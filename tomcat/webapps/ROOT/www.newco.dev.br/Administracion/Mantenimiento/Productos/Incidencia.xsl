<?xml version="1.0" encoding="iso-8859-1"?>
<!--
	Incidencia de producto
	Ultima revisi�n: ET 7jun17 08:48
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
		<xsl:when test="Incidencia/LANG"><xsl:value-of select="Incidencia/LANG"/></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
	</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<title><xsl:value-of select="document($doc)/translation/texts/item[@name='incidencia']/node()"/></title>

	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->
        <link rel="stylesheet" href="http://www.newco.dev.br/General/estiloPrintComercial.css" type="text/css" media="print"/>

	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery-1.8.3.min.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/Administracion/Mantenimiento/Productos/proIncidencias170915.js"></script>
        
        <!--codigo etiquetas-->
	<script type="text/javascript" src="http://www.newco.dev.br/General/Tabla-popup.150715.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/Gestion/Comercial/etiquetas.js"></script>

	<link rel="stylesheet" href="http://www.newco.dev.br/General/lightbox.css" type="text/css" media="screen"/>
	<link href="http://www.newco.dev.br/General/Tabla-popup.150715.css" rel="stylesheet" type="text/css"/>
        <!--fin codigo etiquetas-->
        
	<script type="text/javascript">
		var textoIncidenciaObli		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='texto_incidencia_obli']/node()"/>';
		var noCambiosIncidencia		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='no_ha_cambiado_incidencia']/node()"/>';
		var seguroSalirIncidencia	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='seguro_salir_incidencia']/node()"/>';

		var recordProvOK		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='recordatorio_proveedor_OK']/node()"/>';
		var recordProvERR		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='recordatorio_proveedor_ERROR']/node()"/>';
                <!-- Variables y Strings JS para las etiquetas -->
		var IDRegistro = '<xsl:value-of select="/Incidencia/INCIDENCIA/PROD_INC_ID"/>';
		var IDTipo = 'INC';
		var str_NuevaEtiquetaGuardada	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='nueva_etiqueta_guardada']/node()"/>';
		var str_NuevaEtiquetaError		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='nueva_etiqueta_error']/node()"/>';
		var str_autor			= '<xsl:value-of select="document($doc)/translation/texts/item[@name='autor']/node()"/>';
		var str_fecha			= '<xsl:value-of select="document($doc)/translation/texts/item[@name='fecha']/node()"/>';
		var str_etiqueta	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='etiqueta']/node()"/>';
		var str_borrar		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='borrar']/node()"/>';
		<!-- FIN Variables y Strings JS para las etiquetas -->
	</script>
</head>
<body onload="RecuperaBienText();">
<xsl:choose>
<xsl:when test="Incidencia/SESION_CADUCADA">
	<xsl:for-each select="Incidencia/SESION_CADUCADA">
		<xsl:if test="position()=last()">
			<xsl:apply-templates select="."/>
		</xsl:if>
	</xsl:for-each>
</xsl:when>
<xsl:when test="//xsql-error">
	<xsl:apply-templates select="//xsql-error"/>
</xsl:when>
<xsl:otherwise>
	<!--idioma-->
	<xsl:variable name="lang">
	<xsl:choose>
		<xsl:when test="Incidencia/LANG"><xsl:value-of select="Incidencia/LANG" /></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
	</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<xsl:variable name="usuario">
	<xsl:choose>
		<xsl:when test="/Incidencia/INCIDENCIA/OBSERVADOR">OBSERVADOR</xsl:when>
		<xsl:when test="/Incidencia/INCIDENCIA/CDC and /Incidencia/INCIDENCIA/IDEMPRESAUSUARIO = /Incidencia/INCIDENCIA/PROD_INC_IDCLIENTE">CDC</xsl:when>
		<xsl:otherwise>NORMAL</xsl:otherwise>
	</xsl:choose>
	</xsl:variable>
        
        <xsl:variable name="usuarioAutor">
	<xsl:choose>
                <xsl:when test="/Incidencia/INCIDENCIA/IDUSUARIO = /Incidencia/INCIDENCIA/PROD_INC_IDUSUARIO">AUTOR</xsl:when>
		<xsl:when test="/Incidencia/AUTOR">AUTOR</xsl:when>
		<xsl:otherwise>NORMAL</xsl:otherwise>
	</xsl:choose>
	</xsl:variable>

	<div style="float:left;"><!-- Bloque de pesta�as solo si mvm o mvmb -->
	<xsl:choose>
	<xsl:when test="/Incidencia/OK">
		<a href="http://www.newco.dev.br/Administracion/Mantenimiento/Productos/PRODetalle.xsql?PRO_ID={/Incidencia/PRO_ID}&amp;IDCLIENTE={/Incidencia/INCIDENCIA/PROD_INC_IDCLIENTE}" style="text-decoration:none;">
		<xsl:choose>
		<xsl:when test="/Incidencia/LANG = 'spanish'">
			<img src="http://www.newco.dev.br/images/botonFicha.gif" alt="FICHA"/>
		</xsl:when>
		<xsl:otherwise>
			<img src="http://www.newco.dev.br/images/botonFicha.gif" alt="FICHA"/>
		</xsl:otherwise>
		</xsl:choose>
		</a>
	</xsl:when>
	<xsl:otherwise>
		<a href="http://www.newco.dev.br/Administracion/Mantenimiento/Productos/PRODetalle.xsql?PRO_ID={/Incidencia/INCIDENCIA/PROD_INC_IDPRODUCTO}&amp;IDCLIENTE={/Incidencia/INCIDENCIA/PROD_INC_IDCLIENTE}" style="text-decoration:none;">
		<xsl:choose>
		<xsl:when test="/Incidencia/LANG = 'spanish'">
			<img src="http://www.newco.dev.br/images/botonFicha.gif" alt="FICHA"/>
		</xsl:when>
		<xsl:otherwise>
			<img src="http://www.newco.dev.br/images/botonFicha.gif" alt="FICHA"/>
		</xsl:otherwise>
		</xsl:choose>
		</a>

	<!--productos equivalentes-->
	<xsl:if test="$usuario = 'CDC' or $usuario = 'OBSERVADOR' or /Incidencia/INCIDENCIA/MVM or /Incidencia/INCIDENCIA/MVMB">
		&nbsp;
		<a style="text-decoration:none;">
			<xsl:attribute name="href">http://www.newco.dev.br/Administracion/Mantenimiento/Productos/PRODetalle.xsql?PRO_ID=<xsl:value-of select="/Incidencia/PRO_ID"/>&amp;IDCLIENTE=<xsl:value-of select="/Incidencia/INCIDENCIA/PROD_INC_IDCLIENTE"/>&amp;USER=CDC&amp;DEST=EQUIV</xsl:attribute>

			<xsl:choose>
			<xsl:when test="/Incidencia/LANG = 'spanish'">
				<img src="http://www.newco.dev.br/images/botonEquivalentes.gif" alt="EQUIVALENTES"/>
			</xsl:when>
			<xsl:otherwise>
				<img src="http://www.newco.dev.br/images/botonEquivalentes-Br.gif" alt="EQUIVALENTES"/>
			</xsl:otherwise>
			</xsl:choose>
		</a>
	</xsl:if>
	</xsl:otherwise>
	</xsl:choose>
	</div><!--fin de bloque de pesta�as-->

	<div style="float:right;">
	<xsl:choose>
	<xsl:when test="/Incidencia/OK">
		<a href="http://www.newco.dev.br/Administracion/Mantenimiento/Productos/Incidencias.xsql?PRO_ID={/Incidencia/PRO_ID}" style="text-decoration:none;">
		<xsl:choose>
		<xsl:when test="/Incidencia/LANG = 'spanish'">
			<img src="http://www.newco.dev.br/images/botonIncidencias.gif" alt="INCIDENCIAS"/>
		</xsl:when>
		<xsl:otherwise>
			<img src="http://www.newco.dev.br/images/botonIncidencias-Br.gif" alt="INCIDENCIAS"/>
		</xsl:otherwise>
		</xsl:choose>
		</a>
	</xsl:when>
	<xsl:otherwise>
		<a href="http://www.newco.dev.br/Administracion/Mantenimiento/Productos/Incidencias.xsql?PRO_ID={/Incidencia/INCIDENCIA/PROD_INC_IDPRODUCTO}" style="text-decoration:none;">
		<xsl:choose>
		<xsl:when test="/Incidencia/LANG = 'spanish'">
			<img src="http://www.newco.dev.br/images/botonIncidencias.gif" alt="INCIDENCIAS"/>
		</xsl:when>
		<xsl:otherwise>
			<img src="http://www.newco.dev.br/images/botonIncidencias-Br.gif" alt="INCIDENCIAS"/>
		</xsl:otherwise>
		</xsl:choose>
		</a>

	<!-- Para crear nueva incidencia solo los usuarios de la empresa -->
	<xsl:if test="/Incidencia/INCIDENCIA/IDEMPRESAUSUARIO = /Incidencia/INCIDENCIA/PROD_INC_IDCLIENTE and $usuario != 'OBSERVADOR'">
		&nbsp;
		<a href="http://www.newco.dev.br/Administracion/Mantenimiento/Productos/NuevaIncidencia.xsql?PRO_ID={/Incidencia/INCIDENCIA/PROD_INC_IDPRODUCTO}" style="text-decoration:none;">
		<xsl:choose>
		<xsl:when test="/Incidencia/LANG = 'spanish'">
			<img src="http://www.newco.dev.br/images/botonNuevaIncidencia.gif" alt="NUEVAINCIDENCIA"/>
		</xsl:when>
		<xsl:otherwise>
			<img src="http://www.newco.dev.br/images/botonNuevaIncidencia-Br.gif" alt="NUEVAINCIDENCIA"/>
		</xsl:otherwise>
		</xsl:choose>
		</a>
	</xsl:if>
	</xsl:otherwise>
	</xsl:choose>
	</div>

	<div class="divLeft">
	<xsl:choose>
	<xsl:when test="Incidencia/ERROR">
		<h1 class="titlePage"><xsl:value-of select="document($doc)/translation/texts/item[@name='error_incidencia']/node()"/></h1>
	</xsl:when>
	<xsl:otherwise>
		<!--	Titulo de la p�gina		-->
		<div class="ZonaTituloPagina">
			<p class="Path"><xsl:value-of select="document($doc)/translation/texts/item[@name='Inicio']/node()"/>&nbsp;/&nbsp;<span class="FinPath"><xsl:value-of select="document($doc)/translation/texts/item[@name='incidencia']/node()"/>&nbsp;<xsl:value-of select="/Incidencia/INCIDENCIA/PROD_INC_CODIGO"/>
				</span>
				&nbsp;&nbsp;&nbsp;<xsl:if test="Incidencia/OK"><xsl:value-of select="document($doc)/translation/texts/item[@name='incidencia_guardada_exito']/node()"/></xsl:if>
			</p>
			<p class="TituloPagina">
				<xsl:choose>
					<xsl:when test="/Incidencia/INCIDENCIA/PROD_INC_REFCLIENTE != ''">
					<xsl:value-of select="/Incidencia/INCIDENCIA/PROD_INC_REFCLIENTE"/>
				</xsl:when>
				<xsl:otherwise>
                    <!--15jun18     -->
                    <xsl:choose>
                    <xsl:when test="/Incidencia/INCIDENCIA/PROD_INC_REFERENCIA!=''"><xsl:value-of select="/Incidencia/INCIDENCIA/PROD_INC_REFERENCIA"/></xsl:when>
                    <xsl:otherwise><xsl:value-of select="/Incidencia/INCIDENCIA/PROD_INC_REFPROVEEDOR"/></xsl:otherwise>
                    </xsl:choose>
				</xsl:otherwise>
				</xsl:choose>:&nbsp;
				<xsl:choose>
					<xsl:when test="string-length(/Incidencia/INCIDENCIA/PROD_INC_NOMBRE) > 70">
					<xsl:value-of select="substring(/Incidencia/INCIDENCIA/PROD_INC_DESCESTANDAR, 1, 70)"/>...
				</xsl:when>
				<xsl:otherwise>
                    <!--15jun18     -->
                    <xsl:choose>
                    <xsl:when test="/Incidencia/INCIDENCIA/PROD_INC_DESCESTANDAR!=''"><xsl:value-of select="/Incidencia/INCIDENCIA/PROD_INC_DESCESTANDAR"/></xsl:when>
                    <xsl:otherwise><xsl:value-of select="/Incidencia/INCIDENCIA/PROD_INC_NOMBRE"/></xsl:otherwise>
                    </xsl:choose>
				</xsl:otherwise>
				</xsl:choose>
				<xsl:if test="/Incidencia/INCIDENCIA/MVM or /Incidencia/INCIDENCIA/MVMB or /Incidencia/INCIDENCIA/ADMIN">&nbsp;<span class="amarillo">INC_ID: <xsl:value-of select="/Incidencia/INCIDENCIA/PROD_INC_ID"/></span></xsl:if>
				<span class="CompletarTitulo" width="700px">
					<!--
					
					<a class="btnDestacado" href="http://www.newco.dev.br/Gestion/Comercial/EvaluacionProductos.xsql">
                    	<xsl:value-of select="document($doc)/translation/texts/item[@name='evaluaciones']/node()"/>
                    </a>
					&nbsp;
					-->
					<!-- BOTONES DE ACCION -->
					<!--proveedor diagnostico-->
					<xsl:if test="/Incidencia/INCIDENCIA/PROD_INC_IDESTADO = 'INC' and (/Incidencia/INCIDENCIA/IDUSUARIO = /Incidencia/INCIDENCIA/PROD_INC_IDUSUARIODIAGNOSTICO or $usuario = 'CDC')">
							<a class="btnDestacado" href="javascript:GuardarIncidencia(document.forms['Incidencia'],'INC');">
								<xsl:value-of select="document($doc)/translation/texts/item[@name='informar_pero_pendiente']/node()"/>
							</a>&nbsp;
							<a class="btnDestacado" href="javascript:GuardarIncidencia(document.forms['Incidencia'],'DIAG');">
								<xsl:value-of select="document($doc)/translation/texts/item[@name='diagnostico']/node()"/>
							</a>&nbsp;
 					</xsl:if>
					<!--cdc hace una propuesta de solucion-->
                    <xsl:if test="$usuario = 'CDC' and /Incidencia/INCIDENCIA/PROD_INC_IDESTADO = 'DIAG'">
							<a class="btnDestacado" href="javascript:GuardarIncidencia(document.forms['Incidencia'],'P');">
								<xsl:value-of select="document($doc)/translation/texts/item[@name='propuesta']/node()"/>
							</a>&nbsp;
							<a class="btnDestacado" href="javascript:GuardarIncidencia(document.forms['Incidencia'],'INC');">
								<xsl:value-of select="document($doc)/translation/texts/item[@name='rechazar']/node()"/>
							</a>&nbsp;
                    </xsl:if>
                   	<!--clinica responde, si ok incidencia cerrada, si no vuelve a cdc-->
					<xsl:if test="$usuarioAutor = 'AUTOR' and /Incidencia/INCIDENCIA/PROD_INC_IDESTADO = 'P'">
							<a class="btnDestacado" href="javascript:GuardarIncidencia(document.forms['Incidencia'],'RHOSP');">
								<xsl:value-of select="document($doc)/translation/texts/item[@name='rechazar']/node()"/>
							</a>&nbsp;
					</xsl:if>
                    <!--cdc informa la soluci�n-->
                    <xsl:if test="/Incidencia/INCIDENCIA/PROD_INC_IDESTADO = 'RHOSP' and $usuario = 'CDC'">
						<a href="javascript:GuardarIncidencia(document.forms['Incidencia'],'SOL');">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='enviar']/node()"/>
						</a>&nbsp;
					</xsl:if>

                    <!--usuario autor elige si solucion de cdc ok o no-->
                    <!--cdc puede cerrar la incidencia si esta en propuesta de soluci�n pedido de alf 5-6-15-->
                    <xsl:if test="($usuarioAutor = 'AUTOR' and /Incidencia/INCIDENCIA/PROD_INC_IDESTADO = 'P') or (/Incidencia/INCIDENCIA/PROD_INC_IDESTADO = 'P' and $usuario = 'CDC') or (/Incidencia/INCIDENCIA/PROD_INC_IDESTADO = 'SOL' and $usuarioAutor = 'AUTOR')">
						<a class="btnDestacado" href="javascript:GuardarIncidencia(document.forms['Incidencia'],'RES');">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='resuelta']/node()"/>
						</a>&nbsp;
					</xsl:if>

					<xsl:if test="/Incidencia/INCIDENCIA/MVM and /Incidencia/INCIDENCIA/PROD_INC_IDESTADO = 'RES'">
							<a class="btnDestacado" href="javascript:GuardarIncidencia(document.forms['Incidencia'],'SOL');">
								<xsl:value-of select="document($doc)/translation/texts/item[@name='retroceder']/node()"/>
							</a>&nbsp;
					</xsl:if>
					<!-- FIN BOTONES DE ACCION -->
					<a class="btnNormal" href="javascript:window.close();">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='cancelar']/node()"/>
					</a>
					&nbsp;
					<a class="btnNormal" href="javascript:window.print();">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='imprimir']/node()"/>
					</a>
				</span>
			</p>
		</div>


