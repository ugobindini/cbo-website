<?xml version="1.0" encoding="UTF-8" ?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:template match="div[@type='poem']">
    <div class="poem">
      <xsl:apply-templates select="./lg[@type='strophe']"/>
    </div>
  </xsl:template>

  <xsl:template match="lg[@type='strophe']">
    <div class="strophe">
      <div class="text-font strophe-heading"><xsl:value-of select="@n"/></div>
      <xsl:apply-templates>
        <xsl:with-param name="strophepos" select="position()"/>
      </xsl:apply-templates>
    </div>
  </xsl:template>

  <xsl:template match="l">
    <xsl:param name = "strophepos"/>
    <div class="verse">
      <div class="verse-text">
        <xsl:apply-templates/>
      </div>
      <div class="verse-met">
        <xsl:if test="$strophepos = 1">
          <xsl:value-of select="@met"/>
        </xsl:if>
      </div>
      <div class="verse-rhyme">
        <xsl:value-of select="@rhyme"/>
      </div>
      <div class="verse-real">
        <xsl:value-of select="@real"/>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="seg[@type='hemistich']">
  <div class="hemistich">
    <xsl:apply-templates/>
  </div>
  </xsl:template>

  <xsl:template match="seg[@type='word']">
  <div class="word text-font">
    <xsl:apply-templates/>
  </div>
  </xsl:template>

  <xsl:template match="seg[@type='syll']">
    <xsl:variable name="text"><xsl:value-of select="./text()"/></xsl:variable>
    <div class="neumed-syll">
      <div class="neumes non-selectable">
        <div class="neume consonant-space"><xsl:value-of select="normalize-space($text)"/></div>
        <xsl:for-each select="notatedMusic/neume">
          <img class="neume">
            <xsl:attribute name="src">img/glyphs/<xsl:value-of select="@fontname"/><xsl:value-of select="@glyph.num"/>.svg</xsl:attribute>
          </img>
        </xsl:for-each>
      </div>
      <div class="syl">
        <xsl:choose>
          <xsl:when test="@met='+'">
            <div class="syl-text stressed-syl">
              <xsl:value-of select="normalize-space($text)"/>
            </div>
          </xsl:when>
          <xsl:otherwise>
            <div class="syl-text">
              <xsl:value-of select="normalize-space($text)"/>
            </div>
          </xsl:otherwise>
        </xsl:choose>
        <div class="syl-dash">
          <xsl:if test="@part='I' or  @part='M'"><xsl:text>-</xsl:text></xsl:if>
        </div>
      </div>
    </div>
  </xsl:template>

</xsl:stylesheet>

