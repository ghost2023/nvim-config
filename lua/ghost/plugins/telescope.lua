return {
  "nvim-telescope/telescope.nvim",
  cmd = "Telescope",
  branch = "0.1.x",
  dependencies = {
    "nvim-telescope/telescope-live-grep-args.nvim",
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")

    telescope.setup({
      defaults = {
        layout_strategy = "vertical",
        layout_config = {
          height = 0.99,
          -- width = 0.95,
          preview_cutoff = 0.10,
          preview_height = 0.40,
          horizontal = {
            preview_width = 0.45,
            results_width = 0.8,
          },
          vertical = {
            mirror = true,
          },
          prompt_position = "top",
        },
        path_display = { "trunicate" },
        mappings = {
          i = {
            ["<C-k>"] = actions.move_selection_previous, -- move to prev result
            ["<C-j>"] = actions.move_selection_next, -- move to next result
            ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
            ["jk"] = actions.close,
          },
        },
        file_ignore_patterns = {
          "node_modules",
          ".git",
          ".expo",
          ".next",
          "dist",
          "%.png",
          "%.webp",
          "%jpg",
          "%.ttf",
          "%.otf",
          "%.otf",
          "%.svg",
          "%.zip",
          "yarn.lock",
          "pnpm-lock.yaml",
          "package-lock.json",
          "tsconfig.tsbuildinfo",
        },
      },
      pickers = {
        find_files = {
          find_command = { "rg", "--files", "--hidden" },
          hidden = true,
        },
        mappings = {
          i = {
            ["<c-x>"] = actions.delete_buffer + actions.move_to_top,
          },
        },
      },
    })

    telescope.load_extension("live_grep_args")
    telescope.load_extension("fzf")
  end,
}
