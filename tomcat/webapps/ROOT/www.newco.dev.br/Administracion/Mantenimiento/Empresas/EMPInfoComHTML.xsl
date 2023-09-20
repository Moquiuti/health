<?xml version="1.0" encoding="iso-8859-1"?>
<!--
	Mostrar información comrecial de la empresa.
	Ultima revision: ET 30mar21 16:47 EMPInfoCom_300321.js
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:import href="http://www.newco.dev.br/General/General.xsl"/>
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="lang" select="@lang"/>
<xsl:template match="/InfoCom">

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

	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->

	<title><xsl:value-of select="/InfoCom/EMPRESA/EMP_NOMBRECORTOPUBLICO" disable-output-escaping="yes"/></title>

	<meta http-equiv="Cache-Control" Content="no-cache"/>

	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery-1.8.3.min.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>

	<!-- solo se muestra la tabla resumen (como pop-up) para fichas de proveedores (acceso para usuarios MVM y MVMB) -->
	<xsl:if test="(/InfoCom/EMPRESA/MVM or /InfoCom/EMPRESA/MVMB) and /InfoCom/EMPRESA/ROL='VENDEDOR'">
		<link rel="stylesheet" type="text/css" href="http://www.newco.dev.br/General/TablaResumen-popup.css"/>
		<script type="text/javascript" src="http://www.newco.dev.br/General/TablaResumen-popup.js"></script>
	</xsl:if>

	<script type="text/javascript">
		var lang = '<xsl:value-of select="LANG"/>';
		var condProvOK	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='ok_cond_proveedor_save']/node()"/>';
		var condProvERR	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='error_cond_proveedor_save']/node()"/>';
	</script>

	<script type="text/javascript" src="http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPInfoCom_300321.js"></script>

</head>

<body onload="javascript:onloadEvents();">
	<xsl:choose>
		<xsl:when test="//SESION_CADUCADA">
			<xsl:apply-templates select="//SESION_CADUCADA"/>
		</xsl:when>
		<xsl:when test="//xsql-error">
			<xsl:apply-templates select="//xsql-error"/>
		</xsl:when>
		<xsl:when test="//Status">
			<xsl:apply-templates select="//Status"/>
		</xsl:when>
		<xsl:otherwise>
			<xsl:apply-templates select="EMPRESA"/>
		</xsl:otherwise>
	</xsl:choose>
</body>
</html>
</xsl:template>

<!--
 |  Templates
 +-->

<xsl:template match="EMPRESA">
	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:choose>
		<xsl:when test="/InfoCom/LANG"><xsl:value-of select="/InfoCom/LANG"/></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->


	<!--	Titulo de la página		-->
	<div class="ZonaTituloPagina">
		<p class="Path"><xsl:value-of select="document($doc)/translation/texts/item[@name='Inicio']/node()"/>&nbsp;/&nbsp;<span class="FinPath"><xsl:value-of select="document($doc)/translation/texts/item[@name='empresa']/node()"/>&nbsp;</span>
		<span class="CompletarTitulo">
			<xsl:if test="/InfoCom/EMPRESA/MVM"><span class="amarillo">EMP_ID:&nbsp;<xsl:value-of select="EMP_ID"/></span></xsl:if>
		</span>
		</p>
		<p class="TituloPagina">
        	<xsl:choose>
        	<xsl:when test="EMP_NOMBRECORTOPUBLICO != ''"><xsl:value-of select="EMP_NOMBRECORTOPUBLICO" disable-output-escaping="yes"/></xsl:when>
        	<xsl:otherwise><xsl:value-of select="substring(EMP_NOMBRE,0,50)" disable-output-escaping="yes"/></xsl:otherwise>
        	</xsl:choose>
			<span class="CompletarTitulo" style="width:400px;">
			<xsl:if test="/InfoCom/EMPRESA/MVM or /InfoCom/EMPRESA/MVMB">
				<a class="btnNormal" style="text-decoration:none;">
					<xsl:attribute name="href">javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPManten.xsql?ID=<xsl:value-of select="EMP_ID"/>&amp;ADMINISTRADORMVM=ADMINISTRADORMVM','Mantenimiento empresa',100,80,0,0);</xsl:attribute>
					<xsl:value-of select="document($doc)/translation/texts/item[@name='modificar']/node()"/>
				</a>
				&nbsp;
				<a class="btnNormal" href="javascript:window.print();" style="text-decoration:none;" title="Imprimir">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='imprimir']/node()"/>
				</a>
			</xsl:if>
			<xsl:if test="/InfoCom/EMPRESA/ROL = 'VENDEDOR'">
				<xsl:text>&nbsp;&nbsp;&nbsp;</xsl:text>
				<a class="btnNormal">
					<xsl:attribute name="href">javascript:showTablaResumenEmpresa(true);</xsl:attribute>
					<img src="http://www.newco.dev.br/images/tabla.gif"/>&nbsp;
					<xsl:value-of select="document($doc)/translation/texts/item[@name='resumen']/node()"/>
				</a>
			</xsl:if>
			</span>
		</p>
	</div>
	<br/>
	<br/>

	<div class="divLeft">
		<!-- INICIO Condiciones Comerciales -->
		<!--
		 <h1 class="titlePage" style="float:left;width:60%;padding-left:20%;">
      <xsl:choose>
      <xsl:when test="EMP_NOMBRE_CORTO != ''"><xsl:value-of select="EMP_NOMBRE_CORTO" disable-output-escaping="yes"/></xsl:when>
      <xsl:otherwise><xsl:value-of select="EMP_NOMBRE" disable-output-escaping="yes"/></xsl:otherwise>
      </xsl:choose>:&nbsp;

      <xsl:value-of select="document($doc)/translation/texts/item[@name='informacion_comercial']/node()"/>

      <xsl:if test="/InfoCom/EMPRESA/MVM or /InfoCom/EMPRESA/MVMB">
        <xsl:text>&nbsp;&nbsp;&nbsp;</xsl:text>
        <a href="javascript:window.print();" style="text-decoration:none;">
          <img src="http://www.newco.dev.br/images/imprimir.gif"/>
          <xsl:value-of select="document($doc)/translation/texts/item[@name='imprimir']/node()"/>
        </a>
        <!- -ense?o resumen arriba solo para proveedores, si es cliente ense?o tabla directamente- ->
        <xsl:if test="/InfoCom/EMPRESA/ROL = 'VENDEDOR'">
          <xsl:text>&nbsp;&nbsp;&nbsp;</xsl:text>
          <a style="text-decoration:none;">
            <xsl:attribute name="href">javascript:showTablaResumenEmpresa(true);</xsl:attribute>
            <img src="http://www.newco.dev.br/images/tabla.gif"/>&nbsp;
            <xsl:value-of select="document($doc)/translation/texts/item[@name='resumen']/node()"/>
          </a>
        </xsl:if>
      </xsl:if>
		</h1>
    <h1 class="titlePage" style="float:left;width:20%;">&nbsp;
      <xsl:if test="/InfoCom/EMPRESA/MVM or /InfoCom/EMPRESA/MVMB or /InfoCom/EMPRESA/EDITAR_INFO_COMERCIAL"><span style="float:right; padding:5px;" class="amarillo">EMP_ID: <xsl:value-of select="EMP_ID"/></span></xsl:if>
    </h1>
	-->

    <!--CONDICIONES COMERCIALES SI SOY PROVEEDOR-->
    <xsl:if test="/InfoCom/EMPRESA/ROL = 'VENDEDOR'">
      <xsl:call-template name="condComercialProveedor"/>
		</xsl:if>
		<!-- FIN Condiciones Comerciales (ficha empresa proveedor) -->

		<!-- INICIO Condiciones Comerciales a Proveedor (ficha empresa cliente) -->
		<xsl:if test="/InfoCom/EMPRESA/ROL = 'COMPRADOR'">
      <xsl:call-template name="condComercialCliente"/>
		</xsl:if>

	</div><!--fin de divCenter50-->
</xsl:template>

