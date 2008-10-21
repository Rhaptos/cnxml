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
  xmlns:mc="#media-conversions"
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
    # statement
convert media to new media structures
  * figure/table 
  * figure/code
  * table gets @summary
-->

  <xsl:output indent="yes" method="xml"/>
  <xsl:param name="moduleid"/>
  <xsl:variable name="required-id-elements" select="document('')/xsl:stylesheet/reqid:elements"/>
  <xsl:variable name="media-conversions" select="document('')/xsl:stylesheet/mc:mediaconversions"/>

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
      <xsl:apply-templates select="@*[not(name(.)='src') and not(name(.)='id')]"/>
      <xsl:call-template name="convert-link-src">
        <xsl:with-param name="src" select="normalize-space(@src)"/>
      </xsl:call-template>
      <xsl:call-template name="generate-id-if-required"/>
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
      <xsl:if test="@document">
        <xsl:attribute name="document">
          <xsl:value-of select="normalize-space(@document)"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="@version">
        <xsl:attribute name="version">
          <xsl:value-of select="normalize-space(@version)"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="@target">
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
    <xsl:param name="figure-id"/>
    <xsl:copy>
      <xsl:apply-templates select="@*[name(.)!='id']"/>
      <xsl:attribute name="id">
        <xsl:choose>
          <xsl:when test="string-length($figure-id)">
              <xsl:value-of select="$figure-id"/>
          </xsl:when>
          <xsl:when test="string-length(@id)">
            <xsl:value-of select="@id"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="generate-id()"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:attribute>
      <xsl:attribute name="summary"></xsl:attribute>
      <xsl:apply-templates/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="cnxml:figure[cnxml:table]">
    <xsl:if test="@id">
      <xsl:processing-instruction name="figure-id">
        <xsl:value-of select="@id"/>
      </xsl:processing-instruction>
    </xsl:if>
    <xsl:apply-templates select="cnxml:table">
      <xsl:with-param name="figure-id">
        <!-- m16333 is the one module in which cnxns pointing to a table 
             within a figure use the table @id rather than the figure @id. 
             In this case, we don't pass figure/@id down to the table 
             template. -->
        <xsl:if test="$moduleid != 'm16333'">
          <xsl:value-of select="@id"/>
        </xsl:if>
      </xsl:with-param>
    </xsl:apply-templates>
  </xsl:template>

  <xsl:template match="cnxml:figure[cnxml:code]">
    <xsl:apply-templates select="cnxml:code"/>
  </xsl:template>

  <xsl:template match="cnxml:code">
    <xsl:copy>
      <xsl:apply-templates select="@*[name()!='id']"/>
      <xsl:attribute name="id">
        <xsl:choose>
          <xsl:when test="parent::cnxml:figure">
            <xsl:value-of select="parent::cnxml:figure/@id"/>
          </xsl:when>
          <xsl:when test="string-length(@id)">
            <xsl:value-of select="@id"/>
          </xsl:when>
          <xsl:otherwise><xsl:value-of select="generate-id()"/></xsl:otherwise>
        </xsl:choose>
      </xsl:attribute>
      <xsl:if test="parent::cnxml:figure">
        <xsl:attribute name="class">listing</xsl:attribute>
        <xsl:if test="preceding-sibling::cnxml:name">
          <xsl:apply-templates select="preceding-sibling::cnxml:name"/>
        </xsl:if>
      </xsl:if>
      <xsl:apply-templates/>
      <xsl:if test="parent::cnxml:figure and following-sibling::cnxml:caption">
        <xsl:apply-templates select="following-sibling::cnxml:caption"/>
      </xsl:if>
    </xsl:copy>
  </xsl:template>

  <!-- media upconversion cases:
      - ext='html' or ext='htm', type='image/png', has thumbnail (Ed Doering)
      - eps around png/bmp/gif
      - png around png
      - mov around png
      - everything else (single media) -->
  <!-- FIXME: this becomes a proper 'media' with children. -->
  <xsl:template match="cnxml:media">
    <xsl:variable name="ext">
      <xsl:call-template name="get-extension">
        <xsl:with-param name="data" select="normalize-space(substring-after(@src, '.'))"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:choose>
      <!-- FIXME dummy content -->
      <xsl:when test="cnxml:media">
        <media id="{generate-id()}" alt="an image" xmlns="http://cnx.rice.edu/cnxml">
          <xsl:if test="parent::cnxml:content or parent::cnxml:section">
            <xsl:attribute name="display">block</xsl:attribute>
          </xsl:if>
          <image src="foo.png" mime-type="image/png"/>
        </media>
      </xsl:when>
      <!-- FIXME dummy content -->
      <xsl:when test="@type='image/png' and ($ext = 'htm' or $ext = 'html') and cnxml:param[@name='thumbnail']">
        <media id="{generate-id()}" alt="an image" xmlns="http://cnx.rice.edu/cnxml">
          <xsl:if test="parent::cnxml:content or parent::cnxml:section">
            <xsl:attribute name="display">block</xsl:attribute>
          </xsl:if>
          <image src="foo.png" mime-type="image/png"/>
        </media>
      </xsl:when>
      <xsl:otherwise>
        <xsl:variable name="intype" select="@type"/>
        <xsl:variable name="media-conversion" select="$media-conversions/mc:mediaconversion[@intype=$intype][@inext=$ext]"/>
        <xsl:element name="media" namespace="http://cnx.rice.edu/cnxml">
          <xsl:call-template name="generate-id-if-required"/>
          <xsl:attribute name="alt">
            <xsl:value-of select="//cnxml:param[@name='alt'][1]"/>
          </xsl:attribute>
          <xsl:call-template name="make-attribute-from-param">
            <xsl:with-param name="param-name" select="'longdesc'"/>
          </xsl:call-template>
          <xsl:call-template name="make-media-display-attribute"/>
          <xsl:choose>
            <xsl:when test="$media-conversion/@objtype='image'">
              <xsl:call-template name="make-media-image">
                <xsl:with-param name="media-conversion" select="$media-conversion"/>
              </xsl:call-template>
            </xsl:when>
          </xsl:choose>
        </xsl:element>
        <!-- FIXME -->
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="get-extension">
    <xsl:param name="data"/>
    <xsl:choose>
      <xsl:when test="contains($data, '.')">
        <xsl:call-template name="get-extension">
          <xsl:with-param name="data" select="substring-after($data, '.')"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$data"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="make-media-display-attribute">
    <xsl:if test="parent::cnxml:content or parent::cnxml:section or
                  parent::cnxml:example or parent::cnxml:problem or
                  parent::cnxml:solution or parent::cnxml:statement or
                  parent::cnxml:proof">
      <xsl:attribute name="display">block</xsl:attribute>
    </xsl:if>
  </xsl:template>

  <xsl:template name="make-media-image">
    <xsl:param name="media-conversion"/>
    <xsl:element name="image" namespace="http://cnx.rice.edu/cnxml">
      <xsl:attribute name="src">
        <xsl:value-of select="@src"/>
      </xsl:attribute>
      <xsl:call-template name="make-mime-type">
        <xsl:with-param name="media-conversion" select="$media-conversion"/>
      </xsl:call-template>
      <xsl:call-template name="make-attribute-from-param">
        <xsl:with-param name="param-name" select="'height'"/>
      </xsl:call-template>
      <xsl:call-template name="make-attribute-from-param">
        <xsl:with-param name="param-name" select="'width'"/>
      </xsl:call-template>
      <xsl:call-template name="make-attribute-from-param">
        <xsl:with-param name="param-name" select="'print-width'"/>
      </xsl:call-template>
      <xsl:call-template name="make-attribute-from-param">
        <xsl:with-param name="param-name" select="'thumbnail'"/>
      </xsl:call-template>
    </xsl:element>
  </xsl:template>

  <xsl:template name="make-mime-type">
    <xsl:param name="media-conversion"/>
    <xsl:attribute name="mime-type">
      <xsl:choose>
        <xsl:when test="string-length($media-conversion/@outtype)">
          <xsl:value-of select="$media-conversion/@outtype"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="@type"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:attribute>
  </xsl:template>

  <xsl:template name="make-attribute-from-param">
    <xsl:param name="param-name"/>
    <xsl:if test="cnxml:param[@name=$param-name]">
      <xsl:attribute name="{$param-name}">
        <xsl:value-of select="cnxml:param[@name=$param-name]/@value"/>
      </xsl:attribute>
    </xsl:if>
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
    <reqid:element name="proof"/>
    <reqid:element name="statement"/>
  </reqid:elements>

  <mc:mediaconversions>
    <mc:mediaconversion intype="image/png" inext="png" objtype="image" outtype=""/>
    <mc:mediaconversion intype="image/gif" inext="gif" objtype="image" outtype=""/>
    <mc:mediaconversion intype="image/jpg" inext="jpg" objtype="image" outtype="image/jpeg"/>
    <mc:mediaconversion intype="application/postscript" inext="eps" objtype="image" outtype=""/>
    <mc:mediaconversion intype="image/jpeg" inext="jpg" objtype="image" outtype=""/>
    <mc:mediaconversion intype="audio/mpeg" inext="mp3" objtype="audio" outtype=""/>
    <mc:mediaconversion intype="image/bmp" inext="bmp" objtype="image" outtype=""/>
    <mc:mediaconversion intype="image/jpg" inext="gif" objtype="image" outtype="image/gif"/>
    <mc:mediaconversion intype="image/png" inext="" objtype="image" outtype=""/>
    <mc:mediaconversion intype="image/png" inext="PNG" objtype="image" outtype=""/>
    <mc:mediaconversion intype="image/" inext="" objtype="image" outtype=""/>
    <mc:mediaconversion intype="image/png" inext="html" objtype="image" outtype=""/>
    <mc:mediaconversion intype="image/jpg" inext="JPG" objtype="image" outtype="image/jpeg"/>
    <mc:mediaconversion intype="image/jpg" inext="png" objtype="image" outtype="image/png"/>
    <mc:mediaconversion intype="application/msword" inext="doc" objtype="download" outtype=""/>
    <mc:mediaconversion intype="application/mspowerpoint" inext="ppt" objtype="download" outtype="application/vnd.ms-powerpoint"/>
    <mc:mediaconversion intype="image/jpeg" inext="JPG" objtype="image" outtype=""/>
    <mc:mediaconversion intype="application/x-java-applet" inext="class" objtype="javaapplet" outtype=""/>
    <mc:mediaconversion intype="image/jpg" inext="GIF" objtype="image" outtype="image/gif"/>
    <mc:mediaconversion intype="image/jpeg" inext="png" objtype="image" outtype="image/png"/>
    <mc:mediaconversion intype="image/jpeg" inext="gif" objtype="image" outtype="image/gif"/>
    <mc:mediaconversion intype="image/jpg" inext="" objtype="image" outtype="image/jpeg"/>
    <mc:mediaconversion intype="image" inext="jpg" objtype="image" outtype="image/jpeg"/>
    <mc:mediaconversion intype="video/mpeg" inext="mov" objtype="video" outtype="video/quicktime"/>
    <mc:mediaconversion intype="image/wmf" inext="wmf" objtype="image" outtype="image/wmf"/>
    <mc:mediaconversion intype="application/x-labviewrpvi80" inext="llb" objtype="labview" outtype=""/>
    <mc:mediaconversion intype="image/" inext="png" objtype="image" outtype="image/png"/>
    <mc:mediaconversion intype="audio/mp3" inext="mp3" objtype="audio" outtype="audio/mpeg"/>
    <mc:mediaconversion intype="audio/x-wav" inext="wav" objtype="audio" outtype=""/>
    <mc:mediaconversion intype="application/x-labview-llb" inext="llb" objtype="labview" outtype=""/>
    <mc:mediaconversion intype="image/png" inext="jpg" objtype="image" outtype="image/jpeg"/>
    <mc:mediaconversion intype="application/word" inext="doc" objtype="download" outtype="application/msword"/>
    <mc:mediaconversion intype="application/mp3" inext="mp3" objtype="audio" outtype="audio/mpeg"/>
    <mc:mediaconversion intype="doc/pdf" inext="pdf" objtype="download" outtype="application/pdf"/>
    <mc:mediaconversion intype="image.png" inext="png" objtype="image" outtype="image/png"/>
    <mc:mediaconversion intype="application/x-shockwave-flash" inext="swf" objtype="flash" outtype=""/>
    <mc:mediaconversion intype="application/x-labview-vi" inext="vi" objtype="labview" outtype=""/>
    <mc:mediaconversion intype="image/png" inext="bmp" objtype="image" outtype="image/bmp"/>
    <mc:mediaconversion intype="application/x-labviewrpvi82" inext="llb" objtype="labview" outtype=""/>
    <mc:mediaconversion intype="image.jpg" inext="jpg" objtype="image" outtype="image/jpeg"/>
    <mc:mediaconversion intype="image/bmp" inext="jpg" objtype="image" outtype="image/jpeg"/>
    <mc:mediaconversion intype="audio/wav" inext="wav" objtype="audio" outtype="audio/x-wav"/>
    <mc:mediaconversion intype="image/jpg" inext="bmp" objtype="image" outtype="image/bmp"/>
    <mc:mediaconversion intype="image/src" inext="png" objtype="image" outtype="image/png"/>
    <mc:mediaconversion intype="application/pdf" inext="pdf" objtype="download" outtype=""/>
    <mc:mediaconversion intype="application/vnd.mspowerpoint" inext="ppt" objtype="download" outtype="application/vnd.ms-powerpoint"/>
    <mc:mediaconversion intype="image/gif" inext="GIF" objtype="image" outtype=""/>
    <mc:mediaconversion intype="application/ms-word" inext="doc" objtype="download" outtype="application/msword"/>
    <mc:mediaconversion intype="application/ppt" inext="ppt" objtype="download" outtype="application/vnd.ms-powerpoint"/>
    <mc:mediaconversion intype="image" inext="" objtype="image" outtype=""/>
    <mc:mediaconversion intype="image/gif" inext="png" objtype="image" outtype="image/png"/>
    <mc:mediaconversion intype="image" inext="gif" objtype="image" outtype="image/gif"/>
    <mc:mediaconversion intype="image/pjpg" inext="jpg" objtype="image" outtype="image/jpeg"/>
    <mc:mediaconversion intype="image/wmf" inext="gif" objtype="image" outtype="image/gif"/>
    <mc:mediaconversion intype="imagejpg" inext="jpg" objtype="image" outtype="image/jpeg"/>
    <mc:mediaconversion intype="video/mpeg" inext="mpg" objtype="video" outtype=""/>
    <mc:mediaconversion intype="application/octet" inext="m" objtype="download" outtype="application/octet-stream"/>
    <mc:mediaconversion intype="application/vnd.ms-powerpoint" inext="ppt" objtype="download" outtype=""/>
    <mc:mediaconversion intype="image" inext="png" objtype="image" outtype="image/png"/>
    <mc:mediaconversion intype="video/mpg" inext="mpg" objtype="video" outtype="video/mpeg"/>
    <mc:mediaconversion intype="application/x-java-applet" inext="TempCalcApplet" objtype="javaapplet" outtype=""/>
    <mc:mediaconversion intype="image/jpeg" inext="jpeg" objtype="image" outtype=""/>
    <mc:mediaconversion intype="image/png" inext="gif" objtype="image" outtype="image/gif"/>
    <mc:mediaconversion intype="images/png" inext="png" objtype="image" outtype="image/png"/>
    <mc:mediaconversion intype="video.m4v" inext="m4v" objtype="video" outtype="video/mp4"/>
    <mc:mediaconversion intype="application/powerpoint" inext="ppt" objtype="download" outtype="application/vnd.ms-powerpoint"/>
    <mc:mediaconversion intype="file/m" inext="m" objtype="download" outtype=""/>
    <mc:mediaconversion intype="image/fig" inext="jpg" objtype="image" outtype="image/jpeg"/>
    <mc:mediaconversion intype="image/pct" inext="pct" objtype="image" outtype="image/pct"/>
    <mc:mediaconversion intype="image1.bmp" inext="bmp" objtype="image" outtype="image/bmp"/>
    <mc:mediaconversion intype="image2.bmp" inext="bmp" objtype="image" outtype="image/bmp"/>
    <mc:mediaconversion intype="application/pptx" inext="pptx" objtype="download" outtype="application/vnd.ms-powerpoint"/>
    <mc:mediaconversion intype="applicatoin/msword" inext="doc" objtype="download" outtype="application/msword"/>
    <mc:mediaconversion intype="applicaton/msword" inext="doc" objtype="download" outtype="application/msword"/>
    <mc:mediaconversion intype="audio/mpeg" inext="edu/Brandt/expository/" objtype="audio" outtype=""/>
    <mc:mediaconversion intype="file/wav" inext="wav" objtype="audio" outtype="audio/x-wav"/>
    <mc:mediaconversion intype="image.gif" inext="gif" objtype="image" outtype="image/gif"/>
    <mc:mediaconversion intype="image.png" inext="PNG" objtype="image" outtype="image/png"/>
    <mc:mediaconversion intype="image/bmp" inext="png" objtype="image" outtype="image/png"/>
    <mc:mediaconversion intype="image/fig" inext="jpeg" objtype="image" outtype="image/jpeg"/>
    <mc:mediaconversion intype="image/jpeg" inext="bmp" objtype="image" outtype="image/bmp"/>
    <mc:mediaconversion intype="image/type" inext="png" objtype="image" outtype="image/png"/>
    <mc:mediaconversion intype="image3.bmp" inext="bmp" objtype="image" outtype="image/bmp"/>
    <mc:mediaconversion intype="image4.bmp" inext="bmp" objtype="image" outtype="image/bmp"/>
    <mc:mediaconversion intype="text/plain" inext="m" objtype="download" outtype="application/octet-stream"/>
    <mc:mediaconversion intype="video/mov" inext="mov" objtype="video" outtype="video/quicktime"/>
    <mc:mediaconversion intype="application/adobeacrobat" inext="pdf" objtype="download" outtype="application/pdf"/>
    <mc:mediaconversion intype="application/maword" inext="doc" objtype="download" outtype="application/msword"/>
    <mc:mediaconversion intype="application/mspowerpoint" inext="pptx" objtype="download" outtype="application/vnd.ms-powerpoint"/>
    <mc:mediaconversion intype="application/vnd.ms-word" inext="doc" objtype="download" outtype="application/msword"/>
    <mc:mediaconversion intype="application/vnd.mspowerpoint" inext="doc" objtype="download" outtype="application/msword"/>
    <mc:mediaconversion intype="application/x-java-applet" inext="jar" objtype="javaapplet" outtype=""/>
    <mc:mediaconversion intype="application/x-java-applet" inext="TempCalcButtonApplet" objtype="javaapplet" outtype=""/>
    <mc:mediaconversion intype="application/x-labview-llb" inext="vi" objtype="labview" outtype=""/>
    <mc:mediaconversion intype="application/x-labviewrpvi80" inext="vi" objtype="labview" outtype=""/>
    <mc:mediaconversion intype="application/xls" inext="xls" objtype="download" outtype="application/vnd.ms-excel"/>
    <mc:mediaconversion intype="applicaton/vnd.mspowerpoint" inext="ppt" objtype="download" outtype="application/vnd.ms-powerpoint"/>
    <mc:mediaconversion intype="imag/jpeg" inext="" objtype="image" outtype=""/>
    <mc:mediaconversion intype="image/bitmap" inext="bmp" objtype="image" outtype="image/bmp"/>
    <mc:mediaconversion intype="image/g" inext="png" objtype="image" outtype="image/png"/>
    <mc:mediaconversion intype="image/GIF" inext="GIF" objtype="image" outtype="image/gif"/>
    <mc:mediaconversion intype="image/gif" inext="jpg" objtype="image" outtype="image/jpeg"/>
    <mc:mediaconversion intype="image/jpeg" inext="jpg/" objtype="image" outtype=""/>
    <mc:mediaconversion intype="image/jpeg" inext="jpg/image" objtype="image" outtype="image/jpeg"/>
    <mc:mediaconversion intype="image/JPG" inext="JPG" objtype="image" outtype="image/jpeg"/>
    <mc:mediaconversion intype="image/pg" inext="png" objtype="image" outtype="image/png"/>
    <mc:mediaconversion intype="image/pn" inext="png" objtype="image" outtype="image/png"/>
    <mc:mediaconversion intype="image/png" inext="GIF" objtype="image" outtype="image/gif"/>
    <mc:mediaconversion intype="image/png" inext="htm" objtype="image" outtype=""/>
    <mc:mediaconversion intype="image/png" inext="jpg/view" objtype="image" outtype="image/jpeg"/>
    <mc:mediaconversion intype="image/png" inext="pg" objtype="image" outtype=""/>
    <mc:mediaconversion intype="image/src" inext="jpg" objtype="image" outtype="image/jpeg"/>
    <mc:mediaconversion intype="image/wmf" inext="jpg" objtype="image" outtype="image/jpeg"/>
    <mc:mediaconversion intype="image10.bmp" inext="bmp" objtype="image" outtype="image/bmp"/>
    <mc:mediaconversion intype="image5.bmp" inext="bmp" objtype="image" outtype="image/bmp"/>
    <mc:mediaconversion intype="image6.bmp" inext="bmp" objtype="image" outtype="image/bmp"/>
    <mc:mediaconversion intype="image7.bmp" inext="bmp" objtype="image" outtype="image/bmp"/>
    <mc:mediaconversion intype="image8.bmp" inext="bmp" objtype="image" outtype="image/bmp"/>
    <mc:mediaconversion intype="image9.bmp" inext="bmp" objtype="image" outtype="image/bmp"/>
    <mc:mediaconversion intype="image9/jpg" inext="jpg" objtype="image" outtype="image/bmp"/>
    <mc:mediaconversion intype="images/jpeg" inext="JPG" objtype="image" outtype="image/jpeg"/>
    <mc:mediaconversion intype="images/png" inext="PNG" objtype="image" outtype="image/png"/>
    <mc:mediaconversion intype="video/mp4" inext="mp4" objtype="video" outtype=""/>
    <mc:mediaconversion intype="video/x-msvideo" inext="avi" objtype="video" outtype=""/>
  </mc:mediaconversions>
</xsl:stylesheet>
