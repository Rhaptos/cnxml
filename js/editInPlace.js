/**
 * editInPlaceSpecific.js
 *
 * This file contains information
 * specific to a particular version
 * of CNXML for which editInPlace
 * is being utilized.
 */

// Namespaces
const CNXML_NS = "http://cnx.rice.edu/cnxml/0.4";
const MATHML_NS = "http://www.w3.org/1998/Math/MathML";
const XHTML_NS = "http://www.w3.org/1999/xhtml";

// top level tag
const TOP_LEVEL_TAG_NS = CNXML_NS;
const TOP_LEVEL_TAGNAME = 'document';

// preview relative url
const PREVIEW_TRANSFORM_REL_URL = "/cnxml/0.4/transform";

// doctype parts
const DOCTYPE_SYSTEM_PART = "-//CNX//DTD CNXML 0.4 plus MathML//EN";
const DOCTYPE_PUBLIC_PART = "http://cnx.rice.edu/cnxml/0.4/DTD/cnxml_mathml.dtd";

/**
 * These are the tag names that are
 * editable. If you switch the value
 * to false, the tag will become un-editable.
 */
var gEditableTags = { 'para': true,
		      'equation': true,
		      'rule': true,
		      'definition': true,
		      'exercise': true,
		      'ol': true,
		      'ul': true,
		      'section': false };



/**
 * editInPlaceGeneral.js
 *
 * This portion of editInPlace
 * contains code general to any
 * CNXML-language editInPlace.
 *
 * requires:  editInPlaceSpecific.js
 */


/**
 * CONSTANTS.
 */

// TAGS
const INPUT_TAG = 'input';
const ANCHOR_TAG = 'anchor'; 
const UL_TAG = 'ul';
const OL_TAG = 'ol';
const LIST_TAG = 'list';

// Validation / Preview
const SERVER_VALIDATION_OK_STATUS = 200;

// Commit
const COMMIT_FORM_ID = "eipCommitForm";
const COMMIT_TEXTAREA_ID = "eipCommitText";

// XMLHttpRequest readyState codes, from Microsoft 
const XHR_UNINITIALIZED = 0; // created, not initialized (open not called yet)
const XHR_LOADING = 1; // send method not called yet
const XHR_LOADED = 2; // send has been called, response not yet received
const XHR_INTERACTIVE = 3; // partial response data received
const XHR_COMPLETED = 4; // complete response received

// Internal State
const STATE_VIEWING = 0;
const STATE_EDITING = 1;
const STATE_VALIDATING = 2;
const STATE_COMMITTING = 3;
const STATE_BROKEN = 4;
const STATE_DOWNLOADING_SOURCE = 5;

/**
 * GLOBAL VARIABLES.
 */

/**
 * Regular expressions used multiple times in
 * this script.
 */
var gRegExps = {
  cnxml: new RegExp("^(<[^]*?)\\sxmlns\\=[\"']" + CNXML_NS + "['\"]([^]*)"),
  mathml: new RegExp("^(<[^]*?)\\sxmlns\\:m\\=[\"']" + MATHML_NS + "['\"]([^]*)") 
};

/**
 * Contains infromation about the 
 * node that we're editing.
 */
var gEditInformation = {
    editedNodeClone: undefined,
    editTagOpeningText: undefined,
    editTagClosingText: undefined,
    state: STATE_DOWNLOADING_SOURCE  };

/**
 * URLs obtained from links or hardcoded.
 */
var gURLs = {
  source: undefined, // url to obtain the document source
  module: undefined, // url to go to upon cancellation
  preview: "http://" + window.location.host + PREVIEW_TRANSFORM_REL_URL  // validator for previewing
};
    

/**
 * Contains objects related to the
 * original source version of this document.
 */
var gSource = {
    source: undefined,
    nodeBeingEdited: undefined,
    doc: undefined 
};

/**
 * Contains the DOM Nodes swapped
 * in and out to do editing.
 */
var gEditNodes = {
    containerDiv: undefined,
    previewButton: undefined,
    revertButton: undefined,
    textInputArea:  undefined,
    openingTagLabel: undefined,
    closingTagLabel: undefined,
    warningMessage: undefined 
};


/**
 * Objects used to send
 * information to the server.
 */
var gPreviewRequest = {
    nodeReplacementXML: undefined,
    xhr: undefined 
};

