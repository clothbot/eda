<?xml version="1.0"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="text"/>

<xsl:template name="pad-scad">
<xsl:text>module pad(x,y,shape="",diameter,drill,layer=0) {
  translate([x,y]) difference() {
    if(shape=="octagon") {
      rotate(22.5) circle($fn=8,r=diameter/2);
    } else {
      circle($fn=16,r=diameter/2);
    }
    circle($fn=16,r=drill);
  }
}
</xsl:text>
</xsl:template>

<xsl:template name="pad">
<xsl:text> if(layer==</xsl:text><xsl:value-of select="/eagle/drawing/layers/layer[@name='Pads']/@number"/><xsl:text>) pad(</xsl:text>
<xsl:for-each select="@*">
<xsl:if test="not(position()=1)"><xsl:text>,</xsl:text></xsl:if>
<xsl:value-of select="name()"/><xsl:text>=</xsl:text>
<xsl:choose>
<xsl:when test="name()='shape'"><xsl:text>"</xsl:text><xsl:value-of select="."/><xsl:text>"</xsl:text></xsl:when>
<xsl:otherwise><xsl:value-of select="."/></xsl:otherwise>
</xsl:choose>
</xsl:for-each>
<xsl:text>);
</xsl:text>
</xsl:template>

</xsl:stylesheet>
