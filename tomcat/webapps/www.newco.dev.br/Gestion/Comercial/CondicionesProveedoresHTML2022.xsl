<?xml version="1.0" encoding="iso-8859-1"?>
<!--
	Condiciones de los proveedores
	Ultima revisión: ET 14abr20 09:10
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:import href="http://www.newco.dev.br/General/General.xsl"/>
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<!--<xsl:param name="lang" select="@lang"/>-->
<xsl:param name="usuario" select="@US_ID"/>

<xsl:template match="/CondicionesProv">

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

	<META Http-Equiv="Cache-Control" Content="no-cache" />
	<link rel="shortcut icon" href="http://www.newco.dev.br/images/MedicalVM.ico"/>

	<title><xsl:value-of select="document($doc)/translation/texts/item[@name='condiciones_proveedores']/node()"/></title>

	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<link href="http://www.newco.dev.br/General/Tabla-popup.150715.css" rel="stylesheet" type="text/css"/>
	<!--fin de style-->

	<!--	11ene22 nuevos estilos -->
	<!--<link rel="stylesheet" href="http://www.newco.dev.br/General/basicMVM2022.css"/>-->
	<link href='http://fonts.googleapis.com/css?family=Roboto' rel='stylesheet'/>
	<!--	11ene22 nuevos estilos -->

	<script src="http://www.newco.dev.br/General/jquery-3.6.0.js"></script>	
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic2022_010822.js"></script>

	<!--
	<script type="text/javascript" src="http://www.newco.dev.br/General/Tabla-popup.150715.js"></script>
	-->
	<!--<script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>-->
	<script type="text/javascript"><xsl:text disable-output-escaping="yes"><![CDATA[
	function CambioEmpresaActual(IDCliente)
	{
		document.forms["formProv"].elements["IDCLIENTE"].value = IDCliente;
		document.forms["formProv"].submit();
	}
	
	function Indicadores()
	{
		window.location="http://www.newco.dev.br/Gestion/EIS/IndicadoresProveedoresEIS2022.xsql?IDCLIENTE="+document.forms["formProv"].elements["IDCLIENTE"].value;
	}
	
	function Clasificacion()
	{
		window.location="http://www.newco.dev.br/Gestion/EIS/ClasificacionProveedoresEIS2022.xsql?IDCLIENTE="+document.forms["formProv"].elements["IDCLIENTE"].value;
	}

	function Evaluacion()
	{
		window.location="http://www.newco.dev.br/Gestion/EIS/EvaluacionProveedor2022.xsql?IDCLIENTE="+document.forms["formProv"].elements["IDCLIENTE"].value;
	}
	
    ]]></xsl:text></script>
</head>
<body>
<!--idioma-->
<xsl:variable name="lang">
	<xsl:choose>
		<xsl:when test="LANG"><xsl:value-of select="LANG"/></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
	</xsl:choose>
</xsl:variable>
<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
<!--idioma fin-->
<!--<xsl:choose>
	<xsl:when test="//SESION_CADUCADA">
		<xsl:apply-templates select="//SESION_CADUCADA"/>
	</xsl:when>
	<xsl:when test="//Sorry">
		<xsl:apply-templates select="//Sorry"/>
	</xsl:when>
	<xsl:otherwise>-->

