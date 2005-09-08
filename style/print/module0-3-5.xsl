<?xml version= "1.0" standalone="no"?>

<xsl:stylesheet version="1.0" 
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:cnx="http://cnx.rice.edu/cnxml/0.3.5"
		xmlns:qml="http://cnx.rice.edu/qml/1.0"
		xmlns:fo="http://www.w3.org/1999/XSL/Format"
		xmlns:m="http://www.w3.org/1998/Math/MathML">


  <!-- math imports -->
  <xsl:import href="../mathmlc2p.xsl"/>
  <!-- connexion macros -->
  <xsl:import href="../cnxmathmlc2p.xsl"/>


<!-- debugging smilie key:
       :) means it works as far as it has been tested
       :( means i think the code is right is there but there is a passivetex
              bug messing up the formatting.
      ?:) means i have written the code, but not tested it with passivetex.
  nothing means that the xsl code is not finished. -->


<!-- METADATA :) -->
  <xsl:template match="cnx:authorlist">
  </xsl:template>

  <xsl:template match="cnx:maintainerlist">
  </xsl:template>

  <xsl:template match="cnx:keywordlist">
  </xsl:template>

  <xsl:template match="cnx:objectives">
  </xsl:template>

  <xsl:template match="cnx:abstract">
  </xsl:template>

<!-- CONTENT :) -->
  <xsl:template match="cnx:content">
    <fo:block font-size="12pt"
	      text-align="justify">
      <xsl:apply-templates/>
    </fo:block>
  </xsl:template>


<!-- MODULE NAME :) -->
  <xsl:template match="cnx:module/cnx:name">
    <fo:block text-align="begin"
	      font-size="20pt"
	      font-weight="bold">
      <xsl:value-of select="../@number"/>
      <xsl:apply-templates />
    </fo:block>
  </xsl:template>


<!-- SECTION/NAME -->
  <xsl:template match="cnx:content/cnx:section/cnx:name">
    <fo:block keep-with-next="always"
	      font-size="16pt"
	      font-weight="bold"
              space-before="20pt">
      <xsl:value-of select="../@number"/>
      <xsl:apply-templates />
    </fo:block>
  </xsl:template>


<!-- SECTION/SECTION/NAME -->
  <xsl:template match="cnx:content/cnx:section/cnx:section/cnx:name">
    <fo:block font-size="14pt"
	      font-weight="bold"
              space-before="17pt">
      <xsl:value-of select="../@number"/>
      <xsl:apply-templates />
    </fo:block>
  </xsl:template>


<!--  SECTION/SECTION  -->
  <xsl:template match="cnx:section/cnx:section">
      <xsl:apply-templates />
  </xsl:template>


<!-- PARA  -->
  <xsl:template match="cnx:para">
    <fo:block>
      <xsl:apply-templates/>
    </fo:block>
  </xsl:template>

 <xsl:template match="cnx:section/cnx:para">
    <fo:block space-before=".5cm"
	      space-after=".5cm"> 
      <xsl:apply-templates />
    </fo:block>
  </xsl:template>


<!-- used to indent only para's preceded by para's, as per traditional
     printing. -->
<!--  <xsl:template match="cnx:para[preceding-sibling::cnx:para]">
    <fo:block text-align="justified"
	      font-size="12pt"
	      space-before="7pt"
	      space-after="7pt"
	      text-indent="15pt">
      <xsl:apply-templates />
    </fo:block>
  </xsl:template> -->


<!-- LIST :( -->
  <xsl:template match="cnx:list">
    <fo:block margin-left="1cm"
	      margin-right="1cm"
	      space-before=".5cm"
	      font-weight="bold">
      <xsl:apply-templates select="cnx:name"/>
    </fo:block>
    <fo:list-block margin-left="1cm"
		   margin-right="1cm">
      <xsl:apply-templates select="cnx:item"/>
    </fo:list-block>
  </xsl:template>

  <xsl:template match="cnx:item">
    <fo:list-item>
      <fo:list-item-label>
	 &#x2218;
      </fo:list-item-label>
      <fo:list-item-body>
	<xsl:apply-templates />
      </fo:list-item-body>
    </fo:list-item>
  </xsl:template>


<!-- CODE :) -->
  <xsl:template match="cnx:codeblock">
     <fo:block font-size="12pt"
	       font-family="monospace"
	       white-space="pre"
	       background-color="#CCCCCC"
	       padding=".3cm">
      <xsl:apply-templates />
    </fo:block>
  </xsl:template>

  <xsl:template match="cnx:codeline">
    <fo:inline font-family="monospace"
	       white-space="pre">
      <xsl:apply-templates />
    </fo:inline>
  </xsl:template>

  <xsl:template match="cnx:codeblock/cnx:emphasis | cnx:codeline/cnx:emphasis">
   <fo:inline font-weight="bold"
	      font-family="monospace"
	      white-space="pre"> 
      <xsl:apply-templates />
    </fo:inline>
  </xsl:template>


