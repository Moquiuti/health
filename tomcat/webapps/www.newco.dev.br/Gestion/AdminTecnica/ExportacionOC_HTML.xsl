<?xml version="1.0" encoding="iso-8859-1"?>
<!--
 |	Gestión de los fichero de integración 
+-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:import href = "http://www.newco.dev.br/General/General.xsl"/>
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="lang" select="@lang"/>
<xsl:template match="/">

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

	<title><xsl:value-of select="document($doc)/translation/texts/item[@name='integracion']/node()"/></title>
	<xsl:call-template name="estiloIndip"/>
	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/Gestion/AdminTecnica/admintecnica_060913.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/Integracion/envioFicheroIntegracion.js"></script>
  <script type="text/javascript" src="http://www.newco.dev.br/Administracion/Mantenimiento/Productos/CargaDocumentos110614.js"></script>
  <script type="text/javascript" src="http://www.newco.dev.br/Compras/Multioferta/BuscaProd.js"></script>
  <script type="text/javascript" src="http://www.newco.dev.br/Administracion/Mantenimiento/Productos/proManten301115.js"></script>

  <!--style-->
  <xsl:call-template name="estiloIndip"/>
  <!--fin de style-->

</head>

<body>
	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:choose>
			<xsl:when test="/Administracion/LANG"><xsl:value-of select="/Administracion/LANG"/></xsl:when>
			<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

<xsl:choose>
<xsl:when test="/Administracion/ERROR">
	<h1 class="titlePage"><xsl:value-of select="document($doc)/translation/texts/item[@name='integracion']/node()"/></h1>
	<h2 class="titlePage"><xsl:value-of select="document($doc)/translation/texts/item[@name='no_tiene_derechos']/node()"/></h2>
