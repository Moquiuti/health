// JavaScript Document
// dc 19-03-14

var mostrarCategoria, mostrarGrupo;

jQuery(document).ready(onLoadEvents);

function onLoadEvents(){
	// Los checkbox 'ADJUDICADO' y 'SINUSAR' son incompatibles
	jQuery('input#ADJUDICADO').click(function(){
		evaluarChckboxAdjudicado();
		if(this.checked == true)
			jQuery('#SINUSAR').removeAttr('checked');
	});
	jQuery('input#SINUSAR').click(function(){
		if(this.checked == true){
			jQuery('#ADJUDICADO').removeAttr('checked');
			evaluarChckboxAdjudicado();
		}
	});

	// Si existe el desplegable de Cliente (estamos en Catalogo Cliente) mostramos el desplegable del primer nivel del cliente por defecto
	if(jQuery('select#IDCLIENTE').length && origen != 'CATCLIENTES_S')
		NivelesEmpresa(jQuery('select#IDCLIENTE').val());

	// Checkbox 'primeros pedidos' es incompatible con "Sin consumo reciente"
	if(jQuery('input#PRIMEROSPEDIDOS').is(':checked')){
		jQuery('input#SIN_CONSUMO').removeAttr('checked').attr("disabled", true);
	}else{
		jQuery('input#SIN_CONSUMO').removeAttr("disabled");
	}
	if(jQuery('input#SIN_CONSUMO').is(':checked')){
		jQuery('input#PRIMEROSPEDIDOS').removeAttr('checked').attr("disabled", true);
	}else{
		jQuery('input#PRIMEROSPEDIDOS').removeAttr("disabled");
	}
	jQuery('input#PRIMEROSPEDIDOS').click(function(){
		if(this.checked !== true){
			jQuery('input#SIN_CONSUMO').removeAttr("disabled");
		}else{
			jQuery('input#SIN_CONSUMO').removeAttr('checked').attr("disabled", true);
		}
	});
	jQuery('input#SIN_CONSUMO').click(function(){
		if(this.checked !== true){
			jQuery('input#PRIMEROSPEDIDOS').removeAttr("disabled");
		}else{
			jQuery('input#PRIMEROSPEDIDOS').removeAttr('checked').attr("disabled", true);
		}
	});

	// Toogle buscador avanzado catalogo privado
	jQuery('img#toogleBuscador').click(function(){
		if(jQuery('tr#auxToogle').is(":hidden")){
			jQuery('tr#auxToogle').show();
			jQuery('img#toogleBuscadorLic').hide();
		}else{
			jQuery('tr#auxToogle').hide();
			jQuery('img#toogleBuscadorLic').show();
		}
	});
	// Toogle buscador licitaciones catalogo privado
	jQuery('img#toogleBuscadorLic').click(function(){
		if(jQuery('tr#auxToogleLic').is(":hidden")){
			jQuery('tr#auxToogleLic').show();
			jQuery('img#toogleBuscador').hide();
		}else{
			jQuery('tr#auxToogleLic').hide();
			jQuery('img#toogleBuscador').show();
		}
	});
}

function evaluarChckboxAdjudicado(){
	// Si checkbox 'adjudicado' esta inactivo => 3 nuevos checkboxes inactivos
	if(jQuery('input#ADJUDICADO').is(':checked')){
		jQuery('input#PRIMEROSPEDIDOS').removeAttr("disabled");
		jQuery('input#CON_CONSUMO').removeAttr("disabled");
		jQuery('input#SIN_CONSUMO').removeAttr("disabled");
	}else{
		jQuery('input#PRIMEROSPEDIDOS').attr("disabled", true);
		jQuery('input#CON_CONSUMO').attr("disabled", true);
		jQuery('input#SIN_CONSUMO').attr("disabled", true);
	}
}
/*
		function EjecutarFuncionDelFrame(nombreFrame,idProductoEstandar){
			var objFrame=new Object();
			objFrame=obtenerFrame(top, nombreFrame);
			objFrame.CambioProductoEstandarActual(idProductoEstandar,'CAMBIOPRODUCTOESTANDAR');
		}

		function EnviarBusqueda(form){
			SubmitForm(form);
		}

		function EjecutarEnviarBusqueda(){
			EnviarBusqueda(document.forms[0]);
		}

		function recargarPagina(tipo){
			EnviarBusqueda(document.forms[0]);
			if(tipo=='PROPAGAR'){
				var objFrameTop=new Object();
				objFrameTop=window.top;
				var objFrame=new Object();
				objFrame=obtenerFrame(objFrameTop,'zonaCatalogo');
				objFrame.recargarPagina();
			}
		}
*/

