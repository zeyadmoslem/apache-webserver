FROM php:7.4-apache

ENV TZ=Europe/Berlin
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone


COPY --from=composer:2 /usr/bin/composer /usr/bin/composer
#COPY --chown=1000:www-data . /var/www/html
COPY ./docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

# Update apt-get and install some basic php extensions
RUN apt-get update -y && apt-get install -y curl \
  libcurl4-openssl-dev \
  git \
  nano \
  zlib1g-dev \
  ghostscript \
  graphicsmagick \
  imagemagick \
  libpng-dev \
  libfreetype6-dev \
  libjpeg62-turbo-dev \
  libxml2-dev \
  libzip-dev \
  libicu-dev \
  locales \
  wget \
  cron \
  && docker-php-ext-install pdo_mysql mysqli curl zip intl \
  && docker-php-ext-configure gd --with-freetype --with-jpeg \
  && docker-php-ext-install gd soap \
  && a2enmod rewrite

RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    sed -i -e 's/# de_DE.UTF-8 UTF-8/de_DE.UTF-8 UTF-8/' /etc/locale.gen && \
    sed -i -e 's/# fr_FR.UTF-8 UTF-8/fr_FR.UTF-8 UTF-8/' /etc/locale.gen && \
    sed -i -e 's/# cs_CZ.UTF-8 UTF-8/cs_CZ.UTF-8 UTF-8/' /etc/locale.gen && \
    sed -i -e 's/# zh_CN.UTF-8 UTF-8/zh_CN.UTF-8 UTF-8/' /etc/locale.gen && \
    sed -i -e 's/# tr_TR.UTF-8 UTF-8/tr_TR.UTF-8 UTF-8/' /etc/locale.gen && \
    dpkg-reconfigure --frontend=noninteractive locales

RUN apt-get clean -y && a2enmod rewrite

RUN service apache2 restart

ENTRYPOINT ["docker-entrypoint.sh"]
