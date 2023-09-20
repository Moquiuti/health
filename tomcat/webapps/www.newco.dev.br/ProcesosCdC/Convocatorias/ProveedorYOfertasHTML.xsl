<?xml version="1.0" encoding="iso-8859-1"?>
<!--
	Convocatorias especiales: mantenimiento de productos
	Ultima revision ET 23nov18 13:00
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

	<title><xsl:value-of select="document($doc)/translation/texts/item[@name='Convocatorias']/node()"/>:&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Productos']/node()"/></title>

	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->

	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>
	<script type="text/javascript">

 		//	2oct18	Funciones para paginación del listado
		function Enviar(){
			var form=document.forms[0];			
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
				if (Campo=='REFCLIENTE' || Campo=='PRODUCTO')
					document.forms[0].elements['SENTIDO'].value='ASC';
				else
					document.forms[0].elements['SENTIDO'].value='DESC';
			}

			console.log('Orden:'+Campo+' Nueva ordenación:'+document.forms[0].elements['ORDEN'].value+' '+document.forms[0].elements['SENTIDO'].value);

			Enviar();
		}

		function VerConvocatoria()
		{
			var IDConvocatoria=document.forms[0].elements['FIDCONVOCATORIA'].value;
			document.location='http://www.newco.dev.br/ProcesosCdC/Convocatorias/Convocatoria.xsql?LIC_CONV_ID='+IDConvocatoria;
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
		<p class="Path"><xsl:value-of select="document($doc)/translation/texts/item[@name='Inicio']/node()"/>&nbsp;/&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Convocatorias']/node()"/>&nbsp;/&nbsp;<span class="FinPath"><xsl:value-of select="document($doc)/translation/texts/item[@name='Productos']/node()"/></span>
			<span class="CompletarTitulo">
				<xsl:copy-of select="document($doc)/translation/texts/item[@name='pagina']/node()"/>&nbsp;
				<xsl:value-of select="/Productos/PRODUCTOS/PAGINA_ACTUAL"/>&nbsp;
				<xsl:copy-of select="document($doc)/translation/texts/item[@name='de']/node()"/>&nbsp;
				<xsl:value-of select="/Productos/PRODUCTOS/TOTAL_PAGINAS"/>
			</span>
		</p>
		<p class="TituloPagina">
			<xsl:value-of select="/Productos/PRODUCTOS/CONVOCATORIA"/>
			&nbsp;&nbsp;
			<span class="CompletarTitulo">
				<a class="btnNormal" href="http://www.newco.dev.br/ProcesosCdC/Convocatorias/Proveedores.xsql">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='Proveedores']/node()"/>
				</a>
				<!--	Botones	anterior y siguiente-->
				<xsl:if test="/Productos/PRODUCTOS/ANTERIOR">
					&nbsp;<a class="btnNormal" href="javascript:PaginaAnterior();"><xsl:value-of select="document($doc)/translation/texts/item[@name='anterior']/node()"/></a>
				</xsl:if>
				<xsl:if test="/Productos/PRODUCTOS/SIGUIENTE">
					&nbsp;<a class="btnNormal" href="javascript:PaginaSiguiente();"><xsl:value-of select="document($doc)/translation/texts/item[@name='siguiente']/node()"/></a>
				</xsl:if>
			</span>
		</p>
	</div>
	<br/>
	<br/>
	<br/>
	
	
	<div class="divLeft">
		<form name="Procedimiento" method="post" action="http://www.newco.dev.br/ProcesosCdC/Convocatorias/ProveedorYOfertas.xsql">
		<input type="hidden" name="PAGINA" value="{/Productos/PRODUCTOS/PAGINA}"/>
		<input type="hidden" name="ORDEN" value="{/Productos/PRODUCTOS/ORDEN}"/>
		<input type="hidden" name="SENTIDO" value="{/Productos/PRODUCTOS/SENTIDO}"/>
		<!--<table class="buscador" border="0">-->
		<table class="buscador" border="0">
		<tr class="sinLinea" style="height:30px;">
		<td width="150px" class="labelRight">
      		<label><xsl:value-of select="document($doc)/translation/texts/item[@name='Convocatoria']/node()"/>:&nbsp;</label>
		</td>
		<td width="450px" class="textLeft">
        	<xsl:call-template name="desplegable">
            	<xsl:with-param name="path" select="/Productos/PRODUCTOS/FIDCONVOCATORIA/field"/>
            	<!--<xsl:with-param name="defecto" select="/Productos/PRODUCTOS/FIDCONVOCATORIA/field/@current"/>-->
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
        	<label><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/>:&nbsp;</label>
		</td>
		<td class="textLeft">
        	<xsl:call-template name="desplegable">
            	<xsl:with-param name="path" select="/Productos/PRODUCTOS/FIDPROVEEDOR/field"/>
            	<!--<xsl:with-param name="defecto" select="/Productos/PRODUCTOS/FIDPROVEEDOR/field/@current"/>-->
            	<xsl:with-param name="style">width:400px;height:20px;</xsl:with-param>
            	<xsl:with-param name="onChange">javascript:CambioDesplegables('CAMBIO_PROVEEDOR');</xsl:with-param>
        	</xsl:call-template>
		</td>
		<td width="140px" style="text-align:left;">
			<xsl:choose>
			<xsl:when test="/Productos/PRODUCTOS/EXISTE_FICHA_PROVEEDOR">
				<a class="btnNormal" href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPFichaCompleta.xsql?EMP_ID={/Productos/PRODUCTOS/IDPROVEEDOR}','Detalle Empresa',100,80,0,0);">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='ver_ficha']/node()"/>
				</a>
			</xsl:when>
			<xsl:otherwise><xsl:value-of select="document($doc)/translation/texts/item[@name='Sin_ficha_proveedor']/node()"/></xsl:otherwise>
			</xsl:choose>
		</td>
		<td width="*" class="datosLeft">
			<strong><xsl:value-of select="document($doc)/translation/texts/item[@name='Productos_adjudicados']/node()"/>:&nbsp;<xsl:value-of select="/Productos/PRODUCTOS/PRODUCTOS_ADJUDICADOS"/></strong>&nbsp;&nbsp;&nbsp;&nbsp;
		</td>
		</tr>
		<tr class="sinLinea" style="height:30px;">
		<td class="labelRight">
        	<label><xsl:value-of select="document($doc)/translation/texts/item[@name='precio']/node()"/>:&nbsp;</label>
		</td>
		<td class="textLeft">
        	<xsl:call-template name="desplegable">
            	<xsl:with-param name="path" select="/Productos/PRODUCTOS/FPRECIOS/field"/>
            	<!--<xsl:with-param name="defecto" select="/Productos/PRODUCTOS/FPRECIOS/field/@current"/>-->
            	<xsl:with-param name="style">width:400px;height:20px;</xsl:with-param>
            	<!--<xsl:with-param name="onChange">javascript:CambioDesplegables('CAMBIO_PRECIO');</xsl:with-param>-->
        	</xsl:call-template>
		</td>
		<td width="300px" style="text-align:left;">
			<label><xsl:value-of select="document($doc)/translation/texts/item[@name='texto']/node()"/>:&nbsp;</label>
			<input type="text" name="FTEXTO" size="10" id="FTEXTO" style="width:180px">
				<xsl:attribute name="value"><xsl:value-of select="/Productos/PRODUCTOS/FTEXTO"/></xsl:attribute>
			</input>
		</td>
		<td width="300px" style="text-align:left;">
			<label><xsl:copy-of select="document($doc)/translation/texts/item[@name='lineas_por_pagina']/node()"/>:&nbsp;</label>
			<xsl:call-template name="desplegable">
				<xsl:with-param name="path" select="/Productos/PRODUCTOS/LINEASPORPAGINA/field"/>
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
		<table class="buscador" border="0">
		<tr class="sinLinea" style="height:30px;">
		<td class="datosLeft">
			<xsl:value-of select="document($doc)/translation/texts/item[@name='Productos_ofertados']/node()"/>:&nbsp;<strong><xsl:value-of select="/Productos/PRODUCTOS/TOTAL_PRODUCTOS"/></strong>&nbsp;
		</td>
		<td class="textLeft">
			<xsl:value-of select="document($doc)/translation/texts/item[@name='Potencial_ofertado']/node()"/>:&nbsp;<strong><xsl:value-of select="/Productos/PRODUCTOS/POTENCIAL_OFERTADO"/></strong>&nbsp;
		</td>
		<td class="textLeft">
			<xsl:value-of select="document($doc)/translation/texts/item[@name='Importe_global_oferta']/node()"/>:&nbsp;<strong><xsl:value-of select="/Productos/PRODUCTOS/TOTAL_PROVEEDOR"/></strong>&nbsp;
		</td>
		<td class="textLeft azul">
			<xsl:value-of select="document($doc)/translation/texts/item[@name='Productos_mejor_precio']/node()"/>&nbsp;(<strong><xsl:value-of select="/Productos/PRODUCTOS/PRODUCTOS_MEJORPRECIO"/></strong>):&nbsp;<strong><xsl:value-of select="/Productos/PRODUCTOS/TOTAL_MEJORPRECIO"/></strong>&nbsp;
		</td>
		<td class="textLeft verde">
			<xsl:value-of select="document($doc)/translation/texts/item[@name='Productos_con_ahorro']/node()"/>&nbsp;(<strong><xsl:value-of select="/Productos/PRODUCTOS/PRODUCTOS_CONAHORRO"/></strong>):&nbsp;<strong><xsl:value-of select="/Productos/PRODUCTOS/TOTAL_CONAHORRO"/></strong>&nbsp;
		</td>
		</tr>
		</table>
		<BR/>

		<!--<table class="grandeInicio" border="0">-->
		<table class="buscador" border="0">
		<thead>
			<tr class="subTituloTabla">
				<th class="uno"><xsl:value-of select="document($doc)/translation/texts/item[@name='pos']/node()"/>.</th>
				<th class="uno"><xsl:value-of select="document($doc)/translation/texts/item[@name='ABC']/node()"/>&nbsp;</th>
				<th class="uno"><xsl:value-of select="document($doc)/translation/texts/item[@name='Rank']/node()"/>&nbsp;</th>
				<th class="uno"><a href="javascript:Orden('CONSUMO');"><xsl:value-of select="document($doc)/translation/texts/item[@name='consumo']/node()"/></a></th>
				<th align="left" class="cinco"><a href="javascript:Orden('REFCLIENTE');"><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_cliente']/node()"/></a></th>
				<th align="left" ><a href="javascript:Orden('PRODUCTO');"><xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/></a></th>
				<!--<th align="left" class="cinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_prov']/node()"/></th>
				<th align="left" class="veinte"><xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/></th>-->
				<th align="left" class="cinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='marca']/node()"/></th>
				<th align="left" class="tres"><xsl:value-of select="document($doc)/translation/texts/item[@name='ud_basica']/node()"/></th>
				<th align="left" class="tres">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='tipo_iva']/node()"/></th>
				<th align="left" class="cinco"><a href="javascript:Orden('LICITACION');"><xsl:value-of select="document($doc)/translation/texts/item[@name='Clasificacion']/node()"/></a></th>
				<th align="left" class="tres"><xsl:value-of select="document($doc)/translation/texts/item[@name='ud_lote']/node()"/></th>
				<th align="left" class="tres"><xsl:value-of select="document($doc)/translation/texts/item[@name='cantidad']/node()"/></th>
				<th align="left" class="cinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='precio_ud_basica']/node()"/></th>
				<th align="left" class="cinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='precio_ref']/node()"/></th>
				<th align="left" class="diez"><xsl:value-of select="document($doc)/translation/texts/item[@name='Proveedor_actual']/node()"/></th>
				<th align="left" class="tres"><xsl:value-of select="document($doc)/translation/texts/item[@name='marca']/node()"/></th>
				<th align="left" class="tres"><a href="javascript:Orden('AHORRO');"><xsl:value-of select="document($doc)/translation/texts/item[@name='ahorro']/node()"/>(%)</a></th>
				<th align="left" class="tres"><xsl:value-of select="document($doc)/translation/texts/item[@name='mejor_precio']/node()"/></th>
				<th>&nbsp;</th>
			</tr>
		</thead>
        <xsl:choose>
		<xsl:when test="/Productos/PRODUCTOS/PRODUCTO">
			<xsl:for-each select="/Productos/PRODUCTOS/PRODUCTO">
				<xsl:variable name="IncID"><xsl:value-of select="ID"/></xsl:variable>
				<tr id="PRO_{LIC_CEL_ID}" style="border-bottom:1px solid #A7A8A9;">
					<xsl:choose>
					<xsl:when test="MODIFICADO_1HORA">
						<xsl:attribute name="class">fondoNaranja</xsl:attribute>
					</xsl:when>
					<xsl:when test="MODIFICADO_24HORAS">
						<xsl:attribute name="class">fondoAmarillo</xsl:attribute>
					</xsl:when>
					</xsl:choose>

                    <td><xsl:value-of select="LINEA"/></td>
                    <td><xsl:value-of select="LIC_PROD_CLASIFICACIONABC"/></td>
                    <td class="datosRight"><xsl:value-of select="LIC_PROD_POSICIONCONSUMO"/>&nbsp;</td>
                    <td class="datosRight"><strong><xsl:value-of select="LIC_PROD_CONSUMOHISTORICO"/></strong>&nbsp;</td>
					<td>
						<strong>
						<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Gestion/Comercial/FichaProductoLicitacion.xsql?LIC_PROD_ID={LIC_PROD_ID}&amp;LIC_ID={LIC_ID}','Detalle Empresa',100,80,0,0);">
                    		<xsl:value-of select="LIC_PROD_REFCLIENTE"/>
                        </a>
						</strong>
                    </td>
					<td class="datosLeft">&nbsp;<xsl:value-of select="LIC_PROD_NOMBRE"/></td>
					<!--<td class="datosLeft">&nbsp;<xsl:value-of select="LIC_OFE_REFERENCIA"/></td>
					<td class="datosLeft">&nbsp;<xsl:value-of select="LIC_OFE_NOMBRE"/></td>-->
					<td class="datosLeft">&nbsp;<xsl:value-of select="LIC_OFE_MARCA"/></td>
					<td class="datosLeft">&nbsp;<xsl:value-of select="LIC_PROD_UNIDADBASICA"/></td>
					<td class="datosRight"><xsl:value-of select="LIC_PROD_TIPOIVA"/>&nbsp;</td>
					<td class="datosLeft">&nbsp;<xsl:value-of select="LIC_TITULO"/></td>
					<td class="datosRight"><xsl:value-of select="LIC_OFE_UNIDADESPORLOTE"/>&nbsp;</td>
					<td class="datosRight"><xsl:value-of select="LIC_PROD_CANTIDAD"/>&nbsp;</td>
					<td class="datosRight">
						<strong>
							<xsl:choose>
							<xsl:when test="MEJOR_PRECIO">
								<xsl:attribute name="class">azul</xsl:attribute>
							</xsl:when>
							<xsl:when test="CON_AHORRO">
								<xsl:attribute name="class">verde</xsl:attribute>
							</xsl:when>
							<xsl:when test="MAS_CARO">
								<xsl:attribute name="class">rojo</xsl:attribute>
							</xsl:when>
							</xsl:choose>
						<xsl:value-of select="LIC_OFE_PRECIO"/>
						</strong>&nbsp;
					</td>
					<td class="datosRight"><strong><xsl:value-of select="LIC_PROD_PRECIOREFERENCIA"/></strong>&nbsp;</td>
					<td class="datosLeft">&nbsp;<xsl:value-of select="PROVEEDORACTUAL"/></td>
					<td class="datosLeft">&nbsp;<xsl:value-of select="LIC_PROD_MARCAACTUAL"/></td>
					<td class="datosRight">
						<strong>
							<xsl:choose>
							<xsl:when test="MEJOR_PRECIO">
								<xsl:attribute name="class">azul</xsl:attribute>
							</xsl:when>
							<xsl:when test="CON_AHORRO">
								<xsl:attribute name="class">verde</xsl:attribute>
							</xsl:when>
							<xsl:when test="MAS_CARO">
								<xsl:attribute name="class">rojo</xsl:attribute>
							</xsl:when>
							</xsl:choose>
							<xsl:value-of select="LIC_OFE_AHORRO"/>
						</strong>&nbsp;
					</td>
					<td class="datosRight"><strong><xsl:value-of select="LIC_PROD_MEJORPRECIO"/></strong>&nbsp;</td>
