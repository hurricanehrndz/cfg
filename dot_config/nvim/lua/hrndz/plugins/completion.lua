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
  },
  sources = cmp.config.sources({
    { name = 'nvim_lua' },
    { name = 'nvim_lsp' },
    { name = 'zsh' },
    { name = 'path' },
    { name = 'vsnip' },
    {
      name = 'buffer',
      keyword_length = 3,
      max_item_count = 5,
    },
  }),
  formatting = cmp_formatting,
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