<!-- NOTE :) -->
  <xsl:template match="cnx:note">
    <fo:block margin-left="1cm"
	      margin-right="1cm"
	      space-before=".5cm"
	      space-after=".5cm">
      
      <xsl:choose>
	<xsl:when test="@type">
	  <fo:inline font-weight="bold"
		   text-transform="capitalize">
	    <xsl:value-of select="@type" />:
	  </fo:inline>
	</xsl:when>
	<xsl:otherwise>
	  <fo:inline font-weight="bold">Note:</fo:inline>
	</xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates />
    </fo:block>
  </xsl:template>

<!-- DEFINITION :) -->
<!-- 
To get the Definition or Rules number concatenate it's modules number
attribute with its own number attribute.-->

  <xsl:template match="cnx:definition">
    <fo:block margin-left="1cm"
              margin-right="1cm"
	      space-before=".5cm"
	      space-after=".5cm">
      <xsl:apply-templates/>
    </fo:block>
  </xsl:template>
  
  <xsl:template match="cnx:meaning">
    <xsl:number level="single" count="cnx:meaning" format="1. "/>
    <xsl:apply-templates/>
  </xsl:template>
  
  <xsl:template match="cnx:definition/cnx:example">
    <fo:inline font-style="italic">(<xsl:apply-templates/>)</fo:inline>
  </xsl:template>

  <xsl:template match="cnx:term">
    <fo:inline font-weight="bold" id="{@id}">
      <xsl:apply-templates />
    </fo:inline>
  </xsl:template>

  <xsl:template match="cnx:example/cnx:para">
     <xsl:apply-templates />
  </xsl:template>

<!-- RULE ?:) -->
  <xsl:template match="cnx:rule">
    <fo:block margin-left="1cm"
              margin-right="1cm"
	      space-before=".5cm"
	      space-after=".5cm">
      <fo:inline text-transform="capitalize"
		 font-weight="bold"><xsl:value-of
	      select="@type"/> <xsl:value-of select="@number"/>:</fo:inline> 
      <xsl:apply-templates/>
    </fo:block>
  </xsl:template>

<!--  <xsl:template match="cnx:rule/cnx:name">
      <xsl:apply-templates/>
  </xsl:template> -->

  <xsl:template match="cnx:statement">
    <fo:block margin-left=".35cm"
	      margin-right=".35cm"
	      space-before=".15cm"
	      space-after=".15cm">
      <xsl:apply-templates/>
    </fo:block>
  </xsl:template>

  <xsl:template match="cnx:proof">
    <fo:block margin-left=".35cm"
	      margin-right=".35cm"
	      space-before=".15cm"
	      space-after=".15cm">
      <fo:inline font-weight="bold"
		 font-size="10pt">Proof: </fo:inline>
      <xsl:apply-templates/>
    </fo:block>
  </xsl:template>


<!-- EXAMPLE ?:) -->
  <xsl:template match="cnx:example">
    <fo:block space-before=".15cm"
	      space-after=".15cm"
	      margin-left=".35cm"
	      padding-left=".2cm">
      Example <xsl:value-of select="@number"/>:
      <xsl:apply-templates/>
    </fo:block>
  </xsl:template>

  <xsl:template match="cnx:example/cnx:name">
    <fo:inline font-weight="bold">
      <xsl:apply-templates/>
    </fo:inline>
  </xsl:template>

