//	JS Informar procedimientos en convocatoria de elementos especiales. Nuevo disenno 2022.
//	Ultima revision ET 23may22 11:23. ProcedimientoYOfertas2022_230522.js


//	2oct18	Funciones para paginación del listado
function Enviar(){
	var form=document.forms[0];

	SubmitForm(form);
}

function CambioDesplegables(Tipo)
{

	console.log('CambioDesplegables'+Tipo);

	if (Tipo=='CAMBIO_CONVOCATORIA')
		document.forms[0].elements['FIDPROVEEDOR'].value=-1;

	Enviar();
}


function Orden(Campo)
{
	if (Campo==document.forms[0].elements['ORDEN'].value)
	{	
		document.forms[0].elements['SENTIDO'].value=(document.forms[0].elements['SENTIDO'].value=='DESC')?'ASC':'DESC';
	}
	else
	{
		document.forms[0].elements['ORDEN'].value=Campo;

		if (Campo=='REEMBCARTERA')
			document.forms[0].elements['SENTIDO'].value='DESC';
		else
			document.forms[0].elements['SENTIDO'].value='ASC';
	}

	//console.log('3.- Orden (sol.'+Campo+') Nueva ordenación real:'+document.forms[0].elements['ORDEN'].value+' '+document.forms[0].elements['SENTIDO'].value);

	Enviar();
}

function VerProveedor(IDProveedor)
{
	var Url='http://www.newco.dev.br/ProcesosCdC/ConvocatoriasEspeciales/InformarProcedimientos2022.xsql?'
			+'FIDCONVOCATORIA='+IDConvocatoria			//23may22	document.forms["Procedimiento"].elements["FIDCONVOCATORIA"].value
			+'&FIDESPECIALIDAD='+document.forms["Procedimiento"].elements["FIDESPECIALIDAD"].value
			+'&FIDPROCEDIMIENTO='+document.forms["Procedimiento"].elements["FIDPROCEDIMIENTO"].value
			+'&FIDPROVEEDOR='+IDProveedor;

//	console.log('VerProveedor Pendiente. IDProveedor:'+IDProveedor+ Url:'+Url);
	window.location=Url;
}

function OrdenAdjudicacionAutomatico()
{
	jQuery("select").each(function()
	{
    	//solodebug	console.log('Nombre:'+jQuery(this).attr("name").substring(0,5));

		if (jQuery(this).attr("name").substring(0,5)=='ORDEN')
		{
			var Control=jQuery(this).attr("name");
			var ID=Piece(jQuery(this).attr("name"),'_',1);
			var Orden=jQuery('#CONT_'+ID).val();

        	//solodebug	console.log('Control:'+Control+' ID:'+ID+' Valor anterior:'+jQuery(this).val()+' Orden:'+Orden);

			jQuery(this).val(Orden);
		}
	});
}

function GuardarAdjudicacion()
{
	console.log('GuardarAdjudicacion: Pendiente');
	var Cadena='';

	jQuery("select").each(function()
	{
    	//solodebug	console.log('Nombre:'+jQuery(this).attr("name").substring(0,5));

		if (jQuery(this).attr("name").substring(0,5)=='ORDEN')
		{
			var Control=jQuery(this).attr("name");
			var ID=Piece(jQuery(this).attr("name"),'_',1);
			var Orden=jQuery(this).val();

        	//solodebug	console.log('Control:'+Control+' ID:'+ID+' Valor anterior:'+jQuery(this).val()+' Orden:'+Orden);

			if (Orden==-1)
				Cadena+=ID+'|'+'N'+'|-1#';
			else
				Cadena+=ID+'|'+'S'+'|'+Orden+'#';

		}
	});

	document.forms[0].elements['ACCION'].value='GUARDAR';
	document.forms[0].elements['PARAMETROS'].value=Cadena;

	//solodebug	
	console.log('Guardar:'+Cadena);

	Enviar();
}


function Procedimientos()
{
	document.location='http://www.newco.dev.br/ProcesosCdC/ConvocatoriasEspeciales/BuscadorProcedimientos2022.xsql?FIDCONVOCATORIA='+IDConvocatoria;
}

function Productos()
{
	document.location='http://www.newco.dev.br/ProcesosCdC/ConvocatoriasEspeciales/BuscadorProductos2022.xsql?FIDCONVOCATORIA='+IDConvocatoria;
}

function Proveedores()
{
	document.location='http://www.newco.dev.br/ProcesosCdC/ConvocatoriasEspeciales/Proveedores2022.xsql?FIDCONVOCATORIA='+IDConvocatoria;
}




