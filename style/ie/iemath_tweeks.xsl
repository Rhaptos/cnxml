<?xml version= "1.0" standalone="no"?>

<xsl:stylesheet version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:cnx="http://cnx.rice.edu/cnxml/0.3.5"
  xmlns:m="http://www.w3.org/1998/Math/MathML"
  xmlns="http://www.w3.org/1999/xhtml">
  

  <!-- Root Node -->
  <xsl:template match="/">
    <!-- only difference between no math and math -->
    <xsl:processing-instruction name="xml-stylesheet">
      <xsl:text>type="text/xsl" href="/cnxml/0.3.5/style/w3/mathml.xsl"</xsl:text>
    </xsl:processing-instruction>
    <!-- does not include the multiple stylesheet info here -->

    <html xmlns:pref="http://www.w3.org/2002/Math/preference" 
          pref:renderer="mathplayer-dl">
      <head>

        <script language="javascript" src="/cnxml/0.3.5/scripts/ie-exercise.js" />
        <script language="javascript" src="/qml/1.0/scripts/qml_1-0.js" />

        <!-- ****QML**** sets the feedback and hints to non-visible. -->
        <style type="text/css">
          .feedback {display:none}
          .hint {display:none}
        </style>
	
	<link rel="stylesheet" title="Default" type="text/css" href="/cnxml/0.3.5/style/ie/max.css" />
	
	<!--MODULE's NAME-->
        <title><xsl:value-of select="cnx:module/cnx:name"/></title>
      </head>	
      <xsl:apply-templates />
    </html>
  </xsl:template>

  <!-- Always force display to block.  Enclose in <p> when block requested -->
  <xsl:template match="m:math">
    <xsl:choose>
      <xsl:when test="@display='block' or parent::*[local-name()='equation']">
	<p>
	  <m:math display="block">
	    <xsl:apply-templates/>
	  </m:math>
	</p>
      </xsl:when>
      <xsl:otherwise>
	<span class="math">
	  <m:math display="inline">
	    <xsl:apply-templates/>
	  </m:math>
	</span>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!--EQUATION-->
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
      <div class="equation-math">
	<xsl:apply-templates select="*[not(self::cnx:name)]" />
      </div>
    </div>
  </xsl:template>

</xsl:stylesheet>








