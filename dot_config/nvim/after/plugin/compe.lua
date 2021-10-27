-- completion settings
vim.o.completeopt = "menu,menuone,noinsert"
-- disable insert completion menu messages
vim.o.shortmess = vim.o.shortmess .. "c"

local has_cmp, cmp = pcall(require, "cmp")
if not has_cmp then
 do return end
end

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
    { name = 'buffer' },
    { name = 'path' },
    { name = 'nvim_lsp' },
    { name = 'nvim_lua' },
    { name = 'vsnip' },
    { name = 'zsh' },
  })
})
