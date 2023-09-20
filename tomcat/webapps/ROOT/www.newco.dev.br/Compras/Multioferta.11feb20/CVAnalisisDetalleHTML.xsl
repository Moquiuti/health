<?xml version="1.0" encoding="iso-8859-1" ?>
<!--
 |  
 |
 |
 +-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href = "http://www.newco.dev.br/General/General.xsl" />
  <xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
  <xsl:param name="lang" select="@lang"/>  
  <xsl:template match="/">
    <html>
      <head>
        <title><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='CVD-0010' and @lang=$lang]" disable-output-escaping="yes"/></title>
	<xsl:text disable-output-escaping="yes"><![CDATA[
	<link rel="stylesheet" href="http://www.newco.dev.br/General/Estilos.css" type="text/css">
	<script type="text/javascript" src="http://www.newco.dev.br/General/general.js">
	</script>
	<SCRIPT type="text/javascript">
	<!--
	  var turno=1;
	  function resize () {
 	    if (turno==1){
	      resizeBy(-200, 0);
	      moveBy(200,0);
	      window.parent.focus();
	      turno=0;
	    }else{
	      resizeBy(200, 0);
	      moveBy(-200,0);      
	      turno=1;	    
	    } 	    	  
	  }
	//-->   	
	</SCRIPT>        
        ]]></xsl:text>
      </head>
      <body bgcolor="#EEFFFF">      
        <xsl:choose>
          <xsl:when test="Generar/xsql-error">
             <xsl:apply-templates select="//xsql-error"/>          
          </xsl:when>
          <xsl:otherwise>                    
            <xsl:apply-templates select="Generar/LISTAPROCESOS"/>
	      <br/>
	      <table width="100%" border="0" cellpadding="0" cellspacing="0">	    
	        <tr>
		    <td align="center">		  		  
		      <xsl:apply-templates select="Generar/button"/>
                    </td>                    
                </tr>  	  
              </table>
          </xsl:otherwise>
        </xsl:choose>
      </body>
    </html>
  </xsl:template>  


<!-- TEMPLATES --> <!-- TEMPLATES --> <!-- TEMPLATES --> <!-- TEMPLATES --> <!-- TEMPLATES -->      

<xsl:template match="LISTAPROCESOS">                         

    <!--
    	Mostramos la cabecera con los datos de la LISTA DE PRODUCTOS.
     +-->

    <table width="100%" border="0" cellspacing="0" cellpadding="0">
   	<tr>
   	  <td width="5%"><a href="javascript:resize()">&lt;-|-&gt;</a></td>
          <td><p class="tituloPag"><xsl:value-of select="LP_NOMBRE"/></p></td>
	  <td><p class="tituloCamp"><xsl:value-of select="LP_NUMERO"/></p></td>
	</tr><tr><td colspan="3">
