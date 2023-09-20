//	JC Circuitos de aprobación
//	Ultima revision: ET 18jun19 12:30
function onLoad()
{
	document.forms['frmCirc'].elements['ACCION'].value='CREAR';
	document.forms['frmCirc'].elements['IDCIRCUITO'].value='';
	document.forms['frmCirc'].elements['LISTACONDICIONES'].value='IMPORTE';
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

	document.forms['frmCirc'].elements['NIVEL'].value='';
	document.forms['frmCirc'].elements['ORDEN'].value='';
	document.forms['frmCirc'].elements['LISTACENTROS'].value='';
	document.forms['frmCirc'].elements['LISTACOMPRADORES'].value='';
	document.forms['frmCirc'].elements['LISTAAPROBADORES'].value='';
	document.forms['frmCirc'].elements['LISTACONDICIONES'].value='IMPORTE';

	jQuery("#CATEGORIAS").hide();	
	jQuery("#PROVEEDORES").hide();	

	document.forms['frmCirc'].elements['IMPORTE'].value=0;

}

function EditarCircuito(id)
{
	document.forms['frmCirc'].elements['ACCION'].value='MODIFICAR';
	document.forms['frmCirc'].elements['IDCIRCUITO'].value=id;

	document.forms['frmCirc'].elements['NIVEL'].value=document.forms['frmCirc'].elements['NIVEL_'+id].value;
	document.forms['frmCirc'].elements['ORDEN'].value=document.forms['frmCirc'].elements['ORDEN_'+id].value;
	document.forms['frmCirc'].elements['NOMBRE'].value=document.forms['frmCirc'].elements['NOMBRE_'+id].value;
	document.forms['frmCirc'].elements['LISTACENTROS'].value=document.forms['frmCirc'].elements['IDCENTROCLIENTE_'+id].value;
	document.forms['frmCirc'].elements['LISTACOMPRADORES'].value=document.forms['frmCirc'].elements['IDCOMPRADOR_'+id].value;
	document.forms['frmCirc'].elements['LISTAAPROBADORES'].value=document.forms['frmCirc'].elements['IDAPROBADOR_'+id].value;
	document.forms['frmCirc'].elements['LISTACONDICIONES'].value=document.forms['frmCirc'].elements['CONDICION_'+id].value;

	var Condicion=jQuery("#LISTACONDICIONES").val().substring(0,4);
	if (Condicion==='IMPO')
	{
		Valor='';
		jQuery("#CATEGORIAS").hide();	
		jQuery("#PROVEEDORES").hide();	
	}
	else if (Condicion==='CATE')
	{
		jQuery("#LISTACATEGORIAS").val(document.forms['frmCirc'].elements['VALOR_'+id].value);
		jQuery("#CATEGORIAS").show();	
		jQuery("#PROVEEDORES").hide();	
	}
	else if (Condicion==='PROV')
	{
		Valor=jQuery("#LISTAPROVEEDORES").val(document.forms['frmCirc'].elements['VALOR_'+id].value);
		jQuery("#CATEGORIAS").hide();	
		jQuery("#PROVEEDORES").show();	
	}

	document.forms['frmCirc'].elements['IMPORTE'].value=document.forms['frmCirc'].elements['IMPORTE_'+id].value;

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
					+'|'+document.forms['frmCirc'].elements['LISTAAPROBADORES'].value;

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
		document.forms['frmCirc'].elements['LISTACOMPRADORES'].value='';
	}
	else
	{
		//	Muestra solo los usuarios del centro correspondiente
		var Centro=jQuery("#LISTACENTROS option:selected").text();
		//solodebug console.log("CambiaCentro:"+Centro);

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


//	Comprueba que el importe sea numérico o lo deja a 0
function ComprobarImporte()
{
	var Importe=document.forms['frmCirc'].elements['IMPORTE'].value.replace('.','').replace(',','.');

	console.log(Importe);

	if (isNaN(Importe))
	{
		alert(errImporteIncorrecto);
		document.forms['frmCirc'].elements['IMPORTE'].value='0';
	}
}


