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
        <title><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='EMP-0010' and @lang=$lang]" disable-output-escaping="yes"/></title>
	<xsl:text disable-output-escaping="yes"><![CDATA[
	<link rel="stylesheet" href="http://www.newco.dev.br/General/Estilos.css" type="text/css">
	<script type="text/javascript" src="http://www.newco.dev.br/General/general.js"></script>
        ]]></xsl:text>
      </head>
      <body bgcolor="#EEFFFF">      
        <xsl:choose>
          <xsl:when test="Lista/form/xsql-error"> 
          <p class="tituloForm">     
            <xsl:apply-templates select="Lista/form/xsql-error"/>
          </p>
          </xsl:when>
          <xsl:when test="Lista/form/ROWSET/ROW/TooManyRows">       
            <p class="tituloPag">
              <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='PRO-0220' and @lang=$lang]" disable-output-escaping="yes"/>
              <hr/>
            </p>
            <p class="tituloForm">            
              <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='PRO-0230' and @lang=$lang]" disable-output-escaping="yes"/>
            </p>
            <div align="center">
              <br/><xsl:apply-templates select="Lista/jumpTo"/>
            </div>
          </xsl:when>
          
          <xsl:when test="Lista/form/ROWSET/ROW/NoDataFound">       
            <div align="center">
            <p class="tituloPag">
              <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='PRO-0220' and @lang=$lang]" disable-output-escaping="yes"/>
              <hr/></p>
            <p class="tituloForm">            
               <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='PRO-0240' and @lang=$lang]" disable-output-escaping="yes"/>
            </p>
              <br/><xsl:apply-templates select="Lista/jumpTo"/>
            </div>
          </xsl:when>
          
          <xsl:otherwise>
            <xsl:apply-templates select="Lista/form"/>
          </xsl:otherwise>
        </xsl:choose>
      </body>
    </html>
  </xsl:template>  


<!-- TEMPLATES --> <!-- TEMPLATES --> <!-- TEMPLATES --> <!-- TEMPLATES --> <!-- TEMPLATES -->      

<xsl:template match="form">
  <table width="90%" align="center" border="0" cellspacing="0" cellpadding="5">
    <!-- Formulario de datos -->
    <form>
      <xsl:attribute name="name">
	<xsl:value-of select="@name"/>
      </xsl:attribute>
	
      <xsl:attribute name="method">
	<xsl:value-of select="@method"/>
      </xsl:attribute>
	   
      <xsl:attribute name="action">
	mailto:comercial@medicalvm.com
      </xsl:attribute>      

      <tr> 
        <td align="center" colspan="3"><p class="tituloPag">      
            <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='PRO-0310' and @lang=$lang]" disable-output-escaping="yes"/>
            <br/><br/></p></td>
      </tr>  	                     
      <xsl:for-each select="ROWSET/ROW">
        <tr>
          <td>                
            <xsl:apply-templates select="."/>
	  </td>
	  <td>	  
	    <input type="text" size="8" maxlength="8"><xsl:attribute name="name">CANTIDAD<xsl:value-of select="PRO_ID"/></xsl:attribute></input><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='PRO-0330' and @lang=$lang]" disable-output-escaping="yes"/>
	  </td>	  
	  <td>
	    <input type="checkbox" name="SELECCIONAR">
	      <xsl:attribute name="value"><xsl:value-of select="PRO_ID"/></xsl:attribute>
	    </input>
	    <!--<xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='PRO-0320' and @lang=$lang]" disable-output-escaping="yes"/>-->
	  </td>
        </tr>
      </xsl:for-each>
      
      <tr valign="top" align="center" bgcolor="#EEFFFF">       
        <td colspan="2"><br/>	            
	  <xsl:apply-templates select="sendRequest"/>
        </td>
        <td><br/>
          <xsl:apply-templates select="../jumpTo"/>
        </td>	     
      </tr>
    </form> 
  </table>
</xsl:template>

