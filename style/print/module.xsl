<?xml version= "1.0" standalone="no"?>

<xsl:stylesheet version="1.0" 
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:cnx="http://cnx.rice.edu/cnxml/0.3.5"
		xmlns:qml="http://cnx.rice.edu/qml/1.0"
		xmlns:fo="http://www.w3.org/1999/XSL/Format"
		xmlns:m="http://www.w3.org/1998/Math/MathML">

  <xsl:include href="qml.xsl" />
  <xsl:include href="table.xsl" />

  <xsl:output indent="no" />

  <xsl:key name='id' match='*' use='@id'/>

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
    <fo:block font-size="11pt"
	      text-align="justify">
      <xsl:apply-templates/>
    </fo:block>
  </xsl:template>


<!-- MODULE/NAME :) -->
  <xsl:template match="cnx:module/cnx:name">
    <fo:block text-align="begin"
	      font-size="16pt"
	      font-weight="bold"
	      space-before="15pt"
	      space-after="10pt"
	      keep-with-next="always">
      <xsl:choose>
	<xsl:when test="parent::*[@number]">
	  <xsl:value-of select="../@number"/><xsl:text> </xsl:text>
	</xsl:when>
	<xsl:otherwise></xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates />
    </fo:block>
  </xsl:template>


<!-- SECTION/NAME -->
  <xsl:template match="cnx:content/cnx:section/cnx:name">
    <fo:block keep-with-next="always"
	      font-size="14pt"
	      font-weight="bold"
              space-before="15pt"
	      space-after="1pt">
      <xsl:copy-of select="../@id"/>
      <xsl:choose>
	<xsl:when test="parent::*[@number]">
	  <xsl:value-of select="../@number"/>
	</xsl:when>
	<xsl:otherwise>
	  <xsl:number count="cnx:section" level="multiple"/>
	</xsl:otherwise>
      </xsl:choose>
       <xsl:text> </xsl:text><xsl:apply-templates />
    </fo:block>
  </xsl:template>


<!-- SECTION/SECTION/NAME -->
  <xsl:template match="cnx:content/cnx:section/cnx:section/cnx:name">
    <fo:block keep-with-next="always"
	      font-size="13pt"
	      font-weight="bold"
              space-before="5pt"
	      space-after="1pt">
      <xsl:copy-of select="../@id"/>
      <xsl:choose>
	<xsl:when test="parent::*[@number]">
	  <xsl:value-of select="../@number"/>
	</xsl:when>
	<xsl:otherwise>
	  <xsl:number count="cnx:section" level="multiple"/>
	</xsl:otherwise>
      </xsl:choose>
      <xsl:text> </xsl:text><xsl:apply-templates />
    </fo:block>
  </xsl:template>


<!-- SECTION/SECTION/SECTION/NAME -->
  <xsl:template match="cnx:section/cnx:section/cnx:section/cnx:name">
    <fo:block keep-with-next="always"
	      font-size="12pt"
	      font-weight="bold"
              space-before="10pt">
      <xsl:copy-of select="../@id"/>
      <xsl:choose>
	<xsl:when test="parent::*[@number]">
	  <xsl:value-of select="../@number"/><xsl:text> </xsl:text>
	</xsl:when>
	<xsl:otherwise>
	  <xsl:number count="cnx:section" level="multiple"/>
	</xsl:otherwise>
      </xsl:choose>
      <xsl:text> </xsl:text><xsl:apply-templates />
    </fo:block>
  </xsl:template>


