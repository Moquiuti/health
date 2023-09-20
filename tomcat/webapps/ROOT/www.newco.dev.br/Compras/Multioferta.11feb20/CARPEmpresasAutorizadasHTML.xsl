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
         <script type="text/javascript" src="http://www.newco.dev.br/General/general.js"></script>	
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
      <body bgcolor="#FFFFFF">
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
   
        <table width="80%" align="center" class="gris" cellpadding="0" cellspacing="1">
          <tr class="grisClaro">
            <td>
              <table width="100%">
                <tr>
                  <td align="left">
                    <b>Empresas Autorizadas</b>
                    <br/>
                    <i>Asigne aquí las empresas autorizadas para la carpeta</i>
                  </td>
                  <td align="right">
                   &nbsp;
                  </td>
                </tr>
              </table>
            </td>
          </tr>
          

          <xsl:if test="Mantenimiento/EMPRESASAUTORIZADAS/EMPRESA">
          <tr class="claro">
            <td class="blanco">
          
            <br/>
            <br/>
               <table width="100%" class="medio" align="center" cellpadding="1" cellspacing="1">
          <tr class="oscuro" align="center">
            <td>
              Empresa
            </td>
          </tr>

          <xsl:for-each select="Mantenimiento/EMPRESASAUTORIZADAS/EMPRESA">
          
          <tr class="claro" align="center">
            <td align="left">
              <table width="100%">
                <tr>
                <td width="20%"  align="center">
              		<xsl:call-template name="botonPersonalizado">
	      			<xsl:with-param name="funcion">BorrarEmpresa(document.forms[0],'<xsl:value-of select="ID"/>');</xsl:with-param>
	      			<xsl:with-param name="label">Eliminar</xsl:with-param>
	      			<xsl:with-param name="status">Eliminar empresa</xsl:with-param>
					</xsl:call-template>
					<!--
                    <xsl:call-template name="boton">
                      <xsl:with-param name="path" select="/Mantenimiento/button[@label='Borrar']"/>
                    </xsl:call-template>
					-->
	      		</td>
	      		<td width="80%"  align="left">
	    			&nbsp;&nbsp;<xsl:value-of select="NOMBRE"/>
	      		</td>
	      		</tr>
	      	  </table>
            </td>
          </tr>
            
          </xsl:for-each>
          
        </table> 
        <br/>
        <br/>
            </td>
          </tr>
          </xsl:if>
          <tr class="grisClaro">
              <td align="left" class="grisClaro">
                Autorizar empresas
              </td>
          </tr>
          <tr  class="blanco">
            <td align="left" class="blanco">
              <table class="medio" width="100%" align="center" cellspacing="1" cellpadding="1">
                <tr class="oscuro" align="center">
                  <td  class="oscuro" width="80%">
                    Empresa
                  </td>
                  <td  class="oscuro" width="20%">
                    Insertar
                  </td>
                </tr>
                <tr class="claro" align="center">
                  <td> 
				  	<xsl:apply-templates select="/Mantenimiento/EMPRESAS/field"/>
                  </td>
                  <td align="center">
                    <xsl:call-template name="boton">
                      <xsl:with-param name="path" select="Mantenimiento/button[@label='Insertar']"/>
                    </xsl:call-template>
                  </td>
                </tr> 
              </table>
            </td>
          </tr>
          <tr>
            <td>
              <table width="100%" class="blanco">
                <tr>
                  <td align="center">
                    <xsl:call-template name="boton">
                      <xsl:with-param name="path" select="Mantenimiento/button[@label='Cerrar']"/>
                    </xsl:call-template>
                  </td>
                </tr>
              </table>
            </td>
          </tr>
          </table>
        </form>
        </xsl:otherwise>
        </xsl:choose>
      </body>
    </html>
  </xsl:template>

</xsl:stylesheet>
