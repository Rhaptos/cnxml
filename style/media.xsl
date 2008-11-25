<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns="http://www.w3.org/1999/xhtml"
                xmlns:cnx="http://cnx.rice.edu/cnxml"
                version='1.0'>

  <!-- Squash PARAMs-->
  <xsl:template match="cnx:param" />

  <!-- MEDIA:RANDOM -->
  <xsl:template match="cnx:media">
    <div class="media">
      <xsl:call-template name='IdCheck'/>
      <object>
 	<xsl:for-each select="cnx:param">
	  <xsl:attribute name='{@name}'>
	    <xsl:value-of select='@value'/>
	  </xsl:attribute> 
	</xsl:for-each>
        <xsl:call-template name="gentext">
          <xsl:with-param name="key">MediaFile</xsl:with-param>
          <xsl:with-param name="lang" select="/module/metadata/language" />
        </xsl:call-template>:
	<!--Media File:-->
	<a class="link" href="{@src}">
	  <xsl:choose>
	    <xsl:when test="cnx:param[@name='title' and normalize-space(@value) != '']">
	      <xsl:value-of select="cnx:param[@name='title']/@value" />
	    </xsl:when>
	    <xsl:otherwise>
	      <xsl:value-of select="@src" />
	    </xsl:otherwise>
	  </xsl:choose>
	</a>
        <xsl:apply-templates/>
      </object>
    </div>
  </xsl:template>

  <!-- MEDIA:IMAGE --> 
  <xsl:template match="cnx:media[starts-with(@type,'image')]|cnx:mediaobject[starts-with(@type,'image')]">
    <span class="media">
    <xsl:choose>
      <xsl:when test="child::cnx:param[@name='thumbnail']">
	<a href="{@src}">
	  <img src="{child::cnx:param[@name='thumbnail']/@value}">
	    <xsl:call-template name='IdCheck'/>
	    <xsl:for-each select="cnx:param[@name != 'thumbnail']">
	      <xsl:attribute name='{@name}'>
		<xsl:value-of select='@value'/>
	      </xsl:attribute> 
	    </xsl:for-each>
            <xsl:call-template name="altgenerator" />
	  </img>
	</a>	    
      </xsl:when>
      <xsl:otherwise>
	<img src="{@src}">
	  <xsl:call-template name='IdCheck'/>
	  <xsl:for-each select="cnx:param">
	    <xsl:attribute name='{@name}'>
	      <xsl:value-of select='@value'/>
	    </xsl:attribute> 
	  </xsl:for-each>
          <xsl:call-template name="altgenerator" />
	  <xsl:apply-templates select="media" />
	</img>
      </xsl:otherwise>
    </xsl:choose>
    </span>
  </xsl:template>

  <!-- Alt generator (if that param is absent) -->
  <xsl:template name="altgenerator">
    <xsl:if test="not(cnx:param[@name='alt'])">
      <xsl:attribute name="alt">
        <xsl:choose>
          <xsl:when test="parent::cnx:figure">
            <xsl:choose>
              <xsl:when test="parent::cnx:figure/*[self::cnx:name or self::cnx:title]">
                <xsl:value-of select="parent::cnx:figure/*[self::cnx:name or self::cnx:title]" />
              </xsl:when>
              <xsl:otherwise>
                <!--Figure--> 
                <xsl:call-template name="gentext">
                  <xsl:with-param name="key">Figure</xsl:with-param>
                    <xsl:with-param name="lang" select="/module/metadata/language" />
                  </xsl:call-template>
                <xsl:text> </xsl:text>
                <xsl:number level="any" count="cnx:figure" />
              </xsl:otherwise>
            </xsl:choose>
            <xsl:text> (</xsl:text>
            <xsl:value-of select="@src" />
            <xsl:text>)</xsl:text>
          </xsl:when>
          <xsl:when test="parent::cnx:subfigure">
            <xsl:choose>
              <xsl:when test="parent::cnx:subfigure/*[self::cnx:name or self::cnx:title]">
                <xsl:value-of select="parent::cnx:subfigure/*[self::cnx:name or self::cnx:title]" />
              </xsl:when>
              <xsl:otherwise>
                <xsl:if test="ancestor::cnx:figure[1]/*[self::cnx:name or self::cnx:title]">
                  <xsl:value-of select="ancestor::cnx:figure[1]/*[self::cnx:name or self::cnx:title]" />
                  <xsl:text>, </xsl:text>
                </xsl:if>
                <!--Subfigure--> 
                <xsl:call-template name="gentext">
                  <xsl:with-param name="key">Subfigure</xsl:with-param>
                    <xsl:with-param name="lang" select="/module/metadata/language" />
                  </xsl:call-template>
                <xsl:text> </xsl:text>
		<xsl:number level="any" count="//cnx:figure" />.<xsl:number level="single" count="cnx:subfigure" />
              </xsl:otherwise>
            </xsl:choose>
            <xsl:text> (</xsl:text>
            <xsl:value-of select="@src" />
            <xsl:text>)</xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="@src" />
          </xsl:otherwise>
        </xsl:choose>
      </xsl:attribute>
    </xsl:if>
  </xsl:template>

  <!--MEDIA:EPS Image -->
  <xsl:template match="cnx:media[starts-with(@type,'application/postscript')]">
    <xsl:choose>
      <xsl:when test="child::cnx:media">
	<xsl:apply-templates/>
      </xsl:when>
      <xsl:otherwise>
	<div class="media">
	  <xsl:call-template name='IdCheck'/>
	  <object>
	    <xsl:for-each select="cnx:param">
	      <xsl:attribute name='{@name}'>
		<xsl:value-of select='@value'/>
	      </xsl:attribute> 
	    </xsl:for-each>
            <xsl:call-template name="gentext">
              <xsl:with-param name="key">EPSImage</xsl:with-param>
              <xsl:with-param name="lang" select="/module/metadata/language" />
            </xsl:call-template>:
	    <!--EPS Image:--> 
	    <a class="link" href="{@src}">
	      <xsl:choose>
		<xsl:when test="cnx:param[@name='title' and normalize-space(@value) != '']">
		  <xsl:value-of select="cnx:param[@name='title']/@value" />
		</xsl:when>
		<xsl:otherwise>
		  <xsl:value-of select="@src" />
		</xsl:otherwise>
	      </xsl:choose>
	    </a>
	    <xsl:apply-templates/>
	  </object>
	</div>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!--  MEDIA:APPLET  -->
  <xsl:template match="cnx:media[@type='application/x-java-applet']">
    <span class="media">
    <applet code="{@src}">
      <xsl:call-template name='IdCheck'/>
      <xsl:for-each select="cnx:param">
	<xsl:attribute name='{@name}'>
	  <xsl:value-of select='@value'/>
	</xsl:attribute>
      </xsl:for-each>
      <xsl:apply-templates />
    </applet>
    </span>
  </xsl:template>

  <!-- Video  -->
  <xsl:template match="cnx:media[starts-with(@type, 'video/')]">
    <span class="media">
    <object href='{@src}'>
      <xsl:call-template name='IdCheck'/>
      <xsl:for-each select="cnx:param[@name='classid' or @name='codebase']">
     	<xsl:attribute name='{@name}'>
	  <xsl:value-of select='@value'/>
	</xsl:attribute>
      </xsl:for-each>
     <xsl:for-each select="cnx:param[@name!='classid' and @name!='codebase']">
	<param name='{@name}' value="{@value}" />
     </xsl:for-each> 
      <embed src="{@src}">
	<xsl:for-each select="cnx:param">
	  <xsl:attribute name='{@name}'>
	    <xsl:value-of select='@value' />
	  </xsl:attribute>
	</xsl:for-each>
	<xsl:apply-templates />
      </embed>
    </object>
    </span>
  </xsl:template>

  <!-- LABVIEW -->
  <xsl:template match="cnx:media[starts-with(@type,'application/x-labview')]">
    <div class="media labview example">
      <xsl:call-template name='IdCheck'/>
      <span class="cnx_label">
        <xsl:call-template name="gentext">
          <xsl:with-param name="key">LabVIEWExample</xsl:with-param>
          <xsl:with-param name="lang" select="/module/metadata/language" />
        </xsl:call-template>:
        <xsl:text> </xsl:text>
        <!--LabVIEW Example:-->
      </span>
      <xsl:for-each select=".">
        <xsl:variable name="viinfo" select="cnx:param[@name='viinfo']/@value" />
        (<a class="cnxn" href="{$viinfo}">run</a>) (<a class="cnxn" href="{@src}">source</a>)
      </xsl:for-each>
    </div>
  </xsl:template>

  <!-- LABVIEW 8.X -->
  <xsl:template match="cnx:media[starts-with(@type,'application/x-labviewrp')]">
    <xsl:param name="lv-version" select="substring-after(@type, 'application/x-labviewrp')"/>
    <xsl:param name="classid">
      <xsl:choose>
        <xsl:when test="$lv-version = 'vi80'">CLSID:A40B0AD4-B50E-4E58-8A1D-8544233807AD</xsl:when>
        <xsl:when test="$lv-version = 'vi82'">CLSID:A40B0AD4-B50E-4E58-8A1D-8544233807AE</xsl:when>
      </xsl:choose>
    </xsl:param>
    <xsl:param name="codebase">
      <xsl:choose>
        <xsl:when test="$lv-version = 'vi80'">ftp://ftp.ni.com/pub/devzone/tut/cnx_lv8_runtime.exe</xsl:when>
        <xsl:when test="$lv-version = 'vi82'">ftp://ftp.ni.com/support/labview/runtime/windows/8.2/LVRunTimeEng.exe</xsl:when>
      </xsl:choose>
    </xsl:param>
    <xsl:param name="pluginspage">
        http://digital.ni.com/express.nsf/bycode/exwgjq
    </xsl:param>
    <div class="media labview example">
      <xsl:call-template name='IdCheck'/>
      <object classid="{$classid}"
              codebase="{$codebase}">
	<xsl:if test="cnx:param[@name='width']">
	  <xsl:attribute name="width"><xsl:value-of select="cnx:param[@name='width']/@value"/></xsl:attribute>
	</xsl:if>
	<xsl:if test="cnx:param[@name='height']">
	  <xsl:attribute name="height"><xsl:value-of select="cnx:param[@name='height']/@value"/></xsl:attribute>
	</xsl:if>
	<param name="SRC" value="{@src}" />
	<xsl:choose>
	  <xsl:when test="cnx:param[@name='lvfppviname']">
	    <param name="LVFPPVINAME" value="{cnx:param[@name='lvfppviname']/@value}" />
	  </xsl:when>
	  <xsl:otherwise>
	    <param name="LVFPPVINAME" value="{@src}" />
	  </xsl:otherwise>
	</xsl:choose>
	<param name="REQCTRL" value="false" />
	<param name="RUNLOCALLY" value="true" />
	<embed src="{@src}"
               reqctrl="true"
	       runlocally="true"
	       type="{@type}"
	       pluginspage="{$pluginspage}">
	  <xsl:attribute name="lvfppviname">
	    <xsl:choose>
	      <xsl:when test="cnx:param[@name='lvfppviname']"><xsl:value-of select="cnx:param[@name='lvfppviname']/@value" /></xsl:when>
	      <xsl:otherwise><xsl:value-of select="@src" /></xsl:otherwise>
	    </xsl:choose>
	  </xsl:attribute>
	  <xsl:if test="cnx:param[@name='width']">
	    <xsl:attribute name="width"><xsl:value-of select="cnx:param[@name='width']/@value"/></xsl:attribute>
	  </xsl:if>
	  <xsl:if test="cnx:param[@name='height']">
	    <xsl:attribute name="height"><xsl:value-of select="cnx:param[@name='height']/@value"/></xsl:attribute>
	  </xsl:if>
	</embed>
      </object>
      <p>
        <xsl:call-template name="gentext">
          <xsl:with-param name="key">Download</xsl:with-param>
          <xsl:with-param name="lang" select="/module/metadata/language" />
        </xsl:call-template>
        <xsl:text> </xsl:text>
        <!--Download--> 
        <a class="cnxn" href="{@src}">
          <xsl:call-template name="gentext">
            <xsl:with-param name="key">LabVIEWSource</xsl:with-param>
            <xsl:with-param name="lang" select="/module/metadata/language" />
          </xsl:call-template>
          <!--LabVIEW source-->
        </a>
      </p>
    </div>
  </xsl:template>

  <!-- FLASH Objects -->
  <xsl:template match="cnx:media[@type='application/x-shockwave-flash']">
    <span class="media">
    <object type="application/x-shockwave-flash" data="{@src}">
      <xsl:call-template name='IdCheck'/>
      <xsl:for-each select="cnx:param">
        <xsl:choose>
          <xsl:when test="@name='width' or @name='height'">
            <xsl:attribute name="{@name}">
              <xsl:value-of select="@value" />
            </xsl:attribute>
          </xsl:when>
          <xsl:otherwise>
            <param name="{@name}" value="{@value}" />
          </xsl:otherwise>
        </xsl:choose>
      </xsl:for-each>
      <param name="movie" value="{@src}"/>
      <embed src="{@src}" type="application/x-shockwave-flash" pluginspace="http://www.macromedia.com/shockwave/download/index.cgi?P1_Prod_Version=ShockwaveFlash">
        <xsl:for-each select="cnx:param">
          <xsl:attribute name="{@name}">
            <xsl:value-of select="@value" />
          </xsl:attribute>
        </xsl:for-each>
      </embed>
    </object>
    </span>
  </xsl:template>

  <!-- Generic audio file -->
  <xsl:template match="cnx:media[starts-with(@type,'audio')]"> 
    <div class="media musical example">
      <xsl:call-template name='IdCheck'/>
      <span class="cnx_label">
        <xsl:call-template name="gentext">
          <xsl:with-param name="key">AudioFile</xsl:with-param>
          <xsl:with-param name="lang" select="/module/metadata/language" />
        </xsl:call-template>:
        <!--Audio File:-->
      </span>
      <a class="link" href="{@src}">
	<xsl:choose>
	  <xsl:when test="cnx:param[@name='title' and normalize-space(@value) != '']">
	    <i><xsl:value-of select="cnx:param[@name='title']/@value" /></i>
	  </xsl:when>
	  <xsl:otherwise>
	    <xsl:value-of select="@src" />
	  </xsl:otherwise>
	</xsl:choose>
      </a>
    </div>       
  </xsl:template>

  <!-- MP3 (Tony Brandt) -->
  <xsl:template match="cnx:media[@type='audio/mpeg']"> 
    <div class="media musical example">
      <xsl:call-template name='IdCheck'/>
      <span class="cnx_label">
        <xsl:call-template name="gentext">
          <xsl:with-param name="key">MusicalExample</xsl:with-param>
          <xsl:with-param name="lang" select="/module/metadata/language" />
        </xsl:call-template>:
        <!--Musical Example:-->
      </span>
      <a class="cnxn" href="{@src}">
        <xsl:call-template name="composer-title-comments" />
      </a>
    </div>       
  </xsl:template>

  <!-- COMPOSER, TITLE and COMMENTS template -->
  <xsl:template name="composer-title-comments">
    <xsl:if test="cnx:param[@name='composer' and normalize-space(@value) != '']">
      <xsl:value-of select="cnx:param[@name='composer']/@value" />
      <xsl:text>, </xsl:text>
    </xsl:if>
    <xsl:choose>
      <xsl:when test="cnx:param[@name='title' and normalize-space(@value) != '']">
	<i><xsl:value-of select="cnx:param[@name='title']/@value" /></i>
      </xsl:when>
      <xsl:otherwise>
	<xsl:value-of select="@src" />
      </xsl:otherwise>
    </xsl:choose>
    <xsl:if test="cnx:param[@name='comments' and normalize-space(@value)!='']">
      <xsl:text>, </xsl:text>
      <xsl:value-of select="cnx:param[@name='comments']/@value" />
    </xsl:if>
  </xsl:template>

</xsl:stylesheet>
