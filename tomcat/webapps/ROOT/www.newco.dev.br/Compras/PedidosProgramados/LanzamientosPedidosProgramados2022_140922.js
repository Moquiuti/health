//	JS Calendario de PROGRAMA. Nuevo disenno 2022
//	Ultima revision: ET 14set22 18:30 LanzamientosPedidosProgramados2022_140922.js

function asignarFondo()
{
  for(var n=0;n<arrayFechasTemp.length;n++){
	var arrFechaActual=arrayFechasTemp[n];
	if(esFechaLanzamiento(arrFechaActual[1])){
	  if(document.getElementById('CELDA_'+arrFechaActual[0])){
	    asignarFondoAObjeto('CELDA_',arrFechaActual[0],obtenerClase('CELDA_',arrFechaActual[0]));
	  }
	  if(document.getElementById('FECHA_'+arrFechaActual[0])){
	    asignarFondoAObjeto('FECHA_',arrFechaActual[0],obtenerClase('FECHA_',arrFechaActual[0]));
	  }
	}
  }
}


function obtenerClase(prefijo,fecha)
{

  var clase;

  if(document.getElementById(prefijo+fecha).className=='diasVacacionesProveedor' ||
	 document.getElementById(prefijo+fecha).className=='diasVacacionesCliente' ||
	 document.getElementById(prefijo+fecha).className=='grisclaro'){
	clase='diasLanzamientosConflictos';
  }
  else{
	clase='diasLanzamientosCorrectos';
  }
  return clase;
}



function esFechaLanzamiento(estilo)
{

  if(estilo=='diasLanzamientosCorrectos'|| estilo=='diasLanzamientosConflictos'){
	return true;
  }
  else{
	return false;
  }
}

function esVacaciones(fecha){

  if(document.getElementById('FECHA_'+fecha)){
	if(document.getElementById('FECHA_'+fecha).className=='diasVacacionesCliente'||
	    document.getElementById('FECHA_'+fecha).className=='diasVacacionesProveedor'){
	    return true;   
	}
	else{
	    return false;
	}
  }
  else{
	return false;
  }
}


function asignarFondoAObjeto(prefijo,fecha,estilo)
{

  var bgcolorEstilo='';
  var fontColorEstilo='';
  var fontWeightEstilo='';
  var txtDecoration='';

  //alert(prefijo+fecha+' '+estilo);

  document.getElementById(prefijo+fecha).className=estilo;

  switch(estilo){

	case 'diasLanzamientosCorrectos':
	  bgcolorEstilo='blue';
	  fontColorEstilo='white';
	  fontWeightEstilo='bold';
	break;

	case 'diasLanzamientosConflictos':
	  bgcolorEstilo='blue';
	  fontColorEstilo='white';
	  fontWeightEstilo='bold';
	break;

	case 'diasAnteriores':
	  bgcolorEstilo='#EBEBEB';
	  fontColorEstilo='black';
	  fontWeightEstilo='normal';
	  txtDecoration='line-through';
	break;


  }

  if(prefijo=='FECHA_'){

	document.getElementById(prefijo+fecha).style.background=bgcolorEstilo;
	document.getElementById(prefijo+fecha).style.color=fontColorEstilo;
	document.getElementById(prefijo+fecha).style.fontWeight=fontWeightEstilo;
	document.getElementById(prefijo+fecha).style.textDecoration=txtDecoration;
  }

}


function obtenerClasePorDefectoDelDia(objDia){
	for(var n=0;n<arrayEstilos.length;n++){
	  if(arrayEstilos[n][0]==objDia){
    	return (arrayEstilos[n][1]);
	  }
	}    
}


