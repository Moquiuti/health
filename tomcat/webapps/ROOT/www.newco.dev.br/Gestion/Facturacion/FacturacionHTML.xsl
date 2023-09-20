<?xml version="1.0" encoding="iso-8859-1"?>
<!--
	Control y facturas a clientes MVM
	Ultima revisi�n: ET 20ene20 16:30 Facturacion_200120.js
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:import href="http://www.newco.dev.br/General/General.xsl"/>
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="usuario" select="@US_ID"/>
<xsl:template match="/Facturacion">

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

  <title><xsl:value-of select="document($doc)/translation/texts/item[@name='informe_facturacion_centros']/node()"/></title>

	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<link href="http://www.newco.dev.br/General/Tabla-popup.150715.css" rel="stylesheet" type="text/css"/>
	<!--fin de style-->

  	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery-1.8.3.min.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/Tabla-popup.150715.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/Gestion/Facturacion/Facturacion_200120.js"></script>
	<script type="text/javascript">

		var fechaInicio = '<xsl:value-of select="FACTURACION/FECHAINICIO"/>';
		var fechaFinal	= '<xsl:value-of select="FACTURACION/FECHAFINAL"/>';
		var mes			= '<xsl:value-of select="FACTURACION/MES"/>';
		var anno		= '<xsl:value-of select="FACTURACION/ANNO"/>';

		var str_codigoObli = '<xsl:value-of select="document($doc)/translation/texts/item[@name='factura_codigo_obli']/node()"/>';
		var str_importeObli = '<xsl:value-of select="document($doc)/translation/texts/item[@name='factura_importe_obli']/node()"/>';
		var str_importeSinFormato = '<xsl:value-of select="document($doc)/translation/texts/item[@name='factura_importe_sin_formato']/node()"/>';
		var str_nuevaFacturaOK = '<xsl:value-of select="document($doc)/translation/texts/item[@name='nueva_factura_ok']/node()"/>';
		var str_MesYAnnoObli = '<xsl:value-of select="document($doc)/translation/texts/item[@name='factura_excel_fecha_obli']/node()"/>';

		var alrt_sinSeleccionCheckboxes = '<xsl:value-of select="document($doc)/translation/texts/item[@name='facturacion_no_hay_seleccion_chk']/node()"/>';
		var alrt_countFacturasMarcadasEnviadas = '<xsl:value-of select="document($doc)/translation/texts/item[@name='facturacion_facturas_enviadas_count']/node()"/>';

	</script>
