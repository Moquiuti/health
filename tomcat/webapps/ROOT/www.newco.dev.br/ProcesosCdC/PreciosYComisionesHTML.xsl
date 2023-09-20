<?xml version="1.0" encoding="iso-8859-1"?>
<!--
	Listado del cat�logo privado, incluye datos proveedor y precio
	ultima revision	ET 23dic20 18:00
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:import href = "http://www.newco.dev.br/General/General.xsl"/>
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>

<xsl:template match="/">
<html>
<head>
	<!--idioma-->
	<xsl:variable name="lang">
	<xsl:choose>
		<xsl:when test="/FamiliasYProductos/LANG"><xsl:value-of select="/FamiliasYProductos/LANG"/></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
	</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<title><xsl:value-of select="TITULO" disable-output-escaping="yes"/></title>

	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->

	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>

	<script type="text/javascript">
		var errorFechaLimite	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='error_guardar_fecha']/node()"/>';
		var obliFechaLimite	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_limite_obli']/node()"/>';
	</script>

	<script type="text/javascript">
		var origen	= '<xsl:value-of select="/FamiliasYProductos/ORIGEN"/>';
		var type	= '<xsl:value-of select="/FamiliasYProductos/TYPE"/>';
	</script>

	<script type="text/javascript">
            
        //ver la oferta cargada
		function verOferta(IDOferta){
			jQuery.ajax({
					cache:	false,
					url:	'http://www.newco.dev.br/ProcesosCdC/CatalogoPrivado/URLDocumentoAJAX.xsql',
					type:	"GET",
					data:	"IDDOC="+IDOferta,
					contentType: "application/xhtml+xml",
					success: function(objeto){
						var data = eval("(" + objeto + ")");
            
                                                if(data.URLDocumento.estado == 'OK'){
                                                    window.open("http://www.newco.dev.br/Documentos/"+data.URLDocumento.URLDocumento);
						}
					},
					error: function(xhr, errorString, exception) {
						alert("xhr.status="+xhr.status+" error="+errorString+" exception="+exception);
					}
				});
		}
            
		//cambiar fecha validez precio
		function cambiaFecha(IDProd){
			var form = document.forms['form1'];
			var fechaLimite = 'FECHA_CADUCIDAD_'+IDProd;
			var enviarFechaLimite = 'EnviarFecha_'+IDProd;
			var modificarFechaLimite = 'ModificaFecha_'+IDProd;

			jQuery("#" + fechaLimite).removeClass('noinput');
			jQuery("#" + modificarFechaLimite).hide();
			jQuery("#" + enviarFechaLimite).show();
		}

		//actualizarFechaLimite funcion de la pagina actualizarFechaLimite
		function actualizarFechaLimite(IDProd){
			var IDCLIENTE		= jQuery('#CLIENTE_ID_'+IDProd).val();
			var valueFechaLimite	= jQuery('#FECHA_CADUCIDAD_'+IDProd).val();
			var fechaLimite		= 'FECHA_CADUCIDAD_'+IDProd;
			var enviarFechaLimite	= 'EnviarFecha_'+IDProd;
			var modificarFechaLimite = 'ModificaFecha_'+IDProd;
			var msg = '';
			var d = new Date();

			if (valueFechaLimite == ''){ msg += obliFechaLimite;}

			if (msg == ''){
				jQuery.ajax({
					cache:	false,
					url:	'http://www.newco.dev.br/ProcesosCdC/CatalogoPrivado/ActualizarFechaLimiteCat.xsql',
					type:	"GET",
					data:	"PRO_ID="+IDProd+"&amp;CLIENTE_ID="+IDCLIENTE+"&amp;FECHA_LIMITE="+valueFechaLimite,
					contentType: "application/xhtml+xml",
					success: function(objeto){
						var data = eval("(" + objeto + ")");
			
						if(data.ActualizarFechaLimite.estado == 'OK'){
							jQuery("#" + fechaLimite).addClass('noinput');
							//jQuery("#" + fechaLimite).setAttribute('disabled','disabled');
							jQuery("#"+modificarFechaLimite).show();
							jQuery("#"+enviarFechaLimite).hide();
						}
					},
					error: function(xhr, errorString, exception) {
						alert("xhr.status="+xhr.status+" error="+errorString+" exception="+exception);
					}
				});
			}else{
				alert(msg);
			}
		}// fin de actualizarFechaLimite

	function ProdEstandar(idempresa,ID){
		EjecutarFuncionDelFrame('zonaCatalogo','CambioProductoEstandarActual('+idempresa+','+ID+',\'CAMBIOPRODUCTOESTANDAR\')');
	}

	function EjecutarFuncionDelFrame(nombreFrame,nombreFuncion){
		//solodebug 	console.log('EjecutarFuncionDelFrame Frame: '+nombreFrame+' Funcion:'+nombreFuncion);

		//---var objFrame=new Object();
		objFrame=obtenerFrame(top, nombreFrame);

		if(objFrame.name!=null){

			var retorno=eval('objFrame.'+nombreFuncion);

			if(retorno!=undefined)
			{
				return retorno;
			}
		}

	}
 
	function EjecutarExterno(nombreFrame,idProductoEstandar){
		EjecutarFuncionDelFrame(nombreFrame,nombreFuncion);
		EjecutarFuncionDelFrame('zonaProducto','location.href=\'about:blank\'');
	}

	function recargarPagina(tipo){
		EjecutarFuncionDelFrame('Cabecera','EjecutarEnviarBusqueda();');
	}

    //funcion que enseña en el eis los datos del centro o de la empresa segun un producto, agrupar por producto siempre    
    function MostrarEIS(indicador, idempresa, idcentro, refPro, anno)
    {
		var Enlace;

		//	alert(indicador + idempresa +idcentro +refPro +anno);


		Enlace='http://www.newco.dev.br/Gestion/EIS/EISDatos2.xsql?'
				+'IDCUADROMANDO='+indicador
				+'&amp;'+'ANNO='+anno
				+'&amp;'+'IDEMPRESA='+idempresa
				+'&amp;'+'IDCENTRO='+idcentro
				+'&amp;'+'IDUSUARIO='
				+'&amp;'+'IDPRODUCTO=-1'
				+'&amp;'+'IDGRUPOCAT=-1'
				+'&amp;'+'IDSUBFAMILIA=-1'
				+'&amp;'+'IDESTADO=-1'
				+'&amp;'+'REFERENCIA='+refPro
				+'&amp;'+'CODIGO='
				+'&amp;'+'AGRUPARPOR=REF';

		MostrarPagPersonalizada(Enlace,'EIS',100,80,0,0);
    }

	function nuevaBusqueda(IDCat, IDFam, IDSfam, IDGru){
		<!-- El segundo y tercer parametro son opcionales -->
		IDFam	= (typeof IDFam === "undefined") ? -1 : IDFam;
		IDSfam	= (typeof IDSfam === "undefined") ? -1 : IDSfam;
		IDGru	= (typeof IDGru === "undefined") ? -1 : IDGru

		<!-- Esta funcion informa los desplegables del buscador -->
		EjecutarFuncionDelFrame('Cabecera','NuevaBusqueda(' + IDCat + ', ' + IDFam + ', ' + IDSfam + ', ' + IDGru + ');');

		<!-- Aqui recargamos la pagina con los nuevos valores -->
		var IDCLIENTE = jQuery('#IDCLIENTE').val();
		window.location = 'http://www.newco.dev.br/ProcesosCdC/CatalogoPrivado/PreciosYComisiones.xsql?' 
			+ 'ORIGEN=' + origen
			+ '&amp;'+'TYPE=' + type
			+ '&amp;'+'IDINFORME=Comisiones'
			+ '&amp;'+'ADJUDICADO=N'
			+ '&amp;'+'IDCATEGORIA=' + IDCat
			+ '&amp;'+'IDFAMILIA=' + IDFam
			+ '&amp;'+'IDSUBFAMILIA=' + IDSfam
			+ '&amp;'+'IDGRUPO=' + IDGru
			+ '&amp;'+'IDCLIENTE=' + IDCLIENTE;
	}
 
 	//	17ago16	Funciones para paginacion del listado
	function Enviar(){
		var form=document.forms[0];
		SubmitForm(form);
	}
 		
	function Buscar() {document.forms[0].elements['PAGINA'].value=0; Enviar();}
	function PaginaAnterior() {document.forms[0].elements['PAGINA'].value=parseInt(document.forms[0].elements['PAGINA'].value)-1; Enviar();}
	function PaginaSiguiente() {document.forms[0].elements['PAGINA'].value=parseInt(document.forms[0].elements['PAGINA'].value)+1; Enviar();}
	
	function CambiarOrden(Orden)
	{
		document.forms[0].elements['PAGINA'].value=0; 
		document.forms[0].elements['ORDEN'].value=Orden; 
		Enviar();
	};
	
                
	</script>
