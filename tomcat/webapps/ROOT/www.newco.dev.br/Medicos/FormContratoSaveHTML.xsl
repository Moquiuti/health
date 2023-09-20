<?xml version="1.0" encoding="iso-8859-1" ?>
<!--
 | ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
 |Fichero: 
 |Descripcion: 
 |Funcionamiento: 
 |		  Mostramos el resultado del alta
 |
 |Modificaciones:
 |Fecha		Autor		Modificacion
 |
 |
 |
 |Situacion: __Modificacion__
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
        <title>Respuesta</title>
	<xsl:text disable-output-escaping="yes"><![CDATA[
	
	<script type="text/javascript" src="http://www.newco.dev.br/General/general.js">  
	</script>
        
        
        ]]></xsl:text>
        <STYLE>
          .tituloPagForm {COLOR: #015e4b; FONT-FAMILY: Arial, Helvetica, Swiss, Geneva, Sans; FONT-SIZE: 14pt; FONT-WEIGHT: bold}
          .tituloForm {COLOR: #015e4b; FONT-SIZE: 10pt; FONT-WEIGHT: bold}
          .subTituloForm {COLOR: #018167; FONT-SIZE: 9pt; FONT-WEIGHT: bold}      
          .textoForm {COLOR: #000000; FONT-SIZE: 10pt; FONT-WEIGHT: bold}
          .textoLegal {COLOR: #000000; FONT-SIZE: 7pt}
        </STYLE>
        
        
      </head>
      <body bgcolor="#FFFFFF" marginwidth="0" marginheight="0">  
      <form name="form1" action="./" method="post">    
        <xsl:choose>
          <xsl:when test="//xsql-error"> 
          <P class="tituloForm">     
            <xsl:apply-templates select="//xsql-error"/>
          </P>
          </xsl:when>
          <xsl:otherwise>
          <table width="75%" border="0"  align="center">
            <tr>
              <td align="left" height="50" class="tituloPagForm">
              Bienvenido a Medical Virtual Market, S.L.
              </td>
            </tr>
            <tr>
              <td align="justify" class="textoForm">
              
              <p>Gracias por su solicitud de alta a MedicalVM, su nuevo mercado sanitario.</p>
 
<p>Por motivos de seguridad rogamos se conecte a www.mvmnucleo.com y nos llame al teléfono 
93 241 26 99, o al 625 39 53 33 (Sr. Alfonso Linares), y procederemos en
 ese momento a entregarle sus claves personales de entrada.</p>
 
<p>Cordialmente,<br/>
<a href="mailto:comercial@medicalvm.com">Departamento Comercial</a>.</p>
              </td>
            </tr>
            <tr>  
              <td align="justify" height="75" class="textoForm">
              Gracias por su confianza.
              </td>
            </tr>
            <tr>  
              <td>
                <input type="hidden" name="CONTRATO_ALTA">
                  <xsl:attribute name="value"><xsl:value-of select="/Contrato/CODIGO_ALTA"/></xsl:attribute>
                </input>
                <center>
                <input type="button" value="Aceptar" name="btnOK" onClick="window.location='../AreaPublica.xsql'"/>
                </center>
              </td>
            </tr>
            </table>  
          </xsl:otherwise>
        </xsl:choose>
        </form>
      </body>
    </html>
  </xsl:template>  


</xsl:stylesheet>



<!--  

                           __desarrollo__

-->