/**
 * Handles a user click on the displayed
 * document.
 *
 * @param e Event
 */
function generalOnClickHandler(e) {
    var clickedNode;

    // if we're still downloading source, inform the user
    if (gEditInformation.state == STATE_DOWNLOADING_SOURCE) {
	window.alert("Edit-in-place is still downloading the source text of the " + TOP_LEVEL_TAGNAME + " in the background. " +
		     "Please wait a few seconds and try again.");
	return;
    }

    // if we're editing or don't have sufficient support, return
    if ( (gEditInformation.state != STATE_VIEWING) || (! document.getElementById) || 
	 (! document.createElement) || ( ! gSource.doc  ) ) return;

    // get the node that was clicked 
    if (window.Event) {
	clickedNode = e.target;
    }
    else {
	clickedNode = window.event.srcElement;
    }

    // find an editable node from the clicked node
    var editableNode = findEditableNode(clickedNode);
    if (editableNode) {
	editNode(editableNode);
    }
}


/**
 * Called upon clicking the Revert
 * button during editing.  Replaces
 * the editing machinery (buttons, textboxes)
 * with the clone we made of the 
 * node before editing.
 */
function doRevert() {

    // if we're sending, try to abort
    if (gEditInformation.state == STATE_VALIDATING) {
	try {
	    gPreviewRequest.xhr.abort();
	}
	catch(e) {
	}
    }

    // remove the editing textarea and buttons, replacing with the clone
    // of the original node
    tearDownEditingArea(gEditInformation.editedNodeClone);

    // change back to viewing state
    gEditInformation.state = STATE_VIEWING;
}

/**
 * Cancels editing of this document after
 * soliciting user confirmation.
 */
function doCancel() {

    if (window.confirm("Are you sure that you want to discard all of your changes?")) {
	if (gURLs.module) {
	    window._content.location.href = gURLs.module;
	}
	else {
	    dump("gURLs.module does not exist.  using window.back()\n");
	    window.back();
	}
    }
}

/**
 * Commits changes to the document, unless the
 * user is still in an unfinished editing state.
 */
function doCommit() {

    switch(gEditInformation.state) {
	// ok
    case STATE_VIEWING:
	break;
    case STATE_EDITING:
	window.alert("You are currently editing a node in the document.  Please either finish editing it by clicking the 'Preview' button, or discard your changes to that node by clicking 'Revert'");
	return;
    case STATE_VALIDATING:
	window.alert("Please wait for validation on the node you edited to finish before committing your changes.");
	return;
    default:
	return;
    }
    
    // abort if no commit message
    var commitMsg = document.getElementById(COMMIT_TEXTAREA_ID);
    if ( (!commitMsg) || commitMsg.value == "") {
	window.alert("Please type a brief summary of your changes in the box at the top of " +
		     "the screen.");
	return;
    }

    // serialize the source document
    var cnxmlText = serializeXMLNode(gSource.doc);

    // add it to an input tag
    var hiddenInput = document.createElementNS(XHTML_NS, "input");
    hiddenInput.setAttribute("type", "hidden");
    hiddenInput.setAttribute("name", "moduleText");
    hiddenInput.setAttribute("value", cnxmlText);

    // add the hidden input to the form
    var form = document.getElementById(COMMIT_FORM_ID);
    form.appendChild(hiddenInput);

    form.submit();
}

/**
 * Called upon clicking the Preview
 * button during editing.  Sends the
 * edited text to the preview url
 * for validation and styling.
 */
function doPreview()
{
    gEditNodes.previewButton.disabled = true;

    // validate with the server
    gPreviewRequest.xhr = new XMLHttpRequest();
    gPreviewRequest.xhr.open("POST", gURLs.preview);
    gPreviewRequest.xhr.onreadystatechange = handlePreviewRequest;
    gPreviewRequest.xhr.setRequestHeader('Content-Type', 'application/xml');

    // add namespaces to opening tag for validation
    var openTag = addNamespacesToTagText(gEditInformation.editTagOpeningText);

    // setup send string
    var sendStr = openTag + 
	gEditNodes.textInputArea.value + 
	gEditInformation.editTagClosingText;    

    // store this as the eventual text of the new cnxml node
    gPreviewRequest.nodeReplacementXML = sendStr;

    // prepend the DOCTYPE for our server's benefit
    sendStr = '<!DOCTYPE ' + gSource.nodeBeingEdited.localName + 
	' PUBLIC "' + DOCTYPE_SYSTEM_PART + '" "' + DOCTYPE_PUBLIC_PART + '">\n' + sendStr;

    // set state to validating
    gEditInformation.state = STATE_VALIDATING;

    // send the POST
    gPreviewRequest.xhr.send(sendStr);
}

