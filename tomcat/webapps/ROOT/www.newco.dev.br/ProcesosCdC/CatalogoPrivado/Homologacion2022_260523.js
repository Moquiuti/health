//	JS para mantenimiento de homologación pro prod. estándar y centro
//	Ultima revisión ET 26mar23 12:15 Homologacion2022_260523.js


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
			var Autorizado='N';
			
			if (jQuery('#CHK_CENTRO_'+ID).prop('checked')) Autorizado='S';

			cadenaOrden=cadenaOrden+ID+'#'+Orden+'#'+Autorizado+'|';

			//solodebug	console.log('Elemento:'+form.elements[i].name+' checked:'+form.elements[i].checked+' Cadena:'+cadenaOrden);
		}
	}
	//solodebug	alert(cadenaOrden)
	
	form.elements['ACCION'].value='ACTUALIZAR_ORDEN';
	form.elements['PARAMETROS'].value=cadenaOrden;
	
	EnviarCambios();	
}



//	28mar23 Muestra el boton de guardar ref
function ActivaBtnGuardarRef(IDCentro)
{
	jQuery("#chkOK").hide();
	jQuery("#chkOK").hide();
	jQuery("#btnGuardaRef").show();
}


//	28mar23 Guardar la referencia del centro
function GuardarRefCentro()
{
	var RefEstandar=jQuery("#REFERENCIA").val(),
		IDCentro=jQuery("#IDCENTRO").val(),
		Referencia=jQuery("#REFCENTRO").val();
	
	//solodebug	
	console.log('GuardarRefCentro. RefEstandar:'+RefEstandar+' IDCentro:'+IDCentro+' Referencia:'+Referencia);

   	jQuery("#btnGuardaRef").hide();

	var d = new Date();
    jQuery.ajax({
        cache:    false,
        url:    'http://www.newco.dev.br/ProcesosCdC/CatalogoPrivado/CambiarReferenciaCentroAjax.xsql',
        type:    "GET",
        data:    "REFESTANDAR="+RefEstandar+"&IDCENTRO="+IDCentro+"&REFERENCIA="+Referencia+"&_="+d.getTime(),
        contentType: "application/xhtml+xml",
        error: function(objeto, quepaso, otroobj){
            alert('error'+quepaso+' '+otroobj+' '+objeto);
        },
        success: function(objeto){
			var data = JSON.parse(objeto);

            if(data.Estado == 'OK'){
				jQuery(".RefCentro").html(Referencia);
            	jQuery("#chkOK").show();
            }else{
            	jQuery("#chkOK").show();
            }
        }
    });


}












