function getExerciseSolution(id) {
    children = document.getElementById(id).getElementsByTagName("div");
    for (var i = 0; i < children.length; i++)
	if (children.item(i).getAttribute('class') == 'solution')
	    return children.item(i);
}

function getSolutionButton(id) {
    children = document.getElementById(id).getElementsByTagName("div");
    for (var i = 0; i < children.length; i++)
	if (children.item(i).getAttribute('class') == 'button')
	    return children.item(i);
}

function showSolution(id){
    getExerciseSolution(id).style.display="block";
    getSolutionButton(id).style.display="none";
}

function hideSolution(id) {
    getExerciseSolution(id).style.display="none";
    getSolutionButton(id).style.display="block";
}
