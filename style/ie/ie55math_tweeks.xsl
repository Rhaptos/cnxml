<?xml version= "1.0" standalone="no"?>

<xsl:stylesheet version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:cnx="http://cnx.rice.edu/cnxml/0.4"
  xmlns:m="http://www.w3.org/1998/Math/MathML"
  xmlns:md="http://cnx.rice.edu/mdml/0.4"
  xmlns:doc="http://www.dcarlisle.demon.co.uk/xsldoc"
  xmlns:fns="http://www.w3.org/2002/Math/preference"
  xmlns="http://www.w3.org/1999/xhtml">

  <!-- Root Node -->
  <xsl:template match="/">
    <html xmlns:pref="http://www.w3.org/2002/Math/preference" 
          pref:renderer="mathplayer-dl">
      <head>
	<object id="mmlFactory" 
	  classid="clsid:32F66A20-7614-11D4-BD11-00104BD3F987">
	  <xsl:text> </xsl:text>
	</object>
	<xsl:text disable-output-escaping="yes">
	  <![CDATA[<?import namespace="m" implementation="#mmlFactory"?>]]>
	</xsl:text>

<xsl:text disable-output-escaping="yes">
<![CDATA[
<script language="JScript">
var cookieName = "MathPlayerInstall=";
function MPInstall(){
 var notInstalled=testmplayer();
 var showDialog=notInstalled;
 var c = document.cookie;
 var i = c.indexOf(cookieName);
 if (i >= 0) {                  
  if ( c.substr(i + cookieName.length, 1) >= 2) { showDialog=false; }
 }          
 if (showDialog) {
  MPDialog();
  c = document.cookie;
  i = c.indexOf(cookieName);
 }
 if (!notInstalled) {
   return 2;
 }
 else {
    if (i >= 0) return c.substr(i + cookieName.length, 1);
    else { return null; };
 }
}

function MPDialog() {
 var vArgs="";
 var sFeatures="dialogWidth:410px;dialogHeight:190px;help:off;status:no";
 var text = "";      
 text += "javascript:document.write('"
 text += '<script>'
 text += 'function fnClose(v) { '
 text += 'var exp = new Date();'
 text += 'var thirtyDays = exp.getTime() + (30 * 24 * 60 * 60 * 1000);'
 text += 'exp.setTime(thirtyDays);'
 text += 'var cookieProps = ";expires=" + exp.toGMTString();'
 text += 'if (document.forms[0].dontask.checked) v+=2;'            
 text += 'document.cookie="' + cookieName + '"+v+cookieProps;'
 text += 'window.close();'           
 text += '}'        
 text += '</' + 'script>'
 text += '<head><title>Install MathPlayer?</title></head>'
 text += '<body bgcolor="#D4D0C8"><form>'
 text += '<table cellpadding=10 style="font-family:Arial;font-size:10pt" border=0 width=100%>'
 text += '<tr><td align="left">This page requires Design Science\\\'s MathPlayer&amp;trade;.<br>'
 text += 'Do you want to download and install MathPlayer?</td></tr>';
 text += '<tr><td align=center><input type="checkbox" name="dontask">'
 text += 'Don\\\'t ask me again</td></tr>'
 text += '<tr><td align=center><input id=yes type="button" value=" Yes "'
 text += ' onClick="fnClose(1)">&nbsp;&nbsp;&nbsp;'
 text += '<input type="button" value="  No  " onClick="fnClose(0)"></td></tr>'
 text += '</table></form>';
 text += '</body>'
 text += "')"
 window.showModalDialog( text , vArgs, sFeatures );        
}               

function WaitDialog() {
 var vArgs="";
 var sFeatures="dialogWidth:510px;dialogHeight:150px;help:off;status:no";
 var text = "";               
 text += "javascript:document.write('"
 text += '<script>'
 text += 'window.onload=fnLoad;'
 text += 'function fnLoad() {document.forms[0].yes.focus();}'
 text += 'function fnClose(v) { '                 
 text += 'window.returnValue=v;'
 text += 'window.close();'
 text += '}'
 text += '</' + 'script>'
 text += '<head><title>Wait for Installation?</title></head>'
 text += '<body bgcolor="#D4D0C8" onload="fnLoad()"><form><'
 text += 'table cellpadding=10 style="font-family:Arial;font-size:10pt" border=0 width=100%>'
 text += '<tr><td align=left>Click OK once MathPlayer is installed '
 text += 'to refresh the page.<br>'                 
 text += 'Click Cancel to view the page immediately without MathPlayer.</td></tr>';
 text += '<tr><td align=center><input id=yes type="button" '
 text += 'value="   OK   " onClick="fnClose(1)">&nbsp;&nbsp;&nbsp;'
 text += '<input type="button" value="Cancel" onClick="fnClose(0)"></td></tr>'
 text += '</table></form>';
 text += '</body>'
 text += "')"        
 return window.showModalDialog( text , vArgs, sFeatures );
}

var result = MPInstall();       
var action = "fallthrough";        
if (result == 1 || result == 3) {
 window.open("http://www.dessci.com/webmath/mathplayer");          
 var wait = WaitDialog();
 if ( wait == 1) {                   
  action =  "install";
  document.location.reload();

 }
}
if (action == "fallthrough") {
var xsl = new ActiveXObject("Microsoft.FreeThreadedXMLDOM");               
xsl.async = false;
xsl.validateOnParse = false;
xsl.load("pmathmlcss.xsl");
var xslTemplate = new ActiveXObject("MSXML2.XSLTemplate.3.0"); 
xslTemplate.stylesheet=xsl.documentElement;
var xslProc = xslTemplate.createProcessor();
xslProc.input = document.XMLDocument;

xslProc.transform();
var str = xslProc.output;
//<!-- work around bug in IE6 under Win XP, RM 6/5/2002 -->
var repl = "replace";  
if (window.navigator.appVersion.match(/Windows NT 5.1/)) { repl = ""; }
var newDoc = document.open("text/html", repl);
newDoc.write(str);            
document.close();
}

function isinstalled(ax)
{
    try {                     
        var ActiveX = new ActiveXObject(ax);
        return true;
    } catch (e) {    
        return false;
    }       
}

function testmplayer()
{
    return (!isinstalled('MathPlayer.Factory.1'));
}

</script>
]]>
</xsl:text>

        <script language="javascript" src="/cnxml/0.4/scripts/ie-exercise.js"> </script>
        <script language="javascript" src="/qml/1.0/scripts/qml_1-0.js"> </script>

        <!-- ****QML**** sets the feedback and hints to non-visible. -->
        <style type="text/css">
          .feedback {display:none}
          .hint {display:none}
        </style>
	
	<link rel="stylesheet" title="Default" type="text/css" href="/cnxml/0.4/style/ie/max.css">  </link>
	
	<!--MODULE's NAME-->
        <title><xsl:value-of select="cnx:module/cnx:name"/></title>
      </head>	
      <xsl:apply-templates />
    </html>
  </xsl:template>

  <!-- Always force display to block.  Enclose in <p> when block requested -->
  <xsl:template match="m:math">
    <xsl:choose>
      <xsl:when test="@display='block' or parent::*[local-name()='equation']">
	<p>
	  <m:math display="block">
	    <xsl:apply-templates/>
	  </m:math>
	</p>
      </xsl:when>
      <xsl:otherwise>
	<span class="math">
	  <m:math display="inline">
	    <xsl:apply-templates/>
	  </m:math>
	</span>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!--EQUATION-->
  <xsl:template match="cnx:equation">
    <!--do something with the para because eqn can go in paras-->
    <div class="equation" id="{@id}">
     <div class="equation-before">
        <span class="equation-number">
          Equation <xsl:number level="any" count="cnx:equation"/>
          <xsl:if test="cnx:name">: </xsl:if>
        </span>
        <xsl:if test="cnx:name">
          <span class="equation-name">
            <xsl:value-of select="cnx:name"/>
          </span>
        </xsl:if>  
      </div>
      <div class="equation-math">
	<xsl:apply-templates select="*[not(self::cnx:name)]" />
      </div>
    </div>
  </xsl:template>

</xsl:stylesheet>
