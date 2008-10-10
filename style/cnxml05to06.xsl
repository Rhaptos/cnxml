<?xml version="1.0"?>

<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:cnxml="http://cnx.rice.edu/cnxml"
  xmlns:m="http://www.w3.org/1998/Math/MathML"
  xmlns:md="http://cnx.rice.edu/mdml/0.4"
  xmlns:q="http://cnx.rice.edu/qml/1.0"
  xmlns:xhtml="http://www.w3.org/1999/xhtml"
  xmlns:bib="http://bibtexml.sf.net/"
  xmlns:cc="http://web.resource.org/cc/"
  xmlns:cnx="http://cnx.rice.edu/contexts#"
  xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
  xmlns:exsl="http://exslt.org/common"
  xmlns:reqid="#required-ids"
  extension-element-prefixes="exsl"
  exclude-result-prefixes="cnxml"
>

<!--
  * 'name' becomes 'title'
  * convert cnxn to link
  * convert linking element attributes
  * convert @type=(inline|block) to @display=(inline|block)
  * convert note[@type=footnote] to footnote
  * convert list/@type=named-item to list/@type=labeled-item
  * generate IDs for all of 
    # div
    # section
    # figure
    # subfigure
    # example
    # note
    # footnote
    # problem
    # solution
    # quote[@type='block']
    # code[@type='block']
    # pre[@type='block']
    # media
    # meaning
    # proof 
