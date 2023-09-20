//	JS Selecciones/agrupaciones para consultas
//	Ultima revisión: ET 27may19 09:19

function globalEvents(){

        jQuery("#nuevaSel").click(function(){
			jQuery("#nuevaSeleccion").show();
			jQuery("#mantSeleccion").hide();
        });
}

function verNuevaSel(){
	jQuery("#nuevaSeleccion").show();
	jQuery("#mantSeleccion").hide();
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

//19ago16 ET Buscamos en un select un elemento por su id, devuelve su posición o -1
function BuscarEnSelect(obj, id){
	var pos=-1;
	
	for (i=0; i<obj.options.length;i++){
		if (obj.options[i].value==id) pos=i;
		alert('Buscar '+id+'valor:'+obj.options[i].value+' texto:'+obj.options[i].text+' encontrado en pos:'+i);
	}
	return pos;
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
	
    if (document.forms['Selecciones'].elements['ID_REGISTRO_SEL'].value.match(id)){
        alert(refYaInsertada);
    }
    else{
        jQuery("#REGISTRO_SEL_NEW").append(option);
        document.forms['Selecciones'].elements['ID_REGISTRO_SEL'].value = registroSel;
    }
}
/*
function QuitarNuevaSel_debug(){

    var id = jQuery("#REGISTRO_SEL_NEW").val();
    var text = jQuery("#REGISTRO_SEL_NEW option:selected").text();
    //alert(id +' '+text);
    
	//ET19ago16	var option = '<option value="'+id+'">'+text+'</option>';

    jQuery("#REGISTRO_SEL_NEW option:selected").remove();


	//COntrol de que se haya borrado bien, SOLODEBUG	
	var obj = document.forms['Selecciones'].elements['REGISTRO_SEL_NEW'];
	var textdebug	='Elementos:';
    for (i=0; i<obj.options.length;i++){
		textdebug=textdebug+obj.options[i].value+'.\n\r';
	}
	if (BuscarEnSelect(document.forms['Selecciones'].elements['REGISTRO_SEL_NEW'], id)>=0)
	{
		textdebug=textdebug+'.LO SIGUE ENCONTRANDO!\n\r';
	}
	
	alert(textdebug);

}
*/
//19ago16 Falta reconstruir la cadena de elementos en la lista de seleccion
function QuitarNuevaSel(){

    var id = jQuery("#REGISTRO_SEL_NEW").val();
    var text = jQuery("#REGISTRO_SEL_NEW option:selected").text();
    //alert(id +' '+text);
    
	jQuery("#REGISTRO_SEL_NEW option:selected").remove();
    jQuery("#REGISTRO_SEL_NEW option[value="+id+"]").remove();
	
	
	//19ago16
	obj=document.forms['Selecciones'].elements['REGISTRO_SEL_NEW'];
	var registroSel='';
    for (i=0; i<obj.options.length;i++){
	    registroSel += '|'+ obj.options[i].value;
    }
	document.forms['Selecciones'].elements['ID_REGISTRO_SEL'].value = registroSel;
}


function NuevaSeleccion()
{
	var Estado='';

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

	//	19ago16 Solo comprobamos los checkboxes para AdminMVM
	if (document.forms['Selecciones'].elements['ADMINMVM'].value=='S'){
	
    	if (document.forms['Selecciones'].elements['CHK_PUBLICO'].checked === true){
        	document.forms['Selecciones'].elements['IDEMPRESA'].value = '';
    	}
		else
        	document.forms['Selecciones'].elements['IDEMPRESA'].value = document.forms['Selecciones'].elements['IDEMPRESALISTA'].value;
		
    	if (document.forms['Selecciones'].elements['TODOS_ADMIN_NU'].checked === true){
    	  document.forms['Selecciones'].elements['TODOS_ADMIN'].value = 'S';
    	}else{
    	  document.forms['Selecciones'].elements['TODOS_ADMIN'].value = 'N';
    	}
    	if (document.forms['Selecciones'].elements['CHK_AUTORIZADOS'].checked === true){
    	  document.forms['Selecciones'].elements['AUTORIZADOS'].value = 'S';
    	}else{
    	  document.forms['Selecciones'].elements['AUTORIZADOS'].value = 'N';
    	}
    	if (document.forms['Selecciones'].elements['CHK_EXCLUIDOS'].checked === true){
    	  document.forms['Selecciones'].elements['EXCLUIDOS'].value = 'S';
    	}else{
    	  document.forms['Selecciones'].elements['EXCLUIDOS'].value = 'N';
    	}
	}else{
	  document.forms['Selecciones'].elements['TODOS_ADMIN'].value = 'N';
	  document.forms['Selecciones'].elements['AUTORIZADOS'].value = 'N';
	  document.forms['Selecciones'].elements['EXCLUIDOS'].value = 'N';
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

function RecuperaSeleccion(idSeleccion)
{

	var nombreSel, idSel, idUsuario, tipo, excluir, selPublico, todosAdmin, Autorizados, Excluidos;
	jQuery("#nuevaSeleccion").hide();

	jQuery.ajax
	({
		url:"http://www.newco.dev.br/Gestion/EIS/RecuperaSeleccionAjax.xsql",
		data: "IDSELECCION="+idSeleccion,
		type: "GET",
		contentType: "application/xhtml+xml",

		beforeSend:function()
		{
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
                nombreSel = data.Filtros[1].Selecciones[i].Seleccion.nombreSel;
                idSel = data.Filtros[1].Selecciones[i].Seleccion.idSel;
                idUsuario = data.Filtros[1].Selecciones[i].Seleccion.idUsuario;
                idtipo = data.Filtros[1].Selecciones[i].Seleccion.idtipo;
                tipo = data.Filtros[1].Selecciones[i].Seleccion.tipo;
                excluir = data.Filtros[1].Selecciones[i].Seleccion.excluir;
                selPublico = data.Filtros[1].Selecciones[i].Seleccion.selPublico;
                todosAdmin = data.Filtros[1].Selecciones[i].Seleccion.todosAdmin;
                Autorizados = data.Filtros[1].Selecciones[i].Seleccion.Autorizados;
                Excluidos = data.Filtros[1].Selecciones[i].Seleccion.Excluidos;
			}
		}
        if(data.Filtros[2].Registros != ''){
            for(var i=0; i<data.Filtros[2].Registros.length; i++){
                Registros = Registros+'<option value="'+data.Filtros[2].Registros[i].Registro.idRegistro+'">'+data.Filtros[2].Registros[i].Registro.nombreRegistro+'</option>';
                idRegistros = idRegistros + "|"+data.Filtros[2].Registros[i].Registro.idRegistro;
			}
		}

        jQuery("#EMPRESAS").html(Resultados);
        jQuery("#mantSeleccion").show();
        jQuery("#REGISTRO_SEL").html(Registros);
        jQuery("#ID_REGISTRO_SEL").html(idRegistros);

        document.forms['Selecciones'].elements['ID_REGISTRO_SEL'].value = idRegistros;
        document.forms['Selecciones'].elements['SEL_NOMBRE_MOD'].value = nombreSel;
        document.forms['Selecciones'].elements['ID_SEL'].value = idSel;
        document.forms['Selecciones'].elements['IDUSUARIO'].value = idUsuario;
        document.forms['Selecciones'].elements['EXCLUIR'].value = excluir;
		document.forms['Selecciones'].elements['TIPO'].value  = idtipo;

		//solodebug	console.log("RecuperaSeleccion. Tipo:"+idtipo+'/'+document.forms['Selecciones'].elements['TIPO'].value);

		//	control derechos solo para Admin
		if (document.forms['Selecciones'].elements['ADMINMVM'].value=='S')
		{
            if (selPublico == 'S'){ document.forms['Selecciones'].elements['CHK_PUBLICO_MOD'].checked = true; }
            document.forms['Selecciones'].elements['SEL_PUBLICO'].value = selPublico;
            if (todosAdmin == '1'){ document.forms['Selecciones'].elements['TODOS_ADMIN_MOD'].checked = true; }
            document.forms['Selecciones'].elements['TODOS_ADMIN'].value = todosAdmin;
            if (Autorizados == 'S'){ document.forms['Selecciones'].elements['CHK_AUTORIZADOS_MOD'].checked = true; }
            document.forms['Selecciones'].elements['AUTORIZADOS'].value = Autorizados;
            if (Excluidos == 'S'){ document.forms['Selecciones'].elements['CHK_EXCLUIDOS_MOD'].checked = true; }
            document.forms['Selecciones'].elements['EXCLUIDOS'].value = Excluidos;
		}

        jQuery("#tipoSel").html(tipo);

		}
	}); //fin ajax
} //fin de RecuperaSeleccion

function AnadirEmpresaSel(){

    var registroSel = document.forms['Selecciones'].elements['ID_REGISTRO_SEL'].value;
    var option = '';

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

    if (document.forms['Selecciones'].elements['CHK_PUBLICO_MOD'].checked === true){
        document.forms['Selecciones'].elements['IDEMPRESA'].value = '';
    }
	else
       	document.forms['Selecciones'].elements['IDEMPRESA'].value = document.forms['Selecciones'].elements['IDEMPRESALISTA'].value;

    if (document.forms['Selecciones'].elements['TODOS_ADMIN_MOD'].checked === true){
        document.forms['Selecciones'].elements['TODOS_ADMIN'].value = 'S';
    }else{
        document.forms['Selecciones'].elements['TODOS_ADMIN'].value = 'N';
    }

    if (document.forms['Selecciones'].elements['CHK_AUTORIZADOS_MOD'].checked === true){
      document.forms['Selecciones'].elements['AUTORIZADOS'].value = 'S';
    }else{
      document.forms['Selecciones'].elements['AUTORIZADOS'].value = 'N';
    }
    if (document.forms['Selecciones'].elements['CHK_EXCLUIDOS_MOD'].checked === true){
      document.forms['Selecciones'].elements['EXCLUIDOS'].value = 'S';
    }else{
      document.forms['Selecciones'].elements['EXCLUIDOS'].value = 'N';
    }


    obj = document.forms['Selecciones'].elements['REGISTRO_SEL'];
    var registroSel = '';
    for (i=0; opt=obj.options[i];i++){
        registroSel += '|'+ obj.options[i].value;
        //alert(obj.options[i].value + 'mi');
    }

    document.forms['Selecciones'].elements['SELECCION'].value = registroSel;
    SubmitForm(document.forms[0]);
}


function DescargarExcel(){
	var form=document.forms[0];
    var cadEmpresa='';
	
	if (document.forms['Selecciones'].elements['ADMINMVM'].value=='S')
	{
		cadEmpresa='?IDEMPRESA='+document.forms['Selecciones'].elements['IDEMPRESALISTA'].value;
	}
	
	
	var d = new Date();

	jQuery.ajax({
		cache:	false,
		url:	'EISSeleccionesExcel.xsql'+cadEmpresa,
		type:	"GET",
		data:	"d="+d.getTime(),
		contentType: "application/xhtml+xml",
		error: function(objeto, quepaso, otroobj)
		{
			alert('error'+quepaso+' '+otroobj+''+objeto);
		},
		success: function(objeto)
		{
			var data = eval("(" + objeto + ")");

            if(data.estado == 'ok') window.location='http://www.newco.dev.br/Descargas/'+data.url;
            else alert('Se ha producido un error. No se puede descargar el fichero.');
        }
	});
}


//	Comprueba cambios necesarios tras activar/desactivar botón de autorizados/excluidos
function AutorizadosYExcluidos(control)
{
	var Activado=false;
	
	//	Comprueba si son los controles de nuevo o modificacion
	var nombre=Piece(control,'_',1);
	var isMod=Piece(control,'_',2);
	
	isMod=((isMod=='')?'':'_')+isMod;
	
	//solodebug	console.log('AutorizadosYExcluidos. control:'+control+' nombre:'+nombre+' isMod:'+isMod);
	
	
    if (document.forms['Selecciones'].elements['CHK_'+nombre+isMod].checked === true)
	{
		Activado=true;
	}
	
	if ((Activado === true) && (document.forms['Selecciones'].elements['CHK_PUBLICO'+isMod].checked === true))
	{
		document.forms['Selecciones'].elements['CHK_PUBLICO'+isMod].checked = false;
	}

	if ((nombre==='AUTORIZADOS') && (document.forms['Selecciones'].elements['CHK_EXCLUIDOS'+isMod].checked === true))
	{
		document.forms['Selecciones'].elements['CHK_EXCLUIDOS'+isMod].checked = false;
	}
	else if ((nombre==='EXCLUIDOS') && (document.forms['Selecciones'].elements['CHK_AUTORIZADOS'+isMod].checked === true))
	{
		document.forms['Selecciones'].elements['CHK_AUTORIZADOS'+isMod].checked = false;
	}
	
}

//	COmprueba cambios tras desactivar botón de "Publico"
function chkPublico(control)
{
	
	//solodebug	console.log('chkPublico. control:'+control);
	
    if (document.forms['Selecciones'].elements[control].checked === true)
	{
		console.log('chkPublico. control:'+control+' checked');
		if (control==='CHK_PUBLICO_MOD')
		{
			document.forms['Selecciones'].elements['CHK_EXCLUIDOS_MOD'].checked = false;
			document.forms['Selecciones'].elements['CHK_AUTORIZADOS_MOD'].checked = false;
		}
		else
		{
			document.forms['Selecciones'].elements['CHK_EXCLUIDOS'].checked = false;
			document.forms['Selecciones'].elements['CHK_AUTORIZADOS'].checked = false;
		}
	}
}

//	24may19 Cambio en el desplegable de la empresa
function CambioEmpresa()
{
	document.forms['Selecciones'].elements['ACCION'].value='CAMBIOEMPRESA';
   	document.forms['Selecciones'].elements['IDEMPRESA'].value = document.forms['Selecciones'].elements['IDEMPRESALISTA'].value;
    SubmitForm(document.forms[0]);
}





