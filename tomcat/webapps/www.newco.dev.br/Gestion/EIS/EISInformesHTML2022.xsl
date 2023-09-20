<?xml version="1.0" encoding="iso-8859-1"?>
<!--
 	Presentacion de los datos para EIS Informes. Nuevo disenno 2022.
 	Ultima revision: ET 03jul23 10:30 EISInformes2022_210322.js
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:import href = "http://www.newco.dev.br/General/General.xsl"/>
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="lang" select="@lang"/>

<xsl:template match="/EISInformes">

<!--	Todos los documentos HTML deben empezar con esto	-->
<xsl:text disable-output-escaping='yes'>&lt;!doctype html></xsl:text>

<html>
<head>
	<!--idioma-->
	<xsl:variable name="lang"><xsl:value-of select="LANG"/></xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<title><xsl:value-of select="document($doc)/translation/texts/item[@name='informes']/node()"/>:&nbsp;<xsl:value-of select="INFORME/NOMBRE"/></title>

	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->

	<script src="http://www.newco.dev.br/General/jquery-3.6.0.js"></script>	
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic2022_010822.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/descargas_151117.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/Chart.bundle.min.2.9.3.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/Gestion/EIS/EISInformes2022_210322.js"></script>
	<script type="text/javascript">
		var IDInforme = "<xsl:value-of select="IDINFORME"/>";
		
		<!--	30mar20	Variables JS para crear gráficos	-->
		var DatasetsMensual=[];
		<xsl:for-each select="/EISInformes/INFORME/BLOQUE/LINEA/RESUMEN_MENSUAL[@IncluirGrafico='S']">
			var Dataset= [];

			var Columnas=[];
			<xsl:for-each select="COLUMNA">
				<xsl:if test="ORDEN != 13">
				Columnas.push(<xsl:value-of select="VALOR_SINFORMATO"/>);
				</xsl:if>
			</xsl:for-each>	
			Dataset["ID"]='<xsl:value-of select="@ID"/>';
			Dataset["data"]=Columnas;
			Dataset["label"]='<xsl:value-of select="@Nombre"/>';
        	Dataset["borderColor"]="#46d5f1";
        	Dataset["backgroundColor"]="#EEEEEE";
        	Dataset["fill"]=false;
			DatasetsMensual.push(Dataset);
		</xsl:for-each>

		cont = 0;
		var NombresMeses		= [];
		<xsl:for-each select="/EISInformes/INFORME/CABECERA_TABLAS/COLUMNA">
			<xsl:if test="ORDEN != 13">
			NombresMeses[cont] = '<xsl:value-of select="MES"/>/<xsl:value-of select="ANYO"/>';
			++cont;
			</xsl:if>
		</xsl:for-each>
	</script>
</head>
<!---->
<body onload="javascript:inicio();">

