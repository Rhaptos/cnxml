<!-- DTD for the Connexions Markup Language (CNXML)            -->
<!-- Version 0.5                                               -->
<!--                                                           -->   
<!-- This entity may be identified by the following PUBLIC     -->
<!-- and SYSTEM identifiers                                    -->
<!--                                                           -->
<!-- PUBLIC:  -//CNX//ELEMENTS CNXML 0.5 Elements//EN          -->
<!-- SYSTEM:  http://cnx.rice.edu/technology/cnxml/schema/dtd/0.5/cnxml.mod      -->
<!--  xmlns:  http://cnx.rice.edu/cnxml                        -->
<!--                                                           -->
<!-- CVS Version: $Revision$                            -->
<!-- Modified: $Date$                    -->
<!-- Maintained by the CNXML langauge team                     -->
<!-- email: cnxml@cnx.rice.edu                                 -->
<!--                                                           -->

<!-- Define the global namespace attributes -->
<![%CNXML.prefixed;[
<!ENTITY % CNXML.xmlns.attrib
    "%NS.decl.attrib;"
>
]]>
<!ENTITY % CNXML.xmlns.attrib
    "xmlns CDATA #FIXED '%CNXML.xmlns;' %NS.decl.attrib;"
>

<!-- Define a common set of attributes for all document elements -->
<!ENTITY % CNXML.Common.attrib
         "%CNXML.xmlns.attrib;"
>

<!-- Pseudo datatype for URLs -->
<!ENTITY % CNXML.URL "CDATA">

<!-- Extra inline/text items.  May be redefined by other modules -->
<!ENTITY % CNXML.textextras "#PCDATA" >

<!-- Inline tags (with the exception of code) -->
<!ENTITY % CNXML.inline '%CNXML.textextras;|%CNXML.emphasis.qname;|%CNXML.term.qname;|%CNXML.cite.qname;|%CNXML.cnxn.qname;|%CNXML.link.qname;|%CNXML.quote.qname;|%CNXML.foreign.qname;'>

<!-- Structural tags -->
<!ENTITY % CNXML.structural "%CNXML.section.qname;|%CNXML.example.qname;">

<!-- Special tags with different content models -->
<!ENTITY % CNXML.special "%CNXML.definition.qname;|%CNXML.rule.qname;|%CNXML.figure.qname;|%CNXML.media.qname;|%CNXML.table.qname;|%CNXML.list.qname;|%CNXML.exercise.qname;|%CNXML.equation.qname;|%CNXML.note.qname;">

<!-- Structural content model -->
<!ENTITY % CNXML.structural.content "(%CNXML.name.qname;?, (%CNXML.structural;|%CNXML.special;|%CNXML.para.qname;|%CNXML.code.qname;)+)">

<!-- Inline content model -->
<!ENTITY % CNXML.inline.content "(%CNXML.inline;|%CNXML.code.qname;)*">

<!-- Define the elements and attributes of the document -->
<!ENTITY % CNXML.document.content "(%CNXML.name.qname;,%CNXML.metadata.qname;?,%CNXML.content.qname;, %CNXML.glossary.qname;?)">
<!ELEMENT %CNXML.document.qname; %CNXML.document.content; >
          <!ATTLIST %CNXML.document.qname; %CNXML.xmlns.attrib;>
	  <!ATTLIST %CNXML.document.qname; id ID #REQUIRED>

<!ENTITY % CNXML.metadata.content "ANY" >
<!ELEMENT %CNXML.metadata.qname; %CNXML.metadata.content; >
	  <!ATTLIST %CNXML.metadata.qname; %CNXML.xmlns.attrib;>

<!ENTITY % CNXML.content.content "(%CNXML.structural;|%CNXML.code.qname;|%CNXML.special;|%CNXML.para.qname;)+">
<!ELEMENT %CNXML.content.qname; %CNXML.content.content;>
          <!ATTLIST %CNXML.content.qname; %CNXML.xmlns.attrib;>
	  <!ATTLIST %CNXML.content.qname; id ID #IMPLIED>

<!ENTITY % CNXML.glossary.content "(%CNXML.definition.qname;)+">
<!ELEMENT %CNXML.glossary.qname; %CNXML.glossary.content; >
	  <!ATTLIST %CNXML.glossary.qname; %CNXML.xmlns.attrib;>
	  <!ATTLIST %CNXML.glossary.qname; id ID #IMPLIED>

