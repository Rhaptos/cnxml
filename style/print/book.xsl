<?xml version="1.0" encoding="utf-8"?>

  <xsl:stylesheet version="1.0"
		  xmlns:m="http://www.w3.org/1998/Math/MathML"
		  xmlns:cnx="http://cnx.rice.edu/cnxml/0.2"
		  xmlns:cnxml="http://cnx.rice.edu/cnxml/0.3"
		  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		  xmlns:fo="http://www.w3.org/1999/XSL/Format"
		  xmlns:fotex="http://www.tug.org/fotex">
    <!-- Use identity transform as a last resort -->
    <xsl:import href="/home/coppin/nextrelease/stylesheets/ident.xsl"/>
    
    <!-- Use math for only math tags -->
    <xsl:import href="/home/coppin/nextrelease/stylesheets/mathmlc2p.xsl"/>
    
<xsl:import href="/home/coppin/nextrelease/stylesheets/print/module.xsl"/>
  
    <xsl:template match="/">
      <fo:root>
      <fo:layout-master-set>
	<!-- A Cover Page -->
	<fo:simple-page-master master-name="cover"
			       page-height="11in"
			       page-width="8.5in"
			       margin-top="1in"
				 margin-bottom="1in"
			       margin-left="1in"
			       margin-right="1in">
	  <fo:region-body/>
	</fo:simple-page-master>

<!-- Chapter starter pages -->
	  <fo:simple-page-master master-name="ChapterPage"
				 page-height="11in"
				 page-width="8.5in"
				 margin-left="1in"
				 margin-right="1in"
				 margin-top="1in"
				 margin-bottom="1in">
	  <fo:region-body/>
	  <fo:region-after extent=".5in"/>
	</fo:simple-page-master>

<!-- Even numbered pages -->
	  <fo:simple-page-master master-name="leftPage"
				 page-height="11in"
				 page-width="8.5in"
				 margin-left="1in"
				 margin-right="1in"
				 margin-top="1in"
				 margin-bottom="1in">
	  <fo:region-before extent=".5in"/>
	  <fo:region-body/>
	  <fo:region-after extent=".5in"/>
	  </fo:simple-page-master>
	  
<!-- Odd numbered pages -->
	  <fo:simple-page-master master-name="rightPage"
				 page-height="11in"
				 page-width="8.5in"
				 margin-left="1in"
				 margin-right="1in"
				 margin-top="1in"
				 margin-bottom="1in">
	  <fo:region-before extent=".5in"/>
	  <fo:region-body/>
	  <fo:region-after extent=".5in"/>
	</fo:simple-page-master>


	


<!-- Page order of the table of contents  -->
	<fo:page-sequence-master master-name="TOC">
	  <fo:repeatable-page-master-alternatives>
	    <fo:conditional-page-master-reference
						 
						  blank-or-not-blank="blank"
						  odd-or-even="even"/>
	    <fo:conditional-page-master-reference
						  master-name="ChapterPage"
						  page-position="first"/>
	  <fo:conditional-page-master-reference
						master-name="leftPage"
						odd-or-even="even"/>
	  <fo:conditional-page-master-reference
						master-name="rightPage"
						odd-or-even="odd"/>
	    
	</fo:repeatable-page-master-alternatives>
      </fo:page-sequence-master>
      



<!-- Page order of a basic page -->
      <fo:page-sequence-master master-name="contents">
