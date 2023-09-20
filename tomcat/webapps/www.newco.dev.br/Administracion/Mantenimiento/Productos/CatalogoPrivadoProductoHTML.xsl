<?xml version="1.0" encoding="iso-8859-1"?>
<!--
    Buscador de productos en catalogos privados
	Revisado: ET 27ago21 16:00
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:import href="http://www.newco.dev.br/General/General.xsl"/>
<xsl:param name="usuario" select="@US_ID"/>
<xsl:template match="/">

<html>
<head>
  <!--idioma-->
  <xsl:variable name="lang">
    <xsl:choose>
    <xsl:when test="/CatalogoPrivado/LANG"><xsl:value-of select="/CatalogoPrivado/LANG"/></xsl:when>
    <xsl:otherwise>spanish</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
  <!--idioma fin-->

  <title>
    <xsl:value-of select="document($doc)/translation/texts/item[@name='central_compras_material_sanitario']/node()"/>&nbsp;-&nbsp;
    <xsl:value-of select="document($doc)/translation/texts/item[@name='catalogo_privado']/node()"/>&nbsp;-&nbsp;
    <xsl:value-of select="document($doc)/translation/texts/item[@name='medicalvm']/node()"/>
  </title>

	<link rel="shortcut icon" href="http://www.newco.dev.br/images/MedicalVM.ico"/>

	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->

	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>
	<script type="text/javascript">
	var alrt_CambiarProductoEstandar	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='cambiar_producto_estandar']/node()"/>';
	</script>

