<?xml version="1.0" encoding="iso-8859-1"?>
<!--
	Ultima revisi�n ET 29may18 10:21
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:import href = "http://www.newco.dev.br/General/General.xsl"/>
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
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

	<title><xsl:value-of select="document($doc)/translation/texts/item[@name='mantenimiento_productos_estandar']/node()"/></title>

	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->

	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic_18.06.08.js"></script>

	<xsl:text disable-output-escaping="yes">
	<![CDATA[
	<script language="javascript">
	<!--
		var msgSubfamilia='Debe seleccionar una familia para el nuevo Producto Est�ndar';
		var msgReferenciaProductoEstandar='Debe introducir una referencia para el nuevo Producto Est�ndar';
		var msgNombreProductoEstandar='Debe introducir un nombre para el nuevo Producto Est�ndar';
		var msgUnidadBasicaProductoEstandar='Debe introducir la unidad b�sica para el nuevo Producto Est�ndar';
		var msgMismaReferencia='Debe introducir una referencia diferente para el nuevo Producto Est�ndar';
		var msgReferenciaEstrictaProductoEstandar='La referencia del producto estandar no es correcta. introduzca una con el formato siguiente: ';
		var msgSinDerechosParaCopiar='No tiene derechos suficientes para crear nuevos productos estandar. Por favor, pongase en contacto con MedicalVM';

		var msgPrecioReferenciaInventado='El precio de referencia est� marcado como NO BASADO EN LOS HIST�RICOS pero no se ha introducido ning�n valor.\nPor favor, introduzca uno o desmarque la casilla correspondiente.';
		var msgRestaurarNombre='�Desea restaurar el nombre del producto?';
		var msgMismoNombre='Debe introducir un nombre diferente para el nuevo Producto Est�ndar';
		var msgMismaRefGuardar = 'Debe introducir una referencia diferente para el nuevo Producto Est�ndar\nPara cambiar la descripci�n est�ndar sin crear una nueva referencia est�ndar contacte con el equipo t�cnico de MedicalVM.';
		var msgMismaRefCopiar = 'Para crear un nuevo producto est�ndar por favor asigne una nueva referencia.';
	]]>
	</xsl:text>

		var lang = '<xsl:value-of select="/Mantenimiento/LANG"/>';

		var msg_previo_desc_antiguas = '<xsl:value-of select="document($doc)/translation/texts/item[@name='msg_previo_desc_antiguas']/node()"/>';
		var sustituirDescAntErr	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='sustituir_desc_ant_error']/node()"/>';
		var sustituirDescAntOK	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='sustituir_desc_ant_ok']/node()"/>';
		var catpriv_estricto='<xsl:value-of select="/Mantenimiento/PRODUCTOESTANDAR/CATPRIV_ESTRICTO"/>';
        var raros_alert	= "<xsl:value-of select="document($doc)/translation/texts/item[@name='caracteres_raros']/node()"/>";
        var raros_prod_estandar	= "<xsl:value-of select="document($doc)/translation/texts/item[@name='caracteres_raros_producto_estandard']/node()"/>";

                
	<xsl:text disable-output-escaping="yes">
	<![CDATA[
		var arrTodasCategorias=new Array();
		var arrTodasFamilias=new Array();
		var arrTodasSubfamilias=new Array();
		var arrTodasGrupos=new Array();
	]]>
	</xsl:text>

	//array si hay 3 desplegables
	<xsl:choose>
	<xsl:when test="/Mantenimiento/PRODUCTOESTANDAR/TODASSUBFAMILIAS">
		<xsl:for-each select="/Mantenimiento/PRODUCTOESTANDAR/TODASSUBFAMILIAS/CATEGORIA/FAMILIA">
			var arrayFamilia=new Array();
			arrayFamilia[arrayFamilia.length]=new Array('<xsl:value-of select="ID"/>','<xsl:value-of select="listItem2"/>');
			<xsl:for-each select="SUBFAMILIA">
				arrayFamilia[arrayFamilia.length]=new Array('<xsl:value-of select="ID"/>','<xsl:value-of select="listItem"/>','<xsl:value-of select="listItem2"/>','<xsl:value-of select="SIGUIENTE"/>');
			</xsl:for-each>
			arrTodasSubfamilias[arrTodasSubfamilias.length]=arrayFamilia;
		</xsl:for-each>

		<xsl:for-each select="/Mantenimiento/PRODUCTOESTANDAR/TODASSUBFAMILIAS/CATEGORIA/FAMILIA/SUBFAMILIA">
			var arraySubfamilia=new Array();
			arraySubfamilia[arraySubfamilia.length]=new Array('<xsl:value-of select="ID"/>','<xsl:value-of select="IDGRUPO"/>');
			<xsl:for-each select="GRUPO">
				arraySubfamilia[arraySubfamilia.length]=new Array('<xsl:value-of select="ID"/>','<xsl:value-of select="IDGRUPO"/>','<xsl:value-of select="listItem2"/>','<xsl:value-of select="SIGUIENTE"/>');
			</xsl:for-each>
			arrTodasGrupos[arrTodasGrupos.length]=arraySubfamilia;
		</xsl:for-each>
	</xsl:when>
	<xsl:otherwise>
		<xsl:for-each select="/Mantenimiento/PRODUCTOESTANDAR/TODOSGRUPOS/CATEGORIA">
			var arrayCategoria=new Array();
			arrayCategoria[arrayCategoria.length]=new Array('<xsl:value-of select="ID"/>','<xsl:value-of select="listItem2"/>');
			<xsl:for-each select="FAMILIA">
				arrayCategoria[arrayCategoria.length]=new Array('<xsl:value-of select="ID"/>','<xsl:value-of select="listItem"/>','<xsl:value-of select="listItem2"/>','<xsl:value-of select="SIGUIENTE"/>');
			</xsl:for-each>
			arrTodasFamilias[arrTodasFamilias.length]=arrayCategoria;
		</xsl:for-each>

		<xsl:for-each select="/Mantenimiento/PRODUCTOESTANDAR/TODOSGRUPOS/CATEGORIA/FAMILIA">
			var arrayFamilia=new Array();
			arrayFamilia[arrayFamilia.length]=new Array('<xsl:value-of select="ID"/>','<xsl:value-of select="listItem2"/>');
			<xsl:for-each select="SUBFAMILIA">
				arrayFamilia[arrayFamilia.length]=new Array('<xsl:value-of select="ID"/>','<xsl:value-of select="listItem"/>','<xsl:value-of select="listItem2"/>','<xsl:value-of select="SIGUIENTE"/>');
			</xsl:for-each>
			arrTodasSubfamilias[arrTodasSubfamilias.length]=arrayFamilia;
		</xsl:for-each>

		<xsl:for-each select="/Mantenimiento/PRODUCTOESTANDAR/TODOSGRUPOS/CATEGORIA/FAMILIA/SUBFAMILIA">
			var arraySubfamilia=new Array();
			arraySubfamilia[arraySubfamilia.length]=new Array('<xsl:value-of select="ID"/>','<xsl:value-of select="listItem2"/>');
			<xsl:for-each select="GRUPO">
				arraySubfamilia[arraySubfamilia.length]=new Array('<xsl:value-of select="ID"/>','<xsl:value-of select="listItem"/>','<xsl:value-of select="listItem2"/>','<xsl:value-of select="SIGUIENTE"/>');
			</xsl:for-each>
			arrTodasGrupos[arrTodasGrupos.length]=arraySubfamilia;
		</xsl:for-each>

		<xsl:for-each select="/Mantenimiento/PRODUCTOESTANDAR/TODOSGRUPOS/CATEGORIA/FAMILIA/SUBFAMILIA/GRUPO">
			var arrayGrupo=new Array();
			arrayGrupo[arrayGrupo.length]=new Array('<xsl:value-of select="ID"/>','<xsl:value-of select="listItem2"/>');
			<xsl:for-each select="GRUPO">
				arrayGrupo[arrayGrupo.length]=new Array('<xsl:value-of select="ID"/>','<xsl:value-of select="listItem"/>','<xsl:value-of select="listItem2"/>','<xsl:value-of select="SIGUIENTE"/>');
			</xsl:for-each>
			arrTodasGrupos[arrTodasGrupos.length]=arrayGrupo;
		</xsl:for-each>
	</xsl:otherwise>
	</xsl:choose>

		chars_nivel5 = "<xsl:value-of select="Mantenimiento/PRODUCTOESTANDAR/CODIFICACIONNIVELES/NIVEL5"/>";
		leyenda_ref_nivel5	= "<xsl:value-of select="document($doc)/translation/texts/item[@name='leyenda_ref_prod_estandar']/node()"/>";

		no_hay		= "<xsl:value-of select="document($doc)/translation/texts/item[@name='no_hay_datos']/node()"/>";

		jQuery(document).ready(onloadEvents);

		function onloadEvents(){
			// Si se cambia el desplegable de grupo (caso 5 niveles)
			jQuery('#CATPRIV_IDGRUPO').change(function(){
				UltimaRefProductoPorGrupo();
			});

			// Si se cambia el desplegable de subfamilia (caso 3 niveles)
			jQuery('#CATPRIV_IDSUBFAMILIA').change(function(){
				if(jQuery('#CATPRIV_IDGRUPO').length == 0)
					UltimaRefProductoPorSF();
			});

			// Recuperamos la ultima ref.utilizada segun el grupo por defecto (caso 5 niveles)
			if(jQuery('#CATPRIV_IDGRUPO').length){
				UltimaRefProductoPorGrupo();
			// Recuperamos la ultima ref.utilizada segun la subfamilia por defecto (caso 3 niveles)
			}else if(jQuery('#CATPRIV_IDSUBFAMILIA').length){
				UltimaRefProductoPorSF();
			}
			// Si se hace click sobre el icono de info
			jQuery('#toggleResumenCatalogo').click(function(){
				if(!jQuery("#ResumenCatalogo").is(':visible'))
					ResumenCatalogo();

				jQuery("#ResumenCatalogo").toggle("slow");
			});
		}

	<xsl:text disable-output-escaping="yes">
	<![CDATA[
	function ValidarRefProdEstandar(form){
		jQuery("#CATPRIV_REF").css("background-color", "#FFF");
		jQuery("#RefProd_ERROR").hide();
		jQuery("#RefProd_OK").hide();

		if(form.elements['CATPRIV_REFERENCIA_STRING2'].value == ''){
			jQuery("#CATPRIV_REF").css("background-color", "#F3F781");
			document.forms[0].elements['CATPRIV_REFERENCIA_STRING2'].focus();
			alert(document.forms['MensajeJS'].elements['OBLI_REF_PROD_ESTANDAR'].value);
			return;
		}else if(form.elements['CATPRIV_REFERENCIA_AUX'].value == form.elements['CATPRIV_REFERENCIA_STRING1'].value + form.elements['CATPRIV_REFERENCIA_STRING2'].value){
			// La referencia no ha cambiado (es la misma)
			jQuery("#CATPRIV_REF").css("background-color", "#BCF5A9");
			jQuery("#RefProd_OK").show();
			return;
		}else if(form.elements['CATPRIV_REFERENCIA_STRING2'].value.length < 2 || form.elements['CATPRIV_REFERENCIA_STRING2'].value.length > 3){
			// Comprobamos longitud de input CATPRIV_REFERENCIA_STRING2 (2 o 3)
			jQuery("#CATPRIV_REF").css("background-color", "#F3F781");
			document.forms[0].elements['CATPRIV_REFERENCIA_STRING2'].focus();
			alert(document.forms['MensajeJS'].elements['LENGTH_REF_NUEVO_PROD_EST'].value);
			return;
		}else if(form.elements['CATPRIV_REFERENCIA_STRING2'].value.length == 2){
			// Comprobamos formato de input CATPRIV_REFERENCIA_STRING2 (2 caracteres alfanumericos)
			var dosChars		= form.elements['CATPRIV_REFERENCIA_STRING2'].value;
			var regex_alfanum	= /^[0-9A-Z]+$/;	//caracteres alfanumericos (solo mayusculas)

			if(!checkRegEx(dosChars, regex_alfanum)){
				jQuery("#CATPRIV_REF").css("background-color", "#F3F781");
				document.forms[0].elements['CATPRIV_REFERENCIA_STRING2'].focus();
				alert(document.forms['MensajeJS'].elements['LENGTH_REF_NUEVO_PROD_EST'].value);
				return;
			}
		}else if(form.elements['CATPRIV_REFERENCIA_STRING2'].value.length == 3){
			var dosChars = form.elements['CATPRIV_REFERENCIA_STRING2'].value.substring(0,2);
			var ultimoDigito = form.elements['CATPRIV_REFERENCIA_STRING2'].value.substring(2);
			var regex_alfanum	= /^[0-9A-Z]+$/;	//caracteres alfanumericos (solo mayusculas)

			if(!checkRegEx(dosChars, regex_alfanum)){
				jQuery("#CATPRIV_REF").css("background-color", "#F3F781");
				document.forms[0].elements['CATPRIV_REFERENCIA_STRING2'].focus();
				alert(document.forms['MensajeJS'].elements['LENGTH_REF_NUEVO_PROD_EST'].value);
				return;
			}

			if(isNaN(ultimoDigito) !== true){
				jQuery("#CATPRIV_REF").css("background-color", "#F3F781");
				document.forms[0].elements['CATPRIV_REFERENCIA_STRING2'].focus();
				alert(document.forms['MensajeJS'].elements['LENGTH_REF_NUEVO_PROD_EST'].value);
				return;
			}
		}

		var IDEmpresa	= jQuery('#CATPRIV_IDEMPRESA').val();
		var Referencia	= form.elements['CATPRIV_REFERENCIA_STRING1'].value + form.elements['CATPRIV_REFERENCIA_STRING2'].value;
		var d = new Date();

		jQuery.ajax({
			cache:	false,
			url:	'http://www.newco.dev.br/ProcesosCdC/CatalogoPrivado/ValidarRefProdEstandarAJAX.xsql',
			type:	"GET",
			data:	"IDEMPRESA="+IDEmpresa+"&REFERENCIA="+Referencia+"&_="+d.getTime(),
			contentType: "application/xhtml+xml",
			success: function(objeto){
				var data = eval("(" + objeto + ")");

				if(data.estado == 'ERROR'){
					jQuery("#CATPRIV_REF").css("background-color", "#F5A9A9");
					jQuery("#RefProd_ERROR").show();
					document.forms[0].elements['CATPRIV_REFERENCIA_STRING2'].focus();

				}else{
					// Si no hay error continuamos
					jQuery("#CATPRIV_REF").css("background-color", "#BCF5A9");
					jQuery("#RefProd_OK").show();
				}
			},
			error: function(xhr, errorString, exception) {
				alert("xhr.status="+xhr.status+" error="+errorString+" exception="+exception);
			}
		});
	}

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
        var regex_car_raros     = new RegExp("[\#|\\|\'\|]","g"); //caracteres raros que no queremos en los campos de texto (requisito MVM)
        var regex_prod_estandar	= new RegExp("^[0-9a-zA-Z ]+$","g"); // Expresion regular para controlar el campo que solo puede incluir n�meros y letras (requisito MVM)
        var raros=0;
		var errores=0;

		/* quitamos los espacios sobrantes  */
		for(var n=0;n<form.length;n++){
			if(form.elements[n].type=='text'){
				form.elements[n].value=quitarEspacios(form.elements[n].value);
			}
		}

		if((!errores) && (esNulo(form.elements['CATPRIV_IDSUBFAMILIA'].value))){
			errores++;
			alert(document.forms['MensajeJS'].elements['OBLI_FAMILIA_PROD_ESTANDAR'].value);
			document.forms[0].elements['CATPRIV_IDSUBFAMILIA'].focus();
		}

		// 04/06/14 - DC
		// Solo permitimos modificar las �ltimas 2 cifras de la ref. (o 3 si se trata de una variante de producto)
		// Trabajamos con inputs hidden (CATPRIV_REFERENCIA, CATPRIV_REFERENCIA_STRING1, CATPRIV_REFERENCIA_AUX) y con input text (CATPRIV_REFERENCIA_STRING2)
		if((!errores) && form.elements['CATPRIV_REFERENCIA_STRING2'] && (esNulo(form.elements['CATPRIV_REFERENCIA_STRING2'].value))){
			errores++;
			alert(document.forms['MensajeJS'].elements['OBLI_REF_PROD_ESTANDAR'].value);
			document.forms[0].elements['CATPRIV_REFERENCIA_STRING2'].focus();
		}else if((!errores) && form.elements['CATPRIV_REFERENCIA_STRING2'] && (form.elements['CATPRIV_REFERENCIA_STRING2'].value.length < 2 || form.elements['CATPRIV_REFERENCIA_STRING2'].value.length > 3)){
			errores++;
			alert(document.forms['MensajeJS'].elements['LENGTH_REF_NUEVO_PROD_EST'].value);
			document.forms[0].elements['CATPRIV_REFERENCIA_STRING2'].focus();
		}else if(form.elements['CATPRIV_REFERENCIA_STRING2'] && form.elements['CATPRIV_REFERENCIA_STRING2'].value.length == 2){
			// Comprobamos formato de input CATPRIV_REFERENCIA_STRING2 (2 caracteres alfanumericos)
			var dosChars		= form.elements['CATPRIV_REFERENCIA_STRING2'].value;
			var regex_alfanum	= /^[0-9A-Z]+$/;	//caracteres alfanumericos (solo mayusculas)

			if(!checkRegEx(dosChars, regex_alfanum)){
				errores++;
				document.forms[0].elements['CATPRIV_REFERENCIA_STRING2'].focus();
				alert(document.forms['MensajeJS'].elements['LENGTH_REF_NUEVO_PROD_EST'].value);
			}

			form.elements['CATPRIV_REFERENCIA'].value = form.elements['CATPRIV_REFERENCIA_STRING1'].value + form.elements['CATPRIV_REFERENCIA_STRING2'].value;
		}else if(form.elements['CATPRIV_REFERENCIA_STRING2'] && form.elements['CATPRIV_REFERENCIA_STRING2'].value.length == 3){
			var dosChars = form.elements['CATPRIV_REFERENCIA_STRING2'].value.substring(0,2);
			var ultimoDigito = form.elements['CATPRIV_REFERENCIA_STRING2'].value.substring(2);
			var regex_alfanum	= /^[0-9A-Z]+$/;	//caracteres alfanumericos (solo mayusculas)

			if(!checkRegEx(dosChars, regex_alfanum)){
				errores++;
				document.forms[0].elements['CATPRIV_REFERENCIA_STRING2'].focus();
				alert(document.forms['MensajeJS'].elements['LENGTH_REF_NUEVO_PROD_EST'].value);
			}

			if(isNaN(ultimoDigito) !== true){
				errores++;
				document.forms[0].elements['CATPRIV_REFERENCIA_STRING2'].focus();
				alert(document.forms['MensajeJS'].elements['LENGTH_REF_NUEVO_PROD_EST'].value);
			}

			form.elements['CATPRIV_REFERENCIA'].value = form.elements['CATPRIV_REFERENCIA_STRING1'].value + form.elements['CATPRIV_REFERENCIA_STRING2'].value;
		}

		// miramos que si el catalogo es estricto, la referencia lo sea, esto es, ref=ref_fam+ref_subfam+2 o mas digitos
		// 9abr10 permitimos una letra
		/* 2may12 el catalogo MVM, igual que el de ASISA, ya no es "estricto"
		else{
			if(catpriv_estricto=='S'){
				if(!esReferenciaEstricta(document.forms[0])){
					errores++;
					alert(document.forms['MensajeJS'].elements['REF_NO_CORRECTA'].value + montarReferenciaEstricta(document.forms[0])+'XXL');
					document.forms[0].elements['CATPRIV_REFERENCIA'].focus();
				}
			}
		}
		*/

		if((!errores && esNulo(form.elements['CATPRIV_NOMBRE'].value))){
			errores++;
			alert(document.forms['MensajeJS'].elements['OBLI_NOMBRE_PROD_ESTANDAR'].value);
			document.forms[0].elements['CATPRIV_NOMBRE'].focus();
		}

		//31/10/11 si cambia nombre prod debe cambiar tb la referencia si no nada cambio
		//quitado control 22/11/11

		var nuevaReferencia=quitarEspacios(form.elements['CATPRIV_REFERENCIA'].value.toUpperCase());
		var ReferenciaOriginal=quitarEspacios(form.elements['REFERENCIAORIGINAL'].value.toUpperCase());
		var nuevoNombre=quitarEspacios(form.elements['CATPRIV_NOMBRE'].value.toUpperCase());
		var NombreOriginal=quitarEspacios(form.elements['NOMBREORIGINAL'].value.toUpperCase());

		/*if ((!errores) && nuevoNombre != NombreOriginal){
			if (nuevaReferencia == ReferenciaOriginal){
				alert(document.forms['MensajeJS'].elements['OBLI_REF_DIFERENTE'].value +'\n'+ document.forms['MensajeJS'].elements['OBLI_REF_DIFERENTE1'].value);
				errores++;
			}
		}*/
		//fin control cambio ref cambio nombre

        //control que no pongan caracteres raros en los textos
                var inputText = [document.forms[0].elements['CATPRIV_REFERENCIA'].value,document.forms[0].elements['CATPRIV_NOMBRE'].value,document.forms[0].elements['CATPRIV_NOMBRE_PRIVADO'].value,document.forms[0].elements['CATPRIV_REFCLIENTE'].value];

                for (var i=0;i<inputText.length;i++){
                //var f=checkRegEx(inputText[i], regex_car_raros); alert ('valor f '+f);
                    if(checkRegEx(inputText[i], regex_car_raros)){
                        //si true implica que si ha encontrado caracteres raros
                        errores=1; 
                        raros=1;
                    }
                }//fin for caracteres raros
                if (raros =='1') alert(raros_alert);


        //requiere licitacion
        if (form.elements['REQUIERELICITACION'] && form.elements['REQUIERELICITACION'].checked==true){
            form.elements['REQUIERELICITACION'].value = 'S';
        }
        else{form.elements['REQUIERELICITACION'].value = 'N';}

        //	24ene18	Producto regulado
        if (form.elements['CHK_REGULADO'] && form.elements['CHK_REGULADO'].checked==true){
            form.elements['REGULADO'].value = 'S';
        }
        else{form.elements['REGULADO'].value = 'N';}

        //text licitacion
        //if (form.elements['CP_PRO_IDTEXTOLICITACION'] && form.elements['CP_PRO_IDTEXTOLICITACION'].value != '' && (!checkRegEx(form.elements['CP_PRO_IDTEXTOLICITACION'].value, regex_prod_estandar)) ){
        //     alert(raros_prod_estandar);
        //     errores++;
        //}

        //cambiar precio de referencia 4-6-15
        if(form.elements['CATPRIV_PRECIOREFERENCIA'] && form.elements['CATPRIV_PRECIOREFERENCIA'].value != '' && form.elements['CATPRIV_PRECIOREFERENCIA_OLD'].value != '' && (form.elements['CATPRIV_PRECIOREFERENCIA'].value != form.elements['CATPRIV_PRECIOREFERENCIA_OLD'].value)){
            if(confirm(document.forms['MensajeJS'].elements['SEGURO_CAMBIAR_PRECIO_REF'].value)){}
            else{ errores++; }
        }
        //dejar vac�o precio de referencia 4-6-15
        if(form.elements['CATPRIV_PRECIOREFERENCIA'] && form.elements['CATPRIV_PRECIOREFERENCIA_OLD'].value != '' && form.elements['CATPRIV_PRECIOREFERENCIA'].value == ''){
            if(confirm(document.forms['MensajeJS'].elements['SEGURO_CAMBIAR_PRECIO_REF_ZERO'].value)){}
            else{ errores++; }
        }


		//	Prepara la lista de centros para enviar, recorreindo todos los elementos CHK_CENTRO
		var cadenaCentros='';
		for (i=0;i<form.elements.length;++i)
		{
			//solodebug	console.log('Comprobando elemento:'+form.elements[i].name);
			
			if (form.elements[i].name.substring(0,10)=='CHK_CENTRO')
			{
				var ID=Piece(form.elements[i].name,'_',2);
				var Autorizado=(form.elements[i].checked==true)?'S':'N';
				
				cadenaCentros=cadenaCentros+ID+'#'+Autorizado+'#'+form.elements["REFCENTRO_"+ID].value+'#'+form.elements["ORDEN_"+ID].value+'|';
				
				//solodebug	console.log('Elemento:'+form.elements[i].name+' checked:'+form.elements[i].checked+' Cadena:'+cadenaCentros);
			}
		}
		//solodebug	alert(cadenaCentros)
		form.elements['LISTA_CENTROS'].value=cadenaCentros;

		/* si los datos son correctos enviamos el form  */
		if(!errores){
            jQuery(".boton").hide();
			EnviarCambios(form)
		}
	}

	//9abr10	 permitimos 8 o 9 caracteres
	function esReferenciaEstricta(form){
		//alert('Referencia:'+form.elements['CATPRIV_REFERENCIA'].value+' length'+form.elements['CATPRIV_REFERENCIA'].value.length+ ' ref estricta:'+montarReferenciaEstricta(form));

		if(form.elements['CATPRIV_REFERENCIA'].value.substring(0,montarReferenciaEstricta(form).length)==montarReferenciaEstricta(form)
		&& ((form.elements['CATPRIV_REFERENCIA'].value.length==8) || (form.elements['CATPRIV_REFERENCIA'].value.length==9))){
			return 1;
		}else{
			return 0;
		}
	}

	function montarReferenciaEstricta(form){
		// buscamos la ref de familia y de subfamilia
		var encontrado=0;
		var refFamilia='';
		var refSubfamilia='';
		for(var n=0;n<arrTodasSubfamilias.length && !encontrado;n++){
			var arrFamilia=arrTodasSubfamilias[n][0];
			if(arrFamilia[0]==form.elements['CATPRIV_IDFAMILIA'].value){
				refFamilia=arrFamilia[1];
				for(var i=1;i<arrTodasSubfamilias[n].length;i++){
					var arrSubfamilia=arrTodasSubfamilias[n][i];
					if(arrSubfamilia[0]==form.elements['CATPRIV_IDSUBFAMILIA'].value){
						var refSubfamilia=arrSubfamilia[2];
						encontrado=1;
					}
				}
			}
		}
		return refFamilia+refSubfamilia;
	}

	function EnviarCambios(form){
		SubmitForm(form);
	}

	function ValidarNumero(obj,decimales){
		if(checkNumberNulo(obj.value,obj)){
			if(parseFloat(reemplazaComaPorPunto(obj.value))!=0){
				obj.value=anyadirCerosDecimales(reemplazaPuntoPorComa(Round(reemplazaComaPorPunto(obj.value),decimales)),decimales);
			}
			return true;
		}
		return false;
	}

	//14-01-13 mc
	function CambioCategoriaActual(valor,accion){
		var objName='CATPRIV_IDFAMILIA';
		var encontrado=0;
		var arrFamilia=new Array();
		//alert('mi '+arrTodasFamilias.length);
		for(var n=0;n<arrTodasFamilias.length && !encontrado;n++){
			var arrCategoria=arrTodasFamilias[n][0];
			if(arrCategoria[0]==valor){
				encontrado=1;
				arrFamilias=arrTodasFamilias[n];
			}
		}

		document.forms['form1'].elements['IDCATEGORIA'].value=document.forms['form1'].elements['CATPRIV_IDCATEGORIA'].value;
		document.forms['form1'].elements[objName].length=0;
		for(var n=1;n<arrFamilias.length;n++){
			var id=arrFamilias[n][0];
			var elemento=arrFamilias[n][1];
			var addOption=new Option(elemento,id);
			document.forms['form1'].elements[objName]
			document.forms['form1'].elements[objName].options[document.forms['form1'].elements[objName].length]=addOption;
		}
		//alert('val '+document.forms['form1'].elements[objName].value);
		CambioFamiliaActual(document.forms['form1'].elements[objName].value,'CAMBIOSUBFAMILIA');
	}

	function CambioFamiliaActual(valor,accion){
		var objName='CATPRIV_IDSUBFAMILIA';
		var encontrado=0;
		var arrSubfamilias=new Array();
		for(var n=0;n<arrTodasSubfamilias.length && !encontrado;n++){
			var arrFamilia=arrTodasSubfamilias[n][0];
			//alert(arrFamilia);
			if(arrFamilia[0]==valor){
				encontrado=1;
				arrSubfamilias=arrTodasSubfamilias[n];
			}
		}
		document.forms['form1'].elements['IDFAMILIA'].value=document.forms['form1'].elements['CATPRIV_IDFAMILIA'].value;
		document.forms['form1'].elements[objName].length=0;
		for(var n=1;n<arrSubfamilias.length;n++){
			var id=arrSubfamilias[n][0];
			var elemento=arrSubfamilias[n][1];
			var addOption=new Option(elemento,id);
			document.forms['form1'].elements[objName]
			document.forms['form1'].elements[objName].options[document.forms['form1'].elements[objName].length]=addOption;
		}
		CambioSubfamiliaActual(document.forms['form1'].elements[objName].value,'CAMBIOGRUPO');
	}

	//14-01-13 mc
	function CambioSubfamiliaActual(valor,accion){

		var objName='CATPRIV_IDGRUPO';
		var encontrado=0;
		var arrGrupos=new Array();

		for(var n=0;n<arrTodasGrupos.length && !encontrado;n++){
			var arrSubfamilia=arrTodasGrupos[n][0];
			if(arrSubfamilia[0]==valor){
				encontrado=1;
				arrGrupos=arrTodasGrupos[n];
			}
		}

		//si CATPRIV_IDGRUPO es hidden significa oculto, 3 niveles
		if (document.forms['form1'].elements[objName].type == 'hidden'){
			for(var n=0;n<arrGrupos.length;n++){
				var id=arrGrupos[n][0];
				var elemento=arrGrupos[n][1];
				var grupo=arrGrupos[n][1];
				//alert(id+' - '+elemento);
			}
			document.forms['form1'].elements[objName].value = grupo;

			// Lanzamos la funcion ajax que devuelve la ref de grupo
			ReferenciaGrupo();

			// Lanzo la funcion para recuperar la ultima ref.utilizada por subfamilia (3 niveles)
			UltimaRefProductoPorSF();
		}else{

			document.forms['form1'].elements['IDSUBFAMILIA'].value=document.forms['form1'].elements['CATPRIV_IDSUBFAMILIA'].value;
			document.forms['form1'].elements[objName].length=0;
			for(var n=1;n<arrGrupos.length;n++){
				var id=arrGrupos[n][0];
				var elemento=arrGrupos[n][1];
				var addOption=new Option(elemento,id);
				document.forms['form1'].elements[objName]
				document.forms['form1'].elements[objName].options[document.forms['form1'].elements[objName].length]=addOption;
			}

			// Lanzamos la funcion ajax que devuelve la ref de grupo
			ReferenciaGrupo();

			// Lanzo la funcion para recuperar la ultima ref.utilizada por grupo (5 niveles)
			UltimaRefProductoPorGrupo();
		}
	}

	//14-01-13 mc
	function CambioGrupoActual(valor,accion){
		//UltimaRefProductoPorGrupo();
	}

	function restaurarNombre(objTexto,valor,objPadre){
		if(confirm(document.forms['MensajeJS'].elements['RESTAURAR_NOMBRE_PRODUCTO'].value+'\n\n'+ document.forms['MensajeJS'].elements['NOMBRE_ACTUAL'].value+' : '+objTexto.value+'\n '+ document.forms['MensajeJS'].elements['NUEVO_NOMBRE'].value +': '+valor)){
			objTexto.value=valor;
			objPadre.value='S';
		}
	}

	function debugando(form){
		var id_1=form.elements['CATPRIV_IDFAMILIA'].value;
		var id_2=form.elements['CATPRIV_IDSUBFAMILIA'].value;
		if(confirm('idfamilia: '+id_1+' idsubfamilia: '+id_2+' �Enviamos los datos?')){
			return 1;
		}else{
			return 0;
		}
	}

	function seleccionarValor(elemento,valor){
		var valorSeleccionado=0;
		if(elemento.type=='select-one'){
			for(var n=0;n<elemento.options.length;n++){
				if(elemento.options[n].value==valor){
					valorSeleccionado=n;
				}
			}
			elemento.selectedIndex=valorSeleccionado;
		}
	}

	//	25jun12	Guardar el propducto est�ndar completo, incluyendo hijos e hist�ricos
	function GuardarProducto(form, accion){
		form.elements['ACCION'].value=accion;
		ValidarFormulario(form);
	}

	//	25jun12	Mueve el producto est�ndar completo, incluyendo hijos e hist�ricos
	function MoverProducto(form){
		form.elements['ACCION'].value='MOVER';
		if (form.elements['MOVERAREFESTANDAR'].value=='')
			alert(document.forms['MensajeJS'].elements['MOVER_REF_ERROR'].value);
		else
			ValidarFormulario(form);
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
		EjecutarFuncionDelFrame('zonaCatalogo','CambioProductoEstandarActual('+jQuery('#CATPRIV_IDEMPRESA').val()+','+jQuery('#CATPRIV_ID').val()+',\'CAMBIOPRODUCTOESTANDAR\');');
	}

	function sustituirDescripcion(cont){
		var IDEmpresa		= jQuery('#CATPRIV_IDEMPRESA').val();
		var IDProdEstandar	= jQuery('#CATPRIV_ID').val();
		var NombreAntiguo	= encodeURIComponent(jQuery('#DUMP_' + cont).html());
		var d = new Date();

		// Ocultamos y vaciamos la zona de mensajes
		jQuery('tr#DESC_ANT_MESSAGE').hide();
		jQuery('tr#DESC_ANT_MESSAGE td#MSG').html('');

		jQuery.ajax({
			cache:	false,
			url:	'SustituirDescripcion.xsql',
			type:	"GET",
			data:	"IDEMPRESA="+IDEmpresa+"&IDPRODESTANDAR="+IDProdEstandar+"&DUMP_NOMBREANTIGUO="+NombreAntiguo+"&_="+d.getTime(),
			contentType: "application/xhtml+xml",
			beforeSend: function(){
				jQuery("#ACTION_" + cont).attr("src","http://www.newco.dev.br/images/loading.gif");
				jQuery("tr#DESC_ANT_MESSAGE td#MSG").html(msg_previo_desc_antiguas);
				jQuery("tr#DESC_ANT_MESSAGE").show()
			},
			error: function(objeto, quepaso, otroobj){
// El proceso tarda mas de 3 minutos en responder y salta el timeout
// De momento, comentamos y borramos la linia (asumiendo que ha salido bien)
				jQuery("tr#DESC_" + cont).remove();
				jQuery("tr#DESC_ANT_MESSAGE").hide().html('');
				//alert('error'+quepaso+' '+otroobj+' '+objeto);
			},
			success: function(objeto){
				var data = eval("(" + objeto + ")");

				if(data.SustituirDescripcion.estado == 'OK'){
					var Total = data.SustituirDescripcion.TotalLineas;

					jQuery('tr#DESC_ANT_MESSAGE td#MSG').html(sustituirDescAntOK.replace('[[LINEAS]]', Total));
					ActualizarDescripcionesAntiguas();
				}else{
					jQuery('tr#DESC_ANT_MESSAGE td#MSG').html(sustituirDescAntErr);
				}
			}
		});
	}

	function ActualizarDescripcionesAntiguas(){
		var IDEmpresa		= jQuery('#CATPRIV_IDEMPRESA').val();
		var IDProdEstandar	= jQuery('#CATPRIV_ID').val();
		var d = new Date();
		var txtHTML = '', botonAccion = '';

		jQuery.ajax({
			cache:	false,
			url:	'DescripcionesAnteriores.xsql',
			type:	"GET",
			data:	"IDEMPRESA="+IDEmpresa+"&IDPRODESTANDAR="+IDProdEstandar+"&_="+d.getTime(),
			contentType: "application/xhtml+xml",
			error: function(objeto, quepaso, otroobj){
				alert('error'+quepaso+' '+otroobj+' '+objeto);
			},
			success: function(objeto){
				var data = eval("(" + objeto + ")");

				if(data.DescripcionesAnteriores.length > 0){
					// Reconstruir la tabla de descripciones antiguas
					// Ocultar las filas para descripciones antiguas
					jQuery("tr.descAntic").each(function(){
						jQuery(this).remove();
					});

					jQuery(data.DescripcionesAnteriores.ListaDescripciones).each(function(key,descripcion){

						if(lang == 'spanish'){
							botonAccion = '<img src="http://www.newco.dev.br/images/sustituir.gif" id="ACTION_' + descripcion.Num + '" title="Sustituir" alt="Sustituir"/>';
						}else{
							botonAccion = '<img src="http://www.newco.dev.br/images/sustituir-BR.gif" id="ACTION_' + descripcion.Num + '" title="Substituir" alt="Substituir"/>';
						}

						txtHTML = '<tr id="DESC_' + descripcion.Num + '" class="descAntic">' +
							'<td>&nbsp;</td>' +
							'<td colspan="2">[' + descripcion.Nombre + ']<span id="DUMP_' + descripcion.Num + '" style="display:none;">' + descripcion.NombreDump + '</span></td>' +
							'<td>' +
								'<a href="javascript:sustituirDescripcion(' + descripcion.Num + ');">' +
									botonAccion +
								'</a>' +
							'</td>' +
							'<td colspan="3">&nbsp;</td>' +
						'</tr>';

						jQuery("#TituloDescAntic").after(txtHTML);
					});
				}else{
					// Ocultar las filas para descripciones antiguas
					jQuery("tr.descAntic").each(function(){
						jQuery(this).remove();
					});
				}
			}
		});
	}


	function UltimaRefProductoPorSF(){
		var IDEmpresa	= jQuery('#CATPRIV_IDEMPRESA').val();
		var IDSubfam	= jQuery('#CATPRIV_IDSUBFAMILIA').val();
		var d = new Date();

		jQuery.ajax({
			cache:	false,
			url:	'http://www.newco.dev.br/ProcesosCdC/CatalogoPrivado/UltimaRefProductoPorSF_ajax.xsql',
			type:	"GET",
			data:	"IDEMPRESA="+IDEmpresa+"&IDSUBFAMILIA="+IDSubfam+"&_="+d.getTime(),
			contentType: "application/xhtml+xml",
			success: function(objeto){
				var data = eval("(" + objeto + ")");

				if(data.UltimaReferenciaMVM != '')
					jQuery('span#ley_ref_prodestandar').html(leyenda_ref_nivel5.replace('[[REF_MVM]]', data.UltimaReferenciaMVM).replace('[[CODE_NIVEL5]]', chars_nivel5));

				if(data.UltimaReferenciaCliente != '')
					jQuery('span#UltimaRefCliente').html(data.UltimaReferenciaCliente);
				else
					jQuery('span#UltimaRefCliente').html(no_hay);
			},
			error: function(xhr, errorString, exception) {
				alert("xhr.status="+xhr.status+" error="+errorString+" exception="+exception);
			}
		});
	}

	function UltimaRefProductoPorGrupo(){
		var IDEmpresa	= jQuery('#CATPRIV_IDEMPRESA').val();
		var IDGrupo	= jQuery('#CATPRIV_IDGRUPO').val();
		var d = new Date();

		//solodebug	alert('UltimaRefProductoPorGrupo IDEmpresa:'+IDEmpresa+' IDGrupo:'+IDGrupo);

		jQuery.ajax({
			cache:	false,
			url:	'http://www.newco.dev.br/ProcesosCdC/CatalogoPrivado/UltimaRefProductoPorGrupo_ajax.xsql',
			type:	"GET",
			data:	"IDEMPRESA="+IDEmpresa+"&IDGRUPO="+IDGrupo+"&_="+d.getTime(),
			contentType: "application/xhtml+xml",
			success: function(objeto){
				var data = eval("(" + objeto + ")");

				if(data.UltimaReferenciaMVM != '')
					jQuery('span#ley_ref_prodestandar').html(leyenda_ref_nivel5.replace('[[REF_MVM]]', data.UltimaReferenciaMVM).replace('[[CODE_NIVEL5]]', chars_nivel5));

				if(data.UltimaReferenciaCliente != '')
					jQuery('span#UltimaRefCliente').html(data.UltimaReferenciaCliente);
				else
					jQuery('span#UltimaRefCliente').html(no_hay);
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

	function ReferenciaGrupo(){
		var IDGrupo	= jQuery('#CATPRIV_IDGRUPO').val();
		var d		= new Date();

		jQuery.ajax({
			cache:	false,
			url:	'http://www.newco.dev.br/ProcesosCdC/CatalogoPrivado/ReferenciaGrupoAJAX.xsql',
			type:	"GET",
			data:	"IDGRUPO="+IDGrupo+"&_="+d.getTime(),
			contentType: "application/xhtml+xml",
			success: function(objeto){
				var data = eval("(" + objeto + ")");

				if(data.ReferenciaGrupo.estado == 'ERROR'){
					null;
				}else{
					// Si no hay error mostramos laRefGrupo donde toca
					jQuery("#CATPRIV_REFERENCIA_TXT").val(data.ReferenciaGrupo.RefGrupo);
					jQuery("#CATPRIV_REFERENCIA_STRING1").val(data.ReferenciaGrupo.RefGrupo);
				}
			},
			error: function(xhr, errorString, exception) {
				alert("xhr.status="+xhr.status+" error="+errorString+" exception="+exception);
			}
		});
	}

    function CopiaraLicitacion(idProd){

        jQuery.ajax({
            cache:    false,
            url:  'http://www.newco.dev.br/ProcesosCdC/CatalogoPrivado/CopiaraLicitacionAJAX.xsql',
            type:    "GET",
            data:    "IDPROD="+idProd,
            contentType: "application/xhtml+xml",
            success: function(objeto){
                var data = eval("(" + objeto + ")");
                alert(data.CopiaraLicitacion.estado);

                                    var res='';
                if(data.CopiaraLicitacion.estado == 'ERROR'){
                                        res = document.forms['MensajeJS'].elements['ERROR_ACTUALIZAR_LICI'].value;
                }else if (data.CopiaraLicitacion.estado == 'NO_ENCONTRADA'){
                    res = document.forms['MensajeJS'].elements['PROD_NO_ENCONTRADO'].value;
                }
                else{
                    res = document.forms['MensajeJS'].elements['ACTUALIZADAS_LINEAS_LICI'].value+" data.CopiaraLicitacion.estado "+document.forms['MensajeJS'].elements['ACTUALIZADAS_LINEAS_LICI2'].value;
                }

                jQuery("#resCopiaraLici").append(res);
            },
            error: function(xhr, errorString, exception) {
                alert("xhr.status="+xhr.status+" error="+errorString+" exception="+exception);
            }
        });
    }//fin de copiaraLici 

    //a�adir producto a una licitacion
    function InsertarProdLici(oForm){
        var IDLic	= oForm.elements['IDLICITACION'].value;
        var refProd	= oForm.elements['REF_PROD'].value;
        var TipoIVA	= oForm.elements['PRO_IDTIPOIVA'].value;
        var d = new Date();

        if (IDLic != '-1'){
            jQuery.ajax({
                    cache:	false,
                    url:	'http://www.newco.dev.br/Gestion/Comercial/NuevosProductos.xsql',
                    type:	"GET",
                    data:	"LIC_ID="+IDLic+"&LISTA_REFERENCIAS="+refProd+"&TIPOIVA="+TipoIVA+"&_="+d.getTime(),
                    contentType: "application/xhtml+xml",
                    success: function(objeto){
                            var data = eval("(" + objeto + ")");


                            if(data.NuevosProductos.estado == 'OK'){
                                    alert(data.NuevosProductos.message);
                            }
                            else{
                                    alert('Error: \n' + data.NuevosProductos.message + '\n' + errorNuevosProductos);
                            }

                    },
                    error: function(xhr, errorString, exception) {
                            alert("mimi xhr.status="+xhr.status+" error="+errorString+" exception="+exception);
                    }
            });
        }
        else{ alert('elige licitacion'); }
    } //fin de InsertarProdLici
//-->
</script>
	]]>
	</xsl:text>
</head>

<!--<body class="gris">-->
<body>
<!-- Si es el alta de un nuevo producto -->
<xsl:if test="/Mantenimiento/PRODUCTOESTANDAR/ID = 0 and (/Mantenimiento/PRODUCTOESTANDAR/MASTER or /Mantenimiento/PRODUCTOESTANDAR/MASTER_UNICO)">
	<xsl:attribute name="onload">ReferenciaGrupo()</xsl:attribute>
</xsl:if>

<xsl:choose>
<xsl:when test="//SESION_CADUCADA">
	<xsl:apply-templates select="//SESION_CADUCADA"/>
</xsl:when>
<xsl:when test="//Sorry">
	<xsl:apply-templates select="//Sorry"/>
</xsl:when>
<xsl:otherwise>
	<xsl:if test="Mantenimiento/PRODUCTOESTANDAR/MENSAJE = 'OK'">
		<xsl:attribute name="onLoad">RecargarInfoCatalogo();</xsl:attribute>
	</xsl:if>
	<form name="form1" action="MantProductosEstandarSave.xsql" method="post">
		<!--idioma-->
		<xsl:variable name="lang">
			<xsl:choose>
			<xsl:when test="/Mantenimiento/LANG"><xsl:value-of select="/Mantenimiento/LANG"/></xsl:when>
			<xsl:otherwise>spanish</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
		<!--idioma fin-->

		<!--	Titulo de la p�gina		-->
		<div class="ZonaTituloPagina">
			<p class="Path"><xsl:value-of select="document($doc)/translation/texts/item[@name='Inicio']/node()"/>&nbsp;/&nbsp;<span class="FinPath">
			<xsl:value-of select="document($doc)/translation/texts/item[@name='mantenimiento_productos_estandar']/node()"/>
			</span>
				<span class="CompletarTitulo">
				<xsl:if test="/Mantenimiento/PRODUCTOESTANDAR/CONCONTRATO = 'S'">
					&nbsp;&nbsp;&nbsp;<span class="verde"><xsl:value-of select="document($doc)/translation/texts/item[@name='CON_CONTRATO']/node()"/></span>
				</xsl:if>
				<xsl:if test="/Mantenimiento/PRODUCTOESTANDAR/CONCONTRATO = 'C'">
					&nbsp;&nbsp;&nbsp;<span class="rojo"><xsl:value-of select="document($doc)/translation/texts/item[@name='CONTRATO_CADUCADO']/node()"/></span>
				</xsl:if>

				&nbsp;<a href="#" id="toggleResumenCatalogo" style="text-decoration:none;"><img src="http://www.newco.dev.br/images/info.gif"/></a>
				<xsl:if test="/Mantenimiento/PRODUCTOESTANDAR/MENSAJE">
					<xsl:choose>
						<xsl:when test="/Mantenimiento/PRODUCTOESTANDAR/MENSAJE='OK'">
                            <span style="font-size:13px;"><xsl:value-of select="document($doc)/translation/texts/item[@name='cambios_guardados']/node()"/>
                            :&nbsp;<xsl:value-of select="/Mantenimiento/PRODUCTOESTANDAR/FECHA"/></span>
							<!--&nbsp;-&nbsp;
                            <xsl:value-of select="document($doc)/translation/texts/item[@name='datos_historicos']/node()"/>-->
                        </xsl:when>
						<xsl:otherwise><xsl:value-of select="/Mantenimiento/PRODUCTOESTANDAR/MENSAJE"/>&nbsp;<xsl:value-of select="/Mantenimiento/PRODUCTOESTANDAR/FECHA"/></xsl:otherwise>
					</xsl:choose>
				</xsl:if>
				<xsl:if test="(/Mantenimiento/PRODUCTOESTANDAR/MASTER or /Mantenimiento/PRODUCTOESTANDAR/MASTER_UNICO) and /Mantenimiento/ACCION = 'MODIFICARPRODUCTOESTANDAR'">
					&nbsp;&nbsp;&nbsp;<span class="amarillo">CP_PRO_ID:&nbsp;<xsl:value-of select="/Mantenimiento/PRODUCTOESTANDAR/ID"/></span>
				</xsl:if>
				</span>
			</p>
			<p class="TituloPagina">
				<!--	Nombre de la categor�a si ya existe o "Categor�a" -->
				<xsl:choose>
					<xsl:when test="/Mantenimiento/PRODUCTOESTANDAR/REFERENCIA != ''">
						<!--<xsl:value-of select="Mantenimiento/PRODUCTOESTANDAR/REFERENCIA"/>&nbsp;--><xsl:value-of select="Mantenimiento/PRODUCTOESTANDAR/NOMBRE"/>
                    </xsl:when>
					<xsl:otherwise>	
						<xsl:value-of select="document($doc)/translation/texts/item[@name='mantenimiento_productos_estandar']/node()"/>
					</xsl:otherwise>							
				</xsl:choose>
				<span class="CompletarTitulo" style="width:400px;font-size:13px;">
        			<a class="btnNormal" href="javascript:document.location='about:blank'">
            			<xsl:value-of select="document($doc)/translation/texts/item[@name='cancelar']/node()"/>
            		</a>
					&nbsp;
                    <xsl:choose>
                    <xsl:when test="Mantenimiento/ACCION= 'NUEVOPRODUCTOESTANDAR'">
					<!--	Bot�n "nuevo" -->
						<a class="btnDestacado" href="javascript:GuardarProducto(document.forms[0],'NUEVOPRODUCTOESTANDAR');">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='guardar']/node()"/>
						</a>
                    </xsl:when>
                    <xsl:when test="Mantenimiento/ACCION='MODIFICAR' or Mantenimiento/ACCION='MOVER' or Mantenimiento/ACCION='MODIFICARPRODUCTOESTANDAR' or Mantenimiento/ACCION= 'COPIARPRODUCTOESTANDAR'">
						<a class="btnDestacado" href="javascript:GuardarProducto(document.forms[0],'MODIFICAR');">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='guardar']/node()"/>
						</a>
                    </xsl:when>
                    </xsl:choose>
				</span>
			</p>
		</div>
		<br/>
		<br/>		
		
		<!--
		<h1 class="titlePage" style="float:left;width:70%;padding-left:10%;height:40px;">
			<xsl:if test="/Mantenimiento/PRODUCTOESTANDAR/ADJUDICADO">
                <a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/ProcesosCdC/MantenimientoReducido/MantenimientoReducido.xsql?PRO_ID={/Mantenimiento/PRODUCTOESTANDAR/IDPRODUCTO}','catalogoprivado',100,80,75,0);" style="text-decoration:none;">
                    <img src="http://www.newco.dev.br/images/catalogo.gif"/>
                </a>
            &nbsp;
            </xsl:if>
            <xsl:value-of select="document($doc)/translation/texts/item[@name='mantenimiento_productos_estandar']/node()"/>
			&nbsp;<a href="#" id="toggleResumenCatalogo" style="text-decoration:none;"><img src="http://www.newco.dev.br/images/info.gif" width="13"/></a>
                       

			<xsl:if test="/Mantenimiento/PRODUCTOESTANDAR/MENSAJE">
				<p>
				<xsl:choose>
				<xsl:when test="/Mantenimiento/PRODUCTOESTANDAR/MENSAJE='OK'">
                                    <xsl:value-of select="document($doc)/translation/texts/item[@name='cambios_guardados']/node()"/>
                                    :&nbsp;<xsl:value-of select="/Mantenimiento/PRODUCTOESTANDAR/FECHA"/>&nbsp;-&nbsp;				
                                    <xsl:value-of select="document($doc)/translation/texts/item[@name='datos_historicos']/node()"/>
                                </xsl:when>
				<xsl:otherwise>
                                    <xsl:value-of select="/Mantenimiento/PRODUCTOESTANDAR/MENSAJE"/>&nbsp;<xsl:value-of select="/Mantenimiento/PRODUCTOESTANDAR/FECHA"/>
                                </xsl:otherwise>
				</xsl:choose>
                                </p>
			</xsl:if>
                </h1>
                <h1 class="titlePage" style="float:left;width:20%;height:40px;">    
			<xsl:if test="(/Mantenimiento/PRODUCTOESTANDAR/MASTER or /Mantenimiento/PRODUCTOESTANDAR/MASTER_UNICO) and /Mantenimiento/ACCION = 'MODIFICARPRODUCTOESTANDAR'">
				<span style="float:right; padding:5px;" class="amarillo">CP_PRO_ID:&nbsp;<xsl:value-of select="/Mantenimiento/PRODUCTOESTANDAR/ID"/></span>
			</xsl:if>
		</h1>
		-->
                
        <div class="divLeft">
		<div id="ResumenCatalogo" style="display:none;margin-bottom:20px;border-bottom:2px solid #3B5998;">
			<!--<table class="mediaTabla">-->
			<table class="buscador">
			<thead>
				<tr class="sinLinea">
					<th class="trenta">&nbsp;</th>
					<th class="doce" style="text-align:right;"><xsl:value-of select="document($doc)/translation/texts/item[@name='nombre_nivel']/node()"/></th>
					<th class="dies" style="text-align:right;"><xsl:value-of select="document($doc)/translation/texts/item[@name='total']/node()"/></th>
					<th class="dies" style="text-align:right;"><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_cliente']/node()"/></th>
					<th class="dies" style="text-align:right;"><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_mvm']/node()"/></th>
					<th class="">&nbsp;</th>
				</tr>
			</thead>

			<tbody>
				<xsl:if test="/Mantenimiento/PRODUCTOESTANDAR/NOMBRESNIVELES/NIVEL1">
				<tr id="Nivel_1">
					<td>&nbsp;</td>
					<td class="labelRight"><xsl:value-of select="/Mantenimiento/PRODUCTOESTANDAR/NOMBRESNIVELES/NIVEL1"/></td>
					<td class="total datosRight">&nbsp;</td>
					<td class="ref_cliente datosRight">&nbsp;</td>
					<td class="ref_mvm datosRight">&nbsp;</td>
					<td>&nbsp;</td>
				</tr>
				</xsl:if>

				<xsl:if test="/Mantenimiento/PRODUCTOESTANDAR/NOMBRESNIVELES/NIVEL2">
				<tr id="Nivel_2">
					<td>&nbsp;</td>
					<td class="labelRight"><xsl:value-of select="/Mantenimiento/PRODUCTOESTANDAR/NOMBRESNIVELES/NIVEL2"/></td>
					<td class="total datosRight">&nbsp;</td>
					<td class="ref_cliente datosRight">&nbsp;</td>
					<td class="ref_mvm datosRight">&nbsp;</td>
					<td>&nbsp;</td>
				</tr>
				</xsl:if>

				<xsl:if test="/Mantenimiento/PRODUCTOESTANDAR/NOMBRESNIVELES/NIVEL3">
				<tr id="Nivel_3">
					<td>&nbsp;</td>
					<td class="labelRight"><xsl:value-of select="/Mantenimiento/PRODUCTOESTANDAR/NOMBRESNIVELES/NIVEL3"/></td>
					<td class="total datosRight">&nbsp;</td>
					<td class="ref_cliente datosRight">&nbsp;</td>
					<td class="ref_mvm datosRight">&nbsp;</td>
					<td>&nbsp;</td>
				</tr>
				</xsl:if>

				<xsl:if test="/Mantenimiento/PRODUCTOESTANDAR/NOMBRESNIVELES/NIVEL4">
				<tr id="Nivel_4">
					<td>&nbsp;</td>
					<td class="labelRight"><xsl:value-of select="/Mantenimiento/PRODUCTOESTANDAR/NOMBRESNIVELES/NIVEL4"/></td>
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

		<input type="hidden" name="CATPRIV_IDUSUARIO" VALUE="{Mantenimiento/US_ID}"/>
		<input type="hidden" name="CATPRIV_IDEMPRESA" VALUE="{Mantenimiento/CATPRIV_IDEMPRESA}" id="CATPRIV_IDEMPRESA"/>
		<input type="hidden" name="CATPRIV_ID" VALUE="{Mantenimiento/PRODUCTOESTANDAR/ID}" id="CATPRIV_ID"/>
		<input type="hidden" name="CATPRIV_IDDIVISA" VALUE="{Mantenimiento/PRODUCTOESTANDAR/IDDIVISA}"/>
		<input type="hidden" name="ACCION" VALUE="{Mantenimiento/ACCION}"/>
		<input type="hidden" name="VENTANA" VALUE="{Mantenimiento/VENTANA}"/>
		<input type="hidden" name="REFERENCIAORIGINAL" VALUE="{Mantenimiento/PRODUCTOESTANDAR/REFERENCIA}"/>
		<input type="hidden" name="NOMBREORIGINAL" VALUE="{Mantenimiento/PRODUCTOESTANDAR/NOMBRE}"/>
		<input type="hidden" name="IDCATEGORIA" VALUE="{Mantenimiento/PRODUCTOESTANDAR/CATEGORIA/field/@current}"/>
		<input type="hidden" name="IDFAMILIA" VALUE="{Mantenimiento/PRODUCTOESTANDAR/FAMILIAS/field/@current}"/>
		<input type="hidden" name="IDGRUPO" VALUE="{Mantenimiento/PRODUCTOESTANDAR/GRUPO/field/@current}"/>
        <input type="hidden" name="IDSUBFAMILIA" VALUE="{Mantenimiento/PRODUCTOESTANDAR/SUBFAMILIAS/field/@current}"/>
        <input type="hidden" name="REF_PROD" VALUE="{/Mantenimiento/PRODUCTOESTANDAR/REFERENCIA}"/>
        <input type="hidden" name="LISTA_CENTROS" VALUE=""/>

		<!--<table class="mediaTabla">-->
		<table class="buscador">
		
			<tr class="sinLinea">
				<td colspan="2">&nbsp;</td>
				<td class="textLeft" colspan="2"><span class="rojo"><xsl:value-of select="document($doc)/translation/texts/item[@name='los_siguientes_caracteres_no_deben_sin_barra']/node()"/></span></td>
			</tr>

			<tr class="sinLinea">
				<td>&nbsp;</td>
				<td class="labelRight trentacinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_alta']/node()"/>:&nbsp;</td>
				<td class="textLeft"><strong><xsl:value-of select="Mantenimiento/PRODUCTOESTANDAR/FECHAALTA"/></strong></td>
				<td>&nbsp;</td>
			</tr>

		<xsl:choose>
		<xsl:when test="Mantenimiento/PRODUCTOESTANDAR/CATEGORIAS">
			<tr class="sinLinea">
				<td>&nbsp;</td>
				<td class="labelRight trentacinco">
					<xsl:value-of select="Mantenimiento/PRODUCTOESTANDAR/NOMBRESNIVELES/NIVEL1"/>
					<xsl:value-of select="document($doc)/translation/texts/item[@name='de_productos']/node()"/>:&nbsp;
					<xsl:if test="/Mantenimiento/ACCION = 'NUEVOPRODUCTOESTANDAR'">
						<span class="camposObligatorios">*</span>
					</xsl:if>
				</td>
				<td class="textLeft">
				<xsl:choose>
				<!-- SOLO CONSULTA -->
				<xsl:when test="Mantenimiento/TIPO='CONSULTA'">
					<xsl:for-each select="Mantenimiento/PRODUCTOESTANDAR/CATEGORIAS/field/dropDownList/listElem">
						<xsl:if test="ID=../../@current">
							<xsl:value-of select="listItem"/>
						</xsl:if>
					</xsl:for-each>
				</xsl:when>
				<!-- MODIFICACION -->
				<xsl:otherwise>
					<xsl:choose>
					<!-- PUEDE CREAR NUEVOS O MODIFICAR EL NOMBRE Y DATOS DE CONSUMO -->
					<xsl:when test="Mantenimiento/PRODUCTOESTANDAR/MASTER or Mantenimiento/PRODUCTOESTANDAR/MASTER_UNICO">
						<!-- NUEVO -->
						<xsl:choose>
						<xsl:when test="Mantenimiento/PRODUCTOESTANDAR/ID='0'">
							<xsl:call-template name="desplegable">
								<xsl:with-param name="path" select="Mantenimiento/PRODUCTOESTANDAR/CATEGORIAS/field"/>
							</xsl:call-template>
						</xsl:when>
						<!-- modificacion -->
						<xsl:otherwise>
							<xsl:call-template name="desplegable_disabled">
								<xsl:with-param name="path" select="Mantenimiento/PRODUCTOESTANDAR/CATEGORIAS/field"/>
							</xsl:call-template>
							<!--<xsl:for-each select="Mantenimiento/PRODUCTOESTANDAR/FAMILIAS/field/dropDownList/listElem">
								<xsl:if test="ID=../../@current">
									<input type="hidden" name="CATPRIV_IDFAMILIA" value="{ID}"/>
									<xsl:value-of select="listItem"/>
								</xsl:if>
							</xsl:for-each>-->
						</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<!-- USUARIO EDICION, EDICIONES RESTRINGIDAS, SOLO EL NOMBRE Y DATOS DE CONSUMO -->
					<xsl:otherwise>
						<xsl:for-each select="Mantenimiento/PRODUCTOESTANDAR/CATEGORIAS/field/dropDownList/listElem">
							<xsl:if test="ID=../../@current">
								<xsl:value-of select="listItem"/>
								<input type="hidden" name="CATPRIV_IDCATEGORIA" value="{ID}"/>
							</xsl:if>
						</xsl:for-each>
					</xsl:otherwise>
					</xsl:choose>
				</xsl:otherwise>
				</xsl:choose>
				</td>
				<td>&nbsp;</td>
			</tr>
		</xsl:when>
		<xsl:otherwise>
			<input type="hidden" name="CATPRIV_IDCATEGORIA" value="{Mantenimiento/PRODUCTOESTANDAR/IDCATEGORIA}"/>
		</xsl:otherwise>
		</xsl:choose>

			<tr class="sinLinea">
				<td>&nbsp;</td>
				<td class="labelRight trentacinco">
					<xsl:value-of select="Mantenimiento/PRODUCTOESTANDAR/NOMBRESNIVELES/NIVEL2"/>
					<xsl:value-of select="document($doc)/translation/texts/item[@name='de_productos']/node()"/>:&nbsp;
					<xsl:if test="/Mantenimiento/ACCION = 'NUEVOPRODUCTOESTANDAR'">
						<span class="camposObligatorios">*</span>
					</xsl:if>
				</td>
				<td class="textLeft">
				<xsl:choose>
				<!-- SOLO CONSULTA -->
				<xsl:when test="Mantenimiento/TIPO='CONSULTA'">
					<!--<xsl:for-each select="Mantenimiento/PRODUCTOESTANDAR/FAMILIAS/field/dropDownList/listElem">
						<xsl:if test="ID=../../@current">
							<xsl:value-of select="listItem"/>
						</xsl:if>
					</xsl:for-each>-->
					<xsl:for-each select="Mantenimiento/PRODUCTOESTANDAR/TODASSUBFAMILIAS/CATEGORIA/FAMILIA">
						<!--<xsl:value-of select="@current"/>
						<xsl:value-of select="ID"/>-->
						<xsl:if test="ID = @current">
							<xsl:value-of select="listItem"/>
						</xsl:if>
					</xsl:for-each>
				</xsl:when>
				<!-- MODIFICACION -->
				<xsl:otherwise>
					<xsl:choose>
					<!-- PUEDE CREAR NUEVOS O MODIFICAR EL NOMBRE Y DATOS DE CONSUMO -->
					<xsl:when test="Mantenimiento/PRODUCTOESTANDAR/MASTER or Mantenimiento/PRODUCTOESTANDAR/MASTER_UNICO">
						<!-- NUEVO -->
						<xsl:choose>
						<xsl:when test="Mantenimiento/PRODUCTOESTANDAR/ID='0'">
							<xsl:call-template name="desplegable">
								<xsl:with-param name="path" select="Mantenimiento/PRODUCTOESTANDAR/FAMILIAS/field"/>
							</xsl:call-template>
						</xsl:when>
						<!-- modificacion -->
						<xsl:otherwise>
							<xsl:call-template name="desplegable_disabled">
								<xsl:with-param name="path" select="Mantenimiento/PRODUCTOESTANDAR/FAMILIAS/field"/>
							</xsl:call-template>
							
						</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<!-- USUARIO EDICION, EDICIONES RESTRINGIDAS, SOLO EL NOMBRE Y DATOS DE CONSUMO -->
					<xsl:otherwise>
						<xsl:for-each select="Mantenimiento/PRODUCTOESTANDAR/FAMILIAS/field/dropDownList/listElem">
							<xsl:if test="ID=../../@current">
								<xsl:value-of select="listItem"/>
								<input type="hidden" name="CATPRIV_IDFAMILIA" value="{ID}"/>
							</xsl:if>
						</xsl:for-each>
					</xsl:otherwise>
					</xsl:choose>
				</xsl:otherwise>
				</xsl:choose>
				</td>
				<td>&nbsp;</td>
			</tr>
			<tr class="sinLinea">
				<td>&nbsp;</td>
				<td class="labelRight trentacinco">
					<xsl:value-of select="Mantenimiento/PRODUCTOESTANDAR/NOMBRESNIVELES/NIVEL3"/>
					<xsl:value-of select="document($doc)/translation/texts/item[@name='de_productos']/node()"/>:&nbsp;
					<xsl:if test="/Mantenimiento/ACCION = 'NUEVOPRODUCTOESTANDAR'">
						<span class="camposObligatorios">*</span>
					</xsl:if>
				</td>
				<td class="textLeft">
				<xsl:choose>
				<!-- CONSULTA -->
				<xsl:when test="/Mantenimiento/TIPO='CONSULTA'">
					<xsl:for-each select="/Mantenimiento/PRODUCTOESTANDAR/SUBFAMILIAS/field/dropDownList/listElem">
						<xsl:if test="ID=../../@current">
							<xsl:value-of select="listItem"/>
						</xsl:if>
					</xsl:for-each>
				</xsl:when>
				<!-- MODIFICACION -->
				<xsl:otherwise>
					<xsl:choose>
					<!-- usuario master y master unico, solo nuevos o modificaciones de nombre y datos de consumo -->
					<xsl:when test="/Mantenimiento/PRODUCTOESTANDAR/MASTER or /Mantenimiento/PRODUCTOESTANDAR/MASTER_UNICO">
						<!-- NUEVO -->
						<xsl:choose>
						<xsl:when test="/Mantenimiento/PRODUCTOESTANDAR/ID='0'">
							<xsl:call-template name="desplegable">
								<xsl:with-param name="path" select="/Mantenimiento/PRODUCTOESTANDAR/SUBFAMILIAS/field"/>
							</xsl:call-template>
						</xsl:when>
						<!-- modificacion -->
						<xsl:otherwise>
							<xsl:call-template name="desplegable_disabled">
								<xsl:with-param name="path" select="/Mantenimiento/PRODUCTOESTANDAR/SUBFAMILIAS/field"/>
							</xsl:call-template>
						</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<!-- usuario edicion, modificaciones restringidas, solo nombre y datos de consumo -->
					<xsl:otherwise>
						<xsl:for-each select="/Mantenimiento/PRODUCTOESTANDAR/SUBFAMILIAS/field/dropDownList/listElem">
							<xsl:if test="ID=../../@current">
								<xsl:value-of select="listItem"/>
								<input type="hidden" name="CATPRIV_IDSUBFAMILIA" value="{ID}"/>
							</xsl:if>
						</xsl:for-each>
					</xsl:otherwise>
					</xsl:choose>
				</xsl:otherwise>
				</xsl:choose>
				</td>
				<td>&nbsp;</td>
			</tr>

		<xsl:choose>
		<xsl:when test="Mantenimiento/PRODUCTOESTANDAR/GRUPOS">
			<tr class="sinLinea">
				<td>&nbsp;</td>
				<td class="labelRight trentacinco">
					<xsl:value-of select="Mantenimiento/PRODUCTOESTANDAR/NOMBRESNIVELES/NIVEL4"/>
					<xsl:value-of select="document($doc)/translation/texts/item[@name='de_productos']/node()"/>:&nbsp;
					<xsl:if test="/Mantenimiento/ACCION = 'NUEVOPRODUCTOESTANDAR'">
						<span class="camposObligatorios">*</span>
					</xsl:if>
				</td>
				<td class="textLeft">
				<xsl:choose>
				<!-- SOLO CONSULTA -->
				<xsl:when test="Mantenimiento/TIPO='CONSULTA'">
					<xsl:for-each select="Mantenimiento/PRODUCTOESTANDAR/GRUPOS/field/dropDownList/listElem">
						<xsl:if test="ID=../../@current">
							<xsl:value-of select="listItem"/>
						</xsl:if>
					</xsl:for-each>
				</xsl:when>
				<!-- MODIFICACION -->
				<xsl:otherwise>
					<xsl:choose>
					<!-- PUEDE CREAR NUEVOS O MODIFICAR EL NOMBRE Y DATOS DE CONSUMO -->
					<xsl:when test="Mantenimiento/PRODUCTOESTANDAR/MASTER or Mantenimiento/PRODUCTOESTANDAR/MASTER_UNICO">
						<!-- NUEVO -->
						<xsl:choose>
						<xsl:when test="Mantenimiento/PRODUCTOESTANDAR/ID='0'">
							<xsl:call-template name="desplegable">
								<xsl:with-param name="path" select="Mantenimiento/PRODUCTOESTANDAR/GRUPOS/field"/>
								<xsl:with-param name="id">CATPRIV_IDGRUPO</xsl:with-param>
								<xsl:with-param name="onChange">ReferenciaGrupo()</xsl:with-param>
							</xsl:call-template>
						</xsl:when>
						<!-- modificacion -->
						<xsl:otherwise>
							<xsl:call-template name="desplegable_disabled">
								<xsl:with-param name="path" select="Mantenimiento/PRODUCTOESTANDAR/GRUPOS/field"/>
								<xsl:with-param name="id">CATPRIV_IDGRUPO</xsl:with-param>
							</xsl:call-template>
							
						</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<!-- USUARIO EDICION, EDICIONES RESTRINGIDAS, SOLO EL NOMBRE Y DATOS DE CONSUMO -->
					<xsl:otherwise>
						<xsl:for-each select="Mantenimiento/PRODUCTOESTANDAR/GRUPOS/field/dropDownList/listElem">
							<xsl:if test="ID=../../@current">
								<xsl:value-of select="listItem"/>
								<input type="hidden" name="CATPRIV_IDGRUPO" id="CATPRIV_IDGRUPO" value="{ID}"/>
							</xsl:if>
						</xsl:for-each>
					</xsl:otherwise>
					</xsl:choose>
				</xsl:otherwise>
				</xsl:choose>
				</td>
				<td>&nbsp;</td>
			</tr>
		</xsl:when>
		<xsl:otherwise>
			<input type="hidden" name="CATPRIV_IDGRUPO" id="CATPRIV_IDGRUPO" value="{Mantenimiento/PRODUCTOESTANDAR/IDGRUPO}">
				<xsl:if test="/Mantenimiento/PRODUCTOESTANDAR/ID = 0 and (/Mantenimiento/PRODUCTOESTANDAR/MASTER or /Mantenimiento/PRODUCTOESTANDAR/MASTER_UNICO)">
					<xsl:attribute name="onchange">ReferenciaGrupo()</xsl:attribute>
				</xsl:if>
                        </input>
		</xsl:otherwise>
		</xsl:choose>

			<tr class="sinLinea">
				<td>&nbsp;</td>
				<td class="labelRight trentacinco" valign="top">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='referencia']/node()"/>:&nbsp;
					<span class="camposObligatorios">*</span>
				</td>
				
				<xsl:choose>
				<!--consulta -->
				<xsl:when test="Mantenimiento/TIPO='CONSULTA'">
					<td class="textLeft"><xsl:value-of select="Mantenimiento/PRODUCTOESTANDAR/REFERENCIA"/></td>
				</xsl:when>
				<!-- modificacion -->
				<xsl:otherwise>
					<xsl:choose>
					
					<!-- usuario master, solo nombre y datos de consumos -->
					<xsl:when test="Mantenimiento/PRODUCTOESTANDAR/MASTER or Mantenimiento/PRODUCTOESTANDAR/MASTER_UNICO">
						<!-- NUEVO -->
						<xsl:choose>
						<xsl:when test="Mantenimiento/PRODUCTOESTANDAR/ID='0'">
							<td class="textLeft">
								<input type="text" class="noinput peq" name="CATPRIV_REFERENCIA_TXT" id="CATPRIV_REFERENCIA_TXT" disabled="disabled" size="5"/>
								<input type="hidden" name="CATPRIV_REFERENCIA_STRING1" id="CATPRIV_REFERENCIA_STRING1"/>
								<input type="text" class="muypeq" id="CATPRIV_REF" name="CATPRIV_REFERENCIA_STRING2" size="2" maxlength="3"/>&nbsp;
								<input type="hidden" name="CATPRIV_REFERENCIA_AUX"/>
								<input type="hidden" name="CATPRIV_REFERENCIA"/>&nbsp;
								<a href="javascript:ValidarRefProdEstandar(document.forms[0]);" style="text-decoration:none;">
									<xsl:choose>
									<xsl:when test="/Mantenimiento/LANG = 'portugues'">
										<img src="http://www.newco.dev.br/images/comprobar-BR.gif" alt="Verificar"/>
									</xsl:when>
									<xsl:otherwise>
										<img src="http://www.newco.dev.br/images/comprobar.gif" alt="Comprobar"/>
									</xsl:otherwise>
									</xsl:choose>
								</a>
								<span id="RefProd_OK" style="display:none;">&nbsp;
									<img src="http://www.newco.dev.br/images/recibido.gif">
										<xsl:attribute name="alt"><xsl:value-of select="document($doc)/translation/texts/item[@name='referencia_correcta']/node()"/></xsl:attribute>
                                                                        </img>
								</span>
								<span id="RefProd_ERROR" style="color:#FE2E2E;display:none;">&nbsp;
									<img src="http://www.newco.dev.br/images/error.gif">
										<xsl:attribute name="alt"><xsl:value-of select="document($doc)/translation/texts/item[@name='existe_referencia']/node()"/></xsl:attribute>
                                                                        </img>&nbsp;
									<xsl:value-of select="document($doc)/translation/texts/item[@name='existe_ref_prod_est']/node()"/>
								</span><br />
								<span id="ley_ref_prodestandar">&nbsp;</span>
							</td>
						</xsl:when>
						<!-- modificacion -->
						<xsl:otherwise>
							<td class="textLeft">
								<input type="text" class="noinput peq" name="CATPRIV_REFERENCIA_TXT" id="CATPRIV_REFERENCIA_TXT" value="{substring(Mantenimiento/PRODUCTOESTANDAR/REFERENCIA,1,6)}" disabled="disabled" size="5"/>
								<input type="hidden" name="CATPRIV_REFERENCIA_STRING1" value="{substring(Mantenimiento/PRODUCTOESTANDAR/REFERENCIA,1,6)}"/>
								<input type="text" class="muypeq" id="CATPRIV_REF" name="CATPRIV_REFERENCIA_STRING2" value="{substring(Mantenimiento/PRODUCTOESTANDAR/REFERENCIA,7)}" maxlength="3" size="2"/>
								<input type="hidden" name="CATPRIV_REFERENCIA_AUX" value="{Mantenimiento/PRODUCTOESTANDAR/REFERENCIA}"/>
								<input type="hidden" name="CATPRIV_REFERENCIA"/>&nbsp;
								<a href="javascript:ValidarRefProdEstandar(document.forms[0]);" style="text-decoration:none;">
									<xsl:choose>
									<xsl:when test="/Mantenimiento/LANG = 'portugues'">
										<img src="http://www.newco.dev.br/images/comprobar-BR.gif" alt="Verificar"/>
									</xsl:when>
									<xsl:otherwise>
										<img src="http://www.newco.dev.br/images/comprobar.gif" alt="Comprobar"/>
									</xsl:otherwise>
									</xsl:choose>
								</a>
								<span id="RefProd_OK" style="display:none;">&nbsp;
									<img src="http://www.newco.dev.br/images/recibido.gif">
										<xsl:attribute name="alt"><xsl:value-of select="document($doc)/translation/texts/item[@name='referencia_correcta']/node()"/></xsl:attribute>
                                                                        </img>
								</span>
								<span id="RefProd_ERROR" style="color:#FE2E2E;display:none;">&nbsp;
									<img src="http://www.newco.dev.br/images/error.gif">
										<xsl:attribute name="alt"><xsl:value-of select="document($doc)/translation/texts/item[@name='existe_referencia']/node()"/></xsl:attribute>
                                                                        </img>&nbsp;
									<xsl:value-of select="document($doc)/translation/texts/item[@name='existe_ref_prod_est']/node()"/>
								</span><br />
								<em><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_prod_estandar_3chars']/node()"/></em><br/>
								<span id="ley_ref_prodestandar">&nbsp;</span>
							</td>

						</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<!-- usuario edicion, solo ediciones restringidas, nombre y datos de consumo -->
					<xsl:otherwise>
						<td class="sesanta textLeft">
							<strong>
							<xsl:if test="Mantenimiento/PRODUCTOESTANDAR/REFERENCIA!=''">
								<xsl:value-of select="Mantenimiento/PRODUCTOESTANDAR/REFERENCIA"/>.&nbsp;
							</xsl:if>
							<xsl:value-of select="document($doc)/translation/texts/item[@name='Catalogo_padre']/node()"/>:<xsl:value-of select="Mantenimiento/PRODUCTOESTANDAR/CATALOGO_PADRE"/>.
							</strong> 
							<input type="hidden" name="CATPRIV_REFERENCIA" value="{Mantenimiento/PRODUCTOESTANDAR/REFERENCIA}"/>
						</td>
					</xsl:otherwise>
					</xsl:choose>
				</xsl:otherwise>
				</xsl:choose>

				<td>&nbsp;</td>
			</tr>
			<tr class="sinLinea">
				<td>&nbsp;</td>
				<td class="labelRight trentacinco">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='nombre']/node()"/>:&nbsp;
					<span class="camposObligatorios">*</span>
				</td>
				<td class="textLeft">
				<xsl:choose>
				<!-- consulta -->
				<xsl:when test="Mantenimiento/TIPO='CONSULTA'">
					<xsl:value-of select="Mantenimiento/PRODUCTOESTANDAR/NOMBRE"/>
				</xsl:when>
				<!-- edicion -->
				<xsl:otherwise>
					<input type="text" class="muygrande" id="CATPRIV_NOMBRE" name="CATPRIV_NOMBRE" value="{Mantenimiento/PRODUCTOESTANDAR/NOMBRE}" size="70" maxlength="300"/>
					<!-- si es un producto que sigue un catpriv_de otra empresa
					mostramos el boton de restaurtar nombre, en el caso de que se hubiera salido del catalogo -->
					<xsl:if test="not(Mantenimiento/PRODUCTOESTANDAR/MASTER_UNICO) and not(Mantenimiento/PRODUCTOESTANDAR/MASTER)">
						<xsl:if test="Mantenimiento/PRODUCTOESTANDAR/NOMBREPADRE='N'">
							<input type="hidden" name="CATPRIV_PADRE" value="{Mantenimiento/PRODUCTOESTANDAR/NOMBREPADRE}"/>
							<xsl:call-template name="botonPersonalizado">
								<xsl:with-param name="funcion">restaurarNombre(document.forms['form1'].elements['CATPRIV_NOMBRE'],'<xsl:value-of select="Mantenimiento/PRODUCTOESTANDAR/NOMBREPRODUCTO_PADRE"/>',document.forms['form1'].elements['CATPRIV_PADRE']);</xsl:with-param>
								<xsl:with-param name="label">Restaurar Nombre</xsl:with-param>
								<xsl:with-param name="status">Restaura el nombre del producto con el del cat�logo que sigue</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
					</xsl:if>
				</xsl:otherwise>
				</xsl:choose>
				</td>
				<td>&nbsp;</td>
			</tr>
			<tr class="sinLinea">
				<td>&nbsp;</td>
				<td class="labelRight trentacinco">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='completar_nombre']/node()"/>:&nbsp;
				</td>
				<td class="textLeft">
				<xsl:choose>
				<!-- consulta -->
				<xsl:when test="Mantenimiento/TIPO='CONSULTA'">
					<xsl:value-of select="Mantenimiento/PRODUCTOESTANDAR/NOMBRE_PRIVADO"/>
				</xsl:when>
				<!-- edicion -->
				<xsl:otherwise>
					<input type="text" class="muygrande" name="CATPRIV_NOMBRE_PRIVADO" value="{Mantenimiento/PRODUCTOESTANDAR/NOMBRE_PRIVADO}" size="70" maxlength="300"/>
				</xsl:otherwise>
				</xsl:choose>
					&nbsp;(<xsl:value-of select="document($doc)/translation/texts/item[@name='particular']/node()"/>)
				</td>
				<td>&nbsp;</td>
			</tr>
            <!--marcas aceptadas-->
            <tr class="sinLinea">
				<td>&nbsp;</td>
				<td class="labelRight trentacinco">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='marcas']/node()"/>:&nbsp;
				</td>
				<td class="textLeft">
					<xsl:choose>
					<!-- consulta -->
					<xsl:when test="Mantenimiento/TIPO='CONSULTA'">
						<xsl:value-of select="Mantenimiento/PRODUCTOESTANDAR/MARCASACEPTABLES"/>
					</xsl:when>
					<!-- edicion -->
					<xsl:otherwise>
						<input type="text" class="muygrande" name="MARCAS" id="MARCAS" value="{Mantenimiento/PRODUCTOESTANDAR/MARCASACEPTABLES}" size="70" maxlength="300"/>
					</xsl:otherwise>
					</xsl:choose>
				</td>
				<td>&nbsp;</td>
			</tr>
            <!--28cot16	unidad b�sica-->
            <tr class="sinLinea">
				<td>&nbsp;</td>
				<td class="labelRight trentacinco">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='unidad_basica']/node()"/>:&nbsp;
				</td>
				<td class="textLeft">
					<xsl:choose>
					<!-- consulta -->
					<xsl:when test="Mantenimiento/TIPO='CONSULTA'">
						<xsl:value-of select="Mantenimiento/PRODUCTOESTANDAR/UNIDADBASICA"/>
					</xsl:when>
					<!-- edicion -->
					<xsl:otherwise>
						<input type="text" name="CATPRIV_UNIDADBASICA" id="CATPRIV_UNIDADBASICA" value="{Mantenimiento/PRODUCTOESTANDAR/UNIDADBASICA}" size="10" maxlength="300"/>
					</xsl:otherwise>
					</xsl:choose>
				</td>
				<td>&nbsp;</td>
			</tr>
            <!--iva-->
            <xsl:choose>
            <xsl:when test="Mantenimiento/PRODUCTOESTANDAR/IDPAIS != 55 and (not(Mantenimiento/PRODUCTOESTANDAR/ADJUDICADO) or Mantenimiento/PRODUCTOESTANDAR/IDTIPOIVA = '')">
            <tr class="sinLinea">
				<td>&nbsp;</td>
				<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='iva']/node()"/>:&nbsp;</td>
                <td class="textLeft">
                    <xsl:call-template name="desplegable">
                        <xsl:with-param name="path" select="Mantenimiento/PRODUCTOESTANDAR/IVA/field" />
                        <xsl:with-param name="defecto" select="Mantenimiento/PRODUCTOESTANDAR/IDTIPOIVA" />
                        <xsl:with-param name="claSel">select80</xsl:with-param>
                    </xsl:call-template>
                </td>
				<td>&nbsp;</td>
			</tr>
            </xsl:when>
            <xsl:when test="Mantenimiento/PRODUCTOESTANDAR/IDPAIS != 55 and Mantenimiento/PRODUCTOESTANDAR/ADJUDICADO">
            <tr class="sinLinea">
				<td>&nbsp;</td>
				<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='iva']/node()"/>:</td>
                <td class="textLeft"><xsl:value-of select="Mantenimiento/PRODUCTOESTANDAR/IVA/field/dropDownList/listElem[ID = /Mantenimiento/PRODUCTOESTANDAR/IDTIPOIVA]/listItem" />
                    <input type="hidden" name="PRO_IDTIPOIVA" id="PRO_IDTIPOIVA" value="{Mantenimiento/PRODUCTOESTANDAR/IDTIPOIVA}" />
                </td>
				<td>&nbsp;</td>
			</tr>
            </xsl:when>
            <xsl:otherwise>
                <input type="hidden" name="PRO_IDTIPOIVA" id="PRO_IDTIPOIVA" value="{Mantenimiento/PRODUCTOESTANDAR/IDTIPOIVA}" />
            </xsl:otherwise>
            </xsl:choose>
            <!--fin de iva solo para espa�a-->
            <tr class="sinLinea">
				<td>&nbsp;</td>
				<td class="labelRight trentacinco">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='precio_ref']/node()"/>:&nbsp;
				</td>
				<td class="textLeft">
                    <xsl:choose>
                    <!-- consulta -->
                    <xsl:when test="Mantenimiento/TIPO='CONSULTA'">
                        <xsl:value-of select="Mantenimiento/PRODUCTOESTANDAR/PRECIOREFERENCIA_FORMATO" />
                    </xsl:when>
                    <!-- edicion -->
                    <xsl:otherwise>
                        <input type="hidden" name="CATPRIV_PRECIOREFERENCIA_OLD" value="{Mantenimiento/PRODUCTOESTANDAR/PRECIOREFERENCIA_FORMATO}" size="10" maxlength="20"/>
                        <input type="text" name="CATPRIV_PRECIOREFERENCIA" value="{Mantenimiento/PRODUCTOESTANDAR/PRECIOREFERENCIA_FORMATO}" size="10" maxlength="20"/>
                    </xsl:otherwise>
				</xsl:choose>&nbsp;<xsl:value-of select="Mantenimiento/PRODUCTOESTANDAR/DIV_SUFIJO"/>
				</td>
				<td>&nbsp;</td>
			</tr>
            <!--a�adido 16-4-15 solo si CP_PRO_PRECIOREFERENCIA_CLI IS NOT NULL OR CP_PRO_CANTIDADANUAL_CLI esta informado-->
            <xsl:if test="Mantenimiento/PRODUCTOESTANDAR/CP_PRO_PRECIOREFERENCIA_CLI != ''">
            <tr class="sinLinea">
				<td>&nbsp;</td>
				<td class="labelRight trentacinco">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='precio_historico_original']/node()"/>:&nbsp;
				</td>
				<td class="textLeft">
                    <xsl:value-of select="Mantenimiento/PRODUCTOESTANDAR/CP_PRO_PRECIOREFERENCIA_CLI" />
                    &nbsp;<xsl:value-of select="Mantenimiento/PRODUCTOESTANDAR/DIV_SUFIJO"/>
                    <!--&nbsp;
                    <span class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='cantidad_compra_anual']/node()"/>:</span>&nbsp;
                    <xsl:value-of select="Mantenimiento/PRODUCTOESTANDAR/CP_PRO_CANTIDADANUAL_CLI" />
                    &nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='eur']/node()"/>-->
				</td>
				<td>&nbsp;</td>
			</tr>
            </xsl:if>
            <xsl:if test="Mantenimiento/PRODUCTOESTANDAR/CP_PRO_CANTIDADANUAL_CLI != '' ">
            <tr class="sinLinea">
				<td>&nbsp;</td>
				<td class="labelRight trentacinco">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='cantidad_compra_anual']/node()"/>:&nbsp;
				</td>
				<td class="textLeft">
                    <xsl:value-of select="Mantenimiento/PRODUCTOESTANDAR/CP_PRO_CANTIDADANUAL_CLI" />
                    &nbsp;<xsl:value-of select="Mantenimiento/PRODUCTOESTANDAR/DIV_SUFIJO"/>
				</td>
				<td>&nbsp;</td>
			</tr>
           </xsl:if>
            <xsl:if test="Mantenimiento/PRODUCTOESTANDAR/COMPRAMEDIAMENSUALUNIDADES_FORMATO != ''">
            <tr class="sinLinea">
				<td>&nbsp;</td>
				<td class="labelRight trentacinco">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='cantidad_compra_mensual_unidades']/node()"/>:&nbsp;
				</td>
				<td class="textLeft">
                    <xsl:value-of select="Mantenimiento/PRODUCTOESTANDAR/COMPRAMEDIAMENSUALUNIDADES_FORMATO" />
                    &nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='unidades']/node()"/>
				</td>
				<td>&nbsp;</td>
			</tr>
           </xsl:if>

            <!--	medicamento regulado, en prioncipio solo colombia-->
            <xsl:choose>
            <xsl:when test="Mantenimiento/PRODUCTOESTANDAR/REGULADO">
            <tr class="sinLinea">
				<td>&nbsp;</td>
				<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='Regulado']/node()"/>:&nbsp;</td>
                <td class="textLeft">
					<input class="muypeq" type="checkbox" name="CHK_REGULADO">
            			<xsl:choose>
            			<xsl:when test="Mantenimiento/PRODUCTOESTANDAR/REGULADO='S'">
							<xsl:attribute name="checked" value="checked"/>
            			</xsl:when>
            			<xsl:otherwise>
 							<xsl:attribute name="unchecked" value="unchecked"/>
           				</xsl:otherwise>
            			</xsl:choose>
					</input>&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Regulado_expli']/node()"/>
                	<input type="hidden" name="REGULADO" id="REGULADO" value="N" />
                </td>
				<td>&nbsp;</td>
			</tr>
            </xsl:when>
            <xsl:otherwise>
                <input type="hidden" name="REGULADO" id="REGULADO" value="N" />
            </xsl:otherwise>
            </xsl:choose>
            <!--fin de iva solo para espa�a-->


			<tr class="sinLinea">
				<td>&nbsp;</td>
				<td class="labelRight trentacinco">
					<xsl:choose>
					<xsl:when test="Mantenimiento/PRODUCTOESTANDAR/NOMBREREFCLIENTE">
						<xsl:value-of select="Mantenimiento/PRODUCTOESTANDAR/NOMBREREFCLIENTE"/>:&nbsp;
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="document($doc)/translation/texts/item[@name='ref_cliente']/node()"/>:&nbsp;
					</xsl:otherwise>
					</xsl:choose>
				</td>
				<td class="textLeft">
					<xsl:choose>
					<xsl:when test="Mantenimiento/TIPO='CONSULTA'">
						<xsl:value-of select="Mantenimiento/PRODUCTOESTANDAR/REFCLIENTE"/>
					</xsl:when>
					<xsl:otherwise>
						<input type="hidden" name="CATPRIV_REFCLIENTE_AUX" id="CATPRIV_REFCLIENTE_AUX" value="{Mantenimiento/PRODUCTOESTANDAR/REFCLIENTE}"/>
						<input type="text" name="CATPRIV_REFCLIENTE" id="CATPRIV_REFCLIENTE" value="{Mantenimiento/PRODUCTOESTANDAR/REFCLIENTE}" size="10" maxlength="20"/>&nbsp;
						<a href="javascript:ValidarRefCliente(document.forms[0],'PRODUCTOESTANDAR');" style="text-decoration:none;">
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
							<xsl:value-of select="document($doc)/translation/texts/item[@name='existe_ref_cliente_prod_est']/node()"/>
						</span>
					</xsl:otherwise>
					</xsl:choose>
				</td>
				<td>&nbsp;</td>
			</tr>
			<xsl:if test="Mantenimiento/PRODUCTOESTANDAR/DATOS_AVANZADOS">
			<tr class="sinLinea">
				<td>&nbsp;</td>
				<td class="labelRight trentacinco">
					<xsl:choose>
					<xsl:when test="Mantenimiento/PRODUCTOESTANDAR/NOMBREREFCLIENTE2">
						<xsl:value-of select="Mantenimiento/PRODUCTOESTANDAR/NOMBREREFCLIENTE2"/>:&nbsp;
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="document($doc)/translation/texts/item[@name='ref_cliente']/node()"/>2:&nbsp;
					</xsl:otherwise>
					</xsl:choose>
				</td>
				<td class="textLeft">
					<xsl:choose>
					<xsl:when test="Mantenimiento/TIPO='CONSULTA'">
						<xsl:value-of select="Mantenimiento/PRODUCTOESTANDAR/REFCLIENTE2"/>
					</xsl:when>
					<xsl:otherwise>
						<input type="text" name="CATPRIV_REFCLIENTE2" id="CATPRIV_REFCLIENTE2" value="{Mantenimiento/PRODUCTOESTANDAR/REFCLIENTE2}" size="10" maxlength="20"/>&nbsp;
					</xsl:otherwise>
					</xsl:choose>
				</td>
				<td>&nbsp;</td>
			</tr>
			<tr class="sinLinea">
				<td>&nbsp;</td>
				<td class="labelRight trentacinco">
					<xsl:choose>
					<xsl:when test="Mantenimiento/PRODUCTOESTANDAR/NOMBREREFCLIENTE3">
						<xsl:value-of select="Mantenimiento/PRODUCTOESTANDAR/NOMBREREFCLIENTE3"/>:&nbsp;
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="document($doc)/translation/texts/item[@name='ref_cliente']/node()"/>3:&nbsp;
					</xsl:otherwise>
					</xsl:choose>
				</td>
				<td class="textLeft">
					<xsl:choose>
					<xsl:when test="Mantenimiento/TIPO='CONSULTA'">
						<xsl:value-of select="Mantenimiento/PRODUCTOESTANDAR/REFCLIENTE3"/>
					</xsl:when>
					<xsl:otherwise>
						<input type="text" name="CATPRIV_REFCLIENTE3" id="CATPRIV_REFCLIENTE3" value="{Mantenimiento/PRODUCTOESTANDAR/REFCLIENTE3}" size="10" maxlength="20"/>&nbsp;
					</xsl:otherwise>
					</xsl:choose>
				</td>
				<td>&nbsp;</td>
			</tr>
			<tr class="sinLinea">
				<td>&nbsp;</td>
				<td class="labelRight trentacinco">
					<xsl:choose>
					<xsl:when test="Mantenimiento/PRODUCTOESTANDAR/NOMBREREFCLIENTE4">
						<xsl:value-of select="Mantenimiento/PRODUCTOESTANDAR/NOMBREREFCLIENTE4"/>:&nbsp;
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="document($doc)/translation/texts/item[@name='ref_cliente']/node()"/>4:&nbsp;
					</xsl:otherwise>
					</xsl:choose>
				</td>
				<td class="textLeft">
					<xsl:choose>
					<xsl:when test="Mantenimiento/TIPO='CONSULTA'">
						<xsl:value-of select="Mantenimiento/PRODUCTOESTANDAR/REFCLIENTE4"/>
					</xsl:when>
					<xsl:otherwise>
						<input type="text" name="CATPRIV_REFCLIENTE4" id="CATPRIV_REFCLIENTE4" value="{Mantenimiento/PRODUCTOESTANDAR/REFCLIENTE4}" size="10" maxlength="20"/>&nbsp;
					</xsl:otherwise>
					</xsl:choose>
				</td>
				<td>&nbsp;</td>
			</tr>
			<tr class="sinLinea">
				<td>&nbsp;</td>
				<td class="labelRight trentacinco">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='Unidad_media_base']/node()"/>:&nbsp;
				</td>
				<td class="textLeft">
					<xsl:choose>
					<xsl:when test="Mantenimiento/TIPO='CONSULTA'">
						<xsl:value-of select="Mantenimiento/PRODUCTOESTANDAR/UNIDADMEDIABASE"/>
					</xsl:when>
					<xsl:otherwise>
						<input type="text" name="UNIDADMEDIABASE" id="UNIDADMEDIABASE" value="{Mantenimiento/PRODUCTOESTANDAR/UNIDADMEDIABASE}" size="10" maxlength="20"/>&nbsp;
					</xsl:otherwise>
					</xsl:choose>
				</td>
				<td>&nbsp;</td>
			</tr>
			<tr class="sinLinea">
				<td>&nbsp;</td>
				<td class="labelRight trentacinco">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='Unidad_pedido']/node()"/>:&nbsp;
				</td>
				<td class="textLeft">
					<xsl:choose>
					<xsl:when test="Mantenimiento/TIPO='CONSULTA'">
						<xsl:value-of select="Mantenimiento/PRODUCTOESTANDAR/UNIDADPEDIDO"/>
					</xsl:when>
					<xsl:otherwise>
						<input type="text" name="UNIDADPEDIDO" id="UNIDADPEDIDO" value="{Mantenimiento/PRODUCTOESTANDAR/UNIDADPEDIDO}" size="10" maxlength="20"/>&nbsp;
					</xsl:otherwise>
					</xsl:choose>
				</td>
				<td>&nbsp;</td>
			</tr>
			<tr class="sinLinea">
				<td>&nbsp;</td>
				<td class="labelRight trentacinco">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='Relacion_base_pedido']/node()"/>:&nbsp;
				</td>
				<td class="textLeft">
					<xsl:choose>
					<xsl:when test="Mantenimiento/TIPO='CONSULTA'">
						<xsl:value-of select="Mantenimiento/PRODUCTOESTANDAR/RELACIONBASEPEDIDO"/>
					</xsl:when>
					<xsl:otherwise>
						<input type="text" name="RELACIONBASEPEDIDO" id="RELACIONBASEPEDIDO" value="{Mantenimiento/PRODUCTOESTANDAR/RELACIONBASEPEDIDO}" size="10" maxlength="20"/>&nbsp;
					</xsl:otherwise>
					</xsl:choose>
				</td>
				<td>&nbsp;</td>
			</tr>
			<tr class="sinLinea">
				<td>&nbsp;</td>
				<td class="labelRight trentacinco">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='Stock_minimo']/node()"/>:&nbsp;
				</td>
				<td class="textLeft">
					<xsl:choose>
					<xsl:when test="Mantenimiento/TIPO='CONSULTA'">
						<xsl:value-of select="Mantenimiento/PRODUCTOESTANDAR/STOCKMINIMO"/>
					</xsl:when>
					<xsl:otherwise>
						<input type="text" name="STOCKMINIMO" id="STOCKMINIMO" value="{Mantenimiento/PRODUCTOESTANDAR/STOCKMINIMO}" size="10" maxlength="20"/>&nbsp;
					</xsl:otherwise>
					</xsl:choose>
				</td>
				<td>&nbsp;</td>
			</tr>
			<tr class="sinLinea">
				<td>&nbsp;</td>
				<td class="labelRight trentacinco">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='Stock_maximo']/node()"/>:&nbsp;
				</td>
				<td class="textLeft">
					<xsl:choose>
					<xsl:when test="Mantenimiento/TIPO='CONSULTA'">
						<xsl:value-of select="Mantenimiento/PRODUCTOESTANDAR/STOCKMAXIMO"/>
					</xsl:when>
					<xsl:otherwise>
						<input type="text" name="STOCKMAXIMO" id="STOCKMAXIMO" value="{Mantenimiento/PRODUCTOESTANDAR/STOCKMAXIMO}" size="10" maxlength="20"/>&nbsp;
					</xsl:otherwise>
					</xsl:choose>
				</td>
				<td>&nbsp;</td>
			</tr>
			<tr class="sinLinea">
				<td>&nbsp;</td>
				<td class="labelRight trentacinco">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='Tipo_Producto']/node()"/>:&nbsp;
				</td>
				<td class="textLeft">
					<xsl:choose>
					<xsl:when test="Mantenimiento/TIPO='CONSULTA'">
						<xsl:value-of select="Mantenimiento/PRODUCTOESTANDAR/TIPOPRODUCTO"/>
					</xsl:when>
					<xsl:otherwise>
						<input type="text" name="TIPOPRODUCTO" id="TIPOPRODUCTO" value="{Mantenimiento/PRODUCTOESTANDAR/TIPOPRODUCTO}" size="10" maxlength="20"/>&nbsp;
					</xsl:otherwise>
					</xsl:choose>
				</td>
				<td>&nbsp;</td>
			</tr>
			<!--	Lista de centros	-->
			<tr class="sinLinea">
				<td>&nbsp;</td>
				<td class="labelRight trentacinco">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='Centros_autorizados']/node()"/>:&nbsp;
				</td>
				<td class="textLeft">
					&nbsp;
				</td>
				<td>&nbsp;</td>
			</tr>
			</xsl:if>
			<xsl:if test="Mantenimiento/PRODUCTOESTANDAR/DATOS_AVANZADOS or Mantenimiento/PRODUCTOESTANDAR/REFERENCIA_CLIENTE_POR_CENTRO">
			<xsl:for-each select="Mantenimiento/PRODUCTOESTANDAR/CENTROS/CENTRO">
			<tr class="sinLinea">
				<td>&nbsp;</td>
				<td class="labelRight trentacinco">
					<xsl:choose>
					<xsl:when test="Mantenimiento/TIPO='CONSULTA'">
						<xsl:choose>
						<xsl:when test="AUTORIZADO='S'">
							<input class="muypeq" type="checkbox" name="CHK_CENTRO_{CEN_ID}" checked="checked" disabled="true" />
						</xsl:when>
						<xsl:otherwise>
							<input class="muypeq" type="checkbox" name="CHK_CENTRO_{CEN_ID}" unchecked="unchecked" disabled="true" />
						</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:otherwise>
						<xsl:choose>
						<xsl:when test="AUTORIZADO='S'">
							<input class="muypeq" type="checkbox" name="CHK_CENTRO_{CEN_ID}" checked="checked"/>
						</xsl:when>
						<xsl:otherwise>
							<input class="muypeq" type="checkbox" name="CHK_CENTRO_{CEN_ID}" unchecked="unchecked"/>
						</xsl:otherwise>
						</xsl:choose>
					</xsl:otherwise>
					</xsl:choose>
					&nbsp;
				</td>
				<td class="textLeft">
					<xsl:choose>
					<xsl:when test="Mantenimiento/TIPO='CONSULTA'">
						<xsl:value-of select="REF_CENTRO"/>
					</xsl:when>
					<xsl:otherwise>
						<input type="text" name="REFCENTRO_{CEN_ID}" id="REFCENTRO_{CEN_ID}" value="{REF_CENTRO}" size="10" maxlength="20"/>
					</xsl:otherwise>
					</xsl:choose>
					&nbsp;<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/ProcesosCdC/CatalogoPrivado/Homologacion.xsql?IDEMPRESA={/Mantenimiento/CATPRIV_IDEMPRESA}&amp;IDCENTRO={CEN_ID}&amp;REFERENCIA={REF_CENTRO}','DetalleCentro',100,45,0,-50);"><xsl:value-of select="document($doc)/translation/texts/item[@name='Orden']/node()"/></a>:&nbsp;
					<xsl:choose>
					<xsl:when test="Mantenimiento/TIPO='CONSULTA'">
						<xsl:value-of select="ORDEN"/>
					</xsl:when>
					<xsl:otherwise>
						<input type="text" class="muypeq" name="ORDEN_{CEN_ID}" id="ORDEN_{CEN_ID}" value="{ORDEN}" size="2" maxlength="2"/>
					</xsl:otherwise>
					</xsl:choose>
					&nbsp;
					<xsl:value-of select="NOMBRE"/>
				</td>
				<td>&nbsp;</td>
			</tr>
			</xsl:for-each>
			</xsl:if>
			<tr class="sinLinea">
				<td>&nbsp;</td>
				<td class="labelRight trentacinco">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='Curva_ABC']/node()"/>:&nbsp;
				</td>
				<td class="textLeft">
					<xsl:choose>
					<xsl:when test="Mantenimiento/TIPO='CONSULTA'">
						<xsl:value-of select="Mantenimiento/PRODUCTOESTANDAR/CURVA_ABC"/>
					</xsl:when>
					<xsl:otherwise>
						<input type="text" name="CURVA_ABC" id="CURVA_ABC" class="muypeq" value="{Mantenimiento/PRODUCTOESTANDAR/CURVA_ABC}" size="1" maxlength="1"/>
					</xsl:otherwise>
					</xsl:choose>
				</td>
				<td>&nbsp;</td>
			</tr>
                       
        	<xsl:choose>
        	<xsl:when test="Mantenimiento/PRODUCTOESTANDAR/IDPAIS = 55">
        	<tr class="sinLinea">
				<td>&nbsp;</td>
				<td class="labelRight">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='requiere_licitacion']/node()"/>:</td>
                <td class="textLeft">
                     <xsl:choose>
                        <xsl:when test="Mantenimiento/PRODUCTOESTANDAR/REQUIERELICITACION='S'">
                         <input type="checkbox" class="muypeq" checked="checked" name="REQUIERELICITACION" />
                       </xsl:when>
                       <xsl:otherwise>
                         <input type="checkbox" class="muypeq" name="REQUIERELICITACION" />
                       </xsl:otherwise>
                     </xsl:choose>
                </td>
				<td>&nbsp;</td>
			</tr>
            </xsl:when>
            <xsl:otherwise><input type="hidden" name="REQUIERELICITACION" value="N" /></xsl:otherwise>
            </xsl:choose>

            <!--<xsl:choose>
            <xsl:when test="Mantenimiento/PRODUCTOESTANDAR/IDPAIS = '34'">-->
            <tr class="sinLinea">
				<td>&nbsp;</td>
				<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='licitacion']/node()"/>:</td>
                <td class="textLeft">
                    <strong>
                        <xsl:choose>
                        <xsl:when test="/Mantenimiento/PRODUCTOESTANDAR/IDTEXTOLICITACION != ''">
                            <xsl:value-of select="/Mantenimiento/PRODUCTOESTANDAR/IDTEXTOLICITACION"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="document($doc)/translation/texts/item[@name='sin_licitacion']/node()"/>
                        </xsl:otherwise>
                        </xsl:choose>
                    </strong>
                    <input type="hidden" name="CP_PRO_IDTEXTOLICITACION" id="CP_PRO_IDTEXTOLICITACION"  value="{Mantenimiento/PRODUCTOESTANDAR/IDTEXTOLICITACION}"/>
					&nbsp;&nbsp;&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_oferta']/node()"/>:<xsl:value-of select="/Mantenimiento/PRODUCTOESTANDAR/CP_PRO_FECHAOFERTA"/>
					&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Caduca']/node()"/>:<xsl:value-of select="/Mantenimiento/PRODUCTOESTANDAR/CP_PRO_FECHALIMITEOFERTA"/>
                </td>
				<td>&nbsp;</td>
			</tr>
            <!--</xsl:when>
            <xsl:otherwise>
                <input type="hidden" name="CP_PRO_IDTEXTOLICITACION" id="CP_PRO_IDTEXTOLICITACION"/>
            </xsl:otherwise>
            </xsl:choose>-->
			<tr class="sinLinea">
				<td>&nbsp;</td>
				<td colspan="2">&nbsp;</td>
				<td>&nbsp;</td>
			</tr>
			<tr class="sinLinea">
				<!--<td>&nbsp;</td>-->
                <td>&nbsp;</td>
				<td>&nbsp;
					<!--
                    <xsl:choose>
                    <xsl:when test="Mantenimiento/ACCION= 'NUEVOPRODUCTOESTANDAR'">
					<!- -	Bot�n "nuevo" - ->
					<div class="boton">
						<a href="javascript:GuardarProducto(document.forms[0],'NUEVOPRODUCTOESTANDAR');">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='guardar']/node()"/>
						</a>
					</div>
                    </xsl:when>
                    <xsl:when test="Mantenimiento/ACCION='MODIFICAR' or Mantenimiento/ACCION='MOVER' or Mantenimiento/ACCION='MODIFICARPRODUCTOESTANDAR' or Mantenimiento/ACCION= 'COPIARPRODUCTOESTANDAR'">
					<div class="boton">
						<a href="javascript:GuardarProducto(document.forms[0],'MODIFICAR');">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='guardar']/node()"/>
						</a>
					</div>
                    </xsl:when>
                    </xsl:choose>
					-->
				</td>
				<td class="textLeft">
                    &nbsp;&nbsp;
					<xsl:value-of select="document($doc)/translation/texts/item[@name='los_campos_marcados_con']/node()"/>
					&nbsp;(<span class="camposObligatorios">*</span>)&nbsp;
					<xsl:value-of select="document($doc)/translation/texts/item[@name='son_obligatorios']/node()"/>.
				</td>
				<td>&nbsp;</td>
			</tr>
		</table>
        <br />
        <!--solo si modifica producto-->
        <xsl:if test="Mantenimiento/ACCION= 'MODIFICARPRODUCTOESTANDAR' or Mantenimiento/ACCION= 'MODIFICAR' or Mantenimiento/ACCION= 'COPIARPRODUCTOESTANDAR' or Mantenimiento/ACCION='MOVER'">
		<!--<table class="mediaTabla">-->
		<table class="buscador">
        <tr class="sinLinea">
            <td class="trenta">&nbsp;</td>
            <td class="quince">    
				<a class="btnDestacado" href="javascript:GuardarProducto(document.forms[0],'COPIARPRODUCTOESTANDAR');">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='copiar']/node()"/>
				</a>
            </td>

            <td class="quince">
                <a class="btnDestacado" href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Gestion/Comercial/NuevaEvaluacionProducto.xsql?ID_PROD_ESTANDAR={/Mantenimiento/PRODUCTOESTANDAR/ID}&amp;EMP_ID={/Mantenimiento/CATPRIV_IDEMPRESA}','Evaluaci�n producto',100,80,0,-10);" style="text-decoration:none;">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='solicitar_evaluacion']/node()"/>
				</a>
            </td>                                
			<td>&nbsp;</td>
		</tr>
        </table>
        <br />
        <br />
                
        <!--insertar en una licitaci�n-->
        <xsl:if test="Mantenimiento/PRODUCTOESTANDAR/LICITACIONES != ''">
            <br />
            <br />
			<!--<table class="mediaTabla">-->
			<table class="buscador">
                <tr class="sinLinea">
				<td>&nbsp;</td>
				<td class="labelRight trentacinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='insertar_licitacion']/node()"/>:</td>
            	<td class="textLeft">
                	<xsl:call-template name="desplegable">
						<xsl:with-param name="path" select="Mantenimiento/PRODUCTOESTANDAR/LICITACIONES/field"/>
                    	<xsl:with-param name="claSel">select200</xsl:with-param>
					</xsl:call-template>&nbsp;

                	<a class="btnDestacadoPeq" href="javascript:InsertarProdLici(document.forms['form1']);">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='insertar']/node()"/>
                    <!--	<xsl:choose>
                        	<xsl:when test="Mantenimiento/PRODUCTOESTANDAR/IDPAIS = '34'"><img src="http://www.newco.dev.br/images/insertar.gif" alt="Insertar"/></xsl:when>
                        	<xsl:otherwise><img src="http://www.newco.dev.br/images/insertar-BR.gif" alt="Inserir"/></xsl:otherwise>
                    	</xsl:choose>
					-->
                	</a>
            	</td>
			</tr>
           </table>
        </xsl:if><!--fin de insertar en una licitaci�n-->

    </xsl:if><!--fin si es modifica de producto-->

    </div><!--fin de divleft-->
	</form>

	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:choose>
		<xsl:when test="/Mantenimiento/LANG"><xsl:value-of select="/Mantenimiento/LANG" /></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->
	<form name="MensajeJS">
		<input type="hidden" name="OBLI_FAMILIA_PROD_ESTANDAR" value="{document($doc)/translation/texts/item[@name='obli_familia_prod_estandar']/node()}"/>
		<input type="hidden" name="OBLI_REF_PROD_ESTANDAR" value="{document($doc)/translation/texts/item[@name='obli_ref_prod_estandar']/node()}"/>
		<input type="hidden" name="OBLI_NOMBRE_PROD_ESTANDAR" value="{document($doc)/translation/texts/item[@name='obli_nombre_prod_estandar']/node()}"/>
		<input type="hidden" name="OBLI_UN_BASICA_PROD_ESTANDAR" value="{document($doc)/translation/texts/item[@name='obli_un_basica_prod_estandar']/node()}"/>
		<input type="hidden" name="REF_DIFERENTE_PROD_ESTANDAR" value="{document($doc)/translation/texts/item[@name='ref_diferente_prod_estandar']/node()}"/>
		<input type="hidden" name="REF_NO_CORRECTA" value="{document($doc)/translation/texts/item[@name='ref_no_correcta']/node()}"/>
		<input type="hidden" name="NO_DERECHOS_PARA_CREAR" value="{document($doc)/translation/texts/item[@name='no_derechos_para_crear']/node()}"/>
		<input type="hidden" name="OBLI_PRECIO_REF_PROD_ESTANDAR" value="{document($doc)/translation/texts/item[@name='obli_precio_ref_prod_estandar']/node()}"/>
		<input type="hidden" name="OBLI_PRECIO_REF_PROD_ESTANDAR1" value="{document($doc)/translation/texts/item[@name='obli_precio_ref_prod_estandar1']/node()}"/>
		<input type="hidden" name="RESTAURAR_NOMBRE_PRODUCTO" value="{document($doc)/translation/texts/item[@name='restaurar_nombre_producto']/node()}"/>
		<input type="hidden" name="OBLI_NOMBRE_DIFFERENTE" value="{document($doc)/translation/texts/item[@name='obli_nombre_diferente']/node()}"/>
		<input type="hidden" name="OBLI_REF_DIFERENTE" value="{document($doc)/translation/texts/item[@name='obli_ref_diferente']/node()}"/>
		<input type="hidden" name="OBLI_REF_DIFERENTE1" value="{document($doc)/translation/texts/item[@name='obli_ref_diferente1']/node()}"/>
		<input type="hidden" name="NUEVO_PRODUCTO_NUEVA_REF" value="{document($doc)/translation/texts/item[@name='nuevo_producto_nueva_ref']/node()}"/>
		<input type="hidden" name="NUEVO_NOMBRE" value="{document($doc)/translation/texts/item[@name='nuevo_nombre']/node()}"/>
		<input type="hidden" name="NOMBRE_ACTUAL" value="{document($doc)/translation/texts/item[@name='nombre_actual']/node()}"/>
		<input type="hidden" name="MOVER_REF_ERROR" value="{document($doc)/translation/texts/item[@name='mover_ref_error']/node()}"/>
		<input type="hidden" name="LENGTH_REF_NUEVO_PROD_EST" value="{document($doc)/translation/texts/item[@name='length_ref_nuevo_prod_est']/node()}"/>
		<input type="hidden" name="REF_PROD_EST_YA_EXISTE" value="{document($doc)/translation/texts/item[@name='existe_ref_prod_est']/node()}"/>
		<input type="hidden" name="OBLI_REF_CLIENTE_PROD_ESTANDAR" value="{document($doc)/translation/texts/item[@name='obli_ref_cliente_prod_estandar']/node()}"/>
        <input type="hidden" name="SEGURO_CAMBIAR_PRECIO_REF" value="{document($doc)/translation/texts/item[@name='seguro_cambiar_precio_ref']/node()}"/>
        <input type="hidden" name="SEGURO_CAMBIAR_PRECIO_REF_ZERO" value="{document($doc)/translation/texts/item[@name='seguro_cambiar_precio_ref_zero']/node()}"/>
	</form>
</xsl:otherwise>
</xsl:choose>
</body>
</html>
</xsl:template>
</xsl:stylesheet>
