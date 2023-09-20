<?xml version="1.0" encoding="iso-8859-1"?>
<!--
	Informar procedimientos en convocatoria de elementos especiales
	Ultima revision ET 24oct18 11:45
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

	<title><xsl:value-of select="document($doc)/translation/texts/item[@name='Procedimiento']/node()"/></title>

	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->

	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>
	<script type="text/javascript">

 		//	2oct18	Funciones para paginación del listado
		function Enviar(){
			var form=document.forms[0];
			
			SubmitForm(form);
		}

		function CambioDesplegables(Tipo)
		{

			console.log('CambioDesplegables'+Tipo);
			
			if (Tipo=='CAMBIO_CONVOCATORIA')
				document.forms[0].elements['FIDPROVEEDOR'].value=-1;
			
			Enviar();
		}


		function Orden(Campo)
		{
			if (Campo==document.forms[0].elements['ORDEN'].value)
			{	
				document.forms[0].elements['SENTIDO'].value=(document.forms[0].elements['SENTIDO'].value=='DESC')?'ASC':'DESC';
			}
			else
			{
				document.forms[0].elements['ORDEN'].value=Campo;
				
				if (Campo=='REEMBCARTERA')
					document.forms[0].elements['SENTIDO'].value='DESC';
				else
					document.forms[0].elements['SENTIDO'].value='ASC';
			}

			//console.log('3.- Orden (sol.'+Campo+') Nueva ordenación real:'+document.forms[0].elements['ORDEN'].value+' '+document.forms[0].elements['SENTIDO'].value);

			Enviar();
		}
		
		function VerProveedor(IDProveedor)
		{
			var Url='http://www.newco.dev.br/ProcesosCdC/ConvocatoriasEspeciales/InformarProcedimientos.xsql?'
					+'FIDCONVOCATORIA='+document.forms["Procedimiento"].elements["FIDCONVOCATORIA"].value
					+'&amp;FIDESPECIALIDAD='+document.forms["Procedimiento"].elements["FIDESPECIALIDAD"].value
					+'&amp;FIDPROCEDIMIENTO='+document.forms["Procedimiento"].elements["FIDPROCEDIMIENTO"].value
					+'&amp;FIDPROVEEDOR='+IDProveedor;
		
		//	console.log('VerProveedor Pendiente. IDProveedor:'+IDProveedor+ Url:'+Url);
			window.location=Url;
		}
		
		function OrdenAdjudicacionAutomatico()
		{
			jQuery("select").each(function()
			{
    			//solodebug	console.log('Nombre:'+jQuery(this).attr("name").substring(0,5));
				
				if (jQuery(this).attr("name").substring(0,5)=='ORDEN')
				{
					var Control=jQuery(this).attr("name");
					var ID=Piece(jQuery(this).attr("name"),'_',1);
					var Orden=jQuery('#CONT_'+ID).val();

        			//solodebug	console.log('Control:'+Control+' ID:'+ID+' Valor anterior:'+jQuery(this).val()+' Orden:'+Orden);

					jQuery(this).val(Orden);
				}
			});
		}

		function GuardarAdjudicacion()
		{
			console.log('GuardarAdjudicacion: Pendiente');
			var Cadena='';
			
			jQuery("select").each(function()
			{
    			//solodebug	console.log('Nombre:'+jQuery(this).attr("name").substring(0,5));
				
				if (jQuery(this).attr("name").substring(0,5)=='ORDEN')
				{
					var Control=jQuery(this).attr("name");
					var ID=Piece(jQuery(this).attr("name"),'_',1);
					var Orden=jQuery(this).val();

        			//solodebug	console.log('Control:'+Control+' ID:'+ID+' Valor anterior:'+jQuery(this).val()+' Orden:'+Orden);
					
					if (Orden==-1)
						Cadena+=ID+'|'+'N'+'|-1#';
					else
						Cadena+=ID+'|'+'S'+'|'+Orden+'#';

				}
			});
			
			document.forms[0].elements['ACCION'].value='GUARDAR';
			document.forms[0].elements['PARAMETROS'].value=Cadena;
			
			//solodebug	
			console.log('Guardar:'+Cadena);
			
			Enviar();
		}

	</script>
</head>

