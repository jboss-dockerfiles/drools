#################################################################################
# Dockerfile image that provides JBoss Drools Workbench 6.2.0.Final Showcase
#
# The web application binaries are downloaded from JBoss Nexus Repository.
#
# The Docker image generated name/tag is "jboss/drools-workbench-showcase:6.2.0.Final"
#################################################################################

####### BASE ############
FROM jboss/drools-workbench:6.2.0.Final

####### MAINTAINER ############
MAINTAINER "Roger Martinez" "romartin@redhat.com"

####### Drools Workbench CUSTOM CONFIGURATION ############
# There is an issue in Docker with ADD command.
# When a file is added into the container's filesystem, the file owner is always root, instead of the current running user.
# See https://github.com/docker/docker/issues/5110
# The workaround is doing a chown using root user and then switchback to jboss user.
ADD etc/standalone-full-drools.xml /opt/jboss/wildfly/standalone/configuration/standalone-full-drools.xml
ADD etc/drools-users.properties /opt/jboss/wildfly/standalone/configuration/drools-users.properties
ADD etc/drools-roles.properties /opt/jboss/wildfly/standalone/configuration/drools-roles.properties
USER root
RUN chown jboss:jboss /opt/jboss/wildfly/standalone/configuration/standalone-full-drools.xml && \ 
chown jboss:jboss /opt/jboss/wildfly/standalone/configuration/drools-users.properties && \ 
chown jboss:jboss /opt/jboss/wildfly/standalone/configuration/drools-roles.properties
# Switchback to jboss user
USER jboss

####### RUNNING DROOLS-WB ############
WORKDIR /opt/jboss/wildfly/bin/
CMD ["./standalone.sh", "-b", "0.0.0.0", "--server-config=standalone-full-drools.xml"]