<!--TEMPLATE COND_COMMERCIALES PROVEEDOR-->
<xsl:template name="condComercialProveedor">
  <!--idioma-->
	<xsl:variable name="lang">
		<xsl:choose>
		<xsl:when test="/InfoCom/LANG"><xsl:value-of select="/InfoCom/LANG"/></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

  <!-- solo se muestra la tabla resumen (como pop-up) para fichas de proveedores (acceso para usuarios MVM y MVMB) -->
	<xsl:if test="/InfoCom/EMPRESA/MVM or /InfoCom/EMPRESA/MVMB">
	<div class="overlay-container-2">
		<div class="window-container zoomout">
			<p><a href="javascript:showTablaResumenEmpresa(false);"><xsl:value-of select="document($doc)/translation/texts/item[@name='cerrar']/node()"/></a></p>
			<table>
			<thead>
				<tr>
					<td>&nbsp;</td>
				<xsl:for-each select="/InfoCom/EMPRESA/RESUMENES_MENSUALES/CABECERA/COLUMNA">
					<td><xsl:value-of select="MES"/>/<xsl:value-of select="ANYO"/></td>
				</xsl:for-each>
				</tr>
			</thead>

			<tbody>
			<xsl:for-each select="/InfoCom/EMPRESA/RESUMENES_MENSUALES/RESUMEN_MENSUAL">
				<tr>
					<td class="indicador"><xsl:value-of select="@Nombre"/></td>
				<xsl:for-each select="COLUMNA">
					<td><xsl:value-of select="VALOR"/></td>
				</xsl:for-each>
                                </tr>
			</xsl:for-each>
			</tbody>
			</table>
		</div>
	</div>
	</xsl:if>
	<!-- FIN Pop-up para mostrar tabla resumen empresa (solo MVM y MVMB)-->
	<div class="divLeft">
	<table width="100%">
	<tr style="height:70px;text-align:center;background-color:#F6DBC9;">
	<td width="12%" style="border:10px solid white;">
		<span style="font-size: 15px;"><xsl:value-of select="document($doc)/translation/texts/item[@name='pedidos_90d']/node()"/></span><br/>
		<span style="font-size: 25px;color:green;"><xsl:value-of select="/InfoCom/EMPRESA/RESUMENPROVEEDORES/PROVEEDOR/EIS_PROV_NUMEROPEDIDOS"/></span><br/>
		<span style="font-size: 20px;color:green;"><xsl:value-of select="/InfoCom/EMPRESA/RESUMENPROVEEDORES/PROVEEDOR/EIS_PROV_IMPORTEPEDIDOS"/><xsl:value-of select="/InfoCom/EMPRESA/DIVISA/SUFIJO"/></span>
	</td>
	<td width="12%" style="border:10px solid white;">
		<span style="font-size: 15px;"><xsl:value-of select="document($doc)/translation/texts/item[@name='pedidos_retr_90d']/node()"/></span><br/>
		<span style="font-size: 25px;color:red;"><xsl:value-of select="/InfoCom/EMPRESA/RESUMENPROVEEDORES/PROVEEDOR/EIS_PROV_NUMPEDIDOSRETRASADOS"/></span><br/>
		<span style="font-size: 20px;color:red;"><xsl:value-of select="/InfoCom/EMPRESA/RESUMENPROVEEDORES/PROVEEDOR/EIS_PROV_PORCPEDIDOSRETRASADOS"/>%</span>
	</td>
	<td width="12%" style="border:10px solid white;">
		<span style="font-size: 15px;"><xsl:value-of select="document($doc)/translation/texts/item[@name='pedidos_parc_90d']/node()"/></span><br/>
		<span style="font-size: 25px;color:red;"><xsl:value-of select="/InfoCom/EMPRESA/RESUMENPROVEEDORES/PROVEEDOR/EIS_PROV_NUMPEDIDOSPARCIALES"/></span><br/>
		<span style="font-size: 20px;color:red;"><xsl:value-of select="/InfoCom/EMPRESA/RESUMENPROVEEDORES/PROVEEDOR/EIS_PROV_PORCPEDIDOSPARCIALES"/>%</span>
	</td>
	<td width="12%" style="border:10px solid white;">
		<span style="font-size: 15px;"><xsl:value-of select="document($doc)/translation/texts/item[@name='retraso_medio_90d']/node()"/></span><br/>
		<span style="font-size: 25px;color:red;"><xsl:value-of select="/InfoCom/EMPRESA/RESUMENPROVEEDORES/PROVEEDOR/EIS_PROV_RETRASOMEDIO"/></span><br/>
		<span style="font-size: 20px;color:red;"><xsl:value-of select="/InfoCom/EMPRESA/RESUMENPROVEEDORES/PROVEEDOR/EIS_PROV_RETRASODIAS"/></span>
	</td>
	<td width="12%" style="border:10px solid white;">
		<span style="font-size: 15px;"><xsl:value-of select="document($doc)/translation/texts/item[@name='licitaciones_90d']/node()"/></span><br/>
		<span style="font-size: 25px;color:green;"><xsl:value-of select="/InfoCom/EMPRESA/RESUMENPROVEEDORES/PROVEEDOR/EIS_PROV_LICITACIONES"/></span><br/>
		<!--<span style="font-size: 20px;color:green;"><xsl:value-of select="EIS_PROV_IMPORTEPEDIDOS"/></span>-->
	</td>
	<td width="12%" style="border:10px solid white;">
		<span style="font-size: 15px;"><xsl:value-of select="document($doc)/translation/texts/item[@name='lic_ofertadas_90d']/node()"/></span><br/>
		<span style="font-size: 25px;color:green;"><xsl:value-of select="/InfoCom/EMPRESA/RESUMENPROVEEDORES/PROVEEDOR/EIS_PROV_LICITACIONESRESP"/></span><br/>
		<span style="font-size: 20px;color:green;"><xsl:value-of select="/InfoCom/EMPRESA/RESUMENPROVEEDORES/PROVEEDOR/EIS_PROV_LIC_RATIORESPTOT"/>%</span>
	</td>
	<td width="12%" style="border:10px solid white;">
		<span style="font-size: 15px;"><xsl:value-of select="document($doc)/translation/texts/item[@name='lic_ganadas_90d']/node()"/></span><br/>
		<span style="font-size: 25px;color:green;"><xsl:value-of select="/InfoCom/EMPRESA/RESUMENPROVEEDORES/PROVEEDOR/EIS_PROV_LICITACIONESGANADAS"/></span><br/>
		<span style="font-size: 20px;color:green;"><xsl:value-of select="/InfoCom/EMPRESA/RESUMENPROVEEDORES/PROVEEDOR/EIS_PROV_LIC_RATIOGANRESP"/>%</span>
	</td>
	</tr>
	</table>
	</div>

  <!--pesta?as condic comerciales prove, licitaciones, incidencias, rotura stock proveedor, cliente y mvm visualiza-->
  <!--<div class="divLeft lineaAzul">&nbsp;</div>-->
  <br/>&nbsp;
  <br/>&nbsp;
 	<div class="divLeft">
		<ul class="pestannas">
			<li>
				<a id="pes_CondicPartic" class="MenuLic"><xsl:value-of select="document($doc)/translation/texts/item[@name='condiciones_particulares']/node()"/></a>
			</li>
			<li>
				<a id="pes_Evaluaciones" class="MenuLic"><xsl:value-of select="document($doc)/translation/texts/item[@name='evaluaciones']/node()"/>&nbsp;<xsl:value-of select="PLAZO_CONSULTAS"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='dias']/node()"/>
					(<xsl:value-of select="EVALUACIONESPRODUCTOS/TOTAL"/>)</a>
			</li>
			<li>
				<a id="pes_Incidencias" class="MenuLic"><xsl:value-of select="document($doc)/translation/texts/item[@name='incidencias']/node()"/>&nbsp;<xsl:value-of select="PLAZO_CONSULTAS"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='dias']/node()"/>
					(<xsl:value-of select="INCIDENCIASPRODUCTOS/TOTAL"/>)</a>
			</li>
			<li>
				<a id="pes_Roturas" class="MenuLic"><xsl:value-of select="document($doc)/translation/texts/item[@name='roturas_stock']/node()"/>&nbsp;<xsl:value-of select="PLAZO_CONSULTAS"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='dias']/node()"/>
					(<xsl:value-of select="ROTURAS_STOCKS/TOTAL"/>)</a>
			</li>
			<li>
				<a id="pes_Reclamaciones" class="MenuLic"><xsl:value-of select="document($doc)/translation/texts/item[@name='reclamaciones']/node()"/>&nbsp;<xsl:value-of select="PLAZO_CONSULTAS"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='dias']/node()"/>
					(<xsl:value-of select="INCIDENCIASPEDIDOS/TOTAL"/>)</a>
			</li>
		</ul>
	</div>

  <!--condiciones particulares-->
  <div class="divLeft tablas70" id="pestanaCondicParticDiv" style="margin-top:30px;">

		<!--<table class="infoTable" border="0">-->
		<table class="buscador">
		<form name="CondProveedor" id="formCondProveedor" method="post" action="http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPInfoCom.xsql">
		<input type="hidden" name="IDPROV" value="{/InfoCom/EMPRESA/EMP_ID}" id="IDPROV"/>
		<!--
		<thead>
			<tr class="subTituloTabla">
				<th colspan="7"><xsl:value-of select="document($doc)/translation/texts/item[@name='condiciones_particulares']/node()"/></th>
			</tr>
		</thead>
		-->
		<tbody>
		<tr class="sinLinea">
			<td class="uno">&nbsp;</td>
			<td class="veinte labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='codigo']/node()"/>:&nbsp;</td>
			<td class="datosLeft" colspan="3">
				<xsl:choose>
				<xsl:when test="/InfoCom/EMPRESA/EDITAR_INFO_COMERCIAL">
					<input type="text" class="peq" name="COP_CODIGO" id="COP_CODIGO" value="{/InfoCom/EMPRESA/CONDICIONES/COP_CODIGO}"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="/InfoCom/EMPRESA/CONDICIONES/COP_CODIGO"/>
				</xsl:otherwise>
				</xsl:choose>
			</td>
			<td>&nbsp;</td>
		</tr>
    	  <tr class="sinLinea">
			<td>&nbsp;</td>
			<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='informacion_privada']/node()"/>:&nbsp;</td>
			<td class="datosLeft" colspan="3">
				<xsl:choose>
				<xsl:when test="/InfoCom/EMPRESA/EDITAR_INFO_COMERCIAL">
					<textarea name="COP_INFORMACIONPRIVADA" cols="80" rows="4">
						<xsl:value-of select="/InfoCom/EMPRESA/CONDICIONES/COP_INFORMACIONPRIVADA"/>
					</textarea>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="/InfoCom/EMPRESA/CONDICIONES/COP_INFORMACIONPRIVADA"/><br />
				</xsl:otherwise>
				</xsl:choose>
        	  <br />
        	  <xsl:value-of select="document($doc)/translation/texts/item[@name='observaciones_pedido_expli']/node()"/>
			</td>
			<td>&nbsp;</td>
    	  </tr>
		<tr class="sinLinea">
			<td class="dos">&nbsp;</td>
			<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='forma_pago']/node()"/>:&nbsp;</td>
			<td class="datosLeft">
			<xsl:choose>
			<xsl:when test="/InfoCom/EMPRESA/EDITAR_INFO_COMERCIAL">
				<xsl:call-template name="desplegable">
				<xsl:with-param name="path" select="/InfoCom/EMPRESA/FORMASPAGO/field"/>
				</xsl:call-template>
			<!--<input type="text" name="FORMA_PAGO" value="{/InfoCom/EMPRESA/CONDICIONES/COP_FORMADEPAGO}" size="40"/>-->
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="/InfoCom/EMPRESA/COP_FORMADEPAGO"/>
			</xsl:otherwise>
			</xsl:choose>
        	<!--</td>
        	<td class="labelRight dies">-->
				&nbsp;&nbsp;&nbsp;
			<label><xsl:value-of select="document($doc)/translation/texts/item[@name='plazo_de_pago']/node()"/>:&nbsp;</label>
			<!--</td>
			<td class="datosLeft">-->
			<xsl:choose>
			<xsl:when test="/InfoCom/EMPRESA/EDITAR_INFO_COMERCIAL">
			<xsl:call-template name="desplegable">
				<xsl:with-param name="path" select="/InfoCom/EMPRESA/PLAZOSPAGO/field"/>
			</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="/InfoCom/EMPRESA/COP_FORMADEPAGO"/>
			</xsl:otherwise>
			</xsl:choose>
        	</td>
			<td>&nbsp;</td>
		</tr>
		<xsl:choose>
		<xsl:when test="/InfoCom/EMPRESA/EMP_IDPAIS=55">
			<tr class="sinLinea">
				<td class="dos">&nbsp;</td>
				<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='Nombre_banco']/node()"/>:&nbsp;</td>
				<td class="datosLeft" colspan="4">
				<xsl:choose>
				<xsl:when test="/InfoCom/EMPRESA/EDITAR_INFO_COMERCIAL">
						<input type="text" name="COP_NOMBREBANCO" id="COP_NOMBREBANCO" size="20" value="{/InfoCom/EMPRESA/CONDICIONES/COP_NOMBREBANCO}"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="/InfoCom/EMPRESA/CONDICIONES/COP_NOMBREBANCO"/>
				</xsl:otherwise>
				</xsl:choose>
        		<!--</td>
				<td class="datosLeft quince">-->
				&nbsp;&nbsp;&nbsp;
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='cod_banco']/node()"/>:&nbsp;</label>
				<xsl:choose>
				<xsl:when test="/InfoCom/EMPRESA/EDITAR_INFO_COMERCIAL">
						<input type="text" class="peq" name="COP_CODBANCO" id="COP_CODBANCO" size="6" value="{/InfoCom/EMPRESA/CONDICIONES/COP_CODBANCO}"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="/InfoCom/EMPRESA/CONDICIONES/COP_CODBANCO"/>
				</xsl:otherwise>
				</xsl:choose>
        		<!--</td>
				<td class="datosLeft quince">-->
				&nbsp;&nbsp;&nbsp;
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='cod_oficina']/node()"/>:&nbsp;</label>
				<xsl:choose>
				<xsl:when test="/InfoCom/EMPRESA/EDITAR_INFO_COMERCIAL">
						<input type="text" class="peq" name="COP_CODOFICINA" id="COP_CODOFICINA" size="6" value="{/InfoCom/EMPRESA/CONDICIONES/COP_CODOFICINA}"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="/InfoCom/EMPRESA/CONDICIONES/COP_CODOFICINA"/>
				</xsl:otherwise>
				</xsl:choose>
        		<!--</td>
				<td class="datosLeft quince">-->
				&nbsp;&nbsp;&nbsp;
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='cod_cuenta']/node()"/>:&nbsp;</label>
				<xsl:choose>
				<xsl:when test="/InfoCom/EMPRESA/EDITAR_INFO_COMERCIAL">
					<input type="text" class="grande" name="COP_CODCUENTA" id="COP_CODCUENTA" size="15" value="{/InfoCom/EMPRESA/CONDICIONES/COP_CODCUENTA}"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="/InfoCom/EMPRESA/CONDICIONES/COP_CODCUENTA"/>
				</xsl:otherwise>
				</xsl:choose>
        		</td>
				<td>&nbsp;</td>
			</tr>
		</xsl:when>
		<xsl:otherwise>
			<input type="hidden" name="COP_NOMBREBANCO" id="COP_NOMBREBANCO" value="{/InfoCom/EMPRESA/CONDICIONES/COP_NOMBREBANCO}"/>
			<input type="hidden" name="COP_CODBANCO" id="COP_CODBANCO" value="{/InfoCom/EMPRESA/CONDICIONES/COP_CODBANCO}"/>
			<input type="hidden" name="COP_CODOFICINA" id="COP_CODOFICINA" value="{/InfoCom/EMPRESA/CONDICIONES/COP_CODOFICINA}"/>
			<input type="hidden" name="COP_CODCUENTA" id="COP_CODCUENTA" value="{/InfoCom/EMPRESA/CONDICIONES/COP_CODCUENTA}"/>
		</xsl:otherwise>
		</xsl:choose>

		<tr class="sinLinea">
			<td>&nbsp;</td>
			<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='gestion_caducidades']/node()"/>:&nbsp;</td>
			<td class="datosLeft" colspan="3">
				<xsl:choose>
				<xsl:when test="/InfoCom/EMPRESA/EDITAR_INFO_COMERCIAL">
					<textarea name="GESTION_CADUCIDAD" cols="80" rows="4">
						<xsl:value-of select="/InfoCom/EMPRESA/CONDICIONES/COP_GESTIONCADUCIDADES"/>
					</textarea>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="/InfoCom/EMPRESA/CONDICIONES/COP_GESTIONCADUCIDADES"/>
				</xsl:otherwise>
				</xsl:choose>
			</td>
			<td>&nbsp;</td>
      </tr>

	<tr class="sinLinea">
		<td>&nbsp;</td>
		<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='otras_licitaciones']/node()"/>:&nbsp;</td>
		<td class="datosLeft" colspan="3">
			<xsl:choose>
			<xsl:when test="/InfoCom/EMPRESA/EDITAR_INFO_COMERCIAL">
				<textarea name="OTRAS_LICITACIONES" cols="80" rows="4">
					<xsl:value-of select="/InfoCom/EMPRESA/CONDICIONES/COP_OTRASLICITACIONES"/>
				</textarea>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="/InfoCom/EMPRESA/CONDICIONES/COP_OTRASLICITACIONES"/>
			</xsl:otherwise>
			</xsl:choose>
		</td>
		<td>&nbsp;</td>
      </tr>

      <tr class="sinLinea">
		<td>&nbsp;</td>
		<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='observaciones_pedidos']/node()"/>:&nbsp;</td>
		<td class="datosLeft" colspan="3">
			<xsl:choose>
			<xsl:when test="/InfoCom/EMPRESA/EDITAR_INFO_COMERCIAL">
				<textarea name="OBSERVACIONES" cols="80" rows="4">
					<xsl:value-of select="/InfoCom/EMPRESA/CONDICIONES/COP_OBSERVACIONESPEDIDOS"/>
				</textarea>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="/InfoCom/EMPRESA/CONDICIONES/COP_OBSERVACIONESPEDIDOS"/><br />
			</xsl:otherwise>
			</xsl:choose>
          <br />
          <xsl:value-of select="document($doc)/translation/texts/item[@name='observaciones_pedido_expli']/node()"/>
		</td>
		<td>&nbsp;</td>
      </tr>

		<xsl:if test="/InfoCom/EMPRESA/EDITAR_INFO_COMERCIAL">
			<tr  class="sinLinea" style="display:none;" id="SAVE_MSG">
				<td colspan="2">&nbsp;</td>
				<td colspan="2" id="SAVE_MSG_CELL" class="fondoVerde" style="text-align:left;font-weight:bold;">&nbsp;</td>
				<td colspan="2">&nbsp;</td>
			</tr>

			<tr class="sinLinea">
				<td colspan="2">&nbsp;</td>
				<td>
					<xsl:if test="not(/InfoCom/EMPRESA/OBSERVADOR)">
            		<!--div class="boton">-->
						<a class="btnDestacado" href="javascript:CondProveedorSend(document.forms['CondProveedor']);">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='guardar']/node()"/>
						</a>
            		<!--</div>-->
        			</xsl:if>
				</td>
				<td colspan="3">&nbsp;</td>
			</tr>
		</xsl:if>
		</tbody>
    </form>
		</table>
  </div><!--fin de divLeft-->

  <!--licitaciones info comm-->
  <div class="divLeft tablas70" id="pestanaLicitacionesDiv" style="margin-top:30px;display:none;">
    <xsl:choose>
    <xsl:when test="/InfoCom/EMPRESA/CONDICIONES/LICITACIONES/LICITACION">
			<!--<table class="infoTable" border="0">-->
			<table class="buscador">
			<thead>
				<tr class="subTituloTabla">
					<th class="dies">&nbsp;</th>
					<th align="left"><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_alta']/node()"/></th>
					<th align="left"><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_decision']/node()"/></th>
					<th style="text-align:left;"><xsl:value-of select="document($doc)/translation/texts/item[@name='nombre']/node()"/></th>
					<th><xsl:value-of select="document($doc)/translation/texts/item[@name='estado']/node()"/></th>
					<th>
						<xsl:value-of select="document($doc)/translation/texts/item[@name='consumo']/node()"/>&nbsp;
						(<xsl:value-of select="/InfoCom/EMPRESA/DIVISA/SUFIJO"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='c_iva']/node()"/>)
					</th>
					<th style="text-align:left;"><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor_adjudicado']/node()"/></th>
				</tr>
	    </thead>

			<tbody>
			<xsl:for-each select="/InfoCom/EMPRESA/CONDICIONES/LICITACIONES/LICITACION">
				<tr class="lineGris">
					<td class="dos">&nbsp;</td>
					<td class="textLeft ocho"><xsl:value-of select="LIC_FECHAALTA"/></td>
					<td class="textLeft ocho"><xsl:value-of select="LIC_FECHADECISIONPREVISTA"/></td>
					<td class="veinte" style="text-align:left;"><xsl:value-of select="LIC_TITULO"/></td>
					<td><xsl:value-of select="ESTADO"/></td>
					<td><xsl:value-of select="LIC_CONSUMOIVA"/></td>
					<td style="text-align:left;"><xsl:value-of select="PROVEEDORSELECCIONADO"/></td>
				</tr>
			</xsl:for-each>
			</tbody>
			</table>
    </xsl:when>
    <xsl:otherwise>
		<!--<table class="infoTable" border="0">-->
		<table class="buscador">
		<thead>
			<tr class="subTituloTabla">
			<th><xsl:value-of select="document($doc)/translation/texts/item[@name='licitaciones_sin_resultados']/node()"/></th>
			</tr>
		</thead>
		</table>
    </xsl:otherwise>
    </xsl:choose>
  </div><!--fin de divLeft-->

  <!--evaluaciones info comm-->
  <div class="divLeft tablas70" id="pestanaEvaluacionesDiv" style="margin-top:30px;display:none;">
    <xsl:choose>
    <xsl:when test="/InfoCom/EMPRESA/EVALUACIONESPRODUCTOS/EVALUACION">
			<!--<table class="infoTable" border="0">-->
			<table class="buscador">
			<thead>
				<tr class="subTituloTabla">
					<td class="cinco">&nbsp;</td>
					<th><xsl:value-of select="document($doc)/translation/texts/item[@name='pos']/node()"/>.</th>
					<th class="dos"><xsl:value-of select="document($doc)/translation/texts/item[@name='cod_abbr']/node()"/></th>
					<th><xsl:copy-of select="document($doc)/translation/texts/item[@name='fecha']/node()"/></th>
					<!--<th align="left"><xsl:value-of select="document($doc)/translation/texts/item[@name='cliente']/node()"/></th>-->
					<th align="left" class="quince"><xsl:value-of select="document($doc)/translation/texts/item[@name='centro_de_cliente']/node()"/></th>
					<th align="left"><xsl:value-of select="document($doc)/translation/texts/item[@name='respon']/node()"/></th>
					<th align="left">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='ref_cliente']/node()"/></th>
					<th align="left">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='ref_prov']/node()"/></th>
					<th align="left">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/></th>
					<th align="left"><xsl:value-of select="document($doc)/translation/texts/item[@name='coordinador']/node()"/></th>
					<!--<th align="left"><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/></th>-->
					<th align="left">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='usuario_prov']/node()"/></th>
					<th><xsl:value-of select="document($doc)/translation/texts/item[@name='estado']/node()"/></th>
					<th><xsl:value-of select="document($doc)/translation/texts/item[@name='diagn']/node()"/></th>
					<th>&nbsp;</th>
				</tr>
	    </thead>

			<tbody>
			<xsl:for-each select="/InfoCom/EMPRESA/EVALUACIONESPRODUCTOS/EVALUACION">
				<tr class="lineGris">
					<td>&nbsp;</td>
	        <td><xsl:value-of select="position()"/></td>
					<td><a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Gestion/Comercial/EvaluacionProducto.xsql?ID_EVAL={PROD_EV_ID}','evaluacion',100,80,0,-10)">
	          	<xsl:value-of select="PROD_EV_CODIGO"/>
	          </a>
	        </td>
					<td><xsl:value-of select="PROD_EV_FECHA"/></td>
					<!--<td style="text-align:left;">
						<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPDetalleFrame.xsql?EMP_ID={IDCLIENTE}&amp;VENTANA=NUEVA','DetalleEmpresa',100,80,0,0)">
							<xsl:value-of select="CLIENTE"/>
						</a>&nbsp;
					</td>-->
					<td style="text-align:left;">
						<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/CENDetalle.xsql?ID={IDCENTROEVALUACION}','DetalleCentro',100,80,0,0)">
							<xsl:value-of select="CENTROEVALUACION"/>
	          </a>
					</td>
	        <td style="text-align:left;"><xsl:value-of select="AUTOR"/></td>
	        <td style="text-align:left;">&nbsp;
						<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Gestion/Comercial/EvaluacionProducto.xsql?ID_EVAL={PROD_EV_ID}','evaluacion',100,80,0,-10)">
							<xsl:value-of select="REFERENCIA"/></a>
					</td>
	        <td style="text-align:left;">
						<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Gestion/Comercial/EvaluacionProducto.xsql?ID_EVAL={PROD_EV_ID}','evaluacion',100,80,0,-10)">
							<xsl:value-of select="PROD_EV_REFPROVEEDOR"/>&nbsp;
						</a>
					</td>
					<td style="text-align:left;">
						<strong><a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Gestion/Comercial/EvaluacionProducto.xsql?ID_EVAL={PROD_EV_ID}','evaluacion',100,80,0,-10)">
								<xsl:value-of select="PROD_EV_NOMBRE"/>
						</a></strong>
					</td>
	        <td style="text-align:left;">
						<xsl:value-of select="COORDINADOR"/>
					</td>
					<!--<td style="text-align:left;">
						<xsl:value-of select="PROVEEDOR"/>
					</td>-->
	        <td style="text-align:left;">&nbsp;<xsl:value-of select="USUARIOMUESTRAS"/></td>
					<td><xsl:value-of select="ESTADO"/></td>
	        <td>
	          &nbsp;
	          <xsl:choose>
	          <xsl:when test="PROD_EV_DIAGNOSTICO = 'Apto'"><span class="verde"><xsl:value-of select="PROD_EV_DIAGNOSTICO" /></span></xsl:when>
	          <xsl:otherwise><span class="rojo"><xsl:value-of select="PROD_EV_DIAGNOSTICO" /></span></xsl:otherwise>
	          </xsl:choose>
          </td>
					<td>&nbsp;</td>
				</tr>
			</xsl:for-each>
			</tbody>
			</table>
    </xsl:when>
    <xsl:otherwise>
      <!--<table class="infoTable" border="0">-->
      <table class="buscador" border="0">
		<thead>
			<tr class="subTituloTabla">
		<th><xsl:value-of select="document($doc)/translation/texts/item[@name='evaluaciones_sin_resultados']/node()"/></th>
		</tr>
		</thead>
      </table>
    </xsl:otherwise>
    </xsl:choose>
  </div><!--fin de divLeft-->

  <!--incidencias info comm-->
  <div class="divLeft tablas70" id="pestanaIncidenciasDiv" style="margin-top:30px;display:none;">
    <xsl:choose>
    <xsl:when test="/InfoCom/EMPRESA/INCIDENCIASPRODUCTOS/INCIDENCIA">
		<!--<table class="infoTable" border="0">-->
		<table class="buscador">
			<thead>
				<tr class="subTituloTabla">
					<th class="cinco">&nbsp;</th>
					<th align="left"><xsl:value-of select="document($doc)/translation/texts/item[@name='pos']/node()"/>.</th>
					<th class="dos"><xsl:value-of select="document($doc)/translation/texts/item[@name='cod_abbr']/node()"/></th>
					<th><xsl:copy-of select="document($doc)/translation/texts/item[@name='fecha_comunicacion_2line']/node()"/></th>
					<th><xsl:copy-of select="document($doc)/translation/texts/item[@name='ultimo_cambio']/node()"/></th>
					<!--<th align="left"><xsl:value-of select="document($doc)/translation/texts/item[@name='cliente']/node()"/></th>-->
					<th align="left"><xsl:value-of select="document($doc)/translation/texts/item[@name='centro_de_cliente']/node()"/></th>
					<th align="left">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='ref_cliente']/node()"/></th>
					<th align="left">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/></th>
					<th align="left"><xsl:value-of select="document($doc)/translation/texts/item[@name='responsable']/node()"/></th>
					<!--<th align="left"><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/></th>-->
					<th><xsl:value-of select="document($doc)/translation/texts/item[@name='estado']/node()"/></th>
					<th>&nbsp;</th>
				</tr>
	    </thead>

			<tbody>
			<xsl:for-each select="/InfoCom/EMPRESA/INCIDENCIASPRODUCTOS/INCIDENCIA">
				<tr class="lineGris">
					<td class="dos">&nbsp;</td>
					<td><xsl:value-of select="position()"/></td>
					<td>
	          <a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Productos/Incidencia.xsql?ID_INC={PROD_INC_ID}&amp;PRO_ID={PROD_INC_IDPRODUCTO}&amp;LIC_OFE_ID={PROD_INC_IDOFERTA_LIC}','incidencia',100,80,0,-10)">
	            <xsl:value-of select="PROD_INC_CODIGO"/>
	          </a>
	        </td>
					<td><xsl:value-of select="PROD_INC_FECHA"/></td>
	        <td><xsl:value-of select="FECHA_ULTIMO_CAMBIO"/></td>
	        <!--<td style="text-align:left;">
						<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPDetalleFrame.xsql?EMP_ID={IDCLIENTE}&amp;VENTANA=NUEVA','DetalleEmpresa',100,80,0,0)">
							<xsl:value-of select="CLIENTE"/>
						</a>
					</td>-->
					<td style="text-align:left;">
						<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/CENDetalle.xsql?ID={IDCENTROCLIENTE}','DetalleCentro',100,80,0,0)">
							<xsl:value-of select="CENTROCLIENTE"/>
	          </a>
					</td>
					<td style="text-align:left;">&nbsp;
						<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Productos/Incidencia.xsql?ID_INC={PROD_INC_ID}&amp;PRO_ID={PROD_INC_IDPRODUCTO}&amp;LIC_OFE_ID={PROD_INC_IDOFERTA_LIC}','incidencia',100,80,0,-10)">
							<xsl:value-of select="REFERENCIA"/>
						</a>
					</td>
					<td style="text-align:left;">&nbsp;
						<strong>
	            <a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Productos/Incidencia.xsql?ID_INC={PROD_INC_ID}&amp;PRO_ID={PROD_INC_IDPRODUCTO}&amp;LIC_OFE_ID={PROD_INC_IDOFERTA_LIC}','incidencia',100,80,0,-10)">
								<xsl:value-of select="PROD_INC_DESCESTANDAR"/>
	            </a>
	          </strong>
					</td>
					<td style="text-align:left;"><xsl:value-of select="USUARIO"/></td>
					<!--<td style="text-align:left;">
						<xsl:value-of select="PROVEEDOR"/>
					</td>-->
					<td><xsl:value-of select="ESTADO"/></td>
				</tr>
			</xsl:for-each>
			</tbody>
			</table>
    </xsl:when>
    <xsl:otherwise>
      <!--<table class="infoTable" border="0">-->
      <table class="buscador" border="0">
		<thead>
			<tr class="subTituloTabla">
		<th><xsl:value-of select="document($doc)/translation/texts/item[@name='incidecias_sin_resultados']/node()"/></th>
		</tr>
      	</thead>
      </table>
    </xsl:otherwise>
    </xsl:choose>
  </div><!--fin de divLeft-->

  <!--roturas de stock info comm-->
  <div class="divLeft tablas70" id="pestanaRoturasDiv" style="margin-top:30px;display:none;">
    <xsl:choose>
    <xsl:when test="/InfoCom/EMPRESA/ROTURAS_STOCKS/ROTURAS_STOCKS_HISTORICAS/ROTURA_STOCKS or /InfoCom/EMPRESA/ROTURAS_STOCKS/ROTURAS_STOCKS_ACTIVAS/ROTURA_STOCKS">
		<!--<table class="infoTable" border="0">-->
		<table class="buscador" border="0">
			<thead>
				<tr class="subTituloTabla">
					<th class="dos">&nbsp;</th>
					<th class="tres" align="left"><xsl:value-of select="document($doc)/translation/texts/item[@name='pos']/node()"/>.</th>
					<th class="cinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha']/node()"/>&nbsp;&nbsp;</th>
					<th class="veinte" align="left"><xsl:copy-of select="document($doc)/translation/texts/item[@name='producto']/node()"/></th>
					<th class="ocho" align="left"><xsl:copy-of select="document($doc)/translation/texts/item[@name='ref_proveedor']/node()"/></th>
					<th class="dies" align="left"><xsl:copy-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/></th>
					<th class="veinte" align="left"><xsl:copy-of select="document($doc)/translation/texts/item[@name='comentarios']/node()"/></th>
					<th class="veinte" align="left"><xsl:value-of select="document($doc)/translation/texts/item[@name='alternativa']/node()"/></th>
					<th class="cinco" align="left"><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha']/node()"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='final']/node()"/></th>
					<th class="cinco" align="left"><xsl:value-of select="document($doc)/translation/texts/item[@name='duracion']/node()"/></th>
					<th>&nbsp;</th>
				</tr>
	    </thead>

			<tbody>
	    <xsl:for-each select="/InfoCom/EMPRESA/ROTURAS_STOCKS/ROTURAS_STOCKS_ACTIVAS/ROTURA_STOCKS">
				<tr class="lineGris amarillo">
					<td>&nbsp;</td>
					<td style="text-align:left;"><xsl:value-of select="POS"/></td>
	        <td style="text-align:left;"><xsl:value-of select="FECHA" />&nbsp;&nbsp;</td>
	        <td style="text-align:left;"><xsl:value-of select="PRODUCTO" /></td>
	        <td style="text-align:left;"><xsl:value-of select="REFPROVEEDOR" /></td>
	        <td style="text-align:left;"><xsl:value-of select="PROVEEDOR" /></td>
	        <td style="text-align:left;"><xsl:value-of select="COMENTARIOS" /></td>
	        <td style="text-align:left;"><xsl:value-of select="ALTERNATIVA" /></td>
	        <td style="text-align:left;"><xsl:value-of select="document($doc)/translation/texts/item[@name='pendiente']/node()"/></td>
	        <td style="text-align:left;">&nbsp;</td>
	        <td>&nbsp;</td>
				</tr>
			</xsl:for-each>

			<xsl:for-each select="/InfoCom/EMPRESA/ROTURAS_STOCKS/ROTURAS_STOCKS_HISTORICAS/ROTURA_STOCKS">
				<tr class="lineGris">
					<td>&nbsp;</td>
					<td style="text-align:left;"><xsl:value-of select="POS"/></td>
	        <td style="text-align:left;"><xsl:value-of select="FECHA" />&nbsp;&nbsp;</td>
	        <td style="text-align:left;"><xsl:value-of select="PRODUCTO" /></td>
	        <td style="text-align:left;"><xsl:value-of select="REFPROVEEDOR" /></td>
	        <td style="text-align:left;"><xsl:value-of select="PROVEEDOR" /></td>
	        <td style="text-align:left;"><xsl:value-of select="COMENTARIOS" /></td>
	        <td style="text-align:left;"><xsl:value-of select="ALTERNATIVA" /></td>
	        <td style="text-align:left;"><xsl:value-of select="FECHAFINAL" /></td>
	        <td style="text-align:center;"><xsl:value-of select="DURACION" /></td>
	        <td>&nbsp;</td>
				</tr>
			</xsl:for-each>
			</tbody>
			</table>
    </xsl:when>
    <xsl:otherwise>
      <!--<table class="infoTable" border="0">-->
      <table class="buscador">
			<thead>
			<tr class="subTituloTabla">
				<th><xsl:value-of select="document($doc)/translation/texts/item[@name='roturas_sin_resultados']/node()"/></th>
	        </tr>
      	</thead>
      </table>
    </xsl:otherwise>
    </xsl:choose>
  </div><!--fin de divLeft-->

  <!--reclamaciones info comm-->
  <div class="divLeft tablas70" id="pestanaReclamacionesDiv" style="margin-top:30px;display:none;">
    <xsl:choose>
    <xsl:when test="/InfoCom/EMPRESA/INCIDENCIASPEDIDOS/INCIDENCIA">
		<!--<table class="infoTable" border="0">-->
		<table class="buscador" border="0">
			<thead>
				<tr class="subTituloTabla">
					<th class="dos">&nbsp;</th>
					<th class="tres" align="left"><xsl:value-of select="document($doc)/translation/texts/item[@name='pos']/node()"/>.</th>
					<th class="cinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha']/node()"/>&nbsp;&nbsp;</th>
					<th class="veinte" align="left"><xsl:copy-of select="document($doc)/translation/texts/item[@name='pedido']/node()"/></th>
					<th class="veinte" align="left"><xsl:copy-of select="document($doc)/translation/texts/item[@name='cliente']/node()"/></th>
					<th class="veinte" align="left"><xsl:copy-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/></th>
					<th class="ocho" align="left"><xsl:copy-of select="document($doc)/translation/texts/item[@name='fecha_reclamacion']/node()"/></th>
					<th class="dies" align="left"><xsl:copy-of select="document($doc)/translation/texts/item[@name='reclamacion']/node()"/></th>
					<th>&nbsp;</th>
				</tr>
	    </thead>

			<tbody>
	   			<xsl:for-each select="/InfoCom/EMPRESA/INCIDENCIASPEDIDOS/INCIDENCIA">
				<tr class="lineGris amarillo">
					<xsl:attribute name="class">
					<xsl:choose>
   						<xsl:when test="MO_STATUS=11 or MO_STATUS=13 or MO_STATUS=25">
						lineGris amarillo
    					</xsl:when>
    					<xsl:otherwise>
						lineGris
					</xsl:otherwise>
					</xsl:choose>
					</xsl:attribute>
					<td>&nbsp;</td>
					<td style="text-align:left;"><xsl:value-of select="POS"/></td>
	        		<td style="text-align:left;"><xsl:value-of select="MO_FECHA"/></td>
	        		<td style="text-align:left;"><xsl:value-of select="MO_NUMERO"/></td>
	        		<td style="text-align:left;"><xsl:value-of select="CENTROCLIENTE"/></td>
	        		<td style="text-align:left;"><xsl:value-of select="PROVEEDOR"/></td>
	        		<td style="text-align:left;"><xsl:value-of select="PCM_FECHA"/></td>
	        		<td style="text-align:left;"><xsl:value-of select="PCM_COMENTARIOS"/></td>
	        		<td style="text-align:left;">&nbsp;</td>
	        		<td>&nbsp;</td>
					</tr>
				</xsl:for-each>
			</tbody>
			</table>
    </xsl:when>
    <xsl:otherwise>
      <!--<table class="infoTable" border="0">-->
      <table class="buscador">
			<thead>
			<tr class="subTituloTabla">
				<th><xsl:value-of select="document($doc)/translation/texts/item[@name='incidecias_sin_resultados']/node()"/></th>
	        </tr>
      	</thead>
      </table>
    </xsl:otherwise>
    </xsl:choose>
  </div><!--fin de divLeft-->


