<?xml version="1.0" encoding="iso-8859-1"?>
<!--
	Herramientas de administracion avanzada
	Ultima revisión: ET 19ene22 11:00
+-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:import href = "http://www.newco.dev.br/General/General.xsl"/>
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="lang" select="@lang"/>
<xsl:template match="/">

<!--	Todos los documentos HTML deben empezar con esto	-->
<xsl:text disable-output-escaping='yes'>&lt;!doctype html></xsl:text>

<html>
<head>
	<title>AdminTec:<xsl:value-of select="/Administracion/INICIO/RESULTADO"/></title>
	<xsl:call-template name="estiloIndip"/>
	<!--	11ene22 nuevos estilos -->
	<!--<link rel="stylesheet" href="http://www.newco.dev.br/General/basicMVM2022.css"/>-->
	<link href='http://fonts.googleapis.com/css?family=Roboto' rel='stylesheet'/>
	<!--	11ene22 nuevos estilos -->

	<script src="http://www.newco.dev.br/General/jquery-3.6.0.js"></script>	
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic2022_010822.js"></script>
	<!--<script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>-->
	<script type="text/javascript" src="http://www.newco.dev.br/Gestion/AdminTecnica/AdminTecnica_190122.js"></script>
</head>

<body onLoad="javascript:onLoadBody();">
<xsl:choose>
<xsl:when test="/Administracion/ERROR">
	<h1 class="titlePage">Administración Técnica</h1>
	<h2 class="titlePage">No tiene derechos para acceder a esta página</h2>
