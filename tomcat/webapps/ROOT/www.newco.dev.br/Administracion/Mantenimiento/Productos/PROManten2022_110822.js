// JS para el mantenimiento de productos (catalogo proveedor)
// Ultima revisión: ET 08mar22 PROManten2022_110822.js

jQuery(document).ready(globalEvents);

function globalEvents(){
	//selecionar ofertas de proveedor

	//	12dic16	Marcamos la primera opción de menú
	jQuery("#pes_Ficha").css('background','#3b569b');
	jQuery("#pes_Ficha").css('color','#D6D6D6');

	// Se clica en pestañas
	jQuery("#pes_Tarifas").click(function(){
	
		//	Pendiente identificar si estamos en mantenimiento o en lectura
	
 		var IDProducto = document.forms['frmProducto'].elements['IDPRODUCTO'].value;
		window.location.assign("http://www.newco.dev.br/Administracion/Mantenimiento/Productos/PROTarifas2022.xsql?PRO_ID="+IDProducto);

	});
	jQuery("#pes_Documentos").click(function(){
	
		//	Pendiente identificar si estamos en mantenimiento o en lectura
	
 		var IDProducto = document.forms['frmProducto'].elements['IDPRODUCTO'].value;
		window.location.assign("http://www.newco.dev.br/Administracion/Mantenimiento/Productos/PRODocs2022.xsql?PRO_ID="+IDProducto);

	});
	jQuery("#pes_Pack").click(function(){
	
		//	Pendiente identificar si estamos en mantenimiento o en lectura
	
 		var IDProducto = document.forms['frmProducto'].elements['IDPRODUCTO'].value;
		window.location.assign("http://www.newco.dev.br/Administracion/Mantenimiento/Productos/PROPack2022.xsql?PRO_ID="+IDProducto);

	});

	jQuery("#pes_Empaquetamiento").click(function(){
	
		//	Pendiente identificar si estamos en mantenimiento o en lectura
	
 		var IDProducto = document.forms['frmProducto'].elements['IDPRODUCTO'].value;
		window.location.assign("http://www.newco.dev.br/Administracion/Mantenimiento/Productos/PROEmpaquetamientos2022.xsql?PRO_ID="+IDProducto);

	});

	jQuery("#IDPROVEEDOR").change(function(){
		var IDProveedor = this.value;

		SeleccionaFichas(IDProveedor,'IDFICHA','-1','lista');

		var IDOfertaTipo = '';
		// Recupero todos los desplegables de las ofertas segun el IDOfertaTipo
		jQuery(".inputPrecio").each(function(){
			IDOfertaTipo = this.id.substring(19); // Extraigo los tipos y los guardo en un la variable auxiliar para asarlo como parametro a la siguiente funcion
			SeleccionaOfertas(IDProveedor,IDOfertaTipo,'lista');
		});
	});

	// Recupera Tipo al inicio y cuando cambia el valor del desplegable (sólo si existe el desplegable tipoIVA)
	if(jQuery("#PRO_IDTIPOIVA").length){
		RecuperaTipoIVA();
		jQuery("#PRO_IDTIPOIVA").bind("change",function(){
			RecuperaTipoIVA();
			jQuery(".inputPrecioIVA").each(function(i, obj){
				if(obj.value){
					calcularPreciosSinIVA(obj);
				}
			});
		});

		// Campos precios conIVA (sólo usuarios MVM de España)
		jQuery(".inputPrecioIVA").bind("change paste keyup",function(){
			calcularPreciosSinIVA(this);
		});
	}
}//fin de globalEvents


function BuscadorCatProv()
{
	document.location="http://www.newco.dev.br/Administracion/Mantenimiento/Productos/CatProvUnica2022.html";
}


function RecuperaTipoIVA(){
	var IDtipoIVA = jQuery("#PRO_IDTIPOIVA").val();
	var d = new Date();

	jQuery.ajax({
		cache:	false,
		async:	false,
		url:	'http://www.newco.dev.br/Administracion/Mantenimiento/Productos/RecuperaTipoIVAAJAX.xsql',
		type:	"GET",
		data:	"IDTIPOIVA="+IDtipoIVA+"&_="+d.getTime(),
		contentType: "application/xhtml+xml",
		beforeSend:function(){
			jQuery('.alertPrecioIVA').hide();
		},
		success: function(objeto){
			var data = JSON.parse(objeto);

			if(data.estado == 'OK'){
				tipoIVA = data.TipoIVA;
			}else{
				RecuperaTipoIVA();
			}
		},
		error: function(xhr, errorString, exception) {
			alert("xhr.status="+xhr.status+" error="+errorString+" exception="+exception);
		}
	});
}

