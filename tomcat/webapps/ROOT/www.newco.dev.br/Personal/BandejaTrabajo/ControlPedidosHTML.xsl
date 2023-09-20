<?xml version="1.0" encoding="iso-8859-1" ?>
<!--
    Ficha de control de pedido
	Ultima revision: ET 3jun22 10:35 ControlPedidos_141220.js cargaDocAlbaran_251019.js
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href = "http://www.newco.dev.br/General/General.xsl" /> 
  <xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
  <xsl:template match="/">
    <html> 
      <head> 
       <!--style-->
      <xsl:call-template name="estiloIndip"/>
      <!--fin de style-->

			<!--idioma-->
			<xsl:variable name="lang">
    			<xsl:value-of select="/ControlPedidos/LANG" />
			</xsl:variable>
			<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
			<!--idioma fin-->

			<script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
			<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>
			<script type="text/javascript" src="http://www.newco.dev.br/General/stringFormatEncode.js"></script>
			<script type="text/javascript" src="http://www.newco.dev.br/Personal/BandejaTrabajo/ControlPedidos_141220.js"></script>
			<script type="text/javascript" src="http://www.newco.dev.br/Personal/BandejaTrabajo/cargaDocAlbaran_251019.js"></script><!--usado tb en bandeja inicio wfstatus-->
			<script type="text/javascript">
			var strFechaErrorGuardando='<xsl:value-of select="document($doc)/translation/texts/item[@name='error_guardar_fecha']/node()"/>';
			var strFechaGuardadaCorrectamente='<xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_guardada_exito']/node()"/>';
			</script>
			<title>
				<xsl:value-of select="ControlPedidos/PEDIDO/NOMBRE_CENTRO"/>:&nbsp;<xsl:value-of select="ControlPedidos/PEDIDO/NUMERO_PEDIDO"/> a <xsl:value-of select="ControlPedidos/PEDIDO/NOMBRE_PROVEEDOR"/>
			</title>
      </head>
      <body onload="javascript:RecuperoCheck({ControlPedidos/PEDIDO/SITUACION});">
        <xsl:choose>
           <xsl:when test="//SESION_CADUCADA">
             <xsl:apply-templates select="//SESION_CADUCADA"/>
           </xsl:when>
           <xsl:when test="//xsql-error">
             <xsl:apply-templates select="//xsql-error"/>
           </xsl:when>
           <xsl:when test="//Status">
             <xsl:apply-templates select="//Status"/>         
           </xsl:when>
          <xsl:otherwise>
			<xsl:apply-templates select="ControlPedidos/PEDIDO"/>         	
          </xsl:otherwise>
       </xsl:choose> 
       
       <div id="uploadFrame" style="display:none;"><iframe src="" id="uploadFrame" name="uploadFrame" style="width: 100%;"></iframe></div>
       <div id="uploadFrameBoxDoc" style="display:none;"><iframe src="" id="uploadFrameDoc" name="uploadFrameDoc" style="width: 100%;"></iframe></div>
      </body>
    </html>
  </xsl:template>

<!--
 |  Templates
 +-->

