-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

local lspconfig = require("lspconfig")

lspconfig.pylsp.setup{
  settings = {
    pylsp = {
      plugins = {
        pycodestyle = { enabled = false },
        -- optionally disable other style linters if you want:
        -- pyflakes = { enabled = false },
        -- mccabe = { enabled = false },
      },
    },
  },
}

