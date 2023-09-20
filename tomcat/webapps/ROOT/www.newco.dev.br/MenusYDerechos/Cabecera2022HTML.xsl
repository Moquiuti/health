<?xml version="1.0" encoding="iso-8859-1"?>
<!--
	Cabecera: Logo, texto, opciones y menú
	Ultima revisión: ET 27may22 12:00 Cabecera_091221.js
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:import href="http://www.newco.dev.br/General/General.xsl"/>
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:template match="/">


<!--	Todos los documentos HTML deben empezar con esto	-->
<xsl:text disable-output-escaping='yes'>&lt;!doctype html></xsl:text>

<html>
<head>
	<link rel="stylesheet" href="http://www.newco.dev.br/General/basicMVM2022.css"/>
	<script src="http://www.newco.dev.br/General/jquery-3.6.0.js"></script>	
    <script type="text/javascript" src="http://www.newco.dev.br/MenusYDerechos/Cabecera2022_120122.js"></script>
	<script type="text/javascript">
		var Accion='<xsl:value-of select="/Cabecera/ACCION"/>';
	</script>
</head>

<body onload="bodyLoad();">
	<input type="hidden" id="URLSALIDA" value="{Cabecera/USUARIO/URLSALIDA}"/>
	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:choose>
			<xsl:when test="/Cabecera/LANG"><xsl:value-of select="/Cabecera/LANG"/></xsl:when>
			<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<div class="header">
		<!--<a href="http://www.newco.dev.br/Personal/BandejaTrabajo/WFStatus2022.xsql" target="mainFrame" class="logo"></a>-->
		<a target="mainFrame" class="logo"></a>
		<div class="header-right">
			<div class="key" onclick="CambiarClave();"></div>
			<div class="usuario">
				<p><xsl:value-of select="substring(Cabecera/USUARIO/NOMBRECENTRO,0,35)"/> | <xsl:value-of select="substring(Cabecera/USUARIO/NOMBREUSUARIO,0,25)"/></p>
			</div>
			<div class="sair" onclick="CerrarSesion();"></div>
		</div>
	</div>
	<div class="linha_separacao"> </div>
	<div class="menu">
		<a class="w60px" id="MENU_0" style="background-image:initial;transition:initial;" href="http://www.newco.dev.br/Personal/BandejaTrabajo/WFStatus2022.xsql" target="mainFrame">
			<img src="http://www.newco.dev.br/images/2022/icones/home2022.png" style="position:absolute;top:10px;padding:0 0;"/>
		</a>
		<xsl:for-each select="//MENU_DE_USUARIO/button">
			<xsl:if test="ID!=1"><!--30may22	Quitamos el menu de INICIO	-->
    			<a class="itens_menu principal" id="MENU_{ID}">
					<xsl:choose>
        			<xsl:when test="name_location!=''">
                		<xsl:attribute name="href">http://www.newco.dev.br/<xsl:value-of select="ENLACE_2022"/></xsl:attribute>
                		<xsl:attribute name="target"><xsl:value-of select="target"/></xsl:attribute>
						<xsl:choose>
						<xsl:when test="MARCA_VERDE">
							<img src="http://www.newco.dev.br/images/comeMatrizVERDE.gif"/>
						</xsl:when>
						<xsl:when test="MARCA_AMBAR">
							<img src="http://www.newco.dev.br/images/comeMatrizAMARILLO.gif"/>
						</xsl:when>
						<xsl:when test="MARCA_ROJA">
							<img src="http://www.newco.dev.br/images/comeMatrizROJO.gif"/>
						</xsl:when>
						</xsl:choose>
						<xsl:value-of select="@captionMin"/>
        			</xsl:when>
        			<xsl:otherwise>
                		<xsl:attribute name="href">javascript:SubMenu("<xsl:value-of select="ID"/>");</xsl:attribute>
						<xsl:value-of select="@captionMin"/>
        			</xsl:otherwise>
					</xsl:choose>
    			</a>
			</xsl:if>
		</xsl:for-each>

	    <xsl:for-each select="//MENU_DE_USUARIO/button">
			<xsl:if test="MENUS_HIJO/button/ID">
            <a  class="itens_menu submenu_{ID}" id="SUBMENU_{ID}" style="display:none" href="javascript:SalirSubmenu();">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&lt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a>
			<xsl:variable name="IDMenu"><xsl:value-of select="ID"/></xsl:variable>
			<xsl:for-each select="MENUS_HIJO/button">
			<a class="itens_menu submenu_{$IDMenu}" style="display:none" id="SUBMENU_{$IDMenu}_{ID}">
               	<xsl:attribute name="href">http://www.newco.dev.br/<xsl:value-of select="ENLACE_2022"/></xsl:attribute>
                <xsl:attribute name="target"><xsl:value-of select="target"/></xsl:attribute>
				<xsl:choose>
				<xsl:when test="MARCA_VERDE">
					<img src="http://www.newco.dev.br/images/comeMatrizVERDE.gif"/>
				</xsl:when>
				<xsl:when test="MARCA_AMBAR">
					<img src="http://www.newco.dev.br/images/comeMatrizAMARILLO.gif"/>
				</xsl:when>
				<xsl:when test="MARCA_ROJA">
					<img src="http://www.newco.dev.br/images/comeMatrizROJO.gif"/>
				</xsl:when>
				</xsl:choose>
				<xsl:value-of select="@captionMin"/>
	        </a>
			</xsl:for-each>
			</xsl:if>
		</xsl:for-each>
	</div>

</body>
</html>
</xsl:template>
</xsl:stylesheet>