</xsl:when>
<xsl:otherwise>
	<!-- Bloque de título -->
	<xsl:choose>
	<xsl:when test="/Administracion/INICIO/RESULTADO">
		<h1 class="titlePage"><!--<xsl:value-of select="document($doc)/translation/texts/item[@name='ficheros_de_integracion']/node()"/>:--><xsl:value-of select="/Administracion/INICIO/RESULTADO"/></h1>
	</xsl:when>
	<xsl:otherwise>
		<h1 class="titlePage"><xsl:value-of select="document($doc)/translation/texts/item[@name='integracion']/node()"/></h1>
	</xsl:otherwise>
	</xsl:choose>
  <!-- PS 13jul16 -->
  <!-- <xsl:for-each select="PRODUCTO/DATOS_CLIENTE"> -->
      <xsl:variable name="tipo"><xsl:value-of select="TIPO"/></xsl:variable>
      <xsl:variable name="nombre_corto"><xsl:value-of select="NOMBRE_CORTO"/></xsl:variable>
  <!-- Bloque de info para envío de ficheros de integración -->
  <a href="javascript:verCargaDoc('{$tipo}');" title="Subir documento" class="botonLink">
            <xsl:value-of select="document($doc)/translation/texts/item[@name='subir_ficheros']/node()"/>&nbsp;<xsl:value-of select="NOMBRE_CORTO"/>
          </a><xsl:text>&nbsp;&nbsp;</xsl:text>
	<!-- Bloque de info para los ficheros de integración -->
	<xsl:if test="/Administracion/INICIO/ACCION='INT_CONSULTA' or /Administracion/INICIO/ACCION='INT_EJECUTAR' or /Administracion/INICIO/ACCION='INT_OKMANUAL'">
		<xsl:choose>
		<xsl:when test="/Administracion/INICIO/INTEGRACION/FICHERO">
			<table align="center" class="encuesta">
			<thead>
				<tr class="titulos">
					<th align="center" class="cinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha']/node()"/></th>
					<th align="center" class="cinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='cliente']/node()"/></th>
					<th align="center" class="quince"><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/></th>
					<!--<th align="center" class="ocho"><xsl:value-of select="document($doc)/translation/texts/item[@name='fichero']/node()"/></th>-->
					<th align="center" class="ocho"><xsl:value-of select="document($doc)/translation/texts/item[@name='accion']/node()"/></th>
					<!--<th align="center">Estado</th> Siempre será con errores-->
					<th align="center"><xsl:value-of select="document($doc)/translation/texts/item[@name='comentarios']/node()"/></th>
					<th align="center" class="quince"><xsl:value-of select="document($doc)/translation/texts/item[@name='acciones']/node()"/></th>
				</tr>
			</thead>

			<tbody>
			<xsl:for-each select="/Administracion/INICIO/INTEGRACION/FICHERO">
				<tr>
					<td align="center">&nbsp;<xsl:value-of select="FECHA"/></td>
					<td align="left">&nbsp;<xsl:value-of select="CLIENTE"/></td>
					<td align="center">&nbsp;
                                            <xsl:choose>
                                                <xsl:when test="PROVEEDOR/NOMBRECORTO != ''"><xsl:value-of select="PROVEEDOR/NOMBRECORTO"/></xsl:when>
                                                <xsl:otherwise><xsl:value-of select="document($doc)/translation/texts/item[@name='no_informado']/node()"/></xsl:otherwise>
                                            </xsl:choose>
                                            
                                        </td>
					<!--<td align="left">&nbsp;<xsl:value-of select="NOMBRE"/></td>-->
					<td align="center">&nbsp;<xsl:value-of select="ACCION"/></td>
					<!--<td align="left">&nbsp;<xsl:value-of select="ESTADO"/></td>-->
					<td align="left">&nbsp;<xsl:value-of select="COMENTARIOS_CORTO"/></td>
					<td align="center">
						<a href="javascript:EjecutarFichero({ID});">
                                                    <xsl:attribute name="title">
                                                        <xsl:value-of select="document($doc)/translation/texts/item[@name='ejecutar_integ_expli']/node()"/>
                                                    </xsl:attribute>
                                                    <xsl:choose>
                                                        <xsl:when test="Administracion/LANG = 'spanish'"><img src="http://www.newco.dev.br/images/botonEjecutar.gif" alt="Ejecutar" /></xsl:when>
                                                        <xsl:otherwise><img src="http://www.newco.dev.br/images/botonEjecutar-BR.gif" alt="Executar" /></xsl:otherwise>
                                                    </xsl:choose>
                                                </a>&nbsp;
						<a href="javascript:OkManualFichero({ID});">
                                                     <xsl:attribute name="title">
                                                        <xsl:value-of select="document($doc)/translation/texts/item[@name='archivar_integ_expli']/node()"/>
                                                    </xsl:attribute>
                                                    <xsl:choose>
                                                        <xsl:when test="Administracion/LANG = 'spanish'"><img src="http://www.newco.dev.br/images/botonArchivar.gif" alt="Archivar" /></xsl:when>
                                                        <xsl:otherwise><img src="http://www.newco.dev.br/images/botonArchivar-BR.gif" alt="Archivo" /></xsl:otherwise>
                                                    </xsl:choose>
                                                </a>&nbsp;
						<a href="javascript:EditarFichero({ID});">
                                                     <xsl:attribute name="title">
                                                        <xsl:value-of select="document($doc)/translation/texts/item[@name='editar_integ_expli']/node()"/>
                                                    </xsl:attribute>
                                                    <img src="http://www.newco.dev.br/images/botonEditar.gif" alt="Editar" />
                                                </a>
					</td>
				</tr>
			</xsl:for-each>
			</tbody>
			</table>
                        
      <table class="infoTable">
			<tfoot>
				<tr class="lejenda lineBorderBottom3" style="background:#E4E4E5;font-weight:bold;"> 
					<td colspan="5" class="datosLeft" style="padding:3px 0px 0px 20px;"><xsl:value-of select="document($doc)/translation/texts/item[@name='leyenda']/node()"/>:</td>
				</tr>
                                <tr class="lineBorderBottom5">
                                    <td class="trenta datosLeft">
                                        <p style="line-height:20px;">
					&nbsp;&nbsp;&nbsp;&nbsp; 
                                            <xsl:choose>
                                                <xsl:when test="Administracion/LANG = 'spanish'"><img src="http://www.newco.dev.br/images/botonEjecutar.gif" alt="Ejecutar" /></xsl:when>
                                                <xsl:otherwise><img src="http://www.newco.dev.br/images/botonEjecutar-BR.gif" alt="Executar" /></xsl:otherwise>
                                            </xsl:choose> 
                                            &nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='ejecutar_integ_expli']/node()"/><br />
                                            &nbsp;&nbsp;&nbsp;&nbsp; 
                                            <xsl:choose>
                                                <xsl:when test="Administracion/LANG = 'spanish'"><img src="http://www.newco.dev.br/images/botonArchivar.gif" alt="Archivar" /></xsl:when>
                                                <xsl:otherwise><img src="http://www.newco.dev.br/images/botonArchivar-BR.gif" alt="Archivo" /></xsl:otherwise>
                                            </xsl:choose> 
                                            &nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='archivar_integ_expli']/node()"/><br />
                                            &nbsp;&nbsp;&nbsp;&nbsp; 
                                            <img src="http://www.newco.dev.br/images/botonEditar.gif" alt="Editar" />
                                            &nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='editar_integ_expli']/node()"/>
                                        </p>
                                    </td>
                                    <td>&nbsp;</td>
                                 </tr>
			</tfoot>
			</table>
		</xsl:when>
		<xsl:otherwise>
                    <p style="text-align:center;font-weight:bold;"><xsl:value-of select="document($doc)/translation/texts/item[@name='sin_ficheros_pendientes']/node()"/></p>
		</xsl:otherwise>
		</xsl:choose>
	</xsl:if>
	<br/>
	<br/>
	<!-- Formulario, menús -->
	<form name="Admin" method="post" action="Integracion.xsql">
	<input type="hidden" name="ACCION"/>
	<input type="hidden" name="PARAMETROS"/>
	</form>
