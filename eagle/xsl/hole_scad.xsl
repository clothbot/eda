<?xml version="1.0"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="text"/>

<xsl:template name="hole-scad">
<xsl:text>module hole(x,y,drill,layer=0) {
  translate([x,y]) circle($fn=16,r=drill/2);
}
</xsl:text>
</xsl:template>

<xsl:template name="hole">
<xsl:text> if(layer==</xsl:text><xsl:value-of select="/eagle/drawing/layers/layer[@name='Holes']/@number"/><xsl:text>) hole(</xsl:text>
<xsl:for-each select="@*">
<xsl:if test="not(position()=1)"><xsl:text>,</xsl:text></xsl:if>
<xsl:value-of select="name()"/><xsl:text>=</xsl:text><xsl:value-of select="."/>
</xsl:for-each>
<xsl:text>);
</xsl:text>
</xsl:template>

</xsl:stylesheet>
