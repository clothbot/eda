<?xml version="1.0"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="text"/>

<xsl:template match="/">
<xsl:text>// eagle2scad: begin
</xsl:text>
<xsl:apply-templates select="eagle"/>
<xsl:text>// eagle2scad: end
</xsl:text>
</xsl:template>

<xsl:template match="eagle">
<xsl:text>// Entering eagle
</xsl:text>
<xsl:apply-templates select="drawing"/>
<xsl:text>// Exiting eagle
</xsl:text>
</xsl:template>

<xsl:template match="drawing">
<xsl:text>// Entering drawing element
</xsl:text>
<xsl:apply-templates select="settings"/>
<xsl:apply-templates select="grid"/>
<xsl:apply-templates select="layers"/>
<xsl:apply-templates select="board"/>
<xsl:for-each select="layers/layer">
<xsl:choose>
<xsl:when test="@visible='yes'">
<xsl:text>  echo("Rendering layer </xsl:text><xsl:value-of select="@number"/><xsl:text> (</xsl:text><xsl:value-of select="@name"/><xsl:text>)");
</xsl:text>
<xsl:text>  board(layer=</xsl:text><xsl:value-of select="@number"/><xsl:text>);
</xsl:text>
</xsl:when>
<xsl:otherwise>
<xsl:text>  echo("Not rendering layer </xsl:text><xsl:value-of select="@number"/><xsl:text> (</xsl:text><xsl:value-of select="@name"/><xsl:text>)");
</xsl:text>
<xsl:text>  // board(layer=</xsl:text><xsl:value-of select="@number"/><xsl:text>);
</xsl:text>
</xsl:otherwise>
</xsl:choose>
</xsl:for-each>
</xsl:template>

<xsl:template match="settings">
<xsl:text>// Entering settings
</xsl:text>
<xsl:apply-templates select="setting"/>
<xsl:text>// Exiting settings
</xsl:text>
</xsl:template>

<xsl:template match="setting">
<xsl:for-each select="@*">
<xsl:text>  setting_</xsl:text><xsl:value-of select="name()"/><xsl:text>="</xsl:text><xsl:value-of select="."/><xsl:text>";
</xsl:text>
</xsl:for-each>
</xsl:template>

<xsl:template match="grid">
<xsl:text>// Grid:
</xsl:text>
<xsl:for-each select="@*">
<xsl:choose>
<xsl:when test="name()='distance'">
  <xsl:text>  grid_</xsl:text><xsl:value-of select="name()"/><xsl:text>=</xsl:text><xsl:value-of select="."/><xsl:text>;
</xsl:text></xsl:when>
<xsl:when test="name()='multiple'">
  <xsl:text>  grid_</xsl:text><xsl:value-of select="name()"/><xsl:text>=</xsl:text><xsl:value-of select="."/><xsl:text>;
</xsl:text></xsl:when>
<xsl:when test="name()='altdistance'">
  <xsl:text>  grid_</xsl:text><xsl:value-of select="name()"/><xsl:text>=</xsl:text><xsl:value-of select="."/><xsl:text>;
</xsl:text></xsl:when>
<xsl:otherwise>
<xsl:text>  grid_</xsl:text><xsl:value-of select="name()"/><xsl:text>="</xsl:text><xsl:value-of select="."/><xsl:text>";
</xsl:text>
</xsl:otherwise>
</xsl:choose>
</xsl:for-each>
</xsl:template>

<xsl:template match="layers">
<xsl:text>// Entering layers
</xsl:text>
<xsl:apply-templates select="layer"/>
<xsl:text>// Exiting layers
</xsl:text>
</xsl:template>

<xsl:template match="layer">
<xsl:text>// Layer </xsl:text><xsl:value-of select="@number"/><xsl:text>
</xsl:text>
<xsl:text>  layer_</xsl:text><xsl:value-of select="@number"/><xsl:text>_name="</xsl:text><xsl:value-of select="@name"/><xsl:text>";
</xsl:text>
<xsl:text>  layer_</xsl:text><xsl:value-of select="@number"/><xsl:text>_color=</xsl:text><xsl:value-of select="@color"/><xsl:text>;
</xsl:text>
<xsl:text>  layer_</xsl:text><xsl:value-of select="@number"/><xsl:text>_fill=</xsl:text><xsl:value-of select="@fill"/><xsl:text>;
</xsl:text>
<xsl:text>  layer_</xsl:text><xsl:value-of select="@number"/><xsl:text>_visible="</xsl:text><xsl:value-of select="@visible"/><xsl:text>";
</xsl:text>
<xsl:text>  layer_</xsl:text><xsl:value-of select="@number"/><xsl:text>_active="</xsl:text><xsl:value-of select="@active"/><xsl:text>";
</xsl:text>
</xsl:template>

