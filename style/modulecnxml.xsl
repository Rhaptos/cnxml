<?xml version= "1.0" encoding="ISO-8859-1"?>
<!DOCTYPE module SYSTEM "http://mntb.ece.rice.edu/dtd/cnxml.dtd"
[<!ENTITY % mathml SYSTEM "http://mntb.ece.rice.edu/dtd/mathml.dtd">
%mathml;]>

<xsl:stylesheet version="1.0" 
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:math="http://www.w3.org/1998/Math/MathML"
xmlns="http://www.w3.org/TR/REC-html40">

<!-- Root Node -->
<xsl:template match="/">
	<xsl:processing-instruction name="cocoon-format">
		type="text/html"
	</xsl:processing-instruction>
<!--	<xsl:processing-instruction name="xml-stylesheet">
		type="text/css" href="http://mntb.ece.rice.edu/stylesheets/cnxml.css"
	</xsl:processing-instruction> -->
<html>
    <head> 
        <title>
		<xsl:for-each select="course">
			<xsl:value-of select="@name"/>
		</xsl:for-each>
        </title>
    </head>	
        <xsl:apply-templates/>
</html>
</xsl:template>


<!-- Body for the Table  -->
<!-- This adds the headers at the top. -->
<xsl:template match="modulelist">
    <body>
        <table border="3">
		<tr>
			<xsl:attribute name='style'>
				       <xsl:text>background-color:
				       teal;
				       font-weight: bold;
				       </xsl:text>
			</xsl:attribute>
			<td>Name</td>
			<td>ID</td>
			<td>Author</td>
			<td>URI</td>
		</tr>
	<xsl:apply-templates/>
	</table>
    </body>
</xsl:template>

<!-- This adds the value for each row -->
<xsl:template match='module'>
	      <tr>
		<td><xsl:value-of select='@name'/></td>
		<td><xsl:value-of select='@id'/></td>
		<td><xsl:value-of select='author/@name'/></td>
		<td><a>
			<xsl:attribute name="href">
				       <xsl:value-of select='@uri'/>
			</xsl:attribute>
					<xsl:value-of select='@uri'/>
			</a>
		</td>
	      </tr>
</xsl:template>

</xsl:stylesheet>













