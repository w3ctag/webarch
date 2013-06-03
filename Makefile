# Support for idempotently converting between XHTML and HTML5 for respec docs
# Fragile, use at your own risk!
SAXON=saxon92
TIDY=ntidy

%.html: %.xhtml to5.xsl tidyconfig.txt
	rxp -o d "$<" | $(SAXON) - to5.xsl | \
	 $(TIDY) -utf8 -ashtml -config tidyconfig.txt --doctype html5 | \
	sed -e '4,6d' \
	    -e '/specStatus:/s/unofficial/ED/' > "$@"

%.xhtml: %.html
	sed  -e '4s/charset="/name="Content-Type" content="charset: /' \
	     -e '/specStatus:/s/ED/unofficial/' \
	     -e 's/<section\([^>]*class="\)/<div\1section /g' \
	     -e 's/<\(section\|figure\|figcaption\)/<div class="\1"/g' \
	     -e 's/<\/\(section\|figure\|figcaption\)>/<\/div>/' "$<" | $(TIDY) -utf8 -asxml | \
	sed '1s@.*@<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">@' | rxp -d | \
	sed -e '/<script class="remove">/s/$$/<![CDATA[/' \
	    -e '/^<!\[CDATA\[/d' \
	    -e '/    };/s/$$/]]>/' \
	    -e '/^]]>/d' > "$@"
