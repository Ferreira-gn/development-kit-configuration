return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = "BufRead",
    opts = {
      ensure_installed = {
        "lua",
        "javascript",
        "typescript",
        "go",
        "java",
        "html",
        "css",
        "dockerfile",
        "nix",
      },
      highlight = { enable = true },
    },
  },
}
