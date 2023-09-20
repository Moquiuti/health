<!-- No estan actualizados los botones ni el path de los mensajes -->
<!-- No estan actualizados los botones ni el path de los mensajes -->
<!-- No estan actualizados los botones ni el path de los mensajes -->
<!-- No estan actualizados los botones ni el path de los mensajes -->
<!-- No estan actualizados los botones ni el path de los mensajes -->
<!-- No estan actualizados los botones ni el path de los mensajes -->




<?xml version="1.0" encoding="iso-8859-1" ?>
<!--
 |  This stylesheet implements multi-language at the UI level
 |  It is based on the parameter 'lang' that is 'english' by default.
 |  It can be also 'french' or 'spanish' or 'german'.
 +-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
  <xsl:param name="lang" select="@lang"/>  
  <xsl:template match="/">
    <html>
      <head>
        <title><xsl:value-of select="document('messages.xml')/messages/msg[@id='USD-1010' and @lang=$lang]" disable-output-escaping="yes"/></title>
      </head>
      <body bgcolor="#EEFFFF" text="#000000" link="#333366" vlink="#333366" alink="#3399ff">      
        <xsl:choose>
          <xsl:when test="ListaDerechosUsuarios/xsql-error">
            <!-- Mostrar los errores -->
            <xsl:apply-templates select="ListaDerechosUsuarios/xsql-error"/>          
          </xsl:when>
        <xsl:when test="ListaDerechosUsuarios/ROWSET/ROW/Sorry">
          <xsl:apply-templates select="ListaDerechosUsuarios/ROWSET/ROW/Sorry"/> 
        </xsl:when>
        <xsl:otherwise>
          <table width="80%" border="0" align="center" cellspacing="0" cellpadding="5" >
	    <!-- Formulario de datos -->
	    <tr align="center" bgcolor="#CCCCCC"> 
	      <td valign="top" colspan="3">  
	          <font size="2" face="Verdana, Arial, Helvetica, sans-serif"><b>          
	            <xsl:value-of select="document('messages.xml')/messages/msg[@id='USD-1010' and @lang=$lang]" disable-output-escaping="yes"/>
	          </b></font>	         
	      </td>
	    </tr>  	                     
            <tr bgcolor="#CCCCCC">
                    
               <!-- Nombre Usuario -->
                    
               <td valign="top" colspan="3"><b><xsl:value-of select="ListaDerechosUsuarios/ROWSET/ROW/NOMBREUSUARIO[1]"/></b></td>
            </tr>
            <tr bgcolor="#CCCCCC">
              <td>
                <!-- Tipo Menu -->
                <xsl:value-of select="document('messages.xml')/messages/msg[@id='USD-1100' and @lang=$lang]" disable-output-escaping="yes"/>
              </td>
              <td>
                <!-- Menu -->
                <xsl:value-of select="document('messages.xml')/messages/msg[@id='USD-1120' and @lang=$lang]" disable-output-escaping="yes"/>
              </td>
              <td>
                <!-- Autorizado -->
                <xsl:value-of select="document('messages.xml')/messages/msg[@id='USD-1140' and @lang=$lang]" disable-output-escaping="yes"/>
              </td>
            </tr>
            <xsl:for-each select="ListaDerechosUsuarios/ROWSET/ROW">
              <tr >
                <td width="35%"><b><xsl:value-of select="TIPOMENU"/></b></td>
                <td width="50%"><b><xsl:value-of select="NOMBREMENU"/></b></td>
                <td width="15%"><b><xsl:apply-templates select="AUTORIZADO"/></b></td>
              </tr>
            </xsl:for-each>
          </table> 
          <br/><br/>
	  <div align="center">
            <xsl:apply-templates select="ListaDerechosUsuarios/jumpTo"/>
        </div>
        </xsl:otherwise>
        </xsl:choose>
      </body>
    </html>
  </xsl:template>  


<!-- TEMPLATES --> <!-- TEMPLATES --> <!-- TEMPLATES --> <!-- TEMPLATES --> <!-- TEMPLATES -->
  
  <xsl:template match="ID">
        <xsl:value-of select="."/> 
   </xsl:template> 
   
  <xsl:template match="Sorry">
    <h1><xsl:value-of select="document('messages.xml')/messages/msg[@id='EMP-0320' and @lang=$lang]" disable-output-escaping="yes"/></h1>    
    <h2><xsl:value-of select="document('messages.xml')/messages/msg[@id='EMP-0330' and @lang=$lang]" disable-output-escaping="yes"/></h2>        
  </xsl:template>





                
  <!-- ** ** ** Empiezan las definiciones ** ** ** ** -->
  <xsl:template match="xsql-error">
    <h1><xsl:value-of select="document('messages.xml')/messages/msg[@id='G-1000' and @lang=$lang]" disable-output-escaping="yes"/></h1>
    <h3>On action: <xsl:value-of select="@action"/></h3>
    <h3>Message: <xsl:value-of select="./message"/></h3>
    <h3>Statement:</h3>
    <font size="-1">
    <pre>
    <xsl:value-of select="./statement"/>
    </pre>
    </font>
    <xsl:value-of select="document('messages.xml')/messages/msg[@id='G-1001' and @lang=$lang]" disable-output-escaping="yes"/>
    
  </xsl:template>
  
  <xsl:template match="AUTORIZADO">
    <a>
     <xsl:attribute name="href">USDERManten.xsql?LANG=<xsl:value-of select="$lang"/>&amp;US_ID=<xsl:value-of select="../IDUSUARIO"/>&amp;IDMENU=<xsl:value-of select="../IDMENU"/>
     </xsl:attribute>
     <xsl:value-of select="."/>
    </a>
  </xsl:template>

</xsl:stylesheet>
