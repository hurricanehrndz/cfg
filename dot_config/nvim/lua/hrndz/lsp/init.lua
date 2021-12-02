local has_astronauta, _ = pcall(require, "astronauta.keymap")
if not has_astronauta then
  return
end

local nnoremap = vim.keymap.nnoremap
local inoremap = vim.keymap.inoremap

local buf_nnoremap = function(opts)
  opts.buffer = 0
  nnoremap(opts)
end

local buf_inoremap = function(opts)
  opts.buffer = 0
  inoremap(opts)
end

local custom_attach = function(client)
  vim.bo.omnifunc = "v:lua.vim.lsp.omnifunc"

  buf_inoremap({ "<C-x><C-x>", vim.lsp.buf.signature_help })

  buf_nnoremap({ "gD", vim.lsp.buf.declaration })
  buf_nnoremap({ "gd", vim.lsp.buf.definition })
  buf_nnoremap({ "K", vim.lsp.buf.hover })
  buf_nnoremap({ "[d", vim.diagnostic.goto_prev })
  buf_nnoremap({ "]d", vim.diagnostic.goto_next })
  buf_nnoremap({ "gT", vim.lsp.buf.type_definition })
  buf_nnoremap({ "<space>cr", vim.lsp.buf.rename })

  if client.resolved_capabilities.document_formatting then
    vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
  end
end

-- Setup lspconfig.
local has_lsp, _ = pcall(require, "lspconfig")
local has_cmp_lsp, cmp_lsp = pcall(require, "cmp_nvim_lsp")
if not has_lsp or not has_cmp_lsp then
  return
end

local updated_capabilities = vim.lsp.protocol.make_client_capabilities()
updated_capabilities = cmp_lsp.update_capabilities(updated_capabilities)

require("hrndz.lsp.sumneko").setup(custom_attach, updated_capabilities)
require("hrndz.lsp.tsserver").setup(custom_attach, updated_capabilities)
