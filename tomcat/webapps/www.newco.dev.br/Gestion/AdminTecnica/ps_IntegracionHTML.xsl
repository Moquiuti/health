<?xml version="1.0" encoding="iso-8859-1"?>
<!--
 |	Gestión de los fichero de integración 
+-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:import href = "http://www.newco.dev.br/General/General.xsl"/>
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="lang" select="@lang"/>
<xsl:template match="/Integracion">

<html>
<head>
	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:choose>
			<xsl:when test="/Administracion/LANG"><xsl:value-of select="/Administracion/LANG"/></xsl:when>
			<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

  <meta http-equiv="Cache-Control" Content="no-cache"/>

  <title><xsl:value-of select="document($doc)/translation/texts/item[@name='detalle_empresa']/node()"/></title>
	<title><xsl:value-of select="document($doc)/translation/texts/item[@name='integracion']/node()"/></title>

  <!--style-->
	<xsl:call-template name="estiloIndip"/>
  <!--fin de style-->
  <!-- Empresas -->
  <script type="text/javascript" src="http://www.newco.dev.br/General/jquery-1.8.3.min.js"></script>
  <script type="text/javascript" src="http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPDetalleCabecera160216.js"></script>

  <!--<script type="text/javascript">
    var lang      = '<xsl:value-of select="LANG"/>';
    var IDEmpresa = '<xsl:value-of select="EMP_ID"/>';
    var Destino   = '<xsl:value-of select="DEST"/>';

    var imgPesProv, imgPesProvSel;
    <xsl:choose>
    <xsl:when test="EMPRESA/RESUMENPROVEEDORES/PROVEEDOR/NOTAMEDIA = 1">
      imgPesProv    = 'http://www.newco.dev.br/images/boton1star.gif';
      imgPesProvSel = 'http://www.newco.dev.br/images/boton1star1.gif';
    </xsl:when>
    <xsl:when test="EMPRESA/RESUMENPROVEEDORES/PROVEEDOR/NOTAMEDIA = 2">
      imgPesProv    = 'http://www.newco.dev.br/images/boton2star.gif';
      imgPesProvSel = 'http://www.newco.dev.br/images/boton2star1.gif';
    </xsl:when>
    <xsl:when test="EMPRESA/RESUMENPROVEEDORES/PROVEEDOR/NOTAMEDIA = 3">
      imgPesProv    = 'http://www.newco.dev.br/images/boton3star.gif';
      imgPesProvSel = 'http://www.newco.dev.br/images/boton3star1.gif';
    </xsl:when>
    <xsl:when test="EMPRESA/RESUMENPROVEEDORES/PROVEEDOR/NOTAMEDIA = 4">
      imgPesProv    = 'http://www.newco.dev.br/images/boton4star.gif';
      imgPesProvSel = 'http://www.newco.dev.br/images/boton4star1.gif';
    </xsl:when>
    <xsl:when test="EMPRESA/RESUMENPROVEEDORES/PROVEEDOR/NOTAMEDIA = 5">
      imgPesProv    = 'http://www.newco.dev.br/images/boton5star.gif';
      imgPesProvSel = 'http://www.newco.dev.br/images/boton5star1.gif';
    </xsl:when>
    <xsl:otherwise>
      imgPesProv    = 'http://www.newco.dev.br/images/boton2star.gif';
      imgPesProvSel = 'http://www.newco.dev.br/images/boton2star1.gif';
    </xsl:otherwise>
    </xsl:choose>
  </script>-->

  <!-- Fin de Empresas -->
</head>

<xsl:choose>
<xsl:when test="//xsql-error">
  <xsl:apply-templates select="//xsql-error"/>

  <body>
    <br/><br/>
    <center><xsl:apply-templates select="//jumpTo"/></center>
  </body>
