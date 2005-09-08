<?xml version= "1.0" standalone="no"?>
<!--FIX OUTPUTED DOCTYPE THAT IS IMPORTED FROM basic.xsl-->           

<!--
This stylesheet transforms a CNXML document, with no math, for
display in an HTML enabled browser.  

It applies the templates in this stylesheet with the highest priority,
then templates in corecnxml.xsl, and then uses the
identity transformation (ident.xsl) for the remaining tags, leaving
them unaltered.  Theoretically, every tag should be transformed.

This stylesheet is appropriate for CNXML documents that contain no
MathML.  The output is HTML.
-->
           
<xsl:stylesheet version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:cnx="http://cnx.rice.edu/cnxml/0.3"
  xmlns="http://www.w3.org/1999/xhtml">

  <!-- Use identity transform as a last resort -->
  <xsl:import href="ident.xsl"/>
  
  <!-- Core cnxml transform is the highest priority -->
  <xsl:import href="corecnxml.xsl"/>
  
  <xsl:output method="html"
	      doctype-system="http://cnx.rice.edu/cnxml/0.3/DTD/mozcompat.ent"
	      omit-xml-declaration="yes"
	      indent="yes"/>

  <!-- Root Node -->
  
  <xsl:template match="/">
   
      <html>
      <head>

	<link rel="stylesheet" title="Default" type="text/css"
	  href="http://cnx.rice.edu/cnxml/0.3/style/html_bw.css"/>

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
      <h1><u><xsl:value-of select="cnx:name"/></u></h1>

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
    <div class='section'>
    <h2 id='{@id}'><xsl:value-of select="cnx:name"/></h2>
    <xsl:apply-templates/>
    </div>
  </xsl:template>
  
  <!--SUBSECTION-->
  <xsl:template match="cnx:module/cnx:section/cnx:section">
    <div class='section'>
    <h3 id='{@id}'><xsl:value-of select="cnx:name"/></h3>
    <xsl:apply-templates/>
    </div>
  </xsl:template>

  <!--SUBSUBSECTION-->
  <xsl:template match="cnx:module/cnx:section/cnx:section/cnx:section">
    <div class='section'>
    <h4 id='{@id}'><xsl:value-of select="cnx:name"/></h4>
    <xsl:apply-templates/>
    </div>
  </xsl:template>

  <!--SUBSUBSUBSECTION-->
  <xsl:template match="cnx:module/cnx:section/cnx:section/cnx:section/cnx:section">
    <div class='section'>
    <h5 id='{@id}'><xsl:value-of select="cnx:name"/></h5>
    <xsl:apply-templates/>
    </div>
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
    <ul>
      <xsl:for-each select="cnx:item">
	<li><xsl:apply-templates/></li>
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

  <!--CNXN-->  
  <!-- CNXN can have a target attribute, a module attribute, or both.  But it must have one of them.-->
  <xsl:template match="cnx:cnxn">
    <xsl:choose>
      
      <!--if both target and module-->
      <xsl:when test="@target and @module">
        <a href="http://cnx.rice.edu/modules/{@module}#{@target}/latest/">
          <xsl:if test="not(string())">*</xsl:if>
          <xsl:apply-templates/></a>
      </xsl:when>
      
      <!--if only module and not target-->
      <xsl:when test="not(@target)">
        <a href="http://cnx.rice.edu/modules/{@module}/latest/"><xsl:apply-templates/></a>
      </xsl:when>
      
      <!--if only target and no module-->
      <xsl:otherwise>
        <!--what about subfigures?-->
        
        <!--There is a hierarchy of options.  
        First, it checks if the user entered something inside the cnxn tag.
        Next, it checks if it links to an equation, then a figure, then a tag
        with a name attribute, and it finally defaults to printing generic content.
        It tests for the first three things using a key that is defined at the
        top of the file.  The key is called id and matches a tag that
        has an id with the same value as @target.-->
        <xsl:choose>
          <!--Checks if the cnxn tag contains text.
          Prints an anchor, and the contents of the cnxn tag. Note that @target is used.-->
          <xsl:when test="node()">
            <a href="#{@target}"><xsl:apply-templates/></a>
          </xsl:when>
          <!--Checks if the tag that matches the key is an equation.
          For each tag that matches the equation (there should be only one) it
          prints an anchor, and Eqn. followed by the equation number.
          Note that @id and @target are the same in this case.-->
          <xsl:when test="key('id',@target)[self::cnx:equation]">
            <xsl:for-each select="key('id',@target)">
              <a href="#{@id}">Eqn. <xsl:number level="any"/></a>
            </xsl:for-each>
          </xsl:when>
          <!--Checks if the tag that matches the key is a figure.
          For each tag that matches the figure (there should be only one) it
          prints an anchor, and Fig. followed by the equation number.
          Note that @id and @target are the same in this case.-->
          <xsl:when test="key('id',@target)[self::cnx:figure]">
            <xsl:for-each select="key('id',@target)">
              <a href="#{@id}">Fig. <xsl:number level="any"/></a>
            </xsl:for-each>
          </xsl:when>
          <!--Checks if the tag that matches the key has a name child.
          Prints an anchor, and the value of the name.  Note that @target is
          used because the cnxn is still the active node.-->
          <xsl:when test="key('id',@target)[self::*[cnx:name]]">
            <a href="#{@target}"><xsl:value-of select="key('id',@target)/cnx:name"/></a>
          </xsl:when>
          
          <!--All other options are exhausted.  It prints an anchor
          and Ref. as a generic substitute.-->
          <xsl:otherwise>
            <a href="#{@target}">Ref.</a>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:otherwise>
      
    </xsl:choose>
  </xsl:template>
  
  <!--   LINK          -->
  <!--turns into an anchor -->
  <xsl:template match='cnx:link'>
    <a href="{@src}">
      <xsl:apply-templates/>
    </a>
  </xsl:template>

  <!-- MEDIA:IMAGE -->
  <xsl:template match="cnx:media[starts-with(@type,'image/')]">
    <img src="{@src}" />
  </xsl:template>
  
  <!--  MEDIA:APPLET  -->
  <xsl:template match="cnx:media[@type='application/x-java-applet']">
    <applet code="{@src}" width="430" height="500"/>
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
  
  <!--generic EXAMPLE-->
  <xsl:template match="cnx:example">
    <div class='example'><b>Example:</b>
      <xsl:apply-templates/>
    </div>
