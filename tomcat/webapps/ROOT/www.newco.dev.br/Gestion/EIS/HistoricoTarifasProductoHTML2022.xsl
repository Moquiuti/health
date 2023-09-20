<?xml version="1.0" encoding="iso-8859-1"?>
<!--
	Historico de tarifas para un producto
	Ultima revision: ET 12jun23 12:12. HistoricoTarifasProducto2022_110623.js
+-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:import href = "http://www.newco.dev.br/General/General.xsl"/>
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="lang" select="@lang"/>

<xsl:template match="/">

<!--	Todos los documentos HTML deben empezar con esto	-->
<xsl:text disable-output-escaping='yes'>&lt;!doctype html></xsl:text>

<html>
<head>
	<!--idioma-->
	<xsl:variable name="lang"><xsl:value-of select="/Tarifas/LANG"/></xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<title>
	<xsl:value-of select="document($doc)/translation/texts/item[@name='Analisis_tarifas']/node()"/>:(<xsl:value-of select="/Tarifas/LINEASTARIFAS/REFPROVEEDOR"/>)&nbsp;
		<xsl:value-of select="/Tarifas/LINEASTARIFAS/PRODUCTO"/>&nbsp;[<xsl:value-of select="/Tarifas/LINEASTARIFAS/PROVEEDOR"/>]
	</title>

	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->

	<script src="http://www.newco.dev.br/General/jquery-3.6.0.js"></script>	
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic2022_010822.js"></script>
	<!--<script type="text/javascript" src="http://www.newco.dev.br/General/chart.4.3.0.min.js"></script>-->

	<script src=" http://cdn.jsdelivr.net/npm/chart.js@4.3.0/dist/chart.umd.min.js"/>	
	<script type="text/javascript" src="http://www.newco.dev.br/Gestion/EIS/HistoricoTarifasProducto2022_110623.js"></script>
	<link rel="stylesheet" type="text/css" href="http://www.newco.dev.br/General/TablaResumen-popup.css"/>
	<script type="text/javascript" src="http://www.newco.dev.br/General/TablaResumen-popup.js"></script>
	<script type="text/javascript">

		var IDEmpresaUsu= <xsl:value-of select="/Tarifas/LINEASTARIFAS/IDEMPRESA"/>;
		var IDPais		= <xsl:value-of select="/Tarifas/LINEASTARIFAS/IDPAIS"/>;
		var IDIdioma	= <xsl:value-of select="/Tarifas/LINEASTARIFAS/IDIDIOMA"/>;
		var AnnoActual	= <xsl:value-of select="/Tarifas/LINEASTARIFAS/ANNO_ACTUAL"/>;
		var MesActual	= <xsl:value-of select="/Tarifas/LINEASTARIFAS/MES_ACTUAL"/>;
		var txtFecha	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='fecha']/node()"/>';
		var txtPrecio	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='precio']/node()"/>';
		var txtPedidos	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='Pedidos']/node()"/>';
		var txtCantidad	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='cantidad_comprada']/node()"/>';
		var txtTotal	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='Total_pedidos']/node()"/>';
		
		var IDProveedor	= <xsl:value-of select="/Tarifas/LINEASTARIFAS/IDPROVEEDOR"/>;
		var Proveedor	= '<xsl:value-of select="/Tarifas/LINEASTARIFAS/PROVEEDOR"/>';
		var refProducto	= '<xsl:value-of select="/Tarifas/LINEASTARIFAS/REFPROVEEDOR"/>';
		var IDProducto	= <xsl:value-of select="/Tarifas/LINEASTARIFAS/IDPRODUCTO"/>;
		var Producto	= '<xsl:value-of select="/Tarifas/LINEASTARIFAS/PRODUCTO"/>';
		var IDProdEstandar	= <xsl:value-of select="/Tarifas/LINEASTARIFAS/IDPRODESTANDAR"/>;
		var RefEstandar	= '<xsl:value-of select="/Tarifas/LINEASTARIFAS/REFESTANDAR"/>';
		var RefCliente	= '<xsl:value-of select="/Tarifas/LINEASTARIFAS/REFCLIENTE"/>';
		var DescEstandar= '<xsl:value-of select="/Tarifas/LINEASTARIFAS/NOMBREESTANDAR"/>';
		
		var Label=[];
		Label[0]=txtPrecio;
		Label[1]=txtPedidos
		Label[2]=txtCantidad
		Label[3]=txtTotal

		
		<!--
		var arrMeses= [];		//	Nombres de los meses

		var Mes=[]
		Mes["Nombre"]='';	//dejamos el indice 0 vacio, Enero=1
		arrMeses.push(Mes);
		<xsl:for-each select="/Tarifas/LINEASTARIFAS/LISTAMESES/MES">
		var Mes=[]
		Mes["Nombre"]='<xsl:value-of select="NOMBRE"/>';
		arrMeses.push(Mes);
		</xsl:for-each>
		-->

		arrTarifas=[];
		<xsl:for-each select="/Tarifas/LINEASTARIFAS/LINEA">
		//<xsl:value-of select="FECHA_INICIO"/>
		
		var Tarifa=[];	
		Tarifa["FechaInicio"]='<xsl:value-of select="FECHA_INICIO"/>';
		Tarifa["FechaFinal"]='<xsl:value-of select="FECHA_FINAL"/>';
		Tarifa["Importe"]=<xsl:value-of select="IMPORTE"/>;		
		Tarifa["NumPedidos"]=<xsl:value-of select="NUMPEDIDOS"/>;		
		Tarifa["Cantidad"]=<xsl:value-of select="CANTIDAD"/>;		
		Tarifa["ImporteTotal"]=<xsl:value-of select="IMPORTE_TOTAL"/>;		
		arrTarifas.push(Tarifa);
		</xsl:for-each>
	</script>
