<?xml version= "1.0" standalone="no"?>

<xsl:stylesheet version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:cnx="http://cnx.rice.edu/cnxml/0.3.5"
  xmlns:m="http://www.w3.org/1998/Math/MathML"
  xmlns="http://www.w3.org/1999/xhtml">
  
<xsl:variable name="lower" select="'abcdefghijklmnopqrstuvwxyz'" />
<xsl:variable name="upper" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'" />

  <!-- Root Node -->
  <xsl:template match="/">
    <!-- does not include the multiple stylesheet info here -->

    <html>
      <head>

<!--
        <script language="javascript" src="http://rhaptos.ece.rice.edu/cnxml/0.3.5/scripts/exercise.js" />
        <script language="javascript" src="http://rhaptos.ece.rice.edu/qml/1.0/scripts/qml_1-0.js" />
-->

        <!-- ****QML**** sets the feedback and hints to non-visible. -->
        <style type="text/css">
          .feedback {display:none}
          .hint {display:none}
        </style>
	
	<link rel="stylesheet" title="Default" type="text/css" href="/cnxml/0.3.5/style/netscape4/netscape4.css" />

	<!--MODULE's NAME-->
        <title><xsl:value-of select="cnx:module/cnx:name"/></title>
      </head>	
      <xsl:apply-templates />
    </html>
  </xsl:template>

  <!-- Header and Body for the Module -->
  <xsl:template match="cnx:module">
    <body bgcolor="#6699cc" marginwidth="0px" marginheight="0px">
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
	
	<!--MODULE's NAME and ABOUT LINKS-->
	<tr>
	  <td rowspan="6" bgcolor="#006699" width="15">
	    <img src="/cnxml/0.3.5/style/netscape4/spacer.gif" width="15"/>
	  </td>
	  <td bgcolor="#6699cc" width="100%">
	    <span class="namebox">
	      <xsl:value-of select="cnx:name"/>
	    </span>
	  </td>
        </tr> 
        <tr>
          <td bgcolor="#3377aa" width="100%" align="right">
            <div class="about-links"> 
              <span class="about">VIEW</span> &#183; <a class="about" href="about">ABOUT</a> &#183; <a class="about" href="history">HISTORY</a> &#183; <a class="about" href="?format=pdf">PRINT</a>
            </div> 
          </td>
        </tr>
	
	<!-- Line Under Title -->
	<tr>
	  <td height="2" class="line-under-title">
	    <img src="/cnxml/0.3.5/style/netscape4/spacer.gif" height="2"/>
	  </td>
	</tr>
	<tr>
	  <td class="metadata-and-content-table" bgcolor="#ffffff">
	    <div class="metadata-and-content-table">
	      <table class="metadata-and-content-table" border="0" cellspacing="0" cellpadding="0" width="100%">
		<tr>
		  <td colspan="3" height="15" class="space-under-title">
		    <img src="/cnxml/0.3.5/style/netscape4/spacer.gif" height="15"/>
		  </td>
		</tr>
		<tr>
		  <td colspan="3" width="15" class="metadata-and-content-margin">
		    <img src="/cnxml/0.3.5/style/netscape4/spacer.gif" width="15"/>
		  </td>
		  <td class="metadata-and-content">
		    <div class="metadata-and-content">
		      <!-- ABSTRACT and OBJECTIVES at beginning -->
		      <xsl:apply-templates select="//cnx:abstract|//cnx:objectives"/>
		      
		      <!-- Note about DISABILITY TO DISPLAY MATH -->
		      <xsl:if test="//m:math|//cnx:equation">
		        <a name="nomathml">
			  <div class="nomathml">
			    Note: This browser cannot display MathML.  To be able to view the math on this page, please consider using another browser, such as <a class="otherbrowsers" href="http://www.mozilla.org/releases/">Mozilla</a>, <a class="otherbrowsers" href="http://channels.netscape.com/ns/browsers/7/default.jsp">Netscape 7</a> or <a class="otherbrowsers" href="http://www.microsoft.com/windows/ie/downloads/ie6/default.asp">Microsoft Internet Explorer 5.5 or above</a> (<a class="otherbrowsers" href="http://www.dessci.com/webmath/mathplayer/">MathPlayer</a> required for IE).
			  </div>
		        </a>
		      </xsl:if>
		      
		      <!-- Line at Top -->
		      <div class="line-top">
			<table border="0" cellpadding="0" width="100%" cellspacing="0">
			  <tr>
			    <td height="2">
			      <img src="/cnxml/0.3.5/style/netscape4/spacer.gif" height="2"/>
			    </td>
			  </tr>
			</table>	
		      </div>
		      
		      <!-- rest of the content -->
		      <xsl:apply-templates select="descendant-or-self::cnx:content"/>
		      
		      <!-- any possible footnotes -->
		      <xsl:for-each select="//cnx:note[@type='footnote']">
			<xsl:variable name="footnote-number">
			  <xsl:number level="any" count="//cnx:note[@type='footnote']" format="1" />
        		</xsl:variable>
			<div class="footnote">
          		  <a class="footnote-number" name="footnote{$footnote-number}">
	    		    <span class="footnotebefore"><xsl:value-of select="$footnote-number" />: </span>
	  		  </a>
			  <xsl:apply-templates />
			</div>
		      </xsl:for-each>

		      <!-- Line at Bottom -->
		      <div class="line-bottom">
			<table border="0" cellpadding="0" width="100%" cellspacing="0">
			  <tr>
			    <td height="2">
			      <img src="/cnxml/0.3.5/style/netscape4/spacer.gif" height="2"/>
			    </td>
			  </tr>
			</table>
		      </div>
		      
		      <!-- AUTHOR and MAINTAINER at bottom -->	   
		      <div class="authorlist-maintainerlist">
			<table border="0" cellspacing="0" cellpadding="0" class="authorlist-maintainerlist">
			  <tr>
			    <td class="authorlistbefore" valign="top">
			      <span class="authorlistbefore">Written By: </span>
			    </td>
			    <td class="authorlist">
			      <xsl:apply-templates select="cnx:metadata/cnx:authorlist" />
			    </td>
			  </tr>
			  <tr>
			    <td class="maintainerlistbefore" valign="top">
			      <span class="maintainerlistbefore">Maintained By: </span>
			    </td>
			    <td class="maintainerlist">
			      <xsl:apply-templates select="cnx:metadata/cnx:maintainerlist" />
			    </td>
			  </tr>
			</table>
		      </div>
		      
		      <xsl:if test="$footer">
			<!--CONNEXIONS PROJECT LOGO AND CONTACT EMAIL GO HERE.-->
			<div class="footer">
			  <table border="0" width="100%" class="footer" cellpadding="0" cellspacing="0">
			    <tr>
			      <td class="logo">
				<a href="http://cnx.rice.edu/">
				  <img src="/cnxml/0.3.5/style/common/the-connexions-project-footer.jpg" border="0" alt="The Connexions Project, Rice University" title="The Connexions Project, Rice University"/>
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
				    <div>This work is licensed under a <a class="license-link" href="{$license}">Creative Commons License</a>.</div>
				  </div>
				</xsl:if>
			      </td>
			    </tr>
			  </table>
			</div>
		      </xsl:if>

		    </div>	    
		  </td>
		  <td width="15" class="metadata-and-content-margin">
		    <img src="/cnxml/0.3.5/style/netscape4/spacer.gif" width="15"/>
		  </td>
		</tr>
