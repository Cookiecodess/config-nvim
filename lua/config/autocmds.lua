-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- autosave on normal mode
vim.api.nvim_create_autocmd({ "TextChanged", "InsertLeave", "FocusLost", "BufLeave" }, {
  pattern = "*",
  callback = function()
    if vim.bo.modifiable and vim.bo.filetype ~= "help" then
      vim.cmd("silent! update") -- saves if the buffer is modified
    end
  end,
})
