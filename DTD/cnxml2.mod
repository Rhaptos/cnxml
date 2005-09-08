<!-- DTD for the Connexions Markup Language (CNXML)               -->
<!-- Version 0.2                                                  -->
<!--                                                              -->   
<!-- This entity may be identified by the following PUBLIC        -->
<!-- and SYSTEM identifiers                                       -->
<!--                                                              -->
<!-- PUBLIC:  -//CNX//ELEMENTS CNXML 0.2 Elements//EN             -->
<!-- SYSTEM:  http://cnx.rice.edu/cnxml/0.2/DTD/cnxml2.mod        -->
<!--  xmlns:  http://cnx.rice.edu/cnxml/0.2                       -->
<!--                                                              -->
<!-- CVS Version: $Revision$                               -->
<!-- Modified: $Date$                       -->
<!-- Maintained by the CNXML langauge team                        -->
<!-- email: cnxml@cnx.rice.edu                                    -->
<!--                                                              -->

<!-- Define the global namespace attributes -->
<![%CNXML.prefixed;[
<!ENTITY % CNXML.xmlns.attrib
    "%NS.decl.attrib;"
>
]]>
<!ENTITY % CNXML.xmlns.attrib
    "xmlns CDATA #FIXED '%CNXML.xmlns;' %NS.decl.attrib;"
>

<!-- Define a common set of attributes for all module elements -->
<!ENTITY % CNXML.Common.attrib
         "%CNXML.xmlns.attrib;"
>


<!-- Define the elements and attributes of the module -->
<!ENTITY % CNXML.module.content "(%CNXML.name.qname;, %CNXML.authorlist.qname;, (%CNXML.keywordlist.qname;)?, %CNXML.abstract.qname;, (%CNXML.section.qname;|%CNXML.para.qname;|%CNXML.equation.qname;|%CNXML.list.qname;|%CNXML.codeblock.qname;|%CNXML.figure.qname;|%CNXML.table.qname;|%CNXML.example.qname;|%CNXML.exercise.qname;|%CNXML.important.qname;|%CNXML.definition.qname;)+)">
<!ELEMENT %CNXML.module.qname; %CNXML.module.content; >
          <!ATTLIST %CNXML.module.qname; %CNXML.xmlns.attrib;>
	  <!ATTLIST %CNXML.module.qname; id ID #REQUIRED>
	  <!ATTLIST %CNXML.module.qname; levelmask CDATA #REQUIRED>
	  <!ATTLIST %CNXML.module.qname; created CDATA #REQUIRED>
	  <!ATTLIST %CNXML.module.qname; revised CDATA #REQUIRED>

<!ENTITY % CNXML.name.content "(#PCDATA)">
<!ELEMENT %CNXML.name.qname; %CNXML.name.content;>
          <!ATTLIST %CNXML.name.qname; %CNXML.xmlns.attrib;>

<!ENTITY % CNXML.authorlist.content "(%CNXML.author.qname;)+">
<!ELEMENT %CNXML.authorlist.qname; %CNXML.authorlist.content;>
          <!ATTLIST %CNXML.authorlist.qname; %CNXML.xmlns.attrib;>

<!ENTITY % CNXML.author.content "((%CNXML.honorific.qname;)?, %CNXML.firstname.qname;, (%CNXML.othername.qname;)*, %CNXML.surname.qname;, (%CNXML.lineage.qname;)?, (%CNXML.email.qname;)?)">
<!ELEMENT %CNXML.author.qname; %CNXML.author.content;>
          <!ATTLIST %CNXML.author.qname; %CNXML.xmlns.attrib;>
	  <!ATTLIST %CNXML.author.qname; id ID #REQUIRED>
	  <!ATTLIST %CNXML.author.qname; homepage CDATA #IMPLIED>

<!ENTITY % CNXML.honorific.content "(#PCDATA)">
<!ELEMENT %CNXML.honorific.qname; %CNXML.honorific.content;>
          <!ATTLIST %CNXML.honorific.qname; %CNXML.xmlns.attrib;>

<!ENTITY % CNXML.firstname.content "(#PCDATA)">
<!ELEMENT %CNXML.firstname.qname; %CNXML.firstname.content;>
          <!ATTLIST %CNXML.firstname.qname; %CNXML.xmlns.attrib;>

<!ENTITY % CNXML.othername.content "(#PCDATA)">
<!ELEMENT %CNXML.othername.qname; %CNXML.othername.content;>
          <!ATTLIST %CNXML.othername.qname; %CNXML.xmlns.attrib;>

<!ENTITY % CNXML.surname.content "(#PCDATA)">
<!ELEMENT %CNXML.surname.qname; %CNXML.surname.content;>
          <!ATTLIST %CNXML.surname.qname; %CNXML.xmlns.attrib;>

