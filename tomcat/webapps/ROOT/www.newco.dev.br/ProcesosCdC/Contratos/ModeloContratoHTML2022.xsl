<?xml version="1.0" encoding="iso-8859-1"?>
<!--
	Mantenimiento de Modelo de Contrato. Nuevo disenno 2022.
	Ultima revision: ET 12may22 15:00 ModeloContrato2022_120522.js
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:import href = "http://www.newco.dev.br/General/General.xsl"/>
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="lang" select="@lang"/>

<xsl:template match="/ModeloContrato">

<!--	Todos los documentos HTML deben empezar con esto	-->
<xsl:text disable-output-escaping='yes'>&lt;!doctype html></xsl:text>

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

	<title><xsl:value-of select="document($doc)/translation/texts/item[@name='Modelo_contrato']/node()"/></title>

	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->

	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery-3.6.0.js"></script>	
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic2022_010822.js"></script>
	<!--<script type="text/javascript" src="http://www.newco.dev.br/General/jquery-1.8.3.min.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>-->
	<script type="text/javascript" src="http://www.newco.dev.br/General/parsley_2.8.1.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/parsley.es.js"></script>

	<script type="text/javascript" src="http://www.newco.dev.br/ProcesosCdC/Contratos/ModeloContrato2022_120522.js"></script>
