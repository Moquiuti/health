//	JS Listado de empresas de MedicalVM con sus datos principales
//	Ultima revision: ET 22mar22 10:00 ListadoEmpresasHTML2022_220322.js

function Enviar(){
	var form=document.forms[0];
	SubmitForm(form);
}

function CambiarEmpresa(idEmpresa){
	var objFrame=new Object();
	// objFrame=obtenerFrame(top, 'zonaEmpresa');
	// objFrame=parent.parent.areaTrabajo;
	// objFrame.CambioEmpresaActual(idEmpresa);
	//parent.parent.areaTrabajo.CambioEmpresaActual(idEmpresa);
	parent.zonaEmpresa.CambioEmpresaActual(idEmpresa);
}

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

			if (Valor=='S')
				form.elements[n].checked=true;
			else
				form.elements[n].checked=false;
		}
	}
}

function Continuar(){
	var form=document.forms[0],ListaIDs='';

	for(var n=0;n<form.length;n++){
		if(form.elements[n].name.match('CHK_')){
			if (form.elements[n].checked==true)
				ListaIDs=ListaIDs+Piece(form.elements[n].name,'_',1)+'|';
		}
	}

	if (ListaIDs=='')
		alert('Debe seleccionar al menos una empresa para poder continuar');
	else{
		form.elements['LISTAEMPRESAS'].value=ListaIDs;
		form.action="./ListadoCentros.xsql";
		SubmitForm(form);
	}
}

function Buscar() {document.forms[0].elements['PAGINA'].value=0; Enviar();}
function PaginaAnterior() {document.forms[0].elements['PAGINA'].value=document.forms[0].elements['PAGINA'].value-1; Enviar();}
function PaginaSiguiente() {document.forms[0].elements['PAGINA'].value=parseInt(document.forms[0].elements['PAGINA'].value)+1; Enviar();}
