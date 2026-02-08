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

-- treat the file extensions listed in `pattern`
-- as zip files, so we can view their contents in vim
-- see `:h zip-extension` for the guide on creating
-- an autocmd for this purpose in .vimrc 
-- Since i'm using lazyvim, this is the lazyvim equivalent
-- of the code that the documentation suggested I use.
-- For more information about vim's zip capabilities,
-- see `:h zip`
vim.api.nvim_create_autocmd("BufRead", {
  pattern = {"*.jar", "*.xpi"},
  callback = function()
    vim.cmd("call zip#Browse(expand('<amatch>'))")
  end,
})
