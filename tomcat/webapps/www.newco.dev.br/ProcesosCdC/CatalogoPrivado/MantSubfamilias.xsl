<?xml version="1.0" encoding="iso-8859-1"?>

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
		<xsl:value-of select="Mantenimiento/SUBFAMILIA/NOMBRESNIVELES/NIVEL3"/>
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
		var leyenda_ref_nivel3		= "<xsl:value-of select="document($doc)/translation/texts/item[@name='leyenda_ref_subfamilia']/node()"/>";
		var chars_nivel3		= "<xsl:value-of select="Mantenimiento/SUBFAMILIA/CODIFICACIONNIVELES/NIVEL3"/>";
		var conCategorias		= "<xsl:value-of select="Mantenimiento/SUBFAMILIA/CODIFICACIONNIVELES/@MostrarCategoria"/>";
		var ya_existe_ref_cliente	= "<xsl:value-of select="document($doc)/translation/texts/item[@name='existe_ref_cliente_nivel']/node()"/>";
		var nombre_nivel3		= "<xsl:value-of select="/Mantenimiento/SUBFAMILIA/NOMBRESNIVELES/NIVEL3"/>";

		var length_nueva_ref_subfam;
		<xsl:choose>
		<xsl:when test="/Mantenimiento/SUBFAMILIA/CODIFICACIONNIVELES[@MostrarCategoria='S']">
			length_nueva_ref_subfam	= <xsl:value-of select="string-length(/Mantenimiento/SUBFAMILIA/CODIFICACIONNIVELES/NIVEL3) - string-length(/Mantenimiento/SUBFAMILIA/CODIFICACIONNIVELES/NIVEL2)"/>;
		</xsl:when>
		<xsl:otherwise>
			length_nueva_ref_subfam	= <xsl:value-of select="string-length(/Mantenimiento/SUBFAMILIA/CODIFICACIONNIVELES/NIVEL3)"/>;
		</xsl:otherwise>
		</xsl:choose>

		var introducir_ref_nuevo_nivel3	= "<xsl:value-of select="document($doc)/translation/texts/item[@name='introducir_ref']/node()"/>";
		var length_ref_nuevo_nivel3	= "<xsl:value-of select="document($doc)/translation/texts/item[@name='length_ref']/node()"/>";
		var introducir_nombre_nivel3	= "<xsl:value-of select="document($doc)/translation/texts/item[@name='introducir_nombre']/node()"/>";
		var ya_existe_ref_nivel3	= "<xsl:value-of select="document($doc)/translation/texts/item[@name='ya_existe_ref']/node()"/>";
                <xsl:choose>
		<xsl:when test="Mantenimiento/SUBFAMILIA/NOMBRESNIVELES[@id='custom']">
			introducir_ref_nuevo_nivel3	+= "<xsl:value-of select="document($doc)/translation/texts/item[@name='nuevo_subgrupo']/node()"/>.";
			length_ref_nuevo_nivel3		+= "<xsl:value-of select="document($doc)/translation/texts/item[@name='nuevo_subgrupo']/node()"/>";
			introducir_nombre_nivel3	+= "<xsl:value-of select="document($doc)/translation/texts/item[@name='nuevo_subgrupo']/node()"/>.";
			ya_existe_ref_nivel3		+= "<xsl:value-of select="document($doc)/translation/texts/item[@name='nuevo_subgrupo']/node()"/>";
		</xsl:when>
                <xsl:when test="Mantenimiento/SUBFAMILIA/NOMBRESNIVELES[@id='estandar']">
			introducir_ref_nuevo_nivel3	+= "<xsl:value-of select="document($doc)/translation/texts/item[@name='nueva_subfamilia']/node()"/>.";
			length_ref_nuevo_nivel3		+= "<xsl:value-of select="document($doc)/translation/texts/item[@name='nueva_subfamilia']/node()"/>";
			introducir_nombre_nivel3	+= "<xsl:value-of select="document($doc)/translation/texts/item[@name='nueva_subfamilia']/node()"/>.";
			ya_existe_ref_nivel3		+= "<xsl:value-of select="document($doc)/translation/texts/item[@name='nueva_subfamilia']/node()"/>";
		</xsl:when>
                </xsl:choose>
                
                length_ref_nuevo_nivel3	+= "<xsl:value-of select="document($doc)/translation/texts/item[@name='length_ref_nivel3']/node()"/>";
	</script>

	<script language="javascript">
		jQuery(document).ready(onloadEvents);

		function onloadEvents(){
			// Si se cambia el desplegable de familias
			jQuery('#CATPRIV_IDFAMILIA').change(function(){
				UltimaRefSFPorFamilia();
			});

			// Recuperamos la ultima ref.utilizada segun la familia por defecto
			if(jQuery('#CATPRIV_IDFAMILIA').length){
				UltimaRefSFPorFamilia();
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
			var ID		= oForm.elements['CATPRIV_ID'].value;
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
						jQuery("#RefCliente_ERROR .text").html(ya_existe_ref_cliente.replace('[[NIVEL]]',nombre_nivel3));
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

				if((!errores) && (esNulo(form.elements['CATPRIV_IDFAMILIA'].value))){
					errores++;
					alert(document.forms['MensajeJS'].elements['SELECCIONAR_FAMILIA_SUBFAMILIA'].value);
					document.forms[0].elements['CATPRIV_IDFAMILIA'].focus();
				}

				if(form.elements['ACCION'].value == 'MODIFICARSUBFAMILIA'){
					if((!errores) && (esNulo(form.elements['CATPRIV_REFERENCIA'].value))){
						errores++;
						alert(introducir_ref_nuevo_nivel3);
						document.forms[0].elements['CATPRIV_REFERENCIA'].focus();
					}else if((!errores) && (form.elements['CATPRIV_REFERENCIA'].value.length != chars_nivel3.length)){
						errores++;
						alert(length_ref_nuevo_nivel3.replace('[[DIGITO]]', chars_nivel3.length));
						document.forms[0].elements['CATPRIV_REFERENCIA'].focus();
					}
				}else if(form.elements['ACCION'].value == 'NUEVASUBFAMILIA'){
					if(form.elements['CATPRIV_REFERENCIA_STRING2'].value == ''){
						document.forms[0].elements['CATPRIV_REFERENCIA_STRING2'].focus();
						alert(introducir_ref_nuevo_nivel3);
						return;
					}else if(form.elements['CATPRIV_REFERENCIA_STRING2'].value.length != length_nueva_ref_subfam){
						// Comprobamos longitud de input CATPRIV_REFERENCIA_STRING2 (1 o 2 segun caracteres para codificacion de este nivel)
						document.forms[0].elements['CATPRIV_REFERENCIA_STRING2'].focus();
						alert(length_ref_nuevo_nivel3.replace('[[DIGITO]]', chars_nivel3.length));
						return;
					}else if(form.elements['CATPRIV_REFERENCIA_STRING2'].value.length == length_nueva_ref_subfam){
						// Comprobamos formato de input CATPRIV_REFERENCIA_STRING2 (2 caracteres alfanumericos)
						var dosChars		= form.elements['CATPRIV_REFERENCIA_STRING2'].value;
						var regex_alfanum	= /^[0-9A-Z]+$/;	//caracteres alfanumericos (solo mayusculas)

						if(!checkRegEx(dosChars, regex_alfanum)){
							document.forms[0].elements['CATPRIV_REFERENCIA_STRING2'].focus();
							alert(length_ref_nuevo_nivel3.replace('[[DIGITO]]', chars_nivel3.length));
							return;
						}

						form.elements['CATPRIV_REFERENCIA'].value = form.elements['CATPRIV_REFERENCIA_STRING1'].value + form.elements['CATPRIV_REFERENCIA_STRING2'].value;
					}
				}

				if((!errores && esNulo(form.elements['CATPRIV_NOMBRE'].value))){
					errores++;
					alert(introducir_nombre_nivel3);
					document.forms[0].elements['CATPRIV_NOMBRE'].focus();
				}
                                
                                 //control que no pongan caracteres raros en los textos
                                var inputText = [document.forms[0].elements['CATPRIV_REFERENCIA'].value,document.forms[0].elements['CATPRIV_NOMBRE'].value, document.forms[0].elements['CATPRIV_REFCLIENTE'].value];

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
                                        jQuery(".boton").hide();
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
				//alert(document.forms['form1'].elements['CATPRIV_ID'].value);
				EjecutarFuncionDelFrame('zonaCatalogo','CambioSubfamiliaActual(document.forms[\'form1\'].elements[\'CATPRIV_ID\'].value,\'CAMBIOSUBFAMILIA\');');
			}

			function UltimaRefSFPorFamilia(){
				var IDEmpresa	= jQuery('#CATPRIV_IDEMPRESA').val();
				var IDFamilia	= jQuery('#CATPRIV_IDFAMILIA').val();
				var d = new Date();

				jQuery.ajax({
					cache:	false,
					url:	'http://www.newco.dev.br/ProcesosCdC/CatalogoPrivado/UltimaRefSFPorFamilia_ajax.xsql',
					type:	"GET",
					data:	"IDEMPRESA="+IDEmpresa+"&IDFAMILIA="+IDFamilia+"&_="+d.getTime(),
					contentType: "application/xhtml+xml",
					success: function(objeto){
						var data = eval("(" + objeto + ")");

						if(data.UltimaReferenciaMVM != '')
							jQuery('span#ley_ref_subfamilia').html(leyenda_ref_nivel3.replace('[[REF_MVM]]', data.UltimaReferenciaMVM).replace('[[CODE_NIVEL3]]', chars_nivel3).replace('[[DIGITO]]',chars_nivel3.length));

						if(data.UltimaReferenciaCliente != '')
							jQuery('span#UltimaRefCliente').html(data.UltimaReferenciaCliente);
						else
							jQuery('span#UltimaRefCliente').html(no_hay);

						// Lanzamos la funcion ajax que devuelve la ref de familia si no es caso 3 niveles
						if(document.forms[0].elements['ACCION'].value == 'NUEVASUBFAMILIA' && conCategorias == 'S')
							ReferenciaFamilia();
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

			function ReferenciaFamilia(){
				var IDFamilia	= jQuery('#CATPRIV_IDFAMILIA').val();
				var d		= new Date();

				jQuery.ajax({
					cache:	false,
					url:	'http://www.newco.dev.br/ProcesosCdC/CatalogoPrivado/ReferenciaFamiliaAJAX.xsql',
					type:	"GET",
					data:	"IDFAMILIA="+IDFamilia+"&_="+d.getTime(),
					contentType: "application/xhtml+xml",
					success: function(objeto){
						var data = eval("(" + objeto + ")");

						if(data.ReferenciaFamilia.estado == 'ERROR'){
							null;
						}else{
							// Si no hay error mostramos la RefSubfamilia donde toca
							jQuery("#CATPRIV_REFERENCIA_TXT").val(data.ReferenciaFamilia.RefFamilia);
							jQuery("#CATPRIV_REFERENCIA_STRING1").val(data.ReferenciaFamilia.RefFamilia);
						}
					},
					error: function(xhr, errorString, exception) {
						alert("xhr.status="+xhr.status+" error="+errorString+" exception="+exception);
					}
				});
			}

			function ValidarRefSubfamilia(form){
				jQuery("#CATPRIV_REF").css("background-color", "#FFF");
				jQuery("#RefSF_ERROR").hide();
				jQuery("#RefSF_OK").hide();

				if(form.elements['CATPRIV_REFERENCIA_STRING2'].value == ''){
					jQuery("#CATPRIV_REF").css("background-color", "#F3F781");
					document.forms[0].elements['CATPRIV_REFERENCIA_STRING2'].focus();
					alert(introducir_ref_nuevo_nivel3);
					return;
				}else if(form.elements['CATPRIV_REFERENCIA_AUX'].value == form.elements['CATPRIV_REFERENCIA_STRING1'].value + form.elements['CATPRIV_REFERENCIA_STRING2'].value){
					// La referencia no ha cambiado (es la misma)
					jQuery("#CATPRIV_REF").css("background-color", "#BCF5A9");
					jQuery("#RefSF_OK").show();
					return;
				}else if(form.elements['CATPRIV_REFERENCIA_STRING2'].value.length != length_nueva_ref_subfam){
					// Comprobamos longitud de input CATPRIV_REFERENCIA_STRING2 (1 o 2 segun caracteres para codificacion de este nivel)
					jQuery("#CATPRIV_REF").css("background-color", "#F3F781");
					document.forms[0].elements['CATPRIV_REFERENCIA_STRING2'].focus();
					alert(length_ref_nuevo_nivel3.replace('[[DIGITO]]', chars_nivel3.length));
					return;
				}else if(form.elements['CATPRIV_REFERENCIA_STRING2'].value.length == length_nueva_ref_subfam){
					// Comprobamos formato de input CATPRIV_REFERENCIA_STRING2 (2 caracteres alfanumericos)
					var dosChars		= form.elements['CATPRIV_REFERENCIA_STRING2'].value;
					var regex_alfanum	= /^[0-9A-Z]+$/;	//caracteres alfanumericos (solo mayusculas)

					if(!checkRegEx(dosChars, regex_alfanum)){
						jQuery("#CATPRIV_REF").css("background-color", "#F3F781");
						document.forms[0].elements['CATPRIV_REFERENCIA_STRING2'].focus();
						alert(length_ref_nuevo_nivel3.replace('[[DIGITO]]', chars_nivel3.length));
						return;
					}
				}

				var IDEmpresa	= jQuery('#CATPRIV_IDEMPRESA').val();
				var IDFamilia	= jQuery('#CATPRIV_IDFAMILIA').val();
				var Referencia	= form.elements['CATPRIV_REFERENCIA_STRING1'].value + form.elements['CATPRIV_REFERENCIA_STRING2'].value;
				var d = new Date();

				jQuery.ajax({
					cache:	false,
					url:	'http://www.newco.dev.br/ProcesosCdC/CatalogoPrivado/ValidarRefSubfamiliaAJAX.xsql',
					type:	"GET",
					data:	"IDEMPRESA="+IDEmpresa+"&REFERENCIA="+Referencia+"&IDFAMILIA="+IDFamilia+"&_="+d.getTime(),
					contentType: "application/xhtml+xml",
					success: function(objeto){
						var data = eval("(" + objeto + ")");

						if(data.estado == 'ERROR'){
							jQuery("#CATPRIV_REF").css("background-color", "#F5A9A9");
							jQuery("#RefSF_ERROR_TXT").html(ya_existe_ref_nivel3.replace('[[REF]]',Referencia));
							jQuery("#RefSF_ERROR").show();
							document.forms[0].elements['CATPRIV_REFERENCIA_STRING2'].focus();

						}else{
							// Si no hay error continuamos
							jQuery("#CATPRIV_REF").css("background-color", "#BCF5A9");
							jQuery("#RefSF_OK").show();
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

<body class="gris">
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
		<xsl:when test="//SESION_CADUCADA">
			<xsl:apply-templates select="//SESION_CADUCADA"/>
		</xsl:when>
		<xsl:when test="//Sorry">
			<xsl:apply-templates select="//Sorry"/>
		</xsl:when>
		<xsl:otherwise>
			<xsl:if test="Mantenimiento/SUBFAMILIA/MENSAJE = 'OK'">
				<xsl:attribute name="onLoad">RecargarInfoCatalogo();</xsl:attribute>
			</xsl:if>

			<form name="form1" action="MantSubfamiliasSave.xsql" method="post">
				<h1 class="titlePage" style="float:left;width:70%;padding-left:10%;height:40px;">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='mant_de']/node()"/>
					<xsl:value-of select="Mantenimiento/SUBFAMILIA/NOMBRESNIVELES/NIVEL3"/>
					<xsl:value-of select="document($doc)/translation/texts/item[@name='de_productos']/node()"/>

					&nbsp;<a href="#" id="toggleResumenCatalogo" style="text-decoration:none;"><img src="http://www.newco.dev.br/images/info.gif"/></a>

					<xsl:if test="/Mantenimiento/SUBFAMILIA/MENSAJE">
						<p>
						<xsl:choose>
							<xsl:when test="/Mantenimiento/SUBFAMILIA/MENSAJE='OK'">
                                                            <xsl:value-of select="document($doc)/translation/texts/item[@name='cambios_guardados']/node()"/>
                                                            :&nbsp;<xsl:value-of select="/Mantenimiento/SUBFAMILIA/FECHA"/>&nbsp;-&nbsp;
                                                            <xsl:value-of select="document($doc)/translation/texts/item[@name='datos_historicos']/node()"/>
                                                        </xsl:when>
							<xsl:otherwise>
                                                            <xsl:value-of select="/Mantenimiento/SUBFAMILIA/MENSAJE"/>&nbsp;<xsl:value-of select="/Mantenimiento/SUBFAMILIA/FECHA"/>
                                                        </xsl:otherwise>
						</xsl:choose>
                                                </p>
					</xsl:if>
                                </h1>
                                <h1 class="titlePage" style="float:left;width:20%;height:40px;">
					<xsl:if test="(/Mantenimiento/SUBFAMILIA/MASTER or /Mantenimiento/SUBFAMILIA/MASTER_UNICO) and /Mantenimiento/ACCION = 'MODIFICARSUBFAMILIA'">
						<span style="float:right; padding:5px;" class="amarillo">CP_SF_ID:&nbsp;<xsl:value-of select="/Mantenimiento/SUBFAMILIA/ID"/></span>
					</xsl:if>
				</h1>
                            
                             <div class="divLeft">
				<div id="ResumenCatalogo" style="display:none;margin-bottom:20px;border-bottom:2px solid #3B5998;">
					<table class="mediaTabla">
					<thead>
						<tr>
							<th class="trenta">&nbsp;</th>
							<th class="doce"><xsl:value-of select="document($doc)/translation/texts/item[@name='nombre_nivel']/node()"/></th>
							<th class="dies"><xsl:value-of select="document($doc)/translation/texts/item[@name='total']/node()"/></th>
							<th class="dies"><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_cliente']/node()"/></th>
							<th class="dies"><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_mvm']/node()"/></th>
							<th class="">&nbsp;</th>
						</tr>
					</thead>

					<tbody>
						<xsl:if test="/Mantenimiento/SUBFAMILIA/NOMBRESNIVELES/NIVEL1">
						<tr id="Nivel_1">
							<td>&nbsp;</td>
							<td class="label"><xsl:value-of select="/Mantenimiento/SUBFAMILIA/NOMBRESNIVELES/NIVEL1"/></td>
							<td class="total datosRight">&nbsp;</td>
							<td class="ref_cliente datosRight">&nbsp;</td>
							<td class="ref_mvm datosRight">&nbsp;</td>
							<td>&nbsp;</td>
						</tr>
						</xsl:if>

						<xsl:if test="/Mantenimiento/SUBFAMILIA/NOMBRESNIVELES/NIVEL2">
						<tr id="Nivel_2">
							<td>&nbsp;</td>
							<td class="label"><xsl:value-of select="/Mantenimiento/SUBFAMILIA/NOMBRESNIVELES/NIVEL2"/></td>
							<td class="total datosRight">&nbsp;</td>
							<td class="ref_cliente datosRight">&nbsp;</td>
							<td class="ref_mvm datosRight">&nbsp;</td>
							<td>&nbsp;</td>
						</tr>
						</xsl:if>

						<xsl:if test="/Mantenimiento/SUBFAMILIA/NOMBRESNIVELES/NIVEL3">
						<tr id="Nivel_3">
							<td>&nbsp;</td>
							<td class="label"><xsl:value-of select="/Mantenimiento/SUBFAMILIA/NOMBRESNIVELES/NIVEL3"/></td>
							<td class="total datosRight">&nbsp;</td>
							<td class="ref_cliente datosRight">&nbsp;</td>
							<td class="ref_mvm datosRight">&nbsp;</td>
							<td>&nbsp;</td>
						</tr>
						</xsl:if>

						<xsl:if test="/Mantenimiento/SUBFAMILIA/NOMBRESNIVELES/NIVEL4">
						<tr id="Nivel_4">
							<td>&nbsp;</td>
							<td class="label"><xsl:value-of select="/Mantenimiento/SUBFAMILIA/NOMBRESNIVELES/NIVEL4"/></td>
							<td class="total datosRight">&nbsp;</td>
							<td class="ref_cliente datosRight">&nbsp;</td>
							<td class="ref_mvm datosRight">&nbsp;</td>
							<td>&nbsp;</td>
						</tr>
						</xsl:if>

						<tr id="Nivel_5">
							<td>&nbsp;</td>
							<td class="label"><xsl:value-of select="document($doc)/translation/texts/item[@name='Productos_estandar']/node()"/></td>
							<td class="total datosRight">&nbsp;</td>
							<td class="ref_cliente datosRight">&nbsp;</td>
							<td class="ref_mvm datosRight">&nbsp;</td>
							<td>&nbsp;</td>
						</tr>
					</tbody>
					</table>
				</div>

				<table class="mediaTabla">
					<input type="hidden" name="CATPRIV_IDUSUARIO" VALUE="{Mantenimiento/US_ID}"/>
					<input type="hidden" name="CATPRIV_IDEMPRESA" VALUE="{Mantenimiento/CATPRIV_IDEMPRESA}" id="CATPRIV_IDEMPRESA"/>
					<input type="hidden" name="CATPRIV_ID" VALUE="{Mantenimiento/SUBFAMILIA/ID}"/>
					<input type="hidden" name="ACCION" VALUE="{Mantenimiento/ACCION}"/>
					<input type="hidden" name="VENTANA" VALUE="{Mantenimiento/VENTANA}"/>

					<tr><td>&nbsp;</td><td><span class="rojo"><xsl:value-of select="document($doc)/translation/texts/item[@name='los_siguientes_caracteres_no_deben_sin_barra']/node()"/></span></td></tr>

					<tr>
						<td class="label trentacinco">
							<xsl:value-of select="Mantenimiento/SUBFAMILIA/NOMBRESNIVELES/NIVEL2"/>
							<xsl:value-of select="document($doc)/translation/texts/item[@name='de_productos']/node()"/>:
							<xsl:if test="/Mantenimiento/ACCION = 'NUEVASUBFAMILIA'">
								<span class="camposObligatorios">*</span>
							</xsl:if>
						</td>
						<td class="datosLeft sesenta">
							<xsl:choose>
								<!-- solo consulta -->
								<xsl:when test="Mantenimiento/TIPO='CONSULTA'">
									<xsl:for-each select="Mantenimiento/SUBFAMILIA/FAMILIAS/field/dropDownList/listElem">
										<xsl:if test="ID=../../@current">
											<xsl:value-of select="listItem"/>
										</xsl:if>
									</xsl:for-each>
								</xsl:when>
								<!-- edicion -->
								<xsl:otherwise>
									<xsl:choose>
										<!-- no puede modificar la familia de la que depende o puede crear nuevas subfamilias -->
										<xsl:when test="Mantenimiento/SUBFAMILIA/MASTER or Mantenimiento/SUBFAMILIA/MASTER_UNICO">
											<!-- nueva -->
											<xsl:choose>
												<xsl:when test="Mantenimiento/SUBFAMILIA/ID='0'">
													<xsl:call-template name="desplegable">
														<xsl:with-param name="path" select="Mantenimiento/SUBFAMILIA/FAMILIAS/field"></xsl:with-param>
													</xsl:call-template>
												</xsl:when>
												<!-- modificacion -->
												<xsl:otherwise>
													<xsl:call-template name="desplegable_disabled">
														<xsl:with-param name="path" select="Mantenimiento/SUBFAMILIA/FAMILIAS/field"></xsl:with-param>
													</xsl:call-template>
												</xsl:otherwise>
											</xsl:choose>
										</xsl:when>
										<!-- no puede modificar la familia de la que depende -->
										<xsl:when test="Mantenimiento/SUBFAMILIA/EDICION">
											<xsl:for-each select="Mantenimiento/SUBFAMILIA/FAMILIAS/field/dropDownList/listElem">
												<xsl:if test="ID=../../@current">
													<xsl:value-of select="listItem"/>
													<input type="hidden" name="CATPRIV_IDFAMILIA" value="{ID}"/>
												</xsl:if>
											</xsl:for-each>
										</xsl:when>
									</xsl:choose>
								</xsl:otherwise>
							</xsl:choose>
						</td>
					</tr>

					<tr>
						<td class="label">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='referencia']/node()"/>:
							<xsl:if test="/Mantenimiento/ACCION = 'NUEVASUBFAMILIA'">
								<span class="camposObligatorios">*</span>
							</xsl:if>
						</td>
						<td class="datosLeft">
							<xsl:choose>
								<!-- solo consulta -->
								<xsl:when test="Mantenimiento/TIPO='CONSULTA'">
									<xsl:value-of select="Mantenimiento/SUBFAMILIA/REFERENCIA"/>
								</xsl:when>
								<!-- edicion -->
								<xsl:otherwise>
									<xsl:choose>
										
										<!-- no puede modificar la familia de la que depende o puede crear nuevas subfamilias -->
										<xsl:when test="Mantenimiento/SUBFAMILIA/MASTER or Mantenimiento/SUBFAMILIA/MASTER_UNICO">
											<!-- nueva -->
											<xsl:choose>
												<xsl:when test="/Mantenimiento/SUBFAMILIA/ID='0'">
													<xsl:if test="/Mantenimiento/SUBFAMILIA/CODIFICACIONNIVELES[@MostrarCategoria='S']">
														<input type="text" name="CATPRIV_REFERENCIA_TXT" id="CATPRIV_REFERENCIA_TXT" disabled="disabled" class="noinput" size="3"/>
													</xsl:if>
													<input type="hidden" name="CATPRIV_REFERENCIA_STRING1" id="CATPRIV_REFERENCIA_STRING1"/>
													<input type="text" id="CATPRIV_REF" name="CATPRIV_REFERENCIA_STRING2" size="3">
														<xsl:choose>
														<xsl:when test="/Mantenimiento/SUBFAMILIA/CODIFICACIONNIVELES[@MostrarCategoria='S']">
															<xsl:attribute name="maxlength"><xsl:value-of select="string-length(/Mantenimiento/SUBFAMILIA/CODIFICACIONNIVELES/NIVEL3) - string-length(/Mantenimiento/SUBFAMILIA/CODIFICACIONNIVELES/NIVEL2)"/></xsl:attribute>
														</xsl:when>
														<xsl:otherwise>
															<xsl:attribute name="maxlength"><xsl:value-of select="string-length(/Mantenimiento/SUBFAMILIA/CODIFICACIONNIVELES/NIVEL3)"/></xsl:attribute>
														</xsl:otherwise>
														</xsl:choose>
													</input>&nbsp;
													<input type="hidden" name="CATPRIV_REFERENCIA_AUX"/>
													<input type="hidden" name="CATPRIV_REFERENCIA"/>&nbsp;
													<a href="javascript:ValidarRefSubfamilia(document.forms[0]);" style="text-decoration:none;">
														<xsl:choose>
														<xsl:when test="/Mantenimiento/LANG = 'portugues'">
															<img src="http://www.newco.dev.br/images/comprobar-BR.gif" alt="Verificar"/>
														</xsl:when>
														<xsl:otherwise>
															<img src="http://www.newco.dev.br/images/comprobar.gif" alt="Comprobar"/>
														</xsl:otherwise>
														</xsl:choose>
													</a>
													<span id="RefSF_OK" style="display:none;">&nbsp;
														<img src="http://www.newco.dev.br/images/recibido.gif">
															<xsl:attribute name="alt"><xsl:value-of select="document($doc)/translation/texts/item[@name='referencia_correcta']/node()"/></xsl:attribute>
                                        					                                </img>
													</span>
													<span id="RefSF_ERROR" style="color:#FE2E2E;display:none;">&nbsp;
														<img src="http://www.newco.dev.br/images/error.gif">
															<xsl:attribute name="alt"><xsl:value-of select="document($doc)/translation/texts/item[@name='existe_referencia']/node()"/></xsl:attribute>
                                        					                                </img>&nbsp;
														<span id="RefSF_ERROR_TXT"><xsl:value-of select="document($doc)/translation/texts/item[@name='ya_existe_ref']/node()"/></span>
													</span><br />
													<span id="ley_ref_subfamilia">&nbsp;</span>

<!-- DC - 24/07/14 - Deshabilitamos los primeros caracteres de la ref.subfamilia que dependen de los niveles inferiores
													<input type="text" name="CATPRIV_REFERENCIA" value="{Mantenimiento/SUBFAMILIA/REFERENCIA}" size="8" maxlength="{string-length(Mantenimiento/SUBFAMILIA/CODIFICACIONNIVELES/NIVEL3)}"/>
													&nbsp;<span id="ley_ref_subfamilia">&nbsp;</span>
-->
													   <!--a 5 niveles-->
<!--
                                                        <xsl:if test="Mantenimiento/SUBFAMILIA/NOMBRESNIVELES/@MostrarCategoria = 'S'">
                                                            <xsl:value-of select="document($doc)/translation/texts/item[@name='leyenda_ref_subfamilia_5_niveles']/node()"/>
                                                        </xsl:if>
-->
                                                         <!--a 3 niveles-->
<!--
                                                        <xsl:if test="Mantenimiento/SUBFAMILIA/NOMBRESNIVELES/@MostrarCategoria = 'N'">
                                                            <xsl:value-of select="document($doc)/translation/texts/item[@name='leyenda_ref_subfamilia_3_niveles']/node()"/>
                                                        </xsl:if>
-->
													<!--{Mantenimiento/PRODUCTOESTANDAR/TODASSUBFAMILIAS/FAMILIA[@current = ID]/SUBFAMILIA[@current = ID]/SIGUIENTE}-->
												</xsl:when>
												<!-- modificacion -->
												<xsl:otherwise>
                                                                                                        <xsl:value-of select="Mantenimiento/SUBFAMILIA/REFERENCIA"/>
													<input type="hidden" name="CATPRIV_REFERENCIA" value="{Mantenimiento/SUBFAMILIA/REFERENCIA}" size="8" maxlength="{string-length(Mantenimiento/SUBFAMILIA/CODIFICACIONNIVELES/NIVEL3)}"/>
													&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='para_modificar_consultar']/node()"/>
													   <!--a 5 niveles-->
<!--
                                                        <xsl:if test="Mantenimiento/SUBFAMILIA/NOMBRESNIVELES/@MostrarCategoria = 'S'">
                                                            <xsl:value-of select="document($doc)/translation/texts/item[@name='leyenda_ref_subfamilia_5_niveles']/node()"/>
                                                        </xsl:if>
-->
                                                         <!--a 3 niveles-->
<!--
                                                        <xsl:if test="Mantenimiento/SUBFAMILIA/NOMBRESNIVELES/@MostrarCategoria = 'N'">
                                                            <xsl:value-of select="document($doc)/translation/texts/item[@name='leyenda_ref_subfamilia_3_niveles']/node()"/>
                                                        </xsl:if>
-->
												</xsl:otherwise>
											</xsl:choose>
										</xsl:when>
										<!-- no puede modificar la familia de la que depende -->
										<xsl:when test="Mantenimiento/SUBFAMILIA/EDICION">
											<xsl:value-of select="Mantenimiento/SUBFAMILIA/REFERENCIA"/>
											<input type="hidden" name="CATPRIV_REFERENCIA" value="{Mantenimiento/SUBFAMILIA/REFERENCIA}"/>
										</xsl:when>
									</xsl:choose>
								</xsl:otherwise>
							</xsl:choose>
						</td>
					</tr>

					<tr>
						<td class="label">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='nombre']/node()"/>:
							<span class="camposObligatorios">*</span>
						</td>
						<td class="datosLeft">
							<xsl:choose>
								<xsl:when test="Mantenimiento/TIPO='CONSULTA'">
									<xsl:value-of select="Mantenimiento/SUBFAMILIA/NOMBRE"/>
								</xsl:when>
								<xsl:otherwise>
									<input type="text" name="CATPRIV_NOMBRE" value="{Mantenimiento/SUBFAMILIA/NOMBRE}" size="70" maxlength="300"/>
								</xsl:otherwise>
							</xsl:choose>
						</td>
					</tr>

					<tr>
						<td class="label">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='ref_cliente']/node()"/>:
						</td>
						<td class="datosLeft">
							<xsl:choose>
								<xsl:when test="Mantenimiento/TIPO='CONSULTA'">
									<xsl:value-of select="Mantenimiento/FAMILIA/REFCLIENTE"/>
								</xsl:when>
								<xsl:otherwise>
									<input type="hidden" name="CATPRIV_REFCLIENTE_AUX" id="CATPRIV_REFCLIENTE_AUX" value="{Mantenimiento/SUBFAMILIA/REFCLIENTE}"/>
									<input type="text" name="CATPRIV_REFCLIENTE" id="CATPRIV_REFCLIENTE" value="{Mantenimiento/SUBFAMILIA/REFCLIENTE}" size="10" maxlength="20"/>&nbsp;
									<a href="javascript:ValidarRefCliente(document.forms[0],'SUBFAMILIAS');" style="text-decoration:none;">
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
<!-- DC - 16/06/14 - Alfonso dice que ya no es util -->
<!--
									<xsl:value-of select="document($doc)/translation/texts/item[@name='ultima_refCliente_utilizada_cp']/node()"/>:&nbsp;
									<span id="UltimaRefCliente">&nbsp;</span>
-->
								</xsl:otherwise>
							</xsl:choose>
						</td>
					</tr>
					<tr>
						<td class="label">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='proveedores']/node()"/>:
						</td>
						<td class="datosLeft">
							<xsl:choose>
								<xsl:when test="Mantenimiento/TIPO='CONSULTA'">
									<xsl:value-of select="Mantenimiento/SUBFAMILIA/NOMBRESELECCION"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:call-template name="desplegable">
										<xsl:with-param name="path" select="Mantenimiento/SUBFAMILIA/CP_SF_IDSELECCION/field"/>
									</xsl:call-template>
								</xsl:otherwise>
							</xsl:choose>
						</td>
					</tr>

					<tr>
						<td>&nbsp;</td>
						<td colspan="2">&nbsp;</td>
						<td>&nbsp;</td>
					</tr>

					<tr>
						<td>&nbsp;</td>
						<td colspan="2">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='los_campos_marcados_con']/node()"/>
							&nbsp;(<span class="camposObligatorios">*</span>)&nbsp;
							<xsl:value-of select="document($doc)/translation/texts/item[@name='son_obligatorios']/node()"/>.
						</td>
					</tr>
				</table>

				<table class="mediaTabla">
					<tr>
						<td colspan="3">&nbsp;</td>
					</tr>
					<tr>
						<td class="trenta">&nbsp;</td>
						<td align="center" class="dies">&nbsp;</td>
						<td align="center">
							<div class="boton">
								<a href="javascript:ValidarFormulario(document.forms[0]);">
									<xsl:value-of select="document($doc)/translation/texts/item[@name='guardar']/node()"/>
								</a>
							</div>
						</td>
					</tr>
				</table>
                            </div><!--fin de divleft-->
			</form>

			<form name="MensajeJS">
				<input type="hidden" name="SELECCIONAR_FAMILIA_SUBFAMILIA" value="{document($doc)/translation/texts/item[@name='seleccionar_familia_subfamilia']/node()}"/>
			</form>
		</xsl:otherwise>
	</xsl:choose>
</body>
</html>
</xsl:template>
</xsl:stylesheet>
