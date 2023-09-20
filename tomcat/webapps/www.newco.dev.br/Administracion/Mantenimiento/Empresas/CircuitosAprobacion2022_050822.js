//	JC Circuitos de aprobación
//	Ultima revision: ET 5ago22 15:00 CircuitosAprobacion2022_050822.js

function onLoad()
{
	/*document.forms['frmCirc'].elements['ACCION'].value='CREAR';
	document.forms['frmCirc'].elements['IDCIRCUITO'].value='';
	document.forms['frmCirc'].elements['LISTACONDICIONES'].value='IMPORTE';

	//8ago22 Inicializamos el desplegable a "todos los centros"
	jQuery('#LISTACENTROS').val('');*/
	
	LimpiarCircuito();
}


function Enviar()
{
	SubmitForm(document.forms['frmCirc']);
}

function BorrarCircuito(IDCircuito)
{
	if (confirm(strSeguroBorrar))
	{
		document.forms['frmCirc'].elements['ACCION'].value='BORRAR';
		document.forms['frmCirc'].elements['IDCIRCUITO'].value=IDCircuito
		SubmitForm(document.forms['frmCirc']);
	}
}

function LimpiarCircuito()
{
	document.forms['frmCirc'].elements['ACCION'].value='CREAR';
	document.forms['frmCirc'].elements['IDCIRCUITO'].value='';

	//8ago22	document.forms['frmCirc'].elements['NIVEL'].value='';
	//8ago22	document.forms['frmCirc'].elements['ORDEN'].value='';
	//8ago22	document.forms['frmCirc'].elements['LISTACENTROS'].value='';
	//8ago22	document.forms['frmCirc'].elements['LISTACOMPRADORES'].value='';
	//8ago22	document.forms['frmCirc'].elements['LISTAAPROBADORES'].value='';
	//8ago22	document.forms['frmCirc'].elements['LISTACONDICIONES'].value='IMPORTE';
	//8ago22	document.forms['frmCirc'].elements['CONVENIO'].value='T';
	//8ago22	document.forms['frmCirc'].elements['TIPO'].value='PED';
	//8ago22	document.forms['frmCirc'].elements['IDCENTROCOSTE'].value='';

	jQuery('#IMPORTE').val('0');
	
	//	Valores por defecto de los desplegables
	jQuery('#TIPO').val('PED');
	jQuery('#NIVEL').val('1');
	jQuery('#ORDEN').val('10');
	jQuery('#NOMBRE').val('');
	jQuery('#LISTACENTROS').val('');
	jQuery('#LISTACOMPRADORES').val('');
	jQuery('#LISTACENTROS').val('');
	jQuery('#LISTAAPROBADORES').val('');
	jQuery('#CONVENIO').val('T');
	jQuery('#LISTACONDICIONES').val('IMPORTE');
	
	//	Ocultamos desplegables innecesarios
	jQuery("#IDCENTROCOSTE").hide();	
	jQuery("#CATEGORIAS").hide();	
	jQuery("#PROVEEDORES").hide();	

	//8ago22 document.forms['frmCirc'].elements['IMPORTE'].value=0;

}

