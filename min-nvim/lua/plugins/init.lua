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
    },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        event = "VeryLazy",
        config = function()
          require("lualine").setup({
            options = { theme="onedark" }
          })
        end,
    },
    {
      "nvim-neo-tree/neo-tree.nvim",
      branch = "v3.x",
      cmd = { "Neotree" },
      keys = {
        { "<leader>e", "<cmd>Neotree reveal toggle<cr>", desc = "Explorer" },
      },
      dependencies = {
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
        "nvim-tree/nvim-web-devicons", -- optional, but recommended
      },
      opts = {
        filesystem = {
          filtered_items = {
            hide_dotfiles = false,
            hide_gitignored = true,
            hide_hidden = true,      -- This shows files hidden by the OS (Windows/macOS)
          },
        },
      },
      lazy = false, -- neo-tree will lazily load itself
    }
}
