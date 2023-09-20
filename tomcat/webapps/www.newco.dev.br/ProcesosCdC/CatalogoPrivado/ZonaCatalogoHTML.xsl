<?xml version="1.0" encoding="iso-8859-1"?>
<!--
	Margen izquierdo del mantenimiento del catálogo privado
	ultima revision: 5may21 13:00 ZonaCatalogo_050521.js
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
		<xsl:value-of select="/ZonaCatalogo/LANG"/>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<title> <xsl:value-of select="document($doc)/translation/texts/item[@name='mant_cat_priv']/node()"/></title>
	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->

	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/ProcesosCdC/CatalogoPrivado/ZonaCatalogo_050521.js"></script>
	<script>
		var para_prod_estandar		= "<xsl:value-of select="document($doc)/translation/texts/item[@name='para_prod_estandar']/node()"/>";
		var sin_prod_estan_para_editar	= "<xsl:value-of select="document($doc)/translation/texts/item[@name='sin_prod_estandar_para_editar']/node()"/>";
		var sin_prod_estan_para_borrar	= "<xsl:value-of select="document($doc)/translation/texts/item[@name='sin_prod_estandar_para_borrar']/node()"/>";
		var borrar_prod_estandar	= "<xsl:value-of select="document($doc)/translation/texts/item[@name='borrar_prod_estandar']/node()"/>";
		var clientes_utilizan_prod_estandar = "<xsl:value-of select="document($doc)/translation/texts/item[@name='clientes_utilizan_prod_estandar']/node()"/>";
		var prod_estandar_con_consumo	= "<xsl:value-of select="document($doc)/translation/texts/item[@name='prod_estandar_con_consumo']/node()"/>";
		var borrar_prod_estandar_error	= "<xsl:value-of select="document($doc)/translation/texts/item[@name='borrar_prod_estandar_error']/node()"/>";

		var Nivel1 = "<xsl:value-of select="/ZonaCatalogo/AREACATALOGOS/NOMBRESNIVELES/NIVEL1"/>";
		var Nivel2 = "<xsl:value-of select="/ZonaCatalogo/AREACATALOGOS/NOMBRESNIVELES/NIVEL2"/>";
		var Nivel3 = "<xsl:value-of select="/ZonaCatalogo/AREACATALOGOS/NOMBRESNIVELES/NIVEL3"/>";
		var Nivel4 = "<xsl:value-of select="/ZonaCatalogo/AREACATALOGOS/NOMBRESNIVELES/NIVEL4"/>";
		var Nivel5 = "<xsl:value-of select="document($doc)/translation/texts/item[@name='Productos']/node()"/>";
		
		var msgBorrar = "<xsl:value-of select="document($doc)/translation/texts/item[@name='Desea_borrar_nivel']/node()"/>";
		var msgSinNivelParaBorrar = "<xsl:value-of select="document($doc)/translation/texts/item[@name='Sin_nivel_para_borrar']/node()"/>";
		var msgSinNivelParaEditar = "<xsl:value-of select="document($doc)/translation/texts/item[@name='Sin_nivel_para_editar']/node()"/>";
		var msgSinNivelSuperior = "<xsl:value-of select="document($doc)/translation/texts/item[@name='Sin_nivel_superior']/node()"/>";
		var msgNoSePuedeBorrar = "<xsl:value-of select="document($doc)/translation/texts/item[@name='No_se_puede_borrar_nivel']/node()"/>";
	</script>

	<xsl:text disable-output-escaping="yes"><![CDATA[
		<script language="javascript">
		<!--
			var TAMANYO_FRAME_MAXIMIZADO='100';
			var TIPO_TAMANYO_FRAME_MAXIMIZADO='%';
			var TAMANYO_FRAME_NORMAL=290;
			var TIPO_TAMANYO_FRAME_NORMAL='px';
/*
        IMPORTANTE  -- IMPORTANTE --  IMPORTANTE  -- IMPORTANTE --  IMPORTANTE  -- IMPORTANTE --  IMPORTANTE  -- IMPORTANTE

	Los nombres de las funciones seguiran siendo las mismas que en la zona de productos
	esto es necesario porque para hacer la insercion de productos se utilizara el buscador
	de ofertas y pedidos. El listado de productos llama a unas funciones de esos frames
	y no se puede cambiar la estructura, de momento

	IMPORTANTE  -- IMPORTANTE --  IMPORTANTE  -- IMPORTANTE --  IMPORTANTE  -- IMPORTANTE --  IMPORTANTE  -- IMPORTANTE
*/

	]]></xsl:text>

	var arrayCategorias=new Array();
	var arrayFamilias=new Array();
	var arraySubfamilias=new Array();
	var arrayGrupos=new Array();
	var arrayProductosEstandar=new Array();

	<xsl:for-each select="ZonaCatalogo/AREACATALOGOS/CATEGORIAS/field/dropDownList/listElem">
		arrayCategorias[arrayCategorias.length]=new Array('<xsl:value-of select="ID"/>','<xsl:value-of select="listItem"/>','<xsl:value-of select="../../@current"/>','<xsl:value-of select="listItem3"/>');
	</xsl:for-each>

	<xsl:for-each select="ZonaCatalogo/AREACATALOGOS/FAMILIAS/field/dropDownList/listElem">
		arrayFamilias[arrayFamilias.length]=new Array('<xsl:value-of select="ID"/>','<xsl:value-of select="listItem"/>','<xsl:value-of select="../../@current"/>','<xsl:value-of select="listItem3"/>');
	</xsl:for-each>

	<xsl:for-each select="ZonaCatalogo/AREACATALOGOS/SUBFAMILIAS/field/dropDownList/listElem">
		arraySubfamilias[arraySubfamilias.length]=new Array('<xsl:value-of select="ID"/>','<xsl:value-of select="listItem"/>','<xsl:value-of select="../../@current"/>','<xsl:value-of select="listItem3"/>');
	</xsl:for-each>

	<xsl:for-each select="ZonaCatalogo/AREACATALOGOS/GRUPOS/field/dropDownList/listElem">
		arrayGrupos[arrayGrupos.length]=new Array('<xsl:value-of select="ID"/>','<xsl:value-of select="listItem"/>','<xsl:value-of select="../../@current"/>','<xsl:value-of select="listItem3"/>');
	</xsl:for-each>

	<xsl:for-each select="ZonaCatalogo/AREACATALOGOS/PRODUCTOSESTANDAR/field/dropDownList/listElem">
		arrayProductosEstandar[arrayProductosEstandar.length]=new Array('<xsl:value-of select="ID"/>','<xsl:value-of select="listItem"/>','<xsl:value-of select="../../@current"/>','<xsl:value-of select="HIJOS"/>' );
	</xsl:for-each>

	<xsl:text disable-output-escaping="yes"><![CDATA[

	//-->
	</script>  
	]]></xsl:text>
