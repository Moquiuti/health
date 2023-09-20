//	Última revisión: 21may12

                        //checkbox desplegable empresa
                        function soloClientes(oForm){
                            if (oForm.elements['SOLO_CLIENTES_CK'].checked == true){
                                oForm.elements['SOLO_PROVEE_CK'].checked = false;
                            }
                            DesplegableEmpresa(oForm);
                        }
                        function soloProvee(oForm){
                            if (oForm.elements['SOLO_PROVEE_CK'].checked == true){
                                oForm.elements['SOLO_CLIENTES_CK'].checked = false;
                            }
                            DesplegableEmpresa(oForm);
                        }
                        function DesplegableEmpresa(oForm){

                                if (oForm.elements['SOLO_PROVEE_CK'].checked == true){
                                    oForm.elements['SOLO_PROVEE'].value = 'S';
                                    oForm.elements['SOLO_CLIENTES'].value = 'N';
                                }
                                if (oForm.elements['SOLO_CLIENTES_CK'].checked == true){
                                    oForm.elements['SOLO_PROVEE'].value = 'N';
                                    oForm.elements['SOLO_CLIENTES'].value = 'S';
                                }

                                if (oForm.elements['IDEMPRESA'].value != ''){ var idEmpresa = encodeURIComponent(oForm.elements['IDEMPRESA'].value); }
                                else { var idEmpresa  = '-1';}

				var marca	 = 'EMPRESAS';
				var nombreCampo	 = 'FIDEMPRESA';
        var IDEmpresaUsuario = oForm.elements['IDEMPRESAUSUARIO'].value;
        var idPais	 = oForm.elements['IDPAIS'].value;
				var soloClientes = oForm.elements['SOLO_CLIENTES'].value;
        var soloProvee	 = oForm.elements['SOLO_PROVEE'].value;

				jQuery.ajax({
					cache:	false,
					url:	'http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/DesplegableEmpresa.xsql',
					type:	"GET",
					data:	"MARCA="+marca+"&NOMBRECAMPO="+nombreCampo+"&IDPAIS="+idPais+"&IDEMPRESA="+idEmpresa+"&SOLO_CLIENTES="+soloClientes+"&SOLO_PROVEE="+soloProvee+"&IDEMPRESAUSUARIO="+IDEmpresaUsuario,
					contentType: "application/xhtml+xml",
					success: function(objeto){
						var data = eval("(" + objeto + ")");
                                                var Resultados = new String('');

                                                if(data.Filtros != ''){
                                                        for(var i=0; i<data.Filtros.length; i++){
                                                                if(i==1){
                                                                        var Doc_ID_Actual	= data.Filtros[i].Fitro.id;
                                                                        var File_ID_Actual	= data.Filtros[i].Fitro.file;
                                                                }
                                                                Resultados = Resultados+'<option value="'+data.Filtros[i].Fitro.id+'">'+data.Filtros[i].Fitro.nombre+'</option>';
                                                        }
                                                    }
                                                        jQuery("#FIDEMPRESA").html(Resultados);
                                                        jQuery("#FIDEMPRESA").val(Doc_ID_Actual);
                                                        //CambiarEmpresa();

					},
					error: function(xhr, errorString, exception) {
						//alert("xhr.status="+xhr.status+" error="+errorString+" exception="+exception);
					}
				});
			}


function CambiarEmpresa(){

        //alert(document.forms[0].elements["FESTADO"].value);
	//alert('EnviarTareas: '+document.forms[0].elements["ACCION"].value+':'+document.forms[0].elements["PARAMETROS"].value);		//	para pruebas
        document.forms['Admin'].method="post";
        document.forms['Admin'].action="Tareas.xsql";
	document.forms['Admin'].submit();
}

function CambiarEmpresaID(idEmpresa){

        document.forms['Admin'].elements["FIDEMPRESA"].value = idEmpresa;
        document.forms['Admin'].method="post";
        document.forms['Admin'].action="Tareas.xsql";
	document.forms['Admin'].submit();
}

