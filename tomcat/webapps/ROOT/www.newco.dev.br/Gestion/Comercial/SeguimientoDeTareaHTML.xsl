<?xml version="1.0" encoding="iso-8859-1"?>
<!--  -->
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
		<xsl:when test="/Seguimiento/LANG != ''"><xsl:value-of select="/Seguimiento/LANG"/></xsl:when>
		<xsl:when test="/Seguimiento/LANGTESTI != ''"><xsl:value-of select="/Seguimiento/LANGTESTI"/></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
	</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--fin idioma-->

	<title><xsl:value-of select="document($doc)/translation/texts/item[@name='seguimiento_titulo']/node()"/></title>
	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->

	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery-1.8.3.min.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/Gestion/Comercial/seguimiento_210815.js"></script>
        <link rel="stylesheet" type="text/css" href="http://www.newco.dev.br/General/TablaResumen-popup.css"/>
	<script type="text/javascript" src="http://www.newco.dev.br/General/TablaResumen-popup.js"></script>

        <script type="text/javascript">
		var crearCentro	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='crear_centro']/node()"/>';
                var textoObli	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='descripcion_obli']/node()"/>';
        </script>
</head>

<body onload="RecuperaBienText();">
<xsl:choose>
<!-- Error en alguna sentencia del XSQL -->
<xsl:when test="//xsql-error">
	<xsl:apply-templates select="//xsql-error"/>
</xsl:when>
<xsl:when test="//SESION_CADUCADA">
	<xsl:for-each select="//SESION_CADUCADA">
		<xsl:if test="position()=last()">
			<xsl:apply-templates select="."/>
		</xsl:if>
	</xsl:for-each>
</xsl:when>
<xsl:otherwise>
	<!--idioma-->
	<xsl:variable name="lang">
	<xsl:choose>
		<xsl:when test="/Seguimiento/LANG != ''"><xsl:value-of select="/Seguimiento/LANG"/></xsl:when>
		<xsl:when test="/Seguimiento/LANGTESTI != ''"><xsl:value-of select="/Seguimiento/LANGTESTI"/></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
	</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--fin idioma-->
        
        <form name="form1" action="Seguimiento.xsql" method="post">
		<table class="infoTable" style="margin-bottom:10px;">
			<tr style="background:#C3D2E9;border-bottom:0px solid #3B5998;">
				<td>
					<p style="font-weight:bold;">
                                            <xsl:call-template name="desplegable">
						<xsl:with-param name="path" select="/Seguimiento/ENTRADAS_SEGUIMIENTO/EMPRESAS/field"/>
						<xsl:with-param name="onChange">javascript:CambiarEmpresa();</xsl:with-param>
                                                <xsl:with-param name="claSel">selectFont18</xsl:with-param>
                                            </xsl:call-template>
                                            &nbsp;&nbsp;
                                            <input type="hidden" name="IDPAIS" value="{/Seguimiento/ENTRADAS_SEGUIMIENTO/TITULOS/IDPAIS}" />
                                            <input type="hidden" name="IDEMPRESA" value="{/Seguimiento/ENTRADAS_SEGUIMIENTO/EMPRESAS/field/@current}" />
                                            <input type="hidden" name="SOLO_CLIENTES" />
                                            <input type="hidden" name="SOLO_PROVEE" />
                                            <input type="checkbox" name="SOLO_CLIENTES_CK" onchange="soloClientes(document.forms['form1']);"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='solo_clientes']/node()"/>&nbsp;&nbsp;
                                            <input type="checkbox" name="SOLO_PROVEE_CK" onchange="soloProvee(document.forms['form1']);"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='solo_proveedores']/node()"/>
                                        </p>
				</td>
			</tr>
		</table><!--fin desplegable empresas, para saber de que empresa veo los datos-->


        

