OPENSCAD=/Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD

default : usage

usage :
	@echo "Usage:"
	@echo "  make all"
	@echo "  make adns2610.stl"
	@echo "  make adns2610_oc0.stl"

all : adns2610.stl adns2610_oc0.stl

adns2610.stl :
	$(OPENSCAD) -D render_part=1 -s adns2610.stl adns-2610.scad

adns2610_oc0.stl :
	$(OPENSCAD) -D render_part=2 -s adns2610_oc0.stl adns-2610.scad

clean :
	$(RM) *.stl

