require("chatgpt").setup({
	keymaps = {
		submit = "<C-Enter>",
		yank_last_code = "<C-y>",
	},
	edit_with_instructions = {
		keymaps = {
			use_output_as_input = "<C-I>",
		},
	},
})