<!--
		<h1 class="titlePage" style="float:left;width:70%;padding-left:10%;padding-bottom:5px;">
                    
                    <a id="conEtiquetas" href="javascript:abrirEtiqueta(true);" style="text-decoration:none;display:none;">
					<img src="http://www.newco.dev.br/images/tagsAma.png" width="20px">
						<xsl:attribute name="alt"><xsl:value-of select="document($doc)/translation/texts/item[@name='ver_mas_nueva_etiqueta']/node()"/></xsl:attribute>
						<xsl:attribute name="title"><xsl:value-of select="document($doc)/translation/texts/item[@name='ver_mas_nueva_etiqueta']/node()"/></xsl:attribute>
					</img>
				</a>&nbsp;

				<a id="sinEtiquetas" href="javascript:abrirEtiqueta(false);" style="text-decoration:none;display:none;">
					<img src="http://www.newco.dev.br/images/tags.png" width="20px">
						<xsl:attribute name="alt"><xsl:value-of select="document($doc)/translation/texts/item[@name='nueva_etiqueta']/node()"/></xsl:attribute>
						<xsl:attribute name="title"><xsl:value-of select="document($doc)/translation/texts/item[@name='nueva_etiqueta']/node()"/></xsl:attribute>
					</img>
                                </a>&nbsp;

                                <xsl:choose>
                        <xsl:when test="Incidencia/OK"><xsl:value-of select="document($doc)/translation/texts/item[@name='incidencia_guardada_exito']/node()"/></xsl:when>
                        <xsl:otherwise><xsl:value-of select="document($doc)/translation/texts/item[@name='incidencia']/node()"/>&nbsp;<xsl:value-of select="/Incidencia/INCIDENCIA/PROD_INC_CODIGO"/></xsl:otherwise>
                    </xsl:choose>:&nbsp;
		<xsl:choose>
		<xsl:when test="string-length(/Incidencia/INCIDENCIA/PROD_INC_NOMBRE) > 75">
			<xsl:value-of select="substring(/Incidencia/INCIDENCIA/PROD_INC_DESCESTANDAR, 1, 75)"/>...
		</xsl:when>
		<xsl:otherwise>
			<xsl:value-of select="/Incidencia/INCIDENCIA/PROD_INC_DESCESTANDAR"/>
		</xsl:otherwise>
		</xsl:choose>
			&nbsp;-&nbsp;
			<xsl:value-of select="document($doc)/translation/texts/item[@name='ref_cliente']/node()"/>:&nbsp;
			<xsl:choose>
			<xsl:when test="/Incidencia/INCIDENCIA/PROD_INC_REFCLIENTE != ''">
				<xsl:value-of select="/Incidencia/INCIDENCIA/PROD_INC_REFCLIENTE"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="/Incidencia/INCIDENCIA/PROD_INC_REFERENCIA"/>
			</xsl:otherwise>
			</xsl:choose>
                        &nbsp;&nbsp;<a href="javascript:window.print();" title="Imprimir" style="text-decoration:none;">
					<img src="http://www.newco.dev.br/images/imprimir.gif" style="margin-top:-5px;" alt="Imprimir" />
				</a>
                </h1>
                <h1 class="titlePage" style="float:left;width:20%;padding-bottom:5px;">
				<xsl:if test="/Incidencia/INCIDENCIA/MVM or /Incidencia/INCIDENCIA/MVMB or /Incidencia/INCIDENCIA/ADMIN"><span style="float:right; padding:5px; font-weight:bold;" class="amarillo">INC_ID: <xsl:value-of select="/Incidencia/INCIDENCIA/PROD_INC_ID"/></span></xsl:if>
                </h1>
