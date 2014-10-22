vagrant-alfresco-nightly
========================

Creates a linux VM with vagrant, downloads, installs and runs the lastest Alfresco nightly build

VM
---
- Uses Vagrant Vitualbox provider
- Creates a VM based on Ubuntu Trusty 64bit
- VM with 4 CPUs, 4GB of memory
- Downloads latest alfresco nightly community build from http://dev.alfresco.com/downloads/nightly/dist/
- Alfresco is exposed to **local port 8080**

Alfresco Setup
---
- Standard Alfresco installation with PostgresQL
- Admin login defaults to admin:admin
- Install location: /opt/alfresco

Usage
---
- Checkout using 
    
        git clone https://github.com/fmaul/vagrant-alfresco-nightly.git
        
- Optionaly add amp files or libraries to these subfolders. They are copied and applied berfore starting Alfresco.
        shared-classes/
        shared-lib/
        amps-repo/
        amps-share/

- Start vagrant VM

        vagrant up
        
- Wait 5-10 minutes for Alfresco being available at

        http://localhost:8080/
        