// Envia la busqueda en funcion del listado seleccionado
function Busqueda(formu,origen,type){
	var enviarBusqueda;
	var MaxRegistros = 500;

//	if(formu.elements['IDFAMILIA'].value=='-1' && formu.elements['PRODUCTO'].value=='' && formu.elements['IDPROVEEDOR'].value=='-1'){
	if(formu.elements['IDFAMILIA'].value=='-1'){
		formu.elements['IDSUBFAMILIA'].value = '-1';
	}

	if(formu.elements['SINUSAR'] && formu.elements['SINUSAR'].checked == true)
		formu.elements['SINUSAR'].value = 'S';
	else if(formu.elements['SINUSAR'] && formu.elements['SINUSAR'].checked == false)
		formu.elements['SINUSAR'].value = 'NULL';

	if(formu.elements['ADJUDICADO'] && formu.elements['ADJUDICADO'].checked == true)
		formu.elements['ADJUDICADO'].value = 'S';
	else if(formu.elements['ADJUDICADO'] && formu.elements['ADJUDICADO'].checked == false)
		formu.elements['ADJUDICADO'].value = 'NULL';

	if(formu.elements['PRIMEROSPEDIDOS'] && formu.elements['PRIMEROSPEDIDOS'].checked == true)
		formu.elements['PRIMEROSPEDIDOS'].value = 'S';
	else if(formu.elements['PRIMEROSPEDIDOS'])
		formu.elements['PRIMEROSPEDIDOS'].value = 'NULL';

	if(formu.elements['CON_CONSUMO'] && formu.elements['CON_CONSUMO'].checked == true)
		formu.elements['CON_CONSUMO'].value = 'S';
	else if(formu.elements['CON_CONSUMO'])
		formu.elements['CON_CONSUMO'].value = 'NULL';

	if(formu.elements['SIN_CONSUMO'] && formu.elements['SIN_CONSUMO'].checked == true)
		formu.elements['SIN_CONSUMO'].value = 'S';
	else if(formu.elements['SIN_CONSUMO'])
		formu.elements['SIN_CONSUMO'].value = 'NULL';

	if(formu.elements['INFORMAR_X_CENTRO'] && formu.elements['INFORMAR_X_CENTRO'].checked == true)
		formu.elements['INFORMAR_X_CENTRO'].value = 'S';
	else if(formu.elements['INFORMAR_X_CENTRO'])
		formu.elements['INFORMAR_X_CENTRO'].value = 'NULL';

        if(formu.elements['SOLO_PROD_ESTANDAR'] && formu.elements['SOLO_PROD_ESTANDAR'].checked == true)
		formu.elements['SOLO_PROD_ESTANDAR'].value = 'S';
	else if(formu.elements['SOLO_PROD_ESTANDAR'])
		formu.elements['SOLO_PROD_ESTANDAR'].value = 'NULL';

	// Mostramos un mensaje de alerta si es el listado completo y TotalRegistros > 'var MaxRegistros'
	if(TotalRegistros > MaxRegistros){
		if(((formu.elements['IDCATEGORIA'] && formu.elements['IDCATEGORIA'].value=='-1')		// Todas las categorias (5 niveles)
		   || (!formu.elements['IDCATEGORIA'] && formu.elements['IDFAMILIA'] && formu.elements['IDFAMILIA'].value=='-1'))	// Todas las familias (3 niveles)
		   && formu.elements['PRODUCTO'].value=='' && formu.elements['IDPROVEEDOR'].value=='-1'		// Todos los proveedores
		   && formu.elements['SINUSAR'] && formu.elements['SINUSAR'].value=='NULL'			// Checkbox 'vacio' no seleccionado
		   && (formu.elements['CON_CONSUMO'] && formu.elements['CON_CONSUMO'].value=='NULL')		// Si es buscador avanzado => Checkbox 'Con consumo �ltimo a�o' no seleccionado
		   && (formu.elements['PRIMEROSPEDIDOS'] && formu.elements['PRIMEROSPEDIDOS'].value=='NULL')	// Si es buscador avanzado => Checkbox 'Primeros pedidos' no seleccionado
		   && (formu.elements['SIN_CONSUMO'] && formu.elements['SIN_CONSUMO'].value=='NULL')		// Si es buscador avanzado => Checkbox 'Sin consumo reciente' no seleccionado
		   && (formu.elements['IDLICITACION'] && formu.elements['IDLICITACION'].value=='-1')		// Si no se escoge nada del desplegable licitaciones
		){
                        if(confirm(confirmFullSearch))
				enviarBusqueda	= true;
		}else
			enviarBusqueda	= true;
	}else
		enviarBusqueda	= true;

        //si es cat clientes y si el cliente no esta selecionado debo selecionar almeno 1 checkbox de los 4 estando pinchado adjudicado
        if (origen =='CATCLIENTES'){
//            if (formu.elements['IDCLIENTE'] && formu.elements['IDCLIENTE'].value == '-1' && formu.elements['IDCENTROCLIENTE'] && formu.elements['IDCENTROCLIENTE'].value == '-1' && formu.elements['INFORMAR_X_CENTRO'].value != 'S' && formu.elements['SIN_CONSUMO'].value != 'S' && formu.elements['CON_CONSUMO'].value != 'S' && formu.elements['PRIMEROSPEDIDOS'].value != 'S'){
            if (formu.elements['IDCLIENTE']  && formu.elements['IDCENTROCLIENTE'] && formu.elements['INFORMAR_X_CENTRO'].value == 'S' && formu.elements['SIN_CONSUMO'].value != 'S' && formu.elements['CON_CONSUMO'].value != 'S' && formu.elements['PRIMEROSPEDIDOS'].value != 'S'){
                alert(seleccionarDespl);
                enviarBusqueda	= false;
            }
            else if (formu.elements['INFORMAR_X_CENTRO'] && formu.elements['INFORMAR_X_CENTRO'].value == 'S' && formu.elements['SIN_CONSUMO'].value == 'S' && formu.elements['CON_CONSUMO'].value != 'S' ){
                alert(seleccionarConConsumoAnt);
                enviarBusqueda	= false;
            }
        }
        //si es cat privado y seleciono por centro tengo que seleccionar almeno uno de los otros checkbox
        else{
            if (formu.elements['INFORMAR_X_CENTRO'] && formu.elements['INFORMAR_X_CENTRO'].value == 'S' && formu.elements['SIN_CONSUMO'].value != 'S' && formu.elements['CON_CONSUMO'].value != 'S' && formu.elements['PRIMEROSPEDIDOS'].value != 'S'){
                alert(seleccionarDesplCatPriv);
                enviarBusqueda	= false;
            }
            else if (formu.elements['INFORMAR_X_CENTRO'] && formu.elements['INFORMAR_X_CENTRO'].value == 'S' && formu.elements['SIN_CONSUMO'].value == 'S' && formu.elements['CON_CONSUMO'].value != 'S' ){
                alert(seleccionarConConsumoAnt);
                enviarBusqueda	= false;
            }

        }

	if(enviarBusqueda==true){
		// IDINFORME siempre tiene valor 'Comisiones'
		AsignarAccion(formu,'PreciosYComisiones.xsql?ORIGEN='+origen+'&TYPE='+type);
		SubmitForm(formu);
	}
}

