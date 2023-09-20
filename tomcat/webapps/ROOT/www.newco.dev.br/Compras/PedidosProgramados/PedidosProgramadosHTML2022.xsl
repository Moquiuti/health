<?xml version="1.0" encoding="iso-8859-1" ?>
<!--
 	Listado de Pedidos programados. Nuevo disenno 2022
	Ultima revision: ET 23ago22 15:35
 -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:import href = "http://www.newco.dev.br/General/General.xsl" />
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
	<xsl:when test="/PedidosProgramados/LANG != ''"><xsl:value-of select="/PedidosProgramados/LANG" /></xsl:when>
	<xsl:when test="/PedidosProgramados/LANGTESTI != ''"><xsl:value-of select="/PedidosProgramados/LANGTESTI" /></xsl:when>
	<xsl:otherwise>spanish</xsl:otherwise>
	</xsl:choose>  
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--fin idioma-->

	<title><xsl:value-of select="TITULO" disable-output-escaping="yes"/></title>

	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->
    
	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery-3.6.0.js"></script>	
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic2022_010822.js"></script>
	<xsl:text disable-output-escaping="yes"><![CDATA[
	
	<script type="text/javascript">
	  <!--
	    
	function recargarPagina(){
		document.location.href='http://www.newco.dev.br/Compras/PedidosProgramados/PedidosProgramados2022.xsql';
	}


	function MantPedidosProgramados(idPrograma,listaPedidos, listaUsuariosCentro){
		MostrarPag('http://www.newco.dev.br/Compras/PedidosProgramados/MantPedidosProgramados2022.xsql?PEDP_ID='+idPrograma+'&LISTAPEDIDOS='+listaPedidos+'&LISTAUSUARIOSCENTRO='+listaUsuariosCentro+'&VENTANA=NUEVA','pedidosProgramados');
	}

	function VisualizarPedidosProgramados(idPrograma,listaPedidos, listaUsuariosCentro){
		MostrarPag('http://www.newco.dev.br/Compras/PedidosProgramados/VisualizarPedidosProgramados2022.xsql?PEDP_ID='+idPrograma+'&LISTAPEDIDOS='+listaPedidos+'&LISTAUSUARIOSCENTRO='+listaUsuariosCentro+'&VENTANA=NUEVA','pedidosProgramados');
	}

	function MostrarMultioferta(idMultioferta,estadoMultioferta,cadReadOnly){
		var readOnly='';
		if(cadReadOnly!='')
		readOnly='S';

	]]></xsl:text>
	var idSesion='<xsl:value-of select="//SES_ID"/>';
	<xsl:text disable-output-escaping="yes"><![CDATA[

		MostrarPag('http://www.newco.dev.br/Compras/Multioferta/MultiofertaFrame2022.xsql?MO_ID='+idMultioferta,'MultiofertaIncidencia'); 
	}

	function NuevoPrograma(){ 
		//	ET	Para evitar conflictos con pedidos con datos modificados por los proveedores, no permitimos crear programas desde aqui
		//  MostrarPag('http://www.newco.dev.br/Compras/PedidosProgramados/MantPedidosProgramados2022.xsql?PEDP_ID=&IDOFERTAMODELO=&LISTAPEDIDOS=S&LISTAUSUARIOSCENTRO=S&VENTANA=NUEVA','pedidosProgramados');
		alert(document.forms['MensajeJS'].elements['PARA_CREAR_PROGRAMA'].value +':\n1. '+ document.forms['MensajeJS'].elements['IR_MENU_ENVIAR_PEDIDODS'].value +'\n2. '+ document.forms['MensajeJS'].elements['PREPARAR_PEDIDO_PROGRAMMAR'].value +'\n3. '+ document.forms['MensajeJS'].elements['SEGUNDO_PASO_PROGRAMAR'].value);
	}

	function CambiarEstadoPrograma(IDPrograma, Estado)
	{
		document.location.href='http://www.newco.dev.br/Compras/PedidosProgramados/PedidosProgramados2022.xsql?PEDP_ID='+IDPrograma+'&ACCION=CAMBIOESTADO&ESTADO='+Estado;
	}
	   

	   
	  //-->
	</script>
        ]]></xsl:text>
      </head>
      <body>  
       <!--idioma-->
        <xsl:variable name="lang">
        	<xsl:choose>
            <xsl:when test="/PedidosProgramados/LANG != ''"><xsl:value-of select="/PedidosProgramados/LANG" /></xsl:when>
            <xsl:when test="/PedidosProgramados/LANGTESTI != ''"><xsl:value-of select="/PedidosProgramados/LANGTESTI" /></xsl:when>
            <xsl:otherwise>spanish</xsl:otherwise>
            </xsl:choose>  
        </xsl:variable>
        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
         <!--fin idioma-->

		<!--	Titulo de la página		-->
		<div class="ZonaTituloPagina">
			<p class="TituloPagina">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='pedidos_programados']/node()"/>&nbsp;&nbsp;
				&nbsp;&nbsp;
				<span class="CompletarTitulo">
                    <xsl:if test="/PedidosProgramados/LISTAPEDIDOSPROGRAMADOS/ROL != 'VENDEDOR'">
					<a class="btnDestacado" href="javascript:NuevoPrograma();"> 
						<xsl:value-of select="document($doc)/translation/texts/item[@name='nuevo']/node()"/>
					</a>
					</xsl:if>
				</span>
			</p>
		</div>
		<br/>
         
        <xsl:choose>
        	<xsl:when test="PedidosProgramados/SESION_CADUCADA">
        	  <xsl:apply-templates select="FamiliasYProductos/SESION_CADUCADA"/> 
        	</xsl:when>
        	<xsl:otherwise>
				<xsl:if test="/PedidosProgramados/LISTAPEDIDOSPROGRAMADOS/ERRORESPEDIDOSPROGRAMADOS/PEDIDOPROGRAMADO">
		  			<xsl:apply-templates select="/PedidosProgramados/LISTAPEDIDOSPROGRAMADOS/ERRORESPEDIDOSPROGRAMADOS"/>
				</xsl:if>
                
                <!--compruebo si hay pedidos-->
                <xsl:choose>
                <xsl:when test="/PedidosProgramados/LISTAPEDIDOSPROGRAMADOS/PEDIDOSPROGRAMADOSCORRECTOS/PEDIDOPROGRAMADO">
		  			<xsl:apply-templates select="/PedidosProgramados/LISTAPEDIDOSPROGRAMADOS/PEDIDOSPROGRAMADOSCORRECTOS"/>
                </xsl:when>
                <xsl:otherwise>
				
				<br/>
				<br/>
				<h1 align="center"><xsl:value-of select="document($doc)/translation/texts/item[@name='no_hay_pedidos_programados']/node()"/></h1>
                
                </xsl:otherwise>
                </xsl:choose>
        	</xsl:otherwise>
        </xsl:choose>
        
        <form name="MensajeJS">
        <input type="hidden" name="PARA_CREAR_PROGRAMA" value="{document($doc)/translation/texts/item[@name='para_crear_programa']/node()}"/>
        
        <input type="hidden" name="IR_MENU_ENVIAR_PEDIDODS" value="{document($doc)/translation/texts/item[@name='ir_menu_enviar_pedidos']/node()}"/>
        <input type="hidden" name="PREPARAR_PEDIDO_PROGRAMMAR" value="{document($doc)/translation/texts/item[@name='preparar_pedido_programar']/node()}"/>
        
        <input type="hidden" name="SEGUNDO_PASO_PROGRAMAR" value="{document($doc)/translation/texts/item[@name='segundo_paso_pragramar']/node()}"/>
    	</form>
      </body>
    </html>
