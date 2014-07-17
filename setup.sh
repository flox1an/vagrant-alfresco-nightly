#!/bin/sh

# Location for Alfresco nightly downloads, no trailing slash
export alfresconightly=http://dev.alfresco.com/downloads/nightly/dist

# Find distribution filename in the download page, e.g. alfresco-community-5.0.b-SNAPSHOT-installer-linux-x64.bin
echo Finding latest linux x64 release in $alfresconightly
releasename=`curl "$alfresconightly/" | grep -Po 'alfresco[^\>]+linux-x64.bin' | head -n1`

# Change working dir to vagrant directory
cd /vagrant

# Download Alfresco release if not already downloaded earlier
echo Downloading Alfresco release: $releasename
wget -N $alfresconightly/$releasename

# Install Alfresco using the key file
./$releasename < /vagrant/install-keys

# Start Alfresco after installation
service alfresco start
