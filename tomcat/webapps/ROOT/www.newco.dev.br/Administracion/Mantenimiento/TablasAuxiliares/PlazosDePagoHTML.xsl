<?xml version="1.0" encoding="iso-8859-1" ?>
<!--	
	Mantenimiento de plazos de pago, para usuarios MVM
	Ultima revision: ET 18nov21 11:30 PlazosDePago_18nov21.js
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
            <xsl:when test="/PlazosDePago/LANG"><xsl:value-of select="/PlazosDePago/LANG" /></xsl:when>
            <xsl:otherwise>spanish</xsl:otherwise>
            </xsl:choose>  
        </xsl:variable>
        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>        <!--idioma fin-->
        
	<title><xsl:value-of select="document($doc)/translation/texts/item[@name='Tablas_auxiliares']/node()"/>:&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Plazos_de_pago']/node()"/></title>
       <!--style-->
      <xsl:call-template name="estiloIndip"/>
      <!--fin de style-->  

    <script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/descargas_151117.js"></script>		<!-- Para descargas excel	-->
	<script type="text/javascript" src="http://www.newco.dev.br/Administracion/Mantenimiento/TablasAuxiliares/PlazosDePago_18nov21.js"></script>
     
	<script type="text/javascript">
	var strID='<xsl:value-of select="document($doc)/translation/texts/item[@name='id']/node()"/>';
	var strPlazo='<xsl:value-of select="document($doc)/translation/texts/item[@name='plazo_de_pago']/node()"/>';
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
		<form action="http://www.newco.dev.br/Administracion/Mantenimiento/TablasAuxiliares/PlazosDePago.xsql" name="Form" method="POST">
		<input type="hidden" name="ACCION"/>
		<input type="hidden" name="PARAMETROS"/>

		<!--	Titulo de la página		-->
		<div class="ZonaTituloPagina">
			<p class="Path"><xsl:value-of select="document($doc)/translation/texts/item[@name='Inicio']/node()"/>&nbsp;/&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Tablas_auxiliares']/node()"/>&nbsp;/&nbsp;<span class="FinPath"><xsl:value-of select="document($doc)/translation/texts/item[@name='Plazos_de_pago']/node()"/></span></p>
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
					<a class="btnNormal" style="text-decoration:none;">
						<xsl:attribute name="href">javascript:DescargarExcel();</xsl:attribute>
						<img src="http://www.newco.dev.br/images/iconoExcel.gif">
							<xsl:attribute name="alt"><xsl:value-of select="document($doc)/translation/texts/item[@name='listado_excel']/node()"/></xsl:attribute>
							<xsl:attribute name="title"><xsl:value-of select="document($doc)/translation/texts/item[@name='listado_excel']/node()"/></xsl:attribute>
						</img>
					</a>
					&nbsp;
					<a class="btnNormal" href="http://www.newco.dev.br/Administracion/Mantenimiento/TablasAuxiliares/FormasDePago.xsql">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='Formas_de_pago']/node()"/>
					</a>
					&nbsp;
					<a class="btnNormal" href="http://www.newco.dev.br/Administracion/Mantenimiento/TablasAuxiliares/EquivalenciasERP.xsql">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='Equivalencias_ERP']/node()"/>
					</a>
					&nbsp;
					<a class="btnNormal" href="http://www.newco.dev.br/Administracion/Mantenimiento/TablasAuxiliares/OtrasTablas.xsql">
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
        <!--<xsl:if test="/PlazosDePago/PLAZOSDEPAGO/PLAZODEPAGO">-->
            <table class="buscador" style="width:1000px;margin-left:auto;margin-right:auto;">
            	<tr class="SinLinea">
					<th colspan="4">
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='Cliente']/node()"/></label>:&nbsp;
					<xsl:call-template name="desplegable">
						<xsl:with-param name="path" select="/PlazosDePago/PLAZOSDEPAGO/LISTAEMPRESAS/field"/>
						<!--<xsl:with-param name="claSel">muygrande</xsl:with-param>-->
						<xsl:with-param name="style">width:600px;</xsl:with-param>
						<xsl:with-param name="onChange">javascript:selEmpresaChange();</xsl:with-param>
					</xsl:call-template>
					</th>
					<th colspan="1">&nbsp;</th>
            	</tr>
            	<tr class="SinLinea">
            	</tr>
                <tr class="subTituloTabla">	
					<th class="cinco">&nbsp;</th>
					<th align="textCenter" class="diez"><xsl:value-of select="document($doc)/translation/texts/item[@name='id']/node()"/></th>
					<th align="left"><xsl:value-of select="document($doc)/translation/texts/item[@name='plazo_de_pago']/node()"/></th>
					<th class="diez"><xsl:value-of select="document($doc)/translation/texts/item[@name='borrar']/node()"/></th>
					<th class="cinco">&nbsp;</th>
				</tr>
	       		<xsl:for-each select="/PlazosDePago/PLAZOSDEPAGO/PLAZODEPAGO">
                <tr>
					<td>&nbsp;</td>
					<td class="textCenter">
						<xsl:value-of select="ID"/>
					</td>
					<td class="textLeft">
						<xsl:value-of select="DESCRIPCION"/>
					</td>
					<td>
                    	<a href="javascript:Borrar({ID})">
                        	<img src="/images/2017/trash.png"/>
                    	</a>
					</td>
					<td>&nbsp;</td>
                 </tr>
			</xsl:for-each> 
            <tr class="SinLinea">
            </tr>
            <tr class="SinLinea">
				<td>&nbsp;</td>
				<td class="textLeft">
					<input type="text" class="grande" name="DESCRIPCION"/>
				</td>
				<td>
                    <a class="btnDestacado" href="javascript:Insertar();">
                        <xsl:value-of select="document($doc)/translation/texts/item[@name='insertar']/node()"/>
                    </a>
				</td>
             </tr>
	    	</table>
        	<!--</xsl:if>-->
			<br/>
			<br/>
			<br/>
		</form>
        <form name="MensajeJS">
			<input type="hidden" name="SEGURO_BORRAR" value="{document($doc)/translation/texts/item[@name='seguro_de_borrar_registro']/node()}"/>
        </form>
		</xsl:otherwise>
      </xsl:choose> 
      </body>
    </html>
  </xsl:template>  
</xsl:stylesheet>
