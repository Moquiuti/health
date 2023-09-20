/*
	JS para la catalogación rápida
	Ultima revision: ET 20feb23 18:30 CatalogacionRapida2022_200223.js
*/

//	Activar Parsley
jQuery(function () {
  jQuery('#frmProducto').parsley().on('field:validated', function() {
    var ok = jQuery('.parsley-error').length === 0;
    jQuery('.bs-callout-info').toggleClass('hidden', !ok);
    jQuery('.bs-callout-warning').toggleClass('hidden', ok);
  })
  .on('form:submit', function() {
	console.log("submit");
  });
});

//	Inicializacion
function onloadEvents()
{
	//solodebug	console.log('Inicio');
	
	//	Comprueba si el producto esta adjudicado, en cuyo caso bloquea los campos del formulario
	if (jQuery('#IDPRODUCTO').val()!='')
		BloquearCampos();
}


//	centalizamos el envío del form para facilitar añadir código de depuración
function Enviar()
{
	var Precio=jQuery('#PRECIO').val();
	jQuery('#PRECIO').val(Precio.replaceAll('.',''));
	
	//solodebug	console.log('Enviar. CREARVARIANTE:'+jQuery('#CREARVARIANTE').val());
	//solodebug	alert('Enviar. CREARVARIANTE:'+jQuery('#CREARVARIANTE').val());
	
	jQuery('#frmProducto').submit();
}

//	Guarda los datos y adjudica el producto
function AdjudicarProducto()
{
	//solodebug	console.log('AdjudicarProducto');
	
	jQuery('#ACTION').val('ADJUDICAR');
	Enviar();	
}

//	Desadjudica el producto
function DesadjudicarProducto()
{
	//solodebug	console.log('DesadjudicarProducto');
	
	jQuery('#ACTION').val('DESADJUDICAR');
	Enviar();
	
}

//	Desadjudica el producto
function ActualizarProducto()
{
	//solodebug	console.log('ActualizarProducto');
	
	if (jQuery('#CREARVARIANTE').val()=='S')
		jQuery('#ACTION').val('ADJUDICAR');
	else
		jQuery('#ACTION').val('ACTUALIZAR');
		
	Enviar();
	
}

//	Guarda los datos y adjudica el producto
function AbrirCatalogoProveedor()
{
	var IDProveedor=jQuery('#IDPROVEEDOR').val();
	var IDEmpresa=jQuery('#IDEMPRESA').val();
	
	//solodebug	console.log('AbrirCatalogoProveedor. IDProveedor:'+IDProveedor);

	javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Productos/CatalogoProveedor2022.xsql?IDPROVEEDOR='+IDProveedor+'&IDEMPRESA='+IDEmpresa+'&ORIGEN=CATRAPIDA','CatalogoProveedor',50,80,90,20);
}

//	Cambio en el checkbox de "Crear variante". Si está activo, desbloquear todo.
function CambioCrearVariante()
{
	if (jQuery('#chkCREARVARIANTE').prop('checked'))
	{
		Limpiar();	
		jQuery('#chkCREARVARIANTE').prop('disabled',true);
		jQuery('#CREARVARIANTE').val('S');
	}
	else
		jQuery('#CREARVARIANTE').val('N');
}


//	Actualiza los cvalores del formulario desde página externa
function ActualizarCampos(id,ref, prod, marca, udbasica, udlote, precio)
{
	document.forms['frmProducto'].elements['IDPRODUCTO'].value = id;
	document.forms['frmProducto'].elements['REFERENCIA'].value = ref;
	document.forms['frmProducto'].elements['NOMBRE'].value = prod;
	document.forms['frmProducto'].elements['MARCA'].value = marca;
	document.forms['frmProducto'].elements['UNIDADBASICA'].value = udbasica;
	document.forms['frmProducto'].elements['UNIDADESLOTE'].value = udlote;
	document.forms['frmProducto'].elements['PRECIO'].value = precio;
	
	document.forms['frmProducto'].elements['IDPROVEEDOR'].disabled=true;
	document.forms['frmProducto'].elements['REFERENCIA'].disabled=true;
	document.forms['frmProducto'].elements['NOMBRE'].disabled=true;
	document.forms['frmProducto'].elements['MARCA'].disabled=true;
	
	jQuery('#btnLimpiar').show();
}

//	limpia los campos, reactiva los bloqueados
function Limpiar()
{
	document.forms['frmProducto'].elements['IDPRODUCTO'].value = '';
	document.forms['frmProducto'].elements['REFERENCIA'].value = '';
	document.forms['frmProducto'].elements['NOMBRE'].value = '';
	document.forms['frmProducto'].elements['MARCA'].value = '';
	document.forms['frmProducto'].elements['UNIDADBASICA'].value = '';
	document.forms['frmProducto'].elements['UNIDADESLOTE'].value = '';
	document.forms['frmProducto'].elements['PRECIO'].value = '';
	
	document.forms['frmProducto'].elements['IDPROVEEDOR'].disabled=false;
	document.forms['frmProducto'].elements['REFERENCIA'].disabled=false;
	document.forms['frmProducto'].elements['NOMBRE'].disabled=false;
	document.forms['frmProducto'].elements['MARCA'].disabled=false;
	document.forms['frmProducto'].elements['UNIDADBASICA'].disabled=false;		//	Por si la llamada viene de ActualizarCampos
	document.forms['frmProducto'].elements['UNIDADESLOTE'].disabled=false;
	document.forms['frmProducto'].elements['PRECIO'].disabled=false;

	jQuery('#btnLimpiar').hide();
	jQuery('#btnCatalogo').show();
}

//	Bloquea los campos del formulario
function BloquearCampos()
{
	document.forms['frmProducto'].elements['IDPROVEEDOR'].disabled=true;
	document.forms['frmProducto'].elements['REFERENCIA'].disabled=true;
	document.forms['frmProducto'].elements['NOMBRE'].disabled=true;
	document.forms['frmProducto'].elements['MARCA'].disabled=true;
	//document.forms['frmProducto'].elements['UNIDADBASICA'].disabled=true;
	//document.forms['frmProducto'].elements['UNIDADESLOTE'].disabled=true;
	//document.forms['frmProducto'].elements['PRECIO'].disabled=true;
	//document.forms['frmProducto'].elements['IDTIPOIVA'].disabled=true;

	jQuery('#btnActualizar').show();
	jQuery('#btnLimpiar').hide();
	jQuery('#btnCatalogo').hide();
	jQuery('#btnAdjudicar').hide();
}