</head>
<body onload="javascript:Inicio();">
	<!--idioma-->
	<xsl:variable name="lang"><xsl:value-of select="/Tarifas/LANG"/></xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->
	<xsl:call-template name="Pagina_principal">
		<xsl:with-param name="doc"><xsl:value-of select="$doc"/></xsl:with-param>		
	</xsl:call-template>
</body>
</html>
</xsl:template>
<xsl:template name="Pagina_principal">
	<xsl:param name="doc"/>

	<!--	Titulo de la página		-->
	<div class="ZonaTituloPagina">
		<p class="TituloPagina">
			<xsl:value-of select="/Tarifas/LINEASTARIFAS/REFPROVEEDOR"/>&nbsp;<xsl:value-of select="/Tarifas/LINEASTARIFAS/PRODUCTO"/>
			<xsl:if test="/Tarifas/LINEASTARIFAS/MVM or /Tarifas/LINEASTARIFAS/CDC">&nbsp;<span class="amarillo">PRO_ID: <xsl:value-of select="/Tarifas/LINEASTARIFAS/IDPRODUCTO"/></span></xsl:if>
			<span class="CompletarTitulo">
        		<a class="btnNormal" href="javascript:FichaProducto('{/Tarifas/LINEASTARIFAS/IDPRODUCTO}','AnalisisTarifas',{/Tarifas/LINEASTARIFAS/IDEMPRESA});">
            		<xsl:value-of select="document($doc)/translation/texts/item[@name='Ficha_de_producto']/node()"/>
        		</a>&nbsp;
        		<a class="btnNormal" href="javascript:AnalisisPedidos('{/Tarifas/LINEASTARIFAS/IDPRODUCTO}');">
            		<xsl:value-of select="document($doc)/translation/texts/item[@name='analisis_pedidos']/node()"/>
        		</a>&nbsp;
        		<a class="btnNormal" href="javascript:HistoricoCompras('{/Tarifas/LINEASTARIFAS/IDPRODUCTO}',{/Tarifas/LINEASTARIFAS/IDEMPRESA});">
            		<xsl:value-of select="document($doc)/translation/texts/item[@name='Historico_compras']/node()"/>
        		</a>&nbsp;
			</span>
		</p>
	</div>
	<br/>

	<div class="divLeft">
		<span class="marginLeft50"><label><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/>:&nbsp;</label><xsl:value-of select="/Tarifas/LINEASTARIFAS/PROVEEDOR"/></span>
		<br/><br/>
		<span class="marginLeft50"><label><xsl:value-of select="document($doc)/translation/texts/item[@name='nombre_privado']/node()"/>:&nbsp;</label>
			<xsl:choose>
			<xsl:when test="/Tarifas/LINEASTARIFAS/REFCLIENTE!=''">
				(<xsl:value-of select="/Tarifas/LINEASTARIFAS/REFCLIENTE"/>)
			</xsl:when>
			<xsl:otherwise>
				(<xsl:value-of select="/Tarifas/LINEASTARIFAS/REFESTANDAR"/>)
			</xsl:otherwise>
			</xsl:choose>
			&nbsp;<xsl:value-of select="/Tarifas/LINEASTARIFAS/NOMBREESTANDAR"/>
		</span>

		<!-- Tabla de datos	-->
		<div id="divTablaDatos">
		</div>
		<br/>
		<!-- Grafico de tarifas	-->
        <div id="actTarifasBox" class="eisBox w90 divCenter">
			<canvas id="actTarifas" width="1200px" height="300px"></canvas>
        </div>

		<br/><br/><br/><br/><br/><br/>
	</div>
</xsl:template>

</xsl:stylesheet>
