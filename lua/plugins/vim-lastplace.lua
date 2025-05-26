return {
  "farmergreg/vim-lastplace",
  event = { "BufReadPost", "BufNewFile" },
  init = function()
    vim.g.lastplace_open_folds = 0
  end,
}
