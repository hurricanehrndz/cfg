return require('packer').startup(function(use)

  -- Packer can manage itself
  use('wbthomason/packer.nvim')
  -- let's go to space
  use('tjdevries/astronauta.nvim')

  -- > Look and feel <--
  -- Embrace the darkside
  use('joshdick/onedark.vim')
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
  -- Files grow on trees?
  use('kyazdani42/nvim-tree.lua')
  -- Use the telescope to search between the fuzz
  use({
    'nvim-telescope/telescope.nvim',
    requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}, {'nvim-telescope/telescope-fzy-native.nvim'}}
  })
  use 'christoomey/vim-tmux-navigator'
  use('famiu/feline.nvim')

  -- Please complete me
  use 'neovim/nvim-lspconfig'
  use('hrsh7th/cmp-nvim-lsp')
  use('hrsh7th/cmp-nvim-lua')
  use('hrsh7th/cmp-path')
  use('hrsh7th/cmp-buffer')
  use('tamago324/cmp-zsh')
  use('Shougo/deol.nvim')
  use('hrsh7th/nvim-cmp')
  -- use({
  --   'f3fora/cmp-nuspell',
  --   rocks = {
  --     {
  --       'lua-nuspell',
  --       env = {
  --         ICU_ROOT = '/usr/local/opt/icu4c',
  --         LUA_LIBDIR = '/usr/local/opt/lua@5.1/lib/',
  --         LUA_LIBDIR_FILE = 'liblua5.1.dylib',
  --         MACOSX_DEPLOYMENT_TARGET = '10.15',
  --        },
  --     },
  --   }
  -- })
  use('glepnir/lspsaga.nvim') -- performance UI - code actions, diags
  use('onsails/lspkind-nvim') -- pictogram for completion menu
  use('sbdchd/neoformat')
  -- Snippets
  use('rafamadriz/friendly-snippets')
  use('hrsh7th/cmp-vsnip')
  use('hrsh7th/vim-vsnip')

  -- > Polyglot Plugins <--
  --  Better syntax
  use({
    'nvim-treesitter/nvim-treesitter',
    requires = {
      -- color all the braces
      {'p00f/nvim-ts-rainbow'}
    },
  })
  use 'sheerun/vim-polyglot' -- forces redraw effecting startpage
  -- Lua development -- lsp plugin
  use 'tjdevries/nlua.nvim'

  -- All hail to the Pope (tpope) + Other tools <--
  -- For the Git
  use 'tpope/vim-fugitive'
  -- Need to swap some braces? This is the dentist!
  use 'tpope/vim-surround'
  -- Embrace the peanut gallery
  use 'tpope/vim-commentary'
  -- So good, why not do it again
  use 'tpope/vim-repeat'
  -- In case you need to break-up and reconcile
  use 'AndrewRadev/splitjoin.vim'
  -- I am a Super
  use 'lambdalisue/suda.vim'
  -- Need a table?
  use 'godlygeek/tabular'
  use 'ntpeters/vim-better-whitespace'
  -- Add a terminal
end)