// Calcula el precio sinIVA cuando se introduce el precio conIVA y se realizan validaciones
function calcularPreciosSinIVA(obj){
	var IDPrecioConIVA = obj.id;
	var PrecioConIVA = obj.value;
	var PrecioConIVAFmt = PrecioConIVA.replace(',','.');
	var tipoOferta = IDPrecioConIVA.substr(23);

	jQuery('#alertPrecioIVA_' + tipoOferta).hide();

	if(!isNaN(PrecioConIVAFmt)){
		var IDPrecio = 'PRO_PRECIOUNITARIO_' + tipoOferta;
		var Precio = Number(Round(PrecioConIVAFmt * (100/(100 + parseFloat(tipoIVA))) + 'e' + 4) + 'e-' + 4);
		var PrecioFmt = Precio.toString().replace('.',',');
		if(PrecioFmt == '0')		PrecioFmt = '';
		jQuery("#" + IDPrecio).val(PrecioFmt);

		// comprobacion de seguridad para mostrar alert si el precio cIVA recalculado no coincide con el que está escrito
		var newPrecioIVA = Number(Round(Precio * ((100 + parseFloat(tipoIVA))/100) + 'e' + 4) + 'e-' + 4);
		if(newPrecioIVA != PrecioConIVAFmt){
			jQuery('#alertPrecioIVA_' + tipoOferta).show();
		}
	}else{
		alert(precio_cIVA_mal_formado);
		return;
	}
}

//validar ref proveedor
function ValidarRefProd()
{
	var formu=document.forms['frmProducto']
    var Referencia = formu.elements['PRO_REFERENCIA'].value;
    var Prove = formu.elements['IDPROVEEDOR'].value;
    var idProd = formu.elements['PRO_ID'].value;

    jQuery("#RefProd_ERROR").hide();
    jQuery("#RefProd_OK").hide();
    jQuery("#RefProd_VACIO").hide();

    if (Referencia != ''){
			jQuery.ajax({
				cache:	false,
				url:	'http://www.newco.dev.br/Administracion/Mantenimiento/Productos/ValidarRefProdJSON.xsql',
				type:	"GET",
				data:	"IDPROVE="+Prove+"&REFERENCIA="+Referencia,
				contentType: "application/xhtml+xml",
				success: function(objeto){
					var data = eval("(" + objeto + ")");

                    //si estado es diferente de vacío o de NULL implica que ya hay idprod, si igual al que hay ok, si no significa ref ya cogida
                    //alert(data.estado);
					if(data.estado != '' && data.estado != 'NULL'){
                    	if (data.estado == idProd)
						{	//si es igual significa ok esta bien
                        	jQuery("#PRO_REFERENCIA").css("background-color", "#BCF5A9");
							jQuery("#RefProd_OK").show();
                    	}
                    	else{
							jQuery("#PRO_REFERENCIA").css("background-color", "#F5A9A9");
							jQuery("#RefProd_ERROR").show();
							formu.elements['PRO_REFERENCIA'].focus();
                         }
					}
					else
					{
						// Si no hay error continuamos
						jQuery("#PRO_REFERENCIA").css("background-color", "#BCF5A9");
						jQuery("#RefProd_OK").show();
					}
				},
				error: function(xhr, errorString, exception) {
					alert("xhr.status="+xhr.status+" error="+errorString+" exception="+exception);
				}
			});
        }//fin if si referencia diferente de vacío
        else{
            jQuery("#RefProd_VACIO").show();
        }
} //fin validarRefProd


//cambiar fecha limite
function cambiaFecha(tipoOferta){
	var form			= document.forms['frmProducto'];
	var fechaLimite			= 'FECHA_LIMITE_'+tipoOferta;
	var enviarFechaLimite		= 'EnviarFecha_'+tipoOferta;
	var modificarFechaLimite	= 'ModificaFecha_'+tipoOferta;

	form.elements[fechaLimite].setAttribute('class','');

	jQuery("#"+modificarFechaLimite).hide();
	jQuery("#"+enviarFechaLimite).show();
}

