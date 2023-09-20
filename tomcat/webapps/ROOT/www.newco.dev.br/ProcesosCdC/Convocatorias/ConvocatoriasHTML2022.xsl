<?xml version="1.0" encoding="iso-8859-1"?>
<!--
	Buscador/Listado de convocatorias
	Ultima revision ET 07abr22 11:20. Convocatorias2022_070422.js
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:import href = "http://www.newco.dev.br/General/General.xsl"/>
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
		<xsl:when test="/Convocatorias/LANG"><xsl:value-of select="/Convocatorias/LANG" /></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
	</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<title><xsl:value-of select="document($doc)/translation/texts/item[@name='Convocatorias']/node()"/>:&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Proveedores']/node()"/></title>

	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->

	<!--	11ene22 nuevos estilos -->
	<!--<link rel="stylesheet" href="http://www.newco.dev.br/General/basicMVM2022.css"/>-->
	<link href='http://fonts.googleapis.com/css?family=Roboto' rel='stylesheet'/>
	<!--	11ene22 nuevos estilos -->

	<script src="http://www.newco.dev.br/General/jquery-3.6.0.js"></script>	
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic2022_010822.js"></script>
	<!--<script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>-->
	<script type="text/javascript" src="http://www.newco.dev.br/ProcesosCdC/Convocatorias/Convocatorias2022_070422.js"></script>
	<script type="text/javascript">
		var alrt_errorDescargaFichero	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='error_descarga_fichero']/node()"/>';
	</script>
</head>

<body class="gris">
<xsl:choose>
<xsl:when test="/Convocatorias/SESION_CADUCADA">
	<xsl:for-each select="/Productos/SESION_CADUCADA">
		<xsl:if test="position()=last()">
			<xsl:apply-templates select="."/>
		</xsl:if>
	</xsl:for-each>
</xsl:when>
<xsl:when test="//xsql-error">
	<xsl:apply-templates select="//xsql-error"/>
