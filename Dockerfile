FROM debian:bookworm

RUN apt-get update 
RUN apt-get install -y wget libzip-dev apt-transport-https lsb-release ca-certificates git curl software-properties-common
RUN apt-get -y install libxpm4 libxrender1 libgtk2.0-0 libnss3 libgconf-2-4
RUN apt-get -y install -y gconf-service libasound2 libatk1.0-0 libcairo2 libcups2 libfontconfig1 libgdk-pixbuf2.0-0 libgtk-3-0 libnspr4 libpango-1.0-0 libxss1 fonts-liberation libappindicator1 libnss3 lsb-release xdg-utils
RUN apt-get install -y g++ build-essential

### Install NodeJS
RUN curl -sL https://deb.nodesource.com/setup_20.x | bash -
RUN apt-get install -y nodejs

### Install Redis
RUN apt-get install -y redis-server

### Install PHP
RUN wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg
RUN echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main"> /etc/apt/sources.list.d/php.list
RUN apt-get update
RUN apt-get install --no-install-recommends -y php8.3 libapache2-mod-php8.3 php8.3-mysql php8.3-curl php8.3-gd php8.3-msgpack php8.3-memcached php8.3-intl php8.3-sqlite3 php8.3-gmp php8.3-mbstring php8.3-redis php8.3-xml php8.3-zip php8.3-soap php8.3-igbinary

### Install Composer
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php composer-setup.php \
    && php -r "unlink('composer-setup.php');" \
    && mv composer.phar /usr/bin/composer \
    && chmod +x /usr/bin/composer
RUN php -v
