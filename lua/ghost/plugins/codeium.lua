return {
  {
    "supermaven-inc/supermaven-nvim",
    event = "InsertEnter",
    config = function()
      require("supermaven-nvim").setup({
        keymaps = {
          accept_suggestion = "<Tab>",
          clear_suggestion = "<C-]>",
          accept_word = "<C-b>",
        },
      })
    end,
  },
  -- "Exafunction/codeium.vim",
  -- config = function()
  -- 	vim.keymap.set("i", "<C-i>", function()
  -- 		return vim.fn["codeium#Accept"]()
  -- 	end, { expr = true })
  -- end,
}
