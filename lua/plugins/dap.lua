return {
  "mfussenegger/nvim-dap",
  dependencies = {
    {
      "jay-babu/mason-nvim-dap.nvim",
      dependencies = { "nvim-dap" },
      cmd = { "DapInstall", "DapUninstall" },
      opts = { handlers = {} },
    },
    {
      "rcarriga/nvim-dap-ui",
      dependencies = { "nvim-neotest/nvim-nio" },
      config = function()
        require("dapui").setup()
      end,
    },
    { "jbyuki/one-small-step-for-vimkind" },
  },
  config = function()
    local dap = require("dap")
    dap.configurations.lua = {
      {
        type = "nlua",
        request = "attach",
        name = "Attach to running Neovim instance",
      },
    }
    -- local dapui =  require('dapui')
    -- dap.listeners.after.event_initialized["dapui_config"] = function()
    --   dapui.open()
    -- end
    -- dap.listeners.before.event_terminated["dapui_config"] = function()
    --   dapui.close()
    -- end
    -- dap.listeners.before.event_exited["dapui_config"] = function()
    --   dapui.close()
    -- end
    dap.adapters.nlua = function(callback, config)
      callback({
        type = "server",
        host = config.host or "127.0.0.1",
        port = config.port or 8086,
        log = true,
      })
    end
  end,
}
