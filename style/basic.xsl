<?xml version= "1.0" standalone="no"?>

<!--FIX xsl DOCTYPE-->
<!--CHECK HOW IMPORTS WITH MATH-->
<!--CHECK IF CNXN STILL WORKS RIGHT with eqn-->
<!--FIX OUTPUT DTD-->
                            

<!--
This stylesheet transforms a CNXML document, with no math, for
display in an XML enabled browser.  

It applies the templates in corecnxml.xsl first, then uses the
identity transformation (ident.xsl) for the remaining tags, leaving
them unaltered.

This stylesheet is appropriate for CNXML documents that contain no
MathML.  The output is a combination of CNXML, and XHTML.
-->


<xsl:stylesheet version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <!-- Use identity transform as a last resort -->
  <xsl:import href="ident.xsl"/>
  
  <!-- Core cnxml transform is the highest priority -->
  <xsl:import href="corecnxml.xsl"/>

  <xsl:output doctype-system="http://cnx.rice.edu/cnxml/0.2/DTD/mozcompat.ent"
	      omit-xml-declaration="no"
	      indent="yes"/>
  
  <!-- Root Node (which is MODULE) -->
  <xsl:template match="/">

    <!--Allow access to multiple stylesheets.-->
    <xsl:processing-instruction name="xml-stylesheet">
      type="text/css" title="Default" media="screen"
      href="http://cnx.rice.edu/cnxml/0.2/style/exp/cnxml1.css"
    </xsl:processing-instruction>
    
    <xsl:processing-instruction name="xml-stylesheet">
      type="text/css" title="Style 2" media="screen" alternate="yes"
      href="http://cnx.rice.edu/cnxml/0.2/style/exp/cnxml2.css"
    </xsl:processing-instruction>

    <xsl:processing-instruction name="xml-stylesheet">
      type="text/css" title="Style 3" media="screen" alternate="yes"
      href="http://cnx.rice.edu/cnxml/0.2/style/exp/cnxml3.css"
    </xsl:processing-instruction>

    <xsl:processing-instruction name="xml-stylesheet">
      type="text/css" title="Style 4" media="screen" alternate="yes"
      href="http://cnx.rice.edu/cnxml/0.2/style/exp/cnxml4.css"
    </xsl:processing-instruction>
    
    <xsl:apply-templates/>

  </xsl:template>
  
</xsl:stylesheet>



















