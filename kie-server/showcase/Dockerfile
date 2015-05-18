#################################################################################
# Dockerfile image that provides JBoss KIE Server 6.2.0.Final Showcase
#
# The web application binaries are downloaded from JBoss Nexus Repository.
#
# The Docker image generated name/tag is "jboss/kie-server-showcase:6.2.0"
#################################################################################

####### BASE ############
FROM jboss/kie-server:6.2.0.Final

####### MAINTAINER ############
MAINTAINER "Roger Martinez" "romartin@redhat.com"

####### Drools KIE Server CUSTOM CONFIGURATION ############
# There is an issue in Docker with ADD command.
# When a file is added into the container's filesystem, the file owner is always root, instead of the current running user.
# See https://github.com/docker/docker/issues/5110
# The workaround is doing a chown using root user and then switchback to jboss user.
ADD etc/standalone-full-kie-server.xml /opt/jboss/wildfly/standalone/configuration/standalone-full-kie-server.xml
ADD etc/kie-server-users.properties /opt/jboss/wildfly/standalone/configuration/kie-server-users.properties
ADD etc/kie-server-roles.properties /opt/jboss/wildfly/standalone/configuration/kie-server-roles.properties
USER root
RUN chown jboss:jboss /opt/jboss/wildfly/standalone/configuration/standalone-full-kie-server.xml && \ 
chown jboss:jboss /opt/jboss/wildfly/standalone/configuration/kie-server-users.properties && \ 
chown jboss:jboss /opt/jboss/wildfly/standalone/configuration/kie-server-roles.properties
# Switchback to jboss user
USER jboss

####### RUNNING KIE-SERVER ############
WORKDIR /opt/jboss/wildfly/bin/
CMD ["./standalone.sh", "-b", "0.0.0.0", "--server-config=standalone-full-kie-server.xml"]
