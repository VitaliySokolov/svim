local keymap = vim.keymap.set

-- Remap for dealing with word wrap
keymap("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true })
keymap("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true })

-- Better viewing
-- keymap("n", "n", "nzzzv")
-- keymap("n", "N", "Nzzzv")
-- keymap("n", "g,", "g,zvzz")
-- keymap("n", "g;", "g;zvzz")

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
keymap("n", "<C-h>", "<C-w>h") --"Window left" },
keymap("n", "<C-l>", "<C-w>l") --"Window right" },
keymap("n", "<C-j>", "<C-w>j") --"Window down" },
keymap("n", "<C-k>", "<C-w>k") --"Window up" },

-- save
keymap("n", "<C-s>", "<cmd> w <CR>") --"Save file" },

-- Copy all
keymap("n", "<C-c>", "<cmd> %y+ <CR>") --"Copy whole file" },

-- line numbers
keymap("n", "<leader>n", "<cmd> set nu! <CR>") --"Toggle line number" },
keymap("n", "<leader>rn", "<cmd> set rnu! <CR>") --"Toggle relative number" },

-- Allow moving the cursor through wrapped lines with j, k, <Up> and <Down>
-- http://www.reddit.com/r/vim/comments/2k4cbr/problem_with_gj_and_gk/
-- empty mode is same as using <cmd> :map
-- also don't use g[j|k] when in operator pending mode, so it doesn't alter d, y or c behaviour
-- keymap("n", "j", "v:count || mode(1)[0:1] == \"no\" ? \"j\" : \"gj\"") --"Move down", opts = { expr = true } },
-- keymap("n", "k", "v:count || mode(1)[0:1] == \"no\" ? \"k\" : \"gk\"") --"Move up", opts = { expr = true } },
-- keymap("n", "Up", "v:count || mode(1)[0:1] == \"no\" ? \"k\" : \"gk\"") --"Move up", opts = { expr = true } },
-- keymap("n", "Down", "v:count || mode(1)[0:1] == \"no\" ? \"j\" : \"gj\"") --"Move down", opts = { expr = true } },

-- new buffer
keymap("n", "<leader>b", "<cmd> enew <CR>") --"New buffer" },
--nkeymap("n", "<leader>ch", "<cmd> NvCheatsheet <CR>") --"Mapping cheatsheet" },

-- keymap("n", "<leader>fm"] = {
--       function()
--         vim.lsp.buf.format { async = true }
--       end,
--       "LSP formatting",
--     },
--
keymap("n", "<C-x><C-s>", "<cmd> w <CR>")
keymap("i", "<C-x><C-s>", "<cmd> w <CR>")
keymap("n", "<C-x><C-c>", "<cmd> q <CR>")
keymap("n", "<C-x>b", "<cmd>Telescope buffers<cr>")
