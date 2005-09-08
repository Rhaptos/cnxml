SOURCES = appendixa.cnxml \
	  doctype.cnxml \
	  entities.cnxml \
	  intro.cnxml \
	  mathml.cnxml \
	  spec.cnxml \
	  tags.cnxml \
	  tagsoup.cnxml

spec.xml: $(SOURCES) spec.xsl
	saxon -o spec.xml spec.cnxml spec.xsl