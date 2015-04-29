Drools Workbench Showcase Docker image
========================================

JBoss Drools Workbench Showcase [Docker](http://docker.io/) image.

Table of contents
------------------

* **[Introduction](#introduction)**
* **[Usage](#usage)**
* **[GIT internal repository access](#git-internal-repository.access)**
* **[Users and roles](#users-and-roles)**
* **[Logging](#logging)**
* **[Extending this image](#extending-this-image)**
* **[Experimenting](#experimenting)**
* **[Notes](#notes)**

Introduction
------------

The image contains:               
* JBoss Wildfly 8.1.0.Final             
* Drools Workbench 6.2.0.Final            

This image inherits from <code>jboss/drools-workbench:6.2.0</code> and provides some additional configurations:     

* Some KIE examples            
* Default users and roles                                                       

This is a **ready to run Docker image for Drools Workbench**. Just run it and try our workbench!                       


Usage
-----

To run a container:
    
    docker run -P -d --name drools-workbench jboss/drools-workbench-showcase:6.2.0

Once container and web applications started, you can navigate to it using one of the users described in section [Users and roles](#users-and-roles).              

To find out the application URL:               

**Using local host binding port**

If you have run the container using <code>-P</code> flag in the <code>docker</code> command, the port <code>8080</code> has been bind to an available port on your host.                 

So you have to discover your host's bind port, that can be done by running the command:          

    docker ps -a

Example of the above command response:                   

    CONTAINER ID        IMAGE                        COMMAND                CREATED              STATUS              PORTS                                              NAMES
    2a55fbe771c0        jboss/drools-workbench-showcase:6.2.0   ./standalone.sh -b 0   About a minute ago   Up About a minute   0.0.0.0:49159->8080/tcp, 0.0.0.0:49160->9990/tcp   drools-workbench-showcase      

As you can see, the bind port to use for container's port <code>8080</code> is <code>49159</code>, so you can navigate to:

    http://localhost:49159/drools-wb

**No bind port for localhost**

In case you run the container without using <code>-P</code> flag in the <code>docker</code> command, you can navigate to the application at:

    http://<container_ip_address>:8080/drools-wb
    
You can discover the IP address of your running container by:

    docker inspect --format '{{ .NetworkSettings.IPAddress }}' drools-workbench-showcase

GIT internal repository access
------------------------------

You can clone the GIT internal repositories that Drools Workbench Showcase provides, as well as any ones created by application users.             

By default, the protocol used for cloning a GIT repository from the application is <code>SSH</code> at port <code>8001</code>.            
 
    git clone ssh://admin@localhost:8001/uf-playground
    
For cloning a repository located inside the Drools Workbench Showcase docker container, you have to discover your host's port bind for the internal port <code>8001</code>, by running the <code>ps</code> docker command:                   

    docker ps -a

Example of the above command response:                   

    CONTAINER ID        IMAGE                        COMMAND                CREATED              STATUS              PORTS                                                                                   NAMES
    2a55fbe771c0        jboss/drools-workbench-showcase:6.2.0   ./standalone.sh -b 0   About a minute ago   Up About a minute   0.0.0.0:49159->8080/tcp, 0.0.0.0:49160->9990/tcp, 0.0.0.0:49161->8001/tcp   drools-workbench-showcase  

As you can see, the bind port to use for container's port <code>8001</code> is <code>49161</code>, so you can do the clone as:

    git clone ssh://admin@localhost:49161/uf-playground

NOTE: Users and password for ssh access are the same that for the web application users defined at the realm files.   

Users and roles
----------------

This showcase image contains default users and roles:               

<table>
    <tr>
        <td><b>User</b></td>
        <td><b>Password</b></td>
        <td><b>Role</b></td>
    </tr>
    <tr>
        <td>admin</td>
        <td>admin</td>
        <td>admin,analyst,kiemgmt</td>
    </tr>
    <tr>
        <td>krisv</td>
        <td>krisv</td>
        <td>admin,analyst</td>
    </tr>
    <tr>
        <td>john</td>
        <td>john</td>
        <td>analyst,Accounting,PM</td>
    </tr>
    <tr>
        <td>mary</td>
        <td>mary</td>
        <td>analyst,HR</td>
    </tr>
    <tr>
        <td>sales-rep</td>
        <td>sales-rep</td>
        <td>analyst,sales</td>
    </tr>
    <tr>
        <td>katy</td>
        <td>katy</td>
        <td>analyst,HR</td>
    </tr>
    <tr>
        <td>jack</td>
        <td>jack</td>
        <td>analyst,IT</td>
    </tr>
    <tr>
        <td>salaboy</td>
        <td>salaboy</td>
        <td>admin,analyst,IT,HR,Accounting</td>
    </tr>
</table>

Logging
-------

You can see all logs generated by the <code>standalone</code> binary running:

    docker logs [-f] <container_id>
    
You can attach the container by running:

    docker attach <container_id>

The Drools Workbench web application logs can be found inside the container at path:

    /opt/jboss/wildfly/standalone/log/server.log

    Example:
    sudo nsenter -t $(docker inspect --format '{{ .State.Pid }}' $(docker ps -lq)) -m -u -i -n -p -w
    -bash-4.2# tail -f /opt/jboss/wildfly/standalone/log/server.log

Experimenting
-------------

To spin up a shell in one of the containers try:

    docker run -t -i -P jboss/drools-workbench-showcase:6.2.0 /bin/bash

You can then noodle around the container and run stuff & look at files etc.

You can run the Drools Workbench web application by running command:

    /opt/jboss/wildfly/bin/standalone.sh -b 0.0.0.0 --server-config=standalone-full-drools.xml


Notes
-----

* Drools Workbench version is <code>6.2.0.Final</code>               
* Drools Workbench requires running JBoss Wildfly using <code>full</code> profile                        
* No support for clustering                
* Use of embedded H2 database server by default               
* No support for Wildfly domain mode, just standalone mode                    
* The context path for Drools Workbench web application is <code>drools-wb</code>                  
