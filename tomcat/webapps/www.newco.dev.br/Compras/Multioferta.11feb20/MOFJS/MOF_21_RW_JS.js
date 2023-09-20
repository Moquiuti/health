// JavaScript Document
//js de MOF_21_RW


     

       
         var msgError='', msgErrorStd=' \n\nPor favor, corrija el error antes de enviar el formulario.';
 //no se usa fin  

	
	
	
	function Actua(formu,accion){
	  comentariosToForm1(document.forms['form1'], document.forms['form1'],'NMU_COMENTARIOS');	
	  AsignarAccion(formu,accion);
	  //quito los botones asi no doble click
			document.getElementById('ocultarBotones').style.display = 'none';
	  SubmitForm(formu,document);
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
        
          