<!ENTITY % CNXML.name.content "(#PCDATA)">
<!ELEMENT %CNXML.name.qname; %CNXML.name.content;>
          <!ATTLIST %CNXML.name.qname; %CNXML.xmlns.attrib;>
	  <!ATTLIST %CNXML.name.qname; id ID #IMPLIED>

<!ENTITY % CNXML.cite.content "%CNXML.inline.content;">
<!ELEMENT %CNXML.cite.qname; %CNXML.cite.content;>
          <!ATTLIST %CNXML.cite.qname; %CNXML.xmlns.attrib;>
	  <!ATTLIST %CNXML.cite.qname; id ID #IMPLIED>
	  <!ATTLIST %CNXML.cite.qname; src %CNXML.URL; #IMPLIED>

<!ENTITY % CNXML.section.content "%CNXML.structural.content;">
<!ELEMENT %CNXML.section.qname; %CNXML.section.content;>
          <!ATTLIST %CNXML.section.qname; %CNXML.xmlns.attrib;>
	  <!ATTLIST %CNXML.section.qname; id ID #IMPLIED>


<!-- %CNXML.name.qname; is only allowed as the first child --> 
<!ENTITY % CNXML.para.content "(%CNXML.inline;|%CNXML.code.qname;|%CNXML.special;|%CNXML.name.qname;)*">
<!ELEMENT %CNXML.para.qname; %CNXML.para.content;>
          <!ATTLIST %CNXML.para.qname; %CNXML.xmlns.attrib;>
	  <!ATTLIST %CNXML.para.qname; id ID #REQUIRED>

<!ENTITY % CNXML.cnxn.content "(#PCDATA)">
<!ELEMENT %CNXML.cnxn.qname; %CNXML.cnxn.content;>
          <!ATTLIST %CNXML.cnxn.qname; %CNXML.xmlns.attrib;>
          <!ATTLIST %CNXML.cnxn.qname; target CDATA #IMPLIED>
          <!ATTLIST %CNXML.cnxn.qname; document CDATA #IMPLIED>
          <!ATTLIST %CNXML.cnxn.qname; version CDATA #IMPLIED>
	  <!ATTLIST %CNXML.cnxn.qname; strength (0|1|2|3|4|5|6|7|8|9) #IMPLIED>
	  <!ATTLIST %CNXML.cnxn.qname; id ID #IMPLIED>

<!ENTITY % CNXML.link.content "%CNXML.inline.content;">
<!ELEMENT %CNXML.link.qname; %CNXML.link.content;>
          <!ATTLIST %CNXML.link.qname; %CNXML.xmlns.attrib;>
          <!ATTLIST %CNXML.link.qname; src %CNXML.URL; #REQUIRED>
	  <!ATTLIST %CNXML.link.qname; id ID #IMPLIED>

<!ENTITY % CNXML.equation.content "(#PCDATA|%CNXML.name.qname;|%CNXML.media.qname;)*">
<!ELEMENT %CNXML.equation.qname; %CNXML.equation.content;>
          <!ATTLIST %CNXML.equation.qname; %CNXML.xmlns.attrib;>
	  <!ATTLIST %CNXML.equation.qname; id ID #REQUIRED>

<!ENTITY % CNXML.note.content "%CNXML.inline.content;">
<!ELEMENT %CNXML.note.qname; %CNXML.note.content;>
          <!ATTLIST %CNXML.note.qname; %CNXML.xmlns.attrib;>
          <!ATTLIST %CNXML.note.qname; type CDATA #IMPLIED>
	  <!ATTLIST %CNXML.note.qname; id ID #IMPLIED>

<!ENTITY % CNXML.emphasis.content "%CNXML.inline.content;">
<!ELEMENT %CNXML.emphasis.qname; %CNXML.emphasis.content;>
          <!ATTLIST %CNXML.emphasis.qname; %CNXML.xmlns.attrib;>
	  <!ATTLIST %CNXML.emphasis.qname; id ID #IMPLIED>

<!ENTITY % CNXML.list.content "((%CNXML.name.qname;)?,(%CNXML.item.qname;)+)">
<!ELEMENT %CNXML.list.qname; %CNXML.list.content;>
          <!ATTLIST %CNXML.list.qname; %CNXML.xmlns.attrib;>
          <!ATTLIST %CNXML.list.qname; id ID #REQUIRED>
          <!ATTLIST %CNXML.list.qname; type CDATA #IMPLIED>


