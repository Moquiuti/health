<?xml version="1.0" encoding="iso-8859-1"?>
<!--
	Ficha normal de empresa. Nuevo disenno 2022.
	Ultima revision: ET 21feb22 18:42
+-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:import href="http://www.newco.dev.br/General/General.xsl"/>
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="lang" select="@lang"/>
<xsl:template match="/Ficha">

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

	<!--	11ene22 nuevos estilos -->
	<!--<link rel="stylesheet" href="http://www.newco.dev.br/General/basicMVM2022.css"/>-->
	<link href='http://fonts.googleapis.com/css?family=Roboto' rel='stylesheet'/>
	<!--	11ene22 nuevos estilos -->

	<script src="http://www.newco.dev.br/General/jquery-3.6.0.js"></script>	
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic2022_010822.js"></script>

	<meta http-equiv="Cache-Control" Content="no-cache"/>

	<title><xsl:value-of select="/Ficha/EMPRESA/EMP_NOMBRECORTOPUBLICO" disable-output-escaping="yes"/></title>
<!--
	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery-1.8.3.min.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>-->

  <!--codigo etiquetas-->
	<script type="text/javascript" src="http://www.newco.dev.br/General/Tabla-popup.150715.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/Gestion/Comercial/etiquetas.js"></script>

	<link href="http://www.newco.dev.br/General/Tabla-popup.150715.css" rel="stylesheet" type="text/css"/>
  <!--fin codigo etiquetas-->

  <script type="text/javascript">
    <!-- Variables y Strings JS para las etiquetas -->
		var IDRegistro = '<xsl:value-of select="EMPRESA/EMP_ID"/>';
		var IDTipo = 'EMP';
		var str_NuevaEtiquetaGuardada	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='nueva_etiqueta_guardada']/node()"/>';
		var str_NuevaEtiquetaError		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='nueva_etiqueta_error']/node()"/>';
		var str_autor			= '<xsl:value-of select="document($doc)/translation/texts/item[@name='autor']/node()"/>';
		var str_fecha			= '<xsl:value-of select="document($doc)/translation/texts/item[@name='fecha']/node()"/>';
		var str_etiqueta	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='etiqueta']/node()"/>';
		var str_borrar		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='borrar']/node()"/>';
		<!-- FIN Variables y Strings JS para las etiquetas -->

		var str_incluir		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='incluir']/node()"/>';
		var str_quitar		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='quitar']/node()"/>';
		var str_errorCambiarSeleccion = '<xsl:value-of select="document($doc)/translation/texts/item[@name='error_cambiar_seleccion']/node()"/>';

		<xsl:text disable-output-escaping="yes">
		<![CDATA[

		function cambiarSeleccion(IDSel, flag){
			var d = new Date();

			jQuery.ajax({
				url:"http://www.newco.dev.br/Gestion/EIS/cambiarSeleccionAJAX.xsql",
				data: "IDSELECCION="+IDSel+"&IDREGISTRO="+IDRegistro+"&_="+d.getTime(),
				type: "GET",
				async: false,
				contentType: "application/xhtml+xml",
				beforeSend:function(){
					null;
				},
				error:function(objeto, quepaso, otroobj){
					alert("objeto:"+objeto);
					alert("otroobj:"+otroobj);
					alert("quepaso:"+quepaso);
				},
				success:function(objeto){
					var data = eval("(" + objeto + ")");

					if(data.Seleccion.estado == 'OK'){
						if(flag){
							jQuery("#SEL_" + IDSel + " td.estadoSel").html("<img src='http://www.newco.dev.br/images/checkCenter.gif'/>");
							jQuery("#SEL_" + IDSel + " td.accionSel").html("<a href='javascript:cambiarSeleccion(" + IDSel + ", false);'>" + str_quitar + "</a>");
						}else{
							jQuery("#SEL_" + IDSel + " td.estadoSel").html("<img src='http://www.newco.dev.br/images/nocheck.gif'/>");
							jQuery("#SEL_" + IDSel + " td.accionSel").html("<a href='javascript:cambiarSeleccion(" + IDSel + ", true);'>" + str_incluir + "</a>");
						}
					}else{
						alert(str_errorCambiarSeleccion);
					}
				}
			});
		}

		]]>
		</xsl:text>
  </script>
