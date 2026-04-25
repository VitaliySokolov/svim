return {
    {
      "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {
          spec = {
            {"<leader>f", group = "File"},
            {"<leader>g", group = "Git"},
            {"<leader>gh", group = "Hunk"},
            {"<leader>ght", group = "Toogle"},
            {"<leader>o", group = "Org"},
            {"<leader>od", group = "Dailies"},
            {"<leader>odw", group = "Working Dailies"},
            {"<leader>t", group = "Test"},
            {"<leader>d", group = "Diagnostic"},
            {"<leader>b", group = "Buffers"},
            {"<leader>l", group = "Line number"},
          }
        },
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
}