<!-- EXERCISE -->
  <xsl:template match="cnx:exercise">
    <fo:block space-before=".15cm"
	      space-after=".15cm"
	      margin-left=".35cm"
	      padding-left=".2cm">
      Exercise <xsl:value-of select="@number"/>:
      <xsl:apply-templates />
    </fo:block>
  </xsl:template>

 <!-- Problem -->
  <xsl:template match="cnx:problem">
    <xsl:apply-templates />
  </xsl:template>
    
    
    <!--
  <xsl:value-of select="text()"/>
  <fo:footnote>
  <fo:footnote-citation>
  <fo:inline font-size="10pt" vertical-align="super">
  <xsl:number format="a" level="any" count="cnx:solution"/>
  </fo:inline>
  </fo:footnote-citation>
  <fo:footnote-body>	  
  <fo:block>
  <fo:inline font-size="10pt" vertical-align="super">
  <xsl:number format="a" level="any" count="cnx:solution"/>
  </fo:inline>  
  <xsl:apply-templates select="cnx:solution"/>
  </fo:block>
  </fo:footnote-body>
</fo:footnote>
</xsl:template>
  -->
  
  <xsl:template match="cnx:problem/cnx:para | cnx:solution/cnx:para">
    <xsl:apply-templates/> 
  </xsl:template> 
  
  
  <!-- Solution -->
  <xsl:template match="cnx:solution">
    <fo:footnote>
      <fo:footnote-citation>
	<fo:inline font-size="10pt" vertical-align="super">
	  <xsl:number format="1" level="any" count="cnx:solution | qml:key"/>
	</fo:inline>
      </fo:footnote-citation>
      <fo:footnote-body>
	<fo:inline font-size="10pt" vertical-align="super">
	  <xsl:number format="1" level="any" count="cnx:solution | qml:key"/>
	</fo:inline>
	<xsl:apply-templates />
      </fo:footnote-body>
    </fo:footnote>
  </xsl:template>

<!-- FIGURE ?:) -->
  <xsl:template match="cnx:figure">
    <fo:block border-top-style="solid"
	      border-top-width=".01cm"
	      border-bottom-style="solid"
	      border-bottom-width=".01cm"
	      padding=".3cm"
	      margin-top="1cm"
	      margin-bottom="1cm" 
	      space-before=".5cm"
	      space-after=".5cm"
	      text-align="center">
      <!-- first print name -->
      <xsl:apply-templates select="cnx:name"/>
 
      <!-- second, print subfigures.  if figure is vertical, simply print a
      series of blocks.  if it is horizontal or undefined then make a table
      with subfigure cells. -->
      <xsl:choose>
	<xsl:when test="cnx:subfigure and @orient='vertical'">
	  <xsl:apply-templates select="cnx:subfigure" mode="vertical"/>
	</xsl:when>
	<xsl:otherwise>
	  <fo:table>
	    <xsl:for-each select="cnx:subfigure">
	      <fo:table-column>
		<xsl:attribute name="column-number">
		  <xsl:number count="cnx:subfigure"/>
		</xsl:attribute>
		<xsl:attribute name="column-width"><xsl:number value="floor(6.5 div last())"/>in</xsl:attribute>
	      </fo:table-column>
	    </xsl:for-each>
	    <fo:table-row>
	      <xsl:apply-templates select="cnx:subfigure" mode="horizontal"/>
	    </fo:table-row>
	  </fo:table>
	</xsl:otherwise>
      </xsl:choose>

      <!-- third, print the caption -->
      <xsl:choose>
	<xsl:when test="//cnx:caption">
	  <xsl:apply-templates select="cnx:caption"/>
	</xsl:when>
	<xsl:otherwise>
	  <fo:block text-align="center">
	    Figure <xsl:value-of select="@number"/>
	  </fo:block>
	</xsl:otherwise>
      </xsl:choose>

    </fo:block>
  </xsl:template>

  <xsl:template match="cnx:figure/cnx:name">
    <fo:block text-align="center"
	      font-weight="bold"
	      padding=".2cm">
      <xsl:apply-templates />
    </fo:block>
  </xsl:template>
  
  <!-- Caption -->
  <xsl:template match="cnx:caption">
    <fo:block text-align="center">
      <fo:inline font-weight="bold">
	Figure <xsl:value-of select="@number"/>:
      </fo:inline>
      <xsl:apply-templates />
      <xsl:for-each select="../cnx:subfigure">
	<xsl:if test="../cnx:subfigure/cnx:caption">
	  <xsl:number count="cnx:subfigure" format=" (a) "/>
	  <xsl:apply-templates select="cnx:caption"/>
	</xsl:if>
      </xsl:for-each>
    </fo:block>
  </xsl:template>

  <xsl:template match="cnx:subfigure/cnx:caption">
    <xsl:apply-templates />
  </xsl:template>

  <!-- Subfigure -->
  <xsl:template match="cnx:subfigure" mode="vertical">
    <xsl:apply-templates select="cnx:media | cnx:codeblock | cnx:table"/>
    <fo:block>    
      <xsl:number count="cnx:subfigure" format="(a)"/>
      <xsl:apply-templates select="cnx:name"/>
    </fo:block>
  </xsl:template>
  
  <xsl:template match="cnx:subfigure" mode="horizontal">
    <fo:table-cell>
      <xsl:attribute name="column-number"><xsl:number
      count="cnx:subfigure"/></xsl:attribute>
      <xsl:apply-templates select="cnx:media | cnx:codeblock | cnx:table"/>
      <fo:block>    
	<xsl:number count="cnx:subfigure" format="(a)"/>
	<xsl:apply-templates select="cnx:name"/>
      </fo:block>
    </fo:table-cell>
  </xsl:template>

