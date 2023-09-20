<?xml version="1.0" encoding="iso-8859-1" ?>
<!--
	Solicitud de alta / Mantenimiento de Empresa
	Ultima revision: ET 03nov21 09:00 EMPNuevaSimple_081121.js
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href = "http://www.newco.dev.br/General/General.xsl" />
  <xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
  <xsl:param name="lang" select="@lang"/>
  <xsl:template match="/">  
    <html>
      <head> 
      
		<link rel="StyleSheet" type="text/css" href="http://www.newco.dev.br/General/basicMVM2019.css"/>
		<!--style- ->
		<xsl:call-template name="estiloIndip"/>
		<!- -fin de style-->  

		<!--idioma-->
		<xsl:variable name="lang">
		<xsl:choose>
		<xsl:when test="/Empresa/INDEXLANG != ''"><xsl:value-of select="/Empresa/INDEXLANG"/></xsl:when><!-- utilizar INDEXLANG para evitar confusion con la cookie LANG	-->
		<xsl:when test="/Empresa/INDEXLANG ='' and /Empresa/LANG != ''"><xsl:value-of select="/Empresa/LANG"/></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>  
		</xsl:variable>

		<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
		
		<title>
		<xsl:value-of select="document($doc)/translation/texts/item[@name='Form_alta_proveedores']/node()"/><xsl:if test="/Empresa/EMPRESA/EMP_ID">:&nbsp;<xsl:value-of select="/Empresa/EMPRESA/EMP_NOMBRE"/></xsl:if>
		</title>
		
		<!--idioma fin-->
     	<!--fin de style-->  
		<script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"/>
		<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"/>
		<script type="text/javascript">
		<xsl:choose>
		<xsl:when test="/Empresa/EMPRESA/EMP_ID">
		var IDEmpresa=<xsl:value-of select="/Empresa/EMPRESA/EMP_ID"/>;
		var IDSesion=<xsl:value-of select="/Empresa/EMPRESA/SES_ID"/>;
		var Accion='<xsl:value-of select="/Empresa/ACCION"/>';
		</xsl:when>
		<xsl:otherwise>
		var IDEmpresa='';
		var IDSesion='';
		var Accion='';
		</xsl:otherwise>
		</xsl:choose>  
		
		var v_BorrarOfertas='S';
		var v_AdminMVM='N';

		var strCargando='<xsl:value-of select="document($doc)/translation/texts/item[@name='cargando']/node()"/>';
		
		var str_PEDIDO_MINIMO_ACTIVO='<xsl:value-of select="document($doc)/translation/texts/item[@name='pedido_minimo_activo']/node()"/>';
		var str_NO_ACEPTAR_OFERTAS='<xsl:value-of select="document($doc)/translation/texts/item[@name='no_aceptar_ofertas']/node()"/>';

		var str_OBLI_NOMBRE_EMPRESA='<xsl:value-of select="document($doc)/translation/texts/item[@name='obli_nombre_empresa']/node()"/>';
		var str_OBLI_NIF='<xsl:value-of select="document($doc)/translation/texts/item[@name='obli_nif']/node()"/>';
		var str_OBLI_DIRECCION='<xsl:value-of select="document($doc)/translation/texts/item[@name='obli_direccion']/node()"/>';
		var str_OBLI_COD_POSTAL='<xsl:value-of select="document($doc)/translation/texts/item[@name='obli_cod_poostal']/node()"/>';
		var str_OBLI_POBLACION='<xsl:value-of select="document($doc)/translation/texts/item[@name='obli_poblacion']/node()"/>';
		var str_OBLI_TELEFONO='<xsl:value-of select="document($doc)/translation/texts/item[@name='obli_telefono']/node()"/>';
		var str_OBLI_TIPO_EMPRESA='<xsl:value-of select="document($doc)/translation/texts/item[@name='obli_tipo_empresa']/node()"/>';
		var str_OBLI_DEPARTAMENTO='<xsl:value-of select="document($doc)/translation/texts/item[@name='obli_departamento']/node()"/>';
		var str_OBLI_TITULO_USUARIO='<xsl:value-of select="document($doc)/translation/texts/item[@name='obli_titulo_usuario']/node()"/>';
		var str_OBLI_PRIMER_APELLIDO='<xsl:value-of select="document($doc)/translation/texts/item[@name='obli_primer_apellido']/node()"/>';
		var str_OBLI_EMAIL_USUARIO='<xsl:value-of select="document($doc)/translation/texts/item[@name='obli_email_usuario']/node()"/>';
		var str_OBLI_TEL_USUARIO='<xsl:value-of select="document($doc)/translation/texts/item[@name='obli_tel_usuario']/node()"/>';
		var str_OBLI_COMISION_AHORRO='<xsl:value-of select="document($doc)/translation/texts/item[@name='obli_comision_ahorro']/node()"/>';
		var str_OBLI_COMISION_TRANSAC='<xsl:value-of select="document($doc)/translation/texts/item[@name='obli_comision_transac']/node()"/>';
		var str_OBLI_CAMPOS_OBLI='<xsl:value-of select="document($doc)/translation/texts/item[@name='obli_campos_obli']/node()"/>';
		var str_OBLI_NOMBRE_USUARIO='<xsl:value-of select="document($doc)/translation/texts/item[@name='obli_nombre_usuario']/node()"/>';
		var str_FORMATO_NUM_GUION_PARENT='<xsl:value-of select="document($doc)/translation/texts/item[@name='formato_num_guion_parent']/node()"/>';
    	var str_SOLO_NUM_GUIONES_PAR='<xsl:value-of select="document($doc)/translation/texts/item[@name='solo_numeros_guiones_parentesis']/node()"/>';

    	var str_FORMATO_COD_POSTAL='<xsl:value-of select="document($doc)/translation/texts/item[@name='codigo_postal']/node()"/>';
    	var str_FORMATO_TELEFONO='<xsl:value-of select="document($doc)/translation/texts/item[@name='telefono']/node()"/>';
    	var str_FORMATO_TELEFONO_FIJO='<xsl:value-of select="document($doc)/translation/texts/item[@name='telefono_fijo']/node()"/>';
    	var str_FORMATO_FAX='<xsl:value-of select="document($doc)/translation/texts/item[@name='fax']/node()"/>';
    	var str_EL_CAMPO='<xsl:value-of select="document($doc)/translation/texts/item[@name='el_campo']/node()"/>';
		
		var str_OBLI_SELECCION_AREAGEO='<xsl:value-of select="document($doc)/translation/texts/item[@name='obli_selec_areageo']/node()"/>';
		var str_OBLI_SELECCION_CATEGORIA='<xsl:value-of select="document($doc)/translation/texts/item[@name='obli_selec_cat']/node()"/>';
		
		var str_errorCambiarSeleccion='<xsl:value-of select="document($doc)/translation/texts/item[@name='error_cambiar_seleccion']/node()"/>';

		//	Cadenas al incluir/quitar una seleccion
		var str_incluir		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='incluir']/node()"/>';
		var str_quitar		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='quitar']/node()"/>';


		//	Cadenas para DOCUMENTOS. Copiado desde EMPDocs
		var	strEmpresa='<xsl:value-of select="document($doc)/translation/texts/item[@name='empresa']/node()"/>';
		var	strUsuario	='<xsl:value-of select="document($doc)/translation/texts/item[@name='comercial_principal']/node()"/>';
		var	strTelefono='<xsl:value-of select="document($doc)/translation/texts/item[@name='telefono']/node()"/>';
		var	strEmail='<xsl:value-of select="document($doc)/translation/texts/item[@name='email']/node()"/>';
		var	strProvincia='<xsl:value-of select="document($doc)/translation/texts/item[@name='provincia']/node()"/>';
		var strDocumentoBorrado='<xsl:value-of select="document($doc)/translation/texts/item[@name='Documento_borrado']/node()"/>';
		<xsl:choose>
		<xsl:when test="/Docs/EMPRESA/MVM">
			var strCabeceraExcel='<xsl:value-of select="document($doc)/translation/texts/item[@name='Cabecera_CSV_documentos_contacto']/node()"/>';
		</xsl:when>
		<xsl:otherwise>
			var strCabeceraExcel='<xsl:value-of select="document($doc)/translation/texts/item[@name='Cabecera_CSV_documentos']/node()"/>';
		</xsl:otherwise>
   		</xsl:choose>

        var strNombre='<xsl:value-of select="document($doc)/translation/texts/item[@name='nombre']/node()"/>';
        var strCentro='<xsl:value-of select="document($doc)/translation/texts/item[@name='centro']/node()"/>';
        var strUsuario='<xsl:value-of select="document($doc)/translation/texts/item[@name='usuario']/node()"/>';
        var strFecha='<xsl:value-of select="document($doc)/translation/texts/item[@name='fecha']/node()"/>';
        var strVencimiento='<xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_final']/node()"/>';
        var strUsuarioRev='<xsl:value-of select="document($doc)/translation/texts/item[@name='Usuario_revision']/node()"/>';
        var strFechaRev='<xsl:value-of select="document($doc)/translation/texts/item[@name='Fecha_revision']/node()"/>';
        var strBorrar='<xsl:value-of select="document($doc)/translation/texts/item[@name='eliminar']/node()"/>';

        var strDocsObligatorios='<xsl:value-of select="document($doc)/translation/texts/item[@name='Documentos_obligatorios']/node()"/>';
        var strDocsOpcionales='<xsl:value-of select="document($doc)/translation/texts/item[@name='Documentos_opcionales']/node()"/>';
        var strDocNoInformado='<xsl:value-of select="document($doc)/translation/texts/item[@name='Documento_obligatorio_no_informado']/node()"/>';

        var strEmpresaYaExiste='<xsl:copy-of select="document($doc)/translation/texts/item[@name='Empresa_ya_existe']/node()"/>';
		
		//	Monta el array de todas categorias de documentos
		var arrCategorias=[];
		//arrDocs['Categorias']= [];

		</script>
		<!-- para Documentos-->
		<script type="text/javascript" src="http://www.newco.dev.br/General/descargas_151117.js"></script>
		<script type="text/javascript" src="http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPDocs_280721.js"></script>
		<!-- JS se la propia pagina	-->
		<script type="text/javascript" src="http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPNuevaSimple_081121.js"></script>     
      </head>

      <body>
      <xsl:choose>
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
        		<xsl:apply-templates select="Empresa"/> 
        </xsl:otherwise>
        </xsl:choose>	 
      </body>
    </html>
  </xsl:template>

