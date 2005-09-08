<?xml version="1.0" encoding="utf-8"?>

  <xsl:stylesheet version="1.0"
		  xmlns:cnx="http://cnx.rice.edu/contexts#"
		  xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
		  xmlns:m="http://www.w3.org/1998/Math/MathML"
		  xmlns:cnxml="http://cnx.rice.edu/cnxml/0.3"
		  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		  xmlns:fo="http://www.w3.org/1999/XSL/Format"
		  xmlns:fotex="http://www.tug.org/fotex"
		  xmlns:ind="index">

    <!-- Use identity transform as a last resort -->
  <!--  <xsl:import href="/home/coppin/nextrelease/stylesheets/ident.xsl"/> -->

  <xsl:template match="@*|node()">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="cnx:linktypes">
  </xsl:template>

  <!--A key which matches an element by its ID attribute-->
  <xsl:key name="ID" match="*[@ID]" use="@ID"/>
  
  <!--A key which matches an element by its about attribute-->
  <xsl:key name="about" match="*[@about]" use="@about"/>


  <!--The ROOT node-->
  <xsl:template match="/">
   <rdf:RDF>
      
      <!--Copy RDF information-->   <!-- chris doesn't think we care about the
      attributes on the rdf tag, they are just namespaces-->   
      <xsl:copy-of select="@*"/>
      
      <!--The top most grouping of the course.-->
      <!--Without the select attribute it will apply the templates in
      this stylesheet to everything in the entire file and essentially
      repeat the entire course and pieces of the course multiple times.-->
      <xsl:copy>
	<xsl:apply-templates select="rdf:RDF/rdf:Description[@about='urn:context:root']"/>
      </xsl:copy>

      <!--Create a list of the authors in all of the modules in the course.-->
      <ind:authorlist>
	<!--look in each module, segue, and problemset.-->
	<xsl:for-each select="//rdf:Description[child::cnx:class[normalize-space(.)='module' or
	  normalize-space(.)='segue' or normalize-space(.)='problemset']]">
	  <!--pull in the document-->
	  <xsl:for-each
	      select="document(concat(normalize-space(cnx:uri),'index.cnxml'))">
	    <!--look at each author-->
	    <!--copy the firstname and surname separately so that you
	    can sort by surname later.-->
	    <xsl:for-each select="//cnxml:author">
		<ind:item type="author">
		  <xsl:copy-of select='@id'/>
		  <cnxml:firstname><xsl:copy-of
		  select="normalize-space(cnxml:firstname/.)"/></cnxml:firstname>
		  <cnxml:surname><xsl:copy-of
		  select="normalize-space(cnxml:surname/.)"/></cnxml:surname>
		</ind:item>
	      </xsl:for-each>
	    </xsl:for-each>
	  </xsl:for-each>
	</ind:authorlist>

      <!--Create a list of the keywords and terms in all modules in
      the course.-->
      <ind:indexlist>
	<!--look in each module, segue, and problemset.-->
	<xsl:for-each select="//rdf:Description[child::cnx:class[normalize-space(.)='module' or
	  normalize-space(.)='segue' or
	  normalize-space(.)='problemset']]">
	  <!--pull in the document-->
	  <xsl:for-each
	  select="document(concat(normalize-space(cnx:uri),'index.cnxml'))">

	    <!--normalize-space() removes whitespace before and after text and
	      collapses repeating whitespace into one character.  This
	      greatly improves the accuracy of the alphabetization in
	    a later stylesheet.-->
	    <!--keywords and terms have an attribute marking them as
	    such so that they can be referenced differently later.-->

	    <!--look at each keyword-->
	    <xsl:for-each select="cnxml:module//cnxml:keyword">
	      <ind:item type="keyword" id="{/cnxml:module/@id}"><xsl:value-of select="normalize-space(.)"/></ind:item>
	    </xsl:for-each>

	    <!--look at each term (but only ones that are not in an
	    objectives tag)-->
	    <!--you must generate the id for the term so that it
	    matches the one generated in the term id in this stylesheet-->
	    <xsl:for-each select="cnxml:module//cnxml:term[not(ancestor::cnxml:objectives)]">
	      <ind:item type="term" id="{generate-id()}"><xsl:value-of select="normalize-space(.)"/></ind:item>
	    </xsl:for-each>

	  </xsl:for-each>
	</xsl:for-each>
      </ind:indexlist>
      
    </rdf:RDF>
  </xsl:template>	  
  
  <!-- LI -->
  <xsl:template match="rdf:li[@resource]">
    <rdf:li>

      <!--Copy RDF information-->
      <xsl:copy-of select="@*"/>

      <!--Copy the contents of the module or the group that the rdf:li
      describes.-->
      <xsl:choose>
	<!--Case 1: reference starts with a #, which means that it
	refers to a group.-->
	<xsl:when test="starts-with(@resource,'#')">
	  <xsl:apply-templates select="key('ID',substring-after(@resource,'#'))"/>
	</xsl:when>
	<!--Case 2: reference does not start with a #, which means
	that it refers to a module.-->
	<xsl:otherwise>
	  <xsl:apply-templates select="key('about',@resource)"/>
	</xsl:otherwise>
      </xsl:choose>

    </rdf:li>
  </xsl:template>

  <!--PAGEVIEWS-->
  <xsl:template match="rdf:Description[child::cnx:class[normalize-space(.)='pageview']]">
    <rdf:Description>

      <!--Copy RDF information, but not the segues or problemsets.-->
      <xsl:copy-of select="@*"/>
      <xsl:apply-templates select="*[not(self::cnx:pre or self::cnx:post)]|@*"/>
      
      <!--Copy the contents of the preceeding segues.-->
      <xsl:apply-templates select="cnx:pre"/>
      
      <!--Copy the contents of the module or the group that the
      pageview describes.-->
      <xsl:choose>
	<!--Case 1: reference starts with a #, which means that it
	refers to a group.-->
	<xsl:when test="starts-with(cnx:node,'#')">
	  <xsl:apply-templates select="key('ID',substring-after(cnx:node,'#'))"/>
	</xsl:when>
	<!--Case 2: reference does not start with a #, which means
	that it refers to a module.-->
	<xsl:otherwise>
	  <xsl:apply-templates select="key('about',cnx:node)"/>
	</xsl:otherwise>
      </xsl:choose>

      <!--Copy the contents of the following segues and problemsets.-->
      <xsl:apply-templates select="cnx:post"/>

    </rdf:Description>
  </xsl:template>

  <!--MODULE, SEGUE, PROBLEMSET -->
  <xsl:template match="rdf:Description[child::cnx:class[normalize-space(.)='module' or
    normalize-space(.)='segue' or normalize-space(.)='problemset']]">
    <rdf:Description>

      <!--Copy RDF information-->
      <xsl:copy-of select="@*"/>
      <xsl:apply-templates/>
      
      <!--Copy the contents of the module into the output document.-->
      <cnx:content parseType="Literal"><!--I added this tag-->
	<!--<xsl:value-of
	select="document(concat(normalize-space(cnx:uri),'index.cnxml'))"/>-->
	<xsl:apply-templates select="document(concat(normalize-space(cnx:uri),'index.cnxml'))/*"/>
      </cnx:content>

    </rdf:Description>
  </xsl:template>
  
  <!--TERM-->
  <!--Add an autogenerated id to term.-->
  <xsl:template match="cnxml:term">
    <xsl:copy>
      <xsl:attribute name="id">
	<xsl:value-of select="generate-id()"/>
      </xsl:attribute>
      <xsl:apply-templates/>
    </xsl:copy>
  </xsl:template>



  <!--Concatenate the IDs-->
  <!--The id of each elements id is concatenated with its module id to -->
  <!--make it unique within the course.  This removes ambiguity.  The -->
  <!--two ids are separated by an *.-->
  <xsl:template match="cnxml:module//@id[not(parent::cnxml:module)]">
    <xsl:attribute name="id">
      <xsl:value-of select="ancestor::cnxml:module/@id"/>*<xsl:value-of select="."/>
    </xsl:attribute>
  </xsl:template>


  <!--Since the ids are concatenated the target attribute also needs to -->
  <!--contain the module part of the new id.-->  
  <xsl:template match="cnxml:cnxn/@target">
    <xsl:attribute name='target'>
      <xsl:choose>
	<!--Case 1: If cnxn has a module attribute concatenate that value with the -->
	<!--target attribute.-->
	<xsl:when test="../@module">
	  <xsl:value-of select="../@module"/>*<xsl:value-of select="."/>
	</xsl:when>
	<!--Case 2: If cnxn does not have a module attribute, concatenate the -->
	<!--module id of the current module with the target attribute.-->
	<xsl:otherwise>
	  <xsl:value-of
	    select="ancestor::cnxml:module/@id"/>*<xsl:value-of select="."/>
	</xsl:otherwise>
      </xsl:choose>
    </xsl:attribute>
  </xsl:template>


  
<!--FOR TESTING-->
<!--Won't print the entire module.  It will just print enough so that -->
<!--you can see that it is working.-->

<!--  <xsl:template match="cnxml:module">
  I am module:    <xsl:value-of select="@id"/>
  </xsl:template>
-->

</xsl:stylesheet>






