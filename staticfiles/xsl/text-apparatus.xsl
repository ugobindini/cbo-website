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
        <p class="text-font"><b>Critical apparatus (text)</b></p>
        <div class="flex-wrapper">
          <xsl:apply-templates select=".//app[@type='text']" />
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="app[@type='text']">
    <b style="margin-left: 6px;"><xsl:value-of select="ancestor::lg/@n"/>.<xsl:value-of select="ancestor::l/@n"/></b>
    <!-- TODO: numbering system for plays and refrains -->
    <xsl:apply-templates select="./lem" />
    <xsl:apply-templates select="./rdg" />
    <xsl:apply-templates select="./note" />
  </xsl:template>

  <xsl:template match="lem">
    <span class="flex-wrapper lem text-font">
      <xsl:apply-templates />
      <xsl:if test="@wit">
        <i style="margin-left: 6px;"><xsl:value-of select="@wit" /></i>
      </xsl:if>
      <xsl:if test="../rdg">]</xsl:if>
    </span>
  </xsl:template>

  <xsl:template match="rdg">
    <span class="flex-wrapper rdg" style="margin-left: 6px;">
      <i>
        <xsl:apply-templates />
      </i>
      <i style="margin-left: 6px;"><xsl:value-of select="@wit" /></i>
    <xsl:if test="../note">;</xsl:if>
    </span>
  </xsl:template>

  <xsl:template match="note">
    <i style="margin-left: 6px;">
      <xsl:apply-templates />
    </i>
  </xsl:template>

  <xsl:template match="w">
    <span class="word text-font">
      <xsl:apply-templates />
    </span>
  </xsl:template>

  <xsl:template match="pc[@resp='#editor']">
    <span>
      <xsl:choose>
        <xsl:when test="@pre='true'">
          <xsl:attribute name="class">pc pre</xsl:attribute>
        </xsl:when>
        <xsl:otherwise>
          <xsl:attribute name="class">pc</xsl:attribute>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:value-of select="./text()"/>
    </span>
  </xsl:template>

  <xsl:template match="pc" />

  <xsl:template match="seg[@type='syll']">
    <xsl:value-of select="normalize-space(.)"/>
  </xsl:template>

</xsl:stylesheet>