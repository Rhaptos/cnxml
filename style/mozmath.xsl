<?xml version= "1.0"?>

<!-- for mozilla -->

<xsl:stylesheet version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
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
  <xsl:import href="../../../mathml2/style/cnxmathmlc2p.xsl"/>

  <!-- tweeks for the header stuff -->
  <xsl:import href="mozilla/moz_tweeks.xsl"/>

  <!-- tweeks for the math -->
  <xsl:import href="mozilla/mozmath.xsl"/>
 

  <xsl:output 
    doctype-public="-//W3C//DTD XHTML 1.1 plus MathML 2.0//EN"
    doctype-system="http://www.w3.org/TR/MathML2/dtd/xhtml-math11-f.dtd"
    omit-xml-declaration="no"
    indent="yes"/>

</xsl:stylesheet>