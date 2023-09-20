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
        <title><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='DP-0010' and @lang=$lang]" disable-output-escaping = "yes"/></title>
	<xsl:text disable-output-escaping="yes"><![CDATA[
	<link rel="stylesheet" href="http://www.newco.dev.br/General/Estilos.css" type="text/css">
        <script type="text/javascript" src="http://www.newco.dev.br/General/general.js">
        </script>
        ]]></xsl:text>	
      </head>
      <body bgcolor="#EEFFFF">
          <xsl:choose>
           <xsl:when test="Lista/xsql-error">
             <!-- Mostrar los errores -->	     
             <xsl:apply-templates select="//xsql-error"/>
             <br/><br/>
             <form method="post" name="button"><center><xsl:apply-templates select="//jumpTo"/></center></form>
           </xsl:when>
           <xsl:when test="Lista/ROWSET/ROW/Sorry">
	   <form method="post" name="Sorry">
             <xsl:apply-templates select="//Sorry"/>
             <br/><br/>
             <center><xsl:apply-templates select="//jumpTo"/></center></form>
           </xsl:when>
          <xsl:otherwise>          

            <table align="center" width="100%" border="0" cellspacing="0" cellpadding="0" >

              <p class="tituloPag">
                <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='DP-0020' and @lang=$lang]" disable-output-escaping = "yes" />
              </p>

              <tr bgcolor="#A0D8D7">
                <td><p class="tituloCamp">
                  <!-- Nombre  -->
                  <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='DP-0120' and @lang=$lang]" disable-output-escaping = "yes" />
                </p></td>
                <td><p class="tituloCamp">
                  <!-- Responsable -->
                  <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='DP-0050' and @lang=$lang]" disable-output-escaping = "yes" />
                </p></td>
              </tr>
              <tr><td colspan="2">&nbsp;</td></tr>
              <xsl:for-each select="Lista/ROWSET/ROW">
                <tr>
                  <td width="40%"><xsl:apply-templates select="DP_NOMBRE"/></td>
                  <td><xsl:apply-templates select="NOMBRE"/></td>
                </tr>
              </xsl:for-each>
              <tr bgcolor="#EEFFFF"><td colspan="2"><table width="100%"><tr valign="top" align="center">               
		<td><xsl:apply-templates select="Lista/jumpTo"/>
                </td>
                <td width="60%">&nbsp;</td>
                <xsl:apply-templates select="Lista/ExtraButtons"/>                 
              </tr></table></td></tr>
            </table>
        </xsl:otherwise>
        </xsl:choose>
      </body>
    </html>
  </xsl:template>  
  
<xsl:template match="ExtraButtons">
    <!-- Cada button corresponde a un form con campos ocultos /field y un submit /button -->
    <xsl:for-each select="formu">
    <xsl:choose>
    <xsl:when test="@name='dummy'">
      <!-- Colocamos form chorra porque el javascript tiene problemas con el primer formulario 
           anidado -->
      <form method="post">
        <xsl:attribute name="name">
          <xsl:value-of select="@name"/>
        </xsl:attribute>
        <xsl:attribute name="action">
          <xsl:value-of select="@action"/>
        </xsl:attribute>    
      </form>
    </xsl:when>
    <xsl:otherwise>
    <td>
      <form method="post">    
        <xsl:attribute name="name">
          <xsl:value-of select="@name"/>
        </xsl:attribute>
        <xsl:attribute name="action">
          <xsl:value-of select="@action"/>
        </xsl:attribute>
        <!-- Ponemos los campos input ocultos -->
        <xsl:for-each select="field">
           <input>
           <!-- Anyade las opciones comunes al campo input -->
                <xsl:attribute name="type">
                  <xsl:value-of select="@type"/>
                </xsl:attribute>
                <xsl:attribute name="name">
                  <xsl:value-of select="@name"/>
                </xsl:attribute>
           <!-- Anyadimos los valores, que son diferentes para cada field -->
           <xsl:choose>
            <!-- Campo EMP_ID -->
             <xsl:when test="EMP_ID">
               <xsl:attribute name="value">
               <xsl:value-of select="EMP_ID"/>
               </xsl:attribute>             
             </xsl:when>
             <!-- Campo DP_ID -->
             <xsl:when test="DP_ID">
               <xsl:attribute name="value">
               <xsl:value-of select="DP_ID"/>
               </xsl:attribute>             
             </xsl:when>           
           </xsl:choose>
           </input>
        </xsl:for-each>
        <!-- Anyadimos el boton de submit -->
        <xsl:apply-templates select="button"/>
      </form>
    </td>
    </xsl:otherwise>
    </xsl:choose>
    </xsl:for-each>     
</xsl:template>
 
<xsl:template match="Sorry">
  <h1><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='CEN-0070' and @lang=$lang]" disable-output-escaping = "yes" /></h1>    
  <h2><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='CEN-0080' and @lang=$lang]" disable-output-escaping = "yes" /></h2>        
</xsl:template>
  
  <xsl:template match="DP_NOMBRE">
    <a>
     <xsl:attribute name="href">DPManten.xsql?DP_ID=<xsl:value-of select="../DP_ID"/>&amp;EMP_ID=<xsl:value-of select="../EMP_ID"/>
     </xsl:attribute>
     <xsl:value-of select="."/>
    </a>
  </xsl:template>

  <xsl:template match="NOMBRE">
        <xsl:value-of select="."/>
  </xsl:template>

</xsl:stylesheet>
