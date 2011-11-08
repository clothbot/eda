<?xml version="1.0"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="text"/>

<xsl:template name="wire-scad">
<xsl:text>module wire(x1,y1,x2,y2,width,layer=0,extent="") {
  xd=x2-x1;
  yd=y2-y1;
  angle=atan2(yd,xd);
  length=sqrt(pow(xd,2)+pow(yd,2));
  width=max(grid_distance/10,width);
  translate([x1+xd/2,y1+yd/2]) rotate(angle) square(size=[length,width],center=true);
}
</xsl:text>
</xsl:template>

<xsl:template name="wire">
<xsl:text> if(layer==</xsl:text><xsl:value-of select="@layer"/><xsl:text>) wire(</xsl:text>
<xsl:for-each select="@*">
<xsl:if test="not(position()=1)"><xsl:text>,</xsl:text></xsl:if>
<xsl:value-of select="name()"/><xsl:text>=</xsl:text>
<xsl:choose>
<xsl:when test="name()='extent'"><xsl:text>"</xsl:text><xsl:value-of select="."/><xsl:text>"</xsl:text></xsl:when>
<xsl:when test="name()='cap'"><xsl:text>"</xsl:text><xsl:value-of select="."/><xsl:text>"</xsl:text></xsl:when>
<xsl:otherwise><xsl:value-of select="."/></xsl:otherwise>
</xsl:choose>
</xsl:for-each>
<xsl:text>);
</xsl:text>
</xsl:template>

</xsl:stylesheet>
