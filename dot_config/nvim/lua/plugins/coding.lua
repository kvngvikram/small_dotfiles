return {

	{
		'numToStr/Comment.nvim',
		keys = 'g',
		opts = {},
	},


	{
		'jpalardy/vim-slime',
		config = function()
			vim.g.slime_no_mappings = 1
			vim.g.slime_target = 'tmux'
			vim.opt.shell = '/bin/sh'  -- set the default shell since fish is very slow
			-- vim.g.slime_paste_file = '~/.temp_vim-slime_paste.delete_please'
			vim.cmd('let g:slime_default_config = {"socket_name": "default", "target_pane": ":.1"}') -- check github page for this
			vim.g.slime_dont_ask_default = 1
		end,
		ft = { 'python', 'sh' },  -- add more files when required
	},

	{
		'lewis6991/gitsigns.nvim',
		-- event = 'VimEnter',
		-- event = 'UIEnter',
		event = 'CursorHold',  -- basically after you open and wait for few seconds of 'updatetime'
		keys = {
			{'[g', '<cmd>Gitsigns prev_hunk<CR><Esc>:Gitsigns preview_hunk<CR>'},
			{']g', '<cmd>Gitsigns next_hunk<CR><Esc>:Gitsigns preview_hunk<CR>'},
		},
		cmd = 'Gitsigns',
		opts = {},
		-- config = function()
		-- 	require('gitsigns').setup()
		-- 	vim.keymap.set({'n', 'v'}, '[g', ':Gitsigns prev_hunk<CR><Esc>:Gitsigns preview_hunk<CR>')
		-- 	vim.keymap.set({'n', 'v'}, ']g', ':Gitsigns next_hunk<CR><Esc>:Gitsigns preview_hunk<CR>')
		-- 	vim.keymap.set('n', '<Leader>g', ':Gitsigns preview_hunk<CR>')
		-- end
	},

}
