<?xml version="1.0" encoding="UTF-8" ?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:template match="teiHeader"/>

  <xsl:template match="app[@type='neume']">
    <xsl:apply-templates select="./lem/*" />
  </xsl:template>

  <xsl:template match="body">
    <xsl:if test=".//app[@type='text']">
      <p class="text-font font-bold">Critical apparatus (text)</p>
    </xsl:if>
    <xsl:apply-templates select=".//app[@type='text']"/>
  </xsl:template>

  <xsl:template match="app[@type='text']">
    <b style="margin-right: 5px;"><xsl:value-of select="ancestor::lg/@n"/>.<xsl:value-of select="ancestor::l/@n"/></b>
    <xsl:choose>
      <xsl:when test="./lem/l">
        <xsl:value-of select="./lem/l[first()]/@n" />-<xsl:value-of select="./lem/l[last()]/@n" />
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-templates select="./lem/*" />
      </xsl:otherwise>
    </xsl:choose>
    <i><xsl:value-of select="./lem/@wit" /></i>
    <xsl:if test="./rdg">
      <xsl:choose>
        <xsl:when test="./lem/@wit">
          <span style="margin-left: 3px;">]</span>
        </xsl:when>
        <xsl:otherwise>
          <span style="margin-left: -5px;">]</span>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:if>
    <xsl:apply-templates select="./rdg" />
    <xsl:apply-templates select="./note" />
  </xsl:template>

  <xsl:template match="rdg">
    <span class="rdg font-it">
      <xsl:apply-templates />
    </span>
    <i style="margin-right: 10px;"><xsl:value-of select="@wit" /></i>
  </xsl:template>

  <xsl:template match="note">
    <span class="font-it" style="margin-right: 10px;">
      <xsl:apply-templates />
    </span>
  </xsl:template>

  <xsl:template match="w">
    <span class="word text-font">
      <xsl:choose>
        <xsl:when test=".//seg[@type='syll']">
          <xsl:apply-templates />
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="."/>
        </xsl:otherwise>
      </xsl:choose>
    </span>
  </xsl:template>

  <xsl:template match="seg[@type='syll']">
    <xsl:value-of select="normalize-space(.)"/>
  </xsl:template>

</xsl:stylesheet>