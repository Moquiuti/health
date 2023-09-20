<?xml version="1.0" encoding="iso-8859-1" ?>
<!--	
	Mantenimiento de circuitos de aprobación
	Ultima revision: ET 2jul21 11:00 CircuitosAprobacion_150321.js
-->
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
            <xsl:when test="/CircuitosAprobacion/LANG"><xsl:value-of select="/CircuitosAprobacion/LANG" /></xsl:when>
            <xsl:otherwise>spanish</xsl:otherwise>
            </xsl:choose>  
        </xsl:variable>
        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>        <!--idioma fin-->
        
	<title><xsl:value-of select="/CircuitosAprobacion/CIRCUITOS_APROBACION/EMPRESA"/>:&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Circuitos_aprobacion']/node()"/></title>
       <!--style-->
      <xsl:call-template name="estiloIndip"/>
      <!--fin de style-->  

	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"/>
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"/>
	<script type="text/javascript">     
		strSeguroBorrar='<xsl:value-of select="document($doc)/translation/texts/item[@name='Seguro_de_borrar_circuito']/node()"/>';
		errCategoriaObligatoria='<xsl:value-of select="document($doc)/translation/texts/item[@name='Categoria_obligatoria']/node()"/>';
		errProveedorObligatorio='<xsl:value-of select="document($doc)/translation/texts/item[@name='Proveedor_obligatorio']/node()"/>';
		errNombreObligatorio='<xsl:value-of select="document($doc)/translation/texts/item[@name='Nombre_circuito_obligatorio']/node()"/>';
		errImporteIncorrecto='<xsl:value-of select="document($doc)/translation/texts/item[@name='Formato_importe_incorrecto']/node()"/>';
	</script>	
	<script type="text/javascript" src="http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/CircuitosAprobacion_150321.js"/>
        
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
		<form action="http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/CircuitosAprobacion.xsql" name="frmCirc" method="POST">
		<input type="hidden" name="ACCION"/>
		<input type="hidden" name="IDEMPRESA" value="{/CircuitosAprobacion/CIRCUITOS_APROBACION/IDEMPRESA}"/>
		<input type="hidden" name="IDCIRCUITO" id="IDCIRCUITO"/>
		<input type="hidden" name="PARAMETROS" id="PARAMETROS"/>

		<!--	Titulo de la página		-->
		<div class="ZonaTituloPagina">
			<p class="Path"><xsl:value-of select="document($doc)/translation/texts/item[@name='Inicio']/node()"/>&nbsp;/&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='empresa']/node()"/>&nbsp;/&nbsp;<span class="FinPath"><xsl:value-of select="document($doc)/translation/texts/item[@name='Circuitos_aprobacion']/node()"/></span></p>
			<p class="TituloPagina">
				<xsl:value-of select="/CircuitosAprobacion/CIRCUITOS_APROBACION/EMPRESA"/>
				<span class="CompletarTitulo">
				</span>
			</p>
		</div>
		<br/>
		<br/>
		<br/>
		<br/>
		<br/>
		<!--
		<h1 class="titlePage"><xsl:value-of select="document($doc)/translation/texts/item[@name='cartera_clientes_por_vendedor']/node()"/></h1>
        -->
        <xsl:if test="/CircuitosAprobacion/CIRCUITOS_APROBACION/CIRCUITO">
            <!--<table class="grandeInicio">-->
