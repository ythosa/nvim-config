return {
  -- all the lua functions i don't want to write twice
  "nvim-lua/plenary.nvim",

  -- ui
  {
    "nvchad/base46",
    build = function()
      require("base46").load_all_highlights()
    end,
  },
  {
    "nvchad/ui",
    lazy = false,
    config = function()
      require "nvchad"
    end,
  },
  "nvzone/volt",
  "nvzone/menu",
  { "nvzone/minty", cmd = { "Huefy", "Shades" } },
  {
    "nvim-tree/nvim-web-devicons",
    opts = function()
      dofile(vim.g.base46_cache .. "devicons")
      return { override = require "nvchad.icons.devicons" }
    end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "User FilePost",
    opts = {
      indent = { char = "│", highlight = "IblChar" },
      scope = { char = "│", highlight = "IblScopeChar" },
    },
    config = function(_, opts)
      dofile(vim.g.base46_cache .. "blankline")

      local hooks = require "ibl.hooks"
      hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_space_indent_level)
      require("ibl").setup(opts)
      dofile(vim.g.base46_cache .. "blankline")
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
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    lazy = false,
    config = function()
      require("todo-comments").setup()
    end,
  },

  -- file management 
  {
    "nvim-tree/nvim-tree.lua",
    lazy = false,
    opts = function()
      return require "configs.nvim-tree"
    end,
  },
  {
    "folke/which-key.nvim",
    keys = { "<leader>", "<c-w>", '"', "'", "`", "c", "v", "g" },
    cmd = "WhichKey",
    opts = function()
      dofile(vim.g.base46_cache .. "whichkey")
      return {}
    end,
  },
  {
    "pocco81/auto-save.nvim",
    lazy = false,
    config = function()
      require("auto-save").setup({
        config = {
          trigger_events = {"BufLeave"}
        }
      })
    end
  },
    {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    cmd = "Telescope",
    opts = function()
      return require "configs.telescope"
    end,
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

  -- formatting
  {
    "stevearc/conform.nvim",
    opts = require "configs.conform",
  },

  -- git tools
  {
    "lewis6991/gitsigns.nvim",
    event = "User FilePost",
    opts = function()
      return require "configs.gitsigns"
    end,
  },

  -- lsp
  {
    "williamboman/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonUpdate" },
    opts = function()
      return require "configs.mason"
    end,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- coq for autocompletion
      { "ms-jpq/coq_nvim", branch = "coq" }, -- main one 
      { "ms-jpq/coq.artifacts", branch = "artifacts" }, -- for snippets 
      { 'ms-jpq/coq.thirdparty', branch = "3p" }, -- third party sources -- See https://github.com/ms-jpq/coq.thirdparty
      -- - shell repl
      -- - nvim lua api
      -- - scientific calculator
      -- - comment banner
      -- - etc

      -- list of available classes and methods
      {
        "SmiteshP/nvim-navbuddy",
        dependencies = {
          "SmiteshP/nvim-navic",
          "MunifTanjim/nui.nvim"
        },
        opts = { lsp = { auto_attach = true } }
      },
    },
    init = function()
      vim.g.coq_settings = {
          auto_start = true, 
      }
    end,
    config = function()
      require "configs.lspconfig"
    end,
  },
  { 
    "hrsh7th/nvim-cmp", -- `coq_nvim` alternative
    enabled = false,
    event = "InsertEnter",
    dependencies = {
      {
        -- snippet plugin
        "L3MON4D3/LuaSnip",
        dependencies = "rafamadriz/friendly-snippets",
        opts = { history = true, updateevents = "TextChanged,TextChangedI" },
        config = function(_, opts)
          require("luasnip").config.set_config(opts)
        end,
      },

      -- autopairing of (){}[] etc
      {
        "windwp/nvim-autopairs",
        opts = {
          fast_wrap = {},
          disable_filetype = { "TelescopePrompt", "vim" },
        },
        config = function(_, opts)
          require("nvim-autopairs").setup(opts)

          -- setup cmp for autopairs
          local cmp_autopairs = require "nvim-autopairs.completion.cmp"
          require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
        end,
      },

      -- cmp sources plugins
      {
        "saadparwaiz1/cmp_luasnip",
        "hrsh7th/cmp-nvim-lua",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
      },
    },
    opts = function()
      return require "configs.nvim-cmp"
    end,
  },
  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    config = true,
    enabled = false,
    -- use opts = {} for passing setup options, this is equivalent to setup({}) function
  },
  {
    "RRethy/vim-illuminate",
    lazy = false,
    config = function ()
      require("configs.illuminate").setup()
    end,
  },
  {
    "mfussenegger/nvim-dap",
  },
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
    build = ":TSUpdate",
    opts = function()
      return require "configs.treesitter"
    end,
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
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

  -- D2 support
  {
    "terrastruct/d2-vim",
    ft = "d2"
  }
}
