/*
 * The contents of this file are subject to the Mozilla Public
 * License Version 1.1 (the"License"); you may not use this file
 * except in compliance with the License. You may obtain a copy of
 * the License at http://www.mozilla.org/MPL/
 *
 * Software distributed under the License is distributed on an"AS
 * IS" basis, WITHOUT WARRANTY OF ANY KIND, either express or
 * implied. See the License for the specific language governing
 * rights and limitations under the License.
 *
 * The Original Code is Mozilla MathML Project.
 *
 * The Initial Developer of the Original Code is The University Of
 * Queensland.  Portions created by The University Of Queensland are
 * Copyright (C) 2002 The University Of Queensland.  All Rights Reserved.
 *
 * Contributor(s):
 *   Roger B. Sidje <rbs@maths.uq.edu.au>
 *   Steve Swanson <steve.swanson@mackichan.com>
 *   
 */

var gDebug = 0;
var gLineCount = 0;
var gStartTargetLine = 0;
var gEndTargetLine = 0;
var gTargetNode = null;
var gWYSIWYGWindow = null;
// had to use an absolute path here, otherwise Mozilla is confused when the
// script is loaded from a directory different from where the CSS resides
var gViewSourceCSS = 'http://www.mozilla.org/projects/mathml/demo/viewsource.css';

function viewmath(id) {
  anchor=document.getElementById(id);
  var m =
  anchor.getElementsByTagNameNS('http://www.w3.org/1998/Math/MathML','math')[0];
  var semanticstag= m.firstChild;
  var
  annotationlist=semanticstag.getElementsByTagNameNS("http://www.w3.org/1998/Math/MathML",
  'annotation-xml')
  var annotation=annotationlist.item(0);
  var content=annotation.firstChild;
  gLineCount = 0;
  gStartTargetLine = 0;
  gEndTargetLine = 0;
  if (annotation) {
    gWYSIWYGWindow = open("", "wysiwyg", "scrollbars=1,resizable=1,width=500,height=200");
    gWYSIWYGWindow.document.open();
    with (gWYSIWYGWindow.document) {
      writeln('<html><base target="wysiwyg">');
      writeln('<head><title>MathML WYSIWYG Source</title>');
      writeln('<style>#target{border:dashed 1px; background-color:lightyellow; }</style>'); 
        writeln('<link rel="stylesheet" type="text/css" href="'+gViewSourceCSS+'" />');
        writeln('</head><body id="viewsource" onload="window.focus();" bgcolor="#FFFFFF">');
      writeln('<pre>');
      writeln(getOuterMarkup(annotation,0));
      writeln('</pre></body></html>');
    }
    gWYSIWYGWindow.document.close();
  }
}



function getInnerMarkup(n, indent) {
  var str = '';
  for (var i = 0; i<n.childNodes.length; i++)
    str += getOuterMarkup(n.childNodes.item(i),indent);
    str=  str.replace(/m:/g, "");
  
  return str;
}

function getOuterMarkup(n, indent) {
  var newline = '';
  var padding = '';
  var str = '';
  if (n == gTargetNode) {
    gStartTargetLine = gLineCount;
    str += '<a name="target"></a><div id="target">';
  }

  switch (n.nodeType) {
  case Node.ELEMENT_NODE: // Element
    // to avoid the wide gap problem, '\n' is not emitted on the first
    // line and the lines before & after the <div id="target">...</div>
    newline = '';
    if (gLineCount > 0) {
      newline = '\n';
    }
    if (gLineCount == gStartTargetLine ||
        gLineCount == gEndTargetLine) {
      newline = '';
    }
    gLineCount++;
    if (gDebug) {
      newline += gLineCount;
    }
    for (var k=0; k<indent; k++) {
      padding += ' ';
    }
    str += newline + padding + '&lt;<span class="start-tag">' + n.nodeName + '</span>';
    for (var i=0; i<n.attributes.length; i++) {
      var attr = n.attributes.item(i);
      if (!gDebug && attr.nodeName.match(/^-moz-math-/)) {
        continue;
      }
      if (!gDebug &&
	  ( attr.nodeName.match(/xmlns:m/) 
	    || (attr.nodeName.match(/definitionURL/) && attr.nodeValue == "")
	    || (attr.nodeName.match(/encoding/) && attr.nodeValue == "")
	   )){ 
	  continue;
      }
      str += ' <span class="attribute-name">';
      str += attr.nodeName;
      str += '</span>=<span class="attribute-value">"';
      str += unicode2entity(attr.nodeValue);
      str += '"</span>';
    }
    str += '&gt;';
    var oldLine = gLineCount;
    str += getInnerMarkup(n, indent + 2);
    if (oldLine == gLineCount) {
      newline = '';
      padding = '';
    }
    else {
      newline = '\n';
      if (gLineCount == gEndTargetLine) {
        newline = '';
      }
      gLineCount++;
      if (gDebug) {
        newline += gLineCount;
      }
    }
    str += newline + padding + '&lt;/<span class="end-tag">' + n.nodeName + '</span>&gt;';
    break;
  case Node.TEXT_NODE: // Text
    var tmp = n.nodeValue;
    tmp = tmp.toString();
    tmp = tmp.replace(/m:/g, " ");
    tmp = tmp.replace(/(\n|\r|\t)+/g, " ");
    tmp = tmp.replace(/\s+/," ");
    tmp = tmp.replace(/^\s+/, "");
    tmp = tmp.replace(/\s+$/,"");
    if (tmp.length != 0) {
      str += '<span class="text">' + unicode2entity(tmp) + '</span>';
    }
    break;
  default:
    break;
  }
  if (n == gTargetNode) {
    gEndTargetLine = gLineCount;
    str += '</div>';
  }
  str=  str.replace(/m:/g, "");
  str=  str.replace(/annotation-xml/g, "math");
  return str;
}
