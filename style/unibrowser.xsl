<?xml version="1.0"?>

<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:cnx="http://cnx.rice.edu/cnxml"
  xmlns:m="http://www.w3.org/1998/Math/MathML"
  xmlns:md="http://cnx.rice.edu/mdml/0.4"
  xmlns="http://www.w3.org/1999/xhtml"
  xmlns:bib="http://bibtexml.sf.net/">

  <!-- Import identity transform first so it gets lowest priority -->
  <xsl:import href="ident.xsl" />

  <!-- MathML support -->
  <xsl:include href='http://cnx.rice.edu/technology/mathml/stylesheet/cnxmathmlc2p.xsl' />

  <!-- Bibtexml support -->
  <xsl:include href='http://cnx.rice.edu/technology/bibtexml/stylesheet/bibtexml.xsl'/>

  <!-- QML support -->
  <xsl:include href='http://cnx.rice.edu/technology/qml/stylesheet/qml.xsl'/>

  <!-- Include the CALS Table stylesheet -->
  <xsl:include href='table.xsl' />

  <xsl:param name="toc" select="0" />
  <xsl:param name="viewmath" select="0" />
  <xsl:param name="wrapper" select="1" />

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

  <xsl:template match="/">
    <xsl:choose>
      <!-- FAKE WRAPPER -->
      <xsl:when test="$wrapper">

	<html xmlns="http://www.w3.org/1999/xhtml">
	  <head>
	    <title><xsl:value-of select="cnx:document/cnx:name|cnx:module/cnx:name"/></title>
	    
	    <link rel="stylesheet" type="text/css" href="/cnx-styles/sky/ns4.css" />
	    <link rel="stylesheet" title="Sky" type="text/css" href="/cnx-styles/sky/document.css" />
	    <!-- The extra space is because some browsers don't like script as an empty tag -->
	    <script type="text/javascript" src="/js/exercise.js"><xsl:text> </xsl:text></script>
	    <script type="text/javascript" src="/js/qml_1-0.js"><xsl:text> </xsl:text></script>
	    <xsl:if test="$toc">
	      <script type="text/javascript" src="/js/toc.js" ><xsl:text> </xsl:text></script>
	    </xsl:if>

	    <xsl:comment>****QML**** sets the feedback and hints to non-visible.</xsl:comment>
	    <style type="text/css">
	      .feedback {display:none}
	      .hint {display:none}
	    </style>
	  </head>
	  
	  <body>
	    <xsl:comment>Editing In Place javascript</xsl:comment>
	    <div id="header">
	      <h1 id="name-box">
		<xsl:value-of select="cnx:document/cnx:name|cnx:module/cnx:name"/>
	      </h1>
	      <div id="about-links">&#160;</div>

	      <div id="abstract-objectives">
		<div id="abstract">
		  <span id="abstract-before">Summary: </span>
		  <xsl:value-of select="cnx:module/cnx:abstract|cnx:module/cnx:metadata/cnx:abstract|cnx:module/cnx:metadata/md:abstract|cnx:document/cnx:metadata/md:abstract"/>
		</div>
	      </div>

	    </div>
	    
	    <xsl:apply-templates select="cnx:document|cnx:module" />


	    <div id="footer">
	      <div id="credits">

		<div id="licensorlist">
		  <span id="licensorlist-before">Copyright: </span>
		  <xsl:for-each select="cnx:module/cnx:authorlist/cnx:author|cnx:module/cnx:metadata/cnx:authorlist/cnx:author|cnx:module/cnx:metadata/md:authorlist/md:author|cnx:document/cnx:metadata/md:authorlist/md:author">
		    <span class="cnx_author">
		      <span class="cnx_name">
			<xsl:choose>
			  <xsl:when test="@name">
			    <xsl:value-of select="@name"/>
			  </xsl:when>
			  <xsl:otherwise>
			    <xsl:value-of select="cnx:firstname|md:firstname"/>&#160;<xsl:value-of select="cnx:surname|md:surname"/>
			  </xsl:otherwise>
			</xsl:choose>
		      </span>
		      <xsl:choose>
			<xsl:when test="@email">
			  (<a class="cnx_email" href="mailto:{@email}"><xsl:value-of select="@email"/></a>)
			</xsl:when>
			<xsl:when test="cnx:email|md:email">
			  (<a class="cnx_email" href="mailto:{cnx:email|md:email}"><xsl:value-of select="cnx:email|md:email"/></a>)
			</xsl:when>
		      </xsl:choose>
		    </span>
		    <xsl:if test="position()!=last()">, </xsl:if>
		  </xsl:for-each>
		</div>

		<div id="authorlist">
		  <span id="authorlist-before">Written By: </span>
		  <xsl:for-each select="cnx:module/cnx:authorlist/cnx:author|cnx:module/cnx:metadata/cnx:authorlist/cnx:author|cnx:module/cnx:metadata/md:authorlist/md:author|cnx:document/cnx:metadata/md:authorlist/md:author">
		    <span class="cnx_author">
		      <span class="cnx_name">
			<xsl:choose>
			  <xsl:when test="@name">
			    <xsl:value-of select="@name"/>
			  </xsl:when>
			  <xsl:otherwise>
			    <xsl:value-of select="cnx:firstname|md:firstname"/>&#160;<xsl:value-of select="cnx:surname|md:surname"/>
			  </xsl:otherwise>
			</xsl:choose>
		      </span>
		      <xsl:choose>
			<xsl:when test="@email">
			  (<a class="cnx_email" href="mailto:{@email}"><xsl:value-of select="@email"/></a>)
			</xsl:when>
			<xsl:when test="cnx:email|md:email">
			  (<a class="cnx_email" href="mailto:{cnx:email|md:email}"><xsl:value-of select="cnx:email|md:email"/></a>)
			</xsl:when>
		      </xsl:choose>
		    </span>
		    <xsl:if test="position()!=last()">, </xsl:if>
		  </xsl:for-each>
		</div>

		<div id="maintainerlist">
		  <span id="maintainerlist-before">Maintained By: </span>
		  <xsl:for-each select="cnx:module/cnx:maintainerlist/cnx:maintainer|cnx:module/cnx:metadata/cnx:maintainerlist/cnx:maintainer|cnx:module/cnx:metadata/md:maintainerlist/md:maintainer|cnx:document/cnx:metadata/md:maintainerlist/md:maintainer">
		    <span class="cnx_maintainer">
		      <span class="cnx_name">
			<xsl:value-of select="cnx:firstname|md:firstname"/>&#160;<xsl:value-of select="cnx:surname|md:surname"/>
		      </span>
		      <xsl:if test="cnx:email|md:email">
			(<a class="cnx_email" href="mailto:{cnx:email|md:email}"><xsl:value-of select="cnx:email|md:email"/></a>)
		      </xsl:if>
		    </span>
		    <xsl:if test="position()!=last()">, </xsl:if>
		  </xsl:for-each>
		</div>

	      </div>
	    </div>
	  </body>
	</html>
      </xsl:when>
      <!-- END WRAPPER -->
      <xsl:otherwise>
	<xsl:apply-templates />
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <!-- Header and Body for the Document -->
  <xsl:template match="cnx:module|cnx:document">

    <div id="cnx_main">

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
        <a class="cnx_footnote-number" name="footnote{$footnote-number}"><xsl:text> </xsl:text></a>
        <div class="cnx_footnote">
	  <xsl:call-template name='IdCheck'/>
          <span class="cnx_footnote-number">
	    <xsl:number level="any" count="//cnx:note[@type='footnote']" format="1. " />
	  </span>
          <xsl:apply-templates />
        </div>
      </xsl:for-each>

      <!-- GLOSSARY -->
      <xsl:if test='cnx:glossary'>
	<div id='glossary'>
	  <span class='cnx_glossary'>Glossary</span>
	  <xsl:for-each select='cnx:glossary/cnx:definition'>
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
    <div class="cnx_toc" id="tableofcontents">
      <h2 id='toc'>Table of Contents</h2>
      <ul class="cnx_toc">
	<xsl:for-each select="cnx:section|cnx:content/cnx:section">
	  <li class = "toc">
	    <xsl:number level="single" count="cnx:section" format="1.  "/>
	    <a href='#{@id}'><xsl:value-of select="@name|cnx:name"/></a>
	    <ul class="cnx_toc">
	      <xsl:for-each select="cnx:section">
		<li class = "toc">
		  <xsl:number level="multiple" count="cnx:section" format="1.1  "/>
		  <a href='#{@id}'><xsl:value-of select="@name|cnx:name"/></a>
		  <ul class="cnx_toc">
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
    <div class="cnx_section">
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

  <xsl:template match="cnx:name[not(node())]|cnx:title[not(node())]|cnx:link[not(node())]|cnx:emphasis[not(node())]|cnx:important[not(node())]|cnx:quote[not(node())]|cnx:foreign[not(node())]|cnx:codeline[not(node())]|cnx:code[not(node())]|cnx:term[not(node())]|cnx:cite[not(node())]|cnx:meaning[not(node())]">
    <xsl:comment>empty <xsl:value-of select="local-name()" /> tag</xsl:comment>
  </xsl:template>

  <!--NAME-->
  <xsl:template match="cnx:name|cnx:title">
    <xsl:if test="parent::*[not(self::cnx:module|self::cnx:document)]">
      <span class="cnx_name">
	<xsl:call-template name='IdCheck'/>
	<xsl:apply-templates /><xsl:if test="parent::cnx:meaning"><xsl:text>: </xsl:text></xsl:if>
      </span>
    </xsl:if>
  </xsl:template>

  <!--PARA-->
  <xsl:template match="cnx:para">
    <div class="cnx_para">
      <xsl:call-template name='IdCheck'/>
      <xsl:apply-templates/>
      <xsl:if test="not(node())">
	<xsl:comment>empty para tag</xsl:comment>
      </xsl:if>
    </div>
  </xsl:template>

  <!-- LINK -->
  <xsl:template match="cnx:link">
    <a class="cnx_link" href="{@src}">
      <xsl:call-template name='IdCheck'/>
      <xsl:apply-templates />
    </a>
  </xsl:template>

  <!-- CNXN with target attribute only (no document) -->

  <!-- Since the target is in the same document, we know what the author
  is linking to.  If there is text provides, that text will serve as
  the link text. If not, we will provide it, including numbering.  -->
  <xsl:template match="cnx:cnxn[not(@document|@module)]">
    <a class="cnx_cnxn" href="#{@target}">
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
		<span class="cnx_cnxn-target">
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
	      <span class="cnx_cnxn-target">
		<xsl:value-of select="local-name(key('id',@target))" />
	      </span>
              <xsl:for-each select="key('id',@target)">
                <xsl:text> </xsl:text>
	        <xsl:choose>
		  <xsl:when test="self::cnx:subfigure">
		    <xsl:number level="any" count="//cnx:figure" />.<xsl:number level="single" count="cnx:subfigure" />
		  </xsl:when>
		  <xsl:when test="self::cnx:solution">
		    <xsl:number level="any" count="//cnx:exercise" />
		    <xsl:if test="count(parent::cnx:exercise/cnx:solution) > 1">
		      <xsl:text>.</xsl:text>
		      <xsl:number count="cnx:solution" />
		    </xsl:if>
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
    <a class="cnx_cnxn" href="/content/{@module|@document}/latest/">
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
    <a class="cnx_cnxn" href="/content/{@module|@document}/latest/#{@target}">
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
	    <span class="cnx_quote-source">[</span>
	    <a href="{@src}" class="cnx_quote-source">source</a>
	    <span class="cnx_quote-source">]</span>
	  </xsl:if>
	</blockquote>
      </xsl:when>
      <xsl:otherwise>
	<span class="cnx_quote">
	  <xsl:call-template name='IdCheck'/>
	  <xsl:apply-templates />
	</span>
	<xsl:if test="@src">
	  <span class="cnx_quote-source">[</span>
	  <a href="{@src}" class="cnx_quote-source">source</a>
	  <span class="cnx_quote-source">]</span>
	</xsl:if>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <!-- FOREIGN -->
  <xsl:template match="cnx:foreign">
    <span class="cnx_foreign">
      <xsl:call-template name='IdCheck'/>
      <xsl:apply-templates />
    </span>
  </xsl:template>

  <!-- CODE -->
  <xsl:template match="cnx:codeline|cnx:code">
    <code class="cnx_codeline">
      <xsl:call-template name='IdCheck'/>
      <xsl:apply-templates />
    </code>
  </xsl:template>
  <!--CODE.block (IE understands pre better than code.codeblock) -->
  <xsl:template match="cnx:codeblock|cnx:code[@type='block']">
    <pre class="cnx_code">
      <xsl:call-template name='IdCheck'/>
      <xsl:apply-templates />
      <xsl:if test="not(node())">
	<xsl:comment>empty code tag</xsl:comment>
      </xsl:if>
    </pre>  
  </xsl:template>

  <!-- FOOTNOTE -->
  <xsl:template match="cnx:note[@type='footnote']">
    <xsl:variable name="footnote-number">
      <xsl:number level="any" count="//cnx:note[@type='footnote']" format="1" />
    </xsl:variable>
    <span class="cnx_footnote-reference">
      <a class="cnx_footnote-reference" href="#footnote{$footnote-number}">
	<xsl:value-of select="$footnote-number" />
      </a><xsl:if test="following-sibling::node()[normalize-space()!=''][1][self::cnx:note and @type='footnote']">, </xsl:if>
    </span>
  </xsl:template>

  <!-- NOTE -->
  <xsl:template match="cnx:note[not(@type='footnote')]">
    <div class="cnx_note">
      <xsl:call-template name='IdCheck'/>
      <xsl:choose>
	<xsl:when test="(not(@type) or @type='')">
	  <span class="cnx_note">Note: </span>
	</xsl:when>
	<xsl:otherwise>
	  <span class="cnx_note"><xsl:value-of select="@type"/>: </span>
	</xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates/>
    </div>
  </xsl:template>
  
  <!--EXAMPLE-->
  <xsl:template match="cnx:example">
    <div class="cnx_example">
      <xsl:call-template name='IdCheck'/>
      <span class="cnx_example">
	Example<xsl:if test="not(parent::cnx:definition|parent::cnx:rule)">
	  <xsl:text> </xsl:text>
	  <xsl:number level="any" count="cnx:example[not(parent::cnx:definition|parent::cnx:rule)]"/>
	</xsl:if>
	<xsl:if test="cnx:name|ancestor::cnx:glossary">: </xsl:if>
      </span>
      <xsl:if test="not(ancestor::bib:file)">
	<span class="cnx_example-name">
	  <xsl:value-of select="cnx:name" /><xsl:text>&#160;</xsl:text>
	</span>
      </xsl:if>
      <xsl:if test="ancestor::bib:file">
	<span class="cnx_example-name">
	  <xsl:value-of select="cnx:name" />
	</span>
      </xsl:if>
      <xsl:apply-templates select="*[not(self::cnx:name)]" />
    </div>
  </xsl:template>

  <!--DEFINITION-->
  <xsl:template match="cnx:definition">
    <div class="cnx_definition">
      <xsl:call-template name='IdCheck'/>
      <span class="cnx_definition">
	Definition <xsl:number level="any" count="cnx:definition"/>: 
      </span>
      <xsl:apply-templates />
    </div>
  </xsl:template>

  <!--TERM-->
  <xsl:template match="cnx:term">
    <span class="cnx_term">
      <xsl:call-template name='IdCheck'/>
      <xsl:choose>
	<xsl:when test="@src">
	  <a href="{@src}"><xsl:apply-templates /></a>
	</xsl:when>
	<xsl:otherwise>
	  <xsl:apply-templates />
	</xsl:otherwise>
      </xsl:choose>
      <xsl:if test="ancestor::cnx:glossary and parent::cnx:definition">
	<xsl:text>: </xsl:text>
      </xsl:if>
    </span>
  </xsl:template>

  <!-- SEEALSO -->
  <xsl:template match="cnx:seealso">
    <div class="cnx_seealso">
      <span class="cnx_seealso">See Also: </span>
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
	  <a class="cnx_cite" href="{@src}">
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
	      [<a class="cnx_cite" href="#{@id}"><xsl:number level="any" count="//bib:entry"/></a>]
	    </xsl:for-each>
	  </xsl:when>
	  <xsl:otherwise>
	    [<a class="cnx_cite" href="{@src}">cite</a>]
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
      <span class="cnx_meaning-number"><xsl:number level="single"/>. </span>
      </xsl:if>
      <xsl:apply-templates/>
    </div>
  </xsl:template>

  <!-- RULE -->
  <xsl:template match="cnx:rule">
    <xsl:variable name="type" select="@type"/>
    <div class="cnx_rule">
      <xsl:call-template name='IdCheck'/>
      <span class="cnx_rule">
	<xsl:value-of select="@type"/><xsl:text> </xsl:text><xsl:number level="any" count="cnx:rule[@type=$type]" /><xsl:if test="cnx:name">: </xsl:if>
      </span>
      <span class="cnx_rule-name">
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
      <span class="cnx_proof">Proof<xsl:if test="cnx:name">: </xsl:if></span>
      <xsl:apply-templates/>
    </div>
  </xsl:template>
  
  <!--LIST-->
  <!-- Default list.  Prints a list of type='bulleted'. -->
  <xsl:template match="cnx:list">
    <ul class="cnx_list">
      <xsl:call-template name='IdCheck'/>
      <xsl:apply-templates select="cnx:name"/>
      <xsl:for-each select="cnx:item">
        <li class="cnx_item">
          <xsl:call-template name='IdCheck'/>
          <xsl:apply-templates />
        </li>
      </xsl:for-each>
    </ul>
  </xsl:template>

  <!--LIST with type='enumerated'-->
  <!-- Numbered lists -->
  <xsl:template match="cnx:list[@type='enumerated']">
    <ol class="cnx_list">
      <xsl:call-template name='IdCheck'/>
      <xsl:apply-templates select="cnx:name"/>
      <xsl:for-each select="cnx:item">
        <li class="cnx_item">
          <xsl:call-template name='IdCheck'/>
          <xsl:apply-templates/>
        </li>
      </xsl:for-each>
    </ol>
  </xsl:template>

  <!--LIST with type='inline' -->
  <xsl:template match="cnx:list[@type='inline']">
    <span class="cnx_list">
      <xsl:call-template name='IdCheck'/>
      <xsl:if test="cnx:name">
	<span class="cnx_name"><xsl:value-of select="cnx:name"/>: </span>
      </xsl:if>
      <xsl:for-each select="cnx:item[node()]">
	<span class="cnx_item">
	  <xsl:call-template name='IdCheck'/>
	  <xsl:apply-templates /><xsl:if test="position()!=last()">; </xsl:if>
	</span>
      </xsl:for-each>
      <xsl:for-each select="cnx:item[not(node())]">
	<xsl:comment>empty item tag</xsl:comment>
      </xsl:for-each>
    </span>
  </xsl:template>

  <!--NAMED LIST ITEM-->
  <xsl:template match="cnx:list[@type!='named-item']/cnx:item/cnx:name">
    <span class="cnx_name"><xsl:value-of select="."/><xsl:text> - </xsl:text></span>
  </xsl:template>

  <!--LIST with type='named-item' -->
  <xsl:template match="cnx:list[@type='named-item']">
    <table border="0" cellspacing="0" cellpadding="0" class="cnx_list">
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
          <td class="cnx_name" align="right" >
            <xsl:apply-templates select="cnx:name"/>
          </td>
	  <td class="cnx_bullet">
	    <xsl:text disable-output-escaping="yes">&#160;-&#160;</xsl:text>
	  </td>
          <td class="cnx_item">
            <xsl:call-template name='IdCheck'/>
            <xsl:apply-templates select="*[not(self::cnx:name)]|text()"/>
          </td>
        </tr>
      </xsl:for-each>
    </table>
  </xsl:template>

  <!-- EQUATION -->
  <xsl:template match="cnx:equation">
    <div class="cnx_equation">
      <xsl:call-template name='IdCheck'/> 
      <xsl:if test="@name">
	<span class="cnx_name">
	  <xsl:value-of select="@name"/>
	</span>
      </xsl:if>
      <xsl:apply-templates select="cnx:name"/>
      <xsl:apply-templates select="*[not(self::cnx:name)]|text()"/>
      <span class="cnx_equation-number">
	<xsl:number level="any" count="cnx:equation" format="(1)"/>
      </span>
    </div>
  </xsl:template>

  <!-- FIGURE -->
  <xsl:template match="cnx:figure">
    <table class="cnx_figure" border="0" cellpadding="0" cellspacing="0" align="center" width="50%">
      <xsl:call-template name='IdCheck'/> 
      <tr>
	<td>
	  <xsl:apply-templates select="cnx:name|cnx:title"/>
	  <div class="cnx_inner-figure">
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
    <div class="cnx_subfigure">
      <xsl:call-template name='IdCheck'/>
      <xsl:apply-templates select="*[not(self::cnx:caption)]"/>
      <xsl:call-template name="caption"/>
    </div>
  </xsl:template>

  <!-- SUBFIGURE horizontal -->
  <xsl:template name="horizontal">
    <table border="0" cellpadding="0" cellspacing="5" width="100%">
      <tr>
	<xsl:for-each select="cnx:subfigure">
	  <td valign="bottom">
	    <xsl:apply-templates select="cnx:name"/>
	  </td>
	</xsl:for-each>
      </tr>
      <tr>
	<xsl:for-each select="cnx:subfigure">
	  <td valign="middle" class="cnx_subfigure">
	    <xsl:call-template name='IdCheck'/>
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
    <div class="cnx_caption">
      <span class="cnx_caption">
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
    <div class="cnx_media">
      <xsl:call-template name='IdCheck'/>
      <object>
	<xsl:for-each select="cnx:param">
	  <xsl:attribute name='{@name}'>
	    <xsl:value-of select='@value'/>
	  </xsl:attribute> 
	</xsl:for-each>
	Media File:
	<a class="cnx_link" href="{@src}">
	  <xsl:choose>
	    <xsl:when test="cnx:param[@name='title' and normalize-space(@value) != '']">
	      <xsl:value-of select="cnx:param[@name='title']/@value" />
	    </xsl:when>
	    <xsl:otherwise>
	      <xsl:value-of select="@src" />
	    </xsl:otherwise>
	  </xsl:choose>
	</a>
	<xsl:apply-templates/>
      </object>
    </div>
  </xsl:template>

  <!-- MEDIA:IMAGE --> 
  <xsl:template match="cnx:media[starts-with(@type,'image')]|cnx:mediaobject[starts-with(@type,'image')]">
    <xsl:choose>
      <xsl:when test="child::cnx:param[@name='thumbnail']">
	<a href="{@src}" class="cnx_media">
	  <img src="{child::cnx:param[@name='thumbnail']/@value}">
	    <xsl:call-template name='IdCheck'/>
	    <xsl:for-each select="cnx:param">
	      <xsl:attribute name='{@name}'>
		<xsl:value-of select='@value'/>
	      </xsl:attribute> 
	    </xsl:for-each>
	  </img>
	</a>	    
      </xsl:when>
      <xsl:otherwise>
	<img src="{@src}" class="cnx_media">
	  <xsl:call-template name='IdCheck'/>
	  <xsl:for-each select="cnx:param">
	    <xsl:attribute name='{@name}'>
	      <xsl:value-of select='@value'/>
	    </xsl:attribute> 
	  </xsl:for-each>
	  <xsl:apply-templates select="media" />
	</img>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!--MEDIA:EPS Image -->
  <xsl:template match="cnx:media[starts-with(@type,'application/postscript')]">
    <xsl:choose>
      <xsl:when test="child::cnx:media">
	<xsl:apply-templates/>
      </xsl:when>
      <xsl:otherwise>
	<div class="cnx_media">
	  <xsl:call-template name='IdCheck'/>
	  <object>
	    <xsl:for-each select="cnx:param">
	      <xsl:attribute name='{@name}'>
		<xsl:value-of select='@value'/>
	      </xsl:attribute> 
	    </xsl:for-each>
	    EPS Image: 
	    <a class="cnx_link" href="{@src}">
	      <xsl:choose>
		<xsl:when test="cnx:param[@name='title' and normalize-space(@value) != '']">
		  <xsl:value-of select="cnx:param[@name='title']/@value" />
		</xsl:when>
		<xsl:otherwise>
		  <xsl:value-of select="@src" />
		</xsl:otherwise>
	      </xsl:choose>
	    </a>
	    <xsl:apply-templates/>
	  </object>
	</div>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!--  MEDIA:APPLET  -->
  <xsl:template match="cnx:media[@type='application/x-java-applet']">
    <applet code="{@src}" class="cnx_media">
      <xsl:call-template name='IdCheck'/>
      <xsl:for-each select="cnx:param">
	<xsl:attribute name='{@name}'>
	  <xsl:value-of select='@value'/>
	</xsl:attribute>
      </xsl:for-each>
      <xsl:apply-templates />
    </applet>
  </xsl:template>

  <!-- Video  -->
  <xsl:template match="cnx:media[starts-with(@type, 'video/')]">
    <object href='{@src}' class="cnx_media">
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
    <div class="cnx_media cnx_labview cnx_example">
      <span class="cnx_example">
        LabVIEW Example:
      </span>
      <xsl:for-each select=".">
        <xsl:variable name="viinfo" select="cnx:param[@name='viinfo']/@value" />
        (<a class="cnx_cnxn" href="{$viinfo}">run</a>) (<a class="cnx_cnxn" href="{@src}">source</a>)
      </xsl:for-each>
    </div>
  </xsl:template>

  <!-- LABVIEW -->        
  <xsl:template match="cnx:media[starts-with(@type,'application/x-labviewrp')]">
    <div class="cnx_media cnx_labview cnx_example">
      <object classid="CLSID:A40B0AD4-B50E-4E58-8A1D-8544233807AD"
              codebase="http://zone.ni.com/devzone/conceptd.nsf/webmain/7DBFD404C6AD0B24862570BB0072F83B/$FILE/CNX_LV8_RTE.exe">
        <xsl:if test="cnx:param[@name='width']">
          <xsl:attribute name="width"><xsl:value-of select="cnx:param[@name='width']/@value"/></xsl:attribute>
        </xsl:if>         
        <xsl:if test="cnx:param[@name='height']">
          <xsl:attribute name="height"><xsl:value-of select="cnx:param[@name='height']/@value"/></xsl:attribute>
        </xsl:if>
        <param name="SRC" value="{@src}" />
        <xsl:choose>
          <xsl:when test="cnx:param[@name='lvfppviname']">
            <param name="LVFPPVINAME" value="{cnx:param[@name='lvfppviname']/@value}" />
          </xsl:when>
          <xsl:otherwise>
            <param name="LVFPPVINAME" value="{@src}" />
          </xsl:otherwise>
        </xsl:choose>
        <param name="REQCTRL" value="false" />
        <param name="RUNLOCALLY" value="true" />
        <embed src="{@src}"
               reqctrl="true"
               runlocally="true"
               type="application/x-labviewrpvi80"
               pluginspage="http://digital.ni.com/express.nsf/bycode/exwgjq">   
          <xsl:attribute name="lvfppviname">
            <xsl:choose>
              <xsl:when test="cnx:param[@name='lvfppviname']"><xsl:value-of select="cnx:param[@name='lvfppviname']/@value" /></xsl:when>
              <xsl:otherwise><xsl:value-of select="@src" /></xsl:otherwise>
            </xsl:choose>
          </xsl:attribute>
          <xsl:if test="cnx:param[@name='width']">
            <xsl:attribute name="width"><xsl:value-of select="cnx:param[@name='width']/@value"/></xsl:attribute>
          </xsl:if>
          <xsl:if test="cnx:param[@name='height']">
            <xsl:attribute name="height"><xsl:value-of select="cnx:param[@name='height']/@value"/></xsl:attribute>
          </xsl:if>
        </embed>          
      </object>
      <p>Download <a class="cnxn" href="{@src}">LabVIEW source</a></p>
    </div>       
  </xsl:template>

  <!-- FLASH Objects -->
  <xsl:template match="cnx:media[@type='application/x-shockwave-flash']">
    <object type="application/x-shockwave-flash" data="{@src}" class="cnx_media">
      <xsl:call-template name='IdCheck'/>
      <xsl:if test="cnx:param[@name='width']">
	<xsl:attribute name="width">
	  <xsl:value-of select="cnx:param[@name='width']/@value"/>
	</xsl:attribute>
      </xsl:if>
      <xsl:if test="cnx:param[@name='height']">
	<xsl:attribute name="height">
	  <xsl:value-of select="cnx:param[@name='height']/@value"/>
	</xsl:attribute>
      </xsl:if>
      <param name="movie" value="{@src}"/>
      <xsl:if test="cnx:param[@name='base']">
	<param name="base">
	  <xsl:attribute name="value">
	    <xsl:value-of select="cnx:param[@name='base']/@value"/>
	  </xsl:attribute>
	</param>
      </xsl:if>
      <embed src="{@src}" type="application/x-shockwave-flash" pluginspace="http://www.macromedia.com/shockwave/download/index.cgi?P1_Prod_Version=ShockwaveFlash">
	<xsl:if test="cnx:param[@name='width']">
	  <xsl:attribute name="width">
	    <xsl:value-of select="cnx:param[@name='width']/@value"/>
	  </xsl:attribute>
	</xsl:if>
	<xsl:if test="cnx:param[@name='height']">
	  <xsl:attribute name="height">
	    <xsl:value-of select="cnx:param[@name='height']/@value"/>
	  </xsl:attribute>
	</xsl:if>
	<xsl:if test="cnx:param[@name='base']">
	  <xsl:attribute name="base">
	    <xsl:value-of select="cnx:param[@name='base']/@value"/>
	  </xsl:attribute>
	</xsl:if>
      </embed>
    </object>
  </xsl:template>

  <!-- Generic audio file -->
  <xsl:template match="cnx:media[starts-with(@type,'audio')]"> 
    <div class="cnx_media cnx_musical cnx_example">
      <span class="cnx_example">Audio File: </span>
      <a class="cnx_link" href="{@src}">
	<xsl:choose>
	  <xsl:when test="cnx:param[@name='title' and normalize-space(@value) != '']">
	    <i><xsl:value-of select="cnx:param[@name='title']/@value" /></i>
	  </xsl:when>
	  <xsl:otherwise>
	    <xsl:value-of select="@src" />
	  </xsl:otherwise>
	</xsl:choose>
      </a>
    </div>       
  </xsl:template>

  <!-- MP3 (Tony Brandt) -->
  <xsl:template match="cnx:media[@type='audio/mpeg']"> 
    <div class="cnx_media cnx_musical cnx_example">
      <span class="cnx_example">
        Musical Example:
      </span>
      <a class="cnx_cnxn" href="{@src}">
        <xsl:call-template name="composer-title-comments" />
      </a>
    </div>       
  </xsl:template>

  <!-- COMPOSER, TITLE and COMMENTS template -->
  <xsl:template name="composer-title-comments">
    <xsl:if test="cnx:param[@name='composer' and normalize-space(@value) != '']">
      <xsl:value-of select="cnx:param[@name='composer']/@value" />
      <xsl:text>, </xsl:text>
    </xsl:if>
    <xsl:choose>
      <xsl:when test="cnx:param[@name='title' and normalize-space(@value) != '']">
	<i><xsl:value-of select="cnx:param[@name='title']/@value" /></i>
      </xsl:when>
      <xsl:otherwise>
	<xsl:value-of select="@src" />
      </xsl:otherwise>
    </xsl:choose>
    <xsl:if test="cnx:param[@name='comments' and normalize-space(@value)!='']">
      <xsl:text>, </xsl:text>
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
    <div class="cnx_problem">
      <xsl:call-template name='IdCheck'/>
      <span class="cnx_problem">
	Problem <xsl:number level="any" count="cnx:exercise" /><xsl:if test="cnx:name">: </xsl:if>
      </span>
      <xsl:apply-templates />
    </div>
  </xsl:template>

  <!--SOLUTION -->
  <xsl:template match="cnx:solution">
    <xsl:variable name="solution-number">
      <xsl:number count="cnx:solution" />
    </xsl:variable>
    <xsl:variable name="full-number">
      <xsl:number level="any" count="cnx:exercise" />
      <xsl:if test="count(parent::cnx:exercise/cnx:solution) > 1">
	<xsl:text>.</xsl:text>
	<xsl:value-of select="$solution-number" />
      </xsl:if>
    </xsl:variable>
    <div class="cnx_button" onclick="showSolution('{../@id}',{$solution-number})">
      <span class="cnx_button-text">[ Click for Solution <xsl:value-of select="$full-number" /> ]</span>
    </div>
    <div class="cnx_solution">
      <xsl:call-template name='IdCheck' />
      <span class="cnx_solution">
	Solution <xsl:value-of select="$full-number" /><xsl:if test="cnx:name">: </xsl:if>
      </span>
      <xsl:apply-templates />
      <div class="cnx_button" onclick="hideSolution('{../@id}',{$solution-number})">
        <span class="cnx_button-text">[ Hide Solution <xsl:value-of select="$full-number" /> ]</span>
      </div>
    </div>
  </xsl:template>

</xsl:stylesheet>
