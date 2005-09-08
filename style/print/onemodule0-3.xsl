<?xml version= "1.0" standalone="no"?>

<xsl:stylesheet version="1.0" 
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:fo="http://www.w3.org/1999/XSL/Format"
		xmlns:m="http://www.w3.org/1998/Math/MathML">

  <xsl:include href="module0-3.xsl"/>
  <xsl:include href="qml.xsl"/>
  <xsl:include href="mathml.xsl"/>
  
  <xsl:template match="/">
    <!-- ROOT -->
    
    <fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format">

      <!-- LAYOUT MASTER -->
      <fo:layout-master-set>
	<fo:simple-page-master page-master-name="all"
			       page-height="11in"
			       page-width="8.5in"
			       margin-top="1in"	    
			       margin-bottom="1in"	    
			       margin-left="1.25in"
			       margin-right="1.25in">
	  <fo:region-body/>
	</fo:simple-page-master>
      </fo:layout-master-set>
      
      <fo:page-sequence>
	
	<!-- SEQUENCE SPECIFICATION -->
	<fo:sequence-specification>
	  <fo:sequence-specifier-repeating page-master-even="all" />
	</fo:sequence-specification>
	<fo:flow flow-name="xsl-body">
	  <xsl:apply-templates />
	</fo:flow>
      </fo:page-sequence>
    </fo:root>
  </xsl:template>




</xsl:stylesheet>
  
  
  
  
  