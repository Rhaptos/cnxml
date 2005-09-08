<?xml version= "1.0" standalone="no"?>
<!DOCTYPE xsl:stylesheet SYSTEM "http://cnx.rice.edu/technology/mathml2/DTD/moz-mathml.ent">

<!--FIX xsl DOCTYPE-->
<!--CHECK HOW IMPORTS WITH MATH-->
<!--CHECK IF CNXN STILL WORKS RIGHT with eqn-->
                            
<xsl:stylesheet version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:cnx="http://cnx.rice.edu/cnxml/0.2"
  xmlns="http://www.w3.org/1999/xhtml"
  exclude-result-prefixes="cnx">

  <!--This key is used for the cnxn template.-->
  <xsl:key name='id' match='*' use='@id'/>

  <!--CNXN-->  
  <!-- CNXN can have a target attribute, a module attribute, or both.  But it must have one of them.-->
  <xsl:template match="cnx:cnxn">
    <xsl:choose>
      
      <!--if both target and module-->
      <xsl:when test="@target and @module">
	<a href="http://cnx.rice.edu/cgi-bin/showmodule.cgi?id={@module}/#{@target}">
	  <xsl:if test="not(string())">*</xsl:if>
	  <xsl:apply-templates/></a>
      </xsl:when>
      
      <!--if only module and not target-->
      <xsl:when test="not(@target)">
	<a href="http://cnx.rice.edu/cgi-bin/showmodule.cgi?id={@module}"><xsl:apply-templates/></a>
      </xsl:when>
      
      <!--if only target and no module-->
      <xsl:otherwise>
	<!--what about subfigures?-->
	
	<!--There is a hierarchy of options.  
	First, it checks if the user entered something inside the cnxn tag.
	Next, it checks if it links to an equation, then a figure, then a tag
	with a name attribute, and it finally defaults to printing generic content.
	It tests for the first three things using a key that is defined at the
	top of the file.  The key is called id and matches a tag that
	has an id with the same value as @target.-->
	<xsl:choose>
	  <!--Checks if the cnxn tag contains text.
	  Prints an anchor, and the contents of the cnxn tag. Note that @target is used.-->
	  <xsl:when test="node()">
	    <a href="#{@target}"><xsl:apply-templates/></a>
	  </xsl:when>
	  <!--Checks if the tag that matches the key is an equation.
	  For each tag that matches the equation (there should be only one) it
	  prints an anchor, and Eqn. followed by the equation number.
	  Note that @id and @target are the same in this case.-->
	  <xsl:when test="key('id',@target)[self::cnx:equation]">
	    <xsl:for-each select="key('id',@target)">
	      <a href="#{@id}">Eqn. <xsl:number level="any"/></a>
	    </xsl:for-each>
	  </xsl:when>
	  <!--Checks if the tag that matches the key is a figure.
	  For each tag that matches the figure (there should be only one) it
	  prints an anchor, and Fig. followed by the equation number.
	  Note that @id and @target are the same in this case.-->
	  <xsl:when test="key('id',@target)[self::cnx:figure]">
	    <xsl:for-each select="key('id',@target)">
	      <a href="#{@id}">Fig. <xsl:number level="any"/></a>
	    </xsl:for-each>
	  </xsl:when>
	  <!--Checks if the tag that matches the key has a name child.
	  Prints an anchor, and the value of the name.  Note that @target is
	  used because the cnxn is still the active node.-->
	  <xsl:when test="key('id',@target)[self::*[cnx:name]]">
	    <a href="#{@target}"><xsl:value-of select="key('id',@target)/cnx:name"/></a>
	  </xsl:when>
	  
	  <!--All other options are exhausted.  It prints an anchor
	  and Ref. as a generic substitute.-->
	  <xsl:otherwise>
	    <a href="#{@target}">Ref.</a>
	  </xsl:otherwise>
	</xsl:choose>
      </xsl:otherwise>
      
    </xsl:choose>
  </xsl:template>
  
  <!--	 LINK	       -->
  <!--turns into an anchor -->
  <xsl:template match='cnx:link'>
    <a href="{@src}">
      <xsl:apply-templates/>
    </a>
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
    <center>

      <!--The case when their are no SUBFIGURES.-->
      <!--Prints: the NAME, then the MEDIA or TABLE, and then the CAPTION.-->
      <b><xsl:apply-templates select="cnx:name"/></b><br/>
      <xsl:apply-templates select="cnx:media|cnx:table"/>


      <!--The case when their are SUBFIGUREs.  -->
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
		  <xsl:apply-templates select="cnx:name"/>
		  <xsl:apply-templates select="cnx:media|cnx:table"/>
		  <xsl:apply-templates select="cnx:caption"/>
		</td>
	      </tr>
	    </xsl:for-each>
	  </xsl:when>
	  <!--Second option.  orient='horizontal'-->
	  <xsl:otherwise>
	    <tr>
	      <xsl:for-each select="cnx:subfigure">
		<td align='center'>
		  <xsl:apply-templates select="cnx:name"/>
		  <xsl:apply-templates select="cnx:media|cnx:table"/>
		  <xsl:apply-templates select="cnx:caption"/>
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
	<font size="-1">
	  <b>Figure <xsl:number level="any" count="cnx:figure"/></b>&nbsp;
	  <xsl:apply-templates select="cnx:caption"/>
	</font>	
      </p>
    </center>
    <br/>
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
  </xsl:template>
  <!-- end early draft (7.28.00) -->
  
</xsl:stylesheet>
