<?xml version="1.0" encoding="iso-8859-1" ?>
<!--
 |   Lista las Sugerencias pendientes para el usuario.
 |
 |   Dependiendo del estado del documento llamamos al proceso correspondiente.  
 |
 +-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href = "http://www.newco.dev.br/General/General.xsl" />
  <xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
  <xsl:param name="lang" select="@lang"/>  
  <xsl:template match="/">
    <html>
      <head>
	<xsl:text disable-output-escaping="yes"><![CDATA[
	<link rel="stylesheet" href="http://www.newco.dev.br/General/Estilos.css" type="text/css">
        ]]></xsl:text>
      </head>
      <body>
          <xsl:choose>
          <xsl:when test="ListaSugerencias/xsql-error">
            <!-- Mostrar los errores -->
            <xsl:apply-templates select="ListaSugerencias/xsql-error"/>          
          </xsl:when>
          <xsl:otherwise>                   
            <table width="100%" align="center" border="0"  cellpadding="0" cellspacing="0">              
              <tr>
                <td colspan="4" align="center">
                  <xsl:apply-templates select="ListaSugerencias/jumpTo"/>
                </td>
              </tr>
              <tr>
                <td colspan="4"><br/></td>
              </tr>                          
              <tr>
                <td colspan="4">
	          <p class="tituloPag">
	            <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='SU-0200' and @lang=$lang]"/>
	          </p>              
                </td>
              </tr>
              <tr><td colspan="4">&nbsp;</td></tr>
	  <xsl:choose>
	    <xsl:when test="//Sorry"> 
	      <tr><td colspan="4" align="center">    
	        <xsl:apply-templates select="//Sorry"/></td></tr>
	    </xsl:when>
	    <xsl:otherwise>                             
              <tr bgcolor="#A0D8D7">
                <td><p class="tituloCamp">
                  <!-- Estado -->	                            
                  <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='SU-0240' and @lang=$lang]"/>
	          </p></td>
                <td><p class="tituloCamp">
                  <!-- Usuario -->	          
                  <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='SU-0210' and @lang=$lang]"/>
	          </p></td>
                <td><p class="tituloCamp">
                  <!-- Asunto -->	          
                  <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='SU-0220' and @lang=$lang]"/>
	          </p></td>
                <td><p class="tituloCamp">
                  <!-- Fecha Recibido -->	          
                  <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='SU-0230' and @lang=$lang]"/>
                  </p></td>
              </tr>
              <tr><td colspan="4">&nbsp;</td></tr>
              <xsl:for-each select="ListaSugerencias/ROWSET/ROW">
                <tr>
                  <td><xsl:apply-templates select="ESTADO_ACTUAL"/></td>                    
                  <td><xsl:apply-templates select="AUTOR"/></td>
                  <td><xsl:apply-templates select="SU_RESUMEN"/></td>
                  <td><xsl:apply-templates select="SU_FECHA_IN"/></td>
                </tr>
              </xsl:for-each></xsl:otherwise></xsl:choose>
              <tr>
                <td colspan="4"><br/></td>
              </tr>              
              <tr>
                <td colspan="4" align="center">
                  <xsl:apply-templates select="ListaSugerencias/jumpTo"/>
                </td>
              </tr>                           
            </table>
        </xsl:otherwise>
        </xsl:choose>
      </body>
    </html>
  </xsl:template>
    
  <xsl:template match="Sorry">
    <p class="tituloCamp"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='SU-0250' and @lang=$lang]"/></p>
  </xsl:template>
  
  <!-- ** ** ** Empiezan las definiciones ** ** ** ** -->
  <xsl:template match="xsql-error">
    <h1><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='G-1000' and @lang=$lang]"/></h1>
    <h3>On action: <xsl:value-of select="@action"/></h3>
    <h3>Message: <xsl:value-of select="./message"/></h3>
    <h3>Statement:</h3>
    <font size="-1">
    <pre>
    <xsl:value-of select="./statement"/>
    </pre>
    </font>
    <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='G-1001' and @lang=$lang]"/>
    
  </xsl:template>

  <!-- 
   |
   |  Un usuario puede tener una sugerencia pendiente de:
   |
   |  - Analizar (Estado 1=Inicio)
   |  - Dar un resultado (Estado 2=Analisis)
   |  - Revisar el resultado (Estado 3=Dar resultado/Implementar)
   |
   +-->
  <xsl:template match="SU_RESUMEN">
  
    <xsl:choose>
     <xsl:when test="../ESTADO_ACTUAL = 1">
	    <a>
	     <xsl:attribute name="href">SUGenerica.xsql?CODIGO=<xsl:value-of select="../SU_CODIGO"/>&amp;USUARIO=<xsl:value-of select="../USUARIO"/>
	     </xsl:attribute>
	     <xsl:value-of select="."/>
	    </a>
     </xsl:when>
     <xsl:when test="../ESTADO_ACTUAL = 2">
	    <a>
	     <xsl:attribute name="href">SUGenerica.xsql?CODIGO=<xsl:value-of select="../SU_CODIGO"/>&amp;USUARIO=<xsl:value-of select="../USUARIO"/>
	     </xsl:attribute>
	     <xsl:value-of select="."/>
	    </a>
     </xsl:when>
     <xsl:when test="../ESTADO_ACTUAL = 3">
	    <a>
	     <xsl:attribute name="href">SUGenerica.xsql?CODIGO=<xsl:value-of select="../SU_CODIGO"/>&amp;USUARIO=<xsl:value-of select="../USUARIO"/>
	     </xsl:attribute>
	     <xsl:value-of select="."/>
	    </a>
     </xsl:when>
     <xsl:when test="../ESTADO_ACTUAL = 4">
	    <a>
	     <xsl:attribute name="href">SUGenerica.xsql?CODIGO=<xsl:value-of select="../SU_CODIGO"/>&amp;USUARIO=<xsl:value-of select="../USUARIO"/>
	     </xsl:attribute>
	     <xsl:value-of select="."/>
	    </a>
     </xsl:when>
     <xsl:otherwise>
       [Estado Desconocido]
     </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="ESTADO_ACTUAL">
    <xsl:choose>
      <xsl:when test=".=1">
        Inicial
      </xsl:when>
      <xsl:when test=".=2">
        Analizada
      </xsl:when>
      <xsl:when test=".=3">
        Implementada
      </xsl:when>
      <xsl:when test=".=4">
        Revisada
      </xsl:when>
      <xsl:when test=".=5">
        Cerrada
      </xsl:when>
      <xsl:otherwise>
        [Desconocido]
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <xsl:template match="AUTOR">
   <i><a>
    <xsl:attribute name="href">http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/USDetalle.xsql?CODIGO_USUARIO=<xsl:value-of select="../SU_IDAUTOR"/></xsl:attribute>
    <xsl:value-of select="."/>
   </a></i>
  </xsl:template>
  
  <xsl:template match="SU_FECHA_IN">
    <xsl:value-of select="."/>
  </xsl:template>

</xsl:stylesheet>
