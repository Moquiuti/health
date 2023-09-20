<?xml version="1.0" encoding="iso-8859-1"?>
<!--
	Listado/Buscador de Contratos
	Ultima revision: ET 13feb23 12:10
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:import href="http://www.newco.dev.br/General/General.xsl"/>
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="lang" select="@lang"/>
<xsl:param name="usuario" select="@US_ID"/>

<xsl:template match="/Contratos">

<!--	Todos los documentos HTML deben empezar con esto	-->
<xsl:text disable-output-escaping='yes'>&lt;!doctype html></xsl:text>

<html>
<head>
	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:choose>
			<xsl:when test="/Contratos/LANG"><xsl:value-of select="/Contratos/LANG"/></xsl:when>
			<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<META Http-Equiv="Cache-Control" Content="no-cache" />

	<title><xsl:value-of select="document($doc)/translation/texts/item[@name='Contratos']/node()"/></title>

	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->

	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery-3.6.0.js"></script>	
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic2022_010822.js"></script>
	<script type="text/javascript">
		function BuscarContratos()
		{
			SubmitForm(document.forms['Buscador']);
		}
		
		function NuevoContrato()
		{
			document.location="http://www.newco.dev.br/ProcesosCdC/Contratos/Contrato2022.xsql";
		}
				
		function ModelosContrato()
		{
			document.location="http://www.newco.dev.br/ProcesosCdC/Contratos/ModelosContrato2022.xsql";
		}
		
		function Contrato(IDContrato)
		{
			document.location="http://www.newco.dev.br/ProcesosCdC/Contratos/Contrato2022.xsql?CON_ID="+IDContrato;
		}
		
	</script>
</head>
<body>

<!--idioma-->
<xsl:variable name="lang">
	<xsl:choose>
		<xsl:when test="/Contratos/LANG"><xsl:value-of select="/Contratos/LANG"/></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
	</xsl:choose>
