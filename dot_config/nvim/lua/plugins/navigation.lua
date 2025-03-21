return {

	{
		'christoomey/vim-tmux-navigator',
		-- event = 'VimEnter',
		keys = {'<M-h>', '<M-j>', '<M-k>', '<M-l>'},
		config = function ()
			vim.g.tmux_navigator_no_mappings = 1  -- don't open at start
			vim.keymap.set('n', '<M-h>', ':TmuxNavigateLeft<cr>')
			vim.keymap.set('n', '<M-j>', ':TmuxNavigateDown<cr>')
			vim.keymap.set('n', '<M-k>', ':TmuxNavigateUp<cr>')
			vim.keymap.set('n', '<M-l>', ':TmuxNavigateRight<cr>')
			vim.keymap.set('i', '<M-h>', '<Esc>:TmuxNavigateLeft<cr>')
			vim.keymap.set('i', '<M-j>', '<Esc>:TmuxNavigateDown<cr>')
			vim.keymap.set('i', '<M-k>', '<Esc>:TmuxNavigateUp<cr>')
			vim.keymap.set('i', '<M-l>', '<Esc>:TmuxNavigateRight<cr>')
		end
	},


	{
		'smoka7/hop.nvim',
		-- opts = { keys = 'etovxqpdygfblzhckisuranjmwx' },  -- these keys can come up as hints, i set all 26 alphabets
		-- event = 'VimEnter',
		event = 'CursorMoved',
		keys = {},
		opts = {},
		config = function()
			require('hop').setup()
			vim.keymap.set('n', '<leader>f', ':HopWord<CR>')
		end
	},

}
