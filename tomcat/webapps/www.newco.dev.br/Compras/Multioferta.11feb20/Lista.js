

	//
	// Instalamos el nuevo controlador de eventos. Cuando se 
	//  pulsa enter obligamos al control a perder el foco.
	//       
         function handleKeyPress(e) {	
	  var keyASCII;	  
	  if(navigator.appName.match('Microsoft')){
	    var keyASCII=event.keyCode;
	    var eSrc=event.srcElement;
	    if (keyASCII == 13)
	      eSrc.blur();
	  }
	  else{
            keyASCII = (e.which);
          }  
        }
	
	if(navigator.appName.match('Microsoft')==false)
	  document.captureEvents();
	document.onkeypress = handleKeyPress;
	  
	// 
	//
	//
	// LLP_ULTIMAPAGINA = 0
	//
	function abrirVentana(pag) {
          window.open(pag,toolbar='no',menubar='no',status='no',scrollbars='yes',resizable='yes');
        }
        
         //
         // Abrimos la busqueda detallada
         //
         function Catalogo (dir) {
         	var lp_id = document.forms[0].elements['LP_ID'].value;
         	var llp_id = document.forms[0].elements['LLP_ID'].value;
		document.location.href= dir + '&LLP_ID='+llp_id+'&LP_ID='+lp_id+'&OP=EDICION';
		
         }
         
        //
        //
        //
	var producto = null;
        /*
        function MostrarPag(pag){
          if (is_nav){
            ample=parseInt(window.outerWidth*80/100)-50;
            alcada=parseInt(window.innerHeight-23)-50;
            alt=parseInt(window.parent.innerHeight+18)-parseInt(window.innerHeight)+25;
            esquerra = parseInt(window.outerWidth*18/100)+25;
            if (producto && producto.open){
              producto.close();            
            }
            producto=window.open(pag,'procesoVenta','toolbar=no,menubar=no,status=no,scrollbars=yes,resizable=yes,width='+ample+',height='+alcada+',screenX='+esquerra+',screenY='+alt);
          }else{
            ample = window.screen.availWidth-window.screenLeft-15-50;
            alcada = document.body.offsetHeight-27-50;
            esquerra = window.screenLeft+25;
            alt = window.screenTop+25;
            if (producto && producto.open && !producto.closed) producto.close();
	    producto=window.open(pag,'procesoVenta','toolbar=no,menubar=no,status=no,scrollbars=yes,resizable=yes,width='+ample+',height='+alcada+',top='+alt+',left='+esquerra);
          }
        }
        */
	

	
	//
	// Cuando el usuario cambia el combo se reordenan los productos.
	// Lo modificamos para que FILTRE los productos segun el criterio.
	//
	function ReordenarConsulta ( form ) {
	 var newfilter ='';
	 // Filtro de empresas.
	 
	 if (form.elements['CEmpresas']) {
	   var cemp = form.elements['CEmpresas'];
	   var filtro_emp = cemp.options[cemp.selectedIndex].value;
	   if (filtro_emp != '0') {
		newfilter += '(PROV|'+filtro_emp+')';		
	   }
	 }
	 // Filtro de Nomenclator
	 if (form.elements['CNomenclator']) {
	   var cnom = form.elements['CNomenclator'];
	   var filtro_nome = cnom.options[cnom.selectedIndex].value;
	   if (filtro_nome != '0') {
		newfilter += '(NOME|'+filtro_nome+')';		
	   }
	 }
	 
	 // Filtro de Marcas
	 if (form.elements['CMarcas']) {
	   var cmarca = form.elements['CMarcas'];
	   var filtro_marca = cmarca.options[cmarca.selectedIndex].value;
	   if (filtro_marca != '0') {
		newfilter += '(MARC|'+filtro_marca+')';		
	   }
	 }
	 
 	 // Mostrar solo productos seleccionados ??
 	 if (form.elements['CSeleccionados']) {
	   var csele = form.elements['CSeleccionados'];
	   var filtro_sele = csele.options[csele.selectedIndex].value;
	   if (filtro_sele != '0') {
		newfilter += '(SELE|X)';		
	   }
 	 }
 
 	   //alert('EMP:'+filtro_emp+' NOM:'+filtro_nome+' MAR:'+filtro_marca+ ' SEL:'+filtro_sele);
	   if (newfilter != '') {
		newfilter = 'FILTRO: '+newfilter;		
	   }
	   
	   form.elements['LLP_ORDERBY'].value = newfilter;
	   form.elements['ULTIMAPAGINA'].value = 0;
	   
	   top.status = 'Por favor, espere...';
	   
	   Navega(form,'CANTIDAD_UNI','0');	   
	}


	  //
	  //  
	  var ultimoCheckedName,ultimoCheckedStatus;
	  
	  //
	  //Esta funcion nos permite deseleccionar el input radio (por defecto no se deselecciona).
	  //Ademas actualizamos los inputs hidden asociados a la opcion del radio
	  //
	  function ActivaDesactiva(objeto,formu){
	    if (objeto.value==ultimoCheckedName){
	      if(ultimoCheckedStatus=='NoChecked'){
	            formu.elements['LLP_PRODUCTO_DETERMINADO'].value=objeto.value;
	            formu.elements['LLP_PRODUCTO_AUTOMATICO'].value="No";
	            ultimoCheckedName=objeto.value;
	            ultimoCheckedStatus='Checked';
	      }else{
	            objeto.checked=false;
	            formu.elements['LLP_PRODUCTO_DETERMINADO'].value="";
	            formu.elements['LLP_PRODUCTO_AUTOMATICO'].value="No";
	            ultimoCheckedName=objeto.value;
	            ultimoCheckedStatus='NoChecked';	                    
	      }
	    }	        
            ultimoCheckedName=objeto.value;	            
	  }
	
	 //
	 //	  
	  function Navega(formu,NombreCampo,pagina){
	    //Guardamos la ultima pagina en el campo oculto ULTIMAPAG.
            formu.elements['ULTIMAPAGINA'].value=pagina;
	    if(ValidaCampos(formu,NombreCampo)){	      
	      if (validaCheckyCantidadSin(formu,'PRO_PREDETERMINADO','CANTIDAD_UNI',IntrodeceNumLotes )){
	        // Actualizo campo hidden LLP_PRODUCTO_DETERMINADO con el valor seleccionado.
	        PredeterminaElChecked(formu);
	        SubmitForm(formu);
	      }
	    }
	  }

	 //
	 //
	  function InsertarProductos (formu,NombreCampo,accio,VariasLineas){
	      
	    formu.elements['LLP_VARIAS_LINEAS'].value = VariasLineas;
	    for(var n=0;n<formu.length;n++){
	      if(formu.elements[n].name.match('CANTIDAD_') && formu.elements[n].type=='text' && formu.elements[n].value!='')
	        formu.elements['HAY_PRODUCTOS'].value=1;
	    }
	    if(formu.elements['HAY_PRODUCTOS'].value!=''){
	      formu.action = accio;
	    }
	    formu.elements['xml-stylesheet'].value="";	   
	    PreseleccionaYSubmita(formu,NombreCampo,VariasLineas);
	  }

	  function AsignarReferencia(formu,NombreCampo,accio){               
	    if(ValidaCampos(formu,NombreCampo)){
	      do{
	      var contestacion1 = prompt(AsigneReferencia,'');
	        if (contestacion1) 
	          var contestacion2 = confirm(LaReferencia+' '+contestacion1+' '+EsCorrecta);
              }while (contestacion2==false)
              if (contestacion2) {
                formu.elements['REFERENCIACLIENTE'].value=contestacion1;
	        formu.action = accio;
	        formu.elements['xml-stylesheet'].value="";
	        SubmitForm(formu);     
              }
            }
          }
	   
	   //
	   //
	   // 	  	  
	  function PreseleccionaYSubmita(formu,NombreCampo,VariasLineas){
	    if(ValidaCampos(formu,NombreCampo)){	      
	      if (validaCheckyCantidadSin(formu,'PRO_PREDETERMINADO','CANTIDAD_UNI',IntrodeceNumLotes )){
	        // Actualizo campo hidden LLP_PRODUCTO_DETERMINADO con el valor seleccionado.
	        PredeterminaElChecked(formu);
	        //Hay ya un predeterminado.
	        if(formu.elements['LLP_PRODUCTO_DETERMINADO'].value!="" || VariasLineas=='SI') {
	        	
	        	/*
	        	  nacho 
	        	  14/3/2002
	        	  
	        	  para cada pagina se hace una preinsercion, con lo que no sabemos en la pagina actual si hay productos pendientes
	        	  de introducirse 
	        	  
	        	  en HAY_PRODUCTOS guardo 1 si en la pagina anterior o en la actual hay productos pendientes
	        	  
	        	*/
	          if(formu.elements['SELECCIONARTOTAL'].value!='' || formu.elements['HAY_PRODUCTOS'].value!=''){
  		    SubmitForm(formu);
  		  }
  		  else
  		    alert('Por Favor, Introduzca algún producto antes de pulsar el botón:\n\"Insertar Productos en la Plantilla Actual\".\n\nPara volver a la plantilla pulse el botón: \"Abrir Plantilla Actual\".');
	        }	        
	        //No encontramos predeterminado.
	        else{
	          //No se ha encontrado ningun producto
	          if(formu.elements['SELECCIONARTOTAL'].value==""){
	            SubmitForm(formu);	
	          }else{
		    PreseleccionAutomatica(formu);
		  }
	        }	        
	      }
	    }	  	
	  }
	  
	  function PredeterminaElChecked(formu){
	      // Actualizo campo hidden LLP_PRODUCTO_DETERMINADO con el valor seleccionado.    
	      for(i=0; i<formu.elements.length; i++){    
                if (formu.elements[i].type=="radio" && formu.elements[i].checked==true){  
	          formu.elements['LLP_PRODUCTO_DETERMINADO'].value=formu.elements[i].value;
	          formu.elements['LLP_PRODUCTO_AUTOMATICO'].value="No";
	          break;
	        }
	      }	  
	  }
	  	  
	  function PreseleccionAutomatica(formu){
	    var contestacion = confirm(SeleccionAutomatica);
            if (contestacion) {
              formu.elements['LLP_PRODUCTO_AUTOMATICO'].value="Si";
              SubmitForm(formu);
	    }       
 	  }

	// Reseta los valores de los numeros de lotes a pedir
	// Actualiza el valor predeterminado del comienzo	  
	function Resetea(formu){
          for (i=0;i<formu.elements.length;i++){    
            if (formu.elements[i].type=="text"){
              formu.elements[i].value="";         
            }
            if (formu.elements[i].type=="radio" && formu.elements[i].checked==true){
              formu.elements[i].checked=false;
              formu.elements['LLP_PRODUCTO_DETERMINADO'].value="";
              formu.elements['LLP_PRODUCTO_AUTOMATICO'].value="No";
            }
          }	  
	}
	
       function Selecciona(formu,producto_predeterminado){
          for (i=0;i<formu.elements.length;i++){         
            if (formu.elements[i].type=="radio" && formu.elements[i].value==producto_predeterminado){
              formu.elements[i].checked=true;
              ultimoCheckedName=formu.elements[i].value;
              ultimoCheckedStatus='Checked';      
            }
          }
        }
        
        //  Buscamos los elementos cuyo nombre empieza por NombreCampo
        //    Si la cantidad es <=0 o no numerica mostramos el error
        //    Si la cantidad es correcta agrupa en un array 
        //   SELECCIONARTOTAL=(num_unidades(0),identificador_unidades(0)),(num_unidades(1),identificador_unidades(1),...	  
	function ValidaCampos(formu,nombre){
          seleccion = new Array;
          var primeraVez = 0;	
	  for(i=0; i<formu.elements.length; i++){
	    if (formu.elements[i].name.substr(0,12)==nombre){
	      if (formu.elements[i].value != "" && formu.elements[i].value !=0){
	        if(formu.elements[i].value < 0 || isNaN(formu.elements[i].value)){
	          alert(UnidadesNoValidas+formu.elements[i].value);
	          formu.elements[i].focus();
	          return false;
	        }
	        else{
	          if(formu.elements[i].value!=0){
	            if (primeraVez==0){
	    	      seleccion='('+formu.elements[i].name.substr(nombre.length,formu.elements[i].name.length-nombre.length)+','+formu.elements[formu.elements[i].name.substr(0,nombre.length)+formu.elements[i].name.substr(nombre.length, formu.elements[i].name.length-nombre.length)].value+')';
	    	      primeraVez=1;
                    }
                    else if (primeraVez>0){
                      seleccion=seleccion+',('+formu.elements[i].name.substr(nombre.length, formu.elements[i].name.length-nombre.length)+','+formu.elements[formu.elements[i].name.substr(0,nombre.length)+formu.elements[i].name.substr(nombre.length, formu.elements[i].name.length-nombre.length)].value+')';                  
                    }                  
	          }
	        }
	      }
	    }
	  }
	  formu.elements['SELECCIONARTOTAL'].value=seleccion;
	  return true;
	}
	  
	  //Comprueba que el numero de unidades introducidas coincide con un multiplo del
	  //numero de lotes
	  //Se pide confirmacion para redondearlo a la alza si no es asi.
	  function UnidadesALotes(unidades,unidadesporlote,objeto){ 
	    var identificador=objeto.name.substr(12,objeto.name.length);
            if (objeto.value == ""){
	      objeto.form.elements['CANTIDAD_CAJAS'+identificador].value=""; 
	      //Si borramos unidades y estaba preseleccionado lo despreseleccionamos.
              for(var i=0; i<document.forms[0].elements.length; i++){ 
                if (document.forms[0].elements[i].name=='PRO_PREDETERMINADO' && document.forms[0].elements[i].value==identificador){
                  if(document.forms[0].elements[i].checked){	      		          	
                    document.forms[0].elements[i].checked=false;
                    document.forms[0].elements['LLP_PRODUCTO_DETERMINADO'].value="";
                    document.forms[0].elements['LLP_PRODUCTO_AUTOMATICO'].value="No";
                  }
                }
              }	                    
            }else{
	      if(objeto.value < 0 || isNaN(objeto.value)){
	        alert(UnidadesNoValidas);
	        objeto.focus();
	        return false;
	      }else{	    	  	
	        var lotes;	        
	        if (unidades%unidadesporlote==0){
	          lotes=unidades/unidadesporlote;
	          //Si ponemos 0 unidades y estaba preseleccionado lo despreseleccionamos.	          
	          if (unidades==0){
	            for(var i=0; i<document.forms[0].elements.length; i++){ 
	              if (document.forms[0].elements[i].name=='PRO_PREDETERMINADO' && document.forms[0].elements[i].value==identificador){
	                if(document.forms[0].elements[i].checked){	      		          	
	                  document.forms[0].elements[i].checked=false;
	                  document.forms[0].elements['LLP_PRODUCTO_DETERMINADO'].value="";
	                  document.forms[0].elements['LLP_PRODUCTO_AUTOMATICO'].value="No";
	                }
	              }
	            }	          
	          }
	        }else {
	          lotes=(unidades-(unidades%unidadesporlote))/unidadesporlote+1;
	          alert(unidades+' unidad(es) no corresponde a un numero entero de cajas. \nSe han redondeado para que coincida con '+lotes+' caja(s). ('+unidadesporlote*lotes+' unidad(es))');	          
	        }
	        var nuevasUnidades=unidadesporlote*lotes;	    
	        //objeto.form.elements['CANTIDAD'+identificador].value=lotes;	        
	        objeto.form.elements['CANTIDAD_UNI'+identificador].value=nuevasUnidades;
	        alineaCelda(objeto.form.elements['CANTIDAD_UNI'+identificador]);
	        objeto.form.elements['CANTIDAD_CAJAS'+identificador].value=nuevasUnidades/unidadesporlote;
                alineaCelda(objeto.form.elements['CANTIDAD_CAJAS'+identificador]);
                return true;
              }
            }
	  }
	  
	  // Convierte los lotes introducidos a unidades y estas son asignadas
	  // al campo CANTIDAD_UNI.
	  function LotesAUnidades(lotes,unidadesporlote,objeto){
	    identificador=objeto.name.substr(14,objeto.name.length);
            if (objeto.value == ""){
	      objeto.form.elements['CANTIDAD_UNI'+identificador].value="";
	      //Si borramos unidades y estaba preseleccionado lo despreseleccionamos.
              for(var i=0; i<document.forms[0].elements.length; i++){ 
                if (document.forms[0].elements[i].name=='PRO_PREDETERMINADO' && document.forms[0].elements[i].value==identificador){
                  if(document.forms[0].elements[i].checked){	      		          	
                    document.forms[0].elements[i].checked=false;
                    document.forms[0].elements['LLP_PRODUCTO_DETERMINADO'].value="";
                    document.forms[0].elements['LLP_PRODUCTO_AUTOMATICO'].value="No";
                  }
                }
              }
            }else{
	      if(objeto.value < 0 || isNaN(objeto.value)){
	        alert(UnidadesNoValidas);
	        objeto.focus();
	        return false;
	      }else{	      	    	  	
	        var unidades;	        
	        unidades=unidadesporlote*lotes;	    	        
	        objeto.form.elements['CANTIDAD_UNI'+identificador].value=unidades;
	        //Si ponemos 0 lotes y estaba preseleccionado lo despreseleccionamos.
	        if (unidades==0){
	          for(var i=0; i<document.forms[0].elements.length; i++){ 
	            if (document.forms[0].elements[i].name=='PRO_PREDETERMINADO' && document.forms[0].elements[i].value==identificador){
	              if(document.forms[0].elements[i].checked){	      		          	
	                document.forms[0].elements[i].checked=false;
	                document.forms[0].elements['LLP_PRODUCTO_DETERMINADO'].value="";
	                document.forms[0].elements['LLP_PRODUCTO_AUTOMATICO'].value="No";
	              }
	            }
	          }	          
	        }	        
              }
            }
	    alineaCelda(objeto.form.elements['CANTIDAD_UNI'+identificador]);
            alineaCelda(objeto.form.elements['CANTIDAD_CAJAS'+identificador]);
	  }	  	
	   
	   //Convierte las unidades a lotes para todas las lineas
	   function loadLotesAUnidades(){ 	   
	    for(var i=0; i<document.forms[0].elements.length; i++) {
	      if (document.forms[0].elements[i].name.substr(0,12)=='CANTIDAD_UNI' && document.forms[0].elements[i].value!=""){
	      	alineaCelda(document.forms[0].elements[i]);
	        identificador=document.forms[0].elements[i].name.substr(12,document.forms[0].elements[i].name.length);
	        unidadesporlote =document.forms[0].elements['UNIDADES_POR_LOTE'+identificador].value;
	        unidades=document.forms[0].elements[i].value;
	        UnidadesALotes(unidades,unidadesporlote,document.forms[0].elements[i]);
	      }
	    }
	  }  	      		  	  	  	