</xsl:variable>
<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
<!--idioma fin-->
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
                            <xsl:when test="/Contratos/LANG"><xsl:value-of select="/Contratos/LANG"/></xsl:when>
                            <xsl:otherwise>spanish</xsl:otherwise>
                    </xsl:choose>
            </xsl:variable>
            <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
            <!--idioma fin-->

		<xsl:variable name="usuario">
		<xsl:choose>
			<xsl:when test="not(CONTRATOS/OBSERVADOR) and Contratos/CDC">CDC</xsl:when>
			<xsl:otherwise>NORMAL</xsl:otherwise>
		</xsl:choose>
		</xsl:variable>

	<!--	Titulo de la página		-->
	<div class="ZonaTituloPagina">
		<p class="TituloPagina">
			<xsl:value-of select="document($doc)/translation/texts/item[@name='Contratos']/node()"/>&nbsp;&nbsp;
			&nbsp;&nbsp;
			<span class="CompletarTitulo" style="width:350px;">
                <xsl:if test="CONTRATOS/ROL='COMPRADOR'">
				<a class="btnDestacado" href="javascript:NuevoContrato()"> 
					<xsl:value-of select="document($doc)/translation/texts/item[@name='nuevo']/node()"/>
				</a>
				&nbsp;
				</xsl:if>
                <xsl:if test="CONTRATOS/ROL='COMPRADOR'">
				<a class="btnNormal" href="javascript:ModelosContrato()"> 
					<xsl:value-of select="document($doc)/translation/texts/item[@name='Modelos_contrato']/node()"/>
				</a>
				&nbsp;
				</xsl:if>
			</span>
		</p>
	</div>
	<br/>
	<br/>
	<br/>
	
		<form name="Buscador" method="post" action="Contratos2022.xsql">
		<table cellspacing="6px" cellpadding="6px">
			<tr class="filtros" height="50px">
				<th class="uno">&nbsp;</th>
				<xsl:choose>
				<xsl:when test="CONTRATOS/MVM or CONTRATOS/MVMB or CONTRATOS/ROL = 'VENDEDOR'">
					<th class="w200px textLeft">
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='empresa']/node()"/></label><br />
					<xsl:call-template name="desplegable">
						<xsl:with-param name="path" select="Contratos/FIDEMPRESA/field"/>
			            <xsl:with-param name="claSel">w200px</xsl:with-param>
					</xsl:call-template>
					</th>
				</xsl:when>
				<xsl:otherwise>
					<input type="hidden" name="FIDEMPRESA" value="-1" id="FIDEMPRESA"/>
				</xsl:otherwise>
				</xsl:choose>

				<th class="w200px textLeft">
				<xsl:choose>
				<xsl:when test="CONTRATOS/ROL = 'COMPRADOR' and CONTRATOS/CDC">
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='centro']/node()"/></label><br />
					<xsl:call-template name="desplegable">
                        <xsl:with-param name="path" select="CONTRATOS/FIDCENTRO/field"/>
			            <xsl:with-param name="claSel">w200px</xsl:with-param>
                    </xsl:call-template>
				</xsl:when>
				<xsl:when test="CONTRATOS/ROL != 'VENDEDOR'">
					<input type="hidden" name="FIDCENTRO" value="-1" id="FIDCENTRO"/>
				</xsl:when>
				<xsl:otherwise>
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='centro']/node()"/></label><br />
					<xsl:call-template name="desplegable">
						<xsl:with-param name="path" select="CONTRATOS/FIDCENTRO/field"/>
			            <xsl:with-param name="claSel">w200px</xsl:with-param>
					</xsl:call-template>
				</xsl:otherwise>
				</xsl:choose>
				</th>

				<th class="w140px textLeft">
				<xsl:choose>
				<xsl:when test="CONTRATOS/ROL = 'COMPRADOR' and CONTRATOS/CDC">
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='responsable']/node()"/></label><br />
					<xsl:call-template name="desplegable">
						<xsl:with-param name="path" select="CONTRATOS/FIDRESPONSABLE/field"/>
			            <xsl:with-param name="claSel">w140px</xsl:with-param>
					</xsl:call-template>
				</xsl:when>
				<xsl:when test="CONTRATOS/ROL != 'VENDEDOR'">
					<input type="hidden" name="FIDRESPONSABLE" value="-1" id="FIDRESPONSABLE"/>
				</xsl:when>
				<xsl:otherwise>
					<input type="hidden" name="FIDRESPONSABLE" value="-1" id="FIDRESPONSABLE"/>
				</xsl:otherwise>
				</xsl:choose>
				</th>

				<xsl:choose>
				<xsl:when test="CONTRATOS/ROL = 'COMPRADOR' and CONTRATOS/CDC and CONTRATOS/FIDPROVEEDOR/field/dropDownList/listElem"><!--12may22 solo si hay algun proveedor informado-->
					<th class="w140px textLeft">
						<label><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/></label><br />
						<xsl:call-template name="desplegable">
							<xsl:with-param name="path" select="CONTRATOS/FIDPROVEEDOR/field"/>
			            	<xsl:with-param name="claSel">w140px</xsl:with-param>
						</xsl:call-template>
					</th>
				</xsl:when>
				<xsl:when test="CONTRATOS/ROL != 'VENDEDOR'">
					<input type="hidden" name="FIDPROVEEDOR" value="-1" id="FIDPROVEEDOR"/>
				</xsl:when>
				<xsl:otherwise>
					<input type="hidden" name="FIDPROVEEDOR" value="-1" id="FIDPROVEEDOR"/>
				</xsl:otherwise>
				</xsl:choose>

				<th class="w140px textLeft">
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='texto']/node()"/></label><br />
					<input type="text" class="campopesquisa w150px" name="FTEXTO" id="FTEXTO">
						<xsl:attribute name="value"><xsl:value-of select="Contratos/FTEXTO"/></xsl:attribute>
					</input>
				</th>

				<th class="w140px textLeft">
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='estado']/node()"/></label><br />
					<xsl:call-template name="desplegable">
						<xsl:with-param name="path" select="CONTRATOS/FESTADO/field"/>
			            <xsl:with-param name="claSel">w140px</xsl:with-param>
					</xsl:call-template>
				</th>

				<th width="140px" class="textLeft">
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='plazo']/node()"/></label><br />
					<xsl:call-template name="desplegable">
						<xsl:with-param name="path" select="CONTRATOS/FPLAZO/field"/>
			            <xsl:with-param name="claSel">w140px</xsl:with-param>
					</xsl:call-template>
				</th>

				<th class="w140px textLeft">
					<br/>
					<a class="btnDestacado" href="javascript:BuscarContratos();">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='buscar']/node()"/>
					</a>
				</th>
				<th>&nbsp;</th>
			</tr>
		</table>
		</form>

		<div id="ContratoBorradoOK" style="display:none;background:#CEF6CE;padding:5px;width:400px;color:#7d7d7d;font-weight:bold;text-align:center;border:1px solid #01DF01;margin:10px auto;"><xsl:value-of select="document($doc)/translation/texts/item[@name='borrar_contrato_OK']/node()"/></div>
		<div id="ContratoBorradoKO" style="display:none;background:#F8E0E6;padding:5px;width:400px;color:#7d7d7d;font-weight:bold;text-align:center;border:1px solid red;margin:10px auto;"><xsl:value-of select="document($doc)/translation/texts/item[@name='borrar_contrato_KO']/node()"/></div>
		<div class="tabela tabela_redonda">
		<table cellspacing="6px" cellpadding="6px">
			<thead class="cabecalho_tabela">
			<tr>
				<th class="w1px"></th>
				<th class="w100px"><xsl:value-of select="document($doc)/translation/texts/item[@name='cod_abbr']/node()"/></th>
				<th class="w100px"><xsl:copy-of select="document($doc)/translation/texts/item[@name='fecha']/node()"/></th>
				<th class="w100px"><xsl:copy-of select="document($doc)/translation/texts/item[@name='Fecha_inicio']/node()"/></th>
				<th class="w100px"><xsl:copy-of select="document($doc)/translation/texts/item[@name='Fecha_final']/node()"/></th>
				<th class="textLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='cliente']/node()"/></th>
				<th class="textLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='centro_de_cliente']/node()"/></th>
				<th class="textLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='titulo']/node()"/></th>
				<th class="textLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/></th>
				<th class="textLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='responsable']/node()"/></th>
				<th class="w100px"><xsl:value-of select="document($doc)/translation/texts/item[@name='estado']/node()"/></th>
				<th class="w1px">&nbsp;</th>
			</tr>
		</thead>
		<!--	Cuerpo de la tabla	-->
		<tbody class="corpo_tabela">
        <xsl:choose>
		<xsl:when test="CONTRATOS/CONTRATO">
			<xsl:for-each select="CONTRATOS/CONTRATO">
				<xsl:variable name="IDContrato"><xsl:value-of select="CON_ID"/></xsl:variable>
				<tr id="SOLIC_{CON_ID}" class="con_hover">
					<xsl:choose>
					<xsl:when test="MODIFICADO_1HORA">
						<xsl:attribute name="class">fondoNaranja</xsl:attribute>
					</xsl:when>
					<xsl:when test="MODIFICADO_24HORAS">
						<xsl:attribute name="class">fondoAmarillo</xsl:attribute>
					</xsl:when>
					</xsl:choose>

					<td class="color_status"><xsl:value-of select="position()"/></td>
					<td>
						<strong>
                        <a href="javascript:Contrato({CON_ID})">
                            <xsl:value-of select="CON_CODIGO"/>
                        </a>
						</strong>
                    </td>
					<td><xsl:value-of select="CON_FECHAALTA"/></td>
					<td><xsl:value-of select="CON_FECHAINICIO"/></td>
					<td><xsl:value-of select="CON_FECHAFINAL"/></td>
                    <td class="textLeft">
						<a href="javascript:FichaEmpresa('{IDCLIENTE}')">
							<xsl:value-of select="CLIENTE"/>
						</a>
					</td>
					<td class="textLeft">
						<a href="javascript:FichaCentro('{IDCENTROCLIENTE}')">
							<xsl:value-of select="CENTROCLIENTE"/>
                        </a>
					</td>
					<td class="textLeft">
						<strong>
                        <a href="javascript:Contrato({CON_ID})">
							<xsl:value-of select="CON_TITULO"/>
                        </a>
                    	</strong>
					</td>
                    <td class="textLeft">
						&nbsp;<a href="javascript:FichaEmpresa('{IDPROVEEDOR}');"><xsl:value-of select="PROVEEDOR"/></a>
					</td>
                    <td class="textLeft"><xsl:value-of select="USUARIO"/></td>
					<td class="textLeft"><xsl:value-of select="ESTADO"/></td>
					<td>
					<xsl:if test="$usuario = 'CDC'">
						<a href="javascript:BorrarContrato('{CON_ID}');"><img src="http://www.newco.dev.br/images/2017/trash.png"/></a>
					</xsl:if>
					</td>
				</tr>
			</xsl:for-each>
        </xsl:when>
		<xsl:otherwise>
			<tr><td colspan="12" align="center"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='busqueda_sin_resultados']/node()"/></strong></td></tr>
		</xsl:otherwise>
		</xsl:choose>
		</tbody>
		<tfoot class="rodape_tabela">
			<tr><td colspan="12">&nbsp;</td></tr>
		</tfoot>
	</table><!--fin de infoTableAma-->
 	</div>
 	<br/>  
 	<br/>  
 	<br/>  
 	<br/>  
 	<br/>  
	</xsl:otherwise>
</xsl:choose>
</body>
</html>
</xsl:template>
</xsl:stylesheet>
