<?xml version="1.0" encoding="UTF-8" ?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  
  <xsl:param name="n" select="null" />

  <xsl:template match="body">
    <div>
      <xsl:for-each select=".//l | .//p">
        <xsl:if test=".//neume[@glyph.num=$n]">
          <div class="flex-wrapper text-font" style="margin-left: 15px;">
            <xsl:apply-templates />
          </div>
        </xsl:if>
      </xsl:for-each>
    </div>
  </xsl:template>

  <xsl:template match="seg[@type='hemistich']">
    <div class="hemistich">
      <xsl:apply-templates/>
    </div>
  </xsl:template>

  <xsl:include href="word-and-syll.xsl"/>

  <xsl:include href="pc.xsl"/>

  <xsl:template match="app">
    <xsl:apply-templates select="./lem/*" />
  </xsl:template>

</xsl:stylesheet>