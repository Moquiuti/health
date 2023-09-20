<?xml version="1.0" encoding="iso-8859-1"?>
<!--
 |
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
			<xsl:when test="/Meddicc/LANG != ''"><xsl:value-of select="/Meddicc/LANG"/></xsl:when>
			<xsl:when test="/Meddicc/LANGTESTI != ''"><xsl:value-of select="/Meddicc/LANGTESTI"/></xsl:when>
			<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--fin idioma-->

			<title><xsl:value-of select="document($doc)/translation/texts/item[@name='meddicc']/node()"/></title>

			<xsl:call-template name="estiloIndip"/>
			<script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
			<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>
			<script type="text/javascript" src="http://www.newco.dev.br/Gestion/Comercial/meddicc_250117.js"></script>
</head>

<body onload="replaceTextArea();">
	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:choose>
			<xsl:when test="/Meddicc/LANG != ''"><xsl:value-of select="/Meddicc/LANG"/></xsl:when>
			<xsl:when test="/Meddicc/LANGTESTI != ''"><xsl:value-of select="/Meddicc/LANGTESTI"/></xsl:when>
			<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--fin idioma-->

	<form name="Admin" method="post" action="Meddicc.xsql">

	<div class="divLeft">
	<xsl:choose>
		<xsl:when test="/Meddicc/ERROR">
			<h1 class="titlePage"><xsl:value-of select="document($doc)/translation/texts/item[@name='meddicc']/node()"/></h1>
			<div class="divLeft">
				<p><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='no_tiene_derechos']/node()"/></strong></p>
			</div>
		</xsl:when>
		<xsl:when test="not(/Meddicc/INICIO/COMERCIAL) and /Meddicc/INICIO/MEDDICC/LINEAS/NO_EXISTE">
			<h1 class="titlePage"><xsl:value-of select="document($doc)/translation/texts/item[@name='meddicc']/node()"/></h1>
			<div class="divLeft">
			<p>&nbsp;</p>
			<p style="text-align:center;"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='no_datos_disponibles']/node()"/></strong></p>
			</div>
			<input type="hidden" name="ACCION"/>
			<input type="hidden" name="PARAMETROS"/>
		</xsl:when>
		<xsl:otherwise>


		<!--	Titulo de la página		-->
		<div class="ZonaTituloPagina">
			<p class="Path"><xsl:value-of select="document($doc)/translation/texts/item[@name='Inicio']/node()"/>&nbsp;/&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='meddicc']/node()"/>&nbsp;/&nbsp;<span class="FinPath"><xsl:value-of select="document($doc)/translation/texts/item[@name='empresa']/node()"/>&nbsp;</span>
				<span class="CompletarTitulo">
                	<xsl:if test="/Meddicc/INICIO/MEDDICC/LINEAS/FECHA">
						(<xsl:value-of select="document($doc)/translation/texts/item[@name='actualizado']/node()"/>: <xsl:value-of select="/Meddicc/INICIO/MEDDICC/LINEAS/FECHA"/>)
                	</xsl:if>
				</span>
			</p>
			<p class="TituloPagina">
				<xsl:value-of select="/Meddicc/INICIO/MEDDICC/EMPRESA/NOMBRE" disable-output-escaping="yes"/>
                <!--desplegable estado solo si empresa informada-->
                <xsl:if test="/Meddicc/INICIO/MEDDICC/ESTADO">
                    <xsl:text>.&nbsp;</xsl:text>
                    <xsl:value-of select="document($doc)/translation/texts/item[@name='estado']/node()"/>:<span class="camposObligatorios">*</span>&nbsp;

                    <xsl:call-template name="desplegable">
                        <xsl:with-param name="path" select="/Meddicc/INICIO/MEDDICC/ESTADO/field"></xsl:with-param>
		                <xsl:with-param name="claSel">grande</xsl:with-param>
                    </xsl:call-template>
                </xsl:if>
				<span class="CompletarTitulo" style="width:300px;">
                	<xsl:if test="/Meddicc/INICIO/COMERCIAL">
                    	<a class="btnDestacado" href="javascript:GuardarTodo();"><xsl:value-of select="document($doc)/translation/texts/item[@name='guardar']/node()"/></a>
						&nbsp;
                	</xsl:if>
					<a class="btnNormal" href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Gestion/Comercial/MeddiccPrint.xsql?FIDEMPRESA={/Meddicc/INICIO/IDEMPRESA}','Meddicc Imprimir',100,80,0,0);" style="text-decoration:none;" title="Imprimir">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='imprimir']/node()"/>
					</a>
					&nbsp;
				</span>
			</p>
		</div>
		<br/>
		<!--
			<h1 class="titlePage" style="float:left;width:60%;padding-left:20%;">
                    <xsl:value-of select="/Meddicc/INICIO/EMPRESAS/field/dropDownList/listElem[ID = ../../@current]/listItem"/>:&nbsp;
                    <xsl:value-of select="document($doc)/translation/texts/item[@name='meddicc']/node()"/>

                    <!- -desplegable estado solo si empresa informada- ->
                    <xsl:if test="/Meddicc/INICIO/MEDDICC/ESTADO">
                        <xsl:text>&nbsp;&nbsp;&nbsp;</xsl:text>
                        <xsl:value-of select="document($doc)/translation/texts/item[@name='estado']/node()"/>:<span class="camposObligatorios">*</span>&nbsp;

                        <xsl:call-template name="desplegable">
                            <xsl:with-param name="path" select="/Meddicc/INICIO/MEDDICC/ESTADO/field"></xsl:with-param>
                        </xsl:call-template>
                    </xsl:if>

                    <xsl:if test="/Meddicc/INICIO/MEDDICC/LINEAS/FECHA">
			(<xsl:value-of select="document($doc)/translation/texts/item[@name='actualizado']/node()"/>: <xsl:value-of select="/Meddicc/INICIO/MEDDICC/LINEAS/FECHA"/>)
                    </xsl:if>

                    <xsl:text>&nbsp;&nbsp;&nbsp;</xsl:text>
                    <!- -<a href="javascript:window.print();">- ->
                    <a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Gestion/Comercial/MeddiccPrint.xsql','Meddicc Imprimir',100,80,0,0);">
	                <img src="http://www.newco.dev.br/images/imprimir.gif"/>
                        <xsl:value-of select="document($doc)/translation/texts/item[@name='imprimir']/node()"/>
                    </a>
                </h1>
                <h1 class="titlePage" style="float:left;width:20%;">
                    <xsl:if test="/Meddicc/INICIO/MVM or /Meddicc/INICIO/MVMB or /Meddicc/INICIO/ADMIN"><span style="float:right; padding:5px;" class="amarillo">EMP_ID: <xsl:value-of select="/Meddicc/INICIO/EMPRESAS/field/@current"/></span></xsl:if>
                </h1>
		-->

				<input type="hidden" name="ACCION"/>
				<input type="hidden" name="PARAMETROS"/>
				<input type="hidden" name="FIDEMPRESA" value="{/Meddicc/INICIO/IDEMPRESA}"/>

				<!--<table class="infoTable" border="0" id="MeddiccTable">-->
				<table class="buscador" id="MeddiccTable">
