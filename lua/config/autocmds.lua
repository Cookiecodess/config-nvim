-- autosave on normal mode
vim.api.nvim_create_autocmd({ "TextChanged", "InsertLeave", "FocusLost", "BufLeave" }, {
  pattern = "*",
  callback = function()
    if vim.bo.modifiable and vim.bo.filetype ~= "help" then
      vim.cmd("silent! update") -- saves if the buffer is modified
    end
  end,
})

--vim.api.nvim_create_autocmd({ 
	

