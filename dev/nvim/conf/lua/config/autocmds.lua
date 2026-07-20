-- Autocmds are automatically loaded on the VeryLazy event
-- Add any additional autocmds here

local augroup = vim.api.nvim_create_augroup("custom_autocmds", { clear = true })

-- Auto save ao sair do Insert
vim.api.nvim_create_autocmd("InsertLeave", {
  group = augroup,
  callback = function()
    if vim.bo.modified and vim.bo.buftype == "" then
      vim.cmd("silent! write")
    end
  end,
})

-- Highlight overrides de Git / Diff / Snacks
vim.api.nvim_create_autocmd("ColorScheme", {
  group = augroup,
  callback = function()
    local hl = vim.api.nvim_set_hl

    local function set_hl(name, opts)
      hl(0, name, opts)
    end

    local colors = {
      add = "#42BE65",
      change = "#F1C21B",
      delete = "#FA4D56",
      untracked = "#78A9FF",
      renamed = "#BE95FF",
    }

    -- GitSigns
    set_hl("GitSignsAdd", { fg = colors.add, bold = true })
    set_hl("GitSignsChange", { fg = colors.change, bold = true })
    set_hl("GitSignsDelete", { fg = colors.delete, bold = true })
    set_hl("GitSignsUntracked", { fg = colors.untracked, bold = true })

    -- Diff
    set_hl("DiffAdd", { fg = colors.add, bold = true })
    set_hl("DiffChange", { fg = colors.change, bold = true })
    set_hl("DiffDelete", { fg = colors.delete, bold = true })

    -- Snacks (LazyVim plugin)
    set_hl("SnacksPickerGitStatusAdded", { fg = colors.add, bold = true })
    set_hl("SnacksPickerGitStatusModified", { fg = colors.change, bold = true })
    set_hl("SnacksPickerGitStatusDeleted", { fg = colors.delete, bold = true })
    set_hl("SnacksPickerGitStatusUntracked", { fg = colors.untracked, bold = true })
    set_hl("SnacksPickerGitStatusRenamed", { fg = colors.renamed, bold = true })
  end,
})