-->                
 
 
		<form class="formEstandar" name="Incidencia" method="post">
			<input type="hidden" name="ID_INC" id="ID_INC" value="{/Incidencia/INCIDENCIA/PROD_INC_ID}"/>
			<input type="hidden" name="PRO_ID" id="PRO_ID" value="{/Incidencia/INCIDENCIA/PROD_INC_IDPRODUCTO}"/>
			<input type="hidden" name="LIC_PROD_ID" id="LIC_PROD_ID" value="{/Incidencia/LIC_PROD_ID}"/>
			<input type="hidden" name="LIC_OFE_ID" id="LIC_OFE_ID" value="{/Incidencia/LIC_OFE_ID}"/>
			<input type="hidden" name="SEGUIR_UTILIZANDO" id="SEGUIR_UTILIZANDO" value="{/Incidencia/INCIDENCIA/PROD_INC_SEGUIRUTILIZANDO}"/>
			<input type="hidden" name="ESTADO_ACTUAL" id="ESTADO_ACTUAL" value="{/Incidencia/INCIDENCIA/PROD_INC_IDESTADO}"/>
			<input type="hidden" name="NUM_LOTE" id="NUM_LOTE" value="{/Incidencia/INCIDENCIA/PROD_INC_INFOLOTE}" />

			<!-- Inputs Carga Documentos -->
			<input type="hidden" name="ID_USUARIO" value="{/Incidencia/INCIDENCIA/IDUSUARIO}"/>
			<input type="hidden" name="IDPROVEEDOR" value="{/Incidencia/INCIDENCIA/PROD_INC_IDPROVEEDOR}"/>
			<input type="hidden" name="REMOVE" value="{document($doc)/translation/texts/item[@name='remove']/node()}"/>
			<input type="hidden" name="DOCUMENTOS_BORRADOS"/>
			<input type="hidden" name="BORRAR_ANTERIORES"/>
			<input type="hidden" name="CADENA_DOCUMENTOS"/>
			<input type="hidden" name="TIPO_DOC_DB" id="TIPO_DOC_DB"/>
			<input type="hidden" name="TIPO_DOC_HTML" id="TIPO_DOC_HTML"/>
			<input type="hidden" name="PROD_INC_IDDOCINCIDENCIA" id="DOC_INC" value="{/Incidencia/INCIDENCIA/DOCUMENTO_INCIDENCIA/ID}"/>
			<input type="hidden" name="PROD_INC_IDDOCDIAGNOSTICO" id="DOC_DIAG" value="{/Incidencia/INCIDENCIA/DOCUMENTO_DIAGNOSTICO/ID}"/>
			<input type="hidden" name="PROD_INC_IDDOCSOLUCION" id="DOC_SOL" value="{/Incidencia/INCIDENCIA/DOCUMENTO_SOLUCION/ID}"/>
			<input type="hidden" name="PROD_INC_IDDOCPROPSOLUCION" id="DOC_P" value="{/Incidencia/INCIDENCIA/DOCUMENTO_PROPSOLUCION/ID}"/>

    	<div>
        	<ul style="width:1000px;">
             	<li>
					<label>&nbsp;</label>
					<xsl:choose>
					<xsl:when test="/Incidencia/LANG = 'spanish'">
    					<xsl:choose>
        					<xsl:when test="/Incidencia/INCIDENCIA/PROD_INC_IDESTADO = 'INC'">
            					<img src="http://www.newco.dev.br/images/step2inc.gif" alt="Diagn�stico" />
        					</xsl:when>
        					<xsl:when test="/Incidencia/INCIDENCIA/PROD_INC_IDESTADO = 'DIAG'">
            					<img src="http://www.newco.dev.br/images/step3inc.gif" alt="Propuesta de soluci�n" />
        					</xsl:when>
        					<xsl:when test="/Incidencia/INCIDENCIA/PROD_INC_IDESTADO = 'P'">
            					<img src="http://www.newco.dev.br/images/step4inc.gif" alt="Respuesta" />
        					</xsl:when>
        					<xsl:when test="/Incidencia/INCIDENCIA/PROD_INC_IDESTADO = 'RES'">
            					<img src="http://www.newco.dev.br/images/step5inc.gif" alt="Finalizada" />
        					</xsl:when>
    					</xsl:choose>
					</xsl:when>
					<xsl:otherwise>
    					<xsl:choose>
        					<xsl:when test="/Incidencia/INCIDENCIA/PROD_INC_IDESTADO = 'INC'">
            					<img src="http://www.newco.dev.br/images/step2inc-BR.gif" alt="Diagn�stico" />
        					</xsl:when>
        					<xsl:when test="/Incidencia/INCIDENCIA/PROD_INC_IDESTADO = 'DIAG'">
            					<img src="http://www.newco.dev.br/images/step3inc-BR.gif" alt="Solu��o proposta" />
        					</xsl:when>
        					<xsl:when test="/Incidencia/INCIDENCIA/PROD_INC_IDESTADO = 'P'">
            					<img src="http://www.newco.dev.br/images/step4inc-BR.gif" alt="Resposta" />
        					</xsl:when>
        					<xsl:when test="/Incidencia/INCIDENCIA/PROD_INC_IDESTADO = 'RES'">
            					<img src="http://www.newco.dev.br/images/step5inc-BR.gif" alt="Terminado" />
        					</xsl:when>
    					</xsl:choose>
					</xsl:otherwise>
					</xsl:choose>
 				</li>
              	<li>
					<strong>
					<xsl:value-of select="document($doc)/translation/texts/item[@name='incidencia']/node()"/>
					<xsl:if test="/Incidencia/INCIDENCIA/PROD_INC_FECHA != ''">
					<span style="float:right;padding-right:30px;">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='fecha']/node()"/>:&nbsp;<xsl:value-of select="/Incidencia/INCIDENCIA/PROD_INC_FECHA"/>
					</span>
					</xsl:if>
					</strong>
 				</li>
				<li>
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='responsable_incidencia']/node()"/>:</label>
					<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/CENDetalle.xsql?ID={/Incidencia/INCIDENCIA/PROD_INC_IDCENTROCLIENTE}','Centro',100,80,0,-20);">
					<xsl:value-of select="/Incidencia/INCIDENCIA/CENTROCLIENTE"/></a>:&nbsp;<xsl:value-of select="/Incidencia/INCIDENCIA/USUARIO"/>
				</li>
				<li>
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='incidencia']/node()"/>:</label>
                    <textarea name="INCIDENCIA" id="INCIDENCIA" cols="40" rows="7" style="display:none;">
                        <xsl:copy-of select="/Incidencia/INCIDENCIA/PROD_INC_DESCRIPCION/node()" />
                    </textarea>
                    <xsl:copy-of select="/Incidencia/INCIDENCIA/PROD_INC_DESCRIPCION" disable-output-escaping="yes"/>
				</li>
				<li>
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='num_lote']/node()"/>:</label>
                    <xsl:value-of select="/Incidencia/INCIDENCIA/PROD_INC_INFOLOTE"/>&nbsp;
				</li>
				<li>
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='usuario_quiere_seguir_utilizando']/node()"/>:</label>
                    <xsl:choose>
                        <xsl:when test="/Incidencia/INCIDENCIA/PROD_INC_SEGUIRUTILIZANDO = 'S'">
                            <xsl:value-of select="document($doc)/translation/texts/item[@name='si']/node()"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="document($doc)/translation/texts/item[@name='no']/node()"/>
                        </xsl:otherwise>
                    </xsl:choose>
				</li>
				<xsl:if test="/Incidencia/INCIDENCIA/DOCUMENTO_INCIDENCIA/ID">
					<li>
						<label><xsl:value-of select="document($doc)/translation/texts/item[@name='documento_incidencia']/node()"/>:</label>
						<a href="http://www.newco.dev.br/Documentos/{/Incidencia/INCIDENCIA/DOCUMENTO_INCIDENCIA/URL}" target="_blank">
							<xsl:value-of select="/Incidencia/INCIDENCIA/DOCUMENTO_INCIDENCIA/NOMBRE"/>
						</a>
					</li>
				</xsl:if>
				<xsl:if test="/Incidencia/INCIDENCIA/PROD_INC_IDESTADO = 'INC' and $usuario = 'CDC'">
					<li>
						<label>&nbsp;</label>
						<a href="http://www.newco.dev.br/Documentos/{/Incidencia/INCIDENCIA/DOCUMENTO_INCIDENCIA/URL}" target="_blank">
							<a href="javascript:recordatorioProveedor({/Incidencia/INCIDENCIA/PROD_INC_IDUSUARIODIAGNOSTICO},{/Incidencia/INCIDENCIA/PROD_INC_ID});">Recordatorio Proveedor</a>
						</a>
					</li>
				</xsl:if>
              	<li>
					<strong>
						<xsl:value-of select="document($doc)/translation/texts/item[@name='diagnostico']/node()"/>
						<xsl:if test="/Incidencia/INCIDENCIA/PROD_INC_FECHADIAGNOSTICO != ''">
							<span style="float:right;padding-right:30px;">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='fecha']/node()"/>:&nbsp;<xsl:value-of select="/Incidencia/INCIDENCIA/PROD_INC_FECHADIAGNOSTICO"/>
							</span>
						</xsl:if>
					</strong>
 				</li>
				<li>
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='responsable_diagnostico']/node()"/>:</label>
					<xsl:choose>
					<xsl:when test="/Incidencia/INCIDENCIA/USUARIODIAGNOSTICO">
						<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPDetalleFrame.xsql?EMP_ID={/Incidencia/INCIDENCIA/PROD_INC_IDPROVEEDOR}&amp;VENTANA=NUEVA','Proveedor',100,80,0,-20);">
						<xsl:value-of select="/Incidencia/INCIDENCIA/PROVEEDOR"/>
						</a>:&nbsp;
						<xsl:value-of select="/Incidencia/INCIDENCIA/USUARIODIAGNOSTICO"/>
					</xsl:when>
					<xsl:otherwise>
						[<xsl:value-of select="document($doc)/translation/texts/item[@name='pendiente']/node()"/>]
					</xsl:otherwise>
					</xsl:choose>
				</li>
				<xsl:choose>
				<xsl:when test="/Incidencia/INCIDENCIA/PROD_INC_IDESTADO = 'INC' and (/Incidencia/INCIDENCIA/IDUSUARIO = /Incidencia/INCIDENCIA/PROD_INC_IDUSUARIODIAGNOSTICO or $usuario = 'CDC')">
					<li>
						<label><xsl:value-of select="document($doc)/translation/texts/item[@name='diagnostico']/node()"/>:</label>
						<textarea name="DIAGNOSTICO_OLD" id="DIAGNOSTICO_OLD" style="display:none;">
							<xsl:copy-of select="/Incidencia/INCIDENCIA/PROD_INC_DIAGNOSTICO/node()" disable-output-escaping="yes"/>
						</textarea> 
						<textarea name="DIAGNOSTICO" id="DIAGNOSTICO" rows="4" cols="60">
							<xsl:copy-of select="/Incidencia/INCIDENCIA/PROD_INC_DIAGNOSTICO/node()" disable-output-escaping="yes"/>
						</textarea>
					</li>
					<li>
						<label><xsl:value-of select="document($doc)/translation/texts/item[@name='documento_diagnostico']/node()"/>:</label>
						<xsl:choose>
						<xsl:when test="/Incidencia/INCIDENCIA/DOCUMENTO_DIAGNOSTICO/ID">
							<span id="newDocDIAG" align="center" style="display:none;">
								<a href="javascript:verCargaDoc('DIAG');" title="Subir documento" style="text-decoration:none;">
									<img src="http://www.newco.dev.br/images/subirDocumento.gif" alt="Subir Documento" title="Subir Documento"/>
								</a>
							</span>&nbsp;
							<span id="docBoxDIAG" align="center">
								<a href="http://www.newco.dev.br/Documentos/{/Incidencia/INCIDENCIA/DOCUMENTO_DIAGNOSTICO/URL}" target="_blank">
									<xsl:value-of select="/Incidencia/INCIDENCIA/DOCUMENTO_DIAGNOSTICO/NOMBRE"/>
								</a>
							</span>&nbsp;
							<span id="borraDocDIAG" align="center">
								<a href="javascript:borrarDoc({/Incidencia/INCIDENCIA/DOCUMENTO_DIAGNOSTICO/ID},'DIAG')">
									<img src="http://www.newco.dev.br/images/2017/trash.png"/>
                                                        	</a>
							</span>
						</xsl:when>
						<xsl:otherwise>
							<span id="newDocDIAG" align="center">
								<a href="javascript:verCargaDoc('DIAG');" title="Subir documento" style="text-decoration:none;">
									<img src="http://www.newco.dev.br/images/subirDocumento.gif" alt="Subir Documento" title="Subir Documento"/>
								</a>
							</span>&nbsp;
							<span id="docBoxDIAG" style="display:none;" align="center"></span>&nbsp;
							<span id="borraDocDIAG" style="display:none;" align="center"></span>
						</xsl:otherwise>
						</xsl:choose>
					</li>
					<li id="cargaDIAG" class="cargas" style="display:none;">
						<xsl:call-template name="CargaDocumentos"><xsl:with-param name="tipo">DIAG</xsl:with-param></xsl:call-template>
					</li>
				</xsl:when>
				<xsl:otherwise>
					<li>
						<label><xsl:value-of select="document($doc)/translation/texts/item[@name='diagnostico']/node()"/>:</label>
                        <textarea name="DIAGNOSTICO" id="DIAGNOSTICO" style="display:none;">
                            <xsl:copy-of select="/Incidencia/INCIDENCIA/PROD_INC_DIAGNOSTICO/node()" disable-output-escaping="yes"/>
                        </textarea> 
                        <xsl:copy-of select="/Incidencia/INCIDENCIA/PROD_INC_DIAGNOSTICO" disable-output-escaping="yes"/>
					</li>
					<xsl:if test="/Incidencia/INCIDENCIA/DOCUMENTO_DIAGNOSTICO/ID">
						<li>
							<label><xsl:value-of select="document($doc)/translation/texts/item[@name='documento_diagnostico']/node()"/>:</label>
							<a href="http://www.newco.dev.br/Documentos/{/Incidencia/INCIDENCIA/DOCUMENTO_DIAGNOSTICO/URL}" target="_blank">
								<xsl:value-of select="/Incidencia/INCIDENCIA/DOCUMENTO_DIAGNOSTICO/NOMBRE"/>
							</a>
						</li>
					</xsl:if>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:if test="/Incidencia/INCIDENCIA/ROL != 'VENDEDOR' and (/Incidencia/INCIDENCIA/PROD_INC_IDESTADO = 'DIAG' or /Incidencia/INCIDENCIA/PROD_INC_IDESTADO = 'P' or /Incidencia/INCIDENCIA/PROD_INC_IDESTADO = 'RHOSP' or /Incidencia/INCIDENCIA/PROD_INC_IDESTADO = 'SOL' or /Incidencia/INCIDENCIA/PROD_INC_IDESTADO = 'RES')">
            <li>
				<strong>
					<xsl:value-of select="document($doc)/translation/texts/item[@name='propuesta']/node()"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='solucion']/node()"/>
					<xsl:if test="/Incidencia/INCIDENCIA/PROD_INC_FECHAPROPSOLUCION != ''">
						<span style="float:right;padding-right:30px;">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='fecha']/node()"/>:&nbsp;<xsl:value-of select="/Incidencia/INCIDENCIA/PROD_INC_FECHAPROPSOLUCION"/>
						</span>
					</xsl:if>
				</strong>
 			</li>
			<li>
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='responsable_propuesta']/node()"/>:</label>
				<xsl:choose>
				<xsl:when test="/Incidencia/INCIDENCIA/USUARIOPROPSOLUCION != ''">
					<xsl:value-of select="/Incidencia/INCIDENCIA/CENTROPROPSOLUCION" />:&nbsp;
					<xsl:value-of select="/Incidencia/INCIDENCIA/USUARIOPROPSOLUCION"/>
				</xsl:when>
				<xsl:otherwise>
					[<xsl:value-of select="document($doc)/translation/texts/item[@name='pendiente']/node()"/>]
				</xsl:otherwise>
				</xsl:choose>
			</li>
			<li>
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='propuesta']/node()"/>:</label>
				<xsl:choose>
				<xsl:when test="$usuario = 'CDC' and /Incidencia/INCIDENCIA/PROD_INC_IDESTADO = 'DIAG'">
					<textarea name="PROPUESTA_SOLUCION_OLD" id="PROPUESTA_SOLUCION_OLD" style="display:none;">
					<xsl:copy-of select="/Incidencia/INCIDENCIA/PROD_INC_PROPSOLUCION/node()" disable-output-escaping="yes"/>
					</textarea> 
				<textarea name="PROPUESTA_SOLUCION" id="PROPUESTA_SOLUCION" rows="4" cols="60">
					<xsl:copy-of select="/Incidencia/INCIDENCIA/PROD_INC_PROPSOLUCION/node()" disable-output-escaping="yes"/>
				</textarea>
				</xsl:when>
				<xsl:otherwise>
					<xsl:copy-of select="/Incidencia/INCIDENCIA/PROD_INC_PROPSOLUCION" disable-output-escaping="yes"/>
					<textarea name="PROPUESTA_SOLUCION" id="PROPUESTA_SOLUCION" rows="4" cols="60" style="display:none;">
					<xsl:copy-of select="/Incidencia/INCIDENCIA/PROD_INC_PROPSOLUCION/node()" disable-output-escaping="yes"/>
					</textarea>
				</xsl:otherwise>
				</xsl:choose>
			</li>
			<xsl:choose>
			<xsl:when test="/Incidencia/INCIDENCIA/PROD_INC_IDESTADO = 'DIAG' and $usuario = 'CDC'">
				<li>
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='documento_propuesta']/node()"/>:</label>
					<xsl:choose>
					<xsl:when test="/Incidencia/INCIDENCIA/DOCUMENTO_PROPSOLUCION/ID">
						<span id="newDocP" align="center" style="display:none;">
							<a href="javascript:verCargaDoc('P');" title="Subir documento" style="text-decoration:none;">
								<img src="http://www.newco.dev.br/images/subirDocumento.gif" alt="Subir Documento" title="Subir Documento"/>
							</a>
						</span>&nbsp;
						<span id="docBoxP" align="center">
							<a href="http://www.newco.dev.br/Documentos/{/Incidencia/INCIDENCIA/DOCUMENTO_PROPSOLUCION/URL}" target="_blank">
								<xsl:value-of select="/Incidencia/INCIDENCIA/DOCUMENTO_PROPSOLUCION/NOMBRE"/>
							</a>
						</span>&nbsp;
						<span id="borraDocP" align="center">
							<a href="javascript:borrarDoc({/Incidencia/INCIDENCIA/DOCUMENTO_PROPSOLUCION/ID},'P')">
								<img src="http://www.newco.dev.br/images/2017/trash.png"/>
                                                        </a>
						</span>
					</xsl:when>
					<xsl:otherwise>
						<span id="newDocP" align="center">
							<a href="javascript:verCargaDoc('P');" title="Subir documento" style="text-decoration:none;">
								<img src="http://www.newco.dev.br/images/subirDocumento.gif" alt="Subir Documento" title="Subir Documento"/>
							</a>
						</span>&nbsp;
						<span id="docBoxP" style="display:none;" align="center"></span>&nbsp;
						<span id="borraDocP" style="display:none;" align="center"></span>
					</xsl:otherwise>
					</xsl:choose>
				</li>
				<li id="cargaP" class="cargas" style="display:none;">
					<xsl:call-template name="CargaDocumentos"><xsl:with-param name="tipo">P</xsl:with-param></xsl:call-template>
				</li>
				<li>
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='seguir_utilizando']/node()"/>:</label>
                    <input type="hidden" name="SEGUIR_UTILIZANDO_CDC" id="SEGUIR_UTILIZANDO_CDC" />
                    <input type="radio" name="SEGUIR_UTILIZANDO_CDC_VALUES" id="SEGUIR_UTILIZANDO_CDC_S" value="S">
                        &nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='si']/node()"/>
                    </input>&nbsp;&nbsp;
                    <input type="radio" name="SEGUIR_UTILIZANDO_CDC_VALUES" id="SEGUIR_UTILIZANDO_CDC_N" value="N">
                        &nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='no']/node()"/>
                    </input>
				</li>
            </xsl:when>
            <xsl:otherwise>
                <xsl:if test="/Incidencia/INCIDENCIA/DOCUMENTO_PROPSOLUCION/ID">
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='documento_propuesta']/node()"/>:</label>
                    <a href="http://www.newco.dev.br/Documentos/{/Incidencia/INCIDENCIA/DOCUMENTO_PROPSOLUCION/URL}" target="_blank">
                        <xsl:value-of select="/Incidencia/INCIDENCIA/DOCUMENTO_PROPSOLUCION/NOMBRE"/>
                    </a>
				</xsl:if>
				<li>
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='seguir_utilizando']/node()"/>:</label>
                    <xsl:choose>
                        <xsl:when test="/Incidencia/INCIDENCIA/PROD_INC_SEGUIRUTILIZANDO_CDC = 'S'">
                            <xsl:value-of select="document($doc)/translation/texts/item[@name='si']/node()"/>
                            <input type="hidden" name="SEGUIR_UTILIZANDO_CDC" id="SEGUIR_UTILIZANDO_CDC" value="S"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="document($doc)/translation/texts/item[@name='no']/node()"/>
                            <input type="hidden" name="SEGUIR_UTILIZANDO_CDC" id="SEGUIR_UTILIZANDO_CDC" value=""/>
                        </xsl:otherwise>
                    </xsl:choose>
				</li>
            </xsl:otherwise>
			</xsl:choose>
		</xsl:if>
		<xsl:if test="/Incidencia/INCIDENCIA/PROD_INC_IDESTADO = 'P' or /Incidencia/INCIDENCIA/PROD_INC_IDESTADO = 'RHOSP' or /Incidencia/INCIDENCIA/PROD_INC_IDESTADO = 'SOL' or /Incidencia/INCIDENCIA/PROD_INC_IDESTADO = 'RES'">
        	<li>
				<strong>
					<xsl:value-of select="document($doc)/translation/texts/item[@name='respuesta']/node()"/>
					<xsl:if test="/Incidencia/INCIDENCIA/PROD_INC_FECHARESPHOSPITAL != ''">
						<span style="float:right;padding-right:30px;">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='fecha']/node()"/>:&nbsp;<xsl:value-of select="/Incidencia/INCIDENCIA/PROD_INC_FECHARESPHOSPITAL"/>
						</span>
					</xsl:if>
				</strong>
 			</li>
			<li>
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='responsable_respuesta']/node()"/>:</label>
				<xsl:choose>
				<xsl:when test="/Incidencia/INCIDENCIA/USUARIORESPHOSPITAL">
                    <xsl:value-of select="/Incidencia/INCIDENCIA/CENTRORESPHOSPITAL"/>:&nbsp;
					<xsl:value-of select="/Incidencia/INCIDENCIA/USUARIORESPHOSPITAL"/>
				</xsl:when>
				<xsl:otherwise>
					[<xsl:value-of select="document($doc)/translation/texts/item[@name='pendiente']/node()"/>]
				</xsl:otherwise>
				</xsl:choose>
			</li>
			<li>
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='respuesta']/node()"/>:</label>
				<xsl:choose>
				<!--cliente o cdc cliente puede poner respuesta-->
				<xsl:when test="($usuarioAutor = 'AUTOR' or $usuario = 'CDC') and /Incidencia/INCIDENCIA/PROD_INC_IDESTADO = 'P'">
					<textarea name="TEXTO_RESP_HOSPITAL_OLD" id="TEXTO_RESP_HOSPITAL_OLD" style="display:none;">
						<xsl:copy-of select="/Incidencia/INCIDENCIA/PROD_INC_RESPHOSPITAL/node()" disable-output-escaping="yes"/><br/>
					</textarea> 
					<textarea name="TEXTO_RESP_HOSPITAL" id="TEXTO_RESP_HOSPITAL" rows="4" cols="60">
						<xsl:copy-of select="/Incidencia/INCIDENCIA/PROD_INC_RESPHOSPITAL/node()" disable-output-escaping="yes"/><br/>
					</textarea>
				</xsl:when>
				<xsl:otherwise>
					<xsl:copy-of select="/Incidencia/INCIDENCIA/PROD_INC_RESPHOSPITAL" disable-output-escaping="yes"/>&nbsp;
					<textarea name="TEXTO_RESP_HOSPITAL" id="TEXTO_RESP_HOSPITAL" rows="4" cols="60" style="display:none;">
						<xsl:copy-of select="/Incidencia/INCIDENCIA/PROD_INC_RESPHOSPITAL/node()" disable-output-escaping="yes"/><br/>
					</textarea>
				</xsl:otherwise>
				</xsl:choose>
			</li>
		</xsl:if>
		<xsl:if test="/Incidencia/INCIDENCIA/PROD_INC_IDESTADO = 'RHOSP' or /Incidencia/INCIDENCIA/PROD_INC_IDESTADO = 'SOL' or /Incidencia/INCIDENCIA/PROD_INC_IDESTADO = 'RES'">
			<li>
				<strong>
					<xsl:value-of select="document($doc)/translation/texts/item[@name='solucion']/node()"/>
					<xsl:if test="/Incidencia/INCIDENCIA/PROD_INC_FECHASOLUCION != ''">
						<span style="float:right;padding-right:30px;">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='fecha']/node()"/>:&nbsp;<xsl:value-of select="/Incidencia/INCIDENCIA/PROD_INC_FECHASOLUCION"/>
						</span>
					</xsl:if>
				</strong>
			</li>
			<li>
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='responsable_solucion']/node()"/>:</label>
				<xsl:choose>
				<xsl:when test="/Incidencia/INCIDENCIA/USUARIOSOLUCION">
                    <xsl:value-of select="/Incidencia/INCIDENCIA/CENTROSOLUCION"/>:&nbsp;
					<xsl:value-of select="/Incidencia/INCIDENCIA/USUARIOSOLUCION"/>
				</xsl:when>
				<xsl:otherwise>
					[<xsl:value-of select="document($doc)/translation/texts/item[@name='pendiente']/node()"/>]
				</xsl:otherwise>
				</xsl:choose>
			</li>
			<li>
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='solucion']/node()"/>:</label>
				<xsl:choose>
				<xsl:when test="$usuario = 'CDC' and /Incidencia/INCIDENCIA/PROD_INC_IDESTADO = 'RHOSP'">
					<textarea name="SOLUCION_OLD" id="SOLUCION_OLD" style="display:none;">
						<xsl:copy-of select="/Incidencia/INCIDENCIA/PROD_INC_SOLUCION/node()" disable-output-escaping="yes"/>
					</textarea> 
					<textarea name="SOLUCION" id="SOLUCION" rows="4" cols="60">
						<xsl:copy-of select="/Incidencia/INCIDENCIA/PROD_INC_SOLUCION/node()" disable-output-escaping="yes"/>
					</textarea>
				</xsl:when>
				<xsl:otherwise>
					<xsl:copy-of select="/Incidencia/INCIDENCIA/PROD_INC_SOLUCION" disable-output-escaping="yes"/>
					<textarea name="SOLUCION" id="SOLUCION" rows="4" cols="60" style="display:none;">
						<xsl:copy-of select="/Incidencia/INCIDENCIA/PROD_INC_SOLUCION/node()" disable-output-escaping="yes"/>
					</textarea>
				</xsl:otherwise>
				</xsl:choose>
			</li>
			<xsl:choose>
			<xsl:when test="$usuario = 'CDC'">
				<xsl:choose>
				<xsl:when test="/Incidencia/INCIDENCIA/DOCUMENTO_SOLUCION/ID">
				<li>
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='documento_solucion']/node()"/>:</label>
					<span id="newDocSOL" align="center" style="display:none;">
						<a href="javascript:verCargaDoc('SOL');" title="Subir documento" style="text-decoration:none;">
							<img src="http://www.newco.dev.br/images/subirDocumento.gif" alt="Subir Documento" title="Subir Documento"/>
						</a>
					</span>&nbsp;
					<span id="docBoxSOL" align="center">
						<a href="http://www.newco.dev.br/Documentos/{/Incidencia/INCIDENCIA/DOCUMENTO_SOLUCION/URL}" target="_blank">
							<xsl:value-of select="/Incidencia/INCIDENCIA/DOCUMENTO_SOLUCION/NOMBRE"/>
						</a>
					</span>&nbsp;
					<span id="borraDocSOL" align="center">
						<a href="javascript:borrarDoc({/Incidencia/INCIDENCIA/DOCUMENTO_SOLUCION/ID},'SOL')">
							<img src="http://www.newco.dev.br/images/2017/trash.png"/>
                        </a>
					</span>
				</li>
				</xsl:when>
                <xsl:when test="/Incidencia/INCIDENCIA/PROD_INC_IDESTADO = 'RHOSP'">
					<li>
						<label><xsl:value-of select="document($doc)/translation/texts/item[@name='documento_solucion']/node()"/>:</label>
                        <span id="newDocSOL" align="center">
							<a href="javascript:verCargaDoc('SOL');" title="Subir documento" style="text-decoration:none;">
								<img src="http://www.newco.dev.br/images/subirDocumento.gif" alt="Subir Documento" title="Subir Documento"/>
							</a>
						</span>&nbsp;
						<span id="docBoxSOL" style="display:none;" align="center"></span>&nbsp;
						<span id="borraDocSOL" style="display:none;" align="center"></span>
					</li>
				</xsl:when>
				</xsl:choose>
			</xsl:when>
			</xsl:choose>
			<li id="cargaSOL" class="cargas" style="display:none;">
				<label>&nbsp;</label>
				<xsl:call-template name="CargaDocumentos"><xsl:with-param name="tipo">SOL</xsl:with-param></xsl:call-template>
			</li>
		</xsl:if>
 		</ul>
 		</div>
	</form>
 
    <!--          
		<form name="Incidencia" method="post">
			<input type="hidden" name="ID_INC" id="ID_INC" value="{/Incidencia/INCIDENCIA/PROD_INC_ID}"/>
			<input type="hidden" name="PRO_ID" id="PRO_ID" value="{/Incidencia/INCIDENCIA/PROD_INC_IDPRODUCTO}"/>
			<input type="hidden" name="LIC_PROD_ID" id="LIC_PROD_ID" value="{/Incidencia/LIC_PROD_ID}"/>
			<input type="hidden" name="LIC_OFE_ID" id="LIC_OFE_ID" value="{/Incidencia/LIC_OFE_ID}"/>
            <input type="hidden" name="SEGUIR_UTILIZANDO" id="SEGUIR_UTILIZANDO" value="{/Incidencia/INCIDENCIA/PROD_INC_SEGUIRUTILIZANDO}"/>
            <input type="hidden" name="ESTADO_ACTUAL" id="ESTADO_ACTUAL" value="{/Incidencia/INCIDENCIA/PROD_INC_IDESTADO}"/>
            <input type="hidden" name="NUM_LOTE" id="NUM_LOTE" value="{/Incidencia/INCIDENCIA/PROD_INC_INFOLOTE}" />
                        
			<!- - Inputs Carga Documentos - ->
			<input type="hidden" name="ID_USUARIO" value="{/Incidencia/INCIDENCIA/IDUSUARIO}"/>
			<input type="hidden" name="IDPROVEEDOR" value="{/Incidencia/INCIDENCIA/PROD_INC_IDPROVEEDOR}"/>
			<input type="hidden" name="REMOVE" value="{document($doc)/translation/texts/item[@name='remove']/node()}"/>
			<input type="hidden" name="DOCUMENTOS_BORRADOS"/>
			<input type="hidden" name="BORRAR_ANTERIORES"/>
			<input type="hidden" name="CADENA_DOCUMENTOS"/>
			<input type="hidden" name="TIPO_DOC_DB" id="TIPO_DOC_DB"/>
			<input type="hidden" name="TIPO_DOC_HTML" id="TIPO_DOC_HTML"/>
			<input type="hidden" name="PROD_INC_IDDOCINCIDENCIA" id="DOC_INC" value="{/Incidencia/INCIDENCIA/DOCUMENTO_INCIDENCIA/ID}"/>
			<input type="hidden" name="PROD_INC_IDDOCDIAGNOSTICO" id="DOC_DIAG" value="{/Incidencia/INCIDENCIA/DOCUMENTO_DIAGNOSTICO/ID}"/>
			<input type="hidden" name="PROD_INC_IDDOCSOLUCION" id="DOC_SOL" value="{/Incidencia/INCIDENCIA/DOCUMENTO_SOLUCION/ID}"/>
                        <input type="hidden" name="PROD_INC_IDDOCPROPSOLUCION" id="DOC_P" value="{/Incidencia/INCIDENCIA/DOCUMENTO_PROPSOLUCION/ID}"/>
                        
                        <div class="divLeft5">&nbsp;</div>
                        <div class="divLeft90">
                            
                        <table class="infoTable incidencias" cellspacing="5">
				<!- - Incidencia - ->
                                <tr>
					<td>&nbsp;</td>
					<td class="datosLeft">
                                             <xsl:choose>
                                                <xsl:when test="/Incidencia/LANG = 'spanish'">
                                                    <xsl:choose>
                                                        <xsl:when test="/Incidencia/INCIDENCIA/PROD_INC_IDESTADO = 'INC'">
                                                            <img src="http://www.newco.dev.br/images/step2inc.gif" alt="Diagn�stico" />
                                                        </xsl:when>
                                                        <xsl:when test="/Incidencia/INCIDENCIA/PROD_INC_IDESTADO = 'DIAG'">
                                                            <img src="http://www.newco.dev.br/images/step3inc.gif" alt="Propuesta de soluci�n" />
                                                        </xsl:when>
                                                        <xsl:when test="/Incidencia/INCIDENCIA/PROD_INC_IDESTADO = 'P'">
                                                            <img src="http://www.newco.dev.br/images/step4inc.gif" alt="Respuesta" />
                                                        </xsl:when>
                                                        <xsl:when test="/Incidencia/INCIDENCIA/PROD_INC_IDESTADO = 'RES'">
                                                            <img src="http://www.newco.dev.br/images/step5inc.gif" alt="Finalizada" />
                                                        </xsl:when>
                                                    </xsl:choose>
                                                </xsl:when>
                                                <xsl:otherwise>
                                                    <xsl:choose>
                                                        <xsl:when test="/Incidencia/INCIDENCIA/PROD_INC_IDESTADO = 'INC'">
                                                            <img src="http://www.newco.dev.br/images/step2inc-BR.gif" alt="Diagn�stico" />
                                                        </xsl:when>
                                                        <xsl:when test="/Incidencia/INCIDENCIA/PROD_INC_IDESTADO = 'DIAG'">
                                                            <img src="http://www.newco.dev.br/images/step3inc-BR.gif" alt="Solu��o proposta" />
                                                        </xsl:when>
                                                        <xsl:when test="/Incidencia/INCIDENCIA/PROD_INC_IDESTADO = 'P'">
                                                            <img src="http://www.newco.dev.br/images/step4inc-BR.gif" alt="Resposta" />
                                                        </xsl:when>
                                                        <xsl:when test="/Incidencia/INCIDENCIA/PROD_INC_IDESTADO = 'RES'">
                                                            <img src="http://www.newco.dev.br/images/step5inc-BR.gif" alt="Terminado" />
                                                        </xsl:when>
                                                    </xsl:choose>
                                                </xsl:otherwise>
                                            </xsl:choose>
                                            
                                           
                                        </td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td class="title">
                                                    <strong>
							<xsl:value-of select="document($doc)/translation/texts/item[@name='incidencia']/node()"/>
							<xsl:if test="/Incidencia/INCIDENCIA/PROD_INC_FECHA != ''">
                                                            <span style="float:right;padding-right:30px;">
								<xsl:value-of select="document($doc)/translation/texts/item[@name='fecha']/node()"/>:&nbsp;<xsl:value-of select="/Incidencia/INCIDENCIA/PROD_INC_FECHA"/>
                                                            </span>
                                                        </xsl:if>
                                                    </strong>
                                        </td>
				</tr>
				<tr>
					<td class="trenta labelRight grisMed"><xsl:value-of select="document($doc)/translation/texts/item[@name='responsable_incidencia']/node()"/>:</td>
					<td class="datosLeft">
                                            <a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/CENDetalle.xsql?ID={/Incidencia/INCIDENCIA/PROD_INC_IDCENTROCLIENTE}','Centro',100,80,0,-20);">
                                            <xsl:value-of select="/Incidencia/INCIDENCIA/CENTROCLIENTE"/></a>:&nbsp;<xsl:value-of select="/Incidencia/INCIDENCIA/USUARIO"/>
                                        </td>
				</tr>
				<tr>
					<td class="labelRight grisMed">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='incidencia']/node()"/>:
					</td>
					<td class="datosLeft">
                                            <textarea name="INCIDENCIA" id="INCIDENCIA" cols="40" rows="7" style="display:none;">
                                                <xsl:copy-of select="/Incidencia/INCIDENCIA/PROD_INC_DESCRIPCION/node()" />
                                            </textarea>

                                            <xsl:copy-of select="/Incidencia/INCIDENCIA/PROD_INC_DESCRIPCION" disable-output-escaping="yes"/>
					</td>
				</tr>
                                <tr>
					<td class="labelRight grisMed"><xsl:value-of select="document($doc)/translation/texts/item[@name='num_lote']/node()"/>:</td>
					<td class="datosLeft">
                                            <xsl:value-of select="/Incidencia/INCIDENCIA/PROD_INC_INFOLOTE"/>
					</td>
				</tr>
                                
                                <tr>
					<td class="labelRight grisMed">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='usuario_quiere_seguir_utilizando']/node()"/>:&nbsp;
					</td>
                                        <td class="datosLeft">
                                        <xsl:choose>
                                            <xsl:when test="/Incidencia/INCIDENCIA/PROD_INC_SEGUIRUTILIZANDO = 'S'">
                                                <xsl:value-of select="document($doc)/translation/texts/item[@name='si']/node()"/>
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <xsl:value-of select="document($doc)/translation/texts/item[@name='no']/node()"/>
                                            </xsl:otherwise>
                                        </xsl:choose>
					</td>
				</tr>
			<xsl:if test="/Incidencia/INCIDENCIA/DOCUMENTO_INCIDENCIA/ID">
				<tr>
					<td class="labelRight grisMed"><xsl:value-of select="document($doc)/translation/texts/item[@name='documento_incidencia']/node()"/>:</td>
					<td class="datosLeft" colspan="2">
						<a href="http://www.newco.dev.br/Documentos/{/Incidencia/INCIDENCIA/DOCUMENTO_INCIDENCIA/URL}" target="_blank">
							<xsl:value-of select="/Incidencia/INCIDENCIA/DOCUMENTO_INCIDENCIA/NOMBRE"/>
						</a>
					</td>
				</tr>
			</xsl:if>
			<xsl:if test="/Incidencia/INCIDENCIA/PROD_INC_IDESTADO = 'INC' and $usuario = 'CDC'">
				<tr>
					<td>&nbsp;</td>
					<td class="datosLeft">
						<a href="javascript:recordatorioProveedor({/Incidencia/INCIDENCIA/PROD_INC_IDUSUARIODIAGNOSTICO},{/Incidencia/INCIDENCIA/PROD_INC_ID});">Recordatorio Proveedor</a>
					</td>
				</tr>
			</xsl:if>
				<tr class="line">
					<td colspan="2">&nbsp;</td>
				</tr>
                                
				<!- - Diagnostico - ->
				<tr>
					<td>&nbsp;</td>
					<td class="title">
						<strong>
							<xsl:value-of select="document($doc)/translation/texts/item[@name='diagnostico']/node()"/>
							<xsl:if test="/Incidencia/INCIDENCIA/PROD_INC_FECHADIAGNOSTICO != ''">
                                                            <span style="float:right;padding-right:30px;">
								<xsl:value-of select="document($doc)/translation/texts/item[@name='fecha']/node()"/>:&nbsp;<xsl:value-of select="/Incidencia/INCIDENCIA/PROD_INC_FECHADIAGNOSTICO"/>
                                                            </span>
                                                        </xsl:if>
						</strong>
					</td>
				</tr>
				<tr>
					<td class="labelRight grisMed"><xsl:value-of select="document($doc)/translation/texts/item[@name='responsable_diagnostico']/node()"/>:</td>
					<td class="datosLeft">
					<xsl:choose>
					<xsl:when test="/Incidencia/INCIDENCIA/USUARIODIAGNOSTICO">
                                            <a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPDetalleFrame.xsql?EMP_ID={/Incidencia/INCIDENCIA/PROD_INC_IDPROVEEDOR}&amp;VENTANA=NUEVA','Proveedor',100,80,0,-20);">
						<xsl:value-of select="/Incidencia/INCIDENCIA/PROVEEDOR"/>
                                            </a>:&nbsp;
                                            <xsl:value-of select="/Incidencia/INCIDENCIA/USUARIODIAGNOSTICO"/>
					</xsl:when>
					<xsl:otherwise>
						[<xsl:value-of select="document($doc)/translation/texts/item[@name='pendiente']/node()"/>]
					</xsl:otherwise>
					</xsl:choose>
                                        </td>
				</tr>
			<xsl:choose>
			<xsl:when test="/Incidencia/INCIDENCIA/PROD_INC_IDESTADO = 'INC' and (/Incidencia/INCIDENCIA/IDUSUARIO = /Incidencia/INCIDENCIA/PROD_INC_IDUSUARIODIAGNOSTICO or $usuario = 'CDC')">
				<tr>
					<td class="labelRight grisMed"><xsl:value-of select="document($doc)/translation/texts/item[@name='diagnostico']/node()"/>:</td>
					<td class="datosLeft" colspan="2">
                                                <textarea name="DIAGNOSTICO_OLD" id="DIAGNOSTICO_OLD" style="display:none;">
                                                    <xsl:copy-of select="/Incidencia/INCIDENCIA/PROD_INC_DIAGNOSTICO/node()" disable-output-escaping="yes"/>
                                                </textarea> 
						<textarea name="DIAGNOSTICO" id="DIAGNOSTICO" rows="4" cols="60">
							<xsl:copy-of select="/Incidencia/INCIDENCIA/PROD_INC_DIAGNOSTICO/node()" disable-output-escaping="yes"/>
						</textarea>
					</td>
				</tr>
				<tr>
					<td class="labelRight grisMed"><xsl:value-of select="document($doc)/translation/texts/item[@name='documento_diagnostico']/node()"/>:</td>
					<td class="datosLeft" colspan="2">
					<xsl:choose>
					<xsl:when test="/Incidencia/INCIDENCIA/DOCUMENTO_DIAGNOSTICO/ID">
						<span id="newDocDIAG" align="center" style="display:none;">
							<a href="javascript:verCargaDoc('DIAG');" title="Subir documento" style="text-decoration:none;">
								<img src="http://www.newco.dev.br/images/subirDocumento.gif" alt="Subir Documento" title="Subir Documento"/>
							</a>
						</span>&nbsp;
						<span id="docBoxDIAG" align="center">
							<a href="http://www.newco.dev.br/Documentos/{/Incidencia/INCIDENCIA/DOCUMENTO_DIAGNOSTICO/URL}" target="_blank">
								<xsl:value-of select="/Incidencia/INCIDENCIA/DOCUMENTO_DIAGNOSTICO/NOMBRE"/>
							</a>
						</span>&nbsp;
						<span id="borraDocDIAG" align="center">
							<a href="javascript:borrarDoc({/Incidencia/INCIDENCIA/DOCUMENTO_DIAGNOSTICO/ID},'DIAG')">
								<img src="http://www.newco.dev.br/images/2017/trash.png"/>
                                                        </a>
						</span>
					</xsl:when>
					<xsl:otherwise>
						<span id="newDocDIAG" align="center">
							<a href="javascript:verCargaDoc('DIAG');" title="Subir documento" style="text-decoration:none;">
								<img src="http://www.newco.dev.br/images/subirDocumento.gif" alt="Subir Documento" title="Subir Documento"/>
							</a>
						</span>&nbsp;
						<span id="docBoxDIAG" style="display:none;" align="center"></span>&nbsp;
						<span id="borraDocDIAG" style="display:none;" align="center"></span>
					</xsl:otherwise>
					</xsl:choose>
					</td>
				</tr>
				<tr id="cargaDIAG" class="cargas" style="display:none;">
					<td colspan="2"><xsl:call-template name="CargaDocumentos"><xsl:with-param name="tipo">DIAG</xsl:with-param></xsl:call-template></td>
				</tr>
			</xsl:when>
			<xsl:otherwise>
				<tr>
					<td class="labelRight grisMed"><xsl:value-of select="document($doc)/translation/texts/item[@name='diagnostico']/node()"/>:</td>
					<td class="datosLeft">
                                            <textarea name="DIAGNOSTICO" id="DIAGNOSTICO" style="display:none;">
                                                <xsl:copy-of select="/Incidencia/INCIDENCIA/PROD_INC_DIAGNOSTICO/node()" disable-output-escaping="yes"/>
                                            </textarea> 
                                            <xsl:copy-of select="/Incidencia/INCIDENCIA/PROD_INC_DIAGNOSTICO" disable-output-escaping="yes"/>
                                           
					</td>
					<td>&nbsp;</td>
				</tr>
			<xsl:if test="/Incidencia/INCIDENCIA/DOCUMENTO_DIAGNOSTICO/ID">
				<tr>
					<td class="labelRight grisMed"><xsl:value-of select="document($doc)/translation/texts/item[@name='documento_diagnostico']/node()"/>:</td>
					<td class="datosLeft">
						<a href="http://www.newco.dev.br/Documentos/{/Incidencia/INCIDENCIA/DOCUMENTO_DIAGNOSTICO/URL}" target="_blank">
							<xsl:value-of select="/Incidencia/INCIDENCIA/DOCUMENTO_DIAGNOSTICO/NOMBRE"/>
						</a>
					</td>
				</tr>
			</xsl:if>
			</xsl:otherwise>
			</xsl:choose>
                                <tr class="line">
					<td colspan="2">&nbsp;</td>
				</tr>
                                
                                <xsl:if test="/Incidencia/INCIDENCIA/ROL != 'VENDEDOR' and (/Incidencia/INCIDENCIA/PROD_INC_IDESTADO = 'DIAG' or /Incidencia/INCIDENCIA/PROD_INC_IDESTADO = 'P' or /Incidencia/INCIDENCIA/PROD_INC_IDESTADO = 'RHOSP' or /Incidencia/INCIDENCIA/PROD_INC_IDESTADO = 'SOL' or /Incidencia/INCIDENCIA/PROD_INC_IDESTADO = 'RES')">
                                <!- - Propuesta solucion cdc - ->
                                <tr>
					<td>&nbsp;</td>
					<td class="title">
						<strong>
							<xsl:value-of select="document($doc)/translation/texts/item[@name='propuesta']/node()"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='solucion']/node()"/>
							<xsl:if test="/Incidencia/INCIDENCIA/PROD_INC_FECHAPROPSOLUCION != ''">
                                                            <span style="float:right;padding-right:30px;">
								<xsl:value-of select="document($doc)/translation/texts/item[@name='fecha']/node()"/>:&nbsp;<xsl:value-of select="/Incidencia/INCIDENCIA/PROD_INC_FECHAPROPSOLUCION"/>
                                                            </span>
                                                        </xsl:if>
						</strong>
					</td>
				</tr>
				<tr>
					<td class="labelRight grisMed"><xsl:value-of select="document($doc)/translation/texts/item[@name='responsable_propuesta']/node()"/>:</td>
					<td class="datosLeft">
					<xsl:choose>
					<xsl:when test="/Incidencia/INCIDENCIA/USUARIOPROPSOLUCION != ''">
                                            <xsl:value-of select="/Incidencia/INCIDENCIA/CENTROPROPSOLUCION" />:&nbsp;
                                            <xsl:value-of select="/Incidencia/INCIDENCIA/USUARIOPROPSOLUCION"/>
					</xsl:when>
					<xsl:otherwise>
						[<xsl:value-of select="document($doc)/translation/texts/item[@name='pendiente']/node()"/>]
					</xsl:otherwise>
					</xsl:choose>
                                        </td>
				</tr>
				<tr>
					<td class="labelRight grisMed"><xsl:value-of select="document($doc)/translation/texts/item[@name='propuesta']/node()"/>:</td>
					<td class="datosLeft">
					<xsl:choose>
					<xsl:when test="$usuario = 'CDC' and /Incidencia/INCIDENCIA/PROD_INC_IDESTADO = 'DIAG'">
                                                <textarea name="PROPUESTA_SOLUCION_OLD" id="PROPUESTA_SOLUCION_OLD" style="display:none;">
                                                    <xsl:copy-of select="/Incidencia/INCIDENCIA/PROD_INC_PROPSOLUCION/node()" disable-output-escaping="yes"/>
                                                </textarea> 
						<textarea name="PROPUESTA_SOLUCION" id="PROPUESTA_SOLUCION" rows="4" cols="60">
                                                    <xsl:copy-of select="/Incidencia/INCIDENCIA/PROD_INC_PROPSOLUCION/node()" disable-output-escaping="yes"/>
						</textarea>
					</xsl:when>
					<xsl:otherwise>
						<xsl:copy-of select="/Incidencia/INCIDENCIA/PROD_INC_PROPSOLUCION" disable-output-escaping="yes"/>
                                                <textarea name="PROPUESTA_SOLUCION" id="PROPUESTA_SOLUCION" rows="4" cols="60" style="display:none;">
                                                    <xsl:copy-of select="/Incidencia/INCIDENCIA/PROD_INC_PROPSOLUCION/node()" disable-output-escaping="yes"/>
						</textarea>
					</xsl:otherwise>
					</xsl:choose>
					</td>
				</tr>
                                <!- -documento propuesta solucion- ->
                                 <xsl:choose>
                                    <xsl:when test="/Incidencia/INCIDENCIA/PROD_INC_IDESTADO = 'DIAG' and $usuario = 'CDC'">
                                        <tr>
					<td class="labelRight grisMed"><xsl:value-of select="document($doc)/translation/texts/item[@name='documento_propuesta']/node()"/>:</td>
					<td class="datosLeft">
					<xsl:choose>
					<xsl:when test="/Incidencia/INCIDENCIA/DOCUMENTO_PROPSOLUCION/ID">
						<span id="newDocP" align="center" style="display:none;">
							<a href="javascript:verCargaDoc('P');" title="Subir documento" style="text-decoration:none;">
								<img src="http://www.newco.dev.br/images/subirDocumento.gif" alt="Subir Documento" title="Subir Documento"/>
							</a>
						</span>&nbsp;
						<span id="docBoxP" align="center">
							<a href="http://www.newco.dev.br/Documentos/{/Incidencia/INCIDENCIA/DOCUMENTO_PROPSOLUCION/URL}" target="_blank">
								<xsl:value-of select="/Incidencia/INCIDENCIA/DOCUMENTO_PROPSOLUCION/NOMBRE"/>
							</a>
						</span>&nbsp;
						<span id="borraDocP" align="center">
							<a href="javascript:borrarDoc({/Incidencia/INCIDENCIA/DOCUMENTO_PROPSOLUCION/ID},'P')">
								<img src="http://www.newco.dev.br/images/2017/trash.png"/>
                                                        </a>
						</span>
					</xsl:when>
					<xsl:otherwise>
						<span id="newDocP" align="center">
							<a href="javascript:verCargaDoc('P');" title="Subir documento" style="text-decoration:none;">
								<img src="http://www.newco.dev.br/images/subirDocumento.gif" alt="Subir Documento" title="Subir Documento"/>
							</a>
						</span>&nbsp;
						<span id="docBoxP" style="display:none;" align="center"></span>&nbsp;
						<span id="borraDocP" style="display:none;" align="center"></span>
					</xsl:otherwise>
					</xsl:choose>
					</td>
                                        </tr>
                                        <tr id="cargaP" class="cargas" style="display:none;">
                                                <td colspan="2"><xsl:call-template name="CargaDocumentos"><xsl:with-param name="tipo">P</xsl:with-param></xsl:call-template></td>
                                        </tr>
                                        <tr>
                                                <td class="veinte labelRight grisMed">
                                                        <xsl:value-of select="document($doc)/translation/texts/item[@name='seguir_utilizando']/node()"/>:&nbsp;
                                                </td>
                                                <td class="datosLeft">
                                                    <input type="hidden" name="SEGUIR_UTILIZANDO_CDC" id="SEGUIR_UTILIZANDO_CDC" />
                                                    <input type="radio" name="SEGUIR_UTILIZANDO_CDC_VALUES" id="SEGUIR_UTILIZANDO_CDC_S" value="S">
                                                        <!- -<xsl:if test="/Incidencia/INCIDENCIA/PROD_INC_SEGUIRUTILIZANDO_CDC = 'S'">
                                                            <xsl:attribute name="checked">checked</xsl:attribute>
                                                        </xsl:if>- ->
                                                        &nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='si']/node()"/>
                                                    </input>&nbsp;&nbsp;
                                                    <input type="radio" name="SEGUIR_UTILIZANDO_CDC_VALUES" id="SEGUIR_UTILIZANDO_CDC_N" value="N">
                                                        <!- -<xsl:if test="/Incidencia/INCIDENCIA/PROD_INC_SEGUIRUTILIZANDO_CDC != 'S'">
                                                            <xsl:attribute name="checked">checked</xsl:attribute>
                                                        </xsl:if>- ->
                                                        &nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='no']/node()"/>
                                                    </input>

                                                </td>
                                        </tr>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:if test="/Incidencia/INCIDENCIA/DOCUMENTO_PROPSOLUCION/ID">
                                                <tr>
                                                        <td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='documento_propuesta']/node()"/>:</td>
                                                        <td class="datosLeft" colspan="2">
                                                                <a href="http://www.newco.dev.br/Documentos/{/Incidencia/INCIDENCIA/DOCUMENTO_PROPSOLUCION/URL}" target="_blank">
                                                                        <xsl:value-of select="/Incidencia/INCIDENCIA/DOCUMENTO_PROPSOLUCION/NOMBRE"/>
                                                                </a>
                                                        </td>
                                                </tr>
                                        </xsl:if>
                                        <tr>
                                            <td class="veinte labelRight grisMed">
                                                    <xsl:value-of select="document($doc)/translation/texts/item[@name='seguir_utilizando']/node()"/>:&nbsp;
                                            </td>
                                            <td class="datosLeft">
                                            <xsl:choose>
                                                <xsl:when test="/Incidencia/INCIDENCIA/PROD_INC_SEGUIRUTILIZANDO_CDC = 'S'">
                                                    <xsl:value-of select="document($doc)/translation/texts/item[@name='si']/node()"/>
                                                    <input type="hidden" name="SEGUIR_UTILIZANDO_CDC" id="SEGUIR_UTILIZANDO_CDC" value="S"/>
                                                </xsl:when>
                                                <xsl:otherwise>
                                                    <xsl:value-of select="document($doc)/translation/texts/item[@name='no']/node()"/>
                                                    <input type="hidden" name="SEGUIR_UTILIZANDO_CDC" id="SEGUIR_UTILIZANDO_CDC" value=""/>
                                                </xsl:otherwise>
                                            </xsl:choose>
                                            </td>
                                        </tr>
                                    </xsl:otherwise>
                                 </xsl:choose>
                                 <!- -fin de documento prop solucion- ->
                                 
				<tr class="line">
					<td colspan="2">&nbsp;</td>
				</tr>
                                </xsl:if>
                                
                                
                                <!- - Respuesta a la propuesta de solucion de parte del centro - ->
                                <xsl:if test="/Incidencia/INCIDENCIA/PROD_INC_IDESTADO = 'P' or /Incidencia/INCIDENCIA/PROD_INC_IDESTADO = 'RHOSP' or /Incidencia/INCIDENCIA/PROD_INC_IDESTADO = 'SOL' or /Incidencia/INCIDENCIA/PROD_INC_IDESTADO = 'RES'">
				<tr>
					<td>&nbsp;</td>
					<td class="title">
						<strong>
							<xsl:value-of select="document($doc)/translation/texts/item[@name='respuesta']/node()"/>
							<xsl:if test="/Incidencia/INCIDENCIA/PROD_INC_FECHARESPHOSPITAL != ''">
                                                            <span style="float:right;padding-right:30px;">
								<xsl:value-of select="document($doc)/translation/texts/item[@name='fecha']/node()"/>:&nbsp;<xsl:value-of select="/Incidencia/INCIDENCIA/PROD_INC_FECHARESPHOSPITAL"/>
                                                            </span>
                                                        </xsl:if>
						</strong>
					</td>
				</tr>
				<tr>
					<td class="labelRight grisMed"><xsl:value-of select="document($doc)/translation/texts/item[@name='responsable_respuesta']/node()"/>:</td>
					<td class="datosLeft">
					<xsl:choose>
					<xsl:when test="/Incidencia/INCIDENCIA/USUARIORESPHOSPITAL">
                                                <xsl:value-of select="/Incidencia/INCIDENCIA/CENTRORESPHOSPITAL"/>:&nbsp;
						<xsl:value-of select="/Incidencia/INCIDENCIA/USUARIORESPHOSPITAL"/>
					</xsl:when>
					<xsl:otherwise>
						[<xsl:value-of select="document($doc)/translation/texts/item[@name='pendiente']/node()"/>]
					</xsl:otherwise>
					</xsl:choose>
                                        </td>
				</tr>
				<tr>
					<td class="labelRight grisMed"><xsl:value-of select="document($doc)/translation/texts/item[@name='respuesta']/node()"/>:</td>
					<td class="datosLeft">
					<xsl:choose>
                                        <!- -cliente o cdc cliente puede poner respuesta- ->
					<xsl:when test="($usuarioAutor = 'AUTOR' or $usuario = 'CDC') and /Incidencia/INCIDENCIA/PROD_INC_IDESTADO = 'P'">
                                                <textarea name="TEXTO_RESP_HOSPITAL_OLD" id="TEXTO_RESP_HOSPITAL_OLD" style="display:none;">
                                                    <xsl:copy-of select="/Incidencia/INCIDENCIA/PROD_INC_RESPHOSPITAL/node()" disable-output-escaping="yes"/>
                                                </textarea> 
						<textarea name="TEXTO_RESP_HOSPITAL" id="TEXTO_RESP_HOSPITAL" rows="4" cols="60">
                                                    <xsl:copy-of select="/Incidencia/INCIDENCIA/PROD_INC_RESPHOSPITAL/node()" disable-output-escaping="yes"/>
						</textarea>
					</xsl:when>
					<xsl:otherwise>
						<xsl:copy-of select="/Incidencia/INCIDENCIA/PROD_INC_RESPHOSPITAL" disable-output-escaping="yes"/>
                                                <textarea name="TEXTO_RESP_HOSPITAL" id="TEXTO_RESP_HOSPITAL" rows="4" cols="60" style="display:none;">
                                                    <xsl:copy-of select="/Incidencia/INCIDENCIA/PROD_INC_RESPHOSPITAL/node()" disable-output-escaping="yes"/>
						</textarea>
					</xsl:otherwise>
					</xsl:choose>
					</td>
				</tr>
                                <tr class="line">
					<td colspan="2">&nbsp;</td>
				</tr>
                                </xsl:if>
                                
                                <!- -solucion definitiva cdc- ->
                               <xsl:if test="/Incidencia/INCIDENCIA/PROD_INC_IDESTADO = 'RHOSP' or /Incidencia/INCIDENCIA/PROD_INC_IDESTADO = 'SOL' or /Incidencia/INCIDENCIA/PROD_INC_IDESTADO = 'RES'">

                                <tr>
					<td>&nbsp;</td>
					<td class="title">
						<strong>
							<xsl:value-of select="document($doc)/translation/texts/item[@name='solucion']/node()"/>
							<xsl:if test="/Incidencia/INCIDENCIA/PROD_INC_FECHASOLUCION != ''">
                                                            <span style="float:right;padding-right:30px;">
								<xsl:value-of select="document($doc)/translation/texts/item[@name='fecha']/node()"/>:&nbsp;<xsl:value-of select="/Incidencia/INCIDENCIA/PROD_INC_FECHASOLUCION"/>
                                                            </span>
                                                        </xsl:if>
						</strong>
					</td>
				</tr>
				<tr>
					<td class="labelRight grisMed"><xsl:value-of select="document($doc)/translation/texts/item[@name='responsable_solucion']/node()"/>:</td>
					<td class="datosLeft">
					<xsl:choose>
					<xsl:when test="/Incidencia/INCIDENCIA/USUARIOSOLUCION">
                                                <xsl:value-of select="/Incidencia/INCIDENCIA/CENTROSOLUCION"/>:&nbsp;
						<xsl:value-of select="/Incidencia/INCIDENCIA/USUARIOSOLUCION"/>
					</xsl:when>
					<xsl:otherwise>
						[<xsl:value-of select="document($doc)/translation/texts/item[@name='pendiente']/node()"/>]
					</xsl:otherwise>
					</xsl:choose>
                                        </td>
				</tr>
				<tr>
					<td class="labelRight grisMed"><xsl:value-of select="document($doc)/translation/texts/item[@name='solucion']/node()"/>:</td>
					<td class="datosLeft">
					<xsl:choose>
					<xsl:when test="$usuario = 'CDC' and /Incidencia/INCIDENCIA/PROD_INC_IDESTADO = 'RHOSP'">
                                                <textarea name="SOLUCION_OLD" id="SOLUCION_OLD" style="display:none;">
                                                    <xsl:copy-of select="/Incidencia/INCIDENCIA/PROD_INC_SOLUCION/node()" disable-output-escaping="yes"/>
                                                </textarea> 
						<textarea name="SOLUCION" id="SOLUCION" rows="4" cols="60">
                                                    <xsl:copy-of select="/Incidencia/INCIDENCIA/PROD_INC_SOLUCION/node()" disable-output-escaping="yes"/>
						</textarea>
					</xsl:when>
					<xsl:otherwise>
						<xsl:copy-of select="/Incidencia/INCIDENCIA/PROD_INC_SOLUCION" disable-output-escaping="yes"/>
                                                <textarea name="SOLUCION" id="SOLUCION" rows="4" cols="60" style="display:none;">
                                                    <xsl:copy-of select="/Incidencia/INCIDENCIA/PROD_INC_SOLUCION/node()" disable-output-escaping="yes"/>
						</textarea>
					</xsl:otherwise>
					</xsl:choose>
					</td>
                                </tr>
                                
                                <!- -doc solucion- ->
                                        <xsl:choose>
                                        <xsl:when test="$usuario = 'CDC'">
					<xsl:choose>
					<xsl:when test="/Incidencia/INCIDENCIA/DOCUMENTO_SOLUCION/ID">
                                            <tr>
                                            <td class="labelRight grisMed"><xsl:value-of select="document($doc)/translation/texts/item[@name='documento_solucion']/node()"/>:</td>
                                            <td class="datosLeft">
						<span id="newDocSOL" align="center" style="display:none;">
							<a href="javascript:verCargaDoc('SOL');" title="Subir documento" style="text-decoration:none;">
								<img src="http://www.newco.dev.br/images/subirDocumento.gif" alt="Subir Documento" title="Subir Documento"/>
							</a>
						</span>&nbsp;
						<span id="docBoxSOL" align="center">
							<a href="http://www.newco.dev.br/Documentos/{/Incidencia/INCIDENCIA/DOCUMENTO_SOLUCION/URL}" target="_blank">
								<xsl:value-of select="/Incidencia/INCIDENCIA/DOCUMENTO_SOLUCION/NOMBRE"/>
							</a>
						</span>&nbsp;
						<span id="borraDocSOL" align="center">
							<a href="javascript:borrarDoc({/Incidencia/INCIDENCIA/DOCUMENTO_SOLUCION/ID},'SOL')">
								<img src="http://www.newco.dev.br/images/2017/trash.png"/>
                                                        </a>
						</span>
                                            </td>
                                            </tr>
					</xsl:when>
                                        <xsl:when test="/Incidencia/INCIDENCIA/PROD_INC_IDESTADO = 'RHOSP'">
						<tr>
                                                <td class="labelRight grisMed">
                                                        <xsl:value-of select="document($doc)/translation/texts/item[@name='documento_solucion']/node()"/>:</td>
                                                <td class="datosLeft">
                                                <span id="newDocSOL" align="center">
							<a href="javascript:verCargaDoc('SOL');" title="Subir documento" style="text-decoration:none;">
								<img src="http://www.newco.dev.br/images/subirDocumento.gif" alt="Subir Documento" title="Subir Documento"/>
							</a>
						</span>&nbsp;
						<span id="docBoxSOL" style="display:none;" align="center"></span>&nbsp;
						<span id="borraDocSOL" style="display:none;" align="center"></span>
                                                </td>
                                                </tr>
					</xsl:when>
					</xsl:choose>
                                        </xsl:when>
                                        </xsl:choose>
                                <tr id="cargaSOL" class="cargas" style="display:none;">
					<td colspan="2"><xsl:call-template name="CargaDocumentos"><xsl:with-param name="tipo">SOL</xsl:with-param></xsl:call-template></td>
				</tr>

                               </xsl:if>
                        </table>
                        <table class="infoTable incidencias" border="0" style="border-bottom:2px solid #D7D8D7;">
				<!- - BOTONES - ->
				<tr>
					<td class="labelRight trenta"></td>
                                        <!- -proveedor diagnostico- ->
					<xsl:if test="/Incidencia/INCIDENCIA/PROD_INC_IDESTADO = 'INC' and (/Incidencia/INCIDENCIA/IDUSUARIO = /Incidencia/INCIDENCIA/PROD_INC_IDUSUARIODIAGNOSTICO or $usuario = 'CDC')">
						<td class="datosLeft quince">
                                                    <div class="botonLargo">
							<a href="javascript:GuardarIncidencia(document.forms['Incidencia'],'INC');">
								<xsl:value-of select="document($doc)/translation/texts/item[@name='informar_pero_pendiente']/node()"/>
							</a>
                                                    </div>
                                                </td>
                                                <td class="cinco">&nbsp;</td>
                                                <td class="datosLeft">
                                                    <div class="boton">
							<a href="javascript:GuardarIncidencia(document.forms['Incidencia'],'DIAG');">
								<xsl:value-of select="document($doc)/translation/texts/item[@name='diagnostico']/node()"/>
							</a>
                                                    </div>
                                                </td>
					</xsl:if>
                                        <!- -cdc hace una propuesta de solucion- ->
                                        <xsl:if test="$usuario = 'CDC' and /Incidencia/INCIDENCIA/PROD_INC_IDESTADO = 'DIAG'">
                                            <td class="datosLeft quince">
                                                    <div class="boton">
							<a href="javascript:GuardarIncidencia(document.forms['Incidencia'],'P');">
								<xsl:value-of select="document($doc)/translation/texts/item[@name='propuesta']/node()"/>
							</a>
						</div>
                                            </td>
                                            <td class="datosLeft quince">
                                                    <div class="boton">
							<a href="javascript:GuardarIncidencia(document.forms['Incidencia'],'INC');">
								<xsl:value-of select="document($doc)/translation/texts/item[@name='rechazar']/node()"/>
							</a>
                                                    </div>
                                                </td>
                                        </xsl:if>
                                        <!- -clinica responde, si ok incidencia cerrada, si no vuelve a cdc- ->
					<xsl:if test="$usuarioAutor = 'AUTOR' and /Incidencia/INCIDENCIA/PROD_INC_IDESTADO = 'P'">
                                                <td class="datosLeft quince">
                                                    <div class="boton">
							<a href="javascript:GuardarIncidencia(document.forms['Incidencia'],'RHOSP');">
								<xsl:value-of select="document($doc)/translation/texts/item[@name='rechazar']/node()"/>
							</a>
                                                    </div>
                                                </td>
					</xsl:if>
                                        <!- -cdc pone la soluci�n- ->
                                        <xsl:if test="/Incidencia/INCIDENCIA/PROD_INC_IDESTADO = 'RHOSP' and $usuario = 'CDC'">
						<td class="datosLeft quince">
						<div class="boton">
							<a href="javascript:GuardarIncidencia(document.forms['Incidencia'],'SOL');">
								<xsl:value-of select="document($doc)/translation/texts/item[@name='enviar']/node()"/>
							</a>
						</div>
                                                </td>
					</xsl:if>

                                        <!- -usuario autor elige si solucion de cdc ok o no- ->
                                        <!- -cdc puede cerrar la incidencia si esta en propuesta de soluci�n pedido de alf 5-6-15- ->
                                        <xsl:if test="($usuarioAutor = 'AUTOR' and /Incidencia/INCIDENCIA/PROD_INC_IDESTADO = 'P') or (/Incidencia/INCIDENCIA/PROD_INC_IDESTADO = 'P' and $usuario = 'CDC') or (/Incidencia/INCIDENCIA/PROD_INC_IDESTADO = 'SOL' and $usuarioAutor = 'AUTOR')">
						<td class="datosLeft quince">
						<div class="boton">
							<a href="javascript:GuardarIncidencia(document.forms['Incidencia'],'RES');">
								<xsl:value-of select="document($doc)/translation/texts/item[@name='resuelta']/node()"/>
							</a>
						</div>
                                                </td>
					</xsl:if>

					<xsl:if test="/Incidencia/INCIDENCIA/MVM and /Incidencia/INCIDENCIA/PROD_INC_IDESTADO = 'RES'">
						<td class="datosLeft quince">
                                                <div class="boton">
							<a href="javascript:GuardarIncidencia(document.forms['Incidencia'],'SOL');">
								<xsl:value-of select="document($doc)/translation/texts/item[@name='retroceder']/node()"/>
							</a>
						</div>
                                                </td>
                                                
					</xsl:if>
                                        <td>&nbsp;</td>
				</tr>
			<!- - FIN BOTONES - ->

			</table>
                    </div><!- -fin de divLeft60nopa- ->
		</form>
		-->

		<!--frame para las imagenes-->
		<!--<div id="uploadFrameBox" style="display:none;"><iframe src="" id="uploadFrame" name="uploadFrame" style="width: 100%;"></iframe></div>-->
		<div id="uploadFrameBoxDoc" style="display:none;"><iframe src="" id="uploadFrameDoc" name="uploadFrameDoc" style="width: 100%;"></iframe></div>

		<!--form de mensaje de error de js-->
		<form name="mensajeJS">
			<!--carga documentos-->
			<input type="hidden" name="ERROR_SIN_DEFINIR" value="{document($doc)/translation/texts/item[@name='error_sin_definir']/node()}"/>
			<input type="hidden" name="HEMOS_ESPERADO" value="{document($doc)/translation/texts/item[@name='hemos_esperado']/node()}"/>
			<input type="hidden" name="LA_CARGA_NO_TERMINO" value="{document($doc)/translation/texts/item[@name='la_carga_no_termino']/node()}"/>
                        <input type="hidden" name="TEXTO_DIAG_OBLI" value="{document($doc)/translation/texts/item[@name='texto_diag_obli']/node()}"/>
                        <input type="hidden" name="TEXTO_RESP_HOSPITAL_OBLI" value="{document($doc)/translation/texts/item[@name='texto_diag_hospital_obli']/node()}"/>
                        <input type="hidden" name="TEXTO_PROP_SOLUCION_OBLI" value="{document($doc)/translation/texts/item[@name='texto_prop_solucion_obli']/node()}"/>
                        <input type="hidden" name="SEGUIR_UTILIZANDO_CDC_OBLI" value="{document($doc)/translation/texts/item[@name='seguir_utilizando_cdc_obli']/node()}"/>
		</form>
	</xsl:otherwise>
	</xsl:choose><!--fin choose si incidencia guardada con exito-->
	</div><!--fin de divLeft-->
        
        <!-- DIV Nueva etiqueta -->
