/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

function globalEvents(){
        
        jQuery("#nuevaSel").click(function(){
            jQuery(".infoTable").hide();
            jQuery("#nuevaSeleccion").show();
        });
}

function verNuevaSel(){
    jQuery(".infoTable").hide();
    jQuery("#nuevaSeleccion").show();
    
}

function DevolverTipoSel(tipo){
	//alert(tipo);
        if (tipo == 'EMP'){ 
            jQuery("#CENTROS_NEW").hide(); 
            jQuery("#PROVEEDORES_NEW").hide(); 
            jQuery("#EMPRESAS_NEW").show(); 
        }
        else if (tipo == 'CEN'){ 
            jQuery("#PROVEEDORES_NEW").hide(); 
            jQuery("#EMPRESAS_NEW").hide(); 
            jQuery("#CENTROS_NEW").show();
            
        }
        else if (tipo == 'EMP2'){ 
            jQuery("#EMPRESAS_NEW").hide(); 
            jQuery("#CENTROS_NEW").hide(); 
            jQuery("#PROVEEDORES_NEW").show();
        }
      
        var id = jQuery("#REGISTRO_SEL_NEW").val();
        var text = jQuery("#REGISTRO_SEL_NEW option:selected").text();
        //alert(id +' '+text);
        var option = '<option value="'+id+'">'+text+'</option>';

        jQuery("#REGISTRO_SEL_NEW option:selected").remove();
        
        
}

function AnadirNuevaSel(){
   
    var registroSel = document.forms['Selecciones'].elements['ID_REGISTRO_SEL'].value;
    var option = '';
    //alert('mi '+registroSel);
    
    if (jQuery("#EMPRESAS_NEW").is(':visible')){ obj = document.forms['Selecciones'].elements['EMPRESAS_NEW']; }
    else if (jQuery("#CENTROS_NEW").is(':visible')){ obj = document.forms['Selecciones'].elements['CENTROS_NEW']; }
    else if (jQuery("#PROVEEDORES_NEW").is(':visible')){ obj = document.forms['Selecciones'].elements['PROVEEDORES_NEW']; }
    
            for (i=0; i<obj.options.length;i++){
                
                if (obj.options[i].selected == true){
                    var id = obj.options[i].value;
                    if (registroSel.match(id)){ }
                    else{
                        option += '<option value="'+obj.options[i].value+'">'+obj.options[i].text+'</option>';
                        registroSel += '|'+ obj.options[i].value;
                    }
                }
            }
            
       // alert('option final '+option);  
        
    if (document.forms['Selecciones'].elements['ID_REGISTRO_SEL'].value.match(id)){ 
        alert(refYaInsertada); 
    }
    else{  
        jQuery("#REGISTRO_SEL_NEW").append(option);
        document.forms['Selecciones'].elements['ID_REGISTRO_SEL'].value = registroSel;
    }     
}

function QuitarNuevaSel(){
    
    var id = jQuery("#REGISTRO_SEL_NEW").val();
    var text = jQuery("#REGISTRO_SEL_NEW option:selected").text();
    //alert(id +' '+text);
    var option = '<option value="'+id+'">'+text+'</option>';
   
    jQuery("#REGISTRO_SEL_NEW option:selected").remove();
    
}

