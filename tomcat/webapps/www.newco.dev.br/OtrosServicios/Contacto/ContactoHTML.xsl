<?xml version="1.0" encoding="iso-8859-1"?>
<!--
 | ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
 |
 | Fichero.......: ContactoHTML.xsl	
 | Autor.........: Nacho Garcia
 | Fecha.........: 
 | Descripcion...:  
 | Funcionamiento: 
 |
 |Modificaciones:
 |   Fecha:     Autor:      Modificacion:
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
  <xsl:output media-type="text/html" method="html"/> <!-- encoding="iso-8859-1"/>-->
  <xsl:param name="lang" select="@lang"/>  

  <xsl:template match="/">
    <html>
      <head>
        <xsl:text disable-output-escaping="yes"><![CDATA[
	<link rel="stylesheet" href="http://www.newco.dev.br/General/Estilos.css" type="text/css"/>
        <script type="text/javascript" src="http://www.newco.dev.br/General/general.js">
        </script>
	<SCRIPT type="text/javascript">
	<!--
	
	//funciones JavaScript
           			
	-->
	</SCRIPT>
	]]></xsl:text>
      </head>
      <body bgcolor="#EEFFFF">      
        <xsl:choose>
          <xsl:when test="Contacto/xsql-error">
              <xsl:apply-templates select="Contacto/xsql-error"/>
          </xsl:when>
          <xsl:otherwise>   
          <table width="100%" border="1">
            <tr>
              <td>
                
                <input type="text" name="origen" >
                  <xsl:attribute name="value"><xsl:value-of select="/Contacto/CONTACTO/ORIGEN/EMPRESA"/></xsl:attribute>
                </input>
              </td>
              <td></td>
              <td></td>
            </tr>
            <tr>
              <td align="center" valign="top" width="50%">            
	        <xsl:apply-templates select="Contacto/jumpTo"/> 
	      </td>
	      <td>&nbsp;</td>
	      <td align="center" valign="top" width="*">
	        <xsl:apply-templates select="Contacto/button"/>       
	      </td>
	    </tr>
	  </table>
          </xsl:otherwise> 
        </xsl:choose> 
      </body>
    </html>
  </xsl:template>  


<!-- TEMPLATES --> <!-- TEMPLATES --> <!-- TEMPLATES --> <!-- TEMPLATES --> <!-- TEMPLATES -->      



</xsl:stylesheet>
