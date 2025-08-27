<?xml version="1.0" encoding="UTF-8" ?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:template match="w">
    <span class="word text-font" style="vertical-align: bottom;">
      <xsl:if test="@rend='italic'">
          <xsl:attribute name="data-rend">italic</xsl:attribute>
      </xsl:if>
      <xsl:apply-templates/>
    </span>
  </xsl:template>

  <xsl:template match="seg[@type='syll']">
    <xsl:variable name="text"><xsl:value-of select="./text()"/></xsl:variable>
    <span class="neumed-syll">
      <span class="syl text-font">
        <xsl:choose>
          <xsl:when test="@met='+'">
            <span class="syl-text stressed-syl">
              <xsl:value-of select="normalize-space($text)"/>
            </span>
          </xsl:when>
          <xsl:otherwise>
            <span class="syl-text">
              <xsl:value-of select="normalize-space($text)"/>
            </span>
          </xsl:otherwise>
        </xsl:choose>
        <span class="syl-dash">
          <xsl:if test="@part='I' or  @part='M'"><xsl:text>-</xsl:text></xsl:if>
        </span>
      </span>
      <xsl:if test="./notatedMusic">
        <span class="neumes non-selectable">
          <span class="consonant-space"><xsl:value-of select="normalize-space($text)"/></span>
          <xsl:for-each select="notatedMusic/neume">
            <img class="neume">
              <xsl:attribute name="src">/staticfiles/img/glyphs/svg/<xsl:value-of select="@fontname"/><xsl:value-of select="@glyph.num"/>.svg</xsl:attribute>
            </img>
          </xsl:for-each>
        </span>
      </xsl:if>
    </span>
  </xsl:template>
</xsl:stylesheet>