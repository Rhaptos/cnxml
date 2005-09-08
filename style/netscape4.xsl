<?xml version= "1.0" standalone="no"?>

<!-- for netscape 4.* -->

<xsl:stylesheet version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:cnx="http://cnx.rice.edu/cnxml/0.3.5"
  xmlns="http://www.w3.org/1999/xhtml">

  <!-- Use identity transform as a last resort -->
  <xsl:import href="common/ident.xsl"/>

  <!-- QML is the next highest priority -->
  <xsl:import href="common/qml.xsl"/>
  
  <!-- Core cnxml transform is the highest priority -->
  <xsl:import href="common/corecnxml.xsl"/>

  <!-- the xhtml stuff that is common -->
  <xsl:import href="common/common_xhtml.xsl"/>

  <!-- tweeks for the header stuff -->
  <xsl:import href="netscape4/netscape4_tweeks.xsl"/>

  <!-- What does Netscape want?  Not XML. -->
  <xsl:output method="html" encoding="iso-8859-1"/>
 
</xsl:stylesheet>