<!--	  <fo:single-page-master-reference>
	    <fo:conditional-page-master-reference
						  master-name="ChapterPage"/>
	  </fo:single-page-master-reference>-->
	  <fo:repeatable-page-master-alternatives>
	    <fo:conditional-page-master-reference
						 
						  blank-or-not-blank="blank"
						  odd-or-even="even"/>
	    <fo:conditional-page-master-reference
						  master-name="ChapterPage"
						  page-position="first"/>
	  <fo:conditional-page-master-reference
						master-name="leftPage"
						odd-or-even="even"/>
	  <fo:conditional-page-master-reference
						master-name="rightPage"
						odd-or-even="odd"/>
	    
	</fo:repeatable-page-master-alternatives>
      </fo:page-sequence-master>
      
      </fo:layout-master-set>
 
	<fo:page-sequence master-name="cover">
	  <fo:flow flow-name="xsl-region-body">
	    <fo:block font-family="Helvetica" font-size="18pt"
		      text-align="end"> 
	    <xsl:for-each select="cnx:course">
	      <xsl:value-of select="@name"/>
	    </xsl:for-each>
	    </fo:block>
	    <fo:block font-family="Helvetica" font-size="12pt"
		      text-align="end" space-after="36pt">
	      Copyright &#169; 2001 Connexions Project
	    </fo:block>
	    <fo:block text-align="end">
	      The Connexions Project (Rice University)
	    </fo:block>
	  </fo:flow>
	</fo:page-sequence> 

<!-- Table of Contents page order -->      
      <fo:page-sequence master-name="TOC">
	<fo:static-content flow-name="xsl-region-before">
	  <fo:block text-align="center">
	    TABLE OF CONTENTS 
	  </fo:block>
	  <fo:block text-align="end">
	    <fo:page-number/>
	  </fo:block>
	</fo:static-content>
	<fo:flow flow-name="xsl-region-body">
	


	  <fo:block text-align="begin"
		    font-size="18pt"
		    font-weight="bold"
		    space-after=".5in">
	    Table of Contents with appendices
	  </fo:block>
	<!--Chapters-->  
	  <xsl:for-each select="cnx:course/cnx:mainpath/cnx:chapter">
	    <fo:list-block>
	      <fo:list-item>
		<fo:list-item-label>
		  <xsl:number count="cnx:chapter"/>
		</fo:list-item-label>
		<fo:list-item-body>
		  <xsl:value-of select="cnx:name"/>
		  <fo:list-block>
		    <xsl:for-each select="cnx:module">
		    <fo:list-item>
		      <fo:list-item-label>
			<xsl:number count="cnx:chapter|cnx:module"
			level='multiple' format='1.1'/>
		      </fo:list-item-label>
		    <fo:list-item-body>
			<xsl:for-each select="document(concat('http://cnx.rice.edu/cgi-bin/showmodule.cgi?id=',@cnxid, '/index.cnxml'))">
			  <xsl:value-of
			  select="cnxml:module/cnxml:name"/>
			    <fo:page-number-citation refid="../../{@id}"/>
			  <!--<xsl:apply-templates select="cnxml:module"/>-->
			  <xsl:text>
			  </xsl:text>
			</xsl:for-each>
		      </fo:list-item-body>
		    </fo:list-item>
		  </xsl:for-each>
		  </fo:list-block>
		</fo:list-item-body>
	      </fo:list-item>
	    </fo:list-block>
	  </xsl:for-each>
	  <!--Appendices-->
	  <xsl:for-each select="/cnx:course/cnx:appendix">

	    <fo:list-block>
	
      <fo:list-item>
		<fo:list-item-label>
		  A.<xsl:number count="cnx:appendix" format="1"/>
		</fo:list-item-label>
		<fo:list-item-body>
		  <xsl:value-of select="cnx:name"/>
		  <fo:list-block>
		    <xsl:for-each select="cnx:module">
		    <fo:list-item>
		      <fo:list-item-label>
			A.<xsl:number count="cnx:appendix|cnx:module"
			level='multiple' format='1.1'/>
		      </fo:list-item-label>
		    <fo:list-item-body>
			<xsl:for-each select="document(concat('http://cnx.rice.edu/cgi-bin/showmodule.cgi?id=',@cnxid, '/index.cnxml'))">
			  <xsl:value-of
			  select="cnxml:module/cnxml:name"/>
			    <fo:page-number-citation refid="../../{@id}"/>
			  <!--<xsl:apply-templates select="cnxml:module"/>-->
			  <xsl:text>
			  </xsl:text>
			</xsl:for-each>
		      </fo:list-item-body>
		    </fo:list-item>
		  </xsl:for-each>
		  </fo:list-block>
		</fo:list-item-body>
	      </fo:list-item>
	    </fo:list-block>
	  </xsl:for-each>
	

	</fo:flow>
     </fo:page-sequence>

