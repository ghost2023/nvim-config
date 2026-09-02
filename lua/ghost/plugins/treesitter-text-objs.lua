return {
	"nvim-treesitter/nvim-treesitter-textobjects",
	branch = "main",
	event = { "BufReadPre", "BufNewFile" },
	init = function()
		vim.g.no_plugin_maps = true -- built-in ftplugin maps steal ]m/[m
	end,
	config = function()
		require("nvim-treesitter-textobjects").setup({
			select = { lookahead = true },
		})

		local select = require("nvim-treesitter-textobjects.select")
		local move = require("nvim-treesitter-textobjects.move")

		-- custom captures live in after/queries/{ecma,jsx,tsx}/textobjects.scm
		for lhs, capture in pairs({
			["a:"] = "@property.outer",
			["i:"] = "@property.inner",
			["l:"] = "@property.lhs",
			["r:"] = "@property.rhs",
			["aa"] = "@parameter.outer",
			["ia"] = "@parameter.inner",
			["ai"] = "@conditional.outer",
			["ii"] = "@conditional.inner",
			["al"] = "@loop.outer",
			["il"] = "@loop.inner",
			["af"] = "@call.outer",
			["if"] = "@call.inner",
			["am"] = "@function.outer",
			["im"] = "@function.inner",
			["ac"] = "@class.outer",
			["ic"] = "@class.inner",
			["an"] = "@self_closing_element",
			["ag"] = "@jsx_attribute",
		}) do
			vim.keymap.set({ "x", "o" }, lhs, function()
				select.select_textobject(capture, "textobjects")
			end, { desc = "Select " .. capture })
		end

		-- capture may be { query, query_group }
		for fn, maps in pairs({
			goto_next_start = {
				["]f"] = "@call.outer",
				["]m"] = "@function.outer",
				["]c"] = "@class.outer",
				["]i"] = "@conditional.outer",
				["]l"] = "@loop.outer",
				["]n"] = "@self_closing_element",
				["]s"] = { "@local.scope", "locals" },
				["]z"] = { "@fold", "folds" },
			},
			goto_next_end = {
				["]F"] = "@call.outer",
				["]M"] = "@function.outer",
				["]C"] = "@class.outer",
				["]I"] = "@conditional.outer",
				["]L"] = "@loop.outer",
			},
			goto_previous_start = {
				["[f"] = "@call.outer",
				["[m"] = "@function.outer",
				["[c"] = "@class.outer",
				["[i"] = "@conditional.outer",
				["[l"] = "@loop.outer",
			},
			goto_previous_end = {
				["[F"] = "@call.outer",
				["[M"] = "@function.outer",
				["[C"] = "@class.outer",
				["[I"] = "@conditional.outer",
				["[L"] = "@loop.outer",
			},
		}) do
			for lhs, capture in pairs(maps) do
				local query, group = capture, "textobjects"
				if type(capture) == "table" then
					query, group = capture[1], capture[2]
				end
				vim.keymap.set({ "n", "x", "o" }, lhs, function()
					move[fn](query, group)
				end, { desc = fn .. " " .. query })
			end
		end
	end,
}
