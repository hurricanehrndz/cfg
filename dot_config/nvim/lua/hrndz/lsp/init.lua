local custom_attach = function(_, bufnr)
  vim.bo.omnifunc = "v:lua.vim.lsp.omnifunc"
  -- disable lsp range formatting via gq
  vim.bo.formatexpr = "formatprg"
  local opts = { noremap = true, buffer = bufnr }

  vim.keymap.set("n", "<C-x><C-x>", vim.lsp.buf.signature_help, opts)

  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
  vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
  vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
  vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
  vim.keymap.set("n", "gT", vim.lsp.buf.type_definition, opts)
  vim.keymap.set("n", "<space>cr", vim.lsp.buf.rename, opts)
end

-- Setup lspconfig.
local has_lsp, _ = pcall(require, "lspconfig")
local has_cmp_lsp, cmp_lsp = pcall(require, "cmp_nvim_lsp")
if not has_lsp or not has_cmp_lsp then
  return
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities = cmp_lsp.update_capabilities(capabilities)

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

vim.diagnostic.config({
  underline = true,
  signs = true,
  virtual_text = false,
  float = {
    show_header = true,
    source = "always",
    border = "rounded",
    focusable = false,
  },
  update_in_insert = false, -- default to false
  severity_sort = true, -- default to false
})

for _, server in ipairs({
  "eslint",
  "null-ls",
  "sumneko",
  "tsserver",
  "pses",
}) do
  require("hrndz.lsp." .. server).setup(custom_attach, capabilities)
end
