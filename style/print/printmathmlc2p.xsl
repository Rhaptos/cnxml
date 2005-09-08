<?xml version="1.0" encoding="UTF-8"?> 
<!DOCTYPE xsl:stylesheet SYSTEM "http://cnx.rice.edu/cnxml/0.4/DTD/moz-mathml.ent">

<xsl:stylesheet version="1.0" 
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:cnx="cnxml"
		xmlns:m="http://www.w3.org/1998/Math/MathML"
                xmlns="http://www.w3.org/1998/Math/MathML" >
  

<!--=-=-=-=-=-=-=-=- EXPONENTIAL E -=-=-=-=-=-=-=-=-=-=-=-->
<!-- exponential -->
<xsl:template match="m:apply[child::*[position()=1 and local-name()='exp']]">
  <msup>
    <mi><xsl:text disable-output-escaping="yes">e</xsl:text></mi>   <!-- ExponentialE does not work yet -->
    <xsl:apply-templates select="child::*[position()=2]"/>
  </msup>
</xsl:template>

<xsl:template match="m:exp[local-name(preceding-sibling::*[position()=last()])='compose' or local-name(preceding-sibling::*[position()=last()])='inverse']">
  <mi><xsl:text disable-output-escaping="yes">e</xsl:text></mi>   <!-- used with inverse or composition; not sure it is appropriate for exponential-->
</xsl:template>

<!-- exponential base -->
<xsl:template match="m:exponentiale">
  <mi><xsl:text disable-output-escaping="yes">e</xsl:text></mi>  <!-- ExponentialE does not work yet -->
</xsl:template>

<!--=-=-=-=-=-=-=-=-=-=-= MOVER and MUNDER =-=-=-=-=-=-=-=-=-=-=-=-->


<!--=-=-=-=-=-=-=-=-=-= LESS THEN and GREATER THAN =-=-=-=-=-=-=-=-->
<!-- less than -->
<xsl:template name="ltRelprint">
  <xsl:choose>
  <xsl:when test="count(child::*)>=3">
    <mrow>
      <xsl:for-each select="child::*[position()!=1 and position()!=last()]">
	<xsl:apply-templates select="."/><mo><m:mtext> <xsl:text
	disable-output-escaping="yes"> <![CDATA[&lt;]]> </xsl:text> </m:mtext></mo>
      </xsl:for-each>
      <xsl:apply-templates select="child::*[position()=last()]"/>
    </mrow>
  </xsl:when>
  <xsl:when test="count(child::*)=2">
    <mrow>
      <mo><m:mtext> <xsl:text
      disable-output-escaping="yes"> <![CDATA[&lt;]]> </xsl:text> </m:mtext></mo><xsl:apply-templates select="child::*[position()=2]"/>
    </mrow>
  </xsl:when>
  <xsl:otherwise>
    <mo><m:mtext> <xsl:text
    disable-output-escaping="yes"> <![CDATA[&lt;]]> </xsl:text> </m:mtext></mo>
  </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template match="m:apply[child::*[position()=1 and local-name()='lt']]">
  <xsl:call-template name="ltRelprint"/>
</xsl:template>

<xsl:template match="m:reln[child::*[position()=1 and local-name()='lt']]">
  <xsl:call-template name="ltRelprint"/>
</xsl:template>

<!-- greater than -->
<xsl:template name="gtRelprint">
  <xsl:choose>
  <xsl:when test="count(child::*)>=3">
    <mrow>
      <xsl:for-each select="child::*[position()!=1 and position()!=last()]">
	<xsl:apply-templates select="."/><mo><m:mtext> <xsl:text
	disable-output-escaping="yes"> &gt; </xsl:text> </m:mtext></mo>
      </xsl:for-each>
      <xsl:apply-templates select="child::*[position()=last()]"/>
    </mrow>
  </xsl:when>
  <xsl:when test="count(child::*)=2">
    <mrow>
      <mo><m:mtext> <xsl:text disable-output-escaping="yes"> &gt; </xsl:text> </m:mtext></mo><xsl:apply-templates select="child::*[position()=2]"/>
    </mrow>
  </xsl:when>
  <xsl:otherwise>
    <mo><m:mtext> <xsl:text disable-output-escaping="yes"> &gt; </xsl:text> </m:mtext></mo>
  </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template match="m:apply[child::*[position()=1 and local-name()='gt']]">
  <xsl:call-template name="gtRelprint"/>
</xsl:template>

