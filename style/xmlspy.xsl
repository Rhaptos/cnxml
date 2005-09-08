<?xml version="1.0"?>

<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:cnx="http://cnx.rice.edu/cnxml"
  xmlns:m="http://www.w3.org/1998/Math/MathML" 
  xmlns="http://www.w3.org/1999/xhtml"
  xmlns:bib="http://bibtexml.sf.net/">

  <!-- Import identity transform first so it gets lowest priority -->
  <xsl:import href="ident.xsl" />

  <!-- Bibtexml support -->
  <xsl:include href='http://cnx.rice.edu/technology/bibtexml/stylesheet/bibtexml.xsl'/>

  <!-- MathML support 
  <xsl:include href='http://cnx.rice.edu/technology/mathml2/style/cnxmathmlc2p.xsl' />-->

  <!-- Include the CALS Table stylesheet -->
  <xsl:include href='table.xsl' />

  <xsl:param name="toc" select="0" />
  <xsl:param name="viewmath" select="0" />

  <xsl:output omit-xml-declaration="yes" indent="yes"/>

  <!--ID CHECK -->
  <xsl:template name='IdCheck'>
    <xsl:if test='@id'>
      <xsl:attribute name='id'>
	<xsl:value-of select='@id'/>
      </xsl:attribute>
    </xsl:if>
  </xsl:template>

  <!-- Declare a key for the id attribute since we may not be loading
  the DTD so we can't rely on id() working --> 
  <xsl:key name='id' match='*' use='@id'/>

  <!-- Root Node -->
  <xsl:template match="/">
    <html>
      <head>
	<link rel="stylesheet" title="Sky" type="text/css" href="http://cnx.rice.edu/stylesheets/sky/document.css" />
      </head>
       <body>
      	<!--MODULE's NAME-->
      	<div id="header"><h1 id="name-box"><xsl:value-of select="*/*[local-name()='name']"/></h1></div>

      <xsl:apply-templates/>
     </body> 
    </html>
  </xsl:template>

  <!-- Header and Body for the Document -->
  <xsl:template match="cnx:module|cnx:document">

    <div id="main">

      <!-- rest of content -->

      <xsl:if test="$toc">
        <input type="button" value="View/Hide Table of Contents" onclick="toggleToc();"/>
	<xsl:call-template name="toc" />
      </xsl:if>

      <!-- Transform all of the content except glossary and bib. -->
      <xsl:apply-templates select="*[not(self::cnx:glossary|self::bib:file)]"/>


      <!-- FOOTNOTEs -->
      <xsl:for-each select="descendant::cnx:note[@type='footnote']">
        <xsl:variable name="footnote-number">
          <xsl:number level="any" count="//cnx:note[@type='footnote']" format="1" />
        </xsl:variable>
        <a class="footnote-number" name="footnote{$footnote-number}"><xsl:text> </xsl:text></a>
        <div class="footnote">
	  <xsl:call-template name='IdCheck'/>
          <span class="footnote-number">
	    <xsl:number level="any" count="//cnx:note[@type='footnote']" format="1. " />
	  </span>
          <xsl:apply-templates />
        </div>
      </xsl:for-each>
      
      <!-- GLOSSARY -->
      <xsl:if test='cnx:glossary'>
	<div id='glossary'>
	  <span class='glossary'>Glossary</span>
	  <xsl:for-each select='cnx:glossary/cnx:definition'>
	    <xsl:sort select="cnx:term" />
	    <div class='glossary-definition'>
	      <xsl:call-template name='IdCheck'/>
	      <xsl:apply-templates/>
	    </div>
	  </xsl:for-each>
	</div>
      </xsl:if>

      <!--BIBTEXML -->
      <xsl:if test='bib:file'>
	<xsl:apply-templates select='bib:file'/>
      </xsl:if>

   </div>

  </xsl:template>

  <!-- TOC -->
  <xsl:template name="toc">
    <!-- Table of contents -->
    <div class="toc" id="tableofcontents">
      <h2 id='toc'>Table of Contents</h2>
      <ul class="toc">
	<xsl:for-each select="cnx:section|cnx:content/cnx:section">
	  <li class = "toc">
	    <xsl:number level="single" count="cnx:section" format="1.  "/>
	    <a href='#{@id}'><xsl:value-of select="@name|cnx:name"/></a>
	    <ul class="toc">
	      <xsl:for-each select="cnx:section">
		<li class = "toc">
		  <xsl:number level="multiple" count="cnx:section" format="1.1  "/>
		  <a href='#{@id}'><xsl:value-of select="@name|cnx:name"/></a>
		  <ul class="toc">
		    <xsl:for-each select="cnx:section">
		      <li class = "toc">
			<xsl:number level="multiple" count="cnx:section" format="1.1.1  "/>
			<a href='#{@id}'><xsl:value-of select="@name|cnx:name"/></a>
		      </li>
		    </xsl:for-each>
		  </ul>
		</li>
	      </xsl:for-each>
	    </ul>
	  </li>	
	</xsl:for-each>
      </ul>
    </div>
  </xsl:template>

  <!-- METADATA -->
  <xsl:template match="cnx:metadata|cnx:authorlist|cnx:maintainerlist|cnx:keywordlist|cnx:abstract" />

  <!--SECTION-->
  <xsl:template match="cnx:section">
    <div class="section">
      <xsl:call-template name='IdCheck'/>
	  <h2>
	    <xsl:if test="parent::cnx:problem or parent::cnx:solution">
	      <xsl:number level="any" count="cnx:exercise" format="1."/>
	      <xsl:number level="single" format="a) " />
	    </xsl:if>
	    <xsl:value-of select="@name|cnx:name"/>
	  </h2>
      <xsl:apply-templates select="*[not(self::cnx:name)]"/>
    </div>
  </xsl:template>

  <!--CONTENT-->
  <xsl:template match="cnx:content">
    <xsl:apply-templates />
  </xsl:template>

  <!--NAME-->
  <xsl:template match="cnx:name|cnx:title">
    <xsl:if test="parent::*[not(self::cnx:module|self::cnx:document)]">
      <span class="name">
	<xsl:call-template name='IdCheck'/>
	<xsl:apply-templates /><xsl:if test="parent::cnx:meaning"><xsl:text>: </xsl:text></xsl:if>
      </span>
    </xsl:if>
  </xsl:template>

  <!--PARA-->
  <xsl:template match="cnx:para">
    <div class="para">
      <xsl:call-template name='IdCheck'/>
      <xsl:apply-templates/>
    </div>
  </xsl:template>

  <!-- LINK -->
  <xsl:template match="cnx:link">
    <a class="link" href="{@src}">
      <xsl:call-template name='IdCheck'/>
      <xsl:apply-templates />
    </a>
  </xsl:template>

  <!-- CNXN with target attribute only (no document) -->

  <!-- Since the target is in the same document, we know what the author
  is linking to.  If there is text provides, that text will serve as
  the link text. If not, we will provide it, including numbering.  -->
  <xsl:template match="cnx:cnxn[not(@document|@module)]">
    <a class="cnxn" href="#{@target}">
      <xsl:call-template name='IdCheck'/>
      <xsl:if test="@strength">
	<xsl:attribute name="title">Strength <xsl:value-of select="@strength" /></xsl:attribute>
      </xsl:if>
      <xsl:choose>
        <xsl:when test="node()">
	  <xsl:apply-templates />
        </xsl:when>
	<xsl:when test="key('id', @target)">
	  <xsl:choose>
	    <xsl:when test="local-name(key('id',@target))='note' or local-name(key('id',@target))='rule'">
              <xsl:for-each select="key('id',@target)">
		<xsl:variable name="cnxntype" select="@type" />
		<span class="cnxn-target">
		  <xsl:value-of select="@type" />
		</span>
		<xsl:text> </xsl:text>
		<xsl:if test="self::cnx:note">
		  <xsl:number level="any" count="//cnx:note[@type=$cnxntype]"/>
		</xsl:if>
		<xsl:if test="self::cnx:rule">
		  <xsl:number level="any" count="//cnx:rule[@type=$cnxntype]"/>
		</xsl:if>
	      </xsl:for-each>
	    </xsl:when>
	    <xsl:otherwise>
	      <span class="cnxn-target">
		<xsl:value-of select="local-name(key('id',@target))" />
	      </span>
              <xsl:for-each select="key('id',@target)">
                <xsl:text> </xsl:text>
	        <xsl:choose>
		  <xsl:when test="self::cnx:subfigure">
		    <xsl:number level="any" count="//cnx:figure" />.<xsl:number level="single" count="cnx:subfigure" />
		  </xsl:when>
		  <xsl:otherwise>
		    <xsl:number level="any" />
		  </xsl:otherwise>
		</xsl:choose>
	      </xsl:for-each>
	    </xsl:otherwise>
	  </xsl:choose>
        </xsl:when>
	<xsl:otherwise>
	  (Reference)</xsl:otherwise></xsl:choose></a> <!-- this is made w/ poorly formed XSL to eliminate the underlined white space after the parenthesis -->
  </xsl:template>

  <!-- CNXN with document attribute only (no target) -->
  <xsl:template match="cnx:cnxn[not(@target)]">
    <a class="cnxn" href="/content/{@module|@document}/latest/">
      <xsl:call-template name='IdCheck'/>
      <xsl:choose>
	<xsl:when test="string()">
	  <xsl:apply-templates />
	</xsl:when>
	<xsl:otherwise>
	  (Reference)</xsl:otherwise></xsl:choose></a> <!-- this is made w/ poorly formed XSL to eliminate the underlined white space after the parenthesis -->
  </xsl:template>

  <!-- CNXN with target and document attributes -->
  <xsl:template match="cnx:cnxn[@target and (@module or @document)]">
    <a class="cnxn" href="/content/{@module|@document}/latest/#{@target}">
      <xsl:call-template name='IdCheck'/>
      <xsl:choose>
	<xsl:when test="string()">
	  <xsl:value-of select="normalize-space(.)" />
	</xsl:when>
	<xsl:otherwise>
	  (Reference)</xsl:otherwise></xsl:choose></a> <!-- this is made w/ poorly formed XSL to eliminate the underlined white space after the parenthesis -->
  </xsl:template>

  <!--EMPHASIS-->
  <xsl:template match="cnx:emphasis">
    <i>
      <xsl:call-template name='IdCheck'/>
      <xsl:apply-templates/>
    </i>
  </xsl:template>

  <!--IMPORTANT-->
  <xsl:template match="cnx:important">
    <b>
      <xsl:apply-templates/>
    </b>
  </xsl:template>

  <!-- QUOTE -->
  <xsl:template match="cnx:quote">
    <xsl:choose>
      <xsl:when test="@type='block'">
	<blockquote>
	  <xsl:call-template name="IdCheck"/>
	  <xsl:apply-templates />
	  <xsl:if test="@src">
	    <span class="quote-source-before">[</span>
	    <a href="{@src}" class="quote-source">source</a>
	    <span class="quote-source-after">]</span>
	  </xsl:if>
	</blockquote>
      </xsl:when>
      <xsl:otherwise>
	<span class="quote">
	  <xsl:call-template name='IdCheck'/>
	  <xsl:apply-templates />
	</span>
	<xsl:if test="@src">
	  <span class="quote-source-before">[</span>
	  <a href="{@src}" class="quote-source">source</a>
	  <span class="quote-source-after">]</span>
	</xsl:if>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <!-- FOREIGN -->
  <xsl:template match="cnx:foreign">
    <span class="foreign">
      <xsl:call-template name='IdCheck'/>
      <xsl:apply-templates />
    </span>
  </xsl:template>

  <!-- CODE -->
  <xsl:template match="cnx:codeline|cnx:code">
    <code class="codeline">
      <xsl:call-template name='IdCheck'/>
      <xsl:apply-templates />
    </code>
  </xsl:template>
  <!--CODE.block (IE understands pre better than code.codeblock) -->
  <xsl:template match="cnx:codeblock|cnx:code[@type='block']">
    <pre>
      <xsl:call-template name='IdCheck'/>
      <xsl:apply-templates />
    </pre>  
  </xsl:template>

  <!-- FOOTNOTE -->
  <xsl:template match="cnx:note[@type='footnote']">
    <xsl:variable name="footnote-number">
      <xsl:number level="any" count="//cnx:note[@type='footnote']" format="1" />
    </xsl:variable>
    <span class="footnote-reference">
      <a class="footnote-reference" href="#footnote{$footnote-number}">
	<xsl:value-of select="$footnote-number" />
      </a><xsl:if test="following-sibling::node()[normalize-space()!=''][1][self::cnx:note and @type='footnote']">, </xsl:if>
    </span>
  </xsl:template>

  <!-- NOTE -->
  <xsl:template match="cnx:note[not(@type='footnote')]">
    <div class="note">
      <xsl:call-template name='IdCheck'/>
      <xsl:choose>
	<xsl:when test="@type=''">
	  <span class="note-before">Note: </span>
	</xsl:when>
	<xsl:otherwise>
	  <span class="note-before"><xsl:value-of select="@type"/>: </span>
	</xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates/>
    </div>
  </xsl:template>
  
  <!--EXAMPLE-->
  <xsl:template match="cnx:example">
    <div class="example">
      <xsl:call-template name='IdCheck'/>
      <span class="example-before">
	Example<xsl:if test="not(parent::cnx:definition|parent::cnx:rule)">
	  <xsl:text> </xsl:text>
	  <xsl:number level="any" count="cnx:example[not(parent::cnx:definition|parent::cnx:rule)]"/>
	</xsl:if>
	<xsl:if test="cnx:name|ancestor::cnx:glossary">: </xsl:if>
      </span>
      <xsl:if test="not(ancestor::bib:file)">
	<span class="example-name">
	  <xsl:value-of select="cnx:name" /><xsl:text>&#160;</xsl:text>
	</span>
      </xsl:if>
      <xsl:if test="ancestor::bib:file">
	<span class="example-name">
	  <xsl:value-of select="cnx:name" />
	</span>
      </xsl:if>
      <xsl:apply-templates select="*[not(self::cnx:name)]" />
    </div>
  </xsl:template>

  <!--DEFINITION-->
  <xsl:template match="cnx:definition">
    <div class="definition">
      <xsl:call-template name='IdCheck'/>
      <span class="definition-before">
	Definition <xsl:number level="any" count="cnx:definition"/>: 
      </span>
      <xsl:apply-templates />
    </div>
  </xsl:template>

  <!--TERM-->
  <xsl:template match="cnx:term">
    <span class="term">
      <xsl:call-template name='IdCheck'/>
      <xsl:choose>
	<xsl:when test="@src">
	  <a href="{@src}"><xsl:apply-templates /></a>
	</xsl:when>
	<xsl:otherwise>
	  <xsl:apply-templates />
	</xsl:otherwise>
      </xsl:choose>
    </span>
  </xsl:template>

  <!-- SEEALSO -->
  <xsl:template match="cnx:seealso">
    <div class="seealso">
      <span class="seealso-before">See Also: </span>
      <xsl:for-each select="cnx:term">
        <xsl:apply-templates select="."/>
      <xsl:if test="position()!=last()">, </xsl:if>
      </xsl:for-each>
    </div>
  </xsl:template>
  
  <!--CITE-->
  <xsl:template match="cnx:cite">
    <cite>
      <xsl:call-template name='IdCheck'/>
      <xsl:apply-templates/>
    </cite>
  </xsl:template>

  <xsl:template match="cnx:cite[@src]"> 
    <xsl:choose>
      <xsl:when test='count(child::node())>0'>
	<cite>
	  <a class="cite" href="{@src}">
	    <xsl:call-template name='IdCheck'/>
	    <xsl:apply-templates/>
	  </a>
	</cite>
      </xsl:when>
      <xsl:otherwise>
	<xsl:variable name='src' select="substring-after(@src, '#')"/>		
	<xsl:choose>
	  <xsl:when test="starts-with(@src, '#') and local-name(key('id',$src))='entry'">
	    <xsl:for-each select="key('id',$src)">
	      [<a class="cite" href="#{@id}"><xsl:number level="any" count="//bib:entry"/></a>]
	    </xsl:for-each>
	  </xsl:when>
	  <xsl:otherwise>
	    [<a class="cite" href="{@src}">cite</a>]
	  </xsl:otherwise>
	</xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!--MEANING-->
  <xsl:template match="cnx:meaning">
    <div class='meaning'>
      <xsl:call-template name='IdCheck'/>
      <xsl:if test="count(parent::cnx:definition/cnx:meaning) > 1"> 
      <span class="meaning-number"><xsl:number level="single"/>. </span>
      </xsl:if>
      <xsl:apply-templates/>
    </div>
  </xsl:template>

  <!-- RULE -->
  <xsl:template match="cnx:rule">
    <xsl:variable name="type" select="@type"/>
    <div class="rule">
      <xsl:call-template name='IdCheck'/>
      <span class="rule-before">
	<xsl:value-of select="@type"/><xsl:text> </xsl:text><xsl:number level="any" count="cnx:rule[@type=$type]" /><xsl:if test="cnx:name">: </xsl:if>
      </span>
      <span class="rule-name">
	<xsl:value-of select="cnx:name" /><xsl:text>&#160;</xsl:text>
      </span>
      <xsl:apply-templates select="*[not(self::cnx:name)]" />
    </div>
  </xsl:template>

  <!-- STATEMENT -->
  <xsl:template match="cnx:statement">
    <div class='statement'>
      <xsl:call-template name='IdCheck'/>
      <xsl:apply-templates/>
    </div>
  </xsl:template>

  <!--PROOF-->
  <xsl:template match="cnx:proof">
    <div class='proof'>
      <xsl:call-template name='IdCheck'/>
      <span class="proof-before">Proof<xsl:if test="cnx:name">: </xsl:if></span>
      <xsl:apply-templates/>
    </div>
  </xsl:template>
  
  <!--LIST-->
  <!-- Default list.  Prints a list of type='bulleted'. -->
  <xsl:template match="cnx:list">
    <ul class="list">
      <xsl:call-template name='IdCheck'/>
      <xsl:apply-templates select="cnx:name"/>
      <xsl:for-each select="cnx:item">
        <li>
          <xsl:call-template name='IdCheck'/>
          <xsl:apply-templates />
        </li>
      </xsl:for-each>
    </ul>
  </xsl:template>

  <!--LIST with type='enumerated'-->
  <!-- Numbered lists -->
  <xsl:template match="cnx:list[@type='enumerated']">
    <ol class="list">
      <xsl:call-template name='IdCheck'/>
      <xsl:apply-templates select="cnx:name"/>
      <xsl:for-each select="cnx:item">
        <li>
          <xsl:call-template name='IdCheck'/>
          <xsl:apply-templates/>
        </li>
      </xsl:for-each>
    </ol>
  </xsl:template>

  <!--LIST with type='inline' -->
  <xsl:template match="cnx:list[@type='inline']">
    <span class="list">
      <xsl:call-template name='IdCheck'/>
      <xsl:if test="cnx:name">
	<span class="name"><xsl:value-of select="cnx:name"/>: </span>
      </xsl:if>
      <xsl:for-each select="cnx:item">
	<span class="item">
	  <xsl:call-template name='IdCheck'/>
	  <xsl:apply-templates /><xsl:if test="position()!=last()">; </xsl:if>
	</span>
      </xsl:for-each>
    </span>
  </xsl:template>

  <!--NAMED LIST ITEM-->
  <xsl:template match="cnx:list[@type!='named-item']/cnx:item/cnx:name">
    <span class="name"><xsl:value-of select="."/><xsl:text> - </xsl:text></span>
  </xsl:template>

  <!--LIST with type='named-item' -->
  <xsl:template match="cnx:list[@type='named-item']">
    <table border="0" cellspacing="0" cellpadding="0" class="list">
      <xsl:call-template name='IdCheck'/>
      <xsl:if test="cnx:name">
        <tr>
          <td colspan="3">
            <xsl:apply-templates select="cnx:name"/>
          </td>
        </tr>
      </xsl:if>
      <xsl:for-each select="cnx:item">
        <tr>
          <td class="name" align="right" >
            <xsl:apply-templates select="cnx:name"/>
          </td>
	  <td class="bullet">
	    <xsl:text disable-output-escaping="yes">&#160;-&#160;</xsl:text>
	  </td>
          <td class="item">
            <xsl:call-template name='IdCheck'/>
            <xsl:apply-templates select="*[not(self::cnx:name)]|text()"/>
          </td>
        </tr>
      </xsl:for-each>
    </table>
  </xsl:template>

  <!-- EQUATION -->
  <xsl:template match="cnx:equation">
    <div class="equation">
      <xsl:call-template name='IdCheck'/> 
      <xsl:if test="@name">
	<span class="name">
	  <xsl:value-of select="@name"/>
	</span>
      </xsl:if>
      <xsl:apply-templates select="cnx:name"/>
      <xsl:apply-templates select="*[not(self::cnx:name)]|text()"/>
      <span class="equation-number">
	<xsl:number level="any" count="cnx:equation" format="(1)"/>
      </span>
    </div>
  </xsl:template>

  <!-- FIGURE -->
  <xsl:template match="cnx:figure">
    <table class="figure" border="0" cellpadding="0" cellspacing="0" align="center" width="50%">
      <xsl:call-template name='IdCheck'/> 
      <tr>
	<td>
	  <xsl:apply-templates select="cnx:name|cnx:title"/>
	  <div class="inner-figure">
	    <xsl:choose>
	      <xsl:when test="cnx:subfigure">
		<xsl:choose>
		  <xsl:when test="@orient='vertical'">
		    <xsl:apply-templates select="cnx:subfigure"/>
		  </xsl:when>
		  <xsl:otherwise>
		    <xsl:call-template name="horizontal" />
		  </xsl:otherwise>
		</xsl:choose>
	      </xsl:when>
	      <xsl:otherwise>
		<xsl:apply-templates select="*[not(self::cnx:caption|self::cnx:name)]"/>
	      </xsl:otherwise>
	    </xsl:choose>
	  </div>
	  <xsl:call-template name="caption"/>
	</td>
      </tr>
    </table>
  </xsl:template>
  
  <!-- SUBFIGURE vertical -->
  <xsl:template match="cnx:subfigure[../@orient='vertical']">
    <div class="subfigure">
      <xsl:call-template name='IdCheck'/>
      <xsl:apply-templates select="*[not(self::cnx:caption)]"/>
      <xsl:call-template name="caption"/>
    </div>
  </xsl:template>

  <!-- SUBFIGURE horizontal -->
  <xsl:template name="horizontal">
    <table class="subfigure" border="0" cellpadding="0" cellspacing="5" width="100%">
      <xsl:call-template name='IdCheck'/> 
      <tr>
	<xsl:for-each select="cnx:subfigure">
	  <td valign="bottom">
	    <xsl:apply-templates select="cnx:name"/>
	  </td>
	</xsl:for-each>
      </tr>
      <tr>
	<xsl:for-each select="cnx:subfigure">
	  <td valign="middle">
	    <xsl:apply-templates select="*[not(self::cnx:caption|self::cnx:name)]"/>
	  </td>
	</xsl:for-each>
      </tr>
      <tr>
	<xsl:for-each select="cnx:subfigure">
	  <td valign="top">
	    <xsl:call-template name="caption"/>
	  </td>
	</xsl:for-each> 
      </tr>
    </table>
  </xsl:template>

  <!-- CAPTION -->
  <xsl:template name="caption">
    <div class="caption">
      <xsl:call-template name='IdCheck'/>
      <span class="caption-before">
        <xsl:choose>
          <xsl:when test="self::cnx:subfigure">
            Subfigure <xsl:number level="any" count="cnx:figure" />.<xsl:number level="single" count="cnx:subfigure" /><xsl:if test="cnx:caption">: </xsl:if>
	  </xsl:when>
          <xsl:otherwise>
            Figure <xsl:number level="any" count="cnx:figure" /><xsl:if test="cnx:caption">: </xsl:if>
          </xsl:otherwise>
        </xsl:choose>
      </span>
      <xsl:apply-templates select="cnx:caption"/>
    </div>
  </xsl:template>
  <xsl:template match="cnx:caption">
    <xsl:apply-templates />
  </xsl:template>
  
  <!-- Squash PARAMs-->
  <xsl:template match="cnx:param" />

  <!-- MEDIA:RANDOM -->
  <xsl:template match="cnx:media">
    <object class="media">
      <xsl:call-template name='IdCheck'/>
      <xsl:for-each select="cnx:param">
	<xsl:attribute name='{@name}'>
	  <xsl:value-of select='@value'/>
	</xsl:attribute> 
      </xsl:for-each>
      <xsl:apply-templates/>
    </object>
  </xsl:template>

  <!-- MEDIA:IMAGE --> 
  <xsl:template match="cnx:media[starts-with(@type,'image')]|cnx:mediaobject[starts-with(@type,'image')]">
    <img src="{@src}">
      <xsl:call-template name='IdCheck'/>
      <xsl:for-each select="cnx:param">
	<xsl:attribute name='{@name}'>
	  <xsl:value-of select='@value'/>
	</xsl:attribute> 
      </xsl:for-each>
      <xsl:apply-templates />
    </img>
  </xsl:template>
  
  <!--  MEDIA:APPLET  -->
  <xsl:template match="cnx:media[@type='application/x-java-applet']">
    <applet code="{@src}">
      <xsl:call-template name='IdCheck'/>
      <xsl:for-each select="cnx:param">
	<xsl:attribute name='{@name}'>
	  <xsl:value-of select='@value'/>
	</xsl:attribute>
      </xsl:for-each>
      <xsl:apply-templates />
    </applet>
  </xsl:template>

  <!--Quicktime Movies -->
  <xsl:template match="cnx:media[@type='video/mov']">
    <object href='{@src}'>
      <xsl:call-template name='IdCheck'/>
      <xsl:for-each select="cnx:param[@name='classid' or @name='codebase']">
     	<xsl:attribute name='{@name}'>
	  <xsl:value-of select='@value'/>
	</xsl:attribute>
      </xsl:for-each>
     <xsl:for-each select="cnx:param[@name!='classid' and @name!='codebase']">
	<param name='{@name}' value="{@value}" />
     </xsl:for-each> 
      <embed src="{@src}">
	<xsl:for-each select="cnx:param">
	  <xsl:attribute name='{@name}'>
	    <xsl:value-of select='@value' />
	  </xsl:attribute>
	</xsl:for-each>
	<xsl:apply-templates />
      </embed>
    </object>
  </xsl:template>

  <!-- LABVIEW -->
  <xsl:template match="cnx:media[starts-with(@type,'application/x-labview')]">
    <div class="example labview">
      <span class="example-before">
        Labview Example:
      </span>
      <xsl:for-each select=".">
        <xsl:variable name="viinfo" select="cnx:param[@name='viinfo']/@value" />
        (<a class="cnxn" href="{$viinfo}">run</a>) (<a class="cnxn" href="{@src}">source</a>)
      </xsl:for-each>
    </div>
  </xsl:template>


  <!-- MP3 (Tony Brandt) -->
  <xsl:template match="cnx:media[@type='audio/mpeg']"> 
    <div class="example musical">
      <span class="example-before">
        Musical Example:
      </span>
      <a class="cnxn" href="{@src}">
        <xsl:call-template name="composer-title-comments" />
      </a>
    </div>       
  </xsl:template>


  <!-- COMPOSER, TITLE and COMMENTS template -->
  <xsl:template name="composer-title-comments">
    <xsl:if test="cnx:param[@name='composer']">
      <xsl:value-of select="cnx:param[@name='composer']/@value" />,<xsl:text> </xsl:text>
    </xsl:if>
    <xsl:if test="cnx:param[@name='title']">
      <i><xsl:value-of select="cnx:param[@name='title']/@value" /></i>, <xsl:text> </xsl:text>
    </xsl:if>
    <xsl:if test="cnx:param[@name='composer']">
      <xsl:value-of select="cnx:param[@name='comments']/@value" />
    </xsl:if>
  </xsl:template>

  <!--EXERCISE-->
  <!--Uses Javascript code at the top.-->
  <xsl:template match="cnx:exercise">
    <div class='exercise'>
      <xsl:call-template name='IdCheck'/>
      <xsl:apply-templates />
    </div>
  </xsl:template>

  <!-- PROBLEM -->
  <xsl:template match="cnx:problem">
    <div class="problem">
      <xsl:call-template name='IdCheck'/>
      <span class="problem-before">
	Problem <xsl:number level="any" count="cnx:exercise" /><xsl:if test="cnx:name">: </xsl:if>
      </span>
      <xsl:apply-templates />
    </div>
  </xsl:template>

  <!--SOLUTION -->
  <xsl:template match="cnx:solution">
    <div class="button" onclick="showSolution('{../@id}')">
      <span class="button-text">[ Click for Solution ]</span>
    </div>
    <div class="solution">
      <xsl:call-template name='IdCheck' />
      <span class="solution-before">
	Solution <xsl:number level="any" count="cnx:exercise"/><xsl:if test="cnx:name">: </xsl:if>
      </span>
      <xsl:apply-templates />
      <div class="button" onclick="hideSolution('{../@id}')">
        <span class="button-text">[ Hide Solution ]</span>
      </div>
    </div>
  </xsl:template>

</xsl:stylesheet>
