<!-- DTD for the Connexions Markup Language (CNXML)               -->
<!-- Version 0.3.5                                                -->
<!--                                                              -->   
<!-- This entity may be identified by the following PUBLIC        -->
<!-- and SYSTEM identifiers                                       -->
<!--                                                              -->
<!-- PUBLIC:  -//CNX//ELEMENTS CNXML 0.3.5 Elements//EN           -->
<!-- SYSTEM:  http://cnx.rice.edu/cnxml/0.3.5/DTD/cnxml.mod       -->
<!--  xmlns:  http://cnx.rice.edu/cnxml/0.3.5                     -->
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

<!ENTITY % CNXML.textextras "#PCDATA" >

<!ENTITY % CNXML.textlike '%CNXML.textextras;|%CNXML.emphasis.qname;|%CNXML.codeline.qname;|%CNXML.term.qname;|%CNXML.cite.qname;|%CNXML.cnxn.qname;|%CNXML.link.qname;'>

<!-- Define the elements and attributes of the module -->
<!ENTITY % CNXML.module.content "(%CNXML.name.qname;,%CNXML.metadata.qname;,%CNXML.content.qname;)">
<!ELEMENT %CNXML.module.qname; %CNXML.module.content; >
          <!ATTLIST %CNXML.module.qname; %CNXML.xmlns.attrib;>
	  <!ATTLIST %CNXML.module.qname; id ID #REQUIRED>
	  <!ATTLIST %CNXML.module.qname; levelmask CDATA #REQUIRED>
	  <!ATTLIST %CNXML.module.qname; created CDATA #REQUIRED>
	  <!ATTLIST %CNXML.module.qname; revised CDATA #REQUIRED>
	  <!ATTLIST %CNXML.module.qname; version CDATA #REQUIRED>

<!ENTITY % CNXML.metadata.content "(%CNXML.authorlist.qname;, %CNXML.maintainerlist.qname;, (%CNXML.keywordlist.qname;)?, %CNXML.abstract.qname;, (%CNXML.objectives.qname;)?)">
<!ELEMENT %CNXML.metadata.qname; %CNXML.metadata.content;>
          <!ATTLIST %CNXML.metadata.qname; %CNXML.xmlns.attrib;>

<!ENTITY % CNXML.content.content "(%CNXML.section.qname;|%CNXML.para.qname;|%CNXML.equation.qname;|%CNXML.list.qname;|%CNXML.codeblock.qname;|%CNXML.figure.qname;|%CNXML.table.qname;|%CNXML.example.qname;|%CNXML.exercise.qname;|%CNXML.definition.qname;|%CNXML.rule.qname;)+">
<!ELEMENT %CNXML.content.qname; %CNXML.content.content;>
          <!ATTLIST %CNXML.content.qname; %CNXML.xmlns.attrib;>

<!ENTITY % CNXML.name.content "(#PCDATA)">
<!ELEMENT %CNXML.name.qname; %CNXML.name.content;>
          <!ATTLIST %CNXML.name.qname; %CNXML.xmlns.attrib;>

<!ENTITY % CNXML.authorlist.content "(%CNXML.author.qname;)+">
<!ELEMENT %CNXML.authorlist.qname; %CNXML.authorlist.content;>
          <!ATTLIST %CNXML.authorlist.qname; %CNXML.xmlns.attrib;>

<!ENTITY % CNXML.author.content "((%CNXML.honorific.qname;)?, %CNXML.firstname.qname;, (%CNXML.othername.qname;)*, %CNXML.surname.qname;, (%CNXML.lineage.qname;)?, (%CNXML.email.qname;)?)">
<!ELEMENT %CNXML.author.qname; %CNXML.author.content;>
          <!ATTLIST %CNXML.author.qname; %CNXML.xmlns.attrib;>
	  <!ATTLIST %CNXML.author.qname; id CDATA #REQUIRED>
	  <!ATTLIST %CNXML.author.qname; homepage CDATA #IMPLIED>

<!ENTITY % CNXML.maintainerlist.content "(%CNXML.maintainer.qname;)+">
<!ELEMENT %CNXML.maintainerlist.qname; %CNXML.maintainerlist.content;>
          <!ATTLIST %CNXML.maintainerlist.qname; %CNXML.xmlns.attrib;>

