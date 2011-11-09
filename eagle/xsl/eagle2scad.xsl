<?xml version="1.0"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="text"/>

<xsl:param name="name_badchars"><xsl:text>',./-$+'</xsl:text></xsl:param>
<xsl:param name="name_goodchars"><xsl:text>'ppm__p'</xsl:text></xsl:param>

<xsl:include href="wire_scad.xsl"/>
<xsl:include href="text_scad.xsl"/>
<xsl:include href="pad_scad.xsl"/>
<xsl:include href="circle_scad.xsl"/>
<xsl:include href="rectangle_scad.xsl"/>
<xsl:include href="smd_scad.xsl"/>
<xsl:include href="via_scad.xsl"/>
<xsl:include href="polygon_scad.xsl"/>

<xsl:include href="package_scad.xsl"/>
<xsl:include href="signal_scad.xsl"/>

<xsl:template match="/">
<xsl:text>// Render layer variable
render_layer=0;
render_holes="yes"; // render_holes={"yes"|"no"|"only"};
if(render_layer!=0) {
  echo("Rendering layer: ",render_layer);
  board(layer=render_layer);
}
</xsl:text>
<xsl:text>// OpenSCAD Definitions
</xsl:text>
<xsl:call-template name="wire-scad"/>
<xsl:call-template name="text-scad"/>
<xsl:call-template name="pad-scad"/>
<xsl:call-template name="circle-scad"/>
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
<xsl:text>  if(render_layer==0) echo("Rendering layer </xsl:text><xsl:value-of select="@number"/><xsl:text> (</xsl:text><xsl:value-of select="@name"/><xsl:text>)");
</xsl:text>
<xsl:text>  if(render_layer==0) board(layer=</xsl:text><xsl:value-of select="@number"/><xsl:text>);
</xsl:text>
</xsl:when>
<xsl:otherwise>
<xsl:text>  if(render_layer==0) echo("Not rendering layer </xsl:text><xsl:value-of select="@number"/><xsl:text> (</xsl:text><xsl:value-of select="@name"/><xsl:text>)");
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
<xsl:for-each select="signals/signal">
<xsl:call-template name="signal-scad">
<xsl:with-param name="name">
<xsl:value-of select="translate(./@name,$name_badchars,$name_goodchars)"/>
</xsl:with-param>
</xsl:call-template>
</xsl:for-each>
<xsl:text>module board(layer=0) {
</xsl:text>
<xsl:apply-templates select="plain"/>
<xsl:apply-templates select="elements"/>
<xsl:apply-templates select="signals"/>
<xsl:text>}
</xsl:text>
<xsl:text>// Exiting board
</xsl:text>
</xsl:template>

<xsl:template match="libraries">
<xsl:text>// Entering libraries
</xsl:text>
<xsl:apply-templates select="library"/>
<xsl:text>// Exiting libraries
</xsl:text>
</xsl:template>

<xsl:template match="library">
<xsl:text>//Entering library
</xsl:text>
<xsl:for-each select="packages/package">
<xsl:call-template name="package-scad">
<xsl:with-param name="library">
<xsl:value-of select="translate(../../@name,$name_badchars,$name_goodchars)"/>
</xsl:with-param>
<xsl:with-param name="package" select="translate(@name,$name_badchars,$name_goodchars)"/>
</xsl:call-template>
</xsl:for-each>
<xsl:text>// Exiting library
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

<xsl:template match="elements">
<xsl:for-each select="element">
 <xsl:text>  translate([</xsl:text><xsl:value-of select="@x"/><xsl:text>,</xsl:text><xsl:value-of select="@y"/><xsl:text>])</xsl:text>
 <xsl:choose>
  <xsl:when test="@rot='R90'"><xsl:text> rotate(90)</xsl:text></xsl:when>
  <xsl:when test="@rot='R180'"><xsl:text> rotate(180)</xsl:text></xsl:when>
  <xsl:when test="@rot='R270'"><xsl:text> rotate(270)</xsl:text></xsl:when>
 </xsl:choose>
 <xsl:text> </xsl:text>package_<xsl:value-of select="translate(@library,$name_badchars,$name_goodchars)"/><xsl:text>_</xsl:text>
 <xsl:value-of select="translate(@package,$name_badchars,$name_goodchars)"/><xsl:text>(layer=layer</xsl:text>
 <xsl:if test="@name"><xsl:text>, name="</xsl:text><xsl:value-of select="@name"/><xsl:text>"</xsl:text></xsl:if>
 <xsl:if test="@value"><xsl:text>, value="</xsl:text><xsl:value-of select="@value"/><xsl:text>"</xsl:text></xsl:if>
 <xsl:if test="@smashed"><xsl:text>, smashed="</xsl:text><xsl:value-of select="@smashed"/><xsl:text>"</xsl:text></xsl:if>
 <xsl:text>)</xsl:text>
 <xsl:if test="count(attribute) &gt; 0">
  <xsl:text> {
</xsl:text>
  <xsl:for-each select="attribute">
    <xsl:call-template name="element-attribute"/>
  </xsl:for-each>
  <xsl:text> }
</xsl:text>
 </xsl:if>
 <xsl:text>;
 </xsl:text>
</xsl:for-each>
</xsl:template>

<xsl:template name="element-attribute">
<xsl:text>  // Attribute </xsl:text>
<xsl:for-each select="@*">
<xsl:text> </xsl:text><xsl:value-of select="name()"/><xsl:text>="</xsl:text><xsl:value-of select="."/><xsl:text>"</xsl:text>
</xsl:for-each>
<xsl:text>
</xsl:text>
</xsl:template>

<xsl:template match="signals">
<xsl:for-each select="signal">
  <xsl:text>// Signal "</xsl:text><xsl:value-of select="@name"/><xsl:text>
  signal_</xsl:text><xsl:value-of select="translate(./@name,$name_badchars,$name_goodchars)"/><xsl:text>(layer=layer);
</xsl:text>
</xsl:for-each>
</xsl:template>

</xsl:stylesheet>
