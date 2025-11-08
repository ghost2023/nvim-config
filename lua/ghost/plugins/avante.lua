return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  lazy = false,
  -- enabled = false,
  version = false, -- Set this to "*" to always pull the latest release version, or set it to false to update to the latest code changes.
  -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
  build = "make",
  dependencies = {
    "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    --- The below dependencies are optional,
    "echasnovski/mini.pick", -- for file_selector provider mini.pick
    "ibhagwan/fzf-lua",    -- for file_selector provider fzf
  },
  config = function()
    require("avante").setup({
      provider = "gemini",
      providers = {

        ["gemini_flash_lite"] = {
          __inherited_from = "gemini",
          model = "gemini-2.5-flash-lite",
          endpoint = "https://generativelanguage.googleapis.com/v1beta/models",
          api_key_name = "MAIN_GEMINI_API_KEY",
          timeout = 60000,
        },

        ["gemini_flash"] = {
          __inherited_from = "gemini",
          model = "gemini-2.5-flash",
          endpoint = "https://generativelanguage.googleapis.com/v1beta/models",
          api_key_name = "MAIN_GEMINI_API_KEY",
          timeout = 60000,
        },

        gemini = {
          model = "gemini-2.5-flash",
          endpoint = "https://generativelanguage.googleapis.com/v1beta/models",
          api_key_name = "MAIN_GEMINI_API_KEY",
          timeout = 600000,
        },
      },
      -- custom_tools = {
      --   {
      --     name = "list_tmux_sessions",
      --     description = "List all tmux sessions",
      --     command = "tmux list-sessions",
      --     returns = {
      --       {
      --         name = "sessions",
      --         description = "List of tmux sessions",
      --         type = "string",
      --       },
      --     },
      --     func = function()
      --       return vim.fn.system("tmux list-sessions")
      --     end,
      --   },
      --   {
      --     name = "list_tmux_windows",
      --     description = "List all tmux windows (all sessions)",
      --     command = "tmux list-windows -a",
      --     returns = {
      --       {
      --         name = "windows",
      --         description = "List of all windows with session names",
      --         type = "string",
      --       },
      --     },
      --     func = function(_, _, _)
      --       return vim.fn.system("tmux list-windows -a")
      --     end,
      --   },
      --   {
      --     name = "list_tmux_panes",
      --     description = "List all tmux panes (all sessions)",
      --     command = "tmux list-panes -a",
      --     returns = {
      --       {
      --         name = "panes",
      --         description = "List of all panes with session, window, and pane info",
      --         type = "string",
      --       },
      --     },
      --     func = function(_, _, _)
      --       return vim.fn.system("tmux list-panes -a")
      --     end,
      --   },
      --   {
      --     name = "get_tmux_pane_content",
      --     description = "Get content of a specific tmux pane",
      --     command = "tmux capture-pane -pt <target>",
      --     param = {
      --       type = "table",
      --       fields = {
      --         {
      --           name = "target",
      --           description = "Target pane (e.g. '0.1', ':2.0', 'session:1.1')",
      --           type = "string",
      --         },
      --       },
      --     },
      --     returns = {
      --       {
      --         name = "content",
      --         description = "Captured content of the target pane",
      --         type = "string",
      --       },
      --       {
      --         name = "error",
      --         description = "Error message if capture fails",
      --         type = "string",
      --         optional = true,
      --       },
      --     },
      --     func = function(params, _, _)
      --       local target = params.target
      --       if not target or target == "" then
      --         return nil, "Missing tmux target pane"
      --       end
      --       return vim.fn.system("tmux capture-pane -pt " .. target)
      --     end,
      --   },
      -- },
    })
    -- prefil edit window with common scenarios to avoid repeating query and submit immediately
    local prefill_edit_window = function(request)
      require("avante.api").edit()
      local code_bufnr = vim.api.nvim_get_current_buf()
      local code_winid = vim.api.nvim_get_current_win()
      if code_bufnr == nil or code_winid == nil then
        return
      end
      vim.api.nvim_buf_set_lines(code_bufnr, 0, -1, false, { request })
      -- Optionally set the cursor position to the end of the input
      vim.api.nvim_win_set_cursor(code_winid, { 1, #request + 1 })
      -- Simulate Ctrl+S keypress to submit
      vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-s>", true, true, true), "v", true)
    end

    require("which-key").add({
      { "<leader>a", group = "Avante" },
      {
        mode = { "v" },
        {
          "<leader>al",
          function()
            require("avante.api").switch_provider("gemini_flash")
            prefill_edit_window(
              'Insert logging statements to selected code at critical points to help trace execution and variable states. Make sure the the logs are formatted and labeled correctly like a debugger for maximum readablity. Try to group related logic together and add "#__{section title}__#" logs with new lines to separate the group'
            )
            require("avante.api").switch_provider("gemini")
          end,
          desc = "Log",
        },
      },
    })
  end,
}
