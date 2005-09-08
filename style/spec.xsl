<?xml version= "1.0" standalone="no"?>

<!--FIX OUTPUTED DOCTYPE THAT IS IMPORTED FROM basic.xsl-->           

<!--
This stylesheet is specialized to convert specifications.
It adds a table of contents and makes some other small changes.

It applies the templates in this stylesheet with the highest priority,
then templates in xhtml.xsl, and then uses the
identity transformation (ident.xsl) for the remaining tags, leaving
them unaltered.  Theoretically, every tag should be transformed.

This stylesheet is appropriate for CNXML documents that contain no
MathML.  The output is XHTML.
-->
           
<xsl:stylesheet version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:cnx="http://cnx.rice.edu/cnxml/0.3.5"
  xmlns="http://www.w3.org/1999/xhtml">

  <!-- Use identity transform as a last resort -->
  <xsl:import href="common/ident.xsl"/>
  
  <!-- Core cnxml transform is the highest priority -->
  <xsl:import href="common/corecnxml.xsl"/>

  <!-- XHTML is the highest priority. -->
  <xsl:import href="common/common_xhtml.xsl"/>

  <!-- tweeks -->
  <xsl:import href="spec/spec_tweeks.xsl"/>
  
</xsl:stylesheet>
