// JavaScript Document

function GuardarDerechos(form){
	
	var cadena = '';
	var plantilla = form.elements['ID_PLANTILLA'].value;
	var plantilla_prov = form.elements['ID_PLANTILLA_PROV'].value;
	var producto = form.elements['ID_PRODUCTO'].value;
	
	var lun = form.length;
	for (var i=0;i<lun;i++){
		
		//cadena = cadena + plantilla+'|'+plantilla_prov+'|'+producto+'|';
		var k = form.elements[i].name;
		if (k.match('USUARIO_')){
			cadena = cadena + plantilla+'|'+plantilla_prov+'|'+ form.elements[i].value+'|'+producto+'|';
			
			}
		if (k.match('OCULTAR_')){
			//alert('oculto '+ form.elements[i].checked);
			//si checked pongo Si a ocultar
			if (form.elements[i].checked == true){
				cadena = cadena + 'S|';
				}
			else{ cadena = cadena + 'N|';}
			}
		if (k.match('BLOQUEAR_')){
			//alert('oculto '+ form.elements[i].checked);
			//si checked pongo Si a ocultar
			if (form.elements[i].checked == true){
				cadena = cadena + 'S#';
				}
			else{ cadena = cadena + 'N#';}
			}
			
		}//fin for
		
	form.elements['DERECHOS_PLANTILLAS'].value = cadena;
	
	if (cadena != ''){
		SubmitForm(form);
	}
}//fin de guardarderechos

//si bloqueao un prod a un usuario => oculto tb el prod
function Bloquear(id){
	var form = document.forms['form1'];
	
	if (form.elements['BLOQUEAR_'+id].checked == true){
		form.elements['OCULTAR_'+id].checked = true;
		}
}

//si desoculto un prod a un usuario => desbloqueo tb el prod
function Desocultar(id){
	var form = document.forms['form1'];
	
	if (form.elements['OCULTAR_'+id].checked == false){
		if (form.elements['BLOQUEAR_'+id].checked == true){
			form.elements['BLOQUEAR_'+id].checked = false;
		}
	}
}

//selecionar, deselecionar ocultos
function selTodosOcultos(){
	var form = document.forms['form1'];
	var lun = form.length;
	var Estado = null;
	
	for (var i=0;i<lun;i++){
		//cadena = cadena + plantilla+'|'+plantilla_prov+'|'+producto+'|';
		var k = form.elements[i].name;
		if (k.substr(0,8) == 'OCULTAR_'){
			//form.elements[i].checked = true;
			   if (form.elements[i].checked == true )
                            Estado=false;
                        else
                            Estado=true;
		}	
	}//fin for
	for (var i=0;i<lun;i++){
		//cadena = cadena + plantilla+'|'+plantilla_prov+'|'+producto+'|';
		var k = form.elements[i].name;
		if (k.substr(0,8) == 'OCULTAR_'){
			//si checked pongo Si a ocultar
			form.elements[i].checked = Estado;
		}	
	}//fin for
	
}//fin selTodosOcultos

//selecionar, deselecionar bloqueados
function selTodosBloquear(){
	var form = document.forms['form1'];
	var lun = form.length;
	var Estado = null;
	
	for (var i=0;i<lun;i++){
		//cadena = cadena + plantilla+'|'+plantilla_prov+'|'+producto+'|';
		var k = form.elements[i].name;
		if (k.substr(0,9) == 'BLOQUEAR_'){
			//form.elements[i].checked = true;
			   if (form.elements[i].checked == true )
                            Estado=false; 
                        else
                            Estado=true;
		}	
		if (k.substr(0,8) == 'OCULTAR_'){
			//form.elements[i].checked = true;
			   if (form.elements[i].checked == true )
                            Estado=false;
                        else
                            Estado=true;
		}	
	}//fin for
	for (var i=0;i<lun;i++){
		//cadena = cadena + plantilla+'|'+plantilla_prov+'|'+producto+'|';
		var k = form.elements[i].name;
		if (k.substr(0,9) == 'BLOQUEAR_'){
			//si checked pongo Si a ocultar
			form.elements[i].checked = Estado;
		}	
		if (k.substr(0,8) == 'OCULTAR_' && Estado == true){
			//si checked pongo Si a ocultar
			form.elements[i].checked = Estado;
		}	
	}//fin for
	
}//fin selTodosBloquear


