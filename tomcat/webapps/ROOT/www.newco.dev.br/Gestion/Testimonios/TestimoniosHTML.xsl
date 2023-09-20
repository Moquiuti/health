<?xml version="1.0" encoding="iso-8859-1"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href="http://www.newco.dev.br/General/General.xsl" />
  <xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
  <xsl:param name="usuario" select="@US_ID"/>  
  <xsl:template match="/">
    <html>
      <head>   
         <!--idioma-->
        <xsl:variable name="lang">
        	<xsl:choose>
            <xsl:when test="/Testimonios/LANG != ''"><xsl:value-of select="/Testimonios/LANG" /></xsl:when>
            <xsl:when test="/Testimonios/LANGTESTI != ''"><xsl:value-of select="/Testimonios/LANGTESTI" /></xsl:when>
            <xsl:otherwise>spanish</xsl:otherwise>
            </xsl:choose>  
        </xsl:variable>
        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
         <!--fin idioma-->
       <title> 
        <xsl:value-of select="document($doc)/translation/texts/item[@name='central_compras_material_sanitario']/node()"/>&nbsp;-&nbsp;
        <xsl:value-of select="document($doc)/translation/texts/item[@name='testimonios']/node()"/>&nbsp;-&nbsp;
        <xsl:value-of select="document($doc)/translation/texts/item[@name='medicalvm']/node()"/>
      </title>
      
    <link rel="shortcut icon" href="http://www.newco.dev.br/images/MedicalVM.ico"/>
    
    
    <script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>
    <script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
    <script type="text/javascript" src="http://www.newco.dev.br/Gestion/Testimonios/testimonios11211.js"></script>
    
    <xsl:choose>
    <xsl:when test="/Testimonios/PARAM = 'PARTEPUBLICA'">
		<link rel="stylesheet" href="http://www.newco.dev.br/General/basicPublic.css" type="text/css"/>
                <script type="text/javascript" src="http://www.newco.dev.br/General/loginNew_190814.js"></script>
                <script type="text/javascript">
		
                function AceptaCookie(){
                        var aceptoCookie = GetCookie('ACEPTO_COOKIE');
                        if (aceptoCookie == '' || aceptoCookie == null) {
                                   //si no ha aceptado lo de los coockie pongo aviso
                                   document.getElementById("avisoCookieBox").style.display = 'block';
                           }
		}
            
	</script>
        <script>
(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
})(window,document,'script','//www.google-analytics.com/analytics.js','ga');

  ga('create', 'UA-64519488-3', 'auto');
  ga('send', 'pageview');

