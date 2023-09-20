<?xml version="1.0" encoding="iso-8859-1" ?>
<!--
 | ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
 |
 | Fichero.......: TRFClientesParaListadoHTML.xsl
 | Autor.........: Olivier JEAN
 | Fecha.........: 08/01/2001
 | Descripcion...: Tarifas de productos por empresa
 | Funcionamiento: 
 |
 |Modificaciones:
 |   Fecha       Autor          Modificacion
 |
 | Situacion: __Desarrollo__
 |
 |(c) 2001 MedicalVM
 |///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
 +-->
 
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href = "http://www.newco.dev.br/General/General.xsl" />
  <xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
  <xsl:param name="lang" select="@lang"/>  
  <xsl:template match="/ClientesParaListado">
    <html>
      <head>
        <xsl:text disable-output-escaping="yes"><![CDATA[
	<link rel="stylesheet" href="http://www.newco.dev.br/General/Estilos.css" type="text/css"/>      
	<script type="text/javascript" src="http://www.newco.dev.br/General/general.js">
	</script>
	<script type="text/javascript">
	<!--
	
	
	function Actua(formu) {
	
	var pag = 'http://www.newco.dev.br/Administracion/Mantenimiento/Tarifas/TRFListado.xsql';
	
	us_id=formu.elements['US_ID'].value;
	idx=formu.elements['emp'].selectedIndex;
	emp_id=formu.elements['emp'].options[idx].value;
	pag += '?US_ID='+us_id  +'&EMP_IDCLIENTE='+emp_id;
	
	if (formu.elements['TextoPlano'].checked) pag+='&TEXTO_PLANO=S';
	if (formu.elements['ConPrecio'].checked) pag+='&CON_PRECIO=S';
	
	AsignarAccion(formu,pag);
	SubmitForm(formu);
	} 
	
	
	
	
	//-->
	</script>
      ]]></xsl:text>
      </head>
      <body bgcolor="#EEFFFF">  
        <xsl:choose>
      	<!-- Desactivado control errores para desarrollo...
          <xsl:when test="ListaDerechosUsuarios/xsql-error">
            <xsl:apply-templates select="ListaDerechosUsuarios/xsql-error"/>          
          </xsl:when>
	-->
        <xsl:when test="Sorry">
          <xsl:apply-templates select="Sorry"/> 
        </xsl:when>
        <xsl:otherwise>
        
      <!--+
          |
          | Titulo Pagina
          + -->
          
         <p align="center" class="tituloPag">Listado de Tarifas para sus clientes</p>
         <br/><br/>

       <!--+
          |
          | Combo con las empresas + checkboxes
          + -->
   
   <form method="post">
     <input name="US_ID" type="hidden" value="{US_ID}"/>
     <table align="center" width="100%" border="0" cellpadding="0" cellspacing="0">
     	<tr>
	  <p class="tituloCamp">Seleccione un cliente:</p>
     	  <xsl:variable name="IDAct" select="nada"/>
     	  <td colspan="2" align="left"><xsl:apply-templates select="field"/></td>
     	</tr>
     	<tr><td colspan="2">&nbsp;</td></tr>  
        <tr>
          <td width="5%"><input type="checkbox" name="ConPrecio" checked="true"/></td>
          <td>Ver sólo productos con precio</td>
        </tr>
        <tr>
          <td width="5%"><input type="checkbox" name="TextoPlano"/></td>
          <td>Exportar precios a una hoja Excel</td>
        </tr>
        <tr>
          <td colspan="2">&nbsp;</td>
        </tr>
        <tr><td colspan="2">&nbsp;</td></tr>
        <tr>
          <td align="center" colspan="2"><xsl:apply-templates select="button"/></td>
        </tr>
     </table>
   </form>
   
     <br/><br/>
    </xsl:otherwise>
   </xsl:choose>
  </body>
 </html>
</xsl:template>  

</xsl:stylesheet>
