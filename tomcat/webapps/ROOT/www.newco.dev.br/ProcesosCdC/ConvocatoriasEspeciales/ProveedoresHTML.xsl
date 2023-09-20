<?xml version="1.0" encoding="iso-8859-1"?>
<!--
	Convocatorias especiales: listado de proveedores
	Ultima revision ET 13mar19 09:15
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:import href = "http://www.newco.dev.br/General/General.xsl"/>
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="lang" select="@lang"/>
<xsl:template match="/">
<html>
<head>
	<!--idioma-->
	<xsl:variable name="lang">
	<xsl:choose>
		<xsl:when test="/Productos/LANG"><xsl:value-of select="/Productos/LANG" /></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
	</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<title><xsl:value-of select="document($doc)/translation/texts/item[@name='Convocatorias']/node()"/>:&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Proveedores']/node()"/></title>

	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->

	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>
	<script type="text/javascript">
		var alrt_errorDescargaFichero	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='error_descarga_fichero']/node()"/>';
		
 		//	2oct18	Funciones para paginación del listado
		function Enviar(){
			var form=document.forms[0];
			//console.log("PAGINA:"+document.forms[0].elements['PAGINA'].value);
			
			SubmitForm(form);
		}

		function Buscar() {document.forms[0].elements['PAGINA'].value=0; Enviar();}
		function PaginaAnterior() {document.forms[0].elements['PAGINA'].value=parseInt(document.forms[0].elements['PAGINA'].value)-1; Enviar();}
		function PaginaSiguiente() {document.forms[0].elements['PAGINA'].value=parseInt(document.forms[0].elements['PAGINA'].value)+1; Enviar();}

		function CambioDesplegables(Tipo)
		{

			console.log('CambioDesplegables'+Tipo);
			
			if (Tipo=='CAMBIO_CONVOCATORIA')
				document.forms[0].elements['FIDPROVEEDOR'].value=-1;
			
			Enviar();
		}


		function Orden(Campo)
		{
			console.log('Campo:'+Campo+ 'Orden actual:'+document.forms[0].elements['ORDEN'].value+ 'Sentido:'+document.forms[0].elements['SENTIDO'].value);
		
			if (Campo==document.forms[0].elements['ORDEN'].value)
				document.forms[0].elements['SENTIDO'].value=(document.forms[0].elements['SENTIDO'].value=='DESC')?'ASC':'DESC';
			else
			{
				document.forms[0].elements['ORDEN'].value=Campo;
				if ((Campo=='PROVEEDOR')||(Campo=='FICHA'))
					document.forms[0].elements['SENTIDO'].value='ASC';
				else
					document.forms[0].elements['SENTIDO'].value='DESC';
			}

			//console.log('Orden:'+Campo+' Nueva ordenación:'+document.forms[0].elements['ORDEN'].value+' '+document.forms[0].elements['SENTIDO'].value);

			Enviar();
		}
		
		function DescargarExcel(){
			var d = new Date();
			IDConvocatoria=document.forms[0].elements['FIDCONVOCATORIA'].value;
			
			jQuery.ajax({
				url:	"http://www.newco.dev.br/ProcesosCdC/ConvocatoriasEspeciales/ProveedoresExcel.xsql",
				data:	"IDCONVOCATORIA="+IDConvocatoria+"&amp;_="+d.getTime(),
				type:	"GET",
				contentType: "application/xhtml+xml",
				beforeSend: function(){
					null;
				},
				error: function(objeto, quepaso, otroobj){
					alert('error'+quepaso+' '+otroobj+''+objeto);
				},
				success: function(objeto){
					var data = eval("(" + objeto + ")");

					if(data.estado == 'ok')
						window.location='http://www.newco.dev.br/Descargas/'+data.url;
					else
						alert(alrt_errorDescargaFichero);
				}
			});
		}
		
		//	Reabre convocatoria para un proveedor
		function reabrirConvocatoria(IDProveedor)
		{
			document.forms[0].elements['PARAMETROS'].value=IDProveedor;
			document.forms[0].elements['FESPECIALES'].value='';
			document.forms[0].elements['FTEXTO'].value='';
			document.forms[0].elements['ACCION'].value='REOFERTA';
			Enviar();
		}

		//	Cierra/suspende convocatoria para un proveedor
		function activaOSuspendeProveedor(IDProveedor)
		{
			document.forms[0].elements['PARAMETROS'].value=IDProveedor;
			document.forms[0].elements['FESPECIALES'].value='';
			document.forms[0].elements['FTEXTO'].value='';
			document.forms[0].elements['ACCION'].value='SUS';
			Enviar();
		}

		function VerConvocatoria()
		{
			var IDConvocatoria=document.forms[0].elements['FIDCONVOCATORIA'].value;
			document.location='http://www.newco.dev.br/ProcesosCdC/Convocatorias/Convocatoria.xsql?LIC_CONV_ID='+IDConvocatoria;
		}

		function VerProcedimientos(IDProveedor)
		{
			var IDConvocatoria=document.forms[0].elements['FIDCONVOCATORIA'].value;
			document.location='http://www.newco.dev.br/ProcesosCdC/ConvocatoriasEspeciales/BuscadorProcedimientos.xsql?FIDCONVOCATORIA='+IDConvocatoria+'&amp;FIDPROVEEDOR='+IDProveedor;
		}

		function VerProductos()
		{
			var IDConvocatoria=document.forms[0].elements['FIDCONVOCATORIA'].value;
			document.location='http://www.newco.dev.br/ProcesosCdC/ConvocatoriasEspeciales/BuscadorProductos.xsql?FIDCONVOCATORIA='+IDConvocatoria;
		}
		
	</script>