</xsl:template><!--find de cond comercial prove-->

<xsl:template name="condComercialCliente">
  <!--idioma-->
	<xsl:variable name="lang">
		<xsl:choose>
		<xsl:when test="/InfoCom/LANG"><xsl:value-of select="/InfoCom/LANG"/></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
  <!--idioma fin-->

  <!-- Tabla resumen empresa (siempre visible para ficha de clientes) -->
	<xsl:if test="/InfoCom/EMPRESA/MVM or /InfoCom/EMPRESA/MVMB">
	<div class="divLeft">
		<!--<table class="grandeInicio">-->
		<table class="buscador">
		<thead>
			<tr class="subTituloTabla">
				<th class="textLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='resumen']/node()"/></th>
				<xsl:for-each select="/InfoCom/EMPRESA/RESUMENES_MENSUALES/CABECERA/COLUMNA">
					<th><xsl:value-of select="MES"/>/<xsl:value-of select="ANYO"/></th>
				</xsl:for-each>
			</tr>
		</thead>

		<tbody>
		<xsl:for-each select="/InfoCom/EMPRESA/RESUMENES_MENSUALES/RESUMEN_MENSUAL">
			<tr>
				<td class="indicador textLeft"><xsl:value-of select="@Nombre"/></td>
				<xsl:for-each select="COLUMNA">
					<td><xsl:value-of select="VALOR"/></td>
				</xsl:for-each>
      </tr>
		</xsl:for-each>
		</tbody>
		</table>
	</div>
	</xsl:if>
