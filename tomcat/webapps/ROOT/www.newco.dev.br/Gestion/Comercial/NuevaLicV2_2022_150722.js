//	Funciones JS de la página principal de la licitación (creado desde lic2022_260122.js)
//	Ultima revisión ET 22abr22 11:15 NuevaLicV2_2022_150722.js


//	Variables para envio de ficheros
var	uploadFilesDoc = new Array();
var	periodicTimerDoc = 0;
var	MAX_WAIT_DOC = 100;



function onloadEvents()
{	
	// Informar desplegable 'Duracion adjudicacion'
	seleccionaMeses();
	
	//	19set19 Muestra u oculta los campos según si es licitacion spot
	camposLicitacionSpot();


	// si hay campo en el desplegable de meses duracion => muestro o escondo los campos para pedidos puntuales
	jQuery('select#LIC_MESES').change(function(){
		
		camposLicitacionSpot();

	});
	// Si se hace cambio en el usuario responsable del pedido puntual => se recarga el desplegable de lugares de entrega
	jQuery('select#LIC_IDUSUARIOPEDIDO').change(function(){
		if(this.value != '')
		{
			recuperaObservacionesPedido(this.value);
			recuperaLugaresEntrega(this.value);
		}
		else
			jQuery('select#LIC_IDLUGARENTREGA').empty().append("<option value=''>" + str_Selecciona + "</option>");
	});

	// Cambio en el tipo de vista de la pestanya productos
	jQuery("select#tipoVista").change(function(){
		muestraNuevaVistaProductos(this.value);
	});

	formateaTextareas();

}


// Inicializa el menu desplegable de los meses de la licitacion con el valor por defecto o el valor guardado
function seleccionaMeses(){
	
	//15set16 El valor por defecto se envía desde la base de datos
	//if(mesesSelected == '')	mesesSelected = '12';	/* Valor por defecto para nueva licitacion */
	//jQuery("#LIC_MESES").val(mesesSelected);

	if(mesesSelected == '')	mesesSelected = jQuery("#LIC_MESES").val();
	
	// Si es pedido puntual => mostrar campos necesarios para generar el pedido
	if((mesesSelected == '0') && (isLicAgregada == 'N')){
		jQuery('.campoPedidoPuntual').show();
		jQuery('.campoPedidoPuntual_Inv').hide();
	}
}


//	Muestra u oculta los campos dependiendo de si es liciatcion SPOT o no
function camposLicitacionSpot()
{

	try
	{	
		if((document.forms['form1'].elements['LIC_MESES'].value == '0')&&(isLicAgregada=='N')){ // Pedido puntual, y no es licitación agregada		
			jQuery('.campoPedidoPuntual').show();
			jQuery('.campoPedidoPuntual_Inv').hide();
		}else{
			jQuery('.campoPedidoPuntual').hide();
			jQuery('.campoPedidoPuntual_Inv').show();
		}
	}
	catch(err)
	{
	}
}


