<?xml version="1.0" encoding="iso-8859-1" ?>
<!--
 
   para el detalle de los usuarios
 |
 +-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href = "http://www.newco.dev.br/General/General.xsl" />
  <xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
  <xsl:param name="lang" select="@lang"/>  
  <xsl:template match="/Usuarios">
    <html>
      <head>
	<xsl:text disable-output-escaping="yes"><![CDATA[
	<link rel="stylesheet" href="http://www.newco.dev.br/General/Estilos.css" type="text/css">
        ]]></xsl:text>
        <script type="text/javascript" src="http://www.newco.dev.br/General/general.js">
        </script>
      </head>
      <body bgcolor="#EEFFFF">
          <xsl:choose>
          <xsl:when test="//xsql-error">
            <!-- Mostrar los errores -->
            <xsl:apply-templates select="/Usuarios/xsql-error"/>          
          </xsl:when>
          <xsl:otherwise>
            <table width="100%" align="center" border="0"  cellpadding="0" cellspacing="0">
              <tr bgcolor="#A0D8D7">
                <td colspan="4">
	          <p class="tituloForm">
	            <xsl:value-of select="USUARIO/US_NOMBRE"/>
	          </p>              
                </td>
              </tr>
              <tr>
                <td>
	          <p class="tituloCamp">
	            <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='US-0500' and @lang=$lang]"/>:
	          </p>              
                </td>
                <td>
                        <xsl:value-of select="USUARIO/EMPRESA"/>
                </td>
                <td>
	          <p class="tituloCamp">
	            <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='US-0460' and @lang=$lang]"/>:
	          </p>              
                </td>
                <td>
                        <xsl:value-of select="USUARIO/TIPO_EMPRESA"/>
                </td>
              </tr>                            
              <tr>
                <td>
	          <p class="tituloCamp">
	            <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='US-0490' and @lang=$lang]"/>:
	          </p>              
                </td>
                <td>
                        <xsl:value-of select="USUARIO/TIPO_USUARIO"/>
                </td>
                <td>
	          <p class="tituloCamp">
	            <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='US-0220' and @lang=$lang]"/>:
	          </p>              
                </td>
                <td>
                        <xsl:value-of select="USUARIO/CEN_NOMBRE"/>
                </td>                
              </tr>              
              <tr>
               <td>
	          <p class="tituloCamp">
	            <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='US-0470' and @lang=$lang]"/>:
	          </p>              
                </td>
                <td>
                        <xsl:value-of select="USUARIO/CEN_POBLACION"/>
                </td>                
                <td>
	          <p class="tituloCamp">
	            <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='US-0480' and @lang=$lang]"/>:
	          </p>              
                </td>
                <td>
                        <xsl:value-of select="USUARIO/CEN_PROVINCIA"/>
                </td>                
              </tr>
              <tr> 
                <td>
	          <p class="tituloCamp">
	            <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='US-0290' and @lang=$lang]"/>:
	          </p>              
                </td>              
                <td>
                        <a>
                        <xsl:attribute name="href">mailto:<xsl:value-of select="USUARIO/US_EMAIL"/></xsl:attribute>
                        <xsl:value-of select="USUARIO/US_EMAIL"/>
                        </a>
                </td> 
                <td>
	          <p class="tituloCamp">
	            <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='US-0270' and @lang=$lang]"/>:
	          </p>              
                </td>
                <td>
                        <xsl:value-of select="USUARIO/IDIOMA"/>
                </td>
              </tr>                                                     
            </table>
            <br/>
            <br/>
            <center><xsl:apply-templates select="jumpTo"/></center>
        </xsl:otherwise>
        </xsl:choose>
      </body>
    </html>
  </xsl:template>
    

</xsl:stylesheet>
