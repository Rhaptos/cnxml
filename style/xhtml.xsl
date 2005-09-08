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
MathML.  The output is XHTML.
-->
           
<xsl:stylesheet version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:cnx="http://cnx.rice.edu/cnxml/0.3"
  xmlns="http://www.w3.org/1999/xhtml">

  <!-- Use identity transform as a last resort -->
  <xsl:import href="ident.xsl"/>
  
  <!-- QML is the next highest priority -->
  <xsl:import href="qml.xsl"/>
  
  <!-- Core cnxml transform is the highest priority -->
  <xsl:import href="corecnxml.xsl"/>
  
  <xsl:output 
	      doctype-system="http://cnx.rice.edu/cnxml/0.3/DTD/mozcompat.ent"
	      omit-xml-declaration="no"
	      indent="yes"/>

  <xsl:key name="id" match="equation|figure" use="@id" /> 

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
	<script language="javascript"
	  src="http://cnx.rice.edu/cnxml/0.3/style/xhtml.js" />
	<script language="javascript"
	  src="http://cnx.rice.edu/qml/1.0/scripts/qml_1-0.js" />
	<!-- ****QML**** sets the feedback and hints to non-visible. -->
        <style type="text/css">
          .feedback {display:none}
          .hint {display:none}
        </style>

      </head>	
      <xsl:apply-templates/>
    </html>
  </xsl:template>
  
  
  <!-- Header and Body for the Module -->
  <xsl:template match="cnx:module">
    <body>

      <!--MODULE's NAME-->
      <h1><span class="namebox"><xsl:value-of select="cnx:name"/></span></h1>

      <!--The content of the module goes here.-->
      <xsl:apply-templates/>

      <!--BUG REPORT and SUGGESTION info goes at the bottom.-->
    <div class="footer">
      <a href='http://cnx.rice.edu/forms/bugReport.cfm?id={@id}'>Submit a BUG REPORT.</a><br/>
      <a href='http://cnx.rice.edu/comment.html'>Submit a SUGGESTION.</a> 
    </div>
    </body>
  </xsl:template>



