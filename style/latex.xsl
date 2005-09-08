<?xml version= "1.0" standalone="no"?>

<xsl:stylesheet version="1.0" 
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:math="http://www.w3.org/1998/Math/MathML"
		xmlns="http://www.w3.org/1999/xhtml">
<xsl:output omit-xml-declaration="yes"/>  
  <!-- Root Node -->
  <xsl:template match="/">
      <xsl:apply-templates/>
  </xsl:template>
  
  <!-- Header and Body for the Module -->
  <xsl:template match="module">
    \chapter{<xsl:value-of select="@name"/>}

      <!--list authors and dates-->
      This document was created by
      <xsl:for-each select="authorlist/author">
	<xsl:if test='not(position()=last())'>
	  <xsl:value-of select="@name"/>,
	</xsl:if>
	<xsl:if test='position()=last()'> and <xsl:value-of select="@name"/>
	</xsl:if>
      </xsl:for-each>
      on
      <xsl:value-of select="@dateofcreation"/>.

      Last revised on <xsl:value-of select="@dateoflastrevision"/>.
      <!--Sarah Coppin on 1/5/01 -->
      <xsl:apply-templates/>
  </xsl:template>


  <!-- Section Header -->
  <xsl:template match="module/section">
    \section{<xsl:value-of select="@name"/>}
    \label{sec:<xsl:value-of select='@id'/>}
    <xsl:apply-templates/>
  </xsl:template>

  <!-- Subsection Header -->
  <xsl:template match="module/section/section">
    \subsection{<xsl:value-of select='@name'/>}
    \label{sec:<xsl:value-of select='@id'/>}
    <xsl:apply-templates/>
  </xsl:template>
  
  <!-- subsubsection header -->
  <xsl:template match="module/section/section/section">
    \subsubsection{<xsl:value-of select="@name"/>}
    \label{sec:<xsl:value-of select='@id'/>}
    <xsl:apply-templates/>
  </xsl:template>
  
  <!--  subsubsubsection header-->
  <xsl:template match="module/section/section/section/section">
    \subsubsubsection{<xsl:value-of select="@name"/>}
    \label{sec:<xsl:value-of select='@id'/>}
    <xsl:apply-templates/>
  </xsl:template>
  
  <!-- Emphasized Text -->
  <xsl:template match="emphasis">
    {\em <xsl:apply-templates/>}
  </xsl:template>
  
  
  <!-- Paragraph. Formatting in CSS under p.para -->
  <xsl:template match="para">
      <xsl:apply-templates/>
  </xsl:template>

  <!-- Default list -->
  <xsl:template match="list">
\begin{itemize}
\setlength{\itemsep}{0pt}
\label{list:<xsl:value-of select='@id'/>}<xsl:for-each select="item">
\item \label{item:<xsl:value-of select='@id'/>} <xsl:apply-templates/></xsl:for-each>
\end{itemize}
  </xsl:template>


  <!-- Numbered lists -->
  <xsl:template match="list[@type='enumerated']">
\begin{enumerate}
\label{list:<xsl:value-of select='@id'/>}<xsl:for-each select="item">
\item \label{item:<xsl:value-of select='@id'/>} <xsl:apply-templates/></xsl:for-each>
\end{enumerate}
  </xsl:template>
  

  <!-- Code -->
  <xsl:template match="code">
<!--\texttt{<xsl:copy-of select='.'/>}-->
    \renewcommand{\baselinestretch}{1}\begin{verbatim}<xsl:apply-templates/>\end{verbatim}
  </xsl:template>
  

<!-- Figure -->
  <xsl:template match="figure">	
    <xsl:variable name="orient">
      <xsl:value-of select="@orient"/>
    </xsl:variable>	
    \begin{figure}[H]
      \centering <xsl:apply-templates select='title'/>
    \label{fig:<xsl:value-of select='@id'/>}
