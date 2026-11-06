--
-- OPTIONS
-- 

-- show line numbers
vim.o.number = true
vim.o.relativenumber = true

-- disable line wrapping
-- vim.o.wrap = false

-- how wide does a literal tab character appear?
vim.o.tabstop = 2
-- indentation step used by >> / << commands and automatic indentation
vim.o.shiftwidth = 2

-- ignore case when search pattern is all lowercase
vim.o.smartcase = true
vim.o.ignorecase = true

-- clear search highlights on pressing Enter after typing the search term
vim.o.hlsearch = false

-- reserve a space in the gutter for signs. some plugins use this to show icons
vim.o.signcolumn = 'yes'

--
-- THEME
--

local ok_theme = pcall(vim.cmd.colorscheme, 'retrobox')
if not ok_theme then
  vim.cmd.colorscheme('habamax')
end

-- 
-- KEYMAPS
--

-- notes on vim.keymap.set()
-- args: 
--   a list of vim modes or a string if there's only one mode, e.g. {'n','x'} means normal and visual modes, 'n' means normal mode only
--   the hotkey
--   existing keymap or Ex-command (scroll down for notes on Ex-commands) to bind to
--   metadata object containing attributes like `desc`

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

--
-- PLUGINS
--

-- note: vim.pack is a fully functional plugin manager 
-- built into Neovim, but only if you're using Neovim v0.12 or above.
-- for backwards compatibility with Neovim 0.9.5, use mini.deps
-- vim.pack's design was based on mini.deps so it should be fairly easy to migrate from one to the other

local ok, MiniDeps = pcall(require, 'mini.deps')
-- tip: run `:help pcall` for how pcall works
if not ok then
	vim.notify('[WARN] mini.deps module not found', vim.log.levels.WARN)
	return
end

-- note: all features of `mini.nvim` are opt-in,
--   meaning we have to do something in our config
--   to enable a module.
--   for the `mini.deps` module we have to use a function
--   called `.setup()`
MiniDeps.setup({})

---
--- PLUGINS > LSP config
---

-- install nvim-lspconfig via MiniDeps
MiniDeps.add('neovim/nvim-lspconfig')

-- note: the `.add()` function will make sure the plugin
--   is installed and loaded.

-- note: the vim.pack equivalent of this is 
--   vim.pack.add({'https://github.com/neovim/nvim-lspconfig'})

-- more on MiniDeps.add() and vim.pack.add():
--   if you need to add more info about the plugin you
--   want to download, replace the string arg with a lua table.
--   e.g. if we want to download a previous version of `nvim-lspconfig`, we should do:
--     MiniDeps.add({
--       source = 'neovim/nvim-lspconfig',
--       checkout = 'v1.8.0' 
--     })
--   `checkout` can be a commit hash, tag or branch name.
--   in this example v1.8.0 is a tag on the `nvim-lspconfig`
--   repository. it's the last version that supports 
--   Neovim v0.9.
--
--   for `vim.pack` we do:
--     vim.pack.add({
--       {
--         src = 'https://github.com/neovim/nvim-lspconfig',
--         version = 'v1.8.0'
--       },
--     })
--
--   note that vim.pack.add() can install multiple plugins
--     with a single function call, whereas MiniDeps.add()
--     can only install one plugin at a time.
--
--   official docs for mini.deps:
--     mini.nvim/doc/mini-deps.html

---
--- PLUGINS > file explorer
---

-- Neovim has a built-in file explorer called netrw.
-- we're not gonna use it here cuz it has a few quirks that the 
-- author of the guide im using to write this config doesn't 
-- like. and what do i know, right?
-- mini.nvim provides a file explorer called `mini.files`.
require('mini.files').setup({})

-- it's a CONVENTION that to enable a plugin, you have to 
-- execute a function called `.setup()`, but it's NOT a 
-- hard-and-fast RULE. some plugins execute their setup
-- automatically.

-- a keymap to open the file explorer
vim.keymap.set('n', '<leader>e', '<cmd>lua MiniFiles.open()<cr>', {desc = 'File explorer'})

-- note: after you open the file explorer, you can press
-- `g` then `?` to view the available keymaps. these are set 
-- by the `mini.files` module.
-- to customize these default settings, do this:
require('mini.files').setup({
	mappings = {
		show_help = 'gh',
  },
})
-- these custom settings are in a "lua table". (very important
-- Lua syntax btw, get familiar with it)
-- to know what setings there are, run:
--   :help mini.file

-- if your terminal font doesn't support icons,
-- you can add the `mini.icons` module.
-- or, just install a terminal font that does: Nerd Fonts!
-- require('mini.icons').setup({style = 'ascii'})

-- the below is for when you don't have any plugins installed,
-- in which case you can use the `files` command (same as `buffers` and `ls`) to list open files
-- (emphasis on *open*; unlike mini.files which shows you files
-- in your current directory, `files` only shows you the files you have opened in vim),
-- and use `buffer` to switch to another file,
-- and the below is a nice keymap for that:
--   vim.keymap.set('n', '<leader><space>', '<cmd>files<cr>:buffer ', {desc = 'Switch to a different file'})
-- but since we have mini.files, we don't need it!

---
--- PLUGINS > FILE PICKER/SEARCHER
---

-- for when you wanna search for files/help pages
require('mini.pick').setup({})

