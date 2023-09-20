<?xml version="1.0" encoding="iso-8859-1" ?>
<!--
 |
 |
 +-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href = "http://www.newco.dev.br/General/General.xsl" />
  <xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
  <xsl:param name="lang" select="@lang"/>
  <xsl:template match="/">  
    <xsl:choose>
    <xsl:when test="//xsql-error">
        <xsl:apply-templates select="//xsql-error"/>
    </xsl:when>
    <xsl:otherwise>
    <html>
      <head>
	<xsl:text disable-output-escaping="yes"><![CDATA[
	<link rel="stylesheet" href="http://www.newco.dev.br/General/Estilos.css" type="text/css">	
        <script type="text/javascript" src="http://www.newco.dev.br/General/general.js">
        </script>
        ]]></xsl:text>        
      </head>

      <body bgcolor="#EEFFFF">
        <p align="center" class="tituloPag">     
	  <br/> 	        	           
	  <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='CYP-0000' and @lang=$lang]" disable-output-escaping="yes"/>	        
	  <br/>
	</p>	                     
        <xsl:apply-templates select="BusquedaEmpresas/BuscForm"/> 	 
      </body>
    </html>
    </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

<!--
 |  Templates
 +-->

<xsl:template match="BuscForm">
  <form method="post">
    <xsl:attribute name="name">
      <xsl:value-of select="@name"/>
    </xsl:attribute>

  <table width="100%" border="0" cellspacing="0" cellpadding="0" >	
    <tr bgcolor="#A0D8D7"> 
      <td colspan="4"><p class="tituloForm">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='CYP-0210' and @lang=$lang]" disable-output-escaping="yes"/>:
        </p></td>
    </tr>	
    <tr> 
      <td width="20%"><p class="tituloCamp">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='CYP-0240' and @lang=$lang]" disable-output-escaping="yes"/>:
        </p></td>
      <td colspan="3">  
	<input type="text" size="67" name="EMP_NOMBRE"/>
      </td>
    </tr>		    		          	          	    
    <tr> 
      <td width="20%"><p class="tituloCamp">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='CYP-0280' and @lang=$lang]" disable-output-escaping="yes"/>:
        </p></td>
      <td width="30%"><p class="tituloCamp"> 
          <!-- Indico el valor del identificador de la empresa actual -->
          <xsl:variable name="IDAct"><xsl:value-of select="TE_ID"/></xsl:variable>
          <xsl:apply-templates select="field"/></p>
      </td>
      <td width="15%"><p class="tituloCamp">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='CYP-0230' and @lang=$lang]" disable-output-escaping="yes"/>:
        </p></td>
      <td width="35%">  
	<input type="text" size="10" name="EMP_NIF"/>
      </td>
    </tr>
    <tr> 
      <td><p class="tituloCamp">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='CYP-0220' and @lang=$lang]" disable-output-escaping="yes"/>:
        </p></td>
      <td colspan="3">  
	<input type="text" size="51" name="EMP_DIRECCION"/>               
      </td>
    </tr>	
    <tr> 
      <td><p class="tituloCamp">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='CYP-0260' and @lang=$lang]" disable-output-escaping="yes"/>:
        </p></td>
      <td> 
	<input type="text" size="5" name="EMP_CPOSTAL"/>
        </td>
      <td><p class="tituloCamp">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='CYP-0270' and @lang=$lang]" disable-output-escaping="yes"/>:
        </p></td> 
      <td>
	<input type="text" size="28" name="EMP_POBLACION"/> 	     
        </td>
    </tr>	
    <tr> 
      <td><p class="tituloCamp">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='CYP-0250' and @lang=$lang]" disable-output-escaping="yes"/>:
        </p></td>
      <td> 
	<input type="text" size="23" name="EMP_PROVINCIA"/>
      </td>
      <td>&nbsp;
      </td> 
      <td>&nbsp;
      </td>
    </tr>
    <tr> 
      <td><p class="tituloCamp">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='CYP-0290' and @lang=$lang]" disable-output-escaping="yes"/>:
        </p></td>
      <td>  
	<input type="text" size="9" name="EMP_TELEFONO"/> 	     
        </td>
      <td><p class="tituloCamp">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='CYP-0300' and @lang=$lang]" disable-output-escaping="yes"/>:
        </p></td>
      <td>  
	<input type="text" size="9" name="EMP_FAX"/>
        </td>
    </tr>
    <!--
    <tr valign="top"> 
      <td><p class="tituloCamp">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='CYP-0310' and @lang=$lang]" disable-output-escaping="yes"/>:
        </p></td>
      <td colspan="3"> 
	<textarea name="EMP_REFERENCIAS" cols="51" rows="5"/>               
        </td>
    </tr>
    +-->
    <tr bgcolor="#EEFFFF"><td colspan="4">&nbsp;</td></tr>
    <tr bgcolor="#A0D8D7"> 
      <td colspan="4"><p class="tituloCamp">
        Consultas predefinidas
        </p></td>
    </tr>
    <tr valign="top"> 
      <td>
        Consultas Predefinidas:
      </td>
      <td colspan="3"> 
        <select name="CONSULTAPREDEFINIDA">
          <option value="-1">[Consultas Predefinidas]</option>
          <option value="CLI_NO">Clientes NO visibles</option>
          <option value="CLI_SI">Clientes visibles</option>
          <option value="PRV_NO">Proveedores NO visibles</option>
          <option value="PRV_SI">Proveedores visibles</option>
          <option value="PRV_HAB">Proveedores habituales</option>
        </select>
       </td>
    </tr>
    <tr bgcolor="#EEFFFF"><td colspan="4">&nbsp;</td></tr>
    <tr valign="top" align="center" bgcolor="#EEFFFF">               
      <td colspan="2">
        <xsl:apply-templates select="../jumpTo"/>
      </td>
     <xsl:for-each select="button">
      <td colspan="2">   
        <xsl:apply-templates select="."/>
      </td>
     </xsl:for-each>      	     
    </tr>    	            	
  </table>    	  

  </form>
</xsl:template>

</xsl:stylesheet>