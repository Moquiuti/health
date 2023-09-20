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
        	<xsl:value-of select="/Testimonios/LANG" />
        </xsl:variable>
        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
         <!--fin idioma-->
       <title>
        <xsl:value-of select="document($doc)/translation/texts/item[@name='central_compras_material_sanitario']/node()"/>&nbsp;-&nbsp;
        <xsl:value-of select="document($doc)/translation/texts/item[@name='testimonios']/node()"/>&nbsp;-&nbsp;
        <xsl:value-of select="document($doc)/translation/texts/item[@name='medicalvm']/node()"/>
      </title>

	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->

	<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>
    <script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
    <script type="text/javascript" src="http://www.newco.dev.br/Gestion/Testimonios/testimonios11211.js"></script>
    
        <xsl:text disable-output-escaping="yes">
        </xsl:text>
        
      </head>
      <body>	
		
        <!--idioma-->
        <xsl:variable name="lang">
        	<xsl:value-of select="/Testimonios/LANG" />
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
        	<xsl:value-of select="/Testimonios/LANG" />
        </xsl:variable>
        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
         <!--fin idioma-->
    
          <div class="zonaPublicaBox">
         <!--mantenimiento de testimonios solo para mvm -->
         <xsl:choose>
          <xsl:when test="(Testimonios/TESTIMONIOSPENDIENTES/TESTIMONIOS/USUARIOCONECTADO/MVM or Testimonios/TESTIMONIOSPENDIENTES/TESTIMONIOS/USUARIOCONECTADO/MVMB) and not(/Testimonios/PARAM = 'PARTEPUBLICA')">
           
           <!--paginacion--> 
            <form name="pageTesti" action="AdminTestimonios.xsql" method="post">
            	<input type="hidden" name="PAG"/>
                <input type="hidden" name="PENDIENTE_TESTI"/>
                <!--buscador de testimonios admin-->
                <div class="divleft">
                <div class="divCenter50">
                  <table class="busca">
                   <tr>
                   <td class="buscaLeft">&nbsp;</td>
                   <td class="aster">  
                    <input type="text" name="BUSCA_TESTI" value="{Testimonios/TESTIMONIOSPENDIENTES/TESTIMONIOS/PALABRASCLAVE}" />
                    &nbsp;
                    <input type="checkbox" name="PENDIENTE_TESTI_CK">
                        <xsl:if test="Testimonios/TESTIMONIOSPENDIENTES/TESTIMONIOS/TIPOLISTADO = 'PENDIENTES'">
                            <xsl:attribute name="checked">checked</xsl:attribute>
                        </xsl:if>
                    </input>
                    &nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='pendientes']/node()"/>
                    </td>
                    <td>
                       <a id="buscaAdminTestimonios">
                        <img src="http://www.newco.dev.br/images/buttonBuscar.gif" alt="Boton Buscar" title="Buscar en MedicalVM" id="buscarPedido" style="vertical-align:middle; margin-bottom:10px;"/>
                        </a>
                    </td>
                	<td class="buscaRight">&nbsp;</td>
                    </tr>
                  </table>
              </div><!--fin de divLeft50-->
              </div><!--fin de divLeft-->
               
            <div class="divLeft">
               <div class="divCenter50">
               <xsl:if test="Testimonios/TESTIMONIOSPENDIENTES/TESTIMONIOS/ANTERIOR">
                  <p><img src="http://www.newco.dev.br/images/anterior.gif"/>&nbsp;<a href="javascript:navegaTesti(document.forms['pageTesti'],{Testimonios/TESTIMONIOSPENDIENTES/TESTIMONIOS/PAGINA},'anterior');"><xsl:value-of select="document($doc)/translation/texts/item[@name='anterior']/node()"/></a>
                  </p>
              </xsl:if>&nbsp;
              </div> <!--fin de divLeft50-->
              <div class="divCenter50">
              <xsl:if test="Testimonios/TESTIMONIOSPENDIENTES/TESTIMONIOS/SIGUIENTE">
                 <p style="text-align:right;"><a href="javascript:navegaTesti(document.forms['pageTesti'],{Testimonios/TESTIMONIOSPENDIENTES/TESTIMONIOS/PAGINA},'siguiente');"><xsl:value-of select="document($doc)/translation/texts/item[@name='siguiente']/node()"/>
                 </a>&nbsp;<img src="http://www.newco.dev.br/images/siguiente.gif"/></p>
              </xsl:if>
              </div><!--fin de divCenter50-->
              <br /><br />
            </div><!--fin de divLeft-->
            
           <!--fin paginacion-->
          <!--testimonios todos, mant testimonio-->
          <div class="divLeft">
               <div class="divCenter50">
                <xsl:for-each select="Testimonios/TESTIMONIOSPENDIENTES/TESTIMONIOS/TESTIMONIO">
          		<div class="mantTestimonio">
                	
                    	<div class="mantTextTesti">
                        	<p class="strongAzul"><xsl:value-of select="PALABRASCLAVE"/></p>
                        	<p><xsl:copy-of select="TEXTO"/></p>
                        </div>
                        
                    	<div class="mantQuienTesti">
                            <p class="azul">
                            -&nbsp;<xsl:value-of select="FECHA"/>&nbsp;&nbsp;
                            <xsl:value-of select="USUARIO"/>&nbsp;&nbsp;
                            <xsl:value-of select="CARGO"/>&nbsp;<xsl:value-of select="CENTRO"/>
                           </p> 
                          
                        </div>
                        
                        <div class="mantLinkTesti">
                            <p>
                            <!--<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Gestion/Testimonios/MantTestimonios.xsql?ID={ID}',','Mantenimiento Testimonios',80,70,0,-50)">-->
                            <a href="http://www.newco.dev.br/Gestion/Testimonios/MantTestimonios.xsql?ID={ID}">
                            <xsl:value-of select="document($doc)/translation/texts/item[@name='mantenimiento']/node()"/>
                            </a>
                            </p>
                    	</div>
                        <div class="detalleTesti">
                            <xsl:if test="IMPORTANCIA != ''">
                            	<p>
                            	<xsl:value-of select="document($doc)/translation/texts/item[@name='importancia']/node()"/>:&nbsp;
                                <xsl:value-of select="IMPORTANCIA"/></p>
                            </xsl:if>
                           
                        </div><!--fin de detalleTesti-->
                        <div class="estadoTesti">
                        	 <!--estado-->
                            <p><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='estado']/node()"/>:&nbsp;
                            <xsl:choose>
                            <xsl:when test="ESTADO = 'P'">
                            	<xsl:value-of select="document($doc)/translation/texts/item[@name='pendiente']/node()"/>
                            </xsl:when>
                            <xsl:when test="ESTADO = 'B'">
                            	<xsl:value-of select="document($doc)/translation/texts/item[@name='borrado']/node()"/>
                            </xsl:when>
                            <xsl:otherwise>
                            	<xsl:value-of select="document($doc)/translation/texts/item[@name='activo']/node()"/>
                            </xsl:otherwise>
                            </xsl:choose>
                            </strong>
                            </p>
                        </div>
                 </div><!--fin de onetestimonios-->
          </xsl:for-each>
               </div>
          </div><!--fin de divLeft-->
           
          <!--paginacion admin testimonios--> 
           
        	
            <div class="divLeft">
               <div class="divLeft50nopa">
               <xsl:if test="Testimonios/TESTIMONIOSPENDIENTES/TESTIMONIOS/ANTERIOR">
                  <p><img src="http://www.newco.dev.br/images/anterior.gif"/>&nbsp;<a href="javascript:navegaTesti(document.forms['pageTesti'],{Testimonios/TESTIMONIOSPENDIENTES/TESTIMONIOS/PAGINA},'anterior');"><xsl:value-of select="document($doc)/translation/texts/item[@name='anterior']/node()"/></a>
                  </p>
              </xsl:if>&nbsp;
              </div> <!--fin de divLeft50-->
              <div class="divLeft50nopa">
              <xsl:if test="Testimonios/TESTIMONIOSPENDIENTES/TESTIMONIOS/SIGUIENTE">
                 <p style="text-align:right;"><a href="javascript:navegaTesti(document.forms['pageTesti'],{Testimonios/TESTIMONIOSPENDIENTES/TESTIMONIOS/PAGINA},'siguiente');"><xsl:value-of select="document($doc)/translation/texts/item[@name='siguiente']/node()"/>
                 </a>&nbsp;<img src="http://www.newco.dev.br/images/siguiente.gif"/></p>
              </xsl:if>
              </div><!--fin de divLeft50-->
            </div><!--fin de divLeft-->
              <br /><br />
           <!--fin paginacion admin testimonios-->
           </form>
        </xsl:when>
        <xsl:otherwise>
      
        </xsl:otherwise>
        </xsl:choose>
		
      
	 </div><!--fin de zonaPublicaBox-->

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