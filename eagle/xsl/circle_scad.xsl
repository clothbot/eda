<?xml version="1.0"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="text"/>

<xsl:template name="circle-scad">
<xsl:text>module eagle_circle(x,y,radius,width,layer=0,fill=false,extend=0.0) {
  width=max(grid_distance/10,width+2*extend);
  if(fill) {
    translate([x,y]) circle($fn=16,r=radius);
  } else {
    translate([x,y]) difference() {
      circle($fn=16,r=radius+width/2);
      circle($fn=16,r=radius-width/2);
    }
  }
}
</xsl:text>
</xsl:template>

<xsl:template name="circle">
<xsl:text> eagle_circle(</xsl:text>
<xsl:for-each select="@*">
<xsl:if test="not(position()=1)"><xsl:text>,</xsl:text></xsl:if>
<xsl:value-of select="name()"/><xsl:text>=</xsl:text><xsl:value-of select="."/>
</xsl:for-each>
<xsl:text>,extend=extend);
</xsl:text>
</xsl:template>

</xsl:stylesheet>
