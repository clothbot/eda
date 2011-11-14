<?xml version="1.0"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="text"/>

<xsl:template name="smd-scad">
<xsl:text>module smd(x,y,dx,dy,layer=0,name="",rot=0.0,extend=0.0) {
  translate([x,y]) rotate(rot) square(size=[dx+2*extend,dy+2*extend],center=true);
}
</xsl:text>
</xsl:template>

<xsl:template name="smd">
<xsl:text> if(layer==</xsl:text><xsl:value-of select="@layer"/><xsl:text>) smd(</xsl:text>
<xsl:for-each select="@*">
<xsl:if test="not(position()=1)"><xsl:text>,</xsl:text></xsl:if>
<xsl:value-of select="name()"/><xsl:text>=</xsl:text>
<xsl:choose>
<xsl:when test="name()='name'"><xsl:text>"</xsl:text><xsl:value-of select="."/><xsl:text>"</xsl:text></xsl:when>
<xsl:when test="name()='rot'">
  <xsl:choose>
    <xsl:when test="'R90'"><xsl:text>90</xsl:text></xsl:when>
    <xsl:when test="'R180'"><xsl:text>180</xsl:text></xsl:when>
    <xsl:when test="'R270'"><xsl:text>270</xsl:text></xsl:when>
    <xsl:otherwise><xsl:text>"</xsl:text><xsl:value-of select="."/><xsl:text>"</xsl:text></xsl:otherwise>
  </xsl:choose>
</xsl:when>
<xsl:otherwise><xsl:value-of select="."/></xsl:otherwise>
</xsl:choose>
</xsl:for-each>
<xsl:text>,extend=extend);
</xsl:text>
</xsl:template>

</xsl:stylesheet>
