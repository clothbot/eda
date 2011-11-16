<?xml version="1.0"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="text"/>

<xsl:template name="board-scad">
<xsl:text>module board(layer=0,holes=render_holes,fill=false,rank=0,extend=0.0) {
</xsl:text>
<xsl:apply-templates select="plain"/>
<xsl:apply-templates select="elements"/>
<xsl:apply-templates select="signals"/>
<xsl:text>}
</xsl:text>
</xsl:template>

<xsl:template match="board">
<xsl:text>// Entering board
</xsl:text>
<xsl:apply-templates select="libraries"/>
<xsl:call-template name="signals-scad"/>
<xsl:call-template name="board-scad"/>
<xsl:text>// Exiting board
</xsl:text>
</xsl:template>

<xsl:template match="plain">
<xsl:text>// board plain geometry
</xsl:text>
<xsl:for-each select="*">
<xsl:text>  if(layer==</xsl:text><xsl:value-of select="@layer"/><xsl:text>) </xsl:text>
<xsl:choose>
<xsl:when test="name()='circle'"><xsl:call-template name="circle"/></xsl:when>
<xsl:when test="name()='text'"><xsl:call-template name="text"/></xsl:when>
<xsl:when test="name()='wire'"><xsl:call-template name="wire"/></xsl:when>
<xsl:otherwise><xsl:text>// Ignoring </xsl:text><xsl:value-of select="name()"/><xsl:text> </xsl:text>
<xsl:for-each select="@*">
<xsl:text> </xsl:text><xsl:value-of select="name()"/><xsl:text>="</xsl:text><xsl:value-of select="."/><xsl:text>"</xsl:text>
</xsl:for-each>
<xsl:text>
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
 <xsl:text> package(library="</xsl:text><xsl:value-of select="@library"/><xsl:text>",package="</xsl:text>
 <xsl:value-of select="@package"/><xsl:text>",layer=layer</xsl:text>
 <xsl:if test="@name"><xsl:text>, name="</xsl:text><xsl:value-of select="@name"/><xsl:text>"</xsl:text></xsl:if>
 <xsl:if test="@value"><xsl:text>, value="</xsl:text><xsl:value-of select="@value"/><xsl:text>"</xsl:text></xsl:if>
 <xsl:if test="@smashed"><xsl:text>, smashed="</xsl:text><xsl:value-of select="@smashed"/><xsl:text>"</xsl:text></xsl:if>
 <xsl:text>,holes=holes,extend=extend)</xsl:text>
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
<xsl:text> signal(name="</xsl:text><xsl:value-of select="@name"/><xsl:text>",layer=layer,holes=holes,fill=fill,rank=rank,extend=extend);
</xsl:text>
</xsl:for-each>
</xsl:template>

</xsl:stylesheet>
