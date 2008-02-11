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
      <l:gentext key="Home" text="Home"/>
      <l:gentext key="AboutUs" text="About Us"/>
      <l:gentext key="Help" text="Help"/>
      <l:gentext key="AuthorArea" text="Authoring Area"/>
      <l:gentext key="ContentActions" text="Content Actions"/>
      <l:gentext key="SaveToDelicious" text="Save to del.icio.us"/>
      <l:gentext key="whatsthis" text="(what's this?)"/>
      <l:gentext key="Quality" text="Quality"/>
      <l:gentext key="EndorsedBy" text="Endorsed by"/>
      <l:gentext key="AffiliatedWith" text="Affiliated with"/>
      <l:gentext key="Lenses" text="Lenses"/>
      <l:gentext key="AddLens" text="Add to a lens"/>
      <l:gentext key="Memberlists" text="Member lists"/>
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
      <l:gentext key="EndorsementHelpText" text="This content or a collection containing this content has been endorsed by the organizations listed. Click for more information."/>
      <l:gentext key="AffiliationHelpText" text="This content or a collection containing this content is affiliated with the organizations listed. Click for more information."/>
      <l:gentext key="LensHelpText" text="This content or a collection containing this content is selected by the member lists below. Click for more information."/>
      <l:gentext key="TagHelpText" text="These tags about this content come from endorsements, affiliations, and member lists that include this content."/>
      <l:gentext key="Module" text="Module"/>
      <l:gentext key="Collection" text="Collection"/>
      <l:gentext key="AsAPartOfCollection" text="as a part of collection"/>
      <l:gentext key="AndAsAPartOf" text="and as a part of"/>
      <l:gentext key="ThisModuleIncluded" text="This module is included in"/>
      <l:gentext key="ThisModuleAndCollectionIncluded" text="This module and collection are included in"/>
      <l:gentext key="ThisCollectionIncluded" text="This collection is included in"/>
      <l:gentext key="ALensBy" text="a lens by"/>
      <l:gentext key="TagsLensInfo" text="Tags:"/>
      <l:gentext key="Comments" text="Comments:"/>
      <l:gentext key="lens" text="lens"/>

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
