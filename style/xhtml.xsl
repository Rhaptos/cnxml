<?xml version= "1.0" standalone="no"?>

<!--FIX DOCTYPE-->
<!--FIX OUTPUTED DOCTYPE THAT IS IMPORTED FROM basic.xsl-->           

<!--
This stylesheet transforms a CNXML document, with no math, for
display in an HTML enabled browser.  

It applies the templates in this stylesheet with the highest priority,
then templates in corecnxml.xsl, and then uses the
identity transformation (ident.xsl) for the remaining tags, leaving
them unaltered.  Theoretically, every tag should be transformed.

This stylesheet is appropriate for CNXML documents that contain no
MathML.  The output is XHTML.
-->
           
<xsl:stylesheet version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:m="http://www.w3.org/1998/Math/MathML"
  xmlns:cnx="http://cnx.rice.edu/cnxml/0.2"
  xmlns="http://www.w3.org/1999/xhtml">

  <!-- Use identity transform as a last resort -->
  <xsl:import href="ident.xsl"/>
  
  <!-- Core cnxml transform is the highest priority -->
  <xsl:import href="corecnxml.xsl"/>
  
  <xsl:output 
	      doctype-system="http://cnx.rice.edu/cnxml/0.2/DTD/mozcompat.ent"
	      omit-xml-declaration="no"
	      indent="yes"/>

  <!-- Root Node -->
  <xsl:template match="/">

    <xsl:processing-instruction name="xml-stylesheet">
      type="text/css" title="Default" media="screen"
      href="http://cnx.rice.edu/cnxml/0.2/style/cnxml.css"
    </xsl:processing-instruction>

    <html>
      <head>
	<link rel="stylesheet" type="text/css"
	href="http://cnx.rice.edu/cnxml/0.2/style/cnxml.css"/>
	
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
      <xsl:apply-templates/>
    </html>
  </xsl:template>
  
  
  <!-- Header and Body for the Module -->
  <xsl:template match="cnx:module">
    <body>

      <!--MODULE's NAME-->
      <h1><xsl:value-of select="cnx:name"/></h1>

      <!--The content of the module goes here.-->
      <xsl:apply-templates/>

      <!--BUG REPORT and SUGGESTION info goes at the bottom.-->
      <hr/>
      <a href='http://cnx.rice.edu/forms/bugReport.cfm?id={@id}'>Submit a BUG REPORT.</a><br/>
      <a href='http://cnx.rice.edu/comment.html'>Submit a SUGGESTION.</a> 
    </body>
  </xsl:template>
  
  <!--SECTION-->
  <xsl:template match="cnx:module/cnx:section">
    <h2 id='{@id}'><xsl:value-of select="cnx:name"/></h2>
    <xsl:apply-templates/>
  </xsl:template>
  
  <!--SUBSECTION-->
  <xsl:template match="cnx:module/cnx:section/cnx:section">
    <h3 id='{@id}'><xsl:value-of select="cnx:name"/></h3>
    <xsl:apply-templates/>
  </xsl:template>

  <!--SUBSUBSECTION-->
  <xsl:template match="cnx:module/cnx:section/cnx:section/cnx:section">
    <h4 id='{@id}'><xsl:value-of select="cnx:name"/></h4>
    <xsl:apply-templates/>
  </xsl:template>

  <!--EMPHASIS-->
  <!-- Emphasized Text -->
  <xsl:template match="cnx:emphasis">
    <i><xsl:apply-templates/></i>
  </xsl:template>

  <!--PARA-->
  <!-- Paragraph. Formatting in CSS under p.para -->
  <xsl:template match="cnx:para">
    <p class="para" id='{@id}'>
      <xsl:apply-templates/>
    </p>
  </xsl:template>

  <!--LIST-->
  <!-- Default list.  Prints a list of type='bulleted'. -->
  <xsl:template match="cnx:list">
    <ul id='{@id}'>
      <xsl:for-each select="cnx:item">
	<li id='{@id}'><xsl:apply-templates/></li>
      </xsl:for-each>
    </ul>
  </xsl:template>
  
  
  <!--LIST with type='enumerated'-->
  <!-- Numbered lists -->
  <xsl:template match="cnx:list[@type='enumerated']">
    <ol id='{@id}'>
      <xsl:for-each select="cnx:item">
	<li id='{@id}'><xsl:apply-templates/></li>
      </xsl:for-each>
    </ol>
  </xsl:template>

  
  <!-- CODEBLOCK -->
  <xsl:template match="cnx:codeblock">
    <pre><xsl:apply-templates/></pre>
  </xsl:template>

  <!--CODELINE-->
  <xsl:template match="cnx:codeline">
  <code><xsl:apply-templates/></code>
  </xsl:template>	  
  
  <!--EQUATION-->
  <xsl:template match="cnx:equation">
    <!--do something with the para because eqn can go in paras-->
    <center>
      <a name="{@id}">	
	<table width="100%"> <tr>
	    <td width="30"></td>     
	    <td align="center" valign="center">
	      <xsl:apply-templates/>
	    </td>
	    <td width="30" align="right">	
	      <xsl:number level="any" count="cnx:equation" format="(1)"/>
	    </td>
	  </tr>
	</table>
      </a>
    </center>
  </xsl:template>
  
  <!--DEFINITION-->
  <xsl:template match="cnx:definition">
    <div class='definition'>
      <span class='term'><b>Definition: </b> <xsl:apply-templates select='cnx:term'/>  </span>
      <xsl:apply-templates select='cnx:meaning|cnx:example'/>
    </div>
  </xsl:template>

  <!--generic TERM-->
  <xsl:template match="cnx:term">
    <span class='term'><xsl:apply-templates/></span>
  </xsl:template>

  <!--DEFINITION's TERM-->
  <xsl:template match="cnx:definition/cnx:term">
    <xsl:apply-templates/>
  </xsl:template>

  <!--MEANING-->
  <xsl:template match="cnx:meaning">
    <div class='meaning'><xsl:number level="single"/>. <xsl:apply-templates/></div>
  </xsl:template>
  
  <!--DEFINITION's EXAMPLE-->
  <xsl:template match="cnx:definition/cnx:example">
    <div class='example'>
      <b>Example</b><br/><xsl:apply-templates/>
    </div>
  </xsl:template> 


  <!--EXERCISE-->
  <!--Uses Javascript code at the top.-->
  <xsl:template match="cnx:exercise">
    <div id="{@id}">
      <div class="problem" onclick="showSolution('{@id}')">
	<b>Question <xsl:number level="any" count="cnx:exercise"/>: </b>
	<i><xsl:apply-templates select="cnx:problem"/></i>
      </div>
      <div class="solution" onclick="hideSolution('{@id}')">
	<b>Answer</b> <xsl:apply-templates select="cnx:solution"/>
      </div>
    </div>
  </xsl:template>

  <!--PROBLEM-->
  <xsl:template match="cnx:problem">
    <xsl:apply-templates/>
  </xsl:template>
  
  <!--SOLUTION-->
  <xsl:template match="cnx:solution">
    <xsl:apply-templates/>
  </xsl:template>

  <!--generic EXAMPLE-->
  <xsl:template match="cnx:example">
    <hr/>
    <b id='{@id}'>Example</b><br/>
    <xsl:apply-templates/>
    <hr/> 
  </xsl:template>
  
  <!--CITE-->
  <xsl:template match='cnx:cite'>
    <span class="cite"><xsl:apply-templates/></span>
  </xsl:template>
  

  <!--ABSTRACT-->
  <!--Not displayed.-->
  <xsl:template match="cnx:abstract">
  </xsl:template>
  
  <!--AUTHORLIST-->
  <!--Not displayed.-->
  <xsl:template match="cnx:authorlist">
  </xsl:template>

  <!--KEYWORDLIST-->
  <!--Not displayed.-->
  <xsl:template match="cnx:keywordlist">
  </xsl:template>

  <!--NAME-->
  <!--Not displayed.-->
  <xsl:template match='cnx:name'>
  </xsl:template>

</xsl:stylesheet>













