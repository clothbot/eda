// Fill pattern.

module bars(
	spacing=1.0
	, barWidth=1.0
	, minLength=10
	, minWidth=10
	, angle=0
	) {
  rotate([0,0,angle]) {
	square(size=[barWidth,minWidth], center=true);
    assign( barCount=(minLength-(minLength)%(spacing+barWidth))/(spacing+barWidth) ) {
     for ( ln = [1 : 
		(barCount-barCount%2)/2+1 ] ) {
      translate([ln*(spacing+barWidth),0])
        square(size=[barWidth,minWidth], center=true);
      translate([-ln*(spacing+barWidth),0])
        square(size=[barWidth,minWidth], center=true);
     }
    }
  }
}

module fill_linear(
	spacing=2.0
	, barWidth=2.0
	, minLength=100
	, minWidth=100
	, angle=0
	) {
  for ( i = [0 : $children-1] ) {
    intersection () {
      child(i);
      bars(spacing=spacing,barWidth=barWidth,minLength=minLength,minWidth=minWidth,angle=angle);
    }
  }
}

translate([0,0,-0.5]) color([0.5,0.5,0.5]) cube(size=[100,100,1.0],center=true);
bars(
	spacing=2.0
	, barWidth=1.0
	, minLength=100
	, minWidth=100
	, angle=0
	);

translate([0,0,2]) fill_linear(spacing=1.0,minLength=20,minWidth=20) {
   circle(r=10.0);
  }
translate([0,0,4]) fill_linear(spacing=2.0,minLength=20,minWidth=20, angle=60) {
   circle(r=10.0);
  }
translate([0,0,6]) fill_linear(spacing=3.0,minLength=20,minWidth=20, angle=120) {
  circle(r=10.0);
 }