<!-- ********CNXN AND LINK*************** -->
  <!-- LINK -->
    <xsl:template match="cnx:link">
         <a class="link" href="{@src}">   
            <xsl:apply-templates />
         </a>
    </xsl:template>


  <!-- CNXN -->
    <!-- first the parser looks at the third tag here, if there is a target and
    a module, then the 3rd template is applied.  if both are not present, it
    will then see if there is a module specified, and if so apply the 2nd
    template. otherwise, there must just be a target specified, and it will
    apply the 1st template. -->

    <!-- if there is a target only specified -->
    <!-- and then if there is just a target specified, then we can try to infer what the author was attempting to connect to.  if there is no text, we will insert text.  if there is text, that text will serve as the link text.  -->
  


    <xsl:template match="cnx:cnxn[not(@module)]">
         <a class="cnxn" title="Strength {@strength}" href="#{@target}">
            
            <xsl:choose>
                <xsl:when test="node()">
                   <xsl:apply-templates /> 
                </xsl:when>

                <xsl:when test="id(@target)[self::cnx:equation]">
                   Eqn.
                   <xsl:for-each select="id(@target)">
                       <xsl:number level="any" />
                   </xsl:for-each>
                   <xsl:apply-templates />
                </xsl:when>

                <xsl:when  test="id(@target)[self::cnx:figure]">
                   Fig.
                   <xsl:for-each select="id(@target)">
                       <xsl:number level="any" />
                   </xsl:for-each>
                   <xsl:apply-templates />
                </xsl:when>
                <xsl:otherwise>
                   Ref.
                   <xsl:apply-templates />
                </xsl:otherwise>
            </xsl:choose>

         </a>
    </xsl:template>

    <!-- if there is a module only specified -->
    <xsl:template match="cnx:cnxn[not(@target)]">
         <a class="cnxn" title="Strength {@strength}"
   href="http://cnx.rice.edu/modules/{@module}/latest/">
            <xsl:if test="not(string())">module</xsl:if> 
            <xsl:apply-templates />
         </a>
    </xsl:template>


    <!-- if there is a target and a module specified -->
    <xsl:template match="cnx:cnxn[@module and @target]">
         <a class="cnxn" title="Strength {@strength}"
   href="http://cnx.rice.edu/modules/{@module}/latest/#{@target}">
            <xsl:if test="not(string())">module</xsl:if>
            <xsl:apply-templates />
         </a>
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
  <xsl:template
		match="cnx:module/cnx:section/cnx:section/cnx:section/cnx:section">
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
  
  <!--generic EXAMPLE-->
  <xsl:template match="cnx:example">
    <div class='example'> 
      <span class="examplename"><xsl:value-of select="cnx:name"/> </span>
      <xsl:apply-templates/>
    </div>
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
    <xsl:apply-templates/>
  </xsl:template>

  <!--MEANING-->
  <xsl:template match="cnx:meaning">
    <div class='meaning'><xsl:number level="single"/>. <xsl:apply-templates/></div>
  </xsl:template>
  
  <!--DEFINITION's EXAMPLE-->
  <xsl:template match="cnx:definition/cnx:example">
    <div class='example'>
      <span class="examplename"><xsl:value-of select="cnx:name"/> </span>
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
    <span class='rulename'><xsl:value-of select="."/></span>
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
      <span class="proofname"><xsl:value-of select="cnx:name"/></span>
      <xsl:apply-templates/>
    </div>
  </xsl:template>
  
  <!--RULE's EXAMPLE-->
  <xsl:template match="cnx:rule/cnx:example">
    <div class='example'>
      <span class="examplename"><xsl:value-of select="cnx:name"/></span>
      <xsl:apply-templates/>
    </div>
  </xsl:template> 

  <!--EXERCISE-->
  <!--Uses Javascript code at the top.-->
  <xsl:template match="cnx:exercise">
    <div class='exercise' id="{@id}">
      <!-- moved exercise label from problem and put in exercise-->
      <span class="problem">Exercise 
	<xsl:number level="any" count="cnx:exercise"/>:
      </span>
      <xsl:apply-templates />
    </div>
  </xsl:template>

  <!--PROBLEM-->
  <xsl:template match="cnx:problem">
    <div class="problem">
      <xsl:apply-templates />
    </div>
  </xsl:template>
  
  <!--SOLUTION-->
  <xsl:template match="cnx:solution">
    <div class="button" onclick="showSolution('{../@id}')">
      <span class="buttontext">Click for Solution</span>
    </div>   
    <div class="solution">   <!-- onclick="hideSolution('{@id}')" -->
      <xsl:apply-templates />
    </div>
                             <!-- there will be no hiding of solutions until
                                  mozilla fixes their weird math bug. -->
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
      <xsl:choose>
         <xsl:when test="@homepage">
               <xsl:apply-templates select="cnx:honorific | cnx:firstname |
                   cnx:othername | cnx:surname | cnx:lineage"/>
               <xsl:apply-templates select="cnx:email"/>
               <a class="homepage" href="{@homepage}">homepage</a>
         </xsl:when>
         <xsl:otherwise>
               <xsl:apply-templates />
         </xsl:otherwise>
      </xsl:choose>
    </div>
  </xsl:template>

  <!--EMAIL-->
  <xsl:template match='cnx:email'>
      <a class="email" href="mailto:{.}">
          <xsl:apply-templates/> 
      </a>
  </xsl:template>

  <!--HONORIFIC-->
  <xsl:template match='cnx:honorific'>
    <span class='honorific'>
       <xsl:apply-templates/> <xsl:text> </xsl:text>
    </span>
  </xsl:template>
  
  <!--FIRSTNAME-->
  <xsl:template match='cnx:firstname'>
    <span class='firstname'>
       <xsl:apply-templates/> <xsl:text> </xsl:text>
    </span>
  </xsl:template>
  
  <!--OTHERNAME-->
  <xsl:template match='cnx:othername'>
    <span class='othername'>
       <xsl:apply-templates/> <xsl:text> </xsl:text>
    </span>
  </xsl:template>
  
  <!--SURNAME-->
  <xsl:template match='cnx:surname'>
    <span class='surname'>
       <xsl:apply-templates/> <xsl:text> </xsl:text>
    </span>
  </xsl:template>
  
  <!--LINEAGE-->
  <xsl:template match='cnx:lineage'>
    <span class='lineage'>
       <xsl:apply-templates/> <xsl:text> </xsl:text>
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
      <xsl:choose>
         <xsl:when test="@homepage">
             <xsl:apply-templates select="cnx:honorific | cnx:firstname |
                   cnx:othername | cnx:surname | cnx:lineage"/>
             <xsl:apply-templates select="cnx:email"/>
             <a class="homepage" href="{@homepage}">homepage</a>  
         </xsl:when>
         <xsl:otherwise>
               <xsl:apply-templates />
         </xsl:otherwise>
      </xsl:choose>
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
      <xsl:if test="@type">
	<xsl:attribute name="title">
	  <xsl:value-of select="@type"/>
	</xsl:attribute>
      </xsl:if>
      <xsl:apply-templates/>
    </div>
  </xsl:template>

</xsl:stylesheet>




















