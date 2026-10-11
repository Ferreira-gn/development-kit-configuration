local M = {}

local TITLE = "Git Workflow"
local GH_HOST = "github.com"

local function notify(message, level)
  vim.notify(message, level or vim.log.levels.INFO, {
    title = TITLE,
  })
end

local function command_exists(command)
  return vim.fn.executable(command) == 1
end

local function ensure_command(command, hint)
  if command_exists(command) then
    return true
  end

  local message = ("O comando `%s` não está instalado."):format(command)

  if hint and hint ~= "" then
    message = message .. "\n" .. hint
  end

  notify(message, vim.log.levels.ERROR)
  return false
end

local function ensure_snacks()
  if _G.Snacks and Snacks.terminal then
    return true
  end

  notify(
    "Snacks.terminal não está disponível. Verifique a configuração do LazyVim.",
    vim.log.levels.ERROR
  )

  return false
end

local function repo_root()
  local buffer_name = vim.api.nvim_buf_get_name(0)

  local start = buffer_name ~= ""
      and vim.fs.dirname(buffer_name)
    or vim.uv.cwd()

  return vim.fs.root(start, ".git")
end

local function ensure_repo()
  local root = repo_root()

  if root then
    return root
  end

  notify(
    "O buffer atual não pertence a um repositório Git.",
    vim.log.levels.WARN
  )

  return nil
end

local function terminal(command, cwd)
  if not ensure_snacks() then
    return
  end

  Snacks.terminal.toggle(command, {
    cwd = cwd,
  })
end

local function run_async(command, options, callback)
  options = options or {}

  vim.system(command, {
    cwd = options.cwd,
    text = true,
  }, function(result)
    vim.schedule(function()
      callback(result)
    end)
  end)
end

local function result_details(result)
  local stderr = vim.trim(result.stderr or "")
  local stdout = vim.trim(result.stdout or "")

  if stderr ~= "" then
    return stderr
  end

  if stdout ~= "" then
    return stdout
  end

  return "Nenhum detalhe adicional foi retornado."
end

local function offer_github_login(cwd)
  vim.ui.select({
    "Autenticar agora",
    "Cancelar",
  }, {
    prompt = "Deseja autenticar o GitHub CLI?",
  }, function(choice)
    if choice ~= "Autenticar agora" then
      return
    end

    terminal({
      "gh",
      "auth",
      "login",
      "--hostname",
      GH_HOST,
    }, cwd)
  end)
end

local function handle_auth_failure(cwd, result)
  notify(
    table.concat({
      "O GitHub CLI não está autenticado ou possui credenciais inválidas.",
      "",
      "Execute `gh auth login` para continuar.",
      "",
      result_details(result),
    }, "\n"),
    vim.log.levels.ERROR
  )

  offer_github_login(cwd)
end

---@param cwd string
---@param callback fun()
local function with_github_auth(cwd, callback)
  if not ensure_command(
    "gh",
    "Adicione o GitHub CLI ao seu módulo Home Manager."
  ) then
    return
  end

  -- Não use --json aqui. O modo JSON pode retornar código zero mesmo
  -- quando existem problemas de autenticação.
  run_async({
    "gh",
    "auth",
    "status",
    "--active",
    "--hostname",
    GH_HOST,
  }, {
    cwd = cwd,
  }, function(result)
    if result.code == 0 then
      callback()
      return
    end

    handle_auth_failure(cwd, result)
  end)
end

---@param cwd string
---@param callback fun(repository: string)
local function with_github_repository(cwd, callback)
  with_github_auth(cwd, function()
    run_async({
      "gh",
      "repo",
      "view",
      "--json",
      "nameWithOwner",
      "--jq",
      ".nameWithOwner",
    }, {
      cwd = cwd,
    }, function(result)
      if result.code == 4 then
        handle_auth_failure(cwd, result)
        return
      end

      local repository = vim.trim(result.stdout or "")

      if result.code == 0 and repository ~= "" then
        callback(repository)
        return
      end

      notify(
        table.concat({
          "Não foi possível identificar um repositório GitHub.",
          "",
          "Verifique se:",
          "• o repositório possui um remote hospedado no GitHub;",
          "• a conta autenticada possui acesso ao repositório;",
          "• a conexão com o GitHub está disponível;",
          "• o remote não está apontando para outro forge.",
          "",
          result_details(result),
        }, "\n"),
        vim.log.levels.ERROR
      )
    end)
  end)
end

