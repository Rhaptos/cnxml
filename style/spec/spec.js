//show and hide the table of contents creates by the xsl on the side
//of the spec
function createToc()
{
    toc = document.getElementById('tableofcontents');
    html = document.documentElement;
    
    if (toc.style.display != "block") {
	toc.style.display = "block";
	html.style.marginLeft = "17em";
    } else {
	toc.style.display = "none";
	html.style.marginLeft = "0";
    }
}

