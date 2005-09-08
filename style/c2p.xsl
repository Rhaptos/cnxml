<?xml version= "1.0" standalone="no"?>
<!DOCTYPE xsl:stylesheet SYSTEM "http://cnx.rice.edu/technology/mathml2/DTD/moz-mathml.ent">
                      
<xsl:stylesheet version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:m="http://www.w3.org/1998/Math/MathML"
  xmlns:cnx="http://cnx.rice.edu/cnxml/0.2"
  xmlns="http://www.w3.org/1999/xhtml">

  
<!--This key is used for the cnxn template.-->
<xsl:key name='id' match='*' use='@id'/>

  <!-- Root Node -->
  <xsl:template match="/">
    <xsl:processing-instruction name="xml-stylesheet">
      type="text/css" href="http://cnx.rice.edu/cnxml/0.2/style/cnxml.css"
    </xsl:processing-instruction>  

    <html>
      <head>
      <link rel="stylesheet" type="text/css" href="http://cnx.rice.edu/cnxml/0.2/style/cnxml.css"/>
        <title><xsl:value-of select="cnx:module/cnx:name"/></title>
        
	<!--	Javascript so that answer can appear on click.	-->
	<script language="javascript">
	  function getExerciseSolution(id)
	  {
	     return document.getElementById(id).getElementsByTagName("div").item(1);
	  }
	  function showSolution(id) 
	  {
	     getExerciseSolution(id).style.display="block";
	  }
	  function hideSolution(id) 
	  {
	     getExerciseSolution(id).style.display="none";
	  }
	</script>
      </head>	
      <xsl:apply-templates/>
    </html>
  </xsl:template>
  
  
  <!-- Header and Body for the Module -->
  <xsl:template match="cnx:module">
    <body>
      <h1><xsl:value-of select="cnx:name"/></h1>
      
      <xsl:apply-templates/>
      <!-- Print footnotes in order at the bottom 
      
      <xsl:for-each select="//annotation">
	<xsl:variable name="foot">
	  <xsl:number level="any"/>
	</xsl:variable>
	<xsl:if test="$foot='1'">
	  <hr/>
	</xsl:if>
	<sup>		
	  <a name="FOOT{$foot}"><xsl:value-of select='$foot'/></a>
	</sup>  
	<xsl:apply-templates/>
	<br/>
      </xsl:for-each>-->
      <!-- Through here. 8/14/00 by Sarah  -->
      <hr/>
      <a href='http://cnx.rice.edu/forms/bugReport.cfm?id={@id}'>Submit a BUG REPORT.</a><br/>
      <a href='http://cnx.rice.edu/comment.html'>Submit a SUGGESTION.</a> 
    </body>
  </xsl:template>
  
  
  <!-- Section Header -->
  <xsl:template match="cnx:module/cnx:section">
    <h2 id='{@id}'><xsl:value-of select="cnx:name"/></h2>
    <xsl:apply-templates/>
  </xsl:template>
  
  
  <!-- Subsection Header -->
  <xsl:template match="cnx:module/cnx:section/cnx:section">
    <h3 id='{@id}'><xsl:value-of select="cnx:name"/></h3>
    <xsl:apply-templates/>
  </xsl:template>

    <!-- Sub-subsection Header -->
  <xsl:template match="cnx:module/cnx:section/cnx:section/cnx:section">
    <h4 id='{@id}'><xsl:value-of select="cnx:name"/></h4>
    <xsl:apply-templates/>
  </xsl:template>

  <!-- Emphasized Text -->
  <xsl:template match="cnx:emphasis">
    <i><xsl:apply-templates/></i>
  </xsl:template>

  
  <!-- Paragraph. Formatting in CSS under p.para -->
  <xsl:template match="cnx:para">
    <p class="para" id='{@id}'>
      <xsl:apply-templates/>
    </p>
  </xsl:template>

  
  <!-- Default list -->
  <xsl:template match="cnx:list">
    <ul id='{@id}'>
      <xsl:for-each select="cnx:item">
	<li id='{@id}'><xsl:apply-templates/></li>
      </xsl:for-each>
    </ul>
  </xsl:template>
  
  <!-- Numbered lists -->
  <xsl:template match="cnx:list[@type='enumerated']">
    <ol id='{@id}'>
      <xsl:for-each select="cnx:item">
	<li id='{@id}'><xsl:apply-templates/></li>
      </xsl:for-each>
    </ol>
  </xsl:template>

  
  <!-- Code -->
  <xsl:template match="cnx:codeblock">
    <pre><xsl:apply-templates/></pre>
  </xsl:template>

  <xsl:template match="cnx:codeline">
  <code><xsl:apply-templates/></code>
  </xsl:template>	  
  
  <!-- Figure -->
  <xsl:template match="cnx:figure">	
    
    <xsl:variable name="orient">
      <xsl:value-of select="@orient"/>
    </xsl:variable>	
    
    <a name="{@id}"/>
    <br/>	
    <center>
      <b><xsl:apply-templates select="cnx:name"/></b><br/>
      <xsl:apply-templates select="cnx:media|cnx:table"/>
      
      <!-- Change this when we figure out how to have two different possibilities-->	
      <table align="center">
	<xsl:choose>
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
      
      <p class="caption">
	<font size="-1">
	  <b>Figure <xsl:number level="any" count="cnx:figure"/></b>&nbsp;
	  <xsl:apply-templates select="cnx:caption"/>
	</font>	
      </p>
    </center>
    <br/>
  </xsl:template>

  
  <!-- SubFigure -->
  <xsl:template match="cnx:subfigure">
    <td>
      <xsl:apply-templates select="cnx:media|cnx:table"/>
      <xsl:apply-templates select="cnx:caption"/>
    </td>
  </xsl:template>

  <xsl:template match="cnx:subfigure/cnx:caption">
    <br/>
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="cnx:subfigure/cnx:name">
    <xsl:apply-templates/>
    <br/>
  </xsl:template>
  
  <xsl:template match="cnx:media[@type='image']">
    <img>
      <xsl:attribute name="src">
	<xsl:value-of select="@src"/>
      </xsl:attribute>
    </img>
  </xsl:template>

  
  <xsl:template match="cnx:caption">
    <xsl:apply-templates/>
  </xsl:template>
  
  <!-- math:math puts the math tag in the math namespace   -->  
  
  <xsl:template match="m:math">
    <m:math>
      <xsl:if test="@*[local-name()='display']">
	<xsl:attribute name="display">
	  <xsl:value-of select="@display"/>
	</xsl:attribute>
      </xsl:if>
      <xsl:apply-templates/>
    </m:math>
  </xsl:template>


  <xsl:template match="cnx:equation">
    <!--do something with the para because eqn can go in paras-->
    <center>
      <a name="{@id}">	
	<table width="100%"> <tr>
	    <td width="30"></td>     
	    <td align="center" valign="center">
	      <xsl:apply-templates/>
	    </td>
	    <td width="30" align="right">	
	      <xsl:number level="any" count="cnx:equation" format="(1)"/>
	    </td>
	  </tr>
	</table>
      </a>
    </center>
  </xsl:template>
  

  <!-- cnxn can have a target attribute, a module attribute, or both.  But it must have one of them.-->
  <xsl:template match="cnx:cnxn">
    <xsl:choose>
      
      <!--both target and module-->
      <xsl:when test="@target and @module">
	<a href="http://cnx.rice.edu/cgi-bin/showmodule.cgi?id={@module}/#{@target}">
	  <xsl:if test="not(string())">*</xsl:if>
	  <xsl:apply-templates/></a>
      </xsl:when>
      
      <!--only module and not target-->
      <xsl:when test="not(@target)">
	<a href="http://cnx.rice.edu/cgi-bin/showmodule.cgi?id={@module}"><xsl:apply-templates/></a>
      </xsl:when>
            
