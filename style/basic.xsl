<?xml version= "1.0" standalone="no"?>


<!--CHECK HOW IMPORTS WITH MATH-->
<!--CHECK IF CNXN STILL WORKS RIGHT with eqn-->
                            

<!--
This stylesheet transforms a CNXML document, with no math, for
display in an XML enabled browser.  

It applies the templates in corecnxml.xsl first, then uses the
identity transformation (ident.xsl) for the remaining tags, leaving
them unaltered.

This stylesheet is appropriate for CNXML documents that contain no
MathML.  The output is a combination of CNXML, and XHTML.
-->


<xsl:stylesheet version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:cnx="http://cnx.rice.edu/cnxml/0.3"
  xmlns:xlink="http://www.w3.org/1999/xlink"
  xmlns:html="http://www.w3.org/1999/xhtml"
  xmlns="http://cnx.rice.edu/cnxml/0.3"
  exclude-result-prefixes="cnx">

  <!-- Use identity transform as a last resort -->
  <xsl:import href="ident.xsl"/>
  
  <!-- Core cnxml transform is the highest priority -->
  <xsl:import href="corecnxml.xsl"/>


  <xsl:output doctype-system="http://cnx.rice.edu/cnxml/0.3/DTD/mozcompat.ent"
	      omit-xml-declaration="no"
	      indent="yes"/>


  <!-- Root Node -->
  <xsl:template match="/">

    <!--Allow access to multiple stylesheets.-->
    <xsl:processing-instruction name="xml-stylesheet">
      type="text/css" title="Default" media="screen"
      href="http://cnx.rice.edu/cnxml/0.3/style/cnxml1.css"
    </xsl:processing-instruction>
    
    <xsl:processing-instruction name="xml-stylesheet">
      type="text/css" title="Style 2" media="screen" alternate="yes"
      href="http://cnx.rice.edu/cnxml/0.3/style/cnxml2.css"
    </xsl:processing-instruction>

    <xsl:processing-instruction name="xml-stylesheet">
      type="text/css" title="Style 3" media="screen" alternate="yes"
      href="http://cnx.rice.edu/cnxml/0.3/style/cnxml3.css"
    </xsl:processing-instruction>

    <xsl:processing-instruction name="xml-stylesheet">
      type="text/css" title="Style 4" media="screen" alternate="yes"
      href="http://cnx.rice.edu/cnxml/0.3/style/cnxml4.css"
    </xsl:processing-instruction>
    
    <xsl:apply-templates/>
  </xsl:template>
 <xsl:template match="cnx:module">
    <module id="{@id}"
	    levelmask="{@levelmask}"
	    created="{@created}"
	    revised="{@revised}"
	    version="{@version}">
      
      <html:title><xsl:value-of select="cnx:name" /></html:title>

      <xsl:apply-templates />	
    
      <!--BUG REPORT and SUGGESTION info goes at the bottom.-->

   <para id="bug">
    <link xlink:type="simple"
          xlink:href="http://cnx.rice.edu/forms/bugReport.cfm?id={@id}"
          xlink:show="replace"
          xlink:actuate="onRequest" >
            Submit a BUG REPORT.   
    </link>
   </para>

   <para id="suggestion">
    <link xlink:type="simple"
          xlink:href="http://cnx.rice.edu/forms/comment.html"
          xlink:show="replace"
          xlink:actuate="onRequest" > 
            Submit a SUGGESTION.
    </link>
   </para>

    </module>
  </xsl:template>



<!-- LINK -->
    <xsl:template match="cnx:link">
         <link xlink:type="simple"
               xlink:href="{@src}"
               xlink:show="replace"
               xlink:actuate="onRequest" >   
            <xsl:apply-templates />
         </link>
    </xsl:template>



<!-- CNXN -->
    <!-- first the parser looks at the third tag here, if there is a target and
    a module, then the 3rd template is applied.  if both are not present, it
    will then see if there is a module specified, and if so apply the 2nd
    template. otherwise, there must just be a target specified, and it will
    apply the 1st template. -->

    <!-- if there is a target only specified -->
    <xsl:template match="cnx:cnxn[@target]">
         <cnxn strength="{@strength}"
               xlink:type="simple"
               xlink:href="#{@target}"
               xlink:show="replace"
               xlink:actuate="onRequest" >
            <xsl:apply-templates />
         </cnxn>
    </xsl:template>

    <!-- if there is a module only specified -->
    <xsl:template match="cnx:cnxn[@module]">
         <cnxn strength="{@strength}"
               xlink:type="simple"
               xlink:href="http://cnx.rice.edu/cgi-bin/showmodule.cgi?id={@module}"
               xlink:show="replace"
               xlink:actuate="onRequest" >
            <xsl:apply-templates />
         </cnxn>
    </xsl:template>


    <!-- if there is a target and a module specified -->
    <xsl:template match="cnx:cnxn[@module and @target]">
         <cnxn strength="{@strength}"
               xlink:type="simple"
               xlink:href="http://cnx.rice.edu/cgi-bin/showmodule.cgi?id={@module}/#{@target}"
               xlink:show="replace"
               xlink:actuate="onRequest" >
            <xsl:apply-templates />
         </cnxn>
    </xsl:template>
  
  <!--LIST-->
  <!-- Default list.  Prints a list of type='bulleted'.
  <xsl:template match="cnx:list">
    <ul id='{@id}'>
      <xsl:for-each select="cnx:item">
	<li id='{@id}'><xsl:apply-templates/></li>
      </xsl:for-each>
    </ul>
  </xsl:template> -->
  
  <!--LIST with type='enumerated'-->
  <!-- Numbered lists -->
  <xsl:template match="cnx:list[@type='enumerated']">
    <html:ol id='{@id}'>
      <xsl:for-each select="cnx:item">
	<html:li id='{@id}'><xsl:apply-templates/></html:li>
      </xsl:for-each>
    </html:ol>
  </xsl:template>


</xsl:stylesheet>

