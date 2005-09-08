<?xml version="1.0" encoding="UTF-8"?> 
<!DOCTYPE xsl:stylesheet SYSTEM "http://cnx.rice.edu/cnxml/0.3/DTD/mozcompat.ent">

<!--  Copyright (c) 2000 Xerox Corporation.  All Rights Reserved.  

  Unlimited use, reproduction, and distribution of this software is
  permitted.  Any copy of this software must include both the above
  copyright notice of Xerox Corporation and this paragraph.  Any
  distribution of this software must comply with all applicable United
  States export control laws.  This software is made available AS IS,
  and XEROX CORPORATION DISCLAIMS ALL WARRANTIES, EXPRESS OR IMPLIED,
  INCLUDING WITHOUT LIMITATION THE IMPLIED WARRANTIES OF MERCHANTABILITY
  AND FITNESS FOR A PARTICULAR PURPOSE, AND NOTWITHSTANDING ANY OTHER
  PROVISION CONTAINED HEREIN, ANY LIABILITY FOR DAMAGES RESULTING FROM
  THE SOFTWARE OR ITS USE IS EXPRESSLY DISCLAIMED, WHETHER ARISING IN
  CONTRACT, TORT (INCLUDING NEGLIGENCE) OR STRICT LIABILITY, EVEN IF
  XEROX CORPORATION IS ADVISED OF THE POSSIBILITY OF SUCH DAMAGES.

  emmanuel.pietriga@xrce.xerox.com

  This work is done for the OPERA project (INRIA) during a thesis work under a 
  CIFRE contract.

  April 2000
-->
<!--
Author: E. Pietriga {emmanuel.pietriga@xrce.xerox.com}
Created: 02/10/2000
Last updated: 12/04/2000
-->
<!-- general rules: 
*based on the 13 November 2000 WD   http://www.w3.org/TR/2000/CR-MathML2-20001113
*comments about char refs which do not work are related to Amaya 3.0, since this stylesheet was tested using Amaya as the presentation renderer; perhaps some of the char refs said not to be working in Amaya will work with another renderer.
*the subtrees returned by a template decide for themselves if they have to be surrounded by an mrow element (sometimes it is an mfenced element)
*they never add brackets to themselves (or this will be an exception); it is the parent (template from which this one has been called) which decides this since the need for brackets depends on the context
-->
<!-- TO DO LIST
*handling of compose and inverse is probably not good enough
*as for divide, we could use the dotted notation for differentiation provided apply has the appropriate 'other' attribute (which is not defined yet ans will perhaps never be: it does not seem to be something that will be specified, rather application dependant)
*have to find a way to detect when a vector should be represented verticaly (we do that only in one case: when preceding sibling is a matrix and operation is a multiplication; there are other cases where a vertical vector is the correct representation, but they are not yet supported)
-->

<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
  xmlns:m="http://www.w3.org/1998/Math/MathML" 
  xmlns="http://www.w3.org/1998/Math/MathML"
  > <!--exclude-result-prefixes="m #default"-->

<!-- #################### 4.4.1 #################### -->

<!-- number-->
<!-- support for bases and types-->
<xsl:template match="m:cn">
  <xsl:choose>
  <xsl:when test="@base and @base!=10">  <!-- base specified and different from 10 ; if base = 10 we do not display it -->
    <msub>
      <mrow> <!-- mrow to be sure that the base is actually the element put as sub in case the number is a composed one-->
      <xsl:choose>  
      <xsl:when test="./@type='complex-cartesian' or ./@type='complex'">
        <mn><xsl:value-of select="text()[position()=1]"/></mn>
	<xsl:choose>
	<xsl:when test="contains(text()[position()=2],'-')">
	  <mo>-</mo><mn><xsl:value-of select="substring-after(text()[position()=2],'-')"/></mn> 
	  <!--substring-after does not seem to work well in XT : if imaginary part is expressed with at least one space char before the minus sign, then it does not work (we end up with two minus sign since the one in the text is kept)-->
	</xsl:when>
	<xsl:otherwise>
	  <mo>+</mo><mn><xsl:value-of select="text()[position()=2]"/></mn>
	</xsl:otherwise>
	</xsl:choose>
	<mo><xsl:text disable-output-escaping="yes">&InvisibleTimes;</xsl:text></mo><mi><xsl:text disable-output-escaping="yes">&ImaginaryI;</xsl:text></mi>  <!-- perhaps ii-->
      </xsl:when>
      <xsl:when test="./@type='complex-polar'">
        <m:mrow><mn><xsl:value-of select="text()[position()=1]"/></mn><mo>&angle;</mo><mn><xsl:value-of select="text()[position()=2]"/></mn></m:mrow>
      </xsl:when>
      <xsl:when test="./@type='rational'">
        <mn><xsl:value-of select="text()[position()=1]"/></mn><mo>/</mo><mn><xsl:value-of select="text()[position()=2]"/></mn>
      </xsl:when>
      <xsl:otherwise>
        <mn><xsl:value-of select="."/></mn>
      </xsl:otherwise>
      </xsl:choose>
      </mrow>
      <mn><xsl:value-of select="@base"/></mn>
    </msub>
  </xsl:when>
  <xsl:otherwise>  <!-- no base specified -->
    <xsl:choose>  
    <xsl:when test="./@type='complex-cartesian' or ./@type='complex'">
      <mrow>
        <mn><xsl:value-of select="text()[position()=1]"/></mn>
        <xsl:choose>
        <xsl:when test="contains(text()[position()=2],'-')">
  	  <mo>-</mo><mn><xsl:value-of select="substring(text()[position()=2],2)"/></mn><mo><xsl:text disable-output-escaping="yes">&InvisibleTimes;</xsl:text></mo><mi><xsl:text disable-output-escaping="yes">&ImaginaryI;</xsl:text></mi><!-- perhaps ii-->
        </xsl:when>
        <xsl:otherwise>
	  <mo>+</mo><mn><xsl:value-of select="text()[position()=2]"/></mn><mo><xsl:text disable-output-escaping="yes">&InvisibleTimes;</xsl:text></mo><mi><xsl:text disable-output-escaping="yes">&ImaginaryI;</xsl:text></mi><!-- perhaps ii-->
        </xsl:otherwise>
        </xsl:choose>
      </mrow>
    </xsl:when>
    <xsl:when test="./@type='complex-polar'">
      <m:mrow><mn><xsl:value-of select="text()[position()=1]"/></mn><mo>&angle;</mo><mn><xsl:value-of select="text()[position()=2]"/></mn></m:mrow>
    </xsl:when> 
    <xsl:when test="./@type='e-notation'">
      <mrow>
        <mn><xsl:value-of select="text()[position()=1]"/></mn>
	<mo>&times;</mo>
	<msup><mn>10</mn><mn><xsl:value-of select="text()[position()=2]"/></mn></msup>
      </mrow>
    </xsl:when>
    <xsl:when test="./@type='rational'">
      <mrow><mn><xsl:value-of select="text()[position()=1]"/></mn><mo>/</mo><mn><xsl:value-of select="text()[position()=2]"/></mn></mrow>
    </xsl:when>
    <xsl:otherwise>
      <mn><xsl:value-of select="."/></mn>
    </xsl:otherwise>
    </xsl:choose>
  </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<!-- identifier -->
<!--support for presentation markup-->
<xsl:template match="m:ci">
  <xsl:choose>  
  <xsl:when test="./@type='complex-cartesian' or ./@type='complex'">
    <xsl:choose>
    <xsl:when test="count(*)>0">  <!--if identifier is composed of real+imag parts-->
      <mrow>
	<mi><xsl:value-of select="text()[position()=1]"/></mi>
        <xsl:choose> <!-- im part is negative-->
        <xsl:when test="contains(text()[preceding-sibling::*[position()=1 and self::m:sep]],'-')">
          <mo>-</mo><mi>
	  <xsl:value-of select="substring-after(text()[preceding-sibling::*[position()=1 and self::m:sep]],'-')"/>
          </mi><mo><xsl:text disable-output-escaping="yes">&InvisibleTimes;</xsl:text></mo><mi><xsl:text disable-output-escaping="yes">&ImaginaryI;</xsl:text></mi><!-- perhaps ii-->
        </xsl:when>
        <xsl:otherwise> <!-- im part is not negative-->
          <mo>+</mo><mi>
          <xsl:value-of select="text()[preceding-sibling::*[position()=1 and self::m:sep]]"/>
          </mi><mo><xsl:text disable-output-escaping="yes">&InvisibleTimes;</xsl:text></mo><mi><xsl:text disable-output-escaping="yes">&ImaginaryI;</xsl:text></mi><!-- perhaps ii-->
        </xsl:otherwise>
        </xsl:choose>
      </mrow>
    </xsl:when>
    <xsl:otherwise>  <!-- if identifier is composed only of one text child-->
      <mi><xsl:value-of select="."/></mi>
    </xsl:otherwise>
    </xsl:choose>
  </xsl:when>
  <xsl:when test="./@type='complex-polar'">
    <xsl:choose>
    <xsl:when test="count(*)>0">   <!--if identifier is composed of real+imag parts-->
      <mrow>
        <mi>Polar</mi>
        <mfenced><mi>
        <xsl:value-of select="text()[following-sibling::*[self::m:sep]]"/>
        </mi>
        <mi>
        <xsl:value-of select="text()[preceding-sibling::*[self::m:sep]]"/>
        </mi></mfenced>
      </mrow>
    </xsl:when>
    <xsl:otherwise>   <!-- if identifier is composed only of one text child-->
      <mi><xsl:value-of select="."/></mi>
    </xsl:otherwise>
    </xsl:choose>
  </xsl:when> 
  <xsl:when test="./@type='rational'">
    <xsl:choose>
    <xsl:when test="count(*)>0"> <!--if identifier is composed of two parts-->
      <mrow><mi>
      <xsl:value-of select="text()[following-sibling::*[self::m:sep]]"/>
      </mi>
      <mo>/</mo>
      <mi>
      <xsl:value-of select="text()[preceding-sibling::*[self::m:sep]]"/>
      </mi></mrow>
    </xsl:when>
    <xsl:otherwise>   <!-- if identifier is composed only of one text child-->
      <mi><xsl:value-of select="."/></mi>
    </xsl:otherwise>
    </xsl:choose>
  </xsl:when>
  <xsl:when test="./@type='vector'">
	<xsl:choose>
	  <xsl:when test="count(node()) != count(text())">
	    <!--test if children are not all text nodes, meaning there is markup assumed to be presentation markup-->
	    <mstyle fontweight="bold"><mrow><xsl:copy-of select="child::*"/></mrow></mstyle>
	  </xsl:when>
	  <xsl:otherwise>  <!-- common case -->
	    <mi fontweight="bold"><xsl:value-of select="text()"/></mi>
	  </xsl:otherwise>
	</xsl:choose>   
  </xsl:when>
     

  <!-- type 'set' seems to be deprecated (use 4.4.12 instead); besides, there is no easy way to translate set identifiers to chars in ISOMOPF -->
  <xsl:otherwise>  <!-- no type attribute provided -->
    <xsl:choose>
    <xsl:when test="count(node()) != count(text())">
      <!--test if children are not all text nodes, meaning there is markup assumed to be presentation markup-->
	<mrow><xsl:copy-of select="child::*"/></mrow>
    </xsl:when>
    <xsl:otherwise>  <!-- common case -->
      <mi><xsl:value-of select="."/></mi>
    </xsl:otherwise>
    </xsl:choose>
  </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<!-- externally defined symbols-->
<xsl:template match="m:apply[child::*[position()=1 and local-name()='csymbol']]">
  <mrow>
  <xsl:apply-templates select="m:csymbol[position()=1]"/>
  <mfenced>
  <xsl:for-each select="child::*[position()!=1]">
    <xsl:apply-templates select="."/>
  </xsl:for-each>
  </mfenced>
  </mrow>
</xsl:template>

<xsl:template match="m:csymbol">
  <xsl:choose>
  <!--test if children are not all text nodes, meaning there is markup assumed to be presentation markup-->
  <!--perhaps it would be sufficient to test if there is more than one node or text node-->
  <xsl:when test="count(node()) != count(text())"> 
    <mrow><xsl:copy-of select="child::*"/></mrow>
  </xsl:when>
  <xsl:otherwise>
    <mo><xsl:value-of select="."/></mo>
  </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template match="m:mtext">
  <xsl:copy-of select="."/>
</xsl:template>

<!-- #################### 4.4.2 #################### -->

<!-- apply/apply -->
<xsl:template match="m:apply[child::*[position()=1 and local-name()='apply']]">  <!-- when the function itself is defined by other functions: (F+G)(x) -->
  <xsl:choose>
  <xsl:when test="count(child::*)>=2">
    <mrow>
      <mfenced separators=""><xsl:apply-templates select="child::*[position()=1]"/></mfenced>
      <mfenced><xsl:apply-templates select="child::*[position()!=1]"/></mfenced>
    </mrow>
  </xsl:when>
  <xsl:otherwise> <!-- apply only contains apply, no operand-->
    <mfenced separators=""><xsl:apply-templates select="child::*"/></mfenced>
  </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<!-- force function or operator MathML 1.0 deprecated-->
<xsl:template match="m:apply[child::*[position()=1 and local-name()='fn']]">
<mrow>
  <xsl:choose>
    <xsl:when test="local-name(m:fn/*[position()=1])='apply'"> <!-- fn definition is complex, surround with brackets, but only one child-->
      <mfenced separators=""><mrow><xsl:apply-templates select="m:fn/*"/></mrow></mfenced>
    </xsl:when>
    <xsl:otherwise>
      <mi><xsl:apply-templates select="m:fn/*"/></mi>
    </xsl:otherwise>
  </xsl:choose>
  <xsl:if test="count(*)>1">  <!-- if no operands, don't put empty parentheses-->
    <mo><xsl:text disable-output-escaping="yes">&ApplyFunction;</xsl:text></mo>
    <mfenced>
      <xsl:apply-templates select="*[position()!=1]"/>
    </mfenced>
  </xsl:if>
</mrow>
</xsl:template>

<!--first ci is supposed to be a function-->
<xsl:template match="m:apply[child::*[position()=1 and
	      local-name()='ci']]">
    <!-- special case if the function is to some power -->
	
	<mrow>
	  <xsl:apply-templates select="m:ci[position()=1]"/>
	  <xsl:if test="count(*)>1">  <!-- if no operands, don't put empty parentheses-->
	    <mo><xsl:text
	  disable-output-escaping="yes">&ApplyFunction;</xsl:text></mo>
<!-- changed from mfenced so that the commas appear between
	  the variables -->
	<mo>(</mo><mrow>
	    <xsl:for-each select="*[position()!=1]">
	      <xsl:apply-templates select="."/>
	      <xsl:if test="(position()!=last())">
		<mo>,</mo>
	      </xsl:if>
	    </xsl:for-each>
	  </mrow>
	  <mo>)</mo>

	   
	  </xsl:if>
	</mrow>
</xsl:template>

<xsl:template match="m:apply[child::*[position()=1 and local-name()='mo']]">
  <!--operator assumed to be infix-->
  <xsl:choose>
  <xsl:when test="count(child::*)>=3">
    <mrow>
      <xsl:for-each select="child::*[position()!=last() and  position()!=1]">
        <xsl:apply-templates select="."/><xsl:copy-of select="preceding-sibling::m:mo"/>
      </xsl:for-each>
      <xsl:apply-templates select="child::*[position()!=1 and position()=last()]"/>
    </mrow>
  </xsl:when>
  <xsl:when test="count(child::*)=2">
    <mrow><xsl:copy-of select="child::m:mo[position()=1]"/><xsl:apply-templates select="child::*[position()=2]"/></mrow>
  </xsl:when>
  </xsl:choose>
