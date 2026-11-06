# cookie's minimal Neovim config

## how to use 

1. run `setup.sh`
2. `setup.sh` should print Neovim's config directory. Copy `init.lua` in there. Or all contents of this repo, if you want. The path of the `init.lua` should be `<NVIM_CONFIG_DIR>/init.lua`.
3. Neovim is ready to use

`init.lua` is heavily commented so give it a read to understand the config.

my config closely follows this awesome guide: https://vonheikemen.github.io/devlog/tools/simple-neovim-config/ ([archived 2026-11-06](https://web.archive.org/web/20261106092003/https://vonheikemen.github.io/devlog/tools/simple-neovim-config/))

## useful DEFAULT neovim keymaps

| keymap | description |
|---------|-------------|
| <C-w> h/j/k/l | Switch focus to other windows (hjkl denotes direction)
| <C-w> c | Close current window |

useful **LSP keymaps** (default for Neovim v0.11) are documented in the `CONFIGURE LANGUAGE SERVERS > LSP KEYMAPS` section in [init.lua](init.lua), but here are some really useful ones:
- `K`: invokes `vim.lsp.buf.hover()` which shows a floating window displaying documentation of the symbol under the cursor, if it exists.
    - pressing `K` a *second* time focuses on the floating window, so you can do Normal-mode stuff on it like scrolling, searching, etc.
    - press `q` to close the floating window.
- `grn`: rename symbol
- `grt`: jump to definition of the type symbol
- `[d`/`]d`: jump to prev/next dianogstic in current buffer
- `<C-w>d`/`<C-w><C-d>`: show dianogstics in a floating window

## useful DEFAULT commands

| command | description |
|---------|-------------|
| :ls / :buffers | list open buffers and their IDs (numbers) |
| :buffer N | switch to a buffer by its ID (a number) |
| :bn / :bnext | switch to next buffer |
| :bp / :bprevious | switch to previous buffer |
| :!<cmd> | run shell command. e.g. `:!ls` lists current working directory. |
| :read !<cmd> | run shell command and insert its output into current buffer. |
| :!<cmd> % | `%` will be substituted with current file name. e.g. `:!cat %` prints content of current file |