<!--
					|| 	'<LIC_CONVOCATORIA>'		|| mvm.ScapeHTMLString(v_reg.LIC_CONVOCATORIA)				||'</LIC_CONVOCATORIA>'
					|| 	'<LIC_TITULO>'				|| mvm.ScapeHTMLString(v_reg.LIC_TITULO)					||'</LIC_TITULO>'
					|| 	'<IDPROVEEDOR>'				|| v_reg.IDPROVEEDOR 										||'</IDPROVEEDOR>'
					|| 	'<PROVEEDOR>'				|| mvm.ScapeHTMLString(v_reg.PROVEEDOR)						||'</PROVEEDOR>'
					|| 	'<LIC_PROD_ID>'				|| v_reg.LIC_PROD_ID 										||'</LIC_PROD_ID>'
					|| 	'<LIC_PROD_REFESTANDAR>'	|| mvm.ScapeHTMLString(v_reg.LIC_PROD_REFESTANDAR)			||'</LIC_PROD_REFESTANDAR>'
					|| 	'<LIC_PROD_REFCLIENTE>'		|| mvm.ScapeHTMLString(v_reg.LIC_PROD_REFCLIENTE)			||'</LIC_PROD_REFCLIENTE>'
					|| 	'<LIC_PROD_UNIDADBASICA>'	|| mvm.ScapeHTMLString(v_reg.LIC_PROD_UNIDADBASICA)			||'</LIC_PROD_UNIDADBASICA>'
					|| 	'<LIC_PROD_CANTIDAD>'		|| Formato.formato(v_reg.LIC_PROD_CANTIDAD,NULL,0)			||'</LIC_PROD_CANTIDAD>'
					|| 	'<LIC_PROD_PRECIOREFERENCIA>'|| Formato.formato(v_reg.LIC_PROD_PRECIOREFERENCIA,NULL,2)	||'</LIC_PROD_PRECIOREFERENCIA>'
					|| 	'<LIC_PROD_TIPOIVA>'		|| Formato.formato(v_reg.LIC_PROD_TIPOIVA,NULL,0)			||'</LIC_PROD_TIPOIVA>'
					|| 	'<LIC_OFE_ID>'				|| v_reg.LIC_OFE_ID 										||'</LIC_OFE_ID>'
					|| 	'<LIC_OFE_REFERENCIA>'		|| mvm.ScapeHTMLString(v_reg.LIC_OFE_REFERENCIA)			||'</LIC_OFE_REFERENCIA>'
					|| 	'<LIC_OFE_NOMBRE>'			|| mvm.ScapeHTMLString(v_reg.LIC_OFE_NOMBRE)				||'</LIC_OFE_NOMBRE>'
					|| 	'<LIC_OFE_MARCA>'			|| mvm.ScapeHTMLString(v_reg.LIC_OFE_MARCA)					||'</LIC_OFE_MARCA>'
					|| 	'<LIC_OFE_UNIDADESPORLOTE>'|| Formato.formato(v_reg.LIC_OFE_UNIDADESPORLOTE,NULL,0)		||'</LIC_OFE_UNIDADESPORLOTE>'
					|| 	'<LIC_OFE_PRECIO>'			|| Formato.formato(v_reg.LIC_OFE_PRECIO,NULL,2)				||'</LIC_OFE_PRECIO>'
					|| 	'<LIC_OFE_AHORRO>'			|| Formato.formato(v_reg.LIC_OFE_AHORRO,NULL,2)				||'</LIC_OFE_AHORRO>'
					|| 	'<LIC_PROD_MEJORPRECIO>'	|| Formato.formato(v_reg.LIC_PROD_MEJORPRECIO,NULL,2)		||'</LIC_PROD_MEJORPRECIO>'
-->

					<td>
					<!--
					<xsl:if test="/Productos/PRODUCTOS/CDC">
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