<!--
		<tr>
		  <td colspan="3" height="15" class="space-under-footer">
		    <img src="/cnxml/0.3.5/style/netscape4/spacer.gif" height="15"/>
		  </td>
		</tr>
-->
	      </table>
	    </div>
	  </td>
	</tr>
      </table>
    </body>
  </xsl:template>
  
  <!--ABSTRACT-->
  <xsl:template match="cnx:abstract">
    <div class='abstract'>
      <span class="abstractbefore">Summary: </span>
      <xsl:apply-templates/>
    </div>
  </xsl:template>

   <!--OBJECTIVES-->
  <xsl:template match="cnx:objectives">
    <div class='objectives'>
      <span class="objectivesbefore">Objectives: </span>
      <xsl:apply-templates/>
    </div>
  </xsl:template>

  <!--HOMEPAGE Attribute-->
  <xsl:template match="cnx:authorlist">
    <xsl:for-each select="cnx:author">
      <span class="author">
	<xsl:choose>
	  <xsl:when test="@homepage">
	    <xsl:apply-templates />
	    <span class="homepagebefore">(</span><a class="homepage" href="{@homepage}">homepage</a><span class="homepageafter">)</span>
	  </xsl:when>
	  <xsl:otherwise>
	    <xsl:apply-templates />
	  </xsl:otherwise>
	</xsl:choose>
	<xsl:if test="not(position()=last())">, </xsl:if>
      </span>
    </xsl:for-each>
  </xsl:template> 
  <xsl:template match="cnx:maintainerlist">
    <xsl:for-each select="cnx:maintainer">
      <span class="maintainer">
	<xsl:choose>
	  <xsl:when test="@homepage">
	    <xsl:apply-templates />
	    <span class="homepagebefore">(</span><a class="homepage" href="{@homepage}">homepage</a><span class="homepageafter">)</span>
	  </xsl:when>
	  <xsl:otherwise>
	    <xsl:apply-templates />
	  </xsl:otherwise>
	</xsl:choose>
	<xsl:if test="not(position()=last())">, </xsl:if>
      </span>
    </xsl:for-each>
  </xsl:template> 
  
  <!--EMAIL-->
  <xsl:template match='cnx:email'>
    <span class="emailbefore">(</span>
      <a class="email" href="mailto:{.}">
        <xsl:value-of select="normalize-space(.)" />
      </a>
    <span class="emailafter">)</span>
  </xsl:template>

  <!--SECTION-->
  <xsl:template match="//cnx:section">
    <div class='section'>
      <div class='section-name-table'>
        <table border="0" width="100%" cellpadding="0" cellspacing="0" class="section">
	  <tr>
	    <td class="sectionname">
	      <span class="sectionname" id='{@id}'>
	        <xsl:value-of select="cnx:name"/>
	      </span>
	    </td>
	  </tr>
	  <tr>
	    <td class="blue-line" height="2">
	      <img src="/cnxml/0.3.5/style/netscape4/spacer.gif" height="2"/>
	    </td>
	  </tr>
        </table>
      </div>
      <div class="section-content">
        <xsl:apply-templates/>
      </div>
    </div>
  </xsl:template>


  <!--PARA-->
  <!-- Paragraph. Formatting in CSS under p.para -->
  <xsl:template match="cnx:para">
    <p class="para" id='{@id}'>
      <xsl:apply-templates/>
    </p>
  </xsl:template>

  <!--generic EXAMPLE-->
  <xsl:template match="cnx:example">
    <div class='example-table'>
      <table class="example-table" border="0" cellspacing="0" cellpadding="0" width="100%">
	<tr>
	  <td width="36"><img src="/cnxml/0.3.5/style/netscape4/spacer.gif" width="36" height="1" /></td>
	  <td class="example" width="100%">
	    <div class="example">
	      <xsl:choose>
		<xsl:when test="child::*[position()=1 and local-name()='name']">
		  <span class="examplebefore">EXAMPLE: </span>
		  <span class="examplename"><xsl:value-of select="cnx:name"/>
		  </span>
		</xsl:when>
		<xsl:otherwise>
		  <span class="examplebefore">EXAMPLE: </span>
		</xsl:otherwise>
	      </xsl:choose>
	      <xsl:apply-templates/>
	    </div>
	  </td>
	</tr>
      </table>
    </div>
  </xsl:template>
  
  <!--DEFINITION-->
  <xsl:template match="cnx:definition">
    <div class='definition'>
      <span class="termbefore">TERM: </span>
      <span class='term'><xsl:apply-templates select='cnx:term'/>  </span>
      <xsl:apply-templates select='cnx:meaning|cnx:example'/>
    </div>
  </xsl:template>

  <!--MEANING-->
  <xsl:template match="cnx:meaning">
    <div class='meaning-table'>
      <table class="meaning-table" border="0" cellspacing="0" cellpadding="0" width="100%">
	<tr>
	  <td width="36"><img src="/cnxml/0.3.5/style/netscape4/spacer.gif" width="36" height="1" /></td>
	  <td class="meaning" width="100%">
	    <div class="meaning">
	      <xsl:number level="single"/>. <xsl:apply-templates/>
	    </div>
	  </td>
	</tr>
      </table>
    </div>
  </xsl:template>

  <!--DEFINITION's EXAMPLE-->
