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
        <title>Detalle del Centro</title>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1"/>
	<meta name="description" content="insert brief description here"/> 
	<meta name="keywords" content="insert, keywords, here"/>
	<xsl:text disable-output-escaping="yes"><![CDATA[
	<link rel="stylesheet" href="http://www.newco.dev.br/General/Estilos.css" type="text/css">
        <script type="text/javascript" src="http://www.newco.dev.br/General/general.js"></script>
        <script type="text/javascript">
        <!--
        
        //-->
        </script>
        ]]></xsl:text>
      </head>

      <body bgcolor="#FFFFFF">
        <xsl:choose> 
        <xsl:when test="//SESION_CADUCADA">
          <xsl:apply-templates select="//SESION_CADUCADA"/>
        </xsl:when>
        <xsl:when test="//xsql-error">
          <xsl:apply-templates select="//xsql-error"/>
        </xsl:when>
        <xsl:otherwise>
                  <p class="tituloPag" align="center">	
                     Datos de Contacto  	           
		  </p>	        
	        <br/>
        	<xsl:choose> 
				<xsl:when test="Contacto/CONTACTO/CENTRO">
                	<xsl:apply-templates select="Contacto/CONTACTO/CENTRO"/>
				</xsl:when>
       			 <xsl:otherwise>
                	<xsl:apply-templates select="Contacto/CONTACTO/NOAFILIADO"/>
        		</xsl:otherwise>
        	</xsl:choose>      
				 
        </xsl:otherwise>
        </xsl:choose>      
      </body>
    </html>
  </xsl:template>

<xsl:template match="CENTRO">
  <xsl:apply-templates select="CEN_ID"/>
  <xsl:apply-templates select="EMP_ID"/>   
  <table width="100%" border="0" cellspacing="1" cellpadding="3" class="muyoscuro">	
    <tr class="oscuro"> 
      <td colspan="4">
        Usuario afiliado a MedicalVM     
      </td>
    </tr>
    <tr class="blanco"><td colspan="4">&nbsp;</td></tr>    	
    <tr class="blanco"> 
      <td width="100px" class="claro" align="right">
	  	Usuario:
     </td>
      <td colspan="3">
          <xsl:value-of select="USUARIO"/>
        </td>
    </tr>	
    <tr class="blanco"> 
      <td width="100px" class="claro" align="right">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='CEN-0210' and @lang=$lang]" disable-output-escaping="yes"/>:
     </td>
      <td colspan="3">
        <xsl:value-of select="EMP_NOMBRE"/>   
      </td>
    </tr>	
    <tr class="blanco"> 
      <td class="claro" align="right">
        Centro:
      </td>
      <td>
        <xsl:apply-templates select="CEN_NOMBRE"/>
      </td>
      <td width="100px" class="claro" align="right">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='CEN-0215' and @lang=$lang]" disable-output-escaping="yes"/>:
      </td> 
      <td>
        <xsl:apply-templates select="CEN_NIF"/> 
        <br/>	     
      </td>
    </tr>		    		          	          	    
    <tr class="blanco"> 
      <td class="claro" align="right">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='CEN-0150' and @lang=$lang]" disable-output-escaping="yes"/>:
      </td>
      <td colspan="3">
        <xsl:apply-templates select="CEN_DIRECCION"/>                
      </td>
    </tr>	
    <tr class="blanco"> 
      <td class="claro" align="right">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='CEN-0170' and @lang=$lang]" disable-output-escaping="yes"/>:
     </td>
      <td colspan="3">
        <xsl:apply-templates select="CEN_POBLACION"/> 
      </td>
    </tr>
    <tr class="blanco"> 
      <td class="claro" align="right">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='CEN-0160' and @lang=$lang]" disable-output-escaping="yes"/>:
      </td>
      <td> 
          <xsl:value-of select="CEN_PROVINCIA"/>
    	  <xsl:for-each select="//field[@name='CEN_PROVINCIA']">
    	    <xsl:value-of select="dropdownList/listElem/ID"/>
    	    <xsl:value-of select="dropdownList/listElem/listItem"/>
    	  </xsl:for-each>
      </td>
      <td width="100px" class="claro" align="right">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='CEN-0180' and @lang=$lang]" disable-output-escaping="yes"/>:
      </td> 
      <td>
        <xsl:apply-templates select="CEN_CPOSTAL"/> 	     
      </td>
    </tr>
    <tr class="blanco"> 
      <td class="claro" align="right">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='CEN-0190' and @lang=$lang]" disable-output-escaping="yes"/>:
      </td>
      <td>
        <xsl:apply-templates select="CEN_TELEFONO"/> 	     
        </td>
      <td class="claro" align="right">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='CEN-0200' and @lang=$lang]" disable-output-escaping="yes"/>:
      </td>
      <td>
        <xsl:apply-templates select="CEN_FAX"/>
      </td>
    </tr> 
    <tr class="blanco" height="25px" valign="bottom">
      <td colspan="4">
        <table width="100%" border="0">
        <tr align="center" valign="bottom" height="30px">       
          <td align="center"> 
            <xsl:call-template name="boton">
              <xsl:with-param name="path" select="//botones_nuevo/button[@label='Cerrar']"/>
            </xsl:call-template>
          </td>       
          </tr>
        </table>
      </td>
    </tr>
  </table>