<!-- PARA  -->
  <!-- All para's will simply be justified blocks unless this template is
  overriden.  This is so that para's within example, exercise, etc. are treated
  differently than para's within sections, see below. -->
  <xsl:template match="cnx:para">
    <fo:block text-align="justify"
	      text-indent="15pt">
      <xsl:copy-of select="@id"/>
      <xsl:apply-templates/>
    </fo:block>
  </xsl:template>

  <!-- This template overrides the above so that para's in modules and sections
  have space between them. -->
  <xsl:template match="cnx:section/cnx:para|cnx:content/cnx:para">
    <fo:block space-before=".25cm"
	      space-after=".25cm"
	      text-align="justify">
      <xsl:copy-of select="@id"/>
      
      <!-- This indents all para's that are not first.  There was a bit of
      debate on how to do para indenting, perhaps this should be
      parameterized. -->
      <xsl:if test="count(preceding-sibling::cnx:para) > 0">
	<xsl:attribute name="text-indent">15pt</xsl:attribute>
      </xsl:if>

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
    <xsl:if test="cnx:name">
      <fo:block margin-left="1cm"
		margin-right="1cm"
		space-before=".5cm"
		font-weight="bold"
		keep-with-next="always">
	<xsl:apply-templates select="cnx:name"/>
      </fo:block>
    </xsl:if>
    <fo:list-block margin-left="1cm"
		   margin-right="1cm">
      <xsl:copy-of select="@id"/>
      <xsl:apply-templates select="cnx:item"/>
    </fo:list-block>
  </xsl:template>


  <xsl:template match="cnx:item">
    <fo:list-item>
      <fo:list-item-label>
	<xsl:choose>
	  <xsl:when test="../@type='enumerated'">
	    <xsl:number count="cnx:item" format="1. "/>
	  </xsl:when>
	  <xsl:otherwise>
	    &#x2218;
	  </xsl:otherwise>
	</xsl:choose>
      </fo:list-item-label>
      <fo:list-item-body>
	<xsl:apply-templates />
      </fo:list-item-body>
    </fo:list-item>
  </xsl:template>


<!-- CODE :) -->
  <xsl:template match="cnx:codeblock">
     <fo:block font-size="8pt"
	       font-family="monospace"
	       white-space="pre"
	       background-color="#CCCCCC"
	       padding-top=".3cm"
	       padding-bottom=".3cm"
	       padding-left=".5cm"
	       padding-right=".5cm"
	       margin=".2cm">
      <xsl:copy-of select="@id"/>
      <xsl:apply-templates />
    </fo:block>
  </xsl:template>

  <xsl:template match="cnx:codeline">
    <fo:inline font-family="monospace"
	       font-size="10pt"
	       white-space="pre">
      <xsl:apply-templates />
    </fo:inline>
  </xsl:template>

  <xsl:template match="cnx:codeblock/cnx:emphasis|cnx:codeline/cnx:emphasis">
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
	      space-after=".5cm"
	      text-align="justify"
	      text-indent="0pt">
      <xsl:choose>
	<xsl:when test="@type">
	  <fo:inline font-weight="bold">
	    <xsl:call-template name="print-capital-attribute"/>:
	  </fo:inline>
	</xsl:when>
	<xsl:otherwise>
	  <fo:inline font-weight="bold">Note:</fo:inline>
	</xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates />
    </fo:block>
  </xsl:template>


  <xsl:template match="cnx:note[@type='footnote']">
    <fo:footnote>
      <fo:footnote-citation>
	<fo:inline font-size="10pt" 
		   vertical-align="super">
	  <xsl:number format="1" 
		      level="any" 
		      count="cnx:solution|qml:key|cnx:note[@type='footnote']"/>
	</fo:inline>
      </fo:footnote-citation>
      <fo:footnote-body>
	<fo:inline font-size="10pt" vertical-align="super">
	  <xsl:number format="1" 
		      level="any" 
		      count="cnx:solution|qml:key|cnx:note[@type='footnote']"/>
	</fo:inline>
	<fo:block font-size="10pt">
	  <xsl:apply-templates />
	</fo:block>
      </fo:footnote-body>
    </fo:footnote>
    </xsl:template>

<!-- DEFINITION :) -->
<!-- 
To get the Definition or Rules number concatenate it's modules number
attribute with its own number attribute.-->

  <xsl:template match="cnx:definition">
    <fo:block margin-left="1cm"
              margin-right="1cm"
	      space-before=".6cm"
	      space-after=".6cm"
	      text-align="justify">
      <xsl:copy-of select="@id"/>
      <xsl:apply-templates/>
    </fo:block>
  </xsl:template>
  
  <xsl:template match="cnx:meaning">
    <xsl:number level="single" count="cnx:meaning" format="1. "/>
    <xsl:apply-templates/>
  </xsl:template>
  
  <xsl:template match="cnx:definition/cnx:example">
    <xsl:choose>
      <xsl:when test="descendant::cnx:codeblock|descendant::cnx:figure">
	<fo:block> Example:
	  <xsl:apply-templates/>
	</fo:block>
      </xsl:when>
      <xsl:otherwise>
	<fo:inline font-style="italic">(<xsl:apply-templates/>)</fo:inline>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="cnx:term">
    <fo:inline font-weight="bold">
      <xsl:copy-of select="@id"/>
      <xsl:apply-templates />
    </fo:inline>
  </xsl:template>

  <xsl:template match="cnx:example/cnx:para[position()=1]">
     <xsl:apply-templates />
  </xsl:template>

