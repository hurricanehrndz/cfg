local telescope = require("telescope")

telescope.load_extension("fzf")

-- string maps
-- search for current word under cursor
vim.keymap.set(
  "n",
  "<space>fw",
  function()
    return require('telescope.builtin').grep_string({ search = vim.fn.expand("<cword>") })
  end
)
vim.keymap.set("n", "<space>fs", require('telescope.builtin').grep_string)
vim.keymap.set("n", "<space>fg", require('telescope.builtin').live_grep)

-- file finder
vim.keymap.set("n", "<C-p>", require('telescope.builtin').git_files)
vim.keymap.set("n", "<space>ff", require('telescope.builtin').find_files)

-- buffer finder
vim.keymap.set("n", "<space>fb", require('telescope.builtin').buffers)

-- help finder
vim.keymap.set("n", "<space>fh", require('telescope.builtin').help_tags)

-- git maps
vim.keymap.set("n", "<space>gc", require('telescope.builtin').git_commits)
vim.keymap.set("n", "<space>gb", require('telescope.builtin').git_branches)
vim.keymap.set("n", "<space>gs", require('telescope.builtin').git_status)
vim.keymap.set("n", "<space>gp", require('telescope.builtin').git_bcommits)

local plenary_ft = require("plenary.filetype")
plenary_ft.add_file('defs')