</head>

<body>
	<xsl:choose>
	
	<xsl:when test="FamiliasYProductos/SESION_CADUCADA"><xsl:apply-templates select="FamiliasYProductos/SESION_CADUCADA"/> </xsl:when>
	<xsl:when test="FamiliasYProductos/ROWSET/ROW/Sorry"><xsl:apply-templates select="FamiliasYProductos/ROWSET/ROW/Sorry"/></xsl:when>
	<xsl:otherwise>

		<!--idioma-->
		<xsl:variable name="lang"><xsl:value-of select="/FamiliasYProductos/LANG"/></xsl:variable>
		<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
		<!--idioma fin-->

		<!-- miramos si hay datos devueltos -->
		<xsl:choose>
		<xsl:when test="not(FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/CATEGORIA)">
			<div class="titlePage"><xsl:value-of select="document($doc)/translation/texts/item[@name='busqueda_sin_resultados']/node()"/></div>
		</xsl:when>
		<xsl:otherwise>

			<!--	Titulo de la página		-->
			<div class="ZonaTituloPagina">
				<p class="Path"><xsl:value-of select="document($doc)/translation/texts/item[@name='Inicio']/node()"/>&nbsp;/&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Catalogo_privado']/node()"/>&nbsp;/&nbsp;<span class="FinPath"><xsl:value-of select="document($doc)/translation/texts/item[@name='Listado_productos_y_precios']/node()"/></span>
					<span class="CompletarTitulo" style="width:600px;">
						<xsl:if test="/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/ROL != 'VENDEDOR'">
							<xsl:if test="FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/SOLO_PRODESTANDAR != 'S'">
								<xsl:if test="/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/MOSTRARCATEGORIAS or (/FamiliasYProductos/ORIGEN = 'CATCLIENTES' and /FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/CATEGORIA/REFERENCIA != 'DEF')">
									<xsl:value-of select="/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/TOTAL_CATEGORIAS"/>&nbsp;
									<xsl:value-of select="/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/NOMBRESNIVELES/NIVEL1"/>(s),&nbsp;
								</xsl:if>
								<xsl:value-of select="/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/TOTAL_FAMILIAS"/>&nbsp;
								<xsl:value-of select="/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/NOMBRESNIVELES/NIVEL2"/>(s),&nbsp;
								<xsl:value-of select="/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/TOTAL_SUBFAMILIAS"/>&nbsp;
								<xsl:value-of select="/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/NOMBRESNIVELES/NIVEL3"/>(s),&nbsp;
								<xsl:if test="/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/MOSTRARGRUPOS">
									<xsl:value-of select="/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/TOTAL_GRUPOS"/>&nbsp;
									<xsl:value-of select="/SFamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/NOMBRESNIVELES/NIVEL4"/>(s)&nbsp;
								</xsl:if>
							</xsl:if>
							(<xsl:value-of select="document($doc)/translation/texts/item[@name='productos_estandar_vacios']/node()"/>:&nbsp;
							<xsl:value-of select="FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/TOTAL_PRODUCTOSESTANDARVACIOS"/>)
						</xsl:if>
					</span>
				</p>
				<p class="TituloPagina">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='resultados']/node()"/>:&nbsp;
					<xsl:value-of select="FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/TOTAL_PRODUCTOSESTANDAR"/>&nbsp;
					<xsl:choose>
					<xsl:when test="/FamiliasYProductos/ORIGEN = 'CATCLIENTES'">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='productos']/node()"/>&nbsp;
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="document($doc)/translation/texts/item[@name='productos_estandar']/node()"/>&nbsp;
					</xsl:otherwise>
					</xsl:choose>
       				&nbsp;&nbsp;
					<span class="CompletarTitulo" style="width:300px;">
						<!--	Botones	-->
						<xsl:if test="/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/ANTERIOR">
							<a class="btnNormal" href="javascript:PaginaAnterior();"><xsl:value-of select="document($doc)/translation/texts/item[@name='anterior']/node()"/></a>
						</xsl:if>&nbsp;
						<xsl:if test="/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/SIGUIENTE">
							<a class="btnNormal" href="javascript:PaginaSiguiente();"><xsl:value-of select="document($doc)/translation/texts/item[@name='siguiente']/node()"/></a>
						</xsl:if>&nbsp;
					</span>
				</p>
			</div>
			<br/>

			<div id="pruebaDescarga">
				<!--<table class="grandeInicio" border="0">-->
				<table class="buscador">
				<thead>

				<!--	17ago16	Guardamos los campos en un formulario, más comodo para manejarlos-->
				<form action="PreciosYComisiones.xsql" method="POST" name="form1">
        			<input type="hidden" name="IDCLIENTE" id="IDCLIENTE" value="{FamiliasYProductos/IDCLIENTE}"/>
        			<input type="hidden" name="IDINFORME" id="IDINFORME" value="{FamiliasYProductos/IDINFORME}"/>
        			<input type="hidden" name="IDCATEGORIA" id="IDCATEGORIA" value="{FamiliasYProductos/IDCATEGORIA}"/>
        			<input type="hidden" name="IDFAMILIA" id="IDFAMILIA" value="{FamiliasYProductos/IDFAMILIA}"/>
        			<input type="hidden" name="IDSUBFAMILIA" id="IDSUBFAMILIA" value="{FamiliasYProductos/IDSUBFAMILIA}"/>
        			<input type="hidden" name="IDPROVEEDOR" id="IDPROVEEDOR"  value="{FamiliasYProductos/IDPROVEEDOR}"/>
        			<input type="hidden" name="PRODUCTO" id="PRODUCTO" value="{FamiliasYProductos/PRODUCTO}"/>
        			<input type="hidden" name="PROVEEDOR" id="PROVEEDOR" value="{FamiliasYProductos/PROVEEDOR}"/>
        			<input type="hidden" name="IDCENTRO" id="IDCENTRO" value="{FamiliasYProductos/IDCENTRO}"/>
        			<input type="hidden" name="SINUSAR" id="SINUSAR" value="{FamiliasYProductos/SINUSAR}"/>
        			<input type="hidden" name="ADJUDICADO" id="ADJUDICADO" value="{FamiliasYProductos/ADJUDICADO}"/>
        			<input type="hidden" name="MES" id="MES" value="{FamiliasYProductos/MES}"/>
        			<input type="hidden" name="ANNO" id="ANNO" value="{FamiliasYProductos/ANNO}"/>
        			<input type="hidden" name="TIPOFILTRO" id="TIPOFILTRO" value="{FamiliasYProductos/TIPOFILTRO}"/>
        			<input type="hidden" name="PRIMEROSPEDIDOS" id="PRIMEROSPEDIDOS" value="{FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/PRIMEROSPEDIDOS}"/>
        			<input type="hidden" name="CONCONSUMO" id="CONCONSUMO" value="{FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/CONCONSUMO}"/>
        			<input type="hidden" name="SINCONSUMO" id="SINCONSUMO" value="{FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/SINCONSUMORECIENTE}"/>
        			<input type="hidden" name="informarXCentro" id="informarXCentro" value="{FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/PORCENTRO}"/>
        			<input type="hidden" name="consumoMinimo" id="consumoMinimo" value="{FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/FILTROCONSUMO}"/>
        			<input type="hidden" name="PAGINA" id="PAGINA" value="{FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/PAGINA}"/>
        			<input type="hidden" name="ORDEN" id="ORDEN" value="{FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/ORDEN}"/>
        			<input type="hidden" name="SOLO_PROD_ESTANDAR" id="SOLO_PROD_ESTANDAR" value="{FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/SOLO_PRODESTANDAR}"/>
        			<input type="hidden" name="SOLO_REGULADOS" id="SOLO_REGULADOS" value="{FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/SOLO_REGULADOS}"/>
        			<input type="hidden" name="SOLO_OPCION1" id="SOLO_OPCION1" value="{FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/SOLO_OPCION1}"/>
        			<input type="hidden" name="SIN_STOCK" id="SIN_STOCK" value="{FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/SIN_STOCK}"/>
        			<input type="hidden" name="PROV_BLOQUEADO" id="PROV_BLOQUEADO" value="{FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/PROV_BLOQUEADO}"/>

				<!--<tr class="select">-->
				<tr class="filtros">
				<td colspan="2" align="right">
					&nbsp;
					<!--<xsl:if test="/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/ANTERIOR">
						<a href="javascript:PaginaAnterior();"><xsl:value-of select="document($doc)/translation/texts/item[@name='anterior']/node()"/></a>
					</xsl:if>-->
				</td>
				<td colspan="6">
					<xsl:copy-of select="document($doc)/translation/texts/item[@name='lineas_por_pagina']/node()"/>:&nbsp;
					<xsl:call-template name="desplegable">
						<xsl:with-param name="id" value="LINEASPORPAGINA"/>
						<xsl:with-param name="path" select="/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/LINEASPORPAGINA/field"/>
						<xsl:with-param name="onChange">javascript:Buscar();</xsl:with-param>
					</xsl:call-template>&nbsp;&nbsp;&nbsp;
					<xsl:copy-of select="document($doc)/translation/texts/item[@name='pagina']/node()"/>&nbsp;
					<xsl:value-of select="FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/PAGINA_ACTUAL"/>&nbsp;
					<xsl:copy-of select="document($doc)/translation/texts/item[@name='de']/node()"/>&nbsp;
					<xsl:value-of select="FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/TOTAL_PAGINAS"/>
				</td>
				<td colspan="4" align="left">
					&nbsp;
					<!--<xsl:if test="/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/SIGUIENTE">
						<a href="javascript:PaginaSiguiente();"><xsl:value-of select="document($doc)/translation/texts/item[@name='siguiente']/node()"/></a>
					</xsl:if>-->
				</td>
				</tr>
				</form>
				<tr class="subTituloTabla">
				<!--<tr class="titulos">-->
                    <!--columna empresa solo para catalogo clientes-->
                    <xsl:choose>
                    <xsl:when test="/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/MOSTRAR_COLUMNA_EMPRESA or /FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/MOSTRAR_COLUMNA_CENTRO">
                        <td class="ocho"><xsl:value-of select="document($doc)/translation/texts/item[@name='cliente']/node()"/></td>
                    </xsl:when>
                    <xsl:otherwise><td class="zerouno">&nbsp;</td></xsl:otherwise>
                    </xsl:choose>
					<td class="cinco textLeft"><a href="javascript:CambiarOrden('REF_MVM');"><xsl:value-of select="document($doc)/translation/texts/item[@name='Ref']/node()"/></a></td>
					<!--si cdc veo ref privada y ref cliente, si usuario normal veo ref cliente si informADA, SI NO REF-->
					<xsl:choose>
					<xsl:when test="/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/NUEVO_MODELO">
						<td class="zerouno"></td>
					</xsl:when>
					<xsl:when test="not(/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/MOSTRAR_COLUMNA_REFCLIENTE)">
						<td class="zerouno"></td>
					</xsl:when>
					<xsl:otherwise>
						<td class="seis textLeft">
							<a href="javascript:CambiarOrden('REF_CLIENTE');">
								<xsl:value-of select="document($doc)/translation/texts/item[@name='ref_cliente']/node()"/>
							</a>
							<xsl:if test="/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/CATALOGO_MULTIOPCION">
								<br/><xsl:value-of select="document($doc)/translation/texts/item[@name='Orden']/node()"/>
							</xsl:if>
						</td>
					</xsl:otherwise>
					</xsl:choose>
					<td class="textLeft"><a href="javascript:CambiarOrden('NOMBRE');"><xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/></a></td>
					<td class="cinco">&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='marca']/node()"/>&nbsp;&nbsp;</td>
					<td class="uno"></td>
					<td class="diez textLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/></td>
					<td class="cinco textLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_prov']/node()"/></td>
					<td>
						<xsl:attribute name="style">
							<xsl:choose>
							<xsl:when test="/FamiliasYProductos/ORIGEN = 'CATCLIENTES'">width=100px</xsl:when>
							<xsl:otherwise>width=0px</xsl:otherwise>
							</xsl:choose>
						</xsl:attribute>

						<xsl:choose>
						<xsl:when test="/FamiliasYProductos/ORIGEN = 'CATCLIENTES'">&nbsp;</xsl:when>
						<xsl:otherwise><xsl:copy-of select="document($doc)/translation/texts/item[@name='unidad_basica_2line']/node()"/></xsl:otherwise>
						</xsl:choose>
					</td>

					<td style="width=150px;"><!--precio-->
						<xsl:attribute name="class">
							<xsl:choose>
							<xsl:when test="/FamiliasYProductos/ORIGEN = 'CATCLIENTES' and /FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/NO_MOSTRAR_PRECIO">uno</xsl:when>
							<xsl:otherwise>siete</xsl:otherwise>
							</xsl:choose>
						</xsl:attribute>
						<!--si es catalogo clientes no veo precio  cambio condiciones 24-11-2014 mc-->
						<xsl:choose>
						<xsl:when test="/FamiliasYProductos/ORIGEN = 'CATCLIENTES' and /FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/NO_MOSTRAR_PRECIO">&nbsp;</xsl:when>
						<xsl:otherwise>
							<xsl:choose>
							<xsl:when test="/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/NUEVO_MODELO"><!--gomosa-->
								<xsl:copy-of select="document($doc)/translation/texts/item[@name='precio_final_iva_incl']/node()"/>
							</xsl:when>
                                                        <xsl:when test="/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/MOSTRAR_PRECIO_IVA"><!--optima-->
								<xsl:copy-of select="document($doc)/translation/texts/item[@name='precio_prov_iva_incl']/node()"/>
							</xsl:when>
							<xsl:otherwise><!--tipo asisa-->
								<xsl:copy-of select="document($doc)/translation/texts/item[@name='precio_prov_sin_iva_2line']/node()"/>
							</xsl:otherwise>
							</xsl:choose>
						</xsl:otherwise>
						</xsl:choose>
					</td>

					<td style="width=400px;text-align:center;">
						<xsl:choose>
						<xsl:when test="/FamiliasYProductos/ORIGEN = 'CATCLIENTES' or /FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/MOSTRAR_PRECIO">
							&nbsp;&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='validez_precio']/node()"/>&nbsp;&nbsp;&nbsp;
						</xsl:when>
						<xsl:otherwise>
							<span class="font11"><xsl:value-of select="document($doc)/translation/texts/item[@name='validez_precio']/node()"/></span>
						</xsl:otherwise>
						</xsl:choose>
					</td>

				<xsl:choose>
				<xsl:when test="/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/MOSTRAR_COMISION_MVM and /FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/NUEVO_MODELO">
					<td class="seis"><xsl:copy-of select="document($doc)/translation/texts/item[@name='comision_mvm_2line']/node()"/></td>
				</xsl:when>
				<xsl:otherwise>
					<td class="zerouno"></td>
				</xsl:otherwise>
				</xsl:choose>

				<!-- Margen -->
				<xsl:choose>
				<xsl:when test="/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/CDC or /FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/ADMIN and /FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/NUEVO_MODELO">
					<td class="cinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='margen']/node()"/></td>
				</xsl:when>
				<xsl:otherwise>
					<td class="zerouno"></td>
				</xsl:otherwise>
				</xsl:choose>

				<xsl:choose>
				<xsl:when test="/FamiliasYProductos/ADJUDICADO = 'S' and /FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/MOSTRAR_CONSUMOS">
					<!-- Consumo ultimo anyo -->
					<td class="cinco">
						<xsl:copy-of select="document($doc)/translation/texts/item[@name='consumo_ultimo_anyo_2line']/node()"/>
					</td>
					<!-- Consumo reciente -->
					<td class="cinco">
						<xsl:copy-of select="document($doc)/translation/texts/item[@name='consumo_reciente_2line']/node()"/>
					</td>
				</xsl:when>
				<xsl:otherwise>
					<td colspan="2" class="zerouno">&nbsp;</td>
				</xsl:otherwise>
				</xsl:choose>

				</tr>
			</thead>

			<tbody>
				<!--categoria productos-->
				<xsl:for-each select="FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/CATEGORIA">
				<xsl:if test="(/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/SOLO_PRODESTANDAR != 'S') and (./FAMILIA/SUBFAMILIA/GRUPO/PRODUCTOESTANDAR)">
				<tr>
                    <td>&nbsp;</td>
					<td class="textLeft bold">
						<xsl:value-of select="REFERENCIA"/>
					</td>
					<!--ref cliente si es usuario admin-->
					<td class="textLeft">
					<xsl:choose>
					<xsl:when test="/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/NUEVO_MODELO">
						&nbsp;
					</xsl:when>
					<xsl:when test="not(/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/MOSTRAR_COLUMNA_REFCLIENTE)">
						&nbsp;
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="REFCLIENTE"/>
					</xsl:otherwise>
					</xsl:choose>
					</td>
					<td colspan="9" class="textLeft">
						<a href="javascript:EjecutarFuncionDelFrame('zonaCatalogo','CambioCategoriaActual({/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/IDEMPRESA},{ID},\'CAMBIOCATEGORIA\');');" style="color:#666666; font-size:13px;">
							<xsl:value-of select="NOMBRE"/>
						</a>&nbsp;
						<a href="javascript:nuevaBusqueda({ID});" style="text-decoration:none;"><img src="http://www.newco.dev.br/images/modificarLente.gif" alt="" title=""/></a>
					</td>
				</tr>
				</xsl:if>

				<!--familia productos-->
				<xsl:for-each select="./FAMILIA">
				<xsl:if test="(/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/SOLO_PRODESTANDAR != 'S') and (./SUBFAMILIA/GRUPO/PRODUCTOESTANDAR)">
				<tr>
                    <xsl:attribute name="class">
						<xsl:choose>
                        <xsl:when test="/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/SOLO_PRODESTANDAR = 'S'">familia oculta</xsl:when>
						<xsl:otherwise>familia oculta</xsl:otherwise>
						</xsl:choose>
					</xsl:attribute>
                                    
                    <!--columna centro cliente solo para buscador clientes-->
                    <td>&nbsp;</td>
                                        
					<td class="bold textLeft">
						<xsl:value-of select="REFERENCIA"/>
					</td>
					<td>

					<xsl:choose>
					<xsl:when test="/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/NUEVO_MODELO">
						&nbsp;
					</xsl:when>
					<xsl:when test="not(/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/MOSTRAR_COLUMNA_REFCLIENTE)">
						&nbsp;
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="REFCLIENTE"/>
					</xsl:otherwise>
					</xsl:choose>
					</td>
					<td colspan="9" class="textLeft">
						<a href="javascript:EjecutarFuncionDelFrame('zonaCatalogo','CambioFamiliaActual({/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/IDEMPRESA},{ID},\'CAMBIOFAMILIA\');');" style="color:#666666; font-size:13px;">
							<xsl:value-of select="NOMBRE"/>
						</a>&nbsp;
						<a href="javascript:nuevaBusqueda({../ID},{ID});" style="text-decoration:none;"><img src="http://www.newco.dev.br/images/modificarLente.gif" alt="" title=""/></a>
					</td>
				</tr>
				</xsl:if>

				<xsl:for-each select="./SUBFAMILIA">
				<xsl:if test="(/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/SOLO_PRODESTANDAR != 'S') and (./GRUPO/PRODUCTOESTANDAR)">
				<tr>
                   <xsl:attribute name="class">
						<xsl:choose>
                       <xsl:when test="/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/SOLO_PRODESTANDAR = 'S'">subFamilia oculta</xsl:when>
						<xsl:otherwise>subFamilia oculta</xsl:otherwise>
						</xsl:choose>
					</xsl:attribute>
                    <!--columna centro cliente solo para buscador clientes-->
                    <td>&nbsp;</td>
					<td class="bold textLeft">
						<xsl:value-of select="REFERENCIA"/>
					</td>
					<td class="textLeft">

					<xsl:choose>
					<xsl:when test="/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/NUEVO_MODELO">
						&nbsp;
					</xsl:when>
					<xsl:when test="not(/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/MOSTRAR_COLUMNA_REFCLIENTE)">
						&nbsp;
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="REFCLIENTE"/>
					</xsl:otherwise>
					</xsl:choose>
					</td>
					<td colspan="9" class="textLeft">
						<a href="javascript:EjecutarFuncionDelFrame('zonaCatalogo','CambioSubfamiliaActual({/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/IDEMPRESA},{ID},\'CAMBIOSUBFAMILIA\');');" style="color:#666666; font-size:13px;">
							<xsl:value-of select="NOMBRE"/>
						</a>&nbsp;
						<a href="javascript:nuevaBusqueda({../../ID},{../ID},{ID});" style="text-decoration:none;"><img src="http://www.newco.dev.br/images/modificarLente.gif" alt="" title=""/></a>
						<xsl:if test="(//FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/ADMIN or //FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/CDC) and not(//FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/MOSTRARGRUPOS)">
							&nbsp;[<xsl:value-of select="document($doc)/translation/texts/item[@name='ultima_ref_utilizada']/node()"/>:&nbsp;<xsl:value-of select="GRUPO/REFESTANDARMAX"/>]
						</xsl:if>
					</td>
				</tr>
				</xsl:if>

				<xsl:for-each select="./GRUPO">
				<xsl:if test="(/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/SOLO_PRODESTANDAR != 'S') and (./PRODUCTOESTANDAR)">
				<tr>
					<xsl:attribute name="class">
						<xsl:choose>
                        <xsl:when test="/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/SOLO_PRODESTANDAR = 'S'">grupo oculta</xsl:when>
						<xsl:when test="//FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/NOMBRESNIVELES/@MostrarGrupo = 'S'">grupo</xsl:when>