</head>
<body>
  <!--idioma-->
	<xsl:variable name="lang">
		<xsl:choose>
		<xsl:when test="LANG"><xsl:value-of select="LANG"/></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

  <xsl:choose>
	<!-- Error en alguna sentencia del XSQL -->
	<xsl:when test="AreaPublica/xsql-error">
		<xsl:apply-templates select="AreaPublica/xsql-error"/>
	</xsl:when>
	<xsl:otherwise>


	<!--	Titulo de la p�gina		-->
	<div class="ZonaTituloPagina">
		<p class="Path"><xsl:value-of select="document($doc)/translation/texts/item[@name='Inicio']/node()"/>&nbsp;/&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='pedidos']/node()"/>&nbsp;/&nbsp;<span class="FinPath"><xsl:value-of select="document($doc)/translation/texts/item[@name='informe_facturacion_centros']/node()"/></span></p>
		<p class="TituloPagina">
        	<xsl:value-of select="document($doc)/translation/texts/item[@name='informe_facturacion_centros']/node()"/>
			<span class="CompletarTitulo">
				<a class="btnNormal" href="javascript:DescargarExcel();"><img src="http://www.newco.dev.br/images/iconoExcel.gif" alt="Descargar Excel"/></a>
			</span>
		</p>
	</div>
	<br/>
	<br/>



	<form method="post" name="FormBuscador" action="Facturacion.xsql">
    <!--<div class="divLeft" style="border:1px solid #939494;border-top:0;">-->
    <div class="divLeft">
		<table class="grandeInicio" border="0">
			<!--<tr class="tituloTablaPeq">
				<th colspan="6" align="center">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='informe_facturacion_centros']/node()"/>
				</th>
			</tr>-->
			<tr>
				<!--<td bgcolor="#E3E2E2" colspan="6">-->
				<td colspan="6">
					<xsl:call-template name="buscador"/>
				</td>
			</tr>
		</table>
	</div>
	</form>

    <!--<div class="divLeft" style="border:1px solid #939494;border-top:0;">-->
    <div class="divLeft">
		  <!--<table class="grandeInicio" border="0">-->
		  <table class="buscador">
			<thead>
			  <tr class="subTituloTabla">
        		  <th class="zerouno">&nbsp;</th>
        		  <th class="siete" style="text-align:left;"><xsl:value-of select="document($doc)/translation/texts/item[@name='empresa']/node()"/></th>
        		  <th class="siete" style="text-align:left;"><xsl:value-of select="document($doc)/translation/texts/item[@name='centro']/node()"/></th>
        		  <th class="siete" style="text-align:left;"><xsl:value-of select="document($doc)/translation/texts/item[@name='modelo']/node()"/></th>
        		  <th class="cinco" style="text-align:left;"><xsl:value-of select="document($doc)/translation/texts/item[@name='forma_pago']/node()"/></th>
        		  <th class="cinco textRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='pedidos']/node()"/></th>
        		  <th class="cinco textRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='ahorro']/node()"/></th>
        		  <th class="seis"><xsl:copy-of select="document($doc)/translation/texts/item[@name='comision_sobre_ahorro_2lines']/node()"/></th>
        		  <th class="seis"><xsl:copy-of select="document($doc)/translation/texts/item[@name='comision_sobre_trans_2lines']/node()"/></th>
        		  <th class="cinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='comision']/node()"/></th>
        		  <th class="zerouno">&nbsp;</th>
        		  <th class="cinco textRight borderLeft" bgcolor="#8C8C8C"><xsl:value-of select="document($doc)/translation/texts/item[@name='importe']/node()"/></th>
        		  <th class="cinco textRight" bgcolor="#8C8C8C"><xsl:value-of select="document($doc)/translation/texts/item[@name='cod_abbr']/node()"/></th>
        		  <th class="seis" bgcolor="#8C8C8C"><xsl:copy-of select="document($doc)/translation/texts/item[@name='fecha_remesa_2ln']/node()"/></th>
        		  <th class="seis" bgcolor="#8C8C8C"><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_cobro']/node()"/></th>
        		  <th class="siete" bgcolor="#8C8C8C">&nbsp;</th>
        		  <th class="zerouno" bgcolor="#8C8C8C">&nbsp;</th>
			  </tr>
			</thead>

		<xsl:choose>
		<xsl:when test="FACTURACION/CENTRO">
			<tbody>
    		<xsl:for-each select="FACTURACION/CENTRO">
        <tr id="linea{LINEA}" class="body" style="border-bottom:1px solid #A7A8A9;height:30px;">
          <td>&nbsp;</td>
          <td class="textLeft ">
            <a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPDetalleFrame.xsql?EMP_ID={IDEMPRESA}','Ficha Empresa',100,80,0,-20);">
              <span class="NombreEmpresa"><xsl:value-of select="EMPRESA"/></span>
            </a>
          </td>
					<td class="textLeft">
            <a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/CENDetalle.xsql?ID={ID}','Ficha Centro',100,80,0,-20);">
              <span class="NombreCentro"><xsl:value-of select="NOMBRE"/></span>
            </a>
          </td>
          <td class="textLeft">
			<xsl:value-of select="MODELO"/>
			<xsl:if test="MODELO_EXPLIC != ''">
				<!--	ET 14dic16	El nuevo Tooltip funciona bien, quitamos el antiguo
					&nbsp;<a class="tooltip" href="#">
					<img src="http://www.newco.dev.br/images/info.gif" class="static"/>
					<span class="classic">
						<xsl:value-of select="MODELO_EXPLIC"/>
					</span>
				</a>-->
				&nbsp;<div class="tooltip">
						<img src="http://www.newco.dev.br/images/info.gif" class="static"/>
						<span class="tooltiptext">
							<xsl:value-of select="MODELO_EXPLIC"/>
						</span>
					</div>
			</xsl:if>
          </td>
          <td class="textLeft">
            <xsl:value-of select="FORMADEPAGO"/>
						<xsl:if test="FORMADEPAGO_EXPLIC != ''">
							&nbsp;<a class="tooltip" href="#">
								<img src="http://www.newco.dev.br/images/info.gif" class="static"/>
								<span class="classic">
									<xsl:value-of select="FORMADEPAGO_EXPLIC"/>
								</span>
							</a>
						</xsl:if>
          </td>
          <td class="textRight totalPedidos">
            <xsl:value-of select="TRANSACCIONES"/>
          </td>
          <td class="textRight totalAhorro">
            <xsl:value-of select="AHORRO"/>
          </td>
          <td class="textRight comisionAhorroPorc">
            <xsl:value-of select="COMISIONAHORRO_PORC"/>
          </td>
          <td class="textRight comisionPedidosPorc">
            <xsl:value-of select="COMISIONTRANSACCIONES_PORC"/>
          </td>
          <td class="textRight totalComision">
            <xsl:value-of select="COMISION"/>
          </td>
					<td>&nbsp;</td>
					<td class="textRight borderLeft importe">
						<xsl:value-of select="FACTURAS/FACTURA/IMPORTE"/>
					</td>
					<td class="textRight num_factura">
						<xsl:value-of select="FACTURAS/FACTURA/CODIGO"/>
						<xsl:if test="FACTURAS/FACTURA/COMENTARIOS != ''">
							&nbsp;<a class="tooltip" href="#">
								<img src="http://www.newco.dev.br/images/info.gif" class="static"/>
								<span class="classic comentario">
									<xsl:value-of select="FACTURAS/FACTURA/COMENTARIOS"/>
								</span>
							</a>
						</xsl:if>
					</td>
					<td class="textRight fecharemesa">
						<xsl:value-of select="FACTURAS/FACTURA/REMESA_FECHA"/>
					</td>