</xsl:template>  

<xsl:template match="PEDIDOSPROGRAMADOSCORRECTOS">
   <!--idioma-->
     <xsl:variable name="lang">
    <xsl:choose>
        <xsl:when test="/PedidosProgramados/LANG"><xsl:value-of select="/PedidosProgramados/LANG" /></xsl:when>
        <xsl:otherwise>spanish</xsl:otherwise>
        </xsl:choose>  
    </xsl:variable>

    <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>        <!--idioma fin-->
    	<xsl:if test="/PedidosProgramados/LISTAPEDIDOSPROGRAMADOS/ROL = 'VENDEDOR'"><!--si es prove veo text informativo-->
            <table class="infoTableAma">
             <tr>
                <td><p style="text-align:center;color:#F00;font-weight:bold;"><xsl:value-of select="document($doc)/translation/texts/item[@name='pedidos_programados_texto_informativo']/node()"/></p></td>
            </tr>
            </table>
        </xsl:if>
        <div class="divLeft"> 
			<div class="tabela tabela_redonda">
			<table cellspacing="6px" cellpadding="6px">
				<thead class="cabecalho_tabela">
				<tr>
					<th class="w1px"></th>
		          	<th class="textCenter w120px">
						<xsl:copy-of select="document($doc)/translation/texts/item[@name='proxima_entrega_2line']/node()"/>
					</th>
                	<th class="textLeft">
                    	<xsl:value-of select="document($doc)/translation/texts/item[@name='centro']/node()"/>
					</th>
                    <th class="w50px"><xsl:copy-of select="document($doc)/translation/texts/item[@name='numero']/node()"/></th>
                    <th class="w1px">&nbsp;</th>
                	<th class="textLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='nombre']/node()"/></th>
                	<th class="w50px"><xsl:copy-of select="document($doc)/translation/texts/item[@name='inicio']/node()"/></th>
                	<th class="w50px"><xsl:copy-of select="document($doc)/translation/texts/item[@name='fin']/node()"/></th>
                	<xsl:choose><!--si es proveedor no enseño proveedor-->
                    	<xsl:when test="/PedidosProgramados/LISTAPEDIDOSPROGRAMADOS/ROL = 'VENDEDOR'">
                       		<th class="w1px">&nbsp;</th>
                        </xsl:when>
                        <xsl:otherwise>
                        	 <th class="w150px textLeft">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/></th>
                        </xsl:otherwise>
                    </xsl:choose>
                    <xsl:choose><!--si es proveedor no enseño si esta visible-->
                    	<xsl:when test="/PedidosProgramados/LISTAPEDIDOSPROGRAMADOS/ROL = 'VENDEDOR'">
                       		<th class="uno">&nbsp;</th>
                        </xsl:when>
                        <xsl:otherwise>
                        	 <th class="tres"><xsl:value-of select="document($doc)/translation/texts/item[@name='visible_proveedor']/node()"/></th>
                        </xsl:otherwise>
                    </xsl:choose>
                	<th class="w60px"><xsl:value-of select="document($doc)/translation/texts/item[@name='importe']/node()"/></th>
                	<th class="w50px"><xsl:value-of select="document($doc)/translation/texts/item[@name='periodo']/node()"/></th>
                	<th class="w50px"><xsl:copy-of select="document($doc)/translation/texts/item[@name='ultima_entrega_2line']/node()"/></th>
                	<xsl:choose><!--si es proveedor no enseño confirmar-->
                    	<xsl:when test="/PedidosProgramados/LISTAPEDIDOSPROGRAMADOS/ROL = 'VENDEDOR'">
                        	<th class="w1px">&nbsp;</th>
                        </xsl:when>
                        <xsl:otherwise>
                        	<th class="w30px"><xsl:value-of select="document($doc)/translation/texts/item[@name='confirmar']/node()"/></th>
                        </xsl:otherwise>
                    </xsl:choose>
				</tr>
            </thead>
			<tbody class="corpo_tabela">
    		<xsl:for-each select="PEDIDOPROGRAMADO">
				<tr class="conhover">
				<td class="color_status">&nbsp;</td>
				<td>
				  <xsl:choose>
					<xsl:when test="NOEDICION or /PedidosProgramados/LISTAPEDIDOSPROGRAMADOS/ROL = 'VENDEDOR'">
					  <a href="javascript:VisualizarPedidosProgramados({ID},'N','N');"  onMouseOver="window.status='Permite visualizar la programación del pedido';return true;" onMouseOut="window.status='';return true;">
                          <xsl:choose>
							<xsl:when test="PROGRAMAFINALIZADO"><xsl:value-of select="document($doc)/translation/texts/item[@name='finalizado']/node()"/></xsl:when>
							<xsl:when test="INACTIVO='S'"><xsl:value-of select="document($doc)/translation/texts/item[@name='inactivo']/node()"/></xsl:when>
							<xsl:otherwise><xsl:value-of select="DIAENTREGA"/></xsl:otherwise>
						  </xsl:choose>
						</a>
					</xsl:when>
                    <xsl:when test="/PedidosProgramados/LISTAPEDIDOSPROGRAMADOS/IDUSUARIO != IDUSUARIO and not /PedidosProgramados/LISTAPEDIDOSPROGRAMADOS/MVM">
					  <a href="javascript:VisualizarPedidosProgramados({ID},'N','N');"  onMouseOver="window.status='Permite visualizar la programación del pedido';return true;" onMouseOut="window.status='';return true;">
                          <xsl:choose>
							<xsl:when test="PROGRAMAFINALIZADO"><xsl:value-of select="document($doc)/translation/texts/item[@name='finalizado']/node()"/></xsl:when>
							<xsl:when test="INACTIVO='S'"><xsl:value-of select="document($doc)/translation/texts/item[@name='inactivo']/node()"/></xsl:when>
							<xsl:otherwise><xsl:value-of select="DIAENTREGA"/></xsl:otherwise>
						  </xsl:choose>
						</a>
					</xsl:when>
					<xsl:otherwise><!--es editable el programa-->
						<a href="javascript:MantPedidosProgramados({ID},'N','S');"  onMouseOver="window.status='Permite editar la programación del pedido';return true;" onMouseOut="window.status='';return true;">
						  <xsl:choose>
							<xsl:when test="PROGRAMAFINALIZADO"><xsl:value-of select="document($doc)/translation/texts/item[@name='finalizado']/node()"/></xsl:when>
							<xsl:when test="INACTIVO='S'"><xsl:value-of select="document($doc)/translation/texts/item[@name='inactivo']/node()"/></xsl:when>
							<xsl:otherwise><xsl:value-of select="DIAENTREGA"/></xsl:otherwise>
						  </xsl:choose>
						</a>
						&nbsp;
						<xsl:choose>
							<xsl:when test="INACTIVO='S'">
								<a href="javascript:CambiarEstadoPrograma({ID},'ACTIVO');"><img src="http://www.newco.dev.br/images/2017/reload.png" border="0"/></a>
								<a href="javascript:CambiarEstadoPrograma({ID},'BORRADO');"><img src="http://www.newco.dev.br/images/2017/trash.png" border="0"/></a>
							</xsl:when>
							<xsl:when test="INACTIVO='N'"><a href="javascript:CambiarEstadoPrograma({ID},'DESACTIVADO');"><img src="http://www.newco.dev.br/images/2022/icones/parar.png" border="0"/></a></xsl:when>
						</xsl:choose>
					  </xsl:otherwise>
					</xsl:choose>
				</td>
                <td class="textLeft">  
                <a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/CENDetalle2022.xsql?ID={IDCENTRO}&amp;VENTANA=NUEVA','DetalleEmpresa',100,80,0,0);">
                <xsl:value-of select="CENTRO"/></a>&nbsp;
                </td>
                <!--quitado 17-12-2015   <td><xsl:value-of select="USUARIO"/>&nbsp;</td>-->
            	<td align="center">
					<xsl:choose>
					<xsl:when test="NOEDICION or /PedidosProgramados/LISTAPEDIDOSPROGRAMADOS/ROL = 'VENDEDOR'">
						<a href="javascript:VisualizarPedidosProgramados({ID},'N','N');"  onMouseOver="window.status='Permite visualizar la programación del pedido';return true;" onMouseOut="window.status='';return true;">
							<xsl:value-of select="NUMERO"/>
						</a>
					</xsl:when>
					<xsl:when test="/PedidosProgramados/LISTAPEDIDOSPROGRAMADOS/IDUSUARIO != IDUSUARIO and not /PedidosProgramados/LISTAPEDIDOSPROGRAMADOS/MVM">
						<a href="javascript:VisualizarPedidosProgramados({ID},'N','N');"  onMouseOver="window.status='Permite visualizar la programación del pedido';return true;" onMouseOut="window.status='';return true;">
							<xsl:value-of select="NUMERO"/>
						</a>
					</xsl:when>
					<xsl:otherwise><!--si usuario mismo conectado mismo del pedido si puede editar si no no.-->
						<a href="javascript:MantPedidosProgramados({ID},'N','S');"  onMouseOver="window.status='Permite editar la programación del pedido';return true;" onMouseOut="window.status='';return true;">
							<xsl:value-of select="NUMERO"/>
						</a>
					</xsl:otherwise>
					</xsl:choose>&nbsp;
                </td>

                <!--ver pedido-->
                <td>
					<xsl:choose>
					<xsl:when test="NOEDICION">
					  <a href="javascript:MostrarMultioferta('{IDOFERTAMODELO}','{ESTADO}','RO-')" title="Ver pedido">
    					  <img src="http://www.newco.dev.br/images/iconVerPedido.gif" alt="Ver pedido" />
					  </a>
					</xsl:when>
					<xsl:otherwise>
					   <a href="javascript:MostrarMultioferta('{IDOFERTAMODELO}','{ESTADO}','RO-')" title="Ver pedido">
    					  <img src="http://www.newco.dev.br/images/iconVerPedido.gif" alt="Ver pedido" />
					  </a>
					</xsl:otherwise>
					</xsl:choose>
                </td>
                <!--nombre -->
				<td class="textLeft">
					<xsl:choose>
					<xsl:when test="NOEDICION or /PedidosProgramados/LISTAPEDIDOSPROGRAMADOS/ROL = 'VENDEDOR'">
						<a href="javascript:VisualizarPedidosProgramados({ID},'N','N');"  onMouseOver="window.status='Permite visualizar la programación del pedido';return true;" onMouseOut="window.status='';return true;">
							<xsl:value-of select="DESCRIPCION"/>
						</a>
					</xsl:when>
					<xsl:when test="/PedidosProgramados/LISTAPEDIDOSPROGRAMADOS/IDUSUARIO != IDUSUARIO and not /PedidosProgramados/LISTAPEDIDOSPROGRAMADOS/MVM">
						<a href="javascript:VisualizarPedidosProgramados({ID},'N','N');"  onMouseOver="window.status='Permite visualizar la programación del pedido';return true;" onMouseOut="window.status='';return true;">
							<xsl:value-of select="DESCRIPCION"/>
						</a>
					</xsl:when>
					<xsl:otherwise><!--si usuario mismo conectado mismo del pedido si puede editar si no no.-->
						<a href="javascript:MantPedidosProgramados({ID},'N','S');"  onMouseOver="window.status='Permite editar la programación del pedido';return true;" onMouseOut="window.status='';return true;">
							<xsl:value-of select="DESCRIPCION"/>
						</a>
					</xsl:otherwise>
					</xsl:choose>
				</td>
            	<td>
					<xsl:value-of select="INICIOPROGRAMA"/>
            	</td>
            	<td>
					&nbsp;<xsl:value-of select="FINPROGRAMA"/>
            	</td>
            	<td class="textLeft">
                <xsl:choose><!--si es proveedor no enseño proveedor-->
                <xsl:when test="/PedidosProgramados/LISTAPEDIDOSPROGRAMADOS/ROL = 'VENDEDOR'"> </xsl:when>
                <xsl:otherwise>
                    &nbsp;
                	<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPDetalle2022.xsql?EMP_ID={IDPROVEEDOR}&amp;ESTADO=CABECERA&amp;VENTANA=NUEVA','DetalleEmpresa',100,80,0,0);" onmouseover="window.status='Ver información sobre el proveedor';return true;">
                        <xsl:value-of select="PROVEEDOR"/>
                        </a>
            	    &nbsp;
                </xsl:otherwise>
                </xsl:choose>
            	</td>
                <td>
                <xsl:choose><!--si es proveedor no enseño si esta visible al provee-->
                <xsl:when test="/PedidosProgramados/LISTAPEDIDOSPROGRAMADOS/ROL = 'VENDEDOR'"> </xsl:when>
                <xsl:otherwise>
                	<xsl:value-of select="VISIBLE"/>
                </xsl:otherwise>
                </xsl:choose>
            	</td>
            	<td class="textRight"><xsl:value-of select="SUBTOTAL"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='eur']/node()"/></td>
            	<td><xsl:value-of select="TIPOPERIODO"/>&nbsp;</td>
            	<td>
            	  &nbsp;
                	<xsl:choose>
                	  <xsl:when test="ULTIMOLANZAMIENTO=''">
                		---
                	  </xsl:when>
                	  <xsl:otherwise>
                		<xsl:value-of select="ULTIMAENTREGA"/>
                	  </xsl:otherwise>
                	</xsl:choose>
            	  &nbsp;
            	</td>
            	<td>
                 <xsl:choose>
                <xsl:when test="/PedidosProgramados/LISTAPEDIDOSPROGRAMADOS/ROL = 'VENDEDOR'"> </xsl:when><!--si es proveedor no enseño proveedor-->
                <xsl:otherwise>
                	 &nbsp;
            	  <xsl:choose>
                	<xsl:when test="CONFIRMAR='S'">
                	  <xsl:value-of select="document($doc)/translation/texts/item[@name='si']/node()"/>
                	</xsl:when>
                	<xsl:otherwise>
                	  <xsl:value-of select="document($doc)/translation/texts/item[@name='no']/node()"/>
                	</xsl:otherwise>
            	  </xsl:choose>
            	 &nbsp;
                </xsl:otherwise>
                </xsl:choose>
            	</td>
			</tr>
		</xsl:for-each>	 
        </tbody>   
 		<tfoot class="rodape_tabela">
			<tr><td colspan="15">&nbsp;</td></tr>
		</tfoot>
	</table> 
	</div>
	</div>