<!--only target and no module-->
      <xsl:otherwise>
<!--what about subfigures-->

<!--There is a hierarchy of options.  
First, it checks if the user entered something inside the cnxn tag.
	Next, it checks if it links to an equation, then a figure, then a tag
	with a name tag, and it finally defaults to printing generic content.
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
	  <xsl:when test="key('id',@target)[self::equation]">
	      <xsl:for-each select="key('id',@target)">
		  <a href="#{@id}">Eqn. <xsl:number level="any"/></a>
	      </xsl:for-each>
	  </xsl:when>
<!--Checks if the tag that matches the key is a figure.
For each tag that matches the figure (there should be only one) it
	  prints an anchor, and Fig. followed by the equation number.
	  Note that @id and @target are the same in this case.-->
	  <xsl:when test="key('id',@target)[self::figure]">
	    <xsl:for-each select="key('id',@target)">
		<a href="#{@id}">Fig. <xsl:number level="any"/></a>
	    </xsl:for-each>
	  </xsl:when>
<!--Checks if the tag that matches the key has a name tag.
Prints an anchor, and the value of the name.  Note that @target is
	  used because the cnxn is still the active node.-->
	  <xsl:when test="key('id',@target)/cnx:name">
	    <a href="#{@target}"><xsl:value-of select="key('id',@target)/cnx:name"/></a>
	  </xsl:when>

