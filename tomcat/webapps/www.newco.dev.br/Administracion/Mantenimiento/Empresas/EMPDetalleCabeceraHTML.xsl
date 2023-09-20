<?xml version="1.0" encoding="iso-8859-1"?>
<!--
	Cabecera de la ficha de empresa
	Ultima revisión: ET 29mar20 15:45 EMPDetalleCabecera_290320.js
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:import href="http://www.newco.dev.br/General/General.xsl"/>
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="lang" select="@lang"/>
<xsl:template match="/CabeceraEmpresa">

<html>
<head>
	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:choose>
		<xsl:when test="LANG"><xsl:value-of select="LANG"/></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<meta http-equiv="Cache-Control" Content="no-cache"/>

	<title><xsl:value-of select="document($doc)/translation/texts/item[@name='detalle_empresa']/node()"/></title>

	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->

	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery-1.8.3.min.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPDetalleCabecera_290320.js"></script>
	<script type="text/javascript">
		var lang	= '<xsl:value-of select="LANG"/>';
		var IDEmpresa = '<xsl:value-of select="EMPRESA/IDEMPRESA"/>';
		<!--var Destino	= '<xsl:value-of select="DEST"/>';-->
		var Pestanna= '<xsl:value-of select="PESTANNA"/>';

		var imgPesProv, imgPesProvSel;
		<xsl:choose>
		<xsl:when test="EMPRESA/RESUMENPROVEEDORES/PROVEEDOR/NOTAMEDIA = 1">
			imgPesProv		= 'http://www.newco.dev.br/images/boton1star.gif';
			imgPesProvSel = 'http://www.newco.dev.br/images/boton1star1.gif';
		</xsl:when>
		<xsl:when test="EMPRESA/RESUMENPROVEEDORES/PROVEEDOR/NOTAMEDIA = 2">
			imgPesProv		= 'http://www.newco.dev.br/images/boton2star.gif';
			imgPesProvSel = 'http://www.newco.dev.br/images/boton2star1.gif';
		</xsl:when>
		<xsl:when test="EMPRESA/RESUMENPROVEEDORES/PROVEEDOR/NOTAMEDIA = 3">
			imgPesProv		= 'http://www.newco.dev.br/images/boton3star.gif';
			imgPesProvSel = 'http://www.newco.dev.br/images/boton3star1.gif';
		</xsl:when>
		<xsl:when test="EMPRESA/RESUMENPROVEEDORES/PROVEEDOR/NOTAMEDIA = 4">
			imgPesProv		= 'http://www.newco.dev.br/images/boton4star.gif';
			imgPesProvSel = 'http://www.newco.dev.br/images/boton4star1.gif';
		</xsl:when>
		<xsl:when test="EMPRESA/RESUMENPROVEEDORES/PROVEEDOR/NOTAMEDIA = 5">
			imgPesProv		= 'http://www.newco.dev.br/images/boton5star.gif';
			imgPesProvSel = 'http://www.newco.dev.br/images/boton5star1.gif';
		</xsl:when>
		<xsl:otherwise>
			imgPesProv		= 'http://www.newco.dev.br/images/boton2star.gif';
			imgPesProvSel = 'http://www.newco.dev.br/images/boton2star1.gif';
		</xsl:otherwise>
		</xsl:choose>
	</script>
</head>

<xsl:choose>
<xsl:when test="//xsql-error">
	<xsl:apply-templates select="//xsql-error"/>

	<body>
		<br/><br/>
		<center><xsl:apply-templates select="//jumpTo"/></center>
	</body>
