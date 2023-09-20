<?xml version="1.0" encoding="iso-8859-1" ?>
<!--	
	Mantenimiento de plazos de pago, para usuarios MVM. Nuevo disenno 2022.
	Ultima revision ET 5set22 10:30 PlazosDePago2022_050922.js
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
		<xsl:when test="/PlazosDePago/LANG"><xsl:value-of select="/PlazosDePago/LANG" /></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
	</xsl:choose>  
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>        
	<!--idioma fin-->
        
	<title><xsl:value-of select="document($doc)/translation/texts/item[@name='Tablas_auxiliares']/node()"/>:&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Plazos_de_pago']/node()"/></title>
       <!--style-->
      <xsl:call-template name="estiloIndip"/>
      <!--fin de style-->  

	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery-3.6.0.js"></script>	
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic2022_010822.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/descargas_151117.js"></script>		<!-- Para descargas excel	-->
	<script type="text/javascript" src="http://www.newco.dev.br/Administracion/Mantenimiento/TablasAuxiliares/PlazosDePago2022_050922.js"></script>
     
	<script type="text/javascript">
	var strID='<xsl:value-of select="document($doc)/translation/texts/item[@name='id']/node()"/>';
	var strPlazo='<xsl:value-of select="document($doc)/translation/texts/item[@name='plazo_de_pago']/node()"/>';
	var alrt_EstaSeguro='<xsl:value-of select="document($doc)/translation/texts/item[@name='seguro_de_borrar_registro']/node()"/>'
	<!--	Ofertas vencedoras y alternativas. Listado Excel		-->

	var numColumnas=0;
	var arrPlazos			= new Array();
	<xsl:for-each select="/PlazosDePago/PLAZOSDEPAGO/PLAZODEPAGO">
		var Plazo			= [];
		Plazo['ID']	= '<xsl:value-of select="ID"/>';
		Plazo['Descripcion']	= '<xsl:value-of select="DESCRIPCION"/>';
		arrPlazos.push(Plazo);
	</xsl:for-each>
	</script>
                
</head>
<body>   
	<!--idioma-->
	<xsl:variable name="lang">
	<xsl:choose>
		<xsl:when test="/PlazosDePago/LANG"><xsl:value-of select="/PlazosDePago/LANG" /></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
	</xsl:choose>  
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>        
	<!--idioma fin-->
        
      
    <xsl:choose>
        <xsl:when test="//SESION_CADUCADA">
              <xsl:apply-templates select="//SESION_CADUCADA"/>    
        </xsl:when>
        <xsl:when test="//xsql-error">
             <xsl:apply-templates select="//xsql-error"/>
           </xsl:when>
        <xsl:otherwise>
	    <!-- Titulo -->
		<form action="http://www.newco.dev.br/Administracion/Mantenimiento/TablasAuxiliares/PlazosDePago2022.xsql" name="Form" method="POST">
		<input type="hidden" name="ACCION"/>
		<input type="hidden" name="PARAMETROS"/>

		<!--	Titulo de la página		-->
		<div class="ZonaTituloPagina">
			<p class="TituloPagina">
      			<xsl:choose>
        		<xsl:when test="/PlazosDePago/PLAZOSDEPAGO/MENSAJE != ''">
					<xsl:value-of select="/PlazosDePago/PLAZOSDEPAGO/MENSAJE"/>
        		</xsl:when>
        		<xsl:otherwise>
					<xsl:value-of select="document($doc)/translation/texts/item[@name='Plazos_de_pago']/node()"/>
        		</xsl:otherwise>
      			</xsl:choose>
				<span class="CompletarTitulo">
					<a class="btnNormal" href="javascript:DescargarExcel();">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='CSV']/node()"/>
					</a>
					&nbsp;
					<a class="btnNormal" href="http://www.newco.dev.br/Administracion/Mantenimiento/TablasAuxiliares/FormasDePago2022.xsql">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='Formas_de_pago']/node()"/>
					</a>
					&nbsp;
					<a class="btnNormal" href="http://www.newco.dev.br/Administracion/Mantenimiento/TablasAuxiliares/EquivalenciasERP2022.xsql">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='Equivalencias_ERP']/node()"/>
					</a>
					&nbsp;
					<a class="btnNormal" href="http://www.newco.dev.br/Administracion/Mantenimiento/TablasAuxiliares/OtrasTablas2022.xsql">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='Otras_tablas_ERP']/node()"/>
					</a>
					&nbsp;
				</span>
			</p>
		</div>
		<br/>
		<br/>
		<br/>
		<br/>
		<br/>
		<div class="divLeft marginLeft300">
			<label><xsl:value-of select="document($doc)/translation/texts/item[@name='Cliente']/node()"/></label>:&nbsp;
			<xsl:call-template name="desplegable">
				<xsl:with-param name="path" select="/PlazosDePago/PLAZOSDEPAGO/LISTAEMPRESAS/field"/>
				<xsl:with-param name="claSel">w600px</xsl:with-param>
				<xsl:with-param name="onChange">javascript:selEmpresaChange();</xsl:with-param>
			</xsl:call-template>
			<br/>
			<br/>
		</div>
		<div class="tabela tabela_redonda">
		<table class="w1000px tableCenter" cellspacing="6px" cellpadding="6px">
			<thead class="cabecalho_tabela">
                <tr>	
					<th class="w1px">&nbsp;</th>
					<th class="w100px"><xsl:value-of select="document($doc)/translation/texts/item[@name='id']/node()"/></th>
					<th class="textLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='plazo_de_pago']/node()"/></th>
					<th class="w10px"><xsl:value-of select="document($doc)/translation/texts/item[@name='borrar']/node()"/></th>
					<th class="w10px">&nbsp;</th>
				</tr>
			</thead>
			<!--	Cuerpo de la tabla	-->
			<tbody class="corpo_tabela">
	       		<xsl:for-each select="/PlazosDePago/PLAZOSDEPAGO/PLAZODEPAGO">
				<tr class="conhover">
					<td class="color_status">&nbsp;</td>
					<td>
						<xsl:value-of select="ID"/>
					</td>
					<td class="textLeft">
						<xsl:value-of select="DESCRIPCION"/>
					</td>
					<td>
                    	<a href="javascript:Borrar({ID})">
                        	<img src="http://www.newco.dev.br/images/2022/icones/del.svg"/>
                    	</a>
					</td>
					<td>&nbsp;</td>
                 </tr>
			</xsl:for-each> 
            <tr class="SinLinea">
            </tr>
            <tr class="SinLinea">
				<td class="color_status">&nbsp;</td>
				<td>&nbsp;</td>
				<td class="textLeft">
					<input type="text" class="campopesquisa w500px" name="DESCRIPCION"/>
				</td>
				<td>
                    <a class="btnDestacado" href="javascript:Insertar();">
                        <xsl:value-of select="document($doc)/translation/texts/item[@name='insertar']/node()"/>
                    </a>
				</td>
				<td>&nbsp;</td>
            </tr>
			</tbody>
			<tfoot class="rodape_tabela">
				<tr><td colspan="5">&nbsp;</td></tr>
			</tfoot>
	    </table>
		<br/>
		<br/>
		<br/>
		<br/>
		<br/>
		<br/>
		<br/>
		<br/>
		<br/>
		</div>
		</form>
		</xsl:otherwise>
		</xsl:choose> 
	</body>
</html>
</xsl:template>  
</xsl:stylesheet>
