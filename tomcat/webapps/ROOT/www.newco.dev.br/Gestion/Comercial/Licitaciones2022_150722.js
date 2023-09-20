//	JS para el listado/buscador de Licitaciones
//	Ultima revision ET 15dic21 13:00 Licitaciones2022_150722.js


//	3dic18	Funciones para paginación del listado
function Enviar(){
	var form=document.forms['Buscador'];
	SubmitForm(form);
}


function NuevaLicitacion(){
	//15jul22 window.open('http://www.newco.dev.br/Gestion/Comercial/MantLicitacion2022.xsql','_blank','scrollbars=yes');
	document.location="http://www.newco.dev.br/Gestion/Comercial/NuevaLicV2_2022.xsql";
	//15jul22 document.location="http://www.newco.dev.br/Gestion/Comercial/LicitacionV2_2022.xsql";
}

function CambiarEstadoLicitacion(IDLic, IDEstado)
{
	var d = new Date();

	if (((IDEstado=='B')||(IDEstado=='SUS'))&&(jQuery('#FMOTIVOBORRAR_'+IDLic).val()=='-1'))
	{
		alert(strMotivoBorrar);
		jQuery('#trMOTIVOBORRAR_'+IDLic).show();
		return;
	}
	
	var IDMotivo=jQuery('#FMOTIVOBORRAR_'+IDLic).val(), Motivo=jQuery('#MOTIVOBORRAR_'+IDLic).val();

	jQuery.ajax({
		cache:	false,
		url:	'http://www.newco.dev.br/Gestion/Comercial/CambiarEstadoLicitacion.xsql',
		type:	"GET",
		data:	"ID_LIC="+IDLic+"&ID_ESTADO="+IDEstado+"&ID_MOTIVO="+IDMotivo+"&MOTIVO="+encodeURIComponent(ScapeHTMLString(Motivo))+"&_="+d.getTime(),
		contentType: "application/xhtml+xml",
		success: function(objeto){
			var data = eval("(" + objeto + ")");

			if(data.NuevoEstado.estado == 'OK'){
				 Enviar();
			}else{
				alert(errorNuevoEstadoLicitacion);
			}
		},
		error: function(xhr, errorString, exception) {
			alert("xhr.status="+xhr.status+" error="+errorString+" exception="+exception);
		}
	});
}

function Orden(Campo)
{
	if (Campo==document.forms[0].elements['ORDEN'].value)
		document.forms[0].elements['SENTIDO'].value=(document.forms[0].elements['SENTIDO'].value=='DESC')?'ASC':'DESC';
	else
	{
		document.forms[0].elements['ORDEN'].value=Campo;
		if ((Campo=='TITULO')||(Campo=='COD')||(Campo=='ESTADO')||(Campo=='CLIENTE')||(Campo=='CENTROPEDIDO')||(Campo=='FECHADEC')||(Campo=='FECHALIC'))
			document.forms[0].elements['SENTIDO'].value='ASC';
		else
			document.forms[0].elements['SENTIDO'].value='DESC';
	}
	Enviar();
}

function VerPedidos(IDLicitacion)
{
	MostrarPagPersonalizada('http://www.newco.dev.br/Personal/BandejaTrabajo/AnalisisPedidos2022.xsql?IDLICITACION='+IDLicitacion,'HistoricoPedidos',90,90,10,10);
}

//	15dic21 Al cambiar el desplegable estado, ponemos a null el campo de ORDEN para tomar la ordenacion por defecto para este tipo 
function CambiaEstado()
{
	debug('CambiaEstado');
	document.forms[0].elements['ORDEN'].value='';
	document.forms[0].elements['SENTIDO'].value='';
}


/*

24may22 Utilizamos las funciones de basic2022_010822.js

//	25ene22 Abrir ficha Empresa
function FichaEmpresa(IDEmpresa)
{
	MostrarPagPersonalizada("http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPDetalleFrame2022.xsql?EMP_ID="+IDEmpresa+"&amp;VENTANA=NUEVA","Cliente",100,80,0,-20);
}

//	25ene22 Abrir ficha Centro
function FichaCentro(IDCentro)
{
	MostrarPagPersonalizada("http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/CENDetalle2022.xsql?ID="+IDCentro,"centro",100,80,0,-20);
}


//	25ene22 Abrir ficha Centro
function VerLicitacion(IDLic)
{
	MostrarPagPersonalizada("http://www.newco.dev.br/Gestion/Comercial/MantLicitacion2022.xsql?LIC_ID="+IDLic,"Licitacion",100,80,0,-20);
}


//	25ene22 Abre la pagina de Vencedores de la liciatcion
function VerVencedores(IDLic)
{
	MostrarPagPersonalizada("http://www.newco.dev.br/Gestion/Comercial/licOfertasSeleccionadas2022.xsql?LIC_ID="+IDLic,"Licitacion",100,80,0,-20);
}


//	25ene22 Abre la pagina de Vencedores de la liciatcion
function FichaProductoLic(IDLic, IDProdLic)
{
	MostrarPagPersonalizada("http://www.newco.dev.br/Gestion/Comercial/FichaProductoLicitacion2022.xsql?LIC_PROD_ID="+IDProdLic+"&amp;LIC_ID="+IDLic,"FichaProducto",100,80,0,-20);
}
*/





