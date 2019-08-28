# NOTE: This Makefile is not required to build the program, for which maven
# is used. Instead, it invokes the program for tests and for transforming the
# output, for example to the lirc.xml file.

MYDIR := $(dir $(firstword $(MAKEFILE_LIST)))
TOP := $(realpath $(MYDIR)..)

include $(MYDIR)/paths.mk
include $(MYDIR)/java-test-renderer-protocols.mk
include $(MYDIR)/java-test-decoder-protocols.mk

EXTRACT_VERSION := $(TOP)/tools/extract_project_version.xsl
VERSION := $(shell $(XSLTPROC) $(EXTRACT_VERSION) pom.xml)
IRPHOME := $(TOP)/target
IRPPROTOCOLS_XML := $(IRPHOME)/IrpProtocols.xml
XSLT_DIR := $(IRPHOME)/xslt
LIRC_TRANSFORM=$(XSLT_DIR)/lirc.xsl
IRP_TRANSMOGRIFIER_JAR := $(IRPHOME)/IrpTransmogrifier-$(VERSION)-jar-with-dependencies.jar
IRP_TRANSMOGRIFIER_BIN := $(IRPHOME)/IrpTransmogrifier-$(VERSION)-bin.zip
IRPTRANSMOGRIFIER := $(JAVA) -jar $(IRP_TRANSMOGRIFIER_JAR) --loglevel warning --url-decode
JAVA_PROTOCOL_TEST := JavaTestProtocol

JAVA_RENDERER_CODEDIR := $(JAVA_PROTOCOL_TEST)/src/main/java/org/harctoolbox/renderers
JAVA_RENDERER_TESTDIR := $(JAVA_PROTOCOL_TEST)/src/test/java/org/harctoolbox/renderers
JAVA_DECODER_CODEDIR := $(JAVA_PROTOCOL_TEST)/src/main/java/org/harctoolbox/decoders
JAVA_DECODER_TESTDIR := $(JAVA_PROTOCOL_TEST)/src/test/java/org/harctoolbox/decoders

IRPPROTOCOLS_XML := $(JAVA_PROTOCOL_TEST)/src/main/resources/IrpProtocols.xml

GH_PAGES := $(TOP)/gh-pages
ORIGINURL := $(shell git remote get-url origin)

default: $(IRP_TRANSMOGRIFIER_JAR)
	$(IRPTRANSMOGRIFIER) --help

$(IRP_TRANSMOGRIFIER_JAR) $(IRP_TRANSMOGRIFIER_BIN):
	mvn install -Dmaven.test.skip=true

$(IRP_TRANSMOGRIFIER_JAR)-test:
	mvn install -Dmaven.test.skip=false

apidoc: target/site/apidocs
	$(BROWSE) target/site/apidocs/index.html

javadoc: target/site/apidocs

target/site/apidocs:
	mvn javadoc:javadoc

gh-pages: target/site/apidocs
	rm -rf $(GH_PAGES)
	git clone --depth 1 -b gh-pages ${ORIGINURL} ${GH_PAGES}
	( cd ${GH_PAGES} ; \
	cp -rf ../target/site/apidocs/* . ; \
	git add * ; \
	git commit -a -m "Update of API documentation" )
	echo Now perform \"git push\" from ${GH_PAGES}

all-protocols.xml: $(IRP_TRANSMOGRIFIER_JAR)
	$(IRPTRANSMOGRIFIER) -o $@ code --target xml

lirc.xml: all-protocols.xml ${LIRC_TRANSFORM}
	$(SAXON) -s:$< -xsl:${LIRC_TRANSFORM} -o:$@

install-lirc.xml: ../harctoolboxbundle/IrScrutinizer/src/main/config/exportformats.d/lirc.xml lirc.xml

../harctoolboxbundle/IrScrutinizer/src/main/config/exportformats.d/lirc.xml: lirc.xml
	cp $< $@

javacodetest: javarendertest javadecodertest $(JAVA_PROTOCOL_TEST)/pom.xml $(IRPPROTOCOLS_XML)
	(cd $(JAVA_PROTOCOL_TEST); mvn test)

javarendertest:  javarendercodefiles  javarendertestfiles
javadecodertest: javadecodercodefiles javadecodertestfiles

javarendercodefiles: $(IRP_TRANSMOGRIFIER_JAR) | $(JAVA_RENDERER_CODEDIR)
	$(IRPTRANSMOGRIFIER) code --directory $(JAVA_RENDERER_CODEDIR) --stdir $(IRPHOME)/st --target java-renderer-code $(foreach proto,$(JAVA_TEST_RENDERER_PROTOCOLS),"$(proto)")

javarendertestfiles: $(IRP_TRANSMOGRIFIER_JAR) | $(JAVA_RENDERER_TESTDIR)
	$(IRPTRANSMOGRIFIER) code --directory $(JAVA_RENDERER_TESTDIR) --stdir $(IRPHOME)/st --target java-renderer-test $(foreach proto,$(JAVA_TEST_RENDERER_PROTOCOLS), "$(proto)")

javadecodercodefiles: $(IRP_TRANSMOGRIFIER_JAR) | $(JAVA_DECODER_CODEDIR)
	$(IRPTRANSMOGRIFIER) code --directory $(JAVA_DECODER_CODEDIR)  --stdir $(IRPHOME)/st --target java-decoder-code $(foreach proto,$(JAVA_TEST_DECODER_PROTOCOLS), "$(proto)")

javadecodertestfiles: $(IRP_TRANSMOGRIFIER_JAR) | $(JAVA_DECODER_TESTDIR)
	$(IRPTRANSMOGRIFIER) code --directory $(JAVA_DECODER_TESTDIR)  --stdir $(IRPHOME)/st --target java-decoder-test $(foreach proto,$(JAVA_TEST_DECODER_PROTOCOLS), "$(proto)")

$(JAVA_PROTOCOL_TEST)/pom.xml: $(JAVA_PROTOCOL_TEST)
	cp $(MYDIR)/JavaIrpProtocolTest.pom.xml $@

$(IRPPROTOCOLS_XML): | $(JAVA_PROTOCOL_TEST)/src/main/resources
	cp src/main/resources/IrpProtocols.xml $@

$(JAVA_PROTOCOL_TEST) \
$(JAVA_PROTOCOL_TEST)/src/main/resources \
$(JAVA_RENDERER_CODEDIR) $(JAVA_RENDERER_TESTDIR) $(JAVA_DECODER_CODEDIR) $(JAVA_DECODER_TESTDIR) \
$(INSTALLDIR):
	mkdir -p $@

# Only for Unix-like systems
install: $(IRP_TRANSMOGRIFIER_BIN) | $(INSTALLDIR)
	-rm -rf $(INSTALLDIR)/*
	( cd $(INSTALLDIR); jar xf $< )
	ln -sf $(INSTALLDIR)/irptransmogrifier.sh $(BINLINK)
	echo \#!/bin/sh > $(BROWSELINK)
	echo $(BROWSE) $(INSTALLDIR)/IrpProtocols.html >> $(BROWSELINK)
	chmod +x $(BROWSELINK) $(INSTALLDIR)/irptransmogrifier.sh

uninstall:
	rm -rf $(INSTALLDIR)
	rm $(BINLINK)

test: $(IRP_TRANSMOGRIFIER_JAR)-test javacodetest lirc.xml
	diff lirc.xml lirc.xml.old

clean:
	mvn clean
	rm -f all-protocols.xml lirc.xml
	rm -rf $(JAVA_PROTOCOL_TEST)
	rm -rf $(GH_PAGES)

.PHONY: clean $(IRP_TRANSMOGRIFIER_JAR)-test