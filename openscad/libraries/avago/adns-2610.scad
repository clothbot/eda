// Model of Avago Technologies ADNS-2610

// Pin 1 is [0,0,0] unless using adns2610_oc0

// adns2610_render_part=0;
// adns2610_render_part=1; // adns2610()
// adns2610_render_part=2; // adns2610_oc0()
// adns2610_render_part=3; // parametric adns2610_oc0 example
use <../generic/pin_socket.scad>
// adns2610_render_part=4; // render pin_socket at pin locations
use <../tdk/fcr_m6.scad>
// adns2610_render_part=5; // render adns2610 with pin sockets and ceramic resonator sockets.
adns2610_render_part=6; // render inverse adns2610 with pin sockets and ceramic resonator sockets.

module adns2610_pin(
	pinDTh=0.0
	, pinDH=0.0
        , pinH=5.15
        , pinTh=0.25
        , pinWB=0.50
        , pinWT=0.90
        , pin2TH=1.00
        , pkgB2TH=3.18
	, pin2pkg=(12.85-9.10)/2
	, pinColor=[192/255,192/255,0]
        ) {
  $fs=0.1;
  $fa=15;
  color(pinColor) {
    translate([-pinWB/2,-(pinTh+pinDTh)/2,pkgB2TH-pinH-pinDH-pin2TH])
        cube(size=[pinWB, (pinTh+pinDTh), pinH+pinDH], center=false);
    translate([-pinWT/2, -(pinTh+pinDTh)/2, 0])
        cube(size=[pinWT, (pinTh+pinDTh), pkgB2TH-pin2TH], center=false);
    translate([-pinWT/2, -(pinTh+pinDTh)/2, pkgB2TH-pin2TH]) rotate([-90,0,0])
        cube(size=[pinWT, (pinTh+pinDTh), pin2pkg+pinTh], center=false);
  }
}

module adns2610_placeAtPinLocations(
	pin2pin=2.00
	, row2row=12.85
	) {
  for (i = [0 : $children-1]) {
    // pin1
    child(i);
    // pin2
    translate([pin2pin,0,0])
      child(i);
    // pin3
    translate([2*pin2pin,0,0])
      child(i);
    // pin4
    translate([3*pin2pin,0,0])
      child(i);
    // pin5
    translate([3*pin2pin-pin2pin/2,row2row,0]) rotate([0,0,180])
      child(i);
    // pin6
    translate([2*pin2pin-pin2pin/2,row2row,0]) rotate([0,0,180])
      child(i);
    // pin7
    translate([1*pin2pin-pin2pin/2,row2row,0]) rotate([0,0,180])
      child(i);
    // pin8
    translate([-pin2pin/2,row2row,0]) rotate([0,0,180])
      child(i);
  }
}

module adns2610_placeAtPin(
	pinNumber=1
	, pin2pin=2.00
	, row2row=12.85
	) {
  for (i = [0 : $children-1]) {
    // pin1
    if( pinNumber == 1 ) 
     child(i);
    // pin2
    if( pinNumber == 2 ) 
     translate([pin2pin,0,0])
      child(i);
    // pin3
    if( pinNumber == 3 ) 
     translate([2*pin2pin,0,0])
      child(i);
    // pin4
    if( pinNumber == 4 ) 
     translate([3*pin2pin,0,0])
      child(i);
    // pin5
    if( pinNumber == 5 ) 
     translate([3*pin2pin-pin2pin/2,row2row,0]) rotate([0,0,180])
      child(i);
    // pin6
    if( pinNumber == 6 ) 
     translate([2*pin2pin-pin2pin/2,row2row,0]) rotate([0,0,180])
      child(i);
    // pin7
    if( pinNumber == 7 ) 
     translate([1*pin2pin-pin2pin/2,row2row,0]) rotate([0,0,180])
      child(i);
    // pin8
    if( pinNumber == 8 ) 
     translate([-pin2pin/2,row2row,0]) rotate([0,0,180])
      child(i);
  }
}

module adns2610(
	pinDTh=0.0
	, pinDH=0.0
	, opticalDD=0.0
	, opticalDZ=0.0
	, pinH=5.15
	, pinTh=0.25
	, pinWB=0.50
	, pinWT=0.90
	, pin2TH=1.00
	, pkgB2TH=3.18
	, pin2pin=2.00
	, pin2pkg=(12.85-9.10)/2
	, row2row=12.85
	, pkgW=9.10
	, pkgL=9.90
	, opticalXC=2.00
	, opticalYC=4.55+(12.85-9.10)/2
	, opticalD=5.60
	, opticalZ=1.42
	, bodyColor=[64/255,64/255,64/255]
	) {
  color(bodyColor) {
    // package
    translate([opticalXC-4.45,opticalYC-4.55,0])
      cube(size=[pkgL, pkgW, pkgB2TH],center=false);
    // optical path
    translate([opticalXC,opticalYC,-opticalZ-opticalDZ])
      cylinder($fa=15, $fs=0.1, r=(opticalD+opticalDD)/2,h=opticalZ+opticalDZ,center=false);
    // optical path top marker
    translate([opticalXC,opticalYC,-0.1]) cylinder($fa=15, $fs=0.1, r=opticalD/2,h=pkgB2TH+0.2,center=false);
  }
  // pin1 indicator
  color([1,1,1]-bodyColor)
    translate([0,pin2pkg+1.0,pkgB2TH]) sphere($fa=30, $fs=0.1, r=0.5,center=true);
  adns2610_placeAtPinLocations(
	pin2pin=pin2pin
	, row2row=row2row
	) {
    adns2610_pin( pinDTh=pinDTh, pinDH=pinDH, pinH=pinH , pinTh=pinTh , pinWB=pinWB , pinWT=pinWT , pin2TH=pin2TH , pkgB2TH=pkgB2TH, pin2pkg=pin2pkg);
  }
}