<xsl:text disable-output-escaping="yes">
<![CDATA[
  <script type="text/javascript">
  <!--
	function Buscar(){
		var form = document.forms['catalogo'];
		var idEmpresa = form.elements['IDEMPRESA'].value;
    	var origen = form.elements['ORIGEN'].value;
    	var inputSol = form.elements['INPUT_SOL'].value;
		var dataSol = "ORIGEN="+origen+"&INPUT_SOL="+inputSol;

		//si busco desde el manten reducido, catalogo de producto
		if((idEmpresa != '') && (origen != 'SOLICITUD')){
			document.forms['catalogo'].action="http://www.newco.dev.br/Administracion/Mantenimiento/Productos/CatalogoPrivadoProductoEmpresa.xsql?ORIGEN="+origen;
			SubmitForm(document.forms['catalogo']);
		}
      	else if ((origen == 'SOLICITUD') || (origen == 'LICITACION')	|| (origen == 'PEDIDOSTEXTO'))
		{
			document.forms['catalogo'].action="http://www.newco.dev.br/Administracion/Mantenimiento/Productos/CatalogoPrivadoProductoEmpresa.xsql?"+dataSol;
			SubmitForm(document.forms['catalogo']);
		}
		else
		{
			document.forms['catalogo'].action="http://www.newco.dev.br/Administracion/Mantenimiento/Productos/CatalogoPrivadoProducto.xsql";
			SubmitForm(document.forms['catalogo']);
		}
	}

	function InsertarMantenimientoReducido(ref){
		var objFrameTop=new Object();
		objFrameTop=window.opener.top;
		var FrameOpenerName=window.opener.name;
		var objFrame=new Object();
		objFrame=obtenerFrame(objFrameTop,FrameOpenerName);

		//inserto ref en campo input referencia
		var formMant = objFrame.document.forms['form1'];
		formMant.elements['REFERENCIACLIENTE'].value = ref;

		window.close();
	}

	function InsertarPROManten(ref,precio,udba)
	{
		var objFrameTop=new Object();
		objFrameTop=window.opener.top;
		var FrameOpenerName=window.opener.name;
		var objFrame=new Object();
		objFrame=obtenerFrame(objFrameTop,FrameOpenerName);

		objFrame.document.getElementById('refPrecioObjetivo').style.display = 'none';
		//inserto ref en campo input referencia
		var formMant = objFrame.document.forms['form1'];
		formMant.elements['PRO_REF_ESTANDAR'].value = ref;

		if(precio != '')
		{
			formMant.elements['PRECIO_CAT_PRIV'].value = precio;
			formMant.elements['UDBA_CAT_PRIV'].value = udba;
			objFrame.document.getElementById('refPrecioObjetivo').style.display = 'block';
		}
		else
		{
		objFrame.document.getElementById('refPrecioObjetivo').style.display = 'none';
      	}

		window.close();
	}

    //insertar la ref producto en campo input de nueva evaluacion producto
    function InsertarPROEvaluacion(ref)
	{
		var objFrameTop=new Object();
		objFrameTop=window.opener.top;
		var FrameOpenerName=window.opener.name;
		var objFrame=new Object();

		objFrame=obtenerFrame(objFrameTop,FrameOpenerName);

		//inserto ref en campo input referencia
		var form = objFrame.document.forms['EvaluacionProducto'];
		form.elements['REF_PROD'].value = ref;
		objFrame.document.getElementById("botonBuscarEval").style.display = 'none';
		objFrame.document.getElementById("botonRecuperarProd").style.display = 'block';

		//llamo la funciona en evaluaciones.js
		window.opener.top.RecuperarDatosProducto();
		window.close();
	}

    //insertar la ref producto en campo input de nueva oferta stock
    function InsertarPROStock(ref){
		var objFrameTop=new Object();
		objFrameTop=window.opener.top;
		var FrameOpenerName=window.opener.name;
		var objFrame=new Object();

		objFrame=obtenerFrame(objFrameTop,FrameOpenerName);

		//inserto ref en campo input referencia
		var form = objFrame.document.forms['frmStockOfertaID'];
		form.elements['STOCK_REF_CLIENTE'].value = ref;

		//llamo la funciona en stockoferta.js
		window.opener.top.RecuperarDatosProducto();
		window.close();
		}

    //insertar la ref producto en campo input de una solicitud
    function InsertarPROSolicitud(ref,inputSol)
	{
		var objFrameTop=new Object();
		objFrameTop=window.opener.top;
		var FrameOpenerName=window.opener.name;
		var objFrame=new Object();

		objFrame=obtenerFrame(objFrameTop,FrameOpenerName);

		//inserto ref en campo input referencia
		var form = objFrame.document.forms['SolicitudCatalogacion'];
		form.elements[inputSol].value = ref;

		var solProdID = jQuery('#INPUT_SOL').val().replace('PROD_ESTAN_','');
		var IDEmpresa = jQuery('#IDEMPRESA').val();
		//llamo la funciona en solicitudes.js
		window.opener.top.recuperarIDProdEstandard(IDEmpresa,solProdID);

		//objFrame.document.getElementById("botonBuscarEval").style.display = 'none';
		//objFrame.document.getElementById("botonRecuperarProd").style.display = 'block';

		window.close();
	}

    //insertar la ref producto en campo input grande de licitacion de productos
    function InsertarPROLicitacion(ref)
	{
		var objFrameTop=new Object();
		objFrameTop=window.opener.top;
		//console.log('objFrameTop: '+objFrameTop);
		var FrameOpenerName=window.opener.name;
		//console.log('FrameOpenerName: '+FrameOpenerName);
		var objFrame=new Object();
		objFrame=obtenerFrame(objFrameTop,FrameOpenerName);
		//console.log('objFrame: '+objFrame);
		//inserto ref en campo input referencia
		var form = objFrame.document.forms['RefProductos'];
		//console.log('form: '+form);
		//compruebo si el producto ya esta insertado
		if(form.elements['LIC_LISTA_REFPRODUCTO'].value.match(ref))
		{
			alert(document.forms['mensajeJS'].elements['REF_YA_INSERTADA'].value);
		}
		else
		{
			form.elements['LIC_LISTA_REFPRODUCTO'].value += ref+'\n';
		}
	}
  //-->
 
    //insertar la ref producto en campo input grande pedidos desde fichero de texto
    function InsertarPrepararPedidoTexto(ref)
	{

		console.log('InsertarPrepararPedidoTexto: '+ref);

		var objFrameTop=new Object();
		objFrameTop=window.opener.top;
		console.log('objFrameTop: '+objFrameTop);

		var FrameOpenerName=window.opener.name;
		console.log('FrameOpenerName: '+FrameOpenerName);

		var objFrame=new Object();
		objFrame=obtenerFrame(objFrameTop,FrameOpenerName);
		console.log('objFrame: '+objFrame);
		
		//inserto ref en campo input referencia
		var form = objFrame.document.forms['SubirDocumentos'];
		console.log('form: '+form);
		//compruebo si el producto ya esta insertado
		if(form.elements['TXT_PRODUCTOS'].value.match(ref))
		{
			alert(document.forms['mensajeJS'].elements['REF_YA_INSERTADA'].value);
		}
		else
		{
			form.elements['TXT_PRODUCTOS'].value += ref+'\n';
		}
	}

    //insertar la ref producto en campo input de mantenimiento de pedidos
    function InsertarMantenimientoPedido(ref)
	{

		console.log('InsertarMantenimientoPedido '+ref);

		var objFrameTop=new Object();
		objFrameTop=window.opener.top;
		console.log('objFrameTop: '+objFrameTop);
		
		//inserto ref en campo input referencia
		var form = objFrameTop.document.forms['frmMantenPedido'];
		//console.log('form: '+form);
		//compruebo si el producto ya esta insertado
		if(form.elements['NEWLINE_REFPROV'].value==ref)
		{
			alert(document.forms['mensajeJS'].elements['REF_YA_INSERTADA'].value);
		}
		else
		{
			form.elements['NEWLINE_REFPROV'].value = ref+'\n';
		}
	}

    //Activar el cambio de producto estandar en la ficha de producto de licitacion
    function SustituirProductoLicitacion(id, ref, nombre, marca)
	{

		//console.log('SustituirProductoLicitacion id:'+id+'. ref'+ref+'. nombre'+nombre);

		var objFrameTop=new Object();
		objFrameTop=window.opener.top;
		//console.log('objFrameTop: '+objFrameTop);
		
		//	El aviso lo mostramos desde esta pagina
		if (marca!='') nombre=nombre+' ['+marca+']';
		if (confirm(alrt_CambiarProductoEstandar.replace('[[REF]]',ref).replace('[[PRODUCTO]]',nombre)))
		{
			objFrameTop.SustituirProductoLicitacion(id, ref, nombre);
			window.close();
		}
	}
  //-->

 	//	18ago16	Funciones para paginación del listado
	function Pagina0() {BuscarDesde0();}
	function BuscarDesde0() {document.forms[0].elements['PAGINA'].value=0; Buscar();}
	function PaginaAnterior() {document.forms[0].elements['PAGINA'].value=parseInt(document.forms[0].elements['PAGINA'].value)-1; Buscar();}
	function PaginaSiguiente() {document.forms[0].elements['PAGINA'].value=parseInt(document.forms[0].elements['PAGINA'].value)+1; Buscar();}
	</script>
]]>
</xsl:text>
</head>