/**
 * Given a click event, finds the nearest
 * enclosing editable node.
 *
 * @param e Event this function is handling
 */
function findEditableNode(node) {
    
    // find an enclosing element node
    while (node.nodeType != node.ELEMENT_NODE) {
	node = node.parentNode;
    }

    // screen out anchor and input
    if (node.tagName && (node.tagName == INPUT_TAG || node.tagName == ANCHOR_TAG)) {
	return null;
    }

    // move outward until we reach a known tag
    while ( (!gEditableTags[node.localName]) &&
	    (node.localName != TOP_LEVEL_TAGNAME))
	{
	    node = node.parentNode;
	}    
    
    // if we reach top-level tag, we found nothing to edit
    if (node.localName == TOP_LEVEL_TAGNAME) {
	return null;
    }
    // otherwise we found an editable node
    else {
	return node;
    }
}
	
    

/**
 * Edits a node.
 *
 * @param displayNode DOM Node to edit (from the DOM Tree being displayed to
 *                    the user, not the source DOM tree)
 */
function editNode(displayNode)
{

    var tagName;  // tag name of the node we're editing

    // make a deep clone of the original XHTML Node
    gEditInformation.editedNodeClone = displayNode.cloneNode(true);

    // transform tag name to <list> if it was a <ul> or <ol> 
    if (displayNode.localName == UL_TAG || displayNode.localName == OL_TAG) {
	tagName = LIST_TAG;
    }
    else { 
	tagName = displayNode.localName;
    }
    
    // Get the corresponding node in the source DOM tree
    // XXX -- fix me to use getElementById if we can include
    // an inline DTD.  currently, getElementById doesn't work
    // for the CNXML DOM because mozilla does not load external DTDs
    gSource.nodeBeingEdited = getNodeByBruteForce(displayNode.getAttribute("id"), CNXML_NS, tagName, gSource.doc);

    // add any necessary namespaces before serializing the node
    addNamespaceAttributesToNode(gSource.nodeBeingEdited);

    // serialize the node
    var xmlText = serializeXMLNode(gSource.nodeBeingEdited);

    // remove the additional namespaces we added to the edited node
    removeNamespaceAttributesFromNode(gSource.nodeBeingEdited);

    // remove serializer-added namespaces  <a0:..> from xmlText 
    xmlText = removeSerializerNamespacesFromText(xmlText);

    // remove the namespaces that we added from what the user sees in xmlText
    xmlText = removeNamespaceAttributesFromText(xmlText);

    /* remove the top level tag and store it in gEditInformation.editTagOpeningText 
       and gEditInformation.editTagClosingText */
    xmlText = removeAndStoreOuterTagFromText(xmlText);

    // set up the editing environment
    setupEditingArea(displayNode, gEditInformation.editTagOpeningText, 
		     xmlText, gEditInformation.editTagClosingText);

    gEditInformation.state = STATE_EDITING;
}

/**
 * Add the necessary xmlns attributes to a particular
 * node so that the serializer will be able
 * to identify any namespaces used within the node.
 *
 * @param node DOM Element to add namespaces to
 */
function addNamespaceAttributesToNode(node) {
    
    // if the node does not have a namespace attribute, give it the CNXML namespace
    if (! node.hasAttribute("xmlns")) {
	node.setAttribute("xmlns", CNXML_NS);
    }

    // if the node does not have a math namespace attribute, give it the MATHML namespace
    if (! node.hasAttribute("xmlns:m")) {
	node.setAttribute("xmlns:m", MATHML_NS);
    }

}

/**
 * Remove the namespace attributes that were added
 * to a node with addNamespaceAttributesToNode
 * function above.
 *
 * @param node
 */
function removeNamespaceAttributesFromNode(node) {
    
    // remove the CNXML namespace we added
    node.removeAttribute("xmlns");

    // remove the MATHML namespace we added
    node.removeAttribute("xmlns:m");
}

/**
 * Remove the namespace attributes from serialized
 * xmlText that were added with addNamespaceAttributesToNode
 * to the node before serialization.
 *
 * @param xmlText String text of node to be edited
 * @return xmlText, stripped of previously added namespaces
 */
