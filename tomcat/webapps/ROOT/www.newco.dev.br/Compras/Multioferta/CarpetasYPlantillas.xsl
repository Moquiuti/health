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
        <!-- 
	<title><xsl:value-of select="document('messages.xml')/messages/msg[@id='USD-1010' and @lang=$lang]" disable-output-escaping="yes"/></title>
	-->
	<title><xsl:value-of select="TITULO" disable-output-escaping="yes"/></title>
	<xsl:text disable-output-escaping="yes"><![CDATA[
	<link rel="stylesheet" href="http://www.newco.dev.br/General/Estilos.css" type="text/css">
	<script type="text/javascript" src="http://www.newco.dev.br/General/general.js">
	</script>
	<script type="text/javascript">
	  <!--
	    function EjecutarFuncionDelFrame(nombreFrame,idPlantilla){
	      var objFrame=new Object();
	      objFrame=obtenerFrame(top, nombreFrame);
	      objFrame.CambioPlantillaExterno(idPlantilla);
	    }
	  //-->
	</script>
        ]]></xsl:text>
      </head>
      <body class="blanco" text="#000000" link="#333366" vlink="#333366" alink="#3399ff">      
        <xsl:choose>
      	<!-- ET Desactivado control errores: Habra que reactivarlo
          <xsl:when test="ListaDerechosUsuarios/xsql-error">
            <xsl:apply-templates select="ListaDerechosUsuarios/xsql-error"/>          
          </xsl:when>
	-->
        <xsl:when test="CarpetasYPlantillas/SESION_CADUCADA">
          <xsl:apply-templates select="CarpetasYPlantillas/SESION_CADUCADA"/> 
        </xsl:when>
        <xsl:when test="CarpetasYPlantillas/ROWSET/ROW/Sorry">
          <xsl:apply-templates select="CarpetasYPlantillas/ROWSET/ROW/Sorry"/> 
        </xsl:when>
        <xsl:otherwise>
		<br/><br/>
        <table width="100%" border="0" align="center" cellspacing="1" cellpadding="1" class="gris">
		<tr class="grisclaro">
		<td align="left">
		<table width="100%" class="blanco" cellspacing="1" cellpadding="1">
				    <tr  class="grisclaro">
				      <td align="left" class="grisclaro">
				        <B>Carpetas y Plantillas</B>	
				        <br/>
				        <i>Listado de todas las carpetas, plantillas y número de productos que contienen.</i>
				      </td>
				    </tr>
				  </table>
        <table width="100%" border="0" align="center" cellspacing="1" cellpadding="1" class="gris">
            <tr class="oscuro">
                <td align="left">Listado</td>
                <td align="center">Productos</td>
			</tr>
          <xsl:for-each select="CarpetasYPlantillas/CARPETAS/CARPETA">
            <tr class="medio">
                <td align="left" colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;<xsl:value-of select="NOMBRE"/>&nbsp;</td>
			</tr>
          	<xsl:for-each select="./PLANTILLA">
            <tr class="claro" onMouseOver="this.className='blanco'" onMouseOut="this.className='claro'">
                <td align="left">
                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                  <a href="javascript:EjecutarFuncionDelFrame('zonaPlantilla',{ID});"  onMouseOver="window.status='Activa la plantilla';return true;" onMouseOut="window.status='';return true;">
                    <xsl:value-of select="NOMBRE"/>
                  </a>
                  &nbsp;
                </td>
                <td align="center"><xsl:value-of select="LINEAS"/>&nbsp;</td>
			</tr>
		    </xsl:for-each>	    
		  </xsl:for-each>	    
          <tr class="medio">
                <td align="right">TOTAL</td>
                <td align="center"><xsl:value-of select="CarpetasYPlantillas/CARPETAS/TOTAL"/>&nbsp;</td>
		  </tr>
        </table> 
		</td>
		</tr>
		</table>
        </xsl:otherwise>
        </xsl:choose>
      </body>
    </html>
  </xsl:template>  
</xsl:stylesheet>
