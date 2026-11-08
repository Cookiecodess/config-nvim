-- 
-- KEYMAPS
--

-- notes on vim.keymap.set()
-- args: 
--   a list of vim modes or a string if there's only one mode, e.g. {'n','x'} means normal and visual modes, 'n' means normal mode only
--   the hotkey
--   existing keymap or Ex-command (scroll down for notes on Ex-commands) to bind to
--   metadata object containing attributes like `desc`

-- notes on leader key
-- denoted by <leader>, by default it's `\`, so <leader>h means \ + h.

-- notes on special sequences/characters
-- e.g. Ctrl + k is denoted by <C-k>
-- e.g. vim.g.mapleader = vim.keycode('<C-k>')
-- e.g. vim.g.mapleader = vim.keycode('<space>')
--   (note: the space character can also be denoted by the string ' '.)
vim.g.mapleader = ' '

-- notes on Ex-commands
-- two ways of doing it
-- 1. <cmd>...<cr>
--   <cmd> is a special sequence that tells Neovim
--     you want to execute a vim expression.
--   <cr> represents the Enter key. it marks the end of 
--     the expression you want to execute.
--   e.g. vim.keymap.set('n', '<leader>w', '<cmd>write<cr>', {desc = 'Save file'})
--   e.g. vim.keymap.set('n', '<leader>q', '<cmd>quitall<cr>', {desc = 'Exit vim'})
-- 2. idk the guide i was reading didnt mention this second method

vim.keymap.set({'n', 'x'}, 'gy', '"+y', {desc = 'Copy to clipboard'})
vim.keymap.set({'n', 'x'}, 'gp', '"+p', {desc = 'Paste clipboard text'})

-- Ctrl+Backspace to delete previous word
vim.keymap.set({'n', 'i'}, '<C-h>', '<C-w>', {desc = 'Delete previous word'})

-- Alt+H/L to jump to prev/next cursor locations
-- useful for jumping back after jumping to type definition
vim.keymap.set('n', '<M-h>', '<C-o>', {desc = 'Jump to previous cursor location'})
vim.keymap.set('n', '<M-l>', '<C-i>', {desc = 'Jump to next cursor location'})

-- in windows terminal Ctrl+V pastes.
-- you can only unbind globally but i wanna use it for powershell.
-- so i override <C-v> behavior in nvim.
vim.keymap.set('n', '<C-v>', '<C-q>', {desc = 'Switch to Visual Block mode'})

-- Alt+J/K to scroll page one line up/down without moving the cursor
vim.keymap.set('n', '<M-j>', '<C-e>', {desc = 'Scroll page down one line'})
vim.keymap.set('n', '<M-k>', '<C-y>', {desc = 'Scroll page up one line'})
