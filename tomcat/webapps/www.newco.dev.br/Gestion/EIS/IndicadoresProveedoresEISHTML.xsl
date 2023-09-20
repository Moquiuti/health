<?xml version="1.0" encoding="iso-8859-1"?>
<!--
	Clasificacion proveedores
	Ultima revisión: ET 28abr20 09:30 IndicadoresProveedoresEIS_190421.js
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
        	<xsl:value-of select="/IndicadoresProveedores/LANG" />
        </xsl:variable>
        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
         <!--fin idioma-->
		<title>
			<xsl:value-of select="/IndicadoresProveedores/INDICADORES/EMPRESAUSUARIO"/>:&nbsp;
			<xsl:value-of select="document($doc)/translation/texts/item[@name='indicadores_proveedores']/node()"/>
		</title>
       
<!--
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1"/>
 		<META HTTP-EQUIV="Pragma" CONTENT="no-caché"/>
		<META HTTP-EQUIV="expired" CONTENT="01-Mar-94 00:00:01 GMT"/> 	
		<meta content="ALL" name="ROBOTS"/>	
-->
		<link rel="shortcut icon" href="http://www.newco.dev.br/images/MedicalVM.ico"/>

		<!--style-->
		<xsl:call-template name="estiloIndip"/>
		<!--fin de style-->

		<script type="text/javascript" src="http://www.newco.dev.br/General/jquery-1.8.3.min.js"></script>
		<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>
		<script type="text/javascript" src="http://www.newco.dev.br/General/descargas_151117.js"></script>
		<script type="text/javascript" src="http://www.newco.dev.br/General/Chart.bundle.min.2.9.3.js"></script>
		<script type="text/javascript" src="http://www.newco.dev.br/Gestion/EIS/IndicadoresProveedoresEIS_190421.js"></script>
		<script type="text/javascript">
			var IDFiltroProveedor=<xsl:value-of select="/IndicadoresProveedores/INDICADORES/IDPROVEEDOR" />;

			//	Valores
			var TotalPedidos=<xsl:value-of select="/IndicadoresProveedores/INDICADORES/PEDIDOS/TOTAL" />;
			var PedPendientes=<xsl:value-of select="/IndicadoresProveedores/INDICADORES/PEDIDOS/PENDIENTES" />;
			var PedPuntuales=<xsl:value-of select="/IndicadoresProveedores/INDICADORES/PEDIDOS/PUNTUALES" />;
			var PedRetrasados=<xsl:value-of select="/IndicadoresProveedores/INDICADORES/PEDIDOS/RETRASADOS" />;
			
			var PedRetrasados1dia=<xsl:value-of select="/IndicadoresProveedores/INDICADORES/PEDIDOS/RETRASADOS1DIA" />;
			var PedRetrasados2dias=<xsl:value-of select="/IndicadoresProveedores/INDICADORES/PEDIDOS/RETRASADOS2DIAS" />;
			var PedRetrasados3dias=<xsl:value-of select="/IndicadoresProveedores/INDICADORES/PEDIDOS/RETRASADOS3DIAS" />;
			var PedRetrasados4dias=<xsl:value-of select="/IndicadoresProveedores/INDICADORES/PEDIDOS/RETRASADOS4DIAS" />;
			var PedRetrasados5diasOMas=<xsl:value-of select="/IndicadoresProveedores/INDICADORES/PEDIDOS/RETRASADOS5DIASOMAS" />;

			var PedParciales=<xsl:value-of select="/IndicadoresProveedores/INDICADORES/PEDIDOS/PARCIALES" />;
			var PedUrgentes=<xsl:value-of select="/IndicadoresProveedores/INDICADORES/PEDIDOS/URGENTES" />;
			var TMAprobacion=<xsl:value-of select="/IndicadoresProveedores/INDICADORES/PEDIDOS/TM_APROBACION" />;
			var TMAceptacion=<xsl:value-of select="/IndicadoresProveedores/INDICADORES/PEDIDOS/TM_ACEPTACION" />;
			var TMPreparacion=<xsl:value-of select="/IndicadoresProveedores/INDICADORES/PEDIDOS/TM_PREPARACION" />;
			var TMTransporte=<xsl:value-of select="/IndicadoresProveedores/INDICADORES/PEDIDOS/TM_TRANSPORTE" />;
			var TMRetraso=<xsl:value-of select="/IndicadoresProveedores/INDICADORES/PEDIDOS/TM_RETRASO" />;

			var TMLicitacion=<xsl:value-of select="/IndicadoresProveedores/INDICADORES/LICITACIONES/TIEMPOMEDIO" />;

			var LicTotal=<xsl:value-of select="/IndicadoresProveedores/INDICADORES/LICITACIONES/TOTAL" />;
			var LicProveedores=<xsl:value-of select="/IndicadoresProveedores/INDICADORES/LICITACIONES/PROVEEDORES" />;
			var LicProveedoresInf=<xsl:value-of select="/IndicadoresProveedores/INDICADORES/LICITACIONES/PROVEEDORES_INF" />;
			var LicProveedoresAdj=<xsl:value-of select="/IndicadoresProveedores/INDICADORES/LICITACIONES/PROVEEDORES_ADJ" />;
			var LicMenosDe3Dias=<xsl:value-of select="/IndicadoresProveedores/INDICADORES/LICITACIONES/LIC_MENOS_DE_3DIAS" />;
			var LicMasDe7Dias=<xsl:value-of select="/IndicadoresProveedores/INDICADORES/LICITACIONES/LIC_MAS_DE_7DIAS" />;

			var TMEstudioPrevio=<xsl:value-of select="/IndicadoresProveedores/INDICADORES/LICITACIONES/TM_ESTUDIOPREVIO" />;
			var TMOfertas=<xsl:value-of select="/IndicadoresProveedores/INDICADORES/LICITACIONES/TM_OFERTAS" />;
			var TMAdjudicacion=<xsl:value-of select="/IndicadoresProveedores/INDICADORES/LICITACIONES/TM_ADJUDICACION" />;
			var TMPedidos=<xsl:value-of select="/IndicadoresProveedores/INDICADORES/LICITACIONES/TM_PEDIDOS" />;

			//	Datos especificos de proveedor
			var TOferta1dia=<xsl:value-of select="/IndicadoresProveedores/INDICADORES/LICITACIONES/OFERTAS1DIA" />;
			var TOferta2dias=<xsl:value-of select="/IndicadoresProveedores/INDICADORES/LICITACIONES/OFERTAS2DIAS" />;
			var TOferta3dias=<xsl:value-of select="/IndicadoresProveedores/INDICADORES/LICITACIONES/OFERTAS3DIAS" />;
			var TOferta4dias=<xsl:value-of select="/IndicadoresProveedores/INDICADORES/LICITACIONES/OFERTAS4DIAS" />;
			var TOferta4diasOMas=<xsl:value-of select="/IndicadoresProveedores/INDICADORES/LICITACIONES/OFERTAS4DIASOMAS" />;

			var NumLicInformadas=<xsl:value-of select="/IndicadoresProveedores/INDICADORES/LICITACIONES/INFORMADAS" />;
			var NumLicAdjudicadas=<xsl:value-of select="/IndicadoresProveedores/INDICADORES/LICITACIONES/ADJUDICADAS" />;
			var NumLicNoInformadas=<xsl:value-of select="/IndicadoresProveedores/INDICADORES/LICITACIONES/NOOFERTADAS" />;

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
            <xsl:when test="/IndicadoresProveedores/LANG"><xsl:value-of select="/IndicadoresProveedores/LANG" /></xsl:when>
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
					<xsl:if test="not (/IndicadoresProveedores/INDICADORES/SIN_CABECERA='S')">
					<a class="btnNormal" href="javascript:Evaluacion();">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='evaluacion_proveedor']/node()"/>
					</a>&nbsp;
					<a class="btnNormal" href="javascript:Clasificacion();">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='clasificacion_proveedores']/node()"/>
					</a>&nbsp;
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

        <div class="divLeft">
		<form name="frmFiltro" id="frmFiltro" method="post" action="http://www.newco.dev.br/Gestion/EIS/IndicadoresProveedoresEIS.xsql">        
        <table id="PestanasInicio" border="0" >
            <tr style="font-size:15px;text-align:left;">
				<th>
				<xsl:choose>
				<xsl:when test="/IndicadoresProveedores/INDICADORES/CLIENTE/field">
				&nbsp;&nbsp;&nbsp;<strong><xsl:value-of select="document($doc)/translation/texts/item[@name='cliente']/node()"/>:</strong>&nbsp;
				<xsl:call-template name="desplegable">
					<xsl:with-param name="path" select="/IndicadoresProveedores/INDICADORES/CLIENTE/field"/>
					<xsl:with-param name="style">height:25px;width:250px;font-size:15px;</xsl:with-param>
				</xsl:call-template>
				</xsl:when>
				<xsl:otherwise><input type="hidden" name="IDCLIENTE" value="{/IndicadoresProveedores/INDICADORES/IDEMPRESA}"/></xsl:otherwise>
				</xsl:choose>
				
				<xsl:choose>
				<xsl:when test="/IndicadoresProveedores/INDICADORES/CENTROCLIENTE/field">
				&nbsp;&nbsp;&nbsp;<strong><xsl:value-of select="document($doc)/translation/texts/item[@name='centro']/node()"/>:</strong>&nbsp;
				<xsl:call-template name="desplegable">
					<xsl:with-param name="path" select="/IndicadoresProveedores/INDICADORES/CENTROCLIENTE/field"/>
					<xsl:with-param name="style">height:25px;width:250px;font-size:15px;</xsl:with-param>
				</xsl:call-template>
				</xsl:when>
				<xsl:otherwise><input type="hidden" name="IDCENTROCLIENTE" value="{/IndicadoresProveedores/INDICADORES/IDCENTRO}"/></xsl:otherwise>
				</xsl:choose>
				&nbsp;&nbsp;&nbsp;
				<br/><br/>
				<xsl:choose>
				<xsl:when test="not (/IndicadoresProveedores/INDICADORES/SIN_CABECERA='S')">
					&nbsp;<strong><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/>:</strong>&nbsp;
					<xsl:call-template name="desplegable">
						<xsl:with-param name="path" select="/IndicadoresProveedores/INDICADORES/IDPROVEEDOR/field"/>
						<xsl:with-param name="style">height:25px;width:250px;font-size:15px;</xsl:with-param>
						<xsl:with-param name="onChange">javascript:CambioProveedorActual();</xsl:with-param>
					</xsl:call-template>
					&nbsp;
					<xsl:if test="/IndicadoresProveedores/INDICADORES/IDPROVEEDOR!=-1">
						<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPDetalleFrame.xsql?EMP_ID={/IndicadoresProveedores/INDICADORES/IDPROVEEDOR}&amp;VENTANA=NUEVA','DetalleEmpresa',100,58,0,-50)"><xsl:value-of select="document($doc)/translation/texts/item[@name='ver']/node()"/></a>
					</xsl:if>
					&nbsp;&nbsp;&nbsp;
				</xsl:when>
				<xsl:otherwise>
					<input type="hidden" name="IDPROVEEDOR" id="IDPROVEEDOR" value="{/IndicadoresProveedores/INDICADORES/IDPROVEEDOR}"/>
				</xsl:otherwise>
				</xsl:choose>
				<strong><xsl:value-of select="document($doc)/translation/texts/item[@name='periodo']/node()"/>:</strong>&nbsp;
				<xsl:call-template name="desplegable">
					<xsl:with-param name="path" select="/IndicadoresProveedores/INDICADORES/PERIODOS/field"/>
					<xsl:with-param name="style">height:25px;width:150px;font-size:15px;</xsl:with-param>
				</xsl:call-template>
				&nbsp;&nbsp;&nbsp;
				<span class="avanzadas">
				<xsl:if test="/IndicadoresProveedores/INDICADORES/PERIODO!='OTROS'">
					<xsl:attribute name="style">display:none</xsl:attribute>
				</xsl:if>
				<strong><xsl:value-of select="document($doc)/translation/texts/item[@name='de']/node()"/>:</strong>&nbsp;
				<input type="text" name="FECHA_INICIO" id="FECHA_INICIO" style="height:25px;width:90px;font-size:15px;" value="{/IndicadoresProveedores/INDICADORES/FECHA_INICIO}"/>
				&nbsp;&nbsp;&nbsp;
				<strong><xsl:value-of select="document($doc)/translation/texts/item[@name='a']/node()"/>:</strong>&nbsp;
				<input type="text" name="FECHA_FINAL" id="FECHA_FINAL" style="height:25px;width:90px;font-size:15px;" value="{/IndicadoresProveedores/INDICADORES/FECHA_FINAL}"/>
				&nbsp;&nbsp;&nbsp;
				<a class="btnDestacado" href="javascript:Buscar();" style="text-decoration:none;">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='buscar']/node()"/>
				</a>&nbsp;
				&nbsp;&nbsp;&nbsp;
				</span>
				<a class="btnNormal" href="javascript:OtraVentana();" style="text-decoration:none;">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='Otra_ventana']/node()"/>
				</a>&nbsp;
				</th>
            </tr>
        </table>
 		</form>
		</div>
		<br/>
		<br/>
		<br/>

		
        <div class="divLeft">
			<table id="Grafico" width="100%" class="blanco" border="0" align="center" cellspacing="1" cellpadding="1">
				<tr>
					<td align="center" colspan="2">
    					<div class="container" style="width:600px;height:300px;">
        					<canvas id="cvGrafProcesoCompra" style="width:600px;height:300px;"></canvas>
    					</div>
					</td>
					<td align="center" colspan="2">
    					<div class="container" style="width:600px;height:300px;">
        					<canvas id="cvGraficoProcesoLicitacion" style="width:600px;height:300px;"></canvas>
    					</div>
					</td>
				</tr>
				<tr>
					<td align="center">
    					<div class="container" style="width:300px;height:300px;">
        					<canvas id="cvGrafico1" style="width:300px;height:300px;"></canvas>
    					</div>
					</td>
					<td align="center">
    					<div class="container" style="width:300px;height:300px;">
        					<canvas id="cvGrafico2" style="width:300px;height:300px;"></canvas>
    					</div>
					</td>
					<td align="center">
    					<div class="container" style="width:300px;height:300px;">
        					<canvas id="cvGrafico3" style="width:300px;height:300px;"></canvas>
    					</div>
					</td>
					<td align="center">
    					<div class="container" style="width:300px;height:300px;">
        					<canvas id="cvGrafico4" style="width:300px;height:300px;"></canvas>
    					</div>
					</td>
				</tr>
				<tr>
					<td align="center">
    					<div class="container" style="width:300px;height:300px;">
        					<canvas id="cvGrafico5" style="width:300px;height:300px;"></canvas>
    					</div>
					</td>
					<td align="center">
    					<div class="container" style="width:300px;height:300px;">
        					<canvas id="cvGrafico6" style="width:300px;height:300px;"></canvas>
    					</div>
					</td>
					<td align="center">
    					<div class="container" style="width:300px;height:300px;">
        					<canvas id="cvGrafico7" style="width:300px;height:300px;"></canvas>
    					</div>
					</td>
					<td align="center">
    					<div class="container" style="width:300px;height:300px;">
        					<canvas id="cvGrafico8" style="width:300px;height:300px;"></canvas>
    					</div>
					</td>
				</tr>
			</table>
        </div>
       
       <p>&nbsp;</p>
       <p>&nbsp;</p>
    
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