function EditarCircuito(id)
{
	debug('EditarCircuito:'+id);

	document.forms['frmCirc'].elements['ACCION'].value='MODIFICAR';
	document.forms['frmCirc'].elements['IDCIRCUITO'].value=id;

	Pos=BuscaEnArray(arrCircuitos,'ID',id);

	/*debug('#TIPO:'+arrCircuitos[Pos].TIPO);
	debug('#NIVEL:'+arrCircuitos[Pos].NIVEL);
	debug('#ORDEN:'+arrCircuitos[Pos].ORDEN);
	debug('#NOMBRE:'+arrCircuitos[Pos].NOMBRE);
	debug('#LISTACENTROS:'+arrCircuitos[Pos].IDCENTROCLIENTE);
	debug('#LISTACOMPRADORES:'+arrCircuitos[Pos].IDCOMPRADOR);
	debug('#LISTAAPROBADORES:'+arrCircuitos[Pos].IDAPROBADOR);
	debug('#CONVENIO:'+arrCircuitos[Pos].CONVENIO);
	debug('#LISTACONDICIONES:'+arrCircuitos[Pos].CONDICION);
	debug('#IDCENTROCOSTE:'+arrCircuitos[Pos].IDCENTROCONSUMO);*/


	debug('#LISTAAPROBADORES:'+arrCircuitos[Pos].IDAPROBADOR);

	//	Valores por defecto de los desplegables
	jQuery('#TIPO').val(arrCircuitos[Pos].TIPO);
	jQuery('#NIVEL').val(arrCircuitos[Pos].NIVEL);
	jQuery('#ORDEN').val(arrCircuitos[Pos].ORDEN);
	jQuery('#NOMBRE').val(arrCircuitos[Pos].NOMBRE);
	jQuery('#LISTACENTROS').val(arrCircuitos[Pos].IDCENTROCLIENTE);
	jQuery('#LISTACOMPRADORES').val(arrCircuitos[Pos].IDCOMPRADOR);
	jQuery('#LISTAAPROBADORES').val(arrCircuitos[Pos].IDAPROBADOR);
	jQuery('#CONVENIO').val(arrCircuitos[Pos].CONVENIO);
	jQuery('#LISTACONDICIONES').val(arrCircuitos[Pos].CONDICION);
	jQuery('#IDCENTROCOSTE').val(arrCircuitos[Pos].IDCENTROCONSUMO);

	var Condicion=jQuery("#LISTACONDICIONES").val();
	
	if (!Condicion)
	{
		Condicion='IMPORTE';
		jQuery("#LISTACONDICIONES").val('IMPORTE');
	}
	
	Condicion=Condicion.toString().substring(0,4);
	
	if (Condicion==='IMPO')
	{
		Valor='';
		jQuery("#CATEGORIAS").hide();	
		jQuery("#PROVEEDORES").hide();	
	}
	else if (Condicion==='CATE')
	{
		jQuery("#LISTACATEGORIAS").val(arrCircuitos[Pos].VALOR);
		jQuery("#CATEGORIAS").show();	
		jQuery("#PROVEEDORES").hide();	
	}
	else if (Condicion==='PROV')
	{
		jQuery("#LISTAPROVEEDORES").val(arrCircuitos[Pos].VALOR);
		jQuery("#CATEGORIAS").hide();	
		jQuery("#PROVEEDORES").show();	
	}

	jQuery('#IMPORTE').val(arrCircuitos[Pos].IMPORTE);

}

function GuardarCircuito()
{
	var Condicion=jQuery("#LISTACONDICIONES").val().substring(0,4);
	var Errores='', Valor, Parametros, Importe;
	
	if (document.forms['frmCirc'].elements['NOMBRE'].value=='')
		Errores+=errNombreObligatorio;
	
	if (Condicion==='IMPO')
	{
		Valor='';
		console.log('GuardarCircuito: cond:IMP. Valor:'+Valor);
	}
	else if (Condicion==='CATE')
	{
		Valor=jQuery("#LISTACATEGORIAS").val();	
		console.log('GuardarCircuito: cond:CAT. Valor:'+Valor);
		
		if (Valor=="")
			Errores+=errCategoriaObligatoria;
	}
	else if (Condicion==='PROV')
	{
		Valor=jQuery("#LISTAPROVEEDORES").val();	
		console.log('GuardarCircuito: cond:PRO. Valor:'+Valor);
		
		if (Valor=="")
			Errores+=errProveedorObligatorio;
	}
	
	
	if (Errores=='')
	{
		Parametros=document.forms['frmCirc'].elements['NOMBRE'].value
					+'|'+document.forms['frmCirc'].elements['NIVEL'].value
					+'|'+document.forms['frmCirc'].elements['ORDEN'].value
					+'|'+document.forms['frmCirc'].elements['LISTACENTROS'].value
					+'|'+document.forms['frmCirc'].elements['LISTACOMPRADORES'].value
					+'|'+document.forms['frmCirc'].elements['LISTACONDICIONES'].value
					+'|'+Valor
					+'|'+document.forms['frmCirc'].elements['IMPORTE'].value
					+'|'+document.forms['frmCirc'].elements['LISTAAPROBADORES'].value
					+'|'+document.forms['frmCirc'].elements['CONVENIO'].value
					+'|'+document.forms['frmCirc'].elements['TIPO'].value					//	8ago22 Nuevo campo. PED: PEDIDOS, LIC:LICITACIONES.
					+'|'+document.forms['frmCirc'].elements['IDCENTROCOSTE'].value;			//	8ago22 Nuevo campo. IDCENTROCOSTE

		jQuery("#PARAMETROS").val(Parametros);

		//solodebug	console.log('GuardarCircuito:'+Parametros);

		Enviar();
	}
	else
		alert(Errores);
}