</xsl:template> 

<!--	Presentacion de los datos de contacto de usuarios no afiliados		-->
<xsl:template match="NOAFILIADO">
  <table width="100%" border="0" cellspacing="1" cellpadding="3" class="muyoscuro">	
    <tr class="oscuro"> 
      <td colspan="2">
        Usuario no afiliado a MedicalVM     
      </td>
    </tr>
    <tr class="blanco"><td colspan="2">&nbsp;</td></tr>
	<tr>
      <td width="25%" class="claro" align="right">
	  	Nombre:
     </td>
      <td class="blanco">
          <xsl:value-of select="USUARIO"/>
        </td>
    </tr>	
	<tr>
      <td class="claro" align="right">
	  	Empresa:
     </td>
      <td class="blanco">
          <xsl:value-of select="EMPRESA"/>
        </td>
    </tr>	
	<tr>
      <td class="claro" align="right">
	  	Provincia:
     </td>
      <td class="blanco">
          <xsl:value-of select="PROVINCIA"/>
        </td>
    </tr>	
	<tr>
      <td class="claro" align="right">
	  	Otros datos de Contacto:
     </td>
      <td class="blanco">
          <xsl:copy-of select="CONTACTO"/>
        </td>
    </tr>	
    <tr class="blanco" height="25px" valign="bottom">
      <td colspan="2">
        <table width="100%" border="0">
        <tr align="center" valign="bottom" height="30px">       
          <td align="center"> 
            <xsl:call-template name="boton">
              <xsl:with-param name="path" select="//botones_nuevo/button[@label='Cerrar']"/>
            </xsl:call-template>
          </td>       
          </tr>
        </table>
      </td>
    </tr>
	</table>	
</xsl:template> 


<xsl:template match="Sorry">
  <xsl:value-of select="."/>
</xsl:template>


  
<xsl:template match="CEN_ID">
  <input type="hidden" name="CEN_ID" size="59" maxlength="70">
    <xsl:attribute name="value">
      <xsl:value-of select="."/> 
    </xsl:attribute>      
  </input>
</xsl:template>  

<xsl:template match="EMP_ID">
  <input type="hidden" name="EMP_ID" maxlength="70">
    <xsl:attribute name="value">
      <xsl:value-of select="."/> 
    </xsl:attribute>      
  </input>
</xsl:template>  

<xsl:template match="CEN_NOMBRE">
      <xsl:value-of select="."/>      
</xsl:template>

<xsl:template match="CEN_DIRECCION">
      <xsl:value-of select="."/>      
</xsl:template>

<xsl:template match="CEN_CPOSTAL">
      <xsl:value-of select="."/> 
</xsl:template>

<xsl:template match="CEN_NIF">
      <xsl:value-of select="."/> 
</xsl:template>
  
<xsl:template match="CEN_POBLACION">
      <xsl:value-of select="."/> 
</xsl:template>

<xsl:template match="CEN_PROVINCIA">
      <xsl:value-of select="."/> 
</xsl:template>
    
<xsl:template match="CEN_TELEFONO">
      <xsl:value-of select="."/> 
</xsl:template>
  
<xsl:template match="CEN_FAX">
      <xsl:value-of select="."/> 
</xsl:template>

</xsl:stylesheet>