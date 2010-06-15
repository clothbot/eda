OPENSCAD=/Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD

default : usage

usage :
	@echo "Usage:"
	@echo "  make all"
	@echo "  make fcr_m6.stl"

all : fcr_m6.stl

fcr_m6.stl :
	$(OPENSCAD) -D fcr_m6_render_part=1 -s fcr_m6.stl fcr_m6.scad

clean :
	$(RM) *.stl

