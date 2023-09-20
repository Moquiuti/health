<?xml version="1.0" encoding="iso-8859-1"?>
<!--
	Historico de tarifas para un producto
	Ultima revision: ET 11jun23. HistoricoComprasProducto2022_110623.js
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
	<xsl:variable name="lang"><xsl:value-of select="/Compras/LANG"/></xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<title>
	<xsl:value-of select="document($doc)/translation/texts/item[@name='Historico_compras']/node()"/>:(<xsl:value-of select="/Compras/LINEASTARIFAS/REFPROVEEDOR"/>)&nbsp;
		<xsl:value-of select="/Compras/LINEASTARIFAS/PRODUCTO"/>&nbsp;[<xsl:value-of select="/Compras/LINEASTARIFAS/PROVEEDOR"/>]
	</title>

	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->

	<script src="http://www.newco.dev.br/General/jquery-3.6.0.js"></script>	
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic2022_010822.js"></script>
	<!--<script type="text/javascript" src="http://www.newco.dev.br/General/chart.4.3.0.min.js"></script>-->

	<script src=" http://cdn.jsdelivr.net/npm/chart.js@4.3.0/dist/chart.umd.min.js"/>	
	<script type="text/javascript" src="http://www.newco.dev.br/Gestion/EIS/HistoricoComprasProducto2022_110623.js"></script>
	<link rel="stylesheet" type="text/css" href="http://www.newco.dev.br/General/TablaResumen-popup.css"/>
	<script type="text/javascript" src="http://www.newco.dev.br/General/TablaResumen-popup.js"></script>
	<script type="text/javascript">

		var IDEmpresaUsu= <xsl:value-of select="/Compras/LINEASTARIFAS/IDEMPRESA"/>;
		var IDPais		= <xsl:value-of select="/Compras/LINEASTARIFAS/IDPAIS"/>;
		var IDIdioma	= <xsl:value-of select="/Compras/LINEASTARIFAS/IDIDIOMA"/>;
		var AnnoActual	= <xsl:value-of select="/Compras/LINEASTARIFAS/ANNO_ACTUAL"/>;
		var MesActual	= <xsl:value-of select="/Compras/LINEASTARIFAS/MES_ACTUAL"/>;

		var IDProveedor	= <xsl:value-of select="/Compras/LINEASTARIFAS/IDPROVEEDOR"/>;
		var Proveedor	= '<xsl:value-of select="/Compras/LINEASTARIFAS/PROVEEDOR"/>';
		var refProducto	= '<xsl:value-of select="/Compras/LINEASTARIFAS/REFPROVEEDOR"/>';
		var IDProducto	= <xsl:value-of select="/Compras/LINEASTARIFAS/IDPRODUCTO"/>;
		var Producto	= '<xsl:value-of select="/Compras/LINEASTARIFAS/PRODUCTO"/>';
		var IDProdEstandar	= <xsl:value-of select="/Compras/LINEASTARIFAS/IDPRODESTANDAR"/>;
		var RefEstandar	= '<xsl:value-of select="/Compras/LINEASTARIFAS/REFESTANDAR"/>';
		var RefCliente	= '<xsl:value-of select="/Compras/LINEASTARIFAS/REFCLIENTE"/>';
		var DescEstandar= '<xsl:value-of select="/Compras/LINEASTARIFAS/NOMBREESTANDAR"/>';

		var txt_Fecha	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='fecha']/node()"/>';
		var	txtTotal	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='total']/node()"/>';
		var UrlDoc= '<xsl:value-of select="$doc"/>';
		
		var NumMesesTabla	=36;	// Numero de meses a mostrar en pantalla para la tabla agregada
		
		var arrEntradas = [];			//	Todas las entradas
		var arrEntradasMes = [];		//	Entradas agregadas por mes
		var arrEntradasSem = [];		//	Entradas agragadas por semana
		var arrCentros= [];				//	Centros de la empresa, para montar la matriz de base
		var arrCategorias= [];			//	Categorias de la empresa, para montar la matriz de base

		var arrMeses= [];		//	Nombres de los meses

		var Mes=[]
		Mes["Nombre"]='';	//dejamos el indice 0 vacio, Enero=1
		arrMeses.push(Mes);
		<xsl:for-each select="/Compras/LINEASTARIFAS/LISTAMESES/MES">
		var Mes=[]
		Mes["Nombre"]='<xsl:value-of select="NOMBRE"/>';
		arrMeses.push(Mes);
		</xsl:for-each>

		<xsl:for-each select="/Compras/LINEASTARIFAS/CENTRO">
		var Centro=[];
		Centro["ID"]='<xsl:value-of select="ID"/>';
		Centro["Nombre"]='<xsl:value-of select="NOMBRE"/>';
		Centro["Lineas"]=new Array();	
		<xsl:for-each select="LINEA">
		var Linea=[];	
		Linea["Anno"]=<xsl:value-of select="ANNO"/>;
		Linea["Mes"]=<xsl:value-of select="MES"/>;
		Linea["TarifaInicio"]=<xsl:value-of select="TARIFA_INICIO"/>;
		Linea["TarifaFinal"]=<xsl:value-of select="TARIFA_FINAL"/>;
		Linea["TarifaMedia"]=<xsl:value-of select="TARIFA_MEDIA"/>;
		Linea["Cantidad"]=<xsl:value-of select="CANTIDAD"/>;
		Linea["ImporteTotal"]=<xsl:value-of select="IMPORTE_TOTAL"/>;		
		Centro["Lineas"].push(Linea);
		<!--console.log('Centro["Lineas"].push(Linea). NumLineas:'+Centro.Lineas.length);-->
		</xsl:for-each>
		arrCentros.push(Centro);
		<!--console.log('NumCentros:'+arrCentros.push.length);-->
		</xsl:for-each>
	</script>