//calculamos los diasd habiles teninedo en cuenta las vacaciones */
function calcularDiasHabiles(hoy,incremento, conVacaciones){


	// conVacaciones  tenemos en cuenta los dias marcados como vacaciones para los calculos (los tratamos como fin de semana)

	var fechaResultado=hoy;

	var incrementoDiasHabiles=0;

	if(incremento>=0){
	 while(incrementoDiasHabiles<incremento){
	   fechaResultado=sumaDiasAFecha(fechaResultado,1);  
    	 /* es dia laborable */
	   if(fechaResultado.getDay()!=0 && fechaResultado.getDay()!=6){
    	  /* controlamos las vacaciones */

    	 if(conVacaciones==true){
        	  /* no esta marcado como vacaciones */ 

    	   var fechaResultadoTexto=convertirFechaATexto(fechaResultado);



    	   if(!esVacaciones(fechaResultadoTexto)){
        	 incrementoDiasHabiles++;     
    	   } 
    	 }
    	 else{
        	 /* no lo controlamos, se contabiliza el dia */
    	   incrementoDiasHabiles++;
    	 }
	   }
	   else{
    	 /* es finde */
    	 null;
    	 /* no hacemos nada*/
	   }
	 }
	}
	else{
	 while(incrementoDiasHabiles>incremento){
	   fechaResultado=sumaDiasAFecha(fechaResultado,-1);
    	 /* es dia laborable */  
	   if(fechaResultado.getDay()!=0 && fechaResultado.getDay()!=6){
    	 /* controlamos las vacaciones */
    	 if(conVacaciones==true){
    	  /* no esta marcado como vacaciones */ 

    	   var fechaResultadoTexto=convertirFechaATexto(fechaResultado);

    	   if(!esVacaciones(fechaResultadoTexto)){
        	 incrementoDiasHabiles--;     
    	   } 
    	 }
    	 else{ 
        	 /* no lo controlamos, se contabiliza el dia */
    	   incrementoDiasHabiles--;
    	 }
	   }
	 }
	}

	return(fechaResultado);
}


