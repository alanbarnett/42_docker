# An Archlinux base with a C development environment

FROM archlinux/base

# Update the system, and install a basic C environment
RUN pacman --noconfirm -Syu \
	gcc \
	lldb \
	make

# To build:
# docker build -t alan328/arch:c-base .
# To run:
# docker run --rm -it alan328/arch:c-base
