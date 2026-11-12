-- Side-by-side diffs with a file panel: :DiffviewOpen for the working tree, :DiffviewOpen <rev>
-- for a commit or range, :DiffviewFileHistory % for one file. :DiffviewClose (or q) closes it.
return {
  "sindrets/diffview.nvim",
  cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewFileHistory" },
  keys = {
    { "<leader>gv", "<cmd>DiffviewOpen<cr>", desc = "Diff view (uncommitted)" },
    { "<leader>gV", "<cmd>DiffviewOpen HEAD~1<cr>", desc = "Diff view (last commit)" },
    { "<leader>gF", "<cmd>DiffviewFileHistory %<cr>", desc = "File history" },
  },
  opts = {
    keymaps = {
      view = { { "n", "q", "<cmd>DiffviewClose<cr>", { desc = "Close diff view" } } },
      file_panel = { { "n", "q", "<cmd>DiffviewClose<cr>", { desc = "Close diff view" } } },
      file_history_panel = { { "n", "q", "<cmd>DiffviewClose<cr>", { desc = "Close diff view" } } },
    },
  },
}
