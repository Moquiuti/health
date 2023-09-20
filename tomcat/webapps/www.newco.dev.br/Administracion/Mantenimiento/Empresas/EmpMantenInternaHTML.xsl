<?xml version="1.0" encoding="iso-8859-1" ?>
<!--
 |
 +-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href = "http://www.newco.dev.br/General/General.xsl"/> 
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
        <xsl:choose>
           <xsl:when test="Lista/xsql-error">
             <xsl:apply-templates select="//xsql-error"/>         
           </xsl:when>
           <!--
            |
            +-->
          <xsl:when test="MantenimientoEmpresas/form/Status">
             <xsl:apply-templates select="MantenimientoEmpresas/form/Status"/>              
          </xsl:when>
          <xsl:otherwise>
	        <xsl:choose>
	          <xsl:when test="MantenimientoEmpresas/form/EMPRESA/EMP_ID != 0 
	                      and MantenimientoEmpresas/form/EMPRESA/EMP_IDTIPO = 0">
	             <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='EMP-0140' and @lang=$lang]" disable-output-escaping="yes"/>
	             <xsl:value-of select="/MantenimientoEmpresas/form/EMPRESA/EMP_ID" /> 
	          </xsl:when>
	          <xsl:otherwise>
	            <p class="tituloPag">
		      <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='EMP-0060' and @lang=$lang]" disable-output-escaping="yes"/>
	            </p>
	            <xsl:apply-templates select="MantenimientoEmpresas/form"/>          	
	          </xsl:otherwise>
	        </xsl:choose> 
	  </xsl:otherwise>
	</xsl:choose>
      </body>
    </html>
  </xsl:template>

<!--
 |  Templates
 +-->

<xsl:template match="form">
  <form>
    <xsl:attribute name="name"><xsl:value-of select="@name"/></xsl:attribute>
    <xsl:attribute name="action"><xsl:value-of select="@action"/></xsl:attribute>
    <xsl:attribute name="method"><xsl:value-of select="@method"/></xsl:attribute>
    <xsl:apply-templates select="EMPRESA"/>
  </form>
</xsl:template>

