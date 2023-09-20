<?xml version="1.0" encoding="iso-8859-1"?>
<!--
    Mostrar documentos de producto. Creado a partir de EMPDocs.
 	ultima revision: ET 4nov20 15:30 PRODocs_041120.js
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
	
	<title><xsl:value-of select="/Docs/PRODUCTO/EMP_NOMBRE" disable-output-escaping="yes"/>:&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='documentos']/node()"/></title>

	<script type="text/javascript">
		var strDocumentoBorrado='<xsl:value-of select="document($doc)/translation/texts/item[@name='Documento_borrado']/node()"/>';
	</script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery-1.8.3.min.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/Administracion/Mantenimiento/Productos/PRODocs_041120.js"></script>
	<script type="text/javascript">
		strEliminarDoc="<xsl:value-of select="document($doc)/translation/texts/item[@name='seguro_eliminar_documento']/node()"/>";
		strModificarFecha="<xsl:value-of select="document($doc)/translation/texts/item[@name='seguro_modificar_fecha']/node()"/>";
		//	carga documentos
		strErrorSinDefinir="<xsl:value-of select="document($doc)/translation/texts/item[@name='error_sin_definir']/node()"/>";
		strHemosEsperado="<xsl:value-of select="document($doc)/translation/texts/item[@name='hemos_esperado']/node()"/>";
		strCargaNoTermino="<xsl:value-of select="document($doc)/translation/texts/item[@name='la_carga_no_termino']/node()"/>";
		strTipoObligatorio="<xsl:value-of select="document($doc)/translation/texts/item[@name='Tipo_doc_obligatorio']/node()"/>";
	</script>
</head>

<body onload="javascript:onloadEvents();">
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
			<xsl:apply-templates select="PRODUCTO"/>
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

