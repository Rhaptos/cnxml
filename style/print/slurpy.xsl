<?xml version="1.0"?>
<xsl:stylesheet version='1.0'
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:cnx='http://cnx.rice.edu/cnxml/0.2'
		xmlns:cnxml="http://cnx.rice.edu/cnxml/0.3"
		xmlns="http://www.w3.org/1999/xhtml">
<!--This stylesheet is a proof of concept.  The concept is that you can pull in
multiple modules into a separate file (i.e. a course file).  

Run:
saxon -o new241out.xml new241.xml slurpy.xsl

new241.xml has the cnx namespace.
The modules have the namespace cnxml.

-->
  
  <xsl:template match="/">
    <xsl:apply-templates/>
  </xsl:template>
  
  
  <xsl:template match="cnx:course/cnx:mainpath">
    <xsl:for-each select="cnx:chapter">
CHAPTER: <xsl:value-of select="cnx:name"/>
      <xsl:for-each select="cnx:module">
	<xsl:for-each select="document(concat('http://cnx.rice.edu/cgi-bin/showmodule.cgi?id=',@cnxid, '/index.cnxml'))">
<!--	  <xsl:value-of select="cnxml:module/cnxml:name"/>
	  <xsl:text>
	    </xsl:text>
	-->    <xsl:apply-templates select="cnxml:module"/>
<xsl:text>
	    </xsl:text>
	</xsl:for-each>
      </xsl:for-each>
    </xsl:for-each>
  </xsl:template>

  <xsl:template match="cnxml:module">
    <xsl:apply-templates select="cnxml:name"/>
  </xsl:template>

  <xsl:template match="cnxml:name">
    MODULE:  <xsl:value-of select='.'/>
  </xsl:template>
 
</xsl:stylesheet>

