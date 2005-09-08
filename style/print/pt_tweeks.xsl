
  <xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:m="http://www.w3.org/1998/Math/MathML">
    
    <xsl:import href="../common/ident.xsl" />

    <xsl:template match="m:mfenced">
      <m:mfenced>
      <xsl:if test="@open">
	<xsl:attribute name="open"><xsl:value-of
	    select="@open"/></xsl:attribute>
      </xsl:if>
      <xsl:if test="@close">
	<xsl:attribute name="close"><xsl:value-of
	    select="@close"/></xsl:attribute>
      </xsl:if>
	<xsl:for-each select="*">	
	  <xsl:apply-templates select="."/>
	  <xsl:if test="not(position() = last())">
	    <xsl:choose>
	      <xsl:when test="../@separators">
		<m:mo><xsl:value-of select="../@separators"/> </m:mo>
	      </xsl:when>
	      <xsl:otherwise>
		<m:mo>, </m:mo>
	      </xsl:otherwise>
	    </xsl:choose>
	  </xsl:if>
	</xsl:for-each>
      </m:mfenced>
    </xsl:template>

  <xsl:template match="m:munderover">
    <m:msubsup>
      <xsl:apply-templates/>
    </m:msubsup>
  </xsl:template>
 
  
</xsl:stylesheet>
  