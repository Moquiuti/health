//	JS para seleccin ptima de productos/proveedores
//	Ultima revision: ET 22jul18 10:51


//	Seleccion Optima
function SeleccionOptima()
{
	var MejorPrecio, MejorColumna, MejorOfertaID, valAux;

	// Marcamos el flag de control como que se han hecho nuevos cambios en el formulario
	anyChange = true;
	jQuery('#botonSelecOptima').hide();


	//
	//	1.- Seleccion mejores precios
	// Se puede sustituir por llamada a SeleccionarMejoresPrecios()
	//
	jQuery.each(arrProductos, function(key, producto){
		MejorPrecio	= -1;
		MejorColumna	= -1;

		jQuery.each(producto['Ofertas'], function(key2, oferta){
			valAux = (oferta.Precio != '') ? parseFloat(oferta.Precio.replace(',', '.')) : '';

			if(valAux != '' && (MejorPrecio < 0 || MejorPrecio > valAux)){
				MejorPrecio	= valAux;
				MejorColumna	= key2;
			}
		});

		if(MejorColumna != -1){
			MejorOfertaID = arrProductos[key].Ofertas[MejorColumna].ID;	//21set16	.IDOferta
        }

		// Una vez tengo el mejor precio y su IDOferta, busco el radio button que toca
		var radioAux = document.getElementsByName('RADIO_' + key);

		for(var j = 0; j < radioAux.length; j++){
			if(radioAux[j].value == MejorOfertaID){
				radioAux[j].checked = true;
				// Ahora lanzamos la funcion para que recalcule el div flotante (ms rapido que hacerlo todos de golpe con MostrarFloatingBox)
				recalcularFloatingBox(radioAux[j], 0);
			}
		}
		
	});


	//
	// Fase 2.- Validamos pedidos minimos para mostrar/ocultar el aviso de pedido minimo por proveedores.
	// Se puede sustituir por llamada a validarPedidosMinimosDOM()
	//
	var arrConsumos	= new Array(arrConsumoProvs.length);
	var arrPedsMin	= new Array(arrConsumoProvs.length);
	var errPedMin = false, numOfertas = 0;

	//Inicializamos dos arrays:
		// arrConsumos - contador de consumos por proveedor segun ofertas seleccionadas
		// arrPedsMin - donde guardamos el valor del pedido minimo segun proveedor
	for(var i=0; i<arrConsumoProvs.length; i++){
		arrConsumos[i]	= 0;
		arrPedsMin[i]	= parseFloat(arrConsumoProvs[i].PedidoMin.replace(".","").replace(",","."));
	}

	// Recorremos el array de productos entero
	jQuery.each(arrProductos, function(key, producto){
		// Si el producto en cuestion se muestra por pantalla, recuperamos los datos del radio button del DOM
		if(jQuery("tr#posArr_" + key).length){
			// Recorremos los N radio buttons del producto en cuestion para encontrar el que pertenece al proveedor que tiene la oferta
			jQuery(".RADIO_" + key).each(function(key2, thisRadio){
				if(jQuery(thisRadio).is(':checked')){ // Si esta checked, entonces sumamos el consumo en la posicion del array que toca
					numOfertas++;
					
					var thisPos = jQuery("#Prov_" + thisRadio.value).val();			//esto devuelve un número de columna
										
					//solodebug		console.log ('validarPedidosMinimosDOM. IDPROVEEDOR:'+thisRadio.value+ ' thisPos:'+thisPos);
					
					arrConsumos[thisPos] += parseFloat(producto.Ofertas[thisPos].Consumo.replace(".","").replace(",","."));
					
					return false;
				}
			});
		// Si el producto en cuestion NO se muestra por pantalla, recuperamos los datos del propio objeto JS
		}else{

			jQuery.each(producto.Ofertas, function(key2, oferta){
				if(producto.Ofertas[key2].OfertaAdjud == 'S'){
					numOfertas++;
					arrConsumos[key2] += parseFloat(producto.Ofertas[key2].Consumo.replace(".","").replace(",","."));
					return false;
				}
			});
		}
	});

	// Ahora recorremos de nuevo el array para mostrar/ocultar la imagen de aviso segun la validacion de pedido minimo
	for(i=0; i<arrConsumoProvs.length; i++){
		if(arrPedsMin[i] > arrConsumos[i] && arrConsumos[i] != 0){
		
			arrConsumoProvs[i].CumplePedMinimo='N';	//	22jul18	Marcamos el nuevo campo en arrConsumoProvs
			
			errPedMin = true;
			jQuery("#avisoProv_" + parseInt(i + 1)).show();
		}else{

			arrConsumoProvs[i].CumplePedMinimo='S';	//	22jul18	

			jQuery("#avisoProv_" + parseInt(i + 1)).hide();
		}
	}

	// Si existe alguna seleccion que no cumple el pedido minimo mostramos icono aviso en el floatingBox
	if(!errPedMin && numOfertas == arrProductos.length){
		jQuery('#FBAviso').html('&nbsp;<img src="http://www.newco.dev.br/images/check.gif" style="vertical-align:text-bottom;"/>');
	}else{
		jQuery('#FBAviso').html('&nbsp;<img src="http://www.newco.dev.br/images/atencion.gif" style="vertical-align:text-bottom;"/>');
	}

	//
	// Fase 3.- Revisamos los proveedores con problemas con el pedido minimo
	//
	if(errPedMin)
	{
		for(i=0; i<arrConsumoProvs.length; i++)
		{
			if (arrConsumoProvs[i].CumplePedMinimo=='N')
			{

				//	22jul18	solodebug			
				console.log('SeleccionOptima: PED_MIN_ERR ('+arrConsumoProvs[i].IDProvLic+') '+arrConsumoProvs[i].NombreCorto+'. ' +arrConsumoProvs[i].PedidoMin+'>'+arrConsumos[i]);
				
			}
		}
	}
	
	
	


	jQuery('#botonSelecOptima').show();
}