<!ENTITY % CNXML.lineage.content "(#PCDATA)">
<!ELEMENT %CNXML.lineage.qname; %CNXML.lineage.content;>
          <!ATTLIST %CNXML.lineage.qname; %CNXML.xmlns.attrib;>

<!ENTITY % CNXML.email.content "(#PCDATA)">
<!ELEMENT %CNXML.email.qname; %CNXML.email.content;>
          <!ATTLIST %CNXML.email.qname; %CNXML.xmlns.attrib;>

<!ENTITY % CNXML.cite.content "(#PCDATA|%CNXML.emphasis.qname;)*">
<!ELEMENT %CNXML.cite.qname; %CNXML.cite.content;>
          <!ATTLIST %CNXML.cite.qname; %CNXML.xmlns.attrib;>

<!ENTITY % CNXML.keywordlist.content "(%CNXML.keyword.qname;)+">
<!ELEMENT %CNXML.keywordlist.qname; %CNXML.keywordlist.content;>
          <!ATTLIST %CNXML.keywordlist.qname; %CNXML.xmlns.attrib;>

<!ENTITY % CNXML.keyword.content "(#PCDATA)">
<!ELEMENT %CNXML.keyword.qname; %CNXML.keyword.content;>
          <!ATTLIST %CNXML.keyword.qname; %CNXML.xmlns.attrib;>

<!ENTITY % CNXML.section.content "(%CNXML.name.qname;, (%CNXML.section.qname;|%CNXML.definition.qname;|%CNXML.para.qname;|%CNXML.equation.qname;|%CNXML.list.qname;|%CNXML.codeblock.qname;|%CNXML.figure.qname;|%CNXML.table.qname;|%CNXML.example.qname;|%CNXML.exercise.qname;|%CNXML.important.qname;)+)">
<!ELEMENT %CNXML.section.qname; %CNXML.section.content;>
          <!ATTLIST %CNXML.section.qname; %CNXML.xmlns.attrib;>
	  <!ATTLIST %CNXML.section.qname; id ID #REQUIRED>

<!ENTITY % CNXML.para.content "(#PCDATA|%CNXML.emphasis.qname;|%CNXML.important.qname;|%CNXML.list.qname;|%CNXML.cnxn.qname;|%CNXML.link.qname;|%CNXML.equation.qname;|%CNXML.cite.qname;|%CNXML.definition.qname;|%CNXML.codeline.qname;|%CNXML.term.qname;)*">
<!ELEMENT %CNXML.para.qname; %CNXML.para.content;>
          <!ATTLIST %CNXML.para.qname; %CNXML.xmlns.attrib;>
	  <!ATTLIST %CNXML.para.qname; id ID #REQUIRED>

<!ENTITY % CNXML.cnxn.content "(#PCDATA)">
<!ELEMENT %CNXML.cnxn.qname; %CNXML.cnxn.content;>
          <!ATTLIST %CNXML.cnxn.qname; %CNXML.xmlns.attrib;>
          <!ATTLIST %CNXML.cnxn.qname; target CDATA #IMPLIED>
          <!ATTLIST %CNXML.cnxn.qname; module CDATA #IMPLIED>
          <!ATTLIST %CNXML.cnxn.qname; strength (0|1|2|3|4|5|6|7|8|9) #REQUIRED>

<!ENTITY % CNXML.link.content "(#PCDATA)">
<!ELEMENT %CNXML.link.qname; %CNXML.link.content;>
          <!ATTLIST %CNXML.link.qname; %CNXML.xmlns.attrib;>
          <!ATTLIST %CNXML.link.qname; src CDATA #REQUIRED>

<!ENTITY % CNXML.equation.content "((%CNXML.name.qname;)?)">
<!ELEMENT %CNXML.equation.qname; %CNXML.equation.content;>
          <!ATTLIST %CNXML.equation.qname; %CNXML.xmlns.attrib;>
	  <!ATTLIST %CNXML.equation.qname; id ID #REQUIRED>

<!ENTITY % CNXML.important.content "ANY">
<!ELEMENT %CNXML.important.qname; %CNXML.important.content;>
          <!ATTLIST %CNXML.important.qname; %CNXML.xmlns.attrib;>
          <!ATTLIST %CNXML.important.qname; id ID #REQUIRED>

<!ENTITY % CNXML.emphasis.content "(#PCDATA)">
<!ELEMENT %CNXML.emphasis.qname; %CNXML.emphasis.content;>
          <!ATTLIST %CNXML.emphasis.qname; %CNXML.xmlns.attrib;>

