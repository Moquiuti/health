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
       <!--style-->
      <xsl:call-template name="estiloIndip"/>
      <!--fin de style-->  

     <script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
	 <script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>
     
	<xsl:text disable-output-escaping="yes"><![CDATA[

        <script type="text/javascript">
        <!--

          
	function CerrarVentana()
	{
		window.close();
		Refresh(top.opener.document);
	}
          
        	
	function ActualizarDatos(form, accion)
	{
		document.forms[0].elements['ACCION'].value=accion; 
		SubmitForm(form);
	}
        	
	function BorrarEmpresa(form, empresa)
	{
		document.forms[0].elements['ACCION'].value='ELIMINAR'; 
		document.forms[0].elements['IDEMPRESA'].value=empresa; 
		SubmitForm(form);
	}
                   
	//-->        
        </script>
        ]]></xsl:text> 
        
        
      </head>
      <body class="gris">
      
       <!--idioma-->
         <xsl:variable name="lang">
        <xsl:choose>
            <xsl:when test="/Mantenimiento/LANG"><xsl:value-of select="/Mantenimiento/LANG" /></xsl:when>
            <xsl:otherwise>spanish</xsl:otherwise>
            </xsl:choose>  
        </xsl:variable>

        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>        
      <!--idioma fin-->


        <xsl:choose>
          <!-- Error en alguna sentencia del XSQL -->
          <xsl:when test="//xsql-error">
            <xsl:apply-templates select="//xsql-error"/>        
          </xsl:when>
          <xsl:when test="//SESION_CADUCADA">
            <xsl:for-each select="//SESION_CADUCADA">
              <xsl:if test="position()=last()">
                <xsl:apply-templates select="."/>
              </xsl:if>
            </xsl:for-each>        
          </xsl:when>
          <xsl:otherwise>    
        <form name="form1" action="PLEmpresasAutorizadasSave.xsql" method="post">
          <input type="hidden" name="PL_ID" value="{/Mantenimiento/PL_ID}"/>
          <input type="hidden" name="ACCION"/>
   
        
         
          
          

          <xsl:if test="Mantenimiento/EMPRESASAUTORIZADAS/EMPRESA"> 
          <div class="divLeft">
          <h1 class="titlePage">
              <xsl:value-of select="document($doc)/translation/texts/item[@name='empresas_autorizadas']/node()"/>&nbsp;-&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='asigne_aqui_empresas_autorizadas']/node()"/>
          </h1>
          <table class="encuesta">
          <xsl:for-each select="Mantenimiento/EMPRESASAUTORIZADAS/EMPRESA">
          <tr>
	      		<td align="right" class="cinquenta">
	    			<xsl:value-of select="NOMBRE"/>&nbsp;&nbsp;
	      		</td>
                <td>
                	<a>
                    <xsl:attribute name="href">javascript:BorrarEmpresa(document.forms[0],'<xsl:value-of select="ID"/>');</xsl:attribute>
                    <img src="http://www.newco.dev.br/images/eliminarOferta.gif" alt="Eliminar"/>
                    </a>
	      		</td>         
          </tr>
          
          </xsl:for-each>
          </table>
          </div><!--fin de divleft-->
          </xsl:if>
          
          <div class="divLeft">
           <h1 class="titlePage">
                    <xsl:value-of select="document($doc)/translation/texts/item[@name='empresas_autorizadas']/node()"/>&nbsp;-&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='asigne_aqui_empresas_autorizadas']/node()"/>
          </h1>
          <table class="encuesta">
          <tr class="titulos">
           
                  <th  class="oscuro">
                    <xsl:value-of select="document($doc)/translation/texts/item[@name='empresa']/node()"/>
                  </th>
                  <th  class="oscuro">
                    <xsl:value-of select="document($doc)/translation/texts/item[@name='dar_derechos']/node()"/>
                  </th>
                  <th  class="oscuro">
                    <xsl:value-of select="document($doc)/translation/texts/item[@name='insertar']/node()"/>
                  </th>
                </tr>
                <tr align="center">
                  <td> 
				  	<xsl:apply-templates select="/Mantenimiento/EMPRESAS/field"/>
                  </td>
                  <td> 
				  	<input type="checkbox" name="TODOSUSUARIOS"/>
				  	&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='a_todos_los_usuarios']/node()"/>
                  </td>
                  <td align="center">
                    <xsl:call-template name="boton">
                      <xsl:with-param name="path" select="Mantenimiento/button[@label='Insertar']"/>
                    </xsl:call-template>
                  </td>
                </tr> 
          <tfoot>
           <tr>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
            <td>&nbsp;</td>     
          </tr>
          <tr>
          <td>&nbsp;</td>
          <td>
             <xsl:call-template name="boton">
                <xsl:with-param name="path" select="Mantenimiento/button[@label='Cerrar']"/>
             </xsl:call-template>
            </td>
            <td>&nbsp;</td>     
          </tr>
          </tfoot>
          </table>
          </div><!--fin divleft-->
        </form>
        </xsl:otherwise>
        </xsl:choose>
      </body>
    </html>
  </xsl:template>

</xsl:stylesheet>
