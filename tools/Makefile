# NOTE: This Makefile is not required to build the program, for which maven
# is used. Instead, it invokes the program for tests and for transforming the
# output, for example to the lirc.xml file.

MYDIR := $(dir $(firstword $(MAKEFILE_LIST)))
TOP := $(realpath $(MYDIR)..)

include $(MYDIR)/paths.mk
include $(MYDIR)/java-test-renderer-protocols.mk
include $(MYDIR)/java-test-decoder-protocols.mk

EXTRACT_VERSION := $(IRPTRANSMOGRIFIER_HOME)/common/xslt/extract_project_version.xsl
VERSION := $(shell $(XSLTPROC) $(EXTRACT_VERSION) $(IRPTRANSMOGRIFIER_HOME)/pom.xml)
IRPPROTOCOLS_XML := $(IRPTRANSMOGRIFIER_HOME)/IrpProtocols.xml
XSLT_DIR := $(TOP)/src/main/xslt
LIRC_TRANSFORM=$(XSLT_DIR)/lirc.xsl
ST_DIR := $(TOP)/src/main/st

JAVA_PROTOCOL_SRC :=  $(TOP)/target/generated-sources/java/
JAVA_PROTOCOL_TEST := $(TOP)/target/generated-test-sources/java/

#JAVA_PROTOCOL_SRC :=  $(TOP)/src/main/java/
#JAVA_PROTOCOL_TEST := $(TOP)/src/test/java/

JAVA_RENDERER_CODEDIR := $(JAVA_PROTOCOL_SRC)/org/harctoolbox/renderers
JAVA_RENDERER_TESTDIR := $(JAVA_PROTOCOL_TEST)/org/harctoolbox/renderers
JAVA_DECODER_CODEDIR :=  $(JAVA_PROTOCOL_SRC)/org/harctoolbox/decoders
JAVA_DECODER_TESTDIR :=  $(JAVA_PROTOCOL_TEST)/org/harctoolbox/decoders

default: $(IRP_TRANSMOGRIFIER)
	$(IRPTRANSMOGRIFIER) version

all-protocols.xml: $(IRP_TRANSMOGRIFIER_JAR)
	$(IRPTRANSMOGRIFIER) -o $@ code --target xml

lirc.xml: all-protocols.xml ${LIRC_TRANSFORM}
	$(SAXON) -s:$< -xsl:${LIRC_TRANSFORM} -o:$@

install-lirc.xml: $(OLD_LIRC_XML)

$(OLD_LIRC_XML): lirc.xml
	cp $< $@

diffuse: lirc.xml
	kdiff3 $(OLD_LIRC_XML) lirc.xml

install: install-lirc.xml

javacodetest: javarendertest javadecodertest
	mvn test

javarendertest:  javarendercodefiles  javarendertestfiles
javadecodertest: javadecodercodefiles javadecodertestfiles

javarendercodefiles: $(IRP_TRANSMOGRIFIER_JAR) | $(JAVA_RENDERER_CODEDIR)
	$(IRPTRANSMOGRIFIER) code --directory $(JAVA_RENDERER_CODEDIR) --stdir $(ST_DIR) --target java-renderer-code $(foreach proto,$(JAVA_TEST_RENDERER_PROTOCOLS),"$(proto)")

javarendertestfiles: $(IRP_TRANSMOGRIFIER_JAR) | $(JAVA_RENDERER_TESTDIR)
	$(IRPTRANSMOGRIFIER) code --directory $(JAVA_RENDERER_TESTDIR) --stdir $(ST_DIR) --target java-renderer-test $(foreach proto,$(JAVA_TEST_RENDERER_PROTOCOLS), "$(proto)")

javadecodercodefiles: $(IRP_TRANSMOGRIFIER_JAR) | $(JAVA_DECODER_CODEDIR)
	$(IRPTRANSMOGRIFIER) code --directory $(JAVA_DECODER_CODEDIR)  --stdir $(ST_DIR) --target java-decoder-code $(foreach proto,$(JAVA_TEST_DECODER_PROTOCOLS), "$(proto)")

javadecodertestfiles: $(IRP_TRANSMOGRIFIER_JAR) | $(JAVA_DECODER_TESTDIR)
	$(IRPTRANSMOGRIFIER) code --directory $(JAVA_DECODER_TESTDIR)  --stdir $(ST_DIR) --target java-decoder-test $(foreach proto,$(JAVA_TEST_DECODER_PROTOCOLS), "$(proto)")

$(JAVA_PROTOCOL_TEST) \
$(JAVA_RENDERER_CODEDIR) $(JAVA_RENDERER_TESTDIR) $(JAVA_DECODER_CODEDIR) $(JAVA_DECODER_TESTDIR):
	mkdir -p $@

test: $(IRP_TRANSMOGRIFIER_JAR)-test javacodetest lirc.xml
	diff lirc.xml lirc.xml.old

clean:
	mvn clean
	rm -f all-protocols.xml lirc.xml

.PHONY: clean $(IRP_TRANSMOGRIFIER_JAR)-test
