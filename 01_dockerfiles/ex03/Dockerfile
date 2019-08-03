# Resources:
# https://about.gitlab.com/install/#ubuntu
# https://gitlab.com/gitlab-org/omnibus-gitlab/issues/2229
# https://docs.gitlab.com/omnibus/settings/ssl.html
# https://www.digitalocean.com/community/questions/how-to-set-up-gitlab-with-ssl-correctly
# https://stackoverflow.com/questions/10175812/how-to-create-a-self-signed-certificate-with-openssl
# https://www.shellhacks.com/create-csr-openssl-without-prompt-non-interactive/
# https://docs.gitlab.com/ee/administration/restart_gitlab.html#omnibus-gitlab-reconfigure
# https://gitlab.com/gitlab-org/omnibus-gitlab/issues/430
# https://confluence.atlassian.com/fishkb/unable-to-clone-git-repository-due-to-self-signed-certificate-376838977.html
# https://stackoverflow.com/questions/18517189/gitlab-with-non-standard-ssh-port-on-vm-with-iptable-forwarding
# https://hub.docker.com/r/gitlab/gitlab-ce/dockerfile/
# https://serverfault.com/questions/743443/gitlab-not-listening-on-ssh-port
# https://serverfault.com/questions/744643/configuring-docker-ssh-git-access

FROM ubuntu:latest

# Initial upgrade, and dependencies
RUN apt-get update && apt-get -y upgrade && apt-get -y install \
	curl \
	ca-certificates \
	openssh-server \
	tzdata
# Run script to set up repository, and get extra dependencies
RUN curl -L https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.deb.sh | bash
# Install gitlab-ce, now that the repo is set up properly
RUN apt-get -y install gitlab-ce

# Generate our keys for HTTPS
RUN openssl req \
	-subj "/C=US/ST=California/L=Fremont/O=42School/OU=Docker/CN=gitlab.abarnett.com" \
	-nodes -newkey rsa:2048 -keyout gitlab.abarnett.com.key \
	-x509 -days 365 -out gitlab.abarnett.com.crt
# Move our new keys
RUN mkdir -p /etc/gitlab/trusted-certs && \
	chmod 700 /etc/gitlab/trusted-certs && \
	mv gitlab.abarnett.com.key gitlab.abarnett.com.crt /etc/gitlab/trusted-certs

# Set up sshd, with runit
RUN mkdir -p /opt/gitlab/sv/sshd/supervise && \
	mkfifo /opt/gitlab/sv/sshd/supervise/ok && \
	printf "#!/bin/sh\nexec 2>&1\numask 077\nexec /usr/sbin/sshd -D\n" > /opt/gitlab/sv/sshd/run && \
	chmod 755 /opt/gitlab/sv/sshd/run && \
	ln -s /opt/gitlab/sv/sshd /opt/gitlab/service && \
	mkdir -p /var/run/sshd

# Tweak some settings for HTTPS and SSH
RUN mv /etc/gitlab/gitlab.rb /etc/gitlab/gitlab.rb.orig
COPY gitlab.rb /etc/gitlab/gitlab.rb

# Expose ports for HTTPS, SSH, and the normal website
EXPOSE 443 22 80

# Start runsvdir, which needs to be running in the background
# Also run the reconfigure portion, which takes a very long time.
# Tail command to stop container from exiting, also the logs are convenient
CMD (/opt/gitlab/embedded/bin/runsvdir-start &) && gitlab-ctl reconfigure && gitlab-ctl tail

# To build:
# docker build -t ubuntu:gce .
# To run:
# docker run --rm -it -p 8080:80 -p 8443:443 -p 8022:22 --priveleged ubuntu:gce
