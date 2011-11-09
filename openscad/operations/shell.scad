// Create shell from 2D and 3D objects

module shell_2D(
	shell_minWall=0.25
	) {
  for (i = [0 : $children-1]) {
    union() {
      difference() {
	child(i);
	translate([shell_minWall,0]) child(i);
      }
      difference() {
	child(i);
	translate([shell_minWall/sqrt(2),shell_minWall/sqrt(2)]) child(i);
      }
      difference() {
	child(i);
	translate([0,shell_minWall]) child(i);
      }
      difference() {
	child(i);
	translate([-shell_minWall/sqrt(2),shell_minWall/sqrt(2)]) child(i);
      }
      difference() {
	child(i);
	translate([-shell_minWall,0]) child(i);
      }
      difference() {
	child(i);
	translate([-shell_minWall/sqrt(2),-shell_minWall/sqrt(2)]) child(i);
      }
      difference() {
	child(i);
	translate([0,-shell_minWall]) child(i);
      }
      difference() {
	child(i);
	translate([shell_minWall/sqrt(2),-shell_minWall/sqrt(2)]) child(i);
      }
    }
  }
}

module shell_spherical(wall_th=2.0
	, polar_res=4
	, rot_res=4
	) {
  union() {
    for(k=[0:$children-1]) for(i=[0:rot_res-1]) for(j=[0:polar_res-1]) assign(rotAngle=360*i/rot_res, polarAngle=180*j/polar_res-90) {
      render() difference() {
	child(k);
	translate([-wall_th*sin(polarAngle)*cos(rotAngle),-wall_th*sin(polarAngle)*sin(rotAngle),-wall_th*cos(polarAngle)]) child(k);
      }
    }
  }
}

