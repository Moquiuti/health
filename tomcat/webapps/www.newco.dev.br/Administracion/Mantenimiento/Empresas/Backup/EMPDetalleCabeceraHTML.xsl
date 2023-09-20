<?xml version="1.0" encoding="iso-8859-1"?>
<!--
 |
 |
 +-->
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
	<script type="text/javascript" src="http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPDetalleCabecera160216.js"></script>
	<script type="text/javascript">
		var lang			= '<xsl:value-of select="LANG"/>';
		var IDEmpresa = '<xsl:value-of select="EMP_ID"/>';
		var Destino		= '<xsl:value-of select="DEST"/>';

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

	<!-- Desplegable empresas-->
  <xsl:if test="EMPRESA/MVM or EMPRESA/ADMIN or EMPRESA/COMERCIAL or EMPRESA/CDC">
    <form name="Empresas" id="Empresas">
		<table class="infoTable" style="margin-bottom:10px;">
			<tr style="background:#C3D2E9;border-bottom:0px solid #3B5998;">
				<td>
					<p style="font-weight:bold;">
            <xsl:call-template name="desplegable">
							<xsl:with-param name="path" select="EMPRESA/EMPRESAS/field"/>
							<xsl:with-param name="onChange">javascript:CambiarEmpresa(this.value);</xsl:with-param>
              <xsl:with-param name="claSel">selectFont18</xsl:with-param>
            </xsl:call-template>&nbsp;&nbsp;
            <input type="hidden" name="IDPAIS" value="{EMPRESA/IDPAIS}"/>
            <input type="hidden" name="IDEMPRESA" value="{EMPRESA/IDEMPRESA}"/>
            <input type="hidden" name="IDEMPRESAUSUARIO" value="{EMPRESA/IDEMPRESADELUSUARIO}"/>
            <input type="checkbox" name="SOLO_CLIENTES" onchange="soloClientes(document.forms['Empresas']);"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='solo_clientes']/node()"/>&nbsp;&nbsp;
            <input type="checkbox" name="SOLO_PROVEE" onchange="soloProvee(document.forms['Empresas']);"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='solo_proveedores']/node()"/>
          </p>
				</td>
			</tr>
		</table><!--fin desplegable empresas, para saber de que empresa veo los datos-->
    </form>
  </xsl:if>

		<!-- Lógica visualización pestañas -->
		<!--

		Usuario COMPRADOR o MVM, ficha de PROVEEDOR
			- Pestaña "ficha empresa": TODOS
			- Pestaña información comercial: CDC, ADMIN
			- Pestaña documentos: "Ver ofertas", CDC, ADMIN
			- Pestaña seguimiento (actividad): COMERCIAL, ADMIN
			- Pestaña tareas (actividad): COMERCIAL, ADMIN
			- Pestaña MEDDICC: solo para MVM, MVMB
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


		<!-- INICIO Pestañas Lado Izquierdo -->
		<div style="background:#fff;float:left;">
			<xsl:if test="EMP_ID != ''">
			<!-- INICIO Pestaña 'Ficha' (todos) -->
	      &nbsp;<a href="#" id="Ficha" class="pestanaEmpresa" style="text-decoration:none;">
	        <xsl:choose>
	        <xsl:when test="LANG = 'spanish'">
	          <img src="http://www.newco.dev.br/images/botonFicha1.gif" alt="FICHA" id="FICHA"/>
	        </xsl:when>
	        <xsl:otherwise>
	          <img src="http://www.newco.dev.br/images/botonFicha1.gif" alt="FICHA" id="FICHA"/>
	        </xsl:otherwise>
	        </xsl:choose>
	      </a>&nbsp;
				<!-- FIN Pestaña 'Ficha' -->

				<!-- INICIO Pestaña 'Condiciones Comerciales' (solo ficha cliente) -->
				<xsl:if test="EMPRESA/ROL_EMPRESA = 'COMPRADOR' and EMPRESA/IDEMPRESA != EMPRESA/IDEMPRESADELUSUARIO and (EMPRESA/MVM or EMPRESA/ADMIN or EMPRESA/CDC)">
					<a href="#" id="InfoCom" class="pestanaEmpresa" style="text-decoration:none;">
						<xsl:choose>
						<xsl:when test="LANG = 'spanish'">
							<img src="http://www.newco.dev.br/images/botonCondicionesComerciales.gif" alt="CONDICIONES COMERCIALES" id="COND_COMERC"/>
						</xsl:when>
						<xsl:otherwise>
							<img src="http://www.newco.dev.br/images/botonCondicionesComerciales-BR.gif" alt="CONDIÇÕES COMERCIAIS" id="COND_COMERC"/>
						</xsl:otherwise>
						</xsl:choose>
					</a>&nbsp;
	      </xsl:if>
				<!-- FIN Pestaña 'Condiciones Comerciales' -->

				<!-- INICIO Pestaña 'Condiciones Comerciales' (solo ficha proveedor) -->
				<xsl:if test="EMPRESA/ROL_EMPRESA = 'VENDEDOR' and (EMPRESA/MVM or EMPRESA/ADMIN or EMPRESA/CDC)">
					<a href="#" id="InfoComProv" class="pestanaEmpresa" style="text-decoration:none;">
						<xsl:choose>
						<xsl:when test="LANG = 'spanish'">
							<img src="http://www.newco.dev.br/images/botonCondicionesComerciales.gif" alt="CONDICIONES COMERCIALES" id="COND_COMERC_PROV"/>
						</xsl:when>
						<xsl:otherwise>
							<img src="http://www.newco.dev.br/images/botonCondicionesComerciales-BR.gif" alt="CONDIÇÕES COMERCIAIS" id="COND_COMERC_PROV"/>
						</xsl:otherwise>
						</xsl:choose>
					</a>&nbsp;
	      </xsl:if>
				<!-- FIN Pestaña 'Condiciones Comerciales' -->
			</xsl:if>

			<xsl:if test="EMPRESA/MVM or EMPRESA/ADMIN or EMPRESA/COMERCIAL">
				<!-- INICIO Pestaña 'Seguimiento' (solo usuarios clientes) -->
				<a href="#" id="Seguimiento" class="pestanaEmpresa" style="text-decoration:none;">
					<xsl:choose>
					<xsl:when test="LANG = 'spanish'">
						<img src="http://www.newco.dev.br/images/botonSeguimiento.gif" alt="SEGUIMIENTO"/>
					</xsl:when>
					<xsl:otherwise>
						<img src="http://www.newco.dev.br/images/botonSeguimiento-Br.gif" alt="SEGUIMENTO"/>
					</xsl:otherwise>
					</xsl:choose>
				</a>&nbsp;
				<!-- FIN Pestaña 'Seguimiento' -->

				<!-- INICIO Pestaña 'Tareas' (solo usuarios clientes) -->
				<a href="#" id="Tareas" class="pestanaEmpresa" style="text-decoration:none;">
					<xsl:choose>
					<xsl:when test="LANG = 'spanish'">
						<img src="http://www.newco.dev.br/images/botonTareas.gif" alt="TAREAS"/>
					</xsl:when>
					<xsl:otherwise>
						<img src="http://www.newco.dev.br/images/botonTareas-Br.gif" alt="TAREFAS"/>
					</xsl:otherwise>
					</xsl:choose>
				</a>&nbsp;
				<!-- FIN Pestaña 'Tareas' -->
      </xsl:if>

			<!-- INICIO Pestaña 'Medicc' (solo MVM) -->
			<xsl:if test="EMPRESA/MVM and EMP_ID != ''">
				<a href="#" id="Medicc" class="pestanaEmpresa" style="text-decoration:none;">
					<xsl:choose>
					<xsl:when test="LANG = 'spanish'">
						<img src="http://www.newco.dev.br/images/botonMeddicc.gif" alt="MEDDICC"/>
					</xsl:when>
					<xsl:otherwise>
						<img src="http://www.newco.dev.br/images/botonMeddicc.gif" alt="MEDDICC"/>
					</xsl:otherwise>
					</xsl:choose>
				</a>&nbsp;
      </xsl:if>
			<!-- FIN Pestaña 'Medicc' -->

			<!-- INICIO Pestaña 'Documentos' (solo usuarios clientes) -->
			<xsl:if test="EMP_ID != '' and (EMPRESA/VEROFERTAS or EMPRESA/MVM or EMPRESA/ADMIN or EMPRESA/CDC)">
				<a href="#" id="Documentos" class="pestanaEmpresa" style="text-decoration:none;">
					<img src="http://www.newco.dev.br/images/botonDocumentos.gif" alt="DOCUMENTOS" id="DOCUMENTOS"/>
				</a>&nbsp;
      </xsl:if>
			<!-- FIN Pestaña 'Documentos' -->

			<!-- INICIO Pestaña 'Valoraciones/Estrellas' (solo ficha proveedor) -->
			<xsl:if test="EMPRESA/ROL_EMPRESA = 'VENDEDOR'">
				<a href="#" id="ValoracionProv" class="pestanaEmpresa" style="text-decoration:none;">
					<img>
						<xsl:choose>
						<xsl:when test="EMPRESA/RESUMENPROVEEDORES/PROVEEDOR/NOTAMEDIA = 1">
							<xsl:attribute name="src">http://www.newco.dev.br/images/boton1star.gif</xsl:attribute>
							<xsl:attribute name="alt"><xsl:value-of select="document($doc)/translation/texts/item[@name='prov_valoracion_uno_cinco']/node()"/></xsl:attribute>
							<xsl:attribute name="title"><xsl:value-of select="document($doc)/translation/texts/item[@name='prov_valoracion_uno_cinco']/node()"/></xsl:attribute>
						</xsl:when>
						<xsl:when test="EMPRESA/RESUMENPROVEEDORES/PROVEEDOR/NOTAMEDIA = 2">
							<xsl:attribute name="src">http://www.newco.dev.br/images/boton2star.gif</xsl:attribute>
							<xsl:attribute name="alt"><xsl:value-of select="document($doc)/translation/texts/item[@name='prov_valoracion_dos_cinco']/node()"/></xsl:attribute>
							<xsl:attribute name="title"><xsl:value-of select="document($doc)/translation/texts/item[@name='prov_valoracion_dos_cinco']/node()"/></xsl:attribute>
						</xsl:when>
						<xsl:when test="EMPRESA/RESUMENPROVEEDORES/PROVEEDOR/NOTAMEDIA = 3">
							<xsl:attribute name="src">http://www.newco.dev.br/images/boton3star.gif</xsl:attribute>
							<xsl:attribute name="alt"><xsl:value-of select="document($doc)/translation/texts/item[@name='prov_valoracion_tres_cinco']/node()"/></xsl:attribute>
							<xsl:attribute name="title"><xsl:value-of select="document($doc)/translation/texts/item[@name='prov_valoracion_tres_cinco']/node()"/></xsl:attribute>
						</xsl:when>
						<xsl:when test="EMPRESA/RESUMENPROVEEDORES/PROVEEDOR/NOTAMEDIA = 4">
							<xsl:attribute name="src">http://www.newco.dev.br/images/boton4star.gif</xsl:attribute>
							<xsl:attribute name="alt"><xsl:value-of select="document($doc)/translation/texts/item[@name='prov_valoracion_cuatro_cinco']/node()"/></xsl:attribute>
							<xsl:attribute name="title"><xsl:value-of select="document($doc)/translation/texts/item[@name='prov_valoracion_cuatro_cinco']/node()"/></xsl:attribute>
						</xsl:when>
						<xsl:when test="EMPRESA/RESUMENPROVEEDORES/PROVEEDOR/NOTAMEDIA = 5">
							<xsl:attribute name="src">http://www.newco.dev.br/images/boton5star.gif</xsl:attribute>
							<xsl:attribute name="alt"><xsl:value-of select="document($doc)/translation/texts/item[@name='prov_valoracion_cinco_cinco']/node()"/></xsl:attribute>
							<xsl:attribute name="title"><xsl:value-of select="document($doc)/translation/texts/item[@name='prov_valoracion_cinco_cinco']/node()"/></xsl:attribute>
						</xsl:when>
						<xsl:otherwise>
							<xsl:attribute name="src">http://www.newco.dev.br/images/boton2star.gif</xsl:attribute>
							<xsl:attribute name="alt"><xsl:value-of select="document($doc)/translation/texts/item[@name='prov_valoracion_dos_cinco']/node()"/></xsl:attribute>
							<xsl:attribute name="title"><xsl:value-of select="document($doc)/translation/texts/item[@name='prov_valoracion_dos_cinco']/node()"/></xsl:attribute>
						</xsl:otherwise>
						</xsl:choose>

					</img>
				</a>&nbsp;
			</xsl:if>
			<!-- FIN Pestaña 'Valoraciones' -->
		</div>
		<!-- FIN Pestañas Lado Izquierdo -->

	<!-- INICIO Pestañas Lado Derecho (solo MVM) -->
	<xsl:if test="EMPRESA/MVM">
		<div style="background:#fff;float:right;">
			<a href="#" id="Buscador" class="pestanaEmpresa" style="text-decoration:none;">
				<img src="http://www.newco.dev.br/images/botonBuscador.gif" alt="BUSCADOR"/>
			</a>
	  </div>
	</xsl:if>
	<!-- FIN Pestañas Lado Derecho -->

	<!-- iframe único para mostrar el contenido de cada pestaña -->
	<iframe width="100%" height="90%" frameBorder="0" id="iframeEmpresas"/>

</xsl:otherwise>
</xsl:choose>
</html>
</xsl:template>
</xsl:stylesheet>
