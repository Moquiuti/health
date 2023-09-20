<?xml version="1.0" encoding="iso-8859-1" ?>
<!--
 | ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
 |
 | Fichero.......: 
 | Autor.........:
 | Fecha.........:
 | Descripcion...: 
 | Funcionamiento: 
 |
 |Modificaciones:
 |   Fecha       Autor          Modificacion
 |
 |
 |
 | Situacion: __Desarrollo__

 |
 |(c) 2001 MedicalVM
 |///////////////////////////////////////////////////////////////////////////////////////////////////////////////////   
 +-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href = "http://www.newco.dev.br/General/General.xsl" />
  <xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
  <xsl:param name="lang" select="@lang"/>  
  <xsl:template match="/">
    <html>
      <head>
        <title><xsl:value-of select="Alerta/TITULO" disable-output-escaping="yes"/></title>
	      
	      <xsl:text disable-output-escaping="yes"><![CDATA[
	        <link rel="stylesheet" href="http://www.newco.dev.br/General/Estilos.css" type="text/css">
	        <script type="text/javascript" src="http://www.newco.dev.br/General/general.js"></script>
	        <script type="text/javascript">
	          <!--
	            function CerrarVentana(){
	              window.opener.focus();
	              window.close();
	            }
	
	          //-->   	
	        </script>
        
        ]]></xsl:text>
      </head>
      <body>     
        <table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">
          <tr align="center" valign="middle">
            <td>
              <table width="90%" height="90%" cellpadding="5" cellspacing="1" class="muyoscuro" border="0">
                <tr align="center" valign="middle" class="claro">
                  <td>
                    <table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">
                      <tr align="center" valign="middle" height="50px">
                        <td>
                          <font color="red" size="3">
                            <b><u><xsl:value-of select="Alerta/TITULO"/></u></b>
                          </font>
                        </td>
                      </tr>
                      <tr align="justyfy" valign="top" height="*">
                        <td>
                          <font align="justify">
                            <xsl:variable name="vCODIGO_MENSAJE" select="Alerta/CODIGO_MENSAJE"/>
                            <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id=$vCODIGO_MENSAJE and @lang=$lang]" disable-output-escaping="yes"/>
                          </font>
                        </td>
                      </tr>
                    </table>
                  </td>
                </tr>
              </table>
            </td>
          </tr>
          <tr align="center" valign="bottom">
            <td>
              <xsl:call-template name="boton">
                <xsl:with-param name="path" select="Alerta/button[@label='Cerrar']"/>
              </xsl:call-template>
            </td>
          </tr>
        </table>
      </body>
    </html>
  </xsl:template>  
    
</xsl:stylesheet>
