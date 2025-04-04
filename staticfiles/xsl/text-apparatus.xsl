<?xml version="1.0" encoding="UTF-8" ?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:template match="teiHeader"/>

  <xsl:strip-space elements="w" />

  <xsl:template match="app[@type='neume']">
    <xsl:apply-templates select="./lem/*" />
  </xsl:template>

  <xsl:template match="body">
    <xsl:if test=".//app[@type='text']">
      <div class="text-font font-small">
        <p class="text-font font-bold">Critical apparatus (text)</p>
        <div class="flex-wrapper">
          <xsl:apply-templates select=".//app[@type='text']" />
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="app[@type='text']">
    <b style="margin-right: 6px;"><xsl:value-of select="ancestor::lg/@n"/>.<xsl:value-of select="ancestor::l/@n"/></b>
    <xsl:apply-templates select="./lem" />
    <xsl:if test="./rdg">
      <xsl:choose>
        <xsl:when test="./lem/@wit">]</xsl:when>
        <xsl:otherwise>
          <span style="margin-left: -3px;">]</span>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:if>
    <xsl:apply-templates select="./rdg" />
    <xsl:if test="./rdg"><xsl:if test="./note">;</xsl:if></xsl:if>
    <xsl:apply-templates select="./note" />
  </xsl:template>

  <xsl:template match="lem">
    <span class="flex-wrapper lem text-font">
      <xsl:apply-templates />
    </span>
    <i style="margin-right: 3px;"><xsl:value-of select="@wit" /></i>
  </xsl:template>

  <xsl:template match="rdg">
    <span class="flex-wrapper rdg font-it" style="margin-left: 6px;">
      <xsl:apply-templates />
    </span>
    <i><xsl:value-of select="@wit" /></i>
  </xsl:template>

  <xsl:template match="note">
    <span class="flex-wrapper font-it" style="margin-left: 6px; margin-right: 6px;">
      <xsl:apply-templates />
    </span>
  </xsl:template>

  <xsl:template match="w">
    <span class="word text-font">
      <xsl:apply-templates />
    </span>
  </xsl:template>

  <xsl:template match="seg[@type='syll']">
    <xsl:value-of select="normalize-space(.)"/>
  </xsl:template>

</xsl:stylesheet>