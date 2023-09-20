<?xml version="1.0" encoding="iso-8859-1" ?>
<!--
	Mantenimiento de empaquetamientos privados
	Ultima revisión: ET 14mar22 11:40
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:import href = "http://www.newco.dev.br/General/General.xsl"/> 
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="lang" select="@lang"/>

<xsl:template match="/">

	<!--	Todos los documentos HTML deben empezar con esto	-->
	<xsl:text disable-output-escaping='yes'>&lt;!doctype html></xsl:text>

    <html>
      <head>
        <!--idioma-->
         <xsl:variable name="lang">
        <xsl:choose>
            <xsl:when test="/Empaquetamientos/LANG"><xsl:value-of select="/Empaquetamientos/LANG" /></xsl:when>
            <xsl:otherwise>spanish</xsl:otherwise>
            </xsl:choose>  
        </xsl:variable>
        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
      <!--idioma fin-->
           
		<title><xsl:value-of select="/Empaquetamientos/EMPAQUETAMIENTOS/PROVEEDOR"/>:&nbsp;<xsl:value-of select="/Empaquetamientos/EMPAQUETAMIENTOS/PRO_REFERENCIA"/>&nbsp;<xsl:value-of select="substring(/Empaquetamientos/EMPAQUETAMIENTOS/PRO_NOMBRE, 1, 75)"/>:&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='empaquetamientos']/node()"/></title>
		<!--style-->
		<xsl:call-template name="estiloIndip"/>
		<!--fin de style-->  

		<script src="http://www.newco.dev.br/General/jquery-3.6.0.js"></script>	
		<script type="text/javascript" src="http://www.newco.dev.br/General/basic2022_010822.js"></script>
		<!--<script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
		<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>-->
		<script type="text/javascript" src="http://www.newco.dev.br/Administracion/Mantenimiento/Productos/PROEmpaquetamientos2022_140322.js"></script>        
      </head>
      <body>
      	  <!--idioma-->
         <xsl:variable name="lang">
        <xsl:choose>
            <xsl:when test="/Empaquetamientos/LANG"><xsl:value-of select="/Empaquetamientos/LANG" /></xsl:when>
            <xsl:otherwise>spanish</xsl:otherwise>
            </xsl:choose>  
        </xsl:variable>
        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
      <!--idioma fin-->
           
     
        <xsl:choose>
          <!-- Error en alguna sentencia del XSQL -->
          <xsl:when test="//xsql-error">
            <xsl:apply-templates select="//xsql-error"/>        
          </xsl:when>
          <xsl:when test="//SESION_CADUCADA">
            <xsl:for-each select="//SESION_CADUCADA">
              <xsl:if test="position()=last()">
                <xsl:apply-templates select="."/>
              </xsl:if>
            </xsl:for-each>        
          </xsl:when>
          <xsl:otherwise>
			<!--	Titulo de la página		-->
			<div class="ZonaTituloPagina">
				<!--<p class="Path">&nbsp;</p>-->
				<p class="TituloPagina">
					<xsl:value-of select="/Empaquetamientos/EMPAQUETAMIENTOS/PROVEEDOR"/>:&nbsp;<xsl:value-of select="/Empaquetamientos/EMPAQUETAMIENTOS/PRO_REFERENCIA"/>&nbsp;<xsl:value-of select="substring(/Empaquetamientos/EMPAQUETAMIENTOS/PRO_NOMBRE, 1, 75)"/>
					<span class="CompletarTitulo w400px">
                	   <a class="btnNormal" href="javascript:window.close();">
                        	<xsl:value-of select="document($doc)/translation/texts/item[@name='cerrar']/node()"/>
                	   </a>
					</span>
				</p>
			</div>
			<br/>
 			<div class="divLeft marginTop20">
				<ul class="pestannas w100" style="position:relative;">
					<li>
						<a id="pes_Ficha" class="MenuLic"><xsl:value-of select="document($doc)/translation/texts/item[@name='Ficha_de_producto']/node()"/></a>
					</li>
					<li>
						<a id="pes_Tarifas" class="MenuLic"><xsl:value-of select="document($doc)/translation/texts/item[@name='tarifas']/node()"/></a>
					</li>
					<li>
						<a id="pes_Documentos" class="MenuLic"><xsl:value-of select="document($doc)/translation/texts/item[@name='documentos']/node()"/></a>
					</li>
					<li>
						<a id="pes_Pack" class="MenuLic"><xsl:value-of select="document($doc)/translation/texts/item[@name='Contenido_pack']/node()"/></a>
					</li>
					<li>
						<a id="pes_Empaquetamiento" class="MenuLic"><xsl:value-of select="document($doc)/translation/texts/item[@name='empaquetamientos']/node()"/></a>
					</li>
				</ul>
			</div>


          
 			<div class="divLeft marginTop20">
        	<form name="frmEmpaquetamiento" method="get">
        	 <input type="hidden" name="PRO_ID" id="PRO_ID" value="{/Empaquetamientos/EMPAQUETAMIENTOS/IDPRODUCTO}"/>

			<div class="tabela tabela_redonda">
			<table class="w800px tableCenter" cellspacing="6px" cellpadding="6px">
				<thead class="cabecalho_tabela">
					<tr>
            		<th class="w1px">&nbsp;</th>
            		<th>
            		  <xsl:value-of select="document($doc)/translation/texts/item[@name='cliente']/node()"/>
            		</th>
            		<th class="w150px">
            		 <xsl:value-of select="document($doc)/translation/texts/item[@name='unidad_basica']/node()"/>
            		</th>
            		<th class="w150px">
            			<xsl:value-of select="document($doc)/translation/texts/item[@name='unidad_por_lote']/node()"/>
            		</th>
            		<th class="w10px">&nbsp;</th>
        	  	</tr>
				</thead>
				<tbody class="corpo_tabela">
				<xsl:choose>
				<xsl:when test="/Empaquetamientos/EMPAQUETAMIENTOS/EMPAQUETAMIENTO">
				  <!-- mostramos cada empresa -->
				  <xsl:for-each select="/Empaquetamientos/EMPAQUETAMIENTOS/EMPAQUETAMIENTO">
				  <tr class="conhover">
    				<td class="color_status">&nbsp;</td>
    				<td class="textCenter"><xsl:value-of select="CLIENTE"/></td>
    				<td class="textCenter"><xsl:value-of select="UNIDADBASICA"/></td>
    				<td class="textCenter"><xsl:value-of select="UNIDADESPORLOTE"/></td>
    				<td align="left" style="text-align:left;">
        				<a href="javascript:EliminarEmpaquetamiento({IDCLIENTE});">
							<img src="http://www.newco.dev.br/images/2022/icones/del.svg" alt="Eliminar"/>
						</a>
    				</td>
				  </tr>
				  </xsl:for-each>
				</xsl:when>
				<xsl:otherwise>
				  <tr>
    				<td colspan="5">
        				<strong><xsl:value-of select="document($doc)/translation/texts/item[@name='no_hay_datos']/node()"/></strong>
    				</td>
				  </tr>
				</xsl:otherwise>
				</xsl:choose>
				</tbody>
				<tfoot class="rodape_tabela">
					<tr><td colspan="5">&nbsp;</td></tr>
				</tfoot>
        	</table> 
			</div>
			<br/><br/>
			<!--nuevo empaquetamineto-->          
			<table cellspacing="6px" cellpadding="6px"> 
				<tr class="fondoGris">
            		<td>&nbsp;</td>
                	<td colspan="5">
                    	<strong><xsl:value-of select="document($doc)/translation/texts/item[@name='nuevo_empaquetamiento']/node()"/></strong>
                	</td>
               	</tr>
				<tr><td colspan="6">&nbsp;</td></tr>
				<tr>
            		<td>&nbsp;</td>
            		<td class="textLeft w220px">
              			<label><xsl:value-of select="document($doc)/translation/texts/item[@name='cliente']/node()"/>:</label>
	          			<xsl:choose>
            			<xsl:when test="/Empaquetamientos/EMPAQUETAMIENTOS/ADMIN">
							<span class="camposObligatorios">*</span>&nbsp;<br/>
                    		<xsl:call-template name="desplegable">
              					<xsl:with-param name="path" select="/Empaquetamientos/EMPAQUETAMIENTOS/CLIENTES/field"></xsl:with-param>
                        		<xsl:with-param name="claSel">w200px</xsl:with-param>
            				</xsl:call-template>
            			</xsl:when>
            			<xsl:otherwise>
							<br/>
							<xsl:value-of select="/Empaquetamientos/EMPAQUETAMIENTOS/EMPRESA"/>
							<input type="hidden" name="IDCLIENTE" id="IDCLIENTE" value="{/Empaquetamientos/EMPAQUETAMIENTOS/IDEMPRESA}"/>
						</xsl:otherwise>
						</xsl:choose>
						
            		</td>
            		<td class="textLeft w150px">
						<label><xsl:value-of select="document($doc)/translation/texts/item[@name='unidad_basica']/node()"/>:<span class="camposObligatorios">*</span></label><br/>
						<input type="text" class="campopesquisa w140px" name="UN_BASICA" id="UN_BASICA" />
            		</td>
           			<td class="textLeft w150px">
          			  	<label><xsl:value-of select="document($doc)/translation/texts/item[@name='unidad_por_lote']/node()"/>:<span class="camposObligatorios">*</span></label><br/>
            		 	<input type="text" class="campopesquisa w140px" name="UN_LOTE" id="UN_LOTE"/>
      				</td>
            		<td class="textLeft w150px">
					 	<br/>
						<a class="btnDestacado" href="javascript:EnviarEmpaquetamiento();">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='enviar']/node()"/>
						</a>
					 &nbsp;
					</td>
					<td>&nbsp;</td>
        	 	</tr>

			</table>
        	</form>

        	<form name="MensajeJS">
        		<input type="hidden" name="ERROR_INSERTAR_DATOS" value="{document($doc)/translation/texts/item[@name='error_insertar_datos']/node()}"/>
            	<input type="hidden" name="ERROR_ELIMINAR_DATOS" value="{document($doc)/translation/texts/item[@name='error_eliminar_datos']/node()}"/>
            	<input type="hidden" name="TODOS_CAMPOS_OBLI" value="{document($doc)/translation/texts/item[@name='todos_campos_obli']/node()}"/>
        	</form>
			</div>
        </xsl:otherwise>
        </xsl:choose>
      </body>
    </html>
  </xsl:template>

</xsl:stylesheet>
