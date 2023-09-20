<?xml version="1.0" encoding="iso-8859-1"?>
<!--
	Convocatorias especiales: buscador de procedimientos
	Ultima revision ET 13mar19 09:27
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
		<xsl:when test="/Procedimientos/LANG"><xsl:value-of select="/Procedimientos/LANG" /></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
	</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<title><xsl:value-of select="document($doc)/translation/texts/item[@name='Convocatorias']/node()"/>:&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Procedimientos']/node()"/></title>

	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->

	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>
	<script type="text/javascript">
		var alrt_errorDescargaFichero	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='error_descarga_fichero']/node()"/>';
	
		function onLoad()
		{	
			proveedorOnChange();
		}

 		//	Funciones para paginación del listado
		function Enviar(){
			var form=document.forms[0];
			//console.log("PAGINA:"+document.forms[0].elements['PAGINA'].value);
			
			//if (document.forms[0].elements['FPRODUCTOS'].checked)
			//	form.action="http://www.newco.dev.br/ProcesosCdC/ConvocatoriasEspeciales/BuscadorProductos.xsql";
			
			if (document.forms[0].elements['FINFORMADO'].checked)
				document.forms[0].elements['FINFORMADO'].value="S";
			
			SubmitForm(form);
		}

		function Buscar() {document.forms[0].elements['PAGINA'].value=0; Enviar();}
		function PaginaAnterior() {document.forms[0].elements['PAGINA'].value=parseInt(document.forms[0].elements['PAGINA'].value)-1; Enviar();}
		function PaginaSiguiente() {document.forms[0].elements['PAGINA'].value=parseInt(document.forms[0].elements['PAGINA'].value)+1; Enviar();}

		function AbrirEnPaginaPrincipal(IDConvocatoria, IDEspecialidad, IDModProcedimiento, IDProveedor)
		{
			if (document.forms[0].elements['ROL'].value=='COMPRADOR')
			{
				//	Para un cliente, abrimos en la propia página principal
				var UrlCompetencia='http://www.newco.dev.br/ProcesosCdC/ConvocatoriasEspeciales/ProcedimientoYOfertas.xsql?FIDCONVOCATORIA='
								+IDConvocatoria+'&amp;FIDESPECIALIDAD='+IDEspecialidad+'&amp;FIDPROCEDIMIENTO='+IDModProcedimiento+'&amp;FIDPROVEEDOR='+IDProveedor;

				window.location=UrlCompetencia;
			}
			else
			{
				var Url='http://www.newco.dev.br/ProcesosCdC/ConvocatoriasEspeciales/InformarProcedimientos.xsql?FIDCONVOCATORIA='
								+IDConvocatoria+'&amp;FIDESPECIALIDAD='+IDEspecialidad+'&amp;FIDPROCEDIMIENTO='+IDModProcedimiento+'&amp;FIDPROVEEDOR='+IDProveedor;

				try
				{
					//	Para un proveedor,desde el pop up cambiamos la página principal
					window.opener.location=Url;
				}
				catch(err)
				{
					//	Si ha dado error, abrimos en la propia página principal
					window.location=Url;
				}
			}
		}
		
		function proveedorOnChange()
		{
			if (document.forms[0].elements['FIDPROVEEDOR'].value!=-1)
			{
				document.forms[0].elements['FINFORMADO'].checked=true;
				document.forms[0].elements['FINFORMADO'].disabled=true;
			}
			else
			{
				document.forms[0].elements['FINFORMADO'].disabled=false
			}
		}
		
		function VerProveedor(IDProveedor, Referencia)
		{
			document.forms[0].elements['FINFORMADO'].checked=true;
			document.forms[0].elements['PAGINA'].value=0;
			document.forms[0].elements['FESPECIALES'].value='-1';
			document.forms[0].elements['FTEXTO'].value=Referencia;
			document.forms[0].elements['FIDPROVEEDOR'].value=IDProveedor;
			Enviar();
		}
		

		function Orden(Campo)
		{
			console.log('Campo:'+Campo+ 'Orden actual:'+document.forms[0].elements['ORDEN'].value+ 'Sentido:'+document.forms[0].elements['SENTIDO'].value);
		
			if (Campo==document.forms[0].elements['ORDEN'].value)
				document.forms[0].elements['SENTIDO'].value=(document.forms[0].elements['SENTIDO'].value=='DESC')?'ASC':'DESC';
			else
			{
				document.forms[0].elements['ORDEN'].value=Campo;
				if ((Campo=='REFERENCIA')||(Campo=='PROCEDIMIENTO'))
					document.forms[0].elements['SENTIDO'].value='ASC';
				else
					document.forms[0].elements['SENTIDO'].value='DESC';
			}

			//console.log('Orden:'+Campo+' Nueva ordenación:'+document.forms[0].elements['ORDEN'].value+' '+document.forms[0].elements['SENTIDO'].value);

			Enviar();
		}
		
		function DescargarExcel()
		{
			var d = new Date();
			IDConvocatoria=document.forms[0].elements['FIDCONVOCATORIA'].value;
			
			jQuery.ajax({
				url:	"http://www.newco.dev.br/ProcesosCdC/ConvocatoriasEspeciales/ProcedimientosExcel.xsql",
				data:	"IDCONVOCATORIA="+IDConvocatoria+"&amp;_="+d.getTime(),
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

		function VerProveedores(IDProveedor)
		{
			var IDConvocatoria=document.forms[0].elements['FIDCONVOCATORIA'].value;
			document.location='http://www.newco.dev.br/ProcesosCdC/ConvocatoriasEspeciales/Proveedores.xsql?FIDCONVOCATORIA='+IDConvocatoria+'&amp;FIDPROVEEDOR='+IDProveedor;
		}

		function VerProductos()
		{
			var IDConvocatoria=document.forms[0].elements['FIDCONVOCATORIA'].value;
			document.location='http://www.newco.dev.br/ProcesosCdC/ConvocatoriasEspeciales/BuscadorProductos.xsql?FIDCONVOCATORIA='+IDConvocatoria;
		}
		

	</script>
</head>

<body class="gris" onload="javascript:onLoad();">
<xsl:choose>
<xsl:when test="/Procedimientos/SESION_CADUCADA">
	<xsl:for-each select="/Procedimientos/SESION_CADUCADA">
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
		<xsl:when test="/Procedimientos/LANG"><xsl:value-of select="/Procedimientos/LANG" /></xsl:when>
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
	
	<!--	Titulo de la página		-->
	<div class="ZonaTituloPagina">
		<p class="Path"><xsl:value-of select="document($doc)/translation/texts/item[@name='Inicio']/node()"/>&nbsp;/&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Convocatorias']/node()"/>&nbsp;/&nbsp;<span class="FinPath"><xsl:value-of select="/Procedimientos/PROCEDIMIENTOS/TOTAL"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Procedimientos']/node()"/></span>
			<span class="CompletarTitulo">
				<xsl:copy-of select="document($doc)/translation/texts/item[@name='pagina']/node()"/>&nbsp;
				<xsl:value-of select="/Procedimientos/PROCEDIMIENTOS/PAGINA_ACTUAL"/>&nbsp;
				<xsl:copy-of select="document($doc)/translation/texts/item[@name='de']/node()"/>&nbsp;
				<xsl:value-of select="/Procedimientos/PROCEDIMIENTOS/TOTAL_PAGINAS"/>
			</span>
		</p>
		<p class="TituloPagina">
			<xsl:value-of select="/Procedimientos/PROCEDIMIENTOS/CONVOCATORIA"/>
			&nbsp;&nbsp;
			<span class="CompletarTitulo">
				<a class="btnNormal" href="javascript:DescargarExcel();">
					<img src="http://www.newco.dev.br/images/iconoExcel.gif" alt="Descargar Excel"/>
				</a>&nbsp;
				<xsl:if test="/Procedimientos/PROCEDIMIENTOS/ROL='COMPRADOR'">
				<a class="btnNormal" href="javascript:VerProductos()">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='Productos']/node()"/>
				</a>&nbsp;
				<a class="btnNormal" href="javascript:VerProveedores({/Procedimientos/PROCEDIMIENTOS/IDPROVEEDOR})">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='Proveedores']/node()"/>
				</a>
				</xsl:if>
				<!--	Botones	anterior y siguiente-->
				<xsl:if test="/Procedimientos/PROCEDIMIENTOS/ANTERIOR">
					&nbsp;<a class="btnNormal" href="javascript:PaginaAnterior();"><xsl:value-of select="document($doc)/translation/texts/item[@name='anterior']/node()"/></a>
				</xsl:if>
				<xsl:if test="/Procedimientos/PROCEDIMIENTOS/SIGUIENTE">
					&nbsp;<a class="btnNormal" href="javascript:PaginaSiguiente();"><xsl:value-of select="document($doc)/translation/texts/item[@name='siguiente']/node()"/></a>
				</xsl:if>
			</span>
		</p>
	</div>
	<br/>
	<br/>
	<br/>
	
	
	<div class="divLeft">
		<form name="Buscador" method="post" action="http://www.newco.dev.br/ProcesosCdC/ConvocatoriasEspeciales/BuscadorProcedimientos.xsql">
        <input type="hidden" name="ROL" id="ROL" value="{/Procedimientos/PROCEDIMIENTOS/ROL}"/>
        <input type="hidden" name="PAGINA" id="PAGINA" value="{/Procedimientos/PROCEDIMIENTOS/PAGINA}"/>
        <input type="hidden" name="ORDEN" id="ORDEN" value="{/Procedimientos/PROCEDIMIENTOS/ORDEN}"/>
		<input type="hidden" name="SENTIDO" value="{/Procedimientos/PROCEDIMIENTOS/SENTIDO}"/>
        <input type="hidden" name="IDPROVEEDOR" id="IDPROVEEDOR" value="{/Procedimientos/PROCEDIMIENTOS/IDPROVEEDOR}"/>
		<!--<table class="buscador" border="0">-->
		<table class="buscador" border="0">
			<!--<tr class="select" height="50px">-->
			<tr class="filtros" height="50px">
			<!--CONVOCATORIA-->
			<th width="320px" style="text-align:left;">
        	<label><xsl:value-of select="document($doc)/translation/texts/item[@name='Convocatoria']/node()"/></label><br />
        	<xsl:call-template name="desplegable">
            	<xsl:with-param name="path" select="/Procedimientos/PROCEDIMIENTOS/FIDCONVOCATORIA/field"/>
            	<xsl:with-param name="defecto" select="/Procedimientos/PROCEDIMIENTOS/FIDCONVOCATORIA/field/@current"/>
            	<xsl:with-param name="style">width:300px;</xsl:with-param>
        	</xsl:call-template>
			</th>
    		<xsl:if test="/Procedimientos/PROCEDIMIENTOS/MVM or /Procedimientos/PROCEDIMIENTOS/MVMB or /Procedimientos/PROCEDIMIENTOS/ROL = 'COMPRADOR'">
				<th width="320px" style="text-align:left;">
        		&nbsp;<label><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/></label><br />
        		&nbsp;<xsl:call-template name="desplegable">
            		<xsl:with-param name="path" select="/Procedimientos/PROCEDIMIENTOS/FIDPROVEEDOR/field"/>
            		<xsl:with-param name="defecto" select="/Procedimientos/PROCEDIMIENTOS/FIDPROVEEDOR/field/@current"/>
            		<xsl:with-param name="style">width:300px;</xsl:with-param>
					<xsl:with-param name="onChange">javascript:proveedorOnChange();</xsl:with-param>
        		</xsl:call-template>
				</th>
    		</xsl:if>
			<th width="220px" style="text-align:left;">
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='texto']/node()"/></label><br />
				<input type="text" name="FTEXTO" size="10" id="FTEXTO" style="width:200px">
					<xsl:attribute name="value"><xsl:value-of select="/Procedimientos/PROCEDIMIENTOS/FTEXTO"/></xsl:attribute>
				</input>
			</th>
    		<xsl:if test="/Procedimientos/PROCEDIMIENTOS/MVM or /Procedimientos/PROCEDIMIENTOS/MVMB or /Procedimientos/PROCEDIMIENTOS/ROL = 'COMPRADOR'">
			<th width="220px" style="text-align:left;">
        		<label><xsl:value-of select="document($doc)/translation/texts/item[@name='Filtros']/node()"/>:&nbsp;</label><br />
        		<xsl:call-template name="desplegable">
            		<xsl:with-param name="path" select="/Procedimientos/PROCEDIMIENTOS/FESPECIALES/field"/>
             		<xsl:with-param name="style">width:200px;</xsl:with-param>
        		</xsl:call-template>
			</th>
    		</xsl:if>
			<th width="150px" style="text-align:left;">
				<label><xsl:copy-of select="document($doc)/translation/texts/item[@name='lineas_por_pagina']/node()"/></label><br />
				<xsl:call-template name="desplegable">
					<xsl:with-param name="path" select="/Procedimientos/PROCEDIMIENTOS/LINEASPORPAGINA/field"/>
					<xsl:with-param name="onChange">javascript:Buscar();</xsl:with-param>
				</xsl:call-template>&nbsp;&nbsp;&nbsp;
			</th>
			<!--
			<th width="140px" style="text-align:left;">
				<input type="checkbox" class="muypeq" style="width:30px;" name="FPRODUCTOS"/>
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='Productos']/node()"/></label><br />
			</th>
			-->
			<th width="140px" style="text-align:left;">
				<input type="checkbox" class="muypeq" style="width:30px;" name="FINFORMADO">
				<xsl:if test="/Procedimientos/PROCEDIMIENTOS/FINFORMADO='S'">
					<xsl:attribute name="checked" value="checked"/>
				</xsl:if>
				</input>
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='Informado']/node()"/></label><br />
			</th>

			<th width="100px" style="text-align:left;">
				<a class="btnDestacado" href="javascript:Buscar();">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='buscar']/node()"/>
				</a>
			</th>

			<th>&nbsp;</th>
			</tr>
		</table>
		</form>

		<!--<table class="grandeInicio" border="0">-->
		<table class="buscador" border="0">
		<thead>
			<tr class="subTituloTabla">
				<th class="uno"><xsl:value-of select="document($doc)/translation/texts/item[@name='pos']/node()"/>.</th>
				<th align="left" class="cinco"><a href="javascript:Orden('REFERENCIA');"><xsl:value-of select="document($doc)/translation/texts/item[@name='referencia']/node()"/></a></th>
				<th align="left"><a href="javascript:Orden('PROCEDIMIENTO');"><xsl:value-of select="document($doc)/translation/texts/item[@name='Procedimiento']/node()"/></a></th>
				<xsl:choose>
				<xsl:when test="/Procedimientos/PROCEDIMIENTOS/CON_FILTRO_PROVEEDOR">
					<th align="left" class="cinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='usuario']/node()"/></th>
					<th align="left" class="dos"><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha']/node()"/></th>
				</xsl:when>
				<xsl:otherwise>
				</xsl:otherwise>
				</xsl:choose>
				<xsl:if test="/Procedimientos/PROCEDIMIENTOS/ROL='COMPRADOR'">
					<th align="left" class="cinco"><a href="javascript:Orden('OFERTAS');"><xsl:value-of select="document($doc)/translation/texts/item[@name='ofertas']/node()"/></a></th>
					<th align="left" class="cinco"><a href="javascript:Orden('ORDEN');"><xsl:value-of select="document($doc)/translation/texts/item[@name='Orden']/node()"/></a></th>
				</xsl:if>
				<th align="left" class="cinco"><a href="javascript:Orden('CONSUMO');"><xsl:value-of select="document($doc)/translation/texts/item[@name='Consumo_hist']/node()"/></a></th>
				<th align="left" class="cinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='Valor_factura']/node()"/></th>
				<th align="left" class="cinco">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Costo_neto']/node()"/></th>
				<th align="left" class="cinco">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Valor_factura_hist']/node()"/></th>
				<th align="left" class="cinco">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Costo_neto_hist']/node()"/></th>
				<th align="left" class="cinco">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Mejor_valor_factura']/node()"/></th>
				<th align="left" class="cinco">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Mejor_costo_neto']/node()"/></th>
				<th align="left" class="diez">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Proveedor_actual']/node()"/></th>
				<th align="left" class="diez">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Prov_mejor_costo_neto']/node()"/></th>
				<th>&nbsp;</th>
			</tr>
		</thead>
        <xsl:choose>
		<xsl:when test="/Procedimientos/PROCEDIMIENTOS/PROCEDIMIENTO">
			<xsl:for-each select="/Procedimientos/PROCEDIMIENTOS/PROCEDIMIENTO">
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
						<a href="javascript:AbrirEnPaginaPrincipal({/Procedimientos/PROCEDIMIENTOS/IDCONVOCATORIA},{LIC_CMP_IDESPECIALIDAD},{LIC_CMP_ID},{/Procedimientos/PROCEDIMIENTOS/IDPROVEEDOR});">
                    		<xsl:value-of select="LIC_CMP_REFERENCIA"/>
                        </a>
                    </td>
					<td class="datosLeft">&nbsp;<xsl:value-of select="LIC_CMP_PROCEDIMIENTO"/></td>
					<xsl:choose>
					<xsl:when test="/Procedimientos/PROCEDIMIENTOS/CON_FILTRO_PROVEEDOR">
						<td class="datosLeft">&nbsp;<xsl:value-of select="INFORMADO/USUARIO"/></td>
						<td class="datosLeft">&nbsp;<xsl:value-of select="INFORMADO/FECHA"/></td>
					</xsl:when>
					<xsl:otherwise>
					</xsl:otherwise>
					</xsl:choose>
					<xsl:if test="/Procedimientos/PROCEDIMIENTOS/ROL='COMPRADOR'">
						<td class="datosRight">&nbsp;<xsl:value-of select="LIC_CMP_NUMEROOFERTAS"/>&nbsp;</td>
						<td>
							<xsl:choose>
							<xsl:when test="INFORMADO/LIC_CEP_ORDEN=1">
								<xsl:attribute name="class">datosRight azul</xsl:attribute>
							</xsl:when>
							<xsl:otherwise>
								<xsl:attribute name="class">datosRight</xsl:attribute>
							</xsl:otherwise>
							</xsl:choose>
							<strong><xsl:value-of select="INFORMADO/LIC_CEP_ORDEN"/></strong>&nbsp;
						</td>
					</xsl:if>
					<td class="datosRight"><xsl:value-of select="LIC_CMP_CONSUMOHISTORICO"/>&nbsp;</td>
					<td>
						<xsl:choose>
						<xsl:when test="INFORMADO/PRECIOBASE_MEJORPRECIO">
							<xsl:attribute name="class">datosRight azul</xsl:attribute>
						</xsl:when>
						<xsl:when test="INFORMADO/PRECIOBASE_MASBARATO">
							<xsl:attribute name="class">datosRight verde</xsl:attribute>
						</xsl:when>
						<xsl:when test="INFORMADO/PRECIOBASE_MASCARO">
							<xsl:attribute name="class">datosRight rojo</xsl:attribute>
						</xsl:when>
						<xsl:otherwise>
							<xsl:attribute name="class">datosRight</xsl:attribute>
						</xsl:otherwise>
						</xsl:choose>
						<strong>
							<xsl:value-of select="INFORMADO/LIC_CEP_PRECIOBASE"/>
						</strong>&nbsp;
						</td>
					<td class="datosRight">
						<xsl:choose>
						<xsl:when test="INFORMADO/PRECIONETO_MEJORPRECIO">
							<xsl:attribute name="class">datosRight azul</xsl:attribute>
						</xsl:when>
						<xsl:when test="INFORMADO/PRECIONETO_MASBARATO">
							<xsl:attribute name="class">datosRight verde</xsl:attribute>
						</xsl:when>
						<xsl:when test="INFORMADO/PRECIONETO_MASCARO">
							<xsl:attribute name="class">datosRight rojo</xsl:attribute>
						</xsl:when>
						<xsl:otherwise>
							<xsl:attribute name="class">datosRight</xsl:attribute>
						</xsl:otherwise>
						</xsl:choose>
						<strong>
							<xsl:value-of select="INFORMADO/LIC_CEP_PRECIOBONIFICADO"/>
						</strong>&nbsp;
					</td>
					<td class="datosRight"><strong><xsl:value-of select="LIC_CMP_PRECIOREFERENCIA"/></strong>&nbsp;</td>
					<td class="datosRight"><strong><xsl:value-of select="LIC_CMP_PRECIOREFERENCIADESC"/></strong>&nbsp;</td>
					<td class="datosRight"><strong><xsl:value-of select="LIC_CMP_MEJORPRECIO"/></strong>&nbsp;</td>
					<td class="datosRight"><strong><xsl:value-of select="LIC_CMP_MEJORPRECIODESC"/></strong>&nbsp;</td>
					<td class="datosLeft"><a href="javascript:VerProveedor({IDPROVEEDOR_ACTUAL},'{LIC_CMP_REFERENCIA}');"><xsl:value-of select="PROVEEDOR_ACTUAL"/></a>&nbsp;</td>
					<td class="datosLeft"><a href="javascript:VerProveedor({IDPROVEEDOR_MEJORPRECIODESC},'{LIC_CMP_REFERENCIA}');"><xsl:value-of select="PROVEEDOR_MEJORPRECIODESC"/></a>&nbsp;</td>
					<td>&nbsp;</td>
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
