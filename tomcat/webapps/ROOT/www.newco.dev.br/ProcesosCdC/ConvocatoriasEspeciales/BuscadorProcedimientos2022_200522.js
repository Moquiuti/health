//	JS Convocatorias especiales: buscador de procedimientos. Nuevo disenno. 
//	Ultima revision ET 20may22 15:35


function onLoad()
{	
	proveedorOnChange();
}

//	Funciones para paginación del listado
function Enviar(){
	var form=document.forms[0];
	//console.log("PAGINA:"+document.forms[0].elements['PAGINA'].value);

	//if (document.forms[0].elements['FPRODUCTOS'].checked)
	//	form.action="http://www.newco.dev.br/ProcesosCdC/ConvocatoriasEspeciales/BuscadorProductos.xsql";

	if (document.forms[0].elements['FINFORMADO'].checked)
		document.forms[0].elements['FINFORMADO'].value="S";

	SubmitForm(form);
}

function Buscar() {document.forms[0].elements['PAGINA'].value=0; Enviar();}
function PaginaAnterior() {document.forms[0].elements['PAGINA'].value=parseInt(document.forms[0].elements['PAGINA'].value)-1; Enviar();}
function PaginaSiguiente() {document.forms[0].elements['PAGINA'].value=parseInt(document.forms[0].elements['PAGINA'].value)+1; Enviar();}

function Procedimiento(IDConvocatoria, IDEspecialidad, IDModProcedimiento)		//, IDProveedor)
{
	//solodebug	alert("Procedimiento("+IDConvocatoria+","+ IDEspecialidad+","+ IDModProcedimiento);	//+","+ IDProveedor+")");

	if (document.forms[0].elements['ROL'].value=='COMPRADOR')
	{
		//	Para un cliente, abrimos en la propia página principal
		var UrlCompetencia='http://www.newco.dev.br/ProcesosCdC/ConvocatoriasEspeciales/ProcedimientoYOfertas2022.xsql?FIDCONVOCATORIA='
						+IDConvocatoria+'&FIDESPECIALIDAD='+IDEspecialidad+'&FIDPROCEDIMIENTO='+IDModProcedimiento;	//+'&amp;FIDPROVEEDOR='+IDProveedor;

		window.location=UrlCompetencia;
	}
	else
	{
		var Url='http://www.newco.dev.br/ProcesosCdC/ConvocatoriasEspeciales/InformarProcedimientos2022.xsql?FIDCONVOCATORIA='
						+IDConvocatoria+'&FIDESPECIALIDAD='+IDEspecialidad+'&FIDPROCEDIMIENTO='+IDModProcedimiento;	//+'&amp;FIDPROVEEDOR='+IDProveedor;

		try
		{
			//	Para un proveedor,desde el pop up cambiamos la página principal
			window.opener.location=Url;
		}
		catch(err)
		{
			//	Si ha dado error, abrimos en la propia página principal
			window.location=Url;
		}
	}
}

//25may22 Solo activamos filtros especiales si se ha seleccionado un proveedor
function proveedorOnChange()
{
	if (document.forms[0].elements['FIDPROVEEDOR'].value!=-1)
	{
		document.forms[0].elements['FINFORMADO'].checked=true;
		document.forms[0].elements['FINFORMADO'].disabled=true;

		document.forms[0].elements['FESPECIALES'].disabled=false;
	}
	else
	{
		document.forms[0].elements['FINFORMADO'].disabled=false

		document.forms[0].elements['FESPECIALES'].disabled=true;
		document.forms[0].elements['FESPECIALES'].value='TODOS';
	}
}

function VerProveedor(IDProveedor, Referencia)
{
	document.forms[0].elements['FINFORMADO'].checked=true;
	document.forms[0].elements['PAGINA'].value=0;
	document.forms[0].elements['FESPECIALES'].value='TODOS';
	document.forms[0].elements['FTEXTO'].value=Referencia;
	document.forms[0].elements['FIDPROVEEDOR'].value=IDProveedor;
	Enviar();
}


function Orden(Campo)
{
	console.log('Campo:'+Campo+ 'Orden actual:'+document.forms[0].elements['ORDEN'].value+ 'Sentido:'+document.forms[0].elements['SENTIDO'].value);

	if (Campo==document.forms[0].elements['ORDEN'].value)
		document.forms[0].elements['SENTIDO'].value=(document.forms[0].elements['SENTIDO'].value=='DESC')?'ASC':'DESC';
	else
	{
		document.forms[0].elements['ORDEN'].value=Campo;
		if ((Campo=='REFERENCIA')||(Campo=='PROCEDIMIENTO'))
			document.forms[0].elements['SENTIDO'].value='ASC';
		else
			document.forms[0].elements['SENTIDO'].value='DESC';
	}

	//console.log('Orden:'+Campo+' Nueva ordenación:'+document.forms[0].elements['ORDEN'].value+' '+document.forms[0].elements['SENTIDO'].value);

	Enviar();
}

function DescargarExcel()
{
	var d = new Date();

	jQuery.ajax({
		url:	"http://www.newco.dev.br/ProcesosCdC/ConvocatoriasEspeciales/ProcedimientosExcel.xsql",
		data:	"IDCONVOCATORIA="+IDConvocatoria+"&amp;_="+d.getTime(),
		type:	"GET",
		contentType: "application/xhtml+xml",
		beforeSend: function(){
			null;
		},
		error: function(objeto, quepaso, otroobj){
			alert('error'+quepaso+' '+otroobj+''+objeto);
		},
		success: function(objeto){
			var data = eval("(" + objeto + ")");

			if(data.estado == 'ok')
				window.location='http://www.newco.dev.br/Descargas/'+data.url;
			else
				alert(alrt_errorDescargaFichero);
		}
	});
}

function VerProveedores(IDProveedor)
{
	document.location='http://www.newco.dev.br/ProcesosCdC/ConvocatoriasEspeciales/Proveedores2022.xsql?FIDCONVOCATORIA='+IDConvocatoria+'&amp;FIDPROVEEDOR='+IDProveedor;
}

function VerProductos()
{
	document.location='http://www.newco.dev.br/ProcesosCdC/ConvocatoriasEspeciales/BuscadorProductos2022.xsql?FIDCONVOCATORIA='+IDConvocatoria;
}

