<?xml version="1.0" encoding="UTF-8" ?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:template match="teiHeader"/>

  <xsl:template match="body">
    <html>
    <body>
      <xsl:apply-templates />
    </body>
    </html>
  </xsl:template>

  <xsl:template match="castList" />

  <xsl:template match="lg[@type='strophe'] | lg[@type='versicle']">
    <b><xsl:apply-templates select="./head"/></b>
    <xsl:apply-templates />
  </xsl:template>

  <xsl:template match="lg[@type='refrain']">
    <i><xsl:apply-templates select="./head"/></i>
    <xsl:apply-templates />
  </xsl:template>

  <xsl:template match="move | stage">
    <p><i><xsl:apply-templates /></i></p>
  </xsl:template>

  <xsl:template match="div[@type='prose']">
    <p><b><xsl:apply-templates select="./head"/></b></p>
    <xsl:apply-templates select="./p"/>
  </xsl:template>

  <xsl:template match="p">
    <p><xsl:apply-templates /></p>
  </xsl:template>

  <xsl:template match="l">
    <!-- TODO: hemistichs -->
    <p><xsl:apply-templates /></p>
  </xsl:template>

  <xsl:template match="w">
    <xsl:value-of select="normalize-space(.)"/>
  </xsl:template>

  <xsl:template match="seg[@type='syll']">
    <xsl:value-of select="normalize-space(.)"/>
  </xsl:template>

  <xsl:template match="pc" />

  <xsl:template match="pc[@resp='#editor']">
    <xsl:value-of select="normalize-space(.)"/>
  </xsl:template>

  <xsl:template match="app" />

</xsl:stylesheet>