<!-- DTD for the Connexions Markup Language (CNXML)                -->
<!-- Version 0.3                                                   -->
<!--                                                               -->   
<!-- This entity may be identified by the following PUBLIC         -->
<!-- and SYSTEM identifiers                                        -->
<!--                                                               -->
<!-- PUBLIC:  -//CNX//ENTITIES CNXML 0.3 Qualified Names 1.0//EN   -->
<!-- SYSTEM:  http://cnx.rice.edu/cnxml/0.3/DTD/cnxml-qname-1.mod  -->
<!--  xmlns:  http://cnx.rice.edu/cnxml/0.3                        -->
<!--                                                               -->
<!-- CVS Version: $Revision$                                 -->
<!-- Modified: $Date$                        -->
<!-- Maintained by the CNXML langauge team                         -->
<!-- email: cnxml@cnx.rice.edu                                     -->
<!--                                                               -->
<!-- CNXML Qualified Names:                                        -->
<!--                                                               -->
<!-- This module is contained in two parts, labeled Section 'A'    -->
<!-- and 'B'                                                       -->
<!--                                                               -->
<!-- Section A declares parameter entities to support namespace-   -->
<!-- qualified names, namespace declarations, and name prefixing   -->
<!-- for CNXML                                                     -->
<!--                                                               -->
<!-- Section B declares parameter entities used to provide         -->
<!-- namespace-qualified names for all CNXML element types.        -->
<!--                                                               -->
<!-- This module is derived from the MathML2 Qualified Names       -->
<!-- module.                                                       -->


<!-- Section A: XHTML XML Namespace Framework -->

<!-- Declare the default value for prefixing of this module's elements -->
<!-- Note that the NS.prefixed will get overridden by the XHTML Framework or
     by a document instance. -->

<!ENTITY % NS.prefixed     "IGNORE" >
<!ENTITY % CNXML.prefixed "%NS.prefixed;" >

<!-- Declare the actual namespace of this module -->
<!ENTITY % CNXML.xmlns    "http://cnx.rice.edu/cnxml/0.3" >

<!-- Declare the default prefix for this module -->
<!ENTITY % CNXML.prefix   "cnx" >

<!-- Declare the prefix for this module -->
<![%CNXML.prefixed;[
<!ENTITY % CNXML.pfx "%CNXML.prefix;:" >
]]>
<!ENTITY % CNXML.pfx "" >

<!-- Declare the xml namespace attribute for this module -->
<![%CNXML.prefixed;[
<!ENTITY % CNXML.xmlns.extra.attrib
	 "xmlns:%CNXML.prefix;   CDATA  #FIXED  '%CNXML.xmlns;'" >
]]>
<!ENTITY % CNXML.xmlns.extra.attrib "" >


<!-- Declare the extra namespace that should be included in the XHTML elements -->
<!ENTITY % XHTML.xmlns.extra.attrib "%CNXML.xmlns.extra.attrib;" >
              
<!-- XLink -->

<!ENTITY % XLINK.xmlns "http://www.w3.org/1999/xlink" >
<!ENTITY % XLINK.xmlns.attrib
     "xmlns:xlink  CDATA           #FIXED '%XLINK.xmlns;'"
>


<!-- Section B: CNXML Qualified Names -->

<!ENTITY % CNXML.module.qname       "%CNXML.pfx;module">
<!ENTITY % CNXML.name.qname         "%CNXML.pfx;name" >
<!ENTITY % CNXML.authorlist.qname   "%CNXML.pfx;authorlist" >
<!ENTITY % CNXML.author.qname       "%CNXML.pfx;author" >
<!ENTITY % CNXML.maintainerlist.qname   "%CNXML.pfx;maintainerlist" >
<!ENTITY % CNXML.maintainer.qname       "%CNXML.pfx;maintainer" >
<!ENTITY % CNXML.honorific.qname    "%CNXML.pfx;honorific" >
<!ENTITY % CNXML.firstname.qname    "%CNXML.pfx;firstname" >
<!ENTITY % CNXML.othername.qname    "%CNXML.pfx;othername" >
<!ENTITY % CNXML.surname.qname      "%CNXML.pfx;surname" >
<!ENTITY % CNXML.lineage.qname      "%CNXML.pfx;lineage" >
<!ENTITY % CNXML.email.qname        "%CNXML.pfx;email" >
<!ENTITY % CNXML.cite.qname         "%CNXML.pfx;cite" >
<!ENTITY % CNXML.keywordlist.qname  "%CNXML.pfx;keywordlist" >
<!ENTITY % CNXML.keyword.qname      "%CNXML.pfx;keyword" >
<!ENTITY % CNXML.section.qname      "%CNXML.pfx;section" >
<!ENTITY % CNXML.para.qname         "%CNXML.pfx;para" >
<!ENTITY % CNXML.cnxn.qname         "%CNXML.pfx;cnxn" >
<!ENTITY % CNXML.link.qname         "%CNXML.pfx;link" >
<!ENTITY % CNXML.equation.qname     "%CNXML.pfx;equation" >
<!ENTITY % CNXML.emphasis.qname     "%CNXML.pfx;emphasis" >
<!ENTITY % CNXML.list.qname         "%CNXML.pfx;list" >
<!ENTITY % CNXML.item.qname         "%CNXML.pfx;item" >
<!ENTITY % CNXML.codeblock.qname    "%CNXML.pfx;codeblock" >
<!ENTITY % CNXML.codeline.qname     "%CNXML.pfx;codeline" >
<!ENTITY % CNXML.media.qname        "%CNXML.pfx;media" >
<!ENTITY % CNXML.figure.qname       "%CNXML.pfx;figure" >
<!ENTITY % CNXML.subfigure.qname    "%CNXML.pfx;subfigure" >
<!ENTITY % CNXML.caption.qname      "%CNXML.pfx;caption" >
<!ENTITY % CNXML.table.qname        "%CNXML.pfx;table" >
<!ENTITY % CNXML.categories.qname   "%CNXML.pfx;categories" >
<!ENTITY % CNXML.category.qname     "%CNXML.pfx;category" >
<!ENTITY % CNXML.group.qname        "%CNXML.pfx;group" >
<!ENTITY % CNXML.elem.qname         "%CNXML.pfx;elem" >
<!ENTITY % CNXML.example.qname      "%CNXML.pfx;example" >
<!ENTITY % CNXML.exercise.qname     "%CNXML.pfx;exercise" >
<!ENTITY % CNXML.problem.qname      "%CNXML.pfx;problem" >
<!ENTITY % CNXML.solution.qname     "%CNXML.pfx;solution" >
<!ENTITY % CNXML.abstract.qname     "%CNXML.pfx;abstract" >
<!ENTITY % CNXML.definition.qname   "%CNXML.pfx;definition" >
<!ENTITY % CNXML.term.qname         "%CNXML.pfx;term" >
<!ENTITY % CNXML.meaning.qname      "%CNXML.pfx;meaning" >
<!ENTITY % CNXML.note.qname         "%CNXML.pfx;note" >
<!ENTITY % CNXML.rule.qname         "%CNXML.pfx;rule" >
<!ENTITY % CNXML.statement.qname    "%CNXML.pfx;statement" >
<!ENTITY % CNXML.proof.qname        "%CNXML.pfx;proof" >
<!ENTITY % CNXML.objectives.qname   "%CNXML.pfx;objectives" >


