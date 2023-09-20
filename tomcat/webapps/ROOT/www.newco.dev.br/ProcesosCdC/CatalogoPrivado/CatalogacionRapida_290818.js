/*
	JS para la catalogación rápida
	UltimaRevisión: ET 31ago18 11:15
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
	console.log('Inicio');
	
	//	Comprueba si el producto esta adjudicado, en cuyo caso bloquea los campos del formulario
	if (jQuery('#IDPRODUCTO').val()!='')
		BloquearCampos();
}


//	Guarda los datos y adjudica el producto
function AdjudicarProducto()
{
	console.log('AdjudicarProducto');
	
	jQuery('#ACTION').val('ADJUDICAR');
	jQuery('#frmProducto').submit();
	
}

//	Desadjudica el producto
function DesadjudicarProducto()
{
	console.log('DesadjudicarProducto');
	
	jQuery('#ACTION').val('DESADJUDICAR');
	jQuery('#frmProducto').submit();
	
}

//	Desadjudica el producto
function ActualizarProducto()
{
	console.log('ActualizarProducto');
	
	jQuery('#ACTION').val('ACTUALIZAR');
	jQuery('#frmProducto').submit();
	
}

//	Guarda los datos y adjudica el producto
function AbrirCatalogoProveedor()
{
	var IDProveedor=jQuery('#IDPROVEEDOR').val();
	var IDEmpresa=jQuery('#IDEMPRESA').val();
	
	console.log('AbrirCatalogoProveedor. IDProveedor:'+IDProveedor);
	javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Productos/CatalogoProveedor.xsql?IDPROVEEDOR='+IDProveedor+'&IDEMPRESA='+IDEmpresa+'&ORIGEN=CATRAPIDA','CatalogoProveedor',50,80,90,20);
}

//	Cambio en el checkbox de "Crear variante". Si está activo, desbloquear todo.
function CambioCrearVariante()
{
	if (jQuery('#CREARVARIANTE').prop('checked'))
	{
		Limpiar();	
		jQuery('#CREARVARIANTE').prop('disabled',true);
	}
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


