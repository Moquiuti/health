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
        <title>Detalle Oferta</title>
	<xsl:text disable-output-escaping="yes"><![CDATA[
	<link rel="stylesheet" href="http://www.newco.dev.br/General/Estilos.css" type="text/css">
	<script type="text/javascript" src="http://www.newco.dev.br/General/general.js">
	</script>       
        ]]></xsl:text>
      </head>
      <body bgcolor="#EEFFFF" onLoad="Habilita()">   
        <xsl:choose>
          <xsl:when test="Generar/xsql-error"> 
          <p class="tituloForm">     
            <xsl:apply-templates select="Generar/xsql-error"/>
          </p>
          </xsl:when>
          <xsl:otherwise>                    
	   <!--<p id="buttons" style="position:absolute;visibility:visible;top:0px;left:320px">
	      <table width="100%" border="0">	    
	        <tr>
		  <xsl:for-each select="Generar/button">
		    <td align="center">		  		  
		      <xsl:apply-templates select="."/>
                    </td>
                  </xsl:for-each>                    
                </tr>  	  
              </table>
            </p>-->	    
            <xsl:apply-templates select="Generar/MULTIOFERTA"/>
	    <table width="100%" border="0">
	      <tr align="center">
		<td><xsl:apply-templates select="Generar/button"/></td></tr></table>            
          </xsl:otherwise>
        </xsl:choose>
      </body>
    </html>
  </xsl:template>  


<!-- TEMPLATES --> <!-- TEMPLATES --> <!-- TEMPLATES --> <!-- TEMPLATES --> <!-- TEMPLATES -->      

<xsl:template match="LISTAPROCESOS">
  <p id="principal" style="z-index:1;position:absolute;overflow:auto;visibility:visible;width:280px;height:440px;left:0px;top:0px">
    <form name="form1" method="post">    
    <select name="selField" size="25" disabled="disabled">
      <xsl:attribute name="onChange">mostrar(this.form,<xsl:value-of select = "$num_plantillas"/>);</xsl:attribute>
      <xsl:for-each select="MULTIOFERTAS">               
        <option>
          <xsl:attribute name="value"><xsl:value-of select="MO_ID"/></xsl:attribute>
          <xsl:value-of select="LP_FECHAEMISION"/>:<xsl:value-of select="LP_NOMBRE"/>
        </option> 
      </xsl:for-each>            
    </select>     
    </form>
  </p>    
</xsl:template>


