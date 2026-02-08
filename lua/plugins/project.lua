-- required for automatically cd into the project directory. 
-- This is important because when nvim with the socket listener is launched, 
-- we need it to automatically cd into our Unity project directory 
-- with .sln & .csproj at the root.
return {
  {
    "ahmedkhalf/project.nvim",
    lazy = false,
    config = function()
      require("project_nvim").setup {}
    end,
  }
}
