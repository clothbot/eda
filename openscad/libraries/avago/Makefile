OPENSCAD=/Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD

# include gmsl
# c_val := 0
# counter = $(c_val)$(eval c_val := $(call plus,$(c_val),1))

default : usage

usage :
	@echo "Usage:"
	@echo "  make all"
	@echo "  make adns2610.stl"
	@echo "  make adns2610_oc0.stl"
	@echo "  make adns2610_pin_sockets.stl"
	@echo "  make adns2610_dev_circuit.stl"
	@echo "  make adns2610_dev_circuit_inv.stl"
	@echo "  make sliced"

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

sliced :
	i="0" ;\
	while [ $$i -lt 10 ] ; do \
		echo " Slice "$$i"..." ;\
		$(OPENSCAD) -D adns2610_render_part=7 -D slice_z_index=$$i -D slice_z_thickness=0.35 -x slice.$$i.dxf adns-2610.scad ;\
		i=$$[$$i+1] ;\
		done
#		$(counter) ;\

clean :
	$(RM) *.stl

