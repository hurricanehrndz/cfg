-- Setup lspconfig.
local has_lsp, _ = pcall(require, "lspconfig")
local has_cmp_lsp, cmp_lsp = pcall(require, "cmp_nvim_lsp")
if not has_lsp or not has_cmp_lsp then
  return
end

local custom_attach = function(_, bufnr)
  vim.bo.omnifunc = "v:lua.vim.lsp.omnifunc"
  -- disable lsp range formatting via gq
  vim.bo.formatexpr = "formatprg"
  local status_ok, wk = pcall(require, "which-key")
  if not status_ok then
    return
  end

  wk.register({
    d = { "<Cmd>Telescope lsp_definitions<CR>", "Show lsp definitions"},
    D = { "<Cmd>Telescope lsp_declarations<CR>", "Show lsp declarations"},
    I = { "<Cmd>Telescope lsp_implementations<CR>", "Show lsp implementations" },
    r = { "<cmd>Telescope lsp_references<CR>", "Show lsp references" },
    s = { "<cmd>lua vim.lsp.buf.signature_help()<CR>", "Signature help" },
    K = { "<Cmd>lua vim.lsp.buf.type_definition()<CR>", "Go to type definition" },
    y = { "<Cmd>lua vim.lsp.buf.document_symbol()<CR>", "Search for symbol in document" },
    a = { "<Cmd>lua vim.lsp.buf.code_action()<CR>", "Run code action" },
    n = { "<Cmd>lua vim.lsp.buf.rename()<CR>", "Rename symbol under cursor" },

  }, {prefix = "g", buffer = bufnr})

  wk.register({
    d =  { "<Cmd>lua vim.diagnostic.goto_prev()<CR>", "Go to prev diagnostic" }
  }, {prefix = "[", buffer = bufnr})

  wk.register({
    d =  { "<Cmd>lua vim.diagnostic.goto_next()<CR>", "Go to next diagnostic" }
  }, {prefix = "]", buffer = bufnr })
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
