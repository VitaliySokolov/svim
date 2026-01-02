return {
  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = "InsertEnter",
    opts = {
      suggestion = { enabled = false },
      panel = { enabled = false },
      filetypes = {
        markdown = true,
        help = true,
      },
    },
    config = function()
      require("copilot").setup({})
    end,
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      { "nvim-lua/plenary.nvim", branch = "master" },
    },
    cmd = "CopilotChatOpen",
    build = "make tiktoken",
    opts = {
      -- See Configuration section for options
    },
  },
}