<div style="background:#fff;float:left;">
	<!--	Bloque de pestañas	-->
        &nbsp;
        <xsl:if test="/Seguimiento/ENTRADAS_SEGUIMIENTO/TITULOS/IDEMPRESA != ''">
            <a href="http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPDetalleFrame.xsql?EMP_ID={/Seguimiento/ENTRADAS_SEGUIMIENTO/TITULOS/IDEMPRESA}&amp;ESTADO=CABECERA" style="text-decoration:none;">
            <xsl:choose>
            <xsl:when test="/Seguimiento/LANG = 'spanish'">
                    <img src="http://www.newco.dev.br/images/botonFicha.gif" alt="FICHA"/>
            </xsl:when>
            <xsl:otherwise>
                    <img src="http://www.newco.dev.br/images/botonFicha.gif" alt="FICHA"/>
            </xsl:otherwise>
            </xsl:choose>
            </a>&nbsp;
        </xsl:if>
        
        <xsl:if test="/Seguimiento/ENTRADAS_SEGUIMIENTO/TITULOS/IDEMPRESA != ''">
		<a href="http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPDetalleFrame.xsql?EMP_ID={/Seguimiento/ENTRADAS_SEGUIMIENTO/TITULOS/IDEMPRESA}&amp;ESTADO=CABECERA&amp;ZONA=COND_COMERC" style="text-decoration:none;">
		<xsl:choose>
		<xsl:when test="/Seguimiento/LANG = 'spanish'">
			<img src="http://www.newco.dev.br/images/botonCondicionesComerciales.gif" alt="CONDICIONES COMERCIALES" id="COND_COMERC"/>
		</xsl:when>
		<xsl:otherwise>
			<img src="http://www.newco.dev.br/images/botonCondicionesComerciales-BR.gif" alt="CONDIÇÕES COMERCIAIS" id="COND_COMERC"/>
		</xsl:otherwise>
		</xsl:choose>
		</a>
                &nbsp;
	</xsl:if>
        
	<a href="http://www.newco.dev.br/Gestion/Comercial/Seguimiento.xsql?FIDEMPRESA={/Seguimiento/ENTRADAS_SEGUIMIENTO/TITULOS/IDEMPRESA}" style="text-decoration:none;">
	<xsl:choose>
	<xsl:when test="/Seguimiento/LANG = 'spanish'">
		<img src="http://www.newco.dev.br/images/botonSeguimiento1.gif" alt="SEGUIMIENTO"/>
	</xsl:when>
	<xsl:otherwise>
		<img src="http://www.newco.dev.br/images/botonSeguimiento1-Br.gif" alt="SEGUIMENTO"/>
	</xsl:otherwise>
	</xsl:choose>
	</a>&nbsp;
        
	<a href="http://www.newco.dev.br/Gestion/Comercial/Tareas.xsql?FIDEMPRESA={/Seguimiento/ENTRADAS_SEGUIMIENTO/TITULOS/IDEMPRESA}&amp;FIDRESPONSABLE=-1" style="text-decoration:none;">
	<xsl:choose>
	<xsl:when test="/Seguimiento/LANG = 'spanish'">
		<img src="http://www.newco.dev.br/images/botonTareas.gif" alt="TAREAS"/>
	</xsl:when>
	<xsl:otherwise>
		<img src="http://www.newco.dev.br/images/botonTareas-Br.gif" alt="TAREFAS"/>
	</xsl:otherwise>
	</xsl:choose>
	</a>&nbsp;
        
        <xsl:if test="/Seguimiento/ENTRADAS_SEGUIMIENTO/TITULOS/IDEMPRESA != ''">
            <a href="http://www.newco.dev.br/Gestion/Comercial/Meddicc.xsql?FIDEMPRESA={/Seguimiento/ENTRADAS_SEGUIMIENTO/TITULOS/IDEMPRESA}" style="text-decoration:none;">
            <xsl:choose>
            <xsl:when test="/Seguimiento/LANG = 'spanish'">
                    <img src="http://www.newco.dev.br/images/botonMeddicc.gif" alt="MEDDICC"/>
            </xsl:when>
            <xsl:otherwise>
                    <img src="http://www.newco.dev.br/images/botonMeddicc.gif" alt="MEDDICC"/>
            </xsl:otherwise>
            </xsl:choose>
            </a>&nbsp;
        </xsl:if>
        
        <xsl:if test="/Seguimiento/ENTRADAS_SEGUIMIENTO/TITULOS/IDEMPRESA != ''">
                <a href="http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPDetalleFrame.xsql?EMP_ID={/Seguimiento/ENTRADAS_SEGUIMIENTO/TITULOS/IDEMPRESA}&amp;ESTADO=CABECERA&amp;ZONA=DOCS" style="text-decoration:none;">
			<img src="http://www.newco.dev.br/images/botonDocumentos.gif" alt="DOCUMENTOS" id="DOCUMENTOS"/>
		</a>
		&nbsp;
	</xsl:if>

    </div>
    
    <xsl:if test="/Tareas/INICIO/MVM or /Tareas/INICIO/MVMB">
        <div style="background:#fff;float:right;">
            <a href="http://www.newco.dev.br/Gestion/Comercial/BuscadorEmpresas.xsql"  style="text-decoration:none;">
                    <img src="http://www.newco.dev.br/images/botonBuscador.gif" alt="BUSCADOR"/>
            </a>
        </div>
    </xsl:if>

