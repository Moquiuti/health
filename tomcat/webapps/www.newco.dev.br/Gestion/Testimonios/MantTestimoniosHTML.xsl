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
    <script type="text/javascript" src="http://www.newco.dev.br/Gestion/Testimonios/testimonios.js"></script>
    
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
         
         
			
	<h1 class="titlePage">
    	 <xsl:value-of select="document($doc)/translation/texts/item[@name='mantenimiento_testimonio']/node()"/>
    </h1>
			<div class="divLeft">
            	<div id="confirmTestimonio" style="display:none;"><span class="rojo">Enviando</span></div>
            </div><!--fin divLeft-->
            
        	<div class="divLeft gris">
            	<form name="mantTesti" action="MantTestimoniosSave.xsql">
                	<input type="hidden" name="TES_ID" value="{Testimonios/TESTIMONIO/ID}"/>
                 <table class="infoTable">
                      <tr>
                      	<td class="dos">&nbsp;</td>
                      	<td class="labelRight veinte"><xsl:value-of select="document($doc)/translation/texts/item[@name='nombre']/node()"/>:</td>
                        <td class="datosLeft" colspan="2"><input type="text" name="TES_NOMBRE" value="{Testimonios/TESTIMONIO/USUARIO}" size="50"/></td>
                      </tr>
                      <tr>
                      	<td class="dos">&nbsp;</td>
                      	<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='centro']/node()"/>:</td>
                        <td class="datosLeft" colspan="2"> <input type="text" name="TES_CENTRO" value="{Testimonios/TESTIMONIO/CENTRO}" size="50"/></td>
                      </tr>
                      <tr>
                      	<td class="dos">&nbsp;</td>
                      	<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='cargo']/node()"/>:</td>
                        <td class="datosLeft" colspan="2"> <input type="text" name="TES_CARGO" value="{Testimonios/TESTIMONIO/CARGO}" size="50"/></td>
                      </tr>
                    
                      <tr><td colspan="4">&nbsp;</td></tr>
                       <tr>
                       	 <td class="dos">&nbsp;</td>
                      	 <td colspan="3" class="datosLeft"><xsl:copy-of select="document($doc)/translation/texts/item[@name='testimonios_text']/node()"/></td>
                      </tr>
                      <tr><td colspan="4">&nbsp;</td></tr>
                        <tr>
                      	<td class="dos">&nbsp;</td>
                      	<td class="labelRight" valign="top"><xsl:value-of select="document($doc)/translation/texts/item[@name='mensaje']/node()"/>:</td>
                      	<td class="datosLeft" colspan="2">
                            <textarea name="TES_TEXTO" rows="6" cols="50">
                            	<xsl:value-of select="/Testimonios/TESTIMONIO/TEXTO"/>
                            </textarea>
                        </td>
                      </tr>
                      <tr>
                      	<td class="dos">&nbsp;</td>
                      	<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='palabras_clave']/node()"/>:</td>
                        <td class="datosLeft" colspan="2"> <input type="text" name="TES_PALABRAS" value="{Testimonios/TESTIMONIO/PALABRASCLAVE}" size="50"/></td>
                      </tr>
                      <tr>
                      	<td class="dos">&nbsp;</td>
                      	<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='importancia']/node()"/>:</td>
                        <td class="datosLeft" colspan="2">
						 	<!--<input type="text" name="TES_IMPORTANCIA" value="{Testimonios/TESTIMONIO/IMPORTANCIA}" size="50"/>-->
							<xsl:call-template name="desplegable">
        						<xsl:with-param name="path" select="/Testimonios/TESTIMONIO/IMPORTANCIA/field">
        						</xsl:with-param>
      						</xsl:call-template>				
						</td>
                      </tr>
                        <tr>
                      	<td class="dos">&nbsp;</td>
                      	<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='estado']/node()"/>:</td>
                        <td class="datosLeft" colspan="2"> 
                            <select name="TES_ESTADO">
                                <option value="P">
                                    <xsl:if test="Testimonios/TESTIMONIO/ESTADOCORREGIDO = 'P'"><xsl:attribute name="selected">true</xsl:attribute></xsl:if>
                                <xsl:value-of select="document($doc)/translation/texts/item[@name='pendiente']/node()"/>
                                </option>
                                <option value="">
                                    <xsl:if test="Testimonios/TESTIMONIO/ESTADOCORREGIDO = 'A'" ><xsl:attribute name="selected">true</xsl:attribute></xsl:if>
                                <xsl:value-of select="document($doc)/translation/texts/item[@name='activo']/node()"/>
                                </option>
                                <option value="B">
                                    <xsl:if test="Testimonios/TESTIMONIO/ESTADOCORREGIDO = 'B'" ><xsl:attribute name="selected">true</xsl:attribute></xsl:if>
                                 <xsl:value-of select="document($doc)/translation/texts/item[@name='borrado']/node()"/>
                                </option>
                            </select>
               			</td>
                      </tr>
                       <tr><td colspan="4">&nbsp;</td></tr>
                	  <tr>
                      <td colspan="2">&nbsp;</td>
                      <td class="trenta">
                         <div class="boton">
                      		<strong><a href="javascript:EnviaMantTestimonio(document.forms['mantTesti']);"> <xsl:value-of select="document($doc)/translation/texts/item[@name='enviar']/node()"/></a></strong>
                  		</div>
                      <td> 
                      	<div class="boton">
                      		<strong><a href="http://www.newco.dev.br/Gestion/Testimonios/Testimonios.xsql"><xsl:value-of select="document($doc)/translation/texts/item[@name='volver']/node()"/></a></strong>
                  		</div>
                        </td>
                      </td>
                      </tr>
                      <tr><td colspan="4">&nbsp;</td></tr>
                   </table>
                    
            	</form>
            </div><!--fin de nuevoTestimonio divLeft-->
        
    	
         
        
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