</xsl:otherwise>
</xsl:choose>
<!--PS 120716 -->
</body>
</html>
</xsl:template> <!--fin de template body-->

<!-- PS 12jul16 -->

 <xsl:template name="GENERAL_TEXTBOX">
   <xsl:param name="nom"/>
   <xsl:param name="valor"/>
   <xsl:param name="size">15</xsl:param>
   <xsl:param name="perderFoco"/>
   <xsl:param name="maxChars"/>

   <input type="text" name="{$nom}" size="{$size}" value="{$valor}">
     <xsl:if test="$perderFoco!=''">
       <xsl:attribute name="onBlur"><xsl:value-of select="$perderFoco"/></xsl:attribute>
     </xsl:if>
     <xsl:if test="$maxChars!=''">
       <xsl:attribute name="maxlength"><xsl:value-of select="$maxChars"/></xsl:attribute>
     </xsl:if>
   </input>
</xsl:template>

<!--INICIO TEMPLATE IMAGE-->
 <xsl:template name="image">
  <xsl:param name="num" />
  <div class="imageLine" id="imageLine_{$num}">
      <label class="medium" for="inputFile_{$num}" style="display:none;">&nbsp;</label>
      <input id="inputFile_{$num}" name="inputFile" type="file" onchange="addFile({$num});" />
  </div>
</xsl:template>

<!--INICIO TEMPLATE IMAGE Mantenimiento-->
<xsl:template name="imageMan">
  <xsl:param name="num" />

  <!--idioma-->
  <xsl:variable name="lang">
    <xsl:value-of select="../../../../LANG"/>
  </xsl:variable>
  <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
  <!--idioma fin-->

  <div class="imageLine" id="imageLine_{$num}">
    <label for="inputFile_{$num}" id="labelFile_{$num}">
      <xsl:if test="@id != '-1' or $num != '0'">
        <xsl:attribute name="style">display:none;</xsl:attribute>
      </xsl:if>
      &nbsp;<xsl:value-of select="$num"/>:&nbsp;
    </label>
    <input id="inputFile_{$num}" name="inputFile" type="file" onchange="addFile({$num});">
      <xsl:if test="@id != '-1' or $num != '0'">
        <xsl:attribute name="style">display:none;</xsl:attribute>
      </xsl:if>
    </input>

    <xsl:if test="@id != '-1'">
      <div class="imageManten">
        <label class="medium" for="inputFile_{$num}" style="display:none;">&nbsp;<xsl:value-of select="$num"/>:&nbsp;</label>
        <img src="http://www.newco.dev.br/Fotos/{@peq}" class="manFoto"/>
        <xsl:text>&nbsp;&nbsp;&nbsp;</xsl:text>
        <a id="deleteLink_{$num}" href="javascript:void();" onclick="this.parentNode.style.display='none'; return deleteFile({@id}, {$num});">
          <xsl:value-of select="document($doc)/translation/texts/item[@name='eliminar']/node()"/>
        </a>
      </div>
    </xsl:if>
  </div>
</xsl:template>
<!--fin de template image-->

<!--template carga documentos-->
<!-- PS 13jul16
<xsl:template name="CargaDocumentos">
  <xsl:param name="tipo"/>
  <xsl:param name="nombre_corto"/>

    <xsl:variable name="lang">
    <xsl:value-of select="/MantenimientoProductos/LANG"/>
  </xsl:variable>
  <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
  

  <div class="divLeft" id="cargaDoc{$tipo}">
    <div id="confirmBox{$tipo}" style="display:none;" align="center">
      <span class="cargado">?<xsl:value-of select="document($doc)/translation/texts/item[@name='documento_cargado']/node()"/>!</span>
    </div>-->