</xsl:template>


<!-- intervals -->
<xsl:template match="m:interval">
  <xsl:choose>
    <xsl:when test="count(*)=2"> <!--we have an interval defined by two real numbers-->
      <xsl:choose>
        <xsl:when test="@closure and @closure='open-closed'">
	  <mfenced open="(" close="]" separators="">
	    <xsl:apply-templates select="child::*[position()=1]"/>
	      <mo>,</mo>
	    <xsl:apply-templates select="child::*[position()=2]"/>
	  </mfenced>
	</xsl:when>
        <xsl:when test="@closure and @closure='closed-open'">
	  <mfenced open="[" close=")" separators="">
	    <xsl:apply-templates select="child::*[position()=1]"/>
	      <mo>,</mo>
	    <xsl:apply-templates select="child::*[position()=2]"/>
	  </mfenced>
	</xsl:when>
        <xsl:when test="@closure and @closure='closed'">
	  <mfenced open="[" close="]" separators="">
	    <xsl:apply-templates select="child::*[position()=1]"/>
	      <mo>,</mo>
	    <xsl:apply-templates select="child::*[position()=2]"/>
	  </mfenced>
	</xsl:when>
        <xsl:when test="@closure and @closure='open'">
	  <mfenced open="(" close=")" separators="">
	    <xsl:apply-templates select="child::*[position()=1]"/>
	      <mo>,</mo>
	    <xsl:apply-templates select="child::*[position()=2]"/>
	  </mfenced>
	</xsl:when>
	<xsl:otherwise>  <!--default is close-->
	  <mfenced open="[" close="]" separators="">
	    <xsl:apply-templates select="child::*[position()=1]"/>
	      <mo>,</mo>
	    <xsl:apply-templates select="child::*[position()=2]"/>
	  </mfenced>
	</xsl:otherwise>
      </xsl:choose>
    </xsl:when>
    <xsl:otherwise> <!--we have an interval defined by a condition-->
      <mrow><xsl:apply-templates select="m:condition"/></mrow>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<!-- inverse -->
<xsl:template match="m:apply[child::*[position()=1 and
	      local-name()='apply']/m:inverse]">
	<mrow>
      <msup><!-- elementary classical functions have two templates: apply[func] for standard case, func[position()!=1] for inverse and compose case-->
	    <mrow><xsl:apply-templates select="m:apply[position()=1]/*[position()=2]"/></mrow><!-- function to be inversed-->
	    <mn>-1</mn>
	  </msup>
	  <xsl:if test="count(*)>=2"> <!-- deal with operands, if any-->
	    <mo><xsl:text disable-output-escaping="yes">&ApplyFunction;</xsl:text></mo>
	    <mfenced>
	      <xsl:apply-templates select="*[position()!=1]"/>
	    </mfenced>
	  </xsl:if>
	</mrow>
</xsl:template> 

<!-- checks to see if there is an apply after the inverse and adds parentheses if so -->
<xsl:template match="m:apply[child::*[position()=1 and
	      local-name()='inverse']]">
    <xsl:choose>
      <xsl:when test="local-name(*[position()=2])='apply'">
	<msup>
	  <mfenced separators="">
	    <mrow>
	      <xsl:apply-templates select="*[position()=2]"/>
	    </mrow>
	  </mfenced>
	  <mn>-1</mn>
	</msup>
      </xsl:when>
      <xsl:otherwise>
	<msup> <!-- elementary classical functions have two templates: apply[func] for standard case, func[position()!=1] for inverse and compose case-->
	  <mrow><xsl:apply-templates select="*[position()=2]"/></mrow><!-- function to be inversed-->
	  <mn>-1</mn>
	</msup>
      </xsl:otherwise>
    </xsl:choose>
</xsl:template>

<!-- conditions -->
<!-- no support for deprecated reln-->
<xsl:template match="m:condition">
  <mrow><xsl:apply-templates select="*"/></mrow>
</xsl:template>

<!-- domain of application -->
<xsl:template match="m:domainofapplication">
  <mrow><xsl:apply-templates select="*"/></mrow>
</xsl:template>

<!-- declare -->
<xsl:template match="m:declare">
<!-- no rendering for declarations-->
</xsl:template>

<!-- lambda -->
<xsl:template match="m:lambda">
  <mrow>
    <mo><xsl:text disable-output-escaping="yes">&lambda;</xsl:text></mo>
    <mrow><mo>(</mo>
      <xsl:for-each select="m:bvar">
        <xsl:apply-templates select="."/><mo>,</mo>
      </xsl:for-each>
      <xsl:apply-templates select="*[position()=last()]"/>
    <mo>)</mo></mrow>
  </mrow>
</xsl:template>

<!-- composition -->
<xsl:template match="m:apply[child::*[position()=1 and local-name()='apply']/m:compose]">
  <mrow> <!-- elementary classical functions have two templates: apply[func] for standard case, func[position()!=1] for inverse and compose case-->
    <xsl:for-each select="m:apply[position()=1]/*[position()!=1 and position()!=last()]">
      <xsl:apply-templates select="."/><mo><xsl:text disable-output-escaping="yes">&SmallCircle;</xsl:text></mo> <!-- compose functions --><!-- does not work, perhaps compfn, UNICODE 02218-->
    </xsl:for-each>
    <xsl:apply-templates select="m:apply[position()=1]/*[position()=last()]"/>
    <xsl:if test="count(*)>=2"> <!-- deal with operands, if any-->
      <mo><xsl:text disable-output-escaping="yes">&ApplyFunction;</xsl:text></mo>
      <mrow><mo>(</mo>
      <xsl:for-each select="*[position()!=1 and position()!=last()]">
        <xsl:apply-templates select="."/><mo>,</mo>
      </xsl:for-each>
      <xsl:apply-templates select="*[position()=last()]"/>
      <mo>)</mo></mrow>
    </xsl:if>
  </mrow>
</xsl:template>

<xsl:template match="m:apply[child::*[position()=1 and local-name()='compose']]">
   <!-- elementary classical functions have two templates: apply[func] for standard case, func[position()!=1] for inverse and compose case-->
  <xsl:for-each select="*[position()!=1 and position()!=last()]">
    <xsl:apply-templates select="."/><mo><xsl:text disable-output-escaping="yes">&SmallCircle;</xsl:text></mo> <!-- compose functions --><!-- does not work, perhaps compfn, UNICODE 02218-->
  </xsl:for-each>
  <xsl:apply-templates select="*[position()=last()]"/>
</xsl:template>

<!-- identity -->
<xsl:template match="m:ident">
  <mi>id</mi>
</xsl:template>

<!-- domain -->
<xsl:template match="m:apply[child::*[position()=1 and local-name()='domain']]">
  <mrow>
    <mi>domain</mi><mfenced open="(" close=")"><xsl:apply-templates select="*[position()!=1]"/></mfenced>
  </mrow>
</xsl:template>

<!-- codomain -->
<xsl:template match="m:apply[child::*[position()=1 and local-name()='codomain']]">
  <mrow>
    <mi>codomain</mi><mfenced open="(" close=")"><xsl:apply-templates select="*[position()!=1]"/></mfenced>
  </mrow>
</xsl:template>

<!-- image -->
<xsl:template match="m:apply[child::*[position()=1 and local-name()='image']]">
  <mrow>
    <mi>image</mi><mfenced open="(" close=")"><xsl:apply-templates select="*[position()!=1]"/></mfenced>
  </mrow>
</xsl:template>

<!-- piecewise -->
<xsl:template match="m:piecewise">
  <mrow>
      <xsl:element name="m:mfenced" namespace="http://www.w3.org/1998/Math/MathML">
      <xsl:attribute name="open">{</xsl:attribute>
      <xsl:attribute name="close"></xsl:attribute>
      <mtable>
	<xsl:for-each select="m:piece">
	<mtr><mtd>
	  <xsl:apply-templates select="*[position()=1]"/><mspace
	  width="0.3em"/><mtext>if</mtext><mspace width="0.3em"/><xsl:apply-templates select="*[position()=2]"/>
	</mtd></mtr>
	</xsl:for-each>
        <xsl:if test="m:otherwise">
	  <mtr><mtd><xsl:apply-templates
	  select="m:otherwise/*"/><mspace width="0.3em"/>otherwise</mtd></mtr>
        </xsl:if>
	</mtable>
      </xsl:element>
  </mrow>
</xsl:template>

<!-- #################### 4.4.3 #################### -->

<!-- quotient -->
<xsl:template match="m:apply[child::*[position()=1 and local-name()='quotient']]">
  <mrow>  <!-- the third notation uses UNICODE chars x0230A and x0230B -->
    <mo>integer part of</mo>
    <mrow>
      <xsl:choose> <!-- surround with brackets if operands are composed-->
      <xsl:when test="child::*[position()=2] and local-name()='apply'">
        <mfenced separators=""><xsl:apply-templates select="*[position()=2]"/></mfenced>
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-templates select="*[position()=2]"/>
      </xsl:otherwise>
      </xsl:choose>
      <mo>/</mo>
      <xsl:choose>
      <xsl:when test="child::*[position()=3] and local-name()='apply'">
        <mfenced separators=""><xsl:apply-templates select="*[position()=3]"/></mfenced>
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-templates select="*[position()=3]"/>
      </xsl:otherwise>
      </xsl:choose>
    </mrow>
  </mrow>
</xsl:template>

<!-- factorial -->
<xsl:template match="m:apply[child::*[position()=1 and local-name()='factorial']]">
  <mrow>
    <xsl:choose> <!-- surround with brackets if operand is composed-->
    <xsl:when test="local-name(*[position()=2])='apply'">
      <mfenced separators=""><xsl:apply-templates select="*[position()=2]"/></mfenced>
    </xsl:when>
    <xsl:otherwise>
      <xsl:apply-templates select="*[position()=2]"/>
    </xsl:otherwise>
    </xsl:choose>
    <mo>!</mo>
  </mrow>
</xsl:template>

<!-- divide -->
<xsl:template match="m:apply[child::*[position()=1 and local-name()='divide']]">
  <mrow>
    <xsl:choose>
    <xsl:when test="contains(@other,'scriptstyle')">
      <mfrac bevelled="true">
        <xsl:apply-templates select="child::*[position()=2]"/>
        <xsl:apply-templates select="child::*[position()=3]"/>
      </mfrac>
    </xsl:when>
    <xsl:otherwise>
      <mfrac>
        <xsl:apply-templates select="child::*[position()=2]"/>
        <xsl:apply-templates select="child::*[position()=3]"/>
      </mfrac>
    </xsl:otherwise>
    </xsl:choose>
  </mrow>
</xsl:template>

<!-- min -->
<xsl:template match="m:apply[child::*[position()=1 and local-name()='min']]">
  <mrow>
    <xsl:choose>
    <xsl:when test="m:bvar"> <!-- if there are bvars-->
      <msub>
        <mi>min</mi>
        <mrow>
          <xsl:for-each select="m:bvar[position()!=last()]">  <!--select every bvar except the last one (position() only counts bvars, not the other siblings)-->
              <xsl:apply-templates select="."/><mo>,</mo>
          </xsl:for-each>
  	<xsl:apply-templates select="m:bvar[position()=last()]"/>
        </mrow>
      </msub>
      <mrow><mo>{</mo>
        <xsl:apply-templates select="*[local-name()!='condition' and local-name()!='bvar']"/>
        <xsl:if test="m:condition">
          <mo>|</mo><xsl:apply-templates select="m:condition"/>
        </xsl:if>
      <mo>}</mo></mrow>
    </xsl:when>
    <xsl:otherwise> <!-- if there are no bvars-->
      <mo>min</mo>
      <mrow><mo>{</mo>
      <mfenced open="" close=""><xsl:apply-templates select="*[local-name()!='condition']"/></mfenced>
      <xsl:if test="m:condition">
        <mo>|</mo><xsl:apply-templates select="m:condition"/>
      </xsl:if>
      <mo>}</mo></mrow>
    </xsl:otherwise>
    </xsl:choose>
  </mrow>
</xsl:template>

<!-- max -->
<xsl:template match="m:apply[child::*[position()=1 and local-name()='max']]">
  <mrow>
    <xsl:choose>
    <xsl:when test="m:bvar"> <!-- if there are bvars-->
      <msub>
        <mi>max</mi>
        <mrow>
          <xsl:for-each select="m:bvar[position()!=last()]">  <!--select every bvar except the last one (position() only counts bvars, not the other siblings)-->
            <xsl:apply-templates select="."/><mo>,</mo>
          </xsl:for-each>  
  	  <xsl:apply-templates select="m:bvar[position()=last()]"/>
        </mrow>
      </msub>
      <mrow><mo>{</mo>
      <xsl:apply-templates select="*[local-name()!='condition' and local-name()!='bvar']"/>
      <xsl:if test="m:condition">
        <mo>|</mo><xsl:apply-templates select="m:condition"/>
      </xsl:if>
      <mo>}</mo></mrow>
    </xsl:when>
    <xsl:otherwise> <!-- if there are no bvars-->
      <mo>max</mo>
      <mrow><mo>{</mo>
        <mfenced open="" close=""><xsl:apply-templates select="*[local-name()!='condition']"/></mfenced>
        <xsl:if test="m:condition">
          <mo>|</mo><xsl:apply-templates select="m:condition"/>
        </xsl:if>
      <mo>}</mo></mrow>
    </xsl:otherwise>
    </xsl:choose>
  </mrow>
</xsl:template>

<!-- substraction(minus); unary or binary operator-->
  <xsl:template match="m:apply[child::*[position()=1 and local-name()='minus']]">
    <mrow>
      <xsl:choose> <!-- binary -->
	<xsl:when test="count(child::*)=3">
	  <xsl:apply-templates select="child::*[position()=2]"/>
	  <mo>-</mo>
	  <xsl:choose>
	    <xsl:when test="((local-name(*[position()=3])='ci' or local-name(*[position()=3])='cn') and contains(*[position()=3]/text(),'-')) or ((local-name(*[position()=3])='apply') and (local-name(*[position()=3]/*[position()=1])='minus' or local-name(*[position()=3]/*[position()=1])='plus'))">
	      <mfenced separators="">
	      <xsl:apply-templates select="*[position()=3]"/>
	      </mfenced>
	      
	      <!-- surround negative or complex things with brackets -->
	    </xsl:when>
	    <xsl:otherwise>
	      <xsl:apply-templates select="*[position()=3]"/>
	    </xsl:otherwise>
	  </xsl:choose>
	</xsl:when>
	<xsl:otherwise> <!-- unary -->
	  <mo>-</mo>
	  <xsl:choose>
	    <xsl:when test="((local-name(*[position()=2])='ci' or local-name(*[position()=2])='cn') and contains(*[position()=2]/text(),'-')) or (local-name(*[position()=2])='apply')">
	      <mfenced separators="">
<!-- surround negative or complex things with brackets -->
      <xsl:apply-templates select="child::*[position()=last()]"/>
	      </mfenced>
	    </xsl:when>
	    <xsl:otherwise>
	      <xsl:apply-templates select="child::*[position()=last()]"/>
	    </xsl:otherwise>
	  </xsl:choose>
	</xsl:otherwise>
      </xsl:choose>
    </mrow>
  </xsl:template>

<!-- addition -->
<xsl:template match="m:apply[child::*[position()=1 and local-name()='plus']]">
  <xsl:choose>
  <xsl:when test="count(child::*)>=3">
    <mrow>
      <xsl:choose>
        <xsl:when test="((local-name(*[position()=2])='ci' or local-name(*[position()=2])='cn') and contains(*[position()=2]/text(),'-'))">
          <mfenced separators=""><xsl:apply-templates select="*[position()=2]"/></mfenced> <!-- surround negative things with brackets -->
        </xsl:when>
        <xsl:otherwise>
          <xsl:apply-templates select="*[position()=2]"/>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:for-each select="child::*[position()!=1 and position()!=2]">
        <xsl:choose>
        <xsl:when test="((local-name(.)='ci' or local-name(.)='cn') and contains(./text(),'-')) or (self::m:apply and child::m:minus and child::*[last()=2]) or (self::m:apply and child::m:times[1] and child::*[position()=2 and (local-name(.)='ci' or local-name(.)='cn') and contains(./text(),'-')])"> <!-- surround negative things with brackets -->
          <mo>+</mo><mfenced separators=""><xsl:apply-templates select="."/></mfenced>
        </xsl:when>
        <xsl:otherwise>
          <mo>+</mo><xsl:apply-templates select="."/>
        </xsl:otherwise>
        </xsl:choose>
      </xsl:for-each>
    </mrow>
  </xsl:when>
  <xsl:when test="count(child::*)=2">
    <mrow>
      <mo>+</mo><xsl:apply-templates select="child::*[position()=2]"/>
    </mrow>
  </xsl:when>
  <xsl:otherwise>
    <mo>+</mo>
  </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<!-- power -->
<xsl:template match="m:apply[child::*[position()=1 and local-name()='power']]">
    <msup>
      <xsl:choose>
	<xsl:when test="local-name(*[position()=2])='apply'">
	  <mfenced separators="">
	    <xsl:apply-templates select="child::*[position()=2]" /> 
	  </mfenced>
	</xsl:when>
	<xsl:otherwise>
	  <xsl:apply-templates select="child::*[position()=2]" /> 
	</xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="child::*[position()=3]" /> 
    </msup>
  </xsl:template>

<!-- remainder -->
<xsl:template match="m:apply[child::*[position()=1 and local-name()='rem']]">
  <mrow>
    <xsl:choose> <!-- surround with brackets if operands are composed-->
    <xsl:when test="local-name(*[position()=2])='apply'">
      <mfenced separators=""><xsl:apply-templates select="*[position()=2]"/></mfenced>
    </xsl:when>
    <xsl:otherwise>
      <xsl:apply-templates select="*[position()=2]"/>
    </xsl:otherwise>
    </xsl:choose>
    <mo>mod</mo>
    <xsl:choose>
    <xsl:when test="local-name(*[position()=3])='apply'">
      <mfenced separators=""><xsl:apply-templates select="*[position()=3]"/></mfenced>
    </xsl:when>
    <xsl:otherwise>
      <xsl:apply-templates select="*[position()=3]"/>
    </xsl:otherwise>
    </xsl:choose>
  </mrow>
</xsl:template>

<!-- multiplication -->
<xsl:template match="m:apply[child::*[position()=1 and local-name()='times']]">
<xsl:choose>
<xsl:when test="count(child::*)>=3">
  <mrow>
    <xsl:for-each select="child::*[position()!=last() and  position()!=1]">
      <xsl:choose>
      <xsl:when test="m:plus"> <!--add brackets around + children for priority purpose-->
        <mfenced separators=""><xsl:apply-templates select="."/></mfenced><mo><xsl:text disable-output-escaping="yes">&InvisibleTimes;</xsl:text></mo>
      </xsl:when>
      <xsl:when test="m:minus"> <!--add brackets around - children for priority purpose-->
        <mfenced separators=""><xsl:apply-templates select="."/></mfenced><mo><xsl:text disable-output-escaping="yes">&InvisibleTimes;</xsl:text></mo>
      </xsl:when>
	      <!-- if someone goes through the trouble of nesting
	      times then add brackets -->
	      <xsl:when test="m:times"> <!--add brackets around - children for priority purpose-->
		<mfenced separators=""><xsl:apply-templates select="."/></mfenced><mo><xsl:text disable-output-escaping="yes">&InvisibleTimes;</xsl:text></mo>
	      </xsl:when>
      <!-- putting a times symbol between two cn's added by allison -->
      <xsl:when test="(local-name()='cn') and
		following-sibling::*[position()=1 and local-name()='cn']">
		<xsl:choose>
		  <!--case when the entity pi is a cn-->
		  <!--and when the pi tag is used-->
		  <xsl:when test="(local-name()='cn') and
		    contains(text(),'&pi;')">
		    <xsl:apply-templates
		    select="."/><mo>&InvisibleTimes;</mo>
		  </xsl:when>
		  <xsl:when
		  test="following-sibling::*[contains(text(),'&pi;')
		    or local-name()='pi']">
		    <xsl:apply-templates
		    select="."/><mo>&InvisibleTimes;</mo>
		  </xsl:when>
		  <!--default case with two cn's there is a times sign-->
		  <xsl:otherwise>
		    <xsl:apply-templates select="."/><mo>&times;</mo>
		  </xsl:otherwise>
		</xsl:choose>
      </xsl:when>
	      <!-- case for powers (scientific notation by using times) -->
      <xsl:when test="(local-name()='cn') and
      following-sibling::*[position()=1 and local-name()='apply' and
      child::*[position()=2 and local-name()='cn'] and
      child::*[position()=1 and local-name()='power']]">
		<xsl:apply-templates select="."/><mo>&times;</mo>
	      </xsl:when>
	      <!-- end of allison's addition -->
      <xsl:otherwise>
        <xsl:apply-templates select="."/><mo><xsl:text disable-output-escaping="yes">&InvisibleTimes;</xsl:text></mo>
      </xsl:otherwise>
      </xsl:choose>
    </xsl:for-each>
    <xsl:for-each select="child::*[position()=last()]">
      <xsl:choose>
      <xsl:when test="m:plus">
        <mfenced separators=""><xsl:apply-templates select="."/></mfenced>
      </xsl:when>
      <xsl:when test="m:minus">
        <mfenced separators=""><xsl:apply-templates select="."/></mfenced>
      </xsl:when>
	      <!-- if someone goes through the trouble of nesting
      times, then add parentheses -->
	      <xsl:when test="m:times">
        <mfenced separators=""><xsl:apply-templates select="."/></mfenced>
      </xsl:when> 
      
      <xsl:when test="(local-name(.)='ci' or local-name(.)='cn') and contains(text(),'-')"> <!-- have to do it using contains because starts-with doesn't seem to work well in  XT-->
        <mfenced separators=""><xsl:apply-templates select="."/></mfenced>
      </xsl:when>
     
      <xsl:otherwise>
        <xsl:apply-templates select="."/>
      </xsl:otherwise>
      </xsl:choose>
    </xsl:for-each>
  </mrow>