<div class="overlay-container" id="verEtiquetas">
	<div class="window-container zoomout">
		<p style="text-align:right;">
                    <a href="javascript:showTabla(false);" style="text-decoration:none;">
                        <xsl:value-of select="document($doc)/translation/texts/item[@name='cerrar']/node()"/>
                    </a>&nbsp;
                    <a href="javascript:showTabla(false);" style="text-decoration:none;">
                        <img src="http://www.newco.dev.br/images/cerrar.gif" alt="Cerrar" />
                    </a>
                </p>

		<p id="tableTitle">
			<xsl:value-of select="document($doc)/translation/texts/item[@name='nueva_etiqueta']/node()"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='para']/node()"/>&nbsp;
			<xsl:value-of select="/Incidencia/INCIDENCIA/PROD_INC_CODIGO"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='incidencia']/node()"/>:&nbsp;
                    
                        <xsl:choose>
                        <xsl:when test="string-length(/Incidencia/INCIDENCIA/PROD_INC_NOMBRE) > 75">
                                <xsl:value-of select="substring(/Incidencia/INCIDENCIA/PROD_INC_DESCESTANDAR, 1, 75)"/>...
                        </xsl:when>
                        <xsl:otherwise>
                                <xsl:value-of select="/Incidencia/INCIDENCIA/PROD_INC_DESCESTANDAR"/>
                        </xsl:otherwise>
                        </xsl:choose>
			&nbsp;-&nbsp;
			<xsl:value-of select="document($doc)/translation/texts/item[@name='ref_cliente']/node()"/>:&nbsp;
			<xsl:choose>
			<xsl:when test="/Incidencia/INCIDENCIA/PROD_INC_REFCLIENTE != ''">
				<xsl:value-of select="/Incidencia/INCIDENCIA/PROD_INC_REFCLIENTE"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="/Incidencia/INCIDENCIA/PROD_INC_REFERENCIA"/>
			</xsl:otherwise>
			</xsl:choose>
