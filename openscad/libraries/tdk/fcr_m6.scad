// TDK Corporation
// FCR24.0M6T
// Ceramic Resonator, 24MHz, 2 pin
// http://search.digikey.com/scripts/DkSearch/dksus.dll?Detail&name=445-2571-1-ND
// http://www.tdk.co.jp/tefe02/ef32_fcr.pdf

fcr_m6_render_part=1;

module fcr_m6(
	pinColor=[192/255,192/255,0]
        , bodyColor=[0.0,0.5,1.0]
  ) {
  $fs=0.1;
  $fa=15;
  union() {
   // pin 1
   color(pinColor) {
    translate([0,0,-5.0])
      cylinder(r=0.55/2,h=5.0,center=false);
    sphere(r=0.55/2);
   }
   // pin 2
   color(pinColor) {
    translate([6.0,0,-5.0])
      cylinder(r=0.55/2,h=5.0,center=false);
    sphere(r=0.55/2);
   }
   // body
   color(bodyColor) translate([0,-2.0,0])
    cube(size=[6.0,4.0,7.0], center=false);
  }
}

if( fcr_m6_render_part==1 ) {
  echo("Rendering fcr_m6...");
  fcr_m6();
}