<body class="gris">
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
	
	<!--	Titulo de la página		-->
	<div class="ZonaTituloPagina">
		<p class="Path"><xsl:value-of select="document($doc)/translation/texts/item[@name='Inicio']/node()"/>&nbsp;/&nbsp;<span class="FinPath"><xsl:value-of select="document($doc)/translation/texts/item[@name='Procedimiento']/node()"/></span>
			<span class="CompletarTitulo">
			</span>
		</p>
		<p class="TituloPagina">
			<xsl:value-of select="/Procedimiento/PROCEDIMIENTO/CONVOCATORIA"/>
			&nbsp;&nbsp;
			<span class="CompletarTitulo">
				<!--
				<xsl:if test="/Procedimiento/PROCEDIMIENTO/MVM or /Procedimiento/PROCEDIMIENTO/CDC">
				<a class="btnDestacado" href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/','Nueva convocatoria',100,100,0,0)">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='nueva']/node()"/>
				</a>
				</xsl:if>
				-->
				<a class="btnDestacado" href="javascript:GuardarAdjudicacion();">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='guardar']/node()"/>
				</a>
				&nbsp;
				<a class="btnNormal" href="http://www.newco.dev.br/ProcesosCdC/ConvocatoriasEspeciales/Proveedores.xsql">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='Proveedores']/node()"/>
				</a>
				&nbsp;
				<a class="btnNormal" href="http://www.newco.dev.br/ProcesosCdC/ConvocatoriasEspeciales/BuscadorProcedimientos.xsql">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='Ver_procedimientos']/node()"/>
				</a>
				&nbsp;
				<a class="btnNormal" href="http://www.newco.dev.br/ProcesosCdC/ConvocatoriasEspeciales/BuscadorProductos.xsql">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='Ver_productos']/node()"/>
				</a>
			</span>
		</p>
	</div>
	<br/>
	<br/>
	<br/>
	
	
	<div class="divLeft">
		<form name="Procedimiento" method="post" action="http://www.newco.dev.br/ProcesosCdC/ConvocatoriasEspeciales/ProcedimientoYOfertas.xsql">
		<input type="hidden" name="ACCION" value=""/>
		<input type="hidden" name="PARAMETROS" value=""/>
		<input type="hidden" name="ORDEN" value="{/Procedimiento/PROCEDIMIENTO/ORDEN}"/>
		<input type="hidden" name="SENTIDO" value="{/Procedimiento/PROCEDIMIENTO/SENTIDO}"/>
		<table class="buscador" border="0">
		<tr class="sinLinea" style="height:30px;">
		<td width="300px" class="labelRight">
      		<label><xsl:value-of select="document($doc)/translation/texts/item[@name='Convocatoria']/node()"/>:&nbsp;</label>
		</td>
		<td width="450px" class="textLeft">
        	<xsl:call-template name="desplegable">
            	<xsl:with-param name="path" select="/Procedimiento/PROCEDIMIENTO/FIDCONVOCATORIA/field"/>
            	<xsl:with-param name="defecto" select="/Procedimiento/PROCEDIMIENTO/FIDCONVOCATORIA/field/@current"/>
            	<xsl:with-param name="style">width:400px;height:20px;</xsl:with-param>
            	<xsl:with-param name="onChange">javascript:CambioDesplegables('CAMBIO_CONVOCATORIA');</xsl:with-param>
        	</xsl:call-template>
		</td>
		<td width="*">
      		&nbsp;
		</td>
		</tr>
		<tr class="sinLinea" style="height:30px;">
		<td class="labelRight">
        	<label><xsl:value-of select="document($doc)/translation/texts/item[@name='Especialidad']/node()"/>:&nbsp;</label>
		</td>
		<td class="textLeft">
        	<xsl:call-template name="desplegable">
            	<xsl:with-param name="path" select="/Procedimiento/PROCEDIMIENTO/FIDESPECIALIDAD/field"/>
            	<xsl:with-param name="defecto" select="/Procedimiento/PROCEDIMIENTO/FIDESPECIALIDAD/field/@current"/>
            	<xsl:with-param name="style">width:400px;height:20px;</xsl:with-param>
            	<xsl:with-param name="onChange">javascript:CambioDesplegables('CAMBIO_ESPECIALIDAD');</xsl:with-param>
        	</xsl:call-template>
		</td>
		<td width="*">
      		&nbsp;
		</td>
		</tr>
		<tr class="sinLinea" style="height:30px;">
		<td class="labelRight">
        	<label><xsl:value-of select="document($doc)/translation/texts/item[@name='Procedimiento']/node()"/>:&nbsp;</label>
		</td>
		<td class="textLeft">
        	<xsl:call-template name="desplegable">
            	<xsl:with-param name="path" select="/Procedimiento/PROCEDIMIENTO/FIDPROCEDIMIENTO/field"/>
            	<xsl:with-param name="defecto" select="/Procedimiento/PROCEDIMIENTO/FIDPROCEDIMIENTO/field/@current"/>
            	<xsl:with-param name="style">width:400px;height:20px;</xsl:with-param>
            	<xsl:with-param name="onChange">javascript:CambioDesplegables('CAMBIO_PROCEDIMIENTO');</xsl:with-param>
        	</xsl:call-template>
		</td>
		<td width="*">
      		&nbsp;
		</td>
		</tr>
		</table>
		<BR/><BR/>
		<table class="buscador" border="0">
		<tr class="sinLinea" style="height:30px;">
		<td class="datosRight">
			<strong><xsl:value-of select="document($doc)/translation/texts/item[@name='Historico']/node()"/>:&nbsp;</strong>
		</td>
		<td class="datosLeft">
			<xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/>:&nbsp;<strong><xsl:value-of select="/Procedimiento/PROCEDIMIENTO/HISTORICO/PROVEEDOR"/></strong>&nbsp;
		</td>
		<!--
		<td class="textLeft">
			<xsl:value-of select="document($doc)/translation/texts/item[@name='marca']/node()"/>:&nbsp;<strong><xsl:value-of select="/Procedimiento/PROCEDIMIENTO/HISTORICO/LIC_CMP_MARCAACTUAL"/></strong>&nbsp;
		</td>
		-->
		<td class="textLeft">
			<xsl:value-of select="document($doc)/translation/texts/item[@name='consumo']/node()"/>:&nbsp;<strong><xsl:value-of select="/Procedimiento/PROCEDIMIENTO/HISTORICO/LIC_CMP_CONSUMOHISTORICO"/></strong>&nbsp;
		</td>
		<td class="textLeft">
			<xsl:value-of select="document($doc)/translation/texts/item[@name='Valor_factura']/node()"/>&nbsp;<strong><xsl:value-of select="/Procedimiento/PROCEDIMIENTO/HISTORICO/LIC_CMP_PRECIOREFERENCIA"/></strong>&nbsp;
		</td>
		<td class="textLeft">
			<xsl:value-of select="document($doc)/translation/texts/item[@name='Costo_neto']/node()"/>&nbsp;<strong><xsl:value-of select="/Procedimiento/PROCEDIMIENTO/HISTORICO/LIC_CMP_PRECIOREFERENCIADESC"/></strong>&nbsp;
		</td>
		<td class="textLeft veinte">
			&nbsp;
		</td>
		</tr>
		</table>
		
		<BR/>

		<!--<table class="grandeInicio" border="0">-->
		<table class="buscador" border="0">
		<thead>
			<tr class="subTituloTabla">
				<th align="left" class="uno">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='pos']/node()"/>.</th>
				<th align="left" class="veinte">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/></th>
				<th align="left" class="diez">&nbsp;<a href="javascript:Orden('ORDEN');"><xsl:value-of select="document($doc)/translation/texts/item[@name='Orden']/node()"/></a>&nbsp;<a href="javascript:OrdenAdjudicacionAutomatico();">[<xsl:value-of select="document($doc)/translation/texts/item[@name='Auto']/node()"/>]</a></th>
				<th align="left" class="diez">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='usuario']/node()"/></th>
				<th align="left" class="diez">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='fecha']/node()"/></th>
				<th align="left" class="diez">&nbsp;<a href="javascript:Orden('PRECIOFACTURA');"><xsl:value-of select="document($doc)/translation/texts/item[@name='Valor_factura']/node()"/></a></th>
				<th align="left" class="diez">&nbsp;<a href="javascript:Orden('REEMBCARTERA');"><xsl:value-of select="document($doc)/translation/texts/item[@name='Reembolso_cartera']/node()"/></a></th>
				<th align="left" class="diez">&nbsp;<a href="javascript:Orden('BONIFPRODUCTOS');"><xsl:value-of select="document($doc)/translation/texts/item[@name='Bonificacion_productos']/node()"/></a></th>
				<th align="left" class="diez">&nbsp;<a href="javascript:Orden('PRECIONETO');"><xsl:value-of select="document($doc)/translation/texts/item[@name='Costo_neto']/node()"/></a></th>
				<!--<th>&nbsp;</th>-->
			</tr>
		</thead>
        <xsl:choose>
		<xsl:when test="/Procedimiento/PROCEDIMIENTO/OFERTA">
			<xsl:for-each select="/Procedimiento/PROCEDIMIENTO/OFERTA">
				<tr id="PRO_{LIC_CEP_ID}">
                    <td>
						<xsl:value-of select="LINEA"/>
						<input type="hidden" name="REFCLIENTE_{LIC_CEP_ID}" value="{REFERENCIA}"/>
						<input type="hidden" name="PRECIO_{LIC_CEP_ID}" value="{PRECIO}"/>
						<input type="hidden" name="TOTALLINEA_{LIC_CEP_ID}" value="{TOTAL_LINEA}"/>
						<input type="hidden" name="CONT_{LIC_CEP_ID}" id="CONT_{LIC_CEP_ID}" value="{LINEA}"/>
					</td>
					<td class="datosLeft">&nbsp;<a href="javascript:VerProveedor('{LIC_CEP_IDPROVEEDOR}');"><xsl:value-of select="PROVEEDOR"/></a></td>
					<td>
        				<xsl:call-template name="desplegable">
            				<xsl:with-param name="path" select="ORDEN/field"/>
            				<xsl:with-param name="style">width:50px;</xsl:with-param>
            				<xsl:with-param name="nombre">ORDEN_<xsl:value-of select="LIC_CEP_ID"/></xsl:with-param>
            				<xsl:with-param name="id">ORDEN_<xsl:value-of select="LIC_CEP_ID"/></xsl:with-param>
        				</xsl:call-template>
					</td>
					<td class="datosLeft">&nbsp;<xsl:value-of select="USUARIO"/></td>
					<td >&nbsp;<xsl:value-of select="LIC_CEP_FECHA"/></td>
					<td class="datosRight">&nbsp;
						<strong>
							<xsl:choose>
							<xsl:when test="PRECIOBASE_MEJORPRECIO">
								<xsl:attribute name="class">azul</xsl:attribute>
							</xsl:when>
							<xsl:when test="PRECIOBASE_MASBARATO">
								<xsl:attribute name="class">verde</xsl:attribute>
							</xsl:when>
							<xsl:when test="PRECIOBASE_MASCARO">
								<xsl:attribute name="class">rojo</xsl:attribute>
							</xsl:when>
							</xsl:choose>
						<xsl:value-of select="LIC_CEP_PRECIOBASE"/>
						</strong>&nbsp;
					</td>
					<td class="datosRight">&nbsp;<strong><xsl:value-of select="LIC_CEP_REEMBCARTERA"/></strong>&nbsp;</td>
					<td class="datosRight">&nbsp;<strong><xsl:value-of select="LIC_CEP_BONIFICACIONPRODUCTO"/></strong>&nbsp;</td>
					<td class="datosRight">
						<strong>
							<xsl:choose>
							<xsl:when test="PRECIONETO_MEJORPRECIO">
								<xsl:attribute name="class">azul</xsl:attribute>
							</xsl:when>
							<xsl:when test="PRECIONETO_MASBARATO">
								<xsl:attribute name="class">verde</xsl:attribute>
							</xsl:when>
							<xsl:when test="PRECIONETO_MASCARO">
								<xsl:attribute name="class">rojo</xsl:attribute>
							</xsl:when>
							</xsl:choose>
						<xsl:value-of select="LIC_CEP_PRECIOBONIFICADO"/>
						</strong>&nbsp;
					</td>
				</tr>
			</xsl:for-each>
        </xsl:when>
		<xsl:otherwise>
			<tr><td colspan="15" align="center"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='no_se_han_encontrado_resultados']/node()"/></strong></td></tr>
		</xsl:otherwise>
		</xsl:choose>
		</table>
		</form>
        </div><!--fin de divLeft-->
	</xsl:otherwise>
        </xsl:choose>
</xsl:otherwise>
</xsl:choose>
</body>
</html>
</xsl:template>
</xsl:stylesheet>