</head>

<body class="gris">
<xsl:choose>
<xsl:when test="/Productos/SESION_CADUCADA">
	<xsl:for-each select="/Productos/SESION_CADUCADA">
		<xsl:if test="position()=last()">
			<xsl:apply-templates select="."/>
		</xsl:if>
	</xsl:for-each>
</xsl:when>
<xsl:when test="//xsql-error">
	<xsl:apply-templates select="//xsql-error"/>
</xsl:when>
<xsl:otherwise>
	<xsl:choose>
	<xsl:when test="//SESION_CADUCADA">
		<xsl:apply-templates select="//SESION_CADUCADA"/>
	</xsl:when>
	<xsl:when test="//Sorry">
		<xsl:apply-templates select="//Sorry"/>
	</xsl:when>
	<xsl:otherwise>

    <!--idioma-->
	<xsl:variable name="lang">
	<xsl:choose>
		<xsl:when test="/Productos/LANG"><xsl:value-of select="/Productos/LANG" /></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
	</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
    <!--idioma fin-->

	<xsl:variable name="usuario">
		<xsl:choose>
		<xsl:when test="EVALUACIONESPRODUCTOS/OBSERVADOR and EVALUACIONESPRODUCTOS/CDC">CDC</xsl:when>
		<xsl:otherwise>NORMAL</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	
	<!--	Titulo de la página		-->
	<div class="ZonaTituloPagina">
		<p class="Path"><xsl:value-of select="document($doc)/translation/texts/item[@name='Inicio']/node()"/>&nbsp;/&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Convocatorias']/node()"/>&nbsp;/&nbsp;<span class="FinPath">
			<xsl:value-of select="/Proveedores/PROVEEDORES/TOTAL_PROVEEDORES"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Proveedores']/node()"/></span>
			<span class="CompletarTitulo">
				<xsl:copy-of select="document($doc)/translation/texts/item[@name='pagina']/node()"/>&nbsp;
				<xsl:value-of select="/Proveedores/PROVEEDORES/PAGINA_ACTUAL"/>&nbsp;
				<xsl:copy-of select="document($doc)/translation/texts/item[@name='de']/node()"/>&nbsp;
				<xsl:value-of select="/Proveedores/PROVEEDORES/TOTAL_PAGINAS"/>
			</span>
		</p>
		<p class="TituloPagina">
			<xsl:value-of select="/Proveedores/PROVEEDORES/CONVOCATORIA"/>
			&nbsp;&nbsp;
			<span class="CompletarTitulo">
				<xsl:if test="/Proveedores/PROVEEDORES/ROL='COMPRADOR'">
				<a class="btnNormal" href="javascript:DescargarExcel();">
					<img src="http://www.newco.dev.br/images/iconoExcel.gif" alt="Descargar Excel"/>
				</a>&nbsp;
				<a class="btnNormal" href="javascript:VerProcedimientos('');">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='Procedimientos']/node()"/>
				</a>&nbsp;
				<a class="btnNormal" href="javascript:VerProductos();">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='Productos']/node()"/>
				</a>&nbsp;
				</xsl:if>
				<!--	Botones	anterior y siguiente-->
				<xsl:if test="/Proveedores/PROVEEDORES/ANTERIOR">
					<a class="btnNormal" href="javascript:PaginaAnterior();"><xsl:value-of select="document($doc)/translation/texts/item[@name='anterior']/node()"/></a>&nbsp;
				</xsl:if>
				<xsl:if test="/Proveedores/PROVEEDORES/SIGUIENTE">
					<a class="btnNormal" href="javascript:PaginaSiguiente();"><xsl:value-of select="document($doc)/translation/texts/item[@name='siguiente']/node()"/></a>&nbsp;
				</xsl:if>
			</span>
		</p>
	</div>
	<br/>
	<br/>
	<br/>
	
	
	<div class="divLeft">
		<form name="Procedimiento" method="post" action="http://www.newco.dev.br/ProcesosCdC/ConvocatoriasEspeciales/Proveedores.xsql">
		<input type="hidden" name="PAGINA" value="{/Proveedores/PROVEEDORES/PAGINA}"/>
		<input type="hidden" name="ORDEN" value="{/Proveedores/PROVEEDORES/ORDEN}"/>
		<input type="hidden" name="SENTIDO" value="{/Proveedores/PROVEEDORES/SENTIDO}"/>
		<input type="hidden" name="ACCION" value=""/>
		<input type="hidden" name="PARAMETROS" value=""/>
		<!--<table class="buscador" border="0">-->
		<table class="buscador" border="0">
		<tr class="sinLinea" style="height:30px;">
		<td width="150px" class="labelRight">
      		<label><xsl:value-of select="document($doc)/translation/texts/item[@name='Convocatoria']/node()"/>:&nbsp;</label>
		</td>
		<td width="450px" class="textLeft">
        	<xsl:call-template name="desplegable">
            	<xsl:with-param name="path" select="/Proveedores/PROVEEDORES/FIDCONVOCATORIA/field"/>
            	<!--<xsl:with-param name="defecto" select="/Proveedores/PROVEEDORES/FIDCONVOCATORIA/field/@current"/>-->
            	<xsl:with-param name="style">width:400px;height:20px;</xsl:with-param>
            	<xsl:with-param name="onChange">javascript:CambioDesplegables('CAMBIO_CONVOCATORIA');</xsl:with-param>
        	</xsl:call-template>
		</td>
		<td width="140px" style="text-align:left;">
			<a class="btnNormal" href="javascript:VerConvocatoria();">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='Convocatoria']/node()"/>
			</a>
		</td>
		<td width="*">
      		&nbsp;
		</td>
		</tr>
		<tr class="sinLinea" style="height:30px;">
		<td class="labelRight">
        	<label><xsl:value-of select="document($doc)/translation/texts/item[@name='Filtros']/node()"/>:&nbsp;</label>
		</td>
		<td class="textLeft">
        	<xsl:call-template name="desplegable">
            	<xsl:with-param name="path" select="/Proveedores/PROVEEDORES/FESPECIALES/field"/>
             	<xsl:with-param name="style">width:400px;height:20px;</xsl:with-param>
        	</xsl:call-template>
		</td>
		<td width="300px" class="labelRight">
			<label><xsl:value-of select="document($doc)/translation/texts/item[@name='texto']/node()"/>:&nbsp;</label>
			<input type="text" name="FTEXTO" size="10" id="FTEXTO" style="width:180px">
				<xsl:attribute name="value"><xsl:value-of select="/Proveedores/PROVEEDORES/FTEXTO"/></xsl:attribute>
			</input>&nbsp;&nbsp;
		</td>
		<td width="300px" style="text-align:left;">
			<label><xsl:copy-of select="document($doc)/translation/texts/item[@name='lineas_por_pagina']/node()"/>:&nbsp;</label>
			<xsl:call-template name="desplegable">
				<xsl:with-param name="path" select="/Proveedores/PROVEEDORES/LINEASPORPAGINA/field"/>
            	<xsl:with-param name="style">width:100px;height:20px;</xsl:with-param>
				<!--<xsl:with-param name="onChange">javascript:Buscar();</xsl:with-param>-->
			</xsl:call-template>&nbsp;&nbsp;&nbsp;
		</td>
		<td width="140px" style="text-align:left;">
			<a class="btnDestacado" href="javascript:Buscar();">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='buscar']/node()"/>
			</a>
		</td>
		<td width="*">
      		&nbsp;
		</td>
		</tr>
		</table>
		</form>
		<BR/><BR/>

		<!--<table class="grandeInicio" border="0">-->
		<table class="buscador" border="0">
		<thead>
			<tr class="subTituloTabla">
				<th class="uno"><xsl:value-of select="document($doc)/translation/texts/item[@name='pos']/node()"/>.</th>
				<th align="left" class="treinta"><a href="javascript:Orden('PROVEEDOR');"><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/></a></th>
				<th align="left" class="uno">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='estado']/node()"/></th>
				<xsl:if test="not(/Proveedores/PROVEEDORES/NOEDICION)">
					<th align="left" class="uno">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='accion']/node()"/></th>
					<th align="left" class="uno" >&nbsp;<a href="javascript:Orden('FICHA');"><xsl:value-of select="document($doc)/translation/texts/item[@name='ver_ficha']/node()"/></a></th>
				</xsl:if>
				<th align="left" class="cinco">&nbsp;<a href="javascript:Orden('NUMOFERTAS');"><xsl:value-of select="document($doc)/translation/texts/item[@name='Productos']/node()"/></a></th>
				<th align="left" class="cinco"><a href="javascript:Orden('PROCEDIMIENTOS');"><xsl:value-of select="document($doc)/translation/texts/item[@name='Procedimientos']/node()"/></a></th>
				<th align="left" class="cinco"><a href="javascript:Orden('ADJUDICADOS');"><xsl:value-of select="document($doc)/translation/texts/item[@name='Adj']/node()"/></a></th>
				<th align="left" class="cinco"><a href="javascript:Orden('ORDEN1');"><xsl:value-of select="document($doc)/translation/texts/item[@name='Ord1']/node()"/></a></th>
				<th align="left azul" class="cinco">&nbsp;<a href="javascript:Orden('PROD_MEJOR');"><xsl:value-of select="document($doc)/translation/texts/item[@name='Procedimientos_mejor_precio']/node()"/></a></th>
				<th align="left azul" class="diez">&nbsp;<a href="javascript:Orden('CONSUMO_MEJOR');"><xsl:value-of select="document($doc)/translation/texts/item[@name='Importe_global_mejor_precio']/node()"/></a></th>
				<th align="left verde" class="cinco"><a href="javascript:Orden('PROD_AHORRO');"><xsl:value-of select="document($doc)/translation/texts/item[@name='Procedimientos_con_ahorro']/node()"/></a></th>
				<th align="left verde" class="diez"><a href="javascript:Orden('CONSUMO_AHORRO');"><xsl:value-of select="document($doc)/translation/texts/item[@name='Importe_global_con_ahorro']/node()"/></a></th>
				<th>&nbsp;</th>
			</tr>
		</thead>
        <xsl:choose>
		<xsl:when test="/Proveedores/PROVEEDORES/PROVEEDOR">
			<xsl:for-each select="/Proveedores/PROVEEDORES/PROVEEDOR">
				<xsl:variable name="IncID"><xsl:value-of select="ID"/></xsl:variable>
				<tr id="PRO_{LIC_CEL_ID}">
					<xsl:attribute name="style">
					<xsl:choose>
					<xsl:when test="IDESTADO='SUS'">border-bottom:1px solid #A7A8A9;background:#CC0000;</xsl:when>
					<xsl:otherwise>border-bottom:1px solid #A7A8A9;</xsl:otherwise>
					</xsl:choose>
					</xsl:attribute>
                    <td><xsl:value-of select="LINEA"/></td>
					<td class="datosLeft">
						&nbsp;<a href="javascript:VerProcedimientos({IDPROVEEDOR});">
							<strong><xsl:value-of select="PROVEEDOR"/></strong>
						</a>
					</td>
					<td class="datosLeft">&nbsp;<xsl:value-of select="ESTADO"/>&nbsp;</td>
					<xsl:if test="not(/Proveedores/PROVEEDORES/NOEDICION)">
						<td>
							<xsl:if test="IDESTADO='INF' or IDESTADO='FUERAPLAZO'">
								<a href="javascript:reabrirConvocatoria({IDPROVEEDOR});" style="text-decoration:none;"><img src="http://www.newco.dev.br/images/2017/reload.png"/></a>
							</xsl:if>
							<a href="javascript:activaOSuspendeProveedor({IDPROVEEDOR});" style="text-decoration:none;"><img src="http://www.newco.dev.br/images/suspender.gif"/></a>
						</td>
						<td class="datosLeft">
							<xsl:choose>
							<xsl:when test="EXISTE_FICHA_PROVEEDOR">
								<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPFichaCompleta.xsql?EMP_ID={IDPROVEEDOR}','Detalle Empresa',100,80,0,0);">
									<xsl:value-of select="document($doc)/translation/texts/item[@name='ver_ficha']/node()"/>
								</a>
							</xsl:when>
							<xsl:otherwise><xsl:value-of select="document($doc)/translation/texts/item[@name='Sin_ficha_proveedor']/node()"/></xsl:otherwise>
							</xsl:choose>
						</td>
					</xsl:if>
					<td class="datosRight"><strong><xsl:value-of select="NUMEROLINEAS"/></strong>&nbsp;</td>
					<td class="datosRight"><strong><xsl:value-of select="NUMPROCEDIMIENTOS"/></strong>&nbsp;</td>
					<td class="datosRight"><strong><xsl:value-of select="ADJUDICADOS"/></strong>&nbsp;</td>
					<td class="datosRight"><strong><xsl:value-of select="ORDEN1"/></strong>&nbsp;</td>
					<td class="datosRight azul"><strong><xsl:value-of select="OFERTASMEJORPRECIO"/></strong>&nbsp;</td>
					<td class="datosRight azul"><strong><xsl:value-of select="CONSUMOMEJORPRECIO"/></strong>&nbsp;</td>
					<td class="datosRight verde"><strong><xsl:value-of select="OFERTASCONAHORRO"/></strong>&nbsp;</td>
					<td class="datosRight verde"><strong><xsl:value-of select="CONSUMOCONAHORRO"/></strong>&nbsp;</td>

					<td>
					<!--
					<xsl:if test="/Proveedores/PROVEEDORES/CDC">
						<a href="javascript:BorrarEvaluacionProducto('{PROD_EV_ID}');"><img src="http://www.newco.dev.br/images/2017/trash.png"/></a>
					</xsl:if>
					-->
					</td>
				</tr>
			</xsl:for-each>
                </xsl:when>
		<xsl:otherwise>
			<tr><td colspan="15" align="center"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='no_se_han_encontrado_resultados']/node()"/></strong></td></tr>
		</xsl:otherwise>
		</xsl:choose>
		</table>
                </div><!--fin de divLeft-->
	</xsl:otherwise>
        </xsl:choose>
</xsl:otherwise>
</xsl:choose>
</body>
</html>
</xsl:template>
</xsl:stylesheet>
