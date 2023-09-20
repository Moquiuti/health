<?xml version="1.0" encoding="iso-8859-1"?>
<!--
    Mostrar documentos de la empresa.
 		Ultima revision: ET 29oct20 16:30 MODocs_180920.js
 +-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:import href="http://www.newco.dev.br/General/General.xsl"/>
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="lang" select="@lang"/>
<xsl:template match="/Docs">

<html>
<head>
	<!--idioma-->
	<xsl:variable name="lang">
    <xsl:choose>
		<xsl:when test="LANG"><xsl:value-of select="LANG"/></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
    </xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->

	<meta http-equiv="Cache-Control" Content="no-cache"/>
	
	<title><xsl:value-of select="document($doc)/translation/texts/item[@name='pedido']/node()"/>&nbsp;<xsl:value-of select="/Docs/MULTIOFERTA/CENTROCLIENTE" disable-output-escaping="yes"/>&nbsp;:<xsl:value-of select="document($doc)/translation/texts/item[@name='documentos']/node()"/></title>

	<script type="text/javascript">
		var Empresa='<xsl:value-of select="/Docs/MULTIOFERTA/EMP_NOMBRE"/>';
		var IDMultioferta='<xsl:value-of select="/Docs/MULTIOFERTA/MO_ID"/>';
		var IDPedido='<xsl:value-of select="/Docs/MULTIOFERTA/PED_ID"/>';
		var LP_ID='<xsl:value-of select="/Docs/MULTIOFERTA/LP_ID"/>';
		var MOStatus='<xsl:value-of select="/Docs/MULTIOFERTA/MO_STATUS"/>';
		var IDCliente='<xsl:value-of select="/Docs/MULTIOFERTA/MO_IDCLIENTE"/>';
		var IDProveedor='<xsl:value-of select="/Docs/MULTIOFERTA/MO_IDPROVEEDOR"/>';
		var IDEmpresaUsuario='<xsl:value-of select="/Docs/MULTIOFERTA/IDEMPRESADELUSUARIO"/>';
		var Origen='<xsl:value-of select="/Docs/ORIGEN"/>';

		var strDocumentoBorrado='<xsl:value-of select="document($doc)/translation/texts/item[@name='Documento_borrado']/node()"/>';
		var alertSeguroEliminarDoc='<xsl:value-of select="document($doc)/translation/texts/item[@name='seguro_eliminar_documento']/node()"/>';
		var alrtErrorDesconocido='<xsl:value-of select="document($doc)/translation/texts/item[@name='error_sin_definir']/node()"/>';
	</script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery-1.8.3.min.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/descargas_151117.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/Compras/Multioferta/MODocs_180920.js"></script>
</head>

<body>
	<xsl:choose>
		<xsl:when test="//SESION_CADUCADA">
			<xsl:apply-templates select="//SESION_CADUCADA"/>
		</xsl:when>
		<xsl:when test="//xsql-error">
			<xsl:apply-templates select="//xsql-error"/>
		</xsl:when>
		<xsl:when test="//Status">
			<xsl:apply-templates select="//Status"/>
		</xsl:when>
		<xsl:otherwise>
			<xsl:apply-templates select="MULTIOFERTA"/>
		</xsl:otherwise>
	</xsl:choose>

  <div id="uploadFrameBox" style="display:none;"><iframe id="uploadFrame" name="uploadFrame" style="width:100%;"></iframe></div>
  <div id="uploadFrameBoxDoc" style="display:none;"><iframe id="uploadFrameDoc" name="uploadFrameDoc" style="width:100%;"></iframe></div>
</body>
</html>
</xsl:template>

<!--
 |  Templates
 +-->

