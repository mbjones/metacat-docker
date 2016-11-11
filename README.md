# Docker configuration for building a standalone Metacat install

**WORK IN PROGRESS: This Docker configuration is not yet complete, and should not be relied upon.**
The configuration currently includes some locally hardcoded data specific to my system, which will be replaced.

## Using docker-compose
Metacat ships with a docker-compose.yaml file that configures metacat to be run in docker containers using the default containers from docker hub for Tomcat and Postgres.  Configuration information for usernames and passwords to be used is passed through environment variables.  On a machine on which Docker is installed, Metacat can be launched and shut down using the following command:

```bash
# Bring up metacat, with persistant state in volumes which are created if they don't yet exist
$ export ADMIN="uid=jones,o=NCEAS,dc=ecoinformatics,dc=org"
$ export ADMINPASS='admin-password-goes-here'
$ PGUSER=metacat PGPASS=db-password-goes-here PGDB=metacat docker-compose -p metacat up -d

# Bring down the metacat server containers
$ docker-compose -p metacat down
```

## Using standalone docker containers
The docker-compose utility is useful for configuring multiple containers.  The sections below explain the manual approach to bringing up those same containers.

### Network

- create a bridge network for all containers to communicate over

```bash
docker network create --driver bridge mc-net
```

### Postgres
This creates a data-only volume called 'mc-data' to contain the data for postgres, which is then mounted and used with the volume command.  When the `mc-postgres` container starts, it uses the `mc-data` volume. Even if the `mc-postgres` container is completely deleted, it is completely restartable because of the persistence of the data container.

```bash
docker volume create --name mc-pgdata
docker run --name mc-postgres --net=mc-net -p 5432:5432 -v mc-pgdata:/pgdata -e POSTGRES_PASSWORD=db-password-goes-here -e POSTGRES_USER=metacat -e POSTGRES_DB=metacat -e PGDATA=/pgdata -d postgres
```
- Connect with: psql -h {docker-machine-ip} metacat metacat
- Logs: `docker logs mc-postgres | more`

### Tomcat
Same idea with tomcat.  Mount a data-only volume container for the /var/metacat partition.
```bash
docker volume create --name mc-data
docker run --name mc-tomcat --net=mc-net -v mc-data:/var/metacat -p 8080:8080 -v ${HOME}/tomcat/apache-tomcat-8.0.30/webapps:/usr/local/tomcat/webapps -d tomcat:8.0
```
- Connect to http://${docker-machine-ip}:8080
- Errors to be fixed:
    - DataONE Config: Cannot locate configuration source file:///etc/dataone/node.properties

### Configure Metacat

- Run password utility from local webapps dir, copy password.xml file into webapps dir
- From mc-tomcat, copy password.xml file to /var/metacat/users
- MetacatUI is at: http://${docker-machine-ip}:8080/metacatui