//	Comprueba y guarda el formulario. Mantenemos parametros por compatibilidad 
function ValidarFormulario(oForm, nombre, flag){
	var errores=0, eliminarOfertas='S';

	
	/* quitamos los espacios sobrantes  */
	for(var n=0; n < oForm.length; n++){
		if(oForm.elements[n].type=='text'){
			oForm.elements[n].value=oForm.elements[n].value.trim();
		}
	}

	if(nombre == 'datosGenerales')
	{
		var msgError='',fechaDec,
		 hoy = new Date(),
		 dd = hoy.getDate(),
		 mm = hoy.getMonth() + 1, 				//January is 0!
		 yyyy = hoy.getFullYear();
		 
		 hoyOrd=yyyy*10000+mm*100+dd;			//	Este formato es más eficiente para comparar fechas
		 
		//solodebug	debug('ValidarFormulario. datosGenerales. fecha dec.:'+oForm.elements['LIC_FECHADECISION'].value);
		if((esNulo(oForm.elements['LIC_TITULO'].value))){
			errores++;
			//alert(val_faltaTitulo);
			msgError+=val_faltaTitulo+'\n';
			oForm.elements['LIC_TITULO'].focus();
		}

		if((esNulo(oForm.elements['LIC_FECHADECISION'].value))){
			errores++;
			//alert(val_faltaFechaDecision);
			msgError+=val_faltaFechaDecision+'\n';
			oForm.elements['LIC_FECHADECISION'].focus();
		}
		else if(!errores && CheckDate(oForm.elements['LIC_FECHADECISION'].value))
		{
			errores++;
			//alert(val_malFechaDecision);
			msgError+=val_malFechaDecision+'\n';
			oForm.elements['LIC_FECHADECISION'].focus();
		}
		else if (fechaDecisionLic!=oForm.elements['LIC_FECHADECISION'].value)	//	18feb20 Solo chequeamos la fecha de decision si ha sido modificada
		{
			fechaDec=parseInt(Piece(oForm.elements['LIC_FECHADECISION'].value,'/',2))*10000+parseInt(Piece(oForm.elements['LIC_FECHADECISION'].value,'/',1))*100+parseInt(Piece(oForm.elements['LIC_FECHADECISION'].value,'/',0));
			
			//solodebug	alert('hoyOrd:'+hoyOrd+' fechaDec:'+fechaDec);

			if (fechaDec<10000000) fechaDec=20000000+fechaDec;			//5may21 Solucionado error (fechaDec<100000000)
			
			//CAMBIAR CUANDO LA LIBRERIA ESTÉ ACTUALIZADA fechaDec=dateToInteger(oForm.elements['LIC_FECHADECISION'].value);
			
			//solodebug	alert('hoyOrd:'+hoyOrd+' fechaDec:'+fechaDec);
			
			if(!errores && (fechaDec<hoyOrd))
			{
				errores++;
				//alert(val_FechaDecisionAntigua);
				msgError+=val_FechaDecisionAntigua+'\n';
				oForm.elements['LIC_FECHADECISION'].focus();
			}
			
		}
	
		
		//solodebug	debug('ValidarFormulario.datosGenerales. msgError:'+msgError);

		//	19set19 Fecha entrega del pedido
		if((!esNulo(oForm.elements['LIC_FECHAENTREGAPEDIDO'].value) && (CheckDate(oForm.elements['LIC_FECHAENTREGAPEDIDO'].value))))
		{
			errores++;
			msgError+=val_malFechaPedidoLic+'\n';
			oForm.elements['LIC_FECHAENTREGAPEDIDO'].focus();
		}
		else if(!esNulo(oForm.elements['LIC_FECHAENTREGAPEDIDO'].value))
		{
		 	var fechaPed=parseInt(Piece(oForm.elements['LIC_FECHAENTREGAPEDIDO'].value,'/',2))*10000+parseInt(Piece(oForm.elements['LIC_FECHAENTREGAPEDIDO'].value,'/',1))*100+parseInt(Piece(oForm.elements['LIC_FECHAENTREGAPEDIDO'].value,'/',0));
			if (fechaPed<100000000) fechaPed=20000000+fechaPed;
								
			if(!errores && (oForm.elements['LIC_MESES'].value==0) && ((fechaPed<hoyOrd+1)||(fechaPed<fechaDec+1)))
			{
				errores++;
				msgError+=val_FechaPedidoAntigua+'\n';
				oForm.elements['LIC_FECHAENTREGAPEDIDO'].focus();
			}
			
		}

		if((esNulo(oForm.elements['LIC_DESCRIPCION'].value))){
			errores++;
			msgError+=val_faltaDescripcion+'\n';
			oForm.elements['LIC_DESCRIPCION'].focus();
		}
		

		if(jQuery("#LIC_FECHAADJUDICACION").length){
			if(!esNulo(oForm.elements['LIC_FECHAADJUDICACION'].value)){
				if(CheckDate(oForm.elements['LIC_FECHAADJUDICACION'].value)){
					errores++;
					msgError+=val_malFechaAdjudic+'\n';
					oForm.elements['LIC_FECHAADJUDICACION'].focus();
				}else{
					if((oForm.elements['LIC_MESES'].value!=0)&&(comparaFechas(oForm.elements['LIC_FECHADECISION'].value, oForm.elements['LIC_FECHAADJUDICACION'].value) == '>')){
						errores++;
						msgError+=val_malFechaAdjudic2.replace('[[FECHA_ADJUDICACION]]', oForm.elements['LIC_FECHAADJUDICACION'].value).replace('[[FECHA_DECISION]]', oForm.elements['LIC_FECHADECISION'].value)+'\n';
						oForm.elements['LIC_FECHAADJUDICACION'].focus();
					}
				}
			}
		}
		
		if ((jQuery('#CHK_LIC_AGREGADA').length) && (oForm.elements['CHK_LIC_AGREGADA'].checked)){	//12set16	Primero comprobamos que existe el checkbox
			oForm.elements['LIC_AGREGADA'].value='S';
		}
		else{
			if (jQuery('#CHK_LIC_AGREGADA').length){			//	Si existe el checkbox, asignamos su valor, sino manetnemos el que hubiera
				oForm.elements['LIC_AGREGADA'].value='N';
			}
		}
		
		if ((jQuery('#CHK_LIC_CONTINUA').length) && (oForm.elements['CHK_LIC_CONTINUA'].checked)){
			oForm.elements['LIC_CONTINUA'].value='S';
		}
		else{
			if (jQuery('#CHK_LIC_CONTINUA').length){
				oForm.elements['LIC_CONTINUA'].value='N';
			}
		}
		
		//	24may18 Licitación urgente
		if ((jQuery('#CHK_LIC_URGENTE').length) && (oForm.elements['CHK_LIC_URGENTE'].checked)){
			oForm.elements['LIC_URGENTE'].value='S';
		}
		else{
			if (jQuery('#CHK_LIC_URGENTE').length){	
				oForm.elements['LIC_URGENTE'].value='N';
			}
		}
		
		//	24may18 Solicitar datos proveedores
		if ((jQuery('#CHK_LIC_SOLICDATOSPROV').length) && (oForm.elements['CHK_LIC_SOLICDATOSPROV'].checked))
		{
			oForm.elements['LIC_SOLICDATOSPROV'].value='S';
		}
		else{
			if (jQuery('#CHK_LIC_SOLICDATOSPROV').length){
				oForm.elements['LIC_SOLICDATOSPROV'].value='N';
			}
		}
		
		//	4jul18 Multiopcion
		if ((jQuery('#CHK_LIC_MULTIOPCION').length) && (oForm.elements['CHK_LIC_MULTIOPCION'].checked))
		{
			oForm.elements['LIC_MULTIOPCION'].value='S';
		}
		else{
			if (jQuery('#CHK_LIC_MULTIOPCION').length){	
				oForm.elements['LIC_MULTIOPCION'].value='N';
			}
		}

		//	17jun20
		if ((jQuery('#CHK_LIC_FRETECIFOBLIGATORIO').length) && (oForm.elements['CHK_LIC_FRETECIFOBLIGATORIO'].checked))
		{
			oForm.elements['LIC_FRETECIFOBLIGATORIO'].value='S';
		}
		else{
			if (jQuery('#CHK_LIC_FRETECIFOBLIGATORIO').length){	
				oForm.elements['LIC_FRETECIFOBLIGATORIO'].value='N';
			}
		}

		//	17jun20
		if ((jQuery('#CHK_LIC_PAGOAPLAZODOOBLIGATORIO').length) && (oForm.elements['CHK_LIC_PAGOAPLAZODOOBLIGATORIO'].checked))
		{
			oForm.elements['LIC_PAGOAPLAZODOOBLIGATORIO'].value='S';
		}
		else{
			if (jQuery('#CHK_LIC_PAGOAPLAZODOOBLIGATORIO').length){	
				oForm.elements['LIC_PAGOAPLAZODOOBLIGATORIO'].value='N';
			}
		}

		//	17jun20
		if ((jQuery('#CHK_LIC_PRECIOOBJETIVOESTRICTO').length) && (oForm.elements['CHK_LIC_PRECIOOBJETIVOESTRICTO'].checked))
		{
			oForm.elements['LIC_PRECIOOBJETIVOESTRICTO'].value='S';
		}
		else{
			if (jQuery('#CHK_LIC_PRECIOOBJETIVOESTRICTO').length){	
				oForm.elements['LIC_PRECIOOBJETIVOESTRICTO'].value='N';
			}
		}
		
		//solodebug debug('ValidarFormulario.datosGenerales. errores:'+errores+' msgError:'+msgError);
		/* si los datos son correctos enviamos el form  */
		if(!errores){
			//	Nos aseguramos que no haya cambiado el action debido a la subida de documentos
			oForm.action="http://www.newco.dev.br/Gestion/Comercial/LicitacionV2_2022.xsql";
			SubmitForm(oForm);
		}
		else
		{
			alert(msgError);
		}
	}
}


