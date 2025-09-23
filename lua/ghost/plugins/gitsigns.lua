return {
  "lewis6991/gitsigns.nvim",
  event = "VeryLazy",
  config = function()
    local gitsigns = require("gitsigns")
    gitsigns.setup()

    vim.keymap.set("n", "]g", function()
      gitsigns.nav_hunk('next',{wrap = true} )
    end, {
      desc = "Go to next git hunk",
    })

    vim.keymap.set("n", "[g", function()
      gitsigns.nav_hunk("prev",{wrap = true} )
    end, {
      desc = "Go to previous git hunk",
    })

    vim.keymap.set("n", "<leader>gp", function()
      gitsigns.preview_hunk_inline()
    end, {
      desc = "Preview git hunk",
    })

  end,
}
