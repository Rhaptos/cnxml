<xsl:stylesheet version="1.0" 
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:m="http://www.w3.org/1998/Math/MathML">

  <!-- connexion macros -->
  <xsl:import href="../../../../mathml2/style/cnxmathmlc2p.xsl"/>
  <!-- print override of mathmlc2p.xsl -->
  <xsl:import href="printmathmlc2p.xsl"/>


<!-- MATH -->
  <xsl:template match="m:math">
    <m:math>
      <xsl:choose>

	<!-- If they specified a display mode, use it -->
	<xsl:when test="@display">
	  <xsl:attribute name="display">
	    <xsl:value-of select="@display"/>
	  </xsl:attribute>
	</xsl:when>

	<!-- Otherwise, explicitly set equations to display 'block' -->
	<xsl:otherwise>
	  <xsl:if test="parent::*[local-name()='equation']">
	    <xsl:attribute name="display">block</xsl:attribute>
	  </xsl:if>
	</xsl:otherwise>

      </xsl:choose>
      <xsl:apply-templates/>
    </m:math>
  </xsl:template>

</xsl:stylesheet>