</xsl:when>
<xsl:otherwise>

	 <!--idioma-->
  <xsl:variable name="lang">
    <xsl:choose>
    <xsl:when test="LANG"><xsl:value-of select="LANG"/></xsl:when>
    <xsl:otherwise>spanish</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
  <!--idioma fin-->

  <h1 class="titlePage"><xsl:value-of select="document($doc)/translation/texts/item[@name='integracion']/node()"/></h1>

  <!-- Desplegable empresas-->
  <xsl:if test="EMPRESA/MVM or EMPRESA/ADMIN or EMPRESA/COMERCIAL or EMPRESA/CDC">
    <form name="Empresas" id="Empresas">
    <table class="infoTable" style="margin-bottom:10px;">
      <tr style="background:#C3D2E9;border-bottom:0px solid #3B5998;">
        <td>
          <p style="font-weight:bold;">
            <xsl:call-template name="desplegable">
              <xsl:with-param name="path" select="EMPRESA/EMPRESAS/field"/>
              <xsl:with-param name="onChange">javascript:CambiarEmpresa(this.value);</xsl:with-param>
              <xsl:with-param name="claSel">selectFont18</xsl:with-param>
            </xsl:call-template>&nbsp;&nbsp;
            <input type="hidden" name="IDPAIS" value="{EMPRESA/IDPAIS}"/>
            <input type="hidden" name="IDEMPRESA" value="{EMPRESA/IDEMPRESA}"/>
            <input type="hidden" name="IDEMPRESAUSUARIO" value="{EMPRESA/IDEMPRESADELUSUARIO}"/>
            <input type="checkbox" name="SOLO_CLIENTES" onchange="soloClientes(document.forms['Empresas']);"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='solo_clientes']/node()"/>&nbsp;&nbsp;
            <input type="checkbox" name="SOLO_PROVEE" onchange="soloProvee(document.forms['Empresas']);"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='solo_proveedores']/node()"/>
          </p>
        </td>
      </tr>
    </table>
    </form>
  </xsl:if><!--fin desplegable empresas, para saber de que empresa veo los datos-->

  <!-- INICIO Pestañas Lado Izquierdo -->
    <div style="background:#fff;float:left;">
      <xsl:if test="EMP_ID != ''">
      <!-- INICIO Pestaña 'Ficha' (todos) -->
        &nbsp;<a href="#" id="Ficha" class="pestanaEmpresa" style="text-decoration:none;">
          <xsl:choose>
          <xsl:when test="LANG = 'spanish'">
            <img src="http://www.newco.dev.br/images/botonFicha1.gif" alt="FICHA" id="FICHA"/>
          </xsl:when>
          <xsl:otherwise>
            <img src="http://www.newco.dev.br/images/botonFicha1.gif" alt="FICHA" id="FICHA"/>
          </xsl:otherwise>
          </xsl:choose>
          </a>&nbsp;
      </xsl:if>
      <!-- FIN Pestaña 'Ficha' -->

      <!-- INICIO Pestaña 'Documentos' (solo usuarios clientes) -->
      <xsl:if test="EMP_ID != ''">
        <a href="#" id="Documentos" class="pestanaEmpresa" style="text-decoration:none;">
          <img src="http://www.newco.dev.br/images/botonDocumentos.gif" alt="DOCUMENTOS" id="DOCUMENTOS"/>
        </a>&nbsp;
      </xsl:if>
      <!-- FIN Pestaña 'Documentos' -->
    </div>
    <!-- FIN Pestañas Lado Izquierdo -->

  <!-- INICIO Pestañas Lado Derecho (solo MVM) -->
  <!--<xsl:if test="EMPRESA/MVM">-->
    <div style="background:#fff;float:right;">
      <a href="#" id="Buscador" class="pestanaEmpresa" style="text-decoration:none;">
        <img src="http://www.newco.dev.br/images/botonBuscador.gif" alt="BUSCADOR"/>
      </a>
    </div>
  <!--</xsl:if>-->
  <!-- FIN Pestañas Lado Derecho -->

  <!-- iframe único para mostrar el contenido de cada pestaña -->
  <iframe width="100%" height="90%" frameBorder="0" id="iframeEmpresas"/>

<!-- PS inicio código de mantenimiento de productos y final código de Empresas -->

</xsl:otherwise>
</xsl:choose>
</html>
</xsl:template>
</xsl:stylesheet>
