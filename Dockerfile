FROM tomcat:8.0-jre8
MAINTAINER Matthew B. Jones <jones@nceas.ucsb.edu>

RUN apt-get update && apt-get install -y --no-install-recommends \
        vim \
    && rm -rf /var/lib/apt/lists/*

# COPY the Metacat distribution to the container
COPY dist/metacat-2.8.4/metacat.war /usr/local/tomcat/webapps
COPY dist/metacat-2.8.4/metacat-index.war /usr/local/tomcat/webapps
COPY dist/metacat-2.8.4/metacatui.war /usr/local/tomcat/webapps

# Add configuration data for an admin account 
# TODO: isolate pw file out of the image
COPY config /config

ENV PATH /usr/local/bin:$PATH
COPY docker-entrypoint.sh /usr/local/bin/
RUN ln -s usr/local/bin/docker-entrypoint.sh / # backwards compat
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]

EXPOSE 8080
CMD ["catalina.sh", "run"]
