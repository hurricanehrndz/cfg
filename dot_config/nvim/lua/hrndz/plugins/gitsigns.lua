local has_gitsigns, gitsigns = pcall(require, "gitsigns")

if has_gitsigns then
  gitsigns.setup({
    on_attach = function(bufnr)
      local gs = package.loaded.gitsigns

      local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
      end

      local wk = require("which-key")
      -- Navigation
      wk.register({
        c = {
          function()
            if vim.wo.diff then
              return "[c"
            end
            vim.schedule(function()
              gs.prev_hunk()
            end)
            return "<Ignore>"
          end,
          "Go to prev change",
        },
      }, { prefix = "[", buffer = bufnr })

      wk.register({
        c = {
          function()
            if vim.wo.diff then
              return "]c"
            end
            vim.schedule(function()
              gs.next_hunk()
            end)
            return "<Ignore>"
          end,
          "Go to next change",
        },
      }, { prefix = "]", buffer = bufnr })

      -- Actions
      map({ "n", "v" }, "<space>hs", ":Gitsigns stage_hunk<CR>", { desc = "Stage hunk" })
      map({ "n", "v" }, "<space>hr", ":Gitsigns reset_hunk<CR>", { desc = "Reset hunk" })
      map("n", "<space>hS", gs.stage_buffer, { desc = "Stage buffer" })
      map("n", "<space>hu", gs.undo_stage_hunk, { desc = "Unstage hunk" })
      map("n", "<space>hR", gs.reset_buffer, { desc = "Reset buffer" })
      map("n", "<space>hp", gs.preview_hunk, { desc = "Preview hunk" })
      map("n", "<space>hb", function()
        gs.blame_line({ full = true })
      end, { desc = "Git blame" })
      map("n", "<space>hB", gs.toggle_current_line_blame, { desc = "Toggle line blame" })
      map("n", "<space>hd", gs.diffthis, { desc = "Diff HEAD" })
      map("n", "<space>hD", function()
        gs.diffthis("~")
      end, { desc = "Diff HEAD~1" })
      map("n", "<space>hg", gs.toggle_deleted, { desc = "Ghost deleted" })

      -- Text object
      map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "Select hunk" })
    end,
  })
end