<!--
					<td class="textLeft descremesa">
						<xsl:value-of select="FACTURAS/FACTURA/REMESA"/>
					</td>
-->
					<td class="textRight">
						<xsl:choose>
						<xsl:when test="FACTURAS/FACTURA/FECHACOBROREAL != ''">
							<span class="fechacobroprevisto" style="display:none;"><xsl:value-of select="FACTURAS/FACTURA/FECHACOBROPREVISTO"/></span>
							<span class="fechacobroreal"><xsl:value-of select="FACTURAS/FACTURA/FECHACOBROREAL"/></span>
						</xsl:when>
						<xsl:when test="FACTURAS/FACTURA/FECHACOBROPREVISTO != ''">
							(<span class="fechacobroprevisto"><xsl:value-of select="FACTURAS/FACTURA/FECHACOBROPREVISTO"/></span>)
							<span class="fechacobroreal" style="display:none;"><xsl:value-of select="FACTURAS/FACTURA/FECHACOBROREAL"/></span>
						</xsl:when>
						<xsl:otherwise>
							<span class="fechacobroprevisto" style="display:none;"></span>
							<span class="fechacobroreal" style="display:none;"></span>
						</xsl:otherwise>
						</xsl:choose>
					</td>
          <td>
<!--
						<input type="hidden" class="textoFactura">
							<xsl:attribute name="value"><xsl:copy-of select="FACTURAS/FACTURA/TEXTOFACTURA/node()" disable-output-escaping="yes"/></xsl:attribute>
						</input>