<!--template carga documentos-->
<xsl:template name="CargaDocumentos">
  <!--<xsl:param name="tipo"/>Fs/item[@name='documento_cargado']/node()"/>!</span>-->
    <!--</div>-->

    <!--tabla imagenes y documentos-->
    <table class="infoTable" border="0">
      <tr>
        <!--documentos-->
        <td class="veintecinco">&nbsp;</td>
        <td class="labelRight dies">
          <span class="text{$tipo}">
            <xsl:choose>
            <xsl:when test="$nombre_corto != ''">
              <xsl:value-of select="document($doc)/translation/texts/item[@name='subir_oferta']/node()"/><!--&nbsp;<xsl:value-of select="$nombre_corto"/>-->
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="document($doc)/translation/texts/item[@name='subir_ficha']/node()"/>
            </xsl:otherwise>
            </xsl:choose>
                                        </span>
        </td>
        <td class="datosLeft quince">
          <div class="altaDocumento">
            <span class="anadirDoc">
              <xsl:call-template name="documentos">
                <xsl:with-param name="num" select="number(1)"/>
                <xsl:with-param name="type" select="$tipo"/>
              </xsl:call-template>
            </span>
          </div>
        </td>
        <td class="dies">

            <a href="javascript:cargaDoc(document.forms['form1'],'{$tipo}');" class="botonLink">
              <span class="text{$tipo}">
                <xsl:choose>
                <xsl:when test="$nombre_corto != ''">
                  <xsl:value-of select="document($doc)/translation/texts/item[@name='subir_oferta']/node()"/><!--&nbsp;<xsl:value-of select="$nombre_corto"/>-->
                </xsl:when>
                <xsl:otherwise>
                  <xsl:value-of select="document($doc)/translation/texts/item[@name='subir_ficha']/node()"/>
                </xsl:otherwise>
                </xsl:choose>
                                                        </span>
            </a>
        </td>
        <td>&nbsp;</td>
      </tr>
    </table><!--fin de tabla imagenes doc-->

    <div id="waitBoxDoc{$tipo}" align="center">&nbsp;</div>
  <!--</div>--><!--fin de divleft-->
</xsl:template><!--fin de template carga documentos-->

<!--documentos-->
<xsl:template name="documentos">
  <xsl:param name="num" />
    <xsl:param name="type" />
  <xsl:choose>
    <xsl:when test="$num &lt; number(5)">
      <div class="docLine" id="docLine_{$type}">

        <div class="docLongEspec" id="docLongEspec_{$type}">

          <input id="inputFileDoc_{$type}" name="inputFileDoc" type="file" onChange="addDocFile('{$type}');" />
        </div>
      </div>
    </xsl:when>

  </xsl:choose>
    </xsl:template>
<!--fin de documentos-->

<!--template carga documentos-->
<xsl:template name="CargaDocumentosNormal">
	<xsl:param name="tipo" />

	<!--idioma-->
        <xsl:variable name="lang">
        	<xsl:value-of select="/MantenimientoProductos/LANG" />
        </xsl:variable>
        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
      <!--idioma fin-->

    <div class="divLeft" id="cargaDoc{$tipo}">
    <xsl:apply-templates select="MantenimientoProductos/Form"/>
    <div id="confirmBox{$tipo}" style="display:none;" align="center"><span class="cargado">?<xsl:value-of select="document($doc)/translation/texts/item[@name='documento_cargado']/node()"/>!</span></div>

  <!--tabla imagenes y documentos-->
  <table class="infoTable" border="2">
  <tr>
     <!--documentos-->
        <td class="veintecinco labelRight">
        	<xsl:value-of select="document($doc)/translation/texts/item[@name='subir_documento']/node()"/>:
        </td>

        <td class="datosLeft quince">
       	<div class="altaDocumento">

            <span class="anadirDoc">
                <xsl:call-template name="documentos">
                	<xsl:with-param name="num" select="number(1)" />
                    <xsl:with-param name="type" select="$tipo"/>
            	</xsl:call-template>
            </span>
        </div>
        </td>
        <td class="dies">
        	<div class="boton">
                	<a href="javascript:cargaDoc(document.forms['form1'],'{$tipo}');">
                    	<xsl:value-of select="document($doc)/translation/texts/item[@name='subir_documento']/node()"/>&nbsp;</a>
       			</div>
        </td>
        <td>&nbsp;</td>
     </tr>
  </table><!--fin de tabla imagenes doc-->

  <div id="waitBoxDoc{$tipo}" align="center">&nbsp;</div>

  </div><!--fin de divleft-->

</xsl:template>
</xsl:stylesheet>
