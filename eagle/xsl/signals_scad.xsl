<?xml version="1.0"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="text"/>

<xsl:template name="signals-scad">
<xsl:text>module signal(name="GND",layer=0,holes="yes",fill=false,rank=0) {
</xsl:text>
<xsl:for-each select="/eagle/drawing/board/signals/signal">
<xsl:text>  if(name=="</xsl:text><xsl:value-of select="@name"/><xsl:text>") {
</xsl:text>
<xsl:for-each select="*">
<xsl:choose>
<xsl:when test="name()='circle'"><xsl:call-template name="circle"/></xsl:when>
<xsl:when test="name()='hole'"><xsl:call-template name="hole"/></xsl:when>
<xsl:when test="name()='pad'"><xsl:call-template name="pad"/></xsl:when>
<xsl:when test="name()='polygon'"><xsl:call-template name="polygon"/></xsl:when>
<xsl:when test="name()='rectangle'"><xsl:call-template name="rectangle"/></xsl:when>
<xsl:when test="name()='smd'"><xsl:call-template name="smd"/></xsl:when>
<xsl:when test="name()='text'"><xsl:call-template name="text"/></xsl:when>
<xsl:when test="name()='via'"><xsl:call-template name="via"/></xsl:when>
<xsl:when test="name()='wire'"><xsl:call-template name="wire"/></xsl:when>
<xsl:otherwise><xsl:text>// Ignoring </xsl:text><xsl:value-of select="name()"/><xsl:text> </xsl:text>
<xsl:for-each select="@*">
<xsl:text> </xsl:text><xsl:value-of select="name()"/><xsl:text>="</xsl:text><xsl:value-of select="."/><xsl:text>"</xsl:text>
</xsl:for-each>
<xsl:text>
</xsl:text></xsl:otherwise>
</xsl:choose>
</xsl:for-each>
<xsl:text> }
</xsl:text>
</xsl:for-each>
<xsl:text>}
</xsl:text>
</xsl:template>

</xsl:stylesheet>
