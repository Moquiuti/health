//	JS de MOF_25_RW
//	Ultima revisión ET 2oct18 11:32

var AvisarCantidadesIntactas=1;

var CadenaValoresInicio='';
var CadenaValoresSubmit='';

//2oct18 Para subir documento
var uploadFilesDoc = new Array();
var periodicTimerDoc = 0;
var form_tmp;
var MAX_WAIT_DOC = 1000;


function RegistrarValores(cuando, form){

  var CadenaValores='';

  for(var n=0;n<form.length;n++){
	if(form.elements[n].name=='ENTREGA_REAL'){
	  CadenaValores+=form.elements[n].value+'|';
	}
	else{
	  if(form.elements[n].name.substring(0,18)=='CantidadEntregada_'){
	    CadenaValores+=form.elements[n].value+'|';
	  }
	  else{
	    if(form.elements[n].name=='NMU_COMENTARIOS'){
	      CadenaValores+=form.elements[n].value+'|';
	    }
	  }
	}
  }

  if(cuando=='INICIO'){
	CadenaValoresInicio=CadenaValores;
  }
  else{
	CadenaValoresSubmit=CadenaValores;
  }
}


function CancelarPedido(form,accion){

  AsignarAccion(form,accion);
  SubmitForm(form,document);
}


function Actua(formu,accion){
	var msgError='';

	comentariosToForm1(document.forms['form1'], document.forms['form1'],'NMU_COMENTARIOS');
	AsignarAccion(formu,accion);

	//quito los botones asi no doble click
    document.getElementById('ocultarBotones').style.display = 'none';

	//	22mar09	Guardamos los parametros, aunque solo se utiliza el de ALBARAN_SALIDA
	document.forms['form1'].elements['OTROSPARAMETROS'].value='|||'+document.forms['form1'].elements['ALBARAN_SALIDA'].value;

	if(accion.match('RECEPCION_OK') || accion.match('RECEPCION_PARCIAL') || accion.match('ABONO') || accion.match('BACKORDER') || accion.match('LEGALIZAR')){
		// miramos que productos estan marcados como recibidos
		comprobarRecibidos(formu);

		var fechaEntregatmp=obtenerSubCadena(formu.elements['FECHANO_ENTREGA'].value,2)+'/'+obtenerSubCadena(formu.elements['FECHANO_ENTREGA'].value,1)+'/'+obtenerSubCadena(formu.elements['FECHANO_ENTREGA'].value,3);
		fechaEntregatmp=new Date(fechaEntregatmp);

		var fechaEntregaRealtmp=obtenerSubCadena(formu.elements['FECHA_ENTREGA_REAL'].value,2)+'/'+obtenerSubCadena(formu.elements['FECHA_ENTREGA_REAL'].value,1)+'/'+obtenerSubCadena(formu.elements['FECHA_ENTREGA_REAL'].value,3);
		fechaEntregaRealtmp=new Date(fechaEntregaRealtmp);

		if((document.forms['form1'].elements['ALBARAN_OBLIGATORIO'].value=='S') &&(document.forms['form1'].elements['ALBARAN_SALIDA'].value=='')){
			msgError=msgError+document.forms['MensajeJS'].elements['NECESARIO_ALBARAN'].value+'\n\r';
		}

		if(accion.match('ABONO') || accion.match('BACKORDER')){
			if(formu.elements['RECIBIDO'].value=='TODOSRECIBIDOS'){
				msgError=msgError+ document.forms['MensajeJS'].elements['SIN_CANTIDADES_PARA_ABONO'].value +'\n'+ document.forms['MensajeJS'].elements['SIN_CANTIDADES_PARA_ABONO1'].value+'\n\r';
			}else{
				if((AvisarCantidadesIntactas)){
					if(confirm(document.forms['MensajeJS'].elements['CANTIDADES_NO_MODIFICADAS'].value +'\n\n '+document.forms['MensajeJS'].elements['ACEPTAR_GUARDAR_DATOS'].value +'\n'+ document.forms['MensajeJS'].elements['CANCELAR_MODIFICAR_CANTIDADES'].value )){
						//	estÃ¡ ok!
					}else{
						msgError=msgError+document.forms['MensajeJS'].elements['CORRIJA_CANTIDAD'].value+'\n\r';
						seleccionarElPrimerCuadroDeTextoDeCantidades(formu,'CantidadEntregada_');
						document.getElementById('ocultarBotones').style.display = 'block';
					}
				}else{
					//SubmitForm(formu, document);
				}
			}

			if(msgError==''){
				SubmitForm(formu, document);
				return;
			}else
				alert(msgError);
		}else{
			if((AvisarCantidadesIntactas)){
				if(confirm(document.forms['MensajeJS'].elements['CANTIDADES_NO_MODIFICADAS'].value +'\n\n '+document.forms['MensajeJS'].elements['ACEPTAR_GUARDAR_DATOS'].value +'\n'+ document.forms['MensajeJS'].elements['CANCELAR_MODIFICAR_CANTIDADES'].value )){
					RegistrarValores('SUBMIT', document.forms['form1']);

					// SubmitForm(formu, document);
				}else{
					msgError=msgError+document.forms['MensajeJS'].elements['CORRIJA_CANTIDAD'].value+'\n\r';
					seleccionarElPrimerCuadroDeTextoDeCantidades(formu,'CantidadEntregada_');
				}
			}else{
				RegistrarValores('SUBMIT', document.forms['form1']);
				//SubmitForm(formu, document);
			}
		}

		if(msgError==''){
			SubmitForm(formu, document);
			return;
		}else
			alert(msgError);
	}else{
		if(accion.match('INCIDENCIA')){
			AsignarAccion(formu,accion+prepararDatosActuales(formu));
			SubmitForm(formu,document);
		}else{
			SubmitForm(formu,document);
		}
	}
}