</script> 
    </xsl:when>
    <xsl:otherwise>
	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->
    </xsl:otherwise>
    </xsl:choose>
    
	
        <xsl:text disable-output-escaping="yes">
        </xsl:text>
        
      </head>
      <body>
          <xsl:attribute name="onload">
              <xsl:if test="/Testimonios/PARAM = 'PARTEPUBLICA'">MenuExplorerPublic(); AceptaCookie();</xsl:if>
          </xsl:attribute>
		
        <!--idioma-->
        <xsl:variable name="lang">
        	<xsl:choose>
            <xsl:when test="/Testimonios/LANG != ''"><xsl:value-of select="/Testimonios/LANG" /></xsl:when>
            <xsl:when test="/Testimonios/LANGTESTI != ''"><xsl:value-of select="/Testimonios/LANGTESTI" /></xsl:when>
            <xsl:otherwise>spanish</xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
         <!--fin idioma-->
		
        <xsl:choose>
			<!-- Error en alguna sentencia del XSQL -->
			<xsl:when test="Testimonios/xsql-error">
			<xsl:apply-templates select="Testimonios/xsql-error"/>        
			</xsl:when>
		<xsl:otherwise>
		<!--	/AreaPublica	-->
		<!--idioma-->
        <xsl:variable name="lang">
        	<xsl:choose>
            <xsl:when test="/Testimonios/LANG != ''"><xsl:value-of select="/Testimonios/LANG" /></xsl:when>
            <xsl:when test="/Testimonios/LANGTESTI != ''"><xsl:value-of select="/Testimonios/LANGTESTI" /></xsl:when>
            <xsl:otherwise>spanish</xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
         <!--fin idioma-->
    
    <div class="todo">
    <!--TEST SI USUARIO ESTA LOGADO O NO, si no esta logado enseño cabecera y menu-->
    <xsl:choose>
    <xsl:when test="/Testimonios/PARAM = 'PARTEPUBLICA'">
            <div class="avisoCookieBox" id="avisoCookieBox" style="display:none;">
            <div class='avisoCookie'>
                    <xsl:copy-of select="document($doc)/translation/texts/item[@name='aviso_cookies']/node()"/>
            </div>
            </div><!--fin de avisoCookieBox-->
            <div class="header">
            	<a href="http://www.newco.dev.br" title="Medical Virtual Market">
            		<img src="http://www.newco.dev.br/images/logoMVM.gif" alt="Medical Virtual Market"/>
                </a>
            </div><!--fin de header-->
            
            <xsl:call-template name="menuPublic"><!--en general.xsl-->
                <xsl:with-param name="select">testimonios</xsl:with-param>
            </xsl:call-template>
    </xsl:when>
  
    </xsl:choose>
    
    <div class="todoInside">
       
	<div class="zonaPublicaBox">
		<xsl:choose>
    	<xsl:when test="/Testimonios/PARAM = 'PARTEPUBLICA'">
            <!--<h1 class="titlePage">
                 <xsl:value-of select="document($doc)/translation/texts/item[@name='testimonios']/node()"/>
            </h1>
             link a testimonios y clientesMVM-->
             
             <!--<div class="divLeft30nopa">
                <div class="boton">
                    <strong>
                     <a href="http://www.newco.dev.br/MVMClientes.xsql" title="Clientes MVM">
                         <xsl:value-of select="document($doc)/translation/texts/item[@name='clientes']/node()"/>
                     </a> 	
                    </strong>
                </div> 
              </div>fin de divLeft30-->
               
                <!--<div class="divLeft40nopa"> 
                <form name="BuscaTesti" method="post" action="Testimonios.xsql?PARAM=PARTEPUBLICA&amp;TIPO=TODOS">
                  <table class="busca">
                   <tr>
                   <td class="buscaLeft">&nbsp;</td>
                   <td class="aster">  
                    <input type="text" name="BUSCA_TESTI" value="{Testimonios/LISTADOTESTIMONIOS/TESTIMONIOS/PALABRASCLAVE}"  />
                   </td>
                   	<td>
                        <a id="buscaTestimonios">
                        <img src="http://www.newco.dev.br/images/buttonBuscar.gif" alt="Boton Buscar" title="Buscar en MedicalVM" id="buscarPedido" style="vertical-align:middle; margin-bottom:10px;"/>
                        </a>
					</td>
                	<td class="buscaRight">&nbsp;</td>
					</tr>  
        			</table>
                    </form>
                </div>fin de divLeft40 buscador-->
                <xsl:if test="/Testimonios/TIPO = '5ALEATORIOS'">
                <div class="divLeft30nopa">
                  <div class="boton" style="float:left; margin-right:5px;">
                       <strong>
                     <a href="http://www.newco.dev.br/Gestion/Testimonios/Testimonios.xsql?PARAM=PARTEPUBLICA&amp;TIPO=TODOS" title="Testimonios de MVM">
                             <xsl:value-of select="document($doc)/translation/texts/item[@name='todos_testimonios']/node()"/>
                         </a> 
                       </strong>
                </div>
                <br /><br />
                </div> <!--fin de divLeft30-->
                </xsl:if>
                 <br /><br />    <!--<br /><br />  -->
        	</xsl:when>
            </xsl:choose>
        
        <!--formulario para nuevo testimonio para mvm y usuarios-->
        <xsl:choose>
         <xsl:when test="not(/Testimonios/PARAM = 'PARTEPUBLICA')">
         	<div class="divLeft">
         	<!--<div class="boton">
         		<a id="verEnviarTestimonio"><xsl:value-of select="document($doc)/translation/texts/item[@name='nuevo']/node()"/>
                </a>
            </div>fin de boton-->
            <div id="confirmTestimonio" style="display:none;"><span class="rojo">Enviado</span></div>
            </div><!--fin divLeft-->
            
        	<div class="divLeft gris" id="nuevoTestimonio" style="display:;">
            	<form name="testi" action="Testimonios.xsql" method="post">
                	<input type="hidden" name="US_ID">
                     <xsl:attribute name="value">
                        	<xsl:choose>
                            <xsl:when test="Testimonios/LISTADOTESTIMONIOS/GUARDARTESTIMONIO/OK">
                            	<xsl:value-of select="Testimonios/LISTADOTESTIMONIOS/GUARDARTESTIMONIO/USUARIOTESTIMONIO/US_ID"/>
                            </xsl:when>
                            <xsl:otherwise>
                            	<xsl:value-of select="Testimonios/LISTADOTESTIMONIOS/TESTIMONIOS/USUARIOTESTIMONIO/US_ID"/>
                            </xsl:otherwise>
                            </xsl:choose>
                        </xsl:attribute>
                         </input>
                     <input type="hidden" name="IDUSUARIOTESTIMONIO">
                      <xsl:attribute name="value">
                        	<xsl:choose>
                            <xsl:when test="Testimonios/LISTADOTESTIMONIOS/GUARDARTESTIMONIO/OK">
                            	<xsl:value-of select="Testimonios/LISTADOTESTIMONIOS/GUARDARTESTIMONIO/USUARIOTESTIMONIO/US_ID"/>
                            </xsl:when>
                            <xsl:otherwise>
                            	<xsl:value-of select="Testimonios/LISTADOTESTIMONIOS/TESTIMONIOS/USUARIOTESTIMONIO/US_ID"/>
                            </xsl:otherwise>
                            </xsl:choose>
                        </xsl:attribute>
                      </input>
                 <table class="infoTable" border="0">
                     <thead>
                          <tr class="titulosAzul">
                          <td colSpan="4"> <xsl:value-of select="document($doc)/translation/texts/item[@name='envianos_tu_testimonio']/node()"/></td>
                          </tr>
                      </thead>
                      <tr>
                      	<td class="dos">&nbsp;</td>
                      	<td class="labelRight cuarenta"><xsl:value-of select="document($doc)/translation/texts/item[@name='nombre']/node()"/>:</td>
                        <td class="datosLeft" colspan="2">
                        <input type="text" name="TES_NOMBRE" size="50"> 
                        <xsl:attribute name="value">
                        	<xsl:choose>
                            <xsl:when test="Testimonios/LISTADOTESTIMONIOS/GUARDARTESTIMONIO/OK">
                            	<xsl:value-of select="Testimonios/LISTADOTESTIMONIOS/GUARDARTESTIMONIO/USUARIOTESTIMONIO/USUARIO"/>
                            </xsl:when>
                            <xsl:otherwise>
                            	<xsl:value-of select="Testimonios/LISTADOTESTIMONIOS/TESTIMONIOS/USUARIOTESTIMONIO/USUARIO"/>
                            </xsl:otherwise>
                            </xsl:choose>
                        </xsl:attribute>
                         </input>
                        </td>
                      </tr>
                      <tr>
                      	<td class="dos">&nbsp;</td>
                      	<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='centro']/node()"/>:</td>
                        <td class="datosLeft" colspan="2"> <input type="text" name="TES_CENTRO" size="50">
                         <xsl:attribute name="value">
                        	<xsl:choose>
                            <xsl:when test="Testimonios/LISTADOTESTIMONIOS/GUARDARTESTIMONIO/OK">
                            	<xsl:value-of select="Testimonios/LISTADOTESTIMONIOS/GUARDARTESTIMONIO/USUARIOTESTIMONIO/CENTRO"/>
                            </xsl:when>
                            <xsl:otherwise>
                            	<xsl:value-of select="Testimonios/LISTADOTESTIMONIOS/TESTIMONIOS/USUARIOTESTIMONIO/CENTRO"/>
                            </xsl:otherwise>
                            </xsl:choose>
                        </xsl:attribute>
                         </input>
                        </td>
                      </tr>
                      <tr>
                      	<td class="dos">&nbsp;</td>
                      	<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='cargo']/node()"/>:</td>
                        <td class="datosLeft" colspan="2"> <input type="text" name="TES_CARGO" size="50">
                         <xsl:attribute name="value">
                        	<xsl:choose>
                            <xsl:when test="Testimonios/LISTADOTESTIMONIOS/GUARDARTESTIMONIO/OK">
                            	<xsl:value-of select="Testimonios/LISTADOTESTIMONIOS/GUARDARTESTIMONIO/USUARIOTESTIMONIO/CARGO"/>
                            </xsl:when>
                            <xsl:otherwise>
                            	<xsl:value-of select="Testimonios/LISTADOTESTIMONIOS/TESTIMONIOS/USUARIOTESTIMONIO/CARGO"/>
                            </xsl:otherwise>
                            </xsl:choose>
                        </xsl:attribute>
                         </input>
                        </td>
                      </tr>
                    
                      <tr><td colspan="4">&nbsp;</td></tr>
                       <tr>
                       	 <td colspan="2">&nbsp;</td>
                      	 <td colspan="2" class="datosLeft"><xsl:copy-of select="document($doc)/translation/texts/item[@name='testimonios_text']/node()"/></td>
                      </tr>
                      <tr><td colspan="4">&nbsp;</td></tr>
                        <tr>
                      	<td class="dos">&nbsp;</td>
                      	<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='titulo']/node()"/>:</td>
                        <td class="datosLeft" colspan="2"> <input type="text" name="TES_PALABRAS" value="{Testimonios/TESTIMONIO/PALABRASCLAVE}" size="50"/></td>
                      </tr>
                        <tr>
                      	<td class="dos">&nbsp;</td>
                      	<td class="labelRight" valign="top"><xsl:value-of select="document($doc)/translation/texts/item[@name='mensaje']/node()"/>:</td>
                      	<td class="datosLeft" colspan="2"><textarea name="TES_TEXTO" rows="6" cols="50"></textarea></td>
                      </tr>
                      
                      <xsl:choose>
                      <xsl:when test="Testimonios/LISTADOTESTIMONIOS/TESTIMONIOS/USUARIOCONECTADO/MVM or Testimonios/LISTADOTESTIMONIOS/TESTIMONIOS/USUARIOCONECTADO/MVMB">      
                      
                      <tr>
                      	<td class="dos">&nbsp;</td>
                      	<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='importancia']/node()"/>:</td>
                        <td class="datosLeft" colspan="2">
                       		<xsl:call-template name="desplegable">
        						<xsl:with-param name="path" select="/Testimonios/LISTADOTESTIMONIOS/TESTIMONIOS/IMPORTANCIA/field">
        						</xsl:with-param>
      						</xsl:call-template>		
                            <!-- <input type="text" name="TES_IMPORTANCIA" value="{Testimonios/TESTIMONIO/IMPORTANCIA}" size="50"/>--></td>
                      </tr>
                        <tr>
                      	<td class="dos">&nbsp;</td>
                      	<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='estado']/node()"/>:</td>
                        <td class="datosLeft" colspan="2"> 
                            <select name="TES_ESTADO">
                                <option value="P">
                                <xsl:value-of select="document($doc)/translation/texts/item[@name='pendiente']/node()"/>
                                </option>
                                <option value="">
                                <xsl:value-of select="document($doc)/translation/texts/item[@name='activo']/node()"/>
                                </option>
                                <option value="B">
                                 <xsl:value-of select="document($doc)/translation/texts/item[@name='borrado']/node()"/>
                                </option>
                            </select>
               			</td>
                      </tr>
                       <tr><td colspan="4">&nbsp;</td></tr>
                       </xsl:when>
                       <xsl:otherwise>
                        <input type="hidden" name="TES_ESTADO" value="P"/>
                       </xsl:otherwise>
                       </xsl:choose>
                	  <tr>
                        <td colspan="2">&nbsp;</td>
                        <td colspan="2">
                                <div class="boton">
                                  <strong><a href="javascript:EnviaTestimonio(document.forms['testi']);"> <xsl:value-of select="document($doc)/translation/texts/item[@name='enviar']/node()"/></a></strong>
                                </div>
                        
                                <div class="boton" style="margin-left:50px;">
                      		  <strong><a href="window.close();"><xsl:value-of select="document($doc)/translation/texts/item[@name='cancelar']/node()"/></a></strong>
                  		</div>
                      </td>
                      </tr>
                      <tr><td colspan="4">&nbsp;</td></tr>
                      <tr>
                      	<td colspan="2">&nbsp;</td>
                      	<td class="datosLeft">
                      	<a href="http://www.newco.dev.br/Contacto.xsql" title="Contactar"><xsl:value-of select="document($doc)/translation/texts/item[@name='contactar_con_mvm']/node()"/>	</a>
                        </td>
                      	<td>&nbsp;</td>
                      </tr>
                   </table>
                    
            	</form>
            </div><!--fin de nuevoTestimonio divLeft-->
            <br /><br />
            <div class="divleft">
                <div class="divCenter50">
              <xsl:for-each select="Testimonios/LISTADOTESTIMONIOS/TESTIMONIOS/TESTIMONIO">
              
               
          		<div class="oneTestimonio">
                	<xsl:attribute name="style">
                    	<xsl:choose>
                        <xsl:when test="ROL = 'VENDEDOR'">background:#b0c2e5;</xsl:when><!--proveedor gris-->
                        <xsl:when test="ROL = 'COMPRADOR'">background:#c3d2e9;</xsl:when><!--cliente-->
                        <xsl:otherwise>background:#f2f2f2;</xsl:otherwise>
                        </xsl:choose>
                    </xsl:attribute>
                    
                    	<div class="contentTestimonio">
                          <div class="textTestimonio">
                            <p><strong><xsl:value-of select="PALABRASCLAVE"/></strong><br />
                        	<xsl:copy-of select="TEXTO"/></p>
                          </div><!--fin de textTestimonio-->
                        </div>
                         
                    	<p class="quienTestimonio">
                        <xsl:value-of select="FECHA"/>
                        <br />
                        <xsl:value-of select="USUARIO"/>&nbsp;(<xsl:value-of select="POBLACION"/>)<br />
                        <xsl:value-of select="CARGO"/>&nbsp;<a href="{ENLACE}" target="_blank"><xsl:value-of select="CENTRO"/></a>
                        </p>
                 	
                 </div><!--fin de onetestimonios-->
          </xsl:for-each>
                </div>
            </div><!--fin de divleft-->
        </xsl:when> 
        <xsl:otherwise>
        
         <!-- todos testimonios-->
          <!--paginacion parte publica-->  
          <form name="pageTesti" action="Testimonios.xsql?PARAM=PARTEPUBLICA&amp;TIPO=TODOS" method="post">
                <input type="hidden" name="PAG"/>
           <xsl:choose>
    		<xsl:when test="/Testimonios/TIPO = '5ALEATORIOS'">
            </xsl:when>
            <xsl:otherwise>
               
               <div class="divLeft"> 
               <div class="divLeft50nopa">
                   <xsl:if test="Testimonios/LISTADOTESTIMONIOS/TESTIMONIOS/ANTERIOR">
                     <img src="http://www.newco.dev.br/images/anterior.gif"/>&nbsp;<a href="javascript:navegaTesti(document.forms['pageTesti'],{Testimonios/LISTADOTESTIMONIOS/TESTIMONIOS/PAGINA},'anterior');"><xsl:value-of select="document($doc)/translation/texts/item[@name='anterior']/node()"/></a>
                  </xsl:if>&nbsp;
              </div> <!--fin de divLeft50-->
               <div class="divLeft50nopa">
                  <xsl:if test="Testimonios/LISTADOTESTIMONIOS/TESTIMONIOS/SIGUIENTE">
                     <p style="text-align:right"><a href="javascript:navegaTesti(document.forms['pageTesti'],{Testimonios/LISTADOTESTIMONIOS/TESTIMONIOS/PAGINA},'siguiente');"><xsl:value-of select="document($doc)/translation/texts/item[@name='siguiente']/node()"/>
                     </a>&nbsp;<img src="http://www.newco.dev.br/images/siguiente.gif"/></p>
                  </xsl:if>
              </div> <!--fin de divLeft50-->
              </div><!--fin de divLeft-->
             <br /><br />
            </xsl:otherwise>
           </xsl:choose>
          <!--fin paginacion parte publica-->
           
          <xsl:for-each select="Testimonios/LISTADOTESTIMONIOS/TESTIMONIOS/TESTIMONIO">
          			<div class="oneTestimonio">
                	<xsl:attribute name="style">
                    	<xsl:choose>
                      <xsl:when test="ROL = 'VENDEDOR'">background:#b0c2e5;</xsl:when><!--proveedor gris-->
                        <xsl:when test="ROL = 'COMPRADOR'">background:#c3d2e9;</xsl:when><!--cliente-->
                        <xsl:otherwise>background:#f2f2f2;</xsl:otherwise>
                        </xsl:choose>
                    </xsl:attribute>
                	
                    	<div class="contentTestimonio">
                            <div class="textTestimonio">
                                <p class="strongNegro"><xsl:value-of select="PALABRASCLAVE"/></p>
                                <p><xsl:copy-of select="TEXTO"/></p>
                            </div>
                        </div>
                        
                    	<p class="quienTestimonio">
                        <xsl:value-of select="FECHA"/>,&nbsp;
                        <xsl:value-of select="USUARIO"/>,&nbsp;<xsl:value-of select="CARGO"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='en']/node()"/>&nbsp;<a href="{ENLACE}" target="_blank"><xsl:value-of select="CENTRO"/></a>
                        </p>
                    
                 </div><!--fin de onetestimonios-->
          </xsl:for-each>
           <!--paginacion parte publica--> 
           <xsl:choose>
    		<xsl:when test="/Testimonios/TIPO = '5ALEATORIOS'">
            </xsl:when>
            <xsl:otherwise>
                             
               <div class="divLeft"> 
               <div class="divLeft50nopa">
                   <xsl:if test="Testimonios/LISTADOTESTIMONIOS/TESTIMONIOS/ANTERIOR">
                     <img src="http://www.newco.dev.br/images/anterior.gif"/>&nbsp;<a href="javascript:navegaTesti(document.forms['pageTesti'],{Testimonios/LISTADOTESTIMONIOS/TESTIMONIOS/PAGINA},'anterior');"><xsl:value-of select="document($doc)/translation/texts/item[@name='anterior']/node()"/></a>
                  </xsl:if>&nbsp;
              </div> <!--fin de divLeft50-->
               <div class="divLeft50nopa">
                  <xsl:if test="Testimonios/LISTADOTESTIMONIOS/TESTIMONIOS/SIGUIENTE">
                     <p style="text-align:right"><a href="javascript:navegaTesti(document.forms['pageTesti'],{Testimonios/LISTADOTESTIMONIOS/TESTIMONIOS/PAGINA},'siguiente');"><xsl:value-of select="document($doc)/translation/texts/item[@name='siguiente']/node()"/>
                     </a>&nbsp;<img src="http://www.newco.dev.br/images/siguiente.gif"/></p>
                  </xsl:if>
              </div> <!--fin de divLeft50-->
              </div><!--fin de divLeft-->
             <br /><br />
            </xsl:otherwise>
           </xsl:choose>
          <!--fin paginacion parte publica-->
             </form>
        </xsl:otherwise>
        </xsl:choose>
		
      
	 

    </div><!--fin de zonaPublicaBox-->
    </div><!--fin de todoInside-->
    </div><!--fin de todo-->
    <br /><br />

        </xsl:otherwise>
      </xsl:choose>
      <br/>    
    </body>
  </html>
</xsl:template>

  <xsl:template match="Sorry">
    <xsl:apply-templates select="Testimonios/ROW/Sorry"/>
  </xsl:template>
</xsl:stylesheet>