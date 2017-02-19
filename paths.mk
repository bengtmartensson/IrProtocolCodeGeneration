# External programs

JAVA := java
SAXON_JAR := /usr/local/saxon/saxon9he.jar

IRPHOME := $(abspath $(MYDIR)../target)
XSLTDIR := $(IRPHOME)/xslt
IRP_TRANSMOGRIFIER_JAR := $(IRPHOME)/IrpTransmogrifier-0.0.1dev-jar-with-dependencies.jar
IRPPROTOCOLS_XML := $(IRPHOME)/IrpProtocols.xml 
XSLT_DIR := $(IRPHOME)/xslt
LIRC_TRANSFORM=$(XSLT_DIR)/lirc.xsl

IRPTRANSMOGRIFIER := $(JAVA) -jar $(IRP_TRANSMOGRIFIER_JAR) -c $(IRPPROTOCOLS_XML)
SAXON := $(JAVA) -jar $(SAXON_JAR)