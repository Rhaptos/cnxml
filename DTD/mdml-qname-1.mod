<!-- DTD for the Connexions Markup Language (MDML)                -->
<!-- Version 0.4                                                  -->
<!--                                                              -->   
<!-- This entity may be identified by the following PUBLIC        -->
<!-- and SYSTEM identifiers                                       -->
<!--                                                              -->
<!-- PUBLIC:  -//CNX//ENTITIES MDML 0.4 Qualified Names 1.0//EN   -->
<!-- SYSTEM:  http://cnx.rice.edu/mdml/0.4/DTD/mdml-qname-1.mod   -->
<!--  xmlns:  http://cnx.rice.edu/mdml/0.4                        -->
<!--                                                              -->
<!-- CVS Version: $Revision$                                -->
<!-- Modified: $Date$                       -->
<!-- Maintained by the MDML langauge team                         -->
<!-- email: mdml@cnx.rice.edu                                     -->
<!--                                                              -->
<!-- MDML Qualified Names:                                        -->
<!--                                                              -->
<!-- This module is contained in two parts, labeled Section 'A'   -->
<!-- and 'B'                                                      -->
<!--                                                              -->
<!-- Section A declares parameter entities to support namespace-  -->
<!-- qualified names, namespace declarations, and name prefixing  -->
<!-- for MDML                                                     -->
<!--                                                              -->
<!-- Section B declares parameter entities used to provide        -->
<!-- namespace-qualified names for all MDML element types.        -->
<!--                                                              -->
<!-- This module is derived from the MathML2 Qualified Names      -->
<!-- module.                                                      -->


<!-- Section A: XHTML XML Namespace Framework -->

<!-- Declare the default value for prefixing of this module's elements -->
<!-- Note that the NS.prefixed will get overridden by the XHTML Framework or
     by a document instance. -->

<!ENTITY % NS.prefixed     "IGNORE" >
<!ENTITY % MDML.prefixed "%NS.prefixed;" >

<!-- Declare the actual namespace of this module -->
<!ENTITY % MDML.xmlns    "http://cnx.rice.edu/mdml/0.4" >

<!-- Declare the default prefix for this module -->
<!ENTITY % MDML.prefix   "md" >

<!-- Declare the prefix for this module -->
<![%MDML.prefixed;[
<!ENTITY % MDML.pfx "%MDML.prefix;:" >
]]>
<!ENTITY % MDML.pfx "" >

<!-- Declare the xml namespace attribute for this module -->
<![%MDML.prefixed;[
<!ENTITY % MDML.xmlns.extra.attrib
	 "xmlns:%MDML.prefix;   CDATA  #FIXED  '%MDML.xmlns;'" >
]]>
<!ENTITY % MDML.xmlns.extra.attrib "" >


<!-- Declare the extra namespace that should be included in the XHTML elements -->
<!ENTITY % XHTML.xmlns.extra.attrib "%MDML.xmlns.extra.attrib;" >
              
<!-- XLink -->

<!ENTITY % XLINK.xmlns "http://www.w3.org/1999/xlink" >
<!ENTITY % XLINK.xmlns.attrib
     "xmlns:xlink  CDATA           #FIXED '%XLINK.xmlns;'"
>


<!-- Section B: MDML Qualified Names -->

<!ENTITY % MDML.metadata.qname       "%MDML.pfx;metadata">
<!ENTITY % MDML.version.qname        "%MDML.pfx;version">
<!ENTITY % MDML.created.qname        "%MDML.pfx;created">
<!ENTITY % MDML.revised.qname        "%MDML.pfx;revised">
<!ENTITY % MDML.authorlist.qname     "%MDML.pfx;authorlist" >
<!ENTITY % MDML.author.qname         "%MDML.pfx;author" >
<!ENTITY % MDML.maintainerlist.qname "%MDML.pfx;maintainerlist" >
<!ENTITY % MDML.maintainer.qname     "%MDML.pfx;maintainer" >
<!ENTITY % MDML.honorific.qname      "%MDML.pfx;honorific" >
<!ENTITY % MDML.firstname.qname      "%MDML.pfx;firstname" >
<!ENTITY % MDML.othername.qname      "%MDML.pfx;othername" >
<!ENTITY % MDML.surname.qname        "%MDML.pfx;surname" >
<!ENTITY % MDML.lineage.qname        "%MDML.pfx;lineage" >
<!ENTITY % MDML.email.qname          "%MDML.pfx;email" >
<!ENTITY % MDML.keywordlist.qname    "%MDML.pfx;keywordlist" >
<!ENTITY % MDML.keyword.qname        "%MDML.pfx;keyword" >
<!ENTITY % MDML.abstract.qname       "%MDML.pfx;abstract" >
<!ENTITY % MDML.objectives.qname     "%MDML.pfx;objectives" >