//	Cambia la clase del "anchor" correspondiente al dia modificado
function Pulsado(ControlPulsado)
{
  var bgcolorEstiloPorDefecto;
  var clasePorDefecto;
  var usuario;
  txtDecoration='';



  clasePorDefecto=obtenerClasePorDefectoDelDia(document.getElementById(ControlPulsado).name);

  if(clasePorDefecto=='diasVacacionesCliente'){
	usuario='usted';
  }
  else{
	usuario='el proveedor';
  }

  var id=obtenerId(document.getElementById(ControlPulsado).name);

  switch(clasePorDefecto){
	case 'claro':
	  bgcolorEstiloPorDefecto='#EEFFFF';
	  fontColorEstiloPorDefecto='black';
	  fontWeightEstiloPorDefecto='normal';
	break;

	case 'oscuro':
	  bgcolorEstiloPorDefecto='#EBEBEB';
	  fontColorEstiloPorDefecto='black';
	  fontWeightEstiloPorDefecto='normal';
	break;

	case 'diasVacacionesCliente':
	  bgcolorEstiloPorDefecto='#FDD61F';
	  fontColorEstiloPorDefecto='black';
	  fontWeightEstiloPorDefecto='bold';
	break;

	case 'diasVacacionesProveedor':
	  bgcolorEstiloPorDefecto='red';
	  fontColorEstiloPorDefecto='white';
	  fontWeightEstiloPorDefecto='bold';
	break;

	case 'grisclaro':
	  bgcolorEstiloPorDefecto='#EBEBEB';
	  fontColorEstiloPorDefecto='black';
	  fontWeightEstiloPorDefecto='normal';
	break;  

	case 'diasAnteriores':
	  bgcolorEstiloPorDefecto='#EBEBEB';
	  fontColorEstiloPorDefecto='black';
	  fontWeightEstiloPorDefecto='normal';
	  txtDecoration='line-through';
	break;

  }

  //colorDiasVacacionesCliente='#FDD61F';
  //colorDiasVacacionesProveedor='red';
	//colorDiasLanzamientosCorrectos='blue';
	//colorDiasLanzamientosConflictos='blue';


	//alert(clasePorDefecto+' '+ document.getElementById(ControlPulsado).className);


	if (document.getElementById(ControlPulsado).className=='diasLanzamientosCorrectos'||
		document.getElementById(ControlPulsado).className=='diasLanzamientosConflictos'){

		if(document.getElementById(ControlPulsado).className=='diasLanzamientosConflictos'){
		  if(confirm(msgDiaEntregaConflictos+usuario+confimacionAccionActivo+explicacionActivo)){
			document.getElementById(ControlPulsado).className=clasePorDefecto;
			document.getElementById('CELDA_'+id).className=clasePorDefecto;
			document.getElementById(ControlPulsado).style.color=fontColorEstiloPorDefecto;
			document.getElementById(ControlPulsado).style.background=bgcolorEstiloPorDefecto;
			document.getElementById(ControlPulsado).style.fontWeight=fontWeightEstiloPorDefecto;
			document.getElementById(ControlPulsado).blur();
		  }
		}
		else{
		  document.getElementById(ControlPulsado).className=clasePorDefecto;
		  document.getElementById('CELDA_'+id).className=clasePorDefecto;
		  document.getElementById(ControlPulsado).style.color=fontColorEstiloPorDefecto;
		  document.getElementById(ControlPulsado).style.background=bgcolorEstiloPorDefecto;
		  document.getElementById(ControlPulsado).style.fontWeight=fontWeightEstiloPorDefecto;
		  document.getElementById(ControlPulsado).blur();
		}

	}
	else{
	  if(document.getElementById(ControlPulsado).className=='diasVacacionesCliente'  ||
		 document.getElementById(ControlPulsado).className=='diasVacacionesProveedor'||
		 document.getElementById(ControlPulsado).className=='grisclaro' ||
		 document.getElementById(ControlPulsado).className=='diasAnteriores'){
		if(document.getElementById(ControlPulsado).className=='grisclaro'||
		   document.getElementById(ControlPulsado).className=='diasAnteriores'){
		  alert(msgDiaEntregaFinDeSemana);
		}
		else{
		  if(confirm(msgDiaEntregaConflictos+usuario+confimacionAccionNoActivo+explicacionNoActivo)){
		    document.getElementById('CELDA_'+id).className='diasLanzamientosConflictos';
		    document.getElementById(ControlPulsado).className='diasLanzamientosConflictos';
			  document.getElementById(ControlPulsado).style.color='white';
			  document.getElementById(ControlPulsado).style.background='blue';
			  document.getElementById(ControlPulsado).style.fontWeight='bold';
			  document.getElementById(ControlPulsado).blur(); 
			}
		  }
	  }
	  else{
		  document.getElementById(ControlPulsado).className='diasLanzamientosCorrectos';
		  document.getElementById('CELDA_'+id).className='diasLanzamientosCorrectos';
		  document.getElementById(ControlPulsado).style.color='white';
		  document.getElementById(ControlPulsado).style.background='blue';
		  document.getElementById(ControlPulsado).style.fontWeight='bold';
		  document.getElementById(ControlPulsado).blur();
		}
  }
}


// funcion para montar la cadena de resultados
function montarCadenaResultados()
{

	// quitamos las vacaciones de este anyo y las volvemos a montar, junto con los demas anyos
	var arrayResultadoTmp=document.forms['form1'].elements['RESULTADO'].value.split('·');


	var Resultado='';

	for(var n=0;n<arrayResultadoTmp.length;n++){
	  if(arrayResultadoTmp[n]!=''){
	    arrTmp=arrayResultadoTmp[n].split('|');
	    if(!existeSubCadena(arrTmp[0], anyoActual)){
	      Resultado+=arrTmp[0]+'|'+arrTmp[1]+'·';
	    }
	  }
	}

	// tratamos las de este anyo
	for (i=0;i<document.anchors.length;++i)
	{



		if (document.anchors[i].className=="diasLanzamientosCorrectos"||document.anchors[i].className=="diasLanzamientosConflictos"){

		  var fFechaEntrega=new Date(formatoFecha(document.anchors[i].name.replace('FECHA_',''),'E','I'));
		var fFechaLanzamiento=calcularDiasHabiles(new Date(formatoFecha(document.anchors[i].name.replace('FECHA_',''),'E','I')),-plazoEntregaGenerico,true);

		var plazoEntrega=diferenciaDias(fFechaLanzamiento,fFechaEntrega,'HABILES');
			Resultado=Resultado+document.anchors[i].name+'|'+plazoEntrega+'·';
	  }
	}

	return Resultado;

}