-->
						<textarea class="textoFacturaIni" style="display:none;"><xsl:copy-of select="CEN_TEXTOFACTURAMVM/node()"/></textarea>
						<textarea class="textoFactura" style="display:none;"><xsl:copy-of select="FACTURAS/FACTURA/TEXTOFACTURA/node()"/></textarea>
						<textarea class="descremesa" style="display:none;"><xsl:copy-of select="FACTURAS/FACTURA/REMESA/node()"/></textarea>
						<input type="hidden" class="FacEnviada">
							<xsl:if test="FACTURAS/FACTURA/ENVIADA='S'"><xsl:attribute name="value">S</xsl:attribute></xsl:if>
						</input>
						<input type="hidden" class="fechaFactura" value="{FACTURAS/FACTURA/FECHA}"/>

						<xsl:variable name="flagRemesa">
							<xsl:choose>
							<xsl:when test="PAGA_POR_REMESA">true</xsl:when>
							<xsl:otherwise>false</xsl:otherwise>
							</xsl:choose>
						</xsl:variable>

						<a href="javascript:AnalisisListado({IDEMPRESA}, {ID});" style="text-decoration:none;">
									<img src="http://www.newco.dev.br/images/iconPedido.gif" width="14">
										<xsl:attribute name="alt"><xsl:value-of select="document($doc)/translation/texts/item[@name='listado_pedidos']/node()"/></xsl:attribute>
										<xsl:attribute name="title"><xsl:value-of select="document($doc)/translation/texts/item[@name='listado_pedidos']/node()"/></xsl:attribute>
									</img>
						</a>
						<xsl:choose>
						<xsl:when test="FACTURAS/SIN_FACTURAS">
							<a href="javascript:CrearFactura({LINEA}, {IDEMPRESA}, {ID}, {$flagRemesa});" style="text-decoration:none;">
								<img src="http://www.newco.dev.br/images/iconFormFactura.gif" width="14">
									<xsl:attribute name="alt"><xsl:value-of select="document($doc)/translation/texts/item[@name='nueva_factura']/node()"/></xsl:attribute>
									<xsl:attribute name="title"><xsl:value-of select="document($doc)/translation/texts/item[@name='nueva_factura']/node()"/></xsl:attribute>
								</img>
							</a>
						</xsl:when>
						<xsl:otherwise>
							<a href="javascript:EditarFactura({LINEA}, {FACTURAS/FACTURA/ID}, {IDEMPRESA}, {ID}, {$flagRemesa});" style="text-decoration:none;">
								<img src="http://www.newco.dev.br/images/iconFormFactura.gif" width="14">
									<xsl:attribute name="alt"><xsl:value-of select="document($doc)/translation/texts/item[@name='edita_factura']/node()"/></xsl:attribute>
									<xsl:attribute name="title"><xsl:value-of select="document($doc)/translation/texts/item[@name='edita_factura']/node()"/></xsl:attribute>
								</img>
							</a>
<!-- DC - 18ene16 - Ahora ya no quiere abrir la factura desde aqu�
							<a href="javascript:GenerarFactura({FACTURAS/FACTURA/ID});" style="text-decoration:none;">
										<img src="http://www.newco.dev.br/images/facturaBlanco.gif" width="14">
											<xsl:attribute name="alt"><xsl:value-of select="document($doc)/translation/texts/item[@name='generar_factura']/node()"/></xsl:attribute>
											<xsl:attribute name="title"><xsl:value-of select="document($doc)/translation/texts/item[@name='generar_factura']/node()"/></xsl:attribute>
										</img>
							</a>
