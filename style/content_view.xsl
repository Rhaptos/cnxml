<?xml version="1.0"?>

<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:cnx="http://cnx.rice.edu/cnxml"
  xmlns="http://www.w3.org/1999/xhtml"
  xmlns:tal="http://xml.zope.org/namespaces/tal"
  xmlns:metal="http://xml.zope.org/namespaces/metal">

  <xsl:import href="unibrowser.xsl" />

  <!-- Don't actually display gallery if there are no mpegs -->
  <xsl:param name="gallery" select="0" />
  <xsl:variable name="xsl_gallery" select="$gallery and //cnx:media[@type='audio/mpeg']" />

  <xsl:output omit-xml-declaration="yes" encoding="utf-8" />
  
  <xsl:template match="/">

<!--<span tal:omit-tag="" metal:use-macro="here/xml_header/macros/doctype" />-->
<html xmlns="http://www.w3.org/1999/xhtml" 
      metal:use-macro="here/module_view_template/macros/master">

      <!-- Pass our redefined gallery variable on to the template -->
      <tal:globals metal:fill-slot="top_slot">
	<xsl:attribute name="tal:define">global gallery <xsl:choose>
	    <xsl:when test="$xsl_gallery">python:1</xsl:when>
	    <xsl:otherwise>nothing</xsl:otherwise>
	  </xsl:choose>
	</xsl:attribute>
      </tal:globals>

      <!-- LISTENING GALLERY -->
      <xsl:if test="$xsl_gallery">
	<metal:slot metal:fill-slot="pre_content">
	  <div id="musical-examples">
	  <span class="name">Musical Examples</span>
	  <ol>
	    <xsl:for-each select="//cnx:media[@type='audio/mpeg']">
	      <li>
		<a class="musical-example" id="{@id}-link" href="javascript:toggleBar('{@id}')">
		  <xsl:call-template name="composer-title-comments" />
		</a>
	      </li>
	    </xsl:for-each>
	  </ol>
	</div>

	  <!-- MUSIC APPLET TITLE BARS -->
	  <xsl:for-each select="//cnx:media[@type='audio/mpeg']">
	  <div id="{@id}">
	    <xsl:attribute name="class">
	      <xsl:choose>
		<xsl:when test="cnx:param[@name='interactive']">title-bar interactive</xsl:when>
		<xsl:otherwise>title-bar</xsl:otherwise>
	      </xsl:choose>
	    </xsl:attribute>
	    <div class="titles">
	<div class="title shadow">                  
	  <xsl:call-template name="composer-title-comments" />
	  <xsl:call-template name="tt" />
	</div>
	<div class="title top">
	  <xsl:call-template name="composer-title-comments" />
	  <xsl:call-template name="tt" />
	</div>
	<a class="close" href="javascript:toggleBar('{@id}');">x</a>
      </div>
	    <div class="player">
	      <object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000"
	              codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,0,0"
                      width="600" align="center">
		<xsl:choose>
		  <xsl:when test="cnx:param[@name='interactive']">
		    <xsl:attribute name="height">175</xsl:attribute>
		    <param name="movie" value="http://music.cnx.rice.edu/flash/cnxplayer_int.swf?song={@src}&amp;songname={cnx:param[@name='interactive']/@value}" />
		  </xsl:when>
		  <xsl:when test="cnx:param[@name='timed-text']">
		    <xsl:attribute name="height">85</xsl:attribute>
		    <param name="movie" value="http://music.cnx.rice.edu/flash/cnxplayer_tt.swf?song={@src}&amp;songname={cnx:param[@name='timed-text']/@value}" />
		  </xsl:when>
		  <xsl:otherwise>
		    <xsl:attribute name="height">60</xsl:attribute>
		    <param name="movie" value="http://music.cnx.rice.edu/flash/cnxplayer.swf?song={@src}" />
		  </xsl:otherwise>
		</xsl:choose>
		
		<param name="quality" value="high" />
		<embed width="600" align="center" quality="high" bgcolor="4A79A5"
		       type="application/x-shockwave-flash"
		       pluginspage="http://www.macromedia.com/go/getflashplayer">
		    <xsl:choose>
		    <xsl:when test="cnx:param[@name='interactive']">
		      <xsl:attribute name="height">175</xsl:attribute>
		      <xsl:attribute name="src">http://music.cnx.rice.edu/flash/cnxplayer_int.swf?song=<xsl:value-of select="@src"/>&amp;songname=<xsl:value-of select="cnx:param[@name='interactive']/@value"/></xsl:attribute>
		    </xsl:when>
		    <xsl:when test="cnx:param[@name='timed-text']">
		      <xsl:attribute name="height">85</xsl:attribute>
		      <xsl:attribute name="src">http://music.cnx.rice.edu/flash/cnxplayer_tt.swf?song=<xsl:value-of select="@src"/>&amp;songname=<xsl:value-of select="cnx:param[@name='timed-text']/@value"/></xsl:attribute>
		    </xsl:when>
		    <xsl:otherwise>
		      <xsl:attribute name="height">60</xsl:attribute>
		      <xsl:attribute name="src">http://music.cnx.rice.edu/flash/cnxplayer.swf?song=<xsl:value-of select="@src"/></xsl:attribute>
		    </xsl:otherwise>
		  </xsl:choose>
		  <p>You need to install <a href="http://www.macromedia.com/shockwave/download/download.cgi?P1_Prod_Version=ShockwaveFlash&amp;application/x-shockwave-flash"> Macromedia Flash</a> to display this.</p>
		</embed>

		<param name="bgcolor" value="4A79A5" />
		<xsl:if test="cnx:param[@name='total-time']">
		  <xsl:variable name="total-time" select="cnx:param[@name='total-time']/@value" />
		  <param name="total-time" value="{$total-time}" />
		</xsl:if>
		<param name="textcolor" value="ffffff" />
		<xsl:if test="cnx:param[@name='timed-text']">
		  <xsl:variable name="timed-text-file" select="cnx:param[@name='timed-text']/@value" />
		  <param name="timed-text" value="{$timed-text-file}" />
		</xsl:if>
		<xsl:if test="cnx:param[@name='interactive']">
		  <param name="interactive" value="{cnx:param[@name='interactive']/@value}" />
		</xsl:if>
		<!--<p>You need to install Macromedia Flash to display this.</p>-->
	      </object>
	    </div>
	    <div class="performance">
	      <xsl:if test="cnx:param[@name='label-number' and normalize-space(@value)!='']">
		<xsl:value-of select="cnx:param[@name='label-number']/@value" />
	      </xsl:if>
	      <xsl:if test="cnx:param[@name='label-number' and normalize-space(@value)!=''] and cnx:param[@name='performer' and normalize-space(@value)!='']">
		<xsl:text> </xsl:text>&#8212;<xsl:text> </xsl:text>
	      </xsl:if>
	      <xsl:if test="cnx:param[@name='performer']">
		<xsl:value-of select="cnx:param[@name='performer']/@value" />
	      </xsl:if>
	    </div>
	  </div>
	  </xsl:for-each>
	</metal:slot>
      </xsl:if>

      <metal:slot metal:fill-slot="main">
	<xsl:apply-templates/>
      </metal:slot>
</html>

  </xsl:template>

  <!-- MP3 (Gallery style) -->
  <xsl:template match="cnx:media[@type='audio/mpeg']"> 
    <xsl:choose>
      <xsl:when test="$xsl_gallery">
	<div class="example musical">
	  <span class="example-before">Musical Example:</span>
	  <a class="link" href="javascript:toggleBar('{@id}')">
	    <xsl:call-template name="composer-title-comments" />
	  </a>
	</div>
      </xsl:when>
      <xsl:otherwise><xsl:apply-imports /></xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="tt">
    <xsl:if test="cnx:param[@name='total-time' and normalize-space(@value)!='']">
      <xsl:variable name="tt-number" select="number(cnx:param[@name='total-time']/@value)" />
      <xsl:variable name="minutes" select="floor(format-number($tt-number div 60,'#.####'))" />
      <xsl:variable name="seconds" select="format-number(($tt-number div 60 - $minutes) * 60,'00')" />
      <i><xsl:text> (</xsl:text><xsl:value-of select="$minutes"/><xsl:text>:</xsl:text><xsl:value-of select="$seconds"/><xsl:text>) </xsl:text></i>
    </xsl:if>
  </xsl:template>

</xsl:stylesheet>