<!--
 |  Templates
 +-->

<xsl:template match="Empresa">

	<!--idioma-->
	<xsl:variable name="lang">
	<xsl:choose>
	<xsl:when test="/Empresa/INDEXLANG != ''"><xsl:value-of select="/Empresa/INDEXLANG"/></xsl:when>
	<xsl:when test="/Empresa/INDEXLANG ='' and /Empresa/LANG != ''"><xsl:value-of select="/Empresa/LANG"/></xsl:when>
	<xsl:otherwise>spanish</xsl:otherwise>
	</xsl:choose>  
	</xsl:variable>

	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>      <!--idioma fin-->

	<!--portal-->
	<xsl:variable name="portal">
		<xsl:choose>
		<xsl:when test="/Empresa/PORTAL != ''"><xsl:value-of select="/Empresa/PORTAL"/></xsl:when>
		<xsl:otherwise>MVM</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<!--portal-->

	<!--	Copiado desde indexHTML.xsl		-->
	<xsl:variable name="AP_Portal">AP_<xsl:value-of select="$portal"/>_Portal</xsl:variable>
	<!--<xsl:variable name="AP_URL">AP_<xsl:value-of select="$portal"/>_URL</xsl:variable>-->
	<xsl:variable name="AP_Logo">AP_<xsl:value-of select="$portal"/>_Logo</xsl:variable>
	<xsl:variable name="AP_PortalLargo">AP_<xsl:value-of select="$portal"/>_PortalLargo</xsl:variable>
	<xsl:variable name="AP_Dominio">AP_<xsl:value-of select="$portal"/>_Dominio</xsl:variable>
  	
	<h1 class="titlePage">   
       <!--<xsl:value-of select="document($doc)/translation/texts/item[@name='nueva_empresa']/node()"/>:&nbsp;
		SES_ID: <xsl:value-of select="EMPRESA/SES_ID"/>. EMP_ID: <xsl:value-of select="EMPRESA/EMP_ID"/><br/><br/><br/>-->
    	<div class="logo" style="width:50%;margin-left:auto;">
			<a>
				<xsl:attribute name="href"><xsl:value-of select="/Empresa/EMPRESA/PMVM_URLSALIDA"/></xsl:attribute>
				<xsl:attribute name="title"><xsl:value-of select="document($doc)/translation/texts/item[@name=$AP_Portal]/node()"/></xsl:attribute>
				<img>
					<xsl:attribute name="src"><xsl:value-of select="document($doc)/translation/texts/item[@name=$AP_Logo]/node()"/></xsl:attribute>
					<xsl:attribute name="alt"><xsl:value-of select="document($doc)/translation/texts/item[@name=$AP_Portal]/node()"/></xsl:attribute>
				</img>
			</a>
		</div>
	</h1>
	
		<br/>
		<br/>
    	<div style="width:30%;margin-left:auto;margin-right:auto;">
		<strong><xsl:value-of select="document($doc)/translation/texts/item[@name='Form_alta_proveedores']/node()"/></strong><br/><br/>
		<xsl:copy-of select="document($doc)/translation/texts/item[@name='Form_alta_proveedores_expli']/node()"/>
		</div>
		<br/>
		<br/>
		<br/>
		
		
	<h2>	
		<xsl:if test="/Empresa/EMPRESA/FASE=1">
   			<div class="menus" style="width:80%;margin-left:auto;">
			1/4.- <xsl:value-of select="document($doc)/translation/texts/item[@name='datos_empresa']/node()"/>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<a class="btnDestacado" href="javascript:GuardaEmpresa('GUARDA');">
            	<xsl:value-of select="document($doc)/translation/texts/item[@name='siguiente']/node()"/>
        	</a>
			</div>
		</xsl:if>
		<xsl:if test="/Empresa/EMPRESA/EMP_ID">
			<br/>
			<br/>
			<xsl:choose>
			<xsl:when test="/Empresa/EMPRESA/EMPRESA_PENDIENTE_APROBACION">
    			<!--<div class="problematicos" style="text-align: center;margin-top:20px;padding:10px 10;margin-left:40%;margin-bottom:50px;margin-top:20px;">-->
    			<div class="problematicos" style="width:30%;text-align:center;padding:10px 10;margin-left:35%;margin-bottom:50px;">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='Datos_registro_enviados']/node()"/>
				</div>
			</xsl:when>
			<xsl:otherwise>
				<!--
    			<div class="menus" style="width:80%;margin-left:auto;">
				<a href="javascript:MostrarDiv('divDatosEmpresa');"><xsl:value-of select="document($doc)/translation/texts/item[@name='datos_empresa']/node()"/></a>
				&nbsp;|&nbsp;<a href="javascript:MostrarDiv('divAreasGeo');"><xsl:value-of select="document($doc)/translation/texts/item[@name='Cobertura_geografica']/node()"/></a>
				&nbsp;|&nbsp;<a href="javascript:MostrarDiv('divCategorias');"><xsl:value-of select="document($doc)/translation/texts/item[@name='Categorias_producto']/node()"/></a>
				&nbsp;|&nbsp;<a href="javascript:MostrarDiv('divDocumentos');"><xsl:value-of select="document($doc)/translation/texts/item[@name='documentos']/node()"/></a>

				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        		<a class="btnDestacado" href="javascript:GuardaEmpresa('ENVIA');">
            		<xsl:value-of select="document($doc)/translation/texts/item[@name='Enviar']/node()"/>
        		</a>
				&nbsp;
				</div>
				-->
				<xsl:if test="/Empresa/EMPRESA/FASE=2">
   					<div class="menus" style="width:80%;margin-left:auto;">
					2/4.- <xsl:value-of select="document($doc)/translation/texts/item[@name='Cobertura_geografica']/node()"/>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<a class="btnDestacado" href="javascript:Atras();">&lt;</a>&nbsp;
					<a class="btnDestacado" href="javascript:GuardaEmpresa('SIGUIENTE');">
            			<xsl:value-of select="document($doc)/translation/texts/item[@name='siguiente']/node()"/>
        			</a>
					</div>
				</xsl:if>
				<xsl:if test="/Empresa/EMPRESA/FASE=3">
   					<div class="menus" style="width:80%;margin-left:auto;">
					3/4.- <xsl:value-of select="document($doc)/translation/texts/item[@name='Categorias_producto']/node()"/>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<a class="btnDestacado" href="javascript:Atras();">&lt;</a>&nbsp;
					<a class="btnDestacado" href="javascript:GuardaEmpresa('SIGUIENTE');">
            			<xsl:value-of select="document($doc)/translation/texts/item[@name='siguiente']/node()"/>
        			</a>
					</div>
				</xsl:if>
				<xsl:if test="/Empresa/EMPRESA/FASE=4">
   					<div class="menus" style="width:80%;margin-left:auto;">
					4/4.- <xsl:value-of select="document($doc)/translation/texts/item[@name='documentos']/node()"/>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<a class="btnDestacado" href="javascript:Atras();">&lt;</a>&nbsp;
					<a class="btnDestacado" href="javascript:GuardaEmpresa('ENVIA');">
            			<xsl:value-of select="document($doc)/translation/texts/item[@name='finalizar_registro']/node()"/>
        			</a>
					</div>
				</xsl:if>
			</xsl:otherwise>
			</xsl:choose>
		</xsl:if>
	</h2>	
	<!--</h1>-->
	<br/>
	<br/>

	<!-- textos de ayuda	-->
	<xsl:if test="/Empresa/EMPRESA/FASE=2">
    	<div style="width:20%;margin-left:auto;margin-right:auto;">
			<xsl:value-of select="document($doc)/translation/texts/item[@name='Ayuda_seleccionar_area_geo']/node()"/>
		</div>
	</xsl:if>
	<!-- textos de ayuda	-->
	<xsl:if test="/Empresa/EMPRESA/FASE=3">
    	<div style="width:20%;margin-left:auto;margin-right:auto;">
			<xsl:value-of select="document($doc)/translation/texts/item[@name='Ayuda_seleccionar_productos']/node()"/>
		</div>
	</xsl:if>
	
	
	<br/>
	<br/>
	
	  
	<form name="MantEmpresaSimple" method="post">
	<input type="hidden" name="ACCION" id="ACCION" value=""/>
	<input type="hidden" name="FASE" id="FASE" value="{/Empresa/EMPRESA/FASE}"/>
	<input type="hidden" name="EMP_ID" id="EMP_ID" value="{/Empresa/EMPRESA/EMP_ID}"/>
	<input type="hidden" name="IDPAIS" id="IDPAIS" value="{/Empresa/IDPAIS}"/>
	<input type="hidden" name="PORTAL" id="PORTAL" value="{/Empresa/PORTAL}"/>
	<input type="hidden" name="INDEXLANG" id="INDEXLANG" value="{/Empresa/INDEXLANG}"/>
	<xsl:apply-templates select="EMPRESA"> 	  
		<xsl:with-param name="doc"><xsl:value-of select="$doc"/></xsl:with-param>
	</xsl:apply-templates>
	</form>
	<xsl:if test="EMPRESA/SELECCIONES_MATERIAL/SELECCIONES">
	<xsl:apply-templates select="EMPRESA/SELECCIONES_MATERIAL/SELECCIONES"> 	  
		<xsl:with-param name="doc"><xsl:value-of select="$doc"/></xsl:with-param>
		<xsl:with-param name="div">divCategorias</xsl:with-param>
		<xsl:with-param name="titulo"><xsl:value-of select="document($doc)/translation/texts/item[@name='Categorias_producto']/node()"/></xsl:with-param>
		<xsl:with-param name="nombrecampo">CAT</xsl:with-param>
	</xsl:apply-templates>
	</xsl:if>
	<xsl:if test="EMPRESA/SELECCIONES_MATERIAL/SELECCIONES">
	<xsl:apply-templates select="EMPRESA/SELECCIONES_AREAGEO/SELECCIONES"> 	  
		<xsl:with-param name="doc"><xsl:value-of select="$doc"/></xsl:with-param>
		<xsl:with-param name="div">divAreasGeo</xsl:with-param>
		<xsl:with-param name="titulo"><xsl:value-of select="document($doc)/translation/texts/item[@name='Cobertura_geografica']/node()"/></xsl:with-param>
		<xsl:with-param name="nombrecampo">AREA</xsl:with-param>
	</xsl:apply-templates>
	</xsl:if>
	<xsl:if test="EMPRESA/DOCUMENTACION/DOCUMENTOS">
	<xsl:apply-templates select="EMPRESA/DOCUMENTACION/DOCUMENTOS"> 	  
		<xsl:with-param name="doc"><xsl:value-of select="$doc"/></xsl:with-param>
		<xsl:with-param name="div">divDocumentos</xsl:with-param>
	</xsl:apply-templates>
	</xsl:if>
	<div id="uploadFrameBox" style="display:none;"><iframe id="uploadFrame" name="uploadFrame" style="width:100%;"></iframe></div>
	<div id="uploadFrameBoxDoc" style="display:none;"><iframe id="uploadFrameDoc" name="uploadFrameDoc" style="width:100%;"></iframe></div>
	
	<div style="width:30%;margin-left:auto;margin-right:auto;">
		<br/><br/><br/><br/>
		<strong><xsl:copy-of select="document($doc)/translation/texts/item[@name='Registro_prov_contactos']/node()"/></strong>
	</div>
