<?xml version="1.0" encoding="iso-8859-1"?>
<!--
	Clasificacion proveedores
	Ultima revisión: ET 15set20 09:00 ClasificacionProveedoresEIS_150920.js
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
        	<xsl:value-of select="/ClasificacionProveedores/LANG" />
        </xsl:variable>
        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
         <!--fin idioma-->
		<title>
			<xsl:value-of select="/ClasificacionProveedores/RESUMENPROVEEDORES/CLIENTE"/>:&nbsp;
			<xsl:value-of select="document($doc)/translation/texts/item[@name='clasificacion_proveedores']/node()"/>
		</title>
       
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1"/>
 		<META HTTP-EQUIV="Pragma" CONTENT="no-caché"/>
		<META HTTP-EQUIV="expired" CONTENT="01-Mar-94 00:00:01 GMT"/> 	
		<meta content="ALL" name="ROBOTS"/>	

		<META name="description" content="Medical Virtual Market es la mayor central de compras virtual para las empresas del sector sanitario español."/> 
		<link rel="shortcut icon" href="http://www.newco.dev.br/images/MedicalVM.ico"/>

		<!--style-->
		<xsl:call-template name="estiloIndip"/>
		<!--fin de style-->

		<script type="text/javascript">
			var Empresa='<xsl:value-of select="/ClasificacionProveedores/RESUMENPROVEEDORES/CLIENTE" disable-output-escaping="yes"/>';
		</script>
		<script type="text/javascript" src="http://www.newco.dev.br/General/jquery-1.8.3.min.js"></script>
		<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>
		<script type="text/javascript" src="http://www.newco.dev.br/General/descargas_151117.js"></script>
		<script type="text/javascript" src="http://www.newco.dev.br/Gestion/EIS/ClasificacionProveedoresEIS_150920.js"></script>
		
	</head>
	<body>	
      
       <!--idioma-->
		<xsl:variable name="lang">
        <xsl:choose>
            <xsl:when test="/ClasificacionProveedores/LANG"><xsl:value-of select="/ClasificacionProveedores/LANG" /></xsl:when>
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
		
    <!--proveedores-->

		<!--	Titulo de la pagina		-->
		<div class="ZonaTituloPagina">
			<p class="Path"><xsl:value-of select="document($doc)/translation/texts/item[@name='Inicio']/node()"/>&nbsp;/&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Proveedores']/node()"/>&nbsp;/&nbsp;<span class="FinPath"><xsl:value-of select="document($doc)/translation/texts/item[@name='clasificacion_proveedores']/node()"/></span></p>
			<p class="TituloPagina">
        		<xsl:value-of select="document($doc)/translation/texts/item[@name='clasificacion_proveedores']/node()"/>
				<span class="CompletarTitulo">
					<!--<a class="btnNormal" href="javascript:DescargarExcel();"><img src="http://www.newco.dev.br/images/iconoExcel.gif" alt="Descargar Excel"/></a>-->
					<a class="btnNormal" href="javascript:DescargarExcel();"><img src="http://www.newco.dev.br/images/iconoExcel.gif" alt="Descargar Excel"/></a>&nbsp;
					<a class="btnNormal" href="javascript:window.print();" style="text-decoration:none;" title="Imprimir">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='imprimir']/node()"/>
					</a>&nbsp;
					<!--<a class="btnNormal" href="http://www.newco.dev.br/Gestion/EIS/IndicadoresProveedoresEIS.xsql">-->
					<a class="btnNormal" href="javascript:Indicadores();">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='indicadores_proveedores']/node()"/>
					</a>&nbsp;
					<!--<a class="btnNormal" href="http://www.newco.dev.br/Gestion/Comercial/CondicionesProveedores.xsql">-->
					<a class="btnNormal" href="javascript:Condiciones();">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='condiciones_proveedores']/node()"/>
					</a>&nbsp;
				</span>
			</p>
		</div>
		<br/>
		<br/>
		<br/>
		<br/>

		<xsl:if test="/ClasificacionProveedores/RESUMENPROVEEDORES/CLIENTE/field">
        <div class="divLeft">
        <table id="PestanasInicio" border="0" >
            <tr style="font-size:15px;">
				<th>
				&nbsp;&nbsp;&nbsp;<strong><xsl:value-of select="document($doc)/translation/texts/item[@name='cliente']/node()"/>:</strong>&nbsp;
				<xsl:call-template name="desplegable">
					<xsl:with-param name="path" select="/ClasificacionProveedores/RESUMENPROVEEDORES/CLIENTE/field"/>
					<xsl:with-param name="style">height:25px;width:300px;font-size:15px;</xsl:with-param>
				</xsl:call-template>&nbsp;&nbsp;&nbsp;
				</th>
            </tr>
        </table>
        </div>
		<br/>
		<br/>
		<br/>
		</xsl:if>
		
		<form name="formProv" id="formProv" method="post" action="http://www.newco.dev.br/Gestion/EIS/ClasificacionProveedoresEIS.xsql">
			<input type="hidden" name="IDPAIS" value="{/ClasificacionProveedores/RESUMENPROVEEDORES/IDPAIS}"/>
			<input type="hidden" name="ORDEN" value="{/ClasificacionProveedores/RESUMENPROVEEDORES/ORDEN}"/>
			<input type="hidden" name="SENTIDO" value="{/ClasificacionProveedores/RESUMENPROVEEDORES/SENTIDO}"/>
			<input type="hidden" name="IDCLIENTE" value="{/ClasificacionProveedores/RESUMENPROVEEDORES/IDCLIENTE}"/>
			<input type="hidden" name="IDSELECCION" value="{/ClasificacionProveedores/RESUMENPROVEEDORES/IDSELECCION}"/>
        
        <div class="divLeft"><!--style="border:1px solid #939494;border-top:0;"-->
		<table class="buscador">
			<tr class="subTituloTabla">
            	<th class="uno">&nbsp;</th>
				<th>
					<a href="javascript:OrdenarPor('DOC');"><xsl:value-of select="document($doc)/translation/texts/item[@name='pos']/node()"/></a>
				</th>
                <th class="textCenter">
					<a href="javascript:OrdenarPor('NOTA');"><xsl:value-of select="document($doc)/translation/texts/item[@name='valoracion']/node()"/></a>
				</th>
                <th style="text-align:left;width:250px;">&nbsp;
					<a href="javascript:OrdenarPor('NOMBRE');"><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/></a>
					&nbsp;&nbsp;<xsl:call-template name="desplegable">
						<xsl:with-param name="path" select="/ClasificacionProveedores/RESUMENPROVEEDORES/FIDSELECCION/field"/>
						<xsl:with-param name="onChange">document.forms['formProv'].submit();</xsl:with-param>
					</xsl:call-template>
				</th>
				<xsl:if test="/ClasificacionProveedores/RESUMENPROVEEDORES/IDPAIS=57">
                <th class="textCenter">
					<a href="javascript:OrdenarPor('FICHA');"><xsl:value-of select="document($doc)/translation/texts/item[@name='Fic.']/node()"/></a>
				</th> 
				<th style="width:2px;">&nbsp;</th>
				</xsl:if>
                <th class="textCenter">
					<a href="javascript:OrdenarPor('PRODADJ');"><xsl:value-of select="document($doc)/translation/texts/item[@name='ProdAdj']/node()"/></a>
				</th>
                <th class="textCenter">
					<a href="javascript:OrdenarPor('NUMDOCS_EMP');"><xsl:value-of select="document($doc)/translation/texts/item[@name='Num_docs_empresa']/node()"/></a>
				</th>
                <th class="textCenter">
					<a href="javascript:OrdenarPor('NUMDOCS_PROD');"><xsl:value-of select="document($doc)/translation/texts/item[@name='Num_docs_prod']/node()"/></a>
				</th>
                <th class="textCenter">
					<a href="javascript:OrdenarPor('PL_ENTR');"><xsl:value-of select="document($doc)/translation/texts/item[@name='pl_entr']/node()"/></a>
				</th>
                <th class="textCenter">
					<a href="javascript:OrdenarPor('PL_ENVIO');"><xsl:value-of select="document($doc)/translation/texts/item[@name='pl_env']/node()"/></a>
				</th>
                <th class="textCenter">
					<a href="javascript:OrdenarPor('INTEGRADO');"><xsl:value-of select="substring(document($doc)/translation/texts/item[@name='integrado']/node(),0,6)"/>.</a>
				</th>
                <th class="textCenter" style="width:140px;"><xsl:value-of select="document($doc)/translation/texts/item[@name='licitaciones']/node()"/><br/>
					<a href="javascript:OrdenarPor('LIC_ADJ');"><xsl:value-of select="document($doc)/translation/texts/item[@name='venc']/node()"/>.</a>/
					<a href="javascript:OrdenarPor('LIC_OFE');"><xsl:value-of select="document($doc)/translation/texts/item[@name='of']/node()"/>.</a>/
					<a href="javascript:OrdenarPor('LIC_TOT');"><xsl:value-of select="document($doc)/translation/texts/item[@name='tot']/node()"/>.</a>
				</th>
                <th class="textCenter" style="width:140px;"><xsl:value-of select="document($doc)/translation/texts/item[@name='licitaciones']/node()"/> (%)<br/>
					<a href="javascript:OrdenarPor('LIC_RAT_GANTOT');"><xsl:value-of select="document($doc)/translation/texts/item[@name='venc']/node()"/>/<xsl:value-of select="document($doc)/translation/texts/item[@name='tot']/node()"/>.</a>&nbsp;/
					<a href="javascript:OrdenarPor('LIC_RAT_GANRESP');"><xsl:value-of select="document($doc)/translation/texts/item[@name='venc']/node()"/>/<xsl:value-of select="document($doc)/translation/texts/item[@name='of']/node()"/>.</a>
					<!--<a href="javascript:OrdenarPor('LIC_RAT_RESPTOT');"><xsl:value-of select="document($doc)/translation/texts/item[@name='of']/node()"/>/<xsl:value-of select="document($doc)/translation/texts/item[@name='tot']/node()"/>.</a>/-->
				</th>
                <th class="textCenter">
					<a href="javascript:OrdenarPor('PED_NUM');"><xsl:value-of select="document($doc)/translation/texts/item[@name='pedidos']/node()"/><br/>(<xsl:value-of select="document($doc)/translation/texts/item[@name='num']/node()"/>)</a>
				</th>
                <th class="textCenter">
					<a href="javascript:OrdenarPor('PED_TOT');"><xsl:value-of select="document($doc)/translation/texts/item[@name='pedidos']/node()"/><br/>(<xsl:value-of select="/ClasificacionProveedores/RESUMENPROVEEDORES/DIVISA/PREFIJO"/><xsl:value-of select="/ClasificacionProveedores/RESUMENPROVEEDORES/DIVISA/SUFIJO"/>)</a>
				</th>
                 <th class="textCenter">
					<a href="javascript:OrdenarPor('PED_NUMRET');"><xsl:value-of select="document($doc)/translation/texts/item[@name='ped_retr']/node()"/><br/>(<xsl:value-of select="document($doc)/translation/texts/item[@name='num']/node()"/>)</a>
				</th>
                 <th class="textCenter">
					<a href="javascript:OrdenarPor('PED_PORCRET');"><xsl:value-of select="document($doc)/translation/texts/item[@name='ped_retr']/node()"/><br/>(%)</a>
				</th>
                 <th class="textCenter">
					<a href="javascript:OrdenarPor('PED_NUMPARC');"><xsl:value-of select="document($doc)/translation/texts/item[@name='ped_parc']/node()"/><br/>(<xsl:value-of select="document($doc)/translation/texts/item[@name='num']/node()"/>)</a>
				</th>
                 <th class="textCenter">
					<a href="javascript:OrdenarPor('PED_PORCPARC');"><xsl:value-of select="document($doc)/translation/texts/item[@name='ped_parc']/node()"/><br/>(%)</a>
				</th>
               <th class="textCenter">
					<a href="javascript:OrdenarPor('RETR_DIAS');"><xsl:value-of select="document($doc)/translation/texts/item[@name='retraso']/node()"/><br/>(<xsl:value-of select="document($doc)/translation/texts/item[@name='dias']/node()"/>)<!--<xsl:value-of select="document($doc)/translation/texts/item[@name='retraso_en_dias']/node()"/>--></a>
				</th>
                <th class="textCenter">
					<a href="javascript:OrdenarPor('RETR_MEDIO');"><xsl:value-of select="document($doc)/translation/texts/item[@name='retraso']/node()"/><br/><xsl:value-of select="document($doc)/translation/texts/item[@name='medio']/node()"/></a>
				</th>
                <th class="textCenter tres"><xsl:value-of select="document($doc)/translation/texts/item[@name='incidencias_pedidos']/node()"/></th>
                <th class="textCenter tres"><xsl:value-of select="document($doc)/translation/texts/item[@name='incidencias_productos']/node()"/></th>
                <!--	PENDIENTE
                <th class="textCenter"><xsl:value-of select="document($doc)/translation/texts/item[@name='nota_compradores']/node()"/></th>
                <th class="textCenter"><xsl:value-of select="document($doc)/translation/texts/item[@name='nota_sistema']/node()"/></th>
				-->
                <th class="textCenter tres"><xsl:value-of select="document($doc)/translation/texts/item[@name='Eval']/node()"/></th>
                <th class="textCenter">
					&nbsp;
				</th>
			</tr>
    		<xsl:for-each select="/ClasificacionProveedores/RESUMENPROVEEDORES/PROVEEDOR">
             <tr class="conhover">
				<input type="hidden" id="EXCEL_{ID}" name="EXCEL_{ID}" value="{POSICION};{NOMBRE};{NOTAMEDIA};{PRODUCTOSADJUDICADOS};{NUMDOCS_EMPRESA};{NUMDOCS_PRODUCTOS};{PLAZOENTREGA};{PLAZOENVIO};{EIS_PROV_LICITACIONESGANADAS};{EIS_PROV_LICITACIONESRESP};{EIS_PROV_LICITACIONES};{EIS_PROV_LIC_RATIOGANTOT};{EIS_PROV_LIC_RATIOGANRESP};{EIS_PROV_NUMEROPEDIDOS};{EIS_PROV_IMPORTEPEDIDOS};{EIS_PROV_NUMPEDIDOSRETRASADOS};{EIS_PROV_PORCPEDIDOSRETRASADOS};{EIS_PROV_NUMPEDIDOSPARCIALES};{EIS_PROV_PORCPEDIDOSPARCIALES};{EIS_PROV_RETRASODIAS};{EIS_PROV_RETRASOMEDIO};{EIS_PROV_INCIDENCIASPEDIDOS};{EIS_PROV_INCIDENCIASPRODUCTOS};{EIS_PROV_EVALUACIONES}"/> 
             	<td>&nbsp;</td>
             	<td>
                    <xsl:choose>
                    <xsl:when test="/ClasificacionProveedores/RESUMENPROVEEDORES/MOSTRAR_COLORES_DOCUMENTACION">
						<xsl:attribute name="style">
                    	<xsl:choose>
                    	<xsl:when test="NIVELDOCUMENTACION='R'">
                    		background:#CC0000;
                    	</xsl:when>
                    	<xsl:when test="NIVELDOCUMENTACION='A'">
                    		background:#F57900;
                    	</xsl:when>
                    	<xsl:otherwise>
                    		background:#background:#F57900;
                    	</xsl:otherwise>
                    	</xsl:choose>
						</xsl:attribute>
                   		<xsl:value-of select="POSICION"/>
                    </xsl:when>
                    <xsl:otherwise>
                    	<xsl:value-of select="POSICION"/>
                    </xsl:otherwise>
                    </xsl:choose>
				</td>
                <td>
                    <!--&nbsp;<a href="javascript:AbrirNuevaValoracionEmpresa('{ID}','{NOMBRE}');"><img src="http://www.newco.dev.br/images/star{NOTAMEDIA}.gif" alt="{NOTAMEDIA}"/></a>-->
                    &nbsp;<a href="javascript:IndicadoresProv({ID})"><img src="http://www.newco.dev.br/images/star{NOTAMEDIA}.gif" alt="{NOTAMEDIA}"/></a>
                </td> 
                <td class="textLeft">&nbsp;<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPDetalleFrame.xsql?EMP_ID={ID}&amp;VENTANA=NUEVA','Detalle Empresa',90,80,0,-50);"><xsl:value-of select="NOMBRE"/></a></td>
				<xsl:if test="/ClasificacionProveedores/RESUMENPROVEEDORES/IDPAIS=57">
                <td class="textCenter">
                    <xsl:choose>
                    <xsl:when test="/ClasificacionProveedores/RESUMENPROVEEDORES/MOSTRAR_COLORES_DOCUMENTACION">
						<xsl:attribute name="style">
                    	<xsl:choose>
                    	<xsl:when test="IDESTADOFICHA='ERR' or IDESTADOFICHA='SIN_FICHA' or IDESTADOFICHA='CURS'">
                    		background:#CC0000;
                    	</xsl:when>
                    	<xsl:when test="IDESTADOFICHA='PEND'">
                    		background:#F57900;
                    	</xsl:when>
                    	<xsl:otherwise>
                    		background:#F57900;
                    	</xsl:otherwise>
                    	</xsl:choose>
						</xsl:attribute>
						<xsl:if test="not(IDESTADOFICHA='SIN_FICHA' or IDESTADOFICHA='CURS')">
                   			<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPFichaCompleta.xsql?EMP_ID={ID}','Ficha Empresa',90,80,0,-50);"><img src="http://www.newco.dev.br/images/2017/info.png"/></a>
						</xsl:if>
                    </xsl:when>
                    <xsl:otherwise>
						<xsl:if test="not(IDESTADOFICHA='SIN_FICHA' or IDESTADOFICHA='CURS')">
                   			<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPFichaCompleta.xsql?EMP_ID={ID}','Ficha Empresa',90,80,0,-50);"><img src="http://www.newco.dev.br/images/2017/info.png"/></a>
						</xsl:if>
                    </xsl:otherwise>
                    </xsl:choose>
				</td>
				<td></td>
				</xsl:if>
             	<td>
                    <xsl:choose>
                    <xsl:when test="/ClasificacionProveedores/RESUMENPROVEEDORES/MOSTRAR_COLORES_DOCUMENTACION">
						<xsl:attribute name="style">
                    	<xsl:choose>
                    	<xsl:when test="ESTADODOCPRODUCTOS='R' or ESTADODOCPRODUCTOS='SIN_DOCS'">
                    		background:#CC0000;
                    	</xsl:when>
                    	<xsl:when test="ESTADODOCPRODUCTOS='A'">
                    		background:#F57900;
                    	</xsl:when>
                    	<xsl:otherwise>
                    		background:#F57900;
                    	</xsl:otherwise>
                    	</xsl:choose>
						</xsl:attribute>
                   		<xsl:value-of select="PRODUCTOSADJUDICADOS"/>
                    </xsl:when>
                    <xsl:otherwise>
                    	<xsl:value-of select="PRODUCTOSADJUDICADOS"/>
                    </xsl:otherwise>
                    </xsl:choose>
				</td>
                <td class="textCenter"><xsl:value-of select="NUMDOCS_EMPRESA"/></td>
                <td class="textCenter"><xsl:value-of select="NUMDOCS_PRODUCTOS"/></td>
				<xsl:choose>
				<xsl:when test="PLAZO_ENTREGA_INFERIOR">
                	<td class="textCenter fondoRojo"><xsl:value-of select="PLAZOENTREGA"/></td>
                	<td class="textCenter fondoRojo"><xsl:value-of select="PLAZOENVIO"/></td>
                </xsl:when>
                <xsl:otherwise>
                	<td class="textCenter"><xsl:value-of select="PLAZOENTREGA"/></td>
                	<td class="textCenter"><xsl:value-of select="PLAZOENVIO"/></td>
                </xsl:otherwise>
				</xsl:choose>
                <td class="textCenter">
                	<xsl:if test="INTEGRADO='S'">
						<img src="http://www.newco.dev.br/images/2017/warning-red.png"/>
					</xsl:if>
                </td>
                <td class="textCenter"><xsl:value-of select="EIS_PROV_LICITACIONESGANADAS"/>&nbsp;/&nbsp;<xsl:value-of select="EIS_PROV_LICITACIONESRESP"/>&nbsp;/&nbsp;<xsl:value-of select="EIS_PROV_LICITACIONES"/></td>
                <td class="textCenter"><xsl:value-of select="EIS_PROV_LIC_RATIOGANTOT"/>%&nbsp;/&nbsp;<xsl:value-of select="EIS_PROV_LIC_RATIOGANRESP"/>%</td>
                <td class="textCenter">
                    <!--<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Gestion/EIS/EISBasico.xsql?IDCONSULTA=COPedidosRetrCentroNum&amp;CP_EMPRESA2={ID}&amp;CP_AGRUPAR=EMP','Pedidos retrasados',100,58,0,-50);">-->
                    <xsl:value-of select="EIS_PROV_NUMEROPEDIDOS"/>
                    <!--</a>-->
                </td>
                <td class="textCenter">
                    <xsl:value-of select="EIS_PROV_IMPORTEPEDIDOS"/>
                </td>
                <td class="textCenter"><xsl:value-of select="EIS_PROV_NUMPEDIDOSRETRASADOS"/></td>
                <td class="textCenter"><xsl:value-of select="EIS_PROV_PORCPEDIDOSRETRASADOS"/>%</td>
                <td class="textCenter"><xsl:value-of select="EIS_PROV_NUMPEDIDOSPARCIALES"/></td>
                <td class="textCenter"><xsl:value-of select="EIS_PROV_PORCPEDIDOSPARCIALES"/>%</td>
                <td class="textCenter"><xsl:value-of select="EIS_PROV_RETRASODIAS"/></td>
                <td class="textCenter"><!--si es mvm agrupo por empresas el eis, si no por centro-->
                    <xsl:value-of select="EIS_PROV_RETRASOMEDIO"/>
                </td>
                <td class="textCenter"><xsl:value-of select="EIS_PROV_INCIDENCIASPEDIDOS"/></td>
                <td class="textCenter">
                	<xsl:choose>
                    <xsl:when test="EIS_PROV_INCIDENCIASPRODUCTOS = '0'">
                    	<xsl:value-of select="EIS_PROV_INCIDENCIASPRODUCTOS"/>
                    </xsl:when>
                    <xsl:otherwise>
                		<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Gestion/Comercial/IncidenciasProductos.xsql?PROVEEDOR={ID}&amp;FESTADO=-1','Incidencias productos',100,58,0,-50);">
                                    <xsl:value-of select="EIS_PROV_INCIDENCIASPRODUCTOS"/>
                                </a>
                    </xsl:otherwise>
                    </xsl:choose>
                </td>
                <td class="textCenter">
                	<xsl:choose>
                    <xsl:when test="EIS_PROV_EVALUACIONES = '0'">
                    	<xsl:value-of select="EIS_PROV_EVALUACIONES"/>
                    </xsl:when>
                    <xsl:otherwise>
                		<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Gestion/Comercial/EvaluacionProductos.xsql?FPROVEEDOR={ID}&amp;FESTADO=-1','Evaluaciones productos',100,58,0,-50);">
                            <xsl:value-of select="EIS_PROV_EVALUACIONES"/>
                        </a>
                    </xsl:otherwise>
                    </xsl:choose>
                </td>
                <!--	PENDIENTE
				<td>
                    &nbsp;<xsl:value-of select="NOTACOMPRADORES"/>
                </td> 
                <td>
                    &nbsp;<xsl:value-of select="NOTASISTEMA"/>
                </td> 
				-->
                <td class="dos">
                    <xsl:if test="EVOLUCION != 'NUEVO' and EVOLUCION != 'IGUAL'">
                    	&nbsp;&nbsp;&nbsp;<img src="http://www.newco.dev.br/images/icon{EVOLUCION}.gif" alt="{EVOLUCION}"/>
                    </xsl:if>
                </td> 
                <td>
                	
                </td>
             </tr>
        	</xsl:for-each> 
			<tr class="subTituloTabla">
                <td colspan="2"></td>
                <td colspan="3"><xsl:value-of select="document($doc)/translation/texts/item[@name='total']/node()"/></td>
                <td colspan="4"></td>
				<td><xsl:value-of select="/ClasificacionProveedores/RESUMENPROVEEDORES/NUMPEDIDOS"/></td>
				<td><xsl:value-of select="/ClasificacionProveedores/RESUMENPROVEEDORES/TOTALPEDIDOS"/></td>
				<td><xsl:value-of select="/ClasificacionProveedores/RESUMENPROVEEDORES/NUMPEDIDOSRETR"/></td>
				<td><xsl:value-of select="/ClasificacionProveedores/RESUMENPROVEEDORES/PORCPEDIDOSRETR"/>%</td>
				<td><xsl:value-of select="/ClasificacionProveedores/RESUMENPROVEEDORES/NUMPEDIDOSPARC"/></td>
				<td><xsl:value-of select="/ClasificacionProveedores/RESUMENPROVEEDORES/PORCPEDIDOSPARC"/>%</td>
				<td><xsl:value-of select="/ClasificacionProveedores/RESUMENPROVEEDORES/RETRASODIAS"/></td>
				<td><xsl:value-of select="/ClasificacionProveedores/RESUMENPROVEEDORES/RETRASOMEDIO"/></td>
				<td><xsl:value-of select="/ClasificacionProveedores/RESUMENPROVEEDORES/TOTALINCIDENCIASPED"/></td>
				<td><xsl:value-of select="/ClasificacionProveedores/RESUMENPROVEEDORES/TOTALINCIDENCIASPROD"/></td>
                <td colspan="4"></td>
			</tr>
		</table>
        </div>
		</form>
       
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
