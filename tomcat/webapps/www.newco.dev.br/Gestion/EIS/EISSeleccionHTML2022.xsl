<?xml version="1.0" encoding="iso-8859-1" ?>
<!--
	Creación de selecciones/agrupaciones de centros/empresas. Nuevo disenno 2022
	Se utilizará en filtros, al crear licitaciones, etc
	
	Ultima revisión: ET 20mar23 11:15 EISSeleccion2022_090323.js
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
            <xsl:when test="/EISSeleccion/LANG"><xsl:value-of select="/EISSeleccion/LANG" /></xsl:when>
            <xsl:otherwise>spanish</xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>        <!--idioma fin-->

	<title><xsl:value-of select="/EISSeleccion/SELECCION/EMPRESA"/>:&nbsp;
		<xsl:choose>
       	<xsl:when test="/EISSeleccion/SELECCION/EIS_SEL_NOMBRE">
			<xsl:value-of select="/EISSeleccion/SELECCION/EIS_SEL_NOMBRE"/>
		</xsl:when>
		<xsl:otherwise>
			<xsl:value-of select="document($doc)/translation/texts/item[@name='nueva_seleccion']/node()"/>
		</xsl:otherwise>
		</xsl:choose>
	</title>

	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->

	<script src="http://www.newco.dev.br/General/jquery-3.6.0.js"></script>	
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic2022_010822.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/descargas_151117.js"></script>		<!-- Para descargas excel	-->
    <script type="text/javascript" src="http://www.newco.dev.br/Gestion/EIS/EISSeleccion2022_090323.js"></script>

    <script type="text/javascript">
		var strID='<xsl:value-of select="document($doc)/translation/texts/item[@name='id']/node()"/>';
		var strNombre='<xsl:value-of select="document($doc)/translation/texts/item[@name='nombre']/node()"/>';
		
		var Empresas=[];
		<xsl:for-each select="/EISSeleccion/SELECCION/EMPRESAS/field/dropDownList/listElem">
			var Empresa=[];
			
			Empresa["ID"]="<xsl:value-of select="ID"/>";
			Empresa["Nombre"]="<xsl:value-of select="listItem"/>";
			Empresa["Sel"]='N';
			
			Empresas.push(Empresa);
		</xsl:for-each>
		console.log('Empresas:'+Empresas.length);	

		var Centros=[];
		<xsl:for-each select="/EISSeleccion/SELECCION/CENTROS/field/dropDownList/listElem">
			var Centro=[];
			
			Centro["ID"]="<xsl:value-of select="ID"/>";
			Centro["Nombre"]="<xsl:value-of select="listItem"/>";
			Centro["Sel"]='N';
			
			Centros.push(Centro);
		</xsl:for-each>
		console.log('Centros:'+Centros.length);	

		var Proveedores=[];
		<xsl:for-each select="/EISSeleccion/SELECCION/PROVEEDORES/field/dropDownList/listElem">
			var Proveedor=[];
			
			Proveedor["ID"]="<xsl:value-of select="ID"/>";
			Proveedor["Nombre"]="<xsl:value-of select="listItem"/>";
			Proveedor["Sel"]='N';
			
			Proveedores.push(Proveedor);
		</xsl:for-each>
		console.log('Proveedores:'+Proveedores.length);	

		var TiposDoc=[];
		<xsl:for-each select="/EISSeleccion/SELECCION/TIPOSDOCUMENTOS/field/dropDownList/listElem">
			var TipoDoc=[];
			
			TipoDoc["ID"]="<xsl:value-of select="ID"/>";
			TipoDoc["Nombre"]="<xsl:value-of select="listItem"/>";
			TipoDoc["Sel"]='N';
			
			TiposDoc.push(TipoDoc);
		</xsl:for-each>
		console.log('TiposDoc:'+TiposDoc.length);	

		//	Cadena con todos los registros seleccionados
		var idRegistros=[];
		<xsl:for-each select="/EISSeleccion/SELECCION/REGISTROS/REGISTRO">
			idRegistros.push("<xsl:value-of select="EIS_SELD_VALOR" />");
		</xsl:for-each>
		console.log('idRegistros:'+idRegistros.length);	

        var sincroErrorPerfil = '<xsl:value-of select="document($doc)/translation/texts/item[@name='sincronizacion_error_perfil']/node()"/>';
        var sincroOkPerfil = '<xsl:value-of select="document($doc)/translation/texts/item[@name='sincronizacion_ok_perfil']/node()"/>';
        var refYaInsertada = '<xsl:value-of select="document($doc)/translation/texts/item[@name='ref_ya_insertada']/node()"/>';
        var nombreObli = '<xsl:value-of select="document($doc)/translation/texts/item[@name='nombre_obli_seleccion']/node()"/>';
        var tipoObli = '<xsl:value-of select="document($doc)/translation/texts/item[@name='tipo_obli_seleccion']/node()"/>';
        var elementosObli = '<xsl:value-of select="document($doc)/translation/texts/item[@name='elementos_obli_seleccion']/node()"/>';
        var strRegistrosIncluidos = '<xsl:value-of select="document($doc)/translation/texts/item[@name='Registros_incluidos']/node()"/>';
    </script>

      </head>
      <body onLoad="javascript:onLoad();">
      <!--idioma-->
        <xsl:variable name="lang">
        <xsl:choose>
            <xsl:when test="/EISSeleccion/LANG"><xsl:value-of select="/EISSeleccion/LANG" /></xsl:when>
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

		<!--	Titulo de la página		-->
		<div class="ZonaTituloPagina">
			<p class="TituloPagina">
				<xsl:choose>
       			<xsl:when test="/EISSeleccion/SELECCION/EIS_SEL_NOMBRE">
					<xsl:value-of select="/EISSeleccion/SELECCION/EIS_SEL_NOMBRE"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="document($doc)/translation/texts/item[@name='nueva_seleccion']/node()"/>
				</xsl:otherwise>
				</xsl:choose>
				<span class="CompletarTitulo400">
					<a class="btnNormal" href="javascript:Salir();">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='salir']/node()"/>
					</a>&nbsp;
					<a class="btnDestacado" href="javascript:Guardar();">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='guardar']/node()"/>
					</a>&nbsp;
					<a class="btnNormal" href="javascript:DescargarExcel();"><xsl:value-of select="document($doc)/translation/texts/item[@name='CSV']/node()"/></a>&nbsp;
				</span>
			</p>
		</div>
		<form class="formEstrecho" action="http://www.newco.dev.br/Gestion/EIS/EISSeleccion2022.xsql" name="Seleccion" method="POST">
			<input type="hidden" name="ACCION"/>
			<input type="hidden" name="IDSELECCION" value="{/EISSeleccion/SELECCION/EIS_SEL_ID}"/>
			<input type="hidden" name="IDUSUARIO"/>
            <input type="hidden" name="IDSELECCION" id="IDSELECCION" value="{/EISSeleccion/SELECCION/EIS_SEL_ID}"/>
            <input type="hidden" name="EXCLUIR" id="EXCLUIR"/>
            <input type="hidden" name="PUBLICO" id="PUBLICO"/>
            <input type="hidden" name="TODOS_ADMIN" id="TODOS_ADMIN"/>
            <input type="hidden" name="AUTORIZADOS" id="AUTORIZADOS"/>
            <input type="hidden" name="EXCLUIDOS" id="EXCLUIDOS"/>
			
			<input type="hidden" name="LISTAREGISTROS" id="LISTAREGISTROS" value=""/><!--	Lista de registros seleccionados	-->
			<div class="divLeftw w250px">
        		<ul>
				<xsl:choose>
				<xsl:when test="/EISSeleccion/SELECCION/LISTAEMPRESAS">
					<li>
                    <label><xsl:value-of select="document($doc)/translation/texts/item[@name='empresa']/node()"/>:&nbsp;</label>
		    		<xsl:call-template name="desplegable">
						<xsl:with-param name="path" select="/EISSeleccion/SELECCION/LISTAEMPRESAS/field"/>
						<xsl:with-param name="nombre">IDEMPRESA</xsl:with-param>
						<xsl:with-param name="id">IDEMPRESA</xsl:with-param>
						<xsl:with-param name="claSel">w220px</xsl:with-param>
					</xsl:call-template>
					</li>
				</xsl:when>
				<xsl:otherwise>
           				<input type="hidden" name="IDEMPRESA" id="IDEMPRESA" value="{/EISSeleccion/SELECCION/EIS_SEL_IDEMPRESA}"/>
				</xsl:otherwise>
				</xsl:choose>
				<li>
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='nombre']/node()"/>:&nbsp;</label>
                	<input class="campopesquisa w220px" type="text" name="SEL_NOMBRE" id="SEL_NOMBRE" value="{/EISSeleccion/SELECCION/EIS_SEL_NOMBRE}"/>
				</li>
				<li>
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='nombre_corto']/node()"/>:&nbsp;</label>
                	<input class="campopesquisa w220px" name="SEL_NOMBRECORTO" id="SEL_NOMBRECORTO" value="{/EISSeleccion/SELECCION/EIS_SEL_NOMBRECORTO}"/>
				</li>
				<li>
                    <label><xsl:value-of select="document($doc)/translation/texts/item[@name='tipo']/node()"/>:&nbsp;</label>
		    		<xsl:call-template name="desplegable">
						<xsl:with-param name="path" select="/EISSeleccion/SELECCION/TIPOS/field"/>
						<xsl:with-param name="nombre">IDTIPO</xsl:with-param>
						<xsl:with-param name="id">IDTIPO</xsl:with-param>
						<xsl:with-param name="onChange">javascript:MostrarTipoSel();</xsl:with-param>
						<xsl:with-param name="claSel">w220px</xsl:with-param>
					</xsl:call-template>
				</li>
				<li>
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='categoria']/node()"/>:&nbsp;</label>
		    		<xsl:call-template name="desplegable">
						<xsl:with-param name="path" select="/EISSeleccion/SELECCION/CLASIFICACIONES/field"/>
						<xsl:with-param name="nombre">IDCLASIFICACION</xsl:with-param>
						<xsl:with-param name="id">IDCLASIFICACION</xsl:with-param>
						<xsl:with-param name="claSel">w220px</xsl:with-param>
						<xsl:with-param name="onChange">javascript:CambioClasificacion();</xsl:with-param>
					</xsl:call-template>
				</li>
				<li id="liTipoDoc">
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='Tipos_documentos']/node()"/>:&nbsp;</label>
		    		<xsl:call-template name="desplegable">
						<xsl:with-param name="path" select="/EISSeleccion/SELECCION/IDSELTIPOSDOCUMENTOS/field"/>
						<xsl:with-param name="nombre">IDSELTIPOSDOCUMENTOS</xsl:with-param>
						<xsl:with-param name="id">IDSELTIPOSDOCUMENTOS</xsl:with-param>
						<xsl:with-param name="claSel">w220px</xsl:with-param>
						<xsl:with-param name="onChange">javascript:CambioClasificacion();</xsl:with-param>
					</xsl:call-template>
				</li>
				<xsl:choose>
				<xsl:when test="/EISSeleccion/SELECCION/ADMINMVM">
					<li>
                        <input type="checkbox" class="muypeq" name="CHK_PUBLICO" id="CHK_PUBLICO" onclick="javascript:chkPublico('CHK_PUBLICO');">
                            <xsl:if test="/EISSeleccion/SELECCION/EIS_SEL_PUBLICO = 'S'"><xsl:attribute name="checked">true</xsl:attribute></xsl:if>
                        </input>
                        <label class="w100px labelCheck"><xsl:value-of select="document($doc)/translation/texts/item[@name='todas_las_empresas']/node()"/></label>
					</li>
					<li>
                        <input type="checkbox" class="muypeq" name="CHK_TODOS_ADMIN" id="CHK_TODOS_ADMIN">
                            <xsl:if test="/EISSeleccion/SELECCION/EIS_SEL_TODOSLOSADMIN = 'S'"><xsl:attribute name="checked">true</xsl:attribute></xsl:if>
                        </input>
                        <label class="w100px labelCheck"><xsl:value-of select="document($doc)/translation/texts/item[@name='todos_los_admin']/node()"/></label>
					</li>
					<li>
                        <input type="checkbox" class="muypeq" name="CHK_AUTORIZADOS" id="CHK_AUTORIZADOS" onclick="javascript:AutorizadosYExcluidos('CHK_AUTORIZADOS');">
                            <xsl:if test="/EISSeleccion/SELECCION/EIS_SEL_AUTORIZADOS = 'S'"><xsl:attribute name="checked">true</xsl:attribute></xsl:if>
                        </input>
                        <label class="w100px labelCheck"><xsl:value-of select="document($doc)/translation/texts/item[@name='AUTORIZADOS']/node()"/></label>
					</li>
					<li>
                        <input type="checkbox" class="muypeq" name="CHK_EXCLUIDOS" id="CHK_EXCLUIDOS" onclick="javascript:AutorizadosYExcluidos('CHK_EXCLUIDOS');">
                            <xsl:if test="/EISSeleccion/SELECCION/EIS_SEL_EXCLUIDOS = 'S'"><xsl:attribute name="checked">true</xsl:attribute></xsl:if>
                        </input>
                        <label class="w100px labelCheck"><xsl:value-of select="document($doc)/translation/texts/item[@name='EXCLUIDOS']/node()"/></label>
					</li>
					</xsl:when>
					<xsl:otherwise>
						<input type="hidden" name="CHK_TODOS_ADMIN" id="CHK_TODOS_ADMIN" value="" />
						<input type="hidden" name="CHK_AUTORIZADOS" id="CHK_AUTORIZADOS" value="" />
						<input type="hidden" name="CHK_PUBLICO" id="CHK_PUBLICO" value="" />
						<input type="hidden" name="CHK_EXCLUIDOS" id="CHK_EXCLUIDOS" value="" />
					</xsl:otherwise>
					</xsl:choose>
					<li id="liPortalIncluido">
						<label><xsl:value-of select="document($doc)/translation/texts/item[@name='Portal_incluido']/node()"/>:&nbsp;</label>
		    			<xsl:call-template name="desplegable">
							<xsl:with-param name="path" select="/EISSeleccion/SELECCION/IDPORTALINCLUIR/field"/>
							<xsl:with-param name="nombre">IDPORTALINCLUIR</xsl:with-param>
							<xsl:with-param name="id">IDPORTALINCLUIR</xsl:with-param>
							<xsl:with-param name="style">font-size:12px;width:220px;</xsl:with-param>
							<xsl:with-param name="onChange">javascript:chPortalIncluido();</xsl:with-param>
						</xsl:call-template>
					</li>
					<li id="liPortalExcluido">
						<label><xsl:value-of select="document($doc)/translation/texts/item[@name='Portal_excluido']/node()"/>:&nbsp;</label>
		    			<xsl:call-template name="desplegable">
							<xsl:with-param name="path" select="/EISSeleccion/SELECCION/IDPORTALEXCLUIR/field"/>
							<xsl:with-param name="nombre">IDPORTALEXCLUIR</xsl:with-param>
							<xsl:with-param name="id">IDPORTALEXCLUIR</xsl:with-param>
							<xsl:with-param name="style">font-size:12px;width:220px;</xsl:with-param>
							<xsl:with-param name="onChange">javascript:chPortalExcluido();</xsl:with-param>
						</xsl:call-template>
					</li>
					
				</ul>
			</div>
			<div class="divLeftw w1000px">
				<br/>
				<br/>
				<br/>
				<br/>
            	<table id="nuevaSeleccion" style="display:;">
                	<tr>
                    	<td>&nbsp;</td>
                    	<td class="labelRight">
							<input type="text" class="w500px campopesquisa" name="FILTRO1" id="FILTRO1" onkeyUp="javascript:Filtro1();" />
                        	<!--empresas-->
                        	<select name="EMPRESAS[]" id="EMPRESAS" multiple="multiple" class="w500px h300px" style="display:none;">
                        	  <xsl:for-each select="/EISSeleccion/SELECCION/EMPRESAS/field/dropDownList/listElem">
                            	  <xsl:if test="ID != ''">
                            	   <option value="{ID}"><xsl:value-of select="listItem" /></option>
                            	  </xsl:if>
                        	  </xsl:for-each>
                        	</select>
                        	<!--centros-->
                        	<select name="CENTROS[]" id="CENTROS" multiple="multiple" class="w500px h300px" style="display:none;">
                        	  <xsl:for-each select="/EISSeleccion/SELECCION/CENTROS/field/dropDownList/listElem">
                            	  <xsl:if test="ID != ''">
                            	   <option value="{ID}"><xsl:value-of select="listItem" /></option>
                            	  </xsl:if>
                        	  </xsl:for-each>
                        	</select>
                        	<!--proveedores-->
                        	<select name="PROVEEDORES[]" id="PROVEEDORES" multiple="multiple" class="w500px h300px" style="display:none;">
                        	  <xsl:for-each select="/EISSeleccion/SELECCION/PROVEEDORES/field/dropDownList/listElem">
                            	  <xsl:if test="ID != ''">
                            	   <option value="{ID}"><xsl:value-of select="listItem" /></option>
                            	  </xsl:if>
                        	  </xsl:for-each>
                        	</select>
                        	<!--tipos documentos-->
                        	<select name="TIPOSDOCUMENTOS[]" id="TIPOSDOCUMENTOS" multiple="multiple" class="w500px h300px" style="display:none;">
                        	  <xsl:for-each select="/EISSeleccion/SELECCION/TIPOSDOCUMENTOS/field/dropDownList/listElem">
                            	  <xsl:if test="ID != ''">
                            	   <option value="{ID}"><xsl:value-of select="listItem" /></option>
                            	  </xsl:if>
                        	  </xsl:for-each>
                        	</select>
							<textarea rows="10" cols="30" name="CODIGOS" id="CODIGOS" class="w500px h300px"/>
                    	</td>
                    	<td class="uno">
                        	<a class="btnDestacado" href="javascript:NuevoElemento();">&nbsp;&gt;&nbsp;<!--<img src="http://www.newco.dev.br/images/flechaGrisDx.gif" alt="añadir"/>--></a>
							<BR/>
							<BR/>
							<BR/>
							<BR/>
							<BR/>
							<BR/>
							<BR/>
							<BR/>
							<BR/>
                        	<a class="btnDestacado" href="javascript:AnadirEmpresaPorCod();">&nbsp;&gt;&nbsp;<!--<img src="http://www.newco.dev.br/images/flechaGrisDx.gif" alt="añadir"/>--></a>
                    	</td>
                    	<td class="uno">
                        	<a class="btnDestacado" href="javascript:QuitarElemento();">&nbsp;&lt;&nbsp;<!--<img src="http://www.newco.dev.br/images/flechaGrisSx.gif" alt="quitar"/>--></a>
                    	</td>
                    	<td class="datosLeft">
							<input type="text" class="w500px campopesquisa" name="FILTRO2" id="FILTRO2" onkeyUp="javascript:Filtro2();"/>
                        	<select name="REGISTRO_SEL[]" id="REGISTRO_SEL" multiple="multiple" class="w500px h300px" >
                        		<xsl:for-each select="/EISSeleccion/SELECCION/REGISTROS/REGISTRO">
                            	   <option value="{EIS_SELD_VALOR}"><xsl:value-of select="NOMBRECONNIF" /></option>
                        		</xsl:for-each>
							</select>

                    	</td>
                    	<td colspan="5">&nbsp;</td>
                	</tr>
            	 </table>
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
