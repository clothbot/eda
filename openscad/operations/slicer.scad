// Module for slicing operations

module slicer(
        slice_z_index=0
        , slice_z_thickness=0.25
        ) {
  for (i = [0 : $children-1]) {
   projection(cut=true) {
    translate([0,0,-slice_z_index*slice_z_thickness-slice_z_thickness/2])
      child(i);
   }
  }
}

module slicer_slab(
        slice_z_index=0
        , slice_z_thickness=0.25
	, slice_w=100
	, slice_l=100
        ) {
  union () for (i = [0 : $children-1]) {
   projection(cut=false) {
    intersection () {
      translate([0,0,slice_z_index*slice_z_thickness]) cube(size=[slice_w,slice_l,slice_z_thickness], center=true);
      child(i);
    }
   }
  }
}

