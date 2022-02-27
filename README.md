# twisted-honeypots

SSH, FTP and Telnet honeypot services based on the [Twisted](http://twistedmatrix.com/) engine for Python 3.
All credentials are stored on a local MySQL database.

This will create easily (and painlessly) very good dictionaries to use for pentesting.

## What this is about ##
I just am collecting the needs to create a Dockerfile and a public image. The steps below will be scripted and archived. 

## docker-compose ##
It is highly recommended to start with an image that already has the basic needs: mariadb. We will as an example start with linuxserver/mariadb, based on Alpine.
You can use your own image with Debian or whatnot, but the guide below is for Alpine (`apk`) only.

Create a `docker-compose.yml` like so:
```version: "3"
services:
  twisted:
    image: linuxserver/mariadb
    container_name: twisted
    volumes:
      - ./config:/config
    environment: 
      TZ: ${TZ}
      PUID: 1000
      PGID: 1000
      MYSQL_ROOT_PASSWORD: "changeme"
      MYSQL_LOG_CONSOLE: "true"
      MYSQL_DATABASE: "pot_db"
      MYSQL_USER: "pot_user"
      MYSQL_PASSWORD: "changeme"
    ports:
      - "21:21"
      - "22:22"
      - "23:23"
    restart: unless-stopped
```
Now start it, then access it to install the rest as root:
`docker exec -it twisted bash`

## Requisites ##
There is a bunch of pre-requisites that were missing from the original repo.
```export PATH=$PATH:/root/.local/bin
apk --update --upgrade add git python3 py3-pip python3-dev curl sudo geoip libc-dev linux-headers libffi-dev openssl-dev
```

## Install ##

```git clone https://github.com/lanjelot/twisted-honeypots /opt/twisted-honeypots
cd /opt/twisted-honeypots
./install.sh && ./setup-db.sh
```

# Usage #

To start/stop the services:

```bash
./start.sh
./stop.sh
```


To monitor the current execution:

```bash
./monitor.sh
```

![preview](https://i.imgur.com/5p4GR5z.png)


To extract the login/passwords in a wordlist sorted by best popularity:

```bash
source vars.sh
# logins
echo "select distinct login from pot group by login order by count(login) desc" | mysql -rs -u${MYSQL_USER} -p${MYSQL_PWD} ${MYSQL_DB}
# passwords
echo "select distinct password from pot group by password order by count(password) desc" | mysql -rs -u${MYSQL_USER} -p${MYSQL_PWD} ${MYSQL_DB}
```