<!ENTITY % CNXML.maintainer.content "((%CNXML.honorific.qname;)?, %CNXML.firstname.qname;, (%CNXML.othername.qname;)*, %CNXML.surname.qname;, (%CNXML.lineage.qname;)?, (%CNXML.email.qname;)?)">
<!ELEMENT %CNXML.maintainer.qname; %CNXML.maintainer.content;>
          <!ATTLIST %CNXML.maintainer.qname; %CNXML.xmlns.attrib;>
	  <!ATTLIST %CNXML.maintainer.qname; id CDATA #REQUIRED>
	  <!ATTLIST %CNXML.maintainer.qname; homepage CDATA #IMPLIED>

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

<!ENTITY % CNXML.cite.content "(%CNXML.textlike;)*">
<!ELEMENT %CNXML.cite.qname; %CNXML.cite.content;>
          <!ATTLIST %CNXML.cite.qname; %CNXML.xmlns.attrib;>

<!ENTITY % CNXML.keywordlist.content "(%CNXML.keyword.qname;)+">
<!ELEMENT %CNXML.keywordlist.qname; %CNXML.keywordlist.content;>
          <!ATTLIST %CNXML.keywordlist.qname; %CNXML.xmlns.attrib;>

<!ENTITY % CNXML.keyword.content "(#PCDATA)">
<!ELEMENT %CNXML.keyword.qname; %CNXML.keyword.content;>
          <!ATTLIST %CNXML.keyword.qname; %CNXML.xmlns.attrib;>

<!ENTITY % CNXML.section.content "(%CNXML.name.qname;, (%CNXML.section.qname;|%CNXML.definition.qname;|%CNXML.para.qname;|%CNXML.equation.qname;|%CNXML.list.qname;|%CNXML.codeblock.qname;|%CNXML.figure.qname;|%CNXML.table.qname;|%CNXML.example.qname;|%CNXML.exercise.qname;|%CNXML.rule.qname;)+)">
<!ELEMENT %CNXML.section.qname; %CNXML.section.content;>
          <!ATTLIST %CNXML.section.qname; %CNXML.xmlns.attrib;>
	  <!ATTLIST %CNXML.section.qname; id ID #REQUIRED>

<!ENTITY % CNXML.para.content "(%CNXML.textlike;|%CNXML.list.qname;|%CNXML.equation.qname;|%CNXML.definition.qname;|%CNXML.note.qname;|%CNXML.rule.qname;)*">
<!ELEMENT %CNXML.para.qname; %CNXML.para.content;>
          <!ATTLIST %CNXML.para.qname; %CNXML.xmlns.attrib;>
	  <!ATTLIST %CNXML.para.qname; id ID #REQUIRED>

<!ENTITY % CNXML.cnxn.content "(%CNXML.textlike;)*">
<!ELEMENT %CNXML.cnxn.qname; %CNXML.cnxn.content;>
          <!ATTLIST %CNXML.cnxn.qname; %CNXML.xmlns.attrib;>
          <!ATTLIST %CNXML.cnxn.qname; target  CDATA #IMPLIED>
          <!ATTLIST %CNXML.cnxn.qname; module  CDATA #IMPLIED>
          <!ATTLIST %CNXML.cnxn.qname; version CDATA #IMPLIED>
          <!ATTLIST %CNXML.cnxn.qname; strength (0|1|2|3|4|5|6|7|8|9) #REQUIRED>

<!ENTITY % CNXML.link.content "(%CNXML.textlike;)*">
<!ELEMENT %CNXML.link.qname; %CNXML.link.content;>
          <!ATTLIST %CNXML.link.qname; %CNXML.xmlns.attrib;>
          <!ATTLIST %CNXML.link.qname; src CDATA #REQUIRED>

<!ENTITY % CNXML.equation.content "(#PCDATA|%CNXML.name.qname;|%CNXML.media.qname;)*">
<!ELEMENT %CNXML.equation.qname; %CNXML.equation.content;>
          <!ATTLIST %CNXML.equation.qname; %CNXML.xmlns.attrib;>
	  <!ATTLIST %CNXML.equation.qname; id ID #REQUIRED>

<!ENTITY % CNXML.note.content "(%CNXML.textlike;)*">
<!ELEMENT %CNXML.note.qname; %CNXML.note.content;>
          <!ATTLIST %CNXML.note.qname; %CNXML.xmlns.attrib;>
          <!ATTLIST %CNXML.note.qname; type CDATA #IMPLIED>

<!ENTITY % CNXML.emphasis.content "(%CNXML.textlike;)*">
<!ELEMENT %CNXML.emphasis.qname; %CNXML.emphasis.content;>
          <!ATTLIST %CNXML.emphasis.qname; %CNXML.xmlns.attrib;>

