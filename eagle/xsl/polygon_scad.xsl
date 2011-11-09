<?xml version="1.0"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="text"/>

<xsl:template name="polygon-scad">
<xsl:text>module eagle_polygon(points,paths,layer=0,width=0,isolate=0,rot_res=8,fill=false) {
  if(width&lt;=0 || fill) {
    polygon(points=points,paths=paths);
  } else {
    union() {
      for(i=[0:rot_res-1]) assign(rotAngle=360*i/rot_res) {
        render() difference() {
          polygon(points=points,paths=paths);
          translate([-width*cos(rotAngle),-width*sin(rotAngle)])polygon(points=points,paths=paths);
        }
      }
    }
  }
}
</xsl:text>
</xsl:template>

<xsl:template name="polygon">
<xsl:text> if(layer==</xsl:text><xsl:value-of select="@layer"/><xsl:text>) eagle_polygon(</xsl:text>
<xsl:for-each select="@*">
<xsl:if test="not(position()=1)"><xsl:text>,</xsl:text></xsl:if>
<xsl:value-of select="name()"/><xsl:text>=</xsl:text><xsl:value-of select="."/>
</xsl:for-each>
<xsl:text>,points=[</xsl:text>
<xsl:for-each select="vertex">
<xsl:if test="not(position()=1)"><xsl:text>,</xsl:text></xsl:if>
<xsl:text>[</xsl:text><xsl:value-of select="@x"/><xsl:text>,</xsl:text><xsl:value-of select="@y"/><xsl:text>]</xsl:text>
</xsl:for-each>
<xsl:text>]</xsl:text>
<xsl:text>,paths=[[</xsl:text>
<xsl:for-each select="vertex">
<xsl:if test="not(position()=1)"><xsl:text>,</xsl:text></xsl:if>
<xsl:value-of select="position()-1"/>
</xsl:for-each>
<xsl:text>]]</xsl:text>
<xsl:text>,fill=fill);
</xsl:text>
</xsl:template>

</xsl:stylesheet>
