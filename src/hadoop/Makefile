#
# $Id$
#
# @Copyright@
#
# 				Rocks(tm)
# 		         www.rocksclusters.org
# 		        version 4.3 (Mars Hill)
#
# Copyright (c) 2000 - 2011 The Regents of the University of California.
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are
# met:
#
# 1. Redistributions of source code must retain the above copyright
# notice, this list of conditions and the following disclaimer.
#
# 2. Redistributions in binary form must reproduce the above copyright
# notice unmodified and in its entirety, this list of conditions and the
# following disclaimer in the documentation and/or other materials provided
# with the distribution.
#
# 3. All advertising and press materials, printed or electronic, mentioning
# features or use of this software must display the following acknowledgement:
#
# 	"This product includes software developed by the Rocks(tm)
# 	Cluster Group at the San Diego Supercomputer Center at the
# 	University of California, San Diego and its contributors."
#
# 4. Except as permitted for the purposes of acknowledgment in paragraph 3,
# neither the name or logo of this software nor the names of its
# authors may be used to endorse or promote products derived from this
# software without specific prior written permission.  The name of the
# software includes the following terms, and any derivatives thereof:
# "Rocks", "Rocks Clusters", and "Avalanche Installer".  For licensing of
# the associated name, interested parties should contact Technology
# Transfer & Intellectual Property Services, University of California,
# San Diego, 9500 Gilman Drive, Mail Code 0910, La Jolla, CA 92093-0910,
# Ph: (858) 534-5815, FAX: (858) 534-7345, E-MAIL:invent@ucsd.edu
#
# THIS SOFTWARE IS PROVIDED BY THE REGENTS AND CONTRIBUTORS ``AS IS''
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
# THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
# PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE REGENTS OR CONTRIBUTORS
# BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
# CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
# SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
# BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
# WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
# OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN
# IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#
# @Copyright@
#

RPM.EXTRAS += "AutoReq: 0 "
RPM.EXTRAS += %define __os_install_post %{nil} 

PKGROOT = /opt/hadoop
SOURCE = $(NAME)-$(VERSION)-src

YARN_USER = yarn
HADOOP_TMP_DIR = /state/partition1/hadoop/tmp
HADOOP_CONF_DIR = $(PKGROOT)/etc/hadoop

REDHAT.ROOT = $(PWD)/../../

-include $(ROCKSROOT)/etc/Rules.mk
include Rules.mk

SCRIPTS = hadoop-env.sh yarn-env.sh 
CONFIGS = core-site.xml yarn-site.xml hdfs-site.xml

SEDSPEC += \
        -e 's%@HADOOP_INST_DIR@%$(PKGROOT)%g' \
        -e 's%@HADOOP_TMPDIR@%$(HADOOP_TMPDIR)%g' \
        -e 's%@YARN_USER@%$(YARN_USER)%g'

hadoop-env.sh: hadoop-env.sh.in
	$(SED) $(SEDSPEC) $^ > $@

yarn-env.sh: yarn-env.sh.in
	$(SED) $(SEDSPEC) $^ > $@

core-site.xml: core-site.xml.in
	$(SED) $(SEDSPEC) $^ > $@

yarn-site.xml: yarn-site.xml.in
	$(SED) $(SEDSPEC) $^ > $@

hdfs-site.xml: hdfs-site.xml.in
	$(SED) $(SEDSPEC) $^ > $@

doctar:
	tar zxvf $(SOURCE).tar.gz
	cd patch-files && find . -type f | grep -v CVS | cpio -pduv ..
	(\
	    cd $(SOURCE); \
	    mvn clean site; mvn site:stage -DstagingDirectory=/tmp/hadoopDoc ; \
	    tar czvf ../../hadoop-doc/$(NAME)-doc-$(VERSION).tar.gz -C /tmp/hadoopDoc/hadoop-project .  ; \
	)
	rm -rf /tmp/hadoopDoc

build: $(SCRIPTS) $(CONFIGS)
	tar zxvf $(SOURCE).tar.gz
	cd patch-files && find . -type f | grep -v CVS | cpio -pduv ..
	(cd $(SOURCE); mvn package -Pdist,native -DskipTests -Dtar)

install::
	mkdir -p $(ROOT)/$(PKGROOT)
	( \
           cd $(SOURCE)/hadoop-dist/target/$(NAME)-$(VERSION); \
	   cp -r . $(ROOT)/$(PKGROOT); \
        )
	mkdir -p $(ROOT)/$(HADOOP_CONF_DIR)
	install -m 755 $(SCRIPTS) $(ROOT)/$(HADOOP_CONF_DIR)
	install -m 644 $(CONFIGS) $(ROOT)/$(HADOOP_CONF_DIR)

clean::
	rm -rf $(SOURCE)
	rm -rf $(SCRIPTS) $(CONFIGS)
