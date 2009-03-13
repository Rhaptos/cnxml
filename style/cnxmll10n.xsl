<?xml version="1.0"?>

<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  
  <!-- Begin section of translations for english text that appear in this file-->
  <xsl:param name="local.l10n.xml" select="document('')"/>
  <l:i18n xmlns:l="http://docbook.sourceforge.net/xmlns/l10n/1.0">
    <l:l10n language="en" english-language-name="English">
      <!-- for cnxml_render.xsl -->
      <l:gentext key="subfigure" text="Subfigure"/>
      <l:gentext key="Subfigure" text="Subfigure"/>
      <l:gentext key="problem" text="Problem"/>
      <l:gentext key="Problem" text="Problem"/>
      <l:gentext key="exercise" text="Exercise"/>
      <l:gentext key="Exercise" text="Exercise"/>
      <l:gentext key="solution" text="Solution"/>
      <l:gentext key="para" text="Paragraph"/>
      <l:gentext key="statement" text="Statement"/>
      <l:gentext key="rule" text="Rule"/>
      <l:gentext key="definition" text="Definition"/>
      <l:gentext key="meaning" text="Meaning"/>
      <l:gentext key="list" text="List"/>
      <l:gentext key="item" text="Item"/>
      <l:gentext key="caption" text="Caption"/>
      <l:gentext key="media" text="Media"/>
      <l:gentext key="param" text="Param"/>
      <l:gentext key="emphasis" text="Emphasis"/>
      <l:gentext key="quote" text="Quote"/>
      <l:gentext key="foreign" text="Foreign"/>
      <l:gentext key="code" text="Code"/>
      <l:gentext key="cnxn" text="Cnxn"/>
      <l:gentext key="link" text="Link"/>
      <l:gentext key="cite" text="Cite"/>
      <l:gentext key="term" text="Term"/>
      <l:gentext key="name" text="Name"/>
      <l:gentext key="tgroup" text="Tgroup"/>
      <l:gentext key="colspec" text="Colspec"/>
      <l:gentext key="spanspec" text="Spanspec"/>
      <l:gentext key="thead" text="Thead"/>
      <l:gentext key="tfoot" text="Tfoot"/>
      <l:gentext key="tbody" text="Tbody"/>
      <l:gentext key="row" text="Row"/>
      <l:gentext key="entrytbl" text="Entrytbl"/>
      <l:gentext key="entry" text="Entry"/>
      <l:gentext key="Strength" text="Strength"/>
      <l:gentext key="Definition" text="Definition"/>
      <l:gentext key="Proof" text="Proof"/>
      <l:gentext key="MediaFile" text="Media File"/>
      <l:gentext key="LabVIEWExample" text="LabVIEW Example"/>
      <l:gentext key="Download" text="Download"/>
      <l:gentext key="LabVIEWSource" text="LabVIEW Source"/>
      <l:gentext key="AudioFile" text="Audio File"/>
      <l:gentext key="MusicalExample" text="Musical Example"/>
      <l:gentext key="Show" text="Show"/>
      <l:gentext key="Hide" text="Hide"/>
      <l:gentext key="Solution" text="Solution"/>
      <l:gentext key="Diagnosis" text="Diagnosis"/>
      <l:gentext key="Footnotes" text="Footnotes"/>
      <l:gentext key="warning" text="Warning"/>
      <l:gentext key="important" text="Important"/>
      <l:gentext key="aside" text="Aside"/>
      <l:gentext key="tip" text="Tip"/>
      <l:gentext key="Note" text="Note"/>
      <l:gentext key="theorem" text="Theorem"/>
      <l:gentext key="lemma" text="Lemma"/>
      <l:gentext key="corollary" text="Corollary"/>
      <l:gentext key="law" text="Law"/>
      <l:gentext key="proposition" text="Proposition"/>
      <l:gentext key="Rule" text="Rule"/>
      <l:gentext key="Step" text="Step"/>
      <l:gentext key="Listing" text="Listing"/>
      <l:gentext key="citelink" text="link"/>

      <!-- for content_render.xsl -->
      <l:gentext key="Translators:" text="Translators:"/>
      <l:gentext key="Translators" text="Translators"/>
      <l:gentext key="Translated By" text="Translated by:"/>
      <l:gentext key="Editors:" text="Editors:"/>
      <l:gentext key="Editors" text="Editors"/>
      <l:gentext key="Edited By" text="Edited by:"/>
      <l:gentext key="By" text="By: "/>
      <l:gentext key="BasedOn" text="Based on:"/>
      <l:gentext key="Summary" text="Summary:"/>
      <l:gentext key="viewingoldversion" text="You are viewing an old version of this document."/>
      <l:gentext key="latestversionhere" text="The latest version is available here."/>
      <l:gentext key="Thisisapreview_start" text="This is a preview of how your module will appear when published"/>
      <l:gentext key="Thisisapreview_finish" text="."/>
      <l:gentext key="commaassumingthatall" text=", assuming that all"/>
      <l:gentext key="pendingrolerequests" text="currently pending role requests"/>
      <l:gentext key="areaccepted" text="are accepted"/>
      <l:gentext key="returntoediting" text="You must return to the editing interface to"/>
      <l:gentext key="edit" text="edit"/>
      <l:gentext key="or" text="or"/>
      <l:gentext key="publish" text="publish"/>
      <l:gentext key="yourchanges" text="your changes."/>
      <l:gentext key="youmayview" text="You may view the"/>
      <l:gentext key="latestpublishedversion" text="latest published version"/>
      <l:gentext key="hereanda" text="here and a"/>
      <l:gentext key="listofchanges" text="list of changes"/>
      <l:gentext key="hereperiod" text="here."/>
      <l:gentext key="CollectionNavigation" text="Collection Navigation" />
      <l:gentext key="Previousmodule" text="&#171; Previous module"/>
      <l:gentext key="Nextmodule" text="Next module"/>
      <l:gentext key="incollection" text="in collection"/>
      <l:gentext key="Collectionhome" text="Collection home: "/>
      <l:gentext key="Commentsquestionsfeedback" text="Comments, questions, feedback, criticisms?"/>
      <l:gentext key="Discussionforum" text="Discussion forum"/>
      <l:gentext key="Jointhediscussion" text="Join the discussion &#187;"/>
      <l:gentext key="Sendfeedback" text="Send feedback"/>
      <l:gentext key="Emailtheauthors" text="E-mail the authors"/>
      <l:gentext key="Emailtheauthor" text="E-mail the author"/>
      <l:gentext key="Email" text="E-mail "/>
      <l:gentext key="Relatedmaterial" text="Related material"/>
      <l:gentext key="Recently" text="Recently"/>
      <l:gentext key="Viewed" text="Viewed"/>
      <l:gentext key="Example links" text="Example links"/>
      <l:gentext key="Prerequisite links" text="Prerequisite links"/>
      <l:gentext key="Supplemental links" text="Supplemental links"/>
      <l:gentext key="Stronglink" text="Strongly related link"/>
      <l:gentext key="Relatedlink" text="Related link"/>
      <l:gentext key="Weaklink" text="Weakly related link"/>
      <l:gentext key="Downloadellipsis" text="Download PDF/ZIP..."/>
      <l:gentext key="Downloadcolon" text="Download:"/>
      <l:gentext key="ThePDFofthemodulecomma" text="The PDF of the module,"/>
      <l:gentext key="ThePDFofthecollectioncomma" text="The PDF of the collection,"/>
      <l:gentext key="AZIPfileofthecollectioncomma" text="A ZIP file containing all the multimedia files in the collection,"/>
      <l:gentext key="LinktoPDFformat" text="Link to printer-friendly PDF format"/>
      <l:gentext key="LinktoZIPfile" text="Link to ZIP file of any images and interactive media"/>
      <l:gentext key="DownloadmodulePDF" text="Download module PDF"/>
      <l:gentext key="DownloadcollectionPDF" text="Download collection PDF"/>
      <l:gentext key="DownloadcollectionmultimediaZIP" text="Download collection multimedia ZIP"/>
      <l:gentext key="mZIPexplanationopening" text="The multimedia ZIP file provides offline access to all the multimedia files that are not available in the printed version (PDF) of this collection."/>
      <l:gentext key="Toaccessthefilescolon" text="To access the files:"/>
      <l:gentext key="downloadtheZIP" text="download the ZIP"/>
      <l:gentext key="extractallthefiles" text="extract all of its files to a location on your hard drive"/>
      <l:gentext key="opentheREADME" text="open the README file for instructions or go directly to mediafiles.html file in your Web browser"/>
      <l:gentext key="ModulePDF" text="Module PDF"/>
      <l:gentext key="CollectionPDF" text="Collection PDF"/>
      <l:gentext key="CollectionmultimediaZIP" text="Collection multimedia ZIP"/>
      <l:gentext key="HowdoIusethemultimediazipfile" text="How do I use the multimedia ZIP file"/>
      <l:gentext key="PrintthisWebpage" text="Print this Web page"/>
      <l:gentext key="Emailtheauthormaybepluralellipsis" text="E-mail the author(s) ..."/>
      <l:gentext key="Emailauthorof" text="E-mail the author(s) of:" />
      <l:gentext key="Thismodulecomma" text="This module," />
      <l:gentext key="Thiscollectioncomma" text="This collection," />
      <l:gentext key="ofthemodule" text="of the module" />
      <l:gentext key="ofthecollection" text="of the collection" />
      <l:gentext key="ofthiscontent" text="of this content" />
      <l:gentext key="Feedbackon" text="Feedback on" />
      <l:gentext key="modulecolon" text="module:" />
      <l:gentext key="collectioncolon" text="collection:" />
      <l:gentext key="asusedincollection" text="as used in collection:" />
      <l:gentext key="commamodule" text=", module:" />
      <l:gentext key="Similarcontent" text="Similar content"/>
      <l:gentext key="Moresimilarcontent" text="More links to similar content"/>
      <l:gentext key="More" text="More"/>
      <l:gentext key="similarcontent" text="similar content"/>
      <l:gentext key="Collectionsusingthismodule" text="Collections using this module"/>
      <l:gentext key="Othercollectionsusingthismodule" text="Other collections using this module"/>
      <l:gentext key="Morecollectionsusingthismodule" text="More collections using this module"/>
      <l:gentext key="Personalize" text="Personalize"/>
      <l:gentext key="Chooseastyle" text="Choose a style"/>
      <l:gentext key="EditInPlace" text="Edit-In-Place"/>
      <l:gentext key="Editthiscontent" text="Edit this content"/>
      <l:gentext key="authoronly" text=" (author only)"/>
      <l:gentext key="MoreAboutThisContent" text="More about this content: "/>
      <l:gentext key="Metadata" text="Metadata"/>
      <l:gentext key="VersionHistory" text="Version History"/>
      <l:gentext key="Howto" text="How to"/>
      <l:gentext key="reuse" text="reuse"/>
      <l:gentext key="cite_verb" text="cite"/>
      <l:gentext key="andattributethiscontent" text="and attribute this content"/>
      <l:gentext key="Worklicensedby" text="This work is licensed by"/>
      <l:gentext key="and" text="and"/>
      <l:gentext key="comma" text=", "/>
      <l:gentext key="undera" text="under a"/>
      <l:gentext key="CreativeCommonsAttributionLicense" text="Creative Commons Attribution License"/>
      <l:gentext key="period" text=". "/>
      <l:gentext key="Lasteditedby" text="Last edited by"/>
      <l:gentext key="on" text="on"/>
      <l:gentext key="Search" text="Search"/>
      <l:gentext key="Searchcolon" text="Search: "/>
      <l:gentext key="Home" text="Home"/>
      <l:gentext key="AboutUs" text="About Us"/>
      <l:gentext key="Help" text="Help"/>
      <l:gentext key="MyCNX" text="MyCNX"/>
      <l:gentext key="ContentActions" text="Content Actions"/>
      <l:gentext key="parensquestion" text="(?)"/>
      <l:gentext key="questionmark" text="?"/>
      <l:gentext key="EndorsedBy" text="Endorsed by"/>
      <l:gentext key="Whatdoesendorsedbymean" text='What does "Endorsed by" mean'/>
      <l:gentext key="AffiliatedWith" text="Affiliated with"/>
      <l:gentext key="Whatdoesaffiliatedwithmean" text='What does "Affiliated with" mean'/>
      <l:gentext key="Definitionofalens" text="Definition of a lens"/>
      <l:gentext key="Lenses" text="Lenses"/>
      <l:gentext key="AddLens" text="Add to a lens"/>
      <l:gentext key="Intheselenses" text="In these lenses" />
      <l:gentext key="Alsointheselenses" text="Also in these lenses" />
      <l:gentext key="Tags" text="Tags"/>
      <l:gentext key="Whatisatag" text="What is a tag"/>
      <l:gentext key="Addtoellipsis" text="Add to ..."/>
      <l:gentext key="Addmoduleorcollectionto" text="Add either the module or the collection to:"/>
      <l:gentext key="Addmoduleto" text="Add the module to:"/>
      <l:gentext key="MyFavorites" text="My Favorites"/>
      <l:gentext key="Alens" text="A lens"/>
      <l:gentext key="Anexternalsocialbookmarkingservice" text="An external social bookmarking service"/>
      <l:gentext key="Externalbookmarks" text="External bookmarks"/>
      <l:gentext key="Addmoduletocolon" text="Add module to:"/>
      <l:gentext key="Addcollectiontocolon" text="Add collection to:"/>
      <l:gentext key="remove" text="remove" />
      <l:gentext key="Loginrequired" text="Login required"/>
      <l:gentext key="LogIn" text="Log In"/>
      <l:gentext key="LogOut" text="Log Out"/>
      <l:gentext key="ReportaBug" text="Report a Bug"/>
      <l:gentext key="ContactUs" text="Contact Us"/>
      <l:gentext key="Youarehere" text="You are here: "/>
      <l:gentext key="rightanglequote" text=" &#187; "/>
      <l:gentext key="Content" text="Content"/>
      <l:gentext key="arrowPrevious" text="&#171; Previous"/>
      <l:gentext key="Next" text="Next"/>
      <l:gentext key="moduleincollection" text="module in collection"/>
      <l:gentext key="InCollection" text="Inside Collection"/>
      <l:gentext key="leftparen" text="("/>
      <l:gentext key="rightparen" text=")"/>
      <l:gentext key="colon" text=": "/>
      <l:gentext key="MusicalExamples" text="Musical Examples"/>
      <l:gentext key="Moduleby" text="Module by:"/>
      <l:gentext key="Tableof" text="Table of"/>
      <l:gentext key="Contents" text="Contents"/>
      <l:gentext key="ClicktotoggleToC" text="Click to toggle the Table of Contents open and closed"/>
      <l:gentext key="show" text="show"/>
      <l:gentext key="hide" text="hide"/>
      <l:gentext key="Links" text="Links"/>
      <l:gentext key="links" text="links"/>
      <l:gentext key="EndorsementHelpText" text="This content has been endorsed by the organizations listed. Click each link for a list of all content endorsed by the organization."/>
      <l:gentext key="AffiliationHelpText" text="This content is either by members of the organizations listed or about topics related to the organizations listed. Click each link to see a list of all content affiliated with the organization."/>
      <l:gentext key="TagHelpText" text="These tags come from the endorsement, affiliation, and other lenses that include this content."/>
      <l:gentext key="AsAPartOfCollection" text="As a part of collection:"/>
      <l:gentext key="AsAPartOfCollections" text="As a part of collections:"/>
      <l:gentext key="ThisModuleIncluded" text="This module is included in"/>
      <l:gentext key="ThisModuleAndCollectionIncluded" text="This module and collection are included in"/>
      <l:gentext key="ThisCollectionIncluded" text="This collection is included in"/>
      <l:gentext key="a" text="a"/>
      <l:gentext key="Lensby" text="Lens by:"/>
      <l:gentext key="Comments" text="Comments:"/>
      <l:gentext key="Lens" text="Lens:"/>
      <l:gentext key="Whatisalens" text="What is a lens"/>
      <l:gentext key="Lensespara" text="A lens is a custom view of Connexions content. You can think of it as a fancy kind of list that will let you see Connexions through the eyes of organizations and people you trust."/>
      <l:gentext key="Whatisinalens" text="What is in a lens?"/>
      <l:gentext key="Whatisinalenspara" text="Lens makers point to Connexions materials (modules and collections), creating a guide that includes their own comments and descriptive tags about the content."/>
      <l:gentext key="Whocancreatealens" text="Who can create a lens?"/>
      <l:gentext key="Whocancreatealenspara" text="Any individual Connexions member, a community, or a respected organization."/>
      <l:gentext key="WhatisMyFavorites" text="What is 'My Favorites'"/>
      <l:gentext key="MyFavoritesexplanation" text="'My Favorites' is a special kind of lens which you can use to bookmark modules and collections directly in Connexions. 'My Favorites' can only be seen by you, and collections saved in 'My Favorites' can remember the last module you were on. You need a Connexions account to use 'My Favorites'."/>
      <l:gentext key="Thiscontentisellipsis" text="This content is ..."/>
      <l:gentext key="Clickthe" text="Click the"/>
      <l:gentext key="lquot" text='"'/>
      <l:gentext key="rquot" text='"'/>
      <l:gentext key="linktoseeallendorsed" text="link to see all content they endorse."/>
      <l:gentext key="linktoseeallaffiliated" text="link to see all content affiliated with them."/>
      <l:gentext key="linktoseeallselected" text="link to see all content selected in this lens."/>
      <l:gentext key="Skiptocontent" text="Skip to content"/>
      <l:gentext key="Skiptonavigation" text="Skip to navigation"/>
      <l:gentext key="Skiptocollectioninformation" text="Skip to collection information"/>
      <l:gentext key="Selectedcolon" text="Selected:"/>
      <l:gentext key="Navigation" text="Navigation"/>
      <l:gentext key="Footer" text="Footer"/>
      <l:gentext key="CreativeCommonsLicense" text="Creative Commons License"/>
      <l:gentext key="Logofor" text="Logo for"/>
      <l:gentext key="Privatelenskey" text="Private lens key"/>
      <l:gentext key="Privatelensexplanation" text="Private lens: seen only by lens maker while logged on"/>
      <l:gentext key="Diagramoflenses" text="Diagram of lenses"/>
      <l:gentext key="Notecolon" text="Note:" />
      <l:gentext key="NoMathMLSupport" text="Your browser may not currently support MathML."/>
      <l:gentext key="IE6OrAbove" text="Please install the required"/>
      <l:gentext key="MathMLPlayer" text="MathPlayer plugin"/>
      <l:gentext key="ToViewMathML" text="to view MathML correctly."/>
      <l:gentext key="FirefoxRequires" text="Firefox requires additional"/>
      <l:gentext key="ToDisplayMathML" text=" to display MathML correctly."/>
      <l:gentext key="MathematicsFonts" text="mathematics fonts"/>
      <l:gentext key="ChromeMsg" text="Chrome will attempt to display MathML, but it should not be considered correct."/>
      <l:gentext key="SafariMsg" text="Safari will attempt to display MathML, but it should not be considered correct."/>
      <l:gentext key="AnyBrowser_part1" text="You can always view the correct math in the "/>
      <l:gentext key="PrintVersion" text="PDF version"/>
      <l:gentext key="AnyBrowser_part2" text="."/>
      <l:gentext key="SeeOur" text=" See our"/>
      <l:gentext key="BrowserSupport" text="browser support page"/>
      <l:gentext key="AdditionalDetails" text="for additional details."/>
      <l:gentext key="MathMLTest" text="Or compare the two sample Math snippets below. Example 1 is what you will see in your browser and Example 2 is the correct display of the MathML. If the two MathML examples below are alike, your browser is MathML compatible."/>
      <l:gentext key="Example1" text="Example 1:"/>
      <l:gentext key="Example2" text="Example 2:"/>
      <l:gentext key="HideExamples" text="(Hide examples)"/>
      <l:gentext key="ShowExamples" text="(Show MathML examples)"/>
      <l:gentext key="TwoExamples_part1" text="If the two examples below are mathematically the same, your browser is correctly displaying MathML, and you can"/>
      <l:gentext key="DismissMessage" text="dismiss this message"/>
      <l:gentext key="TwoExamples_part2" text="."/>

      <!-- for editInPlace.xsl -->
      <l:gentext key="Instructions" text="Instructions: "/>
      <l:gentext key="Instructionstext" text="To edit text, click on an area with a white background. Warning: Reloading or leaving the page will discard any unpublished changes."/>
      <l:gentext key="Brieflydescribeyourchanges" text="Briefly describe your changes:"/>
      <l:gentext key="Publish" text="Publish"/>
      <l:gentext key="Discard" text="Discard"/>

      <!-- for qml.xsl -->
      <l:gentext key="ProblemSet" text="Problem Set"/>
      <l:gentext key="CheckAnswer" text="Check Answer"/>
      <l:gentext key="ShowAnswer" text="Show Answer"/>
      <l:gentext key="Hint" text="Hint"/>
      <l:gentext key="Correct" text="Correct!"/>
      <l:gentext key="Incorrect" text="Incorrect."/>

      <!-- Old pairs resurrected for use by old content_render template -->
      <l:gentext key="Aboutus" text="About us"/>
      <l:gentext key="Browseallcontent" text="Browse all content"/>
      <l:gentext key="PrintPDF" text="Print (PDF)"/>
<!--      <l:gentext key="loginrequired" text="(login required)"/>  -->
      <l:gentext key="Moreaboutthiscontent" text="More about this content"/>
      <l:gentext key="Citethiscontent" text="Cite this content"/>
      <l:gentext key="Versionhistory" text="Version history"/>
      <l:gentext key="SaveToDelicious" text="Save to del.icio.us"/>
      <l:gentext key="Coursesusingcontent" text="Collections using this content"/>
      <l:gentext key="Morecoursesusingcontent" text="More collections using this content"/>
      <l:gentext key="TableofContents" text="Table of Contents"/>

<!--
      <l:gentext key="Summer Sky" text="Summer Sky"/>
      <l:gentext key="Desert Scape" text="Desert Scape"/>
      <l:gentext key="Charcoal" text="Charcoal"/>
      <l:gentext key="Playland" text="Playland"/>
-->
<!--      <l:gentext key="Plone" text="Plone"/>  -->


    </l:l10n>
  </l:i18n>
</xsl:stylesheet>