</xsl:when>
<xsl:when test="count(child::*)=2">  <!-- unary -->
  <mrow>
    <mo><xsl:text disable-output-escaping="yes">&InvisibleTimes;</xsl:text></mo>
    <xsl:choose>
      <xsl:when test="m:plus">
        <mfenced separators=""><xsl:apply-templates select="*[position()=2]"/></mfenced>
      </xsl:when>
      <xsl:when test="m:minus">
        <mfenced separators=""><xsl:apply-templates select="*[position()=2]"/></mfenced>
      </xsl:when>
      <xsl:when test="(*[position()=2 and self::m:ci] or *[position()=2 and self::m:cn]) and contains(*[position()=2]/text(),'-')">
        <mfenced separators=""><xsl:apply-templates select="*[position()=2]"/></mfenced>
      </xsl:when>
      
      <xsl:otherwise>
        <xsl:apply-templates select="*[position()=2]"/>
      </xsl:otherwise>
    </xsl:choose>
  </mrow>
</xsl:when>
<xsl:otherwise>  <!-- no operand -->
  <mo><xsl:text disable-output-escaping="yes">&InvisibleTimes;</xsl:text></mo>
</xsl:otherwise>
</xsl:choose>
</xsl:template>

<!-- root -->
<xsl:template match="m:apply[child::*[position()=1 and local-name()='root']]">
  <xsl:choose>
  <xsl:when test="m:degree">
    <xsl:choose>
    <xsl:when test="m:degree/m:cn/text()='2'"> <!--if degree=2 display a standard square root-->
      <msqrt>
        <xsl:apply-templates select="child::*[position()=3]"/>
      </msqrt>
    </xsl:when>
    <xsl:otherwise>
      <mroot>
        <xsl:apply-templates select="child::*[position()=3]"/>
        <mrow><xsl:apply-templates select="m:degree/*"/></mrow>
      </mroot>
    </xsl:otherwise>
    </xsl:choose>
  </xsl:when>
  <xsl:otherwise> <!-- no degree specified-->
    <msqrt>
      <xsl:apply-templates select="child::*[position()=2]"/>
    </msqrt>
  </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<!-- greatest common divisor -->
<xsl:template match="m:apply[child::*[position()=1 and local-name()='gcd']]">
  <mrow>
    <mi>gcd</mi><mo><xsl:text disable-output-escaping="yes">&ApplyFunction;</xsl:text></mo>
    <mfenced>
      <xsl:apply-templates select="child::*[position()!=1]"/>
    </mfenced>
  </mrow>
</xsl:template>

<!-- AND -->
<xsl:template match="m:apply[child::*[position()=1 and local-name()='and']]">
<mrow>
  <xsl:choose>
  <xsl:when test="count(*)>=3"> <!-- at least two operands (common case)-->
    <xsl:for-each select="child::*[position()!=last() and  position()!=1]">
      <xsl:choose>
      <xsl:when test="m:or"> <!--add brackets around OR children for priority purpose-->
        <mfenced separators=""><xsl:apply-templates select="."/></mfenced><mo><xsl:text disable-output-escaping="yes">&and;</xsl:text></mo>
      </xsl:when>
      <xsl:when test="m:xor"> <!--add brackets around XOR children for priority purpose-->
       <mfenced separators=""><xsl:apply-templates select="."/></mfenced><mo><xsl:text disable-output-escaping="yes">&and;</xsl:text></mo> 
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-templates select="."/><mo><xsl:text disable-output-escaping="yes">&and;</xsl:text></mo>
      </xsl:otherwise>
      </xsl:choose>
    </xsl:for-each>
    <xsl:for-each select="child::*[position()=last()]">
      <xsl:choose>
      <xsl:when test="m:or">
        <mfenced separators=""><xsl:apply-templates select="."/></mfenced>
      </xsl:when>
      <xsl:when test="m:xor">
        <mfenced separators=""><xsl:apply-templates select="."/></mfenced>
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-templates select="."/>
      </xsl:otherwise>
      </xsl:choose>
    </xsl:for-each>
  </xsl:when>
  <xsl:when test="count(*)=2">
    <mo><xsl:text disable-output-escaping="yes">&and;</xsl:text></mo><xsl:apply-templates select="*[position()=last()]"/>
  </xsl:when>
  <xsl:otherwise>
    <mo><xsl:text disable-output-escaping="yes">&and;</xsl:text></mo>
  </xsl:otherwise>
  </xsl:choose>
</mrow>
</xsl:template>

<!-- OR -->
<xsl:template match="m:apply[child::*[position()=1 and local-name()='or']]">
<mrow>
  <xsl:choose>
  <xsl:when test="count(*)>=3">
    <xsl:for-each select="child::*[position()!=last() and  position()!=1]">
      <xsl:apply-templates select="."/><mo><xsl:text disable-output-escaping="yes">&or;</xsl:text></mo>
    </xsl:for-each>
    <xsl:apply-templates select="child::*[position()=last()]"/>
    </xsl:when>
    <xsl:when test="count(*)=2">
      <mo><xsl:text disable-output-escaping="yes">&or;</xsl:text></mo><xsl:apply-templates select="*[position()=last()]"/>
  </xsl:when>
  <xsl:otherwise>
    <mo><xsl:text disable-output-escaping="yes">&or;</xsl:text></mo>
  </xsl:otherwise>
  </xsl:choose>
</mrow>
</xsl:template>

<!-- XOR -->
<xsl:template match="m:apply[child::*[position()=1 and local-name()='xor']]">
<mrow>
  <xsl:choose>
  <xsl:when test="count(*)>=3">
    <xsl:for-each select="child::*[position()!=last() and  position()!=1]">
      <xsl:apply-templates select="."/><mo>&xoplus;</mo>
    </xsl:for-each>
    <xsl:apply-templates select="child::*[position()=last()]"/>
    </xsl:when>
    <xsl:when test="count(*)=2">
      <mo>&xoplus;</mo><xsl:apply-templates select="*[position()=last()]"/>
  </xsl:when>
  <xsl:otherwise>
    <mo>&xoplus;</mo>
  </xsl:otherwise>
  </xsl:choose>
</mrow>
</xsl:template>

<!-- NOT -->
<xsl:template match="m:apply[child::*[position()=1 and local-name()='not']]">
  <mrow>
    <mo><xsl:text disable-output-escaping="yes">&not;</xsl:text></mo>
    <xsl:choose>
    <xsl:when test="child::m:apply"><!--add brackets around OR,AND,XOR children for priority purpose-->
      <mfenced separators="">
        <xsl:apply-templates select="child::*[position()=2]"/>
      </mfenced>
    </xsl:when>
    <xsl:otherwise>
      <xsl:apply-templates select="child::*[position()=2]"/>
    </xsl:otherwise>
    </xsl:choose>
  </mrow>
</xsl:template>

<!-- implies -->
<xsl:template match="m:apply[child::*[position()=1 and local-name()='implies']]">
  <mrow>
    <xsl:apply-templates select="child::*[position()=2]"/>
    <mo><xsl:text disable-output-escaping="yes">&DoubleRightArrow;</xsl:text></mo>
    <xsl:apply-templates select="child::*[position()=3]"/>
  </mrow>
</xsl:template>

<xsl:template match="m:reln[child::*[position()=1 and local-name()='implies']]">
  <mrow>
    <xsl:apply-templates select="child::*[position()=2]"/>
    <mo><xsl:text disable-output-escaping="yes">&DoubleRightArrow;</xsl:text></mo>
    <xsl:apply-templates select="child::*[position()=3]"/>
  </mrow>
</xsl:template>

<!-- for all-->
<xsl:template match="m:apply[child::*[position()=1 and local-name()='forall']]">
  <mrow>
    <mo><xsl:text disable-output-escaping="yes">&ForAll;</xsl:text></mo>
    <mrow>
      <xsl:for-each select="m:bvar[position()!=last()]">
        <xsl:apply-templates select="."/><mo>,</mo>
      </xsl:for-each>
      <xsl:apply-templates select="m:bvar[position()=last()]"/>
    </mrow>
    <xsl:if test="m:condition">
      <mrow><mo>,</mo><xsl:apply-templates select="m:condition"/></mrow>
    </xsl:if>
    <xsl:choose>
      <xsl:when test="m:apply">
        <mo>:</mo><xsl:apply-templates select="m:apply"/>
      </xsl:when>
      <xsl:when test="m:reln">
        <mo>:</mo><xsl:apply-templates select="m:reln"/>
      </xsl:when>
    </xsl:choose>
  </mrow>
</xsl:template>

<!-- exist-->
<xsl:template match="m:apply[child::*[position()=1 and local-name()='exists']]">
  <mrow>
    <mo><xsl:text disable-output-escaping="yes">&Exists;</xsl:text></mo>
    <mrow>
      <xsl:for-each select="m:bvar[position()!=last()]">
        <xsl:apply-templates select="."/><mo>,</mo>
      </xsl:for-each>
      <xsl:apply-templates select="m:bvar[position()=last()]"/>
    </mrow>
    <xsl:if test="m:condition">
      <mrow><mo>,</mo><xsl:apply-templates select="m:condition"/></mrow>
    </xsl:if>
    <xsl:choose>
      <xsl:when test="m:apply">
        <mo>:</mo><xsl:apply-templates select="m:apply"/>
      </xsl:when>
      <xsl:when test="m:reln">
        <mo>:</mo><xsl:apply-templates select="m:reln"/>
      </xsl:when>
    </xsl:choose>
  </mrow>
