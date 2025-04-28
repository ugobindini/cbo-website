<?xml version="1.0" encoding="UTF-8" ?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:template match="teiHeader"/>

  <xsl:template match="body">
    <div class="text-font" style="font-size: 16px;">
      <xsl:apply-templates />
    </div>
  </xsl:template>

  <xsl:template match="castList" />

  <xsl:template match="head">
    <b><xsl:apply-templates /></b>
  </xsl:template>

  <xsl:template match="div/head">
    <b><xsl:apply-templates /></b><span class="break"></span>
  </xsl:template>

  <xsl:template match="prologue">
    <p><xsl:apply-templates /></p>
  </xsl:template>

  <!-- TODO: decide how to represent it compared to direct speech -->
  <xsl:template match="q">
    <xsl:apply-templates />
  </xsl:template>

  <xsl:template match="lg[@type='refrain']/head">
    <div class="lg-heading"><i><xsl:apply-templates /></i></div>
  </xsl:template>

  <xsl:template match="div[@type='drama']">
    <div class="prose-text flex-column">
      <xsl:apply-templates/>
    </div>
  </xsl:template>

  <xsl:template match="move | stage">
    <p class="margin-6px"><i><xsl:apply-templates /></i></p>
  </xsl:template>

  <xsl:template match="sp">
    <div class="spoken-text">
      <xsl:apply-templates />
    </div>
  </xsl:template>

  <xsl:template match="div[@type='prose']">
    <div class="prose-text flex-column">
      <xsl:apply-templates />
    </div>
  </xsl:template>

  <xsl:template match="p">
    <p class="text-font"><xsl:apply-templates /></p>
  </xsl:template>

  <xsl:template match="div[@type='sequence']">
    <div class="flex-column" data-type="poem">
      <xsl:apply-templates />
    </div>
  </xsl:template>

  <xsl:template match="div[@type='poem'] | div[@type='leich']">
    <div class="flex-column" data-type="poem">
      <xsl:apply-templates />
    </div>
  </xsl:template>

  <xsl:template match="lg[@type='strophe']">
    <div class="flex-column strophe" data-type="strophe">
      <xsl:choose>
        <xsl:when test="./@n">
          <div class="lg-heading"><b><xsl:value-of select="@n"/></b></div>
        </xsl:when>
        <xsl:otherwise>
          <div style="display: hidden;" />
          <!-- a small hack to make the verse numbers work even when there is no strophe number -->
        </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates />
    </div>
  </xsl:template>

  <xsl:template match="lg[@type='refrain']">
    <div class="flex-column strophe" data-type="strophe">
      <xsl:choose>
        <xsl:when test="./head" />
        <xsl:otherwise>
          <div class="lg-heading"><i>[Refl.]</i></div>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates />
    </div>
  </xsl:template>

  <xsl:template match="lg[@type='versicle']">
    <div class="flex-column strophe" data-type="strophe">
      <div class="lg-heading"><b><xsl:value-of select="@n"/></b></div>
      <xsl:apply-templates />
    </div>
  </xsl:template>

  <xsl:template match="l">
    <div class="verse">
      <xsl:if test="@rend">
        <xsl:variable name="rend" select="@rend"/>
        <xsl:variable name="indent" select="substring-after($rend, '(')"></xsl:variable>
        <xsl:attribute name="data-indent"><xsl:value-of select="substring-before($indent, ')')" /></xsl:attribute>
      </xsl:if>
      <div class="verse-text" style="margin-left: 8px;">
        <xsl:apply-templates/>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="seg[@type='hemistich']">
  <div class="hemistich">
    <xsl:apply-templates/>
  </div>
  </xsl:template>

</xsl:stylesheet>

