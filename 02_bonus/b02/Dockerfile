# An archlinux container with my 42 programs installed
# My fillit, ft_ls, and minishell are installed

FROM alan328/arch:c-libft

# make systemlibft uses the libft I installed in the c-libft image instead of
# cloning and building it's own

# Clone, make, and install my fillit
# It doesn't use the system libft, because I haven't updated it to that version
# Give it some test files as well
RUN git clone https://github.com/alan23394/fillit /usr/local/src/fillit && \
	make -C /usr/local/src/fillit all clean && \
	ln -s /usr/local/src/fillit/fillit /usr/local/games && \
	ln -s /usr/local/src/fillit/fillit.files /usr/local/share/fillit.files

# Clone, make, and install my ft_ls
RUN git clone https://github.com/alan23394/ft_ls /usr/local/src/ft_ls && \
	make -C /usr/local/src/ft_ls systemlibft clean && \
	ln -s /usr/local/src/ft_ls/ft_ls /usr/local/bin/

# Clone, make, and install my minishell
RUN git clone https://github.com/alan23394/flash /usr/local/src/flash && \
	make -C /usr/local/src/flash systemlibft clean && \
	ln -s /usr/local/src/flash/minishell /usr/local/bin/flash

# To build:
# docker build -t alan328/arch:42 .
# To run:
# docker run --rm -it alan328/arch:42
