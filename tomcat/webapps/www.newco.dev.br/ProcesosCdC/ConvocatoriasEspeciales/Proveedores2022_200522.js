//	JS Convocatorias especiales: listado de proveedores. Nuevo disenno.
//	Ultima revision ET 24may22 19:15. Proveedores2022_200522.js

//	2oct18	Funciones para paginación del listado
function Enviar(){
	var form=document.forms[0];
	//console.log("PAGINA:"+document.forms[0].elements['PAGINA'].value);

	SubmitForm(form);
}

function Buscar() {document.forms[0].elements['PAGINA'].value=0; Enviar();}
function PaginaAnterior() {document.forms[0].elements['PAGINA'].value=parseInt(document.forms[0].elements['PAGINA'].value)-1; Enviar();}
function PaginaSiguiente() {document.forms[0].elements['PAGINA'].value=parseInt(document.forms[0].elements['PAGINA'].value)+1; Enviar();}

function CambioDesplegables(Tipo)
{

	console.log('CambioDesplegables'+Tipo);

	if (Tipo=='CAMBIO_CONVOCATORIA')
		document.forms[0].elements['FIDPROVEEDOR'].value=-1;

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
		if ((Campo=='PROVEEDOR')||(Campo=='FICHA'))
			document.forms[0].elements['SENTIDO'].value='ASC';
		else
			document.forms[0].elements['SENTIDO'].value='DESC';
	}

	//console.log('Orden:'+Campo+' Nueva ordenación:'+document.forms[0].elements['ORDEN'].value+' '+document.forms[0].elements['SENTIDO'].value);

	Enviar();
}

function DescargarExcel(){
	var d = new Date();

	jQuery.ajax({
		url:	"http://www.newco.dev.br/ProcesosCdC/ConvocatoriasEspeciales/ProveedoresExcel.xsql",
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

//	Reabre convocatoria para un proveedor
function reabrirConvocatoria(IDProveedor)
{
	document.forms[0].elements['PARAMETROS'].value=IDProveedor;
	document.forms[0].elements['FESPECIALES'].value='';
	document.forms[0].elements['FTEXTO'].value='';
	document.forms[0].elements['ACCION'].value='REOFERTA';
	Enviar();
}

//	Cierra/suspende convocatoria para un proveedor
function activaOSuspendeProveedor(IDProveedor)
{
	document.forms[0].elements['PARAMETROS'].value=IDProveedor;
	document.forms[0].elements['FESPECIALES'].value='';
	document.forms[0].elements['FTEXTO'].value='';
	document.forms[0].elements['ACCION'].value='SUS';
	Enviar();
}

function VerConvocatoria()
{
	document.location='http://www.newco.dev.br/ProcesosCdC/Convocatorias/Convocatoria2022.xsql?LIC_CONV_ID='+IDConvocatoria;
}

function VerProcedimientos(IDProveedor)
{
	document.location='http://www.newco.dev.br/ProcesosCdC/ConvocatoriasEspeciales/BuscadorProcedimientos2022.xsql?FIDCONVOCATORIA='+IDConvocatoria+'&FIDPROVEEDOR='+IDProveedor;
}

function VerProductos()
{
	document.location='http://www.newco.dev.br/ProcesosCdC/ConvocatoriasEspeciales/BuscadorProductos2022.xsql?FIDCONVOCATORIA='+IDConvocatoria;
}

//	20may22 Abre la ficha completa del proveedor
function FichaCompleta(IDProveedor)
{
	MostrarPagPersonalizada("http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPFichaCompleta.xsql?EMP_ID="+IDProveedor,'Detalle Empresa',100,80,0,0);
}





