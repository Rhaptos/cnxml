<?xml version= "1.0" standalone="no"?>

<!--CHECK HOW IMPORTS WITH MATH-->
<!--CHECK IF CNXN STILL WORKS RIGHT with eqn-->
<!--FIX OUTPUT DTD-->

<!--
This stylesheet transforms a CNXML document, with math, for display in an XML enabled browser.  

It transforms the math from Content MathML to Presentation MathML
first (using mathmlc2p.xsl), then applies the basic.xsl tranformation.
basic.xsl converts things from cnxml into an altered xml, for example xlinks that need to be transformed into XHTML for
display in a browser, then uses the identity transformation
(ident.xsl) for the remaining tags, leaving them unaltered.

This stylesheet is appropriate for CNXML documents that contain
Content MathML.  The output is a combination of mostly CNXML, with some XHTML
and Presentation MathML.
-->
                            
<xsl:stylesheet version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:m="http://www.w3.org/1998/Math/MathML"
  xmlns:cnx="http://cnx.rice.edu/cnxml/0.3"
  xmlns:xlink="http://www.w3.org/1999/xlink"
  xmlns="http://www.w3.org/1999/xhtml"
  exclude-result-prefixes="cnx m #default">

  <!-- Basic is the highest priority -->
  <xsl:import href="basic.xsl"/>

  <!-- Connexion macros -->
  <xsl:import href="../../../mathml2/style/cnxmathmlc2p.xsl"/>


  <xsl:output doctype-system="http://cnx.rice.edu/cnxml/0.3/DTD/mozcompat.ent"
    omit-xml-declaration="no"
    indent="yes"/>

<!-- MATH -->
  <!--This is the template for math.-->
  <xsl:template match="m:math">
    <m:math>
      <xsl:if test="@*[local-name()='display']">
	<xsl:attribute name="display">
	  <xsl:value-of select="@display"/>
	</xsl:attribute>
      </xsl:if>
      <xsl:apply-templates/>
    </m:math>
  </xsl:template>
  
</xsl:stylesheet>





















