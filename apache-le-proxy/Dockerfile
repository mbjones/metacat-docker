FROM ubuntu:16.04

RUN apt-get update \
    && apt-get install -y git \
       apache2 bc supervisor \
       libapache2-mod-jk

RUN a2enmod proxy_http
RUN a2enmod ssl

RUN git clone https://github.com/certbot/certbot.git

RUN certbot/certbot-auto --non-interactive --help > /dev/null

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

ADD includes/run.sh /run.sh
ADD includes/renew.sh /renew.sh
RUN chmod +x /run.sh
RUN chmod +x /renew.sh

EXPOSE 443
EXPOSE 80

ADD apache_config /etc/apache2/sites-available/

CMD ["/usr/bin/supervisord"]
