FROM ruby:2.3

# Setup build variables
ARG RAILS_ENV=production

# Set up environmental variables - do all in one go to reduce cache layers (see https://docs.docker.com/engine/reference/builder/#env)
# Default to UTF-8 file.encoding
# see https://bugs.debian.org/775775
# and https://github.com/docker-library/java/issues/19#issuecomment-70546872
ENV RAILS_ENV="$RAILS_ENV" \
    LANG=C.UTF-8 \
    JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/jre \
    RAILS_LOG_TO_STDOUT=yes_please \
    PATH=/fits/fits-1.0.2/:$PATH \
    BUNDLE_JOBS=2 \
    APP_PRODUCTION=/willow.production/ \
    APP_WORKDIR="/willow.$RAILS_ENV" \
    SAMVERA_DIR="./willow/"

# Add backports to apt-get sources
# Install libraries, dependencies, java and fits

RUN echo 'deb http://deb.debian.org/debian jessie-backports main' > /etc/apt/sources.list.d/jessie-backports.list \
    && apt-get update -qq \
    && apt-get install -y --no-install-recommends \
    libpq-dev libmediainfo-dev \
    libxml2-dev libxslt1-dev \
    libqt4-webkit libqt4-dev xvfb \
    nodejs \
    imagemagick \
    libreoffice \
    ghostscript \
    ffmpeg \
    ufraw \
    bzip2 unzip xz-utils \
    # install open-jdk and ca-certs from jessie-backports
    && apt-get install -t jessie-backports -y --no-install-recommends openjdk-8-jre-headless ca-certificates-java \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && /var/lib/dpkg/info/ca-certificates-java.postinst configure

RUN mkdir -p /fits/ \
    && wget -q https://s3.eu-west-2.amazonaws.com/rdss-institutional-ecs-clusters-objects-public/rdss-samvera-dependencies/fits-1.0.2.zip -O /fits/fits-1.0.2.zip \
    && unzip -q /fits/fits-1.0.2.zip -d /fits \
    && chmod a+x /fits/fits-1.0.2/fits.sh \
    && rm /fits/fits-1.0.2.zip

# copy the application
COPY $SAMVERA_DIR $APP_PRODUCTION
COPY $SAMVERA_DIR/docker-entrypoint.sh /bin/

# install gems to system - use flags dependent on RAILS_ENV
RUN cd $APP_PRODUCTION && \
    bundle config build.nokogiri --use-system-libraries \
    && if [ "$RAILS_ENV" = "production" ]; then \
            bundle install --without test:development; \
        else \
            bundle install --without production --no-deployment; \
        fi \
    && mv Gemfile.lock Gemfile.lock.built_by_docker

# copy the seeds
COPY $SAMVERA_DIR/seed /seed

# create a folder to store derivatives
RUN mkdir -p /derivatives

# use the just built Gemfile.lock, not the one copied into the container and verify the gems are correctly installed
RUN cd $APP_PRODUCTION \
    && mv Gemfile.lock.built_by_docker Gemfile.lock \
    && bundle check

# generate production assets if production environment
RUN if [ "$RAILS_ENV" = "production" ]; then \
        cd $APP_PRODUCTION \
        && SECRET_KEY_BASE_PRODUCTION=0 ASSET_PRECOMPILATION_ADAPTER=sqlite3 bundle exec rake -v --trace=stdout assets:clean assets:precompile; \
    fi

# Generate the version file without caching
ARG CACHEBUST=1
COPY ./.git $APP_PRODUCTION/.git
COPY $SAMVERA_DIR/rdss-samvera-version.sh $APP_PRODUCTION
RUN cd $APP_PRODUCTION && \
    mkdir -p /version_info && \
    ./rdss-samvera-version.sh "/version_info/version.rb" && \ 
    rm -r .git

WORKDIR $APP_WORKDIR

CMD ["/bin/docker-entrypoint.sh"]
