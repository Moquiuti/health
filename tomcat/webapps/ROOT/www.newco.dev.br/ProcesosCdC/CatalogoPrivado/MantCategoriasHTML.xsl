<?xml version="1.0" encoding="iso-8859-1"?>
<!--
	Mantenimiento de CATEGORIA
	Ultima revisión: ET 15jun20 17:45
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
			<xsl:when test="/Mantenimiento/LANG"><xsl:value-of select="/Mantenimiento/LANG"/></xsl:when>
			<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<title>
		<xsl:value-of select="document($doc)/translation/texts/item[@name='mant_de']/node()"/>
		<xsl:value-of select="Mantenimiento/CATEGORIA/NOMBRESNIVELES/NIVEL1"/>
		<xsl:value-of select="document($doc)/translation/texts/item[@name='de_productos']/node()"/>&nbsp;-&nbsp;
		<xsl:value-of select="document($doc)/translation/texts/item[@name='catalogo_privado']/node()"/>
        </title>
	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->

	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>

	<script type="text/javascript">
		var introducir_ref_nuevo_nivel1	= "<xsl:value-of select="document($doc)/translation/texts/item[@name='introducir_ref']/node()"/>";
		var length_ref_nuevo_nivel1	= "<xsl:value-of select="document($doc)/translation/texts/item[@name='length_ref']/node()"/>";
		var introducir_nombre_nivel1	= "<xsl:value-of select="document($doc)/translation/texts/item[@name='introducir_nombre']/node()"/>";
		var raros_alert			= "<xsl:value-of select="document($doc)/translation/texts/item[@name='caracteres_raros']/node()"/>";
		var ya_existe_ref_cliente	= "<xsl:value-of select="document($doc)/translation/texts/item[@name='existe_ref_cliente_nivel']/node()"/>";
		var nombre_nivel1		= "<xsl:value-of select="/Mantenimiento/CATEGORIA/NOMBRESNIVELES/NIVEL1"/>";

                <xsl:choose>
		<xsl:when test="Mantenimiento/CATEGORIA/NOMBRESNIVELES[@id='custom']">
			introducir_ref_nuevo_nivel1	+= "<xsl:value-of select="document($doc)/translation/texts/item[@name='nuevo_tipo']/node()"/>.";
			length_ref_nuevo_nivel1		+= "<xsl:value-of select="document($doc)/translation/texts/item[@name='nuevo_tipo']/node()"/>";
			introducir_nombre_nivel1	+= "<xsl:value-of select="document($doc)/translation/texts/item[@name='nuevo_tipo']/node()"/>.";
		</xsl:when>
                <xsl:when test="Mantenimiento/CATEGORIA/NOMBRESNIVELES[@id='estandar']">
			introducir_ref_nuevo_nivel1	+= "<xsl:value-of select="document($doc)/translation/texts/item[@name='nueva_categoria']/node()"/>.";
			length_ref_nuevo_nivel1		+= "<xsl:value-of select="document($doc)/translation/texts/item[@name='nueva_categoria']/node()"/>";
			introducir_nombre_nivel1	+= "<xsl:value-of select="document($doc)/translation/texts/item[@name='nueva_categoria']/node()"/>.";
		</xsl:when>
		</xsl:choose>
                
		length_ref_nuevo_nivel1	+= "<xsl:value-of select="document($doc)/translation/texts/item[@name='length_ref_nivel1']/node()"/>";

		chars_nivel1 = "<xsl:value-of select="Mantenimiento/CATEGORIA/CODIFICACIONNIVELES/NIVEL1"/>";
		leyenda_ref_nivel1	= "<xsl:value-of select="document($doc)/translation/texts/item[@name='leyenda_ref_categoria']/node()"/>";

		no_hay		= "<xsl:value-of select="document($doc)/translation/texts/item[@name='no_hay_datos']/node()"/>";
	</script>

	<script language="javascript">
		jQuery(document).ready(onloadEvents);

		function onloadEvents(){
			jQuery('span#ley_ref_categoria').html(leyenda_ref_nivel1.replace('[[CODE_NIVEL1]]', chars_nivel1));

			// Si se hace click sobre el icono de info
			jQuery('#toggleResumenCatalogo').click(function(){
				if(!jQuery("#ResumenCatalogo").is(':visible'))
					ResumenCatalogo();

				jQuery("#ResumenCatalogo").toggle("slow");
			});
		}
	</script>

	<xsl:text disable-output-escaping="yes">
	<![CDATA[
		<script language="javascript">
		<!--
		function ValidarRefCliente(oForm, Nivel){
			jQuery("#CATPRIV_REFCLIENTE").css("background-color", "#FFF");
			jQuery("#RefCliente_ERROR").hide();
			jQuery("#RefCliente_OK").hide();

			if(oForm.elements['CATPRIV_REFCLIENTE'].value == ''){
				jQuery("#CATPRIV_REFCLIENTE").css("background-color", "#F3F781");
				oForm.elements['CATPRIV_REFCLIENTE'].focus();
				alert(document.forms['MensajeJS'].elements['OBLI_REF_CLIENTE_PROD_ESTANDAR'].value);
				return;
			}else if(oForm.elements['CATPRIV_REFCLIENTE_AUX'].value == oForm.elements['CATPRIV_REFCLIENTE'].value){
				// La referencia no ha cambiado (es la misma)
				jQuery("#CATPRIV_REFCLIENTE").css("background-color", "#BCF5A9");
				jQuery("#RefCliente_OK").show();
				return;
			}

			var IDEmpresa	= jQuery('#CATPRIV_IDEMPRESA').val();
			var Referencia	= oForm.elements['CATPRIV_REFCLIENTE'].value;
			var ID		= oForm.elements['CATPRIV_IDCATEGORIA'].value;
			var d = new Date();

			jQuery.ajax({
				cache:	false,
				url:	'http://www.newco.dev.br/ProcesosCdC/CatalogoPrivado/ValidarRefClienteAJAX.xsql',
				type:	"GET",
				data:	"IDEMPRESA="+IDEmpresa+"&REFERENCIA="+Referencia+"&CP_ID="+ID+"&NIVEL="+Nivel+"&_="+d.getTime(),
				contentType: "application/xhtml+xml",
				success: function(objeto){
					var data = eval("(" + objeto + ")");

					if(data.estado == 'ERROR'){
						jQuery("#RefCliente_ERROR .text").html(ya_existe_ref_cliente.replace('[[NIVEL]]',nombre_nivel1));
						jQuery("#RefCliente_ERROR").show();
						jQuery("#CATPRIV_REFCLIENTE").css("background-color", "#F5A9A9");
						jQuery("#RefCliente_ERROR").show();
						oForm.elements['CATPRIV_REFCLIENTE'].focus();
					}else{
						// Si no hay error continuamos
						jQuery("#CATPRIV_REFCLIENTE").css("background-color", "#BCF5A9");
						jQuery("#RefCliente_OK").show();
					}
				},
				error: function(xhr, errorString, exception) {
					alert("xhr.status="+xhr.status+" error="+errorString+" exception="+exception);
				}
			});
		}

			function ValidarFormulario(form){
                                var regex_car_raros     = new RegExp("[\%|\$|\#|\\|\'|\&\|]","g"); //caracteres raros que no queremos en los campos de texto (requisito MVM)
                                var raros=0;
				var errores=0;
				for(var n=0;n<form.length;n++){
					if(form.elements[n].type=='text'){
						/* quitamos los espacios sobrantes  */
						form.elements[n].value=quitarEspacios(form.elements[n].value);
					}
				}

				if((!errores) && (esNulo(form.elements['CATPRIV_REFERENCIACATEGORIA'].value))){
					errores++;
					alert(introducir_ref_nuevo_nivel1);
					document.forms[0].elements['CATPRIV_REFERENCIACATEGORIA'].focus();
				}else if ((!errores) && (form.elements['CATPRIV_REFERENCIACATEGORIA'].value.length != chars_nivel1.length)){
					errores++;
					alert(length_ref_nuevo_nivel1.replace('[[DIGITO]]', chars_nivel1.length));
					document.forms[0].elements['CATPRIV_REFERENCIACATEGORIA'].focus();
				}

				if((!errores) && (esNulo(form.elements['CATPRIV_NOMBRE'].value))){
					errores++;
					alert(introducir_nombre_nivel1);
					document.forms[0].elements['CATPRIV_NOMBRE'].focus();
				}
                               
                                //control que no pongan caracteres raros en los textos
                                var inputText = [document.forms[0].elements['CATPRIV_REFERENCIACATEGORIA'].value,document.forms[0].elements['CATPRIV_NOMBRE'].value, document.forms[0].elements['CATPRIV_REFCLIENTE'].value];

                                for (var i=0;i<inputText.length;i++){
                                //var f=checkRegEx(inputText[i], regex_car_raros); alert ('valor f '+f);
                                    if(checkRegEx(inputText[i], regex_car_raros)){
                                        //si true implica que si ha encontrado caracteres raros
                                        errores=1; 
                                        raros=1;
                                    }
                                }//fin for caracteres raros
                                if (raros =='1') alert(raros_alert);
                                
				/* si los datos son correctos enviamos el form  */
				if(!errores){
                    jQuery(".btnestacado").hide();
					EnviarCambios(form)
				}
			}

			function EnviarCambios(form){
				SubmitForm(form);
			}

			function EjecutarFuncionDelFrame(nombreFrame,nombreFuncion){
				var objFrame=new Object();
				objFrame=obtenerFrame(top, nombreFrame);

				if(objFrame!=null){
					var retorno=eval('objFrame.'+nombreFuncion);
					if(retorno!=undefined){
						return retorno;
					}
				}
			}

			function RecargarInfoCatalogo(){
				EjecutarFuncionDelFrame('zonaCatalogo','CambioCategoriaActual('+jQuery('#CATPRIV_IDEMPRESA').val()+',document.forms[\'form1\'].elements[\'CATPRIV_IDCATEGORIA\'].value,\'CAMBIOCATEGORIA\');');
			}

			function ResumenCatalogo(){
				var IDEmpresa	= jQuery('#CATPRIV_IDEMPRESA').val();
				var d = new Date();

				jQuery.ajax({
					cache:	false,
					url:	'http://www.newco.dev.br/ProcesosCdC/CatalogoPrivado/ResumenCatalogo_ajax.xsql',
					type:	"GET",
					data:	"IDEMPRESA="+IDEmpresa+"&_="+d.getTime(),
					contentType: "application/xhtml+xml",
					success: function(objeto){
						var data = eval("(" + objeto + ")");

						if(data.Categorias){		// Tenemos 5 niveles
							// Nivel 1
							jQuery('tr#Nivel_1 td.total').html(data.Categorias.Total);
							jQuery('tr#Nivel_1 td.ref_cliente').html(data.Categorias.ReferenciaCliente ? data.Categorias.ReferenciaCliente : no_hay);
							jQuery('tr#Nivel_1 td.ref_mvm').html(data.Categorias.ReferenciaMVM);
							// Nivel 2
							jQuery('tr#Nivel_2 td.total').html(data.Familias.Total);
							jQuery('tr#Nivel_2 td.ref_cliente').html(data.Familias.ReferenciaCliente ? data.Familias.ReferenciaCliente : no_hay);
							jQuery('tr#Nivel_2 td.ref_mvm').html(data.Familias.ReferenciaMVM);
							// Nivel 3
							jQuery('tr#Nivel_3 td.total').html(data.Subfamilias.Total);
							jQuery('tr#Nivel_3 td.ref_cliente').html(data.Subfamilias.ReferenciaCliente ? data.Subfamilias.ReferenciaCliente : no_hay);
							jQuery('tr#Nivel_3 td.ref_mvm').html(data.Subfamilias.ReferenciaMVM);
							// Nivel 4
							jQuery('tr#Nivel_4 td.total').html(data.Grupos.Total);
							jQuery('tr#Nivel_4 td.ref_cliente').html(data.Grupos.ReferenciaCliente ? data.Grupos.ReferenciaCliente : no_hay);
							jQuery('tr#Nivel_4 td.ref_mvm').html(data.Grupos.ReferenciaMVM);
							// Nivel 5
							jQuery('tr#Nivel_5 td.total').html(data.ProductosEstandar.Total);
							jQuery('tr#Nivel_5 td.ref_cliente').html(data.ProductosEstandar.ReferenciaCliente ? data.ProductosEstandar.ReferenciaCliente : no_hay);
							jQuery('tr#Nivel_5 td.ref_mvm').html(data.ProductosEstandar.ReferenciaMVM);

						}else if(data.Familias){	// Tenemos 3 niveles
							null;
						}
					},
					error: function(xhr, errorString, exception) {
						alert("xhr.status="+xhr.status+" error="+errorString+" exception="+exception);
					}
				});
			}
		//-->
		</script>
	]]>
	</xsl:text>
