<?xml version= "1.0" standalone="no"?>


<!--FIX xsl DOCTYPE-->
<!--CHECK HOW IMPORTS WITH MATH-->
                            
<xsl:stylesheet version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:cnx="http://cnx.rice.edu/cnxml/0.3"
  xmlns="http://www.w3.org/1999/xhtml">
<!-- exclude-result-prefixes="cnx">-->

  <!--  NAME -->
  <!-- this adds a span so that css is able to wrap the title text. -->
  <xsl:template match="cnx:module/cnx:name">
      <cnx:name><span class="namebox">
          <xsl:apply-templates />
      </span></cnx:name>
  </xsl:template>



  <!--   MEDIA   --> 
  <!--turns into an img-->
  <xsl:template match="cnx:media[@type='image']">
    <img src="{@src}" />
  </xsl:template>


  <!--Remove these later.-->
  <!-- FIGURE -->
  <!--Deals with FIGURES with both SUBFIGURES and no SUBFIGURES.-->
  <xsl:template match="cnx:figure">	
    
    <!--Stores value of orient attribute of figure for use later.-->
    <xsl:variable name="orient">
      <xsl:value-of select="@orient"/>
    </xsl:variable>	
    
    <a name="{@id}"/>
    <br/>	
      
      <!--The case when there are no SUBFIGURES.-->
      <!--Prints: the NAME, then the MEDIA or TABLE, and then the CAPTION.-->
      <b><span class="figurename"><xsl:value-of
      select="cnx:name"/></span></b><br/>

    <div align="center">
      <xsl:apply-templates select="cnx:media|cnx:table|cnx:codeblock"/>
    </div>

      <!--The case when there are SUBFIGUREs.  -->
      <!--Two options for SUBFIGUREs depending on the value of the attribute
      of figure called orient.  The value of this attribute is saved as
      orient above. -->

      <table align="center">

	<!--For each SUBFIGURE: the NAME, then the MEDIA or TABLE, and then
	the SUBFIGURE's CAPTION is printed using an HTML table.--> 
	<xsl:choose>
	  <!--First option.  orient='vertical'-->
	  <xsl:when test="$orient='vertical'">
	    <xsl:for-each select="cnx:subfigure">
	      <tr>
		<td align='center'>
		  <span class="subfigurename"><xsl:apply-templates
		     select="cnx:name"/></span> 
		  <xsl:apply-templates
		     select="cnx:media|cnx:table|cnx:codeblock"/> 
		  <span class="subcaption"><xsl:apply-templates
		     select="cnx:caption"/></span>
		</td>
	      </tr>
	    </xsl:for-each>
	  </xsl:when>
	  <!--Second option.  orient='horizontal'-->
	  <xsl:otherwise>
	    <tr>
	      <xsl:for-each select="cnx:subfigure">
		<td align='center'>
		  <span class="subfigurename"><xsl:apply-templates
		     select="cnx:name"/></span> 
		  <xsl:apply-templates
		     select="cnx:media|cnx:table|cnx:codeblock"/> 
		  <span class="subcaption"><xsl:apply-templates
		     select="cnx:caption"/></span> 
		</td>
	      </xsl:for-each>
	    </tr>
	  </xsl:otherwise>
	</xsl:choose>
      </table>
      <!-- end commented code  (7.28.00) -->

      <!--CAPTIONs for FIGURE-->
      <!--Prints "Figure", then the figure number, then the caption.-->      
      <p class="caption">
	  <b>Figure <xsl:number level="any"
      count="cnx:figure"/></b><xsl:text> </xsl:text>

	  <xsl:apply-templates select="cnx:caption" />
      </p>
  </xsl:template>

  
  <!-- SUBFIGURE -->
  <!-- is this template necessary? -->
  <xsl:template match="cnx:subfigure">
    <td>
      <xsl:apply-templates select="cnx:media|cnx:table"/>
      <xsl:apply-templates select="cnx:caption"/>
    </td>
  </xsl:template>
  
  <!--SUBFIGURE's CAPTION-->
  <!--Called by the FIGURE template.-->
  <xsl:template match="cnx:subfigure/cnx:caption">
    <br/>
    <xsl:apply-templates/>
  </xsl:template>
  
  <!--SUBFIGURE's NAME-->
  <!--Called by the FIGURE template.-->
  <xsl:template match="cnx:subfigure/cnx:name">
    <xsl:apply-templates/>
    <br/>
  </xsl:template>
  
  <!--generic CAPTION-->
  <!--Called by the FIGURE template.-->
  <xsl:template match="cnx:caption">
    <xsl:apply-templates/>
  </xsl:template>

  
  <!--TABLE-->  
  <!--This is an early draft.  It needs major modification.-->
  <!--Should match up ELEMs and CATEGORY by desc attribute.-->
  <xsl:template match="cnx:table">
    <xsl:choose>
      
    <xsl:when test=".//cnx:row">
      <span class="tablename"><xsl:value-of select="cnx:name" /></span>
      <xsl:apply-templates />
    </xsl:when>

    <xsl:otherwise>
      <table border="3" align="center">
	<!--Prints CATEGORY as headers.-->
	<xsl:for-each select="cnx:categories">
	  <tr>
	    <xsl:for-each select="cnx:category">
	      <td><B><xsl:apply-templates/></B></td>
	    </xsl:for-each>
	</tr>
	</xsl:for-each>
	
      <!--Prints the content of ELEMs in the order they are listed
      within each GROUP.-->
      <xsl:for-each select="cnx:group">
	<tr>
	  <xsl:for-each select="cnx:elem">
	    <td><xsl:apply-templates/></td>
	  </xsl:for-each>
	</tr>
      </xsl:for-each>
    </table>

	<!--generic CAPTION-->
	<xsl:apply-templates select="cnx:caption"/>

      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <!-- end early draft (7.28.00) -->

  <xsl:include href="table0-3.xsl"/>


</xsl:stylesheet>
