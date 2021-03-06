FROM tomcat:8.0-jre8
MAINTAINER Matthew B. Jones <jones@nceas.ucsb.edu>

ARG METACAT_VERSION=2.8.7

ADD dist/metacat-bin-${METACAT_VERSION}.tar.gz /tmp

RUN apt-get update && apt-get install -y --no-install-recommends \
        vim \
        python-bcrypt \
    && rm -rf /var/lib/apt/lists/* \
    && cp /tmp/metacat.war /tmp/metacat-index.war /tmp/metacatui.war /usr/local/tomcat/webapps


# Add configuration data for an admin account 
# TODO: isolate pw file out of the image
COPY config /config

ENV PATH /usr/local/bin:$PATH
COPY docker-entrypoint.sh /usr/local/bin/
RUN ln -s usr/local/bin/docker-entrypoint.sh / # backwards compat
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]

EXPOSE 8080
CMD ["catalina.sh", "run"]
