# Docker Trusty LAMP Image
Docker image that installs Ubuntu Trusty and a LAMP environment
- Ubuntu 14.04
- Apache2
- MySQL (Ver 14.14 Distrib 5.5.52)
- PHP (Ver 5.5.9)

Setup
-----
1. Clone the repository
```
git clone https://github.com/wlalele/trusty_lamp.git
```

2. Change Directory
```
cd trusty_lamp
```

3. Edit the Dockerfile (if you want/need) -
_You can change the name of the non-root unix user that is going to be created and the root password for MySQL._

4. Build image from Dockerfile
```
docker build -t="trusty_lamp" .
```

5. Run image with tcp 80 redirect
```
docker run -d -p 80:80 -i -t trusty_lamp
```

You should see a container running when you type:
```
docker ps
```

To access the container ssh:
```
docker attach {container_id / container_name}
```

You can start all servers with a script located on the root dir
```
./start_servers
```
