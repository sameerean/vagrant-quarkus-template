#!/usr/bin/env bash

# sh ./env-vars.sh
VAGRANT_HOST_DIR=/home/vagrant
PROJECT_ROOT=$VAGRANT_HOST_DIR/workspace

echo "======================================="
echo "Updating CentOs..."
echo "======================================="

sudo yum install -y epel-release
sudo yum install dnf -y
sudo yum -y update
sudo yum install -y net-tools
sudo yum install -y wget
sudo yum -y install unzip
sudo yum -y install git


echo "======================================="
echo "Installing AdoptOpenJDK 8 .."
echo "======================================="

cat <<'EOF' > /etc/yum.repos.d/adoptopenjdk.repo
[AdoptOpenJDK]
name=AdoptOpenJDK
baseurl=http://adoptopenjdk.jfrog.io/adoptopenjdk/rpm/centos/$releasever/$basearch
enabled=1
gpgcheck=1
gpgkey=https://adoptopenjdk.jfrog.io/adoptopenjdk/api/gpg/key/public
EOF

sudo yum install -y adoptopenjdk-8-openj9


echo "======================================="
echo "Installing GraaL VM .."
echo "======================================="

sudo dnf install gcc glibc-devel zlib-devel libstdc++-static

# https://github.com/graalvm/graalvm-ce-builds/releases/download/vm-20.0.0/graalvm-ce-java8-linux-amd64-20.0.0.tar.gz

sudo wget -O /tmp/graalvm-ce-java8.tar.gz https://github.com/graalvm/graalvm-ce-builds/releases/download/vm-20.0.0/graalvm-ce-java8-linux-amd64-20.0.0.tar.gz

# sudo wget -O /tmp/graalvm-ce-java8.tar.gz https://github.com/graalvm/graalvm-ce-builds/releases/download/vm-19.3.0/graalvm-ce-java8-linux-amd64-19.3.0.tar.gz

sudo tar -xvzf /tmp/graalvm-ce-java8.tar.gz -C /usr/lib/jvm/

# sudo mv /tmp/graalvm-ce-java8-19.3.0/ /usr/lib/jvm/

cd /usr/lib/jvm
# sudo ln -s graalvm-ce-java8-19.3.0 graalvm
sudo ln -s graalvm-ce-java8-20.0.0 graalvm

sudo alternatives --install /usr/bin/java java /usr/lib/jvm/graalvm/bin/java 2

sudo /usr/lib/jvm/graalvm/bin/gu install native-image

echo "======================================="
echo "Installing Apache Maven .."
echo "======================================="

sudo wget https://www-us.apache.org/dist/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.tar.gz -P /tmp
sudo tar xf /tmp/apache-maven-3.6.3-bin.tar.gz -C /opt
sudo ln -s /opt/apache-maven-3.6.3 /opt/maven


echo "======================================="
echo "Setting environment variables .."
echo "======================================="

export M2_HOME=/opt/maven

sudo cat <<EOF | sudo tee /etc/profile.d/env_vars.sh
export JAVA_HOME=/usr/lib/jvm/adoptopenjdk-8-openj9/
export GRAALVM_HOME=/usr/lib/jvm/graalvm
export M2_HOME=$M2_HOME
export MAVEN_HOME=$M2_HOME
export PATH=$M2_HOME/bin:$PATH
EOF


#echo "======================================="
#echo "Installing Docker Engine .."
#echo "======================================="
#
## https://docs.docker.com/install/linux/docker-ce/centos/
#
#sudo yum install -y yum-utils \
#  device-mapper-persistent-data \
#  lvm2
#
#sudo yum-config-manager \
#    --add-repo \
#    https://download.docker.com/linux/centos/docker-ce.repo
#
#
#sudo yum install -y docker-ce docker-ce-cli containerd.io
#
#sudo systemctl start docker
#
#echo "======================================="
#echo "Installing Docker Compose .."
#echo "======================================="
#
#
#sudo curl -L "https://github.com/docker/compose/releases/download/1.25.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
#
#sudo chmod +x /usr/local/bin/docker-compose
#
#sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
#
#
#echo "======================================="
#echo "Installing Docker Compose Command-line completion .."
#echo "======================================="
#
## https://docs.docker.com/compose/completion/
#
#sudo curl -L https://raw.githubusercontent.com/docker/compose/1.25.4/contrib/completion/bash/docker-compose -o /etc/bash_completion.d/docker-compose
#
#
#
## Docker Post-installation steps for Linux
#
## Manage Docker as a non-root user
#
## sudo groupadd docker
#getent group docker || groupadd docker
#
#sudo usermod -aG docker $USER
#sudo usermod -aG docker vagrant
#
#newgrp docker 
## su -s ${USER}
#
## Configure Docker to start on boot
#sudo systemctl enable docker
#

# export PATH=${M2_HOME}/bin:${PATH}

# grep -q '^source' /home/vagrant/.bash_profile && sed -i 's/^source.*/source \/etc\/profile\.d\/env_vars\.sh/' /home/vagrant/.bash_profile || echo 'source /etc/profile.d/env_vars.sh' >> /home/vagrant/.bash_profile

# grep -q '^option' file && sed -i 's/^option.*/option=value/' file || echo 'option=value' >> file


# sudo chmod +x /etc/profile.d/env_vars.sh




# graalvm-ce-java8-19.3.0

# echo "List = " & ls -a
# sudo mv graalvm-ce-java8/ /usr/lib/jvm/

# echo "======================================="
# echo "Installing Node JS .."
# echo "======================================="

# curl -sL https://rpm.nodesource.com/setup_12.x | sudo bash -

# sudo yum -y install nodejs
# npm install  npm --global

# # node –v
# # npm –v

# echo "***************************************"
# echo " Linking  node_modules temp folder.."
# echo "***************************************"

# # This linking is a fix of an error - node_modules(or any build) dir cannot be inside a Synced Folder. See the issues below.
# # https://github.com/Hashnode/mern-cli/issues/16
# # https://github.com/Hashnode/mern-starter/issues/185


# mkdir -p ~/tmp/node_modules/

# cd $PROJECT_ROOT

# ln -s ~/tmp/node_modules/

# echo "***************************************"
# echo " Linking  node_modules temp folder - DONE!"
# echo "***************************************"



# echo "======================================="
# echo "Installing Anguilar CLI .."
# echo "======================================="

# npm install --unsafe-perm -g @angular/cli -y


# npm install

# ng serve --host 0.0.0.0

echo "======================================="
echo "Vagrant provisioning complete."
echo "======================================="

sudo reboot