module adns2610_oc0(
	pinDTh=0.0
	, pinDH=0.0
	, opticalDD=0.0
	, opticalDZ=0.0
	, pinH=5.15
	, pinTh=0.25
	, pinWB=0.50
	, pinWT=0.90
	, pin2TH=1.00
	, pkgB2TH=3.18
	, pin2pin=2.00
	, pin2pkg=(12.85-9.10)/2
	, row2row=12.85
	, pkgW=9.10
	, pkgL=9.90
	, opticalXC=2.00
	, opticalYC=4.55+(12.85-9.10)/2
	, opticalD=5.60
	, opticalZ=1.42
	) {
  translate([-opticalXC,-opticalYC,0])
    adns2610(
	pinDTh=pinDTh
	, pinDH=pinDH
	, opticalDD=opticalDD
	, opticalDZ=opticalDZ
	, pinH=pinH
	, pinTh=pinTh
	, pinWB=pinWB
	, pinWT=pinWT
	, pin2TH=pin2TH
	, pkgB2TH=pkgB2TH
	, pin2pin=pin2pin
	, pin2pkg=pin2pkg
	, row2row=row2row
	, pkgW=pkgW
	, pkgL=pkgL
	, opticalXC=opticalXC
	, opticalYC=opticalYC
	, opticalD=opticalD
	, opticalZ=opticalZ
    );
}

module adns2610_dev_circuit() {
  adns2610(opticalZ=10.0);
  adns2610_placeAtPinLocations() {
    color([0,0,1.0]) pin_socket(
        pinH=10.0
        , socketH=2.5
        , pinW=1.6
        , socketW=2.2
	);
  }
  // OSC_IN connects to pin 1
  adns2610_placeAtPin(pinNumber=1) {
    translate([1.2/2,0,0]) rotate([0,0,180])
      cube(size=[1.2,4.0+1.2/2,2.0],center=false);
    translate([-2.0,-4.0,0]) {
      color([0,1.0,0]) pin_socket(
        pinH=10.0
        , socketH=1.5
        , pinW=1.6
        , socketW=1.9
	);
      fcr_m6();
      rotate([0,0,-90]) translate([-1.2/2,0,0])
        cube(size=[1.2,2.0,2.0],center=false);
    }
  }
  // OSC_OUT connects to pin 2
  adns2610_placeAtPin(pinNumber=2) {
    translate([1.2/2,0,0]) rotate([0,0,180])
      cube(size=[1.2,4.0+1.2/2,2.0],center=false);
    translate([2.0,-4.0,0]) {
      color([0,1.0,0]) pin_socket(
        pinH=10.0
        , socketH=1.5
        , pinW=1.6
        , socketW=1.9
	);
      rotate([0,0,90]) translate([-1.2/2,0,0])
        cube(size=[1.2,2.0,2.0],center=false);
    }
  }
  // GND connects to pin 6
  adns2610_placeAtPin(pinNumber=6) {
    translate([1.2/2,0,0]) rotate([0,0,180])
      cube(size=[1.2,5.0+1.6/2,2.0],center=false);
    translate([0.0,-5.0,0]) 
      color([0,0.0,0]) pin_socket(
        pinH=10.0
        , socketH=1.5
        , pinW=1.6
        , socketW=2.0
	);
  }
  // VDD connects to pin 7
  adns2610_placeAtPin(pinNumber=7) {
    translate([1.2/2,0,0]) rotate([0,0,180])
      cube(size=[1.2,3.0+1.6/2,2.0],center=false);
    translate([0.0,-3.0,0]) 
      color([1.0,0.0,0]) pin_socket(
        pinH=10.0
        , socketH=1.5
        , pinW=1.6
        , socketW=2.0
	);
  }
  // REFA 2.2uF cap connects to pin 8 and GND
  adns2610_placeAtPin(pinNumber=8) {
    translate([1.2/2,0,0]) rotate([0,0,180])
      cube(size=[1.2,5.0+1.6/2,2.0],center=false);
    translate([0.0,-5.0,0]) 
      color([0,1.0,1.0]) pin_socket(
        pinH=10.0
        , socketH=1.5
        , pinW=1.6
        , socketW=2.0
	);
  }

}

if( adns2610_render_part==1 ) {
  echo("Rendering adns2610...");
  adns2610();
}

if( adns2610_render_part==2 ) {
  echo("Rendering adns2610_oc0...");
  adns2610_oc0();
}

if( adns2610_render_part==3 ) {
  echo("Rendering parametric adns2610_oc0 example...");
  adns2610_oc0(
	pinDTh=0.5
	, pinDH=5.0
	, opticalDD=0.2
	, opticalDZ=5.0
  );
}

if( adns2610_render_part==4 ) {
  echo("Rendering pin_sockets at adns2610_placeAtPinLocations...");
  adns2610_placeAtPinLocations() {
    color([0,0,1.0]) pin_socket(
        pinH=10.0
        , socketH=2.5
        , pinW=1.6
        , socketW=2.2
	);
  }
}

if( adns2610_render_part==5 ) {
  echo("Rendering adns2610_dev_circuit (sockets and ceramic resonator)...");
  adns2610_dev_circuit();
}

if( adns2610_render_part==6 ) {
  echo("Rendering inverse adns2610_dev_circuit...");
  difference () {
    translate([-5,-7,-2.0])
      cube([15,28,3.2],center=false);
    adns2610_dev_circuit();
  }
}

