<?xml version="1.0" encoding="iso-8859-1"?>
<!--
	"ZonaPlantilla" en "EnviarPedidos"
	Ultima revision: ET 21feb21 09:45 ZonaPlantilla_210221.js
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:import href = "http://www.newco.dev.br/General/General.xsl"/>

<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="lang" select="@lang"/>
<xsl:template match="/">
<html>
<head>
	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->
	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/Compras/NuevaMultioferta/ZonaPlantilla_210221.js"></script>
	<script type="text/javascript">
		var HojaDeGastos='<xsl:value-of select="/ZonaPlantilla/HOJADEGASTOS"/>';
		console.log('ZonaPlantillas. HojaDeGastos:'+HojaDeGastos);
		var NumCedula='<xsl:value-of select="/ZonaPlantilla/NUMCEDULA"/>';
		console.log('ZonaPlantillas. NumCedula:'+NumCedula);
		var NombrePaciente='<xsl:value-of select="/ZonaPlantilla/NOMBREPACIENTE"/>';
		console.log('ZonaPlantillas. NombrePaciente:'+NombrePaciente);
		var Habitacion='<xsl:value-of select="/ZonaPlantilla/HABITACION"/>';
		console.log('ZonaPlantillas. Habitacion:'+Habitacion);
	</script>
<xsl:text disable-output-escaping="yes"><![CDATA[

	<script type="text/javascript">
	<!--
		//
		//	Funciones con carpetas
		//

		var msgPrivilegiosEditarCarpeta='No tiene autorización para editar la carpeta.\nPor favor, compruebe quien es el propietario.';
		var msgPrivilegiosEditarPlantilla='No tiene autorización para editar la plantilla.\nPor favor, compruebe quien es el propietario.';
		var msgPrivilegiosBorrarCarpeta='No tiene autorización para borrar la carpeta.\nPor favor, compruebe quien es el propietario.';
		var msgPrivilegiosBorrarPlantilla='No tiene autorización para borrar la plantilla.\nPor favor, compruebe quien es el propietario.';
		var msgPrivilegiosProducto='No tiene autorización para modificar el contenido de la plantilla.\nPor favor, compruebe quien es el propietario.';
		var msgNoCreaCarpetas='No tiene autorización para crear carpetas.\nPor favor, contacte con el usuario Administrador.';
		var msgNoCreaPlantillas='No tiene autorización para crear plantillas. Por favor, contacte con el usuario Administrador.';
		var msgSinPlantilla='No hay ninguna plantilla activa. Por favor, cree una plantilla con el botón Nueva.';
		var msgSinCarpetaParaPlantilla='No hay ninguna carpeta activa. Por favor, cree una carpeta antes de crear la plantilla.';

/*		variables para controlar si el usuario puede modificar la carpeta, plantilla y los productos */

]]></xsl:text>

		var existeCarpeta=<xsl:value-of select="count(ZonaPlantilla/AREAPLANTILLAS/CARPETAS/field/dropDownList/listElem)"/>;
		var existePlantilla=<xsl:value-of select="count(ZonaPlantilla/AREAPLANTILLAS/PLANTILLAS/field/dropDownList/listElem)"/>;

		<xsl:choose>
		<xsl:when test="ZonaPlantilla/AREAPLANTILLAS/CARPETAS/EDICION">
			privilegiosCarpeta=1;
		</xsl:when>
		<xsl:otherwise>
			privilegiosCarpeta=0;
		</xsl:otherwise>
		</xsl:choose>

<!--
		solo se usa esta marca al cargarse la pagina
		una vez se cambia de plantilla, mientras no se recargue la pagina
		(solo pasa si se cambia de carpeta) se coje del arrayPlantillas, para cada una de ellas
-->

		<xsl:choose>
		<xsl:when test="ZonaPlantilla/AREAPLANTILLAS/PLANTILLAS/EDICION">
			var privilegiosPlantilla=1;
		</xsl:when>
		<xsl:otherwise>
			var privilegiosPlantilla=0;
		</xsl:otherwise>
		</xsl:choose>


