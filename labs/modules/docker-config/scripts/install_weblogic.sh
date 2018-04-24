sudo apt-get update -y

sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common -y 

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable" -y
sudo apt-get update -y
sudo apt-get install docker-ce -y

# Need to get Java in a container running first
# OracleJava java-8 
# server-jre-8u161-linux-x64.tar
cd /tmp/OracleJava/java-8/
chmod +x build.sh
sudo sh build.sh

# instead of doing this only include the necessary files for the docker images
# git clone --depth=1 https://github.com/oracle/docker-images.git 
# OracleWebLogic dockerfiles 12.2.1 folder
# fmw_12.2.1.0.0_wls_quick_Disk1_1of1
# fmw_12.2.1.0.0_wls_supplemental_quick_Disk1_1of1

# this is found in dockerfiles root
cd /tmp/OracleWebLogic/dockerfiles/
chmod +x buildDockerImage.sh
sudo sh buildDockerImage.sh  -d

chmod 777 /tmp/OracleWebLogic/samples/1221-domain/container-scripts/*

# cd into the samples/1221-domain
cd /tmp/OracleWebLogic/samples/1221-domain
sudo docker build -t 1221-domain --build-arg ADMIN_PASSWORD=welcome1 --build-arg ADMIN_NAME=WL_AdminServer .
sudo docker run -d --name wlsadmin --hostname wlsadmin -p 7001:7001 1221-domain

# using to mount shared folder 
# docker run -v /media/sf_Shared:/shared -d --name wlsadmin --hostname wlsadmin -p 7001:7001 1221-domain 

# sudo docker exec -it -u root wlsadmin wlst /u01/oracle/deploy_app.py 

# don't have to run this but I can ;)
# docker run -d --link wlsadmin:wlsadmin -p 7002:7002 1221-domain createServer.sh

# could use this command or run something locally? 
# docker exec -it <container name> <command>

# with root 
# docker exec -ti -u root container_name /bin/bash
