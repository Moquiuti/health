// JavaScript Document
//js de MOF_13_RW

        
	//var estado = ]]></xsl:text><xsl:value-of select="Multioferta/MULTIOFERTA/MO_STATUS"/><xsl:text disable-output-escaping="yes"><![CDATA[;
	
	var AvisarFechaRecepcion=1;
	
	
	
	/*
	    nacho 26/2/2002
	    a帽adimos el boton cancelar pedido para el estado 10 que llama a la funcion cancelarPedido()
	*/
	
	
	
	function CancelarPedido(form,accion){
	  
	  AsignarAccion(form,accion);
	  SubmitForm(form,document);
	}
	
	
	function Actua(formu,accion){ 
	  comentariosToForm1(document.forms['form1'], document.forms['form1'],'NMU_COMENTARIOS');	
	  AsignarAccion(formu,accion);
         
            //quito los botones asi no doble click
            document.getElementById('ocultarBotones').style.display = 'none';

	  if(accion.match('RECEPCION_OK') || accion.match('RECEPCION_PARCIAL') ||accion.match('ABONO'))
	  {
	    // miramos que productos estan marcados como recibidos
	    comprobarRecibidos(formu);
	    
	    var fechaEntregatmp=obtenerSubCadena(formu.elements['FECHANO_ENTREGA'].value,2)+'/'+obtenerSubCadena(formu.elements['FECHANO_ENTREGA'].value,1)+'/'+obtenerSubCadena(formu.elements['FECHANO_ENTREGA'].value,3);
	    fechaEntregatmp=new Date(fechaEntregatmp);
	    
	    var fechaEntregaRealtmp=obtenerSubCadena(formu.elements['FECHA_ENTREGA_REAL'].value,2)+'/'+obtenerSubCadena(formu.elements['FECHA_ENTREGA_REAL'].value,1)+'/'+obtenerSubCadena(formu.elements['FECHA_ENTREGA_REAL'].value,3);
	    fechaEntregaRealtmp=new Date(fechaEntregaRealtmp);
	    
	    if(accion.match('ABONO'))
		{
			if(formu.elements['RECIBIDO'].value=='TODOSRECIBIDOS')
			{
				 
      		alert(document.forms['MensajeJS'].elements['SIN_CANTIDADES_PARA_ABONO'].value+'\n'+document.forms['MensajeJS'].elements['SIN_CANTIDADES_PARA_ABONO1'].value);
               //pongo de nuevo los botones 
      		document.getElementById('ocultarBotones').style.display = 'block';
			}
			else 
			{
				/*quitado 4-5-12 fecha recepcion automatica
                if((AvisarFechaRecepcion) && (fechaEntregaRealtmp>fechaEntregatmp) && formu.elements['RECIBIDO'].value!='NINGUNORECIBIDO')
				{
					if(confirm(document.forms['MensajeJS'].elements['ES_EL'].value + formu.elements['FECHA_ENTREGA_REAL'].value+document.forms['MensajeJS'].elements['FECHA_CORRECTA_RECEPCION'].value + '\n\n'+ document.forms['MensajeJS'].elements['CANCELAR_INFORMAR_FECHA'].value))
			  		{
						SubmitForm(formu, document);
			  		}
			  		else
			  		{
						formu.elements['COMBO_ENTREGA_REAL'].focus();
			  		}
				}
				else
				{
                */
			  	
                SubmitForm(formu, document);
			}
	    }
	    else
		{
			if (accion.match('RECEPCION_PARCIAL'))			//	ET	9oct07 En caso de recepcion parcial comprobamos que no esten todos recibidos
			{
				if(formu.elements['RECIBIDO'].value=='TODOSRECIBIDOS')
				{
                    alert(document.forms['MensajeJS'].elements['SIN_CANTIDADES_PARA_ABONO'].value+'\n'+document.forms['MensajeJS'].elements['SIN_CANTIDADES_PARA_ABONO1'].value);
               //pongo de nuevo los botones 
      			document.getElementById('ocultarBotones').style.display = 'block';
					return;
				}
			}
			
	    	/*quitado 4-5-12 fecha recepcion automatica
            if((AvisarFechaRecepcion) && (fechaEntregaRealtmp>fechaEntregatmp))
			{
	        	if(confirm('驴Es el '+formu.elements['FECHA_ENTREGA_REAL'].value+' (hoy) la fecha correcta de recepci贸n del pedido?\n\n * Cancelar: Podr谩 informar la fecha real de recepci贸n.'))
				{
		          SubmitForm(formu, document);
	        	}
	        	else
				{
	          		formu.elements['COMBO_ENTREGA_REAL'].focus();
	        	}
	      	}
	      	else
			{*/
	        
            SubmitForm(formu, document);
	      	
	    }
	  }
	  else{
	    if(accion.match('INCIDENCIA')){
	      AsignarAccion(formu,accion+prepararDatosActuales(formu));
	      SubmitForm(formu,document);
	    }
	    else{
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
                CadenaDatos+=form.elements[n].name+'|'+cadenaTemp+'路';
              }
              else{
                CadenaDatos+=form.elements[n].name+'|'+form.elements[n].value+'路';
              }
            }
          }
          for(var n=0;n<document.forms['form1'].length;n++){
            if(document.forms['form1'].elements[n].name.substring(0,12)=='CHKRECIBIDO_'){
              CadenaDatos+=document.forms['form1'].elements[n].name+'|'+document.forms['form1'].elements[n].value+'路';
            }
          }   
          return CadenaDatos;
        }
        
        function cargarDatosActuales(form, CadenaDatos){
          var arrParNombreValor=CadenaDatos.split('路');
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
        
        
        function comprobarRecibidos(form)
		{
          
          var cambios='';
          var estadoRecepcion;
          var cuantosProductosTotal=0;
          var cuantosProductosRecibidos=0;
          var cantidadEntregada=0;
          
        
          for(var n=0;n<form.length;n++)
		  {
            if(form.elements[n].name.substring(0,12)=='CHKRECIBIDO_')
			{
            	cuantosProductosTotal++;
            	var idProducto;
            	var recibido;


            	idProducto=obtenerId(form.elements[n].name);
            	 //idProducto=obtenerId(document.images[n].name);

            	if(form.elements['CHKRECIBIDO_'+idProducto].value=='checked')
				{
            	  recibido='S';
            	  cuantosProductosRecibidos++;
            	}
            	else
				{
            	  recibido='N';
            	}
            
            	cantidadEntregada=form.elements['CantidadEntregada_'+idProducto].value;
            
            
            
            	cambios=cambios+idProducto+'|'+recibido+'|'+cantidadEntregada+'#';

          	}
       	  }
        
          if(cuantosProductosRecibidos==cuantosProductosTotal)
		  {
          	estadoRecepcion='TODOSRECIBIDOS';
          }
          else
		  {
          	if(cuantosProductosRecibidos==0)
			{
            	estadoRecepcion='NINGUNORECIBIDO'; 
            }
            else
			{
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
          //alert('subtotal '+form.elements['MO_SUBTOTAL'].value);
          //alert('iva '+form.elements['MO_IMPORTEIVA'].value);
          //alert('importe final '+form.elements['IMPORTE_FINAL_PEDIDO'].value);
            form.elements['MO_SUBTOTAL'].value=anyadirCerosDecimales(formateaDivisa(Round(desformateaDivisa(form.elements['MO_SUBTOTAL'].value),2)),2);
            form.elements['MO_IMPORTEIVA'].value=anyadirCerosDecimales(formateaDivisa(Round(desformateaDivisa(form.elements['MO_IMPORTEIVA'].value),2)),2);
            form.elements['IMPORTE_FINAL_PEDIDO'].value=anyadirCerosDecimales(formateaDivisa(Round(desformateaDivisa(form.elements['IMPORTE_FINAL_PEDIDO'].value),2)),2);
            
            //si alguna cantidad no esta recibida entonces ense駉 boton recibido parcialmente
            for(var i=0;i<form.length;i++){
                if (form.elements[i].name.substring(0,12) == 'CHKRECIBIDO_' ){
                    //alert(form.elements[i].value);
                    if (form.elements[i].value == 'unchecked'){
                        jQuery("#botonRecibidoParc").show();
                        jQuery("#textRecibidoParc").hide();
                        
                        jQuery("#botonRecibido").hide();
                        jQuery("#textRecibido").show();
                    }
                 }
            }
            
          }//fin de inicializarImportes
          
        function UnidadesALotesRecibidas(unidades,unidadesporlote,cantidadTotal,objeto){
	  
	  var identificador=objeto.name.substr(18,objeto.name.length);
	  
          if(objeto.value == "" || objeto.value == 0){
            if(document.forms['form1'].elements['CHKRECIBIDO_'+identificador].checked==true){
	      objeto.value=0;
	      document.forms['form1'].elements['CHKRECIBIDO_'+identificador].checked=false;
	      return true;
	      //alert('Por favor, introduzca una cantidad');
	      //objeto.focus();
	      //return false;
	    }
	    else{
	      objeto.value=0;
	      document.forms['form1'].elements['CHKRECIBIDO_'+identificador].checked=false;
	      return true;
	    }
          }	                   
          else{
	    if((objeto.value < 0) || (!esEntero(objeto.value))){  //tienePuntuacion(objeto.value)
	      alert(document.forms['MensajeJS'].elements['INTRODUZCA_CANTIDAD_CORRECTA'].value);
	      objeto.focus();
	      return false;
	    }else{	
	      if(parseInt(unidades) > parseInt(cantidadTotal)){
	        alert(document.forms['MensajeJS'].elements['RECIBIDA_SUPERIOR_SOLICITADA'].value + '\n' + document.forms['MensajeJS'].elements['SOSTITUIRA_POR_SOLICITADA'].value + cantidadTotal + document.forms['MensajeJS'].elements['UNIDADES'].value);
	        objeto.value=cantidadTotal;
	        objeto.select();
	        return true;
	      } 
	      else{
	        if(document.forms['form1'].elements['CHKRECIBIDO_'+identificador].checked==true && parseInt(unidades) < parseInt(cantidadTotal)){
	          //if(confirm(document.forms['MensajeJS'].elements['RECIBIDA_INFERIOR_SOLICITADA'].value + '\n'+ document.forms['MensajeJS'].elements['ACEPTAR_CANTIDAD_PARCIAL'].value +'\n'+document.forms['MensajeJS'].elements['CANCELAR_MARCAR_RECIBIDO'].value )){
              
              //ACEPTAR_CANTIDAD_PARCIAL
	            var lotes;	        
	            if(unidades%unidadesporlote==0){
	              lotes=unidades/unidadesporlote;
	              var nuevasUnidades=unidadesporlote*lotes;	    
	              document.forms['form1'].elements['CantidadEntregada_'+identificador].value=nuevasUnidades;	          
                    }
                    else{
	              lotes=(Math.abs(unidades)-(Math.abs(unidades)%unidadesporlote))/unidadesporlote+1;
                  
	              alert(unidades + document.forms['MensajeJS'].elements['UNIDADES_NO_ENTERO_CAJAS'].value+'\n' + document.forms['MensajeJS'].elements['REDONDEADO_COINCIDA'].value + Math.abs(lotes)+document.forms['MensajeJS'].elements['CAJAS'].value+' ('+Math.abs(unidadesporlote*lotes)+ document.forms['MensajeJS'].elements['UNIDADES'].value + ')');	  
                          
	              var nuevasUnidades=unidadesporlote*lotes;	
	              document.forms['form1'].elements['CantidadEntregada_'+identificador].value=nuevasUnidades;	 
                    }
	          //}
	          //else{
	          //  document.forms['form1'].elements['CantidadEntregada_'+identificador].value=cantidadTotal;
	          //}
                  if(document.forms['form1'].elements['CantidadEntregada_'+identificador].value==cantidadTotal){
                    document.forms['form1'].elements['CHKRECIBIDO_'+identificador].checked=true;
                    return true;
                  }
                  else{
	            document.forms['form1'].elements['CHKRECIBIDO_'+identificador].checked=false;
	            return true;
	          }
	        }
	        else{	  	
	          var lotes;	        
	          if(unidades%unidadesporlote==0){
	            lotes=unidades/unidadesporlote;
	            var nuevasUnidades=unidadesporlote*lotes;	    
	             
	            document.forms['form1'].elements['CantidadEntregada_'+identificador].value=nuevasUnidades;	          
                  }
                  else{
	            lotes=(Math.abs(unidades)-(Math.abs(unidades)%unidadesporlote))/unidadesporlote+1;
                
	                               
                  alert(unidades + document.forms['MensajeJS'].elements['UNIDADES_NO_ENTERO_CAJAS'].value+' \n' + document.forms['MensajeJS'].elements['REDONDEADO_COINCIDA'].value + Math.abs(lotes)+ document.forms['MensajeJS'].elements['CAJAS'].value+' ('+Math.abs(unidadesporlote*lotes)+ document.forms['MensajeJS'].elements['UNIDADES'].value + ')');	   
                  
	            var nuevasUnidades=unidadesporlote*lotes;	
	            document.forms['form1'].elements['CantidadEntregada_'+identificador].value=nuevasUnidades;	 
                  }
                  if(document.forms['form1'].elements['CantidadEntregada_'+identificador].value==cantidadTotal){
                    document.forms['form1'].elements['CHKRECIBIDO_'+identificador].checked=true;
                    return true;
                  }
                  else{
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
	  
          if(objeto.value == "" || objeto.value == 0){
	      objeto.value=0;
	      document.forms['form1'].elements['CHKRECIBIDO_'+identificador].value='unchecked';
	      document.images['IMGRECIBIDO_'+identificador].src='http://www.newco.dev.br/images/norecibido.gif';
              //si cambia cantidad y es no recibido todos ense駉 boton de recibido parcial
              jQuery("#botonRecibidoParc").show();
              jQuery("#textRecibidoParc").hide();
              
              jQuery("#botonRecibido").hide();
              jQuery("#textRecibido").show();
                 
	      return true;
          }	                   
          else{
	    if((objeto.value < 0) || (!esEntero(objeto.value))){  //tienePuntuacion(objeto.value)
	      alert(document.forms['MensajeJS'].elements['INTRODUZCA_CANTIDAD_CORRECTA'].value);    
	      objeto.focus();
	      return false;
	    }else{	
	      if(parseInt(unidades) > parseInt(cantidadTotal)){
	        alert( document.forms['MensajeJS'].elements['RECIBIDA_SUPERIOR_SOLICITADA'].value +'\n'+ document.forms['MensajeJS'].elements['SOSTITUIRA_POR_SOLICITADA'].value + cantidadTotal+' ud(s).');
	        objeto.value=cantidadTotal;
	        objeto.select();
	        return true;
	      } 
	      else{
	        if(parseInt(unidades) <= parseInt(cantidadTotal)){
	          var lotes;	        
	          //if(unidades%unidadesporlote==0){
	          //  lotes=unidades/unidadesporlote;
	          //  var nuevasUnidades=unidadesporlote*lotes;	    
	          //  document.forms['form1'].elements['CantidadEntregada_'+identificador].value=nuevasUnidades;	          
                  //}
                  //else{
	          //   lotes=(Math.abs(unidades)-(Math.abs(unidades)%unidadesporlote))/unidadesporlote+1;
	           // alert(unidades + document.forms['MensajeJS'].elements['UNIDADES_NO_ENTERO_CAJAS'].value +' \n '+ document.forms['MensajeJS'].elements['REDONDEADO_COINCIDA'].value + Math.abs(lotes)+document.forms['MensajeJS'].elements['CAJAS'].value +' ('+Math.abs(unidadesporlote*lotes)+document.forms['MensajeJS'].elements['UNIDADES'].value+')');	          
	           // var nuevasUnidades=unidadesporlote*lotes;	
	          //  document.forms['form1'].elements['CantidadEntregada_'+identificador].value=nuevasUnidades;	 
                 // }
                         
	            lotes=(Math.abs(unidades)-(Math.abs(unidades)%unidadesporlote))/unidadesporlote+1;
	            //if(unidades%unidadesporlote!=0){
	            //  alert(unidades+document.forms['MensajeJS'].elements['UNIDADES_NO_ENTERO_CAJAS'].value);          
                   // }
	            document.forms['form1'].elements['CantidadEntregada_'+identificador].value=unidades;
                 
                  
                  if(document.forms['form1'].elements['CantidadEntregada_'+identificador].value==cantidadTotal){
                    document.forms['form1'].elements['CHKRECIBIDO_'+identificador].value='checked';
                    document.images['IMGRECIBIDO_'+identificador].src='http://www.newco.dev.br/images/recibido.gif';
                    //quito el boton de recibido parcial si cantidad recibida
                    jQuery("#botonRecibidoParc").hide();
                    jQuery("#textRecibidoParc").show();
                    //pongo el boton si cantidad recibida
                    jQuery("#botonRecibido").show();
                    jQuery("#textRecibido").hide();
                                
                    //for para ense馻r o no boton de recibido parcial
                    var form = document.forms['form1'];
                    for(var i=0;i<form.length;i++){
                        if (form.elements[i].name.substring(0,12) == 'CHKRECIBIDO_' ){
                            //alert(form.elements[i].value);
                            if (form.elements[i].value == 'unchecked'){
                                jQuery("#botonRecibidoParc").show();
                                jQuery("#textRecibidoParc").hide();
                                 
                                jQuery("#botonRecibido").hide();
                                jQuery("#textRecibido").show();
                            }
                         }
                    }
                    return true;
                  }
                  else{
	            document.forms['form1'].elements['CHKRECIBIDO_'+identificador].value='unchecked';
	            document.images['IMGRECIBIDO_'+identificador].src='http://www.newco.dev.br/images/norecibido.gif';
                    //ense駉 el boton si cantidad recibida
                    jQuery("#botonRecibidoParc").show();
                    jQuery("#textRecibidoParc").hide();
                    
                    jQuery("#botonRecibido").hide();
                    jQuery("#textRecibido").show();
                  
	            return true;
	          }
	        }
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
		
          AvisarFechaRecepcion=0;
          
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
    
    function todasRecibidas(objStatusTodas){
      for(var n=0;n<document.forms['form1'].length;n++){
        if(document.forms['form1'].elements[n].name.substring(0,14)=='IDLINEAPEDIDO_'){
          var idLinea=obtenerId(document.forms['form1'].elements[n].name);
          if(objStatusTodas.value==1){
            document.forms['form1'].elements['CantidadEntregada_'+idLinea].value=0;
            //document.forms['form1'].elements['CHKRECIBIDO_'+idLinea].checked=false;
            document.images['IMGRECIBIDO_'+idLinea].src='http://www.newco.dev.br/images/norecibido.gif';
            document.forms['form1'].elements['CHKRECIBIDO_'+idLinea].value='unchecked';
          }
          else{
            var CantidadTotalLinea=document.forms['form1'].elements['CANTIDADSINFORMATO_'+idLinea].value;
            document.forms['form1'].elements['CantidadEntregada_'+idLinea].value=CantidadTotalLinea;
            //document.forms['form1'].elements['CHKRECIBIDO_'+idLinea].checked=true;
            document.images['IMGRECIBIDO_'+idLinea].src='http://www.newco.dev.br/images/recibido.gif';
            document.forms['form1'].elements['CHKRECIBIDO_'+idLinea].value='checked';
          }
        }
      }
      if(objStatusTodas.value==1){
        objStatusTodas.value=0;
      }
      else{
        objStatusTodas.value=1;
      }
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