function removeNamespaceAttributesFromText(xmlText) {
    
    xmlText = xmlText.replace(gRegExps.cnxml, "$1$2");
    return xmlText.replace(gRegExps.mathml, "$1$2");
}

/**
 * Adds the necessary namespaces to the text of a tag.
 *
 * @param tag String xmlText of the tag
 * @return the tag text augmented with namespaces
 */
function addNamespacesToTagText(tag) {
  return tag.replace(/(<\S+\s)/,"$1xmlns=\"" + CNXML_NS + "\" ");
}


/**
 * Replaces the node passed in
 * with the editing machinery, setting
 * the editing textarea to the value of parameter
 * xmlText.
 *
 * @param nodeToReplace nsIDOMNode to replace
 * @param openTag String text of the opening tag
 * @param xmlText String text for the editing textarea
 * @param closeTag String text for the closing tag
 */
function setupEditingArea(nodeToReplace, openTag, xmlText, closeTag) {
    // create div to hold all editing stuff
    gEditNodes.containerDiv = document.createElementNS(XHTML_NS, 'div');
    gEditNodes.containerDiv.setAttribute("id", "eipEditContainer");

    // create a textarea
    gEditNodes.textInputArea = document.createElementNS(XHTML_NS, 'textarea');
    gEditNodes.textInputArea.setAttribute("id", "eipXMLEditor");
    gEditNodes.textInputArea.setAttribute("rows", "7");

    // create span to hold opening label
    gEditNodes.openingTagLabel = document.createElementNS(XHTML_NS, 'div');
    gEditNodes.openingTagLabel.setAttribute("id", "eipOpeningTagLabel");
    openingTagTextNode = document.createTextNode(openTag);
    gEditNodes.openingTagLabel.appendChild(openingTagTextNode);
    gEditNodes.openingTagLabel.style.fontWeight = "bold";
   
    // create div to hold closing label
    gEditNodes.closingTagLabel = document.createElementNS(XHTML_NS, 'div');
    gEditNodes.closingTagLabel.setAttribute("id", "eipClosingTagLabel");
    closingTagTextNode = document.createTextNode(closeTag);
    gEditNodes.closingTagLabel.appendChild(closingTagTextNode);
    gEditNodes.closingTagLabel.style.fontWeight = "bold";

    // insert into containerDiv   
    gEditNodes.containerDiv.appendChild(gEditNodes.warningMessage);
    gEditNodes.containerDiv.appendChild(gEditNodes.openingTagLabel);
    gEditNodes.containerDiv.appendChild(gEditNodes.textInputArea);
    gEditNodes.containerDiv.appendChild(gEditNodes.closingTagLabel);
    gEditNodes.containerDiv.appendChild(gEditNodes.previewButton);
    gEditNodes.containerDiv.appendChild(gEditNodes.revertButton);

    var par = nodeToReplace.parentNode;
    par.insertBefore(gEditNodes.containerDiv, nodeToReplace);

    par.removeChild(nodeToReplace);
    gEditNodes.textInputArea.value = xmlText;
    gEditNodes.previewButton.disabled = false;
    gEditNodes.revertButton.disabled = false;
    gEditNodes.textInputArea.focus();
}

/**
 * Tear down the editing area, replacing it
 * with the supplied node.
 */
function tearDownEditingArea(newNode) { 
    
    var parentNode = gEditNodes.containerDiv.parentNode;
    parentNode.insertBefore(newNode, gEditNodes.containerDiv);
    parentNode.removeChild(gEditNodes.containerDiv);

}

/**
 * Called when the ready state of our XMLHttpRequest 
 * changes.  We watch this for when the request is complete.
 */
