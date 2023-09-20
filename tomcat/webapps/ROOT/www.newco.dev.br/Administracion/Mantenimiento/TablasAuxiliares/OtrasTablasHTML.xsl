<?xml version="1.0" encoding="iso-8859-1" ?>
<!--	
	Mantenimiento de otras tablas auxiliareas, para usuarios MVM
	Ultima revision: ET 21ene20 09:25 OtrasTablas_21ene20.js
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
            <xsl:when test="/TablasAuxiliaresERP/LANG"><xsl:value-of select="/TablasAuxiliaresERP/LANG" /></xsl:when>
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
		<script type="text/javascript" src="http://www.newco.dev.br/Administracion/Mantenimiento/TablasAuxiliares/OtrasTablas_21ene20.js"></script>
        <script type="text/javascript">
			var str_FicheroProcesado= '<xsl:value-of select="document($doc)/translation/texts/item[@name='Fichero_Procesado']/node()"/>';
			var str_FicheroYaEnviado= '<xsl:value-of select="document($doc)/translation/texts/item[@name='Fichero_ya_enviado']/node()"/>';	
			var str_ErrorDesconocidoCreandoFichero= '<xsl:value-of select="document($doc)/translation/texts/item[@name='Error_desconocido_creando_fichero']/node()"/>';	

			var strTipoObligatorio='<xsl:value-of select="document($doc)/translation/texts/item[@name='Tipo_obligatorio']/node()"/>';
			var strCodigoMVMObligatorio='<xsl:value-of select="document($doc)/translation/texts/item[@name='Codigo_MVM_obligatorio']/node()"/>';
			var strCodigoERPObligatorio='<xsl:value-of select="document($doc)/translation/texts/item[@name='Codigo_ERP_obligatorio']/node()"/>';

			var str_ErrSubirRegistro= '<xsl:value-of select="document($doc)/translation/texts/item[@name='err_subir_registro']/node()"/>';	
			var str_NoPodidoIncluirRegistro= '<xsl:value-of select="document($doc)/translation/texts/item[@name='err_subir_registro']/node()"/>';	
			var str_AvisoBorrar= '<xsl:value-of select="document($doc)/translation/texts/item[@name='seguro_de_borrar_registro']/node()"/>';	
			
			var IDUsuario=<xsl:value-of select="/TablasAuxiliaresERP/TABLASAUXILIARES/IDUSUARIO"/>;
			var IDEmpresaOr=<xsl:value-of select="/TablasAuxiliaresERP/TABLASAUXILIARES/IDEMPRESA"/>;
			var IDCentroOr=<xsl:value-of select="/TablasAuxiliaresERP/TABLASAUXILIARES/IDCENTRO"/>;
			<!--
			//	Array de centros, para construir el desplegable en funci�n de la empresa
			var arrCentros	= new Array();
			<xsl:for-each select="/TablasAuxiliaresERP/TABLASAUXILIARES/CENTROSINTEGRADOS/field/dropDownList/listElem">
				var items		= [];
				items['ID']			= '<xsl:value-of select="ID"/>';
				items['IDEmpresa']	= '<xsl:value-of select="IDEMPRESA"/>';
				items['Nombre']		= '<xsl:value-of select="listItem"/>';
				arrCentros.push(items);
			</xsl:for-each>
			-->
		</script>
      </head>
      <body>   
      <!--idioma-->
         <xsl:variable name="lang">
        <xsl:choose>
            <xsl:when test="/TablasAuxiliaresERP/LANG"><xsl:value-of select="/TablasAuxiliaresERP/LANG" /></xsl:when>
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
		<form action="http://www.newco.dev.br/Administracion/Mantenimiento/TablasAuxiliares/OtrasTablas.xsql" name="Form" method="POST">
		<input type="hidden" name="ACCION"/>
		<input type="hidden" name="PARAMETROS"/>

		<!--	Titulo de la p�gina		-->
		<div class="ZonaTituloPagina">
			<p class="Path"><xsl:value-of select="document($doc)/translation/texts/item[@name='Inicio']/node()"/>&nbsp;/&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Tablas_auxiliares']/node()"/>&nbsp;/&nbsp;<span class="FinPath"><xsl:value-of select="document($doc)/translation/texts/item[@name='Otras_tablas_ERP']/node()"/></span></p>
			<p class="TituloPagina">
      			<xsl:choose>
        		<xsl:when test="/TablasAuxiliaresERP/OtrasTablasERP/MENSAJE != ''">
					<xsl:value-of select="/TablasAuxiliaresERP/TABLASAUXILIARES/MENSAJE"/>
        		</xsl:when>
        		<xsl:otherwise>
					<xsl:value-of select="document($doc)/translation/texts/item[@name='Otras_tablas_ERP']/node()"/>
        		</xsl:otherwise>
      			</xsl:choose>
				<span class="CompletarTitulo">
					<a class="btnNormal" href="http://www.newco.dev.br/Administracion/Mantenimiento/TablasAuxiliares/PlazosDePago.xsql">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='Plazos_de_pago']/node()"/>
					</a>
					&nbsp;
					<a class="btnNormal" href="http://www.newco.dev.br/Administracion/Mantenimiento/TablasAuxiliares/FormasDePago.xsql">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='Formas_de_pago']/node()"/>
					</a>
					&nbsp;
					<a class="btnNormal" href="http://www.newco.dev.br/Administracion/Mantenimiento/TablasAuxiliares/EquivalenciasERP.xsql">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='Equivalencias_ERP']/node()"/>
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
				<th colspan="3">
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='empresa']/node()"/></label>:&nbsp;
				<xsl:call-template name="desplegable">
					<xsl:with-param name="path" select="/TablasAuxiliaresERP/TABLASAUXILIARES/EMPRESASINTEGRADAS/field"/>
					<xsl:with-param name="claSel">muygrande</xsl:with-param>
					<xsl:with-param name="style">width:300px;</xsl:with-param>
					<xsl:with-param name="onChange">javascript:selEmpresaChange();</xsl:with-param>
				</xsl:call-template>
				</th>
				<th colspan="3">
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='centro']/node()"/></label>:&nbsp;
					<xsl:call-template name="desplegable">
						<xsl:with-param name="path" select="/TablasAuxiliaresERP/TABLASAUXILIARES/CENTROSINTEGRADOS/field"/>
						<xsl:with-param name="claSel">muygrande</xsl:with-param>
						<xsl:with-param name="style">width:300px;</xsl:with-param>
						<xsl:with-param name="onChange">javascript:selCentroChange();</xsl:with-param>
					</xsl:call-template>
				</th>
            </tr>
            <tr class="SinLinea">
            </tr>
            <tr class="subTituloTabla">	
				<th class="uno">&nbsp;</th>
				<td class="textLeft veinte"><xsl:value-of select="document($doc)/translation/texts/item[@name='tipo']/node()"/></td>
				<td class="textLeft veinte"><xsl:value-of select="document($doc)/translation/texts/item[@name='Codigo_MVM']/node()"/></td>
				<td class="textLeft	veinte"><xsl:value-of select="document($doc)/translation/texts/item[@name='Codigo_ERP']/node()"/></td>
				<td class="textLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='centro']/node()"/></td>
				<th class="uno"><xsl:value-of select="document($doc)/translation/texts/item[@name='borrar']/node()"/></th>
			</tr>
        	<xsl:choose>
        		<xsl:when test="/TablasAuxiliaresERP/TABLASAUXILIARES/REGISTROS/REGISTRO">
	       			<xsl:for-each select="/TablasAuxiliaresERP/TABLASAUXILIARES/REGISTROS/REGISTRO">
                	<tr>
						<td>&nbsp;</td>
						<td class="textLeft">
							<xsl:value-of select="TIPO"/>
						</td>
						<td class="textLeft">
							<xsl:value-of select="CODIGOMVM"/>
						</td>
						<td class="textLeft">
							<xsl:value-of select="CODIGOERP"/>
						</td>
						<td class="textLeft">
							<xsl:value-of select="CENTRO"/>
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
            <tr class="SinLinea">
				<br/>
				<br/>
            </tr>
            <tr class="SinLinea">
				<td>&nbsp;</td>
				<td class="textLeft">
					<xsl:call-template name="desplegable">
						<xsl:with-param name="path" select="/TablasAuxiliaresERP/TABLASAUXILIARES/TIPOS/field"/>
					</xsl:call-template>
				</td>
				<td class="textLeft">
					<input type="text" name="CODIGOMVM"/>
				</td>
				<td class="textLeft">
					<input type="text" name="CODIGOERP"/>
				</td>
				<td>
                    <a class="btnDestacado" href="javascript:Insertar();">
                        <xsl:value-of select="document($doc)/translation/texts/item[@name='insertar']/node()"/>
                    </a>
				</td>
             </tr>
		</table>
		<br/>
		<br/>
        <table class="buscador" style="width:1200px;margin-left:auto;margin-right:auto;">
            <tr class="subTituloTabla">
				<td class="textCenter" colspan="7">
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
					<xsl:value-of select="document($doc)/translation/texts/item[@name='Estructura_carga_tablas_auxiliares']/node()"/>
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
									&nbsp;&nbsp;&nbsp;<textarea name="TXT_TABLASAUXILIARES" id="TXT_TABLASAUXILIARES" cols="70" rows="20" wrap="off"/>
								</td>
								<td class="textLeft">
 									&nbsp;&nbsp;&nbsp;<a id="btnMantenTablasAux" class="btnDestacado" href="javascript:MantenTablasAuxTXT();"><xsl:value-of select="document($doc)/translation/texts/item[@name='enviar']/node()"/></a>
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
		</xsl:otherwise>
      </xsl:choose> 
      </body>
    </html>
  </xsl:template>  
</xsl:stylesheet>