function CambiaCondicion()
{
	var Condicion=jQuery("#LISTACONDICIONES").val().substring(0,4);

	//solodebug
	console.log('CambiaCondicion:'+Condicion);

	jQuery("#LISTACATEGORIAS").val('');
	jQuery("#LISTAPROVEEDORES").val('');
	
	if (Condicion==='IMPO')
	{
		jQuery("#CATEGORIAS").hide();	
		jQuery("#PROVEEDORES").hide();	
	}
	else if (Condicion==='CATE')
	{
		jQuery("#CATEGORIAS").show();	
		jQuery("#PROVEEDORES").hide();	
	}
	else if (Condicion==='PROV')
	{
		jQuery("#CATEGORIAS").hide();	
		jQuery("#PROVEEDORES").show();	
	}
	
}

function CambiaCentro()
{
	if (document.forms['frmCirc'].elements['LISTACENTROS'].value==='')
	{
		jQuery("#USUARIOS").hide();
		OcultarCentrosCoste()
		document.forms['frmCirc'].elements['LISTACOMPRADORES'].value='';
	}
	else
	{
		//	Muestra solo los usuarios del centro correspondiente
		var Centro=jQuery("#LISTACENTROS option:selected").text();
		var IDCentro = jQuery("#LISTACENTROS").val();

		//solodebug 
		debug("CambiaCentro:"+Centro);

		//	5ago22 Recupera los centros de coste
		RecuperaCentrosCoste(IDCentro);

		var output=document.getElementById('LISTACOMPRADORES').options;
		for(var i=0;i<output.length;i++) 
		{
			//solodebug console.log("CambiaCentro. Revisando:"+output[i].text+'::'+output[i].text.substring(0, Centro.length));

			if ((output[i].value=="")||(output[i].text.substring(0, Centro.length)===Centro))
			{
				//solodebug console.log("CambiaCentro. Revisando:"+output[i].text+" INCLUIDO");
				output[i].style.display = "block";
			}
			else
			{
				output[i].style.display = "none";
			}
		}

		jQuery("#USUARIOS").show();
	}
}


//	5ago22 Recuperamos los datos de centros de coste del centro seleccionado para incluirlos en el desplegable
function RecuperaCentrosCoste(IDCentro){
	var precioReferenciaVacio = 0, CheckCamposIniciar = true;
	var d = new Date();

	//solodebug 
	debug("RecuperaCentrosCoste:"+IDCentro);
	
	//	vacia el desplegable de centros de coste
	OcultarCentrosCoste();
	
	jQuery.ajax({
		cache:	false,
		url:	'http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/RecuperaCentrosConsumoAJAX.xsql',
		type:	"GET",
		data:	"IDCENTRO="+IDCentro+"&_="+d.getTime(),
		contentType: "application/xhtml+xml",
		error: function(objeto, quepaso, otroobj){
			alert('error'+quepaso+' '+otroobj+' '+objeto);
		},
		success: function(objeto){
			debug("RecuperaCentrosCoste("+IDCentro+"):"+objeto);

			var data = JSON.parse(objeto);
			debug("RecuperaCentrosCoste("+IDCentro+"). JSON length:"+data.CentrosConsumo.length);

			if(data.CentrosConsumo.length > 0){

				var html='';

				jQuery.each(data.CentrosConsumo, function(key, cen){
					html+='<option value="'+cen.ID+'">'+cen.Nombre+'</option>';
				});

				debug("RecuperaCentrosCoste("+IDCentro+"). html:"+html);

				jQuery("#IDCENTROCOSTE").html(html);	
				jQuery("#CENTROSCOSTE").show();	
			}
		}
	});
}


//	5ago22 Vacia y oculta los centros de consumo 
function OcultarCentrosCoste()
{
	jQuery("#CENTROSCOSTE").hide();
	jQuery("#IDCENTROCOSTE").empty();			
}


//	Comprueba que el importe sea numérico o lo deja a 0
function ComprobarImporte()
{
	//27jul22 var Importe=document.forms['frmCirc'].elements['IMPORTE'].value.replace('PUNTO','').replace(',','.');
	var Importe=desformateaDivisa(document.forms['frmCirc'].elements['IMPORTE'].value);

	console.log(Importe);

	if (isNaN(Importe))
	{
		alert(errImporteIncorrecto);
		document.forms['frmCirc'].elements['IMPORTE'].value='0';
	}
}


