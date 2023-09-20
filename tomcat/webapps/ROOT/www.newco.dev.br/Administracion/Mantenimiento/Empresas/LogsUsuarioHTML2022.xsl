<?xml version="1.0" encoding="iso-8859-1" ?>
<!--	
	Mostrar los historicos (logs) de la empresa
	Ultima revision: ET 02ene23 18:50
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
		<xsl:when test="/LogsUsuario/LANG"><xsl:value-of select="/LogsUsuario/LANG" /></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
	</xsl:choose>  
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>        <!--idioma fin-->
        
	<title><xsl:value-of select="/LogsUsuario/LOGS/USUARIO"/>:&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Ver_logs']/node()"/></title>
    <!--style-->
    <xsl:call-template name="estiloIndip"/>
    <!--fin de style-->  

	<script src="http://www.newco.dev.br/General/jquery-3.6.0.js"></script>	
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic2022_010822.js"></script><!--para volver al mantenimiento de empresas-->
</head>
<body>   
	<!--idioma-->
	<xsl:variable name="lang">
	<xsl:choose>
		<xsl:when test="/LogsUsuario/LANG"><xsl:value-of select="/LogsUsuario/LANG" /></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
	</xsl:choose>  
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>        <!--idioma fin-->
      
    <xsl:choose>
		<xsl:when test="//SESION_CADUCADA">
			<xsl:apply-templates select="//SESION_CADUCADA"/>    
		</xsl:when>
		<xsl:when test="//xsql-error">
			<xsl:apply-templates select="//xsql-error"/>
		</xsl:when>
        <xsl:otherwise>
		<!--	Titulo de la página		-->
		<div class="ZonaTituloPagina">
			<p class="TituloPagina">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='Ver_logs']/node()"/>:&nbsp;<xsl:value-of select="/LogsUsuario/LOGS/USUARIO"/>
				&nbsp;&nbsp;
				<span class="CompletarTitulo">
					<a class="btnNormal" title="Ficha Empresa" style="text-decoration:none;">
						<xsl:attribute name="href">javascript:chMantenUsuario(<xsl:value-of select="/LogsUsuario/LOGS/IDUSUARIO"/>);</xsl:attribute>
						<xsl:value-of select="document($doc)/translation/texts/item[@name='volver']/node()"/>
					</a>
				</span>
			</p>
		</div>
        <xsl:if test="/LogsUsuario/LOGS/LOG">
			<div class="tabela tabela_redonda">
			<table cellspacing="6px" cellpadding="6px">
				<thead class="cabecalho_tabela">
				<tr>
					<th class="w1px"></th>
					<th class="w50px"><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha']/node()"/></th>
					<th class="w50px"><xsl:value-of select="document($doc)/translation/texts/item[@name='usuario']/node()"/></th>
					<th class="textLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='comentarios']/node()"/></th>
				</tr>
				</thead>
				<tbody class="corpo_tabela">
	       		<xsl:for-each select="/LogsUsuario/LOGS/LOG">
				<tr class="conhover">
					<td class="color_status"><xsl:value-of select="CONTADOR"/></td>
					<td class="textLeft"><xsl:value-of select="FECHA"/></td>
					<td class="textLeft">
						<xsl:value-of select="USUARIO"/>
					</td>
					<td class="textLeft">
						<xsl:value-of select="TEXTO"/>
					</td>
                 </tr>
			</xsl:for-each> 
			</tbody>
			<tfoot class="rodape_tabela">
				<tr><td colspan="4">&nbsp;</td></tr>
			</tfoot>
			<br/>
			<br/>
	    	</table>
			</div>
        </xsl:if>
	</xsl:otherwise>
	</xsl:choose> 
</body>
</html>
</xsl:template>  
</xsl:stylesheet>