</head>
<body>
<xsl:choose>
<xsl:when test="SESION_CADUCADA">
	<xsl:for-each select="SESION_CADUCADA">
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
		<xsl:when test="LANG"><xsl:value-of select="LANG"/></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<div class="divLeft">
	<xsl:choose>
	<xsl:when test="ERROR">
		<h1 class="titlePage"><xsl:value-of select="document($doc)/translation/texts/item[@name='error_Contrato']/node()"/></h1>
	</xsl:when>
	<xsl:otherwise>

		<xsl:variable name="usuario">
		<xsl:choose>
			<xsl:when test="not(MODELO/OBSERVADOR) and MODELO/CDC and MODELO/IDEMPRESAUSUARIO = MODELO/CON_MOD_IDCLIENTE">CDC</xsl:when>
			<xsl:otherwise>NORMAL</xsl:otherwise>
		</xsl:choose>
		</xsl:variable>
                <xsl:variable name="adminCliente">
		<xsl:choose>
			<xsl:when test="MODELO/ADMIN">ADMIN</xsl:when>
			<xsl:otherwise>NOADMIN</xsl:otherwise>
		</xsl:choose>
		</xsl:variable>
                <xsl:variable name="usuarioMVM">
		<xsl:choose>
			<xsl:when test="MODELO/MVM">MVM</xsl:when>
			<xsl:otherwise>NOMVM</xsl:otherwise>
		</xsl:choose>
		</xsl:variable>

		<!--	Titulo de la página		-->
		<div class="ZonaTituloPagina">
			<p class="TituloPagina">
				<xsl:choose>
					<xsl:when test="MODELO/NUEVO">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='Nuevo_modelo_contrato']/node()"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="MODELO/CON_MOD_CODIGO"/>&nbsp;
						<xsl:value-of select="MODELO/CON_MOD_NOMBRE"/>
					</xsl:otherwise>
					</xsl:choose>
				<span class="CompletarTitulo400">
					<a class="btnNormal" href="javascript:ModelosContrato();">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='volver']/node()"/>
					</a>
					&nbsp;
					<xsl:if test="MODELO/CDC or MODELO/ADMIN">
						<a class="btnDestacado" href="javascript:ValidarYEnviar();">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='guardar']/node()"/>
						</a>
						&nbsp;
					</xsl:if> 
					<xsl:if test="MODELO/LINEAS/LINEA">
						<a class="btnNormal" href="javascript:VerModelo('{MODELO/CON_MOD_ID}');"> 
							<xsl:value-of select="document($doc)/translation/texts/item[@name='Ver_modelo']/node()"/>
						</a>
						&nbsp;
					</xsl:if> 
					
				</span>
			</p>
		</div>
		<br/>

		<form class="formEstandar" name="Modelo" id="Modelo" method="post"  action="ModeloContrato.xsql">
			<input type="hidden" name="ACCION" id="ACCION" value=""/>
			<input type="hidden" name="CON_MOD_ID" id="CON_MOD_ID" value="{MODELO/CON_MOD_ID}"/>
			<input type="hidden" name="CON_MOD_IDESTADO" id="CON_MOD_IDESTADO"/>
			<input type="hidden" name="ID_USUARIO" value="{MODELO/IDUSUARIO}"/>
			<input type="hidden" name="IDEMPRESA" id="IDEMPRESA" value="{MODELO/IDEMPRESAUSUARIO}"/>
		
		<!--	Nuevo formulario	-->
    	<div>
        	<ul style="width:1000px;">
				<li>
					<strong><xsl:value-of select="document($doc)/translation/texts/item[@name='datos_generales']/node()"/></strong>
				</li>
				<li>
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='codigo']/node()"/>(<span class="camposObligatorios">*</span>):</label>
        			<xsl:choose>
        			  <xsl:when test="NOEDICION">
            			&nbsp;<xsl:value-of select="MODELO/CON_MOD_CODIGO"/>
        			  </xsl:when>
        			  <xsl:otherwise>
        				<input type="text" name="CON_MOD_CODIGO" class="campopesquisa w100px form-control" data-parsley-trigger="change" required="" maxlength="50" value="{MODELO/CON_MOD_CODIGO}"/>
        			  </xsl:otherwise>
        			</xsl:choose>
				</li>
				<li>
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='nombre']/node()"/>(<span class="camposObligatorios">*</span>):</label>
        			<xsl:choose>
        			  <xsl:when test="NOEDICION">
            			&nbsp;<xsl:value-of select="MODELO/CON_MOD_NOMBRE"/>
        			  </xsl:when>
        			  <xsl:otherwise>
        				<input type="text" name="CON_MOD_NOMBRE" class="campopesquisa w300px form-control" data-parsley-trigger="change" required="" maxlength="50" value="{MODELO/CON_MOD_NOMBRE}"/>
        			  </xsl:otherwise>
        			</xsl:choose>
				</li>
				<li>
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='descripcion']/node()"/>:</label>
        			<xsl:choose>
        			  <xsl:when test="NOEDICION">
            			&nbsp;<xsl:value-of select="MODELO/CON_MOD_DESCRIPCION"/>
        			  </xsl:when>
        			  <xsl:otherwise>
        				<input type="text" name="CON_MOD_DESCRIPCION" class="campopesquisa w600px form-control" data-parsley-trigger="change" maxlength="1000" value="{MODELO/CON_MOD_DESCRIPCION}"/>
        			  </xsl:otherwise>
        			</xsl:choose>
				</li>
				<xsl:if test="MODELO/CON_MOD_ID &gt;0">
				<li>
					<!--	Nuevo formulario	-->
    				<div>
						<xsl:for-each select="MODELO/LINEAS/LINEA">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='linea']/node()"/>(<xsl:value-of select="NUMERO"/>)
							<xsl:value-of select="TEXTO"/><BR/>
						</xsl:for-each>
						<xsl:value-of select="document($doc)/translation/texts/item[@name='total']/node()"/>:&nbsp;<xsl:copy-of select="MODELO/CON_MOD_LINEASMODELO"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='lineas']/node()"/>
    				</div>
				</li>
				<li>
        			<xsl:choose>
        				<xsl:when test="NOEDICION">
        			 	</xsl:when>
        				<xsl:otherwise>
							<label><xsl:value-of select="document($doc)/translation/texts/item[@name='fichero']/node()"/>&nbsp;(<xsl:value-of select="document($doc)/translation/texts/item[@name='XHTML']/node()"/>):</label>
							<input type="hidden" name="IDPROVEEDOR" id="IDPROVEEDOR" value="1"/>
							<input type="hidden" name="CADENA_DOCUMENTOS"/>
							<input type="hidden" name="DOCUMENTOS_BORRADOS"/>
							<input type="hidden" name="BORRAR_ANTERIORES"/>
							<input type="hidden" name="REMOVE" value="Eliminar"/>
							<input class="muygrande" id="inputFile" name="inputFile" type="file"  style="width:700px;" onChange="EnviarFichero(this.files);"/>
							<div id="infoProgreso" style="margin-left:300px;"/>
        				</xsl:otherwise>
        			</xsl:choose>
				</li>
				</xsl:if>
				<li><label><xsl:value-of select="document($doc)/translation/texts/item[@name='Macros_autorizadas']/node()"/>&nbsp;</label>&nbsp;</li>
				<BR/><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='Datos_contrato']/node()"/></strong><BR/>
				<xsl:value-of select="document($doc)/translation/texts/item[@name='Numero_contrato']/node()"/>:[NUMERO_CONTRATO]<BR/>
				<xsl:value-of select="document($doc)/translation/texts/item[@name='Titulo_contrato']/node()"/>:[TITULO_CONTRATO]<BR/>
				<xsl:value-of select="document($doc)/translation/texts/item[@name='Fecha_firma']/node()"/>:[FECHA_FIRMA]<BR/>
				<xsl:value-of select="document($doc)/translation/texts/item[@name='Fecha_inicio']/node()"/>:[FECHA_INICIO]<BR/>
				<xsl:value-of select="document($doc)/translation/texts/item[@name='Fecha_final']/node()"/>:[FECHA_FINAL]<BR/>
				<xsl:value-of select="document($doc)/translation/texts/item[@name='Duracion_contrato']/node()"/>:[DURACION_CONTRATO]<BR/>
				<BR/><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='Cliente']/node()"/></strong>&nbsp;<BR/>
				<xsl:value-of select="document($doc)/translation/texts/item[@name='Logo_cliente']/node()"/>:[LOGO_CLIENTE]<BR/>
				<xsl:value-of select="document($doc)/translation/texts/item[@name='Nombre_centro_cliente']/node()"/>:[NOMBRE_CENTRO_CLIENTE]<BR/>
				<BR/><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='Proveedor_empresa']/node()"/></strong>&nbsp;<BR/>
				<xsl:value-of select="document($doc)/translation/texts/item[@name='Nombre_proveedor']/node()"/>:[NOMBRE_PROVEEDOR]<BR/>
				<xsl:value-of select="document($doc)/translation/texts/item[@name='NIF_proveedor']/node()"/>:[NIT_PROVEEDOR]<BR/>
				<xsl:value-of select="document($doc)/translation/texts/item[@name='Direccion_proveedor']/node()"/>:[DIRECCION_PROVEEDOR]<BR/>
				<xsl:value-of select="document($doc)/translation/texts/item[@name='Poblacion_proveedor']/node()"/>:[POBLACION_PROVEEDOR]<BR/>
				<xsl:value-of select="document($doc)/translation/texts/item[@name='Provincia_proveedor']/node()"/>:[PROVINCIA_PROVEEDOR]<BR/>
				<xsl:value-of select="document($doc)/translation/texts/item[@name='Barrio_proveedor']/node()"/>:[BARRIO_PROVEEDOR]<BR/>
				<xsl:value-of select="document($doc)/translation/texts/item[@name='Cod_postal_proveedor']/node()"/>:[CODIGO_POSTAL_PROVEEDOR]<BR/>
				<BR/><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='Proveedor_representante']/node()"/></strong>&nbsp;<BR/>
				<xsl:value-of select="document($doc)/translation/texts/item[@name='Nombre_representante']/node()"/>:[NOMBRE_REPRESENTANTE_PROVEEDOR]<BR/>
				<xsl:value-of select="document($doc)/translation/texts/item[@name='Correo_representante']/node()"/>:[CORREO_REPR_PROVEEDOR]<BR/>
				<xsl:value-of select="document($doc)/translation/texts/item[@name='Telefono_representante']/node()"/>:[TELEFONO_REPR_PROVEEDOR]<BR/>
				<xsl:value-of select="document($doc)/translation/texts/item[@name='Tipo_identificacion_representante']/node()"/>:[TIPO_IDENTIF_REPR_PROVEEDOR]<BR/>
				<xsl:value-of select="document($doc)/translation/texts/item[@name='Identificacion_representante']/node()"/>:[IDENTIFICACION_REPR_PROVEEDOR]<BR/>
			</ul>
    	</div>
		</form>
		<!--	FIN nuevo formulario	-->
	</xsl:otherwise>
	</xsl:choose><!--fin choose si contrato guardado con exito-->
	</div><!--fin de divLeft-->
</xsl:otherwise>
</xsl:choose>
</body>
</html>
</xsl:template>
</xsl:stylesheet>
