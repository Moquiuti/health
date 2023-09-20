// JavaScript Document

 function CerrarVentana(){
	    
	    var nombreFormRemoto=document.forms['form1'].elements['NOMBRE_FORM'].value;
            var nombreObjetoRemoto=document.forms['form1'].elements['NOMBRE_OBJETO'].value;
	  
	    var objFrameTop=new Object();    
            objFrameTop=window.opener.top;
            
            var FrameOpenerName=window.opener.name;
            var objFrame=new Object();
            
            objFrame=obtenerFrame(objFrameTop,FrameOpenerName);
            window.close();
            objFrame.document.forms[nombreFormRemoto].elements[nombreObjetoRemoto].focus();
	  }
	  
	  function copiarComentarios(texto, nombreObjeto, nombreframe, nombreForm){
            var objFrameTop=new Object();    
            objFrameTop=window.opener.top;
            
            var FrameOpenerName=window.opener.name;
            var objFrame=new Object();
            
            objFrame=obtenerFrame(objFrameTop,FrameOpenerName);
            
            //if(confirm('copiar los comentarios?')){
              objFrame.copiarComentarios(nombreForm,nombreObjeto,texto.replace(/\\n/g,String.fromCharCode(13,10)));
              
            //}
	  }
	  
	  
	  
	  function existeElComentario(comentario){
	    var coment=comentario;
	    for(var n=0;n<document.forms['form1'].length;n++){
	      if(document.forms['form1'].elements[n].type=='hidden' && document.forms['form1'].elements[n].name.substring(0,11)=='COMENTARIO_'){
	        if(quitarEspacios(document.forms['form1'].elements[n].value)==quitarEspacios(eliminarCaracterAscii(comentario.replace(/\n/g,'\\\\n'),13))){
	          return 1;
	        }
	      }
	    }
	    return 0;
	  }
	  
	  function GuardarComentario(form, accion){
	    var objFrameTop=new Object();    
            objFrameTop=window.opener.top;
            
            var FrameOpenerName=window.opener.name;
            var objFrame=new Object();
            
            objFrame=obtenerFrame(objFrameTop,FrameOpenerName);
            
            var nombreFormRemoto=form.elements['NOMBRE_FORM'].value;
            var nombreObjetoRemoto=form.elements['NOMBRE_OBJETO'].value;
	  
	    document.forms['form1'].elements['COMENTARIO'].value=objFrame.document.forms[nombreFormRemoto].elements[nombreObjetoRemoto].value;	    
	    
	    if(quitarEspacios(document.forms['form1'].elements['COMENTARIO'].value)==''){
	      alert(document.forms['MensajeJS'].elements['SIN_COME_PARA_GUARDAR'].value);
	      objFrame.document.forms[nombreFormRemoto].elements[nombreObjetoRemoto].focus();
	    }
	    else{
	      if(!existeElComentario(document.forms['form1'].elements['COMENTARIO'].value)){
	        form.elements['ACCION'].value=accion;
	        SubmitForm(form);
	      }
	      else{
	        alert(document.forms['MensajeJS'].elements['COME_YA_EXISTE'].value);
	      }
	    }
	  }
	  
	  function BorrarComentarios(form, accion){
	    var cambios='';
	    var existe=0;
	    for(var n=0;n<form.length;n++){
	      if(form.elements[n].type=='checkbox' && form.elements[n].name.substring(0,14)=='CHKCOMENTARIO_'){
	        existe=1;
	        if(form.elements[n].checked==true){
            	//alert('coment '+form.elements[n].name);
                var id = form.elements[n].name.split('_');
                //alert(id[1]);
	          //cambios+=obtenerId(form.elements[n].name)+'|'+'dedededed'+'#';
              cambios+=id[1]+'|'+'dedededed'+'#';
	        }
	      }
	    }
           
            if(cambios==''){
              if(!existe){
                alert(document.forms['MensajeJS'].elements['NO_COME_PARA_BORRAR'].value);
              }
              else{
                alert(document.forms['MensajeJS'].elements['COME_PARA_BORRAR'].value);
              }
            }
            else{
              if(confirm(document.forms['MensajeJS'].elements['COME_SEL_BORRAR'].value))){
	        form.elements['CAMBIOS'].value=cambios;
	        form.elements['ACCION'].value=accion;
	        SubmitForm(form);
	      }
	    }
	  }
	  
      //comentario por defecto
        function GuardarPorDefecto(form, Defecto){
        
        var lung = document.forms['form1'].length;
      
	   for(var i=1; i<lung; i++){
        var formName=form.elements[i].name;
        
        if (formName.match('CHKDEFECTO')) {
        	//alert(form.elements[i].name)
        	form.elements[i].checked= false;
        }
       document.forms['form1'].elements['CHKDEFECTO_'+Defecto].checked= true;
       }
	  }//fin checkdefecto
      
      function GuardarDefecto(form){
      		form.action='/Compras/NuevaMultioferta/ComentarioDefectoSave.xsql';
            
            var lung = document.forms['form1'].length;
      		var Defecto='';
            var cadenaCome= '';
            
               for(var i=1; i<lung; i++){
                var formName=form.elements[i].name;
                
                if (formName.match('CHKDEFECTO')) {
                    //alert(form.elements[i].name);
                    cadenaCome
                    if (form.elements[i].checked==true){
                    	cadenaCome += form.elements[i].id+'#S|';
                    }
                    else{
                    	cadenaCome += form.elements[i].id+'#N|';
                        }
                }
               } 
               var lunCadena = cadenaCome.length;
               var OkCadenaCome = cadenaCome.substr(0,(lunCadena-1));
               form.elements['DEFECTO_SEL'].value=OkCadenaCome;
               //alert(OkCadenaCome);
	           SubmitForm(form);
      }//fin guardarDefecto