-- Check and install lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- do this before loading lazy.nvim
vim.g.mapleader = ' '  -- mapping space as leader
vim.g.maplocalleader = ' '

require('lazy').setup('plugins')

-- This will mainly have keymaps and basic options, not the plugin options
-- using lazy.nvim


vim.opt.updatetime = 2000  -- CursorHold event is triggerend if cursor doesn't move for this time
-- updatetime is used in lsp diagnostics, and for lazy loading plugins with CursorHold event !!

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.swapfile = false
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.schedule(function()
	vim.opt.clipboard = 'unnamedplus'
end)
-- vim.opt.autochdir = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.cursorline = true
vim.opt.colorcolumn = '80'
vim.opt.spellfile = '/home/happy/.config/nvim/spell/en.utf-8.add'  -- don't give ~/ for home

vim.opt.signcolumn = 'auto:2'

vim.opt.background = 'dark'
vim.cmd('colorscheme retrobox')


local function vim_opt_toggle(opt, val_1, val_2, name)  -- toggle between the two values
	local message = name
	if vim.opt[opt]:get() == val_2 then
		vim.opt[opt] = val_1
		message = message .. " Enabled"
	else
		vim.opt[opt] = val_2
		message = message .. " Disabled"
	end
	vim.notify(message)
end

vim.keymap.set('i', 'kj', '<Esc>:w<CR>')
vim.keymap.set('n', '<leader><leader>', ':w<CR>')

vim.keymap.set('n', '<leader>o', 'mzo<Esc>`z')
vim.keymap.set('n', '<leader>O', 'mzO<Esc>`z')

vim.keymap.set('n', '<leader>sp', function() vim_opt_toggle("spell", true, false, "Spell checks") end)
vim.keymap.set('n', '<Leader>sn', ':tabnew ~/.config/nvim/snippets/<CR>')

vim.keymap.set('n', '<leader>w', function() vim_opt_toggle("wrap", true, false, "Line warping") end)
vim.keymap.set('n', '<leader>,', ':tabnew ~/.config/nvim/init.lua<CR>')
vim.keymap.set('n', '<leader>/', ':noh<CR>')

-- change split sizes
vim.keymap.set('n', '<C-h>', '<C-w><')
vim.keymap.set('n', '<C-j>', '<C-w>+')
vim.keymap.set('n', '<C-k>', '<C-w>-')
vim.keymap.set('n', '<C-l>', '<C-w>>')

-- Map j,k so that it will move DOWN,UP line by line for long wrapped lines.
-- Also Mapping for navigation using relative numbers when lines are wrapped
-- Refer: https://vi.stackexchange.com/a/16944
vim.cmd('nnoremap <expr> j v:count == 0 ? "gj" : "<Esc>".v:count."j"')
vim.cmd('nnoremap <expr> k v:count == 0 ? "gk" : "<Esc>".v:count."k"')

-- Visual search
vim.cmd [[
vnoremap // "zy/\V<C-R>=escape(@z,'/\')<CR><CR>
]]
-- for '\V' refer :help /\V

vim.cmd('autocmd BufLeave,BufWinLeave * silent! mkview')
vim.cmd('autocmd BufReadPost * silent! loadview')

-- for neovide !!
if vim.g.neovide then
	vim.opt.guifont = "Hasklug Nerd Font"
	-- vim.opt.neovide_cursor_animate_command_line = false
end