function RecuperarCentros(){
    var idEmp = document.forms['Admin'].elements["FIDEMPRESA"].value;

    jQuery.ajax({
					url:	'http://www.newco.dev.br/Gestion/Comercial/RecuperaCentrosAJAX.xsql',
					type:	"GET",
					data:	"IDEMPRESA="+idEmp,
					contentType:	"application/xhtml+xml",
					success: function(objeto){
						var data = eval("(" + objeto + ")");
                                                var Resultados = new String('');

                                                if(data.ListaCentros != ''){
                                                        for(var i=0; i<data.ListaCentros.length; i++){
                                                                Resultados = Resultados+'<option value="'+data.ListaCentros[i].Centro.ID+'">'+data.ListaCentros[i].Centro.Nombre+'</option>';
                                                        }
                                                    }
                                                        jQuery("#FIDCENTRO").html(Resultados);
                                                        jQuery(".centroBox").show();
                                                        jQuery("#IDCENTRO").html(Resultados);

					},
					error: function(xhr, errorString, exception) {
						alert("xhr.status="+xhr.status+" error="+errorString+" exception="+exception);
					}
				});


}


function VerMasTareas()
{
	if ( jQuery(".masTareas").is (':visible')){
		jQuery(".masTareas").hide();
	}
	else { jQuery(".masTareas").show(); }

}
//en onload enseño las tareas recientes, si lo hago desde codigo no funciona
function TareasRecientes()
{
//console.log("Inicio TareasRecientes: " + (new Date() - start));
	jQuery(".oculto").hide();
	jQuery(".noOculto").show();
//console.log("Fin TareasRecientes: " + (new Date() - start));
}

//	Ver todas tareas
function VerTareas()
{
	if ( jQuery(".subTareasTot").is (':visible')){
		jQuery(".subTareasTot").hide();
	}
	else { jQuery(".subTareasTot").show(); }

}

//	Abrir subtareas desde padre
function AbrirSubTareas(idpadre)
{

	if ( jQuery(".subtarea_"+idpadre).is (':visible')){
		jQuery(".subtarea_"+idpadre).hide();
	}
	else { jQuery(".subtarea_"+idpadre).show(); }

}

//	Envía el formulario
function EnviarTareas(){

        /*if (document.forms['Admin'].elements["IDEMPRESA"].value != ''){
            var idEmp = document.forms['Admin'].elements["IDEMPRESA"].value;
            document.forms['Admin'].action = 'Tareas.xsql?IDEMPRESA='+idEmp;
        }
        alert(document.forms['Admin'].action);*/
	//alert('EnviarTareas: '+document.forms['Admin'].elements["ACCION"].value+':'+document.forms['Admin'].elements["PARAMETROS"].value);		//	para pruebas


	document.forms['Admin'].submit();
}

//	Asigna acción y envía formulario
function Accion(Tipo)
{
	document.forms['Admin'].elements["ACCION"].value=Tipo;
	document.forms['Admin'].elements["PARAMETROS"].value='';

	EnviarTareas();
}

//	Busca ID, asigna acción y envía formulario
function BorrarGestion(IDGestion, subtareas)
{
	//alert(subtareas);
	if (subtareas == '0' || subtareas == ''){
		document.forms['Admin'].elements["ACCION"].value='BORRAR';
		document.forms['Admin'].elements["PARAMETROS"].value=IDGestion;

		if (IDGestion!='') EnviarTareas();
		else alert(document.forms['mensajeJS'].elements['FALTA_INFORMAR_GESTION_BORRAR'].value);
	}
	else { if (confirm(document.forms['mensajeJS'].elements['BORRAR_TAREAS_SUBTAREAS'].value)){
				if (IDGestion!='') EnviarTareas();
			}
		}
}


