<?xml version="1.0" encoding="iso-8859-1"?>
<!--
	Noticias MedicalVM. Nuevo disenno 2022.
	Ultima revision: ET 12ago22 09:00 Noticias2022_310522.js
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

	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery-3.6.0.js"></script>	
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic2022_010822.js"></script>
	<!--  PENDIENTE <script type="text/javascript" src="http://www.newco.dev.br/Noticias/uploadImage.js"/>-->
	<script type="text/javascript" src="http://www.newco.dev.br/Noticias/Noticias2022_310522.js"/>
	<script type="text/javascript" src="http://www.newco.dev.br/Noticias/CargaDocumentosNot_130619.js"/>
	<script type="text/javascript">
		str_NuevaNoticia='<xsl:value-of select="document($doc)/translation/texts/item[@name='nueva_noticia']/node()"/>';
		
	<!--
		PENDIENTE UTILIZAR ARRAY JS
		var Noticias=new Array();
		<xsl:for-each select="/WorkFlowPendientes/INICIO/NOTICIAS/NOTICIA">
			var Noticia=[];

			Noticia['Titulo']= '<xsl:value-of select="TITULO"/>';
			Noticia['Cuerpo']= '<xsl:value-of select="CUERPO"/>';
			Noticia['DocUrl']= '<xsl:value-of select="DOC_NOTICIA/URL"/>';
			Noticia['Destacada']= '<xsl:value-of select="DESTACADA"/>';
			Noticia['EnlaceAnchor']= '<xsl:value-of select="NOT_ENLACE_ANCHOR"/>';
			Noticia['EnlaceUrl']= '<xsl:value-of select="NOT_ENLACE_URL"/>';
			Noticia['Destinatarios']= '<xsl:value-of select="NOT_IDSELECCION"/>';

			Noticias.push(Noticia);
		</xsl:for-each>-->
		
	</script>
</head>