<xsl:template match="PRODUCTO">
	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:choose>
		<xsl:when test="/Docs/LANG"><xsl:value-of select="/Docs/LANG"/></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->


	<!--	Pestañas y Titulo de la página		-->
	<xsl:if test="MOSTRARPESTANNAS">
 	<div class="divLeft" style="background-color:white;">
		<ul class="pestannas" style="position:relative;width:600px;">
			<li>
				<a id="pes_Ficha" class="MenuLic"><xsl:value-of select="document($doc)/translation/texts/item[@name='Ficha_de_producto']/node()"/></a>
			</li>
			<li>
				<a id="pes_Tarifas" class="MenuLic"><xsl:value-of select="document($doc)/translation/texts/item[@name='tarifas']/node()"/></a>
			</li>
			<li>
				<a id="pes_Documentos" class="MenuLic"><xsl:value-of select="document($doc)/translation/texts/item[@name='documentos']/node()"/></a>
			</li>
			<li>
				<a id="pes_Pack" class="MenuLic"><xsl:value-of select="document($doc)/translation/texts/item[@name='Contenido_pack']/node()"/></a>
			</li>
		</ul>
	</div>
	</xsl:if>

	<div class="ZonaTituloPagina">
		<p class="Path"><xsl:value-of select="document($doc)/translation/texts/item[@name='Inicio']/node()"/>&nbsp;/&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/>&nbsp;/<span class="FinPath"><xsl:value-of select="document($doc)/translation/texts/item[@name='documentos']/node()"/>&nbsp;</span>
			<xsl:if test="MVM or MVMB or ADMIN">
				<span class="CompletarTitulo">
					<span class="amarillo">EMP_ID:&nbsp;<xsl:value-of select="EMP_ID"/></span>
				</span>
			</xsl:if>
		</p>
		<p class="TituloPagina">
			<xsl:value-of select="EMP_NOMBRE" disable-output-escaping="yes"/>:&nbsp;<xsl:value-of select="PRO_NOMBRE" disable-output-escaping="yes"/>
			<span class="CompletarTitulo">
			<xsl:if test="/Docs/PRODUCTO/MVM or /Docs/PRODUCTO/MVMB">
				<a class="btnNormal" href="javascript:window.print();" style="text-decoration:none;" title="Imprimir">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='imprimir']/node()"/>
				</a>
			</xsl:if>
			</span>
		</p>
	</div>
	<br/>


	<div class="divLeft">
  <form name="SubirDocumentos" method="post">
    <input type="hidden" name="IDPROVEEDOR" id="IDPROVEEDOR" value="{/Docs/PRODUCTO/EMP_ID}"/>
    <input type="hidden" name="IDPRODUCTO" id="IDPRODUCTO" value="{/Docs/PRODUCTO/PRO_ID}"/>
    <input type="hidden" name="CADENA_DOCUMENTOS" />
    <input type="hidden" name="DOCUMENTOS_BORRADOS" />
    <input type="hidden" name="BORRAR_ANTERIORES" />
    <input type="hidden" name="REMOVE" value="{document($doc)/translation/texts/item[@name='remove']/node()}"/>
    <xsl:if test="/Docs/PRODUCTO/SUBIR_DOCUMENTOS">
		<!--tabla imagenes y documentos-->
      <table class="buscador documentos" border="0">

        <tr class="sinLinea">
          <!--documentos-->
          <td class="quince">&nbsp;</td>
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
            <xsl:for-each select="/Docs/PRODUCTO/TIPOS_DOCUMENTOS/field/dropDownList/listElem">
              <option value="{ID}"><xsl:value-of select="listItem"/></option>
            </xsl:for-each>
            </select>
          </td>
          <td style="width:200px;">
            <!--<div class="boton">-->
          	<a class="btnDestacado" href="javascript:cargaDoc(document.forms['SubirDocumentos']);">
             	<xsl:value-of select="document($doc)/translation/texts/item[@name='subir_documento']/node()"/>
          	</a>
          </td>
          <td style="width:100px;">
		  		<div id="waitBoxDoc" align="center">&nbsp;</div>
          </td>
          <td>
  		  		<div id="confirmBoxDocEmpresa" align="center" style="display:none;"><span class="cargado">¡<xsl:value-of select="document($doc)/translation/texts/item[@name='documento_cargado']/node()"/>!</span></div>
          </td>
        </tr>
      </table><!--fin de tabla doc-->
    </xsl:if><!--fin if si es mvm-->
    </form>
	<br/>
	<br/>

		<form name="frmDocumentos">
			<xsl:if test="/Docs/PRODUCTO/DOCUMENTOS_OBLIGATORIOS">
				<xsl:call-template name="tabla_documentos">
					<xsl:with-param name="path" select="/Docs/PRODUCTO/DOCUMENTOS_OBLIGATORIOS"/>
					<xsl:with-param name="doc" select="$doc"/>
					<xsl:with-param name="titulo" select="document($doc)/translation/texts/item[@name='Documentos_obligatorios']/node()"/>
				</xsl:call-template>
    		</xsl:if>
			<xsl:if test="/Docs/PRODUCTO/DOCUMENTOS_OPCIONALES">
				<xsl:call-template name="tabla_documentos">
					<xsl:with-param name="path" select="/Docs/PRODUCTO/DOCUMENTOS_OPCIONALES"/>
					<xsl:with-param name="doc" select="$doc"/>
					<xsl:with-param name="titulo" select="document($doc)/translation/texts/item[@name='Documentos_opcionales']/node()"/>
				</xsl:call-template>
    		</xsl:if>
    	</form>

		<!--mensajes js 
		<form name="MensajeJS">
			<input type="hidden" name="SEGURO_ELIMINAR_DOC" value="{document($doc)/translation/texts/item[@name='seguro_eliminar_documento']/node()}"/>
			<input type="hidden" name="SEGURO_MODIFICAR_FECHA" value="{document($doc)/translation/texts/item[@name='seguro_modificar_fecha']/node()}"/>
			<!- -carga documentos- ->
			<input type="hidden" name="ERROR_SIN_DEFINIR" value="{document($doc)/translation/texts/item[@name='error_sin_definir']/node()}"/>
			<input type="hidden" name="HEMOS_ESPERADO" value="{document($doc)/translation/texts/item[@name='hemos_esperado']/node()}"/>
			<input type="hidden" name="LA_CARGA_NO_TERMINO" value="{document($doc)/translation/texts/item[@name='la_carga_no_termino']/node()}"/>
			<input type="hidden" name="CARGANDO_IMAGEN" value="{document($doc)/translation/texts/item[@name='cargando_imagen']/node()}"/>
			<input type="hidden" name="FICHA_OBLIGATORIA" value="{document($doc)/translation/texts/item[@name='ficha_obligatoria']/node()}"/>
			<input type="hidden" name="TIPO_OBLIGATORIO" value="{document($doc)/translation/texts/item[@name='Tipo_doc_obligatorio']/node()}"/>
		</form>
		fin de mensajes js -->
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
        <input type="hidden" name="ID_EMPRESA" value="{/Docs/PRODUCTO/EMP_ID}"/> 
			<tr class="sinLinea"><td colspan="10">&nbsp;</td></tr>
			<tr class="subTituloTabla"><td colspan="10"><strong><xsl:value-of select="$titulo"/></strong></td></tr>
		  <!--nombres columnas-->
		  <tr class="subTituloTabla">
			<td class="uno">&nbsp;</td>
			<td class="cuarenta"><xsl:value-of select="document($doc)/translation/texts/item[@name='nombre']/node()"/></td>
			<!--<td class="diez"><xsl:value-of select="document($doc)/translation/texts/item[@name='descarga']/node()"/></td>-->

			<xsl:choose>
			<xsl:when test="//BORRAROFERTAS and TIPO != 'LEGAL' and TIPO != 'FICHAS_TECNICAS' and TIPO != 'LOGOS'">
			<td class="diez"><xsl:value-of select="document($doc)/translation/texts/item[@name='asociar_a_todos']/node()"/></td>
			</xsl:when>
			<xsl:otherwise>
			<td class="diez">&nbsp;</td>
			</xsl:otherwise>
			</xsl:choose>

            <td class="diez"><xsl:value-of select="document($doc)/translation/texts/item[@name='usuario']/node()"/></td>
            <td style="width:80px"><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha']/node()"/></td>
            <td style="width:80px"><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_final']/node()"/></td>
            <td class="diez"><xsl:value-of select="document($doc)/translation/texts/item[@name='Usuario_revision']/node()"/></td>
            <td class="cinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='Fecha_revision']/node()"/></td>

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
						<xsl:value-of select="NOMBRETIPO"/>:&nbsp;
						<xsl:value-of select="NOMBRE"/>
					</a>
				</td>
				<td>
				</td>
				<td align="left"><xsl:value-of select="USUARIO"/></td>
				<td align="left">
					<xsl:choose>
					<xsl:when test="((/Docs/PRODUCTO/MVM or /Docs/PRODUCTO/ADMIN) and not(/Docs/PRODUCTO/OBSERVADOR))">
						<input type="text" name="fecha_{ID}" value="{FECHA}" maxlength="10" size="10" class="medio" id="fechaI_{ID}"/>
						<img src="http://www.newco.dev.br/images/actualizarFlecha.gif" alt="Actualizar Fecha" onmouseover="style.cursor='pointer'" onclick="javascript:ActualizarFechaOferta('{ID}','{TIPO}','{NOMBRE}','I');"/>
						<!--<div id="waitBoxFechaI_{ID}" class="gris" style="display:none;"><img id="waitBoxFechaI_{ID}" style="display:none;" src="http://www.newco.dev.br/images/loading.gif"/></div>-->
						<img id="waitBoxFechaI_{ID}" style="display:none;" src="http://www.newco.dev.br/images/loading.gif"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="FECHA"/>
					</xsl:otherwise>
					</xsl:choose>
				</td>
    			<td align="left">
					<xsl:choose>
					<xsl:when test="((/Docs/PRODUCTO/MVM or /Docs/PRODUCTO/ADMIN) and not(/Docs/PRODUCTO/OBSERVADOR))">
						<input type="text" name="fechaFinal_{ID}" value="{FECHACADUCIDAD}" maxlength="10" size="10" class="medio" id="fechaF_{ID}"/>
						<img src="http://www.newco.dev.br/images/actualizarFlecha.gif" alt="Actualizar Fecha final" onmouseover="style.cursor='pointer'" onclick="javascript:ActualizarFechaOferta('{ID}','{TIPO}','{NOMBRE}','F');"/>
						<!--<div id="waitBoxFechaF_{ID}" class="gris" style="display:none;"><img id="waitBoxFechaF_{ID}" style="display:none;" src="http://www.newco.dev.br/images/loading.gif"/></div>-->
						<img id="waitBoxFechaF_{ID}" style="display:none;" src="http://www.newco.dev.br/images/loading.gif"/>
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
					<xsl:if test="/Docs/PRODUCTO/REVISAR_DOCUMENTOS">
						<a id="btnEstado_{ID}" class="btnDestacado" href="javascript:revisarDocumento({ID});">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='Revisar']/node()"/>
						</a>
						<div id="waitBoxEst_{ID}" class="gris" style="display:none; margin-top:5px;">
                			<xsl:value-of select="document($doc)/translation/texts/item[@name='cargando']/node()"/>...&nbsp;
            			</div>
					</xsl:if>
				</td>
				<td>
					<xsl:if test="(/Docs/PRODUCTO/BORRAR_DOCUMENTOS) and not(/Docs/PRODUCTO/OBSERVADOR)">
						<a id="btnBorrar" class="btnNormal rojo">
							<xsl:attribute name="href">javascript:EliminarDocumento('<xsl:value-of select="ID"/>','<xsl:value-of select="TIPO"/>','<xsl:value-of select="NOMBRE_CORTO"/>');</xsl:attribute>
							X<!--<img src="http://www.newco.dev.br/images/eliminarOferta.gif" alt="Eliminar"/>-->
						</a>
						<div id="waitBoxOferta_{ID}" class="gris" style="display:none;"><img src="http://www.newco.dev.br/images/loading.gif"/></div>
					</xsl:if>
				</td>
			</tr>
		</xsl:otherwise>
   		</xsl:choose>
		</xsl:for-each>
	</table>
	</xsl:if>
</xsl:template>		

<!--fin de documentos-->
</xsl:stylesheet>