<!--
<CIRCUITO><NIVEL>1</NIVEL><ORDEN>10</ORDEN><IDCENTROCLIENTE/><CENTROCLIENTE/><IDCOMPRADOR/><COMPRADOR> </COMPRADOR><IDAPROBADOR>33727</IDAPROBADOR><APROBADOR>Tamara Pérez</APROBADOR></CIRCUITO>
-->
            <table class="buscador">
                <!--<tr class="titulosAzul">	-->
                <tr class="subTituloTabla">	
					<th class="uno">&nbsp;</th>
					<th align="left"><xsl:value-of select="document($doc)/translation/texts/item[@name='nombre']/node()"/></th>
					<th align="left" class="tres"><xsl:value-of select="document($doc)/translation/texts/item[@name='Nivel']/node()"/></th>
					<th align="left" class="tres"><xsl:value-of select="document($doc)/translation/texts/item[@name='orden']/node()"/></th>
					<th align="left"><xsl:value-of select="document($doc)/translation/texts/item[@name='centro']/node()"/></th>
					<th align="left" class="diez"><xsl:value-of select="document($doc)/translation/texts/item[@name='comprador']/node()"/></th>
					<th align="left"><xsl:value-of select="document($doc)/translation/texts/item[@name='Convenio']/node()"/></th>
					<th align="left"><xsl:value-of select="document($doc)/translation/texts/item[@name='Condicion']/node()"/></th>
					<th align="left"><xsl:value-of select="document($doc)/translation/texts/item[@name='valor']/node()"/></th>
					<th align="left"><xsl:value-of select="document($doc)/translation/texts/item[@name='importe']/node()"/></th>
					<th align="left"><xsl:value-of select="document($doc)/translation/texts/item[@name='Aprobador']/node()"/></th>
					<th class="uno"><xsl:value-of select="document($doc)/translation/texts/item[@name='borrar']/node()"/>&nbsp;</th>
				</tr>
	       		<xsl:for-each select="/CircuitosAprobacion/CIRCUITOS_APROBACION/CIRCUITO">
                <tr>
					<td>&nbsp;</td>
					<td class="textLeft">
						<a href="javascript:EditarCircuito({ID});"><xsl:value-of select="NOMBRE"/></a>
						<input type="hidden" id="NOMBRE_{ID}" value="{NOMBRE}"/>
					</td>
					<td class="textCenter">
						<xsl:value-of select="NIVEL"/>
						<input type="hidden" id="NIVEL_{ID}" value="{NIVEL}"/>
					</td>
					<td class="textCenter">
						<xsl:value-of select="ORDEN"/>
						<input type="hidden" id="ORDEN_{ID}" value="{ORDEN}"/>
					</td>
					<td class="textLeft">
						<xsl:value-of select="CENTROCLIENTE"/>
						<input type="hidden" id="IDCENTROCLIENTE_{ID}" value="{IDCENTROCLIENTE}"/>
					</td>
					<td class="textLeft">
						<xsl:value-of select="COMPRADOR"/>
						<input type="hidden" id="IDCOMPRADOR_{ID}" value="{IDCOMPRADOR}"/>
					</td>
					<td class="textLeft">
						<xsl:value-of select="CONVENIO"/>
						<input type="hidden" id="CONVENIO_{ID}" value="{CONVENIO}"/>
					</td>
					<td class="textLeft">
						<xsl:value-of select="TEXTOCONDICION"/>
						<input type="hidden" id="CONDICION_{ID}" value="{CONDICION}"/>
					</td>
					<td class="textLeft">
						<xsl:value-of select="TEXTOVALOR"/>
						<input type="hidden" id="VALOR_{ID}" value="{VALOR}"/>
					</td>
					<td class="textRight">
						<xsl:value-of select="IMPORTE"/>&nbsp;
						<input type="hidden" id="IMPORTE_{ID}" value="{IMPORTE}"/>
					</td>
					<td class="textLeft">
						<xsl:value-of select="APROBADOR"/>
						<input type="hidden" id="IDAPROBADOR_{ID}" value="{IDAPROBADOR}"/>
					</td>
					<td>
                    	<a href="javascript:BorrarCircuito({ID});">
                        	<img src="/images/2017/trash.png"/>
                    	</a>
					</td>
                 </tr>
			</xsl:for-each> 
	    	</table>
        	</xsl:if>
			<br/>
			<br/>
			<br/>

			<!--<table class="infoTable" style="border-top:2px solid #3B5998;">-->
			<table class="buscador">
            	<!--<tr><td colspan="3">&nbsp;</td></tr>-->
				<tr class="sinLinea">
				<td class="textLeft">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='Nivel']/node()"/>:<br/>
					<!--<input type="textbox" class="peq" name="NIVEL" id="NIVEL" value=""/>-->
					<select name="NIVEL" id="NIVEL" style="width:50px">
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
				<td class="textLeft">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='orden']/node()"/>:<br/>
					<!--<input type="textbox" class="peq" name="ORDEN" id="ORDEN" value=""/>-->
					<select name="ORDEN" id="ORDEN" style="width:50px">
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
				<td class="textLeft">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='nombre']/node()"/>:<br/>
					<input type="textbox" name="NOMBRE" id="NOMBRE" value=""/>
				</td>
				<td class="textLeft">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='centro']/node()"/>:<br/>
					<xsl:call-template name="desplegable">
					<xsl:with-param name="path" select="/CircuitosAprobacion/CIRCUITOS_APROBACION/LISTACENTROS/field"/>
					<xsl:with-param name="style">width:250px</xsl:with-param>
					<xsl:with-param name="onChange">javascript:CambiaCentro();</xsl:with-param>
					</xsl:call-template>
				</td>
				<td class="textLeft" id="USUARIOS" style="display:none">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='usuario']/node()"/>:<br/>
					<xsl:call-template name="desplegable">
					<xsl:with-param name="path" select="/CircuitosAprobacion/CIRCUITOS_APROBACION/LISTACOMPRADORES/field"/>
					<xsl:with-param name="style">width:250px</xsl:with-param>
					</xsl:call-template>
				</td>
				<td class="textLeft" id="CONVENIO">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='Tipo_negociacion']/node()"/>:<br/>
					<xsl:call-template name="desplegable">
					<xsl:with-param name="path" select="/CircuitosAprobacion/CIRCUITOS_APROBACION/CONVENIO/field"/>
					<xsl:with-param name="style">width:180px</xsl:with-param>
					</xsl:call-template>
				</td>
				<td class="textLeft">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='Condicion']/node()"/>:<br/>
					<xsl:call-template name="desplegable">
					<xsl:with-param name="path" select="/CircuitosAprobacion/CIRCUITOS_APROBACION/LISTACONDICIONES/field"/>
					<xsl:with-param name="style">width:250px</xsl:with-param>
					<xsl:with-param name="onChange">javascript:CambiaCondicion();</xsl:with-param>
					</xsl:call-template>
				</td>
				<td class="textLeft" id="CATEGORIAS" style="display:none">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='categoria']/node()"/>:<br/>
					<xsl:call-template name="desplegable">
					<xsl:with-param name="path" select="/CircuitosAprobacion/CIRCUITOS_APROBACION/LISTACATEGORIAS/field"/>
					<xsl:with-param name="style">width:250px</xsl:with-param>
					</xsl:call-template>
				</td>
				<td class="textLeft" id="PROVEEDORES" style="display:none">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/>:<br/>
					<xsl:call-template name="desplegable">
					<xsl:with-param name="path" select="/CircuitosAprobacion/CIRCUITOS_APROBACION/LISTAPROVEEDORES/field"/>
					<xsl:with-param name="style">width:250px</xsl:with-param>
					</xsl:call-template>
				</td>
				<td class="textLeft">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='importe']/node()"/>:<br/>
					<input type="textbox" name="IMPORTE" id="IMPORTE" value="0" style="width:150px" onChange="javascript:ComprobarImporte();"/>
				</td>
				<td class="textLeft">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='Aprobador']/node()"/>:<br/>
					<xsl:call-template name="desplegable">
					<xsl:with-param name="path" select="/CircuitosAprobacion/CIRCUITOS_APROBACION/LISTAAPROBADORES/field"/>
					<xsl:with-param name="style">width:250px</xsl:with-param>
					</xsl:call-template>
				</td>
				<td class="textLeft">
					<a class="btnDestacado" href="javascript:GuardarCircuito();"><xsl:value-of select="document($doc)/translation/texts/item[@name='guardar']/node()"/></a>
					&nbsp;
					<a class="btnNormal" href="javascript:LimpiarCircuito();"><xsl:value-of select="document($doc)/translation/texts/item[@name='Limpiar']/node()"/></a>
				</td>
           </tr>
         </table>
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