<!ENTITY % CNXML.list.content "((%CNXML.name.qname;)?,(%CNXML.item.qname;)+)">
<!ELEMENT %CNXML.list.qname; %CNXML.list.content;>
          <!ATTLIST %CNXML.list.qname; %CNXML.xmlns.attrib;>
          <!ATTLIST %CNXML.list.qname; id ID #REQUIRED>
          <!ATTLIST %CNXML.list.qname; type (enumerated | bulleted) "bulleted">

<!ENTITY % CNXML.item.content "(%CNXML.textlike;|%CNXML.definition.qname;|%CNXML.list.qname;|%CNXML.note.qname;|%CNXML.rule.qname;|%CNXML.equation.qname;)*">
<!ELEMENT %CNXML.item.qname; %CNXML.item.content;>
          <!ATTLIST %CNXML.item.qname; %CNXML.xmlns.attrib;>
          <!ATTLIST %CNXML.item.qname; id ID #IMPLIED>

<!ENTITY % CNXML.codeblock.content "(%CNXML.textlike;)*">
<!ELEMENT %CNXML.codeblock.qname; %CNXML.codeblock.content;>
          <!ATTLIST %CNXML.codeblock.qname; %CNXML.xmlns.attrib;>
          <!ATTLIST %CNXML.codeblock.qname; id ID #IMPLIED>

<!ENTITY % CNXML.codeline.content "(%CNXML.textlike;)*">
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

<!ENTITY % CNXML.caption.content "(%CNXML.textlike;)*">
<!ELEMENT %CNXML.caption.qname; %CNXML.caption.content;>
          <!ATTLIST %CNXML.caption.qname; %CNXML.xmlns.attrib;>

<!ENTITY % CNXML.example.content "((%CNXML.name.qname;)?, (%CNXML.para.qname;|%CNXML.equation.qname;|%CNXML.list.qname;|%CNXML.codeblock.qname;|%CNXML.figure.qname;|%CNXML.table.qname;)+)">
<!ELEMENT %CNXML.example.qname; %CNXML.example.content;>
          <!ATTLIST %CNXML.example.qname; %CNXML.xmlns.attrib;>
          <!ATTLIST %CNXML.example.qname; id ID #REQUIRED>       

<!ENTITY % CNXML.exercise.content "(%CNXML.problem.qname;, %CNXML.solution.qname;)">
<!ELEMENT %CNXML.exercise.qname; %CNXML.exercise.content;>
          <!ATTLIST %CNXML.exercise.qname; %CNXML.xmlns.attrib;>
          <!ATTLIST %CNXML.exercise.qname; id ID #REQUIRED>

<!ENTITY % CNXML.problem.content "(%CNXML.definition.qname;|%CNXML.para.qname;|%CNXML.equation.qname;|%CNXML.list.qname;|%CNXML.codeblock.qname;|%CNXML.figure.qname;|%CNXML.table.qname;|%CNXML.rule.qname;)+">
<!ELEMENT %CNXML.problem.qname; %CNXML.problem.content;>
          <!ATTLIST %CNXML.problem.qname; %CNXML.xmlns.attrib;>

<!ENTITY % CNXML.solution.content "(%CNXML.para.qname;|%CNXML.equation.qname;|%CNXML.list.qname;|%CNXML.codeblock.qname;|%CNXML.figure.qname;|%CNXML.table.qname;)+">
<!ELEMENT %CNXML.solution.qname; %CNXML.solution.content;>
          <!ATTLIST %CNXML.solution.qname; %CNXML.xmlns.attrib;>

<!ENTITY % CNXML.abstract.content "(%CNXML.textlike;)*">
<!ELEMENT %CNXML.abstract.qname; %CNXML.abstract.content;>
          <!ATTLIST %CNXML.abstract.qname; %CNXML.xmlns.attrib;>

<!ENTITY % CNXML.objectives.content "(%CNXML.textlike;|%CNXML.list.qname;)*">
<!ELEMENT %CNXML.objectives.qname; %CNXML.objectives.content;>
          <!ATTLIST %CNXML.objectives.qname; %CNXML.xmlns.attrib;>

<!ENTITY % CNXML.definition.content "(%CNXML.term.qname;, (%CNXML.meaning.qname;, (%CNXML.example.qname;)*)+)">
<!ELEMENT %CNXML.definition.qname; %CNXML.definition.content;>
          <!ATTLIST %CNXML.definition.qname; %CNXML.xmlns.attrib;>
          <!ATTLIST %CNXML.definition.qname; id ID #REQUIRED>