convert media to new media structures
figure/table and figure/code conversion
table gets @summary
-->

  <reqid:elements>
    <reqid:element name="div"/>
    <reqid:element name="section"/>
    <reqid:element name="figure"/>
    <reqid:element name="subfigure"/>
    <reqid:element name="example"/>
    <reqid:element name="note"/>
    <reqid:element name="footnote"/>
    <reqid:element name="problem"/>
    <reqid:element name="solution"/>
    <reqid:element name="media"/>
    <reqid:element name="meaning"/>
    <reqid:element name="proof "/>
  </reqid:elements>

  <xsl:output indent="yes" method="xml"/>
  <xsl:param name="moduleid"/>
  <xsl:variable name="required-id-elements" select="document('')/xsl:stylesheet/reqid:elements"/>

  <xsl:template match="cnxml:document">
    <xsl:element name="document" namespace="http://cnx.rice.edu/cnxml">
      <xsl:apply-templates select="@*"/>
      <xsl:attribute name="module-id"><xsl:value-of select="$moduleid"/></xsl:attribute>
      <xsl:attribute name="cnxml-version">0.6</xsl:attribute>
      <xsl:apply-templates/>
    </xsl:element>
  </xsl:template>

  <!-- Convert 'name' to 'title'. -->
  <xsl:template match="cnxml:name">
    <xsl:element name="title" namespace="http://cnx.rice.edu/cnxml">
      <xsl:copy-of select="@id"/>
      <xsl:apply-templates/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="@type">
    <xsl:choose>
      <xsl:when test=".='inline'">
        <xsl:attribute name="display">inline</xsl:attribute>
      </xsl:when>
      <xsl:when test=".='block'">
        <xsl:attribute name="display">block</xsl:attribute>
      </xsl:when>
      <xsl:otherwise><xsl:copy/></xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="cnxml:note[@type='footnote']">
    <xsl:element name="footnote" namespace="http://cnx.rice.edu/cnxml">
      <xsl:choose>
        <xsl:when test="@id"><xsl:copy-of select="@id"/></xsl:when>
        <xsl:otherwise>
          <xsl:attribute name="id">
            <xsl:value-of select="generate-id()"/>
          </xsl:attribute>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="cnxml:list/@type">
    <xsl:choose>
      <xsl:when test="starts-with(normalize-space(.), 'bull') or
                      starts-with(normalize-space(.), 'unen') or
                      starts-with(normalize-space(.), 'list') or
                      starts-with(normalize-space(.), 'unor')">
        <xsl:attribute name="list-type">bulleted</xsl:attribute>
      </xsl:when>
      <xsl:when test="starts-with(normalize-space(.), 'enum') or
                      starts-with(normalize-space(.), 'enme') or
                      starts-with(normalize-space(.), 'ennu')">
        <xsl:attribute name="list-type">enumerated</xsl:attribute>
      </xsl:when>
      <xsl:when test="starts-with(normalize-space(.), 'name')">
        <xsl:attribute name="list-type">labeled-item</xsl:attribute>
      </xsl:when>
      <xsl:when test=".='inline'">
        <xsl:attribute name="list-type">labeled-item</xsl:attribute>
        <xsl:attribute name="display">inline</xsl:attribute>
      </xsl:when>
      <xsl:otherwise></xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="generate-id-if-required">
    <xsl:if test="not(@id)">
      <xsl:variable name="element-name" select="name(self::*)"/>
      <xsl:choose>
        <!-- Certain elements now get IDs always. -->
        <xsl:when test="$required-id-elements/reqid:element[@name=$element-name]">
          <xsl:attribute name="id">
            <xsl:value-of select="generate-id()"/>
          </xsl:attribute>
        </xsl:when>
        <!-- Block 'quote', 'pre', and 'code' get IDs always. -->
        <xsl:when test="(name(self::*) = 'quote' or name(self::*) = 'code' or 
                         name(self::*) = 'pre') and self::*[@type='block']">
          <xsl:attribute name="id">
            <xsl:value-of select="generate-id()"/>
          </xsl:attribute>
        </xsl:when>
      </xsl:choose>
    </xsl:if>
  </xsl:template>

  <!--
   Handle these attributes:
   - @document
   - @target-id
   - @resource
   - @version -->
  <xsl:template match="cnxml:link|cnxml:cite|cnxml:term|cnxml:quote">
    <xsl:copy>
      <xsl:apply-templates select="@*[not(name(.)='src')]"/>
      <xsl:call-template name="convert-link-src">
        <xsl:with-param name="src" select="normalize-space(@src)"/>
      </xsl:call-template>
      <xsl:apply-templates/>
    </xsl:copy>
  </xsl:template>

  <xsl:template name="convert-link-src">
    <xsl:param name="src"/>
    <xsl:choose>
      <!-- Empty or absent @src: do nothing. -->
      <xsl:when test="not($src)"></xsl:when>
      <!-- Absolute URL pointing to Connexions object -->
      <xsl:when test="starts-with($src, 'http:') and (
                contains($src, 'cnx.rice.edu') or
                contains($src, 'cnx.org')
                ) and
                contains($src, '/content/') and
                not(contains($src, 'content/browse')) and
                not(contains($src, 'content/search'))">
        <xsl:call-template name="make-link-attributes">
          <xsl:with-param name="attribute-name" select="'document'"/>
          <xsl:with-param name="value" select="substring-after($src, 'content/')"/>
        </xsl:call-template>
      </xsl:when>
      <!-- Relative URL pointing to Connexions object -->
      <xsl:when test="starts-with($src, '/content/') and
                      not(contains($src, '/content/search')) and
                      not(contains($src, '/content/browse'))">
        <xsl:call-template name="make-link-attributes">
          <xsl:with-param name="attribute-name" select="'document'"/>
          <xsl:with-param name="value" select="substring-after($src, 'content/')"/>
        </xsl:call-template>
      </xsl:when>
      <!-- Fragment identifier pointing to element @id -->
      <xsl:when test="starts-with($src, '#')">
        <xsl:call-template name="make-link-attributes">
          <xsl:with-param name="attribute-name" select="'target-id'"/>
          <xsl:with-param name="value" select="$src"/>
        </xsl:call-template>
      </xsl:when>
      <!-- Relative URL pointing to resource inside of a module -->
      <xsl:when test="not(starts-with($src, '/')) and
                      not(starts-with($src, 'http:')) and
                      not(starts-with($src, 'https:')) and
                      not(starts-with($src, 'ftp:')) and
                      not(starts-with($src, 'file:')) and
                      not(starts-with($src, 'mailto:')) and
                      not(starts-with($src, 'matilto:')) and
                      not(starts-with($src, 'mms:')) and
                      not(starts-with($src, 'www.')) and
                      not(starts-with($src, 'okapi.berkeley.edu')) and
                      not(starts-with($src, 'serials.abc-clio.com'))">
        <xsl:call-template name="make-link-attributes">
          <xsl:with-param name="attribute-name" select="'resource'"/>
          <xsl:with-param name="value" select="$src"/>
        </xsl:call-template>
      </xsl:when>
      <!-- URL pointing somewhere outside of the respository -->
      <xsl:otherwise>
        <xsl:attribute name="url"><xsl:value-of select="$src"/></xsl:attribute>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="make-link-attributes">
    <xsl:param name="attribute-name"/>
    <xsl:param name="value"/>
    <xsl:variable name="value-before-slash" select="substring-before($value, '/')"/>
    <xsl:variable name="value-after-slash" select="substring-after($value, '/')"/>
    <xsl:variable name="first">
      <xsl:choose>
        <xsl:when test="$value-before-slash">
          <xsl:value-of select="$value-before-slash"/>
        </xsl:when>
        <xsl:otherwise><xsl:value-of select="$value"/></xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="rest">
      <xsl:if test="$value-after-slash">
        <xsl:value-of select="$value-after-slash"/>
      </xsl:if>
    </xsl:variable>
    <!-- Output an attribute unless its name is 'version' and the value is 'latest'. -->
    <xsl:if test="not($attribute-name = 'version' and $first = 'latest')">
      <xsl:attribute name="{$attribute-name}">
        <xsl:value-of select="$first"/>
      </xsl:attribute>
    </xsl:if>
    <xsl:if test="string-length($rest)">
      <xsl:message>attname: '<xsl:value-of select="$attribute-name"/>', first: '<xsl:value-of select="$first"/>', rest: '<xsl:value-of select="$rest"/>'</xsl:message>
      <xsl:choose>
        <xsl:when test="$attribute-name = 'document'">
          <xsl:call-template name="make-link-attributes">
            <xsl:with-param name="attribute-name" select="'version'"/>
            <xsl:with-param name="value" select="$rest"/>
          </xsl:call-template>
        </xsl:when>
        <xsl:when test="$attribute-name = 'version'">
          <xsl:call-template name="make-link-attributes">
            <xsl:with-param name="attribute-name">
              <xsl:choose>
                <xsl:when test="starts-with($rest, '#')">target-id</xsl:when>
                <xsl:otherwise>resource</xsl:otherwise>
              </xsl:choose>
            </xsl:with-param>
            <xsl:with-param name="value" select="$rest"/>
          </xsl:call-template>
        </xsl:when>
      </xsl:choose>
    </xsl:if>
  </xsl:template>

  <xsl:template match="cnxml:cnxn">
    <xsl:variable name="strength" select="normalize-space(@strength)"/>
    <xsl:element name="link" namespace="http://cnx.rice.edu/cnxml">
      <xsl:if test="normalize-space(@document)">
        <xsl:attribute name="document">
          <xsl:value-of select="normalize-space(@document)"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="normalize-space(@version)">
        <xsl:attribute name="version">
          <xsl:value-of select="normalize-space(@version)"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="normalize-space(@target)">
        <xsl:attribute name="target-id">
          <xsl:value-of select="normalize-space(@target)"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="$strength">
        <xsl:attribute name="strength">
          <xsl:choose>
            <xsl:when test="$strength='9' or $strength='8'">3</xsl:when>
            <xsl:when test="$strength='7' or $strength='6' or
                            $strength='5' or $strength='4'">2</xsl:when>
            <xsl:when test="$strength='3' or $strength='2' or
                            $strength='1' or $strength='0'">1</xsl:when>
          </xsl:choose>
        </xsl:attribute>
      </xsl:if>
      <xsl:apply-templates/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="cnxml:table">
    <xsl:copy>
      <xsl:apply-templates select="@*"/>
      <xsl:call-template name="generate-id-if-required"/>
      <xsl:attribute name="summary"></xsl:attribute>
      <xsl:apply-templates/>
    </xsl:copy>
  </xsl:template>

  <!-- FIXME: this becomes code[@type="listing"] later, or a proper 'media' with children. -->
  <xsl:template match="cnxml:figure/cnxml:code|cnxml:media">
    <media id="{generate-id()}" alt="an image" xmlns="http://cnx.rice.edu/cnxml">
      <xsl:if test="parent::cnxml:content or parent::cnxml:section">
        <xsl:attribute name="display">block</xsl:attribute>
      </xsl:if>
      <image src="foo.png" mimetype="image/png"/>
    </media>
  </xsl:template>

  <xsl:template match="/">
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="*">
    <xsl:copy>
      <xsl:apply-templates select="@*"/>
      <xsl:call-template name="generate-id-if-required"/>
      <xsl:apply-templates/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="@*|text()|comment()|processing-instruction()">
    <xsl:copy/>
  </xsl:template>

</xsl:stylesheet>