</head>

<body>
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
		<xsl:when test="/Ficha/LANG"><xsl:value-of select="/Ficha/LANG"/></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->


	<!--	Titulo de la página		-->
	<div class="ZonaTituloPagina">
		<p class="TituloPagina">
        	<xsl:choose>
        	<xsl:when test="EMP_NOMBRECORTOPUBLICO != ''"><xsl:value-of select="EMP_NOMBRECORTOPUBLICO" disable-output-escaping="yes"/></xsl:when>
        	<xsl:otherwise><xsl:value-of select="substring(EMP_NOMBRE,0,50)" disable-output-escaping="yes"/></xsl:otherwise>
        	</xsl:choose>
			<span class="CompletarTitulo">
			<xsl:if test="MVM or MVMB or ADMIN">
				<a class="btnNormal" style="text-decoration:none;">
					<xsl:attribute name="href">javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPManten.xsql?IDEMPRESA=<xsl:value-of select="EMP_ID"/>&amp;ADMINISTRADORMVM=ADMINISTRADORMVM','Mantenimiento empresa',100,80,0,0);</xsl:attribute>
					<xsl:value-of select="document($doc)/translation/texts/item[@name='modificar']/node()"/>
				</a>
				&nbsp;
				<a class="btnNormal" href="javascript:window.print();" style="text-decoration:none;" title="Imprimir">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='imprimir']/node()"/>
				</a>
			</xsl:if>
			</span>
		</p>
	</div>
	<br/>

	<div class="divLeft space60px">
		<table cellspacing="6px" cellpadding="6px">
		<tbody>
			<tr class="sinLinea">
				<td class="veinte imgCenter" rowspan="10">
					<img src="{URL_LOGOTIPO}" height="80px" width="160px"/>
				</td>
				<td class="labelRight w200px">
          			<xsl:value-of select="document($doc)/translation/texts/item[@name='nombre']/node()"/>:&nbsp; 
				</td>
				<td class="textLeft">
					<strong><xsl:value-of select="EMP_NOMBRE"/><xsl:if test="EMP_ENLACE != 'http://' and EMP_ENLACE != ''">&nbsp;(<a href="{EMP_ENLACE}" target="_blank"><xsl:value-of select="EMP_ENLACE"/></a>)</xsl:if></strong>
				</td>
				<td class="cuatro">&nbsp;</td>
			</tr>
			<tr class="sinLinea">
				<td class="labelRight">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='nif']/node()"/>:&nbsp;
				</td>
				<td class="textLeft">
					<xsl:value-of select="EMP_NIF"/>
				</td>
			</tr>
			<tr class="sinLinea">
				<td class="labelRight">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='tel']/node()"/>:&nbsp;
				</td>
				<td class="textLeft">
					<xsl:value-of select="EMP_TELEFONO"/>
       			</td>
				<td>&nbsp;</td>
			</tr>
			<tr class="sinLinea">
				<td class="labelRight" valign="top">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='direccion']/node()"/>:&nbsp;
				</td>
				<td class="textLeft">
					<xsl:value-of select="EMP_DIRECCION" disable-output-escaping="yes"/>,&nbsp;
					<xsl:value-of select="EMP_CPOSTAL"/><br/>
					<xsl:value-of select="EMP_POBLACION" disable-output-escaping="yes"/>&nbsp;
					(<xsl:value-of select="EMP_PROVINCIA" disable-output-escaping="yes"/>)
				</td>
				<td>&nbsp;</td>
			</tr>

		<tr class="sinLinea">
			<td class="labelRight">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='pedido_minimo']/node()"/>:&nbsp;
			</td>
			<td colspan="2" class="textLeft">
    			<xsl:copy-of select="PEDIDO_MINIMO"/><xsl:if test="PEDIDO_MINIMO_DETALLE != ''">&nbsp;(&nbsp;<xsl:value-of select="PEDIDO_MINIMO_DETALLE"/>)</xsl:if>
			</td>
			<td>&nbsp;</td>
		</tr>
		<tr class="sinLinea">
			<td class="labelRight">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='plazo_entrega']/node()"/>:&nbsp;
			</td>
			<td colspan="2" class="textLeft">
    			<xsl:copy-of select="PLAZO_ENTREGA"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='dias']/node()"/>
			</td>
			<td>&nbsp;</td>
		</tr>
		<tr class="sinLinea">
			<td class="labelRight">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='plazo_envio']/node()"/>:&nbsp;
			</td>
			<td colspan="2" class="textLeft">
    			<xsl:copy-of select="PLAZO_ENVIO"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='dias']/node()"/>
			</td>
			<td>&nbsp;</td>
		</tr>
		<tr class="sinLinea">
			<td class="labelRight">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='forma_pago']/node()"/>:&nbsp;
			</td>
			<td colspan="2" class="textLeft">
    			<xsl:copy-of select="FORMA_PAGO"/>
			</td>
			<td>&nbsp;</td>
		</tr>
		<xsl:if test="EMP_REFERENCIAS != ''">
    	  <tr class="sinLinea">
        	<td class="labelRight">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='descripcion_comercial_corta']/node()"/>:&nbsp;
			</td>
        	<td colspan="2" class="textLeft">
        		<xsl:copy-of select="EMP_REFERENCIAS/node()"/>
        	</td>
        	<td>&nbsp;</td>
    	  </tr>
		</xsl:if>
		</tbody>
		</table>
	</div><!--fin de div con tabla datos empresa-->

    <!--selecciones-->
	<xsl:if test="ROL = 'VENDEDOR'">
		<xsl:if test="SELECCIONESAREASGEOGRAFICAS/SELECCIONES/SELECCION">
			<xsl:apply-templates select="SELECCIONESAREASGEOGRAFICAS/SELECCIONES">
				<xsl:with-param name="doc"><xsl:value-of select="$doc"/></xsl:with-param>
				<xsl:with-param name="titulo"><xsl:value-of select="document($doc)/translation/texts/item[@name='Cobertura_geografica']/node()"/></xsl:with-param>
			</xsl:apply-templates>
		</xsl:if>
		<xsl:if test="SELECCIONESMATERIAL/SELECCIONES/SELECCION">
			<xsl:apply-templates select="SELECCIONESMATERIAL/SELECCIONES">
				<xsl:with-param name="doc"><xsl:value-of select="$doc"/></xsl:with-param>
				<xsl:with-param name="titulo"><xsl:value-of select="document($doc)/translation/texts/item[@name='Categorias_producto']/node()"/></xsl:with-param>
			</xsl:apply-templates>
		</xsl:if>
	</xsl:if>
	<br/>         
	<br/>           
	<br/>         
	<br/>         
	<!--centros-->
	<div class="divLeft textCenter space40px">
		<span class="tituloTabla"><xsl:value-of select="document($doc)/translation/texts/item[@name='centros']/node()"/></span>
		<div class="linha_separacao_cotacao_y"></div>
		<div class="tabela tabela_redonda">
		<table cellspacing="10px" cellpadding="10px" class="w1200px tableCenter">
			<thead class="cabecalho_tabela">
			<tr>
				<th class="w1px">&nbsp;</th>
				<th class="textLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='nombre']/node()"/></th>
				<th class="textLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='provincia']/node()"/></th>
				<th class="textLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='poblacion']/node()"/></th>
				<xsl:if test="ROL = 'COMPRADOR'">
					<th class="textLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='numero_de_camas']/node()"/></th>
					<th class="textLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='quirofanos']/node()"/></th>
				</xsl:if>
				<th>&nbsp;</th>
			</tr>

	        </thead>
    	    <tbody class="corpo_tabela">
			<xsl:for-each select="CENTROS/CENTRO">
			<tr class="conhover">
				<td class="color_status">&nbsp;</td>
				<td class="textLeft">
					<a href="javascript:chFichaCentro({ID});">
						<xsl:value-of select="NOMBRE"/>
					</a>
					<!--9mar23
					<xsl:choose>
					<xsl:when test="(/Ficha/EMPRESA/MVM or /Ficha/EMPRESA/MVMB) and /Ficha/EMPRESA/ADMIN">
						<a href="javascript:FichaCentro({ID});">
							<xsl:value-of select="NOMBRE"/>
						</a>
					</xsl:when>
					<xsl:otherwise>
							<xsl:value-of select="NOMBRE"/>
					</xsl:otherwise>
					</xsl:choose>
					-->
				</td>
				<td class="textLeft"><xsl:value-of select="PROVINCIA"/></td>
				<td class="textLeft"><xsl:value-of select="POBLACION"/></td>
				<xsl:if test="/Ficha/EMPRESA/ROL = 'COMPRADOR'">
					<td style="padding-left:30px;"><xsl:value-of select="CAMAS"/><xsl:if test="CAMAS = ''">-</xsl:if></td>
					<td style="padding-left:30px;"><xsl:value-of select="QUIROFANOS"/><xsl:if test="QUIROFANOS = ''">-</xsl:if></td>
				</xsl:if>
				<td>&nbsp;</td>
			</tr>
			</xsl:for-each>
		</tbody>
		<tfoot class="rodape_tabela"><tr><td colspan="7">&nbsp;</td></tr></tfoot>
		</table>
		</div>
		</div>
		<br/>         
		<br/>           
		<br/>         
		<br/>         

		<!--usuarios, solo si estan informados: no se muestran los de clientes-->
		<xsl:if test="USUARIOS/USUARIO">
		<div class="divLeft textCenter space40px">
			<span class="tituloTabla"><xsl:value-of select="document($doc)/translation/texts/item[@name='usuarios']/node()"/></span>
			<div class="linha_separacao_cotacao_y"></div>
			<div class="tabela tabela_redonda">
			<table cellspacing="10px" cellpadding="10px" class="w1200px tableCenter">
			<thead class="cabecalho_tabela">
			<tr>
				<th class="w1px">&nbsp;</th>
				<th><xsl:value-of select="document($doc)/translation/texts/item[@name='nombre']/node()"/></th>
				<th><xsl:value-of select="document($doc)/translation/texts/item[@name='centro']/node()"/></th>
				<th><xsl:value-of select="document($doc)/translation/texts/item[@name='cargo']/node()"/></th>
				<th><xsl:value-of select="document($doc)/translation/texts/item[@name='email']/node()"/></th>
				<th><xsl:value-of select="document($doc)/translation/texts/item[@name='movil']/node()"/></th>
				<th><xsl:value-of select="document($doc)/translation/texts/item[@name='telefono']/node()"/></th>
				<th><xsl:value-of select="document($doc)/translation/texts/item[@name='Skype']/node()"/></th>
				<th>&nbsp;</th>
			</tr>
			</thead>
   	    	<tbody class="corpo_tabela">
			<xsl:for-each select="USUARIOS/USUARIO">
				<tr class="conhover">
					<td class="color_status">&nbsp;</td>
					<td class="textLeft">
        			  <xsl:choose>
        			  <xsl:when test="(/Ficha/EMPRESA/MVM or /Ficha/EMPRESA/MVMB) and /Ficha/EMPRESA/ADMIN">
          				<a title="Manten Usuario">
            			  <xsl:attribute name="href">javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/USManten.xsql?ID_USUARIO=<xsl:value-of select="ID"/>&amp;EMP_ID=<xsl:value-of select="/Ficha/EMPRESA/EMP_ID"/>','Mantenimiento Usuario',100,80,0,0);</xsl:attribute>
            			  <xsl:value-of select="NOMBRE"/></a>
        			  </xsl:when>
        			  <xsl:otherwise><xsl:value-of select="NOMBRE"/></xsl:otherwise>
        			  </xsl:choose>
        			  &nbsp;
					</td>
					<td class="textLeft">
						<xsl:choose>
						<xsl:when test="(/Ficha/EMPRESA/MVM or /Ficha/EMPRESA/MVMB) and /Ficha/EMPRESA/ADMIN">
							<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/CENDetalle.xsql?ID={IDCENTRO}','Centro',100,80,0,0);">
								<xsl:value-of select="CENTRO"/>
							</a>
						</xsl:when>
						<xsl:otherwise>
								<xsl:value-of select="CENTRO"/>
						</xsl:otherwise>
						</xsl:choose>
					</td>
					<td class="textLeft">
						<xsl:value-of select="TIPO_USUARIO"/>
					</td>
					<td class="textLeft">
						<a>
            				<xsl:attribute name="href">mailto:<xsl:value-of select="US_EMAIL"/></xsl:attribute><xsl:value-of select="US_EMAIL"/>
        				</a>
					</td>
					<td>
						<xsl:value-of select="TELEFONO_MOVIL"/>
					</td>
					<td>
						<xsl:value-of select="TELEFONO"/>
					</td>
					<td>
						<xsl:value-of select="US_SKYPE"/>
					</td>
					<td>&nbsp;</td>
				</tr>
			</xsl:for-each>
			</tbody>
			<tfoot class="rodape_tabela"><tr><td colspan="9">&nbsp;</td></tr></tfoot>
		</table>
		</div>
		</div>
		</xsl:if>

		

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
        <xsl:value-of select="document($doc)/translation/texts/item[@name='nueva_etiqueta']/node()"/>&nbsp;
        <xsl:value-of select="document($doc)/translation/texts/item[@name='para']/node()"/>&nbsp;

	      <xsl:choose>
				<xsl:when test="EMP_NOMBRE_CORTO != ''"><xsl:value-of select="EMP_NOMBRE_CORTO" disable-output-escaping="yes"/></xsl:when>
	      <xsl:otherwise><xsl:value-of select="substring(EMP_NOMBRE,0,50)" disable-output-escaping="yes"/></xsl:otherwise>
	      </xsl:choose>
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
</xsl:template>

