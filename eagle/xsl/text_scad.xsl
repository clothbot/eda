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

<xsl:template name="text">
<xsl:text> if(layer==</xsl:text><xsl:value-of select="@layer"/><xsl:text>) text(</xsl:text>
<xsl:for-each select="@*">
<xsl:if test="not(position()=1)"><xsl:text>,</xsl:text></xsl:if>
<xsl:value-of select="name()"/><xsl:text>=</xsl:text>
<xsl:choose>
<xsl:when test="name()='font'"><xsl:text>"</xsl:text><xsl:value-of select="."/><xsl:text>"</xsl:text></xsl:when>
<xsl:otherwise><xsl:value-of select="."/></xsl:otherwise>
</xsl:choose>
</xsl:for-each>
<xsl:text>,text_string="</xsl:text><xsl:value-of select="normalize-space()"/><xsl:text>");
</xsl:text>
</xsl:template>

</xsl:stylesheet>