<xsl:text disable-output-escaping="yes"><![CDATA[
/*
		montamos un array con las plantillas y con los derechos de edicion (atributo EDICION='SI' o sin atributo si no lo tiene)
*/

		var arrayPlantillas=new Array();
]]></xsl:text>
		<xsl:for-each select="//ZonaPlantilla/AREAPLANTILLAS/PLANTILLAS/field/dropDownList/listElem">

			<xsl:variable name="edicion"><xsl:choose><xsl:when test="ID/@EDICION='SI'">1</xsl:when><xsl:otherwise>0</xsl:otherwise></xsl:choose></xsl:variable>

			arrayPlantillas[arrayPlantillas.length]=new Array('<xsl:value-of select="ID"/>', '<xsl:value-of select="listItem"/>',<xsl:value-of select="$edicion"/>);
		</xsl:for-each>
<xsl:text disable-output-escaping="yes"><![CDATA[




		function NuevaPlantilla(){
			var carp_actual = document.forms[0].elements['IDCARPETA'].value;

]]></xsl:text>
			<xsl:choose>
			<xsl:when test="/ZonaPlantilla/AREAPLANTILLAS/NOCREAPLANTILLAS">
				var puedeCrearPlantillas='N';
			</xsl:when>
			<xsl:otherwise>
				var puedeCrearPlantillas='S';
			</xsl:otherwise>
			</xsl:choose>

<xsl:text disable-output-escaping="yes"><![CDATA[

			if(puedeCrearPlantillas=='S'){
				if(carp_actual==-1){
					alert(document.forms['MensajeJS'].elements['NO_CARPETAS_NO_PLANTILLAS'].value);
				}else{
					var objFrame=new Object();
					objFrame=obtenerFrame(top,'areaTrabajo');
					objFrame.location.href='../Multioferta/PLManten.xsql?BOTON=NUEVA';
				}
			}else{
				alert(document.forms['MensajeJS'].elements['NO_AUTORIZADO_CREAR_PLANTILLA'].value);
			}
		}


	//-->
	</script>
]]></xsl:text>
</head>

