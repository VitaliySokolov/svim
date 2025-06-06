return {
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    version = false, -- Never set this value to "*"! Never!
    opts = {
      -- add any opts here
      -- for example
      provider = "ollama",
      debug = true,
      -- behaviour = {
      --   --- ... existing behaviours
      --   enable_cursor_planning_mode = true, -- enable cursor planning mode!
      -- },
      ollama = {
        -- behaviour = {
        --   --- ... existing behaviours
        --   enable_cursor_planning_mode = true, -- enable cursor planning mode!
        -- },
        endpoint = "http://192.168.0.105:11434",
        model = "gemma3:4b", -- your desired model (or use gpt-4o, etc.) timeout = 30000, -- Timeout in milliseconds, increase this for reasoning models
        -- model = "qwen3:14b", -- your desired model (or use gpt-4o, etc.) timeout = 30000, -- Timeout in milliseconds, increase this for reasoning models
        -- temperature = 0,
        -- max_completion_tokens = 8192, -- Increase this to include reasoning tokens (for reasoning models)
        --reasoning_effort = "medium", -- low|medium|high, only used for reasoning models
      },
      -- prompt_opts = {
      --   system_prompt = "Act as a helpfull assistent.",
      -- },
    },
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = "make",
    -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below dependencies are optional,
      -- "echasnovski/mini.pick", -- for file_selector provider mini.pick
      -- "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
      -- "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
      -- "ibhagwan/fzf-lua", -- for file_selector provider fzf
      -- "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
      -- "zbirenbaum/copilot.lua", -- for providers='copilot'
      -- {
      --   -- support for image pasting
      --   "HakonHarnes/img-clip.nvim",
      --   event = "VeryLazy",
      --   opts = {
      --     -- recommended settings
      --     default = {
      --       embed_image_as_base64 = false,
      --       prompt_for_file_name = false,
      --       drag_and_drop = {
      --         insert_mode = true,
      --       },
      --       -- required for Windows users
      --       use_absolute_path = true,
      --     },
      --   },
      -- },
      -- {
      --   -- Make sure to set this up properly if you have lazy=true
      --   "MeanderingProgrammer/render-markdown.nvim",
      --   opts = {
      --     file_types = { "markdown", "Avante" },
      --   },
      --   ft = { "markdown", "Avante" },
      -- },
    },
  },
  -- {
  --   "milanglacier/minuet-ai.nvim",
  --   -- lazy = false,
  --   -- Explain this
  --   event = "VeryLazy",
  --   config = function()
  --     require("minuet").setup({
  --       -- Your configuration options here
  --       virtualtext = {
  --         auto_trigger_ft = {},
  --         keymap = {
  --           -- accept whole completion
  --           accept = "<A-A>",
  --           -- accept one line
  --           accept_line = "<A-a>",
  --           -- accept n lines (prompts for number)
  --           -- e.g. "A-z 2 CR" will accept 2 lines
  --           accept_n_lines = "<A-z>",
  --           -- Cycle to prev completion item, or manually invoke completion
  --           prev = "<A-[>",
  --           -- Cycle to next completion item, or manually invoke completion
  --           next = "<A-]>",
  --           dismiss = "<A-e>",
  --         },
  --       },
  --       provider = "openai_fim_compatible",
  --       n_completions = 1, -- recommend for local model for resource saving
  --       -- I recommend beginning with a small context window size and incrementally
  --       -- expanding it, depending on your local computing power. A context window
  --       -- of 512, serves as an good starting point to estimate your computing
  --       -- power. Once you have a reliable estimate of your local computing power,
  --       -- you should adjust the context window to a larger value.
  --       context_window = 512,
  --       provider_options = {
  --         openai_fim_compatible = {
  --           -- For Windows users, TERM may not be present in environment variables.
  --           -- Consider using APPDATA instead.
  --           api_key = "TERM",
  --           name = "Ollama",
  --           end_point = "http://localhost:11434/v1/completions",
  --           model = "phi4-mini:latest",
  --           optional = {
  --             max_tokens = 56,
  --             top_p = 0.9,
  --           },
  --         },
  --       },
  --     })
  --   end,
  -- },
  -- { "nvim-lua/plenary.nvim" },
  -- optional, if you are using virtual-text frontend, nvim-cmp is not
  -- required.
  -- { "hrsh7th/nvim-cmp" },
  -- optional, if you are using virtual-text frontend, blink is not required.
  -- { "Saghen/blink.cmp" },
}
