FROM tomcat:8.0
MAINTAINER Matthew B. Jones <jones@nceas.ucsb.edu>

RUN apt-get update && apt-get install -y --no-install-recommends \
        vim \
    && rm -rf /var/lib/apt/lists/*

# COPY the Metacat distribution to the container

# Add configuration data for an admin account 
# TODO: isolate pw file out of the image
COPY config /config

CMD ["/config/config.sh"]