<xsl:choose>
<xsl:when test="ROWSET/ROW/Sorry"><xsl:apply-templates select="ROWSET/ROW/Sorry"/></xsl:when>
<xsl:when test="SESION_CADUCADA"><xsl:apply-templates select="SESION_CADUCADA"/></xsl:when>
<xsl:otherwise>
	<!--idioma-->
	<xsl:variable name="lang"><xsl:value-of select="LANG"/></xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->
	<form name="formInforme">
	
	
	<!--	Titulo de la página		-->
	<div class="ZonaTituloPagina">
		<!--<p class="Path"><xsl:value-of select="document($doc)/translation/texts/item[@name='Inicio']/node()"/>&nbsp;/&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='eis']/node()"/>&nbsp;/&nbsp;<span class="FinPath"><xsl:value-of select="document($doc)/translation/texts/item[@name='listado_de_datos']/node()"/></span></p>-->
		<p class="TituloPagina">
			<xsl:if test="INFORME/EMPRESA != '' and not(INFORME/LISTAEMPRESAS) and not(INFORME/LISTACENTROS)">
				<xsl:value-of select="INFORME/EMPRESA"/>:&nbsp;<xsl:value-of select="INFORME/NOMBRE"/>&nbsp;
			</xsl:if>
			<xsl:choose>
			<xsl:when test="(INFORME/MVM or INFORME/MULTIEMPRESA) and INFORME/LISTAEMPRESAS">
				<xsl:call-template name="desplegable">
					<xsl:with-param name="path" select="INFORME/LISTAEMPRESAS/field"></xsl:with-param>
					<xsl:with-param name="claSel">w400px</xsl:with-param>
				</xsl:call-template>:&nbsp;<xsl:value-of select="INFORME/NOMBRE"/>&nbsp;
			</xsl:when>
			<xsl:otherwise>
				<input type="hidden" name="IDEMPRESA" id="IDEMPRESA" value="{INFORME/IDEMPRESA}"/>
			</xsl:otherwise>
			</xsl:choose>
    		<xsl:if test="not(INFORME/MVM) and INFORME/LISTACENTROS">
			<xsl:call-template name="desplegable">
				<xsl:with-param name="path" select="INFORME/LISTACENTROS/field"></xsl:with-param>
				<xsl:with-param name="claSel">w300px</xsl:with-param>
			</xsl:call-template>:&nbsp;<xsl:value-of select="INFORME/NOMBRE"/>&nbsp;			
    		</xsl:if>
			<span class="CompletarTitulo300">
				<a class="btnNormal" href="javascript:RecuperaCSV();" style="text-decoration:none;"><xsl:value-of select="document($doc)/translation/texts/item[@name='CSV']/node()"/></a>
				&nbsp;
				<a class="btnNormal" href="javascript:print();"><xsl:value-of select="document($doc)/translation/texts/item[@name='imprimir']/node()"/></a>
			</span>
		</p>
	</div>
	<br/>
	<br/>	
	</form>
	<xsl:for-each select="INFORME/BLOQUE">
	<table class="w95 tableCenter">
      <tr class="filtros sinLinea">
        <td class="textLeft">
          &nbsp;<a href="javascript:toggleTable('TableID_{ID}');"><xsl:value-of select="NOMBRE"/></a>
        </td>
      </tr>
    </table>

		<div id="TableID_{ID}" class="w95 tableCenter">
		<xsl:for-each select="LINEA">

			<xsl:if test="INCLUIR_CABECERA_TABLA">
				<xsl:text disable-output-escaping="yes">
                <!--dentro del CDATA	-->
				<![CDATA[
					<div class="tabela tabela_redonda">
                	<table class="w90 tableCenter" cellspacing="6px" cellpadding="6px" border="1px">
				]]>
				</xsl:text>
				<thead>
					<tr class="ConBordes">
						<th class="w300px">&nbsp;</th>
						<xsl:for-each select="//INFORME/CABECERA_TABLAS/COLUMNA">
							<th class="w80px">
    							<xsl:value-of select="MES"/>
    							<xsl:if test="MES != 'TOTAL'"><xsl:text>/</xsl:text></xsl:if>
    							<xsl:value-of select="ANYO"/>
							</th>
						</xsl:for-each>
					</tr>
				</thead>
				<!--<![CDATA[
                	<tbody class="corpo_tabela">
				]]>-->
			</xsl:if>

			<xsl:if test="RESUMEN_MENSUAL">
				<tr>
					<td class="indicador textLeft color_status">&nbsp;<xsl:value-of select="RESUMEN_MENSUAL/@Nombre"/></td>
					<xsl:for-each select="RESUMEN_MENSUAL/COLUMNA">
						<td><xsl:value-of select="VALOR"/>&nbsp;</td>
					</xsl:for-each>
				</tr>
				<xsl:if test="RESUMEN_MENSUAL/INCLUIR_EN_GRAFICO">
				<tr>
					<td colspan="14"><div width="600px" height="200px" align="center" style="float:left;width:100%;"><canvas id="gr_{RESUMEN_MENSUAL/@ID}" width="600px" height="200px"></canvas></div></td>
				</tr>
				</xsl:if>
				<!--<tr>
					<td colspan="14">&nbsp;</td>
				</tr>-->
			</xsl:if>

			<xsl:if test="INCLUIR_CIERRE_TABLA">
			<xsl:text disable-output-escaping="yes">
			<![CDATA[
				</tbody>
             	</table>
				</div>
            	<br /><br />
			]]>
			</xsl:text>
            </xsl:if>

            <xsl:if test="TEXTO">
                <label>&nbsp;<xsl:value-of select="TEXTO"/></label>
                <p>&nbsp;</p>
            </xsl:if>

		</xsl:for-each>
		</div>
	</xsl:for-each>

</xsl:otherwise>
</xsl:choose>

</body>
</html>
</xsl:template>

</xsl:stylesheet>
