local gitsign_on_attach = function(bufnr)
  local gitsigns = require("gitsigns")

  local function map(mode, l, r, opts)
    opts = opts or {}
    opts.buffer = bufnr
    vim.keymap.set(mode, l, r, opts)
  end

  -- Navigation
  map("n", "]c", function()
    if vim.wo.diff then
      vim.cmd.normal({ "]c", bang = true })
    else
      gitsigns.nav_hunk("next", { target="all" })
    end
  end, { desc = "next hunk" })

  map("n", "[c", function()
    if vim.wo.diff then
      vim.cmd.normal({ "[c", bang = true })
    else
      gitsigns.nav_hunk("prev")
    end
  end, { desc = "prev hunk" })

  -- Actions
  map("n", "<leader>ghs", gitsigns.stage_hunk, { desc = "stage" })
  map("n", "<leader>ghr", gitsigns.reset_hunk, { desc = "reset" })

  map("v", "<leader>ghs", function()
    gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
  end, { desc = "stage" })

  map("v", "<leader>ghr", function()
    gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
  end, { desc = "reset" })

  map("n", "<leader>ghS", gitsigns.stage_buffer, { desc = "stage buffer" })
  map("n", "<leader>ghR", gitsigns.reset_buffer, { desc = "reset buffer" })
  map("n", "<leader>ghp", gitsigns.preview_hunk, { desc = "preview hunk" })
  map("n", "<leader>ghi", gitsigns.preview_hunk_inline, { desc = "preview hunk inline" })

  map("n", "<leader>ghb", function()
    gitsigns.blame_line({ full = true })
  end, { desc = "blame line" })

  map("n", "<leader>ghd", gitsigns.diffthis, { desc = "show diff" })

  map("n", "<leader>ghD", function()
    gitsigns.diffthis("~")
  end, { desc = "show HEAD diff"})

  map("n", "<leader>ghQ", function()
    gitsigns.setqflist("all")
  end, { desc = "list of all changes" })
  map("n", "<leader>ghq", gitsigns.setqflist, { desc = "list of buffer changes" })

  -- Toggles
  map("n", "<leader>ghtb", gitsigns.toggle_current_line_blame, { desc = "Toggle current line blame" })
  map("n", "<leader>ghtw", gitsigns.toggle_word_diff, { desc = "Toggle highlighting word diffs" })

  -- Text object
  -- map({ "o", "x" }, "ih", gitsigns.select_hunk)
end

return {
  {
    "lewis6991/gitsigns.nvim",
    cmd = "Gitsigns",
    config = function()
      -- local updatetime = vim.api.nvim_get_option_value("updatetime", { scope = "global" })
        require("gitsigns").setup({
          signs_staged_enable = true,
          signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
          numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
          linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
          word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`

          current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
          current_line_blame_opts = {
            virt_text = true,
            virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
            delay = 1000,
            ignore_whitespace = false,
            virt_text_priority = 100,
            use_focus = true,
          },
          current_line_blame_formatter = "    <author>, <author_time:%R> - <summary>",
          on_attach = gitsign_on_attach
        })
    end,
    lazy = false,
  }
}