//actualizarFechaLimite funcion de la pagina actualizarFechaLimite
function actualizarFechaLimite(tipoOferta){
	var form = document.forms['frmProducto'];
	var msg = '';
	var idProd = form.elements['PRO_ID'].value;
	var idCliente = form.elements['CLIENTE_ID_'+tipoOferta].value;
	var IDFechaLimite = 'FECHA_LIMITE_'+tipoOferta;
	var valueFechaLimite = form.elements[IDFechaLimite].value;
	var errorFechaLimite = document.forms['mensajeJS'].elements['ERROR_GUARDAR_FECHA'].value;
	var enviarFechaLimite = 'EnviarFecha_'+tipoOferta;
	var modificarFechaLimite = 'ModificaFecha_'+tipoOferta;
	var d = new Date();

	if (form.elements['FECHA_LIMITE_'+tipoOferta].value == ''){ msg += document.forms['mensajeJS'].elements['FECHA_LIMITE_OBLI'].value;}

	if (msg == ''){
		jQuery.ajax({
			cache:	false,
			url:	'http://www.newco.dev.br/Administracion/Mantenimiento/Productos/ActualizarFechaLimite.xsql',
			type:	"GET",
			data:	"PRO_ID="+idProd+"&CLIENTE_ID="+idCliente+"&FECHA_LIMITE="+valueFechaLimite+"&_="+d.getTime(),
			contentType: "application/xhtml+xml",
			success: function(objeto){
				var data = eval("(" + objeto + ")");

				if(data.ActualizarFechaLimite.estado == 'OK'){
					form.elements[IDFechaLimite].setAttribute('class','noinput');
					jQuery("#"+modificarFechaLimite).show();
					jQuery("#"+enviarFechaLimite).hide();
				}else{
					alert('Error: \n' + data.ActualizarFechaLimite.message + '\n' + errorFechaLimite);
				}
			},
			error: function(xhr, errorString, exception) {
				alert("xhr.status="+xhr.status+" error="+errorString+" exception="+exception);
			}
		});
	}else{alert(msg);}
}// fin de actualizarFechaLimite


//abro pagina de catalogo privado con ref estandar propuesta
function MostrarPagCatalogo(pag,titulo,p_ancho,p_alto,p_desfaseLeft,p_desfaseTop){
	var ample,alcada,esquerra,alt;
	var formu = document.forms['frmProducto'];
	var ref = '';	//formu.elements['PRO_REF_ESTANDAR'].value;
	var pagina = pag+'?REFERENCIA='+ref;

	if(titulo==null)
		titulo='MedicalVM';

	if(is_nav){
		ample		= (top.screen.availWidth*p_ancho)/100;
		alcada		= (top.screen.availHeight*p_alto)/100;
		esquerra	= parseInt(((top.screen.availWidth-ample) / 2)+((((top.screen.availWidth-ample) / 2)*p_desfaseLeft)/100));
		alt		= parseInt(((top.screen.availHeight-alcada) / 2)+((((top.screen.availHeight-alcada) / 2)*p_desfaseTop)/100));

		if(titulo && titulo.open){
			titulo.close();
		}

		titulo=window.open(pagina,titulo,'toolbar=no,menubar=no,status=no,scrollbars=yes,resizable=yes,width='+ample+',height='+alcada+',screenX='+esquerra+',screenY='+alt);
		titulo.focus();
	}else{
		ample		= (top.screen.availWidth*p_ancho)/100;
		alcada		= (top.screen.availHeight*p_alto)/100;
		esquerra	= parseInt(((top.screen.availWidth-ample) / 2)+((((top.screen.availWidth-ample) / 2)*p_desfaseLeft)/100));
		alt		= parseInt(((top.screen.availHeight-alcada) / 2)+((((top.screen.availHeight-alcada) / 2)*p_desfaseTop)/100));

		if(titulo &&  titulo.open && !titulo.closed){
			titulo.close();
		}

		titulo=window.open(pagina,titulo,'toolbar=no,menubar=no,status=no,scrollbars=yes,resizable=yes,width='+ample+',height='+alcada+',top='+alt+',left='+esquerra);
		titulo.focus();
	}
}//fin de abrir pagina


//changeIVA si prod es de farmacia pongo el iva a 4%
function ChangeIVA(){
	var formu = document.forms['frmProducto'];
	var proCat = formu.elements['PRO_CATEGORIA_CHK'].checked;

	if(proCat == true){
		formu.elements['PRO_IDTIPOIVA'].value = '2';
	}else{
		formu.elements['PRO_IDTIPOIVA'].value = '10';
	}
}//fin changeIVA


//boton borrar producto
function BorrarProd(){
	var formu=document.forms['frmProducto'];
	if (confirm(document.forms['mensajeJS'].elements['SEGURO_ELIMINAR_PRODUCTO'].value))
	{
		formu.elements['PRO_BORRAR_VAL'].value = 'S';
		EnviaProd();
	}
}


