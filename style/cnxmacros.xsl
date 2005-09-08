<?xml version= "1.0" standalone="no"?>
                      
<xsl:stylesheet version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:m="http://www.w3.org/1998/Math/MathML"
  xmlns:mx="http://cnx.rice.edu/macros"
  xmlns="http://www.w3.org/1999/xhtml">

  <xsl:template match="/">
    <xsl:apply-templates/>
  </xsl:template>
    
  <xsl:template match="m:apply[mx:vecind]">
    <m:mrow>
      <xsl:apply-templates select="child::*[position()=2]"/>
      <m:mfenced open="[" close="]">
	<m:mrow>
	  <xsl:apply-templates select="child::*[position()=3]"/>
	</m:mrow>
      </m:mfenced>
    </m:mrow>
  </xsl:template>

  <xsl:template match="m:apply[mx:seqind]">
    <m:mrow>
      <m:msub>
	<xsl:apply-templates select="child::*[position()=2]"/>
	<xsl:apply-templates select="child::*[position()=3]"/>
      </m:msub>
    </m:mrow>
  </xsl:template>

  <xsl:template match="m:apply[mx:complexn]">
    <m:mrow>
      <m:msup>
	<mi>&#x2102;</mi>
	<xsl:apply-templates select="child::*[position()=2]"/>
      </m:msup>
    </m:mrow>
  </xsl:template>
  
</xsl:stylesheet>
  