<xsl:template match="EMPRESA">
  <xsl:apply-templates select="EMP_ID"/>
  <input type="hidden" name="DESDE" value="{@DESDE}"/>
    
  <table width="100%" border="0" cellspacing="0" cellpadding="0" >	
    <tr bgcolor="#A0D8D7"> 
      <td colspan="4"><p class="tituloForm">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='EMP-0061' and @lang=$lang]" disable-output-escaping="yes"/>
      </p>
      </td>
    </tr>
    <tr><td colspan="4">&nbsp;</td></tr>    	
    <tr> 
      <td><p class="tituloCamp">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='EMP-0067' and @lang=$lang]" disable-output-escaping="yes"/>:
        </p></td>
      <td colspan="3">
        <xsl:apply-templates select="EMP_NOMBRE"/>
      </td>
    </tr>		    		          	          	    
    <tr> 
      <td width="15%"><p class="tituloCamp">
      <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='EMP-0100' and @lang=$lang]" disable-output-escaping="yes"/>:
      </p></td>
      <td width="35%">
          <!-- Indico el valor del identificador de la empresa actual -->
          <xsl:variable name="IDAct" select="EMP_IDTIPO"/>
          <xsl:apply-templates select="/MantenimientoEmpresas/form/field"/>
      </td>
      <td width="15%"><p class="tituloCamp">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='EMP-0066' and @lang=$lang]" disable-output-escaping="yes"/>:
        </p></td>
      <td width="35%">
        <xsl:apply-templates select="EMP_NIF"/>
        </td>
    </tr>
    <tr> 
      <td><p class="tituloCamp">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='EMP-0065' and @lang=$lang]" disable-output-escaping="yes"/>:
        </p></td>
      <td colspan="3">
        <xsl:apply-templates select="EMP_DIRECCION"/>                
        </td>
    </tr>	
    <tr> 
      <td><p class="tituloCamp">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='EMP-0080' and @lang=$lang]" disable-output-escaping="yes"/>:
        </p></td>
      <td> 
        <xsl:apply-templates select="EMP_CPOSTAL"/> 
        </td>
      <td><p class="tituloCamp">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='EMP-0090' and @lang=$lang]" disable-output-escaping="yes"/>:
        </p></td> 
      <td>
        <xsl:apply-templates select="EMP_POBLACION"/> 	     
        </td>
    </tr>	
    <tr>
      <td><p class="tituloCamp">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='EMP-0070' and @lang=$lang]" disable-output-escaping="yes"/>:
        </p></td>
      <td colspan="3">
        <xsl:apply-templates select="EMP_PROVINCIA"/> 
        </td>
    </tr>
    <tr> 
      <td><p class="tituloCamp">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='EMP-0110' and @lang=$lang]" disable-output-escaping="yes"/>:
        </p></td>
      <td> 
        <xsl:apply-templates select="EMP_TELEFONO"/> 	     
        </td>
      <td><p class="tituloCamp">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='EMP-0120' and @lang=$lang]" disable-output-escaping="yes"/>:
        </p></td>
      <td> 
        <xsl:apply-templates select="EMP_FAX"/>
        </td>
    </tr>
    <tr> 
      <td><p class="tituloCamp">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='EMP-0121' and @lang=$lang]" disable-output-escaping="yes"/>:
       </p></td>
       <td colspan="2">
        <xsl:apply-templates select="EMP_ENLACE"/>
        </td>      
      <td align="right">&nbsp;
        <!--<p class="tituloCamp">      
         <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='EMP-0122' and @lang=$lang]" disable-output-escaping="yes"/>:
         <xsl:apply-templates select="EMP_PUBLICAR"/>&nbsp;&nbsp;</p>  -->    
      </td>
    </tr>
    <tr> 
      <td><p class="tituloCamp">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='EMP-0125' and @lang=$lang]" disable-output-escaping="yes"/>:
       </p></td>
       <td colspan="3">
        <xsl:apply-templates select="EMP_LOGOTIPO"/> 	     
        </td>
    </tr>    
    <tr valign="top"> 
      <td><p class="tituloCamp">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='EMP-0130' and @lang=$lang]" disable-output-escaping="yes"/>:
        </p></td>
      <td colspan="3">
        <xsl:apply-templates select="EMP_REFERENCIAS"/>
        </td>
      </tr>
    <tr align="center" bgcolor="#EEFFFF"><td colspan="4">&nbsp;</td></tr>     
    <tr bgcolor="#EEFFFF"><td colspan="4"><table width="100%"><tr align="center" valign="top">
      <td width="25%">
        <xsl:apply-templates select="/MantenimientoEmpresas/jumpTo"/>
     </td>
      <td width="25%">  
        <xsl:apply-templates select="/MantenimientoEmpresas/form/button"/>
      </td>
      <xsl:apply-templates select="/MantenimientoEmpresas/ExtraButtons"/>      
    </tr></table></td></tr>	            	
  </table>		      	          	          	          	          	          	          	          	        	      	          	          
</xsl:template>
  
<xsl:template match="EMP_ID">
  <input type="hidden" name="EMP_ID">
    <xsl:attribute name="value"><xsl:value-of select="."/></xsl:attribute>      
  </input>  
</xsl:template>  


<xsl:template match="EMP_NOMBRE">
  <input type="text" name="EMP_NOMBRE" size="48" maxlength="70">
    <xsl:attribute name="value"><xsl:value-of select="."/></xsl:attribute>      
  </input>
</xsl:template>

<xsl:template match="EMP_NIF">
  <input type="text" size="10" name="EMP_NIF">
    <xsl:attribute name="value"><xsl:value-of select="."/></xsl:attribute>      
  </input>  
</xsl:template>

<xsl:template match="EMP_DIRECCION">
  <input type="text" name="EMP_DIRECCION" size="48" maxlength="70">
    <xsl:attribute name="value"><xsl:value-of select="."/></xsl:attribute>      
  </input>
