// JavaScript Document

 	var msg_SinCriterios = 'Introduzca algún criterio de busqueda antes de buscar. \nGracias.';
    var msg_DemasiadosCriteriosDefault = 'El criterio de búsqueda en el campo: \"';
	var msg_DemasiadosCriteriosExtra_1 = '\" contiene demasiadas palabras.\nEl máximo de palabras es de 5.\n\n    * Pulse \'Aceptar\' para enviar \"';
	var msg_DemasiadosCriteriosExtra_2 = '\"\n\n    * Pulse \'Cancelar\' para modificar los criterios manualmente.';
	var msgSinProveedor='Seleccione el proveedor para el que quiere realizar la busqueda.';
	var msgExpansion='Ha marcado algún producto para que se expandan sus precios. ¿Continuar con la expansión?';
	var msgExpandidosNulos='Alguno de los precios marcados para expandirse está vacío. Esta opción no está permitida. Desmarque la casilla o introduzca el precio. Gracias'
	
    /*eliminar imgenes X*/
    function Eliminar (){
    	alert('Estas seguro que deseas eliminar esta imagen?');
    }
	
	function Linka(pag){ 
	  parent.frames['zonaTrabajo'].document.location.href=pag; 
	}
    
	function Busqueda(formu,accion){ 
	
    	
            if (document.forms.length==2)
			{	//el formulario de Productos que contiene el numero de pagina no existe en la primera busqueda
            	if (document.forms['Productos'])
                	formu.elements['PAGINA'].value = document.forms['Productos'].elements['PAGINA'].value;	//et	07dic05	para que no cambie la pagina al cambiar el cliente

            	if (document.forms['formCambio'])
                	formu.elements['PAGINA'].value = document.forms['formCambio'].elements['PAGINA'].value;	

        	}
        	//alert(accion); 
        	AsignarAccion(formu,accion);
        	SubmitForm(formu);
	  	//}
	}

	// Permite manipular los checkbox como si fueran 'Radio'	
	function ValidarCheckBox(formu,seleccionado){
	    for (var i=0;i<formu.elements.length;i++) {
	      if (formu.elements[i].type=="checkbox")
	        if (formu.elements[i].name != seleccionado)
	          formu.elements[i].checked=false;
	        else
	          formu.elements[i].checked=true;
	      }
	            
	      
	      // Por defecto buscamos productos.
	      formu.elements['LLP_LISTAR'].value = 'PRO';
	      
	      if (seleccionado == 'BuscarProveedores') {
	       formu.elements['LLP_LISTAR'].value = 'EMP';
	      }
	} 
	

	// 
	function handleKeyPress(e) {
	  var keyASCII;
	  
	  if(navigator.appName.match('Microsoft'))
	    var keyASCII=event.keyCode;
	  else
            keyASCII = (e.which);
            
          if (keyASCII == 13) {
             EnviarBusqueda();
		}
	}
        
	// Asignamos la función handleKeyPress al evento 
	if(navigator.appName.match('Microsoft')==false)
	  document.captureEvents();
	document.onkeypress = handleKeyPress;

        //
        // Hacemos el cambio de la PLANTILLA ACTUAL.
        //
     	function CambioPlantilla(pl_id){
     	  parent.location.href='../NuevaMultioferta/CambioPlantilla.xsql?PL_ID='+pl_id;
     	} 
		

