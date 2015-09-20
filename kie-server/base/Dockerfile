#################################################################################
# Dockerfile that provides the image for JBoss KIE Server 6.3.0.Final
#################################################################################

####### BASE ############
FROM jboss/wildfly:8.2.0.Final

####### MAINTAINER ############
MAINTAINER "Roger Martinez" "romartin@redhat.com"

####### ENVIRONMENT ############
ENV JBOSS_BIND_ADDRESS 0.0.0.0
ENV KIE_REPOSITORY https://repository.jboss.org/nexus/content/groups/public-jboss
ENV KIE_VERSION 6.3.0.Final
ENV KIE_CLASSIFIER ee7
ENV KIE_CONTEXT_PATH kie-server
ENV JAVA_OPTS -XX:MaxPermSize=256m -Xms256m -Xmx512m

####### KIE-SERVER ############
RUN curl -o $HOME/$KIE_CONTEXT_PATH.war $KIE_REPOSITORY/org/kie/server/kie-server/$KIE_VERSION/kie-server-$KIE_VERSION-$KIE_CLASSIFIER.war && \
unzip -q $HOME/$KIE_CONTEXT_PATH.war -d $JBOSS_HOME/standalone/deployments/$KIE_CONTEXT_PATH.war &&  \
touch $JBOSS_HOME/standalone/deployments/$KIE_CONTEXT_PATH.war.dodeploy &&  \
rm -rf $HOME/$KIE_CONTEXT_PATH.war

####### RUNNING KIE-SERVER ############
WORKDIR $JBOSS_HOME/bin/
CMD ["./standalone.sh", "-b", "$JBOSS_BIND_ADDRESS", "-c", "standalone-full.xml"]