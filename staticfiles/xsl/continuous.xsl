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
    <b><xsl:apply-templates /></b>
  </xsl:template>

  <xsl:template match="div/head">
    <b style="margin-left: auto;"><xsl:apply-templates /></b><span class="break"></span>
  </xsl:template>

  <xsl:template match="lg[@type='refrain']/head">
    <i style="margin-left: 8px;"><xsl:apply-templates /></i>
  </xsl:template>

  <xsl:template match="prologue">
    <p class="text-font flex-wrapper"><xsl:apply-templates /></p>
  </xsl:template>

  <xsl:template match="div[@type='drama']">
    <i><xsl:apply-templates/></i>
  </xsl:template>

  <xsl:template match="div">
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="move | stage">
    <i><xsl:apply-templates /></i>
  </xsl:template>

  <xsl:template match="sp">
    <span class="text-font">
      <xsl:apply-templates />
    </span>
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

  <xsl:template match="w">
    <span class="word text-font" style="vertical-align: bottom;">
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
              <xsl:attribute name="src">/staticfiles/img/svg/<xsl:value-of select="@fontname"/><xsl:value-of select="@glyph.num"/>.svg</xsl:attribute>
            </img>
          </xsl:for-each>
        </span>
      </xsl:if>
    </span>
  </xsl:template>

  <xsl:template match="pc">
    <span>
      <xsl:choose>
        <xsl:when test="@pre='true'">
          <xsl:attribute name="class">pc pre</xsl:attribute>
        </xsl:when>
        <xsl:otherwise>
          <xsl:attribute name="class">pc</xsl:attribute>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
        <xsl:when test="@resp='#editor'">
          <xsl:attribute name="data-resp">ed</xsl:attribute>
        </xsl:when>
        <xsl:otherwise>
          <xsl:attribute name="data-resp">ms</xsl:attribute>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:value-of select="./text()"/>
    </span>
  </xsl:template>

  <xsl:template match="app">
    <span>
      <xsl:attribute name="class">
        <xsl:if test="@type='text'">apparatus-in-text app-type-text apparatus-visible</xsl:if>
        <xsl:if test="@type='neume'">apparatus-in-text app-type-neume apparatus-visible</xsl:if>
      </xsl:attribute>
      <span>
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
    <span class="rdg">
      <xsl:apply-templates />
    </span>
    <span class="wit">
      <i><xsl:value-of select="@wit" /></i>
    </span>
  </xsl:template>

  <xsl:template match="note">
    <span><i>
      <xsl:apply-templates />
    </i></span>
  </xsl:template>

</xsl:stylesheet>