</head>

<!--<body class="gris">-->
<body>
	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:choose>
			<xsl:when test="/Mantenimiento/LANG"><xsl:value-of select="/Mantenimiento/LANG"/></xsl:when>
			<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<xsl:choose>
		<xsl:when test="CarpetasYPlantillas/SESION_CADUCADA">
			<xsl:apply-templates select="CarpetasYPlantillas/SESION_CADUCADA"/>
		</xsl:when>
		<xsl:when test="CarpetasYPlantillas/ROWSET/ROW/Sorry">
			<xsl:apply-templates select="CarpetasYPlantillas/ROWSET/ROW/Sorry"/>
		</xsl:when>
		<xsl:otherwise>
			<xsl:if test="Mantenimiento/CATEGORIA/MENSAJE = 'OK'">
				<xsl:attribute name="onLoad">RecargarInfoCatalogo();</xsl:attribute>
			</xsl:if>
			<form name="form1" action="MantCategoriasSave.xsql" method="post">
			
				<!--	Titulo de la página		-->
				<div class="ZonaTituloPagina">
					<p class="Path"><xsl:value-of select="document($doc)/translation/texts/item[@name='Inicio']/node()"/>&nbsp;/&nbsp;<span class="FinPath">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='mant_de']/node()"/>
					<xsl:value-of select="Mantenimiento/CATEGORIA/NOMBRESNIVELES/NIVEL1"/>
					<xsl:value-of select="document($doc)/translation/texts/item[@name='de_productos']/node()"/>
					</span>
						<span class="CompletarTitulo">
						<xsl:if test="(/Mantenimiento/CATEGORIA/MASTER or /Mantenimiento/CATEGORIA/MASTER_UNICO) and /Mantenimiento/ACCION = 'MODIFICARCATEGORIA'">
							&nbsp;&nbsp;&nbsp;<span class="amarillo">CP_CAT_ID:&nbsp;<xsl:value-of select="/Mantenimiento/CATEGORIA/ID"/></span>
						</xsl:if>
						</span>
					</p>
					<p class="TituloPagina">
						<!--	Nombre de la categoría si ya existe o "Categoría" -->
						<xsl:choose>
							<xsl:when test="/Mantenimiento/CATEGORIA/REFERENCIA != ''">
								<xsl:value-of select="Mantenimiento/CATEGORIA/REFERENCIA"/>&nbsp;<xsl:value-of select="Mantenimiento/CATEGORIA/NOMBRE"/>
                            </xsl:when>
							<xsl:otherwise>	
								<xsl:value-of select="document($doc)/translation/texts/item[@name='mant_de']/node()"/>
								<xsl:value-of select="Mantenimiento/CATEGORIA/NOMBRESNIVELES/NIVEL1"/>
								<xsl:value-of select="document($doc)/translation/texts/item[@name='de_productos']/node()"/>
							</xsl:otherwise>							
						</xsl:choose>
								
						&nbsp;<a href="#" id="toggleResumenCatalogo" style="text-decoration:none;"><img src="http://www.newco.dev.br/images/info.gif"/></a>
						<xsl:if test="/Mantenimiento/CATEGORIA/MENSAJE">
							<xsl:choose>
								<xsl:when test="/Mantenimiento/CATEGORIA/MENSAJE='OK'">
                                	<xsl:value-of select="document($doc)/translation/texts/item[@name='cambios_guardados']/node()"/>
                                	:&nbsp;<xsl:value-of select="/Mantenimiento/CATEGORIA/FECHA"/>
									<!--&nbsp;-&nbsp;
                                	<xsl:value-of select="document($doc)/translation/texts/item[@name='datos_historicos']/node()"/>-->
                            	</xsl:when>
								<xsl:otherwise><xsl:value-of select="/Mantenimiento/CATEGORIA/MENSAJE"/>&nbsp;<xsl:value-of select="/Mantenimiento/CATEGORIA/FECHA"/></xsl:otherwise>
							</xsl:choose>
						</xsl:if>
						<span class="CompletarTitulo" style="width:400px;">
							<!--	Botones	-->
        					<a class="btnDestacado"  href="javascript:ValidarFormulario(document.forms[0]);">
            					<xsl:value-of select="document($doc)/translation/texts/item[@name='guardar']/node()"/>
            				</a>
							&nbsp;
        					<a class="btnNormal" href="javascript:document.location='about:blank'">
            					<xsl:value-of select="document($doc)/translation/texts/item[@name='cancelar']/node()"/>
            				</a>
							&nbsp;
						</span>
					</p>
				</div>
				<br/>
				<br/>
                <div class="divLeft">
				<div id="ResumenCatalogo" style="display:none;margin-bottom:20px;border-bottom:2px solid #3B5998;">
					<!--<table class="mediaTabla">-->
					<table class="buscador">
					<thead>
						<tr class="sinLinea">
							<th class="trenta">&nbsp;</th>
							<th class="doce"><xsl:value-of select="document($doc)/translation/texts/item[@name='nombre_nivel']/node()"/></th>
							<th class="dies"><xsl:value-of select="document($doc)/translation/texts/item[@name='total']/node()"/></th>
							<th class="dies"><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_cliente']/node()"/></th>
							<th class="dies"><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_mvm']/node()"/></th>
							<th class="">&nbsp;</th>
						</tr>
					</thead>

					<tbody>
						<xsl:if test="/Mantenimiento/CATEGORIA/NOMBRESNIVELES/NIVEL1">
						<tr id="Nivel_1">
							<td>&nbsp;</td>
							<td class="labelRight"><xsl:value-of select="/Mantenimiento/CATEGORIA/NOMBRESNIVELES/NIVEL1"/></td>
							<td class="total datosRight">&nbsp;</td>
							<td class="ref_cliente datosRight">&nbsp;</td>
							<td class="ref_mvm datosRight">&nbsp;</td>
							<td>&nbsp;</td>
						</tr>
						</xsl:if>

						<xsl:if test="/Mantenimiento/CATEGORIA/NOMBRESNIVELES/NIVEL2">
						<tr id="Nivel_2">
							<td>&nbsp;</td>
							<td class="labelRight"><xsl:value-of select="/Mantenimiento/CATEGORIA/NOMBRESNIVELES/NIVEL2"/></td>
							<td class="total datosRight">&nbsp;</td>
							<td class="ref_cliente datosRight">&nbsp;</td>
							<td class="ref_mvm datosRight">&nbsp;</td>
							<td>&nbsp;</td>
						</tr>
						</xsl:if>

						<xsl:if test="/Mantenimiento/CATEGORIA/NOMBRESNIVELES/NIVEL3">
						<tr id="Nivel_3">
							<td>&nbsp;</td>
							<td class="labelRight"><xsl:value-of select="/Mantenimiento/CATEGORIA/NOMBRESNIVELES/NIVEL3"/></td>
							<td class="total datosRight">&nbsp;</td>
							<td class="ref_cliente datosRight">&nbsp;</td>
							<td class="ref_mvm datosRight">&nbsp;</td>
							<td>&nbsp;</td>
						</tr>
						</xsl:if>

						<xsl:if test="/Mantenimiento/CATEGORIA/NOMBRESNIVELES/NIVEL4">
						<tr id="Nivel_4">
							<td>&nbsp;</td>
							<td class="labelRight"><xsl:value-of select="/Mantenimiento/CATEGORIA/NOMBRESNIVELES/NIVEL4"/></td>
							<td class="total datosRight">&nbsp;</td>
							<td class="ref_cliente datosRight">&nbsp;</td>
							<td class="ref_mvm datosRight">&nbsp;</td>
							<td>&nbsp;</td>
						</tr>
						</xsl:if>

						<tr id="Nivel_5">
							<td>&nbsp;</td>
							<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='Productos_estandar']/node()"/></td>
							<td class="total datosRight">&nbsp;</td>
							<td class="ref_cliente datosRight">&nbsp;</td>
							<td class="ref_mvm datosRight">&nbsp;</td>
							<td>&nbsp;</td>
						</tr>
					</tbody>
					</table>
				</div>

				<!--<table class="mediaTabla">-->
				<table class="buscador">
					<input type="hidden" name="CATPRIV_IDUSUARIO" VALUE="{Mantenimiento/US_ID}"/>
					<input type="hidden" name="CATPRIV_IDEMPRESA" VALUE="{Mantenimiento/CATPRIV_IDEMPRESA}" id="CATPRIV_IDEMPRESA"/>
					<input type="hidden" name="CATPRIV_IDCATEGORIA" value="{Mantenimiento/CATEGORIA/ID}"/>
					<input type="hidden" name="ACCION" VALUE="{Mantenimiento/ACCION}"/>

					<tr class="sinLinea">
						<td>&nbsp;</td>
						<td class="textLeft">
							<span class="rojo"><xsl:value-of select="document($doc)/translation/texts/item[@name='los_siguientes_caracteres_no_deben_sin_barra']/node()"/></span>
						</td>
					</tr>

					<tr class="sinLinea">
						<td class="labelRight trentacinco">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='referencia']/node()"/>:
							<xsl:if test="/Mantenimiento/ACCION = 'NUEVACATEGORIA'"> Tipo:<xsl:value-of select="Mantenimiento/TIPO"/> Bloqueado:<xsl:value-of select="Mantenimiento/CATEGORIA/BLOQUEADO"/>
								<span class="camposObligatorios">*</span>
							</xsl:if>
						</td>
						<td class="datosLeft sesanta">
							<xsl:choose>
								<!-- CONSULTA -->
								<xsl:when test="Mantenimiento/TIPO='CONSULTA' or Mantenimiento/CATEGORIA/BLOQUEADO">
									<xsl:value-of select="Mantenimiento/CATEGORIA/REFERENCIA"/>
									aqui3<input type="hidden" name="CATPRIV_REFERENCIACATEGORIA" value="{Mantenimiento/CATEGORIA/REFERENCIA}"/>
								</xsl:when>
								<!-- EDICION -->
								<xsl:otherwise>
									<xsl:choose>
									<xsl:when test="Mantenimiento/CATEGORIA/ID='0'">
										<input type="text" name="CATPRIV_REFERENCIACATEGORIA" value="{Mantenimiento/CATEGORIA/REFERENCIA}" size="4" maxlength="{string-length(Mantenimiento/CATEGORIA/CODIFICACIONNIVELES/NIVEL1)}"/>
										&nbsp;
										<!--<xsl:value-of select="document($doc)/translation/texts/item[@name='leyenda_ref_categoria']/node()"/>-->
										<span id="ley_ref_categoria">&nbsp;</span>
									</xsl:when>
									<xsl:otherwise>
                                        <xsl:value-of select="Mantenimiento/CATEGORIA/REFERENCIA" />
										<input type="hidden" name="CATPRIV_REFERENCIACATEGORIA" value="{Mantenimiento/CATEGORIA/REFERENCIA}" size="4" maxlength="{string-length(Mantenimiento/CATEGORIA/CODIFICACIONNIVELES/NIVEL1)}" />
										&nbsp;
										<xsl:value-of select="document($doc)/translation/texts/item[@name='para_modificar_consultar']/node()"/>
									</xsl:otherwise>
									</xsl:choose>
									<!--
									<xsl:choose>
										<!- - no puede modificar la ref, afecta a otros catalogos - ->
										<xsl:when test="(Mantenimiento/CATEGORIA/MASTER or Mantenimiento/CATEGORIA/MASTER_UNICO) or not (Mantenimiento/CATEGORIA/BLOQUEADO) ">
											<!- - solo puede crear nuevas ref - ->
											<xsl:choose>
												<xsl:when test="Mantenimiento/CATEGORIA/ID='0'">
													<input type="text" name="CATPRIV_REFERENCIACATEGORIA" value="{Mantenimiento/CATEGORIA/REFERENCIA}" size="4" maxlength="{string-length(Mantenimiento/CATEGORIA/CODIFICACIONNIVELES/NIVEL1)}"/>
													&nbsp;
													<!- -<xsl:value-of select="document($doc)/translation/texts/item[@name='leyenda_ref_categoria']/node()"/> - ->
													<span id="ley_ref_categoria">&nbsp;</span>
												</xsl:when>
												<xsl:otherwise>
                                                    <xsl:value-of select="Mantenimiento/CATEGORIA/REFERENCIA" />
													<input type="hidden" name="CATPRIV_REFERENCIACATEGORIA" value="{Mantenimiento/CATEGORIA/REFERENCIA}" size="4" maxlength="{string-length(Mantenimiento/CATEGORIA/CODIFICACIONNIVELES/NIVEL1)}" />
													&nbsp;
													<xsl:value-of select="document($doc)/translation/texts/item[@name='para_modificar_consultar']/node()"/>
												</xsl:otherwise>
											</xsl:choose>
										</xsl:when>
										<!- - no puede modificar la ref, depende de otros catalogos - ->
										<xsl:when test="Mantenimiento/FAMILIA/EDICION">
											<xsl:value-of select="Mantenimiento/CATEGORIA/REFERENCIA"/>
											<input type="hidden" name="CATPRIV_REFERENCIACATEGORIA" value="{Mantenimiento/CATEGORIA/REFERENCIA}"/>
										</xsl:when>
									</xsl:choose>
									-->
								</xsl:otherwise>
							</xsl:choose>
						</td>
					</tr>
					<tr class="sinLinea">
						<td class="labelRight">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='nombre']/node()"/>:
							<span class="camposObligatorios">*</span>
						</td>
						<td class="datosLeft">
							<xsl:choose>
								<xsl:when test="Mantenimiento/TIPO='CONSULTA' or Mantenimiento/CATEGORIA/BLOQUEADO">
									<xsl:value-of select="Mantenimiento/CATEGORIA/NOMBRE"/>
									<input type="hidden" name="CATPRIV_NOMBRE" value="{Mantenimiento/CATEGORIA/NOMBRE}"/>
								</xsl:when>
								<xsl:otherwise>
									<input type="text" class="muygrande" name="CATPRIV_NOMBRE" value="{Mantenimiento/CATEGORIA/NOMBRE}" size="50" maxlength="100"/>
								</xsl:otherwise>
							</xsl:choose>
						</td>
					</tr>
					<tr class="sinLinea">
						<td class="labelRight">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='ref_cliente']/node()"/>:
						</td>
						<td class="datosLeft">
							<xsl:choose>
								<xsl:when test="Mantenimiento/TIPO='CONSULTA' or Mantenimiento/CATEGORIA/BLOQUEADO">
									<xsl:value-of select="Mantenimiento/CATEGORIA/REFCLIENTE"/>
									<input type="hidden" name="CATPRIV_REFCLIENTE" id="CATPRIV_REFCLIENTE" value="{Mantenimiento/CATEGORIA/REFCLIENTE}"/>
								</xsl:when>
								<xsl:otherwise>
									<input type="hidden" name="CATPRIV_REFCLIENTE_AUX" id="CATPRIV_REFCLIENTE_AUX" value="{Mantenimiento/CATEGORIA/REFCLIENTE}"/>
									<input type="text" name="CATPRIV_REFCLIENTE" id="CATPRIV_REFCLIENTE" value="{Mantenimiento/CATEGORIA/REFCLIENTE}" size="10" maxlength="20"/>&nbsp;
									<a href="javascript:ValidarRefCliente(document.forms[0],'CATEGORIAS');" style="text-decoration:none;">
										<xsl:choose>
										<xsl:when test="/Mantenimiento/LANG = 'portugues'">
											<img src="http://www.newco.dev.br/images/comprobar-BR.gif" alt="Verificar"/>
										</xsl:when>
										<xsl:otherwise>
											<img src="http://www.newco.dev.br/images/comprobar.gif" alt="Comprobar"/>
										</xsl:otherwise>
										</xsl:choose>
									</a>
									<span id="RefCliente_OK" style="display:none;">&nbsp;
										<img src="http://www.newco.dev.br/images/recibido.gif">
											<xsl:attribute name="alt"><xsl:value-of select="document($doc)/translation/texts/item[@name='referencia_correcta']/node()"/></xsl:attribute>
										</img>
									</span>
									<span id="RefCliente_ERROR" style="color:#FE2E2E;display:none;">&nbsp;
										<img src="http://www.newco.dev.br/images/error.gif">
											<xsl:attribute name="alt"><xsl:value-of select="document($doc)/translation/texts/item[@name='existe_ref_cliente']/node()"/></xsl:attribute>
										</img>&nbsp;
										<span class="text"><xsl:value-of select="document($doc)/translation/texts/item[@name='existe_ref_cliente_nivel']/node()"/></span>
									</span>
								</xsl:otherwise>
							</xsl:choose>
						</td>
					</tr>
					<tr class="sinLinea">
						<td class="labelRight">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='Proveedores']/node()"/>:
						</td>
						<td class="datosLeft">
							<xsl:choose>
								<xsl:when test="Mantenimiento/TIPO='CONSULTA'">
									<xsl:value-of select="Mantenimiento/CATEGORIA/NOMBRESELECCION"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:call-template name="desplegable">
										<xsl:with-param name="path" select="Mantenimiento/CATEGORIA/CP_CAT_IDSELECCION/field"/>
									</xsl:call-template>
								</xsl:otherwise>
							</xsl:choose>
						</td>
					</tr>

					<tr class="sinLinea">
						<td>&nbsp;</td>
						<td colspan="2">&nbsp;</td>
						<td>&nbsp;</td>
					</tr>

					<tr class="sinLinea">
						<td>&nbsp;</td>
						<td colspan="2" class="textLeft">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='los_campos_marcados_con']/node()"/>
							&nbsp;
							(<span class="camposObligatorios">*</span>)
							&nbsp;
							<xsl:value-of select="document($doc)/translation/texts/item[@name='son_obligatorios']/node()"/>.
						</td>
					</tr>
				</table>

				<!--<table class="mediaTabla">
					<tr class="sinLinea">
						<td colspan="3">&nbsp;</td>
					</tr>
					<tr class="sinLinea">
						<td class="cinco">&nbsp;</td>
						<td align="center" class="dies">
							<div class="boton">
								<a href="javascript:ValidarFormulario(document.forms[0]);">
									<xsl:value-of select="document($doc)/translation/texts/item[@name='guardar']/node()"/>
								</a>
							</div>
						</td>
						<td align="center" class="veinte">&nbsp;</td>
					</tr>
				</table>-->
                </div><!--fin de divleft-->
			</form>
		</xsl:otherwise>
	</xsl:choose>
</body>
</html>
</xsl:template>
</xsl:stylesheet>