//compruebo los cambios si es solicitud de proveedor
function CompruebaCambios(formu, accion){
	// Esconder boton guardar para evitar doble-click
	if(jQuery('#botonGuardar').length)
		jQuery('#botonGuardar').hide();

	var todoIgual = '';
	var	arrPrecios	= new Array(),
		arrTipos	= new Array(),
		arrIDOferta	= new Array(),
		arrAntIDOferta	= new Array(),
		arrAntPrecio	= new Array();

	//si espanya iva, precio asisa, precio fncp
	if(formu.elements['PAIS'].value == '34'){
		if(formu.elements['ANT_PRO_IDTIPOIVA'].value != formu.elements['PRO_IDTIPOIVA'].value)
			todoIgual = 'NO';
        }

	jQuery(".inputPrecio").each(function(){
		this.value	= this.value.trim();
		arrPrecios.push(this.value);
		arrTipos.push(this.id.substring(19)); // Extraigo los tipos y los guardo en un array (OF, OA, OFNCP, etc...)
		arrAntPrecio.push(jQuery('#ANT_PRO_PRECIOUNITARIO_' + this.id.substring(19)).val());
		arrIDOferta.push(jQuery('#IDOFERTA_' + this.id.substring(19)).val());
		arrAntIDOferta.push(jQuery('#ANT_IDOFERTA_' + this.id.substring(19)).val());
	});

	for(var i=0; i<arrTipos.length; i++){
		if(arrPrecios[i] != arrAntPrecio[i])
			todoIgual = 'NO';
		if(arrIDOferta[i] != arrAntIDOferta[i] && arrIDOferta[i] != -1)
			todoIgual = 'NO';
		if(arrPrecios[i] != '' && arrIDOferta[i] == -1){
			alert(document.forms['mensajeJS'].elements['SELECCIONA_OFERTA'].value);
			// Volvemos a mostrar el boton para que puedan reenviar el formulario
			jQuery('#botonGuardar').show();
			return;
                }
	}

	//check farmacia
	if(formu.elements['PRO_CATEGORIA_CHK'].checked != true && formu.elements['ANT_FARMACIA'].value == 'F')
		todoIgual = 'NO';
	if(formu.elements['PRO_CATEGORIA_CHK'].checked != false && formu.elements['ANT_FARMACIA'].value != 'F')
		todoIgual = 'NO';

	


	//compruebo cambios en ficha
	if(formu.elements['ANT_FICHA'].value != formu.elements['IDFICHA'].value && formu.elements['IDFICHA'].value != '-1')
		todoIgual = 'NO';

	//imagen
	var image = formu.elements['CADENA_IMAGENES'].value;
	var imageOne = image.split("|");
	var imageOk = imageOne[1];
        //alert('img borradas '+document.getElementsByName('IMAGENES_BORRADAS')[0].value);
        //alert('img '+ formu.elements['CADENA_IMAGENES'].value);

	if(formu.elements['ANT_IMAGEN'].value != imageOk || (formu.elements['inputFile'].value != '' && formu.elements['ANT_IMAGEN'].value =='') || document.getElementsByName('IMAGENES_BORRADAS')[0].value != '')
		todoIgual = 'NO';

	//todoIgual NO => no vacio => envio porque hubo cambios
	if(todoIgual != ''){
		EnviaProd();
	}else{
		alert(document.forms['mensajeJS'].elements['NO_CAMBIOS_NO_SOLICITUD'].value);
		// Volvemos a mostrar el boton para que puedan reenviar el formulario
		jQuery('#botonGuardar').show();
	}
}//fin cambio prov comprobacion


