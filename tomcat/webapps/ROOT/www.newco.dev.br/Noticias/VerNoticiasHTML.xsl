<?xml version="1.0" encoding="iso-8859-1" ?>
<!--
 |	Tablon de anuncios de MedicalVM
 |
 |	(c) 30/8/2001 ET
 |	
 +-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href = "http://www.newco.dev.br/General/General.xsl" />
  <xsl:import href = "http://www.newco.dev.br/Noticias/Noticias.xsl" />
  <xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
  <xsl:param name="lang" select="@lang"/>  
  <xsl:template match="/">
    <html>
      <head>
      	 <!--idioma-->
         <xsl:variable name="lang">
        <xsl:choose>
            <xsl:when test="/WorkFlowPendientes/LANG"><xsl:value-of select="/WorkFlowPendientes/LANG" /></xsl:when>
            <xsl:otherwise>spanish</xsl:otherwise>
            </xsl:choose>  
        </xsl:variable>
        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>      <!--idioma fin-->

	
	<title><xsl:value-of select="TITULO" disable-output-escaping="yes"/> <xsl:value-of select="document($doc)/translation/texts/item[@name='noticias']/node()"/></title>
    <!--style-->
      <xsl:call-template name="estiloIndip"/>
      <!--fin de style-->  

         <script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
	 <script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>
     
	<xsl:text disable-output-escaping="yes"><![CDATA[
	
        
       <script type="text/javascript">
	
	<!-- 
	
	/*function MostrarPag(pag,titulo){  
         
          //alert('local');
          if(titulo==null)
            titulo='MedicalVM';
            
           
          
          if (is_nav){
            ample=parseInt(window.outerWidth)-100-50;
            alcada=parseInt(window.innerHeight-23)-50;
            esquerra = parseInt(window.outerWidth*18/100)+25;
            alt=parseInt(window.parent.innerHeight+18)-parseInt(window.innerHeight)+25;            
            if (ventana && ventana.open){
              ventana.close();            
            }
            titulo=window.open(pag,titulo,'toolbar=no,menubar=no,status=no,scrollbars=yes,resizable=yes,width='+ample+',height='+alcada+',screenX='+esquerra+',screenY='+alt);
            titulo.focus();
          }else{
            
            ample = window.screen.availWidth-window.screenLeft-15-50;
            alcada = document.body.offsetHeight-27-50;
            esquerra = window.screenLeft+25;
            alt = window.screenTop+25;
            if (ventana &&  ventana.open && !ventana.closed){
            	 ventana.close();
            }
	    ventana=window.open(pag,titulo,'toolbar=no,menubar=no,status=no,scrollbars=yes,resizable=yes,width='+ample+',height='+alcada+',top='+alt+',left='+esquerra);
	    ventana.focus();
          }
        }*/	  	  	
 
        -->
        </script>
        
        
        ]]></xsl:text>
      </head>
      <body onLoad="">      
        <xsl:choose>
      	<!-- ET Desactivado control errores: Habra que reactivarlo -->
          <xsl:when test="Noticias/xsql-error">
            <xsl:apply-templates select="Noticias/xsql-error"/>          
          </xsl:when>
	
        <xsl:when test="Noticias/ROW/Sorry">
          <xsl:apply-templates select="Noticias/ROW/Sorry"/> 
        </xsl:when>
        <xsl:otherwise>
        <xsl:apply-templates select="Noticias/button"/>
        <xsl:value-of select="@TIPO"/>
	  <div class="tituloPag" align="center">Información sobre MedicalVM
	  <br/>
	  <xsl:choose>
	    <xsl:when test="Noticias/TIPO[.='Z']">
	      (<xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='WF-0300' and @lang=$lang]" disable-output-escaping="yes"/>)
	    </xsl:when>
	    <xsl:when test="Noticias/TIPO[.='N']">
	      (<xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='WF-0290' and @lang=$lang]" disable-output-escaping="yes"/>)
	    </xsl:when>
	    <xsl:when test="Noticias/TIPO[.='C']">
	      (<xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='WF-0310' and @lang=$lang]" disable-output-escaping="yes"/>)
	    </xsl:when>
	    <xsl:when test="Noticias/TIPO[.='P']">
	      (<xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='WF-0320' and @lang=$lang]" disable-output-escaping="yes"/>)
	    </xsl:when>
	    <xsl:otherwise>
	      (<xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='WF-0325' and @lang=$lang]" disable-output-escaping="yes"/>)
	    </xsl:otherwise>
	  </xsl:choose>
	  </div>
	  <br/>
	  <div align="center">
		El sistema de gestión de información sobre MedicalVM incluye noticias, consejos,
		preguntas frecuentes y publicidad.<br/>
		Para ver la información pulse sobre el título que le interese<br/><br/>
	  </div>
          <xsl:for-each select="Noticias/ROW">
            <!--<xsl:choose>
	    <xsl:when test="NOTICIAS">-->
            <table width="90%" border="1" align="center" cellspacing="0" cellpadding="0" >
	      <tr>
	        <td>
	        
        	  <table width="100%" border="0" align="center" cellspacing="0" cellpadding="0" >
                    <tr bgColor="#a0d8d7">
		      <td align="center" colspan="2">
		        <xsl:value-of select="NOMBRE"/>
		      </td>
		    </tr>
            <tr bgcolor="#EEFFFF"> 
		      <td colspan="2">
		        <br/>
		        <xsl:copy-of select="TITULO"/>
		       </td>
		     </tr>
          	 <xsl:for-each select="NOTICIAS/NOTICIAS_ROW">
			<!--	Titulos de las noticias, consejos, FAQs, etc.		-->
           		<tr bgColor="#EEFFFF">
				<td align="center" width="10%">
			  		<xsl:copy-of select="FECHAENTRADA"/>
				</td>
		       	<td align="left">
			 <a>
			   <xsl:attribute name="href">javascript:MostrarPag('http://www.newco.dev.br/Noticias/VerNoticia.xsql?ID=<xsl:value-of select='ID'/>','Noticia')</xsl:attribute>
			   <xsl:copy-of select="TITULO"/>
			 </a>
		       </td>
		     </tr>
		     </xsl:for-each>	    
                     <tr bgcolor="#EEFFFF"> 
		       <td>
		         <br/>
		         <xsl:copy-of select="TITULO"/>
			 </td>
		       </tr>
        	     </table> 
        	    
		   </td>
		 </tr>
	       </table>
	        <!--</xsl:when>
        	     <xsl:otherwise>
        	       &nbsp;
        	     </xsl:otherwise>
        	     </xsl:choose>-->
	       <br/>
	       </xsl:for-each>	    
               <br/><br/>
             </xsl:otherwise>
        </xsl:choose>
      </body>
    </html>
  </xsl:template>  
  
  

</xsl:stylesheet>
