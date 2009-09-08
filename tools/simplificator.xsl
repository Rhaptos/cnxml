<?xml version="1.0"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:rng="http://relaxng.org/ns/structure/1.0"
                xmlns:exsl="http://exslt.org/common"
                extension-element-prefixes="exsl"
                exclude-result-prefixes="rng"
>
  <xsl:output indent="yes" method="xml"/>
  <xsl:strip-space elements="*"/>
  <xsl:key name="define-by-name" match="rng:define" use="@name"/>
  <xsl:key name="ref-by-name" match="rng:ref" use="@name"/>

  <xsl:template match="/">
    <!-- Grab input schema file. -->
    <xsl:variable name="input-doc">
      <xsl:copy-of select="."/>
    </xsl:variable>
    <!-- Grab included grammars and stuff them into the input schema. -->
    <xsl:variable name="includes-1-done">
      <xsl:apply-templates select="exsl:node-set($input-doc)" mode="includes-1"/>
    </xsl:variable>
    <!--<xsl:copy-of select="$includes-1-done"/>-->
    <!-- For duplicate define elements within an include, remove all but the last. -->
    <xsl:variable name="includes-2-done">
      <xsl:apply-templates select="exsl:node-set($includes-1-done)" mode="includes-2"/>
    </xsl:variable>
    <!-- Process define[@combine] -->
    <xsl:variable name="combine-defs-done">
      <xsl:apply-templates select="exsl:node-set($includes-2-done)" mode="combine-defs"/>
    </xsl:variable>
    <!-- Check for duplicate define elements -->
    <xsl:variable name="combine-defs-done-nodeset" select="exsl:node-set($combine-defs-done)"/>
    <xsl:for-each select="$combine-defs-done-nodeset//rng:define">
      <xsl:variable name="name" select="@name"/>
      <xsl:if test="preceding-sibling::rng:define[@name=$name]">
        <xsl:message terminate="no">Duplicate definition: <xsl:value-of select="@name"/></xsl:message>
      </xsl:if>
    </xsl:for-each>
    <!-- Resolve all ref elements except those containing element elements -->
    <xsl:variable name="resolve-refs-done">
      <xsl:apply-templates select="$combine-defs-done-nodeset" mode="resolve-refs"/>
    </xsl:variable>
    <xsl:apply-templates select="exsl:node-set($resolve-refs-done)" mode="flatten"/>
  </xsl:template>

  <xsl:template match="node()|@*" mode="includes-1">
    <xsl:copy>
      <xsl:apply-templates select="@*" mode="includes-1"/>
      <xsl:if test="self::rng:element and not(@ns)">
        <xsl:copy-of select="ancestor::rng:*[@ns][1]/@ns"/>
      </xsl:if>
      <xsl:if test="self::rng:define and not(@datatypeLibrary)">
        <xsl:copy-of select="ancestor::rng:*[@ns][1]/@datatypeLibrary"/>
      </xsl:if>
      <xsl:apply-templates select="node()" mode="includes-1"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="rng:include" mode="includes-1">
    <xsl:comment>starting <xsl:value-of select="@href"/></xsl:comment>
    <xsl:copy>
      <xsl:apply-templates select="@*" mode="includes-1"/>
      <xsl:comment>included elements</xsl:comment>
      <xsl:apply-templates select="document(@href)/rng:grammar/node()" mode="includes-1"/>
      <xsl:comment>the rest</xsl:comment>
      <xsl:apply-templates select="node()" mode="includes-1"/>
    </xsl:copy>
    <xsl:comment>ending <xsl:value-of select="@href"/></xsl:comment>
  </xsl:template>

  <xsl:template match="rng:include|rng:include/rng:grammar" mode="includes-2">
    <!--<xsl:copy>
      <xsl:apply-templates select="node()|@*" mode="includes-2"/>
    </xsl:copy>-->
    <xsl:apply-templates mode="includes-2"/>
  </xsl:template>

  <xsl:template match="rng:include//rng:define" mode="includes-2">
    <xsl:variable name="name" select="@name"/>
    <xsl:variable name="ancestor-include" select="ancestor::rng:include[1]"/>
    <xsl:if test="not(following-sibling::rng:define[@name=$name])">
      <xsl:copy>
        <xsl:apply-templates select="node()|@*" mode="includes-2"/>
      </xsl:copy>
    </xsl:if>
  </xsl:template>

  <xsl:template match="node()|@*" mode="includes-2">
    <xsl:copy>
      <xsl:apply-templates select="node()|@*" mode="includes-2"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="rng:define" mode="combine-defs">
    <xsl:variable name="name" select="@name"/>
    <xsl:variable name="preceding-like-defines" select="preceding::rng:define[@name=$name]"/>
    <xsl:variable name="following-like-defines" select="following::rng:define[@name=$name]"/>
    <xsl:choose>
      <xsl:when test="not($preceding-like-defines) and not($following-like-defines)">
        <xsl:copy-of select="."/>
      </xsl:when>
      <xsl:when test="not($preceding-like-defines)">
        <xsl:variable name="all-like-defines" select="self::rng:define|$following-like-defines"/>
        <xsl:if test="$all-like-defines[@combine='choice'] and $all-like-defines[@combine='interleave']">
          <xsl:message terminate="yes">Defines of <xsl:value-of select="$name"/> have both 'choice' and 'interleave'</xsl:message>
        </xsl:if>
        <xsl:if test="count($all-like-defines[not(@combine)])&gt;1">
          <xsl:message terminate="yes">Defines of <xsl:value-of select="$name"/> have more than one without @combine</xsl:message>
        </xsl:if>
        <xsl:copy>
          <xsl:apply-templates select="@*" mode="combine-defs"/>
          <xsl:element name="{$all-like-defines/@combine}" namespace="http://relaxng.org/ns/structure/1.0">
            <xsl:apply-templates select="$all-like-defines/*" mode="combine-defs"/>
          </xsl:element>
        </xsl:copy>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="node()|@*" mode="combine-defs">
    <xsl:copy>
      <xsl:apply-templates select="node()|@*" mode="combine-defs"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="rng:ref" mode="resolve-refs">
    <xsl:variable name="name" select="@name"/>
    <xsl:variable name="define" select="ancestor::rng:grammar//rng:define[@name=$name]"/>
    <xsl:choose>
      <xsl:when test="$define//rng:element">
        <xsl:copy-of select="."/>
      </xsl:when>
      <xsl:when test="count($define/*)=1 and $define/rng:empty">
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-templates select="$define/node()" mode="resolve-refs"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="node()|@*" mode="resolve-refs">
    <xsl:copy>
      <xsl:apply-templates select="node()|@*" mode="resolve-refs"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="rng:choice/rng:choice|rng:group/rng:group" mode="flatten">
    <xsl:apply-templates select="node()" mode="flatten"/>
  </xsl:template>

  <xsl:template match="rng:define[not(descendant::rng:element)]" mode="flatten">
  </xsl:template>

  <xsl:template match="node()|@*" mode="flatten">
    <xsl:copy>
      <xsl:apply-templates select="node()|@*" mode="flatten"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="rng:optional[count(*) = 0]" mode="flatten">
    <xsl:comment>disposing of an empty 'optional' element</xsl:comment>
  </xsl:template>

</xsl:stylesheet>