<!-- Name is listed as a child at any point but it is really only
allowed as the first child -->
<!ENTITY % CNXML.item.content "(%CNXML.inline;|%CNXML.code.qname;|%CNXML.special;|%CNXML.name.qname;)*">
<!ELEMENT %CNXML.item.qname; %CNXML.item.content;>
          <!ATTLIST %CNXML.item.qname; %CNXML.xmlns.attrib;>
          <!ATTLIST %CNXML.item.qname; id ID #IMPLIED>

<!ENTITY % CNXML.code.content "%CNXML.inline.content;">
<!ELEMENT %CNXML.code.qname; %CNXML.code.content;>
          <!ATTLIST %CNXML.code.qname; %CNXML.xmlns.attrib;>  
          <!ATTLIST %CNXML.code.qname; id ID #IMPLIED>
	  <!ATTLIST %CNXML.code.qname; type (inline | block) 'inline'>

<!ENTITY % CNXML.media.content "(PCDATA|(%CNXML.param.qname;*,%CNXML.media.qname;?))">
<!ELEMENT %CNXML.media.qname; %CNXML.media.content;>
          <!ATTLIST %CNXML.media.qname; %CNXML.xmlns.attrib;>
          <!ATTLIST %CNXML.media.qname; type CDATA #REQUIRED>
          <!ATTLIST %CNXML.media.qname; src %CNXML.URL; #REQUIRED>
	  <!ATTLIST %CNXML.media.qname; id ID #IMPLIED>

<!ENTITY % CNXML.param.content "EMPTY">
<!ELEMENT %CNXML.param.qname; %CNXML.param.content;>
	  <!ATTLIST %CNXML.param.qname; name CDATA #REQUIRED>
	  <!ATTLIST %CNXML.param.qname; value CDATA #REQUIRED>


<!ENTITY % CNXML.figure.content "((%CNXML.name.qname;)?, ((%CNXML.subfigure.qname;, (%CNXML.subfigure.qname;)+)|%CNXML.media.qname;|%CNXML.table.qname;|%CNXML.code.qname;), (%CNXML.caption.qname;)?)">
<!ELEMENT %CNXML.figure.qname; %CNXML.figure.content;>
          <!ATTLIST %CNXML.figure.qname; %CNXML.xmlns.attrib;>
	  <!ATTLIST %CNXML.figure.qname; id ID #IMPLIED>
          <!ATTLIST %CNXML.figure.qname; orient (vertical|horizontal) "horizontal">

<!ENTITY % CNXML.subfigure.content "((%CNXML.name.qname;)?, (%CNXML.media.qname;|%CNXML.table.qname;|%CNXML.code.qname;), (%CNXML.caption.qname;)?)">
<!ELEMENT %CNXML.subfigure.qname; %CNXML.subfigure.content;>
          <!ATTLIST %CNXML.subfigure.qname; %CNXML.xmlns.attrib;>
          <!ATTLIST %CNXML.subfigure.qname; id ID #IMPLIED>

<!ENTITY % CNXML.caption.content "%CNXML.inline.content;">
<!ELEMENT %CNXML.caption.qname; %CNXML.caption.content;>
          <!ATTLIST %CNXML.caption.qname; %CNXML.xmlns.attrib;>
	  <!ATTLIST %CNXML.caption.qname; id ID #IMPLIED>

<!ENTITY % CNXML.example.content "%CNXML.structural.content;">
<!ELEMENT %CNXML.example.qname; %CNXML.example.content;>
          <!ATTLIST %CNXML.example.qname; %CNXML.xmlns.attrib;>
          <!ATTLIST %CNXML.example.qname; id ID #IMPLIED>       

<!ENTITY % CNXML.exercise.content "((%CNXML.name.qname;)?, %CNXML.problem.qname;, (%CNXML.solution.qname;)*)">
<!ELEMENT %CNXML.exercise.qname; %CNXML.exercise.content;>
          <!ATTLIST %CNXML.exercise.qname; %CNXML.xmlns.attrib;>
          <!ATTLIST %CNXML.exercise.qname; id ID #REQUIRED>

<!ENTITY % CNXML.problem.content "%CNXML.structural.content;">
<!ELEMENT %CNXML.problem.qname; %CNXML.problem.content;>
          <!ATTLIST %CNXML.problem.qname; %CNXML.xmlns.attrib;>
	  <!ATTLIST %CNXML.problem.qname; id ID #IMPLIED>

<!ENTITY % CNXML.solution.content "%CNXML.structural.content;">
<!ELEMENT %CNXML.solution.qname; %CNXML.solution.content;>
          <!ATTLIST %CNXML.solution.qname; %CNXML.xmlns.attrib;>
	  <!ATTLIST %CNXML.solution.qname; id ID #IMPLIED>

