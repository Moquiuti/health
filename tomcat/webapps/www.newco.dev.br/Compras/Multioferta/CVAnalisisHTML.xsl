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
        <title><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='PL-0110' and @lang=$lang]" disable-output-escaping="yes"/></title>
	<xsl:text disable-output-escaping="yes"><![CDATA[
	<link rel="stylesheet" href="http://www.newco.dev.br/General/Estilos.css" type="text/css">
	<script type="text/javascript" src="http://www.newco.dev.br/General/general.js">
	</script>
	<SCRIPT type="text/javascript">
	<!--
	// Abre una ventana con url 'pag' y si ya hay abierta una cierra la anterior.
	
        var producto = null;	  
        /*
        function MostrarPag(pag){
          if (is_nav){
            ample=parseInt(window.outerWidth*80/100)-50;
            alcada=parseInt(window.innerHeight-23)-50;
            alt=parseInt(window.parent.innerHeight+18)-parseInt(window.innerHeight)+25;
            esquerra = parseInt(window.outerWidth*18/100)+25;
            if (producto && producto.open){
              producto.close();            
            }
            producto=window.open(pag,'Multioferta','toolbar=no,menubar=no,status=no,scrollbars=yes,resizable=yes,width='+ample+',height='+alcada+',screenX='+esquerra+',screenY='+alt);
          }else{
            ample = window.screen.availWidth-window.screenLeft-15-50;
            alcada = document.body.offsetHeight-27-50;
            esquerra = window.screenLeft+25;
            alt = window.screenTop+25;
            if (producto && producto.open && !producto.closed) producto.close();
	    producto=window.open(pag,'Multioferta','toolbar=no,menubar=no,status=no,scrollbars=yes,resizable=yes,width='+ample+',height='+alcada+',top='+alt+',left='+esquerra);
          }
        }
        */			
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
	    <form method="post" name="buttons">
	    <xsl:apply-templates select="//jumpTo"/><br/>
        <xsl:choose>
          <xsl:when test="Generar/LISTAPROCESOS/ESTADO=0"> 
            <p align="center" class="tituloPag"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='CVA-0100' and @lang=$lang]" disable-output-escaping="yes"/></p>
          </xsl:when>          
          <xsl:otherwise>
            <p align="center" class="tituloPag"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='CVA-0105' and @lang=$lang]" disable-output-escaping="yes"/></p>
          </xsl:otherwise>
        </xsl:choose>
	    <xsl:apply-templates select="Generar/LISTAPROCESOS"/>
	    <br/>
	    <xsl:apply-templates select="//jumpTo"/></form> 
          </xsl:otherwise>
        </xsl:choose>
      </body>
    </html>
  </xsl:template>  


<!-- TEMPLATES --> <!-- TEMPLATES --> <!-- TEMPLATES --> <!-- TEMPLATES --> <!-- TEMPLATES -->      

