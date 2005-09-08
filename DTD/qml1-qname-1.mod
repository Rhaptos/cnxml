<!-- DTD for the Questions Markup Language (QML)                  -->
<!-- Version 1.0                                                   -->
<!--                                                               -->   
<!-- This entity may be identified by the following PUBLIC         -->
<!-- and SYSTEM identifiers                                        -->
<!--                                                               -->
<!-- PUBLIC:  -//CNX//ENTITIES QML 1.0 Qualified Names 1.0//EN    -->
<!-- SYSTEM:  http://cnx.rice.edu/qml/1.0/DTD/qml1-qname-1.mod   -->
<!--  xmlns:  http://cnx.rice.edu/qml/1.0                         -->
<!--                                                               -->
<!-- CVS Version: $Revision$                                 -->
<!-- Modified: $Date$                        -->
<!-- Maintained by the Learning Assessment Team                    -->
<!-- email: asses@cnx.rice.edu                                     -->
<!--                                                               -->
<!-- QML Qualified Names:                                         -->
<!--                                                               -->
<!-- This module is contained in two parts, labeled Section 'A'    -->
<!-- and 'B'                                                       -->
<!--                                                               -->
<!-- Section A declares parameter entities to support namespace-   -->
<!-- qualified names, namespace declarations, and name prefixing   -->
<!-- for QML                                                      -->
<!--                                                               -->
<!-- Section B declares parameter entities used to provide         -->
<!-- namespace-qualified names for all QML element types.         -->
<!--                                                               -->
<!-- This module is derived from the CNXML Qualified Names         -->
<!-- module.                                                       -->


<!-- Section A: XHTML XML Namespace Framework -->

<!-- Declare the default value for prefixing of this module's elements -->
<!-- Note that the NS.prefixed will get overridden by the XHTML Framework or
     by a document instance. -->

<!ENTITY % NS.prefixed     "IGNORE" >
<!ENTITY % QML.prefixed "%NS.prefixed;" >

<!-- Declare the actual namespace of this module -->
<!ENTITY % QML.xmlns    "http://cnx.rice.edu/qml/1.0" >

<!-- Declare the default prefix for this module -->
<!ENTITY % QML.prefix   "q" >

<!-- Declare the prefix for this module -->
<![%QML.prefixed;[
<!ENTITY % QML.pfx "%QML.prefix;:" >
]]>
<!ENTITY % QML.pfx "" >

<!-- Declare the xml namespace attribute for this module -->
<![%QML.prefixed;[
<!ENTITY % QML.xmlns.extra.attrib
	 "xmlns:%QML.prefix;   CDATA  #FIXED  '%QML.xmlns;'" >
]]>
<!ENTITY % QML.xmlns.extra.attrib "" >


<!-- Declare the extra namespace that should be included in the XHTML elements -->
<!ENTITY % XHTML.xmlns.extra.attrib "%QML.xmlns.extra.attrib;" >
              
<!-- XLink -->

<!ENTITY % XLINK.xmlns "http://www.w3.org/1999/xlink" >
<!ENTITY % XLINK.xmlns.attrib
     "xmlns:xlink  CDATA           #FIXED '%XLINK.xmlns;'"
>


<!-- Section B: QML Qualified Names -->

<!ENTITY % QML.problemset.qname "%QML.pfx;problemset">
<!ENTITY % QML.item.qname       "%QML.pfx;item">
<!ENTITY % QML.question.qname   "%QML.pfx;question">
<!ENTITY % QML.resource.qname   "%QML.pfx;resource">
<!ENTITY % QML.answer.qname     "%QML.pfx;answer">
<!ENTITY % QML.response.qname   "%QML.pfx;response">
<!ENTITY % QML.feedback.qname   "%QML.pfx;feedback">
<!ENTITY % QML.hint.qname       "%QML.pfx;hint">
<!ENTITY % QML.key.qname        "%QML.pfx;key">