<!-- RULE ?:) -->
  <xsl:template match="cnx:rule">
    <xsl:variable name="type" select="@type"/>
    <fo:block margin-left="1cm"
              margin-right="1cm"
	      space-before=".5cm"
	      space-after=".5cm">
      <xsl:copy-of select="@id"/>
      <fo:inline keep-with-next="always"
		 text-transform="capitalize"
		 font-weight="bold">
	<xsl:call-template name="print-capital-attribute"/>
	<xsl:text> </xsl:text>
	<xsl:choose>
	  <xsl:when test="@number">
	    <xsl:value-of select="@number"/>
	  </xsl:when>
	  <xsl:otherwise>
	    <xsl:number level="any"
			count="cnx:rule[@type=$type]"/>
	  </xsl:otherwise>
	</xsl:choose>: </fo:inline> 
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
      <fo:inline font-weight="bold">
	Proof<xsl:if test="count(cnx:proof)>1">
	  <xsl:number /></xsl:if>: 
      </fo:inline>
      <xsl:apply-templates/>
    </fo:block>
  </xsl:template>


<!-- EXAMPLE ?:) -->
  <xsl:template match="cnx:example">
    <fo:block margin-left="1cm"
	      margin-right="1cm"
	      space-before=".35cm"
	      space-after=".35cm">
      <xsl:copy-of select="@id"/>  
      <fo:inline keep-with-next="always"
		 font-weight="bold">
	Example 
	<xsl:choose>
	  <xsl:when test="@number">
	    <xsl:value-of select="@number"/>:
	  </xsl:when>
	  <xsl:otherwise>
	    <xsl:number count="cnx:example" level="any" />:
	  </xsl:otherwise>
	</xsl:choose>
      </fo:inline>
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
    <fo:block space-before=".5cm"
	      space-after=".5cm"
	      margin-left="1cm"
	      margin-right="1cm"
	      padding-left=".2cm">
      <xsl:copy-of select="@id"/>
      <fo:inline font-weight="bold">
	Exercise
	<xsl:choose>
	  <xsl:when test="@number">
	    <xsl:value-of select="@number"/>:
	  </xsl:when>
	  <xsl:otherwise>
	    <xsl:number count="cnx:exercise" level="any" />:
	  </xsl:otherwise>
	</xsl:choose>
      </fo:inline>
      <xsl:apply-templates />
    </fo:block>
  </xsl:template>
  
  <!-- Problem -->
  <xsl:template match="cnx:problem">
    <xsl:apply-templates />
  </xsl:template>

<!-- with this template i was trying to fix the 'footnotes go onto the wrong
 page' problem-->
 <!--  <xsl:template match="cnx:problem/text()"> -->
  <!--  <xsl:choose>
      <xsl:when test="last()=position()">
	hello <xsl:value-of select="normalize-space(.)" />   hello
      </xsl:when>
      <xsl:otherwise> 
	<xsl:value-of select="normalize-space()" /> -->
   <!--   </xsl:otherwise>
    </xsl:choose> -->
 <!-- </xsl:template> -->

 
  <xsl:template match="cnx:problem/cnx:para[position()=1]|cnx:solution/cnx:para[position()=1]">
    <xsl:apply-templates/> 
  </xsl:template> 
  
  
  <!-- Solution -->
  <xsl:template match="cnx:solution">
    <!-- no space in the following so that footnotes do not wrap away from the
    text they are referencing -->
    <fo:footnote><fo:inline font-size="10pt"
  vertical-align="super"><xsl:number format="1"  level="any"
  count="qml:key|cnx:solution|cnx:note[@type='footnote']"/>
      </fo:inline>
   <!--   </fo:footnote-citation> -->
      <fo:footnote-body>
	<fo:block font-size="10pt">
	  <fo:inline font-size="10pt" vertical-align="super">
	    <xsl:number format="1"
	                level="any" 
	                count="cnx:solution|qml:key|cnx:note[@type='footnote']"/>
	  </fo:inline>
	  <xsl:apply-templates />
	</fo:block>
      </fo:footnote-body>
    </fo:footnote>
  </xsl:template>