<!--    <xsl:apply-templates select="title"/>-->
<!--    \includegraphics{--><xsl:apply-templates select="mediaobject"/>
    <!-- Change this when we figure out how to have two different possibilities-->	
	<xsl:choose>
	  <xsl:when test="$orient='vertical'">
	    <xsl:for-each select="subfigure">
<xsl:if test='not(position()=last())'>
\subfigure[<xsl:apply-templates select="caption"/>]{<xsl:apply-templates select="mediaobject|table"/>}\\
</xsl:if>
<xsl:if test='position()=last()'>
\subfigure[<xsl:apply-templates select="caption"/>]{<xsl:apply-templates select="mediaobject|table"/>}
</xsl:if>
	    </xsl:for-each>
	  </xsl:when>
	  <xsl:otherwise>
	      <xsl:for-each select="subfigure">
\subfigure[<xsl:apply-templates select="caption"/>]{<xsl:apply-templates select="mediaobject|table"/>}
	      </xsl:for-each>
      </xsl:otherwise>
    </xsl:choose>
<xsl:apply-templates select="caption"/>
\end{figure}
  </xsl:template>


<!-- SubFigure -->
<!--  <xsl:template match="subfigure">
    <td>
      <xsl:apply-templates select="mediaobject|table"/>
      <br/>
      <xsl:apply-templates select="caption"/>
    </td>
  </xsl:template>
-->

  <!--FIX ME  -->
  <!--This mediaobject should be dependent on type='image'-->
  <!--check me (@type="image")-->
  <xsl:template match="mediaobject">
	<xsl:value-of select="@src"/>
  </xsl:template>


  <xsl:template match="title">
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="figure/caption">
    \caption{<xsl:apply-templates/>}
  </xsl:template>
  <xsl:template match="subfigure/caption">
    <xsl:apply-templates/>
  </xsl:template>

  <!-- math:math puts the math tag in the math namespace -->

  <xsl:template match="math:math">
    <xsl:copy-of select="."/>
  </xsl:template>

  <xsl:template match="equation">

    <!--do something with the para because eqn can go in paras-->
    <center>
      <a name="{@id}">	
	<table width="100%"> <tr>
	    <td width="30"></td>     
	    <td align="center" valign="center">
	      <xsl:apply-templates/>
	    </td>
	    <td width="30" align="right">	
	      <xsl:number level="any" count="equation" format="(1)"/>
	    </td>
	  </tr>
	</table>
      </a>
    </center>
  </xsl:template>


<!--Just printing the content of the cnxn tag -->
  <xsl:template match="cnxn">
    <xsl:apply-templates/>
  </xsl:template>

  
  <!--
  This prevents the keywords from printing in the module.
  -->
  <xsl:template match="keywordlist">
  </xsl:template>

  <!--	Added to make exercises appear and disappear -->
  <!--	The for-each commands are over kill but I could not figure out
  how else to do it.  -->
<!--  <xsl:template match="exercise">
    <xsl:variable name="ex">
      <xsl:number level="any"/>
    </xsl:variable>
    <xsl:variable name="somesolid">
      <xsl:for-each select="solution">
	<xsl:value-of select="@id"/>
      </xsl:for-each>   
    </xsl:variable>
    <div id='{@id}' class="problem" onclick="showSolution('{$somesolid}')">
      <xsl:attribute name="id">
	<xsl:for-each select="problem">
	  <xsl:value-of select="@id"/>
	</xsl:for-each>
      </xsl:attribute>
      <b>Question <xsl:value-of select="$ex"/>. </b>
      <i><xsl:apply-templates select="problem"/></i>
    </div>
    <div id='{@id}' class="solution" onclick="hideSolution('{$somesolid}')">
      <xsl:attribute name="id">
	<xsl:for-each select="solution">
	  <xsl:value-of select="@id"/>
	</xsl:for-each>
      </xsl:attribute>
      <b>Answer&nbsp;</b> <xsl:apply-templates select="solution"/>
    </div>
  </xsl:template>
  
  <xsl:template match="problem">
    <xsl:apply-templates/>
  </xsl:template>
  
  <xsl:template match="solution">
    <xsl:apply-templates/>
  </xsl:template>
-->  
  <!--	Added by Sarah on 8/17/00 -->
  
  
  <xsl:template match="example">

    \label{example:<xsl:value-of select='@id'/>}    
    Example 
    <xsl:apply-templates/>

  </xsl:template>
  

<!--This is an early draft.  It needs major modification.-->
<!--<xsl:template match="table">
<table border="3" align="center">
	<xsl:for-each select="categories">
		<tr>
			<xsl:for-each select="category">
				<td><B><xsl:apply-templates/></B></td>
			</xsl:for-each>
		</tr>
	</xsl:for-each>
	<xsl:for-each select="group">
		<tr>
			<xsl:for-each select="elem">
				<td><xsl:apply-templates/></td>
			</xsl:for-each>
		</tr>
	</xsl:for-each>
</table>
<xsl:apply-templates select="caption"/>
</xsl:template>-->
<!-- end early draft (7.28.00) -->

  <!--	 External link	       -->
  <xsl:template match='link'> <xsl:apply-templates/> (<xsl:value-of
  select="@src"/>) </xsl:template>
<!--	added by Sarah (8-18-00)-->

</xsl:stylesheet>













