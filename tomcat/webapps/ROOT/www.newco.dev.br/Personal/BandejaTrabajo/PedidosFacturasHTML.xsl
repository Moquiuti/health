<?xml version="1.0" encoding="iso-8859-1"?>
<!--
	Gestion de pedidos/albaranes/facturas/pagos
	Ultima revision: ET 14nov19 11:50 PedidosFacturas_160321.js
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:import href="http://www.newco.dev.br/General/General.xsl"/>
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="usuario" select="@US_ID"/>

<xsl:template match="/PedidosYFacturas">
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

	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->

	<!--<script type="text/javascript">
        //solodebug
        console.log("JS WFSTATUS INICIO");
	</script>-->

	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/Personal/BandejaTrabajo/PedidosFacturas_160321.js"></script>

	<script type="text/javascript">
	</script>
  
</head>
<body>
	<!--onLoad="javascript:EliminaCookies();"-->
	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:choose>
		<xsl:when test="LANG"><xsl:value-of select="LANG"/></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<form  method="post" name="Form1" id="Form1" action="WFStatusSave.xsql">
	<input type="hidden" name="IDOFERTA"/>
	<input type="hidden" name="IDMOTIVO"/>
	<input type="hidden" name="FECHAPEDIDO"/>
	<input type="hidden" name="NUEVAFECHAENTREGA"/>
	<input type="hidden" name="FECHAACTUAL" value="{INICIO/PEDIDOSPROBLEMATICOS/FECHAACTUAL}"/>
	<input type="hidden" name="COMENTARIOS"/>
	<input type="hidden" name="BLOQUEADO"/>
	<input type="hidden" name="NOCUMPLEPEDMIN"/>
	<input type="hidden" name="FARMACIA"/>
	<input type="hidden" name="MATERIAL"/>
	<input type="hidden" name="SINSTOCKS"/>
    <input type="hidden" name="TODOS12MESES"/>
    <input type="hidden" name="INCFUERAPLAZO"/>
    <input type="hidden" name="PED_ENTREGADOOK"/>
    <input type="hidden" name="PED_PEDIDONOCOINCIDE"/>
    <input type="hidden" name="BUSCAR_PACKS"/>
    <input type="hidden" name="PED_RETRASADO"/>
    <input type="hidden" name="PED_ENTREGADOPARCIAL"/>
    <input type="hidden" name="PED_NOINFORMADOENPLATAFORMA"/>
    <input type="hidden" name="PED_PRODUCTOSANYADIDOS"/>
    <input type="hidden" name="PED_PRODUCTOSRETIRADO"/>
    <input type="hidden" name="PED_MALAATENCIONPROV"/>
    <input type="hidden" name="PED_URGENTE"/>
    <input type="hidden" name="PED_RETRASODOCTECNICA"/>
    <input type="hidden" name="ALBARAN"/>
    <input type="hidden" name="IDALBARAN"/>
    <!--subir documentos-->
    <input type="hidden" name="CADENA_DOCUMENTOS" />
    <input type="hidden" name="DOCUMENTOS_BORRADOS"/>
    <input type="hidden" name="BORRAR_ANTERIORES"/>
    <input type="hidden" name="ID_USUARIO" value="{/PedidosYFacturas/INICIO/IDUSUARIO}" />
    <input type="hidden" name="TIPO_DOC" value="ALBARAN"/>
    <input type="hidden" name="DOC_DESCRI" />
    <input type="hidden" name="REMOVE" value="{document($doc)/translation/texts/item[@name='remove']/node()}"/>
    <input type="hidden" name="CHANGE_PROV" />
    <input type="hidden" name="IDPROVEEDOR_ALB" value="{/PedidosYFacturas/INICIO/IDEMPRESA}" />
    <input type="hidden" name="SOLOPEDIDOS" value="{/PedidosYFacturas/INICIO/SOLOPEDIDOS}" />
            
	<xsl:choose>
	<!-- Error en alguna sentencia del XSQL -->
	<xsl:when test="INICIO/xsql-error">
		<xsl:apply-templates select="INICIO/xsql-error"/>
	</xsl:when>
	<xsl:when test="INICIO/SESION_CADUCADA">
		<xsl:for-each select="INICIO/SESION_CADUCADA">
			<xsl:if test="position()=last()">
				<xsl:apply-templates select="."/>
			</xsl:if>
		</xsl:for-each>
	</xsl:when>
	<xsl:otherwise>
        <xsl:call-template name="estiloIndip"/>		
		<xsl:call-template name="ADMIN"/>