<div class="divLeft">
		<h1 class="titlePage" style="float:left;width:60%;padding-left:20%;">
                    <xsl:value-of select="document($doc)/translation/texts/item[@name='seguimiento_titulo']/node()"/>&nbsp;
                    <xsl:if test="/Seguimiento/ENTRADAS_SEGUIMIENTO/EMPRESAS/field/dropDownList/listElem[ID = ../../@current]/listItem != 'Todas'">
                        [&nbsp;<xsl:value-of select="/Seguimiento/ENTRADAS_SEGUIMIENTO/EMPRESAS/field/dropDownList/listElem[ID = ../../@current]/listItem"/>&nbsp;]
                    </xsl:if>
                        <xsl:text>&nbsp;&nbsp;&nbsp;</xsl:text>
                        <a href="javascript:window.print();" style="text-decoration:none;">
	                        <img src="http://www.newco.dev.br/images/imprimir.gif"/>
                            <xsl:value-of select="document($doc)/translation/texts/item[@name='imprimir']/node()"/>
                        </a>
                       
		</h1>
                <h1 class="titlePage" style="float:left;width:20%;">
                    <xsl:if test="(/Seguimiento/ENTRADAS_SEGUIMIENTO/MVM or /Seguimiento/ENTRADAS_SEGUIMIENTO/MVMB or /Seguimiento/ENTRADAS_SEGUIMIENTO/ADMIN) and /Seguimiento/ENTRADAS_SEGUIMIENTO/EMPRESAS/field/@current != ''">
                        <span style="float:right; padding:5px;" class="amarillo">EMP_ID: <xsl:value-of select="/Seguimiento/ENTRADAS_SEGUIMIENTO/EMPRESAS/field/@current"/></span>
                    </xsl:if>
                </h1>

				<input type="hidden" name="ACCION"/>
				<input type="hidden" name="PARAMETROS"/>
				<!--<input type="hidden" name="IDSEGUIMIENTO"/>
				<input type="hidden" name="IDEMPRESA_OR" value="{/Seguimiento/ENTRADAS_SEGUIMIENTO/TITULOS/IDEMPRESA}"/>-->

				<table class="infoTable" border="0">
                                    <xsl:choose>
                                    <xsl:when test="/Seguimiento/ENTRADAS_SEGUIMIENTO/SEGUIMIENTO">
                                        <!--buscador-->
                                        <tr class="subTituloTablaNoB">
						<td class="cinco">&nbsp;</td>
                                                <td class="ocho">&nbsp;</td>
						<td class="datosLeft ocho">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='tipo']/node()"/>
						</td>
                                                <td class="datosLeft quince">
                                                    <xsl:value-of select="document($doc)/translation/texts/item[@name='centro']/node()"/>
						</td>
                                                <td class="datosLeft dies">
                                                    <xsl:value-of select="document($doc)/translation/texts/item[@name='visibilidad']/node()"/>
						</td>
                                                <td class="datosLeft quince">
                                                   <xsl:value-of select="document($doc)/translation/texts/item[@name='autor']/node()"/> 
                                                </td>
						<td class="datosLeft">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='texto']/node()"/>
						</td>
						<td class="tres">&nbsp;</td>
					</tr>
                                        <tr class="subTituloTablaNoB">
						<td colspan="2">&nbsp;</td>
						<td class="datosLeft">
							<xsl:call-template name="desplegable">
								<xsl:with-param name="path" select="/Seguimiento/ENTRADAS_SEGUIMIENTO/FTIPO/field"></xsl:with-param>
                                                                <xsl:with-param name="defecto" select="/Seguimiento/ENTRADAS_SEGUIMIENTO/TITULOS/FTIPO"></xsl:with-param>
							</xsl:call-template>
						</td>
                                                <td class="datosLeft">
                                                    <xsl:if test="/Seguimiento/ENTRADAS_SEGUIMIENTO/EMPRESAS/field/@current != ''">
                                                    <select name="FIDCENTRO" id="FIDCENTRO" class="select200 centroBox">
                                                        <xsl:for-each select="/Seguimiento/ENTRADAS_SEGUIMIENTO/LISTACENTROS/field/dropDownList/listElem">
                                                            <option value="{ID}"><xsl:value-of select="listItem" /></option>
                                                        </xsl:for-each>
                                                    </select>
                                                    </xsl:if>
						</td>
                                                <td colspan="2">&nbsp;</td>
						<td class="datosLeft">
							<input type="text" name="FTEXTO" size="40" value="{/Seguimiento/TEXTO}" style="float:left;"/>&nbsp;
                                                        <div class="boton" style="margin-left:20px;">
								<strong>
									<a href="javascript:Enviar();">
										<xsl:value-of select="document($doc)/translation/texts/item[@name='buscar']/node()"/>
									</a>
								</strong>
							</div>
						</td>
						<td>&nbsp;</td>
					</tr>
                                        <!--fin buscador-->
					<tr class="subTituloTablaNoB line5"><td colspan="8" height="5px"></td></tr>
					<xsl:for-each select="/Seguimiento/ENTRADAS_SEGUIMIENTO/SEGUIMIENTO/ENTRADA">
						<xsl:variable name="id" select="ID"/>
							<xsl:choose>
								<xsl:when test="/Seguimiento/ENTRADAS_SEGUIMIENTO/IDUSUARIO=IDAUTOR or /Seguimiento/ENTRADAS_SEGUIMIENTO/SUPERUSUARIO">
                                                                    <tr>
                                                                        <td class="datosCenter">
                                                                               
									</td>
                                                                        <td class="datosCenter"><strong><xsl:value-of select="FECHA"/></strong></td>
									<td style="text-align:left;">
                                                                            
                                                                            <xsl:variable name="idTipoSel" select="TIPO/field/dropDownList/listElem[ID = ../../@current]/ID" />

                                                                            <select name="IDTIPO_{ID}" id="IDTIPO_{ID}" class="select120">
                                                                                <xsl:for-each select="/Seguimiento/ENTRADAS_SEGUIMIENTO/TIPO/field/dropDownList/listElem">
                                                                                    <xsl:choose>
                                                                                        <xsl:when test="ID = $idTipoSel">
                                                                                            <option value="{ID}" selected="selected"><xsl:value-of select="listItem" /></option>
                                                                                        </xsl:when>
                                                                                        <xsl:otherwise>
                                                                                            <option value="{ID}"><xsl:value-of select="listItem" /></option>
                                                                                        </xsl:otherwise>
                                                                                    </xsl:choose>
                                                                                </xsl:for-each>
                                                                            </select>
                                                                            
									</td>
                                                                        <td style="text-align:left;font-weight:bold;">
                                                                            <xsl:variable name="idCentroSel" select="IDCENTRO" />
                                                                           
                                                                            <select name="IDCENTRO_{ID}" id="IDCENTRO_{ID}" class="select200 centros">
                                                                                <xsl:if test="/Seguimiento/ENTRADAS_SEGUIMIENTO/EMPRESAS/field/@current = ''">
                                                                                    <xsl:attribute name="disabled">disabled</xsl:attribute>
                                                                                </xsl:if>
                                                                                <xsl:for-each select="/Seguimiento/ENTRADAS_SEGUIMIENTO/LISTACENTROS/field/dropDownList/listElem">
                                                                                    <xsl:choose>
                                                                                        <xsl:when test="ID = $idCentroSel">
                                                                                            <option value="{ID}" selected="selected"><xsl:value-of select="listItem" /></option>
                                                                                        </xsl:when>
                                                                                        <xsl:otherwise>
                                                                                            <option value="{ID}"><xsl:value-of select="listItem" /></option>
                                                                                        </xsl:otherwise>
                                                                                    </xsl:choose>
                                                                                </xsl:for-each>
                                                                            </select>
                                                                            &nbsp;
                                                                            <xsl:if test="/Seguimiento/ENTRADAS_SEGUIMIENTO/EMPRESAS/field/@current = ''">
                                                                                    <a href="javascript:CambiarEmpresaID({IDEMPRESA});"><img src="http://www.newco.dev.br/images/sel.gif" alt="Sel" style="text-decoration:none;"/></a>
                                                                            </xsl:if>
                                                                        </td>
                                                                        <td style="text-align:left;">
                                                                           <input type="radio" name="VISIBILIDAD_{ID}" id="VIS_PRIVADA_{ID}" value="P">
                                                                                    <xsl:if test="VISIBILIDAD = 'P'">
                                                                                            <xsl:attribute name="checked">checked</xsl:attribute>
                                                                                    </xsl:if>
                                                                           </input>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='priv']/node()"/>&nbsp;&nbsp;
                                                                           <input type="radio" name="VISIBILIDAD_{ID}" id="VIS_CENTRO_{ID}" value="C">
                                                                                    <xsl:if test="VISIBILIDAD = 'C'">
                                                                                            <xsl:attribute name="checked">checked</xsl:attribute>
                                                                                    </xsl:if>
                                                                           </input>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='cen']/node()"/>&nbsp;&nbsp;
                                                                           <input type="radio" name="VISIBILIDAD_{ID}" id="VIS_EMPRESA_{ID}" value="E">
                                                                                    <xsl:if test="VISIBILIDAD = 'E'">
                                                                                            <xsl:attribute name="checked">checked</xsl:attribute>
                                                                                    </xsl:if>
                                                                           </input>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='emp']/node()"/>&nbsp;&nbsp;
                                                                        </td>
                                                                        <td colspan="2" style="text-align:left;">
                                                                            <span style="font-weight:bold;"><xsl:value-of select="AUTOR"/></span>&nbsp;&nbsp;
                                                                            (<xsl:value-of select="CENTROAUTOR"/>)
                                                                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                                            <a href="javascript:Modificar('{ID}');" style="text-decoration:none;">
										<img src="http://www.newco.dev.br/images/modificar.gif"/>
                                                                            </a>
                                                                            &nbsp;&nbsp;&nbsp;
                                                                            <a href="javascript:Borrar('{ID}');" style="text-decoration:none;">
										<img src="http://www.newco.dev.br/images/2017/trash.png"/>
									    </a>
                                                                        </td>
                                                                    </tr>
                                                                    <tr class="subTareasTot">
                                                                        <td colspan="2">&nbsp;</td>
									<td colspan="4" style="text-align:left;padding:5px 0px;">
                                                                            <textarea type="text" name="TEXTO_{ID}" id="TEXTO_{ID}" cols="125" rows="5" class="textModificable"><xsl:copy-of select="TEXTO/node()"/></textarea>
                                                                        </td>
                                                                    </tr>
								</xsl:when>
								<xsl:otherwise>
                                                                    <tr>
                                                                        <td class="datosCenter">&nbsp;</td>
									<td class="datosCenter"><strong><xsl:value-of select="FECHA"/></strong></td>
									<td style="text-align:left;font-weight:bold;">
                                                                            <xsl:value-of select="TIPO/field/dropDownList/listElem[ID = ../../@current]/listItem"/>
									</td>
                                                                        <td style="text-align:left;font-weight:bold;">
                                                                            <xsl:value-of select="CENTRO" />
                                                                        </td>
                                                                        <td style="text-align:left;">
                                                                           <input type="radio" name="VISIBILIDAD_{ID}" id="VIS_PRIVADA_{ID}" value="P" disabled="disabled">
                                                                                    <xsl:if test="VISIBILIDAD = 'P'">
                                                                                            <xsl:attribute name="checked">checked</xsl:attribute>
                                                                                    </xsl:if>
                                                                           </input>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='priv']/node()"/>&nbsp;&nbsp;
                                                                           <input type="radio" name="VISIBILIDAD_{ID}" id="VIS_CENTRO_{ID}" value="C" disabled="disabled">
                                                                                    <xsl:if test="VISIBILIDAD = 'C'">
                                                                                            <xsl:attribute name="checked">checked</xsl:attribute>
                                                                                    </xsl:if>
                                                                           </input>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='cen']/node()"/>&nbsp;&nbsp;
                                                                           <input type="radio" name="VISIBILIDAD_{ID}" id="VIS_EMPRESA_{ID}" value="E" disabled="disabled">
                                                                                    <xsl:if test="VISIBILIDAD = 'E'">
                                                                                            <xsl:attribute name="checked">checked</xsl:attribute>
                                                                                    </xsl:if>
                                                                           </input>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='emp']/node()"/>&nbsp;&nbsp;
                                                                        </td>
                                                                        <td style="text-align:left;font-weight:bold;">
                                                                            <span style="font-weight:bold;"><xsl:value-of select="AUTOR"/></span>&nbsp;&nbsp;&nbsp;
                                                                             <!--empresa, la oculto si hay una seleccionada arriba-->
                                                                                <xsl:if test="/Seguimiento/ENTRADAS_SEGUIMIENTO/EMPRESAS/field/@current = ''">
                                                                                    <a href="javascript:CambiarEmpresaID({IDEMPRESA});"><xsl:value-of select="EMPRESA"/></a>
                                                                                </xsl:if>
                                                                        </td>
                                                                        <td>&nbsp;</td>
                                                                    </tr>
                                                                    <tr class="subTareasTot">
                                                                        <td colspan="2">&nbsp;</td>
									<td colspan="4" style="text-align:left;padding:5px 0px;"><xsl:copy-of select="TEXTO" /></td>
                                                                    </tr>
								</xsl:otherwise>
							</xsl:choose>
					</xsl:for-each>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <tr><td colspan="6" align="center"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='seguimiento_sin_resultados']/node()"/></strong></td></tr>
                                    </xsl:otherwise>
                                    </xsl:choose>
                                </table>
                                <br /><br />
                                        <!--hay que ser comercial para crear un nuevo seguimineto y empresa informada-->
                                        <xsl:if test="/Seguimiento/ENTRADAS_SEGUIMIENTO/COMERCIAL and /Seguimiento/ENTRADAS_SEGUIMIENTO/EMPRESAS/field/@current != ''">
                                           <div class="divLeft20">&nbsp;</div>
                                            <div class="divLeft60nopa">
                                            <table class="infoTable incidencias" border="0" cellspacing="5" style="border-top:2px solid #D7D8D7;border-bottom:2px solid #D7D8D7;">
                                                 <tr>
                                                <td colspan="4" class="grisMed" style="font-weight:bold;">
                                                  <xsl:value-of select="document($doc)/translation/texts/item[@name='nueva_entrada_de_seguimiento']/node()"/>&nbsp;
                                                  <xsl:value-of select="document($doc)/translation/texts/item[@name='para']/node()"/>&nbsp;
                                                   <xsl:value-of select="/Seguimiento/ENTRADAS_SEGUIMIENTO/EMPRESAS/field/dropDownList/listElem[ID = ../../@current]/listItem"/>,&nbsp;
                                                  <xsl:value-of select="document($doc)/translation/texts/item[@name='dia']/node()"/>&nbsp;
                                                  <xsl:value-of select="/Seguimiento/ENTRADAS_SEGUIMIENTO/FECHA"/>
                                                </td>
                                            </tr>
                                            <tr>
                                            <td class="dies labelRight grisMed"><xsl:value-of select="document($doc)/translation/texts/item[@name='centro']/node()"/>:</td>
                                            <td class="veinte datosLeft">
                                                    <select name="IDCENTRO" id="IDCENTRO" class="select200 centroBox">
                                                         <xsl:for-each select="/Seguimiento/ENTRADAS_SEGUIMIENTO/LISTACENTROS/field/dropDownList/listElem">
                                                             <xsl:choose>
                                                                 <xsl:when test="../../../../../INICIO/GESTIONCOMERCIAL/GESTION/IDCENTRO = ID"><option value="{ID}" selected="selected"><xsl:value-of select="listItem" /></option></xsl:when>
                                                                 <xsl:otherwise><option value="{ID}"><xsl:value-of select="listItem" /></option></xsl:otherwise>
                                                             </xsl:choose>
                                                        </xsl:for-each>
                                                    </select>
                                            </td>
                                            <td class="labelRight dies grisMed"><xsl:value-of select="document($doc)/translation/texts/item[@name='tipo']/node()"/>:</td>
                                            <td class="datosLeft quince">
                                                    <xsl:call-template name="desplegable">
							<xsl:with-param name="path" select="/Seguimiento/ENTRADAS_SEGUIMIENTO/TIPO/field"></xsl:with-param>
                                                        <xsl:with-param name="defecto" select="/Seguimiento/INICIO/GESTIONCOMERCIAL/GESTION/TIPO/field/@current"></xsl:with-param>
                                                    </xsl:call-template>
                                            </td>
                                          </tr>
                                          <tr>
                                              <td class="dies labelRight grisMed"><xsl:value-of select="document($doc)/translation/texts/item[@name='visibilidad']/node()"/>:</td>
                                              <td colspan="3" class="datosLeft">
                                                   <input type="radio" name="VISIBILIDAD" id="VIS_PRIVADA" value="P">
                                                        <xsl:if test="/Seguimiento/INICIO/GESTIONCOMERCIAL/GESTION/VISIBILIDAD = 'P'">
                                                            <xsl:attribute name="checked">checked</xsl:attribute>
                                                        </xsl:if>
                                                   </input>&nbsp;
                                                   <xsl:value-of select="document($doc)/translation/texts/item[@name='priv']/node()"/>&nbsp;&nbsp;
                                                   <input type="radio" name="VISIBILIDAD" id="VIS_CENTRO" value="C">
                                                       <xsl:if test="/Seguimiento/INICIO/GESTIONCOMERCIAL/GESTION/VISIBILIDAD = 'C'">
                                                            <xsl:attribute name="checked">checked</xsl:attribute>
                                                        </xsl:if>
                                                   </input>&nbsp;
                                                   <xsl:value-of select="document($doc)/translation/texts/item[@name='cen']/node()"/>&nbsp;&nbsp;
                                                   <input type="radio" name="VISIBILIDAD" id="VIS_EMPRESA" value="E">
                                                       <xsl:if test="/Seguimiento/INICIO/GESTIONCOMERCIAL/GESTION/VISIBILIDAD = 'E'">
                                                            <xsl:attribute name="checked">checked</xsl:attribute>
                                                        </xsl:if>
                                                   </input>&nbsp;
                                                   <xsl:value-of select="document($doc)/translation/texts/item[@name='emp']/node()"/>&nbsp;&nbsp;
                                              </td>
                                          </tr>
                                          <tr>
                                            <td class="labelRight grisMed" valign="top"><xsl:value-of select="document($doc)/translation/texts/item[@name='descripcion']/node()"/>:</td>
                                            <td colspan="3" style="text-align:left;">
							<!--descripcion-->
							<textarea name="TEXTO" id="TEXTO" cols="105" rows="10" value="{/Tareas/INICIO/GESTIONCOMERCIAL/TEXTO}" style="float:left;margin-right:10px;">
                                                            <xsl:copy-of select="/Seguimiento/INICIO/GESTIONCOMERCIAL/GESTION/TEXTO/node()" />
                                                        </textarea>
						</td>
                                            </tr> 
                                            <tr style="border-bottom:2px solid #D7D8D7;">
                                                <td colspan="4" align="center">
                                                    <div class="botonCenter">
                                                            <a href="javascript:Nueva();" style="text-decoration:none;">
                                                                <xsl:value-of select="document($doc)/translation/texts/item[@name='nuevo']/node()"/>
                                                            </a>
                                                    </div>
                                                </td>
                                            </tr>
                                       </table>
                                       <br />
                                       <br />
                                       </div>
                                       
                                    </xsl:if>
				
</div>
			</form>
		</xsl:otherwise>
	</xsl:choose>
</body>
</html>
</xsl:template>
</xsl:stylesheet>