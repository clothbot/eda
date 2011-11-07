default : usage

usage :
	@echo "Usage:"
	@echo "  make all"

all : tmp300

tmp300 : tempctrl_tmp300_brd.scad

tempctrl_tmp300_brd.scad :
	xsltproc -o tempctrl_tmp300_brd.scad xsl/eagle2scad.xsl designs/TMP300/tempctrl_tmp300_eagle6beta.brd 

clean :
	$(RM) tempctrl_tmp300_brd.scad
