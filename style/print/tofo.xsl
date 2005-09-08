<?xml version="1.0" encoding="utf-8"?>

  <xsl:stylesheet version="1.0"
		  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		  xmlns:fo="http://www.w3.org/1999/XSL/Format"
		  xmlns:ind="index">

    
  <xsl:key name='id' match='*' use='@id'/>


  <!-- These stylesheets create the index and the authorlist -->
  <xsl:include href="indexfo.xsl" />  

  
  <!--ROOT-->
  <xsl:template match="/">
    <fo:root>
      <fo:layout-master-set>
	
	<!-- A Cover Page -->
	<fo:simple-page-master master-name="cover"
			       page-height="11in"
			       page-width="8.5in"
			       margin-top="4in"
			       padding-before="3in"
			       margin-bottom="1in">
			    <!--   margin-left="1in"
			       margin-right="1in"-->
	  <fo:region-body/>
	</fo:simple-page-master>
	
	<!-- First Page of the Chapter -->
	<fo:simple-page-master master-name="ChapterPage"
	  page-height="11in"
	  page-width="8.5in"
	  margin-left="1in"
	  margin-right="1in"
	  margin-top="1in"
	  margin-bottom="1in">
	  <fo:region-before region-name="xsl-region-before" extent=".5in"/>
	  <fo:region-body/>
	  <fo:region-after region-name="xsl-region-after-chapter" extent=".5in"/>
	</fo:simple-page-master>

	<!-- Even numbered pages -->
	<fo:simple-page-master master-name="leftPage"
				 page-height="11in"
				 page-width="8.5in"
				 margin-left="1in"
				 margin-right="1.25in"
				 margin-top="1in"
				 margin-bottom="1in">
	  <fo:region-before region-name="xsl-region-before-left" extent=".5in"/>
	  <fo:region-body/>
	  <fo:region-after  extent=".5in"/>
	</fo:simple-page-master>
	
	<!-- Odd numbered pages -->
	<fo:simple-page-master master-name="rightPage"
	  page-height="11in"
	  page-width="8.5in"
	  margin-left="1.25in"
	  margin-right="1in"
	  margin-top="1in"
	  margin-bottom="1in">
	  <fo:region-before region-name="xsl-region-before-right" extent=".5in"/>
	  <fo:region-body/>
	  <fo:region-after extent=".5in"/>
	</fo:simple-page-master>
	
	<!-- Blank Page-Goes at the end of chapters to make chapters
	start on the right. -->
	<fo:simple-page-master master-name="Blank"
				 page-height="11in"
				 page-width="8.5in"
				 margin-left="1in"
				 margin-right="1in"
				 margin-top="1in"
				 margin-bottom="1in">
	  <fo:region-body/>
	</fo:simple-page-master>
	
	


	<!-- Page order of the TABLE OF CONTENTS  -->
	<fo:page-sequence-master master-name="TOC">
	  <fo:repeatable-page-master-alternatives>
	    <!--The Blank page at the end of a chapter if it ends on
	    an even numbered page.-->
	    <fo:conditional-page-master-reference 
	      blank-or-not-blank="Blank"
	      odd-or-even="even"/>
	    <!--The first page of a chapter-->
	    <fo:conditional-page-master-reference
	      master-name="ChapterPage"
	      page-position="first"/>
	    <!--Even numbered pages-->
	    <fo:conditional-page-master-reference
	      master-name="leftPage"
	      odd-or-even="even"/>
	    <!--Odd numbered pages-->
	    <fo:conditional-page-master-reference
	      master-name="rightPage"
	      odd-or-even="odd"/>
	  </fo:repeatable-page-master-alternatives>
	</fo:page-sequence-master>
	
	


	<!-- Page order of a BASIC PAGE -->
	<fo:page-sequence-master master-name="contents">
	  <fo:repeatable-page-master-alternatives>
	    <!--The Blank page at the end of a chapter if it ends on
	    an even numbered page.-->
	    <fo:conditional-page-master-reference master-name="Blank"
	      blank-or-not-blank="blank"
	      odd-or-even="even"/>
	    <!--The first page of a chapter-->
	    <fo:conditional-page-master-reference
	      master-name="ChapterPage"
	      page-position="first"/>
	    <!--Even numbered pages-->
	    <fo:conditional-page-master-reference
	      master-name="leftPage"
	      odd-or-even="even"/>
	    <!--Odd numbered pages-->
	    <fo:conditional-page-master-reference
	      master-name="rightPage"
	      odd-or-even="odd"/>
	</fo:repeatable-page-master-alternatives>
      </fo:page-sequence-master>
      
      </fo:layout-master-set>
 


      

      <!-- COVER PAGE-->
      <fo:page-sequence master-name="cover" 
			force-page-count="end-on-even">
	<fo:flow flow-name="xsl-region-body">
	  
	  <fo:leader leader-pattern="rule"
	    leader-length.minimum="8.5in"
	    leader-length.optimum="8.5in"
	    leader-length.maximum="8.5in"
	    rule-style="solid"/>	    
	  
	  <fo:block text-align="center"
		    font-size="36pt">
	    <!--Title of the Course-->  
	    <xsl:value-of select="course/name"/>
	  </fo:block>
	  
	  <fo:leader leader-pattern="rule"
	    leader-length.minimum="8.5in"
	    leader-length.optimum="8.5in"
	    leader-length.maximum="8.5in"
	    rule-style="solid"/>
	  
	  <!--Teachers Name-->
	  <fo:block font-size="16pt" text-align="center">
	    <xsl:for-each select="course/author">
	      <fo:block>
		<xsl:value-of select="."/>
	      </fo:block>
	    </xsl:for-each>
	  </fo:block>

	  <fo:block font-weight="bold" 
		    space-before="3.5in" 
		    text-align="center" 
		    font-size="14pt">
	    NONRETURNABLE
	  </fo:block>
	  <fo:block font-weight="bold" 
		    text-align="center" 
		    font-size="12pt">
	    NO REFUNDS, EXCHANGES, OR CREDIT ON ANY COURSE PACKETS
	  </fo:block>
	  
	</fo:flow>
      </fo:page-sequence>


      <!--Inside COVER-->
      <fo:page-sequence master-name="contents" initial-page-number="1">
	<fo:flow flow-name="xsl-region-body">

	  <!--Course Name-->
	  <fo:block font-size="24pt"
		    text-align="begin"
		    padding-before="1in"
		    font-weight="bold">    
	    <xsl:value-of select="course/name"/>
	  </fo:block>
	  <!--Author Information-->
	  <fo:block font-size="12pt"
		    text-align="begin"
		    margin="1.5cm">

	    <!--Course Authors-->
	    <fo:block font-weight="bold"
		      space-before="1cm">Course Authors:</fo:block>
	    <xsl:for-each select="course/author">			  
	      <fo:block>
		<xsl:value-of select="."/>
	      </fo:block>
	    </xsl:for-each>

	    <!--Module Authors-->
	    <fo:block font-weight="bold"
		      space-before="1cm">Contributing Authors:</fo:block>
	  
	    <!--Second Step in creating the authorlist.  Sort by surname.-->
	    <fo:block text-align="begin">
	      <xsl:for-each select="//ind:authorlist/ind:item">
		<fo:block id="@id"><xsl:value-of select="firstname"/><xsl:text> </xsl:text><xsl:value-of select="surname"/>
		</fo:block>
	      </xsl:for-each>
	    </fo:block>

	  </fo:block>
	</fo:flow>
      </fo:page-sequence>
      

      <!--COPYRIGHT PAGE-->
      <fo:page-sequence master-name="contents">
	<fo:flow>
	  <fo:block space-before="1in">
	    This course was created using:
	  </fo:block>
	  <fo:block font-size="20pt" space-before="1cm">
	    The Connexions Project
	  </fo:block>
	  <fo:block font-size="13pt" space-before=".5pt">
	    Rice University
	  </fo:block>
	  <fo:block>
	    Houston, Texas
	  </fo:block>
	  <fo:block>
	    http://cnx.rice.edu
	  </fo:block>
	  <fo:block space-before="3in">
	    Please report Comments, Suggestions, Bugs to
	    http://www.cnx.rice.edu/forms/bugReport.cfm
	  </fo:block>
	  <fo:block space-before="3in">
	    Copyright &#xA9; 2001 Rice University
	  </fo:block>

	</fo:flow>
      </fo:page-sequence>

      
      <!--CONTRIBUTING AUTHORS PAGE-->
      <fo:page-sequence master-name="contents"
	force-page-count="end-on-even">
	<fo:flow>
	 
	</fo:flow>
      </fo:page-sequence>
      
      
      <!-- TABLE OF CONTENTS PAGE -->      
      <fo:page-sequence master-name="contents" force-page-count="end-on-even">
	
	<!--EVEN numbered page-->
	<fo:static-content flow-name="xsl-region-before-right">
	  <fo:marker id="printstyletoc">
	    Table of Contents
	  </fo:marker>
	  <fo:block text-align="center">
	    <!--Print the Table of Contents on the right page-->	    
	    Table of Contents
	  </fo:block>
	  <fo:block font-size="12pt" text-align="end">
	    <fo:page-number/>
	  </fo:block>
	</fo:static-content>

	<!--ODD numbered page-->
	<fo:static-content flow-name="xsl-region-before-left">
	  <fo:block font-size="12pt" text-align="start">
	    <fo:page-number/>
	  </fo:block>
	  <fo:block text-align="center">
	    <!--Print Book name on the left header-->
	    <xsl:value-of select="course/name"/>
	  </fo:block>
	</fo:static-content>

	<!--FIRST PAGE OF THE CHAPTER-->
	<fo:static-content  flow-name="xsl-region-after-chapter"> 
	  <fo:block font-size="12pt" text-align="center"  margin-top=".4in">
	    <fo:page-number/>
	  </fo:block>
	</fo:static-content>
	

	<!--BODY of the text-->
	<fo:flow flow-name="xsl-region-body">
	  <fo:block  text-align="end"
	    font-size="24pt"
	    font-weight="bold"
	    space-before=".5in"
	    space-after="2in">
	    Table of Contents
	  </fo:block>
	
	  <!--Applies the templates of mode='toc'.  Those templates
	  created the Table of Contents-->
	 
	  <xsl:for-each select="course/group">
	    <fo:list-block>
	      <xsl:apply-templates select="." mode="toc"/>
	    </fo:list-block>
	  </xsl:for-each>
	  
	</fo:flow>
      </fo:page-sequence>
      
      
      <!--INNER COVER PAGE-->
      <fo:page-sequence master-name="cover" initial-page-number="1" force-page-count="end-on-even">
	<fo:flow flow-name="xsl-region-body">
	  <fo:leader leader-pattern="rule"
	    leader-length.minimum="8.5in"
	    leader-length.optimum="8.5in"
	    leader-length.maximum="8.5in"
	    rule-style="solid"/>
	  
	  <fo:block text-align="center"
	    font-size="36pt">
	    <!--Course Name-->
	    <xsl:value-of select="course/name"/>
	  </fo:block>
	  
	  <fo:leader leader-pattern="rule"
	    leader-length.minimum="8.5in"
	    leader-length.optimum="8.5in"
	    leader-length.maximum="8.5in"
	    rule-style="solid"/>
	</fo:flow>
      </fo:page-sequence>
      

      <!-- CONTENT OF THE BOOK -->
      <xsl:for-each select="course/group">     
	<fo:page-sequence master-name="contents"
	  force-page-count="end-on-even">

	  <!--EVEN numbered page-->
	  <fo:static-content flow-name="xsl-region-before-right">
	    <fo:block text-align="center">
	      <!--Print the chapter name on the right page-->	      
	      <fo:retrieve-marker retrieve-class-name="{@id}"
				  retrieve-position="first-including-carryover"/>
	    </fo:block>
	    <fo:block font-size="12pt" text-align="end">
	      <fo:page-number/>
	    </fo:block>
	  </fo:static-content>
	  
	  <!--ODD numbered page-->
	  <fo:static-content flow-name="xsl-region-before-left">
	    <fo:block font-size="12pt" text-align="start">
	      <fo:page-number/>
	    </fo:block>
	    <fo:block text-align="center">
	      <!--Print Book name on the left header-->
	      <xsl:value-of select="course/name"/>
	    </fo:block>
	  </fo:static-content>

	  <!--FIRST PAGE OF THE CHAPTER-->
	  <fo:static-content  flow-name="xsl-region-after-chapter"> 
	    <fo:block font-size="12pt" text-align="center" margin-top=".4in">
	      <fo:page-number/>
	    </fo:block>
	  </fo:static-content>


	  <!--BODY-->
	  <fo:flow flow-name="xsl-region-body">
	    <!--Name of the group or module-->
	    <xsl:apply-templates select="name"/>
	    
	    <!--Add the text of the body here-->
	    <!--There are templates that cause the body of the text to
	    be applied in the appropriate ways.  They are all of mode='body'.-->
	    <xsl:apply-templates select="." mode="body"/>
	    
	  </fo:flow>
	  
	</fo:page-sequence>
      </xsl:for-each>
      

      <!--INDEX-->
      <fo:page-sequence master-name="contents"
	force-page-count="end-on-even">
	<fo:flow flow-name="xsl-region-body">
	  <fo:marker id="printstyleindex">
	    Index of Keywords and Terms
	  </fo:marker>
	  <fo:block space-after=".3in">
	    <fo:block text-align="begin"
	      font-size="18pt"
	      font-weight="bold"
	      space-after=".2in">
	      Index of Keywords and Terms
	    </fo:block>
	    <fo:block>
	      <fo:inline font-weight="bold">Keywords</fo:inline>
	      are listed by the section with that keyword 
	      (page numbers are in parentheses). Keywords do not necessarily
	      appear in the text of the page.  They are merely
	      associated with that section. <fo:inline
	      font-style="italic">Ex.</fo:inline> <fo:inline font-weight="bold"> term</fo:inline> Sec. 1.1 (1)
	    </fo:block>
	    <fo:block>
	      <fo:inline font-weight="bold">Terms</fo:inline> are
	      referenced by the page they appear on.  <fo:inline
	      font-style="italic">Ex.</fo:inline><fo:inline font-weight="bold"> term</fo:inline> 1
	    </fo:block>
	  </fo:block>
	  <fo:block>
	    <xsl:apply-templates select="//ind:indexlist"/>
	  </fo:block>
	</fo:flow>
	
      </fo:page-sequence>
      
      
    </fo:root>
  </xsl:template>
  

  <!--TABLE OF CONTENTS templates-->
  
  <!--MODULEs in the Table of Contents-->
  <xsl:template match="module" mode="toc">
    <fo:list-item>

      <fo:list-item-label>
	<!--The number of the module-->
	<xsl:value-of select="@number"/>
      </fo:list-item-label>

      <fo:list-item-body>
	<fo:block>
	  <!--name-->
	  <xsl:value-of select="name"/>
	  <fo:leader leader-pattern="dots"
	    leader-length.minimum="1cm"
	    leader-length.optimum="8.5in"
	    leader-length.maximum="8.5in"/>
	  <!--Page number that the module starts on.-->
	  <fo:page-number-citation ref-id="{@id}"/>
	</fo:block>

      </fo:list-item-body>
    </fo:list-item>
  </xsl:template>
  
  <!--GROUPS in the Table of Contents-->
  <xsl:template match="group" mode="toc">

    <fo:list-item>

      <fo:list-item-label>
	<!--The number of the group-->
	<xsl:value-of select="@number"/>
      </fo:list-item-label>

      <fo:list-item-body>
	<fo:block>
	  <!--name-->
	  <xsl:value-of select="name"/>
	  <!--the page number is not printed for groups-->
	  <!--  <fo:leader leader-pattern="dots"
	  leader-length.minimum="3in"
	  leader-length.optimum="8.5in"
	  leader-length.maximum="8.5in"/>-->
	  <!--  <fo:page-number-citation ref-id="{@ID}"/>-->
	  <fo:list-block>
	    <!--Continue the recursion-->
	    <xsl:apply-templates select="group|module" mode="toc"/>
	  </fo:list-block>
	</fo:block>
      </fo:list-item-body>

    </fo:list-item>
  </xsl:template>

  <!--BODY OF THE TEXT templates-->
  <!--MODULES in the body of the text -->
  <xsl:template match="module" mode="body" name='module'>
    <fo:block text-align="begin"
      font-size="20pt"
      font-weight="bold"
      id="{@id}">
    </fo:block>
    
    <!--Print the module-->
    <xsl:apply-templates />
  </xsl:template>
  
  <!--GROUPS in the body of the text-->
  <xsl:template match="group" mode="body">

    <fo:block id="{@id}">
      
      <!--Print the name of the group-->
      <xsl:apply-templates select="name" mode='body'/>

      <!--Continue the recursion-->
      <xsl:apply-templates select="group|module" mode="body"/>

    </fo:block>
  </xsl:template>
  

  <!--NAME-->
  <xsl:template match="name" mode='body'>
    <fo:block text-align="begin"
      font-size="20pt"
      font-weight="bold">
      <xsl:value-of select="../@number"/><xsl:text> </xsl:text>
      <xsl:apply-templates/>
    </fo:block>
  </xsl:template>
  
  <!--NAMEs of top level groups and modules-->
  <!--These shouldn't be printed because they are already printed-->
  <xsl:template match="/course/group/name" mode='body' />
  
  <!--TOP LEVEL NAMEs of groups -->
  <xsl:template match="group/name">
    <fo:block text-align="end"
      font-size="24pt"
      font-weight="bold"
      space-before=".5in"
      space-after="2in">
      <fo:marker marker-class-name="{../@id}">
	<xsl:value-of select="."/>
      </fo:marker>
      <!--Big Number-->
      <fo:block font-size="56pt">
	<xsl:value-of select="../@number"/>
      </fo:block>
      <!--Big Name-->
      <fo:block>
	<xsl:apply-templates/>
      </fo:block>
    </fo:block>
  </xsl:template>
  
  <!-- Suppress metadata output -->
  <xsl:template match="author|keyword" />
  
  <!--The innards of the modules.-->
  <xsl:include href="mathml.xsl"/>
  <xsl:include href="module.xsl"/>
  
  <!--Override the module name from module.xsl.  Add a marker so that
  it can get printed on the odd numbered pages.
  <xsl:template match="module/name">
    <fo:marker marker-class-name="{../../../@about}">
      <xsl:value-of select="."/>
    </fo:marker>
  </xsl:template>-->
  
  
</xsl:stylesheet>
