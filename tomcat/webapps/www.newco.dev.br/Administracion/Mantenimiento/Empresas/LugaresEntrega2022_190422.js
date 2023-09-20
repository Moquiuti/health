//	JS mantenimiento lugares de entrega
//	Ultima revision: ET 19abr22 09:00 LugaresEntrega2022_190422.js
function CerrarVentana()
{
	window.close();
	Refresh(top.opener.document);
}

function EditarLugarEntrega(cen_id, lugar_id)
{
	document.location.href='http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/LugaresEntrega2022.xsql?CEN_ID='+cen_id+'&LUGAR_ID='+lugar_id+'&ACCION=EDITAR';
}


function BorrarLugarEntrega(idCentro, idLugar, accion)
{
	document.forms[0].elements['ACCION'].value=accion; 
	document.forms[0].elements['CEN_ID'].value=idCentro;
	document.forms[0].elements['LUGAR_ID'].value=idLugar;

	var idPorDefecto=ObtenerIDdeCheck(document.forms[0], 'CHECKPORDEFECTO_');
	var idPorDefectoFarmacia=idPorDefecto;		//14jun18 //ObtenerIDdeCheck(document.forms[0], 'CHECKPORDEFECTOFARMACIA_');
	document.forms[0].elements['IDPORDEFECTO'].value=idPorDefecto+'|'+idPorDefectoFarmacia; 

	//if((document.forms[0].elements['CHECKPORDEFECTO_'+idLugar].checked==true)||(document.forms[0].elements['CHECKPORDEFECTOFARMACIA_'+idLugar].checked==true))
	if(document.forms[0].elements['CHECKPORDEFECTO_'+idLugar].checked==true)
	    alert(msgBorrarPorDefecto);
	else
        SubmitForm(document.forms[0]);
}	


function ActualizarDatos(form, accion)
{
	form.elements['ACCION'].value=accion; 

	if(document.forms[0].elements['CHECKNUEVOPORDEFECTO'].checked==true)
	  document.forms[0].elements['NUEVOPORDEFECTO'].value='S';
	else
	  document.forms[0].elements['NUEVOPORDEFECTO'].value='N';

/*	14jun18

	if(document.forms[0].elements['CHECKNUEVOPORDEFECTOFARMACIA'].checked==true)
	  document.forms[0].elements['NUEVOPORDEFECTOFARMACIA'].value='S';
	else
	  document.forms[0].elements['NUEVOPORDEFECTOFARMACIA'].value='N';
*/
    if(accion=='NUEVO')
	 {
		document.forms[0].elements['LUGAR_ID'].value=0;
        var refer = new Array();

        jQuery("#form1").find(':input').each(function() {
            var elemento= this;
            var ele = elemento.name.split('_');
            if (ele[0] == 'REF'){
                refer.push(elemento.value);
            }
        });

        var dupliRef = '';

        //compruebo que la referencia sea unica, que no se repita
        for (var i=0;i<refer.length;i++){
            if (refer[i] ==  document.forms[0].elements['NUEVAREFERENCIA'].value){
                dupliRef = 'S';
            }
        }
        if(dupliRef == ''){
            if(validarFormulario(form)){ 
                    SubmitForm(document.forms[0]);
                }
        }
        else { alert(referenciaDuplicada); }


    }
    else if(accion=='GUARDAR')
	{
		if(validarFormulario(form))
		{ 
    		SubmitForm(document.forms[0]);
		}
    }
    else if(accion=='CAMBIARPORDEFECTO')
	{
        var hemosAvisado=0;
		idPorDefecto=ObtenerIDdeCheck( document.forms[0], 'CHECKPORDEFECTO_');
		idPorDefectoFarmacia=idPorDefecto;	//14jun18	ObtenerIDdeCheck(document.forms[0], 'CHECKPORDEFECTOFARMACIA_');
		document.forms[0].elements['IDPORDEFECTO'].value=idPorDefecto+'|'+idPorDefectoFarmacia; 

		//solodebug	alert('IDPORDEFECTO:'+document.forms[0].elements['IDPORDEFECTO'].value);

        if(document.forms[0].elements['IDPORDEFECTO'].value=='|')
            alert(msgSinPorDefectoError);
		else
       		SubmitForm(document.forms[0]);

    }
}