function handleKeyPress(e){
	var keyASCII;

	if(navigator.appName.match('Microsoft'))
		keyASCII = event.keyCode;
	else
		keyASCII = (e.which);

	if(keyASCII == 13)
		Busqueda(document.forms[0]);
}

// Asignamos la funci�n handleKeyPress al evento
if(navigator.appName.match('Microsoft')==false)
	document.captureEvents();
document.onkeypress = handleKeyPress;


// Cambio de familias segun la categoria
function SeleccionaDesplFamilia(categoria){
	var ACTION="http://www.newco.dev.br/ProcesosCdC/CatalogoPrivado/Familias.xsql";
	var post='IDCATEGORIA='+categoria+'&IDCLIENTE='+IDCliente;

	if(categoria != -1 && categoria!=0)
		sendRequest(ACTION,handleRequestFamiliaDespl,post);

	if(categoria == -1 || categoria ==0 ){
		jQuery("#IDFAMILIA").hide();
		jQuery("#labelFamilia").hide();
		jQuery("#desplFamilia").hide();
		document.forms[0].elements['IDFAMILIA'].value = '-1';
	}
}


function handleRequestFamiliaDespl(req){
	var response = eval("(" + req.responseText + ")");
	var Resultados = new String('');

	if(response.Filtros != ''){
		for(var i=0; i < response.Filtros.length; i++){
			Resultados =Resultados+' <option value="'+response.Filtros[i].Fitro.id+'">'+response.Filtros[i].Fitro.nombre+'</option>';
		}
		jQuery("#IDFAMILIA").show();
		jQuery("#labelFamilia").show();
		jQuery("#desplFamilia").show();
		jQuery("#IDFAMILIA").html(Resultados);
		document.forms['Busqueda'].elements['IDFAMILIA'].value = '-1';
	}
	return true;
}

