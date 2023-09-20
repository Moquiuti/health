<?xml version="1.0" encoding="iso-8859-1"?>
<!--
	Evaluacion de proveedor
	Ultima revisión: ET 27abr21 11:15 EvaluacionProveedor_190421.js
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href="http://www.newco.dev.br/General/General.xsl" />
  <xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
  <xsl:param name="usuario" select="@US_ID"/>  
  <xsl:template match="/">
    <html>
      <head>
      <!--idioma-->
        <xsl:variable name="lang">
        	<xsl:value-of select="/EvaluacionProveedor/LANG" />
        </xsl:variable>
        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
         <!--fin idioma-->
		<title>
			<xsl:value-of select="/EvaluacionProveedor/INDICADORES/EMPRESAUSUARIO"/>:&nbsp;
			<xsl:value-of select="document($doc)/translation/texts/item[@name='evaluacion_proveedor']/node()"/>
		</title>
       
		<link rel="shortcut icon" href="http://www.newco.dev.br/images/MedicalVM.ico"/>

		<!--style-->
		<xsl:call-template name="estiloIndip"/>
		<!--fin de style-->

		<script type="text/javascript" src="http://www.newco.dev.br/General/jquery-1.8.3.min.js"></script>
		<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>
		<!--<script type="text/javascript" src="http://www.newco.dev.br/General/descargas_151117.js"></script>
		<script type="text/javascript" src="http://www.newco.dev.br/General/Chart.bundle.min.2.9.3.js"></script>-->
		<script type="text/javascript" src="http://www.newco.dev.br/Gestion/EIS/EvaluacionProveedor_190421.js"></script>
		<script type="text/javascript">
			var IDFiltroProveedor=<xsl:value-of select="/EvaluacionProveedor/INDICADORES/IDPROVEEDOR" />;

			//	Valores
			var TotalPedidos=<xsl:value-of select="/EvaluacionProveedor/INDICADORES/PEDIDOS/TOTAL" />;
			var PedPendientes=<xsl:value-of select="/EvaluacionProveedor/INDICADORES/PEDIDOS/PENDIENTES" />;
			var PedPuntuales=<xsl:value-of select="/EvaluacionProveedor/INDICADORES/PEDIDOS/PUNTUALES" />;
			var PedRetrasados=<xsl:value-of select="/EvaluacionProveedor/INDICADORES/PEDIDOS/RETRASADOS" />;
			
			var PedRetrasados1dia=<xsl:value-of select="/EvaluacionProveedor/INDICADORES/PEDIDOS/RETRASADOS1DIA" />;
			var PedRetrasados2dias=<xsl:value-of select="/EvaluacionProveedor/INDICADORES/PEDIDOS/RETRASADOS2DIAS" />;
			var PedRetrasados3dias=<xsl:value-of select="/EvaluacionProveedor/INDICADORES/PEDIDOS/RETRASADOS3DIAS" />;
			var PedRetrasados4dias=<xsl:value-of select="/EvaluacionProveedor/INDICADORES/PEDIDOS/RETRASADOS4DIAS" />;
			var PedRetrasados5diasOMas=<xsl:value-of select="/EvaluacionProveedor/INDICADORES/PEDIDOS/RETRASADOS5DIASOMAS" />;

			var PedParciales=<xsl:value-of select="/EvaluacionProveedor/INDICADORES/PEDIDOS/PARCIALES" />;
			var PedUrgentes=<xsl:value-of select="/EvaluacionProveedor/INDICADORES/PEDIDOS/URGENTES" />;
			var TMAprobacion=<xsl:value-of select="/EvaluacionProveedor/INDICADORES/PEDIDOS/TM_APROBACION" />;
			var TMAceptacion=<xsl:value-of select="/EvaluacionProveedor/INDICADORES/PEDIDOS/TM_ACEPTACION" />;
			var TMPreparacion=<xsl:value-of select="/EvaluacionProveedor/INDICADORES/PEDIDOS/TM_PREPARACION" />;
			var TMTransporte=<xsl:value-of select="/EvaluacionProveedor/INDICADORES/PEDIDOS/TM_TRANSPORTE" />;
			var TMRetraso=<xsl:value-of select="/EvaluacionProveedor/INDICADORES/PEDIDOS/TM_RETRASO" />;

			var TMLicitacion=<xsl:value-of select="/EvaluacionProveedor/INDICADORES/LICITACIONES/TIEMPOMEDIO" />;

			var LicTotal=<xsl:value-of select="/EvaluacionProveedor/INDICADORES/LICITACIONES/TOTAL" />;
			var LicProveedores=<xsl:value-of select="/EvaluacionProveedor/INDICADORES/LICITACIONES/PROVEEDORES" />;
			var LicProveedoresInf=<xsl:value-of select="/EvaluacionProveedor/INDICADORES/LICITACIONES/PROVEEDORES_INF" />;
			var LicProveedoresAdj=<xsl:value-of select="/EvaluacionProveedor/INDICADORES/LICITACIONES/PROVEEDORES_ADJ" />;
			var LicMenosDe3Dias=<xsl:value-of select="/EvaluacionProveedor/INDICADORES/LICITACIONES/LIC_MENOS_DE_3DIAS" />;
			var LicMasDe7Dias=<xsl:value-of select="/EvaluacionProveedor/INDICADORES/LICITACIONES/LIC_MAS_DE_7DIAS" />;

			var TMEstudioPrevio=<xsl:value-of select="/EvaluacionProveedor/INDICADORES/LICITACIONES/TM_ESTUDIOPREVIO" />;
			var TMOfertas=<xsl:value-of select="/EvaluacionProveedor/INDICADORES/LICITACIONES/TM_OFERTAS" />;
			var TMAdjudicacion=<xsl:value-of select="/EvaluacionProveedor/INDICADORES/LICITACIONES/TM_ADJUDICACION" />;
			var TMPedidos=<xsl:value-of select="/EvaluacionProveedor/INDICADORES/LICITACIONES/TM_PEDIDOS" />;

			//	Datos especificos de proveedor
			var TOferta1dia=<xsl:value-of select="/EvaluacionProveedor/INDICADORES/LICITACIONES/OFERTAS1DIA" />;
			var TOferta2dias=<xsl:value-of select="/EvaluacionProveedor/INDICADORES/LICITACIONES/OFERTAS2DIAS" />;
			var TOferta3dias=<xsl:value-of select="/EvaluacionProveedor/INDICADORES/LICITACIONES/OFERTAS3DIAS" />;
			var TOferta4dias=<xsl:value-of select="/EvaluacionProveedor/INDICADORES/LICITACIONES/OFERTAS4DIAS" />;
			var TOferta4diasOMas=<xsl:value-of select="/EvaluacionProveedor/INDICADORES/LICITACIONES/OFERTAS4DIASOMAS" />;

			var NumLicInformadas=<xsl:value-of select="/EvaluacionProveedor/INDICADORES/LICITACIONES/INFORMADAS" />;
			var NumLicAdjudicadas=<xsl:value-of select="/EvaluacionProveedor/INDICADORES/LICITACIONES/ADJUDICADAS" />;
			var NumLicNoInformadas=<xsl:value-of select="/EvaluacionProveedor/INDICADORES/LICITACIONES/NOOFERTADAS" />;

			//	Titulos y textos
			var TitProcPedido='<xsl:value-of select="document($doc)/translation/texts/item[@name='Proceso_completo_pedido']/node()"/>';
			var txtLicitacion='<xsl:value-of select="document($doc)/translation/texts/item[@name='Licitacion']/node()"/>';
			var txtAprobacion='<xsl:value-of select="document($doc)/translation/texts/item[@name='Aprobacion']/node()"/>';
			var txtAceptacion='<xsl:value-of select="document($doc)/translation/texts/item[@name='Aceptacion']/node()"/>';
			var txtPreparacion='<xsl:value-of select="document($doc)/translation/texts/item[@name='Preparacion']/node()"/>';
			var txtTransporte='<xsl:value-of select="document($doc)/translation/texts/item[@name='Transporte']/node()"/>';

			var TitUrgentes='<xsl:value-of select="document($doc)/translation/texts/item[@name='Pedidos_urgentes']/node()"/>';
			var TitRetrasados='<xsl:value-of select="document($doc)/translation/texts/item[@name='Pedidos_retrasados']/node()"/>';
			var TitPuntuales='<xsl:value-of select="document($doc)/translation/texts/item[@name='Pedidos_puntuales']/node()"/>';
			var TitParciales='<xsl:value-of select="document($doc)/translation/texts/item[@name='Pedidos_parciales']/node()"/>';
			var TitNormales='<xsl:value-of select="document($doc)/translation/texts/item[@name='Pedidos_normales']/node()"/>';
			var TitResto='<xsl:value-of select="document($doc)/translation/texts/item[@name='Resto_pedidos']/node()"/>';

			var TitRetrasoPedidos='<xsl:value-of select="document($doc)/translation/texts/item[@name='Analisis_retraso_pedidos']/node()"/>';
			var TitRetrasados1dia='<xsl:value-of select="document($doc)/translation/texts/item[@name='Pedidos_retrasados_1dia']/node()"/>';
			var TitRetrasados2dias='<xsl:value-of select="document($doc)/translation/texts/item[@name='Pedidos_retrasados_2dias']/node()"/>';
			var TitRetrasados3dias='<xsl:value-of select="document($doc)/translation/texts/item[@name='Pedidos_retrasados_3dias']/node()"/>';
			var TitRetrasados4dias='<xsl:value-of select="document($doc)/translation/texts/item[@name='Pedidos_retrasados_4dias']/node()"/>';
			var TitRetrasados5dias='<xsl:value-of select="document($doc)/translation/texts/item[@name='Pedidos_retrasados_5dias']/node()"/>';
			var TitRetrasados5diasOMas='<xsl:value-of select="document($doc)/translation/texts/item[@name='Pedidos_retrasados_5dias_omas']/node()"/>';

			var TitProvInfInv='<xsl:value-of select="document($doc)/translation/texts/item[@name='Proveedores_informados_invitados']/node()"/>';
			var TitProvAdjInf='<xsl:value-of select="document($doc)/translation/texts/item[@name='Proveedores_adjudicados_informados']/node()"/>';
			var txtProvInvitados='<xsl:value-of select="document($doc)/translation/texts/item[@name='Proveedores_invitados']/node()"/>';
			var txtProvInformados='<xsl:value-of select="document($doc)/translation/texts/item[@name='Proveedores_informados']/node()"/>';
			var txtProvAdjudicados='<xsl:value-of select="document($doc)/translation/texts/item[@name='Proveedores_adjudicados']/node()"/>';
		
			var TitLicMenos3dias='<xsl:value-of select="document($doc)/translation/texts/item[@name='Licitaciones_menos_3dias']/node()"/>';
			var TitLicMas7dias='<xsl:value-of select="document($doc)/translation/texts/item[@name='Licitaciones_mas_7dias']/node()"/>';
			var TitRestoLic='<xsl:value-of select="document($doc)/translation/texts/item[@name='Resto_licitaciones']/node()"/>';

			var TitProcLicitacion='<xsl:value-of select="document($doc)/translation/texts/item[@name='Proceso_completo_licitacion']/node()"/>';
			var txtEstudioPrevio='<xsl:value-of select="document($doc)/translation/texts/item[@name='Estudio_previo']/node()"/>';
			var txtOfertas='<xsl:value-of select="document($doc)/translation/texts/item[@name='ofertas']/node()"/>';
			var txtAdjudicacion='<xsl:value-of select="document($doc)/translation/texts/item[@name='Adjudicacion']/node()"/>';
			var txtPrepPedidos='<xsl:value-of select="document($doc)/translation/texts/item[@name='Preparar_pedidos']/node()"/>';

			var TitTiempoMedioOfertas='<xsl:value-of select="document($doc)/translation/texts/item[@name='Tiempo_medio_ofertas_licitacion']/node()"/>';
			var txtOferta1dia='<xsl:value-of select="document($doc)/translation/texts/item[@name='Licitaciones_Oferta_1dia']/node()"/>';
			var txtOferta2dias='<xsl:value-of select="document($doc)/translation/texts/item[@name='Licitaciones_Oferta_2dias']/node()"/>';
			var txtOferta3dias='<xsl:value-of select="document($doc)/translation/texts/item[@name='Licitaciones_Oferta_3dias']/node()"/>';
			var txtOferta4dias='<xsl:value-of select="document($doc)/translation/texts/item[@name='Licitaciones_Oferta_4dias']/node()"/>';
			var txtOferta4diasOMas='<xsl:value-of select="document($doc)/translation/texts/item[@name='Licitaciones_Oferta_4dias_omas']/node()"/>';
			
			var TitLicInfInv='<xsl:value-of select="document($doc)/translation/texts/item[@name='Licitaciones_informadas_invitadas']/node()"/>';
			var TitLicAdjInf='<xsl:value-of select="document($doc)/translation/texts/item[@name='Licitaciones_adjudicadas_informadas']/node()"/>';
			var TitRestoLic='<xsl:value-of select="document($doc)/translation/texts/item[@name='Resto_licitaciones']/node()"/>';
			var TitRestoLic='<xsl:value-of select="document($doc)/translation/texts/item[@name='Resto_licitaciones']/node()"/>';
			var txtLicInformadas='<xsl:value-of select="document($doc)/translation/texts/item[@name='Licitaciones_informadas']/node()"/>';
			var txtLicNoInformadas='<xsl:value-of select="document($doc)/translation/texts/item[@name='Licitaciones_no_informadas']/node()"/>';
			var txtLicAdjudicadas='<xsl:value-of select="document($doc)/translation/texts/item[@name='Licitaciones_adjudicadas']/node()"/>';
			var txtLicNoAdjudicadas='<xsl:value-of select="document($doc)/translation/texts/item[@name='Licitaciones_no_adjudicadas']/node()"/>';

		</script>
	</head>
	<body onload="javascript:inicio();">	
      
       <!--idioma-->
		<xsl:variable name="lang">
        <xsl:choose>
            <xsl:when test="/EvaluacionProveedor/LANG"><xsl:value-of select="/EvaluacionProveedor/LANG" /></xsl:when>
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

		<!--	Titulo de la pagina		-->
		<div class="ZonaTituloPagina">
			<p class="Path"><xsl:value-of select="document($doc)/translation/texts/item[@name='Inicio']/node()"/>&nbsp;/&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Proveedores']/node()"/>&nbsp;/&nbsp;<span class="FinPath"><xsl:value-of select="document($doc)/translation/texts/item[@name='indicadores_proveedores']/node()"/></span></p>
			<p class="TituloPagina">
        		<xsl:value-of select="document($doc)/translation/texts/item[@name='indicadores_proveedores']/node()"/>
				<span class="CompletarTitulo" style="width:900px">
					<xsl:if test="not (/EvaluacionProveedor/INDICADORES/SIN_CABECERA='S')">
					<!--<a class="btnNormal" href="http://www.newco.dev.br/Gestion/EIS/ClasificacionProveedoresEIS.xsql">-->
					<a class="btnNormal" href="javascript:Indicadores();">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='indicadores_proveedores']/node()"/>
					</a>&nbsp;
					<a class="btnNormal" href="javascript:Clasificacion();">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='clasificacion_proveedores']/node()"/>
					</a>&nbsp;
					<!--<a class="btnNormal" href="http://www.newco.dev.br/Gestion/Comercial/CondicionesProveedores.xsql">-->
					<a class="btnNormal" href="javascript:Condiciones();">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='condiciones_proveedores']/node()"/>
					</a>&nbsp;
					<a class="btnNormal" href="javascript:window.print();" style="text-decoration:none;" title="Imprimir">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='imprimir']/node()"/>
					</a>&nbsp;
					</xsl:if>
				</span>
			</p>
		</div>
		<br/>
		<br/>
		<br/>
		<br/>

        <div class="divLeft" id="Cabecera" style="align:left;margin-left:100px">
			<img src="{/EvaluacionProveedor/INDICADORES/URL_LOGOTIPO}" style="max-height:100px;max-width:300px;"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<span style="font-size:16px;"><xsl:value-of select="document($doc)/translation/texts/item[@name='periodo']/node()"/>:&nbsp;<xsl:value-of select="/EvaluacionProveedor/INDICADORES/FECHA_INICIO"/>&nbsp;-&nbsp;<xsl:value-of select="/EvaluacionProveedor/INDICADORES/FECHA_FINAL"/></span>
			<br/>
			<br/>
        </div>

        <div class="divLeft" style="align:left;margin-left:100px">
		<form name="frmFiltro" id="frmFiltro" method="post" action="http://www.newco.dev.br/Gestion/EIS/EvaluacionProveedor.xsql">        
        <table id="PestanasInicio" border="0" >
            <tr style="font-size:15px;text-align:left;">
				<th>
				<xsl:choose>
				<xsl:when test="/EvaluacionProveedor/INDICADORES/CLIENTE/field">
				&nbsp;&nbsp;&nbsp;<strong><xsl:value-of select="document($doc)/translation/texts/item[@name='cliente']/node()"/>:</strong>&nbsp;
				<xsl:call-template name="desplegable">
					<xsl:with-param name="path" select="/EvaluacionProveedor/INDICADORES/CLIENTE/field"/>
					<xsl:with-param name="style">height:25px;width:250px;font-size:15px;</xsl:with-param>
				</xsl:call-template>
				</xsl:when>
				<xsl:otherwise><input type="hidden" name="IDCLIENTE" value="{/EvaluacionProveedor/INDICADORES/IDEMPRESA}"/></xsl:otherwise>
				</xsl:choose>
				
				<xsl:choose>
				<xsl:when test="/EvaluacionProveedor/INDICADORES/CENTROCLIENTE/field">
				&nbsp;&nbsp;&nbsp;<strong><xsl:value-of select="document($doc)/translation/texts/item[@name='centro']/node()"/>:</strong>&nbsp;
				<xsl:call-template name="desplegable">
					<xsl:with-param name="path" select="/EvaluacionProveedor/INDICADORES/CENTROCLIENTE/field"/>
					<xsl:with-param name="style">height:25px;width:250px;font-size:15px;</xsl:with-param>
				</xsl:call-template>
				</xsl:when>
				<xsl:otherwise><input type="hidden" name="IDCENTROCLIENTE" value="{/EvaluacionProveedor/INDICADORES/IDCENTRO}"/></xsl:otherwise>
				</xsl:choose>
				&nbsp;&nbsp;&nbsp;
				<br/><br/>
				<xsl:choose>
				<xsl:when test="not (/EvaluacionProveedor/INDICADORES/SIN_CABECERA='S')">
					&nbsp;<strong><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/>:</strong>&nbsp;
					<xsl:call-template name="desplegable">
						<xsl:with-param name="path" select="/EvaluacionProveedor/INDICADORES/IDPROVEEDOR/field"/>
						<xsl:with-param name="style">height:25px;width:250px;font-size:15px;</xsl:with-param>
						<xsl:with-param name="onChange">javascript:CambioProveedorActual();</xsl:with-param>
					</xsl:call-template>
					&nbsp;
					<xsl:if test="/EvaluacionProveedor/INDICADORES/IDPROVEEDOR!=-1">
						<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPDetalleFrame.xsql?EMP_ID={/EvaluacionProveedor/INDICADORES/IDPROVEEDOR}&amp;VENTANA=NUEVA','DetalleEmpresa',100,58,0,-50)"><xsl:value-of select="document($doc)/translation/texts/item[@name='ver']/node()"/></a>
					</xsl:if>
					&nbsp;&nbsp;&nbsp;
				</xsl:when>
				<xsl:otherwise>
					<input type="hidden" name="IDPROVEEDOR" id="IDPROVEEDOR" value="{/EvaluacionProveedor/INDICADORES/IDPROVEEDOR}"/>
				</xsl:otherwise>
				</xsl:choose>
				<strong><xsl:value-of select="document($doc)/translation/texts/item[@name='periodo']/node()"/>:</strong>&nbsp;
				<xsl:call-template name="desplegable">
					<xsl:with-param name="path" select="/EvaluacionProveedor/INDICADORES/PERIODOS/field"/>
					<xsl:with-param name="style">height:25px;width:150px;font-size:15px;</xsl:with-param>
				</xsl:call-template>
				&nbsp;&nbsp;&nbsp;
				<span class="avanzadas">
				<xsl:if test="/EvaluacionProveedor/INDICADORES/PERIODO!='OTROS'">
					<xsl:attribute name="style">display:none</xsl:attribute>
				</xsl:if>
				<strong><xsl:value-of select="document($doc)/translation/texts/item[@name='de']/node()"/>:</strong>&nbsp;
				<input type="text" name="FECHA_INICIO" id="FECHA_INICIO" style="height:25px;width:90px;font-size:15px;" value="{/EvaluacionProveedor/INDICADORES/FECHA_INICIO}"/>
				&nbsp;&nbsp;&nbsp;
				<strong><xsl:value-of select="document($doc)/translation/texts/item[@name='a']/node()"/>:</strong>&nbsp;
				<input type="text" name="FECHA_FINAL" id="FECHA_FINAL" style="height:25px;width:90px;font-size:15px;" value="{/EvaluacionProveedor/INDICADORES/FECHA_FINAL}"/>
				&nbsp;&nbsp;&nbsp;
				<a class="btnDestacado" href="javascript:Buscar();" style="text-decoration:none;">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='buscar']/node()"/>
				</a>&nbsp;
				&nbsp;&nbsp;&nbsp;
				</span>
				</th>
            </tr>
        </table>
 		</form>
		</div>

        <div class="divLeft" id="TablaPedidos" style="align:left;margin-left:100px">
			<br/>
			<br/>
			<br/>
			<br/>
			<table class="buscador" style="width:450px;">
			<tr class="sinLinea" style="height:20px;"><td class="textLeft" style="font-size:15px;" colspan="2"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='Nota_final']/node()"/>:&nbsp;<xsl:value-of select="/EvaluacionProveedor/INDICADORES/NOTAS/NOTA_FINAL" />/100</strong></td></tr>
			<tr class="sinLinea" style="height:20px;"><td class="labelLeft" style="font-size:15px;width=250px;"><xsl:value-of select="document($doc)/translation/texts/item[@name='Nota_Pedidos']/node()"/></td><td class="textRight" style="font-size:15px;"><xsl:value-of select="/EvaluacionProveedor/INDICADORES/NOTAS/NOTA_PEDIDOS" />/<xsl:value-of select="/EvaluacionProveedor/INDICADORES/NOTAS/PORC_PEDIDOS" /></td></tr>
			<tr class="sinLinea" style="height:20px;"><td class="labelLeft" style="font-size:15px;"><xsl:value-of select="document($doc)/translation/texts/item[@name='Nota_Retrasos']/node()"/></td><td class="textRight" style="font-size:15px;"><xsl:value-of select="/EvaluacionProveedor/INDICADORES/NOTAS/NOTA_RETRASOS" />/<xsl:value-of select="/EvaluacionProveedor/INDICADORES/NOTAS/PORC_RETRASOS" /></td></tr>
			<tr class="sinLinea" style="height:20px;"><td class="labelLeft" style="font-size:15px;"><xsl:value-of select="document($doc)/translation/texts/item[@name='Nota_Incidencias']/node()"/></td><td class="textRight" style="font-size:15px;"><xsl:value-of select="/EvaluacionProveedor/INDICADORES/NOTAS/NOTA_INCIDENCIAS" />/<xsl:value-of select="/EvaluacionProveedor/INDICADORES/NOTAS/PORC_INCIDENCIAS" /></td></tr>
			<tr class="sinLinea" style="height:20px;"><td class="labelLeft" style="font-size:15px;"><xsl:value-of select="document($doc)/translation/texts/item[@name='Nota_Roturas']/node()"/></td><td class="textRight" style="font-size:15px;"><xsl:value-of select="/EvaluacionProveedor/INDICADORES/NOTAS/NOTA_ROTURAS" />/<xsl:value-of select="/EvaluacionProveedor/INDICADORES/NOTAS/PORC_ROTURAS" /></td></tr>
			<tr class="sinLinea" style="height:20px;"><td class="labelLeft" style="font-size:15px;"><xsl:value-of select="document($doc)/translation/texts/item[@name='Nota_Licitaciones']/node()"/></td><td class="textRight" style="font-size:15px;"><xsl:value-of select="/EvaluacionProveedor/INDICADORES/NOTAS/NOTA_LICITACIONES" />/<xsl:value-of select="/EvaluacionProveedor/INDICADORES/NOTAS/PORC_LICITACIONES" /></td></tr>
			</table>
			<br/>
			<br/>
        </div>

        <div class="divLeft" id="TablaPedidos" style="align:left;margin-left:100px">
			<table class="buscador" style="width:550px;">
			<tr class="sinLinea" style="height:20px;"><td class="textLeft" style="font-size:15px;" colspan="2"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='Resumen']/node()"/></strong></td></tr>
			<tr class="sinLinea" style="height:20px;"><td class="labelLeft" style="font-size:15px;width=250px;"><xsl:value-of select="document($doc)/translation/texts/item[@name='eis_importe_pedidos']/node()"/></td><td class="textRight" style="font-size:15px;width=150px;"><xsl:value-of select="/EvaluacionProveedor/INDICADORES/PEDIDOS/IMPORTE_FORMATO" /></td></tr>
			<tr class="sinLinea" style="height:20px;"><td class="labelLeft" style="font-size:15px;"><xsl:value-of select="document($doc)/translation/texts/item[@name='eis_numero_pedidos']/node()"/></td><td class="textRight" style="font-size:15px;"><xsl:value-of select="/EvaluacionProveedor/INDICADORES/PEDIDOS/TOTAL" /></td></tr>
			<tr class="sinLinea" style="height:20px;"><td class="labelLeft" style="font-size:15px;"><xsl:value-of select="document($doc)/translation/texts/item[@name='Pedidos_puntuales']/node()"/></td><td class="textRight" style="font-size:15px;"><xsl:value-of select="/EvaluacionProveedor/INDICADORES/PEDIDOS/PUNTUALES" /></td><td class="textRight" style="font-size:15px;"><xsl:value-of select="/EvaluacionProveedor/INDICADORES/PEDIDOS/PUNTUALES_PORC" />%</td></tr>
			<tr class="sinLinea" style="height:20px;"><td class="labelLeft" style="font-size:15px;"><xsl:value-of select="document($doc)/translation/texts/item[@name='Pedidos_retrasados']/node()"/></td><td class="textRight" style="font-size:15px;"><xsl:value-of select="/EvaluacionProveedor/INDICADORES/PEDIDOS/RETRASADOS" /></td><td class="textRight" style="font-size:15px;"><xsl:value-of select="/EvaluacionProveedor/INDICADORES/PEDIDOS/RETRASADOS_PORC" />%</td></tr>
			<tr class="sinLinea" style="height:20px;"><td class="labelLeft" style="font-size:15px;"><xsl:value-of select="document($doc)/translation/texts/item[@name='Pedidos_parciales']/node()"/></td><td class="textRight" style="font-size:15px;"><xsl:value-of select="/EvaluacionProveedor/INDICADORES/PEDIDOS/PARCIALES" /></td><td class="textRight" style="font-size:15px;"><xsl:value-of select="/EvaluacionProveedor/INDICADORES/PEDIDOS/PARCIALES_PORC" />%</td></tr>
			<tr class="sinLinea" style="height:20px;"><td class="labelLeft" style="font-size:15px;"><xsl:value-of select="document($doc)/translation/texts/item[@name='reclamaciones']/node()"/></td><td class="textRight" style="font-size:15px;"><xsl:value-of select="/EvaluacionProveedor/INDICADORES/PEDIDOS/RECLAMACIONES" /></td><td class="textRight" style="font-size:15px;"><xsl:value-of select="/EvaluacionProveedor/INDICADORES/PEDIDOS/RECLAMACIONES_PORC" />%</td></tr>
			<tr class="sinLinea" style="height:20px;"><td class="labelLeft" style="font-size:15px;"><xsl:value-of select="document($doc)/translation/texts/item[@name='Pedidos_urgentes']/node()"/></td><td class="textRight" style="font-size:15px;"><xsl:value-of select="/EvaluacionProveedor/INDICADORES/PEDIDOS/URGENTES" /></td><td class="textRight" style="font-size:15px;"><xsl:value-of select="/EvaluacionProveedor/INDICADORES/PEDIDOS/URGENTES_PORC" />%</td></tr>
			</table>
			<br/>
			<br/>
        </div>
		
        <div class="divLeft" id="TablaTiempos" style="align:left;margin-left:100px">
			<table class="buscador" style="width:450px;">
			<tr class="sinLinea" style="height:20px;"><td class="textLeft" style="font-size:15px;" colspan="2"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='Proceso_completo_pedido']/node()"/></strong></td></tr>
			<tr class="sinLinea" style="height:20px;"><td class="labelLeft" style="font-size:15px;width=250px;"><xsl:value-of select="document($doc)/translation/texts/item[@name='Aceptacion']/node()"/></td><td class="textRight" style="font-size:15px;"><xsl:value-of select="/EvaluacionProveedor/INDICADORES/PEDIDOS/TM_ACEPTACION_FORMATO" /></td></tr>
			<tr class="sinLinea" style="height:20px;"><td class="labelLeft" style="font-size:15px;"><xsl:value-of select="document($doc)/translation/texts/item[@name='Preparacion']/node()"/></td><td class="textRight" style="font-size:15px;"><xsl:value-of select="/EvaluacionProveedor/INDICADORES/PEDIDOS/TM_PREPARACION_FORMATO" /></td></tr>
			<tr class="sinLinea" style="height:20px;"><td class="labelLeft" style="font-size:15px;"><xsl:value-of select="document($doc)/translation/texts/item[@name='Transporte']/node()"/></td><td class="textRight" style="font-size:15px;"><xsl:value-of select="/EvaluacionProveedor/INDICADORES/PEDIDOS/TM_TRANSPORTE_FORMATO" /></td></tr>
			<tr class="sinLinea" style="height:20px;"><td class="labelLeft" style="font-size:15px;"><xsl:value-of select="document($doc)/translation/texts/item[@name='retraso']/node()"/></td><td class="textRight" style="font-size:15px;"><xsl:value-of select="/EvaluacionProveedor/INDICADORES/PEDIDOS/TM_RETRASO_FORMATO" /></td></tr>
			</table>
			<br/>
			<br/>
        </div>

        <div class="divLeft" id="TablaRetrasos" style="align:left;margin-left:100px">
			<table class="buscador" style="width:450px;">
			<tr class="sinLinea" style="height:20px;"><td class="textLeft" style="font-size:15px;" colspan="2"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='Analisis_retraso_pedidos']/node()"/></strong></td></tr>
			<tr class="sinLinea" style="height:20px;"><td class="labelLeft" style="font-size:15px;width=250px;"><xsl:value-of select="document($doc)/translation/texts/item[@name='Pedidos_retrasados_1dia']/node()"/></td><td class="textRight" style="font-size:15px;"><xsl:value-of select="/EvaluacionProveedor/INDICADORES/PEDIDOS/RETRASADOS1DIA" /></td></tr>
			<tr class="sinLinea" style="height:20px;"><td class="labelLeft" style="font-size:15px;"><xsl:value-of select="document($doc)/translation/texts/item[@name='Pedidos_retrasados_2dias']/node()"/></td><td class="textRight" style="font-size:15px;"><xsl:value-of select="/EvaluacionProveedor/INDICADORES/PEDIDOS/RETRASADOS2DIAS" /></td></tr>
			<tr class="sinLinea" style="height:20px;"><td class="labelLeft" style="font-size:15px;"><xsl:value-of select="document($doc)/translation/texts/item[@name='Pedidos_retrasados_3dias']/node()"/></td><td class="textRight" style="font-size:15px;"><xsl:value-of select="/EvaluacionProveedor/INDICADORES/PEDIDOS/RETRASADOS3DIAS" /></td></tr>
			<tr class="sinLinea" style="height:20px;"><td class="labelLeft" style="font-size:15px;"><xsl:value-of select="document($doc)/translation/texts/item[@name='Pedidos_retrasados_4dias']/node()"/></td><td class="textRight" style="font-size:15px;"><xsl:value-of select="/EvaluacionProveedor/INDICADORES/PEDIDOS/RETRASADOS4DIAS" /></td></tr>
			<tr class="sinLinea" style="height:20px;"><td class="labelLeft" style="font-size:15px;"><xsl:value-of select="document($doc)/translation/texts/item[@name='Pedidos_retrasados_5dias_omas']/node()"/></td><td class="textRight" style="font-size:15px;"><xsl:value-of select="/EvaluacionProveedor/INDICADORES/PEDIDOS/RETRASADOS5DIASOMAS" /></td></tr>
			</table>
			<br/>
			<br/>
        </div>

        <div class="divLeft" id="TablaRetrasos" style="align:left;margin-left:100px">
			<table class="buscador" style="width:450px;">
			<tr class="sinLinea" style="height:20px;"><td class="textLeft" style="font-size:15px;" colspan="2"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='licitaciones']/node()"/></strong></td></tr>
			<tr class="sinLinea" style="height:20px;"><td class="labelLeft" style="font-size:15px;width=250px;"><xsl:value-of select="document($doc)/translation/texts/item[@name='Licitaciones_informadas']/node()"/></td><td class="textRight" style="font-size:15px;"><xsl:value-of select="/EvaluacionProveedor/INDICADORES/LICITACIONES/INFORMADAS" /></td></tr>
			<tr class="sinLinea" style="height:20px;"><td class="labelLeft" style="font-size:15px;"><xsl:value-of select="document($doc)/translation/texts/item[@name='Licitaciones_no_informadas']/node()"/></td><td class="textRight" style="font-size:15px;"><xsl:value-of select="/EvaluacionProveedor/INDICADORES/LICITACIONES/NOOFERTADAS" /></td></tr>
			<tr class="sinLinea" style="height:20px;"><td class="labelLeft" style="font-size:15px;"><xsl:value-of select="document($doc)/translation/texts/item[@name='Licitaciones_adjudicadas']/node()"/></td><td class="textRight" style="font-size:15px;"><xsl:value-of select="/EvaluacionProveedor/INDICADORES/LICITACIONES/ADJUDICADAS" /></td></tr>
			</table>
			<br/>
			<br/>
        </div>

        <div id="divMostraPedidos" style="align:left;margin-left:100px;display:none">
			<a href="javascript:MostrarPedidos();" class="btnNormal"><xsl:value-of select="document($doc)/translation/texts/item[@name='Pedidos']/node()"/></a>
        </div>

        <div id="divTodosPedidos">
			<table class="buscador" style="100%">
			<tr class="subTituloTabla" >
				<td class="dos">&nbsp;<a href="javascript:OcultarPedidos();"><xsl:value-of select="document($doc)/translation/texts/item[@name='ocultar']/node()"/></a></td>
				<td class="cinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='Codigo']/node()"/></td>
				<td class="textLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='cliente']/node()"/></td>
				<td class="textLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/></td>
				<td class="cinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_pedido']/node()"/></td>
				<td class="cinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='Fecha_acep']/node()"/></td>
				<td class="cinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='Fecha_envio']/node()"/></td>
				<td class="cinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_entrega_prevista']/node()"/></td>
				<td class="cinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_entrega_real']/node()"/></td>
				<td class="cinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='urgente']/node()"/></td>
				<td class="cinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='retrasado']/node()"/></td>
				<td class="cinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='parcial']/node()"/></td>
				<td class="cinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='reclamaciones']/node()"/></td>
				<td class="cinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='importe']/node()"/></td>
				<td class="dos">&nbsp;</td>
			</tr>
			<xsl:for-each select="/EvaluacionProveedor/INDICADORES/PEDIDOS/PEDIDO">
				<tr class="sinLinea">
					<td>&nbsp;</td>
					<td><xsl:value-of select="CODIGO"/></td>
					<td class="textLeft"><xsl:value-of select="CENTROCLIENTE"/></td>
					<td class="textLeft"><xsl:value-of select="PROVEEDOR"/></td>
					<td><xsl:value-of select="MO_FECHA"/></td>
					<td><xsl:value-of select="PED_FECHAACEPTACION"/></td>
					<td><xsl:value-of select="PED_FECHAENVIOPROVEEDOR"/></td>
					<td><xsl:value-of select="PED_FECHAENTREGA"/></td>
					<td><xsl:value-of select="PED_FECHAENTREGAREAL"/></td>
					<td><xsl:value-of select="MO_URGENCIA"/></td>
					<td><xsl:value-of select="PED_RETRASOACUMULADO"/></td>
					<td><xsl:value-of select="PED_ENTREGADOPARCIAL"/></td>
					<td><xsl:value-of select="NUMERO_RECLAMACIONES"/></td>
					<td class="textRight"><strong><xsl:value-of select="IMPORTE_FORMATO"/></strong>&nbsp;</td>
					<td>&nbsp;</td>
				</tr>
			</xsl:for-each>
			</table>
        </div>
        </xsl:otherwise>
      </xsl:choose>
      <br/>    
    </body>
  </html>
</xsl:template>

  <xsl:template match="Sorry">
    <xsl:apply-templates select="Noticias/ROW/Sorry"/>
  </xsl:template>
</xsl:stylesheet>
