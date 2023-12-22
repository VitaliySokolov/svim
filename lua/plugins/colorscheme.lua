return {
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    lazy = false,
    config = function()
      local gruvbox = require("gruvbox")
      gruvbox.setup()
      -- vim.o.background = "dark" -- or "light" for light mode
      vim.cmd([[colorscheme gruvbox]])
      -- gruvbox.load()
    end,
  },
}
