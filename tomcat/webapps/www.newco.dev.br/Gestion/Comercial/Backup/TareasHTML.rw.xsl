<?xml version="1.0" encoding="iso-8859-1"?>
<!--
 |
 +-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:import href = "http://www.newco.dev.br/General/General.xsl"/>
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="lang" select="@lang"/>
<xsl:template match="/Tareas">

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

	<title><xsl:value-of select="document($doc)/translation/texts/item[@name='gestion_tareas']/node()"/></title>

	<xsl:call-template name="estiloIndip"/>
  <link rel="stylesheet" type="text/css" href="http://www.newco.dev.br/General/TablaResumen-popup.css"/>

	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery-1.8.3.min.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/Gestion/Comercial/tareas_081015.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/TablaResumen-popup.js"></script>
  <script type="text/javascript">
<!--
		var start = new Date();
		console.log("Start: " + (new Date() - start));

		jQuery(window).ready(function() {
		   console.log("Ready: " + (new Date() - start));
		});

		jQuery(window).load(function() {
		   console.log("Done Carga Pagina: " + (new Date() - start));
		});
-->
		var crearCentro	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='crear_centro']/node()"/>';
  </script>
</head>

<body onload="TareasRecientes();">
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
		<h1 class="titlePage"><xsl:value-of select="document($doc)/translation/texts/item[@name='gestion_tareas']/node()"/></h1>
		<div class="divLeft">
			<p><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='no_tiene_derechos']/node()"/></strong></p>
		</div>
	</xsl:when>
	<xsl:otherwise>

    <form name="Admin" method="post" action="Tareas.xsql">
		<input type="hidden" name="IDPAIS" value="{INICIO/GESTIONCOMERCIAL/IDPAIS}"/>
		<input type="hidden" name="IDEMPRESAUSUARIO" value="{INICIO/IDEMPRESAUSUARIO}"/>
		<input type="hidden" name="IDEMPRESA" id="IDEMPRESA">
			<xsl:attribute name="value">
				<xsl:choose>
				<xsl:when test="INICIO/EMPRESAS/field/@current != ''"><xsl:value-of select="INICIO/EMPRESAS/field/@current"/></xsl:when>
				<xsl:otherwise><xsl:value-of select="IDEMPRESA"/></xsl:otherwise>
				</xsl:choose>
			</xsl:attribute>
		</input>
		<input type="hidden" name="SOLO_CLIENTES"/>
		<input type="hidden" name="SOLO_PROVEE"/>
		<input type="hidden" name="ACCION"/>
		<input type="hidden" name="PARAMETROS"/>

		<table class="infoTable" style="margin-bottom:10px;">
			<tr style="background:#C3D2E9;border-bottom:0px solid #3B5998;">
				<td>
					<p style="font-weight:bold;">
            <xsl:call-template name="desplegable">
							<xsl:with-param name="path" select="INICIO/EMPRESAS/field"/>
							<xsl:with-param name="onChange">javascript:CambiarEmpresa();</xsl:with-param>
              <xsl:with-param name="claSel">selectFont18</xsl:with-param>
            </xsl:call-template>
            &nbsp;&nbsp;
            <input type="checkbox" name="SOLO_CLIENTES_CK" onchange="soloClientes(document.forms['Admin']);"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='solo_clientes']/node()"/>&nbsp;&nbsp;
            <input type="checkbox" name="SOLO_PROVEE_CK" onchange="soloProvee(document.forms['Admin']);"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='solo_proveedores']/node()"/>
          </p>
				</td>
			</tr>
		</table><!--fin desplegable empresas, para saber de que empresa veo los datos-->

		<div style="background:#fff;float:left;">
			<!--	Bloque de pestañas	-->
      &nbsp;
      <xsl:if test="/Tareas/INICIO/IDEMPRESA != ''">
				<a href="http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPDetalle.xsql?EMP_ID={INICIO/IDEMPRESA}&amp;ESTADO=CABECERA" style="text-decoration:none;">
					<xsl:choose>
					<xsl:when test="LANG = 'spanish'">
						<img src="http://www.newco.dev.br/images/botonFicha.gif" alt="FICHA"/>
					</xsl:when>
					<xsl:otherwise>
						<img src="http://www.newco.dev.br/images/botonFicha.gif" alt="FICHA"/>
					</xsl:otherwise>
					</xsl:choose>
				</a>&nbsp;
      </xsl:if>

      <!--condiciones comerciales ven todos, cliente no ve licitaciones-->
      <xsl:if test="INICIO/IDEMPRESA != '' and (INICIO/COMERCIAL or INICIO/MVM or INICIO/MVMB or INICIO/USUARIO_CDC)">
        <a href="http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPDetalle.xsql?EMP_ID={INICIO/IDEMPRESA}&amp;ESTADO=CABECERA&amp;ZONA=COND_COMERC_PROV" style="text-decoration:none;">
          <xsl:choose>
          <xsl:when test="LANG = 'spanish'">
            <img src="http://www.newco.dev.br/images/botonCondicionesComerciales.gif" alt="CONDICIONES COMERCIALES" id="COND_COMERC"/>
          </xsl:when>
          <xsl:otherwise>
            <img src="http://www.newco.dev.br/images/botonCondicionesComerciales-BR.gif" alt="CONDIÇÕ•ES COMERCIAIS" id="COND_COMERC"/>
          </xsl:otherwise>
          </xsl:choose>
        </a>&nbsp;
      </xsl:if>

      <xsl:if test="INICIO/COMERCIAL or INICIO/MVM or INICIO/MVMB">
				<a href="http://www.newco.dev.br/Gestion/Comercial/Seguimiento.xsql?FIDEMPRESA={INICIO/IDEMPRESA}" style="text-decoration:none;">
					<xsl:choose>
					<xsl:when test="LANG = 'spanish'">
						<img src="http://www.newco.dev.br/images/botonSeguimiento.gif" alt="SEGUIMIENTO"/>
					</xsl:when>
					<xsl:otherwise>
						<img src="http://www.newco.dev.br/images/botonSeguimiento-Br.gif" alt="SEGUIMENTO"/>
					</xsl:otherwise>
					</xsl:choose>
				</a>&nbsp;
				<a href="http://www.newco.dev.br/Gestion/Comercial/Tareas.xsql?FIDEMPRESA={INICIO/IDEMPRESA}&amp;FIDRESPONSABLE=-1" style="text-decoration:none;">
					<xsl:choose>
					<xsl:when test="LANG = 'spanish'">
						<img src="http://www.newco.dev.br/images/botonTareas1.gif" alt="TAREAS"/>
					</xsl:when>
					<xsl:otherwise>
						<img src="http://www.newco.dev.br/images/botonTareas1-Br.gif" alt="TAREFAS"/>
					</xsl:otherwise>
					</xsl:choose>
				</a>&nbsp;
      </xsl:if>
      <xsl:if test="INICIO/IDEMPRESA != '' and (INICIO/MVM or INICIO/MVMB)">
				<a href="http://www.newco.dev.br/Gestion/Comercial/Meddicc.xsql?FIDEMPRESA={INICIO/IDEMPRESA}" style="text-decoration:none;">
					<xsl:choose>
					<xsl:when test="LANG = 'spanish'">
						<img src="http://www.newco.dev.br/images/botonMeddicc.gif" alt="MEDDICC"/>
					</xsl:when>
					<xsl:otherwise>
						<img src="http://www.newco.dev.br/images/botonMeddicc.gif" alt="MEDDICC"/>
					</xsl:otherwise>
					</xsl:choose>
	      </a>&nbsp;
				<a href="http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPDetalle.xsql?EMP_ID={INICIO/IDEMPRESA}&amp;ESTADO=CABECERA&amp;ZONA=DOCS" style="text-decoration:none;">
          <img src="http://www.newco.dev.br/images/botonDocumentos.gif" alt="DOCUMENTOS" id="DOCUMENTOS"/>
        </a>&nbsp;
    	</xsl:if>
    </div>

    <xsl:if test="INICIO/MVM or INICIO/MVMB">
      <div style="background:#fff;float:right;">
        <a href="http://www.newco.dev.br/Gestion/Comercial/BuscadorEmpresas.xsql" style="text-decoration:none;">
          <img src="http://www.newco.dev.br/images/botonBuscador.gif" alt="BUSCADOR"/>
        </a>
      </div>
    </xsl:if>

		<div class="divLeft">
			<!--	Bloque de tí­tulo	-->
      <h1 class="titlePage" style="float:left;width:60%;padding-left:20%;">
				<xsl:choose>
				<xsl:when test="INICIO/RESULTADO">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='gestion_tareas']/node()"/>:&nbsp;
          <xsl:value-of select="substring(INICIO/RESULTADO,0,48)"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="document($doc)/translation/texts/item[@name='gestion_tareas']/node()"/>&nbsp;
          <xsl:if test="INICIO/EMPRESAS/field/dropDownList/listElem[ID = ../../../../IDEMPRESA]/listItem != 'Todas'">[ <xsl:value-of select="INICIO/EMPRESAS/field/dropDownList/listElem[ID = ../../../../IDEMPRESA]/listItem"/> ]</xsl:if>
				</xsl:otherwise>
				</xsl:choose>
        <xsl:text>&nbsp;&nbsp;&nbsp;</xsl:text>
        <a href="javascript:window.print();" style="text-decoration:none;">
	        <img src="http://www.newco.dev.br/images/imprimir.gif"/>
          <xsl:value-of select="document($doc)/translation/texts/item[@name='imprimir']/node()"/>
        </a>
      </h1>
      <h1 class="titlePage" style="float:left;width:20%;">
        <xsl:if test="(INICIO/MVM or INICIO/MVMB or INICIO/ADMIN) and INICIO/IDEMPRESA != ''"><span style="float:right; padding:5px;" class="amarillo">EMP_ID: <xsl:value-of select="INICIO/EMPRESAS/field/@current"/></span></xsl:if>
      </h1>

			<!-- TODO! - DC - 30/10/2015 - Esto es necesario? -->
      <!-- Pop-up para mostrar tabla resumen empresa -->
      <xsl:if test="INICIO/MVM or INICIO/MVMB">
        <div class="overlay-container-2">
          <div class="window-container zoomout">
            <p><a href="javascript:showTablaResumenEmpresa(false);"><xsl:value-of select="document($doc)/translation/texts/item[@name='cerrar']/node()"/></a></p>
            <table>
            <thead>
              <tr>
                <td>&nbsp;</td>
                <xsl:for-each select="/Empresas/EMPRESA/RESUMENES_MENSUALES/CABECERA/COLUMNA">
                  <td><xsl:value-of select="MES"/>/<xsl:value-of select="ANYO"/></td>
                </xsl:for-each>
              </tr>
            </thead>

            <tbody>
              <xsl:for-each select="/Empresas/EMPRESA/RESUMENES_MENSUALES/RESUMEN_MENSUAL">
                <tr>
                  <td class="indicador"><xsl:value-of select="@Nombre"/></td>
                    <xsl:for-each select="COLUMNA">
                      <td><xsl:value-of select="VALOR"/></td>
                    </xsl:for-each>
                </tr>
              </xsl:for-each>
            </tbody>
          	</table>
          </div>
        </div>
      </xsl:if>
      <!-- FIN Pop-up para mostrar tabla resumen empresa -->

			<!-- INICIO Tabla Tareas -->
			<table class="infoTable" border="0">
      <xsl:choose>
      <xsl:when test="INICIO/GESTIONCOMERCIAL/GESTION">

				<!--buscador-->
				<tr class="subTituloTablaNoB">
					<td>&nbsp;</td>
					<td><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha']/node()"/></td>
					<td class="datosLeft">
            <xsl:value-of select="document($doc)/translation/texts/item[@name='autor']/node()"/><br />
						[<xsl:value-of select="document($doc)/translation/texts/item[@name='responsable']/node()"/>]
					</td>
					<td class="datosLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='empresa']/node()"/></td>
          <td class="datosLeft"><span class="centroBox"><xsl:value-of select="document($doc)/translation/texts/item[@name='centro']/node()"/></span></td>
          <td class="datosLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='tipo']/node()"/></td>
          <td class="datosLeft quince"><xsl:value-of select="document($doc)/translation/texts/item[@name='visibilidad']/node()"/></td>
          <td>&nbsp;</td><!--semaforo si caduca-->
					<td class="datosLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='descripcion_tarea']/node()"/></td>
          <td>&nbsp;</td>
					<td class="datosLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_limite']/node()"/></td>
					<td class="datosLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='estado']/node()"/></td>
					<td class="datosLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='prioridad']/node()"/></td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
				</tr>

				<!--desplegables buscador-->
				<tr class="subTituloTablaNoB">
					<td class="uno">&nbsp;</td>
					<td class="seis">&nbsp;</td>
					<td class="doce datosLeft">
						<!--responsable-->
						<xsl:call-template name="desplegable">
							<xsl:with-param name="path" select="INICIO/GESTIONCOMERCIAL/FIDRESPONSABLE/field"/>
              <xsl:with-param name="claSel">select140</xsl:with-param>
						</xsl:call-template>
					</td>
					<td class="dies datosLeft">
						<!--empresa-->
            <!--<xsl:value-of select="INICIO/EMPRESAS/field/dropDownList/listElem[ID = ../../@current]/listItem"/>
            <xsl:value-of select="INICIO/GESTIONCOMERCIAL/FIDEMPRESA/field/dropDownList/listElem[ID = ../../@current]/listItem"/>
						<xsl:call-template name="desplegable">
							<xsl:with-param name="path" select="INICIO/GESTIONCOMERCIAL/FIDEMPRESA/field"/>
              <xsl:with-param name="claSel">select100</xsl:with-param>
              <xsl:with-param name="nombre">ARRIBA_EMPRESA</xsl:with-param>
              <xsl:with-param name="id">ARRIBA_EMPRESA</xsl:with-param>
						</xsl:call-template>-->
					</td>

          <td class="datosLeft doce">
          <xsl:if test="INICIO/EMPRESAS/field/@current != ''">
            <select name="FIDCENTRO" id="FIDCENTRO" class="select140 centroBox">
              <xsl:for-each select="INICIO/LISTACENTROS/field/dropDownList/listElem">
                <option value="{ID}"><xsl:value-of select="listItem" /></option>
              </xsl:for-each>
            </select>
          </xsl:if>
					</td>

          <td class="cinco datosLeft">
						<xsl:call-template name="desplegable">
							<xsl:with-param name="path" select="INICIO/TIPO/field[@name= 'FIDTIPO']"/>
              <xsl:with-param name="claSel">select80</xsl:with-param>
						</xsl:call-template>
					</td>
          <td>&nbsp;</td><!--visibilidad-->
          <td>&nbsp;</td><!--semaforo si caduca-->
					<td class="datosLeft">
						<!--descripcion-->
						<input type="text" name="FTEXTO" size="40" value="{INICIO/GESTIONCOMERCIAL/FTEXTO}"/>
					</td>
          <td class="uno">&nbsp;</td>
					<td class="seis datosLeft">&nbsp;</td>
					<td class="cinco datosLeft"><!--estado-->
						<xsl:call-template name="desplegable">
							<xsl:with-param name="path" select="INICIO/GESTIONCOMERCIAL/FESTADO/field"/>
              <xsl:with-param name="defecto" select="INICIO/GESTIONCOMERCIAL/FESTADO/field/@current"/>
              <xsl:with-param name="claSel">select80</xsl:with-param>
						</xsl:call-template>
					</td>
					<td class="cinco datosLeft"><!--prioridad-->
						<xsl:call-template name="desplegable">
							<xsl:with-param name="path" select="INICIO/GESTIONCOMERCIAL/FPRIORIDAD/field"/>
              <xsl:with-param name="claSel">select80</xsl:with-param>
						</xsl:call-template>
					</td>
					<td class="siete" align="center">
						<div class="botonLargo">
							<strong><a href="javascript:EnviarTareas();"><xsl:value-of select="document($doc)/translation/texts/item[@name='buscar']/node()"/></a></strong>
						</div>
					</td>
					<td class="uno">&nbsp;</td>
				</tr>
				<!--fin buscador-->

				<tr class="subTituloTablaNoB line5"><td colspan="16" height="5px"></td></tr>

			<!--lista tareas hasta 5 tareas 9/12/2014 mc-->
			<xsl:for-each select="INICIO/GESTIONCOMERCIAL/GESTION">
				<tr>
        <xsl:choose>
				<xsl:when test="MODIFICADO_1HORA">
					<xsl:attribute name="style">border-bottom:1px solid #A7A8A9;background:#ff9900;</xsl:attribute>
				</xsl:when>
				<xsl:when test="MODIFICADO_24HORAS">
					<xsl:attribute name="style">border-bottom:1px solid #A7A8A9;background:yellow;</xsl:attribute>
				</xsl:when>
        <xsl:otherwise>
					<xsl:attribute name="style">border-bottom:1px solid #A7A8A9;</xsl:attribute>
        </xsl:otherwise>
				</xsl:choose>

					<xsl:variable name="id" select="ID"/>

					<td>
						<!-- TODO! - DC - 30/10/2015 - Esto es necesario? -->
						<xsl:attribute name="class">
							<xsl:choose>
							<xsl:when test="IDPADRE=ID and HIJOS != ''">dos<!--borderBottom--></xsl:when>
							<xsl:when test="IDPADRE!=ID">dos<!--borderRight--></xsl:when>
							</xsl:choose>
						</xsl:attribute>
					</td>
					<td class="borderTop">
						<xsl:if test="RECIENTE"><xsl:attribute name="class">amarillo</xsl:attribute></xsl:if>
						<input type="hidden" name="IDPADRE_{ID}" value="{IDPADRE}"/>
						<xsl:value-of select="FECHA"/>
					</td>
					<td class="datosLeft borderTop">
            <input type="hidden" name="IDRESPONSABLE_{ID}" value="{IDRESPONSABLE/field/@current}"/>
            <xsl:choose>
            <xsl:when test="AUTOR = IDRESPONSABLE/field/dropDownList/listElem[ID = ../../@current]/listItem">
              <xsl:value-of select="AUTOR"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="AUTOR"/><br />
              <xsl:value-of select="IDRESPONSABLE/field/dropDownList/listElem[ID = ../../@current]/listItem"/>
            </xsl:otherwise>
            </xsl:choose>
					</td>
					<td class="datosLeft borderTop"><!--si no hay marca comercial desabilito-->
            <a href="javascript:CambiarEmpresaID({IDEMPRESA/field/@current});">
              <xsl:value-of select="IDEMPRESA/field/dropDownList/listElem[ID = ../../@current]/listItem"/>
            </a>
            <input type="hidden" name="IDEMPRESA_{ID}" value="{IDEMPRESA/field/@current}"/>
					</td>
          <td class="datosLeft">
            <xsl:choose>
            <xsl:when test="/Tareas/INICIO/GESTIONCOMERCIAL/USUARIOCONECTADO/US_ID=IDAUTOR or /Tareas/INICIO/GESTIONCOMERCIAL/USUARIOCONECTADO/US_ID=IDRESPONSABLE or /Tareas/INICIO/SUPERUSUARIO"><!--si autor o responsable puede cambiar-->
              <xsl:variable name="idCentroSel" select="IDCENTRO"/>
              <select name="IDCENTRO_{ID}" id="IDCENTRO_{ID}" class="select140">
                <xsl:for-each select="/Tareas/INICIO/LISTACENTROS/field/dropDownList/listElem">
                  <xsl:choose>
                  <xsl:when test="ID = $idCentroSel">
                    <option value="{ID}" selected="selected"><xsl:value-of select="listItem"/></option>
                  </xsl:when>
                  <xsl:otherwise>
                    <option value="{ID}"><xsl:value-of select="listItem" /></option>
                  </xsl:otherwise>
                  </xsl:choose>
                </xsl:for-each>
              </select>
            </xsl:when>
            <xsl:otherwise>
              <xsl:variable name="idCentroSel" select="IDCENTRO"/>
              <select name="IDCENTRO_{ID}" id="IDCENTRO_{ID}" class="select200" disabled="disabled">
                <xsl:for-each select="/Tareas/INICIO/LISTACENTROS/field/dropDownList/listElem">
                  <xsl:choose>
                  <xsl:when test="ID = $idCentroSel">
                    <option value="{ID}" selected="selected"><xsl:value-of select="listItem" /></option>
                  </xsl:when>
                  <xsl:otherwise>
                    <option value="{ID}"><xsl:value-of select="listItem" /></option>
                  </xsl:otherwise>
                  </xsl:choose>
                </xsl:for-each>
              </select>
            </xsl:otherwise>
            </xsl:choose>
          </td>
          <!--TIPO-->
          <td class="datosLeft borderTop">
            <xsl:choose>
            <xsl:when test="/Tareas/INICIO/GESTIONCOMERCIAL/USUARIOCONECTADO/US_ID=IDAUTOR or /Tareas/INICIO/SUPERUSUARIO"><!--si autor puede cambiar-->
              <xsl:call-template name="desplegable">
								<xsl:with-param name="path" select="/Tareas/INICIO/GESTIONCOMERCIAL/GESTION/TIPO[@id=$id]/field"/>
                <xsl:with-param name="claSel">select80</xsl:with-param>
							</xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
              <xsl:call-template name="desplegable">
								<xsl:with-param name="path" select="/Tareas/INICIO/GESTIONCOMERCIAL/GESTION/TIPO[@id=$id]/field"/>
                <xsl:with-param name="deshabilitado">disabled</xsl:with-param>
                <xsl:with-param name="claSel">select80</xsl:with-param>
							</xsl:call-template>
            </xsl:otherwise>
            </xsl:choose>
            <input type="hidden" name="IDTIPO_{ID}" size="40" value="{TIPO/field/@current}"/>
					</td>
          <td style="text-align:left;">
            <xsl:choose>
            <xsl:when test="/Tareas/INICIO/GESTIONCOMERCIAL/USUARIOCONECTADO/US_ID=IDAUTOR or /Tareas/INICIO/SUPERUSUARIO"><!--si autor puede cambiar-->
              <input type="radio" name="VISIBILIDAD_{ID}" id="VIS_PRIVADA_{ID}" value="P">
              	<xsl:if test="VISIBILIDAD = 'P'">
                	<xsl:attribute name="checked">checked</xsl:attribute>
              	</xsl:if>
              </input>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='priv']/node()"/>&nbsp;&nbsp;
              <input type="radio" name="VISIBILIDAD_{ID}" id="VIS_CENTRO_{ID}" value="C">
                <xsl:if test="VISIBILIDAD = 'C'">
                  <xsl:attribute name="checked">checked</xsl:attribute>
                </xsl:if>
              </input>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='cen']/node()"/>&nbsp;&nbsp;
              <input type="radio" name="VISIBILIDAD_{ID}" id="VIS_EMPRESA_{ID}" value="E">
                <xsl:if test="VISIBILIDAD = 'E'">
                  <xsl:attribute name="checked">checked</xsl:attribute>
                </xsl:if>
              </input>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='emp']/node()"/>&nbsp;&nbsp;
            </xsl:when>
            <xsl:otherwise>
              <input type="radio" name="VISIBILIDAD_{ID}" id="VIS_PRIVADA_{ID}" value="P" disabled="disabled">
                <xsl:if test="VISIBILIDAD = 'P'">
                  <xsl:attribute name="checked">checked</xsl:attribute>
                </xsl:if>
              </input>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='priv']/node()"/>&nbsp;&nbsp;
              <input type="radio" name="VISIBILIDAD_{ID}" id="VIS_CENTRO_{ID}" value="C" disabled="disabled">
                <xsl:if test="VISIBILIDAD = 'C'">
                  <xsl:attribute name="checked">checked</xsl:attribute>
                </xsl:if>
              </input>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='cen']/node()"/>&nbsp;&nbsp;
              <input type="radio" name="VISIBILIDAD_{ID}" id="VIS_EMPRESA_{ID}" value="E" disabled="disabled">
                <xsl:if test="VISIBILIDAD = 'E'">
                  <xsl:attribute name="checked">checked</xsl:attribute>
                </xsl:if>
              </input>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='emp']/node()"/>&nbsp;&nbsp;
            </xsl:otherwise>
            </xsl:choose>
          </td>
          <td><!--semaforo si caduca-->
            <xsl:if test="CADUCADA">&nbsp;<img src="http://www.newco.dev.br/images/bolaRoja.gif" /></xsl:if>
            <xsl:if test="ACCION_INMEDIATA">&nbsp;<img src="http://www.newco.dev.br/images/bolaAmbar.gif" /></xsl:if>
          </td>
					<td class="datosLeft borderTop" style="padding:3px 0 3px 5px;">
            <xsl:value-of select="TEXTO" />
            <input type="hidden" name="TEXTO_{ID}" size="40" value="{TEXTO}"/>
          </td>
          <td>&nbsp;</td>
					<td class="datosLeft borderTop">
						<xsl:choose>
	          <xsl:when test="/Tareas/INICIO/GESTIONCOMERCIAL/USUARIOCONECTADO/US_ID=IDAUTOR or /Tareas/INICIO/SUPERUSUARIO"><!--si autor puede cambiar-->
	            <input type="text" name="FECHALIMITE_{ID}" size="8" value="{FECHALIMITE}">
								<xsl:if test="CADUCADA"><xsl:attribute name="class">rojoNormal</xsl:attribute></xsl:if>
	            </input>
	          </xsl:when>
	          <xsl:otherwise>
	            <xsl:value-of select="FECHALIMITE"/>
	            <input type="hidden" name="FECHALIMITE_{ID}" size="8" value="{FECHALIMITE}"/>
	          </xsl:otherwise>
	          </xsl:choose>
					</td>
					<td class="datosLeft borderTop">
            <xsl:choose>
            <xsl:when test="/Tareas/INICIO/GESTIONCOMERCIAL/USUARIOCONECTADO/US_ID=IDAUTOR or /Tareas/INICIO/GESTIONCOMERCIAL/USUARIOCONECTADO/US_ID=IDRESPONSABLE or /Tareas/INICIO/SUPERUSUARIO"><!--si autor o responsable puede cambiar-->
              <xsl:call-template name="desplegable">
								<xsl:with-param name="path" select="/Tareas/INICIO/GESTIONCOMERCIAL/GESTION/ESTADO[@id=$id]/field"/>
								<xsl:with-param name="claSel">select80</xsl:with-param>
							</xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
              <xsl:call-template name="desplegable">
								<xsl:with-param name="path" select="/Tareas/INICIO/GESTIONCOMERCIAL/GESTION/ESTADO[@id=$id]/field"/>
								<xsl:with-param name="claSel">select80</xsl:with-param>
                <xsl:with-param name="deshabilitado">disabled</xsl:with-param>
							</xsl:call-template>
            </xsl:otherwise>
            </xsl:choose>
					</td>
					<td class="datosLeft borderTop">
            <xsl:choose>
            <xsl:when test="/Tareas/INICIO/GESTIONCOMERCIAL/USUARIOCONECTADO/US_ID=IDAUTOR or /Tareas/INICIO/SUPERUSUARIO"><!--si autor puede cambiar-->
							<xsl:call-template name="desplegable">
								<xsl:with-param name="path" select="/Tareas/INICIO/GESTIONCOMERCIAL/GESTION/PRIORIDAD[@id=$id]/field"/>
								<xsl:with-param name="claSel">select80</xsl:with-param>
							</xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
              <xsl:call-template name="desplegable">
								<xsl:with-param name="path" select="/Tareas/INICIO/GESTIONCOMERCIAL/GESTION/PRIORIDAD[@id=$id]/field"/>
								<xsl:with-param name="claSel">select80</xsl:with-param>
                <xsl:with-param name="deshabilitado">disabled</xsl:with-param>
							</xsl:call-template>
            </xsl:otherwise>
            </xsl:choose>
					</td>
					<td class="datosLeft borderTop">
            <xsl:if test="/Tareas/INICIO/COMERCIAL"><!--si hay la marca de comercial enseño botones-->
              &nbsp;
              <xsl:choose>
              <xsl:when test="/Tareas/INICIO/GESTIONCOMERCIAL/USUARIOCONECTADO/US_ID=IDAUTOR or /Tareas/INICIO/GESTIONCOMERCIAL/USUARIOCONECTADO/US_ID=IDRESPONSABLE or /Tareas/INICIO/SUPERUSUARIO">
                <a href="javascript:ModificarGestion('{ID}');" style="text-decoration:none;">
                  <img src="http://www.newco.dev.br/images/modificar.gif" alt="Modificar"/>
                </a>&nbsp;
                <a href="javascript:BorrarGestion('{ID}', '{HIJOS}');" style="text-decoration:none;">
                	<img src="http://www.newco.dev.br/images/2017/trash.png" alt="Borrar"/>
                </a>&nbsp;
                <a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Gestion/Comercial/SeguimientoDeTarea.xsql?FIDEMPRESA={IDEMPRESA/field/@current}','Copiar gestion',100,80,0,-50);">
                  <img src="http://www.newco.dev.br/images/consultar.gif" alt="Copiar"/>
                </a>
              </xsl:when>
              <xsl:otherwise>
                <img src="http://www.newco.dev.br/images/modificarGris.gif"/>&nbsp;
                <img src="http://www.newco.dev.br/images/borrarGris.gif"/>&nbsp;
                <xsl:if test="../../EMPRESAS/field/@current != ''">
                  <img src="http://www.newco.dev.br/images/consultarGris.gif"/>
                </xsl:if>
              </xsl:otherwise>
              </xsl:choose>
            </xsl:if>
					</td>
					<td class="borderTop">&nbsp;</td>
				</tr>
      </xsl:for-each>
      </xsl:when>
      <xsl:otherwise>
        <tr style="border-bottom:2px solid #D7D8D7;"><td align="center"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='tareas_sin_resultados']/node()"/></strong></td></tr>
      </xsl:otherwise>
      </xsl:choose>
      </table>
			<!-- FIN Tabla Tareas -->

      <br /><br />

    <xsl:if test="INICIO/COMERCIAL and INICIO/IDEMPRESA != ''">
      <div class="divLeft20">&nbsp;</div>
      <div class="divLeft60nopa">
        <table class="infoTable incidencias" border="0" cellspacing="5" style="border-top:2px solid #D7D8D7;border-bottom:2px solid #D7D8D7;">
          <tr>
            <td colspan="4" class="grisMed" style="font-weight:bold;">
              <xsl:value-of select="document($doc)/translation/texts/item[@name='nueva']/node()"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='tarea']/node()"/>&nbsp;
              <xsl:value-of select="document($doc)/translation/texts/item[@name='de']/node()"/>&nbsp;
              <xsl:value-of select="INICIO/GESTIONCOMERCIAL/USUARIOCONECTADO/NOMBRE"/>&nbsp;
              <xsl:value-of select="document($doc)/translation/texts/item[@name='para']/node()"/>&nbsp;
              <xsl:value-of select="INICIO/EMPRESAS/field/dropDownList/listElem[ID = ../../@current]/listItem"/>&nbsp;
              <xsl:value-of select="document($doc)/translation/texts/item[@name='del']/node()"/>&nbsp;
              <xsl:value-of select="INICIO/GESTIONCOMERCIAL/FECHA"/>
              <input type="hidden" name="IDPADRE"/>
            </td>
          </tr>
          <tr>
            <td class="doce labelRight grisMed"><xsl:value-of select="document($doc)/translation/texts/item[@name='centro']/node()"/>:</td>
            <td class="veinte datosLeft">
              <select name="IDCENTRO" id="IDCENTRO" class="select250">
                <xsl:for-each select="INICIO/LISTACENTROS/field/dropDownList/listElem">
                  <option value="{ID}"><xsl:value-of select="listItem" /></option>
                </xsl:for-each>
              </select>
            </td>
            <td class="labelRight dies grisMed"><xsl:value-of select="document($doc)/translation/texts/item[@name='estado']/node()"/>:</td>
            <td class="datosLeft quince">
              <xsl:call-template name="desplegable">
								<xsl:with-param name="path" select="INICIO/GESTIONCOMERCIAL/ESTADO/field"/>
                <xsl:with-param name="claSel">select250</xsl:with-param>
							</xsl:call-template>
            </td>
          </tr>
          <tr>
            <td class="labelRight grisMed"><xsl:value-of select="document($doc)/translation/texts/item[@name='responsable']/node()"/>:</td>
            <td class="datosLeft">
              <xsl:call-template name="desplegable">
								<xsl:with-param name="path" select="INICIO/GESTIONCOMERCIAL/IDRESPONSABLE/field"/>
                <xsl:with-param name="claSel">select250</xsl:with-param>
              </xsl:call-template>
            </td>
            <td class="labelRight grisMed"><xsl:value-of select="document($doc)/translation/texts/item[@name='prioridad']/node()"/>:</td>
            <td class="datosLeft">
              <xsl:call-template name="desplegable">
                <xsl:with-param name="path" select="INICIO/GESTIONCOMERCIAL/PRIORIDAD/field"/>
                <xsl:with-param name="claSel">select250</xsl:with-param>
							</xsl:call-template>
            </td>
          </tr>
          <tr>
            <td class="labelRight grisMed"><xsl:value-of select="document($doc)/translation/texts/item[@name='tipo']/node()"/>:</td>
            <td class="datosLeft">
              <xsl:call-template name="desplegable">
                <xsl:with-param name="path" select="INICIO/TIPO/field[@name= 'IDTIPO']"/>
                <xsl:with-param name="claSel">select250</xsl:with-param>
              </xsl:call-template>
            </td>
            <td class="labelRight grisMed">
              <xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_limite']/node()"/>:</td>
            <td class="datosLeft"><input type="text" name="FECHALIMITE" size="8"/></td>
          </tr>
          <tr>
            <td class="dies labelRight grisMed"><xsl:value-of select="document($doc)/translation/texts/item[@name='visibilidad']/node()"/>:</td>
            <td colspan="3" class="datosLeft">
              <input type="radio" name="VISIBILIDAD" id="VIS_PRIVADA" value="P"></input>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='priv']/node()"/>&nbsp;&nbsp;
              <input type="radio" name="VISIBILIDAD" id="VIS_CENTRO" value="C" checked="checked"></input>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='cen']/node()"/>&nbsp;&nbsp;
              <input type="radio" name="VISIBILIDAD" id="VIS_EMPRESA" value="E"></input>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='emp']/node()"/>&nbsp;&nbsp;
            </td>
          </tr>
          <tr>
            <td class="labelRight grisMed"><xsl:value-of select="document($doc)/translation/texts/item[@name='descripcion']/node()"/>:</td>
            <td colspan="3" class="datosLeft"><input type="text" name="TEXTO" size="100"/></td>
          </tr>
          <tr style="border-bottom:2px solid #D7D8D7;">
            <td colspan="4" align="center">
							<div class="botonCenter">
                <strong><a href="javascript:NuevaGestion();"><xsl:value-of select="document($doc)/translation/texts/item[@name='nueva']/node()"/></a></strong>
							</div>
						</td>
          </tr>
        </table>
      </div>
    </xsl:if>
    </div>
		</form>

		<br/>
		<br/>

		<!--form de mensaje de error de js-->
		<form name="mensajeJS">
			<input type="hidden" name="FALTA_INFORMAR_GESTION_BORRAR" value="{document($doc)/translation/texts/item[@name='falta_informar_gestion_borrar']/node()}"/>
			<input type="hidden" name="FALTA_INFORMAR_GESTION_MODIFICAR" value="{document($doc)/translation/texts/item[@name='falta_informar_gestion_modificar']/node()}"/>
			<input type="hidden" name="BORRAR_TAREAS_SUBTAREAS" value="{document($doc)/translation/texts/item[@name='borrar_tarea_subtareas']/node()}"/>
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