function prepararDatosActuales(form){
  var CadenaDatos='&DATOSACTUALES=';
  for(var n=0;n<form.length;n++){
    if(form.elements[n].name=='COMBO_ENTREGA_REAL' || form.elements[n].name=='FECHA_ENTREGA_REAL' || form.elements[n].name=='NMU_COMENTARIOS' || form.elements[n].name.substring(0,18)=='CantidadEntregada_'){
      if(form.elements[n].name=='NMU_COMENTARIOS'){
        var arrAscii=new Array();
        for(var i=0;i<form.elements[n].value.length;i++){
          arrAscii[arrAscii.length]=form.elements[n].value.charCodeAt(i);
        }
        var cadenaTemp='';
        for(var i=0;i<arrAscii.length;i++){
          if(arrAscii[i]==13 && arrAscii[i+1]==10){
            cadenaTemp+='<br/>';
            i++;
          }
          else{
            cadenaTemp+=String.fromCharCode(arrAscii[i]);
          }
        }
        CadenaDatos+=form.elements[n].name+'|'+cadenaTemp+'#';
      }
      else{
        CadenaDatos+=form.elements[n].name+'|'+form.elements[n].value+'#';
      }
    }
  }
  for(var n=0;n<document.forms['form1'].length;n++){
    if(document.forms['form1'].elements[n].name.substring(0,12)=='CHKRECIBIDO_'){
      CadenaDatos+=document.forms['form1'].elements[n].name+'|'+document.forms['form1'].elements[n].value+'#';
    }
  }   
  return CadenaDatos;
}
        
function seleccionarElPrimerCuadroDeTextoDeCantidades(form, nombreObj){
  for(var n=0;n<form.length;n++){
    if(form.elements[n].name.substring(0,18)==nombreObj){
      form.elements[n].focus();
      return true;
    }
  }
}
        
        
        
function cargarDatosActuales(form, CadenaDatos){

  var arrParNombreValor=CadenaDatos.split('#');
  arrParNombreValor.length=arrParNombreValor.length-1;
  for(var n=0;n<arrParNombreValor.length;n++){
    var arrElemento=arrParNombreValor[n].split('|');
    if(arrElemento[0]=='NMU_COMENTARIOS'){
      var cadenaTmp='';
      for(var i=0;i<arrElemento[1].length;i++){
        if(arrElemento[1].charCodeAt(i)==60 && arrElemento[1].charCodeAt(i+1)==98 && arrElemento[1].charCodeAt(i+2)==114 && arrElemento[1].charCodeAt(i+3)==47 && arrElemento[1].charCodeAt(i+4)==62){
          cadenaTmp+='\n';
          i=i+4;
        }
        else{
          cadenaTmp+=String.fromCharCode(arrElemento[1].charCodeAt(i));
        }
      }
      form.elements[arrElemento[0]].value=cadenaTmp;
      document.forms['form1'].elements[arrElemento[0]].value=cadenaTmp;
    }
    else{
      if(arrElemento[0]=='COMBO_ENTREGA_REAL'){
        for(var i=0;i<form.elements[arrElemento[0]].options.length;i++){
          if(form.elements[arrElemento[0]].options[i].value==arrElemento[1]){
            form.elements[arrElemento[0]].options.selectedIndex=i;
          }
        }
      }
      else{
        if(arrElemento[0].substring(0,12)=='CHKRECIBIDO_'){
          var elId=obtenerId(arrElemento[0]);
          form.elements[arrElemento[0]].value=arrElemento[1];
          if(arrElemento[1]=='checked'){
            document.images['IMGRECIBIDO_'+elId].src='http://www.newco.dev.br/images/recibido.gif';
          }
          else{
            document.images['IMGRECIBIDO_'+elId].src='http://www.newco.dev.br/images/norecibido.gif';
          }
        }
        else{ 
          form.elements[arrElemento[0]].value=arrElemento[1];
        }
      }
    }
  }
}

