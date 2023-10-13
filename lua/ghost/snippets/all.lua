local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node

ls.snippets = {
	javascript = {
		ls.parser.parse_snippet({ trig = "cl" }, "console.log(${1:object});"),
	},
	typescript = {
		ls.parser.parse_snippet({ trig = "cl" }, "console.log(${1:object});"),
	},
	javascriptreact = {
		ls.parser.parse_snippet({ trig = "cl" }, "console.log(${1:object});"),
	},
	typescriptreact = {
		ls.parser.parse_snippet({ trig = "cl" }, "console.log(${1:object});"),
	},
}
