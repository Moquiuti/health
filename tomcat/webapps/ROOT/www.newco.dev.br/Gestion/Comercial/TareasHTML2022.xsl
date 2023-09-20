<?xml version="1.0" encoding="iso-8859-1"?>
<!-- 
	Mantenimiento de tareas de la gestión comercial. Nuevo diseno 2022
	Ultima revision: ET 19may22 10:37 Tareas2022_230222.js
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:import href="http://www.newco.dev.br/General/General.xsl"/>
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="lang" select="@lang"/>
<xsl:template match="/Tareas">

<!--	Todos los documentos HTML deben empezar con esto	-->
<xsl:text disable-output-escaping='yes'>&lt;!doctype html></xsl:text>

<html>
<head>
	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:choose>
		<xsl:when test="LANG != ''"><xsl:value-of select="LANG"/></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--fin idioma-->

	<title><xsl:value-of select="INICIO/EMPRESA" disable-output-escaping="yes"/>:&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='gestion_tareas']/node()"/></title>

	<xsl:call-template name="estiloIndip"/>
	<link href="http://www.newco.dev.br/General/Tabla-popup.2022.css" rel="stylesheet" type="text/css"/>

	<script src="http://www.newco.dev.br/General/jquery-3.6.0.js"></script>	
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic2022_010822.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/Gestion/Comercial/Tareas2022_230222.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/Gestion/Comercial/CargaDocumentosTar_060619.js"></script><!--	3jun19 Incluir documentos en seguimiento	-->
	<script type="text/javascript" src="http://www.newco.dev.br/General/Tabla-popup.150715.js"></script>
	<script type="text/javascript">
		var crearCentro		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='crear_centro']/node()"/>';
		var no_hay_datos	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='no_hay_datos']/node()"/>';
	</script>
</head>