// Veo si devuelvo categoria 5 niveles o familia 3 niveles (funcion del buscador de catalogo clientes)
function NivelesEmpresa(IDPadre){
	var idEmpresa = IDPadre;
	var d = new Date();

	// Ponemos un filtro para que no se hagan peticiones ajax si no hay empresa seleccionada
	if(idEmpresa != -1){
		jQuery.ajax({
			url:	'http://www.newco.dev.br/Gestion/EIS/EISNivelesEmpresa.xsql',
			type:	"GET",
			data:	"IDEmpresa="+idEmpresa+'&_='+d.getTime(),
			contentType: "application/xhtml+xml",
			error: function(objeto, quepaso, otroobj){
				alert('error'+quepaso+' '+otroobj+''+objeto);
			},
			success: function(objeto){
				var data		= eval("(" + objeto + ")");

				var IDEmpresa		= data.NivelesEmpresa.IDEmpresa;
				mostrarCategoria	= data.NivelesEmpresa.MostrarCategorias;
				mostrarGrupo		= data.NivelesEmpresa.MostrarGrupos;

				if(mostrarCategoria == 'S'){
					jQuery("#IDFAMILIA").empty().hide();
					jQuery("#labelFamilia").hide();
					jQuery("#desplFamilia").hide();
					jQuery("#IDSUBFAMILIA").empty().hide();
					jQuery("#labelSubFamilia").hide();
					jQuery("#desplSubFamilia").hide();
					if(jQuery("#IDGRUPO").length) {
						jQuery("#IDGRUPO").empty().hide();
						jQuery("#labelGrupo").hide();
						jQuery("#desplGrupo").hide();
					}
					// Estamos en 5 niveles, hay que utilizar el nivel de grupos
					jQuery('#IDSUBFAMILIA').bind("change", function(){
						SeleccionaGrupo(this.value);
					});
					SeleccionaCategoria(IDEmpresa);
				}else{
					document.forms['Busqueda'].elements['IDCATEGORIA'].value = '-1';
					jQuery("#IDCATEGORIA").empty().hide();
					jQuery("#labelCategoria").hide();
					jQuery("#desplCategoria").hide();
					jQuery("#IDFAMILIA").empty().show();
					jQuery("#labelFamilia").show();
					jQuery("#desplFamilia").show();
					jQuery("#IDSUBFAMILIA").empty().hide();
					jQuery("#labelSubFamilia").hide();
					jQuery("#desplSubFamilia").hide();
					if(jQuery("#IDGRUPO").length) {
						jQuery("#IDGRUPO").empty().hide();
						jQuery("#labelGrupo").hide();
						jQuery("#desplGrupo").hide();
					}
					// Estamos en 3 niveles, NO hay que utilizar el nivel de grupos
					jQuery('#IDSUBFAMILIA').unbind("change");
					SeleccionaFamilia(IDEmpresa);
				}
			}
		});
	}
}