</head>
<body class="areaizq">
	<xsl:choose>
		<xsl:when test="CarpetasYPlantillas/SESION_CADUCADA">
			<xsl:apply-templates select="CarpetasYPlantillas/SESION_CADUCADA"/>
		</xsl:when>
		<xsl:when test="CarpetasYPlantillas/ROWSET/ROW/Sorry">
			<xsl:apply-templates select="CarpetasYPlantillas/ROWSET/ROW/Sorry"/>
		</xsl:when>
		<xsl:otherwise>
			<xsl:attribute name="onLoad">
				CargarProductoEstandar(document.forms[0].elements['CATPRIV_IDPRODUCTOESTANDAR'].value);
			</xsl:attribute>

			<!--idioma-->
			<xsl:variable name="lang">
				<xsl:value-of select="/ZonaCatalogo/LANG"/>
			</xsl:variable>
			<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
			<!--idioma fin-->

			<form name="form1" action="" method="post">
				<input type="hidden" name="CATPRIV_IDUSUARIO" value="1"/>
				<input type="hidden" name="CATPRIV_IDEMPRESA" value="{ZonaCatalogo/AREACATALOGOS/DATOSUSUARIO/EMP_ID}"/>
				<input type="hidden" name="TIPOVENTANA" value="{ZonaCatalogo/TIPOVENTANA}"/>
				<input type="hidden" name="PROPAGAR" value="{ZonaCatalogo/PROPAGAR}"/>
				
				<xsl:choose>
					<xsl:when test="ZonaCatalogo/AREACATALOGOS/MVM">
					<!--<table class="plantilla" style="background:#F44810;">-->
					<table class="areaizq">
						<tr id="table_titulos">
							<th>&nbsp;</th>
							<th colspan="3">
								<xsl:value-of select="document($doc)/translation/texts/item[@name='empresa']/node()"/>
							</th>
							<th>&nbsp;</th>
						</tr>					
						<!--<tr height="5px"><td colspan="5"></td></tr>-->
						<tr align="center" style="height:40px;background:#F44810;">
							<td>&nbsp;</td>
							<td id="td_categorias" colspan="3">
								<xsl:choose>
									<xsl:when test="ZonaCatalogo/AREACATALOGOS/EMPRESA/field/dropDownList/listElem">
										<xsl:call-template name="desplegable">
											<xsl:with-param name="path" select="ZonaCatalogo/AREACATALOGOS/EMPRESA/field"></xsl:with-param>
											<xsl:with-param name="claSel">select200</xsl:with-param>
										</xsl:call-template>
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="document($doc)/translation/texts/item[@name='no_dispone_de_empresas']/node()"/>
										<input type="hidden" name="IDEMPRESA" value="{/ZonaCatalogo/AREACATALOGOS/EMP_ID}"/>
									</xsl:otherwise>
								</xsl:choose>
							</td>
							<td>&nbsp;</td>
						</tr>
						<!--<tr height="5px"><td colspan="5"></td></tr>-->
						<xsl:if test="/ZonaCatalogo/AREACATALOGOS/CATALOGO_PADRE">
						<tr id="table_titulos">
							<th>&nbsp;</th>
							<th colspan="3">
								<xsl:value-of select="document($doc)/translation/texts/item[@name='Cat_padre']/node()"/>:<xsl:value-of select="/ZonaCatalogo/AREACATALOGOS/CATALOGO_PADRE"/>
							</th>
							<th>&nbsp;</th>
						</tr>	
						</xsl:if>				
					</table>
					</xsl:when>
					<xsl:otherwise>
						<input type="hidden" name="IDEMPRESA" value="{/ZonaCatalogo/AREACATALOGOS/EMP_ID}"/>
					</xsl:otherwise>
				</xsl:choose>
				

				<!--tabla plantilla categoria para 5 niveles... 7-01-13 mc -->
				<xsl:choose>
					<xsl:when test="ZonaCatalogo/AREACATALOGOS/CATEGORIAS">
						<!--<table class="plantilla">-->
						<table class="areaizq">
							<tr id="table_titulos">
								<th>&nbsp;</th>
								<th colspan="3">
									<xsl:value-of select="ZonaCatalogo/AREACATALOGOS/NOMBRESNIVELES/NIVEL1"/>
								</th>
								<th>&nbsp;</th>
							</tr>
							<!--<tr height="5px"><td colspan="5"></td></tr>-->
							<tr align="center">
								<td>&nbsp;</td>
								<td id="td_categorias" colspan="3">
									<xsl:choose>
										<xsl:when test="ZonaCatalogo/AREACATALOGOS/CATEGORIAS/field/dropDownList/listElem">
											<xsl:call-template name="desplegable">
												<xsl:with-param name="path" select="ZonaCatalogo/AREACATALOGOS/CATEGORIAS/field"></xsl:with-param>
												<xsl:with-param name="claSel">select200</xsl:with-param>
											</xsl:call-template>
										</xsl:when>
										<xsl:otherwise>
											<xsl:value-of select="document($doc)/translation/texts/item[@name='no_dispone_de_categorias']/node()"/>
											<input type="hidden" name="CATPRIV_IDCATEGORIA"/>
										</xsl:otherwise>
									</xsl:choose>
								</td>
								<td>&nbsp;</td>
							</tr>
							<!--<tr height="5px"><td colspan="5"></td></tr>-->
							<tr align="center">
								<td>&nbsp;</td>
								<xsl:choose>
									<!-- USUARIO CON PRIVILEGIOS DE MASTER_UNICO (EL ANTIGUO EDICION) -->
									<!--<xsl:when test="ZonaCatalogo/AREACATALOGOS/DATOSUSUARIO/MASTER_UNICO or ZonaCatalogo/AREACATALOGOS/DATOSUSUARIO/MASTER">-->
									<xsl:when test="ZonaCatalogo/AREACATALOGOS/CATEGORIAS/BLOQUEAR_ACTUAL='N'">
										<td class="trenta">									
											<a href="javascript:NuevaCategoria('','NUEVACATEGORIA');">
												<xsl:value-of select="document($doc)/translation/texts/item[@name='nuevo']/node()"/>
											</a>

										</td>
										<td class="trenta">
											<a href="javascript:ModificarCategoria(document.forms[0].elements['CATPRIV_IDCATEGORIA'].value,'MODIFICARCATEGORIA');">
												<xsl:value-of select="document($doc)/translation/texts/item[@name='propiedades']/node()"/>
											</a>
										</td>
										<td>
											<a href="javascript:BorrarCategoria(document.forms[0].elements['CATPRIV_IDEMPRESA'].value,document.forms[0].elements['CATPRIV_IDCATEGORIA'].value,'BORRARCATEGORIA');">
												<xsl:value-of select="document($doc)/translation/texts/item[@name='borrar']/node()"/>
											</a>
										</td>
									</xsl:when>
									<!-- USUARIO CON PRIVILEGIOS DE MASTER (PUEDE CAMBIAR EL NOMBRE Y CREAR NUEVAS) - ->
									<xsl:when test="ZonaCatalogo/AREACATALOGOS/DATOSUSUARIO/MASTER">
										<td class="trenta">
											<a href="javascript:NuevaCategoria(document.forms[0].elements['CATPRIV_IDCATEGORIA'].value,'NUEVACATEGORIA');">
												<xsl:value-of select="document($doc)/translation/texts/item[@name='nuevo']/node()"/>
											</a>
										</td>
										<td class="trenta">
											<a href="javascript:ModificarCategoria(document.forms[0].elements['CATPRIV_IDCATEGORIA'].value,document.forms[0].elements['CATPRIV_IDCATEGORIA'].value,'MODIFICARCATEGORIA');">
												<xsl:value-of select="document($doc)/translation/texts/item[@name='propiedades']/node()"/>
											</a>
										</td>
										<td>
											<a href="javascript:BorrarCategoria(document.forms[0].elements['CATPRIV_IDEMPRESA'].value,document.forms[0].elements['CATPRIV_IDCATEGORIA'].value,'BORRARCATEGORIA');">
												<xsl:value-of select="document($doc)/translation/texts/item[@name='borrar']/node()"/>
											</a>
										</td>
									</xsl:when>
									-->
									<!-- USUARIO QUE SOLO PUEDE MODIFICAR ALGUNOS CAMPOS DEL PRODUCTO ESTANDAR -->
									<xsl:when test="ZonaCatalogo/AREACATALOGOS/DATOSUSUARIO/EDICION">
										<td class="trenta">									
											<a href="javascript:NuevaCategoria('','NUEVACATEGORIA');">
												<xsl:value-of select="document($doc)/translation/texts/item[@name='nuevo']/node()"/>
											</a>
										</td>
										<td class="trenta">
											<!--<a href="javascript:ModificarCategoria(document.forms[0].elements['CATPRIV_IDCATEGORIA'].value,'CONSULTARCATEGORIA');">
												<xsl:value-of select="document($doc)/translation/texts/item[@name='propiedades']/node()"/>
											</a>-->
											<a href="javascript:ModificarCategoria(document.forms[0].elements['CATPRIV_IDCATEGORIA'].value,document.forms[0].elements['CATPRIV_IDCATEGORIA'].value,'CONSULTARCATEGORIA');">
												<xsl:value-of select="document($doc)/translation/texts/item[@name='propiedades']/node()"/>
											</a>
										</td>
										<td class="trenta">&nbsp;</td>
									</xsl:when>
								</xsl:choose>
								<td>&nbsp;</td>
							</tr>
						</table>
					</xsl:when>
					<xsl:otherwise>
						<input type="hidden" name="CATPRIV_IDCATEGORIA" value="{/ZonaCatalogo/AREACATALOGOS/IDCATEGORIA}"/>
					</xsl:otherwise>
				</xsl:choose>

				<!--table plantilla familia 2a-->
				<table class="areaizq">
					<tr id="table_titulos">
						<th>&nbsp;</th>
						<th colspan="3">
							<xsl:value-of select="ZonaCatalogo/AREACATALOGOS/NOMBRESNIVELES/NIVEL2"/>
						</th>
						<th>&nbsp;</th>
					</tr>
					<tr align="center">
						<td>&nbsp;</td>
						<td id="td_familias" colspan="3">
							<xsl:choose>
								<xsl:when test="ZonaCatalogo/AREACATALOGOS/FAMILIAS/field/dropDownList/listElem">
									<xsl:call-template name="desplegable">
										<xsl:with-param name="path" select="ZonaCatalogo/AREACATALOGOS/FAMILIAS/field"></xsl:with-param>
										<xsl:with-param name="claSel">select200</xsl:with-param>
									</xsl:call-template>
								</xsl:when>
								<xsl:otherwise>
									<strong><xsl:value-of select="document($doc)/translation/texts/item[@name='no_dispone_de_familias']/node()"/></strong>
									<input type="hidden" name="CATPRIV_IDFAMILIA"/>
								</xsl:otherwise>
							</xsl:choose>
						</td>
						<td>&nbsp;</td>
					</tr>
					<!--<tr height="5px"><td colspan="5"></td></tr>-->
					<tr align="center">
						<td>&nbsp;</td>
						<!--<xsl:choose>-->
							<!-- USUARIO CON PRIVILEGIOS DE MASTER_UNICO (EL ANTIGUO EDICION) -->
							<!--<xsl:when test="ZonaCatalogo/AREACATALOGOS/DATOSUSUARIO/MASTER_UNICO or ZonaCatalogo/AREACATALOGOS/DATOSUSUARIO/MASTER">-->
								<td class="trenta">
									<a href="javascript:NuevaFamilia('',document.forms[0].elements['CATPRIV_IDCATEGORIA'].value,'NUEVAFAMILIA');">
										<xsl:value-of select="document($doc)/translation/texts/item[@name='nuevo']/node()"/>
									</a>
								</td>
								<td class="trenta">
									<a href="javascript:ModificarFamilia(document.forms[0].elements['CATPRIV_IDFAMILIA'].value,document.forms[0].elements['CATPRIV_IDCATEGORIA'].value,'MODIFICARFAMILIA');">
										<xsl:value-of select="document($doc)/translation/texts/item[@name='propiedades']/node()"/>
									</a>
								</td>
							<xsl:if test="ZonaCatalogo/AREACATALOGOS/FAMILIAS/BLOQUEAR_ACTUAL='N'">
								<td>
									<a href="javascript:BorrarFamilia(document.forms[0].elements['CATPRIV_IDEMPRESA'].value,document.forms[0].elements['CATPRIV_IDCATEGORIA'].value,document.forms[0].elements['CATPRIV_IDFAMILIA'].value,'BORRARFAMILIA');">
										<xsl:value-of select="document($doc)/translation/texts/item[@name='borrar']/node()"/>
									</a>
								</td>
							</xsl:if>
							<!-- USUARIO CON PRIVILEGIOS DE MASTER (PUEDE CAMBIAR EL NOMBRE Y CREAR NUEVAS) - ->
							<xsl:when test="ZonaCatalogo/AREACATALOGOS/DATOSUSUARIO/MASTER">
								<td class="trenta">
									<a href="javascript:NuevaFamilia('',document.forms[0].elements['CATPRIV_IDCATEGORIA'].value,'NUEVAFAMILIA');">
										<xsl:value-of select="document($doc)/translation/texts/item[@name='nuevo']/node()"/>
									</a>
								</td>
								<td class="trenta">
									<a href="javascript:ModificarFamilia(document.forms[0].elements['CATPRIV_IDFAMILIA'].value,document.forms[0].elements['CATPRIV_IDCATEGORIA'].value,'MODIFICARFAMILIA');">
										<xsl:value-of select="document($doc)/translation/texts/item[@name='propiedades']/node()"/>
									</a>
								</td>
								<td class="trenta">
									<a href="javascript:BorrarFamilia(document.forms[0].elements['CATPRIV_IDEMPRESA'].value,document.forms[0].elements['CATPRIV_IDCATEGORIA'].value,document.forms[0].elements['CATPRIV_IDFAMILIA'].value,'BORRARFAMILIA');">
										<xsl:value-of select="document($doc)/translation/texts/item[@name='borrar']/node()"/>
									</a>
								</td>
							</xsl:when>
							-->
							<!-- USUARIO QUE SOLO PUEDE MODIFICAR ALGUNOS CAMPOS DEL PRODUCTO ESTANDAR - ->
							<xsl:when test="ZonaCatalogo/AREACATALOGOS/DATOSUSUARIO/EDICION">
								<td class="trenta">&nbsp;</td>
								<td class="trenta">
									<a href="javascript:ModificarFamilia(document.forms[0].elements['CATPRIV_IDFAMILIA'].value,document.forms[0].elements['CATPRIV_IDCATEGORIA'].value,'CONSULTARFAMILIA');">
										<xsl:value-of select="document($doc)/translation/texts/item[@name='propiedades']/node()"/>
									</a>
									<!- - <xsl:call-template name="botonNostyle">
										<xsl:with-param name="path" select="ZonaCatalogo/botones/button[@label='ConsultarFamilia']"/>
									</xsl:call-template>- ->
								</td>
								<td class="trenta">&nbsp;</td>
							</xsl:when>
							<!- - RESTO DE USUARIOS
							<xsl:otherwise>
								<td class="trenta">&nbsp;</td>
								<td class="trenta">
									<a href="javascript:ModificarFamilia(document.forms[0].elements['CATPRIV_IDFAMILIA'].value,document.forms[0].elements['CATPRIV_IDCATEGORIA'].value,'CONSULTARFAMILIA');">
										<xsl:value-of select="document($doc)/translation/texts/item[@name='propiedades']/node()"/>
									</a>
								</td>
							</xsl:otherwise>- ->
						</xsl:choose>-->
						<td>&nbsp;</td>
					</tr>
					<!--<tr height="5px"><td colspan="5">&nbsp;</td></tr>-->
				</table>

				<!--3a tabla plantilla subfamilia-->
				<!--<table class="plantilla">-->
				<table class="areaizq">
					<tr>
						<th>&nbsp;</th>
						<th colspan="3">
							<xsl:value-of select="ZonaCatalogo/AREACATALOGOS/NOMBRESNIVELES/NIVEL3"/>
						</th>
						<th>&nbsp;</th>
					</tr>
					<!--<tr height="5px"><td colspan="5"></td></tr>-->
					<tr align="center">
						<td>&nbsp;</td>
						<td colspan="3" id="td_subfamilias">
							<xsl:choose>
								<xsl:when test="ZonaCatalogo/AREACATALOGOS/SUBFAMILIAS/field/dropDownList/listElem">
									<xsl:call-template name="desplegable">
										<xsl:with-param name="path" select="ZonaCatalogo/AREACATALOGOS/SUBFAMILIAS/field"></xsl:with-param>
										<xsl:with-param name="claSel">select200</xsl:with-param>
									</xsl:call-template>
								</xsl:when>
								<xsl:otherwise>
									<strong><xsl:value-of select="document($doc)/translation/texts/item[@name='no_dispone_de_subfamilias']/node()"/></strong>
									<input type="hidden" name="CATPRIV_IDSUBFAMILIA"/>
								</xsl:otherwise>
							</xsl:choose>
						</td>
						<td>&nbsp;</td>
					</tr>
					<!--<tr height="5px"><td colspan="5"></td></tr>-->
					<tr align="center">
						<td>&nbsp;</td>
						<!--<xsl:choose>-->
							<!-- USUARIO MASTER_UNICO (EL ANTIGUO USUARIO EDICION)-->
							<!--<xsl:when test="ZonaCatalogo/AREACATALOGOS/DATOSUSUARIO/MASTER_UNICO or ZonaCatalogo/AREACATALOGOS/DATOSUSUARIO/MASTER">-->
								<td class="trenta">
									<a href="javascript:NuevaSubfamilia('',document.forms[0].elements['CATPRIV_IDFAMILIA'].value,'NUEVASUBFAMILIA');">
										<xsl:value-of select="document($doc)/translation/texts/item[@name='nuevo']/node()"/>
									</a>
								</td>
								<td class="trenta">
									<a href="javascript:ModificarSubfamilia(document.forms[0].elements['CATPRIV_IDSUBFAMILIA'].value,document.forms[0].elements['CATPRIV_IDFAMILIA'].value,'MODIFICARSUBFAMILIA');">
										<xsl:value-of select="document($doc)/translation/texts/item[@name='propiedades']/node()"/>
									</a>
								</td>
							<xsl:if test="ZonaCatalogo/AREACATALOGOS/SUBFAMILIAS/BLOQUEAR_ACTUAL='N'">
								<td class="trenta">
									<a href="javascript:BorrarSubfamilia(document.forms[0].elements['CATPRIV_IDEMPRESA'].value,document.forms[0].elements['CATPRIV_IDCATEGORIA'].value,document.forms[0].elements['CATPRIV_IDFAMILIA'].value,document.forms[0].elements['CATPRIV_IDSUBFAMILIA'].value,'BORRARSUBFAMILIA');">
										<xsl:value-of select="document($doc)/translation/texts/item[@name='borrar']/node()"/>
									</a>
								</td>
							</xsl:if>
							<!-- USUARIO MASTER (PUEDE CAMBIAR EL NOMBRE Y CREAR NUEVOS)- ->
							<xsl:when test="ZonaCatalogo/AREACATALOGOS/DATOSUSUARIO/MASTER">
								<td class="trenta">
									<a href="javascript:NuevaSubfamilia('',document.forms[0].elements['CATPRIV_IDFAMILIA'].value,'NUEVASUBFAMILIA');">
										<xsl:value-of select="document($doc)/translation/texts/item[@name='nuevo']/node()"/>
									</a>
								</td>
								<td class="trenta">
									<a href="javascript:ModificarSubfamilia(document.forms[0].elements['CATPRIV_IDSUBFAMILIA'].value,document.forms[0].elements['CATPRIV_IDFAMILIA'].value,'MODIFICARSUBFAMILIA');">
										<xsl:value-of select="document($doc)/translation/texts/item[@name='propiedades']/node()"/>
									</a>
								</td>
								<td class="trenta">
										<a href="javascript:BorrarSubfamilia(document.forms[0].elements['CATPRIV_IDEMPRESA'].value,document.forms[0].elements['CATPRIV_IDCATEGORIA'].value,document.forms[0].elements['CATPRIV_IDFAMILIA'].value,document.forms[0].elements['CATPRIV_IDSUBFAMILIA'].value,'BORRARSUBFAMILIA');">
										<xsl:value-of select="document($doc)/translation/texts/item[@name='borrar']/node()"/>
									</a>
								</td>
							</xsl:when>
							-->
							<!-- USUARIO QUE SOLO PUEDE MODIFICAR ALGUNOS CAMPOS DEL PRODUCTO ESTANDAR -->
							<xsl:when test="ZonaCatalogo/AREACATALOGOS/DATOSUSUARIO/EDICION">
								<td class="trenta">&nbsp;</td>
								<td class="trenta">
									<a href="javascript:ModificarSubfamilia(document.forms[0].elements['CATPRIV_IDSUBFAMILIA'].value,document.forms[0].elements['CATPRIV_IDFAMILIA'].value,'CONSULTARSUBFAMILIA');">
										<xsl:value-of select="document($doc)/translation/texts/item[@name='propiedades']/node()"/>
									</a>
								</td>
								<td class="trenta">&nbsp;</td>
							</xsl:when>
							<!-- RESTO DE USUARIOS
							<xsl:otherwise>
								<td class="trenta">&nbsp;</td>
								<td class="trenta">
									<a href="javascript:ModificarSubfamilia(document.forms[0].elements['CATPRIV_IDSUBFAMILIA'].value,document.forms[0].elements['CATPRIV_IDFAMILIA'].value,'CONSULTARSUBFAMILIA');">
										<xsl:value-of select="document($doc)/translation/texts/item[@name='propiedades']/node()"/>
									</a>
								</td>
								<td class="trenta">&nbsp;</td>
							</xsl:otherwise>- ->
						</xsl:choose>-->
						<td>&nbsp;</td>
					</tr>
					<!--<tr height="5px"><td colspan="5">&nbsp;</td></tr>-->
				</table>
				<!--fin 3a tabla-->

				<!--4a tabla plantilla grupos-->
				<xsl:choose>
					<xsl:when test="ZonaCatalogo/AREACATALOGOS/GRUPOS">
						<!--<table class="plantilla">-->
						<table class="areaizq">
							<tr>
								<th>&nbsp;</th>
								<th colspan="3">
									<xsl:value-of select="ZonaCatalogo/AREACATALOGOS/NOMBRESNIVELES/NIVEL4"/>
								</th>
								<th>&nbsp;</th>
							</tr>
							<!--<tr height="5px"><td colspan="5"></td></tr>-->
							<tr align="center">
								<td>&nbsp;</td>
								<td colspan="3" id="td_grupos">
									<xsl:choose>
										<xsl:when test="ZonaCatalogo/AREACATALOGOS/GRUPOS/field/dropDownList/listElem">
											<xsl:call-template name="desplegable">
												<xsl:with-param name="path" select="ZonaCatalogo/AREACATALOGOS/GRUPOS/field"></xsl:with-param>
												<xsl:with-param name="claSel">select200</xsl:with-param>
											</xsl:call-template>
										</xsl:when>
										<xsl:otherwise>
											<strong><xsl:value-of select="document($doc)/translation/texts/item[@name='no_dispone_de_grupos']/node()"/></strong>
											<input type="hidden" name="CATPRIV_IDGRUPO"/>
										</xsl:otherwise>
									</xsl:choose>
								</td>
								<td>&nbsp;</td>
							</tr>
							<!--<tr height="5px"><td colspan="5"></td></tr>-->
							<tr align="center">
								<td>&nbsp;</td>
								<!--<xsl:choose>-->
									<!-- USUARIO MASTER_UNICO (EL ANTIGUO USUARIO EDICION)-->
									<!--<xsl:when test="ZonaCatalogo/AREACATALOGOS/DATOSUSUARIO/MASTER_UNICO or ZonaCatalogo/AREACATALOGOS/DATOSUSUARIO/MASTER">-->
										<td class="trenta">
											<a href="javascript:NuevoGrupo('',document.forms[0].elements['CATPRIV_IDSUBFAMILIA'].value,'NUEVOGRUPO');">
												<xsl:value-of select="document($doc)/translation/texts/item[@name='nuevo']/node()"/>
											</a>
										</td>
										<td class="trenta">
											<a href="javascript:ModificarGrupo(document.forms[0].elements['CATPRIV_IDGRUPO'].value,document.forms[0].elements['CATPRIV_IDSUBFAMILIA'].value,'MODIFICARGRUPO');">
												<xsl:value-of select="document($doc)/translation/texts/item[@name='propiedades']/node()"/>
											</a>
										</td>
									<xsl:if test="ZonaCatalogo/AREACATALOGOS/GRUPOS/BLOQUEAR_ACTUAL='N'">
										<td class="trenta">
											<a href="javascript:BorrarGrupo(document.forms[0].elements['CATPRIV_IDEMPRESA'].value,document.forms[0].elements['CATPRIV_IDCATEGORIA'].value,document.forms[0].elements['CATPRIV_IDFAMILIA'].value,document.forms[0].elements['CATPRIV_IDSUBFAMILIA'].value,document.forms[0].elements['CATPRIV_IDGRUPO'].value,'BORRARGRUPO');">
												<xsl:value-of select="document($doc)/translation/texts/item[@name='borrar']/node()"/>
											</a>
										</td>
									</xsl:if>
									<!-- USUARIO MASTER (PUEDE CAMBIAR EL NOMBRE Y CREAR NUEVOS)- ->
									<xsl:when test="ZonaCatalogo/AREACATALOGOS/DATOSUSUARIO/MASTER">
										<td class="trenta">
											<a href="javascript:NuevoGrupo('',document.forms[0].elements['CATPRIV_IDSUBFAMILIA'].value,'NUEVOGRUPO');">
												<xsl:value-of select="document($doc)/translation/texts/item[@name='nuevo']/node()"/>
											</a>
										</td>
										<td class="trenta">
											<a href="javascript:ModificarGrupo(document.forms[0].elements['CATPRIV_IDGRUPO'].value,document.forms[0].elements['CATPRIV_IDSUBFAMILIA'].value,'MODIFICARGRUPO');">
												<xsl:value-of select="document($doc)/translation/texts/item[@name='propiedades']/node()"/>
											</a>
										</td>
										<td class="trenta">
												<a href="javascript:BorrarGrupo(document.forms[0].elements['CATPRIV_IDEMPRESA'].value,document.forms[0].elements['CATPRIV_IDCATEGORIA'].value,document.forms[0].elements['CATPRIV_IDFAMILIA'].value,document.forms[0].elements['CATPRIV_IDSUBFAMILIA'].value,document.forms[0].elements['CATPRIV_IDGRUPO'].value,'BORRARGRUPO');">
												<xsl:value-of select="document($doc)/translation/texts/item[@name='borrar']/node()"/>
											</a>
										</td>
									</xsl:when>
									-->
									<!-- USUARIO QUE SOLO PUEDE MODIFICAR ALGUNOS CAMPOS DEL GRUPO 
									<xsl:when test="ZonaCatalogo/AREACATALOGOS/DATOSUSUARIO/EDICION">
										<td class="trenta">&nbsp;</td>
										<td class="trenta">
											<a href="javascript:ModificarGrupo(document.forms[0].elements['CATPRIV_IDGRUPO'].value,document.forms[0].elements['CATPRIV_IDSUBFAMILIA'].value,'CONSULTARGRUPO');">
												<xsl:value-of select="document($doc)/translation/texts/item[@name='propiedades']/node()"/>
											</a>
										</td>
										<td class="trenta">&nbsp;</td>
									</xsl:when>
									<!- - RESTO DE USUARIOS
									<xsl:otherwise>
										<td class="trenta">&nbsp;</td>
										<td class="trenta">
											<a href="javascript:ModificarGrupo(document.forms[0].elements['CATPRIV_IDGRUPO'].value,document.forms[0].elements['CATPRIV_IDSUBFAMILIA'].value,'CONSULTARGRUPO');">
												<xsl:value-of select="document($doc)/translation/texts/item[@name='propiedades']/node()"/>
											</a>
										</td>
										<td class="trenta">&nbsp;</td>
									</xsl:otherwise>-->
								<!--</xsl:choose>-->
								<td>&nbsp;</td>
							</tr>
							<!--<tr height="5px"><td colspan="5">&nbsp;</td></tr>-->
						</table>
					</xsl:when>
					<xsl:otherwise>
						<input type="hidden" name="CATPRIV_IDGRUPO" value="{/ZonaCatalogo/AREACATALOGOS/IDGRUPO}"/>
					</xsl:otherwise>
				</xsl:choose>
				<!--fin grupos tabla-->

				<!--5a tabla producto estandar-->
				<!--<table class="plantilla">-->
				<table class="areaizq" style="font-size:13px;">

					<tr>
						<th>&nbsp;</th>
						<th colspan="3">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='Productos_estandar']/node()"/>
						</th>
						<th>&nbsp;</th>
					</tr>

					<!--<tr height="5px"><td colspan="5"></td></tr>-->
					<tr align="center">
						<td>&nbsp;</td>
						<td colspan="3" id="td_productosestandar">
							<xsl:choose>
								<xsl:when test="count(/ZonaCatalogo/AREACATALOGOS/PRODUCTOSESTANDAR/field/dropDownList/listElem)>0">
									<xsl:call-template name="desplegable">
										<xsl:with-param name="path" select="/ZonaCatalogo/AREACATALOGOS/PRODUCTOSESTANDAR/field"></xsl:with-param>
										<xsl:with-param name="claSel">select200</xsl:with-param>
									</xsl:call-template>
								</xsl:when>
								<xsl:otherwise>
									<strong><xsl:value-of select="document($doc)/translation/texts/item[@name='no_dispone_de_productos']/node()"/></strong>
									<input type="hidden" name="CATPRIV_IDPRODUCTOESTANDAR"/>
								</xsl:otherwise>
							</xsl:choose>
						</td>
						<td>&nbsp;</td>
					</tr>
					<!--<tr height="5px"><td colspan="5"></td></tr>-->
					<tr align="center">
						<td>&nbsp;</td>
						<!--<xsl:choose>-->
							<!-- USUARIO MASTER_UNICO, (EL ANTIGUO USUARIOS EDICION) -->
							<!--<xsl:when test="ZonaCatalogo/AREACATALOGOS/DATOSUSUARIO/MASTER_UNICO or ZonaCatalogo/AREACATALOGOS/DATOSUSUARIO/MASTER">-->
							<td class="trenta">
								<a href="javascript:NuevoProductoEstandar('',document.forms[0].elements['CATPRIV_IDGRUPO'].value,document.forms[0].elements['CATPRIV_IDSUBFAMILIA'].value,'NUEVOPRODUCTOESTANDAR');">
									<xsl:value-of select="document($doc)/translation/texts/item[@name='nuevo']/node()"/>
								</a>
							</td>
							<td class="trenta">
								<a href="javascript:ModificarProductoEstandar(document.forms[0].elements['CATPRIV_IDPRODUCTOESTANDAR'].value,document.forms[0].elements['CATPRIV_IDGRUPO'].value,document.forms[0].elements['CATPRIV_IDSUBFAMILIA'].value,document.forms[0].elements['CATPRIV_IDFAMILIA'].value,document.forms[0].elements['CATPRIV_IDCATEGORIA'].value,'MODIFICARPRODUCTOESTANDAR');">
									<xsl:value-of select="document($doc)/translation/texts/item[@name='propiedades']/node()"/>
								</a>
							</td>
							<xsl:if test="ZonaCatalogo/AREACATALOGOS/PRODUCTOSESTANDAR/BLOQUEAR_ACTUAL='N'">
								<td class="trenta">
									<a href="javascript:BorrarProductoEstandarSinConsumo(document.forms[0]);">
										<xsl:value-of select="document($doc)/translation/texts/item[@name='borrar']/node()"/>
									</a>
								</td>
							</xsl:if>
							<!-- USUARIO MASTER (PUEDE CAMBIAR EL NOMBRE Y CREAR NUEVOS)- ->
							<xsl:when test="ZonaCatalogo/AREACATALOGOS/DATOSUSUARIO/MASTER">
								<td class="trenta">
									<a href="javascript:NuevoProductoEstandar('',document.forms[0].elements['CATPRIV_IDGRUPO'].value,document.forms[0].elements['CATPRIV_IDSUBFAMILIA'].value,'NUEVOPRODUCTOESTANDAR');">
										<xsl:value-of select="document($doc)/translation/texts/item[@name='nuevo']/node()"/>
									</a>
								</td>
								<td class="trenta">
									<a href="javascript:ModificarProductoEstandar(document.forms[0].elements['CATPRIV_IDPRODUCTOESTANDAR'].value,document.forms[0].elements['CATPRIV_IDGRUPO'].value,document.forms[0].elements['CATPRIV_IDSUBFAMILIA'].value,document.forms[0].elements['CATPRIV_IDFAMILIA'].value,document.forms[0].elements['CATPRIV_IDCATEGORIA'].value,'MODIFICARPRODUCTOESTANDAR');">
										<xsl:value-of select="document($doc)/translation/texts/item[@name='propiedades']/node()"/>
									</a>
								</td>
								<td class="trenta">
									<a href="javascript:BorrarProductoEstandarSinConsumo(document.forms[0]);">
										<xsl:value-of select="document($doc)/translation/texts/item[@name='borrar']/node()"/>
									</a>
								</td>
							</xsl:when>
							-->
							<!-- USUARIO QUE SOLO PUEDE MODIFICAR ALGUNOS CAMPOS DEL PRODUCTO ESTANDAR O BORRAR UN PRODUCTO ESTANDAR- - >
							<xsl:when test="ZonaCatalogo/AREACATALOGOS/DATOSUSUARIO/EDICION">
								<td class="veinte">&nbsp;</td>
								<td class="trenta">
									<a href="javascript:ModificarProductoEstandar(document.forms[0].elements['CATPRIV_IDPRODUCTOESTANDAR'].value,document.forms[0].elements['CATPRIV_IDGRUPO'].value,document.forms[0].elements['CATPRIV_IDSUBFAMILIA'].value,document.forms[0].elements['CATPRIV_IDFAMILIA'].value,document.forms[0].elements['CATPRIV_IDCATEGORIA'].value,'MODIFICARPRODUCTOESTANDAR');">
										<xsl:value-of select="document($doc)/translation/texts/item[@name='propiedades']/node()"/>
									</a>
								</td>
								<td class="trenta">
								</td>
							</xsl:when>
							-->
						<!--</xsl:choose>-->
						<td>&nbsp;</td>
					</tr>
					<tfoot>
						<tr>
							<td class="footLeft">&nbsp;</td>
							<td colspan="3">&nbsp;</td>
							<td class="footRight">&nbsp;</td>
						</tr>
					</tfoot>
				</table>
			</form>
		</xsl:otherwise>
	</xsl:choose>
</body>
</html>
</xsl:template>
</xsl:stylesheet>
