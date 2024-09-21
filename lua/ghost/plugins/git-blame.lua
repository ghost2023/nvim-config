return {
  "f-person/git-blame.nvim",
  cmd = { "GitBlameEnable", "GitBlameToggle" },
  config = function()
    require("gitblame").setup({
      enabled = false,
    })
  end,
}
