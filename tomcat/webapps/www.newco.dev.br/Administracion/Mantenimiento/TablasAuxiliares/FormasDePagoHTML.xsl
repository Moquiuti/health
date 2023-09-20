<?xml version="1.0" encoding="iso-8859-1" ?>
<!--	
	Mantenimiento de plazos de pago, para usuarios MVM
	Ultima revision: ET 18nov21 11:35 FormasDePago_18nov21.js
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
            <xsl:when test="/FormasDePago/LANG"><xsl:value-of select="/FormasDePago/LANG" /></xsl:when>
            <xsl:otherwise>spanish</xsl:otherwise>
            </xsl:choose>  
        </xsl:variable>
        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>        <!--idioma fin-->
        
	<title><xsl:value-of select="document($doc)/translation/texts/item[@name='Tablas_auxiliares']/node()"/>:&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Formas_de_pago']/node()"/></title>
       <!--style-->
      <xsl:call-template name="estiloIndip"/>
      <!--fin de style-->  

    <script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/descargas_151117.js"></script>		<!-- Para descargas excel	-->
	<script type="text/javascript" src="http://www.newco.dev.br/Administracion/Mantenimiento/TablasAuxiliares/FormasDePago_18nov21.js"></script>
     
	<script type="text/javascript">
	var strID='<xsl:value-of select="document($doc)/translation/texts/item[@name='id']/node()"/>';
	var strForma='<xsl:value-of select="document($doc)/translation/texts/item[@name='forma_de_pago']/node()"/>';
	<!--	Ofertas vencedoras y alternativas. Listado Excel		-->

	var numColumnas=0;
	var arrFormas			= new Array();
	<xsl:for-each select="/FormasDePago/FORMASDEPAGO/FORMADEPAGO">
		var Forma			= [];
		Forma['ID']	= '<xsl:value-of select="ID"/>';
		Forma['Descripcion']	= '<xsl:value-of select="DESCRIPCION"/>';
		arrFormas.push(Forma);
	</xsl:for-each>
	</script>
        
      </head>
      <body>   
      <!--idioma-->
         <xsl:variable name="lang">
        <xsl:choose>
            <xsl:when test="/FormasDePago/LANG"><xsl:value-of select="/FormasDePago/LANG" /></xsl:when>
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
		<form action="http://www.newco.dev.br/Administracion/Mantenimiento/TablasAuxiliares/FormasDePago.xsql" name="Form" method="POST">
		<input type="hidden" name="ACCION"/>
		<input type="hidden" name="PARAMETROS"/>

		<!--	Titulo de la página		-->
		<div class="ZonaTituloPagina">
			<p class="Path"><xsl:value-of select="document($doc)/translation/texts/item[@name='Inicio']/node()"/>&nbsp;/&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Tablas_auxiliares']/node()"/>&nbsp;/&nbsp;<span class="FinPath"><xsl:value-of select="document($doc)/translation/texts/item[@name='Formas_de_pago']/node()"/></span></p>
			<p class="TituloPagina">
      			<xsl:choose>
        		<xsl:when test="/FormasDePago/FORMASDEPAGO/MENSAJE != ''">
					<xsl:value-of select="/FormasDePago/FORMASDEPAGO/MENSAJE"/>
        		</xsl:when>
        		<xsl:otherwise>
					<xsl:value-of select="document($doc)/translation/texts/item[@name='Formas_de_pago']/node()"/>
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
					<a class="btnNormal" href="http://www.newco.dev.br/Administracion/Mantenimiento/TablasAuxiliares/PlazosDePago.xsql">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='Plazos_de_pago']/node()"/>
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
        <xsl:if test="/FormasDePago/FORMASDEPAGO/FORMADEPAGO">
            <table class="buscador" style="width:1000px;margin-left:auto;margin-right:auto;">
                <tr class="subTituloTabla">	
					<th class="cinco">&nbsp;</th>
					<th align="textCenter" class="diez"><xsl:value-of select="document($doc)/translation/texts/item[@name='id']/node()"/></th>
					<th align="left"><xsl:value-of select="document($doc)/translation/texts/item[@name='forma_de_pago']/node()"/></th>
					<th class="cinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='borrar']/node()"/></th>
					<th class="cinco">&nbsp;</th>
				</tr>
	       		<xsl:for-each select="/FormasDePago/FORMASDEPAGO/FORMADEPAGO">
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
        	</xsl:if>
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
