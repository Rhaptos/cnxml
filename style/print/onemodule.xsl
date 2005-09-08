<?xml version= "1.0" standalone="no"?>

<xsl:stylesheet version="1.0" 
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:fo="http://www.w3.org/1999/XSL/Format"
		xmlns:m="http://www.w3.org/1998/Math/MathML">

  <xsl:include href="module-0.3.5.xsl"/>
  <xsl:include href="module-0.4.xsl"/>
  <xsl:include href="qml.xsl"/>
  <xsl:include href="mathml.xsl"/>

  
  <xsl:template match="/">
    <!-- ROOT -->
    
    <fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format">

      <!-- LAYOUT MASTER -->
      <fo:layout-master-set>
	<fo:simple-page-master master-name="page"
			       page-height="11in"
			       page-width="8.5in"
			       margin-top="1in"	    
			       margin-bottom="1in"	    
			       margin-left="1in"
			       margin-right="1in">
	  <fo:region-body/>
	</fo:simple-page-master>

	<!-- SEQUENCE SPECIFICATION -->
	<fo:page-sequence-master master-name="basic">
	  <fo:single-page-master-reference master-reference="page" />
	</fo:page-sequence-master>

      </fo:layout-master-set>
      
      <fo:page-sequence master-reference="basic">
	<fo:flow flow-name="xsl-region-body">
	  <xsl:apply-templates />
	</fo:flow>
      </fo:page-sequence>

    </fo:root>
  </xsl:template>




</xsl:stylesheet>
  
  
  
  
  