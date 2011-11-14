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

</xsl:stylesheet>
