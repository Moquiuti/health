<?xml version="1.0" encoding="iso-8859-1" ?>
<!--
 	Pedidos especiales: Primeros pedidos, muestras, primer pedido en respuesta a una muestra
  +-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href = "http://www.newco.dev.br/General/General.xsl" />
  <xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
  <xsl:param name="lang" select="@lang"/>  
  <xsl:template match="/">
    <html>
      <head>
      
	<title><xsl:value-of select="TITULO" disable-output-escaping="yes"/></title>
     <!--style-->
      <xsl:call-template name="estiloIndip"/>
      <!--fin de style-->  
	  
	  	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
        <script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>
    
	<xsl:text disable-output-escaping="yes"><![CDATA[
        
       <script type="text/javascript">
	
	<!-- 

		function Enviar()
		{ 
			var form=document.forms[0];
			SubmitForm(form);
		}

		function Buscar()
		{ 
			document.getElementById('PAGINA').value = 0;
			Enviar();
		}
		
		function Atras()
		{
			var form=document.forms[0];
			document.getElementById('PAGINA').value = parseInt(document.getElementById('PAGINA').value)-1;
			Enviar();
		}
		
		function Adelante()
		{
			var form=document.forms[0];
			document.getElementById('PAGINA').value =  parseInt(document.getElementById('PAGINA').value)+1;
			Enviar();
		}

		function OrdenarPor(Orden)
		{
			var form=document.forms[0];

			if (form.elements['ORDEN'].value==Orden)
			{
				if (form.elements['SENTIDO'].value=='ASC') form.elements['SENTIDO'].value='DESC';
				else  form.elements['SENTIDO'].value='ASC';
			}
			else
			{
				form.elements['ORDEN'].value=Orden; 
				form.elements['SENTIDO'].value='ASC';
			}	
			Enviar();
		}
		
		        -->
        </script>
        
        
        ]]></xsl:text>
      </head>
      <body>
        <!--idioma-->
         <xsl:variable name="lang">
        <xsl:choose>
            <xsl:when test="/PedidosEspeciales/LANG"><xsl:value-of select="/PedidosEspeciales/LANG" /></xsl:when>
            <xsl:otherwise>spanish</xsl:otherwise>
            </xsl:choose>  
        </xsl:variable>

        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>        <!--idioma fin-->
      
            
		<form action="PedidosEspeciales.xsql" method="POST" name="form1">


		<!--	Titulo de la página		-->
		<div class="ZonaTituloPagina">
			<p class="Path"><xsl:value-of select="document($doc)/translation/texts/item[@name='Inicio']/node()"/>&nbsp;/&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='gestion']/node()"/>&nbsp;/&nbsp;<span class="FinPath"><xsl:value-of select="document($doc)/translation/texts/item[@name='seguimiento_pedidos_especiales']/node()"/></span></p>
			<p class="TituloPagina">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='seguimiento_pedidos_especiales']/node()"/>
				<span class="CompletarTitulo">
					(<xsl:value-of select="document($doc)/translation/texts/item[@name='lineas_encontradas']/node()"/>: <xsl:value-of select="/PedidosEspeciales/PEDIDOSESPECIALES/TOTAL"/>)
					&nbsp;
					<!--	botones	-->
					<a class="btnNormal" href="javascript:print();"><xsl:value-of select="document($doc)/translation/texts/item[@name='imprimir']/node()"/></a>
				</span>
			</p>
		</div>
		<br/>
		<br/>
        
        <!--
		<h1 class="titlePage"><xsl:value-of select="document($doc)/translation/texts/item[@name='seguimiento_pedidos_especiales']/node()"/> (<xsl:value-of select="document($doc)/translation/texts/item[@name='lineas_encontradas']/node()"/>: <xsl:value-of select="/PedidosEspeciales/PEDIDOSESPECIALES/TOTAL"/>)</h1>
		-->
		<input type="hidden" id="ORDEN" name="ORDEN" value="{/PedidosEspeciales/PEDIDOSESPECIALES/FILTROS/ORDEN}" />
		<input type="hidden" id="SENTIDO" name="SENTIDO" value="{/PedidosEspeciales/PEDIDOSESPECIALES/FILTROS/SENTIDO}" />
		<input type="hidden" id="PAGINA" name="PAGINA" value="{/PedidosEspeciales/PEDIDOSESPECIALES/FILTROS/PAGINA}" />
        
        <div class="divLeft">
		
        	<!--<table class="grandeInicio">-->
        	<table class="buscador">
                <tr class="filtros">
					<th colspan="7" height="40px;">
						<label><xsl:value-of select="document($doc)/translation/texts/item[@name='control_de_pedidos']/node()"/>:&nbsp;</label>
						<xsl:call-template name="desplegable"> 
						<xsl:with-param name="id" value="FIDTIPO"/>
						<xsl:with-param name="path" select="/PedidosEspeciales/PEDIDOSESPECIALES/FILTROS_DESPLEGABLES/FIDTIPO/field" />
						</xsl:call-template>
						&nbsp;&nbsp;&nbsp;<label><xsl:value-of select="document($doc)/translation/texts/item[@name='plazo']/node()"/>:&nbsp;</label>
						<xsl:call-template name="desplegable"> 
						<xsl:with-param name="id" value="FIDPLAZO"/>
						<xsl:with-param name="path" select="/PedidosEspeciales/PEDIDOSESPECIALES/FILTROS_DESPLEGABLES/FIDPLAZO/field" />
						</xsl:call-template>
                    <!--<div class="boton">
						<xsl:call-template name="botonPersonalizado">
							<xsl:with-param name="funcion">Buscar();</xsl:with-param>
							<xsl:with-param name="label">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='buscar']/node()"/>&nbsp;</xsl:with-param>
	                        <xsl:with-param name="status">Buscar las lineas de pedidos</xsl:with-param>
						</xsl:call-template>
                    </div>-->
						&nbsp;&nbsp;&nbsp;<a class="btnDestacado" href="javascript:Buscar();"><xsl:value-of select="document($doc)/translation/texts/item[@name='buscar']/node()"/></a>		
					</th>
					<th>&nbsp;</th>
			    </tr>
                <!--<tr class="titulos">-->
                <tr class="subTituloTabla">
				    <th class="ocho">
                    <a href="javascript:OrdenarPor('FECHA');"><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha']/node()"/></a>&nbsp;
				</th>
					<xsl:choose>
						<xsl:when test="/PedidosEspeciales/PEDIDOSESPECIALES/FILTROS/TIPO='MSP'">
				    	<th class="cinco">
                        	<xsl:value-of select="document($doc)/translation/texts/item[@name='cod_muest']/node()"/>
						</th>
						</xsl:when>
						<xsl:when test="/PedidosEspeciales/PEDIDOSESPECIALES/FILTROS/TIPO='M+P'">
				    		<th class="cinco">
								<xsl:value-of select="document($doc)/translation/texts/item[@name='muestras']/node()"/>
							</th>
				    		<th class="cinco">
								<xsl:value-of select="document($doc)/translation/texts/item[@name='cod_ped']/node()"/>
							</th>
						</xsl:when>
						<xsl:otherwise>
				    		<th class="cinco">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='cod_ped']/node()"/>
							</th>
						</xsl:otherwise>
					</xsl:choose>
				 <th class="veinte" align="left">
                     <a href="javascript:OrdenarPor('CLIENTE');"><xsl:value-of select="document($doc)/translation/texts/item[@name='cliente']/node()"/></a>&nbsp;
				</th>
				<th class="quince" align="left">
                    <a href="javascript:OrdenarPor('CENTRO');"><xsl:value-of select="document($doc)/translation/texts/item[@name='centro']/node()"/></a>&nbsp;
				</th>
				<th class="dieciseis" align="left">
                    <a href="javascript:OrdenarPor('PROVEEDOR');"><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/></a>&nbsp;
				</th>
				<th class="ocho"><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_estandar']/node()"/></th>
				<th class="ocho"><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_proveedor']/node()"/></th>
				<th class="veinte" align="left">
                   <a href="javascript:OrdenarPor('PRODUCTO');"><xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/></a>&nbsp;
				</th>
		</tr>
                <tr style="border-bottom:5px solid #e4e4e5; height:40px;">
                    <th>&nbsp;</th>
                    <th>&nbsp;</th>
					<xsl:if test="/PedidosEspeciales/PEDIDOSESPECIALES/FILTROS/TIPO='M+P'">
						<th>&nbsp;</th>
					</xsl:if>
                    <th align="left">
						<xsl:call-template name="desplegable"> 
						<xsl:with-param name="id" value="FIDEMPRESA"/>
						<xsl:with-param name="path" select="/PedidosEspeciales/PEDIDOSESPECIALES/FILTROS_DESPLEGABLES/FIDEMPRESA/field" />
						</xsl:call-template>
					</th>
					<th align="left">
						<xsl:call-template name="desplegable"> 
						<xsl:with-param name="id" value="FIDCENTRO"/>
						<xsl:with-param name="path" select="/PedidosEspeciales/PEDIDOSESPECIALES/FILTROS_DESPLEGABLES/FIDCENTRO/field" />
						</xsl:call-template>
					</th>
					<th align="left">
						<xsl:call-template name="desplegable"> 
						<xsl:with-param name="id" value="FIDPROVEEDOR"/>
						<xsl:with-param name="path" select="/PedidosEspeciales/PEDIDOSESPECIALES/FILTROS_DESPLEGABLES/FIDPROVEEDOR/field" />
						</xsl:call-template>
					</th>
                    <th><input type="text" id="FREFERENCIA" class="peq" name="FREFERENCIA" maxlength="20" size="10" value="{/PedidosEspeciales/PEDIDOSESPECIALES/FILTROS/REFERENCIA}" /></th>
                    <th><input type="text" id="FREFPROVEEDOR" class="peq" name="FREFPROVEEDOR" maxlength="20" size="10" value="{/PedidosEspeciales/PEDIDOSESPECIALES/FILTROS/REFPROVEEDOR}" /></th>
					<th align="left">
						<xsl:call-template name="desplegable"> 
						<xsl:with-param name="id" value="FIDPRODUCTO"/>
						<xsl:with-param name="path" select="/PedidosEspeciales/PEDIDOSESPECIALES/FILTROS_DESPLEGABLES/FIDPRODUCTO/field" />
						</xsl:call-template>
					</th>
                                            <th colspan="4">&nbsp;</th>
                                            </tr>
					<xsl:for-each select="PedidosEspeciales/PEDIDOSESPECIALES/LINEAPEDIDO">
					<tr>
						<td><xsl:value-of select="FECHA"/></td>
						<xsl:if test="/PedidosEspeciales/PEDIDOSESPECIALES/FILTROS/TIPO='M+P'">
							<td>
								<a>
								<xsl:attribute name="href">javascript:MostrarPag('<xsl:value-of select="ENLACEMUESTRA"/>&amp;SES_ID=<xsl:value-of select="//SES_ID"/>','Multioferta')</xsl:attribute>
								<xsl:attribute name="onMouseOver">window.status='Ver tarea';return true;</xsl:attribute>
								<xsl:attribute name="onMouseOut">window.status='';return true;</xsl:attribute>
								<xsl:value-of select="CODIGOMUESTRA"/>
								</a>
							</td>
						</xsl:if>
						<td>
							<a>
								<xsl:attribute name="href">javascript:MostrarPag('<xsl:value-of select="ENLACETAREA"/>&amp;SES_ID=<xsl:value-of select="//SES_ID"/>','Multioferta')</xsl:attribute>
								<xsl:attribute name="onMouseOver">window.status='Ver tarea';return true;</xsl:attribute>
								<xsl:attribute name="onMouseOut">window.status='';return true;</xsl:attribute>
								<xsl:value-of select="CODIGOPEDIDO"/>
							</a>
						</td>
						<td class="textLeft">
							<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPDetalleFrame.xsql?EMP_ID={IDCLIENTE}&amp;VENTANA=NUEVA','Cliente',100,80,0,0);">
								<xsl:value-of select="CLIENTE"/>
                                                            </a>
						</td>
						<td class="textLeft"><xsl:value-of select="CENTROCLIENTE"/></td>
						<td class="textLeft">
							<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPDetalleFrame.xsql?EMP_ID={IDPROVEEDOR}&amp;VENTANA=NUEVA','Cliente',100,80,0,0);">
								<xsl:value-of select="PROVEEDOR"/>
                                                            </a>
                                                    </td>
						<td><xsl:value-of select="REFERENCIA"/></td>
						<td><xsl:value-of select="REFPROVEEDOR"/></td>
						<td class="textLeft">
							<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Productos/PRODetalle.xsql?PRO_ID={IDPRODUCTO}','producto',100,80,0,0);">
								<xsl:value-of select="PRODUCTO"/>
                                                            </a>
                                                    </td>
					</tr>	
					</xsl:for-each>
            </table><!--fin de grndeInicio tabla resumen con buscador-->
                
        				<div class="divLeft" style="margin-top:15px;">
                       
                        	<div class="divLeft10">&nbsp;</div>
                        	<div class="divLeft20">
                            <xsl:text>&nbsp;</xsl:text>
								<xsl:if test="/PedidosEspeciales/PEDIDOSESPECIALES/BOTONES/PAGINAANTERIOR">
                                	<img src="/images/anterior.gif" />&nbsp;
									<xsl:call-template name="botonNostyle">
									<xsl:with-param name="path" select="/PedidosEspeciales/botones/button[@label='NavegarAtras']"/>
									</xsl:call-template>
								</xsl:if>
							</div>
                            <div class="divLeft50nopa">&nbsp;</div>
                            <div class="divLeft20">
                            	<xsl:if test="/PedidosEspeciales/PEDIDOSESPECIALES/BOTONES/PAGINASIGUIENTE">
                                <img src="/images/siguiente.gif" />&nbsp;
									<xsl:call-template name="botonNostyle">
									<xsl:with-param name="path" select="/PedidosEspeciales/botones/button[@label='NavegarAdelante']"/>
									</xsl:call-template>								

								</xsl:if>
							</div>
                             <br /><br />
                          </div><!--fin de divLeft buttons-->
                          
                    
				<!--	Estadísticas de resumen		-->
        				<div class="divLeft">
                          <div class="divLeft30" style="margin-left:10%;">
                          <!--primera tabla-->
       							<!--<table class="infotable borderTable">-->
       							<table class="buscador">
            					<tr class="subTituloTabla">
									<td colspan="2"><xsl:value-of select="document($doc)/translation/texts/item[@name='estadisticas_por_empresa']/node()"/></td>
								</tr>
								<xsl:for-each select="PedidosEspeciales/PEDIDOSESPECIALES/ESTADISTICAS/ESTADISTICAS_EMPRESAS/EMPRESA">
								<xsl:if test="ID!='-1'">
            						<tr class="body">
										<td class="label">&nbsp;&nbsp;&nbsp;<xsl:value-of select="NOMBRE"/></td>
										<td><xsl:value-of select="TOTAL"/></td>
									</tr>
								</xsl:if>
								</xsl:for-each>
								</table>
                             </div>
                            
							<!--segunda tabla-->
                             <div class="divLeft30" style="margin-left:10%;">
		   					  <table class="buscador">
            					<tr class="subTituloTabla">
									<td colspan="2"><xsl:value-of select="document($doc)/translation/texts/item[@name='estadisticas_por_centro']/node()"/></td>
								</tr>
								<xsl:for-each select="PedidosEspeciales/PEDIDOSESPECIALES/ESTADISTICAS/ESTADISTICAS_CENTROS/CENTRO">
								<xsl:if test="ID!='-1'">
            						<tr class="body">
										<td class="label">&nbsp;&nbsp;&nbsp;<xsl:value-of select="NOMBRE"/></td>
										<td><xsl:value-of select="TOTAL"/></td>
									</tr>
								</xsl:if>
								</xsl:for-each>
								</table>
                              </div>

							<!--tercera tabla-->
                             <div class="divLeft30" style="margin-left:10%;">
       							<table class="buscador">
            					<tr class="subTituloTabla">
									<td colspan="2"><xsl:value-of select="document($doc)/translation/texts/item[@name='estadisticas_por_proveedor']/node()"/></td>
								</tr>
								<xsl:for-each select="PedidosEspeciales/PEDIDOSESPECIALES/ESTADISTICAS/ESTADISTICAS_PROVEEDORES/PROVEEDOR">
								<xsl:if test="ID!='-1'">
            						<tr class="body">
										<td class="label">&nbsp;&nbsp;&nbsp;<xsl:value-of select="NOMBRE"/></td>
										<td><xsl:value-of select="TOTAL"/></td>
									</tr>
								</xsl:if>
								</xsl:for-each>
								</table>
                              </div>
							</div><!--fin de divleft-->
			    	
		  
          </div><!--fin de divLeft-->
  		</form>
      </body>
    </html>
  </xsl:template>  
  
  

</xsl:stylesheet>
