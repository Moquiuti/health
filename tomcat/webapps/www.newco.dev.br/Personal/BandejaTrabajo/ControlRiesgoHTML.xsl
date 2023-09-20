<?xml version="1.0" encoding="iso-8859-1"?>
<!--
	Control de riesgo en los pedidos
	Ultima revision 8set19 15:00
 -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href = "http://www.newco.dev.br/General/General.xsl" />
  <xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
  <xsl:param name="usuario" select="@US_ID"/>
  <xsl:template match="/">
    <html>
      <head>
       <!--style-->
      <xsl:call-template name="estiloIndip"/>
      <!--fin de style-->

      <script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
	  <script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>

		<xsl:text disable-output-escaping="yes"><![CDATA[
		   	<script type="text/javascript">
        	  <!--

			function CambiarConsulta(IDPedido, IDProducto)
			{
				var form=document.forms[0];

				form.elements['PED_ID'].value=IDPedido;
				form.elements['IDPRODUCTO'].value=IDProducto;
				//alert(IDPEdido+','+ IDProducto);
				SubmitForm(form);
			}

        	  //-->
        	</script>
        ]]></xsl:text>
      </head>
      <body>

       <!--idioma-->
        <xsl:variable name="lang">
        	<xsl:value-of select="/ControlRiesgo/LANG" />
        </xsl:variable>
        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
      <!--idioma fin-->

      <form  method="post" name="Form1" action="ControlRiesgo.xsql">
       	<input type="hidden" name="PED_ID" value=""/>
       	<input type="hidden" name="IDPRODUCTO" value=""/>

		  <!--	Ofertas y Pedidos en curso	-->
		  		<xsl:apply-templates select="ControlRiesgo/PEDIDO/LINEASPEDIDO"/>
          <br/><br/>
          <br/><br/>
		  		<xsl:apply-templates select="ControlRiesgo/PEDIDO/LINEASOTROSPEDIDOS"/>

		</form>
      </body>
    </html>
  </xsl:template>

  <xsl:template match="LINEASPEDIDO">
    <!--idioma-->
        <xsl:variable name="lang">
        	<xsl:value-of select="../../LANG" />
        </xsl:variable>
        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
      <!--idioma fin-->

		<!--	Titulo de la página		-->
		<div class="ZonaTituloPagina">
			<p class="Path">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='Inicio']/node()"/>&nbsp;/&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Pedidos']/node()"/>&nbsp;/&nbsp;<span class="FinPath"><xsl:value-of select="document($doc)/translation/texts/item[@name='Control_riesgo']/node()"/></span>
				<span class="CompletarTitulo">
				</span>
			</p>
			<p class="TituloPagina">
				<xsl:value-of select="./LINEAPEDIDO/DESCRIPCION_ESTANDAR"/>
				<span class="CompletarTitulo" style="width:600px;">
				</span>
			</p>
		</div>
		<br/>
		<br/>
		<br/>
		<br/>
		<br/>




    <table class="buscador">
	    <tr class="tituloTabla">
			   	<th colspan="10">
					&nbsp; <xsl:value-of select="document($doc)/translation/texts/item[@name='lineas_del_pedido']/node()"/>&nbsp;<xsl:value-of select="./LINEAPEDIDO/PED_NUMERO"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='de']/node()"/>&nbsp;<xsl:value-of select="./LINEAPEDIDO/CLIENTE"/> <xsl:value-of select="document($doc)/translation/texts/item[@name='a']/node()"/> <xsl:value-of select="./LINEAPEDIDO/PROVEEDOR"/>
			    </th>
		</tr>
        <tr class="titulos">
				<th class="cinco">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='pedido']/node()"/>
				</th>
				<th class="cinco">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='estado']/node()"/>
				</th>
				<th class="dies">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/>
				</th>
				<th class="quince">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='cliente']/node()"/>
				</th>
				<th class="dies">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='ref_proveedor']/node()"/>
				</th>
				<th class="dies">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='ref_cliente']/node()"/>
				</th>
				<th class="trenta">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/>
				</th>
				<th class="cinco">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='entrega']/node()"/>
				</th>
				<th class="cinco">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='pendiente']/node()"/>
				</th>
				<th class="cinco">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='riesgo']/node()"/>
				</th>
			</tr>
      		<xsl:for-each select="./LINEAPEDIDO">
	    			<tr>
				   		<td>
								<a>
									<xsl:attribute name="href">javascript:MostrarPag('http://www.newco.dev.br<xsl:value-of select="ENLACETAREA"/>&amp;SES_ID=<xsl:value-of select="//SES_ID"/>','Multioferta')</xsl:attribute>
									<xsl:attribute name="onMouseOver">window.status='Ver tarea';return true;</xsl:attribute>
									<xsl:attribute name="onMouseOut">window.status='';return true;</xsl:attribute>
									<xsl:value-of select="PED_NUMERO"/><!--&nbsp;(<xsl:value-of select="PED_ID"/>)-->
								</a>
				    	</td>
				   		<td>
							&nbsp;<xsl:value-of select="ESTADO"/>
				    	</td>
				   		<td>
							&nbsp;<xsl:value-of select="PROVEEDOR"/>
				    	</td>
						<td>
							&nbsp;<xsl:value-of select="CLIENTE"/>
						</td>
				   		<td>
							<xsl:value-of select="REFERENCIA_PROVEEDOR"/>
				    	</td>
				   		<td>
							<xsl:value-of select="REFERENCIA_CLIENTE"/>
				    	</td>
				   		<td>
							&nbsp;<xsl:value-of select="DESCRIPCION_ESTANDAR"/>
				    	</td>
				   		<td>
							<xsl:value-of select="PED_FECHAENTREGA"/>&nbsp;
				    	</td>
				   		<td>
							<xsl:value-of select="CANTIDADPENDIENTE"/>&nbsp;
				    	</td>
				   		<td>
								<a>
									<xsl:attribute name="href">javascript:CambiarConsulta(<xsl:value-of select="PED_ID"/>,<xsl:value-of select="LPE_IDPRODUCTO"/>)</xsl:attribute>
									<xsl:attribute name="onMouseOver">window.status='Cambiar consulta';return true;</xsl:attribute>
									<xsl:attribute name="onMouseOut">window.status='';return true;</xsl:attribute>
									<xsl:value-of select="LPE_VALORACIONRIESGO"/>
								</a>
				    	</td>
					</tr>
      		</xsl:for-each>
		</table>
  </xsl:template>

  <xsl:template match="LINEASOTROSPEDIDOS">
  	 <!--idioma-->
        <xsl:variable name="lang">
        	<xsl:value-of select="../../LANG" />
        </xsl:variable>
        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
      <!--idioma fin-->
    	<table class="buscador">
	    	<tr class="tituloTabla">
			   	<th colspan="10">
					&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='lineas_otros_pedidos_con_prod']/node()"/>&nbsp;"<xsl:value-of select="./LINEAPEDIDO/DESCRIPCION_ESTANDAR"/>"&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='de']/node()"/>&nbsp;<xsl:value-of select="./LINEAPEDIDO/PROVEEDOR"/>
			    </th>
			</tr>
            <tr class="titulos">
				<th class="cinco">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='pedido']/node()"/>
				</th>
				<th class="cinco">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='estado']/node()"/>
				</th>
				<th class="dies">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/>
				</th>
				<th class="quince">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='cliente']/node()"/>
				</th>
				<th class="dies">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='ref_proveedor']/node()"/>
				</th>
				<th class="dies">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='ref_cliente']/node()"/>
				</th>
				<th class="trenta">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/>
				</th>
				<th class="cinco">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='entrega']/node()"/>
				</th>
				<th class="cinco">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='pendiente']/node()"/>
				</th>
				<th class="cinco">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='riesgo']/node()"/>
				</th>
			</tr>
      		<xsl:for-each select="./LINEAPEDIDO">
	    			<tr>
				   		<td>
								<a>
									<xsl:attribute name="href">javascript:MostrarPag('<xsl:value-of select="ENLACETAREA"/>&amp;SES_ID=<xsl:value-of select="//SES_ID"/>','Multioferta')</xsl:attribute>
									<xsl:attribute name="onMouseOver">window.status='Ver tarea';return true;</xsl:attribute>
									<xsl:attribute name="onMouseOut">window.status='';return true;</xsl:attribute>
									<xsl:value-of select="PED_NUMERO"/>
								</a>
				    	</td>
				   		<td>
							<xsl:value-of select="ESTADO"/>
				    	</td>
				   		<td>
							<xsl:value-of select="PROVEEDOR"/>
				    	</td>
						<td>
							<xsl:value-of select="CLIENTE"/>
						</td>
				   		<td>
							<xsl:value-of select="REFERENCIA_PROVEEDOR"/>
				    	</td>
				   		<td>
							<xsl:value-of select="REFERENCIA_CLIENTE"/>
				    	</td>
				   		<td>
							<xsl:value-of select="DESCRIPCION_ESTANDAR"/>
				    	</td>
				   		<td>
							<xsl:value-of select="PED_FECHAENTREGA"/>&nbsp;
				    	</td>
				   		<td>
							<xsl:value-of select="CANTIDADPENDIENTE"/>&nbsp;
				    	</td>
				   		<td>
								<a>
									<xsl:attribute name="href">javascript:CambiarConsulta(<xsl:value-of select="PED_ID"/>,<xsl:value-of select="LPE_IDPRODUCTO"/>)</xsl:attribute>
									<xsl:attribute name="onMouseOver">window.status='Cambiar consulta';return true;</xsl:attribute>
									<xsl:attribute name="onMouseOut">window.status='';return true;</xsl:attribute>
									<xsl:value-of select="LPE_VALORACIONRIESGO"/>
								</a>
				    	</td>
					</tr>
      		</xsl:for-each>

		</table>
  </xsl:template>

</xsl:stylesheet>
