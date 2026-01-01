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
    },
    {
      "alexghergh/nvim-tmux-navigation",
      event = "VeryLazy", -- Load the plugin when Neovim starts
      config = function()
        require'nvim-tmux-navigation'.setup {
            disable_when_zoomed = true, -- defaults to false
            keybindings = {
                left = "<C-h>",
                down = "<C-j>",
                up = "<C-k>",
                right = "<C-l>",
                last_active = "<C-\\>",
                next = "<C-Space>",
            }
        }
      end,
    },
    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        config = true
        -- use opts = {} for passing setup options
        -- this is equivalent to setup({}) function
    }
}
