<?xml version="1.0" encoding="iso-8859-1"?>
<!--
	Listado de empresas de MedicalVM con sus datos principales

	14set10		ET
+-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:import href="http://www.newco.dev.br/General/General.xsl"/>
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="lang" select="@lang"/>

<xsl:template match="/">
<html>
<head>
	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:value-of select="/ListadoEmpresas/LANG"/>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<title><xsl:value-of select="document($doc)/translation/texts/item[@name='listado_de_empresas']/node()"/></title>

	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->

	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>

	<xsl:text disable-output-escaping="yes"><![CDATA[
	<script type="text/javascript">
	<!--
		function Enviar(){
			var form=document.forms[0];
			SubmitForm(form);
		}

		function CambiarEmpresa(idEmpresa){
			var objFrame=new Object();
			objFrame=obtenerFrame(top, 'zonaEmpresa');
			objFrame.CambioEmpresaActual(idEmpresa);
		}

		//	Selecciona/Deselecciona todos los checkboxes
		function SeleccionarTodas(){
			var form=document.forms[0],Valor='';

			for(var n=0;n<form.length;n++){
				if(form.elements[n].name.match('CHK_')){
					if(Valor=='')
						if(form.elements[n].checked==true)
							Valor='N';
						else
							Valor='S';

					if (Valor=='S')
						form.elements[n].checked=true;
					else
						form.elements[n].checked=false;
				}
			}
		}

		function Continuar(){
			var form=document.forms[0],ListaIDs='';

			for(var n=0;n<form.length;n++){
				if(form.elements[n].name.match('CHK_')){
					if (form.elements[n].checked==true)
						ListaIDs=ListaIDs+Piece(form.elements[n].name,'_',1)+'|';
				}
			}

			if (ListaIDs=='')
				alert('Debe seleccionar al menos una empresa para poder continuar');
			else{
				form.elements['LISTAEMPRESAS'].value=ListaIDs;
				form.action="./ListadoCentros.xsql";
				SubmitForm(form);
			}
		}
		
		function Buscar() {document.forms[0].elements['PAGINA'].value=0; Enviar();}
		function PaginaAnterior() {document.forms[0].elements['PAGINA'].value=document.forms[0].elements['PAGINA'].value-1; Enviar();}
		function PaginaSiguiente() {document.forms[0].elements['PAGINA'].value=parseInt(document.forms[0].elements['PAGINA'].value)+1; Enviar();}
		
	-->
	</script>
	]]></xsl:text>