</xsl:when>
<xsl:otherwise>
	<xsl:choose>
	<xsl:when test="//SESION_CADUCADA">
		<xsl:apply-templates select="//SESION_CADUCADA"/>
	</xsl:when>
	<xsl:when test="//Sorry">
		<xsl:apply-templates select="//Sorry"/>
	</xsl:when>
	<xsl:otherwise>

    <!--idioma-->
	<xsl:variable name="lang">
	<xsl:choose>
		<xsl:when test="/Productos/LANG"><xsl:value-of select="/Productos/LANG" /></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
	</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
    <!--idioma fin-->
	
	<!--	Titulo de la página		-->
	<div class="ZonaTituloPagina">
		<p class="TituloPagina">
			<xsl:value-of select="document($doc)/translation/texts/item[@name='Convocatorias']/node()"/>&nbsp;
			<span class="fuentePeq">
				(<xsl:copy-of select="document($doc)/translation/texts/item[@name='pagina']/node()"/>&nbsp;
				<xsl:value-of select="/Convocatorias/CONVOCATORIAS/PAGINA_ACTUAL"/>&nbsp;
				<xsl:copy-of select="document($doc)/translation/texts/item[@name='de']/node()"/>&nbsp;
				<xsl:value-of select="/Convocatorias/CONVOCATORIAS/TOTAL_PAGINAS"/>)
			</span>
			<span class="CompletarTitulo">
				<xsl:if test="/Convocatorias/CONVOCATORIAS/ROL='COMPRADOR'">
				<a class="btnNormal" href="javascript:chConvocatoria('')"><xsl:value-of select="document($doc)/translation/texts/item[@name='nueva']/node()"/></a>&nbsp;
				<a class="btnNormal" href="javascript:chLicitaciones();">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='Licitaciones']/node()"/>
				</a>&nbsp;
				</xsl:if>
				<!--	Botones	anterior y siguiente-->
				<xsl:if test="/Convocatorias/CONVOCATORIAS/ANTERIOR">
					<a class="btnNormal" href="javascript:PaginaAnterior();"><xsl:value-of select="document($doc)/translation/texts/item[@name='anterior']/node()"/></a>&nbsp;
				</xsl:if>
				<xsl:if test="/Convocatorias/CONVOCATORIAS/SIGUIENTE">
					<a class="btnNormal" href="javascript:PaginaSiguiente();"><xsl:value-of select="document($doc)/translation/texts/item[@name='siguiente']/node()"/></a>&nbsp;
				</xsl:if>
			</span>
		</p>
	</div>
	<br/>
	<br/>
	<br/>
	
	
	<div class="divLeft">
		<form name="Procedimiento" method="post" action="http://www.newco.dev.br/ProcesosCdC/Convocatorias/Convocatorias2022.xsql">
		<input type="hidden" name="PAGINA" value="{/Convocatorias/CONVOCATORIAS/PAGINA}"/>
		<input type="hidden" name="ORDEN" value="{/Convocatorias/CONVOCATORIAS/ORDEN}"/>
		<input type="hidden" name="SENTIDO" value="{/Convocatorias/CONVOCATORIAS/SENTIDO}"/>
		<input type="hidden" name="ACCION" value=""/>
		<input type="hidden" name="PARAMETROS" value=""/>
		<table cellspacing="6px" cellpadding="6px">
			<tr>
				<td class="w50px">&nbsp;</td>
				<td class="textLeft w300px">
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='texto']/node()"/>:&nbsp;</label>
					<input type="text" class="campopesquisa w300px" name="FTEXTO" id="FTEXTO">
						<xsl:attribute name="value"><xsl:value-of select="/Convocatorias/CONVOCATORIAS/FTEXTO"/></xsl:attribute>
					</input>&nbsp;&nbsp;
				</td>
				<td class="textLeft w140px">
					<label><xsl:copy-of select="document($doc)/translation/texts/item[@name='lineas_por_pagina']/node()"/>:&nbsp;</label>
					<xsl:call-template name="desplegable">
						<xsl:with-param name="path" select="/Convocatorias/CONVOCATORIAS/LINEASPORPAGINA/field"/>
            			<xsl:with-param name="claSel">w140px</xsl:with-param>
					</xsl:call-template>&nbsp;&nbsp;&nbsp;
				</td>
				<td class="textLeft w140px">
					<a class="btnDestacado" href="javascript:Buscar();">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='buscar']/node()"/>
					</a>
				</td>
				<td>&nbsp;</td>
			</tr>
		</table>
		</form>
		<BR/><BR/>
		<div class="tabela tabela_redonda">
		<table cellspacing="6px" cellpadding="6px">
			<thead class="cabecalho_tabela">
			<tr>
				<th class="w1px">&nbsp;</th>
				<th class="textLeft">&nbsp;<a href="javascript:Orden('CONVOCATORIA');"><xsl:value-of select="document($doc)/translation/texts/item[@name='Convocatoria']/node()"/></a></th>
				<th class="textLeft">&nbsp;<a href="javascript:Orden('CLIENTE');"><xsl:value-of select="document($doc)/translation/texts/item[@name='cliente']/node()"/></a></th>
				<th class="textLeft w50px">&nbsp;<a href="javascript:Orden('TIPO');"><xsl:value-of select="document($doc)/translation/texts/item[@name='tipo']/node()"/></a></th>
				<th class="textLeft">&nbsp;<a href="javascript:Orden('USUARIO');"><xsl:value-of select="document($doc)/translation/texts/item[@name='usuario']/node()"/></a></th>
				<th class="textLeft w1px">&nbsp;<a href="javascript:Orden('FECHA');"><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha']/node()"/></a></th>
				<th class="textLeft w1px">&nbsp;<a href="javascript:Orden('FECHADEC');"><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_decision_abbr']/node()"/></a></th>
				<th class="textLeft w1px" >&nbsp;<a href="javascript:Orden('NUMLIC');"><xsl:value-of select="document($doc)/translation/texts/item[@name='Licitaciones']/node()"/></a></th>
				<th class="textLeft w1px" >&nbsp;<a href="javascript:Orden('NUMPROV');"><xsl:value-of select="document($doc)/translation/texts/item[@name='Proveedores']/node()"/></a></th>
				<th class="textLeft w150px" >&nbsp;<a href="javascript:Orden('ESTADO');"><xsl:value-of select="document($doc)/translation/texts/item[@name='estado']/node()"/></a></th>
				<th>&nbsp;</th>
			</tr>
		</thead>
		<tbody class="corpo_tabela">
        <xsl:choose>
		<xsl:when test="/Convocatorias/CONVOCATORIAS/CONVOCATORIA">
			<xsl:for-each select="/Convocatorias/CONVOCATORIAS/CONVOCATORIA">
				<tr id="CONV_{LIC_CONV_ID}">
					<xsl:attribute name="class">
					<xsl:choose>
					<xsl:when test="IDESTADO='SUS'">conhover fondoRojo</xsl:when>
					<xsl:otherwise>conhover</xsl:otherwise>
					</xsl:choose>
					</xsl:attribute>
                    <td class="color_status"><xsl:value-of select="LINEA"/></td>
					<td class="textLeft">
						&nbsp;<a href="javascript:chConvocatoria({LIC_CONV_ID});">
							<strong><xsl:value-of select="LIC_CONV_NOMBRE"/></strong>
						</a>
					</td>
					<td class="textLeft">&nbsp;<strong><xsl:value-of select="CLIENTE"/></strong></td>
					<td>&nbsp;<xsl:value-of select="TIPO"/></td>
					<td class="textLeft">&nbsp;<xsl:value-of select="USUARIO"/></td>
					<td>&nbsp;<xsl:value-of select="FECHA"/></td>
					<td>&nbsp;<xsl:value-of select="FECHADECISION"/></td>
					<td class="datosRight"><strong><xsl:value-of select="NUMLICITACIONES"/></strong>&nbsp;</td>
					<td class="datosRight"><strong><xsl:value-of select="NUMPROVEEDORES"/></strong>&nbsp;</td>
					<td class="textLeft">&nbsp;<xsl:value-of select="ESTADOCOMPLETO"/></td>
					<td>&nbsp;</td>
				</tr>
			</xsl:for-each>
                </xsl:when>
		<xsl:otherwise>
			<tr><td colspan="11" align="center"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='no_se_han_encontrado_resultados']/node()"/></strong></td></tr>
		</xsl:otherwise>
		</xsl:choose>
		</tbody>
		<tfoot class="rodape_tabela">
			<tr><td colspan="11">&nbsp;</td></tr>
		</tfoot>
	</table><!--fin de infoTableAma-->
 	</div>
 	<br/>  
 	<br/>  
 	<br/>  
 	<br/>  
 	<br/>  
    </div><!--fin de divLeft-->
	</xsl:otherwise>
        </xsl:choose>
</xsl:otherwise>
</xsl:choose>
</body>
</html>
</xsl:template>
</xsl:stylesheet>
