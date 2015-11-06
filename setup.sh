#!/bin/sh

apt-get -y update

# Install fontconfig dependency for libreoffice
apt-get -y install fontconfig
apt-get -y install curl
apt-get -y install libXinerama1
apt-get -y install libcups*
apt-get -y install libglu1-mesa
 
# Location for Alfresco nightly downloads, no trailing slash
export alfresconightly=https://alf-community-nightly.s3-eu-west-1.amazonaws.com/Community

# Find distribution filename in the download page, e.g. alfresco-community-5.0.b-SNAPSHOT-installer-linux-x64.bin
echo Finding latest linux x64 release in $alfresconightly
releasename=`curl -L "https://alf-community-nightly.s3-eu-west-1.amazonaws.com/?delimiter=/&prefix=Community/" | sed 's/[<>]/\n/g' | grep linux | sed -e 's/Community\///'`
# Change working dir to vagrant directory
cd /vagrant

# Download Alfresco release if not already downloaded earlier
if [ ! -f $releasename ]; then
	echo Downloading Alfresco release: $releasename
	curl -L -O $alfresconightly/$releasename
fi

# Install Alfresco using the key file
./$releasename < /vagrant/install-keys

# Copy extensions and amp modules
cd /opt/alfresco
cp -Rv /vagrant/shared-classes/* tomcat/shared/classes/
cp -Rv /vagrant/shared-lib/* tomcat/shared/lib/
cp -Rv /vagrant/amps-repo/* amps/
cp -Rv /vagrant/amps-share/* amps_share/

# Install amp modules into alfresco.war and share.war
mmt="/opt/alfresco/java/bin/java -jar /opt/alfresco/bin/alfresco-mmt.jar"
$mmt install amps tomcat/webapps/alfresco.war -directory $*
$mmt list tomcat/webapps/alfresco.war
$mmt install amps_share tomcat/webapps/share.war -directory $*
$mmt list tomcat/webapps/share.war

# Start Alfresco after installation
service alfresco start