<body class="areaizq" onLoad="montarDesplegable(arrayPlantillas,document.forms[0].elements['IDPLANTILLA'],'{//ZonaPlantilla/AREAPLANTILLAS/PLANTILLAS/field/@current}');CargarListaProductos(document.forms[0].elements['IDCARPETA'].value, document.forms[0].elements['IDPLANTILLA'].value,'','');">
	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:choose>
		<xsl:when test="/ZonaPlantilla/LANG"><xsl:value-of select="/ZonaPlantilla/LANG" /></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<xsl:choose>
	<xsl:when test="//SESION_CADUCADA">
		<xsl:apply-templates select="//SESION_CADUCADA"/>
	</xsl:when>
	<xsl:otherwise>
		<form action="ZonaPlantilla.xsql" name="plantillas" method="POST">
		<input type="hidden" name="SES_ID"><!--	1mar17 Permitirá limpiar el código javascript	-->
			<xsl:attribute name="value"><xsl:value-of select="//SES_ID"/></xsl:attribute>
		</input>
		<input type="hidden" name="FECHA"/>
		<input type="hidden" name="ACCION"/>
		<input type="hidden" name="IDPRODUCTO"/>
		<input type="hidden" name="CATEGORIA"/>
		<input type="hidden" name="IDNUEVACARPETA">
			<xsl:attribute name="value"><xsl:value-of select="ZonaPlantilla/AREAPLANTILLAS/CARPETAS/field/@current"/></xsl:attribute>
		</input>
		<input type="hidden" name="IDNUEVAPLANTILLA">
			<xsl:attribute name="value"><xsl:value-of select="ZonaPlantilla/AREAPLANTILLAS/PLANTILLAS/field/@current"/></xsl:attribute>
		</input>
		<!-- DC - 30/09/14 - No se muestran pestanyas para 'Compras de Empresa' -->
		<xsl:if test="/ZonaPlantilla/AREAPLANTILLAS/IDPORTAL = 'MVM' and /ZonaPlantilla/AREAPLANTILLAS/SEPARAR_FARMACIA">
			<table class="plantilla">
				<tr>
					<td id="tdFarmacia">
						<xsl:attribute name="style">
                		<xsl:choose>
							<xsl:when test="ZonaPlantilla/AREAPLANTILLAS/CATEGORIA = 'F'">background:#ffffff; font-weight:bold; border:2px solid #3b5998; border-bottom:0px; padding:5px 3px; text-align:center;</xsl:when>
							<xsl:when test="ZonaPlantilla/AREAPLANTILLAS/CATEGORIA = 'N'">background:#e4e4e5; font-weight:bold; padding:5px 3px; text-align:center;</xsl:when>
                            <xsl:otherwise>background:#e4e4e5; font-weight:bold; padding:5px 3px; text-align:center;</xsl:otherwise>
                        </xsl:choose>
						</xsl:attribute>

						<a id="verFarmacia" style="cursor:pointer; text-decoration:none;" onclick="cambioCategoria('CAMBIOCATEGORIA','F');" title="Farmacia">
							<img src="http://www.newco.dev.br/images/farmacia-icon.gif" alt="Farmacia" />
						</a>
					</td>
					<td id="tdMatSan">
						<xsl:attribute name="style">
							<xsl:if test="ZonaPlantilla/AREAPLANTILLAS/CATEGORIA = 'F'">background:#e4e4e5; font-weight:bold; padding:5px 3px; text-align:center;</xsl:if>
							<xsl:if test="ZonaPlantilla/AREAPLANTILLAS/CATEGORIA = 'N'">background:#ffffff; font-weight:bold; border:2px solid #3b5998; border-bottom:0px; padding:5px 3px; text-align:center;</xsl:if>
						</xsl:attribute>

						<a id="verMatSan" style="cursor:pointer; text-decoration:none;" onclick="cambioCategoria('CAMBIOCATEGORIA','N');" title="Material Sanitario">
							<img src="http://www.newco.dev.br/images/matSan-icon.gif" alt="Material Sanitario"/>
						</a>
					</td>
				</tr>
			</table><!--fin de pestañas-->
		</xsl:if>

			<xsl:choose>
			<xsl:when test="ZonaPlantilla/AREAPLANTILLAS/VERCARPETAS">

				<table class="plantilla">
				<thead>
					<tr>
						<th>&nbsp;</th>
						<th colspan="3" style="padding:3px 0px;"><xsl:value-of select="document($doc)/translation/texts/item[@name='carpetas']/node()"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<!--[ <a href="javascript:ListarCarpetasYPlantillas();" onMouseOver="window.status='Lista todas las carpetas y sus plantillas';return true;" onMouseOut="window.status='';return true;"><xsl:value-of select="document($doc)/translation/texts/item[@name='ver_todas']/node()"/></a> ]-->
						</th>
						<th>&nbsp;</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>&nbsp;</td>
						<td colspan="3" class="select">
							<xsl:choose>
							<xsl:when test="ZonaPlantilla/AREAPLANTILLAS/CARPETAS/field/dropDownList/listElem">
								<xsl:call-template name="desplegable">
									<xsl:with-param name="path" select="ZonaPlantilla/AREAPLANTILLAS/CARPETAS/field"/>
								</xsl:call-template>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="document($doc)/translation/texts/item[@name='no_dispone_carpetas']/node()"/>
								<input type="hidden" name="IDCARPETA" value="-1"/>
							</xsl:otherwise>
							</xsl:choose>
						</td>
						<td>&nbsp;</td>
					</tr>
					<!--<tr>
						<xsl:choose>
						<xsl:when test="/ZonaPlantilla/AREAPLANTILLAS/NOCREAPLANTILLAS">
							<td>&nbsp;</td>
							<td colspan="3">&nbsp;</td>
							<td>&nbsp;</td>
						</xsl:when>
						<xsl:otherwise>
							<td>&nbsp;</td>
							<td class="cinco">
								<xsl:call-template name="botonNostyle">
									<xsl:with-param name="path" select="ZonaPlantilla/button[@label='NuevaCarpeta']"/>
								</xsl:call-template>
							</td>
							<td>&nbsp;&nbsp;&nbsp;
								<a href="javascript:EditarCarpeta();">
									<xsl:value-of select="document($doc)/translation/texts/item[@name='propriedades']/node()"/>
								</a>
							</td>
							<td>
								<a href="javascript:BorrarCarpeta();">
									<xsl:value-of select="document($doc)/translation/texts/item[@name='borrar']/node()"/>
								</a>&nbsp;&nbsp;
							</td>
							<td>&nbsp;</td>
						</xsl:otherwise>
						</xsl:choose>
					</tr>-->
				</tbody>
				<tfoot>
					<tr height="5px">
						<td></td>
						<td colspan="3"></td>
						<td></td>
					</tr>
				</tfoot>
				</table>
			</xsl:when>
			<xsl:otherwise>
				<!--NO VER CARPETAS-->
				<input type="hidden" name="IDCARPETA">
					<xsl:attribute name="value"><xsl:value-of select="ZonaPlantilla/AREAPLANTILLAS/CARPETAS/field/@current"/></xsl:attribute>
				</input>
			</xsl:otherwise>
			</xsl:choose>

			<!--PLANTILLAS-->
			<!--<table class="plantilla">-->
			<table class="areaizq">
			<thead>
				<tr>
					<th>&nbsp;</th>
					<th colspan="3"> <xsl:value-of select="document($doc)/translation/texts/item[@name='Proveedores']/node()"/>&nbsp;&nbsp;
						<!--<xsl:choose>
						<xsl:when test="ZonaPlantilla/AREAPLANTILLAS/PLANTILLAS/EDICION">
							<a href="javascript:ListarProductosPlantillas();" onMouseOver="window.status='Lista todos los productos y plantillas a las que pertenecen';return true;" onMouseOut="window.status='';return true;"> <xsl:value-of select="document($doc)/translation/texts/item[@name='todas']/node()"/></a>

							<xsl:if test="ZonaPlantilla/AREAPLANTILLAS/CDC">
								&nbsp;&nbsp;<a href="javascript:PlantillasPorUsuario();" onMouseOver="window.status='Plantillas por usuario';return true;" onMouseOut="window.status='';return true;"> <xsl:value-of select="document($doc)/translation/texts/item[@name='usuarios']/node()"/></a>
							</xsl:if>
						 </xsl:when>
						</xsl:choose>-->
					</th>
					<th>&nbsp;</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>&nbsp;</td>
					<td colspan="3" class="select">
						<xsl:choose>
						<xsl:when test="ZonaPlantilla/AREAPLANTILLAS/PLANTILLAS/field/dropDownList/listElem">
							<xsl:call-template name="desplegable">
								<xsl:with-param name="path" select="ZonaPlantilla/AREAPLANTILLAS/PLANTILLAS/field"/>
							</xsl:call-template>
						</xsl:when>
						<xsl:otherwise>
							<br/>
							<xsl:value-of select="document($doc)/translation/texts/item[@name='no_dispone_plantillas']/node()"/>
							<br/>&nbsp;
							<input type="hidden" name="IDPLANTILLA" value="-1"/>
						</xsl:otherwise>
						</xsl:choose>
					</td>
					<td>&nbsp;</td>
				</tr>
			<!--si usuario con derechos enseño botones-->
			<xsl:if test="ZonaPlantilla/AREAPLANTILLAS/PLANTILLAS/EDICION">
				<tr>
					<td>&nbsp;</td>
					<td class="cinco">
						<!--<xsl:call-template name="botonNostyle">
							<xsl:with-param name="path" select="ZonaPlantilla/button[@label='NuevaPlantilla']"/>
						</xsl:call-template>-->
					</td>
					<td>
						<a href="javascript:EditarPlantilla();">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='propiedades']/node()"/>
						</a>
					</td>
					<td>
						<a href="javascript:BorrarPlantilla();">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='borrar']/node()"/>
						</a>
					</td>
					<td>&nbsp;</td>
				</tr>
			</xsl:if>
			</tbody>

			<xsl:if test="ZonaPlantilla/AREAPLANTILLAS/VERCARPETAS">
				<tr>
					<td>&nbsp;</td>
					<td colspan="3" height="25px;" align="center" valign="bottom">
						<a href="javascript:PrepararOfertaPedido('DIRECTO');" title="Preparar pedido" class="strongAzul botonPedido"> <xsl:value-of select="document($doc)/translation/texts/item[@name='preparar_pedido']/node()"/></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					</td>
					<td>&nbsp;</td>
				</tr>
			</xsl:if>
			</table>

			<table class="plantilla">
			<tfoot>
				<tr>
					<td class="footLeft">&nbsp;</td>
					<td colspan="3">&nbsp;</td>
					<td class="footRight">&nbsp;</td>
				</tr>
			</tfoot>
			</table>
			<br/>

			<!--si no hay tabla carpetas enseño boton abajo-->
			<xsl:choose>
			<xsl:when test="ZonaPlantilla/AREAPLANTILLAS/VERCARPETAS"></xsl:when>
			<xsl:otherwise>
				<!--PREPARAR PEDIDO-->
				<!--<div class="botonGrande">-->
					<a class="btnDestacado" style="margin-left:15px;" href="javascript:PrepararOfertaPedido('DIRECTO');" title="Preparar pedido"> <xsl:copy-of select="document($doc)/translation/texts/item[@name='preparar_pedido']/node()"/></a>
				<!--</div>--><!--fin de botonGrande-->
			</xsl:otherwise>
			</xsl:choose>

		</form>
	</xsl:otherwise>
	</xsl:choose>

	<form name="MensajeJS">
		<input type="hidden" name="SEGURO_BORRAR_PLANTILLA" value="{document($doc)/translation/texts/item[@name='seguro_borrar_plantilla']/node()}"/>
		<input type="hidden" name="MENS_SIN_PLANTILLA" value="{document($doc)/translation/texts/item[@name='mens_sin_plantilla']/node()}"/>
		<input type="hidden" name="NO_AUTORIZADO_BORRAR_PLANTILLA" value="{document($doc)/translation/texts/item[@name='no_autorizado_borrar_plantilla']/node()}"/>
		<input type="hidden" name="NO_CARPETAS_NO_PLANTILLAS" value="{document($doc)/translation/texts/item[@name='no_carpetas_no_plantillas']/node()}"/>
		<input type="hidden" name="NO_AUTORIZADO_CREAR_PLANTILLA" value="{document($doc)/translation/texts/item[@name='no_autorizado_crear_plantilla']/node()}"/>
		<input type="hidden" name="NO_AUTORIZADO_MODIFICAR_PLANTILLA" value="{document($doc)/translation/texts/item[@name='no_autorizado_modificar_plantilla']/node()}"/>
		<input type="hidden" name="NO_AUTORIZADO_MODIFICAR_PLANTILLA" value="{document($doc)/translation/texts/item[@name='no_autorizado_modificar_plantilla']/node()}"/>
		<input type="hidden" name="PRODUCTO_YA_EXISTE" value="{document($doc)/translation/texts/item[@name='producto_ya_existe']/node()}"/>
		<input type="hidden" name="PLANTILLA_SIN_PRODUCTOS" value="{document($doc)/translation/texts/item[@name='plantilla_sin_productos']/node()}"/>
	</form>