</xsl:template>

<!-- absolute value -->
<xsl:template match="m:apply[child::*[position()=1 and local-name()='abs']]">
  <mrow><mo>|</mo><xsl:apply-templates select="child::*[position()=last()]"/><mo>|</mo></mrow>
</xsl:template>

<!-- conjugate -->
<xsl:template match="m:apply[child::*[position()=1 and local-name()='conjugate']]">
  <mover>
    <xsl:apply-templates select="child::*[position()=2]"/>
    <mo><xsl:text disable-output-escaping="yes">&OverBar;</xsl:text></mo>  <!-- does not work, UNICODE x0233D  or perhaps OverBar-->
  </mover>
</xsl:template>

<!-- argument of complex number -->
<xsl:template match="m:apply[child::*[position()=1 and local-name()='arg']]">
  <mrow>
    <mi>&ang;</mi><mo><xsl:text disable-output-escaping="yes">&ApplyFunction;</xsl:text></mo><mfenced separators=""><xsl:apply-templates select="child::*[position()=2]"/></mfenced>
  </mrow>
</xsl:template>

<!-- real part of complex number -->
<xsl:template match="m:apply[child::*[position()=1 and local-name()='real']]">
  <mrow>
    <mi><xsl:text disable-output-escaping="yes">&amp;#x0211C;</xsl:text><!-- &Re; or &realpart; should work--></mi>
    <mo><xsl:text disable-output-escaping="yes">&ApplyFunction;</xsl:text></mo>
    <mfenced separators=""><xsl:apply-templates select="child::*[position()=2]"/></mfenced>
  </mrow>
</xsl:template>

<!-- imaginary part of complex number -->
<xsl:template match="m:apply[child::*[position()=1 and local-name()='imaginary']]">
  <mrow>
    <mi><xsl:text disable-output-escaping="yes">&amp;#x02111;</xsl:text><!-- &Im; or &impartl should work--></mi>
    <mo><xsl:text disable-output-escaping="yes">&ApplyFunction;</xsl:text></mo>
    <mfenced separators=""><xsl:apply-templates select="child::*[position()=2]"/></mfenced>
  </mrow>
</xsl:template>

<!-- lowest common multiple -->
<xsl:template match="m:apply[child::*[position()=1 and local-name()='lcm']]">
  <mrow>
    <mi>lcm</mi><mo><xsl:text disable-output-escaping="yes">&ApplyFunction;</xsl:text></mo>
    <mfenced>
      <xsl:apply-templates select="child::*[position()!=1]"/>
    </mfenced>
  </mrow>
</xsl:template>

<!-- floor -->
<xsl:template match="m:apply[child::*[position()=1 and local-name()='floor']]">
  <mrow><mo><xsl:text disable-output-escaping="yes">&LeftFloor;</xsl:text></mo><xsl:apply-templates select="child::*[position()=last()]"/><mo><xsl:text disable-output-escaping="yes">&RightFloor;</xsl:text></mo></mrow>
</xsl:template>

<!-- ceiling -->
<xsl:template match="m:apply[child::*[position()=1 and local-name()='ceiling']]">
  <mrow><mo><xsl:text disable-output-escaping="yes">&LeftCeiling;</xsl:text></mo><xsl:apply-templates select="child::*[position()=last()]"/><mo><xsl:text disable-output-escaping="yes">&RightCeiling;</xsl:text></mo></mrow>
</xsl:template>

<!-- #################### 4.4.4 #################### -->

<!-- equal to -->
<xsl:template name="eqRel">
  <xsl:choose>
  <xsl:when test="count(child::*)>=3">
    <mrow>
      <xsl:for-each select="child::*[position()!=1 and position()!=last()]">
	<xsl:apply-templates select="."/><mo>=</mo>
      </xsl:for-each>
      <xsl:apply-templates select="child::*[position()=last()]"/>
    </mrow>
  </xsl:when>
  <xsl:when test="count(child::*)=2">
    <mrow>
      <mo>=</mo><xsl:apply-templates select="child::*[position()=2]"/>
    </mrow>
  </xsl:when>
  <xsl:otherwise>
    <mo>=</mo>
  </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template match="m:apply[child::*[position()=1 and local-name()='eq']]">
  <xsl:call-template name="eqRel"/>
</xsl:template>

<xsl:template match="m:reln[child::*[position()=1 and local-name()='eq']]">
  <xsl:call-template name="eqRel"/>
</xsl:template>

<!-- not equal to -->
<xsl:template match="m:apply[child::*[position()=1 and local-name()='neq']]">
  <mrow>
    <xsl:apply-templates select="child::*[position()=2]"/>
    <mo><xsl:text disable-output-escaping="yes">&NotEqual;</xsl:text></mo>
    <xsl:apply-templates select="child::*[position()=3]"/>
  </mrow>
</xsl:template>

<xsl:template match="m:reln[child::*[position()=1 and local-name()='neq']]">
  <mrow>
    <xsl:apply-templates select="child::*[position()=2]"/>
    <mo><xsl:text disable-output-escaping="yes">&NotEqual;</xsl:text></mo>
    <xsl:apply-templates select="child::*[position()=3]"/>
  </mrow>
</xsl:template>

<!-- greater than -->
<xsl:template name="gtRel">
  <xsl:choose>
  <xsl:when test="count(child::*)>=3">
    <mrow>
      <xsl:for-each select="child::*[position()!=1 and position()!=last()]">
	<xsl:apply-templates select="."/><mo><xsl:text disable-output-escaping="yes">&gt;</xsl:text></mo>
      </xsl:for-each>
      <xsl:apply-templates select="child::*[position()=last()]"/>
    </mrow>
  </xsl:when>
  <xsl:when test="count(child::*)=2">
    <mrow>
      <mo><xsl:text disable-output-escaping="yes">&gt;</xsl:text></mo><xsl:apply-templates select="child::*[position()=2]"/>
    </mrow>
  </xsl:when>
  <xsl:otherwise>
    <mo><xsl:text disable-output-escaping="yes">&gt;</xsl:text></mo>
  </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template match="m:apply[child::*[position()=1 and local-name()='gt']]">
  <xsl:call-template name="gtRel"/>
</xsl:template>

<xsl:template match="m:reln[child::*[position()=1 and local-name()='gt']]">
  <xsl:call-template name="gtRel"/>
</xsl:template>

<!-- less than -->
<xsl:template name="ltRel">
  <xsl:choose>
  <xsl:when test="count(child::*)>=3">
    <mrow>
      <xsl:for-each select="child::*[position()!=1 and position()!=last()]">
	<xsl:apply-templates select="."/><mo><xsl:text disable-output-escaping="yes"><![CDATA[&lt;]]></xsl:text></mo>
      </xsl:for-each>
      <xsl:apply-templates select="child::*[position()=last()]"/>
    </mrow>
  </xsl:when>
  <xsl:when test="count(child::*)=2">
    <mrow>
      <mo><xsl:text disable-output-escaping="yes"><![CDATA[&lt;]]></xsl:text></mo><xsl:apply-templates select="child::*[position()=2]"/>
    </mrow>
  </xsl:when>
  <xsl:otherwise>
    <mo><xsl:text disable-output-escaping="yes"><![CDATA[&lt;]]></xsl:text></mo>
  </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template match="m:apply[child::*[position()=1 and local-name()='lt']]">
  <xsl:call-template name="ltRel"/>
</xsl:template>

<xsl:template match="m:reln[child::*[position()=1 and local-name()='lt']]">
  <xsl:call-template name="ltRel"/>
</xsl:template>

<!-- greater than or equal to -->
<xsl:template name="geqRel">
  <xsl:choose>
  <xsl:when test="count(child::*)>=3">
    <mrow>
      <xsl:for-each select="child::*[position()!=1 and position()!=last()]">
	<xsl:apply-templates select="."/><mo><xsl:text disable-output-escaping="yes">&GreaterEqual;</xsl:text></mo>
      </xsl:for-each>
      <xsl:apply-templates select="child::*[position()=last()]"/>
    </mrow>
  </xsl:when>
  <xsl:when test="count(child::*)=2">
    <mrow>
      <mo><xsl:text disable-output-escaping="yes">&GreaterEqual;</xsl:text></mo><xsl:apply-templates select="child::*[position()=2]"/>
    </mrow>
  </xsl:when>
  <xsl:otherwise>
    <mo><xsl:text disable-output-escaping="yes">&GreaterEqual;</xsl:text></mo>
  </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template match="m:apply[child::*[position()=1 and local-name()='geq']]">
  <xsl:call-template name="geqRel"/>
</xsl:template>

<xsl:template match="m:reln[child::*[position()=1 and local-name()='geq']]">
  <xsl:call-template name="geqRel"/>
</xsl:template>

<!-- less than or equal to -->
<xsl:template name="leqRel">
  <xsl:choose>
  <xsl:when test="count(child::*)>=3">
    <mrow>
      <xsl:for-each select="child::*[position()!=1 and position()!=last()]">
	<xsl:apply-templates select="."/><mo><xsl:text disable-output-escaping="yes">&leq;</xsl:text></mo>
      </xsl:for-each>
      <xsl:apply-templates select="child::*[position()=last()]"/>
    </mrow>
  </xsl:when>
  <xsl:when test="count(child::*)=2">
    <mrow>
      <mo><xsl:text disable-output-escaping="yes">&leq;</xsl:text></mo><xsl:apply-templates select="child::*[position()=2]"/>
    </mrow>
  </xsl:when>
  <xsl:otherwise>
    <mo><xsl:text disable-output-escaping="yes">&leq;</xsl:text></mo>
  </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template match="m:apply[child::*[position()=1 and local-name()='leq']]">
  <xsl:call-template name="leqRel"/>
</xsl:template>

<xsl:template match="m:reln[child::*[position()=1 and local-name()='leq']]">
  <xsl:call-template name="leqRel"/>
</xsl:template>

<!-- equivalent -->
<xsl:template name="equivRel">
  <xsl:choose>
  <xsl:when test="count(child::*)>=3">
    <mrow>
      <xsl:for-each select="child::*[position()!=1 and position()!=last()]">
	<xsl:apply-templates select="."/><mo><xsl:text disable-output-escaping="yes">&equiv;</xsl:text></mo>
      </xsl:for-each>
      <xsl:apply-templates select="child::*[position()=last()]"/>
    </mrow>
  </xsl:when>
  <xsl:when test="count(child::*)=2">
    <mrow>
      <mo><xsl:text disable-output-escaping="yes">&equiv;</xsl:text></mo><xsl:apply-templates select="child::*[position()=2]"/>
    </mrow>
  </xsl:when>
  <xsl:otherwise>
    <mo><xsl:text disable-output-escaping="yes">&equiv;</xsl:text></mo>
  </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template match="m:apply[child::*[position()=1 and local-name()='equivalent']]">
  <xsl:call-template name="equivRel"/>
</xsl:template>

<xsl:template match="m:reln[child::*[position()=1 and local-name()='equivalent']]">
  <xsl:call-template name="equivRel"/>
</xsl:template>

<!-- approximately equal -->
<xsl:template match="m:apply[child::*[position()=1 and local-name()='approx']]">
  <mrow>
    <xsl:apply-templates select="child::*[position()=2]"/>
    <mo><xsl:text disable-output-escaping='yes'>&amp;#x02248;</xsl:text><!-- &TildeTilde; or &approx; should work--></mo>
    <xsl:apply-templates select="child::*[position()=3]"/>
  </mrow>
</xsl:template>

<xsl:template match="m:reln[child::*[position()=1 and local-name()='approx']]">
  <mrow>
    <xsl:apply-templates select="child::*[position()=2]"/>
    <mo><xsl:text disable-output-escaping='yes'>&amp;#x02248;</xsl:text><!-- &TildeTilde; or &approx; should work--></mo>
    <xsl:apply-templates select="child::*[position()=3]"/>
  </mrow>
</xsl:template>

<!-- factor of -->
<xsl:template match="m:apply[child::*[position()=1 and local-name()='factorof']]">
  <mrow>
    <xsl:apply-templates select="child::*[position()=2]"/>
    <mo>|</mo>
    <xsl:apply-templates select="child::*[position()=3]"/>
  </mrow>
</xsl:template>

<!-- #################### 4.4.5 #################### -->

<!-- integral -->
<xsl:template match="m:apply[child::*[position()=1 and local-name()='int']]">
  <mrow>
    <xsl:choose>
    <xsl:when test="m:condition"> <!-- integration domain expressed by a condition-->
      <munder>
        <mo><xsl:text disable-output-escaping="yes">&Integral;</xsl:text></mo>
        <xsl:apply-templates select="m:condition"/>
      </munder>
      <mrow><xsl:apply-templates select="*[position()=last()]"/></mrow>
      <mrow><mo>d<!--DifferentialD does not work--></mo><xsl:apply-templates select="m:bvar"/></mrow>
    </xsl:when>
    <xsl:when test="m:domainofapplication"> <!-- integration domain expressed by a domain of application-->
      <munder>
        <mo><xsl:text disable-output-escaping="yes">&Integral;</xsl:text></mo>
        <xsl:apply-templates select="m:domainofapplication"/>
      </munder>
      <mrow><xsl:apply-templates select="*[position()=last()]"/></mrow>
      <mrow><mo>d<!--DifferentialD does not work--></mo><xsl:apply-templates select="m:bvar"/></mrow>  <!--not sure about this line: can get rid of it if there is never a bvar elem when integ domain specified by domainofapplication-->
    </xsl:when>
    <xsl:otherwise>
      <xsl:choose>
      <xsl:when test="m:interval"> <!-- integration domain expressed by an interval-->
        <msubsup>
          <mo><xsl:text disable-output-escaping="yes">&Integral;</xsl:text></mo>
          <xsl:apply-templates select="m:interval/*[position()=1]"/>
          <xsl:apply-templates select="m:interval/*[position()=2]"/>
        </msubsup>
        <xsl:apply-templates select="*[position()=last()]"/>
        <mo>d<!--DifferentialD does not work--></mo><xsl:apply-templates select="m:bvar"/>
      </xsl:when>
      <xsl:when test="m:lowlimit"> <!-- integration domain expressed by lower and upper limits-->
        <msubsup>
          <mo><xsl:text disable-output-escaping="yes">&Integral;</xsl:text></mo>
          <mrow><xsl:apply-templates select="m:lowlimit"/></mrow>
          <mrow><xsl:apply-templates select="m:uplimit"/></mrow>
        </msubsup>
        <xsl:apply-templates select="*[position()=last()]"/>
        <mo>d<!--DifferentialD does not work--></mo><xsl:apply-templates select="m:bvar"/>
      </xsl:when>
      <xsl:otherwise>
        <mo><xsl:text disable-output-escaping="yes">&Integral;</xsl:text></mo>
	<xsl:apply-templates select="*[position()=last()]"/>
	<mo>d<!--DifferentialD does not work--></mo><xsl:apply-templates select="m:bvar"/>
      </xsl:otherwise>
      </xsl:choose>
    </xsl:otherwise>
    </xsl:choose>
  </mrow>
</xsl:template>

