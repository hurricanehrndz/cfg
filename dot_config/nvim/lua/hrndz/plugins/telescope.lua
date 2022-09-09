local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  return
end

local actions = require("telescope.actions")

telescope.setup({
  defaults = {
    prompt_prefix = "🔍 ",
    selection_caret = " ",
    mappings = {
      i = {
        ["<esc>"] = actions.close,
      },
    },
  },
})

telescope.load_extension("fzf")

local opts = { noremap = true, silent = true }

-- string maps
-- search for current word under cursor
vim.keymap.set("n", "<space>fw", function()
  ---@diagnostic disable-next-line: param-type-mismatch
  return require("telescope.builtin").grep_string({ search = vim.fn.expand("<cword>", nil, nil) })
end, opts)
vim.keymap.set("n", "<space>fs", require("telescope.builtin").grep_string, opts)
vim.keymap.set("n", "<space>fg", require("telescope.builtin").live_grep, opts)

-- file finder
vim.keymap.set("n", "<C-p>", require("telescope.builtin").git_files, opts)
vim.keymap.set("n", "<space>ff", function()
  return require("telescope.builtin").find_files({
    prompt_prefix = "🔍",
    find_command = {
      "rg",
      "--no-ignore",
      "--hidden",
      "--no-binary",
      "--iglob",
      "!.git/*",
      "--iglob",
      "!.git-crypt/*",
      "--files",
    },
  })
end, opts)

-- buffer finder
vim.keymap.set("n", "<M-b>", function()
  return require("telescope.builtin").buffers(require("telescope.themes").get_dropdown({
    previewer = false,
    initial_mode = "normal",
  }))
end, opts)

-- help finder
vim.keymap.set("n", "<M-'>", "<cmd>Telescope help_tags<CR>", opts)

local plenary_ft = require("plenary.filetype")
plenary_ft.add_file("defs")
