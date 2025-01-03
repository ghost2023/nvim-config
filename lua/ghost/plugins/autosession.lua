return {
  "rmagatti/auto-session",
  config = function()
    local auto_session = require("auto-session")
    auto_session.setup({
      auto_session_suppress_dirs = { "~/", "~/Downloads", "~/Documents", "~/Desktop/" },
      log_level = "error",
      auto_save_enabled = true,
      auto_restore_enabled = false,
      session_lens = {
        buftypes_to_ignore = {},
        load_on_setup = false,
        theme_conf = { border = true },
        previewer = false,
      },
    })

    local keymap = vim.keymap

    keymap.set("n", "<leader>wr", "<cmd>SessionRestore<CR>", { desc = "Restore session for cwd" }) -- restore last workspace session for current directory

    keymap.set(
      "n",
      "<leader>wl",
      require("auto-session.session-lens").search_session,
      { desc = "Save session for auto session root dir" }
    ) -- save workspace session for current working directory
  end,
}