// Envia los cambiosa la BBDD para guardar
function EnviaProd()
{

	var formu=document.forms[0];
	var accion='PROManten2022.xsql';

	var msg = '';
        var precioError = '';

	var	arrPrecios	= new Array(),
		arrTipos	= new Array(),
		arrIDOferta	= new Array(),
		arrIDCliente	= new Array(),
		arrAntTarifa	= new Array(),
		arrAntPrecio	= new Array(),
		arrNombreCorto	= new Array();

	jQuery(".inputPrecio").each(function(){
		this.value	= this.value.trim();
		arrPrecios.push(this.value);
        arrTipos.push(this.id.substring(19)); // Extraigo los tipos y los guardo en un array (OF, OA, OFNCP, etc...)
		
		//solodebug	console.log('EnviaProd. Preparando arrays iniciales. Tipo:'+this.id.substring(19)+' precio:'+this.value);
		
	});

	for(var i=0; i<arrTipos.length; i++){
		arrIDCliente.push(jQuery('#IDCLIENTE_' + arrTipos[i]).val());
		arrAntTarifa.push(jQuery('#ANTIGUEDAD_TARIFA_' + arrTipos[i]).val());
		arrAntPrecio.push(jQuery('#ANT_PRO_PRECIOUNITARIO_' + arrTipos[i]).val());
		arrNombreCorto.push(jQuery('#NOMBRE_CORTO_' + arrTipos[i]).val());
		arrIDOferta.push(jQuery('#IDOFERTA_' + arrTipos[i]).val());

		//solodebug	console.log('EnviaProd. Preparando arrays clientes/tarifas envío: IDCLIENTE:'+jQuery('#IDCLIENTE_' + arrTipos[i]).val()+' precio anterior:'+jQuery('#ANTIGUEDAD_TARIFA_' + arrTipos[i]).val());
    }
	

	var ofertaAceptadaCliente	= document.forms['mensajeJS'].elements['OFERTA_ACEPTADA_CLIENTE'].value;
	var todaviaNo			= document.forms['mensajeJS'].elements['TODAVIA_NO'].value;
	var digitosIncorrectos		= document.forms['mensajeJS'].elements['DIGITOS_INCORRECTOS'].value;

	//5set11
	if(formu.elements['PRO_REQUIEREPRESUPUESTO_CHK']){
		if(formu.elements['PRO_REQUIEREPRESUPUESTO_CHK'].checked == true){
			formu.elements['PRO_REQUIEREPRESUPUESTO'].value = 'S';
		}else{
			formu.elements['PRO_REQUIEREPRESUPUESTO'].value = 'N';
		}
	}

        //2oct14
	if(formu.elements['PRO_OCULTO_CHK']){
		if(formu.elements['PRO_OCULTO_CHK'].checked == true){
			formu.elements['PRO_OCULTO'].value = 'S';
		}else{
			formu.elements['PRO_OCULTO'].value = 'N';
		}
	}

	if(formu.elements['PRO_CATEGORIA_CHK']){
		if(formu.elements['PRO_CATEGORIA_CHK'].checked == true){
			formu.elements['PRO_CATEGORIA'].value = 'F';
		}else{
			formu.elements['PRO_CATEGORIA'].value = 'N';
		}
	}

	if(formu.elements['PRO_REGULADO_CHK']){
		if(formu.elements['PRO_REGULADO_CHK'].checked == true){
			formu.elements['PRO_REGULADO'].value = 'S';
		}else{
			formu.elements['PRO_REGULADO'].value = 'N';
		}
	}

	var proRefEstan = '';	//document.forms['frmProducto'].elements['PRO_REF_ESTANDAR'].value;
	var lunProRefEstan = proRefEstan.length;

	/*if(document.forms['frmProducto'].elements['PRO_REF_ESTANDAR'].value != '' && lunProRefEstan != 8){
		msg = msg + digitosIncorrectos + '\n\n';
	}*/

	AsignarAccion(formu,accion);

	for(i=0; i<arrTipos.length; i++){
		//if(formu.elements['IDOFERTA_' + arrTipos[i]].value == '-1' && formu.elements['US_MVM'].value == 'no' && formu.elements['US_ADMINCLI'].value == 'no' && formu.elements['PRO_PRECIOUNITARIO_' + arrTipos[i]].value != ''){
		if(formu.elements['IDOFERTA_' + arrTipos[i]].value == '-1' && formu.elements['ROL'].value == 'VENDEDOR' && formu.elements['PRO_PRECIOUNITARIO_' + arrTipos[i]].value != ''){
			msg = msg + document.forms['mensajeJS'].elements['OFERTA_OBLI_CLIENTE'].value.replace('[[CLIENTE]]',arrNombreCorto[i])+'\n\n';
		}
	}

	if(formu.elements['IDPROVEEDOR'].value == '' || formu.elements['IDPROVEEDOR'].value == '-1' ){
		msg = msg + document.forms['mensajeJS'].elements['PROVEEDOR_OBLI'].value+'\n';
	}
	if(formu.elements['PRO_NOMBRE'].value == ''){
		msg = msg + document.forms['mensajeJS'].elements['NOMBRE_OBLI'].value+'\n';
	}
	if(formu.elements['PRO_REFERENCIA'].value == ''){
		msg = msg + document.forms['mensajeJS'].elements['REFERENCIA_OBLI'].value+'\n';
	}
	if(formu.elements['PRO_UNIDADBASICA'].value == ''){
		msg = msg + document.forms['mensajeJS'].elements['UNIDAD_BASICA_OBLI'].value+'\n';
	}
	//compruebo unidad lote, si vacio o no numerico
	formu.elements['PRO_UNIDADESPORLOTE'].value = formu.elements['PRO_UNIDADESPORLOTE'].value.trim();
	if(formu.elements['PRO_UNIDADESPORLOTE'].value == ''){
		msg = msg + document.forms['mensajeJS'].elements['UN_LOTE_OBLI'].value+'\n';
	}else{
		if(isNaN(formu.elements['PRO_UNIDADESPORLOTE'].value) !== false){
			msg = msg + document.forms['mensajeJS'].elements['ERROR_UN_LOTE_NO_NUMERO'].value+'\n';
		}
	}
	//fin de campos obligatorios antes errorcheck

	//borrar
	var bloqBorrar = '';
	if(formu.elements['PRO_BORRAR'] && formu.elements['PRO_BORRAR'].value == 'S'){
		var seguroBorrar = document.forms['mensajeJS'].elements['SEGURO_BORRAR'].value;
		if(confirm(seguroBorrar)){
			bloqBorrar = '';
		}else{
			bloqBorrar = 'SI';
		}
	}

    //controles que no se pongan caracteres raros en los campos de texto
    var regex_car_raros     = new RegExp("[\$|\#|\\|\'|\&\|]","g"); //caracteres raros que no queremos en los campos de texto (requisito MVM)
    var raros = 0;
    //var inputText = [formu.elements['PRO_REFERENCIA'].value,formu.elements['PRO_REF_ESTANDAR'].value,formu.elements['PRO_NOMBRE'].value,formu.elements['PRO_UNIDADBASICA'].value,formu.elements['PRO_VALOR_CERTIFICADO'].value];
    var inputText = [formu.elements['PRO_REFERENCIA'].value,'' /*formu.elements['PRO_REF_ESTANDAR'].value*/,formu.elements['PRO_UNIDADBASICA'].value,formu.elements['PRO_VALOR_CERTIFICADO'].value];

    for (var i=0;i<inputText.length;i++){
    //var f=checkRegEx(inputText[i], regex_car_raros); alert ('valor f '+f);
        if(checkRegEx(inputText[i], regex_car_raros)){
            raros=1;
        }
        else { }
    }//fin for caracteres raros
    if (raros =='1') msg = msg + document.forms['mensajeJS'].elements['CAR_RAROS'].value+'\n';


	var IDOferta;
	formu.elements['PRO_LISTA_CAMBIOS'].value = '';
	for(i=0; i<arrTipos.length; i++){
		(arrIDOferta[i] != '-1') ? IDOferta = arrIDOferta[i] : IDOferta = '';


		//console.log('EnviaProd. PRO_LISTA_CAMBIOS['+i+']. IDCliente:'+arrIDCliente[i] + ' Precio:' + arrPrecios[i] + ' IDOferta:' + IDOferta + '#');

		formu.elements['PRO_LISTA_CAMBIOS'].value = formu.elements['PRO_LISTA_CAMBIOS'].value + arrIDCliente[i] + '|' + arrPrecios[i] + '|' + IDOferta + '#';
	}



	//console.log('EnviaProd. PRO_LISTA_CAMBIOS:'+formu.elements['PRO_LISTA_CAMBIOS'].value);



	//si el provee quiere borrar => diferente de Si un prod no paso por controles de anteguedad ni si esta asociadas ofertas-->
	if(formu.elements['PRO_BORRAR'] && formu.elements['PRO_BORRAR'].value == 'S' && bloqBorrar == ''){
        jQuery('#ACCION').val('BORRAR');
		SubmitForm(formu);
	}else{
		if(msg == ''){
            // Esconder boton guardar para evitar doble-click
            if(jQuery('#botonGuardar').length && jQuery('#botonGuardar').is(':visible'))
            jQuery('#botonGuardar').hide();
			
			//si hay imagenes
			if(hasFiles(formu)){
				var target = 'uploadFrame';
				var action = 'http://www.newco.dev.br/cgi-bin/imageMVM.pl';
				var enctype = 'multipart/form-data';
				formu.target = target;
				formu.encoding = enctype;
				formu.action = action;
				wait("Please wait...");
				formu.submit();
				form_tmp = formu;
				man_tmp = true;
				periodicTimer = 0;
				periodicUpdate();
			}else{
                jQuery('#ACCION').val('MODIFICAR');
				SubmitForm(formu);
			}
		}else{
			alert(msg);
			jQuery('#botonGuardar').show();
		}
	}//fin if si es borrar
}