<!--		
		<xsl:apply-templates select="INICIO/CABECERAS"/>

		<div class="divLeft">
		<xsl:choose>
		<xsl:when test="INICIO/PEDIDOSPROBLEMATICOS/VENDEDOR or INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR">
			<xsl:choose>
				<xsl:when test="INICIO/CUADRO_AVANZADO or INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/PERMITIR_CONTROL_PEDIDOS">
					<xsl:call-template name="ADMIN"/>
				</xsl:when>

				<xsl:when test="not(INICIO/CUADRO_AVANZADO) and (INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/ADMIN = 'EMPRESA' or INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/ADMIN = '' or INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/ADMIN = 'NORMAL' or INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/ADMIN = 'CENTRO')">
					<xsl:call-template name="CLIENTE"/>
				</xsl:when>

				<xsl:otherwise>
					<xsl:apply-templates select="INICIO/PEDIDOSPROBLEMATICOS/VENDEDOR"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:when>
		</xsl:choose>
		</div>
-->
	</xsl:otherwise>
	</xsl:choose>
	</form>
	<!--        
    <div id="uploadFrame" style="display:none;"><iframe src="" id="uploadFrame" name="uploadFrame" style="width: 100%;"></iframe></div>
    <div id="uploadFrameBoxDoc" style="display:none;"><iframe src="" id="uploadFrameDoc" name="uploadFrameDoc" style="width: 100%;"></iframe></div>
	-->
</body>
</html>
</xsl:template>

