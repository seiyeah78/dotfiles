# dotfiles

macOS向けの開発環境構築用dotfilesです。Neovim、tmux、zsh、各種CLIツールの設定を含みます。

## 特徴

- **エディタ**: Neovim with lazy.nvim (LSP, completion, git integration)
- **シェル**: zsh with zinit + Powerlevel10k
- **ターミナルマルチプレクサ**: tmux
- **パッケージ管理**: Homebrew, mise, aqua
- **開発ツール**: Docker, Kubernetes, Go, Python, Node.js, Ruby
- **便利ツール**: fzf, ripgrep, lazygit, bat, eza, ghq

## クイックスタート

```sh
curl -fsSL https://raw.githubusercontent.com/seiyeah78/dotfiles/master/install.sh | sh
```

このコマンドは以下を実行します：

1. Command Line Developer Toolsのインストール (macOS)
2. リポジトリのクローン (`~/dotfiles`)
3. dotfilesのシンボリックリンク作成
4. Homebrewのインストール
5. Brewfileからのパッケージインストール (オプション)
6. miseのセットアップ (Python, Ruby, Node.js, AWS CLI等)

## 手動インストール

### 1. リポジトリのクローン

```sh
git clone --recursive https://github.com/seiyeah78/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

### 2. インストールスクリプトの実行

```sh
# dotfilesのシンボリックリンクのみ
./install.sh

# Brewfileからパッケージもインストール
./install.sh -i

# Command Line Toolsの更新も実行
./install.sh --update-commandline-tools
```

## ディレクトリ構成

```
~/dotfiles/
├── .config/
│   ├── nvim/           # Neovim設定 (Lua)
│   ├── wezterm/        # WezTerm設定
│   ├── kitty/          # Kitty設定
│   └── crush/          # Crush AI設定
├── .hammerspoon/       # Hammerspoon (macOS自動化)
├── tmux/               # tmux設定ファイル
├── vscode/             # VSCode設定
├── iterm2/             # iTerm2カラースキーム
├── lazygit/            # lazygit設定
├── bat/                # bat設定
├── .zshrc              # zsh設定
├── .zshenv             # zsh環境変数
├── .tmux.conf          # tmux設定
├── .gitconfig          # git設定
├── Brewfile            # Homebrewパッケージリスト
├── aqua.yaml           # aquaパッケージリスト
└── install.sh          # インストールスクリプト
```

## 主要設定

### Neovim

- **プラグインマネージャ**: lazy.nvim
- **LSP**: Mason経由で各言語のLSP (Go, Python, TypeScript, Ruby等)
- **補完**: nvim-cmp with snippet support
- **Git統合**: gitsigns, fugitive, diffview
- **UI**: Snacks.nvim, lualine
- **ファジーファインダー**: fzf-lua

設定ファイル: `.config/nvim/`

### tmux

- プレフィックスキー: `Ctrl+a`
- ステータスライン設定: `tmux/statusline.conf`
- マウスサポート有効

設定ファイル: `.tmux.conf`, `tmux/`

### zsh

- **プラグインマネージャ**: zinit
- **テーマ**: Powerlevel10k
- **プラグイン**: 
  - zsh-autosuggestions (コマンド補完)
  - fast-syntax-highlighting (シンタックスハイライト)
  - zsh-autopair (括弧自動補完)
  - z.lua (ディレクトリジャンプ)
- **バージョン管理**: mise

設定ファイル: `.zshrc`, `.zshenv`, `.p10k.zsh`

### Git

- デフォルトエディタ: `nvim`
- Diff表示: delta
- エイリアス多数設定済み

設定ファイル: `.gitconfig`

## 主要なツール

### 開発ツール

- **エディタ**: Neovim, VSCode
- **ターミナル**: WezTerm, Kitty, iTerm2
- **コンテナ**: Docker Desktop
- **Kubernetes**: kubectl, k9s, kubectx, stern, lazygit

### CLI ユーティリティ

- **ファイル操作**: eza, bat, fd, ripgrep, fzf
- **Git**: lazygit, gh (GitHub CLI), hub, delta
- **テキスト処理**: jq, gron, yq
- **モニタリング**: htop, watch
- **その他**: direnv, tldr, navi, pet

### 言語・ランタイム

- Go (+ golangci-lint, delve)
- Python (+ poetry)
- Node.js (+ yarn)
- Ruby (+ ruby-lsp)

## カスタマイズ

### プライベート設定の追加

gitで管理しないプライベート設定は以下に配置：

- zsh: `~/.zshrc.local`
- git: `~/.gitconfig.local`

### Neovim設定の拡張

`.config/nvim/lua/plugins/` 配下にLuaファイルを追加することで、lazy.nvim経由でプラグインを追加できます。

### Brewfileのカスタマイズ

必要なパッケージを `Brewfile` に追加して：

```sh
brew bundle
```

## トラブルシューティング

### Command Line Toolsのエラー

```sh
xcode-select --install
# または
./install.sh --update-commandline-tools
```

### シンボリックリンクが作成されない

既存ファイルがある場合は手動で削除またはバックアップ：

```sh
mv ~/.zshrc ~/.zshrc.backup
ln -snfv ~/dotfiles/.zshrc ~
```

### Homebrewのパス問題 (Apple Silicon)

```sh
eval "$(/opt/homebrew/bin/brew shellenv)"
```

### zsh補完が効かない

```sh
rm ~/.zcompdump*
exec zsh
```

## 必要要件

- macOS (Intel / Apple Silicon)
- Git
- インターネット接続

## ライセンス

個人用設定ファイルのため、自由に利用・改変してください。

## 参考

- [Neovim](https://neovim.io/)
- [zinit](https://github.com/zdharma-continuum/zinit)
- [Homebrew](https://brew.sh/)
- [mise](https://mise.jdx.dev/)
- [aqua](https://aquaproj.github.io/)
