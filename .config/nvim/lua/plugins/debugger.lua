return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
    },
    keys = {
      { "<leader>dd", "<cmd>lua require('dap').continue()<CR>",          noremap = false },
      { "<leader>du", "<cmd>lua require('dapui').toggle()<CR>",          silent = true,  noremap = false },
      { "<leader>db", "<cmd>lua require('dap').toggle_breakpoint()<CR>", noremap = false },
      { "<leader>dc", "<cmd>lua require('dap').run_to_cursor()<CR>",     noremap = false },
      { "<leader>de", "<cmd>lua require('dap').step_out()<CR>",          noremap = false },
      { "<leader>dh", "<cmd>lua require('dap').step_back()<CR>",         noremap = false },
      { "<leader>di", "<cmd>lua require('dap').step_into()<CR>",         noremap = false },
      { "<leader>do", "<cmd>lua require('dap').step_over()<CR>",         noremap = false },
      { "<leader>dr", "<cmd>lua require('dap').repl.toggle()<CR>",       noremap = false },
      { "<leader>ds", "<cmd>lua require('dap').stop()<CR>",              noremap = false },
    },
    config = function()
      require("dapui").setup()
      require("nvim-dap-virtual-text").setup()
    end,
  },
  -- {
  --   "mxsdev/nvim-dap-vscode-js",
  --   dependencies = {
  --     "mfussenegger/nvim-dap",
  --     {
  --       "microsoft/vscode-js-debug",
  --       build = "npm install --legacy-peer-deps && npm run compile",
  --     },
  --   },
  --   config = function()
  --     local dap = require("dap")
  --
  --     require("dap-vscode-js").setup({
  --       debugger_path = vim.fn.stdpath("data") .. "/lazy/vscode-js-debug",
  --       adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" }, -- which adapters to register in nvim-dap
  --     })
  --
  --     for _, language in ipairs({ "typescript", "javascript", "typescriptreact" }) do
  --       dap.configurations[language] = {
  --         {
  --           type = "pwa-node",
  --           request = "launch",
  --           name = "Launch file",
  --           program = "${file}",
  --           cwd = "${workspaceFolder}",
  --         },
  --         {
  --           type = "pwa-node",
  --           request = "attach",
  --           name = "Attach",
  --           processId = require("dap.utils").pick_process,
  --           cwd = "${workspaceFolder}",
  --         },
  --         {
  --           type = "pwa-node",
  --           request = "launch",
  --           name = "Debug Jest Tests",
  --           -- trace = true, -- include debugger info
  --           runtimeExecutable = "node",
  --           runtimeArgs = {
  --             "./node_modules/jest/bin/jest.js",
  --             "--runInBand",
  --           },
  --           rootPath = "${workspaceFolder}",
  --           cwd = "${workspaceFolder}",
  --           console = "integratedTerminal",
  --           internalConsoleOptions = "neverOpen",
  --         },
  --       }
  --     end
  --   end,
  -- }
}