<!ENTITY % CNXML.list.content "(%CNXML.item.qname;)+">
<!ELEMENT %CNXML.list.qname; %CNXML.list.content;>
          <!ATTLIST %CNXML.list.qname; %CNXML.xmlns.attrib;>
          <!ATTLIST %CNXML.list.qname; id ID #REQUIRED>
          <!ATTLIST %CNXML.list.qname; type (enumerated | bulleted) "bulleted">

<!ENTITY % CNXML.item.content "(#PCDATA|%CNXML.cnxn.qname;|%CNXML.link.qname;|%CNXML.cite.qname;|%CNXML.definition.qname;|%CNXML.codeline.qname;|%CNXML.important.qname;|%CNXML.emphasis.qname;|%CNXML.list.qname;)*">
<!ELEMENT %CNXML.item.qname; %CNXML.item.content;>
          <!ATTLIST %CNXML.item.qname; %CNXML.xmlns.attrib;>
          <!ATTLIST %CNXML.item.qname; id ID #IMPLIED>

<!ENTITY % CNXML.codeblock.content "(#PCDATA|%CNXML.cnxn.qname;|%CNXML.link.qname;|%CNXML.important.qname;|%CNXML.emphasis.qname;)*">
<!ELEMENT %CNXML.codeblock.qname; %CNXML.codeblock.content;>
          <!ATTLIST %CNXML.codeblock.qname; %CNXML.xmlns.attrib;>
          <!ATTLIST %CNXML.codeblock.qname; id ID #IMPLIED>

<!ENTITY % CNXML.codeline.content "(#PCDATA|%CNXML.cnxn.qname;|%CNXML.link.qname;|%CNXML.important.qname;|%CNXML.emphasis.qname;)*">
<!ELEMENT %CNXML.codeline.qname; %CNXML.codeline.content;>
          <!ATTLIST %CNXML.codeline.qname; %CNXML.xmlns.attrib;>

<!ENTITY % CNXML.media.content "EMPTY">
<!ELEMENT %CNXML.media.qname; %CNXML.media.content;>
          <!ATTLIST %CNXML.media.qname; %CNXML.xmlns.attrib;>
          <!ATTLIST %CNXML.media.qname; type CDATA #REQUIRED>
          <!ATTLIST %CNXML.media.qname; src CDATA #REQUIRED>

<!ENTITY % CNXML.figure.content "((%CNXML.name.qname;)?, ((%CNXML.subfigure.qname;, (%CNXML.subfigure.qname;)+)|%CNXML.media.qname;|%CNXML.table.qname;|%CNXML.codeblock.qname;), (%CNXML.caption.qname;)?)">
<!ELEMENT %CNXML.figure.qname; %CNXML.figure.content;>
          <!ATTLIST %CNXML.figure.qname; %CNXML.xmlns.attrib;>
	  <!ATTLIST %CNXML.figure.qname; id ID #REQUIRED>
          <!ATTLIST %CNXML.figure.qname; orient (vertical|horizontal) "horizontal">

<!ENTITY % CNXML.subfigure.content "((%CNXML.name.qname;)?, (%CNXML.media.qname;|%CNXML.table.qname;|%CNXML.codeblock.qname;), (%CNXML.caption.qname;)?)">
<!ELEMENT %CNXML.subfigure.qname; %CNXML.subfigure.content;>
          <!ATTLIST %CNXML.subfigure.qname; %CNXML.xmlns.attrib;>
          <!ATTLIST %CNXML.subfigure.qname; id ID #IMPLIED>

<!ENTITY % CNXML.caption.content "(#PCDATA|%CNXML.cnxn.qname;|%CNXML.codeline.qname;|%CNXML.link.qname;|%CNXML.important.qname;|%CNXML.emphasis.qname;)*">
<!ELEMENT %CNXML.caption.qname; %CNXML.caption.content;>
          <!ATTLIST %CNXML.caption.qname; %CNXML.xmlns.attrib;>

<!ENTITY % CNXML.table.content "(%CNXML.categories.qname;, (%CNXML.group.qname;)+)">
<!ELEMENT %CNXML.table.qname; %CNXML.table.content;>
          <!ATTLIST %CNXML.table.qname; %CNXML.xmlns.attrib;>
          <!ATTLIST %CNXML.table.qname; id ID #REQUIRED>
          <!ATTLIST %CNXML.table.qname; orient (vertical|horizontal) #REQUIRED>

<!ENTITY % CNXML.categories.content "((%CNXML.category.qname;)+)">
<!ELEMENT %CNXML.categories.qname; %CNXML.categories.content;>
          <!ATTLIST %CNXML.categories.qname; %CNXML.xmlns.attrib;>