</head>
<body>
	<form action="ListadoEmpresas.xsql" method="POST" name="form1">
	<xsl:choose>
	<xsl:when test="ListadoEmpresas/SIN_DERECHOS">
		<!--	Sin derechos -> Página en blanco	-->
	</xsl:when>
	<xsl:otherwise>
		<!--idioma-->
		<xsl:variable name="lang">
			<xsl:value-of select="/ListadoEmpresas/LANG"/>
		</xsl:variable>
		<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
		<!--idioma fin-->

		<!--<div class="titlePage"><xsl:value-of select="document($doc)/translation/texts/item[@name='listado_de_empresas']/node()"/> (<xsl:value-of select="document($doc)/translation/texts/item[@name='empresas_encontradas']/node()"/>: <xsl:value-of select="/ListadoEmpresas/EMPRESAS/TOTAL"/>)</div>-->
		<!-- Campos ocultos para transmision de datos	-->
		<input type="hidden" name="LISTAEMPRESAS"/>
		<input type="hidden" id="IDENCUESTA" name="IDENCUESTA"/>
		<input type="hidden" id="FECHA"  name="FECHA"/>
		<input type="hidden" id="IDUSUARIO" name="IDUSUARIO"/>
		<input type="hidden" id="LISTACENTROS" name="LISTACENTROS"/>
		<input type="hidden" id="REFERENCIA" name="REFERENCIA"/>
		<input type="hidden" id="PRODUCTO" name="PRODUCTO"/>
		<input type="hidden" id="PROVEEDOR" name="PROVEEDOR"/>
		<input type="hidden" id="PRECIO" name="PRECIO"/>
		<input type="hidden" id="UNIDADBASICA" name="UNIDADBASICA"/>
		<input type="hidden" id="ESTADO" name="ESTADO" value="O"/>
		<input type="hidden" id="ACCION" name="ACCION"/>
		<input type="hidden" id="PAGINA" name="PAGINA" value="{/ListadoEmpresas/EMPRESAS/FILTROS/PAGINA}"/>

		<table class="grandeInicio" border="0">
		<thead>
			<tr class="tituloTabla">
				<td colspan="23">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='listado_de_empresas']/node()"/> (<xsl:value-of select="document($doc)/translation/texts/item[@name='empresas_encontradas']/node()"/>: <xsl:value-of select="/ListadoEmpresas/EMPRESAS/TOTAL"/>)
				</td>
				<td colspan="5">&nbsp;</td>
			</tr>

			<tr class="titulos">
				<td class="uno">&nbsp;</td>
				<td class="tres">&nbsp;</td>
				<td><xsl:value-of select="document($doc)/translation/texts/item[@name='empresa']/node()"/></td>
				<td class="ocho"><xsl:value-of select="document($doc)/translation/texts/item[@name='provincia']/node()"/></td>
				<td class="ocho"><xsl:value-of select="document($doc)/translation/texts/item[@name='tipo']/node()"/></td>

				<td class="ocho"><xsl:copy-of select="document($doc)/translation/texts/item[@name='pedidos_30_dias_2line']/node()"/></td>
				<td class="ocho"><xsl:value-of select="document($doc)/translation/texts/item[@name='pedidos_365_dias_2line']/node()"/></td>
				<td class="ocho"><xsl:copy-of select="document($doc)/translation/texts/item[@name='lineas_catalogo_2line']/node()"/></td>

				<td class="cinco"><xsl:copy-of select="document($doc)/translation/texts/item[@name='nuevo_modelo_2line']/node()"/></td>
				<td class="tres"><xsl:copy-of select="document($doc)/translation/texts/item[@name='pedido_ampliado_2line']/node()"/></td>
				<td class="tres"><xsl:copy-of select="document($doc)/translation/texts/item[@name='pedido_minimo_activo_3line']/node()"/></td>
				<td class="tres"><xsl:copy-of select="document($doc)/translation/texts/item[@name='importe_minimo_activo_3line']/node()"/></td>
				<td class="tres"><xsl:copy-of select="document($doc)/translation/texts/item[@name='no_navegar_2line']/node()"/></td>
				<td class="tres"><xsl:copy-of select="document($doc)/translation/texts/item[@name='no_navegar_por_defecto_2line']/node()"/></td>
				<td class="tres"><xsl:copy-of select="document($doc)/translation/texts/item[@name='bloquear_muestras_2line']/node()"/></td>
				<td class="tres"><xsl:copy-of select="document($doc)/translation/texts/item[@name='bloquear_bandeja_2line']/node()"/></td>
<!-- Nuevas marcas para "Catalogo Visible", "Catalogo con nivel de Categoria" y "Catalogo con nivel de Grupo" - DC - 14/03/13 -->
				<td class="cinco"><xsl:copy-of select="document($doc)/translation/texts/item[@name='catalogo_visible_2line']/node()"/></td>
				<td class="cinco"><xsl:copy-of select="document($doc)/translation/texts/item[@name='catalogo_nivel_categoria_3line']/node()"/></td>
				<td class="cinco"><xsl:copy-of select="document($doc)/translation/texts/item[@name='catalogo_nivel_grupo_3line']/node()"/></td>
