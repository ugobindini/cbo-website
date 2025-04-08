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
      <p><b><xsl:apply-templates select="./head"/></b></p>
      <xsl:apply-templates select="./p"/>
    </div>
  </xsl:template>

  <xsl:template match="p">
    <p class="margin-6px"><xsl:apply-templates /></p>
  </xsl:template>

  <xsl:template match="div[@type='sequence']">
    <div class="flex-column" data-type="poem">
      <p><b><xsl:apply-templates select="./head"/></b></p>
      <xsl:apply-templates select=".//lg[@type='versicle']"/>
    </div>
  </xsl:template>

  <xsl:template match="div[@type='poem'] | div[@type='leich']">
    <div class="flex-column" data-type="poem">
      <xsl:if test="@met">
        <xsl:attribute name="data-met"><xsl:value-of select="@met" /></xsl:attribute>
      </xsl:if>
      <xsl:if test="@rhyme">
        <xsl:attribute name="data-rhyme"><xsl:value-of select="@rhyme" /></xsl:attribute>
      </xsl:if>
      <xsl:apply-templates />
    </div>
  </xsl:template>

  <xsl:template match="lg[@type='strophe']">
    <div class="flex-column strophe" data-type="strophe">
      <xsl:if test="@met">
        <xsl:attribute name="data-met"><xsl:value-of select="@met" /></xsl:attribute>
      </xsl:if>
      <xsl:if test="@rhyme">
        <xsl:attribute name="data-rhyme"><xsl:value-of select="@rhyme" /></xsl:attribute>
      </xsl:if>
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
      <xsl:if test="@met">
        <xsl:attribute name="data-met"><xsl:value-of select="@met" /></xsl:attribute>
      </xsl:if>
      <xsl:if test="@rhyme">
        <xsl:attribute name="data-rhyme"><xsl:value-of select="@rhyme" /></xsl:attribute>
      </xsl:if>
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
      <xsl:attribute name="data-met"><xsl:value-of select="@met" /></xsl:attribute>
      <xsl:attribute name="data-rhyme"><xsl:value-of select="@rhyme" /></xsl:attribute>
      <div class="lg-heading"><b><xsl:value-of select="@n"/></b></div>
      <xsl:apply-templates />
    </div>
  </xsl:template>

  <xsl:template match="l">
    <div class="verse">
      <div class="verse-text">
        <xsl:apply-templates/>
      </div>
      <div class="verse-met non-selectable">
        <xsl:choose>
          <xsl:when test="@real">
            <b><xsl:value-of select="@real"/></b>(<xsl:value-of select="@met"/>)
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="@met"/>
          </xsl:otherwise>
        </xsl:choose>
      </div>
      <div class="verse-rhyme non-selectable">
        <xsl:value-of select="@rhyme"/>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="seg[@type='hemistich']">
  <div class="hemistich">
    <xsl:apply-templates/>
  </div>
  </xsl:template>

  <xsl:template match="w">
  <span class="word">
    <xsl:apply-templates/>
  </span>
  </xsl:template>

  <xsl:strip-space elements="w" />

  <xsl:template match="seg[@type='syll']">
    <xsl:value-of select="normalize-space(.)"/>
  </xsl:template>

  <xsl:template match="app[@type='neume']">
    <xsl:apply-templates select="./lem/*" />
  </xsl:template>

  <xsl:template match="app[@type='text']">
    <span class="apparatus-in-text">
      <div class="apparatus-note font-small">
        <xsl:attribute name="class">
          <xsl:if test="@type='text'">apparatus-note font-small cbo-border-red</xsl:if>
          <xsl:if test="@type='neume'">apparatus-note font-small cbo-border-blue</xsl:if>
        </xsl:attribute>
        <xsl:apply-templates select="./rdg" />
        <xsl:apply-templates select="./note" />
      </div>
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
    <span style="margin-right: 10px;"><i>
      <xsl:apply-templates />
    </i></span>
  </xsl:template>

</xsl:stylesheet>

