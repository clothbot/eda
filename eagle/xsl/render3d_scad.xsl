<?xml version="1.0"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="text"/>

<xsl:template name="render3d-scad">
<xsl:text>
render3d_top_th=0.5;
render3d_bottom_th=0.5;
render3d_board_th=4.0;
</xsl:text>
</xsl:template>

<xsl:template name="render3d">
<xsl:text>if(render_layer==0) {
  for(i=[0:</xsl:text><xsl:value-of select="count(/eagle/drawing/layers/layer)"/><xsl:text>]) assign(layer_number=layers[i][0]) { 
    // Testing layer_lookup
    if(layers[layer_lookup(layer_number)][4]=="yes") {
      echo(str("Visible layer ",layer_number,"(",layers[layer_lookup(layer_number)][1],")"));
    } else {
      echo(str("Not visible layer ",layer_number,"(",layers[layer_lookup(layer_number)][1],")"));
    }
  }
</xsl:text>
<xsl:text>  union() {
    // Rendering Top
    translate([0,0,render3d_board_th/2]) {
      linear_extrude(height=render3d_top_th,center=true) board(layer=1,holes="no",fill=false);
      linear_extrude(height=render3d_top_th,center=true) board(layer=17,holes="no",fill=false);
    }
    // Rendering Pads
    linear_extrude(height=render3d_top_th+render3d_board_th+render3d_bottom_th,center=true) board(layer=17,holes="only",fill=true);
    // Rendering Vias
    linear_extrude(height=render3d_top_th+render3d_board_th+render3d_bottom_th,center=true) board(layer=18,holes="only",fill=true);
    // Rendering Holes
    linear_extrude(height=render3d_top_th+render3d_board_th+render3d_bottom_th,center=true) board(layer=45,holes="only",fill=true);
    // Rendering Bottom
    translate([0,0,-render3d_board_th/2]) {
      linear_extrude(height=render3d_bottom_th,center=true) board(layer=16,holes="no",fill=false);
      linear_extrude(height=render3d_bottom_th,center=true) board(layer=17,holes="no",fill=false);
    }
  }
</xsl:text>
<xsl:text>}
</xsl:text>
</xsl:template>

</xsl:stylesheet>
