return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        lua_ls = {
          settings = {
            Lua = {
              diagnostics = {
                globals = { "hl" },
              },
              workspace = {
                library = {
                  vim.fn.expand("~/.local/share/hypr/stubs"),
                },
              },
            },
          },
        },
      },
    },
  },
}