<xsl:choose>
	<!-- Error en alguna sentencia del XSQL -->
	<xsl:when test="AreaPublica/xsql-error">
		<xsl:apply-templates select="AreaPublica/xsql-error"/>
	</xsl:when>
	<xsl:otherwise>    

	<!--	Titulo de la pagina		-->
	<div class="ZonaTituloPagina">
		<!--<p class="Path"><xsl:value-of select="document($doc)/translation/texts/item[@name='Inicio']/node()"/>&nbsp;/&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='proveedores']/node()"/>&nbsp;/&nbsp;<span class="FinPath"><xsl:value-of select="document($doc)/translation/texts/item[@name='condiciones_proveedores']/node()"/></span></p>-->
		<p class="TituloPagina">
        	<xsl:value-of select="document($doc)/translation/texts/item[@name='condiciones_proveedores']/node()"/>
			<span class="CompletarTitulo">
				<xsl:if test="/CondicionesProv/PROVEEDORES/MVM or /CondicionesProv/PROVEEDORES/EMPRESA or /CondicionesProv/PROVEEDORES/CDC">
					<a class="btnNormal" href="javascript:Evaluacion();">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='evaluacion_proveedor']/node()"/>
					</a>&nbsp;
					<a class="btnNormal" href="javascript:Indicadores();">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='indicadores_proveedores']/node()"/>
					</a>&nbsp;
					<a class="btnNormal" href="javascript:Clasificacion();">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='clasificacion_proveedores']/node()"/>
					</a>&nbsp;
				</xsl:if>
			</span>
		</p>
	</div>
	<br/>
	<br/>
	<br/>
	<br/>

	<form name="formProv" id="formProv" method="post" action="http://www.newco.dev.br/Gestion/Comercial/CondicionesProveedores.xsql">
		<input type="hidden" name="IDPAIS" value="{/CondicionesProv/PROVEEDORES/IDPAIS}"/>
		<input type="hidden" name="IDCLIENTE" value="{/CondicionesProv/PROVEEDORES/IDCLIENTE}"/>
	</form>

    <div class="divLeft">
    <table id="PestanasInicio" border="0" >
        <tr style="font-size:15px;">
			<th>
			<xsl:if test="/CondicionesProv/PROVEEDORES/CLIENTE/field">
			&nbsp;&nbsp;&nbsp;<strong><xsl:value-of select="document($doc)/translation/texts/item[@name='cliente']/node()"/>:</strong>&nbsp;
			<xsl:call-template name="desplegable">
				<xsl:with-param name="path" select="/CondicionesProv/PROVEEDORES/CLIENTE/field"/>
				<xsl:with-param name="claSel">w300px</xsl:with-param>
			</xsl:call-template>&nbsp;&nbsp;&nbsp;
			</xsl:if>
			&nbsp;&nbsp;&nbsp;
			<xsl:value-of select="document($doc)/translation/texts/item[@name='condiciones_pago_centro']/node()"/>&nbsp;
			<xsl:value-of select="/CondicionesProv/PROVEEDORES/FORMA_PAGO/CEN_NOMBRE"/>:&nbsp;
			<xsl:value-of select="/CondicionesProv/PROVEEDORES/FORMA_PAGO/CEN_FORMAPAGO_TXT"/>&nbsp;-&nbsp;
			<xsl:value-of select="/CondicionesProv/PROVEEDORES/FORMA_PAGO/CEN_PLAZOPAGO_TXT"/>
			</th>
        </tr>
    </table>
    </div>
	<br/>
	<br/>
	<br/>
	<div class="tabela tabela_redonda">
	<table cellspacing="6px" cellpadding="6px">
		<thead class="cabecalho_tabela">
			<tr>
				<th class="w1px">&nbsp;</th>
				<th >&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/></th>
				<!--<th class="cinco"><xsl:copy-of select="document($doc)/translation/texts/item[@name='num_prod_farmacia_2line']/node()"/></th>
				<th class="cinco"><xsl:copy-of select="document($doc)/translation/texts/item[@name='productos']/node()"/></th>-->
				<xsl:if test="/CondicionesProv/CDC">
					<th class="w100px"><xsl:value-of select="document($doc)/translation/texts/item[@name='num_ofertas']/node()"/></th>
					<th class="w100px"><xsl:copy-of select="document($doc)/translation/texts/item[@name='num_fichas_tecnicas_2line']/node()"/></th>
				</xsl:if>
				<th class="w120px"><xsl:copy-of select="document($doc)/translation/texts/item[@name='pedido_minimo']/node()"/></th>
				<th class="w120px"><xsl:copy-of select="document($doc)/translation/texts/item[@name='forma_pago']/node()"/></th>
				<th class="w200px"><xsl:copy-of select="document($doc)/translation/texts/item[@name='plazo_pago']/node()"/></th>
				<th class="w120px"><xsl:value-of select="document($doc)/translation/texts/item[@name='plazo_entrega']/node()"/></th>
				<th class="w120px"><xsl:value-of select="document($doc)/translation/texts/item[@name='plazo_envio']/node()"/></th>
				<th class="w1px">&nbsp;</th>
			</tr>
		</thead>
		<!--	Cuerpo de la tabla	-->
		<tbody class="corpo_tabela">
        <xsl:choose>
		<xsl:when test="PROVEEDORES/PROVEEDOR">
			<xsl:for-each select="PROVEEDORES/PROVEEDOR">
				<xsl:variable name="ProvID"><xsl:value-of select="ID"/></xsl:variable>
				<tr class="conhover">
					<td class="color_status">&nbsp;</td>
					<!-- Nombre Proveedor -->
					<td class="textLeft">
						&nbsp;
						<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPDetalleFrame.xsql?EMP_ID={ID}&amp;ESTADO=CABECERA','DetalleEmpresa',600,80,0,0)">
                        	<xsl:value-of select="NOMBRE"/>
                        </a>
					</td>
					<xsl:if test="/CondicionesProv/CDC">
						<!-- Numero Ofertas -->
						<td><xsl:value-of select="OFERTAS"/></td>
						<!-- Numero Fichas Tecnicas -->
						<td><xsl:value-of select="FICHASTECNICAS"/></td>
					</xsl:if>
					<!-- Pedido Minimo -->
					<td>
					<xsl:choose>
					<xsl:when test="CONDICIONES/PEDMINIMO_ACTIVO='S' and CONDICIONES/PEDMINIMO_IMPORTE!=''">
						<strong><xsl:value-of select="CONDICIONES/PEDMINIMO_IMPORTE"/></strong>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="document($doc)/translation/texts/item[@name='no']/node()"/>
					</xsl:otherwise>
					</xsl:choose>
					</td>
					
					<!-- Forma de Pago -->
					<td>
                    	<xsl:value-of select="CONDICIONES/FORMAPAGO"/>
					</td>
                    <!-- Plazos de Pago -->
					<td>
                    	<xsl:value-of select="CONDICIONES/PLAZOPAGO"/>
					</td>
					<!-- Plazo de entrega -->
					<td>
						<strong><xsl:value-of select="CONDICIONES/PLAZOENTREGA"/></strong>
					</td>
					<td>
						<strong><xsl:value-of select="CONDICIONES/PLAZOENVIO"/></strong>
					</td>
 					<td>&nbsp;</td>
				</tr>
			</xsl:for-each>
        </xsl:when>
		<xsl:otherwise>
			<tr>
				<td class="textCenter">
					<xsl:attribute name="colspan">
						<xsl:choose>
						<xsl:when test="//PROVEEDORES/CDC">12</xsl:when>
						<xsl:otherwise>9</xsl:otherwise>
						</xsl:choose>
					</xsl:attribute>
					<strong><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedores_sin_resultados']/node()"/></strong>
				</td>
			</tr>
		</xsl:otherwise>
		</xsl:choose>
		</tbody>
		<tfoot class="rodape_tabela">
			<tr>
				<td>
					<xsl:attribute name="colspan">
						<xsl:choose>
						<xsl:when test="//PROVEEDORES/CDC">12</xsl:when>
						<xsl:otherwise>9</xsl:otherwise>
						</xsl:choose>
					</xsl:attribute>
					&nbsp;
				</td>
			</tr>
		</tfoot>
		</table>
        </div>
		<br /><br />
	</xsl:otherwise>
</xsl:choose>
</body>
</html>
</xsl:template>
</xsl:stylesheet>
