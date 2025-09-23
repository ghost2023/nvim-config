return {
  "goolord/alpha-nvim",
  event = "VimEnter",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")
    dashboard.section.header.val = {
      [[    ███╗   ███╗ █████╗ ██╗  ██╗███████╗   ]],
      [[    ████╗ ████║██╔══██╗██║ ██╔╝██╔════╝   ]],
      [[    ██╔████╔██║███████║█████╔╝ █████╗     ]],
      [[    ██║╚██╔╝██║██╔══██║██╔═██╗ ██╔══╝     ]],
      [[    ██║ ╚═╝ ██║██║  ██║██║  ██╗███████╗   ]],
      [[    ╚═╝     ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝   ]],
      [[      ██████╗ ██████╗  ██████╗ ██╗        ]],
      [[     ██╔════╝██╔═══██╗██╔═══██╗██║        ]],
      [[     ██║     ██║   ██║██║   ██║██║        ]],
      [[     ██║     ██║   ██║██║   ██║██║        ]],
      [[     ╚██████╗╚██████╔╝╚██████╔╝███████╗   ]],
      [[      ╚═════╝ ╚═════╝  ╚═════╝ ╚══════╝   ]],
      [[███████╗████████╗██╗   ██╗███████╗███████╗]],
      [[██╔════╝╚══██╔══╝██║   ██║██╔════╝██╔════╝]],
      [[███████╗   ██║   ██║   ██║█████╗  █████╗  ]],
      [[╚════██║   ██║   ██║   ██║██╔══╝  ██╔══╝  ]],
      [[███████║   ██║   ╚██████╔╝██║     ██║     ]],
      [[╚══════╝   ╚═╝    ╚═════╝ ╚═╝     ╚═╝     ]],
    }

    -- local x=
    -- {
    --   [[      ██╗██╗   ██╗███████╗████████╗    ██████╗ ██╗   ██╗██╗██╗     ██████╗ ]],
    --   [[      ██║██║   ██║██╔════╝╚══██╔══╝    ██╔══██╗██║   ██║██║██║     ██╔══██╗]],
    --   [[      ██║██║   ██║██║        ██║       ██║  ██║██║   ██║██║██║     ██║  ██║]],
    --   [[      ██║██║   ██║███████╗   ██║       ██████  ██║   ██║██║██║     ██║  ██║]],
    --   [[ ██   ██║██║   ██║╚════██║   ██║       ██║  ██║██║   ██║██║██║     ██║  ██║]],
    --   [[ ██   ██║██║   ██║     ██║   ██║       ██║  ██║██║   ██║██║██║     ██║  ██║]],
    --   [[ ╚█████╔╝╚██████╔╝███████║   ██║       ██████╔╝╚██████╔╝██║███████╗██████╔╝]],
    --   [[  ╚════╝  ╚═════╝ ╚══════╝   ╚═╝       ╚═════╝  ╚═════╝ ╚═╝╚══════╝╚═════╝ ]],
    -- }

    --  {
    -- 	"                                                     ",
    -- 	"  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
    -- 	"  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
    -- 	"  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
    -- 	"  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
    -- 	"  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
    -- 	"  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
    -- }

    local icon = require("mini.icons")

    dashboard.section.buttons.val = {
      dashboard.button("r", "↺ ❯ Restore Session", ':silent lua require("persistence").load()<CR>'),
      dashboard.button(
        "e",
        icon.get("default", "directory") .. " ❯ Open Explorer",
        "silent NvimTreeToggle<CR>"
      ),
      dashboard.button("f", icon.get("default", "file") .. " ❯ Open File", ":Telescope find_files<CR>"),
      dashboard.button("q", "✕ ❯ Quit Nvim", ":qa<CR>"),
    }

    dashboard.opts.noautocmd = true

    dashboard.section.buttons.opts.spacing = 0
    -- dashboard.section.buttons.opts.shrink_margin = true

    -- Send config to alpha
    alpha.setup(dashboard.opts)

    -- Disable folding on alpha buffer
    vim.cmd([[autocmd FileType alpha setlocal nofoldenable]])
  end,
}
