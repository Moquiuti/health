//	Buscador de usuarios. Permite recopilar emails para comunicacion de novedades.
//	Ultima revision: ET 22mar22 17:10 BuscadorUsuarios2022_220322.js

//	Selecciona/Deselecciona todos los checkboxes
function SeleccionarTodas(){
	var form=document.forms[0],Valor='';

	for(var n=0;n<form.length;n++){
		if(form.elements[n].name.match('CHK_')){
			if(Valor=='')
				if(form.elements[n].checked==true)
					Valor='N';
				else
					Valor='S';

			if(Valor=='S')
				form.elements[n].checked=true;
			else
				form.elements[n].checked=false;
		}
	}
	PulsadoCheck();
}

//	Recorre el formulario y muestra la dirección de los usuarios activos
function PulsadoCheck(){
	var form=document.forms[0],Valor='',ListaDirecciones='';

	for(var n=0;n<form.length;n++){
		if(form.elements[n].name.match('CHK_')){
			if(form.elements[n].checked==true && form.elements['EMAIL_'+Piece(form.elements[n].name,'_',1)].value != '')
				ListaDirecciones=ListaDirecciones
					+'"'+form.elements['NOMBRE_'+Piece(form.elements[n].name,'_',1)].value+'"'
					+'<'+form.elements['EMAIL_'+Piece(form.elements[n].name,'_',1)].value+'>,';
		}
	}

	form.elements['ListaDirecciones'].value=ListaDirecciones;
}

function CambiarEmpresa(idEmpresa){
	parent.zonaEmpresa.CambioEmpresaActual(idEmpresa);
}

function CambiarCentro(idEmpresa, idCentro){
	parent.zonaEmpresa.CambioCentroActual(idEmpresa, idCentro);
}

function Enviar(){
	var form=document.forms[0];
	SubmitForm(form);
}

function EditarUsuario(url,idempresa){
	parent.areaTrabajo.location.href=url+'&EMP_ID='+idempresa
}

//16may22 Seleccionado un usuario
function Usuario(ID, IDEmpresa,IDCentro)
{
	EditarUsuario('./USManten2022.xsql?ID_USUARIO='+ID,IDEmpresa); CambiarCentro(IDEmpresa,IDCentro);
}

function Buscar() {document.forms[0].elements['PAGINA'].value=0; Enviar();}
function PaginaAnterior() {document.forms[0].elements['PAGINA'].value=document.forms[0].elements['PAGINA'].value-1; Enviar();}
function PaginaSiguiente() {document.forms[0].elements['PAGINA'].value=parseInt(document.forms[0].elements['PAGINA'].value)+1; Enviar();}