function DescargarExcel(){
	var idcliente;
	if(jQuery('#IDCLIENTE').length){
		idcliente = jQuery('#IDCLIENTE').val();
	}else{
		idcliente = ''  ;
	}
	var idinforme = jQuery('#IDINFORME').val();
	var idcategoria;
	if(jQuery('#IDCATEGORIA').length && jQuery('#IDCATEGORIA').val() != ''){
		idcategoria = jQuery('#IDCATEGORIA').val();
	}else{
		idcategoria = -1;
	}
	var idfamilia;
	if(jQuery('#IDFAMILIA').length && jQuery('#IDFAMILIA').val() != ''){
		idfamilia = jQuery('#IDFAMILIA').val();
	}else{
		idfamilia = -1;
	}
	var idsubfamilia;
	if(jQuery('#IDSUBFAMILIA').length && jQuery('#IDSUBFAMILIA').val() != ''){
		idsubfamilia = jQuery('#IDSUBFAMILIA').val();
	}else{
		idsubfamilia = -1;
	}
	var idgrupo;
	if(jQuery('#IDGRUPO').length && jQuery('#IDGRUPO').val() != ''){
		idgrupo = jQuery('#IDGRUPO').val();
	}else{
		idgrupo = -1;
	}
	var idproveedor;
	if(jQuery('#IDPROVEEDOR').length && jQuery('#IDPROVEEDOR').val() != ''){
		idproveedor = jQuery('#IDPROVEEDOR').val();
	}else{
		idproveedor = -1;
	}

	var proveedor = '';
	var producto = encodeURIComponent(jQuery('#PRODUCTO').val());

//	var idcentro = jQuery('#IDCENTRO').val();

	var sinusar;
	if(jQuery('#SINUSAR').attr("checked") == true){
		sinusar = 'S';
	}else{
		sinusar = '';
	}
	var adjudicado;
	if(jQuery('#ADJUDICADO').attr("checked") == true){
		adjudicado = 'S';
	}else{
		adjudicado = '';
	}

	var mes = jQuery('#MES').val();
	var anno = jQuery('#ANNO').val();

	var primerosPedidos;
	if(jQuery('#PRIMEROSPEDIDOS').length && jQuery('#PRIMEROSPEDIDOS').attr("checked") == true){
		primerosPedidos = 'S';
	}else{
		primerosPedidos = '';
	}

	var conConsumo;
	if(jQuery('#CON_CONSUMO').length && jQuery('#CON_CONSUMO').attr("checked") == true){
		conConsumo = 'S';
	}else{
		conConsumo = '';
	}

	var sinConsumo;
	if(jQuery('#SIN_CONSUMO').length && jQuery('#SIN_CONSUMO').attr("checked") == true){
		sinConsumo = 'S';
	}else{
		sinConsumo = '';
	}

	var informarXCentro;
	if(jQuery('#INFORMAR_X_CENTRO').length && jQuery('#INFORMAR_X_CENTRO').attr("checked") == true){
		informarXCentro = 'S';
	}else{
		informarXCentro = '';
	}

//	var idcentro = jQuery('#IDCENTROCLIENTE').val();
	var idcentro;
	if(jQuery('#IDCENTROCLIENTE').length){
		idcentro = jQuery('#IDCENTROCLIENTE').val();
	}else{
		idcentro = '-1';
	}

	var consumoMinimo = jQuery('#CONSUMO_MINIMO').val();

	var idlicitacion;
	if(jQuery('#IDLICITACION').length){
		idlicitacion = jQuery('#IDLICITACION').val();
	}else{
		idlicitacion = '-1';
	}
	jQuery.ajax({
		url:	"http://www.newco.dev.br/ProcesosCdC/CatalogoPrivado/PreciosYComisionesExcel.xsql",
		data:	"IDCLIENTE="+idcliente+"&IDINFORME="+idinforme+"&IDFAMILIA="+idfamilia+"&IDCATEGORIA="+idcategoria+"&IDSUBFAMILIA="+idsubfamilia+"&IDGRUPO="+idgrupo+"&IDPROVEEDOR="+idproveedor+"&PRODUCTO="+producto+"&PROVEEDOR="+proveedor+"&IDCENTROCLIENTE="+idcentro+"&SINUSAR="+sinusar+"&ADJUDICADO="+adjudicado+"&MES="+mes+"&ANNO="+anno+"&PRIMEROSPEDIDOS="+primerosPedidos+"&CON_CONSUMO="+conConsumo+"&SIN_CONSUMO="+sinConsumo+"&INFORMAR_X_CENTRO="+informarXCentro+"&CONSUMO_MINIMO="+consumoMinimo+"&IDLICITACION="+idlicitacion,

		type:	"GET",
		contentType: "application/xhtml+xml",
		beforeSend: function(){
			null;
		},
		error: function(objeto, quepaso, otroobj){
			alert('error'+quepaso+' '+otroobj+''+objeto);
		},
		success: function(objeto){
			var data = eval("(" + objeto + ")");

			if(data.estado == 'ok')
				window.location='http://www.newco.dev.br/Descargas/'+data.url;
			else
				alert('Se ha producido un error. No se puede descargar el fichero.');
		}
	});
}

// Peticion ajax que recupera el desplegable de proveedores cuando se elige una nueva empresa (nueva funcion para Catalogo de Clientes)
function SeleccionaProveedor(IDEmpresa){
	var d = new Date();
        var IDPais = document.forms['Busqueda'].elements['IDPAIS'].value;

	jQuery.ajax({
		url:	"http://www.newco.dev.br/ProcesosCdC/CatalogoPrivado/Proveedores.xsql",
		type:	"GET",
		data:	"IDPAIS="+IDPais+"&IDCLIENTE="+IDEmpresa+"&_="+d.getTime(),
		contentType: "application/xhtml+xml",
		error: function(objeto, quepaso, otroobj){
			alert('error'+quepaso+' '+otroobj+''+objeto);
		},
		success: function(objeto){
			var data = eval("(" + objeto + ")");
			var Resultados = new String('');

			if(data.Filtros.length > 1){
				for(var i=0; i<data.Filtros.length; i++){
					Resultados = Resultados+' <option value="'+data.Filtros[i].Fitro.id+'">'+data.Filtros[i].Fitro.nombre+'</option>';
				}
			}else{
				Resultados = '<option value="-1">' + txtTodos + '</option>';
			}

			jQuery("#IDPROVEEDOR").show();
			jQuery("#labelProveedor").show();
			jQuery("#IDPROVEEDOR").html(Resultados);
			document.forms['Busqueda'].elements['IDPROVEEDOR'].value = '-1';

			// Recuperamos el desplegable de centros de cliente si esta activo
			if(jQuery('#IDCENTROCLIENTE').length > 0)
				SeleccionaCentros(IDEmpresa);
		}
	});
}