</xsl:template>

<xsl:template match="EMPRESA">
    <xsl:param name="doc" />
	<div id="divDatosEmpresa" class="divAvance" style="width:80%;margin-left:auto;">
	<table class="infoTable">
    <tr>
		<td>&nbsp;</td>
		<td colspan="2">
			<xsl:value-of select="document($doc)/translation/texts/item[@name='los_campos_marcados_con']/node()"/>&nbsp;(<span class="camposObligatorios"> * </span>)&nbsp;
			<xsl:value-of select="document($doc)/translation/texts/item[@name='son_obligatorios']/node()"/>
		</td>
		<td>&nbsp;</td>
	</tr>
    
    <!-- DATOS DE EMPRESA -->
    <tr><td colspan="6">&nbsp;</td></tr>	
    <tr> 
      <td class="quince labelRight">
         <xsl:value-of select="document($doc)/translation/texts/item[@name='Razon_social']/node()"/>:<span  class="camposObligatorios" width="1%">*</span>
      </td>
      <td class="datosLeft trenta">  
			<input type="text" size="50" maxlength="100" name="EMP_NOMBRE" value="{EMP_NOMBRE}"/>
      </td>
      <td class="quince labelRight">
         <xsl:value-of select="document($doc)/translation/texts/item[@name='nombre_corto_publico']/node()"/>:<span  class="camposObligatorios" width="1%">*</span>
      </td>
      <td class="datosLeft trenta">  
			<input type="text" size="15" maxlength="30" name="EMP_NOMBRECORTOPUBLICO" value="{EMP_NOMBRECORTOPUBLICO}"/>
      </td>
    </tr>		    		          	          	    
    <tr>
      <td class="labelRight">
         <xsl:value-of select="document($doc)/translation/texts/item[@name='tipo_empresa']/node()"/>:<span  class="camposObligatorios">*</span>
      </td>
      <td class="datosLeft">
          <xsl:call-template name="desplegable">
    	  <xsl:with-param name="path" select="EMP_IDTIPO/field"/>
    	  <xsl:with-param name="style">width:250px</xsl:with-param>
		  <!-- <xsl:copy-of select="EMP_IDTIPO/field"/>-->
    	</xsl:call-template>
      </td>
      <td class="quince labelRight">
         <xsl:value-of select="document($doc)/translation/texts/item[@name='nif']/node()"/>:<span  class="camposObligatorios" width="1%">*</span>
      </td>
      <td class="veintecinco datosLeft">  
		<input type="text" size="20" maxlength="20" name="EMP_NIF" id="EMP_NIF" value="{EMP_NIF}" onblur="javascript:ComprobarNIF();"/>
		<br/>
		<span class="textoComentario">
    	<xsl:value-of select="document($doc)/translation/texts/item[@name='formato_recomendado']/node()"/>
        </span>
      </td>
    </tr>		    		          	          	    
    <tr>
       <td class="labelRight">
         <xsl:value-of select="document($doc)/translation/texts/item[@name='provincia']/node()"/>:<span  class="camposObligatorios">*</span>
      </td>
      <td class="datosLeft">
		<xsl:call-template name="desplegable">
    	  <xsl:with-param name="path" select="EMP_PROVINCIA/field"/>
    	  <xsl:with-param name="style">width:250px</xsl:with-param>
		  <!-- <xsl:copy-of select="EMP_PROVINCIA/field"/>-->
    	</xsl:call-template>
      </td>
       <td class="labelRight">
         <xsl:value-of select="document($doc)/translation/texts/item[@name='poblacion']/node()"/>:<span  class="camposObligatorios">*</span>
      </td> 
      <td class="datosLeft">
			<input type="text" size="25" maxlength="50" name="EMP_POBLACION" value="{EMP_POBLACION}"/> 	     
      </td>
    </tr>	
    <tr>
       <td class="labelRight">
         <xsl:value-of select="document($doc)/translation/texts/item[@name='barrio']/node()"/>:<span  class="camposObligatorios">*</span>
      </td> 
      <td class="datosLeft">
			<input type="text" size="25" maxlength="50" name="EMP_BARRIO" value="{EMP_BARRIO}"/> 	     
      </td>
      <td class="labelRight">
          <xsl:value-of select="document($doc)/translation/texts/item[@name='codigo_postal']/node()"/>:<span  class="camposObligatorios">*</span>
      </td>
      <td class="datosLeft">
		<input type="text" size="25" maxlength="15" name="EMP_CPOSTAL" value="{EMP_CPOSTAL}"/>
      </td>
    </tr>	
    <tr>
       <td class="labelRight">
       		<xsl:value-of select="document($doc)/translation/texts/item[@name='direccion']/node()"/>:<span  class="camposObligatorios">*</span>
      </td>
      <td class="datosLeft">
		<input type="text" size="50" maxlength="100"  name="EMP_DIRECCION" value="{EMP_DIRECCION}"/>               
      </td>
       <td class="labelRight">
         <xsl:value-of select="document($doc)/translation/texts/item[@name='telefono']/node()"/>:<span  class="camposObligatorios">*</span>
      </td>
      <td class="datosLeft">
		<input type="text" size="25" maxlength="50" name="EMP_TELEFONO" value="{EMP_TELEFONO}"/> 	     
      </td>
    </tr> 
    <tr> 
       <td class="labelRight" valign="top">
       		<br/><xsl:value-of select="document($doc)/translation/texts/item[@name='descripcion_comercial']/node()"/>:
      </td>
      <td class="datosLeft"> 
		<textarea name="EMP_REFERENCIAS" cols="60" rows="5"><xsl:value-of select="EMP_REFERENCIAS"/></textarea>
      </td>
      <td class="labelRight">
          <xsl:value-of select="document($doc)/translation/texts/item[@name='importe_minimo_eur']/node()"/>:
      </td>
      <td class="datosLeft">  
			<input type="text" name="EMP_PEDIDOMINIMO" onBlur="checkNumber(this.value, this);" value="{EMP_PEDIDOMINIMO}"/>
      </td>
    </tr>
  </table>
  <br/>
   <!-- USUARIO	-->
   <table class="infoTable" style="width:80%;">
     <tr class="tituloTabla">
        <th colspan="6">
         <xsl:value-of select="document($doc)/translation/texts/item[@name='usuario']/node()"/>
      </th>
    </tr>
    <tr><td colspan="6">&nbsp;</td></tr>
    <tr>
		<td class="labelRight">
			<xsl:value-of select="document($doc)/translation/texts/item[@name='nombre']/node()"/>:<span class="camposObligatorios" width="1%">*</span>
		</td>
		<td class="datosLeft">
			<input type="text" name="US_NOMBRE" maxlength="100" size="20"  value="{US_NOMBRE}"/> 
		</td>
		<td class="labelRight">
			<xsl:value-of select="document($doc)/translation/texts/item[@name='primer_apellido']/node()"/>:<span class="camposObligatorios" width="1%">*</span>
		</td>
		<td class="datosLeft">
			<input type="text" name="US_APELLIDO1" maxlength="100" size="20"  value="{US_APELLIDO1}"/> 
		</td>
		<td class="labelRight">
			<xsl:value-of select="document($doc)/translation/texts/item[@name='e_mail']/node()"/>:<span class="camposObligatorios" width="1%">*</span>
		</td>
		<td class="datosLeft">
			<input type="text" name="US_EMAIL" maxlength="100" size="40"  value="{US_EMAIL}"/> 
		</td>
    </tr>    
    <tr><td colspan="6">&nbsp;</td></tr>
  </table> 
  <!--
	<br/><br/>
	<xsl:if test="not(/Empresa/EMPRESA/EMPRESA_PENDIENTE_APROBACION)">
		<!- - boton para guardar- ->
		<table style="width:50%;">
			<tr align="center">
				<td class="labelRight">
					<a class="btnDestacado" href="javascript:GuardaEmpresa('GUARDA');">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='guardar']/node()"/>
					</a>
				</td>
			</tr>
		</table>  
	</xsl:if> 	  
	<br/><br/>
	-->
