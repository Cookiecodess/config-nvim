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
