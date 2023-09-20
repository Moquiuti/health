<?xml version="1.0" encoding="iso-8859-1"?>
<!--
	Mantenimiento de FAMILIA
	Ultima revisión: ET 8jun20 12:55
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
		<xsl:value-of select="Mantenimiento/FAMILIA/NOMBRESNIVELES/NIVEL2"/>
		<xsl:value-of select="document($doc)/translation/texts/item[@name='de_productos']/node()"/>&nbsp;-&nbsp;
		<xsl:value-of select="document($doc)/translation/texts/item[@name='catalogo_privado']/node()"/>
        </title>
	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->

	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>

	<script>
		var raros_alert			= "<xsl:value-of select="document($doc)/translation/texts/item[@name='caracteres_raros']/node()"/>";
		var no_hay			= "<xsl:value-of select="document($doc)/translation/texts/item[@name='no_hay_datos']/node()"/>";
		var leyenda_ref_nivel2		= "<xsl:value-of select="document($doc)/translation/texts/item[@name='leyenda_ref_familia']/node()"/>";
		var leyenda_ref_nivel2_3niveles	= "<xsl:value-of select="document($doc)/translation/texts/item[@name='leyenda_ref_familia_3niveles']/node()"/>";
		var chars_nivel2		= "<xsl:value-of select="Mantenimiento/FAMILIA/CODIFICACIONNIVELES/NIVEL2"/>";
		var ya_existe_ref_cliente	= "<xsl:value-of select="document($doc)/translation/texts/item[@name='existe_ref_cliente_nivel']/node()"/>";
		var nombre_nivel2		= "<xsl:value-of select="/Mantenimiento/FAMILIA/NOMBRESNIVELES/NIVEL2"/>";

		var length_nueva_ref_familia;
		<xsl:choose>
		<xsl:when test="/Mantenimiento/FAMILIA/CODIFICACIONNIVELES[@MostrarCategoria='S']">
			length_nueva_ref_familia	= <xsl:value-of select="string-length(/Mantenimiento/FAMILIA/CODIFICACIONNIVELES/NIVEL2) - string-length(/Mantenimiento/FAMILIA/CODIFICACIONNIVELES/NIVEL1)"/>;
		</xsl:when>
		<xsl:otherwise>
			length_nueva_ref_familia	= <xsl:value-of select="string-length(/Mantenimiento/FAMILIA/CODIFICACIONNIVELES/NIVEL2)"/>;
		</xsl:otherwise>
		</xsl:choose>

		var introducir_ref_nuevo_nivel2	= "<xsl:value-of select="document($doc)/translation/texts/item[@name='introducir_ref']/node()"/>";
		var length_ref_nuevo_nivel2	= "<xsl:value-of select="document($doc)/translation/texts/item[@name='length_ref']/node()"/>";
		var introducir_nombre_nivel2	= "<xsl:value-of select="document($doc)/translation/texts/item[@name='introducir_nombre']/node()"/>";
		var ya_existe_ref_nivel2	= "<xsl:value-of select="document($doc)/translation/texts/item[@name='ya_existe_ref']/node()"/>";
                <xsl:choose>
		<xsl:when test="Mantenimiento/FAMILIA/NOMBRESNIVELES[@id='custom']">
			introducir_ref_nuevo_nivel2	+= "<xsl:value-of select="document($doc)/translation/texts/item[@name='nuevo_grupo']/node()"/>.";
			length_ref_nuevo_nivel2		+= "<xsl:value-of select="document($doc)/translation/texts/item[@name='nuevo_grupo']/node()"/>";
			introducir_nombre_nivel2	+= "<xsl:value-of select="document($doc)/translation/texts/item[@name='nuevo_grupo']/node()"/>.";
			ya_existe_ref_nivel2		+= "<xsl:value-of select="document($doc)/translation/texts/item[@name='nuevo_grupo']/node()"/>";
		</xsl:when>
                <xsl:when test="Mantenimiento/FAMILIA/NOMBRESNIVELES[@id='estandar']">
			introducir_ref_nuevo_nivel2	+= "<xsl:value-of select="document($doc)/translation/texts/item[@name='nueva_familia']/node()"/>.";
			length_ref_nuevo_nivel2		+= "<xsl:value-of select="document($doc)/translation/texts/item[@name='nueva_familia']/node()"/>";
			introducir_nombre_nivel2	+= "<xsl:value-of select="document($doc)/translation/texts/item[@name='nueva_familia']/node()"/>.";
			ya_existe_ref_nivel2		+= "<xsl:value-of select="document($doc)/translation/texts/item[@name='nueva_familia']/node()"/>";
		</xsl:when>
                </xsl:choose>
                
                length_ref_nuevo_nivel2	+= "<xsl:value-of select="document($doc)/translation/texts/item[@name='length_ref_nivel2']/node()"/>";
	</script>

	<script language="javascript">
		jQuery(document).ready(onloadEvents);

		function onloadEvents(){
			// Si se cambia el desplegable de categorias
			jQuery('#CATPRIV_IDCATEGORIA').change(function(){
				UltimaRefFamiliaPorCat();
			});

			// Recuperamos la ultima ref.utilizada segun la categoria por defecto (caso 5 niveles)
			if(jQuery('#CATPRIV_IDCATEGORIA').length){
				UltimaRefFamiliaPorCat();
			}else{
				jQuery('span#ley_ref_familia').html(leyenda_ref_nivel2_3niveles.replace('[[CODE_NIVEL2]]', chars_nivel2).replace('[[DIGITO]]',chars_nivel2.length));
			}

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
			var ID		= oForm.elements['CATPRIV_IDFAMILIA'].value;
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
						jQuery("#RefCliente_ERROR .text").html(ya_existe_ref_cliente.replace('[[NIVEL]]',nombre_nivel2));
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

				/* quitamos los espacios sobrantes  */
				for(var n=0;n<form.length;n++){
					if(form.elements[n].type=='text'){
						form.elements[n].value=quitarEspacios(form.elements[n].value);
					}
				}

				if(form.elements['ACCION'].value == 'MODIFICARFAMILIA'){
					if((!errores) && (esNulo(form.elements['CATPRIV_REFERENCIAFAMILIA'].value))){
						errores++;
						alert(introducir_ref_nuevo_nivel2);
						document.forms[0].elements['CATPRIV_REFERENCIAFAMILIA'].focus();
					}else if ((!errores) && (form.elements['CATPRIV_REFERENCIAFAMILIA'].value.length != chars_nivel2.length)){
						errores++;
						alert(length_ref_nuevo_nivel2.replace('[[DIGITO]]', chars_nivel2.length));
						document.forms[0].elements['CATPRIV_REFERENCIAFAMILIA'].focus();
					}
				}else if(form.elements['ACCION'].value == 'NUEVAFAMILIA'){
					if(form.elements['CATPRIV_REFERENCIA_STRING2'].value == ''){
						document.forms[0].elements['CATPRIV_REFERENCIA_STRING2'].focus();
						alert(introducir_ref_nuevo_nivel2);
						return;
					}else if(form.elements['CATPRIV_REFERENCIA_STRING2'].value.length != length_nueva_ref_familia){
						// Comprobamos longitud de input CATPRIV_REFERENCIA_STRING2 (1 o 2 segun caracteres para codificacion de este nivel)
						document.forms[0].elements['CATPRIV_REFERENCIA_STRING2'].focus();
						alert(length_ref_nuevo_nivel2.replace('[[DIGITO]]', chars_nivel2.length));
						return;
					}else if(form.elements['CATPRIV_REFERENCIA_STRING2'].value.length == length_nueva_ref_familia){
						// Comprobamos formato de input CATPRIV_REFERENCIA_STRING2 (2 caracteres alfanumericos)
						var dosChars		= form.elements['CATPRIV_REFERENCIA_STRING2'].value;
						var regex_alfanum	= /^[0-9A-Z]+$/;	//caracteres alfanumericos (solo mayusculas)

						if(!checkRegEx(dosChars, regex_alfanum)){
							document.forms[0].elements['CATPRIV_REFERENCIA_STRING2'].focus();
							alert(length_ref_nuevo_nivel2.replace('[[DIGITO]]', chars_nivel2.length));
							return;
						}

						form.elements['CATPRIV_REFERENCIAFAMILIA'].value = form.elements['CATPRIV_REFERENCIA_STRING1'].value + form.elements['CATPRIV_REFERENCIA_STRING2'].value;
					}
				}

				if((!errores) && (esNulo(form.elements['CATPRIV_NOMBRE'].value))){
					errores++;
					alert(introducir_nombre_nivel2);
					document.forms[0].elements['CATPRIV_NOMBRE'].focus();
				}
                    
                                //control que no pongan caracteres raros en los textos
                                var inputText = [document.forms[0].elements['CATPRIV_REFERENCIAFAMILIA'].value,document.forms[0].elements['CATPRIV_NOMBRE'].value, document.forms[0].elements['CATPRIV_REFCLIENTE'].value];

                                for (var i=0;i<inputText.length;i++){
                                    if(checkRegEx(inputText[i], regex_car_raros)){
                                        //si true implica que si ha encontrado caracteres raros
                                        errores=1; 
                                        raros=1;
                                    }
                                   
                                }//fin for caracteres raros
                                if (raros =='1') alert(raros_alert);

				/* si los datos son correctos enviamos el form  */
				if(!errores){
                    jQuery(".btnDestacado").hide();
					EnviarCambios(form)
				}
			}

			function EnviarCambios(form){
				SubmitForm(form);
			}

			function EjecutarFuncionDelFrame(nombreFrame,nombreFuncion){
				var objFrame=new Object();
				// PS 20170125 objFrame=obtenerFrame(top, nombreFrame);
				objFrame=parent.nombreFrame;

				if(objFrame!=null){
					var retorno=eval('objFrame.'+nombreFuncion);
					if(retorno!=undefined){
						return retorno;
					}
				}
			}

			function RecargarInfoCatalogo(){
				EjecutarFuncionDelFrame('zonaCatalogo','CambioFamiliaActual('+jQuery('#CATPRIV_IDEMPRESA').val()+',document.forms[\'form1\'].elements[\'CATPRIV_IDFAMILIA\'].value,\'CAMBIOFAMILIA\');');
			}

			function UltimaRefFamiliaPorCat(){
				var IDEmpresa	= jQuery('#CATPRIV_IDEMPRESA').val();
				var IDCategoria	= jQuery('#CATPRIV_IDCATEGORIA').val();
				var d = new Date();

				jQuery.ajax({
					cache:	false,
					url:	'http://www.newco.dev.br/ProcesosCdC/CatalogoPrivado/UltimaRefFamiliaPorCat_ajax.xsql',
					type:	"GET",
					data:	"IDEMPRESA="+IDEmpresa+"&IDCATEGORIA="+IDCategoria+"&_="+d.getTime(),
					contentType: "application/xhtml+xml",
					success: function(objeto){
						var data = eval("(" + objeto + ")");

						if(data.UltimaReferenciaMVM != '')
							jQuery('span#ley_ref_familia').html(leyenda_ref_nivel2.replace('[[REF_MVM]]', data.UltimaReferenciaMVM).replace('[[CODE_NIVEL2]]', chars_nivel2).replace('[[DIGITO]]',chars_nivel2.length));

						if(data.UltimaReferenciaCliente != '')
							jQuery('span#UltimaRefCliente').html(data.UltimaReferenciaCliente);
						else
							jQuery('span#UltimaRefCliente').html(no_hay);

						// Lanzamos la funcion ajax que devuelve la ref de categoria
						if(document.forms[0].elements['ACCION'].value == 'NUEVAFAMILIA')
							ReferenciaCategoria();
					},
					error: function(xhr, errorString, exception) {
						alert("xhr.status="+xhr.status+" error="+errorString+" exception="+exception);
					}
				});
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
							// Nivel 1
							jQuery('tr#Nivel_1').hide();
							// Nivel 2
							jQuery('tr#Nivel_2 td.total').html(data.Familias.Total);
							jQuery('tr#Nivel_2 td.ref_cliente').html(data.Familias.ReferenciaCliente ? data.Familias.ReferenciaCliente : no_hay);
							jQuery('tr#Nivel_2 td.ref_mvm').html(data.Familias.ReferenciaMVM);
							// Nivel 3
							jQuery('tr#Nivel_3 td.total').html(data.Subfamilias.Total);
							jQuery('tr#Nivel_3 td.ref_cliente').html(data.Subfamilias.ReferenciaCliente ? data.Subfamilias.ReferenciaCliente : no_hay);
							jQuery('tr#Nivel_3 td.ref_mvm').html(data.Subfamilias.ReferenciaMVM);
							// Nivel 4
							jQuery('tr#Nivel_4').hide();
							// Nivel 5
							jQuery('tr#Nivel_5 td.total').html(data.ProductosEstandar.Total);
							jQuery('tr#Nivel_5 td.ref_cliente').html(data.ProductosEstandar.ReferenciaCliente ? data.ProductosEstandar.ReferenciaCliente : no_hay);
							jQuery('tr#Nivel_5 td.ref_mvm').html(data.ProductosEstandar.ReferenciaMVM);
						}
					},
					error: function(xhr, errorString, exception) {
						alert("xhr.status="+xhr.status+" error="+errorString+" exception="+exception);
					}
				});
			}

			function ReferenciaCategoria(){
				var IDCategoria	= jQuery('#CATPRIV_IDCATEGORIA').val();
				var d		= new Date();

				jQuery.ajax({
					cache:	false,
					url:	'http://www.newco.dev.br/ProcesosCdC/CatalogoPrivado/ReferenciaCategoriaAJAX.xsql',
					type:	"GET",
					data:	"IDCATEGORIA="+IDCategoria+"&_="+d.getTime(),
					contentType: "application/xhtml+xml",
					success: function(objeto){
						var data = eval("(" + objeto + ")");

						if(data.ReferenciaCategoria.estado == 'ERROR'){
							null;
						}else{
							// Si no hay error mostramos la RefCategoria donde toca
							jQuery("#CATPRIV_REFERENCIA_TXT").val(data.ReferenciaCategoria.RefCategoria);
							jQuery("#CATPRIV_REFERENCIA_STRING1").val(data.ReferenciaCategoria.RefCategoria);
						}
					},
					error: function(xhr, errorString, exception) {
						alert("xhr.status="+xhr.status+" error="+errorString+" exception="+exception);
					}
				});
			}

			function ValidarRefFamilia(oForm){
				jQuery("#CATPRIV_REF").css("background-color", "#FFF");
				jQuery("#RefFamilia_ERROR").hide();
				jQuery("#RefFamilia_OK").hide();

				if(oForm.elements['CATPRIV_REFERENCIA_STRING2'].value == ''){
					jQuery("#CATPRIV_REF").css("background-color", "#F3F781");
					oForm.elements['CATPRIV_REFERENCIA_STRING2'].focus();
					alert(introducir_ref_nuevo_nivel2);
					return;
				}else if(oForm.elements['CATPRIV_REFERENCIA_AUX'].value == oForm.elements['CATPRIV_REFERENCIA_STRING1'].value + oForm.elements['CATPRIV_REFERENCIA_STRING2'].value){
					// La referencia no ha cambiado (es la misma)
					jQuery("#CATPRIV_REF").css("background-color", "#BCF5A9");
					jQuery("#RefFamilia_OK").show();
					return;
				}else if(oForm.elements['CATPRIV_REFERENCIA_STRING2'].value.length != length_nueva_ref_familia){
					// Comprobamos longitud de input CATPRIV_REFERENCIA_STRING2 (2 o 3 segun caracteres para codificacion de este nivel)
					jQuery("#CATPRIV_REF").css("background-color", "#F3F781");
					oForm.elements['CATPRIV_REFERENCIA_STRING2'].focus();
					alert(length_ref_nuevo_nivel2.replace('[[DIGITO]]', chars_nivel2.length));
					return;
				}else if(oForm.elements['CATPRIV_REFERENCIA_STRING2'].value.length == length_nueva_ref_familia){
					// Comprobamos formato de input CATPRIV_REFERENCIA_STRING2 (2 caracteres alfanumericos)
					var dosChars		= oForm.elements['CATPRIV_REFERENCIA_STRING2'].value;
					var regex_alfanum	= /^[0-9A-Z]+$/;	//caracteres alfanumericos (solo mayusculas)

					if(!checkRegEx(dosChars, regex_alfanum)){
						jQuery("#CATPRIV_REF").css("background-color", "#F3F781");
						oForm.elements['CATPRIV_REFERENCIA_STRING2'].focus();
						alert(length_ref_nuevo_nivel2.replace('[[DIGITO]]', chars_nivel2.length));
						return;
					}
				}

				var IDEmpresa	= jQuery('#CATPRIV_IDEMPRESA').val();
				var IDCategoria	= jQuery('#CATPRIV_IDCATEGORIA').val();
				var Referencia	= oForm.elements['CATPRIV_REFERENCIA_STRING1'].value + oForm.elements['CATPRIV_REFERENCIA_STRING2'].value;
				var d = new Date();

				jQuery.ajax({
					cache:	false,
					url:	'http://www.newco.dev.br/ProcesosCdC/CatalogoPrivado/ValidarRefFamiliaAJAX.xsql',
					type:	"GET",
					data:	"IDEMPRESA="+IDEmpresa+"&REFERENCIA="+Referencia+"&_="+d.getTime(),
					contentType: "application/xhtml+xml",
					success: function(objeto){
						var data = eval("(" + objeto + ")");

						if(data.estado == 'ERROR'){
							jQuery("#CATPRIV_REF").css("background-color", "#F5A9A9");
							jQuery("#RefFamilia_ERROR_TXT").html(ya_existe_ref_nivel2.replace('[[REF]]',Referencia));
							jQuery("#RefFamilia_ERROR").show();
							oForm.elements['CATPRIV_REFERENCIA_STRING2'].focus();
						}else{
							// Si no hay error continuamos
							jQuery("#CATPRIV_REF").css("background-color", "#BCF5A9");
							jQuery("#RefFamilia_OK").show();
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
<!-- Si es el alta de un nuevo grupo -->
<!--
<xsl:if test="/Mantenimiento/FAMILIA/ID = 0 and (/Mantenimiento/FAMILIA/MASTER or /Mantenimiento/FAMILIA/MASTER_UNICO)">
	<xsl:attribute name="onload">ReferenciaCategoria()</xsl:attribute>
</xsl:if>
-->

	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:choose>
			<xsl:when test="/Mantenimiento/LANG"><xsl:value-of select="/Mantenimiento/LANG" /></xsl:when>
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
			<xsl:if test="Mantenimiento/FAMILIA/MENSAJE = 'OK'">
				<xsl:attribute name="onLoad">RecargarInfoCatalogo();</xsl:attribute>
			</xsl:if>

			<form name="form1" action="MantFamiliasSave.xsql" method="post">

				<!--	Titulo de la página		-->
				<div class="ZonaTituloPagina">
					<p class="Path"><xsl:value-of select="document($doc)/translation/texts/item[@name='Inicio']/node()"/>&nbsp;/&nbsp;<span class="FinPath">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='mant_de']/node()"/>
					<xsl:value-of select="Mantenimiento/FAMILIA/NOMBRESNIVELES/NIVEL2"/>
					<xsl:value-of select="document($doc)/translation/texts/item[@name='de_productos']/node()"/>
					</span>
						<span class="CompletarTitulo">
						<xsl:if test="(/Mantenimiento/FAMILIA/MASTER or /Mantenimiento/FAMILIA/MASTER_UNICO) and /Mantenimiento/ACCION = 'MODIFICARFAMILIA'">
							&nbsp;&nbsp;&nbsp;<span class="amarillo">CP_FAM_ID:&nbsp;<xsl:value-of select="/Mantenimiento/FAMILIA/ID"/></span>
						</xsl:if>
						</span>
					</p>
					<p class="TituloPagina">
						<!--	Nombre de la categoría si ya existe o "Categoría" -->
						<xsl:choose>
							<xsl:when test="/Mantenimiento/FAMILIA/REFERENCIA != ''">
								<xsl:value-of select="Mantenimiento/FAMILIA/REFERENCIA"/>&nbsp;<xsl:value-of select="Mantenimiento/FAMILIA/NOMBRE"/>
                            </xsl:when>
							<xsl:otherwise>	
								<xsl:value-of select="document($doc)/translation/texts/item[@name='mant_de']/node()"/>
								<xsl:value-of select="Mantenimiento/FAMILIA/NOMBRESNIVELES/NIVEL2"/>
								<xsl:value-of select="document($doc)/translation/texts/item[@name='de_productos']/node()"/>
							</xsl:otherwise>							
						</xsl:choose>
								
						&nbsp;<a href="#" id="toggleResumenCatalogo" style="text-decoration:none;"><img src="http://www.newco.dev.br/images/info.gif"/></a>
						<xsl:if test="/Mantenimiento/FAMILIA/MENSAJE">
							<xsl:choose>
								<xsl:when test="/Mantenimiento/FAMILIA/MENSAJE='OK'">
                                	<xsl:value-of select="document($doc)/translation/texts/item[@name='cambios_guardados']/node()"/>
                                	:&nbsp;<xsl:value-of select="/Mantenimiento/FAMILIA/FECHA"/>
									<!--&nbsp;-&nbsp;
                                	<xsl:value-of select="document($doc)/translation/texts/item[@name='datos_historicos']/node()"/>-->
                            	</xsl:when>
								<xsl:otherwise><xsl:value-of select="/Mantenimiento/FAMILIA/MENSAJE"/>&nbsp;<xsl:value-of select="/Mantenimiento/FAMILIA/FECHA"/></xsl:otherwise>
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


				            
                <div clasS="divLeft">
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
						<xsl:if test="/Mantenimiento/FAMILIA/NOMBRESNIVELES/NIVEL1">
						<tr id="Nivel_1">
							<td>&nbsp;</td>
							<td class="labelRight"><xsl:value-of select="/Mantenimiento/FAMILIA/NOMBRESNIVELES/NIVEL1"/></td>
							<td class="total datosRight">&nbsp;</td>
							<td class="ref_cliente datosRight">&nbsp;</td>
							<td class="ref_mvm datosRight">&nbsp;</td>
							<td>&nbsp;</td>
						</tr>
						</xsl:if>

						<xsl:if test="/Mantenimiento/FAMILIA/NOMBRESNIVELES/NIVEL2">
						<tr id="Nivel_2">
							<td>&nbsp;</td>
							<td class="labelRight"><xsl:value-of select="/Mantenimiento/FAMILIA/NOMBRESNIVELES/NIVEL2"/></td>
							<td class="total datosRight">&nbsp;</td>
							<td class="ref_cliente datosRight">&nbsp;</td>
							<td class="ref_mvm datosRight">&nbsp;</td>
							<td>&nbsp;</td>
						</tr>
						</xsl:if>

						<xsl:if test="/Mantenimiento/FAMILIA/NOMBRESNIVELES/NIVEL3">
						<tr id="Nivel_3">
							<td>&nbsp;</td>
							<td class="labelRight"><xsl:value-of select="/Mantenimiento/FAMILIA/NOMBRESNIVELES/NIVEL3"/></td>
							<td class="total datosRight">&nbsp;</td>
							<td class="ref_cliente datosRight">&nbsp;</td>
							<td class="ref_mvm datosRight">&nbsp;</td>
							<td>&nbsp;</td>
						</tr>
						</xsl:if>

						<xsl:if test="/Mantenimiento/FAMILIA/NOMBRESNIVELES/NIVEL4">
						<tr id="Nivel_4">
							<td>&nbsp;</td>
							<td class="labelRight"><xsl:value-of select="/Mantenimiento/FAMILIA/NOMBRESNIVELES/NIVEL4"/></td>
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
					<input type="hidden" name="CATPRIV_IDFAMILIA" value="{Mantenimiento/FAMILIA/ID}"/>
					<input type="hidden" name="ACCION" VALUE="{Mantenimiento/ACCION}"/>

					<tr class="sinLinea">
						<td>&nbsp;</td>
						<td class="textLeft"><span class="rojo"><xsl:value-of select="document($doc)/translation/texts/item[@name='los_siguientes_caracteres_no_deben_sin_barra']/node()"/></span></td>
					</tr>

					<xsl:choose>
						<xsl:when test="Mantenimiento/FAMILIA/CATEGORIAS">
							<!-- SELECT DE CATEGORIAS -->
							<tr class="sinLinea">
								<td class="labelRight trentacinco">
									<xsl:value-of select="Mantenimiento/FAMILIA/NOMBRESNIVELES/NIVEL1"/>
									<xsl:value-of select="document($doc)/translation/texts/item[@name='de_productos']/node()"/>:
									<xsl:if test="/Mantenimiento/ACCION = 'NUEVAFAMILIA'">
										<span class="camposObligatorios">*</span>
									</xsl:if>
								</td>
								<td class="datosLeft sesenta">
									<xsl:choose>
										<!-- solo consulta -->
										<xsl:when test="Mantenimiento/TIPO='CONSULTA' or Mantenimiento/FAMILIA/BLOQUEADO">
											<xsl:for-each select="Mantenimiento/FAMILIA/CATEGORIAS/field/dropDownList/listElem">
												<xsl:if test="ID=../../@current">
													<xsl:value-of select="listItem"/>
												</xsl:if>
											</xsl:for-each>
										</xsl:when>
										<!-- edicion -->
										<xsl:otherwise>
											<xsl:choose>
											<xsl:when test="Mantenimiento/FAMILIA/ID='0'">
												<xsl:call-template name="desplegable">
													<xsl:with-param name="path" select="Mantenimiento/FAMILIA/CATEGORIAS/field"></xsl:with-param>
												</xsl:call-template>
											</xsl:when>
											<!-- modificacion -->
											<xsl:otherwise>
												<xsl:call-template name="desplegable_disabled">
													<xsl:with-param name="path" select="Mantenimiento/FAMILIA/CATEGORIAS/field"></xsl:with-param>
												</xsl:call-template>
											</xsl:otherwise>
											</xsl:choose>

<!--
											<xsl:choose>
												<!- - no puede modificar la familia de la que depende o puede crear nuevas subfamilias - ->
												<xsl:when test="Mantenimiento/FAMILIA/MASTER or Mantenimiento/FAMILIA/MASTER_UNICO">
													<!- - nueva - ->
													<xsl:choose>
														<xsl:when test="Mantenimiento/FAMILIA/ID='0'">
															<xsl:call-template name="desplegable">
																<xsl:with-param name="path" select="Mantenimiento/FAMILIA/CATEGORIAS/field"></xsl:with-param>
															</xsl:call-template>
														</xsl:when>
														<!- - modificacion - ->
														<xsl:otherwise>
															<xsl:call-template name="desplegable_disabled">
																<xsl:with-param name="path" select="Mantenimiento/FAMILIA/CATEGORIAS/field"></xsl:with-param>
															</xsl:call-template>
														</xsl:otherwise>
													</xsl:choose>
												</xsl:when>
												<!- - no puede modificar la familia de la que depende - ->
												<xsl:when test="Mantenimiento/FAMILIA/EDICION">
													<xsl:for-each select="Mantenimiento/FAMILIA/CATEGORIAS/field/dropDownList/listElem">
														<xsl:if test="ID=../../@current">
															<xsl:value-of select="listItem"/>
															<input type="hidden" name="CATPRIV_IDCATEGORIA" value="{ID}"/>
														</xsl:if>
													</xsl:for-each>
												</xsl:when>
											</xsl:choose>
											-->
										</xsl:otherwise>
									</xsl:choose>
								</td>
							</tr>
							<!-- FIN SELECT DE CATEGORIAS -->
						</xsl:when>
						<xsl:otherwise>
							<input type="hidden" name="CATPRIV_IDCATEGORIA" value="{Mantenimiento/FAMILIA/IDCATEGORIA}"/>
						</xsl:otherwise>
					</xsl:choose>

					<tr class="sinLinea">
						<td class="labelRight trentacinco">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='referencia']/node()"/>
							<xsl:if test="/Mantenimiento/ACCION = 'NUEVAFAMILIA'">
								<span class="camposObligatorios">*</span>
							</xsl:if>:&nbsp;
						</td>
						<td class="datosLeft sesanta">
							<xsl:choose>
								<!-- CONSULTA -->
								<xsl:when test="Mantenimiento/TIPO='CONSULTA' or Mantenimiento/FAMILIA/BLOQUEADO">
									<xsl:value-of select="Mantenimiento/FAMILIA/REFERENCIA"/>
									<input type="hidden" name="CATPRIV_REFERENCIAFAMILIA" value="{Mantenimiento/FAMILIA/REFERENCIA}"/>
								</xsl:when>
								<!-- EDICION -->
								<xsl:otherwise>
									<xsl:choose>
										<xsl:when test="Mantenimiento/FAMILIA/ID='0'">
											<xsl:if test="/Mantenimiento/FAMILIA/CODIFICACIONNIVELES[@MostrarCategoria='S']">
												<input type="text" name="CATPRIV_REFERENCIA_TXT" id="CATPRIV_REFERENCIA_TXT" disabled="disabled" class="noinput muypeq" size="1"/>
											</xsl:if>
											<input type="hidden" name="CATPRIV_REFERENCIA_STRING1" id="CATPRIV_REFERENCIA_STRING1"/>
											<input type="text" class="peq" id="CATPRIV_REF" name="CATPRIV_REFERENCIA_STRING2" size="1">
												<xsl:choose>
												<xsl:when test="/Mantenimiento/FAMILIA/CODIFICACIONNIVELES[@MostrarCategoria='S']">
													<xsl:attribute name="maxlength"><xsl:value-of select="string-length(/Mantenimiento/FAMILIA/CODIFICACIONNIVELES/NIVEL2) - string-length(/Mantenimiento/FAMILIA/CODIFICACIONNIVELES/NIVEL1)"/></xsl:attribute>
												</xsl:when>
												<xsl:otherwise>
													<xsl:attribute name="maxlength"><xsl:value-of select="string-length(/Mantenimiento/FAMILIA/CODIFICACIONNIVELES/NIVEL2)"/></xsl:attribute>
												</xsl:otherwise>
												</xsl:choose>
											</input>&nbsp;
											<input type="hidden" name="CATPRIV_REFERENCIA_AUX"/>
											<input type="hidden" name="CATPRIV_REFERENCIAFAMILIA"/>&nbsp;
											<a href="javascript:ValidarRefFamilia(document.forms[0]);" style="text-decoration:none;">
												<xsl:choose>
												<xsl:when test="/Mantenimiento/LANG = 'portugues'">
													<img src="http://www.newco.dev.br/images/comprobar-BR.gif" alt="Verificar"/>
												</xsl:when>
												<xsl:otherwise>
													<img src="http://www.newco.dev.br/images/comprobar.gif" alt="Comprobar"/>
												</xsl:otherwise>
												</xsl:choose>
											</a>
											<span id="RefFamilia_OK" style="display:none;">&nbsp;
												<img src="http://www.newco.dev.br/images/recibido.gif">
													<xsl:attribute name="alt"><xsl:value-of select="document($doc)/translation/texts/item[@name='referencia_correcta']/node()"/></xsl:attribute>
                                        		</img>
											</span>
											<span id="RefFamilia_ERROR" style="color:#FE2E2E;display:none;">&nbsp;
												<img src="http://www.newco.dev.br/images/error.gif">
													<xsl:attribute name="alt"><xsl:value-of select="document($doc)/translation/texts/item[@name='existe_referencia']/node()"/></xsl:attribute>
                                        					                        </img>&nbsp;
												<span id="RefFamilia_ERROR_TXT"><xsl:value-of select="document($doc)/translation/texts/item[@name='ya_existe_ref']/node()"/></span>
											</span><br />
											<span id="ley_ref_familia">&nbsp;</span>
										</xsl:when>
										<xsl:otherwise>
                                            <xsl:value-of select="Mantenimiento/FAMILIA/REFERENCIA"/>
											<input type="hidden" name="CATPRIV_REFERENCIAFAMILIA" value="{Mantenimiento/FAMILIA/REFERENCIA}" size="4" maxlength="{string-length(Mantenimiento/FAMILIA/CODIFICACIONNIVELES/NIVEL2)}"/>
											&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='para_modificar_consultar']/node()"/>
										</xsl:otherwise>
									</xsl:choose>
								</xsl:otherwise>
							</xsl:choose>


									<!--
									<xsl:choose>
										
										<!- - no puede modificar la ref, afecta a otros catalogos - ->
										<xsl:when test="Mantenimiento/FAMILIA/MASTER or Mantenimiento/FAMILIA/MASTER_UNICO">
											<!- - solo puede crear nuevas ref  - ->
											<xsl:choose>
												<xsl:when test="Mantenimiento/FAMILIA/ID='0'">
													<xsl:if test="/Mantenimiento/FAMILIA/CODIFICACIONNIVELES[@MostrarCategoria='S']">
														<input type="text" name="CATPRIV_REFERENCIA_TXT" id="CATPRIV_REFERENCIA_TXT" disabled="disabled" class="noinput muypeq" size="1"/>
													</xsl:if>
													<input type="hidden" name="CATPRIV_REFERENCIA_STRING1" id="CATPRIV_REFERENCIA_STRING1"/>
													<input type="text" class="peq" id="CATPRIV_REF" name="CATPRIV_REFERENCIA_STRING2" size="1">
														<xsl:choose>
														<xsl:when test="/Mantenimiento/FAMILIA/CODIFICACIONNIVELES[@MostrarCategoria='S']">
															<xsl:attribute name="maxlength"><xsl:value-of select="string-length(/Mantenimiento/FAMILIA/CODIFICACIONNIVELES/NIVEL2) - string-length(/Mantenimiento/FAMILIA/CODIFICACIONNIVELES/NIVEL1)"/></xsl:attribute>
														</xsl:when>
														<xsl:otherwise>
															<xsl:attribute name="maxlength"><xsl:value-of select="string-length(/Mantenimiento/FAMILIA/CODIFICACIONNIVELES/NIVEL2)"/></xsl:attribute>
														</xsl:otherwise>
														</xsl:choose>
													</input>&nbsp;
													<input type="hidden" name="CATPRIV_REFERENCIA_AUX"/>
													<input type="hidden" name="CATPRIV_REFERENCIAFAMILIA"/>&nbsp;
													<a href="javascript:ValidarRefFamilia(document.forms[0]);" style="text-decoration:none;">
														<xsl:choose>
														<xsl:when test="/Mantenimiento/LANG = 'portugues'">
															<img src="http://www.newco.dev.br/images/comprobar-BR.gif" alt="Verificar"/>
														</xsl:when>
														<xsl:otherwise>
															<img src="http://www.newco.dev.br/images/comprobar.gif" alt="Comprobar"/>
														</xsl:otherwise>
														</xsl:choose>
													</a>
													<span id="RefFamilia_OK" style="display:none;">&nbsp;
														<img src="http://www.newco.dev.br/images/recibido.gif">
															<xsl:attribute name="alt"><xsl:value-of select="document($doc)/translation/texts/item[@name='referencia_correcta']/node()"/></xsl:attribute>
                                        				</img>
													</span>
													<span id="RefFamilia_ERROR" style="color:#FE2E2E;display:none;">&nbsp;
														<img src="http://www.newco.dev.br/images/error.gif">
															<xsl:attribute name="alt"><xsl:value-of select="document($doc)/translation/texts/item[@name='existe_referencia']/node()"/></xsl:attribute>
                                        					                                </img>&nbsp;
														<span id="RefFamilia_ERROR_TXT"><xsl:value-of select="document($doc)/translation/texts/item[@name='ya_existe_ref']/node()"/></span>
													</span><br />
													<span id="ley_ref_familia">&nbsp;</span>

												</xsl:when>
												<xsl:otherwise>
                                                    <xsl:value-of select="Mantenimiento/FAMILIA/REFERENCIA"/>
													<input type="hidden" name="CATPRIV_REFERENCIAFAMILIA" value="{Mantenimiento/FAMILIA/REFERENCIA}" size="4" maxlength="{string-length(Mantenimiento/FAMILIA/CODIFICACIONNIVELES/NIVEL2)}"/>
													&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='para_modificar_consultar']/node()"/>
												</xsl:otherwise>
											</xsl:choose>
										</xsl:when>
										<!- - no puede modificar la ref, depende de otros catalogos - ->
										<xsl:when test="Mantenimiento/FAMILIA/EDICION">
											<xsl:value-of select="Mantenimiento/FAMILIA/REFERENCIA"/>
											<input type="hidden" name="CATPRIV_REFERENCIAFAMILIA" value="{Mantenimiento/FAMILIA/REFERENCIA}"/>
										</xsl:when>
									</xsl:choose>
								</xsl:otherwise>
							</xsl:choose>
							-->
						</td>
					</tr>

					<tr class="sinLinea">
						<td class="labelRight">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='nombre']/node()"/>:&nbsp;
							<span class="camposObligatorios">*</span>
						</td>
						<td class="datosLeft">
							<xsl:choose>
								<xsl:when test="Mantenimiento/TIPO='CONSULTA' or Mantenimiento/FAMILIA/BLOQUEADO">
									<xsl:value-of select="Mantenimiento/FAMILIA/NOMBRE"/>
									<input type="hidden" name="CATPRIV_NOMBRE" value="{Mantenimiento/FAMILIA/NOMBRE}"/>
								</xsl:when>
								<xsl:otherwise>
									<input type="text" class="muygrande" name="CATPRIV_NOMBRE" value="{Mantenimiento/FAMILIA/NOMBRE}" size="50" maxlength="100"/>
								</xsl:otherwise>
							</xsl:choose>
						</td>
					</tr>

					<tr class="sinLinea">
						<td class="labelRight">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='ref_cliente']/node()"/>:&nbsp;
						</td>
						<td class="datosLeft">
							<xsl:choose>
								<xsl:when test="Mantenimiento/TIPO='CONSULTA'">
									<xsl:value-of select="Mantenimiento/FAMILIA/REFCLIENTE"/>
									<input type="hidden" name="CATPRIV_REFCLIENTE" id="CATPRIV_REFCLIENTE" value="{Mantenimiento/FAMILIA/REFCLIENTE}"/>
								</xsl:when>
								<xsl:otherwise>
									<input type="hidden" name="CATPRIV_REFCLIENTE_AUX" id="CATPRIV_REFCLIENTE_AUX" value="{Mantenimiento/FAMILIA/REFCLIENTE}"/>
									<input type="text" name="CATPRIV_REFCLIENTE" id="CATPRIV_REFCLIENTE" value="{Mantenimiento/FAMILIA/REFCLIENTE}" size="10" maxlength="20"/>&nbsp;
									<a href="javascript:ValidarRefCliente(document.forms[0],'FAMILIAS');" style="text-decoration:none;">
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
							<xsl:value-of select="document($doc)/translation/texts/item[@name='Proveedores']/node()"/>:&nbsp;
						</td>
						<td class="datosLeft">
							<xsl:choose>
								<xsl:when test="Mantenimiento/TIPO='CONSULTA'">
									<xsl:value-of select="Mantenimiento/FAMILIA/NOMBRESELECCION"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:call-template name="desplegable">
										<xsl:with-param name="path" select="Mantenimiento/FAMILIA/CP_FAM_IDSELECCION/field"/>
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
							&nbsp;(<span class="camposObligatorios">*</span>)&nbsp;
							<xsl:value-of select="document($doc)/translation/texts/item[@name='son_obligatorios']/node()"/>.
						</td>
					</tr>
				</table>
                </div><!--fin de divleft-->
			</form>
		</xsl:otherwise>
	</xsl:choose>
   
</body>
</html>
</xsl:template>
</xsl:stylesheet>