-->
							<!-- checkbox para informar que las facturas han sido enviadas -->
							<input type="checkbox" class="chk_FactEnviada" value="{FACTURAS/FACTURA/ID}">
								<xsl:if test="FACTURAS/FACTURA/ENVIADA = 'S'"><xsl:attribute name="checked" value="checked"/></xsl:if>
							</input>
						</xsl:otherwise>
						</xsl:choose>
					</td>
					<td>&nbsp;</td>
        </tr>
        </xsl:for-each>
			</tbody>

			<tfoot>
				<tr>
					<td colspan="11">&nbsp;</td>
					<td colspan="6" class="borderLeft">&nbsp;</td>
				</tr>
				<tr>
					<td class="textRight" style="padding-right:20px;" colspan="5"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='totales']/node()"/>:</strong></td>
					<td class="textRight"><strong><xsl:value-of select="FACTURACION/TOTALES/TOTAL_TRANSACCIONES"/></strong></td>
					<td class="textRight"><strong><xsl:value-of select="FACTURACION/TOTALES/TOTAL_AHORRO"/></strong></td>
					<td colspan="2">&nbsp;</td>
					<td class="textRight"><strong><xsl:value-of select="FACTURACION/TOTALES/TOTAL_COMISION"/></strong></td>
					<td>&nbsp;</td>
					<td colspan="3" class="borderLeft">&nbsp;</td>
					<td colspan="2" style="text-align:right;padding-right:30px;">
						<a href="javascript:MarcarFacturasEnviadas();" id="botonMarcarFacturas">
							<img src="http://www.newco.dev.br/images/marcar.gif">
								<xsl:attribute name="alt"><xsl:value-of select="document($doc)/translation/texts/item[@name='marcar_facturas_como_enviadas']/node()"/></xsl:attribute>
								<xsl:attribute name="title"><xsl:value-of select="document($doc)/translation/texts/item[@name='marcar_facturas_como_enviadas']/node()"/></xsl:attribute>
							</img>
						</a>
					</td>
					<td>&nbsp;</td>
				</tr>
				<tr>
					<td colspan="11">&nbsp;</td>
					<td colspan="6" class="borderLeft">&nbsp;</td>
				</tr>
			</tfoot>
		</xsl:when>
		<xsl:otherwise>
			<tbody>
				<tr><td colspan="17"><xsl:value-of select="document($doc)/translation/texts/item[@name='no_hay_datos']/node()"/></td></tr>
			</tbody>
		</xsl:otherwise>
		</xsl:choose>

		  </table>

			<table class="infoTable" bgcolor="#f5f5f5">
			<tfoot>
				<tr class="lejenda lineBorderBottom3">
					<td>&nbsp;</td>
					<td colspan="4" class="datosLeft">&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='leyenda_control']/node()"/></td>
				</tr>
				<tr class="lineBorderBottom5">
					<td class="cinco">&nbsp;</td>
					<td class="trentacinco datosLeft">
						<p>
							&nbsp;&nbsp;&nbsp;&nbsp;<img src="http://www.newco.dev.br/images/iconPedido.gif" border="0"/>&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='listado_lineas_pedido']/node()"/><br/>
							&nbsp;&nbsp;&nbsp;&nbsp;<img src="http://www.newco.dev.br/images/iconFormFactura.gif" border="0"/>&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='factura']/node()"/><br/>
							&nbsp;&nbsp;&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_cobro_previsto']/node()"/>:&nbsp;(21/11/15)<br/>
							&nbsp;&nbsp;&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_cobro_real']/node()"/>:&nbsp;21/11/15<br/>
						</p>
					</td>
	        <td class="quince datosLeft">
						<p>&nbsp;</p>
					</td>
					<td class="quince datosLeft">
						<p>&nbsp;</p>
					</td>
					<td>&nbsp;</td>
				</tr>
			</tfoot>
			</table>
    </div>

		<!-- Pop-up para nueva entrada de factura -->
		<div class="overlay-container" id="NuevaFacturaWrap">
			<div class="window-container zoomout">
				<p style="text-align:right;">
					<a href="javascript:showTabla(false);" style="text-decoration:none;">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='cerrar']/node()"/>
					</a>&nbsp;
					<a href="javascript:showTabla(false);" style="text-decoration:none;">
						<img src="http://www.newco.dev.br/images/cerrar.gif" alt="Cerrar"/>
					</a>
				</p>

				<p id="tableTitle">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='nueva_factura']/node()"/>&nbsp;
					<xsl:value-of select="document($doc)/translation/texts/item[@name='para']/node()"/>&nbsp;
					<span id="NF_NombreEmpresa"></span>,&nbsp;
					<xsl:value-of select="FACTURACION/MES"/>/<xsl:value-of select="FACTURACION/ANNO"/>
				</p>

				<div id="mensError" class="divLeft" style="display:none;">
					<p><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='no_tiene_derechos']/node()"/></strong></p>
				</div>

				<form name="NuevaFacturaForm" method="post" id="NuevaFacturaForm">
				<input type="hidden" name="NF_IDEMPRESA" id="NF_IDEMPRESA"/>
				<input type="hidden" name="NF_IDCENTRO" id="NF_IDCENTRO"/>

				<table id="NuevaFactura" style="width:100%;">
				<thead>
					<tr style="line-height:30px;">
						<th><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='pedidos']/node()"/>:</strong></th>
						<th style="text-align:left; padding-left:6px;" id="NF_TOTALPEDIDOS">&nbsp;</th>
						<th>&nbsp;</th>
						<th><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='ahorro']/node()"/>:</strong></th>
						<th style="text-align:left; padding-left:6px;" id="NF_TOTALAHORRO">&nbsp;</th>
					</tr>
					<tr style="line-height:20px;">
						<th><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='comis_transacciones']/node()"/>:</strong></th>
						<th style="text-align:left; padding-left:6px;" id="NF_COMPEDIDOSPORC">&nbsp;</th>
						<th>&nbsp;</th>
						<th><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='comis_ahorro']/node()"/>:</strong></th>
						<th style="text-align:left; padding-left:6px;" id="NF_COMAHORROPORC">&nbsp;</th>
					</tr>
					<tr style="line-height:30px;">
						<th><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='comision']/node()"/>:</strong></th>
						<th style="text-align:left; padding-left:6px;" id="NF_TOTALCOMISION">&nbsp;</th>
						<th colspan="3">&nbsp;</th>
					</tr>
					<tr style="line-height:25px;"><th colspan="5">&nbsp;</th></tr>
				</thead>

				<tbody>
					<tr style="line-height:30px;">
						<td class="veinte"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='num_factura']/node()"/>:</strong></td>
						<td style="text-align:left; padding-left:3px;">
							<input type="text" name="NF_CODIGO" id="NF_CODIGO"/>
						</td>
						<td>&nbsp;</td>
						<td><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_factura']/node()"/>:</strong></td>
						<td style="text-align:left; padding-left:3px;">
							<input type="text" name="NF_FECHAFACTURA" id="NF_FECHAFACTURA"/>
						</td>
					</tr>

					<tr style="line-height:30px;">
						<td><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='importe']/node()"/>:</strong></td>
						<td style="text-align:left; padding-left:3px;">
							<input type="text" name="NF_IMPORTE" id="NF_IMPORTE"/>
						</td>
						<td colspan="3">&nbsp;</td>
					</tr>

					<tr style="line-height:30px;">
						<td><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_cobro_previsto']/node()"/>:</strong></td>
						<td style="text-align:left; padding-left:3px;">
							<input type="text" name="NF_FECHACOBROPREVISTO" id="NF_FECHACOBROPREVISTO"/>
						</td>
						<td>&nbsp;</td>
						<td><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_cobro_real']/node()"/>:</strong></td>
						<td style="text-align:left; padding-left:3px;">
							<input type="text" name="NF_FECHACOBROREAL" id="NF_FECHACOBROREAL"/>
						</td>
					</tr>

					<tr>
						<td><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='texto_factura']/node()"/>:</strong></td>
						<td colspan="4" style="text-align:left; padding-left:3px;">
							<textarea name="NF_TEXTOFACTURA" id="NF_TEXTOFACTURA" cols="80" rows="5" style="float:left;margin-right:10px;"/>&nbsp;
						</td>
					</tr>

					<tr class="NF_Remesa" style="line-height:30px;">
						<td><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_remesa']/node()"/>:</strong></td>
						<td style="text-align:left; padding-left:3px;" colspan="4">
							<input type="text" name="NF_FECHAREMESA" id="NF_FECHAREMESA"/>
						</td>
					</tr>

					<tr class="NF_Remesa">
						<td><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='descripcion_remesa']/node()"/>:</strong></td>
						<td colspan="4" style="text-align:left; padding-left:3px;">
							<textarea name="NF_DESCRIPCIONREMESA" id="NF_DESCRIPCIONREMESA" cols="80" rows="5" style="float:left;margin-right:10px;"/>&nbsp;
						</td>
					</tr>

					<tr style="line-height:30px;">
						<td><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='factura_enviada']/node()"/>:</strong></td>
						<td colspan="4" style="text-align:left; padding-left:3px;">
							<input type="checkbox" name="NF_ENVIADA" id="NF_ENVIADA"/>
						</td>
					</tr>

					<tr>
						<td><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='comentario']/node()"/>:</strong></td>
						<td colspan="4" style="text-align:left; padding-left:3px;">
							<textarea name="NF_COMENTARIO" id="NF_COMENTARIO" cols="80" rows="5" style="float:left;margin-right:10px;"/>&nbsp;
						</td>
					</tr>
				</tbody>

				<tfoot>
					<tr>
						<td>&nbsp;</td>
						<td>
							<div class="boton" id="botonNuevaFactura">
								<a href="javascript:nuevaFactura();">
									<xsl:value-of select="document($doc)/translation/texts/item[@name='nueva']/node()"/>
								</a>
							</div>
						</td>
						<td id="Respuesta" colspan="3" style="text-align:left;"></td>
					</tr>
				</tfoot>
				</table>
				</form>
			</div>
		</div>
		<!-- FIN Pop-up para nueva factura -->

		<!-- Pop-up para modificar entrada de factura -->
		<div class="overlay-container" id="EditaFacturaWrap">
			<div class="window-container zoomout">
				<p style="text-align:right;">
					<a href="javascript:showTabla(false);" style="text-decoration:none;">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='cerrar']/node()"/>
					</a>&nbsp;
					<a href="javascript:showTabla(false);" style="text-decoration:none;">
						<img src="http://www.newco.dev.br/images/cerrar.gif" alt="Cerrar"/>
					</a>
				</p>

				<p id="tableTitle">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='modifica_factura']/node()"/>&nbsp;
					<xsl:value-of select="document($doc)/translation/texts/item[@name='para']/node()"/>&nbsp;
					<span id="EF_NombreEmpresa"></span>,&nbsp;
					<xsl:value-of select="FACTURACION/MES"/>/<xsl:value-of select="FACTURACION/ANNO"/>
				</p>

				<div id="mensError" class="divLeft" style="display:none;">
					<p><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='no_tiene_derechos']/node()"/></strong></p>
				</div>

				<form name="EditaFacturaForm" method="post" id="EditaFacturaForm">
				<input type="hidden" name="EF_IDEMPRESA" id="EF_IDEMPRESA"/>
				<input type="hidden" name="EF_IDCENTRO" id="EF_IDCENTRO"/>
				<input type="hidden" name="EF_IDFACTURA" id="EF_IDFACTURA"/>

				<table id="EditaFactura" style="width:100%;">
					<thead>
						<tr style="line-height:30px;">
							<th><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='pedidos']/node()"/>:</strong></th>
							<th style="text-align:left; padding-left:6px;" id="EF_TOTALPEDIDOS">&nbsp;</th>
							<th>&nbsp;</th>
							<th><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='ahorro']/node()"/>:</strong></th>
							<th style="text-align:left; padding-left:6px;" id="EF_TOTALAHORRO">&nbsp;</th>
						</tr>
						<tr style="line-height:20px;">
							<th><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='comis_transacciones']/node()"/>:</strong></th>
							<th style="text-align:left; padding-left:6px;" id="EF_COMPEDIDOSPORC">&nbsp;</th>
							<th>&nbsp;</th>
							<th><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='comis_ahorro']/node()"/>:</strong></th>
							<th style="text-align:left; padding-left:6px;" id="EF_COMAHORROPORC">&nbsp;</th>
						</tr>
						<tr style="line-height:30px;">
							<th><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='comision']/node()"/>:</strong></th>
							<th style="text-align:left; padding-left:6px;" id="EF_TOTALCOMISION">&nbsp;</th>
							<th colspan="3">&nbsp;</th>
						</tr>
						<tr style="line-height:25px;"><th colspan="5">&nbsp;</th></tr>
					</thead>

				<tbody>
					<tr style="line-height:30px;">
						<td class="veinte"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='num_factura']/node()"/>:</strong></td>
						<td style="text-align:left; padding-left:3px;">
							<input type="text" name="EF_CODIGO" id="EF_CODIGO"/>
						</td>
						<td>&nbsp;</td>

						<td><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_factura']/node()"/>:</strong></td>
						<td style="text-align:left; padding-left:3px;">
							<input type="text" name="EF_FECHAFACTURA" id="EF_FECHAFACTURA"/>
						</td>
					</tr>

					<tr style="line-height:30px;">
						<td><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='importe']/node()"/>:</strong></td>
						<td style="text-align:left; padding-left:3px;">
							<input type="text" name="EF_IMPORTE" id="EF_IMPORTE"/>
						</td>
						<td colspan="3">&nbsp;</td>
					</tr>

					<tr style="line-height:30px;">
						<td><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_cobro_previsto']/node()"/>:</strong></td>
						<td style="text-align:left; padding-left:3px;">
							<input type="text" name="EF_FECHACOBROPREVISTO" id="EF_FECHACOBROPREVISTO"/>
						</td>
						<td>&nbsp;</td>
						<td><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_cobro_real']/node()"/>:</strong></td>
						<td style="text-align:left; padding-left:3px;">
							<input type="text" name="EF_FECHACOBROREAL" id="EF_FECHACOBROREAL"/>
						</td>
					</tr>

					<tr>
						<td><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='texto_factura']/node()"/>:</strong></td>
						<td colspan="4" style="text-align:left; padding-left:3px;">
							<textarea name="EF_TEXTOFACTURA" id="EF_TEXTOFACTURA" cols="80" rows="5" style="float:left;margin-right:10px;"/>&nbsp;
						</td>
					</tr>

					<tr class="EF_Remesa" style="line-height:30px;">
						<td><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_remesa']/node()"/>:</strong></td>
						<td style="text-align:left; padding-left:3px;" colspan="4">
							<input type="text" name="EF_FECHAREMESA" id="EF_FECHAREMESA"/>
						</td>
					</tr>

					<tr class="EF_Remesa">
						<td><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='descripcion_remesa']/node()"/>:</strong></td>
						<td colspan="4" style="text-align:left; padding-left:3px;">
							<textarea name="EF_DESCRIPCIONREMESA" id="EF_DESCRIPCIONREMESA" cols="80" rows="5" style="float:left;margin-right:10px;"/>&nbsp;
						</td>
					</tr>

					<tr style="line-height:30px;">
						<td><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='factura_enviada']/node()"/>:</strong></td>
						<td colspan="4" style="text-align:left; padding-left:3px;">
							<input type="checkbox" name="EF_ENVIADA" id="EF_ENVIADA"/>
						</td>
					</tr>

					<tr>
						<td><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='comentario']/node()"/>:</strong></td>
						<td colspan="4" style="text-align:left; padding-left:3px;">
							<textarea name="EF_COMENTARIO" id="EF_COMENTARIO" cols="80" rows="5" style="float:left;margin-right:10px;"/>&nbsp;
						</td>
					</tr>
				</tbody>

				<tfoot>
					<tr>
						<td>&nbsp;</td>
						<td>
							<div class="boton" id="botonEditaFactura">
								<a href="javascript:modificaFactura();">
									<xsl:value-of select="document($doc)/translation/texts/item[@name='guardar']/node()"/>
								</a>
							</div>
						</td>
						<td>
							<div class="boton" id="botonVerFactura">
								<a>
									<xsl:value-of select="document($doc)/translation/texts/item[@name='ver_factura']/node()"/>
								</a>
							</div>
						</td>
						<td id="Respuesta" colspan="2" style="text-align:left;"></td>
					</tr>
				</tfoot>
				</table>
				</form>
			</div>
		</div>
		<!-- FIN Pop-up para modificar factura -->

    <p>&nbsp;</p>
    <p>&nbsp;</p>
  </xsl:otherwise>
  </xsl:choose>

  <br/>
