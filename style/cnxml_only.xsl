<?xml version= "1.0" standalone="no"?>

<!-- for mozilla / cnxml-only (well, almost) -->

<xsl:stylesheet version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:cnx="http://cnx.rice.edu/cnxml/0.4"
  xmlns:md="http://cnx.rice.edu/mdml/0.4"  
  xmlns="http://www.w3.org/1999/xhtml">

  <!-- Use identity transform as a last resort -->
  <xsl:import href="common/ident.xsl"/>

  <!-- QML is the next highest priority -->
  <xsl:import href="common/qml.xsl"/>
  
  <!-- CNXML_ONLY_TWEEKS -->
  <xsl:import href="cnxml_only/cnxml_only_tweeks.xsl"/>

</xsl:stylesheet>





