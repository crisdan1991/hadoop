#!/bin/bash

compile_and_install protobuf
compile_and_install rocks-hadoop
compile_and_install maven

echo "/opt/hadoop/lib" > /etc/ld.so.conf.d/hadoop.conf
/sbin/ldconfig

export PATH=$PATH:/opt/hadoop/bin:/opt/maven/bin

export ANT_HOME=/opt/rocks
export MAVEN_HOME=/opt/maven

(cd src/hadoop; make doctar)