// Peticion ajax que recupera el desplegable de centros cuando se elige una nueva empresa
function SeleccionaCentros(IDEmpresa){
	var d = new Date();

	jQuery.ajax({
		url:	"http://www.newco.dev.br/ProcesosCdC/CatalogoPrivado/ListaCentrosAJAX.xsql",
		type:	"GET",
		data:	"IDEMPRESA="+IDEmpresa+"&_="+d.getTime(),
		contentType: "application/xhtml+xml",
		error: function(objeto, quepaso, otroobj){
			alert('error'+quepaso+' '+otroobj+''+objeto);
		},
		success: function(objeto){
			var data = eval("(" + objeto + ")");
			var Resultados = new String('');

			if(data.Filtros.length > 1){
				for(var i=0; i<data.Filtros.length; i++){
					Resultados = Resultados+' <option value="'+data.Filtros[i].Filtro.id+'">'+data.Filtros[i].Filtro.nombre+'</option>';
				}
			}else{
				Resultados = '<option value="-1">' + txtTodos + '</option>';
			}

			jQuery("#IDCENTROCLIENTE").html(Resultados);
			document.forms['Busqueda'].elements['IDCENTROCLIENTE'].value = '-1';
		}
	});
}

// Peticion ajax que devuelve el desplegable de categorias (empresas de 5 niveles)
function SeleccionaCategoria(IDEmpresa){
	var d = new Date();

	jQuery.ajax({
		url:	"http://www.newco.dev.br/ProcesosCdC/CatalogoPrivado/CategoriasAJAX.xsql",
		type:	"GET",
		data:	"IDEMPRESA="+IDEmpresa+"&_="+d.getTime(),
		contentType: "application/xhtml+xml",
		error: function(objeto, quepaso, otroobj){
			alert('error'+quepaso+' '+otroobj+''+objeto);
		},
		success: function(objeto){
			var data = eval("(" + objeto + ")");
			var Resultados = new String('');

			if(data.Filtros.length > 1){
				for(var i=0; i<data.Filtros.length; i++){
					Resultados = Resultados+' <option value="'+data.Filtros[i].Filtro.id+'">'+data.Filtros[i].Filtro.nombre+'</option>';
				}
			}else{
				Resultados = '<option value="-1">' + txtTodas + '</option>';
			}

			jQuery("#IDCATEGORIA").html(Resultados).val('-1').show();
			jQuery("#desplCategoria").show();
		}
	});
}

// Peticion ajax que devuelve el desplegable de familias (empresas de 5 o 3 niveles)
function SeleccionaFamilia(IDCategoria){
	var IDCategoria	= document.forms['Busqueda'].elements['IDCATEGORIA'].value;
	var d = new Date();
	var IDEmpresa;

	if(IDCategoria == -1){
		jQuery("#IDFAMILIA").val('-1');
		if(mostrarCategoria == 'S')
			jQuery("#desplFamilia").hide();
		return;
	}


	if(jQuery('#IDCLIENTE').length)
		IDEmpresa	= jQuery('#IDCLIENTE').val();
	else
		IDEmpresa	= IDCliente;

	jQuery.ajax({
		url:	"http://www.newco.dev.br/ProcesosCdC/CatalogoPrivado/FamiliasAJAX.xsql",
		type:	"GET",
		data:	"IDCLIENTE="+IDEmpresa+"&IDCATEGORIA="+IDCategoria+"&_="+d.getTime(),
		contentType: "application/xhtml+xml",
		error: function(objeto, quepaso, otroobj){
			alert('error'+quepaso+' '+otroobj+''+objeto);
		},
		success: function(objeto){
			var data = eval("(" + objeto + ")");
			var Resultados = new String('');

			if(data.Filtros.length > 1){
				for(var i=0; i<data.Filtros.length; i++){
					Resultados = Resultados+' <option value="'+data.Filtros[i].Filtro.id+'">'+data.Filtros[i].Filtro.nombre+'</option>';
				}
			}else{
				Resultados = '<option value="-1">' + txtTodas + '</option>';
			}

			jQuery("#IDFAMILIA").html(Resultados).val('-1').show();
			jQuery("#desplFamilia").show();
		}
	});
}

// Peticion ajax que devuelve el desplegable de subfamilias (empresas de 5 o 3 niveles)
function SeleccionaSubFamilia(IDFamilia){
	var d = new Date();

	if(IDFamilia == -1){
		jQuery("#desplSubFamilia").hide();
		jQuery("#IDSUBFAMILIA").val('-1');
		if(mostrarCategoria == 'S')
			jQuery("#desplCategoria").show();
		return;
	}

	jQuery.ajax({
		url:	"http://www.newco.dev.br/ProcesosCdC/CatalogoPrivado/SubFamiliasAJAX.xsql",
		type:	"GET",
		data:	"IDFAMILIA="+IDFamilia+"&_="+d.getTime(),
		contentType: "application/xhtml+xml",
		error: function(objeto, quepaso, otroobj){
			alert('error'+quepaso+' '+otroobj+''+objeto);
		},
		success: function(objeto){
			var data = eval("(" + objeto + ")");
			var Resultados = new String('');

			if(data.Filtros.length > 1){
				for(var i=0; i<data.Filtros.length; i++){
					Resultados = Resultados+' <option value="'+data.Filtros[i].Filtro.id+'">'+data.Filtros[i].Filtro.nombre+'</option>';
				}
			}else{
				Resultados = '<option value="-1">' + txtTodas + '</option>';
			}

			jQuery("#IDSUBFAMILIA").html(Resultados).val('-1').show();
			jQuery("#desplCategoria").hide();
			jQuery("#desplSubFamilia").show();
		}
	});
}

