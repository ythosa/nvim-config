# nvim-config

The repository is a ready-made configuration for Neovim,
where the main focus is on the Go programming language. 
Also contains minimalistic Vim config.

## Example
https://github.com/user-attachments/assets/acfff7cb-8546-46b9-84de-8dd70902570a

## Installation
- Cloning repository
    ```sh
    git clone git@github.com:ythosa/nvim-config.git ~/.config/nvim
    ```
- Updating vim configuration 
    ```sh
    mv ~/.config/nvim/.vimrc ~/.vimrc
    ```

## Features
Config uses [lazy.nvim](https://github.com/folke/lazy.nvim.git) as plugin manager.

### UI
- Based on [nvchad/ui](https://github.com/nvchad/ui).
- Uses [karb94/neoscroll.nvim](https://github.com/karb94/neoscroll.nvim) for smooth scrolling.
- Highliting todo-comments using [folke/todo-comments.nvim](https://github.com/folke/todo-comments.nvim).

### File-management
- Displaying a file tree using [nvim-tree/nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua).
- Auto-saving buffers on leaving them [pocco81/auto-save.nvim](https://github.com/pocco81/auto-save.nvim).
- File/folder/git/content search using [nvim-telescope/telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) and [princejoogie/dir-telescope.nvim](https://github.com/princejoogie/dir-telescope.nvim).

### Formatting
- Uses [stevearc/conform.nvim](https://github.com/stevearc/conform.nvim) for code formatting.

### Git 
- Signs for added, removed and changed lines / files, status bar, commands, etc using [lewis6991/gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim).

### LSP 
- Uses [williamboman/mason.nvim](https://github.com/williamboman/mason.nvim) for easy install and managing LSP servers, DAP servers, linters and formatters.
- Fast as FUCK code-completion [ms-jpq/coq_nvim](https://github.com/ms-jpq/coq_nvim).
- Highlighting syntax using [nvim-treesitter/nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter).
- Debugger with [mfussenegger/nvim-dap](https://github.com/mfussenegger/nvim-dap) and [rcarriga/nvim-dap-ui](https://github.com/rcarriga/nvim-dap-ui).
- Showing code context such as signature of the function being edited with [nvim-treesitter/nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter).
- Showing file content as breadcrumbs using [SmiteshP/nvim-navbuddy](https://github.com/SmiteshP/nvim-navbuddy).
- Automatic bracket pairs with [windwp/nvim-autopairs](https://github.com/windwp/nvim-autopairs).
- Highlighting other uses of the word under coursor with [RRethy/vim-illuminate](https://github.com/RRethy/vim-illuminate).

### Go 
- Feature-righ Go plugin: [ray-x/go.nvim](https://github.com/ray-x/go.nvim).
- Using [delve](https://github.com/go-delve/delve) for debugging with [leoluz/nvim-dap-go](https://github.com/leoluz/nvim-dap-go).

