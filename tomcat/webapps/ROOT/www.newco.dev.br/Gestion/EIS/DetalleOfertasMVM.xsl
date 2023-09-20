<?xml version="1.0" encoding="iso-8859-1" ?>
<!--
 |	
 +-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
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
      <body bgcolor="#EEFFFF" text="#000000" link="#333366" vlink="#333366" alink="#3399ff">      
        <xsl:choose>
      	<!-- ET Desactivado control errores: Habra que reactivarlo
          <xsl:when test="ListaDerechosUsuarios/xsql-error">
            <xsl:apply-templates select="ListaDerechosUsuarios/xsql-error"/>          
          </xsl:when>
	-->
        <xsl:when test="ListadoComisiones/ROWSET/ROW/Sorry">
          <xsl:apply-templates select="ListadoComisiones/ROWSET/ROW/Sorry"/> 
        </xsl:when>
        <xsl:otherwise>
        <table class="grandeInicio">
        <tr class="titleTabla">
        	<th colspan="5">Ofertas Realizadas</th>
        </tr>
	    <!-- Titulo -->
	    <tr class="titulos">	      
	      <td class="dies">Fecha</td>
	      <td class="veinte">Vendedor</td>
 	      <td class="veinte">Cliente</td>
 	      <td class="veinte">Producto</td>
	      <td class="quince">Importe(Ptas)</td></tr>
            <xsl:for-each select="ListadoComisiones/ROW">
              <tr>
                <td><xsl:value-of select="FECHA"/>&nbsp;</td>
                <td><xsl:value-of select="NOMBREEMPRESA"/>&nbsp;</td>
                <td><xsl:value-of select="NOMBRECLIENTE"/>&nbsp;</td>
                <td><xsl:value-of select="PRODUCTO"/>&nbsp;</td>
                <td><xsl:value-of select="COMISIONPTAS"/>&nbsp;</td>
              </tr>
			</xsl:for-each>	    
          </table> 
          <br/><br/>
		  
		  <p align="center">
		  <a href="javascript:history.go(-1)">Volver</a>
		  </p>
	  <!--
	  <div align="center">
            <xsl:apply-templates select="ListaDerechosUsuarios/returnHome"/>
          </div>
	  -->
        </xsl:otherwise>
        </xsl:choose>
      </body>
    </html>
  </xsl:template>  
  
  

</xsl:stylesheet>
