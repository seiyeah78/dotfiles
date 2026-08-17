-- 状態を管理するローカル変数（初期状態はOFF）
local kulala_jq_truncated = false

return {
  {
    "mistweaverco/kulala.nvim",
    keys = {
      { "<leader>Rs", desc = "Send request" },
      { "<leader>Ra", desc = "Send all requests" },
      { "<leader>Rb", desc = "Open scratchpad" },
      {
        "<leader>RT",
        function()
          -- キーを押した時にフラグだけを反転させる
          kulala_jq_truncated = not kulala_jq_truncated
          if kulala_jq_truncated then
            vim.notify("Kulala: 文字列省略モード (30文字制限)", vim.log.levels.INFO)
          else
            vim.notify("Kulala: 通常表示モード (jq .)", vim.log.levels.INFO)
          end
        end,
        desc = "Toggle JQ string truncation",
      },
    },
    opts = {
      global_keymaps = true,
      global_keymaps_prefix = "<leader>R",
      kulala_keymaps_prefix = "",
      ui = {
        max_response_size = 10485760, -- 10MB
      },
      -- 2. 常時動くフォーマッタとして関数を登録
      contenttypes = {
        ["application/json"] = {
          ft = "json",
          formatter = function(body)
            -- フラグの状態によって、実行するjqコマンドを動的に切り替える
            local jq_query = "."
            if kulala_jq_truncated then
              jq_query = 'walk(if type == "string" and length > 30 then .[0:30] + "..." else . end)'
            end

            -- vim.fn.system を使い、安全にjqにデータを流し込む
            local cmd = { "jq", jq_query }
            local result = vim.fn.system(cmd, body)

            -- エラーがなければパース結果を返し、失敗したら生のボディを返す
            if vim.v.shell_error == 0 then
              return result
            else
              return body
            end
          end,
          pathresolver = function(...)
            return require("kulala.parser.jsonpath").parse(...)
          end,
        },
      },
    }
  },
}