<body onLoad="javascript:Inicio();">
	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:choose>
		<xsl:when test="LANG != ''"><xsl:value-of select="LANG"/></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--fin idioma-->

	<xsl:choose>
	<xsl:when test="ERROR">
		<div class="divLeft">
			<p><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='no_tiene_derechos']/node()"/></strong></p>
		</div>
	</xsl:when>
	<xsl:otherwise>

    <form name="Admin" method="post" action="Tareas2022.xsql">
		<input type="hidden" name="IDPAIS" value="{INICIO/GESTIONCOMERCIAL/IDPAIS}"/>
		<input type="hidden" name="IDEMPRESAUSUARIO" value="{INICIO/IDEMPRESAUSUARIO}"/>
		<input type="hidden" name="IDEMPRESA" id="IDEMPRESA" value="{INICIO/IDEMPRESA}"/>
		<input type="hidden" name="FIDEMPRESA" id="FIDEMPRESA" value="{INICIO/GESTIONCOMERCIAL/FIDEMPRESA}"/>
		<input type="hidden" name="EMPRESA" id="EMPRESA" value="{INICIO/EMPRESA}"/>
		<input type="hidden" name="AUTOR" id="AUTOR" value="{INICIO/AUTOR}"/>
		<input type="hidden" name="FECHA" id="FECHA" value="{INICIO/FECHA}"/>
		<input type="hidden" name="IDDOCUMENTO" id="IDDOCUMENTO" value=""/>
		<input type="hidden" name="SOLO_CLIENTES"/>
		<input type="hidden" name="SOLO_PROVEE"/>
		<input type="hidden" name="ACCION" id="ACCION"/>
		<input type="hidden" name="PARAMETROS" id="PARAMETROS"/>

		<!--	para subir documentos	-->
    	<input type="hidden" name="CADENA_DOCUMENTOS" />
    	<input type="hidden" name="DOCUMENTOS_BORRADOS"/>
    	<input type="hidden" name="BORRAR_ANTERIORES"/>
    	<input type="hidden" name="ID_USUARIO" value="" />
    	<input type="hidden" name="TIPO_DOC" value="DOC_SEGUIMIENTO"/>

    	<div id="uploadFrameBox" style="display:none;"><iframe src="" id="uploadFrame" name="uploadFrame" style="width: 100%;"></iframe></div>
    	<div id="uploadFrameBoxDoc" style="display:none;"><iframe src="" id="uploadFrameDoc" name="uploadFrameDoc" style="width: 100%;"></iframe></div>

		<!--	Titulo de la página		-->
		<div class="ZonaTituloPagina">
			<p class="TituloPagina">
				<xsl:value-of select="INICIO/EMPRESA" disable-output-escaping="yes"/>:&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='gestion_tareas']/node()"/>
				<span class="CompletarTitulo">
				<xsl:if test="INICIO/COMERCIAL">
					<a class="btnDestacado" href="javascript:AbrirNueva();"><xsl:value-of select="document($doc)/translation/texts/item[@name='nueva']/node()"/></a>
					&nbsp;
				</xsl:if>
				<a class="btnNormal" href="javascript:window.print();">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='imprimir']/node()"/>
				</a>
				&nbsp;
				<a class="btnNormal" id="btnSeguimiento" href="http://www.newco.dev.br/Gestion/Comercial/Seguimiento2022.xsql">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='seguimiento']/node()"/>
				</a>
				&nbsp;
				</span>
			</p>
		</div>
		<br/>

		<div class="divLeft">
      		<!-- Pop-up para editar las entradas de tareas -->
			<div class="overlay-container" id="EditarGestionWrap">
				<div class="window-container zoomout">
					<p style="text-align:right;">
			      <a href="javascript:showTabla(false);" style="text-decoration:none;">
			        <xsl:value-of select="document($doc)/translation/texts/item[@name='cerrar']/node()"/>
			      </a>
			    </p>

					<p id="tableTitle">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='tarea']/node()"/>&nbsp;
						<xsl:value-of select="document($doc)/translation/texts/item[@name='de']/node()"/>&nbsp;
						<span id="NombreAutor"></span>&nbsp;
						<xsl:value-of select="document($doc)/translation/texts/item[@name='para']/node()"/>&nbsp;
						<span id="NombreEmpresa"></span>.&nbsp;
						<xsl:value-of select="document($doc)/translation/texts/item[@name='de']/node()"/>&nbsp;
						<span id="FechaTarea"></span>
					</p>

					<div id="mensError" class="divLeft" style="display:none;">
						<p><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='no_tiene_derechos']/node()"/></strong></p>
					</div>

					<form name="EditarGestionForm" method="post" id="EditarGestionForm">
					<input type="hidden" name="GT_IDGestion" id="GT_IDGestion"/>
					<input type="hidden" name="GT_IDEmpresa" id="GT_IDEmpresa"/>

					<table id="EditarGestion" class="w100" cellspacing="6px" cellpadding="6px">
					<thead>
						<th colspan="4">&nbsp;</th>
					</thead>

					<tbody>
						<tr>
							<td class="quince labelRight"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='centro']/node()"/>:</strong></td>
							<td class="trenta textLeft">
								<xsl:call-template name="desplegable">
									<xsl:with-param name="path" select="INICIO/LISTACENTROS/field"/>
									<xsl:with-param name="nombre">GT_IDCentro</xsl:with-param>
									<xsl:with-param name="id">GT_IDCentro</xsl:with-param>
	    							<xsl:with-param name="claSel">w300px</xsl:with-param>
								</xsl:call-template>
							</td>
							<td class="quince labelRight"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='estado']/node()"/>:</strong></td>
							<td class="textLeft">
		            			<xsl:call-template name="desplegable">
									<xsl:with-param name="path" select="INICIO/GESTIONCOMERCIAL/ESTADO/field"/>
									<xsl:with-param name="nombre">GT_IDEstado</xsl:with-param>
		                			<xsl:with-param name="id">GT_IDEstado</xsl:with-param>
	    							<xsl:with-param name="claSel">w200px</xsl:with-param>
								</xsl:call-template>
							</td>
						</tr>

						<tr>
							<td class="labelRight"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='responsable']/node()"/>:</strong></td>
							<td class="textLeft"> <!--id="GT_Responsable"-->
								<xsl:call-template name="desplegable">
									<xsl:with-param name="path" select="INICIO/GESTIONCOMERCIAL/IDRESPONSABLE/field"/>
									<xsl:with-param name="nombre">GT_IDResponsable</xsl:with-param>
									<xsl:with-param name="id">GT_IDResponsable</xsl:with-param>
	    							<xsl:with-param name="claSel">w300px</xsl:with-param>
								</xsl:call-template>
                            </td>
							<td class="labelRight"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='prioridad']/node()"/>:</strong></td>
							<td class="textLeft">
		            			<xsl:call-template name="desplegable">
		                			<xsl:with-param name="path" select="INICIO/GESTIONCOMERCIAL/PRIORIDAD/field"/>
									<xsl:with-param name="nombre">GT_IDPrioridad</xsl:with-param>
		                			<xsl:with-param name="id">GT_IDPrioridad</xsl:with-param>
	    							<xsl:with-param name="claSel">w200px</xsl:with-param>
								</xsl:call-template>
							</td>
						</tr>

						<tr>
							<td class="labelRight"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='tipo']/node()"/>:</strong></td>
							<td class="textLeft">
								<xsl:call-template name="desplegable">
									<xsl:with-param name="path" select="INICIO/TIPO/field"/>
									<xsl:with-param name="nombre">GT_IDTipo</xsl:with-param>
									<xsl:with-param name="id">GT_IDTipo</xsl:with-param>
	    							<xsl:with-param name="claSel">w200px</xsl:with-param>
								</xsl:call-template>
							</td>
							<td class="labelRight"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_limite']/node()"/>:</strong></td>
							<td class="textLeft"><input type="text" name="GT_FechaLimite" id="GT_FechaLimite" class="campopesquisa w100px"/></td>
						</tr>

						<tr>
							<td class="labelRight"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='visibilidad']/node()"/>:</strong></td>
							<td colspan="3" class="textLeft">
								<input type="radio" name="GT_IDVisibilidad" id="GT_VIS_PRIVADA" value="P"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='priv']/node()"/>&nbsp;&nbsp;
								<input type="radio" name="GT_IDVisibilidad" id="GT_VIS_CENTRO" value="C"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='cen']/node()"/>&nbsp;&nbsp;
								<input type="radio" name="GT_IDVisibilidad" id="VIS_EMPRESA" value="E"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='emp']/node()"/>
							</td>
						</tr>

						<tr>
							<td class="labelRight"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='descripcion_tarea']/node()"/>:</strong></td>
							<td colspan="3" class="textLeft">
								<textarea name="GT_Texto" id="GT_Texto" cols="80"/>
							</td>
						</tr>


        				<!--	3jun19	Añadir documento al seguimiento		-->
						<tr class="sinLinea">
							<td class="labelRight"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='documento']/node()"/>:</strong></td>
							<td colspan="3" class="textLeft">
								<input style="width:500px;" id="inputFileDoc" name="inputFileDoc" type="file" onchange="javascript:addDocFile(document.forms['Admin']);cargaDoc(document.forms['Admin'], 'DOC_SEGUIMIENTO');"/>
								<div id="divDatosDocumento" style="display:none;">
            						<a id="docSubido">
                    					&nbsp;
                					</a>
									<a href="javascript:borrarDoc('DOC_SEGUIMIENTO')" style="width:20px;margin-top:4px;vertical-align:middle;"><img src="http://www.newco.dev.br/images/2017/trash.png"/></a>
								</div>
            					<div id="waitBoxDoc" style="display:none;"><img src="http://www.newco.dev.br/images/descarga.gif" alt="Descarga" /></div>
            					<div id="confirmBox" style="display:none;" align="center">
                					<span class="cargado" style="font-size:10px;"><xsl:value-of select="document($doc)/translation/texts/item[@name='documento_cargado']/node()"/>!</span>
            					</div>
							</td>
        				</tr>
        				<!--	3jun19	Añadir documento al seguimiento		-->



					</tbody>

					<tfoot>
						<tr>
							<td>&nbsp;</td>
							<td class="textRight">
								<br/>
								<!--<div class="boton" id="botonGuardar">-->
									<a class="btnDestacado" id="botonGuardar" href="javascript:guardarTarea();">
										<xsl:value-of select="document($doc)/translation/texts/item[@name='guardar']/node()"/>
									</a>
								<!--</div>-->
							</td>
							<td id="Respuesta" style="text-align:left;"></td>
						</tr>
					</tfoot>
					</table>
					</form>
				</div>
			</div>
      <!-- FIN Pop-up para editar las entradas de tareas -->

		<!-- INICIO Tabla Tareas -->
      	<xsl:choose>
      	<xsl:when test="INICIO/GESTIONCOMERCIAL/GESTION">
			<div class="divLeft textCenter space40px">
			<table id="ListaTareas" cellspacing="6px" cellpadding="6px">
				<!--buscador-->
				<tr class="filtros">
					<td class="w40px textLeft">&nbsp;</td>
					<td class="w160px textLeft">
						<label><xsl:value-of select="document($doc)/translation/texts/item[@name='responsable']/node()"/>:&nbsp;<br/></label>
						<!--	responsable	-->
						<xsl:call-template name="desplegable">
							<xsl:with-param name="path" select="INICIO/GESTIONCOMERCIAL/FIDRESPONSABLE/field"/>
	    					<xsl:with-param name="claSel">w160px</xsl:with-param>
						</xsl:call-template>
					</td>
					<xsl:if test="INICIO/EMPRESAS/field/@current != ''">
					<td class="w200px textLeft">
						<label><xsl:value-of select="document($doc)/translation/texts/item[@name='centro']/node()"/>:&nbsp;<br/></label>
						<select name="FIDCENTRO" id="FIDCENTRO" class="w200px">
					  	<xsl:for-each select="INICIO/LISTACENTROS/field/dropDownList/listElem">
    						<option value="{ID}"><xsl:value-of select="listItem" /></option>
					  	</xsl:for-each>
						</select>
					</td>
					</xsl:if>
					<td class="w120px textLeft">
						<label><xsl:value-of select="document($doc)/translation/texts/item[@name='tipo']/node()"/>:&nbsp;<br/></label>
						<!--	tipo	-->
						<xsl:call-template name="desplegable">
							<xsl:with-param name="path" select="INICIO/FIDTIPO/field"/>
	    					<xsl:with-param name="claSel">w120px</xsl:with-param>
						</xsl:call-template>
					</td>
					<td class="w160px textLeft">
						<label><xsl:value-of select="document($doc)/translation/texts/item[@name='texto']/node()"/>:&nbsp;<br/></label>
						<!--	texto	-->
						<input type="text" name="FTEXTO" size="30" value="{INICIO/GESTIONCOMERCIAL/FTEXTO}" class="campopesquisa w160px"/>
					</td>
					<td class="w120px textLeft">
						<label><xsl:value-of select="document($doc)/translation/texts/item[@name='estado']/node()"/>:&nbsp;<br/></label>
						<!--	texto	-->
						<xsl:call-template name="desplegable">
							<xsl:with-param name="path" select="INICIO/GESTIONCOMERCIAL/FESTADO/field"/>
							<xsl:with-param name="defecto" select="INICIO/GESTIONCOMERCIAL/FESTADO/field/@current"/>
	    					<xsl:with-param name="claSel">w120px</xsl:with-param>
						</xsl:call-template>
					</td>
					<td class="w120px textLeft">
						<label><xsl:value-of select="document($doc)/translation/texts/item[@name='prioridad']/node()"/>:&nbsp;<br/></label>
						<!--	prioridad	-->
						<xsl:call-template name="desplegable">
							<xsl:with-param name="path" select="INICIO/GESTIONCOMERCIAL/FPRIORIDAD/field"/>
	    					<xsl:with-param name="claSel">w120px</xsl:with-param>
 						</xsl:call-template>
					</td>
					<td class="w120px textLeft">
						<br/>
						<select name="NumLineas" id="NumLineas" onchange="mostrarLineas(this.value);" class="w120px"> <!--	se aplica en el javascript-->
							<option value="10">
								10 <xsl:value-of select="document($doc)/translation/texts/item[@name='lineas']/node()"/>
							</option>
							<option value="20" selected="selected">
								20 <xsl:value-of select="document($doc)/translation/texts/item[@name='lineas']/node()"/>
							</option>
							<option value="50">
								50 <xsl:value-of select="document($doc)/translation/texts/item[@name='lineas']/node()"/>
							</option>
							<option value="todas">
								<xsl:value-of select="document($doc)/translation/texts/item[@name='todas']/node()"/>
							</option>
						</select>
					</td>
					<td class="w120px textLeft">
						<br/>
						<a class="btnDestacado" href="javascript:BuscarTareas();"><xsl:value-of select="document($doc)/translation/texts/item[@name='buscar']/node()"/></a>
					</td>
					<td>&nbsp;</td>
				</tr>
			</table>
			</div>
			<div class="divLeft textCenter space40px">
			<div class="linha_separacao_cotacao_y"></div>
			<div class="tabela tabela_redonda">
			<table id="ListaTareas" cellspacing="10px" cellpadding="10px">
			<thead class="cabecalho_tabela">
				<tr>
					<th class="w1px">&nbsp;</th>
					<th class="w50px textLeft">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='fecha']/node()"/></th>
					<th class="w100px textLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='responsable']/node()"/></th>
					<th class="textLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='empresa']/node()"/></th>
					<th class="textLeft"><span class="centroBox"><xsl:value-of select="document($doc)/translation/texts/item[@name='centro']/node()"/></span></th>
					<th class="w100px textLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='tipo']/node()"/></th>
					<th class="dos textLeft">&nbsp;</th><!--semaforo si caduca-->
					<th class="textLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='descripcion_tarea']/node()"/></th>
					<th class="textLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='documento']/node()"/></th>
					<th class="w100px textLeft">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_limite']/node()"/></th>
					<th class="w100px textLeft">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='estado']/node()"/></th>
					<th class="w100px textLeft">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='prioridad']/node()"/></th>
					<th class="w1px">&nbsp;</th>
					<th class="w1px">&nbsp;</th>
				</tr>
			</thead>
    	    <tbody class="corpo_tabela">
			<xsl:for-each select="INICIO/GESTIONCOMERCIAL/GESTION">
				<tr class="conhover">
        			<xsl:choose>
					<xsl:when test="MODIFICADO_1HORA">
						<xsl:attribute name="style">background:#ff9900;</xsl:attribute>
					</xsl:when>
					<xsl:when test="MODIFICADO_24HORAS">
						<xsl:attribute name="style">background:#FFFF99;</xsl:attribute>
					</xsl:when>
       				<xsl:otherwise>
						<xsl:attribute name="style"></xsl:attribute>
        			</xsl:otherwise>
					</xsl:choose>
					<xsl:variable name="id" select="ID"/>
       				<td class="color_status">&nbsp;</td>
					<td class="textLeft">
            			<xsl:choose>
            			<xsl:when test="/Tareas/INICIO/GESTIONCOMERCIAL/USUARIOCONECTADO/US_ID=IDAUTOR or /Tareas/INICIO/GESTIONCOMERCIAL/USUARIOCONECTADO/US_ID=IDRESPONSABLE or /Tareas/INICIO/SUPERUSUARIO">
                			&nbsp;<a href="javascript:EditarGestion('{ID}');">
								<xsl:value-of select="FECHA"/>
							</a>
						</xsl:when>
       					<xsl:otherwise>
							&nbsp;<xsl:value-of select="FECHA"/>
        				</xsl:otherwise>
						</xsl:choose>
					</td>
					<td class="textLeft">
              			<xsl:value-of select="RESPONSABLE"/>
					</td>
					<td class="textLeft">
						<a href="javascript:CambiarEmpresaID({IDEMPRESA});">
							<xsl:value-of select="EMPRESA"/>
						</a>
					</td>
          			<td class="textLeft">
						<xsl:value-of select="CENTRO"/>
          			</td>
         			 <!--TIPO-->
         			<td class="textLeft">
						<xsl:value-of select="TIPO"/>
					</td>
        			<td><!--semaforo si caduca-->
            			<xsl:if test="CADUCADA">&nbsp;<img src="http://www.newco.dev.br/images/bolaRoja.gif" /></xsl:if>
            			<xsl:if test="ACCION_INMEDIATA">&nbsp;<img src="http://www.newco.dev.br/images/bolaAmbar.gif" /></xsl:if>
        			</td>
					<td class="textLeft">
            			<xsl:value-of select="TEXTO" />
        			</td>
					<td class="textLeft">
            			<a href="http://www.newco.dev.br/Documentos/{DOC_SEGUIMIENTO/URL}" target="_blank"><xsl:value-of select="DOC_SEGUIMIENTO/NOMBRE"/></a>
        			</td>
          			<!--<td>&nbsp;</td>-->
					<td class="textLeft">
						&nbsp;<xsl:choose>
						<xsl:when test="(/Tareas/INICIO/GESTIONCOMERCIAL/USUARIOCONECTADO/US_ID=IDAUTOR or /Tareas/INICIO/SUPERUSUARIO) and CADUCADA">
							<span class="rojoNormal"><xsl:value-of select="FECHALIMITE"/></span>
						</xsl:when>
						<xsl:otherwise>
                             <xsl:value-of select="FECHALIMITE"/>
						</xsl:otherwise>
						</xsl:choose>
					</td>
					<td class="textLeft">
							&nbsp;<xsl:value-of select="ESTADO"/>
					</td>
					<td class="textLeft">
							&nbsp;<xsl:value-of select="PRIORIDAD"/>
					</td>
					<td class="center">
            			<xsl:if test="/Tareas/INICIO/COMERCIAL and (/Tareas/INICIO/GESTIONCOMERCIAL/USUARIOCONECTADO/US_ID=IDAUTOR or /Tareas/INICIO/GESTIONCOMERCIAL/USUARIOCONECTADO/US_ID=IDRESPONSABLE or /Tareas/INICIO/SUPERUSUARIO)"><!--si hay la marca de comercial enseño botones-->
                			<a class="btnDestacado" href="javascript:CambiarEstadoGestion('{ID}','3');"><!--estado 3 igual finalizada-->
                			  F <!--<img src="http://www.newco.dev.br/images/finalizar.gif" alt="Finalizar"/>-->
                			</a>
            			</xsl:if>
					</td>
					<td class="center">
            			<xsl:if test="/Tareas/INICIO/COMERCIAL and (/Tareas/INICIO/GESTIONCOMERCIAL/USUARIOCONECTADO/US_ID=IDAUTOR or /Tareas/INICIO/GESTIONCOMERCIAL/USUARIOCONECTADO/US_ID=IDRESPONSABLE or /Tareas/INICIO/SUPERUSUARIO)"><!--si hay la marca de comercial enseño botones-->
                			<a href="javascript:BorrarGestion('{ID}');">
                				<img src="http://www.newco.dev.br/images/2017/trash.png" alt="Borrar"/>
                			</a>
            			</xsl:if>
					</td>
				</tr>
      			</xsl:for-each>
			</tbody>
			<tfoot class="rodape_tabela"><tr><td colspan="14">&nbsp;</td></tr></tfoot>
      	</table>
		</div>
		</div>
      </xsl:when>
      <xsl:otherwise>
     	<table class="w1000px">
        <tr><td align="center"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='tareas_sin_resultados']/node()"/></strong></td></tr>
     	</table>
      </xsl:otherwise>
      </xsl:choose>
			<!-- FIN Tabla Tareas -->

      <br /><br />
    </div>
		</form>

		<br/>
		<br/>

		<!--form de mensaje de error de js-->
		<form name="mensajeJS">
			<input type="hidden" name="FALTA_INFORMAR_GESTION_BORRAR" value="{document($doc)/translation/texts/item[@name='falta_informar_gestion_borrar']/node()}"/>
			<input type="hidden" name="FALTA_INFORMAR_GESTION_MODIFICAR" value="{document($doc)/translation/texts/item[@name='falta_informar_gestion_modificar']/node()}"/>
			<input type="hidden" name="FALTA_INFORMAR_DESCRIPCION" value="{document($doc)/translation/texts/item[@name='falta_informar_descripcion']/node()}"/>
			<input type="hidden" name="FORMATO_FECHA_LIMITE_NO_OK" value="{document($doc)/translation/texts/item[@name='formato_fecha_limite_no_ok']/node()}"/>
      <input type="hidden" name="FECHA_LIMITE_OBLI" value="{document($doc)/translation/texts/item[@name='fecha_limite_obli']/node()}"/>
		</form>
	</xsl:otherwise>
	</xsl:choose>
</body>
</html>
</xsl:template>
</xsl:stylesheet>
