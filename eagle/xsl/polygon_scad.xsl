<?xml version="1.0"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="text"/>

<xsl:template name="polygon-scad">
<xsl:text>module polygon_outline(points,paths,inset,extend=0.0) {
  intersection() {
    polygon(points=points,paths=paths);
    union() for(i=[0:len(paths)-1]) {
      assign(thisPath=paths[i]) {
        for(j=[1:len(thisPath)-1]) assign(x1=points[thisPath[j-1]][0],y1=points[thisPath[j-1]][1],x2=points[thisPath[j]][0], y2=points[thisPath[j]][1])
            wire(x1=x1,y1=y1,x2=x2,y2=y2,width=2*inset);
        assign(x1=points[thisPath[len(thisPath)-1]][0],y1=points[thisPath[len(thisPath)-1]][1],x2=points[thisPath[0]][0], y2=points[thisPath[0]][1])
          wire(x1=x1,y1=y1,x2=x2,y2=y2,width=2*inset);
      }
    }
  }
  if(extend&gt;0.0) {
    difference() {
      union() for(i=[0:len(paths)-1]) assign(thisPath=paths[i]) {
        for(j=[1:len(thisPath)-1]) assign(x1=points[thisPath[j-1]][0],y1=points[thisPath[j-1]][1],x2=points[thisPath[j]][0], y2=points[thisPath[j]][1]) {
            wire(x1=x1,y1=y1,x2=x2,y2=y2,width=2*inset);
          }
        assign(x1=points[thisPath[len(thisPath)-1]][0],y1=points[thisPath[len(thisPath)-1]][1],x2=points[thisPath[0]][0], y2=points[thisPath[0]][1])
          wire(x1=x1,y1=y1,x2=x2,y2=y2,width=2*inset);
      }
      polygon(points=points,paths=paths);
    }
  }
}

module eagle_polygon(points,paths,layer=0,width=0,isolate=0,rot_res=8,fill=false,rank=0,extend=0.0) {
  if(width&lt;=0 || fill ) {
    polygon(points=points,paths=paths);
  } else {
    polygon_outline(points,paths,inset=width,extend=extend);
  }
}
</xsl:text>
</xsl:template>

<xsl:template name="polygon">
<xsl:choose>
<xsl:when test="@rank"><xsl:text> if(rank&gt;=</xsl:text><xsl:value-of select="@rank"/><xsl:text>) </xsl:text></xsl:when>
</xsl:choose>
<xsl:text> eagle_polygon(</xsl:text>
<xsl:for-each select="@*">
<xsl:if test="not(position()=1)"><xsl:text>,</xsl:text></xsl:if>
<xsl:value-of select="name()"/><xsl:text>=</xsl:text><xsl:value-of select="."/>
</xsl:for-each>
<xsl:text>,points=[</xsl:text>
<xsl:for-each select="vertex">
<xsl:if test="not(position()=1)"><xsl:text>,</xsl:text></xsl:if>
<xsl:text>[</xsl:text><xsl:value-of select="@x"/><xsl:text>,</xsl:text><xsl:value-of select="@y"/><xsl:text>]</xsl:text>
</xsl:for-each>
<xsl:text>]</xsl:text>
<xsl:text>,paths=[[</xsl:text>
<xsl:for-each select="vertex">
<xsl:if test="not(position()=1)"><xsl:text>,</xsl:text></xsl:if>
<xsl:value-of select="position()-1"/>
</xsl:for-each>
<xsl:text>]]</xsl:text>
<xsl:text>,fill=fill,extend=extend);
</xsl:text>
</xsl:template>

</xsl:stylesheet>
