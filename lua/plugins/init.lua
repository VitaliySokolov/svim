return {
  "nvim-lua/plenary.nvim",
  "MunifTanjim/nui.nvim",
  {
    "nvim-tree/nvim-web-devicons",
    config = { default = true },
  },
  { "nacro90/numb.nvim", event = "BufReadPre", config = true },
  {
    "stevearc/dressing.nvim",
    event = "VeryLazy",
    config = true,
  },
  {
    "rcarriga/nvim-notify",
    event = "VeryLazy",
    enabled = true,
    config = { default = true }, -- same as config = true
  },
  {
    "numToStr/Comment.nvim",
    opts = {
      -- add any options here
    },
    lazy = false,
  },
  -- { "tpope/vim-surround", event = "BufReadPre", enabled = false },
  {
    "kylechui/nvim-surround",
    event = "BufReadPre",
    opts = {},
    enabled = false,
  },
}