</body>
</html>
</xsl:template>

<xsl:template match="PROVEEDOR">
	<table width="100%">
		<tr>
			<td align="left">
				<a class="suave" onmouseover="window.status=' ';return true" onmouseup="window.status=' ';return true" onmousedown="window.status=' ';return true">
					<xsl:attribute name="href">javascript:MostrarPagPersonalizada('../../Administracion/Mantenimiento/Productos/PRODetalle.xsql?PRO_ID=<xsl:value-of select="../ID"/>&amp;SES_ID=<xsl:value-of select="../../../../SES_ID"/>','producto',70,50,0,-50);</xsl:attribute>
					<!--Pedidos:&nbsp;<xsl:value-of select="../PEDIDOSMES"/>-->
				</a>
			</td>
			<td align="right">
				<a style="color:#015E4B">
					<xsl:attribute name="href">javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPDetalleFrame.xsql?EMP_ID=<xsl:value-of select="../IDPROVEEDOR"/>&amp;VENTANA=NUEVA','empresa',65,58,0,-50)</xsl:attribute>
					<xsl:attribute name="onMouseOver">window.status='Información sobre la empresa.';return true;</xsl:attribute>
					<xsl:attribute name="class">suave</xsl:attribute>
					<xsl:attribute name="onMouseOut">window.status='';return true;</xsl:attribute>
					<xsl:value-of select="." disable-output-escaping="yes"/>
				</a>
			</td>
		</tr>
	</table>
</xsl:template>

<xsl:template match="NOMBRE">
	<input type="hidden" name="IDPRODUCTO_{../ID}" value="{../ID}"/>
	<a class="suave" onmouseover="window.status='Ver detalle del producto';return true" onmouseup="window.status=' ';return true" onmousedown="window.status=' ';return true">
		<xsl:attribute name="href">javascript:MostrarPagPersonalizada('../../Administracion/Mantenimiento/Productos/PRODetalle.xsql?PRO_ID=<xsl:value-of select="../ID"/>&amp;SES_ID=<xsl:value-of select="../../../../SES_ID"/>','producto',70,50,0,-50);</xsl:attribute>
		<xsl:value-of select="." disable-output-escaping="yes"/>
	</a>
</xsl:template>
</xsl:stylesheet>
