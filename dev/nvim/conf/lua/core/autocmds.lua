vim.api.nvim_create_autocmd("InsertLeave", {
  callback = function()
    if vim.bo.modified then
      vim.cmd("silent write")
    end
  end,
})

