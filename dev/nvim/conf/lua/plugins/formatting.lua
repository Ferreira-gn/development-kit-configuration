return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    opts = {
      formatters_by_ft = {
        javascript = { "prettierd" },
        typescript = { "prettierd" },
        html = { "prettierd" },
        css = { "prettierd" },
        go = { "gofmt" },
      },
    },
  },
}