<!--
			&nbsp;<a href="javascript:window.print();" style="text-decoration:none;">
				<img src="http://www.newco.dev.br/images/imprimir.gif">
					<xsl:attribute name="alt"><xsl:value-of select="document($doc)/translation/texts/item[@name='imprimir']/node()"/></xsl:attribute>
					<xsl:attribute name="title"><xsl:value-of select="document($doc)/translation/texts/item[@name='imprimir']/node()"/></xsl:attribute>
				</img>
			</a>
-->
		</p>

		<div id="mensError" class="divLeft" style="display:none;">
			<p><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='no_tiene_derechos']/node()"/></strong></p>
		</div>

		<table id="viejasEtiquetas" border="0" style="width:100%;display:none;">
		<thead>
			<th colspan="5">&nbsp;</th>
		</thead>

		<tbody></tbody>

		</table>

		<form name="nuevaEtiquetaForm" method="post" id="nuevaEtiquetaForm">

		<table id="nuevaEtiqueta" style="width:100%;">
		<thead>
			<th colspan="3">&nbsp;</th>
		</thead>

		<tbody>
			<tr>
				<td class="quince"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='etiqueta']/node()"/>:</strong></td>
				<td colspan="2" style="text-align:left;"><textarea name="TEXTO" id="TEXTO" rows="4" cols="70" /></td>
			</tr>
		</tbody>

		<tfoot>
			<tr>
				<td>&nbsp;</td>
				<td>
					<div class="boton" id="botonGuardar">
						<a href="javascript:guardarEtiqueta();">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='guardar']/node()"/>
						</a>
					</div>
				</td>
				<td id="Respuesta" style="text-align:left;"></td>
			</tr>
		</tfoot>
		</table>
		</form>
	</div>