</div><!--fin de divLeft-->
</xsl:template><!--fin de template EMPRESA	-->


<!--	Mantenimiento de selecciones	-->
<xsl:template match="SELECCIONES">
    <xsl:param name="doc" />
    <xsl:param name="div" />
    <xsl:param name="titulo" />
    <xsl:param name="nombrecampo" />
	<form name="frm{$nombrecampo}">
	<div id="{$div}" class="divAvance" style="display:none;width:80%;margin-left:auto;">
	<table class="buscador" style="width:1200px;align:center;">
		<tr><td colspan="5">&nbsp;</td></tr>

		<tr class="subTituloTabla">
			<td>&nbsp;</td>
			<td colspan="3" align="left">
				<strong><xsl:value-of select="$titulo"/></strong>
				<!--<xsl:if test="(/Ficha/EMPRESA/MVM or /Ficha/EMPRESA/MVMB) and /Ficha/EMPRESA/ADMIN">
				&nbsp;<a href="javascript:MostrarSelecciones();" style="text-decoration:none;"><img src="http://www.newco.dev.br/images/tabla.gif"/></a>
				</xsl:if>-->
			</td>
			<td>&nbsp;</td>
		</tr>

		<!--nombres columnas, nombre, cargo-->
		<tr>
			<td class="dies">&nbsp;</td>
			<td class="trenta"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='nombre']/node()"/></strong></td>
			<td class="dies"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='estado']/node()"/></strong></td>
			<td>&nbsp;</td>
		</tr>

	<tbody>
	<xsl:for-each select="./SELECCION">
		<tr>
			<td>&nbsp;</td>
			<td align="left"><xsl:value-of select="EIS_SEL_NOMBRE"/></td>
			<td class="estadoSel" style="padding-left:5px;">
				<xsl:choose>
				<xsl:when test="NO_INCLUIDO">
					<a href="javascript:cambiarSeleccion({EIS_SEL_ID},'{$nombrecampo}_{EIS_SEL_ID}');"><img id="img_{EIS_SEL_ID}" src="http://www.newco.dev.br/images/nocheck.gif"/></a>
					<input type="hidden" id="hid_{$nombrecampo}_{EIS_SEL_ID}" name="hid_{$nombrecampo}_{EIS_SEL_ID}" value="N"/>
				</xsl:when>
				<xsl:otherwise>
					<a href="javascript:cambiarSeleccion({EIS_SEL_ID},'{$nombrecampo}_{EIS_SEL_ID}');"><img id="img_{EIS_SEL_ID}" src="http://www.newco.dev.br/images/checkCenter.gif"/></a>
					<input type="hidden" id="hid_{$nombrecampo}_{EIS_SEL_ID}" name="hid_{$nombrecampo}_{EIS_SEL_ID}" value="S"/>
				</xsl:otherwise>
				</xsl:choose>
			</td>
			<td>&nbsp;</td>
		</tr>
	</xsl:for-each>
	</tbody>
	</table>
	</div>
	</form>
