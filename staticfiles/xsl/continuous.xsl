<?xml version="1.0" encoding="UTF-8" ?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:template match="teiHeader"/>

  <xsl:template match="body">
    <div class="text-font flex-wrapper" style="font-size: 16px;">
      <xsl:apply-templates />
    </div>
  </xsl:template>

  <xsl:template match="castList" />

  <xsl:template match="head">
    <b style="margin-left: 8px;"><xsl:apply-templates /></b>
  </xsl:template>

  <xsl:template match="lg[@type='refrain']/head">
    <i style="margin-left: 8px;"><xsl:apply-templates /></i>
  </xsl:template>

  <xsl:template match="prologue">
    <p class="text-font"><xsl:apply-templates /></p>
  </xsl:template>

  <xsl:template match="div[@type='drama']">
    <i><xsl:apply-templates/></i>
  </xsl:template>

  <xsl:template match="div">
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="move | stage">
    <i style="margin-left: 8px;"><xsl:apply-templates /></i>
  </xsl:template>

  <xsl:template match="sp">
    <span class="text-font font-0-container"><xsl:apply-templates /></span>
  </xsl:template>

  <xsl:template match="div[@type='prose']">
    <xsl:apply-templates />
  </xsl:template>

  <xsl:template match="p">
    <xsl:apply-templates />
  </xsl:template>

  <xsl:template match="lg">
    <xsl:apply-templates />
  </xsl:template>

  <xsl:template match="l">
    <xsl:apply-templates />
  </xsl:template>

  <xsl:template match="seg[@type='hemistich']">
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:include href="word-and-syll.xsl"/>

  <xsl:include href="pc.xsl"/>

  <xsl:include href="app-in-text.xsl"/>
</xsl:stylesheet>