<?xml version="1.0" encoding="iso-8859-1" ?>
<!--
 | ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
 |
 | Fichero.......: 
 | Autor.........:
 | Fecha.........:
 | Descripcion...: 
 | Funcionamiento: 
 |
 |Modificaciones:
 |   Fecha       Autor          Modificacion
 |
 |
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
            <p align="center" class="tituloPag"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='CVA-0100' and @lang=$lang]" disable-output-escaping="yes"/></p>
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
  <table width="100%" cellpadding="0" cellspacing="0">
    <tr><td colspan="4">&nbsp;</td></tr>
    <tr><td colspan="4"><table width="100%" border="0" cellpadding="0" cellspacing="0">
    <tr bgcolor="#CCCCCC">
      <td>
        <p class="tituloCamp"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='CVA-0170' and @lang=$lang]" disable-output-escaping="yes"/></p></td>	    	    
      <td>
        <p class="tituloCamp"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='CVA-0140' and @lang=$lang]" disable-output-escaping="yes"/></p></td>	    	    
      <td>
        <p class="tituloCamp"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='CVA-0150' and @lang=$lang]" disable-output-escaping="yes"/></p></td>	    	    
      <td>
        <p class="tituloCamp"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='CVA-0160' and @lang=$lang]" disable-output-escaping="yes"/></p></td>	    	    

    </tr>
    <tr><td colspan="4">&nbsp;</td></tr>
    <xsl:for-each select="LISTAPROCESOS_ROW">
      <tr>
        <td><a>
          <xsl:attribute name="href">javascript:MostrarPag('CVAnalisisDetalle.xsql?LP_ID=<xsl:value-of select="LP_ID"/>');</xsl:attribute>    
          <!--<xsl:attribute name="onMouseOver">window.status='<xsl:value-of select="LP_DESCRIPCION"/>';return true;</xsl:attribute>-->
          <!--<xsl:attribute name="onMouseOut">window.status='';return true;</xsl:attribute>-->
          <xsl:value-of select="LP_NOMBRE"/>                
        </a>&nbsp;</td>
        <td><xsl:value-of select="LP_FECHAEMISION"/>&nbsp;</td>                         
        <td><xsl:value-of select="LP_FECHADECISION"/>&nbsp;</td>                         
        <td><xsl:value-of select="LP_FECHAENTREGA"/>&nbsp;</td>                         
      </tr>
      <tr><td colspan="4"><hr/></td></tr>
    </xsl:for-each>
  </table></td></tr></table>
  </xsl:otherwise>
  </xsl:choose>
</xsl:template>


  <xsl:template match="Sorry">
    <p class="tituloCamp" align="center"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='WF-0000' and @lang=$lang]" disable-output-escaping="yes"/></p>
  </xsl:template>
  
</xsl:stylesheet>
