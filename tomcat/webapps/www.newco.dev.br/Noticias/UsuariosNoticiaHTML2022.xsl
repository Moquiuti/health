<?xml version="1.0" encoding="iso-8859-1"?>
<!--
	Usuarios que han consultado una noticia
	Ultima revision: ET 1jun22 09:30
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href="http://www.newco.dev.br/General/General.xsl"/>
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
		<xsl:when test="/UsuariosNoticia/LANG"><xsl:value-of select="/UsuariosNoticia/LANG" /></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
	</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->

	<title><xsl:value-of select="/UsuariosNoticia/NOTICIA/NOT_TITULO"/>:&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='lectores']/node()"/></title>

	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery-3.6.0.js"></script>	
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic2022_010822.js"></script>
	
	<script type="text/javascript">
		// vuelve al mantenimiento de noticias
		function Volver()
		{
			document.location="http://www.newco.dev.br/Noticias/Noticias2022.xsql";
		}
	</script>
</head>

<body>

    <xsl:choose>
    <!-- ET Desactivado control errores: Habra que reactivarlo -->
    <xsl:when test="UsuariosNoticia/xsql-error">
      <xsl:apply-templates select="UsuariosNoticia/xsql-error"/>
    </xsl:when>
    <xsl:when test="UsuariosNoticia/ROW/Sorry">
      <xsl:apply-templates select="UsuariosNoticia/ROW/Sorry"/>
    </xsl:when>
    <xsl:otherwise>

      <!--idioma-->
      <xsl:variable name="lang">
        <xsl:choose>
        <xsl:when test="/UsuariosNoticia/LANG"><xsl:value-of select="/UsuariosNoticia/LANG" /></xsl:when>
        <xsl:otherwise>spanish</xsl:otherwise>
        </xsl:choose>
      </xsl:variable>
      <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
      <!--idioma fin-->


	<!--	Titulo de la página		-->
	<div class="ZonaTituloPagina">
		<p class="TituloPagina">
			<xsl:value-of select="/UsuariosNoticia/NOTICIA/NOT_TITULO"/>:&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='lectores']/node()"/>
			<span class="CompletarTitulo">
				<a class="btnNormal" href="javascript:Volver();"><xsl:value-of select="document($doc)/translation/texts/item[@name='volver']/node()"/></a>			
			</span>
		</p>
	</div>
	<br/>
	<br/>
	<table cellspacing="6px" cellpadding="6px">
	<tr>
		<td class="labelRight veinte"><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha']/node()"/>:&nbsp;</td>
		<td class="textLeft"><xsl:value-of select="/UsuariosNoticia/NOTICIA/NOT_FECHA"/></td>
	</tr>
	<tr>
		<td class="labelRight "><xsl:value-of select="document($doc)/translation/texts/item[@name='titulo']/node()"/>:&nbsp;</td>
		<td class="textLeft"><xsl:value-of select="/UsuariosNoticia/NOTICIA/NOT_TITULO"/></td>
	</tr>
	<tr>
		<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='destinatarios']/node()"/>:&nbsp;</td>
		<td class="textLeft"><xsl:value-of select="/UsuariosNoticia/NOTICIA/DESTINATARIOS"/></td>
	</tr>
	<tr>
		<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='texto']/node()"/>:&nbsp;</td>
		<td class="textLeft" colspan="5"><xsl:copy-of select="/UsuariosNoticia/NOTICIA/NOT_TEXTO"/></td>
	</tr>
	</table>
	<br/>
	<br/>
	<div class="tabela tabela_redonda">
	<table class="w1000px tableCenter" cellspacing="6px" cellpadding="6px">
		<thead class="cabecalho_tabela">
		<tr>
			<th class="w1px"></th>
			<th class="w50px"><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha']/node()"/></th>
			<th class="textLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='nombre']/node()"/></th>
			<th class="textLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='centro']/node()"/></th>
		</tr>
		</thead>
		<!--	Cuerpo de la tabla	-->
		<tbody class="corpo_tabela">

		<xsl:for-each select="/UsuariosNoticia/NOTICIA/LECTORES/LECTOR">
			<tr class="conhover">
				<td class="color_status"><xsl:value-of select="CONTADOR"/></td>
				<td><xsl:value-of select="FECHA"/></td>
				<td class="textLeft"><xsl:value-of select="USUARIO"/></td>
				<td class="textLeft"><xsl:value-of select="CENTRO"/></td>
			</tr>
		</xsl:for-each>
		</tbody>
		<tfoot class="rodape_tabela">
			<tr><td colspan="5">&nbsp;</td></tr>
		</tfoot>
	</table>
 	</div>
 	<br/>  
 	<br/>  
 	<br/>  
 	<br/>  
 	<br/>  

    </xsl:otherwise>
    </xsl:choose>
</body>
</html>
</xsl:template>
</xsl:stylesheet>