<!-- differentiation -->
<xsl:template match="m:apply[child::*[position()=1 and local-name()='diff']]">
    <mrow>
      <xsl:choose>
	<!-- If there's a bound-variable, use Leibniz notation-->
	<xsl:when test="m:bvar">
	  <xsl:choose>
	    <xsl:when test="m:bvar/m:degree"> 
	      <!-- if the order of the derivative is specified-->
	      <xsl:choose>
		<xsl:when test="contains(m:bvar/m:degree/m:cn/text(),'1') and string-length(normalize-space(m:bvar/m:degree/m:cn/text()))=1">
		  <mfrac>
		    <mo>d<!--DifferentialD does not work--></mo>
		    <mrow><mo>d<!--DifferentialD does not work--></mo>
		      <xsl:apply-templates select="m:bvar/*[local-name(.)!='degree']"/></mrow>
		  </mfrac>
		  <mrow>
		    <xsl:choose>
		      <xsl:when test="(m:apply[position()=last()]/m:fn[position()=1] or m:apply[position()=last()]/m:ci[@type='fn'] or m:matrix)"> 
			<xsl:apply-templates select="*[position()=last()]"/>
		      </xsl:when> <!--add brackets around expression if not a function-->
		      <xsl:otherwise>
			<mfenced separators=""><xsl:apply-templates select="*[position()=last()]"/></mfenced>
		      </xsl:otherwise>
		    </xsl:choose>
		  </mrow>
		</xsl:when>
		<xsl:otherwise> <!-- if the order of the derivative is not 1-->
		  <mfrac>
		    <mrow><msup><mo>d<!--DifferentialD does not work--></mo><mrow><xsl:apply-templates select="m:bvar/m:degree"/></mrow></msup></mrow>
		    <mrow><mo>d<!--DifferentialD does not work--></mo><msup><mrow><xsl:apply-templates select="m:bvar/*[local-name(.)!='degree']"/></mrow><mrow><xsl:apply-templates select="m:bvar/m:degree"/></mrow></msup></mrow>
		  </mfrac>
		  <mrow>
		    <xsl:choose>
		      <xsl:when test="(m:apply[position()=last()]/m:fn[position()=1] or m:apply[position()=last()]/m:ci[@type='fn'] or m:matrix)">
			<xsl:apply-templates select="*[position()=last()]"/>
		      </xsl:when>
		      <xsl:otherwise>
		    <mfenced separators=""><xsl:apply-templates select="*[position()=last()]"/></mfenced>
		      </xsl:otherwise>
		    </xsl:choose>
		  </mrow>
		</xsl:otherwise>
	      </xsl:choose>
	    </xsl:when>
	    <xsl:otherwise> <!-- if no order is specified, default to 1-->
	      <mfrac>
		<mo>d<!--DifferentialD does not work--></mo>
		<mrow><mo>d<!--DifferentialD does not work--></mo><xsl:apply-templates select="m:bvar"/></mrow>
	      </mfrac>
	      <mrow>
		<xsl:choose>
		  <xsl:when test="(m:apply[position()=last()]/m:fn[position()=1] or m:apply[position()=last()]/m:ci[@type='fn'] or m:matrix)">
		    <xsl:apply-templates select="*[position()=last()]"/>
		  </xsl:when>
		  <xsl:otherwise>
		    <mfenced separators=""><xsl:apply-templates select="*[position()=last()]"/></mfenced>
		  </xsl:otherwise>
		</xsl:choose>
	      </mrow>
	    </xsl:otherwise>
	  </xsl:choose>
	</xsl:when>
	<!-- Otherwise use prime notation -->
	<xsl:otherwise>
	  <msup>
	    <xsl:apply-templates select="m:apply/m:ci[position()=1] | m:ci"/>
	    <mo accent="true"><xsl:text disable-output-escaping="yes">&prime;</xsl:text></mo>
	  </msup>
	</xsl:otherwise>
      </xsl:choose>
    </mrow>
  </xsl:template>
	
<!-- partial differentiation -->
<!-- the latest working draft sets the default rendering of the numerator
to only one mfrac with one PartialD for the numerator, exponent being the sum
of every partial diff's orders; not supported yet (I am not sure it is even possible with XSLT)-->
<xsl:template match="m:apply[child::*[position()=1 and local-name()='partialdiff']]">
<mrow>
  <xsl:choose>
    <xsl:when test="m:list">
      <msub>
        <mo>D</mo>
        <mfenced separators="," open="" close=""><xsl:apply-templates select="m:list/*"/></mfenced>
      </msub>
      <mfenced open="(" close=")"><xsl:apply-templates select="*[local-name()!='list']"/></mfenced>
    </xsl:when>
    <xsl:otherwise>
      <xsl:for-each select="m:bvar">
      <xsl:choose>
      <xsl:when test="m:degree"> <!-- if the order of the derivative is specified-->
        <xsl:choose>
        <xsl:when test="contains(m:degree/m:cn/text(),'1') and string-length(normalize-space(m:degree/m:cn/text()))=1">
          <mfrac>
            <mrow><mo><xsl:text disable-output-escaping="yes">&PartialD;</xsl:text></mo></mrow>  
	    <mrow><mo><xsl:text disable-output-escaping="yes">&PartialD;</xsl:text></mo><xsl:apply-templates select="*[local-name(.)!='degree']"/></mrow>
          </mfrac>
        </xsl:when>
        <xsl:otherwise> <!-- if the order of the derivative is not 1-->
          <mfrac>
            <mrow><msup><mrow><mo><xsl:text disable-output-escaping="yes">&PartialD;</xsl:text></mo></mrow><mrow><xsl:apply-templates select="m:degree"/></mrow></msup></mrow>
  	    <mrow><mrow><mo><xsl:text disable-output-escaping="yes">&PartialD;</xsl:text></mo></mrow><msup><mrow><xsl:apply-templates select="*[local-name(.)!='degree']"/></mrow><mrow><xsl:apply-templates select="m:degree"/></mrow></msup></mrow>
          </mfrac>
        </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:otherwise> <!-- if no order is specified, default to 1-->
        <mfrac>
          <mrow><mo><xsl:text disable-output-escaping="yes">&PartialD;</xsl:text></mo></mrow>
          <mrow><mo><xsl:text disable-output-escaping="yes">&PartialD;</xsl:text></mo><xsl:apply-templates select="."/></mrow>
        </mfrac>
      </xsl:otherwise>
      </xsl:choose>
    </xsl:for-each>
    <mrow>
    <xsl:choose>
      <xsl:when test="m:apply[position()=last()]/m:fn[position()=1]"> 
        <xsl:apply-templates select="*[position()=last()]"/>
      </xsl:when> <!--add brackets around expression if not a function-->
      <xsl:otherwise>
        <mfenced separators=""><xsl:apply-templates select="*[position()=last()]"/></mfenced>
      </xsl:otherwise>
    </xsl:choose>
    </mrow>
  </xsl:otherwise>
  </xsl:choose>
</mrow>
</xsl:template>

<!-- lowlimit was not in original stylesheet -->
  <xsl:template match="m:lowlimit">
    <xsl:apply-templates select="*"/>
  </xsl:template>

<!-- uplimit was not in original stylesheet-->
  <xsl:template match="m:uplimit">
    <xsl:apply-templates select="*"/>
  </xsl:template>

<!-- bvar was not in original stylesheet -->
  <xsl:template match="m:bvar">
      <xsl:apply-templates select="*"/>
  </xsl:template>

<!-- divergence -->
<xsl:template match="m:apply[child::*[position()=1 and local-name()='divergence']]">
<mrow>
  <mi>div</mi>
  <xsl:choose>
  <xsl:when test="local-name(*[position()=2])='apply' or ((local-name(*[position()=2])='ci' or local-name(*[position()=2])='cn') and contains(*[position()=2]/text(),'-'))">
    <mfenced separators="">
      <xsl:apply-templates select="child::*[position()=2]"/>
    </mfenced>
  </xsl:when>
  <xsl:otherwise>
    <xsl:apply-templates select="child::*[position()=2]"/>
  </xsl:otherwise>
  </xsl:choose>
</mrow>
</xsl:template>

<!-- gradient -->
<xsl:template match="m:apply[child::*[position()=1 and local-name()='grad']]">
<mrow>
  <mi>grad</mi>
  <xsl:choose>
  <xsl:when test="local-name(*[position()=2])='apply' or ((local-name(*[position()=2])='ci' or local-name(*[position()=2])='cn') and contains(*[position()=2]/text(),'-'))">
    <mfenced separators="">
      <xsl:apply-templates select="child::*[position()=2]"/>
    </mfenced>
  </xsl:when>
  <xsl:otherwise>
    <xsl:apply-templates select="child::*[position()=2]"/>
  </xsl:otherwise>
  </xsl:choose>
</mrow>
</xsl:template>

<!-- vector calculus curl -->
<xsl:template match="m:apply[child::*[position()=1 and local-name()='curl']]">
<mrow>
  <mi>curl</mi>
  <xsl:choose>
  <xsl:when test="local-name(*[position()=2])='apply' or ((local-name(*[position()=2])='ci' or local-name(*[position()=2])='cn') and contains(*[position()=2]/text(),'-'))">
    <mfenced separators="">
      <xsl:apply-templates select="child::*[position()=2]"/>
    </mfenced>
  </xsl:when>
  <xsl:otherwise>
    <xsl:apply-templates select="child::*[position()=2]"/>
  </xsl:otherwise>
  </xsl:choose>
</mrow>
</xsl:template>

<!-- laplacian -->
<xsl:template match="m:apply[child::*[position()=1 and local-name()='laplacian']]">
<mrow>
  <msup>
    <mo><xsl:text disable-output-escaping='yes'>&amp;#x02207;</xsl:text></mo>  <!-- Del or nabla should work-->
    <mn>2</mn>
  </msup>
  <xsl:choose>
  <xsl:when test="local-name(*[position()=2])='apply' or ((local-name(*[position()=2])='ci' or local-name(*[position()=2])='cn') and contains(*[position()=2]/text(),'-'))">
    <mfenced separators="">
      <xsl:apply-templates select="child::*[position()=2]"/>
    </mfenced>
  </xsl:when>
  <xsl:otherwise>
    <xsl:apply-templates select="child::*[position()=2]"/>
  </xsl:otherwise>
  </xsl:choose>
</mrow>
</xsl:template>


<!-- #################### 4.4.6 #################### -->

<!-- set -->
<xsl:template match="m:set">
  <mrow>
    <xsl:choose>
    <xsl:when test="m:condition"> <!-- set defined by a condition-->
      <mo>{</mo><mrow><mfenced open="" close=""><xsl:apply-templates select="m:bvar"/></mfenced><mo>|</mo><xsl:apply-templates select="m:condition"/></mrow><mo>}</mo>
    </xsl:when>
	<xsl:otherwise> <!-- set defined by an enumeration -->
	  <mo>{</mo><mrow>
	    <xsl:for-each select="child::*">
	      <xsl:apply-templates select="."/>
	      <xsl:if test="(position()!=last())">
		<mo>,</mo>
	      </xsl:if>
	    </xsl:for-each>
	  </mrow>
	  <mo>}</mo>
	</xsl:otherwise>
    </xsl:choose>
  </mrow>
</xsl:template> 

<!-- list -->
<!-- sorting is not supported yet; not sure we should do it; anyway, can be  done using xsl:sort-->
<xsl:template match="m:list">
  <mrow>
    <xsl:choose>
    <xsl:when test="m:condition"> <!-- set defined by a condition-->
      <mo>[</mo><mrow><mfenced open="" close=""><xsl:apply-templates select="m:bvar"/></mfenced><mo>|</mo><xsl:apply-templates select="m:condition"/></mrow><mo>]</mo>
    </xsl:when>
    <xsl:otherwise> <!-- set defined by an enumeration -->
      <mfenced open="[" close="]"><xsl:apply-templates select="*"/></mfenced>
    </xsl:otherwise>
    </xsl:choose>
  </mrow>
</xsl:template>

<!-- union -->
<xsl:template match="m:apply[child::*[position()=1 and local-name()='union']]">
<mrow>
  <xsl:choose>
  <xsl:when test="count(*)>=3">
    <xsl:for-each select="child::*[position()!=last() and  position()!=1]">
      <xsl:apply-templates select="."/><mo><xsl:text disable-output-escaping="yes">&Union;</xsl:text></mo>
    </xsl:for-each>
    <xsl:apply-templates select="child::*[position()=last()]"/>
  </xsl:when>
  <xsl:when test="count(*)=2">
      <mo><xsl:text disable-output-escaping="yes">&Union;</xsl:text></mo><xsl:apply-templates select="*[position()=last()]"/>
  </xsl:when>
  <xsl:otherwise>
    <mo><xsl:text disable-output-escaping="yes">&Union;</xsl:text></mo>
  </xsl:otherwise>
  </xsl:choose>
</mrow>
</xsl:template>

<!-- intersection -->
<xsl:template match="m:apply[child::*[position()=1 and local-name()='intersect']]">
<mrow>
  <xsl:choose>
  <xsl:when test="count(*)>=3">
    <xsl:for-each select="child::*[position()!=last() and  position()!=1]">
      <xsl:choose>
      <xsl:when test="m:union">  <!-- add brackets around UNION children for priority purpose: intersection has higher precedence than union -->
        <mfenced separators=""><xsl:apply-templates select="."/></mfenced><mo><xsl:text disable-output-escaping="yes">&Intersection;</xsl:text></mo>
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-templates select="."/><mo><xsl:text disable-output-escaping="yes">&Intersection;</xsl:text></mo>
      </xsl:otherwise>
      </xsl:choose>
    </xsl:for-each>
    <xsl:apply-templates select="child::*[position()=last()]"/>
  </xsl:when>
  <xsl:when test="count(*)=2">
      <mo><xsl:text disable-output-escaping="yes">&Intersection;</xsl:text></mo><xsl:apply-templates select="*[position()=last()]"/>
  </xsl:when>
  <xsl:otherwise>
    <mo><xsl:text disable-output-escaping="yes">&Intersection;</xsl:text></mo>
  </xsl:otherwise>
  </xsl:choose>
</mrow>
</xsl:template>

<!-- inclusion -->
<xsl:template match="m:apply[child::*[position()=1 and local-name()='in']]">
<mrow>
  <xsl:apply-templates select="*[position()=2]"/>
  <mo><xsl:text disable-output-escaping="yes">&isin;</xsl:text></mo>
  <xsl:apply-templates select="*[position()=3]"/>
</mrow>
</xsl:template>

<xsl:template match="m:reln[child::*[position()=1 and local-name()='in']]">
<mrow>
  <xsl:apply-templates select="*[position()=2]"/>
  <mo><xsl:text disable-output-escaping="yes">&isin;</xsl:text></mo>
  <xsl:apply-templates select="*[position()=3]"/>
</mrow>
</xsl:template>

<!-- exclusion -->
<xsl:template match="m:apply[child::*[position()=1 and local-name()='notin']]">
<mrow>
  <xsl:apply-templates select="*[position()=2]"/>
  <mo><xsl:text disable-output-escaping="yes">&notin;</xsl:text></mo>
  <xsl:apply-templates select="*[position()=3]"/>
</mrow>
</xsl:template>

<xsl:template match="m:reln[child::*[position()=1 and local-name()='notin']]">
<mrow>
  <xsl:apply-templates select="*[position()=2]"/>
  <mo><xsl:text disable-output-escaping="yes">&notin;</xsl:text></mo>
  <xsl:apply-templates select="*[position()=3]"/>
</mrow>
</xsl:template>

