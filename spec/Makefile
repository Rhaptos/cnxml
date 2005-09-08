SOURCES = appendixa.cnxml \
	  bodytags.cnxml \
	  doctype.cnxml \
	  entities.cnxml \
	  headertags.cnxml \
	  intro.cnxml \
	  mathml.cnxml \
	  spec.cnxml \
	  tags.cnxml

spec.xml: $(SOURCES) spec.xsl
	saxon -o spec.xml spec.cnxml spec.xsl