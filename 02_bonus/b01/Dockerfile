# An archlinux container with C build tools and my 42 library installed

FROM alan328/arch:c-base

# Update everything, and install git
RUN pacman --noconfirm -Syu && pacman --noconfirm -S \
	git

# Add /usr/local/lib to the linker's loader path
RUN echo "/usr/local/lib" > /etc/ld.so.conf.d/local.conf

# Clone, make and install my libft
# make so clean compiles the library into a shared object, then cleans the .o's
# Leave the sources so I may see them later
# Reconfigure the linker to see the new library
RUN git clone https://github.com/alan23394/libft /usr/local/src/libft && \
	cd /usr/local/src/libft && \
	make so clean && \
	ln -s /usr/local/{src/libft/includes/*.h,include} && \
	cd /usr/local/lib && \
	ln -s /usr/local/src/libft/libft.so.1.0.0 . && \
	ln -s libft.so.1.0.0 libft.so.1 && \
	ln -s libft.so.1 libft.so && \
	ldconfig

# To build:
# docker build -t alan328/arch:c-libft .
# To run:
# docker run --rm -it alan328/arch:c-libft
