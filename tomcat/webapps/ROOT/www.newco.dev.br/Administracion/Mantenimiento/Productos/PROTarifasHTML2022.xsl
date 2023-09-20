<?xml version="1.0" encoding="iso-8859-1"?>
<!--
	Mant.producto
 	Ultima revision: ET 28jun23 10:45 PROTarifas2022_280623.js
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
	<xsl:variable name="lang">
		<xsl:choose>
		<xsl:when test="/MantenimientoProductos/LANG"><xsl:value-of select="/MantenimientoProductos/LANG"/></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<title>
	<xsl:choose>
	<xsl:when test="/MantenimientoProductos/Form/PRODUCTO/PRO_ID!=''">
		<xsl:value-of select="/MantenimientoProductos/Form/PRODUCTO/REFERENCIA_PROVEEDOR"/>:&nbsp;
        <xsl:value-of select="substring(MantenimientoProductos/Form/PRODUCTO/PRO_NOMBRE,0,50)"/>
	</xsl:when>
	<xsl:otherwise>
		<xsl:value-of select="document($doc)/translation/texts/item[@name='alta']/node()"/>&nbsp;
		<xsl:value-of select="document($doc)/translation/texts/item[@name='de']/node()"/>&nbsp;
		<xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/>
	</xsl:otherwise>
	</xsl:choose>
	</title>

	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->

	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery-3.6.0.js"></script>	
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic2022_010822.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/Administracion/Mantenimiento/Productos/PROTarifas2022_280623.js"></script>

	<script type="text/javascript">
		var tipoIVA = 0;
		
		var EsAdmin='<xsl:choose><xsl:when test="/MantenimientoProductos/Form/PRODUCTO/ADMIN">S</xsl:when><xsl:otherwise>N</xsl:otherwise></xsl:choose>';
		
		var arrTarifas=new Array();

		<xsl:for-each select="/MantenimientoProductos/Form/PRODUCTO/DATOS_CLIENTE/TARIFA">
			var tar		= [];
			tar['IDCliente']='<xsl:value-of select="../IDCLIENTE"/>';
			tar['Cliente']='<xsl:value-of select="../CLIENTE"/>';
			tar['PorAreaGeo']='<xsl:value-of select="../TARIFAS_POR_AREAGEO"/>';
			tar['Importe']='<xsl:value-of select="TRF_IMPORTE"/>';
			tar['FechaInicio']='<xsl:value-of select="TRF_FECHAINICIO"/>';
			tar['FechaLimite']='<xsl:value-of select="TRF_FECHALIMITE"/>';
			tar['IDDocumento']='<xsl:value-of select="DOCUMENTO/ID"/>';
			tar['NombreDoc']='<xsl:value-of select="TRF_NOMBREDOCUMENTO"/>';
			tar['IDTipoNeg']='<xsl:value-of select="TRF_IDTIPONEGOCIACION"/>';
			tar['BonifCompra']='<xsl:value-of select="TRF_BONIF_CANTIDADDECOMPRA"/>';
			tar['BonifGratis']='<xsl:value-of select="TRF_BONIF_CANTIDADGRATUITA"/>';
			tar['IDSelGeo']='<xsl:value-of select="TRF_IDSELECCIONGEO"/>';
			tar['IDDivisa']='<xsl:value-of select="DIVISA/ID"/>';
			tar['PrecioFabrica']='<xsl:value-of select="TRF_PRECIOFABRICA"/>';
			tar['Descuento']='<xsl:value-of select="TRF_DESCUENTO"/>';
 			
			var DespTipoNeg= new Array();
			<xsl:for-each select="IDTIPONEGOCIACION/field/dropDownList/listElem">
				var tn=[];
				tn['ID']='<xsl:value-of select="ID"/>';
				tn['Nombre']='<xsl:value-of select="listItem"/>';
				DespTipoNeg.push(tn);
			</xsl:for-each>
			
			tar['DespTipoNeg']=DespTipoNeg;
			arrTarifas.push(tar);
		</xsl:for-each>
		
		
		//	Cadenas
		var precio_cIVA_mal_formado = '<xsl:value-of select="document($doc)/translation/texts/item[@name='precio_cIVA_no_numerico']/node()"/>';
		var strClienteObligatorio = '<xsl:value-of select="document($doc)/translation/texts/item[@name='seleccionar_cliente_obligatorio']/node()"/>';
		var strErrorEnTarifa = '<xsl:value-of select="document($doc)/translation/texts/item[@name='error_precio_stck_dem']/node()"/>';
		var strErrorEnFechaInicio = '<xsl:value-of select="document($doc)/translation/texts/item[@name='error_fecha_inicio']/node()"/>';
		var strErrorEnFechaFin = '<xsl:value-of select="document($doc)/translation/texts/item[@name='error_fecha_fin']/node()"/>';
		var strNumeroIncorrecto = '<xsl:value-of select="document($doc)/translation/texts/item[@name='el_numero_no_es_correcto']/node()"/>';
		var msgBorrarTarifa = '<xsl:value-of select="document($doc)/translation/texts/item[@name='seguro_de_borrar_tarifa']/node()"/>';
		var strErrorPrecioFabrica = '<xsl:value-of select="document($doc)/translation/texts/item[@name='Error_precio_fabrica']/node()"/>';
		var strErrorDescuento = '<xsl:value-of select="document($doc)/translation/texts/item[@name='Error_descuento']/node()"/>';
		var strErrorPrecioNoCuadra = '<xsl:value-of select="document($doc)/translation/texts/item[@name='Error_precio_no_cuadra']/node()"/>';
	</script>