//	Nueva gestión
function NuevaGestion()
{
	var msg='';

	if (document.forms['Admin'].elements['FECHALIMITE'].value =='')
		msg+=document.forms['mensajeJS'].elements['FECHA_LIMITE_OBLI'].value+'\n';

	if (document.forms['Admin'].elements['FECHALIMITE'].value!='')
		if (CheckDate(document.forms['Admin'].elements['FECHALIMITE'].value)!='')
			msg+=document.forms['mensajeJS'].elements['FORMATO_FECHA_LIMITE_NO_OK'].value+'\n';

	if (document.forms['Admin'].elements["TEXTO"].value=='')
		msg+=document.forms['mensajeJS'].elements['FALTA_INFORMAR_DESCRIPCION'].value+'\n';

	if (msg!='')
		alert(msg);
	else
	{
            //si no existe centro no puedo crear entrada
            if (document.forms['Admin'].elements["IDCENTRO"].value != '-1'){

		document.forms['Admin'].elements["ACCION"].value='NUEVO';
		document.forms['Admin'].elements["PARAMETROS"].value='|'+document.forms['Admin'].elements["IDPADRE"].value
														+'|'+document.forms['Admin'].elements["IDRESPONSABLE"].value
														+'|'+document.forms['Admin'].elements["IDEMPRESA"].value
                                                                                                                +'|'+document.forms['Admin'].elements["IDCENTRO"].value
														+'|'+document.forms['Admin'].elements["FECHALIMITE"].value
                                                                                                                +'|'+document.forms['Admin'].elements["IDTIPO"].value
														+'|'+document.forms['Admin'].elements["TEXTO"].value				//	único obligatorio
														+'|'+document.forms['Admin'].elements["PRIORIDAD"].value
														+'|'+document.forms['Admin'].elements["ESTADO"].value
                                                                                                                +'|'+document.forms['Admin'].elements["VISIBILIDAD"].value;
                //alert('emp'+document.forms['Admin'].elements["IDCENTRO"].value);
                //alert('mi'+document.forms['Admin'].elements["PARAMETROS"].value);

		EnviarTareas();
            }
            else { alert(crearCentro); }
	}
}



//	Modificar gestión
function ModificarGestion(IDGestion)
{
	var msg='';

	if (document.forms['Admin'].elements['FECHALIMITE_'+IDGestion].value!='')
	{
		if (CheckDate(document.forms['Admin'].elements['FECHALIMITE_'+IDGestion].value)!='')
			msg=document.forms['mensajeJS'].elements['FORMATO_FECHA_LIMITE_NO_OK'].value;
	}

	if ((IDGestion=='')||(document.forms['Admin'].elements["TEXTO_"+IDGestion].value==''))
		msg=document.forms['mensajeJS'].elements['FALTA_INFORMAR_GESTION_MODIFICAR'].value;

	if (msg!='')
		alert(msg);
	else
	{
		document.forms['Admin'].elements["ACCION"].value='MODIFICAR';
		document.forms['Admin'].elements["PARAMETROS"].value=IDGestion+'|'+document.forms['Admin'].elements["IDPADRE_"+IDGestion].value				//	obligatorio
														+'|'+document.forms['Admin'].elements["IDRESPONSABLE_"+IDGestion].value
														+'|'+document.forms['Admin'].elements["IDEMPRESA_"+IDGestion].value
                                                                                                                +'|'+document.forms['Admin'].elements["IDCENTRO_"+IDGestion].value
														+'|'+document.forms['Admin'].elements["FECHALIMITE_"+IDGestion].value
                                                                                                                +'|'+document.forms['Admin'].elements["TIPO_"+IDGestion].value
														+'|'+document.forms['Admin'].elements["TEXTO_"+IDGestion].value				//	obligatorio
														+'|'+document.forms['Admin'].elements["PRIORIDAD_"+IDGestion].value
														+'|'+document.forms['Admin'].elements["ESTADO_"+IDGestion].value
                                                                                                                +'|'+document.forms['Admin'].elements["VISIBILIDAD_"+IDGestion].value;

		EnviarTareas();
	}
}




