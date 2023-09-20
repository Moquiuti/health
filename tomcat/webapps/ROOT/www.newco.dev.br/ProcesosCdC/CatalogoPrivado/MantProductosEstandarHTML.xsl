<?xml version="1.0" encoding="iso-8859-1"?>
<!--
	Mantenimiento de producto estándar
	Ultima revisión: 25oct21 12:20 MantProductosEstandar_210122.js
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:import href = "http://www.newco.dev.br/General/General.xsl"/>
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:template match="/">

<!--	Todos los documentos HTML deben empezar con esto	-->
<xsl:text disable-output-escaping='yes'>&lt;!doctype html></xsl:text>

<html>
<head>
	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:choose>
		<xsl:when test="/Mantenimiento/LANG"><xsl:value-of select="/Mantenimiento/LANG"/></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<title><xsl:value-of select="document($doc)/translation/texts/item[@name='mantenimiento_productos_estandar']/node()"/></title>

	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->

	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>


	<script language="javascript">
		var lang = '<xsl:value-of select="/Mantenimiento/LANG"/>';

		var msg_previo_desc_antiguas = '<xsl:value-of select="document($doc)/translation/texts/item[@name='msg_previo_desc_antiguas']/node()"/>';
		var sustituirDescAntErr	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='sustituir_desc_ant_error']/node()"/>';
		var sustituirDescAntOK	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='sustituir_desc_ant_ok']/node()"/>';
		var catpriv_estricto='<xsl:value-of select="/Mantenimiento/PRODUCTOESTANDAR/CATPRIV_ESTRICTO"/>';
        var raros_alert	= "<xsl:value-of select="document($doc)/translation/texts/item[@name='caracteres_raros']/node()"/>";
        var raros_prod_estandar	= "<xsl:value-of select="document($doc)/translation/texts/item[@name='caracteres_raros_producto_estandard']/node()"/>";
		chars_nivel5 = "<xsl:value-of select="Mantenimiento/PRODUCTOESTANDAR/CODIFICACIONNIVELES/NIVEL5"/>";
		leyenda_ref_nivel5	= "<xsl:value-of select="document($doc)/translation/texts/item[@name='leyenda_ref_prod_estandar']/node()"/>";

		no_hay		= "<xsl:value-of select="document($doc)/translation/texts/item[@name='no_hay_datos']/node()"/>";
	</script>

	<script type="text/javascript" src="http://www.newco.dev.br/ProcesosCdC/CatalogoPrivado/MantProductosEstandar_210122.js"></script>
</head>

<!--<body class="gris">-->
<body>
<!-- Si es el alta de un nuevo producto -->
<xsl:if test="/Mantenimiento/PRODUCTOESTANDAR/ID = 0 and (/Mantenimiento/PRODUCTOESTANDAR/MASTER or /Mantenimiento/PRODUCTOESTANDAR/MASTER_UNICO)">
	<xsl:attribute name="onload">javascript:ReferenciaGrupo();</xsl:attribute>
</xsl:if>

<xsl:choose>
<xsl:when test="//SESION_CADUCADA">
	<xsl:apply-templates select="//SESION_CADUCADA"/>
</xsl:when>
<xsl:when test="//Sorry">
	<xsl:apply-templates select="//Sorry"/>
