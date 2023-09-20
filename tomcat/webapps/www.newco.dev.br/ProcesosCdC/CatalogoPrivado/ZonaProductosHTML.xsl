<?xml version="1.0" encoding="iso-8859-1"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:import href = "http://www.newco.dev.br/General/General.xsl"/>
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>

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

	<xsl:text disable-output-escaping="yes"><![CDATA[
	<script language="javascript">
	<!--

	var TAMANYO_FRAME_MAXIMIZADO='100';
	var TIPO_TAMANYO_FRAME_MAXIMIZADO='%';
	var TAMANYO_FRAME_NORMAL=290;
	var TIPO_TAMANYO_FRAME_NORMAL='px';

	var msgSinProductoEstandarParaVerDetalles='No hay ningun producto estándar seleccionado. Seleccione uno o creelo con el boton \"Nuevo\". Gracias.';

	function VerDetallesProductoEstandar(idProductoEstandar,idCategoria, idFamilia, idGrupo ,idSubfamilia ){
//alert('ZonaProducto-1 '+' idSubfamilia '+idSubfamilia);
		if(document.forms[0].elements['CATPRIV_IDPRODUCTOESTANDAR'].value!='' && document.forms[0].elements['CATPRIV_IDPRODUCTOESTANDAR'].value>0){
//alert('ZonaProducto-2');		
			var idEmpresa=document.forms['form1'].elements['CATPRIV_IDEMPRESA'].value;
//alert('ZonaProducto-2-1');
			var objFrame=new Object();
			objFrame=obtenerFrame(top,'zonaCatalogo');

			var productoActual=parseInt(objFrame.obtenerPosicionDesplegableProductoEstandar())+1;
			//----var productoActual=parseInt(parent.frames['zonaCatalogo'].obtenerPosicionDesplegableProductoEstandar())+1;
//alert('ZonaProducto-2-2 productoActual '+productoActual);

			var subfamiliaActual=parseInt(objFrame.obtenerPosicionDesplegableSubfamilia())+1;
			//----var subfamiliaActual=parseInt(parent.frames['zonaCatalogo'].obtenerPosicionDesplegableSubfamilia())+1;
//alert('ZonaProducto-2-3 subfamilia '+subfamiliaActual);

			var grupoActual=parseInt(objFrame.obtenerPosicionDesplegableGrupo())+1;
			//----var grupoActual=parseInt(parent.frames['zonaCatalogo'].obtenerPosicionDesplegableGrupo())+1;
//alert('ZonaProducto-2-4 grupoActual '+grupoActual);

			var familiaActual=parseInt(objFrame.obtenerPosicionDesplegableFamilia())+1;
			//----var familiaActual=parseInt(parent.frames['zonaCatalogo'].obtenerPosicionDesplegableFamilia())+1;
//alert('ZonaProducto-2-5 familiaActual '+familiaActual);

//alert('ZonaProducto-2-3');
			//objFrame.redimensionarFrame('MINIMIZADO');
			//var objFrame=new Object();
			//objFrame=obtenerFrame(top,'Resultados');

			//if(objFrame==null){
				//  var objFrame=new Object();
				//  objFrame=obtenerFrame(top,'areaTrabajo');
				//  objFrame.location.href='Buscador.htm';
			//}

			var objFrame=new Object();
			objFrame=obtenerFrame(top,'areaTrabajo');

//alert('ZonaProducto-3');
			if(!objFrame.location.href.match('BuscadorFrame.xsql')){
			//----if(!parent.areaTrabajo.location.href.match('BuscadorFrame.xsql')){
//alert('ZonaProducto-4');
				objFrame.location.href='BuscadorFrame.xsql?PAGINARESULTADOS=DetalleProductoEstandar.xsql%3FIDNUEVOPRODUCTOESTANDAR='+idProductoEstandar+'%26IDNUEVASUBFAMILIA='+idSubfamilia+'%26IDEMPRESA='+idEmpresa+'%26PRODUCTOACTUAL='+productoActual+'%26SUBFAMILIAACTUAL='+subfamiliaActual+'%26IDNUEVAFAMILIA='+idFamilia;
				//----parent.areaTrabajo.location.href='BuscadorFrame.xsql?PAGINARESULTADOS=DetalleProductoEstandar.xsql%3FIDNUEVOPRODUCTOESTANDAR='+idProductoEstandar+'%26IDNUEVASUBFAMILIA='+idSubfamilia+'%26IDEMPRESA='+idEmpresa+'%26PRODUCTOACTUAL='+productoActual+'%26SUBFAMILIAACTUAL='+subfamiliaActual+'%26IDNUEVAFAMILIA='+idFamilia;
			}else{
//alert('ZonaProducto-5');
				//----var objFrame=new Object();
				//----objFrame=obtenerFrame(top,'Resultados');
				//----objFrame.location.href='MantProductosEstandar.xsql?IDNUEVOPRODUCTOESTANDAR='+idProductoEstandar+'&IDNUEVASUBFAMILIA='+idSubfamilia+'&IDEMPRESA='+idEmpresa+'&PRODUCTOACTUAL='+productoActual+'&GRUPOACTUAL='+grupoActual+'&SUBFAMILIAACTUAL='+subfamiliaActual+'&FAMILIAACTUAL='+familiaActual+'&IDNUEVAFAMILIA='+idFamilia+'&IDNUEVACATEGORIA='+idCategoria+'&IDNUEVOGRUPO='+idGrupo;

				parent.areaTrabajo.Resultados.location.href='MantProductosEstandar.xsql?IDNUEVOPRODUCTOESTANDAR='+idProductoEstandar+'&IDNUEVASUBFAMILIA='+idSubfamilia+'&IDEMPRESA='+idEmpresa+'&PRODUCTOACTUAL='+productoActual+'&GRUPOACTUAL='+grupoActual+'&SUBFAMILIAACTUAL='+subfamiliaActual+'&FAMILIAACTUAL='+familiaActual+'&IDNUEVAFAMILIA='+idFamilia+'&IDNUEVACATEGORIA='+idCategoria+'&IDNUEVOGRUPO='+idGrupo;

				//----parent.areaTrabajo.location.href='DetalleProductoEstandar.xsql?IDNUEVOPRODUCTOESTANDAR='+idProductoEstandar+'&IDNUEVASUBFAMILIA='+idSubfamilia+'&IDEMPRESA='+idEmpresa+'&PRODUCTOACTUAL='+productoActual+'&GRUPOACTUAL='+grupoActual+'&SUBFAMILIAACTUAL='+subfamiliaActual+'&FAMILIAACTUAL='+familiaActual+'&IDNUEVAFAMILIA='+idFamilia+'&IDNUEVACATEGORIA='+idCategoria+'&IDNUEVOGRUPO='+idGrupo;
//alert('ZonaProducto-6');				
			}
		}else{
			alert(msgSinProductoEstandarParaVerDetalles);
		}
	}

	function recargarPagina(){
		document.location.href='ZonaProductos.xsql?IDPRODUCTOESTANDAR='+document.forms[0].elements['CATPRIV_IDPRODUCTOESTANDAR'].value+'&IDSUBFAMILIA='+document.forms[0].elements['CATPRIV_IDSUBFAMILIA'].value+'&TIPOVENTANA='+document.forms[0].elements['TIPOVENTANA'].value+'&IDFAMILIA='+document.forms[0].elements['CATPRIV_IDFAMILIA'].value;
	}

	function recargarDesplegable(form,nombreDesplegable,arrayValores,posInicial,posFinal){
		form.elements[nombreDesplegable].length=0;
		var indiceSeleccionado;

		for(var n=0;n<arrayValores.length;n++){
			var id=arrayValores[n][0];
			var defecto=arrayValores[n][2];
			var texto=arrayValores[n][1];
			texto=texto.substring(posInicial,posFinal);

			if(id==defecto){
				texto='['+texto+']';
				indiceSeleccionado=n;
			}

			var opcion=new Option(texto,id);
			form.elements[nombreDesplegable].options[form.elements[nombreDesplegable].length]=opcion;
			if(id==defecto){
				form.elements[nombreDesplegable].selectedIndex=indiceSeleccionado;
			}
		}
	}
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
		<input type="hidden" name="CATPRIV_IDCATEGORIA" value="{ZonaCatalogo/IDCATEGORIA}"/>
		<input type="hidden" name="CATPRIV_IDFAMILIA" value="{ZonaCatalogo/IDFAMILIA}"/>
		<input type="hidden" name="CATPRIV_IDSUBFAMILIA" value="{ZonaCatalogo/IDSUBFAMILIA}"/>
		<input type="hidden" name="CATPRIV_IDGRUPO" value="{ZonaCatalogo/IDGRUPO}"/>
		<input type="hidden" name="CATPRIV_IDPRODUCTOESTANDAR" value="{ZonaCatalogo/IDPRODUCTOESTANDAR}"/>

        <!--<table class="plantilla incidencias" id="table_padre" cellspacing="5" style="border-collapse:separate;border:none;font-weight:bold;">-->
        <table class="areaizq" id="table_padre">
			<tr>
				<th colspan="2"><xsl:value-of select="document($doc)/translation/texts/item[@name='descripcion']/node()"/></th>
			</tr>

		<xsl:if test="ZonaCatalogo/AREACATALOGOS/PRODUCTOESTANDAR/NOMBRE != ''">
			<tr height="5px"><td colspan="4"></td></tr>
			<tr height="20px;">
				<td colspan="2" align="center"><xsl:value-of select="ZonaCatalogo/AREACATALOGOS/PRODUCTOESTANDAR/NOMBRE"/></td>
			</tr>
		</xsl:if>

		<tr height="5px"><td colspan="4"></td></tr>

		<xsl:if test="ZonaCatalogo/AREACATALOGOS/DATOSUSUARIO/MVM or ZonaCatalogo/AREACATALOGOS/DATOSUSUARIO/CDC">
			<tr height="20px;">
				<td>CP_PRO_ID&nbsp;:&nbsp;</td>
				<td><xsl:value-of select="ZonaCatalogo/AREACATALOGOS/PRODUCTOESTANDAR/ID"/></td>
			</tr>
		</xsl:if>

		<xsl:if test="ZonaCatalogo/AREACATALOGOS/PRODUCTOESTANDAR/REFCLIENTE != ''">
			<tr height="20px;">
				<td><xsl:value-of select="document($doc)/translation/texts/item[@name='RefCliente']/node()"/>&nbsp;:&nbsp;</td>
				<td><xsl:value-of select="ZonaCatalogo/AREACATALOGOS/PRODUCTOESTANDAR/REFCLIENTE"/></td>
			</tr>
		</xsl:if>

		<xsl:if test="ZonaCatalogo/AREACATALOGOS/PRODUCTOESTANDAR/REFERENCIA != ''">
			<tr height="20px;">
				<td><xsl:value-of select="document($doc)/translation/texts/item[@name='RefEstandar']/node()"/>&nbsp;:&nbsp;</td>
				<td><xsl:value-of select="ZonaCatalogo/AREACATALOGOS/PRODUCTOESTANDAR/REFERENCIA"/></td>
			</tr>
		</xsl:if>

		<xsl:if test="ZonaCatalogo/AREACATALOGOS/PRODUCTOESTANDAR/FECHAALTA != ''">
			<tr height="20px;">
				<td> <xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_alta']/node()"/>:&nbsp;</td>
				<td><xsl:value-of select="ZonaCatalogo/AREACATALOGOS/PRODUCTOESTANDAR/FECHAALTA"/></td>
			</tr>
		</xsl:if>

		<xsl:if test="ZonaCatalogo/AREACATALOGOS/PRODUCTOESTANDAR/PRECIOREFERENCIA != ''">
			<tr height="20px;">
				<td><xsl:value-of select="document($doc)/translation/texts/item[@name='precio_ref']/node()"/>:&nbsp;</td>
				<td><xsl:value-of select="ZonaCatalogo/AREACATALOGOS/PRODUCTOESTANDAR/PRECIOREFERENCIA"/></td>
			</tr>
		</xsl:if>
		<!--
			<tr height="5px"><td colspan="2"></td></tr>
			<tr>
			<xsl:choose>
			<xsl:when test="ZonaCatalogo/AREACATALOGOS/PRODUCTOESTANDAR/NOMBRE != ''">
				<td colspan="2" style="text-align:center;">
				<xsl:if test="ZonaCatalogo/AREACATALOGOS/DATOSUSUARIO/EDICION">
					<!- -<div class="boton" style="margin-left:15px;">- ->
						<a class="btnNormal" href="javascript:VerDetallesProductoEstandar(document.forms[0].elements['CATPRIV_IDPRODUCTOESTANDAR'].value,document.forms[0].elements['CATPRIV_IDCATEGORIA'].value,document.forms[0].elements['CATPRIV_IDFAMILIA'].value,document.forms[0].elements['CATPRIV_IDGRUPO'].value,document.forms[0].elements['CATPRIV_IDSUBFAMILIA'].value,'VERMASDETALLES');">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='ver_mas_detalles']/node()"/>
						</a>
						<!- -<xsl:call-template name="botonNostyle">
							<xsl:with-param name="path" select="ZonaCatalogo/botones/button[@label='VerMasDetalles']"/>
						</xsl:call-template>- ->
					<!- -</div>- ->
				</xsl:if>
				</td>
			</xsl:when>
			<xsl:otherwise>
				<td colspan="2" align="center"><xsl:value-of select="document($doc)/translation/texts/item[@name='no_hay_productos']/node()"/></td>
			</xsl:otherwise>
			</xsl:choose>
			</tr>
		-->
		</table>

		<!--proveedores-->
		<br/>
		<br/>
        <table class="areaizq">
		<!--<table class="plantilla incidencias" cellspacing="5" style="border-collapse:separate;border:none;font-weight:bold;">-->
        	<tr>
				<th colspan="2"><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/></th>
			</tr>
			<xsl:choose>
			<xsl:when test="/ZonaCatalogo/AREACATALOGOS/PROVEEDORES/PROVEEDOR">
				<xsl:for-each select="/ZonaCatalogo/AREACATALOGOS/PROVEEDORES/PROVEEDOR">

					<tr height="20px;">
                        <td align="right" class="trenta grisMed">
                            <xsl:value-of select="document($doc)/translation/texts/item[@name='PROV']/node()"/>&nbsp;:&nbsp;
                        </td>
                        <td>
							<xsl:choose>
							<xsl:when test="IDPROVEEDOR=''">
								<xsl:value-of select="NOMBREPROVEEDOR"/>
							</xsl:when>
							<xsl:otherwise>
								<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPDetalleFrame.xsql?EMP_ID={IDPROVEEDOR}&amp;VENTANA=NUEVA','empresa',100,58,0,-50)" class="suave">
									<xsl:value-of select="NOMBREPROVEEDOR"/>
								</a>
								<input type="hidden" name="PRODUCTO_{REFERENCIA}" value="{REFERENCIA}"/>
							</xsl:otherwise>
							</xsl:choose>
                       </td>
					</tr>

				<xsl:if test="/ZonaCatalogo/AREACATALOGOS/DATOSUSUARIO/MVM or /ZonaCatalogo/AREACATALOGOS/DATOSUSUARIO/CDC">
					<tr height="20px;">
						<td align="right" class="grisMed">PRO_ID&nbsp;:&nbsp;</td>
						<td><xsl:value-of select="IDPRODUCTO"/></td>
					</tr>
				</xsl:if>

					<tr height="20px;">
						<td align="right" class="grisMed">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='REF']/node()"/>&nbsp;:&nbsp;
                        </td>
						<td>
							<xsl:choose>
							<xsl:when test="IDPRODUCTO=''">
								<xsl:value-of select="REFERENCIA"/>
							</xsl:when>
							<xsl:otherwise>
								<a class="suave" href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Productos/PRODetalle.xsql?PRO_ID={IDPRODUCTO}&amp;SES_ID={//ZonaCatalogo/SES_ID}','producto',100,50,0,-50);">
									<xsl:value-of select="REFERENCIA"/>
								</a>
							</xsl:otherwise>
							</xsl:choose>
						</td>
					</tr>
					<xsl:if test="PRECIOUDBASICA!=''">
                                            <tr height="20px;">
						<td align="right" class="grisMed">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='PRECIO']/node()"/>&nbsp;:&nbsp;
						</td>
						<td>
							<xsl:value-of select="PRECIOUDBASICA"/>
						</td>
                                            </tr>
					</xsl:if>
					

