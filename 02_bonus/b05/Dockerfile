# A colorful cow saying a fortune

FROM archlinux/base

RUN pacman --noconfirm -Syu && pacman --noconfirm -S fortune-mod cowsay lolcat

CMD fortune | cowsay | lolcat