<!--    <hr/>
    <b id='{@id}'>Example</b><br/>
    <xsl:apply-templates/>
    <hr/>--> 
  </xsl:template>

  <!--DEFINITION-->
  <xsl:template match="cnx:definition">
    <div class='definition'>
      <span class='term'><xsl:apply-templates select='cnx:term'/>  </span>
      <xsl:apply-templates select='cnx:meaning|cnx:example'/>
    </div>
  </xsl:template>

  <!--generic TERM-->
  <xsl:template match="cnx:term">
    <span class='term'><xsl:apply-templates/></span>
  </xsl:template>

  <!--DEFINITION's TERM-->
  <xsl:template match="cnx:definition/cnx:term">
    <b>Definition: </b>
    <xsl:apply-templates/>
  </xsl:template>

  <!--MEANING-->
  <xsl:template match="cnx:meaning">
    <div class='meaning'><xsl:number level="single"/>. <xsl:apply-templates/></div>
  </xsl:template>
  
  <!--DEFINITION's EXAMPLE-->
  <xsl:template match="cnx:definition/cnx:example">
    <div class='example'>
      <xsl:apply-templates/>

    </div>
  </xsl:template> 

  <!--RULE-->
  <xsl:template match="cnx:rule">
  <div class='rule' type='{@type}'>
  <xsl:apply-templates/>
  </div>
  </xsl:template>
  
  <!--RULE's NAME-->
  <xsl:template match="cnx:rule/cnx:name">
    <span class='name'><xsl:apply-templates/></span>
  </xsl:template>

  <!--RULE's STATEMENT-->
  <xsl:template match="cnx:rule/cnx:statement">
    <div class='statement'>
      <xsl:apply-templates/>
    </div>	
  </xsl:template>

  <!--RULE's PROOF-->
  <xsl:template match="cnx:proof">
    <div class='proof'>
      <b>Proof: </b>
      <xsl:apply-templates/>
    </div>
  </xsl:template>
  
  <!--RULE's EXAMPLE-->
  <xsl:template match="cnx:rule/cnx:example">
    <div class='example'>
      <b>Example: </b>
      <xsl:apply-templates/>
    </div>
  </xsl:template> 

  <!--EXERCISE-->
  <!--Uses Javascript code at the top.-->
  <xsl:template match="cnx:exercise">
    <div class='exercise' id="{@id}">
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


  
  <!--CITE-->
  <xsl:template match='cnx:cite'>
    <span class="cite"><xsl:apply-templates/></span>
  </xsl:template>
  

  <!--ABSTRACT-->
  <xsl:template match="cnx:abstract">
    <div class='abstract'>
      <xsl:apply-templates/>
    </div>
  </xsl:template>

  <!--OBJECTIVES-->
  <xsl:template match="cnx:objectives">
    <div class='objectives'>
      <xsl:apply-templates/>
    </div>
  </xsl:template>
  
  <!--AUTHORLIST-->
  <xsl:template match="cnx:authorlist">
    <div class='authorlist'>
      <xsl:apply-templates/>
    </div>
  </xsl:template>

  <!--AUTHOR-->
  <xsl:template match="cnx:author">
    <div class='author'>
      <xsl:apply-templates/>
    </div>
  </xsl:template>

  <!--HONORIFIC-->
  <xsl:template match='cnx:honorific'>
    <span class='honorific'>
      <xsl:apply-templates/>
    </span>
  </xsl:template>
  
  <!--FIRSTNAME-->
  <xsl:template match='cnx:firstname'>
    <span class='firstname'>
      <xsl:apply-templates/>
    </span>
  </xsl:template>
  
  <!--OTHERNAME-->
  <xsl:template match='cnx:othername'>
    <span class='othername'>
      <xsl:apply-templates/>
    </span>
  </xsl:template>
  
  <!--SURNAME-->
  <xsl:template match='cnx:surname'>
    <span class='surname'>
      <xsl:apply-templates/>
    </span>
  </xsl:template>
  
  <!--LINEAGE-->
  <xsl:template match='cnx:lineage'>
    <span class='lineage'>
      <xsl:apply-templates/>
    </span>
  </xsl:template>

  <!--EMAIL-->
  <xsl:template match='cnx:email'>
    <span class='email'>
      <xsl:apply-templates/>
    </span>
  </xsl:template>

  <!--MAINTAINERLIST-->
  <xsl:template match="cnx:maintainerlist">
    <div class='maintainerlist'>
      <xsl:apply-templates/>
    </div>
  </xsl:template>

  <!--MAINTAINER-->
  <xsl:template match="cnx:maintainer">
    <div class='maintainer'>
      <xsl:apply-templates/>
    </div>
  </xsl:template>

  <!--KEYWORDLIST-->
  <!--Not displayed.-->
  <xsl:template match="cnx:keywordlist">
  </xsl:template>

  <!--NAME-->
  <!--Not displayed.-->
  <xsl:template match='cnx:name'>
  </xsl:template>

  <!--NOTE-->
  <xsl:template match="cnx:note">
    <div class="note">
      <div class="{@type}">
	<font color="#ff0000">
	<xsl:value-of select="@type"/>:
	  </font>
	<xsl:apply-templates/>
      </div>
    </div>
  </xsl:template>
</xsl:stylesheet>
