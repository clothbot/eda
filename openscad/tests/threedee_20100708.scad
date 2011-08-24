module triplicate(s) {
	for (i = [0:2]) rotate([0,0,120*i]) translate([-s/3,0])
		rotate([0,0,60]) translate([s/6,0]) child(0);
}

module flakeSide(s) {
	polygon(points = [[-s/2, 0], [0, -sqrt(3)*s/6], [s/2, 0]]);
}

module flake0Body(s, n, rs, c) {
	if ((s - 6*n*(2*rs + c)/sqrt(3)) > 0)
		triplicate(s - 6*n*(2*rs + c)/sqrt(3))
			flakeSide(s - 6*n*(2*rs + c)/sqrt(3));
	else cube([2,2,2], center = true);	/* just an error case */
}

translate([0,0]) difference() {
	linear_extrude(height=2.0, center=true) flake0Body(9,0,1/2,1/10);
	linear_extrude(height=3.0, center=true) flake0Body(9,1,1/2,1/10);
}