// Peticion ajax que devuelve el desplegable de subfamilias (empresas de 5 o 3 niveles)
function SeleccionaGrupo(IDSubfam){
	var d = new Date();

	if(IDSubfam == -1){
		jQuery("#desplGrupo").hide();
		jQuery("#desplFamilia").show();
		jQuery("#IDGRUPO").val('-1');
		return;
	}

	jQuery.ajax({
		url:	"http://www.newco.dev.br/ProcesosCdC/CatalogoPrivado/GruposAJAX.xsql",
		type:	"GET",
		data:	"IDSUBFAMILIA="+IDSubfam+"&_="+d.getTime(),
		contentType: "application/xhtml+xml",
		error: function(objeto, quepaso, otroobj){
			alert('error'+quepaso+' '+otroobj+''+objeto);
		},
		success: function(objeto){
			var data = eval("(" + objeto + ")");
			var Resultados = new String('');

			if(data.Filtros.length > 1){
				for(var i=0; i<data.Filtros.length; i++){
					Resultados = Resultados+' <option value="'+data.Filtros[i].Filtro.id+'">'+data.Filtros[i].Filtro.nombre+'</option>';
				}
			}else{
				Resultados = '<option value="-1">' + txtTodas + '</option>';
			}

			jQuery("#IDGRUPO").html(Resultados).val('-1').show();
			jQuery("#desplFamilia").hide();
			jQuery("#desplGrupo").show();
		}
	});
}

///////////////////////////////////////////////////////////////////////////////
///		FUNCIONES PARA OPTIMIZAR / LIMPIAR
//////////////////////////////////////////////////////////////////////////////

// Cambio de subfamilias segun la familia
function SeleccionaSubFamiliaX(familia){
	var ACTION="http://www.newco.dev.br/ProcesosCdC/CatalogoPrivado/SubFamilias.xsql";
	var post='IDFAMILIA='+familia;

	if(familia != -1 && familia!=0){
		sendRequest(ACTION,handleRequestSubFamilia,post);
	}
	if(familia == -1 || familia ==0 ){
		jQuery("#IDSUBFAMILIA").hide();
		jQuery("#labelSubFamilia").hide();
		jQuery("#desplSubFamilia").hide();
		jQuery("#IDCATEGORIA").show();
		jQuery("#labelCategoria").show();
		jQuery("#desplCategoria").show();

		document.forms[0].elements['IDSUBFAMILIA'].value = '-1';
	}
}

function handleRequestSubFamilia(req){
	var response = eval("(" + req.responseText + ")");
	var Resultados = new String('');

	if(response.Filtros != ''){
		for(var i=0; i < response.Filtros.length; i++){
			Resultados =Resultados+' <option value="'+response.Filtros[i].Fitro.id+'">'+response.Filtros[i].Fitro.nombre+'</option>';
		}
		jQuery("#IDCATEGORIA").hide();
		jQuery("#labelCategoria").hide();
		jQuery("#desplCategoria").hide();
		jQuery("#IDSUBFAMILIA").show();
		jQuery("#labelSubFamilia").show();
		jQuery("#desplSubFamilia").show();
		jQuery("#IDSUBFAMILIA").html(Resultados);
		document.forms['Busqueda'].elements['IDSUBFAMILIA'].value = '-1';
	}
	return true;
}

// Cambio de familias segun clientes
function SeleccionaFamiliaX(cliente){
	var categoria = document.forms['Busqueda'].elements['IDCATEGORIA'].value;
	var clienteActual = document.forms['Busqueda'].elements['IDCLIENTE'].value;
	var ACTION="http://www.newco.dev.br/ProcesosCdC/CatalogoPrivado/FamiliasAJAX.xsql";
//alert(categoria);
	if(categoria == '-1')
		var post='IDCLIENTE='+clienteActual;
	else
		var post='IDCLIENTE='+clienteActual+'&IDCATEGORIA='+categoria;

	if(cliente != -1 && cliente!=0) sendRequest(ACTION,handleRequestFamilia,post);

	if(cliente == -1 || cliente ==0 ){
		jQuery("#IDFAMILIA").hide();
		jQuery("#labelFamilia").hide();
		jQuery("#desplFamilia").hide();
		document.forms[0].elements['IDFAMILIA'].value = '-1';
	}
}