<xsl:template match="PEDIDO">

	<!--idioma-->
	<xsl:variable name="lang">
    	<xsl:value-of select="../LANG" />
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->
      
	<form method="post" name="Cabecera" id="Cabecera" action="ControlPedidos.xsql">
		<input type="hidden" name="SOLO_COMENTARIOS_PARA_CLINICA" value="?" />
        <input type="hidden" name="SOLO_ACCION" value="?" />
		<input type="hidden" name="IDEMPRESA" value="{IDCLIENTE}" />
		<input type="hidden" name="IDCENTRO" value="{IDCENTROCLIENTE}" />
		<input type="hidden" name="IDPROVEEDOR" value="{IDPROVEEDOR}" />
		<input type="hidden" name="IDFILTROMOTIVO" value="{/ControlPedidos/IDFILTROMOTIVO}" />
		<input type="hidden" name="IDPEDIDO" value="{PED_ID}" />
		<input type="hidden" name="MO_ID" value="{MO_ID}" />
		<input type="hidden" name="ELIMINAR_ENTRADA" value="NO_ELIMINAR" />
        <input type="hidden" name="ELIMINAR_COME_PROVE" value="NO_ELIMINAR" />
        <input type="hidden" name="ACCION" id="ACCION" value="" />

		<input type="hidden" name="NUMEROPEDIDO" value="{NUMERO_PEDIDO}" />
		<input type="hidden" name="NOMBRECENTRO" value="{NOMBRE_CENTRO}" />
		<input type="hidden" name="NOMBREPROVEEDOR" value="{NOMBRE_PROVEEDOR}" />
		<input type="hidden" name="FECHAENTREGA" value="{FECHA_ENTREGA}" />
		<input type="hidden" name="ESTADO" value="{ESTADO}" />
		<input type="hidden" name="IDNUEVOCOMPRADOR"/>
		<input type="hidden" name="IDNUEVOVENDEDOR"/>
 		<input type="hidden" name="IDNUEVOGESTOR"/>
      
        <!--subir documentos-->
        <input type="hidden" name="CADENA_DOCUMENTOS" />
        <input type="hidden" name="DOCUMENTOS_BORRADOS"/>
        <input type="hidden" name="BORRAR_ANTERIORES"/>
        <input type="hidden" name="ID_USUARIO" value="{/ControlPedidos/PEDIDO/IDUSUARIO}" />
        <input type="hidden" name="TIPO_DOC" value="ALBARAN"/>
        <input type="hidden" name="CHANGE_PROV"/>
        <input type="hidden" name="DOC_DESCRI" />
        <input type="hidden" name="REMOVE" value="{document($doc)/translation/texts/item[@name='remove']/node()}"/>

        <input type="hidden" id="textoConfirmPDFCliente" value="{document($doc)/translation/texts/item[@name='desea_enviar_pdf_cliente']/node()}"/>
        <input type="hidden" id="textoConfirmPDFProveedor" value="{document($doc)/translation/texts/item[@name='desea_enviar_pdf_prov']/node()}"/>

	
		<!--	Titulo de la página		-->
		<div class="ZonaTituloPagina">
			<p class="Path">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='Inicio']/node()"/>&nbsp;/&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Pedidos']/node()"/>&nbsp;/&nbsp;<span class="FinPath"><xsl:value-of select="document($doc)/translation/texts/item[@name='control_pedidos']/node()"/></span>
				<span class="CompletarTitulo">
					<xsl:if test="SITUACION>=0">
					<img src="../../images/Situacion{SITUACION}de3.gif"/>&nbsp;
					</xsl:if>
					<xsl:value-of select="ESTADO"/>&nbsp;
            		<xsl:choose>
            		<xsl:when test="RETRASADO = 'S'"><span style="background:#F9B247;padding:2px 4px;"><xsl:value-of select="document($doc)/translation/texts/item[@name='entregado_con_retraso']/node()"/>:&nbsp;<xsl:value-of select="PED_RETRASOACUMULADO"/>&nbsp;</span></xsl:when>
            		<xsl:when test="MO_STATUS!=25 and PED_ENTREGADOPARCIAL = 'S'"><span style="background:#F9B247;padding:2px 4px;"><xsl:value-of select="document($doc)/translation/texts/item[@name='entregado_parcialmente']/node()"/></span></xsl:when>
            		</xsl:choose>
					&nbsp;<span style="padding:5px; font-weight:bold;" class="amarillo">MO_ID: <xsl:value-of select="MO_ID"/></span>
				</span>
			</p>
			<p class="TituloPagina">
                <a style="font-size:20px;">
                    <xsl:attribute name="href">javascript:MostrarPag('http://www.newco.dev.br/<xsl:value-of select="ENLACETAREA"/>','Multioferta')</xsl:attribute>
                    <xsl:value-of select="NUMERO_PEDIDO"/>
                </a>&nbsp;<xsl:value-of select="NOMBRE_CENTRO"/>
				<span class="CompletarTitulo" style="width:800px;">
					<a class="btnDestacado" href="javascript:EnviarTodo();" title="{document($doc)/translation/texts/item[@name='guardar']/node()}">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='guardar']/node()"/>
					</a>&nbsp;
					<xsl:if test="/ControlPedidos/PEDIDO/BOTON_PEDIDO_RECIBIDO">
						<a class="btnDestacado" href="javascript:PedidoRecibido();" title="{document($doc)/translation/texts/item[@name='pedido_recibido']/node()}">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='pedido_recibido']/node()"/>
						</a>&nbsp;
					</xsl:if>
					<a class="btnNormal">
						<xsl:attribute name="href">javascript:EnviarPDF('<xsl:value-of select="MO_ID"/>','CLIENTE');</xsl:attribute>
						<xsl:value-of select="document($doc)/translation/texts/item[@name='enviar_pdf_cliente']/node()"/>
					</a>&nbsp;
					<a class="btnNormal">
						<xsl:attribute name="href">javascript:EnviarPDF('<xsl:value-of select="MO_ID"/>','PROVEE');</xsl:attribute>
						<xsl:value-of select="document($doc)/translation/texts/item[@name='enviar_pdf_provee']/node()"/>
					</a>&nbsp;
					<!--	Nuevos botones parametrizados	-->
					<xsl:for-each select="/ControlPedidos/PEDIDO/BOTONES_MENSAJE/BOTON_MENSAJE">
						<a class="btnNormal">
							<xsl:attribute name="href">javascript:MensajeParametrizado('<xsl:value-of select="ID"/>');</xsl:attribute>
							<xsl:value-of select="TITULO"/>
						</a>&nbsp;
					</xsl:for-each>
				</span>
			</p>
		</div>
		<br/>
        <table class="buscador">
   			<tr class="sinLinea">
				<td class="labelRight diez">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='Requiere_prepago']/node()"/>:&nbsp;
				</td>
				<td class="datosLeft">
					<span style="background:#F9B247;padding:2px 4px;">
					<a id="Prepago" href="javascript:marcarPrepago();">
        			<xsl:choose>
        			<xsl:when test="PED_REQUIEREPREPAGO = 'S'">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='si']/node()"/>
						<xsl:if test="PED_FECHAPREPAGO != ''">
							&nbsp;(<xsl:value-of select="document($doc)/translation/texts/item[@name='Pagado']/node()"/>:&nbsp;<xsl:value-of select="PED_FECHAPREPAGO"/>)
						</xsl:if>
					</xsl:when>
        			<xsl:otherwise>
						<xsl:value-of select="document($doc)/translation/texts/item[@name='no']/node()"/>
					</xsl:otherwise>
        			</xsl:choose>
					</a></span>&nbsp;
					<img id="imgPrepagoKO" src="http://www.newco.dev.br/images/error.gif" style="vertical-align:text-bottom;display:none;"/>
                	<input type="hidden" name="PED_REQUIEREPREPAGO" value="{PED_REQUIEREPREPAGO}" />
				</td>
				<td class="datosLeft" width="50%">&nbsp;</td>
				<td class="datosLeft">
					<strong><a class="btnNormal" href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Compras/Multioferta/MODocs.xsql?ORIGEN=CONTROL&amp;MO_ID={/ControlPedidos/PEDIDO/MO_ID}');"><xsl:value-of select="document($doc)/translation/texts/item[@name='documentos']/node()"/></a></strong>
					&nbsp;&nbsp;
						<xsl:if test="/ControlPedidos/PEDIDO/DOCUMENTOS/DOCUMENTOS_COMPRADOR/DOCUMENTO">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='cliente']/node()"/>:
						<xsl:for-each select="/ControlPedidos/PEDIDO/DOCUMENTOS/DOCUMENTOS_COMPRADOR/DOCUMENTO">
							&nbsp;<a>
								<xsl:attribute name="href">javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Documentos/<xsl:value-of select="URL"/>','Documentos',100,80,0,0);</xsl:attribute>
								<xsl:value-of select="CONTADOR"/>
							</a>&nbsp;
						</xsl:for-each>
					</xsl:if>
					<xsl:if test="/ControlPedidos/PEDIDO/DOCUMENTOS/DOCUMENTOS_VENDEDOR/DOCUMENTO">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/>:
						<xsl:for-each select="/ControlPedidos/PEDIDO/DOCUMENTOS/DOCUMENTOS_VENDEDOR/DOCUMENTO">
							&nbsp;<a>
								<xsl:attribute name="href">javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Documentos/<xsl:value-of select="URL"/>','Documentos',100,80,0,0);</xsl:attribute>
								<xsl:value-of select="CONTADOR"/>
							</a>&nbsp;
						</xsl:for-each>
					</xsl:if>
				</td>
			</tr>
		</table>
		<br/>
	
        <div class="divLeft">
        <table class="buscador">
   			<tr class="sinLinea">
            	<td class="uno">&nbsp;</td>
				<td class="labelRight diez"><xsl:value-of select="document($doc)/translation/texts/item[@name='clinica']/node()"/>:&nbsp;</td>
                <td class="datosLeft veinte">
                	<a>
                    <xsl:attribute name="href">javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPDetalleFrame.xsql?EMP_ID=<xsl:value-of select="DATOSCLIENTE/EMP_ID"/>&amp;VENTANA=NUEVA','Centro',100,80,0,0);</xsl:attribute>
                    <xsl:value-of select="NOMBRE_CENTRO"/></a>
                </td>
                <td class="labelRight diez"><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/>:&nbsp;</td>
                <td class="datosLeft veinte">
                	<a>
                    <xsl:attribute name="href">javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPDetalleFrame.xsql?EMP_ID=<xsl:value-of select="DATOSPROVEEDOR/EMP_ID"/>&amp;VENTANA=NUEVA','Centro',100,80,0,0);</xsl:attribute>
                    <xsl:value-of select="NOMBRE_PROVEEDOR"/>
                    </a>
                </td> 
                <td class="labelRight diez"><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha']/node()"/>:&nbsp;</td>
                <td class="datosLeft quince"><xsl:value-of select="FECHA_PEDIDO"/></td>
			</tr>
   			<tr class="sinLinea">
            	<td>&nbsp;</td>
				<td class="labelRight" valign="top"><xsl:value-of select="document($doc)/translation/texts/item[@name='autor']/node()"/>:&nbsp;</td>
                <td class="datosLeft" valign="top">
                
                	<!--<xsl:value-of select="COMPRADOR/NOMBRE"/>&nbsp;-->
					<xsl:call-template name="desplegable">
        				<xsl:with-param name="path" select="COMPRADOR/field"/>
        				<xsl:with-param name="onChange">javascript:CambioComprador();</xsl:with-param>
      				</xsl:call-template>	&nbsp;			
                    <a class="btnDestacadoPeq" id="btnGuardarComprador" href="javascript:GuardarComprador();" style="display:none"><xsl:value-of select="document($doc)/translation/texts/item[@name='guardar']/node()"/></a>
                   	<img id="imgCompradorOK" src="http://www.newco.dev.br/images/check.gif" style="vertical-align:text-bottom;display:none;"/>
					<img id="imgCompradorKO" src="http://www.newco.dev.br/images/error.gif" style="vertical-align:text-bottom;display:none;"/>
				    &nbsp;<a href="javascript:MailEstimados('{COMPRADOR/EMAIL}','COMPRADOR');"><img src="http://www.newco.dev.br/images/mail.gif" alt="Enviar Mail" title="Enviar Mail" style="vertical-align:middle;" /></a>
					<br />
                    <xsl:value-of select="document($doc)/translation/texts/item[@name='fijo']/node()"/>: <xsl:value-of select="COMPRADOR/FIJO"/>&nbsp;
                    <xsl:if test="COMPRADOR/MOVIL != ''">
                    <xsl:value-of select="document($doc)/translation/texts/item[@name='movil']/node()"/>: <xsl:value-of select="COMPRADOR/MOVIL"/><br />
                    </xsl:if>
                </td>
                <td class="labelRight" valign="top"><xsl:value-of select="document($doc)/translation/texts/item[@name='vendedor']/node()"/>:&nbsp;</td>
                <td class="datosLeft" valign="top">
                	<!--<xsl:value-of select="VENDEDOR/NOMBRE"/>&nbsp;-->
					<xsl:call-template name="desplegable">
        				<xsl:with-param name="path" select="VENDEDOR/field"/>
        				<xsl:with-param name="onChange">javascript:CambioVendedor();</xsl:with-param>
      				</xsl:call-template>&nbsp;
					<span id="spDatosVendedor"  style="display:none;">
					<input type="checkbox" class="muypeq" name="cbTodos"/><xsl:value-of select="document($doc)/translation/texts/item[@name='todos']/node()"/>&nbsp;
                    <a class="btnDestacadoPeq" id="btnGuardarVendedor" href="javascript:GuardarVendedor();"><xsl:value-of select="document($doc)/translation/texts/item[@name='guardar']/node()"/></a>
                   	</span>
					<img id="imgVendedorOK" src="http://www.newco.dev.br/images/check.gif" style="vertical-align:text-bottom;display:none;"/>
					<img id="imgVendedorKO" src="http://www.newco.dev.br/images/error.gif" style="vertical-align:text-bottom;display:none;"/>
                    &nbsp;<a href="javascript:MailEstimados('{VENDEDOR/EMAIL}','VENDEDOR');"><img src="http://www.newco.dev.br/images/mail.gif" alt="Enviar Mail" title="Enviar Mail" style="vertical-align:middle;" /></a>
					<br />
                    <xsl:value-of select="document($doc)/translation/texts/item[@name='fijo']/node()"/>:&nbsp;<xsl:value-of select="VENDEDOR/FIJO"/>&nbsp;
                    <xsl:if test="VENDEDOR/MOVIL != ''">
                    <xsl:value-of select="document($doc)/translation/texts/item[@name='movil']/node()"/>:&nbsp;<xsl:value-of select="VENDEDOR/MOVIL"/><br />
                    </xsl:if>
                </td> 
                <td class="labelRight dies"><xsl:value-of select="document($doc)/translation/texts/item[@name='Aprobacion']/node()"/>:&nbsp;</td>
                <td class="datosLeft">
					<xsl:if test="FECHA_APROBACION != ''">
						<xsl:value-of select="FECHA_APROBACION"/>&nbsp;(<xsl:value-of select="USUARIO_APROBADOR"/>)
					</xsl:if>
				&nbsp;
				</td>
			</tr>
            <tr class="sinLinea">
            	<td>&nbsp;</td>
				<td class="labelRight"> <xsl:value-of select="document($doc)/translation/texts/item[@name='datos_acceso']/node()"/>:&nbsp;</td>
                <td class="datosLeft">
                	<xsl:value-of select="COMPRADOR/USUARIO"/><!--&nbsp;|&nbsp;
                    <xsl:value-of select="COMPRADOR/CLAVE"/>-->
                </td>
                
                <td class="labelRight"> <xsl:value-of select="document($doc)/translation/texts/item[@name='datos_acceso']/node()"/>:&nbsp;</td>
                <td class="datosLeft">
                	<xsl:value-of select="VENDEDOR/USUARIO"/><!--&nbsp;|&nbsp;
                    <xsl:value-of select="VENDEDOR/CLAVE"/>-->
                </td> 
                <td class="labelRight dies"><xsl:value-of select="document($doc)/translation/texts/item[@name='Aceptacion']/node()"/>:&nbsp;</td>
                <td class="datosLeft"><xsl:value-of select="FECHA_ACEPTACION"/></td>
			</tr>
            <tr class="sinLinea">
				<td>&nbsp;</td>
				<td class="labelRight" valign="top"><xsl:value-of select="document($doc)/translation/texts/item[@name='gestor']/node()"/>:&nbsp;</td>
                <td class="datosLeft" valign="top">
					<xsl:call-template name="desplegable">
        				<xsl:with-param name="path" select="GESTOR/field"/>
        				<xsl:with-param name="onChange">javascript:CambioGestor();</xsl:with-param>
      				</xsl:call-template>	&nbsp;			
                    <a class="btnDestacadoPeq" id="btnGuardarGestor" href="javascript:GuardarGestor();" style="display:none"><xsl:value-of select="document($doc)/translation/texts/item[@name='guardar']/node()"/></a>
                   	<img id="imgGestorOK" src="http://www.newco.dev.br/images/check.gif" style="vertical-align:text-bottom;display:none;"/>
					<img id="imgGestorKO" src="http://www.newco.dev.br/images/error.gif" style="vertical-align:text-bottom;display:none;"/>
				    &nbsp;<a href="javascript:MailEstimados('{GESTOR/EMAIL}','GESTOR');"><img src="http://www.newco.dev.br/images/mail.gif" alt="Enviar Mail" title="Enviar Mail" style="vertical-align:middle;" /></a>
					<br />
                    <xsl:value-of select="document($doc)/translation/texts/item[@name='fijo']/node()"/>: <xsl:value-of select="GESTOR/FIJO"/>&nbsp;
                    <xsl:if test="GESTOR/MOVIL != ''">
                    <xsl:value-of select="document($doc)/translation/texts/item[@name='movil']/node()"/>: <xsl:value-of select="GESTOR/MOVIL"/><br />
                    </xsl:if>
                </td>
                <!--delegados-->
                <xsl:choose>
                <xsl:when test="count(DELEGADOS/DELEGADO) &gt; 0">
                <td class="labelRight" valign="top">
                    <xsl:value-of select="document($doc)/translation/texts/item[@name='delegados']/node()"/>:&nbsp;</td>
                <td class="datosLeft" valign="top">
                	<xsl:for-each select="DELEGADOS/DELEGADO">
                        <p class="separation">
                        <xsl:value-of select="NOMBRE"/>&nbsp;
                        <xsl:value-of select="ZONA"/>&nbsp;
                    
                       <a href="javascript:MailEstimados('{EMAIL}','DELEGADO_VEND');">
                       <img src="http://www.newco.dev.br/images/mail.gif" alt="Enviar Mail" title="Enviar Mail" style="vertical-align:middle;" /></a>
                        <br /> 
                       <xsl:value-of select="document($doc)/translation/texts/item[@name='fijo']/node()"/>:&nbsp;<xsl:value-of select="FIJO"/>&nbsp;
                        <xsl:if test="MOVIL != ''">
                        <xsl:value-of select="document($doc)/translation/texts/item[@name='movil']/node()"/>:&nbsp;<xsl:value-of select="MOVIL"/>
                        </xsl:if>
                        <br />
                        </p>
                    </xsl:for-each>
                </td>
                </xsl:when>
                <xsl:otherwise>
                   <td>&nbsp;</td>
                   <td>&nbsp;</td>
                </xsl:otherwise>
                </xsl:choose>

                
                <td class="labelRight"> <xsl:value-of select="document($doc)/translation/texts/item[@name='entrega_prevista']/node()"/>:&nbsp;</td>
                <!--13ene20<td class="datosLeft"><xsl:value-of select="FECHA_ENTREGA" />&nbsp;</td>-->
                <td class="datosLeft">
					<input type="text" class="peq" name="FECHA_ENTREGA" id="FECHA_ENTREGA" value="{FECHA_ENTREGA}" size="10"/>&nbsp;
                	<a href="javascript:ActFechaEntrega('SOLICITADA');"><img src="http://www.newco.dev.br/images/actualizarFlecha.gif" alt="Actualizar" /></a>&nbsp;
				</td>
               
            </tr>
            <tr class="sinLinea" style="height:5px;">
            	<td>&nbsp;</td>
				<td colspan="2">
					<xsl:call-template name="desplegable">
        				<xsl:with-param name="path" select="FORMASPAGO/field"/>
        				<xsl:with-param name="onChange">javascript:CambioFormaPago();</xsl:with-param>
      				</xsl:call-template>&nbsp;
					<xsl:call-template name="desplegable">
        				<xsl:with-param name="path" select="PLAZOSPAGO/field"/>
        				<xsl:with-param name="onChange">javascript:CambioFormaPago();</xsl:with-param>
      				</xsl:call-template>&nbsp;
					<span id="spFormaPago"  style="display:none;">
					<!--<input type="checkbox" class="muypeq" name="cbFormaPagoTodos"/><xsl:value-of select="document($doc)/translation/texts/item[@name='todos']/node()"/>&nbsp;-->
                    <a class="btnDestacadoPeq" id="btnGuardarFormaPago" href="javascript:GuardarFormaPago();"><xsl:value-of select="document($doc)/translation/texts/item[@name='guardar']/node()"/></a>
                   	</span>
					<img id="imgFormaPagoOK" src="http://www.newco.dev.br/images/check.gif" style="vertical-align:text-bottom;display:none;"/>
					<img id="imgFormaPagoKO" src="http://www.newco.dev.br/images/error.gif" style="vertical-align:text-bottom;display:none;"/>
				</td>
				<td colspan="2"></td>
			                
                 <!--fecha entrega real enseño solo si 1,2 o 3 verdes-->
                <td class="labelRight">
 					<xsl:choose>
                	<xsl:when test="PED_FECHACONFIRMACION!='' ">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_entrega_real']/node()"/>
               		</xsl:when>
                	<xsl:otherwise>
						<xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_entrega_prevista']/node()"/>
                	</xsl:otherwise>
                	</xsl:choose>:&nbsp;</td>
               <td class="datosLeft">
					<xsl:choose>
                	<xsl:when test="FECHA_ENTREGA_REAL !=''">
						<!--<xsl:value-of select="FECHA_ENTREGA_REAL" />&nbsp;&nbsp;-->
               		</xsl:when>
                	<xsl:otherwise>
						<xsl:value-of select="document($doc)/translation/texts/item[@name='No_informada']/node()"/>&nbsp;&nbsp;
                	</xsl:otherwise>
                	</xsl:choose>
					
					<input type="text" class="peq" name="FECHA_ENTREGA_REAL" id="FECHA_ENTREGA_REAL" value="{FECHA_ENTREGA_REAL}" size="10"/>&nbsp;
                	<a href="javascript:ActFechaEntrega('REAL');"><img src="http://www.newco.dev.br/images/actualizarFlecha.gif" alt="Actualizar" /></a>
                </td>
			</tr>
            <!--</xsl:if>-->
            <tr class="sinLinea" style="height:5px;"><td colspan="7"></td></tr>
		</table>
		</div><!--fin de divLeft-->
        
       <!--seguimiento mvm comentarios-->  
        <div class="divLeft marginTop15" style="padding-top:15px;">
        <!--comentarios globales-->
        <!--<div class="divleft70">-->
        <!--table class="grandeInicio" >--> 
        <table class="buscador" > 
        	<thead>
            <xsl:choose>
            <xsl:when test="count(CONTROL/ENTRADA) &gt; 0">
   			<tr class="subTituloTabla">
				<td class="uno"><xsl:value-of select="document($doc)/translation/texts/item[@name='pos']/node()"/></td>
				<td class="tres"><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha']/node()"/></td>
				<td class="tres"><xsl:value-of select="document($doc)/translation/texts/item[@name='responsable']/node()"/></td>
				<td class="tres">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='cliente']/node()"/>/<xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/></td>
				<td class="dos">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='sit']/node()"/>.</td>
                <td class="dos">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='enviado']/node()"/></td>
                <td class="dos">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='alb']/node()"/></td>
                <td class="dos">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='entr']/node()"/></td>
				<td class="tres">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='ok']/node()"/></td>
				<td><xsl:value-of select="document($doc)/translation/texts/item[@name='comentarios_internos']/node()"/></td>
				<td class="tres"><xsl:value-of select="document($doc)/translation/texts/item[@name='siguiente']/node()"/></td>
				<td class="tres"><xsl:value-of select="document($doc)/translation/texts/item[@name='accion']/node()"/></td>
				<td class="dos">&nbsp;</td>
				<!--	4mar19	COmentarios clínicas		-->
				<td colspan="4">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='comentarios_visibles_para_clinicas']/node()"/>
				</td>
			</tr>
            </xsl:when>
            <xsl:otherwise>
            <tr class="subTituloTabla">
				<td colspan="9"><xsl:value-of select="document($doc)/translation/texts/item[@name='ningun_control_realizado']/node()"/></td>
			</tr>
            </xsl:otherwise>
            </xsl:choose>
            </thead>
            <tbody>
        	<xsl:for-each select="CONTROL/ENTRADA">
   				<tr>
		            <xsl:if test="CONTADOR=1">
						<xsl:attribute name="class">fondoAmarillo</xsl:attribute>
					</xsl:if>
					<td><xsl:value-of select="CONTADOR"/></td>
					<td><xsl:value-of select="PCM_FECHA"/></td>
					<td><xsl:value-of select="PCM_USUARIO"/></td>
					<td><xsl:value-of select="PCM_INTERLOCUTOR"/></td>
					<td class="textLeft">
						<xsl:if test="PCM_SITUACION>=0">
						<img src="../../images/Situacion{PCM_SITUACION}de3.gif"/>&nbsp;
						</xsl:if>
                    </td>
					<td><xsl:if test="PCM_FECHAENVIO!=''">
                    	<a>
                        <xsl:attribute name="href">javascript:CopiarDatos('<xsl:value-of select="PCM_FECHAENVIO"/>','<xsl:value-of select="PCM_ALBARAN"/>');</xsl:attribute>							
                        	<xsl:value-of select="PCM_FECHAENVIO"/>
                        </a>
                        </xsl:if>
                    </td>
                    <td><xsl:if test="PCM_ALBARAN!=''"><xsl:value-of select="PCM_ALBARAN"/></xsl:if></td>
                    <td><xsl:if test="PCM_ENTREGADO='S'">S</xsl:if>
                    	<xsl:if test="PCM_ENTREGADO!='S'">N</xsl:if>
                    </td>
					
					<td>
                    	<xsl:choose>
							<xsl:when test="PCM_ACEPTASOLUCION='N'">
                                <img src="http://www.newco.dev.br/images/bolaRoja.gif"/>
							</xsl:when>
							<xsl:when test="PCM_ACEPTASOLUCION='S'">
								<img src="http://www.newco.dev.br/images/bolaVerde.gif"/>
							</xsl:when>
                            <xsl:when test="PCM_ACEPTASOLUCION='Z'">
								<img src="http://www.newco.dev.br/images/bolaAmbar.gif"/>
							</xsl:when>
						</xsl:choose>
                    </td>
					<td class="textLeft">&nbsp;<xsl:value-of select="PCM_COMENTARIOS"/></td>
					<td><xsl:value-of select="PCM_USUARIOSIGUIENTE"/></td>
					<td><xsl:value-of select="PCM_PROXIMAACCION"/></td>
					<td align="center"><a href="javascript:EliminarEntrada('{PCM_ID}');"><img src="http://www.newco.dev.br/images/2017/trash.png"/></a></td>
					<!--	4mar19	Comentarios clínicas		-->
					<td><xsl:value-of select="PCC_FECHA"/></td>
					<td>&nbsp;<xsl:value-of select="PCC_USUARIO"/>&nbsp;</td>
					<td class="textLeft"><xsl:value-of select="PCC_COMENTARIOS"/></td>
                    <td align="center"><a href="javascript:EliminarComentProve('{PCC_ID}');"><img src="http://www.newco.dev.br/images/2017/trash.png"/></a></td>
				</tr>
			</xsl:for-each>
            </tbody>
           <!--quitado 28-8-13 peticion de carla
            <xsl:if test="RETRASADO='N' and count(CONTROL/ENTRADA) &gt; 0">
            <tfoot>
            	<tr>
            	<td colspan="12" style="padding:4px 0px;">
					<a href="javascript:EliminarEntrada('TODAS');"><span class="rojoScuro"><xsl:value-of select="document($doc)/translation/texts/item[@name='este_pedido_no_es_problematico']/node()"/></span></a>
                </td>
                </tr>
            </tfoot>
           </xsl:if>-->
		</table>
        <!--</div> < ! - - fin de comenatarios seguimiento-->
        <!-- <div class="divLeft28"> 
		<table class="buscador"  style="border-left:1px solid #999999;width:28%;">
        <thead>
   			<tr class="subTituloTabla">
				<td colspan="4">
                	<xsl:choose>
                	<xsl:when test="count(COMENTARIOSCLINICAS/COMENTARIO) &gt; 0"><xsl:value-of select="document($doc)/translation/texts/item[@name='comentarios_visibles_para_clinicas']/node()"/></xsl:when>
                    <xsl:otherwise><xsl:value-of select="document($doc)/translation/texts/item[@name='no_comentarios_para_clinicas']/node()"/>
                    </xsl:otherwise>
                    </xsl:choose>
				</td>
			</tr>
            </thead>
        	<xsl:for-each select="COMENTARIOSCLINICAS/COMENTARIO">
   				<tr>
					<td><xsl:value-of select="PCC_FECHA"/></td>
					<td><xsl:value-of select="PCC_USUARIO"/></td>
					<td class="textLeft"><xsl:value-of select="PCC_COMENTARIOS"/></td>
                    <td align="center"><a href="javascript:EliminarComentProve('{PCC_ID}');"><img src="http://www.newco.dev.br/images/2017/trash.png"/></a></td>
				</tr>
			</xsl:for-each>
             <xsl:if test="RETRASADO='N' and count(COMENTARIOSCLINICAS/COMENTARIO) &gt; 0">
            
           </xsl:if>
		</table>
        </div><! - -fin de divLeft30 comentarios clinicas-->
        </div><!--fin de divleft id=controlRealizado-->
        
       <!--info proveedor-->  
       <div class="divLeft marginTop20" style="padding-top:20px;">
		
       <div class="divLeft40nopa">
       <!--<table class="infoTable incidencias" cellspacing="5" style="border:none;">-->
       <table class="buscador">
       		<!--<tr style="height:5px;"><td colspan="2"></td></tr>-->
			<input type="hidden" name="SEMAFORO" value="R"/>
   			<tr class="sinLinea">
				<!--<td class="labelRight dies grisMed">-->
				<td class="labelRight trenta">
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='autor']/node()"/>:&nbsp;</label>
				</td>
				<td class="datosLeft">
					<!--	28ago19
                    <select name="USUARIO" id="USUARIO">
                    	<option value="-1">
                    	<xsl:if test="PCM_USUARIO = '-1'"><xsl:attribute name="selected">true</xsl:attribute></xsl:if>
                    		* <xsl:value-of select="document($doc)/translation/texts/item[@name='seleccionar_responsable']/node()"/> *</option>
                            
                    	<xsl:for-each select="/ControlPedidos/PEDIDO/USUARIOSCONTROL/field/dropDownList/listElem">
                    		<xsl:choose>
                            <xsl:when test="ID = ../../@current"><option value="{ID}" selected="selected"><xsl:value-of select="listItem"/></option></xsl:when>
                            <xsl:otherwise><option value="{ID}"><xsl:value-of select="listItem"/></option></xsl:otherwise>
                            </xsl:choose>                          	
                        </xsl:for-each>
                    </select>
					-->
					<xsl:call-template name="desplegable">
        				<xsl:with-param name="path" select="/ControlPedidos/PEDIDO/USUARIOSCONTROL/field"/>
      				</xsl:call-template>				
				</td>
			</tr>
            <tr class="sinLinea">
            	<xsl:choose>
            	<xsl:when test="BLOQUEAR">
				<td class="labelRight grisMed">
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='bloquear_desbloquear']/node()"/>:&nbsp;</label>
				</td>
				<td class="datosLeft">
					<xsl:call-template name="desplegable">
        				<xsl:with-param name="path" select="BLOQUEAR/field"/>
      				</xsl:call-template>				
				</td>
                </xsl:when>
                <xsl:otherwise>
                	<td>&nbsp;</td>
                    <td class="datosLeft">
                	<strong><xsl:value-of select="document($doc)/translation/texts/item[@name='este_proveedor_no_se_puede_bloquear']/node()"/></strong>
                    </td>
                    
                </xsl:otherwise>
                </xsl:choose>
				
			</tr>
   			<tr class="sinLinea">
				<!--<td class="labelRight grisMed trenta">-->
				<td class="labelRight">
                	<label><xsl:value-of select="document($doc)/translation/texts/item[@name='interlocutor']/node()"/>:&nbsp;</label>
				<input type="hidden" name="PROVEEDOROCLIENTE" value="P" />
				</td>
                <!--SE VE INTERLOCUTOR DEL PROVEEDOR POR DEFECTO-->
				<td class="datosLeft" colspan="3" id="Interlocutor_Proveedor">
					<input type="text" name="INTERLOCUTOR" size="40" maxlength="50">
                    	<xsl:attribute name="value">
                        <xsl:choose>
                        <xsl:when test="CONTROL/ENTRADA">
                      
                        	<xsl:for-each select="CONTROL/ENTRADA">
                				<xsl:if test="position() = 1">
                                <xsl:choose>
                                <xsl:when test="PCM_USUARIO != 'PROV' and PCM_INTERLOCUTOR != '-' and PCM_INTERLOCUTOR != ''">
                                	<xsl:value-of select="PCM_INTERLOCUTOR"/>
                                </xsl:when>
                                <xsl:otherwise>
                            		<xsl:value-of select="../../VENDEDOR/NOMBRE"/>
                                </xsl:otherwise>
                                </xsl:choose>
                                </xsl:if>
                            </xsl:for-each>
                        </xsl:when>
                        <xsl:otherwise>
                        	<xsl:value-of select="VENDEDOR/NOMBRE"/>
                        </xsl:otherwise>
                        </xsl:choose>
                        </xsl:attribute>
                    </input>
				</td>
                <!--INTERLOCUTOR DEL CLIENTE-->
                <td class="datosLeft" colspan="3" id="Interlocutor_Cliente" style="display:none;">
					<input type="text" name="INTERLOCUTOR_CLI" size="40" maxlength="50">
                    	<xsl:attribute name="value">
                            	<xsl:value-of select="COMPRADOR/NOMBRE"/>
                        </xsl:attribute>
                    </input>
				</td>
               
			</tr>
			<!--<tr style="height:5px;"><td colspan="2"></td></tr>-->
			<input type="hidden" name="COSTE" value="10"/>
			</table>
            </div><!--fin de divLeft50-->
            
            <!--info proveedor |situacion=0:todo NO | situacion=1:enviado SI | situacin=2:albaran SI, enviado SI | situacion=3:entregado si, alb si, enviado si | situacion=-1:blanco sin datos-->
            <div class="divLeft60nopa">
            <!--<table id="Estado_Pedido_Proveedor" class="infoTable incidencias" border="0" style="border-collpse:separate;border:none;" cellspacing="5">-->
            <table id="Estado_Pedido_Proveedor" class="buscador">
                     <!--<tr style="height:5px;"><td colspan="4"></td></tr>-->
   					<tr class="sinLinea">
						<td class="labelRight trenta"><xsl:value-of select="document($doc)/translation/texts/item[@name='enviado_en_su_totalidad']/node()"/>:&nbsp;</td>
						<td class="datosLeft" style="width:130px;">
							<input type="checkbox" class="muypeq" name="CHK_ENVIADO" onclick="javascript:ControlChecks('ENVIADO','S'); ControlEnviado('S');"  />
							<xsl:value-of select="document($doc)/translation/texts/item[@name='si_maiu']/node()"/>
							&nbsp;&nbsp;
							<input type="checkbox" class="muypeq" name="CHK_NOENVIADO" onclick="javascript:ControlChecks('ENVIADO','N'); ControlEnviado('N');" />
							<xsl:value-of select="document($doc)/translation/texts/item[@name='no_maiu']/node()"/>
                        </td>
						<input type="hidden" name="ENVIADO" value="" />
						<td class="labelRight dieciocho"><div id="Texto_fecha_enviado" style="display:block;"><xsl:value-of select="document($doc)/translation/texts/item[@name='enviado_el']/node()"/>:&nbsp;</div><div id="Texto_fecha_enviara" style="display:none;"><xsl:value-of select="document($doc)/translation/texts/item[@name='enviado_el']/node()"/>:&nbsp;</div></td>
						<td class="datosLeft">
							<input type="text" class="peq" name="ENVIADO_CUANDO" size="10" maxlength="10">
                            <xsl:for-each select="CONTROL/ENTRADA">
                            	<xsl:if test="position() = 1 and PCM_USUARIO != 'PROV'">
                            	   <xsl:attribute name="value">
                                	   <xsl:if test="PCM_FECHAENVIO!=''"><xsl:value-of select="PCM_FECHAENVIO"/></xsl:if>
                            	   </xsl:attribute>
                            	</xsl:if>
                            </xsl:for-each>
                       		</input>
                       &nbsp;(dd/mm/aa)
						</td>
					</tr>
   					<tr class="sinLinea">
						<td class="labelRight" ><xsl:value-of select="document($doc)/translation/texts/item[@name='albaran_salida']/node()"/>:&nbsp;</td>
						<td class="datosLeft"><input type="checkbox" class="muypeq" name="CHK_CONFIRMADO" onclick="javascript:ControlChecks('CONFIRMADO','S');" /> 
                        <xsl:value-of select="document($doc)/translation/texts/item[@name='si_maiu']/node()"/>
						&nbsp;&nbsp;&nbsp;<input type="checkbox" class="muypeq" name="CHK_NOCONFIRMADO" onclick="javascript:ControlChecks('CONFIRMADO','N');" />
                         <xsl:value-of select="document($doc)/translation/texts/item[@name='no_maiu']/node()"/>
                        </td>
						<input type="hidden" name="CONFIRMADO" value="" />
						<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='albaran']/node()"/>:&nbsp;</td>
						<td class="datosLeft">
							<input type="text" name="ALBARAN" size="10" maxlength="50">
                                <xsl:if test="CONTROL/ENTRADA">
                                     <xsl:for-each select="CONTROL/ENTRADA">
                                     <xsl:if test="position() = 1 and PCM_USUARIO != 'PROV'">
                                        <xsl:attribute name="value">
                                            <xsl:if test="PCM_ALBARAN!=''"><xsl:value-of select="PCM_ALBARAN"/></xsl:if>
                                        </xsl:attribute>
                                     </xsl:if>
                                     </xsl:for-each>
                                 </xsl:if>
                            </input>
						</td>
					</tr>
                    
   					<tr class="sinLinea">
						<td class="labelRight" ><xsl:value-of select="document($doc)/translation/texts/item[@name='fichero_albaran']/node()"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='albaran']/node()"/>:&nbsp;</td>
						<td class="datosLeft" colspan="3">
                            <input type="hidden" name="TIPO_DOC" class="tipoDoc" value="ALBARAN" />
                            <input type="hidden" name="TYPE" class="type" value="ALBARAN" />
                            <input type="hidden" name="IDALBARAN" id="IDALBARAN"/>
							<input id="inputFileDoc_{MO_ID}" name="inputFileDoc_{MO_ID}" type="file" onChange="javascript:cargaDocPed('ALBARAN', 'Cabecera', {MO_ID});" style="width:400px">
								<xsl:attribute name="style">
         							<xsl:choose>
          							<xsl:when test="ALBARANENVIO/ID">width:400px;display:none;</xsl:when>
            						<xsl:otherwise>width:400px;</xsl:otherwise>
            						</xsl:choose>
								</xsl:attribute>
							</input>
         					<xsl:choose>
          					<xsl:when test="ALBARANENVIO/ID">
								<span id="docBox_{MO_ID}" align="center">&nbsp;<a href="http://www.newco.dev.br/Documentos/{ALBARANENVIO/URL}"><xsl:value-of select="ALBARANENVIO/NOMBRE"/></a><a href="javascript:borrarDoc('ALBARAN',{ALBARANENVIO/ID}, {MO_ID});"><img src="http://www.newco.dev.br/images/2017/trash.png"/></a></span>&nbsp;
							</xsl:when>
            				<xsl:otherwise>
								<span id="docBox_{MO_ID}" style="display:none;" align="center"></span>&nbsp;
          					</xsl:otherwise>
            				</xsl:choose>
							<div id="waitBoxDoc_{MO_ID}" align="center" style="display:none;"><img src="http://www.newco.dev.br/images/loading.gif"/></div>
                        </td>
					</tr>
                    <tr class="sinLinea">
						<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='albaran_entrega_sellado']/node()"/>:&nbsp;</td>
						<td class="datosLeft">
							<input type="checkbox" class="muypeq" name="CHK_ENTREGADOPROVEEDOR" onclick="javascript:ControlChecks('ENTREGADOPROVEEDOR','S');"  />
                        	<xsl:value-of select="document($doc)/translation/texts/item[@name='si_maiu']/node()"/>
							&nbsp;&nbsp;&nbsp;<input type="checkbox" class="muypeq" name="CHK_NOENTREGADOPROVEEDOR" onclick="javascript:ControlChecks('ENTREGADOPROVEEDOR','N');" />
                        	<xsl:value-of select="document($doc)/translation/texts/item[@name='no_maiu']/node()"/>
                        	<input type="hidden" name="ENTREGADOPROVEEDOR" value="" />
                        </td>
                        <td>&nbsp;</td>
					</tr>
					<tr class="sinLinea">
						<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='Error_condiciones_comerciales']/node()"/>:&nbsp;</td>
						<td class="datosLeft">
							<input type="checkbox" class="muypeq" name="CHK_ERROR_CONDICIONES_COMERCIALES">
								<xsl:if test="PED_ERRCONDICIONESCOMERCIALES='S'">
									<xsl:attribute name="checked">checked</xsl:attribute>
								</xsl:if>
							</input>
                        	<input type="hidden" name="ERROR_CONDICIONES_COMERCIALES" value="" />
                        </td>
					</tr>
					<tr class="sinLinea">
						<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='Error_integridad_productos']/node()"/>:&nbsp;</td>
						<td class="datosLeft" colspan="2">
							<input type="checkbox" class="muypeq" name="CHK_ERROR_INTEGRIDAD_TODOS" onclick="javascript:CheckIntegridad('T');">
								<xsl:if test="PED_ERRINTEGRIDADPRODUCTOS='T'">
									<xsl:attribute name="checked">checked</xsl:attribute>
								</xsl:if>
							</input>
                        	<xsl:value-of select="document($doc)/translation/texts/item[@name='todos']/node()"/>
							<input type="checkbox" class="muypeq" name="CHK_ERROR_INTEGRIDAD_ALGUNOS" onclick="javascript:CheckIntegridad('A');">
								<xsl:if test="PED_ERRINTEGRIDADPRODUCTOS='A'">
									<xsl:attribute name="checked">checked</xsl:attribute>
								</xsl:if>
							</input>
                          	<xsl:value-of select="document($doc)/translation/texts/item[@name='algunos']/node()"/>
							<input type="checkbox" class="muypeq" name="CHK_ERROR_INTEGRIDAD_NINGUNO" onclick="javascript:CheckIntegridad('N');">
								<xsl:if test="PED_ERRINTEGRIDADPRODUCTOS='N'">
									<xsl:attribute name="checked">checked</xsl:attribute>
								</xsl:if>
							</input>
                        	<xsl:value-of select="document($doc)/translation/texts/item[@name='ninguno']/node()"/>
                        	<input type="hidden" name="ERROR_INTEGRIDAD_PRODUCTOS" value="" />
                        </td>
					</tr>
					<tr class="sinLinea">
						<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='Mala_atencion_proveedor']/node()"/>:&nbsp;</td>
						<td class="datosLeft">
							<input type="checkbox" class="muypeq" name="CHK_MALA_ATENCION_PROV" onclick="javascript:ControlChecks('MALA_ATENCION_PROV','S');">
 								<xsl:if test="PED_MALAATENCIONPROV='S'">
									<xsl:attribute name="checked">checked</xsl:attribute>
								</xsl:if>
							</input>
                        	<input type="hidden" name="MALA_ATENCION_PROV" value="" />
                        </td>
					</tr>
				</table> 
               
         </div><!--fin de divLeft50-->
         
         </div><!--fin de divLeft-->
         
        <!--acciones a realizar-->
        <div class="divLeft marginTop20" style="padding-top:20px;">
         <div class="divLeft40nopa">
               <!--comentarios-->
				<!--<table id="Comentarios" class="infoTable incidencias" cellspacing="5" style="border:none;">-->
 				<table id="Comentarios" class="buscador">
  					<tr class="sinLinea">
						<td class="labelRight trenta"><xsl:value-of select="document($doc)/translation/texts/item[@name='la_clinica_aguanta']/node()"/>:&nbsp;</td>
						<td class="datosleft"><input type="checkbox" class="muypeq" name="CHK_ACEPTASOLUCION" onclick="javascript:ControlAguanta('ACEPTASOLUCION','S');"  >
                        
                          <!--<xsl:for-each select="CONTROL/ENTRADA"><xsl:if test="position() = 1">
                        	<xsl:if test="PCM_ACEPTASOLUCION ='S'">-->
                            <xsl:if test="PED_ACEPTASOLUCION ='S'">
                            <xsl:attribute name="checked">checked</xsl:attribute> 
                            <input type="hidden" name="ACEPTASOLUCION" value="S" />
                            </xsl:if>
                        </input>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='si_maiu']/node()"/>
                        
                        
						&nbsp;&nbsp;&nbsp;<input type="checkbox" class="muypeq" name="CHK_NOACEPTASOLUCION" onclick="javascript:ControlAguanta('ACEPTASOLUCION','N');"  >
                         <!-- <xsl:for-each select="CONTROL/ENTRADA"><xsl:if test="position() = 1">
                        	<xsl:if test="PCM_ACEPTASOLUCION ='N'">-->
                             <xsl:if test="PED_ACEPTASOLUCION ='N'">
                            <xsl:attribute name="checked">checked</xsl:attribute> 
                            <input type="hidden" name="ACEPTASOLUCION" value="N" />
                            </xsl:if>
                        </input>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='no_maiu']/node()"/>
                        &nbsp;&nbsp;&nbsp;<input type="checkbox" class="muypeq" name="CHK_AVISOACEPTASOLUCION" onclick="javascript:ControlAguanta('ACEPTASOLUCION','Z');"  >
                         <!-- <xsl:for-each select="CONTROL/ENTRADA"><xsl:if test="position() = 1">
                        	<xsl:if test="PCM_ACEPTASOLUCION ='Z'">-->
                            <xsl:if test="PED_ACEPTASOLUCION ='Z'">
                            <xsl:attribute name="checked">checked</xsl:attribute> 
                            <input type="hidden" name="ACEPTASOLUCION" value="Z" />
                            </xsl:if>
                        </input>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='aviso_interno']/node()"/>
                        <xsl:choose>
                        <xsl:when test="CONTROL/ENTRADA">
                         <!-- <xsl:for-each select="CONTROL/ENTRADA"><xsl:if test="position() = 1">
                        	<xsl:if test="PCM_ACEPTASOLUCION =''">-->
                            <xsl:if test="PED_ACEPTASOLUCION =''">
                            <input type="hidden" name="ACEPTASOLUCION" value="" />
                            </xsl:if>
                        </xsl:when>
                        <xsl:otherwise> <input type="hidden" name="ACEPTASOLUCION" value="" /></xsl:otherwise>
                        </xsl:choose>
                        </td>
                      
						
                    </tr>
                    <tr class="sinLinea">
					<!--comentarios para mvm-->
						<td class="labelRight grisMed"><xsl:value-of select="document($doc)/translation/texts/item[@name='comentarios_internos']/node()"/>:&nbsp;</td>
						<td class="datosleft">
                        <textarea name="COMENTARIOS" cols="50" rows="1">
                        
                            <xsl:choose>
                            <xsl:when test="CONTROL/ENTRADA">
                          
                                <xsl:for-each select="CONTROL/ENTRADA">
                                    <xsl:if test="position() = 1">
                                    <xsl:choose>
                                    <xsl:when test="PCM_USUARIO != 'PROV' and PCM_COMENTARIOS != '-' and PCM_COMENTARIOS != ''">
                                        <xsl:value-of select="PCM_COMENTARIOS"/>
                                    </xsl:when>
                                    </xsl:choose>
                                    </xsl:if>
                                </xsl:for-each>
                            </xsl:when>
                           
                            </xsl:choose>
                         </textarea>
                        </td>
					</tr>
				</table> 
			</div><!--fin de divLeft40-->
            
            <div class="divLeft60nopa">
				<table id="Proxima_accion" class="buscador">
   					<tr class="sinLinea">
						<td class="labelRight trenta"><xsl:value-of select="document($doc)/translation/texts/item[@name='comentario_para_la_clinica']/node()"/>:&nbsp;
                        </td>
						<td class="datosLeft">
							<textarea name="COMENTARIOS_PARA_CLINICA" rows="3" cols="50">
                               		<xsl:value-of select="PED_COMENTARIOSPARACLINICA"/>
                             </textarea>
						</td>
						<td class="quince" colspan="2">
							<!--3jun22 Solo mostramos el boton si ya hay algun comentario	-->
							<xsl:if test="CONTROL/ENTRADA">
                            	<a class="btnDestacado" href="javascript:EnviarSoloComentario();"><xsl:value-of select="document($doc)/translation/texts/item[@name='enviar']/node()"/></a>
							</xsl:if>
						</td>
					</tr>
   					<tr class="sinLinea">
						<td class="labelRight trenta"><xsl:value-of select="document($doc)/translation/texts/item[@name='siguiente_responsable']/node()"/>:&nbsp;</td>
						<td class="datosleft quince"> 
                        
                         <select name="USUARIOSIGUIENTE" id="USUARIOSIGUIENTE">
                            <option value="-1">
                            <xsl:if test="PCM_USUARIO = '-1'"><xsl:attribute name="selected">true</xsl:attribute></xsl:if>
                                * <xsl:value-of select="document($doc)/translation/texts/item[@name='seleccionar_responsable']/node()"/> *</option>
                                
                            <xsl:for-each select="/ControlPedidos/PEDIDO/USUARIOSCONTROL/field/dropDownList/listElem">
                                <xsl:choose>
                                <xsl:when test="ID = ../../@current"><option value="{ID}" selected="selected"><xsl:value-of select="listItem"/></option></xsl:when>
                                <xsl:otherwise><option value="{ID}"><xsl:value-of select="listItem"/></option></xsl:otherwise>
                                </xsl:choose>                          	
                            </xsl:for-each>
                        </select>
                           
						</td>
                        <td colspan="2">&nbsp;</td>
                   </tr>
                   <tr class="sinLinea">
						<td class="labelRight veinte"><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_proxima_accion']/node()"/>:&nbsp;</td>
						<td class="datosleft dies">
							<select name="FECHAPROXIMAACCION">
							<option value="-1">
                             <xsl:if test="SITUACION != '2' and SITUACION = '3'"><xsl:attribute name="selected">true</xsl:attribute></xsl:if>
                            * <xsl:value-of select="document($doc)/translation/texts/item[@name='seleccionar_fecha']/node()"/> *</option>
                            <option value="">
                            <xsl:if test="SITUACION = '2' or SITUACION = '3'"><xsl:attribute name="selected">true</xsl:attribute></xsl:if>
                            <xsl:value-of select="document($doc)/translation/texts/item[@name='sin_fecha_accion']/node()"/></option>
                            <option value="0"><xsl:value-of select="document($doc)/translation/texts/item[@name='hoy']/node()"/></option>
                            <option value="1"><xsl:value-of select="document($doc)/translation/texts/item[@name='manana']/node()"/></option>
                            <option value="2"><xsl:value-of select="document($doc)/translation/texts/item[@name='pasado_manana']/node()"/></option>
                            <option value="3"><xsl:value-of select="document($doc)/translation/texts/item[@name='dentro_3_dias']/node()"/></option>
                            <option value="4"><xsl:value-of select="document($doc)/translation/texts/item[@name='dentro_4_dias']/node()"/></option>
							</select>
                        </td>
					</tr>
				</table> 
           </div><!--fin de divLeft50-->
		</div><!--fin de divLeft-->
        <div class="divLeft">
		<br/>
		<p style="text-align:center;">
		<a class="btnDestacado" href="javascript:EnviarTodo();" title="Actualizar">
			<xsl:value-of select="document($doc)/translation/texts/item[@name='guardar']/node()"/>
		</a>&nbsp;
		</p>
		<br/>
		</div>
        <xsl:if test="/ControlPedidos/PEDIDO/LOGPEDIDOS/ENTRADA">
        <div class="divLeft">
		<br/>
		<br/>
			<table class="buscador"  style="border-left:1px solid #999999;width:100%;">
        	<thead>
   				<tr class="subTituloTabla">
					<td><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha']/node()"/></td>
					<td><xsl:value-of select="document($doc)/translation/texts/item[@name='usuario']/node()"/></td>
					<td>LOGS / <xsl:value-of select="document($doc)/translation/texts/item[@name='accion']/node()"/></td>
				</tr>
            </thead>
        	<xsl:for-each select="/ControlPedidos/PEDIDO/LOGPEDIDOS/ENTRADA">
   				<tr>
					<td class="textLeft"><xsl:value-of select="FECHA"/></td>
					<td class="textLeft"><xsl:value-of select="USUARIO"/></td>
					<td class="textLeft"><xsl:value-of select="COMENTARIOS"/></td>
				</tr>
			</xsl:for-each>
			</table>
		</div>
		</xsl:if>
	</form>
    
    
     <!--FORM DE MENSAJES DE JS-->
     <form name="MensajeJS">
		<input type="hidden" name="NUM_DE_PEDIDO" value="{document($doc)/translation/texts/item[@name='num_de_pedido']/node()}"/>
		<input type="hidden" name="DE" value="{document($doc)/translation/texts/item[@name='de']/node()}"/>

		<input type="hidden" name="ESTIMADOS" value="{document($doc)/translation/texts/item[@name='estimados']/node()}"/>
		<input type="hidden" name="SI_PEDIDO_OS_HA_LLEGADO" value="{document($doc)/translation/texts/item[@name='si_pedido_os_ha_llegado']/node()}"/>

		<input type="hidden" name="GRACIAS" value="{document($doc)/translation/texts/item[@name='gracias']/node()}"/>
		<input type="hidden" name="SALUDOS" value="{document($doc)/translation/texts/item[@name='saludos']/node()}"/>
		<input type="hidden" name="RESPONSABLE_PEDIDOS" value="{document($doc)/translation/texts/item[@name='responsable_pedidos']/node()}"/>
		<input type="hidden" name="WWW_MEDICALVM_COM" value="{document($doc)/translation/texts/item[@name='www.newco.dev.br']/node()}"/>
		<input type="hidden" name="TEL_MVM" value="{document($doc)/translation/texts/item[@name='tel_medicalvm']/node()}"/>
		<input type="hidden" name="FAX_MVM" value="{document($doc)/translation/texts/item[@name='fax_medicalvm']/node()}"/>

		<input type="hidden" name="ACEPTAR_PEDIDO_SISTEMA" value="{document($doc)/translation/texts/item[@name='aceptar_pedido_sistema']/node()}"/>
		<input type="hidden" name="BUENOS_DIAS" value="{document($doc)/translation/texts/item[@name='buenos_dias']/node()}"/>
		<input type="hidden" name="EL_PEDIDO" value="{document($doc)/translation/texts/item[@name='el_pedido']/node()}"/>
		<input type="hidden" name="AGUARDA_RESCATE" value="{document($doc)/translation/texts/item[@name='aguarda_rescate']/node()}"/>

		<input type="hidden" name="INFORMAD_SALIDA_PEDIDO" value="{document($doc)/translation/texts/item[@name='informad_salida_pedido']/node()}"/>


		<input type="hidden" name="OBLIGATORIO_USUARIO" value="{document($doc)/translation/texts/item[@name='obligatorio_usuario']/node()}"/>
		<input type="hidden" name="OBLIGATORIO_CAMPO_TAREA" value="{document($doc)/translation/texts/item[@name='obligatorio_campo_tarea']/node()}"/>
		<input type="hidden" name="OBLIGATORIO_PROVE_ENVIADO" value="{document($doc)/translation/texts/item[@name='obligatorio_prove_enviado']/node()}"/>
		<input type="hidden" name="ERROR_FECHA_ENVIO_PEDIDO" value="{document($doc)/translation/texts/item[@name='error_fecha_envio_pedido']/node()}"/>
		<input type="hidden" name="OBLIGATORIO_FECHA_ENVIO" value="{document($doc)/translation/texts/item[@name='obligatorio_fecha_envio']/node()}"/>
		<input type="hidden" name="OBLIGATORIO_ALBARAN" value="{document($doc)/translation/texts/item[@name='obligatorio_albaran']/node()}"/>
		<input type="hidden" name="OBLIGATORIO_INTERLOCUTOR" value="{document($doc)/translation/texts/item[@name='obligatorio_interlocutor']/node()}"/>
		<input type="hidden" name="OBLIGATORIO_RESP_PROXIMA_ACCION" value="{document($doc)/translation/texts/item[@name='obligatorio_resp_proxima_accion']/node()}"/>
		<input type="hidden" name="INFORMAR_USUARIO_COMENTARIO" value="{document($doc)/translation/texts/item[@name='informar_usuario_comentario']/node()}"/>
		<input type="hidden" name="OBLIGATORIO_COMENTARIO_CLINICA" value="{document($doc)/translation/texts/item[@name='obligatorio_comentario_clinica']/node()}"/>
		<input type="hidden" name="DATOS_PENDIENTE_PERDERA" value="{document($doc)/translation/texts/item[@name='datos_pendientes_perdera']/node()}"/>

		<input type="hidden" name="ELIMINAR_TODAS_ENTRADAS_MES" value="{document($doc)/translation/texts/item[@name='eliminar_todas_entradas']/node()}"/>
		<input type="hidden" name="ELIMINAR_ENTRADA_MES" value="{document($doc)/translation/texts/item[@name='eliminar_entrada']/node()}"/>

		<input type="hidden" name="ELIMINAR_TODOS_COMENTARIOS_MES" value="{document($doc)/translation/texts/item[@name='eliminar_todas_entradas']/node()}"/>
		<input type="hidden" name="ELIMINAR_COMENTARIO_MES" value="{document($doc)/translation/texts/item[@name='eliminar_entrada']/node()}"/>
		<input type="hidden" name="OBLIGATORIO_CAMPO_PROXIMA_ACCION" value="{document($doc)/translation/texts/item[@name='obligatorio_campo_proxima_accion']/node()}"/>
		<input type="hidden" name="PDF_ENVIADO_CON_EXITO" value="{document($doc)/translation/texts/item[@name='pdf_enviado_con_exito']/node()}"/>
		<input type="hidden" name="PDF_ENVIADO_CLIENTE" value="{document($doc)/translation/texts/item[@name='pdf_enviado_cliente']/node()}"/>
		<input type="hidden" name="PDF_ENVIADO_PROVEE" value="{document($doc)/translation/texts/item[@name='pdf_enviado_provee']/node()}"/>
		<input type="hidden" name="ERROR_PDF_ENVIADO_CLIENTE" value="{document($doc)/translation/texts/item[@name='error_pdf_enviado_cliente']/node()}"/>
		<input type="hidden" name="ERROR_PDF_ENVIADO_PROVEE" value="{document($doc)/translation/texts/item[@name='error_pdf_enviado_provee']/node()}"/>

		<input type="hidden" name="MENSAJE_ENVIADO" value="{document($doc)/translation/texts/item[@name='mensaje_enviado']/node()}"/>
		<input type="hidden" name="ERROR_ENVIANDO_MENSAJE" value="{document($doc)/translation/texts/item[@name='error_enviando_mensaje']/node()}"/>

		<input type="hidden" name="strPAGADO" value="{document($doc)/translation/texts/item[@name='Pagado']/node()}"/>



    </form>
    <!--FIN DE FORM DE MENSAJES DE JS-->
    
    
</xsl:template> 
 
</xsl:stylesheet>
