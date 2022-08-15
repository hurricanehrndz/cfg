vim.g.vimwiki_list = {
  {
    automatic_nested_syntaxes = 1,
    path = "~/src/me/vimwiki/content",
    syntax = "markdown",
    ext = ".md",
  },
}

local vimwiki_frontmatter_ag = vim.api.nvim_create_augroup("VimWikiFrontmatter", { clear = true })
vim.api.nvim_create_autocmd("BufNewFile", {
  pattern = { "*/vimwiki/content/diary/*.md" },
  callback = function()
    -- build frontmatter
    local date = vim.fn['strftime']("%Y-%m-%d")
    local title = string.format("Diary for %s", date)
    local frontmatter = {
      "---",
      "tags:",
      "title: %s",
      "date: %s",
      "---",
    }
    frontmatter[3] = string.format(frontmatter[3], title)
    frontmatter[4] = string.format(frontmatter[4], date)
    vim.api.nvim_buf_set_lines(0, 0, 0, false, frontmatter)
  end,
  group = vimwiki_frontmatter_ag,
})