<body>
	<form action="Noticias2022.xsql" method="POST" name="frmNoticias">
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
		<p class="TituloPagina">
			<xsl:value-of select="document($doc)/translation/texts/item[@name='mantenimiento_noticias']/node()"/>&nbsp;
			<span class="CompletarTitulo">
			</span>
		</p>
	</div>
	<br/>
	<br/>
	<div class="tabela tabela_redonda">
	<table cellspacing="6px" cellpadding="6px">
		<thead class="cabecalho_tabela">
		<tr>
			<th class="w1x"></th>
			<th class="w50px"><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha']/node()"/></th>
			<th class="textLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='usuario']/node()"/></th>
			<th class="textLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='titulo']/node()"/></th>
			<th class="textLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='destinatarios']/node()"/></th>
			<th class="w100px"><xsl:value-of select="document($doc)/translation/texts/item[@name='documento']/node()"/></th>
			<th class="w100px"><xsl:value-of select="document($doc)/translation/texts/item[@name='enlace']/node()"/></th>
			<th class="w50px"><xsl:value-of select="document($doc)/translation/texts/item[@name='Destacada']/node()"/></th>
			<th class="w100px"><xsl:value-of select="document($doc)/translation/texts/item[@name='estado']/node()"/></th>
			<th class="w50px"><xsl:value-of select="document($doc)/translation/texts/item[@name='activar']/node()"/></th>
			<th class="w50px"><xsl:value-of select="document($doc)/translation/texts/item[@name='ocultar']/node()"/></th>
			<th class="w50px"><xsl:value-of select="document($doc)/translation/texts/item[@name='borrar']/node()"/></th>
		</tr>
		</thead>
		<!--	Cuerpo de la tabla	-->
		<tbody class="corpo_tabela">
		<xsl:for-each select="MantenimientoNoticias/NOTICIAS/NOTICIA">
			<tr class="conhover">
				<td class="color_status"><xsl:value-of select="CONTADOR"/></td>
				<td><xsl:value-of select="NOT_FECHA"/><input type="hidden" id="FECHA_{NOT_ID}" value="{NOT_FECHA}"/></td>
				<td class="textLeft"><xsl:value-of select="USUARIO"/><input type="hidden" id="IDUSUARIO_{NOT_ID}" value="{NOT_IDUSUARIO}"/></td>
				<td class="textLeft">
					<a>
						<xsl:attribute name="href">javascript:verNoticia('<xsl:value-of select="NOT_ID"/>');</xsl:attribute>
						<xsl:value-of select="NOT_TITULO"/>
					</a>
					<input type="hidden" id="TITULO_{NOT_ID}" value="{NOT_TITULO}"/>
					<input type="hidden" id="TEXTO_{NOT_ID}" value="{NOT_TEXTO}"/>
					<input type="hidden" id="ANCHOR_{NOT_ID}" value="{NOT_ENLACE_ANCHOR}"/>
					<input type="hidden" id="URL_{NOT_ID}" value="{NOT_ENLACE_URL}"/>
				</td>
				<td class="textLeft">
					<a href="javascript:UsuariosNoticia('{NOT_ID}');">
						<img src="http://www.newco.dev.br/images/verFichaIcon.gif"/>
					</a>&nbsp;
					<xsl:value-of select="DESTINATARIOS"/>
					<input type="hidden" id="IDSELECCION_{NOT_ID}" value="{NOT_IDSELECCION}"/>
				</td>
				<td class="textLeft">
            		<input type="hidden" id="DOC_ID_{NOT_ID}" value="{DOC_NOTICIA/ID}"/>
            		<input type="hidden" id="DOC_URL_{NOT_ID}" value="{DOC_NOTICIA/URL}"/>
            		<input type="hidden" id="DOC_NOMBRE_{NOT_ID}" value="{DOC_NOTICIA/NOMBRE}"/>
					<xsl:if test="DOC_NOTICIA">
						<a href="http://www.newco.dev.br/Documentos/{DOC_NOTICIA/URL}" target="_blank"><xsl:value-of select="DOC_NOTICIA/NOMBRE"/></a>
					</xsl:if>
        		</td>
				<td class="textLeft">
					<a href="{ENLACE/NOT_ENLACE_URL}">
					<xsl:value-of select="ENLACE/NOT_ENLACE_ANCHOR"/>
					</a>
					<input type="hidden" id="ENLACE_ANCHOR_{NOT_ID}" value="{ENLACE/NOT_ENLACE_ANCHOR}"/>
					<input type="hidden" id="ENLACE_URL_{NOT_ID}" value="{ENLACE/NOT_ENLACE_URL}"/>
				</td>
				<td><xsl:value-of select="NOT_DESTACADA"/><input type="hidden" id="DESTACADA_{NOT_ID}" value="{NOT_DESTACADA}"/></td>
				<td><xsl:value-of select="ESTADO"/><input type="hidden" id="ESTADO_{NOT_ID}" value="{NOT_ESTADO}"/></td>
				<td>
					<a href="javascript:EstadoNoticia('{NOT_ID}','ACTIVAR');">
						<strong>A</strong>
					</a>
				</td>
				<td>
					<a href="javascript:EstadoNoticia('{NOT_ID}','OCULTAR');">
						<strong><span class="azul">O</span></strong>
					</a>
				</td>
				<td>
					<a href="javascript:EstadoNoticia('{NOT_ID}','BORRAR');">
						<img src="http://www.newco.dev.br/images/2017/trash.png"/>
					</a>
				</td>
			</tr>
		</xsl:for-each>
		</tbody>
		<tfoot class="rodape_tabela">
			<tr><td colspan="12">&nbsp;</td></tr>
		</tfoot>
	</table>
 	</div>
 	<br/>  
 	<br/>  
	
	<div class="divLeft">"	
	<table cellspacing="6px" cellpadding="6px">
        <tr class="tituloTabla">
			<th colspan="2"><span id="TituloTabla" class="textLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='nueva_noticia']/node()"/></span>
			<div class="divRightw">
				<a class="btnDestacado" href="javascript:Guardar();"><xsl:value-of select="document($doc)/translation/texts/item[@name='guardar']/node()"/></a>&nbsp;&nbsp;
				<a class="btnNormal" href="javascript:Limpiar();"><xsl:value-of select="document($doc)/translation/texts/item[@name='nueva']/node()"/></a>
			</div>
			</th>
		</tr>
		<tr>
          <td class="labelRight trentacinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='titulo']/node()"/>:&nbsp;</td>
          <td class="datosLeft"><input type="text" id="NUEVA_TITULO" class="campopesquisa w600px" maxlength="200"/></td>
        </tr>
		<tr>
          <td class="labelRight" valign="top"><xsl:value-of select="document($doc)/translation/texts/item[@name='texto']/node()"/>:&nbsp;</td>
          <td class="datosLeft"><textarea id="NUEVA_TEXTO" class="w600px" rows="10" /></td>
        </tr>
		<tr>
          <td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='enlace_texto']/node()"/>:&nbsp;</td>
          <td class="datosLeft"><input type="text" id="NUEVA_ENLACE_ANCHOR" class="campopesquisa w600px"  maxlength="100"/></td>
        </tr>
		<tr>
          <td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='enlace_url']/node()"/>:&nbsp;</td>
          <td class="datosLeft"><input type="text" id="NUEVA_ENLACE_URL" class="campopesquisa w600px"  maxlength="200"/></td>
        </tr>
		<tr>
          <td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='Destacada']/node()"/>:&nbsp;</td>
          <td class="datosLeft"><input type="checkbox" id="CHK_DESTACADA" class="muypeq"/><input type="hidden" id="DESTACADA" name="DESTACADA"/></td>
        </tr>
		<tr>
          <td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='portal']/node()"/>:&nbsp;</td>
          <td class="datosLeft">
            <xsl:call-template name="desplegable">
        		<xsl:with-param name="nombre" select="'PORTAL'"/>
        		<xsl:with-param name="path" select="/MantenimientoNoticias/NOTICIAS/DESPLEGABLES/PORTALES/field"/>
           		<xsl:with-param name="claSel">w300px</xsl:with-param>
      		</xsl:call-template>
          </td>
        </tr>
		<tr>
			<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='destinatarios']/node()"/>:&nbsp;</td>
			<td class="datosLeft">
			<xsl:call-template name="desplegable">
    			<xsl:with-param name="path" select="/MantenimientoNoticias/NOTICIAS/DESPLEGABLES/SELECCIONES/field"/>
    			<xsl:with-param name="claSel">w300px</xsl:with-param>
			</xsl:call-template>
			</td>
			<td class="datosLeft">
            <!--1jun22 Quitamos el boton a selecciones
			<span id="seleccionEmpresas" style="display:none;">&nbsp;
              <a href="javascript:MostrarSelecciones();">
                <xsl:value-of select="document($doc)/translation/texts/item[@name='selecciones']/node()"/>
              </a>
            </span>-->
			</td>
        </tr>

        <!--	3jun19	Añadir documento a la noticia		-->
		<tr>
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
	</table>
	<br/>
	<br/>
	<br/>
	<br/>
	<br/>
	<br/>
	<br/>
	<br/>
	<br/>
	<br/>
	<br/>
	<br/>
	<br/>
	<br/>
	<br/>
  	</div>
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
