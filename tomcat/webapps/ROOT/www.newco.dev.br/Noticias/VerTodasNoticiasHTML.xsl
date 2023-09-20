<?xml version="1.0" encoding="iso-8859-1"?>
<!--
	Noticias MedicalVM
	Ultima revision: ET ET 31may22 09:45 Noticias_310522.js
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href="http://www.newco.dev.br/General/General.xsl"/>
  <xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
  <xsl:param name="lang" select="@lang"/>

<xsl:template match="/">
<html>
<head>

	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:choose>
		<xsl:when test="/Noticias/LANG"><xsl:value-of select="/Noticias/LANG" /></xsl:when>
		<xsl:when test="/MantenimientoNoticias/LANG"><xsl:value-of select="/MantenimientoNoticias/LANG" /></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<title><xsl:value-of select="document($doc)/translation/texts/item[@name='mantenimiento_noticias']/node()"/></title>
	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->

	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"/>
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"/>
	<!--  PENDIENTE <script type="text/javascript" src="http://www.newco.dev.br/Noticias/uploadImage.js"/>-->
	<script type="text/javascript" src="http://www.newco.dev.br/Noticias/Noticias_310522.js"/>
	<script type="text/javascript" src="http://www.newco.dev.br/Noticias/CargaDocumentosNot_130619.js"/>
	<script type="text/javascript">
		str_NuevaNoticia='<xsl:value-of select="document($doc)/translation/texts/item[@name='nueva_noticia']/node()"/>';
	</script>
</head>

