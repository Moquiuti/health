<?xml version="1.0" encoding="iso-8859-1"?>
<!-- 
	Templates de uso general para la NUEVA página principal de la licitación
	ultima revision: ET 17abr23 11:45
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>

<!-- Tabla Datos Generales Nueva Licitacion -->
<xsl:template name="Tabla_Datos_Generales_Nuevo">
<!--idioma-->
<xsl:variable name="lang">
	<xsl:value-of select="/Mantenimiento/LANG"/>
</xsl:variable>
<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
<!--idioma fin-->

<form class="formEstandar" id="form1" name="form1" action="http://www.newco.dev.br/Gestion/Comercial/MantLicitacion.xsql" method="post">
	<input type="hidden" name="LIC_IDUSUARIO" value="{/Mantenimiento/US_ID}"/>
	<input type="hidden" name="LIC_IDEMPRESA" value="{/Mantenimiento/NUEVALICITACION/IDEMPRESA}"/>
	<input type="hidden" name="LIC_ID"/>
	<input type="hidden" name="ACCION" value="NUEVO"/>
	<input type="hidden" name="LIC_AGREGADA" id="LIC_AGREGADA" value="N"/>
	<input type="hidden" name="LIC_CONTINUA" id="LIC_CONTINUA" value="N"/>
	<input type="hidden" name="LIC_URGENTE" id="LIC_URGENTE" value="N"/>
	<input type="hidden" name="LIC_SOLICDATOSPROV" id="LIC_SOLICDATOSPROV" value="S"/>
	<input type="hidden" name="LIC_MULTIOPCION" id="LIC_MULTIOPCION" value="N"/>
	<!--17jun20	-->
	<input type="hidden" name="LIC_FRETECIFOBLIGATORIO" id="LIC_FRETECIFOBLIGATORIO" value="N"/>
	<input type="hidden" name="LIC_PAGOAPLAZODOOBLIGATORIO" id="LIC_PAGOAPLAZODOOBLIGATORIO" value="N"/>
	<input type="hidden" name="LIC_PRECIOOBJETIVOESTRICTO" id="LIC_PRECIOOBJETIVOESTRICTO" value="N"/>
	<!--14nov16	-->
	<input type="hidden" name="LIC_PORPRODUCTO" id="LIC_PORPRODUCTO" value="S"/>
	<input type="hidden" name="LIC_FARMACIA" id="LIC_FARMACIA" value="N"/>
	<input type="hidden" name="LIC_IDFORMAPAGO" id="LIC_IDFORMAPAGO" value=""/>
	<input type="hidden" name="LIC_IDPLAZOPAGO" id="LIC_IDPLAZOPAGO" value=""/>

	<input type="hidden" name="LIC_DESCRIPCION_OLD" value="{/Mantenimiento/NUEVALICITACION/LIC_DESCRIPCION}"/>
	<input type="hidden" name="LIC_CONDENTREGA_OLD" value="{/Mantenimiento/NUEVALICITACION/LIC_CONDICIONESENTREGA}"/>
	<input type="hidden" name="LIC_CONDPAGO_OLD" value="{/Mantenimiento/NUEVALICITACION/LIC_CONDICIONESPAGO}"/>
	<input type="hidden" name="LIC_CONDOTRAS_OLD" value="{/Mantenimiento/NUEVALICITACION/LIC_OTRASCONDICIONES}"/>
	<input type="hidden" name="LIC_MESES_OLD" value="{/Mantenimiento/NUEVALICITACION/LIC_MESESDURACION}"/>

    <div>
        <ul style="width:1400px;">
			<xsl:if test="/Mantenimiento/LICITACION/USUARIOCREADOR">
			<li class="sinSeparador">
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='autor']/node()"/>:</label>
				<strong><xsl:value-of select="/Mantenimiento/LICITACION/USUARIOCREADOR"/></strong>
	        </li>
			</xsl:if>
			<xsl:if test="/Mantenimiento/LICITACION/USUARIOGESTOR">
				<li class="sinSeparador">
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='gestor']/node()"/>:</label>
					<strong><xsl:value-of select="/Mantenimiento/LICITACION/USUARIOGESTOR"/></strong>
	        	</li>
			</xsl:if>
            <li class="sinSeparador">
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='titulo']/node()"/>:<span class="camposObligatorios">*</span></label>
				<input type="text" class="campopesquisa w400px" name="LIC_TITULO" maxlength="100" value="{/Mantenimiento/NUEVALICITACION/LIC_TITULO}"/>
            </li>
            <li class="sinSeparador">
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_decision']/node()"/>:<span class="camposObligatorios">*</span></label>
				<input type="text" class="campopesquisa w100px" name="LIC_FECHADECISION" maxlength="10" />
				<xsl:call-template name="desplegable">
					<xsl:with-param name="path" select="/Mantenimiento/NUEVALICITACION/LIC_HORADECISION/field"/>
					<xsl:with-param name="claSel">w80px</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="desplegable">
					<xsl:with-param name="path" select="/Mantenimiento/NUEVALICITACION/LIC_MINUTODECISION/field"/>
					<xsl:with-param name="claSel">w80px</xsl:with-param>
				</xsl:call-template>
				&nbsp;<span class="fuentePeq"><xsl:value-of select="document($doc)/translation/texts/item[@name='formato_fecha_hora']/node()"/></span>
            </li>
			<xsl:choose>
				<xsl:when test="/Mantenimiento/NUEVALICITACION/EMP_LICITACIONESAGREGADAS='S'">
            	<li class="sinSeparador">
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='Licitacion_multicentro']/node()"/>:</label> 
					<input type="checkbox" class="muypeq" name="CHK_LIC_AGREGADA" id="CHK_LIC_AGREGADA" unchecked="unchecked"/>
					&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Licitacion_multicentro_expli']/node()"/>
            	</li>
				</xsl:when>
				<xsl:otherwise>
					<input type="hidden" name="CHK_LIC_AGREGADA" id="CHK_LIC_AGREGADA" value="unchecked"/>
				</xsl:otherwise>
			</xsl:choose>
            <li class="sinSeparador">
        		<input type="hidden" name="CADENA_DOCUMENTOS" />
        		<input type="hidden" name="DOCUMENTOS_BORRADOS"/>
        		<input type="hidden" name="BORRAR_ANTERIORES"/>
        		<input type="hidden" name="ID_USUARIO" value="" />
        		<input type="hidden" name="TIPO_DOC" value="DOC_LICITACION"/>
            	<input type="hidden" name="LIC_IDDOCUMENTO" id="LIC_IDDOCUMENTO" value=""/>
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='documento']/node()"/>:</label>
				<input id="inputFileDoc_Licitacion_" name="inputFileDoc" type="file" style="width:500px;" onchange="javascript:addDocFile(document.forms['form1'],'Licitacion_');cargaDoc(document.forms['form1'], 'DOC_LICITACION','Licitacion_');"/>
				<div id="divDatosDocumento" style="display:none;">
            		<a id="docLicitacion">
                    	&nbsp;
                	</a>
					<a href="javascript:borrarDoc('DOC_LICITACION')" style="width:20px;margin-top:4px;vertical-align:middle;"><img src="http://www.newco.dev.br/images/2017/trash.png"/></a>
				</div>
            	<div id="waitBoxDoc_Licitacion_" style="display:none;"><img src="http://www.newco.dev.br/images/descarga.gif" alt="Descarga" /></div>
            	<div id="confirmBox_Licitacion_" style="display:none;" align="center">
                	<span class="cargado" style="font-size:10px;"><xsl:value-of select="document($doc)/translation/texts/item[@name='documento_cargado']/node()"/>!</span>
            	</div>
            </li>
            <li class="sinSeparador">
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='Licitacion_continua']/node()"/>:</label> 
				<input type="checkbox" class="muypeq" name="CHK_LIC_CONTINUA" id="CHK_LIC_CONTINUA" checked="checked"/><!-- unchecked="unchecked"-->
				&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Licitacion_continua_expli']/node()"/>
            </li>
            <li class="sinSeparador">
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='Licitacion_urgente']/node()"/>:</label> 
				<input type="checkbox" class="muypeq" name="CHK_LIC_URGENTE" id="CHK_LIC_URGENTE" unchecked="unchecked"/>
				&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Licitacion_urgente_expli']/node()"/>
            </li>
            <li class="sinSeparador">
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='Solicitar_datos_proveedores']/node()"/>:</label> 
				<input type="checkbox" class="muypeq" name="CHK_LIC_SOLICDATOSPROV" id="CHK_LIC_SOLICDATOSPROV" checked="checked"/>
				&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Solicitar_datos_proveedores_expli']/node()"/>
            </li>
			<!--	nuevos campos 17jun20	-->
			<xsl:if test="/Mantenimiento/LICITACION/IDPAIS = 55 or /Mantenimiento/NUEVALICITACION/IDPAIS = 55">
            	<li class="sinSeparador">
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='Frete_CIF_obligatorio']/node()"/>:</label> 
					<input type="checkbox" class="muypeq" name="CHK_LIC_FRETECIFOBLIGATORIO" id="CHK_LIC_FRETECIFOBLIGATORIO" unchecked="unchecked"/>
					&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Frete_CIF_obligatorio_expli']/node()"/>
            	</li>
            	<li class="sinSeparador">
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='Pago_aplazado_obligatorio']/node()"/>:</label> 
					<input type="checkbox" class="muypeq" name="CHK_LIC_PAGOAPLAZODOOBLIGATORIO" id="CHK_LIC_PAGOAPLAZODOOBLIGATORIO" unchecked="unchecked"/>
					&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Pago_aplazado_obligatorio_expli']/node()"/>
            	</li>
			</xsl:if>
            <li class="sinSeparador">
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='Precio_objetivo_obligatorio']/node()"/>:</label> 
				<input type="checkbox" class="muypeq" name="CHK_LIC_PRECIOOBJETIVOESTRICTO" id="CHK_LIC_PRECIOOBJETIVOESTRICTO" unchecked="unchecked"/>
				&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Precio_objetivo_obligatorio_expli']/node()"/>
            </li>
			<!--	nuevos campos 17jun20	-->
            <li class="sinSeparador">
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='Adjudicacion_multiple']/node()"/>:</label> 
				<input type="checkbox" class="muypeq" name="CHK_LIC_MULTIOPCION" id="CHK_LIC_MULTIOPCION" unchecked="unchecked">
				<xsl:if test="/Mantenimiento/NUEVALICITACION/IDPAIS=55"><!--	Por ahora, desactivado para Brasil	-->
            		<xsl:attribute name="disabled" value="disabled"/>
				</xsl:if>
				</input>
				&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Adjudicacion_multiple_expli']/node()"/>
            </li>
            <li class="sinSeparador">
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='descripcion']/node()"/>:<span class="camposObligatorios">*</span></label>
				<textarea name="LIC_DESCRIPCION" rows="4" cols="120"><xsl:value-of select="/Mantenimiento/NUEVALICITACION/LIC_DESCRIPCION"/></textarea>
            </li>
            <li class="sinSeparador">
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='condiciones_entrega']/node()"/>:</label>
				<textarea name="LIC_CONDENTREGA" rows="4" cols="120"><xsl:value-of select="/Mantenimiento/NUEVALICITACION/LIC_CONDICIONESENTREGA"/></textarea>
            </li>
            <li class="sinSeparador">
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='condiciones_pago']/node()"/>:</label>
				<textarea name="LIC_CONDPAGO" rows="4" cols="120"><xsl:value-of select="/Mantenimiento/NUEVALICITACION/LIC_CONDICIONESPAGO"/></textarea>
            </li>
            <li class="sinSeparador">
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='condiciones_otras']/node()"/>:</label>
				<textarea name="LIC_CONDOTRAS" rows="4" cols="120"><xsl:value-of select="/Mantenimiento/NUEVALICITACION/LIC_OTRASCONDICIONES"/></textarea>
            </li>
			<xsl:choose>
			<xsl:when test="/Mantenimiento/NUEVALICITACION/LIC_MESES/field">
            <li class="sinSeparador">
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='meses_duracion']/node()"/>:</label>
				<xsl:call-template name="desplegable">
					<xsl:with-param name="path" select="/Mantenimiento/NUEVALICITACION/LIC_MESES/field"/>
					<xsl:with-param name="claSel">w200px</xsl:with-param>
				</xsl:call-template>
            </li>
			</xsl:when>
			<xsl:otherwise>
				<input type="hidden" name="LIC_MESES" id="LIC_MESES" value="0"/>
			</xsl:otherwise>
			</xsl:choose>
			<xsl:choose>
			<xsl:when test="/Mantenimiento/NUEVALICITACION/IDPAIS = 55">
				<!--	Para Brasil no informamos ni presentamos este campo	-->
			</xsl:when>
			<xsl:otherwise>
            	<li class="sinSeparador">
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_adjudicacion']/node()"/>:<span class="camposObligatorios">*</span></label>
					<input type="text" class="campopesquisa w150px" name="LIC_FECHAADJUDICACION" id="LIC_FECHAADJUDICACION" maxlength="10"/>
					&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='formato_fecha']/node()"/>
            	</li>
			</xsl:otherwise>
			</xsl:choose>

            <li class="campoPedidoPuntual" style="display:none;">
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='usuario']/node()"/>:</label>
				<select name="LIC_IDUSUARIOPEDIDO" id="LIC_IDUSUARIOPEDIDO" style="width:540px;" onChange="javascript:CambioUsuarioPedido();">
					<option value=""><xsl:value-of select="document($doc)/translation/texts/item[@name='selecciona']/node()"/></option>
					<xsl:for-each select="/Mantenimiento/NUEVALICITACION/field[@name='IDUSUARIOPEDIDO']/dropDownList/listElem">
						<option value="{ID}">
							<xsl:if test="ID = ../../SelectedElement"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>
							<xsl:value-of select="listItem"/>
						</option>
					</xsl:for-each>
				</select>
            </li>

            <li class="campoPedidoPuntual" style="display:none;">
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='lugar_entrega']/node()"/>:</label>
				<select name="LIC_IDLUGARENTREGA" id="LIC_IDLUGARENTREGA" class="w300px">
					<option value=""><xsl:value-of select="document($doc)/translation/texts/item[@name='selecciona']/node()"/></option>
					<xsl:for-each select="/Mantenimiento/NUEVALICITACION/field[@name='IDLUGARENTREGA']/dropDownList/listElem">
						<option value="{ID}">
							<xsl:value-of select="listItem"/>
						</option>
					</xsl:for-each>
				</select>
            </li>

            <li class="campoPedidoPuntual" style="display:none;">
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='codigo_pedido']/node()"/>:</label>
				<input type="text" id="LIC_CODIGOPEDIDO" name="LIC_CODIGOPEDIDO"/>
            </li>

            <li class="campoPedidoPuntual" style="display:none;">
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_entrega_programada']/node()"/>:</label>
				<input type="text" id="LIC_FECHAENTREGAPEDIDO" name="LIC_FECHAENTREGAPEDIDO"/>
				&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_entrega_expli']/node()"/>
            </li>

            <li class="campoPedidoPuntual" style="display:none;">
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='observaciones_pedido']/node()"/>:</label>
				<textarea id="LIC_OBSPEDIDO" name="LIC_OBSPEDIDO" rows="4" cols="120"><xsl:value-of select="/Mantenimiento/NUEVALICITACION/LIC_OBSPEDIDO"/></textarea>
            </li>
            <li class="sinSeparador">
				<label>&nbsp;</label>
				<a class="btnDestacado" href="javascript:ValidarFormulario(document.forms['form1'],'datosGenerales');">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='guardar']/node()"/>
				</a>&nbsp;&nbsp;&nbsp;
            </li>
        </ul>
		<br/>
		<br/>
		<br/>
		<br/>
		<br/>
		<br/>
		<br/>
		<br/>
    </div>