<body>
  <!--idioma-->
  <xsl:variable name="lang">
    <xsl:choose>
    <xsl:when test="/CatalogoPrivado/LANG"><xsl:value-of select="/CatalogoPrivado/LANG"/></xsl:when>
    <xsl:otherwise>spanish</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
  <!--idioma fin-->

  <xsl:choose>
	<!-- Error en alguna sentencia del XSQL -->
	<xsl:when test="CatalogoPrivado/xsql-error">
		<xsl:apply-templates select="CatalogoPrivado/xsql-error"/>
	</xsl:when>
	<xsl:otherwise>
		<!--	/AreaPublica	-->
		<div class="ZonaTituloPagina">
		<p class="Path"><xsl:value-of select="document($doc)/translation/texts/item[@name='Inicio']/node()"/>&nbsp;/&nbsp;<span class="FinPath"><xsl:value-of select="document($doc)/translation/texts/item[@name='catalogo_privado']/node()"/></span></p>
		<p class="TituloPagina">
			<xsl:value-of select="/CatalogoPrivado/CATALOGO/EMPRESA"/>:&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='catalogo_privado']/node()"/>
			<span class="CompletarTitulo" style="width:100px;">
				<a class="btnNormal" href="javascript:window.close();">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='cerrar']/node()"/>
				</a>
			</span>
		</p>
		</div>
		<br/>		
		<br/>		

		<!--<h1 class="titlePage"><xsl:value-of select="/CatalogoPrivado/CATALOGO/EMPRESA"/>:&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='catalogo_privado']/node()"/></h1>-->
		<form name="catalogo" method="post">
		<input type="hidden" id="IDEMPRESA" name="IDEMPRESA" value="{/CatalogoPrivado/CATALOGO/IDEMPRESA}"/>
		<input type="hidden" id="ORIGEN" name="ORIGEN" value="{/CatalogoPrivado/ORIGEN}"/>
		<input type="hidden" id="INPUT_SOL" name="INPUT_SOL" value="{/CatalogoPrivado/INPUT_SOL}"/>
		<input type="hidden" id="PAGINA" name="PAGINA" value="{/CatalogoPrivado/CATALOGO/FILTROS/PAGINA}"/>
		<input type="hidden" id="IDPROVEEDOR" name="IDPROVEEDOR" value="{/CatalogoPrivado/CATALOGO/FILTROS/IDPROVEEDOR}"/>
		<input type="hidden" id="IDDIVISA" name="IDDIVISA" value="{/CatalogoPrivado/CATALOGO/FILTROS/IDDIVISA}"/>

	<xsl:if test="/CatalogoPrivado/CATALOGO/FILTROS/IDPROVEEDOR!=''">
		<p style="font-size: 15px;">&nbsp;&nbsp;&nbsp;&nbsp;<label><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/>:</label>&nbsp;<strong><xsl:value-of select="/CatalogoPrivado/CATALOGO/FILTROS/PROVEEDOR"/></strong></p><BR/>
	</xsl:if >
	<xsl:if test="/CatalogoPrivado/CATALOGO/FILTROS/IDDIVISA!=''">	
		<p style="font-size: 15px;">&nbsp;&nbsp;&nbsp;&nbsp;<label><xsl:value-of select="document($doc)/translation/texts/item[@name='divisa']/node()"/>:</label>&nbsp;<strong><xsl:value-of select="/CatalogoPrivado/CATALOGO/FILTROS/DIVISA"/></strong></p>
	</xsl:if >
		<br/>		
		<br/>		
      <table class="buscador" border="0">
      <thead>
        <xsl:choose>
        <xsl:when test="/CatalogoPrivado/CATALOGO/FILTROS/PUBLICO = 'N'"><!--si publico = N enseño tb ref cliente-->
        	<tr class="subTituloTabla">
            	<td style="width:150px;"><xsl:value-of select="document($doc)/translation/texts/item[@name='referencia']/node()"/></td>
            	<td style="width:150px;"><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_cliente']/node()"/></td>
            	<td style="width:*;text-align:left;"><xsl:value-of select="document($doc)/translation/texts/item[@name='descripcion']/node()"/></td>
				<xsl:choose>
        		<xsl:when test="/CatalogoPrivado/CATALOGO/GRUPODESTOCK">
					<td style="width:200px;">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='Grupo_stock']/node()"/>
					</td>
				</xsl:when>
				<xsl:otherwise>
					<td style="width:1px;">&nbsp;</td>
				</xsl:otherwise>
				</xsl:choose>
            	<td>
					<xsl:attribute name="style">
						<xsl:choose>
       					<xsl:when test="/CatalogoPrivado/CATALOGO/GRUPODESTOCK">width:200px;</xsl:when>
						<xsl:otherwise>width:400px;</xsl:otherwise>
						</xsl:choose>
					</xsl:attribute>
					<xsl:value-of select="document($doc)/translation/texts/item[@name='marca']/node()"/>
				</td>
				<td style="width:300px;">&nbsp;</td>
				<td>&nbsp;</td>
			</tr>
          <tr class="subTituloTabla">
            <td colspan="2">
				&nbsp;
              <xsl:choose>
              <xsl:when test="/CatalogoPrivado/REFERENCIA != '' and /CatalogoPrivado/IDEMPRESA != ''">
                <input type="text" id="REFERENCIA" name="REFERENCIA" maxlength="8" size="20" value="{/CatalogoPrivado/REFERENCIA}" />
              </xsl:when>
              <xsl:otherwise>
                <input type="text" id="REFERENCIA" name="REFERENCIA" maxlength="8" size="20" value="{/CatalogoPrivado/CATALOGO/FILTROS/REFERENCIA}" />
              </xsl:otherwise>
              </xsl:choose>
            </td>
            <td class="textLeft">
              <xsl:choose>
              <xsl:when test="/CatalogoPrivado/CATALOGO/FILTROS/DESCRIPCION != ''">
                <input type="text" id="DESCRIPCION" name="DESCRIPCION" maxlength="50" class="muygrande" value="{/CatalogoPrivado/CATALOGO/FILTROS/DESCRIPCION}" />
              </xsl:when>
              <xsl:when test="/CatalogoPrivado/CATALOGO/FILTROS/DESCRIPCION != ''">
                <input type="text" id="DESCRIPCION" name="DESCRIPCION" maxlength="50" class="muygrande" value="{/CatalogoPrivado/DESCRIPCION}" />
              </xsl:when>
              <xsl:otherwise>
                <input type="text" id="DESCRIPCION" name="DESCRIPCION" maxlength="50" class="muygrande" />
              </xsl:otherwise>
              </xsl:choose>
            </td>
            <td class="textLeft" colspan="4">
				<xsl:if test="/CatalogoPrivado/CATALOGO/GRUPODESTOCK">
					<xsl:call-template name="desplegable">
						<xsl:with-param name="path" select="/CatalogoPrivado/CATALOGO/GRUPODESTOCK/field"/>
					</xsl:call-template>&nbsp;
				</xsl:if>&nbsp;
              	<a class="btnDestacado" href="javascript:BuscarDesde0();"><xsl:value-of select="document($doc)/translation/texts/item[@name='buscar']/node()"/></a>
            </td>
			</tr>
			<tr class="subTituloTabla">
				<td align="right">
					<xsl:if test="/CatalogoPrivado/CATALOGO/ANTERIOR">
						<a class="btnNormal" href="javascript:PaginaAnterior();"><xsl:value-of select="document($doc)/translation/texts/item[@name='anterior']/node()"/></a>
					</xsl:if>
				</td>
				<td colspan="4">
					<xsl:copy-of select="document($doc)/translation/texts/item[@name='lineas_por_pagina']/node()"/>:&nbsp;
					<xsl:call-template name="desplegable">
						<xsl:with-param name="id" value="LINEASPORPAGINA"/>
						<xsl:with-param name="path" select="/CatalogoPrivado/CATALOGO/LINEASPORPAGINA/field"/>
						<xsl:with-param name="onChange">javascript:Pagina0();</xsl:with-param>
					</xsl:call-template>&nbsp;&nbsp;&nbsp;
					<xsl:copy-of select="document($doc)/translation/texts/item[@name='pagina']/node()"/>&nbsp;
					<xsl:value-of select="/CatalogoPrivado/CATALOGO/PAGINA_ACTUAL"/>&nbsp;
					<xsl:copy-of select="document($doc)/translation/texts/item[@name='de']/node()"/>&nbsp;
					<xsl:value-of select="/CatalogoPrivado/CATALOGO/TOTAL_PAGINAS"/>
				</td>
				<td>&nbsp;</td>
				<td align="left">
					<xsl:if test="/CatalogoPrivado/CATALOGO/SIGUIENTE">
						<a class="btnNormal" href="javascript:PaginaSiguiente();"><xsl:value-of select="document($doc)/translation/texts/item[@name='siguiente']/node()"/></a>
					</xsl:if>
				</td>
			</tr>
        </xsl:when>
        <xsl:otherwise>
          <tr class="subTituloTabla">
            <td><xsl:value-of select="document($doc)/translation/texts/item[@name='referencia']/node()"/><br/>
              <xsl:choose>
              <xsl:when test="/CatalogoPrivado/REFERENCIA != '' and /CatalogoPrivado/IDEMPRESA != ''">
                <input type="text" id="REFERENCIA" name="REFERENCIA" maxlength="8" size="8" value="{/CatalogoPrivado/REFERENCIA}" />
              </xsl:when>
              <xsl:otherwise>
                <input type="text" id="REFERENCIA" name="REFERENCIA" maxlength="8" size="8" value="{/CatalogoPrivado/CATALOGO/FILTROS/REFERENCIA}" />
              </xsl:otherwise>
              </xsl:choose>
            </td>
            <td><xsl:value-of select="document($doc)/translation/texts/item[@name='descripcion']/node()"/><br/>
				<input type="text" id="DESCRIPCION" name="DESCRIPCION" maxlength="50" size="50" value="{/CatalogoPrivado/CATALOGO/FILTROS/DESCRIPCION}"/>
            </td>
			<td>&nbsp;</td>
			<td><br />
            	<div class="botonEstrecho">
                <a class="btnDestacadopeq" href="javascript:BuscarDesde0();"><xsl:value-of select="document($doc)/translation/texts/item[@name='buscar']/node()"/></a>
				</div>
			</td>
		  </tr>
        </xsl:otherwise>
        </xsl:choose>
      </thead>

      <tbody>
				<!--	Cuerpo de la tabla	-->
        <xsl:choose>
        <xsl:when test="/CatalogoPrivado/CATALOGO/PRODUCTO_ESTANDAR"><!--si publico = N enseño tb ref cliente-->
        <xsl:for-each select="/CatalogoPrivado/CATALOGO/PRODUCTO_ESTANDAR">
          <tr>
            <td class="ref" align="left">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<!--valign="top"-->
              <!--si vengo de evaluacion-->
              <xsl:choose>
              <xsl:when test="/CatalogoPrivado/ORIGEN = 'EVALUACION'">
                <a href="javascript:InsertarPROEvaluacion('{REFERENCIA}')">
                  <xsl:value-of select="REFERENCIA"/>
                </a>
              </xsl:when>
              <xsl:when test="/CatalogoPrivado/ORIGEN = 'LICITACION'">
                <a href="javascript:InsertarPROLicitacion('{REFERENCIA}')">
                  <xsl:value-of select="REFERENCIA"/>
                </a>
              </xsl:when>
              <xsl:when test="/CatalogoPrivado/ORIGEN = 'SOLICITUD'">
                <a href="javascript:InsertarPROSolicitud('{REFERENCIA}','{//INPUT_SOL}')">
                  <xsl:value-of select="REFERENCIA"/>
                </a>
              </xsl:when>
              <xsl:when test="/CatalogoPrivado/ORIGEN = 'STOCK'">
                <a href="javascript:InsertarPROStock('{REFERENCIA}')">
                  <xsl:value-of select="REFERENCIA"/>
                </a>
              </xsl:when>
              <xsl:when test="/CatalogoPrivado/ORIGEN = 'PEDIDOSTEXTO'">
                <a href="javascript:InsertarPrepararPedidoTexto('{REFERENCIA}')">
                  <xsl:value-of select="REFERENCIA"/>
                </a>
              </xsl:when>
              <xsl:when test="/CatalogoPrivado/ORIGEN = 'MANTENPEDIDO'">
                <a href="javascript:InsertarMantenimientoPedido('{REFERENCIA}')">
                  <xsl:value-of select="REFERENCIA"/>
                </a>
              </xsl:when>
              <xsl:when test="/CatalogoPrivado/ORIGEN = 'PRODUCTOLIC'">
                <a href="javascript:SustituirProductoLicitacion('{ID}','{REFERENCIA}','{DESCRIPCION}','{MARCASACEPTABLES}')">
                  <xsl:value-of select="REFERENCIA"/>
                </a>
              </xsl:when>
              <xsl:otherwise>
                <!--si vengo de nuevo producto o manten producto o manten reducido-->
                <xsl:choose>
                <xsl:when test="/CatalogoPrivado/IDEMPRESA != ''">
                  <a href="javascript:InsertarMantenimientoReducido('{REFERENCIA}')">
                    <xsl:value-of select="REFERENCIA"/>
                  </a>
                </xsl:when>
                <xsl:otherwise>
                  <a href="javascript:InsertarPROManten('{REFERENCIA}','{PRECIOOBJETIVO}','{UNIDADBASICA}')">
                    <xsl:value-of select="REFERENCIA"/>
                  </a>
                </xsl:otherwise>
                </xsl:choose>
              </xsl:otherwise>
              </xsl:choose>
            </td>

            <xsl:if test="/CatalogoPrivado/CATALOGO/FILTROS/PUBLICO = 'N'">
              <td class="ref" align="left">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <xsl:value-of select="REFCLIENTE"/>
              </td>
            </xsl:if>

            <td class="textLeft">
				<xsl:attribute name="colspan">
					<xsl:choose>
       				<xsl:when test="/CatalogoPrivado/CATALOGO/GRUPODESTOCK">1</xsl:when>
					<xsl:otherwise>2</xsl:otherwise>
					</xsl:choose>
				</xsl:attribute>
				<xsl:value-of select="DESCRIPCION"/>&nbsp;&nbsp;&nbsp;
            </td>
        	<xsl:if test="/CatalogoPrivado/CATALOGO/GRUPODESTOCK">
				<td class="textLeft">
					&nbsp;<xsl:value-of select="GRUPODESTOCK"/>
				</td>
			</xsl:if>
			<td class="textLeft">
				&nbsp;<xsl:value-of select="MARCASACEPTABLES"/>
            </td>

            <xsl:if test="/CatalogoPrivado/CATALOGO/FILTROS/PUBLICO = 'N'">
              <td class="ref" align="left">
			  	<xsl:if test="REFPROVEEDOR!=''">
                	<xsl:value-of select="REFPROVEEDOR"/>:&nbsp;<xsl:value-of select="PROVEEDOR"/>
				 </xsl:if>
              </td>
            </xsl:if>

          </tr>
		  </xsl:for-each>
        </xsl:when>
        <xsl:otherwise>
			<tr>
			<td align="center" colspan="5">
			<br/>
			<br/>
			<strong>
        	<xsl:choose>
        	<xsl:when test="/CatalogoPrivado/CATALOGO/FILTROS/REFERENCIA != '' or /CatalogoPrivado/CATALOGO/FILTROS/DESCRIPCION != ''">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='no_se_han_encontrado_resultados']/node()"/>
        	</xsl:when>
        	<xsl:otherwise>
				<xsl:value-of select="document($doc)/translation/texts/item[@name='aplique_filtro_para_buscar']/node()"/>
        	</xsl:otherwise>
        	</xsl:choose>
			</strong>
			<br/>
			<br/>
			</td>
			</tr>
        </xsl:otherwise>
        </xsl:choose>
      </tbody>
      </table>
	</form>

    <!--form de mensaje de error de js-->
    <form name="mensajeJS">
      <input type="hidden" name="REF_YA_INSERTADA" value="{document($doc)/translation/texts/item[@name='ref_ya_insertada']/node()}"/>
    </form>

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