function comprobarRecibidos(form){

  var cambios='';
  var estadoRecepcion;
  var cuantosProductosTotal=0;
  var cuantosProductosRecibidos=0;
  var cantidadEntregada=0;


	 //for(var n=0;n<form.length;n++){
	 for(var n=0;n<form.length;n++){
    	if(form.elements[n].name.substring(0,12)=='CHKRECIBIDO_'){
    	cuantosProductosTotal++;
    	var idProducto;
    	var recibido;


    	idProducto=obtenerId(form.elements[n].name);
    	 //idProducto=obtenerId(document.images[n].name);

    	if(form.elements['CHKRECIBIDO_'+idProducto].value=='checked'){

    	//if(document.images['CHKRECIBIDO_'+idProducto].value=='checked'){
    	  recibido='S';
    	  cuantosProductosRecibidos++;
    	}
    	else{
    	  recibido='N';
    	}

    	cantidadEntregada=form.elements['CantidadEntregada_'+idProducto].value;



    	cambios=cambios+idProducto+'|'+recibido+'|'+cantidadEntregada+'#';

	  }
	}

	if(cuantosProductosRecibidos==cuantosProductosTotal){
	  estadoRecepcion='TODOSRECIBIDOS';
	}
	else{
	  if(cuantosProductosRecibidos==0){
    	estadoRecepcion='NINGUNORECIBIDO'; 
	  }
	  else{
    	estadoRecepcion='ALGUNORECIBIDO'; 
	  }
	}


	form.elements['STRING_CANTIDADES'].value=cambios;
	form.elements['RECIBIDO'].value=estadoRecepcion;

	return true;
}
	
        
//Copiar la zona de texto NMU_COMENTARIOS del form comentarios en el campo hidden NMU_COMENTARIOS del form1
function comentariosToForm1(formOrigen, formDestino,elemento) {

   /*
   for(var n=0;n<document.forms.length;n++){
     //alert('form: '+document.forms[n].name+' '+'longitud: '+' '+document.forms[n].length);
     for(var i=0;i<document.forms[n].length;i++){
       //alert(document.forms[n].elements[i].name+' '+document.forms[n].elements[i].value);
     }
   }

   //alert('nombre: '+elemento);
   //alert('origen: '+formOrigen.name+' '+formOrigen.elements[elemento].value);
   //alert('destino: '+formDestino.name+' '+formDestino.elements[elemento].value);
  */
   formDestino.elements[elemento].value=formOrigen.elements[elemento].value;
}  

function inicializarImportes(form){ 
    form.elements['MO_SUBTOTAL'].value=anyadirCerosDecimales(formateaDivisa(Round(desformateaDivisa(form.elements['MO_SUBTOTAL'].value),2)),2);
    form.elements['MO_IMPORTEIVA'].value=anyadirCerosDecimales(formateaDivisa(Round(desformateaDivisa(form.elements['MO_IMPORTEIVA'].value),2)),2);
    form.elements['IMPORTE_FINAL_PEDIDO'].value=anyadirCerosDecimales(formateaDivisa(Round(desformateaDivisa(form.elements['IMPORTE_FINAL_PEDIDO'].value),2)),2);

	comprobarRecibidoCompleto();
	/*
    //si alguna cantidad no esta recibida entonces enseño boton recibido parcialmente
    for(var i=0;i<form.length;i++){
        if (form.elements[i].name.substring(0,12) == 'CHKRECIBIDO_' ){
           // alert(form.elements[i].value);
            if (form.elements[i].value == 'unchecked'){
                jQuery("#botonRecibidoParc").show();
                //jQuery("#textRecibidoParc").hide();

                jQuery("#botonRecibido").hide();
                //jQuery("#textRecibido").show();

                jQuery("#botonAbono").show();
                jQuery("#botonBackorder").show();
            }
         }
    }
	*/
}

