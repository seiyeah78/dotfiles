return {
  {
    'stevearc/overseer.nvim',
    opts = {
      component_aliases = {
        default = {
          task_components = {
            "display_duration",
            "on_exit_set_status",
            "on_complete_notify",
            "on_complete_dispose",
            { "on_output_summarize", max_lines = 10 },
            { "display_nav" },
            { "open_output",         direction = "vertical" },
            { "on_output_quickfix",  open = true }, -- 自動で開きたくない場合は false
          }
        },
      }
    },
  }
}
