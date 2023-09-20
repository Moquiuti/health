<?xml version="1.0" encoding="iso-8859-1"?>
<!--
    Mostrar documentos de producto. Creado a partir de PRODocs.
 	Ultima revision: ET 9mar22 17:30 PROPack2022_090322.js
 +-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:import href="http://www.newco.dev.br/General/General.xsl"/>
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="lang" select="@lang"/>
<xsl:template match="/Pack">

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

	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->

	<meta http-equiv="Cache-Control" Content="no-cache"/>
	
	<title><xsl:value-of select="/Pack/PRODUCTO/EMP_NOMBRE" disable-output-escaping="yes"/>:&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Contenido_pack']/node()"/></title>

	<!--	11ene22 nuevos estilos -->
	<!--<link rel="stylesheet" href="http://www.newco.dev.br/General/basicMVM2022.css"/>-->
	<link href='http://fonts.googleapis.com/css?family=Roboto' rel='stylesheet'/>
	<!--	11ene22 nuevos estilos -->

	<script src="http://www.newco.dev.br/General/jquery-3.6.0.js"></script>	
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic2022_010822.js"></script>
	<!--<script type="text/javascript" src="http://www.newco.dev.br/General/jquery-1.8.3.min.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>-->
	<script type="text/javascript" src="http://www.newco.dev.br/Administracion/Mantenimiento/Productos/PROPack2022_090322.js"></script>
</head>

<body onload="javascript:onloadEvents();">
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
			<xsl:apply-templates select="PRODUCTO"/>
		</xsl:otherwise>
	</xsl:choose>
</body>
</html>
</xsl:template>

<!--
 |  Templates
 +-->

<xsl:template match="PRODUCTO">
	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:choose>
		<xsl:when test="/Pack/LANG"><xsl:value-of select="/Pack/LANG"/></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<div class="ZonaTituloPagina">
		<!--<p class="Path">&nbsp;</p>-->
		<p class="TituloPagina">
			<xsl:value-of select="EMP_NOMBRE" disable-output-escaping="yes"/>:&nbsp;<xsl:value-of select="PRO_REFERENCIA" disable-output-escaping="yes"/>&nbsp;<xsl:value-of select="PRO_NOMBRE" disable-output-escaping="yes"/>. 
			<xsl:if test="RES_ACCION!=''">
				&nbsp;<xsl:value-of select="RES_ACCION" disable-output-escaping="yes"/>
			</xsl:if>
			<span class="CompletarTitulo">
			<xsl:if test="/Pack/PRODUCTO/MVM or /Pack/PRODUCTO/MVMB">
				<a class="btnNormal" href="javascript:window.print();" style="text-decoration:none;" title="Imprimir">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='imprimir']/node()"/>
				</a>
			</xsl:if>
			</span>
		</p>
	</div>
	<br/>

	<!--	Pestañas y Titulo de la página		-->
	<xsl:if test="MOSTRARPESTANNAS">
 	<div class="divLeft marginTop20">
		<ul class="pestannas w100">
			<li>
				<a id="pes_Ficha" class="MenuLic"><xsl:value-of select="document($doc)/translation/texts/item[@name='Ficha_de_producto']/node()"/></a>
			</li>
			<li>
				<a id="pes_Tarifas" class="MenuLic"><xsl:value-of select="document($doc)/translation/texts/item[@name='tarifas']/node()"/></a>
			</li>
			<li>
				<a id="pes_Documentos" class="MenuLic"><xsl:value-of select="document($doc)/translation/texts/item[@name='documentos']/node()"/></a>
			</li>
			<li>
				<a id="pes_Pack" class="MenuLic"><xsl:value-of select="document($doc)/translation/texts/item[@name='Contenido_pack']/node()"/></a>
			</li>
			<li>
				<a id="pes_Empaquetamiento" class="MenuLic"><xsl:value-of select="document($doc)/translation/texts/item[@name='empaquetamientos']/node()"/></a>
			</li>
		</ul>
	</div>
	</xsl:if>

	<div class="divLeft marginTop50">

    <!--si usuario observador no puede añadir nuevos documentos-->
    <!--<xsl:if test="(/Pack/PRODUCTO/MVM or /Pack/PRODUCTO/MVMB or /Pack/PRODUCTO/USUARIO_CDC) and not(/Pack/PRODUCTO/OBSERVADOR)">-->
	<form name="IncluirProductos" method="post" action="http://www.newco.dev.br/Administracion/Mantenimiento/Productos/PROPack2022.xsql">
	<input type="hidden" name="PARAMETROS" value=""/>
	<input type="hidden" name="ACCION" value=""/>
	<input type="hidden" name="PRO_ID" value="{/Pack/PRODUCTO/PRO_ID}"/>
    <xsl:if test="/Pack/PRODUCTO/INCLUIRPRODUCTOS">
	<!--tabla imagenes y documentos-->
		<table cellspacing="6px" cellpadding="6px">
        	<tr class="sinLinea">
        	  <!--documentos-->
        	  <td class="diez">
		  		&nbsp;
			  </td>
        	  <td class="labelRight w200px">
            		<span class="text"><xsl:value-of select="document($doc)/translation/texts/item[@name='referencia_proveedor']/node()"/>:&nbsp;</span>
        	  </td>
        	  <td class="textLeft w400px">
 					<xsl:call-template name="desplegable">
						<xsl:with-param name="path" select="/Pack/PRODUCTO/FPRODUCTOSPROVEEDOR/field"/>
						<xsl:with-param name="claSel">w400px</xsl:with-param>
					</xsl:call-template>
        	  </td>
        	  <td class="labelRight w80px">
            		<span class="text"><xsl:value-of select="document($doc)/translation/texts/item[@name='cantidad']/node()"/>:&nbsp;</span>
        	  </td>
        	  <td class="textLeft w120px">
            		<input type="text" class="campopesquisa w100px" name="CANTIDAD" max-length="10" value=""/>
        	  </td>
        	  <td class="textLeft w80px">
          		<a class="btnDestacado" href="javascript:IncluirProducto();">
             		<xsl:value-of select="document($doc)/translation/texts/item[@name='insertar']/node()"/>
          		</a>
        	  </td>
        	  <td>&nbsp;</td>
        	</tr>
    	   </table><!--fin de tabla doc-->
    	</xsl:if><!--fin if si es mvm-->
		</form>
		<br/>
		<br/>
		<form name="frmProductos">
			<xsl:if test="/Pack/PRODUCTO/PRODUCTOS_EN_PACK">
				<xsl:call-template name="productos_en_pack">
					<xsl:with-param name="doc" select="$doc"/>
					<xsl:with-param name="path" select="/Pack/PRODUCTO/PRODUCTOS_EN_PACK"/>
				</xsl:call-template>
    		</xsl:if>
    	</form>

		<!--mensajes js -->
		<form name="MensajeJS">
			<input type="hidden" name="ERROR_SIN_DEFINIR" value="{document($doc)/translation/texts/item[@name='error_sin_definir']/node()}"/>
			<input type="hidden" name="FALTA_REFERENCIA" value="{document($doc)/translation/texts/item[@name='falta_referencia']/node()}"/>
			<input type="hidden" name="CANTIDAD_OBLIGATORIA" value="{document($doc)/translation/texts/item[@name='cantidad_obli']/node()}"/>
		</form>
		<!--fin de mensajes js -->
	</div><!--fin de divCenter50-->
