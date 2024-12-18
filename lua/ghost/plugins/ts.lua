return {
  {
    "dmmulroy/tsc.nvim",
    cmd = "TSC",
    config = function()
      require("tsc").setup()
    end,
  },
  {
    "OlegGulevskyy/better-ts-errors.nvim",
    dependencies = { "MunifTanjim/nui.nvim" },
    ft = { "typescript", "typescriptreact" },
    cmd = { "BetterTSErrors" },
    config = {
      keymaps = {
        toggle = nil,
        go_to_definition = nil,
      },
    },
  },
}
