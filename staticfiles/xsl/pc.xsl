<?xml version="1.0" encoding="UTF-8" ?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:template match="pc">
    <span style="flex-shrink: 0;">
      <xsl:choose>
        <xsl:when test="@pre='true'">
          <xsl:attribute name="class">pc pre</xsl:attribute>
        </xsl:when>
        <xsl:otherwise>
          <xsl:attribute name="class">pc</xsl:attribute>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:if test="@rend='space-before'">
        <xsl:attribute name="style">margin-left: 6px;</xsl:attribute>
      </xsl:if>
      <xsl:if test="@rend='space-after'">
        <xsl:attribute name="style">margin-right: 0px;</xsl:attribute>
      </xsl:if>
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
</xsl:stylesheet>