<!ENTITY % CNXML.category.content "(#PCDATA)">
<!ELEMENT %CNXML.category.qname; %CNXML.category.content;>
          <!ATTLIST %CNXML.category.qname; %CNXML.xmlns.attrib;>
          <!ATTLIST %CNXML.category.qname; desc ID #REQUIRED>

<!ENTITY % CNXML.group.content "((%CNXML.elem.qname;)+)">
<!ELEMENT %CNXML.group.qname; %CNXML.group.content;>
          <!ATTLIST %CNXML.group.qname; %CNXML.xmlns.attrib;>

<!ENTITY % CNXML.elem.content "(#PCDATA|%CNXML.cnxn.qname;|%CNXML.link.qname;|%CNXML.important.qname;|%CNXML.cite.qname;|%CNXML.codeblock.qname;|%CNXML.emphasis.qname;)*">
<!ELEMENT %CNXML.elem.qname; %CNXML.elem.content;>
          <!ATTLIST %CNXML.elem.qname; %CNXML.xmlns.attrib;>
          <!ATTLIST %CNXML.elem.qname; id ID #IMPLIED>
          <!ATTLIST %CNXML.elem.qname; desc IDREF #REQUIRED>

<!ENTITY % CNXML.example.content "(%CNXML.para.qname;|%CNXML.equation.qname;|%CNXML.list.qname;|%CNXML.codeblock.qname;|%CNXML.figure.qname;|%CNXML.table.qname;|%CNXML.important.qname;)+">
<!ELEMENT %CNXML.example.qname; %CNXML.example.content;>
          <!ATTLIST %CNXML.example.qname; %CNXML.xmlns.attrib;>
          <!ATTLIST %CNXML.example.qname; id ID #REQUIRED>       

<!ENTITY % CNXML.exercise.content "(%CNXML.problem.qname;, %CNXML.solution.qname;)">
<!ELEMENT %CNXML.exercise.qname; %CNXML.exercise.content;>
          <!ATTLIST %CNXML.exercise.qname; %CNXML.xmlns.attrib;>
          <!ATTLIST %CNXML.exercise.qname; id ID #REQUIRED>

<!ENTITY % CNXML.problem.content "(%CNXML.cite.qname;|%CNXML.definition.qname;|%CNXML.para.qname;|%CNXML.equation.qname;|%CNXML.list.qname;|%CNXML.codeblock.qname;|%CNXML.figure.qname;|%CNXML.table.qname;|%CNXML.important.qname;)+">
<!ELEMENT %CNXML.problem.qname; %CNXML.problem.content;>
          <!ATTLIST %CNXML.problem.qname; %CNXML.xmlns.attrib;>

<!ENTITY % CNXML.solution.content "(%CNXML.cite.qname;|%CNXML.para.qname;|%CNXML.equation.qname;|%CNXML.list.qname;|%CNXML.codeblock.qname;|%CNXML.figure.qname;|%CNXML.table.qname;|%CNXML.important.qname;)+">
<!ELEMENT %CNXML.solution.qname; %CNXML.solution.content;>
          <!ATTLIST %CNXML.solution.qname; %CNXML.xmlns.attrib;>

<!ENTITY % CNXML.abstract.content "(#PCDATA|%CNXML.codeline.qname;|%CNXML.emphasis.qname;)*">
<!ELEMENT %CNXML.abstract.qname; %CNXML.abstract.content;>
          <!ATTLIST %CNXML.abstract.qname; %CNXML.xmlns.attrib;>

<!ENTITY % CNXML.definition.content "(%CNXML.term.qname;, (%CNXML.meaning.qname;, (%CNXML.example.qname;)*)+)">
<!ELEMENT %CNXML.definition.qname; %CNXML.definition.content;>
          <!ATTLIST %CNXML.definition.qname; %CNXML.xmlns.attrib;>
          <!ATTLIST %CNXML.definition.qname; id ID #REQUIRED>

<!ENTITY % CNXML.term.content "(#PCDATA|%CNXML.codeline.qname;)*">
<!ELEMENT %CNXML.term.qname; %CNXML.term.content;>
          <!ATTLIST %CNXML.term.qname; %CNXML.xmlns.attrib;>

<!ENTITY % CNXML.meaning.content "(#PCDATA|%CNXML.codeline.qname;|%CNXML.emphasis.qname;|%CNXML.cite.qname;|%CNXML.link.qname;|%CNXML.cnxn.qname;)*">
<!ELEMENT %CNXML.meaning.qname; %CNXML.meaning.content;>
          <!ATTLIST %CNXML.meaning.qname; %CNXML.xmlns.attrib;>
