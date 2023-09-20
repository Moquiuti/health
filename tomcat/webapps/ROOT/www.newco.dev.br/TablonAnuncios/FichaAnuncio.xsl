<?xml version="1.0" encoding="iso-8859-1" ?>
<!-- 
 |
 +-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"> 
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
	<xsl:text disable-output-escaping="yes"><![CDATA[
	<link rel="stylesheet" href="http://www.newco.dev.br/General/Estilos.css" type="text/css">
        ]]></xsl:text>

<xsl:template match="ANUNCIO"> 
	<xsl:variable name="TipoAnuncio"><xsl:value-of select="TIPO"/></xsl:variable>
 	<table width="75%" border="0" align="center" cellspacing="1" cellpadding="3" class="oscuro">
		<tr class="oscuro">
			<td align="center" colspan="2">
				..........:::::::: Anuncio ::::::::..........
			</td>
		</tr>
		<!--<tr class="claro"><td align="center">
 		<table width="100%" border="0" class="claro" align="center" cellspacing="0" cellpadding="0" >-->
            <tr class="claro">
				<td width="30%" align="left">
					&nbsp;Fecha de entrada:
				</td>
				<td width="70%" align="left" class="blanco">
					&nbsp;<xsl:value-of select="ENTRADA"/>
				</td>
			</tr>
            <tr class="claro">
				<td width="30%" align="left">
					&nbsp;Empresa o Centro:
				</td>
				<td width="70%" align="left" class="blanco">
					&nbsp;<xsl:value-of select="EMPRESA"/>
				</td>
			</tr>
            <tr class="claro">
				<td width="30%" align="left">
					&nbsp;Categoria:
				</td>
				<td width="70%" align="left" class="blanco">
					&nbsp;<xsl:value-of select="CATEGORIA"/>
				</td>
			</tr>
            <tr class="claro">
				<td width="30%" align="left">
					&nbsp;Válido hasta:
				</td>
				<td width="70%" align="left" class="blanco">
					&nbsp;<xsl:value-of select="SALIDA"/>
				</td>
			</tr>
            <tr class="claro">
				<td width="30%" align="left">
					&nbsp;Título:
				</td>
				<td width="70%" align="left" class="blanco">
					&nbsp;<xsl:value-of select="TITULO"/>
				</td>
			</tr>
			<!--	Texto del anuncio		-->
            <tr class="claro">
				<td width="30%" align="left">
					&nbsp;Descripción:
				</td>
				<td width="70%" align="left" class="blanco">
					&nbsp;<xsl:copy-of select="EXPLICACION"/>
				</td>
			</tr>
            <tr class="claro">
				<td align="left" colspan="2">
					<table align="left" cellspacing="1" cellpadding="2" class="oscuro">
						<tr class="blanco"><td>
							<a   onMouseOver="window.status='Ver Anuncio';return true;" onMouseOut="window.status='';return true;">
							<xsl:attribute name="href">javascript:MostrarPag('./Contacto.xsql?IDAnuncio=<xsl:value-of select="ID"/>','Contacto')
							</xsl:attribute>
								Ver Contacto
							</a>
						</td></tr>
					</table>
					<table  align="right" cellspacing="1" cellpadding="2" class="oscuro">
						<tr class="blanco"><td>
							<a  onMouseOver="window.status='Responder al anuncio';return true;" onMouseOut="window.status='';return true;"><xsl:attribute name="href">ResponderAnuncio.xsql?IDAnuncio=<xsl:value-of select="ID"/>
							</xsl:attribute>Responder al anuncio</a>
						</td></tr>
					</table>
				</td>
			</tr>
    </table> 
 </xsl:template>
</xsl:stylesheet>
