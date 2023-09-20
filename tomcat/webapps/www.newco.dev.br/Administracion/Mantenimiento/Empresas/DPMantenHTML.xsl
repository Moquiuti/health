<?xml version="1.0" encoding="iso-8859-1" ?>
<!--
 |  
 +-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href = "http://www.newco.dev.br/General/General.xsl" /> 
  <xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
  <xsl:param name="lang" select="@lang"/>
  <xsl:template match="/">  
    <html> 
      <head> 
        <title><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='CEN-0100' and @lang=$lang]" disable-output-escaping="yes"/></title>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1"/>
	<meta name="description" content="insert brief description here"/> 
	<meta name="keywords" content="insert, keywords, here"/>
	<xsl:text disable-output-escaping="yes"><![CDATA[
	<link rel="stylesheet" href="http://www.newco.dev.br/General/Estilos.css" type="text/css">
        <script type="text/javascript" src="http://www.newco.dev.br/General/general.js"></script>
        <script type="text/javascript">
        <!--
        function Actua(formu){
          if(ConfirmarBorrado(formu))SubmitForm(formu);
        }
        
        function enviarDatos(form){
          if(validarFormulario(form)){
            SubmitForm(form);
          }
        }
        
        function validarFormulario(form){
          errores=0;
          
          if((!errores) && (esNulo(form.elements['DP_NOMBRE'].value))){
            errores=1;
            alert('Por favor, rogamos rellene el campo \"Nombre\" antes de enviar el formulario.');
            form.elements['DP_NOMBRE'].focus();
            return false;
          }
          
          if((!errores) && (form.elements['DP_IDRESPONSABLE'].value<1)){
            errores=1;
            alert('Por favor, rogamos seleccione el \"Responsable del Departamento\" antes de enviar el formulario.');
            form.elements['DP_IDRESPONSABLE'].focus();
            return false;
          }
          
          if(!errores)
            return true;
          else
            return false;
        }
        
        //-->
        </script>
        ]]></xsl:text>	
      </head>

      <body bgcolor="#FFFFFF" text="#000000" link="#333366" vlink="#333366" alink="#3399ff"> 
      <xsl:choose>
           <xsl:when test="//SESION_CADUCADA">
            <xsl:for-each select="//SESION_CADUCADA">
              <xsl:if test="position()=last()">
                <xsl:apply-templates select="."/>
              </xsl:if>
            </xsl:for-each>        
          </xsl:when>
           <xsl:when test="//xsql-error">
             <xsl:apply-templates select="//xsql-error"/>        
           </xsl:when>
           <xsl:otherwise>
	        <br/>
	        <p class="tituloPag" align="center">	           
	        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='DP-0100' and @lang=$lang]" disable-output-escaping="yes"/>	        
                </p>	        
	        <br/>	                           
                <xsl:apply-templates select="Mantenimiento/form"/>   
          </xsl:otherwise>
          </xsl:choose>       	
      </body>
    </html>
  </xsl:template>

<!--
 |  Templates
 +-->

<xsl:template match="Sorry">
  <xsl:value-of select="."/>
</xsl:template>

<xsl:template match="pageTitle">
  <title><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='EMP-0060' and @lang=$lang]"/></title>
</xsl:template>

<xsl:template match="form">
  <form method="post">
    <xsl:attribute name="name">
      <xsl:value-of select="@name"/>
    </xsl:attribute>
    <xsl:attribute name="action">
      <xsl:value-of select="@action"/>
    </xsl:attribute>
    <xsl:apply-templates select="Lista/Registro"/>
  </form>
</xsl:template>

