<?xml version="1.0" encoding="iso-8859-1" ?>
<!--
 |	Informe: Tarifas de productos por empresa
 |
 |	(c) 12/1/2001 ET
 |	
 +-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href = "http://www.newco.dev.br/General/General.xsl" />
  <xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
  <xsl:param name="lang" select="@lang"/>  
  <xsl:template match="/ListadoTarifas">
    <html>
      <head>
        <script type="text/javascript" src="http://www.newco.dev.br/General/general.js">
	</script>
        <!-- 
	<title><xsl:value-of select="document('messages.xml')/messages/msg[@id='USD-1010' and @lang=$lang]" disable-output-escaping="yes"/></title>
	-->
	<title><xsl:value-of select="TITULO" disable-output-escaping="yes"/></title>
	<xsl:text disable-output-escaping="yes"><![CDATA[
	<link rel="stylesheet" href="http://www.newco.dev.br/General/Estilos.css" type="text/css">
        ]]></xsl:text>
      </head>
      <body bgcolor="#EEFFFF" text="#000000" link="#333366" vlink="#333366" alink="#3399ff">      
        <xsl:choose>
      	<!-- ET Desactivado control errores: Habra que reactivarlo
          <xsl:when test="ListaDerechosUsuarios/xsql-error">
            <xsl:apply-templates select="ListaDerechosUsuarios/xsql-error"/>          
          </xsl:when>
	-->
        <xsl:when test="ListadoTarifas/Sorry">
          <xsl:apply-templates select="ListadoTarifas/Sorry"/> 
        </xsl:when>
        <xsl:otherwise>
        
        <!-- Titulo -->	      
	      <p align="center" class="tituloPag"><xsl:value-of select="CABECERA/PROVEEDOR"/>: Listado de Tarifas para <xsl:value-of select="CABECERA/CLIENTE"/></p>
	      <br/>
        
        <!--+
            | CABECERA 
            |
            + -->
         <table width="100%" border="0" align="center" cellspacing="0" cellpadding="0" >  
           <tr>
            <td width="10%" class="tituloCamp" align="left">Usuario: </td><td width="70%"align="left"><xsl:value-of select="CABECERA/NOMBRE"/></td>
            <td width="7%"class="tituloCamp" align="left">Fecha: </td><td align="right"><xsl:value-of select="CABECERA/FECHA"/></td> 
          </tr>
         </table>
        
        <br/><br/>
    <!--+
            | LINEAS DE PRODUCTO 
            |
            + -->    
     <xsl:choose>
      <xsl:when test="TEXTO_PLANO[.='S']"> <!-- devuelve la lista de productos en texto plano, con | como separador -->
  	<xsl:call-template name="PASOS_A_SEGUIR"/>
  	<b>Referencia|Producto|Ud.base|Ud./caja|Importe</b>
  	<br/><br/>
  	<xsl:for-each select="LINEAPRODUCTO">
  	  <xsl:if test="((not(IMPORTE[.='Pts']) and ../CON_PRECIO) or not(../CON_PRECIO[.='S']))">
  		<xsl:value-of select="REFERENCIA"/>|<xsl:value-of select="PRODUCTO"/>|<xsl:value-of select="UNIDADBASICA"/>|<xsl:value-of select="UNIDADESPORLOTE"/>|<xsl:value-of select="IMPORTE"/><br/>
	  </xsl:if>
	</xsl:for-each>
      </xsl:when>
      
      <xsl:otherwise>
        <table width="100%" border="1" align="center" cellspacing="0" cellpadding="0" >
	     
          <tr bgcolor="#A0D8D7">
	      	<td width="10%" align="center"><p class="tituloCamp">Referencia</p></td>
	      	<td width="60%" align="center"><p class="tituloCamp">Producto</p></td>
	      	<td width="7%" align="center"><p class="tituloCamp">Ud.base</p></td>
	      	<td width="7%" align="center"><p class="tituloCamp">Ud./caja</p></td>
	      	<td width="16%" align="center"><p class="tituloCamp">Importe</p></td>
	  </tr>
	  <!--<tr><td colspan="5">&nbsp;</td></tr>-->
	
          <xsl:for-each select="LINEAPRODUCTO">
           <xsl:if test="(not(IMPORTE[.='Pts']) and ../CON_PRECIO) or not(../CON_PRECIO[.='S'])"> 
            <tr>
                <td width="10%" align="center"><xsl:value-of select="REFERENCIA"/>&nbsp;</td>
                <td width="60%" align="left"><xsl:value-of select="PRODUCTO"/>&nbsp;</td>
                <td width="7%" align="right"><xsl:value-of select="UNIDADBASICA"/>&nbsp;</td>
                <td width="7%" align="right"><xsl:value-of select="UNIDADESPORLOTE"/>&nbsp;</td>
                <td width="16%" align="right"><xsl:value-of select="IMPORTE"/>&nbsp;</td>
	    </tr>
	   </xsl:if>
          </xsl:for-each>	    
        </table>
       </xsl:otherwise>
      </xsl:choose>
      
     <br/><br/>
     <p align="center"><xsl:apply-templates select="jumpTo"/></p>
    </xsl:otherwise>
   </xsl:choose>
  </body>
 </html>
</xsl:template>  

 <xsl:template name="PASOS_A_SEGUIR">
	<hr/>
	<p class="tituloCamp">Pasos a seguir para exportar precios a una hoja Excel:</p>
	<ol>
	  <li>Seleccionar con el mouse (botón izquierdo) los campos deseados</li>
	  <li>Pulsar el botón derecho del ratón y la opción "Copiar" del menu desplegable</li>
	  <li>Abrir un programa de texto: Inicio > Programas > Accesorios > Bloc de Notas</li>
	  <li>Pegar con el botón derecho del ratón</li>
	  <li>Guardar (ej: lista-precios.txt)</li>
	  <li>Abrir con el Excel (no olvidar opción Tipo de Archivos 'Todos los archivos (*.*)')</li>
	  <li>Escoger opción "Delimitados"</li>
	  <li>Escoger signo "|"</li>
	  <li>Finalizar</li>
	  <li>Guardar como fichero Excel</li>
	</ol>
	<hr/>
	
 </xsl:template>

</xsl:stylesheet>
