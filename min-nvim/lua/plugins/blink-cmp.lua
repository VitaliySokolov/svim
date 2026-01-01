-- local has_words_before = function()
--   local col = vim.api.nvim_win_get_cursor(0)[2]
--   if col == 0 then
--     return false
--   end
--   local line = vim.api.nvim_get_current_line()
--   return line:sub(col, col):match("%s") == nil
-- end

return {
  'saghen/blink.cmp',
  -- Optional: provides icons for the completion menu
  dependencies = {
    'rafamadriz/friendly-snippets',
    -- 'fang2hou/blink-copilot',
  },
  event = "VeryLazy", -- Load the plugin when Neovim starts
  -- Use a release tag to ensure stability
  version = '1.*',

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    -- 'default' for mappings similar to built-in Neovim
    -- 'super-tab' for mappings similar to vscode (tab to accept, cycle, etc.)
    -- 'enter' for mappings similar to 'super-tab' but with 'Enter' to accept
    keymap = {
      preset = 'none',
      -- If completion hasn't been triggered yet, insert the first suggestion; if it has, cycle to the next suggestion.
      -- ['<Tab>'] = {
      --   function(cmp)
      --     if has_words_before() then
      --       return cmp.insert_next()
      --     end
      --   end,
      --   'fallback',
      -- },
      -- ['<S-Tab>'] = { 'insert_prev' },
      ['<Tab>'] = { 'accept', 'fallback' },
      ['<S-Tab>'] = { 'hide', 'fallback' },
      ['<C-e>'] = { 'hide', 'fallback' },
      ['<CR>'] = { 'accept', 'fallback' },
      ['<C-p>'] = { 'select_prev', 'fallback_to_mappings' },
      ['<C-n>'] = { 'select_next', 'fallback_to_mappings' },

      ['<Up>'] = { 'select_prev', 'fallback' },
      ['<Down>'] = { 'select_next', 'fallback' },

      ['<C-b>'] = { 'scroll_documentation_up', 'fallback' }, -- should be another key
      ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },

      -- ['<C-k>'] = { 'show_signature', 'hide_signature', 'fallback' },
    },

    appearance = {
      -- Sets the fallback highlight groups to nvim-cmp's highlight groups
      -- Useful for themes that don't support blink.cmp yet
      use_nvim_cmp_as_default = true,
      -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      -- Adjusts spacing to ensure icons are aligned
      nerd_font_variant = 'mono'
    },

    -- Default list of enabled providers defined so that you can extend it
    -- elsewhere in your config, without redefining it entirely.
    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },

      providers = {
          snippets = {
            opts = {
              friendly_snippets = true, -- default
            }
          }
        }
    },

    -- Blink.cmp uses a fast rust-based fuzzy matcher by default
    completion = {
      -- Show documentation directly next to the completion menu
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 500,
        window = { border = 'single' }
      },

      -- Displays a preview of the selected item directly in the editor
      ghost_text = { enabled = true },
      menu = { border = 'single' },
    },

    -- Experimental signature help support
    signature = { enabled = true, window = { border = 'single' } }
  },
  opts_extend = { "sources.default" }
}
