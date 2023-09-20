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
         <!--style-->
      <xsl:call-template name="estiloIndip"/>
      <!--fin de style-->  

     <script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
	 <script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>
     <script type="text/javascript" src="http://www.newco.dev.br/Administracion/ClientesYProveedores/CYP.js"></script>
      
      </head>

      <body class="gris">
        <h1 class="titlePage">     
	  <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='CYP-0000' and @lang=$lang]" disable-output-escaping="yes"/>	        
		</h1>                 
        
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

  <table class="infoTable">
    <tr class="subTituloTabla"> 
      <td colspan="2" >
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='CYP-0210' and @lang=$lang]" disable-output-escaping="yes"/>
      </td>  
    </tr>
     <tr height="7px"><td colspan="2"></td></tr>
    <tr> 
      <td class="labelRight cuarenta">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='CYP-0240' and @lang=$lang]" disable-output-escaping="yes"/>:
      </td>
      <td class="datosLeft">  
		<input type="text" size="52" name="EMP_NOMBRE"/>
      </td>
    </tr>		    		          	          	    
    <tr> 
      <td class="labelRight">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='CYP-0280' and @lang=$lang]" disable-output-escaping="yes"/>:
      </td>
      <td class="datosLeft">  
          <xsl:call-template name="field_funcion">
    	  <xsl:with-param name="path" select="field"/>
    	  <xsl:with-param name="IDAct" select="TE_ID"/>
    	</xsl:call-template>
          <input type="hidden" size="10" name="EMP_NIF"/>
      </td>
    </tr>
		<input type="hidden" size="52" name="EMP_DIRECCION"/>               
    <tr> 
       <td class="labelRight">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='CYP-0260' and @lang=$lang]" disable-output-escaping="yes"/>:
      </td>
       <td class="datosLeft">  
	<input type="text" size="5" name="EMP_CPOSTAL"/>
        </td>
      </tr>
      <tr>
       <td class="labelRight">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='CYP-0270' and @lang=$lang]" disable-output-escaping="yes"/>:&nbsp;&nbsp;
      </td> 
     
       <td class="datosLeft">  
	<input type="text" size="20" name="EMP_POBLACION"/> 	     
        </td>
    </tr>	
    <tr> 
       <td class="labelRight">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='CYP-0250' and @lang=$lang]" disable-output-escaping="yes"/>:
      </td>
       <td class="datosLeft">  
	<input type="text" size="23" name="EMP_PROVINCIA"/>
      </td>
    </tr>
		<input type="hidden" size="9" name="EMP_TELEFONO"/> 	     
		<input type="hidden" size="9" name="EMP_FAX"/>
    <tr height="7px"><td colspan="2">&nbsp;</td></tr>
    <tr class="subTituloTabla"> 
      <td colspan="2" >
              <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='CYP-0330' and @lang=$lang]" disable-output-escaping="yes"/>
           
       </td>
        </tr>
      <tr height="7px"><td colspan="2"></td></tr>
        <tr>
           <td class="labelRight">
            <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='CYP-0335' and @lang=$lang]" disable-output-escaping="yes"/>: 
          </td>
           <td class="datosLeft">  
            <select name="CONSULTAPREDEFINIDA">
              <option value="-1">[Consultas Predefinidas]</option>
              <option value="CLI_NO">Clientes NO activados</option>
              <option value="CLI_SI">Clientes activados</option>
              <option value="PRV_NO">Proveedores NO activados</option>
              <option value="PRV_SI">Proveedores activados</option>
              <option value="PRV_HAB">Proveedores habituales</option>
            </select>
         
    </td>
  </tr> 
   <tr height="7px"><td colspan="2"></td></tr>
  <tr>
    <td class="labelRight">   
       Clientes Y Proveedores
     </td>        
     <td>  &nbsp;&nbsp;&nbsp;&nbsp; 
        <xsl:call-template name="boton">
        <xsl:with-param name="path" select="button[@label='BuscarCYP']"/>
        </xsl:call-template>
      </td> 
   </tr>  	     
     
  </table>    	  

  </form>
</xsl:template>

</xsl:stylesheet>