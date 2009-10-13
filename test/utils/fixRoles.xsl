<?xml version="1.0"?>

<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:col="http://cnx.rice.edu/collxml"
  xmlns:cnxml="http://cnx.rice.edu/cnxml"
  xmlns:cnxorg="http://cnx.rice.edu/system-info"
  xmlns:m="http://www.w3.org/1998/Math/MathML"
  xmlns:md="http://cnx.rice.edu/mdml"
  xmlns:md4="http://cnx.rice.edu/mdml/0.4"
  xmlns:q="http://cnx.rice.edu/qml/1.0"
  xmlns:xhtml="http://www.w3.org/1999/xhtml"
  xmlns:bib="http://bibtexml.sf.net/"
  xmlns:cc="http://web.resource.org/cc/"
  xmlns:cnx="http://cnx.rice.edu/contexts#"
  xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
  xmlns:exsl="http://exslt.org/common"
  extension-element-prefixes="exsl"
>

  <xsl:output indent="yes" method="xml"/>
  <xsl:strip-space elements="*"/>
  <xsl:preserve-space elements="md4:abstract"/>
  <xsl:key name="member-by-userid" match="md4:author|md4:maintainer|md4:licensor|md4:editor|md4:translator" use="@id"/>
  <xsl:variable name="members" select="//md4:author|//md4:maintainer|//md4:licensor|//md4:editor|//md4:translator"/>

  <xsl:template match="node()|@*">
    <xsl:copy>
      <xsl:apply-templates select="node()|@*"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="md4:authorlist">
    <xsl:element name="md:actors" namespace="http://cnx.rice.edu/mdml">
      <xsl:for-each select="$members[generate-id()=generate-id(key('member-by-userid', @id)[1])]">
        <xsl:apply-templates select="." mode="conversion"/>
      </xsl:for-each>
    </xsl:element>
    <xsl:element name="md:roles" namespace="http://cnx.rice.edu/mdml">
      <xsl:element name="md:role">
        <xsl:attribute name="type">author</xsl:attribute>
        <xsl:variable name="userids">
          <xsl:for-each select="md4:author/@id">
            <xsl:value-of select="concat(., ' ')"/>
          </xsl:for-each>
        </xsl:variable>
        <xsl:value-of select="normalize-space($userids)"/>
      </xsl:element>
      <xsl:element name="md:role">
        <xsl:attribute name="type">maintainer</xsl:attribute>
        <xsl:variable name="userids">
          <xsl:for-each select="following-sibling::md4:maintainerlist/md4:maintainer/@id">
            <xsl:value-of select="concat(., ' ')"/>
          </xsl:for-each>
        </xsl:variable>
        <xsl:value-of select="normalize-space($userids)"/>
      </xsl:element>
      <xsl:element name="md:role">
        <xsl:attribute name="type">licensor</xsl:attribute>
        <xsl:variable name="userids">
          <xsl:for-each select="following-sibling::md4:licensorlist/md4:licensor/@id">
            <xsl:value-of select="concat(., ' ')"/>
          </xsl:for-each>
        </xsl:variable>
        <xsl:value-of select="normalize-space($userids)"/>
      </xsl:element>
      <xsl:if test="following-sibling::md4:editorlist">
        <xsl:element name="md:role">
          <xsl:attribute name="type">editor</xsl:attribute>
        <xsl:variable name="userids">
          <xsl:for-each select="following-sibling::md4:editorlist/md4:editor/@id">
            <xsl:value-of select="concat(., ' ')"/>
          </xsl:for-each>
        </xsl:variable>
        <xsl:value-of select="normalize-space($userids)"/>
        </xsl:element>
      </xsl:if>
      <xsl:if test="following-sibling::md4:translatorlist">
        <xsl:element name="md:role">
          <xsl:attribute name="type">translator</xsl:attribute>
        <xsl:variable name="userids">
          <xsl:for-each select="following-sibling::md4:translatorlist/md4:translator/@id">
            <xsl:value-of select="concat(., ' ')"/>
          </xsl:for-each>
        </xsl:variable>
        <xsl:value-of select="normalize-space($userids)"/>
        </xsl:element>
      </xsl:if>
    </xsl:element>
  </xsl:template>

  <xsl:template match="*[self::md4:author or self::md4:maintainer or self::md4:licensor or self::md4:editor or self::md4:translator]" mode="conversion">
    <xsl:element name="md:person">
      <xsl:attribute name="userid">
        <xsl:value-of select="@id"/>
      </xsl:attribute>
      <xsl:apply-templates select="node()"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="*[self::md4:author or self::md4:maintainer or self::md4:licensor or self::md4:editor or self::md4:translator][@id='cnxorg']" mode="conversion">
    <xsl:element name="md:organization">
      <xsl:attribute name="userid">
        <xsl:value-of select="@id"/>
      </xsl:attribute>
      <xsl:apply-templates select="node()"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="md4:*[@id='cnxorg']/md4:firstname">
  </xsl:template>

  <xsl:template match="md4:*[@id='cnxorg']/md4:surname">
    <xsl:element name="md:shortname"><xsl:value-of select="."/></xsl:element>
  </xsl:template>

  <xsl:template match="md4:maintainerlist|md4:licensorlist|md4:editorlist|md4:translatorlist">
  </xsl:template>

</xsl:stylesheet>
