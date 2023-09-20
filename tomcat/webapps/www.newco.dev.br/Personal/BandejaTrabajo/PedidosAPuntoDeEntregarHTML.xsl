<?xml version="1.0" encoding="iso-8859-1"?>
<!--
	Pedidos a punto de entregar.
	Ultima revision 5nov18 10:11
 -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href = "http://www.newco.dev.br/General/General.xsl" />
  <!-- 9ene07 ET esto no parece necesario ya <xsl:import href="http://www.newco.dev.br/Noticias/Noticias.xsl" />-->
  <xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
  <xsl:param name="lang" select="@lang"/>
  <xsl:param name="usuario" select="@US_ID"/>  
  <xsl:template match="/">
    <html>
      <head>
        <!--style-->
      <xsl:call-template name="estiloIndip"/>
      <!--fin de style-->  
	  	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
        <script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>
        <script type="text/javascript" src="http://www.newco.dev.br/Personal/BandejaTrabajo/pedidosPuntoEntregar.js"></script>
		
      </head>
      <body>
      <form  method="post" name="Form1" action="PedidosAPuntoDeEntregar.xsql">
       	<input type="hidden" name="IDOFERTA" value=""/>
       	<input type="hidden" name="IDMOTIVO" value=""/>
       	<input type="hidden" name="NUEVAFECHAENTREGA" value=""/>
       	<input type="hidden" name="COMENTARIOS" value=""/>
       	<input type="hidden" name="ALBARAN" value=""/>
        <xsl:choose>
          <!-- Error en alguna sentencia del XSQL -->
          <xsl:when test="WorkFlowPendientes/INICIO/xsql-error">
            <xsl:apply-templates select="WorkFlowPendientes/INICIO/xsql-error"/>        
          </xsl:when>
          <xsl:when test="WorkFlowPendientes/INICIO/SESION_CADUCADA">
            <xsl:for-each select="WorkFlowPendientes/INICIO/SESION_CADUCADA">
              <xsl:if test="position()=last()">
                <xsl:apply-templates select="."/>
              </xsl:if>
            </xsl:for-each>        
          </xsl:when>
          <xsl:otherwise>     
            <xsl:apply-templates select="WorkFlowPendientes/INICIO/CABECERAS"/>
            <div class="divLeft">
		  		<!--	Ofertas y Pedidos en curso	-->
		  		<xsl:apply-templates select="PedidosAPuntoDeEntregar/PEDIDOS"/>
            </div>
			</xsl:otherwise>
          </xsl:choose>
		</form>
      </body>
    </html>
  </xsl:template>
 
  <xsl:template match="PEDIDOS">
  	  <!--idioma-->
        <xsl:variable name="lang">
        	<xsl:value-of select="../LANG" />
        </xsl:variable>
        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
      <!--idioma fin-->
      
  		<input type="hidden" name="ORDEN" value="{./ORDEN}" />
  		<input type="hidden" name="SENTIDO" value="{./SENTIDO}" />
    	<table class="grandeInicio">
			<tr class="tituloTabla" >
			   	<th>
                	<xsl:attribute name="colspan">
                    	<xsl:choose>
                    	<xsl:when test="ADMIN='MVM'">6</xsl:when>
                        <xsl:otherwise>8</xsl:otherwise>
                        </xsl:choose>
                    </xsl:attribute>                        
					<p><xsl:value-of select="document($doc)/translation/texts/item[@name='pedidos_proximos_a_entrega']/node()"/></p>
			    </th>
				<xsl:if test="ADMIN='MVM'">
					<th colspan="2">
						<a href="http://www.newco.dev.br/Personal/BandejaTrabajo/WFStatus.xsql">Volver a pedidos problemáticos</a>
					</th>
			    </xsl:if>
			</tr>
        	<tr class="subTituloTabla">
            	<th  colspan="6">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='informacion_del_sistema']/node()"/>
				</th>
				<th colspan="2">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='informacion_privada']/node()"/>
				</th>
			</tr>
	    	<tr class="titulos">
				<th class="cinco">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='pos']/node()"/>.
				</th>
				<th class="siete" align="left">
					<a href="javascript:OrdenarPor('NUMERO_PEDIDO');"><xsl:value-of select="document($doc)/translation/texts/item[@name='numero_pedido']/node()"/></a><br />
				</th>
				<th class="quince" align="left">
					<a href="javascript:OrdenarPor('CENTRO');"><xsl:value-of select="document($doc)/translation/texts/item[@name='centro']/node()"/></a><br  />
				</th>
				<th class="quince" align="left">
					<a href="javascript:OrdenarPor('PROVEEDOR');"><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/></a><br />
				</th>
				<th class="ocho" align="left">
					<a href="javascript:OrdenarPor('FECHA_EMISION');"><xsl:value-of select="document($doc)/translation/texts/item[@name='emision_del_pedido']/node()"/></a>
				</th>
				<th class="doce" align="left">
					<a href="javascript:OrdenarPor('FECHA_ENTREGA');"><xsl:copy-of select="document($doc)/translation/texts/item[@name='entrega_maxima_prevista_2line']/node()"/></a><br />
				</th>
				<th class="ocho" align="left">
					<a href="javascript:OrdenarPor('ESTADO');"><xsl:copy-of select="document($doc)/translation/texts/item[@name='estado']/node()"/></a><br />
				</th>
				<th class="cinco" align="left">
					<xsl:copy-of select="document($doc)/translation/texts/item[@name='seguimiento']/node()"/>
				</th>
			</tr>
            <tbody>
            	<xsl:for-each select="PEDIDO">
	    			<tr>
				   		<td>
							<xsl:value-of select="POSICION"/>
                                                </td>
				   		<td style="text-align:left">
								<a>
									<xsl:attribute name="href">javascript:MostrarPag('http://www.newco.dev.br<xsl:value-of select="ENLACETAREA"/>&amp;SES_ID=<xsl:value-of select="//SES_ID"/>','Multioferta')</xsl:attribute>
									<xsl:attribute name="onMouseOver">window.status='Ver tarea';return true;</xsl:attribute>
									<xsl:attribute name="onMouseOut">window.status='';return true;</xsl:attribute>
									<xsl:value-of select="NUMERO_PEDIDO"/><!--&nbsp;(<xsl:value-of select="PED_ID"/>)-->
								</a>
                                                </td>
						<td style="text-align:left">
							<xsl:value-of select="CLIENTE"/>
						</td>
				   		<td style="text-align:left">
							<xsl:value-of select="PROVEEDOR"/>
                                                </td>
				   		<td style="text-align:left">
							<xsl:value-of select="FECHA_PEDIDO"/>
                                                </td>
				   		<td style="text-align:left">
							<xsl:value-of select="FECHA_ENTREGA"/>
                                                </td>
				   		<td style="text-align:left">
								<a>
									<xsl:attribute name="href">javascript:MostrarPag('<xsl:value-of select="ENLACETAREA"/>&amp;SES_ID=<xsl:value-of select="//SES_ID"/>','Multioferta')</xsl:attribute>
									<xsl:attribute name="onMouseOver">window.status='Ver tarea';return true;</xsl:attribute>
									<xsl:attribute name="onMouseOut">window.status='';return true;</xsl:attribute>
									<xsl:value-of select="ESTADO"/>
								</a>
                                                </td>
						<td style="text-align:left">
							<a>
								<xsl:attribute name="href">javascript:ControlPedidos('<xsl:value-of select="PED_ID"/>');</xsl:attribute>
								<xsl:attribute name="onMouseOver">window.status='Editar la informacion de control';return true;</xsl:attribute>
								<xsl:attribute name="onMouseOut">window.status='';return true;</xsl:attribute>
							<xsl:value-of select="document($doc)/translation/texts/item[@name='control_pedidos']/node()"/></a>
						</td>
					</tr>
      		</xsl:for-each>
            </tbody>
			</table>
            

  </xsl:template>
  
</xsl:stylesheet>

