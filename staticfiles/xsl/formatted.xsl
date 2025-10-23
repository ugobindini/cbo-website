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

  <xsl:template match="lg[@type='refrain']/head" />

  <xsl:template match="div[@type='drama']">
    <div class="prose-text flex-column">
      <xsl:apply-templates/>
    </div>
  </xsl:template>

  <xsl:template match="move | stage">
    <p class="stage flex-wrapper"><span style="color: gray"><xsl:value-of select="@n" /></span><xsl:apply-templates /></p>
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
    <p class="text-font flex-wrapper"><xsl:apply-templates /></p>
  </xsl:template>

  <xsl:template match="div[@type='sequence']">
    <div class="flex-column" data-type="poem">
      <xsl:apply-templates />
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
          <xsl:apply-templates>
            <xsl:with-param name="lgHead"><xsl:value-of select="@n"/></xsl:with-param>
          </xsl:apply-templates>
        </xsl:when>
        <xsl:otherwise>
          <xsl:apply-templates>
            <xsl:with-param name="lgHead" />
          </xsl:apply-templates>
        </xsl:otherwise>
      </xsl:choose>
    </div>
  </xsl:template>

  <xsl:template match="lg[@type='refrain']">
    <div class="flex-column refrain" data-type="strophe">
      <xsl:attribute name="data-met"><xsl:value-of select="@met" /></xsl:attribute>
      <xsl:attribute name="data-rhyme"><xsl:value-of select="@rhyme" /></xsl:attribute>
      <xsl:choose>
        <xsl:when test="./head">
          <xsl:apply-templates>
            <xsl:with-param name="lgHead"><xsl:value-of select="./head"/></xsl:with-param>
          </xsl:apply-templates>
        </xsl:when>
        <xsl:otherwise>
          <xsl:apply-templates>
            <xsl:with-param name="lgHead">[Refl.]</xsl:with-param>
          </xsl:apply-templates>
        </xsl:otherwise>
      </xsl:choose>
    </div>
  </xsl:template>

  <xsl:template match="lg[@type='versicle']">
    <div class="flex-column strophe" data-type="strophe">
      <xsl:attribute name="data-met"><xsl:value-of select="@met" /></xsl:attribute>
      <xsl:attribute name="data-rhyme"><xsl:value-of select="@rhyme" /></xsl:attribute>
      <xsl:apply-templates>
        <xsl:with-param name="lgHead"><xsl:value-of select="@n"/></xsl:with-param>
      </xsl:apply-templates>
    </div>
  </xsl:template>

  <xsl:template match="l">
    <xsl:param name = "lgHead" />
    <xsl:choose>
      <xsl:when test="@n=1">
        <!-- Create extra div to avoid breaks between strophe/refrain heading and first verse -->
        <div class="no-break non-selectable">
          <div class="lg-heading selectable"><xsl:value-of select="$lgHead"/></div>
          <xsl:call-template name="verse-content" />
        </div>
      </xsl:when>
      <xsl:otherwise>
        <xsl:call-template name="verse-content" />
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="verse-content">
    <div class="verse selectable">
      <div class="verse-number non-selectable">
        <xsl:value-of select="@n"/>
      </div>
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

  <xsl:include href="word-and-syll.xsl"/>

  <xsl:include href="pc.xsl"/>

  <xsl:include href="app-in-text.xsl"/>
</xsl:stylesheet>