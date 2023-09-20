<?xml version="1.0" encoding="iso-8859-1" ?>
<!--
 |	Estadisticas de acceso de los usuarios en MedicalVM
 |
 |	(c) 12/1/2001 ET
 |	
 +-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href = "http://www.newco.dev.br/General/General.xsl" />
  <xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
  <xsl:param name="lang" select="@lang"/>  
  <xsl:template match="/">
    <html>
      <head>
    
	<title><xsl:value-of select="TITULO" disable-output-escaping="yes"/></title>
	  <!--style-->
      <xsl:call-template name="estiloIndip"/>
      <!--fin de style-->  

     <script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
	 <script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>
      </head>
      <body>      
        <xsl:choose>
    
        <xsl:when test="PedidoGPP/ROWSET/ROW/Sorry">
          <xsl:apply-templates select="PedidoGPP/ROWSET/ROW/Sorry"/> 
        </xsl:when>
        <xsl:otherwise>
		
        <!--idioma-->
        <xsl:variable name="lang">
        <xsl:choose>
            <xsl:when test="/AccesosUsuarios/LANG"><xsl:value-of select="/AccesosUsuarios/LANG" /></xsl:when>
            <xsl:otherwise>spanish</xsl:otherwise>
            </xsl:choose>  
        </xsl:variable>

        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>      		        <!--idioma fin-->
      
    	<h1 class="titlePage">
        	<xsl:value-of select="document($doc)/translation/texts/item[@name='historico_accesos_correctos']/node()"/>
				 (<xsl:value-of select="document($doc)/translation/texts/item[@name='total']/node()"/>: <xsl:value-of select="AccesosUsuarios/USUARIOS/TOTAL/TOTAL"/>)
		</h1>
        <div class="divLeft">
		<table class="grandeInicio">
        	<thead>
			
	       <tr class="titulos">
	      	<td class="dies"><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha']/node()"/></td>
	      	<td class="quince"><xsl:value-of select="document($doc)/translation/texts/item[@name='empresa']/node()"/></td>
	      	<td class="veinte"><xsl:value-of select="document($doc)/translation/texts/item[@name='usuario']/node()"/></td>
	      	<td class="trentacinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='navegador']/node()"/></td>
	      	<td class="dies"><xsl:value-of select="document($doc)/translation/texts/item[@name='direccion_ip']/node()"/></td>
	      	<td class="dies"><xsl:value-of select="document($doc)/translation/texts/item[@name='resolucion']/node()"/></td>
		  </tr>
          </thead>
          <tbody>
          <xsl:for-each select="AccesosUsuarios/USUARIOS/ROW">
            <tr>
                <td><xsl:value-of select="FECHA"/>&nbsp;</td>
                <td><xsl:value-of select="EMPRESA"/>&nbsp;</td>
                <td>
					<a>
					<xsl:attribute name="href">javascript:MostrarPag('SeguimientoSesion.xsql?SESION=<xsl:value-of select="SESION"/>&amp;NOMBREUSUARIO=<xsl:value-of select="NOMBREUSUARIO"/>', 'SeguimientoSesion');
					</xsl:attribute>
					<xsl:value-of select="NOMBREUSUARIO"/>&nbsp;
					</a></td>
                <td><xsl:value-of select="NAVEGADOR"/>&nbsp;</td>
                <td><xsl:value-of select="IP"/>&nbsp;</td>
                <td><xsl:value-of select="RESOLUCION"/>&nbsp;</td>
			</tr>
		  </xsl:for-each>	
          </tbody>    
        </table> 
		<br/><br/>
        </div>
         <div class="divLeft">
	    <h1 class="titlePage">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='paginas_visitadas_ultimas_48_horas']/node()"/> (<xsl:value-of select="document($doc)/translation/texts/item[@name='total']/node()"/>: <xsl:value-of select="/AccesosUsuarios/PAGINAS/TOTAL"/>)
		</h1>
       
        <table class="grandeInicio">
        <thead>
	    <!-- Titulos -->
          <tr class="titulos">
          	<td class="trentacinco">&nbsp;</td>
	      	<td class="veinte"><xsl:value-of select="document($doc)/translation/texts/item[@name='pagina']/node()"/></td>
	      	<td class="dies"><xsl:value-of select="document($doc)/translation/texts/item[@name='visitas']/node()"/></td>
            <td>&nbsp;</td>
		  </tr>
         </thead>
          <xsl:for-each select="/AccesosUsuarios/PAGINAS/ROW">
            <tr>
            	<td>&nbsp;</td>
                <td>
					<xsl:value-of select="LA_PAGINA"/>
				</td>
                <td><xsl:value-of select="TOTAL"/>&nbsp;</td>
                <td>&nbsp;</td>
			</tr>
		  </xsl:for-each>	    
        </table> 
		</div>
        </xsl:otherwise>
        </xsl:choose>
      </body>
    </html>
  </xsl:template>  
  
  

</xsl:stylesheet>
