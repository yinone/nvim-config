# nvim-config

面向 Web 开发的 Neovim 配置，基于 [lazy.nvim](https://github.com/folke/lazy.nvim) 管理插件。

## 特性

- **LSP**：通过 mason + nvim-lspconfig 自动安装与配置语言服务器
- **补全**：[blink.cmp](https://github.com/saghen/blink.cmp) + LuaSnip 代码片段
- **格式化**：[conform.nvim](https://github.com/stevearc/conform.nvim) 统一格式化
- **调试**：nvim-dap + dap-ui + dap-go，支持断点调试
- **语法高亮**：nvim-treesitter，含 textobjects 与上下文注释
- **UI**：tokyonight 主题、bufferline、lualine、lspsaga、snacks 仪表盘
- **文件管理**：nvim-tree + oil.nvim
- **搜索**：telescope + fzf-native
- **Git**：gitsigns、diffview、conflict-marker

## 支持的语言

TypeScript / JavaScript、Go、Lua、HTML、CSS（含 CSS Modules）、JSON、YAML、Bash、Vim，并集成 ESLint。

## 目录结构

```
init.lua                 入口文件
lua/
├── basic.lua            基础选项
├── plugins.lua          插件声明（lazy.nvim）
├── keybindings.lua      快捷键映射
├── colorscheme.lua      主题设置
├── autocmds.lua         自动命令
├── lsp/                 LSP / 补全 / 格式化配置
│   └── lang/            各语言服务器配置
└── plugin-config/       各插件独立配置
```

## 安装

要求 Neovim 0.10+（使用了 `vim.uv`）。

```bash
git clone git@github.com:yinone/nvim-config.git ~/.config/nvim
nvim
```

首次启动 lazy.nvim 会自动安装全部插件。
