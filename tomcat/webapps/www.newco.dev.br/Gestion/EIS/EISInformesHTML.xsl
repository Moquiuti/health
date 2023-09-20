<?xml version="1.0" encoding="iso-8859-1"?>
<!--
 	Presentacion de los datos para EIS Informes
 	Ultima revision: ET 15nov17
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:import href = "http://www.newco.dev.br/General/General.xsl"/>
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="lang" select="@lang"/>

<xsl:template match="/EISInformes">
<html>
<head>
	<!--idioma-->
	<xsl:variable name="lang"><xsl:value-of select="LANG"/></xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<title><xsl:value-of select="document($doc)/translation/texts/item[@name='informes']/node()"/>&nbsp;(
	<xsl:value-of select="document($doc)/translation/texts/item[@name='eis']/node()"/>)</title>

	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->

	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery-1.8.3.min.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/descargas_151117.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/Chart.bundle.min.2.9.3.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/Gestion/EIS/EISInformes_300320.js"></script>
	<script type="text/javascript">
		var IDInforme = "<xsl:value-of select="IDINFORME"/>";
		
		<!--	30mar20	Variables JS para crear gráficos	-->
		var DatasetsMensual=[];
		<!--<xsl:for-each select="/EISInformes/INFORME/BLOQUE/LINEA[@IncluirGrafico='S']">-->
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
		<p class="Path"><xsl:value-of select="document($doc)/translation/texts/item[@name='Inicio']/node()"/>&nbsp;/&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='eis']/node()"/>&nbsp;/&nbsp;<span class="FinPath"><xsl:value-of select="document($doc)/translation/texts/item[@name='listado_de_datos']/node()"/></span></p>
		<p class="TituloPagina">
			<xsl:if test="INFORME/EMPRESA != '' and not(INFORME/LISTAEMPRESAS) and not(INFORME/LISTACENTROS)">
				<xsl:value-of select="INFORME/EMPRESA"/>:&nbsp;<xsl:value-of select="INFORME/NOMBRE"/>&nbsp;
			</xsl:if>
			<xsl:choose>
			<xsl:when test="(INFORME/MVM or INFORME/MULTIEMPRESA) and INFORME/LISTAEMPRESAS">
				<xsl:call-template name="desplegable">
					<xsl:with-param name="path" select="INFORME/LISTAEMPRESAS/field"></xsl:with-param>
					<xsl:with-param name="style">width:400px;height:25px;font-size:18px;</xsl:with-param>
				</xsl:call-template>:&nbsp;<xsl:value-of select="INFORME/NOMBRE"/>&nbsp;
			</xsl:when>
			<xsl:otherwise>
				<input type="hidden" name="IDEMPRESA" id="IDEMPRESA" value="{INFORME/IDEMPRESA}"/>
			</xsl:otherwise>
			</xsl:choose>
    		<xsl:if test="not(INFORME/MVM) and INFORME/LISTACENTROS">
			<xsl:call-template name="desplegable">
				<xsl:with-param name="path" select="INFORME/LISTACENTROS/field"></xsl:with-param>
				<xsl:with-param name="style">width:400px;height:25px;font-size:18px;</xsl:with-param>
			</xsl:call-template>:&nbsp;<xsl:value-of select="INFORME/NOMBRE"/>&nbsp;			
    		</xsl:if>
			<span class="CompletarTitulo" width="100px">
				<a class="btnNormal" href="javascript:RecuperaCSV();" style="text-decoration:none;"><img id="botonExcel" alt="Descargar Excel" src="http://www.newco.dev.br/images/iconoExcel.gif"/></a>
				&nbsp;
				<a class="btnNormal" href="javascript:print();"><xsl:value-of select="document($doc)/translation/texts/item[@name='imprimir']/node()"/></a>
			</span>
		</p>
	</div>
	<br/>
	<br/>	
	</form>
	<xsl:for-each select="INFORME/BLOQUE">
	<!--<table class="mediaTabla">-->
	<table class="buscador">
      <tr class="filtros sinLinea">
        <td style="text-align:left;">
          &nbsp;<a style="font-weight:bold; font-size:16px;text-decoration:none;" href="javascript:toggleTable('TableID_{ID}');">
				<xsl:value-of select="NOMBRE"/>
			</a>
        </td>
      </tr>
      <!--<tr height="5">
        <td>&nbsp;</td>
      </tr>-->
    </table>

		<div id="TableID_{ID}">
		<xsl:for-each select="LINEA">

			<xsl:if test="INCLUIR_CABECERA_TABLA">
				<xsl:text disable-output-escaping="yes">
                <!--dentro del CDATA	<table class="mediaTabla" width="90%">	-->
				<![CDATA[
                	<table class="buscador">
				]]>
				</xsl:text>
				<thead>
					<!--<tr style="border-bottom:1px solid #666;border-top:1px solid #666">-->
					<tr class="subTituloTabla">
						<th class="veinte">&nbsp;</th>
						<xsl:for-each select="//INFORME/CABECERA_TABLAS/COLUMNA">
							<th class="cinco" style="border-left:1px solid #666;">
    							<xsl:value-of select="MES"/>
    							<xsl:if test="MES != 'TOTAL'"><xsl:text>/</xsl:text></xsl:if>
    							<xsl:value-of select="ANYO"/>
							</th>
						</xsl:for-each>
					</tr>
				</thead>
			</xsl:if>

			<xsl:if test="RESUMEN_MENSUAL">
				<tr> <!-- style="border-bottom:1px solid #666;">-->
					<td class="indicador textLeft">&nbsp;<xsl:value-of select="RESUMEN_MENSUAL/@Nombre"/></td>
					<xsl:for-each select="RESUMEN_MENSUAL/COLUMNA">
						<td style="text-align:right;border-left:1px solid #666;"><xsl:value-of select="VALOR"/>&nbsp;</td>
					</xsl:for-each>
				</tr>
				<xsl:if test="RESUMEN_MENSUAL/INCLUIR_EN_GRAFICO">
				<tr>
					<td colspan="1">&nbsp;</td>
					<td colspan="9"><div width="1000" height="300" align="center" style="float:left;width:100%;"><canvas id="gr_{RESUMEN_MENSUAL/@ID}" width="1000" height="300"></canvas></div></td>
					<td colspan="3">&nbsp;</td>
				</tr>
				</xsl:if>
			</xsl:if>

			<xsl:if test="INCLUIR_CIERRE_TABLA">
			<xsl:text disable-output-escaping="yes">
			<![CDATA[
             	</table>
            	<br /><br />
			]]>
			</xsl:text>
            </xsl:if>

            <xsl:if test="TEXTO">
                <label><!--<p style="font-size:14px; font-weight:bold;">-->&nbsp;<xsl:value-of select="TEXTO"/><!--</p>--></label>
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
