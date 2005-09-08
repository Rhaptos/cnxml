<?xml version="1.0" encoding="utf-8"?>

  <xsl:stylesheet version="1.0"
		  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		  xmlns:fo="http://www.w3.org/1999/XSL/Format"
		  xmlns:ind="index">

  <!--Identity template-->
  <xsl:import href="../common/ident.xsl"/>
  
  <!--The third part of the index-->
  <xsl:template match="//ind:indexlist">
    <!-- FIX ME to be a normal block, to avoid empty list weirdness-->
    <fo:list-block>
  
      <xsl:for-each select="ind:item">
	
	<!--CURRENT is the current position in the list.-->
	<xsl:variable name="current" select="position()"/>
	<!--SELF is the value of the current node.-->
	<xsl:variable name="self" select="current()"/>
	<!--LAST is the value of the previous node in the list.-->
	<xsl:variable name="last">
	  <xsl:value-of select="../ind:item[position()=($current)-1]"/>
	</xsl:variable>

	<xsl:choose>
	  <!--Case 1: take the first letter of SELF and LAST and
	  capitalize them.  If they not the same, start a new alphabet
	  section.-->
	  <xsl:when test="translate(substring($self,1,1),'abcdefghijklmnopqrstuvwxyz!@#$%^*()-_=+`~[{]}\|;:,./?1234567890','ABCDEFGHIJKLMNOPQRSTUVWXYZ')!=translate(substring($last,1,1),'abcdefghijklmnopqrstuvwxyz!@#$%^*()-_=+`~[{]}\|;:,./?1234567890','ABCDEFGHIJKLMNOPQRSTUVWXYZ')">
	    <!--A space between the different alphabet sections.-->
	    <fo:list-item>
	      <fo:list-item-label>
	      </fo:list-item-label>
	      <fo:list-item-body>
	      </fo:list-item-body>
	    </fo:list-item>

	    <fo:list-item>
	    <!--Take the first letter of SELF, capitalize it, and
	    print it as the label of the first item in the new
	    alphabet section.-->
	      <fo:list-item-label>
		<fo:block font-size="14pt" font-weight="bold"><xsl:value-of select="translate(substring($self,1,1),'abcdefghijklmnopqrstuvwxyz!@#$%^*()-_=+`~[{]}\|;:,./?1234567890','ABCDEFGHIJKLMNOPQRSTUVWXYZ')"/></fo:block>
	      </fo:list-item-label>
	      <fo:list-item-body>
		<!--print the first item in the new alphabet section.-->
		<fo:inline font-weight="bold"><xsl:value-of
		    select="."/></fo:inline>
		<xsl:text>  </xsl:text>
		
		<!-- Output index item -->
		<xsl:call-template name='indexitem' />
		
	      </fo:list-item-body>
	    </fo:list-item>
	    
	  </xsl:when>
	  
	  <!--Case 2: Continue the same alphabetic section.-->
	  <xsl:otherwise>
	    <xsl:call-template name='indexbody'>
	      <xsl:with-param name="self"><xsl:value-of select='$self'/></xsl:with-param>
	      <xsl:with-param name="last"><xsl:value-of select='$last'/></xsl:with-param>
	    </xsl:call-template>
	    
	  </xsl:otherwise>
	</xsl:choose>	      
	
      </xsl:for-each>

    </fo:list-block>
  </xsl:template>
  
  <xsl:template name="indexbody">
    <xsl:param name="self" />
    <xsl:param name="last" />

    <xsl:choose>
      <!--Case 1: the current item in the list and the previous item
      in the list, are the same.  So, concatenate this one with the
      previous item. -->
      <!--FIX ME the "," and everything after it are being added after
      the end of the list-item.  This is really bad.-->
      <xsl:when test="$self=$last">, 
	<!-- Output index item -->
	<xsl:call-template name='indexitem'/>
      </xsl:when>
      <!--Case 2: the current item in the list is different than the
      previous item in the list.-->
      <xsl:otherwise>
	<fo:list-item>
	  <fo:list-item-label></fo:list-item-label>
	  <fo:list-item-body>
	    <fo:inline font-weight="bold"><xsl:value-of select="."/></fo:inline>
	    <xsl:text>  </xsl:text>
	    <!-- Output index item -->
	    <xsl:call-template name='indexitem'/>
	  </fo:list-item-body>
	</fo:list-item>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <!-- Template for outputting index items -->
  <xsl:template name="indexitem">

    <!--REF is the thing we're referring to -->
    <xsl:variable name="ref" select="@id"/>	

    <xsl:choose>
      <!-- If it is type keyword, print the section number and the page number.-->
      <xsl:when test="@type='keyword'">
	Sec. <xsl:value-of select="//module[@id=$ref]/@number"/>
	(<fo:page-number-citation ref-id="{@id}"/>)
      </xsl:when>
      <!-- Otherwise print the page number.-->
      <xsl:otherwise>
	<fo:page-number-citation ref-id="{@id}"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

</xsl:stylesheet>