function handleRequestFamilia(req){
	var response = eval("(" + req.responseText + ")");
	var Resultados = new String('');

	if(response.Filtros != ''){
		for(var i=0; i < response.Filtros.length; i++){
			Resultados =Resultados+' <option value="'+response.Filtros[i].Filtro.id+'">'+response.Filtros[i].Filtro.nombre+'</option>';
		}

		jQuery("#IDFAMILIA").html(Resultados);
		jQuery("#IDFAMILIA").show();
		jQuery("#labelFamilia").show();
		jQuery("#desplFamilia").show();
		document.forms['Busqueda'].elements['IDFAMILIA'].value = '-1';
	}
	return true;
}

// Cambio de familias segun clientes
function SeleccionaCategoriaX(cliente){
	var ACTION="http://www.newco.dev.br/ProcesosCdC/CatalogoPrivado/Categorias.xsql";
	var post='IDCLIENTE='+cliente;

	if(cliente != -1 && cliente!=0)
		sendRequest(ACTION,handleRequestCategoria,post);

	if(cliente == -1 || cliente ==0 ){
		jQuery("#IDCATEGORIA").hide();
		jQuery("#labelCategoria").hide();
		jQuery("#desplCategoria").hide();
		document.forms[0].elements['IDCATEGORIA'].value = '-1';
	}
}

function handleRequestCategoria(req){
	var response = eval("(" + req.responseText + ")");
	var Resultados = new String('');

	if(response.Filtros != ''){
		for(var i=0; i < response.Filtros.length; i++){
			Resultados =Resultados+' <option value="'+response.Filtros[i].Fitro.id+'">'+response.Filtros[i].Fitro.nombre+'</option>';
		}

		jQuery("#IDCATEGORIA").show();
		jQuery("#labelCategoria").show();
		jQuery("#desplCategoria").show();
		jQuery("#IDCATEGORIA").html(Resultados);
		document.forms['Busqueda'].elements['IDCATEGORIA'].value = '-1';
	}
	return true;
}

function NuevaBusqueda(IDCat, IDFam, IDSfam, IDGru){

	// Limpiamos los campos del buscador
	if(jQuery('#PRODUCTO').length)		jQuery('#PRODUCTO').val('');
	if(jQuery('#IDPROVEEDOR').length)	jQuery('#IDPROVEEDOR').val('-1');
	if(jQuery('#MES').length)		jQuery('#MES').val('-1');
	if(jQuery('#ANNO').length)		jQuery('#ANNO').val('-1');
	if(jQuery('#SINUSAR').length)		jQuery('#SINUSAR').removeAttr('checked');
	if(jQuery('#ADJUDICADO').length)	jQuery('#ADJUDICADO').removeAttr('checked');
        // Limpiamos los campos del buscador avanzado
	if(jQuery('#IDCENTROCLIENTE').length)	jQuery('#IDCENTROCLIENTE').val('-1');
	if(jQuery('#CON_CONSUMO').length)	jQuery('#CON_CONSUMO').removeAttr('checked');
	if(jQuery('#CONSUMO_MINIMO').length)	jQuery('#CONSUMO_MINIMO').val('0');
	if(jQuery('#PRIMEROSPEDIDOS').length)	jQuery('#PRIMEROSPEDIDOS').removeAttr('checked');
	if(jQuery('#SIN_CONSUMO').length)	jQuery('#SIN_CONSUMO').removeAttr('checked');
	if(jQuery('#INFORMAR_X_CENTRO').length)	jQuery('#INFORMAR_X_CENTRO').removeAttr('checked');

	// 5 niveles
//	if(jQuery('#IDCATEGORIA').length){
	if(mostrarCategoria == 'S'){
		jQuery('#IDCATEGORIA').val(IDCat);
		SeleccionaFamilia(IDCat);

		if(IDFam !== -1){
			// Meto un timeout para dar tiempo a que el desplegable de familias se cargue
			setTimeout(function(){
				jQuery('#IDFAMILIA').val(IDFam);
				SeleccionaSubFamilia(IDFam);

				if(IDSfam !== -1){
					// Meto un timeout para dar tiempo a que el desplegable de subfamilias se cargue
					setTimeout(function(){
						jQuery('#IDSUBFAMILIA').val(IDSfam);
						SeleccionaGrupo(IDSfam);

						if(IDGru !== -1){
							// Meto un timeout para dar tiempo a que el desplegable de subfamilias se cargue
							setTimeout(function(){
								jQuery('#IDGRUPO').val(IDGru);
							}, 500);
						}
					}, 500);
				}
			}, 500);
		}

	// 3 niveles
	}else{
		jQuery('#IDFAMILIA').val(IDFam);
		SeleccionaSubFamilia(IDFam);

		if(IDSfam !== -1){
			// Meto un timeout para dar tiempo a que el desplegable de subfamilias se cargue
			setTimeout(function(){
				jQuery('#IDSUBFAMILIA').val(IDSfam);
			}, 500);
		}
	}
}