</head>

<body>
	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:value-of select="/MantenimientoProductos/LANG"/>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->


	<!--	Titulo de la página		-->
	<xsl:variable name="tituloCompleto">
		<xsl:choose>
		<xsl:when test="/MantenimientoProductos/Form/PRODUCTO/PRO_ID!=''">
        	<xsl:value-of select="MantenimientoProductos/Form/PRODUCTO/PROVEEDOR"/>:&nbsp;
        	<xsl:value-of select="/MantenimientoProductos/Form/PRODUCTO/REFERENCIA_PROVEEDOR"/>&nbsp;
        	<xsl:value-of select="substring(MantenimientoProductos/Form/PRODUCTO/PRO_NOMBRE,0,50)"/>
		</xsl:when>
		<xsl:otherwise>
        	<xsl:if test="not(//ADMIN_MVM) and not(//ADMIN_MVMB)and not(//ADMIN)">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='solicitud_de']/node()"/>&nbsp;
			</xsl:if>
        	<xsl:value-of select="document($doc)/translation/texts/item[@name='alta']/node()"/>&nbsp;
        	<xsl:value-of select="document($doc)/translation/texts/item[@name='de']/node()"/>&nbsp;
        	<xsl:value-of select="document($doc)/translation/texts/item[@name='productos']/node()"/>
		</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>

	<div class="ZonaTituloPagina">
		<p class="TituloPagina">
			<xsl:value-of select="substring($tituloCompleto,0,100)"/>&nbsp;
			<xsl:if test="(/MantenimientoProductos/Form/PRODUCTO/ROL='VENDEDOR' and /MantenimientoProductos/Form/PRODUCTO/PRO_STATUS='M')">
				<span class="urgente"><xsl:value-of select="document($doc)/translation/texts/item[@name='solicitud_cambio_producto']/node()"/></span>&nbsp;
			</xsl:if>
			<span class="fuentePeq">(<xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_modificacion']/node()"/>:&nbsp;<xsl:value-of select="/MantenimientoProductos/Form/PRODUCTO/FECHACAMBIO"/>)</span>
			<span class="CompletarTitulo">
				<!--	Botones	-->
			</span>
		</p>
	</div>
	<br/>

	<!--	Pestañas y Titulo de la página, únicamente si el producto ya existe. Si no, hay quie crearlo antes de poder incluir documentos		-->
	<xsl:if test="/MantenimientoProductos/Form/PRODUCTO/PRO_ID!=''">
 	<div class="divLeft marginTop20">
		<ul class="pestannas w100" style="position:relative;">
			<li>
				<a id="pes_Ficha" class="MenuLic"><xsl:value-of select="document($doc)/translation/texts/item[@name='Ficha_de_producto']/node()"/></a>
			</li>
			<li>
				<a id="pes_Tarifas" class="MenuLic"><xsl:value-of select="document($doc)/translation/texts/item[@name='tarifas']/node()"/></a>
			</li>
			<li>
				<a id="pes_Documentos" class="MenuLic"><xsl:value-of select="document($doc)/translation/texts/item[@name='documentos']/node()"/></a>
			</li>
			<li>
				<a id="pes_Pack" class="MenuLic"><xsl:value-of select="document($doc)/translation/texts/item[@name='Contenido_pack']/node()"/></a>
			</li>
			<li>
				<a id="pes_Empaquetamiento" class="MenuLic"><xsl:value-of select="document($doc)/translation/texts/item[@name='empaquetamientos']/node()"/></a>
			</li>
		</ul>
	</div>
	</xsl:if>


	<div class="divLeft">
		<xsl:apply-templates select="MantenimientoProductos/Form"/>
	</div>
</body>
</html>
</xsl:template>

<xsl:template match="MantenimientoProductos/Form">
	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:value-of select="../LANG"/>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<div class="divLeft marginTop20">
	<form name="frmTarifas" id="frmTarifas" method="post" action="http://www.newco.dev.br/Administracion/Mantenimiento/Productos/PROTarifas2022.xsql">

		<div class="divLeft">
		<table cellspacing="6px" cellpadding="6px">
			<tr>
			<xsl:choose>
			<!--22ene18	xsl:when test="(//ADMIN_MVM or //ADMIN_MVMB or //ADMIN)">-->
			<xsl:when test="/MantenimientoProductos/Form/PRODUCTO/ROL='COMPRADOR'">
				<td colspan="2" class="labelRight grisMed">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/>:<span class="camposObligatorios">*</span>&nbsp;
				</td>
				<td class="datosLeft" colspan="5">
				<xsl:choose>
				<xsl:when test="PRODUCTO/PRO_ID">
					<strong>
						<a>
							<xsl:attribute name="href">javascript:FichaEmpresa(<xsl:value-of select="PRODUCTO/IDPROVEEDOR"/>);</xsl:attribute>
							<xsl:value-of select="PRODUCTO/PROVEEDOR"/>
						</a>
					</strong>
					<input type="hidden" name="IDPROVEEDOR" value="{PRODUCTO/IDPROVEEDOR}"/>
					<!--input para ver si es nuevo prod o no, para comprobar-->
					<input type="hidden" name="CHANGE_PROV" value="N"/>
				</xsl:when>
				<xsl:otherwise>
					<select name="IDPROVEEDOR" id="IDPROVEEDOR" class="w300px">
						<option value="-1"><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/></option>
						<xsl:for-each select="PRODUCTO/PROVEEDORES/field/dropDownList/listElem">
							<xsl:if test="ID != '' ">
								<option value="{ID}"><xsl:value-of select="listItem"/></option>
							</xsl:if>
						</xsl:for-each>
					</select>
					<!--input para ver si es nuevo prod o no, para comprobar, si es S no ense?o los comprobar hasta que no subo un doc-->
					<input type="hidden" name="CHANGE_PROV" value="S"/>
				</xsl:otherwise>
				</xsl:choose>
				</td>
			</xsl:when>
			<xsl:otherwise>
				<!--input para ver si es nuevo prod o no, para comprobar, si es S no ense?o los comprobar hasta que no subo un doc-->
				<xsl:choose>
				<xsl:when test="PRODUCTO/PRO_ID">
					<input type="hidden" name="CHANGE_PROV" value="N"/>
				</xsl:when>
				<xsl:otherwise>
					<input type="hidden" name="CHANGE_PROV" value="S"/>
				</xsl:otherwise>
				</xsl:choose>
				<!--fin de input para ver si es nuevo prod o no, para comprobar, si es S no ense?o los comprobar hasta que no subo un doc-->
				<input type="hidden" name="IDPROVEEDOR" value="{PRODUCTO/USUARIO/EMP_ID}"/>

				<td colspan="2">&nbsp;</td>
				<td colspan="3">
					<xsl:if test="PRODUCTO/PRO_STATUS = 'S' or PRODUCTO/PRO_STATUS = 'D'">
						<table class="infoTableAma">
							<tr>
								<td>
									<xsl:value-of select="document($doc)/translation/texts/item[@name='solicitud_rechazada_por_mvm']/node()"/>
									<xsl:if test="PRODUCTO/COMENTARIO != ''">
										:<xsl:value-of select="PRODUCTO/COMENTARIO"/>
									</xsl:if>
								</td>
							</tr>
						</table>
					</xsl:if>
				</td>
				<td colspan="2">&nbsp;</td>
			</xsl:otherwise>
			</xsl:choose>
			</tr>
			<xsl:if test="/MantenimientoProductos/Form/PRODUCTO/PACKS">
            	<tr>
                	<td>&nbsp;</td>
                	<td class="labelRight grisMed">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='Incl_pack']/node()"/>:&nbsp;&nbsp;&nbsp;
					</td>
					<td class="datosLeft">
						<xsl:for-each select="/MantenimientoProductos/Form/PRODUCTO/PACKS/PACK">
							<a href="javascript:MantenProducto({PRO_ID});"><xsl:value-of select="PRO_REFERENCIA"/>. <xsl:value-of select="PRO_NOMBRE"/></a><br/>
						</xsl:for-each>
					</td>
                	<td colspan="4">&nbsp;</td>
            	</tr>
			</xsl:if>
			<tr>
				<td class="w300px textCenter" rowspan="3">
				<xsl:choose>
				<xsl:when test="(/MantenimientoProductos/Form/PRODUCTO/ADMIN_MVM or /MantenimientoProductos/Form/PRODUCTO/ADMIN) and /MantenimientoProductos/Form/PRODUCTO/TIPO=''"></xsl:when>
				<xsl:when test="//TIPO=''">
					<img src="{/MantenimientoProductos/Form/PRODUCTO/USUARIO/URL_LOGOTIPO}" height="80px" width="160px"/>
				</xsl:when>
				<xsl:otherwise>
					<img src="{/MantenimientoProductos/Form/PRODUCTO/URL_LOGOTIPO}" height="80px" width="160px"/>
				</xsl:otherwise>
				</xsl:choose>
				</td>
				<td class="dies labelRight grisMed">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='referencia']/node()"/>:&nbsp;
				</td>
				<td class="datosLeft" colspan="2">
					<xsl:value-of select="PRODUCTO/REFERENCIA_PROVEEDOR"/>&nbsp;
				</td>
				<td colspan="3">&nbsp;</td>
			</tr>

			<tr>
				<td class="labelRight grisMed"><xsl:value-of select="document($doc)/translation/texts/item[@name='cod_mvm']/node()"/>:&nbsp;</td>
				<td class="datosLeft" colspan="6">
					<xsl:value-of select="PRODUCTO/REFERENCIA_ESTANDAR"/>&nbsp;
				</td>
			</tr>

			<tr>
				<td class="labelRight grisMed">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='nombre']/node()"/>:&nbsp;
				</td>
				<td class="datosLeft" colspan="3">
					<xsl:value-of select="PRODUCTO/PRO_NOMBRE"/>
				</td>
				<td class="datosLeft" colspan="2">&nbsp;</td>
			</tr>

			<tr>
				<td colspan="2" class="labelRight grisMed"><xsl:value-of select="document($doc)/translation/texts/item[@name='marca']/node()"/>:&nbsp;</td>
				<td colspan="5" class="datosLeft">
					<xsl:value-of select="PRODUCTO/PRO_MARCA"/>
				</td>
			</tr>

		<!--si es mvm ense?o unidad basica si no a 1-->
		<xsl:if test="(PRODUCTO/ADMIN_MVM or PRODUCTO/ADMIN or PRODUCTO/CDC)">
			<tr>
				<td colspan="2" class="labelRight grisMed">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='unidad_basica']/node()"/>:<span class="camposObligatorios">*</span>&nbsp;
				</td>
				<td colspan="5" class="datosLeft">
					<xsl:value-of select="PRODUCTO/PRO_UNIDADBASICA"/>
					<xsl:if test="(PRODUCTO/ADMIN_MVM or PRODUCTO/ADMIN or PRODUCTO/CDC) and /MantenimientoProductos/TIPO='M' "><!--empaquetamientos solo en man prod-->
						&nbsp;<a href="javascript:MostrarPag('http://www.newco.dev.br/Administracion/Mantenimiento/Productos/Empaquetamientos.xsql?PRO_ID={PRODUCTO/PRO_ID}','Empaquetamiento')" class="botonLink">
						<xsl:choose>
						<xsl:when test="PRODUCTO/EMPAQUETAMIENTO_PRIVADO">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='hay_empaquetamientos_privados']/node()"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="document($doc)/translation/texts/item[@name='empaquetamientos']/node()"/>
						</xsl:otherwise>
						</xsl:choose>
						</a>
					</xsl:if>
				</td>
			</tr>
		</xsl:if>
		</table>
	<br/>
	<br/>
	<div class="tabela tabela_redonda">
	<table cellspacing="6px" cellpadding="6px">
		<thead class="cabecalho_tabela">
		<tr>
			<th class="w1x"></th>
			<th class="textLeft">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='cliente']/node()"/></th>
			<xsl:choose>
			<xsl:when test="/MantenimientoProductos/Form/PRODUCTO/MOSTRAR_PRECIO_FABRICA">
				<th><xsl:value-of select="document($doc)/translation/texts/item[@name='Precio_fabrica']/node()"/></th>
				<th><xsl:value-of select="document($doc)/translation/texts/item[@name='Descuento']/node()"/></th>
				<th><xsl:value-of select="document($doc)/translation/texts/item[@name='Precio_final']/node()"/></th>
			</xsl:when>
			<xsl:otherwise>
				<th><xsl:value-of select="document($doc)/translation/texts/item[@name='Tarifa']/node()"/></th>
			</xsl:otherwise>
			</xsl:choose>
			<xsl:if test="/MantenimientoProductos/Form/PRODUCTO/EMP_MULTIDIVISAS='S'">
				<th><xsl:value-of select="document($doc)/translation/texts/item[@name='divisa']/node()"/></th>
			</xsl:if>
			<th class="textLeft">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Cobertura_geografica']/node()"/></th>
			<th><xsl:value-of select="document($doc)/translation/texts/item[@name='Fecha_inicio_tarifa']/node()"/></th>
			<th><xsl:value-of select="document($doc)/translation/texts/item[@name='Fecha_final_tarifa']/node()"/></th>
			<th class="textLeft">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Documento_tarifa']/node()"/></th>
			<th class="textLeft">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Tipo_negociacion']/node()"/></th>
			<th><xsl:value-of select="document($doc)/translation/texts/item[@name='Bonificacion']/node()"/></th>
			<th class="uno"></th>
			<th class="dos"></th>
		</tr>
		</thead>
		<!--	Cuerpo de la tabla	-->
		<tbody class="corpo_tabela">
		<xsl:for-each select="PRODUCTO/DATOS_CLIENTE/TARIFA">
		<xsl:if test="TRF_IMPORTE">
		<tr class="conhover">
			<td class="color_status">&nbsp;</td>
			<td class="textLeft">&nbsp;<a href="javascript:RecuperarTarifa({../IDCLIENTE},'{TRF_IDSELECCIONGEO}');"><xsl:value-of select="../CLIENTE"/></a></td>
			<xsl:if test="/MantenimientoProductos/Form/PRODUCTO/MOSTRAR_PRECIO_FABRICA">
				<td><xsl:value-of select="TRF_PRECIOFABRICA"/></td>
				<td><xsl:value-of select="TRF_DESCUENTO"/>%</td>
			</xsl:if>
			<td><xsl:value-of select="TRF_IMPORTE"/></td>
			<xsl:if test="/MantenimientoProductos/Form/PRODUCTO/EMP_MULTIDIVISAS='S'">
				<td><xsl:value-of select="DIVISA/PREFIJO"/><xsl:value-of select="DIVISA/SUFIJO"/></td>
			</xsl:if>
			<td><xsl:value-of select="SELECCIONGEO"/></td>
			<td><xsl:value-of select="TRF_FECHAINICIO"/></td>
			<td><xsl:value-of select="TRF_FECHALIMITE"/></td>
			<td>
				<xsl:choose>
				<xsl:when test="DOCUMENTO">
					<a href="http://www.newco.dev.br/Documentos/{DOCUMENTO/URL}" target="_blank"><xsl:value-of select="DOCUMENTO/FECHA"/>:&nbsp;<xsl:value-of select="DOCUMENTO/NOMBRETIPO"/>:&nbsp;<xsl:value-of select="DOCUMENTO/NOMBRE"/></a>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="TRF_NOMBREDOCUMENTO"/>
				</xsl:otherwise>
				</xsl:choose>
			</td>
			<td><xsl:value-of select="TIPONEGOCIACION"/></td>
			<td>
				<xsl:if test="TRF_BONIF_CANTIDADDECOMPRA!='' and TRF_BONIF_CANTIDADGRATUITA!=''">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='Cantidad_compra']/node()"/>:&nbsp;<xsl:value-of select="TRF_BONIF_CANTIDADDECOMPRA"/>
					&nbsp;&nbsp;&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Cantidad_obsequiada']/node()"/>:&nbsp;<xsl:value-of select="TRF_BONIF_CANTIDADGRATUITA"/>
				</xsl:if>
			</td>
			<td>
				<xsl:if test="/MantenimientoProductos/Form/PRODUCTO/EDICION">
				<a>
					<xsl:attribute name="href">javascript:EliminarTarifa('<xsl:value-of select="../IDCLIENTE"/>','<xsl:value-of select="TRF_IDSELECCIONGEO"/>');</xsl:attribute>
					<img src="http://www.newco.dev.br/images/2017/trash.png" alt="eliminar"/>
				</a>
				</xsl:if>
			</td>
			<td>&nbsp;</td>
		</tr>
		</xsl:if>
		</xsl:for-each>
		</tbody>
		<tfoot class="rodape_tabela">
			<tr><td colspan="14">&nbsp;</td></tr>
		</tfoot>
	</table><!--fin de infoTableAma-->
 	</div>
 	<br/>  
 	<br/>  
	<input type="hidden" name="PRO_ID" value="{/MantenimientoProductos/Form/PRODUCTO/PRO_ID}"/>
	<input type="hidden" name="ACCION" value=""/>
	<xsl:if test="/MantenimientoProductos/Form/PRODUCTO/EDICION">
		<table cellspacing="6px" cellpadding="6px">
		<tr>
			<td class="w100px">&nbsp;</td>
			<xsl:choose>
			<xsl:when test="PRODUCTO/DESPLEGABLEEMPRESAS">
			<td class="w150px">
				<br/>
				<xsl:value-of select="document($doc)/translation/texts/item[@name='cliente']/node()"/>:<br/>
				<select name="IDCLIENTE" id="IDCLIENTE" class="w150px" onchange="javascript:CambioCliente();">
					<option value="-1"><xsl:value-of select="document($doc)/translation/texts/item[@name='seleccionar']/node()"/></option>
					<xsl:for-each select="PRODUCTO/DATOS_CLIENTE">
						<option value="{EMP_ID}"><xsl:value-of select="NOMBRE_CORTO"/></option>
					</xsl:for-each>
				</select>
			</td>
			</xsl:when>
			<xsl:otherwise>
				<input type="hidden" name="IDCLIENTE" id="IDCLIENTE" value="{/MantenimientoProductos/Form/PRODUCTO/USUARIO/EMP_ID}"/>
			</xsl:otherwise>
			</xsl:choose>
			<xsl:choose>
			<xsl:when test="/MantenimientoProductos/Form/PRODUCTO/MOSTRAR_PRECIO_FABRICA">
				<td class="w120px">
					<br/>
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='Precio_fabrica']/node()"/>:</label><br/>
					<input type="text" class="campopesquisa w120px" name="PRECIOFABRICA" id="PRECIOFABRICA"/>
				</td>
				<td class="w120px">
					<br/>
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='Descuento']/node()"/>:</label><br/>
					<input type="text" class="campopesquisa w120px" name="DESCUENTO" id="DESCUENTO"/>
				</td>
				<td class="w120px">
					<br/>
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='Precio_final']/node()"/>:</label><br/>
					<input type="text" class="campopesquisa w120px" name="IMPORTE" id="IMPORTE"/>
				</td>
			</xsl:when>
			<xsl:otherwise>
				<td class="w120px">
					<br/>
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='tarifa']/node()"/>:</label><br/>
					<input type="text" class="campopesquisa w120px" name="IMPORTE" id="IMPORTE"/>
				</td>
			</xsl:otherwise>
			</xsl:choose>
			<td class="w120px">
				<br/>
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='Fecha_inicio_tarifa']/node()"/>:</label><br/>
				<input type="text" class="campopesquisa w120px" name="FECHAINICIO" id="FECHAINICIO"/>
			</td>
			<td class="w120px">
				<br/>
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='Fecha_final_tarifa']/node()"/>:</label><br/>
				<input type="text" class="campopesquisa w120px" name="FECHAFINAL" id="FECHAFINAL"/>
			</td>
			<td class="w100px">
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='Bonificacion']/node()"/></label><br/>
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='Cantidad_compra']/node()"/>:</label>&nbsp;
				<input type="text" class="campopesquisa w100px" name="BONIF_COMPRA" id="BONIF_COMPRA"/>&nbsp;&nbsp;&nbsp;&nbsp;
			</td>
			<td class="w100px">
				<!--<br/>-->
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='Cantidad_obsequiada']/node()"/>:</label>&nbsp;
				<input type="text" class="campopesquisa w100px" name="BONIF_GRATIS" id="BONIF_GRATIS"/>
			</td>
			<td>&nbsp;</td>
		</tr>
		</table><!--fin de infoTableAma-->
		<table cellspacing="6px" cellpadding="6px">
		<tr>
			<td class="w100px">&nbsp;</td>
			<td id="tdAreaGeo" class="w100px" style="display:none">
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='Cobertura_geografica']/node()"/>:</label><br/>
            	<xsl:call-template name="desplegable">
            	<xsl:with-param name="path" select="PRODUCTO/IDSELECCIONGEO/field"></xsl:with-param>
            	<xsl:with-param name="claSel">w100px</xsl:with-param>
            	</xsl:call-template>
			</td>
			<td id="tdDivisa" class="w100px">
				<xsl:if test="EMP_MULTIDIVISAS='N'">
					<xsl:attribute name="style">display:none</xsl:attribute>
				</xsl:if>
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='divisa']/node()"/>:</label><br/>
            	<xsl:call-template name="desplegable">
            		<xsl:with-param name="path" select="PRODUCTO/DIVISAS/field"></xsl:with-param>
            		<xsl:with-param name="nombre">IDDIVISA</xsl:with-param>
          			<xsl:with-param name="id">IDDIVISA</xsl:with-param>
            		<xsl:with-param name="claSel">w100px</xsl:with-param>
					<!--<select name="IDDIVISA" id="IDDIVISA" style="width:150px;"/>-->
            	</xsl:call-template>
			</td>
			<td id="tdTipoNeg" class="w150px"><!-- style="display:none">-->
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='Tipo_negociacion']/node()"/>:</label><br/>
				<select name="IDTIPONEGOCIACION" id="IDTIPONEGOCIACION" class="w150px"/>
			</td>
			<xsl:if test="PRODUCTO/DOCUMENTOS">
			<td class="w200px">
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='documento']/node()"/>:</label><br/>
            	<xsl:call-template name="desplegable">
            	<xsl:with-param name="path" select="PRODUCTO/DOCUMENTOS/field"></xsl:with-param>
            	<xsl:with-param name="claSel">w200px</xsl:with-param>
            	</xsl:call-template>
			</td>
			</xsl:if>
			<td class="w200px">
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='Documento_tarifa']/node()"/>:</label><br/>
				<input type="text" class="campopesquisa w200px" name="NOMBREDOCUMENTO" id="NOMBREDOCUMENTO"/>
			</td>
			<td class="w100px">
				<br/>
				<a class="btnDestacado" href="javascript:Guardar();"><xsl:value-of select="document($doc)/translation/texts/item[@name='guardar']/node()"/></a>
			</td>
			<td>&nbsp;</td>
		</tr>
		</table><!--fin de infoTableAma-->
	</xsl:if>
	</div><!--fin de divLeft35 producto-->
</form>
</div><!--fin de divleft-->
</xsl:template>
</xsl:stylesheet>
