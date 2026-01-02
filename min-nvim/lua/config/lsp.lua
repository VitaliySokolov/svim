vim.lsp.config["luals"] = {
  -- Command and arguments to start the server.
  cmd = { "lua-language-server" },
  -- Filetypes to automatically attach to.
  filetypes = { "lua" },
  -- Sets the "workspace" to the directory where any of these files is found.
  -- Files that share a root directory will reuse the LSP server connection.
  -- Nested lists indicate equal priority, see |vim.lsp.Config|.
  root_markers = { ".luarc.json", ".luarc.jsonc", ".git" },
  -- Specific settings to send to the server. The schema is server-defined.
  -- Example: https://raw.githubusercontent.com/LuaLS/vscode-lua/master/setting/schema.json
  -- settings = {
  --   Lua = {
  --     runtime = {
  --       version = "LuaJIT",
  --     },
  --   },
  -- },
}

vim.lsp.enable("luals")

vim.lsp.config["clangd"] = {
  cmd = { 'clangd' },
  filetypes = { "c" },
}
vim.lsp.enable("clangd")

vim.lsp.config["rust-analyzer"] = {
  cmd = { 'rust-analyzer' },
  filetypes = { "rust" },
}
vim.lsp.enable("rust-analyzer")

vim.lsp.config["tsserver"] = {
  cmd = { "typescript-language-server", "--stdio" },
  filetypes = {
    "javascript",
    "javascriptreact", -- Handles .jsx and .js with React syntax
    "typescript",
    "typescriptreact", -- Handles .tsx and .ts with React syntax
  },
  root_markers = { "tsconfig.json", "jsconfig.json", "package.json", ".git" },
}
vim.lsp.enable("tsserver")