</head>
<body onload="javascript:Inicio();">
	<!--idioma-->
	<xsl:variable name="lang"><xsl:value-of select="/Compras/LANG"/></xsl:variable>
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
			<xsl:value-of select="/Compras/LINEASTARIFAS/REFPROVEEDOR"/>&nbsp;<xsl:value-of select="/Compras/LINEASTARIFAS/PRODUCTO"/>
			<xsl:if test="/Compras/LINEASTARIFAS/MVM or /Compras/LINEASTARIFAS/CDC">&nbsp;<span class="amarillo">PRO_ID: <xsl:value-of select="/Compras/LINEASTARIFAS/IDPRODUCTO"/></span></xsl:if>
			<span class="CompletarTitulo">
        		<a class="btnNormal" href="javascript:FichaProducto({/Compras/LINEASTARIFAS/IDPRODUCTO},'AnalisisTarifas',{/Compras/LINEASTARIFAS/IDEMPRESA});">
            		<xsl:value-of select="document($doc)/translation/texts/item[@name='Ficha_de_producto']/node()"/>
        		</a>&nbsp;
        		<a class="btnNormal" href="javascript:AnalisisPedidos({/Compras/LINEASTARIFAS/IDPRODUCTO});">
            		<xsl:value-of select="document($doc)/translation/texts/item[@name='analisis_pedidos']/node()"/>
        		</a>&nbsp;
        		<a class="btnNormal" href="javascript:HistoricoTarifas({/Compras/LINEASTARIFAS/IDPRODUCTO},{/Compras/LINEASTARIFAS/IDEMPRESA});">
            		<xsl:value-of select="document($doc)/translation/texts/item[@name='Historico_tarifas']/node()"/>
        		</a>&nbsp;
			</span>
		</p>
	</div>
	<br/>
	<div class="divLeft">
		<span class="marginLeft50"><label><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/>:&nbsp;</label><xsl:value-of select="/Compras/LINEASTARIFAS/PROVEEDOR"/></span>
		<br/><br/>
		<span class="marginLeft50"><label><xsl:value-of select="document($doc)/translation/texts/item[@name='nombre_privado']/node()"/>:&nbsp;</label>
			<xsl:choose>
			<xsl:when test="/Compras/LINEASTARIFAS/REFCLIENTE!=''">
				(<xsl:value-of select="/Compras/LINEASTARIFAS/REFCLIENTE"/>)
			</xsl:when>
			<xsl:otherwise>
				(<xsl:value-of select="/Compras/LINEASTARIFAS/REFESTANDAR"/>)
			</xsl:otherwise>
			</xsl:choose>
			&nbsp;<xsl:value-of select="/Compras/LINEASTARIFAS/NOMBREESTANDAR"/>
		</span>

		<!-- Tabla de datos	-->
		<div id="divTablaDatos">
		</div>
		<!-- Grafico	-->
        <div id="actividadMensualBox" class="eisBox w90 divCenter">
			<canvas id="actMensual" width="1200px" height="400px"></canvas>
        </div>

		<br/><br/><br/><br/><br/><br/>
	</div>
</xsl:template>

</xsl:stylesheet>