</form>

</xsl:template>
<!-- FIN Tabla Datos Generales Nueva Licitacion -->


<!-- Tabla Datos Generales -->
<xsl:template name="Tabla_Datos_Generales">
<!--idioma-->
<xsl:variable name="lang">
	<xsl:value-of select="/Mantenimiento/LANG"/>
</xsl:variable>
<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
<!--idioma fin-->

<div class="formComplejo">
<!--7feb22 se estaba perdiendo este campo-->
<input type="hidden" name="LIC_MULTIOPCION" id="LIC_MULTIOPCION" value="{/Mantenimiento/LICITACION/LIC_MULTIOPCION}"/>
<ul style="width:100%;">
    <li class="sinSeparador">
		<xsl:if test="/Mantenimiento/LICITACION/BOTON_PUBLICAR">
			<p id="txtCondLicitacion">
				<xsl:attribute name="style">
					<xsl:choose>
					<xsl:when test="/Mantenimiento/LICITACION/PRODUCTOSLICITACION/LIC_PROV_PEDIDOMINIMO != ''">
						<xsl:text>font-size:12px;margin-bottom:5px;text-align:right;</xsl:text>
					</xsl:when>
					<xsl:otherwise>
						<xsl:text>font-size:12px;margin-bottom:5px;text-align:right;display:none;</xsl:text>
					</xsl:otherwise>
					</xsl:choose>
				</xsl:attribute>

				<input type="checkbox" name="condLicitacion" class="muypeq" id="condLicitacion" value="accepted"/>&nbsp;
				<xsl:value-of select="document($doc)/translation/texts/item[@name='condiciones_licitacion']/node()"/>&nbsp;&nbsp;&nbsp;&nbsp;
			</p>
		</xsl:if>
	</li>
    <li class="sinSeparador">
		<!--<div style="width:800px;display:inline-block;">
		<span id="idEstadoLic" class="textLeft">-->
			<xsl:if test="/Mantenimiento/LICITACION/MULTIOFERTAS/MO_ID != ''">
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='pedidos']/node()"/>:</label>&nbsp;<strong><xsl:value-of select="/Mantenimiento/LICITACION/LIC_PEDIDOSENVIADOS"/></strong>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a class="btnNormal" href="javascript:VerPedidos({/Mantenimiento/LICITACION/LIC_ID});"><xsl:value-of select="document($doc)/translation/texts/item[@name='lic_pedido_s']/node()"/></a>
			</xsl:if>
			<xsl:if test="/Mantenimiento/LICITACION/BOTON_DESCARGAR_OC">
				&nbsp;&nbsp;<a class="btnNormal" href="javascript:DescargarOC('{/Mantenimiento/LICITACION/LIC_IDFICHEROINTEGRACION}',{/Mantenimiento/LICITACION/LIC_ID});"><xsl:value-of select="document($doc)/translation/texts/item[@name='boton_descargarOC']/node()"/></a>
			</xsl:if>
			<!--7oct21 nuevo boton para permitir al descarga de OCs retenidas	-->
			<xsl:if test="/Mantenimiento/LICITACION/BOTON_PERMITIR_DESCARGA">
				&nbsp;&nbsp;<a class="btnNormal" id="btnPermitirDescarga" href="javascript:PermitirDescarga({/Mantenimiento/LICITACION/LIC_IDFICHEROINTEGRACION});"><xsl:value-of select="document($doc)/translation/texts/item[@name='boton_permitirdescargaOC']/node()"/></a>
			</xsl:if>
		<!--</span>
		</div>-->
		<xsl:if test="/Mantenimiento/LICITACION/LIC_IDESTADO = 'ADJ' or /Mantenimiento/LICITACION/LIC_IDESTADO = 'FIRM' or /Mantenimiento/LICITACION/LIC_IDESTADO = 'CONT'">
			&nbsp;&nbsp;&nbsp;&nbsp;<label><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_real_adj']/node()"/>:&nbsp;</label>
			<xsl:choose>
			<xsl:when test="/Mantenimiento/LICITACION/AUTOR">
				<input type="text"  class="campopesquisa w100px" id="LIC_FECHAREALADJUDICACION" name="LIC_FECHAREALADJUDICACION" value="{Mantenimiento/LICITACION/LIC_FECHAREALADJUDICACION}" size="8" maxlength="8"/>
				&nbsp;<a href="javascript:ActualizarFechasReales();" class="btnDiscreto">M</a>
					<!--<img src="http://www.newco.dev.br/images/modificar.gif">
						<xsl:attribute name="alt"><xsl:value-of select="document($doc)/translation/texts/item[@name='actualizar_fecha']/node()"/></xsl:attribute>
						<xsl:attribute name="title"><xsl:value-of select="document($doc)/translation/texts/item[@name='actualizar_fecha']/node()"/></xsl:attribute>-
					</img>
				</a>-->
				&nbsp;
            	<span class="fuentePeq">
                	<xsl:value-of select="document($doc)/translation/texts/item[@name='formato_fecha']/node()"/>
            	</span>
			</xsl:when>
			<xsl:otherwise>
            	<strong>
                	<xsl:value-of select="/Mantenimiento/LICITACION/LIC_FECHAREALADJUDICACION"/>
            	</strong>
			</xsl:otherwise>
			</xsl:choose>
			<div class="marginLeft50 inline"><label><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_real_cad']/node()"/>:&nbsp;</label></div>
			<xsl:choose>
			<xsl:when test="/Mantenimiento/LICITACION/AUTOR">
				<input type="text" class="campopesquisa w100px" id="LIC_FECHAREALCADUCIDAD" name="LIC_FECHAREALCADUCIDAD" value="{Mantenimiento/LICITACION/LIC_FECHAREALCADUCIDAD}" size="8" maxlength="8"/>
				&nbsp;<a href="javascript:ActualizarFechasReales();"  class="btnDiscreto">M</a>
					<!--<img src="http://www.newco.dev.br/images/modificar.gif">
						<xsl:attribute name="alt"><xsl:value-of select="document($doc)/translation/texts/item[@name='actualizar_fecha']/node()"/></xsl:attribute>
						<xsl:attribute name="title"><xsl:value-of select="document($doc)/translation/texts/item[@name='actualizar_fecha']/node()"/></xsl:attribute>
					</img>
				</a>-->
				&nbsp;
                <span class="fuentePeq">
                    <xsl:value-of select="document($doc)/translation/texts/item[@name='formato_fecha']/node()"/>
                </span>
			</xsl:when>
			<xsl:otherwise>
                <strong>
                    <xsl:value-of select="/Mantenimiento/LICITACION/LIC_FECHAREALCADUCIDAD"/>
                </strong>
			</xsl:otherwise>
			</xsl:choose>
		</xsl:if>
	</li>