<!ENTITY % CNXML.definition.content "(%CNXML.term.qname;, (%CNXML.meaning.qname;, (%CNXML.example.qname;)*, (%CNXML.seealso.qname;)?)+)">
<!ELEMENT %CNXML.definition.qname; %CNXML.definition.content;>
          <!ATTLIST %CNXML.definition.qname; %CNXML.xmlns.attrib;>
          <!ATTLIST %CNXML.definition.qname; id ID #REQUIRED>

<!ENTITY % CNXML.term.content "%CNXML.inline.content;">
<!ELEMENT %CNXML.term.qname; %CNXML.term.content;>
          <!ATTLIST %CNXML.term.qname; %CNXML.xmlns.attrib;>
	  <!ATTLIST %CNXML.term.qname; id ID #IMPLIED>
	  <!ATTLIST %CNXML.term.qname; src %CNXML.URL; #IMPLIED>

<!-- Name not really allowed anywhere in meaning, only as first child -->
<!ENTITY % CNXML.meaning.content "(%CNXML.inline;|%CNXML.code.qname;|%CNXML.special;|%CNXML.name.qname;)*">
<!ELEMENT %CNXML.meaning.qname; %CNXML.meaning.content;>
          <!ATTLIST %CNXML.meaning.qname; %CNXML.xmlns.attrib;>
	  <!ATTLIST %CNXML.meaning.qname; id ID #IMPLIED>

<!ENTITY % CNXML.seealso.content "(%CNXML.term.qname;)+">
<!ELEMENT %CNXML.seealso.qname; %CNXML.seealso.content;> 
	  <!ATTLIST %CNXML.seealso.qname; %CNXML.xmlns.attrib;>

<!ENTITY % CNXML.rule.content "((%CNXML.name.qname;)?, (%CNXML.statement.qname;)+, (%CNXML.proof.qname;|%CNXML.example.qname;)*)">
<!ELEMENT %CNXML.rule.qname; %CNXML.rule.content;>
          <!ATTLIST %CNXML.rule.qname; %CNXML.xmlns.attrib;>
          <!ATTLIST %CNXML.rule.qname; id ID #REQUIRED>
          <!ATTLIST %CNXML.rule.qname; type CDATA #REQUIRED>

<!ENTITY % CNXML.statement.content "%CNXML.structural.content;">
<!ELEMENT %CNXML.statement.qname; %CNXML.statement.content;>
          <!ATTLIST %CNXML.statement.qname; %CNXML.xmlns.attrib;>
          <!ATTLIST %CNXML.statement.qname; id ID #IMPLIED>

<!ENTITY % CNXML.proof.content "%CNXML.structural.content;">
<!ELEMENT %CNXML.proof.qname; %CNXML.proof.content;>
          <!ATTLIST %CNXML.proof.qname; %CNXML.xmlns.attrib;>
          <!ATTLIST %CNXML.proof.qname; id ID #IMPLIED>

<!ENTITY % CNXML.quote.content "%CNXML.inline.content;">
<!ELEMENT %CNXML.quote.qname; %CNXML.quote.content;>
	  <!ATTLIST %CNXML.quote.qname; %CNXML.xmlns.attrib;>
	  <!ATTLIST %CNXML.quote.qname; type CDATA "inline">
	  <!ATTLIST %CNXML.quote.qname; src %CNXML.URL; #IMPLIED>
	  <!ATTLIST %CNXML.quote.qname; id ID #IMPLIED>

<!ENTITY % CNXML.foreign.content "%CNXML.inline.content;">
<!ELEMENT %CNXML.foreign.qname; %CNXML.foreign.content;>
	  <!ATTLIST %CNXML.foreign.qname; %CNXML.xmlns.attrib;>
	  <!ATTLIST %CNXML.foreign.qname; src %CNXML.URL; #IMPLIED>
	  <!ATTLIST %CNXML.foreign.qname; id ID #IMPLIED>      

<!-- CALS Table -->

<!-- These definitions are not directly related to the table model,
but are used in the default CALS table model and are usually defined
elsewhere (and prior to the inclusion of this table document) in a CALS
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
<!ENTITY % CNXML.table.mdl        "%CNXML.name.qname;?, %CNXML.table-main.mdl;, %CNXML.caption.qname;?">
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

<!ENTITY % CNXML.entry.mdl        "(%CNXML.inline;|%CNXML.media.qname;|%CNXML.code.qname;)*">

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