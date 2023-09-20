<?xml version="1.0" encoding="iso-8859-1" ?>
<!--
	Asignacion de lugar de entrega especial a centro para algun proveedor. Nuevo disenno 2022.
	Ultima revision: ET 17may22 15:52
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
		<xsl:when test="/MantenimientoProductos/LANG"><xsl:value-of select="/MantenimientoProductos/LANG"/></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->
        
	<title><xsl:value-of select="/FacturacionEspecial/FACTURACION_ESPECIAL/EMPRESA"/>:&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Facturacion_especial']/node()"/></title>
    <!--style-->
    <xsl:call-template name="estiloIndip"/>
    <!--fin de style-->  

	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery-3.6.0.js"></script>	
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic2022_010822.js"></script>
    <!--<script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>-->
        
	<xsl:text disable-output-escaping="yes"><![CDATA[
	<script type="text/javascript">
	<!--
	//	Funciones de Javascript
	function BorrarFacturacionEspecial(IDCentroCliente, IDProveedor)
	{
    	var seguroBorrar= document.forms['MensajeJS'].elements['SEGURO_BORRAR'].value;
		if (confirm(seguroBorrar))
		{
	          document.forms[0].elements['ACCION'].value='BORRAR';
	          document.forms[0].elements['IDCENTROCLIENTE'].value=IDCentroCliente;
	          document.forms[0].elements['IDPROVEEDOR'].value=IDProveedor;
			  SubmitForm(document.forms[0]);
		}
	}

	function GuardarLugarEntrega()
	{
	      document.forms[0].elements['ACCION'].value='CREAR';
		  SubmitForm(document.forms[0]);
	}
	//-->      
	</script>
     ]]></xsl:text>	

</head>
<body>   
	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:choose>
		<xsl:when test="/MantenimientoProductos/LANG"><xsl:value-of select="/MantenimientoProductos/LANG"/></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->
        
      
      <xsl:choose>
        <xsl:when test="//SESION_CADUCADA">
              <xsl:apply-templates select="//SESION_CADUCADA"/>    
        </xsl:when>
        <xsl:when test="//xsql-error">
             <xsl:apply-templates select="//xsql-error"/>
           </xsl:when>
        <xsl:otherwise>
	    <!-- Titulo -->
		<form action="FacturacionEspecial.xsql" name="FactEspecial" method="POST">
		<input type="hidden" name="ACCION"/>
		<input type="hidden" name="IDEMPRESA" value="{/FacturacionEspecial/IDEMPRESA}"/>
 
		<!--	Titulo de la página		-->
		<div class="ZonaTituloPagina">
			<p class="TituloPagina">
				<xsl:value-of select="/FacturacionEspecial/FACTURACION_ESPECIAL/EMPRESA"/>:&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Facturacion_especial']/node()"/>
				<span class="CompletarTitulo">
				</span>
			</p>
		</div>
		<br/>
		<br/>
		<br/>
		<br/>
		<br/>
        <xsl:if test="/FacturacionEspecial/FACTURACION_ESPECIAL/REGISTRO">
			<div class="tabela tabela_redonda">
			<table class="w1000px tableCenter" cellspacing="6px" cellpadding="6px">
				<thead class="cabecalho_tabela">
				<tr>
					<th class="w1x"></th>
					<th class="cinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='contador']/node()"/></th>
					<th align="left" class="trenta"><xsl:value-of select="document($doc)/translation/texts/item[@name='centro']/node()"/></th>
					<th align="left"><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/></th>
					<th align="left" class="trenta"><xsl:value-of select="document($doc)/translation/texts/item[@name='lugar_entrega']/node()"/></th>
					<th class="cinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='borrar']/node()"/></th>
				</tr>
				</thead>
				<!--	Cuerpo de la tabla	-->
				<tbody class="corpo_tabela">
	       		<xsl:for-each select="/FacturacionEspecial/FACTURACION_ESPECIAL/REGISTRO">
				<tr class="conhover">
					<td class="color_status">&nbsp;</td>
					<td class="textLeft">
						<xsl:value-of select="CONTADOR"/>
					</td>
					<td class="textLeft">
						<xsl:value-of select="CENTROCLIENTE"/>
					</td>
					<td class="textLeft">
						<xsl:value-of select="PROVEEDOR"/>
					</td>
					<td class="textLeft">
						<xsl:value-of select="LUGARENTREGA"/>
					</td>
					<td>
                    	<a href="javascript:BorrarFacturacionEspecial({IDCENTROCLIENTE},{IDPROVEEDOR})">
                        	<img src="/images/2022/icones/del.svg"/>
                    	</a>
					</td>
                 </tr>
			</xsl:for-each> 
			</tbody>
			<tfoot class="rodape_tabela">
				<tr><td colspan="6">&nbsp;</td></tr>
			</tfoot>
		</table>
 		</div>
        </xsl:if>
		<br/>
		<br/>
		<br/>

		<table class="w1000px tableCenter" cellspacing="6px" cellpadding="6px">
			<tr>
				<td class="w300px">
					<xsl:call-template name="desplegable">
					<xsl:with-param name="path" select="/FacturacionEspecial/FACTURACION_ESPECIAL/LISTACENTROS/field"/>
					<xsl:with-param name="claSel">w300px</xsl:with-param>
					</xsl:call-template>
				</td>
				<td class="w300px">
					<xsl:call-template name="desplegable">
					<xsl:with-param name="path" select="/FacturacionEspecial/FACTURACION_ESPECIAL/LISTAPROVEEDORES/field"/>
					<xsl:with-param name="claSel">w300px</xsl:with-param>
					</xsl:call-template>
				</td>
				<td class="w300px">
					<xsl:call-template name="desplegable">
					<xsl:with-param name="path" select="/FacturacionEspecial/FACTURACION_ESPECIAL/LUGARESENTREGA/field"/>
					<xsl:with-param name="claSel">w300px</xsl:with-param>
					</xsl:call-template>
				</td>
				<td class="w100px">
					<a class="btnDestacado" href="javascript:GuardarLugarEntrega();"><xsl:value-of select="document($doc)/translation/texts/item[@name='guardar']/node()"/></a>
				</td>
				<td>&nbsp;</td>
        	</tr>
        </table>

		</form>
        <form name="MensajeJS">
			<input type="hidden" name="SEGURO_BORRAR" value="{document($doc)/translation/texts/item[@name='Seguro_de_borrar_lugar_entrega']/node()}"/>
        </form>
		</xsl:otherwise>
      </xsl:choose> 
      </body>
    </html>
  </xsl:template>  
</xsl:stylesheet>
