<?xml version="1.0" encoding="UTF-8" ?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:template match="teiHeader"/>

  <xsl:template match="body">
    <xsl:if test=".//app[@type='neume']">
      <p class="text-font font-bold">Critical apparatus (neumes)</p>
    </xsl:if>
    <xsl:apply-templates select=".//app[@type='neume']"/>
  </xsl:template>

  <xsl:template match="app[@type='neume']">
    <b style="margin-right: 5px;"><xsl:value-of select="ancestor::lg/@n"/>.<xsl:value-of select="ancestor::l/@n"/></b>
    <xsl:apply-templates select="./lem/*" />
    <i><xsl:value-of select="./lem/@wit" /></i>
    <xsl:if test="./rdg">
      <xsl:choose>
        <xsl:when test="./lem/@wit">
          <span style="margin-left: 3px;">]</span>
        </xsl:when>
        <xsl:otherwise>
          <span style="margin-left: -5px;">]</span>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:if>
    <xsl:apply-templates select="./rdg" />
    <xsl:apply-templates select="./note" />
  </xsl:template>

  <xsl:template match="rdg">
    <span class="rdg font-it">
      <xsl:apply-templates />
    </span>
    <i style="margin-right: 10px;"><xsl:value-of select="@wit" /></i>
  </xsl:template>

  <xsl:template match="note">
    <span class="font-it" style="margin-right: 10px; margin-left: 5px;">
      <xsl:apply-templates />
    </span>
  </xsl:template>

  <xsl:template match="w">
  <span class="word">
    <xsl:apply-templates/>
  </span>
  </xsl:template>

  <xsl:template match="seg[@type='syll']">
    <xsl:variable name="text"><xsl:value-of select="./text()"/></xsl:variable>
    <span class="neumed-syll">
      <span class="syl">
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
        <span class="syl-dash">
          <xsl:if test="@part='I' or  @part='M'"><xsl:text>-</xsl:text></xsl:if>
        </span>
      </span>
      <span class="neumes non-selectable">
        <span class="consonant-space"><xsl:value-of select="normalize-space($text)"/></span>
        <xsl:for-each select="notatedMusic/neume">
          <img class="neume-small">
            <xsl:attribute name="src">/staticfiles/img/svg/<xsl:value-of select="@fontname"/><xsl:value-of select="@glyph.num"/>.svg</xsl:attribute>
          </img>
        </xsl:for-each>
      </span>
    </span>
  </xsl:template>

</xsl:stylesheet>