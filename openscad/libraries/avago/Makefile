OPENSCAD=/Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD

default : usage

usage :
	@echo "Usage:"
	@echo "  make all"
	@echo "  make adns2610.stl"
	@echo "  make adns2610_oc0.stl"
	@echo "  make adns2610_pin_sockets.stl"
	@echo "  make adns2610_dev_circuit.stl"
	@echo "  make adns2610_dev_circuit_inv.stl"

all : adns2610.stl adns2610_oc0.stl adns2610_pin_sockets.stl adns2610_dev_circuit.stl adns2610_dev_circuit_inv.stl

adns2610.stl :
	$(OPENSCAD) -D adns2610_render_part=1 -s adns2610.stl adns-2610.scad

adns2610_oc0.stl :
	$(OPENSCAD) -D adns2610_render_part=2 -s adns2610_oc0.stl adns-2610.scad

adns2610_pin_sockets.stl :
	$(OPENSCAD) -D adns2610_render_part=4 -s adns2610_pin_sockets.stl adns-2610.scad

adns2610_dev_circuit.stl :
	$(OPENSCAD) -D adns2610_render_part=5 -s adns2610_dev_circuit.stl adns-2610.scad

adns2610_dev_circuit_inv.stl :
	$(OPENSCAD) -D adns2610_render_part=6 -s adns2610_dev_circuit_inv.stl adns-2610.scad

clean :
	$(RM) *.stl