</body>
</html>
</xsl:template>

<!--buscador -->
<xsl:template name="buscador">
	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:choose>
		<xsl:when test="LANG"><xsl:value-of select="LANG"/></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<input type="hidden" name="SOLOREMESAS" id="SOLOREMESAS"/>

	<!--table select-->
	<!--<table class="buscador" border="0">-->
	<table class="buscador">
		<!--<tr class="select" height="50px">-->
		<tr class="filtros sinLinea">
			<th width="140px" style="text-align:left;">
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='texto']/node()"/>:</label><br />
				<input type="text" name="NOMBRE" size="25">
					<xsl:attribute name="value"><xsl:value-of select="FACTURACION/NOMBRE"/></xsl:attribute>
				</input>
			</th>
			<th width="140px" style="text-align:left;">
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='mes_mayu']/node()"/>:</label><br/>
				<xsl:call-template name="desplegable">
					<xsl:with-param name="path" select="FACTURACION/field[@name='MES']/."/>
					<xsl:with-param name="defecto" select="FACTURACION/MES"/>
				</xsl:call-template>
			</th>
			<th width="140px" style="text-align:left;">
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='anyo']/node()"/>:</label><br/>
				<xsl:call-template name="desplegable">
					<xsl:with-param name="path" select="FACTURACION/field[@name='ANNO']/."/>
					<xsl:with-param name="defecto" select="FACTURACION/ANNO"/>
				</xsl:call-template>
			</th>
			<th width="200px" style="text-align:left;">
				<input class="peq" type="checkbox" name="SOLOREMESAS_CHK" id="SOLOREMESAS_CHK">
					<xsl:if test="FACTURACION/SOLOREMESAS = 'S'"><xsl:attribute name="checked">checked</xsl:attribute></xsl:if>
				</input>&nbsp;
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='solo_remesas']/node()"/></label>
			</th>
			<th width="140px" style="text-align:left;">
				<a class="btnDestacado" href="javascript:AplicarFiltro();" title="Buscar">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='buscar']/node()"/>
					<!--<img src="http://www.newco.dev.br/images/buttonBuscar.gif" alt="Buscar" />-->
				</a>
			</th>
		</tr>
	</table>
</xsl:template>
<!-- fin de buscador -->

<xsl:template match="Sorry">
  <xsl:apply-templates select="Noticias/ROW/Sorry"/>
</xsl:template>
</xsl:stylesheet>
