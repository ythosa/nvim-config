return {
  {
    "nvim-tree/nvim-tree.lua",
    config = function ()
       require("configs.nvim-tree").setup()
    end
  },
  {
    "stevearc/conform.nvim",
    opts = require "configs.conform",
  },
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()
    end
  },
  {
    "mfussenegger/nvim-dap",
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "SmiteshP/nvim-navbuddy",
        dependencies = {
          "SmiteshP/nvim-navic",
          "MunifTanjim/nui.nvim"
        },
        opts = { lsp = { auto_attach = true } }
      }
    },
    config = function()
      require "configs.lspconfig"
    end,
  },
  {
    "RRethy/vim-illuminate",
    lazy = false,
    config = function ()
      require("configs.illuminate").setup()
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    lazy = false,
    dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
    config = function ()
      require("configs.treesitter-context").setup()
    end
  },
  {
    "princejoogie/dir-telescope.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
    },
    event = "BufRead",
    config = function ()
        require("dir-telescope").setup({
            hidden = true,
            no_ignore = true,
            show_preview = true,
        })
        vim.keymap.set("n", "<leader>fd", "<cmd>Telescope dir live_grep<CR>", { noremap = true, silent = true })
        vim.keymap.set("n", "<leader>pd", "<cmd>Telescope dir find_files<CR>", { noremap = true, silent = true })
    end,
  },
  {
    "karb94/neoscroll.nvim",
    lazy = false,
    config = function ()
      require('neoscroll').setup({
        mappings = {
          '<C-u>', '<C-d>',
          '<C-b>', '<C-f>',
          '<C-y>', '<C-e>',
          'zt', 'zz', 'zb',
        },
        hide_cursor = true,
        stop_eof = true,
        respect_scrolloff = false,
        cursor_scrolls_alone = true,
        easing = 'quadratic',
        pre_hook = nil,
        post_hook = nil,
        performance_mode = false,
      })
    end
  },
  {
    "pocco81/auto-save.nvim",
    event = "BufLeave"
  },

  -- Go language support
  {
    "ray-x/go.nvim",
    dependencies = {
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("go").setup()
    end,
    event = {"CmdlineEnter"},
    ft = {"go", 'gomod'},
    build = ':lua require("go.install").update_all_sync()'
  },
  {
    "dreamsofcode-io/nvim-dap-go",
    ft = "go",
    dependencies = "mfussenegger/nvim-dap",
    config = function(_, opts)
      require("dap-go").setup(opts)
    end
  },
}