<xsl:template match="m:reln[child::*[position()=1 and local-name()='gt']]">
  <xsl:call-template name="gtRelprint"/>
</xsl:template>

<!--=-=-=-=-=-=-=-=-=-=-=-=-=-= &iff; -=-=-=-=-=-=-=-=-=-=-=-=-=-->

  <xsl:template match="m:apply[child::*[position()=1 and local-name()='mo']]">
    <!--operator assumed to be infix-->
    <xsl:choose>
      <xsl:when test="count(child::*)>=3">
	<mrow>
	  <mfenced open='(' close=')' separators=" ">
	    <xsl:for-each select="child::*[position()!=last() and  position()!=1]">
	      <xsl:apply-templates select="."/>
	      <xsl:choose>
		<xsl:when test="contains(preceding-sibling::m:mo/text(),
		  '&iff;')"> <!--this is the print override, &iff; is not
		  showing up in latex --> 
		  <m:mo><m:mtext> iff </m:mtext></m:mo>
		</xsl:when>
		<xsl:otherwise>
		  <xsl:copy-of select="preceding-sibling::m:mo"/>
		</xsl:otherwise>
	      </xsl:choose>
	    </xsl:for-each>
	    <xsl:apply-templates select="child::*[position()!=1 and position()=last()]"/>
	  </mfenced>
	</mrow>
      </xsl:when>
	<!-- Unary operation --><!-- tests added to check for Laplace
	and Fourier Transform Symbols-->
      <xsl:otherwise>
	<xsl:choose>
	  <xsl:when test="contains(m:mo/text(),
		    '&Laplacetrf;')">
	    <mrow><xsl:copy-of
	    select="child::m:mo[position()=1]"/><mfenced open="{" close="}"><xsl:apply-templates select="child::*[position()=2]"/></mfenced></mrow>
	  </xsl:when>
	  <xsl:when test="contains(m:mo/text(),
		    '&Fouriertrf;')">
	    <mrow><xsl:copy-of select="child::m:mo[position()=1]"/><mfenced open='{' close='}'><xsl:apply-templates select="child::*[position()=2]"/></mfenced></mrow>
	  </xsl:when>
	<!--this was the original before tests  <xsl:when
	  test="count(child::*)=2"> -->
	  <xsl:otherwise>
	    <mrow><xsl:copy-of select="child::m:mo[position()=1]"/><xsl:apply-templates select="child::*[position()=2]"/></mrow>
	  </xsl:otherwise>
	</xsl:choose>
      </xsl:otherwise>
  <!--    <xsl:when test="count(child::*)=2">
	<mrow><xsl:copy-of select="child::m:mo[position()=1]"/><xsl:apply-templates select="child::*[position()=2]"/></mrow>
      </xsl:when> -->
    </xsl:choose>
  </xsl:template>


  <!--=-=-=-=-=-=-=-=-=-=-=-=- EQUATION FORMATTING -=-=-=-=-=-=-=-=-=-=-=-=-->
  
  <!-- New equal for equation -->

  <xsl:template match="m:apply[child::*[position()=1 and local-name()='eq'] and ancestor::*[local-name()='equation']]">
    <xsl:choose>
      <xsl:when test="count(child::*)>3">
	<m:mtable align="center" rowspacing="10pt">
	  <m:mtr>
	    <m:mtd align="right">
	      <m:mrow><xsl:apply-templates select="child::*[position()=2]"/></m:mrow>
	    </m:mtd>
	    <m:mtd align="center"><m:mo>=</m:mo></m:mtd>
	    <m:mtd align="left">
	      <m:mrow><xsl:apply-templates select="child::*[position()=3]"/></m:mrow>
	    </m:mtd>
	  </m:mtr>
	  <xsl:for-each select="child::*[position()>3]">
	    <m:mtr>
	      <m:mtd align="right"></m:mtd>
	      <m:mtd align="center"><m:mo>=</m:mo></m:mtd>
	      <m:mtd align="left">
		<m:mrow><xsl:apply-templates select="."/></m:mrow>
	      </m:mtd>
	    </m:mtr>
	  </xsl:for-each>
	</m:mtable>
      </xsl:when>
      <xsl:otherwise>
	<m:mrow><xsl:apply-templates select="child::*[position()=2]"/></m:mrow>
        <m:mrow><m:mo>=</m:mo></m:mrow>
        <m:mrow><xsl:apply-templates select="child::*[position()=last()]"/></m:mrow>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>


</xsl:stylesheet>