</xsl:template>

<xsl:template name="productos_en_pack">
	<xsl:param name="path" />
	<xsl:param name="doc" />
	<xsl:if test="$path/PRODUCTO">
		<div class="tabela tabela_redonda">
		<table cellspacing="6px" cellpadding="6px">
			<thead class="cabecalho_tabela">
        	<input type="hidden" name="ID_EMPRESA" value="{/Pack/PRODUCTO/EMP_ID}"/> 
			<!--nombres columnas-->
			<tr class="subTituloTabla">
				<th class="w1px">&nbsp;</th>
				<th class="w150px textLeft">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='referencia']/node()"/></th>
				<th class="textLeft">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='nombre']/node()"/></th>
				<th class="w120px"><xsl:value-of select="document($doc)/translation/texts/item[@name='unidad_basica']/node()"/></th>
				<th class="w120px"><xsl:value-of select="document($doc)/translation/texts/item[@name='ud_lote']/node()"/></th>
				<th class="w120px"><xsl:value-of select="document($doc)/translation/texts/item[@name='cantidad']/node()"/></th>
				<th class="w120px"><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha']/node()"/></th>
				<th class="w50px"><xsl:value-of select="document($doc)/translation/texts/item[@name='incluir_en_licitacion']/node()"/></th>
				<th class="w200px">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='copiar_desde_producto']/node()"/>&nbsp;&nbsp;
					<a class="btnDestacadoPeq" href="javascript:btnGuardar();" style="text-decoration:none;" title="Guardar">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='guardar']/node()"/>
					</a>
				</th>
				<xsl:choose>
				<xsl:when test="/Pack/PRODUCTO/INCLUIRPRODUCTOS">
					<th class="uno"><xsl:value-of select="document($doc)/translation/texts/item[@name='eliminar']/node()"/></th>
				</xsl:when>
				<xsl:otherwise>
					<th class="w1px">&nbsp;</th>
				</xsl:otherwise>
				</xsl:choose>
				<th class="w1px">&nbsp;</th>
        	</tr>
			</thead>
			<tbody class="corpo_tabela">
			<xsl:for-each select="$path/PRODUCTO">
				<tr class="con_hover">
					<td class="color_status">
						<xsl:value-of select="CONTADOR"/>
					</td>
					<td style="text-align:left;">
						&nbsp;<xsl:value-of select="PRO_REFERENCIA"/>
					</td>
					<td style="text-align:left;">
						&nbsp;<xsl:value-of select="PRO_NOMBRE"/>
					</td>
					<td>
						<xsl:value-of select="PRO_UNIDADBASICA"/>
					</td>
					<td>
						<xsl:value-of select="PRO_UNIDADESPORLOTE"/>
					</td>
					<td>
						<xsl:value-of select="PRO_PP_CANTIDAD"/>
					</td>
					<td>
						<xsl:value-of select="PRO_PP_FECHA"/>
					</td>
					<td>
						<input type="checkbox" class="muypeq chkIncluir" name="chk_INCLUIR_{PRO_ID}" id="chk_INCLUIR_{PRO_ID}" onchange="javascript:chkIncluirChange({PRO_ID});">
							<xsl:choose>
							<xsl:when test="PRO_PP_INCLUIRENOFERTAS='S'">
								<xsl:attribute name="checked">checked</xsl:attribute>
							</xsl:when>
							<xsl:otherwise>
								<xsl:attribute name="unchecked">unchecked</xsl:attribute>
							</xsl:otherwise>
        					</xsl:choose>
						</input>
						<input type="hidden" name="INCLUIR_{PRO_ID}_ORIG" id="INCLUIR_{PRO_ID}_ORIG" value="{PRO_PP_INCLUIRENOFERTAS}"/>
					</td>
					<td>
						<xsl:choose>
						<xsl:when test="PRO_PP_INCLUIRENOFERTAS!='S'">
							<xsl:call-template name="desplegable">
								<xsl:with-param name="path" select="/Pack/PRODUCTO/PRODUCTOS_EN_PACK/REFERENCIAS/field"/>
								<xsl:with-param name="nombre">ASOCIAR_<xsl:value-of select="PRO_ID"/></xsl:with-param>
								<xsl:with-param name="id">ASOCIAR_<xsl:value-of select="PRO_ID"/></xsl:with-param>
								<xsl:with-param name="defecto"><xsl:value-of select="PRO_PP_IDPRODUCTO_COPIAROFERTA"/></xsl:with-param>
							</xsl:call-template>
						</xsl:when>
						<xsl:otherwise>
							<xsl:call-template name="desplegable">
								<xsl:with-param name="path" select="/Pack/PRODUCTO/PRODUCTOS_EN_PACK/REFERENCIAS/field"/>
								<xsl:with-param name="nombre">ASOCIAR_<xsl:value-of select="PRO_ID"/></xsl:with-param>
								<xsl:with-param name="id">ASOCIAR_<xsl:value-of select="PRO_ID"/></xsl:with-param>
								<xsl:with-param name="defecto"><xsl:value-of select="PRO_PP_IDPRODUCTO_COPIAROFERTA"/></xsl:with-param>
								<xsl:with-param name="deshabilitado">S</xsl:with-param>
								<xsl:with-param name="style">display:none</xsl:with-param>
							</xsl:call-template>
						</xsl:otherwise>
        				</xsl:choose>
						<input type="hidden" name="ASOCIAR_{PRO_ID}_ORIG" id="ASOCIAR_{PRO_ID}_ORIG" value="{PRO_PP_IDPRODUCTO_COPIAROFERTA}"/>
					</td>
					<td>
						<xsl:if test="(/Pack/PRODUCTO/INCLUIRPRODUCTOS) and not(/Pack/PRODUCTO/OBSERVADOR)">
							<a>
								<xsl:attribute name="href">javascript:QuitarProducto('<xsl:value-of select="PRO_ID"/>');</xsl:attribute>
								<img src="http://www.newco.dev.br/images/2022/icones/del.svg"/>
							</a>
						</xsl:if>
					</td>
					<td>&nbsp;</td>
				</tr>
			</xsl:for-each>
			</tbody>
			<tfoot class="rodape_tabela">
				<tr><td colspan="12">&nbsp;</td></tr>
			</tfoot>
		</table>
		</div>
	</xsl:if>
</xsl:template>		

<!--fin de documentos-->
</xsl:stylesheet>
