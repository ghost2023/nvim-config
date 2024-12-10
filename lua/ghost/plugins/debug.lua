local js_based_languages = {
  "typescript",
  "javascript",
  "typescriptreact",
  "javascriptreact",
  "vue",
}

return {
  "mfussenegger/nvim-dap",
  -- event = "VeryLazy",
  cmd = { "DapNew" },
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "leoluz/nvim-dap-go",
    "nvim-neotest/nvim-nio",
    {
      "theHamsta/nvim-dap-virtual-text",
      config = function()
        require("nvim-dap-virtual-text").setup()
      end,
    },
    {
      "microsoft/vscode-js-debug",
      -- After install, build it and rename the dist directory to out
      build = "npm install --legacy-peer-deps --no-save && npx gulp vsDebugServerBundle && rm -rf out && mv dist out",
      version = "1.*",
    },
    {
      "mxsdev/nvim-dap-vscode-js",
      config = function()
        ---@diagnostic disable-next-line: missing-fields
        require("dap-vscode-js").setup({
          -- Path of node executable. Defaults to $NODE_PATH, and then "node"
          -- node_path = "node",

          -- Path to vscode-js-debug installation.
          debugger_path = vim.fn.resolve(vim.fn.stdpath("data") .. "/lazy/vscode-js-debug"),

          -- Command to use to launch the debug server. Takes precedence over "node_path" and "debugger_path"
          -- debugger_cmd = { "js-debug-adapter" },

          -- which adapters to register in nvim-dap
          adapters = {
            "node",
            "chrome",
            "pwa-node",
            "pwa-chrome",
            "pwa-msedge",
            "pwa-extensionHost",
            "node-terminal",
          },

          -- Path for file logging
          -- log_file_path = "(stdpath cache)/dap_vscode_js.log",

          -- Logging level for output to file. Set to false to disable logging.
          -- log_file_level = false,

          -- Logging level for output to console. Set to false to disable console output.
          -- log_console_level = vim.log.levels.ERROR,
        })
      end,
    },
    {
      "Joakker/lua-json5",
      build = "./install.sh",
    },
  },
  -- keys = ,
  config = function()
    local dap, dapui = require("dap"), require("dapui")
    --
    -- local Config = require("lazyvim.config")
    -- vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })
    --
    -- for name, sign in pairs(Config.icons.dap) do
    -- 	sign = type(sign) == "table" and sign or { sign }
    -- 	vim.fn.sign_define(
    -- 		"Dap" .. name,
    -- 		{ text = sign[1], texthl = sign[2] or "DiagnosticInfo", linehl = sign[3], numhl = sign[3] }
    -- 	)
    -- end

    dapui.setup()

    vim.keymap.set("n", "<leader>dp", dap.toggle_breakpoint)
    vim.keymap.set("n", "<leader>dc", dap.continue)
    vim.keymap.set("n", "<leader>dO", dap.step_out)
    vim.keymap.set("n", "<leader>do", dap.step_over)
    vim.keymap.set("n", "<leader>da", function()
      if vim.fn.filereadable(".vscode/launch.json") then
        local dap_vscode = require("dap.ext.vscode")
        dap_vscode.load_launchjs(nil, {
          ["pwa-node"] = js_based_languages,
          ["chrome"] = js_based_languages,
          ["pwa-chrome"] = js_based_languages,
        })
      end
      dap.continue()
    end)
    -- {
    -- 	{
    -- 		"<leader>dO",
    -- 		function()
    -- 			require("dap").step_out()
    -- 		end,
    -- 		desc = "Step Out",
    -- 	},
    -- 	{
    -- 		"<leader>do",
    -- 		function()
    -- 			require("dap").step_over()
    -- 		end,
    -- 		desc = "Step Over",
    -- 	},
    -- 	{
    -- 		"<leader>da",
    -- 	},
    --
    -- }

    dap.listeners.before.attach.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated.dapui_config = function()
      dapui.close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
      dapui.close()
    end

    -- JS
    --     -require("dap").adapters["pwa-node"] = {
    --   type = "server",
    --   host = "localhost",
    --   port = "${port}",
    --   executable = {
    --     command = "node",
    --     -- 💀 Make sure to update this path to point to your installation
    --     args = {"/path/to/js-debug/src/dapDebugServer.js", "${port}"},
    --   }
    -- }
    for _, language in ipairs(js_based_languages) do
      dap.configurations[language] = {
        -- Debug single nodejs files
        {
          type = "pwa-node",
          request = "launch",
          name = "Launch file",
          program = "${file}",
          cwd = vim.fn.getcwd(),
          sourceMaps = true,
        },
        -- Debug nodejs processes (make sure to add --inspect when you run the process)
        {
          type = "pwa-node",
          request = "attach",
          name = "Attach",
          processId = require("dap.utils").pick_process,
          cwd = "${workspaceFolder}",
          sourceMaps = true,
        },
        -- Debug web applications (client side)
        {
          type = "pwa-chrome",
          request = "launch",
          name = "Launch & Debug Chrome",
          url = function()
            local co = coroutine.running()
            return coroutine.create(function()
              vim.ui.input({
                prompt = "Enter URL: ",
                default = "http://localhost:3000",
              }, function(url)
                if url == nil or url == "" then
                  return
                else
                  coroutine.resume(co, url)
                end
              end)
            end)
          end,
          webRoot = vim.fn.getcwd(),
          protocol = "inspector",
          sourceMaps = true,
          userDataDir = false,
        },
        -- Divider for the launch.json derived configs
        {
          name = "----- ↓ launch.json configs ↓ -----",
          type = "",
          request = "launch",
        },
      }
    end

    dap.adapters.delve = function(callback, config)
      if config.mode == "remote" and config.request == "attach" then
        callback({
          type = "server",
          host = config.host or "127.0.0.1",
          port = config.port or "38697",
        })
      else
        callback({
          type = "server",
          port = "${port}",
          executable = {
            command = "dlv",
            args = { "dap", "-l", "127.0.0.1:${port}", "--log", "--log-output=dap" },
            detached = vim.fn.has("win32") == 0,
          },
        })
      end
    end

    -- https://github.com/go-delve/delve/blob/master/Documentation/usage/dlv_dap.md
    dap.configurations.go = {
      {
        type = "delve",
        name = "Debug",
        request = "launch",
        program = "${file}",
      },
      {
        type = "delve",
        name = "Debug test", -- configuration for debugging test files
        request = "launch",
        mode = "test",
        program = "${file}",
      },
      -- works with go.mod packages and sub packages
      {
        type = "delve",
        name = "Debug test (go.mod)",
        request = "launch",
        mode = "test",
        program = "./${relativeFileDirname}",
      },
    }
  end,
}