//crear un nuevo producto de uno existente
function CrearNuevoProd(formu,accion){

    var msg = '';

    if (formu.elements['PRO_REFERENCIA'].value == formu.elements['PRO_REFERENCIA_ORIG'].value){
        msg = msg + document.forms['mensajeJS'].elements['NO_MISMA_REFERENCIA'].value+'\n';
    }

    //creo nuevo prod de existente entonces id_pro debe estar vacío
    formu.elements['PRO_ID'].value = '';
    //alert(formu.elements['PRO_ID'].value);

    if (msg != ''){ alert(msg); }

    else{ EnviaProd(); }


}

function conteoDePulsaciones(fieldObj,countFieldName,maxChars){
	var countField = eval("fieldObj.form."+countFieldName);
	var diff = maxChars - fieldObj.value.length;

	// Need to check & enforce limit here also in case user pastes data
	if(diff < 0){
		fieldObj.value = fieldObj.value.substring(0,maxChars);
		diff = maxChars - fieldObj.value.length;
	}
	countField.value = diff;
}

function longitudMaxima(fieldObj,maxChars){
	var result = true;

	if(fieldObj.value.length >= maxChars)
		result = false;

	if(window.event)
		window.event.returnValue = result;

	return result;
}


// IMAGE UPLOAD       ----------------------------------------------------------
var IMG_WIDTH = 200;
var IMG_HEIGHT = 200;
var IMG_SMALL_WIDTH = 50;
var IMG_SMALL_HEIGHT = 50;
var MAX_WAIT = 30;
var numImages = 0;
var uploadFiles = new Array();
var periodicTimer = 0;