<xsl:template match="board">
<xsl:text>// Entering board
</xsl:text>
<xsl:apply-templates select="libraries"/>
<xsl:text>module board() {
</xsl:text>
<xsl:apply-templates select="plain"/>
<xsl:text>}
</xsl:text>
<xsl:text>// Exiting board
</xsl:text>
</xsl:template>

<xsl:template match="libraries">
<xsl:text>// Entering libraries
</xsl:text>
<xsl:text>// Exiting libraries
</xsl:text>
</xsl:template>

<xsl:template match="plain">
<xsl:text>// board plain geometry
</xsl:text>
<xsl:for-each select="*">
<xsl:choose>
<xsl:when test="name()='wire'"><xsl:call-template name="wire"/></xsl:when>
<xsl:when test="name()='circle'"><xsl:call-template name="circle"/></xsl:when>
<xsl:when test="name()='text'"><xsl:call-template name="text"/></xsl:when>
<xsl:otherwise><xsl:text>// Ignoring </xsl:text><xsl:value-of select="name()"/><xsl:text>
</xsl:text></xsl:otherwise>
</xsl:choose>
</xsl:for-each>
</xsl:template>

<xsl:template name="wire">
<xsl:variable name="xd"><xsl:text>(</xsl:text><xsl:value-of select="@x2"/><xsl:text>-</xsl:text><xsl:value-of select="@x1"/><xsl:text>)</xsl:text></xsl:variable>
<xsl:variable name="yd"><xsl:text>(</xsl:text><xsl:value-of select="@y2"/><xsl:text>-</xsl:text><xsl:value-of select="@y1"/><xsl:text>)</xsl:text></xsl:variable>
<xsl:text> if(layer==</xsl:text><xsl:value-of select="@layer"/><xsl:text>) assign(yd=</xsl:text><xsl:value-of select="$yd"/><xsl:text>, xd=</xsl:text>
<xsl:value-of select="$xd"/><xsl:text>, angle=atan2(</xsl:text><xsl:value-of select="$yd"/><xsl:text>,</xsl:text><xsl:value-of select="$xd"/><xsl:text>), length=sqrt(pow(</xsl:text><xsl:value-of select="$xd"/><xsl:text>,2)+pow(</xsl:text><xsl:value-of select="$yd"/><xsl:text>,2)), width=max(grid_distance/10,</xsl:text>
<xsl:value-of select="@width"/><xsl:text>) ) {
</xsl:text>
<xsl:text> translate([</xsl:text><xsl:value-of select="@x1"/><xsl:text>+xd/2,</xsl:text><xsl:value-of select="@y1"/><xsl:text>+yd/2])</xsl:text>
<xsl:text> rotate(angle)</xsl:text>
<xsl:text> square(size=[length,width],center=true);
}
</xsl:text>
</xsl:template>

<xsl:template name="circle">
<xsl:text> if(layer==</xsl:text><xsl:value-of select="@layer"/><xsl:text>) translate([</xsl:text><xsl:value-of select="@x"/><xsl:text>,</xsl:text><xsl:value-of select="@y"/><xsl:text>]) difference() {
  circle(r=</xsl:text><xsl:value-of select="@radius"/><xsl:text>+</xsl:text><xsl:value-of select="@width"/><xsl:text>/2);
  circle(r=</xsl:text><xsl:value-of select="@radius"/><xsl:text>-</xsl:text><xsl:value-of select="@width"/><xsl:text>/2);
 }
</xsl:text>
</xsl:template>

<xsl:template name="text">
<xsl:text> if(layer==</xsl:text><xsl:value-of select="@layer"/><xsl:text>) {
  echo(" Text @ [</xsl:text><xsl:value-of select="@x"/><xsl:text>,</xsl:text><xsl:value-of select="@y"/><xsl:text>], size=</xsl:text><xsl:value-of select="@size"/><xsl:text>, font=\"</xsl:text><xsl:value-of select="@font"/><xsl:text>\", ratio=</xsl:text><xsl:value-of select="@ratio"/><xsl:text>:  </xsl:text><xsl:value-of select="normalize-space()"/><xsl:text>");
  translate([</xsl:text><xsl:value-of select="@x"/><xsl:text>,</xsl:text><xsl:value-of select="@y"/><xsl:text>]) square(size=[</xsl:text><xsl:value-of select="@size"/><xsl:text>,</xsl:text><xsl:value-of select="@size"/><xsl:text>],center=true);
 }
</xsl:text>
</xsl:template>

</xsl:stylesheet>
