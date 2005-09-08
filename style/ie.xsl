<?xml version= "1.0" standalone="no"?>

<!-- for ie -->

<xsl:stylesheet version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:cnx="http://cnx.rice.edu/cnxml/0.4"
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
  <xsl:import href="ie/ie_tweeks.xsl"/>

  <!-- Override ie_tweeks to output 'no-mathml' blurb -->
  <xsl:param name="no-mathml" select="1" />

  <!-- IE wants HTML, not XML -->
  <xsl:output method="html"/>

 
</xsl:stylesheet>