</xsl:template>

<!--PEDIDO MINIMO PARA PROVEE-->
<xsl:template name="pedidoMinimo">
  <!--idioma-->
	<xsl:variable name="lang">
		<xsl:choose>
		<xsl:when test="/InfoCom/LANG"><xsl:value-of select="/InfoCom/LANG"/></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<xsl:choose><!--si no hay pedidos minimos por centros ense?o en 4 lineas el pedido minimo general, si no ense?o todo como tabla-->
	<xsl:when test="(/InfoCom/EMPRESA/CONDICIONES/PEDIDOMINIMO/EMPRESA  or /InfoCom/EMPRESA/CONDICIONES/PEDIDO_MINIMO_GENERAL/EMP_PEDMINIMO_ACTIVO != '') and /InfoCom/EMPRESA/ROL = 'VENDEDOR' and /InfoCom/EMPRESA/CONDICIONES/PEDIDOMINIMO/CENTROS/CENTRO">

	<!--<table class="infoTable"  style="border-right:1px solid #666;border-left:1px solid #666;">-->
	<table class="buscador"  style="border-right:1px solid #666;border-left:1px solid #666;">
	<thead>
      <tr class="subTituloTabla">
        <td colspan="4"><xsl:value-of select="document($doc)/translation/texts/item[@name='pedido_minimo']/node()"/></td>
			</tr>
			<tr class="subTituloTablaNoB">
				<td align="left"><xsl:value-of select="document($doc)/translation/texts/item[@name='centro']/node()"/></td>
				<td><xsl:value-of select="document($doc)/translation/texts/item[@name='tipo']/node()"/></td>
				<td><xsl:value-of select="document($doc)/translation/texts/item[@name='importe']/node()"/></td>
				<td><xsl:value-of select="document($doc)/translation/texts/item[@name='descripcion']/node()"/></td>
			</tr>
    </thead>

    <tbody>
		<xsl:for-each select="/InfoCom/EMPRESA/CONDICIONES/PEDIDOMINIMO/CENTROS/CENTRO">
			<tr>
				<td class="textLeft"><xsl:value-of select="NOMBRE"/></td>
				<td>
					<xsl:choose>
					<xsl:when test="PMC_PEDMINIMO_ACTIVO='N'">
						<b><xsl:value-of select="document($doc)/translation/texts/item[@name='no_activo']/node()"/></b>
					</xsl:when>
					<xsl:when test="PMC_PEDMINIMO_ACTIVO='S'">
						<b><xsl:value-of select="document($doc)/translation/texts/item[@name='activo']/node()"/></b>
					</xsl:when>
					<xsl:when test="PMC_PEDMINIMO_ACTIVO='E'">
						<b><xsl:value-of select="document($doc)/translation/texts/item[@name='estricto']/node()"/></b>
					</xsl:when>
					<xsl:when test="PMC_PEDMINIMO_ACTIVO='I'">
						<b><xsl:value-of select="document($doc)/translation/texts/item[@name='integrado']/node()"/></b>
					</xsl:when>
					</xsl:choose>
				</td>
				<td>
					<xsl:choose>
					<xsl:when test="PMC_PEDMINIMO_IMPORTE>0">
						<xsl:value-of select="PMC_PEDMINIMO_IMPORTE"/><xsl:value-of select="/InfoCom/EMPRESA/DIVISA/SUFIJO"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='s_iva']/node()"/>
					</xsl:when>
					<xsl:otherwise>
						&nbsp;-&nbsp;
					</xsl:otherwise>
					</xsl:choose>
				</td>
				<td>
					<xsl:copy-of select="PMC_PEDMINIMO_DETALLE"/>
				</td>
			</tr>
		</xsl:for-each>

			<tr style="border-bottom:1px solid #999999;">
				<td><xsl:value-of select="document($doc)/translation/texts/item[@name='resto_centros']/node()"/></td>
				<td>
				<xsl:choose>
				<xsl:when test="/InfoCom/EMPRESA/CONDICIONES/PEDIDOMINIMO/EMPRESA">
					<xsl:choose>
					<xsl:when test="/InfoCom/EMPRESA/CONDICIONES/PEDIDOMINIMO/EMPRESA/PME_PEDMINIMO_ACTIVO='N'">
						<b><xsl:value-of select="document($doc)/translation/texts/item[@name='no_activo']/node()"/></b>
					</xsl:when>
					<xsl:when test="/InfoCom/EMPRESA/CONDICIONES/PEDIDOMINIMO/EMPRESA/PME_PEDMINIMO_ACTIVO='S'">
						<b><xsl:value-of select="document($doc)/translation/texts/item[@name='activo']/node()"/></b>
					</xsl:when>
					<xsl:when test="/InfoCom/EMPRESA/CONDICIONES/PEDIDOMINIMO/EMPRESA/PME_PEDMINIMO_ACTIVO='E'">
						<b><xsl:value-of select="document($doc)/translation/texts/item[@name='estricto']/node()"/></b>
					</xsl:when>
					<xsl:when test="/InfoCom/EMPRESA/CONDICIONES/PEDIDOMINIMO/EMPRESA/PME_PEDMINIMO_ACTIVO='I'">
						<b><xsl:value-of select="document($doc)/translation/texts/item[@name='integrado']/node()"/></b>
					</xsl:when>
					</xsl:choose>
				</xsl:when>
				<xsl:when test="/InfoCom/EMPRESA/CONDICIONES/PEDIDO_MINIMO_GENERAL">
					<xsl:choose>
					<xsl:when test="/InfoCom/EMPRESA/CONDICIONES/PEDIDO_MINIMO_GENERAL/EMP_PEDMINIMO_ACTIVO='N'">
						<b><xsl:value-of select="document($doc)/translation/texts/item[@name='no_activo']/node()"/></b>
					</xsl:when>
					<xsl:when test="/InfoCom/EMPRESA/CONDICIONES/PEDIDO_MINIMO_GENERAL/EMP_PEDMINIMO_ACTIVO='S'">
						<b><xsl:value-of select="document($doc)/translation/texts/item[@name='activo']/node()"/></b>
					</xsl:when>
					<xsl:when test="/InfoCom/EMPRESA/CONDICIONES/PEDIDO_MINIMO_GENERAL/EMP_PEDMINIMO_ACTIVO='E'">
						<b><xsl:value-of select="document($doc)/translation/texts/item[@name='estricto']/node()"/></b>
					</xsl:when>
					<xsl:when test="/InfoCom/EMPRESA/CONDICIONES/PEDIDOMINIMO/EMPRESA/EMP_PEDMINIMO_ACTIVO='I'">
						<b><xsl:value-of select="document($doc)/translation/texts/item[@name='integrado']/node()"/></b>
					</xsl:when>
					</xsl:choose>
				</xsl:when>
				</xsl:choose>
				</td>
				<td>
				<xsl:choose>
				<xsl:when test="/InfoCom/EMPRESA/CONDICIONES/PEDIDOMINIMO/EMPRESA">
					<xsl:choose>
					<xsl:when test="PME_PEDMINIMO_IMPORTE>0">
						<xsl:value-of select="/InfoCom/EMPRESA/CONDICIONES/PEDIDOMINIMO/EMPRESA/PME_PEDMINIMO_IMPORTE"/><xsl:value-of select="/InfoCom/EMPRESA/DIVISA/SUFIJO"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='s_iva']/node()"/>
					</xsl:when>
					<xsl:otherwise>
						&nbsp;-&nbsp;
					</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:when test="/InfoCom/EMPRESA/CONDICIONES/PEDIDO_MINIMO_GENERAL">
					<xsl:choose>
					<xsl:when test="EMP_PEDMINIMO_IMPORTE>0">
						<xsl:value-of select="/InfoCom/EMPRESA/CONDICIONES/PEDIDO_MINIMO_GENERAL/EMP_PEDMINIMO_IMPORTE"/><xsl:value-of select="/InfoCom/EMPRESA/DIVISA/SUFIJO"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='s_iva']/node()"/>
					</xsl:when>
					<xsl:otherwise>
						&nbsp;-&nbsp;
					</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				</xsl:choose>
				</td>
				<td>
				<xsl:choose>
				<xsl:when test="/InfoCom/EMPRESA/CONDICIONES/PEDIDOMINIMO/EMPRESA">
					<xsl:copy-of select="/InfoCom/EMPRESA/CONDICIONES/PEDIDOMINIMO/EMPRESA/PME_PEDMINIMO_DETALLE"/>
				</xsl:when>
				<xsl:when test="/InfoCom/EMPRESA/CONDICIONES/PEDIDO_MINIMO_GENERAL">
					<xsl:copy-of select="/InfoCom/EMPRESA/CONDICIONES/PEDIDO_MINIMO_GENERAL/EMP_PEDMINIMO_DETALLE"/>
				</xsl:when>
				</xsl:choose>
				</td>
			</tr>
		</tbody>

      <tr><td colspan="2">&nbsp;</td></tr>
      <tr><td colspan="2">&nbsp;</td></tr>
		</table>
	</xsl:when>
  <xsl:otherwise>
    <!--<table class="infoTable"  style="border-right:1px solid #666;border-left:1px solid #666;">-->
    <table class="buscador"  style="border-right:1px solid #666;border-left:1px solid #666;">
    <thead>
      <tr class="subTituloTabla">
        <td colspan="2"><xsl:value-of select="document($doc)/translation/texts/item[@name='pedido_minimo']/node()"/></td>
      </tr>
    </thead>

    <tbody>
      <tr>
				<td class="labelRight cuarenta">
          			<xsl:value-of select="document($doc)/translation/texts/item[@name='importe']/node()"/>:
				</td>
        <td class="datosLeft">
					<b>
            <xsl:choose>
						<xsl:when test="/InfoCom/EMPRESA/CONDICIONES/PEDIDOMINIMO/EMPRESA">
							<xsl:choose>
							<xsl:when test="PME_PEDMINIMO_IMPORTE>0">
								<xsl:value-of select="/InfoCom/EMPRESA/CONDICIONES/PEDIDOMINIMO/EMPRESA/PME_PEDMINIMO_IMPORTE"/><xsl:value-of select="/InfoCom/EMPRESA/DIVISA/SUFIJO"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='s_iva']/node()"/>
							</xsl:when>
							<xsl:otherwise>
								&nbsp;-&nbsp;
							</xsl:otherwise>
							</xsl:choose>
						</xsl:when>
						<xsl:when test="/InfoCom/EMPRESA/CONDICIONES/PEDIDO_MINIMO_GENERAL">
							<xsl:choose>
							<xsl:when test="EMP_PEDMINIMO_IMPORTE>0">
								<xsl:value-of select="/InfoCom/EMPRESA/CONDICIONES/PEDIDO_MINIMO_GENERAL/EMP_PEDMINIMO_IMPORTE"/><xsl:value-of select="/InfoCom/EMPRESA/DIVISA/SUFIJO"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='s_iva']/node()"/>
							</xsl:when>
							<xsl:otherwise>
								&nbsp;-&nbsp;
							</xsl:otherwise>
							</xsl:choose>
						</xsl:when>
						</xsl:choose>
          </b>
				</td>
      </tr>

      <tr>
				<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='tipo']/node()"/>:</td>
                <td class="datosLeft">
				<xsl:choose>
				<xsl:when test="/InfoCom/EMPRESA/CONDICIONES/PEDIDOMINIMO/EMPRESA">
					<xsl:choose>
					<xsl:when test="/InfoCom/EMPRESA/CONDICIONES/PEDIDOMINIMO/EMPRESA/PME_PEDMINIMO_ACTIVO='N'">
						<b><xsl:value-of select="document($doc)/translation/texts/item[@name='no_activo']/node()"/></b>
					</xsl:when>
					<xsl:when test="/InfoCom/EMPRESA/CONDICIONES/PEDIDOMINIMO/EMPRESA/PME_PEDMINIMO_ACTIVO='S'">
						<b><xsl:value-of select="document($doc)/translation/texts/item[@name='activo']/node()"/></b>
					</xsl:when>
					<xsl:when test="/InfoCom/EMPRESA/CONDICIONES/PEDIDOMINIMO/EMPRESA/PME_PEDMINIMO_ACTIVO='E'">
						<b><xsl:value-of select="document($doc)/translation/texts/item[@name='estricto']/node()"/></b>
					</xsl:when>
					<xsl:when test="/InfoCom/EMPRESA/CONDICIONES/PEDIDOMINIMO/EMPRESA/PME_PEDMINIMO_ACTIVO='I'">
						<b><xsl:value-of select="document($doc)/translation/texts/item[@name='integrado']/node()"/></b>
					</xsl:when>
					</xsl:choose>
				</xsl:when>
				<xsl:when test="/InfoCom/EMPRESA/CONDICIONES/PEDIDO_MINIMO_GENERAL">
					<xsl:choose>
					<xsl:when test="/InfoCom/EMPRESA/CONDICIONES/PEDIDO_MINIMO_GENERAL/EMP_PEDMINIMO_ACTIVO='N'">
						<b><xsl:value-of select="document($doc)/translation/texts/item[@name='no_activo']/node()"/></b>
					</xsl:when>
					<xsl:when test="/InfoCom/EMPRESA/CONDICIONES/PEDIDO_MINIMO_GENERAL/EMP_PEDMINIMO_ACTIVO='S'">
						<b><xsl:value-of select="document($doc)/translation/texts/item[@name='activo']/node()"/></b>
					</xsl:when>
					<xsl:when test="/InfoCom/EMPRESA/CONDICIONES/PEDIDO_MINIMO_GENERAL/EMP_PEDMINIMO_ACTIVO='E'">
						<b><xsl:value-of select="document($doc)/translation/texts/item[@name='estricto']/node()"/></b>
					</xsl:when>
					<xsl:when test="/InfoCom/EMPRESA/CONDICIONES/PEDIDOMINIMO/EMPRESA/EMP_PEDMINIMO_ACTIVO='I'">
						<b><xsl:value-of select="document($doc)/translation/texts/item[@name='integrado']/node()"/></b>
					</xsl:when>
					</xsl:choose>
				</xsl:when>
				</xsl:choose>
				</td>
      </tr>

    <xsl:if test="/InfoCom/EMPRESA/CONDICIONES/PEDIDOMINIMO/EMPRESA/PME_PEDMINIMO_DETALLE != '' or /InfoCom/EMPRESA/CONDICIONES/PEDIDO_MINIMO_GENERAL/EMP_PEDMINIMO_DETALLE != ''">
      <tr>
		<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='descripcion']/node()"/>:</td>
        <td class="datosLeft">
					<xsl:choose>
					<xsl:when test="/InfoCom/EMPRESA/CONDICIONES/PEDIDOMINIMO/EMPRESA">
						<xsl:copy-of select="/InfoCom/EMPRESA/CONDICIONES/PEDIDOMINIMO/EMPRESA/PME_PEDMINIMO_DETALLE"/>
					</xsl:when>
					<xsl:when test="/InfoCom/EMPRESA/CONDICIONES/PEDIDO_MINIMO_GENERAL">
						<xsl:copy-of select="/InfoCom/EMPRESA/CONDICIONES/PEDIDO_MINIMO_GENERAL/EMP_PEDMINIMO_DETALLE"/>
					</xsl:when>
					</xsl:choose>
				</td>
			</tr>
    </xsl:if>
    </tbody>

      <tr><td colspan="2">&nbsp;</td></tr>
      <tr><td colspan="2">&nbsp;</td></tr>
    </table>
  </xsl:otherwise>
  </xsl:choose>
</xsl:template><!--fin de pedido minimo-->
</xsl:stylesheet>
