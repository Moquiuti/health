<?xml version="1.0" encoding="iso-8859-1" ?>
<!--
 |	
 +-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:import href = "http://www.newco.dev.br/General/General.xsl" />
  <xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
  <xsl:param name="lang" select="@lang"/>  
  <xsl:template match="/">
    <html>
      <head>
     <!--idioma-->
         <xsl:variable name="lang">
        <xsl:choose>
            <xsl:when test="/ListadoErrores/LANG"><xsl:value-of select="/ListadoErrores/LANG" /></xsl:when>
            <xsl:otherwise>spanish</xsl:otherwise>
            </xsl:choose>  
        </xsl:variable>
        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>      <!--idioma fin-->
        
	<title><xsl:value-of select="TITULO" disable-output-escaping="yes"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='errores_producidos']/node()"/></title>
	 <!--style-->
      <xsl:call-template name="estiloIndip"/>
      <!--fin de style-->  

     <script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
	 <script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>

      </head>
      <body>      
       <!--idioma-->
         <xsl:variable name="lang">
        <xsl:choose>
            <xsl:when test="/ListadoErrores/LANG"><xsl:value-of select="/ListadoErrores/LANG" /></xsl:when>
            <xsl:otherwise>spanish</xsl:otherwise>
            </xsl:choose>  
        </xsl:variable>
        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>      <!--idioma fin-->
        
        <xsl:choose>
    
        <xsl:when test="/ListadoErrores/ROWSET/ROW/Sorry">
          <xsl:apply-templates select="ListadoErrores/ROWSET/ROW/Sorry"/> 
        </xsl:when>
        <xsl:otherwise>
	    <!-- Titulo -->
	      <h1 class="titlePage"><xsl:value-of select="document($doc)/translation/texts/item[@name='errores_producidos']/node()"/></h1>
          <table class="buscador">
          <thead>
          <tr class="subTituloTabla">
	      	<td class="dies"><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha']/node()"/></td>
	      	<td class="veinte"><xsl:value-of select="document($doc)/translation/texts/item[@name='procedimiento']/node()"/></td>
	      	<td><xsl:value-of select="document($doc)/translation/texts/item[@name='mensaje']/node()"/></td>
		  </tr>
          </thead>
          <tbody>
           <xsl:for-each select="/ListadoErrores/ERRORES/ROW">
              <tr class="sinLinea">
                <td><xsl:value-of select="FECHA"/></td>
                <td class="textLeft"><xsl:value-of select="ERR_TABLA"/>:::<xsl:value-of select="ERR_FICHERO"/></td>
                <td class="textLeft"><xsl:value-of select="MENSAJE"/></td>
				</tr>
			</xsl:for-each>	  
          </tbody>  
          </table> 
          <br/><br/>
	      <h1 class="titlePage"><xsl:value-of select="document($doc)/translation/texts/item[@name='info_log_edu']/node()"/></h1>
           <table class="buscador">
           <thead>
           <tr class="subTituloTabla">
	      	<td class="dies"><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha']/node()"/></td>
	      	<td><xsl:value-of select="document($doc)/translation/texts/item[@name='mensaje']/node()"/></td>
		  </tr>
          </thead>
          <tbody>
           <xsl:for-each select="/ListadoErrores/LOGEDU/ROW">
              <tr>
                <td><xsl:value-of select="FECHA"/></td>
                <td class="textLeft"><xsl:value-of select="MENSAJE"/></td>
				</tr>
			</xsl:for-each>	   
          </tbody> 
          </table> 
          <br/><br/>
	  <!--    <h1 class="titlePage"><xsl:value-of select="document($doc)/translation/texts/item[@name='info_log_admin']/node()"/></h1>
          <table class="buscador">
          <thead>
           <tr class="subTituloTabla">
	      	<td class="dies"><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha']/node()"/></td>
	      	<td class="dies"><xsl:value-of select="document($doc)/translation/texts/item[@name='idusuario']/node()"/></td>
	      	<td class="dies"><xsl:value-of select="document($doc)/translation/texts/item[@name='idcambio']/node()"/></td>
	      	<td class="dies"><xsl:value-of select="document($doc)/translation/texts/item[@name='tabla']/node()"/></td>
	      	<td class="dies"><xsl:value-of select="document($doc)/translation/texts/item[@name='idregistro']/node()"/></td>
	      	<td class="cinquenta"><xsl:value-of select="document($doc)/translation/texts/item[@name='cambio']/node()"/></td>
		  </tr>
          </thead>
          <tbody>
           <xsl:for-each select="/ListadoErrores/LOGADMINISTRACION/ROW">
              <tr>
                <td align="center"><xsl:value-of select="FECHA"/>&nbsp;</td>
                <td align="center"><xsl:value-of select="IDUSUARIO"/>&nbsp;</td>
                <td align="center"><xsl:value-of select="IDCAMBIO"/>&nbsp;</td>
                <td align="left"><xsl:value-of select="TABLA"/>&nbsp;</td>
                <td align="center"><xsl:value-of select="IDREGISTRO"/>&nbsp;</td>
                <td align="left"><xsl:value-of select="CAMBIO"/>&nbsp;</td>
				</tr>
			</xsl:for-each>	    
            </tbody>
          </table> 
          <br/><br/>
	      <h1 class="titlePage"><xsl:value-of select="document($doc)/translation/texts/item[@name='info_log_limpieza']/node()"/></h1>
          <table class="buscador">
          <thead>
           <tr class="subTituloTabla">
	      	<td class="dies"><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha']/node()"/></td>
	      	<td><xsl:value-of select="document($doc)/translation/texts/item[@name='mensaje']/node()"/></td>
		  </tr>
          </thead>
          <tbody>
           <xsl:for-each select="/ListadoErrores/LOGLIMPIEZA/ROW">
              <tr>
                <td align="center"><xsl:value-of select="FECHA"/></td>
                <td align="left"><xsl:value-of select="TXT"/></td>
				</tr>
			</xsl:for-each>	    
           </tbody>
          </table> 
          <br/><br/>
	      <h1 class="titlePage"><xsl:value-of select="document($doc)/translation/texts/item[@name='info_log_pedidos_progr']/node()"/></h1>
          <table class="buscador">
          <thead>
           <tr class="subTituloTabla">
	      	<td class="quince"><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha']/node()"/></td>
	      	<td class="quince"><xsl:value-of select="document($doc)/translation/texts/item[@name='idusuario']/node()"/></td>
	      	<td class="quince"><xsl:value-of select="document($doc)/translation/texts/item[@name='idprograma']/node()"/></td>
	      	<td class="quince"><xsl:value-of select="document($doc)/translation/texts/item[@name='idoferta']/node()"/></td>
	      	<td class="quince"><xsl:value-of select="document($doc)/translation/texts/item[@name='proximo_lanzamiento']/node()"/></td>
	      	<td><xsl:value-of select="document($doc)/translation/texts/item[@name='status']/node()"/></td>
		  </tr>
          </thead>
          <tbody>
           <xsl:for-each select="/ListadoErrores/LOG_PEDIDOSPROGRAMADOS/ROW">
              <tr>
                <td><xsl:value-of select="FECHA"/></td>
                <td><xsl:value-of select="LPP_USUARIO"/></td>
                <td><xsl:value-of select="LPP_IDPEDIDOPROGRAMADO"/></td>
                <td><xsl:value-of select="LPP_IDOFERTA"/></td>
                <td><xsl:value-of select="LPP_PROXIMOLANZAMIENTO"/>;</td>
                <td class="textLeft"><xsl:value-of select="LPP_STATUS"/></td>
				</tr>
			</xsl:for-each>	  
          </tbody>  
          </table> 
          <br/><br/>
	      <h1 class="titlePage"><xsl:value-of select="document($doc)/translation/texts/item[@name='info_log_cargas']/node()"/></h1>
           <table class="buscador">
          <thead>
           <tr class="subTituloTabla">
	      	<td class="quince"><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha']/node()"/></td>
	      	<td class="quince"><xsl:value-of select="document($doc)/translation/texts/item[@name='idcargas']/node()"/></td>
	      	<td><xsl:value-of select="document($doc)/translation/texts/item[@name='mensaje']/node()"/></td>
		  </tr>
          </thead>
          <tbody>
           <xsl:for-each select="/ListadoErrores/LOGCARGAS/ROW">
              <tr>
                <td><xsl:value-of select="FECHA"/></td>
                <td><xsl:value-of select="IDCARGA"/></td>
                <td class="textLeft"><xsl:value-of select="MENSAJE"/></td>
				</tr>
			</xsl:for-each>	    
            </tbody>
          </table> 
          <br/><br/>
	      <h1 class="titlePage"><xsl:value-of select="document($doc)/translation/texts/item[@name='info_log_preciosref']/node()"/></h1>
           <table class="buscador">
          <thead>
           <tr class="subTituloTabla">
	      	<td class="quince"><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha']/node()"/></td>
	      	<td><xsl:value-of select="document($doc)/translation/texts/item[@name='mensaje']/node()"/></td>
		  </tr>
          </thead>
          <tbody>
           <xsl:for-each select="/ListadoErrores/LOGPRECIOSREFERENCIA/ROW">
              <tr>
                <td align="center"><xsl:value-of select="FECHA"/></td>
                <td align="left"><xsl:value-of select="MENSAJE"/></td>
				</tr>
			</xsl:for-each>	  
          </tbody>  
          </table> 
          <br/><br/>-->
        </xsl:otherwise>
        </xsl:choose>
      </body>
    </html>
  </xsl:template>  
  
  

</xsl:stylesheet>
