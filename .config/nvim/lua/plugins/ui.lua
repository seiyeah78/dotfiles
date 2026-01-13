return {
  {
    "nvim-tree/nvim-tree.lua",
    cmd = {
      "NvimTreeFindFile",
      "NvimTreeToggle",
    },
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      { "<leader><S-n>f",     "<cmd>NvimTreeFindFile<CR>", desc = "NvimTreeFindFile" },
      { "<leader><S-n><S-n>", "<cmd>NvimTreeToggle<CR>",   desc = "NvimTreeToggle" },
    },
    config = function()
      require("nvim-tree").setup({
        hijack_netrw = false,
        sync_root_with_cwd = true,
        update_focused_file = {
          enable = false,
          update_root = true,
        },
        actions = {
          open_file = {
            window_picker = {
              enable = false,
            },
          },
        },
        on_attach = function(bufnr)
          local api = require("nvim-tree.api")
          local function opts(desc)
            return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
          end
          -- default mappings
          api.config.mappings.default_on_attach(bufnr)
          -- custom mappings
          vim.keymap.set("n", "<C-s>", api.node.open.horizontal, opts("Open: Horizontal Split"))
        end,
      })
    end,
  },
  {
    "nvim-tree/nvim-web-devicons",
    opts = {
      override_by_extension = {
        ["tsx"] = vim.tbl_deep_extend(
          "force",
          {},
          require("nvim-web-devicons").get_icons()["tsx"],
          { color = "#7198d9" }
        ),
      },
    },
  },
  {
    "stevearc/oil.nvim",
    cmd = "Oil",
    opts = {
      keymaps = {
        ["g?"] = "actions.show_help",
        ["<CR>"] = "actions.select",
        ["<C-g>"] = "actions.select_vsplit",
        ["<C-s>"] = "actions.select_split",
        ["<C-t>"] = "actions.select_tab",
        ["<C-c>"] = "actions.close",
        ["<C-l>"] = "actions.refresh",
        ["-"] = "actions.parent",
        ["_"] = "actions.open_cwd",
        ["C-]"] = "actions.cd",
        ["~"] = "actions.tcd",
        ["gp"] = "actions.preview",
        ["gs"] = "actions.change_sort",
        ["gx"] = "actions.open_external",
        ["g."] = "actions.toggle_hidden",
        ["g\\"] = "actions.toggle_trash",
      },
      use_default_keymaps = false,
    },
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
  {
    "cappyzawa/trim.nvim",
    event = "BufEnter",
    opts = {
      ft_blocklist = {
        "diff",
        "git",
        "gitcommit",
        "unite",
        "qf",
        "help",
        "markdown",
        "fugitive",
        "fugitiveblame",
        "nerdtree",
        "NvimTree",
      },
      trim_last_line = true,
    },
  },
  {
    "keaising/im-select.nvim",
    evnet = "VeryLazy",
    config = function()
      if vim.fn.has("mac") == 1 then
        require("im_select").setup({
          -- IM will be set to `default_im_select` in `normal` mode(`EnterVim` or `InsertLeave`)
          -- For Windows/WSL, default: "1033", aka: English US Keyboard
          -- For macOS, default: "com.apple.keylayout.ABC", aka: US
          -- You can use `im-select` in cli to get the IM's name you preferred
          default_im_select = "com.google.inputmethod.Japanese.Roman",
          -- Set to 1 if you don't want restore IM status when `InsertEnter`
          set_previous_events = { "InsertEnter" },
        })
      end
    end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufEnter",
    config = function()
      require("ibl").setup({
        scope = {
          enabled = true,
          show_start = false, -- Optional: hides the start line highlighting completely
          show_end = false,   -- Optional: hides the end line highlighting completely
        },
        viewport_buffer = { min = 10, max = 100 },
      })
    end,
  },
  {
    "folke/trouble.nvim",
    cmd = { "Trouble" },
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {},
    -- opts = {
    --   open_split = { "<c-s>" },
    --   open_tab = { "<c-g>" },
    -- },
  },
  {
    "m-demare/hlargs.nvim",
    event = "VeryLazy",
    config = function()
      require("hlargs").setup({
        color = "#ef9062",
        use_colorpalette = false,
        sequential_colorpalette = false,
        colorpalette = {
          { fg = "#ef9062" },
          { fg = "#35D27F" },
          { fg = "#EB75D6" },
          { fg = "#E5D180" },
          { fg = "#8997F5" },
          { fg = "#D49DA5" },
          { fg = "#7FEC35" },
          { fg = "#F6B223" },
          { fg = "#F67C1B" },
          { fg = "#BBEA87" },
          { fg = "#EEF06D" },
          { fg = "#8FB272" },
        },
        excluded_filetypes = { "lua", "rust", "typescript", "typescriptreact", "javascript", "javascriptreact" },
      })
    end,
  },
  {
    "linrongbin16/lsp-progress.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lsp-progress").setup({
        client_format = function(client_name, spinner, series_messages)
          if #series_messages == 0 then
            return nil
          end
          return {
            name = client_name,
            body = spinner .. " " .. table.concat(series_messages, ", "),
          }
        end,
        format = function(client_messages)
          --- @param name string
          --- @param msg string?
          --- @return string
          local function stringify(name, msg)
            return msg and string.format("%s %s", name, msg) or name
          end

          local sign = "" -- nf-fa-gear \uf013
          local lsp_clients = vim.lsp.get_clients()
          local messages_map = {}
          for _, climsg in ipairs(client_messages) do
            messages_map[climsg.name] = climsg.body
          end

          if #lsp_clients > 0 then
            table.sort(lsp_clients, function(a, b)
              return a.name < b.name
            end)
            local builder = {}
            for _, cli in ipairs(lsp_clients) do
              if type(cli) == "table" and type(cli.name) == "string" and string.len(cli.name) > 0 then
                if messages_map[cli.name] then
                  table.insert(builder, stringify(cli.name, messages_map[cli.name]))
                else
                  table.insert(builder, stringify(cli.name))
                end
              end
            end
            if #builder > 0 then
              return sign .. " " .. table.concat(builder, ", ")
            end
          end
          return ""
        end,
      })
    end,
  },
  {
    "simeji/winresizer",
    keys = {
      { "<C-w>e", ":WinResizerStartResize<CR>" },
    },
    config = function()
      vim.cmd([[
        let g:winresizer_vert_resize = 3
        let g:winresizer_horiz_resize = 2
      ]])
    end,
  },
  {
    "andymass/vim-matchup",
    event = "VeryLazy",
    config = function()
      vim.g.matchup_matchparen_deferred = 1
      vim.g.matchup_matchparen_offscreen = { method = "popup" }
      -- vim.api.nvim_set_hl(0, 'MatchParen', { fg = "lightblue2" })
      -- vim.api.nvim_set_hl(0, 'MatchWord', { fg = "lightblue2" })
      vim.api.nvim_set_hl(0, "MatchWordCur", { underline = true })
      vim.api.nvim_set_hl(0, "MatchParenCur", {}) -- NONEと同じ

      vim.api.nvim_create_augroup("matchup_matchparen_disable_ft", { clear = true })

      -- kulala_uiで勝手に閉じてしまうので無効化
      vim.api.nvim_create_autocmd("FileType", {
        group = "matchup_matchparen_disable_ft",
        pattern = "json.kulala_ui",
        callback = function()
          vim.b.matchup_matchparen_fallback = 0
          vim.b.matchup_matchparen_enabled = 0
        end,
      })
    end,
  },
  {
    "kevinhwang91/nvim-hlslens",
    event = "VeryLazy",
    dependencies = {
      "haya14busa/vim-asterisk",
    },
    config = function()
      local kopts = { noremap = true, silent = true }
      vim.api.nvim_set_keymap("n", "<ESC><ESC>", ":nohl <CR>", {})
      vim.api.nvim_set_keymap(
        "n",
        "n",
        [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]],
        kopts
      )
      vim.api.nvim_set_keymap(
        "n",
        "N",
        [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]],
        kopts
      )
      vim.api.nvim_set_keymap("n", "*", [[<Plug>(asterisk-z*)<Cmd>lua require('hlslens').start()<CR>]], {})
      vim.api.nvim_set_keymap("n", "#", [[<Plug>(asterisk-z#)<Cmd>lua require('hlslens').start()<CR>]], {})
      vim.api.nvim_set_keymap("n", "g*", [[<Plug>(asterisk-gz*)<Cmd>lua require('hlslens').start()<CR>]], {})
      vim.api.nvim_set_keymap("n", "g#", [[<Plug>(asterisk-gz#)<Cmd>lua require('hlslens').start()<CR>]], {})

      vim.api.nvim_set_keymap("x", "*", [[<Plug>(asterisk-z*)<Cmd>lua require('hlslens').start()<CR>]], {})
      vim.api.nvim_set_keymap("x", "#", [[<Plug>(asterisk-z#)<Cmd>lua require('hlslens').start()<CR>]], {})
      vim.api.nvim_set_keymap("x", "g*", [[<Plug>(asterisk-gz*)<Cmd>lua require('hlslens').start()<CR>]], {})
      vim.api.nvim_set_keymap("x", "g#", [[<Plug>(asterisk-gz#)<Cmd>lua require('hlslens').start()<CR>]], {})
    end,
  },
  {
    "chrisgrieser/nvim-origami",
    opts = {
      foldKeymaps = {
        setup = false,
      },
      autoFold = {
        enable = true,
        kinds = { "imports" },
      },
    }, -- needed even when using default config
    -- recommended: disable vim's auto-folding
    init = function()
      vim.o.foldcolumn = "1"
      vim.o.foldlevel = 99 -- Using ufo provider needs a large value, feel free to decrease
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true
      -- vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
    end,
    config = function(_, opts)
      require("origami").setup(opts)
      vim.keymap.set("n", "$", function()
        require("origami").dollar()
      end)
      vim.keymap.set("n", "l", function()
        require("origami").l()
      end)
    end,
  },
  {
    "luukvbaal/statuscol.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local builtin = require("statuscol.builtin")
      -- fold column の見た目を完全に再現する関数
      local function custom_fold_symbol()
        local lnum = vim.v.lnum
        local fold_level = vim.fn.foldlevel(lnum)

        -- fold がない行
        if fold_level == 0 then
          return "  "
        end

        local closed = vim.fn.foldclosed(lnum)

        -- 閉じているfoldの先頭行（foldopen記号の代わり）
        if closed == lnum then
          return " "
        end

        -- foldが開いている場合: 開始行はfoldopen、内部は│でつなぐ
        if closed == -1 then
          -- foldの開始行
          if vim.fn.foldlevel(lnum) > vim.fn.foldlevel(lnum - 1) then
            return " "
          end

          -- fold 内部行（空白で縦線を表示）
          if vim.fn.foldlevel(lnum) > 0 then
            return "  "
          end
        end

        return "  "
      end
      require("statuscol").setup({
        bt_ignore = { "terminal", "nofile", "ddu-ff", "ddu-ff-filter", "gitcommit" },
        ft_ignore = { "oil" },
        relculright = true,
        segments = {
          {
            text = {
              custom_fold_symbol,
              "",
            },
            click = "v:lua.ScFa",
            hl = "FoldColumn",
          },
          { text = { "%s" },                  click = "v:lua.ScSa" },
          { text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" },
        },
      })
    end,
  },
  {
    "petertriho/nvim-scrollbar",
    event = "BufEnter",
    dependencies = { "kevinhwang91/nvim-hlslens" },
    config = function()
      require("scrollbar").setup({
        handle = {
          text = "  ",
          blend = 85,
          highlight = "TermCursor",
        },
        marks = {
          Cursor = { highlight = "TermCursor" },
          Search = { text = { "--", "==" } },
          Error = { text = { "--", "==" } },
          Warn = { text = { "--", "==" } },
          Info = { text = { "--", "==" } },
          Hint = { text = { "--", "==" } },
          Misc = { highlight = "TermCursor", text = { "--", "==" } },
        },
        handlers = {
          cursor = false,
        },
        excluded_filetypes = {
          "TelescopeResults",
          "NvimTree",
          "DressingInput",
          "blink-cmp-menu",
          "blink-cmp-documentation",
          "Avante*",
        },
      })
      require("scrollbar.handlers.search").setup()
    end,
  },
  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy",
    priority = 1000,
    opts = {
      -- 診断メッセージの表示スタイルを選択
      -- 利用可能: "modern", "classic", "minimal", "powerline", "ghost", "simple", "nonerdfont", "amongus"
      preset = "modern",

      -- 診断メッセージの背景を透明にする
      transparent_bg = true,

      -- カーソル行の診断メッセージの背景を透明にする
      transparent_cursorline = true,

      -- 色のハイライトグループをカスタマイズ
      -- Neovimのハイライトグループ名または "#RRGGBB" 形式の16進数カラーを使用
      hi = {
        error = "DiagnosticError", -- エラー診断のハイライト
        warn = "DiagnosticWarn",   -- 警告診断のハイライト
        info = "DiagnosticInfo",   -- 情報診断のハイライト
        hint = "DiagnosticHint",   -- ヒント診断のハイライト
        arrow = "NonText",         -- 診断を指す矢印のハイライト
        background = "CursorLine", -- 診断の背景ハイライト
        mixing_color = "None",     -- 背景とブレンドする色 (または "None")
      },

      -- プラグインを無効にするファイルタイプのリスト
      disabled_ft = {},

      options = {
        -- 診断のソースを表示 (例: "lua_ls", "pyright")
        show_source = {
          enabled = true,  -- ソース名の表示を有効化
          if_many = false, -- 同じ診断に複数のソースが存在する場合のみソースを表示
        },

        -- プリセットアイコンの代わりにvim.diagnostic.configのアイコンを使用
        use_icons_from_diagnostic = false,

        -- 矢印の色を最初の診断の深刻度に合わせる
        set_arrow_to_diag_color = false,

        -- パフォーマンス向上のため更新頻度をミリ秒単位で調整
        -- 値が大きいほどCPU使用率は下がるが、応答性が低下する可能性がある
        -- 0に設定すると即座に更新される (低速システムでは遅延が発生する可能性がある)
        throttle = 20,

        -- 長いメッセージを折り返す前の最小文字数
        softwrap = 30,

        -- 診断メッセージの表示方法を制御
        -- 注意: display_count = true を使用する場合、multilines.enabled = true で複数行診断を有効にする必要があります
        --       常に表示したい場合は、multilines.always_show = true も設定できます
        add_messages = {
          messages = true,             -- 完全な診断メッセージを表示
          display_count = true,        -- カーソルが行にない場合、メッセージの代わりに診断数を表示
          use_max_severity = false,    -- カウント時、最も深刻な診断のみを表示
          show_multiple_glyphs = true, -- 同じ深刻度の複数の診断に対して複数のアイコンを表示
        },

        -- 複数行診断の設定
        multilines = {
          enabled = true,          -- 複数行診断メッセージのサポートを有効化
          always_show = true,      -- 複数行診断のすべての行に常にメッセージを表示
          trim_whitespaces = true, -- 各行の先頭・末尾の空白を削除
          tabstop = 4,             -- タブを展開する際のスペース数
          severity = nil,          -- 深刻度で複数行診断をフィルタリング (例: { vim.diagnostic.severity.ERROR })
        },

        -- カーソル下だけでなく、現在のカーソル行のすべての診断を表示
        show_all_diags_on_cursorline = true,

        -- カーソルが直接その上にある場合のみ診断を表示し、行診断へのフォールバックなし
        show_diags_only_under_cursor = false,

        -- LSP relatedInformation からの関連診断を表示
        show_related = {
          enabled = false, -- 関連診断の表示を有効化
          max_count = 5,   -- 診断ごとに表示する関連診断の最大数
        },

        -- 挿入モードで診断表示を有効化
        -- 視覚的なアーティファクトが発生する可能性がある。有効にする場合は throttle を 0 に設定することを検討
        enable_on_insert = true,

        -- 選択モードで診断表示を有効化 (例: オートコンプリート中)
        enable_on_select = false,

        -- ウィンドウ幅を超えるメッセージの処理
        overflow = {
          mode = "wrap", -- "wrap": 行に分割、"none": 切り詰めなし、"oneline": 単一行を維持
          padding = 5,   -- 折り返しを早めにトリガーするための追加文字数
        },

        -- 長いメッセージを別々の行に分割
        break_line = {
          enabled = false, -- 自動改行を有効化
          after = 30,      -- 改行を挿入する前の文字数
        },

        -- 診断メッセージをフォーマットするカスタム関数
        -- 診断オブジェクトを受け取り、フォーマットされた文字列を返す
        -- 例: function(diag) return diag.message .. " [" .. diag.source .. "]" end
        format = nil,

        -- 仮想テキストの表示優先度
        -- 値が大きいほど他のプラグイン (例: GitBlame) の上に表示される
        virt_texts = {
          priority = 2048,
        },

        -- 深刻度レベルで診断をフィルタリング
        -- 表示したくない深刻度を削除
        severity = {
          vim.diagnostic.severity.ERROR,
          vim.diagnostic.severity.WARN,
          vim.diagnostic.severity.INFO,
          vim.diagnostic.severity.HINT,
        },

        -- バッファに診断をアタッチするトリガーイベント
        -- デフォルトは {"LspAttach"}。LSP設定でプラグインが動作しない場合のみ変更
        overwrite_events = nil,

        -- 診断フロートウィンドウを開くときに診断を自動的に無効化
        override_open_float = false,

        -- 実験的オプション、将来のNeoVimリリースで誤動作する可能性がある
        experimental = {
          -- 同じバッファを含むウィンドウ間で診断をミラーリングしないようにする
          -- 参照: https://github.com/rachartier/tiny-inline-diagnostic.nvim/issues/127
          use_window_local_extmarks = true,
        },
      },
    },
  },
}
