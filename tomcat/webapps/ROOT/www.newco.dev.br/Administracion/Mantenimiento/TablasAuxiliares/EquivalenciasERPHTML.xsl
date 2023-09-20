<?xml version="1.0" encoding="iso-8859-1" ?>
<!--	
	Mantenimiento de equivalencias de forma y plazo de pago en plataforma y ERP, para usuarios MVM
	Ultima revision: ET 18nov21 12:00 EquivalenciasERP_181121.js
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href = "http://www.newco.dev.br/General/General.xsl"/>
  <xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
  <xsl:param name="lang" select="@lang"/>  
  <xsl:template match="/">
    <html>
      <head>
      <!--idioma-->
        <xsl:variable name="lang">
        <xsl:choose>
            <xsl:when test="/EquivalenciasERP/LANG"><xsl:value-of select="/EquivalenciasERP/LANG" /></xsl:when>
            <xsl:otherwise>spanish</xsl:otherwise>
            </xsl:choose>  
        </xsl:variable>
        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>        <!--idioma fin-->
        
		<title><xsl:value-of select="document($doc)/translation/texts/item[@name='Tablas_auxiliares']/node()"/>:&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Equivalencias_ERP']/node()"/></title>
		<!--style-->
		<xsl:call-template name="estiloIndip"/>
		<!--fin de style-->  

		<script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
		<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>
		<script type="text/javascript" src="http://www.newco.dev.br/General/descargas_151117.js"></script>		<!-- Para descargas excel	-->
		<script type="text/javascript" src="http://www.newco.dev.br/Administracion/Mantenimiento/TablasAuxiliares/EquivalenciasERP_181121.js"></script>
        <script type="text/javascript">
			var str_FicheroProcesado= '<xsl:value-of select="document($doc)/translation/texts/item[@name='Fichero_Procesado']/node()"/>';
			var str_FicheroYaEnviado= '<xsl:value-of select="document($doc)/translation/texts/item[@name='Fichero_ya_enviado']/node()"/>';	
			var str_ErrorDesconocidoCreandoFichero= '<xsl:value-of select="document($doc)/translation/texts/item[@name='Error_desconocido_creando_fichero']/node()"/>';	

			var strCodObligatorio='<xsl:value-of select="document($doc)/translation/texts/item[@name='Codigo_obligatorio']/node()"/>';
			var strDescripcionObligatoria='<xsl:value-of select="document($doc)/translation/texts/item[@name='Descripcion_obligatoria']/node()"/>';
			var strIDFormaPagoOFormaPagoObligatoria='<xsl:value-of select="document($doc)/translation/texts/item[@name='ID_forma_pago_obligatorio']/node()"/>';
			var strIDPlazoPagoOPlazoPagoObligatorio='<xsl:value-of select="document($doc)/translation/texts/item[@name='ID_plazo_pago_obligatorio']/node()"/>';
			var str_ErrSubirRegistro= '<xsl:value-of select="document($doc)/translation/texts/item[@name='err_subir_registro']/node()"/>';	
			var str_NoPodidoIncluirRegistro= '<xsl:value-of select="document($doc)/translation/texts/item[@name='err_subir_registro']/node()"/>';	
			
			var IDUsuario=<xsl:value-of select="/EquivalenciasERP/FORMASYPLAZOSDEPAGO/IDUSUARIO"/>;

			var strCodigo= '<xsl:value-of select="document($doc)/translation/texts/item[@name='codigo']/node()"/>';
			var strID='<xsl:value-of select="document($doc)/translation/texts/item[@name='id']/node()"/>';
			var strForma='<xsl:value-of select="document($doc)/translation/texts/item[@name='forma_de_pago']/node()"/>';
			var strPlazo='<xsl:value-of select="document($doc)/translation/texts/item[@name='plazo_de_pago']/node()"/>';
			var strDescripcion='<xsl:value-of select="document($doc)/translation/texts/item[@name='Descripcion_ERP']/node()"/>';

			var arrEquiv			= new Array();
			<xsl:for-each select="/EquivalenciasERP/FORMASYPLAZOSDEPAGO/FORMAYPLAZODEPAGO">
				var Equiv			= [];
				Equiv['Codigo']	= '<xsl:value-of select="CODIGOCLIENTE"/>';
				Equiv['Descripcion']	= '<xsl:value-of select="DESCRIPCION"/>';
				Equiv['IDForma']	= '<xsl:value-of select="FP_ID"/>';
				Equiv['Forma']	= '<xsl:value-of select="FP_DESCRIPCION"/>';
				Equiv['IDPlazo']	= '<xsl:value-of select="PP_ID"/>';
				Equiv['Plazo']	= '<xsl:value-of select="PP_DESCRIPCION"/>';
				arrEquiv.push(Equiv);
			</xsl:for-each>

		</script>
      </head>
      <body>   
      <!--idioma-->
         <xsl:variable name="lang">
        <xsl:choose>
            <xsl:when test="/EquivalenciasERP/LANG"><xsl:value-of select="/EquivalenciasERP/LANG" /></xsl:when>
            <xsl:otherwise>spanish</xsl:otherwise>
            </xsl:choose>  
        </xsl:variable>
        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>        <!--idioma fin-->
        
      
      <xsl:choose>
        <xsl:when test="//SESION_CADUCADA">
              <xsl:apply-templates select="//SESION_CADUCADA"/>    
        </xsl:when>
        <xsl:when test="//xsql-error">
             <xsl:apply-templates select="//xsql-error"/>
           </xsl:when>
        <xsl:otherwise>
	    <!-- Titulo -->
		<form action="http://www.newco.dev.br/Administracion/Mantenimiento/TablasAuxiliares/EquivalenciasERP.xsql" name="Form" method="POST">
		<input type="hidden" name="ACCION"/>
		<input type="hidden" name="PARAMETROS"/>

		<!--	Titulo de la página		-->
		<div class="ZonaTituloPagina">
			<p class="Path"><xsl:value-of select="document($doc)/translation/texts/item[@name='Inicio']/node()"/>&nbsp;/&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Tablas_auxiliares']/node()"/>&nbsp;/&nbsp;<span class="FinPath"><xsl:value-of select="document($doc)/translation/texts/item[@name='Equivalencias_ERP']/node()"/></span></p>
			<p class="TituloPagina">
      			<xsl:choose>
        		<xsl:when test="/EquivalenciasERP/FORMASYPLAZOSDEPAGO/MENSAJE != ''">
					<xsl:value-of select="/EquivalenciasERP/FORMASYPLAZOSDEPAGO/MENSAJE"/>
        		</xsl:when>
        		<xsl:otherwise>
					<xsl:value-of select="document($doc)/translation/texts/item[@name='Equivalencias_ERP']/node()"/>
        		</xsl:otherwise>
      			</xsl:choose>
				<span class="CompletarTitulo">
					<a class="btnNormal" style="text-decoration:none;">
						<xsl:attribute name="href">javascript:DescargarExcel();</xsl:attribute>
						<img src="http://www.newco.dev.br/images/iconoExcel.gif">
							<xsl:attribute name="alt"><xsl:value-of select="document($doc)/translation/texts/item[@name='listado_excel']/node()"/></xsl:attribute>
							<xsl:attribute name="title"><xsl:value-of select="document($doc)/translation/texts/item[@name='listado_excel']/node()"/></xsl:attribute>
						</img>
					</a>
					&nbsp;
					<a class="btnNormal" href="http://www.newco.dev.br/Administracion/Mantenimiento/TablasAuxiliares/FormasDePago.xsql">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='Formas_de_pago']/node()"/>
					</a>
					&nbsp;
					<a class="btnNormal" href="http://www.newco.dev.br/Administracion/Mantenimiento/TablasAuxiliares/PlazosDePago.xsql">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='Plazos_de_pago']/node()"/>
					</a>
					&nbsp;
					<a class="btnNormal" href="http://www.newco.dev.br/Administracion/Mantenimiento/TablasAuxiliares/OtrasTablas.xsql">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='Otras_tablas_ERP']/node()"/>
					</a>
					&nbsp;
				</span>
			</p>
		</div>
		<br/>
		<br/>
		<br/>
        <table class="buscador" style="width:1200px;margin-left:auto;margin-right:auto;">
            <tr class="SinLinea">
				<th colspan="5">
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='Cliente']/node()"/></label>:&nbsp;
				<xsl:call-template name="desplegable">
					<xsl:with-param name="path" select="/EquivalenciasERP/FORMASYPLAZOSDEPAGO/CENTROSINTEGRADOS/field"/>
					<!--<xsl:with-param name="claSel">muygrande</xsl:with-param>-->
					<xsl:with-param name="style">width:600px;</xsl:with-param>
					<xsl:with-param name="onChange">javascript:selCentroChange();</xsl:with-param>
				</xsl:call-template>
				</th>
				<th colspan="1">&nbsp;</th>
            </tr>
            <tr class="SinLinea">
            </tr>
            <tr class="subTituloTabla">	
				<th class="uno">&nbsp;</th>
				<td class="textLeft cinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='codigo']/node()"/></td>
				<td class="textLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='Descripcion_ERP']/node()"/></td>
				<td class="textLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='forma_de_pago']/node()"/></td>
				<td class="textLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='plazo_de_pago']/node()"/></td>
				<th class="uno"><xsl:value-of select="document($doc)/translation/texts/item[@name='borrar']/node()"/></th>
			</tr>
        	<xsl:choose>
        		<xsl:when test="/EquivalenciasERP/FORMASYPLAZOSDEPAGO/FORMAYPLAZODEPAGO">
	       			<xsl:for-each select="/EquivalenciasERP/FORMASYPLAZOSDEPAGO/FORMAYPLAZODEPAGO">
                	<tr>
						<td>&nbsp;</td>
						<td class="textLeft">
							<xsl:value-of select="CODIGOCLIENTE"/>
						</td>
						<td class="textLeft">
							<xsl:value-of select="DESCRIPCION"/>
						</td>
						<td class="textLeft">
							(<xsl:value-of select="FP_ID"/>)&nbsp;<xsl:value-of select="FP_DESCRIPCION"/>
						</td>
						<td class="textLeft">
							(<xsl:value-of select="PP_ID"/>)&nbsp;<xsl:value-of select="PP_DESCRIPCION"/>
						</td>
						<td>
                    		<a href="javascript:Borrar({ID})">
                        		<img src="/images/2017/trash.png"/>
                    		</a>
						</td>
                	</tr>
					</xsl:for-each> 
       			</xsl:when>
       			<xsl:otherwise>
            		<tr class="SinLinea">
						<td colspan="6"><xsl:value-of select="document($doc)/translation/texts/item[@name='no_se_han_encontrado_resultados']/node()"/>&nbsp;</td>
            		</tr>
       			</xsl:otherwise>
   			</xsl:choose>
		</table>
		<br/>
		<br/>
        <table class="buscador" style="width:1200px;margin-left:auto;margin-right:auto;">
            <tr class="SinLinea">
				<td>&nbsp;</td>
				<td class="textLeft">
					<input type="text" name="CODIGO"/>
				</td>
				<td class="textLeft">
					<input type="text" class="grande" name="DESCRIPCION"/>
				</td>
				<td class="textLeft">
					<xsl:call-template name="desplegable">
						<xsl:with-param name="path" select="/EquivalenciasERP/FORMASYPLAZOSDEPAGO/FORMAPAGO/field"/>
					</xsl:call-template>
				</td>
				<td class="textLeft">
					<xsl:call-template name="desplegable">
						<xsl:with-param name="path" select="/EquivalenciasERP/FORMASYPLAZOSDEPAGO/PLAZOPAGO/field"/>
					</xsl:call-template>
				</td>
				<td>
                    <a class="btnDestacado" href="javascript:Insertar();">
                        <xsl:value-of select="document($doc)/translation/texts/item[@name='insertar']/node()"/>
                    </a>
				</td>
             </tr>
            <tr class="SinLinea">
				<br/>
				<br/>
            </tr>
            <tr class="subTituloTabla">
				<td class="textCenter" colspan="6">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='Carga_desde_fichero']/node()"/>
				</td>
            </tr>
            <tr class="SinLinea">
				<br/>
            </tr>
			<tr class="sinLinea">
				<td class="labelRight" colspan="2">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='fichero']/node()"/>:&nbsp;
				</td>
				<td class="textLeft" colspan="3">
					<input type="hidden" name="IDPROVEEDOR" id="IDPROVEEDOR" value="1"/>
					<input type="hidden" name="CADENA_DOCUMENTOS"/>
					<input type="hidden" name="DOCUMENTOS_BORRADOS"/>
					<input type="hidden" name="BORRAR_ANTERIORES"/>
					<input type="hidden" name="REMOVE" value="Eliminar"/>
					<input class="muygrande" id="inputFile" name="inputFile" type="file" onChange="EnviarFichero(this.files);"/>
				</td>
			</tr>
            <tr class="SinLinea">
            </tr>
            <tr class="SinLinea">
				<td class="textCenter" colspan="6">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='Estructura_carga_equivalencias']/node()"/>
				</td>
            </tr>
            <tr class="SinLinea">
            </tr>
			<tr class="sinLinea">
        		<td colspan="4">
					<div style="text-align:left;">
						<table class="buscador">
							<tr class="sinLinea">
								<td class="textLeft">
									&nbsp;&nbsp;&nbsp;<textarea name="TXT_EQUIVALENCIAS" id="TXT_EQUIVALENCIAS" cols="70" rows="20" wrap="off"/>
								</td>
								<td class="textLeft">
 									&nbsp;&nbsp;&nbsp;<a id="btnMantenEquivalencias" class="btnDestacado" href="javascript:MantenEquivalenciasTXT();"><xsl:value-of select="document($doc)/translation/texts/item[@name='enviar']/node()"/></a>
								</td>
							</tr>
						</table>
        			</div>
        		</td>
        		<td style="width:20px;">
            		&nbsp;
        		</td>
        		<td style="width:*;">
					<div style="text-align:left;"><p id="infoProgreso"></p></div>
					<div id="infoErrores" style="text-align:left;color:red;display:none;"></div>
        		</td>
        		<td>
            		&nbsp;
        		</td>
    		</tr>
	    </table>
		<br/>
		<br/>
		<br/>
		</form>
        <form name="MensajeJS">
			<input type="hidden" name="SEGURO_BORRAR" value="{document($doc)/translation/texts/item[@name='seguro_de_borrar_registro']/node()}"/>
        </form>
		</xsl:otherwise>
      </xsl:choose> 
      </body>
    </html>
  </xsl:template>  
</xsl:stylesheet>
