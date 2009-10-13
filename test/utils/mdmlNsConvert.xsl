<?xml version="1.0"?>

<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:col="http://cnx.rice.edu/collxml"
  xmlns:cnxml="http://cnx.rice.edu/cnxml"
  xmlns:cnxorg="http://cnx.rice.edu/system-info"
  xmlns:m="http://www.w3.org/1998/Math/MathML"
  xmlns:md4="http://cnx.rice.edu/mdml/0.4"
  xmlns:md="http://cnx.rice.edu/mdml"
  xmlns:q="http://cnx.rice.edu/qml/1.0"
  xmlns:xhtml="http://www.w3.org/1999/xhtml"
  xmlns:bib="http://bibtexml.sf.net/"
  xmlns:cc="http://web.resource.org/cc/"
  xmlns:cnx="http://cnx.rice.edu/contexts#"
  xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
  xmlns:exsl="http://exslt.org/common"
  xmlns:str="http://exslt.org/strings"
  extension-element-prefixes="exsl str"
>

  <xsl:output indent="yes" method="xml"/>
  <xsl:strip-space elements="*"/>
  <xsl:preserve-space elements="md:abstract"/>

  <xsl:template match="col:collection">
    <collection xmlns="http://cnx.rice.edu/collxml"
                xmlns:cnx="http://cnx.rice.edu/cnxml"
                xmlns:cnxorg="http://cnx.rice.edu/system-info"
                xmlns:md4="http://cnx.rice.edu/mdml/0.4"
                xmlns:md="http://cnx.rice.edu/mdml"
                xmlns:f00="http://foo.com"
                xmlns:col="http://cnx.rice.edu/collxml"
                xmlns:cnxml="http://cnx.rice.edu/cnxml"
                xmlns:m="http://www.w3.org/1998/Math/MathML"
                xmlns:q="http://cnx.rice.edu/qml/1.0"
                xmlns:xhtml="http://www.w3.org/1999/xhtml"
                xmlns:bib="http://bibtexml.sf.net/"
                xmlns:cc="http://web.resource.org/cc/"
                xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
      <xsl:apply-templates select="node()|@*"/>
    </collection>
  </xsl:template>

  <xsl:template match="md4:*">
    <xsl:element name="md:{local-name(.)}" namespace="http://cnx.rice.edu/mdml">
      <xsl:apply-templates select="node()|@*"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="node()|@*">
    <xsl:copy>
      <xsl:apply-templates select="node()|@*"/>
    </xsl:copy>
  </xsl:template>

</xsl:stylesheet>