</xsl:template>

<!--	Mantenimiento de documentos	-->
<xsl:template match="DOCUMENTOS">
    <xsl:param name="doc" />
    <xsl:param name="div" />
    <xsl:param name="titulo" />
	<div id="{$div}" class="divAvance divLeft" style="display:none">
      <table class="buscador documentos" border="0">
      <form name="SubirDocumentos" method="post">
        <input type="hidden" name="IDPROVEEDOR" id="IDPROVEEDOR" value="{/Empresa/EMPRESA/DOCUMENTACION/EMP_ID}"/>
        <input type="hidden" name="CADENA_DOCUMENTOS" />
        <input type="hidden" name="DOCUMENTOS_BORRADOS" />
        <input type="hidden" name="BORRAR_ANTERIORES" />
        <input type="hidden" name="REMOVE" value="{document($doc)/translation/texts/item[@name='remove']/node()}"/>

        <tr class="sinLinea">
          <!--documentos-->
          <td class="quince"><!--<strong><xsl:value-of select="document($doc)/translation/texts/item[@name='se_permite_cargar_documentos']/node()"/>.</strong>-->&nbsp;</td>
          <td class="labelRight diez">
            	<span class="text"><xsl:value-of select="document($doc)/translation/texts/item[@name='subir_documento']/node()"/>:&nbsp;</span>
          </td>
          <td class="datosLeft cuarenta">
            <div class="altaDocumento">
              <span class="anadirDoc">
                <xsl:call-template name="documentos"><xsl:with-param name="num" select="number(1)"/></xsl:call-template>
              </span>
            </div>
          </td>
          <td class="datosLeft diez">
            <select name="TIPO_DOC" id="TIPO_DOC" class="grande">
            <xsl:for-each select="/Empresa/EMPRESA/DOCUMENTACION/TIPOS_DOCUMENTOS/field/dropDownList/listElem">
              <option value="{ID}"><xsl:value-of select="listItem"/></option>
            </xsl:for-each>
            </select>
          </td>
          <td style="width:200px;">
            <!--<div class="boton">-->
          	<a class="btnDestacado" href="javascript:jQuery('#ACCION').val('DOCUMENTO');cargaDoc(document.forms['SubirDocumentos']);">
             	<xsl:value-of select="document($doc)/translation/texts/item[@name='subir_documento']/node()"/>
          	</a>
            <!--</div>-->
            <!--<div id="waitBoxDoc" align="center">&nbsp;</div> Este DIV despalazaba el botón	-->
          </td>
          <td style="width:100px;">
		  		<div id="waitBoxDoc" align="center">&nbsp;</div>
          </td>
          <td>
  		  		<div id="confirmBoxDocEmpresa" align="center" style="display:none;"><span class="cargado">¡<xsl:value-of select="document($doc)/translation/texts/item[@name='documento_cargado']/node()"/>!</span></div>
          </td>
        </tr>
      </form>
      </table><!--fin de tabla doc-->
		<form name="frmDocumentos" action="http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPDocs.xsql" method="post">
       		<input type="hidden" name="IDFILTROEMPRESA" id="IDFILTROEMPRESA" value="{/Empresa/EMPRESA/DOCUMENTACION/EMP_ID}"/>
       		<input type="hidden" name="FICHAEMPRESA" id="FICHAEMPRESA" value="{/Empresa/FICHAEMPRESA}"/>
			<div id="divTablasDocs">
			</div>
    	</form>

		<!--mensajes js -->
		<form name="MensajeJS">
			<input type="hidden" name="SEGURO_ELIMINAR_OFERTA" value="{document($doc)/translation/texts/item[@name='seguro_eliminar_oferta']/node()}"/>
			<input type="hidden" name="SEGURO_ELIMINAR_OFERTA_ANE" value="{document($doc)/translation/texts/item[@name='seguro_eliminar_anexo']/node()}"/>
			<input type="hidden" name="SEGURO_ELIMINAR_FICHA" value="{document($doc)/translation/texts/item[@name='seguro_eliminar_ficha']/node()}"/>
			<input type="hidden" name="SEGURO_ASOCIAR_OFERTA" value="{document($doc)/translation/texts/item[@name='seguro_asociar_oferta']/node()}"/>
			<input type="hidden" name="SEGURO_MODIFICAR_FECHA" value="{document($doc)/translation/texts/item[@name='seguro_modificar_fecha']/node()}"/>
			<!--carga documentos-->
			<input type="hidden" name="ERROR_SIN_DEFINIR" value="{document($doc)/translation/texts/item[@name='error_sin_definir']/node()}"/>
			<input type="hidden" name="HEMOS_ESPERADO" value="{document($doc)/translation/texts/item[@name='hemos_esperado']/node()}"/>
			<input type="hidden" name="LA_CARGA_NO_TERMINO" value="{document($doc)/translation/texts/item[@name='la_carga_no_termino']/node()}"/>
			<input type="hidden" name="CARGANDO_IMAGEN" value="{document($doc)/translation/texts/item[@name='cargando_imagen']/node()}"/>
			<input type="hidden" name="FICHA_OBLIGATORIA" value="{document($doc)/translation/texts/item[@name='ficha_obligatoria']/node()}"/>
			<input type="hidden" name="TIPO_OBLIGATORIO" value="{document($doc)/translation/texts/item[@name='Tipo_doc_obligatorio']/node()}"/>
		</form>	
	</div>
