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
        <title><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='PRO-0100' and @lang=$lang]"  disable-output-escaping="yes"/></title>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1"/>
	<meta name="description" content="insert brief description here"/> 
	<meta name="keywords" content="insert, keywords, here"/>
	<xsl:text disable-output-escaping="yes"><![CDATA[
	<link rel="stylesheet" href="http://www.newco.dev.br/General/Estilos.css" type="text/css">
	<script type="text/javascript" src="http://www.newco.dev.br/General/general.js"></script>
        ]]></xsl:text>
      </head>

      <body bgcolor="#EEFFFF">      
          <table width="90%" border="0" align="center" cellspacing="0" cellpadding="0">
	    <!-- Formulario de datos -->
	    <tr align="center"> 
	      <td valign="top" colspan="5"><p class="tituloPag">
	        <br/> 	        	           
	          <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='PRO-0110' and @lang=$lang]" disable-output-escaping="yes"/>	        
	        <br/></p>	                     
                <xsl:apply-templates select="BusquedaProductos/BuscForm"/> 
	      </td>
	    </tr>
          </table>	 
      </body>
    </html>
  </xsl:template>

<!--
 |  Templates
 +-->



<xsl:template match="BuscForm">
  <form>
    <xsl:attribute name="name">
      <xsl:value-of select="@name"/>
    </xsl:attribute>

    <xsl:attribute name="method">
      <xsl:value-of select="@method"/>
    </xsl:attribute>
    
    <xsl:attribute name="action">
      <xsl:value-of select="@action"/>
    </xsl:attribute>

  <table width="80%" border="0" cellspacing="0" cellpadding="5" bgcolor="#A0D8D7">	
    <tr bgcolor="#DD000"> 
      <td colspan="4"><p class="tituloForm">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='PRO-0111' and @lang=$lang]" disable-output-escaping="yes"/>:
        </p></td>
    </tr>	
    <tr> 
      <td><p class="tituloCamp">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='PRO-0120' and @lang=$lang]" disable-output-escaping="yes"/>:
        </p></td>
      <td colspan="3">  
	<input type="text" size="51" name="CATEGORIA"/>
      </td>
    </tr>	
    <tr> 
      <td><p class="tituloCamp">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='PRO-0130' and @lang=$lang]" disable-output-escaping="yes"/>:
        </p></td>
      <td colspan="3">  
	<input type="text" size="51" name="FAMILIA"/>
      </td>
    </tr>	
    <tr> 
      <td><p class="tituloCamp">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='PRO-0140' and @lang=$lang]" disable-output-escaping="yes"/>:
        </p></td>
      <td colspan="3">  
	<input type="text" size="51" name="SUBFAMILIA"/>
      </td>
    </tr>	
    <tr> 
      <td><p class="tituloCamp">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='PRO-0150' and @lang=$lang]" disable-output-escaping="yes"/>:
        </p></td>
      <td colspan="3">  
	<input type="text" size="51" name="NOMBRE"/>
      </td>
    </tr>	
    <tr> 
      <td><p class="tituloCamp">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='PRO-0160' and @lang=$lang]" disable-output-escaping="yes"/>:
        </p></td>
      <td colspan="3">  
	<input type="text" size="51" name="DESCRIPCION"/>
      </td>
    </tr>	
    <tr> 
      <td><p class="tituloCamp">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='PRO-0170' and @lang=$lang]" disable-output-escaping="yes"/>:
        </p></td>
      <td colspan="3">  
	<input type="text" size="51" name="FABRICANTE"/>
      </td>
    </tr>	
    <tr> 
      <td><p class="tituloCamp">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='PRO-0180' and @lang=$lang]" disable-output-escaping="yes"/>:
        </p></td>
      <td colspan="3">  
	<input type="text" size="51" name="MARCA"/>
      </td>
    </tr>	
    <tr> 
      <td><p class="tituloCamp">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='PRO-0190' and @lang=$lang]" disable-output-escaping="yes"/>:
        </p></td>
      <td colspan="3">  
	<input type="text" size="51" name="PROVEEDOR"/>
      </td>
    </tr>	
    <tr valign="top" bgcolor="#EEFFFF">       
      <td>   
	<input type="submit">
	  <xsl:attribute name="name">
	    <xsl:value-of select="sendRequest/@name"/>
	  </xsl:attribute>	  
	  <xsl:attribute name="value">
	    <xsl:value-of select="sendRequest/@label"/>
	  </xsl:attribute>	  
	</input>   
      </td>
      <td colspan="3" align="right">
        <xsl:apply-templates select="../jumpTo"/>
      </td>	     
    </tr>    	            	
  </table>    	  

  </form>
</xsl:template>


<xsl:template match="CATEGORIA">
 <input type="text" name="CATEGORIA">
 <xsl:attribute name="value">
  <xsl:value-of select="."/>
 </xsl:attribute>
 </input>
</xsl:template>

<xsl:template match="FAMILIA">
 <input type="text" name="FAMILIA">
 <xsl:attribute name="value">
  <xsl:value-of select="."/>
 </xsl:attribute>
 </input>
</xsl:template>

<xsl:template match="SUBFAMILIA">
 <input type="text" name="SUBFAMILIA">
 <xsl:attribute name="value">
  <xsl:value-of select="."/>
 </xsl:attribute>
 </input>
</xsl:template>

</xsl:stylesheet>