
function getExerciseSolution(id) {
    return _getDivByClass(document.getElementById(id), "solution");
}

function getSolutionButton(id) {
    return _getDivByClass(document.getElementById(id), "button");
}


// Iterates through all descendants and returns the first one with the
// specified class attribute
function _getDivByClass(element, classValue) {
    divList =  element.getElementsByTagName("div");

    for (var i = 0; i < divList.length; i++) {
	if (divList.item(i).getAttribute("class") == classValue) {
	    return divList.item(i);
	}
    }
}


function showSolution(id){
    getExerciseSolution(id).style.display="block";
    getSolutionButton(id).style.display="none";
}

function hideSolution(id) {
    getExerciseSolution(id).style.display="none";
    getSolutionButton(id).style.display="block";
} 
