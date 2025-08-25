<?xml version="1.0" encoding="UTF-8" ?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:template match="app">
    <span>
      <xsl:attribute name="class">
        <xsl:if test="@type='text'">apparatus-in-text app-type-text apparatus-active</xsl:if>
        <xsl:if test="@type='neume'">apparatus-in-text app-type-neume apparatus-active</xsl:if>
      </xsl:attribute>
      <span class="flex-wrapper">
        <xsl:attribute name="class">
          <xsl:if test="@type='text'">apparatus-note font-small cbo-border-red</xsl:if>
          <xsl:if test="@type='neume'">apparatus-note font-small cbo-border-blue toggle-neumes</xsl:if>
        </xsl:attribute>
        <xsl:apply-templates select="./rdg" />
        <xsl:apply-templates select="./note" />
      </span>
      <xsl:apply-templates select="./lem" />
    </span>
  </xsl:template>

  <xsl:template match="lem">
    <xsl:apply-templates />
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
</xsl:stylesheet>