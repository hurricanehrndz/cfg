-- completion settings
-- vim.o.completeopt = "menu,menuone,noinsert"
vim.opt.completeopt = { "menuone", "noinsert", "noselect" }
-- disable insert completion menu messages
vim.opt.shortmess:append "c"

local cmp = require("cmp")
local lspkind = require("lspkind")

local cmp_formatting = {
  -- Youtube: How to set up nice formatting for your sources.
  format = lspkind.cmp_format({
    with_text = true,
    menu = {
      buffer = "[buf]",
      nvim_lsp = "[LSP]",
      nvim_lua = "[api]",
      zsh = "[zpty]",
      path = "[path]",
      vsnip = "[snip]",
      dictionary = "[dictionary]"
    },
  }),
}

lspkind.init()
cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ["<c-y>"] = cmp.mapping(
      cmp.mapping.confirm {
        behavior = cmp.ConfirmBehavior.Insert,
        select = true,
      },
      { "i", "c" }
    ),
  },
  sources = cmp.config.sources({
    { name = 'nvim_lua' },
    { name = 'nvim_lsp' },
    { name = 'path' },
    { name = 'vsnip' },
    {
      name = "dictionary",
      keyword_length = 2,
      max_item_count = 6,
    },
    {
      name = 'buffer',
      keyword_length = 3,
      max_item_count = 5,
    },
  }),
  formatting = cmp_formatting,
})


require("cmp_dictionary").setup({
  dic = {
    ["*"] = "/usr/share/dict/words",
  },
})

-- Use buffer source for `/`.
cmp.setup.cmdline('/', {
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':'.
cmp.setup.cmdline(':', {
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

_ = vim.cmd([[
  augroup CmpZsh
    au!
    autocmd Filetype zsh lua require("cmp").setup.buffer({
    \ sources = {
    \   { name = "zsh" },
    \   { name = 'path' },
    \   {
    \     name = 'buffer',
    \     keyword_length = 3,
    \     max_item_count = 5,
    \   },
    \ }})
  augroup END
]])
