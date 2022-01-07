# SVN-webdav

Lightweight Webdav Apache Subversion server based on Alpine Linux. The access to the server is possible only via WebDav protocol (http://).

## How to use this image.

### Docker CLI
To run the image, you can use the following command:

```
docker run -d --name svn-webdav --restart always \
-p 8888:80 \
-v svn-config:/srv/svn/conf.d \
-v $PWD./repos:/srv/svn/repos rvva/svn-webdav:latest
```
Where volume mount ```$pwd/repos``` is location for new or existing repositories.

### Compose
Example usage with docker-compose:
```
version: '3.7'
services:
  svn-webdav:
    build: .
    image: rvva/svn-webdav:latest
    restart: always
    container_name: svn-webdav
    networks:
       - internal
    ports:
       - 8888:80
    volumes:
       - ./repos:/srv/svn/repos:rw
       - svn-conf:/srv/svn/conf.d
networks:
    internal:
        name: internal
        external: true
volumes:
  svn-conf:
```

## Configuration
### Create username and password
Access control is carried out using a login and password.
To create a new user and add it to the existence of the passwd file, execute the command:
```
docker exec -it svn-webdav htpasswd -mb /srv/svn/conf.d/passwd USERNAME PASSWORD
```
### Create repository
To create a repository, execute the command:
```
docker exec -it svn-webdav svnadmin create /srv/svn/repos/repository_name
```
