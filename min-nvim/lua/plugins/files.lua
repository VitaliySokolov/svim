return {
    {
    'nvim-telescope/telescope.nvim', tag = '0.1.8',
        cmd = 'Telescope',
        dependencies = { 'nvim-lua/plenary.nvim' }
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
    },
    {
      'stevearc/oil.nvim',
      event = "VeryLazy", -- Load the plugin when Neovim starts
      opts = {
        use_default_keymaps = false,
        keymaps = {
          ["g?"] = { "actions.show_help", mode = "n" },
          ["<CR>"] = "actions.select",
          ["<C-s>"] = { "actions.select", opts = { vertical = true } },
          -- ["<C-h>"] = { "actions.select", opts = { horizontal = true } },
          ["<C-t>"] = { "actions.select", opts = { tab = true } },
          ["<C-p>"] = "actions.preview",
          -- ["<C-c>"] = { "actions.close", mode = "n" },
          ["q"] = { "actions.close", mode = "n" },
          -- ["<C-l>"] = "actions.refresh",
          ["gr"] = "actions.refresh",
          ["-"] = { "actions.parent", mode = "n" },
          ["_"] = { "actions.open_cwd", mode = "n" },
          ["`"] = { "actions.cd", mode = "n" },
          ["g~"] = { "actions.cd", opts = { scope = "tab" }, mode = "n" },
          ["gs"] = { "actions.change_sort", mode = "n" },
          ["gx"] = "actions.open_external",
          ["g."] = { "actions.toggle_hidden", mode = "n" },
          ["g\\"] = { "actions.toggle_trash", mode = "n" },
        },
      },
    }
}
