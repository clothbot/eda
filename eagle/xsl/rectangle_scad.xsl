<?xml version="1.0"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="text"/>

<xsl:template name="rectangle-scad">
<xsl:text>module eagle_rectangle(x1,y1,x2,y2,layer=0,extend=0.0) {
  polygon(points=[[x1-extend,y1-extend],[x2+extend,y1-extend],[x2+extend,y2+extend],[x1-extend,y2+extend]],paths=[[0,1,2,3]]);
}
</xsl:text>
</xsl:template>

<xsl:template name="rectangle">
<xsl:text> if(layer==</xsl:text><xsl:value-of select="@layer"/><xsl:text>) eagle_rectangle(</xsl:text>
<xsl:for-each select="@*">
<xsl:if test="not(position()=1)"><xsl:text>,</xsl:text></xsl:if>
<xsl:value-of select="name()"/><xsl:text>=</xsl:text><xsl:value-of select="."/>
</xsl:for-each>
<xsl:text>,extend=extend);
</xsl:text>
</xsl:template>

</xsl:stylesheet>
