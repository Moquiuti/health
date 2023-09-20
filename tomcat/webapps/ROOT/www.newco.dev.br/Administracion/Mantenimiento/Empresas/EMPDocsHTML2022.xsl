<?xml version="1.0" encoding="iso-8859-1"?>
<!--
    Mostrar documentos de la empresa. Nuevo disenno 2022.
 	ultima revision: ET 25may22 19:01 EMPDocs2022_220222.js
 +-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:import href="http://www.newco.dev.br/General/General.xsl"/>
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="lang" select="@lang"/>
<xsl:template match="/Docs">

<html>
<head>
	<!--idioma-->
	<xsl:variable name="lang">
    <xsl:choose>
		<xsl:when test="LANG"><xsl:value-of select="LANG"/></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
    </xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->
	<!--	11ene22 nuevos estilos -->
	<!--<link rel="stylesheet" href="http://www.newco.dev.br/General/basicMVM2022.css"/>-->
	<!--<link href='http://fonts.googleapis.com/css?family=Roboto' rel='stylesheet'/>-->
	<!--	11ene22 nuevos estilos -->

	<script src="http://www.newco.dev.br/General/jquery-3.6.0.js"></script>	
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic2022_010822.js"></script>

	<meta http-equiv="Cache-Control" Content="no-cache"/>
	
	<title><xsl:value-of select="/Docs/EMPRESA/EMP_NOMBRE" disable-output-escaping="yes"/>:&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='documentos']/node()"/></title>

	<!--<script type="text/javascript" src="http://www.newco.dev.br/General/jquery-1.8.3.min.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>-->
	<script type="text/javascript" src="http://www.newco.dev.br/General/descargas_151117.js"></script>
	<script type="text/javascript">
		var IDEmpresa='<xsl:value-of select="/Docs/EMPRESA/EMP_ID"/>';
		var Empresa='<xsl:value-of select="/Docs/EMPRESA/EMP_NOMBRE" disable-output-escaping="yes"/>';
		var Rol='<xsl:value-of select="/Docs/EMPRESA/ROL"/>';
		var Usuario='<xsl:value-of select="/Docs/EMPRESA/COMERCIAL_POR_DEFECTO/NOMBRE"/>';
		var Telefono='<xsl:value-of select="/Docs/EMPRESA/COMERCIAL_POR_DEFECTO/TELEFONO"/>';
		var Email='<xsl:value-of select="/Docs/EMPRESA/COMERCIAL_POR_DEFECTO/US_EMAIL"/>';
		var Provincia='<xsl:value-of select="/Docs/EMPRESA/COMERCIAL_POR_DEFECTO/PROVINCIA"/>';

		<xsl:choose>
		<xsl:when test="/Docs/EMPRESA/MVM">
		var v_AdminMVM='S';
		</xsl:when>
		<xsl:otherwise>
		var v_AdminMVM='N';
		</xsl:otherwise>
   		</xsl:choose>
		<xsl:choose>
		<xsl:when test="//BORRAROFERTAS">
		var v_BorrarOfertas='S';
		</xsl:when>
		<xsl:otherwise>
		var v_BorrarOfertas='N';
		</xsl:otherwise>
   		</xsl:choose>

	</script>
	<script type="text/javascript">
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
		
		//	Monta el array de todas categorias de documentos
		var arrCategorias=[];
		//arrDocs['Categorias']= [];

		<xsl:for-each select="/Docs/EMPRESA/DOCUMENTOS">
			var Categoria=[]
			Categoria['Nombre']='<xsl:value-of select="NOMBRE_CORTO"/>';
			Categoria['Tipo']='<xsl:value-of select="TIPO"/>';
			Categoria['Documentos']=[];

			var arrDocumentos	= [];
			<xsl:choose>
			<xsl:when test="DOCUMENTO">
				<xsl:for-each select="DOCUMENTO">
					var Doc= [];
					Doc['Cont']	= '<xsl:value-of select="CONTADOR"/>';
					Doc['ID']		= '<xsl:value-of select="ID"/>';
					Doc['NifEmpresa']	= '<xsl:value-of select="EMP_NIF"/>';
					Doc['Empresa']	= '<xsl:value-of select="EMPRESA"/>';
					Doc['NifCentro']	= '<xsl:value-of select="CEN_NIF"/>';
					Doc['Centro']	= '<xsl:value-of select="CENTRO"/>';
					Doc['Url']	= '<xsl:value-of select="URL"/>';
					Doc['Nombre']	= '<xsl:value-of select="NOMBRE"/>';
					Doc['Tipo']	= '<xsl:value-of select="TIPO"/>';
					Doc['NombreTipo']	= '<xsl:value-of select="NOMBRETIPO"/>';
					Doc['Usuario']	= '<xsl:value-of select="USUARIO"/>';
					Doc['UsuarioRev']	= '<xsl:value-of select="USUARIO_REVISION"/>';
					Doc['FechaAlta']	= '<xsl:value-of select="FECHA"/>';
					Doc['FechaCad']= '<xsl:value-of select="FECHACADUCIDAD"/>';
					Doc['FechaRev']= '<xsl:value-of select="FECHA_REVISION"/>';
					Doc['FechaUltPed']= '<xsl:value-of select="FECHAULTPEDIDO"/>';
					Doc['IDEmpresa']= '<xsl:value-of select="DOC_IDPROVEEDOR"/>';
					Doc['CentroOEmpresa']= '<xsl:choose><xsl:when test="CENTRO!=''"><xsl:value-of select="CENTRO"/></xsl:when><xsl:otherwise><xsl:value-of select="EMPRESA"/></xsl:otherwise></xsl:choose>';
					Doc['Caducado']= '<xsl:choose><xsl:when test="CADUCADO">S</xsl:when><xsl:otherwise>N</xsl:otherwise></xsl:choose>';
					Doc['Color']	= '<xsl:value-of select="COLOR"/>';
					Doc['FechaUltLic']	= '<xsl:value-of select="FECHAULTLICITACION"/>';
					Doc['Comercial_Nombre']= '<xsl:value-of select="COMERCIAL_POR_DEFECTO/NOMBRE"/>';
					Doc['Comercial_Mail']	= '<xsl:value-of select="COMERCIAL_POR_DEFECTO/US_EMAIL"/>';
					Doc['Comercial_Telf']	= '<xsl:value-of select="COMERCIAL_POR_DEFECTO/TELEFONO"/>';
					Doc['Comercial_Prov']	= '<xsl:value-of select="COMERCIAL_POR_DEFECTO/PROVINCIA"/>';
					arrDocumentos.push(Doc);

					//debug('Cargando doc:'+Doc['ID']+' '+Doc['Tipo']+':'+Doc['Nombre']+' en '+Categoria['Tipo']+' tot:'+arrDocumentos.length);
				</xsl:for-each>
				Categoria['NumDocs']=arrDocumentos.length;
				Categoria['Documentos']=arrDocumentos;

				//debug('Cargando categoria:'+Categoria['Nombre']+' '+Categoria['Tipo']+' tot:'+Categoria['NumDocs']+'='+Categoria.Documentos.length);
				

			</xsl:when>
			<xsl:otherwise>
				Categoria['NumDocs']=0;
				//debug('Cargando categoria vacia:'+Categoria['Nombre']+' '+Categoria['Tipo']+' tot:'+Categoria['NumDocs']);
			</xsl:otherwise>
			</xsl:choose>
			arrCategorias.push(Categoria);

			//debug('Length arrCategorias.length:'+arrCategorias.length);
		</xsl:for-each>
		var strTitObl='';
		var strTitOpc='';
		var strCargando='<xsl:value-of select="document($doc)/translation/texts/item[@name='cargando']/node()"/>';

	</script>
	<script type="text/javascript" src="http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPDocs2022_220222.js"></script>