//	Guarda los cambios creando una cadena a partir de los "anchor" correspondientes a los dias modificados
function Guardar()
{

	document.forms[0].elements['ACCION'].value='MODIFICAR';
	document.forms[0].elements['ANYOS_VISITADOS'].value=AnyosVisitados;
	document.forms[0].elements['RESULTADO'].value=montarCadenaResultados();

	//solodebug	alert('Guardar:'+document.forms[0].elements['PEDP_ID'].value);

	// la cadena resultado contine las fechas con el siguiente formato:
	//	  FECHA_xx/xx/xxx|FECHA_xx/xx/xxxx|...
	//   el formato que necesitamos es 
	//	  xx/xx/xxx|xx/xx/xxxx|...
	var arrayFechas=document.forms[0].elements['RESULTADO'].value.split('·');
	var resultado='';

	lanzamientoDiasAnteriores=0;

	for(var n=0;n<arrayFechas.length;n++)
	{
		if(arrayFechas[n]!='')
		{
			//  hemos de calcular el dia de lanzamiento y el plazo de entrega 
			var arrTmp=arrayFechas[n].split('|');

			var fFechaEntrega=new Date(formatoFecha(arrTmp[0].replace('FECHA_',''),'E','I'));
			var FechaEntrega=convertirFechaATexto(fFechaEntrega);
			var fFechaLanzamiento=calcularDiasHabiles(new Date(formatoFecha(arrTmp[0].replace('FECHA_',''),'E','I')),-arrTmp[1],false);
   			var FechaLanzamiento=convertirFechaATexto(fFechaLanzamiento);

    		resultado+=FechaLanzamiento+'|'+arrTmp[1]+'#';

    		if(obtenerClasePorDefectoDelDia('FECHA_'+FechaEntrega)=='diasAnteriores')
			{
    		  if(lanzamientoDiasAnteriores==0){
        		lanzamientoDiasAnteriores=1;
        		msgLanzamientoImposible='Las siguientes fechas de entrega no son válidas:\n\n  * '+FechaEntrega+'\n';

    		  }
    		  else{
        		msgLanzamientoImposible+='  * '+FechaEntrega+'\n';
    		  }
    		}
  		}
	}	

	msgLanzamientoImposible+='\nPor favor, corrijalas antes de guardar los cambios';

	document.forms[0].elements['RESULTADO'].value=resultado;
	//	Envia el formulario
	if(document.forms[0].elements['RESULTADO'].value==''){
	  alert(msgSinLanzamientos);
	}

	if(!lanzamientoDiasAnteriores){
	  SubmitForm(document.forms[0]);
	}
	else{
	  alert(msgLanzamientoImposible);
	}
}


function CerrarVentana()
{
	if (ventana=='NUEVA')
	{
		if (actualizarPagina=='S')
		{
	        if(window.parent.opener && !window.parent.opener.closed)
			{
            	var objFrameTop=new Object();   
            	objFrameTop=window.parent.opener.top;
            	var FrameOpenerName=window.parent.opener.name;
            	var objFrame=new Object();
            	objFrame=obtenerFrame(objFrameTop,FrameOpenerName);
            	if(objFrame!=null && objFrame.recargarPagina){
            	  objFrame.recargarPagina();
            }
            else{
            	Refresh(objFrame.document);
            }  	
          }
          window.close(); 
		}
		else
	        window.close();
	}
	else
	    document.location.href='about:blank';
}