function NuevaSeleccion(){
                
        document.forms['Selecciones'].elements['ACCION'].value='NUEVA';
            
            obj = document.forms['Selecciones'].elements['REGISTRO_SEL_NEW'];
            var registroSel = '';
            for (i=0; opt=obj.options[i];i++){
                registroSel += '|'+ obj.options[i].value;
                //alert(obj.options[i].value + 'mi');  
            }
            //alert(registroSel);
            document.forms['Selecciones'].elements['SELECCION'].value = registroSel;
            document.forms['Selecciones'].elements['TIPO'].value = document.forms['Selecciones'].elements['TIPO_NEW'].value;
            document.forms['Selecciones'].elements['SEL_NOMBRE'].value = document.forms['Selecciones'].elements['SEL_NOMBRE_NEW'].value;
            document.forms['Selecciones'].elements['ID_SEL'].value = '';
            document.forms['Selecciones'].elements['EXCLUIR'].value = '';
            if (document.forms['Selecciones'].elements['PUBLICO_NEW'].checked == false){
                document.forms['Selecciones'].elements['IDEMPRESA'].value = '';
            }
            
        var error='';  
        if (document.forms['Selecciones'].elements['SEL_NOMBRE'].value == ''){ error += nombreObli+'\n'; }
        if (document.forms['Selecciones'].elements['TIPO'].value == ''){ error += tipoObli+'\n'; }
        if (registroSel == ''){ error += elementosObli +'\n'; }
        
        if (error == ''){
            SubmitForm(document.forms[0]);
        }
        else{ alert(error); }
}
        
function BorrarSeleccion(idSeleccion){
	    document.forms[0].elements['ACCION'].value='BORRAR';
            document.forms[0].elements['IDSELECCION'].value=idSeleccion;
            SubmitForm(document.forms[0]);
	}

 function RecuperaSeleccion(idSeleccion){
     jQuery(".infoTable").hide();
     
	    jQuery.ajax({
		url:"http://www.newco.dev.br/Gestion/EIS/RecuperaSeleccionAjax.xsql",
		data: "IDSELECCION="+idSeleccion,
		type: "GET",
		contentType: "application/xhtml+xml",
            
		beforeSend:function(){ 
                    document.forms['Selecciones'].elements['ID_REGISTRO_SEL'].value = '';
                },
            
		error:function(objeto, quepaso, otroobj){
                    alert("objeto:"+objeto);
                    alert("otroobj:"+otroobj);
                    alert("quepaso:"+quepaso);
		},
		
                success:function(objeto){
                    var data = eval("(" + objeto + ")");
                    //alert('mi '+data.Filtros.Seleccion.nombreSel);
                    
                    var Resultados = new String('');
                    var Registros = new String('');
                    var idRegistros = new String('');

				if(data.Filtros[0].Empresas != ''){
					for(var i=0; i<data.Filtros[0].Empresas.length; i++){
                                            Resultados = Resultados+'<option value="'+data.Filtros[0].Empresas[i].Empresa.id+'">'+data.Filtros[0].Empresas[i].Empresa.nombre+'</option>';
                                            
					}                                      
					
				}
                                if(data.Filtros[1].Selecciones != ''){
					for(var i=0; i<data.Filtros[1].Selecciones.length; i++){
                                            var nombreSel = data.Filtros[1].Selecciones[i].Seleccion.nombreSel;
                                            var idSel = data.Filtros[1].Selecciones[i].Seleccion.idSel;
                                            var idUsuario = data.Filtros[1].Selecciones[i].Seleccion.idUsuario;
                                            var tipo = data.Filtros[1].Selecciones[i].Seleccion.tipo;
                                            var excluir = data.Filtros[1].Selecciones[i].Seleccion.excluir;
                                            var selPublico = data.Filtros[1].Selecciones[i].Seleccion.selPublico;
					} 
				}
                                if(data.Filtros[2].Registros != ''){
                                        for(var i=0; i<data.Filtros[2].Registros.length; i++){
                                            Registros = Registros+'<option value="'+data.Filtros[2].Registros[i].Registro.idRegistro+'">'+data.Filtros[2].Registros[i].Registro.nombreRegistro+'</option>';
                                            idRegistros = idRegistros + "|"+data.Filtros[2].Registros[i].Registro.idRegistro;
					/*for(var i=0; i<data.Filtros[2].Registros.length; i++){
                                            var id = data.Filtros[2].Registros[i].Registro.id;
                                            var idRegistro = data.Filtros[2].Registros[i].Registro.idRegistro;
                                            var nombreRegistro = data.Filtros[2].Registros[i].Registro.nombreRegistro;
                                            Registros += nombreRegistro +'\n';
                                            idRegistros += '|' + idRegistro;
                                            }*/
					} 
				}
                                //alert('reg '+Registros);
                                //alert('idreg '+idRegistros);
                                jQuery("#mantSeleccion").show();
                                jQuery("#EMPRESAS").html(Resultados);
                                jQuery("#REGISTRO_SEL").html(Registros);
                                jQuery("#ID_REGISTRO_SEL").html(idRegistros);
                                //jQuery("#ID_REGISTRO_SEL").html(idRegistros);
                                document.forms['Selecciones'].elements['ID_REGISTRO_SEL'].value = idRegistros;
                                document.forms['Selecciones'].elements['SEL_NOMBRE_MOD'].value = nombreSel;
                                document.forms['Selecciones'].elements['ID_SEL'].value = idSel;
                                document.forms['Selecciones'].elements['IDUSUARIO'].value = idUsuario;
                                document.forms['Selecciones'].elements['EXCLUIR'].value = excluir;
                                if (selPublico == 'S'){ document.forms['Selecciones'].elements['PUBLICO_MOD'].checked = true; }
                                document.forms['Selecciones'].elements['SEL_PUBLICO'].value = selPublico;
                                if (tipo == 'Centros') { document.forms['Selecciones'].elements['TIPO'].value = 'CEN';}
                                if (tipo == 'Empresas') { document.forms['Selecciones'].elements['TIPO'].value = 'EMP';}
                                if (tipo == 'Proveedores') { document.forms['Selecciones'].elements['TIPO'].value = 'EMP2';}
                                
                                jQuery("#tipoSel").html(tipo);
           
		}
	}); //fin ajax
} //fin de RecuperaSeleccion