<!--All other options are exhausted.  It prints an anchor and Ref. as -->
<!--a generic substitute.-->
	  <xsl:otherwise>
	    <a href="#{@target}">Ref.</a>
	  </xsl:otherwise>
	</xsl:choose>
      </xsl:otherwise>
      
    </xsl:choose>
  </xsl:template>
  

  <xsl:template match="cnx:definition">
    <div class='definition'>
      <span class='term'><b>Definition: </b> <xsl:apply-templates select='cnx:term'/>  </span>
      <xsl:apply-templates select='cnx:meaning|cnx:example'/>
    </div>
  </xsl:template>

  <xsl:template match="cnx:term">
    <span class='term'><xsl:apply-templates/></span>
  </xsl:template>
  <xsl:template match="cnx:definition/cnx:term">
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="cnx:meaning">
    <div class='meaning'><xsl:number level="single"/>. <xsl:apply-templates/></div>
  </xsl:template>
 
  <xsl:template match="cnx:definition/cnx:example">
    <div class='example'>
      <b>Example</b><br/><xsl:apply-templates/>
    </div>
  </xsl:template> 

  <!--change this to look for the type="teacher"
  <xsl:template match="annotation">
    <xsl:variable name="foot">
      <xsl:number level="any"/>
    </xsl:variable>
    <sup><a href="#FOOT{$foot}"><xsl:value-of select='$foot'/></a></sup>
  </xsl:template>
  -->
  
  
  
  <!--
  This prevents the keywords from printing in the module.
  -->
  <xsl:template match="cnx:keywordlist">
  </xsl:template>
<!--Don't display name-->
  <xsl:template match='cnx:name'>
  </xsl:template>
  
  <!--	Added to make exercises appear and disappear -->
  <xsl:template match="cnx:exercise">
    <div id="{@id}">
      <div class="problem" onclick="showSolution('{@id}')">
	<b>Question <xsl:number level="any" count="cnx:exercise"/>: </b>
	<i><xsl:apply-templates select="cnx:problem"/></i>
      </div>
      <div class="solution" onclick="hideSolution('{@id}')">
	<b>Answer</b> <xsl:apply-templates select="cnx:solution"/>
      </div>
    </div>
  </xsl:template>

  
  <xsl:template match="cnx:problem">
    <xsl:apply-templates/>
  </xsl:template>
  

  <xsl:template match="cnx:solution">
    <xsl:apply-templates/>
  </xsl:template>
  
  <!--	Added by Sarah on 8/17/00 -->
  
  <xsl:template match="cnx:example">
    <hr/>
    <b id='{@id}'>Example</b><br/>
    <xsl:apply-templates/>
    <hr/> 
  </xsl:template>
  
  
  <!--This is an early draft.  It needs major modification.-->
  <xsl:template match="cnx:table">
    <table border="3" align="center">
      <xsl:for-each select="cnx:categories">
	<tr>
	  <xsl:for-each select="cnx:category">
	    <td><B><xsl:apply-templates/></B></td>
	  </xsl:for-each>
	</tr>
      </xsl:for-each>
      <xsl:for-each select="cnx:group">
	<tr>
	  <xsl:for-each select="cnx:elem">
	    <td><xsl:apply-templates/></td>
	  </xsl:for-each>
	</tr>
      </xsl:for-each>
    </table>
    <xsl:apply-templates select="cnx:caption"/>
  </xsl:template>
  <!-- end early draft (7.28.00) -->
  
  <!--	 External link	       -->
  <xsl:template match='cnx:link'>
    <a>
      <xsl:attribute name='href'>
	<xsl:value-of select="@src"/>
      </xsl:attribute>
      <xsl:apply-templates/>
    </a>
  </xsl:template>
  <!--	added by Sarah (8-18-00)-->
  
  <xsl:template match='cnx:cite'>
    <span class="cite"><xsl:apply-templates/></span>
  </xsl:template>
  
  <xsl:template match="cnx:abstract">
  </xsl:template>

  <xsl:template match="cnx:authorlist">
  </xsl:template>
</xsl:stylesheet>













