//	JS Convocatorias especiales: buscador de productos. Nuevo disenno 2022. 
//	Ultima revision ET 25may22 10:40 BuscadorProductos2022_230522.js


//	2abr19	Comprueba si está abierto como pop-up, si no es así, quita el destacado de los enlaces de ref. producto
function Inicio()
{
	if (window.opener)
	{
		console.log("Existe opener");
	}
	else
	{
		jQuery(".refProducto").css('color','black');
	}
}

//	2oct18	Funciones para paginación del listado
function Enviar(){
	var form=document.forms[0];
	//console.log("PAGINA:"+document.forms[0].elements['PAGINA'].value);

	//if (document.forms[0].elements['FPROCEDIMIENTOS'].checked)
	//	form.action="http://www.newco.dev.br/ProcesosCdC/ConvocatoriasEspeciales/BuscadorProcedimientos.xsql";

	SubmitForm(form);
}

function Buscar() {document.forms[0].elements['PAGINA'].value=0; Enviar();}
function PaginaAnterior() {document.forms[0].elements['PAGINA'].value=parseInt(document.forms[0].elements['PAGINA'].value)-1; Enviar();}
function PaginaSiguiente() {document.forms[0].elements['PAGINA'].value=parseInt(document.forms[0].elements['PAGINA'].value)+1; Enviar();}

function IncluirEnPaginaPrincipal(Ref)
{
	try
	{
		console.log('IncluirEnPaginaPrincipal:'+Ref);
		window.opener.IncluirReferencia(Ref);
	}
	catch(err)
	{
	}
}

function DescargarExcel(){
	var d = new Date(),
		IDConvocatoria=document.forms[0].elements['FIDCONVOCATORIA'].value,
		IDProveedor=document.forms[0].elements['FIDPROVEEDOR'].value;

	jQuery.ajax({
		url:	"http://www.newco.dev.br/ProcesosCdC/ConvocatoriasEspeciales/ProductosExcel.xsql",
		data:	"IDCONVOCATORIA="+IDConvocatoria+"&amp;IDPROVEEDOR="+IDProveedor+"&amp;_="+d.getTime(),
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

function VerProcedimientos()
{
	var IDConvocatoria=document.forms[0].elements['FIDCONVOCATORIA'].value;
	document.location='http://www.newco.dev.br/ProcesosCdC/ConvocatoriasEspeciales/BuscadorProcedimientos2022.xsql?FIDCONVOCATORIA='+IDConvocatoria;
}
