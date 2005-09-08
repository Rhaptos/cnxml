<?xml version= "1.0" standalone="no"?>

<!-- header for mozilla -->

<xsl:stylesheet version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:cnx="http://cnx.rice.edu/cnxml/0.3.5"
  xmlns="http://www.w3.org/1999/xhtml">

  <xsl:param name="viewmath" select="0" />
  <xsl:param name="baseurl" select="''" />

 <!-- Root Node -->
  <xsl:template match="/">
    <html>
      <head>
	<xsl:if test='$baseurl'>
	  <base href='{$baseurl}' />
	</xsl:if>
	<link rel="stylesheet" title="Connexions Default" type="text/css" href="/cnxml/0.3.5/style/mozilla/max.css"/>
	<xsl:if test="$toc">
	  <link rel="stylesheet" title="Connexions Default" type="text/css" href="/cnxml/0.3.5/style/spec.css" />
	</xsl:if>
	
	<link rel="alternate stylesheet" title="Black and White" type="text/css" href="/cnxml/0.3.5/style/mozilla/bw.css"/>

	<!--MODULE's NAME-->
        <title><xsl:value-of select="cnx:module/cnx:name"/></title>
        
	<!--	Javascript so that answer can appear on click.	-->
	<script language="javascript" src="/cnxml/0.3.5/scripts/exercise.js" />
	<script language="javascript" src="/qml/1.0/scripts/qml_1-0.js" />
	<xsl:if test="$viewmath">
	  <script type="text/javascript" src="/cnxml/0.3.5/scripts/viewmath.js" />
	  <script type="text/javascript" src="/cnxml/0.3.5/scripts/entity.js" />
	</xsl:if>
	<xsl:if test="$toc">
	  <script language="javascript" src="/cnxml/0.3.5/scripts/toc.js" />
	</xsl:if>

	<!-- ****QML**** sets the feedback and hints to non-visible. -->
	<style type="text/css">
	  .feedback {display:none}
	  .hint {display:none}
	</style>

      </head>	
      <xsl:apply-templates />

    </html>
  </xsl:template>

  <!-- METADATA -->
  <xsl:template match="cnx:metadata">
    <div class="metadata">
      <xsl:apply-templates />
    </div>
    <xsl:if test="$toc">
      <input type="button" value="View/Hide Table of Contents" onclick="toggleToc();"/>
	
    </xsl:if>
  </xsl:template>

  <!--SOLUTION-->
  <xsl:template match="cnx:solution">
    <div class="button" onclick="showSolution('{../@id}')">
      <span class="buttontext">Click for Solution</span>
    </div>
    <div class="solution" onclick="hideSolution('{../@id}')">
      <xsl:attribute name="number">
        <xsl:number level="any" count="cnx:solution" />
      </xsl:attribute>
      <xsl:apply-templates />
      <div class="button">
        <span class="buttontext">Hide Solution</span> 
      </div>
    </div>
  </xsl:template>

  <!-- PROBLEM numbering -->
  <xsl:template match="cnx:problem">
    <div class="problem">
      <xsl:attribute name="number">
	<xsl:number level="any" count="cnx:problem" />
      </xsl:attribute>
      <xsl:apply-templates />
    </div>
  </xsl:template>

  <!-- RULE numbering -->
  <xsl:template match="cnx:rule">
    <xsl:variable name="type" select="@type"/>
    <div class="rule" id="{@id}" type="{@type}">
      <xsl:attribute name="number">
        <xsl:number level="any" count="cnx:rule[@type=$type]"/>
      </xsl:attribute>
      <xsl:if test="child::*[position()=1 and local-name()='name']">
	<span class='rulename'><xsl:value-of select="cnx:name"/></span>
      </xsl:if>
      <xsl:apply-templates />
    </div>
  </xsl:template>
    
  <!-- EXAMPLE numbering -->
  <xsl:template match="cnx:example[not(parent::cnx:definition|parent::cnx:rule)]">
    <div class="example" id="{@id}">
      <xsl:attribute name="number">
        <xsl:number level="any" count="cnx:example[not(parent::cnx:definition|parent::cnx:rule)]"/>
      </xsl:attribute>
      <xsl:if test="child::*[position()=1 and local-name()='name']">
        <span class="examplename"><xsl:value-of select="cnx:name"/>  </span>
      </xsl:if>
      <xsl:apply-templates />
    </div>
  </xsl:template>
    
  <!-- DEFINITION numbering -->
  <xsl:template match="cnx:definition">
    <div class="definition" id="{@id}">
        <xsl:attribute name="number">
          <xsl:number level="any" count="cnx:definition"/>
        </xsl:attribute>
      <xsl:apply-templates />
    </div>
  </xsl:template>

  <!-- TERM -->
  <xsl:template match="cnx:term">
    <span class="term">
      <xsl:apply-templates />
    </span>
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
                  
    <a class="figure" name="{@id}" />
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
                    <span class="name">
                      <xsl:value-of select="cnx:name"/>
                    </span>
                  </td>
                </tr>
                <tr>
                  <xsl:for-each select="cnx:subfigure">
                    <td valign="bottom">
                      <span class="subfigure-name">
                        <xsl:value-of select="cnx:name" />
                      </span>
                    </td>
                  </xsl:for-each>
                </tr>
                <tr>
                  <xsl:for-each select="cnx:subfigure">
                    <td align="center" valign="middle">
		      <a class="subfigure" name="{@id}" />
                      <div class="subfigure">
			<xsl:if test="@id">
			  <xsl:attribute name="id"><xsl:value-of select="@id" /></xsl:attribute>
			</xsl:if>
                        <xsl:apply-templates select="cnx:media|cnx:table|cnx:codeblock" />
                      </div>
                    </td>
                  </xsl:for-each>
                </tr>
                <tr>
                  <xsl:for-each select="cnx:subfigure">
                    <td valign="top" class="horizontal">
		      <div class="caption">
			<span class="caption-before">
			  Subfigure <xsl:number level="any" count="cnx:figure" />.<xsl:number level="single" count="cnx:subfigure" /><xsl:if test="cnx:caption">: </xsl:if>
			</span>
			<xsl:apply-templates select="cnx:caption" />
		      </div>
                    </td>
                  </xsl:for-each>
                </tr>
                  <tr>
                    <td colspan="{$subfigure-quantity}">
		      <div class="caption">   
			<span class="caption-before">
			  Figure <xsl:number level="any" count="cnx:figure" /><xsl:if test="cnx:caption">: </xsl:if>
			</span>
			<xsl:apply-templates select="cnx:caption" />
		      </div>
                    </td>
                  </tr>  
              </xsl:when>
                    
              <!-- How to treat the figure that has VERTICAL SUBFIGURES -->
              <xsl:when test="$orient='vertical'">
                <tr>
                  <td>
                    <span class="name">
                      <xsl:value-of select="cnx:name"/>
                    </span>
                  </td>  
                </tr>
                <xsl:for-each select="cnx:subfigure">
                  <tr>
                    <td>
                      <span class="subfigure-name">
                        <xsl:value-of select="cnx:name" />
                      </span>
                    </td>
                  </tr>  
                  <tr>  
                    <td align="center">
		      <a class="subfigure" name="{@id}" />
                      <div class="subfigure">
			<xsl:if test="@id">
			  <xsl:attribute name="id"><xsl:value-of select="@id" /></xsl:attribute>
			</xsl:if>
                        <xsl:apply-templates select="cnx:media|cnx:table|cnx:codeblock" />
                      </div>
                    </td>
                  </tr>
                  <tr>
                    <td class="vertical">
		      <div class="caption">
			<span class="caption-before">
			  Subfigure <xsl:number level="any" count="cnx:figure" />.<xsl:number level="single" count="cnx:subfigure" /><xsl:if test="cnx:caption">: </xsl:if>
			</span>
			<xsl:apply-templates select="cnx:caption" />
		      </div>
                    </td>
                  </tr>
                </xsl:for-each>
                <tr>  
                  <td>
		    <div class="caption">   
		      <span class="caption-before">
			Figure <xsl:number level="any" count="cnx:figure" /><xsl:if test="cnx:caption">: </xsl:if>
		      </span>
		      <xsl:apply-templates select="cnx:caption" />
		    </div>
                  </td>
                </tr>
              </xsl:when>
            </xsl:choose>
          </xsl:when>
    
          <xsl:otherwise>
            <!--The case when there are NO SUBFIGURES.-->
            <tr>
              <td>
                <span class="name">
                  <xsl:value-of select="cnx:name"/>
                </span>
              </td>
            </tr>
            <tr>
              <td align="center">
                <div class="figure" id="{@id}">
                  <xsl:apply-templates select="cnx:media|cnx:table|cnx:codeblock"/>
                </div>
              </td>
            </tr>
              <tr>
                <td>
		  <div class="caption">
		    <span class="caption-before">
		      Figure <xsl:number level="any" count="cnx:figure" /><xsl:if test="cnx:caption">: </xsl:if>
		    </span>
		    <xsl:apply-templates select="cnx:caption" />
		  </div>
                </td>
              </tr>
                
          </xsl:otherwise>
        </xsl:choose>  
              
      </table>   
    </div>
              
  </xsl:template>


</xsl:stylesheet>