vim.keymap.set('n', '<leader><space>', '<cmd>Pick buffers<cr>', {desc = 'Search open files'})
-- 'ff': 'find files'
vim.keymap.set('n', '<leader>ff', '<cmd>Pick files<cr>', {desc = 'Search all files'})
-- 'fh': 'find help page'
vim.keymap.set('n', '<leader>fh', '<cmd>Pick help<cr>', {desc = 'Search help tags'})

---
--- PLUGINS > CODE COMPLETION
---

require('mini.snippets').setup({})
require('mini.completion').setup({})

-- `mini.completion` is kinda a wrapper around Neovim's
-- builtin completion mechanism. Neovim makes you press
-- specific keybindings depending on the type of completion
-- you want to get. And what `mini.completion` does is take 
-- that burden away from you, by triggering the completion
-- automatically as you type.
-- By default you just get suggestions based on words of the 
-- current file, but whenever possible it'll try to use the 
-- LSP client to provide smart code completion.
--
-- Default keybindings for controlling the completion menu:
--   <Down>: select next item on list
--   <Up>:   select prev item on list
--   <C-n>:  select and insert text of next item on list
--   <C-p>:  select and insert text of prev item on list
--   <C-y>:  confirm selected item
--   <C-e>:  cancel completion
--   <Enter>: if item was selected using <Up>/<Down>, it
--            confirms selection. if no item is selected, hides
--            completion menu. Else, inserts a newline char. 

---
--- CONFIGURE LANGUAGE SERVERS
---

-- on Neovim v0.11 you can use the function vim.lsp.enable():
--   vim.lsp.enable('example_server')
--   or
--   vim.lsp.enable({'server1', 'server2'})
-- on Neovim v0.10 or lower, must use the "legacy setup" function
-- of `nvim-lspconfig`:
--   require('lspconfig').example_server.setup({})
-- 
-- actual examples:
-- vim.lsp.enable({'gopls', 'rust_analyzer'})
-- or
-- require('lspconfig').gopls.setup({})
-- require('lspconfig').rust_analyzer.setup({})
--
-- This function will use the "legacy setup" on older Neovim version.
-- The new api is only available on Neovim v0.11 or greater.
local function lsp_setup(server, opts)
  if vim.fn.has('nvim-0.11') == 0 then
    require('lspconfig')[server].setup(opts)
    return
  end

  if not vim.tbl_isempty(opts) then
    vim.lsp.config(server, opts)
  end

  vim.lsp.enable(server)
end

lsp_setup('lua_ls', {
	settings = {
		Lua = {
			-- tells LuaLS which Lua dialect/environment to assume.
			-- "LuaJIT" matches Neovim's Lua runtime.
			runtime = { version = "LuaJIT" },
			workspace = {
				-- tells LuaLS to index Neovim's runtime files
				-- which include its Lua API definitions
				library = { vim.env.VIMRUNTIME },
				-- disable LuaLS's prompts about detecting
				-- third-party libraries
				checkThirdParty = false,
			},
		},
	},
})
--lsp_setup('gopls', {})
--lsp_setup('rust_analyzer', {})

---
--- CONFIGURE LANGUAGE SERVERS > LSP KEYMAPS
---

-- after a language server is active in the current buffer,
-- we can use the functions under the module `vim.lsp.buf`.
-- on Neovim v0.11 we have a handful of keymaps that trigger
-- functions on this module, but on older versions we have to
-- create the keymaps ourselves.

-- NOTE: These keymaps are already part of Neovim v0.11.
-- You do not have to add them to your personal configuration
-- if you are using Neovim v0.11 or greater.

-- -- Displays a function's signature information
-- vim.keymap.set('i', '<C-s>', '<cmd>lua vim.lsp.buf.signature_help()<cr>')
-- 
-- -- Lists all symbols in the current buffer
-- vim.keymap.set('n', 'gO', '<cmd>lua vim.lsp.buf.document_symbol()<cr>')
-- 
-- -- Lists all the implementations for the symbol under the cursor
-- vim.keymap.set('n', 'gri', '<cmd>lua vim.lsp.buf.implementation()<cr>')
-- 
-- -- Jumps to the definition of the type symbol
-- vim.keymap.set('n', 'grt', '<cmd>lua vim.lsp.buf.type_definition()<cr>')
-- 
-- -- Lists all the references
-- vim.keymap.set('n', 'grr', '<cmd>lua vim.lsp.buf.references()<cr>')
-- 
-- -- Renames all references to the symbol under the cursor
-- vim.keymap.set('n', 'grn', '<cmd>lua vim.lsp.buf.rename()<cr>')
-- 
-- -- Selects a code action available at the current cursor position
-- vim.keymap.set('n', 'gra', '<cmd>lua vim.lsp.buf.code_action()<cr>')
-- 
-- -- Show diagnostics in a floating window
-- vim.keymap.set('n', '<C-w>d', '<cmd>lua vim.diagnostic.open_float()<cr>')
-- vim.keymap.set('n', '<C-w><C-d>', '<cmd>lua vim.diagnostic.open_float()<cr>')
-- 
-- -- Jump next/previous diagnostic in the current buffer
-- vim.keymap.set('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>')
-- vim.keymap.set('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>')
-- 
-- vim.api.nvim_create_autocmd('LspAttach', {
--   callback = function(event)
--     -- NOTE: By default `K` uses the program specified in 'keywordprg'
--     -- Here we force it to use the LSP client
-- 
--     -- Display documentation of the symbol under the cursor
--     vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', {buffer = event.buf})
--   end,
-- })
