CSS Styles
==========

cnxml_bw.css: Black and White style for CNXML (Chris)
xhtml_bw.css: Black and White style for XHTML (Chris)
 html_bw.css: Black and White style for HTML (Allison)

cnxml_max.css: Max's style sheet for CNXML (Max)
cnxml_max.css: Max's style sheet for XHTML (Max)

cnxml_pastel.css: Original style look with pastel colors (Amie)
xhtml_pastel.css: Original style look with pastel colors (Amie)

cnxml_ice.css: Ice look style sheet for CNXML (Chris)

xhtml_teal.css: The original style sheet for XHTML (Sarah)


Stylesheet modules
==================

ident: passes through every tag/attribute/text/comment as is.
       Meant to be used as the default

corecnxml: transforms some core CNXML tags into XHTML (the ones we
	   can't do with CSS)

htmlcorecnxml: transforms some core CNXML into HTML (targeted for IE)

mathmlc2p: transforms content MathML into presentation MathML

iemath.xsl: transforms content MathML into presentation MathML) for
	    techexplorer

cnxmathmlc2p: some of our special modifications to abover transform

cnxmacros.xsl: Connexions math macros

qml.xsl: converts QML into XHTML

tablel.xsl: converts CALS tables to XHTML


Full stylesheets (pull in above modules, possibly adding more)
================


basic.xsl: the minimum transformation for putting CNXML on the web

basicmath.xsl: the minimum transformation for putting CNXML+MathML on
	       the web

xhtml.xsl: full CNXML->xhtml conversion

xhtmlmath.xsl: full CNXML+contentMathML -> XHTML+presMathML conversion

html.xsll: full CNXML->html conversion

htmlmath.xsl: full CNXML+contentMathML -> HTMML+presMathML(for
	      techexplorer) conversion

spec.xsl: full CNXML->XHTML transform with nice "spec" addons