<!-- MEDIA :) -->
  <xsl:template match="cnx:media[starts-with(@type,'image')]">
    <fo:block>
      <fo:external-graphic>
     <xsl:attribute name="src">/net/mntb2/local/swi/web/xmlpages/<xsl:value-of
	select="translate(/cnx:module/@id,'m','')"/>/<xsl:value-of
	select="@src"/>
	</xsl:attribute>
      </fo:external-graphic>
    </fo:block>
  </xsl:template>
  
  <xsl:template match="cnx:media[@type='application/x-java-applet']">
  </xsl:template>


<!-- EQUATION -->
  <xsl:template match="cnx:equation">
    <fo:block space-before="10pt"
	      space-after="10pt"
	      text-align="centered">
      <xsl:apply-templates />
    </fo:block>
  </xsl:template>

  <xsl:template match="cnx:equation/cnx:name">
    <fo:block text-align="start"
	      font-weight="bold"
	      margin-left="1cm">
      <xsl:apply-templates/>
    </fo:block>
  </xsl:template>


<!-- CNXN :) -->
<!-- cnxn can have a target attribute, a module attribute, or both.  But it must have one of them.-->
      

  <!--contains text-->
<!--  <xsl:template match="cnx:cnxn[text()]">
    <xsl:apply-templates/><xsl:text> </xsl:text>(<xsl:call-template name="refnumb"/>)
  </xsl:template>-->
  
  <!--only target and no module-->
  <xsl:template match="cnx:cnxn[@target and not(@module)]">
    <xsl:apply-templates/>
    <xsl:text> (</xsl:text>    
    <xsl:call-template name="refnumb"/>
    <xsl:text>)</xsl:text>
  </xsl:template>
  
  <xsl:template name="refnumb">
    <xsl:choose>
      <!--Checks if the tag that m<xsl:choose>atches the key is of a certain type.
      For each tag that matches the equation (there should be only one) it
      prints a reference number.  Note that @id and @target are the same in this case.-->
      
      <xsl:when test="key('id',@target)[self::cnx:equation]">
	<xsl:for-each select="key('id',@target)">
	  Equation <xsl:value-of select="@number"/>
	</xsl:for-each>
      </xsl:when>
      
      <xsl:when test="key('id',@target)[self::cnx:figure]">
	<xsl:for-each select="key('id',@target)">
	  Figure <xsl:value-of select="@number"/>
	</xsl:for-each>
      </xsl:when>

      <xsl:when test="key('id',@target)[self::cnx:subfigure]">
	<xsl:for-each select="key('id',@target)">
	  Subfigure <xsl:value-of select="@number"/>
	</xsl:for-each>
      </xsl:when>
      
      <xsl:when test="key('id',@target)[self::cnx:section]">
	<xsl:for-each select="key('id',@target)">
	  Section <xsl:value-of select="@number"/>
	</xsl:for-each>
      </xsl:when>
      
      <xsl:when test="key('id',@target)[self::cnx:example]">
	<xsl:for-each select="key('id',@target)">
	  Example <xsl:value-of select="@number"/>
	</xsl:for-each>
      </xsl:when>

      <xsl:when test="key('id',@target)[self::cnx:exercise]">
	<xsl:for-each select="key('id',@target)">
	  Exercise <xsl:value-of select="@number"/>
	</xsl:for-each>
      </xsl:when>
      
      <xsl:when test="key('id',@target)[self::cnx:definition]">
	<xsl:for-each select="key('id',@target)">
	  Def. <xsl:value-of select="@number"/>
	</xsl:for-each>
      </xsl:when>
      
      <xsl:when test="key('id',@target)[self::cnx:rule]">
	<xsl:for-each select="key('id',@target)">
	  <xsl:value-of select="@type"/><xsl:text> </xsl:text><xsl:value-of select="@number"/>
	</xsl:for-each>
      </xsl:when>
      
      <xsl:when test="key('id',@target)[self::*[cnx:name]]">
	NAME   <xsl:value-of select="key('id',@target)/cnx:name"/>,
	<fo:page-number-citation ref-id="{@target}"/>
      </xsl:when>
      
      <!--If all other options are exhausted, prints the page number.-->
      <xsl:otherwise>pg <fo:page-number-citation ref-id="{@target}"/><!--Page Number-->
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
      

  <!--both target and module-->
  <xsl:template match="cnx:cnxn[@target and @module]">
    <xsl:apply-templates/> 
    <xsl:text> (</xsl:text>
      <xsl:choose>
	<!--Case 1: When the module is in the book.-->
	<xsl:when test="key('id',@module)"><!--Test if the module is in the book. -->
	  <xsl:call-template name="refnumb"/>
	</xsl:when>
	<!--Case 2: When the module is not in the book.-->
	<xsl:otherwise>
	 <xsl:text>http://cnx.rice.edu/cgi-bin/showmodule.cgi?id=</xsl:text><xsl:value-of select="@module"/><xsl:text>#</xsl:text><xsl:value-of select="@target"/>
	</xsl:otherwise>
      </xsl:choose>
      <xsl:text>)</xsl:text>
  </xsl:template>
  

  <!--only module and not target-->
  <xsl:template match="cnx:cnxn[@module and not(@target)]">
    <xsl:apply-templates/> 
    <xsl:text> (</xsl:text><xsl:choose>
      <!--Case 1: When the module is inside the book-->
      <xsl:when test="key('id',@module)/."><!--test for the existance of this node-->
	<xsl:text>Section </xsl:text><xsl:value-of select="key('id',@module)/@number"/>
      </xsl:when>
      <!--Case 2: When the module is outside the book-->
      <xsl:otherwise>
	<xsl:text>http://cnx.rice.edu/cgi-bin/showmodule.cgi?id=</xsl:text><xsl:value-of select="@module"/>
      </xsl:otherwise>
    </xsl:choose><xsl:text>)</xsl:text>
  </xsl:template>



<!--  LINK :)  -->
  <xsl:template match="cnx:link">
    <fo:inline text-decoration="underline">
      <xsl:apply-templates/>
    </fo:inline>
    <fo:inline font-size="10pt">
      (<xsl:value-of select="@src"/>)
    </fo:inline>
  </xsl:template>
  
  
<!-- INLINE ATTRIBUTES :) -->
  <xsl:template match="cnx:emphasis | cnx:cite">
    <fo:inline font-style="italic">
      <xsl:apply-templates />
    </fo:inline>
  </xsl:template>

  <xsl:template match="cnx:cite/cnx:emphasis | cnx:emphasis/cnx:cite">
    <fo:inline font-style="normal">
      <xsl:apply-templates />
    </fo:inline>
  </xsl:template>


<!-- TABLE -->
  <xsl:template match="cnx:table">
    HEH, I AM A <fo:inline font-style="italic">TABLE</fo:inline>
  </xsl:template>

  <xsl:template match="cnx:name">
    NAME!  <xsl:apply-templates/> NAME!
  </xsl:template>

</xsl:stylesheet>
  
  
  
  
  