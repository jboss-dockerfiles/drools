#####################################################################################
# Dockerfile that provides the image for JBoss Drools Workbench 6.3.0.Final Showcase
#####################################################################################

####### BASE ############
FROM jboss/drools-workbench:6.3.0.Final

####### MAINTAINER ############
MAINTAINER "Roger Martinez" "romartin@redhat.com"

####### ENVIRONMENT ############
# Use demo and examples by default in this showcase image (internet connection required).
ENV KIE_DEMO true

####### Drools Workbench CUSTOM CONFIGURATION ############
ADD etc/standalone-full-drools.xml $JBOSS_HOME/standalone/configuration/standalone-full-drools.xml
ADD etc/drools-users.properties $JBOSS_HOME/standalone/configuration/drools-users.properties
ADD etc/drools-roles.properties $JBOSS_HOME/standalone/configuration/drools-roles.properties

# Added files are chowned to root user, change it to the jboss one.
USER root
RUN chown jboss:jboss $JBOSS_HOME/standalone/configuration/standalone-full-drools.xml && \
chown jboss:jboss $JBOSS_HOME/standalone/configuration/drools-users.properties && \
chown jboss:jboss $JBOSS_HOME/standalone/configuration/drools-roles.properties

# Switchback to jboss user
USER jboss

####### RUNNING DROOLS-WB ############
WORKDIR $JBOSS_HOME/bin/
CMD ["./standalone.sh", "-b", "$JBOSS_BIND_ADDRESS", "-Dorg.kie.demo=$KIE_DEMO", "-Dorg.kie.example=$KIE_DEMO", "-c", "standalone-full-drools.xml"]