function UnidadesALotesRecibidas(unidades,unidadesporlote,cantidadTotal,objeto){
	  
	var identificador=objeto.name.substr(18,objeto.name.length);

	//solodebug	console.log('UnidadesALotesRecibidas. unidades:'+unidades+ ' unidadesporlote:'+unidadesporlote+' cantidadTotal:' +cantidadTotal)


    if(objeto.value == "" || objeto.value == 0)
	{
        if(document.forms['form1'].elements['CHKRECIBIDO_'+identificador].checked==true)
		{
		  objeto.value=0;
		  document.forms['form1'].elements['CHKRECIBIDO_'+identificador].checked=false;
		  return true;
		}
		else{
		  objeto.value=0;
		  document.forms['form1'].elements['CHKRECIBIDO_'+identificador].checked=false;
		  return true;
		}
      }	                   
      else{
		if((objeto.value < 0) || (!esEntero(objeto.value)))
		{  //tienePuntuacion(objeto.value)
		  alert(document.forms['MensajeJS'].elements['CANTIDAD_CORRECTA'].value);
		  objeto.focus();
		  return false;
		}
		else
		{	
		  if ((incluyePacks=='N')&&(parseInt(unidades) > parseInt(cantidadTotal)))
		  {
	    	alert(document.forms['MensajeJS'].elements['RECIBIDA_SUPERIOR_SOLICITADA'].value + '\n'+ document.forms['MensajeJS'].elements['SOSTITUIRA_POR_SOLICITADA'].value + cantidadTotal + document.forms['MensajeJS'].elements['UNIDADES'].value);
	    	objeto.value=cantidadTotal;
	    	objeto.select();
	    	return true;
		  } 
		  else{
	    	if(document.forms['form1'].elements['CHKRECIBIDO_'+identificador].checked==true && parseInt(unidades) < parseInt(cantidadTotal)){
	    	  //if(confirm(document.forms['MensajeJS'].elements['RECIBIDA_INFERIOR_SOLICITADA'].value + '\n'+ document.forms['MensajeJS'].elements['ACEPTAR_CANTIDAD_PARCIAL'].value +'\n'+document.forms['MensajeJS'].elements['CANCELAR_MARCAR_RECIBIDO'].value)){
	        	var lotes;	        
	        	if(unidades%unidadesporlote==0)
				{
	        	  lotes=unidades/unidadesporlote;
	        	  //	4set18 var nuevasUnidades=unidadesporlote*lotes;	    
	        	  //	4set18 document.forms['form1'].elements['CantidadEntregada_'+identificador].value=nuevasUnidades;	          
                }
                else
				{
	        	  lotes=(Math.abs(unidades)-(Math.abs(unidades)%unidadesporlote))/unidadesporlote+1;

	        	  alert(unidades+document.forms['MensajeJS'].elements['UNIDADES_NO_ENTERO_CAJAS'].value+'\n' + document.forms['MensajeJS'].elements['REDONDEADO_COINCIDA'].value +Math.abs(lotes)+document.forms['MensajeJS'].elements['CAJAS'].value+'('+Math.abs(unidadesporlote*lotes)+document.forms['MensajeJS'].elements['UNIDADES'].value + ')');	

	        	  //	4set18 var nuevasUnidades=unidadesporlote*lotes;	
	        	  //	4set18 document.forms['form1'].elements['CantidadEntregada_'+identificador].value=nuevasUnidades;	 
                }
	    	  //}
	    	  //else{
	        	//document.forms['form1'].elements['CantidadEntregada_'+identificador].value=cantidadTotal;
	    	  //}

				//	4set18 evitamos duplicar codigo
	        	var nuevasUnidades=unidadesporlote*lotes;	    
	        	document.forms['form1'].elements['CantidadEntregada_'+identificador].value=nuevasUnidades;	          
			  
			  	//solodebug	console.log('UnidadesALotesRecibidas. checked=true. unidades:'+unidades+ ' nuevasUnidades:'+nuevasUnidades+' < cantidadTotal:' +cantidadTotal)
			  
            	if(document.forms['form1'].elements['CantidadEntregada_'+identificador].value>=cantidadTotal)
				{
                	document.forms['form1'].elements['CHKRECIBIDO_'+identificador].checked=true;
                	return true;
            	}
            	else
				{
	        		document.forms['form1'].elements['CHKRECIBIDO_'+identificador].checked=false;
	        		return true;
	    	  	}
	    	}
	    	else
			{	  	
	    	  var lotes;	        
	    	  if(unidades%unidadesporlote==0)
			  {
	        	lotes=unidades/unidadesporlote;

	        	//	4set18 var nuevasUnidades=unidadesporlote*lotes;	    
	        	//	4set18 document.forms['form1'].elements['CantidadEntregada_'+identificador].value=nuevasUnidades;	          
              }
              else
			  {
	        	lotes=(Math.abs(unidades)-(Math.abs(unidades)%unidadesporlote))/unidadesporlote+1;

	        	alert(unidades+document.forms['MensajeJS'].elements['UNIDADES_NO_ENTERO_CAJAS'].value +' \n' + document.forms['MensajeJS'].elements['REDONDEADO_COINCIDA'].value + Math.abs(lotes)+document.forms['MensajeJS'].elements['CAJAS'].value +' ('+Math.abs(unidadesporlote*lotes)+document.forms['MensajeJS'].elements['UNIDADES'].value + ')');	 

	        	//	4set18 var nuevasUnidades=unidadesporlote*lotes;	
	        	//	4set18 document.forms['form1'].elements['CantidadEntregada_'+identificador].value=nuevasUnidades;	 
              }
			  
				//	4set18 evitamos duplicar codigo
	        	var nuevasUnidades=unidadesporlote*lotes;	    
	        	document.forms['form1'].elements['CantidadEntregada_'+identificador].value=nuevasUnidades;	          
			  
			  //solodebug	console.log('UnidadesALotesRecibidas. NOT checked=true. unidades:'+unidades+ ' nuevasUnidades:'+nuevasUnidades+' < cantidadTotal:' +cantidadTotal)
			  
              //4set18	if(document.forms['form1'].elements['CantidadEntregada_'+identificador].value>=cantidadTotal) Comparación de texto, puede dar problemas
              if(nuevasUnidades>=cantidadTotal)
			  {
				document.forms['form1'].elements['CHKRECIBIDO_'+identificador].checked=true;
				return true;
              }
              else
			  {
	        	document.forms['form1'].elements['CHKRECIBIDO_'+identificador].checked=false;
	        	return true;
	   		  }
          }
        }
	}
  }
}
	
