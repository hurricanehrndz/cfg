local parse_cmd = vim.api.nvim_parse_cmd

local frontMatterUpdateLastMod = function()
  ---@diagnostic disable-next-line: param-type-mismatch
  local filename = tostring(vim.fn.expand("%:p:h", false, false))
  if filename:find("src/me/notes") then
    local view = vim.fn.winsaveview()
    local mod_time = os.date("%Y-%m-%dT%H:%M:%S%z")
    local re = [[%%s/\v%s/%s/]]
    local cmd = parse_cmd(re:format([[^(lastmod:).*$]], [[\1 ]] .. mod_time), {})
    cmd.mods.silent = true
    vim.cmd(cmd)
    vim.fn.winrestview(view)
  end
end
