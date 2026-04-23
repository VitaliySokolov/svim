local keymap = vim.keymap.set

-- Remap for dealing with word wrap
keymap("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true })
keymap("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true })

-- Better viewing
keymap("n", "n", "nzzzv")
keymap("n", "N", "Nzzzv")
keymap("n", "g,", "g,zvzz")
keymap("n", "g;", "g;zvzz")

-- Better escape using jk in insert and terminal mode
keymap("i", "jk", "<ESC>")
keymap("t", "jk", "<C-\\><C-n>")
keymap("t", "<C-h>", "<C-\\><C-n><C-w>h")
keymap("t", "<C-j>", "<C-\\><C-n><C-w>j")
keymap("t", "<C-k>", "<C-\\><C-n><C-w>k")
keymap("t", "<C-l>", "<C-\\><C-n><C-w>l")

-- Add undo break-points
keymap("i", ",", ",<c-g>u")
keymap("i", ".", ".<c-g>u")
keymap("i", ";", ";<c-g>u")

-- Better indent
keymap("v", "<", "<gv")
keymap("v", ">", ">gv")

-- Paste over currently selected text without yanking it
keymap("v", "p", '"_dP')

-- Move Lines
keymap("n", "<A-j>", ":m .+1<CR>==")
keymap("v", "<A-j>", ":m '>+1<CR>gv=gv")
keymap("i", "<A-j>", "<Esc>:m .+1<CR>==gi")
keymap("n", "<A-k>", ":m .-2<CR>==")
keymap("v", "<A-k>", ":m '<-2<CR>gv=gv")
keymap("i", "<A-k>", "<Esc>:m .-2<CR>==gi")

-- Resize window using <shift> arrow keys
keymap("n", "<S-Up>", "<cmd>resize +2<CR>")
keymap("n", "<S-Down>", "<cmd>resize -2<CR>")
keymap("n", "<S-Left>", "<cmd>vertical resize -2<CR>")
keymap("n", "<S-Right>", "<cmd>vertical resize +2<CR>")

-- from NvChad
-- go to  beginning and end
keymap("i", "<C-a>", "<ESC>^i") --, "Beginning of line")
keymap("i", "<C-e>", "<End>") --, "End of line")

-- navigate within insert mode
keymap("i", "<C-h>", "<Left>") --, "Move left")
keymap("i", "<C-l>", "<Right>") --, "Move right")
keymap("i", "<C-j>", "<Down>") --, "Move down")
keymap("i", "<C-k>", "<Up>") --, "Move up")

-- keymap("n", "<Esc>", "<cmd> noh <CR>") --"Clear highlights" }, ???
-- switch between windows
-- keymap("n", "<C-h>", "<C-w>h") --"Window left" },
-- keymap("n", "<C-l>", "<C-w>l") --"Window right" },
-- keymap("n", "<C-j>", "<C-w>j") --"Window down" },
-- keymap("n", "<C-k>", "<C-w>k") --"Window up" },

-- save
keymap("n", "<C-s>", "<cmd> w <CR>") --"Save file" },

-- Copy all
keymap("n", "<C-c>", "<cmd> %y+ <CR>") --"Copy whole file" },

-- line numbers
keymap("n", "<leader>ln", "<cmd> set nu! <CR>", { desc = "Toggle line number" })
keymap("n", "<leader>lr", "<cmd> set rnu! <CR>", { desc = "Toggle relative number" })

-- Allow moving the cursor through wrapped lines with j, k, <Up> and <Down>
-- http://www.reddit.com/r/vim/comments/2k4cbr/problem_with_gj_and_gk/
-- empty mode is same as using <cmd> :map
-- also don't use g[j|k] when in operator pending mode, so it doesn't alter d, y or c behaviour
-- keymap("n", "j", "v:count || mode(1)[0:1] == \"no\" ? \"j\" : \"gj\"") --"Move down", opts = { expr = true } },
-- keymap("n", "k", "v:count || mode(1)[0:1] == \"no\" ? \"k\" : \"gk\"") --"Move up", opts = { expr = true } },
-- keymap("n", "Up", "v:count || mode(1)[0:1] == \"no\" ? \"k\" : \"gk\"") --"Move up", opts = { expr = true } },
-- keymap("n", "Down", "v:count || mode(1)[0:1] == \"no\" ? \"j\" : \"gj\"") --"Move down", opts = { expr = true } },

-- new buffer
-- keymap("n", "<leader>b", "<cmd>ls<CR>:b<Space>") --"New buffer" },
--nkeymap("n", "<leader>ch", "<cmd> NvCheatsheet <CR>") --"Mapping cheatsheet" },

-- keymap("n", "<leader>fm"] = {
--       function()
--         vim.lsp.buf.format { async = true }
--       end,
--       "LSP formatting",
--     },
--
keymap("n", "<C-x><C-s>", "<cmd> w <CR>", { desc = "Save" })
keymap("i", "<C-x><C-s>", "<cmd> w <CR>", { desc = "Save" })
keymap("n", "<C-x><C-c>", "<cmd> q <CR>", { desc = "Quit" })