<!--
  <xsl:template match="cnx:definition/cnx:example">
    <div class='example'>
      <xsl:choose>
	<xsl:when test="child::*[position()=1 and local-name()='name']">
	  <span class="examplebefore">EXAMPLE: </span>
	  <span class="examplename"><xsl:value-of select="cnx:name"/>
	  </span>
	</xsl:when>
	<xsl:otherwise>
	  <span class="examplebefore">EXAMPLE: </span>
	</xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates/>
    </div>
  </xsl:template> 
-->

<!--PROOF-->
  <xsl:template match="cnx:proof">
    <div class="proof-table">
      <table class="proof-table" border="0" cellspacing="0" cellpadding="0">
	<tr>
	  <td width="36"><img src="/cnxml/0.3.5/style/netscape4/spacer.gif" width="36" height="1"/></td>
	  <td class="proof" width="100%">
	    <div class='proof'>
	      <xsl:choose>
		<xsl:when test="child::*[position()=1 and local-name()='name']">
		  <span class="proofbefore">PROOF: </span>
		  <span class="proofname"><xsl:value-of
							select="cnx:name"/></span>
		</xsl:when>
		<xsl:otherwise>
		  <span class="proofbefore">PROOF: </span>
		</xsl:otherwise>
	      </xsl:choose>
	      <xsl:apply-templates/>
	    </div>
	  </td>
	</tr>
      </table>
    </div>	
  </xsl:template>

  <!--RULE-->
  <xsl:template match="cnx:rule">
    <div class='rule' type='{@type}'>
      <span class="rulebefore"><xsl:value-of select="translate(@type, $lower, $upper)"/>: </span>
      <xsl:if test="child::*[position()=1 and local-name()='name']">
	<span class='rulename'><xsl:value-of select="cnx:name"/></span>
      </xsl:if>
      <xsl:apply-templates/>
    </div>
  </xsl:template>

  <!--RULE's STATEMENT-->
  <xsl:template match="cnx:rule/cnx:statement">
    <div class="statement-table">
      <table class="statement-table" border="0" cellspacing="0" cellpadding="0">
	<tr>
	  <td width="36"><img src="/cnxml/0.3.5/style/netscape4/spacer.gif" width="36" height="1" /></td>
	  <td class="statement">
	    <div class='statement'>
	      <xsl:apply-templates/>
	    </div>	
	  </td>
	</tr>
      </table>
    </div>
  </xsl:template>

