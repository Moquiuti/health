<?xml version="1.0" encoding="iso-8859-1" ?>
<!--
 	Tablon de anuncios de MedicalVM
 
 	(c) 30/8/2001 ET  
 				
	Revisiones:
	7/4/2003	Cambios en diseño, incluimos en zona publica
 	
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href = "http://www.newco.dev.br/General/General.xsl" />
  <xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
  <xsl:param name="lang" select="@lang"/>  
  <xsl:template match="/">
    <html>
      <head>
		<title>Tablón de Anuncios de MedicalVM</title>
		<xsl:text disable-output-escaping="yes"><![CDATA[
		<link rel="stylesheet" href="http://www.newco.dev.br/General/Estilos.css" type="text/css">
        	]]></xsl:text>
		<xsl:text disable-output-escaping="yes"><![CDATA[
		<script type="text/javascript" src="http://www.newco.dev.br/General/general.js">
		</script>
		<script type="text/javascript">
          <!--
            function AbrirVentanaConPulsacion(pag,titulo){  
       
         
          if(titulo==null)
            var titulo='defecto';
            
          
          if (is_nav){
            if(top.name=='newMain'){
              ample = top.screen.availWidth-100;
              alcada = top.screen.availHeight-100;
            
              esquerra = (top.screen.availWidth-ample) / 2;
              alt = (top.screen.availHeight-alcada) / 2;
            }else{
              var anchoVentanaPadre;
              var altoVentanaPadre;
              
              anchoVentanaPadre=obtenerAnchoVentanaPadre(window);
              altoVentanaPadre=obtenerAltoVentanaPadre(window);
              
              ample = anchoVentanaPadre-50;
              alcada = altoVentanaPadre-50;
              
            
              esquerra = (parent.screen.availWidth-ample) / 2;
              alt = (parent.screen.availHeight-alcada) / 2;
            }
            
            if (ventana && ventana.open){
              ventana.close();            
            }
            titulo=window.open('http://www.newco.dev.br/Empresas/PulsacionesBanners.xsql?LA_URL='+pag+'&EL_BANNER='+titulo,titulo);
            titulo.focus();
          }else{
            if(top.name=='newMain' ||top.name=='mainMVM'){
              ample = top.screen.availWidth-100;
              alcada = top.screen.availHeight-100;
            
              esquerra = (top.screen.availWidth-ample) / 2;
              alt = (top.screen.availHeight-alcada) / 2;
            }else{
              var anchoVentanaPadre;
              var altoVentanaPadre;
              anchoVentanaPadre=obtenerAnchoVentanaPadre(window);
              altoVentanaPadre=obtenerAltoVentanaPadre(window);
              
              ample = anchoVentanaPadre-50;
              alcada = altoVentanaPadre-50;
              
            
              esquerra = (parent.screen.availWidth-ample) / 2;
              alt = (parent.screen.availHeight-alcada) / 2;
            }
            if (ventana &&  ventana.open && !ventana.closed){
            	 ventana.close();
            }
	    titulo=window.open('http://www.newco.dev.br/Empresas/PulsacionesBanners.xsql?LA_URL='+pag+'&EL_BANNER='+titulo,titulo);
	    titulo.focus();
          }
        }
          //-->
         </script>
        	]]></xsl:text>
      </head>
      <body bgcolor="#FFFFFF" text="#000000" link="#333366" vlink="#333366" alink="#3399ff">  
      
      
      
          
		<!-- 
			Almacena en una variable si se tiene que bloquear los enlaces 
			(necesario en la zona publica para que no puedan ver contenidos) o no
		 -->
		<xsl:variable name="Bloquear">
			<xsl:value-of select="/TablonAnuncios/BloquearEnlaces"/>
		</xsl:variable>		
		<xsl:variable name="TipoAnuncio">
			<xsl:value-of select="/TablonAnuncios/ANUNCIOS/TIPO"/>
		</xsl:variable>		
      	<!-- ET Desactivado control errores: Habra que reactivarlo -->
        <xsl:choose>
          <xsl:when test="TablonAnuncios/xsql-error">
            <xsl:apply-templates select="TablonAnuncios/xsql-error"/>          
          </xsl:when>
	
        <xsl:when test="TablonAnuncios/ROW/Sorry">
          <xsl:apply-templates select="TablonAnuncios/ROW/Sorry"/> 
        </xsl:when>
        <xsl:otherwise>
 		
 		<table width="100%" border="0" class="blanco" align="center" cellspacing="0" cellpadding="5">
 		  <tr>
 		    <td>
		      <xsl:choose> 
			      <xsl:when test="$TipoAnuncio=0 or $TipoAnuncio=1">
			        <br/>
			        <p class="TituloPag" align="center">
			          Tablón de Anuncios de MedicalVM
			        </p>	
			      </xsl:when>
			      <xsl:when test="$TipoAnuncio=3">				
			      	<p class="tituloPag" align="center">
			      	Foro Público para Compradores	
			      	</p>
			      </xsl:when> 
			      <xsl:when test="$TipoAnuncio=4">				
			      	<p class="tituloPag" align="center">
			      	Foro Privado	
			      	</p>
			      </xsl:when> 
			      <xsl:otherwise>
			      	<p class="tituloPag" align="center">
			      	Tablón de Anuncios - Varios
			      	</p>
			      </xsl:otherwise> 
		      </xsl:choose>
		      <br/>
		      <br/>
			  </td>
			  <td rowspan="3" width="13%">
			    <table width="100%" border="0" align="center" cellspacing="1" cellpadding="1">
        	    <tr align="center">
        	      <td  class="textoDivisaPeq">

        	        <a border="0" href="javascript:AbrirVentanaConPulsacion('http://www.doctoralia.com','doctoralia');"  onMouseOver="window.status='http://www.doctoralia.com';return true;" onMouseOut="window.status='';return true;">
			              <img border="0" src="http://www.newco.dev.br/images/Banner/BannerDoctoralia.gif"/>
		              </a>
		              <br/>
		              <br/>
        	        <!--<a border="0" href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPDetalleFrame.xsql?EMP_ID=1478&amp;VENTANA=NUEVA','empresa',65,58,0,-50);"   onMouseOver="window.status='Información sobre la empresa';return true;" onMouseOut="window.status='';return true;">
        	        <img border="0" src="http://www.newco.dev.br/files/Empresas/TextilVisontium/BannerTextilVisontium_peq.gif"/>
        	        <br/>
        	        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='PUB-0060' and @lang=$lang]" disable-output-escaping="yes"/>  
        	        <br/>
        	        <br/>
        	        </a>-->
        	      </td>
        	    </tr>
        	    <tr align="center">
        	      <td  class="textoDivisaPeq">
        	        <a border="0" href="javascript:AbrirVentanaConPulsacion('http://www.torval.es/flashini.htm','torval');" onMouseOver="window.status='http://www.torval.es';return true;" onMouseOut="window.status='';return true;">
        	        <img border="0" src="http://www.newco.dev.br/files/Empresas/Torval/BannerTorval_peq.gif"/>
        	        <br/>
        	        <br/>
        	        </a>
        	      </td>
        	    </tr>
        	    <tr align="center">
        	      <td  class="textoDivisaPeq">
        	        <a border="0" href="javascript:AbrirVentanaConPulsacion('http://www.izasa.es/home.asp','izasa');"  onMouseOver="window.status='http://www.izasa.es';return true;" onMouseOut="window.status='';return true;">
        	        <img border="0" src="http://www.newco.dev.br/files/Empresas/Izasa/BannerIzasa_peq.gif"/>
        	        <br/>
        	        <br/>
        	        </a>
        	      </td>
        	    </tr>
        	    <tr align="center">
        	      <td  class="textoDivisaPeq">
        	        <a border="0" href="javascript:AbrirVentanaConPulsacion('http://www.iberhospitex.com/iht_es.htm','iht');" onMouseOver="window.status='http://www.iberhospitex.com';return true;" onMouseOut="window.status='';return true;">
        	        <img border="0" src="http://www.newco.dev.br/files/Empresas/Iberhospitex/BannerIht_peq.gif"/>
        	        <br/>
        	        <br/>
        	        </a>
        	      </td>
        	    </tr>
        	    <tr align="center">
        	      <td  class="textoDivisaPeq">
        	        <a border="0" href="javascript:AbrirVentanaConPulsacion('http://www.hartmann-online.com/espanol/bienvenidos/index.htm','hartmann');" onMouseOver="window.status='http://www.hartmann-online.com';return true;" onMouseOut="window.status='';return true;">
        	        <img border="0" src="http://www.newco.dev.br/files/Empresas/Hartmann/BannerHartmann_peq.gif"/>
        	        <br/>
        	        <br/>
        	        </a>
        	      </td>
        	    </tr>
        	    <tr align="center">
        	      <td  class="textoDivisaPeq">
        	        <a border="0" href="javascript:AbrirVentanaConPulsacion('http://www.indas.es','indas');" onMouseOver="window.status='www.indas.es';return true;" onMouseOut="window.status='';return true;">
        	        <img border="0" src="http://www.newco.dev.br/files/Empresas/Indas/BannerIndas_peq.gif"/>
        	        <br/>
        	        <br/>
        	        </a>
        	      </td>
        	    </tr>
        	  </table>
			  </td>
	    </tr>
	    <tr>
        <td>
          <xsl:choose> 
			      <xsl:when test="$TipoAnuncio=0 or $TipoAnuncio=1">
			        
			        <br/>
			        <br/>		
 			        <table width="85%" border="0" align="center" cellspacing="0" cellpadding="0" class="blanco">
			          <tr>
			            <td>
			              <xsl:call-template name="ArrayPestanyas">
			                <xsl:with-param name="path" select="//TablonAnuncios/PESTANYAS[@name='anuncios']"/>
			                <xsl:with-param name="seleccionada" select="//TablonAnuncios/PESTANYASELECCIONADA"/>
			              </xsl:call-template>
			            </td>
			          </tr>
			        </table>
			      </xsl:when>
			    </xsl:choose> 
          <table width="85%" border="0" align="center" cellspacing="1" cellpadding="1" class="oscuro">
		        <tr class="blanco">
		          <td>
			          <!--	Cuerpo de la tabla	-->
                <table width="100%" border="0" align="center" cellspacing="0" cellpadding="0" class="oscuro">
                  <tr class="oscuro">
			              <td width="10%" align="center">Entrada</td>
			              <td width="10%" align="center">Respuesta</td>
			              <td width="10%" align="center">Provincia</td>
			              <td width="20%" align="center">Categoria</td>
			              <td width="50%" align="center">Título</td>
			            </tr>
                  <xsl:for-each select="TablonAnuncios/ANUNCIOS/ANUNCIO">
                    <tr class="blanco">
			                <td align="center">
			                  <p>
			                	  <xsl:value-of select="ENTRADA"/>
			                	</p>
			                </td>
			                <xsl:variable name="Respuestas">
			                	<xsl:value-of select="RESPUESTAS/NUMERORESPUESTAS"/>
			                </xsl:variable>		
			                <td align="center">
			                	<xsl:choose> 
			                		<xsl:when test="$Respuestas>0">			
			                		  <p>		
			                			  <xsl:value-of select="RESPUESTAS/ULTIMARESPUESTA"/>
			                			</p>
			                		</xsl:when> 
			                		<xsl:otherwise> 
			                		  <p>
			                			  &nbsp;
			                			</p>
			                		</xsl:otherwise> 
			                	</xsl:choose> 
			                </td>
			                <td align="center">
			                  <p>
			                 	  <xsl:value-of select="PROVINCIA"/>
			                	</p>
			                </td>
			                <td align="center">
			                  <p>
			                	  <xsl:value-of select="CATEGORIA"/>
			                	</p>
			                </td>
			                <td align="left" colspan="2">	<!-- colspan="3"	-->
			                  <p>
			                    <a onMouseOver="window.status='Ver Anuncio';return true;" onMouseOut="window.status='';return true;">
			                      <xsl:attribute name="href">javascript:MostrarPag('./VerRespuestasAnuncio.xsql?IDAnuncio=<xsl:value-of select="ID"/>','RespuestasAnuncio')</xsl:attribute>
			                      <xsl:value-of select="TITULO"/>
			                    </a>
			                  </p>
			                </td>
			              </tr>
			              <tr>
			                <td height="1" colspan="7" bgcolor="#d0f8f7"></td>
			              </tr>
		              </xsl:for-each>	   
                </table> 
			              <!--	boton de nuevo anuncio	-->
			          <br/>
 			          <table border="0" align="center">
			            <tr>
			              <td>
			          	    <xsl:call-template name="botonPersonalizado">
	                      <xsl:with-param name="funcion">MostrarPag('./NuevoAnuncio.xsql?TIPO=<xsl:value-of select="$TipoAnuncio"/>','NuevoAnuncio');</xsl:with-param>
	                      <xsl:with-param name="label">Nuevo anuncio</xsl:with-param>
	                      <xsl:with-param name="status">Insertar nueva consulta</xsl:with-param>
	                      <xsl:with-param name="ancho">120px</xsl:with-param>
	                    </xsl:call-template> 
			              </td>
			            </tr>
			          </table>
			        </td>
			      </tr>
			    </table>
        </td>
      </tr>
      <tr>
      <td>
        <br/>
		    <br/>
		    <br/>
		    <br/>
      </td>
      </tr>
    </table> 
  </xsl:otherwise>
</xsl:choose>
</body>
</html>
</xsl:template>  

</xsl:stylesheet>
