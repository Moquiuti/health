<?xml version="1.0" encoding="iso-8859-1" ?>
<!--	
	Mantenimiento de circuitos de aprobación
	Ultima revision:  ET 12set22 12:00 CircuitosAprobacion2022_120922.js
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
		<xsl:when test="/CircuitosAprobacion/LANG"><xsl:value-of select="/CircuitosAprobacion/LANG" /></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
	</xsl:choose>  
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>        <!--idioma fin-->
        
	<title><xsl:value-of select="/CircuitosAprobacion/CIRCUITOS_APROBACION/EMPRESA"/>:&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Circuitos_aprobacion']/node()"/></title>
    <!--style-->
    <xsl:call-template name="estiloIndip"/>
    <!--fin de style-->  

	<script src="http://www.newco.dev.br/General/jquery-3.6.0.js"></script>	
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic2022_010822.js"></script>
	<script type="text/javascript">     
		strSeguroBorrar='<xsl:value-of select="document($doc)/translation/texts/item[@name='Seguro_de_borrar_circuito']/node()"/>';
		errCategoriaObligatoria='<xsl:value-of select="document($doc)/translation/texts/item[@name='Categoria_obligatoria']/node()"/>';
		errProveedorObligatorio='<xsl:value-of select="document($doc)/translation/texts/item[@name='Proveedor_obligatorio']/node()"/>';
		errNombreObligatorio='<xsl:value-of select="document($doc)/translation/texts/item[@name='Nombre_circuito_obligatorio']/node()"/>';
		errImporteIncorrecto='<xsl:value-of select="document($doc)/translation/texts/item[@name='Formato_importe_incorrecto']/node()"/>';
		errAprobadorObligatorio='<xsl:value-of select="document($doc)/translation/texts/item[@name='Aprobador_obligatorio']/node()"/>';
		
		<!-- Array de circuitos -->
		var arrCircuitos		= new Array();
		<xsl:for-each select="/CircuitosAprobacion/CIRCUITOS_APROBACION/CIRCUITO">
			circ= [];
			circ['ID']		= "<xsl:value-of select="ID"/>";
			circ['TIPO']	= "<xsl:value-of select="TIPO"/>";
			circ['NOMBRE']	= "<xsl:value-of select="NOMBRE"/>";
			circ['NIVEL']	= "<xsl:value-of select="NIVEL"/>";
			circ['ORDEN']	= "<xsl:value-of select="ORDEN"/>";
			circ['IDCENTROCLIENTE']	= "<xsl:value-of select="IDCENTROCLIENTE"/>";
			circ['IDCENTROCONSUMO']	= "<xsl:value-of select="IDCENTROCONSUMO"/>";
			circ['CONVENIO']= "<xsl:value-of select="CONVENIO"/>";
			circ['IDCOMPRADOR']	= "<xsl:value-of select="IDCOMPRADOR"/>";
			circ['CONDICION']	= "<xsl:value-of select="CONDICION"/>";
			circ['VALOR']	= "<xsl:value-of select="VALOR"/>";
			circ['IMPORTE']	= "<xsl:value-of select="IMPORTE"/>";
			circ['IDAPROBADOR']	= "<xsl:value-of select="IDAPROBADOR"/>";
			arrCircuitos.push(circ);
		</xsl:for-each>
		<!-- Array de circuitos -->
	</script>	
	<script type="text/javascript" src="http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/CircuitosAprobacion2022_120922.js"/>
        