</ul>
</div>
<br/>

<div class="lDatosGenerales formEstandar" style="margin-top:50px;"><!--posContenedorLic-->
	<br/>
	<xsl:if test="/Mantenimiento/LICITACION/ROL = 'VENDEDOR' and /Mantenimiento/LICITACION/PRODUCTOSLICITACION/LIC_PROV_IDESTADO = 'CURS'">
		<span class="avisoFondoDestacado" style="margin-left:50px;">
			<strong><xsl:value-of select="document($doc)/translation/texts/item[@name='lic_proveedores_expli']/node()"/></strong>
		</span>
	</xsl:if>
	<br/>
    <ul style="width:1400px;">
		<li class="sinSeparador">
			<label><xsl:value-of select="document($doc)/translation/texts/item[@name='autor']/node()"/>:</label>
				<strong><xsl:value-of select="/Mantenimiento/LICITACION/USUARIOCREADOR"/></strong>
	    </li>
		<xsl:if test="/Mantenimiento/LICITACION/USUARIOGESTOR">
			<li class="sinSeparador">
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='gestor']/node()"/>:</label>
				<strong><xsl:value-of select="/Mantenimiento/LICITACION/USUARIOGESTOR"/></strong>
	        </li>
		</xsl:if>
		<xsl:if test="/Mantenimiento/LICITACION/LIC_CODIGOSOLICITUD!=''">
        	<li class="sinSeparador">
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='Solicitud_productos']/node()"/>:</label>
				<strong><xsl:value-of select="/Mantenimiento/LICITACION/LIC_CODIGOSOLICITUD"/></strong>
        	</li>
		</xsl:if>
		<xsl:if test="/Mantenimiento/LICITACION/CATEGORIAPRINCIPAL">
        	<li class="sinSeparador">
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='categorias']/node()"/> (<xsl:value-of select="document($doc)/translation/texts/item[@name='productos']/node()"/>):</label>
				<strong><xsl:value-of select="/Mantenimiento/LICITACION/CATEGORIAPRINCIPAL"/>.&nbsp;<xsl:value-of select="/Mantenimiento/LICITACION/RESTOCATEGORIAS"/></strong>
        	</li>
		</xsl:if>
		<xsl:if test="/Mantenimiento/LICITACION/SELECCIONPRINCIPAL">
        	<li class="sinSeparador">
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='selecciones']/node()"/> (<xsl:value-of select="document($doc)/translation/texts/item[@name='proveedores']/node()"/>):</label>
				<strong><xsl:value-of select="/Mantenimiento/LICITACION/SELECCIONPRINCIPAL"/>.&nbsp;<xsl:value-of select="/Mantenimiento/LICITACION/RESTOSELECCIONES"/></strong>
        	</li>
		</xsl:if>
        <li class="sinSeparador">
			<label><xsl:value-of select="document($doc)/translation/texts/item[@name='descripcion']/node()"/>:</label>
			<!--	PENDIENTE. HAY QUE EVITAR QUE LOS TEXTOS LARGOS PASEN A ESTAR DEBAJO DEL LABEL			-->
			<xsl:copy-of select="/Mantenimiento/LICITACION/LIC_DESCRIPCION/node()"/>&nbsp;
		</li>
		<xsl:if test="/Mantenimiento/LICITACION/DOCLICITACION/URL">
		    <li class="sinSeparador">
			<label><xsl:value-of select="document($doc)/translation/texts/item[@name='documento']/node()"/>:</label>
            <a href="http://www.newco.dev.br/Documentos/{/Mantenimiento/LICITACION/DOCLICITACION/URL}" title="{/Mantenimiento/LICITACION/DOCLICITACION/NOMBRE}" id="docLicitacion">
                <xsl:value-of select="/Mantenimiento/LICITACION/DOCLICITACION/NOMBRE"/>
            </a>
       		</li>
		</xsl:if>
        <li class="sinSeparador">
			<label><xsl:value-of select="document($doc)/translation/texts/item[@name='condiciones_entrega']/node()"/>:</label>
			<xsl:copy-of select="/Mantenimiento/LICITACION/LIC_CONDICIONESENTREGA/node()"/>&nbsp;
		</li>
        <li class="sinSeparador">
			<label><xsl:value-of select="document($doc)/translation/texts/item[@name='condiciones_pago']/node()"/>:</label>
			<xsl:copy-of select="/Mantenimiento/LICITACION/LIC_CONDICIONESPAGO/node()"/>&nbsp;
		</li>
        <li class="sinSeparador">
			<label><xsl:value-of select="document($doc)/translation/texts/item[@name='condiciones_otras']/node()"/>:</label>
			<xsl:copy-of select="/Mantenimiento/LICITACION/LIC_OTRASCONDICIONES/node()"/>&nbsp;
		</li>
			<li class="sinSeparador">
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='Licitacion_continua']/node()"/>:</label>
				<xsl:choose>
				<xsl:when test="/Mantenimiento/LICITACION/LIC_CONTINUA='S'">
					<input type="checkbox" class="muypeq" name="CHK_LIC_CONTINUA" id="CHK_LIC_CONTINUA" checked="checked" disabled="disabled"/>
				</xsl:when>
				<xsl:otherwise>
					<input type="checkbox" class="muypeq" name="CHK_LIC_CONTINUA" id="CHK_LIC_CONTINUA" unchecked="unchecked" disabled="disabled"/>
				</xsl:otherwise>
				</xsl:choose>
				<input type="hidden" name="LIC_CONTINUA" id="LIC_CONTINUA" value="N"/>
				&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Licitacion_continua_expli']/node()"/>
	        </li>
			<li class="sinSeparador">
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='Licitacion_urgente']/node()"/>:</label>
				<xsl:choose>
				<xsl:when test="/Mantenimiento/LICITACION/LIC_URGENTE='S'">
					<input type="checkbox" class="muypeq" name="CHK_LIC_URGENTE" id="CHK_LIC_URGENTE" checked="checked" disabled="disabled"/>
				</xsl:when>
				<xsl:otherwise>
					<input type="checkbox" class="muypeq" name="CHK_LIC_URGENTE" id="CHK_LIC_URGENTE" unchecked="unchecked" disabled="disabled"/>
				</xsl:otherwise>
				</xsl:choose>
                &nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Licitacion_urgente_expli']/node()"/>
	        </li>
			<!--	nuevos campos 17jun20	-->
			<xsl:if test="/Mantenimiento/LICITACION/IDPAIS = 55 or /Mantenimiento/NUEVALICITACION/IDPAIS = 55">
			    <li class="sinSeparador">
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='Frete_CIF_obligatorio']/node()"/>:</label>
					<xsl:choose>
					<xsl:when test="/Mantenimiento/LICITACION/LIC_FRETECIFOBLIGATORIO='S'">
						<input type="checkbox" class="muypeq" name="CHK_LIC_FRETECIFOBLIGATORIO" id="CHK_LIC_FRETECIFOBLIGATORIO" checked="checked"/>
					</xsl:when>
					<xsl:otherwise>
						<input type="checkbox" class="muypeq" name="CHK_LIC_FRETECIFOBLIGATORIO" id="CHK_LIC_FRETECIFOBLIGATORIO" unchecked="unchecked"/>
					</xsl:otherwise>
					</xsl:choose>
                    &nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Frete_CIF_obligatorio_expli']/node()"/>
	            </li>
			    <li class="sinSeparador">
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='Pago_aplazado_obligatorio']/node()"/>:</label>
					<xsl:choose>
					<xsl:when test="/Mantenimiento/LICITACION/LIC_PAGOAPLAZADOOBLIGATORIO='S'">
						<input type="checkbox" class="muypeq" name="CHK_LIC_PAGOAPLAZODOOBLIGATORIO" id="CHK_LIC_PAGOAPLAZODOOBLIGATORIO" checked="checked"/>
					</xsl:when>
					<xsl:otherwise>
						<input type="checkbox" class="muypeq" name="CHK_LIC_PAGOAPLAZODOOBLIGATORIO" id="CHK_LIC_PAGOAPLAZODOOBLIGATORIO" unchecked="unchecked"/>
					</xsl:otherwise>
					</xsl:choose>
                    &nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Pago_aplazado_obligatorio_expli']/node()"/>
	            </li>
			</xsl:if>
			<li class="sinSeparador">
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='Precio_objetivo_obligatorio']/node()"/>:</label>
				<xsl:choose>
				<xsl:when test="/Mantenimiento/LICITACION/LIC_PRECIOOBJETIVOESTRICTO='S'">
					<input type="checkbox" class="muypeq" name="CHK_LIC_PRECIOOBJETIVOESTRICTO" id="CHK_LIC_PRECIOOBJETIVOESTRICTO" checked="checked" disabled="disabled"/>
				</xsl:when>
				<xsl:otherwise>
					<input type="checkbox" class="muypeq" name="CHK_LIC_PRECIOOBJETIVOESTRICTO" id="CHK_LIC_PRECIOOBJETIVOESTRICTO" unchecked="unchecked" disabled="disabled"/>
				</xsl:otherwise>
				</xsl:choose>
                &nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Precio_objetivo_obligatorio_expli']/node()"/>
	        </li>
			<!--	nuevos campos 17jun20	-->
        <li class="sinSeparador">
			<label><xsl:value-of select="document($doc)/translation/texts/item[@name='meses_duracion']/node()"/>:</label>
			<xsl:choose>
			<xsl:when test="/Mantenimiento/LICITACION/LIC_MESESDURACION = 0">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='lic_pedido_puntual']/node()"/>
			</xsl:when>
			<xsl:when test="/Mantenimiento/LICITACION/LIC_MESESDURACION = 1">
				<xsl:value-of select="/Mantenimiento/LICITACION/LIC_MESESDURACION"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='mes']/node()"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="/Mantenimiento/LICITACION/LIC_MESESDURACION"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='meses']/node()"/>
			</xsl:otherwise>&nbsp;
			</xsl:choose>
		</li>
		<xsl:if test="/Mantenimiento/LICITACION/IDPAIS != 55 and /Mantenimiento/LICITACION/LIC_MESESDURACION != 0">
        	<li class="sinSeparador">
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_adjudicacion']/node()"/>:</label>
				<xsl:value-of select="/Mantenimiento/LICITACION/LIC_FECHAADJUDICACION"/>&nbsp;
			</li>
		</xsl:if>


		<!--	28abr17	ET Incluimos datos del pedido cuando corresponda	-->
		<xsl:if test="/Mantenimiento/LICITACION/LIC_MESESDURACION = 0">
			<xsl:if test="/Mantenimiento/LICITACION/IDPAIS != 55">
            	<li class="sinSeparador">
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_adjudicacion']/node()"/>:</label>
					<xsl:value-of select="/Mantenimiento/LICITACION/LIC_FECHAADJUDICACION"/>&nbsp;
            	</li>
			</xsl:if>
            <li class="sinSeparador">
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='usuario']/node()"/>:</label>
				<xsl:for-each select="/Mantenimiento/LICITACION/field[@name='IDUSUARIOPEDIDO']/dropDownList/listElem">
					<xsl:if test="ID = ../../SelectedElement"><xsl:value-of select="listItem"/></xsl:if>
				</xsl:for-each>&nbsp;
            </li>
            <li class="sinSeparador">
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='lugar_entrega']/node()"/>:</label>
				<xsl:for-each select="/Mantenimiento/LICITACION/field[@name='IDLUGARENTREGA']/dropDownList/listElem">
					<xsl:if test="ID = ../../SelectedElement"><xsl:value-of select="listItem"/></xsl:if>
				</xsl:for-each>&nbsp;
            </li>
			<xsl:if test="/Mantenimiento/LICITACION/LIC_FECHAENTREGAPEDIDO != ''">
            	<li class="sinSeparador">
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_entrega_programada']/node()"/>:</label>
					<span class="urgente"><xsl:value-of select="/Mantenimiento/LICITACION/LIC_FECHAENTREGAPEDIDO"/></span><br/>
            	</li>
			</xsl:if>
            <li class="sinSeparador">
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='codigo_pedido']/node()"/>:</label>
				<xsl:value-of select="/Mantenimiento/LICITACION/LIC_CODIGOPEDIDO"/>&nbsp;
            </li>
            <li class="sinSeparador">
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='observaciones_pedido']/node()"/>:</label>
				<xsl:value-of select="/Mantenimiento/LICITACION/LIC_COMENTARIOSPEDIDO"/>&nbsp;
            </li>
		</xsl:if>
	</ul>
