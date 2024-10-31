return {
  {
    "sindrets/diffview.nvim",
    cmd = {
      "DiffviewOpen",
      "DiffviewClose",
      "DiffviewToggleFiles",
      "DiffviewFocusFiles",
    },
    config = true,
  },
  {
    "NeogitOrg/neogit",
    cmd = "Neogit",
    config = {
      integrations = { diffview = true },
    },
    keys = {
      -- <cmd>neogit kind=floating<cr>
      { "<leader>gs", "<cmd>Neogit kind=split<cr>", desc = "Status" },
    },
  },
  {
    "lewis6991/gitsigns.nvim",
    cmd = "Gitsigns",
    lazy = true,
    init = function()
      -- load gitsigns only when a git file is opened
      vim.api.nvim_create_autocmd({ "BufRead" }, {
        group = vim.api.nvim_create_augroup(
          "GitSignsLazyLoad",
          { clear = true }
        ),
        callback = function()
          vim.fn.system(
            "git -C " .. '"' .. vim.fn.expand("%:p:h") .. '"' .. " rev-parse"
          )
          if vim.v.shell_error == 0 then
            vim.api.nvim_del_augroup_by_name("GitSignsLazyLoad")
            vim.schedule(function()
              require("lazy").load({ plugins = { "gitsigns.nvim" } })
            end)
          end
        end,
      })
    end,
    config = function()
      local updatetime =
        vim.api.nvim_get_option_value("updatetime", { scope = "global" })

      require("gitsigns").setup({
        -- signs = { add = { text = "│" }, change = { text = "│" } },
        current_line_blame = true,
        current_line_blame_opts = { delay = updatetime },
        sign_priority = 1,
        update_debounce = updatetime,
        preview_config = { border = "rounded", row = 1, col = 0 },
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns

          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end

          -- Navigation
          map("n", "]c", function()
            if vim.wo.diff then
              return "]c"
            end
            vim.schedule(function()
              gs.next_hunk()
            end)
            return "<Ignore>"
          end, { expr = true })

          map("n", "[c", function()
            if vim.wo.diff then
              return "[c"
            end
            vim.schedule(function()
              gs.prev_hunk()
            end)
            return "<Ignore>"
          end, { expr = true })

          -- Actions
          map("n", "<leader>hs", gs.stage_hunk, { desc = "Stage hunk" })
          map("n", "<leader>hr", gs.reset_hunk, { desc = "Reset hunk" })
          map("v", "<leader>hs", function()
            gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
          end, { desc = "Stage hunk" })
          map("v", "<leader>hr", function()
            gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
          end, { desc = "Reset hunk" })
          map("n", "<leader>hS", gs.stage_buffer, { desc = "Stage buffer" })
          map(
            "n",
            "<leader>hu",
            gs.undo_stage_hunk,
            { desc = "Undo stage hunk" }
          )
          map("n", "<leader>hR", gs.reset_buffer, { desc = "Reset buffer" })
          map("n", "<leader>hp", gs.preview_hunk, { desc = "Preview hunk" })
          map("n", "<leader>hb", function()
            gs.blame_line({ full = true })
          end, { desc = "Blame line" })
          map(
            "n",
            "<leader>tb",
            gs.toggle_current_line_blame,
            { desc = "Toggle blame line" }
          )
          map("n", "<leader>hd", gs.diffthis, { desc = "Diff this" })
          map("n", "<leader>hD", function()
            gs.diffthis("~")
          end, { desc = "Diff this ~" })
          map("n", "<leader>td", gs.toggle_deleted, { desc = "Toggle deleted" })

          -- Text object
          map(
            { "o", "x" },
            "ih",
            ":<C-U>Gitsigns select_hunk<CR>",
            { desc = "Select hunk" }
          )

          -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<localleader>hr", "", {
          --   callback = function() require("gitsigns").reset_hunk() end,
          --   desc = "Git: [r]eset the current [h]unk",
          -- })

          -- vim.api.nvim_buf_set_keymap(bufnr, "x", "<localleader>hr", "", {
          --   callback = function()
          --     require("gitsigns").reset_hunk({
          --       vim.api.nvim_call_function("line", { "." }),
          --       vim.api.nvim_call_function("line", { "v" }),
          --     })
          --   end,
          --   desc = "Git: [r]eset the current [h]unk",
          -- })

          -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<localleader>hs", "", {
          --   callback = function() require("gitsigns").stage_hunk() end,
          --   desc = "Git: [s]tage the current [h]unk",
          -- })

          -- vim.api.nvim_buf_set_keymap(bufnr, "x", "<localleader>hs", "", {
          --   callback = function()
          --     require("gitsigns").stage_hunk({
          --       vim.api.nvim_call_function("line", { "." }),
          --       vim.api.nvim_call_function("line", { "v" }),
          --     })
          --   end,
          --   desc = "Git: [s]tage the current [h]unk",
          -- })

          -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<localleader>hp", "", {
          --   callback = function() require("gitsigns").preview_hunk() end,
          --   desc = "Git: [p]review the current [h]unk",
          -- })

          -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<localleader>bp", "", {
          --   callback = function() require("gitsigns").blame_line({ full = true }) end,
          --   desc = "Git: [p]review the current line [b]lame",
          -- })

          -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<localleader>gd", "", {
          --   callback = function() require("gitsigns").diffthis("~") end,
          --   desc = "Git: split [g]it [d]iffs",
          -- })

          -- vim.api.nvim_buf_set_keymap(bufnr, "n", "]h", "", { callback = function() require("gitsigns").next_hunk() end })
          -- vim.api.nvim_buf_set_keymap(bufnr, "n", "[h", "", { callback = function() require("gitsigns").prev_hunk() end })
        end,
      })

      -- if not pcall(require, "scrollbar.handlers.gitsigns") then return end

      -- require("scrollbar.handlers.gitsigns").setup()
    end,
  },
}
