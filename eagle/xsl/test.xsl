<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html" encoding="utf-8"/>

<xsl:template match="/">
<html><head><title>testing eagle parsing</title></head>
<body>
<xsl:apply-templates select="eagle"/>
</body>
</html>
</xsl:template>

<xsl:template match="eagle">
Eagle<br/>
<xsl:apply-templates select="drawing"/>
</xsl:template>

<xsl:template match="drawing">
In Drawing.<br/>
<xsl:for-each select="layers">
<xsl:apply-templates/>
</xsl:for-each>
<xsl:for-each select="board">
<xsl:apply-templates/>
</xsl:for-each>
</xsl:template>

<xsl:template match="layers">
In Layers.<br/>
<xsl:for-each select="layer">
<xsl:apply-templates select="layer"/>
</xsl:for-each>
</xsl:template>

<xsl:template match="layer">
Layer: 
  number=<xsl:value-of select="@number"/> 
  name=<xsl:value-of select="@name"/>
  color=<xsl:value-of select="@color"/>
  fill=<xsl:value-of select="@fill"/>
  visible=<xsl:value-of select="@visible"/>
  active=<xsl:value-of select="@active"/> 
<br/>
</xsl:template>

<xsl:template match="board">
In Board<br/>
<xsl:apply-templates select="plain"/>
</xsl:template>

<xsl:template match="plain">
Board plain<br/>
<xsl:for-each select="wire">
  Wire: (x1,y1)=(<xsl:value-of select="@x1"/>,<xsl:value-of select="@y1"/>) (x2,y2)=(<xsl:value-of select="@x2"/>,<xsl:value-of select="@y2"/>)<br/>
</xsl:for-each>
</xsl:template>

</xsl:stylesheet>