function handlePreviewRequest() {
     
    // ignore if we've left the validation state or
    // this isn't the completion state
    if (gEditInformation.state != STATE_VALIDATING ||
	gPreviewRequest.xhr.readyState != XHR_COMPLETED) return;

    // if the server returned ok
    if (gPreviewRequest.xhr.status == SERVER_VALIDATION_OK_STATUS) {
	// parse the response
	var newXHTMLDoc, newCNXMLDoc;
	try {
	    newXHTMLDoc = parseXMLTextToDOMDocument(gPreviewRequest.xhr.responseText);
	}
	catch (e) {
	    openErrorWindow("Unable to parse the response text from server. " +
			    "We will revert this node back to its previous state. " +
			    "Please file a bug at http://cnx.rice.edu/forms/bugReport.cfm" +
			    " and provide the following information:\n" + e.toString());
	    return doRevert();
	}

	var newXHTMLNode = document.importNode(newXHTMLDoc.documentElement, true);

	// set the class of this new node to 'edited'
	setNodeAttribute(newXHTMLNode, "edited", "true", true);
	
	try {
	    newCNXMLDoc = parseXMLTextToDOMDocument(gPreviewRequest.nodeReplacementXML);
	    // newCNXMLDoc = parseXMLTextToDOMDocument(replacementXMLWithNamespaces);
	}
	catch(e) {
	    openErrorWindow("Unable to parse the newly edited CNXML text. " +
			    "We will revert the node you were editing back to its previous state. " +
			    "Please file a bug at http://cnx.rice.edu/forms/bugReport.cfm" +
			    " and provide the following information:\n" + e.toString());
	    return doRevert();
	}
	var newCNXMLNode = gSource.doc.importNode(newCNXMLDoc.documentElement, true);
	
	// replace the old cnxml node with the new one
	replaceNode(newCNXMLNode, gSource.nodeBeingEdited);

	// remove the namespaces we added to the new cnxml node
	newCNXMLNode.removeAttribute("xmlns:m");
	newCNXMLNode.removeAttribute("xmlns");

	// replace the editing textarea and buttons with the new DOM Node
	tearDownEditingArea(newXHTMLNode);
	
	gEditInformation.state = STATE_VIEWING;
    }
    else {
	// go back to editing state, turn preview button back on
	gEditInformation.state = STATE_EDITING;
	gEditNodes.previewButton.disabled = false;
	openErrorWindow("The XML you submitted was invalid:\n" + gPreviewRequest.xhr.responseText);
    }
}

/**
 * Parses a String of xml text into 
 * a DOM Node representation of it.
 *
 * @param xmlText String xml text to parse
 * @throws Error if parsing fails
 * @return nsIDOMNode created from xmlText
 */
function parseXMLTextToDOMDocument(xmlText) {
    // XX need to IE-ize
    var domParse = new DOMParser();
    var doc = domParse.parseFromString(xmlText, "text/xml"); 
    if (doc.documentElement.nodeName == "parsererror") {
	var errorMsgArray = [];
	var iteration = iterate(doc.documentElement, Node.TEXT_NODE);
	for (var i = 0; i < iteration.length; i++) {
	    errorMsgArray.push(iteration[i].nodeValue.replace(/\n/, "<br/>"));
	}
	var errorMessage = errorMsgArray.join("");
	throw new Error(errorMessage);
    }
    
    return doc;
}

/**
 * Serialize an XML Node into XML text.
 *
 * @param node to serialize
 * @return xml text
 */
function serializeXMLNode(node) {
    var cheerios = new XMLSerializer();
    return cheerios.serializeToString(node);
}

/**
 * Removes the outermost tag from xml text,
 * and stores the opening and closing versions
 * of the tag in gEditInformation.editTagOpeningText and 
 * gEditInformation.editTagClosingText, respectively.
 */
function removeAndStoreOuterTagFromText(xmlText) {
    xmlText = xmlText.replace(/^(<[^]*?id\=["']([^"']+?)["'][^]*?>)([^]*)(<\/[^]*?>)/,
    function(wholeMatch, openTag, idMatch, contents, closeTag) {
	gEditInformation.editTagOpeningText = openTag;
	gEditInformation.editTagClosingText = closeTag;
	return contents;
    });
    return xmlText;
}

/**
 * Removes the a0: style namespaces
 * that the serializer adds
 * from a String of xml text.
 *
 * @param xmlText String of xml text
 * @return String of xml text purged of namespaces like a0
 */

function removeSerializerNamespacesFromText(xmlText) {

    // remove the a0: style stuff from opening tags with xmlns
    xmlText = xmlText.replace(/<([a-z][0-9]):([^]*?)xmlns:\1\=['"][^]*?["']\s?([^]*?)>/g,
    function(wholeMatch, namespace, keepMeFirst, keepMeSecond) {
	var accumStr = "<" + keepMeFirst;
	if (keepMeSecond) {
	    accumStr += keepMeSecond;
	}
	accumStr += ">";
	return accumStr;
    });
    
    // remove the a0: style stuff from opening tags without xmlns and all closing tags
    return xmlText.replace(/<(\/)?[a-z][0-9]:([^]*?)>/g,
    function(wholeMatch, isCloseTag, tagText) {
	if (isCloseTag) {
	    return "</" + tagText + ">";
	}
	else {
	    return "<" + tagText + ">";
	}
    });
}

