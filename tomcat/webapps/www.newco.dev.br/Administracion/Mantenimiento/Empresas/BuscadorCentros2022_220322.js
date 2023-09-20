//	JS Listado de centros de MedicalVM con sus datos principales
//	Ultima revision: ET 22mar22 11:00 BuscadorCentros2022_220322.js


function Enviar(){
	var form=document.forms[0];
	SubmitForm(form);
}

function CambiarEmpresa(idEmpresa){
	parent.zonaEmpresa.CambioEmpresaActual(idEmpresa);
}

function CambiarCentro(idEmpresa, idCentro){
	parent.zonaEmpresa.CambioCentroActual(idEmpresa, idCentro);
}

//	Selecciona/Deselecciona todos los checkboxes
function SeleccionarTodas(){
	var form=document.forms[0],
	Valor='';

	for(var n=0;n<form.length;n++){
		if(form.elements[n].name.match('CHK_')){
			if (Valor=='')
				if (form.elements[n].checked==true)
					Valor='N';
				else
					Valor='S';

			if (Valor=='S')
				form.elements[n].checked=true;
			else
				form.elements[n].checked=false;
		}
	}
}

function Continuar(){
	var form=document.forms[0],
	ListaIDs='';

	for(var n=0;n<form.length;n++){
		if(form.elements[n].name.match('CHK_')){
			if (form.elements[n].checked==true)
				ListaIDs=ListaIDs+Piece(form.elements[n].name,'_',1)+'|';
		}
	}

	if(ListaIDs=='')
		alert('Debe seleccionar al menos una empresa para poder continuar');
	else{
		form.elements['LISTAEMPRESAS'].value=ListaIDs;
		form.action="./ListadoCentros2022.xsql";
		SubmitForm(form);
	}
}

function Buscar() {document.forms[0].elements['PAGINA'].value=0; Enviar();}
function PaginaAnterior() {document.forms[0].elements['PAGINA'].value=document.forms[0].elements['PAGINA'].value-1; Enviar();}
function PaginaSiguiente() {document.forms[0].elements['PAGINA'].value=parseInt(document.forms[0].elements['PAGINA'].value)+1; Enviar();}
