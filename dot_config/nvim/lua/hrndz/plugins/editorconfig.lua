-- editorconfig
local editorconfig = vim.api.nvim_create_augroup("editorconfig", { clear = true })
vim.api.nvim_create_autocmd({ "BufNewFile", "BufReadPost", "BufFilePost" }, {
  pattern = { "*" },
  callback = function()
    local filetype = vim.bo.filetype
    if filetype ~= "gitcommit" then
      require("editorconfig").config()
    end
  end,
  group = editorconfig,
})