<!-- DC - 12/03/14 - Cambiamos estilo y mostramos como en el caso de productos (por filas)
					<tr>
						<td>&nbsp;</td>
						<td>
							<img src="http://www.newco.dev.br/images/listAzul.gif" alt="lista"/>
							<xsl:choose>
							<xsl:when test="IDPROVEEDOR=''">
								<xsl:value-of select="NOMBREPROVEEDOR"/>
							</xsl:when>
							<xsl:otherwise>
								<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPDetalleFrame.xsql?EMP_ID={IDPROVEEDOR}&amp;VENTANA=NUEVA','empresa',100,58,0,-50)" class="suave">
									<xsl:value-of select="NOMBREPROVEEDOR"/>
								</a>
								<input type="hidden" name="PRODUCTO_{REFERENCIA}" value="{REFERENCIA}"/>
							</xsl:otherwise>
							</xsl:choose>
						</td>
						<td align="right">
							<xsl:choose>
							<xsl:when test="IDPRODUCTO=''">
								<strong><xsl:value-of select="document($doc)/translation/texts/item[@name='ref']/node()"/>:</strong>&nbsp;
								<xsl:value-of select="REFERENCIA"/>
							</xsl:when>
							<xsl:otherwise>
								<strong><xsl:value-of select="document($doc)/translation/texts/item[@name='ref']/node()"/>:</strong>&nbsp;
								<a class="suave" href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Productos/PRODetalle.xsql?PRO_ID={IDPRODUCTO}&amp;SES_ID={//ZonaCatalogo/SES_ID}','producto',100,50,0,-50);">
									<xsl:value-of select="REFERENCIA"/>
								</a>
							</xsl:otherwise>
							</xsl:choose>
						</td>
						<td align="right">
							<xsl:if test="PRECIOUDBASICA!=''">
								&nbsp;&nbsp;<xsl:value-of select="PRECIOUDBASICA"/>&nbsp;&nbsp;
							</xsl:if>
						</td>
						<td>&nbsp;</td>
					</tr>
-->
					<!--<tr height="5px"><td colspan="2"></td></tr>-->
				</xsl:for-each>
			</xsl:when>
			<xsl:otherwise>
				<tr>
                                    <td colspan="2" align="center"><xsl:value-of select="document($doc)/translation/texts/item[@name='no_hay_proveedores']/node()"/></td>
				</tr>
			</xsl:otherwise>
			</xsl:choose>
		</table><!--fin de tabla proveedores-->


<xsl:if test="/ZonaCatalogo/AREACATALOGOS/PRODUCTOESTANDAR/IDLICITACION != ''">
		<!--licitacion-->
                <table class="plantilla incidencias" cellspacing="5" style="border-collapse:separate;border:none;font-weight:bold;">
			<tr>
				<th colspan="2"><xsl:value-of select="document($doc)/translation/texts/item[@name='licitacion']/node()"/></th>
			</tr>

                        <xsl:if test="ZonaCatalogo/AREACATALOGOS/DATOSUSUARIO/MVM or ZonaCatalogo/AREACATALOGOS/DATOSUSUARIO/CDC">
			<tr height="20px;">
				<td align="right" class="trenta grisMed">IDLIC&nbsp;:&nbsp;</td>
				<td><xsl:value-of select="/ZonaCatalogo/AREACATALOGOS/PRODUCTOESTANDAR/IDLICITACION"/></td>
			</tr>
                        </xsl:if>

			<tr height="20px;">
				<td align="right" class="grisMed"><xsl:value-of select="document($doc)/translation/texts/item[@name='nombre']/node()"/>&nbsp;:&nbsp;</td>
				<td><xsl:value-of select="/ZonaCatalogo/AREACATALOGOS/PRODUCTOESTANDAR/LICITACION"/></td>
			</tr>

			<tr height="5px"><td colspan="4"></td></tr>
                </table><!--fin de tabla licitacion-->
</xsl:if>
    <!-- <table class="plantilla">
          <tr>
          	 <th>&nbsp;</th>
             <th colspan="2">Centros</th>
             <th>&nbsp;</th>
          </tr>
          <tr height="5px"><td colspan="4"></td></tr>
                <xsl:choose>
                  <xsl:when test="/ZonaCatalogo/AREACATALOGOS/CENTROS/CENTRO">
                    <xsl:for-each select="/ZonaCatalogo/AREACATALOGOS/CENTROS/CENTRO">
                     
                            <tr>
                              <td>&nbsp;</td>
                              <td>
                               <img src="http://www.newco.dev.br/images/listAzul.gif" alt="lista"/>
                                <a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/CENDetalle.xsql?ID={IDCENTRO}','DetalleCentro',100,45,0,-50);">
                                  <xsl:value-of select="NOMBRECENTRO"/>
                                </a>
                                <input type="hidden" name="PRODUCTO_{REFERENCIA}" value="{REFERENCIA}"/>
                              </td>
                              <td align="right">
                                <xsl:choose>
                                  <xsl:when test="IDPROVEEDOR=''">
                                    <xsl:value-of select="NOMBREPROVEEDOR"/>
                                  </xsl:when>
                                  <xsl:otherwise>  
                                    <a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPDetalleFrame.xsql?EMP_ID={IDPROVEEDOR}&amp;VENTANA=NUEVA','empresa',100,58,0,-50)" class="suave">
                                      <xsl:value-of select="NOMBREPROVEEDOR"/>
                                    </a>
                                  </xsl:otherwise>
                                </xsl:choose>
                              </td>
                              <td>&nbsp;</td>
                            </tr>
                            <tr height="5px"><td colspan="5"></td></tr>
                            <tr>
                             <td>&nbsp;</td>
                              <td>
                                <xsl:value-of select="PRECIO"/>
                              </td>
                              <td align="right">
                                <xsl:choose>
                                  <xsl:when test="IDPRODUCTO=''">
                                      <b>ref:</b>&nbsp;
                                      <xsl:value-of select="REFERENCIA"/>
                                  </xsl:when>
                                  <xsl:otherwise>  
                                      <b>ref:</b>&nbsp;
                                      <a class="suave" href="javascript:MostrarPag('http://www.newco.dev.br/Administracion/Mantenimiento/Productos/PRODetalle.xsql?PRO_ID={IDPRODUCTO}&amp;SES_ID={//ZonaCatalogo/SES_ID}');">
                                        <xsl:value-of select="REFERENCIA"/>
                                      </a>
                                  </xsl:otherwise>
                                </xsl:choose>
                        </td>
                        <td>&nbsp;</td>
                      </tr>
                      <tr height="5px"><td colspan="5"></td></tr>
                    </xsl:for-each>
                  </xsl:when>
                  <xsl:otherwise>
                      <tr>
                        <td>&nbsp;</td>
                        <td colspan="2">
                          No hay Centros
                        </td>
                        <td>&nbsp;</td>
                      </tr>
                  </xsl:otherwise>
                </xsl:choose>
     <tfoot>
      <tr>
         <td class="foot">&nbsp;</td>
         <td colspan="2">&nbsp;</td>
         <td class="foot">&nbsp;</td>
      </tr>
   </tfoot>
   </table>--><!-- fin de centros-->
   
	</form>
</xsl:otherwise>
</xsl:choose>
</body>
</html>
</xsl:template>
</xsl:stylesheet>
