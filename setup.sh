# create Neovim's config directory if it doesn't exist,
# then create an init.lua file in it
nvim --headless -c 'exe "write ++p" stdpath("config") . "/init.lua"' -c 'quit'

# print the path of the config file
nvim_config=$(nvim --headless -c 'echo $MYVIMRC' -c 'quit')
if [ -d "$nvim_config" ]; then
	echo "Neovim config directory: $nvim_config"
else
	# nvim_config may contain outputs from init.lua if the nvim --headless ... command if init.lua hasn't been loaded prior to this.
	# running a second time will print only the command output since
	# init.lua should already have been loaded and won't be reloaded.
	echo "Run \`nvim --headless -c 'echo $MYVIMRC' -c 'quit'\` to print full path of Neovim config directory"
fi

# create the directory:
# <NVIM_DATA_DIRECTORY>/site/pack/deps/start/
nvim --headless -c 'call mkdir(stdpath("data") . "/site/pack/deps/start/", "p")' -c 'quit'

# print the path of the newly created directory
minideps_home=$(nvim --headless -c 'echo stdpath("data") . "/site/pack/deps/start/"' -c 'quit')
if [ -d "$minideps_home" ]; then
	echo "mini.nvim repo path: $minideps_home/mini.nvim"
else
	# nvim_config may contain outputs from init.lua if the nvim --headless ... command if init.lua hasn't been loaded prior to this.
	# running a second time will print only the command output since
	# init.lua should already have been loaded and won't be reloaded.
	echo "Run \`nvim --headless -c 'echo stdpath("data") . "/site/pack/deps/start/"' -c 'quit'\` to print full path of the directory where the \`mini.nvim\` repo will be cloned into"
fi

# clone the mini.deps github repository 
cd "$minideps_home" && git clone --filter=blob:none https://github.com/nvim-mini/mini.nvim

# if using neovim v0.9 switch to the last commit that supports v0.9
nvim_ver=$(nvim --version | head -n1 | awk '{print $2}')
if [ "$(printf '%s\n' "$nvim_ver" v0.10.0 | sort -V | head -n1)" != "v0.10.0" ]; then
	echo "Neovim version is v0.9.X or below ($nvim_ver), switching to the last commit that supports v0.9 (commit hash: 3923662bf3d6ca49a9503f8d7196ea0450983e6a)"
  cd "$minideps_home/mini.nvim" && git switch --detach 3923662bf3d6ca49a9503f8d7196ea0450983e6a
fi

# generate help tags (allows opening help pages via `:help <topic>`)
nvim --headless -c 'helptags ALL' -c 'quit'


