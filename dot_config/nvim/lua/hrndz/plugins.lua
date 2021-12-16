vim.fn.setenv("MACOSX_DEPLOYMENT_TARGET", "10.15")
return require('packer').startup(function(use)

  -- Packer can manage itself
  use('wbthomason/packer.nvim')
  -- let's go to space
  use('tjdevries/astronauta.nvim')

  -- > Look and feel <--
  -- Embrace the darkside
  use('navarasu/onedark.nvim')
  -- Use the guides
  use('lukas-reineke/indent-blankline.nvim')
  -- Show me end of column
  use('tjdevries/overlength.vim')
  -- But mind the (git) warning signs
  use('lewis6991/gitsigns.nvim')

  -- A splash of color in your life
  use('norcalli/nvim-colorizer.lua')
  -- Everyone needs an icon
  use('kyazdani42/nvim-web-devicons')
  -- Use the telescope to search between the fuzz
  use({
    'nvim-telescope/telescope.nvim',
    requires = {
      {'nvim-lua/popup.nvim'},
      {'nvim-lua/plenary.nvim'},
      {'nvim-telescope/telescope-fzf-native.nvim', run = 'make'},
    }
  })
  use('christoomey/vim-tmux-navigator')
  use('famiu/feline.nvim')
  use('folke/which-key.nvim')

  -- Please complete me
  use 'neovim/nvim-lspconfig'
  use('hrsh7th/cmp-nvim-lsp')
  use('hrsh7th/cmp-nvim-lua')
  use('hrsh7th/cmp-path')
  use('hrsh7th/cmp-buffer')
  use('hrsh7th/cmp-cmdline')
  use('tamago324/cmp-zsh')
  use({
    'uga-rosa/cmp-dictionary',
    config = function()
      require("cmp_dictionary").setup({
        dic = {
          ["*"] = "/usr/share/dict/words",
        }
      })
    end
  })
  use('Shougo/deol.nvim')
  use('hrsh7th/nvim-cmp')
  -- Lua development -- lsp plugin
  use("folke/lua-dev.nvim")
  -- javascript dev
  use('jose-elias-alvarez/null-ls.nvim')
  use('jose-elias-alvarez/nvim-lsp-ts-utils')

  -- Snippets
  use('rafamadriz/friendly-snippets')
  use('hrsh7th/cmp-vsnip')
  use('hrsh7th/vim-vsnip')
  use('onsails/lspkind-nvim') -- pictogram for completion menu
  -- use('sbdchd/neoformat')

  -- > Polyglot Plugins <--
  --  Better syntax
  use({
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate maintained',
    requires = {
      -- color all the braces
      {'p00f/nvim-ts-rainbow'}
    },
  })
  use('sheerun/vim-polyglot')

  -- All hail to the Pope (tpope) + Other tools <--
  -- For the Git
  use('tpope/vim-fugitive')
  -- Need to swap some braces? This is the dentist!
  use('tpope/vim-surround')
  -- Embrace the peanut gallery
  use('tpope/vim-commentary')
  -- So good, why not do it again
  use('tpope/vim-repeat')
  -- In case you need to break-up and reconcile
  use('AndrewRadev/splitjoin.vim')
  -- I am a Super
  use('lambdalisue/suda.vim')
  -- Need a table?
  use('godlygeek/tabular')
  use('ntpeters/vim-better-whitespace')
  -- Add a terminal
end)
