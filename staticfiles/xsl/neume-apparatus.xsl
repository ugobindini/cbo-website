<?xml version="1.0" encoding="UTF-8" ?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:template match="teiHeader"/>

  <xsl:template match="body">
    <xsl:if test=".//app[@type='neume']">
      <div class="text-font font-small">
        <p><b>Critical apparatus (neumes)</b></p>
        <div class="flex-wrapper">
          <xsl:apply-templates select=".//app[@type='neume']" />
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="app[@type='neume']">
    <b style="display: inline-flex; margin-right: 5px;"><xsl:value-of select="ancestor::lg/@n"/>.<xsl:value-of select="ancestor::l/@n"/></b>
    <!-- TODO: how to handle prose and plays -->
    <xsl:apply-templates select="./lem/*" />
    <i style="display: inline-flex;"><xsl:value-of select="./lem/@wit" /></i>
    <xsl:if test="./rdg">
      <xsl:choose>
        <xsl:when test="./lem/@wit">
          <span style="display: inline-flex; margin-left: 3px;">]</span>
        </xsl:when>
        <xsl:otherwise>
          <span style="display: inline-flex; margin-left: -5px;">]</span>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:if>
    <xsl:apply-templates select="./note" />
  </xsl:template>

  <xsl:template match="note">
    <span class="flex-wrapper app-note">
      <xsl:apply-templates />
    </span>
  </xsl:template>

  <xsl:template match="seg[@type='syll']">
    <xsl:variable name="text"><xsl:value-of select="./text()"/></xsl:variable>
    <span class="syl-dash text-font">
      <xsl:if test="@part='M' or  @part='F'"><xsl:text>-</xsl:text></xsl:if>
    </span>
    <span class="neumed-syll">
      <span class="syl-text text-font">
        <xsl:if test="@part='M' or  @part='F'"><xsl:text>-</xsl:text></xsl:if>
        <xsl:value-of select="normalize-space($text)"/>
        <xsl:if test="@part='I' or  @part='M'"><xsl:text>-</xsl:text></xsl:if>
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

  <xsl:template match="text()">
    <xsl:value-of select="." />
  </xsl:template>

</xsl:stylesheet>