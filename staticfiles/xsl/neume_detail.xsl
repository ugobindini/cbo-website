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

  <xsl:template match="w">
    <span class="word text-font">
      <xsl:apply-templates/>
    </span>
  </xsl:template>

  <xsl:template match="seg[@type='syll']">
    <xsl:variable name="text"><xsl:value-of select="./text()"/></xsl:variable>
    <span class="neumed-syll">
      <span class="syl text-font">
        <span class="syl-text">
          <xsl:value-of select="normalize-space($text)"/>
          <xsl:if test="@part='I' or  @part='M'"><xsl:text>-</xsl:text></xsl:if>
        </span>
      </span>
      <span class="neumes non-selectable">
        <span class="consonant-space"><xsl:value-of select="normalize-space($text)"/></span>
        <xsl:for-each select="notatedMusic/neume">
          <img class="neume">
            <xsl:attribute name="src">/staticfiles/img/svg/<xsl:value-of select="@fontname"/><xsl:value-of select="@glyph.num"/>.svg</xsl:attribute>
          </img>
        </xsl:for-each>
      </span>
    </span>
  </xsl:template>

  <xsl:template match="app">
    <xsl:apply-templates select="./lem/*" />
  </xsl:template>

</xsl:stylesheet>