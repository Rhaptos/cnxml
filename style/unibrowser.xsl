<?xml version="1.0"?>

<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:cnx="http://cnx.rice.edu/cnxml"
  xmlns:m="http://www.w3.org/1998/Math/MathML"
  xmlns:md="http://cnx.rice.edu/mdml/0.4"
  xmlns="http://www.w3.org/1999/xhtml"
  xmlns:mod="http://cnx.rice.edu/#moduleIds"
  xmlns:bib="http://bibtexml.sf.net/">

  <!-- Import identity transform first so it gets lowest priority -->
  <xsl:import href="ident.xsl" />

  <!-- Include the Docbook translation support-->
  <xsl:import href='http://docbook.sourceforge.net/release/xsl/current/common/l10n.xsl' />

  <!-- Import our local translation keys -->
  <xsl:import href="cnxmll10n.xsl" />

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
  <xsl:param name="objectId" />
  <xsl:variable name="customstylesheet" select="/module/display/customstylesheet"/>
  <xsl:variable name="memcases" select="document('memcases.xml')/mod:modules"/>
  <xsl:variable name="case-diagnosis">
    <xsl:choose>
      <xsl:when test="$memcases/mod:module[@moduleId=$objectId] or
                      $customstylesheet = 'case_diagnosis'">1</xsl:when>
      <xsl:otherwise>0</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  <xsl:variable name="version">
    <xsl:value-of select="//cnx:document/@cnxml-version" />
  </xsl:variable>

  <xsl:output omit-xml-declaration="yes" indent="yes"/>

  <!--ID CHECK -->
  <xsl:template name='IdCheck'>
    <xsl:if test='@id'>
      <xsl:attribute name='id'>
	<xsl:value-of select='@id'/>
      </xsl:attribute>
    </xsl:if>
  </xsl:template>

  <!-- HOW MANY SECTION-LIKE ANCESTORS (for determining header levels) -->
  <xsl:template name="level-count">
    <xsl:variable name="level-number" 
                  select="count(ancestor::cnx:section|
                                ancestor::cnx:example[cnx:name or cnx:title or not(cnx:label[not(node())])]|
                                ancestor::cnx:rule[cnx:name or cnx:title or cnx:label[node()] or (@type!='' and not(cnx:label))]|
                                ancestor::cnx:proof[cnx:name or cnx:title or not(cnx:label[not(node())])]|
                                ancestor::cnx:exercise[cnx:name or cnx:title or not(cnx:label[not(node())])]|
                                ancestor::cnx:problem[cnx:name or cnx:title or cnx:label[node()]]|
                                ancestor::cnx:solution[cnx:name or cnx:title or not(cnx:label[not(node())])]|
                                ancestor::cnx:glossary|
                                ancestor::cnx:para[cnx:name or cnx:title]|
                                ancestor::cnx:note[not(@display='inline')][
                                                   cnx:title or cnx:label[node()] or ((@type!='' or not(@type)) and not(cnx:label))
                                                  ]|
                                ancestor::cnx:list[not(@type='inline' or @display='inline') and (cnx:name or cnx:title)])" />
    <xsl:choose>
      <xsl:when test="$level-number &lt; 4">
        <xsl:value-of select="$level-number + 2" />
      </xsl:when>
      <!-- There is no h7 element in HTML -->
      <xsl:otherwise>6</xsl:otherwise>
    </xsl:choose>
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
		    <span class="author">
		      <span class="name">
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
			  (<a class="email" href="mailto:{@email}"><xsl:value-of select="@email"/></a>)
			</xsl:when>
			<xsl:when test="cnx:email|md:email">
			  (<a class="email" href="mailto:{cnx:email|md:email}"><xsl:value-of select="cnx:email|md:email"/></a>)
			</xsl:when>
		      </xsl:choose>
		    </span>
		    <xsl:if test="position()!=last()">, </xsl:if>
		  </xsl:for-each>
		</div>

		<div id="authorlist">
		  <span id="authorlist-before">Written By: </span>
		  <xsl:for-each select="cnx:module/cnx:authorlist/cnx:author|cnx:module/cnx:metadata/cnx:authorlist/cnx:author|cnx:module/cnx:metadata/md:authorlist/md:author|cnx:document/cnx:metadata/md:authorlist/md:author">
		    <span class="author">
		      <span class="name">
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
			  (<a class="email" href="mailto:{@email}"><xsl:value-of select="@email"/></a>)
			</xsl:when>
			<xsl:when test="cnx:email|md:email">
			  (<a class="email" href="mailto:{cnx:email|md:email}"><xsl:value-of select="cnx:email|md:email"/></a>)
			</xsl:when>
		      </xsl:choose>
		    </span>
		    <xsl:if test="position()!=last()">, </xsl:if>
		  </xsl:for-each>
		</div>

		<div id="maintainerlist">
		  <span id="maintainerlist-before">Maintained By: </span>
		  <xsl:for-each select="cnx:module/cnx:maintainerlist/cnx:maintainer|cnx:module/cnx:metadata/cnx:maintainerlist/cnx:maintainer|cnx:module/cnx:metadata/md:maintainerlist/md:maintainer|cnx:document/cnx:metadata/md:maintainerlist/md:maintainer">
		    <span class="maintainer">
		      <span class="name">
			<xsl:value-of select="cnx:firstname|md:firstname"/>&#160;<xsl:value-of select="cnx:surname|md:surname"/>
		      </span>
		      <xsl:if test="cnx:email|md:email">
			(<a class="email" href="mailto:{cnx:email|md:email}"><xsl:value-of select="cnx:email|md:email"/></a>)
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
      <xsl:if test="descendant::cnx:note[@type='footnote'] or descendant::cnx:footnote">
        <div class="footnotes">
        <h2 class="footnotes-header">
          <!-- Footnotes -->
          <xsl:call-template name="gentext">
            <xsl:with-param name="key">Footnotes</xsl:with-param>
            <xsl:with-param name="lang"><xsl:value-of select="/module/metadata/language"/></xsl:with-param>
          </xsl:call-template>
        </h2>
        <ol id="footnotes">
          <xsl:for-each select="descendant::cnx:note[@type='footnote']|descendant::cnx:footnote">
            <xsl:variable name="footnote-number">
              <xsl:number level="any" count="//cnx:note[@type='footnote']|//cnx:footnote" format="1" />
            </xsl:variable>
            <li>
              <xsl:call-template name='IdCheck'/>
              <a name="footnote{$footnote-number}"><xsl:text> </xsl:text></a>
              <xsl:apply-templates />
            </li>
          </xsl:for-each>
        </ol>
        </div>
      </xsl:if>

      <!-- GLOSSARY -->
      <xsl:apply-templates select="cnx:glossary" />

      <!--BIBTEXML -->
      <xsl:if test='bib:file'>
	<xsl:apply-templates select='bib:file'/>
      </xsl:if>

   </div>

  </xsl:template>

  <!-- GLOSSARY -->
  <xsl:template match="cnx:glossary">
    <div class='glossary-container'>
      <xsl:call-template name='IdCheck'/>
      <h2 class='glossary-header'>
        <!--Glossary-->
        <xsl:call-template name="gentext">
          <xsl:with-param name="key">Glossary</xsl:with-param>
          <xsl:with-param name="lang"><xsl:value-of select="/module/metadata/language"/></xsl:with-param>
        </xsl:call-template>
      </h2>
      <xsl:apply-templates />
    </div>
  </xsl:template>


  <!-- TOC -->
  <xsl:template name="toc">
    <!-- Table of contents -->
    <div class="toc" id="tableofcontents">
      <h2 id='toc'>
        <xsl:call-template name="gentext">
	  <xsl:with-param name="key">TableofContents</xsl:with-param>
	  <xsl:with-param name="lang"><xsl:value-of select="/module/metadata/language"/></xsl:with-param>
	</xsl:call-template>
        <!--Table of Contents--></h2>
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
  <xsl:template match="cnx:metadata|cnx:authorlist|cnx:maintainerlist|cnx:keywordlist|cnx:abstract|cnx:objectives" />

  <!--SECTION-->
  <xsl:template match="cnx:section">
    <div class="section">
      <xsl:call-template name='IdCheck'/>
      <xsl:variable name="level-number">
        <xsl:call-template name="level-count" />
      </xsl:variable>
      <!-- h2, h3, etc... -->
      <xsl:element name="h{$level-number}">
        <xsl:attribute name="class">section-header</xsl:attribute>
	<xsl:if test="parent::cnx:problem or parent::cnx:solution">
	  <xsl:number level="any" count="cnx:exercise" format="1."/>
          <xsl:number level="single" format="a) " />
	</xsl:if>
        <!-- for cnxml version 0.1 -->
        <xsl:if test="@name">
          <strong>
            <xsl:value-of select="@name" />
            <xsl:if test="@name=''">
              <xsl:text> </xsl:text>
            </xsl:if>
          </strong>
        </xsl:if>
        <!-- for all other cnxml versions -->
	<xsl:apply-templates select="cnx:name|cnx:title"/>
        <xsl:if test="not(cnx:name|cnx:title)">
          <xsl:text> </xsl:text>
        </xsl:if>
      </xsl:element>
      <xsl:apply-templates select="*[not(self::cnx:name|self::cnx:title)]"/>
    </div>
  </xsl:template>

  <!--CONTENT-->
  <xsl:template match="cnx:content">
    <xsl:apply-templates />
  </xsl:template>

  <xsl:template match="cnx:name[not(node())]|cnx:title[not(node())]|cnx:link[not(node())]|cnx:emphasis[not(node())]|cnx:important[not(node())]|cnx:quote[not(node())]|cnx:foreign[not(node())]|cnx:codeline[not(node())]|cnx:code[not(node())]|cnx:term[not(node())]|cnx:cite[not(node())]|cnx:meaning[not(node())]">
    <xsl:comment>empty <xsl:value-of select="local-name()" /> tag</xsl:comment>
  </xsl:template>

  <!--NAME/TITLE -->
  <xsl:template match="cnx:name|cnx:title">
    <xsl:if test="not(parent::*[self::cnx:module|self::cnx:document])">
      <strong class="title">
	<xsl:call-template name='IdCheck'/>
	<xsl:apply-templates />
        <xsl:if test="parent::cnx:meaning or 
                      parent::cnx:item[parent::cnx:list[not(@type='named-item')]] or 
                      parent::cnx:list[@type='inline' or @display='inline']">
          <xsl:text>: </xsl:text>
        </xsl:if>
        <xsl:if test="parent::cnx:item[parent::cnx:list[@type='named-item']]">
          <xsl:choose>
            <xsl:when test="parent::cnx:list/processing-instruction('mark')[string-length(normalize-space(.)) &gt; 0]">
              <xsl:value-of select="parent::cnx:list/processing-instruction('mark')" />
            </xsl:when>
            <xsl:when test="parent::cnx:list/processing-instruction('mark')" />
            <xsl:otherwise>
              <xsl:text>:</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
          <xsl:text> </xsl:text>
        </xsl:if>
      </strong>
    </xsl:if>
  </xsl:template>

  <!--LABEL-->
  <xsl:template match="cnx:label">
    <xsl:apply-templates />
  </xsl:template>

  <xsl:template match="cnx:label[parent::cnx:item[parent::cnx:list[not(@list-type='labeled-item')]]][node()]">
    <strong class="cnx_label">
      <xsl:apply-templates />
      <xsl:text>: </xsl:text>
    </strong>
  </xsl:template>

  <!--PARA-->
  <xsl:template match="cnx:para">
    <xsl:if test="cnx:name[node()] or cnx:title[node()]">
      <xsl:variable name="level-number">
        <xsl:call-template name="level-count" />
      </xsl:variable>
      <!-- h2, h3, etc... -->
      <xsl:element name="h{$level-number}">
        <xsl:attribute name="class">para-header</xsl:attribute>
        <xsl:apply-templates select="cnx:name|cnx:title" />
      </xsl:element>
    </xsl:if>
    <p class="para">
      <xsl:call-template name='IdCheck'/>
      <xsl:apply-templates select="*[not(self::cnx:name|self::cnx:title)]|text()" />
      <xsl:if test="not(node())">
	<xsl:comment>empty para tag</xsl:comment>
      </xsl:if>
    </p>
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
	<xsl:attribute name="title">
          <xsl:call-template name="gentext">
            <xsl:with-param name="key">Strength</xsl:with-param>
            <xsl:with-param name="lang"><xsl:value-of select="/module/metadata/language"/></xsl:with-param>
          </xsl:call-template>
          <!--Strength--> <xsl:text> </xsl:text><xsl:value-of select="@strength" /></xsl:attribute>
      </xsl:if>
      <xsl:choose>
        <xsl:when test="node()">
	  <xsl:apply-templates />
        </xsl:when>
	<xsl:when test="key('id', @target)">
          <xsl:for-each select="key('id', @target)">
            <xsl:variable name="type">
              <xsl:value-of select="@type" />
            </xsl:variable>
            <!-- Build a label -->
            <span class="cnxn-target">
              <xsl:choose>
                <xsl:when test="self::cnx:note[@type!=''] or self::cnx:rule">
                  <xsl:value-of select="$type" />
                </xsl:when>
                <xsl:when test="self::cnx:exercise[ancestor::cnx:example]">
                  <!-- Problem -->
                  <xsl:call-template name="gentext">
                    <xsl:with-param name="key">Problem</xsl:with-param>
                    <xsl:with-param name="lang" select="/module/metadata/language" />
                  </xsl:call-template>
                </xsl:when>
                <xsl:when test="self::cnx:problem[not(parent::cnx:exercise[ancestor::cnx:example])]">
                  <!-- Exercise -->
                  <xsl:call-template name="gentext">
                    <xsl:with-param name="key">Exercise</xsl:with-param>
                    <xsl:with-param name="lang" select="/module/metadata/language" />
                  </xsl:call-template>
                </xsl:when>
                <xsl:otherwise>
                  <!--<xsl:value-of select="local-name(key('id',@target))" />-->
                  <xsl:call-template name="gentext">
                    <xsl:with-param name="key"><xsl:value-of select="local-name(.)" /></xsl:with-param>
                    <xsl:with-param name="lang" select="/module/metadata/language"/>
                  </xsl:call-template>
                </xsl:otherwise>
              </xsl:choose>
            </span>
            <xsl:text> </xsl:text>
            <!-- Build a number -->
            <xsl:choose>
              <xsl:when test="self::cnx:note[@type='note' or @type='' or not(@type)]">
                <xsl:number level="any" count="cnx:note[@type='note' or @type='' or not(@type)]" />
              </xsl:when>
              <xsl:when test="self::cnx:note">
                <xsl:number level="any" count="cnx:note[@type=$type]" />
              </xsl:when>
              <xsl:when test="self::cnx:rule">
                <xsl:number level="any" count="cnx:rule[@type=$type]" />
              </xsl:when>
              <xsl:when test="self::cnx:subfigure">
		<xsl:number level="any" count="cnx:figure" />.<xsl:number level="single" count="cnx:subfigure" />
              </xsl:when>
              <xsl:when test="self::cnx:solution or self::cnx:problem">
                <xsl:choose>
                  <xsl:when test="parent::cnx:exercise[ancestor::cnx:example]">
                    <xsl:number level="any" count="cnx:exercise" from="cnx:example" />
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:number level="any" count="cnx:exercise[not(ancestor::cnx:example)]" />
                  </xsl:otherwise>
                </xsl:choose>
                <xsl:if test="self::cnx:solution and count(parent::cnx:exercise/cnx:solution) > 1">
                  <xsl:text>.</xsl:text>
                  <xsl:number count="cnx:solution" />
                </xsl:if>
              </xsl:when>
              <xsl:when test="self::cnx:exercise">
                <xsl:choose>
                  <xsl:when test="ancestor::cnx:example">
                    <xsl:number level="any" count="cnx:exercise" from="cnx:example" />
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:number level="any" count="cnx:exercise[not(ancestor::cnx:example)]" />
                  </xsl:otherwise>
                </xsl:choose>
              </xsl:when>
              <xsl:otherwise>
		<xsl:number level="any" />
              </xsl:otherwise>
            </xsl:choose>
          </xsl:for-each>
        </xsl:when>
	<xsl:otherwise>
          <xsl:text>(</xsl:text>
          <!-- Reference -->
          <xsl:call-template name="gentext">
            <xsl:with-param name="key">Reference</xsl:with-param>
            <xsl:with-param name="lang" select="/module/metadata/language"/>
          </xsl:call-template>
          <xsl:text>)</xsl:text>
        </xsl:otherwise>
      </xsl:choose>
    </a>
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
	  <xsl:text>(</xsl:text>
          <!-- Reference -->
          <xsl:call-template name="gentext">
            <xsl:with-param name="key">Reference</xsl:with-param>
            <xsl:with-param name="lang" select="/module/metadata/language"/>
          </xsl:call-template>
          <xsl:text>)</xsl:text>
        </xsl:otherwise>
      </xsl:choose>
    </a>
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
	  <xsl:text>(</xsl:text>
          <!-- Reference -->
          <xsl:call-template name="gentext">
            <xsl:with-param name="key">Reference</xsl:with-param>
            <xsl:with-param name="lang" select="/module/metadata/language"/>
          </xsl:call-template>
          <xsl:text>)</xsl:text>
        </xsl:otherwise>
      </xsl:choose>
    </a>
  </xsl:template>

  <!--EMPHASIS-->
  <xsl:template match="cnx:emphasis">
    <em class="emphasis">
      <xsl:call-template name='IdCheck'/>
      <xsl:apply-templates/>
    </em>
  </xsl:template>

  <!--IMPORTANT-->
  <xsl:template match="cnx:important">
    <strong class="important">
      <xsl:call-template name='IdCheck'/>
      <xsl:apply-templates/>
    </strong>
  </xsl:template>

  <!-- QUOTE -->
  <xsl:template match="cnx:quote">
    <xsl:choose>
      <xsl:when test="@type='block'">
	<blockquote class="quote">
	  <xsl:call-template name="IdCheck"/>
          <xsl:if test="@src">
            <xsl:attribute name="cite">
              <xsl:value-of select="@src" />
            </xsl:attribute>
          </xsl:if>
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
    <pre class="code codeblock">
      <code>
        <xsl:call-template name='IdCheck'/>
        <xsl:apply-templates />
        <xsl:if test="not(node())">
          <xsl:comment>empty code tag</xsl:comment>
        </xsl:if>
      </code>
    </pre>
  </xsl:template>

  <!-- FOOTNOTE -->
  <xsl:template match="cnx:note[@type='footnote']|cnx:footnote">
    <xsl:variable name="footnote-number">
      <xsl:number level="any" count="//cnx:note[@type='footnote']|//cnx:footnote" format="1" />
    </xsl:variable>
    <a class="footnote-reference" href="#footnote{$footnote-number}">
      <xsl:value-of select="$footnote-number" />
    </a>
    <xsl:if test="following-sibling::node()[normalize-space()!=''][1][self::cnx:note[@type='footnote'] or self::cnx:footnote]">
      <xsl:text>, </xsl:text>
    </xsl:if>
  </xsl:template>

  <!-- NOTE -->
  <xsl:template match="cnx:note[not(@type='footnote')]">
    <div class="note">
      <xsl:call-template name='IdCheck'/>
      <xsl:if test="cnx:title or cnx:label[node()] or ((@type!='' or not(@type)) and not(cnx:label))">
        <xsl:variable name="level-number">
          <xsl:call-template name="level-count" />
        </xsl:variable>
        <!-- h2, h3, etc... -->
        <xsl:element name="h{$level-number}">
          <xsl:attribute name="class">note-header</xsl:attribute>
          <xsl:call-template name="note-label" />
        </xsl:element>
      </xsl:if>
      <xsl:apply-templates select="*[not(self::cnx:label|self::cnx:title)]|text()" />
    </div>
  </xsl:template>
  
  <!-- NOTE (inline) -->
  <xsl:template match="cnx:note[@display='inline']">
    <span class="note">
      <xsl:call-template name='IdCheck'/>
      <xsl:call-template name="note-label" />
      <xsl:apply-templates select="*[not(self::cnx:label|self::cnx:title)]|text()" />
    </span>
  </xsl:template>
  
  <!-- builds a label and puts a name in for inline and regular notes -->
  <xsl:template name="note-label">
    <xsl:if test="cnx:label[node()] or ((@type!='' or not(@type)) and not(cnx:label))">
      <span class="cnx_label">
        <xsl:choose>
          <xsl:when test="cnx:label">
            <xsl:apply-templates select="cnx:label" />
          </xsl:when>
          <xsl:when test="@type='warning' or @type='important' or @type='aside' or @type='tip'">
            <xsl:call-template name="gentext">
              <xsl:with-param name="key" select="@type" />
              <xsl:with-param name="lang" select="/module/metadata/language" />
            </xsl:call-template>
          </xsl:when>
          <xsl:when test="$version!='0.6' and @type">
            <xsl:value-of select="@type" />
          </xsl:when>
          <xsl:otherwise>
            <!-- Note -->
            <xsl:call-template name="gentext">
              <xsl:with-param name="key">Note</xsl:with-param>
              <xsl:with-param name="lang" select="/module/metadata/language" />
            </xsl:call-template>
          </xsl:otherwise>
        </xsl:choose>
        <xsl:text>: </xsl:text>
      </span>
    </xsl:if>
    <xsl:apply-templates select="cnx:title" />
  </xsl:template>

  <!--EXAMPLE-->
  <xsl:template match="cnx:example">
    <div class="example">
      <xsl:call-template name='IdCheck'/>
      <xsl:if test="cnx:name or cnx:title or not(cnx:label[not(node())])">
        <xsl:variable name="level-number">
          <xsl:call-template name="level-count" />
        </xsl:variable>
        <!-- h2, h3, etc... -->
        <xsl:element name="h{$level-number}">
          <xsl:attribute name="class">example-header</xsl:attribute>
          <xsl:if test="not(cnx:label[not(node())])">
            <span class="cnx_label">
              <xsl:choose>
                <xsl:when test="cnx:label">
                  <xsl:apply-templates select="cnx:label" />
                </xsl:when>
                <xsl:otherwise>
                  <!-- Example -->
                  <xsl:call-template name="gentext">
                    <xsl:with-param name="key">Example</xsl:with-param>
                    <xsl:with-param name="lang"><xsl:value-of select="/module/metadata/language"/></xsl:with-param>
                  </xsl:call-template>
                </xsl:otherwise>
              </xsl:choose>
              <xsl:if test="not(parent::cnx:definition|parent::cnx:rule)">
                <xsl:text> </xsl:text>
                <xsl:choose>
                  <xsl:when test="@type">
                    <xsl:variable name="type" select="@type" />
                    <xsl:number level="any" count="cnx:example[not(parent::cnx:definition|parent::cnx:rule)][@type=$type]" />
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:number level="any" count="cnx:example[not(parent::cnx:definition|parent::cnx:rule|@type)]" />
                  </xsl:otherwise>
                </xsl:choose>
              </xsl:if>
              <xsl:if test="cnx:name or cnx:title or ancestor::cnx:glossary">: </xsl:if>
            </span>
          </xsl:if>
          <xsl:apply-templates select="cnx:name|cnx:title" />
        </xsl:element>
      </xsl:if>
      <xsl:apply-templates select="*[not(self::cnx:name|self::cnx:title)]" />
    </div>
  </xsl:template>

  <!--DEFINITION-->
  <xsl:template match="cnx:definition">
    <dl>
      <xsl:attribute name="class">
        <xsl:choose>
          <xsl:when test="parent::cnx:glossary">definition glossary</xsl:when>
          <xsl:otherwise>definition</xsl:otherwise>
        </xsl:choose>
      </xsl:attribute>
      <xsl:call-template name='IdCheck'/>
      <dt>
        <xsl:if test="not(parent::cnx:glossary) and not(cnx:label[not(node())])">
          <span class="cnx_label">
            <xsl:choose>
              <xsl:when test="cnx:label">
                <xsl:apply-templates select="cnx:label" />
              </xsl:when>
              <xsl:otherwise>
                <!-- Definition -->
                <xsl:call-template name="gentext">
                  <xsl:with-param name="key">Definition</xsl:with-param>
                  <xsl:with-param name="lang" select="/module/metadata/language" />
                </xsl:call-template>
                <xsl:text> </xsl:text>
              </xsl:otherwise>
            </xsl:choose>
            <xsl:choose>
              <xsl:when test="@type">
                <xsl:variable name="type" select="@type" />
                <xsl:number level="any" count="cnx:definition[@type=$type]"/>
              </xsl:when>
              <xsl:otherwise>
                <xsl:number level="any" count="cnx:definition[not(@type)]" />
              </xsl:otherwise>
            </xsl:choose>
            <xsl:text>: </xsl:text>
          </span>
        </xsl:if>
        <xsl:apply-templates select="cnx:term" />
      </dt>
      <xsl:for-each select="cnx:meaning">
        <dd>
          <xsl:apply-templates select=".|../cnx:example[generate-id(preceding-sibling::cnx:meaning[1]) = generate-id(current())]" />
        </dd>
      </xsl:for-each>
      <xsl:apply-templates select="cnx:seealso" />
    </dl>
  </xsl:template>

  <!--TERM-->
  <xsl:template match="cnx:term">
    <xsl:choose>
      <xsl:when test="ancestor::cnx:document/cnx:glossary/cnx:definition[@id=substring(current()/@src,2)]">
        <span class="lensinfowrap">
          <dfn class="term">
            <xsl:call-template name='IdCheck'/>
            <a href="{@src}" class="hovlink" onmouseover="createDefinition(this)" onmouseout="removeDefinition(this)">
              <xsl:apply-templates />
            </a>
          </dfn>
        </span>
      </xsl:when>
      <xsl:when test="@src">
        <dfn class="term">
          <xsl:call-template name='IdCheck'/>
          <a href="{@src}"><xsl:apply-templates /></a>
          <xsl:if test="ancestor::cnx:glossary and parent::cnx:definition">
            <xsl:text>:</xsl:text>
          </xsl:if>
        </dfn>
      </xsl:when>
      <xsl:otherwise>
        <dfn class="term">
          <xsl:call-template name='IdCheck'/>
          <xsl:apply-templates />
          <xsl:if test="ancestor::cnx:glossary and parent::cnx:definition">
            <xsl:text>:</xsl:text>
          </xsl:if>
        </dfn>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- SEEALSO -->
  <xsl:template match="cnx:seealso">
    <dd class="seealso">
      <xsl:call-template name='IdCheck'/>
      <xsl:if test="not(cnx:label[not(node())])">
        <span class="cnx_label">
          <xsl:choose>
            <xsl:when test="cnx:label">
              <xsl:apply-templates select="cnx:label" />
            </xsl:when>
            <xsl:otherwise>
              <!-- See Also: -->
              <xsl:call-template name="gentext">
                <xsl:with-param name="key">GlossSeeAlso</xsl:with-param>
                <xsl:with-param name="lang" select="/module/metadata/language" />
              </xsl:call-template>
              <xsl:text>: </xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </span>
      </xsl:if>
      <xsl:for-each select="cnx:term">
        <xsl:apply-templates select="." />
        <xsl:if test="position()!=last()">, </xsl:if>
      </xsl:for-each>
    </dd>
  </xsl:template>
  
  <!--CITE-->
  <xsl:template match="cnx:cite">
    <cite class="cite">
      <xsl:call-template name='IdCheck'/>
      <xsl:apply-templates/>
    </cite>
  </xsl:template>

  <xsl:template match="cnx:cite[@src]"> 
    <xsl:choose>
      <xsl:when test='count(child::node())>0'>
	<cite class="cite">
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
        <span class="cnx_label">
          <xsl:number level="single"/>. 
        </span>
      </xsl:if>
      <xsl:apply-templates />
    </div>
  </xsl:template>

  <!-- RULE -->
  <xsl:template match="cnx:rule">
    <div class="rule">
      <xsl:call-template name='IdCheck'/>
      <xsl:if test="cnx:name or cnx:title or cnx:label[node()] or (@type!='' and not(cnx:label))">
        <xsl:variable name="level-number">
          <xsl:call-template name="level-count" />
        </xsl:variable>
        <!-- h2, h3, etc... -->
        <xsl:element name="h{$level-number}">
          <xsl:attribute name="class">rule-header</xsl:attribute>
          <xsl:if test="cnx:label[node()] or (@type!='' and not(cnx:label))">
            <span class="cnx_label">
              <xsl:choose>
                <xsl:when test="cnx:label">
                  <xsl:value-of select="cnx:label" />
                </xsl:when>
                <xsl:when test="@type='theorem' or @type='lemma' or @type='corollary' or @type='law' or @type='proposition'">
                  <xsl:call-template name="gentext">
                    <xsl:with-param name="key" select="@type" />
                    <xsl:with-param name="lang" select="/module/metadata/language" />
                  </xsl:call-template>
                </xsl:when>
                <xsl:when test="$version!='0.6'">
                  <xsl:value-of select="@type" />
                </xsl:when>
                <xsl:otherwise>
                  <!-- Rule -->
                  <xsl:call-template name="gentext">
                    <xsl:with-param name="key">Rule</xsl:with-param>
                    <xsl:with-param name="lang" select="/module/metadata/language" />
                  </xsl:call-template>
                </xsl:otherwise>
              </xsl:choose>
              <xsl:text> </xsl:text>
              <xsl:variable name="type" select="@type" />
              <xsl:number level="any" count="cnx:rule[@type=$type]" />
              <xsl:if test="cnx:name or cnx:title">
                <xsl:text>: </xsl:text>
              </xsl:if>
            </span>
          </xsl:if>
          <xsl:apply-templates select="cnx:name|cnx:title" />
        </xsl:element>
      </xsl:if>
      <xsl:apply-templates select="*[not(self::cnx:name|self::cnx:title|self::cnx:label)]" />
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
      <xsl:if test="cnx:name or cnx:title or not(cnx:label[not(node())])">
        <xsl:variable name="level-number">
          <xsl:call-template name="level-count" />
        </xsl:variable>
        <!-- h2, h3, etc... -->
        <xsl:element name="h{$level-number}">
          <xsl:attribute name="class">proof-header</xsl:attribute>
          <xsl:if test="not(cnx:label[not(node())])">
            <span class="cnx_label">
              <xsl:choose>
                <xsl:when test="cnx:label">
                  <xsl:value-of select="cnx:label" />
                </xsl:when>
                <xsl:otherwise>
                  <!--Proof-->
                  <xsl:call-template name="gentext">
                    <xsl:with-param name="key">Proof</xsl:with-param>
                    <xsl:with-param name="lang" select="/module/metadata/language" />
                  </xsl:call-template>
               </xsl:otherwise>
              </xsl:choose>
              <xsl:if test="cnx:name or cnx:title">: </xsl:if>
            </span>
          </xsl:if>
          <xsl:apply-templates select="cnx:name|cnx:title" />
        </xsl:element>
      </xsl:if>
      <xsl:apply-templates select="*[not(self::cnx:name|self::cnx:title|self::cnx:label)]" />
    </div>
  </xsl:template>

  <!--LIST (block)-->
  <xsl:template match="cnx:list[not(@display='inline')]">
    <div class="list">
      <xsl:call-template name='IdCheck'/>
      <xsl:if test="cnx:name[node()] or cnx:title[node()]">
        <xsl:variable name="level-number">
          <xsl:call-template name="level-count" />
        </xsl:variable>
        <!-- h2, h3, etc... -->
        <xsl:element name="h{$level-number}">
          <xsl:attribute name="class">list-header</xsl:attribute>
	  <xsl:apply-templates select="cnx:name|cnx:title" />
        </xsl:element>
      </xsl:if>
      <xsl:variable name="list-element">
        <xsl:choose>
          <xsl:when test="@list-type='enumerated' or @type='enumerated'">ol</xsl:when>
          <xsl:otherwise>ul</xsl:otherwise>
        </xsl:choose>
      </xsl:variable>
      <xsl:element name="{$list-element}">
        <xsl:attribute name="class">
          <xsl:choose>
            <xsl:when test="@list-type='labeled-item' or (@type='named-item' and $version!='0.6')">labeled-item</xsl:when>
            <xsl:when test="@before or @after or (@class='stepwise' and @list-type='enumerated')">other</xsl:when>
            <xsl:when test="@bullet-style='bullet' or (@list-type='bulleted' and not(@bullet-style)) or not(@list-type)">bullet</xsl:when>
            <xsl:when test="@bullet-style='open-circle'">open-circle</xsl:when>
            <xsl:when test="@number-style='arabic' or (@list-type='enumerated' and not(@number-style))">arabic</xsl:when>
            <xsl:when test="@number-style='upper-alpha'">upper-alpha</xsl:when>
            <xsl:when test="@number-style='lower-alpha'">lower-alpha</xsl:when>
            <xsl:when test="@number-style='upper-roman'">upper-roman</xsl:when>
            <xsl:when test="@number-style='lower-roman'">lower-roman</xsl:when>
            <xsl:otherwise>other</xsl:otherwise>
          </xsl:choose>
        </xsl:attribute>
        <xsl:for-each select="cnx:item">
          <li class="item">
            <xsl:call-template name='IdCheck'/>
            <xsl:if test="parent::cnx:list[@start-value] and position() = 1">
              <xsl:attribute name="value">
                <xsl:value-of select="parent::cnx:list/@start-value" />
              </xsl:attribute>
            </xsl:if>
            <xsl:if test="parent::cnx:list[@bullet-style!='bullet' or @bullet-style!='open-circle' or @list-type='labeled-item' or 
                                           @before or @after or (@class='stepwise' and @list-type='enumerated')]">
              <xsl:call-template name="item-decoration" />
            </xsl:if>
            <xsl:call-template name="item-contents" />
          </li>
        </xsl:for-each>
      </xsl:element>
    </div>
  </xsl:template>
  
  <!--LIST (inline)-->
  <xsl:template match="cnx:list[@type='inline' or @display='inline']">
    <xsl:text> </xsl:text>
    <span class="list">
      <xsl:call-template name='IdCheck'/>
      <xsl:apply-templates select="cnx:name|cnx:title" />
      <xsl:for-each select="cnx:item">
        <span class="item">
          <xsl:call-template name='IdCheck'/>
          <xsl:call-template name="item-decoration" />
          <xsl:call-template name="item-contents" />
        </span>
      </xsl:for-each>
    </span>
  </xsl:template>

  <!-- Puts in @before, @after, <label> (for labeled-item lists), plus adds bullet or numbering where this can't be done by the 
       browser due to the presence of @before, @after, or @display='inline' -->
  <xsl:template name="item-decoration">
    <xsl:variable name="item-decoration-element">
      <xsl:choose>
        <xsl:when test="parent::cnx:list[@list-type='labeled-item']">strong</xsl:when>
        <xsl:otherwise>span</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:element name="{$item-decoration-element}">
      <xsl:attribute name="class">item-decoration</xsl:attribute>
      <xsl:if test="parent::cnx:list[@class='stepwise' and @list-type='enumerated']">
        <!--Step-->
        <xsl:call-template name="gentext">
          <xsl:with-param name="key">Step</xsl:with-param>
          <xsl:with-param name="lang" select="/module/metadata/language" />
        </xsl:call-template>
        <xsl:text> </xsl:text>
      </xsl:if>
      <xsl:if test="not(parent::list[@list-type='labeled-item'] and not(cnx:label[node()]))">
        <xsl:value-of select="parent::cnx:list[@before]" />
      </xsl:if>
      <xsl:if test="parent::cnx:list[@list-type='bulleted']">
        <xsl:choose>
          <xsl:when test="parent::cnx:list[@bulleted-style='bullet' or not(@bulleted-style)]">&#149;</xsl:when>
          <xsl:when test="parent::cnx:list[@bulleted-style='open-circle']">&#9675;</xsl:when>
          <xsl:when test="parent::cnx:list[@bulleted-style='pilcrow']">&#182;</xsl:when>
          <xsl:when test="parent::cnx:list[@bulleted-style='rpilcrow']">&#8267;</xsl:when>
          <xsl:when test="parent::cnx:list[@bulleted-style='asterisk']">*</xsl:when>
          <xsl:when test="parent::cnx:list[@bulleted-style='dash']">&#150;</xsl:when>
          <xsl:when test="parent::cnx:list[@bulleted-style='section']">&#167;</xsl:when>
          <xsl:when test="parent::cnx:list[@bulleted-style='none']" />
          <xsl:otherwise><xsl:value-of select="parent::cnx:list[@bulleted-style]" /></xsl:otherwise>
        </xsl:choose>
      </xsl:if>
      <xsl:if test="parent::cnx:list[@list-type='enumerated']">
        <xsl:variable name="start-value">
          <xsl:choose>
            <xsl:when test="parent::cnx:list[@start-value]">
              <xsl:value-of select="parent::cnx:list/@start-value" />
            </xsl:when>
            <xsl:otherwise>1</xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:choose>
          <xsl:when test="parent::cnx:list[@number-style='upper-alpha']">
            <xsl:number format="A" value="position() + $start-value - 1" />
          </xsl:when>
          <xsl:when test="parent::cnx:list[@number-style='lower-alpha']">
            <xsl:number format="a" value="position() + $start-value - 1" />
          </xsl:when>
          <xsl:when test="parent::cnx:list[@number-style='upper-roman']">
            <xsl:number format="I" value="position() + $start-value - 1" />
          </xsl:when>
          <xsl:when test="parent::cnx:list[@number-style='lower-roman']">
            <xsl:number format="i" value="position() + $start-value - 1" />
          </xsl:when>
          <xsl:otherwise>
            <xsl:number format="1" value="position() + $start-value - 1" />
          </xsl:otherwise>
        </xsl:choose>
      </xsl:if>
      <xsl:if test="parent::cnx:list[@list-type='labeled-item']">
        <xsl:apply-templates select="cnx:label" />
        <xsl:if test="not(cnx:label) or cnx:label[not(node())]">
          <xsl:comment>empty label</xsl:comment>
        </xsl:if>
      </xsl:if>
      <xsl:choose>
        <xsl:when test="parent::cnx:list[@list-type='labeled-item'] and not(cnx:label[node()])" />
        <xsl:when test="parent::cnx:list[@after]">
          <xsl:value-of select="parent::cnx:list/@after" />
          <xsl:text> </xsl:text>
        </xsl:when>
        <xsl:when test="parent::cnx:list[@list-type='enumerated' or @list-type='bulleted']">
          <xsl:text>. </xsl:text>
        </xsl:when>
        <xsl:when test="parent::cnx:list[@list-type='labeled-item']">
          <xsl:text>: </xsl:text>
        </xsl:when>
      </xsl:choose>
    </xsl:element>
  </xsl:template>

  <!-- After creating the decoration and putting in the labels for labeled-item lists -->
  <xsl:template name="item-contents">
    <xsl:choose>
      <xsl:when test="parent::cnx:list[@list-type='labeled-item']">
        <xsl:apply-templates select="*[not(self::cnx:label)]|text()" />
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-templates />
      </xsl:otherwise>
    </xsl:choose>
    <xsl:if test="position()!=last()">
      <xsl:choose>
        <xsl:when test="parent::cnx:list[@item-sep]">
          <xsl:value-of select="parent::cnx:list/@item-sep" />
        </xsl:when>
        <xsl:when test="parent::cnx:list[@type='inline' or @display='inline']">
          <xsl:text>;</xsl:text>
        </xsl:when>
      </xsl:choose>
      <xsl:text> </xsl:text>
    </xsl:if>
  </xsl:template>


  <!-- EQUATION -->
  <xsl:template match="cnx:equation">
    <div class="equation">
      <xsl:call-template name='IdCheck'/> 
      <xsl:if test="cnx:name[node()] or cnx:title[node()] or @name or cnx:label[node()]">
        <xsl:variable name="level-number">
          <xsl:call-template name="level-count" />
        </xsl:variable>
        <!-- h2, h3, etc... -->
        <xsl:element name="h{$level-number}">
          <xsl:attribute name="class">equation-header</xsl:attribute>
          <xsl:if test="cnx:label[node()]">
            <span class="cnx_label">
              <xsl:apply-templates select="cnx:label" />
              <xsl:if test="cnx:title">
                <xsl:text>: </xsl:text>
              </xsl:if>
            </span>
          </xsl:if>
          <!-- for cnxml version 0.1 -->
	  <xsl:value-of select="@name"/>
          <!-- all other cnxml versions -->
          <xsl:apply-templates select="cnx:name|cnx:title"/>
        </xsl:element>
      </xsl:if>
      <xsl:apply-templates select="*[not(self::cnx:name|self::cnx:title|self::cnx:label)]|text()"/>
      <xsl:choose>
        <xsl:when test="cnx:label[not(node())]" />
        <xsl:otherwise>
          <span class="equation-number">
            <xsl:choose>
              <xsl:when test="@type">
                <xsl:variable name="type" select="@type" />
                <xsl:number level="any" count="cnx:equation[@type=$type]" format="(1)" />
              </xsl:when>
              <xsl:otherwise>
                <xsl:number level="any" count="cnx:equation[not(@type)]" format="(1)" />
              </xsl:otherwise>
            </xsl:choose>
          </span>
        </xsl:otherwise>
      </xsl:choose>
    </div>
  </xsl:template>

  <!-- FIGURE -->
  <xsl:template match="cnx:figure">
    <div class="figure">
      <xsl:call-template name='IdCheck'/>
      <table border="0" cellpadding="0" cellspacing="0" align="center" width="50%">
        <xsl:call-template name="caption"/>
        <xsl:if test="cnx:name[node()] or cnx:title[node()] or @name">
          <thead>
            <tr>
              <th class="figure-name">
                <xsl:value-of select="@name" />
                <xsl:apply-templates select="cnx:name|cnx:title" />
              </th>
            </tr>
          </thead>
        </xsl:if>
        <tbody>
          <tr>
            <td class="inner-figure">
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
                  <xsl:apply-templates select="*[not(self::cnx:caption|self::cnx:name|self::cnx:title)]"/>
                </xsl:otherwise>
              </xsl:choose>
	    </td>
          </tr>
        </tbody>
      </table>
    </div>
  </xsl:template>
  
  <!-- SUBFIGURE vertical -->
  <xsl:template match="cnx:subfigure[parent::cnx:figure[@orient='vertical']]">
    <table border="0" cellpadding="0" cellspacing="0" align="center" class="vertical-subfigure">
      <xsl:call-template name='IdCheck'/>
      <xsl:if test="cnx:name or cnx:title">
        <thead>
          <tr>
            <th class="vertical-subfigure-name">
              <xsl:apply-templates select="cnx:name|cnx:title"/>
            </th>
          </tr>
        </thead>
      </xsl:if>
      <tfoot>
        <tr>
          <xsl:call-template name="caption" />
        </tr>
      </tfoot>
      <tbody>
        <tr>
          <td class="inner-vertical-subfigure">
            <xsl:apply-templates select="*[not(self::cnx:caption|self::cnx:name|self::cnx:title)]"/>
	  </td>
        </tr>
      </tbody>
    </table>
  </xsl:template>

  <!-- SUBFIGURE horizontal -->
  <xsl:template name="horizontal">
    <table border="0" cellpadding="0" cellspacing="0" class="horizontal-subfigure">
      <xsl:if test="cnx:subfigure/cnx:name or cnx:subfigure/cnx:title">
        <thead valign="bottom">
          <tr>
            <xsl:for-each select="cnx:subfigure">
              <th class="horizontal-subfigure-name">
                <xsl:apply-templates select="cnx:name|cnx:title"/>
              </th>
            </xsl:for-each>
          </tr>
        </thead>
      </xsl:if>
      <tfoot>
        <tr>
          <xsl:for-each select="cnx:subfigure">
            <xsl:call-template name="caption"/>
          </xsl:for-each>
        </tr>
      </tfoot>
      <tbody>
        <tr>
          <xsl:for-each select="cnx:subfigure">
            <td class="inner-horizontal-subfigure">
              <xsl:call-template name='IdCheck'/>
              <xsl:apply-templates select="*[not(self::cnx:caption|self::cnx:name|self::cnx:title)]"/>
            </td>
          </xsl:for-each>
        </tr>
      </tbody>
    </table>
  </xsl:template>

  <!-- CAPTION -->
  <xsl:template name="caption">
    <xsl:variable name="captionelement">
      <xsl:choose>
        <xsl:when test="parent::cnx:figure">th</xsl:when>
        <xsl:otherwise>caption</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:element name="{$captionelement}">
      <xsl:if test='cnx:caption[@id]'>
        <xsl:attribute name='id'>
          <xsl:value-of select='cnx:caption/@id'/>
        </xsl:attribute>
      </xsl:if>
      <xsl:attribute name="class">
        <xsl:choose>
          <xsl:when test="parent::cnx:figure[@orient='vertical']">vertical-subfigure-caption</xsl:when>
          <xsl:when test="parent::cnx:figure">horizontal-subfigure-caption</xsl:when>
          <xsl:otherwise>figure-caption</xsl:otherwise>
        </xsl:choose>
      </xsl:attribute>
      <xsl:if test="$captionelement='caption'">
        <xsl:attribute name="align">bottom</xsl:attribute>
      </xsl:if>
      <strong class="cnx_label">
        <xsl:choose>
          <xsl:when test="self::cnx:subfigure">
            <xsl:call-template name="gentext">
              <xsl:with-param name="key">Subfigure</xsl:with-param>
              <xsl:with-param name="lang"><xsl:value-of select="/module/metadata/language"/></xsl:with-param>
            </xsl:call-template>
            <xsl:text>&#160;</xsl:text>
            <!--Subfigure--> <xsl:number level="any" count="cnx:figure" />.<xsl:number level="single" count="cnx:subfigure" /><xsl:if test="cnx:caption">: </xsl:if>
	  </xsl:when>
          <xsl:otherwise>
            <xsl:call-template name="gentext">
              <xsl:with-param name="key">Figure</xsl:with-param>
              <xsl:with-param name="lang">
                <xsl:value-of select="/module/metadata/language"/>
              </xsl:with-param>
            </xsl:call-template>
            <xsl:text>&#160;</xsl:text>
            <!--Figure--> <xsl:number level="any" count="cnx:figure" /><xsl:if test="cnx:caption">: </xsl:if>
          </xsl:otherwise>
        </xsl:choose>
      </strong>
      <xsl:apply-templates select="cnx:caption"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="cnx:caption">
    <xsl:apply-templates />
  </xsl:template>
  
  <!-- Squash PARAMs-->
  <xsl:template match="cnx:param" />

  <!-- MEDIA:RANDOM -->
  <xsl:template match="cnx:media">
    <div class="media">
      <xsl:call-template name='IdCheck'/>
      <object>
 	<xsl:for-each select="cnx:param">
	  <xsl:attribute name='{@name}'>
	    <xsl:value-of select='@value'/>
	  </xsl:attribute> 
	</xsl:for-each>
        <xsl:call-template name="gentext">
          <xsl:with-param name="key">MediaFile</xsl:with-param>
          <xsl:with-param name="lang"><xsl:value-of select="/module/metadata/language"/></xsl:with-param>
        </xsl:call-template>:
	<!--Media File:-->
	<a class="link" href="{@src}">
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
    <span class="media">
    <xsl:choose>
      <xsl:when test="child::cnx:param[@name='thumbnail']">
	<a href="{@src}">
	  <img src="{child::cnx:param[@name='thumbnail']/@value}">
	    <xsl:call-template name='IdCheck'/>
	    <xsl:for-each select="cnx:param[@name != 'thumbnail']">
	      <xsl:attribute name='{@name}'>
		<xsl:value-of select='@value'/>
	      </xsl:attribute> 
	    </xsl:for-each>
            <xsl:call-template name="altgenerator" />
	  </img>
	</a>	    
      </xsl:when>
      <xsl:otherwise>
	<img src="{@src}">
	  <xsl:call-template name='IdCheck'/>
	  <xsl:for-each select="cnx:param">
	    <xsl:attribute name='{@name}'>
	      <xsl:value-of select='@value'/>
	    </xsl:attribute> 
	  </xsl:for-each>
          <xsl:call-template name="altgenerator" />
	  <xsl:apply-templates select="media" />
	</img>
      </xsl:otherwise>
    </xsl:choose>
    </span>
  </xsl:template>

  <!-- Alt generator (if that param is absent) -->
  <xsl:template name="altgenerator">
    <xsl:if test="not(cnx:param[@name='alt'])">
      <xsl:attribute name="alt">
        <xsl:choose>
          <xsl:when test="parent::cnx:figure">
            <xsl:choose>
              <xsl:when test="parent::cnx:figure/*[self::cnx:name or self::cnx:title]">
                <xsl:value-of select="parent::cnx:figure/*[self::cnx:name or self::cnx:title]" />
              </xsl:when>
              <xsl:otherwise>
                <!--Figure--> 
                <xsl:call-template name="gentext">
                  <xsl:with-param name="key">Figure</xsl:with-param>
                    <xsl:with-param name="lang">
                      <xsl:value-of select="/module/metadata/language"/>
                    </xsl:with-param>
                  </xsl:call-template>
                <xsl:text> </xsl:text>
                <xsl:number level="any" count="cnx:figure" />
              </xsl:otherwise>
            </xsl:choose>
            <xsl:text> (</xsl:text>
            <xsl:value-of select="@src" />
            <xsl:text>)</xsl:text>
          </xsl:when>
          <xsl:when test="parent::cnx:subfigure">
            <xsl:choose>
              <xsl:when test="parent::cnx:subfigure/*[self::cnx:name or self::cnx:title]">
                <xsl:value-of select="parent::cnx:subfigure/*[self::cnx:name or self::cnx:title]" />
              </xsl:when>
              <xsl:otherwise>
                <xsl:if test="ancestor::cnx:figure[1]/*[self::cnx:name or self::cnx:title]">
                  <xsl:value-of select="ancestor::cnx:figure[1]/*[self::cnx:name or self::cnx:title]" />
                  <xsl:text>, </xsl:text>
                </xsl:if>
                <!--Subfigure--> 
                <xsl:call-template name="gentext">
                  <xsl:with-param name="key">Subfigure</xsl:with-param>
                    <xsl:with-param name="lang">
                      <xsl:value-of select="/module/metadata/language"/>
                    </xsl:with-param>
                  </xsl:call-template>
                <xsl:text> </xsl:text>
		<xsl:number level="any" count="//cnx:figure" />.<xsl:number level="single" count="cnx:subfigure" />
              </xsl:otherwise>
            </xsl:choose>
            <xsl:text> (</xsl:text>
            <xsl:value-of select="@src" />
            <xsl:text>)</xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="@src" />
          </xsl:otherwise>
        </xsl:choose>
      </xsl:attribute>
    </xsl:if>
  </xsl:template>

  <!--MEDIA:EPS Image -->
  <xsl:template match="cnx:media[starts-with(@type,'application/postscript')]">
    <xsl:choose>
      <xsl:when test="child::cnx:media">
	<xsl:apply-templates/>
      </xsl:when>
      <xsl:otherwise>
	<div class="media">
	  <xsl:call-template name='IdCheck'/>
	  <object>
	    <xsl:for-each select="cnx:param">
	      <xsl:attribute name='{@name}'>
		<xsl:value-of select='@value'/>
	      </xsl:attribute> 
	    </xsl:for-each>
            <xsl:call-template name="gentext">
              <xsl:with-param name="key">EPSImage</xsl:with-param>
              <xsl:with-param name="lang"><xsl:value-of select="/module/metadata/language"/></xsl:with-param>
            </xsl:call-template>:
	    <!--EPS Image:--> 
	    <a class="link" href="{@src}">
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
    <span class="media">
    <applet code="{@src}">
      <xsl:call-template name='IdCheck'/>
      <xsl:for-each select="cnx:param">
	<xsl:attribute name='{@name}'>
	  <xsl:value-of select='@value'/>
	</xsl:attribute>
      </xsl:for-each>
      <xsl:apply-templates />
    </applet>
    </span>
  </xsl:template>

  <!-- Video  -->
  <xsl:template match="cnx:media[starts-with(@type, 'video/')]">
    <span class="media">
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
    </span>
  </xsl:template>

  <!-- LABVIEW -->
  <xsl:template match="cnx:media[starts-with(@type,'application/x-labview')]">
    <div class="media labview example">
      <xsl:call-template name='IdCheck'/>
      <span class="cnx_label">
        <xsl:call-template name="gentext">
          <xsl:with-param name="key">LabVIEWExample</xsl:with-param>
          <xsl:with-param name="lang"><xsl:value-of select="/module/metadata/language"/></xsl:with-param>
        </xsl:call-template>:
        <xsl:text> </xsl:text>
        <!--LabVIEW Example:-->
      </span>
      <xsl:for-each select=".">
        <xsl:variable name="viinfo" select="cnx:param[@name='viinfo']/@value" />
        (<a class="cnxn" href="{$viinfo}">run</a>) (<a class="cnxn" href="{@src}">source</a>)
      </xsl:for-each>
    </div>
  </xsl:template>

  <!-- LABVIEW 8.X -->
  <xsl:template match="cnx:media[starts-with(@type,'application/x-labviewrp')]">
    <xsl:param name="lv-version" select="substring-after(@type, 'application/x-labviewrp')"/>
    <xsl:param name="classid">
      <xsl:choose>
        <xsl:when test="$lv-version = 'vi80'">CLSID:A40B0AD4-B50E-4E58-8A1D-8544233807AD</xsl:when>
        <xsl:when test="$lv-version = 'vi82'">CLSID:A40B0AD4-B50E-4E58-8A1D-8544233807AE</xsl:when>
      </xsl:choose>
    </xsl:param>
    <xsl:param name="codebase">
      <xsl:choose>
        <xsl:when test="$lv-version = 'vi80'">ftp://ftp.ni.com/pub/devzone/tut/cnx_lv8_runtime.exe</xsl:when>
        <xsl:when test="$lv-version = 'vi82'">ftp://ftp.ni.com/support/labview/runtime/windows/8.2/LVRunTimeEng.exe</xsl:when>
      </xsl:choose>
    </xsl:param>
    <xsl:param name="pluginspage">
        http://digital.ni.com/express.nsf/bycode/exwgjq
    </xsl:param>
    <div class="media labview example">
      <xsl:call-template name='IdCheck'/>
      <object classid="{$classid}"
              codebase="{$codebase}">
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
	       type="{@type}"
	       pluginspage="{$pluginspage}">
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
      <p>
        <xsl:call-template name="gentext">
          <xsl:with-param name="key">Download</xsl:with-param>
          <xsl:with-param name="lang"><xsl:value-of select="/module/metadata/language"/></xsl:with-param>
        </xsl:call-template>
        <xsl:text> </xsl:text>
        <!--Download--> 
        <a class="cnxn" href="{@src}">
          <xsl:call-template name="gentext">
            <xsl:with-param name="key">LabVIEWSource</xsl:with-param>
            <xsl:with-param name="lang"><xsl:value-of select="/module/metadata/language"/></xsl:with-param>
          </xsl:call-template>
          <!--LabVIEW source-->
        </a>
      </p>
    </div>
  </xsl:template>

  <!-- FLASH Objects -->
  <xsl:template match="cnx:media[@type='application/x-shockwave-flash']">
    <span class="media">
    <object type="application/x-shockwave-flash" data="{@src}">
      <xsl:call-template name='IdCheck'/>
      <xsl:for-each select="cnx:param">
        <xsl:choose>
          <xsl:when test="@name='width' or @name='height'">
            <xsl:attribute name="{@name}">
              <xsl:value-of select="@value" />
            </xsl:attribute>
          </xsl:when>
          <xsl:otherwise>
            <param name="{@name}" value="{@value}" />
          </xsl:otherwise>
        </xsl:choose>
      </xsl:for-each>
      <param name="movie" value="{@src}"/>
      <embed src="{@src}" type="application/x-shockwave-flash" pluginspace="http://www.macromedia.com/shockwave/download/index.cgi?P1_Prod_Version=ShockwaveFlash">
        <xsl:for-each select="cnx:param">
          <xsl:attribute name="{@name}">
            <xsl:value-of select="@value" />
          </xsl:attribute>
        </xsl:for-each>
      </embed>
    </object>
    </span>
  </xsl:template>

  <!-- Generic audio file -->
  <xsl:template match="cnx:media[starts-with(@type,'audio')]"> 
    <div class="media musical example">
      <xsl:call-template name='IdCheck'/>
      <span class="cnx_label">
        <xsl:call-template name="gentext">
          <xsl:with-param name="key">AudioFile</xsl:with-param>
          <xsl:with-param name="lang"><xsl:value-of select="/module/metadata/language"/></xsl:with-param>
        </xsl:call-template>:
        <!--Audio File:-->
      </span>
      <a class="link" href="{@src}">
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
    <div class="media musical example">
      <xsl:call-template name='IdCheck'/>
      <span class="cnx_label">
        <xsl:call-template name="gentext">
          <xsl:with-param name="key">MusicalExample</xsl:with-param>
          <xsl:with-param name="lang"><xsl:value-of select="/module/metadata/language"/></xsl:with-param>
        </xsl:call-template>:
        <!--Musical Example:-->
      </span>
      <a class="cnxn" href="{@src}">
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
      <xsl:if test="$case-diagnosis = '0' or cnx:name or cnx:title or not(cnx:label[not(node())])">
        <xsl:variable name="level-number">
          <xsl:call-template name="level-count" />
        </xsl:variable>
        <!-- h2, h3, etc... -->
        <xsl:element name="h{$level-number}">
          <xsl:attribute name="class">exercise-header</xsl:attribute>
          <xsl:if test="not(cnx:label[not(node())])">
            <span class="cnx_label">
              <xsl:choose>
                <xsl:when test="cnx:label">
                  <xsl:apply-templates select="cnx:label" />
                </xsl:when>
                <xsl:when test="ancestor::cnx:example">
                  <!-- Problem -->
                  <xsl:call-template name="gentext">
                    <xsl:with-param name="key">Problem</xsl:with-param>
                    <xsl:with-param name="lang" select="/module/metadata/language" />
                  </xsl:call-template>
                </xsl:when>
                <xsl:otherwise>
                  <!-- Exercise -->
                  <xsl:call-template name="gentext">
                    <xsl:with-param name="key">Exercise</xsl:with-param>
                    <xsl:with-param name="lang" select="/module/metadata/language" />
                  </xsl:call-template>
                </xsl:otherwise>
              </xsl:choose>
              <xsl:text> </xsl:text>
              <xsl:choose>
                <xsl:when test="@type">
                  <xsl:variable name="type" select="@type" />
                  <xsl:number level="any" count="cnx:exercise[@type=$type]" />
                </xsl:when>
                <xsl:when test="ancestor::cnx:example">
                  <xsl:number level="any" count="cnx:exercise[not(@type)]" from="cnx:example" />
                </xsl:when>
                <xsl:otherwise>
                  <xsl:number level="any" count="cnx:exercise[not(ancestor::cnx:example) and not(@type)]" />
                </xsl:otherwise>
              </xsl:choose>
              <xsl:if test="cnx:name or cnx:title">
                <xsl:text>: </xsl:text>
              </xsl:if>
            </span>
          </xsl:if>
          <xsl:apply-templates select="cnx:name|cnx:title" />
        </xsl:element>
      </xsl:if>
      <xsl:apply-templates select="*[not(self::cnx:name|self::cnx:title|self::cnx:label)]" />
    </div>
  </xsl:template>

  <!-- PROBLEM -->
  <xsl:template match="cnx:problem">
    <div class="problem">
      <xsl:call-template name='IdCheck'/>
      <xsl:if test="cnx:label[node()] or cnx:name or cnx:title">
        <xsl:variable name="level-number">
          <xsl:call-template name="level-count" />
        </xsl:variable>
        <!-- h2, h3, etc... -->
        <xsl:element name="h{$level-number}">
          <xsl:attribute name="class">problem-header</xsl:attribute>
          <xsl:if test="cnx:label[node()]">
            <span class="cnx_label">
              <xsl:apply-templates select="cnx:label" />
              <xsl:if test="cnx:name or cnx:title">: </xsl:if>
            </span>
          </xsl:if>
          <xsl:apply-templates select="cnx:name|cnx:title" />
        </xsl:element>
      </xsl:if>
      <xsl:apply-templates select="*[not(self::cnx:name|self::cnx:title|self::cnx:label)]" />
    </div>
  </xsl:template>

  <!--SOLUTION -->
  <xsl:template match="cnx:solution">
    <xsl:variable name="solution-number">
      <xsl:number count="cnx:solution" />
    </xsl:variable>
    <xsl:variable name="solution-letter">
      <xsl:choose>
        <xsl:when test="count(parent::cnx:exercise/cnx:solution) > 1">
          <xsl:number count="cnx:solution" format=" A" />
        </xsl:when>
        <xsl:otherwise />
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="solution-string">
      <xsl:choose>
        <xsl:when test="cnx:label[node()]">
          <xsl:value-of select="cnx:label" />
        </xsl:when>
        <xsl:when test="$case-diagnosis = '1'">Diagnosis</xsl:when>
        <xsl:otherwise>Solution</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="clickfor-string">
      <xsl:value-of select="concat('ClickFor', $solution-string)"/>
    </xsl:variable>
    <xsl:variable name="hide-string">
      <xsl:value-of select="concat('Hide', $solution-string)"/>
    </xsl:variable>
    <xsl:variable name="javascriptpresent" select="/module/display/javascriptpresent"/>
    <div class="solution">
      <xsl:call-template name='IdCheck' />
      <xsl:attribute name="style">
        <xsl:choose>
          <xsl:when test="$javascriptpresent='true'">
            <xsl:text>display: none;</xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text>display: block;</xsl:text>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:attribute>
      <xsl:if test="$case-diagnosis = '0' and (cnx:name or cnx:title or not(cnx:label[not(node())]))">
        <xsl:variable name="level-number">
          <xsl:call-template name="level-count" />
        </xsl:variable>
        <!-- h2, h3, etc... -->
        <xsl:element name="h{$level-number}">
          <xsl:attribute name="class">solution-header</xsl:attribute>
          <xsl:if test="$case-diagnosis = '0' and not(cnx:label[not(node())])">
            <span class="cnx_label">
              <!--Solution-->
              <xsl:call-template name="gentext">
                <xsl:with-param name="key" select="$solution-string" />
                <xsl:with-param name="lang" select="/module/metadata/language" />
              </xsl:call-template>
              <xsl:value-of select="$solution-letter" />
              <xsl:if test="cnx:name or cnx:title">: </xsl:if>
            </span>
          </xsl:if>
          <xsl:apply-templates select="cnx:name|cnx:title" />
        </xsl:element>
      </xsl:if>
      <xsl:apply-templates select="*[not(self::cnx:name|self::cnx:title|self::cnx:label)]" />
    </div>
    <div class="solution-toggles">
      <xsl:attribute name="style">
        <xsl:choose>
          <xsl:when test="$javascriptpresent='true'">
            <xsl:text>display: block;</xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text>display: none;</xsl:text>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:attribute>
      <a href="#" onclick="toggleSolution('{../@id}',{$solution-number}); return false;">
      <span class="solution-toggle">
      [
      <!-- Click for Solution/Diagnosis -->
      <xsl:call-template name="gentext">
        <xsl:with-param name="key"><xsl:value-of select="$clickfor-string"/></xsl:with-param>
        <xsl:with-param name="lang" select="/module/metadata/language" />
      </xsl:call-template>
      <xsl:value-of select="$solution-letter" />
      ]
      </span>
      <span class="solution-toggle" style="display: none;">
        [ 
        <!-- Hide Solution/Diagnosis -->
        <xsl:call-template name="gentext">
          <xsl:with-param name="key"><xsl:value-of select="$hide-string"/></xsl:with-param>
          <xsl:with-param name="lang" select="/module/metadata/language" />
        </xsl:call-template>
        <xsl:value-of select="$solution-letter" />
        ]
      </span>
      </a>
    </div>
  </xsl:template>

</xsl:stylesheet>
