<?xml version="1.0" encoding="utf-8"?>

  <xsl:stylesheet version="1.0"
    xmlns:m="http://www.w3.org/1998/Math/MathML"
    xmlns:cnxml="http://cnx.rice.edu/cnxml/0.3.5"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format"
    xmlns:fotex="http://www.tug.org/fotex"
    xmlns:ind="index">

  <!--Identity template-->
  <xsl:import href="/home/coppin/nextrelease/stylesheets/ident.xsl"/>

  <!--ROOT-->
  <xsl:template match="/">
    <xsl:apply-templates/>
  </xsl:template>
  
  <!--FIX ME This should maybe be deleted.-->
  <xsl:template match="ind:section">
  </xsl:template>

  
  <!--The third part of the index-->
  <xsl:template match="//ind:indexlist">
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
	  <xsl:when
	  test="translate(substring($self,1,1),'abcdefghijklmnopqrstuvwxyz!@#$%^*()-_=+`~[{]}\|;:,./?1234567890','ABCDEFGHIJKLMNOPQRSTUVWXYZ')!=translate(substring($last,1,1),'abcdefghijklmnopqrstuvwxyz!@#$%^*()-_=+`~[{]}\|;:,./?1234567890','ABCDEFGHIJKLMNOPQRSTUVWXYZ')">
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
		
		<xsl:choose>
		  <!--Case 1a: if it is type keyword, print the
		  section number and the page number.-->
		  <xsl:when test="@type='keyword'">
		    Sec. <xsl:value-of select="@section"/>
		    (<fo:page-number-citation ref-id="{@id}"/>)
		  </xsl:when>
		  <!--Case 1b: if it of another type, print the page number.-->
		  <xsl:otherwise>
		    <fo:page-number-citation ref-id="{@id}"/>
		  </xsl:otherwise>
		</xsl:choose>
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
<xsl:param name="self"></xsl:param>
<xsl:param name="last"></xsl:param>

    <xsl:choose>
      <!--Case 1: the current item in the list and the previous item
      in the list, are the same.  So, concatenate this one with the
      previous item. -->
      <!--FIX ME the "," and everything after it are being added after
      the end of the list-item.  This is really bad.-->
      <xsl:when test="$self=$last">, 
		  
	<xsl:choose>
	  <!--Case 1a: of type keyword.  Print the section and the
	  page number.-->
	  <xsl:when test="@type='keyword'">
	    Sec.  <xsl:value-of select="@section"/> (<fo:page-number-citation ref-id="{@id}"/>)</xsl:when>
	  <!--Case 1b: of another type.  Print the page number only.-->
	  <xsl:otherwise>
	    <fo:page-number-citation ref-id="{@id}"/>
	  </xsl:otherwise>
	</xsl:choose>  
      </xsl:when>
      <!--Case 2: the current item in the list is different than the
      previous item in the list.-->
      <xsl:otherwise>
	<fo:list-item>
	  <fo:list-item-label></fo:list-item-label>
	  <fo:list-item-body>
	    <fo:inline font-weight="bold"><xsl:value-of select="."/></fo:inline>
	    <xsl:text>  </xsl:text>
	    
	    <xsl:choose>
	      <!--Case 2a: of type keyword.  Same as before.-->
	      <xsl:when test="@type='keyword'">
		Sec. <xsl:value-of select="@section"/>
		(<fo:page-number-citation ref-id="{@id}"/>)
	      </xsl:when>
	      <!--Case 2b: of another type.  Same as before.-->
	      <xsl:otherwise>
		<fo:page-number-citation ref-id="{@id}"/>
	      </xsl:otherwise>
	    </xsl:choose>  
	    
	  </fo:list-item-body>
	</fo:list-item>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  


  <!--The last step of creating the list of authors.-->
  <xsl:template match="//ind:authorlist">
    <xsl:for-each select="ind:item">
      <!--CURRENT is the current position-->
      <xsl:variable name="current" select="position()"/>
      <!--SELF is the current id-->
      <xsl:variable name="self" select="@id"/>
      <!--LAST is the id of the previous item--> 
      <xsl:variable name="last">
	<xsl:value-of select="../ind:item[position()=($current)-1]/@id"/>
      </xsl:variable>
      
      <xsl:call-template name='authorbody'>
	<xsl:with-param name="self"><xsl:value-of select='$self'/></xsl:with-param>
	<xsl:with-param name="last"><xsl:value-of select='$last'/></xsl:with-param>
      </xsl:call-template>
      
    </xsl:for-each>
  </xsl:template>
  

  <xsl:template name="authorbody">
    <xsl:param name="self"></xsl:param>
    <xsl:param name="last"></xsl:param>

    <xsl:choose>
      <!--Case 1: If SELF is the same as LAST, don't do anything.-->
      <xsl:when test="$self=$last">
      </xsl:when>
      
      <!--Case 2: Otherwise print the same.-->
      <xsl:otherwise>
	<fo:block id="@id"><xsl:value-of select="cnxml:firstname"/><xsl:text> </xsl:text><xsl:value-of select="cnxml:surname"/>
	</fo:block>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
</xsl:stylesheet>



