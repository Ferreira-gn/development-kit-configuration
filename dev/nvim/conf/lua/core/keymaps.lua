local map = vim.keymap.set
vim.g.mapleader = " "

map("n", "<leader>w", ":w<CR>")
map("n", "<leader>q", ":q<CR>")

map("n", "-", "<CMD>Oil<CR>")

map("n", "<leader>ff", ":Telescope find_files<CR>")
map("n", "<leader>fg", ":Telescope live_grep<CR>")

map("n", "gd", vim.lsp.buf.definition)
map("n", "K", vim.lsp.buf.hover)
map("n", "<leader>rn", vim.lsp.buf.rename)

map("n", "[d", vim.diagnostic.goto_prev)
map("n", "]d", vim.diagnostic.goto_next)