//
//	Guarda en el campo oculto CAMBIOS el contenido de los campos editables por el usuario
//	en formato (ID, UnidadBasica, UnidadesPorLote, Precio)
//
//	y envia el formulario
//
function Enviar(formOrigen, formDestino, Accion)
{

	var Msg='';
	
	if (Accion=='ANTERIOR')		//	Guarda resultados y retrocede a la pagina anterior
	{
	  formDestino.elements['PAGINA'].value=parseInt(formOrigen.elements['PAGINA'].value)-1;
	}
	else if (Accion=='SIGUIENTE')	//	Guarda resultados y avanza a la pagina siguiente
	{
	  formDestino.elements['PAGINA'].value=parseInt(formOrigen.elements['PAGINA'].value)+1;
	}
	else				//	Guarda resultados y actualiza la pagina actual
	{
	  formDestino.elements['PAGINA'].value=formOrigen.elements['PAGINA'].value;
	}
	
	var idClienteActual= document.forms['Busqueda'].elements['ID_CLIENTE_ACTUAL'].value;
	
	var avisarExpansion=0;
	var hayNulosExpandidos=0;
	
 	var adminMVM = document.forms['Busqueda'].elements['ID_CLIENTE_ACTUAL'].value;
	
	if (document.forms['Busqueda'].elements['ID_CLIENTE_ACTUAL'].value == 'si'){
  
	
	for(var j=0;j<formOrigen.length;j++){
		if(formOrigen.elements[j].name.substring(0,13)=='UNIDADBASICA_'){
			var IDProducto=obtenerId(formOrigen.elements[j].name);
			var Basica=formOrigen.elements['UNIDADBASICA_'+IDProducto].value;
			var PorCaja=formOrigen.elements['UNIDADESPORLOTE_'+IDProducto].value;
			var IDtipoIVA=formOrigen.elements['IDTIPOIVA_'+IDProducto].value;
			var Precio=formOrigen.elements['TARIFA_'+IDProducto].value;
			var Marca=formOrigen.elements['MARCA_'+IDProducto].value;
			var Borrar=formOrigen.elements['BORRAR_'+IDProducto].checked;
			var Copiar=formOrigen.elements['COPIAR_'+IDProducto].checked;	
			var Expandir=formOrigen.elements['EXPANDIR_'+IDProducto].checked;
            var Destacar=formOrigen.elements['DESTACAR_'+IDProducto].checked;
			
			if(formOrigen.elements['EXPANDIR_'+IDProducto].checked==true && idClienteActual==1){
				avisarExpansion=1;
				if(formOrigen.elements['TARIFA_'+IDProducto].value==''){
					hayNulosExpandidos=1;
				}
			}

	  	Msg=Msg+IDProducto+'|'+Marca+'|'+Basica+'|'+PorCaja+'|'+IDtipoIVA+'|'+Precio+'|'+Borrar+'|'+Copiar+'|'+Expandir+'|'+Destacar+'#';
	  }
	}
	
	}//fin if admin mvm
	
	if(avisarExpansion){
		if(hayNulosExpandidos){
			alert(msgExpandidosNulos);
		}
		else{
			if(confirm(msgExpansion)){
				formDestino.elements['CAMBIOS'].value=Msg;
				SubmitForm(formDestino);  
			}
		}
	}
	else{
		formDestino.elements['CAMBIOS'].value=Msg;
		SubmitForm(formDestino);  
	}
}	

