<?xml version="1.0" encoding="iso-8859-1"?>
<!--
 |   Guarda Errores en la base de datos. 
 |
 |   Si se vuelve a producir un error... 
 |      lo tratamos localmente, sino entrariamos en un bucle.
 |
 |  
 +-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href = "http://www.newco.dev.br/General/General.xsl"/>
  <xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
  <xsl:param name="lang" select="@lang"/>  
  <xsl:template match="/">
    <html>
      <head>
        <!-- MedicalVM - Your Virtual Market -->      
        <title><xsl:value-of select="document('messages.xml')/messages/msg[@id='G-0000' and @lang=$lang]"/></title>
	<xsl:text disable-output-escaping="yes"><![CDATA[
	<link rel="stylesheet" href="Estilos.css" type="text/css">
        <script type="text/javascript" src="http://www.newco.dev.br/General/general.js">
        </script>
        ]]></xsl:text>
      </head>
      <body bgcolor="#EEFFFF">
          <xsl:choose>
          <xsl:when test="GuardaError/xsql-error">
            <!-- Mostrar los errores -->
            <xsl:apply-templates select="GuardaError/xsql-error"/>          
          </xsl:when>
          <xsl:otherwise>
          <!-- No hay error, Damos las gracias y Saltamos -->
          <p class="tituloPag">
            <xsl:value-of select="document('messages.xml')/messages/msg[@id='OK-0140' and @lang=$lang]"/>
          </p>
          <hr/>
          <p class="tituloCamp">
            <xsl:value-of select="document('messages.xml')/messages/msg[@id='OK-1040' and @lang=$lang]"/>
          </p>      
          <center>
           <xsl:apply-templates select="GuardaError/jumpTo"/>
          </center>
          </xsl:otherwise>
          </xsl:choose>
      </body>
    </html>
  </xsl:template>

  <!--Ponemos aqui el template xsql-error para que G-error no genere un llamada recursiva 
      a este. Ahora no permitimos llamar a G-error desde G-error porque no permitimos el
      envio de la incidencia-->
  
  <xsl:template match="xsql-error">
    <!-- No lo podemos dentro del xsql-error porque pueden haber caracteres que nos
        impidan enviar el formulario: p.ej: '
      -->
    <xsl:comment>
      On action: <xsl:value-of select="@action"/>
      Message:<xsl:value-of select="./message"/>
      Statement:<xsl:value-of select="./statement"/>
    </xsl:comment>
      <p class="tituloPag"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='G-1000' and @lang=$lang]"/><hr/></p>
      <p class="tituloCamp"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='G-1001' and @lang=$lang]"/></p>
      <center><xsl:apply-templates select="../jumpTo"/></center>
  </xsl:template>
       
</xsl:stylesheet>
