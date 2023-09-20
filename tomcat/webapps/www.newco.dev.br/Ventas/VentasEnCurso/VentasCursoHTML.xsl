<?xml version="1.0" encoding="iso-8859-1" ?>
<!--
 |///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	Fichero: VentasCursoHTML.xsl
	Descripcion: Procesa tabla de ventas en curso
	Funcionamiento:
	
	Modificaciones:
	  Fecha:15/06/2001  Autor Modificacion: Olivier JEAN
	  Fecha:15/06/2001  Autor Modificacion: Olivier JEAN -> cambio de MultiofertaRO por Multioferta.xsql?READ_ONLY=S
	
	Situacion: __Normal__
	
	(c) 2001 MedicalVM
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  
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
        //-->  	
	</SCRIPT>        
        ]]></xsl:text>
      </head>
      <body bgcolor="#EEFFFF">      
        <xsl:choose>
          <xsl:when test="Generar/xsql-error"> 
          <p class="tituloForm">     
            <xsl:apply-templates select="Generar/xsql-error"/>
          </p>
          </xsl:when>          
          <xsl:otherwise>
          <table width="100%" border="0">	    
	    <tr>
	      <td>		  		  
		<xsl:apply-templates select="Generar/jumpTo"/>
              </td>                   
            </tr>  	  
          </table>
          <table width="100%" cellpadding="0" cellspacing="0" border="0">
	    <tr><td colspan="5" align="center">
        <xsl:choose>
          <xsl:when test="Generar/LISTAPROCESOS/ESTADO=0"> 
	      	<p class="tituloPag"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='VC-0000' and @lang=$lang]" disable-output-escaping="yes"/></p>
          </xsl:when>          
          <xsl:otherwise>
	      	<p class="tituloPag"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='VC-0005' and @lang=$lang]" disable-output-escaping="yes"/></p>
          </xsl:otherwise>
        </xsl:choose>
	      </td></tr>
	    <tr><td colspan="5">&nbsp;</td></tr>
	    <xsl:apply-templates select="Generar/LISTAPROCESOS"/>
	  </table>
	  <table width="100%" border="0" cellspacing="2" cellpadding="">	    
	    <tr>
	      <td>		  		  
		<xsl:apply-templates select="Generar/jumpTo"/>
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
  <xsl:choose>
    <xsl:when test="Sorry"> 
      <tr><td colspan="5" align="center">    
        <xsl:apply-templates select="Sorry"/></td></tr>
    </xsl:when>
    <xsl:otherwise>
      <tr bgcolor="#CCCCCC">
      <td align="left" width="20%"><p class="tituloCamp"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='VC-0100' and @lang=$lang]" disable-output-escaping="yes"/></p></td>
      <td align="left" width="13%"><p class="tituloCamp"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='VC-0110' and @lang=$lang]" disable-output-escaping="yes"/></p></td>
      <td align="left" width="13%"><p class="tituloCamp"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='VC-0120' and @lang=$lang]" disable-output-escaping="yes"/></p></td>      
      <td align="left" width="13%"><p class="tituloCamp"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='VC-0130' and @lang=$lang]" disable-output-escaping="yes"/></p></td>            
      <td align="left" width="41%"><p class="tituloCamp"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='VC-0030' and @lang=$lang]" disable-output-escaping="yes"/></p></td>
      </tr>
      <tr><td colspan="5">&nbsp;</td></tr>
      <xsl:for-each select="MULTIOFERTAS">               
      <tr>
        <td>
           <xsl:apply-templates select="EMP_NOMBRE"/>
        </td>
        <td>
          <a>
          <xsl:attribute name="href">javascript:MostrarPag('VentasCursoDetalle.xsql?MO_ID=<xsl:value-of select="MO_ID"/>');</xsl:attribute>                        
          <xsl:value-of select="MO_NUMERO"/>
          </a>
        </td>        
        <td><xsl:value-of select="MO_FECHA"/></td>        
        <td><xsl:value-of select="LP_FECHADECISION"/></td>                
        <td>
          <xsl:choose>
          <xsl:when test="STATUS_COLOR[.='OPONENT_SIDE']">
                  <a>
                  <xsl:attribute name="href">javascript:MostrarPag('http://www.newco.dev.br/Compras/Multioferta/Multioferta.xsql?MO_ID=<xsl:value-of select="MO_ID"/>&amp;US_ID=<xsl:value-of select="US_ID"/>&amp;READ_ONLY=S');</xsl:attribute>
                  <xsl:attribute name="onMouseOver">window.status='Ver oferta.';return true;</xsl:attribute>
	          <xsl:attribute name="onMouseOut">window.status='';return true;</xsl:attribute>
                  <!--<xsl:attribute name="class">color:grey</xsl:attribute>-->
                  <xsl:value-of select="STATUS_DESC"/>  
                  </a>
          </xsl:when>
          <xsl:when test="STATUS_COLOR[.='DEAD_PROCESS']">
                  
                  <a>
                  <xsl:attribute name="href">
                    <xsl:choose>
                      <xsl:when test="//ESTADO='0'"> <!-- C -->
                        javascript:MostrarPag('http://www.newco.dev.br/Compras/Multioferta/Multioferta.xsql?MO_ID=<xsl:value-of select="MO_ID"/>&amp;US_ID=<xsl:value-of select="US_ID"/>&amp;READ_ONLY=');
                      </xsl:when>  
                      <xsl:when test="//ESTADO='1'"> <!-- F -->
                        javascript:MostrarPag('http://www.newco.dev.br/Compras/Multioferta/Multioferta.xsql?MO_ID=<xsl:value-of select="MO_ID"/>&amp;US_ID=<xsl:value-of select="US_ID"/>&amp;READ_ONLY=S');
                      </xsl:when>  
                    </xsl:choose>
                  </xsl:attribute>
                        
                  <xsl:attribute name="onMouseOver">window.status='Ver oferta.';return true;</xsl:attribute>
	          <xsl:attribute name="onMouseOut">window.status='';return true;</xsl:attribute>
                  <!--<xsl:attribute name="class">color:black</xsl:attribute>-->
                   <xsl:value-of select="STATUS_DESC"/>  
                  </a>
          </xsl:when>
          
          <!-- en este estado, podemos modificar y seguir con el proceso -->         
          <xsl:when test="STATUS_COLOR[.='ACTION_REQUIRED']">
          	<b>
                  <a>
                  <xsl:attribute name="href">javascript:MostrarPag('http://www.newco.dev.br/Compras/Multioferta/Multioferta.xsql?MO_ID=<xsl:value-of select="MO_ID"/>&amp;US_ID=<xsl:value-of select="US_ID"/>');</xsl:attribute>
                  <xsl:attribute name="onMouseOver">window.status='Abrir oferta pendiente de acción.';return true;</xsl:attribute>
	          <xsl:attribute name="onMouseOut">window.status='';return true;</xsl:attribute>
                  <!--<xsl:attribute name="class">color:blue</xsl:attribute>-->
                  <xsl:value-of select="STATUS_DESC"/>
                  </a>
                 </b>
          </xsl:when>
        </xsl:choose>
        </td>
      </tr>
      <tr><td colspan="5"><hr/></td></tr>
      </xsl:for-each>            
    </xsl:otherwise>
  </xsl:choose>          
</xsl:template>

  <xsl:template match="Sorry">
    <p class="tituloCamp"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='VC-0140' and @lang=$lang]" disable-output-escaping="yes"/></p>
  </xsl:template>
  
  <xsl:template match="EMP_NOMBRE">
    <i><a>
    <xsl:attribute name="href">http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPDetalleFrame.xsql?EMP_ID=<xsl:value-of select="../EMP_ID"/></xsl:attribute>
    <xsl:attribute name="onMouseOver">window.status='Información sobre la empresa.';return true;</xsl:attribute>
    <xsl:attribute name="onMouseOut">window.status='';return true;</xsl:attribute>
    <xsl:value-of select="."/>
   </a></i>
  </xsl:template>
    
</xsl:stylesheet>
