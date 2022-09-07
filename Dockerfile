FROM ruby:3.1.2

# Atualização do sistema
RUN apt-get update

RUN apt-get install -y build-essential \
                       autoconf \
                       libssl-dev \
                       libyaml-dev \
                       libreadline-dev \
                       zlib1g-dev \
                       libpq-dev \
                       curl \
                       ruby-full \
                       git-core \
                       libsqlite3-dev \
                       sqlite3 \
                       libxml2-dev \
                       libxslt1-dev \
                       libcurl4-openssl-dev \
                       software-properties-common \
                       libgdbm-dev \
                       libncurses5-dev \
                       automake \
                       libtool \
                       bison \
                       libffi-dev \
                       libpq-dev \
                       postgresql-client

# Set timezone
RUN cp /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime
RUN echo "America/Sao_Paulo" >  /etc/timezone

# Update CA Certificates
RUN update-ca-certificates

#Install nodejs e yarn for rails 6.0
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash -
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update && apt-get install -y nodejs yarn

# Set rails env variable
ARG bundle_options_var='--without development test'

# Application path inside container
ENV APP_ROOT /api

# Create application folder
RUN mkdir $APP_ROOT

# Set command execution path
WORKDIR $APP_ROOT

# Copy all project files to application folder inside container
COPY .$APP_ROOT $APP_ROOT

# Install gems
RUN gem install bundler -v 2.1.4
RUN bundle update