<!-- FIGURE ?:) -->
  <xsl:template match="cnx:figure">
    <fo:block keep-together.within-page="always"
	      space-before=".3cm"
	      space-after=".3cm"
	      text-align="center">
      <xsl:call-template name="figure-guts-0.3.5"/>
    </fo:block>
  </xsl:template>


  <xsl:template match="cnx:section/cnx:figure|cnx:content/cnx:figure">
    <fo:block border-top-style="solid"
	      border-top-width=".01cm"
	      border-bottom-style="solid"
	      border-bottom-width=".01cm"
	      keep-together.within-page="always">
      <xsl:copy-of select="@id"/>
      <fo:block text-align="center">
      <fo:leader leader-pattern="rule"
		 leader-length.minimum="13cm"
		 leader-length.optimum="13cm"
		 leader-length.maximum="13cm"
		 rule-style="solid"
		 text-align="center"/>
	</fo:block>

      <xsl:call-template name="figure-guts-0.3.5"/>
      <fo:block text-align="center">
	<fo:leader leader-pattern="rule"
		   leader-length.minimum="13cm"
		   leader-length.optimum="13cm"
		   leader-length.maximum="13cm"
		   rule-style="solid"
		   text-align="center"/>
      </fo:block>
      
    </fo:block>
  </xsl:template>


  <xsl:template name="figure-guts-0.3.5">
    <!-- first print figure name -->
    <xsl:apply-templates select="cnx:name"/>
    
    <!-- second, print actual pictures.  if there are subfigures and they are
    oriented horizontal, then make a horizontal table with subfigure cells.  if
    there are subfigures and orient is vertical or undefined, or if there are
    no subfigures, simply print a series of blocks.  -->
    <xsl:choose>
      <xsl:when test="cnx:subfigure and @orient='horizontal'">
	<fo:table>
	  <xsl:for-each select="cnx:subfigure">
	    <fo:table-column>
	      <xsl:attribute name="column-number">
		<xsl:number count="cnx:subfigure"/>
	      </xsl:attribute>
	      <xsl:attribute name="column-width"><xsl:number value="floor(100 div last())"/>%</xsl:attribute>
	    </fo:table-column>
	  </xsl:for-each>
	  <fo:table-row>
	    <xsl:apply-templates select="cnx:subfigure" mode="horizontal"/>
	  </fo:table-row>
	</fo:table>
      </xsl:when>
      <xsl:otherwise>
	<xsl:apply-templates select="cnx:media|cnx:table|cnx:codeblock"/>
	<xsl:apply-templates select="cnx:subfigure" mode="vertical"/>
      </xsl:otherwise>
    </xsl:choose>
    
    <!-- third, print the caption -->
    <xsl:choose>
      <xsl:when test="//cnx:caption">
	<xsl:apply-templates select="cnx:caption"/>
      </xsl:when>
      <xsl:otherwise>
	<fo:block margin-left="4cm"
		  margin-right="4cm"
		  text-align="center"
		  font-weight="bold"
		  font-size="10pt">
	  Figure
	  <xsl:choose>
	    <xsl:when test="@number">
	      <xsl:value-of select="@number"/>
	    </xsl:when>
	    <xsl:otherwise>
	      <xsl:number count="cnx:figure" level="any" />
	    </xsl:otherwise>
	  </xsl:choose>
	</fo:block>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- Name -->
  <xsl:template match="cnx:figure/cnx:name">
    <fo:block text-align="center"
	      font-weight="bold"
	      margin=".2cm" 
	      keep-with-next="always">
      <xsl:apply-templates />
    </fo:block>
  </xsl:template>

  
  <!-- Caption -->
  <xsl:template match="cnx:caption">
    <fo:block text-align="justify"
	      margin-left="2.5cm"
	      margin-right="2.5cm"
	      font-size="10pt">
      <fo:inline font-weight="bold">
	Figure
	<xsl:choose>
	  <xsl:when test="parent::*[@number]">
	    <xsl:value-of select="../@number"/>:
	  </xsl:when>
	  <xsl:otherwise>
	    <xsl:number count="cnx:figure" level="any" />:
	  </xsl:otherwise>
	</xsl:choose>
      </fo:inline>
      <xsl:apply-templates />
      <xsl:for-each select="../cnx:subfigure">
	<xsl:if test="../cnx:subfigure/cnx:caption">  
    <!--xsltproc bug  <xsl:number count="cnx:subfigure" format=" (a) "/>-->
	  <xsl:text> </xsl:text>
	  (<xsl:number count="cnx:subfigure" format="a"/>) 
	  <xsl:text> </xsl:text>
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
    <fo:block text-align="center"
	      font-size="10pt">    
      <xsl:copy-of select="@id"/>
      <!--xsltproc bug  <xsl:number count="cnx:subfigure" format="(a)"/>-->
      (<xsl:number count="cnx:subfigure" format="a"/>)
      <xsl:text> </xsl:text>
      <xsl:apply-templates select="cnx:name"/>
    </fo:block>
  </xsl:template>

  
  <xsl:template match="cnx:subfigure" mode="horizontal">
    <fo:table-cell>
      <xsl:attribute name="column-number"><xsl:number
      count="cnx:subfigure"/></xsl:attribute>
      <xsl:apply-templates select="cnx:media | cnx:codeblock | cnx:table"/>
      <fo:block text-align="center"
		font-size="10pt">  
	<xsl:copy-of select="@id"/>  
	<!-- xsltproc bug<xsl:number count="cnx:subfigure" format="(a)"/> -->
	(<xsl:number count="cnx:subfigure" format="a"/>)
	<xsl:text> </xsl:text>
	<xsl:apply-templates select="cnx:name"/>
      </fo:block>
    </fo:table-cell>
  </xsl:template>