<!--RULE's EXAMPLE-->
<!--
  <xsl:template match="cnx:rule/cnx:example">
    <div class='example'>
      <xsl:choose>
	<xsl:when test="child::*[position()=1 and
	  local-name()='name']">
	  <span class="examplebefore">EXAMPLE: </span>
	  <span class="examplename"><xsl:value-of
	  select="cnx:name"/></span>
	</xsl:when>
	<xsl:otherwise>
	  <span class="examplebefore">EXAMPLE: </span>
	</xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates/>
    </div>
  </xsl:template>
-->

  <!--PROBLEM-->
  <xsl:template match="cnx:problem">
    <div class="problem">
      <span class="problembefore">EXERCISE
	<xsl:number level="any" count="cnx:exercise"/>:
      </span>
      <xsl:apply-templates />
    </div>
  </xsl:template>

  <!--SOLUTION-->
  <xsl:template match="cnx:solution">
    <div class="button" onclick="showSolution('{../@id}')">
      <span class="buttontext">Click for Solution</span>
    </div>   
    <div class="solution">   <!--onclick="hideSolution('{@id}')"-->
      <span class="solutionbefore">SOLUTION: </span>
      <xsl:apply-templates />
    </div>
                            
  </xsl:template>

<!-- CALS TABLE -->
  <xsl:template match="cnx:table">
    <div class="cals-table">
      <span class="tablename"><xsl:value-of select="cnx:name" /></span>
      <xsl:apply-templates />
    </div>
  </xsl:template>
  
  
  <!-- NOTE -->
  
  <xsl:template match="cnx:note">
	<div class="note-table">
	  <table class="note-table" border="0" cellspacing="0" cellpadding="0">
	    <tr>
	      <td width="36"><img src="/cnxml/0.3.5/style/netscape4/spacer.gif" width="36" height="1" /></td>
	      <td>
		<table class="note" border="1" cellspacing="0" cellpadding="5" width="100%">
		  <tr>
		    <td class="note">
		      <div class="note">
		    <xsl:choose>
		      <xsl:when test="@type = ''">		      
			<xsl:attribute name="title">
			  <xsl:value-of select="@type"/>
			</xsl:attribute>
			<span class="notewithouttypebefore">NOTE: </span> 
			<xsl:apply-templates/> 
		      </xsl:when>
		      <xsl:otherwise>
			<xsl:attribute name="title">
			  <xsl:value-of select="@type"/>
			</xsl:attribute>
			<span class="notebefore"><xsl:value-of select="translate(@type, $lower, $upper)"/>: </span>
			<xsl:apply-templates/>
		      </xsl:otherwise>
		    </xsl:choose>
		      </div>
		    </td>
		  </tr>
		</table>
	      </td>
	      <td width="36"></td>
	    </tr>
	  </table>
        </div>