function UnidadesALotesRecibidasImagen(unidades,unidadesporlote,cantidadTotal,objeto){

  var identificador=objeto.name.substr(18,objeto.name.length);

	//solodebug	console.log('UnidadesALotesRecibidasImagen. unidades:'+unidades+ ' unidadesporlote:'+unidadesporlote+' cantidadTotal:' +cantidadTotal)



      if(objeto.value == "" || objeto.value == 0)
	  {
		  objeto.value=0;
		  document.forms['form1'].elements['CHKRECIBIDO_'+identificador].value='unchecked';
		  document.images['IMGRECIBIDO_'+identificador].src='http://www.newco.dev.br/images/norecibido.gif';

		  botonesRecibidoParcial();

		  return true;
      }	                   
      else
	  {
		if((objeto.value < 0) || (!esEntero(objeto.value)))
		{  //tienePuntuacion(objeto.value)
		  alert(document.forms['MensajeJS'].elements['CANTIDAD_CORRECTA'].value);
		  objeto.focus();
		  return false;
		}
		else
		{	
		  if ((incluyePacks=='N')&&(parseInt(unidades) > parseInt(cantidadTotal)))
		  {
	    	alert(document.forms['MensajeJS'].elements['RECIBIDA_SUPERIOR_SOLICITADA'].value+'\n'+ document.forms['MensajeJS'].elements['SOSTITUIRA_POR_SOLICITADA'].value +cantidadTotal + document.forms['MensajeJS'].elements['UNIDADES'].value);
	    	objeto.value=cantidadTotal;
	    	objeto.select();
	    	return true;
		  } 
		  else{
	    	//if(parseInt(unidades) <= parseInt(cantidadTotal)){


				var lotes;	        
				if(unidades%unidadesporlote==0)
				{
					lotes=unidades/unidadesporlote;
				}
				else
				{
					lotes=(Math.abs(unidades)-(Math.abs(unidades)%unidadesporlote))/unidadesporlote+1;
				}
				   
	        	//4set18	document.forms['form1'].elements['CantidadEntregada_'+identificador].value=unidades;

	        	//alert(unidades+document.forms['MensajeJS'].elements['UNIDADES_NO_ENTERO_CAJAS'].value+'\n'+ document.forms['MensajeJS'].elements['REDONDEADO_COINCIDA'].value +Math.abs(lotes)+document.forms['MensajeJS'].elements['CAJAS'].value+'('+Math.abs(unidadesporlote*lotes)+ document.forms['MensajeJS'].elements['UNIDADES'].value+')');

	        	//4set18 las siguientes 2 lineas estaban comentadas, pero parecen correctas
				var nuevasUnidades=unidadesporlote*lotes;	
	        	document.forms['form1'].elements['CantidadEntregada_'+identificador].value=nuevasUnidades;	 

				//solodebug	console.log('UnidadesALotesRecibidasImagen. Revisando cantidad. unidades:'+unidades+ ' unidadesporlote:'+unidadesporlote+' nuevasUnidades:'+nuevasUnidades+' cantidadTotal:' +cantidadTotal)

				if(nuevasUnidades>=cantidadTotal)
				{
					document.forms['form1'].elements['CHKRECIBIDO_'+identificador].value='checked';
					document.images['IMGRECIBIDO_'+identificador].src='http://www.newco.dev.br/images/recibido.gif';

					comprobarRecibidoCompleto();

					return true;
				}
				else
				{
					document.forms['form1'].elements['CHKRECIBIDO_'+identificador].value='unchecked';
					document.images['IMGRECIBIDO_'+identificador].src='http://www.newco.dev.br/images/norecibido.gif';

					botonesRecibidoParcial();

					return true;
				}
	    //}
      	  }
		}
  	}
}
	
function validarCheckeado(objChk, form, cantidadTotal){
  var idLinea=obtenerId(objChk.name);
  if(objChk.checked==false){
	form.elements['CantidadEntregada_'+idLinea].value=0;
  }
  else{
	form.elements['CantidadEntregada_'+idLinea].value=cantidadTotal;
  }
}
	
	         
function calculaFecha(nom,mas){

      if(mas>=999){
        mas=-2;
      }

      var hoy=new Date();
      var Resultado=calcularDiasHabiles(hoy,mas);  

      var elDia=Resultado.getDate();
      var elMes=Number(Resultado.getMonth())+1;
      var elAnyo=Resultado.getFullYear();
      var laFecha=elDia+'/'+elMes+'/'+elAnyo;

        document.forms['form1'].elements['FECHA_'+nom].value = laFecha;   
}    

    
//	botón de "todas recibidas", alterna el estado de recibido para todas las lineas
//	8may18	No tenemos en cuenta la linea de Pack
function todasRecibidas(objStatusTodas)
{

	AvisarCantidadesIntactas=0;

	for(var n=0;n<document.forms['form1'].length;n++){
		if(document.forms['form1'].elements[n].name.substring(0,14)=='IDLINEAPEDIDO_')
		{
    		var idLinea=obtenerId(document.forms['form1'].elements[n].name);
			
			
			//console.log('todasRecibidas ('+idLinea+') IMGRECIBIDO:'+jQuery("#IMGRECIBIDO_"+idLinea).length>0);

			//8may18	Solo comprobamos las entradas que tengan imagen asociada, no los packs
			if (jQuery("#IMGRECIBIDO_"+idLinea).length>0)
			{

    			if(objStatusTodas.value==1){
        			document.forms['form1'].elements['CantidadEntregada_'+idLinea].value=0;
        			document.images['IMGRECIBIDO_'+idLinea].src='http://www.newco.dev.br/images/norecibido.gif';
        			document.forms['form1'].elements['CHKRECIBIDO_'+idLinea].value='unchecked';

    			}
    			else{
        			var CantidadTotalLinea=document.forms['form1'].elements['CANTIDADSINFORMATO_'+idLinea].value;
        			document.forms['form1'].elements['CantidadEntregada_'+idLinea].value=CantidadTotalLinea;
        			document.images['IMGRECIBIDO_'+idLinea].src='http://www.newco.dev.br/images/recibido.gif';
        			document.forms['form1'].elements['CHKRECIBIDO_'+idLinea].value='checked';

    		 	}
			}
		}
	}
	if(objStatusTodas.value==1){
		objStatusTodas.value=0;
	}
	else{
		objStatusTodas.value=1;
	}

	comprobarRecibidoCompleto();
}

    
function calculaFechaCalendarios(mas){
      var hoy=new Date();
      var Resultado=calcularDiasHabiles(hoy,mas);  

      var elDia=Resultado.getDate();
      var elMes=Number(Resultado.getMonth())+1;
      var elAnyo=Resultado.getFullYear();
      var laFecha=elDia+'/'+elMes+'/'+elAnyo;

      return laFecha;   
}

    
function asignarValorDesplegable(form,nombreObj,valor){
  var indiceSeleccionado=form.elements[nombreObj].length-1;
  for(var n=0;n<form.elements[nombreObj].length;n++){
    if(form.elements[nombreObj].options[n].value==valor){
      indiceSeleccionado=n;
    }
  }
  form.elements[nombreObj].selectedIndex=indiceSeleccionado;
}

    
function actualizarPlazo(form,nombreObj, fFechaOrigen){

  var fechaOrigen=fFechaOrigen.getDate()+'/'+(Number(fFechaOrigen.getMonth())+1)+'/'+fFechaOrigen.getFullYear();
  var fechaDestino=form.elements['FECHA_'+nombreObj].value;
  var nombreCombo;

  if(CheckDate(fechaDestino)==''){

    var fFechaDestino=new Date(formatoFecha(fechaDestino,'E','I'));

    if(nombreObj=='ENTREGA_REAL'){
      var diferencia=diferenciaDias(fFechaOrigen,fFechaDestino,'HABILES');
      nombreCombo='COMBO_'+nombreObj;
    }
    else{
      var diferencia=diferenciaDias(fFechaOrigen,fFechaDestino,'NATURALES');
      nombreCombo='IDPLAZOPAGO';
    }
    asignarValorDesplegable(form,nombreCombo,diferencia);     
  }
  else{
    alert(CheckDate(fechaDestino));
  }
}


