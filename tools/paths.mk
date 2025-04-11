# External programs

INSTALLDIR := /usr/local/share/irptransmogrifier
BINLINK := /usr/local/bin/irptransmogrifier
BROWSELINK := /usr/local/bin/irpbrowse

BROWSE := xdg-open
JAVA := java
SAXON_JAR := /opt/saxon/saxon9he.jar
SAXON := $(JAVA) -jar $(SAXON_JAR)
XSLTPROC := xsltproc
IRPTRANSMOGRIFIER_HOME := $(TOP)/../IrpTransmogrifier
IRPTRANSMOGRIFIER_JAR := $(wildcard $(IRPTRANSMOGRIFIER_HOME)/target/IrpTransmogrifier-*jar-with-dependencies.jar)
IRPTRANSMOGRIFIER := ${JAVA} -jar $(IRPTRANSMOGRIFIER_JAR) -c ${IRPTRANSMOGRIFIER_HOME}/target/IrpProtocols.xml
IRSCRUTINIZER_HOME := $(TOP)/../IrScrutinizer
OLD_LIRC_XML := $(IRSCRUTINIZER_HOME)/src/main/config/exportformats.d/lirc.xml
