# $(CURDIR) will give the path to directory in which Makefile is present
default:
	echo possible options are: link, force, binaries, 
link:
	ln -s $(CURDIR)/home_dots/.bashrc ~/.bashrc
	ln -s $(CURDIR)/home_dots/.condarc ~/.condarc

	ln -s $(CURDIR)/home_dots/.tmux.conf ~/.tmux.conf

	mkdir -p ~/.local/share
	mkdir -p ~/Pictures/icons

	ln -s $(CURDIR)/dot_local_share/nvim/ ~/.local/share/nvim
	ln -s $(CURDIR)/dot_local_share/blesh/ ~/.local/share/blesh

	mkdir -p ~/.config

	ln -s $(CURDIR)/dot_config/nvim/       ~/.config/nvim
	ln -s $(CURDIR)/dot_config/lf/         ~/.config/lf
	ln -s $(CURDIR)/dot_config/lazygit/    ~/.config/lazygit
	ln -s $(CURDIR)/dot_config/pip/        ~/.config/pip
	ln -s $(CURDIR)/dot_config/fzf/        ~/.config/fzf
	ln -s $(CURDIR)/dot_config/pycodestyle ~/.config/pycodestyle

force:
	ln -sf $(CURDIR)/home_dots/.bashrc ~/.bashrc
	ln -sf $(CURDIR)/home_dots/.condarc ~/.condarc

	ln -sf $(CURDIR)/home_dots/.tmux.conf ~/.tmux.conf

	mkdir -p ~/.local/share

	rm -rf ~/.local/share/nvim   2> /dev/null  && ln -sf $(CURDIR)/dot_local_share/nvim/ ~/.local/share/nvim
	rm -rf ~/.local/share/blesh  2> /dev/null  && ln -sf $(CURDIR)/dot_local_share/blesh/ ~/.local/share/blesh

	mkdir -p ~/.config

	rm -rf ~/.config/nvim    2> /dev/null  && ln -sf $(CURDIR)/dot_config/nvim/       ~/.config/nvim
	rm -rf ~/.config/lf      2> /dev/null  && ln -sf $(CURDIR)/dot_config/lf/         ~/.config/lf
	rm -rf ~/.config/lazygit 2> /dev/null  && ln -sf $(CURDIR)/dot_config/lazygit/    ~/.config/lazygit
	rm -rf ~/.config/pip     2> /dev/null  && ln -sf $(CURDIR)/dot_config/pip/        ~/.config/pip
	rm -rf ~/.config/fzf     2> /dev/null  && ln -sf $(CURDIR)/dot_config/fzf/        ~/.config/fzf
	ln -sf $(CURDIR)/dot_config/pycodestyle ~/.config/pycodestyle

binaries:
	mkdir -p ~/bin
	cp $(CURDIR)/bin/* ~/bin/
	echo make links for other AppImages using appimages option

aegis:
	~/installs_and_builds/miniconda3/bin/python3 -m venv ~/installs_and_builds/python_venv/aegis
	~/installs_and_builds/python_venv/aegis/bin/pip install -r $(CURDIR)/misc/Aegis-decrypt-master/requirements.txt