</xsl:when>
<xsl:otherwise>
	<xsl:if test="Mantenimiento/PRODUCTOESTANDAR/MENSAJE = 'OK'">
		<xsl:attribute name="onLoad">javascript:RecargarInfoCatalogo();</xsl:attribute>
	</xsl:if>
	<!--<form name="form1" action="http://www.newco.dev.br/ProcesosCdC/CatalogoPrivado/MantProductosEstandarSave.xsql" method="post">-->
	<form name="form1" action="http://www.newco.dev.br/ProcesosCdC/CatalogoPrivado/MantProductosEstandarSave.xsql" method="post">
		<!--idioma-->
		<xsl:variable name="lang">
			<xsl:choose>
			<xsl:when test="/Mantenimiento/LANG"><xsl:value-of select="/Mantenimiento/LANG"/></xsl:when>
			<xsl:otherwise>spanish</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
		<!--idioma fin-->

		<!--	Titulo de la página		-->
		<div class="ZonaTituloPagina">
			<p class="Path"><xsl:value-of select="document($doc)/translation/texts/item[@name='Inicio']/node()"/>&nbsp;/&nbsp;<span class="FinPath">
			<xsl:value-of select="document($doc)/translation/texts/item[@name='mantenimiento_productos_estandar']/node()"/>
			</span>
				<span class="CompletarTitulo">
				<xsl:if test="/Mantenimiento/PRODUCTOESTANDAR/CONCONTRATO = 'S'">
					&nbsp;&nbsp;&nbsp;<span class="verde"><xsl:value-of select="document($doc)/translation/texts/item[@name='CON_CONTRATO']/node()"/></span>
				</xsl:if>
				<xsl:if test="/Mantenimiento/PRODUCTOESTANDAR/CONCONTRATO = 'C'">
					&nbsp;&nbsp;&nbsp;<span class="rojo"><xsl:value-of select="document($doc)/translation/texts/item[@name='CONTRATO_CADUCADO']/node()"/></span>
				</xsl:if>

				&nbsp;<a href="#" id="toggleResumenCatalogo" style="text-decoration:none;"><img src="http://www.newco.dev.br/images/info.gif"/></a>
				<xsl:if test="/Mantenimiento/PRODUCTOESTANDAR/MENSAJE">
					<xsl:choose>
						<xsl:when test="/Mantenimiento/PRODUCTOESTANDAR/MENSAJE='OK'">
                            <span style="font-size:13px;"><xsl:value-of select="document($doc)/translation/texts/item[@name='cambios_guardados']/node()"/>
                            :&nbsp;<xsl:value-of select="/Mantenimiento/PRODUCTOESTANDAR/FECHA"/></span>
							<!--&nbsp;-&nbsp;
                            <xsl:value-of select="document($doc)/translation/texts/item[@name='datos_historicos']/node()"/>-->
                        </xsl:when>
						<xsl:otherwise><xsl:value-of select="/Mantenimiento/PRODUCTOESTANDAR/MENSAJE"/>&nbsp;<xsl:value-of select="/Mantenimiento/PRODUCTOESTANDAR/FECHA"/></xsl:otherwise>
					</xsl:choose>
				</xsl:if>
				<xsl:if test="(/Mantenimiento/PRODUCTOESTANDAR/MASTER or /Mantenimiento/PRODUCTOESTANDAR/MASTER_UNICO) and /Mantenimiento/ACCION = 'MODIFICARPRODUCTOESTANDAR'">
					&nbsp;&nbsp;&nbsp;<span class="amarillo">CP_PRO_ID:&nbsp;<xsl:value-of select="/Mantenimiento/PRODUCTOESTANDAR/ID"/></span>
				</xsl:if>
				</span>
			</p>
			<p>
				<xsl:attribute name="class">
				<xsl:choose>
					<!--23abr19	Para productos traspasados-->
					<xsl:when test="Mantenimiento/PRODUCTOESTANDAR/TRASPASADO">TituloPagina rojo</xsl:when>
					<xsl:otherwise>TituloPagina</xsl:otherwise>							
				</xsl:choose>
				</xsl:attribute>
				<!--	Nombre de la categoría si ya existe o "Categoría" -->
				<xsl:choose>
					<!--23abr19	Para productos traspasados-->
					<xsl:when test="Mantenimiento/PRODUCTOESTANDAR/TRASPASADO">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='Traspasado']/node()"/>:&nbsp;<xsl:value-of select="Mantenimiento/PRODUCTOESTANDAR/REFERENCIA"/>&nbsp;<xsl:value-of select="substring(Mantenimiento/PRODUCTOESTANDAR/NOMBRE,1,20)"/>
						-><xsl:value-of select="Mantenimiento/PRODUCTOESTANDAR/TRASPASADO/REFERENCIA"/>&nbsp;<xsl:value-of select="substring(Mantenimiento/PRODUCTOESTANDAR/TRASPASADO/NOMBRE,1,20)"/>
                    </xsl:when>
					<xsl:when test="/Mantenimiento/PRODUCTOESTANDAR/REFCLIENTE != ''">
						<xsl:value-of select="Mantenimiento/PRODUCTOESTANDAR/REFCLIENTE"/>&nbsp;(<xsl:value-of select="Mantenimiento/PRODUCTOESTANDAR/REFERENCIA"/>)&nbsp;<xsl:value-of select="substring(Mantenimiento/PRODUCTOESTANDAR/NOMBRE,1,70)"/>
                    </xsl:when>
					<xsl:when test="/Mantenimiento/PRODUCTOESTANDAR/REFERENCIA != ''">
						<xsl:value-of select="Mantenimiento/PRODUCTOESTANDAR/REFERENCIA"/>&nbsp;<xsl:value-of select="substring(Mantenimiento/PRODUCTOESTANDAR/NOMBRE,1,70)"/>
                    </xsl:when>
					<xsl:otherwise>	
						<xsl:value-of select="document($doc)/translation/texts/item[@name='mantenimiento_productos_estandar']/node()"/>
					</xsl:otherwise>							
				</xsl:choose>
				<span class="CompletarTitulo" style="width:600px;font-size:13px;">
					<!--
        			<a class="btnNormal" href="javascript:document.location='about:blank'">
            			<xsl:value-of select="document($doc)/translation/texts/item[@name='cancelar']/node()"/>
            		</a>
					&nbsp;
					-->
                    <xsl:choose>
                    <xsl:when test="Mantenimiento/ACCION= 'NUEVOPRODUCTOESTANDAR'">
					<!--	Botón "nuevo" -->
						<a class="btnDestacado" id="btnGuardar" href="javascript:GuardarProducto(document.forms[0],'NUEVOPRODUCTOESTANDAR');">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='guardar']/node()"/>
						</a>
                    </xsl:when>
                    <xsl:when test="(Mantenimiento/ACCION='MODIFICAR' or Mantenimiento/ACCION='MOVER' or Mantenimiento/ACCION='MODIFICARPRODUCTOESTANDAR' or Mantenimiento/ACCION= 'COPIARPRODUCTOESTANDAR') and not (Mantenimiento/PRODUCTOESTANDAR/TRASPASADO)">
						<a class="btnDestacado" id="btnGuardar" href="javascript:GuardarProducto(document.forms[0],'MODIFICAR');">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='guardar']/node()"/>
						</a>
						&nbsp;
						<a class="btnNormal" id="btnPrepararDesactivar" href="javascript:PrepararDesactivar();">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='desactivar']/node()"/>
						</a>
						<input type="text" name="REFCLIENTETRASPASO" id="REFCLIENTETRASPASO" value="" size="10" maxlength="20" style="display:none" onInput="javascript:CambiadaReferencia();"/>
						<input type="hidden" name="IDPRODESTANDARTRASPASO" id="IDPRODESTANDARTRASPASO"/>
						<a class="btnNormal" id="btnComprobar" href="javascript:ComprobarTraspaso();" style="display:none">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='comprobar']/node()"/>
						</a>
						<a class="btnNormal" id="btnCancelarDesactivar" href="javascript:CancelarDesactivar();" style="display:none">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='cancelar']/node()"/>
						</a>
						&nbsp;
						<a class="btnDestacado" id="btnDesactivar" href="javascript:Desactivar();" style="display:none">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='desactivar']/node()"/>
						</a>
						<xsl:if test="Mantenimiento/PRODUCTOESTANDAR/IDPRODUCTOADJUDICADO != ''">
						&nbsp;
                		<a class="btnNormal" href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Gestion/Comercial/NuevaEvaluacionProducto.xsql?ID_PROD_ESTANDAR={/Mantenimiento/PRODUCTOESTANDAR/ID}&amp;EMP_ID={/Mantenimiento/CATPRIV_IDEMPRESA}','Evaluación producto',100,80,0,-10);" style="text-decoration:none;">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='evaluacion']/node()"/>
						</a>
						</xsl:if>
                    </xsl:when>
                    <xsl:when test="Mantenimiento/PRODUCTOESTANDAR/TRASPASADO">
						<!--	Botón "Reactivar" para productos traspasados -->
						<a class="btnDestacado" href="javascript:Reactivar();">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='Reactivar']/node()"/>
						</a>
                    </xsl:when>
                    </xsl:choose>
					&nbsp;
					<a class="btnNormal" id="btnAdjudicar" href="http://www.newco.dev.br/ProcesosCdC/CatalogoPrivado/CatalogacionRapida.xsql?IDPRODESTANDAR={/Mantenimiento/PRODUCTOESTANDAR/ID}">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='adjudicado']/node()"/>
					</a>
				</span>
			</p>
		</div>
		<br/>
		<br/>		
                
        <div class="divLeft">
		<div id="ResumenCatalogo" style="display:none;margin-bottom:20px;border-bottom:2px solid #3B5998;">
			<!--<table class="mediaTabla">-->
			<table class="buscador">
			<thead>
				<tr class="sinLinea">
					<th class="trenta">&nbsp;</th>
					<th class="doce" style="text-align:right;"><xsl:value-of select="document($doc)/translation/texts/item[@name='nombre_nivel']/node()"/></th>
					<th class="dies" style="text-align:right;"><xsl:value-of select="document($doc)/translation/texts/item[@name='total']/node()"/></th>
					<th class="dies" style="text-align:right;"><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_cliente']/node()"/></th>
					<th class="dies" style="text-align:right;"><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_mvm']/node()"/></th>
					<th class="">&nbsp;</th>
				</tr>
			</thead>

			<tbody>
				<xsl:if test="/Mantenimiento/PRODUCTOESTANDAR/NOMBRESNIVELES/NIVEL1">
				<tr id="Nivel_1">
					<td>&nbsp;</td>
					<td class="labelRight"><xsl:value-of select="/Mantenimiento/PRODUCTOESTANDAR/NOMBRESNIVELES/NIVEL1"/></td>
					<td class="total datosRight">&nbsp;</td>
					<td class="ref_cliente datosRight">&nbsp;</td>
					<td class="ref_mvm datosRight">&nbsp;</td>
					<td>&nbsp;</td>
				</tr>
				</xsl:if>

				<xsl:if test="/Mantenimiento/PRODUCTOESTANDAR/NOMBRESNIVELES/NIVEL2">
				<tr id="Nivel_2">
					<td>&nbsp;</td>
					<td class="labelRight"><xsl:value-of select="/Mantenimiento/PRODUCTOESTANDAR/NOMBRESNIVELES/NIVEL2"/></td>
					<td class="total datosRight">&nbsp;</td>
					<td class="ref_cliente datosRight">&nbsp;</td>
					<td class="ref_mvm datosRight">&nbsp;</td>
					<td>&nbsp;</td>
				</tr>
				</xsl:if>

				<xsl:if test="/Mantenimiento/PRODUCTOESTANDAR/NOMBRESNIVELES/NIVEL3">
				<tr id="Nivel_3">
					<td>&nbsp;</td>
					<td class="labelRight"><xsl:value-of select="/Mantenimiento/PRODUCTOESTANDAR/NOMBRESNIVELES/NIVEL3"/></td>
					<td class="total datosRight">&nbsp;</td>
					<td class="ref_cliente datosRight">&nbsp;</td>
					<td class="ref_mvm datosRight">&nbsp;</td>
					<td>&nbsp;</td>
				</tr>
				</xsl:if>

				<xsl:if test="/Mantenimiento/PRODUCTOESTANDAR/NOMBRESNIVELES/NIVEL4">
				<tr id="Nivel_4">
					<td>&nbsp;</td>
					<td class="labelRight"><xsl:value-of select="/Mantenimiento/PRODUCTOESTANDAR/NOMBRESNIVELES/NIVEL4"/></td>
					<td class="total datosRight">&nbsp;</td>
					<td class="ref_cliente datosRight">&nbsp;</td>
					<td class="ref_mvm datosRight">&nbsp;</td>
					<td>&nbsp;</td>
				</tr>
				</xsl:if>

				<tr id="Nivel_5">
					<td>&nbsp;</td>
					<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='Productos_estandar']/node()"/></td>
					<td class="total datosRight">&nbsp;</td>
					<td class="ref_cliente datosRight">&nbsp;</td>
					<td class="ref_mvm datosRight">&nbsp;</td>
					<td>&nbsp;</td>
				</tr>
			</tbody>
			</table>
		</div>

		<input type="hidden" name="CATPRIV_IDUSUARIO" VALUE="{Mantenimiento/US_ID}"/>
		<input type="hidden" name="CATPRIV_IDEMPRESA" VALUE="{Mantenimiento/CATPRIV_IDEMPRESA}" id="CATPRIV_IDEMPRESA"/>
		<input type="hidden" name="CATPRIV_ID" VALUE="{Mantenimiento/PRODUCTOESTANDAR/ID}" id="CATPRIV_ID"/>
		<input type="hidden" name="CATPRIV_IDDIVISA" VALUE="{Mantenimiento/PRODUCTOESTANDAR/IDDIVISA}"/>
		<input type="hidden" name="ACCION" VALUE="{Mantenimiento/ACCION}"/>
		<input type="hidden" name="VENTANA" VALUE="{Mantenimiento/VENTANA}"/>
		<input type="hidden" name="REFERENCIAORIGINAL" VALUE="{Mantenimiento/PRODUCTOESTANDAR/REFERENCIA}"/>
		<input type="hidden" name="NOMBREORIGINAL" VALUE="{Mantenimiento/PRODUCTOESTANDAR/NOMBRE}"/>
		<input type="hidden" name="IDCATEGORIA" VALUE="{Mantenimiento/PRODUCTOESTANDAR/CATEGORIA/field/@current}"/>
		<input type="hidden" name="IDFAMILIA" VALUE="{Mantenimiento/PRODUCTOESTANDAR/FAMILIAS/field/@current}"/>
		<input type="hidden" name="IDGRUPO" VALUE="{Mantenimiento/PRODUCTOESTANDAR/GRUPO/field/@current}"/>
        <input type="hidden" name="IDSUBFAMILIA" VALUE="{Mantenimiento/PRODUCTOESTANDAR/SUBFAMILIAS/field/@current}"/>
        <input type="hidden" name="REF_PROD" VALUE="{/Mantenimiento/PRODUCTOESTANDAR/REFERENCIA}"/>
        <input type="hidden" name="LISTA_CENTROS" VALUE=""/>

		<!--<table class="mediaTabla">-->
		<table class="buscador">
		
			<tr class="sinLinea">
				<td colspan="2">&nbsp;</td>
				<td class="textLeft" colspan="2"><span class="rojo"><xsl:value-of select="document($doc)/translation/texts/item[@name='los_siguientes_caracteres_no_deben_sin_barra']/node()"/></span></td>
			</tr>

			<tr class="sinLinea">
				<td>&nbsp;</td>
				<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_alta']/node()"/>:&nbsp;</td>
				<td class="textLeft"><strong><xsl:value-of select="Mantenimiento/PRODUCTOESTANDAR/FECHAALTA"/></strong></td>
				<td>&nbsp;</td>
			</tr>

		<xsl:choose>
		<xsl:when test="Mantenimiento/PRODUCTOESTANDAR/CATEGORIAS">
			<tr class="sinLinea">
				<td>&nbsp;</td>
				<td class="labelRight">
					<xsl:value-of select="Mantenimiento/PRODUCTOESTANDAR/NOMBRESNIVELES/NIVEL1"/>
					<xsl:value-of select="document($doc)/translation/texts/item[@name='de_productos']/node()"/>:&nbsp;
					<xsl:if test="/Mantenimiento/ACCION = 'NUEVOPRODUCTOESTANDAR'">
						<span class="camposObligatorios">*</span>
					</xsl:if>
				</td>
				<td class="textLeft">
					<xsl:value-of select="Mantenimiento/PRODUCTOESTANDAR/CP_CAT_NOMBRE"/>
					<input type="hidden" name="CATPRIV_IDCATEGORIA" id="CATPRIV_IDCATEGORIA" value="{Mantenimiento/PRODUCTOESTANDAR/IDCATEGORIA}"/>
				
				<!--
				<xsl:choose>
				<!- - SOLO CONSULTA - ->
				<xsl:when test="Mantenimiento/TIPO='CONSULTA' or Mantenimiento/PRODUCTOESTANDAR/TRASPASADO or Mantenimiento/PRODUCTOESTANDAR/BLOQUEADO">
					<xsl:for-each select="Mantenimiento/PRODUCTOESTANDAR/CATEGORIAS/field/dropDownList/listElem">
						<xsl:if test="ID=../../@current">
							<xsl:value-of select="listItem"/>
						</xsl:if>
					</xsl:for-each>
				</xsl:when>
				<!- - MODIFICACION - ->
				<xsl:otherwise>
					<xsl:choose>
					<!- - PUEDE CREAR NUEVOS O MODIFICAR EL NOMBRE Y DATOS DE CONSUMO - ->
					<xsl:when test="Mantenimiento/PRODUCTOESTANDAR/MASTER or Mantenimiento/PRODUCTOESTANDAR/MASTER_UNICO">
						<!- - NUEVO - ->
						<xsl:choose>
						<xsl:when test="Mantenimiento/PRODUCTOESTANDAR/ID='0'">
							<xsl:call-template name="desplegable">
								<xsl:with-param name="path" select="Mantenimiento/PRODUCTOESTANDAR/CATEGORIAS/field"/>
							</xsl:call-template>
						</xsl:when>
						<!- - modificacion - ->
						<xsl:otherwise>
							<xsl:call-template name="desplegable_disabled">
								<xsl:with-param name="path" select="Mantenimiento/PRODUCTOESTANDAR/CATEGORIAS/field"/>
							</xsl:call-template>
						</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<!- - USUARIO EDICION, EDICIONES RESTRINGIDAS, SOLO EL NOMBRE Y DATOS DE CONSUMO - ->
					<xsl:otherwise>
						<xsl:for-each select="Mantenimiento/PRODUCTOESTANDAR/CATEGORIAS/field/dropDownList/listElem">
							<xsl:if test="ID=../../@current">
								<xsl:value-of select="listItem"/>
								<input type="hidden" name="CATPRIV_IDCATEGORIA" value="{ID}"/>
							</xsl:if>
						</xsl:for-each>
					</xsl:otherwise>
					</xsl:choose>
				</xsl:otherwise>
				</xsl:choose>
				-->
				</td>
				<td>&nbsp;</td>
			</tr>
		</xsl:when>
		<xsl:otherwise>
			<input type="hidden" name="CATPRIV_IDCATEGORIA" value="{Mantenimiento/PRODUCTOESTANDAR/IDCATEGORIA}"/>
		</xsl:otherwise>
		</xsl:choose>

			<tr class="sinLinea">
				<td>&nbsp;</td>
				<td class="labelRight">
					<xsl:value-of select="Mantenimiento/PRODUCTOESTANDAR/NOMBRESNIVELES/NIVEL2"/>
					<xsl:value-of select="document($doc)/translation/texts/item[@name='de_productos']/node()"/>:&nbsp;
					<xsl:if test="/Mantenimiento/ACCION = 'NUEVOPRODUCTOESTANDAR'">
						<span class="camposObligatorios">*</span>
					</xsl:if>
				</td>
				<td class="textLeft">
					<xsl:value-of select="Mantenimiento/PRODUCTOESTANDAR/CP_FAM_NOMBRE"/>
					<input type="hidden" name="CATPRIV_IDFAMILIA" id="CATPRIV_IDFAMILIA" value="{Mantenimiento/PRODUCTOESTANDAR/IDFAMILIA}"/>

				<!--
				<xsl:choose>
				
				<!- - SOLO CONSULTA - ->
				<xsl:when test="Mantenimiento/TIPO='CONSULTA' or Mantenimiento/PRODUCTOESTANDAR/TRASPASADO or Mantenimiento/PRODUCTOESTANDAR/BLOQUEADO">
					<!- -<xsl:for-each select="Mantenimiento/PRODUCTOESTANDAR/FAMILIAS/field/dropDownList/listElem">
						<xsl:if test="ID=../../@current">
							<xsl:value-of select="listItem"/>
						</xsl:if>
					</xsl:for-each>- ->
					<xsl:for-each select="Mantenimiento/PRODUCTOESTANDAR/TODASSUBFAMILIAS/CATEGORIA/FAMILIA">
						<!- -<xsl:value-of select="@current"/>
						<xsl:value-of select="ID"/>- ->
						<xsl:if test="ID = @current">
							<xsl:value-of select="listItem"/>
						</xsl:if>
					</xsl:for-each>
				</xsl:when>
				<!- - MODIFICACION - ->
				<xsl:otherwise>
					<xsl:choose>
					<!- - PUEDE CREAR NUEVOS O MODIFICAR EL NOMBRE Y DATOS DE CONSUMO - ->
					<xsl:when test="Mantenimiento/PRODUCTOESTANDAR/MASTER or Mantenimiento/PRODUCTOESTANDAR/MASTER_UNICO">
						<!- - NUEVO - ->
						<xsl:choose>
						<xsl:when test="Mantenimiento/PRODUCTOESTANDAR/ID='0'">
							<xsl:call-template name="desplegable">
								<xsl:with-param name="path" select="Mantenimiento/PRODUCTOESTANDAR/FAMILIAS/field"/>
							</xsl:call-template>
						</xsl:when>
						<!- - modificacion - ->
						<xsl:otherwise>
							<xsl:call-template name="desplegable_disabled">
								<xsl:with-param name="path" select="Mantenimiento/PRODUCTOESTANDAR/FAMILIAS/field"/>
							</xsl:call-template>
							
						</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<!- - USUARIO EDICION, EDICIONES RESTRINGIDAS, SOLO EL NOMBRE Y DATOS DE CONSUMO - ->
					<xsl:otherwise>
						<xsl:for-each select="Mantenimiento/PRODUCTOESTANDAR/FAMILIAS/field/dropDownList/listElem">
							<xsl:if test="ID=../../@current">
								<xsl:value-of select="listItem"/>
								<input type="hidden" name="CATPRIV_IDFAMILIA" value="{ID}"/>
							</xsl:if>
						</xsl:for-each>
					</xsl:otherwise>
					</xsl:choose>
				</xsl:otherwise>
				</xsl:choose>
				-->
				
				</td>
				<td>&nbsp;</td>
			</tr>
			<tr class="sinLinea">
				<td>&nbsp;</td>
				<td class="labelRight">
					<xsl:value-of select="Mantenimiento/PRODUCTOESTANDAR/NOMBRESNIVELES/NIVEL3"/>
					<xsl:value-of select="document($doc)/translation/texts/item[@name='de_productos']/node()"/>:&nbsp;
					<xsl:if test="/Mantenimiento/ACCION = 'NUEVOPRODUCTOESTANDAR'">
						<span class="camposObligatorios">*</span>
					</xsl:if>
				</td>
				<td class="textLeft">
					<xsl:value-of select="Mantenimiento/PRODUCTOESTANDAR/CP_SF_NOMBRE"/>
					<input type="hidden" name="CATPRIV_IDSUBFAMILIA" id="CATPRIV_IDSUBFAMILIA" value="{Mantenimiento/PRODUCTOESTANDAR/IDSUBFAMILIA}"/>
					
				<!--	
				<xsl:choose>
				<!- - CONSULTA - ->
				<xsl:when test="/Mantenimiento/TIPO='CONSULTA' or Mantenimiento/PRODUCTOESTANDAR/TRASPASADO or Mantenimiento/PRODUCTOESTANDAR/BLOQUEADO">
					<xsl:for-each select="/Mantenimiento/PRODUCTOESTANDAR/SUBFAMILIAS/field/dropDownList/listElem">
						<xsl:if test="ID=../../@current">
							<xsl:value-of select="listItem"/>
						</xsl:if>
					</xsl:for-each>
				</xsl:when>
				<!- - MODIFICACION - ->
				<xsl:otherwise>
					<xsl:choose>
					<!- - usuario master y master unico, solo nuevos o modificaciones de nombre y datos de consumo - ->
					<xsl:when test="/Mantenimiento/PRODUCTOESTANDAR/MASTER or /Mantenimiento/PRODUCTOESTANDAR/MASTER_UNICO">
						<!- - NUEVO - ->
						<xsl:choose>
						<xsl:when test="/Mantenimiento/PRODUCTOESTANDAR/ID='0'">
							<xsl:call-template name="desplegable">
								<xsl:with-param name="path" select="/Mantenimiento/PRODUCTOESTANDAR/SUBFAMILIAS/field"/>
							</xsl:call-template>
						</xsl:when>
						<!- - modificacion - ->
						<xsl:otherwise>
							<xsl:call-template name="desplegable_disabled">
								<xsl:with-param name="path" select="/Mantenimiento/PRODUCTOESTANDAR/SUBFAMILIAS/field"/>
							</xsl:call-template>
						</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<!- - usuario edicion, modificaciones restringidas, solo nombre y datos de consumo - ->
					<xsl:otherwise>
						<xsl:for-each select="/Mantenimiento/PRODUCTOESTANDAR/SUBFAMILIAS/field/dropDownList/listElem">
							<xsl:if test="ID=../../@current">
								<xsl:value-of select="listItem"/>
								<input type="hidden" name="CATPRIV_IDSUBFAMILIA" value="{ID}"/>
							</xsl:if>
						</xsl:for-each>
					</xsl:otherwise>
					</xsl:choose>
				</xsl:otherwise>
				</xsl:choose>
				-->
				</td>
				<td>&nbsp;</td>
			</tr>

		<xsl:choose>
		<xsl:when test="Mantenimiento/PRODUCTOESTANDAR/GRUPOS">
			<tr class="sinLinea">
				<td>&nbsp;</td>
				<td class="labelRight">
					<xsl:value-of select="Mantenimiento/PRODUCTOESTANDAR/NOMBRESNIVELES/NIVEL4"/>
					<xsl:value-of select="document($doc)/translation/texts/item[@name='de_productos']/node()"/>:&nbsp;
					<xsl:if test="/Mantenimiento/ACCION = 'NUEVOPRODUCTOESTANDAR'">
						<span class="camposObligatorios">*</span>
					</xsl:if>
				</td>
				<td class="textLeft">
					<xsl:value-of select="Mantenimiento/PRODUCTOESTANDAR/CP_GRU_NOMBRE"/>
					<input type="hidden" name="CATPRIV_IDGRUPO" id="CATPRIV_IDGRUPO" value="{Mantenimiento/PRODUCTOESTANDAR/IDGRUPO}"/>
				
				<!--
				<xsl:choose>
				<!- - SOLO CONSULTA - ->
				<xsl:when test="Mantenimiento/TIPO='CONSULTA' or Mantenimiento/PRODUCTOESTANDAR/TRASPASADO or Mantenimiento/PRODUCTOESTANDAR/BLOQUEADO">
					<xsl:for-each select="Mantenimiento/PRODUCTOESTANDAR/GRUPOS/field/dropDownList/listElem">
						<xsl:if test="ID=../../@current">
							<xsl:value-of select="listItem"/>
						</xsl:if>
					</xsl:for-each>
				</xsl:when>
				<!- - MODIFICACION - ->
				<xsl:otherwise>
					<xsl:choose>
					<!- - PUEDE CREAR NUEVOS O MODIFICAR EL NOMBRE Y DATOS DE CONSUMO - ->
					<xsl:when test="Mantenimiento/PRODUCTOESTANDAR/MASTER or Mantenimiento/PRODUCTOESTANDAR/MASTER_UNICO">
						<!- - NUEVO - ->
						<xsl:choose>
						<xsl:when test="Mantenimiento/PRODUCTOESTANDAR/ID='0'">
							<xsl:call-template name="desplegable">
								<xsl:with-param name="path" select="Mantenimiento/PRODUCTOESTANDAR/GRUPOS/field"/>
								<xsl:with-param name="id">CATPRIV_IDGRUPO</xsl:with-param>
								<xsl:with-param name="onChange">ReferenciaGrupo()</xsl:with-param>
							</xsl:call-template>
						</xsl:when>
						<!- - modificacion - ->
						<xsl:otherwise>
							<xsl:call-template name="desplegable_disabled">
								<xsl:with-param name="path" select="Mantenimiento/PRODUCTOESTANDAR/GRUPOS/field"/>
								<xsl:with-param name="id">CATPRIV_IDGRUPO</xsl:with-param>
							</xsl:call-template>
							
						</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<!- - USUARIO EDICION, EDICIONES RESTRINGIDAS, SOLO EL NOMBRE Y DATOS DE CONSUMO - ->
					<xsl:otherwise>
						<xsl:for-each select="Mantenimiento/PRODUCTOESTANDAR/GRUPOS/field/dropDownList/listElem">
							<xsl:if test="ID=../../@current">
								<xsl:value-of select="listItem"/>
								<input type="hidden" name="CATPRIV_IDGRUPO" id="CATPRIV_IDGRUPO" value="{ID}"/>
							</xsl:if>
						</xsl:for-each>
					</xsl:otherwise>
					</xsl:choose>
				</xsl:otherwise>
				</xsl:choose>
				-->
				</td>
				<td>&nbsp;</td>
			</tr>
		</xsl:when>
		<xsl:otherwise>
			<input type="hidden" name="CATPRIV_IDGRUPO" id="CATPRIV_IDGRUPO" value="{Mantenimiento/PRODUCTOESTANDAR/IDGRUPO}">
				<xsl:if test="/Mantenimiento/PRODUCTOESTANDAR/ID = 0 and (/Mantenimiento/PRODUCTOESTANDAR/MASTER or /Mantenimiento/PRODUCTOESTANDAR/MASTER_UNICO)">
					<xsl:attribute name="onchange">javascript:ReferenciaGrupo();</xsl:attribute>
				</xsl:if>
            </input>
		</xsl:otherwise>
		</xsl:choose>

			<tr class="sinLinea">
				<td>&nbsp;</td>
				<td class="labelRight">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='referencia']/node()"/>:&nbsp;
					<span class="camposObligatorios">*</span>
				</td>
				
				<xsl:choose>
				<!--consulta -->
				<xsl:when test="Mantenimiento/TIPO='CONSULTA' or Mantenimiento/PRODUCTOESTANDAR/TRASPASADO or Mantenimiento/PRODUCTOESTANDAR/BLOQUEADO">
					<td class="textLeft"><xsl:value-of select="Mantenimiento/PRODUCTOESTANDAR/REFERENCIA"/></td>
				</xsl:when>
				<!-- modificacion -->
				<xsl:otherwise>
					<xsl:choose>
					
					<!-- usuario master, solo nombre y datos de consumos -->
					<xsl:when test="Mantenimiento/PRODUCTOESTANDAR/MASTER or Mantenimiento/PRODUCTOESTANDAR/MASTER_UNICO">
						<!-- NUEVO -->
						<xsl:choose>
						<xsl:when test="Mantenimiento/PRODUCTOESTANDAR/ID='0' and Mantenimiento/PRODUCTOESTANDAR/REFPROPUESTA!='ERROR'  and Mantenimiento/PRODUCTOESTANDAR/FORZAR_CODIGOS">
							<td class="textLeft">
								<xsl:value-of select="Mantenimiento/PRODUCTOESTANDAR/CP_GRU_REFERENCIA"/><xsl:value-of select="Mantenimiento/PRODUCTOESTANDAR/REFPROPUESTA"/>
								<input type="hidden" name="CATPRIV_REFERENCIA" value="{CP_GRU_REFERENCIA}{Mantenimiento/PRODUCTOESTANDAR/REFPROPUESTA}"/>
								<input type="hidden" name="CATPRIV_REFERENCIA_STRING1" id="CATPRIV_REFERENCIA_STRING1" value="{Mantenimiento/PRODUCTOESTANDAR/CP_GRU_REFERENCIA}"/>
								<input type="hidden" name="CATPRIV_REFERENCIA_STRING2" id="CATPRIV_REF" value="{Mantenimiento/PRODUCTOESTANDAR/REFPROPUESTA}"/>
							</td>
						</xsl:when>
						<xsl:when test="Mantenimiento/PRODUCTOESTANDAR/ID='0' and Mantenimiento/PRODUCTOESTANDAR/REFPROPUESTA!='ERROR' and not(Mantenimiento/PRODUCTOESTANDAR/FORZAR_CODIGOS)">
							<td class="textLeft">
								<input type="text" class="noinput peq" name="CATPRIV_REFERENCIA_TXT" id="CATPRIV_REFERENCIA_TXT" disabled="disabled" size="5"/>
								<input type="hidden" name="CATPRIV_REFERENCIA_STRING1" id="CATPRIV_REFERENCIA_STRING1"/>
								<input type="text" class="muypeq" id="CATPRIV_REF" name="CATPRIV_REFERENCIA_STRING2" size="2" maxlength="3" style="height:20px;" value="{Mantenimiento/PRODUCTOESTANDAR/REFPROPUESTA}"/>&nbsp;
								<input type="hidden" name="CATPRIV_REFERENCIA_AUX"/>
								<input type="hidden" name="CATPRIV_REFERENCIA"/>&nbsp;
								<a href="javascript:ValidarRefProdEstandar(document.forms[0]);" style="text-decoration:none;">
									<xsl:choose>
									<xsl:when test="/Mantenimiento/LANG = 'portugues'">
										<img src="http://www.newco.dev.br/images/comprobar-BR.gif" alt="Verificar"/>
									</xsl:when>
									<xsl:otherwise>
										<img src="http://www.newco.dev.br/images/comprobar.gif" alt="Comprobar"/>
									</xsl:otherwise>
									</xsl:choose>
								</a>
								<span id="RefProd_OK" style="display:none;">&nbsp;
									<img src="http://www.newco.dev.br/images/recibido.gif">
										<xsl:attribute name="alt"><xsl:value-of select="document($doc)/translation/texts/item[@name='referencia_correcta']/node()"/></xsl:attribute>
                                    </img>
								</span>
								<span id="RefProd_ERROR" style="color:#FE2E2E;display:none;">&nbsp;
									<img src="http://www.newco.dev.br/images/error.gif">
										<xsl:attribute name="alt"><xsl:value-of select="document($doc)/translation/texts/item[@name='existe_referencia']/node()"/></xsl:attribute>
                                    </img>&nbsp;
									<xsl:value-of select="document($doc)/translation/texts/item[@name='existe_ref_prod_est']/node()"/>
								</span><br />
								<span id="ley_ref_prodestandar">&nbsp;</span>
							</td>
						</xsl:when>
						<xsl:when test="Mantenimiento/PRODUCTOESTANDAR/ID='0' and Mantenimiento/PRODUCTOESTANDAR/REFPROPUESTA='ERROR'">
							<td class="textLeft">
								<xsl:value-of select="document($doc)/translation/texts/item[@name='todos_codigos_utilizados_requiere_nuevo_grupo']/node()"/>
							</td>
						</xsl:when>
						<!-- modificacion -->
						<xsl:otherwise>
							<xsl:choose>
							<xsl:when test="Mantenimiento/PRODUCTOESTANDAR/FORZAR_CODIGOS">
								<td class="textLeft">
									<xsl:value-of select="Mantenimiento/PRODUCTOESTANDAR/REFERENCIA"/>
									<input type="hidden" name="CATPRIV_REFERENCIA" value="{REFERENCIA}"/>
									<input type="hidden" name="CATPRIV_REFERENCIA_STRING1" id="CATPRIV_REFERENCIA_STRING1" value="{substring(Mantenimiento/PRODUCTOESTANDAR/REFERENCIA,1,6)}"/>
									<input type="hidden" name="CATPRIV_REFERENCIA_STRING2" id="CATPRIV_REF" value="{substring(Mantenimiento/PRODUCTOESTANDAR/REFERENCIA,7)}"/>
								</td>
							</xsl:when>
							<xsl:otherwise>
								<td class="textLeft">
									<input type="text" class="noinput peq" name="CATPRIV_REFERENCIA_TXT" id="CATPRIV_REFERENCIA_TXT" value="{substring(Mantenimiento/PRODUCTOESTANDAR/REFERENCIA,1,6)}" disabled="disabled" size="5"/>
									<input type="hidden" name="CATPRIV_REFERENCIA_STRING1" value="{substring(Mantenimiento/PRODUCTOESTANDAR/REFERENCIA,1,6)}"/>
									<input type="text" class="muypeq" id="CATPRIV_REF" name="CATPRIV_REFERENCIA_STRING2" value="{substring(Mantenimiento/PRODUCTOESTANDAR/REFERENCIA,7)}" maxlength="3" size="2" style="height:20px;"/>
									<input type="hidden" name="CATPRIV_REFERENCIA_AUX" value="{Mantenimiento/PRODUCTOESTANDAR/REFERENCIA}"/>
									<input type="hidden" name="CATPRIV_REFERENCIA"/>&nbsp;
									<a href="javascript:ValidarRefProdEstandar(document.forms[0]);" style="text-decoration:none;">
										<xsl:choose>
										<xsl:when test="/Mantenimiento/LANG = 'portugues'">
											<img src="http://www.newco.dev.br/images/comprobar-BR.gif" alt="Verificar"/>
										</xsl:when>
										<xsl:otherwise>
											<img src="http://www.newco.dev.br/images/comprobar.gif" alt="Comprobar"/>
										</xsl:otherwise>
										</xsl:choose>
									</a>
									<span id="RefProd_OK" style="display:none;">&nbsp;
										<img src="http://www.newco.dev.br/images/recibido.gif">
											<xsl:attribute name="alt"><xsl:value-of select="document($doc)/translation/texts/item[@name='referencia_correcta']/node()"/></xsl:attribute>
                                    	</img>
									</span>
									<span id="RefProd_ERROR" style="color:#FE2E2E;display:none;">&nbsp;
										<img src="http://www.newco.dev.br/images/error.gif">
											<xsl:attribute name="alt"><xsl:value-of select="document($doc)/translation/texts/item[@name='existe_referencia']/node()"/></xsl:attribute>
                                                                        	</img>&nbsp;
										<xsl:value-of select="document($doc)/translation/texts/item[@name='existe_ref_prod_est']/node()"/>
									</span><br />
									<em><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_prod_estandar_3chars']/node()"/></em><br/>
									<span id="ley_ref_prodestandar">&nbsp;</span>
								</td>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<!-- usuario edicion, solo ediciones restringidas, nombre y datos de consumo -->
					<xsl:otherwise>
						<td class="sesanta textLeft">
							<strong>
							<xsl:if test="Mantenimiento/PRODUCTOESTANDAR/REFERENCIA!=''">
								<xsl:value-of select="Mantenimiento/PRODUCTOESTANDAR/REFERENCIA"/>.&nbsp;
							</xsl:if>
							<xsl:value-of select="document($doc)/translation/texts/item[@name='Catalogo_padre']/node()"/>:&nbsp;<xsl:value-of select="Mantenimiento/PRODUCTOESTANDAR/CATALOGO_PADRE"/>.
							</strong> 
							<input type="hidden" name="CATPRIV_REFERENCIA" value="{Mantenimiento/PRODUCTOESTANDAR/REFERENCIA}"/>
						</td>
					</xsl:otherwise>
					</xsl:choose>
				</xsl:otherwise>
				</xsl:choose>

				<td>&nbsp;</td>
			</tr>
			<tr class="sinLinea">
				<td>&nbsp;</td>
				<td class="labelRight">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='nombre']/node()"/>:&nbsp;
					<span class="camposObligatorios">*</span>
				</td>
				<td class="textLeft">
				<xsl:choose>
				<!-- consulta -->
				<xsl:when test="Mantenimiento/TIPO='CONSULTA' or Mantenimiento/PRODUCTOESTANDAR/TRASPASADO or Mantenimiento/PRODUCTOESTANDAR/BLOQUEADO">
					<xsl:value-of select="Mantenimiento/PRODUCTOESTANDAR/NOMBRE"/>
				</xsl:when>
				<!-- edicion -->
				<xsl:otherwise>
					<input type="text" class="muygrande" id="CATPRIV_NOMBRE" name="CATPRIV_NOMBRE" value="{Mantenimiento/PRODUCTOESTANDAR/NOMBRE}" size="70" maxlength="300"/>
					<!-- si es un producto que sigue un catpriv_de otra empresa
					mostramos el boton de restaurtar nombre, en el caso de que se hubiera salido del catalogo -->
					<xsl:if test="not(Mantenimiento/PRODUCTOESTANDAR/MASTER_UNICO) and not(Mantenimiento/PRODUCTOESTANDAR/MASTER)">
						<xsl:if test="Mantenimiento/PRODUCTOESTANDAR/NOMBREPADRE='N'">
							<input type="hidden" name="CATPRIV_PADRE" value="{Mantenimiento/PRODUCTOESTANDAR/NOMBREPADRE}"/>
							<xsl:call-template name="botonPersonalizado">
								<xsl:with-param name="funcion">restaurarNombre(document.forms['form1'].elements['CATPRIV_NOMBRE'],'<xsl:value-of select="Mantenimiento/PRODUCTOESTANDAR/NOMBREPRODUCTO_PADRE"/>',document.forms['form1'].elements['CATPRIV_PADRE']);</xsl:with-param>
								<xsl:with-param name="label">Restaurar Nombre</xsl:with-param>
								<xsl:with-param name="status">Restaura el nombre del producto con el del catálogo que sigue</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
					</xsl:if>
				</xsl:otherwise>
				</xsl:choose>
				</td>
				<td>&nbsp;</td>
			</tr>
			<tr class="sinLinea">
				<td>&nbsp;</td>
				<td class="labelRight">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='completar_nombre']/node()"/>:&nbsp;
				</td>
				<td class="textLeft">
				<xsl:choose>
				<!-- consulta -->
				<xsl:when test="Mantenimiento/TIPO='CONSULTA' or Mantenimiento/PRODUCTOESTANDAR/TRASPASADO">
					<xsl:value-of select="Mantenimiento/PRODUCTOESTANDAR/NOMBRE_PRIVADO"/>
				</xsl:when>
				<!-- edicion -->
				<xsl:otherwise>
					<input type="text" class="muygrande" name="CATPRIV_NOMBRE_PRIVADO" value="{Mantenimiento/PRODUCTOESTANDAR/NOMBRE_PRIVADO}" size="70" maxlength="300"/>
				</xsl:otherwise>
				</xsl:choose>
					&nbsp;(<xsl:value-of select="document($doc)/translation/texts/item[@name='particular']/node()"/>)
				</td>
				<td>&nbsp;</td>
			</tr>
			<tr class="sinLinea">
				<td>&nbsp;</td>
				<td class="labelRight">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='Principio_activo']/node()"/>:&nbsp;
				</td>
				<td class="textLeft">
				<xsl:choose>
				<!-- consulta -->
				<xsl:when test="Mantenimiento/TIPO='CONSULTA' or Mantenimiento/PRODUCTOESTANDAR/TRASPASADO">
					<xsl:value-of select="Mantenimiento/PRODUCTOESTANDAR/CP_PRO_PRINCIPIOACTIVO"/>
				</xsl:when>
				<!-- edicion -->
				<xsl:otherwise>
					<input type="text" class="muygrande" name="CP_PRO_PRINCIPIOACTIVO" value="{Mantenimiento/PRODUCTOESTANDAR/CP_PRO_PRINCIPIOACTIVO}" size="70" maxlength="100"/>
				</xsl:otherwise>
				</xsl:choose>
				</td>
				<td>&nbsp;</td>
			</tr>
			<xsl:if test="Mantenimiento/PRODUCTOESTANDAR/CP_PRO_GRUPODESTOCK">
				<tr class="sinLinea">
					<td>&nbsp;</td>
					<td class="labelRight">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='Grupo_de_stock']/node()"/>:&nbsp;
					</td>
					<td class="textLeft">
                    	<xsl:call-template name="desplegable">
                        	<xsl:with-param name="path" select="Mantenimiento/PRODUCTOESTANDAR/CP_PRO_GRUPODESTOCK/field" />
                        	<xsl:with-param name="claSel">select80</xsl:with-param>
							<xsl:if test="Mantenimiento/TIPO='CONSULTA' or Mantenimiento/PRODUCTOESTANDAR/TRASPASADO">
                        		<xsl:with-param name="style">disabled:disabled</xsl:with-param>
							</xsl:if>
                    	</xsl:call-template>
					</td>
					<td>&nbsp;</td>
				</tr>
			</xsl:if>
			<!--	Comentarios, en campo descripción	-->
			<tr class="sinLinea">
				<td>&nbsp;</td>
				<td class="labelRight">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='comentarios']/node()"/>:&nbsp;
				</td>
				<td class="textLeft">
				<xsl:choose>
				<!-- consulta -->
				<xsl:when test="Mantenimiento/TIPO='CONSULTA' or Mantenimiento/PRODUCTOESTANDAR/TRASPASADO">
					<xsl:value-of select="Mantenimiento/PRODUCTOESTANDAR/DESCRIPCION_HTML"/>
				</xsl:when>
				<!-- edicion -->
				<xsl:otherwise>
					<input type="text" class="muygrande" name="CATPRIV_DESCRIPCION" value="{Mantenimiento/PRODUCTOESTANDAR/DESCRIPCION}" size="70" maxlength="1000"/>
				</xsl:otherwise>
				</xsl:choose>
				</td>
				<td>&nbsp;</td>
			</tr>
            <!--marcas aceptadas-->
            <tr class="sinLinea">
				<td>&nbsp;</td>
				<td class="labelRight">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='marcas']/node()"/>:&nbsp;
				</td>
				<td class="textLeft">
					<xsl:choose>
					<!-- consulta -->
					<xsl:when test="Mantenimiento/TIPO='CONSULTA' or Mantenimiento/PRODUCTOESTANDAR/TRASPASADO">
						<xsl:value-of select="Mantenimiento/PRODUCTOESTANDAR/MARCASACEPTABLES"/>
					</xsl:when>
					<!-- edicion -->
					<xsl:otherwise>
						<input type="text" class="muygrande" name="MARCAS" id="MARCAS" value="{Mantenimiento/PRODUCTOESTANDAR/MARCASACEPTABLES}" size="70" maxlength="300"/>
					</xsl:otherwise>
					</xsl:choose>
				</td>
				<td>&nbsp;</td>
			</tr>
            <!--28cot16	unidad básica-->
            <tr class="sinLinea">
				<td>&nbsp;</td>
				<td class="labelRight">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='unidad_basica']/node()"/>:&nbsp;
				</td>
				<td class="textLeft">
					<xsl:choose>
					<!-- consulta -->
					<xsl:when test="Mantenimiento/TIPO='CONSULTA' or Mantenimiento/PRODUCTOESTANDAR/TRASPASADO or Mantenimiento/PRODUCTOESTANDAR/BLOQUEADO">
						<xsl:value-of select="Mantenimiento/PRODUCTOESTANDAR/UNIDADBASICA"/>
					</xsl:when>
					<!-- edicion -->
					<xsl:otherwise>
						<input type="text" name="CATPRIV_UNIDADBASICA" id="CATPRIV_UNIDADBASICA" value="{Mantenimiento/PRODUCTOESTANDAR/UNIDADBASICA}" size="10" maxlength="300"/>
					</xsl:otherwise>
					</xsl:choose>
				</td>
				<td>&nbsp;</td>
			</tr>
            <!--iva-->
            <xsl:choose>
            <xsl:when test="Mantenimiento/PRODUCTOESTANDAR/IDPAIS != 55 and (not(Mantenimiento/PRODUCTOESTANDAR/ADJUDICADO) or Mantenimiento/PRODUCTOESTANDAR/IDTIPOIVA = '')">
            <tr class="sinLinea">
				<td>&nbsp;</td>
				<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='iva']/node()"/>:&nbsp;</td>
                <td class="textLeft">
                    <xsl:call-template name="desplegable">
                        <xsl:with-param name="path" select="Mantenimiento/PRODUCTOESTANDAR/IVA/field" />
                        <xsl:with-param name="defecto" select="Mantenimiento/PRODUCTOESTANDAR/IDTIPOIVA" />
                        <xsl:with-param name="claSel">select80</xsl:with-param>
                    </xsl:call-template>
                </td>
				<td>&nbsp;</td>
			</tr>
            </xsl:when>
            <xsl:when test="Mantenimiento/PRODUCTOESTANDAR/IDPAIS != 55 and Mantenimiento/PRODUCTOESTANDAR/ADJUDICADO">
            <tr class="sinLinea">
				<td>&nbsp;</td>
				<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='iva']/node()"/>:</td>
                <td class="textLeft"><xsl:value-of select="Mantenimiento/PRODUCTOESTANDAR/IVA/field/dropDownList/listElem[ID = /Mantenimiento/PRODUCTOESTANDAR/IDTIPOIVA]/listItem" />
                    <input type="hidden" name="PRO_IDTIPOIVA" id="PRO_IDTIPOIVA" value="{Mantenimiento/PRODUCTOESTANDAR/IDTIPOIVA}" />
                </td>
				<td>&nbsp;</td>
			</tr>
            </xsl:when>
            <xsl:otherwise>
                <input type="hidden" name="PRO_IDTIPOIVA" id="PRO_IDTIPOIVA" value="{Mantenimiento/PRODUCTOESTANDAR/IDTIPOIVA}" />
            </xsl:otherwise>
            </xsl:choose>
            <!--fin de iva solo para españa-->
            <tr class="sinLinea">
				<td>&nbsp;</td>
				<td class="labelRight">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='precio_ref']/node()"/>:&nbsp;
				</td>
				<td class="textLeft">
                    <xsl:choose>
                    <!-- consulta -->
                    <xsl:when test="Mantenimiento/TIPO='CONSULTA' or Mantenimiento/PRODUCTOESTANDAR/TRASPASADO">
                        <xsl:choose>
                   		 <!-- consulta -->
                    	<xsl:when test="Mantenimiento/PRODUCTOESTANDAR/PRECIOREFERENCIA_FORMATO != ''"><xsl:value-of select="Mantenimiento/PRODUCTOESTANDAR/PRECIOREFERENCIA_FORMATO" /></xsl:when>
						<xsl:otherwise>&nbsp;-&nbsp;</xsl:otherwise>
						</xsl:choose>
                    </xsl:when>
                    <!-- edicion -->
                    <xsl:otherwise>
                        <input type="hidden" name="CATPRIV_PRECIOREFERENCIA_OLD" value="{Mantenimiento/PRODUCTOESTANDAR/PRECIOREFERENCIA_FORMATO}" size="10" maxlength="20"/>
                        <input type="text" name="CATPRIV_PRECIOREFERENCIA" value="{Mantenimiento/PRODUCTOESTANDAR/PRECIOREFERENCIA_FORMATO}" size="10" maxlength="20"/>
                    </xsl:otherwise>
				</xsl:choose>&nbsp;<xsl:value-of select="Mantenimiento/PRODUCTOESTANDAR/DIV_SUFIJO"/>
				</td>
				<td>&nbsp;</td>
			</tr>
            <!--añadido 16-4-15 solo si CP_PRO_PRECIOREFERENCIA_CLI IS NOT NULL OR CP_PRO_CANTIDADANUAL_CLI esta informado-->
            <xsl:if test="Mantenimiento/PRODUCTOESTANDAR/CP_PRO_PRECIOREFERENCIA_CLI != ''">
            <tr class="sinLinea">
				<td>&nbsp;</td>
				<td class="labelRight">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='precio_historico_original']/node()"/>:&nbsp;
				</td>
				<td class="textLeft">
                    <xsl:value-of select="Mantenimiento/PRODUCTOESTANDAR/CP_PRO_PRECIOREFERENCIA_CLI" />
                    &nbsp;<xsl:value-of select="Mantenimiento/PRODUCTOESTANDAR/DIV_SUFIJO"/>
                    <!--&nbsp;
                    <span class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='cantidad_compra_anual']/node()"/>:</span>&nbsp;
                    <xsl:value-of select="Mantenimiento/PRODUCTOESTANDAR/CP_PRO_CANTIDADANUAL_CLI" />
                    &nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='eur']/node()"/>-->
				</td>
				<td>&nbsp;</td>
			</tr>
            </xsl:if>
            <xsl:if test="Mantenimiento/PRODUCTOESTANDAR/CP_PRO_CANTIDADANUAL_CLI != '' ">
            <tr class="sinLinea">
				<td>&nbsp;</td>
				<td class="labelRight">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='cantidad_compra_anual']/node()"/>:&nbsp;
				</td>
				<td class="textLeft">
                    <xsl:value-of select="Mantenimiento/PRODUCTOESTANDAR/CP_PRO_CANTIDADANUAL_CLI" />
                    &nbsp;<xsl:value-of select="Mantenimiento/PRODUCTOESTANDAR/DIV_SUFIJO"/>
				</td>
				<td>&nbsp;</td>
			</tr>
           </xsl:if>
            <xsl:if test="Mantenimiento/PRODUCTOESTANDAR/COMPRAMEDIAMENSUALUNIDADES_FORMATO != ''">
            <tr class="sinLinea">
				<td>&nbsp;</td>
				<td class="labelRight">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='cantidad_compra_mensual_unidades']/node()"/>:&nbsp;
				</td>
				<td class="textLeft">
                    <xsl:value-of select="Mantenimiento/PRODUCTOESTANDAR/COMPRAMEDIAMENSUALUNIDADES_FORMATO" />
                    &nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='unidades']/node()"/>
				</td>
				<td>&nbsp;</td>
			</tr>
           </xsl:if>

            <!--	medicamento regulado, en prioncipio solo colombia-->
            <xsl:choose>
            <xsl:when test="Mantenimiento/PRODUCTOESTANDAR/REGULADO">
            <tr class="sinLinea">
				<td>&nbsp;</td>
				<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='Regulado']/node()"/>:&nbsp;</td>
                <td class="textLeft">
					<input class="muypeq" type="checkbox" name="CHK_REGULADO">
            			<xsl:choose>
            			<xsl:when test="Mantenimiento/PRODUCTOESTANDAR/REGULADO='S'">
							<xsl:attribute name="checked" value="checked"/>
            			</xsl:when>
            			<xsl:otherwise>
 							<xsl:attribute name="unchecked" value="unchecked"/>
           				</xsl:otherwise>
            			</xsl:choose>
					</input>&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Regulado_expli']/node()"/>
                	<input type="hidden" name="REGULADO" id="REGULADO" value="N" />
                </td>
				<td>&nbsp;</td>
			</tr>
            </xsl:when>
            <xsl:otherwise>
                <input type="hidden" name="REGULADO" id="REGULADO" value="N" />
            </xsl:otherwise>
            </xsl:choose>
            <!--fin de iva solo para españa-->


			<tr class="sinLinea">
				<td>&nbsp;</td>
				<td class="labelRight">
					<xsl:choose>
					<xsl:when test="Mantenimiento/PRODUCTOESTANDAR/NOMBREREFCLIENTE">
						<xsl:value-of select="Mantenimiento/PRODUCTOESTANDAR/NOMBREREFCLIENTE"/>:&nbsp;
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="document($doc)/translation/texts/item[@name='ref_cliente']/node()"/>:&nbsp;
					</xsl:otherwise>
					</xsl:choose>
				</td>
				<td class="textLeft">
					<xsl:choose>
					<xsl:when test="Mantenimiento/TIPO='CONSULTA' or Mantenimiento/PRODUCTOESTANDAR/TRASPASADO">
						<xsl:value-of select="Mantenimiento/PRODUCTOESTANDAR/REFCLIENTE"/>
					</xsl:when>
					<xsl:otherwise>
						<input type="hidden" name="CATPRIV_REFCLIENTE_AUX" id="CATPRIV_REFCLIENTE_AUX" value="{Mantenimiento/PRODUCTOESTANDAR/REFCLIENTE}"/>
						<input type="text" name="CATPRIV_REFCLIENTE" id="CATPRIV_REFCLIENTE" value="{Mantenimiento/PRODUCTOESTANDAR/REFCLIENTE}" size="10" maxlength="20"/>&nbsp;
						<a href="javascript:ValidarRefCliente(document.forms[0],'PRODUCTOESTANDAR');" style="text-decoration:none;">
							<xsl:choose>
							<xsl:when test="/Mantenimiento/LANG = 'portugues'">
								<img src="http://www.newco.dev.br/images/comprobar-BR.gif" alt="Verificar"/>
							</xsl:when>
							<xsl:otherwise>
								<img src="http://www.newco.dev.br/images/comprobar.gif" alt="Comprobar"/>
							</xsl:otherwise>
							</xsl:choose>
						</a>
						<span id="RefCliente_OK" style="display:none;">&nbsp;
							<img src="http://www.newco.dev.br/images/recibido.gif">
								<xsl:attribute name="alt"><xsl:value-of select="document($doc)/translation/texts/item[@name='referencia_correcta']/node()"/></xsl:attribute>
							</img>
						</span>
						<span id="RefCliente_ERROR" style="color:#FE2E2E;display:none;">&nbsp;
							<img src="http://www.newco.dev.br/images/error.gif">
								<xsl:attribute name="alt"><xsl:value-of select="document($doc)/translation/texts/item[@name='existe_ref_cliente']/node()"/></xsl:attribute>
							</img>&nbsp;
							<xsl:value-of select="document($doc)/translation/texts/item[@name='existe_ref_cliente_prod_est']/node()"/>
						</span>
					</xsl:otherwise>
					</xsl:choose>
				</td>
				<td>&nbsp;</td>
			</tr>
			<xsl:if test="Mantenimiento/PRODUCTOESTANDAR/DATOS_AVANZADOS">
			<tr class="sinLinea">
				<td>&nbsp;</td>
				<td class="labelRight">
					<xsl:choose>
					<xsl:when test="Mantenimiento/PRODUCTOESTANDAR/NOMBREREFCLIENTE2">
						<xsl:value-of select="Mantenimiento/PRODUCTOESTANDAR/NOMBREREFCLIENTE2"/>:&nbsp;
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="document($doc)/translation/texts/item[@name='ref_cliente']/node()"/>2:&nbsp;
					</xsl:otherwise>
					</xsl:choose>
				</td>
				<td class="textLeft">
					<xsl:choose>
					<xsl:when test="Mantenimiento/TIPO='CONSULTA' or Mantenimiento/PRODUCTOESTANDAR/TRASPASADO">
						<xsl:value-of select="Mantenimiento/PRODUCTOESTANDAR/REFCLIENTE2"/>
					</xsl:when>
					<xsl:otherwise>
						<input type="text" name="CATPRIV_REFCLIENTE2" id="CATPRIV_REFCLIENTE2" value="{Mantenimiento/PRODUCTOESTANDAR/REFCLIENTE2}" size="10" maxlength="20"/>&nbsp;
					</xsl:otherwise>
					</xsl:choose>
				</td>
				<td>&nbsp;</td>
			</tr>
			<tr class="sinLinea">
				<td>&nbsp;</td>
				<td class="labelRight">
					<xsl:choose>
					<xsl:when test="Mantenimiento/PRODUCTOESTANDAR/NOMBREREFCLIENTE3">
						<xsl:value-of select="Mantenimiento/PRODUCTOESTANDAR/NOMBREREFCLIENTE3"/>:&nbsp;
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="document($doc)/translation/texts/item[@name='ref_cliente']/node()"/>3:&nbsp;
					</xsl:otherwise>
					</xsl:choose>
				</td>
				<td class="textLeft">
					<xsl:choose>
					<xsl:when test="Mantenimiento/TIPO='CONSULTA' or Mantenimiento/PRODUCTOESTANDAR/TRASPASADO">
						<xsl:value-of select="Mantenimiento/PRODUCTOESTANDAR/REFCLIENTE3"/>
					</xsl:when>
					<xsl:otherwise>
						<input type="text" name="CATPRIV_REFCLIENTE3" id="CATPRIV_REFCLIENTE3" value="{Mantenimiento/PRODUCTOESTANDAR/REFCLIENTE3}" size="10" maxlength="20"/>&nbsp;
					</xsl:otherwise>
					</xsl:choose>
				</td>
				<td>&nbsp;</td>
			</tr>
			<tr class="sinLinea">
				<td>&nbsp;</td>
				<td class="labelRight">
					<xsl:choose>
					<xsl:when test="Mantenimiento/PRODUCTOESTANDAR/NOMBREREFCLIENTE4">
						<xsl:value-of select="Mantenimiento/PRODUCTOESTANDAR/NOMBREREFCLIENTE4"/>:&nbsp;
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="document($doc)/translation/texts/item[@name='ref_cliente']/node()"/>4:&nbsp;
					</xsl:otherwise>
					</xsl:choose>
				</td>
				<td class="textLeft">
					<xsl:choose>
					<xsl:when test="Mantenimiento/TIPO='CONSULTA' or Mantenimiento/PRODUCTOESTANDAR/TRASPASADO">
						<xsl:value-of select="Mantenimiento/PRODUCTOESTANDAR/REFCLIENTE4"/>
					</xsl:when>
					<xsl:otherwise>
						<input type="text" name="CATPRIV_REFCLIENTE4" id="CATPRIV_REFCLIENTE4" value="{Mantenimiento/PRODUCTOESTANDAR/REFCLIENTE4}" size="10" maxlength="20"/>&nbsp;
					</xsl:otherwise>
					</xsl:choose>
				</td>
				<td>&nbsp;</td>
			</tr>
			<tr class="sinLinea">
				<td>&nbsp;</td>
				<td class="labelRight">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='Unidad_media_base']/node()"/>:&nbsp;
				</td>
				<td class="textLeft">
					<xsl:choose>
					<xsl:when test="Mantenimiento/TIPO='CONSULTA' or Mantenimiento/PRODUCTOESTANDAR/TRASPASADO">
						<xsl:value-of select="Mantenimiento/PRODUCTOESTANDAR/UNIDADMEDIABASE"/>
					</xsl:when>
					<xsl:otherwise>
						<input type="text" name="UNIDADMEDIABASE" id="UNIDADMEDIABASE" value="{Mantenimiento/PRODUCTOESTANDAR/UNIDADMEDIABASE}" size="10" maxlength="20"/>&nbsp;
					</xsl:otherwise>
					</xsl:choose>
				</td>
				<td>&nbsp;</td>
			</tr>
			<tr class="sinLinea">
				<td>&nbsp;</td>
				<td class="labelRight">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='Unidad_pedido']/node()"/>:&nbsp;
				</td>
				<td class="textLeft">
					<xsl:choose>
					<xsl:when test="Mantenimiento/TIPO='CONSULTA' or Mantenimiento/PRODUCTOESTANDAR/TRASPASADO">
						<xsl:value-of select="Mantenimiento/PRODUCTOESTANDAR/UNIDADPEDIDO"/>
					</xsl:when>
					<xsl:otherwise>
						<input type="text" name="UNIDADPEDIDO" id="UNIDADPEDIDO" value="{Mantenimiento/PRODUCTOESTANDAR/UNIDADPEDIDO}" size="10" maxlength="20"/>&nbsp;
					</xsl:otherwise>
					</xsl:choose>
				</td>
				<td>&nbsp;</td>
			</tr>
			<tr class="sinLinea">
				<td>&nbsp;</td>
				<td class="labelRight">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='Relacion_base_pedido']/node()"/>:&nbsp;
				</td>
				<td class="textLeft">
					<xsl:choose>
					<xsl:when test="Mantenimiento/TIPO='CONSULTA' or Mantenimiento/PRODUCTOESTANDAR/TRASPASADO">
						<xsl:value-of select="Mantenimiento/PRODUCTOESTANDAR/RELACIONBASEPEDIDO"/>
					</xsl:when>
					<xsl:otherwise>
						<input type="text" name="RELACIONBASEPEDIDO" id="RELACIONBASEPEDIDO" value="{Mantenimiento/PRODUCTOESTANDAR/RELACIONBASEPEDIDO}" size="10" maxlength="20"/>&nbsp;
					</xsl:otherwise>
					</xsl:choose>
				</td>
				<td>&nbsp;</td>
			</tr>
			<tr class="sinLinea">
				<td>&nbsp;</td>
				<td class="labelRight">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='Stock_minimo']/node()"/>:&nbsp;
				</td>
				<td class="textLeft">
					<xsl:choose>
					<xsl:when test="Mantenimiento/TIPO='CONSULTA' or Mantenimiento/PRODUCTOESTANDAR/TRASPASADO">
						<xsl:value-of select="Mantenimiento/PRODUCTOESTANDAR/STOCKMINIMO"/>
					</xsl:when>
					<xsl:otherwise>
						<input type="text" name="STOCKMINIMO" id="STOCKMINIMO" value="{Mantenimiento/PRODUCTOESTANDAR/STOCKMINIMO}" size="10" maxlength="20"/>&nbsp;
					</xsl:otherwise>
					</xsl:choose>
				</td>
				<td>&nbsp;</td>
			</tr>
			<tr class="sinLinea">
				<td>&nbsp;</td>
				<td class="labelRight">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='Stock_maximo']/node()"/>:&nbsp;
				</td>
				<td class="textLeft">
					<xsl:choose>
					<xsl:when test="Mantenimiento/TIPO='CONSULTA' or Mantenimiento/PRODUCTOESTANDAR/TRASPASADO">
						<xsl:value-of select="Mantenimiento/PRODUCTOESTANDAR/STOCKMAXIMO"/>
					</xsl:when>
					<xsl:otherwise>
						<input type="text" name="STOCKMAXIMO" id="STOCKMAXIMO" value="{Mantenimiento/PRODUCTOESTANDAR/STOCKMAXIMO}" size="10" maxlength="20"/>&nbsp;
					</xsl:otherwise>
					</xsl:choose>
				</td>
				<td>&nbsp;</td>
			</tr>
			<tr class="sinLinea">
				<td>&nbsp;</td>
				<td class="labelRight">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='Tipo_Producto']/node()"/>:&nbsp;
				</td>
				<td class="textLeft">
					<xsl:choose>
					<xsl:when test="Mantenimiento/TIPO='CONSULTA' or Mantenimiento/PRODUCTOESTANDAR/TRASPASADO">
						<xsl:value-of select="Mantenimiento/PRODUCTOESTANDAR/TIPOPRODUCTO"/>
					</xsl:when>
					<xsl:otherwise>
						<input type="text" name="TIPOPRODUCTO" id="TIPOPRODUCTO" value="{Mantenimiento/PRODUCTOESTANDAR/TIPOPRODUCTO}" size="10" maxlength="20"/>&nbsp;
					</xsl:otherwise>
					</xsl:choose>
				</td>
				<td>&nbsp;</td>
			</tr>
			<!--	Lista de centros	-->
			<tr class="sinLinea">
				<td>&nbsp;</td>
				<td class="labelRight">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='Centros_autorizados']/node()"/>:&nbsp;
				</td>
				<td class="textLeft">
					&nbsp;
				</td>
				<td>&nbsp;</td>
			</tr>
			</xsl:if>
			<xsl:choose>
			<xsl:when test="Mantenimiento/PRODUCTOESTANDAR/DATOS_AVANZADOS or Mantenimiento/PRODUCTOESTANDAR/REFERENCIA_CLIENTE_POR_CENTRO">
			<tr class="sinLinea">
				<td>&nbsp;</td>
				<td class="labelRight">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='Orden']/node()"/>:&nbsp;
				</td>
				<td class="textLeft">
					<xsl:choose>
					<xsl:when test="Mantenimiento/TIPO='CONSULTA' or Mantenimiento/PRODUCTOESTANDAR/TRASPASADO">
						<xsl:value-of select="Mantenimiento/PRODUCTOESTANDAR/ORDEN"/>
					</xsl:when>
					<xsl:otherwise>
						<input type="text" name="CP_PRO_ORDEN" id="CP_PRO_ORDEN" value="{Mantenimiento/PRODUCTOESTANDAR/CP_PRO_ORDEN}" size="3" maxlength="3"/>&nbsp;
					</xsl:otherwise>
					</xsl:choose>
				</td>
				<td>&nbsp;</td>
			</tr>
			</xsl:when>
			<xsl:otherwise>
				<input type="hidden" name="CP_PRO_ORDEN" id="CP_PRO_ORDEN" value="{Mantenimiento/PRODUCTOESTANDAR/CP_PRO_ORDEN}" size="3" maxlength="3"/>&nbsp;
			</xsl:otherwise>
			</xsl:choose>
			<!--20abr20	<xsl:if test="Mantenimiento/PRODUCTOESTANDAR/DATOS_AVANZADOS or Mantenimiento/PRODUCTOESTANDAR/REFERENCIA_CLIENTE_POR_CENTRO">-->
			<xsl:if test="Mantenimiento/PRODUCTOESTANDAR/CENTROS/CENTRO">
			<!--	Lista de centros	-->
			<tr class="sinLinea">
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td class="textLeft">
					<a href="javascript:TodosCentros();"><xsl:value-of select="document($doc)/translation/texts/item[@name='todos']/node()"/></a>
				</td>
				<td>
					&nbsp;
				</td>
			</tr>
			
			<xsl:for-each select="Mantenimiento/PRODUCTOESTANDAR/CENTROS/CENTRO">
			<xsl:variable name="lnHomologacion">
				<xsl:choose>
				<xsl:when test="REF_CENTRO!=''">javascript:MostrarPagPersonalizada('http://www.newco.dev.br/ProcesosCdC/CatalogoPrivado/Homologacion.xsql?IDEMPRESA=<xsl:value-of select="/Mantenimiento/CATPRIV_IDEMPRESA"/>&amp;IDCENTRO=<xsl:value-of select="CEN_ID"/>&amp;REFERENCIA=<xsl:value-of select="REF_CENTRO"/>','DetalleCentro',100,45,0,-50);</xsl:when>
				<xsl:otherwise>javascript:MostrarPagPersonalizada('http://www.newco.dev.br/ProcesosCdC/CatalogoPrivado/Homologacion.xsql?IDEMPRESA=<xsl:value-of select="/Mantenimiento/CATPRIV_IDEMPRESA"/>&amp;IDCENTRO=<xsl:value-of select="CEN_ID"/>&amp;REFERENCIA=<xsl:value-of select="/Mantenimiento/PRODUCTOESTANDAR/REFERENCIA"/>','DetalleCentro',100,45,0,-50);</xsl:otherwise>
				</xsl:choose>
			</xsl:variable>
			<tr class="sinLinea">
				<td>&nbsp;</td>
				<td class="labelRight">
					<xsl:value-of select="NOMBRE"/>:&nbsp;
				</td>
				<td class="textLeft">
					<xsl:choose>
					<xsl:when test="Mantenimiento/TIPO='CONSULTA' or Mantenimiento/PRODUCTOESTANDAR/TRASPASADO">
						<xsl:choose>
						<xsl:when test="AUTORIZADO='S'">
							<input class="muypeq" type="checkbox" name="CHK_CENTRO_{CEN_ID}" checked="checked" disabled="true" />
						</xsl:when>
						<xsl:otherwise>
							<input class="muypeq" type="checkbox" name="CHK_CENTRO_{CEN_ID}" unchecked="unchecked" disabled="true" />
						</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:otherwise>
						<xsl:choose>
						<xsl:when test="AUTORIZADO='S'">
							<input class="muypeq" type="checkbox" name="CHK_CENTRO_{CEN_ID}" checked="checked"/>
						</xsl:when>
						<xsl:otherwise>
							<input class="muypeq" type="checkbox" name="CHK_CENTRO_{CEN_ID}" unchecked="unchecked"/>
						</xsl:otherwise>
						</xsl:choose>
					</xsl:otherwise>
					</xsl:choose>
					&nbsp;
					Ref:&nbsp;
					<xsl:choose>
					<xsl:when test="Mantenimiento/TIPO='CONSULTA' or Mantenimiento/PRODUCTOESTANDAR/TRASPASADO">
						<xsl:value-of select="REF_CENTRO"/>
					</xsl:when>
					<xsl:otherwise>
						<input type="text" name="REFCENTRO_{CEN_ID}" id="REFCENTRO_{CEN_ID}" value="{REF_CENTRO}" size="10" maxlength="30" style="width:120px;"/>
					</xsl:otherwise>
					</xsl:choose>
					<!--&nbsp;<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/ProcesosCdC/CatalogoPrivado/Homologacion.xsql?IDEMPRESA={/Mantenimiento/CATPRIV_IDEMPRESA}&amp;IDCENTRO={CEN_ID}&amp;REFERENCIA={REF_CENTRO}','DetalleCentro',100,45,0,-50);"><xsl:value-of select="document($doc)/translation/texts/item[@name='Orden']/node()"/></a>:&nbsp;-->
					&nbsp;<a href="{$lnHomologacion}"><xsl:value-of select="document($doc)/translation/texts/item[@name='Orden']/node()"/></a>:&nbsp;
					<xsl:choose>
					<xsl:when test="Mantenimiento/TIPO='CONSULTA' or Mantenimiento/PRODUCTOESTANDAR/TRASPASADO">
						<xsl:value-of select="ORDEN"/>
					</xsl:when>
					<xsl:otherwise>
						<input type="text" class="muypeq"  style="height:20px;" name="ORDEN_{CEN_ID}" id="ORDEN_{CEN_ID}" value="{ORDEN}" size="2" maxlength="2"/>
					</xsl:otherwise>
					</xsl:choose>
					<!--&nbsp;<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/ProcesosCdC/CatalogoPrivado/Homologacion.xsql?IDEMPRESA={/Mantenimiento/CATPRIV_IDEMPRESA}&amp;IDCENTRO={CEN_ID}&amp;REFERENCIA={REF_CENTRO}','DetalleCentro',100,45,0,-50);"><xsl:value-of select="document($doc)/translation/texts/item[@name='Orden']/node()"/></a>:&nbsp;-->
					&nbsp;<a href="{$lnHomologacion}"><xsl:value-of select="document($doc)/translation/texts/item[@name='PrecioRef']/node()"/></a>:&nbsp;
					<xsl:choose>
					<xsl:when test="Mantenimiento/TIPO='CONSULTA' or Mantenimiento/PRODUCTOESTANDAR/TRASPASADO">
						<xsl:value-of select="PRECIOREFERENCIA"/>
					</xsl:when>
					<xsl:otherwise>
						<input type="text" class="medio" name="PRECIOREF_{CEN_ID}" id="PRECIOREF_{CEN_ID}" value="{PRECIOREFERENCIA}" size="16" maxlength="16"/>
					</xsl:otherwise>
					</xsl:choose>
					&nbsp;
					<!--&nbsp;<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/ProcesosCdC/CatalogoPrivado/Homologacion.xsql?IDEMPRESA={/Mantenimiento/CATPRIV_IDEMPRESA}&amp;IDCENTRO={CEN_ID}&amp;REFERENCIA={REF_CENTRO}','DetalleCentro',100,45,0,-50);"><xsl:value-of select="document($doc)/translation/texts/item[@name='Orden']/node()"/></a>:&nbsp;-->
					&nbsp;<a href="{$lnHomologacion}"><xsl:value-of select="document($doc)/translation/texts/item[@name='ud_basica']/node()"/></a>:&nbsp;
					<xsl:choose>
					<xsl:when test="Mantenimiento/TIPO='CONSULTA' or Mantenimiento/PRODUCTOESTANDAR/TRASPASADO">
						<xsl:value-of select="UNIDADBASICA"/>
					</xsl:when>
					<xsl:otherwise>
						<input type="text" class="medio" name="UDBASICA_{CEN_ID}" id="UDBASICA_{CEN_ID}" value="{UNIDADBASICA}" size="16" maxlength="16"/>
					</xsl:otherwise>
					</xsl:choose>
					&nbsp;
					<xsl:value-of select="document($doc)/translation/texts/item[@name='marcas']/node()"/>:&nbsp;
					<xsl:choose>
					<xsl:when test="Mantenimiento/TIPO='CONSULTA' or Mantenimiento/PRODUCTOESTANDAR/TRASPASADO">
						<xsl:value-of select="MARCASACEPTABLES"/>
					</xsl:when>
					<xsl:otherwise>
						<input type="text" class="medio" name="MARCAS_{CEN_ID}" id="MARCAS_{CEN_ID}" value="{MARCASACEPTABLES}" maxlength="1000"/>
					</xsl:otherwise>
					</xsl:choose>
					&nbsp;
				</td>
				<td>&nbsp;</td>
			</tr>
			</xsl:for-each>
			</xsl:if>
			<tr class="sinLinea">
				<td>&nbsp;</td>
				<td class="labelRight">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='Curva_ABC']/node()"/>:&nbsp;
				</td>
				<td class="textLeft">
					<xsl:choose>
					<xsl:when test="Mantenimiento/TIPO='CONSULTA' or Mantenimiento/PRODUCTOESTANDAR/TRASPASADO">
						<xsl:value-of select="Mantenimiento/PRODUCTOESTANDAR/CURVA_ABC"/>
					</xsl:when>
					<xsl:otherwise>
						<input type="text" name="CURVA_ABC" id="CURVA_ABC" class="muypeq" style="height:20px;" value="{Mantenimiento/PRODUCTOESTANDAR/CURVA_ABC}" size="1" maxlength="1"/>
					</xsl:otherwise>
					</xsl:choose>
				</td>
				<td>&nbsp;</td>
			</tr>
        	<xsl:choose>
        	<xsl:when test="Mantenimiento/PRODUCTOESTANDAR/IDPAIS = 55">
        	<tr class="sinLinea">
				<td>&nbsp;</td>
				<td class="labelRight">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='requiere_licitacion']/node()"/>:</td>
                <td class="textLeft">
                     <xsl:choose>
                        <xsl:when test="Mantenimiento/PRODUCTOESTANDAR/REQUIERELICITACION='S'">
                         <input type="checkbox" class="muypeq" checked="checked" name="REQUIERELICITACION" />
                       </xsl:when>
                       <xsl:otherwise>
                         <input type="checkbox" class="muypeq" name="REQUIERELICITACION" />
                       </xsl:otherwise>
                     </xsl:choose>
                </td>
				<td>&nbsp;</td>
			</tr>
            </xsl:when>
            <xsl:otherwise><input type="hidden" name="REQUIERELICITACION" value="N" /></xsl:otherwise>
            </xsl:choose>
			<!--INICIO Nuevos campos UNIMED	-->
        	<xsl:choose>
        	<xsl:when test="Mantenimiento/PRODUCTOESTANDAR/IDPAIS = 55">
        	<tr class="sinLinea">
				<td>&nbsp;</td>
				<td class="labelRight">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='RegistroMS']/node()"/>:</td>
                <td class="textLeft">
					<xsl:choose>
					<xsl:when test="Mantenimiento/TIPO='CONSULTA' or Mantenimiento/PRODUCTOESTANDAR/TRASPASADO">
						<xsl:value-of select="Mantenimiento/PRODUCTOESTANDAR/CP_PRO_REGISTRO"/>
					</xsl:when>
					<xsl:otherwise>
						<input type="text" name="CP_PRO_REGISTRO" id="CP_PRO_REGISTRO" value="{Mantenimiento/PRODUCTOESTANDAR/CP_PRO_REGISTRO}" size="100" maxlength="100"/>
					</xsl:otherwise>
					</xsl:choose>
                </td>
				<td>&nbsp;</td>
			</tr>
            </xsl:when>
            <xsl:otherwise><input type="hidden" name="REQUIERELICITACION" value="N" /></xsl:otherwise>
            </xsl:choose>
        	<xsl:choose>
        	<xsl:when test="Mantenimiento/PRODUCTOESTANDAR/IDPAIS = 55">
        	<tr class="sinLinea">
				<td>&nbsp;</td>
				<td class="labelRight">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='CaducidadMS']/node()"/>:</td>
                <td class="textLeft">
					<xsl:choose>
					<xsl:when test="Mantenimiento/TIPO='CONSULTA' or Mantenimiento/PRODUCTOESTANDAR/TRASPASADO">
						<xsl:value-of select="Mantenimiento/PRODUCTOESTANDAR/CP_PRO_FECHACADREGISTRO"/>
					</xsl:when>
					<xsl:otherwise>
						<input type="text" name="CP_PRO_FECHACADREGISTRO" id="CP_PRO_FECHACADREGISTRO" value="{Mantenimiento/PRODUCTOESTANDAR/CP_PRO_FECHACADREGISTRO}" size="20" maxlength="20"/>
					</xsl:otherwise>
					</xsl:choose>
                </td>
				<td>&nbsp;</td>
			</tr>
            </xsl:when>
            <xsl:otherwise><input type="hidden" name="REQUIERELICITACION" value="N" /></xsl:otherwise>
            </xsl:choose>
        	<xsl:choose>
        	<xsl:when test="Mantenimiento/PRODUCTOESTANDAR/IDPAIS = 55">
        	<tr class="sinLinea">
				<td>&nbsp;</td>
				<td class="labelRight">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='Oncologico']/node()"/>:</td>
                <td class="textLeft">
                     <xsl:choose>
                        <xsl:when test="Mantenimiento/PRODUCTOESTANDAR/CP_PRO_ONCOLOGICO='S'">
                         <input type="checkbox" class="muypeq" checked="checked" name="CP_PRO_ONCOLOGICO" />
                       </xsl:when>
                       <xsl:otherwise>
                         <input type="checkbox" class="muypeq" name="CP_PRO_ONCOLOGICO" />
                       </xsl:otherwise>
                     </xsl:choose>
                </td>
				<td>&nbsp;</td>
			</tr>
            </xsl:when>
            <xsl:otherwise><input type="hidden" name="CP_PRO_ONCOLOGICO" value="N" /></xsl:otherwise>
            </xsl:choose>
			<!--FIN Nuevos campos UNIMED	-->

            <!--<xsl:choose>
            <xsl:when test="Mantenimiento/PRODUCTOESTANDAR/IDPAIS = '34'">-->
            <tr class="sinLinea">
				<td>&nbsp;</td>
				<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='licitacion']/node()"/>:</td>
                <td class="textLeft">
                    <strong>
                        <xsl:choose>
                        <xsl:when test="/Mantenimiento/PRODUCTOESTANDAR/IDTEXTOLICITACION != ''">
                            <xsl:value-of select="/Mantenimiento/PRODUCTOESTANDAR/IDTEXTOLICITACION"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="document($doc)/translation/texts/item[@name='sin_licitacion']/node()"/>
                        </xsl:otherwise>
                        </xsl:choose>
                    </strong>
                    <input type="hidden" name="CP_PRO_IDTEXTOLICITACION" id="CP_PRO_IDTEXTOLICITACION"  value="{Mantenimiento/PRODUCTOESTANDAR/IDTEXTOLICITACION}"/>
					&nbsp;&nbsp;&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_oferta']/node()"/>:<xsl:value-of select="/Mantenimiento/PRODUCTOESTANDAR/CP_PRO_FECHAOFERTA"/>
					&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Caduca']/node()"/>:<xsl:value-of select="/Mantenimiento/PRODUCTOESTANDAR/CP_PRO_FECHALIMITEOFERTA"/>
                </td>
				<td>&nbsp;</td>
			</tr>
            <!--</xsl:when>
            <xsl:otherwise>
                <input type="hidden" name="CP_PRO_IDTEXTOLICITACION" id="CP_PRO_IDTEXTOLICITACION"/>
            </xsl:otherwise>
            </xsl:choose>-->
			<tr class="sinLinea">
				<td>&nbsp;</td>
				<td colspan="2">&nbsp;</td>
				<td>&nbsp;</td>
			</tr>
			<tr class="sinLinea">
				<!--<td>&nbsp;</td>-->
                <td>&nbsp;</td>
				<td>&nbsp;
					<!--
                    <xsl:choose>
                    <xsl:when test="Mantenimiento/ACCION= 'NUEVOPRODUCTOESTANDAR'">
					<!- -	Botón "nuevo" - ->
					<div class="boton">
						<a href="javascript:GuardarProducto(document.forms[0],'NUEVOPRODUCTOESTANDAR');">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='guardar']/node()"/>
						</a>
					</div>
                    </xsl:when>
                    <xsl:when test="Mantenimiento/ACCION='MODIFICAR' or Mantenimiento/ACCION='MOVER' or Mantenimiento/ACCION='MODIFICARPRODUCTOESTANDAR' or Mantenimiento/ACCION= 'COPIARPRODUCTOESTANDAR'">
					<div class="boton">
						<a href="javascript:GuardarProducto(document.forms[0],'MODIFICAR');">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='guardar']/node()"/>
						</a>
					</div>
                    </xsl:when>
                    </xsl:choose>
					-->
				</td>
				<td class="textLeft">
                    &nbsp;&nbsp;
					<xsl:value-of select="document($doc)/translation/texts/item[@name='los_campos_marcados_con']/node()"/>
					&nbsp;(<span class="camposObligatorios">*</span>)&nbsp;
					<xsl:value-of select="document($doc)/translation/texts/item[@name='son_obligatorios']/node()"/>.
				</td>
				<td>&nbsp;</td>
			</tr>
		</table>
        <br />
        <!--solo si modifica producto-->
        <xsl:if test="Mantenimiento/ACCION= 'MODIFICARPRODUCTOESTANDAR' or Mantenimiento/ACCION= 'MODIFICAR' or Mantenimiento/ACCION= 'COPIARPRODUCTOESTANDAR' or Mantenimiento/ACCION='MOVER'">
		<!--<table class="mediaTabla">-->
			<!--
 		<table class="buscador">
        <tr class="sinLinea">
            <td class="trenta">&nbsp;</td>
           <td class="quince">    
				<a class="btnDestacado" href="javascript:GuardarProducto(document.forms[0],'COPIARPRODUCTOESTANDAR');">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='copiar']/node()"/>
				</a>
            </td>

            <td class="quince">
                <a class="btnDestacado" href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Gestion/Comercial/NuevaEvaluacionProducto.xsql?ID_PROD_ESTANDAR={/Mantenimiento/PRODUCTOESTANDAR/ID}&amp;EMP_ID={/Mantenimiento/CATPRIV_IDEMPRESA}','Evaluación producto',100,80,0,-10);" style="text-decoration:none;">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='solicitar_evaluacion']/node()"/>
				</a>
            </td>                                
			<td>&nbsp;</td>
		</tr>
        </table>
        <br />
        <br />
		-->
		
                
        <!--insertar en una licitación-->
        <xsl:if test="Mantenimiento/PRODUCTOESTANDAR/LICITACIONES != ''">
            <br />
            <br />
			<!--<table class="mediaTabla">-->
			<table class="buscador">
                <tr class="sinLinea">
				<td>&nbsp;</td>
				<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='insertar_licitacion']/node()"/>:</td>
            	<td class="textLeft">
                	<xsl:call-template name="desplegable">
						<xsl:with-param name="path" select="Mantenimiento/PRODUCTOESTANDAR/LICITACIONES/field"/>
                    	<xsl:with-param name="claSel">select200</xsl:with-param>
					</xsl:call-template>&nbsp;

                	<a class="btnDestacadoPeq" href="javascript:InsertarProdLici(document.forms['form1']);">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='insertar']/node()"/>
                    <!--	<xsl:choose>
                        	<xsl:when test="Mantenimiento/PRODUCTOESTANDAR/IDPAIS = '34'"><img src="http://www.newco.dev.br/images/insertar.gif" alt="Insertar"/></xsl:when>
                        	<xsl:otherwise><img src="http://www.newco.dev.br/images/insertar-BR.gif" alt="Inserir"/></xsl:otherwise>
                    	</xsl:choose>
					-->
                	</a>
            	</td>
			</tr>
           </table>
        </xsl:if><!--fin de insertar en una licitación-->
        
		<!--	Información de las tablas de LOG-->
        <xsl:if test="Mantenimiento/PRODUCTOESTANDAR/LOGS/LOG">
            <br />
            <br />
			<!--<table class="mediaTabla">-->
			<table class="buscador">
                <tr class="subTituloTabla">
					<th><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha']/node()"/></th>
					<th><xsl:value-of select="document($doc)/translation/texts/item[@name='usuario']/node()"/></th>
					<th><xsl:value-of select="document($doc)/translation/texts/item[@name='comentarios']/node()"/></th>
				</tr>
				<xsl:for-each select="Mantenimiento/PRODUCTOESTANDAR/LOGS/LOG">
                <tr>
					<td class="textLeft">&nbsp;<xsl:value-of select="FECHA" /></td>
					<td class="textLeft">&nbsp;<xsl:value-of select="USUARIO"/>&nbsp;</td>
					<td class="textLeft"><xsl:value-of select="TEXTO" /></td>
                </tr>
				</xsl:for-each>
           </table>
        </xsl:if><!--fin de insertar en una licitación-->

    </xsl:if><!--fin si es modifica de producto-->

    </div><!--fin de divleft-->
	</form>

	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:choose>
		<xsl:when test="/Mantenimiento/LANG"><xsl:value-of select="/Mantenimiento/LANG" /></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->
	<form name="MensajeJS">
		<input type="hidden" name="OBLI_FAMILIA_PROD_ESTANDAR" value="{document($doc)/translation/texts/item[@name='obli_familia_prod_estandar']/node()}"/>
		<input type="hidden" name="OBLI_REF_PROD_ESTANDAR" value="{document($doc)/translation/texts/item[@name='obli_ref_prod_estandar']/node()}"/>
		<input type="hidden" name="OBLI_NOMBRE_PROD_ESTANDAR" value="{document($doc)/translation/texts/item[@name='obli_nombre_prod_estandar']/node()}"/>
		<input type="hidden" name="OBLI_UN_BASICA_PROD_ESTANDAR" value="{document($doc)/translation/texts/item[@name='obli_un_basica_prod_estandar']/node()}"/>
		<input type="hidden" name="REF_DIFERENTE_PROD_ESTANDAR" value="{document($doc)/translation/texts/item[@name='ref_diferente_prod_estandar']/node()}"/>
		<input type="hidden" name="REF_NO_CORRECTA" value="{document($doc)/translation/texts/item[@name='ref_no_correcta']/node()}"/>
		<input type="hidden" name="NO_DERECHOS_PARA_CREAR" value="{document($doc)/translation/texts/item[@name='no_derechos_para_crear']/node()}"/>
		<input type="hidden" name="OBLI_PRECIO_REF_PROD_ESTANDAR" value="{document($doc)/translation/texts/item[@name='obli_precio_ref_prod_estandar']/node()}"/>
		<input type="hidden" name="OBLI_PRECIO_REF_PROD_ESTANDAR1" value="{document($doc)/translation/texts/item[@name='obli_precio_ref_prod_estandar1']/node()}"/>
		<input type="hidden" name="RESTAURAR_NOMBRE_PRODUCTO" value="{document($doc)/translation/texts/item[@name='restaurar_nombre_producto']/node()}"/>
		<input type="hidden" name="OBLI_NOMBRE_DIFFERENTE" value="{document($doc)/translation/texts/item[@name='obli_nombre_diferente']/node()}"/>
		<input type="hidden" name="OBLI_REF_DIFERENTE" value="{document($doc)/translation/texts/item[@name='obli_ref_diferente']/node()}"/>
		<input type="hidden" name="OBLI_REF_DIFERENTE1" value="{document($doc)/translation/texts/item[@name='obli_ref_diferente1']/node()}"/>
		<input type="hidden" name="NUEVO_PRODUCTO_NUEVA_REF" value="{document($doc)/translation/texts/item[@name='nuevo_producto_nueva_ref']/node()}"/>
		<input type="hidden" name="NUEVO_NOMBRE" value="{document($doc)/translation/texts/item[@name='nuevo_nombre']/node()}"/>
		<input type="hidden" name="NOMBRE_ACTUAL" value="{document($doc)/translation/texts/item[@name='nombre_actual']/node()}"/>
		<input type="hidden" name="MOVER_REF_ERROR" value="{document($doc)/translation/texts/item[@name='mover_ref_error']/node()}"/>
		<input type="hidden" name="LENGTH_REF_NUEVO_PROD_EST" value="{document($doc)/translation/texts/item[@name='length_ref_nuevo_prod_est']/node()}"/>
		<input type="hidden" name="REF_PROD_EST_YA_EXISTE" value="{document($doc)/translation/texts/item[@name='existe_ref_prod_est']/node()}"/>
		<input type="hidden" name="OBLI_REF_CLIENTE_PROD_ESTANDAR" value="{document($doc)/translation/texts/item[@name='obli_ref_cliente_prod_estandar']/node()}"/>
        <input type="hidden" name="SEGURO_CAMBIAR_PRECIO_REF" value="{document($doc)/translation/texts/item[@name='seguro_cambiar_precio_ref']/node()}"/>
        <input type="hidden" name="SEGURO_CAMBIAR_PRECIO_REF_ZERO" value="{document($doc)/translation/texts/item[@name='seguro_cambiar_precio_ref_zero']/node()}"/>
	</form>
</xsl:otherwise>
</xsl:choose>
</body>
</html>
</xsl:template>
</xsl:stylesheet>
