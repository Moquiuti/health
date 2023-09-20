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
            <xsl:when test="/Sinonimos/LANG != ''"><xsl:value-of select="/Sinonimos/LANG" /></xsl:when>
            <xsl:when test="/Sinonimos/LANGTESTI != ''"><xsl:value-of select="/Sinonimos/LANGTESTI" /></xsl:when>
            <xsl:otherwise>spanish</xsl:otherwise>
            </xsl:choose>  
        </xsl:variable>
        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
         <!--fin idioma-->
        
			<title><xsl:value-of select="document($doc)/translation/texts/item[@name='manten_sinonimos']/node()"/></title>
            
			<xsl:call-template name="estiloIndip"/>
			<script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
			<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>
			<script type="text/javascript" src="http://www.newco.dev.br/Gestion/Sinonimos/sinonimos_140512.js"></script>
		</head>
		<body>      
        
        <!--idioma-->
        <xsl:variable name="lang">
        	<xsl:choose>
            <xsl:when test="/Sinonimos/LANG != ''"><xsl:value-of select="/Sinonimos/LANG" /></xsl:when>
            <xsl:when test="/Sinonimos/LANGTESTI != ''"><xsl:value-of select="/Sinonimos/LANGTESTI" /></xsl:when>
            <xsl:otherwise>spanish</xsl:otherwise>
            </xsl:choose>  
        </xsl:variable>
        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
         <!--fin idioma-->
        
        
        	<xsl:choose>
        	<xsl:when test="/Sinonimos/ERROR">
				<h1 class="titlePage"><xsl:value-of select="document($doc)/translation/texts/item[@name='admin_tecnica']/node()"/></h1>
                <div class="divLeft">
        		<p><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='no_tiene_derechos']/node()"/></strong></p>
                </div>
        	</xsl:when>
        	<xsl:otherwise>
				<!--	Bloque de título	-->
				<xsl:choose>
       			<xsl:when test="/Sinonimos/INICIO/RESULTADO">
					<h1 class="titlePage"><xsl:value-of select="document($doc)/translation/texts/item[@name='sinonimos']/node()"/> - <xsl:value-of select="document($doc)/translation/texts/item[@name='resultado']/node()"/>: <xsl:value-of select="/Sinonimos/INICIO/RESULTADO"/></h1>
        		</xsl:when>
        		<xsl:otherwise>
					<!--<h1 class="titlePage"><xsl:value-of select="document($doc)/translation/texts/item[@name='sinonimos']/node()"/></h1>-->
        		</xsl:otherwise>
				</xsl:choose>
				<form name="Admin" method="post" action="Sinonimos.xsql">
				<input type="hidden" name="ACCION"/>
				<input type="hidden" name="PARAMETROS"/>
				<table class="infoTable">
					<tr class="tituloTabla">
                    <th colspan="6" align="center"><xsl:value-of select="document($doc)/translation/texts/item[@name='pares_sinonimos_existentes']/node()"/>
                    </th>
                    </tr>
                    
					<tr class="subTituloTabla">
                    <td class="trenta">&nbsp;</td>
                    <td class="dies datosLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha']/node()"/></td>
                    <td class="veinte datosLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='palabra']/node()"/> 1</td>
                    <td class="veinte datosLeft" align="left"><xsl:value-of select="document($doc)/translation/texts/item[@name='palabra']/node()"/> 2</td>
                    <td class="cinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='borrar']/node()"/></td>
                    <td>&nbsp;</td>
                    </tr>
                    <tr>
                    <td colspan="6">
                      <table class="infoTableAma">
                        <tr><td align="center">
                            <p style="padding:5px 0px;"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='cambios_realizados_aplicaran_a_indices']/node()"/></strong></p>
                        </td></tr>
                        
                        </table>
                    </td>
                    </tr>   
                    <tr class="subTituloTabla">
                    <td class="trenta">&nbsp;</td>
					<td class="dies">&nbsp;</td>
					<td class="veinte datosLeft"><input type="text" name="NOMBRE" size="30"/></td>
					<td class="veinte datosLeft"><input type="text" name="SINONIMO" size="30"/></td>
					<td align="center"><strong><a href="javascript:InsertarSinonimo();"><xsl:value-of select="document($doc)/translation/texts/item[@name='insertar']/node()"/></a></strong></td>
                    <td>&nbsp;</td>
					</tr> 
                    <tr class="subTituloTabla">
                    <td class="trenta">&nbsp;</td>
					<td class="dies">&nbsp;</td>
					<td class="veinte datosLeft" colspan="2"><input type="text" size="30" name="COMPROBAR"/></td>
					<td align="center"><strong><a href="javascript:ComprobarSinonimo();"><xsl:value-of select="document($doc)/translation/texts/item[@name='comprobar']/node()"/></a></strong></td>
                    <td>&nbsp;</td>
					</tr> 
                    
					<xsl:for-each select="/Sinonimos/INICIO/SINONIMOS/PARES">
						<tr>
                        <td class="veinte">&nbsp;</td>
						<td class="datosLeft"><xsl:value-of select="FECHA"/></td>
						<td class="datosLeft"><xsl:value-of select="NOMBRE"/></td>
						<td class="datosLeft"><xsl:value-of select="SINONIMO"/></td>
						<td align="center">
                        	<a href="javascript:BorrarSinonimo('{NOMBRE}','{SINONIMO}');"><img src="http://www.newco.dev.br/images/2017/trash.png"/></a></td>
                        <td>&nbsp;</td>
						</tr>
					</xsl:for-each>
					<tr><td colspan="5">&nbsp;</td></tr>
                   
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
