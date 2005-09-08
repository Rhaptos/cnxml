<?xml version= "1.0" standalone="no"?>

<xsl:stylesheet version="1.0" 
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:cnx="http://cnx.rice.edu/cnxml/0.3"
		xmlns:fo="http://www.w3.org/1999/XSL/Format"
		xmlns:m="http://www.w3.org/1998/Math/MathML"
		xmlns:cnxml="http://cnx.rice.edu/contexts#"
                xmlns:qml="http://cnx.rice.edu/qml/1.0"
		xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  
  <!--A key that matches the type attribute of rule-->
  <xsl:key name="rule" match="cnx:rule" use="@type"/>  
 
  <!--ROOT node-->
  <xsl:template match="/">
    <xsl:apply-templates/>
  </xsl:template>

  <!--Identity Transformation-But also passes grpnumb, grptop parameters-->
  <!-- resort to ident if nothing else matches -->
  <xsl:template match="@*|node()">
    <xsl:param name='grpnumb'/>
    <xsl:param name='grptop'/>

    <xsl:copy>
      <xsl:apply-templates select="node()|@*">
	<xsl:with-param name='grpnumb'><xsl:value-of select="$grpnumb"/></xsl:with-param>
	<xsl:with-param name='grptop'><xsl:value-of select="$grptop"/></xsl:with-param>
      </xsl:apply-templates>
    </xsl:copy>

  </xsl:template> 

	  

  <!--LI that is not a child of a PAGEVIEW-->
  <!--Calculate the number-->
  <xsl:template
	  
  match="rdf:Seq/rdf:li[not(ancestor::rdf:Description[child::cnxml:class[normalize-space(.)='pageview']])]">
    <xsl:param name='grpnumb'/>
    <xsl:param name='grptop'/>

    <!--Appendix vs. other things-->
    <!--GRPTYPE is the value of the type attribute of the rdf:Description-->
    <xsl:variable name="grptype"><xsl:value-of
    select="normalize-space(rdf:Description/cnxml:type/.)"/></xsl:variable>
    
    <!--LOCALGRPTYPE is A if the type of the rdf:Description is
    Appendix, and is 1 otherwise.  This is used for the format
    attribute of xsl:number.-->
    <xsl:variable name="localgrptype">
      <xsl:choose>
	<xsl:when test="$grptype='Appendix'">A</xsl:when>
	<xsl:otherwise>1</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <!--LOCALGRPNUMB is the calculated number for this li (rdf:Description)-->
    <xsl:variable name="localgrpnumb">
      <xsl:choose>
	<!--Case 1: Calculate the number if it is an appendix.  Only count
	those rdf:li's that have a type attribute of Appendix.-->
	<xsl:when test="$grptype='Appendix'">
	  <xsl:number
	    count="rdf:li[normalize-space(rdf:Description/cnxml:type/.)='Appendix']" format="{$localgrptype}"/>
	</xsl:when>
	<!--Case 2: Calculate the number if it is not an appendix.  Only count
	those rdf:li's that don't have a type attribute of Appendix.-->
	<xsl:otherwise>
	  <xsl:number
	    count="rdf:li[normalize-space(rdf:Description/cnxml:type/.)!='Appendix']" format="{$localgrptype}"/>
	</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    
    <xsl:copy>
      <xsl:apply-templates select="@*|node()">

	
	<!--This is the number that is used to store the topmost
	parent group. For example, this stores the group or module at
	the top level of the tree.  It is essentially the chapter
	number.  This is what gets conctenated with figure, exercise,
	example, etc. numbers.-->
	<xsl:with-param name="grptop">
	  <xsl:choose>
	    <!--Case 1: If this one is a top level grouping pass the LOCALGRP NUMB-->
	    <xsl:when test="parent::rdf:Seq[parent::cnxml:children[parent::rdf:Description[@about='urn:context:root']]]">
	      <xsl:value-of select="$localgrpnumb"/>
	    </xsl:when>
	    <!--Case 2: Otherwise just pass the GRPTOP number on down the tree-->
	    <xsl:otherwise>
	      <xsl:value-of select="$grptop"/>
	    </xsl:otherwise>
	  </xsl:choose>
	</xsl:with-param>

	<!--This is the number that is used to store the nearest
	group's number.  For example, this stores the number of each
	group, and subgroup.-->
	<!--Concatentate GRPNUMB, a dot,  and LOCALGRPNUMB and pass as
	GRPNUMB. It will look like GRPNUMB.LOCALGRPNUMB-->
	<xsl:with-param name="grpnumb">
	  <xsl:value-of select="$grpnumb"/>.<xsl:value-of select="$localgrpnumb"/>
	</xsl:with-param>
	
      </xsl:apply-templates>
    </xsl:copy>
    
  </xsl:template>
  
  <!--rdf:Description for a MODULE, PAGEVIEW, and GROUP-->
  <!--Print the number as an attribute-->
  <xsl:template
    match="rdf:Description[child::cnxml:class[normalize-space(.)='module'
    or normalize-space(.)='pageview' or normalize-space(.)='group']]">
    <xsl:param name="grpnumb"/>
    <xsl:param name='grptop'/>

    <!--NUMB variable-->
    <!--The NUMB variable is for calculating the number attribute-->
    <xsl:variable name='numb'>
      <xsl:choose>
	<!--Case 1: GRPNUMB starts with a "." This occurs because at
	the very top of the tree there is a concatenation of a
	GRPNUMB, a dot, and LOCALGRPNUMB but GRPNUMB does not exist
	yet because it is at the very top.-->
	  <xsl:when test="starts-with($grpnumb,'.')">
	    <xsl:value-of select="substring-after($grpnumb,'.')"/>
	  </xsl:when>
	<!--Case 2: This is farther does the tree so this isn't a problem.-->
	  <xsl:otherwise>
	    <xsl:value-of select="$grpnumb"/>
	  </xsl:otherwise>
	</xsl:choose>
    </xsl:variable>

    <xsl:copy>
      <!--Copy attributes-->
      <xsl:copy-of select="@*"/>
      
      <!--Add number attribute-->
      <xsl:attribute name='number'><xsl:value-of select="$numb"/></xsl:attribute>
      
      <!--Apply-templates and pass GRPTOP and GRPNUMB down the tree-->
      <xsl:apply-templates>
	<xsl:with-param name="grptop"><xsl:value-of select="$grptop"/></xsl:with-param>
	<!--GRPNUMB is now NUMB-->
	<xsl:with-param name="grpnumb"><xsl:value-of select="$numb"/></xsl:with-param>
      </xsl:apply-templates>
    </xsl:copy>

  </xsl:template>

  <!-- MODULE -->
  <!--Copy over the number attribute that was previously
  calculated.-->
  <xsl:template match="cnx:module">
    <xsl:param name='grpnumb'/>
    <xsl:param name='grptop'/>
    
    <xsl:copy>
      <!--Create number attribute-->
      <xsl:attribute name="number"><xsl:value-of select="$grpnumb"/></xsl:attribute>

      <!--Apply-templates and pass GRPNUMB and GRPTOP-->
      <xsl:apply-templates select="@*|node()">
	<xsl:with-param name="grpnumb"><xsl:value-of select='$grpnumb'/></xsl:with-param>
	<xsl:with-param name="grptop"><xsl:value-of select='$grptop'/></xsl:with-param>
      </xsl:apply-templates>
    </xsl:copy>
  </xsl:template>
    

  <!-- SECTION (not in a PAGEVIEW) -->
  <xsl:template match="cnx:section[not(ancestor::rdf:Description[child::cnxml:class[normalize-space(.)='pageview']])]">
    <xsl:param name='grpnumb'/>
    <xsl:param name='grptop'/>

      <xsl:copy>
      <!--Add number attribute. Concatenate GRPNUMB with the number
      for the section.-->
      <xsl:attribute name="number">
	<xsl:value-of select="$grpnumb"/>.<xsl:number level="multiple" count="cnx:section"/>
      </xsl:attribute>
      
      <xsl:apply-templates select="@*|node()">
	<xsl:with-param name="grptop"><xsl:value-of select='$grptop'/></xsl:with-param>
	<xsl:with-param name='grpnumb'><xsl:value-of select="$grpnumb"/></xsl:with-param>
      </xsl:apply-templates>
      
    </xsl:copy>
  </xsl:template>

    <!-- SECTION (in PAGEVIEW) -->
    <xsl:template match="cnx:section[ancestor::rdf:Description[child::cnxml:class[normalize-space(.)='pageview']]]">
    <xsl:param name='grpnumb'/>
    <xsl:param name='grptop'/>

    <xsl:copy>
      <!--Add the number attribute. -->
      <xsl:attribute name="number">
	<!-- FIX ME: I don't think this is right.  This will work for sections,
	             but what about subsections. Shouldn't it be:
	
