<?xml version="1.0" encoding="iso-8859-1"?>
<!--
    Mostrar documentos de producto. Creado a partir de PRODocs.
 	Ultima revision: ET 4nov20 15:30 PROPack_041120.js
 +-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:import href="http://www.newco.dev.br/General/General.xsl"/>
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="lang" select="@lang"/>
<xsl:template match="/Pack">

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
	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery-1.8.3.min.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/Administracion/Mantenimiento/Productos/PROPack_041120.js"></script>
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


	<!--	Pestañas y Titulo de la página		-->
	<xsl:if test="MOSTRARPESTANNAS">
 	<div class="divLeft" style="background-color:white;">
		<ul class="pestannas" style="position:relative;width:600px;">
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
		</ul>
	</div>
	</xsl:if>

	<div class="ZonaTituloPagina">
		<p class="Path"><xsl:value-of select="document($doc)/translation/texts/item[@name='Inicio']/node()"/>&nbsp;/&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/>&nbsp;/<span class="FinPath"><xsl:value-of select="document($doc)/translation/texts/item[@name='Contenido_pack']/node()"/>&nbsp;</span>
			<xsl:if test="MVM or MVMB or ADMIN">
				<span class="CompletarTitulo">
					<span class="amarillo">EMP_ID:&nbsp;<xsl:value-of select="EMP_ID"/></span>
				</span>
			</xsl:if>
		</p>
		<p class="TituloPagina">
			<xsl:value-of select="EMP_NOMBRE" disable-output-escaping="yes"/>:&nbsp;<xsl:value-of select="PRO_NOMBRE" disable-output-escaping="yes"/>. 
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


	<div class="divLeft">

    <!--si usuario observador no puede añadir nuevos documentos-->
    <!--<xsl:if test="(/Pack/PRODUCTO/MVM or /Pack/PRODUCTO/MVMB or /Pack/PRODUCTO/USUARIO_CDC) and not(/Pack/PRODUCTO/OBSERVADOR)">-->
	<form name="IncluirProductos" method="post" action="http://www.newco.dev.br/Administracion/Mantenimiento/Productos/PROPack.xsql">
	<input type="hidden" name="PARAMETROS" value=""/>
	<input type="hidden" name="ACCION" value=""/>
	<input type="hidden" name="PRO_ID" value="{/Pack/PRODUCTO/PRO_ID}"/>
    <xsl:if test="/Pack/PRODUCTO/INCLUIRPRODUCTOS">
			<!--tabla imagenes y documentos-->
     <!-- <table class="infoTableAma documentos" border="0">-->
      <table class="buscador documentos" border="0">
		
        <tr class="sinLinea">
          <!--documentos-->
          <td class="diez">
		  	&nbsp;
		  </td>
          <td class="labelRight" style="width:200px;">
            	<span class="text"><xsl:value-of select="document($doc)/translation/texts/item[@name='referencia_proveedor']/node()"/>:&nbsp;</span>
          </td>
          <td class="textLeft" style="width:400px;">
            	<!--<input type="text" name="REFPROVEEDOR" size="30" value=""/>-->
 				<xsl:call-template name="desplegable">
					<xsl:with-param name="path" select="/Pack/PRODUCTO/FPRODUCTOSPROVEEDOR/field"/>
					<xsl:with-param name="style">width:400px;</xsl:with-param>
				</xsl:call-template>
          </td>
          <td class="labelRight" style="width:150px;">
            	<span class="text"><xsl:value-of select="document($doc)/translation/texts/item[@name='cantidad']/node()"/>:&nbsp;</span>
          </td>
          <td class="textLeft" style="width:150px;">
            	<input type="text" name="CANTIDAD" size="30" value=""/>
          </td>
          <td style="width:200px;">
          	<a class="btnDestacado" href="javascript:IncluirProducto();">
             	<xsl:value-of select="document($doc)/translation/texts/item[@name='insertar']/node()"/>
          	</a>
          </td>
          <td class="diez">
          </td>
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
		<table class="buscador documentos">
        	<input type="hidden" name="ID_EMPRESA" value="{/Pack/PRODUCTO/EMP_ID}"/> 
				<tr class="sinLinea"><td colspan="10">&nbsp;</td></tr>
			  <!--nombres columnas-->
			  <tr class="subTituloTabla">
				<td class="uno"><xsl:value-of select="document($doc)/translation/texts/item[@name='contador']/node()"/></td>
				<td class="diez" style="text-align:left;">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='referencia']/node()"/></td>
				<td class="cuarenta" style="text-align:left;">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='nombre']/node()"/></td>
            	<td class="diez"><xsl:value-of select="document($doc)/translation/texts/item[@name='unidad_basica']/node()"/></td>
            	<td class="cinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='ud_lote']/node()"/></td>
            	<td class="cinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='cantidad']/node()"/></td>
            	<td class="cinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha']/node()"/></td>
            	<td class="tres"><xsl:value-of select="document($doc)/translation/texts/item[@name='incluir_en_licitacion']/node()"/></td>
            	<td class="veinte">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='copiar_desde_producto']/node()"/>&nbsp;&nbsp;
					<a class="btnDestacadoPeq" href="javascript:btnGuardar();" style="text-decoration:none;" title="Guardar">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='guardar']/node()"/>
					</a>
				</td>
				<xsl:choose>
				<xsl:when test="/Pack/PRODUCTO/INCLUIRPRODUCTOS">
					<td class="uno"><xsl:value-of select="document($doc)/translation/texts/item[@name='eliminar']/node()"/></td>
				</xsl:when>
				<xsl:otherwise>
					<td class="uno">&nbsp;</td>
				</xsl:otherwise>
        		</xsl:choose>
        	</tr>

			<xsl:for-each select="$path/PRODUCTO">
				<tr>
					<td>
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
							<a class="btnNormal rojo">
								<xsl:attribute name="href">javascript:QuitarProducto('<xsl:value-of select="PRO_ID"/>');</xsl:attribute>
								X
							</a>
						</xsl:if>
					</td>
				</tr>
			</xsl:for-each>
		</table>
	</xsl:if>
</xsl:template>		

<!--fin de documentos-->
</xsl:stylesheet>
