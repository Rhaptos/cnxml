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

      <!-- for content_render.xsl -->
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
      <l:gentext key="Print" text="Print"/>
      <l:gentext key="PDF" text=" (PDF)"/>
      <l:gentext key="Similarcontent" text="Similar content"/>
      <l:gentext key="Moresimilarcontent" text="More links to similar content"/>
      <l:gentext key="More" text="More"/>
      <l:gentext key="Coursesusingcontent" text="Courses using this content"/>
      <l:gentext key="Othercoursesusingcontent" text="Other courses using this content"/>
      <l:gentext key="Morecoursesusingcontent" text="More courses using this content"/>
      <l:gentext key="Personalize" text="Personalize"/>
      <l:gentext key="Chooseastyle" text="Choose a style"/>
      <l:gentext key="EditInPlace" text="Edit-In-Place"/>
      <l:gentext key="Editthiscontent" text="Edit this content"/>
      <l:gentext key="authoronly" text=" (author only)"/>
      <l:gentext key="Moreaboutthiscontent" text="More about this content"/>
      <l:gentext key="Citethiscontent" text="Cite this content"/>
      <l:gentext key="Versionhistory" text="Version history"/>
      <l:gentext key="Worklicensedby" text="This work is licensed by"/>
      <l:gentext key="and" text=" and "/>
      <l:gentext key="comma" text=", "/>
      <l:gentext key="undera" text="under a"/>
      <l:gentext key="CreativeCommonsLicense" text="Creative Commons License"/>
      <l:gentext key="period" text=". "/>
      <l:gentext key="Lasteditedby" text="Last edited by"/>
      <l:gentext key="on" text="on"/>
      <l:gentext key="Search" text="Search"/>
      <l:gentext key="Home" text="Home"/>
      <l:gentext key="AboutUs" text="About Us"/>
      <l:gentext key="Help" text="Help"/>
      <l:gentext key="ContentActions" text="Content Actions"/>
      <l:gentext key="SaveToDelicious" text="Save to del.icio.us"/>
      <l:gentext key="whatsthis" text="(what's this?)"/>
      <l:gentext key="Endorsements" text="Endorsements"/>
      <l:gentext key="ReportaBug" text="Report a Bug"/>
      <l:gentext key="Contact" text="Contact"/>
      <l:gentext key="Youarehere" text="You are here: "/>
      <l:gentext key="rightanglequote" text=" &#187; "/>
      <l:gentext key="Content" text="Content"/>
      <l:gentext key="Previous" text="&#171; Previous"/>
      <l:gentext key="Next" text="Next &#187;"/>
      <l:gentext key="pipe" text=" | "/>
      <l:gentext key="Incourse" text="In course:"/>
      <l:gentext key="coursehome" text="course home"/>
      <l:gentext key="leftparen" text="("/>
      <l:gentext key="rightparen" text=")"/>
      <l:gentext key="Courseby" text="Course by: "/>
      <l:gentext key="MusicalExamples" text="Musical Examples"/>
      <l:gentext key="Moduleby" text="Module by:"/>
      <l:gentext key="CourseContents" text="Course Contents"/>
      <l:gentext key="show" text="show"/>
      <l:gentext key="hide" text="hide"/>
      <l:gentext key="Links" text="Links"/>

      <!-- for editInPlace.xsl -->
      <l:gentext key="Instructions" text="Instructions: "/>
      <l:gentext key="Instructionstext" text="To edit text, click on an area with a white background. Warning: Reloading or leaving the page will discard any unpublished changes."/>
      <l:gentext key="Brieflydescribeyourchanges" text="Briefly describe your changes:"/>
      <l:gentext key="Publish" text="Publish"/>
      <l:gentext key="Discard" text="Discard"/>
    </l:l10n>
  </l:i18n>
</xsl:stylesheet>