//	Funcion que convierte las etiquetas <br> en saltos de linea
function formateaTextareas(){
	jQuery("textarea").each(function(){
		jQuery(this).val(this.value.replace(/<br>/gi, '\n'));
	});
}


/*
	Gestion de documento
*/
function addDocFile(uploadForm, ID)
{
	//solodebug	debug('addDocFile. form:'+uploadForm.name+' ID:inputFileDoc_'+ID+' uploadFilesDoc.length:'+uploadFilesDoc.length);

	var uploadElem = jQuery("#inputFileDoc_" + ID);

	//solodebug	debug('addDocFile. form:'+uploadForm.name+' ID:inputFileDoc_'+ID+' uploadFilesDoc.length:'+uploadFilesDoc.length+' uploadElem.value:'+uploadElem.value);
	if(uploadElem.value != '')
	{
		uploadFilesDoc[uploadFilesDoc.length] = uploadElem.value;
		//solodebug	debug('addDocFile.1. Doc:'+uploadElem.value+ ' length:'+uploadFilesDoc.length);
	}
	else
	{
		uploadFilesDoc.splice(ID, 1);
		//solodebug	debug('addDocFile.2. Doc:'+uploadFilesDoc.value+ ' length:'+uploadFilesDoc.length);
	}

	return true;
}

