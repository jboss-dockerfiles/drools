###########################################################################
# Dockerfile that provides the image for JBoss Drools Workbench 7.18.0.Final
###########################################################################

####### BASE ############
FROM jboss/wildfly:14.0.1.Final

####### MAINTAINER ############
MAINTAINER "PatSim"

####### ENVIRONMENT ############
ENV JBOSS_BIND_ADDRESS 0.0.0.0
ENV KIE_REPOSITORY https://repository.jboss.org/nexus/content/groups/public-jboss
ENV KIE_VERSION 7.18.0.Final
ENV KIE_CLASSIFIER wildfly14
ENV KIE_CONTEXT_PATH business-central
ENV KIE_SERVER_PROFILE standalone-full
ENV JAVA_OPTS -Xms256m -Xmx2048m -Djava.net.preferIPv4Stack=true -Dfile.encoding=UTF-8

####### DROOLS-WB ############
RUN curl -o $HOME/$KIE_CONTEXT_PATH.war $KIE_REPOSITORY/org/kie/business-central/$KIE_VERSION/business-central-$KIE_VERSION-$KIE_CLASSIFIER.war && \
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

USER 1001
ENTRYPOINT ["/tmp/docker_run.sh"]