</xsl:template>

<xsl:template match="EMP_CPOSTAL">
  <input type="text" size="5" name="EMP_CPOSTAL">
    <xsl:attribute name="value"><xsl:value-of select="."/></xsl:attribute>      
  </input>
</xsl:template>
  
<xsl:template match="EMP_POBLACION">
  <input type="text" size="18" name="EMP_POBLACION">
    <xsl:attribute name="value"><xsl:value-of select="."/></xsl:attribute>      
  </input>
</xsl:template>

<xsl:template match="EMP_PROVINCIA">
  <input type="text" size="26" name="EMP_PROVINCIA">
    <xsl:attribute name="value"><xsl:value-of select="."/></xsl:attribute>      
  </input>
</xsl:template>
    
<xsl:template match="EMP_TELEFONO">
  <input type="text" size="9" name="EMP_TELEFONO">
    <xsl:attribute name="value"><xsl:value-of select="."/></xsl:attribute>      
  </input>
</xsl:template>
  
<xsl:template match="EMP_FAX">
  <input type="text" size="9" name="EMP_FAX">
    <xsl:attribute name="value"><xsl:value-of select="."/></xsl:attribute>      
  </input>
</xsl:template>

<xsl:template match="EMP_ENLACE">
  <input type="text" size="30" name="EMP_ENLACE">
    <xsl:attribute name="value"><xsl:value-of select="."/></xsl:attribute>      
  </input>
</xsl:template>

<xsl:template match="EMP_LOGOTIPO">
  <input type="text" size="40" name="EMP_LOGOTIPO">
    <xsl:attribute name="value"><xsl:value-of select="."/></xsl:attribute>      
  </input>
</xsl:template>
  
<xsl:template match="EMP_PUBLICAR">
    <xsl:choose>
       <xsl:when test=". ='S' ">
	  <xsl:text disable-output-escaping="yes"><![CDATA[<input type="checkbox" name="EMP_PUBLICAR" checked>]]></xsl:text>
       </xsl:when>
       <xsl:otherwise>
	  <xsl:text disable-output-escaping="yes"><![CDATA[<input type="checkbox" name="EMP_PUBLICAR">]]></xsl:text>       
       </xsl:otherwise>
    </xsl:choose>     
  <xsl:text disable-output-escaping="yes"><![CDATA[
  </input>
  ]]></xsl:text>
</xsl:template>

<xsl:template match="EMP_REFERENCIAS">
  <textarea name="EMP_REFERENCIAS" cols="45" rows="5"><xsl:value-of select="."/></textarea>
</xsl:template>

<xsl:template match="ExtraButtons">
    <!-- Cada button corresponde a un form con campos ocultos /field y un submit /button -->
    <xsl:for-each select="formu">
    <xsl:choose>
    <xsl:when test="@name='dummy'">
      <!-- Colocamos form chorra porque el javascript tiene problemas con el primer formulario 
           anidado -->
      <form method="post">
        <xsl:attribute name="name"><xsl:value-of select="@name"/></xsl:attribute>
        <xsl:attribute name="action"><xsl:value-of select="@action"/></xsl:attribute>    
      </form>
    </xsl:when>
    <xsl:otherwise>       
    <td width="25%">
      <form method="post">       
      <xsl:attribute name="name"><xsl:value-of select="@name"/></xsl:attribute>
      <xsl:attribute name="action"><xsl:value-of select="@action"/></xsl:attribute>      
      <!-- Ponemos los campos input ocultos -->
      <xsl:for-each select="field">
        <input>
        <!-- Anyade las opciones comunes al campo input -->
          <xsl:attribute name="type"><xsl:value-of select="@type"/></xsl:attribute>
          <xsl:attribute name="name"><xsl:value-of select="@name"/></xsl:attribute>         
         <!-- Ponemos como nombre del EMP_ID -->
          <xsl:attribute name="value"><xsl:value-of select="../../../form/EMPRESA/EMP_ID"/></xsl:attribute>
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

</xsl:stylesheet>