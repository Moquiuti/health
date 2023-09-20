<?xml version="1.0" encoding="iso-8859-1"?>
<!--
    13set16	Mostrar documentos del centro (adaptado desde EMPDocsHTML.xsl)
 	ultima revision: ET 16set21 09:00 CENDocs_180821.js
-->
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

	<title><xsl:value-of select="/Docs/CENTRO/CEN_NOMBRE"/>:&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='documentos']/node()"/></title>

	<meta http-equiv="Cache-Control" Content="no-cache"/>

	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery-1.8.3.min.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/CENDocs_180821.js"></script>

<xsl:text disable-output-escaping="yes">
<![CDATA[
	<script type="text/javascript">

	</script>
]]>
</xsl:text>
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
			<xsl:apply-templates select="CENTRO"/>
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

<xsl:template match="CENTRO">
	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:choose>
		<xsl:when test="/Docs/LANG"><xsl:value-of select="/Docs/LANG"/></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<!--	9set16	Pestaña: ficha y documentos, visible para cualqueira con permiso para abrir esta ficha	- ->
	<div style="background:#fff;float:left;">
	<!- -	Pestaña FICHA para todos - ->
	<a href="http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/CENDetalle.xsql?CEN_ID={/Docs/CENTRO/CEN_ID}&amp;ESTADO=CABECERA" style="text-decoration:none;">
	  <xsl:choose>
	  <xsl:when test="/Empresas/LANG = 'spanish'">
    	<img src="http://www.newco.dev.br/images/botonFicha.gif" alt="FICHA" id="FICHA"/>
	  </xsl:when>
	  <xsl:otherwise>
    	<img src="http://www.newco.dev.br/images/botonFicha.gif" alt="FICHA" id="FICHA"/>
	  </xsl:otherwise>
	  </xsl:choose>
	</a>&nbsp;
	<a href="javascript:verPestana('DOCS');" style="text-decoration:none;">
		<img src="http://www.newco.dev.br/images/botonDocumentos1.gif" alt="DOCUMENTOS" id="DOCUMENTOS"/>
	</a>&nbsp;
	</div>
	-->
 	<div class="divLeft">
		<ul class="pestannas">
			<li>
				<a href="http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/CENDetalle.xsql?CEN_ID={/Docs/CENTRO/CEN_ID}&amp;ESTADO=CABECERA" id="Ficha" class="MenuEmp"><xsl:value-of select="document($doc)/translation/texts/item[@name='Ficha']/node()"/></a>
			</li>
			<li>
				<a href="#" id="Docs" class="MenuEmp" style="background:#3b569b;color:#D6D6D6"><xsl:value-of select="document($doc)/translation/texts/item[@name='documentos']/node()"/></a>
			</li>
		</ul>
	</div>
	<br/>
	<br/>
	<!--	FIN PESTAÑAS		-->

	<div class="divLeft"><!--	Sin esto, se montan a las pestañas	-->
	<!--	Titulo de la página		-->
	<div class="ZonaTituloPagina">
		<p class="Path"><xsl:value-of select="document($doc)/translation/texts/item[@name='Inicio']/node()"/>&nbsp;/&nbsp;<span class="FinPath"><xsl:value-of select="document($doc)/translation/texts/item[@name='centro']/node()"/>&nbsp;</span>
		<span class="CompletarTitulo">
			<xsl:if test="/Docs/CENTRO/MVM or /Docs/CENTRO/MVMB or /Docs/CENTRO/ADMIN"><span class="amarillo">CEN_ID:&nbsp;<xsl:value-of select="/Docs/CENTRO/CEN_ID"/></span></xsl:if>
		</span></p>
		<p class="TituloPagina">
			<xsl:choose>
			<xsl:when test="CEN_NOMBRE_CORTO != ''"><xsl:value-of select="CEN_NOMBRE_CORTO" disable-output-escaping="yes"/></xsl:when>
			<xsl:otherwise><xsl:value-of select="CEN_NOMBRE" disable-output-escaping="yes"/></xsl:otherwise>
			</xsl:choose><!--:&nbsp;&nbsp;(<xsl:value-of select="document($doc)/translation/texts/item[@name='documentos']/node()"/>)-->
			<span class="CompletarTitulo">
				<xsl:if test="/Mantenimiento/form/CENTRO/ADMIN">
					<xsl:text>&nbsp;&nbsp;&nbsp;</xsl:text>
					<a class="btnNormal">
						<xsl:attribute name="href">http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/CENManten.xsql?ID=<xsl:value-of select="/Docs/CENTRO/CEN_ID"/></xsl:attribute>
						<xsl:value-of select="document($doc)/translation/texts/item[@name='modificar']/node()"/>
					</a>
					&nbsp;
				</xsl:if>
				<xsl:if test="/Mantenimiento/form/CENTRO/MVM or /Mantenimiento/form/CENTRO/MVMB">
					<a class="btnNormal" href="javascript:window.print();" style="text-decoration:none;" title="Imprimir">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='imprimir']/node()"/>
					</a>
					&nbsp;
				</xsl:if>
			</span>
		</p>
	</div>
	<br/>
	</div>

	<div class="divLeft">
	<!--
		<h1 class="titlePage documentos" style="float:left;width:60%;padding-left:20%;">
      <xsl:choose>
      <xsl:when test="CEN_NOMBRE_CORTO != ''"><xsl:value-of select="CEN_NOMBRE_CORTO" disable-output-escaping="yes"/></xsl:when>
      <xsl:otherwise><xsl:value-of select="CEN_NOMBRE" disable-output-escaping="yes"/></xsl:otherwise>
      </xsl:choose>:&nbsp;
      <xsl:value-of select="document($doc)/translation/texts/item[@name='documentos']/node()"/><!- -&nbsp;<xsl:value-of select="CEN_TIPO"/>- ->
			<xsl:if test="/Docs/CENTRO/MVM or /Docs/CENTRO/MVMB">
				<xsl:text>&nbsp;&nbsp;&nbsp;</xsl:text>
				<a href="javascript:window.print();" style="text-decoration:none;">
					<img src="http://www.newco.dev.br/images/imprimir.gif"/>
					<xsl:value-of select="document($doc)/translation/texts/item[@name='imprimir']/node()"/>
				</a>
			</xsl:if>
		</h1>
    <h1 class="titlePage documentos" style="float:left;width:20%;">
      <xsl:if test="/Docs/CENTRO/MVM or /Docs/CENTRO/MVMB or /Docs/CENTRO/ADMIN"><span style="float:right; padding:5px;" class="amarillo">CEN_ID: <xsl:value-of select="CEN_ID"/></span></xsl:if>
    </h1>
	-->

    <!--si usuario observador no puede añadir nuevos documentos-->
    <xsl:if test="(/Docs/CENTRO/MVM or /Docs/CENTRO/MVMB or /Docs/CENTRO/CDC) and not(/Docs/CENTRO/OBSERVADOR)">
		<!--tabla imagenes y documentos-->
      <table class="infoTableAma documentos" border="0">
      <form name="SubirDocumentos" method="post">
        <input type="hidden" name="CEN_ID" id="CEN_ID" value="{/Docs/CENTRO/CEN_ID}"/>
        <input type="hidden" name="CADENA_DOCUMENTOS" />
        <input type="hidden" name="DOCUMENTOS_BORRADOS" />
        <input type="hidden" name="BORRAR_ANTERIORES" />
        <input type="hidden" name="REMOVE" value="{document($doc)/translation/texts/item[@name='remove']/node()}"/>

        <tr>
          <!--documentos-->
          <td class="quince"><!--<strong><xsl:value-of select="document($doc)/translation/texts/item[@name='se_permite_cargar_documentos']/node()"/>.</strong>-->&nbsp;</td>
          <td class="labelRight dies">
            <span class="text"><xsl:value-of select="document($doc)/translation/texts/item[@name='subir_documento']/node()"/></span>
          </td>
          <td class="datosLeft veintecinco">
            <div class="altaDocumento">
              <span class="anadirDoc">
                <xsl:call-template name="documentos"><xsl:with-param name="num" select="number(1)"/></xsl:call-template>
              </span>
            </div>
          </td>
          <td class="datosLeft dies">
            <select name="TIPO_DOC" id="TIPO_DOC" class="grande">
            <xsl:for-each select="/Docs/CENTRO/TIPOS_DOCUMENTOS/field/dropDownList/listElem">
              <option value="{ID}"><xsl:value-of select="listItem"/></option>
            </xsl:for-each>
            </select>
          </td>
          <td class="trenta">
            <!--<div class="boton">-->
              <a class="btnDestacado" href="javascript:cargaDoc(document.forms['SubirDocumentos']);">
                <xsl:value-of select="document($doc)/translation/texts/item[@name='subir_documento']/node()"/>
              </a>
            <!--</div>-->
          </td>
          <td>
            <div id="waitBoxDoc" align="center">&nbsp;</div>
          </td>
          <td>
  		  		<div id="confirmBoxDocCentro" align="center" style="display:none;"><span class="cargado">¡<xsl:value-of select="document($doc)/translation/texts/item[@name='documento_cargado']/node()"/>!</span></div>
          </td>
        </tr>
      </form>
      </table><!--fin de tabla doc-->
    </xsl:if><!--fin if si es mvm-->


	<form name="frmDocumentos">
		<xsl:for-each select="/Docs/CENTRO/DOCUMENTOS">
			<xsl:if test="/Docs/CENTRO/DOCUMENTOS/DOCUMENTO">
				<xsl:call-template name="tabla_documentos">
					<xsl:with-param name="path" select="."/>
					<xsl:with-param name="doc" select="$doc"/>
					<xsl:with-param name="titulo" select="NOMBRE_CORTO"/>
				</xsl:call-template>
    		</xsl:if>
		</xsl:for-each>
		<!--
		<xsl:if test="/Docs/CENTRO/DOCUMENTOS/DOCUMENTOS_OBLIGATORIOS">
			<xsl:call-template name="tabla_documentos">
				<xsl:with-param name="path" select="/Docs/CENTRO/DOCUMENTOS/DOCUMENTOS_OBLIGATORIOS"/>
				<xsl:with-param name="doc" select="$doc"/>
				<xsl:with-param name="titulo" select="document($doc)/translation/texts/item[@name='Documentos_obligatorios']/node()"/>
			</xsl:call-template>
    	</xsl:if>
		<xsl:if test="/Docs/CENTRO/DOCUMENTOS/DOCUMENTOS_OPCIONALES">
			<xsl:call-template name="tabla_documentos">
				<xsl:with-param name="path" select="/Docs/CENTRO/DOCUMENTOS/DOCUMENTOS_OPCIONALES"/>
				<xsl:with-param name="doc" select="$doc"/>
				<xsl:with-param name="titulo" select="document($doc)/translation/texts/item[@name='Documentos_opcionales']/node()"/>
			</xsl:call-template>
    	</xsl:if>
		<xsl:if test="/Docs/CENTRO/DOCUMENTOS[@tipo='DOC_INTERNO']">
			<xsl:call-template name="tabla_documentos">
				<xsl:with-param name="path" select="/Docs/CENTRO/DOCUMENTOS[@tipo='DOC_INTERNO']"/>
				<xsl:with-param name="doc" select="$doc"/>
				<xsl:with-param name="titulo" select="document($doc)/translation/texts/item[@name='Documentos_internos']/node()"/>
			</xsl:call-template>
    	</xsl:if>
		-->
    </form>
	
	<!--mensajes js -->
	<form name="mensajeJS">
	<input type="hidden" name="SEGURO_ELIMINAR_OFERTA" value="{document($doc)/translation/texts/item[@name='seguro_eliminar_oferta']/node()}"/>
	<input type="hidden" name="SEGURO_ELIMINAR_OFERTA_ANE" value="{document($doc)/translation/texts/item[@name='seguro_eliminar_anexo']/node()}"/>
	<input type="hidden" name="SEGURO_ELIMINAR_FICHA" value="{document($doc)/translation/texts/item[@name='seguro_eliminar_ficha']/node()}"/>
	<input type="hidden" name="SEGURO_ASOCIAR_OFERTA" value="{document($doc)/translation/texts/item[@name='seguro_asociar_oferta']/node()}"/>
	<input type="hidden" name="SEGURO_MODIFICAR_FECHA" value="{document($doc)/translation/texts/item[@name='seguro_modificar_fecha']/node()}"/>
	<!--carga documentos-->
	<input type="hidden" name="ERROR_SIN_DEFINIR" value="{document($doc)/translation/texts/item[@name='error_sin_definir']/node()}"/>
	<input type="hidden" name="HEMOS_ESPERADO" value="{document($doc)/translation/texts/item[@name='hemos_esperado']/node()}"/>
	<input type="hidden" name="LA_CARGA_NO_TERMINO" value="{document($doc)/translation/texts/item[@name='la_carga_no_termino']/node()}"/>
	<input type="hidden" name="CARGANDO_IMAGEN" value="{document($doc)/translation/texts/item[@name='cargando_imagen']/node()}"/>
	<input type="hidden" name="FICHA_OBLIGATORIA" value="{document($doc)/translation/texts/item[@name='ficha_obligatoria']/node()}"/>
	<input type="hidden" name="TIPO_OBLIGATORIO" value="{document($doc)/translation/texts/item[@name='tipo_obli_documento']/node()}"/>
	</form>
	<!--fin de mensajes js -->

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
				<input id="inputFileDoc" name="inputFileDoc" type="file" onChange="addDocFile();" />
			</div>
		</div>
	</xsl:when>
	</xsl:choose>
