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
      <xsl:apply-templates />
    </div>
  </xsl:template>

  <xsl:template match="p">
    <p class="margin-6px"><xsl:apply-templates /></p>
  </xsl:template>

  <xsl:template match="div[@type='sequence']">
    <div class="flex-column" data-type="poem">
      <xsl:apply-templates select="./head | .//lg[@type='versicle']"/>
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
      <xsl:attribute name="data-met"><xsl:value-of select="@met" /></xsl:attribute>
      <xsl:attribute name="data-rhyme"><xsl:value-of select="@rhyme" /></xsl:attribute>
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
      <xsl:attribute name="data-met"><xsl:value-of select="@met" /></xsl:attribute>
      <xsl:attribute name="data-rhyme"><xsl:value-of select="@rhyme" /></xsl:attribute>
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
          <xsl:when test="@met-variant">
            <b><xsl:value-of select="@met-variant"/></b>(<xsl:value-of select="@met"/>)
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="@met"/>
          </xsl:otherwise>
        </xsl:choose>
      </div>
      <div class="verse-rhyme non-selectable">
        <xsl:choose>
          <xsl:when test="@rhyme-variant">
            <b><xsl:value-of select="@rhyme-variant"/></b>(<xsl:value-of select="@rhyme"/>)
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="@rhyme"/>
          </xsl:otherwise>
        </xsl:choose>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="seg[@type='hemistich']">
  <div class="hemistich">
    <xsl:apply-templates/>
  </div>
  </xsl:template>

  <xsl:template match="w">
    <span class="word text-word-margin text-font" style="vertical-align: bottom;">
      <xsl:apply-templates/>
    </span>
  </xsl:template>

  <xsl:template match="seg[@type='syll']">
    <xsl:variable name="text"><xsl:value-of select="./text()"/></xsl:variable>
    <span class="neumed-syll" style="vertical-align: bottom;">
      <span class="syl">
        <xsl:if test="@met='+'">
          <xsl:attribute name="data-met">+</xsl:attribute>
        </xsl:if>
        <xsl:value-of select="normalize-space($text)"/>
        <span class="syl-dash">
          <xsl:if test="./notatedMusic">
            <xsl:if test="@part='I' or  @part='M'"><xsl:text>-</xsl:text></xsl:if>
          </xsl:if>
        </span>
      </span>
      <xsl:if test="./notatedMusic">
        <span class="neumes non-selectable">
          <span class="consonant-space"><xsl:value-of select="normalize-space($text)"/></span>
          <xsl:for-each select="notatedMusic/neume">
            <img class="neume">
              <xsl:attribute name="src">/staticfiles/img/glyphs/<xsl:value-of select="@fontname"/><xsl:value-of select="@glyph.num"/>.svg</xsl:attribute>
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
        <xsl:if test="@type='text'">apparatus-in-text app-text</xsl:if>
        <xsl:if test="@type='neume'">apparatus-in-text</xsl:if>
      </xsl:attribute>
      <div>
        <xsl:attribute name="class">
          <xsl:if test="@type='text'">apparatus-note font-small cbo-border-red</xsl:if>
          <xsl:if test="@type='neume'">apparatus-note font-small cbo-border-blue</xsl:if>
        </xsl:attribute>
        <xsl:apply-templates select="./rdg" />
        <xsl:if test="./rdg"><xsl:if test="./note">;</xsl:if></xsl:if>
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

