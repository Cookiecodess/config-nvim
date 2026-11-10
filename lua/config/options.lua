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

-- disable swap files
vim.o.swapfile = false