//	Add new Line with remove button
function hasFiles(form){
	for(var i=1; i<form.length; i++){
		if(form.elements[i].type == 'file' && (form.elements[i].name == 'inputFile') && form.elements[i].value != ''){
			return true;
		}
	}
	return false;
}

function addFile(id){
	var uploadElem = document.getElementById("inputFile_" + id);

	console.log('addFile id:'+id);

	if(uploadElem.value != ''){
		uploadFiles[uploadFiles.length] = uploadElem.value;

		if (!document.getElementById("inputLink_" + id)){
			var rmLink = document.createElement('div');

			rmLink.setAttribute("class","remove");
			jQuery('Element').append(rmLink);
			rmLink.setAttribute('id', 'inputLink_' + id);
			rmLink.innerHTML = '<a href="javascript:removeFile(\'' + id + '\');">Remove</a>';
			document.getElementById("imageLine_" + id).appendChild(rmLink);
		}
	}else{
		uploadFiles.splice(id, 1);
		document.getElementById("imageLine_" + id).removeChild(document.getElementById("inputLink_" + id));
	}

	displayFiles();

	cargaImagen(document.forms['frmProducto'],'{$tipo}');	//	22ene20

	return true;
}


//	Remove line with remove button
function removeFile(id){
	var clearedInput;
	var uploadElem = document.getElementById("inputFile_" + id);

	uploadElem.value = '';
	clearedInput = uploadElem.cloneNode(false);
	uploadElem.parentNode.insertBefore(clearedInput, uploadElem);
	uploadElem.parentNode.removeChild(uploadElem);
	uploadFiles.splice(id, 1);
	document.getElementById("imageLine_" + id).removeChild(document.getElementById("inputLink_" + id));
	displayFiles();
	return undefined;
}

// Display new line for image
function displayFiles(){

	console.log('displayFiles');
	
	for(var i=1; i<6; i++){
		if(document.getElementById("inputFile_" + i) && document.getElementById("inputFile_" + i).value != '' && document.getElementById("imageLine_" + (1+i))){
			document.getElementById("imageLine_" + (1+i)).style.display = '';
		}
	}
	return true;
}

//22ene20 Faltaba enviar la imagen al servidor
function cargaImagen(form)
{

	console.log('cargaImagen');

	if(uploadFrameDoc && uploadFrameDoc.document && uploadFrameDoc.document.getElementsByTagName("body")[0]){
		uploadFrameDoc.document.getElementsByTagName("body")[0].innerHTML = "";
	}

	var msg = '';

	if(msg != ''){
		alert(msg);
	}else{
		if(hasFiles(form)){
			console.log('cargaImagen hasFiles');
			var target = 'uploadFrame';
			var action = 'http://www.newco.dev.br/cgi-bin/uploadDocsMVM.pl';			//22ene20 uploadDocsMVM.pl o imageMVM.pl
			var enctype = 'multipart/form-data';
			form.target = target;
			form.encoding = enctype;
			form.action = action;
			form_tmp = form;
			man_tmp = true;
			periodicTimer = 0;
			periodicUpdate();
			form.submit();
		}
	}//fin else
}
//fin de carga documentos js


