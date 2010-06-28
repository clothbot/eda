// MakerBot operators and parameters
use <slicer.scad>

mb_cc_minx=-50.0; // MakerBot CupCake minimum X axis coordinate (mm)
mb_cc_maxx=50.0; // MakerBot CupCake maximum X axis coordinate (mm)
mb_cc_miny=-50.0; // MakerBot CupCake minimum Y axis coordinate (mm)
mb_cc_maxy=50.0; // MakerBot CupCake maximum Y axis coordinate (mm)
mb_cc_minz=0.0; // MakerBot CupCake minimum Z axis coordinate (mm)
mb_cc_maxz=130.0; // MakerBot CupCake maximum Z axis coordinate (mm)

mb_ps_nozzle_diam=0.5; // MakerBot Plastruder nozzle diameter (mm)

filament_d=0.58; // measured filament diameter (mm)
echo("Measured Filament Diameter (mm): ",filament_d);
layer_thickness=0.4; // layer thickness in Z axis (mm)
echo("Layer Thickness (mm): ",layer_thickness);

function calc_filament_area(fd) = 3.141592*pow(fd/2,2);
function calc_wall_width(fd,dz) = calc_filament_area(fd)/dz; // calculated wall thickness (mm)
echo("Calculated Wall Width (mm): ",calc_wall_width(filament_d,layer_thickness));

function calc_max_slice_index(dz,minz,maxz) = (maxz-minz-(maxz-minz)%dz)/dz;
echo("Calculated Maximum Slice Index (int): ",calc_max_slice_index(layer_thickness,mb_cc_minz,mb_cc_maxz),"(int)");
echo("  Calculated Maximum Slice Z Position (mm): ",mb_cc_minz+layer_thickness*calc_max_slice_index(layer_thickness,mb_cc_minz,mb_cc_maxz));

module draw_build_platform() {
  translate([mb_cc_minx,mb_cc_miny,mb_cc_minz-1.0]) 
    cube(size=[mb_cc_maxx-mb_cc_minx,mb_cc_maxy-mb_cc_miny,1.0],center=false);
}

module draw_quantized_model(draw_layer_thickness=layer_thickness,draw_layer_space=0.0) {
  for (i = [0 : $children-1]) {
    for (k = [0 : calc_max_slice_index(layer_thickness,mb_cc_minz,mb_cc_maxz)-1]) {
      translate([0,0,mb_cc_minz+k*(draw_layer_thickness+draw_layer_space)]) linear_extrude(height=draw_layer_thickness,center=false) {
	slicer(slice_z_index=k,slice_z_thickness=layer_thickness) {
	    cylinder(r1=10,r2=0,h=10,center=false);
	}
      }
    }
  }
}

color([0.7,0,0]) draw_build_platform();
color([0,1.0,0]) draw_quantized_model(draw_layer_space=1.0);