//cargar documentos
function cargaDoc(uploadForm, tipo, valueID){
	// valueID puede ser:
	//	si tipo in (FT) => valueID = LicProdID
	//	si tipo in (OA, OMVM, OMVMB, OFNCP, etc...) => valueID = LicID
	//	5mar19 DOC_IDLICITACION, LIC_ID
	
	//solodebug	debug('cargaDoc. form:'+uploadForm.name+ ' tipo:'+tipo+ ' ID:'+valueID);

	if(uploadFrameDoc && uploadFrameDoc.document && uploadFrameDoc.document.getElementsByTagName("body")[0]){
		uploadFrameDoc.document.getElementsByTagName("body")[0].innerHTML = "";
	}

	var msg = '';

	if(msg != ''){
		alert(msg);
	}else{
		if(hasFilesDoc(uploadForm)){
			//solodebug	debug('cargaDoc. form:'+uploadForm.name+ ' tipo:'+tipo+ ' ID:'+valueID+ ' hasfiles ok!');
			
			//	6mar19 Guardamos los valores originales del formulario
			var targetOrig=uploadForm.target;
			var enctypeOrig=uploadForm.enctype;
			var actionOrig=uploadForm.action;

			//	Cambiamos el nombre del objeto file (el nombre era diferente para evitar confundir con docs de producto)
			jQuery("#inputFileDoc_"+valueID).attr('name', 'inputFileDoc');


			uploadForm.target = 'uploadFrameDoc';
			uploadForm.action = 'http://www.newco.dev.br/cgi-bin/uploadDocsMVM.pl';
			uploadForm.enctype = 'multipart/form-data';
			waitDoc(tipo, valueID);
			periodicTimerDoc = 0;
			periodicUpdateDoc(uploadForm, valueID, tipo);
			uploadForm.submit();

			//	12feb20 Recuperamos los valores originales del formulario
			uploadForm.target=targetOrig;
			uploadForm.enctype=enctypeOrig;
			uploadForm.action=actionOrig;

			//	Cambiamos el nombre del objeto file
			jQuery("#inputFileDoc_"+valueID).attr('name', 'inputFileDoc_Proveedor');
		}
		else
			debug('cargaDoc. form:'+uploadForm.name+ ' tipo:'+tipo+ ' ID:'+valueID+ ' hasfiles NO!');
	}//fin else
}
//fin de carga documentos js