<!-- containment (subset of)-->
<xsl:template name="subsetRel">
<mrow>
  <xsl:choose>
  <xsl:when test="count(*)>=3">
    <xsl:for-each select="child::*[position()!=last() and  position()!=1]">
      <xsl:apply-templates select="."/><mo><xsl:text disable-output-escaping="yes">&SubsetEqual;</xsl:text></mo>
    </xsl:for-each>
    <xsl:apply-templates select="child::*[position()=last()]"/>
    </xsl:when>
    <xsl:when test="count(*)=2">
      <mo><xsl:text disable-output-escaping="yes">&SubsetEqual;</xsl:text></mo><xsl:apply-templates select="*[position()=last()]"/>
  </xsl:when>
  <xsl:otherwise>
    <mo><xsl:text disable-output-escaping="yes">&SubsetEqual;</xsl:text></mo>
  </xsl:otherwise>
  </xsl:choose>
</mrow>
</xsl:template>

<xsl:template match="m:apply[child::*[position()=1 and local-name()='subset']]">
  <xsl:call-template name="subsetRel"/>
</xsl:template>

<xsl:template match="m:reln[child::*[position()=1 and local-name()='subset']]">
  <xsl:call-template name="subsetRel"/>
</xsl:template>

<!-- containment (proper subset of) -->
<xsl:template name="prsubsetRel">
<mrow>
  <xsl:choose>
  <xsl:when test="count(*)>=3">
    <xsl:for-each select="child::*[position()!=last() and  position()!=1]">
      <xsl:apply-templates select="."/><mo><xsl:text disable-output-escaping="yes">&Subset;</xsl:text></mo>
    </xsl:for-each>
    <xsl:apply-templates select="child::*[position()=last()]"/>
    </xsl:when>
    <xsl:when test="count(*)=2">
      <mo><xsl:text disable-output-escaping="yes">&Subset;</xsl:text></mo><xsl:apply-templates select="*[position()=last()]"/>
  </xsl:when>
  <xsl:otherwise>
    <mo><xsl:text disable-output-escaping="yes">&Subset;</xsl:text></mo>
  </xsl:otherwise>
  </xsl:choose>
</mrow>
</xsl:template>

<xsl:template match="m:apply[child::*[position()=1 and local-name()='prsubset']]">
  <xsl:call-template name="prsubsetRel"/>
</xsl:template>

<xsl:template match="m:reln[child::*[position()=1 and local-name()='prsubset']]">
  <xsl:call-template name="prsubsetRel"/>
</xsl:template>

<!-- perhaps Subset and SubsetEqual signs are used in place of one another ; not according to the spec -->

<!-- containment (not subset of)-->
<xsl:template match="m:apply[child::*[position()=1 and local-name()='notsubset']]">
<mrow>
  <xsl:apply-templates select="*[position()=2]"/>
  <mo><xsl:text disable-output-escaping="yes">&NotSubset;</xsl:text></mo>
  <xsl:apply-templates select="*[position()=3]"/>
</mrow>
</xsl:template>

<xsl:template match="m:reln[child::*[position()=1 and local-name()='notsubset']]">
<mrow>
  <xsl:apply-templates select="*[position()=2]"/>
  <mo><xsl:text disable-output-escaping="yes">&NotSubset;</xsl:text></mo>
  <xsl:apply-templates select="*[position()=3]"/>
</mrow>
</xsl:template>

<!-- containment (not proper subset of) -->
<xsl:template match="m:apply[child::*[position()=1 and local-name()='notprsubset']]">
<mrow>
  <xsl:apply-templates select="*[position()=2]"/>
  <mo><xsl:text disable-output-escaping="yes">&NotSubsetEqual;</xsl:text></mo>  <!-- does not work, perhaps nsube, or nsubE, or nsubseteqq or nsubseteq, UNICODE x02288-->
  <xsl:apply-templates select="*[position()=3]"/>
</mrow>
</xsl:template>

<xsl:template match="m:reln[child::*[position()=1 and local-name()='notprsubset']]">
<mrow>
  <xsl:apply-templates select="*[position()=2]"/>
  <mo><xsl:text disable-output-escaping="yes">&NotSubsetEqual;</xsl:text></mo>  <!-- does not work, perhaps nsube, or nsubE, or nsubseteqq or nsubseteq, UNICODE x02288-->
  <xsl:apply-templates select="*[position()=3]"/>
</mrow>
</xsl:template>

<!-- difference of two sets -->
<xsl:template match="m:apply[child::*[position()=1 and local-name()='setdiff']]">
<mrow>
  <xsl:apply-templates select="*[position()=2]"/>
  <mo><xsl:text disable-output-escaping="yes">&Backslash;</xsl:text></mo>
  <xsl:apply-templates select="*[position()=3]"/>
</mrow>
</xsl:template>

<!-- cardinality -->
<xsl:template match="m:apply[child::*[position()=1 and local-name()='card']]">
  <mrow><mo>|</mo><xsl:apply-templates select="*[position()=last()]"/><mo>|</mo></mrow>
</xsl:template>

<!-- cartesian product -->
<xsl:template match="m:apply[child::*[position()=1 and local-name()='cartesianproduct']]">
<xsl:choose>
<xsl:when test="count(child::*)>=3">
  <mrow>
    <xsl:for-each select="child::*[position()!=last() and  position()!=1]">
      <xsl:choose>
      <xsl:when test="m:plus"> <!--add brackets around + children for priority purpose-->
        <mfenced separators=""><xsl:apply-templates select="."/></mfenced><mo><xsl:text disable-output-escaping="yes">&times;</xsl:text></mo>
      </xsl:when>
      <xsl:when test="m:minus"> <!--add brackets around - children for priority purpose-->
        <mfenced separators=""><xsl:apply-templates select="."/></mfenced><mo><xsl:text disable-output-escaping="yes">&times;</xsl:text></mo>
      </xsl:when>
      <xsl:when test="(local-name(.)='ci' or local-name(.)='cn') and contains(text(),'-')"> <!-- have to do it using contains because starts-with doesn't seem to work well in XT-->
        <mfenced separators=""><xsl:apply-templates select="."/></mfenced><mo><xsl:text disable-output-escaping="yes">&times;</xsl:text></mo>
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-templates select="."/><mo><xsl:text disable-output-escaping="yes">&times;</xsl:text></mo>
      </xsl:otherwise>
      </xsl:choose>
    </xsl:for-each>
    <xsl:for-each select="child::*[position()=last()]">
      <xsl:choose>
      <xsl:when test="m:plus">
        <mfenced separators=""><xsl:apply-templates select="."/></mfenced>
      </xsl:when>
      <xsl:when test="m:minus">
        <mfenced separators=""><xsl:apply-templates select="."/></mfenced>
      </xsl:when>
      <xsl:when test="(local-name(.)='ci' or local-name(.)='cn') and contains(text(),'-')"> <!-- have to do it using contains because starts-with doesn't seem to work well in  XT-->
        <mfenced separators=""><xsl:apply-templates select="."/></mfenced>
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-templates select="."/>
      </xsl:otherwise>
      </xsl:choose>
    </xsl:for-each>
  </mrow>
</xsl:when>
<xsl:when test="count(child::*)=2">  <!-- unary -->
  <mrow>
    <mo><xsl:text disable-output-escaping="yes">&times;</xsl:text></mo>
    <xsl:choose>
      <xsl:when test="m:plus">
        <mfenced separators=""><xsl:apply-templates select="*[position()=2]"/></mfenced>
      </xsl:when>
      <xsl:when test="m:minus">
        <mfenced separators=""><xsl:apply-templates select="*[position()=2]"/></mfenced>
      </xsl:when>
      <xsl:when test="(*[position()=2 and self::m:ci] or *[position()=2 and self::m:cn]) and contains(*[position()=2]/text(),'-')">
        <mfenced separators=""><xsl:apply-templates select="*[position()=2]"/></mfenced>
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-templates select="*[position()=2]"/>
      </xsl:otherwise>
    </xsl:choose>
  </mrow>
</xsl:when>
<xsl:otherwise>  <!-- no operand -->
  <mo><xsl:text disable-output-escaping="yes">&InvisibleTimes;</xsl:text></mo>
</xsl:otherwise>
</xsl:choose>
</xsl:template>

<!-- #################### 4.4.7 #################### -->

<!-- sum -->
<xsl:template match="m:apply[child::*[position()=1 and local-name()='sum']]">
<mrow>
  <xsl:choose>
  <xsl:when test="m:condition">  <!-- domain specified by a condition -->
    <munder>
      <mo><xsl:text disable-output-escaping="yes">&Sum;</xsl:text></mo>
      <xsl:apply-templates select="m:condition"/>
    </munder>
  </xsl:when>
  <xsl:when test="m:domainofapplication">  <!-- domain specified by domain of application -->
    <munder>
      <mo><xsl:text disable-output-escaping="yes">&Sum;</xsl:text></mo>
      <xsl:apply-templates select="m:domainofapplication"/>
    </munder>
  </xsl:when>
  <xsl:otherwise>  <!-- domain specified by low and up limits -->
    <msubsup>
      <mo><xsl:text disable-output-escaping="yes">&Sum;</xsl:text></mo>
      <mrow><xsl:apply-templates select="m:bvar"/><mo>=</mo><xsl:apply-templates select="m:lowlimit"/></mrow>
      <mrow><xsl:apply-templates select="m:uplimit"/></mrow>
    </msubsup>
  </xsl:otherwise>
  </xsl:choose>
  <xsl:choose>
  <xsl:when test="*[position()=last() and self::m:apply]">  <!-- if expression is complex, wrap it in brackets -->
    <mfenced separators=""><xsl:apply-templates select="*[position()=last()]"/></mfenced>
  </xsl:when>
  <xsl:otherwise>  <!-- if not put it in an mrow -->
    <mrow><xsl:apply-templates select="*[position()=last()]"/></mrow>
  </xsl:otherwise>
  </xsl:choose>
</mrow>
</xsl:template>

<!-- product -->
<xsl:template match="m:apply[child::*[position()=1 and local-name()='product']]">
<mrow>
  <xsl:choose>
  <xsl:when test="m:condition">   <!-- domain specified by a condition -->
    <munder>
      <mo><xsl:text disable-output-escaping="yes">&Product;</xsl:text></mo>
      <xsl:apply-templates select="m:condition"/>
    </munder>
  </xsl:when>
  <xsl:when test="m:domainofapplication"> <!--domain specified by a domain -->
    <munder>
      <mo><xsl:text disable-output-escaping="yes">&Product;</xsl:text></mo>
      <xsl:apply-templates select="m:domainofapplication"/>
    </munder>
  </xsl:when>
  <xsl:otherwise>  <!-- domain specified by low and up limits -->
    <msubsup>
      <mo><xsl:text disable-output-escaping="yes">&Product;</xsl:text></mo>
      <mrow><xsl:apply-templates select="m:bvar"/><mo>=</mo><xsl:apply-templates select="m:lowlimit"/></mrow>
      <mrow><xsl:apply-templates select="m:uplimit"/></mrow>
    </msubsup>
  </xsl:otherwise>
  </xsl:choose>
  <xsl:choose>
  <xsl:when test="*[position()=last() and self::m:apply]">  <!-- if expression is complex, wrap it in brackets -->
    <mfenced separators=""><xsl:apply-templates select="*[position()=last()]"/></mfenced>
  </xsl:when>
  <xsl:otherwise>  <!-- if not put it in an mrow -->
    <mrow><xsl:apply-templates select="*[position()=last()]"/></mrow>
  </xsl:otherwise>
  </xsl:choose>
</mrow>
</xsl:template>

<!-- limit -->
<xsl:template match="m:apply[child::*[position()=1 and local-name()='limit']]">
<mrow>
  <xsl:choose>
  <xsl:when test="m:condition">
    <munder>
      <mo>lim</mo>
      <xsl:apply-templates select="m:condition"/>
    </munder>
  </xsl:when>
  <xsl:otherwise>
    <munder>
      <mo>lim</mo>
      <mrow><xsl:apply-templates select="m:bvar"/><mo><xsl:text disable-output-escaping="yes">&RightArrow;</xsl:text></mo><xsl:apply-templates select="m:lowlimit"/></mrow>
    </munder>
  </xsl:otherwise>
  </xsl:choose>
  <mrow><xsl:apply-templates select="*[position()=last()]"/></mrow>
</mrow>
</xsl:template>

<!-- tends to -->
<xsl:template name="tendstoRel">
<mrow>
  <xsl:choose>
  <xsl:when test="m:tendsto/@type">
    <xsl:choose>
    <xsl:when test="m:tendsto/@type='above'"> <!-- from above -->
      <xsl:apply-templates select="*[position()=2]"/><mo><xsl:text disable-output-escaping="yes">&DownArrow;</xsl:text></mo><xsl:apply-templates select="*[position()=3]"/>
    </xsl:when>
    <xsl:when test="m:tendsto/@type='below'"> <!-- from below -->
      <xsl:apply-templates select="*[position()=2]"/><mo><xsl:text disable-output-escaping="yes">&UpArrow;</xsl:text></mo><xsl:apply-templates select="*[position()=3]"/>
    </xsl:when>
    <xsl:when test="m:tendsto/@type='two-sided'"> <!-- from above or below -->
      <xsl:apply-templates select="*[position()=2]"/><mo><xsl:text disable-output-escaping="yes">&RightArrow;</xsl:text></mo><xsl:apply-templates select="*[position()=3]"/>
    </xsl:when>
    </xsl:choose>
  </xsl:when>
  <xsl:otherwise>  <!-- no type attribute -->
    <xsl:apply-templates select="*[position()=2]"/><mo><xsl:text disable-output-escaping="yes">&RightArrow;</xsl:text></mo><xsl:apply-templates select="*[position()=3]"/>
  </xsl:otherwise>
  </xsl:choose>
</mrow>
</xsl:template>

<xsl:template match="m:apply[child::*[position()=1 and local-name()='tendsto']]">
  <xsl:call-template name="tendstoRel"/>
</xsl:template>

<xsl:template match="m:reln[child::*[position()=1 and local-name()='tendsto']]">
  <xsl:call-template name="tendstoRel"/>
</xsl:template>

<!-- #################### 4.4.8 #################### -->

<!-- main template for all trigonometric functions -->
<xsl:template name="trigo">
  <xsl:param name="func">sin</xsl:param> <!-- provide sin as default function in case none is provided (this should never occur)-->
<mrow>
  <mi><xsl:value-of select="$func"/></mi><mo><xsl:text disable-output-escaping="yes">&ApplyFunction;</xsl:text></mo>
  <xsl:choose>
  <xsl:when test="local-name(*[position()=2])='apply' or ((local-name(*[position()=2])='ci' or local-name(*[position()=2])='cn') and contains(*[position()=2]/text(),'-'))">
    <mfenced separators="">
    <xsl:apply-templates select="child::*[position()=2]"/>
    </mfenced>
  </xsl:when>
  <xsl:otherwise>
	    <mfenced separators="">
	      <xsl:apply-templates select="child::*[position()=2]"/>
	    </mfenced>
  </xsl:otherwise>
  </xsl:choose>
</mrow>
</xsl:template>

<!-- trigonometric function: sine -->
<xsl:template match="m:apply[child::*[position()=1 and local-name()='sin']]">
  <xsl:call-template name="trigo">
    <xsl:with-param name="func">sin</xsl:with-param>
  </xsl:call-template>
</xsl:template>

<xsl:template match="m:sin[local-name(preceding-sibling::*[position()=last()])='compose' or local-name(preceding-sibling::*[position()=last()])='inverse']">
  <mi>sin</mi>  <!-- used with inverse or composition-->
</xsl:template>

<!-- trigonometric function: cosine -->
<xsl:template match="m:apply[child::*[position()=1 and local-name()='cos']]">
  <xsl:call-template name="trigo">
    <xsl:with-param name="func">cos</xsl:with-param>
  </xsl:call-template>
</xsl:template>

<xsl:template match="m:cos[local-name(preceding-sibling::*[position()=last()])='compose' or local-name(preceding-sibling::*[position()=last()])='inverse']">
  <mi>cos</mi>   <!-- used with inverse or composition-->
