// Metal-Mite Aluminum Housed chassis-mount resistor
// 89 Series

render_model=0;

// 810F5R0
// 10W, 5.0 Ohms

module MetalMite_810F5R0(detail=0,tolScale=1.0) {
  dimA=34.93; dimA_tol=1.57;  // terminal tip to terminal tip length
  dimB=15.88; dimB_tol=0.25;  // mount hole to mount hole width
  dimC=2.39; dimC_tol=0.79;   // mount hole center to chassis outer radius
  dimD=14.28; dimD_tol=0.25;  // mount hole to mount hole length
  dimE=19.05; dimE_tol=1.57;  // chassis length
  dimF=7.93; dimF_tol=1.57;   // chassis to terminal tip length
  dimG=11.13; dimG_tol=1.57;  // chassis width
  dimH=7.93; dimH_tol=0.79;   // center line to mount hole center width
  dimJ=20.63; dimJ_tol=0.79;  // mount hole edge to mount hole edge outer width
  dimK=2.39; dimK_tol=0.13;   // mount hole diameter
  dimL=10.31; dimL_tol=0.79;  // chassis height
  dimM=5.16; dimM_tol=1.57;   // chassis flat to center line height
  dimN=2.39; dimN_tol=0.79;   // mount hole height
  dimP=2.16; dimP_tol=0.13;   // terminal hole diameter
  QminAWG=12;                 // terminal wire diameter
  dimR=3.56; dimR_tol=0.0;    // terminal wire clearance radius

  if(detail==0) union() {
    translate([-(dimE+tolScale*dimE_tol)/2,-(dimG+tolScale*dimG_tol)/2,0])
      cube(size=[dimE+tolScale*dimE_tol
        , dimG+tolScale*dimG_tol
        ,dimL+tolScale*dimL_tol],center=false);
    translate([dimD/2,0,0]) {
      translate([-(dimC+tolScale*dimC_tol),0,0])
        cube(size=[2*(dimC+tolScale*dimC_tol)
          ,(dimH)
          ,(dimN+tolScale*dimN_tol)],center=false);
      translate([0,dimH,0]) cylinder($fs=0.1, $fa=15.0
		, r=dimC+tolScale*dimC_tol
		, h=dimN+tolScale*dimN_tol
		, center=false);
    }
    translate([-dimD/2,0,0]) rotate([0,0,180]) {
      translate([-(dimC+tolScale*dimC_tol),0,0])
        cube(size=[2*(dimC+tolScale*dimC_tol)
          ,(dimH)
          ,(dimN+tolScale*dimN_tol)],center=false);
      translate([0,dimH,0]) cylinder($fs=0.1, $fa=15.0
		, r=dimC+tolScale*dimC_tol
		, h=dimN+tolScale*dimN_tol
		, center=false);
    }
    translate([0,0,dimM+tolScale*dimM_tol]) rotate([0,90,0])
      cylinder($fs=0.1, $fa=15.0, r=dimR+tolScale*dimR_tol
        ,h=dimA+tolScale*dimA_tol,center=true);
  }
}

if(render_model==0) {
  echo("Rendering simple MetalMite_810F5R0 model; detail=0...");
  MetalMite_810F5R0(detail=0,tolScale=0.5);
}

