<!-- DTD for the Connexions Markup Language (MDML)              -->
<!-- Version 0.4                                                -->
<!--                                                            -->   
<!-- This entity may be identified by the following PUBLIC      -->
<!-- and SYSTEM identifiers                                     -->
<!--                                                            -->
<!-- PUBLIC:  -//CNX//ELEMENTS MDML 0.4 Elements//EN            -->
<!-- SYSTEM:  http://cnx.rice.edu/technology/mdml/schema/dtd/0.4/mdml.mod         -->
<!--  xmlns:  http://cnx.rice.edu/mdml/0.4                      -->
<!--                                                            -->
<!-- CVS Version: $Revision$                             -->
<!-- Modified: $Date$                     -->
<!-- Maintained by the MDML langauge team                       -->
<!-- email: mdml@cnx.rice.edu                                   -->
<!--                                                             -->

<!-- Define the global namespace attributes -->
<![%MDML.prefixed;[
<!ENTITY % MDML.xmlns.attrib
    "%NS.decl.attrib;"
>
]]>
<!ENTITY % MDML.xmlns.attrib
    "xmlns CDATA #FIXED '%MDML.xmlns;' %NS.decl.attrib;"
>

<!-- Define a common set of attributes for all document elements -->
<!ENTITY % MDML.Common.attrib
         "%MDML.xmlns.attrib;"
>


<!ENTITY % MDML.metadata.content "(%MDML.version.qname;,%MDML.created.qname;,%MDML.revised.qname;,%MDML.authorlist.qname;, %MDML.maintainerlist.qname;, (%MDML.keywordlist.qname;)?, %MDML.abstract.qname;, (%MDML.objectives.qname;)?)">
<!ELEMENT %MDML.metadata.qname; %MDML.metadata.content;>
          <!ATTLIST %MDML.metadata.qname; %MDML.xmlns.attrib;>

<!ENTITY % MDML.version.content "(#PCDATA)">
<!ELEMENT %MDML.version.qname; %MDML.version.content;>
          <!ATTLIST %MDML.version.qname; %MDML.xmlns.attrib;>

<!ENTITY % MDML.created.content "(#PCDATA)">
<!ELEMENT %MDML.created.qname; %MDML.created.content;>
          <!ATTLIST %MDML.created.qname; %MDML.xmlns.attrib;>

<!ENTITY % MDML.revised.content "(#PCDATA)">
<!ELEMENT %MDML.revised.qname; %MDML.revised.content;>
          <!ATTLIST %MDML.revised.qname; %MDML.xmlns.attrib;>

<!ENTITY % MDML.authorlist.content "(%MDML.author.qname;)+">
<!ELEMENT %MDML.authorlist.qname; %MDML.authorlist.content;>
          <!ATTLIST %MDML.authorlist.qname; %MDML.xmlns.attrib;>

<!ENTITY % MDML.author.content "((%MDML.honorific.qname;)?, %MDML.firstname.qname;, (%MDML.othername.qname;)*, %MDML.surname.qname;, (%MDML.lineage.qname;)?, (%MDML.email.qname;)?)">
<!ELEMENT %MDML.author.qname; %MDML.author.content;>
          <!ATTLIST %MDML.author.qname; %MDML.xmlns.attrib;>
	  <!ATTLIST %MDML.author.qname; id CDATA #REQUIRED>
	  <!ATTLIST %MDML.author.qname; homepage CDATA #IMPLIED>

<!ENTITY % MDML.maintainerlist.content "(%MDML.maintainer.qname;)+">
<!ELEMENT %MDML.maintainerlist.qname; %MDML.maintainerlist.content;>
          <!ATTLIST %MDML.maintainerlist.qname; %MDML.xmlns.attrib;>

<!ENTITY % MDML.maintainer.content "((%MDML.honorific.qname;)?, %MDML.firstname.qname;, (%MDML.othername.qname;)*, %MDML.surname.qname;, (%MDML.lineage.qname;)?, (%MDML.email.qname;)?)">
<!ELEMENT %MDML.maintainer.qname; %MDML.maintainer.content;>
          <!ATTLIST %MDML.maintainer.qname; %MDML.xmlns.attrib;>
	  <!ATTLIST %MDML.maintainer.qname; id CDATA #REQUIRED>
	  <!ATTLIST %MDML.maintainer.qname; homepage CDATA #IMPLIED>

<!ENTITY % MDML.honorific.content "(#PCDATA)">
<!ELEMENT %MDML.honorific.qname; %MDML.honorific.content;>
          <!ATTLIST %MDML.honorific.qname; %MDML.xmlns.attrib;>

<!ENTITY % MDML.firstname.content "(#PCDATA)">
<!ELEMENT %MDML.firstname.qname; %MDML.firstname.content;>
          <!ATTLIST %MDML.firstname.qname; %MDML.xmlns.attrib;>

<!ENTITY % MDML.othername.content "(#PCDATA)">
<!ELEMENT %MDML.othername.qname; %MDML.othername.content;>
          <!ATTLIST %MDML.othername.qname; %MDML.xmlns.attrib;>

<!ENTITY % MDML.surname.content "(#PCDATA)">
<!ELEMENT %MDML.surname.qname; %MDML.surname.content;>
          <!ATTLIST %MDML.surname.qname; %MDML.xmlns.attrib;>

<!ENTITY % MDML.lineage.content "(#PCDATA)">
<!ELEMENT %MDML.lineage.qname; %MDML.lineage.content;>
          <!ATTLIST %MDML.lineage.qname; %MDML.xmlns.attrib;>

<!ENTITY % MDML.email.content "(#PCDATA)">
<!ELEMENT %MDML.email.qname; %MDML.email.content;>
          <!ATTLIST %MDML.email.qname; %MDML.xmlns.attrib;>

<!ENTITY % MDML.keywordlist.content "(%MDML.keyword.qname;)+">
<!ELEMENT %MDML.keywordlist.qname; %MDML.keywordlist.content;>
          <!ATTLIST %MDML.keywordlist.qname; %MDML.xmlns.attrib;>

<!ENTITY % MDML.keyword.content "(#PCDATA)">
<!ELEMENT %MDML.keyword.qname; %MDML.keyword.content;>
          <!ATTLIST %MDML.keyword.qname; %MDML.xmlns.attrib;>

<!ENTITY % MDML.abstract.content "(#PCDATA)">
<!ELEMENT %MDML.abstract.qname; %MDML.abstract.content;>
          <!ATTLIST %MDML.abstract.qname; %MDML.xmlns.attrib;>

<!ENTITY % MDML.objectives.content "(#PCDATA)">
<!ELEMENT %MDML.objectives.qname; %MDML.objectives.content;>
          <!ATTLIST %MDML.objectives.qname; %MDML.xmlns.attrib;>