<xsl:value-of select="$grpnumb"/>.<xsl:number level="multiple"
      from="rdf:li/rdf:Description[child::cnxml:class[normalize-space(.)='pageview']]" count="cnx:section"/>
	
	-->
	<xsl:value-of select="$grpnumb"/>.<xsl:number level="any" from="rdf:li/rdf:Description[child::cnxml:class[normalize-space(.)='pageview']]"  count="cnx:section"/>
      </xsl:attribute>
      
      <xsl:apply-templates select="@*|node()">
	<xsl:with-param name="grptop"><xsl:value-of select='$grptop'/></xsl:with-param>
	<xsl:with-param name='grpnumb'><xsl:value-of select="$grpnumb"/></xsl:with-param>
      </xsl:apply-templates>
    </xsl:copy>
  </xsl:template>

  
    
<!--stopped here-->

  <!-- EVERYTHING ELSE INSIDE OF A CHAPTER -->
  <xsl:template match="cnx:figure|cnx:exercise|cnx:definition|cnx:equation|qml:item">
    <xsl:param name='grpnumb'/>
    <xsl:param name='grptop'/>
    
    <xsl:copy>
      <!--Add number attribute.  Concatenate GRPTOP with its number.
      Use level="any" to count across GROUPS.  Use from to start
      counting at the top most GROUP or MODULE.-->
      <xsl:attribute name="number">
	<xsl:value-of select="$grptop"/>.<xsl:number level="any" from="rdf:RDF/rdf:Description/cnxml:children/rdf:Seq/rdf:li"/>
      </xsl:attribute>
      
      <xsl:apply-templates select="@*|node()">
	<xsl:with-param name="grptop"><xsl:value-of select='$grptop'/></xsl:with-param>
	<xsl:with-param name='grpnumb'><xsl:value-of select="$grpnumb"/></xsl:with-param>
      </xsl:apply-templates>
      
    </xsl:copy>
  </xsl:template>
  
  <!-- EXAMPLE-->
  <xsl:template match="cnx:example[not(ancestor::cnx:definition)]">
    <xsl:param name='grpnumb'/>
    <xsl:param name='grptop'/>
    
    <xsl:copy>
      <!--Same as previous template.  Except, only count examples that
      are not in definitions.-->
	<xsl:attribute name="number">
	  <xsl:value-of select="$grptop"/>.<xsl:number
	    level="any"
	    from="rdf:RDF/cnxml:children/rdf:Seq/rdf:li/rdf:Description"
	    count="cnx:example[not(ancestor::cnx:definition)]"/>
	</xsl:attribute>

      <xsl:apply-templates select="@*|node()">
	<xsl:with-param name="grptop"><xsl:value-of select='$grptop'/></xsl:with-param>
	<xsl:with-param name='grpnumb'><xsl:value-of select="$grpnumb"/></xsl:with-param>
      </xsl:apply-templates>
      
    </xsl:copy>
  </xsl:template>
  
  
  <!--SUBFIGURE-->
  <xsl:template match="cnx:subfigure">
    <xsl:param name='grpnumb'/>
    <xsl:param name='grptop'/>
    
    <xsl:copy>
      <!--Add number attribute.  Same as above, except also
      concatenate xsl:number for the SUBFIGURE within the FIGURE.-->
      <xsl:attribute name="number">
	<xsl:value-of select="$grptop"/>.<xsl:number level="any"
	  from="rdf:RDF/cnxml:children/rdf:Seq/rdf:li/rdf:Description"
	  count="cnx:figure"/>.<xsl:number format="a"/>
      </xsl:attribute>
      
      <xsl:apply-templates select="@*|node()">
	<xsl:with-param name="grptop"><xsl:value-of select='$grptop'/></xsl:with-param>
	<xsl:with-param name='grpnumb'><xsl:value-of select="$grpnumb"/></xsl:with-param>
      </xsl:apply-templates>
      
    </xsl:copy>
  </xsl:template>
    
  <!--RULE-->
  <xsl:template match="cnx:rule">
    <xsl:param name='grpnumb'/>
    <xsl:param name='grptop'/>

    <xsl:variable name="type" select="@type"/>
    
    <xsl:copy>
      <!--Add the number attribute.  Same as previous except only
      count RULEs of the same type.-->
      <xsl:attribute name="number">
	<xsl:value-of select="$grptop"/>.<xsl:number level="any"
	  from="rdf:RDF/cnxml:children/rdf:Seq/rdf:li/rdf:Description"
	  count="cnx:rule[@type=$type]"/>
      </xsl:attribute>
      
      <xsl:apply-templates select="@*|node()">
	<xsl:with-param name="grptop"><xsl:value-of select='$grptop'/></xsl:with-param>
	<xsl:with-param name='grpnumb'><xsl:value-of select="$grpnumb"/></xsl:with-param>
      </xsl:apply-templates>
      
    </xsl:copy>
    
  </xsl:template>
  
  
  </xsl:stylesheet>
  
  
  
  
  