<!--						<xsl:when test="/FamiliasYProductos/ORIGEN = 'CATCLIENTES' and REFERENCIA != ''">grupo</xsl:when>-->
						<xsl:otherwise>grupo oculta</xsl:otherwise>
						</xsl:choose>
					</xsl:attribute>
                   <!--columna centro cliente solo para buscador clientes-->
                   	<td>&nbsp;</td>
                                        
					<td class="bold textLeft">
						<xsl:value-of select="REFERENCIA"/>
					</td>
					<td class="textLeft">

					<xsl:choose>
					<xsl:when test="/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/NUEVO_MODELO">
						&nbsp;
					</xsl:when>
					<xsl:when test="not(/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/MOSTRAR_COLUMNA_REFCLIENTE)">
						&nbsp;
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="REFCLIENTE"/>
					</xsl:otherwise>
					</xsl:choose>
					</td>
					<td colspan="9" class="textLeft">
						<a href="javascript:EjecutarFuncionDelFrame('zonaCatalogo','CambioGrupoActual({/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/IDEMPRESA},{ID},\'CAMBIOGRUPO\');');" style="color:#666666; font-size:13px;">
							<xsl:value-of select="NOMBRE"/>
						</a>&nbsp;
						<a href="javascript:nuevaBusqueda({../../../ID},{../../ID},{../ID},{ID});" style="text-decoration:none;"><img src="http://www.newco.dev.br/images/modificarLente.gif" alt="" title=""/></a>
						<xsl:if test="(//FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/ADMIN or //FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/CDC) and //FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/MOSTRARGRUPOS">
							&nbsp;[<xsl:value-of select="document($doc)/translation/texts/item[@name='ultima_ref_utilizada']/node()"/>:&nbsp;<xsl:value-of select="REFESTANDARMAX"/>]
						</xsl:if>
					</td>
				</tr>
				</xsl:if>

				<!-- productos   -->
				<xsl:for-each select="./PRODUCTOESTANDAR">
					<xsl:if test="((count(PROVEEDOR) = 0))
					or ((count(PROVEEDOR) &gt; 0) and /FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/SINUSAR != 'S')
					or (/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/TODOSPRODUCTOS='S')">

						<!--Mostrar productos no adjudic solo si es mvm, si no solo los adjudicados-->
						<xsl:choose>
						<xsl:when test="(count(PROVEEDOR) &gt; 0)"><!--and /FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/TODOSPRODUCTOS!='S'-->
							<!-- mostramos todos los proveedores -->
							<xsl:if test="PROVEEDOR">
								<xsl:for-each select="PROVEEDOR">
								<tr>
									<xsl:if test="../TRASPASADO">
										<xsl:attribute name="class">fondoRojo</xsl:attribute>
									</xsl:if>
                                    <td><!--columna centro cliente solo para buscador clientes-->
                                    <xsl:choose>
                                        <xsl:when test="//FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/MOSTRAR_COLUMNA_EMPRESA">
                                                <a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPDetalleFrame.xsql?EMP_ID={../IDCLIENTE}','Empresa',100,80,0,-20);">
                                                    <xsl:value-of select="../CLIENTE" />
                                                </a>
                                        </xsl:when>
                                         <xsl:when test="//FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/MOSTRAR_COLUMNA_CENTRO"><!--pinxado checkbox por centro-->
                                                <a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/CENDetalle.xsql?ID={IDCENTRO}','Centro',100,80,0,-20);">
                                                    <xsl:value-of select="CENTRO" />
                                                </a>
                                        </xsl:when>
                                        <xsl:otherwise>&nbsp;</xsl:otherwise>
                                    </xsl:choose>
                                    </td>
                                    <!-- Referencia -->
									<td class="textLeft">
										<span class="bold">
                                        <xsl:choose>
										<xsl:when test="/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/ROL = 'MVMi' or /FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/ADMIN or /FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/CDC">
											<a href="http://www.newco.dev.br/ProcesosCdC/CatalogoPrivado/CatalogacionRapida.xsql?IDPRODESTANDAR={../ID}"><xsl:value-of select="../REFERENCIA"/></a>
											<!--<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/ProcesosCdC/MantenimientoReducido/MantenimientoReducido.xsql?PRO_ID={IDPRODUCTO}&amp;EMP_ID={../IDCLIENTE}','Ficha Catalogación',100,80,0,-20);" class="nodecor">
												<xsl:value-of select="../REFERENCIA"/>
                                            </a>-->
										</xsl:when>
										<xsl:otherwise>
											<xsl:value-of select="../REFERENCIA"/>
										</xsl:otherwise>
										</xsl:choose>
										<xsl:if test="SIN_PLANTILLAS"><span color="rojo">!!</span></xsl:if>
                                        </span>
                                        <!--si hay esta marca enseña centro, CAT PRIVADO-->
                                        <xsl:if test="/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/MOSTRAR_NOMBRE_CENTRO">
                                            <br /><a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/CENDetalle.xsql?ID={IDCENTRO}','Centro',100,80,0,-20);" class="nodecor">
                                                <xsl:value-of select="CENTRO" />
                                            </a>
                                        </xsl:if>
									</td>
									<!-- Referencia Cliente -->
									<td class="textLeft celdaconverde">
											<xsl:choose>
											<xsl:when test="../REFCENTRO!=''">
												<xsl:value-of select="../REFCENTRO"/><xsl:if test="/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/CATALOGO_MULTIOPCION">-<xsl:value-of select="../ORDEN"/></xsl:if>
											</xsl:when>
											<xsl:when test="../REFCLIENTE != ''">
													<xsl:value-of select="../REFCLIENTE"/><xsl:if test="/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/CATALOGO_MULTIOPCION">-<xsl:value-of select="../ORDEN"/></xsl:if>
											</xsl:when>
											</xsl:choose>
									</td>
									<!-- Producto -->
									<td class="textLeft bold">
										<xsl:choose>
										<xsl:when test="/FamiliasYProductos/ORIGEN = 'CATCLIENTES'">
											<xsl:choose>
											<xsl:when test="/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/ROL = 'MVMi'">
												<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Productos/PRODetalle.xsql?PRO_ID={IDPRODUCTO}&amp;IDCLIENTE={../IDCLIENTE}','producto',100,58,0,-50)" class="noDecor">
													<xsl:value-of select="../NOMBRE"/>
												</a>
											</xsl:when>
											<xsl:otherwise>
												<xsl:if test="../REGULADO='S'"><span class="amarillo"><b>[REG]</b></span>&nbsp;</xsl:if><xsl:value-of select="../NOMBRE"/>
											</xsl:otherwise>
											</xsl:choose>
										</xsl:when>
										<xsl:when test="../ID!='' and /FamiliasYProductos/VENTANA!='NUEVA'">
											<xsl:if test="../REGULADO='S'"><span class="amarillo"><b>[REG]</b></span>&nbsp;</xsl:if><a href="javascript:ProdEstandar({/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/IDEMPRESA},{../ID})" class="noDecor"><xsl:value-of select="../NOMBRE"/><xsl:if test="../PRINCIPIOACTIVO!=''">&nbsp;[<xsl:value-of select="../PRINCIPIOACTIVO"/>]</xsl:if></a>
										</xsl:when>
										<xsl:otherwise>
											<xsl:if test="../REGULADO='S'"><span class="amarillo"><b>[REG]</b></span>&nbsp;</xsl:if><xsl:value-of select="../NOMBRE"/><xsl:if test="../PRINCIPIOACTIVO!=''">&nbsp;[<xsl:value-of select="../PRINCIPIOACTIVO"/>]</xsl:if>
										</xsl:otherwise>
										</xsl:choose>
									</td>
									<!--	Marcas aceptables	-->
									<td class="textLeft bold">
										<xsl:value-of select="../MARCASACEPTABLES"/>
									</td>
									<!-- Proveedor y su referencia-->
									<td class="textLeft">
										<xsl:if test="/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/CATALOGO_MULTIOPCION">
											<a class="noDecor" href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/ProcesosCdC/CatalogoPrivado/Homologacion.xsql?IDEMPRESA={../IDCLIENTE}&amp;IDCENTRO=&amp;REFERENCIA={../REFERENCIA}','producto',100,58,0,-50)">H</a>
										</xsl:if>
                                    </td>
									<xsl:choose>
									<xsl:when test="/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/ROL != 'VENDEDOR'">
										<td class="textLeft">
											<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPDetalleFrame.xsql?EMP_ID={ID}&amp;VENTANA=NUEVA','empresa',100,58,0,-50)" class="noDecor">
												<xsl:value-of select="NOMBRE"/>
											</a>
                                    	</td>
										<td class="textLeft">
											<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Productos/PRODetalle.xsql?PRO_ID={IDPRODUCTO}&amp;IDCLIENTE={../IDCLIENTE}','producto',100,58,0,-50)" class="noDecor"><xsl:value-of select="REFERENCIA"/></a>
                                    	</td>
									</xsl:when>
									<xsl:otherwise>
										<td class="textLeft">
											<xsl:value-of select="NOMBRE"/>
                                    	</td>
										<td class="textLeft">
											<xsl:value-of select="REFERENCIA"/>
                                    	</td>
									</xsl:otherwise>
									</xsl:choose>
									<!-- Resto de campos -->
									<td>
                                     <xsl:choose>
                                      <xsl:when test="/FamiliasYProductos/ORIGEN = 'CATCLIENTES'">&nbsp;</xsl:when>
                                      <xsl:otherwise><xsl:value-of select="UNIDADBASICA"/></xsl:otherwise>
                                     </xsl:choose>
                                    </td>
                                    
                                    <!-- Precio -->
                                    <td>
                                        <!-- DC - 26may14 - Aplicamos colores a los precios cuando se trata de variantes de productos que tienen distinto precio -->
                                        <xsl:choose>
                                        <xsl:when test="BARATO">
                                            <xsl:attribute name="style">color:green;</xsl:attribute>
                                        </xsl:when>
                                        <xsl:when test="CARO">
                                            <xsl:attribute name="style">color:red;</xsl:attribute>
                                        </xsl:when>
                                        <xsl:when test="IGUAL">
                                            <xsl:attribute name="style">color:blue;</xsl:attribute>
                                        </xsl:when>
                                        </xsl:choose>
                                        <!--cambio condiciones 24-11-2014 mc-->
                                        <xsl:choose>
										<xsl:when test="/FamiliasYProductos/ORIGEN = 'CATCLIENTES' and /FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/NO_MOSTRAR_PRECIO">&nbsp;</xsl:when>
										<xsl:otherwise>
											<xsl:choose>
											<xsl:when test="/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/NUEVO_MODELO"><!--gomosa-->
												<xsl:choose>
                                				<xsl:when test="COSTE_TOTAL != ''"><xsl:value-of select="COSTE_TOTAL"/></xsl:when>
                                				<xsl:when test="PRECIOACTUAL_IVA != ''"><xsl:value-of select="PRECIOACTUAL_IVA"/></xsl:when>
                                				</xsl:choose>
											</xsl:when>
                            				<xsl:when test="/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/MOSTRAR_PRECIO_IVA"><!--optima-->
												<xsl:value-of select="PRECIOACTUAL_IVA"/>
											</xsl:when>
											<xsl:otherwise><!--tipo asisa-->
												<xsl:value-of select="TRF_IMPORTE"/>
											</xsl:otherwise>
											</xsl:choose>
										</xsl:otherwise>
										</xsl:choose>
										</td>
										<!-- Validez Precio -->
										<td>
											<img src="http://www.newco.dev.br/images/info.gif" class="static">
											<xsl:attribute name="title">
												<xsl:value-of select="document($doc)/translation/texts/item[@name='Fec_inic_tarifa']/node()"/>:&nbsp;<xsl:value-of select="TRF_FECHAINICIO"/>,<xsl:value-of select="document($doc)/translation/texts/item[@name='Fec_fin_tarifa']/node()"/>:&nbsp;<xsl:value-of select="TRF_FECHALIMITE"/>, <xsl:value-of select="document($doc)/translation/texts/item[@name='Doc_tarifa']/node()"/>:&nbsp;<xsl:value-of select="TRF_NOMBREDOCUMENTO"/>, <xsl:value-of select="document($doc)/translation/texts/item[@name='Tipo_negociacion']/node()"/>:&nbsp;<xsl:value-of select="TIPONEGOCIACION"/>
											</xsl:attribute>
											</img>&nbsp;
                        					<xsl:choose>
                        					<xsl:when test="/FamiliasYProductos/ORIGEN = 'CATCLIENTES' and not(/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/MODIFICAR_FECHA_OFERTA)">
                            					<xsl:value-of select="TRF_FECHALIMITE"/>
                        					</xsl:when>
                        					<xsl:otherwise>
												<xsl:choose>
												<xsl:when test="/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/MODIFICAR_FECHA_OFERTA and ../IDOFERTA = ''">
                            						<input type="hidden" name="CLIENTE_ID" id="CLIENTE_ID_{IDPRODUCTO}" value="{/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/IDEMPRESA}"/>
                            						<input type="text" name="FECHA_CADUCIDAD" id="FECHA_CADUCIDAD_{IDPRODUCTO}" value="{TRF_FECHALIMITE}" class="noinput" style="width:100px;" size="8"/>
                            						<a style="text-decoration:none;" href="javascript:cambiaFecha({IDPRODUCTO});" id="ModificaFecha_{IDPRODUCTO}">
                            							<img src="http://www.newco.dev.br/images/modificar.gif" alt="Modificar Fecha"/>
                            						</a>
                            						<a style="text-decoration:none;display:none;" href="javascript:actualizarFechaLimite({IDPRODUCTO});" id="EnviarFecha_{IDPRODUCTO}">
                            							<img src="http://www.newco.dev.br/images/botonEnviar.gif" alt="Enviar Fecha Límite"/>
                            						</a>
												</xsl:when>
												<xsl:otherwise>
													<xsl:value-of select="TRF_FECHALIMITE"/>&nbsp;
                            						<a href="javascript:verOferta({../IDOFERTA})"><img src="http://www.newco.dev.br/images/ofe.gif" alt="Oferta"/></a>
												</xsl:otherwise>
												</xsl:choose>
                    						</xsl:otherwise>
                    						</xsl:choose>
                						</td>
										<!-- Comision -->
										<xsl:choose>
										<xsl:when test="/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/MOSTRAR_COMISION_MVM and /FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/NUEVO_MODELO">
											<td><xsl:value-of select="COMISIONMVM_PORC"/>%</td>
										</xsl:when>
										<xsl:otherwise><td class="zerouno"></td></xsl:otherwise>
										</xsl:choose>
										<!-- Margen -->
										<xsl:choose>
										<xsl:when test="(/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/ADMIN or/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/CDC) and /FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/NUEVO_MODELO">
											<td><xsl:value-of select="MARGEN"/></td>
										</xsl:when>
										<xsl:otherwise><td class="zerouno"></td></xsl:otherwise>
										</xsl:choose>

										<xsl:choose>
										<xsl:when test="/FamiliasYProductos/ADJUDICADO = 'S' and /FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/MOSTRAR_CONSUMOS">
											<xsl:variable name="consumo"><xsl:value-of select="CONSUMO"/></xsl:variable>
											<xsl:variable name="consumo_reciente"><xsl:value-of select="CONSUMORECIENTE"/></xsl:variable>
											<!-- Consumo ultimo anyo -->
											<td>
                						   <xsl:variable name="refProd">
                        						<xsl:choose>
                            						<xsl:when test="../REFCLIENTE != ''"><xsl:value-of select="../REFCLIENTE"/></xsl:when>
                            						<xsl:otherwise><xsl:value-of select="../REFERENCIA"/></xsl:otherwise>
                        						</xsl:choose>
                    						</xsl:variable>

                            			<xsl:choose>
			<!--
                            			<xsl:when test="//FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/MOSTRAR_COLUMNA_EMPRESA">
                                			<a class="noDecor" href="javascript:MostrarEIS('COPedidosPorEmpEur','{../IDCLIENTE}','','{$refProd}','9999');">
                                			 <xsl:value-of select="$consumo"/>
                                			</a>
                            			</xsl:when>
			-->
                            			<xsl:when test="//FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/MOSTRAR_COLUMNA_CENTRO">
                                			<a class="noDecor" href="javascript:MostrarEIS('CO_Pedidos_Eur','{../IDCLIENTE}','{IDCENTRO}','{$refProd}','9999');">
                                    			<xsl:value-of select="$consumo"/>
                                			</a>
                            			</xsl:when>
                            			<xsl:when test="//FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/MOSTRAR_NOMBRE_CENTRO">
                                			 <a class="noDecor" href="javascript:MostrarEIS('CO_Pedidos_Eur','{../IDCLIENTE}','{IDCENTRO}','{$refProd}','9999');">
                                			 <xsl:value-of select="$consumo"/>
                                			</a>
                            			</xsl:when>
                            			<xsl:otherwise>
                                			<a class="noDecor" href="javascript:MostrarEIS('CO_Pedidos_Eur','{../IDCLIENTE}','{IDCENTRO}','{$refProd}','9999');">
                                			 <xsl:value-of select="$consumo"/>
                                			</a>
                            			</xsl:otherwise>
			<!--
                            			<xsl:otherwise><xsl:value-of select="$consumo"/></xsl:otherwise>
			-->
                        			</xsl:choose>
                                                                        
										</td>
										<!-- Consumo reciente -->
										<td>
											<xsl:value-of select="$consumo_reciente"/>
											<xsl:choose>
											<xsl:when test="$consumo_reciente = $consumo and $consumo &gt; 0">
												&nbsp;<img src="http://www.newco.dev.br/images/bolaVerde.gif"/>
											</xsl:when>
											<xsl:when test="$consumo_reciente = 0 and $consumo &gt; 0">
												&nbsp;<img src="http://www.newco.dev.br/images/bolaRoja.gif"/>
											</xsl:when>
											</xsl:choose>
										</td>
									</xsl:when>
									<xsl:otherwise>
										<td colspan="2"></td>
									</xsl:otherwise>
									</xsl:choose>
								</tr>
								</xsl:for-each>
							</xsl:if>
						</xsl:when>
						<xsl:otherwise>
							<xsl:choose>
							<xsl:when test="PROVEEDOR">
								<xsl:for-each select="PROVEEDOR">
								<tr>
									<xsl:if test="TRASPASADO">
										<xsl:attribute name="class">fondoRojo</xsl:attribute>
									</xsl:if>
                                    <td><!--columna centro cliente solo para buscador clientes-->
                                    <xsl:choose>
                                        <xsl:when test="//FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/MOSTRAR_COLUMNA_EMPRESA">
                                                <a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPDetalleFrame.xsql?EMP_ID={../IDCLIENTE}','Empresa',100,80,0,-20);">
                                                    <xsl:value-of select="../CLIENTE" />
                                                </a>
                                        </xsl:when>
                                         <xsl:when test="//FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/MOSTRAR_COLUMNA_CENTRO"><!--pinxado checkbox por centro-->
                                                <a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/CENDetalle.xsql?ID={IDCENTRO}','Centro',100,80,0,-20);">
                                                    <xsl:value-of select="CENTRO" />
                                                </a>
                                        </xsl:when>
                                        <xsl:otherwise>&nbsp;</xsl:otherwise>
                                    </xsl:choose>
                                    </td>
									<!-- Referencia -->
									<td class="textLeft bold">
										<xsl:value-of select="../REFERENCIA"/>
											<!--<xsl:value-of select="../REFERENCIA"/>-->
										<xsl:if test="SIN_PLANTILLAS"><span color="rojo">!!</span></xsl:if>
                                         <!--si hay esta marca enseña centro, CAT PRIVADO-->
                                        <xsl:if test="/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/MOSTRAR_NOMBRE_CENTRO">
                                            <br /><a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/CENDetalle.xsql?ID={IDCENTRO}','Centro',100,80,0,-20);" class="nodecor">
                                                <xsl:value-of select="CENTRO" />
                                            </a>
                                        </xsl:if>
									</td>
									<!-- Referencia Cliente -->
									<td class="textLeft celdaconverde">
										<xsl:if test="../REFCLIENTE != ''">
											<xsl:value-of select="../REFCLIENTE"/>
										</xsl:if>
									</td>
									<!-- Producto -->
									<td class="textLeft bold">
										<xsl:choose>
										<xsl:when test="../ID!='' and /FamiliasYProductos/VENTANA!='NUEVA'">
											<a href="javascript:ProdEstandar({/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/IDEMPRESA},{../ID})" class="noDecor">
												<xsl:value-of select="../NOMBRE"/><xsl:if test="../PRINCIPIOACTIVO!=''">&nbsp;[<xsl:value-of select="../PRINCIPIOACTIVO"/>]</xsl:if>
											</a>
										</xsl:when>
										<xsl:otherwise><xsl:value-of select="../NOMBRE"/><xsl:if test="../PRINCIPIOACTIVO!=''">&nbsp;[<xsl:value-of select="../PRINCIPIOACTIVO"/>]</xsl:if></xsl:otherwise>
										</xsl:choose>
									</td>
									<!-- Proveedor y su referencia -->
									<td class="textLeft">
										<xsl:choose>
										<xsl:when test="/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/ROL != 'VENDEDOR'">
											<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPDetalleFrame.xsql?EMP_ID={ID}&amp;VENTANA=NUEVA','empresa',100,58,0,-50)" class="noDecor">
												<xsl:value-of select="NOMBRE"/>
											</a>
											(<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Productos/PRODetalle.xsql?PRO_ID={IDPRODUCTO}&amp;IDCLIENTE={../IDCLIENTE}','producto',100,58,0,-50)" class="noDecor"><xsl:value-of select="REFERENCIA"/></a>)
										</xsl:when>
										<xsl:otherwise>
											<!--<xsl:if test="NOMBRECORTO != ''">-->
											<xsl:value-of select="NOMBRE"/>&nbsp;(<xsl:value-of select="REFERENCIA"/>)
											<!--</xsl:if>-->
										</xsl:otherwise>
										</xsl:choose>
                                                                        </td>
									<!-- Resto de campos -->
									<td><xsl:value-of select="UNIDADBASICA"/></td>
									<!-- Precio -->
									<td>
										<!-- DC - 26may14 - Aplicamos colores a los precios cuando se trata de variantes de productos que tienen distinto precio -->
										<xsl:choose>
										<xsl:when test="BARATO">
    										<xsl:attribute name="style">color:green;</xsl:attribute>
										</xsl:when>
										<xsl:when test="CARO">
    										<xsl:attribute name="style">color:red;</xsl:attribute>
										</xsl:when>
										<xsl:when test="IGUAL">
    										<xsl:attribute name="style">color:blue;</xsl:attribute>
										</xsl:when>
										</xsl:choose>
										<xsl:choose>
										<xsl:when test="/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/MOSTRAR_PRECIO_IVA">
											<xsl:value-of select="PRECIOACTUAL_IVA"/>
										</xsl:when>
										<xsl:otherwise><xsl:value-of select="COSTE_TOTAL"/></xsl:otherwise>
										</xsl:choose>
									</td>
									<!-- Validez Precio -->
									<td class="font10"><xsl:value-of select="../FECHACADUCIDAD"/></td>
									<!-- Comision -->
									<xsl:choose>
									<xsl:when test="/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/MOSTRAR_COMISION_MVM">
										<td><xsl:value-of select="COMISIONMVM_PORC"/>%</td>
									</xsl:when>
									<xsl:otherwise><td class="zerouno"></td></xsl:otherwise>
									</xsl:choose>
									<td class="zerouno"></td>
								</tr>
								</xsl:for-each>
							</xsl:when>
							<xsl:otherwise>
								<tr>
									<xsl:if test="TRASPASADO">
										<xsl:attribute name="class">fondoRojo</xsl:attribute>
									</xsl:if>
                                	<td><!--columna centro cliente solo para buscador clientes-->
                                	<xsl:choose>
                                    	<xsl:when test="//FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/MOSTRAR_COLUMNA_EMPRESA">
                                            	<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPDetalleFrame.xsql?EMP_ID={IDCLIENTE}','Empresa',100,80,0,-20);">
                                                	<xsl:value-of select="CLIENTE" />
                                            	</a>
                                    	</xsl:when>
                                    	 <xsl:when test="//FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/MOSTRAR_COLUMNA_CENTRO"><!--pinxado checkbox por centro-->
                                            	<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/CENDetalle.xsql?ID={IDCENTRO}','Centro',100,80,0,-20);">
                                                	<xsl:value-of select="CENTRO" />
                                            	</a>
                                    	</xsl:when>
                                    	<xsl:otherwise>&nbsp;</xsl:otherwise>
                                	</xsl:choose>
                                	</td>
									<!-- Referencia -->
									<td class="textLeft bold">
										<xsl:choose>
										<xsl:when test="/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/ROL = 'MVMi'">
												<a href="http://www.newco.dev.br/ProcesosCdC/CatalogoPrivado/CatalogacionRapida.xsql?IDPRODESTANDAR={ID}"><xsl:value-of select="REFERENCIA"/></a>
										</xsl:when>
										<xsl:otherwise>
                                            <!--si cdc o admin enlazo a precios historicos por centro-->
                                            <xsl:choose>
                                                <xsl:when test="/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/ADMIN or /FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/CDC">
													<a href="http://www.newco.dev.br/ProcesosCdC/CatalogoPrivado/CatalogacionRapida.xsql?IDPRODESTANDAR={ID}"><xsl:value-of select="REFERENCIA"/></a>
                                                 <!--   <a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/ProcesosCdC/MantenimientoReducido/HistoricosCentros.xsql?ID_EMP={IDCLIENTE}&amp;ID_PROD_ESTANDAR={ID}','Centro',100,80,0,0);"><xsl:value-of select="REFERENCIA"/></a>-->
                                                </xsl:when>
                                                <xsl:otherwise>
                                                    <xsl:value-of select="REFERENCIA"/>
                                                </xsl:otherwise>
                                            </xsl:choose>
											
										</xsl:otherwise>
										</xsl:choose>

										<xsl:if test="SIN_PLANTILLAS"><span color="rojo">!!</span></xsl:if>
                                             <!--si hay esta marca enseña centro, CAT PRIVADO-->
                                            <xsl:if test="/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/MOSTRAR_NOMBRE_CENTRO">
                                                <br /><a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/CENDetalle.xsql?ID={IDCENTRO}','Centro',100,80,0,0);" class="nodecor">
                                                    <xsl:value-of select="CENTRO" />
                                                </a>
                                            </xsl:if>
									</td>
									<!-- Referencia Cliente -->
									<td class="textLeft celdaconverde">
<!-- DC - 24/07/14 - No se mostraba Ref. Cliente en el catálogo clientes
										<xsl:if test="//FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/ADMIN_CDC and REFCLIENTE != ''">
											<xsl:value-of select="REFCLIENTE"/>
										</xsl:if>
-->
										<xsl:choose>
										<xsl:when test="/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/NUEVO_MODELO">
											&nbsp;
										</xsl:when>
										<xsl:when test="not(/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/MOSTRAR_COLUMNA_REFCLIENTE)">
											&nbsp;
										</xsl:when>
										<xsl:otherwise>
											<xsl:choose>
											<xsl:when test="REFCENTRO!=''">
												<xsl:value-of select="REFCENTRO"/>
											</xsl:when>
											<xsl:otherwise>
												<xsl:value-of select="REFCLIENTE"/>
											</xsl:otherwise>
											</xsl:choose>
										</xsl:otherwise>
										</xsl:choose>
									</td>
									<!-- Producto -->
									<td class="textLeft bold">
										<a href="javascript:ProdEstandar({/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/IDEMPRESA},{ID})" class="noDecor">
											<xsl:value-of select="NOMBRE"/><xsl:if test="PRINCIPIOACTIVO!=''">&nbsp;[<xsl:value-of select="PRINCIPIOACTIVO"/>]</xsl:if>
										</a>
										<xsl:if test="TRASPASADO">
											-> <xsl:value-of select="TRASPASADO/REFERENCIA"/>:&nbsp;<xsl:value-of select="TRASPASADO/NOMBRE"/>
										</xsl:if>
									</td>
									<!--	Marcas aceptables	-->
									<td class="textLeft bold">
										<xsl:value-of select="MARCASACEPTABLES"/>
									</td>
									<!-- Resto de campos -->
									<td colspan="8">&nbsp;</td>
								</tr>
							</xsl:otherwise>
							</xsl:choose>
						</xsl:otherwise>
						</xsl:choose>
					</xsl:if><!--fin de if antes de chooose-->
				</xsl:for-each><!--3 for each de inicio-->
				</xsl:for-each>
				</xsl:for-each>
				</xsl:for-each>
				</xsl:for-each>
			</tbody>
			</table><!--fin de grandeInicio-->
                        </div>
			<br /><br />
		</xsl:otherwise>
		</xsl:choose>
	</xsl:otherwise>
	</xsl:choose>
</body>
</html>
</xsl:template>
</xsl:stylesheet>
