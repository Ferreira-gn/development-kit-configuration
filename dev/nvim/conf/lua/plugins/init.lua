local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "https://github.com/folke/lazy.nvim",
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    { import = "plugins.lsp" },
    { import = "plugins.cmp" },
    { import = "plugins.treesitter" },
    { import = "plugins.telescope" },
    { import = "plugins.git" },
    { import = "plugins.formatting" },
    {
      "stevearc/oil.nvim",
      cmd = "Oil",
      opts = {},
    },
  },
}, {
  lockfile = vim.fn.stdpath("data") .. "/lazy/lazy-lock.json",
})