</xsl:template>

<!-- trigonometric function: tan -->
<xsl:template match="m:apply[child::*[position()=1 and local-name()='tan']]">
  <xsl:call-template name="trigo">
    <xsl:with-param name="func">tan</xsl:with-param>   
  </xsl:call-template>
</xsl:template>

<xsl:template match="m:tan[local-name(preceding-sibling::*[position()=last()])='compose' or local-name(preceding-sibling::*[position()=last()])='inverse']">
  <mi>tan</mi>   <!-- used with inverse or composition-->
</xsl:template>

<!-- trigonometric function: sec -->
<xsl:template match="m:apply[child::*[position()=1 and local-name()='sec']]">
  <xsl:call-template name="trigo">
    <xsl:with-param name="func">sec</xsl:with-param>  
  </xsl:call-template>
</xsl:template>

<xsl:template match="m:sec[local-name(preceding-sibling::*[position()=last()])='compose' or local-name(preceding-sibling::*[position()=last()])='inverse']">
  <mi>sec</mi>   <!-- used with inverse or composition-->
</xsl:template>

<!-- trigonometric function: csc -->
<xsl:template match="m:apply[child::*[position()=1 and local-name()='csc']]">
  <xsl:call-template name="trigo">
    <xsl:with-param name="func">csc</xsl:with-param>    
  </xsl:call-template>
</xsl:template>

<xsl:template match="m:csc[local-name(preceding-sibling::*[position()=last()])='compose' or local-name(preceding-sibling::*[position()=last()])='inverse']">
  <mi>csc</mi>   <!-- used with inverse or composition-->
</xsl:template>

<!-- trigonometric function: cotan -->
<xsl:template match="m:apply[child::*[position()=1 and local-name()='cot']]">
  <xsl:call-template name="trigo">
    <xsl:with-param name="func">cot</xsl:with-param>    
  </xsl:call-template>
</xsl:template>

<xsl:template match="m:cot[local-name(preceding-sibling::*[position()=last()])='compose' or local-name(preceding-sibling::*[position()=last()])='inverse']">
  <mi>cot</mi>   <!-- used with inverse or composition-->
</xsl:template>

<!-- trigonometric function: hyperbolic sin -->
<xsl:template match="m:apply[child::*[position()=1 and local-name()='sinh']]">
  <xsl:call-template name="trigo">
    <xsl:with-param name="func">sinh</xsl:with-param>    
  </xsl:call-template>
</xsl:template>

<xsl:template match="m:sinh[local-name(preceding-sibling::*[position()=last()])='compose' or local-name(preceding-sibling::*[position()=last()])='inverse']">
  <mi>sinh</mi>   <!-- used with inverse or composition-->
</xsl:template>

<!-- trigonometric function: hyperbolic cos -->
<xsl:template match="m:apply[child::*[position()=1 and local-name()='cosh']]">
  <xsl:call-template name="trigo">
    <xsl:with-param name="func">cosh</xsl:with-param>    
  </xsl:call-template>
</xsl:template>

<xsl:template match="m:cosh[local-name(preceding-sibling::*[position()=last()])='compose' or local-name(preceding-sibling::*[position()=last()])='inverse']">
  <mi>cosh</mi>   <!-- used with inverse or composition-->
</xsl:template>

<!-- trigonometric function: hyperbolic tan -->
<xsl:template match="m:apply[child::*[position()=1 and local-name()='tanh']]">
  <xsl:call-template name="trigo">
    <xsl:with-param name="func">tanh</xsl:with-param>    
  </xsl:call-template>
</xsl:template>

<xsl:template match="m:tanh[local-name(preceding-sibling::*[position()=last()])='compose' or local-name(preceding-sibling::*[position()=last()])='inverse']">
  <mi>tanh</mi>   <!-- used with inverse or composition-->
</xsl:template>

<!-- trigonometric function: hyperbolic sec -->
<xsl:template match="m:apply[child::*[position()=1 and local-name()='sech']]">
  <xsl:call-template name="trigo">
    <xsl:with-param name="func">sech</xsl:with-param>    
  </xsl:call-template>
</xsl:template>

<xsl:template match="m:sech[local-name(preceding-sibling::*[position()=last()])='compose' or local-name(preceding-sibling::*[position()=last()])='inverse']">
  <mi>sech</mi>   <!-- used with inverse or composition-->
</xsl:template>

<!-- trigonometric function: hyperbolic csc -->
<xsl:template match="m:apply[child::*[position()=1 and local-name()='csch']]">
  <xsl:call-template name="trigo">
    <xsl:with-param name="func">csch</xsl:with-param>   
  </xsl:call-template>
</xsl:template>

<xsl:template match="m:csch[local-name(preceding-sibling::*[position()=last()])='compose' or local-name(preceding-sibling::*[position()=last()])='inverse']">
  <mi>csch</mi>   <!-- used with inverse or composition-->
</xsl:template>

<!-- trigonometric function: hyperbolic cotan -->
<xsl:template match="m:apply[child::*[position()=1 and local-name()='coth']]">
  <xsl:call-template name="trigo">
    <xsl:with-param name="func">coth</xsl:with-param>   
  </xsl:call-template>
</xsl:template>

<xsl:template match="m:coth[local-name(preceding-sibling::*[position()=last()])='compose' or local-name(preceding-sibling::*[position()=last()])='inverse']">
  <mi>coth</mi>   <!-- used with inverse or composition-->
</xsl:template>

<!-- trigonometric function: arc sine -->
<xsl:template match="m:apply[child::*[position()=1 and local-name()='arcsin']]">
  <xsl:call-template name="trigo">
    <xsl:with-param name="func">arcsin</xsl:with-param>    
  </xsl:call-template>
</xsl:template>

<xsl:template match="m:arcsin[local-name(preceding-sibling::*[position()=last()])='compose' or local-name(preceding-sibling::*[position()=last()])='inverse']">
  <mi>arcsin</mi>   <!-- used with inverse or composition-->
</xsl:template>

<!-- trigonometric function: arc cosine -->
<xsl:template match="m:apply[child::*[position()=1 and local-name()='arccos']]">
  <xsl:call-template name="trigo">
    <xsl:with-param name="func">arccos</xsl:with-param>    
  </xsl:call-template>
</xsl:template>

<xsl:template match="m:arccos[local-name(preceding-sibling::*[position()=last()])='compose' or local-name(preceding-sibling::*[position()=last()])='inverse']">
  <mi>arccos</mi>   <!-- used with inverse or composition-->
</xsl:template>

<!-- trigonometric function: arc tan -->
<xsl:template match="m:apply[child::*[position()=1 and local-name()='arctan']]">
  <xsl:call-template name="trigo">
    <xsl:with-param name="func">arctan</xsl:with-param>    
  </xsl:call-template>
</xsl:template>

<xsl:template match="m:arctan[local-name(preceding-sibling::*[position()=last()])='compose' or local-name(preceding-sibling::*[position()=last()])='inverse']">
  <mi>arctan</mi>   <!-- used with inverse or composition-->
</xsl:template>

<!-- trigonometric function: arc sec -->
<xsl:template match="m:apply[child::*[position()=1 and local-name()='arcsec']]">
  <xsl:call-template name="trigo">
    <xsl:with-param name="func">arcsec</xsl:with-param>    
  </xsl:call-template>
</xsl:template>

<xsl:template match="m:arcsec[local-name(preceding-sibling::*[position()=last()])='compose' or local-name(preceding-sibling::*[position()=last()])='inverse']">
  <mi>arcsec</mi>   <!-- used with inverse or composition-->
</xsl:template>

<!-- trigonometric function: arc csc -->
<xsl:template match="m:apply[child::*[position()=1 and local-name()='arccsc']]">
  <xsl:call-template name="trigo">
    <xsl:with-param name="func">arccsc</xsl:with-param>    
  </xsl:call-template>
</xsl:template>

<xsl:template match="m:arccsc[local-name(preceding-sibling::*[position()=last()])='compose' or local-name(preceding-sibling::*[position()=last()])='inverse']">
  <mi>arccsc</mi>   <!-- used with inverse or composition-->
</xsl:template>

<!-- trigonometric function: arc cotan -->
<xsl:template match="m:apply[child::*[position()=1 and local-name()='arccot']]">
  <xsl:call-template name="trigo">
    <xsl:with-param name="func">arccot</xsl:with-param>    
  </xsl:call-template>
</xsl:template>

<xsl:template match="m:arccot[local-name(preceding-sibling::*[position()=last()])='compose' or local-name(preceding-sibling::*[position()=last()])='inverse']">
  <mi>arccot</mi>   <!-- used with inverse or composition-->
</xsl:template>

<!-- trigonometric function: arc sinh -->
<xsl:template match="m:apply[child::*[position()=1 and local-name()='arcsinh']]">
  <xsl:call-template name="trigo">
    <xsl:with-param name="func">arcsinh</xsl:with-param>
  </xsl:call-template>
</xsl:template>

<xsl:template match="m:arcsinh[local-name(preceding-sibling::*[position()=last()])='compose' or local-name(preceding-sibling::*[position()=last()])='inverse']">
  <mi>arcsinh</mi>   <!-- used with inverse or composition-->
</xsl:template>

<!-- trigonometric function: arc cosh -->
<xsl:template match="m:apply[child::*[position()=1 and local-name()='arccosh']]">
  <xsl:call-template name="trigo">
    <xsl:with-param name="func">arccosh</xsl:with-param>    
  </xsl:call-template>
</xsl:template>

<xsl:template match="m:arccosh[local-name(preceding-sibling::*[position()=last()])='compose' or local-name(preceding-sibling::*[position()=last()])='inverse']">
  <mi>arccosh</mi>   <!-- used with inverse or composition-->
</xsl:template>

<!-- trigonometric function: arc tanh -->
<xsl:template match="m:apply[child::*[position()=1 and local-name()='arctanh']]">
  <xsl:call-template name="trigo">
    <xsl:with-param name="func">arctanh</xsl:with-param>    
  </xsl:call-template>
</xsl:template>

<xsl:template match="m:arctanh[local-name(preceding-sibling::*[position()=last()])='compose' or local-name(preceding-sibling::*[position()=last()])='inverse']">
  <mi>arctanh</mi>   <!-- used with inverse or composition-->
</xsl:template>

<!-- trigonometric function: arc sech -->
<xsl:template match="m:apply[child::*[position()=1 and local-name()='arcsech']]">
  <xsl:call-template name="trigo">
    <xsl:with-param name="func">arcsech</xsl:with-param>    
  </xsl:call-template>
</xsl:template>

<xsl:template match="m:arcsech[local-name(preceding-sibling::*[position()=last()])='compose' or local-name(preceding-sibling::*[position()=last()])='inverse']">
  <mi>arcsech</mi>   <!-- used with inverse or composition-->
</xsl:template>

<!-- trigonometric function: arc csch -->
<xsl:template match="m:apply[child::*[position()=1 and local-name()='arccsch']]">
  <xsl:call-template name="trigo">
    <xsl:with-param name="func">arccsch</xsl:with-param>    
  </xsl:call-template>
</xsl:template>

<xsl:template match="m:arccsch[local-name(preceding-sibling::*[position()=last()])='compose' or local-name(preceding-sibling::*[position()=last()])='inverse']">
  <mi>arccsch</mi>   <!-- used with inverse or composition-->
</xsl:template>

<!-- trigonometric function: arc coth -->
<xsl:template match="m:apply[child::*[position()=1 and local-name()='arccoth']]">
  <xsl:call-template name="trigo">
    <xsl:with-param name="func">arccoth</xsl:with-param>   
  </xsl:call-template>
</xsl:template>

<xsl:template match="m:arccoth[local-name(preceding-sibling::*[position()=last()])='compose' or local-name(preceding-sibling::*[position()=last()])='inverse']">
  <mi>arccoth</mi>   <!-- used with inverse or composition-->
</xsl:template>

<!-- exponential -->
<xsl:template match="m:apply[child::*[position()=1 and local-name()='exp']]">
  <msup>
    <mi><xsl:text disable-output-escaping="yes">&ee;</xsl:text></mi>   <!-- ExponentialE does not work yet -->
    <xsl:apply-templates select="child::*[position()=2]"/>
  </msup>
</xsl:template>

<xsl:template match="m:exp[local-name(preceding-sibling::*[position()=last()])='compose' or local-name(preceding-sibling::*[position()=last()])='inverse']">
  <mi><xsl:text disable-output-escaping="yes">&ExponentialE;</xsl:text></mi>   <!-- used with inverse or composition; not sure it is appropriate for exponential-->
</xsl:template>

<!-- natural logarithm -->
<xsl:template match="m:apply[child::*[position()=1 and local-name()='ln']]">
<mrow>
  <mi>ln</mi><mo><xsl:text disable-output-escaping="yes">&ApplyFunction;</xsl:text></mo>
  <xsl:choose>
  <xsl:when test="local-name(*[position()=2])='apply' or ((local-name(*[position()=2])='ci' or local-name(*[position()=2])='cn') and contains(*[position()=2]/text(),'-'))">
    <mfenced separators="">
      <xsl:apply-templates select="child::*[position()=2]"/>
    </mfenced>
  </xsl:when>
  <xsl:otherwise>
    <xsl:apply-templates select="child::*[position()=2]"/>
  </xsl:otherwise>
  </xsl:choose>
</mrow>
</xsl:template>

<xsl:template match="m:ln[local-name(preceding-sibling::*[position()=last()])='compose' or local-name(preceding-sibling::*[position()=last()])='inverse']">
  <mi>ln</mi>   <!-- used with inverse or composition-->
</xsl:template>

<!-- logarithm to a given base (default 10)-->
<xsl:template match="m:apply[child::*[position()=1 and local-name()='log']]">
<mrow>
  <xsl:choose>
  <xsl:when test="m:logbase">
    <msub>
      <mi>log</mi>
      <xsl:apply-templates select="m:logbase"/>
    </msub>
    <mo><xsl:text disable-output-escaping="yes">&ApplyFunction;</xsl:text></mo>
    <xsl:choose>
    <xsl:when test="local-name(*[position()=3])='apply' or ((local-name(*[position()=3])='ci' or local-name(*[position()=3])='cn') and contains(*[position()=3]/text(),'-'))">
      <mfenced separators="">
        <xsl:apply-templates select="child::*[position()=3]"/>
      </mfenced>
    </xsl:when>
    <xsl:otherwise>
      <xsl:apply-templates select="child::*[position()=3]"/>
    </xsl:otherwise>
    </xsl:choose>
  </xsl:when>
  <xsl:otherwise> <!--if no base is provided, default to 10-->
    <msub>
      <mi>log</mi>
      <mn>10</mn>
    </msub>
    <mo><xsl:text disable-output-escaping="yes">&ApplyFunction;</xsl:text></mo>
    <xsl:choose>
    <xsl:when test="local-name(*[position()=2])='apply' or ((local-name(*[position()=2])='ci' or local-name(*[position()=2])='cn') and contains(*[position()=2]/text(),'-'))">
      <mfenced separators="">
        <xsl:apply-templates select="child::*[position()=2]"/>
      </mfenced>
    </xsl:when>
    <xsl:otherwise>
      <xsl:apply-templates select="child::*[position()=2]"/>
    </xsl:otherwise>
    </xsl:choose>
  </xsl:otherwise>
  </xsl:choose>
</mrow>
</xsl:template>

<!-- logbase -->
<xsl:template match="m:logbase">
    <xsl:apply-templates select="*"/>
  </xsl:template>