<!ENTITY % CNXML.term.content "(%CNXML.textlike;)*">
<!ELEMENT %CNXML.term.qname; %CNXML.term.content;>
          <!ATTLIST %CNXML.term.qname; %CNXML.xmlns.attrib;>

<!ENTITY % CNXML.meaning.content "(%CNXML.textlike;|%CNXML.equation.qname;)*">
<!ELEMENT %CNXML.meaning.qname; %CNXML.meaning.content;>
          <!ATTLIST %CNXML.meaning.qname; %CNXML.xmlns.attrib;>

<!ENTITY % CNXML.rule.content "((%CNXML.name.qname;)?, (%CNXML.statement.qname;)+, (%CNXML.proof.qname;|%CNXML.example.qname;)*)">
<!ELEMENT %CNXML.rule.qname; %CNXML.rule.content;>
          <!ATTLIST %CNXML.rule.qname; %CNXML.xmlns.attrib;>
          <!ATTLIST %CNXML.rule.qname; id ID #REQUIRED>
          <!ATTLIST %CNXML.rule.qname; type CDATA #REQUIRED>

<!ENTITY % CNXML.statement.content "(%CNXML.para.qname;|%CNXML.equation.qname;)+">
<!ELEMENT %CNXML.statement.qname; %CNXML.statement.content;>
          <!ATTLIST %CNXML.statement.qname; %CNXML.xmlns.attrib;>
          <!ATTLIST %CNXML.statement.qname; id ID #IMPLIED>

<!ENTITY % CNXML.proof.content "((%CNXML.name.qname;)?, (%CNXML.rule.qname;|%CNXML.para.qname;|%CNXML.equation.qname;|%CNXML.figure.qname;|%CNXML.list.qname;)+)">
<!ELEMENT %CNXML.proof.qname; %CNXML.proof.content;>
          <!ATTLIST %CNXML.proof.qname; %CNXML.xmlns.attrib;>
          <!ATTLIST %CNXML.proof.qname; id ID #IMPLIED>

<!-- CALS Table -->

<!-- These definitions are not directly related to the table model,
but are used in the default CALS table model and are usually defined
elsewhere (and prior to the inclusion of this table module) in a CALS
DTD.  -->

<!ENTITY % bodyatt "">
<!ENTITY % secur "">

<!-- no if zero(s), yes if any other digits value -->

<!ENTITY % yesorno 'CDATA'>

<!--
The parameter entities as defined below provide the CALS table model
as published (as part of the Example DTD) in MIL-HDBK-28001.

These following declarations provide the CALS-compliant default definitions
for these entities.  However, these entities can and should be redefined
(by giving the appropriate parameter entity declaration(s) prior to the
reference to this Table Model declaration set entity) to fit the needs
of the current application.
-->

<!ENTITY % CNXML.table.name       "%CNXML.table.qname;">
<!ENTITY % CNXML.table-main.mdl   "%CNXML.tgroup.qname;+">
<!ENTITY % CNXML.table.mdl        "%CNXML.name.qname;?, %CNXML.table-main.mdl;">
<!ENTITY % CNXML.table.att        '
    id		ID		#REQUIRED       
    tabstyle    CDATA           #IMPLIED
    tocentry    %yesorno;       #IMPLIED
    shortentry  %yesorno;       #IMPLIED
    orient      (port|land)     #IMPLIED
    pgwide      %yesorno;       #IMPLIED '>
<!ENTITY % CNXML.tgroup.mdl       "%CNXML.colspec.qname;*,%CNXML.spanspec.qname;*,%CNXML.thead.qname;?,%CNXML.tfoot.qname;?,%CNXML.tbody.qname;">
<!ENTITY % CNXML.tgroup.att       'tgroupstyle CDATA #IMPLIED'>
<!ENTITY % CNXML.hdft.mdl         "%CNXML.colspec.qname;*,%CNXML.row.qname;+">
<!ENTITY % CNXML.row.mdl          "(%CNXML.entry.qname;|%CNXML.entrytbl.qname;)+">
<!ENTITY % CNXML.entrytbl.mdl     "%CNXML.colspec.qname;*,%CNXML.spanspec.qname;*,%CNXML.thead.qname;?,%CNXML.tbody.qname;">

<!ENTITY % CNXML.entry.mdl        "(%CNXML.textlike;|%CNXML.media.qname;)*">

<!-- =====  Element and attribute declarations follow. =====  -->