/**
 * Extract the link tags 
 * from the document and store
 * their information in the gURLs object.
 *
 * @throw Exception if unable to obtain
 *    necessary links
 */
function extractLinks() {
    
    // find the source link
    var links = document.getElementsByTagName("link");

    // looking for submit, source, authorized
    for (var i = 0; i < links.length; i++) {
	if (links.item(i).hasAttribute("rel")) {
	    var rel = links.item(i).getAttribute("rel");
	    if (rel == "source" || rel == "module") {
		/* XXX could we use a more robust mozilla
		   method of transforming relative to absolute URL? */
		gURLs[rel] = "http://" + window.location.host + links.item(i).getAttribute("href");
	    }
	}
    }
    
    for (item in gURLs) {
	if (! gURLs[item]) {
	    throw new Error("Unable to obtain the necessary link ( " + item + " ) to edit " +
			    "this module.");
	}
    }
}


/**
 * Creates the global DOM Nodes that appear
 * when the user chooses to edit a particular 
 * area of text.
 */
function createEditNodes() {
    
    // create preview button
    gEditNodes.previewButton = document.createElementNS(XHTML_NS, 'button');
    gEditNodes.previewButton.setAttribute("id", "eipPreviewButton");
    gEditNodes.previewButton.setAttribute("alt", "Preview");
    buttonText = document.createTextNode('Preview');
    gEditNodes.previewButton.appendChild(buttonText);
    gEditNodes.previewButton.onclick = doPreview;

    // create revert button
    gEditNodes.revertButton = document.createElementNS(XHTML_NS, 'button');
    gEditNodes.revertButton.setAttribute("alt", "Revert");
    gEditNodes.revertButton.setAttribute("id", "eipRevertButton");
    buttonText = document.createTextNode('Revert');
    gEditNodes.revertButton.appendChild(buttonText);
    gEditNodes.revertButton.onclick = doRevert;

    // create warning message
    gEditNodes.warningMessage = document.createElementNS(XHTML_NS, 'div');
    gEditNodes.warningMessage.setAttribute("id", "eipWarningMessage");
    var wText = document.createTextNode('NOTE: \'Preview\' does NOT save your changes. To do so, you must commit or send a patch from the top of the page.');
    gEditNodes.warningMessage.appendChild(wText);
    gEditNodes.warningMessage.style.fontWeight = "bold";
}
    

/**
 * Download the source for a module.
 */
function downloadSource() {

    // augment url with the current server name
    var url = gURLs.source;

    var xmlRequest = new XMLHttpRequest();

    // open a synchronous request for the xml source of the module
    xmlRequest.open("GET", url, false);

    xmlRequest.setRequestHeader('Accept', 'text/xml');

    // get the source
    xmlRequest.send(undefined);

    if (xmlRequest.status != 200) {	
	if (xmlRequest.responseText) {
	    throw new Error("Unable to download the source text for the module. Received the following error message " +
			    "from the server: " + xmlRequest.responseText);
	}
	else {
	    throw new Error("Unable to download the source text for the module.  The server responded with status: " + xmlRequest.status);
	}
    }
    
    return xmlRequest.responseText;
}
    
/**
 * A simple, dirty tree iterator because
 * the DOM one is frustrating.
 */
function iterate(root, nodeTypeFilter) {
    var nodeArray = [];

    return iterateHelper(root, nodeArray, nodeTypeFilter);
}

function iterateHelper(node, nodeArray, nodeTypeFilter) {
    if (node.nodeType == nodeTypeFilter) {
	nodeArray.push(node);
    }

    if (node.childNodes) {
	for (var i = 0; i < node.childNodes.length; i++) {
	    iterateHelper(node.childNodes.item(i), nodeArray, nodeTypeFilter);
	}
    }

    return nodeArray;
}
 
/**
 * Enumerate the nodes of type nodeTypeToDisplay
 * underneath the given node.
 *
 * @param node nsIDOMNode to enumerate children
 * @param nodeTypeToDisplay display nodes of this type
 *                          - only supports Node.ELEMENT_NODE and 
 *                            Node.TEXT_NODE
 */   