local function gh_dash_command()
  -- O pacote do nixpkgs disponibiliza o binário gh-dash.
  if command_exists("gh-dash") then
    return { "gh-dash" }
  end

  -- Fallback para uma instalação feita como extensão do gh.
  return { "gh", "dash" }
end

local function validate_pr(cwd, number, callback)
  run_async({
    "gh",
    "pr",
    "view",
    number,
    "--json",
    "number",
    "--jq",
    ".number",
  }, {
    cwd = cwd,
  }, function(result)
    if result.code == 4 then
      handle_auth_failure(cwd, result)
      return
    end

    local resolved_number = vim.trim(result.stdout or "")

    if result.code == 0 and resolved_number:match("^%d+$") then
      callback(resolved_number)
      return
    end

    notify(
      table.concat({
        ("Não foi possível acessar a pull request #%s."):format(number),
        "",
        "Ela pode não existir, pertencer a outro repositório ou estar",
        "inacessível para a conta atualmente autenticada.",
        "",
        result_details(result),
      }, "\n"),
      vim.log.levels.ERROR
    )
  end)
end

function M.github_dashboard()
  local cwd = ensure_repo()

  if not cwd then
    return
  end

  with_github_repository(cwd, function()
    terminal(gh_dash_command(), cwd)
  end)
end

function M.review_worktree()
  if not ensure_command(
    "tuicr",
    "Adicione o pacote do tuicr ao seu módulo Home Manager."
  ) then
    return
  end

  local cwd = ensure_repo()

  if not cwd then
    return
  end

  -- Uma revisão local não depende de autenticação no GitHub.
  terminal({ "tuicr", "-w" }, cwd)
end

function M.review_current_pr()
  if not ensure_command(
    "tuicr",
    "Adicione o pacote do tuicr ao seu módulo Home Manager."
  ) then
    return
  end

  local cwd = ensure_repo()

  if not cwd then
    return
  end

  with_github_repository(cwd, function()
    run_async({
      "gh",
      "pr",
      "view",
      "--json",
      "number",
      "--jq",
      ".number",
    }, {
      cwd = cwd,
    }, function(result)
      if result.code == 4 then
        handle_auth_failure(cwd, result)
        return
      end

      local number = vim.trim(result.stdout or "")

      if result.code == 0 and number:match("^%d+$") then
        terminal({ "tuicr", "pr", number }, cwd)
        return
      end

      notify(
        table.concat({
          "A branch atual não possui uma pull request acessível.",
          "",
          "Crie uma PR ou use `<leader>gR` para informar o número",
          "de uma PR pertencente ao repositório atual.",
          "",
          result_details(result),
        }, "\n"),
        vim.log.levels.WARN
      )
    end)
  end)
end

function M.review_pr_by_number()
  if not ensure_command(
    "tuicr",
    "Adicione o pacote do tuicr ao seu módulo Home Manager."
  ) then
    return
  end

  local cwd = ensure_repo()

  if not cwd then
    return
  end

  with_github_repository(cwd, function()
    vim.ui.input({
      prompt = "Número da PR: ",
    }, function(value)
      if value == nil then
        return
      end

      local number = vim.trim(value)

      if number == "" then
        notify(
          "Nenhum número de PR foi informado.",
          vim.log.levels.WARN
        )
        return
      end

      if not number:match("^%d+$") then
        notify(
          "O número da PR deve conter apenas dígitos.",
          vim.log.levels.ERROR
        )
        return
      end

      validate_pr(cwd, number, function(resolved_number)
        terminal({ "tuicr", "pr", resolved_number }, cwd)
      end)
    end)
  end)
end

function M.github_login()
  if not ensure_command(
    "gh",
    "Adicione o GitHub CLI ao seu módulo Home Manager."
  ) then
    return
  end

  terminal({
    "gh",
    "auth",
    "login",
    "--hostname",
    GH_HOST,
  }, repo_root() or vim.uv.cwd())
end

function M.github_auth_status()
  if not ensure_command(
    "gh",
    "Adicione o GitHub CLI ao seu módulo Home Manager."
  ) then
    return
  end

  local cwd = repo_root() or vim.uv.cwd()

  run_async({
    "gh",
    "auth",
    "status",
    "--active",
    "--hostname",
    GH_HOST,
  }, {
    cwd = cwd,
  }, function(result)
    if result.code == 0 then
      notify(
        "GitHub CLI autenticado corretamente.",
        vim.log.levels.INFO
      )
      return
    end

    handle_auth_failure(cwd, result)
  end)
end

return M
