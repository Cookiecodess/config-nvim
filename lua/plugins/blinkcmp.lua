return {
  {
    "saghen/blink.cmp",
    opts = {
      keymap = {
        -- 'none' disables the default preset
        -- set to 'default' for default preset
        preset = "none",

        ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
        ["<C-e>"] = { "hide", "fallback" },
        ["<C-y>"] = { "select_and_accept", "fallback" },

        ["<Up>"] = { "select_prev", "fallback" },
        ["<Down>"] = { "select_next", "fallback" },
        ["<C-p>"] = { "select_prev", "fallback_to_mappings" },
        ["<C-n>"] = { "select_next", "fallback_to_mappings" },

        ["<C-b>"] = { "scroll_documentation_up", "fallback" },
        ["<C-f>"] = { "scroll_documentation_down", "fallback" },

        ["<Tab>"] = { "snippet_forward", "fallback" },
        ["<S-Tab>"] = { "snippet_backward", "fallback" },

        -- note: default for this (show/hide signature) is <C-k>.
        -- since preset is set to none, no defaults are used.
        -- 'ts' stands for 'toggle signature'
        -- ["<leader>ts"] = { "show_signature", "hide_signature", "fallback" },
        ["<C-k>"] = { "show_signature", "hide_signature", "fallback" },

        ["<C-u>"] = { "scroll_signature_up", "fallback" },
        ["<C-d>"] = { "scroll_signature_down", "fallback" },
      },
    },
  },
}
