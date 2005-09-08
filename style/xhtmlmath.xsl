<?xml version= "1.0" standalone="no"?>

<!--FIX OUTPUTED DOCTYPE THAT IS IMPORTED FROM basic.xsl-->           

<!--
This stylesheet transforms a CNXML document, with math, for
display in an HTML and MathML enabled browser.  

It applies the templates in this stylesheet first, then corecnxml.xsl,
then transforms math, and then uses the identity transformation
(ident.xsl) for the remaining tags, leaving them unaltered.
Theoretically, every tag should be transformed.

This stylesheet is appropriate for CNXML documents that contain
Content MathML.  The output is XHTML and Presentation MathML.
-->
           
<xsl:stylesheet version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:m="http://www.w3.org/1998/Math/MathML"
  xmlns:cnx="http://cnx.rice.edu/cnxml/0.3"
  xmlns="http://www.w3.org/1999/xhtml"
 ><!-- exclude-result-prefixes="cnx m"-->

  <!-- Core cnxml transform  -->
  <xsl:import href="xhtml.xsl"/>

  <!-- Use math for only math tags -->
  <xsl:import href="../../../mathml2/style/mathmlc2p.xsl"/>


  <xsl:output 
    doctype-system="http://cnx.rice.edu/cnxml/0.3/DTD/mozcompat.ent"
    omit-xml-declaration="no"
    indent="yes"/>


  <!--This is the template for math.-->
  <xsl:template match="m:math">
    <m:math>
      <xsl:if test="@display='block'">
	<xsl:attribute name="mode">display</xsl:attribute>
      </xsl:if>
      <xsl:apply-templates/>
    </m:math>
  </xsl:template>
  

  <xsl:template match="cnx:equation/m:math">
    <m:math>
      <xsl:choose>
	<xsl:when test="@display='inline'">
	  <xsl:attribute name="mode">inline</xsl:attribute>
	</xsl:when>
	<xsl:otherwise>
	  <xsl:attribute name="mode">display</xsl:attribute>
	</xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates/>
    </m:math>
  </xsl:template>


  <!--EQUATION-->
  <xsl:template match="cnx:equation">
    <!--do something with the para because eqn can go in paras-->

      <a name="{@id}">	
	<table class="equation" width="100%"> 
          <tr><td></td>
            <td class="name"> <xsl:value-of select="cnx:name/text()" /> </td>
              <td></td>
          </tr>
          <tr>
	    <td width="15"></td>     
	    <td align="center">
	      <xsl:apply-templates/>
	    </td>
	    <td width="15" align="right">	
	      <xsl:number level="any" count="cnx:equation" format="(1)"/>
	    </td>
	  </tr>
	</table>
      </a>
 
  </xsl:template>

</xsl:stylesheet>

