<!-- MEDIA :) -->
  <xsl:template match="cnx:media[starts-with(@type,'image')]">
    <fo:block text-align="center">
      <xsl:copy-of select="@id"/>
      <fo:external-graphic>
	<xsl:attribute name="src">/net/mntb2/local/swi/web/xmlpages/<xsl:value-of select="translate(ancestor::cnx:module/@id,'m','')"/>/<xsl:value-of
	    select="@src"/>
	</xsl:attribute>
      </fo:external-graphic>
    </fo:block>
  </xsl:template>
  
  <xsl:template match="cnx:media[@type='application/x-java-applet']">
    <fo:block space-before="1cm"
	      space-after="1cm"
	      margin-left="1cm"
	      margin-right="1cm"
	      text-align="center">
      This is a Java Applet.  To view, please see
      http://cnx.rice.edu/modules/<xsl:value-of
      select="ancestor::cnx:module/@id"/>/latest/
    </fo:block>
  </xsl:template>


<!-- EQUATION -->
  <xsl:template match="cnx:equation">
    <fo:block text-align="centered"
	      keep-together.within-page="always">
      <xsl:copy-of select="@id"/>

      <fo:block text-align="start"
		font-weight="bold"
		margin-left="1cm"
		space-before=".25cm"
		keep-with-next="always">
	Equation
	<xsl:choose>
	  <xsl:when test="@number">
	    <xsl:value-of select="@number"/>:
	  </xsl:when>
	  <xsl:otherwise>
	    <xsl:number count="cnx:equation" level="any" />:
	  </xsl:otherwise>
	</xsl:choose>
	<xsl:apply-templates select="cnx:name"/>
      </fo:block>
      
      <xsl:apply-templates />
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
    <xsl:call-template name="refnumb0.3.5"/>
  </xsl:template>
  
  <xsl:template name="refnumb0.3.5">
    <!-- If the cnxn has text in it, then print a parenthesis.  Otherwise
    nothing. -->
    <xsl:if test="text()">
      <xsl:text> (</xsl:text>
    </xsl:if>
    <xsl:choose>
      <!--Checks if the tag that matches the key is of a certain type.
      For each tag that matches the equation (there should be only one) it
      prints a reference number.  Note that @id and @target are the same in this case.-->
      
      <xsl:when test="key('id',@target)[self::cnx:equation]">
	<xsl:for-each select="key('id',@target)">Equation
	  <xsl:choose>
	    <xsl:when test="@number">
	      <xsl:value-of select="@number"/>
	    </xsl:when>
	    <xsl:otherwise>
	      <xsl:number count="cnx:equation" level="any" />
	    </xsl:otherwise>
	  </xsl:choose>
	</xsl:for-each>
      </xsl:when>
      
      <xsl:when test="key('id',@target)[self::cnx:figure]">
	<xsl:for-each select="key('id',@target)">Figure
	  <xsl:choose>
	    <xsl:when test="@number">
	      <xsl:value-of select="@number"/>
	    </xsl:when>
	    <xsl:otherwise>
	      <xsl:number count="cnx:figure" level="any" />
	    </xsl:otherwise>
	  </xsl:choose>
	</xsl:for-each>
      </xsl:when>

      <xsl:when test="key('id',@target)[self::cnx:subfigure]">
	<xsl:for-each select="key('id',@target)">Subfigure
	  <xsl:choose>
	    <xsl:when test="@number">
	      <xsl:value-of select="@number"/>
	    </xsl:when>
	    <xsl:otherwise>
	      <xsl:number count="cnx:subfigure" level="any" />
	    </xsl:otherwise>
	  </xsl:choose>
	</xsl:for-each>
      </xsl:when>
      
      <xsl:when test="key('id',@target)[self::cnx:section]">
	<xsl:for-each select="key('id',@target)">Section
	  <xsl:choose>
	    <xsl:when test="@number">
	      <xsl:value-of select="@number"/>
	    </xsl:when>
	    <xsl:otherwise>
	      <xsl:number count="cnx:section" level="any" />
	    </xsl:otherwise>
	  </xsl:choose>
	</xsl:for-each>
      </xsl:when>
      
      <xsl:when test="key('id',@target)[self::cnx:example]">
	<xsl:for-each select="key('id',@target)">Example
	  <xsl:choose>
	    <xsl:when test="@number">
	      <xsl:value-of select="@number"/>
	    </xsl:when>
	    <xsl:otherwise>
	      <xsl:number count="cnx:example" level="any" />
	    </xsl:otherwise>
	  </xsl:choose>
	</xsl:for-each>
      </xsl:when>

      <xsl:when test="key('id',@target)[self::cnx:exercise]">
	<xsl:for-each select="key('id',@target)">Exercise
	  <xsl:choose>
	    <xsl:when test="@number">
	      <xsl:value-of select="@number"/>
	    </xsl:when>
	    <xsl:otherwise>
	      <xsl:number count="cnx:exercise" level="any" />
	    </xsl:otherwise>
	  </xsl:choose>
	</xsl:for-each>
      </xsl:when>
      
      <xsl:when test="key('id',@target)[self::cnx:definition]">
	<xsl:for-each select="key('id',@target)">Def.
	  <xsl:choose>
	    <xsl:when test="@number">
	      <xsl:value-of select="@number"/>:
	    </xsl:when>
	    <xsl:otherwise>
	      <xsl:number count="cnx:definition" level="any" />
	    </xsl:otherwise>
	  </xsl:choose>
	</xsl:for-each>
      </xsl:when>
      
      <xsl:when test="key('id',@target)[self::cnx:rule]">
	<xsl:variable name="type" select="@type"/>
	<xsl:for-each select="key('id',@target)">
	  <xsl:call-template name="print-capital-attribute">
	    <xsl:with-param name="attribute" select="@type"/>
	  </xsl:call-template>
	  <xsl:text> </xsl:text>
	  <xsl:choose>
	    <xsl:when test="@number">
	      <xsl:value-of select="@number"/>
	    </xsl:when>
	    <xsl:otherwise>
	      <xsl:number level="any"
			  count="cnx:rule[@type=$type]"/>
	    </xsl:otherwise>
	  </xsl:choose>
	</xsl:for-each>
      </xsl:when>
      
      <xsl:when test="key('id',@target)[self::*[cnx:name]]"><xsl:value-of select="key('id',@target)/cnx:name"/><!--,
	<fo:page-number-citation ref-id="{@target}"/>-->
      </xsl:when>
      
      <!--If all other options are exhausted, prints the page number.-->
      <xsl:otherwise>pg <fo:page-number-citation ref-id="{@target}"/><!--Page Number-->
      </xsl:otherwise>
    </xsl:choose>

    <!-- If the cnxn has text in it, then print a parenthesis.  Otherwise
    nothing. -->
    <xsl:if test="text()">
      <xsl:text>)</xsl:text> 
    </xsl:if>
  </xsl:template>
      

  <!--both target and module-->
  <xsl:template match="cnx:cnxn[@target and @module]">
    <xsl:apply-templates/> 
    <xsl:choose>
      <!--Case 1: When the module is in the book.-->
      <xsl:when test="key('id',@module)"><!--Test if the module is
	in the book. --><xsl:call-template name="refnumb0.3.5"/></xsl:when>

      <!--Case 2: When the module is not in the book.-->
      <xsl:otherwise>
	<fo:inline font-size="10pt">    
	  <xsl:if test="text()">
	    <xsl:text> (</xsl:text> 
	  </xsl:if>http://cnx.rice.edu/modules/<xsl:value-of select="@module"/>/latest/#<xsl:choose>
	    <xsl:when test="contains(@target,'*')">
	      <xsl:value-of select="substring-after(@target,'*')"/>
	    </xsl:when>
	    <xsl:otherwise>
	      <xsl:value-of select="@target"/>
	    </xsl:otherwise>
	  </xsl:choose>
	  <xsl:if test="text()">
	    <xsl:text>)</xsl:text> 
	  </xsl:if>
	</fo:inline>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  

  <!--only module and not target-->
  <xsl:template match="cnx:cnxn[@module and not(@target)]">
    <xsl:apply-templates/> 
    <xsl:choose> 
      <!--Case 1: When the module is inside the book-->
      <xsl:when test="key('id',@module)/."><!--test for the existance of this
    node-->    
	<xsl:if test="text()">
	  <xsl:text> (</xsl:text> 
	</xsl:if>
	Section <xsl:value-of select="key('id',@module)/@number"/> 
	<xsl:if test="text()">
	  <xsl:text>)</xsl:text> 
	</xsl:if>
      </xsl:when>

      <!--Case 2: When the module is outside the book-->
      <xsl:otherwise>
	<fo:inline font-size="10pt">
	  <xsl:if test="text()">
	    <xsl:text> (</xsl:text> 
	  </xsl:if>http://cnx.rice.edu/modules/<xsl:value-of select="@module"/>/latest/<xsl:if test="text()">
	    <xsl:text>)</xsl:text> 
	  </xsl:if>
	</fo:inline>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>