<xsl:template  match="SELECCIONES">
    <xsl:param name="doc" />
    <xsl:param name="titulo" />

	<div class="divLeft textCenter space40px">
		<span class="tituloTabla"><xsl:value-of select="$titulo"/>
			<xsl:if test="(/Ficha/EMPRESA/MVM or /Ficha/EMPRESA/MVMB) and /Ficha/EMPRESA/ADMIN">
				&nbsp;<a href="javascript:MostrarSelecciones();" style="text-decoration:none;"><img src="http://www.newco.dev.br/images/tabla.gif"/></a>
			</xsl:if>
		</span>
		<div class="linha_separacao_cotacao_y"></div>
		<div class="tabela tabela_redonda">
		<table cellspacing="10px" cellpadding="10px" class="w1200px tableCenter">
		<thead class="cabecalho_tabela">
		<!--nombres columnas, nombre, cargo-->
		<tr>
			<th class="w1px">&nbsp;</th>
			<th class="textLeft"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='nombre']/node()"/></strong></th>
			<th class="textLeft"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='estado']/node()"/></strong></th>
			<th class="textLeft">&nbsp;</th>
			<th>&nbsp;</th>
		</tr>
	</thead>
   	<tbody class="corpo_tabela">
	<xsl:for-each select="./SELECCION">
		<tr id="SEL_{EIS_SEL_ID}" class="conhover">
			<td class="color_status">&nbsp;</td>
			<td align="left"><xsl:value-of select="EIS_SEL_NOMBRE"/></td>
			<td class="estadoSel">
				<xsl:choose>
				<xsl:when test="NO_INCLUIDO">
					<img src="http://www.newco.dev.br/images/nocheck.gif"/>
				</xsl:when>
				<xsl:otherwise>
					<img src="http://www.newco.dev.br/images/checkCenter.gif"/>
				</xsl:otherwise>
				</xsl:choose>
			</td>
			<td class="accionSel">
				<xsl:if test="/Ficha/EMPRESA/MVM">
				<xsl:choose>
				<xsl:when test="NO_INCLUIDO">
					<a href="javascript:cambiarSeleccion({EIS_SEL_ID}, true);"><xsl:value-of select="document($doc)/translation/texts/item[@name='incluir']/node()"/></a>
				</xsl:when>
				<xsl:otherwise>
					<a href="javascript:cambiarSeleccion({EIS_SEL_ID}, false);"><xsl:value-of select="document($doc)/translation/texts/item[@name='quitar']/node()"/></a>
				</xsl:otherwise>
				</xsl:choose>
				</xsl:if>
			</td>
			<td>&nbsp;</td>
		</tr>
	</xsl:for-each>
	</tbody>
	<tfoot class="rodape_tabela"><tr><td colspan="9">&nbsp;</td></tr></tfoot>
	</table>
	</div>
	</div>
</xsl:template>


</xsl:stylesheet>
