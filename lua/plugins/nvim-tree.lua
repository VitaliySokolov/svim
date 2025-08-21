-- return {
--   "nvim-tree/nvim-tree.lua",
--   cmd = { "NvimTreeToggle" },
--   keys = {
--     { "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Explorer" },
--   },
--   opts = {
--     disable_netrw = false,
--     hijack_netrw = true,
--     respect_buf_cwd = true,
--     view = {
--       number = true,
--       relativenumber = true,
--       width = 50,
--     },
--     filters = {
--       custom = { ".git" },
--     },
--     sync_root_with_cwd = true,
--     update_focused_file = {
--       enable = true,
--       update_root = true,
--     },
--     -- actions = {
--     --   open_file = {
--     --     quit_on_open = true,
--     --   },
--     -- },
--   },
-- }
return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  cmd = { "Neotree" },
  keys = {
    { "<leader>e", "<cmd>Neotree toggle<cr>", desc = "Explorer" },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "nvim-tree/nvim-web-devicons", -- optional, but recommended
  },
  lazy = false, -- neo-tree will lazily load itself
}
