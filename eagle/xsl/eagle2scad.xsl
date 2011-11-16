<?xml version="1.0"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="text"/>

<xsl:param name="name_badchars"><xsl:text>',./-$+'</xsl:text></xsl:param>
<xsl:param name="name_goodchars"><xsl:text>'ppm__p'</xsl:text></xsl:param>

<xsl:include href="circle_scad.xsl"/>
<xsl:include href="hole_scad.xsl"/>
<xsl:include href="pad_scad.xsl"/>
<xsl:include href="polygon_scad.xsl"/>
<xsl:include href="rectangle_scad.xsl"/>
<xsl:include href="smd_scad.xsl"/>
<xsl:include href="text_scad.xsl"/>
<xsl:include href="via_scad.xsl"/>
<xsl:include href="wire_scad.xsl"/>

<xsl:include href="board_scad.xsl"/>
<xsl:include href="signals_scad.xsl"/>
<xsl:include href="packages_scad.xsl"/>

<xsl:include href="render3d_scad.xsl"/>

<xsl:template match="/">
<xsl:text>// Render layer variable
render_layer=0;
render_holes="yes"; // render_holes={"yes"|"no"|"only"};
render_fill=false; // render_fill={true|false};
if(render_layer!=0) {
  echo("Rendering layer: ",render_layer);
  board(layer=render_layer,fill=render_fill,extend=0.0);
}
</xsl:text>
<xsl:text>// OpenSCAD Definitions
</xsl:text>
<xsl:call-template name="render3d-scad"/>
<xsl:call-template name="wire-scad"/>
<xsl:call-template name="text-scad"/>
<xsl:call-template name="pad-scad"/>
<xsl:call-template name="circle-scad"/>
<xsl:call-template name="hole-scad"/>
<xsl:call-template name="rectangle-scad"/>
<xsl:call-template name="smd-scad"/>
<xsl:call-template name="via-scad"/>
<xsl:call-template name="polygon-scad"/>
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
<xsl:call-template name="render3d"/>
</xsl:template>

<xsl:template match="drawing">
<xsl:text>// Entering drawing element
</xsl:text>
<xsl:apply-templates select="settings"/>
<xsl:apply-templates select="grid"/>
<xsl:apply-templates select="layers"/>
<xsl:apply-templates select="board"/>
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
//  [number,name,color,fill.visible,active]
layers=[
</xsl:text>
<xsl:for-each select="layer">
<xsl:if test="position()=1"><xsl:text>   </xsl:text></xsl:if>
<xsl:if test="not(position()=1)"><xsl:text>  ,</xsl:text></xsl:if>
<xsl:text>[</xsl:text><xsl:value-of select="@number"/>
<xsl:text>,"</xsl:text><xsl:value-of select="@name"/><xsl:text>"</xsl:text>
<xsl:text>,</xsl:text><xsl:value-of select="@color"/>
<xsl:text>,</xsl:text><xsl:value-of select="@fill"/>
<xsl:text>,"</xsl:text><xsl:value-of select="@visible"/><xsl:text>"</xsl:text>
<xsl:text>,"</xsl:text><xsl:value-of select="@active"/><xsl:text>"]
</xsl:text>
</xsl:for-each>
<xsl:text>];
</xsl:text>
<xsl:text>function layer_lookup(number) = lookup(number,[</xsl:text>
<xsl:for-each select="layer">
<xsl:if test="not(position()=1)"><xsl:text>,</xsl:text></xsl:if>
<xsl:text>[</xsl:text><xsl:value-of select="@number"/><xsl:text>,</xsl:text><xsl:value-of select="position()-1"/><xsl:text>]</xsl:text>
</xsl:for-each>
<xsl:text>]);
</xsl:text>
<xsl:text>
// Exiting layers
</xsl:text>
</xsl:template>


<xsl:template match="libraries">
<xsl:text>// Entering libraries
</xsl:text>
<xsl:call-template name="library"/>
<xsl:text>// Exiting libraries
</xsl:text>
</xsl:template>

<xsl:template name="library">
<xsl:text>//Entering library
</xsl:text>
<xsl:call-template name="packages-scad"/>
<xsl:text>// Exiting library
</xsl:text>
</xsl:template>

</xsl:stylesheet>
