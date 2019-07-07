# Resources:
# https://guides.rubyonrails.org/getting_started.html
# https://stackoverflow.com/questions/34863114/dockerfile-onbuild-instruction#34865361

FROM ruby

# Make sure everything is up to date, download necessary programs
RUN apt-get update && \
	apt-get -y upgrade && \
	apt-get -y install nodejs

# Install rails
RUN gem install rails

# Copy app to /opt/app
ONBUILD COPY app /opt/app
# Move our working directory to the new folder
ONBUILD WORKDIR /opt/app

# Update bundle
ONBUILD RUN bundle update
# Install gem dependencies
ONBUILD RUN bundle install

# Migrate the database
ONBUILD RUN rake db:migrate
# Seed the new database
ONBUILD RUN rake db:seed

# To build:
# docker build -t ft-rails:on-build .
