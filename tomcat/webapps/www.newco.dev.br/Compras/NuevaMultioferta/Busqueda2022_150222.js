//	Buscador en "Enviar pedidos"
//	Ultima revision:ET 15feb22 11:40 Busqueda2022_150222.js

//	Cuidado, en la version anterior estaba ubicado en Multioferta, ahora en NuevaMultioferta

function Submit(form){
  if (form.LLP_CATEGORIA.selectedIndex <= 0){
	form.LLP_CATEGORIA.value = -1;
	form.LLP_FAMILIA.value = -1;
	form.LLP_SUBFAMILIA.value = -1;	        	        
      } 
      else{
        form.LLP_CATEGORIA.value = form.LLP_CATEGORIA.options[form.LLP_CATEGORIA.selectedIndex].value;
        if (form.LLP_FAMILIA.selectedIndex <= 0){
	  form.LLP_FAMILIA.value = -1;
	  form.LLP_SUBFAMILIA.value = -1;	        	        
        }else{
          form.LLP_FAMILIA.value = form.LLP_FAMILIA.options[form.LLP_FAMILIA.selectedIndex].value;;            
          if (form.LLP_SUBFAMILIA.selectedIndex <= 0){
	    form.LLP_SUBFAMILIA.value = -1;	        	        
          }
          else{
            form.LLP_SUBFAMILIA.value = form.LLP_SUBFAMILIA.options[form.LLP_SUBFAMILIA.selectedIndex].value;;            
          }
        } 
      }
      SubmitForm(form);
}

//Seleccionamos en combo la opcion selecc
function seleccionarCombo(combo, selecc){
  for (i=1;i<combo.options.length;i++){	  
	if (combo.options[i].value == selecc){
	  combo.selectedIndex = i;
	  break;  
	}
      }
    }	

//Anyadimos en el combo (sel) la opcion llamada 'text' con valor 'value' y sin seleccionar.
function addOption(sel,text,value){
  var defaultSelected = false;
  var selected = false;	    
  sel.options[sel.length] = new Option(text, value, defaultSelected, selected);
} 

//function deleteOption(sel,posicion) {
//  sel.options[posicion] = null;
//}
function deleteOptions(Object){
  for (var i=Object.options.length-1;i>0;i--){
	Object.options[i] = null;
  }   
}
		

function Linka(pag){
	parent.frames['zonaTrabajo'].document.location.href=pag;
}

function Busqueda(formu,accion){
	if(formu.elements['CHECK_LISTADO_PLANTILLA'].checked == true){
		formu.elements['LLP_LISTAR'].value = 'PLA';
	}else{
		formu.elements['LLP_LISTAR'].value = 'PRO';
	}

	if(formu.elements['LLP_LISTAR'].value=='PLA'){
		AsignarAccion(formu,'http://www.newco.dev.br/Compras/Multioferta/BuscadorCatalogoPrivado2022.xsql?DONDE_SE_BUSCA='+formu.elements['LLP_LISTAR'].value);
		SubmitForm(formu);
	}
	else
	{
		AsignarAccion(formu,'http://www.newco.dev.br/Compras/Multioferta/ListaProductos2022.xsql');
		SubmitForm(formu);
	}
}

/*
	// Permite manipular los checkbox como si fueran 'Radio'
	function ValidarCheckBox(formu,seleccionado){
		for(var i=0;i<formu.elements.length;i++){
			if(formu.elements[i].type=="checkbox")
				if(formu.elements[i].name != seleccionado)
					formu.elements[i].checked=false;
				else
					formu.elements[i].checked=true;
		}

		// Por defecto buscamos productos.
		formu.elements['LLP_LISTAR'].value = 'PRO';

		if(seleccionado == 'BuscarProveedores'){
			formu.elements['LLP_LISTAR'].value = 'EMP';
		}
	}
*/

function handleKeyPress(e){
	var keyASCII;

	if(navigator.appName.match('Microsoft'))
		keyASCII=event.keyCode;
	else
		keyASCII = (e.which);

	if(keyASCII == 13)
		Busqueda(document.forms[0],'');
}

// Asignamos la función handleKeyPress al evento
if(navigator.appName.match('Microsoft')==false)
	document.captureEvents();
document.onkeypress = handleKeyPress;


function EnviarBusqueda(){
	if(LimitarCantidadPalabras(document.forms[0].elements['LLP_NOMBRE'],5)){
		var longMax = CalcularLongMaxPalabra(document.forms[0].elements['LLP_NOMBRE']);

		if(document.forms[0].elements['LLP_NOMBRE'].value.length != 0 && longMax < 3){
			alert(error_buscador_min_char);
		}else if(longMax == 3){
			if(confirm(error_buscador_min_char + '\n' + confirm_buscador_continuar))
				Busqueda(document.forms[0],'');
		}else{
			Busqueda(document.forms[0],'');
		}
	}
}

function LimitarCantidadPalabras(obj,numPalabras){
	var nombreCampo;

	if(obj.name=='LLP_NOMBRE')
		nombreCampo='Producto';
	/*else
		if(obj.name=='LLP_PROVEEDOR')
			nombreCampo='Proveedor';*/

	var numEspacios=0;
	obj.value=obj.value.trim();

	for(var n=0;n<obj.value.length;n++){
		if(obj.value.substring(n,n+1)==' '){
			numEspacios++;
		}
		if(numEspacios>=numPalabras){
			var cadTemp=obj.value.substring(0,n);
			if(confirm(document.forms['mensajeJS'].elements['CRITERIO_DEMASIADO_LARGO'].value)){
				obj.value=obj.value.substring(0,n);
				return true;
			}else{
				return false;
			}
		}
	}
	return true;
}

// Funcion que recorre todas las palabras de un input text y calcula longitud de la mas larga
function CalcularLongMaxPalabra(obj){
	var aPalabras = new Array();
	var maxLength = 0;

	aPalabras = obj.value.split(' ');

	for(var i=0; i<aPalabras.length; i++){
		aPalabras[i] = aPalabras[i].trim();
		if(aPalabras[i].length > maxLength)
			maxLength = aPalabras[i].length;
	}

	return maxLength;
}

/*	8oct09	ET	No presentamos la lista de clientes
	function MostrarOcultarListaEmpresas(){
		if(document.forms[0].elements["LLP_LISTAR"].value=='PLA'){
			//	mostrar desplegable empresas
			document.getElementById("TD_CLIENTES").style.display='block';
		}else{
			//	ocultar desplegable empresas
			document.getElementById("TD_CLIENTES").style.display='none';
		}
	}
*/

//	7dic10	Si se selecciona el catalogo de proveedores activamos el check de "sin stock"
function CambioCatalogo(){
	var form=document.forms[0];
	if((form.elements["LLP_LISTAR"].value=='PRO')||(form.elements["LLP_LISTAR"].value=='PLA'))
		form.elements["SIN_STOCKS"].disabled=false;
	else
		form.elements["SIN_STOCKS"].disabled=true;
}