<!--ADMIN DE MVM-->
<xsl:template name="ADMIN">
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
		<p class="Path"><xsl:value-of select="document($doc)/translation/texts/item[@name='Inicio']/node()"/>&nbsp;/&nbsp;<span class="FinPath"><xsl:value-of select="document($doc)/translation/texts/item[@name='pedidos']/node()"/>,&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='facturas']/node()"/></span></p>
		<p class="TituloPagina">
          <xsl:value-of select="document($doc)/translation/texts/item[@name='pedidos']/node()"/>,&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='facturas']/node()"/>
          &nbsp;&nbsp;
		  <span class="CompletarTitulo">
          <xsl:value-of select="INICIO/PEDIDOSPROBLEMATICOS/TOTAL" />&nbsp;
          <!--<xsl:value-of select="document($doc)/translation/texts/item[@name='pedidos_en_total']/node()"/>&nbsp;&nbsp;&nbsp;&nbsp;-->
          <xsl:value-of select="document($doc)/translation/texts/item[@name='pedidos']/node()"/>.&nbsp;
		  <xsl:value-of select="document($doc)/translation/texts/item[@name='pagina']/node()"/>&nbsp;
          <xsl:variable name="pagina">
            <xsl:choose>
            <xsl:when test="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/PAGINA != ''">
              <xsl:value-of select="number(INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/PAGINA)+number(1)"/>
            </xsl:when>
            <xsl:otherwise>1</xsl:otherwise>
            </xsl:choose>
          </xsl:variable>
          <xsl:value-of select="$pagina" />&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='de']/node()"/>&nbsp;
          <xsl:value-of select="//BOTONES/NUMERO_PAGINAS" />.&nbsp;
          <!--<xsl:value-of select="document($doc)/translation/texts/item[@name='con']/node()"/>&nbsp;-->
		  <!--	Pendiente arreglar botones adelante y atras	-->
			<xsl:if test="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/BOTONES/ANTERIOR">
				<a class="btnNormal" href="javascript:AplicarFiltroPagina({INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/BOTONES/ANTERIOR/@Pagina});">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='anterior']/node()"/>
				</a>&nbsp;
			</xsl:if>
			<a class="btnNormal" href="javascript:DescargarExcel();"><img src="http://www.newco.dev.br/images/iconoExcel.gif" alt="Descargar Excel"/></a>&nbsp;
			<xsl:if test="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/BOTONES/SIGUIENTE">
				<a class="btnNormal" href="javascript:AplicarFiltroPagina({INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/BOTONES/SIGUIENTE/@Pagina});">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='siguiente']/node()"/>
				</a>&nbsp;
			</xsl:if>
		  </span>
		</p>
	</div>
	<br/>
	<br/>



  <xsl:if test="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR">
	<input type="hidden" name="ORDEN" value="{./ORDEN}"/>
	<input type="hidden" name="SENTIDO" value="{./SENTIDO}"/>

	<input type="hidden" name="PAGINA" id="PAGINA" value="{INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/PAGINA}"/>
	<table class="buscador" border="0">

		<!--	Filtros Desplegables - 18feb19 Se los quitamos a los usuarios básicos "ocultar proveedor", por ejemplo CG, excepto que sean usuarios EMPRESA 	-->
		<xsl:if test="(INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/ADMIN='EMPRESA') or not(INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/OCULTAR_PROVEEDOR)">
			<tr class="filtros">
			<td colspan="20">
				<xsl:call-template name="buscadorInicioAdmin"/><!--buscador mvm igual a buscador cdc edu 6-10-15-->
        	</td>
			</tr>
		</xsl:if>

		<tr class="subTituloTabla">
			<th class="uno">&nbsp;<!--<xsl:value-of select="document($doc)/translation/texts/item[@name='pos']/node()"/>.--></th>
			<th class="zerouno">&nbsp;</th>
			<th class="tres" style="text-align:left;">
				<a href="javascript:OrdenarPor('NUMERO_PEDIDO');">
					<xsl:copy-of select="document($doc)/translation/texts/item[@name='pedido']/node()"/>
				</a>
			</th>
			<xsl:if test="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/MOSTRARCENTRO">
				<th class="diez" style="text-align:left;">
					&nbsp;<a href="javascript:OrdenarPor('CENTRO');"><xsl:value-of select="document($doc)/translation/texts/item[@name='centro']/node()"/></a>
				</th>
			</xsl:if>
			<xsl:if test="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/MOSTRARCENTROCONSUMO">
				<th class="diez" style="text-align:left;">
					&nbsp;<a href="javascript:OrdenarPor('CENTROCONSUMO');"><xsl:value-of select="document($doc)/translation/texts/item[@name='centro_de_consumo']/node()"/></a>
				</th>
			</xsl:if>
			<th class="diez" style="text-align:left;">
				&nbsp;<a href="javascript:OrdenarPor('PROVEEDOR');"><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/></a>
			</th>
			<th class="tres" style="text-align:left;">
				<a href="javascript:OrdenarPor('FECHA_EMISION');"><xsl:copy-of select="document($doc)/translation/texts/item[@name='fecha']/node()"/></a>
			</th>
			<th class="tres" style="text-align:left;">
				<a href="javascript:OrdenarPor('FECHA_ENVIADO_DIA');"><xsl:copy-of select="document($doc)/translation/texts/item[@name='entrega']/node()"/></a>
			</th>
			<th class="tres" style="text-align:left;">
				<a href="javascript:OrdenarPor('ESTADO');"><xsl:value-of select="document($doc)/translation/texts/item[@name='estado']/node()"/></a>
			</th>
			<th class="tres" style="text-align:right;">
				<xsl:choose>
				<xsl:when test="/PedidosYFacturas/INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/MOSTRAR_PRECIOS_CON_IVA"><xsl:value-of select="document($doc)/translation/texts/item[@name='total_cIVA']/node()"/></xsl:when>
				<xsl:otherwise><xsl:value-of select="document($doc)/translation/texts/item[@name='total']/node()"/></xsl:otherwise>
				</xsl:choose>
				&nbsp;(<xsl:value-of select="INICIO/DIVISA/PREFIJO"/><xsl:value-of select="INICIO/DIVISA/SUFIJO"/>)
			</th>
			<th class="tres">
				<a href="javascript:OrdenarPor('ALBARAN');"><xsl:value-of select="document($doc)/translation/texts/item[@name='alb']/node()"/></a>
			</th>
			<th class="cinco">
				<a href="javascript:OrdenarPor('FACTURA');"><xsl:value-of select="document($doc)/translation/texts/item[@name='factura']/node()"/></a>
			</th>
			<th class="cinco">
				<a href="javascript:OrdenarPor('PAGADO');"><xsl:value-of select="document($doc)/translation/texts/item[@name='Pagado']/node()"/></a>
			</th>
			<th style="width:200px;">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='guardar']/node()"/>
			</th>
		</tr>

		<!--SI NO HAY PEDIDOS ENSENO UN MENSAJE Y SIGO ENSENaNDO CABECERA-->
		<xsl:choose>
		<xsl:when test="INICIO/PEDIDOSPROBLEMATICOS/TOTAL = '0'">
			<tr class="lejenda"><th colspan="17"><xsl:value-of select="document($doc)/translation/texts/item[@name='no_pedidos_para_busqueda']/node()"/></th></tr>
		</xsl:when>
		<xsl:otherwise>

		<!--el buscador hace innecesario este separador <tr class="medio" height="3px"><td class="medio" colspan="7"></td></tr>-->
		<xsl:for-each select="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/PEDIDO">
		<tbody>
			<tr style="border-bottom:1px solid #A7A8A9;">
			<td>
				<xsl:attribute name="style">
					<xsl:choose>
					<xsl:when test="RECLAMACION ='S' and BLOQUEAR ='N'">background:#FF9900;</xsl:when>
					<xsl:when test="RECLAMACION ='S' and BLOQUEAR ='S'">background:#FF9900;</xsl:when>
					<xsl:when test="RECLAMACION!='S' and BLOQUEAR='S' and (/PedidosYFacturas/INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/PERMITIR_CONTROL_PEDIDOS)">background:#FE4162;</xsl:when>
					<!--<xsl:otherwise>text-align:left;</xsl:otherwise>-->
           		</xsl:choose>
				</xsl:attribute>
				<xsl:value-of select="POSICION"/>
			</td>
			<!--4nov16	tipo de pedido: ya no ponemos el icono de farmacia
			<td>
				<xsl:choose>
				<xsl:when test="CATEGORIA = 'F'"><img src="http://www.newco.dev.br/images/farmacia-icon.gif" alt="Farmacia"/></xsl:when>
				</xsl:choose>
			</td>-->
			<td>
				<xsl:choose>
				<xsl:when test="URGENTE = 'S'"><img src="http://www.newco.dev.br/images/2017/warning-red.png"/>&nbsp;</xsl:when>
				<xsl:otherwise>&nbsp;</xsl:otherwise>
				</xsl:choose>
				<xsl:choose>
				<xsl:when test="PREPAGOPENDIENTE"><img src="http://www.newco.dev.br/images/2017/icono-pago.png"/>&nbsp;</xsl:when>
				<xsl:otherwise></xsl:otherwise>
				</xsl:choose>
			</td>
			<td class="cinco" style="text-align:left;">
				<strong><a>
					<xsl:attribute name="href">javascript:MostrarPagPersonalizada('http://www.newco.dev.br/<xsl:value-of select="ENLACETAREA"/>','Multioferta',100,100,0,0)</xsl:attribute>
					<xsl:value-of select="NUMERO_PEDIDO"/>
				</a></strong>
			</td>

			<xsl:if test="../MOSTRARCENTRO">
				<td class="textLeft">
					<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/CENDetalle.xsql?ID={IDCENTROCLIENTE}','Centro',100,80,0,-20);">
						<xsl:value-of select="NOMBRE_CENTRO"/>
					</a>
				</td>
			</xsl:if>

			<xsl:if test="../MOSTRARCENTROCONSUMO">
				<td class="textLeft">
					<xsl:value-of select="CENTROCONSUMO"/>
				</td>
			</xsl:if>

			<xsl:if test="not(../OCULTAR_PROVEEDOR)">
				<td class="textLeft">
					<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPDetalleFrame.xsql?EMP_ID={IDPROVEEDOR}&amp;VENTANA=NUEVA','Centro',100,80,0,-20);">
						<xsl:value-of select="PROVEEDOR"/>
					</a>
					<xsl:if test="CAMBIOSPROVEEDOR='S'">&nbsp;<img src="http://www.newco.dev.br/images/bolaAmbar.gif"/></xsl:if>
				</td>
			</xsl:if>
			<td style="text-align:left;">
				<xsl:value-of select="FECHA_PEDIDO"/>
			</td>
			<td style="text-align:left;">
				<xsl:choose>
				<xsl:when test="FECHA_ENTREGA_CORREGIDA != ''">
					<xsl:value-of select="FECHA_ENTREGA_CORREGIDA"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="FECHA_ENTREGA"/>
				</xsl:otherwise>
				</xsl:choose>
			</td>
			<td style="font-style:11px;text-align:left;">
			<xsl:choose>
				<xsl:when test="contains(ESTADO,'PARCIAL')">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='entr_parcial']/node()"/>
				</xsl:when>
				<xsl:when test="contains(ESTADO,'ACEPTAR')">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='aceptar']/node()"/>
				</xsl:when>
				<xsl:when test="contains(ESTADO,'Pend')">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='pendiente_maiu']/node()"/>
				</xsl:when>
				<xsl:when test="contains(ESTADO,'RECH')">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='rechazado']/node()"/>
				</xsl:when>
				<xsl:when test="contains(ESTADO,'RETR')">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='retrasado']/node()"/>
				</xsl:when>
				<xsl:when test="contains(ESTADO,'REQ.ENVIO')">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='req_envio']/node()"/>
				</xsl:when>
				<xsl:when test="contains(ESTADO,'ENVIADO')">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='enviado']/node()"/>
				</xsl:when>
				<xsl:when test="contains(ESTADO,'AP.SUP.')"><!-- 18feb19 Usuario aprobador	-->
					<xsl:value-of select="document($doc)/translation/texts/item[@name='aprobar_superior']/node()"/>:<xsl:value-of select="USUARIOAPROBADOR"/>
				</xsl:when>
				<xsl:when test="contains(ESTADO,'RECH.SUP.')">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='rechazado_superior']/node()"/>
				</xsl:when>
				<xsl:when test="contains(ESTADO,'FINAL')">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='final_maiu']/node()"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="ESTADO"/>
				</xsl:otherwise>
			</xsl:choose>
        	  <!--muestra-->
        	  <xsl:if test="contains(ESTADO,'Muestras')">
            	&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='muestras']/node()"/>
        	  </xsl:if>
			</td>
        	<!--total es con iva, subtotal sin iva-->
        	<td style="text-align:right;">
        	  <xsl:choose>
        	  <xsl:when test="/PedidosYFacturas/INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/MOSTRAR_PRECIOS_CON_IVA"><xsl:value-of select="PED_TOTAL"/></xsl:when>
        	  <xsl:otherwise><xsl:value-of select="PED_SUBTOTAL"/></xsl:otherwise>
        	  </xsl:choose>
        	</td>
			<td><xsl:value-of select="ALBARAN"/></td>
			<td><input type="text" id="Factura_{MO_ID}" name="Factura_{MO_ID}" value="{PED_FACTURA}" onKeyPress="javascript:ActivarGuardar({MO_ID});"/></td>
			<td><input type="text" id="Pagado_{MO_ID}" name="Pagado_{MO_ID}" value="{PED_PAGADO}" onKeyPress="javascript:ActivarGuardar({MO_ID});"/></td>
        	<td class="uno">
				<a class="Guardar btnDestacado" id="Guardar_{MO_ID}" name="Guardar_{MO_ID}" style="display:none" href="javascript:Guardar({MO_ID});">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='guardar']/node()"/>
				</a>
				<img id="OK_{MO_ID}" name="OK_{MO_ID}" style="display:none" src="http://www.newco.dev.br/images/recibido.gif"/>
				<img id="Error_{MO_ID}" name="Error_{MO_ID}" style="display:none" src="http://www.newco.dev.br/images/error.gif"/>
			</td>
		</tr>
		</tbody>
		</xsl:for-each><!--fin de pedidos-->

      <!--total pedidos-->
      <tr>
        <td colspan="{INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/COLSPAN_TOTALES}">
        </td>
        <td style="text-align:right;" colspan="3">
          <strong><xsl:value-of select="document($doc)/translation/texts/item[@name='total']/node()"/>:&nbsp;<xsl:value-of select="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/TOTAL_PEDIDOS"/>
          <!--	Center Group quiere ver el importe con y sin IVA -->
		  <xsl:if test="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/MOSTRAR_PRECIOS_CON_IVA">
		  	<br/><xsl:value-of select="document($doc)/translation/texts/item[@name='total_cIVA']/node()"/>:&nbsp;<xsl:value-of select="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/TOTAL_PEDIDOS_CONIVA"/>
		  </xsl:if>
		  </strong>
        </td>
        <!--pedidos retrasados-->
        <td style="text-align:left;" colspan="3">
          <img src="http://www.newco.dev.br/images/2017/clock-red.png" alt="Retrasados" />&nbsp;
          <xsl:value-of select="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/PEDIDOS_RETRASADOS"/> / <xsl:value-of select="INICIO/PEDIDOSPROBLEMATICOS/TOTAL" /> : <xsl:value-of select="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/PORC_PED_RETRASADOS"/>
        </td>
        <td colspan="5">&nbsp;</td>
      </tr>
		</xsl:otherwise>
		</xsl:choose><!--fin de choose si hay pedidos-->
		</table>
  </xsl:if>