<xsl:template match="ROW">
  <table align="center" border="0" cellspacing="0" cellpadding="5" bgcolor="#cee9fb">		
    <tr> 
      <td><p class="tituloCamp">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='PRO-0150' and @lang=$lang]" disable-output-escaping="yes"/>:
        </p></td>
      <td colspan="3">  
        <xsl:apply-templates select="PRO_NOMBRE"/>  
        <xsl:apply-templates select="PRO_REFERENCIA"/>
      </td>      
    </tr>	
    <tr> 
      <td><p class="tituloCamp">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='PRO-0260' and @lang=$lang]" disable-output-escaping="yes"/>:
        </p></td>
      <td colspan="3">  
        <xsl:apply-templates select="PROVEEDOR"/>
      </td>      
    </tr>
    <tr> 
      <td><p class="tituloCamp">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='PRO-0170' and @lang=$lang]" disable-output-escaping="yes"/>:
        </p></td>
      <td>  
        <xsl:apply-templates select="PRO_FABRICANTE"/>
      </td>      
      <td><p class="tituloCamp">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='PRO-0180' and @lang=$lang]" disable-output-escaping="yes"/>:
        </p></td>
      <td>  
        <xsl:apply-templates select="PRO_MARCA"/>
      </td>      
    </tr>    	
    <tr> 
      <td><p class="tituloCamp">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='PRO-0160' and @lang=$lang]" disable-output-escaping="yes"/>:
        </p></td>
      <td colspan="3">  
        <xsl:apply-templates select="PRO_DESCRIPCION"/>
      </td>
    </tr>	
    <tr> 
      <td><p class="tituloCamp">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='PRO-0270' and @lang=$lang]" disable-output-escaping="yes"/>:
        </p></td>
      <td>  
        <xsl:apply-templates select="PRO_HOMOLOGADO"/>
      </td>
      <td><p class="tituloCamp">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='PRO-0280' and @lang=$lang]" disable-output-escaping="yes"/>:
        </p></td>
      <td>  
        <xsl:apply-templates select="PRO_CERTIFICADOS"/>
      </td>      
    </tr>	
    <tr> 
      <td><p class="tituloCamp">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='PRO-0290' and @lang=$lang]" disable-output-escaping="yes"/>:
        </p></td>
      <td>  
        <xsl:apply-templates select="PRO_UNIDADBASICA"/>
      </td>
      <td><p class="tituloCamp">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='PRO-0300' and @lang=$lang]" disable-output-escaping="yes"/>:
        </p></td>
      <td>  
        <xsl:apply-templates select="PRO_UNIDADESPORLOTE"/>
      </td> 
    </tr>
  </table>
</xsl:template>   	 
  
<xsl:template match="PRO_NOMBRE">
  <xsl:value-of select="."/>&nbsp;
</xsl:template>

<xsl:template match="PRO_REFERENCIA">
  <xsl:value-of select="."/>&nbsp;
</xsl:template>

<xsl:template match="PROVEEDOR">
  <a>
    <xsl:attribute name="href">TRFBuscaProveedor.xsql?LANG=<xsl:value-of select="$lang"/>&amp;PRO_ID=<xsl:value-of select="../PRO_ID"/>
    </xsl:attribute>
    <xsl:value-of select="."/>&nbsp;
  </a>
</xsl:template>

<xsl:template match="PRO_FABRICANTE">
  <xsl:value-of select="."/>&nbsp;
</xsl:template>

<xsl:template match="PRO_MARCA">
  <xsl:value-of select="."/>&nbsp;
</xsl:template>

<xsl:template match="PRO_DESCRIPCION">
  <xsl:value-of select="."/>&nbsp;
</xsl:template>

<xsl:template match="PRO_HOMOLOGADO">
  <input type="checkbox" name="HOMOLOGADO" disabled="disabled">
  <xsl:choose>
    <xsl:when test=".=1">
      <xsl:attribute name="checked">
      checked
      </xsl:attribute>
    </xsl:when>    
  </xsl:choose>      
  </input>
</xsl:template>

<xsl:template match="PRO_CERTIFICADOS">
  <xsl:value-of select="."/>&nbsp;
</xsl:template>

<xsl:template match="PRO_UNIDADBASICA">
  <xsl:value-of select="."/>&nbsp;
</xsl:template>

<xsl:template match="PRO_UNIDADESPORLOTE">
  <xsl:value-of select="."/>&nbsp;
</xsl:template>

<xsl:template match="sendRequest">
  <xsl:variable name="PonCheckyText">
    <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='PRO-0340' and @lang=$lang]" disable-output-escaping="yes"/>
  </xsl:variable>
  <xsl:variable name="TextIsNan">
    <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='PRO-0350' and @lang=$lang]" disable-output-escaping="yes"/>
  </xsl:variable> 
  <input type="button" name="sendRequest">
    <xsl:attribute name="value">
      <xsl:value-of select="@label"/>
    </xsl:attribute>    
    <xsl:attribute name="onClick">
      productosSeleccionados(this.form,'SELECCIONAR','CANTIDAD','<xsl:value-of select="$PonCheckyText"/>','<xsl:value-of select="$TextIsNan"/>')
    </xsl:attribute>

  </input>
</xsl:template>

</xsl:stylesheet>
