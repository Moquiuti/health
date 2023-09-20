<?xml version="1.0" encoding="iso-8859-1" ?>
<!--
 |	
 +-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:import href = "http://www.newco.dev.br/General/General.xsl" />
	<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
	<xsl:param name="lang" select="@lang"/>  
	<xsl:template match="/">
    	<html>
		<head>
        
           <!--idioma-->
        <xsl:variable name="lang">
        	<xsl:choose>
            <xsl:when test="/MatrizEIS/LANG != ''"><xsl:value-of select="/MatrizEIS/LANG" /></xsl:when>
            <xsl:when test="/MatrizEIS/LANGTESTI != ''"><xsl:value-of select="/MatrizEIS/LANGTESTI" /></xsl:when>
            <xsl:otherwise>spanish</xsl:otherwise>
            </xsl:choose>  
        </xsl:variable>
        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
         <!--fin idioma-->
        
			<title><xsl:value-of select="document($doc)/translation/texts/item[@name='manten_matriz_eis']/node()"/></title>
            
			<xsl:call-template name="estiloIndip"/>
			<script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
			<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>
			<script type="text/javascript" src="http://www.newco.dev.br/Gestion/EIS/mantmatrizeis_110512.js"></script>
		</head>
		<body>      
        
        <!--idioma-->
        <xsl:variable name="lang">
        	<xsl:choose>
            <xsl:when test="/MatrizEIS/LANG != ''"><xsl:value-of select="/MatrizEIS/LANG" /></xsl:when>
            <xsl:when test="/MatrizEIS/LANGTESTI != ''"><xsl:value-of select="/MatrizEIS/LANGTESTI" /></xsl:when>
            <xsl:otherwise>spanish</xsl:otherwise>
            </xsl:choose>  
        </xsl:variable>
        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
         <!--fin idioma-->
        
        
        	<xsl:choose>
        	<xsl:when test="/MatrizEIS/ERROR">
				<h1 class="titlePage"><xsl:value-of select="document($doc)/translation/texts/item[@name='manten_matriz_eis']/node()"/></h1>
                <div class="divLeft">
        		<p><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='no_tiene_derechos']/node()"/></strong></p>
                </div>
        	</xsl:when>
        	<xsl:otherwise>
				<!--	Bloque de título	-->
				<xsl:choose>
       			<xsl:when test="/MatrizEIS/INICIO/RESULTADO">
					<h1 class="titlePage"><xsl:value-of select="document($doc)/translation/texts/item[@name='manten_matriz_eis']/node()"/> - <xsl:value-of select="document($doc)/translation/texts/item[@name='resultado']/node()"/>: <xsl:value-of select="/MatrizEIS/INICIO/RESULTADO"/></h1>
        		</xsl:when>
        		<xsl:otherwise>
					<!--<h1 class="titlePage"><xsl:value-of select="document($doc)/translation/texts/item[@name='sinonimos']/node()"/></h1>-->
        		</xsl:otherwise>
				</xsl:choose>
				<form name="Admin" method="post" action="MantMatrizEIS.xsql">
				<input type="hidden" name="ACCION"/>
				<input type="hidden" name="PARAMETROS"/>
				<table class="infoTable" border="0">
					<tr class="tituloTabla">
                    <th colspan="10" align="center"><xsl:value-of select="document($doc)/translation/texts/item[@name='manten_matriz_eis']/node()"/></th>
                    </tr>
                    
					<tr class="subTituloTabla">
                    <td class="cinco">&nbsp;</td>
                    <td class="doce datosLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='id']/node()"/></td>
                    <td class="cinco datosLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='orden']/node()"/></td>
                    <td class="quince datosLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='nombre']/node()"/></td>
					<td class="dies datosLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='filtro_prov']/node()"/></td>
					<td class="ocho datosLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='filtro_fam']/node()"/></td>
					<td class="trenta datosLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='filtro_texto']/node()"/></td>
                    <td class="seis">&nbsp;</td>
                    <td class="seis">&nbsp;</td>
                    <td>&nbsp;</td>
                    </tr>
                    <tr>
                    <td colspan="10">
                      <table class="infoTableAma">
                        <tr><td align="center">
                            <p style="padding:5px 0px;"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='cambios_realizados_aplicaran_a_indices']/node()"/></strong></p>
                        </td></tr>
                        </table>
                    </td>
                    </tr>   
                    <tr class="subTituloTabla">
                    <td>&nbsp;</td>
					<td class="datosLeft"><input type="text" size="20" name="ID"/></td>
					<td class="datosLeft"><input type="text" size="3" name="ORDEN"/></td>
					<td class="datosLeft"><input type="text" size="20" name="NOMBRE"/></td>
					<td class="datosLeft"><input type="text" size="15" name="FILTRO_PROVEEDOR"/></td>
					<td class="datosLeft"><input type="text" size="10" name="FILTRO_FAMILIA"/></td>
					<td class="datosLeft"><input type="text" size="60" name="FILTRO_TEXTO"/></td>
					<td align="center"><strong><a href="javascript:InsertarIndicador();"><xsl:value-of select="document($doc)/translation/texts/item[@name='insertar']/node()"/></a></strong></td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
					</tr> 
					<xsl:for-each select="/MatrizEIS/INICIO/INDICADORES/INDICADOR">
						<tr>
                        <td>&nbsp;</td>
						<td class="datosLeft"><xsl:value-of select="ID"/></td>
						<td class="datosLeft"><input type="text" name="ORDEN_{ID}" size="3" value="{ORDEN}"/></td>
						<td class="datosLeft"><input type="text" name="NOMBRE_{ID}" size="20" value="{NOMBRE}"/></td>
						<td class="datosLeft"><input type="text" name="FILTRO_PROVEEDOR_{ID}" size="15" value="{FILTRO_PROVEEDOR}"/></td>
						<td class="datosLeft"><input type="text" name="FILTRO_FAMILIA_{ID}" size="10" value="{FILTRO_FAMILIA}"/></td>
						<td class="datosLeft"><input type="text" name="FILTRO_TEXTO_{ID}" size="60" value="{FILTRO_TEXTO}"/></td>
						<td align="center"><strong><a href="javascript:BorrarIndicador('{ID}');"><xsl:value-of select="document($doc)/translation/texts/item[@name='borrar']/node()"/></a></strong></td>
						<td align="center"><strong><a href="javascript:ModificarIndicador('{ID}');"><xsl:value-of select="document($doc)/translation/texts/item[@name='modificar']/node()"/></a></strong></td>
                        <td>&nbsp;</td>
						</tr>
					</xsl:for-each>
					<tr><td colspan="10">&nbsp;</td></tr>
                    </table>
                   
                  
				</form>
				<br/>
				<br/>
                
        	</xsl:otherwise>
        	</xsl:choose>
		</body>
		</html>
	</xsl:template>  
</xsl:stylesheet>
