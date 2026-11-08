require('config.options')

--
-- THEME
--

-- local ok_theme = pcall(vim.cmd.colorscheme, 'retrobox')
-- if not ok_theme then
--   vim.cmd.colorscheme('habamax')
-- end

require('config.keymaps')

require('plugins')