<!ELEMENT %CNXML.table.qname; (%CNXML.table.mdl;)>

<!ATTLIST %CNXML.table.qname;
        frame           (top|bottom|topbot|all|sides|none)      #IMPLIED
        colsep          %yesorno;                               #IMPLIED
        rowsep          %yesorno;                               #IMPLIED
        %CNXML.table.att;
        %bodyatt;
        %secur;
>

<!ELEMENT %CNXML.tgroup.qname; (%CNXML.tgroup.mdl;) >

<!ATTLIST %CNXML.tgroup.qname;
        cols            CDATA                                   #REQUIRED
        %CNXML.tgroup.att;
        colsep          %yesorno;                               #IMPLIED
        rowsep          %yesorno;                               #IMPLIED
        align           (left|right|center|justify|char)        #IMPLIED
        char            CDATA                                   #IMPLIED
        charoff         CDATA                                   #IMPLIED
        %secur;
>

<!ELEMENT %CNXML.colspec.qname; EMPTY >

<!ATTLIST %CNXML.colspec.qname;
        colnum          CDATA                                   #IMPLIED
        colname         CDATA                                   #IMPLIED
        colwidth        CDATA                                   #IMPLIED
        colsep         	%yesorno;                               #IMPLIED
        rowsep          %yesorno;                               #IMPLIED
        align           (left|right|center|justify|char)        #IMPLIED
        char            CDATA                                   #IMPLIED
        charoff         CDATA                                   #IMPLIED
>

<!ELEMENT %CNXML.spanspec.qname; EMPTY >

<!ATTLIST %CNXML.spanspec.qname;
        namest         	CDATA                                   #REQUIRED
        nameend         CDATA                                   #REQUIRED
        spanname        CDATA                                   #REQUIRED
        colsep          %yesorno;                               #IMPLIED
        rowsep          %yesorno;                               #IMPLIED
        align           (left|right|center|justify|char)        #IMPLIED
        char            CDATA                                   #IMPLIED
        charoff         CDATA                                   #IMPLIED
>

<!ELEMENT %CNXML.thead.qname; (%CNXML.hdft.mdl;)>
<!ATTLIST %CNXML.thead.qname;
        valign          (top|middle|bottom)                     #IMPLIED
        %secur;
>

<!ELEMENT %CNXML.tfoot.qname; (%CNXML.hdft.mdl;)>
<!ATTLIST %CNXML.tfoot.qname;
        valign          (top|middle|bottom)                     #IMPLIED
        %secur;
>

<!ELEMENT %CNXML.tbody.qname; (row+)>

<!ATTLIST %CNXML.tbody.qname;
        valign          (top|middle|bottom)                     #IMPLIED
        %secur;
>

<!ELEMENT %CNXML.row.qname; (%CNXML.row.mdl;)>

<!ATTLIST %CNXML.row.qname;
        rowsep          %yesorno;                               #IMPLIED
        valign          (top|middle|bottom)                     #IMPLIED
        %secur;
>

<!ELEMENT %CNXML.entrytbl.qname; (%CNXML.entrytbl.mdl;)>

<!ATTLIST %CNXML.entrytbl.qname;
        cols            CDATA                                   #REQUIRED
        %CNXML.tgroup.att;
        colname         CDATA                                   #IMPLIED
        spanname        CDATA                                   #IMPLIED
        namest          CDATA                                   #IMPLIED
        nameend        	CDATA                                   #IMPLIED
        colsep          %yesorno;                               #IMPLIED
        rowsep          %yesorno;                               #IMPLIED
        align           (left|right|center|justify|char)        #IMPLIED
        char            CDATA                                   #IMPLIED
        charoff         CDATA                                   #IMPLIED
        %secur;
>

<!ELEMENT %CNXML.entry.qname; %CNXML.entry.mdl; >

<!ATTLIST %CNXML.entry.qname;
        colname         CDATA                                   #IMPLIED
        namest          CDATA                                   #IMPLIED
        nameend         CDATA                                   #IMPLIED
        spanname        CDATA                                   #IMPLIED
        morerows        CDATA                                   #IMPLIED
        colsep          %yesorno;                               #IMPLIED
        rowsep          %yesorno;                               #IMPLIED
        align           (left|right|center|justify|char)        #IMPLIED
        char            CDATA                                   #IMPLIED
        charoff         CDATA                                   #IMPLIED
        rotate          %yesorno;                               #IMPLIED
        valign          (top|middle|bottom)                     #IMPLIED
        %secur;
>