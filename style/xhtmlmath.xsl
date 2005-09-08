<?xml version= "1.0" standalone="no"?>

<!--FIX DOCTYPE-->
<!--FIX OUTPUTED DOCTYPE THAT IS IMPORTED FROM basic.xsl-->           

<!--
This stylesheet transforms a CNXML document, with math, for
display in an HTML and MathML enabled browser.  

It applies the templates in this stylesheet first, then corecnxml.xsl,
then transforms math, and then uses the identity transformation
(ident.xsl) for the remaining tags, leaving them unaltered.
Theoretically, every tag should be transformed.

This stylesheet is appropriate for CNXML documents that contain
Content MathML.  The output is XHTML and Presentation MathML.
-->
           
<xsl:stylesheet version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:m="http://www.w3.org/1998/Math/MathML"
  xmlns:cnx="http://cnx.rice.edu/cnxml/0.2"
  xmlns="http://www.w3.org/1999/xhtml">

  <!-- Use identity transform as a last resort -->
  <xsl:import href="ident.xsl"/>

  <!-- Connexion macros -->
  <xsl:import href="../../../mathml2/style/cnxmathmlc2p.xsl"/>

  <!-- Special Connexions MathML overrides -->
  <xsl:import href="cnxmacros.xsl"/>

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
      <link rel="stylesheet" type="text/css" href="http://cnx.rice.edu/cnxml/0.2/style/cnxml.css"/>
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

  <!--This is the template for math.-->
  <xsl:template match="m:math">
    <m:math>
      <xsl:if test="@*[local-name()='display']">
	<xsl:attribute name="display">
	  <xsl:value-of select="@display"/>
	</xsl:attribute>
      </xsl:if>
      <xsl:apply-templates/>
    </m:math>
  </xsl:template>
  
  <!-- Header and Body for the Module -->
  <xsl:template match="cnx:module">
    <body>
      <h1><xsl:value-of select="cnx:name"/></h1>
      
      <xsl:apply-templates/>
      <hr/>
      <a href='http://cnx.rice.edu/forms/bugReport.cfm?id={@id}'>Submit a BUG REPORT.</a><br/>
      <a href='http://cnx.rice.edu/comment.html'>Submit a SUGGESTION.</a> 
    </body>
  </xsl:template>
  
  
  <!-- Section Header -->
  <xsl:template match="cnx:module/cnx:section">
    <h2 id='{@id}'><xsl:value-of select="cnx:name"/></h2>
    <xsl:apply-templates/>
  </xsl:template>
  
  
  <!-- Subsection Header -->
  <xsl:template match="cnx:module/cnx:section/cnx:section">
    <h3 id='{@id}'><xsl:value-of select="cnx:name"/></h3>
    <xsl:apply-templates/>
  </xsl:template>

    <!-- Sub-subsection Header -->
  <xsl:template match="cnx:module/cnx:section/cnx:section/cnx:section">
    <h4 id='{@id}'><xsl:value-of select="cnx:name"/></h4>
    <xsl:apply-templates/>
  </xsl:template>

  <!-- Emphasized Text -->
  <xsl:template match="cnx:emphasis">
    <i><xsl:apply-templates/></i>
  </xsl:template>

  
  <!-- Paragraph. Formatting in CSS under p.para -->
  <xsl:template match="cnx:para">
    <p class="para" id='{@id}'>
      <xsl:apply-templates/>
    </p>
  </xsl:template>

  
  <!-- Default list -->
  <xsl:template match="cnx:list">
    <ul id='{@id}'>
      <xsl:for-each select="cnx:item">
	<li id='{@id}'><xsl:apply-templates/></li>
      </xsl:for-each>
    </ul>
  </xsl:template>
  
  <!-- Numbered lists -->
  <xsl:template match="cnx:list[@type='enumerated']">
    <ol id='{@id}'>
      <xsl:for-each select="cnx:item">
	<li id='{@id}'><xsl:apply-templates/></li>
      </xsl:for-each>
    </ol>
  </xsl:template>

  
  <!-- Code -->
  <xsl:template match="cnx:codeblock">
    <pre><xsl:apply-templates/></pre>
  </xsl:template>

  <xsl:template match="cnx:codeline">
  <code><xsl:apply-templates/></code>
  </xsl:template>	  
  
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
  

  <xsl:template match="cnx:definition">
    <div class='definition'>
      <span class='term'><b>Definition: </b> <xsl:apply-templates select='cnx:term'/>  </span>
      <xsl:apply-templates select='cnx:meaning|cnx:example'/>
    </div>
  </xsl:template>

  <xsl:template match="cnx:term">
    <span class='term'><xsl:apply-templates/></span>
  </xsl:template>
  <xsl:template match="cnx:definition/cnx:term">
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="cnx:meaning">
    <div class='meaning'><xsl:number level="single"/>. <xsl:apply-templates/></div>
  </xsl:template>
 
  <xsl:template match="cnx:definition/cnx:example">
    <div class='example'>
      <b>Example</b><br/><xsl:apply-templates/>
    </div>
  </xsl:template> 

  <!--
  This prevents the keywords from printing in the module.
  -->
  <xsl:template match="cnx:keywordlist">
  </xsl:template>
<!--Don't display name-->
  <xsl:template match='cnx:name'>
  </xsl:template>
  
  <!--	Added to make exercises appear and disappear -->
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

  
  <xsl:template match="cnx:problem">
    <xsl:apply-templates/>
  </xsl:template>
  

  <xsl:template match="cnx:solution">
    <xsl:apply-templates/>
  </xsl:template>
  
  <!--	Added by Sarah on 8/17/00 -->
  
  <xsl:template match="cnx:example">
    <hr/>
    <b id='{@id}'>Example</b><br/>
    <xsl:apply-templates/>
    <hr/> 
  </xsl:template>
  
  
  <xsl:template match='cnx:cite'>
    <span class="cite"><xsl:apply-templates/></span>
  </xsl:template>
  
  <xsl:template match="cnx:abstract">
  </xsl:template>

  <xsl:template match="cnx:authorlist">
  </xsl:template>
</xsl:stylesheet>












