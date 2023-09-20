<?xml version="1.0" encoding="iso-8859-1"?>
<!--
	Buscador en "Enviar pedidos"
	Ultima revision:ET 10mar22 19:45  Busqueda2022_150222.js
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
			<xsl:when test="/BusquedaProductos/LANG"><xsl:value-of select="/BusquedaProductos/LANG"/></xsl:when>
			<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->

	<!--	11ene22 nuevos estilos -->
	<!--<link rel="stylesheet" href="http://www.newco.dev.br/General/basicMVM2022.css"/>-->
	<link href='http://fonts.googleapis.com/css?family=Roboto' rel='stylesheet'/>
	<!--	11ene22 nuevos estilos -->


	<!--<script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>-->
	<script src="http://www.newco.dev.br/General/jquery-3.6.0.js"></script>	
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic2022_010822.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/Compras/NuevaMultioferta/Busqueda2022_150222.js"></script>
	<!--Cuidado, en la version anterior estaba ubicado en Multioferta, ahora en NuevaMultioferta
	<script type="text/javascript" src="http://www.newco.dev.br/Compras/Multioferta/BuscaProd.js"></script>-->

	<script type="text/javascript">
		var error_buscador_min_char	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='buscador_error_min_char']/node()"/>';
		var confirm_buscador_continuar	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='buscador_confirm_continuar']/node()"/>';
	</script>

</head>
<body> <!-- onLoad="ActivarAccion(); return true;"-->
	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:value-of select="/BusquedaProductos/LANG"/>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<div>
	<xsl:attribute name="class">
		<xsl:choose>
		<xsl:when test="/BusquedaProductos/BUSCADOR/MVMB or /BusquedaProductos/BUSCADOR/MVM or /BusquedaProductos/BUSCADOR/NAVEGAR_PROVEEDORES or /BusquedaProductos/BUSCADOR/NOCDC or /BusquedaProductos/BUSCADOR/REDUCIDA or /BusquedaProductos/BUSCADOR/GERENTE">divLeft</xsl:when>
		<xsl:otherwise>divLeft40</xsl:otherwise>
		</xsl:choose>
	</xsl:attribute>

		<form action="" name="Busqueda" method="POST" target="zonaTrabajo">
			<!--	Orden alfabetico en la busqueda		-->
			<input type="hidden" name="LLP_ORDERBY" value="ALF"/>
			<input type="hidden" name="LLP_LISTAR"/>
			<input type="hidden" name="TIPO_BUSQUEDA" value="RAPIDA"/>

			<!--<table class="busca" border="0">-->
			<table class="buscador" border="0"><!-- class="muyoscuro"-->
			<tr class="filtros">
				<td width="10px" style="text-align:left;">  
                </td>
				<td class="textLeft w220px">  
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/>:</label><br />
                    <input type="text" class="campopesquisa w200px" name="LLP_NOMBRE" maxlength="200" value="{/BusquedaProductos/DESCRIPCION}" />
                </td>
                <!--todos usuarios ven desple proveedor-->
                <td class="textLeft w220px">   
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/>:</label><br />
					<xsl:call-template name="desplegable">
        				<xsl:with-param name="path" select="/BusquedaProductos/BUSCADOR/PROVEEDORES/field"/>
						<xsl:with-param name="claSel">w200px</xsl:with-param>
      				</xsl:call-template>
				</td>
                <!--para todos casi enseño, si es asisa no-->
                <xsl:choose>
                <xsl:when test="/BusquedaProductos/BUSCADOR/MVMB or /BusquedaProductos/BUSCADOR/MVM or /BusquedaProductos/BUSCADOR/NAVEGAR_PROVEEDORES or /BusquedaProductos/BUSCADOR/NOCDC or /BusquedaProductos/BUSCADOR/REDUCIDA or /BusquedaProductos/BUSCADOR/GERENTE">
	                <td class="textLeft w120px">
						<input type="checkbox" name="SIN_STOCKS"/>&nbsp;<label><xsl:value-of select="document($doc)/translation/texts/item[@name='sin_stock']/node()"/></label>
					</td>
	                <td class="textLeft w160px">
                    	<input type="checkbox" name="CHECK_LISTADO_PLANTILLA" />&nbsp;<label><xsl:value-of select="document($doc)/translation/texts/item[@name='solo_en_plantillas']/node()"/></label>
					</td>
				</xsl:when>
                <xsl:otherwise>
					<input type="hidden" name="SIN_STOCKS"/>
                   	<input class="peq" type="checkbox" name="CHECK_LISTADO_PLANTILLA" style="display:none;">
                        <xsl:attribute name="checked">true</xsl:attribute>
                    </input>
				</xsl:otherwise>
                </xsl:choose>
				<td class="textLeft w140px">
					<br/>
					<a class="btnDestacado" href="javascript:EnviarBusqueda();" onMouseOver="window.status='Buscar'; return true;" onMouseOut="window.status=''; return true;">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='buscar']/node()"/>
					</a>
				</td>
                <td>&nbsp;</td>
			</tr>  
        </table>
      </form>  
      
		<!--form de mensaje de error de js-->
		<form name="mensajeJS">
			<input type="hidden" name="INTRODUZCA_CRITERIO_BUSQUEDA" value="{document($doc)/translation/texts/item[@name='introduzca_criterio_busqueda']/node()}"/>
			<input type="hidden" name="CRITERIO_DEMASIADO_LARGO" value="{document($doc)/translation/texts/item[@name='criterio_demasiado_largo']/node()}"/>
		</form>
      </div><!--fin de divLeft-->      
   
</body>      
     
</html>   
</xsl:template>
</xsl:stylesheet>
