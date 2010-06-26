OPENSCAD=/Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD
JOBPOOL=/opt/local/bin/jobpool -j 2 

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
	@echo "  make sliced_stl"
	@echo "  make sliced_slab"
	@echo "  make sliced shelled"
	@echo "  make sliced shelled fill_mask"

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
		$(JOBPOOL) $(OPENSCAD) -D adns2610_render_part=7 -D slice_z_index=$$i -D slice_z_thickness=0.35 -x slice.$$i.dxf adns-2610.scad & \
		i=$$[$$i+1] ;\
		done

sliced_stl : adns2610_dev_circuit_inv.stl
	echo "use <../../operations/slicer.scad>" > sliced_stl.scad 
	echo "slice_z_index=0;" >> sliced_stl.scad 
	echo "slice_z_thickness=0.35;" >> sliced_stl.scad 
	echo "module slice_stl() {" >> sliced_stl.scad 
	echo "  import_stl("'"'"adns2610_dev_circuit_inv.stl"'"'");" >> sliced_stl.scad 
	echo "}" >> sliced_stl.scad 
	echo "slicer(slice_z_index=slice_z_index,slice_z_thickness=slice_z_thickness) {" >> sliced_stl.scad 
	echo "  slice_stl();" >> sliced_stl.scad 
	echo "}" >> sliced_stl.scad 
	i="0" ;\
	while [ $$i -lt 10 ] ; do \
		echo " Slice "$$i"..." ;\
		$(JOBPOOL) $(OPENSCAD) -D adns2610_render_part=7 -D slice_z_index=$$i -D slice_z_thickness=0.35 -x sliced_stl.$$i.dxf sliced_stl.scad & \
		i=$$[$$i+1] ;\
		done

sliced_slab :
	i="0" ;\
	while [ $$i -lt 10 ] ; do \
		echo " Slice "$$i"..." ;\
		$(JOBPOOL) $(OPENSCAD) -D adns2610_render_part=9 -D slice_z_index=$$i -D slice_z_thickness=0.35 -x slice_slab.$$i.dxf adns-2610.scad & \
		i=$$[$$i+1] ;\
		done

shelled :
	for file in slice.*.dxf ; do \
		echo "Creating shell.$$file..." ; \
		echo "use <../../operations/shell.scad>" > shell.$$file.scad ; \
		echo "shell_2D(shell_minWall=1.5*0.35) {" >> shell.$$file.scad ; \
		echo "  import_dxf("'"'"$$file"'"'");" >> shell.$$file.scad ; \
		echo "}" >> shell.$$file.scad ; \
		$(JOBPOOL) $(OPENSCAD) -x shell.$$file shell.$$file.scad & \
		echo "Done creating shell.$$file." ; \
		done

fill_mask :
	for file in slice.*.dxf ; do \
		echo "Creating fill_mask.$$file..." ; \
		echo "difference () {" > fill_mask.$$file.scad ; \
		echo "  import_dxf("'"'"$$file"'"'");" >> fill_mask.$$file.scad ; \
		echo "  import_dxf("'"'"shell.$$file"'"'");" >> fill_mask.$$file.scad ; \
		echo "}" >> fill_mask.$$file.scad ; \
		$(JOBPOOL) $(OPENSCAD) -x fill_mask.$$file fill_mask.$$file.scad & \
		echo "Done creating fill_mask.$$file." ; \
		done

clean :
	$(RM) *.stl
	$(RM) *.dxf
	$(RM) shell.*.scad
	$(RM) fill_mask.*.scad
	$(RM) sliced_stl.scad