function IncrementarAnyo(incremento){

  // montamos la cadena
  document.forms[0].elements['RESULTADO'].value=montarCadenaResultados();

  // calculamos el anyo destino
  var anyoDestino=Number(obtenerSubCadena(document.forms['form1'].elements['FECHAACTIVA'].value, 3))+Number(incremento);
  document.forms['form1'].elements['FECHAACTIVA'].value=obtenerSubCadena(document.forms['form1'].elements['FECHAACTIVA'].value, 1)+'/'+obtenerSubCadena(document.forms['form1'].elements['FECHAACTIVA'].value, 2)+'/'+anyoDestino;

  document.location.href='http://www.newco.dev.br/Compras/PedidosProgramados/LanzamientosPedidosProgramados2022.xsql?PEDP_ID='+document.forms['form1'].elements['PEDP_ID'].value+'&ACCION='+accion+'&TITULO='+titulo+'&FECHAACTIVA='+document.forms['form1'].elements['FECHAACTIVA'].value+'&IDUSUARIO='+idusuario+'&RESULTADO_TMP='+document.forms['form1'].elements['RESULTADO'].value+'&ANYOS_VISITADOS='+AnyosVisitados;
}


//	16set22 Calcula la diferencia en dias entre 2 fechas. Traido desde basic 180608.js
function diferenciaDias(fFechaOrigen,fFechaDestino,tipo){

	var diferenciaDias=0;
	var fFechaOrigenTmp;
	var fFechaDestinoTmp;
	var signo='';


	// si son iguales no hacemos nada
    if(fFechaOrigen==fFechaDestino){
		diferenciaDias=0;
	}
	else{
		if(fFechaOrigen<fFechaDestino){
		  fFechaOrigenTmp=new Date((Number(fFechaOrigen.getMonth())+1)+'/'+fFechaOrigen.getDate()+'/'+fFechaOrigen.getFullYear());
		  fFechaDestinoTmp=new Date((Number(fFechaDestino.getMonth())+1)+'/'+fFechaDestino.getDate()+'/'+fFechaDestino.getFullYear());
		}
		else{
		  fFechaOrigenTmp=new Date((Number(fFechaDestino.getMonth())+1)+'/'+fFechaDestino.getDate()+'/'+fFechaDestino.getFullYear());
		  fFechaDestinoTmp=new Date((Number(fFechaOrigen.getMonth())+1)+'/'+fFechaOrigen.getDate()+'/'+fFechaOrigen.getFullYear());
		  signo='-';
		}
		 //  para los naturales
		if(tipo=='NATURALES'){
		  while(fFechaOrigenTmp<fFechaDestinoTmp){
    		fFechaOrigenTmp=sumaDiasAFecha(fFechaOrigenTmp,1);
    		diferenciaDias+=1;
		  }
		}
		else{
		  if(tipo=='HABILES'){
    		while(fFechaOrigenTmp<fFechaDestinoTmp){
    		  fFechaOrigenTmp=sumaDiasAFecha(fFechaOrigenTmp,1);
    		  if(fFechaOrigenTmp.getDay()!=0 && fFechaOrigenTmp.getDay()!=6){
        		diferenciaDias+=1;
    		  }
    		}
		  }
		}
	}
	diferenciaDias=parseInt(signo+diferenciaDias);
return diferenciaDias;
}


//	16set22 Comprueba si existe una subcadena. Traido desde basic 180608.js
//	la funcion original de javascript daba problemas en el uso de nulos y con algunos caracteres ('?', '|')
function existeSubCadena(cadenaRecipiente, cadenaBuscada)
{

  if(cadenaBuscada.length==0 ||cadenaRecipiente.length==0)
  {
    return false;
  }
  else{
    if(cadenaBuscada.length>cadenaRecipiente.length)
	{
      return false;
    }
    else
	{
      for(var n=0;n<=cadenaRecipiente.length-cadenaBuscada.length;n++)
	  {

        var subCadenaTemp=cadenaRecipiente.substring(n,n+cadenaBuscada.length);

        if(subCadenaTemp==cadenaBuscada)
		{
          return true;
        }
      }
      return false;
    }
  }
}

