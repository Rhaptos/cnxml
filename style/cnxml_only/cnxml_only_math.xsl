<?xml version= "1.0"?>

<!-- Mozilla math tweaks -->

<xsl:stylesheet version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:m="http://www.w3.org/1998/Math/MathML"
  xmlns:cnx="http://cnx.rice.edu/cnxml/0.3.5"
  xmlns="http://www.w3.org/1999/xhtml">

  <!--This is the template for math.-->
  <xsl:template match="m:math">
    <m:math>
      <xsl:choose>

        <!-- If they specified a display mode, translate it to
	mozilla's broken MathML1.0 'mode' attribute -->
        <xsl:when test="@display='inline'">
          <xsl:attribute name="mode">inline</xsl:attribute>
        </xsl:when>
        <xsl:when test="@display='block'">
          <xsl:attribute name="mode">display</xsl:attribute>
        </xsl:when>

        <!-- Otherwise, explicitly set equations to mode 'display' -->
        <xsl:otherwise>
          <xsl:if test="parent::*[local-name()='equation']">
            <xsl:attribute name="mode">display</xsl:attribute>
          </xsl:if>
        </xsl:otherwise>
      </xsl:choose>
      <m:semantics>
	<xsl:apply-templates/>
	<m:annotation-xml encoding="MathML-Content">
	  <xsl:copy-of select='child::*'/>
	</m:annotation-xml>
      </m:semantics>
    </m:math>
  </xsl:template>

  <!--EQUATION-->
  <xsl:template match="cnx:equation">
    <!--do something with the para because eqn can go in paras-->

      <xsl:copy>
        <xsl:copy-of select="@*" />
	<table class="equation" width="100%" cellpadding="0" cellspacing="0" border="0"> 
	  <tr>
	    <td><!--<name><xsl:value-of select="cnx:name/text()" 
	      /></name>--> </td>
	    <td></td>
	  </tr>
	  <tr>
	    <td><xsl:apply-templates/></td>
	    <td width="15" align="right" valign="middle"><span 
							       class="equation-number">	
		<xsl:number level="any" count="cnx:equation"
			    format="(1)"/> 
	      </span>
	      <!--
	    <xsl:if test="$viewmath"> 
	    <a href="javascript:viewmath('{@id}');">(Source)</a>
	    </xsl:if>
	      -->
	    </td>
	  </tr>
	</table>
      </xsl:copy>
    
  </xsl:template>

</xsl:stylesheet>

