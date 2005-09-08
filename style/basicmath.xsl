<?xml version= "1.0" standalone="no"?>

<!--FIX xsl DOCTYPE-->
<!--CHECK HOW IMPORTS WITH MATH-->
<!--CHECK IF CNXN STILL WORKS RIGHT with eqn-->
<!--FIX OUTPUT DTD-->
                            
<xsl:stylesheet version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:m="http://www.w3.org/1998/Math/MathML"
  exclude-result-prefixes="m">

  <!-- Use identity transform as a last resort -->
  <xsl:import href="ident.xsl"/>

  <!-- Use math for only math tags -->
  <xsl:import href="../../../mathml2/style/mathmlc2p.xsl"/>

  <!-- Core cnxml transform is the highest priority -->
  <xsl:import href="corecnxml.xsl"/>

  <xsl:output doctype-system="http://cnx.rice.edu/cnxml/0.2/DTD/mozcompat.ent"
    omit-xml-declaration="no"
    indent="yes"/>

  <!-- Root Node -->
  <xsl:template match="/">

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



















