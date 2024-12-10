return {
  "nvim-lualine/lualine.nvim",
  event = "UIEnter",
  config = function()
    local lualine = require("lualine")

    local colors = {
      blue = "#65D1FF",
      green = "#3EFFDC",
      violet = "#FF61EF",
      yellow = "#FFDA7B",
      red = "#FF4A4A",
      fg = "#c3ccdc",
      bg = "transparent",
      inactive_bg = "#2c3043",
    }

    local my_lualine_theme = {
      normal = {
        a = { bg = colors.blue, fg = "black", gui = "bold" },
        b = { fg = colors.fg },
        c = { fg = colors.fg },
      },
      insert = {
        a = { bg = colors.yellow, fg = "black", gui = "bold" },
        b = { fg = colors.fg },
        c = { fg = colors.fg },
      },
      visual = {
        a = { bg = colors.violet, fg = "black", gui = "bold" },
        b = { fg = colors.fg },
        c = { fg = colors.fg },
      },
      command = {
        a = { bg = colors.yellow, fg = "black", gui = "bold" },
        b = { fg = colors.fg },
        c = { fg = colors.fg },
      },
      replace = {
        a = { bg = colors.red, fg = "black", gui = "bold" },
        b = { fg = colors.fg },
        c = { bg = colors.bg, fg = colors.fg },
      },
      inactive = {
        a = { bg = colors.inactive_bg, fg = colors.semilightgray, gui = "bold" },
        b = { bg = colors.inactive_bg, fg = colors.semilightgray },
        c = { bg = colors.inactive_bg, fg = colors.semilightgray },
      },
    }

    -- configure lualine with modified theme
    lualine.setup({
      options = {
        theme = my_lualine_theme,
        disabled_filetypes = {
          "NvimTree",
          "alpha",
        },
      },
      sections = {
        lualine_b = {
          {
            "filename",
            file_status = true,
            path = 1,
            hide_filename_extension = true,
          },
          "`diagnostics`",
        },
        lualine_c = {},
        lualine_x = {},
        lualine_y = { "diff" },
        lualine_z = {},
      },
    })
  end,
}

-- -- import lualine plugin safely
-- local status, lualine = pcall(require, "lualine")
-- if not status then
--   return
-- end
--
-- -- get lualine nightfly theme
-- local lualine_nightfly = require("lualine.themes.nightfly")
--
-- -- new colors for theme
-- local new_colors = {
--   blue = "#65D1FF",
--   green = "#3EFFDC",
--   violet = "#FF61EF",
--   yellow = "#FFDA7B",
--   black = "#000000",
-- }
--
-- -- change nightlfy theme colors
-- lualine_nightfly.normal.a.bg = new_colors.blue
-- lualine_nightfly.insert.a.bg = new_colors.green
-- lualine_nightfly.visual.a.bg = new_colors.violet
-- lualine_nightfly.command = {
--   a = {
--     gui = "bold",
--     bg = new_colors.yellow,
--     fg = new_colors.black, -- black
--   },
-- }
--
-- -- configure lualine with modified theme
-- lualine.setup({
--   options = {
--     theme = lualine_nightfly,
--   },
-- })