<!-- The content of the chapters -->

      <xsl:for-each select="cnx:course/cnx:mainpath/cnx:chapter">     
	<fo:page-sequence master-name="contents">
	  <fo:static-content flow-name="xsl-region-before">
	    <fo:block text-align="center">
	      center TEST
	    </fo:block>
	    <fo:block font-size="12pt" text-align="end">
	      <fo:page-number/>
	    </fo:block>
	  </fo:static-content>
	  <fo:static-content  flow-name="xsl-region-after"> 
	    <fo:block font-size="12pt" text-align="end">
	      end
	    </fo:block>
	  </fo:static-content>
	  <fo:flow flow-name="xsl-region-body">
	    <!--	  <xsl:apply-templates/>-->
	    
	    
	    
	    <xsl:apply-templates select="cnx:name"/>
	    <xsl:for-each select="cnx:module">
	      <xsl:for-each select="document(concat('http://cnx.rice.edu/cgi-bin/showmodule.cgi?id=',@cnxid, '/index.cnxml'))">
		<!--	  <xsl:value-of select="cnxml:module/cnxml:name"/>
	      <xsl:text>
	      </xsl:text>
		-->    <xsl:apply-templates select="cnxml:module"/>
		<xsl:text>
		</xsl:text>
	      </xsl:for-each>
	    </xsl:for-each>
	    
	    
	  </fo:flow>
	  
	</fo:page-sequence>
      </xsl:for-each>

      <xsl:for-each select="cnx:course/cnx:appendix">     
	<fo:page-sequence master-name="contents">
	  <fo:static-content flow-name="xsl-region-before">
	    <fo:block text-align="center">
	      center appendix
	    </fo:block>
	    <fo:block font-size="12pt" text-align="end">
	      <fo:page-number/>
	    </fo:block>
	  </fo:static-content>
	  <fo:static-content  flow-name="xsl-region-after"> 
	    <fo:block font-size="12pt" text-align="end">
	      end
	    </fo:block>
	  </fo:static-content>
	  <fo:flow flow-name="xsl-region-body">
	    <xsl:apply-templates select="cnx:name"/>
	    <xsl:for-each select="cnx:module">
	      <xsl:for-each select="document(concat('http://cnx.rice.edu/cgi-bin/showmodule.cgi?id=',@cnxid, '/index.cnxml'))">
		<!--	  <xsl:value-of select="cnxml:module/cnxml:name"/>
	      <xsl:text>
	      </xsl:text>
		-->    <xsl:apply-templates select="cnxml:module"/>
		<xsl:text>
		</xsl:text>
	      </xsl:for-each>
	    </xsl:for-each>
	  

	</fo:flow>
	
      </fo:page-sequence>
</xsl:for-each>



    </fo:root>
  </xsl:template>





  
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

<xsl:template match="cnx:chapter/cnx:name">
    <fo:block text-align="end"
	      font-size="24pt"
	      font-weight="bold"
	      space-before=".5in"
	      space-after="2in">
      <fo:block font-size="56pt">
      <xsl:number count="cnx:chapter"/>
      </fo:block>
      <fo:block>
      <xsl:apply-templates/>
      </fo:block>
    </fo:block>
</xsl:template>

  <xsl:template match="cnx:appendix/cnx:name">
    <fo:block text-align="end"
	      font-size="24pt"
	      font-weight="bold"
	      space-before=".5in"
	      space-after="2in">
      <fo:block font-size="56pt">
      A.<xsl:number count="cnx:appendix"/>
      </fo:block>
      <fo:block>
      <xsl:apply-templates/>
      </fo:block>
    </fo:block>
</xsl:template>
</xsl:stylesheet>