function AceptarCambios(formCambio)
{
	var Msg='';
    for(var j=0;j<formCambio.length;j++){
    	var k = formCambio.elements[j].name;
    	if (k.match('IDPROD')){
			var IDProducto=formCambio.elements[j].value;
            var Aceptar=formCambio.elements['ACEPTAR_'+IDProducto].checked;
            var Cancelar=formCambio.elements['CANCELAR_'+IDProducto].checked;
            var Comentario= formCambio.elements['COMENTARIO_'+IDProducto].value;
            }
        
        if (Aceptar == true){
        	if (Msg.match(IDProducto)){ }//si ya esta el idprod no guardo de nuevo
            else{ 	Msg=Msg+IDProducto+'|A|'+Comentario+'#';}
        }
        else if(Cancelar == true){
        	if (Msg.match(IDProducto)){ }//si ya esta el idprod no guardo de nuevo
        	else { Msg=Msg+IDProducto+'|C|'+Comentario+'#'; }
        }

        
        }
    
    //alert(Msg);
    
    formCambio.elements['CAMBIOS'].value=Msg;
    //alert(formCambio.elements['US_ID'].value)
    //alert(formCambio.action);
	SubmitForm(formCambio);  
    
    
}
       function esEntero(obj){
         if (obj.value == ""){
	   alert('Por favor, introduzca una cantidad');
	   obj.focus();
         }	                   
         else{
	   if(obj.value < 0 || isNaN(obj.value)){
	     alert('Por favor, introduzca una cantidad correcta');
	     obj.focus();    
	   }
	 }
	 
	 if(!isNaN(obj.value)){
	   var comas=0, puntos=0;
	   for(var n=0;n<obj.value.length;n++){
	     if(obj.value.substring(n,n+1)=='.')
	       puntos++;
	     else
	       if(obj.value.substring(n,n+1)==',')
	         comas++;
	   }
	   if(puntos){
	     obj.value=quitaPuntos(obj.value);
	   }
	   if(comas)
	     obj.value=quitaComas(obj.value);
	 }
       }
       
       function esNulo(obj){
         if(obj.value == ""){
	   alert('Por favor, introduzca la unidad base');
	   obj.focus();                
	 }
       }


       function validarCampos(){
       /*
         for(var n=0;n<document.forms['Productos'].length;n++){
           if(document.forms['Productos'].elements[n].name.match('UNIDADBASICA_')){
             if(esNulo(document.forms['Productos'].elements[n].value)){
               return false;
             }    
           }
           else{
             if(document.forms['Productos'].elements[n].name.match('UNIDADESPORLOTE_')){
               if(esNulo(document.forms['Productos'].elements[n].value) || !esEntero(document.forms['Productos'].elements[n].value)){
                 return false;
               }
             }
             else{
               if(document.forms['Productos'].elements[n].name.match('TARIFA_')){
                 if(!esFloat(document.forms['Productos'].elements[n].value)){
                   return false;
                 }
               } 
             }     
           }
         } */
         return true; 
       }
       
       
       
       function recargarPagina(valor){
         if(document.forms['Busqueda'].elements['HAYPRODUCTOS'].value!='S'){
           document.forms['Busqueda'].elements['PRODUCTO'].value=valor;
           document.forms['Busqueda'].elements['HAYPRODUCTOS'].value='S';
           Enviar(document.forms[1],document.forms[0]);
         }
       }
       
       function EnviarBusqueda(){
		   alert('MI');
	  	if(LimitarCantidadPalabras(document.forms[0].elements['PRODUCTO'],5))
		
	    Busqueda(document.forms[0],'./PROBuscador.xsql');
	}
	
	function LimitarCantidadPalabras(obj, numPalabras){
	  var nombreCampo;
	  
	     if(obj.name=='PRODUCTO')
	       nombreCampo='Producto';
	       
	  var numEspacios=0;
	  obj.value=quitarEspacios(obj.value);
	  
	  for(var n=0;n<obj.value.length;n++){
	    if(obj.value.substring(n,n+1)==' '){
	      numEspacios++;
	    }
	    if(numEspacios>=numPalabras){
	      var cadTemp=obj.value.substring(0,n);
	      if(confirm(msg_DemasiadosCriteriosDefault+nombreCampo+msg_DemasiadosCriteriosExtra_1+cadTemp+msg_DemasiadosCriteriosExtra_2)){
	        obj.value=obj.value.substring(0,n);
	        return true;
	      }
	      else{
	        return false;
	      }
	    }
	  }
	  return true;
	}
	
	
	function MantenimientoProductos(laUrl){
	  document.location.href=laUrl;
	}
	
	var Historia= document.forms['Busqueda'].elements['HISTORY'].value;
	
	function obtenerHistoria(){
	  if(Historia=='')
	    return history.length;
	  else
	  return Historia;
	}
	
	function ExpandirNOExpandir(form,obj,origen){
	
	
		var id=obtenerId(obj.name);
		if(obj.checked==false){
			//form.elements['TARIFA_'+id].disabled=false;
			form.elements['TARIFA_'+id].className='normal';
	    form.elements['TARIFA_'+id].onfocus='';
			if(origen=='MVM'){
				form.elements['TARIFA_'+id].value=form.elements['BACKUPTARIFA_'+id].value;
			}
			else{
				form.elements['TARIFA_'+id].value=form.elements['TARIFAHISTORICA_'+id].value;
			}
		}
		else{
			//form.elements['TARIFA_'+id].disabled=true;
			form.elements['TARIFA_'+id].className='deshabilitado';
	   	form.elements['TARIFA_'+id].onfocus=eval('blurPrecio_'+id);
			if(origen=='MVM'){
				form.elements['TARIFA_'+id].value=form.elements['TARIFAPRIVADAMVM_'+id].value;
			}
			else{
				form.elements['TARIFA_'+id].value=form.elements['BACKUPTARIFA_'+id].value;
			}
		}
	}
	
	var siguienteCambioExpansion=1;
	
	function inicializarExpandirTodos(form){
		var estado=0;
		for(var n=0;n<form.length&&!estado;n++){
			if(form.elements[n].name.substring(0,9)=='EXPANDIR_'){
				if(form.elements[n].checked==false){
					estado=1;
				}
			}
		}
		siguienteCambioExpansion=estado;
	}
	
	function ExpandirNOExpandirTodos(form){
		for(var n=0;n<form.length;n++){
			if(form.elements[n].name.substring(0,9)=='EXPANDIR_'){
				if(siguienteCambioExpansion==1){
					form.elements[n].checked=false;
				}
				else{
					form.elements[n].checked=true;
				}
				form.elements[n].click();
			}
		}
		if(siguienteCambioExpansion==1){
			siguienteCambioExpansion=0;
		}
		else{
			siguienteCambioExpansion=1;
		}
	}
	
	//Si se pulsa "aceptar", fuerza "Cancelar" a NO y viceversa
    function RevisarOpciones(formu, idprod, boton)
	{
 		if ((boton=='ACEPTAR')&&(formu.elements['ACEPTAR_'+idprod].checked == true))
		{
 			formu.elements['CANCELAR_'+idprod].checked = false;
    	}
		
 		if ((boton=='CANCELAR')&&(formu.elements['CANCELAR_'+idprod].checked == true))
		{
 			formu.elements['ACEPTAR_'+idprod].checked = false;
		}
    }
    
	}
	
	// funciones para reasignar el onFocus, ha de estar definidas por input (ya que no admite parametros)
	/*
	]]></xsl:text>
		<xsl:for-each select="MantenimientoProductos/LISTAPRODUCTOS/PRODUCTO">
	
		function blurPrecio_<xsl:value-of select="IDPRODUCTO"/>(){
			document.forms['Productos'].elements['TARIFA_<xsl:value-of select="IDPRODUCTO"/>'].blur();
		}
	
	
		</xsl:for-each>
		
        

	<xsl:text disable-output-escaping="yes"><![CDATA[
    */
    
       function OrdenarPor(Orden)
			{
				var form=document.forms['Productos'];
				
				if (form.elements['ORDEN'].value==Orden)
				{
					if (form.elements['SENTIDO'].value=='ASC') form.elements['SENTIDO'].value='DESC';
					else  form.elements['SENTIDO'].value='ASC';
				}
				else
				{
					form.elements['ORDEN'].value=Orden; 
					form.elements['SENTIDO'].value='ASC';
				}	
				AplicarFiltro();
			}
            
           function AplicarFiltro(){
			
				var form=document.forms['Productos'];
				form.action='PROBuscador.xsql';
				 //alert('mi '+form.name+'mi '+ form);
				SubmitForm(form);
               
			}