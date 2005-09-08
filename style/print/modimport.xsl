<?xml version= "1.0" standalone="no"?>

<xsl:stylesheet version="1.0" 
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:cnxml="http://cnx.rice.edu/cnxml/0.3.5">


  <!-- For module, we copy authors, keywords, and content.  That's it -->
  <xsl:template match="cnxml:module">
    <xsl:apply-templates select="//cnxml:author"/>
    <xsl:apply-templates select="//cnxml:keyword"/>
    <xsl:apply-templates select="cnxml:content"/>
  </xsl:template>

  <!-- Concatenate the IDs: -->
  <!-- The id of each elements is concatenated with the module id to -->
  <!-- make it unique within the course. The two ids are separated by an *.-->
  <xsl:template match="@id">
    <xsl:attribute name="id">
      <xsl:value-of select="ancestor::cnxml:module/@id"/>*<xsl:value-of select="."/>
    </xsl:attribute>
  </xsl:template>
  
  <!-- And since the ids are concatenated, the 'target' attribute must -->
  <!-- be modified to refect this -->
  <xsl:template match="cnxml:cnxn/@target">
    <xsl:attribute name="target">
      <xsl:choose>
	<!--Case 1: If cnxn has a module attribute, concatenate that
	value with the target attribute.-->
	<xsl:when test="../@module">
	  <xsl:value-of select="../@module"/>*<xsl:value-of select="."/>
	</xsl:when>
	<!--Case 2: If cnxn does not have a module attribute,
	concatenate the id of the current module with the target
	attribute.-->
	<xsl:otherwise>
	  <xsl:value-of select="ancestor::cnxml:module/@id"/>*<xsl:value-of select="."/>
	</xsl:otherwise>
      </xsl:choose>
    </xsl:attribute>
  </xsl:template>

  <!-- Transform to common author format -->
  <xsl:template match="cnxml:author">
    <author id="{@id}">
      <firstname><xsl:value-of select="cnxml:firstname"/></firstname>
      <surname><xsl:value-of select="cnxml:surname"/></surname>
    </author>
  </xsl:template>

  <!-- Transform to common keyword format -->
  <xsl:template match="cnxml:keyword">
    <keyword><xsl:value-of select="."/></keyword>
  </xsl:template>

  <!-- Grab the content -->
  <xsl:template match="cnxml:content">
    <cnxml:content>
      <xsl:apply-templates />
    </cnxml:content>
  </xsl:template>

  <!-- Default copying rule for cnxml tags -->
  <xsl:template match="cnxml:content//*|@*">
    <xsl:copy>
      <!-- Must copy the attributes first and separately, so that the
      templates for 'id' and 'target' are guaranteed to match *before*
      we've copied over any children (See XSLT spec 7.1.3 and and
      Michael Kay's XSLT ref. p 167 for rationale) -->
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="node()"/>
    </xsl:copy>
  </xsl:template>
  
  
</xsl:stylesheet>
