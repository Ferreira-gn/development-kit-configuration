return {
  {
    "neovim/nvim-lspconfig",
    event = "BufReadPre",
    config = function()
      local lsp = require("lspconfig")

      lsp.ts_ls.setup({})
      lsp.gopls.setup({})
      lsp.lua_ls.setup({})
      lsp.html.setup({})
      lsp.cssls.setup({})
      lsp.dockerls.setup({})
      lsp.nil_ls.setup({})

      -- Java (pesado, ok para seu caso)
      lsp.jdtls.setup({})
    end,
  },
}
