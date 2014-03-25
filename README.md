Hadoop Roll
============
Based on triton hadoop roll for hadoop v. 1.*). 
This roll bundles the hadoop distributed processing package and the myHadoop
add-on.  To install, execute these instructions on a Rocks development machine

Downloads
----------
wget http://apache.mesi.com.ar/maven/maven-3/3.1.1/binaries/apache-maven-3.1.1-bin.tar.gz
wget https://protobuf.googlecode.com/files/protobuf-2.5.0.tar.gz
wget http://www.bizdirusa.com/mirrors/apache/hadoop/common/hadoop-2.2.0/hadoop-2.2.0-src.tar.gz 
wget http://www.bizdirusa.com/mirrors/apache/hadoop/common/hadoop-2.2.0/hadoop-2.2.0-src.tar.gz.mds 


Install
-----------
On a frontend starting in this directory:

% ./bootstarp.sh
% make
% rocks add roll *.iso
% rocks enable roll hadoop
% cd /export/rocks/install
% rocks create distro
% rocks run roll hadoop | bash





