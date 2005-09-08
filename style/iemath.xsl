<?xml version= "1.0" standalone="no"?>

<!-- for ie with Math support -->

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

  <!-- Connexion macros -->
  <xsl:import href="http://cnx.rice.edu/technology/mathml2/style/cnxmathmlc2p.xsl"/>

  <!-- tweeks for IE specific stuff -->
  <xsl:import href="ie/ie_tweeks.xsl"/>

  <!-- tweeks for IE math -->
  <xsl:import href="ie/iemath_tweeks.xsl"/>

  <!-- XML for Math -->
  <xsl:output method="xml"/>

</xsl:stylesheet>
