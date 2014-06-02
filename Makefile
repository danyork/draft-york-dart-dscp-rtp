
SRC  := $(wildcard draft-*.xml)
WSRC  := $(wildcard *.wsd)

HTML := $(patsubst %.xml,%.html,$(SRC))
TXT  := $(patsubst %.xml,%.txt,$(SRC))
DIF  := $(patsubst %.xml,%.diff.html,$(SRC))
PDF  := $(patsubst %.xml,%.pdf,$(SRC))
SVG  := $(patsubst %.wsd,%.svg,$(WSRC))

#all: $(HTML) $(TXT) $(DIF) $(PDF)
all: $(HTML) $(TXT) 

clean:
	rm -f *~ draft*.html draft*pdf draft-*txt $(SVG)

#%.html: %.xml
#	xsltproc -o $@ rfc2629.xslt $^

%.html: %.xml
	xml2rfc --html $^ -o $@


%.txt: %.xml
	xml2rfc --text $^ -o $@

%.diff.html: %.txt.old %.txt 
	htmlwdiff  $^ >  $@

%.pdf: %.html  $(SVG)
	wkpdf -p letter -s $^ -o $@

%.svg: %.wsd
	node ~/bin/ladder.js $^ $@

%.png: %.svg
	java -jar batik-rasterizer.jar $^ -d $@ -bg 255.255.255.255



