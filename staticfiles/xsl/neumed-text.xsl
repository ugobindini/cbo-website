<?xml version="1.0" encoding="UTF-8" ?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:template match="teiHeader"/>

  <xsl:template match="body">
    <div class="text-font" style="text-size: 16px;">
      <xsl:apply-templates />
    </div>
  </xsl:template>

  <xsl:template match="castList" />

  <xsl:template match="head">
    <b><xsl:apply-templates /></b>
  </xsl:template>

  <xsl:template match="div[@type='drama']">
    <div class="prose-text">
      <xsl:apply-templates/>
    </div>
  </xsl:template>

  <xsl:template match="move | stage">
    <p class="font-it">
      <xsl:apply-templates />
    </p>
  </xsl:template>

  <xsl:template match="sp">
    <div class="spoken-text">
      <xsl:apply-templates />
    </div>
  </xsl:template>

  <xsl:template match="div[@type='prose']">
    <div class="prose-text">
      <xsl:apply-templates />
    </div>
  </xsl:template>

  <xsl:template match="p">
    <div class="text-paragraph">
      <xsl:apply-templates />
    </div>
  </xsl:template>

  <xsl:template match="div[@type='sequence']">
    <div class="poem">
      <div class="font-bold">
        <xsl:apply-templates select="./head"/>
      </div>
      <xsl:apply-templates select=".//lg[@type='versicle']"/>
    </div>
  </xsl:template>

  <xsl:template match="div[@type='poem'] | div[@type='leich']">
    <div class="poem">
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
    <div class="strophe">
      <xsl:if test="@met">
        <xsl:attribute name="data-met"><xsl:value-of select="@met" /></xsl:attribute>
      </xsl:if>
      <xsl:if test="@rhyme">
        <xsl:attribute name="data-rhyme"><xsl:value-of select="@rhyme" /></xsl:attribute>
      </xsl:if>
      <xsl:choose>
        <xsl:when test="./@n">
          <div class="text-font strophe-heading"><xsl:value-of select="@n"/></div>
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
    <div class="strophe">
      <xsl:if test="@met">
        <xsl:attribute name="data-met"><xsl:value-of select="@met" /></xsl:attribute>
      </xsl:if>
      <xsl:if test="@rhyme">
        <xsl:attribute name="data-rhyme"><xsl:value-of select="@rhyme" /></xsl:attribute>
      </xsl:if>
      <xsl:choose>
        <xsl:when test="./head">
          <div class="text-font refrain-heading"><xsl:value-of select="./head"/></div>
        </xsl:when>
        <xsl:otherwise>
          <div class="text-font refrain-heading">[Refl.]</div>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates />
    </div>
  </xsl:template>

  <xsl:template match="lg[@type='versicle']">
    <div class="strophe">
      <xsl:attribute name="data-met"><xsl:value-of select="@met" /></xsl:attribute>
      <xsl:attribute name="data-rhyme"><xsl:value-of select="@rhyme" /></xsl:attribute>
      <div class="strophe-heading"><xsl:value-of select="@n"/></div>
      <xsl:apply-templates />
    </div>
  </xsl:template>

  <xsl:template match="l">
    <xsl:param name="showmet"/>
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

  <xsl:template match="seg[@type='syll']">
    <xsl:variable name="text"><xsl:value-of select="./text()"/></xsl:variable>
    <span class="neumed-syll">
      <span class="syl">
        <xsl:if test="@met='+'">
          <xsl:attribute name="data-met">+</xsl:attribute>
        </xsl:if>
        <xsl:value-of select="normalize-space($text)"/>
        <span class="syl-dash">
          <xsl:if test="@part='I' or  @part='M'"><xsl:text>-</xsl:text></xsl:if>
        </span>
      </span>
      <span class="neumes non-selectable">
        <span class="consonant-space"><xsl:value-of select="normalize-space($text)"/></span>
        <xsl:for-each select="notatedMusic/neume">
          <img class="neume">
            <xsl:attribute name="src">/staticfiles/img/svg/<xsl:value-of select="@fontname"/><xsl:value-of select="@glyph.num"/>.svg</xsl:attribute>
          </img>
        </xsl:for-each>
      </span>
    </span>
  </xsl:template>

  <xsl:template match="app">
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
    <span class="font-it" style="margin-right: 10px;">
      <xsl:apply-templates />
    </span>
  </xsl:template>

</xsl:stylesheet>