<!-- Fin Nuevas Marcas -->
				<td class="tres"><xsl:copy-of select="document($doc)/translation/texts/item[@name='comision_transacciones_2line']/node()"/></td>
				<td class="tres"><xsl:copy-of select="document($doc)/translation/texts/item[@name='comision_ahorro_2line']/node()"/></td>
				<td class="tres"><xsl:copy-of select="document($doc)/translation/texts/item[@name='busquedas_cat_prov_total_3line']/node()"/></td>
				<td class="tres"><xsl:copy-of select="document($doc)/translation/texts/item[@name='busquedas_cat_prov_30dias_3line']/node()"/></td>
				<td class="tres"><xsl:copy-of select="document($doc)/translation/texts/item[@name='solicit_emplant_total_3line']/node()"/></td>
				<td class="tres"><xsl:copy-of select="document($doc)/translation/texts/item[@name='solicit_emplant_30dias_3line']/node()"/></td>
				<td class="tres"><xsl:copy-of select="document($doc)/translation/texts/item[@name='usuario_nav_prov_3line']/node()"/></td>
				<td class="tres"><xsl:value-of select="document($doc)/translation/texts/item[@name='logotipo']/node()"/></td>
				<td class="tres"><xsl:copy-of select="document($doc)/translation/texts/item[@name='estilos']/node()"/></td>
			</tr>

			<tr class="select">
				<td>&nbsp;</td>
				<td><a href="javascript:SeleccionarTodas();"><strong><xsl:copy-of select="document($doc)/translation/texts/item[@name='todas']/node()"/></strong></a></td>
				<td><input type="text" id="FNOMBRE" name="FNOMBRE" maxlength="18" size="18" value="{/ListadoEmpresas/EMPRESAS/FILTROS/NOMBRE}"/></td>
				<td>
					<xsl:call-template name="desplegable">
						<xsl:with-param name="id" value="FPROVINCIA"/>
						<xsl:with-param name="path" select="/ListadoEmpresas/EMPRESAS/FPROVINCIA/field"/>
					</xsl:call-template>
				</td>
				<td>
                                    <xsl:choose>
                                        <xsl:when test="/ListadoEmpresas/LANG = 'spanish'">
					<xsl:call-template name="desplegable">
						<xsl:with-param name="id" value="FIDTIPO"/>
						<xsl:with-param name="path" select="/ListadoEmpresas/EMPRESAS/FILTROS/TIPOEMPRESA/field"/>
					</xsl:call-template>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <select id="FIDTIPO" name="FIDTIPO">
                                                <xsl:for-each select="/ListadoEmpresas/EMPRESAS/FILTROS/TIPOEMPRESA/field/dropDownList/listElem">
                                                    <option value="{ID}">
                                                        <xsl:if test="ID = /ListadoEmpresas/EMPRESAS/FILTROS/TIPOEMPRESA/field/@current">
                                                            <xsl:attribute name="selected">selected</xsl:attribute>
                                                        </xsl:if>
                                                        <xsl:choose>
                                                        <xsl:when test="ID = 'VENDEDOR'">
                                                            <xsl:copy-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/>
                                                        </xsl:when>
                                                        <xsl:otherwise>
                                                            <xsl:value-of select="listItem" />
                                                        </xsl:otherwise>
                                                        </xsl:choose>
                                                    </option>
                                                </xsl:for-each>
                                            </select>
                                        </xsl:otherwise>
                                    </xsl:choose>
				</td>

				<td>
					<xsl:call-template name="desplegable">
						<xsl:with-param name="id" value="FCOMPRAS30DIAS"/>
						<xsl:with-param name="path" select="/ListadoEmpresas/EMPRESAS/FILTROS/COMPRAS30DIAS/field"/>
					</xsl:call-template>
				</td>
				<td>
					<xsl:call-template name="desplegable">
						<xsl:with-param name="id" value="FCOMPRAS"/>
						<xsl:with-param name="path" select="/ListadoEmpresas/EMPRESAS/FILTROS/COMPRAS/field"/>
					</xsl:call-template>
				</td>
				<td>
					<xsl:call-template name="desplegable">
						<xsl:with-param name="id" value="FCATALOGO"/>
						<xsl:with-param name="path" select="/ListadoEmpresas/EMPRESAS/FILTROS/CATALOGO/field"/>
					</xsl:call-template>
				</td>

				<td>
					<xsl:call-template name="desplegable">
						<xsl:with-param name="id" value="FNUEVOMODELO"/>
						<xsl:with-param name="path" select="/ListadoEmpresas/EMPRESAS/FILTROS/NUEVOMODELO/field"/>
					</xsl:call-template>
				</td>
				<td>
					<xsl:call-template name="desplegable">
						<xsl:with-param name="id" value="FPEDIDOAMPLIADO"/>
						<xsl:with-param name="path" select="/ListadoEmpresas/EMPRESAS/FILTROS/PEDIDOAMPLIADO/field"/>
					</xsl:call-template>
				</td>
				<td>
					<xsl:call-template name="desplegable">
						<xsl:with-param name="id" value="FPEDIDOMINIMO"/>
						<xsl:with-param name="path" select="/ListadoEmpresas/EMPRESAS/FILTROS/PEDIDOMINIMO/field"/>
					</xsl:call-template>
				</td>
				<td></td>
				<td>
					<xsl:call-template name="desplegable">
						<xsl:with-param name="id" value="FNONAVEGAR"/>
						<xsl:with-param name="path" select="/ListadoEmpresas/EMPRESAS/FILTROS/NONAVEGAR/field"/>
					</xsl:call-template>
				</td>
				<td>
					<xsl:call-template name="desplegable">
						<xsl:with-param name="id" value="FNONAVEGARDEF"/>
						<xsl:with-param name="path" select="/ListadoEmpresas/EMPRESAS/FILTROS/NONAVEGARDEF/field"/>
					</xsl:call-template>
				</td>
				<td>
					<xsl:call-template name="desplegable">
						<xsl:with-param name="id" value="FBLOQUEARMUESTRAS"/>
						<xsl:with-param name="path" select="/ListadoEmpresas/EMPRESAS/FILTROS/BLOQUEARMUESTRAS/field"/>
					</xsl:call-template>
				</td>
				<td>
					<xsl:call-template name="desplegable">
						<xsl:with-param name="id" value="FBLOQUEARBANDEJA"/>
						<xsl:with-param name="path" select="/ListadoEmpresas/EMPRESAS/FILTROS/BLOQUEARBANDEJA/field"/>
					</xsl:call-template>
				</td>
