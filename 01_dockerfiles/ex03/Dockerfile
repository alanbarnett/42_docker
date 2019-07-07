# Resources:
# https://about.gitlab.com/install/#ubuntu
# https://gitlab.com/gitlab-org/omnibus-gitlab/issues/2229
# https://docs.gitlab.com/omnibus/settings/ssl.html#lets-encrypthttpsletsencryptorg-integration
# https://docs.gitlab.com/omnibus/settings/nginx.html#manually-configuring-https
# https://www.digitalocean.com/community/questions/how-to-set-up-gitlab-with-ssl-correctly
# https://stackoverflow.com/questions/10175812/how-to-create-a-self-signed-certificate-with-openssl
# https://www.shellhacks.com/create-csr-openssl-without-prompt-non-interactive/
# https://docs.gitlab.com/ee/administration/restart_gitlab.html#omnibus-gitlab-reconfigure
# https://gitlab.com/gitlab-org/omnibus-gitlab/issues/430

FROM ubuntu:latest

# Initial upgrade
RUN apt-get update && apt-get -y upgrade
# Get more dependencies
RUN apt-get -y install curl ca-certificates openssh-server tzdata
# Run script to set up repository, and get extra dependencies
RUN curl -L https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.deb.sh | bash
# Install gitlab-ce, now that the repo is set up properly
RUN apt-get -y install gitlab-ce

# Generate our keys for HTTPS
RUN openssl req \
	-subj "/C=US/ST=California/L=Fremont/O=42School/OU=Docker/CN=www.abarnett.com" \
	-nodes -newkey rsa:2048 -keyout gitlab.abarnett.com.key \
	-x509 -days 30 -out gitlab.abarnett.com.crt
# Move our new keys
RUN mkdir -p /etc/gitlab/ssl && \
	chmod 700 /etc/gitlab/ssl && \
	mv gitlab.abarnett.com.key gitlab.abarnett.com.crt /etc/gitlab/ssl
# Tweak some settings for HTTPS
RUN mv /etc/gitlab/gitlab.rb /etc/gitlab/gitlab.rb.orig
COPY gitlab.rb /etc/gitlab/gitlab.rb

# Start runsvdir, which needs to be running in the background
# Also run the reconfigure portion, which takes a very long time.
RUN (/opt/gitlab/embedded/bin/runsvdir-start &) && gitlab-ctl reconfigure

# Expose ports for HTTPS, SSH, and the normal website
EXPOSE 443 22 80

# Command for main image, start gitlab
CMD (/opt/gitlab/embedded/bin/runsvdir-start &) && gitlab-ctl start && gitlab-ctl tail
