<?xml version="1.0" encoding="iso-8859-1" ?>
<!--
	Pedido minimo por cliente
	Ultima revision: ET 29set22 11:16 PedidoMinimoPorCliente2022_290922.js
-->
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
            <xsl:when test="/MantenimientoEmpresas/LANG"><xsl:value-of select="/MantenimientoEmpresas/LANG" /></xsl:when>
            <xsl:otherwise>spanish</xsl:otherwise>
            </xsl:choose>  
        </xsl:variable>
        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
      <!--idioma fin-->
           
      <title><xsl:value-of select="document($doc)/translation/texts/item[@name='mant_pedido_minimo_cliente']/node()"/></title>
       <!--style-->
      <xsl:call-template name="estiloIndip"/>
      <!--fin de style-->  

		<script type="text/javascript" src="http://www.newco.dev.br/General/jquery-3.6.0.js"></script>	
		<script type="text/javascript" src="http://www.newco.dev.br/General/basic2022_010822.js"></script>

		<script type="text/javascript">
           var pedidoMinimoActivo='<xsl:value-of select="/MantenimientoEmpresas/PEDIDOSMINIMOS/EMP_PEDMINIMO_ACTIVO"/>';
           var importePedidoMinimo='<xsl:value-of select="/MantenimientoEmpresas/PEDIDOSMINIMOS/EMP_PEDMINIMO_IMPORTE"/>';
           var descripcionPedidoMinimo='<xsl:value-of select="/MantenimientoEmpresas/PEDIDOSMINIMOS/EMP_PEDMINIMO_DETALLE"/>';
		</script>
		<script type="text/javascript" src="http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/PedidoMinimoPorCliente2022_290922.js"></script>
      </head>
      <body>
      	  <!--idioma-->
         <xsl:variable name="lang">
        <xsl:choose>
            <xsl:when test="/MantenimientoEmpresas/LANG"><xsl:value-of select="/MantenimientoEmpresas/LANG" /></xsl:when>
            <xsl:otherwise>spanish</xsl:otherwise>
            </xsl:choose>  
        </xsl:variable>
        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
      <!--idioma fin-->
           
     
        <xsl:choose>
          <!-- Error en alguna sentencia del XSQL -->
          <xsl:when test="//xsql-error">
            <xsl:apply-templates select="//xsql-error"/>        
          </xsl:when>
          <xsl:when test="//SESION_CADUCADA">
            <xsl:for-each select="//SESION_CADUCADA">
              <xsl:if test="position()=last()">
                <xsl:apply-templates select="."/>
              </xsl:if>
            </xsl:for-each>        
          </xsl:when>
          <xsl:otherwise>
            <xsl:choose>
              <xsl:when test="/MantenimientoEmpresas/PEDIDOSMINIMOS/ACCION!='MODIFICARCLIENTE' and MantenimientoEmpresas/PEDIDOSMINIMOS/ACCION!='INSERTARCENTRO' and MantenimientoEmpresas/PEDIDOSMINIMOS/ACCION!='MODIFICARCENTRO' and MantenimientoEmpresas/PEDIDOSMINIMOS/ACCION!='GUARDARCENTRO'">
                <xsl:attribute name="onLoad">
                  cargarValoresDescripcionPedidoMinimo('<xsl:value-of select="/MantenimientoEmpresas/PEDIDOSMINIMOS/EMP_PEDMINIMO_DETALLE"/>','EMP_DESCRIPCIONPEDIDOMINIMO');
                </xsl:attribute>
              </xsl:when>
            </xsl:choose>

		<!--	Titulo de la página		-->
		<div class="ZonaTituloPagina">
			<p class="TituloPagina">
				<xsl:value-of select="/MantenimientoEmpresas/PEDIDOSMINIMOS/PROVEEDOR/NOMBRE"/>
				<span class="CompletarTitulo">
                    <a class="btnNormal" href="javascript:chMantenEmpresa({/MantenimientoEmpresas/PEDIDOSMINIMOS/PROVEEDOR/ID});">
                    <xsl:value-of select="document($doc)/translation/texts/item[@name='volver']/node()"/>
                    </a>
				</span>
			</p>
		</div>
		<br/>
		<br/>
		<br/>
		<br/>
		<br/>
		 
        <form name="form1" action="PedidoMinimoPorCliente2022.xsql" method="post">
			<xsl:choose>
            	<xsl:when test="MantenimientoEmpresas/PEDIDOSMINIMOS/ADMIN">			
					<input type="hidden" name="ADMIN" value="S"/>
				</xsl:when>
				<xsl:otherwise>
					<input type="hidden" name="ADMIN" value="N"/>
				</xsl:otherwise>
			</xsl:choose>
			<input type="hidden" name="IDPROVEEDOR" value="{MantenimientoEmpresas/PEDIDOSMINIMOS/PROVEEDOR/ID}"/>
			<input type="hidden" name="ACCION"/>
			<input type="hidden" name="DESDE"/>
			<input type="hidden" name="NUEVO_CLIENTE"/>
			<input type="hidden" name="NUEVO_CENTRO"/>
			<input type="hidden" name="EMP_PEDMINIMO_ACTIVO" value="{MantenimientoEmpresas/PEDIDOSMINIMOS/EMP_PEDMINIMO_ACTIVO}"/>
			<input type="hidden" name="EMP_PEDMINIMO_IMPORTE"  value="{MantenimientoEmpresas/PEDIDOSMINIMOS/EMP_PEDMINIMO_IMPORTE}"/>
			<input type="hidden" name="EMP_PEDMINIMO_IMPORTE_NM"  value="{MantenimientoEmpresas/PEDIDOSMINIMOS/EMP_PEDMINIMO_IMPORTE_NM}"/>
			<input type="hidden" name="EMP_PEDMINIMO_DETALLE"  value="{MantenimientoEmpresas/PEDIDOSMINIMOS/EMP_PEDMINIMO_DETALLE}"/>

	<div class="tabela tabela_redonda">
	<table cellspacing="6px" cellpadding="6px">
		<thead class="cabecalho_tabela">
		<tr>
            <th class="w1px">&nbsp;</th>
            <th class="veinte" align="left">
              <xsl:value-of select="document($doc)/translation/texts/item[@name='empresa']/node()"/>
            </th>
            <th class="dies">
             <xsl:value-of select="document($doc)/translation/texts/item[@name='plazo_entrega']/node()"/>
            </th>
            <th class="dies">
             <xsl:value-of select="document($doc)/translation/texts/item[@name='plazo_envio']/node()"/>
            </th>
            <th class="dies">
             <xsl:value-of select="document($doc)/translation/texts/item[@name='pedido_minimo']/node()"/>
            </th>
            <th class="dies">
            	<xsl:value-of select="document($doc)/translation/texts/item[@name='pedido_minimo']/node()"/>
