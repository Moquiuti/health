// JS del buscador de Cat·lago privado
//	Ultima revision: ET 30set22 9:50 BuscadorCatPriv2022_300922.js

//ver la oferta cargada
function verOferta(IDOferta){
	jQuery.ajax({
			cache:	false,
			url:	'http://www.newco.dev.br/ProcesosCdC/CatalogoPrivado/URLDocumentoAJAX.xsql',
			type:	"GET",
			data:	"IDDOC="+IDOferta,
			contentType: "application/xhtml+xml",
			success: function(objeto){
				var data = eval("(" + objeto + ")");

                                        if(data.URLDocumento.estado == 'OK'){
                                            window.open("http://www.newco.dev.br/Documentos/"+data.URLDocumento.URLDocumento);
				}
			},
			error: function(xhr, errorString, exception) {
				alert("xhr.status="+xhr.status+" error="+errorString+" exception="+exception);
			}
		});
}


//cambiar fecha validez precio
function cambiaFecha(IDProd){
	var form = document.forms['form1'];
	var fechaLimite = 'FECHA_CADUCIDAD_'+IDProd;
	var enviarFechaLimite = 'EnviarFecha_'+IDProd;
	var modificarFechaLimite = 'ModificaFecha_'+IDProd;

	jQuery("#" + fechaLimite).removeClass('noinput');
	jQuery("#" + modificarFechaLimite).hide();
	jQuery("#" + enviarFechaLimite).show();
}


//actualizarFechaLimite funcion de la pagina actualizarFechaLimite
function actualizarFechaLimite(IDProd){
	var IDCLIENTE		= jQuery('#CLIENTE_ID_'+IDProd).val();
	var valueFechaLimite	= jQuery('#FECHA_CADUCIDAD_'+IDProd).val();
	var fechaLimite		= 'FECHA_CADUCIDAD_'+IDProd;
	var enviarFechaLimite	= 'EnviarFecha_'+IDProd;
	var modificarFechaLimite = 'ModificaFecha_'+IDProd;
	var msg = '';
	var d = new Date();

	if (valueFechaLimite == ''){ msg += obliFechaLimite;}

	if (msg == ''){
		jQuery.ajax({
			cache:	false,
			url:	'http://www.newco.dev.br/ProcesosCdC/CatalogoPrivado/ActualizarFechaLimiteCat.xsql',
			type:	"GET",
			data:	"PRO_ID="+IDProd+"&CLIENTE_ID="+IDCLIENTE+"&FECHA_LIMITE="+valueFechaLimite,				//30set22 ponia &amp;
			contentType: "application/xhtml+xml",
			success: function(objeto){
				var data = eval("(" + objeto + ")");

				if(data.ActualizarFechaLimite.estado == 'OK'){
					jQuery("#" + fechaLimite).addClass('noinput');
					//jQuery("#" + fechaLimite).setAttribute('disabled','disabled');
					jQuery("#"+modificarFechaLimite).show();
					jQuery("#"+enviarFechaLimite).hide();
				}
			},
			error: function(xhr, errorString, exception) {
				alert("xhr.status="+xhr.status+" error="+errorString+" exception="+exception);
			}
		});
	}else{
		alert(msg);
	}
}// fin de actualizarFechaLimite


function ProdEstandar(idempresa,ID){
	EjecutarFuncionDelFrame('zonaCatalogo','CambioProductoEstandarActual('+idempresa+','+ID+',\'CAMBIOPRODUCTOESTANDAR\')');
}


function EjecutarFuncionDelFrame(nombreFrame,nombreFuncion){
	//solodebug 	console.log('EjecutarFuncionDelFrame Frame: '+nombreFrame+' Funcion:'+nombreFuncion);

	//---var objFrame=new Object();
	objFrame=obtenerFrame(top, nombreFrame);

	if(objFrame.name!=null){

		var retorno=eval('objFrame.'+nombreFuncion);

		if(retorno!=undefined)
		{
			return retorno;
		}
	}

}