//Search form if there is a filled file input
function hasFilesDoc(form)
{
	//solodebug debug('hasFilesDoc. form:'+form.name+' FormElements:'+logFormElements(form));
	for(var i=0; i<form.length; i++) {
	
		//if(form.elements[i].type == 'file' && (form.elements[i].name.substring(0,12) == 'inputFileDoc'))
		//solodebug	debug('hasFilesDoc. form:'+form.name+ ' element['+i+']:'+form.elements[i].name + ' value:'+form.elements[i].value);
		
		if(form.elements[i].type == 'file' && (form.elements[i].name.substring(0,12) == 'inputFileDoc') && form.elements[i].value != '' ){
			return true;
		}
	}
	return false;
}

//function que dice al usuario de esperar
function waitDoc(tipo, valueID){
	jQuery('#waitBoxDoc_'+tipo+'_'+valueID).html ('<img src="http://www.newco.dev.br/images/loading.gif" />');
	jQuery('#waitBoxDoc_'+tipo+'_'+valueID).show();
	return false;
}

/**
 * Check periodically if the image upload is finished
 * @return Boolean - true if filled file input found
 */
 
function logFormElements(formName){
  var Text='';
  
  for (i=0; i<formName.elements.length; i++){
    Text+=formName.elements[i].name+'\n\r';
  }
  return(Text);
}
 
function periodicUpdateDoc(uploadForm, valueID, tipo){
	// valueID puede ser:
	//	si tipo in (FT) => valueID = LicProdID
	//	si tipo in (OA, OMVM, OMVMB, OFNCP, etc...) => valueID = LicID


	//solodebug	debug('periodicUpdateDoc. tipo:'+tipo+ ' ID:'+valueID+' uploadForm:'+uploadForm.name);

	if(periodicTimerDoc >= MAX_WAIT_DOC){
		return false;
	}
	periodicTimerDoc++;

	//solodebug	debug('periodicUpdateDoc. tipo:'+tipo+ ' ID:'+valueID+' form:'+uploadForm.name+'::'+logFormElements(uploadForm));

	if(uploadFrameDoc && uploadFrameDoc.document && uploadFrameDoc.document.getElementsByTagName("p")[0]) 
	{
		
		tipoDoc = tipo;

		if(tipoDoc == 'LIC_PRODUCTO_FT' || tipoDoc == 'LIC_OFERTA_FT'){
			document.getElementById('waitBoxDoc_CA').style.display = 'none';
		}
		else if(tipoDoc == 'FT' || tipoDoc == 'RS' || tipoDoc == 'CE'){	//	15nov21
			//solodebug	debug('periodicUpdateDoc. tipo:'+tipo+ ' valueID:'+valueID+' form:'+uploadForm.name+'::'+logFormElements(uploadForm));
			document.getElementById('waitBoxDoc_'+tipo+'_'+valueID).style.display = 'none';
		}
		else{
			//solodebug	debug('periodicUpdateDoc. tipo:'+tipo+ ' valueID:'+valueID+' form:'+uploadForm.name+'::'+logFormElements(uploadForm));
			document.getElementById('waitBoxDoc_'+valueID).style.display = 'none';
		}

		var uFrame = uploadFrameDoc.document.getElementsByTagName("p")[0];

		if(uFrame.innerHTML.substr(0, 1) != '{' && uFrame.innerHTML.substr(0, 1) != '['){
			return false;
		}else{
			var response = eval('(' + uFrame.innerHTML + ')');
			handleFileRequestDoc(uploadForm,response,valueID, tipo);
			return true;
		}
	}else{
		setTimeout(function(){periodicUpdateDoc(uploadForm,valueID, tipo)}, 1000);
		return false;
	}
	return true;
}
 

/**
 * handle Request after file (or image) upload
 * @param {Array} resp Hopefully JSON string array
 * @return Boolean
 */
