<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="1.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:qml="http://cnx.rice.edu/qml/1.0"
		xmlns:fo="http://www.w3.org/1999/XSL/Format">

  <xsl:template match="qml:item">
    <!-- FIXME: We should only do this if we're in a problemset tag -->
    <fo:block space-before=".5cm"
	      space-after=".5cm"
	      margin-left="1cm"
	      margin-right="1cm"
	      padding-left=".2cm">
      <xsl:copy-of select="@id"/>
      <fo:inline font-weight="bold">
	Problem: 
	<xsl:choose>
	  <xsl:when test="@number">
	    <xsl:value-of select="@number"/>:
	  </xsl:when>
	  <xsl:otherwise>
	    <xsl:number count="qml:item" level="any" />:
	  </xsl:otherwise>
	</xsl:choose>
      </fo:inline>
      
      <xsl:apply-templates select="qml:question"/>
      <xsl:apply-templates select="qml:key"/>
      <xsl:if test="@type!='text-response'">
	<xsl:apply-templates select="qml:answer"/>
      </xsl:if>
      <xsl:if test="qml:hint">
	<fo:block margin-left="10pt"
	  space-before="5pt"
	  space-after="5pt">
	  (Hint:
	  <xsl:apply-templates select="qml:hint"/>)
	</fo:block>
      </xsl:if>    
    </fo:block>
  </xsl:template>
  

  <xsl:template match="qml:question">
    <xsl:apply-templates/>
  </xsl:template>
  

  <xsl:template match="qml:answer">
    <fo:block margin-left="25pt">
      <xsl:apply-templates />
    </fo:block>
  </xsl:template>

  
  <xsl:template match="qml:response">
    <xsl:number count="qml:answer" format=" a) "/>
    <xsl:apply-templates />
  </xsl:template>  


  <xsl:template match="qml:hint">
    <xsl:text> </xsl:text>
    <xsl:apply-templates /> 
  </xsl:template>
	

  <xsl:template match="qml:feedback">
  </xsl:template>


  <xsl:template match="qml:key">
    <fo:footnote>
      <fo:footnote-citation>
	<fo:inline font-size="10pt" vertical-align="super">
	  <xsl:number format="1" 
		      level="any" 
		      count="qml:key|*[local-name()='solution' or local-name()='note' and @type='footnote']"/>
	</fo:inline>
      </fo:footnote-citation>
      <fo:footnote-body>
	<fo:inline font-size="10pt" vertical-align="super">
	  <xsl:number format="1" 
		      level="any" 
	              count="qml:key|*[local-name()='solution' or local-name()='note' and @type='footnote']"/>
	</fo:inline>
	<xsl:call-template name="solution" />
      </fo:footnote-body>
    </fo:footnote>
  </xsl:template>


  <xsl:template name="solution">
    <xsl:choose>
      <xsl:when test="parent::*[@type='text-response']">
      </xsl:when>
      <xsl:when test="parent::*[@type='single-response']">
	<xsl:variable name="answer" select="@answer"/>
	<xsl:number
       value="count(../qml:answer[following-sibling::qml:answer[@id=$answer]])+1"
	format=" a) "/>
	<xsl:value-of select="../qml:answer[@id=$answer]/qml:response" /> 
	<xsl:text> </xsl:text>
      </xsl:when>
      <xsl:when test="parent::*[@type='multiple-response']|parent::*[@type='ordered-response']">

	<xsl:call-template name="loop-through-answers"/>

      </xsl:when> 
      <xsl:otherwise>
	Stylesheet ERROR. Did not match a type of QML item in qml.xsl.
      </xsl:otherwise>
    </xsl:choose>
    <xsl:text> </xsl:text>
    <xsl:value-of select="../qml:feedback"/>
  </xsl:template>

  
  <xsl:template name="loop-through-answers">
    <xsl:param name="answer-string" select="@answer"/>
    <xsl:param name="order-num" select="1"/>
    <xsl:if test="parent::*[@type='ordered-response']">
      <xsl:text> </xsl:text>
      <xsl:value-of select="$order-num"/>- 
    </xsl:if>
    <xsl:choose>
      <xsl:when test="contains($answer-string,',')">
	<xsl:call-template name="print-answer">
	  <xsl:with-param name="answer-string"
	  select="substring-before($answer-string, ',')"/>
	</xsl:call-template>
	<xsl:call-template name="loop-through-answers">
	  <xsl:with-param name="answer-string"
	  select="substring-after($answer-string, ',')"/>
	  <xsl:with-param name="order-num" select="$order-num + 1"/>
	</xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
	<xsl:call-template name="print-answer">
	  <xsl:with-param name="answer-string" select="$answer-string"/>
	</xsl:call-template>
      </xsl:otherwise>
    </xsl:choose>
    
  </xsl:template>


  <xsl:template name="print-answer">
    <xsl:param name="answer-string" />

    <xsl:number
        value="count(../qml:answer[following-sibling::qml:answer[@id=$answer-string]])+1"
        format=" a) "/>
    <xsl:value-of select="../qml:answer[@id=$answer-string]/qml:response" />
  </xsl:template> 
  

</xsl:stylesheet>








