<?xml version="1.0" encoding="iso-8859-1" ?>
<!--
 |  This stylesheet implements multi-language at the UI level
 |  It is based on the parameter 'lang' that is 'english' by default.
 |  It can be also 'french' or 'spanish' or 'german'.
 +-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href = "http://www.newco.dev.br/General/General.xsl"/>
  <xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
  <xsl:param name="lang" select="@lang"/>  
  <xsl:template match="/">
    <html>
      <head>
        <title><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='EMP-0010' and @lang=$lang]" disable-output-escaping="yes"/></title>
	<xsl:text disable-output-escaping="yes"><![CDATA[
	<link rel="stylesheet" href="http://www.newco.dev.br/General/Estilos.css" type="text/css">
        ]]></xsl:text>
      </head>
      <body bgcolor="#EEFFFF">      
      <xsl:apply-templates select="ListaEmpresas/Status"/>
       <xsl:choose>
          <xsl:when test="ListaEmpresas/xsql-error">
            <!-- Mostrar los errores -->
            <xsl:apply-templates select="ListaEmpresas/xsql-error"/>          
          </xsl:when>
        <xsl:when test="ListaEmpresas/ROWSET/ROW/Sorry">
          <xsl:apply-templates select="ListaEmpresas/ROWSET/ROW/Sorry"/>
          <center><xsl:apply-templates select="//jumpTo"/></center> 
        </xsl:when>
        <xsl:otherwise>
          <table width="80%" border="0" align="center" cellspacing="0" cellpadding="0" >
	    <!-- Formulario de datos -->
	    <tr bgcolor="#A0D8D7"> 
	      <td valign="top" colspan="3">  
	        <p class="tituloForm">      
	            <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='EMP-0010' and @lang=$lang]" disable-output-escaping="yes"/>
	        </p></td>
	    </tr>  	                     
            <tr>
              <td><p class="tituloCamp">
                <!-- Nombre Empresa -->
                <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='EMP-0050' and @lang=$lang]" disable-output-escaping="yes"/>
                </p></td>
              <td><p class="tituloCamp">
                <!-- Poblacion -->
                <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='EMP-0090' and @lang=$lang]" disable-output-escaping="yes"/>
                </p></td>
              <td><p class="tituloCamp">
                <!-- Tipo Empresa -->
                <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='EMP-0100' and @lang=$lang]" disable-output-escaping="yes"/>
                </p></td>
            </tr>
            <xsl:for-each select="ListaEmpresas/ROWSET/ROW">
              <tr>
                <td width="40%"><xsl:apply-templates select="EMP_NOMBRE"/>&nbsp;</td>
                <td width="30%"><xsl:apply-templates select="EMP_POBLACION"/>&nbsp;</td>
                <td width="30%"><xsl:apply-templates select="TE_DESCRIPCION"/>&nbsp;</td>
              </tr>
            </xsl:for-each>
          </table> 
          <br/><br/>
	  <div align="center">
            <xsl:apply-templates select="ListaEmpresas/jumpTo"/>
        </div>
        </xsl:otherwise>
        </xsl:choose>
      </body>
    </html>
  </xsl:template>  


<!-- TEMPLATES --> <!-- TEMPLATES --> <!-- TEMPLATES --> <!-- TEMPLATES --> <!-- TEMPLATES -->
  
  <xsl:template match="EMP_ID">
        <xsl:value-of select="."/> 
   </xsl:template> 
 
  <xsl:template match="xsql-error">
    <h1><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='G-1000' and @lang=$lang]" disable-output-escaping="yes"/></h1>
    <h3>On action: <xsl:value-of select="@action"/></h3>
    <h3>Message: <xsl:value-of select="./message"/></h3>
    <h3>Statement:</h3>
    <xsl:value-of select="./statement"/>

    <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='G-1001' and @lang=$lang]" disable-output-escaping="yes"/>
    
  </xsl:template>
  
  <xsl:template match="EMP_NOMBRE">
    <a>
     <xsl:attribute name="href">EMPManten.xsql?LANG=<xsl:value-of select="$lang"/>&amp;ID=<xsl:value-of select="../EMP_ID"/>
     </xsl:attribute>
     <xsl:value-of select="."/>
    </a>
  </xsl:template>

  <xsl:template match="EMP_POBLACION">
        <xsl:value-of select="."/>
  </xsl:template>

  <xsl:template match="TE_DESCRIPCION">
        <xsl:value-of select="."/>
  </xsl:template>

</xsl:stylesheet>
