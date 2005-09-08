<?xml version="1.0" encoding="utf-8"?>

  <xsl:stylesheet version="1.0"
		  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		  xmlns:fo="http://www.w3.org/1999/XSL/Format"
		  xmlns:ind="index">


  <xsl:template match="ind:indexlist">
    <!-- this is the control template which decides which templates to call
    next.  it assumes that the ind:item's are already sorted in alphabetical
    order. -->
    <xsl:for-each select="ind:item">
      <xsl:choose>
	<!-- when the first letter of this ind:item does not equal the first
	letter of the preceding ind:item then.... print out the new letter
	block, word and page.  -->
	<xsl:when test="translate(substring(normalize-space(.),1,1),
		  'abcdefghijklmnopqrstuvwxyz', 'ABCDEFGHIJKLMNOPQRSTUVWXYZ')
		  !=translate(substring(normalize-space(preceding-sibling::ind:item[1]),1,1),
		  'abcdefghijklmnopqrstuvwxyz', 'ABCDEFGHIJKLMNOPQRSTUVWXYZ')">

	  <xsl:call-template name="print-letter" />
	  <xsl:call-template name="print-word" />
	  <xsl:call-template name="print-page" />

	</xsl:when>
	<!-- when this ind:item does not equal the preceding ind:item
	then.... end the old word block, print out the new word and page --> 
	<xsl:when test="translate(normalize-space(.),
		  'abcdefghijklmnopqrstuvwxyz', 'ABCDEFGHIJKLMNOPQRSTUVWXYZ')
		  !=translate(normalize-space(preceding-sibling::ind:item[1]),
		  'abcdefghijklmnopqrstuvwxyz', 'ABCDEFGHIJKLMNOPQRSTUVWXYZ')">
	  
	  <xsl:text disable-output-escaping="yes">
	    &lt;/fo:block></xsl:text> <!-- ends the fo:block which contains the
	    preceding word and all the page numbers which belonged to that word
	    before calling print-word again to print out the new current word
	    --> 
	  
	  <xsl:call-template name="print-word" />
	  <xsl:call-template name="print-page" />

	</xsl:when>
	<!-- otherwise this word equals the preceding word, so it is only
	necessary to print another page number -->
	<xsl:otherwise>

	  <xsl:call-template name="print-page" />

	</xsl:otherwise>
      </xsl:choose>
    </xsl:for-each>

  </xsl:template>


  <xsl:template name="print-letter">
    <fo:block font-weight="bold"
	      font-size="14pt"
	      keep-with-next="always"
	      space-before="10pt">

      <xsl:value-of select="translate(substring(normalize-space(.),1,1),
		  'abcdefghijklmnopqrstuvwxyz', 'ABCDEFGHIJKLMNOPQRSTUVWXYZ')"
		  /> <!--selects the capital letter of the current ind:item -->
    </fo:block>
    
  </xsl:template>
  

  <xsl:template name="print-word">
    <xsl:text disable-output-escaping="yes">
      &lt;fo:block></xsl:text> <!--starts a fo:block to contain the current
    word and all the page numbers which belong to that word.  this block is
    ended in the ind:indexlist template --> 
    <xsl:value-of select="." />
  </xsl:template>


  <xsl:template name="print-page">
    <xsl:text>, </xsl:text><!-- comma to go between page references -->

    <xsl:variable name="ref" select="@id"/>
    <!--the variable ref is used to find the module with an id equal to
    @id of a keyword.  the module gives the section number for the keyword -->

    <xsl:choose>
      <!-- If ind:item was a keyword, print the section number and the page
      number.--> 
      <xsl:when test="@type='keyword'">
	<xsl:text> Sec. </xsl:text>
	<xsl:value-of select="//module[@id=$ref]/@number"/>
	<xsl:text> (</xsl:text>
	<fo:page-number-citation ref-id="{@id}"/>
	<xsl:text>)</xsl:text>
      </xsl:when>
      <!-- Otherwise print the page number.-->
      <xsl:otherwise>
	<fo:page-number-citation ref-id="{@id}"/>
      </xsl:otherwise>
    </xsl:choose>

  </xsl:template>
  

</xsl:stylesheet>