<br/><xsl:value-of select="document($doc)/translation/texts/item[@name='precio_prov']/node()"/> (<xsl:value-of select="document($doc)/translation/texts/item[@name='eur']/node()"/>
)
              <!--<xsl:value-of select="document($doc)/translation/texts/item[@name='importe_minimo_eur']/node()"/>-->
            </th>
            <th class="dies">
            	<xsl:value-of select="document($doc)/translation/texts/item[@name='pedido_minimo']/node()"/>
<br/><xsl:value-of select="document($doc)/translation/texts/item[@name='precio_final']/node()"/>
 (<xsl:value-of select="document($doc)/translation/texts/item[@name='eur']/node()"/>)
            </th>
            <th>
            	<xsl:value-of select="document($doc)/translation/texts/item[@name='descr_pedido_minimo']/node()"/>
            </th>
            <th class="w1px">&nbsp;</th>
          </tr>
		</thead>
		<!--	Cuerpo de la tabla	-->
		<tbody class="corpo_tabela">
          <!-- si hay empresas las listamos con sus centros indentados (si los hay) -->
          <xsl:choose>
            <xsl:when test="/MantenimientoEmpresas/PEDIDOSMINIMOS/CLIENTES_CON_PEDIDO_MINIMO/EMPRESA">
              <!-- mostramos cada empresa -->
              <xsl:for-each select="/MantenimientoEmpresas/PEDIDOSMINIMOS/CLIENTES_CON_PEDIDO_MINIMO/EMPRESA">
				<tr class="con_hover">
					<td class="color_status">&nbsp;</td>
					<td class="textLeft">
					<a href="javascript:ModificarPedidoMinimo({ID},'','MODIFICARCLIENTE');">
					  <xsl:value-of select="NOMBRE"/>
					</a>
					</td>
					<td class="datosCenter"><xsl:value-of select="PLAZO_ENTREGA"/></td>
					<td class="datosCenter"><xsl:value-of select="PLAZO_ENVIO"/></td>
					<td>
					 <input type="hidden" name="EMP_PEDMINIMO_ACTIVO_{ID}" value="{ACTIVO}"/>
					 <xsl:choose>
					   <xsl:when test="ACTIVO='N'">
    					 <b><xsl:value-of select="document($doc)/translation/texts/item[@name='no_activo']/node()"/></b>
					   </xsl:when>
					   <xsl:when test="ACTIVO='S'">
    					 <b><xsl:value-of select="document($doc)/translation/texts/item[@name='activo']/node()"/></b>
					   </xsl:when>
					   <xsl:when test="ACTIVO='E'">
    					 <b><xsl:value-of select="document($doc)/translation/texts/item[@name='estricto']/node()"/></b>
					   </xsl:when>
					   <xsl:when test="ACTIVO='I'">
    					 <b><xsl:value-of select="document($doc)/translation/texts/item[@name='integrado']/node()"/></b>
					   </xsl:when>
					 </xsl:choose>
					</td>
					<td>
					  <xsl:value-of select="IMPORTE"/>
					</td>
					<td>
					  <xsl:value-of select="IMPORTE_NM"/>
					</td>
					<td align="left">
    					  <xsl:copy-of select="DESCRIPCION_HTML"/>
					</td>
					<td>
    					<a href="javascript:BorrarPedidoMinimo('{ID}','','BORRARCLIENTE','');">
        					<img src="http://www.newco.dev.br/images/2017/trash.png" />
    					</a>
					</td>

				</tr>
              <!-- si tiene centros con pedidos minimos los listamos tambien -->
                 <xsl:for-each select="CENTROS_CON_PEDIDO_MINIMO/CENTRO">
                 <tr class="con_hover">
                   <td class="color_status">&nbsp;</td>
	                 <td class="textLeft">
	                   &nbsp;&nbsp;&nbsp;&nbsp;&gt;&nbsp;<a href="javascript:ModificarPedidoMinimo('{../../ID}','{ID}','MODIFICARCENTRO');">
	                    <xsl:value-of select="NOMBRE"/>
	                   </a>
	                 </td>
            		<td class="datosCenter"><xsl:value-of select="PLAZO_ENTREGA"/></td>
            		<td class="datosCenter"><xsl:value-of select="PLAZO_ENVIO"/></td>
                   <td>
                    <input type="hidden" name="EMP_PEDMINIMO_ACTIVO_{ID}" value="{ACTIVO}"/>
                    <xsl:choose>
                      <xsl:when test="ACTIVO='N'">
                        <b><xsl:value-of select="document($doc)/translation/texts/item[@name='no_activo']/node()"/></b>
                      </xsl:when>
                      <xsl:when test="ACTIVO='S'">
                        <b><xsl:value-of select="document($doc)/translation/texts/item[@name='activo']/node()"/></b>
                      </xsl:when>
                      <xsl:when test="ACTIVO='E'">
                        <b><xsl:value-of select="document($doc)/translation/texts/item[@name='estricto']/node()"/></b>
                      </xsl:when>
                      <xsl:when test="ACTIVO='I'">
                        <b><xsl:value-of select="document($doc)/translation/texts/item[@name='integrado']/node()"/></b>
                      </xsl:when>
                    </xsl:choose>
                   </td>
                   <td>
                     <xsl:value-of select="IMPORTE"/>
                   </td>
                   <td>
                     <xsl:value-of select="IMPORTE_NM"/>
                   </td>
                   <td>
                         <xsl:copy-of select="DESCRIPCION_HTML"/>
                   </td>
                   <td>
                   		<a href="javascript:BorrarPedidoMinimo('{../../ID}','{ID}','BORRARCENTRO','');">
                    		<img src="http://www.newco.dev.br/images/2017/trash.png" />
                    	</a>
	                 </td>
                 </tr>
                   
                 </xsl:for-each>
              
              </xsl:for-each>
            </xsl:when>
            <xsl:otherwise>
              <tr>
                <td colspan="9">
                	<xsl:value-of select="document($doc)/translation/texts/item[@name='ninguna_empresa_pedido_minimo']/node()"/>
                </td>
              </tr>
            </xsl:otherwise>
          </xsl:choose>
		</tbody>
		<tfoot class="rodape_tabela">
			<tr><td colspan="12">&nbsp;</td></tr>
		</tfoot>
	</table><!--fin de infoTableAma-->
 	</div>
       <br /><br />
     <!--tabla abajo mantenimiento-->
    	<table cellspacing="6px" cellpadding="6px">
    	<tr class="fondoGris h40px">
        <!--  <xsl:choose>
	          <xsl:when test="not(/MantenimientoEmpresas/PEDIDOSMINIMOS/SOLO_EMPRESA_USUARIO) and (ACCION='INICIO' or /MantenimientoEmpresas/PEDIDOSMINIMOS/ACCION='BORRARCENTRO' or /MantenimientoEmpresas/PEDIDOSMINIMOS/ACCION='MODIFICARCLIENTE' or /MantenimientoEmpresas/PEDIDOSMINIMOS/ACCION='INSERTARCENTRO' or /MantenimientoEmpresas/PEDIDOSMINIMOS/ACCION='MODIFICARCENTRO' or /MantenimientoEmpresas/PEDIDOSMINIMOS/ACCION='BORRARCLIENTE' or /MantenimientoEmpresas/PEDIDOSMINIMOS/ACCION='BORRARCENTRO' or /MantenimientoEmpresas/PEDIDOSMINIMOS/ACCION='INSERTARCLIENTE' or /MantenimientoEmpresas/PEDIDOSMINIMOS/ACCION='CENTRO' or /MantenimientoEmpresas/PEDIDOSMINIMOS/ACCION='GUARDARCLIENTE')">-->
            	  <td align="right" class="veinte labelRight">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='cliente']/node()"/>
					</td>
					<td align="left" class="veinte">
 						<xsl:call-template name="desplegable"> 
						<xsl:with-param name="id" value="IDEMPRESACLIENTE"/>
						<xsl:with-param name="path" select="/MantenimientoEmpresas/PEDIDOSMINIMOS/EMPRESAS/field" />
						<xsl:with-param name="claSel">w400px</xsl:with-param>
						<xsl:if test="/MantenimientoEmpresas/PEDIDOSMINIMOS/SOLO_EMPRESA_USUARIO">
							<xsl:with-param name="disabled">disabled</xsl:with-param>
						</xsl:if>
						<xsl:with-param name="onChange">javascript:CambioEmpresa();</xsl:with-param>
						</xsl:call-template> 
					</td>
				<!--</xsl:when>
				<xsl:otherwise>
					<input type="hidden" name="IDEMPRESACLIENTE" value="{/MantenimientoEmpresas/PEDIDOSMINIMOS/IDEMPRESAUSUARIO}"/>
				</xsl:otherwise>
				</xsl:choose>-->
        
              <td colspan="3">&nbsp;</td>
          
           
           	<!-- si hay alguna empresa seleccionada mostramos el desplegable de centros o el centro seleccionado -->
           	<xsl:choose>
			<xsl:when test="/MantenimientoEmpresas/PEDIDOSMINIMOS/CLIENTES_CON_PEDIDO_MINIMO/EMPRESA_SELECCIONADA/LISTACENTROS/field">
                <td class="labelRight">
                    <xsl:value-of select="document($doc)/translation/texts/item[@name='centro']/node()"/>:&nbsp;
                </td>
                <td colspan="2" align="left">
					<xsl:call-template name="desplegable"> 
					<xsl:with-param name="id" value="IDCENTROCLIENTE"/>
					<xsl:with-param name="path" select="/MantenimientoEmpresas/PEDIDOSMINIMOS/CLIENTES_CON_PEDIDO_MINIMO/EMPRESA_SELECCIONADA/LISTACENTROS/field" />
					<xsl:with-param name="claSel">w400px</xsl:with-param>
					</xsl:call-template>
                </td>
                <td> 
                   	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a class="btnNormal" href="javascript:NuevoPedidoMinimoPorCliente(document.forms[0]);"><xsl:value-of select="document($doc)/translation/texts/item[@name='volver_a_empresas']/node()"/></a>
                </td>
			</xsl:when>
			<xsl:otherwise>
                <input type="hidden" name="IDCENTROCLIENTE" value=""/>
            	<td colspan="3">&nbsp;</td>
			</xsl:otherwise>
			</xsl:choose>
		</tr>
		</table>   
          
           
    	<table cellspacing="6px" cellpadding="6px">
			<tr>
			  <td colspan="3">
    				<strong><xsl:value-of select="document($doc)/translation/texts/item[@name='plazo_entrega']/node()"/>&nbsp;+&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='plazo_envio']/node()"/></strong>
			  </td>
			</tr>
			<tr>
            	<td class="labelRight">
            		<xsl:value-of select="document($doc)/translation/texts/item[@name='plazo_entrega']/node()"/>:&nbsp;
            	</td>
           		<td class="datosLeft" >
    				<input type="text" class="campopesquisa w50px" name="PLAZO_ENTREGA"  value="{//CENTRO_SELECCIONADO/PLAZO_ENTREGA}" size="3"/><!--onBlur="ValidarNumero(this,2);"-->
					<!--
					<xsl:choose>
					<xsl:when test="/MantenimientoEmpresas/PEDIDOSMINIMOS/ACCION='MODIFICARCENTRO' or /MantenimientoEmpresas/PEDIDOSMINIMOS/ACCION='INSERTARCENTRO'">
	    				<input type="text" class="campopesquisa w50px" name="PLAZO_ENTREGA"  value="{//CENTRO_SELECCIONADO/PLAZO_ENTREGA}" size="3"/><!- -onBlur="ValidarNumero(this,2);"- ->
					</xsl:when>
					<xsl:otherwise>
	    				<input type="text" class="campopesquisa w50px" name="PLAZO_ENTREGA"  value="{//EMPRESA_SELECCIONADA/PLAZO_ENTREGA}" size="3"/><!- -onBlur="ValidarNumero(this,2);"- ->
					</xsl:otherwise>
					</xsl:choose>-->
            	</td>
			</tr>
			<tr>
            	<td class="labelRight">
            		<xsl:value-of select="document($doc)/translation/texts/item[@name='plazo_envio']/node()"/>:&nbsp;
            	</td>
           		<td class="datosLeft" >
    				<input type="text" class="campopesquisa w50px" name="PLAZO_ENVIO" value="{//CENTRO_SELECCIONADO/PLAZO_ENVIO}" size="3"/><!--onBlur="ValidarNumero(this,2);"-->
					<!--<xsl:choose>
					<xsl:when test="/MantenimientoEmpresas/PEDIDOSMINIMOS/ACCION='MODIFICARCENTRO' or /MantenimientoEmpresas/PEDIDOSMINIMOS/ACCION='INSERTARCENTRO'">
	    				<input type="text" class="campopesquisa w50px" name="PLAZO_ENVIO" value="{//CENTRO_SELECCIONADO/PLAZO_ENVIO}" size="3"/><!- -onBlur="ValidarNumero(this,2);"- ->
					</xsl:when>
					<xsl:otherwise>
	    				<input type="text" class="campopesquisa w50px" name="PLAZO_ENVIO"  value="{//EMPRESA_SELECCIONADA/PLAZO_ENVIO}" size="3"/><!- -onBlur="ValidarNumero(this,2);"- ->
					</xsl:otherwise>
					</xsl:choose>-->
            	</td>
			</tr>
			<tr>
			  <td colspan="3">
    			<strong><xsl:value-of select="document($doc)/translation/texts/item[@name='pedido_minimo']/node()"/></strong>
			  </td>
			</tr>
			<tr>
             <td class="labelRight">
               <xsl:value-of select="document($doc)/translation/texts/item[@name='activo']/node()"/>:&nbsp;
             </td>
             <td class="uno">
               <xsl:choose>
                  <xsl:when test="/MantenimientoEmpresas/PEDIDOSMINIMOS/ACCION!='MODIFICARCLIENTE' and MantenimientoEmpresas/PEDIDOSMINIMOS/ACCION!='INSERTARCENTRO' and MantenimientoEmpresas/PEDIDOSMINIMOS/ACCION!='MODIFICARCENTRO' and MantenimientoEmpresas/PEDIDOSMINIMOS/ACCION!='GUARDARCENTRO'">
                    <xsl:choose>
                      <xsl:when test="/MantenimientoEmpresas/PEDIDOSMINIMOS/EMP_PEDMINIMO_ACTIVO='S' or MantenimientoEmpresas/PEDIDOSMINIMOS/EMP_PEDMINIMO_ACTIVO='E'">
                        <input type="checkbox" class="muypeq" name="EMP_PEDMINIMOACTIVO_CHECK"  checked="checked" onClick="pedidoMinimo(this.name,document.forms[0]);"/>
                      </xsl:when>
                      <xsl:when test="/MantenimientoEmpresas/PEDIDOSMINIMOS/EMP_PEDMINIMO_ACTIVO='I'">
                        <input type="checkbox" class="muypeq" name="EMP_PEDMINIMOACTIVO_CHECK"  disabled="disabled" onClick="pedidoMinimo(this.name,document.forms[0]);"/>
                      </xsl:when>
                      <xsl:otherwise>
                        <input type="checkbox" class="muypeq" name="EMP_PEDMINIMOACTIVO_CHECK" onClick="pedidoMinimo(this.name,document.forms[0]);"/>
                      </xsl:otherwise>
                    </xsl:choose>
                  </xsl:when>
                  <!--modificar, insertar centro-->
                  <xsl:when test="/MantenimientoEmpresas/PEDIDOSMINIMOS/ACCION='MODIFICARCENTRO' or /MantenimientoEmpresas/PEDIDOSMINIMOS/ACCION='INSERTARCENTRO'">
                    <xsl:choose>
                      <xsl:when test="//CENTRO_SELECCIONADO/ACTIVO='S' or //CENTRO_SELECCIONADO/ACTIVO='E'">
                        <input type="checkbox" class="muypeq" name="EMP_PEDMINIMOACTIVO_CHECK" checked="checked" onClick="pedidoMinimo(this.name,document.forms[0]);"/>
                      </xsl:when>
                      <xsl:when test="//CENTRO_SELECCIONADO/ACTIVO='I'">
                        <input type="checkbox" class="muypeq" name="EMP_PEDMINIMOACTIVO_CHECK"  disabled="disabled" onClick="pedidoMinimo(this.name,document.forms[0]);"/>
                      </xsl:when>
                      <xsl:otherwise>
                        <input type="checkbox" class="muypeq" name="EMP_PEDMINIMOACTIVO_CHECK" onClick="pedidoMinimo(this.name,document.forms[0]);"/>
                      </xsl:otherwise>
                    </xsl:choose>
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:choose>
                      <xsl:when test="/MantenimientoEmpresas/PEDIDOSMINIMOS/CLIENTES_CON_PEDIDO_MINIMO/EMPRESA_SELECCIONADA/ACTIVO='S' or MantenimientoEmpresas/PEDIDOSMINIMOS/CLIENTES_CON_PEDIDO_MINIMO/EMPRESA_SELECCIONADA/ACTIVO='E'">
                        <input type="checkbox" class="muypeq" name="EMP_PEDMINIMOACTIVO_CHECK"  checked="checked" onClick="pedidoMinimo(this.name,document.forms[0]);"/>
                      </xsl:when>
                      <xsl:when test="/MantenimientoEmpresas/PEDIDOSMINIMOS/CLIENTES_CON_PEDIDO_MINIMO/EMPRESA_SELECCIONADA/ACTIVO='I'">
                        <input type="checkbox" class="muypeq" name="EMP_PEDMINIMOACTIVO_CHECK"  disabled="disabled" onClick="pedidoMinimo(this.name,document.forms[0]);"/>
                      </xsl:when>
                      <xsl:otherwise>
                        <input type="checkbox" class="muypeq" name="EMP_PEDMINIMOACTIVO_CHECK" onClick="pedidoMinimo(this.name,document.forms[0]);"/>
                      </xsl:otherwise>
                    </xsl:choose>   
                  </xsl:otherwise>
                </xsl:choose>
             </td>
           <td class="datosLeft" >
             <xsl:value-of select="document($doc)/translation/texts/item[@name='activar_control_pedido_minimo']/node()"/>.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
           		<strong><xsl:value-of select="document($doc)/translation/texts/item[@name='importe']/node()"/>:&nbsp;</strong>&nbsp;<input type="hidden" name="EMP_PEDMINIMOACTIVO" value="{MantenimientoEmpresas/PEDIDOSMINIMOS/EMP_PEDMINIMO_ACTIVO}"/>
 
        <xsl:choose>
          <xsl:when test="/MantenimientoEmpresas/PEDIDOSMINIMOS/ACCION!='MODIFICARCLIENTE' and MantenimientoEmpresas/PEDIDOSMINIMOS/ACCION!='INSERTARCENTRO' and MantenimientoEmpresas/PEDIDOSMINIMOS/ACCION!='MODIFICARCENTRO' and MantenimientoEmpresas/PEDIDOSMINIMOS/ACCION!='GUARDARCENTRO'">
            <xsl:choose>
              <xsl:when test="/MantenimientoEmpresas/PEDIDOSMINIMOS/EMP_PEDMINIMO_ACTIVO='S' or MantenimientoEmpresas/PEDIDOSMINIMOS/EMP_PEDMINIMO_ACTIVO='E' or MantenimientoEmpresas/PEDIDOSMINIMOS/EMP_PEDMINIMO_ACTIVO='I'">
	        <!--<input type="text" name="EMP_PEDIDOMINIMO" onBlur="ValidarNumero(this,2);" value="{MantenimientoEmpresas/PEDIDOSMINIMOS/EMP_PEDMINIMO_IMPORTE}"/>-->
             <input type="text" class="campopesquisa w80px" name="EMP_PEDIDOMINIMO" onBlur="ValidarNumero(this,2);" value="{MantenimientoEmpresas/PEDIDOSMINIMOS/EMP_PEDMINIMO_IMPORTE}" size="8"/>
             <input type="text" class="campopesquisa w80px" name="EMP_PEDIDOMINIMO_NM" onBlur="ValidarNumero(this,2);" value="{MantenimientoEmpresas/PEDIDOSMINIMOS/EMP_PEDMINIMO_IMPORTE_NM}" size="8"/>
	      </xsl:when>
	      <xsl:otherwise>
	        <input type="text" class="campopesquisa w80px" name="EMP_PEDIDOMINIMO" disabled="disabled" onBlur="ValidarNumero(this,2);" size="8"/>
	        <input type="text" class="campopesquisa w80px" name="EMP_PEDIDOMINIMO_NM" disabled="disabled" onBlur="ValidarNumero(this,2);" size="8"/>
	      </xsl:otherwise>
   	    </xsl:choose>  
   	  </xsl:when>
   	  <xsl:when test="/MantenimientoEmpresas/PEDIDOSMINIMOS/ACCION='MODIFICARCENTRO' or /MantenimientoEmpresas/PEDIDOSMINIMOS/ACCION='INSERTARCENTRO'">
   	    <xsl:choose>
          <xsl:when test="//CENTRO_SELECCIONADO/ACTIVO='S' or //CENTRO_SELECCIONADO/ACTIVO='E' or //CENTRO_SELECCIONADO/ACTIVO='I'">
	        <input type="text" class="campopesquisa w80px" name="EMP_PEDIDOMINIMO" onBlur="ValidarNumero(this,2);" value="{//CENTRO_SELECCIONADO/IMPORTE}" size="8"/>
	        <input type="text" class="campopesquisa w80px" name="EMP_PEDIDOMINIMO_NM" onBlur="ValidarNumero(this,2);" value="{//CENTRO_SELECCIONADO/IMPORTE_NM}" size="8"/>
	      </xsl:when>
	      <xsl:otherwise>
	        <input type="text" class="campopesquisa w80px" name="EMP_PEDIDOMINIMO" disabled="disabled" onBlur="ValidarNumero(this,2);" size="8"/>
	        <input type="text" class="campopesquisa w80px" name="EMP_PEDIDOMINIMO_NM" disabled="disabled" onBlur="ValidarNumero(this,2);" size="8"/>
	      </xsl:otherwise>
   	    </xsl:choose>
   	  </xsl:when>
   	  <xsl:otherwise>
   	    <xsl:choose>
          <xsl:when test="/MantenimientoEmpresas/PEDIDOSMINIMOS/CLIENTES_CON_PEDIDO_MINIMO/EMPRESA_SELECCIONADA/ACTIVO='S' or MantenimientoEmpresas/PEDIDOSMINIMOS/CLIENTES_CON_PEDIDO_MINIMO/EMPRESA_SELECCIONADA/ACTIVO='E' or MantenimientoEmpresas/PEDIDOSMINIMOS/CLIENTES_CON_PEDIDO_MINIMO/EMPRESA_SELECCIONADA/ACTIVO='I'">
  	        <input type="text" class="campopesquisa w80px" name="EMP_PEDIDOMINIMO" onBlur="ValidarNumero(this,2);" value="{MantenimientoEmpresas/PEDIDOSMINIMOS/CLIENTES_CON_PEDIDO_MINIMO/EMPRESA_SELECCIONADA/IMPORTE}" size="8"/>
  	        <input type="text" class="campopesquisa w80px" name="EMP_PEDIDOMINIMO_NM" onBlur="ValidarNumero(this,2);" value="{MantenimientoEmpresas/PEDIDOSMINIMOS/CLIENTES_CON_PEDIDO_MINIMO/EMPRESA_SELECCIONADA/IMPORTE_NM}" size="8"/>
	      </xsl:when>
	      <xsl:otherwise>
	        <input type="text" class="campopesquisa w80px" name="EMP_PEDIDOMINIMO" disabled="disabled" onBlur="ValidarNumero(this,2);" size="8"/>
	        <input type="text" class="campopesquisa w80px" name="EMP_PEDIDOMINIMO_NM" disabled="disabled" onBlur="ValidarNumero(this,2);" size="8"/>
	      </xsl:otherwise>
   	    </xsl:choose>
   	  </xsl:otherwise>
   	  </xsl:choose>
      </td>
         </tr>
         <tr>
           <td class="labelRight">
             <xsl:value-of select="document($doc)/translation/texts/item[@name='estricto']/node()"/>:&nbsp;
           </td>
           <td>
             <xsl:choose>
               <xsl:when test="/MantenimientoEmpresas/PEDIDOSMINIMOS/ACCION!='MODIFICARCLIENTE' and MantenimientoEmpresas/PEDIDOSMINIMOS/ACCION!='INSERTARCENTRO' and MantenimientoEmpresas/PEDIDOSMINIMOS/ACCION!='MODIFICARCENTRO' and MantenimientoEmpresas/PEDIDOSMINIMOS/ACCION!='GUARDARCENTRO'">
                    <xsl:choose>
                      <xsl:when test="/MantenimientoEmpresas/PEDIDOSMINIMOS/EMP_PEDMINIMO_ACTIVO='S'">
   	                <input type="checkbox" class="muypeq" name="EMP_PEDMINIMOESTRICTO_CHECK" onClick="pedidoMinimo(this.name,document.forms[0]);"/>
   	              </xsl:when>
   	              <xsl:when test="/MantenimientoEmpresas/PEDIDOSMINIMOS/EMP_PEDMINIMO_ACTIVO='E'">
   	                <input type="checkbox" class="muypeq" name="EMP_PEDMINIMOESTRICTO_CHECK" checked="checked" onClick="pedidoMinimo(this.name,document.forms[0]);"/>
   	              </xsl:when>
   	              <xsl:when test="/MantenimientoEmpresas/PEDIDOSMINIMOS/EMP_PEDMINIMO_ACTIVO='I'">
   	                <input type="checkbox" class="muypeq" name="EMP_PEDMINIMOESTRICTO_CHECK" disabled="disabled" onClick="pedidoMinimo(this.name,document.forms[0]);"/>
   	              </xsl:when>
   	              <xsl:otherwise>
   	                <input type="checkbox" class="muypeq" disabled="disabled" name="EMP_PEDMINIMOESTRICTO_CHECK" onClick="pedidoMinimo(this.name,document.forms[0]);"/>
   	              </xsl:otherwise>
   	            </xsl:choose> 
   	          </xsl:when>
   	          <xsl:when test="/MantenimientoEmpresas/PEDIDOSMINIMOS/ACCION='MODIFICARCENTRO' or /MantenimientoEmpresas/PEDIDOSMINIMOS/ACCION='INSERTARCENTRO'">
                    <xsl:choose>
                      <xsl:when test="//CENTRO_SELECCIONADO/ACTIVO='S'">
   	                <input type="checkbox" class="muypeq" name="EMP_PEDMINIMOESTRICTO_CHECK" onClick="pedidoMinimo(this.name,document.forms[0]);"/>
   	              </xsl:when>
   	              <xsl:when test="//CENTRO_SELECCIONADO/ACTIVO='E'">
   	                <input type="checkbox" class="muypeq" name="EMP_PEDMINIMOESTRICTO_CHECK" checked="checked" onClick="pedidoMinimo(this.name,document.forms[0]);"/>
   	              </xsl:when>
   	              <xsl:when test="//CENTRO_SELECCIONADO/ACTIVO='I'">
   	                <input type="checkbox" class="muypeq" name="EMP_PEDMINIMOESTRICTO_CHECK" disabled="disabled" onClick="pedidoMinimo(this.name,document.forms[0]);"/>
   	              </xsl:when>
   	              <xsl:otherwise>
   	                <input type="checkbox" class="muypeq" disabled="disabled" name="EMP_PEDMINIMOESTRICTO_CHECK" onClick="pedidoMinimo(this.name,document.forms[0]);"/>
   	              </xsl:otherwise>
   	            </xsl:choose> 
   	          </xsl:when>
   	          <xsl:otherwise>
   	            <xsl:choose>
                      <xsl:when test="/MantenimientoEmpresas/PEDIDOSMINIMOS/CLIENTES_CON_PEDIDO_MINIMO/EMPRESA_SELECCIONADA/ACTIVO='S'">
   	                <input type="checkbox" class="muypeq" name="EMP_PEDMINIMOESTRICTO_CHECK" onClick="pedidoMinimo(this.name,document.forms[0]);"/>
   	              </xsl:when>
   	              <xsl:when test="/MantenimientoEmpresas/PEDIDOSMINIMOS/CLIENTES_CON_PEDIDO_MINIMO/EMPRESA_SELECCIONADA/ACTIVO='E'">
   	                <input type="checkbox" class="muypeq" name="EMP_PEDMINIMOESTRICTO_CHECK" checked="checked" onClick="pedidoMinimo(this.name,document.forms[0]);"/>
   	              </xsl:when>
   	              <xsl:when test="/MantenimientoEmpresas/PEDIDOSMINIMOS/CLIENTES_CON_PEDIDO_MINIMO/EMPRESA_SELECCIONADA/ACTIVO='I'">
   	                <input type="checkbox" class="muypeq" name="EMP_PEDMINIMOESTRICTO_CHECK" disabled="disabled" onClick="pedidoMinimo(this.name,document.forms[0]);"/>
   	              </xsl:when>
   	              <xsl:otherwise>
   	                <input type="checkbox" class="muypeq" disabled="disabled" name="EMP_PEDMINIMOESTRICTO_CHECK" onClick="pedidoMinimo(this.name,document.forms[0]);"/>
   	              </xsl:otherwise>
   	            </xsl:choose> 
   	          </xsl:otherwise>
   	        </xsl:choose>
   	   </td>
   	   <td class="datosLeft">
       		<xsl:value-of select="document($doc)/translation/texts/item[@name='no_permitir_envio_pedidos_pedido_minimo']/node()"/>.
           </td>
   	 </tr>
   	 <tr>
           <td class="labelRight">
           	<xsl:value-of select="document($doc)/translation/texts/item[@name='no_aceptar_ofertas']/node()"/>:&nbsp;
           </td>
           <td>
             <xsl:choose>
               <xsl:when test="/MantenimientoEmpresas/PEDIDOSMINIMOS/ACCION!='MODIFICARCLIENTE' and MantenimientoEmpresas/PEDIDOSMINIMOS/ACCION!='INSERTARCENTRO' and MantenimientoEmpresas/PEDIDOSMINIMOS/ACCION!='MODIFICARCENTRO' and MantenimientoEmpresas/PEDIDOSMINIMOS/ACCION!='GUARDARCENTRO'">
                 <xsl:choose>
                   <xsl:when test="/MantenimientoEmpresas/PEDIDOSMINIMOS/EMP_PEDMINIMO_ACTIVO='I'">
   	             <input type="checkbox" class="muypeq" checked="checked" name="EMP_INTEGRADO_CHECK" />
   	           </xsl:when>
   	           <xsl:otherwise>
   	             <input type="checkbox" class="muypeq" name="EMP_INTEGRADO_CHECK" />
   	           </xsl:otherwise>
   	         </xsl:choose>
   	       </xsl:when>
   	       <xsl:when test="/MantenimientoEmpresas/PEDIDOSMINIMOS/ACCION='MODIFICARCENTRO'">
   	         <xsl:choose>
                   <xsl:when test="/MantenimientoEmpresas/PEDIDOSMINIMOS/CLIENTES_CON_PEDIDO_MINIMO/EMPRESA_SELECCIONADA/CENTROS_CON_PEDIDO_MINIMO/CENTRO_SELECCIONADO/ACTIVO='I'">
	             <input type="checkbox" class="muypeq" checked="checked" name="EMP_INTEGRADO_CHECK" />
   	           </xsl:when>
   	           <xsl:otherwise>
   	             <input type="checkbox" class="muypeq" name="EMP_INTEGRADO_CHECK" />
   	           </xsl:otherwise>
   	         </xsl:choose>
   	       </xsl:when>
   	       <xsl:otherwise>
   	         <xsl:choose>
                   <xsl:when test="/MantenimientoEmpresas/PEDIDOSMINIMOS/CLIENTES_CON_PEDIDO_MINIMO/EMPRESA_SELECCIONADA/ACTIVO='I'">
   	             <input type="checkbox" class="muypeq" checked="checked" name="EMP_INTEGRADO_CHECK" />
   	           </xsl:when>
   	           <xsl:otherwise>
   	             <input type="checkbox" class="muypeq" name="EMP_INTEGRADO_CHECK" />
   	           </xsl:otherwise>
   	         </xsl:choose>
   	       </xsl:otherwise>
   	     </xsl:choose>
   	   </td>
   	   <td class="datosLeft">
       		<xsl:value-of select="document($doc)/translation/texts/item[@name='permitir_unicamente_envio_pedidos']/node()"/>.
       </td>
      </tr>
      <tr>
     <td class="labelRight">
     	<xsl:value-of select="document($doc)/translation/texts/item[@name='descr_pedido_minimo']/node()"/>:&nbsp;
      </td>
      <td colspan="2" class="datosLeft">
        <xsl:choose>
          <xsl:when test="/MantenimientoEmpresas/PEDIDOSMINIMOS/ACCION!='MODIFICARCLIENTE' and MantenimientoEmpresas/PEDIDOSMINIMOS/ACCION!='INSERTARCENTRO' and MantenimientoEmpresas/PEDIDOSMINIMOS/ACCION!='MODIFICARCENTRO' and MantenimientoEmpresas/PEDIDOSMINIMOS/ACCION!='GUARDARCENTRO'">
            <xsl:choose> 
              <xsl:when test="/MantenimientoEmpresas/PEDIDOSMINIMOS/EMP_PEDMINIMO_ACTIVO='' or MantenimientoEmpresas/PEDIDOSMINIMOS/EMP_PEDMINIMO_ACTIVO='N'">
   	        <textarea name="EMP_DESCRIPCIONPEDIDOMINIMO" cols="60" rows="5" disabled="disabled"></textarea>
   	      </xsl:when>
   	      <xsl:otherwise>
   	        <textarea name="EMP_DESCRIPCIONPEDIDOMINIMO" cols="60" rows="5">
   	        </textarea> 
   	      </xsl:otherwise>
   	    </xsl:choose>    
   	  </xsl:when>
   	  <xsl:when test="/MantenimientoEmpresas/PEDIDOSMINIMOS/ACCION='MODIFICARCENTRO'">
            <xsl:choose> 
              <xsl:when test="/MantenimientoEmpresas/PEDIDOSMINIMOS/CLIENTES_CON_PEDIDO_MINIMO/EMPRESA_SELECCIONADA/CENTROS_CON_PEDIDO_MINIMO/CENTRO_SELECCIONADO/EMP_PEDMINIMO_ACTIVO='' or MantenimientoEmpresas/PEDIDOSMINIMOS/CLIENTES_CON_PEDIDO_MINIMO/EMPRESA_SELECCIONADA/CENTROS_CON_PEDIDO_MINIMO/CENTRO_SELECCIONADO/EMP_PEDMINIMO_ACTIVO='N'">
   	        <textarea name="EMP_DESCRIPCIONPEDIDOMINIMO" cols="60" rows="5" disabled="disabled">
   	        </textarea>
   	      </xsl:when>
   	      <xsl:otherwise>
   	        <textarea name="EMP_DESCRIPCIONPEDIDOMINIMO" cols="60" rows="5">
   	          <xsl:value-of select="/MantenimientoEmpresas/PEDIDOSMINIMOS/CLIENTES_CON_PEDIDO_MINIMO/EMPRESA_SELECCIONADA/CENTROS_CON_PEDIDO_MINIMO/CENTRO_SELECCIONADO/DESCRIPCION"/>
   	        </textarea> 
   	      </xsl:otherwise>
   	    </xsl:choose>
   	  </xsl:when>
   	  <xsl:otherwise>
   	    <xsl:choose> 
              <xsl:when test="/MantenimientoEmpresas/PEDIDOSMINIMOS/CLIENTES_CON_PEDIDO_MINIMO/EMPRESA_SELECCIONADA/EMP_PEDMINIMO_ACTIVO='' or MantenimientoEmpresas/PEDIDOSMINIMOS/CLIENTES_CON_PEDIDO_MINIMO/EMPRESA_SELECCIONADA/EMP_PEDMINIMO_ACTIVO='N'">
   	        <textarea name="EMP_DESCRIPCIONPEDIDOMINIMO" cols="60" rows="5" disabled="disabled">
   	        </textarea>
   	      </xsl:when>
   	      <xsl:otherwise>
   	        <textarea name="EMP_DESCRIPCIONPEDIDOMINIMO" cols="60" rows="5">
   	          <xsl:value-of select="/MantenimientoEmpresas/PEDIDOSMINIMOS/CLIENTES_CON_PEDIDO_MINIMO/EMPRESA_SELECCIONADA/DESCRIPCION"/>
   	        </textarea> 
   	      </xsl:otherwise>
   	    </xsl:choose>
   	  </xsl:otherwise>
   	</xsl:choose>
      </td>
    </tr>
	</table>
      <br/>
      <br />
      <table width="100%">
		<tr align="center">
        	<td class="dies">&nbsp;</td>
              <!--<td>
                <xsl:call-template name="boton">
                  <xsl:with-param name="path" select="/MantenimientoEmpresas/button[@label='Cerrar']"/>
                </xsl:call-template>
              </td>-->
              <xsl:choose>
                <xsl:when test="/MantenimientoEmpresas/PEDIDOSMINIMOS/ACCION='INSERTARCLIENTE' or /MantenimientoEmpresas/PEDIDOSMINIMOS/ACCION='INSERTARCENTRO' or /MantenimientoEmpresas/PEDIDOSMINIMOS/ACCION='MODIFICARCENTRO' or /MantenimientoEmpresas/PEDIDOSMINIMOS/ACCION='GUARDARCENTRO' or /MantenimientoEmpresas/PEDIDOSMINIMOS/ACCION='GUARDARCLIENTE' or /MantenimientoEmpresas/PEDIDOSMINIMOS/ACCION='BORRARCENTRO' or /MantenimientoEmpresas/PEDIDOSMINIMOS/ACCION ='MODIFICARCLIENTE'">
                  <td> 
                  	<!--<div class="boton">-->
                    	<a class="btnNormal" href="javascript:NuevoPedidoMinimoPorCliente(document.forms[0]);"><xsl:value-of select="document($doc)/translation/texts/item[@name='volver_a_empresas']/node()"/></a>
                    <!--</div>-->
                    </td>
                   
                  <xsl:choose>
                  <xsl:when test="(/MantenimientoEmpresas/PEDIDOSMINIMOS/ACCION='INSERTARCLIENTE' or /MantenimientoEmpresas/PEDIDOSMINIMOS/ACCION='INSERTARCENTRO' or /MantenimientoEmpresas/PEDIDOSMINIMOS/ACCION='GUARDARCENTRO' or /MantenimientoEmpresas/PEDIDOSMINIMOS/ACCION='GUARDARCLIENTE' or /MantenimientoEmpresas/PEDIDOSMINIMOS/ACCION='MODIFICARCENTRO') and /MantenimientoEmpresas/PEDIDOSMINIMOS/ACCION!='MODIFICARCLIENTE'">
                      <td>
                        <a class="btnDestacado" href="javascript:ActualizarDatos(document.forms[0],'INSERTARCENTRO');">
                            <xsl:value-of select="document($doc)/translation/texts/item[@name='insertar_centro']/node()"/>
                        </a>
                      </td>
                    </xsl:when>
                    <xsl:when test="/MantenimientoEmpresas/PEDIDOSMINIMOS/ACCION='BORRARCENTRO'">
                       <td>
                        	<a class="btnDestacado" href="javascript:ActualizarDatos(document.forms[0],'INSERTARCENTRO');">
                            	<xsl:value-of select="document($doc)/translation/texts/item[@name='insertar_centro']/node()"/>
                            </a>
                      </td>
                      <!-- <td  align="center">
                        <xsl:call-template name="boton">
                          <xsl:with-param name="path" select="/MantenimientoEmpresas/button[@label='InsertarEmpresa']"/>
                        </xsl:call-template>
                  	   </td>
                      <td align="center">
                          <xsl:call-template name="boton">
                            <xsl:with-param name="path" select="/MantenimientoEmpresas/button[@label='GuardarCentro']"/>
                          </xsl:call-template>
                      </td>-->
                    </xsl:when>
                    <xsl:when test="/MantenimientoEmpresas/PEDIDOSMINIMOS/ACCION='MODIFICARCLIENTE'">
                    	 <td> 
                        	<a class="btnDestacado" href="javascript:ActualizarDatos(document.forms[0],'INSERTARCLIENTE');">
                            	<xsl:value-of select="document($doc)/translation/texts/item[@name='insertar_empresa']/node()"/>
                            </a>
                         </td>
                    </xsl:when>
                  </xsl:choose>
                </xsl:when>
                <xsl:otherwise>
                	<td  align="center">
                    	<a class="btnDestacado" href="javascript:ActualizarDatos(document.forms[0],'INSERTARCLIENTE');">
                    		<xsl:value-of select="document($doc)/translation/texts/item[@name='insertar_empresa']/node()"/>
                    	</a>
                	</td>
                </xsl:otherwise>
              </xsl:choose>
        	<td class="dies">&nbsp;</td>
            </tr>
          </table>
		  <br/>
		  <br/>
		  <br/>
		  <br/>
		  <br/>
		  <br/>
		  <br/>
		  <br/>
		  <br/>
		  <br/>
		  <br/>
		  <br/>
		  &nbsp;
        </form>
        
        <form name="MensajeJS">
        	<input type="hidden" name="RELLENE_IMPORTE_MINIMO_ACTIVO" value="{document($doc)/translation/texts/item[@name='rellene_importe_minimo_activo']/node()}"/>         
            <input type="hidden" name="RELLENE_IMPORTE_MINIMO_NO_ACEPTAR" value="{document($doc)/translation/texts/item[@name='rellene_importe_minimo_no_aceptar']/node()}"/>            
            <input type="hidden" name="SEL_EMPRESA_PEDIDO_MINIMO" value="{document($doc)/translation/texts/item[@name='seleccione_empresa_pedido_minimo']/node()}"/>            
            <input type="hidden" name="SEL_CENTRO_PEDIDO_MINIMO" value="{document($doc)/translation/texts/item[@name='seleccione_centro_pedido_minimo']/node()}"/>            
            <input type="hidden" name="BORRAR_PEDIDO_MINIMO_EMPRESA" value="{document($doc)/translation/texts/item[@name='borrar_pedido_minimo_empresa']/node()}"/>            
            <input type="hidden" name="BORRAR_PEDIDO_MINIMO_CENTRO" value="{document($doc)/translation/texts/item[@name='borrar_pedido_minimo_centro']/node()}"/>            
        </form>
        </xsl:otherwise>
        </xsl:choose>
      </body>
    </html>
  </xsl:template>

</xsl:stylesheet>