</xsl:template><!--FIN DE TEMPLATE ADMIN-->


<!--buscador para admin mvm en el medio de tabla pedidos-->
<xsl:template name="buscadorInicioAdmin">
	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:choose>
		<xsl:when test="//LANG"><xsl:value-of select="//LANG"/></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->
	
	<br/>
	<!--table select-->
	<table class="buscador" border="0">
		<xsl:variable name="BuscAvanzStyle">
			<xsl:choose>
			<xsl:when test="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/URGENTE = 'S' or INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/BLOQUEADO = 'S' or INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/FARMACIA = 'S' or INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/MATERIALSANITARIO = 'S' or INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/SINSTOCKS = 'S' or INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/TODOS12MESES = 'S' or INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/INCFUERAPLAZO = 'S' or INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/PEDIDOOK = 'S' or INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/ENTR_RETRASADO = 'S' or INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/PEDIDONOCOINCIDE = 'S' or INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/ENTR_PARCIAL = 'S' or INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/RETRASODOCUMTEC = 'S' or INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/NOINFORMADOPLAT = 'S' or INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/PROD_ANYADIDOS = 'S' or INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/PROD_RETIRADOS = 'S' or INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/MALAATENCIONPROV = 'S' or INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/FECHAINICIO != '' or INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/FECHAFINAL != ''"></xsl:when>
			<xsl:otherwise>display:none;</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<tr class="filtros">
		<xsl:if test="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/ADMIN='MVM'">
			<th width="160px"  style="text-align:left;">
				<label>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='empresa']/node()"/>:</label><br />
				&nbsp;<xsl:call-template name="desplegable"><xsl:with-param name="path" select="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/FILTROS/IDEMPRESA/field"/></xsl:call-template>&nbsp;
			</th>
		</xsl:if>
		<xsl:if test="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/FILTROS/IDCENTRO">
			<th width="160px"  style="text-align:left;">
				<label>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='centro']/node()"/>:</label><br />
				&nbsp;<xsl:call-template name="desplegable"><xsl:with-param name="path" select="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/FILTROS/IDCENTRO/field"/></xsl:call-template>&nbsp;
			</th>
		</xsl:if>
		<xsl:if test="not(INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/OCULTAR_PROVEEDOR)">
			<th width="160px"  style="text-align:left;">
				<label>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/>:</label><br />
				&nbsp;<xsl:call-template name="desplegable"><xsl:with-param name="path" select="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/FILTROS/IDPROVEEDOR/field"/></xsl:call-template>&nbsp;
			</th>
		</xsl:if>
		<th width="140px"  style="text-align:left;">
			<label>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='motivo']/node()"/>:</label><br />
			&nbsp;<xsl:call-template name="desplegable"><xsl:with-param name="path" select="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/FILTROS/IDFILTROMOTIVO/field"/></xsl:call-template>&nbsp;
		</th>
		<th width="140px" style="text-align:left;">
			<label><xsl:value-of select="document($doc)/translation/texts/item[@name='responsable']/node()"/>:</label><br />
			<xsl:call-template name="desplegable"><xsl:with-param name="path" select="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/FILTROS/IDFILTRORESPONSABLE/field"/></xsl:call-template>&nbsp;
		</th>
		<th width="140px" style="text-align:left;">
			<label><xsl:value-of select="document($doc)/translation/texts/item[@name='situacion']/node()"/>:</label><br />
			<xsl:call-template name="desplegable"><xsl:with-param name="path" select="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/FILTROS/IDFILTROSEMAFORO/field"/></xsl:call-template>&nbsp;
		</th>
		<th width="140px" style="text-align:left;">
			<label><xsl:value-of select="document($doc)/translation/texts/item[@name='numero_pedido']/node()"/>:</label><br />
			<input class="buscador" type="text" name="CODIGOPEDIDO" size="10" maxlength="20" value="{INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/CODIGOPEDIDO}"/>&nbsp;
		</th>
		<th width="140px" style="text-align:left;">
			<label><xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/>:</label><br />
			<input class="buscador" type="text" name="PRODUCTO" size="10" maxlength="20" value="{INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/PRODUCTO}"/>&nbsp;
		</th>
		<th width="140px" style="text-align:left;">
			<!--fecha inicio-->
			<label><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_inicio']/node()"/>:</label><br />
			<input type="text" name="FECHA_INICIO" value="{INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/FECHAINICIO}" size="9" />
		</th>
		<th width="140px" style="text-align:left;">
			<!--fecha final-->
			<label><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_final']/node()"/>:</label><br />
			<input type="text" name="FECHA_FINAL" value="{INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/FECHAFINAL}"  size="9"  />
		</th>
		<th width="140px" style="text-align:left;">
			<!--<label><xsl:value-of select="document($doc)/translation/texts/item[@name='Lineas_por_pagina']/node()"/>:</label>-->&nbsp;<br />
			<select name="LINEA_POR_PAGINA" id="LINEA_POR_PAGINA" onchange="AplicarFiltro();">
			<option value="30">
    			<xsl:if test="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/LINEASPORPAGINA = '30'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>
			  30 <xsl:value-of select="document($doc)/translation/texts/item[@name='lineas']/node()"/>
			</option>
			<option value="50">
			  <xsl:if test="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/LINEASPORPAGINA = '50'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>
			  50 <xsl:value-of select="document($doc)/translation/texts/item[@name='lineas']/node()"/>
			</option>
			<option value="100">
			  <xsl:if test="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/LINEASPORPAGINA = '100'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>
			  100 <xsl:value-of select="document($doc)/translation/texts/item[@name='lineas']/node()"/>
			</option>
			<option value="500">
			  <xsl:if test="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/LINEASPORPAGINA = '500'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>
			  500 <xsl:value-of select="document($doc)/translation/texts/item[@name='lineas']/node()"/>
			</option>
			<option value="1000">
			  <xsl:if test="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/LINEASPORPAGINA = '1000'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>
			  1000 <xsl:value-of select="document($doc)/translation/texts/item[@name='lineas']/node()"/>
			</option>
			</select>
		</th>
    	<!--
			<th width="120px" style="text-align:center;">
       		<a href="javascript:VerBuscadorAvanzado();" title="Buscador avanzado"  class="btnDiscreto">
				[<xsl:value-of select="document($doc)/translation/texts/item[@name='AVANZADO']/node()"/>]
        	</a>
		</th>
		-->
    	<th width="160px" style="text-align:left;">
			<a href="javascript:FiltrarBusqueda();" title="Buscar" class="btnDestacado">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='buscar']/node()"/>
			</a>&nbsp;
		</th>
		<th width="*">
			&nbsp;
		</th>
	</tr>

