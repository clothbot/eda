OPENSCAD=/Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD

default : usage

usage :
	@echo "Usage:"
	@echo "  make all"

all : test_cube.stl test_slicer.scad test_slicer.dxf adns2610_test.dxf

test_cube.stl :
	echo "difference() {" > test_cube.scad
	echo "  cube(size=10.0);" >> test_cube.scad
	echo "  cube(size=8.0);" >> test_cube.scad
	echo "}" >> test_cube.scad
	$(OPENSCAD) -s test_cube.stl test_cube.scad

test_slicer.scad : test_cube.stl
	echo "use <slicer.scad>" > test_slicer.scad
	echo "slicer(slice_z_index=5,slice_z_thickness=0.25) {" >> test_slicer.scad
	echo "  import_stl("'"'"test_cube.stl"'"'");" >> test_slicer.scad
	echo "}" >> test_slicer.scad

test_slicer.dxf : test_slicer.scad
	$(OPENSCAD) -x test_slicer.dxf test_slicer.scad

adns2610_test.dxf :
	echo "use <slicer.scad>" > adns2610_test.scad
	echo "slicer(slice_z_index=0,slice_z_thickness=0.25) {" >> adns2610_test.scad
	echo "  import_stl("'"'"adns2610_dev_circuit_inv_noNulls.stl"'"'");" >> adns2610_test.scad
	echo "}" >> adns2610_test.scad
	$(OPENSCAD) -x adns2610_test.dxf adns2610_test.scad

clean :
	$(RM) test_cube.scad test_cube.stl
	$(RM) test_slicer.scad test_slicer.dxf
	$(RM) adns2610_test.scad adns2610_test.dxf
