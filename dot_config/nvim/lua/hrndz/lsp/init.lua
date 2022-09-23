-- Setup lspconfig.
local has_mason, mason = pcall(require, "mason")
local has_mlsp, mlsp = pcall(require, "mason-lspconfig")
local has_minstaller, minstaller = pcall(require, "mason-tool-installer")
local has_cmp, cmp = pcall(require, "cmp_nvim_lsp")
local has_format, format = pcall(require, "lsp-format")

if not has_mason or not has_minstaller or not has_mlsp or not has_cmp or not has_format then
  return
end

-- setup async formatting
format.setup({})

-- mason settings
local mason_settings = {
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗",
    },
  },
  log_level = vim.log.levels.INFO,
  max_concurrent_installers = 4,
}
mason.setup(mason_settings)
mlsp.setup({})

-- install and update linters, and formatters
minstaller.setup({
  ensure_installed = {
    "cbfmt",
    "black",
    "editorconfig-checker",
    "eslint-lsp",
    "flake8",
    "markdownlint",
    "misspell",
    "prettier",
    "puppet-editor-services",
    "pyright",
    "shellcheck",
    "shfmt",
    "stylua",
    "typescript-language-server",
    "vale",
  },
  auto_update = false,
  run_on_start = true,
})

-- keybinds with which-key
local has_wk, wk = pcall(require, "which-key")
if not has_wk then
  return
end

wk.register({
  l = {
    name = "LSP",
    r = { "<Cmd>lua vim.lsp.buf.rename()<CR>", "Rename" },
    a = { "<Cmd>CodeActionMenu<CR>", "Code Action" },
    d = { "<Cmd>TroubleToggle<CR>", "Diagnostics" },
    w = { "<Cmd>Telescope diagnostics<CR>", "Workspace Diagnostics" },
    f = { "<Cmd>Format sync<CR>", "Format" },
    i = { "<Cmd>LspInfo<CR>", "Info" },
    m = { "<Cmd>Mason<CR>", "Mason" },
  },
}, { prefix = "<space>" })

local custom_attach = function(client, bufnr)
  wk.register({
    d = { "<Cmd>Telescope lsp_definitions<CR>", "Show lsp definitions" },
    D = { "<Cmd>lua vim.lsp.buf.type_definition()<CR>", "Go to type definition" },
    I = { "<Cmd>Telescope lsp_implementations<CR>", "Show lsp implementations" },
    r = { "<Cmd>Telescope lsp_references<CR>", "Show lsp references" },
    s = { "<Cmd>lua vim.lsp.buf.signature_help()<CR>", "Signature help" },
    y = { "<Cmd>lua vim.lsp.buf.document_symbol()<CR>", "Search for symbol" },
    l = { "<Cmd>lua vim.diagnostic.open_float()<CR>", "Show diagnostic" },
  }, { prefix = "g", buffer = bufnr })

  wk.register({
    d = { "<Cmd>lua vim.diagnostic.goto_prev()<CR>", "Go to prev diagnostic" },
  }, { prefix = "[", buffer = bufnr })

  wk.register({
    d = { "<Cmd>lua vim.diagnostic.goto_next()<CR>", "Go to next diagnostic" },
  }, { prefix = "]", buffer = bufnr })

  -- formatting
  format.on_attach(client)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities = cmp.update_capabilities(capabilities)

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

local installed_servers = mlsp.get_installed_servers()
table.insert(installed_servers, "null-ls")

for _, server_name in ipairs(installed_servers) do
  local ok, server = pcall(require, "hrndz.lsp.servers." .. server_name)
  if not ok then
    vim.api.nvim_err_writeln("failed to setup server: " .. server_name)
  else
    server.setup(custom_attach, capabilities)
  end
end
