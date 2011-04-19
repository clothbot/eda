// Testing shell_spherical()

module shell_spherical(wall_th=2.0
        , polar_res=4
        , rot_res=4
        ) {
  union() {
    for(k=[0:$children-1]) for(i=[0:rot_res-1]) for(j=[0:polar_res-1]) assign(rotAngle=360*i/rot_res, polarAngle=180*j/polar_res-90) {
      render() difference() {
        child(k);
        translate([-wall_th*sin(polarAngle)*cos(rotAngle),-wall_th*sin(polarAngle)*cos(rotAngle),-wall_th*cos(polarAngle)]) child(k);
      }
    }
  }
}

difference() {
  shell_spherical(wall_th=1.0, polar_res=6,rot_res=6)
	// cube(size=[10,10,10],center=true);
	sphere(r=5,center=true);
  cube(size=[10,10,10],center=false);
}