<!-- Nuevas marcas para "Catalogo Visible", "Catalogo con nivel de Categoria" y "Catalogo con nivel de Grupo" - DC - 14/03/13 -->
				<td>
					<xsl:call-template name="desplegable">
						<xsl:with-param name="id" value="FCATALOGOVISIBLE"/>
						<xsl:with-param name="path" select="/ListadoEmpresas/EMPRESAS/FILTROS/CATALOGOVISIBLE/field"/>
					</xsl:call-template>
				</td>
				<td>
					<xsl:call-template name="desplegable">
						<xsl:with-param name="id" value="FCATPRIVCONCATEGORIAS"/>
						<xsl:with-param name="path" select="/ListadoEmpresas/EMPRESAS/FILTROS/CATPRIVCONCATEGORIAS/field"/>
					</xsl:call-template>
				</td>
				<td>
					<xsl:call-template name="desplegable">
						<xsl:with-param name="id" value="FCATPRIVCONGRUPOS"/>
						<xsl:with-param name="path" select="/ListadoEmpresas/EMPRESAS/FILTROS/CATPRIVCONGRUPOS/field"/>
					</xsl:call-template>
				</td>
<!-- Fin Nuevas Marcas -->
				<td>
					<xsl:call-template name="desplegable">
						<xsl:with-param name="id" value="FCOMISIONTRANS"/>
						<xsl:with-param name="path" select="/ListadoEmpresas/EMPRESAS/FILTROS/COMISIONTRANS/field"/>
					</xsl:call-template>
				</td>
				<td>
					<xsl:call-template name="desplegable">
						<xsl:with-param name="id" value="FCOMISIONAHORRO"/>
						<xsl:with-param name="path" select="/ListadoEmpresas/EMPRESAS/FILTROS/COMISIONAHORRO/field"/>
					</xsl:call-template>
				</td>
				<td>
					<xsl:call-template name="desplegable">
						<xsl:with-param name="id" value="FBUSQUEDAS"/>
						<xsl:with-param name="path" select="/ListadoEmpresas/EMPRESAS/FILTROS/BUSQUEDAS/field"/>
					</xsl:call-template>
				</td>
				<td>
					<xsl:call-template name="desplegable">
						<xsl:with-param name="id" value="FBUSQUEDAS30DIAS"/>
						<xsl:with-param name="path" select="/ListadoEmpresas/EMPRESAS/FILTROS/BUSQUEDAS30DIAS/field"/>
					</xsl:call-template>
				</td>
				<td>
					<xsl:call-template name="desplegable">
						<xsl:with-param name="id" value="FSOLICITUDES"/>
						<xsl:with-param name="path" select="/ListadoEmpresas/EMPRESAS/FILTROS/SOLICITUDES/field"/>
					</xsl:call-template>
				</td>
				<td>
					<xsl:call-template name="desplegable">
						<xsl:with-param name="id" value="FSOLICITUDES30DIAS"/>
						<xsl:with-param name="path" select="/ListadoEmpresas/EMPRESAS/FILTROS/SOLICITUDES30DIAS/field"/>
					</xsl:call-template>
				</td>
				<td></td>
				<td>
					&nbsp;
					<!--<xsl:call-template name="desplegable">
						<xsl:with-param name="id" value="FLOGOTIPO"/>
						<xsl:with-param name="path" select="/ListadoEmpresas/EMPRESAS/FILTROS/LOGOTIPOS/field"/>
					</xsl:call-template>
					-->
				</td>
				<td>
					&nbsp;
					<!--<xsl:call-template name="desplegable">
						<xsl:with-param name="id" value="FESTILOS"/>
						<xsl:with-param name="path" select="/ListadoEmpresas/EMPRESAS/FILTROS/ESTILOS/field"/>
					</xsl:call-template>
					-->
				</td>
			</tr>
			<tr class="select">
				<td colspan="8" align="right">
					<xsl:if test="/ListadoEmpresas/EMPRESAS/ANTERIOR">
						<a href="javascript:PaginaAnterior();"><xsl:value-of select="document($doc)/translation/texts/item[@name='anterior']/node()"/></a>
					</xsl:if>
				</td>
				<td colspan="4">
					<xsl:copy-of select="document($doc)/translation/texts/item[@name='lineas_por_pagina']/node()"/>:&nbsp;
					<xsl:call-template name="desplegable">
						<xsl:with-param name="id" value="LINEASPORPAGINA"/>
						<xsl:with-param name="path" select="/ListadoEmpresas/EMPRESAS/FILTROS/LINEASPORPAGINA/field"/>
					</xsl:call-template>
				</td>
				<td align="center">
				<!--<td colspan="28" align="center">-->
					<div class="botonCenter">
						<a href="javascript:Buscar();"><xsl:value-of select="document($doc)/translation/texts/item[@name='filtrar']/node()"/></a>
					</div>
				</td>
				<td colspan="16" align="left">
					<xsl:if test="/ListadoEmpresas/EMPRESAS/SIGUIENTE">
						<a href="javascript:PaginaSiguiente();"><xsl:value-of select="document($doc)/translation/texts/item[@name='siguiente']/node()"/></a>
					</xsl:if>
				</td>
			</tr>
		</thead>

	<xsl:choose>
	<xsl:when test="/ListadoEmpresas/EMPRESAS/EMPRESA">
		<tbody>
		<xsl:for-each select="/ListadoEmpresas/EMPRESAS/EMPRESA">
 			<tr>
				<td><xsl:value-of select="CONTADOR"/></td>
				<td><input type="checkbox" name="CHK_{EMP_ID}"/></td>
				<td class="textLeft">
                                    <a href="javascript:CambiarEmpresa({EMP_ID});">
                                        <xsl:choose>
                                            <xsl:when test="EMP_NOMBRE_CORTO != ''"><xsl:value-of select="EMP_NOMBRE_CORTO"/></xsl:when>
                                            <xsl:otherwise><xsl:value-of select="NOMBRE"/></xsl:otherwise>
                                        </xsl:choose>                                               
                                    </a>
                                </td>
				<td class="textLeft"><xsl:value-of select="EMP_PROVINCIA"/></td>
				<td><xsl:value-of select="TIPOEMPRESA"/></td>

				<td><xsl:if test="EMP_CONSUMOMES != 'N'"><xsl:value-of select="EMP_CONSUMOMES"/></xsl:if></td>
				<td><xsl:if test="EMP_CONSUMOANNO != 'N'"><xsl:value-of select="EMP_CONSUMOANNO"/></xsl:if></td>
				<td><xsl:if test="EMP_LINEASCATALOGO != 'N'"><xsl:value-of select="EMP_LINEASCATALOGO"/></xsl:if></td>

				<td><xsl:if test="EMP_OCULTARPRECIOREF != 'N'"><xsl:value-of select="EMP_OCULTARPRECIOREF"/></xsl:if></td>
				<td><xsl:if test="EMP_MOSTRARCOMISIONES_NM != 'N'"><xsl:value-of select="EMP_MOSTRARCOMISIONES_NM"/></xsl:if></td>
				<td><xsl:if test="EMP_PEDMINIMO_ACTIVO != 'N'"><xsl:value-of select="EMP_PEDMINIMO_ACTIVO"/></xsl:if></td>
				<td><xsl:value-of select="EMP_PEDMINIMO_IMPORTE"/></td>
				<td><xsl:if test="EMP_PROVNONAVEGAR != 'N'"><xsl:value-of select="EMP_PROVNONAVEGAR"/></xsl:if></td>
				<td><xsl:if test="EMP_PROVNONAVEGARPORDEFECTO != 'N'"><xsl:value-of select="EMP_PROVNONAVEGARPORDEFECTO"/></xsl:if></td>
				<td><xsl:if test="EMP_BLOQUEARMUESTRAS != 'N'"><xsl:value-of select="EMP_BLOQUEARMUESTRAS"/></xsl:if></td>
				<td><xsl:if test="EMP_BLOQUEARBANDEJA != 'N'"><xsl:value-of select="EMP_BLOQUEARBANDEJA"/></xsl:if></td>
