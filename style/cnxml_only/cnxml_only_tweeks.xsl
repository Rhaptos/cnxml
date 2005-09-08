<?xml version= "1.0" standalone="no"?>

<xsl:stylesheet version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:cnx="http://cnx.rice.edu/cnxml/0.4"
  xmlns:md="http://cnx.rice.edu/mdml/0.4"
  xmlns:m="http://www.w3.org/1998/Math/MathML"
  xmlns="http://www.w3.org/1999/xhtml"
  xmlns:xlink="http://www.w3.org/1999/xlink"
>

  <!-- Include the CALS Table stylesheet -->
  <xsl:include href='../common/table.xsl' />

  <xsl:param name="baseurl" select="''" />
  <xsl:param name="eip" select="0" />
  <xsl:param name="version" select="''" />
  <xsl:param name="id" select="''" />

  <!-- Declare a key for the id attribute since we may not be loading
  the DTD so we can't rely on id() working --> 
  <xsl:key name='id' match='*' use='@id'/>

  <!--ID CHECK -->
  <xsl:template name='IdCheck'>
    <xsl:if test='@id'>
      <xsl:attribute name='id'>
	<xsl:value-of select='@id'/>
      </xsl:attribute>
    </xsl:if>
  </xsl:template>

  <!-- Header and Body for the Module -->
  <xsl:template match="cnx:module">
    <html>

      <!-- Use the override version if specified, otherwise use the one in the document -->
      <xsl:variable name="version">
	<xsl:choose>
	  <xsl:when test="$version"><xsl:value-of select="$version" /></xsl:when>
	  <xsl:otherwise><xsl:value-of select="//md:version" /></xsl:otherwise>
	</xsl:choose>
      </xsl:variable>

      <!-- Use the override id if specified, otherwise use the one in the document -->
      <xsl:variable name="id">
	<xsl:choose>
	  <xsl:when test="$id"><xsl:value-of select="$id" /></xsl:when>
	  <xsl:otherwise><xsl:value-of select="@id" /></xsl:otherwise>
	</xsl:choose>
      </xsl:variable>

      <!-- Editing In Place javascript -->
      <xsl:if test="$eip">
	<form id="eipCommitForm" action="/content/{$id}/latest/postUpdate" method="POST">
	  <div id="eipInstructionBox"><span>To edit text, click on an
	  area with a white background.</span></div>

	  <div id="eipCommitBox">
	    <div id="eipCommitLabel">Briefly describe your changes:</div>
	    <textarea id="eipCommitText" name="message"  rows="2" />
	  </div>
	  <div id="eipCommitButtonBox">
	    <input type="hidden" name="baseVersion" value="{$version}"/>
	    <button type="button" name="commit" value="Submit" onclick="doCommit()">Submit</button> 
	    <button type="button" name="cancel" value="Discard" onclick="doCancel()">Discard</button>
	    <!-- <button alt="Patch" onclick="patchOnClick()" disabled="true">Patch</button> -->
	  </div>
	</form>
      </xsl:if>      

      <cnx:module id="{$id}" created="{//md:created}" revised="{//md:revised}" version="{$version}">

      <head>
	  <xsl:if test='$baseurl'><base href='{$baseurl}' /></xsl:if>

	  <!--  Link to the module source -->
          <link rel="source" title="Source" type="text/xml" href="/content/{$id}/{$version}/source" />
          <link rel="module" title="Module" type="text/xml" href="/content/{$id}/latest/" />
	  
	  <!-- Javascript so that answer can appear on click. -->
	  <script type="application/x-javascript" src="/cnxml/0.4/scripts/exercise.js" />
	  <script type="application/x-javascript" src="/qml/1.0/scripts/qml_1-0.js" />

          <!-- Editing In Place javascript -->
	  <xsl:if test="$eip">
	    <script type="application/x-javascript" src="/cnxml/0.4/scripts/editInPlace.js" />
	  </xsl:if>
	  
	  <!-- ****QML**** sets the feedback and hints to non-visible. -->
	  <style type="text/css">
	    .feedback {display:none}
	    .hint {display:none}
	  </style>
	
          <link rel="stylesheet" title="Default" type="text/css" href="/cnxml/0.4/style/cnxml_only/max.css" />

          <!-- Editing In Place CSS -->
	  <xsl:if test="$eip">
              <link rel="stylesheet" title="Default" type="text/css" href="/cnxml/0.4/style/editInPlace.css" />
          </xsl:if>