<xsl:template match="Registro">
  <xsl:apply-templates select="EMP_ID"/>
  <xsl:apply-templates select="DP_ID"/>  
  <table width="100%" border="0" cellspacing="1" cellpadding="3" class="muyoscuro">	
    <tr class="oscuro"> 
      <td colspan="4">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='DP-0105' and @lang=$lang]" disable-output-escaping="yes"/>:      
      </td>
    </tr>
    <tr class="blanco"><td colspan="4">&nbsp;</td></tr>    	
    <tr class="blanco"> 
      <td width="20%"  class="claro" align="right">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='DP-0110' and @lang=$lang]" disable-output-escaping="yes"/>:
      </td>
      <td colspan="3"> 
        <xsl:apply-templates select="EMP_NOMBRE"/>
      </td>
    </tr>		    		          	          	    
    <tr class="blanco"> 
      <td width="20%" class="claro" align="right">
      <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='DP-0120' and @lang=$lang]" disable-output-escaping="yes"/>:<span  class="camposObligatorios" width="1%">*</span>
      </td>
      <td colspan="3">
        <xsl:apply-templates select="DP_NOMBRE"/>
        </td>
    </tr>
    <tr class="blanco"> 
      <td class="claro" align="right">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='DP-0130' and @lang=$lang]" disable-output-escaping="yes"/>:<span  class="camposObligatorios" width="1%">*</span>
      </td>
      <td colspan="3">
        <!--<xsl:variable name="IDAct" select="DP_IDRESPONSABLE"/>
        <xsl:apply-templates select="../../field"/>-->
        
        <xsl:call-template name="field_funcion">
    	  <xsl:with-param name="path" select="../../field"/>
    	  <xsl:with-param name="IDAct" select="DP_IDRESPONSABLE"/>
    	</xsl:call-template>
        </td>
    </tr>
    <tr class="blanco"><td colspan="4">&nbsp;</td></tr>	
    <tr class="blanco"><td colspan="4"><table width="100%" cellpadding="0" cellspacing="0" border="0">
    <tr align="center" valign="bottom" height="30px"> 
      <td>
        <xsl:call-template name="boton">
          <xsl:with-param name="path" select="../../../botones_nuevo/button[@label='Cancelar']"/>
        </xsl:call-template>
      </td>      
      <td>  
        <xsl:call-template name="boton">
          <xsl:with-param name="path" select="../../../botones_nuevo/button[@label='Aceptar']"/>
        </xsl:call-template>
      </td>
      <xsl:if test="/Mantenimiento/form/Lista/Registro/DP_ID!='0'">
        <xsl:apply-templates select="../../../ExtraButtons"/>            
      </xsl:if>
    </tr></table></td></tr>	            	
  </table>		      	          	          	          	          	          	          	          	        	      	          	          
</xsl:template>
  
<xsl:template match="EMP_ID">
  <input type="hidden" name="EMP_ID">
    <xsl:attribute name="value">
      <xsl:value-of select="."/> 
    </xsl:attribute>      
  </input>
</xsl:template>  

<xsl:template match="DP_ID">
  <input type="hidden" name="DP_ID">
    <xsl:attribute name="value">
      <xsl:value-of select="."/> 
    </xsl:attribute>      
  </input>
</xsl:template> 

<xsl:template match="DP_NOMBRE">
  <input type="text" name="DP_NOMBRE" size="50" maxlength="200">
    <xsl:attribute name="value">
      <xsl:value-of select="."/> 
    </xsl:attribute>      
  </input>
</xsl:template>


<xsl:template match="EMP_NOMBRE">
      <xsl:value-of select="."/> 
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
      <xsl:call-template name="boton">
        <xsl:with-param name="path" select="//botones_nuevo/button[@label='Borrar']"/>
      </xsl:call-template>  
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
         <!-- Ponemos como nombre del field el identificador ID -->
         <xsl:choose>
           <xsl:when test="EMP_ID">
             <xsl:attribute name="value">
             <xsl:value-of select="EMP_ID"/>
             </xsl:attribute>             
           </xsl:when>         
           <xsl:when test="DP_ID">
             <xsl:attribute name="value">
             <xsl:value-of select="DP_ID"/>
             </xsl:attribute>             
           </xsl:when>         
         </xsl:choose>
         </input>        
      </xsl:for-each>       
      <!-- Anyadimos el boton de submit -->      
    </form>
    </td>
    </xsl:otherwise>
    </xsl:choose>        
    </xsl:for-each>
</xsl:template>

</xsl:stylesheet>