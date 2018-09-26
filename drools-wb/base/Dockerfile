###########################################################################
# Dockerfile that provides the image for JBoss Drools Workbench 7.11.0.Final
###########################################################################

####### BASE ############
FROM jboss/wildfly:11.0.0.Final

####### MAINTAINER ############
MAINTAINER "Michael Biarnes Kiefer" "mbiarnes@redhat.com"

####### ENVIRONMENT ############
ENV JBOSS_BIND_ADDRESS 0.0.0.0
ENV KIE_REPOSITORY https://repository.jboss.org/nexus/content/groups/public-jboss
ENV KIE_VERSION 7.11.0.Final
ENV KIE_CLASSIFIER wildfly11
ENV KIE_CONTEXT_PATH drools-wb
ENV KIE_SERVER_PROFILE standalone-full
ENV JAVA_OPTS -Xms256m -Xmx2048m -Djava.net.preferIPv4Stack=true -Dfile.encoding=UTF-8

####### DROOLS-WB ############
RUN curl -o $HOME/$KIE_CONTEXT_PATH.war $KIE_REPOSITORY/org/kie/kie-drools-wb/$KIE_VERSION/kie-drools-wb-$KIE_VERSION-$KIE_CLASSIFIER.war && \
unzip -q $HOME/$KIE_CONTEXT_PATH.war -d $JBOSS_HOME/standalone/deployments/$KIE_CONTEXT_PATH.war &&  \
touch $JBOSS_HOME/standalone/deployments/$KIE_CONTEXT_PATH.war.dodeploy &&  \
rm -rf $HOME/$KIE_CONTEXT_PATH.war

####### SCRIPTS ############
USER root
ADD etc/start_drools-wb.sh $JBOSS_HOME/bin/start_drools-wb.sh
RUN chown jboss:jboss $JBOSS_HOME/bin/start_drools-wb.sh

####### CUSTOM JBOSS USER ############
# Switchback to jboss user
USER jboss

####### EXPOSE INTERNAL JBPM GIT PORT ############
EXPOSE 8001

####### RUNNING DROOLS-WB ############
WORKDIR $JBOSS_HOME/bin/
CMD ["./start_drools-wb.sh"]