</xsl:template>
<!--fin de documentos-->




<xsl:template name="tabla_documentos">
   <xsl:param name="path" />
   <xsl:param name="doc" />
   <xsl:param name="titulo" />
    <xsl:if test="$path/DOCUMENTO">
	<table class="buscador documentos">
        <input type="hidden" name="ID_EMPRESA" value="{/Docs/CENTRO/EMP_ID}"/> 
			<tr class="sinLinea"><td colspan="10">&nbsp;</td></tr>
			<tr class="subTituloTabla"><td colspan="10"><strong><xsl:value-of select="$titulo"/></strong></td></tr>
          	<!--<tr>
            <td>&nbsp;</td>
			     	<td colspan="8" align="center">
            	  <strong>
					<xsl:value-of select="NOMBRE_CORTO"/>
            	  </strong>
            	  <div id="waitBoxOferta_{ID}" class="gris" style="display:none; margin-top:5px;">
                	<xsl:value-of select="document($doc)/translation/texts/item[@name='cargando']/node()"/>...&nbsp;
            	  </div>
            	  <div id="confirmBoxAsociaOferta_{ID}" class="gris" style="display:none; margin-top:5px;">
                	<span class="rojo"><xsl:value-of select="document($doc)/translation/texts/item[@name='oferta_asociada_a_todos']/node()"/></span>
            	  </div>
            	  <div id="confirmBoxEliminaOferta_{ID}" class="gris" style="display:none; margin-top:5px;">
                	<span class="rojo"><xsl:value-of select="document($doc)/translation/texts/item[@name='oferta_eliminada']/node()"/>.</span>
            	  </div>
            	  <div id="confirmBoxModificaFecha_{ID}" class="gris" style="display:none; margin-top:5px;">
                	<span class="rojo"><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_oferta_actualizada']/node()"/>.</span>
            	  </div>
            	</td>
			</tr>
			-->
		  <!--nombres columnas-->
		  <tr class="subTituloTabla">
			<td class="uno">&nbsp;</td>
			<td><xsl:value-of select="document($doc)/translation/texts/item[@name='nombre']/node()"/></td>
			<!--<td class="diez"><xsl:value-of select="document($doc)/translation/texts/item[@name='descarga']/node()"/></td>-->

			<xsl:choose>
			<xsl:when test="//BORRAROFERTAS and TIPO != 'LEGAL' and TIPO != 'FICHAS_TECNICAS' and TIPO != 'LOGOS'">
			<td><xsl:value-of select="document($doc)/translation/texts/item[@name='asociar_a_todos']/node()"/></td>
			</xsl:when>
			<xsl:otherwise>
			<td>&nbsp;</td>
			</xsl:otherwise>
			</xsl:choose>

            <td><xsl:value-of select="document($doc)/translation/texts/item[@name='usuario']/node()"/></td>
            <td style="width:200px;"><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha']/node()"/></td>
            <td style="width:220px;"><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_final']/node()"/></td>
            <td class="diez"><xsl:value-of select="document($doc)/translation/texts/item[@name='Usuario_revision']/node()"/></td>
            <td style="width:150px;"><xsl:value-of select="document($doc)/translation/texts/item[@name='Fecha_revision']/node()"/></td>

			<td class="uno"><xsl:value-of select="document($doc)/translation/texts/item[@name='revisar']/node()"/></td>
			<xsl:choose>
			<xsl:when test="//BORRAROFERTAS">
				<td class="uno"><xsl:value-of select="document($doc)/translation/texts/item[@name='eliminar']/node()"/></td>
			</xsl:when>
			<xsl:otherwise>
				<td class="uno">&nbsp;</td>
			</xsl:otherwise>
        	</xsl:choose>
        </tr>

   	<xsl:for-each select="$path/DOCUMENTO">
		<input type="hidden" id="st_{ID}" value="{COLOR}"/> 
		<xsl:choose>
		<xsl:when test="NO_INFORMADO">
			<!--	Si un documento obligatorio no está informado, lo indicamos		-->
			<tr>
				<td>
					<xsl:attribute name="style">background:#CC0000;</xsl:attribute>
					<xsl:value-of select="CONTADOR"/>
				</td>
				<td class="textLeft">
					<xsl:value-of select="NOMBRETIPO"/>:&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Documento_obligatorio_no_informado']/node()"/>
				</td>
				<td colspan="6">
					&nbsp;
				</td>
			</tr>
		</xsl:when>
		<xsl:otherwise>
			<tr>
				<td id="doc_{ID}">
					<xsl:choose>
    	  			<xsl:when test="COLOR='VERDE'">
						<xsl:attribute name="style">background:#4E9A06;</xsl:attribute>
					</xsl:when>
    	  			<xsl:when test="COLOR='NARANJA'">
						<xsl:attribute name="style">background:#F57900;</xsl:attribute>
					</xsl:when>
					<xsl:otherwise>
						<xsl:attribute name="style">background:#CC0000;</xsl:attribute>
					</xsl:otherwise>
    	 			</xsl:choose>
					<xsl:value-of select="CONTADOR"/>
				</td>
				<td class="textLeft"><!--<xsl:if test="DOCUMENTOHIJO"><span class="rojo amarillo">|&nbsp;</span></xsl:if>-->
					&nbsp;<a>
						<xsl:attribute name="href">http://www.newco.dev.br/Documentos/<xsl:value-of select="URL"/></xsl:attribute>
						<!--<xsl:if test="../TIPO = 'LEGAL'">-->
						<xsl:value-of select="NOMBRETIPO"/>:&nbsp;
						<!--</xsl:if>-->
						<xsl:value-of select="NOMBRE"/><!--&nbsp;( .<xsl:value-of select="substring-after(URL,'.')"/> )-->
					</a>
				</td>
				<!--
				<td>
					<a>
						<xsl:attribute name="href">http://www.newco.dev.br/Documentos/<xsl:value-of select="URL"/></xsl:attribute>
						<img src="http://www.newco.dev.br/images/descarga.gif" alt="Descarga"/>
					</a>
				</td>-->
				<td>
    		  <xsl:choose>
    		  <xsl:when test="//BORRAROFERTAS and not(/Docs/CENTRO/OBSERVADOR) and TIPO = 'DOCUMENTOS_COMERCIALES_PROV'">
					<a>
						<xsl:attribute name="href">javascript:AsociarDocComeTodos('<xsl:value-of select="ID"/>','<xsl:value-of select="TIPO"/>','<xsl:value-of select="NOMBRE"/>');</xsl:attribute>
						<img src="http://www.newco.dev.br/images/asociar.gif" alt="Asociar a todos los productos"/>
					</a>
				</xsl:when>
				<xsl:when test="//BORRAROFERTAS and not(/Docs/CENTRO/OBSERVADOR) and TIPO != 'LEGAL' and TIPO != 'FICHAS_TECNICAS' and TIPO != 'ANEXOS' and TIPO != 'LOGOS'">
					<a>
						<xsl:attribute name="href">javascript:AsociarOfertaTodos('<xsl:value-of select="ID"/>','<xsl:value-of select="TIPO"/>','<xsl:value-of select="NOMBRE"/>');</xsl:attribute>
						<img src="http://www.newco.dev.br/images/asociar.gif" alt="Asociar a todos los productos"/>
					</a>
				</xsl:when>
    		  </xsl:choose>
			</td>
			<td align="left"><xsl:value-of select="USUARIO"/></td>
			<td align="left">
				<xsl:choose>
				<xsl:when test="((/Docs/CENTRO/MVM or /Docs/CENTRO/MVMB or /Docs/CENTRO/ADMIN or /Docs/CENTRO/CDC) and not(/Docs/CENTRO/OBSERVADOR))">
					<input type="text" name="fecha_{ID}" value="{FECHA}" maxlength="10" size="10" class="medio" id="fecha_{ID}"/>
					<img id="btFecha_{ID}" src="http://www.newco.dev.br/images/actualizarFlecha.gif" alt="Actualizar Fecha" onmouseover="style.cursor='pointer'" onclick="javascript:ActualizarFechaOferta('{ID}','{/Docs/CENTRO/EMP_ID}','{TIPO}','{NOMBRE}');"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="FECHA"/>
				</xsl:otherwise>
				</xsl:choose>
			</td>
    		<td align="left">
				<xsl:choose>
				<xsl:when test="((/Docs/CENTRO/MVM or /Docs/CENTRO/MVMB or /Docs/CENTRO/ADMIN or /Docs/CENTRO/CDC) and not(/Docs/CENTRO/OBSERVADOR))">
					<input type="text" name="fechaFinal_{ID}" value="{FECHACADUCIDAD}" maxlength="10" size="10" class="medio" id="fechaFinal_{ID}"/>
					<img id="btFechaFinal_{ID}" src="http://www.newco.dev.br/images/actualizarFlecha.gif" alt="Actualizar Fecha final" onmouseover="style.cursor='pointer'" onclick="javascript:ActualizarFechaOferta('{ID}','{/Docs/CENTRO/EMP_ID}','{TIPO}','{NOMBRE}');"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="FECHACADUCIDAD"/>
				</xsl:otherwise>
				</xsl:choose>
				&nbsp;
				<xsl:if test="CADUCADO">
					<img src="http://www.newco.dev.br/images/2017/warning-red.png"/>
				</xsl:if>
			</td>
			<xsl:choose>
			<xsl:when test="REVISADO='S'">
				<td><xsl:value-of select="USUARIO_REVISION"/></td>
				<td><xsl:value-of select="FECHAREVISION"/></td>
			</xsl:when>
			<xsl:otherwise>
				<td>-</td>
				<td>-</td>
			</xsl:otherwise>
			</xsl:choose>
			<td>
				<xsl:if test="/Docs/CENTRO/REVISAR_DOCUMENTOS">
					<a id="btnEstado_{ID}" class="btnDestacado" href="javascript:revisarDocumento({ID});">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='Revisar']/node()"/>
					</a>
					<div id="waitBoxEst_{ID}" class="gris" style="display:none; margin-top:5px;">
                		<xsl:value-of select="document($doc)/translation/texts/item[@name='cargando']/node()"/>...&nbsp;
            		</div>
				</xsl:if>
			</td>
			<td>
				<!--<xsl:if test="((/Docs/CENTRO/BORRAROFERTAS) or (/Docs/CENTRO/BORRARDOCUMENTOS)) and not(/Docs/CENTRO/OBSERVADOR)">-->
				<xsl:if test="((/Docs/CENTRO/MVM or /Docs/CENTRO/MVMB or /Docs/CENTRO/ADMIN or /Docs/CENTRO/CDC) and not(/Docs/CENTRO/OBSERVADOR))">
					<a>
						<xsl:attribute name="href">javascript:EliminarDocumento('<xsl:value-of select="ID"/>','<xsl:value-of select="TIPO"/>','<xsl:value-of select="NOMBRE"/>');</xsl:attribute>
						<img src="http://www.newco.dev.br/images/2017/trash.png" alt="eliminar"/>
					</a>
					<div id="waitBoxOferta_{ID}" class="gris" style="display:none; margin-top:5px;">
                		<xsl:value-of select="document($doc)/translation/texts/item[@name='cargando']/node()"/>...&nbsp;
            		</div>
				</xsl:if>
			</td>
			</tr>

			  <xsl:if test="DOCUMENTOHIJO">
    			<tr>
    			  <td></td>
    			  <td><span class="rojo amarillo">|&nbsp;<xsl:value-of select="DOCUMENTOHIJO/TIPO"/></span>&nbsp;<xsl:value-of select="DOCUMENTOHIJO/NOMBRE"/></td>
    			  <td>
        			<a>
						<xsl:attribute name="href">http://www.newco.dev.br/Documentos/<xsl:value-of select="DOCUMENTOHIJO/URL"/></xsl:attribute>
						<img src="http://www.newco.dev.br/images/descarga.gif" alt="Descarga"/>
        			</a>
    			  </td>
    			  <td>&nbsp;</td>
    			  <td><xsl:value-of select="DOCUMENTOHIJO/FECHA"/></td>
    			</tr>
		  	</xsl:if>
		</xsl:otherwise>
   		</xsl:choose>
		</xsl:for-each>
	</table>
	</xsl:if>
		<!--mensajes js -->
		<form name="MensajeJS">
			<input type="hidden" name="SEGURO_ELIMINAR_OFERTA" value="{document($doc)/translation/texts/item[@name='seguro_eliminar_oferta']/node()}"/>
			<input type="hidden" name="SEGURO_ELIMINAR_OFERTA_ANE" value="{document($doc)/translation/texts/item[@name='seguro_eliminar_anexo']/node()}"/>
			<input type="hidden" name="SEGURO_ELIMINAR_FICHA" value="{document($doc)/translation/texts/item[@name='seguro_eliminar_ficha']/node()}"/>
			<input type="hidden" name="SEGURO_ASOCIAR_OFERTA" value="{document($doc)/translation/texts/item[@name='seguro_asociar_oferta']/node()}"/>
			<input type="hidden" name="SEGURO_MODIFICAR_FECHA" value="{document($doc)/translation/texts/item[@name='seguro_modificar_fecha']/node()}"/>
			<!--carga documentos-->
			<input type="hidden" name="ERROR_SIN_DEFINIR" value="{document($doc)/translation/texts/item[@name='error_sin_definir']/node()}"/>
			<input type="hidden" name="HEMOS_ESPERADO" value="{document($doc)/translation/texts/item[@name='hemos_esperado']/node()}"/>
			<input type="hidden" name="LA_CARGA_NO_TERMINO" value="{document($doc)/translation/texts/item[@name='la_carga_no_termino']/node()}"/>
			<input type="hidden" name="CARGANDO_IMAGEN" value="{document($doc)/translation/texts/item[@name='cargando_imagen']/node()}"/>
			<input type="hidden" name="FICHA_OBLIGATORIA" value="{document($doc)/translation/texts/item[@name='ficha_obligatoria']/node()}"/>
			<input type="hidden" name="TIPO_OBLIGATORIO" value="{document($doc)/translation/texts/item[@name='Tipo_doc_obligatorio']/node()}"/>
		</form>
		<!--fin de mensajes js -->
</xsl:template>		









</xsl:stylesheet>
