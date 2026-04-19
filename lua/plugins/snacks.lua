return {
  {
    "snacks.nvim",
    opts = {
      explorer = {
        follow_file = false,
      },
      -- -- Override the reveal function to prevent cwd changes
      -- on_show = function(picker)
      --   -- Lock the cwd to the initial directory  
      --   picker._locked_cwd = picker:cwd()
      -- end,  
      -- -- Prevent cwd changes on file operations
      -- transform = function(picker, item)
      --   if picker._locked_cwd and item.file then
      --     -- Only show items within the locked directory
      --     if not item.file:find("^" .. picker._locked_cwd, 1, true) then
      --       return nil
      --     end
      --   end
      --   return item
      -- end,
      dashboard = {
        preset = {
          header = [[
                                       ██             
▄▄  ▄▄ ▄▄▄     ▄▄▄▄    ▄▄▄   ▄▄▄▄ ▄▄▄ ▄▄▄  ▄▄ ▄▄ ▄▄   
▀▀   ██  ██  ▄█▄▄▄██ ▄█  ▀█▄  ▀█▄  █   ██   ██ ██ ██  
     ██  ██  ██      ██   ██   ▀█▄█    ██   ██ ██ ██  
██  ▄██▄ ██▄  ▀█▄▄▄▀  ▀█▄▄█▀    ▀█    ▄██▄ ▄██ ██ ██▄ 
]],
        },
      },
    },
  },
}
