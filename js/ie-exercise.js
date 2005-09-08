/**
 * Get exercise solution 'div' within element indicated
 * by parameter id.
 *
 * @param id String id of problem
 * @return nsIDOMElement 'div' of solution, or null if not found
 */
function getExerciseSolution(id) {
    var children = document.getElementById(id).getElementsByTagName("div");
   
    for (var i = 0; i < children.length; i++) {
	var attribs = children.item(i).attributes;
	var classAtr = attribs.getNamedItem("class");
	
	if (classAtr.nodeValue == 'solution') {
	    return children.item(i);
	}
    }
    return null;
}

/**
 * Get solution buttong 'div' within element indicated
 * by parameter id.
 *
 * @param id String id of problem
 * @return nsIDOMElement 'div' of solution button, or null if not found
 */
function getSolutionButton(id) {
    var children = document.getElementById(id).getElementsByTagName("div");

    for (var i = 0; i < children.length; i++) {
	var attribs = children.item(i).attributes;
	var classAtr = attribs.getNamedItem("class");
	
	if (classAtr.nodeValue == 'button')
	    return children.item(i);
    }
    return null;
}

/**
 * Show the solution of problem indicated
 * by id.
 *
 * @param id String id of problem
 */
function showSolution(id){
    getExerciseSolution(id).style.display="block";
    getSolutionButton(id).style.display="none";
}

/**
 * Hide the solution of problem indicated
 * by id.
 *
 * @param id String id of problem
 */
function hideSolution(id) {
    getExerciseSolution(id).style.display="none";
    getSolutionButton(id).style.display="block";
}

