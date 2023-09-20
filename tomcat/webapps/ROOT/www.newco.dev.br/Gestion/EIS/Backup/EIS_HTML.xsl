<?xml version="1.0" encoding="iso-8859-1" ?>
<!--
 |	Presentacion de datos estadisticos de utilizacion de la plataforma MedicalVM
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
    
	<title>Indicadores de Transacciones</title>
	   <!--style-->
      <xsl:call-template name="estiloIndip"/>
      <!--fin de style-->  

     <script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
	 <script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>
     
      <body>      
        <xsl:choose>
      	<!-- ET Desactivado control errores: Habra que reactivarlo
          <xsl:when test="ListaDerechosUsuarios/xsql-error">
            <xsl:apply-templates select="ListaDerechosUsuarios/xsql-error"/>          
          </xsl:when>
	-->
        <xsl:when test="ListaDerechosUsuarios/ROWSET/ROW/Sorry">
          <xsl:apply-templates select="IndicadoresMVM/ROWSET/ROW/Sorry"/> 
        </xsl:when>
        <xsl:otherwise>
	    <!-- Titulo -->
	    <p class="tituloPag" align="center">Indicadores de control</p>
		<br/><br/>

        <table width="80%" border="1" align="center" cellspacing="0" cellpadding="0" >
	    <tr align="center" bgcolor="#CCCCCC">	      
	      <td><p width="55%" class="tituloCamp">Indicador</p></td>
	      <td><p width="15%" class="tituloCamp">Dia</p></td>
	      <td><p width="15%" class="tituloCamp">Semana</p></td>
	      <td><p width="15%" class="tituloCamp">Últimos 365 días</p></td></tr>
	    
         <xsl:for-each select="IndicadoresMVM/BLOQUE">
		 	<tr>
            	<td width="100%" align="center" colspan="5">&nbsp;
				</td>
		 	</tr>
		 	<tr>
                <td width="100%" bgcolor="#CCCCCC" align="center" colspan="5"><xsl:value-of select="@name"/>&nbsp;
				</td>
			</tr>
         	<xsl:for-each select="ROW">
			<!--<xsl:value-of select="INDICADOR">-->
              <tr>
                <td width="55%"><xsl:value-of select="@name"/>&nbsp;
				</td>
				<td width="15%" align="right">
					<a>
						<xsl:attribute name="HREF"><xsl:value-of select="@link"/>?periodo=1</xsl:attribute>
						<xsl:value-of select="DIA/VALOR"/>
					</a>&nbsp;
				</td>
				<td width="15%" align="right">
					<a>
						<xsl:attribute name="HREF"><xsl:value-of select="@link"/>?periodo=7</xsl:attribute>
						<xsl:value-of select="SEMANA/VALOR"/>
					</a>&nbsp;
				</td>
				<td width="15%" align="right">
					<a>
						<xsl:attribute name="HREF"><xsl:value-of select="@link"/>?periodo=365</xsl:attribute>
						<xsl:value-of select="ANNO/VALOR"/>
					</a>&nbsp;
				</td>
              </tr>
			<!--<xsl:value-of>-->
			</xsl:for-each> 
		</xsl:for-each> 
		</table> 
        <br/><br/>
		<p align="center">
		<a href="DetalleComisionesMVM.xsql">Listado de pedidos y comisiones</a><br/>
		<a href="DetalleOfertasMVM.xsql">Listado de ofertas</a>
		</p>
        </xsl:otherwise>
        </xsl:choose>
      </body>
    </html>
  </xsl:template>  
  
  

</xsl:stylesheet>