<xsl:template match="m:log[local-name(preceding-sibling::*[position()=last()])='compose' or local-name(preceding-sibling::*[position()=last()])='inverse']">
<mrow>  <!-- used with inverse or composition-->
  <xsl:choose>
  <xsl:when test="m:logbase">
    <msub>
      <mi>log</mi>
      <xsl:apply-templates select="m:logbase"/>
    </msub>
  </xsl:when>
  <xsl:otherwise> <!--if no base is provided, default to 10-->
    <msub>
      <mi>log</mi>
      <mn>10</mn>
    </msub>
  </xsl:otherwise>
  </xsl:choose>
</mrow>
</xsl:template>

<!-- #################### 4.4.9 #################### -->

<!-- mean -->
<!-- not sure we handle the n-ary thing correctly as far as display is concerned-->
<xsl:template match="m:apply[child::*[position()=1 and local-name()='mean']]">
<mrow>
  <xsl:choose>
  <xsl:when test="count(*)>2">  <!-- if more than one element use angle bracket notation-->
    <mo><xsl:text disable-output-escaping="yes">&lang;</xsl:text></mo>
    <xsl:for-each select="*[position()!=1 and position()!=last()]">
      <xsl:apply-templates select="."/><mo>,</mo>
    </xsl:for-each>
    <xsl:apply-templates select="*[position()=last()]"/>
    <mo><xsl:text disable-output-escaping="yes">&rang;</xsl:text></mo>  <!-- does not work, UNICODE x03009 or perhaps rangle or RightAngleBracket -->
  </xsl:when>
  <xsl:otherwise> <!-- if only one element use overbar notation-->
    <mover>
      <xsl:apply-templates select="*[position()=last()]"/>
      <mo><xsl:text disable-output-escaping="yes">&OverBar;</xsl:text></mo>  <!-- does not work, UNICODE x0233D  or perhaps OverBar-->
    </mover>
  </xsl:otherwise>
  </xsl:choose>
</mrow>
</xsl:template>

<!-- standard deviation -->
<!-- not sure we handle the n-ary thing correctly as far as display is concerned-->
<xsl:template match="m:apply[child::*[position()=1 and local-name()='sdev']]">
<mrow>
  <mi><xsl:text disable-output-escaping="yes">&sigma;</xsl:text></mi>
  <mfenced>
    <xsl:apply-templates select="*[position()!=1]"/>
  </mfenced>
</mrow>
</xsl:template>

<!-- statistical variance -->
<!-- not sure we handle the n-ary thing correctly as far as display is concerned-->
<xsl:template match="m:apply[child::*[position()=1 and local-name()='variance']]">
<mrow>
  <mi><xsl:text disable-output-escaping="yes">&sigma;</xsl:text></mi>
  <msup> 
    <mfenced>
      <xsl:apply-templates select="*[position()!=1]"/>
    </mfenced>
    <mn>2</mn>
  </msup>
</mrow>
</xsl:template>

<!-- median -->
<!-- not sure we handle the n-ary thing correctly as far as display is concerned-->
<xsl:template match="m:apply[child::*[position()=1 and local-name()='median']]">
<mrow>
  <mi>median</mi>
  <mfenced>
    <xsl:apply-templates select="*[position()!=1]"/>
  </mfenced>
</mrow>
</xsl:template>

<!-- statistical mode -->
<!-- not sure we handle the n-ary thing correctly as far as display is concerned-->
<xsl:template match="m:apply[child::*[position()=1 and local-name()='mode']]">
<mrow>
  <mi>mode</mi>
  <mfenced>
    <xsl:apply-templates select="*[position()!=1]"/>
  </mfenced>
</mrow>
</xsl:template>

<!-- statistical moment -->
<!-- not sure we handle the n-ary thing correctly as far as display is concerned-->
<xsl:template match="m:apply[child::*[position()=1 and local-name()='moment']]">
<mrow>
  <mo><xsl:text disable-output-escaping="yes">&lang;</xsl:text></mo>
  <xsl:for-each select="*[position()!=1 and position()!=2 and position()!=last() and local-name()!='momentabout']">
    <msup>
      <xsl:apply-templates select="."/>
      <xsl:apply-templates select="../m:degree"/>
    </msup><mo>,</mo>
  </xsl:for-each>
  <msup>
    <xsl:apply-templates select="*[position()=last()]"/>
    <xsl:apply-templates select="m:degree"/>
  </msup>
  <mo><xsl:text disable-output-escaping="yes">&rang;</xsl:text></mo>
</mrow> 
</xsl:template>

<!-- point of moment (according to the spec it is not rendered)-->
<xsl:template match="m:momentabout">
</xsl:template>

<!-- #################### 4.4.10 #################### -->

<!-- vector -->
  <xsl:template match="m:vector">
    <!-- the default display for a vector is vertically -->
    <mrow>
      <mfenced open="(" close=")">
      <mtable>
	<xsl:for-each select="*">
	  <mtr>
	    <mtd>
	      <xsl:apply-templates select="."/>
	    </mtd>
	  </mtr>
	</xsl:for-each>
      </mtable>
      </mfenced>
    </mrow>
    </xsl:template>
<!-- when vectors are displayed as block they are displayed vertically -->
  
  <xsl:template match="m:math[@display='block']//m:vector">
    <mrow>
      <mfenced open="(" close=")">
      <mtable>
	<xsl:for-each select="*">
	  <mtr>
	    <mtd>
	      <xsl:apply-templates select="."/>
	    </mtd>
	  </mtr>
	</xsl:for-each>
      </mtable>
      </mfenced>
    </mrow>
  </xsl:template>
 <!-- when vectors are to be displayed inline they are displayed
  horizontally with a superscript T for transpose -->
  <xsl:template match="m:math[@display='inline']//m:vector">
    <msup>
      <mfenced>
	<xsl:apply-templates select="*"/>
      </mfenced>
      <mi>T</mi>
    </msup>
  </xsl:template>

<!-- matrix -->
<xsl:template match="m:matrix">
    <mrow>
      <mfenced>
	<mtable>
	  <xsl:apply-templates select="child::*"/>
	</mtable>
      </mfenced>
    </mrow>
</xsl:template>

<xsl:template match="m:matrixrow">
  <mtr>
    <xsl:for-each select="child::*">
      <mtd>
	  <mpadded width="+0.3em" lspace="+0.3em">
	  <xsl:apply-templates select="."/>
	  </mpadded>
	</mtd>
    </xsl:for-each>
  </mtr>
</xsl:template>

<!-- determinant -->
<xsl:template match="m:apply[child::*[position()=1 and local-name()='determinant']]">
  <mrow>
    <mo>det</mo>
    <xsl:choose>
    <xsl:when test="m:apply">
      <mfenced separators=""><xsl:apply-templates select="*[position()=2]"/></mfenced>
    </xsl:when>
    <xsl:otherwise>
      <xsl:apply-templates select="*[position()=2]"/>
    </xsl:otherwise>
    </xsl:choose>
  </mrow>
</xsl:template>

<!-- transpose -->
<xsl:template match="m:apply[child::*[position()=1 and local-name()='transpose']]">
  <msup>
    <xsl:choose>
    <xsl:when test="m:apply">
      <mfenced separators=""><xsl:apply-templates select="*[position()=2]"/></mfenced>
    </xsl:when>
    <xsl:otherwise>
      <xsl:apply-templates select="*[position()=2]"/>
    </xsl:otherwise>
    </xsl:choose>
    <mo>T</mo>
  </msup>
</xsl:template>

<!-- selector-->
<xsl:template match="m:apply[child::*[position()=1 and local-name()='selector']]">
  <mrow>
  <xsl:choose>
  <xsl:when test="local-name(*[position()=2])='m:matrix'"> <!-- select in a matrix defined inside the selector -->
    <xsl:choose>
    <xsl:when test="count(*)=4"> <!-- matrix element-->
      <xsl:variable name="i"><xsl:value-of select="*[position()=3]"/></xsl:variable>  <!--extract row-->
      <xsl:variable name="j"><xsl:value-of select="*[position()=4]"/></xsl:variable>  <!--extract column-->
      <xsl:apply-templates select="*[position()=2]/*[position()=number($i)]/*[position()=number($j)]"/>
    </xsl:when>
    <xsl:when test="count(*)=3">  <!-- matrix row -->
      <xsl:variable name="i"><xsl:value-of select="*[position()=3]"/></xsl:variable>  <!--extract row, put it in a matrix container of its own-->
      <mtable><xsl:apply-templates select="*[position()=2]/*[position()=number($i)]"/></mtable>
    </xsl:when>
    <xsl:otherwise> <!-- no index select the entire thing-->
      <xsl:apply-templates select="*[position()=2]"/>
    </xsl:otherwise>
    </xsl:choose>
  </xsl:when>
  <xsl:when test="local-name(*[position()=2])='vector' or local-name(*[position()=2])='list'"> <!-- select in a vector or list defined inside the selector -->
    <xsl:choose>
    <xsl:when test="count(*)=3">  <!-- list/vector element -->
      <xsl:variable name="i"><xsl:value-of select="*[position()=3]"/></xsl:variable>  <!--extract index-->
      <xsl:apply-templates select="*[position()=2]/*[position()=number($i)]"/>
    </xsl:when>
    <xsl:otherwise> <!-- no index select the entire thing-->
      <xsl:apply-templates select="*[position()=2]"/>
    </xsl:otherwise>
    </xsl:choose>
  </xsl:when>
  <xsl:otherwise> <!-- select in something defined elsewhere : an identifier is provided-->
    <xsl:choose>
    <xsl:when test="count(*)=4"> <!-- two indices (matrix element)-->
      <msub>
        <xsl:apply-templates select="*[position()=2]"/>
	<mrow>
	  <xsl:apply-templates select="*[position()=3]"/>
	  <mo><xsl:text disable-output-escaping="yes">&InvisibleComma;</xsl:text></mo>  <!-- InvisibleComma does not work -->
	  <xsl:apply-templates select="*[position()=4]"/>
	</mrow>
      </msub>
    </xsl:when>
    <xsl:when test="count(*)=3">  <!-- one index probably list or vector element, or matrix row -->
      <msub>
        <xsl:apply-templates select="*[position()=2]"/>
	<xsl:apply-templates select="*[position()=3]"/>
      </msub>
    </xsl:when>
    <xsl:otherwise> <!-- no index select the entire thing-->
      <xsl:apply-templates select="*[position()=2]"/>
    </xsl:otherwise>
    </xsl:choose>
  </xsl:otherwise>
  </xsl:choose>
  </mrow>
</xsl:template>

<!-- vector product = A x B x sin(teta) -->
<xsl:template match="m:apply[child::*[position()=1 and local-name()='vectorproduct']]">
<mrow>
  <xsl:apply-templates select="*[position()=2]"/>
  <mo><xsl:text disable-output-escaping="yes">&times;</xsl:text></mo>
  <xsl:apply-templates select="*[position()=3]"/>
</mrow>
</xsl:template>

<!-- scalar product = A x B x cos(teta) -->
<xsl:template match="m:apply[child::*[position()=1 and local-name()='scalarproduct']]">
<mrow>
      <mo>&lt;</mo>
	<xsl:apply-templates select="*[position()=2]"/>
      <mo>,</mo>
	<xsl:apply-templates select="*[position()=3]"/>
      <mo>&gt;</mo>
</mrow>
</xsl:template>

<!-- outer product = A x B x cos(teta) -->
<xsl:template match="m:apply[child::*[position()=1 and local-name()='outerproduct']]">
<mrow>
  <xsl:apply-templates select="*[position()=2]"/>
  <mo>.</mo>
  <xsl:apply-templates select="*[position()=3]"/>
</mrow>
</xsl:template>

<!-- #################### 4.4.11 #################### -->

<!-- annotation-->
<xsl:template match="m:annotation">
<!-- no rendering for annotations-->
</xsl:template>

<!-- semantics-->
<xsl:template match="m:semantics">
<mrow>
  <xsl:choose>
    <xsl:when test="contains(m:annotation-xml/@encoding,'MathML-Presentation')"> <!-- if specific representation is provided use it-->
      <xsl:apply-templates select="annotation-xml[contains(@encoding,'MathML-Presentation')]"/>
    </xsl:when>
    <xsl:otherwise>
      <xsl:apply-templates select="*[position()=1]"/>  <!--if no specific representation is provided use the default one-->
    </xsl:otherwise>
  </xsl:choose>
</mrow>
</xsl:template>

<!-- MathML presentation in annotation-xml-->
<xsl:template match="m:annotation-xml[contains(@encoding,'MathML-Presentation')]">
<mrow>
  <xsl:copy-of select="*"/>
</mrow>
</xsl:template>

<!-- #################### 4.4.12 #################### -->
<!-- integer numbers -->
<xsl:template match="m:integers">
  <mi><xsl:text disable-output-escaping='yes'>&amp;#x2124;</xsl:text></mi>  <!-- open face Z --> <!-- UNICODE char works -->
</xsl:template>

<!-- real numbers -->
<xsl:template match="m:reals">
  <mi><xsl:text
  disable-output-escaping='yes'>&amp;#x211D;</xsl:text></mi>  <!-- open face R --> <!-- UNICODE char works -->
</xsl:template>

<!-- rational numbers -->
<xsl:template match="m:rationals">
  <mi><xsl:text disable-output-escaping='yes'>&amp;#x211A;</xsl:text></mi>  <!-- open face Q --> <!-- UNICODE char works -->
</xsl:template>

<!-- natural numbers -->
<xsl:template match="m:naturalnumbers">
  <mi><xsl:text disable-output-escaping='yes'>&amp;#x2115;</xsl:text></mi>  <!-- open face N --> <!-- UNICODE char works -->
</xsl:template>

<!-- complex numbers -->
<xsl:template match="m:complexes">
  <mi><xsl:text disable-output-escaping='yes'>&amp;#x2102;</xsl:text></mi>  <!-- open face C --> <!-- UNICODE char works -->
</xsl:template>

<!-- prime numbers -->
<xsl:template match="m:primes">
  <mi><xsl:text disable-output-escaping='yes'>&amp;#x2119;</xsl:text></mi>  <!-- open face P --> <!-- UNICODE char works -->
</xsl:template>

<!-- exponential base -->
<xsl:template match="m:exponentiale">
  <mi><xsl:text disable-output-escaping="yes">&ee;</xsl:text></mi>  <!-- ExponentialE does not work yet -->
</xsl:template>

<!-- square root of -1 -->
<xsl:template match="m:imaginaryi">
  <mi><xsl:text disable-output-escaping="yes">&ImaginaryI;</xsl:text></mi>  <!-- or perhaps ii -->
</xsl:template>

<!-- result of an ill-defined floating point operation -->
<xsl:template match="m:notanumber">
  <mi>NaN</mi>  
</xsl:template>

<!-- logical constant for truth -->
<xsl:template match="m:true">
  <mi>true</mi>  
</xsl:template>

<!-- logical constant for falsehood -->
<xsl:template match="m:false">
  <mi>false</mi>   
</xsl:template>

<!-- empty set -->
<xsl:template match="m:emptyset">
  <mi><xsl:text disable-output-escaping="yes">&empty;</xsl:text></mi>
</xsl:template>

<!-- ratio of a circle's circumference to its diameter -->
<xsl:template match="m:pi">
  <mi><xsl:text disable-output-escaping="yes">&pi;</xsl:text></mi>
</xsl:template>

<!-- Euler's constant -->
<xsl:template match="m:eulergamma">
  <mi><xsl:text disable-output-escaping="yes">&gamma;</xsl:text></mi>
</xsl:template>

<!-- Infinity -->
<xsl:template match="m:infinity">
  <mi><xsl:text disable-output-escaping="yes">&infin;</xsl:text></mi>
</xsl:template>
</xsl:stylesheet>