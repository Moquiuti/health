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
        <title><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='CEN-0010' and @lang=$lang]" disable-output-escaping = "yes"/></title>

	 <!--style-->
      <xsl:call-template name="estiloIndip"/>
      <!--fin de style-->  	
   	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>
    
      </head>
      <body bgcolor="#FFFFFF">
          <xsl:choose>
           <xsl:when test="Lista/xsql-error">
             <xsl:apply-templates select="//xsql-error"/>         
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
                <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='CEN-0010' and @lang=$lang]" disable-output-escaping = "yes" />
              </p>

              <tr bgcolor="#A0D8D7">
                <td><p class="tituloCamp">
                  <!-- Nombre  -->
                  <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='CEN-0040' and @lang=$lang]" disable-output-escaping = "yes" />
                </p></td>
                <td><p class="tituloCamp">
                  <!-- Direccion -->
                  <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='CEN-0050' and @lang=$lang]" disable-output-escaping = "yes" />
                </p></td>
                <td><p class="tituloCamp">
                  <!-- Poblacion -->
                  <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='CEN-0060' and @lang=$lang]" disable-output-escaping = "yes" />
                </p></td>
              </tr>
              <tr><td colspan="3">&nbsp;</td></tr>
              <xsl:for-each select="Lista/ROWSET/ROW">
                <tr>
                  <td><xsl:apply-templates select="CEN_NOMBRE"/></td>
                  <td><xsl:apply-templates select="CEN_DIRECCION"/></td>
                  <td><xsl:apply-templates select="CEN_POBLACION"/></td>
                </tr>
              </xsl:for-each>
              <tr bgcolor="#FFFFFF"><td colspan="3">&nbsp;</td></tr>              
              <tr bgcolor="#FFFFFF">
                <td colspan="3"><table width="100%"><tr align="center" valign="top">                           
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
             <!-- Campo CEN_ID -->
             <xsl:when test="CEN_ID">
               <xsl:attribute name="value">
               <xsl:value-of select="CEN_ID"/>
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
  
  <!-- ** ** ** Empiezan las definiciones ** ** ** ** -->
  <xsl:template match="xsql-error">
    <h1><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='G-1000' and @lang=$lang]" disable-output-escaping = "yes" /></h1>
    <h3>On action: <xsl:value-of select="@action"/></h3>
    <h3>Message: <xsl:value-of select="./message"/></h3>
    <h3>Statement:</h3>
    <xsl:value-of select="./statement"/>
    <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='G-1001' and @lang=$lang]" disable-output-escaping = "yes" />    
  </xsl:template>
  
  <xsl:template match="CEN_NOMBRE">
    <a>
     <xsl:attribute name="href">CENManten.xsql?LANG=<xsl:value-of select="$lang"/>&amp;ID=<xsl:value-of select="../ID"/>
     </xsl:attribute>
     <xsl:value-of select="."/>
    </a>
  </xsl:template>

  <xsl:template match="CEN_DIRECCION">
        <xsl:value-of select="."/>
  </xsl:template>

  <xsl:template match="CEN_POBLACION">
        <xsl:value-of select="."/>
  </xsl:template>

</xsl:stylesheet>
