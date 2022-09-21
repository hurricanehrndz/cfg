-- editorconfig
local editorconfig = vim.api.nvim_create_augroup("editorconfig", { clear = true })
vim.api.nvim_create_autocmd({ "BufNewFile", "BufReadPost", "BufFilePost" }, {
  pattern = { "*" },
  callback = function()
    local filetype = vim.bo.filetype
    if filetype ~= "gitcommit" then
      require("editorconfig").config()
    else
      vim.notify("Editorconfig disabled..")
    end
  end,
  group = editorconfig,
})