function AnadirEmpresaSel(){
   
    var registroSel = document.forms['Selecciones'].elements['ID_REGISTRO_SEL'].value;
    var option = '';
    //alert('mi '+registroSel);
        
    obj = document.forms['Selecciones'].elements['EMPRESAS'];  
        
            //for (i=0; opt=obj.options[i];i++){
            for (i=0; i<obj.options.length;i++){
                
                if (obj.options[i].selected == true){
                    var id = obj.options[i].value;
                    if (registroSel.match(id)){ }
                    
                    else{
                        option += '<option value="'+obj.options[i].value+'">'+obj.options[i].text+'</option>';
                        registroSel += '|'+ obj.options[i].value;
                    }
                }
            }
            
       // alert('option final '+option);  
        
    /*if (document.forms['Selecciones'].elements['ID_REGISTRO_SEL'].value.match(id)){ 
        alert(refYaInsertada); 
    }
    else{ }   */
        jQuery("#REGISTRO_SEL").append(option);
        document.forms['Selecciones'].elements['ID_REGISTRO_SEL'].value = registroSel;
       
}

function QuitarEmpresaSel(){
    
    var id = jQuery("#REGISTRO_SEL").val();
    var text = jQuery("#REGISTRO_SEL option:selected").text();
    //alert(id +' '+text);
    var option = '<option value="'+id+'">'+text+'</option>';
   
    jQuery("#REGISTRO_SEL option:selected").remove();
    
}

function ModificaSeleccion(){
	    document.forms['Selecciones'].elements['ACCION'].value='MODIFICA';
            document.forms['Selecciones'].elements['SEL_NOMBRE'].value = document.forms['Selecciones'].elements['SEL_NOMBRE_MOD'].value;
            
            if (document.forms['Selecciones'].elements['PUBLICO_MOD'].checked == false){
                document.forms['Selecciones'].elements['IDEMPRESA'].value = '';
            }
           
            obj = document.forms['Selecciones'].elements['REGISTRO_SEL'];
            var registroSel = '';
            for (i=0; opt=obj.options[i];i++){
                registroSel += '|'+ obj.options[i].value;
                //alert(obj.options[i].value + 'mi');  
            }
            //alert(registroSel);
            document.forms['Selecciones'].elements['SELECCION'].value = registroSel;
            SubmitForm(document.forms[0]);
	}



