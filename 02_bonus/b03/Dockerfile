# An installation of my dotfiles, on an Archlinux base with my 42 library and
# other programs

FROM alan328/arch:42

# Update, and install programs I need/want/use
RUN pacman --noconfirm -Syu && pacman --noconfirm -S \
	neofetch \
	neovim

# Clone my prompt theme tool
RUN git clone https://github.com/alan23394/ptheme ~/bin/ptheme

# Clone my dotfiles, and symlink the necessary config files
RUN git clone https://github.com/alan23394/dotfiles ~/dotfiles && \
	mkdir ~/.config && \
	ln -s ~/dotfiles/.vim ~/.vim && \
	ln -s ~/dotfiles/themes/laptop/.bashrc ~/.bashrc && \
	ln -s ~/dotfiles/themes/laptop/.config/nvim ~/.config/nvim