<xsl:template match="MULTIOFERTA">                   
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr valign="top">
        <td colspan="5"><table width="100%" border="1" bordercolor="#A0D8D7" cellpadding="0" cellspacing="0"><tr><td><table width="100%" cellpadding="0" cellspacing="0" border="0"><tr valign="top">
        <td width="20%"><p class="tituloCamp">
          <xsl:value-of disable-output-escaping="yes" select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='VC-0010' and @lang=$lang]"/>:</p></td>
        <td width="30%">
          <xsl:value-of select="EMP_NOMBRE"/>&nbsp;
          </td>
        <td width="20%"><p class="tituloCamp">
          <xsl:value-of disable-output-escaping="yes" select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='VC-0020' and @lang=$lang]"/>:</p></td>
        <td width="30%">
          <xsl:value-of select="US_NOMBRE"/>&nbsp;</td></tr>       
        <tr valign="top">
        <td><p class="tituloCamp">
          <xsl:value-of disable-output-escaping="yes" select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='VC-0030' and @lang=$lang]"/>:</p></td>
        <td><xsl:value-of select="STATUS_DESC"/>&nbsp;</td>         
        <td><p class="tituloCamp">
          <xsl:value-of disable-output-escaping="yes" select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='VC-0040' and @lang=$lang]"/>:</p></td>
        <td>
          <xsl:value-of select="PED_IMPORTE_TOTAL"/>&nbsp;
          </td>         
       </tr>             
	  <tr>
	    <td><p class="tituloCamp"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='LP-0300' and @lang=$lang]" disable-output-escaping="yes"/>:</p></td>
	    <td>
	      <xsl:value-of select="LP_FECHAEMISION"/>&nbsp;</td>
	    <td>
	      <p class="tituloCamp"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='MO-0210' and @lang=$lang]" disable-output-escaping="yes"/>:</p></td>
	    <td>
	      <xsl:value-of select="LP_FECHADECISION"/>&nbsp;</td></tr>
	  <tr valign="top">
	    <td>
	      <p class="tituloCamp"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='MO-0220' and @lang=$lang]" disable-output-escaping="yes"/>:</p></td>
	    <td>
	      <xsl:value-of select="LP_FECHAENTREGA"/>&nbsp;</td>
            <td width="20%">
              <p class="tituloCamp"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='MO-0112' and @lang=$lang]" disable-output-escaping="yes"/>:</p></td>
            <td width="40%"><xsl:value-of select="CENTRO/CEN_DIRECCION"/><br/><xsl:value-of select="CENTRO/CEN_CPOSTAL"/>-<xsl:value-of select="CENTRO/CEN_POBLACION"/><br/><xsl:value-of select="CENTRO/CEN_PROVINCIA"/></td></tr>	                
	  <tr>            
	    <td>
	      <p class="tituloCamp"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='MO-0110' and @lang=$lang]" disable-output-escaping="yes"/>:</p></td>
	    <td colspan="3">
	      <xsl:value-of select="MO_FORMAPAGO"/>&nbsp;</td></tr>       
	  <tr>
	    <td>
	      <p class="tituloCamp"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='MO-0120' and @lang=$lang]" disable-output-escaping="yes"/>:</p></td>
	    <td colspan="3">
	      <xsl:value-of select="MO_CONDICIONESGENERALES"/>&nbsp;</td></tr>
       <!--
       |
       |        Incluimos todas las lineas de la multioferta
       |
       +-->
       </table></td></tr></table></td></tr>
       <tr><td colspan="5">&nbsp;</td></tr>
       <tr>
         <td colspan="5"><p class="tituloForm"> 
                <xsl:value-of disable-output-escaping="yes" select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='VC-0070' and @lang=$lang]"/>                
         </p></td>
       </tr>
       <tr><td colspan="5">&nbsp;</td></tr>
       <tr valign="top" bgcolor="#A0D8D7">
         <td><p class="tituloCamp"> 
                <xsl:value-of disable-output-escaping="yes" select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='VC-0300' and @lang=$lang]"/>                
         </p></td>
         <td><p class="tituloCamp"> 
                <xsl:value-of disable-output-escaping="yes" select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='VC-0310' and @lang=$lang]"/>                
         </p></td>
         <td><p class="tituloCamp"> 
                <xsl:value-of disable-output-escaping="yes" select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='VC-0320' and @lang=$lang]"/>                
         </p></td>
         <td><p class="tituloCamp"> 
                <xsl:value-of disable-output-escaping="yes" select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='VC-0330' and @lang=$lang]"/>                
         </p></td>
         <td><p class="tituloCamp"> 
                <xsl:value-of disable-output-escaping="yes" select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='VC-0340' and @lang=$lang]"/>                
         </p></td>
       </tr>
       <tr><td colspan="5">&nbsp;</td></tr>
       <xsl:for-each select="LINEAS_MULTIOFERTA/LINEAS_MULTIOFERTA_ROW">
        <tr valign="top">       
          <td>
            <xsl:value-of select="LMO_IDPRODUCTO"/>
          </td>
          <td>
            <xsl:value-of select="PRO_NOMBRE"/>
          </td>
          <td>
            <xsl:value-of select="LMO_CANTIDAD"/>
          </td>
          <td>
            <xsl:value-of select="LMO_PRECIO"/>
          </td>
          <td align="right">
            <xsl:value-of select="LMO_TOTAL"/>
          </td>
       </tr>
       </xsl:for-each>
        <tr><td colspan="5">&nbsp;</td></tr>              
        <tr valign="top">       
          <td colspan="3">&nbsp;
            <xsl:value-of select="LMO_IDPRODUCTO"/>
          </td>
          <td><p class="tituloCamp"> 
            <xsl:value-of disable-output-escaping="yes" select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='VC-0090' and @lang=$lang]"/> 
            </p>
          </td>
          <td align="right"><p class="tituloCamp"> 
            <xsl:value-of select="PED_SUBTOTAL"/>
            </p>
          </td>
       </tr>      
    </table> 
</xsl:template> 

</xsl:stylesheet>
