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
    <!-- Numbering -->
    <b style="margin-right: 6px;">
      <xsl:if test="ancestor::sp"><xsl:value-of select="ancestor::sp/@n" />.</xsl:if>
      <xsl:choose>
        <xsl:when test="ancestor::lg[@type='refrain']">Refl.<xsl:value-of select="ancestor::l/@n"/></xsl:when>
        <xsl:when test="ancestor::lg">
          <xsl:if test="ancestor::lg/@n"><xsl:value-of select="ancestor::lg/@n" />.</xsl:if>
          <xsl:value-of select="ancestor::l/@n"/>
        </xsl:when>
      </xsl:choose>
    </b>

    <!-- lem, rdg and note -->
    <xsl:apply-templates select="./lem" />
    <xsl:apply-templates select="./rdg" />
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
        <xsl:for-each select="notatedMusic/neume">
          <img class="neume-small">
            <xsl:attribute name="src"><xsl:value-of select="@fontname"/><xsl:value-of select="@glyph.num"/>.svg</xsl:attribute>
          </img>
        </xsl:for-each>
      </span>
    </span>
  </xsl:template>

  <xsl:template match="text()">
    <xsl:value-of select="." />
  </xsl:template>

</xsl:stylesheet>