<!-- Nuevas marcas para "Catalogo Visible", "Catalogo con nivel de Categoria" y "Catalogo con nivel de Grupo" - DC - 14/03/13 -->
				<td><xsl:if test="EMP_CATALOGOVISIBLE != 'N'"><xsl:value-of select="EMP_CATALOGOVISIBLE"/></xsl:if></td>
				<td><xsl:if test="EMP_CATPRIV_CATEGORIAS != 'N'"><xsl:value-of select="EMP_CATPRIV_CATEGORIAS"/></xsl:if></td>
				<td><xsl:if test="EMP_CATPRIV_GRUPOS != 'N'"><xsl:value-of select="EMP_CATPRIV_GRUPOS"/></xsl:if></td>
<!-- Fin Nuevas Marcas -->
				<td align="right"><xsl:if test="EMP_COMISION_TRANSACCIONES > 0"><xsl:value-of select="EMP_COMISION_TRANSACCIONES"/></xsl:if></td>
				<td align="right"><xsl:value-of select="EMP_COMISION_AHORRO"/></td>
				<td align="right"><xsl:if test="BUSQUEDAS>0"><xsl:value-of select="BUSQUEDAS"/></xsl:if></td>
				<td align="right"><xsl:if test="BUSQUEDAS30DIAS>0"><xsl:value-of select="BUSQUEDAS30DIAS"/></xsl:if></td>
				<td align="right"><xsl:if test="SOLICITUDES>0"><xsl:value-of select="SOLICITUDES"/></xsl:if></td>
				<td align="right"><xsl:if test="SOLICITUDES30DIAS>0"><xsl:value-of select="SOLICITUDES30DIAS"/></xsl:if></td>
				<td align="right"><xsl:if test="NAVEGANPROVEEDORES>0"><xsl:value-of select="NAVEGANPROVEEDORES"/></xsl:if></td>
				<td><xsl:value-of select="LOGOTIPO"/></td>
				<td><xsl:value-of select="ESTILOS"/></td>
			</tr>
		</xsl:for-each>
		</tbody>

			<tr>
				<td colspan="5">&nbsp;</td>
				<td align="right"><b><xsl:value-of select="/ListadoEmpresas/EMPRESAS/TOTAL_COMPRAS30DIAS"/></b></td>
				<td align="right"><b><xsl:value-of select="/ListadoEmpresas/EMPRESAS/TOTAL_COMPRAS"/></b></td>
				<td align="right"><b><xsl:value-of select="/ListadoEmpresas/EMPRESAS/TOTAL_LINEAS"/></b></td>
				<td colspan="13">&nbsp;</td>
				<td align="right"><b><xsl:value-of select="/ListadoEmpresas/EMPRESAS/TOTAL_BUSQUEDAS"/></b></td>
				<td align="right"><b><xsl:value-of select="/ListadoEmpresas/EMPRESAS/TOTAL_BUSQUEDAS30DIAS"/></b></td>
				<td align="right"><b><xsl:value-of select="/ListadoEmpresas/EMPRESAS/TOTAL_SOLICITUDES"/></b></td>
				<td align="right"><b><xsl:value-of select="/ListadoEmpresas/EMPRESAS/TOTAL_SOLICITUDES30DIAS"/></b></td>
				<td align="right"><b><xsl:value-of select="/ListadoEmpresas/EMPRESAS/TOTAL_NAVEGANPROVEEDORES"/></b></td>
				<td colspan="2">&nbsp;</td>
			</tr>

		<tfoot>
			<tr>
				<td colspan="28">
					<div class="botonCenter">
						<a href="javascript:Continuar();" title="Buscar los centros correspondientes a las empresas seleccionadas"><xsl:value-of select="document($doc)/translation/texts/item[@name='buscar_centros']/node()"/></a>
					</div>
				</td>
			</tr>
		</tfoot>
	</xsl:when>
	<xsl:otherwise>
		<tr><td colspan="28"><xsl:value-of select="document($doc)/translation/texts/item[@name='no_se_han_encontrado_resultados']/node()"/></td></tr>
	</xsl:otherwise>
	</xsl:choose>
		</table>
	</xsl:otherwise>
	</xsl:choose>
		</form>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