<xsl:template match="MULTIOFERTA">
	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:choose>
		<xsl:when test="/Docs/LANG"><xsl:value-of select="/Docs/LANG"/></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->


	<!--	Titulo de la página		-->
	<div class="ZonaTituloPagina">
		<p class="Path"><xsl:value-of select="document($doc)/translation/texts/item[@name='Inicio']/node()"/>&nbsp;/&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='pedido']/node()"/>&nbsp;/&nbsp;<span class="FinPath"><xsl:value-of select="document($doc)/translation/texts/item[@name='documentos']/node()"/>&nbsp;</span>
			<xsl:if test="MVM or MVMB or ADMIN">
				<span class="CompletarTitulo">
					<span class="amarillo">MO_ID:&nbsp;<xsl:value-of select="/Docs/MULTIOFERTA/MO_ID"/></span>
				</span>
			</xsl:if>
		</p>
		<p class="TituloPagina">
			<xsl:if test="/Docs/MULTIOFERTA/CODIGO"><xsl:value-of select="/Docs/MULTIOFERTA/CODIGO" disable-output-escaping="yes"/>:&nbsp;</xsl:if>
			<xsl:value-of select="document($doc)/translation/texts/item[@name='pedido']/node()"/>&nbsp;<xsl:value-of select="/Docs/MULTIOFERTA/CENTROCLIENTE" disable-output-escaping="yes"/>
			<span class="CompletarTitulo">
				<!--<a class="btnNormal" href="javascript:DescargarExcel();"><img src="http://www.newco.dev.br/images/iconoExcel.gif" alt="Descargar Excel"/></a>&nbsp;-->
				<a class="btnNormal" href="javascript:window.close();" style="text-decoration:none;">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='salir']/node()"/>
				</a>&nbsp;
				<a class="btnNormal" href="javascript:window.print();" style="text-decoration:none;">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='imprimir']/node()"/>
				</a>&nbsp;
			</span>
		</p>
	</div>
	<br/>


	<div class="divLeft">
    <!--si usuario observador no puede añadir nuevos documentos-->
    <!--<xsl:if test="(/Docs/MULTIOFERTA/MVM or /Docs/MULTIOFERTA/MVMB or /Docs/MULTIOFERTA/USUARIO_CDC) and not(/Docs/MULTIOFERTA/OBSERVADOR)">-->
    <xsl:if test="/Docs/MULTIOFERTA/SUBIR_DOCUMENTOS">
			<!--tabla imagenes y documentos-->
     <!-- <table class="infoTableAma documentos" border="0">-->
      <table class="buscador documentos" border="0">
      <form name="SubirDocumentos" method="post">
        <input type="hidden" name="IDPROVEEDOR" id="IDPROVEEDOR" value="{/Docs/MULTIOFERTA/EMP_ID}"/>
        <input type="hidden" name="CADENA_DOCUMENTOS" />
        <input type="hidden" name="DOCUMENTOS_BORRADOS" />
        <input type="hidden" name="BORRAR_ANTERIORES" />
        <input type="hidden" name="REMOVE" value="{document($doc)/translation/texts/item[@name='remove']/node()}"/>

        <tr class="sinLinea">
          <!--documentos-->
          <td class="quince"><!--<strong><xsl:value-of select="document($doc)/translation/texts/item[@name='se_permite_cargar_documentos']/node()"/>.</strong>-->&nbsp;</td>
          <td class="labelRight diez">
            	<span class="text"><xsl:value-of select="document($doc)/translation/texts/item[@name='subir_documento']/node()"/>:&nbsp;</span>
          </td>
          <td class="datosLeft cuarenta">
            <div class="altaDocumento">
              <span class="anadirDoc">
                <xsl:call-template name="documentos"><xsl:with-param name="num" select="number(1)"/></xsl:call-template>
              </span>
            </div>
          </td>
          <td class="datosLeft diez">
            <select name="TIPO_DOC" id="TIPO_DOC" class="grande">
            <xsl:for-each select="/Docs/MULTIOFERTA/TIPOS_DOCUMENTOS/field/dropDownList/listElem">
              <option value="{ID}"><xsl:value-of select="listItem"/></option>
            </xsl:for-each>
            </select>
          </td>
          <td style="width:200px;">
            <!--<div class="boton">-->
          	<a class="btnDestacado" href="javascript:cargaDoc(document.forms['SubirDocumentos']);">
             	<xsl:value-of select="document($doc)/translation/texts/item[@name='subir_documento']/node()"/>
          	</a>
            <!--</div>-->
            <!--<div id="waitBoxDoc" align="center">&nbsp;</div> Este DIV despalazaba el botón	-->
          </td>
          <td style="width:100px;">
		  		<div id="waitBoxDoc" align="center">&nbsp;</div>
          </td>
          <td>
  		  		<div id="confirmBoxDocEmpresa" align="center" style="display:none;"><span class="cargado">¡<xsl:value-of select="document($doc)/translation/texts/item[@name='documento_cargado']/node()"/>!</span></div>
          </td>
        </tr>
      </form>
      </table><!--fin de tabla doc-->
    </xsl:if><!--fin if si es mvm-->
	<br/>
	<br/>

		<form name="frmDocumentos" action="http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPDocs.xsql" method="post">
       		<input type="hidden" name="IDFILTROEMPRESA" id="IDFILTROEMPRESA" value="{/Docs/MULTIOFERTA/EMP_ID}"/>
       		<input type="hidden" name="FICHAEMPRESA" id="FICHAEMPRESA" value="{/Docs/FICHAEMPRESA}"/>
			<xsl:if test="/Docs/MULTIOFERTA/DOCUMENTOS_COMPRADOR">
				<xsl:call-template name="tabla_documentos">
					<xsl:with-param name="path" select="/Docs/MULTIOFERTA/DOCUMENTOS_COMPRADOR"/>
					<xsl:with-param name="doc" select="$doc"/>
					<xsl:with-param name="titulo" select="document($doc)/translation/texts/item[@name='cliente']/node()"/>
				</xsl:call-template>
    		</xsl:if>
			<xsl:if test="/Docs/MULTIOFERTA/DOCUMENTOS_VENDEDOR">
				<xsl:call-template name="tabla_documentos">
					<xsl:with-param name="path" select="/Docs/MULTIOFERTA/DOCUMENTOS_VENDEDOR"/>
					<xsl:with-param name="doc" select="$doc"/>
					<xsl:with-param name="titulo" select="document($doc)/translation/texts/item[@name='proveedor']/node()"/>
				</xsl:call-template>
    		</xsl:if>
			<xsl:if test="not(/Docs/MULTIOFERTA/DOCUMENTOS_COMPRADOR/DOCUMENTO) and not(/Docs/MULTIOFERTA/DOCUMENTOS_VENDEDOR/DOCUMENTO)">
				<p style="text-align:center;font-size:18px;"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='sin_documentos']/node()"/></strong></p>
    		</xsl:if>
    	</form>
	</div><!--fin de divCenter50-->