</head>

<body onLoad="javascript:Inicio();">
	<xsl:choose>
		<xsl:when test="//SESION_CADUCADA">
			<xsl:apply-templates select="//SESION_CADUCADA"/>
		</xsl:when>
		<xsl:when test="//xsql-error">
			<xsl:apply-templates select="//xsql-error"/>
		</xsl:when>
		<xsl:when test="//Status">
			<xsl:apply-templates select="//Status"/>
		</xsl:when>
		<xsl:otherwise>
			<xsl:apply-templates select="EMPRESA"/>
		</xsl:otherwise>
	</xsl:choose>

  <div id="uploadFrameBox" style="display:none;"><iframe id="uploadFrame" name="uploadFrame" style="width:100%;"></iframe></div>
  <div id="uploadFrameBoxDoc" style="display:none;"><iframe id="uploadFrameDoc" name="uploadFrameDoc" style="width:100%;"></iframe></div>
</body>
</html>
</xsl:template>

<!--
 |  Templates
 +-->

<xsl:template match="EMPRESA">
	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:choose>
		<xsl:when test="/Docs/LANG"><xsl:value-of select="/Docs/LANG"/></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->


	<!--	Titulo de la página		-->
	<div class="ZonaTituloPagina">
		<p class="TituloPagina">
			<xsl:choose>
			<xsl:when test="/Docs/EMPRESA/FIDEMPRESA/field and /Docs/FICHAEMPRESA!='S'">
				<th width="210px" style="text-align:left">
				<xsl:call-template name="desplegable">
					<xsl:with-param name="path" select="/Docs/EMPRESA/FIDEMPRESA/field"/>
					<xsl:with-param name="claSel">w800px</xsl:with-param>
					<xsl:with-param name="onChange">javascript:cbEmpresaChange();</xsl:with-param>
				</xsl:call-template>
				</th>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="EMP_NOMBRE" disable-output-escaping="yes"/>
			</xsl:otherwise>
			</xsl:choose>
			<span class="CompletarTitulo">
				<a class="btnNormal" href="javascript:DescargarExcel();"><xsl:value-of select="document($doc)/translation/texts/item[@name='CSV']/node()"/></a>&nbsp;
				<a class="btnNormal" href="javascript:window.print();" style="text-decoration:none;" title="Imprimir">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='imprimir']/node()"/>
				</a>&nbsp;
			</span>
		</p>
	</div>
	<br/>


	<div class="divLeft">
    <!--si usuario observador no puede añadir nuevos documentos-->
    <!--<xsl:if test="(/Docs/EMPRESA/MVM or /Docs/EMPRESA/MVMB or /Docs/EMPRESA/USUARIO_CDC) and not(/Docs/EMPRESA/OBSERVADOR)">-->
    <xsl:if test="/Docs/EMPRESA/SUBIR_DOCUMENTOS">
			<!--tabla imagenes y documentos-->
     <!-- <table class="infoTableAma documentos" border="0">-->
      <table class="buscador documentos" border="0">
      <form name="SubirDocumentos" method="post">
        <input type="hidden" name="IDPROVEEDOR" id="IDPROVEEDOR" value="{/Docs/EMPRESA/EMP_ID}"/>
        <input type="hidden" name="CADENA_DOCUMENTOS" />
        <input type="hidden" name="DOCUMENTOS_BORRADOS" />
        <input type="hidden" name="BORRAR_ANTERIORES" />
        <input type="hidden" name="REMOVE" value="{document($doc)/translation/texts/item[@name='remove']/node()}"/>

        <tr class="sinLinea">
          <!--documentos-->
          <td class="tres">&nbsp;</td>
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
            <xsl:for-each select="/Docs/EMPRESA/TIPOS_DOCUMENTOS/field/dropDownList/listElem">
              <option value="{ID}"><xsl:value-of select="listItem"/></option>
            </xsl:for-each>
            </select>
          </td>
          <td class="w200px">
          	<a class="btnDestacado" href="javascript:cargaDoc(document.forms['SubirDocumentos']);">
             	<xsl:value-of select="document($doc)/translation/texts/item[@name='subir_documento']/node()"/>
          	</a>
          </td>
          <td style="width:100px;">
		  		<div id="waitBoxDoc" align="center">&nbsp;</div>
          </td>
          <td>
  		  		<div id="confirmBoxDocEmpresa" align="center" style="display:none;"><span class="cargado"><xsl:value-of select="document($doc)/translation/texts/item[@name='documento_cargado']/node()"/></span></div>
          </td>
        </tr>
      </form>
      </table><!--fin de tabla doc-->
    </xsl:if><!--fin if si es mvm-->
	<br/>
	<br/>

		<form name="frmDocumentos" action="http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPDocs2022.xsql" method="post">
       		<input type="hidden" name="IDFILTROEMPRESA" id="IDFILTROEMPRESA" value="{/Docs/EMPRESA/EMP_ID}"/>
       		<input type="hidden" name="FICHAEMPRESA" id="FICHAEMPRESA" value="{/Docs/FICHAEMPRESA}"/>
			<table class="buscador" border="0">
			<tr class="filtros">
				<th class="uno">&nbsp;</th>
				<th width="180px" style="text-align:left">
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='texto']/node()"/></label><br />
					<input type="text" class="campopesquisa w170px" name="FTEXTO" size="30">
						<xsl:attribute name="value"><xsl:value-of select="/Docs/EMPRESA/FTEXTO"/></xsl:attribute>
					</input>
				</th>
				<th width="200px" style="text-align:left;">
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='tipo']/node()"/></label><br />
					<xsl:call-template name="desplegable">
						<xsl:with-param name="path" select="/Docs/EMPRESA/FIDTIPODOCUMENTO/field"/>
						<xsl:with-param name="claSel">w180px</xsl:with-param>
					</xsl:call-template>
				</th>
				<th width="140px" style="text-align:left">
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='estado']/node()"/></label><br />
					<xsl:call-template name="desplegable"><xsl:with-param name="path" select="/Docs/EMPRESA/FIDESTADO/field"/></xsl:call-template>
				</th>
				<th width="140px" style="text-align:left">
					<br/>
					<a class="btnDestacado" href="javascript:Buscar();">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='buscar']/node()"/>
					</a>
				</th>
				<th>&nbsp;</th>
			</tr>
			</table>
			
			<div id="divTablasDocs">
			<!-- 26abr22 Las tablas se generan desde el JS	-->
			<!--	28may20	CONTRATOS	
			<xsl:if test="/Docs/EMPRESA/DOCUMENTOS[@tipo='CONTRATO']">
				<xsl:call-template name="tabla_documentos">
					<xsl:with-param name="path" select="/Docs/EMPRESA/DOCUMENTOS[@tipo='CONTRATO']"/>
					<xsl:with-param name="doc" select="$doc"/>
					<xsl:with-param name="titulo" select="document($doc)/translation/texts/item[@name='Contratos']/node()"/>
				</xsl:call-template>
    		</xsl:if>

			<xsl:if test="/Docs/EMPRESA/DOCUMENTOS/DOCUMENTOS_OBLIGATORIOS">
				<xsl:call-template name="tabla_documentos">
					<xsl:with-param name="path" select="/Docs/EMPRESA/DOCUMENTOS/DOCUMENTOS_OBLIGATORIOS"/>
					<xsl:with-param name="doc" select="$doc"/>
					<xsl:with-param name="titulo" select="document($doc)/translation/texts/item[@name='Documentos_obligatorios']/node()"/>
				</xsl:call-template>
    		</xsl:if>
			<xsl:if test="/Docs/EMPRESA/DOCUMENTOS/DOCUMENTOS_OPCIONALES">
				<xsl:call-template name="tabla_documentos">
					<xsl:with-param name="path" select="/Docs/EMPRESA/DOCUMENTOS/DOCUMENTOS_OPCIONALES"/>
					<xsl:with-param name="doc" select="$doc"/>
					<xsl:with-param name="titulo" select="document($doc)/translation/texts/item[@name='Documentos_opcionales']/node()"/>
				</xsl:call-template>
    		</xsl:if>
			<xsl:if test="/Docs/EMPRESA/DOCUMENTOS[@tipo='OF']">
				<xsl:call-template name="tabla_documentos">
					<xsl:with-param name="path" select="/Docs/EMPRESA/DOCUMENTOS[@tipo='OF']"/>
					<xsl:with-param name="doc" select="$doc"/>
					<xsl:with-param name="titulo" select="document($doc)/translation/texts/item[@name='documentos_comerciales']/node()"/>
				</xsl:call-template>
    		</xsl:if>
			<xsl:if test="/Docs/EMPRESA/DOCUMENTOS[@tipo='DOC_INTERNO']">
				<xsl:call-template name="tabla_documentos">
					<xsl:with-param name="path" select="/Docs/EMPRESA/DOCUMENTOS[@tipo='DOC_INTERNO']"/>
					<xsl:with-param name="doc" select="$doc"/>
					<xsl:with-param name="titulo" select="document($doc)/translation/texts/item[@name='Documentos_internos']/node()"/>
				</xsl:call-template>
    		</xsl:if>
			<xsl:if test="/Docs/EMPRESA/DOCUMENTOS[@tipo='ANE']">
				<xsl:call-template name="tabla_documentos">
					<xsl:with-param name="path" select="/Docs/EMPRESA/DOCUMENTOS[@tipo='ANE']"/>
					<xsl:with-param name="doc" select="$doc"/>
					<xsl:with-param name="titulo" select="document($doc)/translation/texts/item[@name='documentos_anexos']/node()"/>
				</xsl:call-template>
    		</xsl:if>
			<xsl:if test="/Docs/EMPRESA/DOCUMENTOS[@tipo='CO']">
				<xsl:call-template name="tabla_documentos">
					<xsl:with-param name="path" select="/Docs/EMPRESA/DOCUMENTOS[@tipo='CO']"/>
					<xsl:with-param name="doc" select="$doc"/>
					<xsl:with-param name="titulo" select="document($doc)/translation/texts/item[@name='documentos_comerciales']/node()"/>
				</xsl:call-template>
    		</xsl:if>
			<xsl:if test="/Docs/EMPRESA/DOCUMENTOS[@tipo='LOGO']">
				<xsl:call-template name="tabla_documentos">
					<xsl:with-param name="path" select="/Docs/EMPRESA/DOCUMENTOS[@tipo='LOGO']"/>
					<xsl:with-param name="doc" select="$doc"/>
					<xsl:with-param name="titulo" select="document($doc)/translation/texts/item[@name='logos']/node()"/>
				</xsl:call-template>
    		</xsl:if>-->
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
		<!--fin de mensajes js -->
	</div><!--fin de divCenter50-->