-- debugging
keymap(
  "n",
  "<F8>",
  [[:lua require"dap".toggle_breakpoint()<CR>]],
  { noremap = true }
)
keymap("n", "<F9>", [[:lua require"dap".continue()<CR>]], { noremap = true })
keymap("n", "<F10>", [[:lua require"dap".step_over()<CR>]], { noremap = true })
keymap(
  "n",
  "<S-F10>",
  [[:lua require"dap".step_into()<CR>]],
  { noremap = true }
)
keymap(
  "n",
  "<F12>",
  [[:lua require"dap.ui.widgets".hover()<CR>]],
  { noremap = true }
)
keymap(
  "n",
  "<F5>",
  [[:lua require"osv".launch({port = 8086})<CR>]],
  { noremap = true }
)

-- :call nvim_create_user_command()
vim.api.nvim_create_user_command(
  "OsvStop",
  [[:lua require"osv".stop()<CR>]],
  { desc = "Stop Lua debugger" }
)

-- telescope
keymap(
  'n',
  '<leader>ff',
  "<cmd>lua require'telescope.builtin'.find_files({ find_command = {'rg', '--files', '--hidden', '-g', '!.git' }})<CR>",
  { desc = 'Telescope find files' })
keymap(
  'n',
  '<leader><leader>',
  "<cmd>lua require'telescope.builtin'.find_files({ find_command = {'rg', '--files', '--hidden', '-g', '!.git' }})<CR>",
  { desc = 'Telescope find files' })
keymap('n', '<leader>gs', "<cmd>Telescope git_status <CR>", { desc = 'Telescope git status' })
keymap('n', '<leader>gf', "<cmd>Telescope git_files <CR>", { desc = 'Telescope git files' })
keymap('n', '<leader>gb', "<cmd>Telescope git_branches <CR>", { desc = 'Telescope git branches' })
keymap('n', '<leader>gc', "<cmd>Telescope git_commits <CR>", { desc = 'Telescope git commits' })
keymap('n', '<leader>gz', "<cmd>Telescope git_stash <CR>", { desc = 'Telescope git stash' })
keymap('n', '<leader>bb', "<cmd>Telescope buffers <CR>", { desc = 'Telescope buffers' })
keymap('n', '<C-x>b', "<cmd>Telescope buffers <CR>", { desc = 'Switch to buffers' })
keymap('n', '<leader>f/', "<cmd>Telescope live_grep <CR>", { desc = 'Telescope live grep' })
keymap('n', '<leader>/', "<cmd>Telescope current_buffer_fuzzy_find <CR>", { desc = 'Telescope byffer fzf' })
keymap('n', '<leader>fm', "<cmd>Telescope marks <CR>", { desc = 'Telescope marks' })
keymap('n', '<leader>fj', "<cmd>Telescope jumplist <CR>", { desc = 'Telescope jumplist' })
keymap('n', '<leader>fk', "<cmd>Telescope keymaps <CR>", { desc = 'Telescope keymaps' })

keymap('n', '<leader>fP',
  function()
    require("telescope.builtin").find_files({
      cwd = require("lazy.core.config").options.root -- Uses the root dir configured in lazy.nvim options
    })
  end,
  { desc = 'Find Plugin File' })

keymap('n', '<leader>fC',
  function()
    require("telescope.builtin").find_files({
      cwd = vim.fn.stdpath('config')
    })
  end,
  { desc = 'Find Config File' })
keymap('n', '<leader>fo', "<cmd>Oil<CR>", { desc = 'Oil' })

function vim.getVisualSelection()
  local current_clipboard_content = vim.fn.getreg('"')

  vim.cmd('noau normal! "vy"')
  local text = vim.fn.getreg('v')
  vim.fn.setreg('v', {})

  vim.fn.setreg('"', current_clipboard_content)

  text = string.gsub(text, "\n", "")
  if #text > 0 then
    return text
  else
    return ''
  end
end

keymap('v', '<leader>f/', function()
  local text = vim.getVisualSelection()
  require("telescope.builtin").live_grep({ default_text = text })
end, { desc = 'Telescope live grep (Visual)' })

-- diagnostics
keymap('n', '<leader>dd', vim.diagnostic.open_float)

-- test
keymap('n', '<leader>tt', "<cmd>TestNearest<CR>")
-- keymap('n', '<leader>tT', "<cmd>TestFile<CR>")
-- keymap('n', '<leader>ta', "<cmd>TestSuite<CR>")
-- keymap('n', '<leader>tl', "<cmd>TestLast<CR>")
-- keymap('n', '<leader>tg', "<cmd>TestVisit<CR>")

-- obsidian
keymap('n', '<leader>od.', "<cmd>ObsidianToday<CR>", {desc="Open today's note"})
keymap('n', '<leader>ody', "<cmd>ObsidianToday -1<CR>", {desc="Open yesterday's note"})
keymap('n', '<leader>odt', "<cmd>ObsidianToday +1<CR>", {desc="Open tomorrow's note"})
keymap('n', '<leader>odd', "<cmd>ObsidianDailies<CR>", {desc="Week dailies"})
keymap('n', '<leader>odwy', "<cmd>ObsidianYesterday<CR>", {desc="Open/create prevoius working day"})
keymap('n', '<leader>odwt', "<cmd>ObsidianTomorrow<CR>", {desc="Open/create next working day"})
keymap('n', '<leader>o/', "<cmd>ObsidianSearch<CR>", {desc="Search"})