function EjecutarExterno(nombreFrame,idProductoEstandar){
	EjecutarFuncionDelFrame(nombreFrame,nombreFuncion);
	EjecutarFuncionDelFrame('zonaProducto','location.href=\'about:blank\'');
}


function recargarPagina(tipo){
	EjecutarFuncionDelFrame('Cabecera','EjecutarEnviarBusqueda();');
}


//funcion que ense√±a en el eis los datos del centro o de la empresa segun un producto, agrupar por producto siempre    
function MostrarEIS(indicador, idempresa, idcentro, refPro, anno)
{
	var Enlace;

	//	alert(indicador + idempresa +idcentro +refPro +anno);


	Enlace='http://www.newco.dev.br/Gestion/EIS/EISDatos2.xsql?'
			+'IDCUADROMANDO='+indicador
			+'&amp;'+'ANNO='+anno
			+'&amp;'+'IDEMPRESA='+idempresa
			+'&amp;'+'IDCENTRO='+idcentro
			+'&amp;'+'IDUSUARIO='
			+'&amp;'+'IDPRODUCTO=-1'
			+'&amp;'+'IDGRUPOCAT=-1'
			+'&amp;'+'IDSUBFAMILIA=-1'
			+'&amp;'+'IDESTADO=-1'
			+'&amp;'+'REFERENCIA='+refPro
			+'&amp;'+'CODIGO='
			+'&amp;'+'AGRUPARPOR=REF';

	MostrarPagPersonalizada(Enlace,'EIS',100,80,0,0);
}


function nuevaBusqueda(IDCat, IDFam, IDSfam, IDGru){
	<!-- El segundo y tercer parametro son opcionales -->
	IDFam	= (typeof IDFam === "undefined") ? -1 : IDFam;
	IDSfam	= (typeof IDSfam === "undefined") ? -1 : IDSfam;
	IDGru	= (typeof IDGru === "undefined") ? -1 : IDGru

	<!-- Esta funcion informa los desplegables del buscador -->
	EjecutarFuncionDelFrame('Cabecera','NuevaBusqueda(' + IDCat + ', ' + IDFam + ', ' + IDSfam + ', ' + IDGru + ');');

	<!-- Aqui recargamos la pagina con los nuevos valores -->
	var IDCLIENTE = jQuery('#IDCLIENTE').val();
	window.location = 'http://www.newco.dev.br/ProcesosCdC/CatalogoPrivado/PreciosYComisiones.xsql?' 
		+ 'ORIGEN=' + origen
		+ '&amp;'+'TYPE=' + type
		+ '&amp;'+'IDINFORME=Comisiones'
		+ '&amp;'+'ADJUDICADO=N'
		+ '&amp;'+'IDCATEGORIA=' + IDCat
		+ '&amp;'+'IDFAMILIA=' + IDFam
		+ '&amp;'+'IDSUBFAMILIA=' + IDSfam
		+ '&amp;'+'IDGRUPO=' + IDGru
		+ '&amp;'+'IDCLIENTE=' + IDCLIENTE;
}


//	17ago16	Funciones para paginacion del listado
function Enviar(){
	var form=document.forms[0];
	SubmitForm(form);
}

function Buscar() {document.forms[0].elements['PAGINA'].value=0; Enviar();}
function PaginaAnterior() {document.forms[0].elements['PAGINA'].value=parseInt(document.forms[0].elements['PAGINA'].value)-1; Enviar();}
function PaginaSiguiente() {document.forms[0].elements['PAGINA'].value=parseInt(document.forms[0].elements['PAGINA'].value)+1; Enviar();}


function CambiarOrden(Orden)
{
	document.forms[0].elements['PAGINA'].value=0; 
	document.forms[0].elements['ORDEN'].value=Orden; 
	Enviar();
};
