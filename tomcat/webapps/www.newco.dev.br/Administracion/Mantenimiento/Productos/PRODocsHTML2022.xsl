<?xml version="1.0" encoding="iso-8859-1"?>
<!--
    Mostrar documentos de producto. Creado a partir de EMPDocs. Nuevo disenno 2022.
 	ultima revision: ET 9mar22 17:00 PRODocs2022_090322.js
 +-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:import href="http://www.newco.dev.br/General/General.xsl"/>
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="lang" select="@lang"/>
<xsl:template match="/Docs">

<!--	Todos los documentos HTML deben empezar con esto	-->
<xsl:text disable-output-escaping='yes'>&lt;!doctype html></xsl:text>

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

	<meta http-equiv="Cache-Control" Content="no-cache"/>
	
	<title><xsl:value-of select="/Docs/PRODUCTO/PRO_REFERENCIA"/>:&nbsp;<xsl:value-of select="/Docs/PRODUCTO/PRO_NOMBRE" disable-output-escaping="yes"/>:&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='documentos']/node()"/></title>

	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->

	<!--	11ene22 nuevos estilos -->
	<!--<link rel="stylesheet" href="http://www.newco.dev.br/General/basicMVM2022.css"/>-->
	<link href='http://fonts.googleapis.com/css?family=Roboto' rel='stylesheet'/>
	<!--	11ene22 nuevos estilos -->

	<script src="http://www.newco.dev.br/General/jquery-3.6.0.js"></script>	
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic2022_010822.js"></script>
	<!--<script type="text/javascript" src="http://www.newco.dev.br/General/jquery-1.8.3.min.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>-->
	<script type="text/javascript" src="http://www.newco.dev.br/Administracion/Mantenimiento/Productos/PRODocs2022_090322.js"></script>
	<script type="text/javascript">
		var strDocumentoBorrado='<xsl:value-of select="document($doc)/translation/texts/item[@name='Documento_borrado']/node()"/>';
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

	<div class="ZonaTituloPagina">
		<!--<p class="Path">&nbsp;</p>-->
		<p class="TituloPagina">
			<xsl:value-of select="EMP_NOMBRE" disable-output-escaping="yes"/>:&nbsp;<xsl:value-of select="PRO_REFERENCIA" disable-output-escaping="yes"/>&nbsp;<xsl:value-of select="PRO_NOMBRE" disable-output-escaping="yes"/>
			<xsl:if test="(/Docs/PRODUCTO/ROL='VENDEDOR' and /Docs/PRODUCTO/PRO_STATUS='M')">
				&nbsp;<span class="urgente"><xsl:value-of select="document($doc)/translation/texts/item[@name='solicitud_cambio_producto']/node()"/></span>&nbsp;
			</xsl:if>
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


	<!--	Pestañas y Titulo de la página		-->
	<xsl:if test="MOSTRARPESTANNAS">
 	<div class="divLeft marginTop20">
		<ul class="pestannas w100" style="position:relative;">
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
			<li>
				<a id="pes_Empaquetamiento" class="MenuLic"><xsl:value-of select="document($doc)/translation/texts/item[@name='empaquetamientos']/node()"/></a>
			</li>
		</ul>
	</div>
	</xsl:if>


	<div class="divLeft marginTop20">
	<form name="SubirDocumentos" method="post">
    <input type="hidden" name="IDPROVEEDOR" id="IDPROVEEDOR" value="{/Docs/PRODUCTO/EMP_ID}"/>
    <input type="hidden" name="IDPRODUCTO" id="IDPRODUCTO" value="{/Docs/PRODUCTO/PRO_ID}"/>
    <input type="hidden" name="CADENA_DOCUMENTOS" />
    <input type="hidden" name="DOCUMENTOS_BORRADOS" />
    <input type="hidden" name="BORRAR_ANTERIORES" />
    <input type="hidden" name="REMOVE" value="{document($doc)/translation/texts/item[@name='remove']/node()}"/>
    <xsl:if test="/Docs/PRODUCTO/SUBIR_DOCUMENTOS">
		<!--tabla imagenes y documentos-->
		<table >
        <tr class="sinLinea">
          <!--documentos-->
          <td class="w50px">&nbsp;</td>
          <td class="labelRight w160px">
            	<span class="text"><xsl:value-of select="document($doc)/translation/texts/item[@name='subir_documento']/node()"/>:&nbsp;</span>
          </td>
          <td class="datosLeft">
            <div class="altaDocumento">
              <span class="anadirDoc">
                <xsl:call-template name="documentos"><xsl:with-param name="num" select="number(1)"/></xsl:call-template>
              </span>
            </div>
          </td>
          <td class="datosLeft w200px">
            <select name="TIPO_DOC" id="TIPO_DOC" class="grande">
            <xsl:for-each select="/Docs/PRODUCTO/TIPOS_DOCUMENTOS/field/dropDownList/listElem">
              <option value="{ID}"><xsl:value-of select="listItem"/></option>
            </xsl:for-each>
            </select>
          </td>
          <td class="w200px">
            <!--<div class="boton">-->
          	<a class="btnDestacado" href="javascript:cargaDoc(document.forms['SubirDocumentos']);">
             	<xsl:value-of select="document($doc)/translation/texts/item[@name='subir_documento']/node()"/>
          	</a>
          </td>
          <td class="w100px">
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
	<div class="divLeft textCenter space40px">
	<span class="tituloTabla"><xsl:value-of select="$titulo"/></span>
	<div class="tabela tabela_redonda">
	<table cellspacing="6px" cellpadding="6px">
		<thead class="cabecalho_tabela">
        <input type="hidden" name="ID_EMPRESA" value="{/Docs/PRODUCTO/EMP_ID}"/> 
		  <!--nombres columnas-->
		  <tr>
			<th class="w1px">&nbsp;</th>
			<th><xsl:value-of select="document($doc)/translation/texts/item[@name='nombre']/node()"/></th>
			<xsl:choose>
			<xsl:when test="//BORRAROFERTAS and TIPO != 'LEGAL' and TIPO != 'FICHAS_TECNICAS' and TIPO != 'LOGOS'">
				<th class="w80px"><xsl:value-of select="document($doc)/translation/texts/item[@name='asociar_a_todos']/node()"/></th>
			</xsl:when>
			<xsl:otherwise>
				<th class="w80px">&nbsp;</th>
			</xsl:otherwise>
			</xsl:choose>

            <th class="w200px"><xsl:value-of select="document($doc)/translation/texts/item[@name='usuario']/node()"/></th>
            <th class="w150px"><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha']/node()"/></th>
            <th class="w150px"><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_final']/node()"/></th>
            <th class="w200px"><xsl:value-of select="document($doc)/translation/texts/item[@name='Usuario_revision']/node()"/></th>
            <th class="w80px"><xsl:value-of select="document($doc)/translation/texts/item[@name='Fecha_revision']/node()"/></th>

			<th class="w1px"><xsl:value-of select="document($doc)/translation/texts/item[@name='revisar']/node()"/></th>
			<xsl:choose>
			<xsl:when test="//BORRAROFERTAS">
				<th class="w1px"><xsl:value-of select="document($doc)/translation/texts/item[@name='eliminar']/node()"/></th>
			</xsl:when>
			<xsl:otherwise>
				<th class="w1px">&nbsp;</th>
			</xsl:otherwise>
        	</xsl:choose>
			<th class="w5px">&nbsp;</th>
        </tr>
		</thead>
		<tbody class="corpo_tabela">
   		<xsl:for-each select="$path/DOCUMENTO">
			<input type="hidden" id="st_{ID}" value="{COLOR}"/> 
			<xsl:choose>
			<xsl:when test="NO_INFORMADO">
				<!--	Si un documento obligatorio no está informado, lo indicamos		-->
				<tr class="">
					<td>
						<xsl:attribute name="style">background:#CC0000;</xsl:attribute>
						<xsl:value-of select="CONTADOR"/>
					</td>
					<td class="textLeft">
						<xsl:value-of select="NOMBRETIPO"/>:&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Documento_obligatorio_no_informado']/node()"/>
					</td>
					<td colspan="9">
						&nbsp;
					</td>
				</tr>
			</xsl:when>
			<xsl:otherwise>
				<tr class="con_hover">
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
					<td class="textLeft"><xsl:value-of select="USUARIO"/></td>
					<td class="textLeft valignM">
						<xsl:choose>
						<xsl:when test="((/Docs/PRODUCTO/MVM or /Docs/PRODUCTO/ADMIN) and not(/Docs/PRODUCTO/OBSERVADOR))">
							<input type="text" class="campopesquisa w100px" name="fecha_{ID}" value="{FECHA}" maxlength="10" id="fechaI_{ID}"/>
							<!--<img src="http://www.newco.dev.br/images/actualizarFlecha.gif" alt="Actualizar Fecha" onmouseover="style.cursor='pointer'" onclick="javascript:ActualizarFechaOferta('{ID}','{TIPO}','{NOMBRE}','I');"/>-->
							&nbsp;<img src="http://www.newco.dev.br/images/2022/refresh-button.png" class="valignM" onclick="javascript:ActualizarFechaOferta('{ID}','{TIPO}','{NOMBRE}','I');"/>
							<img id="waitBoxFechaI_{ID}" style="display:none;" src="http://www.newco.dev.br/images/loading.gif"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="FECHA"/>
						</xsl:otherwise>
						</xsl:choose>
					</td>
    				<td class="textLeft valignM">
						<xsl:choose>
						<xsl:when test="((/Docs/PRODUCTO/MVM or /Docs/PRODUCTO/ADMIN) and not(/Docs/PRODUCTO/OBSERVADOR))">
							<input type="text" class="campopesquisa w100px" name="fechaFinal_{ID}" value="{FECHACADUCIDAD}" maxlength="10" id="fechaF_{ID}"/>
							<!--<img src="http://www.newco.dev.br/images/actualizarFlecha.gif" alt="Actualizar Fecha final" onmouseover="style.cursor='pointer'" onclick="javascript:ActualizarFechaOferta('{ID}','{TIPO}','{NOMBRE}','F');"/>-->
							&nbsp;<img src="http://www.newco.dev.br/images/2022/refresh-button.png" class="valignM" onclick="javascript:ActualizarFechaOferta('{ID}','{TIPO}','{NOMBRE}','F');"/>
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
							<a id="btnBorrar">
								<xsl:attribute name="href">javascript:EliminarDocumento('<xsl:value-of select="ID"/>','<xsl:value-of select="TIPO"/>','<xsl:value-of select="NOMBRE_CORTO"/>');</xsl:attribute>
								<img src="http://www.newco.dev.br/images/2017/trash.png"/>
							</a>
							<div id="waitBoxOferta_{ID}" class="gris" style="display:none;"><img src="http://www.newco.dev.br/images/loading.gif"/></div>
						</xsl:if>
					</td>
					<td>&nbsp;</td>
				</tr>
			</xsl:otherwise>
   			</xsl:choose>
		</xsl:for-each>
		</tbody>
		<tfoot class="rodape_tabela">
			<tr><td colspan="12">&nbsp;</td></tr>
		</tfoot>
	</table>
	</div>
	</div>
	</xsl:if>
</xsl:template>		

<!--fin de documentos-->
</xsl:stylesheet>
