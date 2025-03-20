<?xml version="1.0" encoding="UTF-8" ?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:template match="teiHeader"/>

  <xsl:template match="castList" />

  <xsl:template match="div[@type='drama']">
    <div class="text-font prose-text">
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
    <div class="text-font prose-text">
      <div class="text-font font-bold">
        <xsl:apply-templates select="./head"/>
      </div>
      <xsl:apply-templates select="./p"/>
    </div>
  </xsl:template>

  <xsl:template match="p">
    <div class="text-paragraph">
      <xsl:apply-templates />
    </div>
  </xsl:template>

  <xsl:template match="div[@type='sequence']">
    <div class="poem">
      <div class="text-font font-bold">
        <xsl:apply-templates select="./head"/>
      </div>
      <xsl:apply-templates select=".//lg[@type='versicle']"/>
    </div>
  </xsl:template>

  <xsl:template match="div[@type='poem']">
    <div class="poem">
      <xsl:apply-templates select=".//lg[@type='strophe'] | .//lg[@type='refrain']" mode="poem" />
    </div>
  </xsl:template>

  <xsl:template match="div[@type='leich']">
    <div class="poem">
      <xsl:apply-templates select=".//lg[@type='strophe'] | .//lg[@type='refrain']" mode="leich" />
    </div>
  </xsl:template>

  <xsl:template match="lg[@type='strophe']" mode="poem">
    <div class="strophe">
      <xsl:choose>
        <xsl:when test="./@n">
          <div class="text-font strophe-heading"><xsl:value-of select="@n"/></div>
        </xsl:when>
        <xsl:otherwise>
          <div style="display: hidden;"></div>
          <!-- a small hack to make the verse numbers work even when there is no strophe number -->
        </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates>
        <xsl:with-param name="showmet" select="position()"/>
      </xsl:apply-templates>
    </div>
  </xsl:template>

  <xsl:template match="lg[@type='strophe']" mode="leich">
    <div class="strophe">
      <xsl:choose>
        <xsl:when test="./@n">
          <div class="text-font strophe-heading"><xsl:value-of select="@n"/></div>
        </xsl:when>
        <xsl:otherwise>
          <div style="display: hidden;"></div>
          <!-- a small hack to make the verse numbers work even when there is no strophe number -->
        </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates>
        <xsl:with-param name="showmet" select="1"/>
      </xsl:apply-templates>
    </div>
  </xsl:template>

  <xsl:template match="lg[@type='refrain']" mode="poem">
    <div class="strophe">
      <xsl:choose>
        <xsl:when test="./head">
          <div class="text-font refrain-heading"><xsl:value-of select="./head"/></div>
        </xsl:when>
        <xsl:otherwise>
          <div class="text-font refrain-heading"></div>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*[not(self::head)]">
        <xsl:with-param name="showmet" select="1"/>
      </xsl:apply-templates>
    </div>
  </xsl:template>

  <xsl:template match="lg[@type='refrain']" mode="leich">
    <xsl:apply-templates select="." mode="poem" />
  </xsl:template>

  <xsl:template match="lg[@type='versicle']">
    <div class="strophe">
      <div class="text-font strophe-heading"><xsl:value-of select="@n"/></div>
      <xsl:apply-templates>
        <xsl:with-param name="showmet" select="0"/>
      </xsl:apply-templates>
    </div>
  </xsl:template>

  <xsl:template match="l">
    <xsl:param name="showmet"/>
    <div class="verse">
      <div class="verse-text text-font">
        <xsl:apply-templates/>
      </div>
      <div class="verse-met non-selectable">
        <xsl:if test="$showmet = 1">
          <xsl:value-of select="@met"/>
        </xsl:if>
      </div>
      <div class="verse-real non-selectable">
        <xsl:value-of select="@real"/>
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
  <span class="word text-font">
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
      <div class="apparatus-note text-font font-small">
        <xsl:apply-templates select="./rdg" />
        <xsl:apply-templates select="./note" />
      </div>
      <xsl:apply-templates select="./lem/*" />
    </span>
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