</xsl:template>


  <!-- NOTE inside LIST ITEM -->
  
  <xsl:template match="cnx:item/cnx:note">
    <div class="note-table">
      <table class="note-table" border="1" cellspacing="0" cellpadding="5">
	<tr>
	  <td class="note">
	    <div class="note">
	      <xsl:choose>
		<xsl:when test="@type = ''">		      
		  <xsl:attribute name="title">
		    <xsl:value-of select="@type"/>
		  </xsl:attribute>
		  <span class="notewithouttypebefore">NOTE: </span> 
		  <xsl:apply-templates/> 
		</xsl:when>
		<xsl:otherwise>
		  <xsl:attribute name="title">
		    <xsl:value-of select="@type"/>
		  </xsl:attribute>
		  <span class="notebefore"><xsl:value-of select="translate(@type, $lower, $upper)"/>: </span>
		  <xsl:apply-templates/>
		</xsl:otherwise>
	      </xsl:choose>
	    </div>
	  </td>
	</tr>
      </table>
    </div>
  </xsl:template>
  

      
<!--
      <xsl:otherwise>
	<div class="note-table">
	  <table class="note-table" border="0" cellspacing="0" cellpadding="0">
	    <tr>
	      <td width="36"></td>
	      <td>
		<table class="note" border="1" cellspacing="0" cellpadding="5" width="100%">
		  <tr>
		    <td class="note">
		      <div class="note">
			<xsl:attribute name="title">
			  <xsl:value-of select="@type"/>
			</xsl:attribute>
			<span class="notebefore"><xsl:value-of select="translate(@type, $lower, $upper)"/>: </span>
			<xsl:apply-templates/>
		      </div>
		    </td>
		  </tr>
		</table>
	      </td>
	      <td width="36"></td>
	    </tr>
	  </table>
        </div>
      </xsl:otherwise>
      
    </xsl:choose>
  </xsl:template>
