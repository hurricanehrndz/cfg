vim.fn.setenv("MACOSX_DEPLOYMENT_,TARGET", "10.15")
return require("packer").startup(function(use)
  -- Packer can manage itself
  use("wbthomason/packer.nvim")

  -- helper functions
  local config = function(name)
    return string.format("require('hrndz.plugins.%s')", name)
  end

  local use_with_config = function(path, name)
    use({ path, config = config(name) })
  end

  -- > Look and feel <--
  -- Embrace the darkside
  use("EdenEast/nightfox.nvim")
  use("folke/tokyonight.nvim")
  -- Use the guides
  use_with_config("lukas-reineke/indent-blankline.nvim", "indentline")
  -- Show me end of column
  use_with_config("lewis6991/gitsigns.nvim", "gitsigns")

  -- A splash of color in your life
  use_with_config("norcalli/nvim-colorizer.lua", "colorizer")
  -- Everyone needs an icon
  use_with_config("kyazdani42/nvim-web-devicons", "devicons")
  -- Keybindings
  use_with_config("folke/which-key.nvim", "whichkey")
  -- nofications
  use("rcarriga/nvim-notify")
  -- editor config
  use_with_config("gpanders/editorconfig.nvim", "editorconfig")
  -- undo
  use("mbbill/undotree")

  -- Use the telescope to search between the fuzz
  use({
    "nvim-telescope/telescope.nvim",
    config = config("telescope"),
    requires = {
      { "nvim-lua/popup.nvim" },
      { "nvim-lua/plenary.nvim" },
      { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
      { "nvim-telescope/telescope-dap.nvim" },
    },
  })
  use("christoomey/vim-tmux-navigator")
  use_with_config("akinsho/toggleterm.nvim", "toggleterm")
  use("famiu/feline.nvim")

  -- squash some bugs
  use({
    "mfussenegger/nvim-dap",
    config = config("dap"),
    requires = {
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
      "mfussenegger/nvim-dap-python",
    },
  })

  -- Please complete me
  use({
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    requires = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "neovim/nvim-lspconfig",
      "jose-elias-alvarez/null-ls.nvim",
    },
  })
  use({
    "hrsh7th/nvim-cmp",
    config = config("completion"),
    requires = {
      "neovim/nvim-lspconfig",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-cmdline",
      -- zpty completion
      "tamago324/cmp-zsh",
      "Shougo/deol.nvim",
      -- Lua development -- lsp plugin
      "folke/lua-dev.nvim",
      -- dictionary
      "uga-rosa/cmp-dictionary",

      -- javascript dev
      "jose-elias-alvarez/null-ls.nvim",
      "jose-elias-alvarez/nvim-lsp-ts-utils",

      -- Snippets
      "honza/vim-snippets",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",

      -- pictogram for completion menu
      "onsails/lspkind-nvim",
    },
  })
  use({
    "weilbith/nvim-code-action-menu",
    cmd = "CodeActionMenu",
  })
  use({
    "filipdutescu/renamer.nvim",
    config = config("renamer"),
    branch = "master",
    requires = { { "nvim-lua/plenary.nvim" } },
  })

  -- signature
  use_with_config("ray-x/lsp_signature.nvim", "lsp-signature")

  -- format
  use("lukas-reineke/lsp-format.nvim")

  -- Diagnostic help
  use({
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = config("trouble"),
  })

  -- wiki stuff
  use({
    "mickael-menu/zk-nvim",
    config = config("zk"),
  })

  -- file management
  use({
    "kyazdani42/nvim-tree.lua",
    requires = {
      "kyazdani42/nvim-web-devicons", -- optional, for file icons
    },
    config = config("nvim-tree"),
    tag = "nightly", -- optional, updated every week. (see issue #1193)
  })

  -- > Polyglot Plugins <--
  --  Better syntax
  use({
    "nvim-treesitter/nvim-treesitter",
    config = config("treesitter"),
    run = ":TSUpdate",
    requires = {
      -- color all the braces
      "p00f/nvim-ts-rainbow",
    },
  })
  use("sheerun/vim-polyglot")

  -- All hail to the Pope (tpope) + Other tools <--
  -- For the Git
  use("tpope/vim-fugitive")
  -- Need to swap some braces? This is the dentist!
  use("tpope/vim-surround")
  -- Embrace the peanut gallery
  use("tpope/vim-commentary")
  -- So good, why not do it again
  use("tpope/vim-repeat")
  -- In case you need to break-up and reconcile
  use("AndrewRadev/splitjoin.vim")
  -- I am a Super
  use("lambdalisue/suda.vim")
  -- Need a table?
  use("godlygeek/tabular")
end)