function handleFileRequestDoc(form, resp, valueID, tipo){
	// valueID puede ser:
	//	si tipo in (FT) => valueID = LicProdID
	//	si tipo in (OA, OMVM, OMVMB, OFNCP, etc...) => valueID = LicID

	//solodebug	debug('handleFileRequestDoc. resp:'+resp+' tipo:'+tipo+ ' ID:'+valueID);

	var lang = new String('');
	if(document.getElementById('myLanguage') && document.getElementById('myLanguage').innerHTML.length > 0){
		lang = document.getElementById('myLanguage').innerHTML;
	}

	var msg = '';
	var target = '_top';
	var enctype = 'application/x-www-form-urlencoded';
	var documentChain = new String('');
	var action = 'http://www.newco.dev.br/Administracion/Mantenimiento/Productos/confirmCargaDocumento.xsql';
	var docNombre = '';
	var docDescri = '';
	var nombre = '';
	var cadenaDoc = '';

	if(resp.documentos){
		if(resp.documentos && resp.documentos.length > 0){
			for(var i=0; i<resp.documentos.length; i++){
				if(resp.documentos[i].error && resp.documentos[i].error != ''){
					msg += resp.documentos[i].error;
				}else{
					if(resp.documentos[i].size){

						/*en lugar del elemento nombre del form cojo el nombre del fichero directamente, si hay espacios el sistema pone guion bajo, entonces cuento cuantos guiones son, divido al penultimo y añado la ultima palabra, si la ultima palabra esta vacía implica que hay 2 ghiones bajos, entonces divido a los 2 ghiones bajos y cojo la primera parte.*/
						var sinEspacioNombre = '';
						var lastWord = '';
						var numSep = PieceCount(sinEspacioNombre,'_');
						var numSepOk = numSep -1;

						sinEspacioNombre = resp.documentos[i].nombre.replace('__','_');

						if(Piece(sinEspacioNombre,'_',numSepOk) == ''){
							if(sinEspacioNombre.search('__')){
								lastWord	= sinEspacioNombre.split('__');
								docNombre	= lastWord[0];
							}
						}else{
							lastWord	= Piece(sinEspacioNombre,'_',numSepOk);
							nombre		= sinEspacioNombre.split(lastWord);
							docNombre	= nombre[0].concat(lastWord);
						}

						documentChain += resp.documentos[i].nombre + '|'+ docNombre+'|'+ resp.documentos[i].size +'|'+ docDescri + '#';
					}
				}
			}

			if(msg == ''){
				document.getElementsByName('CADENA_DOCUMENTOS')[0].value = documentChain;
				cadenaDoc= document.getElementsByName('CADENA_DOCUMENTOS')[0].value;
			}
		}
	}

	var borrados='', borr_ante = 'N', prove = '';

	tipoDoc = tipo;

	if(msg != ''){
		alert(msg);
		return false;
	}else{
		form.encoding = enctype;
		form.action = action;
		form.target = target;

		jQuery.ajax({
			url:"http://www.newco.dev.br/Administracion/Mantenimiento/Productos/confirmCargaDocumento.xsql",
			data: "ID_PROVEEDOR="+prove+"&DOCUMENTOS_BORRADOS="+borrados+"&BORRAR_ANTERIORES="+borr_ante+"&TIPO_DOC="+tipoDoc+"&PARAMETROS="+valueID+"&CADENA_DOCUMENTOS="+cadenaDoc,
			type: "GET",
			async: false,
			contentType: "application/xhtml+xml",
			beforeSend:function(){
				document.getElementById('confirmBox_'+valueID).style.display = 'none';
				document.getElementById('waitBoxDoc_'+valueID).src = 'http://www.newco.dev.br/images/loading.gif';
			},
			error:function(objeto, quepaso, otroobj){
				alert("objeto:"+objeto);
				alert("otroobj:"+otroobj);
				alert("quepaso:"+quepaso);
			},
			success:function(data){
				var doc=JSON.parse(data);

				var currentDocID	= doc[0].id_doc;
				var nombreDoc		= doc[0].nombre;
				var fileDoc			= doc[0].file;

				if(tipoDoc == 'DOC_LICITACION')
					{
						//solodebug	
						debug("handleFileRequestDoc DOC_LICITACION. Actualizado OK. nombreDoc:"+nombreDoc);
					
						document.getElementById('confirmBox_'+valueID).style.display = 'block';
						form.elements['LIC_IDDOCUMENTO'].value=currentDocID;
						jQuery("#inputFileDoc_"+valueID).hide();
						jQuery("#divDatosDocumento").show();
						jQuery("#docLicitacion").text(nombreDoc);
					}

				uploadFrameDoc.document.getElementsByTagName("p")[0].innerHTML = '';
				uploadFrameDoc.document.getElementsByTagName("body")[0].innerHTML = "";

				//resettamos los input file, mismo que removeDoc
				var clearedInput;
				var uploadElem = document.getElementById("inputFileDoc_" + valueID);

				uploadElem.value = '';
			}
		});
	}
		
	return true;
}
