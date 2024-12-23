<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl">
	
	<xsl:output method="html" indent="yes"/>
		<xsl:variable name="header">
		  <h1>Galeria arcymistrzów</h1>
		</xsl:variable>
	<xsl:template match="/">
	
		<html>
				<head>
					<meta charset="UTF-8" />
					<title>Szachy</title>
					<meta name="viewport" content="width=device-width, initial-scale=1.0" />
					<link rel="stylesheet" href="style.css" />
				</head>
				<body>
					<div id="kontener">
						<xsl:call-template name="tytul"/>
						<main>
							<xsl:copy-of select="$header" />
							<section>
								<xsl:apply-templates select="szachy/arcymistrzowie/arcymistrz[@wiek!=54]"/>
							</section>
							<h4>Porady</h4>
							<xsl:apply-templates select="szachy/gra/porady/porada[position()!=5]"/>
							<h4>Figury szachowe</h4>
							<ul>
							<xsl:apply-templates select="szachy/gra/bierki/bierka"/>
							</ul>
							<h4>YT</h4>
							<xsl:apply-templates select="szachy/kanalyYT/kanal[position()!=last()]"/>
						</main>
					</div>
				</body>
				<footer id="bottom">
				Co przygotować: <xsl:apply-templates select="szachy/gra/coPrzygotowac"/>
				</footer>
		</html>
	
	</xsl:template>
	
	<xsl:template name="tytul">
			<header>
					<h1 id="tytul">Królestwo Szachów</h1>
			</header>
	</xsl:template>
	
	<xsl:template match="arcymistrz">
		<figure>
			<xsl:apply-templates select="zdjecie"/>
			
			<figcaption class="opis">
			<h2><xsl:value-of select="imie"/> <xsl:text> </xsl:text>
			<xsl:value-of select="drugieImie"/> <xsl:text> </xsl:text> 
			<xsl:value-of select="nazwisko"/></h2> <br/>
			
			<ul class="osiagniecia">
				<li><xsl:value-of select="upper-case('wiek:')"/><xsl:value-of select="@wiek"/></li>
				<li><xsl:value-of select="upper-case('Płeć:')"/><xsl:value-of select="@plec"/></li>
				<li>
					<xsl:choose>
						<xsl:when test="ranking>2800">
							<xsl:text>Ranking ponad 2800 </xsl:text>
						</xsl:when>
						<xsl:otherwise>
							<xsl:text>Ranking poniżej 2800 </xsl:text>
						</xsl:otherwise>
					</xsl:choose>
				</li>
				<li><xsl:value-of select="substring('Kontynent: Kraj: ',1,11)"/><xsl:value-of select="kontynent"/></li>
				<li><xsl:value-of select="substring('Kontynent: Kraj: ',11,7)"/><xsl:value-of select="panstwo"/></li>
				<li><xsl:text>Arcymistrz od: </xsl:text><xsl:value-of select='format-number(osiagniecia/kiedyArcymistrz,"#")'/> </li>
				<xsl:for-each select="osiagniecia/osiagniecie">
					<xsl:sort select="opis" order="ascending"/>
					<xsl:number value="position()" format="1."/>
					<xsl:value-of select="opis"/> <br/>
				</xsl:for-each>
				<li><xsl:apply-templates select="link"/></li>
			</ul>
			
			</figcaption>
		</figure>
		<div style="clear:both"></div>
	</xsl:template>
	
	<xsl:template match="porada">
		<xsl:number value="position()" format="1."/>
		<xsl:value-of select="tekst"/> <br/>
	</xsl:template>
	
	<xsl:template match="coPrzygotowac">
		<xsl:value-of select="."/>
	</xsl:template>
	

	<xsl:template match="bierka">
		<li><xsl:value-of select="@nazwa"/> <xsl:text> Ilość:</xsl:text>
		<xsl:value-of select='format-number(@ilosc,"##%")'/> <xsl:text> Wartość:</xsl:text>
		<xsl:variable name="pomoc">
			<xsl:value-of select="wartosc"/>
		</xsl:variable>
		<xsl:value-of select="$pomoc"/>
		Poruszanie:
		<xsl:apply-templates select="poruszanie"/>
		</li>
	</xsl:template>
	
	<xsl:template match="poruszanie">
		<xsl:if test="@ograniczone='nie'">
			<xsl:value-of select="kierunek"/>
		</xsl:if>
		<xsl:if test="@ograniczone='tak'">
			<xsl:value-of select="kierunek"/>
			Dlugosc:
			<xsl:value-of select="dlugosc"/>
		</xsl:if>
	</xsl:template>
	
	<xsl:template match="kanal">
		<xsl:value-of select="nazwa"/>
		<xsl:text> Link:</xsl:text>
		<xsl:apply-templates select="link"/>
		<br/>
	</xsl:template>
	
	<xsl:template match="zdjecie">
		<img class="zdjecie" alt=".">
			<xsl:attribute name="src">
				<xsl:value-of select="@zrodlo"/>
			</xsl:attribute>
		</img>
	</xsl:template>
	
	<xsl:template match="link">
		<a>
			<xsl:attribute name="href">
				<xsl:value-of select="@zrodlo"/>
			</xsl:attribute>
			<xsl:attribute name="target">
				<xsl:text>_blank</xsl:text>
			</xsl:attribute>
			<xsl:value-of select="."/>
		</a>
	</xsl:template>
	
</xsl:stylesheet>