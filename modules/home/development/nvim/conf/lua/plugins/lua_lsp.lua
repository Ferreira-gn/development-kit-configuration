local severity = vim.diagnostic.severity

---Abre um recurso LSP pelo Telescope.
---Caso o Telescope não esteja instalado, utiliza a função nativa do Neovim.
---@param action string
---@param fallback function
---@return function
local function lsp_picker(action, fallback)
  return function()
    local has_builtin, builtin = pcall(require, "telescope.builtin")
    local has_themes, themes = pcall(require, "telescope.themes")
    local picker = has_builtin and builtin["lsp_" .. action] or nil

    if picker then
      local options = has_themes and themes.get_ivy() or {}
      picker(options)
      return
    end

    fallback()
  end
end

---Navega entre diagnósticos de erro.
---@param count integer
---@return function
local function jump_error(count)
  return function()
    vim.diagnostic.jump({
      severity = severity.ERROR,
      count = count,
    })

    vim.cmd("normal! zz")
  end
end

return {
  {
    "neovim/nvim-lspconfig",

    -- O módulo lsp_autocommands não faz parte do LazyVim.
    -- Esta proteção evita que o Neovim quebre caso ele não exista.
    init = function()
      local ok, lsp_autocommands = pcall(require, "lsp_autocommands")

      if ok then
        lsp_autocommands.setup()
      end
    end,

    opts = function(_, opts)
      opts.servers = opts.servers or {}

      ------------------------------------------------------------------------
      -- Configuração global
      ------------------------------------------------------------------------

      local global = opts.servers["*"] or {}

      local base_capabilities = vim.tbl_deep_extend("force", {}, global.capabilities or {}, {
        workspace = {
          didChangeWatchedFiles = {
            dynamicRegistration = true,
            relativePatternSupport = true,
          },
        },
      })

      global.capabilities = require("blink.cmp").get_lsp_capabilities(base_capabilities, true)

      local custom_keys = {
        {
          "gd",
          lsp_picker("definitions", vim.lsp.buf.definition),
          desc = "Ir para definição",
          has = "definition",
        },
        {
          "grr",
          lsp_picker("references", vim.lsp.buf.references),
          desc = "Listar referências",
          has = "references",
        },
        {
          "gO",
          lsp_picker("document_symbols", vim.lsp.buf.document_symbol),
          desc = "Símbolos do documento",
          has = "documentSymbol",
        },
        {
          "gri",
          lsp_picker("implementations", vim.lsp.buf.implementation),
          desc = "Listar implementações",
          has = "implementation",
        },
        {
          "gD",
          vim.lsp.buf.declaration,
          desc = "Ir para declaração",
          has = "declaration",
        },
        {
          "K",
          vim.lsp.buf.hover,
          desc = "Documentação do símbolo",
        },
        {
          "<leader>D",
          lsp_picker("type_definitions", vim.lsp.buf.type_definition),
          desc = "Ir para definição do tipo",
          has = "typeDefinition",
        },
        {
          "grl",
          vim.lsp.codelens.run,
          desc = "Executar CodeLens",
          has = "codeLens",
        },
        {
          "gl",
          vim.diagnostic.open_float,
          desc = "Mostrar diagnóstico",
        },
        {
          "[d",
          jump_error(-1),
          desc = "Erro anterior",
        },
        {
          "]d",
          jump_error(1),
          desc = "Próximo erro",
        },
        {
          "<leader>v",
          function()
            vim.cmd("vsplit")
            vim.lsp.buf.definition()
          end,
          desc = "Definição em divisão vertical",
          has = "definition",
        },
      }

      -- Remove os atalhos padrões que serão substituídos.
      local overridden_keys = {}

      for _, key in ipairs(custom_keys) do
        overridden_keys[key[1]] = true
      end

      global.keys = vim.tbl_filter(function(key)
        return not overridden_keys[key[1]]
      end, global.keys or {})

      vim.list_extend(global.keys, custom_keys)

      opts.servers["*"] = global

      ------------------------------------------------------------------------
      -- Helper para preservar configurações adicionadas pelos extras
      ------------------------------------------------------------------------

      ---@param name string
      ---@param config table?
      local function server(name, config)
        opts.servers[name] = vim.tbl_deep_extend("force", opts.servers[name] or {}, config or {})
      end

      ------------------------------------------------------------------------
      -- Go
      ------------------------------------------------------------------------

      server("gopls", {
        settings = {
          gopls = {
            buildFlags = { "-tags=integration" },
            gofumpt = true,

            codelenses = {
              gc_details = true,
              generate = true,
              run_govulncheck = true,
              test = true,
              tidy = true,
              upgrade_dependency = true,
            },

            hints = {
              assignVariableTypes = true,
              compositeLiteralFields = true,
              compositeLiteralTypes = true,
              constantValues = true,
              functionTypeParameters = true,
              parameterNames = true,
              rangeVariableTypes = true,
            },

            analyses = {
              nilness = true,
              unusedparams = true,
              unusedvariable = true,
              unusedwrite = true,
              useany = true,
            },

            staticcheck = true,
            directoryFilters = {
              "-.git",
              "-node_modules",
            },
            semanticTokens = true,
          },
        },

        flags = {
          debounce_text_changes = 150,
        },
      })

      ------------------------------------------------------------------------
      -- TypeScript e JavaScript
      ------------------------------------------------------------------------

      -- Evita dois servidores TypeScript conectados ao mesmo buffer.
      server("vtsls", {
        enabled = false,
      })

      server("tsgo", {
        enabled = false,
      })

      server("tsserver", {
        enabled = false,
      })

      server("ts_ls", {
        enabled = true,

        settings = {
          javascript = {
            inlayHints = {
              includeInlayEnumMemberValueHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayFunctionParameterTypeHints = true,
              includeInlayParameterNameHints = "all",
              includeInlayParameterNameHintsWhenArgumentMatchesName = true,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayVariableTypeHints = true,
            },
          },

          typescript = {
            inlayHints = {
              includeInlayEnumMemberValueHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayFunctionParameterTypeHints = true,
              includeInlayParameterNameHints = "all",
              includeInlayParameterNameHintsWhenArgumentMatchesName = true,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayVariableTypeHints = true,
            },
          },
        },
      })

      ------------------------------------------------------------------------
      -- Rust
      ------------------------------------------------------------------------

      server("rust_analyzer", {
        cmd = {
          "rustup",
          "run",
          "stable",
          "rust-analyzer",
        },
      })

      ------------------------------------------------------------------------
      -- Servidores sem configurações adicionais
      ------------------------------------------------------------------------

      for _, name in ipairs({
        "bashls",
        "clangd",
        "cssls",
        "jsonls",
        "lemminx",
        "taplo",
        "templ",
        "terraformls",
        "tflint",
        "zls",
      }) do
        server(name)
      end

      ------------------------------------------------------------------------
      -- HTML e HTMX
      ------------------------------------------------------------------------

      for _, name in ipairs({
        "html",
        "htmx",
      }) do
        server(name, {
          filetypes = {
            "html",
            "templ",
          },
        })
      end

      ------------------------------------------------------------------------
      -- Tailwind CSS
      ------------------------------------------------------------------------

      server("tailwindcss", {
        filetypes = {
          "html",
          "templ",
          "css",
          "scss",
          "javascript",
          "javascriptreact",
          "typescript",
          "typescriptreact",
        },

        settings = {
          tailwindCSS = {
            includeLanguages = {
              templ = "html",
            },
          },
        },
      })

      ------------------------------------------------------------------------
      -- YAML
      ------------------------------------------------------------------------

      local previous_yaml_on_attach = opts.servers.yamlls and opts.servers.yamlls.on_attach

      server("yamlls", {
        on_attach = function(client, bufnr)
          if previous_yaml_on_attach then
            previous_yaml_on_attach(client, bufnr)
          end

          -- O YAML LSP fica responsável pelos diagnósticos e schemas,
          -- enquanto outro formatter pode cuidar da formatação.
          client.server_capabilities.documentFormattingProvider = false
          client.server_capabilities.documentRangeFormattingProvider = false
        end,

        settings = {
          yaml = {
            schemaStore = {
              url = "https://www.schemastore.org/api/json/catalog.json",
              enable = true,
            },
          },
        },
      })

      ----------------------------------------------------------------------------
      -- Java e Spring
      ----------------------------------------------------------------------------

      server("jdtls", {
        settings = {
          java = {
            signatureHelp = {
              enabled = true,
            },

            eclipse = {
              downloadSources = true,
            },

            maven = {
              downloadSources = true,
            },

            configuration = {
              updateBuildConfiguration = "interactive",
            },

            inlayHints = {
              parameterNames = {
                enabled = "all",
              },
            },

            implementationsCodeLens = {
              enabled = true,
            },

            referencesCodeLens = {
              enabled = true,
            },

            completion = {
              favoriteStaticMembers = {
                "org.junit.jupiter.api.Assertions.*",
                "org.junit.jupiter.api.Assumptions.*",
                "org.junit.jupiter.api.DynamicContainer.*",
                "org.junit.jupiter.api.DynamicTest.*",
                "org.mockito.Mockito.*",
                "org.mockito.ArgumentMatchers.*",
                "org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*",
                "org.springframework.test.web.servlet.result.MockMvcResultMatchers.*",
              },

              filteredTypes = {
                "com.sun.*",
                "io.micrometer.shaded.*",
                "java.awt.*",
                "jdk.*",
                "sun.*",
              },
            },

            sources = {
              organizeImports = {
                starThreshold = 9999,
                staticStarThreshold = 9999,
              },
            },
          },
        },
      })

      ----------------------------------------------------------------------------
      -- Python
      ----------------------------------------------------------------------------

      -- Desabilita implementações concorrentes.
      server("pylsp", {
        enabled = false,
      })

      server("pyright", {
        enabled = false,
      })

      server("ruff_lsp", {
        enabled = false,
      })

      server("basedpyright", {
        settings = {
          basedpyright = {
            disableTaggedHints = false,

            analysis = {
              autoImportCompletions = true,
              autoSearchPaths = true,
              diagnosticMode = "openFilesOnly",

              inlayHints = {
                variableTypes = true,
                callArgumentNames = true,
                functionReturnTypes = true,
                genericTypes = true,
              },
            },
          },
        },
      })

      server("ruff", {
        cmd_env = {
          RUFF_TRACE = "messages",
        },

        init_options = {
          settings = {
            logLevel = "error",
          },
        },

        on_attach = function(client)
          -- BasedPyright fica responsável pelo hover e informações de tipos.
          client.server_capabilities.hoverProvider = false
        end,
      })

      ------------------------------------------------------------------------
      -- Lua
      ------------------------------------------------------------------------

      server("lua_ls", {
        settings = {
          Lua = {
            completion = {
              callSnippet = "Replace",
            },

            diagnostics = {
              globals = {
                "hl",
              },
            },

            telemetry = {
              enable = false,
            },

            hint = {
              enable = true,
            },

            workspace = {
              checkThirdParty = false,

              library = {
                -- APIs internas do Neovim.
                vim.env.VIMRUNTIME,

                -- Tipagens utilizadas na sua configuração do Hyprland.
                vim.fn.expand("~/.local/share/hypr/stubs"),
              },
            },
          },
        },
      })
    end,
  },

  {
    "mfussenegger/nvim-jdtls",
    optional = true,

    opts = function(_, opts)
      opts.settings = vim.tbl_deep_extend("force", opts.settings or {}, {
        java = {
          signatureHelp = {
            enabled = true,
          },

          eclipse = {
            downloadSources = true,
          },

          maven = {
            downloadSources = true,
          },

          configuration = {
            updateBuildConfiguration = "interactive",
          },

          inlayHints = {
            parameterNames = {
              enabled = "all",
            },
          },

          implementationsCodeLens = {
            enabled = true,
          },

          referencesCodeLens = {
            enabled = true,
          },

          completion = {
            favoriteStaticMembers = {
              "org.junit.jupiter.api.Assertions.*",
              "org.junit.jupiter.api.Assumptions.*",
              "org.mockito.Mockito.*",
              "org.mockito.ArgumentMatchers.*",
              "org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*",
              "org.springframework.test.web.servlet.result.MockMvcResultMatchers.*",
            },
          },
        },
      })
    end,
  },
}