</div>

</xsl:template>
<!-- FIN Tabla Datos Generales -->


<!-- Tabla Datos Generales Autor -->
<xsl:template name="Tabla_Datos_Generales_Autor">
<!--idioma-->
<xsl:variable name="lang">
	<xsl:value-of select="/Mantenimiento/LANG"/>
</xsl:variable>
<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
<!--idioma fin-->

<form id="frmDatosGenerales" name="frmDatosGenerales" action="http://www.newco.dev.br/Gestion/Comercial/MantLicitacion.xsql" method="post">
	<input type="hidden" name="LIC_IDUSUARIO" value="{Mantenimiento/US_ID}"/>
	<input type="hidden" name="LIC_IDEMPRESA" value="{/Mantenimiento/LICITACION/LIC_IDEMPRESA}"/>
	<input type="hidden" name="LIC_ID" value="{/Mantenimiento/LICITACION/LIC_ID}"/>
	<input type="hidden" name="ACCION" value="MODIFICAR"/>
	<!--7feb22 se estaba perdiendo este campo-->
	<input type="hidden" name="LIC_MULTIOPCION" id="LIC_MULTIOPCION" value="{/Mantenimiento/LICITACION/LIC_MULTIOPCION}"/>
	<input type="hidden" name="LIC_PORPRODUCTO" id="LIC_PORPRODUCTO" value="{/Mantenimiento/LICITACION/LIC_PORPRODUCTO}"/>
	<input type="hidden" name="LIC_FARMACIA" id="LIC_FARMACIA" value="{/Mantenimiento/LICITACION/LIC_FARMACIA}"/>
	<div class="formEstandar">
    <ul class="w1200px">
        <li class="sinSeparador">
			<!--	Titulo	-->
			<label><xsl:value-of select="document($doc)/translation/texts/item[@name='titulo']/node()"/>:</label>
			<input class="campopesquisa w600px" type="text" name="LIC_TITULO" value="{Mantenimiento/LICITACION/LIC_TITULO}" maxlength="200"/>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<a class="btnDestacado" id="btnGuardarDatosGenerales" href="javascript:GuardarDatosGenerales();">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='guardar']/node()"/>
			</a>
        </li>
		<li class="sinSeparador">
			<label><xsl:value-of select="document($doc)/translation/texts/item[@name='autor']/node()"/>:</label>
			<xsl:choose>
			<xsl:when test="/Mantenimiento/LICITACION/USUARIOGESTOR or not(/Mantenimiento/LICITACION/USUARIOSDELCENTRO/TOTAL) or /Mantenimiento/LICITACION/USUARIOSDELCENTRO/TOTAL='1' ">
				<strong>
					<xsl:choose>
					<xsl:when test="/Mantenimiento/LICITACION/USUARIOCREADOR!='' ">
						<xsl:value-of select="/Mantenimiento/LICITACION/USUARIOCREADOR"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="/Mantenimiento/LICITACION/USUARIOLICITACION/NOMBRE"/>
					</xsl:otherwise>
					</xsl:choose>
				</strong>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="desplegable">
					<xsl:with-param name="path" select="/Mantenimiento/LICITACION/USUARIOSDELCENTRO/field"/>
					<xsl:with-param name="claSel">w500px</xsl:with-param>
					<xsl:with-param name="onChange">javascript:mostrarBoton('btnGuardarCreador');</xsl:with-param>
				</xsl:call-template>
				&nbsp;<a id="btnGuardarCreador" class="btnDestacado" style="display:none" href="javascript:cambiaUsuarioLic('CREADOR','btnGuardarCreador');"><xsl:value-of select="document($doc)/translation/texts/item[@name='guardar']/node()"/></a>
				&nbsp;<img id="chkGuardaUsuarioLic" src="http://www.newco.dev.br/images/check.gif" style="display:none"/>
				&nbsp;<img id="errGuardaUsuarioLic" src="http://www.newco.dev.br/images/error.gif" style="display:none"/>
			</xsl:otherwise>
			</xsl:choose>
	    </li>
		<xsl:if test="/Mantenimiento/LICITACION/USUARIOGESTOR">
			<li class="sinSeparador">
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='gestor']/node()"/>:</label>
				<xsl:choose>
				<xsl:when test="not(/Mantenimiento/LICITACION/USUARIOSDELCENTRO/TOTAL) or /Mantenimiento/LICITACION/USUARIOSDELCENTRO/TOTAL='1' ">
					<strong><xsl:value-of select="/Mantenimiento/LICITACION/USUARIOGESTOR"/></strong>
				</xsl:when>
				<xsl:otherwise>
					<xsl:call-template name="desplegable">
						<xsl:with-param name="path" select="/Mantenimiento/LICITACION/USUARIOSDELCENTRO/field"/>
						<xsl:with-param name="claSel">w500px</xsl:with-param>
						<xsl:with-param name="onChange">javascript:mostrarBoton('btnGuardarGestor');</xsl:with-param>
					</xsl:call-template>
					&nbsp;<a id="btnGuardarGestor" class="btnDestacado" style="display:none" href="javascript:cambiaUsuarioLic('GESTOR', 'btnGuardarGestor');"><xsl:value-of select="document($doc)/translation/texts/item[@name='guardar']/node()"/></a>
					&nbsp;<img id="chkGuardaUsuarioLic" src="http://www.newco.dev.br/images/check.gif" style="display:none"/>
					&nbsp;<img id="errGuardaUsuarioLic" src="http://www.newco.dev.br/images/error.gif" style="display:none"/>
				</xsl:otherwise>
				</xsl:choose>
	        </li>
		</xsl:if>
		<xsl:if test="/Mantenimiento/LICITACION/LIC_CODIGOSOLICITUD!=''">
        	<li class="sinSeparador">
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='Solicitud_productos']/node()"/>:</label>
				<strong><xsl:value-of select="/Mantenimiento/LICITACION/LIC_CODIGOSOLICITUD"/></strong>
        	</li>
		</xsl:if>
		<xsl:if test="/Mantenimiento/LICITACION/CATEGORIAPRINCIPAL">
        	<li class="sinSeparador">
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='categorias']/node()"/> (<xsl:value-of select="document($doc)/translation/texts/item[@name='productos']/node()"/>):</label>
				<strong><xsl:value-of select="/Mantenimiento/LICITACION/CATEGORIAPRINCIPAL"/>.&nbsp;<xsl:value-of select="/Mantenimiento/LICITACION/RESTOCATEGORIAS"/></strong>
        	</li>
		</xsl:if>
		<xsl:if test="/Mantenimiento/LICITACION/SELECCIONPRINCIPAL">
        	<li class="sinSeparador">
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='selecciones']/node()"/> (<xsl:value-of select="document($doc)/translation/texts/item[@name='proveedores']/node()"/>):</label>
				<strong><xsl:value-of select="/Mantenimiento/LICITACION/SELECCIONPRINCIPAL"/>.&nbsp;<xsl:value-of select="/Mantenimiento/LICITACION/RESTOSELECCIONES"/></strong>
        	</li>
		</xsl:if>
        <li class="sinSeparador">
			<label><xsl:value-of select="document($doc)/translation/texts/item[@name='descripcion']/node()"/>:</label>
			<xsl:choose>
			<xsl:when test="/Mantenimiento/LICITACION/AUTOR">
				<textarea name="LIC_DESCRIPCION" rows="4" cols="80"><xsl:copy-of select="/Mantenimiento/LICITACION/LIC_DESCRIPCION/node()"/></textarea>
			</xsl:when>
			<xsl:otherwise>
				<textarea name="LIC_DESCRIPCION" rows="4" cols="80" disabled="disabled"><xsl:copy-of select="/Mantenimiento/LICITACION/LIC_DESCRIPCION/node()"/></textarea>
			</xsl:otherwise>
			</xsl:choose>
        </li>
		<xsl:choose>
		<xsl:when test="/Mantenimiento/LICITACION/AUTOR">
        	<li class="sinSeparador" style="width:1500px;">
        		<input type="hidden" name="CADENA_DOCUMENTOS" />
        		<input type="hidden" name="DOCUMENTOS_BORRADOS"/>
        		<input type="hidden" name="BORRAR_ANTERIORES"/>
        		<input type="hidden" name="ID_USUARIO" value="" />
        		<input type="hidden" name="TIPO_DOC" value="DOC_LICITACION"/>
            	<input type="hidden" name="LIC_IDDOCUMENTO" id="LIC_IDDOCUMENTO" value="{/Mantenimiento/LICITACION/DOCLICITACION/ID}"/>
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='documento']/node()"/>:</label>
				<xsl:choose>
				<xsl:when test="not (/Mantenimiento/LICITACION/DOCLICITACION/URL)">
					<input id="inputFileDoc_Licitacion_{/Mantenimiento/LICITACION/LIC_ID}" name="inputFileDoc" type="file" style="width:500px;" onchange="javascript:addDocFile(document.forms['frmDatosGenerales'],'Licitacion_'+{/Mantenimiento/LICITACION/LIC_ID});cargaDoc(document.forms['frmDatosGenerales'], 'DOC_LICITACION','Licitacion_'+{/Mantenimiento/LICITACION/LIC_ID});"/>
					<div id="divDatosDocumento" style="display:none;">
            			<a id="docLicitacion">
                    		&nbsp;
                		</a>
						<a href="javascript:borrarDoc('DOC_LICITACION')" style="width:20px;margin-top:4px;vertical-align:middle;"><img src="http://www.newco.dev.br/images/2017/trash.png"/></a>
					</div>
				</xsl:when>
				<xsl:otherwise>
					<input style="display:none;width:500px;" id="inputFileDoc_Licitacion_{/Mantenimiento/LICITACION/LIC_ID}" name="inputFileDoc" type="file" onchange="javascript:addDocFile(document.forms['frmDatosGenerales'],'Licitacion_'+{/Mantenimiento/LICITACION/LIC_ID});cargaDoc(document.forms['frmDatosGenerales'], 'DOC_LICITACION','Licitacion_'+{/Mantenimiento/LICITACION/LIC_ID});"/>
 					<div id="divDatosDocumento">
            			<a href="http://www.newco.dev.br/Documentos/{/Mantenimiento/LICITACION/DOCLICITACION/URL}" title="{/Mantenimiento/LICITACION/DOCLICITACION/NOMBRE}" id="docLicitacion">
                    		<xsl:value-of select="/Mantenimiento/LICITACION/DOCLICITACION/NOMBRE"/>
                		</a>
						<a href="javascript:borrarDoc('DOC_LICITACION')" style="width:20px;margin-top:4px;vertical-align:middle;"><img src="http://www.newco.dev.br/images/2017/trash.png"/></a>
					</div>
				</xsl:otherwise>
				</xsl:choose>
            	<div id="waitBoxDoc_Licitacion_{/Mantenimiento/LICITACION/LIC_ID}" style="display:none;"><img src="http://www.newco.dev.br/images/descarga.gif" alt="Descarga" /></div>
            	<div id="confirmBox_Licitacion_{/Mantenimiento/LICITACION/LIC_ID}" style="display:none;" align="center">
                	<span class="cargado" style="font-size:10px;"><xsl:value-of select="document($doc)/translation/texts/item[@name='documento_cargado']/node()"/>!</span>
            	</div>
				<!--	17abr23 recuperamos para cargar documentos	-->
       			<div id="uploadFrameBox" style="display:none;"><iframe src="" id="uploadFrame" name="uploadFrame" style="width: 100%;"></iframe></div>
       			<div id="uploadFrameBoxDoc" style="display:none;"><iframe src="" id="uploadFrameDoc" name="uploadFrameDoc" style="width: 100%;"></iframe></div>
        	</li>
		</xsl:when>
		<xsl:otherwise>
			<xsl:if test="/Mantenimiento/LICITACION/DOCLICITACION/URL">
		        <li class="sinSeparador">
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='documento']/node()"/>:</label>
            	<a href="http://www.newco.dev.br/Documentos/{/Mantenimiento/LICITACION/DOCLICITACION/URL}" title="{/Mantenimiento/LICITACION/DOCLICITACION/NOMBRE}" id="docLicitacion">
                    <xsl:value-of select="/Mantenimiento/LICITACION/DOCLICITACION/NOMBRE"/>
                </a>
       			</li>
			</xsl:if>
		</xsl:otherwise>
		</xsl:choose>
        <li class="sinSeparador">
			<label><xsl:value-of select="document($doc)/translation/texts/item[@name='condiciones_entrega']/node()"/>:</label>
			<xsl:choose>
			<xsl:when test="/Mantenimiento/LICITACION/AUTOR">
				<textarea name="LIC_CONDENTREGA" rows="4" cols="80"><xsl:copy-of select="/Mantenimiento/LICITACION/LIC_CONDICIONESENTREGA/node()"/></textarea>
			</xsl:when>
			<xsl:otherwise>
				<textarea name="LIC_CONDENTREGA" rows="4" cols="80" disabled="disabled"><xsl:copy-of select="/Mantenimiento/LICITACION/LIC_CONDICIONESENTREGA/node()"/></textarea>
			</xsl:otherwise>
			</xsl:choose>
        </li>
        <li class="sinSeparador">
			<label><xsl:value-of select="document($doc)/translation/texts/item[@name='condiciones_pago']/node()"/>:</label>
			<xsl:choose>
			<xsl:when test="/Mantenimiento/LICITACION/AUTOR">
				<textarea name="LIC_CONDPAGO" rows="4" cols="80"><xsl:copy-of select="/Mantenimiento/LICITACION/LIC_CONDICIONESPAGO/node()"/></textarea>
			</xsl:when>
			<xsl:otherwise>
				<textarea name="LIC_CONDPAGO" rows="4" cols="80" disabled="disabled"><xsl:copy-of select="/Mantenimiento/LICITACION/LIC_CONDICIONESPAGO/node()"/></textarea>
			</xsl:otherwise>
			</xsl:choose>
        </li>
        <li class="sinSeparador">
			<label><xsl:value-of select="document($doc)/translation/texts/item[@name='condiciones_otras']/node()"/>:</label>
			<xsl:choose>
			<xsl:when test="/Mantenimiento/LICITACION/AUTOR">
				<textarea name="LIC_CONDOTRAS" rows="4" cols="80"><xsl:copy-of select="/Mantenimiento/LICITACION/LIC_OTRASCONDICIONES/node()"/></textarea>
			</xsl:when>
			<xsl:otherwise>
				<textarea name="LIC_CONDOTRAS" rows="4" cols="80" disabled="disabled"><xsl:copy-of select="/Mantenimiento/LICITACION/LIC_OTRASCONDICIONES/node()"/></textarea>
			</xsl:otherwise>
			</xsl:choose>
        </li>
		<li class="sinSeparador">
			<label><xsl:value-of select="document($doc)/translation/texts/item[@name='Licitacion_continua']/node()"/>:</label>
			<xsl:choose>
			<xsl:when test="/Mantenimiento/LICITACION/AUTOR">
				<xsl:choose>
				<xsl:when test="/Mantenimiento/LICITACION/LIC_CONTINUA='S'">
					<input type="checkbox" class="muypeq" name="CHK_LIC_CONTINUA" id="CHK_LIC_CONTINUA" checked="checked"/>
				</xsl:when>
				<xsl:otherwise>
					<input type="checkbox" class="muypeq" name="CHK_LIC_CONTINUA" id="CHK_LIC_CONTINUA" unchecked="unchecked"/>
				</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise>
				<xsl:choose>
				<xsl:when test="/Mantenimiento/LICITACION/LIC_CONTINUA='S'">
					<input type="checkbox" class="muypeq" name="CHK_LIC_CONTINUA" id="CHK_LIC_CONTINUA" checked="checked" disabled="disabled"/>
				</xsl:when>
				<xsl:otherwise>
					<input type="checkbox" class="muypeq" name="CHK_LIC_CONTINUA" id="CHK_LIC_CONTINUA" unchecked="unchecked" disabled="disabled"/>
				</xsl:otherwise>
				</xsl:choose>
			</xsl:otherwise>
			</xsl:choose>
			<input type="hidden" name="LIC_CONTINUA" id="LIC_CONTINUA" value="N"/>
			&nbsp;&nbsp;<span class="fuentePeq"><xsl:value-of select="document($doc)/translation/texts/item[@name='Licitacion_continua_expli']/node()"/></span>
	    </li>
		<li class="sinSeparador">
			<label><xsl:value-of select="document($doc)/translation/texts/item[@name='Licitacion_urgente']/node()"/>:</label>
			<xsl:choose>
			<xsl:when test="/Mantenimiento/LICITACION/AUTOR">
				<xsl:choose>
				<xsl:when test="/Mantenimiento/LICITACION/LIC_URGENTE='S'">
					<input type="checkbox" class="muypeq" name="CHK_LIC_URGENTE" id="CHK_LIC_URGENTE" checked="checked"/>
				</xsl:when>
				<xsl:otherwise>
					<input type="checkbox" class="muypeq" name="CHK_LIC_URGENTE" id="CHK_LIC_URGENTE" unchecked="unchecked"/>
				</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise>
				<xsl:choose>
				<xsl:when test="/Mantenimiento/LICITACION/LIC_URGENTE='S'">
					<input type="checkbox" class="muypeq" name="CHK_LIC_URGENTE" id="CHK_LIC_URGENTE" checked="checked" disabled="disabled"/>
				</xsl:when>
				<xsl:otherwise>
					<input type="checkbox" class="muypeq" name="CHK_LIC_URGENTE" id="CHK_LIC_URGENTE" unchecked="unchecked" disabled="disabled"/>
				</xsl:otherwise>
				</xsl:choose>
			</xsl:otherwise>
			</xsl:choose>
			<input type="hidden" name="LIC_URGENTE" id="LIC_URGENTE" value="N"/>
            &nbsp;&nbsp;<span class="fuentePeq"><xsl:value-of select="document($doc)/translation/texts/item[@name='Licitacion_urgente_expli']/node()"/></span>
	    </li>
		<!--	nuevos campos 17jun20	-->
		<xsl:if test="/Mantenimiento/LICITACION/IDPAIS = 55 or /Mantenimiento/NUEVALICITACION/IDPAIS = 55">
			<li class="sinSeparador">
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='Frete_CIF_obligatorio']/node()"/>:</label>
				<xsl:choose>
				<xsl:when test="/Mantenimiento/LICITACION/LIC_FRETECIFOBLIGATORIO='S'">
					<input type="checkbox" class="muypeq" name="CHK_LIC_FRETECIFOBLIGATORIO" id="CHK_LIC_FRETECIFOBLIGATORIO" checked="checked"/>
				</xsl:when>
				<xsl:otherwise>
					<input type="checkbox" class="muypeq" name="CHK_LIC_FRETECIFOBLIGATORIO" id="CHK_LIC_FRETECIFOBLIGATORIO" unchecked="unchecked"/>
				</xsl:otherwise>
				</xsl:choose>
				<input type="hidden" name="LIC_FRETECIFOBLIGATORIO" id="LIC_FRETECIFOBLIGATORIO" value="N"/>
                &nbsp;&nbsp;<span class="fuentePeq"><xsl:value-of select="document($doc)/translation/texts/item[@name='Frete_CIF_obligatorio_expli']/node()"/></span>
	        </li>
			<li class="sinSeparador">
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='Pago_aplazado_obligatorio']/node()"/>:</label>
				<xsl:choose>
				<xsl:when test="/Mantenimiento/LICITACION/LIC_PAGOAPLAZADOOBLIGATORIO='S'">
					<input type="checkbox" class="muypeq" name="CHK_LIC_PAGOAPLAZODOOBLIGATORIO" id="CHK_LIC_PAGOAPLAZODOOBLIGATORIO" checked="checked"/>
				</xsl:when>
				<xsl:otherwise>
					<input type="checkbox" class="muypeq" name="CHK_LIC_PAGOAPLAZODOOBLIGATORIO" id="CHK_LIC_PAGOAPLAZODOOBLIGATORIO" unchecked="unchecked"/>
				</xsl:otherwise>
				</xsl:choose>
				<input type="hidden" name="LIC_PAGOAPLAZODOOBLIGATORIO" id="LIC_PAGOAPLAZODOOBLIGATORIO" value="N"/>
                &nbsp;&nbsp;<span class="fuentePeq"><xsl:value-of select="document($doc)/translation/texts/item[@name='Pago_aplazado_obligatorio_expli']/node()"/></span>
	        </li>
		</xsl:if>
		<li class="sinSeparador">
			<label><xsl:value-of select="document($doc)/translation/texts/item[@name='Precio_objetivo_obligatorio']/node()"/>:</label>
			<xsl:choose>
			<xsl:when test="/Mantenimiento/LICITACION/LIC_PRECIOOBJETIVOESTRICTO='S'">
				<input type="checkbox" class="muypeq" name="CHK_LIC_PRECIOOBJETIVOESTRICTO" id="CHK_LIC_PRECIOOBJETIVOESTRICTO" checked="checked"/>
			</xsl:when>
			<xsl:otherwise>
				<input type="checkbox" class="muypeq" name="CHK_LIC_PRECIOOBJETIVOESTRICTO" id="CHK_LIC_PRECIOOBJETIVOESTRICTO" unchecked="unchecked"/>
			</xsl:otherwise>
			</xsl:choose>
			<input type="hidden" name="LIC_PRECIOOBJETIVOESTRICTO" id="LIC_PRECIOOBJETIVOESTRICTO" value="N"/>
            &nbsp;&nbsp;<span class="fuentePeq"><xsl:value-of select="document($doc)/translation/texts/item[@name='Precio_objetivo_obligatorio_expli']/node()"/></span>
	    </li>
		<!--	nuevos campos 17jun20	-->
        <li class="sinSeparador">
			<label><xsl:value-of select="document($doc)/translation/texts/item[@name='meses_duracion']/node()"/>:</label>
			<xsl:choose>
			<xsl:when test="/Mantenimiento/LICITACION/AUTOR">
				<xsl:call-template name="desplegable">
					<xsl:with-param name="path" select="/Mantenimiento/LICITACION/LIC_MESES/field"/>
					<xsl:with-param name="claSel">w200px</xsl:with-param>
					<xsl:with-param name="onChange">javascript:camposLicitacionSpot();</xsl:with-param>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="desplegable">
					<xsl:with-param name="path" select="/Mantenimiento/LICITACION/LIC_MESES/field"/>
					<xsl:with-param name="disabled">disabled</xsl:with-param>
					<xsl:with-param name="claSel">w200px</xsl:with-param>
				</xsl:call-template>
			</xsl:otherwise>
			</xsl:choose>
        </li>
		<!--	Campos avanzados para el autor	 class="campoPedidoPuntual_Inv"	-->
		<xsl:if test="/Mantenimiento/LICITACION/AUTOR">
			<xsl:if test="/Mantenimiento/LICITACION/IDPAIS != 55">
            	<li class="sinSeparador campoPedidoPuntual_Inv">
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_adjudicacion']/node()"/>:</label>
					<input type="text" class="campopesquisa w150px" name="LIC_FECHAADJUDICACION" id="LIC_FECHAADJUDICACION" value="{Mantenimiento/LICITACION/LIC_FECHAADJUDICACION}" size="15" maxlength="10"/>
					&nbsp;<span class="fuentePeq"><xsl:value-of select="document($doc)/translation/texts/item[@name='formato_fecha']/node()"/></span>
            	</li>
			</xsl:if>
            <li class="sinSeparador campoPedidoPuntual">
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='usuario']/node()"/>:</label>
				<select name="LIC_IDUSUARIOPEDIDO" id="LIC_IDUSUARIOPEDIDO" style="width:540px;"  onChange="javascript:CambioUsuarioPedido();">
					<option value=""><xsl:value-of select="document($doc)/translation/texts/item[@name='selecciona']/node()"/></option>
					<xsl:for-each select="/Mantenimiento/LICITACION/field[@name='IDUSUARIOPEDIDO']/dropDownList/listElem">
						<option value="{ID}">
							<xsl:if test="ID = ../../SelectedElement"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>
							<xsl:value-of select="listItem"/>
						</option>
					</xsl:for-each>
				</select>
            </li>
            <li class="sinSeparador campoPedidoPuntual">
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='lugar_entrega']/node()"/>:</label>
				<select name="LIC_IDLUGARENTREGA" id="LIC_IDLUGARENTREGA" class="w300px">
					<option value=""><xsl:value-of select="document($doc)/translation/texts/item[@name='selecciona']/node()"/></option>
					<xsl:for-each select="/Mantenimiento/LICITACION/field[@name='IDLUGARENTREGA']/dropDownList/listElem">
						<option value="{ID}">
							<xsl:if test="ID = ../../SelectedElement"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>
							<xsl:value-of select="listItem"/>
						</option>
					</xsl:for-each>
				</select>
            </li>
			<input type="hidden" name="LIC_IDFORMAPAGO" id="LIC_IDFORMAPAGO" value=""/>
			<input type="hidden" name="LIC_IDPLAZOPAGO" id="LIC_IDPLAZOPAGO" value=""/>
            <li class="sinSeparador campoPedidoPuntual">
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='codigo_pedido']/node()"/>:</label>
				<input type="text" class="campopesquisa w150px" id="LIC_CODIGOPEDIDO" name="LIC_CODIGOPEDIDO" value="{/Mantenimiento/LICITACION/LIC_CODIGOPEDIDO}"/>
            </li>
            <li class="sinSeparador campoPedidoPuntual">
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_entrega_programada']/node()"/>:</label>
				<input type="text" class="campopesquisa w150px" id="LIC_FECHAENTREGAPEDIDO" name="LIC_FECHAENTREGAPEDIDO" value="{/Mantenimiento/LICITACION/LIC_FECHAENTREGAPEDIDO}"/>
				&nbsp;<span class="fuentePeq"><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_entrega_expli']/node()"/></span>
            </li>
            <li class="sinSeparador campoPedidoPuntual">
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='observaciones_pedido']/node()"/>:</label>
				<textarea id="LIC_OBSPEDIDO" name="LIC_OBSPEDIDO" rows="4" cols="120">
					<xsl:value-of select="/Mantenimiento/LICITACION/LIC_COMENTARIOSPEDIDO"/>
                </textarea>
            </li>
			<!--
            <li class="sinSeparador">
				<label>&nbsp;</label>
				<a class="btnDestacado" href="javascript:ValidarFormulario(document.forms['form1'],'datosGenerales');">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='guardar']/node()"/>
				</a>
				<a class="btnNormal" href="javascript:ComprobarDatosGenerales(document.forms['form1']);" title="Volver">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='cancelar']/node()"/>
				</a>
            </li>
			-->
			<input type="hidden" name="LIC_DESCRIPCION_OLD" value="{/Mantenimiento/LICITACION/LIC_DESCRIPCION}"/>
			<input type="hidden" name="LIC_CONDENTREGA_OLD" value="{/Mantenimiento/LICITACION/LIC_CONDICIONESENTREGA}"/>
			<input type="hidden" name="LIC_CONDPAGO_OLD" value="{/Mantenimiento/LICITACION/LIC_CONDICIONESPAGO}"/>
			<input type="hidden" name="LIC_CONDOTRAS_OLD" value="{/Mantenimiento/LICITACION/LIC_OTRASCONDICIONES}"/>
			<input type="hidden" name="LIC_MESES_OLD" value="{/Mantenimiento/LICITACION/LIC_MESESDURACION}"/>
		</xsl:if>
	 </ul>
		<br/>
		<br/>
		<br/>
		<br/>
		<br/>
		<br/>
		<br/>
		<br/>
</div>
</form>
</xsl:template>
<!-- FIN Tabla Datos Generales Autor -->

</xsl:stylesheet>