function ultimosComentarios(nombreObjeto,nombreForm,tipoComentario){

  var accion='CONSULTAR';
  MostrarPagPersonalizada('http://www.newco.dev.br/Compras/NuevaMultioferta/UltimosComentarios.xsql?NOMBRE_OBJETO='+nombreObjeto+'&NOMBRE_FORM='+nombreForm+'&ACCION='+accion+'&TIPO='+tipoComentario+'&COMENTARIO='+document.forms[nombreForm].elements[nombreObjeto].value.replace(/\n/g,'\\\\n'),'form1',45,50,-80,-55);
}


function copiarComentarios(nombreForm,nombreObjeto,texto){
  if(quitarEspacios(document.forms[nombreForm].elements[nombreObjeto].value)!=''){
    document.forms[nombreForm].elements[nombreObjeto].value+='\n\n';
  }
  document.forms[nombreForm].elements[nombreObjeto].value+=texto;
  comentariosToForm1(document.forms['form1'], document.forms['form1'],'NMU_COMENTARIOS');
}
            


//	7may18	cambio del estado Recibido/No recibido para una línea de pedido
function cambioRecibido(idLinea)
{
	//console.log('cambioRecibido:'+idLinea);
	
	//	Comprueba si actualmente está infiormado como entregado o no
	if (document.images['IMGRECIBIDO_'+idLinea].src=='http://www.newco.dev.br/images/recibido.gif')
	{
        document.forms['form1'].elements['CantidadEntregada_'+idLinea].value=0;
        document.images['IMGRECIBIDO_'+idLinea].src='http://www.newco.dev.br/images/norecibido.gif';
        document.forms['form1'].elements['CHKRECIBIDO_'+idLinea].value='unchecked';
	}
	else		
	{
        var CantidadTotalLinea=document.forms['form1'].elements['CANTIDADSINFORMATO_'+idLinea].value;
        document.forms['form1'].elements['CantidadEntregada_'+idLinea].value=CantidadTotalLinea;
        document.images['IMGRECIBIDO_'+idLinea].src='http://www.newco.dev.br/images/recibido.gif';
        document.forms['form1'].elements['CHKRECIBIDO_'+idLinea].value='checked';
	}

	comprobarRecibidoCompleto();	//	8may18
}



//	7may18	comprobamos si el pedido se ha recibido completo, muestra los botones correspondientes
function comprobarRecibidoCompleto()
{

	var completo='S';

    //for para enseñar o no boton de recibido parcial
    var form = document.forms['form1'];
    for(var i=0;i<form.length;i++){
        if (form.elements[i].name.substring(0,12) == 'CHKRECIBIDO_' ){
            //alert(form.elements[i].value);
            if (form.elements[i].value == 'unchecked'){
                completo='N';
            }
         }
    }
	
	if (completo=='S')
	{
        botonesRecibidoCompleto();
	}
	else
	{
        botonesRecibidoParcial();
	}
	
	
	return completo;	
	
}

	
//	7may18	muestra botones para "recibido completo"
function botonesRecibidoCompleto()
{
    jQuery("#botonRecibidoParc").hide();
    jQuery("#botonAbono").hide();
    jQuery("#botonBackorder").hide();
    jQuery("#botonLegalizar").hide();

    jQuery("#botonRecibido").show();
}


//	7may18	muestra botones para "recibido parcial"
function botonesRecibidoParcial()
{
    jQuery("#botonRecibidoParc").show();
    jQuery("#botonAbono").show();
    jQuery("#botonBackorder").show();
    jQuery("#botonLegalizar").show();

    jQuery("#botonRecibido").hide();
}



//
//	Carga de documento
//

