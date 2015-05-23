##########################################################################
# Dockerfile image that provides JBoss Drools Workbench 6.2.0.Final
#
# The web application binaries are downloaded from JBoss Nexus Repository.
#
# The Docker image generated name/tag is "jboss/drools-workbench:6.2.0.Final"
##########################################################################

####### BASE ############
FROM jboss/wildfly:8.1.0.Final

####### MAINTAINER ############
MAINTAINER "Roger Martinez" "romartin@redhat.com"

####### ENVIRONMENT ############
ENV KIE_REPOSITORY https://repository.jboss.org/nexus/content/groups/public-jboss/
ENV DROOLS_VERSION 6.2.0.Final
ENV DROOLS_CLASSIFIER wildfly8
ENV DROOLS_CONTEXT_PATH drools-wb
ENV JAVA_OPTS -XX:MaxPermSize=256m -Xms256m -Xmx512m

####### CUSTOM JBOSS USER ############
# Switchback to jboss user
USER jboss

####### DROOLS-WB ############
RUN curl -o /opt/jboss/$DROOLS_CONTEXT_PATH.war $KIE_REPOSITORY/org/kie/kie-drools-wb-distribution-wars/$DROOLS_VERSION/kie-drools-wb-distribution-wars-$DROOLS_VERSION-$DROOLS_CLASSIFIER.war && \ 
unzip -q /opt/jboss/$DROOLS_CONTEXT_PATH.war -d /opt/jboss/wildfly/standalone/deployments/$DROOLS_CONTEXT_PATH.war &&  \ 
touch /opt/jboss/wildfly/standalone/deployments/$DROOLS_CONTEXT_PATH.war.dodeploy &&  \ 
rm -rf /opt/jboss/$DROOLS_CONTEXT_PATH.war

####### EXPOSE INTERNAL JBPM GIT PORT ############
EXPOSE 8001

####### RUNNING DROOLS-WB ############
WORKDIR /opt/jboss/wildfly/bin/
CMD ["./standalone.sh", "-b", "0.0.0.0", "--server-config=standalone-full.xml"]