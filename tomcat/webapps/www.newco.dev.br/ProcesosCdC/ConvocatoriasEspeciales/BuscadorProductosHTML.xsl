<?xml version="1.0" encoding="iso-8859-1"?>
<!--
	Convocatorias especiales: mantenimiento de productos
	Ultima revision ET 18set19 12:30
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
		<xsl:when test="/Productos/LANG"><xsl:value-of select="/Productos/LANG" /></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
	</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<title><xsl:value-of select="document($doc)/translation/texts/item[@name='Convocatorias']/node()"/>:&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Productos']/node()"/></title>

	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->

	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>
	<script type="text/javascript">
		var alrt_errorDescargaFichero	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='error_descarga_fichero']/node()"/>';
		
		//	2abr19	Comprueba si est� abierto como pop-up, si no es as�, quita el destacado de los enlaces de ref. producto
		function Inicio()
		{
			if (window.opener)
			{
				console.log("Existe opener");
			}
			else
			{
				jQuery(".refProducto").css('color','black').css('textDecoration','none');
			}
		}

 		//	2oct18	Funciones para paginaci�n del listado
		function Enviar(){
			var form=document.forms[0];
			//console.log("PAGINA:"+document.forms[0].elements['PAGINA'].value);
			
			//if (document.forms[0].elements['FPROCEDIMIENTOS'].checked)
			//	form.action="http://www.newco.dev.br/ProcesosCdC/ConvocatoriasEspeciales/BuscadorProcedimientos.xsql";
			
			SubmitForm(form);
		}

		function Buscar() {document.forms[0].elements['PAGINA'].value=0; Enviar();}
		function PaginaAnterior() {document.forms[0].elements['PAGINA'].value=parseInt(document.forms[0].elements['PAGINA'].value)-1; Enviar();}
		function PaginaSiguiente() {document.forms[0].elements['PAGINA'].value=parseInt(document.forms[0].elements['PAGINA'].value)+1; Enviar();}

		function IncluirEnPaginaPrincipal(Ref)
		{
			try
			{
				console.log('IncluirEnPaginaPrincipal:'+Ref);
				window.opener.IncluirReferencia(Ref);
			}
			catch(err)
			{
			}
		}

		function DescargarExcel(){
			var d = new Date(),
				IDConvocatoria=document.forms[0].elements['FIDCONVOCATORIA'].value,
				IDProveedor=document.forms[0].elements['FIDPROVEEDOR'].value;
			
			jQuery.ajax({
				url:	"http://www.newco.dev.br/ProcesosCdC/ConvocatoriasEspeciales/ProductosExcel.xsql",
				data:	"IDCONVOCATORIA="+IDConvocatoria+"&amp;IDPROVEEDOR="+IDProveedor+"&amp;_="+d.getTime(),
				type:	"GET",
				contentType: "application/xhtml+xml",
				beforeSend: function(){
					null;
				},
				error: function(objeto, quepaso, otroobj){
					alert('error'+quepaso+' '+otroobj+''+objeto);
				},
				success: function(objeto){
					var data = eval("(" + objeto + ")");

					if(data.estado == 'ok')
						window.location='http://www.newco.dev.br/Descargas/'+data.url;
					else
						alert(alrt_errorDescargaFichero);
				}
			});
		}

		function VerProcedimientos()
		{
			var IDConvocatoria=document.forms[0].elements['FIDCONVOCATORIA'].value;
			document.location='http://www.newco.dev.br/ProcesosCdC/ConvocatoriasEspeciales/BuscadorProcedimientos.xsql?FIDCONVOCATORIA='+IDConvocatoria;
		}

	</script>
</head>

<body class="gris" onLoad="javascript:Inicio();">
<xsl:choose>
<xsl:when test="/Productos/SESION_CADUCADA">
	<xsl:for-each select="/Productos/SESION_CADUCADA">
		<xsl:if test="position()=last()">
			<xsl:apply-templates select="."/>
		</xsl:if>
	</xsl:for-each>
</xsl:when>
<xsl:when test="//xsql-error">
	<xsl:apply-templates select="//xsql-error"/>
