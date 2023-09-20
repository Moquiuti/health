<?xml version="1.0" encoding="iso-8859-1"?>
<!--
	Buscador de usuarios. Permite recopilar emails para comunicacion de novedades.
	Ultima revision: ET 16may22 11:32 BuscadorUsuarios2022_220322.js
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
		<xsl:value-of select="/BuscadorCentros/LANG"/>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<title><xsl:value-of select="document($doc)/translation/texts/item[@name='listado_usuarios']/node()"/></title>

	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->

	<script src="http://www.newco.dev.br/General/jquery-3.6.0.js"></script>	
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic2022_010822.js"></script>
	<!--<script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>-->
	<script type="text/javascript" src="http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/BuscadorUsuarios2022_220322.js"></script>

</head>
<body>
	<!--idioma-->
	<xsl:variable name="lang">
	<xsl:choose>
		<xsl:when test="/Correos/LANG"><xsl:value-of select="/Correos/LANG"/></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
	</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<form method="post" action="BuscadorUsuarios2022.xsql">
		<input type="hidden" name="LISTAEMPRESAS"/>
		<input type="hidden" id="PAGINA" name="PAGINA" value="{/Correos/USUARIOS/FILTROS/PAGINA}" />
		<input type="hidden" id="IDPAIS" name="IDPAIS" value="{/Correos/USUARIOS/FILTROS/IDPAIS}" />

		<!--	Titulo de la página		-->
		<div class="ZonaTituloPagina">
			<p class="TituloPagina">
        	  <xsl:value-of select="document($doc)/translation/texts/item[@name='listado_usuarios']/node()"/>&nbsp;<span class="fuentePeq">(<xsl:value-of select="document($doc)/translation/texts/item[@name='usuarios']/node()"/>: <xsl:value-of select="/Correos/USUARIOS/TOTAL"/>)</span>
			 <!-- <span class="CompletarTitulo">
			  	Botones
			  </span>	-->
			</p>
		</div>
		<br/>
		<br/>
		<br/>
		<br/>
		<div class="divLeft">
		<table cellspacing="6px" cellpadding="6px">
			<tr class="filtros">
				<th class="w40px">&nbsp;</th>
                <th class="textLeft w210px">
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='empresa']/node()"/>/
					<xsl:value-of select="document($doc)/translation/texts/item[@name='centro']/node()"/>/
					<xsl:value-of select="document($doc)/translation/texts/item[@name='usuario']/node()"/>:</label><br/>
					<input type="text" class="campopesquisa w200px" id="US_NOMBRE" name="US_NOMBRE" maxlength="20" value="{/Correos/USUARIOS/FILTROS/NOMBRE}"/>
				</th>
                <th class="textLeft w160px">
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='rol']/node()"/>:</label><br/>
                    <xsl:call-template name="desplegable"> 
					<xsl:with-param name="id" value="US_TIPO_EMPRESA"/>
					<xsl:with-param name="path" select="/Correos/USUARIOS/FILTROS/TIPOEMPRESA/field" />
					<xsl:with-param name="claSel">w150px</xsl:with-param>
                    </xsl:call-template>
                </th>
                <th class="textLeft w100px">
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='admin']/node()"/>:</label><br/>
                    <xsl:call-template name="desplegable"> 
					<xsl:with-param name="id" value="US_DERECHOS"/>
					<xsl:with-param name="path" select="/Correos/USUARIOS/FILTROS/DERECHOS/field" />
					<xsl:with-param name="claSel">w90px</xsl:with-param>
                    </xsl:call-template>
                </th>
                <th class="textLeft w100px">
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='cdc']/node()"/>:</label><br/>
                    <xsl:call-template name="desplegable"> 
					<xsl:with-param name="id" value="US_CDC"/>
					<xsl:with-param name="path" select="/Correos/USUARIOS/FILTROS/CDC/field" />
					<xsl:with-param name="claSel">w90px</xsl:with-param>
					</xsl:call-template>
                </th>
                <th class="textLeft w100px">
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='eis']/node()"/>:</label><br/>
                    <xsl:call-template name="desplegable"> 
					<xsl:with-param name="id" value="US_DERECHOSEIS"/>
					<xsl:with-param name="path" select="/Correos/USUARIOS/FILTROS/DERECHOSEIS/field" />
					<xsl:with-param name="claSel">w90px</xsl:with-param>
                    </xsl:call-template>
                </th>
                <!--<th>
                    <xsl:call-template name="desplegable"> 
					<xsl:with-param name="id" value="US_NAVEGAR_PROVEE"/>
					<xsl:with-param name="path" select="/Correos/USUARIOS/FILTROS/NAVEGARPROVEEDORES/field" />
					<xsl:with-param name="claSel">w90px</xsl:with-param>
                    </xsl:call-template>
                </th>
                <th>
                    <xsl:call-template name="desplegable"> 
					<xsl:with-param name="id" value="US_CONTROL_ACCESOS"/>
					<xsl:with-param name="path" select="/Correos/USUARIOS/FILTROS/CONTROLACCESOS/field" />
					<xsl:with-param name="claSel">w90px</xsl:with-param>
                    </xsl:call-template>
                </th>
                <th><!- -usuario_controlado- ->
                    <xsl:call-template name="desplegable"> 
					<xsl:with-param name="id" value="US_PEDIDOS_CONTROLADOS"/>
					<xsl:with-param name="path" select="/Correos/USUARIOS/FILTROS/PEDIDOSCONTROLADOS/field" />
 					<xsl:with-param name="claSel">w90px</xsl:with-param>
                   </xsl:call-template>
                </th>
                <th><!- -avisos catalogo- ->
                    <xsl:call-template name="desplegable"> 
					<xsl:with-param name="id" value="US_AVISOS_CATALOGOS"/>
					<xsl:with-param name="path" select="/Correos/USUARIOS/FILTROS/AVISOSCATALOGOS/field" />
					<xsl:with-param name="claSel">w90px</xsl:with-param>
                    </xsl:call-template>
                </th>
                <th>
                    <xsl:call-template name="desplegable"> 
					<xsl:with-param name="id" value="US_VER_OFERTAS"/>
					<xsl:with-param name="path" select="/Correos/USUARIOS/FILTROS/VEROFERTAS/field" />
					<xsl:with-param name="claSel">w90px</xsl:with-param>
                    </xsl:call-template>
                </th>
                <th>
                    <xsl:call-template name="desplegable"> 
					<xsl:with-param name="id" value="US_BLOQUEAR_OCULTOS"/>
					<xsl:with-param name="path" select="/Correos/USUARIOS/FILTROS/BLOQUEAROCULTOS/field" />
					<xsl:with-param name="claSel">w90px</xsl:with-param>
                    </xsl:call-template>
                </th>-->
                <th class="textLeft w150px">
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='lineas_por_pagina']/node()"/>:</label><br/>
					<xsl:call-template name="desplegable">
						<xsl:with-param name="id" value="LINEASPORPAGINA"/>
						<xsl:with-param name="path" select="/Correos/USUARIOS/FILTROS/LINEASPORPAGINA/field"/>
 					<xsl:with-param name="claSel">w140px</xsl:with-param>
					</xsl:call-template>
				</th>
                <th class="textLeft w100px">
					<br/>
                    <a class="btnDestacado" href="javascript:Enviar();"><xsl:value-of select="document($doc)/translation/texts/item[@name='buscar']/node()"/></a>
				</th>
                <th class="textLeft w100px">
					<xsl:if test="/Correos/USUARIOS/ANTERIOR">
						<br/>
						<a class="btnNormal" href="javascript:PaginaAnterior();"><xsl:value-of select="document($doc)/translation/texts/item[@name='anterior']/node()"/></a>
					</xsl:if>
				</th>
                <th class="textLeft w100px">
					<xsl:if test="/Correos/USUARIOS/SIGUIENTE">
						<br/>
						<a class="btnNormal" href="javascript:PaginaSiguiente();"><xsl:value-of select="document($doc)/translation/texts/item[@name='siguiente']/node()"/></a>
					</xsl:if>
				</th>
				<th>&nbsp;</th>
			</tr>	
			</table>
			<br/>
		</div>

		<div class="tabela tabela_redonda">
		<table cellspacing="6px" cellpadding="6px">
			<thead class="cabecalho_tabela">
				<tr>
					<th class="w1px" colspan="2"><a href="javascript:SeleccionarTodas();"><xsl:value-of select="document($doc)/translation/texts/item[@name='todos']/node()"/></a></th>
					<th class="textLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='empresa']/node()"/></th>
					<th class="textLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='centro']/node()"/></th>
					<th class="textLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='usuario']/node()"/></th>
					<th class="w50px"><xsl:value-of select="document($doc)/translation/texts/item[@name='telefono']/node()"/></th>
					<th class="w50px"><xsl:value-of select="document($doc)/translation/texts/item[@name='rol']/node()"/></th>
					<th class="w50px"><xsl:value-of select="document($doc)/translation/texts/item[@name='admin']/node()"/></th>
					<th class="w50px"><xsl:value-of select="document($doc)/translation/texts/item[@name='cdc']/node()"/></th>
					<th class="w50px"><xsl:value-of select="document($doc)/translation/texts/item[@name='eis']/node()"/></th>
					<th class="w50px"><xsl:value-of select="document($doc)/translation/texts/item[@name='control_acessos']/node()"/>&nbsp;</th>
					<th class="w50px"><xsl:value-of select="document($doc)/translation/texts/item[@name='usuario_controlado']/node()"/>&nbsp;</th>
				</tr>
			</thead>
		<xsl:choose>
		<xsl:when test="/Correos/USUARIOS/USUARIO">
			<tbody class="corpo_tabela">
        	  <xsl:for-each select="/Correos/USUARIOS/USUARIO">
				<tr class="conhover">
					<td class="color_status"><xsl:value-of select="CONTADOR"/></td>
                	<td>
						<input class="muypeq" type="checkbox" name="CHK_{ID}" onchange="javascript:PulsadoCheck();"/>
						<input type="hidden" name="EMAIL_{ID}" value="{EMAIL}"/>
						<input type="hidden" name="NOMBRE_{ID}" value="{NOMBRE}"/>
					</td>
                	<td class="textLeft">
                            <a href="javascript:CambiarEmpresa({IDEMPRESA});">
                                <xsl:choose>
                                    <xsl:when test="EMPRESA_NOMBRECORTO != ''"><xsl:value-of select="EMPRESA_NOMBRECORTO"/></xsl:when>
                                    <xsl:otherwise><xsl:value-of select="EMPRESA"/></xsl:otherwise>
                                </xsl:choose>
                            </a>
                        </td>
                	<td class="textLeft">
                            <a href="javascript:CambiarCentro({IDEMPRESA},{IDCENTRO});">
                                 <xsl:choose>
                                    <xsl:when test="CENTRO_NOMBRECORTO != ''"><xsl:value-of select="CENTRO_NOMBRECORTO"/></xsl:when>
                                    <xsl:otherwise><xsl:value-of select="CENTRO"/></xsl:otherwise>
                                </xsl:choose>
                            </a>
                        </td>
                	<td class="textLeft">
                    	<a href="javascript:Usuario({ID},{IDEMPRESA},{IDCENTRO});"><xsl:value-of select="NOMBRE"/></a>
                    </td>
                	<td><xsl:value-of select="TELEFONO"/>&nbsp;</td>
                    <td><xsl:value-of select="ROL"/></td>
               		<td><xsl:value-of select="DERECHOS"/></td>
               		<td><xsl:value-of select="CDC"/></td>
               		<td><xsl:value-of select="DERECHOSEIS"/></td>
                    <td><xsl:value-of select="CONTROLACCESOS"/></td>
                    <td><xsl:value-of select="USUARIOCONTROL"/></td>
				</tr>
			  </xsl:for-each>	   
              </tbody> 
			<tr class="sinLinea">
			<td colspan="17">
			&nbsp;
			</td>
			</tr>
            <tr class="sinLinea">
              <td colspan="5">&nbsp;</td>
              <td colspan="2">
                    <a class="btnDestacado" href="javascript:history.go(-1);" title="Volver al paso anterior"><xsl:value-of select="document($doc)/translation/texts/item[@name='volver']/node()"/></a>
			  </td>
              <td colspan="10">&nbsp;</td>
			</tr>
			<tr class="sinLinea">
				<td colspan="17">
				<textarea name="ListaDirecciones" rows="20" cols="150"/>
				</td>
			</tr>
			<tfoot class="rodape_tabela">
				<tr><td colspan="17">&nbsp;</td></tr>
            </tfoot>
	</xsl:when>
	<xsl:otherwise>
		<tr><td colspan="17"><xsl:value-of select="document($doc)/translation/texts/item[@name='no_se_han_encontrado_resultados']/node()"/></td></tr>
	</xsl:otherwise>
	</xsl:choose>
		</table>
		<br/>
		<br/>
		<br/>
		<br/>
		<br/>
        </div>   
		</form>
      </body>
    </html>
</xsl:template>  
  
  

</xsl:stylesheet>