<!--  LINK :)  -->
  <xsl:template match="cnx:link">
    <xsl:apply-templates/>
    <fo:inline font-size="10pt">
      (<xsl:value-of select="@src"/>)
    </fo:inline>
  </xsl:template>


<!-- INLINE ATTRIBUTES :) -->
  <xsl:template match="cnx:emphasis|cnx:cite">
    <fo:inline font-style="italic">
      <xsl:apply-templates />
    </fo:inline>
  </xsl:template>


  <xsl:template match="cnx:cite/cnx:emphasis|cnx:emphasis/cnx:cite">
    <fo:inline font-style="normal">
      <xsl:apply-templates />
    </fo:inline>
  </xsl:template>


<!-- TABLE -->
  <xsl:template match="cnx:table">
    <fo:block space-before=".5cm"
	      space-after=".5cm">
      <xsl:apply-templates />
    </fo:block>
  </xsl:template>
  

<!-- NAMED TEMPLATES -->
  <xsl:template name="print-capital-attribute">
    <xsl:param name="attribute" select="@type"/>
    <xsl:value-of select="translate(substring($attribute, 1, 1),
    'abcdefghijklmnopqrstuvwxyz', 'ABCDEFGHIJKLMNOPQRSTUVWXYZ')"/><xsl:value-of
    select="substring($attribute, 2)"/>
  </xsl:template>


</xsl:stylesheet>
