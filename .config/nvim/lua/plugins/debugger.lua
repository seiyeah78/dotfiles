return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
      "leoluz/nvim-dap-go",
    },
    keys = {
      { "<leader>dd", "<cmd>lua require('dap').continue()<CR>",          noremap = false },
      { "<leader>du", "<cmd>lua require('dapui').toggle()<CR>",          noremap = false },
      { "<leader>db", "<cmd>lua require('dap').toggle_breakpoint()<CR>", noremap = false },
      { "<leader>dc", "<cmd>lua require('dap').clear_breakpoints()<CR>", noremap = false },
      { "<leader>dR", "<cmd>lua require('dap').run_to_cursor()<CR>",     noremap = false },
      { "<leader>de", "<cmd>lua require('dap').step_out()<CR>",          noremap = false },
      { "<leader>dh", "<cmd>lua require('dap').step_back()<CR>",         noremap = false },
      { "<leader>di", "<cmd>lua require('dap').step_into()<CR>",         noremap = false },
      { "<leader>do", "<cmd>lua require('dap').step_over()<CR>",         noremap = false },
      { "<leader>dh", "<cmd>lua require('dap.ui.widgets').hover()<CR>",  noremap = false, mode = { 'n', 'v' } },
      { "<leader>dp", "<cmd>lua require('dap.ui.widgets').hover()<CR>",  noremap = false, mode = { 'n', 'v' } },
    },
    config = function()
      local dap, dapui, widgets = require("dap"), require("dapui"), require("dap.ui.widgets")
      require("dapui").setup()
      require("nvim-dap-virtual-text").setup({
        highlight_new_as_changed = true,
      })
      require('dap-go').setup()
      -- require("dap.ext.vscode").load_launchjs()
      -- Override icons
      local sign = vim.fn.sign_define
      sign("DapBreakpoint", { text = "●", texthl = "DapBreakpoint", linehl = "", numhl = "" })
      sign("DapBreakpointCondition", { text = "●", texthl = "DapBreakpointCondition", linehl = "", numhl = "" })
      sign("DapLogPoint", { text = "◆", texthl = "DapLogPoint", linehl = "", numhl = "" })
      sign('DapStopped', { text = '', texthl = 'DapStopped', linehl = 'DapStopped', numhl = 'DapStopped' })
      sign('DapBreakpointRejected', {
        text = '',
        texthl = 'DapBreakpoint',
        linehl = 'DapBreakpoint',
        numhl =
        'DapBreakpoint'
      })
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "dap-float",
        callback = function()
          vim.api.nvim_buf_set_keymap(0, "n", "q", "<cmd>close!<CR>", { noremap = true, silent = true })
        end
      })
      vim.keymap.set('n', '<Leader>df', function()
        widgets.centered_float(widgets.frames)
      end)
      vim.keymap.set('n', '<Leader>ds', function()
        widgets.centered_float(widgets.scopes)
      end)
      dap.listeners.before.attach.dapui_config = function()
        vim.cmd("NvimTreeClose")
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end
    end,
  },
}