function enumerate(node, nodeTypeToDisplay) {
    var iteration = iterate(node, nodeTypeToDisplay);
    dump("*****************************\n ITERATION of Node\n");
    for (var i = 0; i < iteration.length; i++) {
	switch(iteration[i].nodeType) {
	case Node.TEXT_NODE:
	    dump(iteration[i].nodeValue);
	    break;
	case Node.ELEMENT_NODE:
	    dump(" " + iteration[i].localName + "--> nodeName==" + iteration[i].nodeName + " ");
	    
	    if (iteration[i].getAttribute("id")) {
		dump("id == " + iteration[i].getAttribute("id"));
	    }
	    
	    dump("\n");
	    break;
	default:
	    break;
	}	
    }
}

/**
 * This is a brute force
 * implementation of DOM
 * Document's getElementById method.
 *
 * @param nodeId String id of node to find
 * @param namespace String namespace of node to find
 * @param localName String localName of node to find
 * @param doc nsIDOMDocument to find node in
 * @return found node, or null if not found
 */
function getNodeByBruteForce(nodeId, namespace, localName, doc) {

    var nodes = doc.getElementsByTagNameNS(namespace, localName);
    for (var i = 0; i < nodes.length; i++) {
	if (nodes.item(i).getAttribute("id") == nodeId) {
	    return nodes.item(i);
	}
    }

    dump("getNodeByBruteForce(" + nodeId + ", " +
	 namespace + ", " +
	 localName + ")\n");
    dump("Couldn't find the " + localName + " node with id==" + 
	 nodeId + " in the given document.\n");
    return null;
}

/**
 * Sets an attribute of a node
 * using an Internet-explorer 6 and
 * mozilla compatible method.
 *
 * @param node nsIDOMNode to set attribute for
 * @param name String name of attribute to set
 * @param value String value of attribute
 * @param doc nsIDOMDocument for this node
 */
function setNodeAttribute(node, name, value, deep) {
    if (deep) {
	setNodeAttributeHelp(node, name, value);
    }
    else {
	if (node.nodeType == Node.ELEMENT_NODE) {
	    node.setAttribute(name, value);
	}
    }
}

function setNodeAttributeHelp(node, name, value) {
   
    if (node.nodeType == Node.ELEMENT_NODE) {
	node.setAttribute(name, value);
    }

    var children = node.childNodes;
    for (var i = 0; i < children.length; i++) {
	setNodeAttributeHelp(children.item(i), name, value);
    } 
}

/**
 * Replaces a DOM Node with another DOM Node.
 * There is a DOM method for this, but it
 * appaers not to work.
 *
 * @param newNode nsIDOMNode replacement node
 * @param oldNode nsIDOMNode to replace
 */
function replaceNode(newNode, oldNode) {
    oldNode.parentNode.insertBefore(newNode, oldNode);
    oldNode.parentNode.removeChild(oldNode);

    //enumerate(newNode.parentNode, Node.ELEMENT_NODE);
}

function openErrorWindow(text) {
    if (window.open) {
	var randomNum = Math.random();
	var errorWindow = window.open("about:blank", "error" + randomNum, "height=300,width=500,scrollbars");
	errorWindow.document.write(text);
	return errorWindow;
    }
    else {
	window.alert(text);
	return null;
    }
}


/**
 * Global codeblock to create the edit-in-place
 * tools and add the event handler.
 */
function initEip()
{
    if (document.getElementById && document.createElement) {
	var buttonText;
	createEditNodes();
	
	try {
	    
	    // extract the links from link tags
	    extractLinks();
	    
	    // download the source
	    gSource.source = downloadSource();
	    
	    // parse it to a DOM Tree
	    gSource.doc = parseXMLTextToDOMDocument(gSource.source);
	    
	    gEditInformation.state = STATE_VIEWING;
	    
	    // get the top level tag, apply the onclick
	    document.getElementsByTagNameNS(TOP_LEVEL_TAG_NS, TOP_LEVEL_TAGNAME)[0].onclick = generalOnClickHandler;
	}
	catch(e) {
	    openErrorWindow("Editing DISABLED due to the following error:  " + e.toString());	
	    gEditInformation.state = STATE_BROKEN;
	}
    }
}