//cargar documentos
function cargaDoc(){

	//solodebug
	console.log('cargaDoc: Inicio.');


    var form=document.forms['form1'];
	var msg = '';

	/*
	if(uploadFrameDoc && uploadFrameDoc.document && uploadFrameDoc.document.getElementsByTagName("body")[0]){
		uploadFrameDoc.document.getElementsByTagName("body")[0].innerHTML = "";
	}
	
	if(msg != ''){
		alert(msg);
	}else{
	*/
		if(hasFilesDoc(form)){

			var actionAnt=form.action;		//	2oct18
			var targetAnt=form.target;		//	2oct18
			var encodingAnt=form.encoding;	//	2oct18

			var target = 'uploadFrameDoc';
			var action = 'http://www.newco.dev.br/cgi-bin/uploadDocsMVM.pl';
			var enctype = 'multipart/form-data';

			form.target = target;
			form.encoding = enctype;
			form.action = action;
			waitDoc();
			form_tmp = form;
			man_tmp = true;
			periodicTimerDoc = 0;
			periodicUpdateDoc();

			//solodebug
			console.log('cargaDoc: submit form.');
			
			form.submit();
			
			form.action=actionAnt;		//	2oct18
			form.target=targetAnt;		//	2oct18
			form.encoding=encodingAnt;	//	2oct18
		}
	//}//fin else
}//fin de carga documentos js

//Search form if there is a filled file input
function hasFilesDoc(form){
	for(var i=1; i<form.length; i++){
		if(form.elements[i].type == 'file' && (form.elements[i].name == 'inputFileDoc') && form.elements[i].value != '' ){
			return true;
		}
	}
	return false;
}

//function que dice al usuario de esperar
function waitDoc(){

	//solodebug
	console.log('waitDoc.');


	jQuery('#waitBoxDoc').html ('<img src="http://www.newco.dev.br/images/loading.gif" />');
	jQuery('#waitBoxDoc').show();
	return false;
}

/**
 * Check periodically if the image upload is finished
 * @return Boolean - true if filled file input found
 */
function periodicUpdateDoc(){

	//solodebug
	console.log('periodicUpdateDoc: Inicio.');

	if(periodicTimerDoc >= MAX_WAIT_DOC){
		alert(document.forms['mensajeJS'].elements['HEMOS_ESPERADO'].value + MAX_WAIT_DOC + document.forms['mensajeJS'].elements['LA_CARGA_NO_TERMINO'].value);
		return false;
	}
	periodicTimerDoc++;

	if(uploadFrameDoc && uploadFrameDoc.document && uploadFrameDoc.document.getElementsByTagName("p")[0]){
		var tipoDocHTML	= document.forms['form1'].elements['TIPO_DOC_HTML'].value;

		var uFrame	= uploadFrameDoc.document.getElementsByTagName("p")[0];

		document.getElementById('waitBoxDoc').style.display = 'none';

		if(uFrame.innerHTML.substr(0, 1) != '{' && uFrame.innerHTML.substr(0, 1) != '['){
			alert(document.forms['mensajeJS'].elements['ERROR_SIN_DEFINIR'].value);
			return false;
		}else{
			var response = eval('(' + uFrame.innerHTML + ')');

			//solodebug
			console.log('periodicUpdateDoc: llamando a handleFileRequestDoc.');

			handleFileRequestDoc(response);
			return true;
		}
	}else{
		window.setTimeout(periodicUpdateDoc, 1000);
		return false;
	}
	return true;
}

/**
 * handle Request after file (or image) upload
 * @param {Array} resp Hopefully JSON string array
 * @return Boolean
 */
