return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  config = function()
    local wk = require("which-key")
    wk.add({
      { "<leader>c", group = "+Code" },
      { "<leader>cX", group = "Swap Previous" },
      { "<leader>cx", group = "Swap Next" },
      { "<leader>g", group = "+Git" },
      { "<leader>f", group = "+File" },
      { "<leader>h", group = "+Hunk" },
      { "<leader>o", group = "+Org" },
      { "<leader>r", group = "+Re(name,start)" },
      { "<leader>t", group = "+Toggle" },
    })
  end,
}
