-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- set Space as leader key
vim.g.mapleader = " "

vim.keymap.set("n", "<M-w>", "<C-w>")
-- use <leader> instead of <C-w> as the prefix for switching buffers
vim.keymap.set("n", "<leader>h", "<C-w>h")
vim.keymap.set("n", "<leader>j", "<C-w>j")
vim.keymap.set("n", "<leader>k", "<C-w>k")
vim.keymap.set("n", "<leader>l", "<C-w>l")

vim.keymap.set({ "i", "c" }, "<C-h>", "<C-w>")
-- the below is buggy if the line were, for example, '123|45 12345'
-- where '|' is the cursor and doing <C-Del> would result in '1231|2345'.
-- vim.keymap.set("i", "<C-Del>", "<Esc>ldwa")

-- keymap for a rename feature provided by the plugin `smjonas/inc-rename.nvim`.
vim.keymap.set("n", "<leader>rn", ":IncRename ")

-- By default lazyvim maps <C-/> to opening the terminal at a new horizontally split window
--   We map <C-`> (the vscode way) to that.
--   this also frees up <C-/> so we can map it to comment/uncommenting!
--   But! when we hit <C-`>, most term emulators actually send <C-Space>.
--   you can verify this in vim by typing <C-V> then typing <C-`>.
-- Some obstacles & unsolved mysteries with the attempts to map <C-`> to something else:
--   - running ``:map <C-`>`` in vim cmdline shows that lazyvim defaults
--     maps <C-`> to something called "Incremental Select".
--   - but even after disabling that (running ``:map <C-`>`` again
--     verified that it's been disabled), hitting <C-`> (which, as a reminder,
--     sends <C-space> to nvim. that's just most term emulators' behavior)
--     opens an autocompletion chooser at the cursor. as of writing this,
--     i'm still not sure where exactly this keymap came from. `:map`
--     couldn't identify its origin.
-- After some consideration, i decided to NOT map <C-/> to comment/uncommenting
--   and instead just use the `gcc` command provided by the `mini.comment` plugin.
--   that's because the command supports motions too. like `gc2j` to comment current line AND the two lines below.
--   i guess it's not rly worth it to move a bunch of stuff around when i think the
--   default commands should already make sense and follow vim conventions.
--   (`gcc` being for commenting current line (double-c) and `gcj` being comment
--   current line AND one line below, just like `dj` being delete current line AND
--   one line below.)
--   maybe i'll come up with a comprehensive remapping of <C-/> that also supports motions like
--   motions and other vim conventions.
-- local rhs = vim.fn.maparg("<c-/>", "n")
-- print(vim.fn.maparg("<C-/>", "n"))
-- vim.keymap.set({ "n", "t" }, "<C-space>", rhs)