function handleFileRequestDoc(resp){
	var lang = new String('');
				
	//solodebug
	console.log('handleFileRequestDoc: Inicio.');

	if(document.getElementById('myLanguage') && document.getElementById('myLanguage').innerHTML.length > 0){
		lang = document.getElementById('myLanguage').innerHTML;
	}

/*
	var form = form_tmp;
	var target = '_top';
	var enctype = 'application/x-www-form-urlencoded';
*/
	var msg = '';
	var documentChain = new String('');


//	var action = 'http://www.newco.dev.br/' + lang + 'confirmCargaDocumentoPedido.xsql';

	var docNombre = '';
	var docDescri = '';
	var nombre = '';

	if(resp.documentos){
		if(resp.documentos && resp.documentos.length > 0){
			for(var i=0; i<resp.documentos.length; i++){
				if(resp.documentos[i].error && resp.documentos[i].error != ''){
					msg += resp.documentos[i].error;
				}else{
					if(resp.documentos[i].size){
					/*en lugar del elemento nombre del form cojo el nombre del fichero diretamente, si hay espacios el sistema pone ghion bajo, entonces cuento cuantos ghiones son, divido al penultimo y añado la ultima palabra, si la ultima palabra esta vacía implica que hay 2 ghiones bajos, entonces divido a los 2 ghiones bajos y cojo la primera parte.*/
						var lastWord = '';
						var sinEspacioNombre = resp.documentos[i].nombre.replace('__','_');

						var numSep = PieceCount(sinEspacioNombre,'_');
						var numSepOk = numSep -1;
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
				var cadenaDoc	= document.getElementsByName('CADENA_DOCUMENTOS')[0].value;
			}
		}
	}

	//var usuario	= document.forms['form1'].elements['ID_USUARIO'].value;
	var borrados	= document.forms['form1'].elements['DOCUMENTOS_BORRADOS'].value;
	var borr_ante	= document.forms['form1'].elements['BORRAR_ANTERIORES'].value;
	var tipoDocDB	= document.forms['form1'].elements['TIPO_DOC_DB'].value;
	var tipoDocHTML	= document.forms['form1'].elements['TIPO_DOC_HTML'].value;
	// En este caso usamos el IDEmpresa del cliente como parámetro de entrada para IDPROVEEDOR
	//var IDEmpresa	= '';
	//if(document.forms['form1'].elements['IDEMPRESA'].value != ''){
	//	IDEmpresa	= document.forms['form1'].elements['IDEMPRESA'].value;
	//}

	if(msg != ''){
		alert(msg);
		return false;
	}else{

//		form.encoding	= enctype;
//		form.action	= action;
//		form.target	= target;
		var d = new Date();

		jQuery.ajax({
			url:"http://www.newco.dev.br/Compras/Multioferta/confirmCargaDocumentoPedidoAJAX.xsql",
			data: "&MO_ID="+IDMultioferta+"&IDEMPRESA="+IDEmpresa+"&TIPODOC="+tipoDocDB+"&CADENA_DOCUMENTOS="+cadenaDoc+"&_="+d.getTime(),
			type: "GET",
			async: false,
			contentType: "application/xhtml+xml",
			beforeSend:function(){
				document.getElementById('waitBoxDoc').src = 'http://www.newco.dev.br/images/loading.gif';
			},
			error:function(objeto, quepaso, otroobj){
				alert("objeto:"+objeto);
				alert("otroobj:"+otroobj);
				alert("quepaso:"+quepaso);
			},
			success:function(data){
				var doc=eval("(" + data + ")");
				
				
				//solodebug
				console.log('handleFileRequestDoc: OK.'+data);
				

				//reinicializo los campos del form
				document.forms['form1'].elements['inputFileDoc'].value = '';

				if(document.forms['form1'].elements['MAN_PRO'] && document.forms['form1'].elements['MAN_PRO'].value != 'si'){
					if (document.forms['form1'].elements['US_MVM'] && document.forms['form1'].elements['US_MVM'].value == 'si'){
						document.forms['form1'].elements['IDPROVEEDOR'].value = '-1';
					}
				}

				var tipo = document.forms['form1'].elements['TIPO_DOC_HTML'].value;

				//vaciamos la carga documentos
				document.forms['form1'].elements['inputFileDoc'+tipo] = '';
				jQuery("#carga"+tipo).hide();

				uploadFrameDoc.document.getElementsByTagName("p")[0].innerHTML = '';
				uploadFrameDoc.document.getElementsByTagName("body")[0].innerHTML = "";

//				var proveedor = document.forms['form1'].elements['IDPROVEEDOR'].value;

				//Informamos del IDDOC en el input hidden que toca y avisamos al usuario
				//jQuery('#IDDOCUMENTO').val(doc[0].id_doc);
				//Creamos el link para acceder al archivo, link para borrarlo y ocultamos link para subir documento
				var nombreDoc	= doc[0].nombre;
				var fileDoc	= doc[0].file;
				var htmlCad= '&nbsp;&nbsp;&nbsp;&nbsp;<a href="http://www.newco.dev.br/Documentos/' + fileDoc + '" target="_blank">' + nombreDoc + '</a>'
								+'<a href="javascript:borrarDoc('+doc[0].id_doc+');"><img src="http://www.newco.dev.br/images/2017/trash.png"/></a>';
				jQuery('#docBox').empty().append(htmlCad).show();
				//jQuery('#borraDoc').append('<a href="javascript:borrarDoc(' + doc[0].id_doc + ',\'' + tipo + '\')"><img src="http://www.newco.dev.br/images/2017/trash.png"/></a>').show();
				//jQuery('#newDoc').hide();
				jQuery('#inputFileDoc').hide();

				//reseteamos los input file, mismo que removeDoc
				var clearedInput;
				var uploadElem = document.getElementById("inputFileDoc");

				uploadElem.value = '';
				clearedInput = uploadElem.cloneNode(false);

				uploadElem.parentNode.insertBefore(clearedInput, uploadElem);
				uploadElem.parentNode.removeChild(uploadElem);
				uploadFilesDoc.splice(tipo, 1);

				return undefined;
			}
		});
	}
	return true;
}



function borrarDoc(IDDoc){
	var d = new Date();

	jQuery.ajax({
		cache:	false,
		url:	'http://www.newco.dev.br/Administracion/Mantenimiento/Productos/BorrarDocumento.xsql',
		type:	"GET",
		data:	"DOC_ID="+IDDoc+"&_="+d.getTime(),
		contentType: "application/xhtml+xml",
		success: function(objeto){
			var data = eval("(" + objeto + ")");

			if(data.BorrarDocumento.estado == 'OK'){
				//jQuery("#IDDOCUMENTO").val("");
				jQuery("#borraDoc").empty().hide();
				jQuery("#docBox").empty().hide();
				//jQuery("#newDoc").show();
				jQuery('#inputFileDoc').show();
            }else{
				alert('Error: ' + data.BorrarDocumento.message);
			}
		},
		error: function(xhr, errorString, exception) {
			alert("xhr.status="+xhr.status+" error="+errorString+" exception="+exception);
		}
	});
}




	