<xsl:template match="LISTAPROCESOS">
  <xsl:choose>
    <xsl:when test="Sorry"> 
      <tr><td colspan="5">    
        <xsl:apply-templates select="Sorry"/></td></tr></xsl:when>
    <xsl:otherwise>
    
  <table width="100%" cellpadding="0" cellspacing="0" border="0">
    <tr>
      <td colspan="5">
        <table width="100%" border="0" cellpadding="0" cellspacing="0">
          <tr bgcolor="#CCCCCC">
            <td colspan="2">
              <p class="tituloCamp"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='CVA-0170' and @lang=$lang]" disable-output-escaping="yes"/>
              </p>
            </td>	    	    
            <td>
              <p class="tituloCamp"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='CVA-0140' and @lang=$lang]" disable-output-escaping="yes"/>
              </p>
            </td>	    	    
            <td>
              <p class="tituloCamp"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='CVA-0150' and @lang=$lang]" disable-output-escaping="yes"/>
              </p>
            </td>	    	    
            <td align="right">
              <p class="tituloCamp"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='CVA-0160' and @lang=$lang]" disable-output-escaping="yes"/>
              </p>
            </td>
          <tr bgcolor="#CCCCCC">
            <td  colspan="2">
              <p><xsl:value-of disable-output-escaping="yes" select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='CVA-0110' and @lang=$lang]"/>
              </p>
            </td>
            <td>
              <p><xsl:value-of disable-output-escaping="yes" select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='CVA-0120' and @lang=$lang]"/>
              </p>
            </td>
            <td>
              <p><xsl:value-of disable-output-escaping="yes" select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='CVA-0130' and @lang=$lang]"/>
              </p>
            </td>      
            <td align="right">
              <p><xsl:value-of disable-output-escaping="yes" select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='CVD-0020' and @lang=$lang]"/>
              </p>
            </td>                                 
          </tr>
        </tr>
        <tr>
          <td colspan="5">&nbsp;
          </td>
        </tr>
        <xsl:for-each select="LISTAPROCESOS_ROW">
        <tr class="tituloCamp" bgcolor="#A0D8D7">
          <td  colspan="2"><a>
            <xsl:attribute name="href">javascript:MostrarPag('http://www.newco.dev.br/Compras/Multioferta/CVAnalisisDetalle.xsql?LP_ID=<xsl:value-of select="LP_ID"/>');</xsl:attribute>    
            <!--<xsl:attribute name="onMouseOver">window.status='<xsl:value-of select="LP_DESCRIPCION"/>';return true;</xsl:attribute>-->
            <!--<xsl:attribute name="onMouseOut">window.status='';return true;</xsl:attribute>-->
            <xsl:value-of select="LP_NOMBRE"/>                
            </a>&nbsp;
          </td>
          <td><xsl:value-of select="LP_FECHAEMISION"/>&nbsp;
          </td>                         
          <td><xsl:value-of select="LP_FECHADECISION"/>&nbsp;
          </td>                         
          <td align="right"><xsl:value-of select="LP_FECHAENTREGA"/>&nbsp;
          </td>                         
        </tr>
      <xsl:for-each select="MULTIOFERTAS/MULTIOFERTAS_ROW">
        <tr>
          <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
          <td>
            <a>
              <xsl:attribute name="href">http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPDetalleFrame.xsql?EMP_ID=<xsl:value-of select="IDPROVEEDOR"/></xsl:attribute>
              <xsl:attribute name="onMouseOver">window.status='Ver información de la empresa.';return true;</xsl:attribute>
	      <xsl:attribute name="onMouseOut">window.status='';return true;</xsl:attribute>
	      <xsl:attribute name="onClick">window.status='Abriendo información de la empresa';return true;</xsl:attribute>
              <xsl:value-of select="PROVEEDOR"/>
            </a>
          </td>
          <td><xsl:value-of select="VENDEDOR"/>&nbsp;
          </td>
          <td><p>        
            <xsl:choose>
            <xsl:when test="STATUS_COLOR[.='OPONENT_SIDE']">
                  <a>
                  <xsl:attribute name="href">javascript:MostrarPag('http://www.newco.dev.br/Compras/Multioferta/Multioferta.xsql?MO_ID=<xsl:value-of select="MO_ID"/>&amp;US_ID=<xsl:value-of select="../../../US_ID"/>&amp;READ_ONLY=S');</xsl:attribute>
                  <xsl:attribute name="onMouseOver">window.status='Ver oferta.';return true;</xsl:attribute>
	          <xsl:attribute name="onMouseOut">window.status='';return true;</xsl:attribute>
                  <xsl:attribute name="class">color:gray</xsl:attribute>
                  <xsl:value-of select="STATUS_DESC"/>  
                  </a>
            </xsl:when>
            <xsl:when test="STATUS_COLOR[.='DEAD_PROCESS']">
                  <a>
                  <xsl:attribute name="href">javascript:MostrarPag('http://www.newco.dev.br/Compras/Multioferta/Multioferta.xsql?MO_ID=<xsl:value-of select="MO_ID"/>&amp;US_ID=<xsl:value-of select="../../../US_ID"/>&amp;READ_ONLY=S');</xsl:attribute>
                  <xsl:attribute name="onMouseOver">window.status='Ver oferta.';return true;</xsl:attribute>
	          <xsl:attribute name="onMouseOut">window.status='';return true;</xsl:attribute>
                  <xsl:attribute name="class">color:black</xsl:attribute>
                   <xsl:value-of select="STATUS_DESC"/>  
                  </a>
            </xsl:when>          
            <xsl:when test="STATUS_COLOR[.='ACTION_REQUIRED']">
          	<b>
                  <a>
                  <xsl:attribute name="href">javascript:MostrarPag('http://www.newco.dev.br/Compras/Multioferta/Multioferta.xsql?MO_ID=<xsl:value-of select="MO_ID"/>&amp;US_ID=<xsl:value-of select="../../../US_ID"/>');</xsl:attribute>
                  <xsl:attribute name="onMouseOver">window.status='Abrir oferta pendiente de acción.';return true;</xsl:attribute>
	          <xsl:attribute name="onMouseOut">window.status='';return true;</xsl:attribute>
                  <xsl:attribute name="class">color:blue</xsl:attribute>
                  <xsl:value-of select="STATUS_DESC"/>
                  </a>
                 </b>
            </xsl:when>
           </xsl:choose>
           </p>
         </td>
         <td align="right">
            <xsl:if test="not(PED_IMPORTE_TOTAL[.='Pts'])">
              <xsl:value-of select="PED_IMPORTE_TOTAL"/>
            </xsl:if>
         </td>          
        </tr>
     </xsl:for-each>  
        <tr>
          <td colspan="4">&nbsp;
          </td>
        </tr>
      </xsl:for-each>
      </table>
    </td>
  </tr>
</table>
  </xsl:otherwise>
  </xsl:choose>
</xsl:template>


  <xsl:template match="Sorry">
    <p class="tituloCamp" align="center">
    <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='CVA-0180' and @lang=$lang]" disable-output-escaping="yes"/>
    </p>
  </xsl:template>
  
</xsl:stylesheet>
