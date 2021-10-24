-- completion settings
vim.o.completeopt = "menuone,noinsert,noselect"
-- disable insert completion menu messages
vim.o.shortmess = vim.o.shortmess .. "c"

local has_cmp, cmp = pcall(require, "cmp")
if not has_cmp then
 do return end
end

cmp.setup {
  snippet = {
    expand = fuction(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'nvim_lua' },
    { name = 'path' },
    { name = 'buffer' },
    { name = 'vsnip' },
    { name = 'nuspell' },
    { name = 'zsh' },
  })
}

vim.cmd([[inoremap <silent><expr> <C-y>      compe#confirm("<C-y>")]])
