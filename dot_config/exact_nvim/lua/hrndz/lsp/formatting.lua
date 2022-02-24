local lsp = vim.lsp
local api = vim.api
local util = require("vim.lsp.util")

local M = {}

-- use lsp formatting if it's available (and if it's good)
-- otherwise, fall back to null-ls
local preferred_formatting_clients = { "eslint" }
local fallback_formatting_client = "null-ls"

function M.sync(bufnr)
  bufnr = tonumber(bufnr) or api.nvim_get_current_buf()

  local selected_client
  for _, client in ipairs(lsp.buf_get_clients(bufnr)) do
    if vim.tbl_contains(preferred_formatting_clients, client.name) then
      selected_client = client
      break
    end

    if client.name == fallback_formatting_client then
      selected_client = client
    end
  end

  if not selected_client then
    return
  end

  local params = util.make_formatting_params()
  local timeout_ms = 1000 -- default used in neovmin
  local result, err = selected_client.request_sync("textDocument/formatting", params, timeout_ms, bufnr)
  if result and result.result then
    util.apply_text_edits(result.result, bufnr, selected_client.offset_encoding)
  elseif err then
    vim.notify("hrndz.formatting_sync: " .. err, vim.log.levels.WARN)
  end
end

return M
-- vim:sw=2 ts=2 et
