<?xml version="1.0" encoding="iso-8859-1"?>
<!--
	Buscador/Listado de convocatorias
	Ultima revision ET 29nov21 12:00
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
		<xsl:when test="/Convocatorias/LANG"><xsl:value-of select="/Convocatorias/LANG" /></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
	</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<title><xsl:value-of select="document($doc)/translation/texts/item[@name='Convocatorias']/node()"/>:&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Proveedores']/node()"/></title>

	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->

	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>
	<script type="text/javascript">
		var alrt_errorDescargaFichero	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='error_descarga_fichero']/node()"/>';
		
 		//	2oct18	Funciones para paginación del listado
		function Enviar(){
			var form=document.forms[0];
			//console.log("PAGINA:"+document.forms[0].elements['PAGINA'].value);
			
			SubmitForm(form);
		}

		function Buscar() {document.forms[0].elements['PAGINA'].value=0; Enviar();}
		function PaginaAnterior() {document.forms[0].elements['PAGINA'].value=parseInt(document.forms[0].elements['PAGINA'].value)-1; Enviar();}
		function PaginaSiguiente() {document.forms[0].elements['PAGINA'].value=parseInt(document.forms[0].elements['PAGINA'].value)+1; Enviar();}

		function CambioDesplegables(Tipo)
		{

			console.log('CambioDesplegables'+Tipo);
			
			if (Tipo=='CAMBIO_CONVOCATORIA')
				document.forms[0].elements['FIDCONVOCATORIA'].value=-1;
			
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
				if ((Campo=='CONVOCATORIA')||(Campo=='ESTADO')||(Campo=='USUARIO'))
					document.forms[0].elements['SENTIDO'].value='ASC';
				else
					document.forms[0].elements['SENTIDO'].value='DESC';
			}

			//console.log('Orden:'+Campo+' Nueva ordenación:'+document.forms[0].elements['ORDEN'].value+' '+document.forms[0].elements['SENTIDO'].value);

			Enviar();
		}
		
		function DescargarExcel(){
			var d = new Date();
			IDConvocatoria=document.forms[0].elements['FIDCONVOCATORIA'].value;
			
			jQuery.ajax({
				url:	"http://www.newco.dev.br/ProcesosCdC/ConvocatoriasEspeciales/ConvocatoriasExcel.xsql",
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
		
		//	Reabre convocatoria para un proveedor
		function reabrirConvocatoria(IDProveedor)
		{
			document.forms[0].elements['PARAMETROS'].value=IDProveedor;
			document.forms[0].elements['FESPECIALES'].value='';
			document.forms[0].elements['FTEXTO'].value='';
			document.forms[0].elements['ACCION'].value='REOFERTA';
			Enviar();
		}

		//	Cierra/suspende convocatoria para un proveedor
		function activaOSuspendeProveedor(IDProveedor)
		{
			document.forms[0].elements['PARAMETROS'].value=IDProveedor;
			document.forms[0].elements['FESPECIALES'].value='';
			document.forms[0].elements['FTEXTO'].value='';
			document.forms[0].elements['ACCION'].value='SUS';
			Enviar();
		}
		
		//	Abre la ventana para nueva convocatoria
		function Nueva()
		{
		}
		
	</script>
</head>

<body class="gris">
<xsl:choose>
<xsl:when test="/Convocatorias/SESION_CADUCADA">
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
	
	<!--	Titulo de la página		-->
	<div class="ZonaTituloPagina">
		<p class="Path"><xsl:value-of select="document($doc)/translation/texts/item[@name='Inicio']/node()"/>&nbsp;/&nbsp;<span class="FinPath"><xsl:value-of select="document($doc)/translation/texts/item[@name='Convocatorias']/node()"/></span>
			<span class="CompletarTitulo">
				<xsl:copy-of select="document($doc)/translation/texts/item[@name='pagina']/node()"/>&nbsp;
				<xsl:value-of select="/Convocatorias/CONVOCATORIAS/PAGINA_ACTUAL"/>&nbsp;
				<xsl:copy-of select="document($doc)/translation/texts/item[@name='de']/node()"/>&nbsp;
				<xsl:value-of select="/Convocatorias/CONVOCATORIAS/TOTAL_PAGINAS"/>
			</span>
		</p>
		<p class="TituloPagina">
			<xsl:value-of select="document($doc)/translation/texts/item[@name='Convocatorias']/node()"/>
			&nbsp;&nbsp;
			<span class="CompletarTitulo">
				<xsl:if test="/Convocatorias/CONVOCATORIAS/ROL='COMPRADOR'">
				<a class="btnNormal" href="http://www.newco.dev.br/ProcesosCdC/Convocatorias/Convocatoria.xsql"><xsl:value-of select="document($doc)/translation/texts/item[@name='nueva']/node()"/></a>&nbsp;
				<a class="btnNormal" href="http://www.newco.dev.br/Gestion/Comercial/Licitaciones.xsql">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='Licitaciones']/node()"/>
				</a>&nbsp;
				</xsl:if>
				<!--	Botones	anterior y siguiente-->
				<xsl:if test="/Convocatorias/CONVOCATORIAS/ANTERIOR">
					<a class="btnNormal" href="javascript:PaginaAnterior();"><xsl:value-of select="document($doc)/translation/texts/item[@name='anterior']/node()"/></a>&nbsp;
				</xsl:if>
				<xsl:if test="/Convocatorias/CONVOCATORIAS/SIGUIENTE">
					<a class="btnNormal" href="javascript:PaginaSiguiente();"><xsl:value-of select="document($doc)/translation/texts/item[@name='siguiente']/node()"/></a>&nbsp;
				</xsl:if>
			</span>
		</p>
	</div>
	<br/>
	<br/>
	<br/>
	
	
	<div class="divLeft">
		<form name="Procedimiento" method="post" action="http://www.newco.dev.br/ProcesosCdC/Convocatorias/Convocatorias.xsql">
		<input type="hidden" name="PAGINA" value="{/Convocatorias/CONVOCATORIAS/PAGINA}"/>
		<input type="hidden" name="ORDEN" value="{/Convocatorias/CONVOCATORIAS/ORDEN}"/>
		<input type="hidden" name="SENTIDO" value="{/Convocatorias/CONVOCATORIAS/SENTIDO}"/>
		<input type="hidden" name="ACCION" value=""/>
		<input type="hidden" name="PARAMETROS" value=""/>
		<!--<table class="buscador" border="0">-->
		<table class="buscador" border="0">
		<!--
		<tr class="sinLinea" style="height:30px;">
		<td width="150px" class="labelRight">
      		<label><xsl:value-of select="document($doc)/translation/texts/item[@name='Convocatoria']/node()"/>:&nbsp;</label>
		</td>
		<td width="450px" class="textLeft">
        	<xsl:call-template name="desplegable">
            	<xsl:with-param name="path" select="/Convocatorias/CONVOCATORIAS/FIDCONVOCATORIA/field"/>
            	<xsl:with-param name="style">width:400px;height:20px;</xsl:with-param>
            	<xsl:with-param name="onChange">javascript:CambioDesplegables('CAMBIO_CONVOCATORIA');</xsl:with-param>
        	</xsl:call-template>
		</td>
		<td width="*">
      		&nbsp;
		</td>
		</tr>
		-->
		<tr class="sinLinea" style="height:30px;">
		<!--
		<td class="labelRight">
        	<label><xsl:value-of select="document($doc)/translation/texts/item[@name='Filtros']/node()"/>:&nbsp;</label>
		</td>
		<td class="textLeft">
        	<xsl:call-template name="desplegable">
            	<xsl:with-param name="path" select="/Convocatorias/CONVOCATORIAS/FESPECIALES/field"/>
             	<xsl:with-param name="style">width:400px;height:20px;</xsl:with-param>
        	</xsl:call-template>
		</td>
		-->
		<td width="300px" class="labelRight">
			<label><xsl:value-of select="document($doc)/translation/texts/item[@name='texto']/node()"/>:&nbsp;</label>
			<input type="text" name="FTEXTO" size="10" id="FTEXTO" style="width:180px">
				<xsl:attribute name="value"><xsl:value-of select="/Convocatorias/CONVOCATORIAS/FTEXTO"/></xsl:attribute>
			</input>&nbsp;&nbsp;
		</td>
		<td width="300px" style="text-align:left;">
			<label><xsl:copy-of select="document($doc)/translation/texts/item[@name='lineas_por_pagina']/node()"/>:&nbsp;</label>
			<xsl:call-template name="desplegable">
				<xsl:with-param name="path" select="/Convocatorias/CONVOCATORIAS/LINEASPORPAGINA/field"/>
            	<xsl:with-param name="style">width:100px;height:20px;</xsl:with-param>
				<!--<xsl:with-param name="onChange">javascript:Buscar();</xsl:with-param>-->
			</xsl:call-template>&nbsp;&nbsp;&nbsp;
		</td>
		<td width="140px" style="text-align:left;">
			<a class="btnDestacado" href="javascript:Buscar();">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='buscar']/node()"/>
			</a>
		</td>
		<td width="*">
      		&nbsp;
		</td>
		</tr>
		</table>
		</form>
		<BR/><BR/>

		<!--<table class="grandeInicio" border="0">-->
		<table class="buscador" border="0">
		<thead>
			<tr class="subTituloTabla">
				<th class="uno"><xsl:value-of select="document($doc)/translation/texts/item[@name='pos']/node()"/>.</th>
				<th align="left" class="veinte">&nbsp;<a href="javascript:Orden('CONVOCATORIA');"><xsl:value-of select="document($doc)/translation/texts/item[@name='Convocatoria']/node()"/></a></th>
				<th align="left" class="veinte">&nbsp;<a href="javascript:Orden('CLIENTE');"><xsl:value-of select="document($doc)/translation/texts/item[@name='cliente']/node()"/></a></th>
				<th align="left" class="cinco">&nbsp;<a href="javascript:Orden('TIPO');"><xsl:value-of select="document($doc)/translation/texts/item[@name='tipo']/node()"/></a></th>
				<th align="left" class="veinte">&nbsp;<a href="javascript:Orden('USUARIO');"><xsl:value-of select="document($doc)/translation/texts/item[@name='usuario']/node()"/></a></th>
				<th align="left" class="uno">&nbsp;<a href="javascript:Orden('FECHA');"><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha']/node()"/></a></th>
				<th align="left" class="uno">&nbsp;<a href="javascript:Orden('FECHADEC');"><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_decision_abbr']/node()"/></a></th>
				<th align="left" class="uno" >&nbsp;<a href="javascript:Orden('NUMLIC');"><xsl:value-of select="document($doc)/translation/texts/item[@name='Licitaciones']/node()"/></a></th>
				<th align="left" class="uno" >&nbsp;<a href="javascript:Orden('NUMPROV');"><xsl:value-of select="document($doc)/translation/texts/item[@name='Proveedores']/node()"/></a></th>
				<th align="left" class="veinte" >&nbsp;<a href="javascript:Orden('ESTADO');"><xsl:value-of select="document($doc)/translation/texts/item[@name='estado']/node()"/></a></th>
				<th>&nbsp;</th>
			</tr>
		</thead>
        <xsl:choose>
		<xsl:when test="/Convocatorias/CONVOCATORIAS/CONVOCATORIA">
			<xsl:for-each select="/Convocatorias/CONVOCATORIAS/CONVOCATORIA">
				<tr id="CONV_{LIC_CONV_ID}">
					<xsl:attribute name="style">
					<xsl:choose>
					<xsl:when test="IDESTADO='SUS'">border-bottom:1px solid #A7A8A9;background:#CC0000;</xsl:when>
					<xsl:otherwise>border-bottom:1px solid #A7A8A9;</xsl:otherwise>
					</xsl:choose>
					</xsl:attribute>
                    <td><xsl:value-of select="LINEA"/></td>
					<td class="datosLeft">
						&nbsp;<a href="http://www.newco.dev.br/ProcesosCdC/Convocatorias/Convocatoria.xsql?LIC_CONV_ID={LIC_CONV_ID}">
							<strong><xsl:value-of select="LIC_CONV_NOMBRE"/></strong>
						</a>
					</td>
					<td class="datosLeft">&nbsp;<strong><xsl:value-of select="CLIENTE"/></strong></td>
					<td class="datosLeft">&nbsp;<xsl:value-of select="TIPO"/></td>
					<td class="datosLeft">&nbsp;<xsl:value-of select="USUARIO"/></td>
					<td class="datosLeft">&nbsp;<xsl:value-of select="FECHA"/></td>
					<td class="datosLeft">&nbsp;<xsl:value-of select="FECHADECISION"/></td>
					<td class="datosRight"><strong><xsl:value-of select="NUMLICITACIONES"/></strong>&nbsp;</td>
					<td class="datosRight"><strong><xsl:value-of select="NUMPROVEEDORES"/></strong>&nbsp;</td>
					<td class="datosLeft">&nbsp;<xsl:value-of select="ESTADOCOMPLETO"/></td>
					<!--<td class="datosRight"><strong><xsl:value-of select="NUMEROLINEAS"/></strong>&nbsp;</td>
					<td class="datosRight"><strong><xsl:value-of select="NUMPROCEDIMIENTOS"/></strong>&nbsp;</td>
					<td class="datosRight"><strong><xsl:value-of select="ADJUDICADOS"/></strong>&nbsp;</td>
					<td class="datosRight"><strong><xsl:value-of select="ORDEN1"/></strong>&nbsp;</td>
					<td class="datosRight azul"><strong><xsl:value-of select="OFERTASMEJORPRECIO"/></strong>&nbsp;</td>
					<td class="datosRight azul"><strong><xsl:value-of select="CONSUMOMEJORPRECIO"/></strong>&nbsp;</td>
					<td class="datosRight verde"><strong><xsl:value-of select="OFERTASCONAHORRO"/></strong>&nbsp;</td>
					<td class="datosRight verde"><strong><xsl:value-of select="CONSUMOCONAHORRO"/></strong>&nbsp;</td>-->

					<td>
					<!--
					<xsl:if test="/Convocatorias/CONVOCATORIAS/CDC">
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
