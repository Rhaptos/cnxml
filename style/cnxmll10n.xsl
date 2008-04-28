<?xml version="1.0"?>

<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  
  <!-- Begin section of translations for english text that appear in this file-->
  <xsl:param name="local.l10n.xml" select="document('')"/>
  <l:i18n xmlns:l="http://docbook.sourceforge.net/xmlns/l10n/1.0">
    <l:l10n language="en" english-language-name="English">
      <!-- for unibrowser.xsl -->
      <l:gentext key="subfigure" text="subfigure"/>
      <l:gentext key="Subfigure" text="Subfigure"/>
      <l:gentext key="Strength" text="Strength"/>
      <l:gentext key="Definition" text="Definition"/>
      <l:gentext key="Proof" text="Proof"/>
      <l:gentext key="MediaFile" text="Media File"/>
      <l:gentext key="EPSImage" text="EPS Image"/>
      <l:gentext key="LabVIEWExample" text="LabVIEWExample"/>
      <l:gentext key="Download" text="Download"/>
      <l:gentext key="LabVIEWSource" text="LabVIEW Source"/>
      <l:gentext key="AudioFile" text="Audio File"/>
      <l:gentext key="MusicalExample" text="Musical Example"/>
      <l:gentext key="Problem" text="Problem"/>
      <l:gentext key="ClickForSolution" text="Click for Solution"/>
      <l:gentext key="HideSolution" text="Hide Solution"/>
      <l:gentext key="Solution" text="Solution"/>
      <l:gentext key="Diagnosis" text="Diagnosis"/>
      <l:gentext key="ClickForDiagnosis" text="Click for Diagnosis"/>
      <l:gentext key="HideDiagnosis" text="Hide Diagnosis"/>
      <l:gentext key="Footnotes" text="Footnotes"/>

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
      <l:gentext key="previewofwhenpublished" text=" This is a preview of how your module will appear when published"/>
      <l:gentext key="assumingthatall" text="assuming that all "/>
      <l:gentext key="pendingrolerequests" text="currently pending role requests"/>
      <l:gentext key="areaccepted" text=" are accepted"/>
      <l:gentext key="returntoediting" text="You must return to the editing interface to "/>
      <l:gentext key="edit" text="edit"/>
      <l:gentext key="or" text=" or "/>
      <l:gentext key="publish" text="publish"/>
      <l:gentext key="yourchanges" text=" your changes. "/>
      <l:gentext key="youmayview" text="You may view the "/>
      <l:gentext key="latestpublishedversion" text="latest published version"/>
      <l:gentext key="hereanda" text=" here and a "/>
      <l:gentext key="listofchanges" text="list of changes"/>
      <l:gentext key="here" text=" here."/>
      <l:gentext key="Commentsquestionsfeedback" text="Comments, questions, feedback, criticisms?"/>
      <l:gentext key="Discussionforum" text="Discussion forum"/>
      <l:gentext key="Jointhediscussion" text="Join the discussion &#187;"/>
      <l:gentext key="Sendfeedback" text="Send feedback"/>
      <l:gentext key="Emailtheauthors" text="E-mail the authors"/>
      <l:gentext key="Emailtheauthor" text="E-mail the author"/>
      <l:gentext key="Email" text="E-mail "/>
      <l:gentext key="Relatedmaterial" text="Related material"/>
      <l:gentext key="Example links" text="Example links"/>
      <l:gentext key="Prerequisite links" text="Prerequisite links"/>
      <l:gentext key="Supplemental links" text="Supplemental links"/>
      <l:gentext key="Verystronglink" text="Very strongly related link"/>
      <l:gentext key="Stronglink" text="Strongly related link"/>
      <l:gentext key="Relatedlink" text="Related link"/>
      <l:gentext key="Distantlink" text="Distantly related link"/>
      <l:gentext key="Verydistantlink" text="Very distantly related link"/>
      <l:gentext key="LinktoPDFformat" text="Link to printer-friendly PDF format"/>
      <l:gentext key="DownloadPDF" text="Download PDF"/>
      <l:gentext key="Similarcontent" text="Similar content"/>
      <l:gentext key="Moresimilarcontent" text="More links to similar content"/>
      <l:gentext key="More" text="More"/>
      <l:gentext key="Coursesusingcontent" text="Collections using this content"/>
      <l:gentext key="Othercoursesusingcontent" text="Other collections using this content"/>
      <l:gentext key="Morecoursesusingcontent" text="More collections using this content"/>
      <l:gentext key="Personalize" text="Personalize"/>
      <l:gentext key="Chooseastyle" text="Choose a style"/>
      <l:gentext key="EditInPlace" text="Edit-In-Place"/>
      <l:gentext key="Editthiscontent" text="Edit this content"/>
      <l:gentext key="authoronly" text=" (author only)"/>
      <l:gentext key="MoreAboutThisContent" text="More about this content: "/>
      <l:gentext key="Metadata" text="Metadata"/>
      <l:gentext key="CiteThisContent" text="Cite This Content"/>
      <l:gentext key="VersionHistory" text="Version History"/>
      <l:gentext key="Worklicensedby" text="This work is licensed by"/>
      <l:gentext key="and" text="and"/>
      <l:gentext key="comma" text=", "/>
      <l:gentext key="Seethe" text="See the"/>
      <l:gentext key="CreativeCommonsLicense" text="Creative Commons License"/>
      <l:gentext key="aboutpermission" text="about permission to reuse this material."/>
      <l:gentext key="period" text=". "/>
      <l:gentext key="Lasteditedby" text="Last edited by"/>
      <l:gentext key="on" text="on"/>
      <l:gentext key="Search" text="Search"/>
      <l:gentext key="Searchcolon" text="Search: "/>
      <l:gentext key="Home" text="Home"/>
      <l:gentext key="AboutUs" text="About Us"/>
      <l:gentext key="Help" text="Help"/>
      <l:gentext key="AuthorArea" text="Authoring Area"/>
      <l:gentext key="ContentActions" text="Content Actions"/>
      <l:gentext key="SaveToDelicious" text="Save to del.icio.us"/>
      <l:gentext key="Bookmarkhelp" text="Add this content to the social bookmarking site del.icio.us, where you can share your favorite links with others."/>
      <l:gentext key="parensquestion" text="(?)"/>
      <l:gentext key="Quality" text="Quality"/>
      <l:gentext key="EndorsedBy" text="Endorsed by"/>
      <l:gentext key="AffiliatedWith" text="Affiliated with"/>
      <l:gentext key="Lenses" text="Lenses"/>
      <l:gentext key="AddLens" text="Add to a lens"/>
      <l:gentext key="Intheselenses" text="In these lenses" />
      <l:gentext key="Alsointheselenses" text="Also in these lenses" />
      <l:gentext key="Tags" text="Tags"/>
      <l:gentext key="ReportaBug" text="Report a Bug"/>
      <l:gentext key="ContactUs" text="Contact Us"/>
      <l:gentext key="Youarehere" text="You are here: "/>
      <l:gentext key="rightanglequote" text=" &#187; "/>
      <l:gentext key="Content" text="Content"/>
      <l:gentext key="Previous" text="&#171; Previous"/>
      <l:gentext key="Next" text="Next &#187;"/>
      <l:gentext key="pipe" text=" | "/>
      <l:gentext key="InCollection" text="Inside Collection"/>
      <l:gentext key="leftparen" text="("/>
      <l:gentext key="rightparen" text=")"/>
      <l:gentext key="colon" text=": "/>
      <l:gentext key="MusicalExamples" text="Musical Examples"/>
      <l:gentext key="Moduleby" text="Module by:"/>
      <l:gentext key="CollectionContents" text="Collection Contents"/>
      <l:gentext key="GoToCollectionHome" text="Go to collection home page"/>
      <l:gentext key="show" text="show"/>
      <l:gentext key="hide" text="hide"/>
      <l:gentext key="showtableofcontents" text="show table of contents"/>
      <l:gentext key="Links" text="Links"/>
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
      <l:gentext key="Whatisalens" text="What is a lens?"/>
      <l:gentext key="Lensespara" text="A lens is a custom view of Connexions content. You can think of it as a fancy kind of list that will let you see Connexions through the eyes of organizations and people you trust."/>
      <l:gentext key="Whatisinalens" text="What is in a lens?"/>
      <l:gentext key="Whatisinalenspara" text="Lens makers point to Connexions materials (modules and collections), creating a guide that includes their own comments and descriptive tags about the content."/>
      <l:gentext key="Whocancreatealens" text="Who can create a lens?"/>
      <l:gentext key="Whocancreatealenspara" text="Any individual Connexions member, a community, or a respected organization."/>
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
      <l:gentext key="Logofor" text="Logo for"/>
      <l:gentext key="Privatelenskey" text="Private lens key"/>
      <l:gentext key="Privatelensexplanation" text="Private lens: seen only by lens maker while logged on"/>
      <l:gentext key="Diagramoflenses" text="Diagram of lenses"/>

      <!-- for editInPlace.xsl -->
      <l:gentext key="Instructions" text="Instructions: "/>
      <l:gentext key="Instructionstext" text="To edit text, click on an area with a white background. Warning: Reloading or leaving the page will discard any unpublished changes."/>
      <l:gentext key="Brieflydescribeyourchanges" text="Briefly describe your changes:"/>
      <l:gentext key="Publish" text="Publish"/>
      <l:gentext key="Discard" text="Discard"/>

      <!-- Old pairs resurrected for use by old content_render template -->
      <l:gentext key="Aboutus" text="About us"/>
      <l:gentext key="Browseallcontent" text="Browse all content"/>
      <l:gentext key="PrintPDF" text="Print (PDF)"/>
<!--      <l:gentext key="loginrequired" text="(login required)"/>  -->
      <l:gentext key="Moreaboutthiscontent" text="More about this content"/>
      <l:gentext key="Citethiscontent" text="Cite this content"/>
      <l:gentext key="Versionhistory" text="Version history"/>
      <l:gentext key="undera" text="under a"/>
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