<body>

	<form action="MantenimientoNoticias.xsql" method="POST" name="frmNoticias">
		<xsl:variable name="Mantenimiento">
			<!--	Controlara si es un indice para mantenimiento o	consulta-->
			<xsl:value-of select="Noticias/Mantenimiento"/>
		</xsl:variable>

    <xsl:choose>
    <!-- ET Desactivado control errores: Habra que reactivarlo -->
    <xsl:when test="Noticias/xsql-error">
      <xsl:apply-templates select="Noticias/xsql-error"/>
    </xsl:when>
    <xsl:when test="Noticias/ROW/Sorry">
      <xsl:apply-templates select="Noticias/ROW/Sorry"/>
    </xsl:when>
    <xsl:otherwise>
		<xsl:choose>
		<xsl:when test="$Mantenimiento=1">
        <xsl:apply-templates select="Noticias/button"/>
		</xsl:when>
		</xsl:choose>

      <xsl:value-of select="@TIPO"/>

		<!-- Campos ocultos para transmision de datos	-->
		<input type="hidden" id="ACCION" name="ACCION"/>
		<input type="hidden" name="IDEMPRESAUSUARIO" value="{/MantenimientoNoticias/NOTICIAS/IDEMPRESAUSUARIO}"/>
		<input type="hidden" id="IDNOTICIA" name="IDNOTICIA"/>
		<input type="hidden" id="FECHA"  name="FECHA"/>
		<input type="hidden" id="IDUSUARIO" name="IDUSUARIO"/>
		<input type="hidden" id="TITULO" name="TITULO"/>
		<input type="hidden" id="TEXTO" name="TEXTO"/>
		<input type="hidden" id="URL" name="URL"/>
		<input type="hidden" id="ANCHOR" name="ANCHOR"/>
		<input type="hidden" id="PUBLICA" name="PUBLICA"/>
		<input type="hidden" id="DESTINATARIOS" name="DESTINATARIOS"/>
		<input type="hidden" id="ESTADO" name="ESTADO"/>
		<input type="hidden" name="CADENA_IMAGENES"/>
		<input type="hidden" name="IMAGENES_BORRADAS"/>

		<!--	para subir documentos	-->
		<input type="hidden" id="IDDOCUMENTO" name="IDDOCUMENTO"/>
    	<input type="hidden" name="CADENA_DOCUMENTOS" />
    	<input type="hidden" name="DOCUMENTOS_BORRADOS"/>
    	<input type="hidden" name="BORRAR_ANTERIORES"/>
    	<input type="hidden" name="ID_USUARIO" value="" />
    	<input type="hidden" name="TIPO_DOC" value="DOC_SEGUIMIENTO"/>

    	<div id="uploadFrameBox" style="display:none;"><iframe src="" id="uploadFrame" name="uploadFrame" style="width: 100%;"></iframe></div>
    	<div id="uploadFrameBoxDoc" style="display:none;"><iframe src="" id="uploadFrameDoc" name="uploadFrameDoc" style="width: 100%;"></iframe></div>

      <!--idioma-->
      <xsl:variable name="lang">
        <xsl:choose>
        <xsl:when test="/Noticias/LANG"><xsl:value-of select="/Noticias/LANG" /></xsl:when>
        <xsl:when test="/MantenimientoNoticias/LANG"><xsl:value-of select="/MantenimientoNoticias/LANG" /></xsl:when>
        <xsl:otherwise>spanish</xsl:otherwise>
        </xsl:choose>
      </xsl:variable>
      <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
      <!--idioma fin-->

			<!--	Titulo de la página		-->
			<div class="ZonaTituloPagina">
				<p class="Path"><xsl:value-of select="document($doc)/translation/texts/item[@name='Inicio']/node()"/>&nbsp;/&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Gestion']/node()"/>&nbsp;/&nbsp;<span class="FinPath"><xsl:value-of select="document($doc)/translation/texts/item[@name='mantenimiento_noticias']/node()"/></span></p>
				<p class="TituloPagina">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='mantenimiento_noticias']/node()"/>&nbsp;
					<span class="CompletarTitulo">
					</span>
				</p>
			</div>
			<br/>
			<br/>

		<table class="buscador">
		<tr class="subTituloTabla">
		  <th class="ocho"><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha']/node()"/></th>
		  <th class="doce"><xsl:value-of select="document($doc)/translation/texts/item[@name='usuario']/node()"/></th>
		  <th class="veinte"><xsl:value-of select="document($doc)/translation/texts/item[@name='titulo']/node()"/></th>
		  <th class="quince"><xsl:value-of select="document($doc)/translation/texts/item[@name='destinatarios']/node()"/></th>
		  <th class="dies"><xsl:value-of select="document($doc)/translation/texts/item[@name='documento']/node()"/></th>
		  <th class="dies"><xsl:value-of select="document($doc)/translation/texts/item[@name='enlace']/node()"/></th>
		  <th class="cinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='Destacada']/node()"/></th>
		  <th class="dies"><xsl:value-of select="document($doc)/translation/texts/item[@name='estado']/node()"/></th>
		  <th class="cinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='activar']/node()"/></th>
		  <th class="cinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='ocultar']/node()"/></th>
		  <th class="cinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='borrar']/node()"/></th>
	  </tr>

			<xsl:for-each select="MantenimientoNoticias/NOTICIAS/NOTICIA">
				<tr>
					<td><xsl:value-of select="NOT_FECHA"/><input type="hidden" id="FECHA_{NOT_ID}" value="{NOT_FECHA}"/></td>
					<td style="text-align:left;"><xsl:value-of select="USUARIO"/><input type="hidden" id="IDUSUARIO_{NOT_ID}" value="{NOT_IDUSUARIO}"/></td>
					<td style="text-align:left;">
						<a>
							<xsl:attribute name="href">javascript:verNoticia('<xsl:value-of select="NOT_ID"/>');</xsl:attribute>
							<xsl:value-of select="NOT_TITULO"/>
						</a>
						<input type="hidden" id="TITULO_{NOT_ID}" value="{NOT_TITULO}"/>
						<input type="hidden" id="TEXTO_{NOT_ID}" value="{NOT_TEXTO}"/>
						<input type="hidden" id="ANCHOR_{NOT_ID}" value="{NOT_ENLACE_ANCHOR}"/>
						<input type="hidden" id="URL_{NOT_ID}" value="{NOT_ENLACE_URL}"/>
					</td>
					<td style="text-align:left;">
						<a href="javascript:UsuariosNoticia('{NOT_ID}');" style="text-decoration:none;">
							<img src="http://www.newco.dev.br/images/verFichaIcon.gif"/>
						</a>&nbsp;
						<xsl:value-of select="DESTINATARIOS"/>
						<input type="hidden" id="IDSELECCION_{NOT_ID}" value="{NOT_IDSELECCION}"/>
					</td>
					<td style="text-align:left;">
            			<input type="hidden" id="DOC_ID_{NOT_ID}" value="{DOC_NOTICIA/ID}"/>
            			<input type="hidden" id="DOC_URL_{NOT_ID}" value="{DOC_NOTICIA/URL}"/>
            			<input type="hidden" id="DOC_NOMBRE_{NOT_ID}" value="{DOC_NOTICIA/NOMBRE}"/>
						<xsl:if test="DOC_NOTICIA">
							<a href="http://www.newco.dev.br/Documentos/{DOC_NOTICIA/URL}" target="_blank"><xsl:value-of select="DOC_NOTICIA/NOMBRE"/></a>
						</xsl:if>
        			</td>
					<td style="text-align:left;">
						<a href="{ENLACE/NOT_ENLACE_URL}">
						<xsl:value-of select="ENLACE/NOT_ENLACE_ANCHOR"/>
						</a>
						<input type="hidden" id="ENLACE_ANCHOR_{NOT_ID}" value="{ENLACE/NOT_ENLACE_ANCHOR}"/>
						<input type="hidden" id="ENLACE_URL_{NOT_ID}" value="{ENLACE/NOT_ENLACE_URL}"/>
					</td>
					<td><xsl:value-of select="NOT_DESTACADA"/><input type="hidden" id="DESTACADA_{NOT_ID}" value="{NOT_DESTACADA}"/></td>
					<td><xsl:value-of select="ESTADO"/><input type="hidden" id="ESTADO_{NOT_ID}" value="{NOT_ESTADO}"/></td>
					<td>
						<a href="javascript:EstadoNoticia('{NOT_ID}','ACTIVAR');" style="text-decoration:none;">
							<strong>A</strong>
						</a>
					</td>
					<td>
						<a href="javascript:EstadoNoticia('{NOT_ID}','OCULTAR');" style="text-decoration:none;">
							<strong><span class="azul">O</span></strong>
						</a>
					</td>
					<td>
						<a href="javascript:EstadoNoticia('{NOT_ID}','BORRAR');" style="text-decoration:none;">
							<img src="http://www.newco.dev.br/images/2017/trash.png"/>
						</a>
					</td>
				</tr>
			</xsl:for-each>
			</table>
			<br/><br/>
			
		<table class="buscador" >
        <tr class="tituloTabla">
			<th colspan="2"><span id="TituloTabla"><xsl:value-of select="document($doc)/translation/texts/item[@name='nueva_noticia']/node()"/></span></th>
		</tr>
		<tr class="sinLinea">
          <td class="labelRight trentacinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='titulo']/node()"/>:&nbsp;</td>
          <td class="datosLeft"><input type="text" id="NUEVA_TITULO" class="muygrande" maxlength="200" size="80"/></td>
        </tr>
		<tr class="sinLinea">
          <td class="labelRight" valign="top"><xsl:value-of select="document($doc)/translation/texts/item[@name='texto']/node()"/>:&nbsp;</td>
          <td class="datosLeft"><textarea id="NUEVA_TEXTO" maxlength="2000" rows="10" cols="77"/></td>
        </tr>
		<tr class="sinLinea">
          <td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='enlace_texto']/node()"/>:&nbsp;</td>
          <td class="datosLeft"><input type="text" id="NUEVA_ENLACE_ANCHOR" class="muygrande" maxlength="100" size="80"/></td>
        </tr>
		<tr class="sinLinea">
          <td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='enlace_url']/node()"/>:&nbsp;</td>
          <td class="datosLeft"><input type="text" id="NUEVA_ENLACE_URL" class="muygrande" maxlength="200" size="80"/></td>
        </tr>
		<tr class="sinLinea">
          <td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='Destacada']/node()"/>:&nbsp;</td>
          <td class="datosLeft"><input type="checkbox" id="CHK_DESTACADA" class="muypeq"/><input type="hidden" id="DESTACADA" name="DESTACADA"/></td>
        </tr>
		<tr class="sinLinea">
          <td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='portal']/node()"/>:&nbsp;</td>
          <td class="datosLeft">
            <xsl:call-template name="desplegable">
        		<xsl:with-param name="nombre" select="'PORTAL'"/>
        		<xsl:with-param name="path" select="/MantenimientoNoticias/NOTICIAS/DESPLEGABLES/PORTALES/field"/>
      		</xsl:call-template>
          </td>
        </tr>
		<tr class="sinLinea">
          <td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='destinatarios']/node()"/>:&nbsp;</td>
          <td class="datosLeft">
            <xsl:call-template name="desplegable">
        		<xsl:with-param name="path" select="/MantenimientoNoticias/NOTICIAS/DESPLEGABLES/SELECCIONES/field"/>
      		</xsl:call-template>
          </td>
          <td class="datosLeft">
            <span id="seleccionEmpresas" style="display:none;">&nbsp;
              <a style="text-decoration:none;" href="javascript:MostrarSelecciones();">
                <xsl:value-of select="document($doc)/translation/texts/item[@name='selecciones']/node()"/>
              </a>
            </span>
			</td>
        </tr>

        <!--	3jun19	Añadir documento a la noticia		-->
		<tr class="sinLinea">
			<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='documento']/node()"/>:&nbsp;</td>
			<td colspan="3" style="text-align:left; padding-left:3px;">
				<input style="width:500px;" id="inputFileDoc" name="inputFileDoc" type="file" onchange="javascript:addDocFile(document.forms['frmNoticias']);cargaDoc(document.forms['frmNoticias'], 'DOC_NOTICIA');"/>
				<div id="divDatosDocumento" style="display:none;">
            		<a id="docSubido">
                    	&nbsp;
                	</a>
					<a href="javascript:borrarDoc('DOC_NOTICIA')" style="width:20px;margin-top:4px;vertical-align:middle;"><img src="http://www.newco.dev.br/images/2017/trash.png"/></a>
				</div>
            	<div id="waitBoxDoc" style="display:none;"><img src="http://www.newco.dev.br/images/descarga.gif" alt="Descarga" /></div>
            	<div id="confirmBox" style="display:none;" align="center">
                	<span class="cargado" style="font-size:10px;"><xsl:value-of select="document($doc)/translation/texts/item[@name='documento_cargado']/node()"/>!</span>
            	</div>
			</td>
        </tr>
        <!--	3jun19	Añadir documento al seguimiento		-->

		<tr class="sinLinea">
			<td>&nbsp;</td>
 			<td align="left">
				<a class="btnDestacado" href="javascript:Guardar();">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='guardar']/node()"/>&nbsp;</a>
				<a class="btnNormal" href="javascript:Limpiar();">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='nueva']/node()"/>&nbsp;</a>
			</td>
 			<td>&nbsp;</td>
		</tr>
	</table>
    </xsl:otherwise>
    </xsl:choose>
	</form>
  
</body>
</html>
</xsl:template>

<!--INICIO TEMPLATE IMAGE-->
 <xsl:template name="image">
	<xsl:param name="num" />

    	<!--idioma-->
        <xsl:variable name="lang">
        	<xsl:value-of select="//LANG" />
        </xsl:variable>
        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
      <!--idioma fin-->

	<div class="imageLineEmp" id="imageLine_{$num}">

			<label class="medium" for="inputFile_{$num}" style="display:none;">&nbsp;</label>
			<input id="inputFile_{$num}" name="inputFile" type="file" onchange="addFile({$num});" />
	</div>
    <div id="waitBox">&nbsp;</div>
    <div id="confirmBox">&nbsp;</div>
</xsl:template>
</xsl:stylesheet>
