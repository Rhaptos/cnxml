<!-- DTD for the Connexions Markup Language (CNXML)                -->
<!-- Version 0.5                                                   -->
<!--                                                               -->   
<!-- This entity may be identified by the following PUBLIC         -->
<!-- and SYSTEM identifiers                                        -->
<!--                                                               -->
<!-- PUBLIC:  -//CNX//ENTITIES CNXML 0.5 Qualified Names 1.0//EN   -->
<!-- SYSTEM:  http://cnx.rice.edu/technology/cnxml/schema/dtd/0.5/cnxml-qname-1.mod  -->
<!--  xmlns:  http://cnx.rice.edu/cnxml                            -->
<!--                                                               -->
<!-- CVS Version: $Revision$                                -->
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

<!-- Declare the default value for prefixing of this document's elements -->
<!-- Note that the NS.prefixed will get overridden by the XHTML Framework or
     by a document instance. -->

<!ENTITY % NS.prefixed     "IGNORE" >
<!ENTITY % CNXML.prefixed "%NS.prefixed;" >

<!-- Declare the actual namespace of this document -->
<!ENTITY % CNXML.xmlns    "http://cnx.rice.edu/cnxml" >

<!-- Declare the default prefix for this document -->
<!ENTITY % CNXML.prefix   "cnx" >

<!-- Declare the prefix for this document -->
<![%CNXML.prefixed;[
<!ENTITY % CNXML.pfx "%CNXML.prefix;:" >
]]>
<!ENTITY % CNXML.pfx "" >

<!-- Declare the xml namespace attribute for this document -->
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

<!ENTITY % CNXML.document.qname     "%CNXML.pfx;document">
<!ENTITY % CNXML.metadata.qname     "%CNXML.pfx;metadata">
<!ENTITY % CNXML.content.qname      "%CNXML.pfx;content">
<!ENTITY % CNXML.glossary.qname     "%CNXML.pfx;glossary">
<!ENTITY % CNXML.name.qname         "%CNXML.pfx;name" >
<!ENTITY % CNXML.cite.qname         "%CNXML.pfx;cite" >
<!ENTITY % CNXML.section.qname      "%CNXML.pfx;section" >
<!ENTITY % CNXML.para.qname         "%CNXML.pfx;para" >
<!ENTITY % CNXML.cnxn.qname         "%CNXML.pfx;cnxn" >
<!ENTITY % CNXML.link.qname         "%CNXML.pfx;link" >
<!ENTITY % CNXML.equation.qname     "%CNXML.pfx;equation" >
<!ENTITY % CNXML.emphasis.qname     "%CNXML.pfx;emphasis" >
<!ENTITY % CNXML.list.qname         "%CNXML.pfx;list" >
<!ENTITY % CNXML.item.qname         "%CNXML.pfx;item" >
<!ENTITY % CNXML.code.qname         "%CNXML.pfx;code" >
<!ENTITY % CNXML.media.qname        "%CNXML.pfx;media" >
<!ENTITY % CNXML.figure.qname       "%CNXML.pfx;figure" >
<!ENTITY % CNXML.subfigure.qname    "%CNXML.pfx;subfigure" >
<!ENTITY % CNXML.caption.qname      "%CNXML.pfx;caption" >
<!ENTITY % CNXML.example.qname      "%CNXML.pfx;example" >
<!ENTITY % CNXML.exercise.qname     "%CNXML.pfx;exercise" >
<!ENTITY % CNXML.problem.qname      "%CNXML.pfx;problem" >
<!ENTITY % CNXML.solution.qname     "%CNXML.pfx;solution" >
<!ENTITY % CNXML.definition.qname   "%CNXML.pfx;definition" >
<!ENTITY % CNXML.term.qname         "%CNXML.pfx;term" >
<!ENTITY % CNXML.meaning.qname      "%CNXML.pfx;meaning" >
<!ENTITY % CNXML.seealso.qname      "%CNXML.pfx;seealso" >
<!ENTITY % CNXML.note.qname         "%CNXML.pfx;note" >
<!ENTITY % CNXML.rule.qname         "%CNXML.pfx;rule" >
<!ENTITY % CNXML.statement.qname    "%CNXML.pfx;statement" >
<!ENTITY % CNXML.proof.qname        "%CNXML.pfx;proof" >
<!ENTITY % CNXML.code.qname         "%CNXML.pfx;code" >
<!ENTITY % CNXML.param.qname        "%CNXML.pfx;param" >
<!ENTITY % CNXML.quote.qname        "%CNXML.pfx;quote" >
<!ENTITY % CNXML.foreign.qname      "%CNXML.pfx;foreign" >

<!--           DocBook XML CALS Table Model V4.1.2                   -->

<!-- 
     Copyright 1992-2000 HaL Computer Systems, Inc., O'Reilly &
     Associates, Inc., ArborText, Inc., Fujitsu Software Corporation,
     Norman Walsh and the Organization for the Advancement of
     Structured Information Standards (OASIS).

     This DTD is based on the CALS Table Model PUBLIC "-//USA-DOD//DTD
     Table Model 951010//EN"

     $Id$

     Permission to use, copy, modify and distribute the DocBook XML
     DTD and its accompanying documentation for any purpose and
     without fee is hereby granted in perpetuity, provided that the
     above copyright notice and this paragraph appear in all copies.
     The copyright holders make no representation about the
     suitability of the DTD for any purpose.  It is provided "as is"
     without expressed or implied warranty.

     If you modify the DocBook XML DTD in any way, except for
     declaring and referencing additional sets of general entities and
     declaring additional notations, label your DTD as a variant of
     DocBook.  See the maintenance documentation for more information.

     Please direct all questions, bug reports, or suggestions for
     changes to the docbook@lists.oasis-open.org mailing list. For
     more information, see http://www.oasis-open.org/docbook/.  
-->

<!ENTITY % CNXML.table.qname        "%CNXML.pfx;table">
<!ENTITY % CNXML.tgroup.qname       "%CNXML.pfx;tgroup" >
<!ENTITY % CNXML.colspec.qname      "%CNXML.pfx;colspec" >
<!ENTITY % CNXML.spanspec.qname     "%CNXML.pfx;spanspec" >
<!ENTITY % CNXML.thead.qname        "%CNXML.pfx;thead" >
<!ENTITY % CNXML.tfoot.qname        "%CNXML.pfx;tfoot" >
<!ENTITY % CNXML.tbody.qname        "%CNXML.pfx;tbody" >
<!ENTITY % CNXML.row.qname          "%CNXML.pfx;row" >
<!ENTITY % CNXML.entrytbl.qname     "%CNXML.pfx;entrytbl" >
<!ENTITY % CNXML.entry.qname        "%CNXML.pfx;entry" >