<!--
					<tr class="tituloTabla">
						<th colspan="6" align="center"><xsl:value-of select="document($doc)/translation/texts/item[@name='pares_sinonimos_existentes']/node()"/></th>
					</tr>
-->
					<tr class="subTituloTabla">
						<td class="diez"><xsl:value-of select="document($doc)/translation/texts/item[@name='linea']/node()"/></td>
						<td class="treinta"><xsl:value-of select="document($doc)/translation/texts/item[@name='ok']/node()"/></td>
						<td class="treinta">?</td>
						<td class="treinta"><xsl:value-of select="document($doc)/translation/texts/item[@name='red_flag']/node()"/></td>
						<td>
						<!--
                                <xsl:if test="/Meddicc/INICIO/COMERCIAL">
                                    <div class="botonLargo ">
                                    <strong>
                                        <a href="javascript:GuardarTodo();"><xsl:value-of select="document($doc)/translation/texts/item[@name='guardar']/node()"/></a>
                                    </strong>
                                    </div>
                                </xsl:if>
						-->
                        </td>
                        <td>&nbsp;</td>
					</tr>

					<!--	Lineas del MEDDICC	-->
                    <!--metrics-->
                    <input type="hidden" name="TEXTO_OK_1_OLD" value="{/Meddicc/INICIO/MEDDICC/LINEAS/LINEA[@Siglas='M']/TEXTO_OK}"/>
                    <input type="hidden" name="TEXTO_IN_1_OLD" value="{/Meddicc/INICIO/MEDDICC/LINEAS/LINEA[@Siglas='M']/TEXTO_IN}"/>
                    <input type="hidden" name="TEXTO_KO_1_OLD" value="{/Meddicc/INICIO/MEDDICC/LINEAS/LINEA[@Siglas='M']/TEXTO_KO}"/>
                    <xsl:choose>
                        <xsl:when test="/Meddicc/INICIO/COMERCIAL">
                            <tr>
                            <td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='metrics']/node()"/>:&nbsp;&nbsp;</td>
                            <td class="datosLeft"><textarea cols="40" rows="3" name="TEXTO_OK_1" id="TEXTO_OK_1"><xsl:copy-of select="/Meddicc/INICIO/MEDDICC/LINEAS/LINEA[@Siglas='M']/TEXTO_OK/node()"/></textarea></td>
                            <td class="datosLeft"><textarea cols="40" rows="3" name="TEXTO_IN_1" id="TEXTO_IN_1"><xsl:copy-of select="/Meddicc/INICIO/MEDDICC/LINEAS/LINEA[@Siglas='M']/TEXTO_IN/node()"/></textarea></td>
                            <td class="datosLeft"><textarea cols="40" rows="3" name="TEXTO_KO_1" id="TEXTO_KO_1"><xsl:copy-of select="/Meddicc/INICIO/MEDDICC/LINEAS/LINEA[@Siglas='M']/TEXTO_KO/node()"/></textarea></td>
                            <td align="center">&nbsp;</td>
                            <td>&nbsp;</td>
                            </tr>
                        </xsl:when>
                        <xsl:otherwise>
                            <tr class="subTareasTot">
                            <td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='metrics']/node()"/>:&nbsp;&nbsp;</td>
                            <td class="datosLeft"><xsl:copy-of select="/Meddicc/INICIO/MEDDICC/LINEAS/LINEA[@Siglas='M']/TEXTO_OK/node()"/></td>
                            <td class="datosLeft"><xsl:copy-of select="/Meddicc/INICIO/MEDDICC/LINEAS/LINEA[@Siglas='M']/TEXTO_IN/node()"/></td>
                            <td class="datosLeft"><xsl:copy-of select="/Meddicc/INICIO/MEDDICC/LINEAS/LINEA[@Siglas='M']/TEXTO_KO/node()"/></td>
                            <td align="center">&nbsp;</td>
                            <td>&nbsp;</td>
                            </tr>
                        </xsl:otherwise>
                    </xsl:choose>

                    <!--EB-->
                    <input type="hidden" name="TEXTO_OK_2_OLD" value="{/Meddicc/INICIO/MEDDICC/LINEAS/LINEA[@Siglas='EB']/TEXTO_OK}"/>
                    <input type="hidden" name="TEXTO_IN_2_OLD" value="{/Meddicc/INICIO/MEDDICC/LINEAS/LINEA[@Siglas='EB']/TEXTO_IN}"/>
                    <input type="hidden" name="TEXTO_KO_2_OLD" value="{/Meddicc/INICIO/MEDDICC/LINEAS/LINEA[@Siglas='EB']/TEXTO_KO}"/>
                    <xsl:choose>
                        <xsl:when test="/Meddicc/INICIO/COMERCIAL">
                            <tr>
                            <td class="labelRight">EB:&nbsp;&nbsp;</td>
                            <td class="datosLeft"><textarea cols="40" rows="3" name="TEXTO_OK_2" id="TEXTO_OK_2"><xsl:copy-of select="/Meddicc/INICIO/MEDDICC/LINEAS/LINEA[@Siglas='EB']/TEXTO_OK/node()"/></textarea></td>
                            <td class="datosLeft"><textarea cols="40" rows="3" name="TEXTO_IN_2" id="TEXTO_IN_2"><xsl:copy-of select="/Meddicc/INICIO/MEDDICC/LINEAS/LINEA[@Siglas='EB']/TEXTO_IN/node()"/></textarea></td>
                            <td class="datosLeft"><textarea cols="40" rows="3" name="TEXTO_KO_2" id="TEXTO_KO_2"><xsl:copy-of select="/Meddicc/INICIO/MEDDICC/LINEAS/LINEA[@Siglas='EB']/TEXTO_KO/node()"/></textarea></td>
                            <td align="center">&nbsp;</td>
                            <td class="nodisplay">&nbsp;</td>
                            </tr>
                        </xsl:when>
                        <xsl:otherwise>
                            <tr class="subTareasTot">
                            <td class="labelRight">EB:&nbsp;&nbsp;</td>
                            <td class="datosLeft"><xsl:copy-of select="/Meddicc/INICIO/MEDDICC/LINEAS/LINEA[@Siglas='EB']/TEXTO_OK/node()"/></td>
                            <td class="datosLeft"><xsl:copy-of select="/Meddicc/INICIO/MEDDICC/LINEAS/LINEA[@Siglas='EB']/TEXTO_IN/node()"/></td>
                            <td class="datosLeft"><xsl:copy-of select="/Meddicc/INICIO/MEDDICC/LINEAS/LINEA[@Siglas='EB']/TEXTO_KO/node()"/></td>
                            <td align="center">&nbsp;</td>
                            <td class="nodisplay">&nbsp;</td>
                            </tr>
                        </xsl:otherwise>
                    </xsl:choose>

                     <!--DP-->
                    <input type="hidden" name="TEXTO_OK_3_OLD" value="{/Meddicc/INICIO/MEDDICC/LINEAS/LINEA[@Siglas='DP']/TEXTO_OK}"/>
                    <input type="hidden" name="TEXTO_IN_3_OLD" value="{/Meddicc/INICIO/MEDDICC/LINEAS/LINEA[@Siglas='DP']/TEXTO_IN}"/>
                    <input type="hidden" name="TEXTO_KO_3_OLD" value="{/Meddicc/INICIO/MEDDICC/LINEAS/LINEA[@Siglas='DP']/TEXTO_KO}"/>
                    <xsl:choose>
                    <xsl:when test="/Meddicc/INICIO/COMERCIAL">
                        <tr>
                        <td class="labelRight">DP:&nbsp;&nbsp;</td>
                        <td class="datosLeft"><textarea cols="40" rows="3" name="TEXTO_OK_3" id="TEXTO_OK_3"><xsl:copy-of select="/Meddicc/INICIO/MEDDICC/LINEAS/LINEA[@Siglas='DP']/TEXTO_OK/node()"/></textarea></td>
                        <td class="datosLeft"><textarea cols="40" rows="3" name="TEXTO_IN_3" id="TEXTO_IN_3"><xsl:copy-of select="/Meddicc/INICIO/MEDDICC/LINEAS/LINEA[@Siglas='DP']/TEXTO_IN/node()"/></textarea></td>
                        <td class="datosLeft"><textarea cols="40" rows="3" name="TEXTO_KO_3" id="TEXTO_KO_3"><xsl:copy-of select="/Meddicc/INICIO/MEDDICC/LINEAS/LINEA[@Siglas='DP']/TEXTO_KO/node()"/></textarea></td>
                        <td align="center">&nbsp;</td>
                        <td class="nodisplay">&nbsp;</td>
                        </tr>
                    </xsl:when>
                    <xsl:otherwise>
                        <tr class="subTareasTot">
                        <td class="labelRight">DP:&nbsp;&nbsp;</td>
                        <td class="datosLeft"><xsl:copy-of select="/Meddicc/INICIO/MEDDICC/LINEAS/LINEA[@Siglas='DP']/TEXTO_OK/node()"/></td>
                        <td class="datosLeft"><xsl:copy-of select="/Meddicc/INICIO/MEDDICC/LINEAS/LINEA[@Siglas='DP']/TEXTO_IN/node()"/></td>
                        <td class="datosLeft"><xsl:copy-of select="/Meddicc/INICIO/MEDDICC/LINEAS/LINEA[@Siglas='DP']/TEXTO_KO/node()"/></td>
                        <td align="center">&nbsp;</td>
                        <td class="nodisplay">&nbsp;</td>
                        </tr>
                    </xsl:otherwise>
                    </xsl:choose>

					 <!--DC-->
                    <input type="hidden" name="TEXTO_OK_4_OLD" value="{/Meddicc/INICIO/MEDDICC/LINEAS/LINEA[@Siglas='DC']/TEXTO_OK}"/>
                    <input type="hidden" name="TEXTO_IN_4_OLD" value="{/Meddicc/INICIO/MEDDICC/LINEAS/LINEA[@Siglas='DC']/TEXTO_IN}"/>
                    <input type="hidden" name="TEXTO_KO_4_OLD" value="{/Meddicc/INICIO/MEDDICC/LINEAS/LINEA[@Siglas='DC']/TEXTO_KO}"/>
                    <xsl:choose>
                    <xsl:when test="/Meddicc/INICIO/COMERCIAL">
                        <tr>
                        <td class="labelRight">DC:&nbsp;&nbsp;</td>
                        <td class="datosLeft"><textarea cols="40" rows="3" name="TEXTO_OK_4" id="TEXTO_OK_4"><xsl:copy-of select="/Meddicc/INICIO/MEDDICC/LINEAS/LINEA[@Siglas='DC']/TEXTO_OK/node()"/></textarea></td>
                        <td class="datosLeft"><textarea cols="40" rows="3" name="TEXTO_IN_4" id="TEXTO_IN_4"><xsl:copy-of select="/Meddicc/INICIO/MEDDICC/LINEAS/LINEA[@Siglas='DC']/TEXTO_IN/node()"/></textarea></td>
                        <td class="datosLeft"><textarea cols="40" rows="3" name="TEXTO_KO_4" id="TEXTO_KO_4"><xsl:copy-of select="/Meddicc/INICIO/MEDDICC/LINEAS/LINEA[@Siglas='DC']/TEXTO_KO/node()"/></textarea></td>
                        <td align="center">&nbsp;</td>
                        <td class="nodisplay">&nbsp;</td>
                        </tr>
                    </xsl:when>
                    <xsl:otherwise>
                        <tr class="subTareasTot">
                        <td>DC</td>
                        <td class="datosLeft"><xsl:copy-of select="/Meddicc/INICIO/MEDDICC/LINEAS/LINEA[@Siglas='DC']/TEXTO_OK/node()"/></td>
                        <td class="datosLeft"><xsl:copy-of select="/Meddicc/INICIO/MEDDICC/LINEAS/LINEA[@Siglas='DC']/TEXTO_IN/node()"/></td>
                        <td class="datosLeft"><xsl:copy-of select="/Meddicc/INICIO/MEDDICC/LINEAS/LINEA[@Siglas='DC']/TEXTO_KO/node()"/></td>
                        <td align="center">&nbsp;</td>
                        <td class="nodisplay">&nbsp;</td>
                        </tr>
                    </xsl:otherwise>
                    </xsl:choose>

                     <!--PaIn-->
                    <input type="hidden" name="TEXTO_OK_5_OLD" value="{/Meddicc/INICIO/MEDDICC/LINEAS/LINEA[@Siglas='I']/TEXTO_OK}"/>
                    <input type="hidden" name="TEXTO_IN_5_OLD" value="{/Meddicc/INICIO/MEDDICC/LINEAS/LINEA[@Siglas='I']/TEXTO_IN}"/>
                    <input type="hidden" name="TEXTO_KO_5_OLD" value="{/Meddicc/INICIO/MEDDICC/LINEAS/LINEA[@Siglas='I']/TEXTO_KO}"/>
                    <xsl:choose>
                    <xsl:when test="/Meddicc/INICIO/COMERCIAL">
                        <tr>
                        <td class="labelRight">PaIn:&nbsp;&nbsp;</td>
                        <td class="datosLeft"><textarea cols="40" rows="3" name="TEXTO_OK_5" id="TEXTO_OK_5"><xsl:copy-of select="/Meddicc/INICIO/MEDDICC/LINEAS/LINEA[@Siglas='I']/TEXTO_OK/node()"/></textarea></td>
                        <td class="datosLeft"><textarea cols="40" rows="3" name="TEXTO_IN_5" id="TEXTO_IN_5"><xsl:copy-of select="/Meddicc/INICIO/MEDDICC/LINEAS/LINEA[@Siglas='I']/TEXTO_IN/node()"/></textarea></td>
                        <td class="datosLeft"><textarea cols="40" rows="3" name="TEXTO_KO_5" id="TEXTO_KO_5"><xsl:copy-of select="/Meddicc/INICIO/MEDDICC/LINEAS/LINEA[@Siglas='I']/TEXTO_KO/node()"/></textarea></td>
                        <td align="center">&nbsp;</td>
                        <td class="nodisplay">&nbsp;</td>
                        </tr>
                    </xsl:when>
                    <xsl:otherwise>
                        <tr class="subTareasTot">
                        <td class="labelRight">PaIn:&nbsp;&nbsp;</td>
                        <td class="datosLeft"><xsl:copy-of select="/Meddicc/INICIO/MEDDICC/LINEAS/LINEA[@Siglas='I']/TEXTO_OK/node()"/></td>
                        <td class="datosLeft"><xsl:copy-of select="/Meddicc/INICIO/MEDDICC/LINEAS/LINEA[@Siglas='I']/TEXTO_IN/node()"/></td>
                        <td class="datosLeft"><xsl:copy-of select="/Meddicc/INICIO/MEDDICC/LINEAS/LINEA[@Siglas='I']/TEXTO_KO/node()"/></td>
                        <td align="center">&nbsp;</td>
                        <td class="nodisplay">&nbsp;</td>
                        </tr>
                    </xsl:otherwise>
                    </xsl:choose>

                     <!--Ch-->
                    <input type="hidden" name="TEXTO_OK_6_OLD" value="{/Meddicc/INICIO/MEDDICC/LINEAS/LINEA[@Siglas='Ch']/TEXTO_OK}"/>
                    <input type="hidden" name="TEXTO_IN_6_OLD" value="{/Meddicc/INICIO/MEDDICC/LINEAS/LINEA[@Siglas='Ch']/TEXTO_IN}"/>
                    <input type="hidden" name="TEXTO_KO_6_OLD" value="{/Meddicc/INICIO/MEDDICC/LINEAS/LINEA[@Siglas='Ch']/TEXTO_KO}"/>
                    <xsl:choose>
                    <xsl:when test="/Meddicc/INICIO/COMERCIAL">
                        <tr>
                        <td class="labelRight">Ch:&nbsp;&nbsp;</td>
                        <td class="datosLeft"><textarea cols="40" rows="3" name="TEXTO_OK_6" id="TEXTO_OK_6"><xsl:copy-of select="/Meddicc/INICIO/MEDDICC/LINEAS/LINEA[@Siglas='Ch']/TEXTO_OK/node()"/></textarea></td>
                        <td class="datosLeft"><textarea cols="40" rows="3" name="TEXTO_IN_6" id="TEXTO_IN_6"><xsl:copy-of select="/Meddicc/INICIO/MEDDICC/LINEAS/LINEA[@Siglas='Ch']/TEXTO_IN/node()"/></textarea></td>
                        <td class="datosLeft"><textarea cols="40" rows="3" name="TEXTO_KO_6" id="TEXTO_KO_6"><xsl:copy-of select="/Meddicc/INICIO/MEDDICC/LINEAS/LINEA[@Siglas='Ch']/TEXTO_KO/node()"/></textarea></td>
                        <td align="center">&nbsp;</td>
                        <td class="nodisplay">&nbsp;</td>
                        </tr>
                    </xsl:when>
                    <xsl:otherwise>
                        <tr class="subTareasTot">
                        <td class="labelRight">Ch:&nbsp;&nbsp;</td>
                        <td class="datosLeft"><xsl:copy-of select="/Meddicc/INICIO/MEDDICC/LINEAS/LINEA[@Siglas='Ch']/TEXTO_OK/node()"/></td>
                        <td class="datosLeft"><xsl:copy-of select="/Meddicc/INICIO/MEDDICC/LINEAS/LINEA[@Siglas='Ch']/TEXTO_IN/node()"/></td>
                        <td class="datosLeft"><xsl:copy-of select="/Meddicc/INICIO/MEDDICC/LINEAS/LINEA[@Siglas='Ch']/TEXTO_KO/node()"/></td>
                        <td align="center">&nbsp;</td>
                        <td class="nodisplay">&nbsp;</td>
                        </tr>
                    </xsl:otherwise>
                    </xsl:choose>

                     <!--Co-->
                    <input type="hidden" name="TEXTO_OK_7_OLD" value="{/Meddicc/INICIO/MEDDICC/LINEAS/LINEA[@Siglas='Co']/TEXTO_OK}"/>
                    <input type="hidden" name="TEXTO_IN_7_OLD" value="{/Meddicc/INICIO/MEDDICC/LINEAS/LINEA[@Siglas='Co']/TEXTO_IN}"/>
                    <input type="hidden" name="TEXTO_KO_7_OLD" value="{/Meddicc/INICIO/MEDDICC/LINEAS/LINEA[@Siglas='Co']/TEXTO_KO}"/>
                    <xsl:choose>
                    <xsl:when test="/Meddicc/INICIO/COMERCIAL">
                        <tr>
                        <td class="labelRight">Co:&nbsp;&nbsp;</td>
                        <td class="datosLeft"><textarea cols="40" rows="3" name="TEXTO_OK_7" id="TEXTO_OK_7"><xsl:copy-of select="/Meddicc/INICIO/MEDDICC/LINEAS/LINEA[@Siglas='Co']/TEXTO_OK/node()"/></textarea></td>
                        <td class="datosLeft"><textarea cols="40" rows="3" name="TEXTO_IN_7" id="TEXTO_IN_7"><xsl:copy-of select="/Meddicc/INICIO/MEDDICC/LINEAS/LINEA[@Siglas='Co']/TEXTO_IN/node()"/></textarea></td>
                        <td class="datosLeft"><textarea cols="40" rows="3" name="TEXTO_KO_7" id="TEXTO_KO_7"><xsl:copy-of select="/Meddicc/INICIO/MEDDICC/LINEAS/LINEA[@Siglas='Co']/TEXTO_KO/node()"/></textarea></td>
                        <td align="center">&nbsp;</td>
                        <td class="nodisplay">&nbsp;</td>
                        </tr>
                    </xsl:when>
                    <xsl:otherwise>
                        <tr class="subTareasTot">
                        <td class="labelRight">Co:&nbsp;&nbsp;</td>
                        <td class="datosLeft"><xsl:copy-of select="/Meddicc/INICIO/MEDDICC/LINEAS/LINEA[@Siglas='Co']/TEXTO_OK/node()"/></td>
                        <td class="datosLeft"><xsl:copy-of select="/Meddicc/INICIO/MEDDICC/LINEAS/LINEA[@Siglas='Co']/TEXTO_IN/node()"/></td>
                        <td class="datosLeft"><xsl:copy-of select="/Meddicc/INICIO/MEDDICC/LINEAS/LINEA[@Siglas='Co']/TEXTO_KO/node()"/></td>
                        <td align="center">&nbsp;</td>
                        <td class="nodisplay">&nbsp;</td>
                        </tr>
                    </xsl:otherwise>
                    </xsl:choose>

                     <!--Comentarios-->
                    <input type="hidden" name="TEXTO_OK_8_OLD" value="{/Meddicc/INICIO/MEDDICC/LINEAS/LINEA[@Siglas='Ex']/TEXTO_OK}"/>
                    <input type="hidden" name="TEXTO_IN_8_OLD" value="{/Meddicc/INICIO/MEDDICC/LINEAS/LINEA[@Siglas='Ex']/TEXTO_IN}"/>
                    <input type="hidden" name="TEXTO_KO_8_OLD" value="{/Meddicc/INICIO/MEDDICC/LINEAS/LINEA[@Siglas='Ex']/TEXTO_KO}"/>
                    <xsl:choose>
                    <xsl:when test="/Meddicc/INICIO/COMERCIAL">
                        <tr>
                        <td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='comentarios']/node()"/>:&nbsp;&nbsp;</td>
                        <td class="datosLeft"><textarea cols="40" rows="3" name="TEXTO_OK_8" id="TEXTO_OK_8"><xsl:copy-of select="/Meddicc/INICIO/MEDDICC/LINEAS/LINEA[@Siglas='Ex']/TEXTO_OK/node()"/></textarea></td>
                        <td class="datosLeft"><textarea cols="40" rows="3" name="TEXTO_IN_8" id="TEXTO_IN_8"><xsl:copy-of select="/Meddicc/INICIO/MEDDICC/LINEAS/LINEA[@Siglas='Ex']/TEXTO_IN/node()"/></textarea></td>
                        <td class="datosLeft"><textarea cols="40" rows="3" name="TEXTO_KO_8" id="TEXTO_KO_8"><xsl:copy-of select="/Meddicc/INICIO/MEDDICC/LINEAS/LINEA[@Siglas='Ex']/TEXTO_KO/node()"/></textarea></td>
                        <td align="center">&nbsp;</td>
                        <td class="nodisplay">&nbsp;</td>
                        </tr>
                    </xsl:when>
                    <xsl:otherwise>
                        <tr class="subTareasTot">
                        <td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='comentarios']/node()"/>:&nbsp;&nbsp;</td>
                        <td class="datosLeft"><xsl:copy-of select="/Meddicc/INICIO/MEDDICC/LINEAS/LINEA[@Siglas='Ex']/TEXTO_OK/node()"/></td>
                        <td class="datosLeft"><xsl:copy-of select="/Meddicc/INICIO/MEDDICC/LINEAS/LINEA[@Siglas='Ex']/TEXTO_IN/node()"/></td>
                        <td class="datosLeft"><xsl:copy-of select="/Meddicc/INICIO/MEDDICC/LINEAS/LINEA[@Siglas='Ex']/TEXTO_KO/node()"/></td>
                        <td align="center">&nbsp;</td>
                        <td class="nodisplay">&nbsp;</td>
                        </tr>
                    </xsl:otherwise>
                    </xsl:choose>

                     <!--Next step-->
                    <input type="hidden" name="TEXTO_OK_9_OLD" value="{/Meddicc/INICIO/MEDDICC/LINEAS/LINEA[@Siglas='Nx']/TEXTO_OK}"/>
                    <input type="hidden" name="TEXTO_IN_9_OLD" value="{/Meddicc/INICIO/MEDDICC/LINEAS/LINEA[@Siglas='Nx']/TEXTO_IN}"/>
                    <input type="hidden" name="TEXTO_KO_9_OLD" value="{/Meddicc/INICIO/MEDDICC/LINEAS/LINEA[@Siglas='Nx']/TEXTO_KO}"/>
                        <xsl:choose>
                        <xsl:when test="/Meddicc/INICIO/COMERCIAL">
                            <tr>
                            <td class="labelRight">Next Step:&nbsp;&nbsp;</td>
                            <td class="datosLeft"><textarea cols="40" rows="3" name="TEXTO_OK_9" id="TEXTO_OK_9"><xsl:copy-of select="/Meddicc/INICIO/MEDDICC/LINEAS/LINEA[@Siglas='Nx']/TEXTO_OK/node()"/></textarea></td>
                            <td class="datosLeft"><textarea cols="40" rows="3" name="TEXTO_IN_9" id="TEXTO_IN_9"><xsl:copy-of select="/Meddicc/INICIO/MEDDICC/LINEAS/LINEA[@Siglas='Nx']/TEXTO_IN/node()"/></textarea></td>
                            <td class="datosLeft"><textarea cols="40" rows="3" name="TEXTO_KO_9" id="TEXTO_KO_9"><xsl:copy-of select="/Meddicc/INICIO/MEDDICC/LINEAS/LINEA[@Siglas='Nx']/TEXTO_KO/node()"/></textarea></td>
                            <td align="center">&nbsp;</td>
                            <td class="nodisplay">&nbsp;</td>
                            </tr>
                        </xsl:when>
                        <xsl:otherwise>
                            <tr class="subTareasTot">
                            <td class="labelRight">Next Step:&nbsp;&nbsp;</td>
                            <td class="datosLeft"><xsl:copy-of select="/Meddicc/INICIO/MEDDICC/LINEAS/LINEA[@Siglas='Nx']/TEXTO_OK/node()"/></td>
                            <td class="datosLeft"><xsl:copy-of select="/Meddicc/INICIO/MEDDICC/LINEAS/LINEA[@Siglas='Nx']/TEXTO_IN/node()"/></td>
                            <td class="datosLeft"><xsl:copy-of select="/Meddicc/INICIO/MEDDICC/LINEAS/LINEA[@Siglas='Nx']/TEXTO_KO/node()"/></td>
                            <td align="center">&nbsp;</td>
                            <td class="nodisplay">&nbsp;</td>
                            </tr>
                        </xsl:otherwise>
                        </xsl:choose>

                    <tr class="subTituloTabla">
						<td><xsl:value-of select="document($doc)/translation/texts/item[@name='linea']/node()"/></td>
						<td><xsl:value-of select="document($doc)/translation/texts/item[@name='ok']/node()"/></td>
						<td>?</td>
						<td><xsl:value-of select="document($doc)/translation/texts/item[@name='red_flag']/node()"/></td>
						<td>
						<!--
                        	<xsl:if test="/Meddicc/INICIO/COMERCIAL">
                                    <div class="botonLargo ">
                                    <strong>
                                        <a href="javascript:GuardarTodo();"><xsl:value-of select="document($doc)/translation/texts/item[@name='guardar']/node()"/></a>
                                    </strong>
                                    </div>
                                </xsl:if>
						-->
                        </td>
                        <td>&nbsp;</td>
					</tr>
				</table>

			<br/>
			<br/>
		</xsl:otherwise>
	</xsl:choose>
</div>
    <input type="hidden" name="ESTADO_OBLI" value="{document($doc)/translation/texts/item[@name='estado_obligatorio']/node()}"/>
    </form>
</body>
</html>
</xsl:template>
</xsl:stylesheet>
