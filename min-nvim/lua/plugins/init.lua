return {
    {
    'nvim-telescope/telescope.nvim', tag = '0.1.8',
        cmd = 'Telescope',
        dependencies = { 'nvim-lua/plenary.nvim' }
    },
    {
    "folke/which-key.nvim",
      event = "VeryLazy",
      opts = {},
      keys = {
        {
          "<leader>?",
          function()
            require("which-key").show({ global = false })
          end,
          desc = "Buffer Local Keymaps",
        },
      },
    }
}

