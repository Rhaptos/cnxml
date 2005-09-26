#!/bin/sh

OPTIONS=''
PREFIX=/usr
CATALOGS=1
USAGE='install.sh [-v] [-n] [-p prefix]'

while [ $# -ge 1 ]; do
        case $1 in
        -v)     OPTIONS="$OPTIONS $1" ;;
        -n)     CATALOGS=0 ;;
        -prefix)    PREFIX=`echo $1 | cut -c3-`;;
        -p)     shift;  PREFIX=$1 ;;
        -*)     echo $USAGE; exit 1 ;;
        *)      disks=$*;       break   ;;
        esac

        shift
done

XML_DIR=$PREFIX/share/xml
DTD_DIR=$XML_DIR/cnxml/schema/dtd/0.5
XSD_DIR=$XML_DIR/cnxml/schema/xsd/0.5
RNG_DIR=$XML_DIR/cnxml/schema/rng/0.5
XSL_DIR=$XML_DIR/cnxml/stylesheet
MISC_DIR=$XML_DIR/cnxml/misc
MDML_DIR=$XML_DIR/mdml/schema/dtd/0.4

install $OPTIONS -m 755 -d $DTD_DIR
install $OPTIONS -m 644 DTD/cnxml*.* $DTD_DIR

install $OPTIONS -m 755 -d $XSD_DIR
install $OPTIONS -m 644 schema/*.xsd $XSD_DIR

install $OPTIONS -m 755 -d $RNG_DIR
install $OPTIONS -m 644 schema/*.rng $RNG_DIR

install $OPTIONS -m 755 -d $XSL_DIR
install $OPTIONS -m 644 style/*.xsl $XSL_DIR

install $OPTIONS -d $MISC_DIR
install $OPTIONS cnxml.sps $MISC_DIR
install $OPTIONS xmlspy_template.xml $MISC_DIR

install $OPTIONS -d $MDML_DIR
install $OPTIONS DTD/mdml*.* $MDML_DIR

install $OPTIONS -m 644 catalog.xml $XML_DIR/cnxml

if [ $CATALOGS -ne 0 ]; then
  xmlcatalog --noout --add "delegatePublic" "-//CNX//DTD CNXML" "file://$XML_DIR/cnxml/catalog.xml" /etc/xml/catalog
  xmlcatalog --noout --add "delegatePublic" "-//CNX//DTD MDML" "file://$XML_DIR/cnxml/catalog.xml" /etc/xml/catalog
  xmlcatalog --noout --add "delegatePublic" "-//CNX//ENTITIES MDML" "file://$XML_DIR/cnxml/catalog.xml" /etc/xml/catalog
  xmlcatalog --noout --add "delegatePublic" "-//CNX//ELEMENTS MDML" "file://$XML_DIR/cnxml/catalog.xml" /etc/xml/catalog
  xmlcatalog --noout --add "delegateSystem" "http://cnx.rice.edu/technology/cnxml" "file://$XML_DIR/cnxml/catalog.xml" /etc/xml/catalog
  xmlcatalog --noout --add "delegateSystem" "http://cnx.rice.edu/technology/mdml" "file://$XML_DIR/cnxml/catalog.xml" /etc/xml/catalog
fi
