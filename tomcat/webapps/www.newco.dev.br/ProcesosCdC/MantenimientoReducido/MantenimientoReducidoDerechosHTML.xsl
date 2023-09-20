<?xml version="1.0" encoding="iso-8859-1" ?>
<!--
	Derechos para un producto a nivel de usuario
	Ultima revision: ET 20nov19 10:48
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:import href = "http://www.newco.dev.br/General/General.xsl" /> 
	<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
	<xsl:param name="lang" select="@lang"/>
	
	<xsl:template match="/">  
		<html>
			<head> 
            <!--idioma-->
             <xsl:variable name="lang">
            <xsl:choose>
                <xsl:when test="/Mantenimiento/LANG"><xsl:value-of select="/Mantenimiento/LANG" /></xsl:when>
                <xsl:otherwise>spanish</xsl:otherwise>
                </xsl:choose>  
            </xsl:variable>
            <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>          <!--idioma fin-->
            
			<title><xsl:value-of select="Mantenimiento/DERECHOSPORUSUARIO/PRODUCTO"/>&nbsp;-&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='ocultar_mostrar_a_usuarios_de']/node()"/>&nbsp;<xsl:value-of select="Mantenimiento/DERECHOSPORUSUARIO/EMPRESA"/>

        	</title>

			<!--style-->
			<xsl:call-template name="estiloIndip"/>
			<!--fin de style-->  

			<script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
			<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>
			<!--<script type="text/javascript" src="http://www.newco.dev.br/ProcesosCdC/MantenimientoReducido/mantenimientoReducido.js"></script>-->
			<script type="text/javascript" src="http://www.newco.dev.br/ProcesosCdC/MantenimientoReducido/mantenimientoReducidoDerechos_290318.js"></script>
						
			</head>
			
			<body class="gris">
				<xsl:choose>
					<xsl:when test="Mantenimiento/ERROR">
						<xsl:apply-templates select="Mantenimiento/ERROR"/>          
					</xsl:when>
					<xsl:otherwise>
						<xsl:call-template name="MantenimientoEdicion"/>          
					</xsl:otherwise>
				</xsl:choose>        
			</body>
		</html>
	</xsl:template>


	<!--
 	|  template con la pagina
 	+-->

	<xsl:template name="MantenimientoEdicion">
    
     	 <!--idioma-->
             <xsl:variable name="lang">
            <xsl:choose>
                <xsl:when test="/Mantenimiento/LANG"><xsl:value-of select="/Mantenimiento/LANG" /></xsl:when>
                <xsl:otherwise>spanish</xsl:otherwise>
                </xsl:choose>  
            </xsl:variable>
            <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>          <!--idioma fin-->
            
    <div class="divLeft">
    
		<form name="form1" method="post" action="http://www.newco.dev.br/ProcesosCdC/MantenimientoReducido/MantenimientoReducidoDerechos.xsql">
			
			
            <input type="hidden" name="IDEMPRESA" value="{/Mantenimiento/DERECHOSPORUSUARIO/IDEMPRESA}"/>
            <input type="hidden" name="ID_PLANTILLA" value="{/Mantenimiento/DERECHOSPORUSUARIO/@idplantilla}"/>
            <input type="hidden" name="ID_PLANTILLA_PROV" value="{/Mantenimiento/DERECHOSPORUSUARIO/@idplantilla_prov}"/>
            <input type="hidden" name="IDPRODUCTO" value="{/Mantenimiento/DERECHOSPORUSUARIO/@idproducto}"/>
			<input type="hidden" name="DERECHOS_PLANTILLAS" value=""/>
            <input type="hidden" name="US_CONECTADO" value="{/Mantenimiento/DERECHOSPORUSUARIO/IDUSUARIO}"/>


		<!--	Titulo de la página		-->
		<div class="ZonaTituloPagina">
			<p class="Path"><xsl:value-of select="document($doc)/translation/texts/item[@name='Inicio']/node()"/>&nbsp;/&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='catalogo_privado']/node()"/>&nbsp;/&nbsp;<span class="FinPath"><xsl:value-of select="Mantenimiento/DERECHOSPORUSUARIO/EMPRESA"/></span>
				<span class="CompletarTitulo" style="width:200px">
					<xsl:if test="/Mantenimiento/FichaCatalogacionSave">
						<span class="rojo" id="exito">&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='datos_guardados_con_exito']/node()"/></span>&nbsp;
					</xsl:if>
				</span>
			</p>
			<p class="TituloPagina">
        		<xsl:value-of select="Mantenimiento/DERECHOSPORUSUARIO/PRODUCTO" disable-output-escaping="yes"/>
				<span class="CompletarTitulo" style="width:200px">
             		<a class="btnDestacado" href="javascript:GuardarDerechos(document.forms['form1']);">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='guardar']/node()"/>
					</a>
					&nbsp;
					<a class="btnNormal" href="javascript:CerrarVentana(document.forms['form1']);">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='cerrar']/node()"/>
					</a>
				</span>
			</p>
		</div>
		<br/>

		<!--
		<h1 class="titlePage">
        <xsl:value-of select="Mantenimiento/DERECHOSPORUSUARIO/PRODUCTO"/>&nbsp;-&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='ocultar_mostrar_a_usuarios_de']/node()"/>&nbsp;<xsl:value-of select="Mantenimiento/DERECHOSPORUSUARIO/EMPRESA"/>
        <!- -<xsl:value-of select="document($doc)/translation/texts/item[@name='ocultar_productos']/node()"/>- ->
        </h1>
			-->	
					
				<table class="buscador" border="0">
					
					<!-- titulos de la tabla -->
					<tr class="subTituloTabla">
                        <th class="dies">&nbsp;</th>
                        <th class="veintecinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='usuario']/node()"/></th>
                        <th class="dies">
                        	<xsl:value-of select="document($doc)/translation/texts/item[@name='ocultar']/node()"/><br /> <br />  
                            <a class="btnDestacadoPeq" href="javascript:selTodosOcultos();">
                            	<xsl:value-of select="document($doc)/translation/texts/item[@name='todos']/node()"/>
                            </a>
                        </th>
                        <th class="dies">
                        	<xsl:value-of select="document($doc)/translation/texts/item[@name='bloquear']/node()"/><br /> <br /> 
                            <a class="btnDestacadoPeq" href="javascript:selTodosBloquear();">
                            	<xsl:value-of select="document($doc)/translation/texts/item[@name='todos']/node()"/>
                            </a>
                        </th>
                        <th>&nbsp;</th>
                    </tr>
	  					<!-- para cada centro -->
	  					<xsl:for-each select="Mantenimiento/DERECHOSPORUSUARIO/CENTRO">
							<input type="hidden">
								<xsl:attribute name="name">CENTRO_ID_<xsl:value-of select="ID"/></xsl:attribute>
    							<xsl:attribute name="value"><xsl:value-of select="ID"/></xsl:attribute>      
 							</input>
 							<!-- derechos de acceso a nivel de centro -->
							<tr>
                                <td>&nbsp;</td>
			  					<td>&nbsp;<strong><xsl:value-of select="./NOMBRE"/></strong></td>
			  					<!-- ocultar -->
			  					<td>&nbsp; </td>
                                <!-- bloquear -->
                                <td>&nbsp; </td>
			  					<td>&nbsp;</td>
							</tr>
								<!-- para cada usuario del centro -->
	  						<xsl:for-each select="./USUARIO">
  									
									<tr>
                                    	<td>&nbsp;</td>
										<td align="left">
                                        <input type="hidden" name="USUARIO_{ID}">
    									<xsl:attribute name="value"><xsl:value-of select="ID"/></xsl:attribute>      
 										</input>
											&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-&nbsp;<xsl:value-of select="./NOMBRE"/>
										</td>
										<!-- ocultar check -->
										<td align="center">
											<input type="checkbox" name="OCULTAR_{ID}" onclick="Desocultar({ID});" onchange="Desocultar({ID});">							
                                            <!--si usuario es igual usuario conectado no puedo ocultar, bloquear-->
                                            <xsl:if test="ID = /Mantenimiento/DERECHOSPORUSUARIO/IDUSUARIO">
                                            <xsl:attribute name="disabled">disabled</xsl:attribute>
                                            </xsl:if>
                                            
	    									<xsl:choose>
	      									<xsl:when test="./PLANTILLA[1]/OCULTAR='S'">
												<xsl:attribute name="checked">checked</xsl:attribute>
	      									</xsl:when>
                                            <xsl:otherwise>
                                            	<xsl:attribute name="unchecked"></xsl:attribute>
                                            </xsl:otherwise>
	    									</xsl:choose>
											</input>
											<input type="hidden" name="OCULTARANT_{ID}" value="{./PLANTILLA[1]/OCULTAR}"/>
										</td>
                                        <!-- BLOQUEAR check -->
										<td align="center">
											<input type="checkbox" name="BLOQUEAR_{ID}" onclick="Bloquear({ID});" onchange="Bloquear({ID});">							
                                            <!--si usuario es igual usuario conectado no puedo ocultar, bloquear-->
                                            <xsl:if test="ID = /Mantenimiento/DERECHOSPORUSUARIO/IDUSUARIO">
                                            <xsl:attribute name="disabled">disabled</xsl:attribute>
                                            </xsl:if>
                                            
	    									<xsl:choose>
	      									<xsl:when test="./PLANTILLA[1]/BLOQUEAR='S'">
												<xsl:attribute name="checked">checked</xsl:attribute>
	      									</xsl:when>
                                            <xsl:otherwise>
                                            	<xsl:attribute name="unchecked"></xsl:attribute>
                                            </xsl:otherwise>
	    									</xsl:choose>
											</input>
											<input type="hidden" name="BLOQUEARANT_{ID}" value="{./PLANTILLA[1]/BLOQUEAR}"/>
										</td>
                                        <td>&nbsp;</td>
									</tr>
	  						</xsl:for-each>  
	  					</xsl:for-each>  
				</table>
			<!--
  			  	<table class="mediaTabla">
                	<tr><td colspan="4">&nbsp;</td></tr>
  			    	<tr align="center">    
                    	<td class="trenta">&nbsp;</td> 
					    <td class="veinte">  
                        	<div class="boton">
                            <a href="javascript:CancelarDerechos();">
                            	<xsl:value-of select="document($doc)/translation/texts/item[@name='cancelar']/node()"/>
                            </a>
                            </div>
					      </td> 
                          <td class="dies">&nbsp; </td>
					      <td> 
                          <div class="boton">
                            <a href="javascript:GuardarDerechos(document.forms['form1']);">
                            	<xsl:value-of select="document($doc)/translation/texts/item[@name='aceptar_minu']/node()"/>
                            </a>
                            </div>
					      
					      </td>
					</tr>
				</table>      
				-->	
		</form>
       </div><!--fin de divLeft-->
	</xsl:template>

	<!-- template error -->
	<xsl:template match="/Mantenimiento/ERROR">
    
      <!--idioma-->
             <xsl:variable name="lang">
            <xsl:choose>
                <xsl:when test="/Mantenimiento/LANG"><xsl:value-of select="/Mantenimiento/LANG" /></xsl:when>
                <xsl:otherwise>spanish</xsl:otherwise>
                </xsl:choose>  
            </xsl:variable>
            <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>          <!--idioma fin-->
            
		<div class="divLeft">
			<h1 class="titlePage">
				<xsl:value-of select="./@titulo"/>
			</h1>
			<br /><br />
            
			<p align="center">
				<xsl:value-of select="./@msg"/>
			</p>
			<br/><br/>
			<p align="center">
            	<div class="botonCenter">
            	<a href="javascript:window.close();">
                	<xsl:value-of select="document($doc)/translation/texts/item[@name='cerrar']/node()"/>
                </a>
                </div>
            </p>
		</div><!--fin de divLeft-->
	</xsl:template>

</xsl:stylesheet>
