// JavaScript Document
// mi -11-07-11

jQuery(document).ready(globalEvents);

function globalEvents(){
	// DC - 19/03/13 - Recargo el frame de ZonaProducto por si se ha quitado de la plantilla
	EjecutarFuncionDelFrame('zonaProducto','recargarPagina()');
/*
	jQuery("#cerrarCargaDoc").mouseover(function(){this.style.cursor="pointer";});
	jQuery("#cerrarCargaDoc").mouseout(function(){this.style.cursor="default";});
	jQuery("#cerrarCargaDoc").click(function(){jQuery("#cargaOferta").hide();jQuery("#botonesMantenPRO").show();});
*/	
}//fin de globalEvents

function quitarDePLantilla(empresa, producto){

	var form = document.forms['form1'];

	form.elements['ACTION'].value = 'BORRAR';
	form.elements['ID_PRODUCTO'].value = producto;
	form.elements['ID_EMPRESA'].value = empresa;

	form.action=document.location+'&ACTION=BORRAR&ID_PRODUCTO='+producto+'&ID_EMPRESA='+empresa;
	SubmitForm(form);

	/*alert(usuario+proveedor+producto);
	jQuery.ajax({
		url:"confirmBorraDePLantilla.xsql",
		data: "ID_PROVEEDOR="+proveedor+"&ID_PRODUCTO="+producto,
		type: "GET",
		contentType: "application/xhtml+xml",
		beforeSend:function(){
			jQuery('#confirmBox').hide();
			document.getElementById('waitBox').src = 'http://www.newco.dev.br/images/loading.gif';
	},
	error:function(objeto, quepaso, otroobj){
		alert("objeto:"+objeto);
		alert("otroobj:"+otroobj);
		alert("quepaso:"+quepaso);
	},
	success:function(data){
		var doc=eval("(" + data + ")");
		//alert('doc '+data);
		if (data.match('error')){
			var dataOne = data.split('error');
			var dataTwo = dataOne[1].split('}');
			var dataThree = dataTwo[0].split(':');
			var error = dataThree[1];
			//alert(error);
			jQuery('#confirmBox').text(error);
		}
		if (data.match('ok')){
			jQuery('#confirmBox').text('Datos enviados con exito');
		}
		jQuery('#waitBox').hide();
		jQuery('#confirmBox').css("color", "#FF0000");
		jQuery('#confirmBox').css("font-weight", "bold");
		jQuery('#confirmBox').show();

		alert(document.location);
		document.location.reload(true);
	}
	}); //FIN AJAX*/
}

function EjecutarFuncionDelFrame(nombreFrame,nombreFuncion){

	var objFrame=new Object();
	objFrame=obtenerFrame(top, nombreFrame);
	if(objFrame!=null){
		var retorno=eval('objFrame.'+nombreFuncion);
		if(retorno!=undefined){
			return retorno;
		}
	}
}