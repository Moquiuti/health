/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
function CreaPerfil(){
            document.forms[0].elements['NOMBRE_PERFIL'].value=document.forms[0].elements['NOMBRE_PERFIL_NUEVO'].value;
            document.forms[0].elements['IDUSUARIO'].value=document.forms[0].elements['IDUSUARIO_NUEVO'].value;
	    document.forms[0].elements['ACCION'].value='CREAR';
            SubmitForm(document.forms[0]);
	}
        
function BorrarSeleccion(idSeleccion){
	    document.forms[0].elements['ACCION'].value='BORRAR';
            document.forms[0].elements['IDSELECCION'].value=idSeleccion;
            SubmitForm(document.forms[0]);
	}

 function RecuperaSeleccion(idSeleccion){
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
                                            var id = data.Filtros[2].Registros[i].Registro.id;
                                            var idRegistro = data.Filtros[2].Registros[i].Registro.idRegistro;
                                            var nombreRegistro = data.Filtros[2].Registros[i].Registro.nombreRegistro;
                                            Registros += nombreRegistro +'\n';
                                            idRegistros += '|' + idRegistro;
                                            
					} 
				}
                                //alert('reg '+Registros);
                                //alert('idreg '+idRegistros);
                                jQuery("#mantSeleccion").show();
                                jQuery("#EMPRESAS").html(Resultados);
                                jQuery("#REGISTRO_SEL").html(Registros);
                                //jQuery("#ID_REGISTRO_SEL").html(idRegistros);
                                document.forms['Selecciones'].elements['ID_REGISTRO_SEL'].value = idRegistros;
                                
                                document.forms['Selecciones'].elements['SEL_NOMBRE'].value = nombreSel;
                                jQuery("#nombreSel").html(nombreSel);
                                document.forms['Selecciones'].elements['ID_SEL'].value = idSel;
                                document.forms['Selecciones'].elements['IDUSUARIO'].value = idUsuario;
                                document.forms['Selecciones'].elements['EXCLUIR'].value = excluir;
                                document.forms['Selecciones'].elements['SEL_PUBLICO'].value = selPublico;
                                if (tipo == 'Centros') { document.forms['Selecciones'].elements['TIPO'].value = 'CEN';}
                                if (tipo == 'Empresas') { document.forms['Selecciones'].elements['TIPO'].value = 'EMP';}
                                jQuery("#tipoSel").html(tipo);
           
		}
	}); //fin ajax
} //fin de RecuperaSeleccion

function AnadirEmpresaSel(){
    var id = jQuery("#EMPRESAS").val();
    var empresa = jQuery("#EMPRESAS option:selected").text();
    
    if (document.forms['Selecciones'].elements['ID_REGISTRO_SEL'].value.match(id)){ 
        alert(refYaInsertada); 
    }
    else{
        document.forms['Selecciones'].elements['ID_REGISTRO_SEL'].value += '|' + id;
        document.forms['Selecciones'].elements['REGISTRO_SEL'].value += empresa + '\n';
    }    
}

function ModificaSeleccion(){
	    document.forms['Selecciones'].elements['ACCION'].value='MODIFICA';
            document.forms['Selecciones'].elements['SELECCION'].value = document.forms['Selecciones'].elements['ID_REGISTRO_SEL'].value;
            //alert(document.forms['Selecciones'].elements['ID_REGISTRO_SEL'].value);
            SubmitForm(document.forms[0]);
	}



