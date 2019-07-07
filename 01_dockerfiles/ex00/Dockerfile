# Resources:
# https://wiki.alpinelinux.org/wiki/Alpine_Linux_package_management
# https://goinbigdata.com/docker-run-vs-cmd-vs-entrypoint/

FROM alpine

# Update, upgrade, install neovim
RUN apk update && apk upgrade && apk add neovim

# Set nvim as the command to run when starting the container
ENTRYPOINT ["nvim"]

# To build and run:
# docker build -t nvim:alpine .
# docker run --rm -it nvim:alpine