-->  

  <!-- FOOTNOTE -->
  <xsl:template match="cnx:note[@type='footnote']">
    <xsl:variable name="footnote-number">
      <xsl:number level="any" count="//cnx:note[@type='footnote']" format="1" />
    </xsl:variable>
    <a class="footnote-reference" href="#footnote{$footnote-number}">
      <xsl:value-of select="$footnote-number" />
    </a>
  </xsl:template>


  <!-- EQUATION -->
  <xsl:template match="cnx:equation">
    <!--do something with the para because eqn can go in paras-->
    <a name="{@id}">
      <div class="equationtable">
	<table class="equation" width="100%" cellspacing="0" cellpadding="0" border="0">
	  <xsl:choose>
	    <xsl:when test="cnx:name">
	      <tr>  
		<td class="name"> <xsl:value-of select="cnx:name/text()" /> </td> 
		<td></td>
	      </tr>
	      <tr>
		<td class="equation">
		  <div class="equation">
		    <a class="equation" href="#nomathml">Math display error.  See note.</a>
		  </div>
		</td>  
		<td width="15" align="right">
		  <span class="equationnumber">
		    <xsl:number level="any" count="cnx:equation" format="(1)"/>
		  </span>
		</td>
	      </tr>
	    </xsl:when>
	    <xsl:otherwise>
	      <tr>
		<td class="equation">
		  <div class="equation">
		    <a class="equation" href="#nomathml">Math display error.  See note.</a>
		  </div>
		</td>  
		<td width="15" align="right">
		  <span class="equationnumber">
		    <xsl:number level="any" count="cnx:equation" format="(1)"/>
		  </span>
		</td>
	      </tr>
	    </xsl:otherwise>
	  </xsl:choose>
	</table>
      </div>
    </a>
  </xsl:template>
  
  <!-- MATH -->
  <xsl:template match="//m:math">
    <span class="nomathml">
      [<a class="nomathml" href="#nomathml">Math display error.  See note.</a>]
    </span>
  </xsl:template>


  <!-- FIGURE and SUBFIGURES -->

  <!-- This template added to resolves problem with corecnxml.xsl, which was putting a <br> tag after subfigures' captions -->
  <xsl:template match="cnx:subfigure/cnx:caption">
    <xsl:apply-templates />
  </xsl:template>

  <xsl:template match="cnx:figure">	
    
    <a name="{@id}" />
    <div class="figuretable" id="{@id}">
      <table class="figure" width="50%" border="0" cellspacing="8" cellpadding="0">
	
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
		  <td class="figurename" colspan="{$subfigure-quantity}">
		    <span class="figurename">
		      <span class="figurenamebefore">
			FIGURE <xsl:number level="any" count="cnx:figure" /><xsl:if test="cnx:name">: </xsl:if>
		      </span>
		      <xsl:value-of select="cnx:name"/>
		    </span>
		  </td>
		</tr>
		<tr>
		  <td class="figure-line" height="1" colspan="{$subfigure-quantity}">
		    <img src="/cnxml/0.3.5/style/netscape4/spacer.gif" height="1" />
		  </td>
		</tr>
		<tr>
		  <xsl:for-each select="cnx:subfigure">
		    <td class="subfigurename" valign="bottom">
		      <span class="subfigurename">
			<span class="subfigurename-before">
			  SUBFIGURE <xsl:number level="any" count="cnx:figure" />.<xsl:number count="cnx:subfigure" /><xsl:if test="cnx:name">: </xsl:if>
			</span>
			<xsl:value-of select="cnx:name" />
		      </span>
		    </td>
		  </xsl:for-each>
		</tr>
		<tr>
		  <xsl:for-each select="cnx:subfigure">
		    <td class="subfigure">
		      <div class="subfigure" id="{@id}">
			<xsl:apply-templates select="cnx:media|cnx:table|cnx:codeblock" />
		      </div>
		    </td>
		  </xsl:for-each>
		</tr>
		<tr>
		  <xsl:for-each select="cnx:subfigure">
		    <td class="subfigure-caption" valign="top">
		      <xsl:if test="cnx:caption">
			<span class="subfigure-caption">
			  <span class="subfigure-captionbefore">Subfigure <xsl:number level="any" count="cnx:figure" />.<xsl:number count="cnx:subfigure"/>: </span><xsl:apply-templates select="cnx:caption"/>
			</span>
		      </xsl:if>
		    </td>
		  </xsl:for-each>
		</tr>
		<xsl:if test="cnx:caption">
		  <tr>
		    <td class="caption-line" height="1" colspan="{$subfigure-quantity}">
		      <img src="/cnxml/0.3.5/style/netscape4/spacer.gif" height="1" />
		    </td>
		  </tr>
		  <tr>
		    <td class="caption" colspan="{$subfigure-quantity}">
		      <span class="caption">
			<span class="captionbefore">Figure <xsl:number level="any" count="cnx:figure" />: </span> <xsl:apply-templates select="cnx:caption" />
		      </span>
		    </td>
		  </tr>
		</xsl:if>
	      </xsl:when>
	      
	      <!-- How to treat the figure that has VERTICAL SUBFIGURES -->
	      <xsl:when test="$orient='vertical'">
		<tr>
		  <td class="figurename">
		    <span class="figurename">
		      <span class="figurenamebefore">
			FIGURE <xsl:number level="any" count="cnx:figure" /><xsl:if test="cnx:name">: </xsl:if>
		      </span>
		      <xsl:value-of select="cnx:name"/>
		    </span>
		  </td>
		</tr>
		<tr>
		  <td class="figure-line" height="1">
		    <img src="/cnxml/0.3.5/style/netscape4/spacer.gif" height="1" />
		  </td>
		</tr>
		<xsl:for-each select="cnx:subfigure">
		  <tr>
		    <td class="subfigurename">
		      <span class="subfigurename">
			<span class="subfigurename-before">
			  SUBFIGURE <xsl:number level="any" count="cnx:figure" />.<xsl:number count="cnx:subfigure" /><xsl:if test="cnx:name">: </xsl:if>
			</span>
			<xsl:value-of select="cnx:name" />
		      </span>
		    </td>
		  </tr>
		  <tr>
		    <td class="subfigure">
		      <div class="subfigure" id="{@id}">
			<xsl:apply-templates select="cnx:media|cnx:table|cnx:codeblock" />
		      </div>
		    </td>
		  </tr>
		  <xsl:if test="cnx:caption">
		    <tr>
		      <td class="subfigure-caption">
			<span class="vertical-subfigure-caption">
			  <span class="subfigure-captionbefore">Subfigure <xsl:number level="any" count="cnx:figure" />.<xsl:number count="cnx:subfigure" />: </span> <xsl:apply-templates select="cnx:caption"/>
			</span>
		      </td>
		    </tr>
		  </xsl:if>
		</xsl:for-each>
		<xsl:if test="cnx:caption">
		  <tr>
		    <td class="caption-line" height="1">
		      <img src="/cnxml/0.3.5/style/netscape4/spacer.gif" height="1" />
		    </td>
		  </tr>
		  <tr>
		    <td class="caption">
		      <span class="caption">
			<span class="captionbefore">Figure <xsl:number level="any" count="cnx:figure" />: </span> <xsl:apply-templates select="cnx:caption" />
		      </span>
		    </td>
		  </tr>
		</xsl:if>
	      </xsl:when>
	    </xsl:choose>
	  </xsl:when>
	  
	  <xsl:otherwise>
	    <!--The case when there are NO SUBFIGURES.-->
	    <tr>
	      <td class="figurename">
		<span class="figurename">
		  <span class="figurenamebefore">
		    FIGURE <xsl:number level="any" count="cnx:figure" /><xsl:if test="cnx:name">: </xsl:if>
		  </span>
		  <xsl:value-of select="cnx:name"/>
		</span>
	      </td>
	    </tr>
	      <tr>
		<td class="caption-line" height="1">
		  <img src="/cnxml/0.3.5/style/netscape4/spacer.gif" height="1" />
		</td>
	      </tr>

	    <tr>
	      <td class="figure">
		<div class="figure" id="{@id}">
		  <xsl:apply-templates select="cnx:media|cnx:table|cnx:codeblock"/>
		</div>
	      </td>
	    </tr>
	    
	    <xsl:if test="cnx:caption">
	      <tr>
		<td class="caption-line" height="1">
		  <img src="/cnxml/0.3.5/style/netscape4/spacer.gif" height="1" />
		</td>
	      </tr>
	      <tr>
		<td class="caption">
		  <span class="caption">
		    <span class="captionbefore">Figure <xsl:number level="any" count="cnx:figure" />: </span> <xsl:apply-templates select="cnx:caption" />
		  </span>
		</td>
	      </tr>
	    </xsl:if>
	    
	  </xsl:otherwise>	    
	</xsl:choose>
	
      </table>
    </div>
    
  </xsl:template>
  
  
  
</xsl:stylesheet>





<!-- OBSOLETE STUFF, BUT THAT I WANT TO KEEP AROUND, IS BELOW -->

<!-- HOW I DID THAT ONE THING -->
<!--
  <xsl:template match="//cnx:authorlist">
    <xsl:variable name="author-quantity" select="count(//cnx:author)" />
    <div class="authorlist">
      <table border="0" cellspacing="0" cellpadding="0">
	<tr>
	  <td rowspan="{$author-quantity}" class="authorlistbefore" valign="top">
	    <span class="authorlistbefore">Written By: </span>
	  </td>
          <td class="author">
	    <xsl:apply-templates select="//cnx:author[position()=1]" />
	  </td>
	</tr>
	<xsl:for-each select="//cnx:author[position()!=1]">
	  <tr>
	    <td class="author">
	      <xsl:apply-templates />
	    </td>
	  </tr>
	</xsl:for-each>
      </table>
    </div>
  </xsl:template>
-->

<!-- HOW I STRIPPED OUT THE WHITESPACE IN CODEBLOCK (UNSUCCESFULLY)-->
<!--
  <xsl:template match="cnx:codeblock">
    <pre><xsl:value-of select="normalize-space(.)" /></pre>
  </xsl:template>   
-->
