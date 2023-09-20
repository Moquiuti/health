//	JS para mantenimiento de homologación pro prod. estándar y centro
//	Ultima revisión ET 19may22 12:30 Homologacion2022_190522.js


function EnviarCambios()
{
	var form=document.forms['frmHomologacion'];

	//solodebug	
	var Cadena=form.elements['IDCENTRO'].value+'|'+form.elements['ACCION'].value+'|'+form.elements['PARAMETROS'].value;
	//solodebug	
	console.log('Cadena:'+Cadena);

	SubmitForm(form);
}

function CambioCentro()
{
	//var form=document.forms['frmHomologacion'];
	//var IDCentro=form.elements['IDCENTRO'].value;
	
	//alert('IDCentro:'+IDCentro);
	
	EnviarCambios();
}


//	Marca un proveedor como desbloqueado
function BloquearProveedor(IDProveedor, IDProdEstandar,  Estado)
{
	var form=document.forms['frmHomologacion'];
	form.elements['ACCION'].value=(Estado=='S')?'DESACTIVAR_PROVEEDOR':'REACTIVAR_PROVEEDOR';
	form.elements['PARAMETROS'].value=IDProveedor+'|'+form.elements['FECHA_'+IDProdEstandar].value+'|'+form.elements['EXPLI_'+IDProdEstandar].value;
	
	document.getElementsByName('btnProveedor_'+IDProveedor)[0].style.display = 'none';
	document.getElementById('waitProveedor_'+IDProveedor).style.display = 'block';
	
	EnviarCambios();
}


//	Marca un producto sin stock 
function ProductoSinStock(IDProdEstandar, Estado)
{
	var form=document.forms['frmHomologacion'];
	form.elements['ACCION'].value=(Estado=='S')?'DESACTIVAR_PRODUCTO':'REACTIVAR_PRODUCTO';
	form.elements['PARAMETROS'].value=IDProdEstandar+'|'+form.elements['FECHA_'+IDProdEstandar].value+'|'+form.elements['EXPLI_'+IDProdEstandar].value;
	
	document.getElementsByName('btnProducto_'+IDProdEstandar)[0].style.display = 'none';
	document.getElementById('waitProducto_'+IDProdEstandar).style.display = 'block';

	EnviarCambios();
}


function EnviarOrden()
{
	var form=document.forms['frmHomologacion'];
	
	//	Prepara la lista de productos y orden
	var cadenaOrden='';
	for (i=0;i<form.elements.length;++i)
	{
		//solodebug	console.log('Comprobando elemento:'+form.elements[i].name);
		if (form.elements[i].name.substring(0,6)=='ORDEN_')
		{
			var ID=Piece(form.elements[i].name,'_',1);
			var Orden=form.elements[i].value;

			cadenaOrden=cadenaOrden+ID+'#'+Orden+'|';

			//solodebug	console.log('Elemento:'+form.elements[i].name+' checked:'+form.elements[i].checked+' Cadena:'+cadenaCentros);
		}
	}
	//solodebug	alert(cadenaCentros)
	
	form.elements['ACCION'].value='ACTUALIZAR_ORDEN';
	form.elements['PARAMETROS'].value=cadenaOrden;
	
	EnviarCambios();	
}