</xsl:when>
<xsl:otherwise>
	<!--idioma-->
	<xsl:variable name="lang">
    	<xsl:choose>
    	<xsl:when test="/CambioClave/LANG"><xsl:value-of select="/CambioClave/LANG" /></xsl:when>
    	<xsl:otherwise>spanish</xsl:otherwise>
    	</xsl:choose>  
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
    <!--idioma fin--> 

	<!-- Formulario, debe incluir la cabecera por el desplegable de periodo -->
	<form name="Admin" method="post" action="http://www.newco.dev.br/Gestion/AdminTecnica/AdminTecnica2022.xsql">


	<!-- Bloque de título -->
	<div class="ZonaTituloPagina">
		<p class="TituloPagina">
			<xsl:choose>
			<xsl:when test="/Administracion/INICIO/RESULTADO">
				<xsl:value-of select="/Administracion/INICIO/RESULTADO"/>
			</xsl:when>
			<xsl:otherwise>
          		<xsl:value-of select="document($doc)/translation/texts/item[@name='Administracion_tecnica']/node()"/>
			</xsl:otherwise>
			</xsl:choose>
			<span class="CompletarTitulo">
				<a class="btnDestacado" href="http://www.newco.dev.br:8080/probe/threads.htm?d-5474-s=4&amp;d-5474-o=2" target="blank_">Monitor Tomcat</a>
				&nbsp;
				<xsl:if test="/Administracion/INICIO/ACCION='LOGS'">
					<a class="btnNormal" href="javascript:Enviar();">Repetir Consulta</a>
					&nbsp;
					<xsl:call-template name="desplegable">
						<xsl:with-param name="path" select="/Administracion/INICIO/PERIODO/field"></xsl:with-param>
						<xsl:with-param name="onChange">javascript:ActualizacionPeriodica();</xsl:with-param>
						<xsl:with-param name="style">font-size:15px;height:28px</xsl:with-param>					
						</xsl:call-template>
				</xsl:if>
			</span>
		</p>
	</div>
	<br/>
	<br/>
	<br/>
	<!-- Bloque de info para los paquetes -->
	<xsl:if test="/Administracion/INICIO/ACCION='PAQUETES' or /Administracion/INICIO/ACCION='RECOMPILAR'">
		<xsl:choose>
		<xsl:when test="/Administracion/INICIO/PAQUETES_INVALIDOS/PAQUETE">
			<div class="tabela tabela_redonda">
			<table class="tableCenter"  cellspacing="6px" cellpadding="6px">
			<thead class="cabecalho_tabela">
				<tr class="subTituloTabla">
                    <th class="textCenter w1px">Pos.</th>
					<th class="textCenter">Fecha</th>
					<th class="textCenter">Tipo</th>
					<th align="left">Paquetes inválidos</th>
					<th class="textCenter">Estado</th>
				</tr>
			</thead>

			<tbody class="corpo_tabela">
			<xsl:for-each select="/Administracion/INICIO/PAQUETES_INVALIDOS/PAQUETE">
				<tr class="conhover">
                    <td class="textCenter color_status"><xsl:value-of select="position()"/></td>
					<td class="textCenter"><xsl:value-of select="FECHA"/></td>
					<td class="textCenter"><xsl:value-of select="TIPO"/></td>
					<td align="left">&nbsp;<xsl:value-of select="NOMBRE"/></td>
					<td class="textCenter"><xsl:value-of select="ESTADO"/></td>
				</tr>
			</xsl:for-each>
			</tbody>
			<tfoot class="rodape_tabela">
				<td colspan="5">&nbsp;</td>
			</tfoot>
			</table>
			</div>
		</xsl:when>
		<xsl:otherwise>
			<div class="tabela tabela_redonda">
            <table class="buscador">
                <tr class="amarillo">
                    <td class="w1px">&nbsp;</td>
                    <td><h2>No se han encontrado paquetes inválidos</h2></td>
                    <td>&nbsp;</td>
                </tr>
            </table>
			</div>
		</xsl:otherwise>
		</xsl:choose>
	</xsl:if>

	<!-- Bloque de info para los logs -->
	<xsl:if test="/Administracion/INICIO/ACCION='LOGS'">
	<xsl:choose>
	<xsl:when test="/Administracion/INICIO/LOG/ENTRADA/COLUMNA">
		<div class="divCenter w500px textCenter">
			<h2><xsl:value-of select="/Administracion/INICIO/LOG/TABLA"/></h2>
		</div>
		<div class="tabela tabela_redonda">
		<table class="tableCenter"  cellspacing="6px" cellpadding="6px">
		<xsl:if test="/Administracion/INICIO/LOG/STYLE">
			<xsl:attribute name="style"><xsl:value-of select="/Administracion/INICIO/LOG/STYLE"/></xsl:attribute>
		</xsl:if>
		<thead class="cabecalho_tabela">
			<!--
			<tr>
				<th class="w1px">&nbsp;</th>
				<th>
					<xsl:attribute name="colspan"><xsl:value-of select="/Administracion/INICIO/LOG/NUMCOLUMNAS"/></xsl:attribute>
					<xsl:value-of select="/Administracion/INICIO/LOG/TABLA"/>
				</th>
			</tr>-->
			<tr class="titulos">
				<th class="w1px">&nbsp;</th>
				<xsl:for-each select="/Administracion/INICIO/LOG/CABECERA/COLUMNA">
					<th><xsl:copy-of select="."/></th>
				</xsl:for-each>
			</tr>
        </thead>
		<tbody class="corpo_tabela">
		<xsl:choose>
		<xsl:when test="/Administracion/INICIO/LOG/ENTRADA">
			<xsl:for-each select="/Administracion/INICIO/LOG/ENTRADA">
				<tr class="conhover">
					<td class="color_status">&nbsp;</td>
					<xsl:choose>
					<xsl:when test="TEXTO">
						<td class="textCenter">
							<xsl:attribute name="colspan"><xsl:value-of select="/Administracion/INICIO/LOG/NUMCOLUMNAS"/></xsl:attribute>
							<xsl:value-of select="TEXTO"/>
						</td>
					</xsl:when>
					<xsl:otherwise>
						<xsl:for-each select="COLUMNA">
							<td>
								<xsl:attribute name="align">
									<xsl:choose>
									<xsl:when test="IZQ">left</xsl:when>
									<xsl:when test="DER">right</xsl:when>
									<xsl:when test="CEN">center</xsl:when>
									<xsl:otherwise>left</xsl:otherwise><!--	2set19	antes center	-->
									</xsl:choose>
								</xsl:attribute>
								<xsl:attribute name="class">
									<xsl:choose>
									<xsl:when test="VERDE">celdaconverde</xsl:when>
									<xsl:when test="ROJO">celdaconrojo</xsl:when>
									<xsl:when test="AZUL">azul</xsl:when>
									</xsl:choose>
								</xsl:attribute>
								<xsl:copy-of select="."/>
							</td>
						</xsl:for-each>
					</xsl:otherwise>
					</xsl:choose>
				</tr>
			</xsl:for-each>
		</xsl:when>
		<xsl:otherwise>
			<tr class="amarillo">
				<td class="color_status">&nbsp;</td>
				<td class="textCenter">
					<xsl:attribute name="colspan"><xsl:value-of select="/Administracion/INICIO/LOG/NUMCOLUMNAS"/></xsl:attribute>
					<strong>No se han encontrado entradas</strong>
				</td>
			</tr>
		</xsl:otherwise>
		</xsl:choose>
		</tbody>
		<tfoot class="rodape_tabela">
			<td>&nbsp;</td>
			<td><xsl:attribute name="colspan"><xsl:value-of select="/Administracion/INICIO/LOG/NUMCOLUMNAS"/></xsl:attribute>&nbsp;</td>
		</tfoot>
		</table>
		</div>
	</xsl:when>
	<xsl:otherwise>
		<xsl:choose>
		<xsl:when test="/Administracion/INICIO/LOG/ENTRADA">
			<div class="tabela tabela_redonda">
			<table class="w1600px tableCenter"  cellspacing="6px" cellpadding="6px">
			<thead class="cabecalho_tabela">
				<tr>
                    <th class="w20px">Pos.</th>
                    <th class="textCenter">Fecha</th>
                    <th align="left">Mensaje</th>
                </tr>
			</thead>

			<tbody class="corpo_tabela">
            <xsl:variable name="linea" select="/Administracion/INICIO/LOG/ENTRADA[1]/LINEA" />
			<xsl:for-each select="/Administracion/INICIO/LOG/ENTRADA">
				<tr>
                    <td class="color_status">
                        <xsl:choose>
                            <xsl:when test="LINEA != ''"><xsl:value-of select="LINEA" /></xsl:when>
                            <xsl:when test="LINEA != '' and $linea = ''"><xsl:value-of select="position()"/></xsl:when>
                        </xsl:choose>
                    </td>
                    <td class="textCenter"><xsl:value-of select="FECHA"/></td>
                    <td align="left">&nbsp;<xsl:value-of select="TEXTO"/></td>
				</tr>
			</xsl:for-each>
			</tbody>
			<tfoot class="rodape_tabela">
				<td colspan="3">&nbsp;</td>
			</tfoot>
			</table>
			</div>
		</xsl:when>
		<xsl:otherwise>
            <table class="w1000px tableCenter">
                <tr class="amarillo">
                    <td class="cinco">&nbsp;</td>
                    <td><h2>No se han encontrado entradas</h2></td>
                    <td>&nbsp;</td>
                </tr>
            </table>
		</xsl:otherwise>
		</xsl:choose>
	</xsl:otherwise>
	</xsl:choose>
	</xsl:if>

	<!-- Bloque de info para los ficheros de integración -->
	<xsl:if test="/Administracion/INICIO/ACCION='INT_CONSULTA' or /Administracion/INICIO/ACCION='INT_EJECUTAR' or /Administracion/INICIO/ACCION='INT_OKMANUAL'">
		<xsl:choose>
		<xsl:when test="/Administracion/INICIO/INTEGRACION/FICHERO">
			<div class="tabela tabela_redonda">
			<table class="w1600px tableCenter">
			<thead>
				<tr class="titulos">
                    <th class="textCenter w1px">Pos.</th>
					<th class="textCenter">Fecha</th>
					<th class="textCenter">Cliente</th>
					<th class="textCenter">Proveedor</th>
					<th class="textCenter">Fichero</th>
					<th class="textCenter">Acción</th>
					<th class="textCenter">Comentarios</th>
					<th class="textCenter">Acciones</th>
				</tr>
			</thead>

			<tbody class="corpo_tabela">
            <xsl:variable name="linea" select="/Administracion/INICIO/INTEGRACION/FICHERO[1]/LINEA" />
			<xsl:for-each select="/Administracion/INICIO/INTEGRACION/FICHERO">
				<tr>
                    <td class="color_status">
                    <xsl:choose>
                        <xsl:when test="LINEA != ''"><xsl:value-of select="LINEA" /></xsl:when>
                        <xsl:when test="LINEA != '' and $linea = ''"><xsl:value-of select="position()"/></xsl:when>
                    </xsl:choose>
                    </td>
					<td align="left">&nbsp;<xsl:value-of select="FECHA"/></td>
					<td align="left">&nbsp;<xsl:value-of select="CLIENTE"/></td>
					<td align="left">&nbsp;<xsl:value-of select="PROVEEDOR"/></td>
					<td align="left">&nbsp;<xsl:value-of select="NOMBRE"/></td>
					<td align="left">&nbsp;<xsl:value-of select="ACCION"/></td>
					<!--<td align="left">&nbsp;<xsl:value-of select="ESTADO"/></td>-->
					<td align="left">&nbsp;<xsl:value-of select="COMENTARIOS"/></td>
					<td class="textCenter">&nbsp;
						<a href="javascript:EjecutarFichero({ID});">Ejecutar</a>&nbsp;
						<a href="javascript:OkManualFichero({ID});">OkManual</a>&nbsp;
						<a href="javascript:EditarFichero({ID});">Editar</a>
					</td>
				</tr>
			</xsl:for-each>
			</tbody>
			<tfoot class="rodape_tabela">
				<td colspan="8">&nbsp;</td>
			</tfoot>
			</table>
			</div>
		</xsl:when>
		<xsl:otherwise>
            <table class="textCenter">
                    <tr class="amarillo">
                        <td class="cuarenta">&nbsp;</td>
                        <td><h2>No se han encontrado ficheros pendientes</h2></td>
                        <td>&nbsp;</td>
                    </tr>
            </table>
		</xsl:otherwise>
		</xsl:choose>
	</xsl:if>
	<br/>
	<br/>
	<input type="hidden" name="ACCION" value="{/Administracion/INICIO/ACCION}"/>
	<input type="hidden" name="PARAMETROS" value="{/Administracion/INICIO/PARAMETROS}"/>

		<table class="tableCenter w1600px" cellspacing="10px" cellpadding="10px">
		<tbody>
			<tr class="sinLinea">
				<td class="uno">&nbsp;</td>
				<td class="labelRight trenta">1.- Asociar empresa a catálogo:</td>
				<td class="veinte textLeft" colspan="3">
					<xsl:call-template name="desplegable">
						<xsl:with-param name="path" select="/Administracion/INICIO/CLIENTESSINCATALOGO/field"></xsl:with-param>
						<xsl:with-param name="claSel">w150px</xsl:with-param>
					</xsl:call-template>
					&nbsp;&nbsp;&nbsp;&nbsp;catálogo:&nbsp;
					<xsl:call-template name="desplegable">
						<xsl:with-param name="path" select="/Administracion/INICIO/CATALOGOSPADRE/field"></xsl:with-param>
						<xsl:with-param name="claSel">w150px</xsl:with-param>
					</xsl:call-template>
				</td>
				<td class="textLeft" colspan="2">DESACTIVADO<!--<a href="javascript:AsociarEmpresa();">Asociar</a>--></td>
			</tr>
			<tr class="sinLinea">
				<td>&nbsp;</td>
				<td class="labelRight">2.- Desbloquear proveedor:</td>
				<td class="textLeft" colspan="3">
					<xsl:call-template name="desplegable">
						<xsl:with-param name="path" select="/Administracion/INICIO/PROVEEDORESBLOQUEADOS/field"></xsl:with-param>
						<xsl:with-param name="claSel">w300px</xsl:with-param>
					</xsl:call-template>
				</td>
				<td class="textLeft" colspan="2"><a class="btnDestacado" href="javascript:DesbloquearProveedor();">Desbloquear</a></td>
			</tr>

			<tr class="sinLinea">
				<td>&nbsp;</td>
				<td class="labelRight">3.- Bloquear proveedor:</td>
				<td class="textLeft" colspan="3">
					<xsl:call-template name="desplegable">
						<xsl:with-param name="path" select="/Administracion/INICIO/PROVEEDORESDESBLOQUEADOS/field"></xsl:with-param>
						<xsl:with-param name="claSel">w300px</xsl:with-param>
					</xsl:call-template>
				</td>
				<td class="textLeft" colspan="2"><a class="btnDestacado" href="javascript:BloquearProveedor();">Bloquear</a></td>
			</tr>

			<tr class="sinLinea">
				<td>&nbsp;</td>
				<td class="labelRight">4.- Copiar derechos generales:</td>
				<td class="textLeft" colspan="3">
					de US_ID: <input type="text" class="campopesquisa" size="5" name="CDG_ORIGEN"/> a US_ID: <input type="text" class="campopesquisa" size="5" name="CDG_DESTINO"/>
				</td>
				<td class="textLeft" colspan="2">
					<a class="btnDestacado" href="javascript:CopiarDerechosGenerales();">Copiar</a>
					&nbsp;&nbsp;&nbsp;&nbsp;(no se copian derechos de pedidos sobre varios centros)
				</td>
			</tr>

			<tr class="sinLinea">
				<td>&nbsp;</td>
				<td class="labelRight">5.- Copiar derechos menus:</td>
				<td class="textLeft" colspan="3">
					de US_ID: <input type="text" class="campopesquisa" size="5" name="CDM_ORIGEN"/> a US_ID: <input type="text" class="campopesquisa" size="5" name="CDM_DESTINO"/>
				</td>
				<td class="textLeft" colspan="2"><a class="btnDestacado" href="javascript:CopiarDerechosMenu();">Copiar</a></td>
			</tr>

			<tr class="sinLinea">
				<td>&nbsp;</td>
				<td class="labelRight">6.- Copiar derechos carpetas y plantillas:</td>
				<td class="textLeft" colspan="3">
					de US_ID: <input type="text" class="campopesquisa" size="5" name="CDP_ORIGEN"/> a US_ID: <input type="text" class="campopesquisa" size="5" name="CDP_DESTINO"/>
				</td>
				<td class="textLeft" colspan="2"><a class="btnDestacado" href="javascript:CopiarDerechosCarpetasYPlantillas();">Copiar</a></td>
			</tr>

			<tr class="sinLinea">
				<td>&nbsp;</td>
				<td class="labelRight">7.- Ocultar productos no comprados en empresa:</td>
				<td class="textLeft" colspan="3">
					<xsl:call-template name="desplegable">
						<xsl:with-param name="path" select="/Administracion/INICIO/CLIENTES/field"></xsl:with-param>
						<xsl:with-param name="claSel">w300px</xsl:with-param>
					</xsl:call-template>
				</td>
				<td class="textLeft" colspan="2"><a class="btnDestacado" href="javascript:OcultarProductosNoCompradosAEmpresa();">Ocultar</a></td>
			</tr>

			<tr class="sinLinea">
				<td>&nbsp;</td>
				<td class="labelRight">8.- Derechos productos en plantillas del usuario:</td>
				<td class="textLeft" colspan="3">
					<input type="text" size="5" class="campopesquisa" name="IDUSUARIOOCULTAR"/>
				</td>
				<td class="textLeft" colspan="2">
					<a class="btnDestacado" href="javascript:DerechosProductosUsuario('OCULTARNOCOMPRADOS');">Ocultar productos no comprados</a>&nbsp;
					<a class="btnDestacado" href="javascript:DerechosProductosUsuario('OCULTARTODOS');">Ocultar todos</a>&nbsp;
					<a class="btnDestacado" href="javascript:DerechosProductosUsuario('MOSTRARTODOS');">Mostrar Todos</a>&nbsp;
					<a class="btnDestacado" href="javascript:DerechosProductosUsuario('SEGUNCENTRO');">Según derechos centro</a>
				</td>
			</tr>
			<tr class="sinLinea">
				<td>&nbsp;</td>
				<td class="labelRight">9.- Otras acciones:</td>
				<td class="textLeft" colspan="5">
					<a class="btnNormal" href="javascript:Accion('COMPROBAR_PROGRAMAS');">Comprobar programas</a>
				</td>
			</tr>

			<tr class="sinLinea">
				<td>&nbsp;</td>
				<td class="labelRight">10.- Consultar situación ficheros integración :</td>
				<td class="textLeft" colspan="5">
					<a class="btnNormal" href="javascript:Accion('INT_CONSULTA');">Consulta</a>
				</td>
			</tr>

			<tr class="sinLinea">
				<td>&nbsp;</td>
				<td class="labelRight">11.- Otras consultas</td>
				<td class="textLeft">
					<xsl:call-template name="desplegable">
						<xsl:with-param name="path" select="/Administracion/INICIO/TIPOLOG/field"></xsl:with-param>
						<xsl:with-param name="claSel">w200px</xsl:with-param>
					</xsl:call-template>
				</td>
				<td class="textLeft">
					<xsl:call-template name="desplegable">
						<xsl:with-param name="path" select="/Administracion/INICIO/PLAZO/field"></xsl:with-param>
						<xsl:with-param name="claSel">w100px</xsl:with-param>
					</xsl:call-template>
				</td>
				<td class="textLeft">
					<xsl:call-template name="desplegable">
						<xsl:with-param name="path" select="/Administracion/INICIO/LINEAS/field"></xsl:with-param>
						<xsl:with-param name="claSel">w100px</xsl:with-param>
					</xsl:call-template>
				</td>
				<td class="textLeft">
					<input type="text" class="campopesquisa" size="20" name="FILTRO" value="{/Administracion/INICIO/RESTRICCION}"/>
				</td>
				<td class="textLeft"><a class="btnNormal" href="javascript:ConsultarLogs();">Consultar</a>&nbsp;<a class="btnDestacado" href="javascript:BorrarLogs();">Borrar</a></td>
			</tr>
		</tbody>
		</table>

		<xsl:if test="/Administracion/INICIO/ADMINISTRADOR_TECNICO">
			<table class="tableCenter w1600px" cellspacing="10px" cellpadding="10px">
				<tr><td colspan="5">&nbsp;</td></tr>

				<tr class="subCategorias"><th colspan="3" class="textCenter">AVANZADO</th><th colspan="2">&nbsp;</th></tr>

			<tbody>
				<tr class="sinLinea">
					<td class="uno">&nbsp;</td>
					<td class="trenta labelRight">A.- Ver paquetes invalidos</td>
					<td class="veinte">&nbsp;</td>
					<td class="cuarenta textLeft"><a class="btnNormal" href="javascript:Accion('PAQUETES');">Consulta</a></td>
					<td>&nbsp;</td>
				</tr>

				<tr class="sinLinea">
					<td>&nbsp;</td>
					<td class="labelRight">B.- Recompilar paquetes</td>
					<td>&nbsp;</td>
					<td class="textLeft"><a class="btnDestacado" href="javascript:Accion('RECOMPILAR');">Recompilar</a></td>
					<td>&nbsp;</td>
				</tr>

				<tr>
					<td>&nbsp;</td>
					<td class="labelRight">C.- Matar sesión ():</td>
					<td class="textLeft">
						<input type="text" class="campopesquisa" size="8" name="IDSESION"/> [sid,serial#]
					</td>
					<td class="textLeft"><a class="btnDestacado" href="javascript:MatarSesion();">Matar</a>&nbsp;&nbsp;<a href="javascript:MatarSesionesAntiguas();">Matar Antiguas</a>&nbsp;&nbsp;<a href="javascript:MatarTodasSesiones();">Matar Todas</a></td>
					<td>&nbsp;</td>
				</tr>
<!--	DC - 20/03/14 - Pide Eduardo ocultar estas dos opciones
				<tr>
					<td>&nbsp;</td>
					<td class="labelRight">D.- Lanzar "Select"</td>
					<td><TEXTAREA cols="40" rows="3" name="SQL_SELECT"/></td>
					<td><a href="javascript:SQLSelect();">Select</a></td>
					<td>&nbsp;</td>
				</tr>

				<tr>
					<td>&nbsp;</td>
					<td class="labelRight">E.- Lanzar "Update"</td>
					<td><TEXTAREA cols="40" rows="3" name="SQL_UPDATE"/></td>
					<td><a href="javascript:SQLUpdate();">Update</a></td>
					<td>&nbsp;</td>
				</tr>
-->
			</tbody>
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
		</xsl:if>
	</form>
</xsl:otherwise>
</xsl:choose>
</body>
</html>
</xsl:template>
</xsl:stylesheet>
