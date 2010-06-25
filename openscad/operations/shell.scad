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

