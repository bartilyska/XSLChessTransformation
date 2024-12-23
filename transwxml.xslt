<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

	<xsl:output method="xml" />
		
	<xsl:template match="/">
		<xsl:element name="NoweSzachy">
			<xsl:apply-templates select="szachy/gra/bierki/bierka"/>
			<xsl:copy-of select="szachy/arcymistrzowie"/>
			<xsl:apply-templates select="szachy/gra/porady/porada/tekst"/>
			<xsl:apply-templates select="szachy/kanalyYT/kanal"/>
		</xsl:element>
	</xsl:template>
	
	<xsl:template match="bierka">
		<xsl:element name="{@nazwa}">
			<xsl:attribute name="wartość">
				<xsl:value-of select="wartosc"/>
			</xsl:attribute>
			<xsl:attribute name="Poruszanie">
				<xsl:value-of select="poruszanie/kierunek"/>
			</xsl:attribute>
			<xsl:element name="ilosc">
				<xsl:value-of select="@ilosc"/>
			</xsl:element>
		</xsl:element>
	</xsl:template>
	
	<xsl:template match="tekst">
            <xsl:copy>
                <xsl:apply-templates/>
            </xsl:copy>
    </xsl:template>
	
	<xsl:template match="kanal">
		<xsl:element name="Szachista">
            <xsl:attribute name="{nazwa}">
				<xsl:value-of select="profesjonalista | amator"/>
			</xsl:attribute>
			<xsl:element name="link">
				<xsl:value-of select="link/@zrodlo"/>
			</xsl:element>
		</xsl:element>
    </xsl:template>
	
</xsl:stylesheet>