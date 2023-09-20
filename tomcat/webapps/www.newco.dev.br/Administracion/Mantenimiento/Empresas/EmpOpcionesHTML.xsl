<?xml version="1.0" encoding="iso-8859-1" ?>
<!--
 |  This stylesheet implements multi-language at the UI level
 |  It is based on the parameter 'lang' that is 'english' by default.
 |  It can be also 'french' or 'spanish' or 'german'.
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
      <body bgcolor="#EEFFFF">
        <br/><br/><br/><br/><br/><br/><br/><br/>
        <table width="50%" border="0" align="center" cellspacing="0" cellpadding="0">	    
	  <tr> 
            <xsl:for-each select="OpcionesEmpresa/Opcion">
              <td>
        	<form method="POST">
          	  <xsl:attribute name="action">
            	    <xsl:value-of select="@action"/>
          	  </xsl:attribute>
  
                  <input type="hidden">
                    <xsl:attribute name="name">EMP_ID</xsl:attribute>
                    <xsl:attribute name="value"><xsl:value-of select="../Parametros/EMP_ID"/></xsl:attribute>
                  </input>  
              
                  <input type="submit">
                    <xsl:attribute name="name">
                      <xsl:value-of select="@name"/>
                    </xsl:attribute>
                    <xsl:attribute name="value">
                      <xsl:value-of select="@label"/>
                    </xsl:attribute>
                  </input>
                </form>
              </td>
            </xsl:for-each> 
	  </tr>
          <tr>                  
            <td colspan="3" align="center" valign="top">
              <xsl:apply-templates select="OpcionesEmpresa/jumpTo"/>
            </td>                       
          </tr>
        </table>
      </body>
    </html>
  </xsl:template>  
  
  <xsl:template match="EMP_ID">
        <xsl:value-of select="."/> 
   </xsl:template> 
   
  <xsl:template match="Sorry">
    <h1><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='EMP-0200' and @lang=$lang]"/></h1>    
    <h2><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='EMP-0210' and @lang=$lang]"/></h2>        
  </xsl:template>
  
  <!-- ** ** ** Empiezan las definiciones ** ** ** ** -->
  <xsl:template match="xsql-error">
    <h1><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='G-1000' and @lang=$lang]"/></h1>
    <h3>On action: <xsl:value-of select="@action"/></h3>
    <h3>Message: <xsl:value-of select="./message"/></h3>
    <h3>Statement:</h3>
    <xsl:value-of select="./statement"/>
    <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='G-1001' and @lang=$lang]"/>
    
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

  <!-- Inicio Formulario -->

  <xsl:template match="form">
    <form>
      <xsl:attribute name="action">
        <xsl:value-of select="@action"/>
      </xsl:attribute>
      <xsl:attribute name="method">
        <xsl:value-of select="@method"/>
      </xsl:attribute>

      <!-- Campo EMP_ID Nulo -->
      <xsl:apply-templates select="./field"/>
     
      <p>
        <xsl:apply-templates select="./sendRequest"/>
      </p>
    </form>
  </xsl:template>

  <xsl:template match="sendRequest">
    <input type="submit">
      <xsl:attribute name="value">
        <xsl:value-of select="@label"/>
      </xsl:attribute>
    </input>
  </xsl:template>

 <!-- Final Formulario -->

  <xsl:template match="returnHome">
    <a>
      <xsl:attribute name="href">javascript:history.go(-1);</xsl:attribute>
      <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='G-0001' and @lang=$lang]"/>            
    </a>
  </xsl:template>

</xsl:stylesheet>
