// Pin Socket

pin_socket_render_part=0;
// pin_socket_render_part=1; // pin_socket()

module pin_socket(
	pinH=10.0
	, socketH=2.5
	, pinW=1.6
	, socketW=2.0
	) {
  $fs=0.1;
  $fa=60.0;
  union() {
   translate([0,0,-pinH])
	cylinder(r=pinW/2,h=pinH+socketH,center=false);
   cylinder(r=socketW/2,h=socketH,center=false);
  }
}

if(pin_socket_render_part==1) {
  echo("Rendering pin_socket...");
  pin_socket();
}

