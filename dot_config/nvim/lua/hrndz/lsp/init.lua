-- Setup lspconfig.
local has_mason, mason = pcall(require, "mason")
local has_mlsp, mlsp = pcall(require, "mason-lspconfig")
local has_installer, installer = pcall(require, "mason-tool-installer")
local has_cmp, cmp = pcall(require, "cmp_nvim_lsp")
local has_lsplines, lsp_lines = pcall(require, "lsp_lines")

if not has_mason or not has_installer or not has_mlsp or not has_cmp then
  return
end

if has_lsplines then
  lsp_lines.setup()
end

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
installer.setup({
  ensure_installed = {
    "beautysh",
    "black",
    "cbfmt",
    "editorconfig-checker",
    "eslint-lsp",
    "flake8",
    "markdownlint",
    "misspell",
    "prettier",
    "pyright",
    "shellcheck",
    "shfmt",
    "stylua",
    "lua-language-server",
    "typescript-language-server",
    "vale",
    "vim-language-server",
  },
  auto_update = false,
  run_on_start = true,
})

local map = require("hrndz.utils").map
map("n", "<space>lr", "<Cmd>lua vim.lsp.buf.rename()<CR>", "Rename")
map("n", "<space>la", "<Cmd>CodeActionMenu<CR>", "Code Action")
map("n", "<space>ld", "<Cmd>lua vim.diagnostic.open_float()<CR>", "Diagnostic float")
map("n", "<space>lt", "<Cmd>TroubleToggle<CR>", "Diagnostics")
map("n", "<space>lw", "<Cmd>Telescope diagnostics<CR>", "Workspace Diagnostics")
map("n", "<space>lf", "<Cmd>lua vim.lsp.buf.format()<CR>", "Format")
map("n", "<space>li", "<Cmd>LspInfo<CR>", "Info")
map("n", "<space>ll", [[<Cmd>lua require("lsp_lines").toggle()<CR>]], "Toggle lsp lines")
map("n", "<space>lm", "<Cmd>Mason<CR>", "Mason")

local custom_attach = function(_, bufnr)
  local function bufmap(mode, l, r, desc)
    local opts = {}
    opts.desc = desc
    opts.buffer = bufnr
    vim.keymap.set(mode, l, r, opts)
  end

  bufmap("n", "gd", "<Cmd>Telescope lsp_definitions<CR>", "Show lsp definitions")
  bufmap("n", "gD", "<Cmd>lua vim.lsp.buf.type_definition()<CR>", "Go to type definition")
  bufmap("n", "gI", "<Cmd>Telescope lsp_implementations<CR>", "Show lsp implementations")
  bufmap("n", "gr", "<Cmd>Telescope lsp_references<CR>", "Show lsp references")
  bufmap("n", "gs", "<Cmd>lua vim.lsp.buf.signature_help()<CR>", "Signature help")
  bufmap("n", "gy", "<Cmd>lua vim.lsp.buf.document_symbol()<CR>", "Search for symbol")

  bufmap("n", "]d", "<Cmd>lua vim.diagnostic.goto_next()<CR>", "Go to next diagnostic")
  bufmap("n", "[d", "<Cmd>lua vim.diagnostic.goto_prev()<CR>", "Go to prev diagnostic")
end

local capabilities = cmp.default_capabilities()

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

vim.diagnostic.config({
  underline = true,
  signs = true,
  virtual_text = false,
  virtual_lines = false,
  float = {
    show_header = true,
    source = "always",
    border = "rounded",
    focusable = false,
  },
  update_in_insert = false, -- default to false
  severity_sort = true, -- default to false
})

local mason_lsp_handlers = {
  -- The first entry (without a key) will be the default handler
  -- and will be called for each installed server that doesn't have
  -- a dedicated handler.
  function(server_name)
    require("lspconfig")[server_name].setup({
      on_attach = custom_attach,
      capabilities = capabilities,
    })
  end,
}
local installed_servers = mlsp.get_installed_servers()
for _, server_name in ipairs(installed_servers) do
  local has_custom_config, lspserver = pcall(require, "hrndz.lsp.servers." .. server_name)
  if has_custom_config then
    mason_lsp_handlers[server_name] = function()
      return lspserver.setup(custom_attach, capabilities)
    end
  end
end
-- setup lsp servers
require("mason-lspconfig").setup_handlers(mason_lsp_handlers)
-- setup null-ls
require("hrndz.lsp.servers.null-ls").setup(custom_attach)

-- setup puppet services, latest git release required
---@diagnostic disable-next-line: param-type-mismatch
vim.env.PATH = vim.fn.expand(vim.fn.stdpath("cache") .. "/puppet-editor-services", false, false) .. ":" .. vim.env.PATH
require("hrndz.lsp.servers.puppet").setup(custom_attach, capabilities)
