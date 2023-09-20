<?xml version="1.0" encoding="iso-8859-1" ?>
<!--
	Listado de empresas de MedicalVM con sus datos principales
	Ultima revision: ET 16oct17	09:39
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:import href="http://www.newco.dev.br/General/General.xsl"/>
	<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
	<xsl:param name="lang" select="@lang"/>
	<xsl:template match="/">

<html>
<head>
	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:value-of select="/BuscadorCentros/LANG"/>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<title><xsl:value-of select="document($doc)/translation/texts/item[@name='listado_de_centros']/node()"/></title>
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
				//var objFrame=new Object();
				//objFrame=obtenerFrame(top, 'zonaEmpresa');
				//objFrame.CambioEmpresaActual(idEmpresa);
				parent.zonaEmpresa.CambioEmpresaActual(idEmpresa);
			}

			function CambiarCentro(idEmpresa, idCentro){
				//var objFrame=new Object();
				//objFrame=obtenerFrame(top, 'zonaEmpresa');
				//objFrame.CambioCentroActual(idEmpresa, idCentro);
				parent.zonaEmpresa.CambioCentroActual(idEmpresa, idCentro);
			}

			//	Selecciona/Deselecciona todos los checkboxes
			function SeleccionarTodas(){
				var form=document.forms[0],
				Valor='';

				for(var n=0;n<form.length;n++){
					if(form.elements[n].name.match('CHK_')){
						if (Valor=='')
							if (form.elements[n].checked==true)
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
				var form=document.forms[0],
				ListaIDs='';

				for(var n=0;n<form.length;n++){
					if(form.elements[n].name.match('CHK_')){
						if (form.elements[n].checked==true)
							ListaIDs=ListaIDs+Piece(form.elements[n].name,'_',1)+'|';
					}
				}

				if(ListaIDs=='')
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
	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:value-of select="/BuscadorCentros/LANG"/>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<form action="BuscadorCentros.xsql" method="POST" name="form1">
	<xsl:choose>
		<xsl:when test="BuscadorCentros/SIN_DERECHOS">
			<!--	Sin derechos -> Página en blanco	-->   
		</xsl:when>
		<xsl:otherwise>

		<!--<div class="titlePage"><xsl:value-of select="document($doc)/translation/texts/item[@name='listado_de_centros']/node()"/> (<xsl:value-of select="document($doc)/translation/texts/item[@name='centros_encontrados']/node()"/>: <xsl:value-of select="/BuscadorCentros/CENTROS/TOTAL"/>)</div>-->
		<!-- Campos ocultos para transmision de datos	-->
		<input type="hidden" name="LISTAEMPRESAS" value=""/>
		<input type="hidden" id="IDENCUESTA" name="IDENCUESTA" value="" />
		<input type="hidden" id="FECHA"  name="FECHA" value="" />
		<input type="hidden" id="IDUSUARIO" name="IDUSUARIO" value="" />
		<input type="hidden" id="LISTACENTROS" name="LISTACENTROS" value="" />
		<input type="hidden" id="REFERENCIA" name="REFERENCIA" value="" />
		<input type="hidden" id="PRODUCTO" name="PRODUCTO" value="" />
		<input type="hidden" id="PROVEEDOR" name="PROVEEDOR" value="" />
		<input type="hidden" id="PRECIO" name="PRECIO" value="" />
		<input type="hidden" id="UNIDADBASICA" name="UNIDADBASICA" value="" />
		<input type="hidden" id="ESTADO" name="ESTADO" value="O" />
		<input type="hidden" id="ACCION" name="ACCION" value="" />
		<input type="hidden" id="PAGINA" name="PAGINA" value="{/BuscadorCentros/CENTROS/FILTROS/PAGINA}" />
		<input type="hidden" id="IDPAIS" name="IDPAIS" value="{/BuscadorCentros/CENTROS/FILTROS/IDPAIS}" />

		<!--	Titulo de la página		-->
		<div class="ZonaTituloPagina">
			<p class="Path"><xsl:value-of select="document($doc)/translation/texts/item[@name='Inicio']/node()"/>&nbsp;/&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='mantenimiento_de_empresas']/node()"/>&nbsp;/&nbsp;<span class="FinPath"><xsl:value-of select="document($doc)/translation/texts/item[@name='listado_de_centros']/node()"/></span></p>
			<p class="TituloPagina">
        	  <xsl:value-of select="document($doc)/translation/texts/item[@name='listado_de_centros']/node()"/> (<xsl:value-of select="document($doc)/translation/texts/item[@name='centros_encontrados']/node()"/>: <xsl:value-of select="/BuscadorCentros/CENTROS/TOTAL"/>)
			  <span class="CompletarTitulo">
			  <!--	Botones	-->
			  </span>
			</p>
		</div>
		<br/>
		<br/>
		<br/>
		<br/>

		<!--<table class="grandeInicio" border="0">-->
		<table class="buscador">
		<thead>
			<!--<tr class="tituloTabla">
				<td colspan="14">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='listado_de_centros']/node()"/> (<xsl:value-of select="document($doc)/translation/texts/item[@name='centros_encontrados']/node()"/>: <xsl:value-of select="/BuscadorCentros/CENTROS/TOTAL"/>)
				</td>
			</tr>
			<tr class="titulos">-->
			<tr class="subTituloTabla">
				<td class="uno">&nbsp;</td>
				<td class="uno">&nbsp;</td>
				<td class="veinte textLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='empresa']/node()"/></td>
				<td class="textLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='centro']/node()"/></td>
				<td class="dies"><xsl:value-of select="document($doc)/translation/texts/item[@name='provincia']/node()"/></td>
				<td class="dies"><xsl:value-of select="document($doc)/translation/texts/item[@name='tipo']/node()"/></td>
				<td class="cinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='sin_comisiones']/node()"/></td>
				<td class="cinco"><xsl:copy-of select="document($doc)/translation/texts/item[@name='accesos_30_dias']/node()"/></td>
				<!--<td class="cinco"><xsl:copy-of select="document($doc)/translation/texts/item[@name='busquedas_cat_prov_total_3line']/node()"/></td>
				<td class="cinco"><xsl:copy-of select="document($doc)/translation/texts/item[@name='busquedas_cat_prov_30dias_3line']/node()"/></td>
				<td class="cinco"><xsl:copy-of select="document($doc)/translation/texts/item[@name='solicit_emplant_total_3line']/node()"/></td>
				<td class="cinco"><xsl:copy-of select="document($doc)/translation/texts/item[@name='solicit_emplant_30dias_3line']/node()"/></td>
				<td class="cinco"><xsl:copy-of select="document($doc)/translation/texts/item[@name='usuario_nav_prov_3line']/node()"/></td>-->
				<td class="cinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='logotipo']/node()"/></td>
				<td class="cinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='estilos']/node()"/></td>
			</tr>

			<!--<tr class="select">-->
			<tr class="filtros">
				<td>&nbsp;</td>
				<td><a href="javascript:SeleccionarTodas();"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='todas']/node()"/></strong></a></td>
				<td colspan="2"><input type="text" id="FNOMBRE" name="FNOMBRE" maxlength="20" size="20" value="{/BuscadorCentros/CENTROS/FILTROS/NOMBRE}"/></td>
				<td>
					<xsl:call-template name="desplegable">
						<xsl:with-param name="id" value="FPROVINCIA"/>
						<xsl:with-param name="path" select="/BuscadorCentros/CENTROS/FPROVINCIA/field"/>
					</xsl:call-template>
				</td>
				<td>
					<xsl:call-template name="desplegable">
						<xsl:with-param name="id" value="FIDTIPO"/>
						<xsl:with-param name="path" select="/BuscadorCentros/CENTROS/FILTROS/TIPOEMPRESA/field"/>
					</xsl:call-template>
				</td>
				<td>
					<xsl:call-template name="desplegable">
						<xsl:with-param name="id" value="FSINCOMISIONES"/>
						<xsl:with-param name="path" select="/BuscadorCentros/CENTROS/FILTROS/SINCOMISIONES/field"/>
						<xsl:with-param name="claSel">peq</xsl:with-param>
					</xsl:call-template>
				</td>

				<td>&nbsp;</td>

				<!--<td>
					<xsl:call-template name="desplegable">
						<xsl:with-param name="id" value="FBUSQUEDAS"/>
						<xsl:with-param name="path" select="/BuscadorCentros/CENTROS/FILTROS/BUSQUEDAS/field"/>
						<xsl:with-param name="claSel">peq</xsl:with-param>
					</xsl:call-template>
				</td>
				<td>
					<xsl:call-template name="desplegable">
						<xsl:with-param name="id" value="FBUSQUEDAS30DIAS"/>
						<xsl:with-param name="path" select="/BuscadorCentros/CENTROS/FILTROS/BUSQUEDAS30DIAS/field"/>
						<xsl:with-param name="claSel">peq</xsl:with-param>
					</xsl:call-template>
				</td>
				<td>
					<xsl:call-template name="desplegable">
						<xsl:with-param name="id" value="FSOLICITUDES"/>
						<xsl:with-param name="path" select="/BuscadorCentros/CENTROS/FILTROS/SOLICITUDES/field"/>
						<xsl:with-param name="claSel">peq</xsl:with-param>
					</xsl:call-template>
				</td>
				<td>
					<xsl:call-template name="desplegable">
						<xsl:with-param name="id" value="FSOLICITUDES30DIAS"/>
						<xsl:with-param name="path" select="/BuscadorCentros/CENTROS/FILTROS/SOLICITUDES30DIAS/field"/>
						<xsl:with-param name="claSel">peq</xsl:with-param>
					</xsl:call-template>
				</td>
				<td>&nbsp;</td>-->
				<td>
					&nbsp;
					<!--<xsl:call-template name="desplegable">
						<xsl:with-param name="id" value="FLOGOTIPO"/>
						<xsl:with-param name="path" select="/BuscadorCentros/CENTROS/FILTROS/LOGOTIPOS/field"/>
					</xsl:call-template>-->
				</td>
				<td>
					&nbsp;
					<!--<xsl:call-template name="desplegable">
						<xsl:with-param name="id" value="FESTILOS"/>
						<xsl:with-param name="path" select="/BuscadorCentros/CENTROS/FILTROS/ESTILOS/field"/>
					</xsl:call-template>-->
				</td>
			</tr>

			<!--<tr class="select">-->
			<tr class="filtros">
				<td colspan="4" align="right">
					<xsl:if test="/BuscadorCentros/CENTROS/ANTERIOR">
						<a class="btnNormal" href="javascript:PaginaAnterior();"><xsl:value-of select="document($doc)/translation/texts/item[@name='anterior']/node()"/></a>
					</xsl:if>
				</td>
				<td colspan="2">
					<xsl:copy-of select="document($doc)/translation/texts/item[@name='lineas_por_pagina']/node()"/>:&nbsp;
					<xsl:call-template name="desplegable">
						<xsl:with-param name="id" value="LINEASPORPAGINA"/>
						<xsl:with-param name="path" select="/BuscadorCentros/CENTROS/FILTROS/LINEASPORPAGINA/field"/>
					</xsl:call-template>
				</td>
				<!--<td colspan="14" align="center">-->
				<td colspan="1" align="center">
					<!--<div class="botonCenter">-->
						<a class="btnDestacado" href="javascript:Buscar();"><xsl:value-of select="document($doc)/translation/texts/item[@name='filtrar']/node()"/></a>
					<!--</div>-->
				</td>
				<td colspan="7" align="left">
					<xsl:if test="/BuscadorCentros/CENTROS/SIGUIENTE">
						<a class="btnNormal" href="javascript:PaginaSiguiente();"><xsl:value-of select="document($doc)/translation/texts/item[@name='siguiente']/node()"/></a>
					</xsl:if>
				</td>
			</tr>
		</thead>
	<xsl:choose>
	<xsl:when test="/BuscadorCentros/CENTROS/CENTRO">
		<tbody>
		<xsl:for-each select="/BuscadorCentros/CENTROS/CENTRO">
			<tr>
				<td><xsl:value-of select="CONTADOR"/></td>
				<td><input class="muypeq" type="checkbox" name="CHK_{EMP_ID}"/></td>
				<td class="textLeft">
					<a href="javascript:CambiarEmpresa({EMP_ID});"><xsl:value-of select="EMPRESA"/></a>
				</td>
				<td class="textLeft">
					<a href="javascript:CambiarCentro({EMP_ID}, {CEN_ID});"><xsl:value-of select="NOMBRE"/></a>
				</td>
				<td><xsl:value-of select="PROVINCIA"/></td>
				<td><xsl:value-of select="TIPOEMPRESA"/></td>
				<td><xsl:value-of select="SINCOMISIONES"/></td>
				<td>
					<xsl:if test="ACCESOS30DIAS>0">
						<xsl:value-of select="ACCESOS30DIAS"/>
					</xsl:if>
				</td>
				<!--<td align="right">
					<xsl:if test="BUSQUEDAS>0">
						<xsl:value-of select="BUSQUEDAS"/>&nbsp;
					</xsl:if>
				</td>
				<td align="right">
					<xsl:if test="BUSQUEDAS30DIAS>0">
						<xsl:value-of select="BUSQUEDAS30DIAS"/>&nbsp;
					</xsl:if>
				</td>
				<td align="right">
					<xsl:if test="SOLICITUDES>0">
						<xsl:value-of select="SOLICITUDES"/>&nbsp;
					</xsl:if>
				</td>
				<td align="right">
					<xsl:if test="SOLICITUDES30DIAS>0">
						<xsl:value-of select="SOLICITUDES30DIAS"/>&nbsp;
					</xsl:if>
				</td>
				<td align="right">
					<xsl:if test="NAVEGANPROVEEDORES>0">
						<xsl:value-of select="NAVEGANPROVEEDORES"/>&nbsp;
					</xsl:if>
				</td>-->
				<td><xsl:value-of select="LOGOTIPO"/></td>
				<td><xsl:value-of select="ESTILOS"/></td>
			</tr>
		</xsl:for-each>
		</tbody>
		<tfoot>
			<tr class="sinLinea">
				<td colspan="7">&nbsp;</td>
				<!--<td align="right">
					<b><xsl:value-of select="/BuscadorCentros/CENTROS/TOTAL_BUSQUEDAS"/>&nbsp;</b>
				</td>
				<td align="right">
					<b><xsl:value-of select="/BuscadorCentros/CENTROS/TOTAL_BUSQUEDAS30DIAS"/>&nbsp;</b>
				</td>
				<td align="right">
					<b><xsl:value-of select="/BuscadorCentros/CENTROS/TOTAL_SOLICITUDES"/>&nbsp;</b>
				</td>
				<td align="right">
					<b><xsl:value-of select="/BuscadorCentros/CENTROS/TOTAL_SOLICITUDES30DIAS"/>&nbsp;</b>
				</td>-->
				<td align="right">
					<b><xsl:value-of select="/BuscadorCentros/CENTROS/TOTAL_NAVEGANPROVEEDORES"/>&nbsp;</b>
				</td>
				<td colspan="2">&nbsp;</td>
			</tr>
			<tr class="sinLinea">
				<td colspan="14">&nbsp;</td>
			</tr>
			<tr class="sinLinea">
				<td colspan="14">
					<!--<div class="botonCenter">-->
						<a class="btnDestacado" href="javascript:Continuar();" title="Buscar los usuarios correspondientes a las empresas seleccionadas"><xsl:value-of select="document($doc)/translation/texts/item[@name='buscar_usuarios']/node()"/></a>
					<!--</div>-->
				</td>
			</tr>
		</tfoot>
	</xsl:when>
	<xsl:otherwise>
		<tr><td colspan="14"><xsl:value-of select="document($doc)/translation/texts/item[@name='no_se_han_encontrado_resultados']/node()"/></td></tr>
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
