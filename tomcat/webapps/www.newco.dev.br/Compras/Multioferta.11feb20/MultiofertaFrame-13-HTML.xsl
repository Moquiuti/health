<?xml version="1.0" encoding="iso-8859-1" ?>
<!--
 | ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
 |Fichero: MultiofertaHTML.xsl
 |Descripcion: Proceso entero de Multioferta
 |Funcionamiento: Los estados son: 6,7,8,9,10,11,12,13,15,16,17.
 |
 |Modificaciones: 
 |Fecha: 20/06/01  Autor Modificacion: Olivier  
 |Fecha: 28/06/01  Autor Modificacion: Olivier -> Adaptar el fichero al proceso READ_ONLY
 |Fecha: 09/07/01  Autor Modificacion: Olivier -> Introduzco el estado 17: proceso terminado.
 |Fecha: 20/08/01  Autor Modificacion: Olivier -> Campo FORMA DE PAGO editable en la cabecera.
 |Fecha: 20/08/01  Autor Modificacion: Olivier -> Introduzco el estado 16: Pago recibido por el proveedor.
 |me he actualizado!!
 |
 |Situacion: __Normal__
 |
 |(c) 2001 MedicalVM
 |///////////////////////////////////////////////////////////////////////////////////////////////////////////////////   
 +-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href = "http://www.mvm.com/General/General.xsl" /> 
  <xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
  <xsl:param name="lang" select="@lang"/>
  <xsl:template match="/">

    <html>
      <head> 	
        <title>Oferta</title>
	<xsl:text disable-output-escaping="yes"><![CDATA[
	<link rel="stylesheet" href="http://www.mvm.com/General/Estilos.css" type="text/css">
	<link rel="stylesheet" href="http://www.mvm.com/General/EstilosImprimir.css" type="text/css" media="print">	
	<link rel="stylesheet" href="http://www.mvm.com/General/calendario/spiffyCal_v2_1.css" type="text/css">
        <script type="text/javascript" src="http://www.mvm.com/General/general.js"></script>
        <script type="text/javascript" src="http://www.mvm.com/General/divisas.js"></script>
        <script type="text/javascript" src="http://www.mvm.com/General/calendario/spiffyCal_v2_1.js"></script>
        <script type="text/javascript">
        <!--
        
	var estado = ]]></xsl:text><xsl:value-of select="Multioferta/MULTIOFERTA/MO_STATUS"/><xsl:text disable-output-escaping="yes"><![CDATA[;
	var divisaIni = ]]></xsl:text><xsl:value-of select="//@current"/><xsl:text disable-output-escaping="yes"><![CDATA[;
	
	var msg_ImporteVacio = ']]></xsl:text><xsl:value-of select="document('http://www.mvm.com/General/messages.xml')/messages/msg[@id='MO-0405' and @lang=$lang]" disable-output-escaping="yes"/><xsl:text disable-output-escaping="yes"><![CDATA[';
	var msgNoExplicacion="Rogamos comunique a su cliente el motivo del rechazo.";
	var msg_ImporteVacio = ']]></xsl:text><xsl:value-of select="document('http://www.mvm.com/General/messages.xml')/messages/msg[@id='MO-0405' and @lang=$lang]" disable-output-escaping="yes"/><xsl:text disable-output-escaping="yes"><![CDATA[';
        var msgGeneraIncidencia="El rechazo de un pedido en este estado generará una incidencia en su contra. ¿Desea continuar?";
	var msgFaltaComentario = ']]></xsl:text><xsl:value-of select="document('http://www.mvm.com/General/messages.xml')/messages/msg[@id='MO-0400' and @lang=$lang]" disable-output-escaping="yes"/><xsl:text disable-output-escaping="yes"><![CDATA[';
	var msgSinCantidadesParaAbono='Todos los productos están marcados como recibidos.\nPor favor, indique las cantidades reales recibidas de cada producto, antes de crear el abono.\n\nGracias.';
	var msgSinCantidadesParaParcial='Todos los productos están marcados como recibidos.\nPor favor, indique las cantidades reales recibidas de cada producto para poder confirmar el pedido parcial.\n\nGracias.';
	var msgFaltaAlbaranObligatorio='Es necesario informar el código de albarán del pedido recibido';
	
	var AvisarFechaRecepcion=1;
	
	
	
	/*
	    nacho 26/2/2002
	    añadimos el boton cancelar pedido para el estado 10 que llama a la funcion cancelarPedido()
	*/
	
	
	
	function CancelarPedido(form,accion){
	  
	  AsignarAccion(form,accion);
	  //DeshabilitarBotones(document);
	  SubmitForm(form,document);
	}
	
	function MensajeAyudaComentarioCliente () {
	 alert("Por favor, introduzca un comentario para el proveedor.\n\n * Preparar pedido: Para dar por finalizado el proceso de negociación. \n * Responder: Para continuar con la negociación.  \n * Terminar petición de oferta: Para dar por terminada la oferta. \n * Pendiente: Para dejar esta oferta pendiente.\n");
	}
	
	function MensajeAyudaComentarioClienteGen () {
	 alert("Por favor, introduzca un comentario para el proveedor.");
	}
	
	function MensajeAyudaComentarioProveedor () {
	 alert("Por favor, introduzca un comentario para el cliente.\n\n * Enviar: Para continuar con la negociación.  \n * Terminar petición de oferta: Para dar por terminada la oferta. \n * Pendiente: Para dejar esta oferta pendiente.\n");
	}
	function MensajeAyudaComentarioProveedorGen () {
	 alert("Por favor, introduzca un comentario para el cliente.");
	}
        
        

       
         var msgError='', msgErrorStd=' \n\nPor favor, corrija el error antes de enviar el formulario.';


	
	
	
	function Actua(formu,accion)
	{
		var msgError='';
		
	  comentariosToForm1(document.forms['comentarios'], document.forms['form1'],'NMU_COMENTARIOS');	
	  AsignarAccion(formu,accion);

	//	22mar09	Guardamos los parametros, aunque solo se utliza el de ALBARAN_SALIDA
		document.forms['form1'].elements['OTROSPARAMETROS'].value='|||'+document.forms['comentarios'].elements['ALBARAN_SALIDA'].value;



	  if(accion.match('RECEPCION_OK') || accion.match('RECEPCION_PARCIAL') ||accion.match('ABONO'))
	  {
	    // miramos que productos estan marcados como recibidos
	    comprobarRecibidos(formu);
	    
	    var fechaEntregatmp=obtenerSubCadena(formu.elements['FECHANO_ENTREGA'].value,2)+'/'+obtenerSubCadena(formu.elements['FECHANO_ENTREGA'].value,1)+'/'+obtenerSubCadena(formu.elements['FECHANO_ENTREGA'].value,3);
	    fechaEntregatmp=new Date(fechaEntregatmp);
	    
	    var fechaEntregaRealtmp=obtenerSubCadena(formu.elements['FECHA_ENTREGA_REAL'].value,2)+'/'+obtenerSubCadena(formu.elements['FECHA_ENTREGA_REAL'].value,1)+'/'+obtenerSubCadena(formu.elements['FECHA_ENTREGA_REAL'].value,3);
	    fechaEntregaRealtmp=new Date(fechaEntregaRealtmp);
	    

		if ((document.forms['comentarios'].elements['ALBARAN_OBLIGATORIO'].value=='S') &&(document.forms['comentarios'].elements['ALBARAN_SALIDA'].value==''))
		{
			msgError=msgError+msgFaltaAlbaranObligatorio+'\n\r';
		}

	    if(accion.match('ABONO'))
		{
			if(formu.elements['RECIBIDO'].value=='TODOSRECIBIDOS')
			{
				msgError=msgError+msgSinCantidadesParaAbono+'\n\r';
			}
			else
			{
				if((AvisarFechaRecepcion) && (fechaEntregaRealtmp>fechaEntregatmp) && formu.elements['RECIBIDO'].value!='NINGUNORECIBIDO')
				{
					if(confirm('¿Es el '+formu.elements['FECHA_ENTREGA_REAL'].value+' (hoy) la fecha correcta de recepción del pedido?\n\n * Cancelar: Podrá informar la fecha real de recepción.'))
			  		{
						//	está ok!
			  		}
			  		else
			  		{
						msgError=msgError+'Por favor, corrija la fecha de entrega real\n\r';
						formu.elements['COMBO_ENTREGA_REAL'].focus();
			  		}
				}
			}
			
			if (msgError=='')
			{
				SubmitForm(formu, document);
			}
			else
			{
				alert(msgError);
			}
	    }
	    else
		{
			if (accion.match('RECEPCION_PARCIAL'))			//	ET	9oct07 En caso de recepcion parcial co probamos que no esten todos recibidos
			{
				if(formu.elements['RECIBIDO'].value=='TODOSRECIBIDOS')
				{
					msgError=msgError+msgSinCantidadesParaParcial+'\n\r';
				}
			}

			
	    	if((AvisarFechaRecepcion) && (fechaEntregaRealtmp>fechaEntregatmp))
			{
	        	if(confirm('¿Es el '+formu.elements['FECHA_ENTREGA_REAL'].value+' (hoy) la fecha correcta de recepción del pedido?\n\n * Cancelar: Podrá informar la fecha real de recepción.'))
				{
						//	está ok!
	        	}
	        	else
				{
					msgError=msgError+'Por favor, corrija la fecha de entrega real\n\r';
	          		formu.elements['COMBO_ENTREGA_REAL'].focus();
	        	}
	      	}
	      	else
			{
	        	//SubmitForm(formu, document);
	      	}
			
			if (msgError=='')
			{
				SubmitForm(formu, document);
			}
			else
			{
				alert(msgError);
			}
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
                CadenaDatos+=form.elements[n].name+'|'+cadenaTemp+'·';
              }
              else{
                CadenaDatos+=form.elements[n].name+'|'+form.elements[n].value+'·';
              }
            }
          }
          for(var n=0;n<document.forms['form1'].length;n++){
            if(document.forms['form1'].elements[n].name.substring(0,12)=='CHKRECIBIDO_'){
              CadenaDatos+=document.forms['form1'].elements[n].name+'|'+document.forms['form1'].elements[n].value+'·';
            }
          }   
          return CadenaDatos;
        }
        
        function cargarDatosActuales(form, CadenaDatos){
        
          var arrParNombreValor=CadenaDatos.split('·');
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
              document.forms['comentarios'].elements[arrElemento[0]].value=cadenaTmp;
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
                    document.images['IMGRECIBIDO_'+elId].src='http://www.mvm.com/images/recibido.gif';
                  }
                  else{
                    document.images['IMGRECIBIDO_'+elId].src='http://www.mvm.com/images/norecibido.gif';
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
            form.elements['MO_SUBTOTAL'].value=anyadirCerosDecimales(formateaDivisa(Round(desformateaDivisa(form.elements['MO_SUBTOTAL'].value),2)),2);
            form.elements['MO_COSTELOGISTICA'].value=anyadirCerosDecimales(formateaDivisa(Round(desformateaDivisa(form.elements['MO_COSTELOGISTICA'].value),2)),2);
            form.elements['MO_IMPORTEIVA'].value=anyadirCerosDecimales(formateaDivisa(Round(desformateaDivisa(form.elements['MO_IMPORTEIVA'].value),2)),2);
            form.elements['IMPORTE_FINAL_PEDIDO'].value=anyadirCerosDecimales(formateaDivisa(Round(desformateaDivisa(form.elements['IMPORTE_FINAL_PEDIDO'].value),2)),2);
          }
          
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
	      alert('Por favor, introduzca una cantidad correcta');
	      objeto.focus();
	      return false;
	    }else{	
	      if(parseInt(unidades) > parseInt(cantidadTotal)){
	        alert('Ha introducido una cantidad de unidades recibidas superior a la solicitada.\nSe sustituirá por la cantidad solicitada: '+cantidadTotal+' ud(s).');
	        objeto.value=cantidadTotal;
	        objeto.select();
	        return true;
	      } 
	      else{
	        if(document.forms['form1'].elements['CHKRECIBIDO_'+identificador].checked==true && parseInt(unidades) < parseInt(cantidadTotal)){
	          //if(confirm('Ha introducido una unidad recibida inferior a la total solicitada. ¿Desea mantener la cantidad introducida?\n  *Aceptar: Cantidad recibida parcial.\n  *Cancelar: Marcar el producto como recibido totalmente.')){
	            var lotes;	        
	            if(unidades%unidadesporlote==0){
	              lotes=unidades/unidadesporlote;
	              var nuevasUnidades=unidadesporlote*lotes;	    
	              document.forms['form1'].elements['CantidadEntregada_'+identificador].value=nuevasUnidades;	          
                    }
                    else{
	              lotes=(Math.abs(unidades)-(Math.abs(unidades)%unidadesporlote))/unidadesporlote+1;
	              alert(unidades+' unidad(es) no corresponde a un numero entero de cajas. \nSe han redondeado para que coincida con '+Math.abs(lotes)+' caja(s). ('+Math.abs(unidadesporlote*lotes)+' unidad(es))');	          
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
	            alert(unidades+' unidad(es) no corresponde a un numero entero de cajas. \nSe han redondeado para que coincida con '+Math.abs(lotes)+' caja(s). ('+Math.abs(unidadesporlote*lotes)+' unidad(es))');	          
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
	      document.images['IMGRECIBIDO_'+identificador].src='http://www.mvm.com/images/norecibido.gif';
	      return true;
          }	                   
          else{
	    if((objeto.value < 0) || (!esEntero(objeto.value))){  //tienePuntuacion(objeto.value)
	      alert('Por favor, introduzca una cantidad correcta');
	      objeto.focus();
	      return false;
	    }else{	
	      if(parseInt(unidades) > parseInt(cantidadTotal)){
	        alert('Ha introducido una cantidad de unidades recibidas superior a la solicitada.\nSe sustituirá por la cantidad solicitada: '+cantidadTotal+' ud(s).');
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
	           // alert(unidades+' unidad(es) no corresponde a un numero entero de cajas. \nSe han redondeado para que coincida con '+Math.abs(lotes)+' caja(s). ('+Math.abs(unidadesporlote*lotes)+' unidad(es))');	          
	           // var nuevasUnidades=unidadesporlote*lotes;	
	          //  document.forms['form1'].elements['CantidadEntregada_'+identificador].value=nuevasUnidades;	 
                 // }
                         
	            lotes=(Math.abs(unidades)-(Math.abs(unidades)%unidadesporlote))/unidadesporlote+1;
	            //if(unidades%unidadesporlote!=0){
	            //  alert(unidades+' unidad(es) no corresponde a un numero entero de cajas.')          
                   // }
	            document.forms['form1'].elements['CantidadEntregada_'+identificador].value=unidades;
                 
                  
                  if(document.forms['form1'].elements['CantidadEntregada_'+identificador].value==cantidadTotal){
                    document.forms['form1'].elements['CHKRECIBIDO_'+identificador].value='checked';
                    document.images['IMGRECIBIDO_'+identificador].src='http://www.mvm.com/images/recibido.gif';
                    return true;
                  }
                  else{
	            document.forms['form1'].elements['CHKRECIBIDO_'+identificador].value='unchecked';
	            document.images['IMGRECIBIDO_'+identificador].src='http://www.mvm.com/images/norecibido.gif';
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
            document.images['IMGRECIBIDO_'+idLinea].src='http://www.mvm.com/images/norecibido.gif';
            document.forms['form1'].elements['CHKRECIBIDO_'+idLinea].value='unchecked';
          }
          else{
            var CantidadTotalLinea=document.forms['form1'].elements['CANTIDADSINFORMATO_'+idLinea].value;
            document.forms['form1'].elements['CantidadEntregada_'+idLinea].value=CantidadTotalLinea;
            //document.forms['form1'].elements['CHKRECIBIDO_'+idLinea].checked=true;
            document.images['IMGRECIBIDO_'+idLinea].src='http://www.mvm.com/images/recibido.gif';
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
      MostrarPagPersonalizada('http://www.mvm.com/Compras/NuevaMultioferta/UltimosComentarios.xsql?NOMBRE_OBJETO='+nombreObjeto+'&NOMBRE_FORM='+nombreForm+'&ACCION='+accion+'&TIPO='+tipoComentario+'&COMENTARIO='+document.forms[nombreForm].elements[nombreObjeto].value.replace(/\n/g,'\\\\n'),'comentarios',45,50,-80,-55);
    }
    
    function copiarComentarios(nombreForm,nombreObjeto,texto){
      if(quitarEspacios(document.forms[nombreForm].elements[nombreObjeto].value)!=''){
        document.forms[nombreForm].elements[nombreObjeto].value+='\n\n';
      }
      document.forms[nombreForm].elements[nombreObjeto].value+=texto;
      comentariosToForm1(document.forms['comentarios'], document.forms['form1'],'NMU_COMENTARIOS');
    } 
        
          

        
	//-->        
        </script>
        ]]></xsl:text> 
               
      </head> 
      <body bgcolor="#FFFFFF"> 
            
	
	
	
        <xsl:choose>
           <xsl:when test="Multioferta/xsql-error">
             <xsl:apply-templates select="//xsql-error"/>        
           </xsl:when>
           <xsl:when test="/Multioferta/SESION_CADUCADA">
             <xsl:apply-templates select="/Multioferta/SESION_CADUCADA"/>
           </xsl:when>
           <xsl:when test="Multioferta/Status">
             <xsl:apply-templates select="//Status"/>        
           </xsl:when>           
        </xsl:choose>   
        
        <xsl:attribute name="onLoad">
          <xsl:choose>
            <xsl:when test="Multioferta/DATOSACTUALES=''">
              inicializarImportes(document.forms['form1']);  
            </xsl:when>
            <xsl:otherwise>
              inicializarImportes(document.forms['form1']);cargarDatosActuales(document.forms['form1'],'<xsl:value-of select="Multioferta/DATOSACTUALES"/>');  
            </xsl:otherwise>           
         </xsl:choose>
       </xsl:attribute>
       <div id="spiffycalendar" class="text"></div>
       <script type="text/javascript">
         var calFechaEntregaReal = new ctlSpiffyCalendarBox("calFechaEntregaReal", "form1", "FECHA_ENTREGA_REAL","btnDateFechaEntregaReal",calculaFechaCalendarios('0'),scBTNMODE_CLASSIC,'ONCHANGE|actualizarPlazo(document.forms[\'form1\'],\'ENTREGA_REAL\',new Date());AvisarFechaRecepcion=0;#CHANGEDAY|actualizarPlazo(document.forms[\'form1\'],\'ENTREGA_REAL\',new Date());AvisarFechaRecepcion=0;#ONBLUR|AvisarFechaRecepcion=0;#SHOW|AvisarFechaRecepcion=0;');
       </script>
	<xsl:apply-templates select="Multioferta/MULTIOFERTA"/>
      </body>
    </html>
  </xsl:template>

  <xsl:template match="MULTIOFERTA">

  
  <!-- **************************************************************************************************************
   |
   |  						TITULO DE LA PANTALLA.
   |
   + ************************************************************************************************************** -->
   

    <!-- tabla cabecera -->
    <table width="100%" align="center" border="0" cellpadding="3" cellspacing="1" class="muyoscuro">
	<tr class="oscuro"><td colspan="6" align="center" class="oscuro">	
	<xsl:value-of select="document('http://www.mvm.com/General/messages.xml')/messages/msg[@id='MO-0105' and @lang=$lang]" disable-output-escaping="yes"/> 
    </td></tr>
     
    <!-- **************************************************************************************************************
   |
   |  					CREACION DEL FORM CON CAMPOS HIDDEN
   |				Para estados 6,7,8,9,12: FORM=FORM1, sino FORM=COMENTARIOS
   |			
   + **************************************************************************************************************   -->
          <form method="post" name="form1">       
            <xsl:apply-templates select="MO_STATUS"/>
            <xsl:apply-templates select="MO_ID"/>
            <xsl:apply-templates select="/Multioferta/ROL"/>
            <xsl:apply-templates select="/Multioferta/TIPO"/>
            <input type="hidden" name="STRING_CANTIDADES"/>
            <input type="hidden" name="STRING_PRECIOS"/>
            <input type="hidden" name="NMU_COMENTARIOS"/>
            <input type="hidden" name="RECIBIDO"/>
            <input type="hidden" name="RECIBIDO_GLOBAL" value="1"/>
	  		<input type="hidden" name="OTROSPARAMETROS" value="" />	<!--	ET 22mar10	Campos de control	-->
            
      
  <!-- **************************************************************************************************************
   |
   |  						CABECERA DE LA MULTIOFERTA
   |
   |		Nota: Solo mostramos el numero de pedido cuando existe y estamos en pantallas del cliente.
   + ************************************************************************************************************** -->  
        <tr class="blanco"> 
    <td colspan="6" class="blanco"> 
      <table width="100%" border="0" cellpadding="3" cellspacing="1">
        <tr> 
          <td align="center" width="50%"> 
            <table width="95%" border="0" class="muyoscuro" cellpadding="3" cellspacing="1">
              <tr class="oscuro">
                <td valign="top" colspan="2">
                <table width="100%" border="0" cellpadding="0" cellspacing="0" height="100%">
                  <tr> 
                    <td colspan="2" align="left">
                      
                      <xsl:if test="DATOSCLIENTE/EMP_NOMBRE!=CENTRO/CEN_NOMBRE">
                      Centro: <b><xsl:value-of select="CENTRO/CEN_NOMBRE"/></b>
                      <br/>
                      </xsl:if>
                      Empresa: <b><xsl:value-of select="DATOSCLIENTE/EMP_NOMBRE"/></b>
                      
                    </td>
                    <td colspan="2" align="right">
                      Nif:
                      <xsl:choose>
                        <xsl:when test="DATOSCLIENTE/EMP_NIF!=CENTRO/CEN_NIF and CENTRO/CEN_NIF!=''">
                          <b><xsl:value-of select="CENTRO/CEN_NIF"/></b>
                          <xsl:if test="DATOSCLIENTE/EMP_NOMBRE!=CENTRO/CEN_NOMBRE">
                            <br/>
                            <br/>
                          </xsl:if>
                        </xsl:when>
                        <xsl:otherwise> 
                          <b><xsl:value-of select="DATOSCLIENTE/EMP_NIF"/></b>
                          <xsl:if test="DATOSCLIENTE/EMP_NOMBRE!=CENTRO/CEN_NOMBRE">
                            <br/>
                            <br/>
                          </xsl:if>
                        </xsl:otherwise>
                      </xsl:choose>
                    </td>
                  </tr>
                </table>
                </td>
              </tr>
              <tr class="blanco"> 
                <td class="claro" colspan="2">
                  <!--<b><xsl:value-of select="ENTREGA/MO_LUGARENTREGA"/></b>&nbsp;-->Dirección:
                </td>
              </tr>
              <tr class="blanco"> 
                <td colspan="2">
                  <table align="left" width="100%">
                    <tr>
                      <td width="*">
                        &nbsp;&nbsp;
                      </td>
                      <td width="50%" valign="top">
                      	<xsl:call-template name="lugarEntregaConsumo">
                              <xsl:with-param name="path" select="."/>
                            </xsl:call-template>
                      </td>
                      <td width="*">
                        <!--	ET	12nov08	Mostramos siempre los datos del lugar de entrega
						<xsl:choose>
                          <xsl:when test="DATOSCLIENTE/EMP_NOMBRE!=CENTRO/CEN_NOMBRE">-->
                            <xsl:call-template name="direccionCentro">
                              <xsl:with-param name="path" select="ENTREGA"/>
                            </xsl:call-template>
                          <!--</xsl:when>
                          <xsl:otherwise>
                            <xsl:call-template name="direccion">
                              <xsl:with-param name="path" select="DATOSCLIENTE"/>
                            </xsl:call-template>
                          </xsl:otherwise>
                        </xsl:choose>-->
                      </td>
                    </tr>
                  </table>
                </td>
              </tr>
			  <!--
              <tr class="blanco"> 
                <td align="center" class="claro">
                  Comprador:
                </td>
                <td align="center" class="blanco">
                  <xsl:value-of select="COMPRADOR"/>
                </td>
              </tr>
			  -->
            </table>
          </td>
          <td align="center"> 
            <table width="95%" border="0" class="muyoscuro" cellpadding="3" cellspacing="1">
              <tr class="oscuro">
                <td colspan="2">
                <table width="100%" cellpadding="0" cellspacing="0" height="100%">
                  <tr> 
                    <td align="left">
                     Proveedor: <b><xsl:value-of select="DATOSPROVEEDOR/EMP_NOMBRE"/></b>
                     <xsl:if test="DATOSCLIENTE/EMP_NOMBRE!=CENTRO/CEN_NOMBRE">
                      <br/>
                      <br/>
                      </xsl:if>
                    </td>
                    <td align="right">
                      Nif: <b><xsl:value-of select="DATOSPROVEEDOR/EMP_NIF"/></b>
                      <xsl:if test="DATOSCLIENTE/EMP_NOMBRE!=CENTRO/CEN_NOMBRE">
                      <br/>
                      <br/>
                      </xsl:if>
                    </td>
                  </tr>
                </table>
                </td>
              </tr>
              <tr class="blanco"> 
                <td class="claro" colspan="2">
                  Dirección:
                </td>
              </tr>
              <tr class="blanco"> 
                <td colspan="2">
                  <table align="left">
                    <tr>
                      <td>
                        &nbsp;&nbsp;
                      </td>
                      <td>
                        <xsl:call-template name="direccion">
                          <xsl:with-param name="path" select="DATOSPROVEEDOR"/>
                        </xsl:call-template>
                      </td>
                    </tr>
                  </table>
                </td>
              </tr>
              <tr class="blanco"> 
                <td align="center" class="claro">
                  Comercial:
                </td>
                <td align="center" class="blanco">
                  <xsl:value-of select="VENDEDOR"/>
                </td>
              </tr>
            </table>
          </td>
        </tr>
      </table>
      <br/>
    </td>
  </tr>
  <tr class="oscuro"> 
      <td colspan="6" class="oscuro">
        <table width="100%">
        <tr>
          <td width="84%">
            Datos del Pedido
          </td>
          <!--
          <td width="11%">
            <xsl:value-of select="document('http://www.mvm.com/General/messages.xml')/messages/msg[@id='MO-0790' and @lang=$lang]" disable-output-escaping="yes"/>:
          </td>
          <td>
            <xsl:choose>
              <xsl:when test="LP_URGENCIA='S'">
                <font color="RED" size="2">
                 <b><xsl:value-of select="document('http://www.mvm.com/General/messages.xml')/messages/msg[@id='MO-0780' and @lang=$lang]" disable-output-escaping="yes"/></b>
                </font>
             </xsl:when>
             <xsl:otherwise>
              <font color="NAVY" size="2">
                <b><xsl:value-of select="document('http://www.mvm.com/General/messages.xml')/messages/msg[@id='MO-0770' and @lang=$lang]" disable-output-escaping="yes"/></b>
              </font>
            </xsl:otherwise>
          </xsl:choose>
        </td>
        -->
      </tr>
    </table>
      </td>
    </tr> 
    <tr class="blanco"> 
      <td class="claro" width="20%">
        Número de pedido:
      </td>
      <td class="blanco" width="25%">
        
        <table width="100%">
          <tr>
            <td align="left">
            <!--
              <font color="NAVY" size="2">
              	<b><xsl:value-of select="PED_NUMERO"/></b>
              </font>
             -->
             <input type="text" name="NUMERO_OFERT_PED" size="30" maxlength="100" value="{PED_NUMERO}"/>

            </td>
            <td align="right">
              <xsl:if test="MO_STATUS&gt;10">
                <xsl:choose>
                  <xsl:when test="PED_IDPADRE!=''">
                    <xsl:call-template name="botonPersonalizado">
                      <xsl:with-param name="funcion">MostrarPag('http://www.mvm.com/Compras/Multioferta/MultiofertaFrame.xsql?MO_ID=<xsl:value-of select="PED_IDPADRE"/>&amp;SES_ID=<xsl:value-of select="//SES_ID"/>&amp;READ_ONLY=S&amp;xml-stylesheet=MultiofertaFrame-<xsl:value-of select="PED_IDPADRE_ESTADO"/>-RO-HTML.xsl','MultiofertaAlt');</xsl:with-param>
                      <xsl:with-param name="label">Ver Pedido</xsl:with-param>
                      <xsl:with-param name="ancho">120px</xsl:with-param>
                    </xsl:call-template>
                  </xsl:when>
                 <xsl:when test="PED_IDHIJO!=''">
                    <xsl:call-template name="botonPersonalizado">
                      <xsl:with-param name="funcion">MostrarPag('http://www.mvm.com/Compras/Multioferta/MultiofertaFrame.xsql?MO_ID=<xsl:value-of select="PED_IDHIJO"/>&amp;SES_ID=<xsl:value-of select="//SES_ID"/>&amp;READ_ONLY=S&amp;xml-stylesheet=MultiofertaFrame-<xsl:value-of select="PED_IDHIJO_ESTADO"/>-RO-HTML.xsl','MultiofertaAlt');</xsl:with-param>
                      <xsl:with-param name="label">Ver Abono</xsl:with-param>
                      <xsl:with-param name="ancho">120px</xsl:with-param>
                    </xsl:call-template>
                  </xsl:when>
                </xsl:choose>
              </xsl:if>
            </td>
          </tr>
        </table>
        
      </td>
      <td class="claro" width="20%">
        Fecha del pedido:
      </td>
      <td class="blanco">
        <table width="100%" align="center">
          <tr>
            <td width="10%">
              <!--<font color="NAVY" size="2">
          <b>
          --><xsl:value-of select="PED_FECHA"/>
          <!--</b>
        </font>-->
            </td>
            <td align="right" width="*">
              Fecha de aceptación:&nbsp;
            </td>
            <td align="left" width="10%">
              &nbsp;<b><xsl:value-of select="PED_FECHAACEPTACION"/></b>
            </td>
          </tr>
        </table>
      </td>
    </tr>
    <tr class="blanco"> 
      <td class="claro">
        Fecha de entrega:
      </td>
      <td class="blanco">
        <font color="NAVY" size="2">
          <b>
          <xsl:value-of select="LP_FECHAENTREGA"/>
          </b>
        </font>
        <input type="hidden" name="FECHANO_ENTREGA" size="12" maxlength="10" value="{LP_FECHAENTREGA}" onFocus="this.blur();" class="inputOcultoPar"/>
      </td>
      <!--
      <td class="claro" rowspan="4">
        <xsl:value-of select="document('http://www.mvm.com/General/messages.xml')/messages/msg[@id='MO-0125' and @lang=$lang]" disable-output-escaping="yes"/>:
      </td>
      <td class="blanco" rowspan="4">
        <b class="rojo">
          <xsl:copy-of select="//MO_CONDICIONESGENERALESHTML"/>
        </b>
      </td>
      -->
      <td class="claro">
        Fecha de pago:
      </td>
      <td class="blanco">
        <xsl:choose>
          <xsl:when test="PLAZOPAGO='Otras'">
            <xsl:value-of select="LINEASPAGO/LINEASPAGO_ROW/LPP_FECHA"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="PLAZOPAGO"/> 
          </xsl:otherwise>
        </xsl:choose>
        <input type="hidden" name="FECHANO_PAGO" size="12" maxlength="10" value="{LINEASPAGO/LINEASPAGO_ROW/LPP_FECHA}" onFocus="this.blur();" class="inputOcultoPar"/>
      </td>
    </tr>
    <tr class="blanco"> 
      <td class="claro">
        Fecha de recepción:
      </td>
      <td class="blanco">
        <xsl:call-template name="COMBO_ENTREGA_REAL"/>
        <br/>
        <!--<input type="text" name="FECHA_ENTREGA_REAL" size="12" maxlength="10" value="{FECHA}"  onBlur="AvisarFechaRecepcion=0;"/>-->
        <script type="text/javascript">
          calFechaEntregaReal.dateFormat="d/M/yyyy";
          calFechaEntregaReal.minDate=new Date(formatoFecha(calculaFechaCalendarios(-100),'E','I'));
          calFechaEntregaReal.maxDate=new Date(formatoFecha(calculaFechaCalendarios(0),'E','I'));
          calFechaEntregaReal.writeControl();
        </script>
        <br/>
        (dd/mm/aaaa)  
      </td>
      <td class="claro">
        Forma de pago:
      </td>
      <td class="blanco">
        <xsl:if test="FORMASPAGO/field/@current!='999'">
          <xsl:value-of select="FORMAPAGO"/>
          <br/>
        </xsl:if>
        
        <input type="hidden" name="{FORMASPAGO/field/@name}" value="{FORMASPAGO/field/@current}"/>
        <input type="hidden" name="{PLAZOSPAGO/field/@name}" value="{PLAZOSPAGO/field/@current}"/>
        
        <xsl:value-of select="MO_FORMAPAGO"/>
        <input type="hidden" name="MO_FORMAPAGO" value="{MO_FORMAPAGO}" size="30"/>
      </td>
    </tr>
    <!--<tr class="blanco"> 
      <td class="claro">
        Fecha de pago:
      </td>
      <td class="blanco">
        <xsl:choose>
          <xsl:when test="PLAZOPAGO='Otras'">
            <xsl:value-of select="LINEASPAGO/LINEASPAGO_ROW/LPP_FECHA"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="PLAZOPAGO"/> 
          </xsl:otherwise>
        </xsl:choose>
        <input type="hidden" name="FECHANO_PAGO" size="12" maxlength="10" value="{LINEASPAGO/LINEASPAGO_ROW/LPP_FECHA}" onFocus="this.blur();" class="inputOcultoPar"/>
      </td>
    </tr>-->
    <!--<tr class="blanco"> 
      <td class="claro">
        Forma de pago:
      </td>
      <td class="blanco">
        <xsl:if test="FORMASPAGO/field/@current!='999'">
          <xsl:value-of select="FORMAPAGO"/>
          <br/>
        </xsl:if>
        
        <input type="hidden" name="{FORMASPAGO/field/@name}" value="{FORMASPAGO/field/@current}"/>
        <input type="hidden" name="{PLAZOSPAGO/field/@name}" value="{PLAZOSPAGO/field/@current}"/>
        
        <xsl:value-of select="MO_FORMAPAGO"/>
        <input type="hidden" name="MO_FORMAPAGO" value="{MO_FORMAPAGO}" size="30"/>
      </td>
    </tr>-->


            
  <!-- **************************************************************************************************************
   |
   |  						DETALLE DE PRODUCTOS
   |
   |			Nota: TODOS los templates  tambien difieren segun el estado.
   + ************************************************************************************************************** --> 
    
<tr bgcolor="#FFFFFF">
 <td colspan="6">  
  <br/>
  <table width="100%" border="0" cellspacing="0" cellpadding="0"><tr><td colspan="9">
  <table width="100%" border="0" cellspacing="1" cellpadding="1" class="muyoscuro" align="center">
  
        <xsl:element name="input"> 
          <xsl:attribute name="name">IDDIVISA</xsl:attribute>
          <xsl:attribute name="type">hidden</xsl:attribute>
          <xsl:attribute name="value"><xsl:value-of select="//@current"/></xsl:attribute>
    	</xsl:element>
  
    <tr class="oscuro" align="center">
      <td width="8%" align="center" class="oscuro">     
        <p class="tituloCamp"><xsl:value-of select="document('http://www.mvm.com/General/messages.xml')/messages/msg[@id='MO-0145' and @lang=$lang]" disable-output-escaping="yes"/></p></td>
      
      <td width="8%" class="oscuro">     
        <p class="tituloCamp"><xsl:value-of select="document('http://www.mvm.com/General/messages.xml')/messages/msg[@id='MO-0140' and @lang=$lang]" disable-output-escaping="yes"/></p></td>
      <td width="40%" class="oscuro">     
        <p class="tituloCamp"><xsl:value-of select="document('http://www.mvm.com/General/messages.xml')/messages/msg[@id='MO-0150' and @lang=$lang]" disable-output-escaping="yes"/></p></td>
        
          
      <td width="10%"  class="oscuro" align="center">
         <p class="tituloCamp"><xsl:value-of select="document('http://www.mvm.com/General/messages.xml')/messages/msg[@id='MO-0740' and @lang=$lang]" disable-output-escaping="yes"/></p>
       </td> 
      
      <td width="10%" class="oscuro">     
        <p class="tituloCamp"><xsl:value-of select="document('http://www.mvm.com/General/messages.xml')/messages/msg[@id='MO-0155' and @lang=$lang]" disable-output-escaping="yes"/></p></td>
      
        
      <td width="11%" class="oscuro">   <!-- Unidades -->
        <p class="tituloCamp"><xsl:value-of select="document('http://www.mvm.com/General/messages.xml')/messages/msg[@id='MO-0160' and @lang=$lang]" disable-output-escaping="yes"/></p></td>
      <td width="1%" align="center" class="oscuro">     
        <p class="tituloCamp">
          <xsl:value-of select="document('http://www.mvm.com/General/messages.xml')/messages/msg[@id='MO-0146' and @lang=$lang]" disable-output-escaping="yes"/>
          <br/>
          <br/>
          <a href="javascript:todasRecibidas(document.forms['form1'].elements['RECIBIDO_GLOBAL'])">
            <span class="textoComentario">Todas</span>
          </a>
        </p></td>
      <td width="5%" class="oscuro">    
            <p class="tituloCamp"><xsl:value-of select="document('http://www.mvm.com/General/messages.xml')/messages/msg[@id='MO-0166' and @lang=$lang]" disable-output-escaping="yes"/></p></td>
       
      <td width="5%" class="oscuro">	 <!-- Tipo IVA -->
        <p class="tituloCamp"><xsl:value-of select="document('http://www.mvm.com/General/messages.xml')/messages/msg[@id='MO-0175' and @lang=$lang]" disable-output-escaping="yes"/></p></td>
      <td width="10%" class="oscuro">   <!-- Importe -->
        <p class="tituloCamp"><xsl:value-of select="document('http://www.mvm.com/General/messages.xml')/messages/msg[@id='MO-0170' and @lang=$lang]" disable-output-escaping="yes"/></p></td>
      
    <td width="4%"  class="oscuro">
      <p class="tituloCamp"><xsl:value-of select="document('http://www.mvm.com/General/messages.xml')/messages/msg[@id='MO-0340' and @lang=$lang]" disable-output-escaping="yes"/></p>
    </td>
    </tr>
 
 <!--
  |  FOR EACH PARA CADA LINEA DE PRODUCTO 
  |   
  +-->    
 <xsl:for-each select="LINEASMULTIOFERTA/LINEASMULTIOFERTA_ROW">
 <xsl:if test="LMO_CANTIDAD_SINFORMATO>0">
 <tr>
   <xsl:attribute name="class"><xsl:choose><xsl:when test="position() mod 2">claro</xsl:when><xsl:otherwise>blanco</xsl:otherwise></xsl:choose></xsl:attribute>   
  <td>
    <xsl:attribute name="class"><xsl:choose><xsl:when test="position() mod 2">claro</xsl:when><xsl:otherwise>blanco</xsl:otherwise></xsl:choose></xsl:attribute>   
        <xsl:choose>
          <xsl:when test="REFERENCIA_PRIVADA!=''">
            <xsl:apply-templates select="REFERENCIA_PRIVADA"/>&nbsp;    
          </xsl:when>
          <xsl:otherwise>
            &nbsp;
          </xsl:otherwise>
        </xsl:choose>
      </td>
      <td>
        <xsl:attribute name="class"><xsl:choose><xsl:when test="position() mod 2">claro</xsl:when><xsl:otherwise>blanco</xsl:otherwise></xsl:choose></xsl:attribute>   
        <xsl:apply-templates select="PRO_REFERENCIA"/>&nbsp;</td>      
      <td>
        <xsl:attribute name="class"><xsl:choose><xsl:when test="position() mod 2">claro</xsl:when><xsl:otherwise>blanco</xsl:otherwise></xsl:choose></xsl:attribute>   
        <xsl:choose>
          <xsl:when test="NOMBRE_PRIVADO!=''">
            <a>
              <xsl:attribute name="href">javascript:MostrarPagPersonalizada('../../Administracion/Mantenimiento/Productos/PRODetalle.xsql?PRO_ID=<xsl:value-of select="LMO_IDPRODUCTO"/>&amp;IDEMPRESA_COMPRADORA=<xsl:value-of select="/Multioferta/MULTIOFERTA/MO_IDCLIENTE"/>','producto',70,50,0,-50)</xsl:attribute>
              <xsl:attribute name="onMouseOver">window.status='Ver detalle del producto';return true;</xsl:attribute>
              <xsl:attribute name="onMouseOut">window.status='';return true;</xsl:attribute>
              <xsl:value-of select="NOMBRE_PRIVADO"/>
            </a>&nbsp;
          </xsl:when>
          <xsl:otherwise>
            <a>
              <xsl:attribute name="href">javascript:MostrarPagPersonalizada('../../Administracion/Mantenimiento/Productos/PRODetalle.xsql?PRO_ID=<xsl:value-of select="LMO_IDPRODUCTO"/>&amp;IDEMPRESA_COMPRADORA=<xsl:value-of select="/Multioferta/MULTIOFERTA/MO_IDCLIENTE"/>','producto',70,50,0,-50)</xsl:attribute>
              <xsl:attribute name="onMouseOver">window.status='Ver detalle del producto';return true;</xsl:attribute>
              <xsl:attribute name="onMouseOut">window.status='';return true;</xsl:attribute>
              <xsl:value-of select="PRO_NOMBRE"/>
            </a>&nbsp;
          </xsl:otherwise>
        </xsl:choose>
    </td> 
   <td align="center">
     <xsl:attribute name="class"><xsl:choose><xsl:when test="position() mod 2">claro</xsl:when><xsl:otherwise>blanco</xsl:otherwise></xsl:choose></xsl:attribute>   
     <xsl:choose>
       <xsl:when test="PRO_UNIDADBASICA">
         <xsl:value-of select="PRO_UNIDADBASICA"/>
       </xsl:when>
       <xsl:otherwise>
         &nbsp;
       </xsl:otherwise>
     </xsl:choose>
       
   </td>
   <!-- en todos los estados mostramos "PRECIO UNITARIO" -->
   <td align="center">
     <xsl:attribute name="class"><xsl:choose><xsl:when test="position() mod 2">claro</xsl:when><xsl:otherwise>blanco</xsl:otherwise></xsl:choose></xsl:attribute>   
     	<xsl:choose>
        <xsl:when test="LMO_PRECIO/@TIPO='PUB'">
	  <input type="text" name="NuevoPrecio_{LMO_ID}" size="8" maxlength="7" style="text-align:right;color:red;" value="{LMO_PRECIO}" OnFocus="this.blur();">
	    <xsl:attribute name="class"><xsl:choose><xsl:when test="position() mod 2">inputOcultoImpar</xsl:when><xsl:otherwise>inputOcultoPar</xsl:otherwise></xsl:choose></xsl:attribute>  
        </input>
	</xsl:when>
	<xsl:when test="LMO_PRECIO/@TIPO='PRV'">
	  <input type="text" name="NuevoPrecio_{LMO_ID}" size="8" maxlength="7" style="text-align:right;color:blue;" value="{LMO_PRECIO}" OnFocus="this.blur();">
	    <xsl:attribute name="class"><xsl:choose><xsl:when test="position() mod 2">inputOcultoImpar</xsl:when><xsl:otherwise>inputOcultoPar</xsl:otherwise></xsl:choose></xsl:attribute>  
        </input>
	</xsl:when>
	<xsl:otherwise>
	  <input type="text" name="NuevoPrecio_{LMO_ID}" size="8" maxlength="7" style="text-align:right;color:black;" value="{LMO_PRECIO}" OnFocus="this.blur();">
	    <xsl:attribute name="class"><xsl:choose><xsl:when test="position() mod 2">inputOcultoImpar</xsl:when><xsl:otherwise>inputOcultoPar</xsl:otherwise></xsl:choose></xsl:attribute>  
        </input>
	</xsl:otherwise>                   
      </xsl:choose> 
   </td>  
   <td align="right">
     <xsl:attribute name="class"><xsl:choose><xsl:when test="position() mod 2">claro</xsl:when><xsl:otherwise>blanco</xsl:otherwise></xsl:choose></xsl:attribute>   
       <input type="text" name="NuevaCantidad_{LMO_ID}" size="8" maxlength="7" style="text-align:center" value="{LMO_CANTIDAD}" OnFocus="this.blur();">
	    <xsl:attribute name="class"><xsl:choose><xsl:when test="position() mod 2">inputOcultoImparBold</xsl:when><xsl:otherwise>inputOcultoParBold</xsl:otherwise></xsl:choose></xsl:attribute>  
        </input>
   </td>
   <td width="1%" align="center" class="oscuro">     
    <xsl:attribute name="class"><xsl:choose><xsl:when test="position() mod 2">claro</xsl:when><xsl:otherwise>blanco</xsl:otherwise></xsl:choose></xsl:attribute>   
      <table width="100%">
        <tr align="center">
          <td>
            
            <input type="hidden" name="IDLINEAPEDIDO_{LMO_ID}"  value="{LMO}"/>
            <input type="hidden" name="CANTIDADSINFORMATO_{LMO_ID}"  value="{LMO_CANTIDAD_SINFORMATO}"/>
            <input type="text" name="CantidadEntregada_{LMO_ID}" size="8" style="text-align:right" maxlength="7"  value="{LMO_CANTIDAD_SINFORMATO}" OnBlur="UnidadesALotesRecibidasImagen(this.value,'{PRO_UNIDADESPORLOTE}','{LMO_CANTIDAD_SINFORMATO}',this);" onFocus="this.select();"/>
          </td>
          <td>
            <!--<input type="checkbox" name="CHKRECIBIDO_{LMO_ID}" checked="checked" onClick="validarCheckeado(this, this.form,{LMO_CANTIDAD_SINFORMATO});"/>-->
            <img src="http://www.mvm.com/images/recibido.gif" width="10px" height="10px" name="IMGRECIBIDO_{LMO_ID}" value="checked"/>
            <input type="hidden" name="CHKRECIBIDO_{LMO_ID}" value="checked"/>
            <!--<img src="http://www.mvm.com"type="checkbox" name="CHKRECIBIDO_{LMO_ID}" checked="checked" onClick="validarCheckeado(this, this.form,{LMO_CANTIDAD_SINFORMATO});"/>-->
          </td>
        </tr>
      </table>
   </td> 
   <td align="center">
     <xsl:attribute name="class"><xsl:choose><xsl:when test="position() mod 2">claro</xsl:when><xsl:otherwise>blanco</xsl:otherwise></xsl:choose></xsl:attribute>   
        <xsl:apply-templates select="PRO_UNIDADESPORLOTE"/>&nbsp;
      </td>
   <td align="center">
     <xsl:attribute name="class"><xsl:choose><xsl:when test="position() mod 2">claro</xsl:when><xsl:otherwise>blanco</xsl:otherwise></xsl:choose></xsl:attribute>   
       <xsl:if test="LMO_TIPOIVA"><xsl:value-of select="LMO_TIPOIVA"/><!--%--></xsl:if>&nbsp;
   </td>
   
   <td align="right">
     <xsl:attribute name="class"><xsl:choose><xsl:when test="position() mod 2">claro</xsl:when><xsl:otherwise>blanco</xsl:otherwise></xsl:choose></xsl:attribute>      
        <xsl:value-of select="DIV_PREFIJO"/><input type="text" name="NuevoImporte_{LMO_ID}" size="11" maxlength="11" style="text-align:right;font-weight:bold;" value="{IMPORTE}" onFocus="this.blur();"><xsl:attribute name="class"><xsl:choose><xsl:when test="position() mod 2">inputOcultoImpar</xsl:when><xsl:otherwise>inputOcultoPar</xsl:otherwise></xsl:choose></xsl:attribute></input>
   </td>
    <td>
      <xsl:attribute name="class"><xsl:choose><xsl:when test="position() mod 2">claro</xsl:when><xsl:otherwise>blanco</xsl:otherwise></xsl:choose></xsl:attribute>   
      <input type="text" name="divisa_{LMO_ID}" size="4" value="{//DIV_SUFIJO}" style="text-align:center" OnFocus="this.blur();">
	    <xsl:attribute name="class"><xsl:choose><xsl:when test="position() mod 2">inputOcultoImpar</xsl:when><xsl:otherwise>inputOcultoPar</xsl:otherwise></xsl:choose></xsl:attribute>  
        </input>
    </td>
  </tr>  
  </xsl:if>
 </xsl:for-each>
 <tr class="blanco">
    <td colspan="11" align="left" class="blanco">
      <table width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr>
          <td align="center">
            <span class="textoComentario">
              Puede indicar la cantidad real recibida para facilitar su control.
            </span>
          </td>
        </tr>
      </table>
      <!--
      * el color <font color="blue">azul</font> indica que los precios son  privados
      <br/>
      * el color <font color="red">rojo</font> indica que los precios son públicos
      -->
    </td>
  </tr>
</table>


  


</td>
</tr>	
    </table>
<br/>
<table border="0" align="center" width="97%"> 	         

	    
<!-- **************************************************************************************************************
   |
   |  						ZONA de TOTALES
   |			
   + ************************************************************************************************************** --> 

   <!--
    |   linea despues de la tabla de productos : xxx | Subtotal:
    +-->
    <tr class="blanco"><td colspan="9"><br/></td></tr>    
    <tr class="blanco">
      <td colspan="6" width="60%" valign="top">
        <xsl:choose>
        <xsl:when test="LINEASMULTIOFERTA/LINEASMULTIOFERTA_ROW/IMPORTE[.=''] and MO_STATUS[.=6]">	  
	  <p class="nota"><xsl:value-of select="document('http://www.mvm.com/General/messages.xml')/messages/msg[@id='MO-0680' and @lang=$lang]" disable-output-escaping="yes"/></p>
	</xsl:when>
	</xsl:choose></td>
      <td align="right" width="20%">
        <p class="tituloCamp" style="margin-right:10px;"><xsl:value-of select="document('http://www.mvm.com/General/messages.xml')/messages/msg[@id='MO-0270' and @lang=$lang]" disable-output-escaping="yes"/>:</p></td>     
      <td align="right" width="10%">
        <xsl:value-of select="DIV_PREFIJO"/><xsl:apply-templates select="IMPORTE_TOTAL_FORMATO"/>&nbsp;</td>
     
          <td width="4%">
            <input type="text" name="divisa_subtotal" onFocus="this.blur();" value="{DIV_SUFIJO}" class="inputOcultoPar" style="text-align:center" size="3"/> 
            &nbsp; 
          </td>

    </tr> 
     
    
    <tr class="blanco">
      
      <td colspan="9">&nbsp;</td>
    </tr>    
    <xsl:variable name="numeroSpan">7</xsl:variable> 
      
    <tr class="blanco">      
      <td align="right">
        <xsl:attribute name="colspan"><xsl:value-of select="$numeroSpan"/></xsl:attribute>
        <p class="tituloCamp" style="margin-right:10px;"><xsl:value-of select="document('http://www.mvm.com/General/messages.xml')/messages/msg[@id='MO-0260' and @lang=$lang]" disable-output-escaping="yes"/>:</p></td>     
      <td align="right" width="10%">
        <input type="text" name="MO_DESCUENTOGENERAL" size="6" maxlength="6" style="text-align:right;font-weight:bold;" value="{MO_DESCUENTOGENERAL}" class="inputOcultoBlancoBold" onFocus="this.blur();"/>
        </td>
      <td align="center">%</td>
    </tr>
    
    <tr class="blanco">
      <td align="right">
        <xsl:attribute name="colspan"><xsl:value-of select="$numeroSpan"/></xsl:attribute>    
        <p class="tituloCamp" style="margin-right:10px;"><xsl:value-of select="document('http://www.mvm.com/General/messages.xml')/messages/msg[@id='MO-0240' and @lang=$lang]" disable-output-escaping="yes"/>:</p></td>     
      <td align="right">
        <xsl:value-of select="DIV_PREFIJO"/><xsl:apply-templates select="MO_COSTELOGISTICA_FORMATO"/>
        </td>
      <td align="center">&nbsp;<xsl:value-of select="DIV_SUFIJO"/>&nbsp;</td>
    </tr>
    
    <tr class="blanco"> 
      <td align="right">
        <xsl:attribute name="colspan"><xsl:value-of select="$numeroSpan"/></xsl:attribute>    
        <p class="tituloCamp" style="margin-right:10px;"><xsl:value-of select="document('http://www.mvm.com/General/messages.xml')/messages/msg[@id='MO-0235' and @lang=$lang]" disable-output-escaping="yes"/>:</p></td>       
      <td align="right">
        <xsl:value-of select="DIV_PREFIJO"/><input type="text" name="MO_IMPORTEIVA" size="12" maxlength="12" style="text-align:right;" class="inputOcultoBlancoBold" onFocus="this.blur();" value="{MO_IMPORTEIVA_FORMATO}"/>
        </td>      
      <td align="center">&nbsp;<xsl:value-of select="DIV_SUFIJO"/>&nbsp;</td>
    </tr>
    
    <tr class="blanco"> 
      <td align="right">
        <xsl:attribute name="colspan"><xsl:value-of select="$numeroSpan"/></xsl:attribute>      
        <p class="tituloCamp" style="margin-right:10px;"><xsl:value-of select="document('http://www.mvm.com/General/messages.xml')/messages/msg[@id='MO-0230' and @lang=$lang]" disable-output-escaping="yes"/>:</p></td>       
      <td align="right">
        <xsl:value-of select="DIV_PREFIJO"/><input type="text" name="IMPORTE_FINAL_PEDIDO" size="12" maxlength="12" style="text-align:right" class="inputOcultoBlancoBold" onFocus="this.blur();" value="{IMPORTE_FINAL_PEDIDO}"/>
        </td>
      <td align="center">&nbsp;<xsl:value-of select="DIV_SUFIJO"/>&nbsp;</td>
    </tr>
 </table>      
</td>
</tr>  

</form>	
     
  
<!-- **************************************************************************************************************
   |
   |  						ZONA DE LINEAS DE PAGO
   |					(fecha|forma|importe|comentarios) + Boton Añadir(*)
   |			
   + ************************************************************************************************************** -->       
    
   <xsl:apply-templates select="LINEASPAGO/LPP_IDPEDIDO"/> 
   
   <form name="anadir" method="post">
     <xsl:apply-templates select="MO_IDPEDIDO"/>
     <xsl:apply-templates select="MO_STATUS"/>       
     <xsl:apply-templates select="MO_ID"/>       	        
     <xsl:apply-templates select="/Multioferta/ROL"/>
     <xsl:apply-templates select="/Multioferta/TIPO"/>
   </form>
              



  <!-- **************************************************************************************************************
   |
   |  						ZONA DE NEGOCIACION
   |					     Comentarios de + EMPRESA
   |			
   + ************************************************************************************************************** -->      

 
	<!--	23mar10	ET	Comprobamos si hay comentarios antes de llamar a negociacion -->
	<xsl:if test="NEGOCIACION/NEGOCIACION_ROW">
    	<tr class="blanco">
      		<td colspan="6" class="blanco">
        		<xsl:apply-templates select="NEGOCIACION"/>
       			<br/>
     		</td>
    	</tr>
	</xsl:if>
	<xsl:if test="MO_URGENCIA='S'">
    	<tr class="blanco">
      		<td colspan="6" class="blanco">
 			<br/>
 			<table align="center">
 				<tr>
    			<td class="blanco" colspan="10" align="center">
    				<font color="red" size="3">
    					<b>URGENTE</b>
    				</font>
    			</td>
    		</tr>
 			</table>
    	  </td>
    	</tr>
		<br/>
	</xsl:if>
 	<!--	22mar10	Albaran		-->
    <form name="comentarios" method="post">  
	<tr class="claro">
		<td align="left">
			Número de Albarán de Salida:
		</td>
		<td align="left" colspan="3">&nbsp;
			<input type="text" name="ALBARAN_SALIDA" size="30" maxlength="100" value="{PED_ALBARAN}" />
			<input type="hidden" name="ALBARAN_OBLIGATORIO" value="{ALBARAN_OBLIGATORIO}"/>
		</td>
	</tr>
 
   
<!-- **************************************************************************************************************
   |
   |  						ZONA DE COMENTARIOS
   |					Para Estados que no sean un rechazo
   |			
   + ************************************************************************************************************** -->       
    <input type="hidden" name="NMU_COMENTARIOS" value=""/>
 	</form>
      
 <!--	22mar10 Eliminamos comentarios, solo se permiten en el primer paso del pedido
         <form name="comentarios" method="post">  
           <tr class="oscuro">
	          <td colspan="6" align="center" class="oscuro">
		    <p class="tituloCamp"><xsl:value-of select="document('http://www.mvm.com/General/messages.xml')/messages/msg[@id='MO-0285' and @lang=$lang]" disable-output-escaping="yes"/>:</p> 
		  </td>
		</tr>
		  <tr class="blanco">
		  <td colspan="6" align="center" class="blanco">         
	            <table cellpadding="0" cellspacing="0" align="center" border="0">
	              <tr>
	                <td>
	                  <textarea name="NMU_COMENTARIOS" cols="80" rows="6" maxlength="300" onChange="comentariosToForm1(document.forms['comentarios'], document.forms['form1'],'NMU_COMENTARIOS');"/>
	                </td>
	              </tr>
	              <tr>
	                <td align="center">
	                  <xsl:call-template name="botonPersonalizado">
	                    <xsl:with-param name="label">Comentarios</xsl:with-param>
	                    <xsl:with-param name="status">Comentarios</xsl:with-param>
	                    <xsl:with-param name="funcion">ultimosComentarios('NMU_COMENTARIOS','comentarios','MULTIOFERTAS');</xsl:with-param>
	                    <xsl:with-param name="ancho">140px</xsl:with-param>
	                  </xsl:call-template>
	                </td>
	              </tr>
	            </table>
	            <xsl:if test="MO_URGENCIA='S'">

 						<br/>
 						
 						<table align="center">
 							<tr>
    						<td class="blanco" colspan="10" align="center">
    							<font color="red" size="3">
    								<b>URGENTE</b>
    							</font>
    						</td>
    					</tr>
 						</table>
						
						<br/>
					
 				</xsl:if>
	          </td>
	   </tr>
	</form>
-->

	<!--
		7jun07	ET	Control de la aceptacion del pedido
	-->
<!--	22mar10	Quitamos la info sobre stocks
	<br/>
	<br/>
	<table width="100%" border="0">
		<tr>
			<td align="right" width="50%">
				El proveedor confirma disponer de stock en el almacén para entregar TOTALMENTE este pedido en la fecha prevista:&nbsp;
			</td>
			<td align="left">
				<xsl:choose>
					<xsl:when test="/Multioferta/MULTIOFERTA/PED_CONSTOCK='S'">
						<b>SI</b>
					</xsl:when>
					<xsl:otherwise>
						<font color="red"><b>NO / No lo sé</b></font>
					</xsl:otherwise>
				</xsl:choose>
			</td>
		</tr>
		< ! - -
		<tr>
			<td align="right">
				El proveedor confirma que este pedido será TOTALMENTE entregado en el cliente en la fecha prevista:&nbsp;
			</td>
			<td align="left">
				<xsl:choose>
					<xsl:when test="/Multioferta/MULTIOFERTA/PED_ENTREGAENFECHA='S'">
						<b>SI</b>
					</xsl:when>
					<xsl:otherwise>
						<font color="red"><b>NO / No lo sé</b></font>
					</xsl:otherwise>
				</xsl:choose>
			</td>
		</tr>
		- - >
  </table>
   </table> 
-->
      
<!-- **************************************************************************************************************
   |
   |  							BOTONES
   |				       Mostramos todos los botones del xsql
   |				O sea, el choose ya se hace en la base de datos para esta parte
   |					El estado 10 es un caso aparte
   + ************************************************************************************************************** -->       

     
   <!-- final tabla ppal -->
   <br/> 
	<table width="100%" border="0">
	  <tr align="center">        
 	    <td width="16%">
 	      <xsl:call-template name="boton">
 	        <xsl:with-param name="path" select="//Multioferta/BOTONS_NUEVO/button[@label='EntregaPendiente']"/>
 	      </xsl:call-template>
 	    </td>
 	    <td width="16%">
 	        <xsl:call-template name="boton">
 	          <xsl:with-param name="path" select="//Multioferta/BOTONS_NUEVO/button[@label='Imprimir']"/>
 	        </xsl:call-template>
 	    </td> 
	    <td width="16%">
	      <xsl:call-template name="boton">
 	        <xsl:with-param name="path" select="//Multioferta/BOTONS_NUEVO/button[@label='AceptarEntrega']"/>
 	      </xsl:call-template>
	    </td>  
	    <td width="16%">
	      <xsl:call-template name="boton">
 	        <xsl:with-param name="path" select="//Multioferta/BOTONS_NUEVO/button[@label='AceptarEntregaParcial']"/>
 	        <xsl:with-param name="ancho">150px</xsl:with-param>
 	      </xsl:call-template>
	    </td> 
	    <td width="16%">
	      <xsl:call-template name="boton">
 	        <xsl:with-param name="path" select="//Multioferta/BOTONS_NUEVO/button[@label='CrearAbono']"/>
 	      </xsl:call-template>
	    </td>
		<!--
	    <td width="16%">
	      <xsl:call-template name="boton">
 	        <xsl:with-param name="path" select="//Multioferta/BOTONS_NUEVO/button[@label='IncidenciaEntrega']"/>
 	      </xsl:call-template>
	    </td>
		-->
	    <td width="16%">
	      <xsl:call-template name="boton">
 	        <xsl:with-param name="path" select="//Multioferta/BOTONS_NUEVO/button[@label='AvisarRetraso']"/>
 	      </xsl:call-template>
	    </td> 
	  </tr>
	</table>	
	</table>	
</xsl:template>

 <!-- **************************************************************************************************************
   |
   |  						TEMPLATES
   |
   |			
   + ************************************************************************************************************** --> 

<!--
 | NEGOCIACION
 |
 + -->  
<xsl:template match="NEGOCIACION">    
  <br/>
  <table width="100%" border="0" cellpadding="0" cellspacing="1" class="muyoscuro">
    <tr class="oscuro">
      <td class="oscuro">
        Comentarios
        <br/>
      </td>
    </tr>
    <tr class="blanco">
      <td class="blanco">
        <table width="100%">
          <xsl:for-each select="NEGOCIACION_ROW">
            <tr>
              <td>
                <table width="100%" cellpadding="0" cellspacing="1" class="oscuro">
                  <tr>
                    <xsl:choose> 
                      <xsl:when test="/Multioferta/MULTIOFERTA/CENTRO/CEN_ID!=IDCENTRO"> <!-- caso de COLor='B' o no informado -->
                        <xsl:attribute name="class">blanco</xsl:attribute>
                      </xsl:when>
                      <xsl:otherwise> <!-- caso de COLor='B' o no informado -->
                        <xsl:attribute name="class">claro</xsl:attribute>
                      </xsl:otherwise>
                    </xsl:choose>
                    <td valign="top" width="25%" align="left"> 
                      <xsl:choose> 
                        <xsl:when test="/Multioferta/MULTIOFERTA/CENTRO/CEN_ID!=IDCENTRO"> <!-- caso de COLor='B' o no informado -->
                          <xsl:attribute name="class">blanco</xsl:attribute>
                        </xsl:when>
                        <xsl:otherwise> <!-- caso de COLor='B' o no informado -->
                          <xsl:attribute name="class">claro</xsl:attribute>
                        </xsl:otherwise>
                      </xsl:choose>
                      <p class="tituloCamp">
	                <xsl:value-of select="CENTRO"/>:&nbsp;	  
	              </p>
                    </td>
                    <td valign="top" width="*" align="center"> 
                      <xsl:choose> 
                        <xsl:when test="/Multioferta/MULTIOFERTA/CENTRO/CEN_ID!=IDCENTRO"> <!-- caso de COLor='B' o no informado -->
                          <xsl:attribute name="class">blanco</xsl:attribute>
                        </xsl:when>
                        <xsl:otherwise> <!-- caso de COLor='B' o no informado -->
                          <xsl:attribute name="class">claro</xsl:attribute>
                        </xsl:otherwise>
                      </xsl:choose>
                      <p class="tituloCamp">
	                <xsl:copy-of select="NMU_ESTADO"/>  
	              </p>
                    </td>
                    <td valign="top" width="25%" align="right"> 
                      <xsl:choose> 
                        <xsl:when test="/Multioferta/MULTIOFERTA/CENTRO/CEN_ID!=IDCENTRO"> <!-- caso de COLor='B' o no informado -->
                          <xsl:attribute name="class">blanco</xsl:attribute>
                        </xsl:when>
                        <xsl:otherwise> <!-- caso de COLor='B' o no informado -->
                          <xsl:attribute name="class">claro</xsl:attribute>
                        </xsl:otherwise>
                      </xsl:choose>
                      <p class="tituloCamp">
	                <xsl:value-of select="NMU_FECHA"/> 	  
	              </p>
                    </td>
                  </tr>
                  <tr>
                    <xsl:choose> 
                      <xsl:when test="/Multioferta/MULTIOFERTA/CENTRO/CEN_ID!=IDCENTRO"> <!-- caso de COLor='B' o no informado -->
                        <xsl:attribute name="class">blanco</xsl:attribute>
                      </xsl:when>
                      <xsl:otherwise> <!-- caso de COLor='B' o no informado -->
                        <xsl:attribute name="class">claro</xsl:attribute>
                      </xsl:otherwise>
                    </xsl:choose>
                    <td colspan="3">   
                      <xsl:choose> 
                        <xsl:when test="/Multioferta/MULTIOFERTA/CENTRO/CEN_ID!=IDCENTRO"> <!-- caso de COLor='B' o no informado -->
                          <xsl:attribute name="class">blanco</xsl:attribute>
                        </xsl:when>
                        <xsl:otherwise> <!-- caso de COLor='B' o no informado -->
                          <xsl:attribute name="class">claro</xsl:attribute>
                        </xsl:otherwise>
                      </xsl:choose>
                      <table width="50%" align="center">
                        <tr>
                          <td>
                            <p>
                              <font class="textoNegociacion">
                                &nbsp;<xsl:copy-of select="NMU_COMENTARIOS"/>
                              </font>
                            </p>
                          </td>
                        </tr>
                      </table>                       
                    </td>  
                  </tr>
                </table>
              </td>
            </tr>
          </xsl:for-each> 
        </table>
      </td>
    </tr>                    
  </table>
 
</xsl:template>

<xsl:template match="IMPORTE_TOTAL_FORMATO">
      <input type="text" name="MO_SUBTOTAL" size="12" maxlength="12" style="text-align:right;" value="{.}" class="inputOcultoBlancoBold" onFocus="this.blur();"/>
</xsl:template> 

<xsl:template match="MO_COSTELOGISTICA">
  <input type="text" name="MO_COSTELOGISTICA" size="12" maxlength="12" style="text-align:right;font-weight:bold;">
    <xsl:attribute name="value"><xsl:value-of select="."/></xsl:attribute>
    <xsl:attribute name="onFocus">this.blur();</xsl:attribute>
    <xsl:attribute name="class">inputOcultoBlancoBold</xsl:attribute>
  </input>
</xsl:template>

<xsl:template match="MO_COSTELOGISTICA_FORMATO">
  <input type="text" name="MO_COSTELOGISTICA" size="12" maxlength="12" style="text-align:right;font-weight:bold;">
    <xsl:attribute name="value"><xsl:value-of select="."/></xsl:attribute>
    <xsl:attribute name="onFocus">this.blur();</xsl:attribute>
    <xsl:attribute name="class">inputOcultoBlancoBold</xsl:attribute>
  </input>
</xsl:template>

<xsl:template match="LMO_DESCUENTO">
  <input type="text" name="LMO_DESCUENTO" size="6" maxlength="6" style="text-align:right;">
    <xsl:attribute name="value"><xsl:value-of select="."/></xsl:attribute>
  </input>
</xsl:template>

<xsl:template match="MO_STATUS">
  <input type="hidden" name="MO_STATUS">
    <xsl:attribute name="value">
      <xsl:value-of select="."/>
    </xsl:attribute>
  </input>
</xsl:template>

<xsl:template match="MO_ID">
  <input type="hidden" name="MO_ID">
    <xsl:attribute name="value">
      <xsl:value-of select="."/>
    </xsl:attribute>
  </input>
</xsl:template>

<xsl:template match="ROL">
  <input type="hidden" name="ROL">
    <xsl:attribute name="value">
      <xsl:value-of select="."/>
    </xsl:attribute>
  </input>
</xsl:template>

<xsl:template match="TIPO">
  <input type="hidden" name="TIPO">
    <xsl:attribute name="value">
      <xsl:value-of select="."/>
    </xsl:attribute>
  </input>
</xsl:template>


<xsl:template match="MO_IDPEDIDO">
  <input type="hidden" name="PED_ID">
    <xsl:attribute name="value">
      <xsl:value-of select="."/>
    </xsl:attribute>
  </input>
</xsl:template>


<xsl:template match="LPP_IDPEDIDO">
  <input type="hidden" name="PED_ID">
    <xsl:attribute name="value">
      <xsl:value-of select="."/>
    </xsl:attribute>
  </input>
</xsl:template>

<xsl:template match="LPP_ID">
  <input type="hidden" name="LPP_ID">
    <xsl:attribute name="value">
      <xsl:value-of select="."/>
    </xsl:attribute>
  </input>
</xsl:template>

  <xsl:template match="fieldTipoIVA">
  <xsl:variable name="IDAct" select="$IDAct"/>
    <select>
      <xsl:attribute name="name"><xsl:value-of select="../@name"/><xsl:value-of select="../LMO_IDPRODUCTO"/></xsl:attribute>
      <xsl:attribute name="onChange">actualizaIVA('<xsl:value-of select="../LMO_IDPRODUCTO"/>',this.options[this.selectedIndex].value)</xsl:attribute>
      <xsl:for-each select="listElem">
      <xsl:value-of select="$IDAct"/>
        <xsl:choose>
          <xsl:when test="$IDAct = ID">
            <option selected="selected">
    	      <xsl:attribute name="value">
     	        <xsl:value-of select="ID"/>
  	      </xsl:attribute>                       
   	      [<xsl:value-of select="listItem"/>]
            </option>
          </xsl:when>
          <xsl:otherwise>
            <option>
    	      <xsl:attribute name="value">
     	        <xsl:value-of select="ID"/>
  	      </xsl:attribute>
              <xsl:value-of select="listItem"/>
            </option> 
            </xsl:otherwise>
          </xsl:choose>
      </xsl:for-each>
    </select>
  </xsl:template>
  
  <xsl:template name="fieldTipoIVA_funcion">
    <xsl:param name="path"/>
    <xsl:param name="IDAct"/>
    <select>
      <xsl:attribute name="name"><xsl:value-of select="$path/../@name"/><xsl:value-of select="$path/../LMO_IDPRODUCTO"/></xsl:attribute>
      <xsl:attribute name="onChange">actualizaIVA('<xsl:value-of select="$path/../LMO_IDPRODUCTO"/>',this.options[this.selectedIndex].value)</xsl:attribute>
      <xsl:for-each select="$path/listElem">
      <xsl:value-of select="$IDAct"/>
        <xsl:choose>
          <xsl:when test="$IDAct = ID">
            <option selected="selected">
    	      <xsl:attribute name="value">
     	        <xsl:value-of select="ID"/>
  	      </xsl:attribute>                       
   	      [<xsl:value-of select="listItem"/>]
            </option>
          </xsl:when>
          <xsl:otherwise>
            <option>
    	      <xsl:attribute name="value">
     	        <xsl:value-of select="ID"/>
  	      </xsl:attribute>
              <xsl:value-of select="listItem"/>
            </option> 
            </xsl:otherwise>
          </xsl:choose>
      </xsl:for-each>
    </select>
  </xsl:template>
  
  <xsl:template name="direccion">
    <xsl:param name="path"/>
    <xsl:value-of select="$path/EMP_DIRECCION"/>
    <br/>
    <xsl:value-of select="$path/EMP_CPOSTAL"/>-<xsl:value-of select="$path/EMP_POBLACION"/>
    <br/>
    <xsl:value-of select="$path/EMP_PROVINCIA"/>
    <br/><br/>
	 telf:&nbsp;Contactar con MedicalVM: 93 241 26 99
	<!-- ET 26feb08 Eliminamos teléfonos y faxes
    <xsl:choose>
      <xsl:when test="$path/EMP_TELEFONO!=''">
        telf:&nbsp;<xsl:value-of select="$path/EMP_TELEFONO"/>
      </xsl:when>
      <xsl:otherwise>
        &nbsp;
      </xsl:otherwise>
    </xsl:choose>
    <br/>
    <xsl:choose>  
      <xsl:when test="$path/EMP_FAX!=''">
    fax:&nbsp;<xsl:value-of select="$path/EMP_FAX"/>
    </xsl:when>
    <xsl:otherwise>
        &nbsp;
      </xsl:otherwise>
    </xsl:choose>-->
  </xsl:template>
  
  <xsl:template name="direccionCentro">
    <xsl:param name="path"/>
    <xsl:value-of select="$path/MO_DIRECCION"/>
    <br/>
    <xsl:value-of select="$path/MO_CPOSTAL"/>-<xsl:value-of select="$path/MO_POBLACION"/>
    <br/>
    <xsl:value-of select="$path/MO_PROVINCIA"/>
    <br/><br/>
	telf:&nbsp;Contactar con MedicalVM: 93 241 26 99
    <!--<xsl:choose>
      <xsl:when test="$path/../CENTRO/CEN_TELEFONO!=''">
        telf:&nbsp;<xsl:value-of select="$path/../CENTRO/CEN_TELEFONO"/>
      </xsl:when>
      <xsl:otherwise>
        &nbsp;
      </xsl:otherwise>
    </xsl:choose>
    <br/>
    <xsl:choose>  
      <xsl:when test="$path/../CENTRO/CEN_FAX!=''">
    fax:&nbsp;<xsl:value-of select="$path/../CENTRO/CEN_FAX"/>
    </xsl:when>
    <xsl:otherwise>
        &nbsp;
      </xsl:otherwise>
    </xsl:choose>-->
  </xsl:template>
  
  <xsl:template name="COMBO_ENTREGA_REAL">
	<xsl:call-template name="field_funcion">
    	<xsl:with-param name="path" select="/Multioferta/field[@name='COMBO_ENTREGA_REAL']"/>
    	<xsl:with-param name="IDAct">0</xsl:with-param>
    	<xsl:with-param name="cambio">calculaFecha('ENTREGA_REAL',this.options[this.selectedIndex].value);</xsl:with-param>
    	<xsl:with-param name="perderFoco">AvisarFechaRecepcion=0;</xsl:with-param>
    </xsl:call-template>
</xsl:template>

<xsl:template name="lugarEntregaConsumo">
    <xsl:param name="path"/>
    
    <b>Lugar de entrega:</b>
    <br/>
    <xsl:value-of select="$path/ENTREGA/MO_LUGARENTREGA"/>
    <xsl:if test="$path/ENTREGA/MO_REFLUGARENTREGA!=''">
    	(<xsl:value-of select="$path/ENTREGA/MO_REFLUGARENTREGA"/>)
    </xsl:if>
    <br/>
    <!-- 2mar09    ET    AL pone comentarios en el centro de consumo que deben ver los proveedores<xsl:if test="$path/CENTROCONSUMO/MO_REFCENTROCONSUMO!='' and (/Multioferta/US_ID=/Multioferta/MULTIOFERTA/MO_IDUSUARIOCOMPRADOR or /Multioferta/MULTIOFERTA/ES_COMPRADOR)">-->
<xsl:if test="$path/CENTROCONSUMO/MO_REFCENTROCONSUMO!='' "> 
    	<br/>
   		<b>Centro de consumo:</b>
    	<br/>
    	<xsl:value-of select="$path/CENTROCONSUMO/MO_CENTROCONSUMO"/> (<xsl:value-of select="$path/CENTROCONSUMO/MO_REFCENTROCONSUMO"/>)
    </xsl:if>
    <!--
    <xsl:if test="$path/ALMACENINTERNO/MO_REFALMACENINTERNO!=''">
    	<br/>
    	<b>Almacén interno:</b>
    	<br/>
    	<xsl:value-of select="$path/ALMACENINTERNO/MO_ALMACENINTERNO"/> (<xsl:value-of select="$path/ALMACENINTERNO/MO_REFALMACENINTERNO"/>)
    </xsl:if>
    -->
    
  </xsl:template>
  
</xsl:stylesheet>
