# vagrant-quarkus-template
A template project for Quarkus inside a Vagrant environment

## Pre-requisites for this template

 1. Install VirtualBox on your Mac or PC
 2. Install Vagrant on your Mac or PC

## Steps to use this template

 1. Open vagrant/Vagrantfile and make sure the VM configuration(IP Addresses and port no.s) doesn't conflict with any other existing setup.
 
 2. From command line, start up vagrant environment(VM):
 	> cd vagrant
 	> vagrant up
 
 	This will take a while to complete. Be patient.
 
 3. SSH into the VM as the default 'vagrant' user
 	> vagrant ssh
 
 	You will be inside the default user home - /home/vagrant
 
 4. Generate the Quarkus Web Project from the project directory
 	> cd workspace/my-project
 	> ./createWebProject.sh
 
 	Answer the questions asked, your project will be created.
 
 5. Start up the newly generated App [from the project root that you just created]: 
 	> cd &lt;projectArtifactId&gt;
 	> ./mvnw quarkus:dev
 
 6. Open a browser window on your local PC, enter the following:
 	> http://localhost:8180
  
 