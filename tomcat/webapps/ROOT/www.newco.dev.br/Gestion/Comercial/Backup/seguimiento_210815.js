//	Última revisión: 11jun12

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
        var idPais	 = encodeURIComponent(oForm.elements['IDPAIS'].value);
				var soloClientes = encodeURIComponent(oForm.elements['SOLO_CLIENTES'].value);
        var soloProvee	 = encodeURIComponent(oForm.elements['SOLO_PROVEE'].value);

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


//	Mostrar otra empresa, solo llama a Enviar sin ninguna acción
function CambiarEmpresa(){

        //document.forms['form1'].elements["FIDEMPRESA"].value = idEmp;
        document.forms['form1'].method="post";
        document.forms['form1'].action="Seguimiento.xsql";


	SubmitForm(document.forms['form1']);
}

function CambiarEmpresaID(idEmpresa){

        document.forms['form1'].elements["FIDEMPRESA"].value = idEmpresa;
        document.forms['form1'].method="post";
        document.forms['form1'].action="Seguimiento.xsql";

	SubmitForm(document.forms['form1']);
}
//para la modifica recupero texto en lugar de br pongo \n
function RecuperaBienText(){
    var form = document.forms['form1'];

    for (var i=0;i<form.length;i++){
        var nameCampo = form.elements[i].name.substring(0, 6);
        //alert(nameCampo);
        if (nameCampo == 'TEXTO_'){
            var idCampo = form.elements[i].name;
            //alert(idCampo);
            jQuery("#"+idCampo).html(jQuery("#"+idCampo).text().replace(/<br>/gi,'\n'));
        }
    }
   //if(jQuery(".textModificable").length > 0)        jQuery(".textModificable").html(jQuery(".textModificable").text().replace(/<br>/gi,'\n'));
}

function RecuperarCentros(){
    var idEmp = document.forms['form1'].elements["FIDEMPRESA"].value;

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
//	Envía el formulario
function Enviar()
{
	//alert(document.forms[0].elements["ACCION"].value+':'+document.forms[0].elements["PARAMETROS"].value);
	SubmitForm(document.forms['form1']);
}

//	Nueva entrada de seguimiento
function Nueva(){

        var msg = '';
        if (jQuery("#TEXTO").length>0) jQuery("#TEXTO").html(jQuery("#TEXTO").text().replace(/<br \/>/gi,'\n'));

        document.forms['form1'].elements["TEXTO"].value = jQuery("#TEXTO").val();

        //alert(document.forms[0].elements["TEXTO"].value);
        //alert(document.forms['form1'].elements["VISIBILIDAD"].value);

        if (document.forms['form1'].elements["IDCENTRO"].value != '-1' && document.forms['form1'].elements["TEXTO"].value != ''){

            document.forms['form1'].elements["ACCION"].value='NUEVA';
            document.forms['form1'].elements["PARAMETROS"].value='|'+document.forms['form1'].elements["IDCENTRO"].value+'|'+document.forms['form1'].elements["TIPO"].value+'|'+document.forms['form1'].elements["TEXTO"].value+'|'+document.forms['form1'].elements["VISIBILIDAD"].value;

            //alert('param '+document.forms['form1'].elements["PARAMETROS"].value);

            Enviar();
        }
        else{
            if (document.forms['form1'].elements["TEXTO"].value == ''){
                msg += textoObli + '\n';
            }
            if (document.forms['form1'].elements["IDCENTRO"].value == '-1'){
                msg += crearCentro;
            }
            alert(msg);
        }
}

function Modificar(IDRegistro)
{
	document.forms['form1'].elements["ACCION"].value='MODIFICAR';

	document.forms['form1'].elements["PARAMETROS"].value=IDRegistro+'|'+document.forms['form1'].elements["IDCENTRO_"+IDRegistro].value+'|'+document.forms['form1'].elements["IDTIPO_"+IDRegistro].value+'|'+document.forms['form1'].elements["TEXTO_"+IDRegistro].value+'|'+document.forms['form1'].elements["VISIBILIDAD_"+IDRegistro].value;

        //alert(document.forms['form1'].elements["PARAMETROS"].value);

	Enviar();
}

//	Nueva entrada de seguimiento
function Borrar(IDRegistro)
{
	document.forms['form1'].elements["ACCION"].value='BORRAR';
	document.forms['form1'].elements["PARAMETROS"].value=IDRegistro;

	Enviar();
}
