<?xml version= "1.0" standalone="no"?>

<!--FIX OUTPUTED DOCTYPE THAT IS IMPORTED FROM basic.xsl-->           

<!--
This stylesheet is specialized to convert specifications.
It adds a table of contents and makes some other small changes.

It applies the templates in this stylesheet with the highest priority,
then templates in xhtml.xsl, and then uses the
identity transformation (ident.xsl) for the remaining tags, leaving
them unaltered.  Theoretically, every tag should be transformed.

This stylesheet is appropriate for CNXML documents that contain no
MathML.  The output is XHTML.
-->
           
<xsl:stylesheet version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:m="http://www.w3.org/1998/Math/MathML"
  xmlns:cnx="http://cnx.rice.edu/cnxml/0.3"
  xmlns="http://www.w3.org/1999/xhtml">

  <!-- Use identity transform as a last resort -->
  <xsl:import href="ident.xsl"/>
  
  <!-- Core cnxml transform is the highest priority -->
 <!-- <xsl:import href="corecnxml.xsl"/>-->

  <!-- XHTML is the highest priority. -->
  <xsl:import href="xhtml.xsl"/>

  
  <xsl:output 
	      doctype-system="http://cnx.rice.edu/cnxml/0.3/DTD/mozcompat.ent"
	      omit-xml-declaration="no"
	      indent="yes"/>



  <!-- Root Node -->
  <xsl:template match="/">
  <xsl:processing-instruction name="xml-stylesheet">
      type="text/css" title="Default" media="screen"
      href="http://cnx.rice.edu/cnxml/0.3/style/xhtml1.css"
    </xsl:processing-instruction>
    
    <xsl:processing-instruction name="xml-stylesheet">
      type="text/css" title="Style 2" media="screen" alternate="yes"
      href="http://cnx.rice.edu/cnxml/0.3/style/xhtml2.css"
    </xsl:processing-instruction>

    <xsl:processing-instruction name="xml-stylesheet">
      type="text/css" title="Style 3" media="screen" alternate="yes"
      href="http://cnx.rice.edu/cnxml/0.3/style/xhtml3.css"
    </xsl:processing-instruction>

    <xsl:processing-instruction name="xml-stylesheet">
      type="text/css" title="Style 4" media="screen" alternate="yes"
      href="http://cnx.rice.edu/cnxml/0.3/style/xhtml4.css"
    </xsl:processing-instruction>

    <html>
      <head>
      <link rel="stylesheet" title="Default" type="text/css"
	  href="http://cnx.rice.edu/cnxml/0.3/style/xhtml1.css"/>
	
	<link rel="alternate stylesheet" title="Style" type="text/css" 
	  href="http://cnx.rice.edu/cnxml/0.3/style/xhtml2.css"/>

	<link rel="alternate stylesheet" title="Style 3" type="text/css"
	  href="http://cnx.rice.edu/cnxml/0.3/style/xhtml3.css"/>

	<link rel="alternate stylesheet" title="Style 4" type="text/css"
	  href="http://cnx.rice.edu/cnxml/0.3/style/xhtml4.css"/>

	
	<!--MODULE's NAME-->
        <title><xsl:value-of select="cnx:module/cnx:name"/></title>
        
	<!--	Javascript so that answer can appear on click.	-->
	<script language="javascript">
	  function getExerciseSolution(id)
	  {
	  return document.getElementById(id).getElementsByTagName("div").item(1);
	  }
	  function showSolution(id) 
	  {
	     getExerciseSolution(id).style.display="block";
	  }
	  function hideSolution(id) 
	  {
	     getExerciseSolution(id).style.display="none";
	  }
	</script>
      </head>	
      <xsl:apply-templates select="cnx:module"/>
    </html>
  </xsl:template>

  
  <!-- Header and Body for the Module -->
  <xsl:template match="cnx:module">
    <body>
      <h1><xsl:value-of select="cnx:name"/></h1>
      
      <!--list authors and dates-->
  <div class="header">
      Document authors:
      <ul>
	<xsl:for-each select="cnx:authorlist/cnx:author">
	  <li>
	    <xsl:value-of select="cnx:firstname"/><xsl:text> </xsl:text><xsl:value-of select="cnx:surname"/>
	  </li>
	</xsl:for-each>
      </ul>
      
      Please send comments and feedback to the <a
      href="mailto:cnxml@cnx.rice.edu">CNXML Language Team.</a>

  </div>

      <!--Add Document Version before Table of Contents -->
      <xsl:apply-templates select="cnx:section[@id='version']"/>
      <!--Sarah Coppin on 1/5/01 -->

      <!--  Table of Contents  -->
      <h2 id='toc'>Table of Contents</h2>
      <ul class="toc">
	<xsl:for-each select="cnx:section">
	  <li>
	    <a href='#{@id}'>
	      <xsl:number level="single" 
			  count="cnx:section"
			  format="1.  "/>
	      <xsl:value-of select='cnx:name'/>
	    </a>
	    <ul class="toc">
	      <xsl:for-each select="cnx:section">
		<li>
		  <a href='#{@id}'>
		    <xsl:number level="multiple" 
				count="cnx:section"
				format="1.1  "/>
		    <xsl:value-of select='cnx:name'/>
		  </a>
		  <ul class="toc">
		    <xsl:for-each select="cnx:section">
		      <li>
			<a href='#{@id}'>
			  <xsl:number level="multiple" 
				      count="cnx:section"
				      format="1.1.1  "/>
			  <xsl:value-of select='cnx:name'/>
			</a>
		      </li>
		    </xsl:for-each>
		  </ul>
		</li>
	      </xsl:for-each>
	    </ul>
	  </li>	
	</xsl:for-each>
      </ul>
      <!--  Added by Sarah updated 12/07/2000  -->
      <!--Moved Document Version section before Table of Contents-->
      <xsl:apply-templates select="cnx:section[not(@id='version')]"/>
      <!-- Modified by Sarah 1/5/01 -->

    </body>
  </xsl:template>




</xsl:stylesheet>