</div>
<!-- FIN DIV Nueva etiqueta -->
</xsl:otherwise>
</xsl:choose>
</body>
</html>
</xsl:template>

<!--template carga documentos-->
<xsl:template name="CargaDocumentos">
	<xsl:param name="tipo" />

	<!--idioma-->
	<xsl:variable name="lang"><xsl:value-of select="/Incidencia/LANG"/></xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<div class="divLeft" id="cargaDoc{$tipo}">
		<!--tabla imagenes y documentos-->
		<table class="infoTable" border="0">
			<tr>
				<!--documentos-->
				<td class="labelRight trenta grisMed">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='elige_documento']/node()"/>
				</td>
				<td class="datosLeft">
					<div class="altaDocumento">
						<span class="anadirDoc">
							<xsl:call-template name="documentos">
								<xsl:with-param name="num" select="number(1)"/>
								<xsl:with-param name="type" select="$tipo"/>
							</xsl:call-template>
						</span>
					</div>
				</td>
			</tr>
		</table><!--fin de tabla imagenes doc-->

		<div id="waitBoxDoc{$tipo}" align="center">&nbsp;</div>
	</div><!--fin de divleft-->
</xsl:template><!--fin de template carga documentos-->

<!--documentos-->
<xsl:template name="documentos">
	<xsl:param name="num"/>
	<xsl:param name="type"/>

	<xsl:choose>
	<xsl:when test="$num &lt; number(5)">
		<div class="docLine" id="docLine_{$type}">
			<div class="docLongEspec" id="docLongEspec_{$type}">
				<input id="inputFileDoc_{$type}" name="inputFileDoc" type="file" onChange="cargaDoc(document.forms['Incidencia'],'{$type}');"/>
			</div>
		</div>
	</xsl:when>
	</xsl:choose>
</xsl:template><!--fin de documentos-->
</xsl:stylesheet>
