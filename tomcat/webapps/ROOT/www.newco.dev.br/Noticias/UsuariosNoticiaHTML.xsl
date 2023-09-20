<?xml version="1.0" encoding="iso-8859-1"?>
<!--
	Usuarios que han consultado una noticia
	Ultima revisión: ET 13jun19 16:15
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href="http://www.newco.dev.br/General/General.xsl"/>
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
		<p class="Path"><xsl:value-of select="document($doc)/translation/texts/item[@name='Inicio']/node()"/>&nbsp;/&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Gestion']/node()"/>&nbsp;/&nbsp;<span class="FinPath"><xsl:value-of select="document($doc)/translation/texts/item[@name='noticia']/node()"/></span></p>
		<p class="TituloPagina">
			<xsl:value-of select="/UsuariosNoticia/NOTICIA/NOT_TITULO"/>
			<span class="CompletarTitulo">
			</span>
		</p>
	</div>
	<br/>
	<br/>

      <table class="buscador">
        <tr class="sinLinea">
		  <td class="labelRight veinte"><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha']/node()"/>:&nbsp;</td>
          <td class="datosLeft"><xsl:value-of select="/UsuariosNoticia/NOTICIA/NOT_FECHA"/></td>
        </tr>
        <tr class="sinLinea">
          <td class="labelRight "><xsl:value-of select="document($doc)/translation/texts/item[@name='titulo']/node()"/>:&nbsp;</td>
          <td class="datosLeft"><xsl:value-of select="/UsuariosNoticia/NOTICIA/NOT_TITULO"/></td>
        </tr>
        <tr class="sinLinea">
          <td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='destinatarios']/node()"/>:&nbsp;</td>
          <td class="datosLeft"><xsl:value-of select="/UsuariosNoticia/NOTICIA/PUBLICA"/></td>
        </tr>
        <tr class="sinLinea">
          <td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='texto']/node()"/>:&nbsp;</td>
          <td class="datosLeft" colspan="5"><xsl:copy-of select="/UsuariosNoticia/NOTICIA/NOT_TEXTO"/></td>
		</tr>
      </table>

	<br/><br/>

	<table class="buscador">
      <tr class="subTituloTabla">
		  <th colspan="5"><xsl:value-of select="document($doc)/translation/texts/item[@name='lectores']/node()"/></th>
		</tr>
      <tr>
		  <th class="veinte">&nbsp;</th>
		  <th class="cinco" align="left"><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha']/node()"/></th>
		  <th class="veinte" align="left"><xsl:value-of select="document($doc)/translation/texts/item[@name='nombre']/node()"/></th>
		  <th class="veinte" align="left"><xsl:value-of select="document($doc)/translation/texts/item[@name='centro']/node()"/></th>
		  <th >&nbsp;</th>
	  </tr>

      <xsl:for-each select="/UsuariosNoticia/NOTICIA/LECTORES/LECTOR">
		<tr>
          <td>&nbsp;</td>
          <td style="text-align:left;"><xsl:value-of select="FECHA"/></td>
          <td style="text-align:left;"><xsl:value-of select="USUARIO"/></td>
          <td style="text-align:left;"><xsl:value-of select="CENTRO"/></td>
          <td>&nbsp;</td>
        </tr>
      </xsl:for-each>
	</table>

    </xsl:otherwise>
    </xsl:choose>
</body>
</html>
</xsl:template>
</xsl:stylesheet>