</xsl:when>
<xsl:otherwise>
	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:choose>
		<xsl:when test="LANG"><xsl:value-of select="LANG"/></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->


	<!--	Titulo de la página		-->
	<div class="ZonaTituloPagina">
		<p class="TituloPagina">
			<xsl:value-of select="document($doc)/translation/texts/item[@name='empresa']/node()"/>:&nbsp;
 			<xsl:choose>
				<xsl:when test="EMPRESA/MVM or EMPRESA/ADMIN or EMPRESA/COMERCIAL or EMPRESA/CDC">
					<xsl:call-template name="desplegable">
					<xsl:with-param name="path" select="EMPRESA/EMPRESAS/field"/>
					<xsl:with-param name="onChange">javascript:CambiarEmpresa(this.value);</xsl:with-param>
					<!--<xsl:with-param name="claSel">muygrande</xsl:with-param>-->
					<xsl:with-param name="style">width:600px;font-size:20px;height:28px</xsl:with-param>
					</xsl:call-template>&nbsp;&nbsp;
				</xsl:when>
				<xsl:otherwise><xsl:value-of select="/CabeceraEmpresa/EMPRESA/EMPRESA" disable-output-escaping="yes"/></xsl:otherwise>
			</xsl:choose>
			<span class="CompletarTitulo">
				<a href="http://www.newco.dev.br/Gestion/Comercial/BuscadorEmpresas.xsql" id="Buscador" class="btnNormal"><xsl:value-of select="document($doc)/translation/texts/item[@name='Buscador']/node()"/></a>
			</span>
		</p>
	</div>
	<br/>

		<!-- Lógica visualización pestañas -->
		<!--

		Usuario COMPRADOR o MVM, ficha de PROVEEDOR
			- Pestaña "ficha empresa": TODOS
			- Pestaña información comercial: CDC, ADMIN
			- Pestaña documentos: "Ver ofertas", CDC, ADMIN
			- Pestaña seguimiento (actividad): COMERCIAL, ADMIN
			- Pestaña tareas (actividad): COMERCIAL, ADMIN
			- Pestaña MEDDICC: solo para COMERCIAL, MVM, MVMB
			- Pestaña Buscador: solo para MVM, MVMB

		Usuario PROVEEDOR, ficha de COMPRADOR (cliente suyo)
			- Pestaña "ficha empresa": TODOS

		Usuario MVM, ficha de COMPRADOR (cliente suyo)
			- Pestaña "ficha empresa": TODOS
			- Pestaña información comercial: COMERCIAL, CDC, ADMIN
			- Pestaña documentos: "Ver ofertas", CDC, ADMIN
			- Pestaña seguimiento (actividad): COMERCIAL, ADMIN
			- Pestaña tareas (actividad): COMERCIAL, ADMIN
			- Pestaña MEDDICC: COMERCIAL, ADMIN
			- Pestaña Buscador: COMERCIAL, ADMIN

		-->
		<!-- FIN Lógica visualización pestañas -->

 	<div class="divLeft">
		<ul class="pestannas">
			<li>
				<a href="#" id="Ficha" class="MenuEmp"><xsl:value-of select="document($doc)/translation/texts/item[@name='Ficha']/node()"/></a>
			</li>
			<xsl:if test="EMPRESA/ROL_EMPRESA = 'COMPRADOR' and EMPRESA/IDEMPRESA != EMPRESA/IDEMPRESADELUSUARIO and (EMPRESA/MVM or EMPRESA/ADMIN or EMPRESA/CDC)">
			<li>
				<a href="#" id="InfoCom" class="MenuEmp"><xsl:value-of select="document($doc)/translation/texts/item[@name='Info_comercial']/node()"/></a>
			</li>
	      	</xsl:if>
			<xsl:if test="EMPRESA/ROL_EMPRESA = 'VENDEDOR'">
			<li>
				<a href="#" id="Indicadores" class="MenuEmp"><xsl:value-of select="document($doc)/translation/texts/item[@name='Indicadores']/node()"/></a>
			</li>
	      	</xsl:if>
			<xsl:if test="EMPRESA/ROL_EMPRESA = 'VENDEDOR' and (EMPRESA/MVM or EMPRESA/ADMIN or EMPRESA/CDC)">
			<li>
				<a href="#" id="InfoComProv" class="MenuEmp"><xsl:value-of select="document($doc)/translation/texts/item[@name='Info_comercial']/node()"/></a>
			</li>
	      	</xsl:if>
			<xsl:if test="EMPRESA/MVM or EMPRESA/ADMIN or EMPRESA/COMERCIAL">
				<li>
					<a href="#" id="Seguimiento" class="MenuEmp" style="text-decoration:none;"><xsl:value-of select="document($doc)/translation/texts/item[@name='seguimiento']/node()"/></a>
				</li>
				<li>
					<a href="#" id="Tareas" class="MenuEmp" style="text-decoration:none;"><xsl:value-of select="document($doc)/translation/texts/item[@name='Tareas']/node()"/></a>
				</li>
	      	</xsl:if>
			<xsl:if test="EMPRESA/MVM and EMPRESA/IDEMPRESA != ''">
				<li>
					<a href="#" id="MEDDICC" class="MenuEmp" style="text-decoration:none;"><xsl:value-of select="document($doc)/translation/texts/item[@name='MEDDICC']/node()"/></a>
				</li>
	      	</xsl:if>
			<li>
				<a href="#" id="Documentos" class="MenuEmp" style="text-decoration:none;"><xsl:value-of select="document($doc)/translation/texts/item[@name='documentos']/node()"/></a>
			</li>
			<xsl:if test="EMPRESA/ROL_EMPRESA = 'VENDEDOR'">
				<li>
				<a href="#" id="ValoracionProv" class="MenuEmp" style="text-decoration:none;"><xsl:value-of select="document($doc)/translation/texts/item[@name='Nota']/node()"/>:
					&nbsp;<strong>
						<xsl:choose>
						<xsl:when test="EMPRESA/RESUMENPROVEEDORES/PROVEEDOR/NOTAMEDIA!=''"><xsl:value-of select="EMPRESA/RESUMENPROVEEDORES/PROVEEDOR/NOTAMEDIA"/></xsl:when>
						<xsl:otherwise>-</xsl:otherwise>
						</xsl:choose>
						/5</strong>
				</a>
				</li>
			</xsl:if>
		</ul>
	</div>
	<br/>
	<br/>
	<!-- iframe único para mostrar el contenido de cada pestaña -->
	<iframe width="100%" height="90%" frameBorder="0" id="iframeEmpresas"/>

</xsl:otherwise>
</xsl:choose>
</html>
</xsl:template>
</xsl:stylesheet>
