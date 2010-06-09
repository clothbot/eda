// Pin Socket

render_part=0;
// render_part=1; // pin_socket()

module pin_socket(
	pinH=10.0
	, socketH=2.5
	, pinW=1.6
	, socketW=2.0
	) {
  $fs=0.1;
  $fa=60.0;
  translate([0,0,-pinH])
	cylinder(r=pinW/2,h=pinH+socketH,center=false);
  cylinder(r=socketW/2,h=socketH,center=false);
}

if(render_part==1) {
  echo("Rendering pin_socket...");
  pin_socket();
}

