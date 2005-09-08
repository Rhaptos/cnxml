<xsl:stylesheet version="1.0" 
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:m="http://www.w3.org/1998/Math/MathML">


  <!-- math imports -->
  <xsl:import href="mathmlc2p.xsl"/>
  <!-- connexion macros -->
  <xsl:import href="../cnxmathmlc2p.xsl"/>


<!-- MATH -->
  <xsl:template match="m:math">
    <m:math>
      <xsl:if test="@display">
	<xsl:attribute name="display">
	  <xsl:value-of select="@display"/>
	</xsl:attribute>
      </xsl:if>
      <xsl:apply-templates/>
    </m:math>
  </xsl:template>

</xsl:stylesheet>