// Check periodically if the image upload is finished
function periodicUpdate()
{

	console.log('periodicUpdate');

	if(periodicTimer >= MAX_WAIT){
		alert("we waited " + MAX_WAIT + " seconds and the upload still did not finish, so we suspect sth. went wrong ;-)\n\nYou should press the stop button of your browser!\n");
		return false;
	}
	periodicTimer++;

	if(window.frames['uploadFrame'] && window.frames['uploadFrame'].document && window.frames['uploadFrame'].document.getElementsByTagName("p")[0]){

		document.getElementById('waitBox').style.display = 'none';

		var uFrame = window.frames['uploadFrame'].document.getElementsByTagName("p")[0];
		if(uFrame.innerHTML.substr(0, 1) != '{' && uFrame.innerHTML.substr(0, 1) != '['){
			alert("An undefined error occurred, please notify the admin");
			return false;
		}
		else
		{
			var response = eval('('+uFrame.innerHTML+')');
			
			console.log('periodicUpdate imageChain:'+uFrame.innerHTML+' response.length:'+response.imagenes.length);
			
			handleFileRequest(response.imagenes);
			return true;
		}
	}
	else
	{
		window.setTimeout(periodicUpdate,1000);
		return false;
	}
	return true;
}


// handle Request after file (or image) upload
// @param {Array} resp Hopefully JSON string array
function handleFileRequest(resp){
	var lang = new String('');
	var form = form_tmp;
	var msg = '';
	var msgHeader = 'Se ha producido errores en el upload de imagenes!<br /><br />'
	var target = '';
	var enctype = 'application/x-www-form-urlencoded';
	var imageChain = new String('');
	var UrlAccion = 'http://www.newco.dev.br/Administracion/Mantenimiento/Productos/PROManten2022.xsql';

	console.log('handleFileRequest resp.length:'+resp.length);

	if(resp instanceof Array && resp.length > 0){
		for(var i=0; i<resp.length; i++)
		{
			
			console.log('handleFileRequest resp['+i+']. big:'+resp[i].big+', small:'+resp[i].small);
		
			if(resp[i].big && resp[i].small){
				var lungmax = resp[i].small.length;
				var lungmin = resp[i].small.length;
			}
		}
	}

	if(resp instanceof Array && resp.length > 0){
		for(i=0; i<resp.length; i++){
			if(resp[i].error && resp[i].error != ''){
				msg += resp[i].error;
			}else if(resp[i].big && resp[i].small){
				imageChain += 'mvm' + '|' + resp[i].small + '|' + resp[i].big + '#';
			}
		}

		console.log('handleFileRequest imageChain:'+imageChain+' msg:'+msg);

		if(msg == ''){

			console.log('PROMantenSave2022');
			
			document.getElementsByName('CADENA_IMAGENES')[0].value = imageChain;
			form.encoding = enctype;
			form.target = target;
			form.action = UrlAccion;

			//redundante con la línea anterior AsignarAccion(document.forms['frmProducto'],UrlAccion);

			SubmitForm(document.forms['frmProducto']);
		}
	}else if(resp.length < 1){
		msg += "Parece que tus ficheros son demasiados grandes.<br />";
	}else{
		msg += "Se ha producido un error.<br />";
	}

	if(msg != ''){
		msg = msgHeader + msg;
		return false;
	}

	return true;
}

function wait(text) {
	//aparece el loading arriba en messageError
	jQuery('#waitBox').html ('<img src="http://www.newco.dev.br/images/loading.gif" />');
	if(jQuery('#ocultoButton'))	jQuery('#ocultoButton').hide();
	jQuery('#waitBox').show();
	return false;
}

/**
 * Prepare image for removing
 * @param {string} fileId Database-ID of the image
 * @param {int} num Number of
 * @return Boolean
 * @author Martin Gangkofer gangkofer@gmail.com
 */
function deleteFile(fileId, num) {


	var uploadElem = document.getElementById("inputFile_" + num);
	var labelElem = document.getElementById("labelFile_" + num);
	var deleteChain = document.getElementsByName('IMAGENES_BORRADAS')[0].value;
	uploadElem.style.display = '';
	labelElem.style.display = '';
	uploadElem.value = '';
	deleteChain += fileId + '|S#';
	document.getElementsByName('IMAGENES_BORRADAS')[0].value = deleteChain;
    document.forms['frmProducto'].elements['CADENA_IMAGENES'].value = '';
	return false;
}


//	9mar22 Abre el catalogo privado, utilizando los campos Ref y Nombre como parametros
function AbrirCatalogoPrivadoProducto()
{
	var Ref=document.forms['frmProducto'].elements['PRO_REFERENCIA'].value;
	var Nombre=document.forms['frmProducto'].elements['PRO_NOMBRE'].value;
	CatalogoPrivadoProducto(Ref, Nombre);		//	funcion en basic2022_010822.js
}