</head>
<body onLoad="javascript:onLoad();">   
	<!--idioma-->
	<xsl:variable name="lang">
	<xsl:choose>
		<xsl:when test="/CircuitosAprobacion/LANG"><xsl:value-of select="/CircuitosAprobacion/LANG" /></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
	</xsl:choose>  
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>        <!--idioma fin-->
      
    <xsl:choose>
		<xsl:when test="//SESION_CADUCADA">
			<xsl:apply-templates select="//SESION_CADUCADA"/>    
		</xsl:when>
		<xsl:when test="//xsql-error">
			<xsl:apply-templates select="//xsql-error"/>
		</xsl:when>
        <xsl:otherwise>
	    <!-- Titulo -->
		<form action="http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/CircuitosAprobacion2022.xsql" name="frmCirc" method="POST">
		<input type="hidden" name="ACCION"/>
		<input type="hidden" name="IDEMPRESA" value="{/CircuitosAprobacion/CIRCUITOS_APROBACION/IDEMPRESA}"/>
		<input type="hidden" name="IDCIRCUITO" id="IDCIRCUITO"/>
		<input type="hidden" name="PARAMETROS" id="PARAMETROS"/>

		<!--	Titulo de la página		-->
		<div class="ZonaTituloPagina">
			<p class="TituloPagina">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='Circuitos_aprobacion']/node()"/>:&nbsp;<xsl:value-of select="/CircuitosAprobacion/CIRCUITOS_APROBACION/EMPRESA"/>
				<!--<span class="CompletarTitulo">
				</span>-->
			</p>
		</div>
		<br/>
		<br/>
		<br/>
		<br/>
		<br/>
        <xsl:if test="/CircuitosAprobacion/CIRCUITOS_APROBACION/CIRCUITO">
			<div class="tabela tabela_redonda">
			<table cellspacing="6px" cellpadding="6px">
				<thead class="cabecalho_tabela">
				<tr>
					<th class="w1px"><xsl:value-of select="document($doc)/translation/texts/item[@name='tipo']/node()"/></th>
					<th class="textLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='nombre']/node()"/></th>
					<th class="textLeft w50px"><xsl:value-of select="document($doc)/translation/texts/item[@name='Nivel']/node()"/></th>
					<th class="textLeft w50px"><xsl:value-of select="document($doc)/translation/texts/item[@name='orden']/node()"/></th>
					<th class="textLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='centro']/node()"/></th>
					<th class="textLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='centro_de_consumo']/node()"/></th>
					<th class="textLeft w100px"><xsl:value-of select="document($doc)/translation/texts/item[@name='comprador']/node()"/></th>
					<th class="textLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='Convenio']/node()"/></th>
					<th class="textLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='Condicion']/node()"/></th>
					<th class="textLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='valor']/node()"/></th>
					<th class="textLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='importe']/node()"/></th>
					<th class="textLeft w100px"><xsl:value-of select="document($doc)/translation/texts/item[@name='Aprobador']/node()"/></th>
					<th class="w1px"><xsl:value-of select="document($doc)/translation/texts/item[@name='borrar']/node()"/>&nbsp;</th>
				</tr>
				</thead>
				<tbody class="corpo_tabela">
	       		<xsl:for-each select="/CircuitosAprobacion/CIRCUITOS_APROBACION/CIRCUITO">
				<tr class="conhover">
					<td class="color_status"><xsl:value-of select="TIPO"/><!--<input type="hidden" id="TIPO_{ID}" value="{TIPO}"/>--></td>
					<td class="textLeft">
						<a href="javascript:EditarCircuito({ID});"><xsl:value-of select="NOMBRE"/></a>
					</td>
					<td class="textCenter">
						<xsl:value-of select="NIVEL"/>
					</td>
					<td class="textCenter">
						<xsl:value-of select="ORDEN"/>
					</td>
					<td class="textLeft">
						<xsl:value-of select="CENTROCLIENTE"/>
					</td>
					<td class="textLeft">
						<xsl:value-of select="CENTROCONSUMO"/>
					</td>
					<td class="textLeft">
						<xsl:value-of select="COMPRADOR"/>
					</td>
					<td class="textLeft">
						<xsl:value-of select="CONVENIO"/>
					</td>
					<td class="textLeft">
						<xsl:value-of select="TEXTOCONDICION"/>
					</td>
					<td class="textLeft">
						<xsl:value-of select="TEXTOVALOR"/>
					</td>
					<td class="textRight">
						<xsl:value-of select="IMPORTE"/>&nbsp;
					</td>
					<td class="textLeft">
						<xsl:value-of select="APROBADOR"/>
					</td>
					<td>
                    	<a href="javascript:BorrarCircuito({ID});">
                        	<img src="/images/2017/trash.png"/>
                    	</a>
					</td>
                 </tr>
			</xsl:for-each> 
			</tbody>
			<tfoot class="rodape_tabela">
				<tr><td colspan="13">&nbsp;</td></tr>
			</tfoot>
	    	</table>
			</div>
        	</xsl:if>
			<br/>
			<br/>
			<br/>

			<table cellspacing="6px" cellpadding="6px">
				<tr>
					<td class="w40px">&nbsp;</td>
					<td class="textLeft w100px">
						<label><xsl:value-of select="document($doc)/translation/texts/item[@name='tipo']/node()"/>:</label><br/>
						<select name="TIPO" id="TIPO" class="w100px" onChange="javascript:CambiaTipo()">
							<option value="PED" selected="selected"><xsl:value-of select="document($doc)/translation/texts/item[@name='pedido']/node()"/></option>
							<option value="LIC"><xsl:value-of select="document($doc)/translation/texts/item[@name='Licitacion']/node()"/></option>
						</select>
					</td>
					<td class="textLeft w50px" id="TDNIVEL">
						<label><xsl:value-of select="document($doc)/translation/texts/item[@name='Nivel']/node()"/>:</label><br/>
						<select name="NIVEL" id="NIVEL" class="w50px">
							<option value="1">1</option>
							<option value="2">2</option>
							<option value="3">3</option>
							<option value="4">4</option>
							<option value="5">5</option>
							<option value="6">6</option>
							<option value="7">7</option>
							<option value="8">8</option>
							<option value="9">9</option>
							<option value="10">10</option>
							<option value="11">11</option>
							<option value="12">12</option>
						</select>
					</td>
					<td class="textLeft w50px" id="TDORDEN">
						<label><xsl:value-of select="document($doc)/translation/texts/item[@name='orden']/node()"/>:</label><br/>
						<select name="ORDEN" id="ORDEN" class="w50px">
							<option value="10">10</option>
							<option value="20">20</option>
							<option value="30">30</option>
							<option value="40">40</option>
							<option value="50">50</option>
							<option value="60">60</option>
							<option value="70">70</option>
							<option value="80">80</option>
							<option value="90">90</option>
						</select>
					</td>
					<td class="textLeft w300px">
						<label><xsl:value-of select="document($doc)/translation/texts/item[@name='nombre']/node()"/>:</label><br/>
						<input type="textbox" class="campopesquisa w300px" name="NOMBRE" id="NOMBRE" value=""/>
					</td>
					<td class="textLeft w200px">
						<label><xsl:value-of select="document($doc)/translation/texts/item[@name='centro']/node()"/>:</label><br/>
						<xsl:call-template name="desplegable">
						<xsl:with-param name="path" select="/CircuitosAprobacion/CIRCUITOS_APROBACION/LISTACENTROS/field"/>
						<xsl:with-param name="claSel">w200px</xsl:with-param>
						<xsl:with-param name="onChange">javascript:CambiaCentro();</xsl:with-param>
						</xsl:call-template>
					</td>
					<!-- 5ago22 centro de costes	-->
					<td class="textLeft w180px" id="TDCENTROCOSTE" style="display:none">
						<label><xsl:value-of select="document($doc)/translation/texts/item[@name='centro_de_consumo']/node()"/>:</label><br/>
						<select name="IDCENTROCOSTE" id="IDCENTROCOSTE" class="w200px"/>
					</td>
					<td class="textLeft w200px" id="USUARIOS" style="display:none">
						<label><xsl:value-of select="document($doc)/translation/texts/item[@name='usuario']/node()"/>:</label><br/>
						<xsl:call-template name="desplegable">
						<xsl:with-param name="path" select="/CircuitosAprobacion/CIRCUITOS_APROBACION/LISTACOMPRADORES/field"/>
						<xsl:with-param name="claSel">w200px</xsl:with-param>
						</xsl:call-template>
					</td>
					<td class="textLeft w180px" id="TDCONVENIO">
						<label><xsl:value-of select="document($doc)/translation/texts/item[@name='Tipo_negociacion']/node()"/>:</label><br/>
						<xsl:call-template name="desplegable">
						<xsl:with-param name="path" select="/CircuitosAprobacion/CIRCUITOS_APROBACION/CONVENIO/field"/>
						<xsl:with-param name="claSel">w180px</xsl:with-param>
						</xsl:call-template>
					</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
         		</tr>
				<tr>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td class="textLeft" id="TDCONDICIONES" >
						<label><xsl:value-of select="document($doc)/translation/texts/item[@name='Condicion']/node()"/>:</label><br/>
						<xsl:call-template name="desplegable">
						<xsl:with-param name="path" select="/CircuitosAprobacion/CIRCUITOS_APROBACION/LISTACONDICIONES/field"/>
						<xsl:with-param name="claSel">w300px</xsl:with-param>
						<xsl:with-param name="onChange">javascript:CambiaCondicion();</xsl:with-param>
						</xsl:call-template>
					</td>
					<td class="textLeft" id="TDCATEGORIAS" style="display:none">
						<label><xsl:value-of select="document($doc)/translation/texts/item[@name='categoria']/node()"/>:</label><br/>
						<xsl:call-template name="desplegable">
						<xsl:with-param name="path" select="/CircuitosAprobacion/CIRCUITOS_APROBACION/LISTACATEGORIAS/field"/>
						<xsl:with-param name="claSel">w200px</xsl:with-param>
						</xsl:call-template>
					</td>
					<td class="textLeft" id="TDPROVEEDORES" style="display:none">
						<label><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/>:</label><br/>
						<xsl:call-template name="desplegable">
						<xsl:with-param name="path" select="/CircuitosAprobacion/CIRCUITOS_APROBACION/LISTAPROVEEDORES/field"/>
						<xsl:with-param name="claSel">w200px</xsl:with-param>
						</xsl:call-template>
					</td>
					<td class="textLeft" id="TDIMPORTE" >
						<label><xsl:value-of select="document($doc)/translation/texts/item[@name='importe']/node()"/>:</label><br/>
						<input type="textbox" class="campopesquisa w120px" name="IMPORTE" id="IMPORTE" value="0" onChange="javascript:ComprobarImporte();"/>
					</td>
					<td class="textLeft">
						<label><xsl:value-of select="document($doc)/translation/texts/item[@name='Aprobador']/node()"/>:</label><br/>
						<xsl:call-template name="desplegable">
						<xsl:with-param name="path" select="/CircuitosAprobacion/CIRCUITOS_APROBACION/LISTAAPROBADORES/field"/>
						<xsl:with-param name="claSel">w200px</xsl:with-param>
						</xsl:call-template>
					</td>
					<td class="textLeft w70px">
						<br/>
						<a class="btnDestacado" href="javascript:GuardarCircuito();"><xsl:value-of select="document($doc)/translation/texts/item[@name='guardar']/node()"/></a>
					</td>
					<td class="textLeft w70px">
						<br/>
						<a class="btnNormal" href="javascript:LimpiarCircuito();"><xsl:value-of select="document($doc)/translation/texts/item[@name='Limpiar']/node()"/></a>
					</td>
					<td>&nbsp;</td>
         		</tr>
         	</table>
			<br/>
			<br/>
			<br/>
			<br/>
			<br/>
			<br/>
		</form>
	</xsl:otherwise>
	</xsl:choose> 
</body>
</html>
</xsl:template>  
</xsl:stylesheet>
