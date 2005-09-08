<?xml version= "1.0" standalone="no"?>

<xsl:stylesheet version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:cnx="http://cnx.rice.edu/cnxml/0.4"
  xmlns:md="http://cnx.rice.edu/mdml/0.4"
  xmlns:m="http://www.w3.org/1998/Math/MathML"
  xmlns="http://www.w3.org/1999/xhtml">
  
  <!-- Default to *not* displaying the 'no-mathml' blurb -->
  <xsl:param name="no-mathml" select="0" />

  <!-- Root Node -->
  <xsl:template match="/">
    <!-- does not include the multiple stylesheet info here -->

    <html>
      <head>

        <script language="javascript" src="/cnxml/0.4/scripts/ie-exercise.js" />
        <script language="javascript" src="/qml/1.0/scripts/qml_1-0.js" />

        <!-- ****QML**** sets the feedback and hints to non-visible. -->
        <style type="text/css">
          .feedback {display:none}
          .hint {display:none}
        </style>
	
	<link rel="stylesheet" title="Default" type="text/css" href="/cnxml/0.4/style/ie/max.css" />
	
	<!--MODULE's NAME-->
        <title><xsl:value-of select="cnx:module/cnx:name"/></title>
      </head>	
      <xsl:apply-templates />
    </html>
  </xsl:template>

  <!-- Header and Body for the Module -->

  <xsl:variable name="created"><xsl:value-of select="//md:created" /></xsl:variable>
  <xsl:variable name="revised"><xsl:value-of select="//md:revised" /></xsl:variable>
  <xsl:variable name="version"><xsl:value-of select="//md:version" /></xsl:variable>

  <xsl:template match="cnx:module">
    <body id="{@id}"
          created="{$created}"
          revised="{$revised}"
          version="{$version}">

      <!--MODULE's NAME-->
      <div class="module-name"><xsl:value-of select="cnx:name"/></div>

      <div class="about-links">
	<span class="about">VIEW</span> &#183; <a class="about" href="about">ABOUT</a> &#183; <a class="about" href="history">HISTORY</a> &#183; <a class="about" href="?format=pdf">PRINT</a>
      </div>

      <!-- Warning Message about LATEST VERSION -->
      <xsl:if test="$latest">
	<div class="latest">Note: You are viewing an old version of this document.
	  <a class="latest-link">
	    <xsl:attribute name="href"><xsl:value-of select="$latest" /></xsl:attribute>
	    Latest version available here
	  </a>.
	</div>
      </xsl:if>

      <!-- Note about INABILITY TO DISPLAY MATH -->
      <xsl:if test="$no-mathml and //m:math|//cnx:equation">
	<a name="no-mathml">
	  <div class="no-mathml">
	    Note: This browser cannot display MathML.  To be able to view the math on this page, please consider using another browser, such as <a class="other-browsers" href="http://www.mozilla.org/releases/">Mozilla</a>, <a class="other-browsers" href="http://channels.netscape.com/ns/browsers/7/default.jsp">Netscape 7</a> or <a class="other-browsers" href="http://www.microsoft.com/windows/ie/downloads/ie6/default.asp">Microsoft Internet Explorer 5.5 or above</a> (<a class="other-browsers" href="http://www.dessci.com/webmath/mathplayer/">MathPlayer</a> required for IE).
	  </div>
	</a>
      </xsl:if>
      <xsl:apply-templates />

      <xsl:for-each select="//cnx:note[@type='footnote']">
        <xsl:variable name="footnote-number">
          <xsl:number level="any" count="//cnx:note[@type='footnote']" format="1" />
        </xsl:variable>
        <a class="footnote-number" name="footnote{$footnote-number}" />
        <div class="footnote">
          <span class="footnote-number">
            <xsl:number level="any" count="//cnx:note[@type='footnote']" />: 
          </span>
          <xsl:apply-templates />
        </div>
      </xsl:for-each>

      <div class="authorlist-maintainerlist">
	<xsl:apply-templates select="//md:authorlist|//md:maintainerlist" />
      </div>


      <xsl:if test="$footer">
        <!--CONNEXIONS PROJECT LOGO AND CONTACT EMAIL GO HERE.-->
	<div class="footer">
	  <table border="0" width="100%" class="footer" cellpadding="0" cellspacing="0">
	    <tr>
	      <td class="logo">
		<a href="http://cnx.rice.edu/">
		  <img src="/images/the-connexions-project-footer.jpg" border="0" alt="The Connexions Project, Rice University" title="The Connexions Project, Rice University"/>
		</a><br />
		<div class="questions-comments">
		  <a class="questions-comments" href="mailto:cnx@rice.edu">Questions? Comments?</a>
		</div>
	      </td>
	      <td class="license">
		<xsl:if test="$license">
		  <!-- Creative Commons License -->
		  <div>
		    <a href="{$license}"><img alt="Creative Commons License" border="0" src="http://creativecommons.org/images/public/somerights.gif" /></a>
		    <div class="license-text">This work is licensed under a <a class="license-link" href="{$license}">Creative Commons License</a>.</div>
		  </div>
		</xsl:if>
	      </td>
	    </tr>
	  </table>
	</div>
      </xsl:if>

    </body>
  </xsl:template>

  <!-- METADATA without AUTHORLIST or MAINTAINERLIST -->
  <xsl:template match="cnx:metadata">
    <div class="metadata">
      <xsl:apply-templates select="*[not(self::md:authorlist|self::md:maintainerlist)]" />
    </div>
  </xsl:template>

  <!--HOMEPAGE Attribute (:before & :after)-->
  <xsl:template match="md:authorlist">
    <div class="authorlist">
      <span class="authorlist-before">Written by: </span>
      <xsl:for-each select="md:author">
        <span class="author">
          <xsl:choose> 
            <xsl:when test="@homepage">
              <xsl:apply-templates />
              <span class="homepage-before">(</span><a class="homepage" href="{@homepage}">homepage</a><span class="homepage-after">)</span>
            </xsl:when>
            <xsl:otherwise>
              <xsl:apply-templates />
            </xsl:otherwise>
          </xsl:choose>
          <xsl:if test="not(position()=last())">, </xsl:if>
        </span> 
      </xsl:for-each>
    </div>
  </xsl:template>
  <xsl:template match="md:maintainerlist">
    <div class="maintainerlist">
      <span class="maintainerlist-before">Maintained by: </span>
      <xsl:for-each select="md:maintainer">
        <span class="maintainer">
          <xsl:choose>
            <xsl:when test="@homepage">
              <xsl:apply-templates />
              <span class="homepage-before">(</span><a class="homepage" href="{@homepage}">homepage</a><span class="homepage-after">)</span>
            </xsl:when>
            <xsl:otherwise>
              <xsl:apply-templates />
            </xsl:otherwise>
          </xsl:choose>
          <xsl:if test="not(position()=last())">, </xsl:if>
        </span>
      </xsl:for-each>  
    </div>
  </xsl:template>

  <!--EMAIL (:before & :after)-->
  <xsl:template match='md:email'>
    <span class="email-before">(</span>
      <a class="email" href="mailto:{.}">
        <xsl:value-of select="normalize-space(.)" />
      </a>
    <span class="email-after">)</span>
  </xsl:template>

  <!--generic EXAMPLE (:before)-->
  <xsl:template match="cnx:example">
    <div class="example">
      <span class="example-before">
	Example <xsl:if test="self::cnx:example[not(parent::cnx:definition|parent::cnx:rule)]">
	  <xsl:number level="any" count="cnx:example[not(parent::cnx:definition|parent::cnx:rule)]"/>
	</xsl:if>
	<xsl:if test="cnx:name">: </xsl:if>
      </span>
      <xsl:if test="cnx:name">
	<span class="example-name"><xsl:value-of select="cnx:name"/></span>
      </xsl:if>
      <xsl:apply-templates select="*[not(self::cnx:name)]" />
    </div>
  </xsl:template>

  <!--DEFINITION (:before)-->
  <xsl:template match="cnx:definition">
    <div class='definition'>
      <span class="definition-before">Definition <xsl:number level="any" count="cnx:definition"/>: </span>
      <span class='term'><xsl:apply-templates select='cnx:term'/>  </span>
      <xsl:apply-templates select='cnx:meaning|cnx:example'/>
    </div>
  </xsl:template>

  <!--PROOF (:before)-->
  <xsl:template match="cnx:proof">
    <div class='proof'>
      <xsl:choose>
	<xsl:when test="child::*[position()=1 and local-name()='name']">
	  <span class="proof-before">Proof: </span>
	  <span class="proof-name"><xsl:value-of
	  select="cnx:name"/></span>
	</xsl:when>
	<xsl:otherwise>
	  <span class="proof-before">Proof: </span>
	</xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates/>
    </div>
  </xsl:template>

  <!--RULE (:before)-->
  <xsl:template match="cnx:rule">
    <xsl:variable name="type" select="@type"/>
    <div class='rule' type='{@type}'>
      <xsl:call-template name='IdCheck'/>
      <span class="rule-before">
	<xsl:value-of select="@type"/><xsl:text> </xsl:text><xsl:number level="any" count="cnx:rule[@type=$type]" />: 
      </span>
      <xsl:if test="child::*[position()=1 and local-name()='name']">
	<span class='rule-name'><xsl:value-of select="cnx:name"/></span>
      </xsl:if>
      <xsl:apply-templates/>
    </div>
  </xsl:template>

  <!--RULE's STATEMENT-->
  <xsl:template match="cnx:rule/cnx:statement">
    <div class='statement'>
      <xsl:apply-templates/>
    </div>	
  </xsl:template>

  <!--PROBLEM (:before)-->
  <xsl:template match="cnx:problem">
    <div class="problem">
      <span class="problem-before">Problem 
	<xsl:number level="any" count="cnx:exercise"/>:
      </span>
      <xsl:apply-templates />
    </div>
  </xsl:template>

  <!--SOLUTION (:before)-->
  <xsl:template match="cnx:solution">
    <div class="button" onclick="showSolution('{../@id}')">
      <span class="button-text">[ Click for Solution ]</span>
    </div>   
    <div class="solution" onclick="hideSolution('{../@id}')">
      <span class="solution-before">Solution
	<xsl:number level="any" count="cnx:exercise"/>: 
      </span>
      <xsl:apply-templates />
      <span class="button-text">[ Hide Solution ]</span>
    </div>
                            
  </xsl:template>

  <!--ABSTRACT (:before)-->
  <xsl:template match="md:abstract">
    <div class='abstract'>
      <span class="abstract-before">Summary: </span>
      <xsl:apply-templates/>
    </div>
  </xsl:template>

   <!--OBJECTIVES (:before)-->
  <xsl:template match="md:objectives">
    <div class='objectives'>
      <span class="objectives-before">Objectives: </span>
      <xsl:apply-templates/>
    </div>
  </xsl:template>
  
  <!-- NOTE (:before)-->
  <xsl:template match="cnx:note">
    <div class="note">
      <xsl:choose>
        <xsl:when test="@type = ''">
          <xsl:attribute name="title">
            <xsl:value-of select="@type"/>
          </xsl:attribute>
          <span class="note-before">Note: </span>
          <xsl:apply-templates/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:attribute name="title">
            <xsl:value-of select="@type"/>
          </xsl:attribute>
          <span class="note-before"><xsl:value-of select="@type"/>: </span>
          <xsl:apply-templates/>
        </xsl:otherwise>
      </xsl:choose>
    </div>
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
    
    <a name="{@id}" />
    <table class="figure" border="0" cellspacing="8" cellpadding="0" width="50%" align="center">
      
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
		  <span class="figure-name">
		    <xsl:value-of select="cnx:name"/>
		  </span>
		</td>
	      </tr>
	      <tr>
		<td>
		  <div class="figure">
		    <table border="0" cellspacing="8" cellpadding="0" width="100%">
		      <tr>
			<xsl:for-each select="cnx:subfigure">
			  <td valign="bottom" align="center">
			    <span class="subfigure-name">
			      <xsl:value-of select="cnx:name" />
			    </span>
			  </td>
			</xsl:for-each>
		      </tr>
		      <tr>
			<xsl:for-each select="cnx:subfigure">
			  <td align="center" valign="middle">
			    <div class="subfigure" id="{@id}">
			      <xsl:apply-templates select="cnx:media|cnx:table|cnx:codeblock" />
			    </div>
			  </td>
			</xsl:for-each>
		      </tr>
		      <tr>
			<xsl:for-each select="cnx:subfigure">
			  <td valign="top">
			    <span class="caption-subfigure-horizontal">
			      <span class="caption-before">Subfigure <xsl:number level="any" count="cnx:figure" />.<xsl:number count="cnx:subfigure" /><xsl:if test="cnx:caption">: </xsl:if></span> 
			      <xsl:apply-templates select="cnx:caption"/>
			    </span>
			  </td>
			</xsl:for-each>
		      </tr>
		    </table>
		  </div>
		</td>
	      </tr>
	      <tr>
		<td colspan="{$subfigure-quantity}">
		  <span class="caption">
		    <span class="caption-before">Figure <xsl:number level="any" count="cnx:figure" /><xsl:if test="cnx:caption">: </xsl:if></span> 
		    <xsl:apply-templates select="cnx:caption" />
		  </span>
		</td>
	      </tr>
	    </xsl:when>
	    
	    <!-- How to treat the figure that has VERTICAL SUBFIGURES -->
	    <xsl:when test="$orient='vertical'">
	      <tr>
		<td>
		  <span class="figure-name">
		    <xsl:value-of select="cnx:name"/>
		  </span>
		</td>
	      </tr>
	      <tr>
		<td>
		  <div class="figure">
		    <table border="0" cellspacing="8" cellpadding="0" width="100%">
		      <xsl:for-each select="cnx:subfigure">
			<tr>
			  <td align="center">
			    <span class="subfigure-name">
			      <xsl:value-of select="cnx:name" />
			    </span>
			  </td>
			</tr>
			<tr>
			  <td align="center">
			    <div class="subfigure" id="{@id}">
			      <xsl:apply-templates select="cnx:media|cnx:table|cnx:codeblock" />
			    </div>
			  </td>
			</tr>
			<tr>
			  <td>
			    <span class="caption-subfigure-vertical">
			      <span class="caption-before">Subfigure <xsl:number level="any" count="cnx:figure" />.<xsl:number count="cnx:subfigure" /><xsl:if test="cnx:caption">: </xsl:if></span> 
			      <xsl:apply-templates select="cnx:caption"/>
			    </span>
			  </td>
			</tr>
		      </xsl:for-each>
		    </table>
		  </div>
		</td>
	      </tr>
	      <tr>
		<td>
		  <span class="caption">
		    <span class="caption-before">Figure <xsl:number level="any" count="cnx:figure" /><xsl:if test="cnx:caption">: </xsl:if></span> 
		    <xsl:apply-templates select="cnx:caption" />
		  </span>
		</td>
	      </tr>
	    </xsl:when>
	  </xsl:choose>
	</xsl:when>
	
	<xsl:otherwise>
	  <!--The case when there are NO SUBFIGURES.-->
	  <tr>
	    <td>
	      <span class="figure-name">
		<xsl:value-of select="cnx:name"/>
	      </span>
	    </td>
	  </tr>
	  <tr>
	    <td align="center" class="figure">
	      <div class="figure" id="{@id}">
		<xsl:apply-templates select="cnx:media|cnx:table|cnx:codeblock"/>
	      </div>
	    </td>
	  </tr>
	  <tr>
	    <td>
	      <span class="caption">
		<span class="caption-before">Figure <xsl:number level="any" count="cnx:figure" /><xsl:if test="cnx:caption">: </xsl:if></span>
		<xsl:apply-templates select="cnx:caption" />
	      </span>
	    </td>
	  </tr>
	</xsl:otherwise>	    
      </xsl:choose>
      
    </table>
    
  </xsl:template>

  <!-- SECTION (NAME) (instead of h1, h2, ... h6)-->
  <xsl:template match="cnx:section">
    <div class="section" id="{@id}">
      <span class="section-name">
	<xsl:value-of select="cnx:name" />
      </span>
      <xsl:apply-templates />
    </div>
  </xsl:template>

  <!-- EQUATION (for IE on a Mac) -->
  <xsl:template match="cnx:equation">
    <!--do something with the para because eqn can go in paras-->
    <div class="equation" id="{@id}">
      <div class="equation-before">
	<span class="equation-number">
	  Equation <xsl:number level="any" count="cnx:equation"/>
	  <xsl:if test="cnx:name">: </xsl:if>
	</span>
	<xsl:if test="cnx:name">
	  <span class="equation-name">
	    <xsl:value-of select="cnx:name"/>
	  </span>
	</xsl:if>
      </div>
      <div class="math-error">
	[<a class="no-mathml" href="#no-mathml">Math display error.  See note.</a>]
      </div>
    </div>
  </xsl:template>

  <!-- MATH (for IE on a Mac) -->
  <xsl:template match="m:math">
    <span class="math-error">
      [<a class="no-mathml" href="#no-mathml">Math display error.  See note.</a>]
    </span>
  </xsl:template>

</xsl:stylesheet>
