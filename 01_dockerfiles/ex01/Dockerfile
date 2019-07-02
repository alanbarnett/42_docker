FROM debian

# Make sure everything is up to date, download necessary programs
RUN apt-get update && \
	apt-get -y upgrade && \
	apt-get install -y wget bzip2

# Make the teamspeak user
# The --gecos flag is to make it use default variables
RUN adduser --disabled-login --gecos '' teamspeak

# cd into teamspeak home
WORKDIR /home/teamspeak

# Download, extract, and remove server archive tarball
RUN wget http://dl.4players.de/ts/releases/3.8.0/teamspeak3-server_linux_amd64-3.8.0.tar.bz2 && \
	tar -xv --strip-components 1 -f teamspeak3-server_linux_amd64-3.8.0.tar.bz2 && \
	rm teamspeak3-server_linux_amd64-3.8.0.tar.bz2

# Accept license
ENV TS3SERVER_LICENSE=accept

# Run server on start
ENTRYPOINT ["sh", "ts3server_minimal_runscript.sh"]

# To build and run:
# docker build -t teamspeak .
# docker run --rm -it -p 9987:9987/udp -p 10011:10011 -p 30033:30033 teamspeak
