return {
  "goolord/alpha-nvim",
  event = "VimEnter",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local dashboard = require("alpha.themes.startify")
    require("alpha").setup(dashboard.config)

    vim.api.nvim_create_autocmd("User", {
      pattern = "LazyVimStarted",
      callback = function()
        local stats = require("lazy").stats()
        local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)

        -- local now = os.date("%d-%m-%Y %H:%M:%S")
        local version = "   v" .. vim.version().major .. "." .. vim.version().minor .. "." .. vim.version().patch
        local plugins = "⚡Neovim loaded " .. stats.count .. " plugins in " .. ms .. "ms"
        local footer = version .. "\t" .. plugins -- .. "\n" .. now
        dashboard.config.layout[9].val = {
          {
            type = "text",
            val = footer,
            opts = { position = "center" },
          },
        }
        pcall(vim.cmd.AlphaRedraw)
      end,
    })
  end,
}