<!--
	<link rel="alternate stylesheet" title="Red-Gray" type="text/css"
	      href="../colors/red-gray.css"/>
	<link rel="alternate stylesheet" title="Night" type="text/css"
	      href="../colors/night.css"/>
	<link rel="alternate stylesheet" title="Autumn" type="text/css" 
	      href="../colors/autumn.css"/>
	<link rel="alternate stylesheet" title="Desert" type="text/css"
	      href="../colors/desert.css"/>
	<link rel="alternate stylesheet" title="Marine" type="text/css"
	      href="../colors/marine.css"/>
	<link rel="alternate stylesheet" title="Barbie" type="text/css"
	      href="../colors/barbie.css"/>
-->
	  
	  <!--MODULE's NAME-->
	  <title><xsl:value-of select="cnx:name"/></title>
	</head>	

	<!-- rest of the content -->
     	<xsl:apply-templates />
	
	<xsl:for-each select="//cnx:note[@type='footnote']">
	  <xsl:variable name="footnote-number">
	    <xsl:number level="any" count="//cnx:note[@type='footnote']" format="1" />
	  </xsl:variable>
	  <a class="footnote-number" name="footnote{$footnote-number}" />
	  <xsl:copy>
	    <xsl:copy-of select="@*" />
	      <xsl:attribute name="footnote-number">
		<xsl:number level="any" count="//cnx:note[@type='footnote']" />
	      </xsl:attribute>
	    <xsl:apply-templates />
	  </xsl:copy>
	</xsl:for-each>

	<!-- AUTHOR and MAINTAINER at bottom -->	   
	<div class="authorlist-maintainerlist">
	  <xsl:apply-templates select="//md:authorlist|//md:maintainerlist"/>
	</div>
	
	<!-- Connexions project LOGO and CONTACT EMAIL -->
	<div class="footer">
	  <table border="0" width="100%" class="footer" cellpadding="0" cellspacing="0">
	    <tr>
	      <td class="footer-logo">
		<a href="http://cnx.rice.edu/" class="footer-logo">
		  <img src="/images/the-connexions-project-footer.jpg" border="0" alt="The Connexions Project, Rice University" title="The Connexions Project, Rice University"/>
		</a> 
	      </td>
	      <td class="questions-comments" align="right" valign="top">
		<a class="questions-comments" href="mailto:cnx@rice.edu">Questions? Comments?</a>
	      </td>
	    </tr>
	  </table>
	</div>

      </cnx:module>

    </html>
  </xsl:template>
  
  <!-- REMOVE AUTHORLIST and MAINTATINERLIST from METADATA -->
  <xsl:template match="cnx:metadata">
    <metadata>
      <xsl:apply-templates select="*[not(self::md:authorlist|self::md:maintainerlist)]" />
    </metadata>	  
  </xsl:template>
  
  <!--HOMEPAGE Attribute-->
  <xsl:template match="md:authorlist|md:maintainerlist">
    <xsl:copy>
      <xsl:copy-of select="@*" />
      <xsl:for-each select="md:author|md:maintainer">
	<xsl:copy>
	  <xsl:copy-of select="@*" />
	  <xsl:choose>
	    <xsl:when test="@homepage">
	      <xsl:apply-templates />
	      <a class="homepage" href="{@homepage}">homepage</a>
	    </xsl:when>
	    <xsl:otherwise>
	      <xsl:apply-templates />
	    </xsl:otherwise>
	  </xsl:choose>
	</xsl:copy>
	<xsl:if test="not(position()=last())">, </xsl:if>
      </xsl:for-each>
    </xsl:copy>
  </xsl:template> 

  <!--EMAIL-->
  <xsl:template match='md:email'>
     <xsl:copy>
       <xsl:copy-of select="@*"/>
       <xsl:attribute name="xlink:type">simple</xsl:attribute>
       <xsl:attribute name="xlink:show">replace</xsl:attribute>
       <xsl:attribute name="xlink:actuate">onRequest</xsl:attribute>
       <xsl:attribute name="xlink:href">mailto:<xsl:value-of select="."/></xsl:attribute> 
      <xsl:value-of select="normalize-space(.)" />
     </xsl:copy>
  </xsl:template>

  <!-- CALS TABLE -->
  <xsl:template match="cnx:table">
    <div class="cals-table" align="center">
      <span class="table-name"><xsl:value-of select="cnx:name" /></span>
      <xsl:apply-templates />
    </div>
  </xsl:template>
  
  <!-- LINK -->
  <xsl:template match="cnx:link">
    <xsl:copy>
       <xsl:copy-of select="@*"/>
       <xsl:attribute name="xlink:type">simple</xsl:attribute>
       <xsl:attribute name="xlink:show">replace</xsl:attribute>
       <xsl:attribute name="xlink:actuate">onRequest</xsl:attribute>
       <xsl:attribute name="xlink:href"><xsl:value-of select="@src"/></xsl:attribute> 
      <xsl:value-of select="normalize-space(.)" />
     </xsl:copy>
  </xsl:template>

  <!-- LIST: Enumerated -->
  <xsl:template match="cnx:list[@type='enumerated']">
    <ol id="{@id}">
      <xsl:apply-templates />
    </ol>
  </xsl:template>

  <!-- LIST: Bulleted (default) -->
  <xsl:template match="cnx:list">
    <ul id="{@id}">
      <xsl:apply-templates />
    </ul>
  </xsl:template>

  <!-- ITEM -->
  <xsl:template match="cnx:item">
    <li>
      <xsl:call-template name='IdCheck'/>
      <xsl:apply-templates />
    </li>
  </xsl:template>

  <!-- CNXN -->
  <!-- first the parser looks at the third tag here, if there is a target and
  a module, then the 3rd template is applied.  if both are not present, it
  will then see if there is a module specified, and if so apply the 2nd
  template. otherwise, there must just be a target specified, and it will
  apply the 1st template. -->
  
  <!-- if there is a target only specified -->
  <!-- and then if there is just a target specified, then we can try to infer what the author was attempting to connect to.  if there is no text, we will 
  insert text.  if there is text, that text will serve as the link text.  -->
    
  <xsl:template match="cnx:cnxn[not(@module)]">
    <xsl:copy>
      <xsl:copy-of select="@*"/>
      <xsl:attribute name="title">Strength <xsl:value-of select="@strength"/></xsl:attribute>
      <xsl:attribute name="xlink:type">simple</xsl:attribute>
      <xsl:attribute name="xlink:show">replace</xsl:attribute>
      <xsl:attribute name="xlink:actuate">onRequest</xsl:attribute>
      <xsl:attribute name="xlink:href">#<xsl:value-of select="@target"/></xsl:attribute> 

      <xsl:choose>

        <xsl:when test="key('id',@target)[self::cnx:equation]">
          Equation 
          <xsl:for-each select="key('id',@target)">   
            <xsl:number level="any" />
          </xsl:for-each>
          <xsl:value-of select="normalize-space(.)" />
        </xsl:when>
	
        <xsl:when  test="key('id',@target)[self::cnx:figure]">
          Figure
          <xsl:for-each select="key('id',@target)"> 
            <xsl:number level="any" />
          </xsl:for-each>
          <xsl:apply-templates />
        </xsl:when>

	<xsl:when test="key('id',@target)[self::cnx:subfigure]">
	  Subfigure
	  <xsl:for-each select="key('id',@target)">
	    <xsl:number level="any" count="cnx:figure" />.<xsl:number level="single" />
	  </xsl:for-each>
	  <xsl:apply-templates />
	</xsl:when>

	<xsl:otherwise>
	  <xsl:choose>
	    <xsl:when test="string()">
	      <xsl:apply-templates select="normalize-space(.)" />
	    </xsl:when>
	    <xsl:otherwise>
	      (Reference)
	    </xsl:otherwise>
	  </xsl:choose>
	</xsl:otherwise>

      </xsl:choose>

    </xsl:copy>
  </xsl:template>  
  
  <!-- if there is a module only specified -->
  <xsl:template match="cnx:cnxn[not(@target)]">
    <xsl:copy>
      <xsl:copy-of select="@*"/>
      <xsl:attribute name="title">Strength <xsl:value-of select="@strength"/></xsl:attribute>
      <xsl:attribute name="xlink:type">simple</xsl:attribute>
      <xsl:attribute name="xlink:show">replace</xsl:attribute>
      <xsl:attribute name="xlink:actuate">onRequest</xsl:attribute>
      <xsl:attribute name="xlink:href">/content/<xsl:value-of select="@module"/>/latest/</xsl:attribute>
      <xsl:choose>
	<xsl:when test='string()'>
	  <xsl:value-of select="normalize-space(.)" />
	</xsl:when>
	<xsl:otherwise>
	  Document
	</xsl:otherwise>
      </xsl:choose>
    </xsl:copy>
  </xsl:template>
  
  <!-- if there is a target and a module specified -->
  <xsl:template match="cnx:cnxn[@module and @target]">
    <xsl:copy>
      <xsl:copy-of select="@*"/>
      <xsl:attribute name="title">Strength <xsl:value-of select="@strength"/></xsl:attribute>
      <xsl:attribute name="xlink:type">simple</xsl:attribute>
      <xsl:attribute name="xlink:show">replace</xsl:attribute>
      <xsl:attribute name="xlink:actuate">onRequest</xsl:attribute>
      <xsl:attribute name="xlink:href">/content/<xsl:value-of select="@module"/>/latest/#<xsl:value-of select="@target"/></xsl:attribute>
      <xsl:choose>
	<xsl:when test='string()'>
	  <xsl:value-of select="normalize-space(.)" />
	</xsl:when>
	<xsl:otherwise>
	  (Reference)
	</xsl:otherwise>
      </xsl:choose>
    </xsl:copy>
  </xsl:template>

  <!-- EXERCISE -->
  <xsl:template match="cnx:exercise">
    <div class="exercise" id="{@id}">
      <xsl:apply-templates />
    </div>
  </xsl:template>

  <!-- PROBLEM numbering -->
  <xsl:template match="cnx:problem">
    <xsl:copy>
      <xsl:copy-of select="@*" />
	<xsl:attribute name="number">
	  <xsl:number level="any" count="cnx:problem"/>
        </xsl:attribute>
      <xsl:apply-templates />
    </xsl:copy>
  </xsl:template>

  <!--SOLUTION-->
  <xsl:template match="cnx:solution">
    <div class="button" onclick="showSolution('{../@id}')">
      <span class="button-text">Click for Solution</span>
    </div>
    <div class="solution" onclick="hideSolution('{../@id}')">
      <xsl:attribute name="number">
	<xsl:number level="any" count="cnx:solution" />
      </xsl:attribute>
      <xsl:apply-templates />
      <div class="button">
	<span class="button-text">Hide Solution</span>
      </div>
    </div>
  </xsl:template>

  <!-- RULE numbering -->
  <xsl:template match="cnx:rule">
    <xsl:variable name="type" select="@type"/>
    <xsl:copy>
      <xsl:copy-of select="@*"/>
	<xsl:attribute name="number">
	  <xsl:number level="any" count="cnx:rule[@type=$type]"/>
        </xsl:attribute>
      <xsl:apply-templates />
    </xsl:copy>
  </xsl:template>
  
  <!-- EXAMPLE numbering -->
  <xsl:template match="cnx:example"> 
    <xsl:copy>
      <xsl:copy-of select="@*"/>
	<xsl:attribute name="number">
	  <xsl:number level="any" count="cnx:example[not(parent::cnx:definition|parent::cnx:rule)]"/>
        </xsl:attribute>
      <xsl:apply-templates />
    </xsl:copy>
  </xsl:template>
  
  <!-- DEFINITION numbering -->
  <xsl:template match="cnx:definition">
    <xsl:copy>
      <xsl:copy-of select="@*"/>
	<xsl:attribute name="number">
	  <xsl:number level="any" count="cnx:definition"/>
        </xsl:attribute>
      <xsl:apply-templates />
    </xsl:copy>
  </xsl:template>  
  
  <!-- MEANING numbering -->
  <xsl:template match="cnx:meaning">
    <xsl:copy>
      <xsl:copy-of select="@*"/>
	<xsl:attribute name="number">
	  <xsl:number level="multiple" count="cnx:meaning" format="1. "/>
	</xsl:attribute>
      <xsl:apply-templates />
    </xsl:copy>
  </xsl:template>

  <!-- FOOTNOTE -->
  <xsl:template match="cnx:note[@type='footnote']">
    <xsl:variable name="footnote-number">
      <xsl:number level="any" count="//cnx:note[@type='footnote']" format="1" />
    </xsl:variable>
    <a class="footnote-reference" href="#footnote{$footnote-number}">
      <xsl:value-of select="$footnote-number" />
    </a>
  </xsl:template>

  <!-- FIGURE and SUBFIGURES -->
  <xsl:template match="cnx:figure">	
    
    <a>
      <xsl:if test='@id'>
	<xsl:attribute name='name'>
	  <xsl:value-of select='@id'/>
	</xsl:attribute>
      </xsl:if>
    </a>
    <div align="center" class="figure">
      <table class="figure" border="0" cellspacing="8" cellpadding="0" width="50%">
	
	<!-- Stores value of orient attribute of figure for use later -->
	<xsl:variable name="orient">
	  <xsl:value-of select="@orient"/>
	</xsl:variable>	
	
	<xsl:choose>
	  <xsl:when test="cnx:subfigure">
	    
	    <xsl:choose>
	      
	      <!-- How to treat the figure that has HORIZONTAL SUBFIGURES -->      
	      <xsl:when test="$orient='horizontal'">
		<xsl:variable name="subfigure-quantity" select="count(cnx:subfigure)" />
		<tr>
		  <td colspan="{$subfigure-quantity}">
		    <name>
		      <xsl:value-of select="cnx:name"/>
		    </name>
		  </td>
		</tr>
		<tr>
		  <xsl:for-each select="cnx:subfigure">
		    <td valign="bottom">
		      <name class="subfigure">
			<xsl:value-of select="cnx:name" />
		      </name>
		    </td>
		  </xsl:for-each>
		</tr>
		<tr>
		  <xsl:for-each select="cnx:subfigure">
		    <td align="center" valign="middle">
		      <xsl:copy>
			<xsl:copy-of select="@*" />
			<xsl:apply-templates select="cnx:media|cnx:table|cnx:codeblock" />
		      </xsl:copy>
		    </td>
		  </xsl:for-each>
		</tr>
		<tr>
		  <xsl:for-each select="cnx:subfigure">
		    <td valign="top" class="horizontal">
			<caption>
			  <xsl:attribute name="number">
			    <xsl:number level="any" count="cnx:figure" />.<xsl:number level="single" count="cnx:subfigure" />
			  </xsl:attribute>
			  <xsl:apply-templates select="cnx:caption" />
			</caption>
		    </td>
		  </xsl:for-each>
		</tr>
		  <tr>
		    <td colspan="{$subfigure-quantity}">
		      <caption>
		   	<xsl:attribute name="number">
			  <xsl:number level="any" count="cnx:figure" />
			</xsl:attribute>
			<xsl:apply-templates select="cnx:caption" />
		      </caption>
		    </td>
		  </tr>
	      </xsl:when>
	      
	      <!-- How to treat the figure that has VERTICAL SUBFIGURES -->
	      <xsl:when test="$orient='vertical'">
		<tr>
		  <td>
		    <name>
		      <xsl:value-of select="cnx:name"/>
		    </name>
		  </td>
		</tr>
		<xsl:for-each select="cnx:subfigure">
		  <tr>
		    <td>
		      <name class="subfigure">
			<xsl:value-of select="cnx:name" />
		      </name>
		    </td>
		  </tr>
		  <tr>
		    <td align="center">
		      <xsl:copy>
			<xsl:copy-of select="@*" />
			<xsl:apply-templates select="cnx:media|cnx:table|cnx:codeblock" />
		      </xsl:copy>
		    </td>
		  </tr>
		    <tr>
		      <td class="vertical">
			<caption>
			  <xsl:attribute name="number">
			    <xsl:number level="any" count="cnx:figure" />.<xsl:number level="single" count="cnx:subfigure" />
			  </xsl:attribute>
			  <xsl:apply-templates select="cnx:caption" />
			</caption>
		      </td>
		    </tr>
		</xsl:for-each>
		  <tr>
		    <td>
		      <caption>
		   	<xsl:attribute name="number">
			  <xsl:number level="any" count="cnx:figure" />
			</xsl:attribute>
			<xsl:apply-templates select="cnx:caption" />
		      </caption>
		    </td>
		  </tr>
	      </xsl:when>
	    </xsl:choose>
	  </xsl:when>
	  
	  <xsl:otherwise>
	    <!--The case when there are NO SUBFIGURES.-->
	    <tr>
	      <td>
		<name>
		  <xsl:value-of select="cnx:name"/>
		</name>
	      </td>
	    </tr>
	    <tr>
	      <td align="center">
		<figure>
		  <xsl:call-template name="IdCheck"/>
		  <xsl:apply-templates select="cnx:media|cnx:table|cnx:codeblock"/>
		</figure>
	      </td>
	    </tr>
	      <tr>
		<td>
		  <caption>
		    <xsl:attribute name="number">
		      <xsl:number level="any" count="cnx:figure" />
		    </xsl:attribute>
		    <xsl:apply-templates select="cnx:caption" />
		  </caption>
		</td>
	      </tr>
	  </xsl:otherwise>	    
	</xsl:choose>
	
      </table>
    </div>
    
  </xsl:template>

  <!-- CAPTION -->
  <xsl:template match="cnx:caption">
    <xsl:apply-templates />
  </xsl:template>

  <!-- MEDIA:IMAGE -->
  <xsl:template match="cnx:media[starts-with(@type,'image/')]">
    <img src="{@src}">
      <xsl:call-template name="IdCheck" />
    </img>
  </xsl:template>

  <!-- MEDIA:APPLET -->
  <xsl:template match="cnx:media[@type='application/x-java-applet']">
    <applet code="{@src}">
      <xsl:call-template name='IdCheck'/>
    </applet>
  </xsl:template>

  <!-- Quicktime Movies -->
  <xsl:template match="cnx:media[@type='video/mov']">
    <object href='{@src}'>
      <xsl:call-template name='IdCheck'/>
      <embed src="{@src}" />
    </object>
  </xsl:template>


</xsl:stylesheet>



<!-- HOW I WAS TRYING TO MAKE CERTAIN EXAMPLES NUMBER DIFFERENTLY
<xsl:choose>
<xsl:when test="parent::cnx:definition">
<xsl:number from="cnx:meaning" count="cnx:definition/cnx:example"/>: DEFINITION-MEANING!!!
</xsl:when>
<xsl:when test="parent::cnx:rule">
<xsl:number count="cnx:rule/cnx:example"/>: RULE!!!!
</xsl:when>
<xsl:otherwise>
<xsl:number level="single" count="cnx:example[not(parent::cnx:definition|parent::cnx:rule)]"/>: OTHERWISE!!!
</xsl:otherwise>
</xsl:choose>
-->
