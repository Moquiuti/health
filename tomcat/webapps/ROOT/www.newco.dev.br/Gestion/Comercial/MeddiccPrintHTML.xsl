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
	<!--<script type="text/javascript" src="http://www.newco.dev.br/Gestion/Comercial/meddicc_020513.js"></script>-->
</head>

<!--<body onload="javascript:window.print();">-->
<body>
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
                     
	</xsl:when>
	<xsl:otherwise>

		<!--	Titulo de la página		-->
		<div class="ZonaTituloPagina">
			<p class="Path"><xsl:value-of select="document($doc)/translation/texts/item[@name='Inicio']/node()"/>&nbsp;/&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='meddicc']/node()"/>&nbsp;/&nbsp;<span class="FinPath"><xsl:value-of select="document($doc)/translation/texts/item[@name='empresa']/node()"/>&nbsp;</span></p>
			<p class="TituloPagina">
				<xsl:value-of select="/Meddicc/INICIO/MEDDICC/EMPRESA/NOMBRE" disable-output-escaping="yes"/>
                <!--desplegable estado solo si empresa informada-->
                <xsl:if test="/Meddicc/INICIO/MEDDICC/ESTADO">
                    <xsl:text>.&nbsp;</xsl:text>
                    <xsl:value-of select="document($doc)/translation/texts/item[@name='estado']/node()"/>:&nbsp;<xsl:value-of select="/Meddicc/INICIO/MEDDICC/EMPRESA/NOMBREESTADO" disable-output-escaping="yes"/>
                </xsl:if>
				<span class="CompletarTitulo" style="width:300px;">
					<a class="btnNormal" href="javascript:window.close();" style="text-decoration:none;">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='cerrar']/node()"/>
					</a>
					&nbsp;
					<a class="btnNormal" href="javascript:window.print();'" style="text-decoration:none;">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='imprimir']/node()"/>
					</a>
					&nbsp;
				</span>
			</p>
		</div>
		<br/>
		<br/>
		<br/>
		
		<!--                    
		<h1 class="titlePage" style="float:left;width:60%;padding-left:20%;">
                    <xsl:value-of select="document($doc)/translation/texts/item[@name='meddicc']/node()"/>: 
                    [&nbsp;<xsl:value-of select="/Meddicc/INICIO/EMPRESAS/field/dropDownList/listElem[ID = ../../@current]/listItem"/>&nbsp;]
                    
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
                    
                </h1>
                <h1 class="titlePage" style="float:left;width:20%;">
                    <xsl:if test="/Meddicc/INICIO/MVM or /Meddicc/INICIO/MVMB or /Meddicc/INICIO/ADMIN"><span style="float:right; padding:5px;" class="amarillo">EMP_ID: <xsl:value-of select="/Meddicc/INICIO/EMPRESAS/field/@current"/></span></xsl:if>
                </h1>
		-->
				

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
                <td class="dos">&nbsp;</td>
				<td class="treinta">?</td>
                <td class="dos">&nbsp;</td>
				<td class="treinta"><xsl:value-of select="document($doc)/translation/texts/item[@name='red_flag']/node()"/></td>
            	<td>&nbsp;</td>
            	<td>&nbsp;</td>
			</tr>

				<!--	Lineas del MEDDICC	-->
				<tr class="subTareasTot">
					<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='metrics']/node()"/>:&nbsp;&nbsp;</td>
					<td class="datosLeft"><xsl:copy-of select="/Meddicc/INICIO/MEDDICC/LINEAS/LINEA[@Siglas='M']/TEXTO_OK/node()"/></td>
					<td>&nbsp;</td>
					<td class="datosLeft"><xsl:copy-of select="/Meddicc/INICIO/MEDDICC/LINEAS/LINEA[@Siglas='M']/TEXTO_IN/node()"/></td>
					<td>&nbsp;</td>
					<td class="datosLeft"><xsl:copy-of select="/Meddicc/INICIO/MEDDICC/LINEAS/LINEA[@Siglas='M']/TEXTO_KO/node()"/></td>
					<td align="center">&nbsp;</td>
					<td>&nbsp;</td>
				</tr>
				<!--EB-->
				<tr class="subTareasTot">
					<td class="labelRight">EB:&nbsp;&nbsp;</td>
					<td class="datosLeft"><xsl:copy-of select="/Meddicc/INICIO/MEDDICC/LINEAS/LINEA[@Siglas='EB']/TEXTO_OK/node()"/></td>
					<td>&nbsp;</td>
					<td class="datosLeft"><xsl:copy-of select="/Meddicc/INICIO/MEDDICC/LINEAS/LINEA[@Siglas='EB']/TEXTO_IN/node()"/></td>
					<td>&nbsp;</td>
					<td class="datosLeft"><xsl:copy-of select="/Meddicc/INICIO/MEDDICC/LINEAS/LINEA[@Siglas='EB']/TEXTO_KO/node()"/></td>
					<td align="center">&nbsp;</td>
					<td class="nodisplay">&nbsp;</td>
				</tr>

				<!--DP-->
				<tr class="subTareasTot">
					<td class="labelRight">DP:&nbsp;&nbsp;</td>
					<td class="datosLeft"><xsl:copy-of select="/Meddicc/INICIO/MEDDICC/LINEAS/LINEA[@Siglas='DP']/TEXTO_OK/node()"/></td>
					<td>&nbsp;</td>
					<td class="datosLeft">
    					<xsl:copy-of select="/Meddicc/INICIO/MEDDICC/LINEAS/LINEA[@Siglas='DP']/TEXTO_IN/node()"/>
					</td>
					<td>&nbsp;</td>
					<td class="datosLeft"><xsl:copy-of select="/Meddicc/INICIO/MEDDICC/LINEAS/LINEA[@Siglas='DP']/TEXTO_KO/node()"/></td>
					<td align="center">&nbsp;</td>
					<td class="nodisplay">&nbsp;</td>
				</tr>

				<!--DC-->
				<tr class="subTareasTot">
					<td class="labelRight">DC:&nbsp;&nbsp;</td>
					<td class="datosLeft"><xsl:copy-of select="/Meddicc/INICIO/MEDDICC/LINEAS/LINEA[@Siglas='DC']/TEXTO_OK/node()"/></td>
					<td>&nbsp;</td>
					<td class="datosLeft"><xsl:copy-of select="/Meddicc/INICIO/MEDDICC/LINEAS/LINEA[@Siglas='DC']/TEXTO_IN/node()"/></td>
					<td>&nbsp;</td>
					<td class="datosLeft"><xsl:copy-of select="/Meddicc/INICIO/MEDDICC/LINEAS/LINEA[@Siglas='DC']/TEXTO_KO/node()"/></td>
					<td align="center">&nbsp;</td>
					<td class="nodisplay">&nbsp;</td>
				</tr>
				<!--PaIn-->
				<tr class="subTareasTot">
					<td class="labelRight">PaIn:&nbsp;&nbsp;</td>
					<td class="datosLeft"><xsl:copy-of select="/Meddicc/INICIO/MEDDICC/LINEAS/LINEA[@Siglas='I']/TEXTO_OK/node()"/></td>
					<td>&nbsp;</td>
					<td class="datosLeft"><xsl:copy-of select="/Meddicc/INICIO/MEDDICC/LINEAS/LINEA[@Siglas='I']/TEXTO_IN/node()"/></td>
					<td>&nbsp;</td>
					<td class="datosLeft"><xsl:copy-of select="/Meddicc/INICIO/MEDDICC/LINEAS/LINEA[@Siglas='I']/TEXTO_KO/node()"/></td>
					<td align="center">&nbsp;</td>
					<td class="nodisplay">&nbsp;</td>
				</tr>
				<!--Ch-->
				<tr class="subTareasTot">
					<td class="labelRight">Ch:&nbsp;&nbsp;</td>
					<td class="datosLeft"><xsl:copy-of select="/Meddicc/INICIO/MEDDICC/LINEAS/LINEA[@Siglas='Ch']/TEXTO_OK/node()"/></td>
					<td>&nbsp;</td>
					<td class="datosLeft"><xsl:copy-of select="/Meddicc/INICIO/MEDDICC/LINEAS/LINEA[@Siglas='Ch']/TEXTO_IN/node()"/></td>
					<td>&nbsp;</td>
					<td class="datosLeft"><xsl:copy-of select="/Meddicc/INICIO/MEDDICC/LINEAS/LINEA[@Siglas='Ch']/TEXTO_KO/node()"/></td>
					<td align="center">&nbsp;</td>
					<td class="nodisplay">&nbsp;</td>
				</tr>
				<!--Co-->

				<tr class="subTareasTot">
					<td class="labelRight">Co:&nbsp;&nbsp;</td>
					<td class="datosLeft"><xsl:copy-of select="/Meddicc/INICIO/MEDDICC/LINEAS/LINEA[@Siglas='Co']/TEXTO_OK/node()"/></td>
					<td>&nbsp;</td>
					<td class="datosLeft"><xsl:copy-of select="/Meddicc/INICIO/MEDDICC/LINEAS/LINEA[@Siglas='Co']/TEXTO_IN/node()"/></td>
					<td>&nbsp;</td>
					<td class="datosLeft"><xsl:copy-of select="/Meddicc/INICIO/MEDDICC/LINEAS/LINEA[@Siglas='Co']/TEXTO_KO/node()"/></td>
					<td align="center">&nbsp;</td>
					<td class="nodisplay">&nbsp;</td>
				</tr>

				<!--Comentarios-->

				<tr class="subTareasTot">
					<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='comentarios']/node()"/>:&nbsp;&nbsp;</td>
					<td class="datosLeft"><xsl:copy-of select="/Meddicc/INICIO/MEDDICC/LINEAS/LINEA[@Siglas='Ex']/TEXTO_OK/node()"/></td>
					<td>&nbsp;</td>
					<td class="datosLeft"><xsl:copy-of select="/Meddicc/INICIO/MEDDICC/LINEAS/LINEA[@Siglas='Ex']/TEXTO_IN/node()"/></td>
					<td>&nbsp;</td>
					<td class="datosLeft"><xsl:copy-of select="/Meddicc/INICIO/MEDDICC/LINEAS/LINEA[@Siglas='Ex']/TEXTO_KO/node()"/></td>
					<td align="center">&nbsp;</td>
					<td class="nodisplay">&nbsp;</td>
				</tr>

				<!--Next step-->

				<tr class="subTareasTot">
					<td class="labelRight">Next Step:&nbsp;&nbsp;</td>
					<td class="datosLeft"><xsl:copy-of select="/Meddicc/INICIO/MEDDICC/LINEAS/LINEA[@Siglas='Nx']/TEXTO_OK/node()"/></td>
					<td>&nbsp;</td>
					<td class="datosLeft"><xsl:copy-of select="/Meddicc/INICIO/MEDDICC/LINEAS/LINEA[@Siglas='Nx']/TEXTO_IN/node()"/></td>
					<td>&nbsp;</td>
					<td class="datosLeft"><xsl:copy-of select="/Meddicc/INICIO/MEDDICC/LINEAS/LINEA[@Siglas='Nx']/TEXTO_KO/node()"/></td>
					<td align="center">&nbsp;</td>
					<td class="nodisplay">&nbsp;</td>
				</tr>

				<tr class="subTituloTabla">
					<td><xsl:value-of select="document($doc)/translation/texts/item[@name='linea']/node()"/>:&nbsp;&nbsp;</td>
					<td><xsl:value-of select="document($doc)/translation/texts/item[@name='ok']/node()"/></td>
					<td>&nbsp;</td>
					<td>?</td>
					<td>&nbsp;</td>
					<td><xsl:value-of select="document($doc)/translation/texts/item[@name='red_flag']/node()"/></td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
				</tr>
			</table>
			
		</xsl:otherwise>
	</xsl:choose>
</div>
 
</body>
</html>
</xsl:template>
</xsl:stylesheet>
