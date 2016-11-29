#!/usr/bin/env bash

# Start Wildfly with the given arguments.
echo "Running jBPM Workbench on JBoss Wildfly..."
exec ./standalone.sh -b $JBOSS_BIND_ADDRESS -c standalone-full.xml
exit $?