function validarFormulario(form){
  var errores=0;

      if((!errores) && (document.forms[0].elements['NUEVAREFERENCIA'].value=='')){
        alert('Debe proporcionar una referencia para el lugar de entrega');
        document.forms[0].elements['NUEVAREFERENCIA'].focus();
        errores++;
      }

      if((!errores) && (document.forms[0].elements['NUEVONOMBRE'].value=='')){
        alert('Debe proporcionar un nombre para el lugar de entrega');
        document.forms[0].elements['NUEVONOMBRE'].focus();
        errores++;
      }

      if((!errores) && (document.forms[0].elements['NUEVAPOBLACION'].value=='')){
        alert('Debe proporcionar la población para el lugar de entrega');
        document.forms[0].elements['NUEVAPOBLACION'].focus();
        errores++;
      }

      if((!errores) && (document.forms[0].elements['NUEVADIRECCION'].value=='')){
        alert('Debe proporcionar una dirección para el lugar de entrega');
        document.forms[0].elements['NUEVADIRECCION'].focus();
        errores++;
      }

      if((!errores) && (document.forms[0].elements['NUEVOCPOSTAL'].value=='')){
        alert('Debe proporcionar el código postal para el lugar de entrega');
        document.forms[0].elements['NUEVOCPOSTAL'].focus();
        errores++;
      }

  if(!errores)
    return true;  
}


function comprobarCheck(form, obj, nombre)
{
  if(obj.checked==true)
  {
      for(var n=0;n<form.length;n++)
	  {
        if(form.elements[n].name.substring(0,nombre.length)==nombre && form.elements[n].name!=obj.name)
          form.elements[n].checked=false;
      }
	}
}


function ObtenerIDdeCheck(form, nombre)		
{
    var IDDelCheck='';
	for(var n=0;n<form.length;n++)
	{
		if(form.elements[n].name.substring(0,nombre.length)==nombre && form.elements[n].checked==true)
		{
			id=obtenerId(form.elements[n].name);
			if(!isNaN(id))
			  	IDDelCheck=id; 
		}
	}
	return IDDelCheck;
}


function CentroSeleccionado()
{
	var IDCentro=document.forms[0].elements['IDCENTROENTREGA'].value;

	//Busca los datos del centro vía Ajax para informarlos en el formulario
	jQuery.ajax({
		url:"datosCentroAJAX.xsql",
		data: "IDCENTRO="+IDCentro,
		type: "GET",
		async: false,
		contentType: "application/xhtml+xml",
		beforeSend:function(){

		  console.log('datosCentroAJAX.xsql:'+IDCentro);

		},
		error:function(objeto, quepaso, otroobj){
		  alert("objeto:"+objeto);
		  alert("otroobj:"+otroobj);
		  alert("quepaso:"+quepaso);
		},
		success:function(data){
			//var doc=eval("(" + data + ")"); eval is deprecated
			console.log('datosCentroAJAX.xsql:'+IDCentro+' data:'+data);
			res = JSON.parse(data);			
			console.log('datosCentroAJAX.xsql:'+IDCentro+' res:'+res);

			document.forms[0].elements['NUEVADIRECCION'].value=res.Direccion;
			document.forms[0].elements['NUEVAPOBLACION'].value=res.Poblacion;
			document.forms[0].elements['NUEVOCPOSTAL'].value=res.CodPostal;
			document.forms[0].elements['NUEVAPROVINCIA'].value=res.Provincia;

			//solodebug console.log('revisarDocumento:'+IDDocumento+': '+stat+': '+color+'. Res AJAX: '+data);
		}
	});


}

//	Al cargar la página, informa los datos del centro por defecto
function Inicializa()
{
	CentroSeleccionado();
}
