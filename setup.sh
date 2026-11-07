#!/bin/sh
set -eu

die() {
    printf '[ERROR] %s\n' "$*" >&2
    exit 1
}

need() {
    command -v "$1" >/dev/null 2>&1 || die "Required command not found: $1"
}

need nvim
need git
need sed
need mkdir
need mv

# Query stdpath with user config disabled, so its output stays clean.
if ! nvim_config_dir=$(
    nvim --headless --clean \
        -c 'lua print(vim.fn.stdpath("config"))' \
        -c 'qa!'
); then
    die "Could not get Neovim's config directory"
fi
[ -n "$nvim_config_dir" ] || die "Neovim returned an empty config directory"

backup_dir=${nvim_config_dir}.bkp

if [ -d "$nvim_config_dir" ]; then
    if [ -e "$backup_dir" ] || [ -L "$backup_dir" ]; then
        die "A Neovim config directory exists, but cannot back up because another backup already exists: $backup_dir"
    fi

    printf '[INFO] Existing Neovim config directory found: %s\n' "$nvim_config_dir"
    printf '[INFO] Renaming it to: %s\n' "$backup_dir"
    if ! mv "$nvim_config_dir" "$backup_dir"; then
        die "Could not back up Neovim config directory"
    fi
    printf '[INFO] Existing config backed up as: %s\n' "$backup_dir"
elif [ -e "$nvim_config_dir" ] || [ -L "$nvim_config_dir" ]; then
    die "Neovim config path exists but is not a directory: $nvim_config_dir"
else
    printf '[INFO] No existing Neovim config directory found\n'
fi

if ! mkdir -p "$nvim_config_dir"; then
    die "Could not create Neovim config directory: $nvim_config_dir"
fi

init_lua=$nvim_config_dir/init.lua

if [ -e "$init_lua" ] || [ -L "$init_lua" ]; then
    if [ -f "$init_lua" ]; then
        printf '[INFO] Keeping existing init.lua: %s\n' "$init_lua"
    else
        die "init.lua exists but is not a regular file: $init_lua"
    fi
else
    # noclobber prevents overwriting a file created between the check and redirect.
    if (set -C; : > "$init_lua") 2>/dev/null; then
        printf '[INFO] Created init.lua: %s\n' "$init_lua"
    else
        die "Could not create: $init_lua"
    fi
fi

if ! nvim_data_dir=$(
    nvim --headless --clean \
        -c 'lua print(vim.fn.stdpath("data"))' \
        -c 'qa!'
); then
    die "Could not get Neovim's data directory"
fi
[ -n "$nvim_data_dir" ] || die "Neovim returned an empty data directory"

minideps_home=$nvim_data_dir/site/pack/deps/start
mini_repo=$minideps_home/mini.nvim

if ! mkdir -p "$minideps_home"; then
    die "Could not create mini.deps directory: $minideps_home"
fi

if [ -d "$mini_repo" ]; then
    if ! git -C "$mini_repo" rev-parse --is-inside-work-tree >/dev/null 2>&1; then
        die "Directory exists but is not a Git repository: $mini_repo"
    fi
    printf '[INFO] mini.nvim repository already exists; skipping clone\n'
else
    printf '[INFO] Cloning mini.nvim into %s\n' "$mini_repo"
    if ! git clone --filter=blob:none \
        https://github.com/nvim-mini/mini.nvim "$mini_repo"; then
        die "Failed to clone mini.nvim"
    fi
fi

if ! nvim_version_output=$(nvim --version); then
    die "Could not get Neovim version"
fi

version_pair=$(
    printf '%s\n' "$nvim_version_output" |
        sed -n '1s/^NVIM v\([0-9][0-9]*\)\.\([0-9][0-9]*\).*/\1 \2/p'
)
[ -n "$version_pair" ] || die "Could not parse Neovim version"

# The parsed value contains only two numbers, so splitting it is safe here.
set -- $version_pair
major=$1
minor=$2

if [ "$major" -eq 0 ] && [ "$minor" -lt 10 ]; then
    old_nvim_commit=3923662bf3d6ca49a9503f8d7196ea0450983e6a
    printf '[INFO] Neovim is older than 0.10; checking out last mini.nvim commit that supported Neovim v0.9'
		printf '[INFO] The commit hash is: %s\n' "$old_nvim_commit"
    if ! git -C "$mini_repo" switch --detach "$old_nvim_commit"; then
        die "Neovim is older than 0.10 but could not check out mini.nvim compatibility commit"
    fi
fi

printf '[INFO] Generating mini.nvim help tags\n'
if ! MINI_DOC="$mini_repo/doc" nvim --headless --clean \
    -c 'lua vim.cmd("helptags " .. vim.fn.fnameescape(vim.env.MINI_DOC))' \
    -c 'qa!'; then
    die "Failed to generate mini.nvim help tags"
fi

printf '[INFO] Done. mini.nvim is at: %s\n' "$mini_repo"

