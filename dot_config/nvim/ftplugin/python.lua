vim.cmd('let g:slime_cell_delimiter = "# --"')

vim.cmd('let g:slime_python_ipython = 1')

vim.cmd [[
nnoremap <Leader>^ :!tmux split-window -d -h -p 45 <CR><CR>
			\:execute 'SlimeSend1 ipython --matplotlib=qt'<CR>
			\:execute 'SlimeSend1 cd ' getcwd()<CR>
]]
			-- \:SlimeSend1 clear<CR>
-- Instead of execute SlimeSend0 can also be used as:- :SlimeSend0 'cd '.getcwd()<CR>
-- But I don't know how to send an <Enter>

-- TODO can we use <C-O> instead of marking with z?
-- But that will mess up the jump lists
vim.keymap.set('n', '<CR>', 'V<Plug>SlimeRegionSendj')
vim.keymap.set('v', '<CR>', '<Plug>SlimeRegionSendj')
vim.keymap.set('n', '<leader><CR>', 'mzVgg<Plug>SlimeRegionSend`zzz')
vim.keymap.set('n', '<Leader>r', 'mzggVG<Plug>SlimeRegionSend`zzz')
vim.keymap.set('n', '<A-CR>', 'mzviw<Plug>SlimeRegionSend`z')
vim.keymap.set('n', '<Leader>p', '<Plug>SlimeSendCell')