</xsl:when>
<xsl:otherwise>
	<xsl:choose>
	<xsl:when test="//SESION_CADUCADA">
		<xsl:apply-templates select="//SESION_CADUCADA"/>
	</xsl:when>
	<xsl:when test="//Sorry">
		<xsl:apply-templates select="//Sorry"/>
	</xsl:when>
	<xsl:otherwise>

    <!--idioma-->
	<xsl:variable name="lang">
	<xsl:choose>
		<xsl:when test="/Productos/LANG"><xsl:value-of select="/Productos/LANG" /></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
	</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
    <!--idioma fin-->

	<xsl:variable name="usuario">
		<xsl:choose>
		<xsl:when test="EVALUACIONESPRODUCTOS/OBSERVADOR and EVALUACIONESPRODUCTOS/CDC">CDC</xsl:when>
		<xsl:otherwise>NORMAL</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	
	<!--	Titulo de la p�gina		-->
	<div class="ZonaTituloPagina">
		<p class="Path"><xsl:value-of select="document($doc)/translation/texts/item[@name='Inicio']/node()"/>&nbsp;/&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Convocatorias']/node()"/>&nbsp;/&nbsp;<span class="FinPath"><xsl:value-of select="document($doc)/translation/texts/item[@name='Productos']/node()"/></span>
			<span class="CompletarTitulo">
				<xsl:copy-of select="document($doc)/translation/texts/item[@name='pagina']/node()"/>&nbsp;
				<xsl:value-of select="/Productos/PRODUCTOS/PAGINA_ACTUAL"/>&nbsp;
				<xsl:copy-of select="document($doc)/translation/texts/item[@name='de']/node()"/>&nbsp;
				<xsl:value-of select="/Productos/PRODUCTOS/TOTAL_PAGINAS"/>
			</span>
		</p>
		<p class="TituloPagina">
			<xsl:value-of select="/Productos/PRODUCTOS/CONVOCATORIA"/>
			&nbsp;&nbsp;
			<span class="CompletarTitulo">
				<a class="btnNormal" href="javascript:DescargarExcel();">
					<img src="http://www.newco.dev.br/images/iconoExcel.gif" alt="Descargar Excel"/>
				</a>&nbsp;
				<a class="btnNormal" href="javascript:VerProcedimientos('');">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='Procedimientos']/node()"/>
				</a>&nbsp;
				<!--	Botones	anterior y siguiente-->
				<xsl:if test="/Productos/PRODUCTOS/ANTERIOR">
					&nbsp;<a class="btnNormal" href="javascript:PaginaAnterior();"><xsl:value-of select="document($doc)/translation/texts/item[@name='anterior']/node()"/></a>
				</xsl:if>
				<xsl:if test="/Productos/PRODUCTOS/SIGUIENTE">
					&nbsp;<a class="btnNormal" href="javascript:PaginaSiguiente();"><xsl:value-of select="document($doc)/translation/texts/item[@name='siguiente']/node()"/></a>
				</xsl:if>
			</span>
		</p>
	</div>
	<br/>
	<br/>
	<br/>
	
	
	<div class="divLeft">
		<form name="Buscador" method="post" action="http://www.newco.dev.br/ProcesosCdC/ConvocatoriasEspeciales/BuscadorProductos.xsql">
        <input type="hidden" name="PAGINA" id="PAGINA" value="{/Productos/PRODUCTOS/PAGINA}"/>
        <input type="hidden" name="ORDEN" id="ORDEN" value="{/Productos/PRODUCTOS/ORDEN}"/>
		<!--<table class="buscador" border="0">-->
		<table class="buscador" border="0">
			<!--<tr class="select" height="50px">-->
			<tr class="filtros" height="50px">
			<!--CONVOCATORIA-->
			<th width="320px" style="text-align:left;">
        	<label><xsl:value-of select="document($doc)/translation/texts/item[@name='Convocatoria']/node()"/></label><br />
        	<xsl:call-template name="desplegable">
            	<xsl:with-param name="path" select="/Productos/PRODUCTOS/FIDCONVOCATORIA/field"/>
            	<xsl:with-param name="defecto" select="/Productos/PRODUCTOS/FIDCONVOCATORIA/field/@current"/>
            	<xsl:with-param name="style">width:300px;</xsl:with-param>
        	</xsl:call-template>
			</th>
    		<xsl:if test="/Productos/PRODUCTOS/MVM or /Productos/PRODUCTOS/MVMB or /Productos/PRODUCTOS/ROL = 'COMPRADOR'">
				<th width="320px" style="text-align:left;">
        		&nbsp;<label><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/></label><br />
        		&nbsp;<xsl:call-template name="desplegable">
            		<xsl:with-param name="path" select="/Productos/PRODUCTOS/FIDPROVEEDOR/field"/>
            		<xsl:with-param name="defecto" select="/Productos/PRODUCTOS/FIDPROVEEDOR/field/@current"/>
            		<xsl:with-param name="style">width:300px;</xsl:with-param>
        		</xsl:call-template>
				</th>
    		</xsl:if>
			<th width="300px" style="text-align:left;">
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='texto']/node()"/></label><br />
				<input type="text" name="FTEXTO" size="10" id="FTEXTO" style="width:280px">
					<xsl:attribute name="value"><xsl:value-of select="/Productos/PRODUCTOS/FTEXTO"/></xsl:attribute>
				</input>
			</th>
			<th width="200px" style="text-align:left;">
				<label><xsl:copy-of select="document($doc)/translation/texts/item[@name='lineas_por_pagina']/node()"/></label><br />
				<xsl:call-template name="desplegable">
					<xsl:with-param name="path" select="/Productos/PRODUCTOS/LINEASPORPAGINA/field"/>
					<xsl:with-param name="onChange">javascript:Buscar();</xsl:with-param>
				</xsl:call-template>&nbsp;&nbsp;&nbsp;
			</th>
			<!--
			<th width="200px" style="text-align:left;">
				<input type="checkbox" class="muypeq" style="width:30px;" name="FPROCEDIMIENTOS"/>
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='Procedimientos']/node()"/></label><br />
			</th>
			-->
			<th width="140px" style="text-align:left;">
				<a class="btnDestacado" href="javascript:Buscar();">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='buscar']/node()"/>
				</a>
			</th>

			<th>&nbsp;</th>
			</tr>
		</table>
		</form>

		<div id="EvalBorradaOK" style="display:none;background:#CEF6CE;padding:5px;width:400px;color:#333;text-align:center;border:1px solid #01DF01;margin:10px auto;"><xsl:value-of select="document($doc)/translation/texts/item[@name='borrar_evaluacion_OK']/node()"/></div>
		<div id="EvalBorradaKO" style="display:none;background:#F8E0E6;padding:5px;width:400px;color:#333;text-align:center;border:1px solid red;margin:10px auto;"><xsl:value-of select="document($doc)/translation/texts/item[@name='borrar_evaluacion_KO']/node()"/></div>

		<!--<table class="grandeInicio" border="0">-->
		<table class="buscador" border="0">
		<thead>
			<tr class="subTituloTabla">
				<th><xsl:value-of select="document($doc)/translation/texts/item[@name='pos']/node()"/>.</th>
				<th align="left" class="cinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_prov']/node()"/></th>
				<th align="left" class="trenta"><xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/></th>
				<th align="left" class="cinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='Medida']/node()"/></th>
				<th align="left" class="cinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='marca']/node()"/></th>
				<th align="left" class="cinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='Fabricante']/node()"/></th>
				<th align="left" class="cinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='ud_basica']/node()"/></th>
				<th align="left" class="uno"><xsl:value-of select="document($doc)/translation/texts/item[@name='ud_lote']/node()"/></th>
				<th align="left" class="cinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='Clasificacion']/node()"/></th>
				<th align="left" class="diez"><xsl:value-of select="document($doc)/translation/texts/item[@name='Cod_Invima']/node()"/></th>
				<th align="left" class="cinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='Fecha_Limite']/node()"/></th>
				<th align="left" class="cinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='Clas_Riesgo']/node()"/></th>
				<th align="left" class="cinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='precio_ud_basica']/node()"/></th>
				<th align="left" class="cinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='tipo_iva']/node()"/></th>
				<th align="left" class="cinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='Descuento']/node()"/></th>
				<th align="left" class="cinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='Bonificacion']/node()"/></th>
				<th>&nbsp;</th>
			</tr>
		</thead>
        <xsl:choose>
		<xsl:when test="/Productos/PRODUCTOS/PRODUCTO">
			<xsl:for-each select="/Productos/PRODUCTOS/PRODUCTO">
				<xsl:variable name="IncID"><xsl:value-of select="ID"/></xsl:variable>
				<tr id="PRO_{LIC_CEL_ID}" style="border-bottom:1px solid #A7A8A9;">
					<xsl:choose>
					<xsl:when test="MODIFICADO_1HORA">
						<xsl:attribute name="class">fondoNaranja</xsl:attribute>
					</xsl:when>
					<xsl:when test="MODIFICADO_24HORAS">
						<xsl:attribute name="class">fondoAmarillo</xsl:attribute>
					</xsl:when>
					</xsl:choose>

                    <td><xsl:value-of select="LINEA"/></td>
					<td>
						<a class="refProducto" href="javascript:IncluirEnPaginaPrincipal('{LIC_CEL_REFERENCIA}');">
                    		<xsl:value-of select="LIC_CEL_REFERENCIA"/>
                        </a>
                    </td>
					<td class="datosLeft">&nbsp;<xsl:value-of select="LIC_CEL_PRODUCTO"/></td>
					<td class="datosLeft">&nbsp;<xsl:value-of select="LIC_CEL_MEDIDA"/></td>
					<td class="datosLeft">&nbsp;<xsl:value-of select="LIC_CEL_MARCA"/></td>
					<td class="datosLeft">&nbsp;<xsl:value-of select="LIC_CEL_FABRICANTE"/></td>
					<td class="datosLeft">&nbsp;<xsl:value-of select="LIC_CEL_UNIDADBASICA"/></td>
					<td class="datosRight">&nbsp;<xsl:value-of select="LIC_CEL_UNIDADESPORLOTE"/></td>
					<td class="datosLeft">&nbsp;<xsl:value-of select="LIC_CEL_CLASIFICACION"/></td>
					<td class="datosLeft">&nbsp;<xsl:value-of select="LIC_CEL_REGISTROINVIMA"/></td>
					<td>&nbsp;<xsl:value-of select="LIC_CEL_FECHAVENCINVIMA"/></td>
					<td class="datosLeft">&nbsp;<xsl:value-of select="LIC_CEL_CLASRIESGO"/></td>
					<td class="datosRight">&nbsp;<xsl:value-of select="LIC_CEL_PRECIO"/></td>
					<td class="datosRight">&nbsp;<xsl:value-of select="LIC_CEL_TIPOIVA"/></td>
					<td class="datosRight">&nbsp;<xsl:value-of select="LIC_CEL_DESCUENTOCOMERCIAL"/></td>
					<td class="datosRight">&nbsp;<xsl:value-of select="LIC_CEL_BONIFICACION"/></td>
					<td>
					<!--
					<xsl:if test="/Productos/PRODUCTOS/CDC">
						<a href="javascript:BorrarEvaluacionProducto('{PROD_EV_ID}');"><img src="http://www.newco.dev.br/images/2017/trash.png"/></a>
					</xsl:if>
					-->
					</td>
				</tr>
			</xsl:for-each>
                </xsl:when>
		<xsl:otherwise>
			<tr><td colspan="15" align="center"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='no_se_han_encontrado_resultados']/node()"/></strong></td></tr>
		</xsl:otherwise>
		</xsl:choose>
		</table>
                </div><!--fin de divLeft-->
	</xsl:otherwise>
        </xsl:choose>
</xsl:otherwise>
</xsl:choose>
</body>
</html>
</xsl:template>
</xsl:stylesheet>
