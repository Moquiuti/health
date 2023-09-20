<?xml version="1.0" encoding="iso-8859-1" ?>
<!--	
	Mantenimiento de equivalencias de forma y plazo de pago en plataforma y ERP, para usuarios MVM
	Ultima revision: ET 5set22 12:20 EquivalenciasERP2022_050922.js
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
    	<xsl:when test="/EquivalenciasERP/LANG"><xsl:value-of select="/EquivalenciasERP/LANG" /></xsl:when>
    	<xsl:otherwise>spanish</xsl:otherwise>
    	</xsl:choose>  
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>        <!--idioma fin-->

	<title><xsl:value-of select="document($doc)/translation/texts/item[@name='Tablas_auxiliares']/node()"/>:&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Equivalencias_ERP']/node()"/></title>
	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->  

	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery-3.6.0.js"></script>	
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic2022_010822.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/descargas_151117.js"></script>		<!-- Para descargas excel	-->
	<script type="text/javascript" src="http://www.newco.dev.br/Administracion/Mantenimiento/TablasAuxiliares/EquivalenciasERP2022_050922.js"></script>
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
		var alrt_EstaSeguro='<xsl:value-of select="document($doc)/translation/texts/item[@name='seguro_de_borrar_registro']/node()"/>'

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
		<form action="http://www.newco.dev.br/Administracion/Mantenimiento/TablasAuxiliares/EquivalenciasERP2022.xsql" name="Form" method="POST">
		<input type="hidden" name="ACCION"/>
		<input type="hidden" name="PARAMETROS"/>

		<!--	Titulo de la página		-->
		<div class="ZonaTituloPagina">
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
					<a class="btnNormal" href="javascript:DescargarExcel();">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='CSV']/node()"/>
					</a>
					&nbsp;
					<a class="btnNormal" href="http://www.newco.dev.br/Administracion/Mantenimiento/TablasAuxiliares/FormasDePago2022.xsql">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='Formas_de_pago']/node()"/>
					</a>
					&nbsp;
					<a class="btnNormal" href="http://www.newco.dev.br/Administracion/Mantenimiento/TablasAuxiliares/PlazosDePago2022.xsql">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='Plazos_de_pago']/node()"/>
					</a>
					&nbsp;
					<a class="btnNormal" href="http://www.newco.dev.br/Administracion/Mantenimiento/TablasAuxiliares/OtrasTablas2022.xsql">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='Otras_tablas_ERP']/node()"/>
					</a>
					&nbsp;
				</span>
			</p>
		</div>
		<br/>
		<br/>
		<br/>
		<div class="divLeft marginLeft300">
			<label><xsl:value-of select="document($doc)/translation/texts/item[@name='Cliente']/node()"/></label>:&nbsp;
			<xsl:call-template name="desplegable">
				<xsl:with-param name="path" select="/EquivalenciasERP/FORMASYPLAZOSDEPAGO/CENTROSINTEGRADOS/field"/>
				<xsl:with-param name="claSel">w600px</xsl:with-param>
				<xsl:with-param name="onChange">javascript:selCentroChange();</xsl:with-param>
			</xsl:call-template>
			<br/>
			<br/>
		</div>
		<div class="tabela tabela_redonda">
		<table class="w1200px tableCenter" cellspacing="6px" cellpadding="6px">
			<thead class="cabecalho_tabela">
            <tr>	
				<th class="w1px">&nbsp;</th>
				<td class="textLeft w50px"><xsl:value-of select="document($doc)/translation/texts/item[@name='codigo']/node()"/></td>
				<td class="textLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='Descripcion_ERP']/node()"/></td>
				<td class="textLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='forma_de_pago']/node()"/></td>
				<td class="textLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='plazo_de_pago']/node()"/></td>
				<th class="w1px"><xsl:value-of select="document($doc)/translation/texts/item[@name='borrar']/node()"/></th>
			</tr>
			</thead>
			<!--	Cuerpo de la tabla	-->
			<tbody class="corpo_tabela">
        	<xsl:choose>
        		<xsl:when test="/EquivalenciasERP/FORMASYPLAZOSDEPAGO/FORMAYPLAZODEPAGO">
	       			<xsl:for-each select="/EquivalenciasERP/FORMASYPLAZOSDEPAGO/FORMAYPLAZODEPAGO">
					<tr class="conhover">
						<td class="color_status">&nbsp;</td>
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
                        		<img src="http://www.newco.dev.br/images/2022/icones/del.svg"/>
                    		</a>
						</td>
                	</tr>
					</xsl:for-each> 
       			</xsl:when>
       			<xsl:otherwise>
            		<tr>
						<td class="color_status">&nbsp;</td>
						<td colspan="5"><xsl:value-of select="document($doc)/translation/texts/item[@name='no_se_han_encontrado_resultados']/node()"/>&nbsp;</td>
            		</tr>
       			</xsl:otherwise>
   			</xsl:choose>
			</tbody>
			<tfoot class="rodape_tabela">
				<tr><td colspan="6">&nbsp;</td></tr>
			</tfoot>
		</table>
		<br/>
		<br/>
		<table class="w1200px tableCenter" cellspacing="6px" cellpadding="6px">
            <tr>
				<td>&nbsp;</td>
				<td class="textLeft">
					<input type="text" class="campopesquisa w100px" name="CODIGO"/>
				</td>
				<td class="textLeft">
					<input type="text" class="campopesquisa w300px" name="DESCRIPCION"/>
				</td>
				<td class="textLeft">
					<xsl:call-template name="desplegable">
						<xsl:with-param name="path" select="/EquivalenciasERP/FORMASYPLAZOSDEPAGO/FORMAPAGO/field"/>
						<xsl:with-param name="claSel">w300px</xsl:with-param>
					</xsl:call-template>
				</td>
				<td class="textLeft">
					<xsl:call-template name="desplegable">
						<xsl:with-param name="path" select="/EquivalenciasERP/FORMASYPLAZOSDEPAGO/PLAZOPAGO/field"/>
						<xsl:with-param name="claSel">w300px</xsl:with-param>
					</xsl:call-template>
				</td>
				<td class="textLeft">
                    <a class="btnDestacado" href="javascript:Insertar();">
                        <xsl:value-of select="document($doc)/translation/texts/item[@name='insertar']/node()"/>
                    </a>
				</td>
            </tr>
            <tr>
				<br/>
				<br/>
            </tr>
            <tr class="subTituloTabla">
				<td class="textCenter" colspan="6">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='Carga_desde_fichero']/node()"/>
				</td>
            </tr>
            <tr>
				<br/>
            </tr>
			<tr>
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
            <tr>
            </tr>
            <tr>
				<td class="textCenter" colspan="6">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='Estructura_carga_equivalencias']/node()"/>
				</td>
            </tr>
            <tr>
            </tr>
			<tr>
        		<td colspan="4">
					<div class="textLeft">
						<table>
							<tr>
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
        		<td class="w20px">
            		&nbsp;
        		</td>
        		<td style="width:*;">
					<div class="textLeft"><p id="infoProgreso"></p></div>
					<div id="infoErrores" class="textLeft rojo" style="display:none;"></div>
        		</td>
        		<td>
            		&nbsp;
        		</td>
    		</tr>
	    </table>
		<br/>
		<br/>
		<br/>
		<br/>
		<br/>
		<br/>
		<br/>
		<br/>
		<br/>
		</div>
		</form>
		</xsl:otherwise>
      </xsl:choose> 
      </body>
    </html>
  </xsl:template>  
</xsl:stylesheet>
