-- completion settings
-- vim.o.completeopt = "menu,menuone,noinsert"
vim.o.completeopt = 'menuone,noinsert,noselect'
-- disable insert completion menu messages
vim.o.shortmess = vim.o.shortmess .. 'c'

local has_cmp, cmp = pcall(require, 'cmp')
local has_lspkind, lspkind = pcall(require, 'lspkind')
if not has_cmp or not has_lspkind then
 do return end
end

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
    },
    {
      name = "dictionary",
      keyword_length = 2,
    },
  }),
  formatting = {
    -- Youtube: How to set up nice formatting for your sources.
    format = lspkind.cmp_format {
      with_text = true,
      menu = {
        buffer = "[buf]",
        nvim_lsp = "[LSP]",
        nvim_lua = "[api]",
        zsh = "[zpty]",
        path = "[path]",
        vsnip = "[snip]",
      },
    },
  },
})

-- Extend dictionary
vim.opt.dictionary:append("/usr/share/dict/words")

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
