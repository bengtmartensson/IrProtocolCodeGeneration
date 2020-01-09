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
IRPTRANSMOGRIFIER := $(IRPTRANSMOGRIFIER_HOME)/tools/irptransmogrifier
IRSCRUTINIZER_HOME := $(TOP)/../harctoolboxbundle
OLD_LIRC_XML := $(IRSCRUTINIZER_HOME)/src/main/config/exportformats.d/lirc.xml