<table width="100%" border="1" bordercolor="#A0D8D7" cellpadding="0" cellspacing="0"><tr><td><table width="100%" cellpadding="0" cellspacing="0" border="0">            
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
	      <xsl:value-of select="LP_FORMAPAGO"/>&nbsp;</td></tr>       
	  <tr>
	    <td>
	      <p class="tituloCamp"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='MO-0120' and @lang=$lang]" disable-output-escaping="yes"/>:</p></td>
	    <td colspan="3">
	      <xsl:value-of select="LP_CONDICIONESGENERALES"/>&nbsp;</td></tr>
       <!--
       |
       |        Incluimos todas las lineas de la multioferta
       |
       +-->
       </table></td></tr></table></td></tr></table>
     <br/>
    <table width="100%" align="center" border="1" cellspacing="0" cellpadding="0">
      <tr bgcolor="#CCCCCC" align="center">
        <td>
          <p class="tituloCamp"><xsl:value-of disable-output-escaping="yes" select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='CVA-0110' and @lang=$lang]"/></p></td>
        <td>
          <p class="tituloCamp"><xsl:value-of disable-output-escaping="yes" select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='CVA-0120' and @lang=$lang]"/></p></td>
        <td>
          <p class="tituloCamp"><xsl:value-of disable-output-escaping="yes" select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='CVA-0130' and @lang=$lang]"/></p></td>      
        <td>
          <p class="tituloCamp"><xsl:value-of disable-output-escaping="yes" select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='CVD-0020' and @lang=$lang]"/></p></td>   
        <td>
          <p class="tituloCamp"><xsl:value-of disable-output-escaping="yes" select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='CVD-0040' and @lang=$lang]"/></p></td>                            
      </tr>
      <tr><td colspan="5">&nbsp;</td></tr>
      <xsl:for-each select="MULTIOFERTAS/MULTIOFERTAS_ROW">
      <!--
       |   Si existe numero de Pedido lo mostramos.
       +-->
      
      <tr bgcolor="#A0D8D7">
        <td colspan="5">
          <xsl:choose>
            <xsl:when test="PED_NUMERO">Nº Pedido: <xsl:value-of select="PED_NUMERO"/></xsl:when> 
            <xsl:otherwise>Nº Oferta: <xsl:value-of select="MO_NUMERO"/></xsl:otherwise></xsl:choose></td></tr>
      <tr>
        <td><xsl:value-of select="PROVEEDOR"/>&nbsp;</td>
        <td><xsl:value-of select="VENDEDOR"/>&nbsp;</td>
        <td><p>        
          <xsl:choose>
          <xsl:when test="STATUS_COLOR[.='OPONENT_SIDE']">
                  <a>
                  <xsl:attribute name="href">http://www.newco.dev.br/Compras/Multioferta/Multioferta.xsql?MO_ID=<xsl:value-of select="MO_ID"/>&amp;US_ID=<xsl:value-of select="../../../US_ID"/>&amp;READ_ONLY=S</xsl:attribute>
                  <xsl:attribute name="onMouseOver">window.status='Ver oferta.';return true;</xsl:attribute>
	          <xsl:attribute name="onMouseOut">window.status='';return true;</xsl:attribute>
                  <xsl:attribute name="class">color:gray</xsl:attribute>
                  <xsl:value-of select="STATUS_DESC"/>  
                  </a>
          </xsl:when>
          <xsl:when test="STATUS_COLOR[.='DEAD_PROCESS']">
                  <a>
                  <xsl:attribute name="href">http://www.newco.dev.br/Compras/Multioferta/Multioferta.xsql?MO_ID=<xsl:value-of select="MO_ID"/>&amp;US_ID=<xsl:value-of select="../../../US_ID"/>&amp;READ_ONLY=S</xsl:attribute>
                  <xsl:attribute name="onMouseOver">window.status='Ver oferta.';return true;</xsl:attribute>
	          <xsl:attribute name="onMouseOut">window.status='';return true;</xsl:attribute>
                  <xsl:attribute name="class">color:black</xsl:attribute>
                   <xsl:value-of select="STATUS_DESC"/>  
                  </a>
          </xsl:when>          
          <xsl:when test="STATUS_COLOR[.='ACTION_REQUIRED']">
          	<b>
                  <a>
                  <xsl:attribute name="href">http://www.newco.dev.br/Compras/Multioferta/Multioferta.xsql?MO_ID=<xsl:value-of select="MO_ID"/>&amp;US_ID=<xsl:value-of select="../../../US_ID"/></xsl:attribute>
                  <xsl:attribute name="onMouseOver">window.status='Abrir oferta pendiente de acción.';return true;</xsl:attribute>
	          <xsl:attribute name="onMouseOut">window.status='';return true;</xsl:attribute>
                  <xsl:attribute name="class">color:blue</xsl:attribute>
                  <xsl:value-of select="STATUS_DESC"/>
                  </a>
                 </b>
          </xsl:when>
        </xsl:choose>
          </p></td>
          <td align="right">
            <xsl:if test="PED_IMPORTE_TOTAL">
              <xsl:value-of select="PED_IMPORTE_TOTAL"/>
            </xsl:if>
          </td>          
          <td align="right"><xsl:value-of select="MO_FECHA"/>&nbsp;</td></tr>
        <tr><td colspan="5"><br/></td></tr>
        </xsl:for-each>
        </table>
</xsl:template> 

</xsl:stylesheet>