</xsl:template>

<!--documentos-->
<xsl:template name="documentos">
	<xsl:param name="num"/>
	<xsl:choose>
	<!--imagenes de la tienda-->
	<xsl:when test="$num &lt; number(5)">
		<div class="docLine" id="docLine">
			<!--<xsl:if test="number($num) &gt; number(1)">
				<xsl:attribute name="style">display: none;</xsl:attribute>
			</xsl:if>-->
			<div class="docLongEspec" id="docLongEspec">
				<input id="inputFileDoc" name="inputFileDoc" type="file" style="width:500px;" onChange="addDocFile();" />
			</div>
		</div>
	</xsl:when>
	</xsl:choose>
</xsl:template>


<xsl:template name="tabla_documentos">
   <xsl:param name="path" />
   <xsl:param name="doc" />
   <xsl:param name="titulo" />
    <xsl:if test="$path/DOCUMENTO">
	<table class="buscador documentos">
        <input type="hidden" name="ID_EMPRESA" value="{/Empresa/EMPRESA/DOCUMENTACION/EMP_ID}"/> 
			<tr class="sinLinea"><th colspan="11">&nbsp;</th></tr>
			<tr class="subTituloTabla"><th colspan="11"><strong><xsl:value-of select="$titulo"/></strong></th></tr>
		  <!--nombres columnas-->
		  <tr class="subTituloTabla">
			<th class="uno">&nbsp;</th>
			<th><xsl:value-of select="document($doc)/translation/texts/item[@name='nombre']/node()"/></th>
			<th><xsl:value-of select="document($doc)/translation/texts/item[@name='centro']/node()"/></th>

			<xsl:choose>
			<xsl:when test="//BORRAROFERTAS and TIPO != 'LEGAL' and TIPO != 'FICHAS_TECNICAS' and TIPO != 'LOGOS'">
				<th class="diez"><xsl:value-of select="document($doc)/translation/texts/item[@name='asociar_a_todos']/node()"/></th>
			</xsl:when>
			<xsl:otherwise>
				<th class="cerouno">&nbsp;</th>
			</xsl:otherwise>
			</xsl:choose>

            <th><xsl:value-of select="document($doc)/translation/texts/item[@name='usuario']/node()"/></th>
            <th style="width:200px;"><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha']/node()"/></th>
            <th style="width:240px;"><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_final']/node()"/></th>
            <th><xsl:value-of select="document($doc)/translation/texts/item[@name='Usuario_revision']/node()"/></th>
            <th style="width:200px;"><xsl:value-of select="document($doc)/translation/texts/item[@name='Fecha_revision']/node()"/></th>

			<th class="uno"><xsl:value-of select="document($doc)/translation/texts/item[@name='revisar']/node()"/></th>
			<xsl:choose>
			<xsl:when test="//BORRAROFERTAS">
				<th class="uno"><xsl:value-of select="document($doc)/translation/texts/item[@name='eliminar']/node()"/></th>
			</xsl:when>
			<xsl:otherwise>
				<th class="uno">&nbsp;</th>
			</xsl:otherwise>
        	</xsl:choose>
        </tr>

   	<xsl:for-each select="$path/DOCUMENTO">
		<input type="hidden" id="st_{ID}" value="{COLOR}"/> 
		<xsl:choose>
		<xsl:when test="/Empresa/EMPRESA/DOCUMENTACION/MVM">
			<input type="hidden" id="EXCEL_{ID}" name="EXCEL_{ID}" value="{CONTADOR};{NOMBRE};{NOMBRETIPO};{EMP_NIF};{EMPRESA};{CEN_NIF};{CENTRO};{FECHA};{FECHACADUCIDAD};{USUARIO_REVISION};{FECHAREVISION};{FECHAULTPEDIDO};{FECHAULTLICITACION};{COMERCIAL_POR_DEFECTO/NOMBRE};{COMERCIAL_POR_DEFECTO/US_EMAIL};{COMERCIAL_POR_DEFECTO/TELEFONO};{COMERCIAL_POR_DEFECTO/PROVINCIA}"/> 
		</xsl:when>
		<xsl:otherwise>
			<input type="hidden" id="EXCEL_{ID}" name="EXCEL_{ID}" value="{CONTADOR};{NOMBRE};{NOMBRETIPO};{EMP_NIF};{EMPRESA};{CEN_NIF};{CENTRO};{FECHA};{FECHACADUCIDAD};{USUARIO_REVISION};{FECHAREVISION};{FECHAULTPEDIDO};{FECHAULTLICITACION}"/> 
		</xsl:otherwise>
   		</xsl:choose>
		<xsl:choose>
		<xsl:when test="NO_INFORMADO">
			<!--	Si un documento obligatorio no está informado, lo indicamos		-->
			<tr class="conhover">
				<td>
					<xsl:attribute name="style">background:#CC0000;</xsl:attribute>
					<xsl:value-of select="CONTADOR"/>
				</td>
				<td class="textLeft">
					<xsl:value-of select="NOMBRETIPO"/>:&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Documento_obligatorio_no_informado']/node()"/>
				</td>
				<td colspan="6">
					&nbsp;
				</td>
			</tr>
		</xsl:when>
		<xsl:otherwise>
			<tr class="conhover">
				<td id="doc_{ID}">
					<xsl:choose>
    	  			<xsl:when test="COLOR='VERDE'">
						<xsl:attribute name="style">background:#4E9A06;</xsl:attribute>
					</xsl:when>
    	  			<xsl:when test="COLOR='NARANJA'">
						<xsl:attribute name="style">background:#F57900;</xsl:attribute>
					</xsl:when>
					<xsl:otherwise>
						<xsl:attribute name="style">background:#CC0000;</xsl:attribute>
					</xsl:otherwise>
    	 			</xsl:choose>
					<xsl:value-of select="CONTADOR"/>
				</td>
				<td class="textLeft"><!--<xsl:if test="DOCUMENTOHIJO"><span class="rojo amarillo">|&nbsp;</span></xsl:if>-->
					<!--Debug:<xsl:value-of select="ID"/>:<xsl:value-of select="DOC_IDCLIENTE"/>:<xsl:value-of select="DOC_IDPROVEEDOR"/>-->
					&nbsp;<strong><a>
						<xsl:attribute name="href">http://www.newco.dev.br/Documentos/<xsl:value-of select="URL"/></xsl:attribute>
						<xsl:value-of select="NOMBRETIPO"/>:&nbsp;<xsl:value-of select="NOMBRE"/>
					</a></strong>
				</td>
				<td class="textLeft">
					<xsl:choose>
    	  			<xsl:when test="CENTRO!=''">
						<a href="javascript:DocsEmpresa({DOC_IDPROVEEDOR});"><xsl:value-of select="CENTRO"/></a>
					</xsl:when>
					<xsl:otherwise>
						<a href="javascript:DocsEmpresa({DOC_IDPROVEEDOR});"><xsl:value-of select="EMPRESA"/></a>
					</xsl:otherwise>
    	 			</xsl:choose>				
				</td>
				<!--
				<td>
					<a>
						<xsl:attribute name="href">http://www.newco.dev.br/Documentos/<xsl:value-of select="URL"/></xsl:attribute>
						<img src="http://www.newco.dev.br/images/descarga.gif" alt="Descarga"/>
					</a>
				</td>-->
				<td>
    		  <xsl:choose>
    		  <xsl:when test="//BORRAROFERTAS and not(/Empresa/EMPRESA/DOCUMENTACION/OBSERVADOR) and ../TIPO = 'DOCUMENTOS_COMERCIALES_PROV'">
					<a>
						<xsl:attribute name="href">javascript:AsociarDocComeTodos('<xsl:value-of select="ID"/>','<xsl:value-of select="../TIPO"/>','<xsl:value-of select="../NOMBRE_CORTO"/>');</xsl:attribute>
						<img src="http://www.newco.dev.br/images/asociar.gif" alt="Asociar a todos los productos"/>
					</a>
				</xsl:when>
				<xsl:when test="//BORRAROFERTAS and not(/Empresa/EMPRESA/DOCUMENTACION/OBSERVADOR) and ../TIPO != 'LEGAL' and ../TIPO != 'FICHAS_TECNICAS' and ../TIPO != 'ANEXOS' and ../TIPO != 'LOGOS'">
					<a>
						<xsl:attribute name="href">javascript:AsociarOfertaTodos('<xsl:value-of select="ID"/>','<xsl:value-of select="../TIPO"/>','<xsl:value-of select="../NOMBRE_CORTO"/>');</xsl:attribute>
						<img src="http://www.newco.dev.br/images/asociar.gif" alt="Asociar a todos los productos"/>
					</a>
				</xsl:when>
    		  </xsl:choose>
			</td>
			<td align="left"><xsl:value-of select="USUARIO"/></td>
			<td align="left">
				<xsl:choose>
				<!--<xsl:when test="((/Empresa/EMPRESA/DOCUMENTACION/MVM or /Empresa/EMPRESA/DOCUMENTACION/MVMB or /Empresa/EMPRESA/DOCUMENTACION/ADMIN) and not(/Empresa/EMPRESA/DOCUMENTACION/OBSERVADOR)) and ../TIPO != 'ANEXOS' and ../TIPO != 'FICHAS_TECNICAS' and ../TIPO != 'LOGOS' and ../TIPO != 'DOCUMENTOS_COMERCIALES_PROV'">-->
				<!--29abr21 <xsl:when test="((/Empresa/EMPRESA/DOCUMENTACION/MVM or /Empresa/EMPRESA/DOCUMENTACION/MVMB or /Empresa/EMPRESA/DOCUMENTACION/ADMIN) and not(/Empresa/EMPRESA/DOCUMENTACION/OBSERVADOR))">-->
				<xsl:when test="/Empresa/EMPRESA/DOCUMENTACION/MODIFICAR_FECHAS">
					<input type="text" name="fecha_{ID}" value="{FECHA}" maxlength="10" size="10" class="medio" id="fecha_{ID}"/>
					<img src="http://www.newco.dev.br/images/actualizarFlecha.gif" alt="Actualizar Fecha" onmouseover="style.cursor='pointer'" onclick="javascript:ActualizarFechaOferta('{ID}','{DOC_IDPROVEEDOR}','{TIPO}','{NOMBRE_CORTO}');"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="FECHA"/>
				</xsl:otherwise>
				</xsl:choose>
			</td>
    		<td align="left">
				<xsl:choose>
				<!--<xsl:when test="((/Empresa/EMPRESA/DOCUMENTACION/MVM or /Empresa/EMPRESA/DOCUMENTACION/MVMB or /Empresa/EMPRESA/DOCUMENTACION/ADMIN) and not(/Empresa/EMPRESA/DOCUMENTACION/OBSERVADOR)) and ../TIPO != 'ANEXOS' and ../TIPO != 'FICHAS_TECNICAS' and ../TIPO != 'LOGOS' and ../TIPO != 'DOCUMENTOS_COMERCIALES_PROV'">-->
				<!--29abr21 <xsl:when test="((/Empresa/EMPRESA/DOCUMENTACION/MVM or /Empresa/EMPRESA/DOCUMENTACION/MVMB or /Empresa/EMPRESA/DOCUMENTACION/ADMIN) and not(/Empresa/EMPRESA/DOCUMENTACION/OBSERVADOR))">-->
				<xsl:when test="/Empresa/EMPRESA/DOCUMENTACION/MODIFICAR_FECHAS">
					<input type="text" name="fechaFinal_{ID}" value="{FECHACADUCIDAD}" maxlength="10" size="10" class="medio" id="fechaFinal_{ID}"/>
					<img src="http://www.newco.dev.br/images/actualizarFlecha.gif" alt="Actualizar Fecha final" onmouseover="style.cursor='pointer'" onclick="javascript:ActualizarFechaOferta('{ID}','{DOC_IDPROVEEDOR}','{TIPO}','{NOMBRE_CORTO}');"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="FECHACADUCIDAD"/>
				</xsl:otherwise>
				</xsl:choose>
				&nbsp;
				<xsl:if test="CADUCADO">
					<img src="http://www.newco.dev.br/images/2017/warning-red.png"/>
				</xsl:if>
			</td>
			<xsl:choose>
			<xsl:when test="REVISADO='S'">
				<td><xsl:value-of select="USUARIO_REVISION"/></td>
				<td><xsl:value-of select="FECHAREVISION"/></td>
			</xsl:when>
			<xsl:otherwise>
				<td>-</td>
				<td>-</td>
			</xsl:otherwise>
			</xsl:choose>
			<td>
				<xsl:if test="/Empresa/EMPRESA/DOCUMENTACION/REVISAR_DOCUMENTOS">
					<a id="btnEstado_{ID}" class="btnDestacado" href="javascript:revisarDocumento({ID});">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='Revisar']/node()"/>
					</a>
					<div id="waitBoxEst_{ID}" class="gris" style="display:none; margin-top:5px;">
                		<xsl:value-of select="document($doc)/translation/texts/item[@name='cargando']/node()"/>...&nbsp;
            		</div>
				</xsl:if>
			</td>
			<td>
				<xsl:if test="((/Empresa/EMPRESA/DOCUMENTACION/BORRAROFERTAS) or (/Empresa/EMPRESA/DOCUMENTACION/BORRARDOCUMENTOS)) and not(/Empresa/EMPRESA/DOCUMENTACION/OBSERVADOR)">
					<a>
						<xsl:attribute name="href">javascript:EliminarDocumento('<xsl:value-of select="ID"/>','<xsl:value-of select="TIPO"/>','<xsl:value-of select="NOMBRE_CORTO"/>');</xsl:attribute>
						<img src="http://www.newco.dev.br/images/2017/trash.png" alt="eliminar"/>
					</a>
					<div id="waitBoxOferta_{ID}" class="gris" style="display:none; margin-top:5px;">
                		<xsl:value-of select="document($doc)/translation/texts/item[@name='cargando']/node()"/>...&nbsp;
            		</div>
				</xsl:if>
			</td>
			</tr>

			  <xsl:if test="DOCUMENTOHIJO">
    			<tr>
    			  <td></td>
    			  <td><span class="rojo amarillo">|&nbsp;<xsl:value-of select="DOCUMENTOHIJO/TIPO"/></span>&nbsp;<xsl:value-of select="DOCUMENTOHIJO/NOMBRE"/></td>
    			  <td>
        			<a>
						<xsl:attribute name="href">http://www.newco.dev.br/Documentos/<xsl:value-of select="DOCUMENTOHIJO/URL"/></xsl:attribute>
						<img src="http://www.newco.dev.br/images/descarga.gif" alt="Descarga"/>
        			</a>
    			  </td>
    			  <td>&nbsp;</td>
    			  <td><xsl:value-of select="DOCUMENTOHIJO/FECHA"/></td>
    			</tr>
		  	</xsl:if>
		</xsl:otherwise>
   		</xsl:choose>
		</xsl:for-each>
	</table>
	</xsl:if>
</xsl:template>		

</xsl:stylesheet>
