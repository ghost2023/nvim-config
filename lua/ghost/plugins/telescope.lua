return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  lazy = false,
  dependencies = {
    "nvim-telescope/telescope-live-grep-args.nvim",
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")
    local action_state = require("telescope.actions.state")

    telescope.load_extension("live_grep_args")
    -- telescope.load_extension("fzf")
    telescope.setup({
      defaults = {
        shorten_path = true,
        layout_strategy = "vertical",
        layout_config = {
          height = 0.99,
          -- width = 0.95,
          preview_cutoff = 0.10,
          horizontal = {
            preview_width = 0.6,
            -- results_width = 0.8,
          },
          vertical = {},
          -- prompt_position = "bottom",
        },
        path_display = "smart",
        mappings = {
          i = {
            ["<C-k>"] = actions.move_selection_previous, -- move to prev result
            ["<C-j>"] = actions.move_selection_next, -- move to next result
            ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
            ["jk"] = actions.close,
            -- ["<C-h>"] = function(prompt_bufnr)
            --   local picker = action_state.get_current_picker(prompt_bufnr)
            --   local preview_win = picker.previewer and picker.previewer.state.winid
            --   if preview_win then
            --     vim.api.nvim_win_call(preview_win, function()
            --       vim.cmd("normal! 2zh")
            --     end)
            --   end
            -- end,
            -- ["<C-l>"] = function(prompt_bufnr)
            --   local picker = action_state.get_current_picker(prompt_bufnr)
            --   local preview_win = picker.previewer and picker.previewer.state.winid
            --   if preview_win then
            --     vim.api.nvim_win_call(preview_win, function()
            --       vim.cmd("normal! 2zl")
            --     end)
            --   end
            -- end,
          },
        },
        file_ignore_patterns = {
          "%.png",
          "%.webp",
          "%.jpg",
          "%.jpeg",
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
        colorscheme = {
          enable_preview = true,
        },
        fd = {},

        buffers = {
          sort_lastused = true,
          mappings = {
            i = {
              ["<c-x>"] = actions.delete_buffer + actions.move_to_top,
            },
          },
        },
        lsp_references = {
          entry_maker = function(entry)
            local Path = require("plenary.path")
            local relpath = Path:new(entry.filename):make_relative(vim.loop.cwd())

            local max_len = 80
            if #relpath > max_len then
              local parts = vim.split(relpath, "/", { trimempty = true })
              for i = 1, #parts - 1 do
                if #relpath <= max_len then
                  break
                end
                if #parts[i] > 2 then
                  parts[i] = parts[i]:sub(1, 2)
                  relpath = table.concat(parts, "/")
                end
              end
            end

            local formatted = string.format("%s %d", relpath, entry.lnum)
            return {
              value = entry.text,
              valid = true,
              ordinal = entry.text,
              display = formatted,
              lnum = entry.lnum,
              kind = entry.kind,
              col = entry.col,
              filename = entry.filename,
            }
          end,
        },
      },
      extensions = {
        fzf = {},
      },
    })
  end,
}