<!--    <tr id="buscadorAvanzadoOne" class="selectAva buscadorAvanzado sinLinea" height="40">
      <xsl:attribute name="style"><xsl:value-of select="$BuscAvanzStyle"/></xsl:attribute>

      <th>&nbsp;</th>
      <th style="text-align:left;">
		<!- -pedidos ultimos 12 meses- ->
		<input class="muypeq" type="checkbox" name="TODOS12MESES_CHECK">
			<xsl:if test="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/TODOS12MESES = 'S'"><xsl:attribute name="checked">true</xsl:attribute></xsl:if>
		</input>&nbsp;
		<label style="color:#333;"><xsl:value-of select="document($doc)/translation/texts/item[@name='24_meses']/node()"/></label>
      </th>
      <th style="text-align:left;">
		<! - -pedido entregado ok - ->
		<input class="muypeq" type="checkbox" name="PED_ENTREGADOOK_CHECK">
		<xsl:if test="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/PEDIDOOK = 'S'"><xsl:attribute name="checked">true</xsl:attribute></xsl:if>
		</input>&nbsp;
		<label><xsl:value-of select="document($doc)/translation/texts/item[@name='entrega_ok']/node()"/></label>
      </th>
      <th style="text-align:left;">
		<! - -pedido retrasado - ->
		<input class="muypeq" type="checkbox" name="PED_RETRASADO_CHECK">
			<xsl:if test="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/ENTR_RETRASADO = 'S'"><xsl:attribute name="checked">true</xsl:attribute></xsl:if>
		</input>&nbsp;
		<label><xsl:value-of select="document($doc)/translation/texts/item[@name='ped_retrasado']/node()"/></label>
      </th>
      <th style="text-align:left;">
		<! - -pedido parcial - ->
		<input class="muypeq" type="checkbox" name="PED_ENTREGADOPARCIAL_CHECK">
			<xsl:if test="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/ENTR_PARCIAL = 'S'"><xsl:attribute name="checked">true</xsl:attribute></xsl:if>
		</input>&nbsp;
		<label><xsl:value-of select="document($doc)/translation/texts/item[@name='ped_parcial']/node()"/></label>
      </th>
      <th>&nbsp;</th>
    </tr>

    <tr id="buscadorAvanzadoTwo" class="selectAva buscadorAvanzado sinLinea" height="40">
      <xsl:attribute name="style"><xsl:value-of select="$BuscAvanzStyle"/></xsl:attribute>

      <th>&nbsp;</th>
    	<th style="text-align:left;">
		<! - -pedido no informado en la plataforma mvm - ->
		<input class="muypeq" type="checkbox" name="PED_NOINFORMADOENPLATAFORMA_CHECK">
			<xsl:if test="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/NOINFORMADOPLAT = 'S'"><xsl:attribute name="checked">true</xsl:attribute></xsl:if>
		</input>&nbsp;
		<label><xsl:value-of select="document($doc)/translation/texts/item[@name='no_info_sistema']/node()"/></label>
      </th>
      <th style="text-align:left;">
        <! - -ped no coincide - ->
		<input class="muypeq" type="checkbox" name="PED_PEDIDONOCOINCIDE_CHECK">
			<xsl:if test="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/PEDIDONOCOINCIDE = 'S'"><xsl:attribute name="checked">true</xsl:attribute></xsl:if>
		</input>&nbsp;
		<label><xsl:value-of select="document($doc)/translation/texts/item[@name='ped_no_coincide']/node()"/></label>
      </th>
      <th style="text-align:left;">
        <! - -pedido con productos a?adidos - ->
		<input class="muypeq" type="checkbox" name="PED_PRODUCTOSANYADIDOS_CHECK">
			<xsl:if test="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/PROD_ANYADIDOS = 'S'"><xsl:attribute name="checked">true</xsl:attribute></xsl:if>
		</input>&nbsp;
		<label><xsl:value-of select="document($doc)/translation/texts/item[@name='prod_anadidos']/node()"/></label>
      </th>
      <th style="text-align:left;">
        <! - -pedido con productos retirados - ->
		<input class="muypeq" type="checkbox" name="PED_PRODUCTOSRETIRADO_CHECK">
			<xsl:if test="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/PROD_RETIRADOS = 'S'"><xsl:attribute name="checked">true</xsl:attribute></xsl:if>
		</input>&nbsp;
		<label><xsl:value-of select="document($doc)/translation/texts/item[@name='prod_retirados']/node()"/></label>
      </th>
      <th style="text-align:left;">
		<! - -pedido con problemas en la documentacion tecnica - ->
		<input class="muypeq" type="checkbox" name="PED_RETRASODOCTECNICA_CHECK">
			<xsl:if test="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/RETRASODOCUMTEC = 'S'"><xsl:attribute name="checked">true</xsl:attribute></xsl:if>
		</input>&nbsp;
		<label><xsl:value-of select="document($doc)/translation/texts/item[@name='prob_doc_tecnica']/node()"/></label>
      </th>
      <th style="text-align:left;">
		<! - -incidencia fuera de plazo - ->
		<input class="muypeq" type="checkbox" name="INCFUERAPLAZO_CHECK">
			<xsl:if test="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/INCFUERAPLAZO = 'S'"><xsl:attribute name="checked">true</xsl:attribute></xsl:if>
		</input>&nbsp;
		<label><xsl:value-of select="document($doc)/translation/texts/item[@name='inc_ped_cerrado']/node()"/></label>
      </th>
      <th>&nbsp;</th>
    </tr>

    <tr id="buscadorAvanzadoThree" class="selectAva buscadorAvanzado" height="40">
      <xsl:attribute name="style"><xsl:value-of select="$BuscAvanzStyle"/></xsl:attribute>
	  <th>&nbsp;</th>
      <th style="text-align:left;">
		<! - -pedido no informado en la plataforma mvm - ->
		<input class="muypeq" type="checkbox" name="PED_URGENTE_CHECK">
			<xsl:if test="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/URGENTE = 'S'"><xsl:attribute name="checked">true</xsl:attribute></xsl:if>
		</input>&nbsp;
		<label><xsl:value-of select="document($doc)/translation/texts/item[@name='urgente']/node()"/></label>
      </th>
      <th style="text-align:left;">
		<! - -bloqueado check - ->
		<input class="muypeq" type="checkbox" name="BLOQUEADO_CHECK">
			<xsl:if test="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/BLOQUEADO = 'S'"><xsl:attribute name="checked">true</xsl:attribute></xsl:if>
		</input>&nbsp;
		<label><xsl:value-of select="document($doc)/translation/texts/item[@name='bloqueados']/node()"/></label>
      </th>
	  <! - -
      <th style="text-align:left;">
		<!- -farmacia check- ->
		<input class="muypeq" type="checkbox" name="FARMACIA_CHECK">
			<xsl:if test="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/FARMACIA = 'S'"><xsl:attribute name="checked">true</xsl:attribute></xsl:if>
		</input>&nbsp;
		<label><xsl:value-of select="document($doc)/translation/texts/item[@name='farmacia']/node()"/></label>
      </th>
      <th style="text-align:left;">
		<!- -material check- ->
		<input class="muypeq" type="checkbox" name="MATERIAL_CHECK">
			<xsl:if test="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/MATERIALSANITARIO = 'S'"><xsl:attribute name="checked">true</xsl:attribute></xsl:if>
		</input>&nbsp;
		<label><xsl:value-of select="document($doc)/translation/texts/item[@name='fungible']/node()"/></label>
      </th>
	   - ->
      <th style="text-align:left;">
		<! - -material check - ->
		<input class="muypeq" type="checkbox" name="NOCUMPLEPEDMIN_CHECK">
			<xsl:if test="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/NOCUMPLEPEDMIN = 'S'"><xsl:attribute name="checked">true</xsl:attribute></xsl:if>
		</input>&nbsp;
		<label><xsl:value-of select="document($doc)/translation/texts/item[@name='no_cumple_ped_min']/node()"/></label>
      </th>
      <th style="text-align:left;">
		<! - -sin stock check - ->
		<input class="muypeq" type="checkbox" name="SINSTOCKS_CHECK">
			<xsl:if test="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/SINSTOCKS = 'S'"><xsl:attribute name="checked">true</xsl:attribute></xsl:if>
		</input>&nbsp;
		<label><xsl:value-of select="document($doc)/translation/texts/item[@name='sin_stock']/node()"/></label>
		</th>
      <th style="text-align:left;">
		<! - -proveedor no atiende bien - ->
		<input class="muypeq" type="checkbox" name="PED_MALAATENCIONPROV_CHECK">
			<xsl:if test="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/MALAATENCIONPROV = 'S'"><xsl:attribute name="checked">true</xsl:attribute></xsl:if>
		</input>&nbsp;
		<label><xsl:value-of select="document($doc)/translation/texts/item[@name='mala_atencion_prov']/node()"/></label>
      </th>
      <th style="text-align:left;">
		<! - -proveedor no atiende bien - ->
		<input class="muypeq" type="checkbox" name="BUSCAR_PACKS_CHECK">
			<xsl:if test="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/BUSCAR_PACKS = 'S'"><xsl:attribute name="checked">true</xsl:attribute></xsl:if>
		</input>&nbsp;
		<label><xsl:value-of select="document($doc)/translation/texts/item[@name='busca_packs']/node()"/></label>
      </th>
      <th>&nbsp;</th>
    </tr>
-->		
	
	
	</table>
</xsl:template>
<!--fin de buscador admin tabla pedidos comprador-->

</xsl:stylesheet>