</xsl:template>  

<xsl:template match="ERRORESPEDIDOSPROGRAMADOS">
 <!--idioma-->
         <xsl:variable name="lang">
        <xsl:choose>
            <xsl:when test="/PedidosProgramados/LANG"><xsl:value-of select="/PedidosProgramados/LANG" /></xsl:when>
            <xsl:otherwise>spanish</xsl:otherwise>
            </xsl:choose>  
        </xsl:variable>

        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>        <!--idioma fin-->
        
        
         <div class="divLeft" style="border-top:1px solid grey;border-bottom:1px solid grey;">           
            <table class="infoTable incidencias" cellspacing="0" style="margin:.3%;width:99.4%;border:none;">
            <tr>
                <td class="titleAzul">
                    <xsl:value-of select="document($doc)/translation/texts/item[@name='errores_en_pedidos_programados']/node()"/>
                </td>
            </tr>
            </table>
                
		<table class="grandeInicio">
        		<thead>
    			<tr class="titulos">
                	<td class="dies"><xsl:value-of select="document($doc)/translation/texts/item[@name='numero_programa']/node()"/></td>
                	<td class="quince"><xsl:value-of select="document($doc)/translation/texts/item[@name='centro']/node()"/></td>
                    <xsl:choose><!--si es proveedor no enseño proveedor-->
                    	<xsl:when test="/PedidosProgramados/LISTAPEDIDOSPROGRAMADOS/ROL = 'VENDEDOR'">
                       		<td class="uno">&nbsp;</td>
                        </xsl:when>
                        <xsl:otherwise> 
                        	<td class="quince"><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/></td>
                        </xsl:otherwise>
                    </xsl:choose>
                	<td class="quince"><xsl:value-of select="document($doc)/translation/texts/item[@name='nombre_del_programa']/node()"/></td>
                	<td class="dies"><xsl:value-of select="document($doc)/translation/texts/item[@name='referencia']/node()"/></td>
                	<td class="textLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='errores_localizados']/node()"/></td>
				</tr>
                </thead>
                <tbody>
    			<xsl:for-each select="PEDIDOPROGRAMADO">
				<tr>
                	<td>&nbsp;
                    <xsl:choose>
						  <xsl:when test="/PedidosProgramados/LISTAPEDIDOSPROGRAMADOS/PEDIDOSPROGRAMADOSCORRECTOS/PEDIDOPROGRAMADO[1]/NOEDICION">
					    	<a href="javascript:VisualizarPedidosProgramados({ID},'N','N');"  onMouseOver="window.status='Permite visualizar la programación del pedido';return true;" onMouseOut="window.status='';return true;">
						    	<xsl:value-of select="NUMERO"/>
							  </a>
						  </xsl:when>
						  <xsl:otherwise>
							  <a href="javascript:MantPedidosProgramados({ID},'N','S');"  onMouseOver="window.status='Permite editar la programación del pedido';return true;" onMouseOut="window.status='';return true;">
						    	<xsl:value-of select="NUMERO"/>
							  </a>
							</xsl:otherwise>
						  </xsl:choose>
                     </td>
					<td>&nbsp;<xsl:value-of select="CENTRO"/></td>
                    <td>
                     <xsl:choose><!--si es proveedor no enseño proveedor-->
                    	<xsl:when test="/PedidosProgramados/LISTAPEDIDOSPROGRAMADOS/ROL = 'VENDEDOR'">
                       		<td class="uno">&nbsp;</td>
                        </xsl:when>
                        <xsl:otherwise> 
                        	 &nbsp;<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPDetalle2022.xsql?EMP_ID={IDPROVEEDOR}&amp;ESTADO=CABECERA&amp;VENTANA=NUEVA','DetalleEmpresa',100,80,0,0);" onmouseover="window.status='Ver información sobre el proveedor';return true;">
                    	<xsl:value-of select="PROVEEDOR"/>
                        </a>
                        </xsl:otherwise>
                    </xsl:choose>
                    
                    </td>
					<td>&nbsp;<xsl:value-of select="PROGRAMA"/></td>
					<td>&nbsp;<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Productos/PRODetalle2022.xsql?PRO_ID={IDPRODUCTO}','producto',100,80,0,0)">
                    <xsl:value-of select="REFERENCIA"/></a>
                    </td>
					<td class="textLeft">&nbsp;<xsl:value-of select="CONTROLERRORES"/></td>
				</tr>
			</xsl:for-each>	    
            </tbody>
      </table> 
      
         </div>
        	
</xsl:template>  
  
</xsl:stylesheet>