//	Insertar gestión (subtarea)
function Subtarea(IDGestion)
{
	var msg='';

	if (document.forms['Admin'].elements['FECHALIMITE_'+IDGestion].value!='')
	{
		if (CheckDate(document.forms['Admin'].elements['FECHALIMITE_'+IDGestion].value)!='')
			msg=document.forms['mensajeJS'].elements['FORMATO_FECHA_LIMITE_NO_OK'].value;
	}

	if ((IDGestion=='')&&(document.forms['Admin'].elements["TEXTO_"+IDGestion].value==''))
		msg=document.forms['mensajeJS'].elements['FALTA_INFORMAR_GESTION_MODIFICAR'].value;

	if (msg!='')
		alert(msg);
	else
	{

		var IDPadre=document.forms['Admin'].elements["IDPADRE_"+IDGestion].value;
		if (IDPadre=='') IDPadre=IDGestion;

		document.forms['Admin'].elements["ACCION"].value='SUBTAREA';
		document.forms['Admin'].elements["PARAMETROS"].value='|'+IDPadre				//	obligatorio
														+'|'	//+document.forms['Admin'].elements["IDRESPONSABLE_"+IDGestion].value
														+'|'+document.forms['Admin'].elements["IDEMPRESA_"+IDGestion].value
														+'|'+document.forms['Admin'].elements["FECHALIMITE_"+IDGestion].value
                                                                                                                +'|'+document.forms['Admin'].elements["TIPO_"+IDGestion].value
														+'|'+document.forms['Admin'].elements["TEXTO_"+IDGestion].value				//	obligatorio
														+'|'+document.forms['Admin'].elements["PRIORIDAD_"+IDGestion].value
														+'|'+document.forms['Admin'].elements["ESTADO_"+IDGestion].value;

		EnviarTareas();
	}
}


function EditarGestion(IDGestion){
  var d = new Date();

  jQuery.ajax({
    url:"http://www.newco.dev.br/Gestion/Comercial/TareaAJAX.xsql",
    data: "IDGESTION="+IDGestion+"&_="+d.getTime(),
    type: "GET",
    async: false,
    contentType: "application/xhtml+xml",
    beforeSend:function(){
      null;
    },
    error:function(objeto, quepaso, otroobj){
      alert("objeto:"+objeto);
      alert("otroobj:"+otroobj);
      alert("quepaso:"+quepaso);
    },
    success:function(objeto){
      var data=eval("(" + objeto + ")");

      if(data.Tarea.Error){
        // No se han encontrado datos
        alert(no_hay_datos);
      }else{

        jQuery('#EG_Fecha').html(data.Tarea.Fecha);
        jQuery('#EG_Autor').html(data.Tarea.Autor);
        jQuery('#EG_Responsable').html(data.Tarea.Responsable);
        jQuery.each(data.Tarea.Empresas, function(index, empresa){
          jQuery('#EG_Empresa').append(jQuery("<option />").val(empresa.ID).text(empresa.Nombre));
        });
        jQuery('#EG_Empresa').val(data.Tarea.IDEmpresa);
/*
        jQuery.each(data.Tarea.Centros, function(index, centro){
          jQuery('#EG_Centro').append(jQuery("<option />").val(centro.ID).text(centro.Nombre));
        });
        jQuery('#EG_Centro').val(data.Tarea.IDCentro);
*/
        jQuery.each(data.Tarea.Tipos, function(index, tipo){
          jQuery('#EG_Tipo').append(jQuery("<option />").val(tipo.ID).text(tipo.Nombre));
        });
        jQuery('#EG_Tipo').val(data.Tarea.IDTipo);
        jQuery('input[name="EG_VISIBILIDAD"][value="' + data.Tarea.Visibilidad + '"]').prop('checked', true);
        jQuery('#EG_Descripcion').html(data.Tarea.Texto);
        jQuery('#EG_FechaLimite').val(data.Tarea.FechaLimite);
        jQuery.each(data.Tarea.Estados, function(index, estado){
          jQuery('#EG_Estado').append(jQuery("<option />").val(estado.ID).text(estado.Nombre));
        });
        jQuery('#EG_Estado').val(data.Tarea.IDEstado);
        jQuery.each(data.Tarea.Prioridades, function(index, prioridad){
          jQuery('#EG_Prioridad').append(jQuery("<option />").val(prioridad.ID).text(prioridad.Nombre));
        });
        jQuery('#EG_Prioridad').val(data.Tarea.IDPrioridad);

        showTablaByID("EditarGestionWrap");
      }
    }
  });
}
