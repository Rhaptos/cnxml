<?xml version= "1.0" standalone="no"?>

<xsl:stylesheet version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:cnx="http://cnx.rice.edu/cnxml/0.4"
  xmlns="http://www.w3.org/1999/xhtml">
  <!-- Root Node -->
  <xsl:template match="/">
    
    <html>
      <head>

	<link rel="stylesheet" title="Default" type="text/css"
	  href="/cnxml/0.4/style/xhtml_max.css"/>

	<link rel="stylesheet" title="Default" type="text/css"
	  href="/cnxml/0.4/style/spec.css" />
	
	<link rel="alternate stylesheet" title="Style" type="text/css" 
	  href="/cnxml/0.4/style/xhtml_bw.css"/>
	
	<!--MODULE's NAME-->
	<title><xsl:value-of select="/cnx:module/cnx:name"/></title>
	
	<!-- Javascript for table of contents -->
	<script language="javascript" src="/cnxml/0.4/scripts/spec.js"/>
      </head>	
      <xsl:apply-templates />
    </html>
  </xsl:template>
  
  <!-- Header and Body for the Module -->
  <xsl:template match="cnx:module">
    <body>
      <h1><span class="name-box"><xsl:value-of select="cnx:name"/></span></h1>
      
      <xsl:apply-templates />
      
    </body>
  </xsl:template>

  <!-- METADATA -->
  <xsl:template match="cnx:metadata">
    <div class="metadata">
      <xsl:apply-templates />
      Please send comments and feedback to the <a href="mailto:cnxml@cnx.rice.edu">CNXML Language Team.</a>
    </div>
    <input type="button" value="Toggle ToC" onclick="createToc();"/>
  </xsl:template>

</xsl:stylesheet>