</xsl:template>

<!--documentos-->
<xsl:template name="documentos">
	<xsl:param name="num"/>
	<xsl:choose>
	<!--imagenes de la tienda-->
	<xsl:when test="$num &lt; number(5)">
		<div class="docLine" id="docLine">
			<!--<xsl:if test="number($num) &gt; number(1)">
				<xsl:attribute name="style">display: none;</xsl:attribute>
			</xsl:if>-->
			<div class="docLongEspec" id="docLongEspec">
				<input id="inputFileDoc" name="inputFileDoc" type="file" style="width:500px;" onChange="addDocFile();" />
			</div>
		</div>
	</xsl:when>
	</xsl:choose>
</xsl:template>


<xsl:template name="tabla_documentos">
   <xsl:param name="path" />
   <xsl:param name="doc" />
   <xsl:param name="titulo" />
    <xsl:if test="$path/DOCUMENTO">
	<table class="buscador documentos">
        <input type="hidden" name="ID_EMPRESA" value="{/Docs/MULTIOFERTA/EMP_ID}"/> 
			<tr class="sinLinea"><th colspan="11">&nbsp;</th></tr>
			<tr class="subTituloTabla"><th colspan="11"><strong><xsl:value-of select="$titulo"/></strong></th></tr>
		  <!--nombres columnas-->
		  <tr>
			<th>&nbsp;</th>
			<th class="uno">&nbsp;</th>
			<th class="treinta" align="left">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='nombre']/node()"/></th>
			<th class="veinte" align="left">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='centro']/node()"/></th>
            <th class="veinte" align="left">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='usuario']/node()"/></th>
            <th style="width:200px;"><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha']/node()"/></th>
			<th class="uno"><xsl:value-of select="document($doc)/translation/texts/item[@name='eliminar']/node()"/></th>
			<th>&nbsp;</th>
        </tr>

   	<xsl:for-each select="$path/DOCUMENTO">
		<input type="hidden" id="st_{ID}" value="{COLOR}"/> 
			<tr class="conhover">
				<td>&nbsp;</td>
				<td id="doc_{ID}">
					<xsl:value-of select="CONTADOR"/>
				</td>
				<td class="textLeft">
					&nbsp;<strong><a>
						<xsl:attribute name="href">http://www.newco.dev.br/Documentos/<xsl:value-of select="URL"/></xsl:attribute>
						<xsl:value-of select="NOMBRETIPO"/>:&nbsp;<xsl:value-of select="NOMBRE"/>
					</a></strong>
				</td>
				<td class="textLeft">
					<xsl:value-of select="CENTRO"/>
				</td>				
				<td align="left"><xsl:value-of select="USUARIO"/></td>
				<td><xsl:value-of select="FECHA"/></td>
				<td>
					<xsl:if test="/Docs/MULTIOFERTA/ADMIN or DOC_IDUSUARIO=/Docs/MULTIOFERTA/IDUSUARIO">
						<a>
							<xsl:attribute name="href">javascript:EliminarDocumento('<xsl:value-of select="ID"/>','<xsl:value-of select="TIPO"/>','<xsl:value-of select="NOMBRE_CORTO"/>');</xsl:attribute>
							<img src="http://www.newco.dev.br/images/2017/trash.png" alt="eliminar"/>
						</a>
						<div id="waitBoxOferta_{ID}" class="gris" style="display:none; margin-top:5px;">
                			<xsl:value-of select="document($doc)/translation/texts/item[@name='cargando']/node()"/>...&nbsp;
            			</div>
					</xsl:if>
				</td>
				<td>&nbsp;</td>
			</tr>
		</xsl:for-each>
	</table>
	</xsl:if>
</xsl:template>		

<!--fin de documentos-->
</xsl:stylesheet>