</xsl:template>

<!--documentos-->
<xsl:template name="documentos">
	<xsl:param name="num"/>
	<xsl:choose>
	<!--imagenes de la tienda-->
	<xsl:when test="$num &lt; number(5)">
		<div class="docLine" id="docLine">
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
	<table class="buscador documentos" cellspacing="6px" cellpadding="6px">
        <input type="hidden" name="ID_EMPRESA" value="{/Docs/EMPRESA/EMP_ID}"/> 
			<tr class="sinLinea"><th colspan="11">&nbsp;</th></tr>
			<tr class="subTituloTabla"><th colspan="11"><strong><xsl:value-of select="$titulo"/></strong></th></tr>
		  <!--nombres columnas-->
		  <tr class="subTituloTabla">
			<th class="w1px">&nbsp;</th>
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
            <th class="w200px"><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha']/node()"/></th>
            <th class="w240px"><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_final']/node()"/></th>
            <th><xsl:value-of select="document($doc)/translation/texts/item[@name='Usuario_revision']/node()"/></th>
            <th class="w200px"><xsl:value-of select="document($doc)/translation/texts/item[@name='Fecha_revision']/node()"/></th>

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
		<xsl:when test="/Docs/EMPRESA/MVM">
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
				<td class="textLeft">
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
    		  <xsl:when test="//BORRAROFERTAS and not(/Docs/EMPRESA/OBSERVADOR) and ../TIPO = 'DOCUMENTOS_COMERCIALES_PROV'">
					<a>
						<xsl:attribute name="href">javascript:AsociarDocComeTodos('<xsl:value-of select="ID"/>','<xsl:value-of select="../TIPO"/>','<xsl:value-of select="../NOMBRE_CORTO"/>');</xsl:attribute>
						<img src="http://www.newco.dev.br/images/asociar.gif" alt="Asociar a todos los productos"/>
					</a>
				</xsl:when>
				<xsl:when test="//BORRAROFERTAS and not(/Docs/EMPRESA/OBSERVADOR) and ../TIPO != 'LEGAL' and ../TIPO != 'FICHAS_TECNICAS' and ../TIPO != 'ANEXOS' and ../TIPO != 'LOGOS'">
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
				<!--<xsl:when test="((/Docs/EMPRESA/MVM or /Docs/EMPRESA/MVMB or /Docs/EMPRESA/ADMIN) and not(/Docs/EMPRESA/OBSERVADOR)) and ../TIPO != 'ANEXOS' and ../TIPO != 'FICHAS_TECNICAS' and ../TIPO != 'LOGOS' and ../TIPO != 'DOCUMENTOS_COMERCIALES_PROV'">-->
				<!--29abr21 <xsl:when test="((/Docs/EMPRESA/MVM or /Docs/EMPRESA/MVMB or /Docs/EMPRESA/ADMIN) and not(/Docs/EMPRESA/OBSERVADOR))">-->
				<xsl:when test="/Docs/EMPRESA/MODIFICAR_FECHAS">
					<input type="text" class="campopesquisa w120px" name="fecha_{ID}" value="{FECHA}" maxlength="10" size="10" id="fecha_{ID}"/>
					<!--<img src="http://www.newco.dev.br/images/actualizarFlecha.gif" alt="Actualizar Fecha" onmouseover="style.cursor='pointer'" onclick="javascript:ActualizarFechaOferta('{ID}','{DOC_IDPROVEEDOR}','{TIPO}','{NOMBRE_CORTO}');"/>-->
					<img src="http://www.newco.dev.br/images/2022/refresh-button.png" alt="Actualizar Fecha" onmouseover="style.cursor='pointer'" onclick="javascript:ActualizarFechaOferta('{ID}','{DOC_IDPROVEEDOR}','{TIPO}','{NOMBRE_CORTO}');"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="FECHA"/>
				</xsl:otherwise>
				</xsl:choose>
			</td>
    		<td align="left">
				<xsl:choose>
				<!--<xsl:when test="((/Docs/EMPRESA/MVM or /Docs/EMPRESA/MVMB or /Docs/EMPRESA/ADMIN) and not(/Docs/EMPRESA/OBSERVADOR)) and ../TIPO != 'ANEXOS' and ../TIPO != 'FICHAS_TECNICAS' and ../TIPO != 'LOGOS' and ../TIPO != 'DOCUMENTOS_COMERCIALES_PROV'">-->
				<!--29abr21 <xsl:when test="((/Docs/EMPRESA/MVM or /Docs/EMPRESA/MVMB or /Docs/EMPRESA/ADMIN) and not(/Docs/EMPRESA/OBSERVADOR))">-->
				<xsl:when test="/Docs/EMPRESA/MODIFICAR_FECHAS">
					<input type="text" class="campopesquisa w120px" name="fechaFinal_{ID}" value="{FECHACADUCIDAD}" maxlength="10" size="10" id="fechaFinal_{ID}"/>
					<!--<img src="http://www.newco.dev.br/images/actualizarFlecha.gif" alt="Actualizar Fecha final" onmouseover="style.cursor='pointer'" onclick="javascript:ActualizarFechaOferta('{ID}','{DOC_IDPROVEEDOR}','{TIPO}','{NOMBRE_CORTO}');"/>-->
					<img src="http://www.newco.dev.br/images/2022/refresh-button.png" alt="Actualizar Fecha final" onmouseover="style.cursor='pointer'" onclick="javascript:ActualizarFechaOferta('{ID}','{DOC_IDPROVEEDOR}','{TIPO}','{NOMBRE_CORTO}');"/>
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
				<td align="left"><xsl:value-of select="USUARIO_REVISION"/></td>
				<td><xsl:value-of select="FECHA_REVISION"/></td>
			</xsl:when>
			<xsl:otherwise>
				<td>-</td>
				<td>-</td>
			</xsl:otherwise>
			</xsl:choose>
			<td>
				<xsl:if test="/Docs/EMPRESA/REVISAR_DOCUMENTOS">
					<a id="btnEstado_{ID}" class="btnDestacado" href="javascript:revisarDocumento({ID});">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='Revisar']/node()"/>
					</a>
					<div id="waitBoxEst_{ID}" class="gris" style="display:none; margin-top:5px;">
                		<xsl:value-of select="document($doc)/translation/texts/item[@name='cargando']/node()"/>...&nbsp;
            		</div>
				</xsl:if>
			</td>
			<td>
				<xsl:if test="((/Docs/EMPRESA/BORRAROFERTAS) or (/Docs/EMPRESA/BORRARDOCUMENTOS)) and not(/Docs/EMPRESA/OBSERVADOR)">
					<a>
						<xsl:attribute name="href">javascript:EliminarDocumento('<xsl:value-of select="ID"/>','<xsl:value-of select="TIPO"/>','<xsl:value-of select="NOMBRE_CORTO"/>');</xsl:attribute>
						<img src="http://www.newco.dev.br/images/2022/icones/del.svg" alt="eliminar"/>
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

<!--fin de documentos-->
</xsl:stylesheet>
