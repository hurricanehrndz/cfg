-- javascript
local lspconfig = require("lspconfig")

local ts_utils_settings = {
  -- debug = true,
  enable_import_on_completion = true,
  import_all_scan_buffers = 100,
  update_imports_on_move = true,
  -- filter out dumb module warning
  filter_out_diagnostics_by_code = { 80001 },
}

local M = {}
M.setup = function(on_attach, capabilities)
  local has_ts_utils, ts_utils = pcall(require, "nvim-lsp-ts-utils")
  if not has_ts_utils then
    return
  end

  lspconfig.tsserver.setup({
    init_options = ts_utils.init_options,
    on_attach = function(client)
      client.resolved_capabilities.document_formatting = false
      client.resolved_capabilities.document_range_formatting = false

      on_attach(client)

      ts_utils.setup(ts_utils_settings)
      ts_utils.setup_client(client)
    end,
    flags = {
      debounce_text_changes = 150,
    },
    capabilities = capabilities,
  })
end

return M
