<?xml version="1.0"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="text"/>

<xsl:template name="text-scad">
<xsl:text>module text(x,y,size,layer=0,font="vector",ratio=15,text_string="") {
  echo(str(" Text @ [",x,",",y,"], size=",size,", font=\"",font,"\", ratio=",ratio,":  ",text_string));
  translate([x,y]) square(size=[size,size],center=true);
}
</xsl:text>
</xsl:template>
</xsl:stylesheet>
