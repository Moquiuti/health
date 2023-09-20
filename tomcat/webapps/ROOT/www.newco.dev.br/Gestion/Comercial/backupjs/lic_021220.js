//	Funciones JS de la página principal de la licitación
//	Ultima revisión ET 24set20 11:30 lic_021220.js
//	Cambios de version deben trasladarse a MantLicitacionHTML.xsl,ProductosParaExcelHTML.xsl,ImprimirOfertaHTML.xsl


//	Variables globales
// tabla productos
var		totalProductos,			// numero total de productos en la licitacion
		numProductos,			// numero de productos que se muestran en la tabla (desplegable numRegistros)
		pagProductos= 0,		// pagina actual
		pagsProdTotal,			// total de paginas segun valor numRegistros
		firstProduct,			// primer indice de producto a mostrar en la tabla
		lastProduct,			// ultimo indice de producto a mostrar en la tabla
		ColumnaOrdenacionProds	= 'NombreNorm',		//	19mar19	'linea',
		OrdenProds		= '',
		ColumnaOrdenadaProds	= [];

var		licCambiosEnOfertasSel;	//	2may17	Indica si han habido cambios en los checkboxes
		
//	tabla proveedores
var		totalProvs,			// numero total de proveedores en la licitacion
		ColumnaOrdenacionProvs='',			//	12nov19	Por defecto ordenamos por nombre corto del proveedor, antes nombrenorm
		OrdenProvs		= '',
		ColumnaOrdenadaProvs	= [];
		

//	22may19 Resumen de situación de las ofertas (antes variables locales, ahora globales para facilitar cálculos)
var	ConsumoPot,ConsumoPrev,Ahorro,numOfertas,numProdConOfe,numProdsAdjud,numProvsAdj;
		
var ProductExist = true;

var	arrRadios = new Array();

var	liciFirmada = '';

var	uploadFilesDoc = new Array();
var	periodicTimerDoc = 0;
//5mar19	var	form_tmp;
var	MAX_WAIT_DOC = 100;

var maxLineasParaInsertar = 500; 	//	19set16 Número máximo de líneas que pueden insertarse de una vez

//	Carga inicial
var mensajeEstadoActual, ctrlCargaProv;

function onloadEvents()
{	

	//	9jul18	Permitimos comunicar desde otras páginas de esta aplicación
	//no acaba de funcionar bien, desactivamos: window.addEventListener("message", receiveMessage, false);

	//	Cargamos los datos de ofertas de los proveedores informados, mostrando en el status cual carga en cada momento
	mensajeEstadoActual=jQuery('#idEstadoLic').html();
	ctrlCargaProv=true;
	
	//16mar18	if ((estadoLicitacion!='EST')&&(estadoLicitacion!='COMP'))-> Cargar siempre, si no se produce error de JS
	cargaDatosOfertasPorProveedores();
	
	jQuery('#idEstadoLic').html(mensajeEstadoActual);

	// Informar desplegable 'Duracion adjudicacion'
	seleccionaMeses();

	//	3may17 Indicamos que no hay cambios en ofertas
	CambiosEnOfertasSeleccionadas('N');	

	if ((rol=='COMPRADOR')||(numOfertas==0))
	{
		
		//solodebug	debug("onloadEvents. Activar pes_lDatosGenerales");

		//	Para compradores o proveedores sin ofertas, marcamos la primera opción de menú
		/*jQuery("#pes_lDatosGenerales").css('background','#3b569b');
		jQuery("#pes_lDatosGenerales").css('color','#D6D6D6');*/
		ActivarPestanna('pes_lDatosGenerales');	//	3feb20
		
	}
	else
	{
		
		//solodebug	debug("onloadEvents. Activar pes_lProductos");

		//	Para proveedores con ofertas, marcamos la pestaña de productos
		pes_lProductos_Click();
	}
	
	
	//	1jul20 Para usuario autor, rol comprador
	if (IDPais==55) ActivarPestannaProv('Selecciones');
	else ActivarPestannaProv('Proveedores');
	
	if (rol=='COMPRADOR')
		RevisarListaSelecciones();
	
	
	//	19set19 Muestra u oculta los campos según si es licitacion spot
	camposLicitacionSpot();

	// No permitimos cambiar desplegable de 'tamanyo de pagina' si se han hecho cambios en el form
	var valor;
	jQuery('#numRegistros').on('focus', function(){
		// Guardamos valor actual
		valor = this.value;
	}).change(function(){
		// Guardamos el dato de valor en otra variable pq despues se pierde
		var valPrevio = valor, chk = true;

		// Si hay cambios en el formulario, pedimos confirmacion
		if(anyChange){
			chk = confirm(conf_hayCambios);
		}

		if(!chk){
			jQuery('#numRegistros').val(valPrevio);
		}else{
			dibujaTablaProductos();
    }
	});

	// Controlamos si se hacen cambios en los inputs del formulario (eventos 'keyup' para teclado y 'paste' para copy/paste con mouse)
	jQuery('table#lProductos_OFE tbody, table#lProductos_PROVE tbody').on('focus', 'input[type=text]', function(){
		// Guardamos valor actual
		valor = this.value;
	}).on('keyup paste', 'input[type=text]', function(e){
		var valPrevio = valor, self = this;

		// Aplicamos un delay porque el evento 'paste' NO devuelve el nuevo valor actualizado
		setTimeout(function(e) {
			if(valPrevio !== jQuery(self).val()){
				anyChange = true;	// Activamos flag de control de cambios en el form
			}
		}, 0);
	});

	// validacion de precios en el lado del proveedor
	//9abr18	jQuery('table#lProductos_PROVE tbody').on('change', 'input[type=text].precio', function(){
	//9abr18		validarPreciosProv(this);
	//9abr18	});

	// Delegar evento click a todos los radio buttons que se generan en la tabla 'lProductos_OFE'
	jQuery('table#lProductos_OFE tbody').on('click', 'input[type=radio]', function(){
		anyChange = true;	// Activamos flag de control de cambios en el form
		recalcularFloatingBox(this, 1);
	});

	// Codigo javascript para mostrar/ocultar tablas cuando se clica en la pestanya 'Condiciones de la licitacion'
	jQuery("#pes_lDatosGenerales").click(function(){
	
		if (ctrlCargaProv) return;	//	Desactivamos durante la carga de proveedores
	
		var chk = true;

		if(anyChange){
			chk = confirm(conf_hayCambios);
		}

		if(chk){

			//	12dic16	Marcamos la pestaña seleccionada
			ActivarPestanna("pes_lDatosGenerales");

			OcultarTablasPestannas();
			jQuery(".lDatosGenerales").show();
		}
	});
	// Codigo javascript para mostrar/ocultar tablas cuando se clica en la pestanya 'Info pedido' -- solo para licitaciones de 'pedido puntual'
	jQuery("#pes_lInfoPedido").click(function(){
		var chk = true;

		if (ctrlCargaProv) return;	//	Desactivamos durante la carga de proveedores

		if(anyChange){
			chk = confirm(conf_hayCambios);
		}

		if(chk){

			//	12dic16	Marcamos la pestaña seleccionada
			ActivarPestanna("pes_lInfoPedido");

			OcultarTablasPestannas();
			jQuery(".tablaInfoPedido").show();
		}
	});
	
	
	// Codigo javascript para mostrar/ocultar tablas cuando se clica en la pestanya 'Productos'
	jQuery("#pes_lProductos").click(function(){
	
		pes_lProductos_Click();
	});

	
	// Codigo javascript para mostrar/ocultar tablas cuando se clica en la pestanya 'Productos' (versión compacta)
	jQuery("#pes_lProductosCompacta").click(function(){
		var chk = true;
		
		//solodebug
		debug("#pes_lProductosCompacta");
		
		

		if(anyChange){
			chk = confirm(conf_hayCambios);
		}

		if(chk){

			//	12dic16	Marcamos la pestaña seleccionada
			ActivarPestanna("pes_lProductosCompacta");

			OcultarTablasPestannas();
			jQuery(".tablaProductosCompacta").show();

      		generaTablaCompacta();
		}
	});
	// Codigo javascript para mostrar/ocultar tablas cuando se clica en la pestanya 'Proveedores'
	jQuery("#pes_lProveedores").click(function(){
		var chk = true;

		if (ctrlCargaProv) return;	//	Desactivamos durante la carga de proveedores

		if(anyChange){
			chk = confirm(conf_hayCambios);
		}

		if(chk){

			//	12dic16	Marcamos la pestaña seleccionada
			ActivarPestanna("pes_lProveedores");

			// Preparamos los datos para dibujar la tabla de la pestanya 'proveedores'
			//prepararTablaProveedores();
			dibujaTablaProveedores();

			OcultarTablasPestannas();
			jQuery("#lProveedores").show();
		}
	});
	// Si se hace click sobre el boton que informa de las conversaciones => se simula click sobre la pestanya de proveedores
	// 11ene17 Eliminamos este botón
	//jQuery("#ConversacionProv").click(function(){
	//	jQuery("#pes_lProveedores").trigger( "click" );
	//});
	// Codigo javascript para mostrar/ocultar tablas cuando se clica en la pestanya 'Usuarios'
	jQuery("#pes_lUsuarios").click(function(){
		var chk = true;

		if (ctrlCargaProv) return;	//	Desactivamos durante la carga de proveedores

		if(anyChange){
			chk = confirm(conf_hayCambios);
		}

		if(chk){

			//	12dic16	Marcamos la pestaña seleccionada
			ActivarPestanna("pes_lUsuarios");

			OcultarTablasPestannas();
			jQuery(".tablaUsuarios").show();
		}
	});
	// Codigo javascript para mostrar/ocultar tablas cuando se clica en la pestanya 'Centros'
	jQuery("#pes_lCentros").click(function(){
		var chk = true;

		if (ctrlCargaProv) return;	//	Desactivamos durante la carga de proveedores

		if(anyChange){
			chk = confirm(conf_hayCambios);
		}

		if(chk){

			//	12dic16	Marcamos la pestaña seleccionada
			ActivarPestanna("pes_lCentros");
			OcultarTablasPestannas();
			jQuery("#lCentros").show();
		}
	});
	// Codigo javascript para mostrar/ocultar tablas cuando se clica en la pestanya 'Resumen'
	jQuery("#pes_lResumen").click(function(){
		var chk = true;

		if (ctrlCargaProv) return;	//	Desactivamos durante la carga de proveedores

		if(anyChange){
			chk = confirm(conf_hayCambios);
		}

		if(chk){

			//	12dic16	Marcamos la pestaña seleccionada
			ActivarPestanna("pes_lResumen");
			OcultarTablasPestannas();
			jQuery("#lResumen").show();
		}
	});
	// Codigo javascript para mostrar/ocultar tablas cuando se clica en la pestanya 'Informes'
	jQuery("#pes_lInformes").click(function(){
		var chk = true;

		if (ctrlCargaProv) return;	//	Desactivamos durante la carga de proveedores

		if(anyChange){
			chk = confirm(conf_hayCambios);
		}

		if(chk){

			//	12dic16	Marcamos la pestaña seleccionada
			ActivarPestanna("pes_lInformes");
			OcultarTablasPestannas();
			jQuery("#lInformes").show();
		}
	});

	// Pestaña Proveedores/Selecciones
	jQuery("#pes_lpSelecciones").click(function(){
			ActivarPestannaProv("Selecciones");
	});

	// Pestaña Proveedores/Proveedores
	jQuery("#pes_lpProveedores").click(function(){
			ActivarPestannaProv("Proveedores");
	});

	// Codigo para mostrar un div flotante que se auto-posiciona aunque se haga scroll
	if(jQuery(".FBox").length){

		jQuery(window).scroll(function(){
		
		ColocaFloatingBox();

		});
    }

	// Sustituye la cadena [[SUBFAMILIAS]] en pestanya 'Productos' >> 'Anyadir productos por catálogo' para que corresponda con los niveles de la empresa
	jQuery('span.cambiarNivel').each(function(){
		jQuery(this).html(jQuery(this).text().replace('[[SUBFAMILIAS]]',txtNivel3));
	});

	// si hay campo en el desplegable de meses duracion => muestro o escondo los campos para pedidos puntuales
	jQuery('select#LIC_MESES').change(function(){
		
		camposLicitacionSpot();

	});
	// Si se hace cambio en el usuario responsable del pedido puntual => se recarga el desplegable de lugares de entrega
	jQuery('select#LIC_IDUSUARIOPEDIDO').change(function(){
		if(this.value != '')
			recuperaLugaresEntrega(this.value);
		else
			jQuery('select#LIC_IDLUGARENTREGA').empty().append("<option value=''>" + str_Selecciona + "</option>");
	});

	// Cambio en el tipo de vista de la pestanya productos
	jQuery("select#tipoVista").change(function(){
		muestraNuevaVistaProductos(this.value);
	});

	formateaTextareas();

	if ((rol=='VENDEDOR')&&(IDComunicado!=''))
		PresentaComunicado();

}

//	Separamos la función que oculta todas las pestannas
function OcultarTablasPestannas()
{
	jQuery(".lDatosGenerales").hide();
	if(jQuery("#pes_lInfoPedido").length)	jQuery(".tablaInfoPedido").hide();
	jQuery("#lProductos").hide();
	jQuery(".tablaProductosCompacta").hide();
	jQuery("#lProveedores").hide();
	jQuery(".tablaUsuarios").hide();
	if(jQuery("#pes_lCentros").length)	jQuery("#lCentros").hide();
	jQuery("#lResumen").hide();
	jQuery("#lInformes").hide();
}

function camposLicitacionSpot()
{

	try
	{	
		if((document.forms['form1'].elements['LIC_MESES'].value == '0')&&(isLicAgregada=='N')){ // Pedido puntual, y no es licitación agregada		
			jQuery('.campoPedidoPuntual').show();
			jQuery('.campoPedidoPuntual_Inv').hide();
		}else{
			jQuery('.campoPedidoPuntual').hide();
			jQuery('.campoPedidoPuntual_Inv').show();
		}
	}
	catch(err)
	{
	}
}


//	13mar19 Separamos esta función para poderser utilizada en la carga de la página ara proveedores con ofertas
function pes_lProductos_Click()
{

	if (ctrlCargaProv) return;	//	Desactivamos durante la carga de proveedores

	//	12dic16	Marcamos la pestaña seleccionada
	ActivarPestanna("pes_lProductos");


	// Preparamos los datos para dibujar la tabla de la pestanya 'productos'
	prepararTablaProductos(true);


	//	12jul19 Si está informado el pedido mínimo, muestra la tabla de productos
	if (PedidoMinimoPend=='S')
	{
		
		//solodebug	debug('pes_lProductos_Click. PedidoMinimoPend:S');
		
		jQuery("input.descripcion").attr("disabled",true);
		jQuery("input.marca").attr("disabled",true);
		jQuery("input.unidades").attr("disabled",true);
		jQuery("input.precio").attr("disabled",true);
	}

	jQuery(".lDatosGenerales").hide();
	if(jQuery("#pes_lInfoPedido").length)	jQuery(".tablaInfoPedido").hide();
	jQuery("#lProductos").show();
	jQuery(".tablaProductosCompacta").hide();
	jQuery("#lProveedores").hide();
	jQuery(".tablaUsuarios").hide();
	if(jQuery("#pes_lCentros").length)	jQuery("#lCentros").hide();
	jQuery("#lInforme").hide();

	ColocaFloatingBox();
}


//	13mar19 Separamos esta función para simplificar los cambios de pestaña principal
function ActivarPestanna(pestanna)
{
//	jQuery(".pestannas a").attr('class', 'MenuInactivo');
	jQuery("a.MenuLic").attr('class', 'MenuLic MenuInactivo');
	jQuery("#"+pestanna).attr('class', 'MenuLic MenuActivo');
}


//	Cambios de pestaña de proveedores
function ActivarPestannaProv(pestanna)
{
	//solodebug console.log('ActivarPestannaProv:'+pestanna)

	jQuery("a.MenuProv").attr('class', 'MenuProv MenuInactivo');
	jQuery("#pes_lp"+pestanna).attr('class', 'MenuProv MenuActivo');
	
	if (pestanna=='Selecciones')
	{
		jQuery("#lpProveedores").hide();
		jQuery("#lpSelecciones").show();
	}
	else
	{
		jQuery("#lpSelecciones").hide();
		jQuery("#lpProveedores").show();
	}
	
}


//	5dic16	Colocamos el floating box en su lugar
function ColocaFloatingBox()
{
	//	Colocamos el FloatingBox en su lugar
	if (mostrarResumenFlotante=='S')			//	9mar20 Solo para casos en que se muestre el resumen
		jQuery(".FBox").offset({ top: jQuery(window).scrollTop()+70, left: jQuery(window).width()-900 });
	else
		jQuery(".FBox").hide();
	
	//solodebug	debug('ColocaFloatingBox.top: '+(jQuery(window).scrollTop()+90)+' left:'+(jQuery(window).width()-900));
}




//	Carga los datos de las ofertas de los proveedores informados, vía ajax
function cargaDatosOfertasPorProveedores()
{
	var texto='';
	
	//solodebug	alert('arrProductos.length:'+arrProductos.length+' arrProveedores.length:'+arrProveedores.length+' arrConsumoProvs.length:'+ arrConsumoProvs.length);
	
	//	Creamos la matriz en blanco, para incluir todos los elementos necesarios

	for(var j=0; j<arrProductos.length; j++){
		
		Ofertas = new Array();
		
		for(var i=0; i < arrProveedores.length; i++){

			var oferta	= [];
			oferta['columna']	= i;
			oferta['IDOferta']	= '';
			oferta['IDProvLic']	= arrProveedores[i].IDProvLic;
			oferta['IDProv']	= arrProveedores[i].IDProveedor;			//13abr17 En algunos casos puede ser útil el ID de proveedor
			oferta['IDProdLic']	= arrProductos[j].IDProdLic;
			oferta['Referencia']	= '';	
			oferta['Nombre']	= '';
			oferta['Marca']		= '';
			oferta['FechaAlta']	= '';
			oferta['FechaMod']	= '';
			oferta['UdsXLote']	= '';
			oferta['Cantidad']	= '';
			oferta['Precio']	= '';
			oferta['PrecioIVA']	= '';
			oferta['TipoIVA']	= '';
			oferta['Consumo']	= '';
			oferta['ConsumoIVA']	= '';
			oferta['IDEstadoEval']	= '';
			oferta['Ahorro']	= '';
			oferta['EstadoEval']	= '';
			oferta['Alternativa'] = 0;				//	11mar19 Alternativa para permitir varias ofertas por producto

			// Campos Avanzados
			oferta['InfoAmpliada']	= '';
			oferta['Documento']	= [];
			// FIN Campos Avanzados

			oferta['PrecioColor'] = '';
			oferta['OfertaAdjud'] = '';
			oferta['Orden'] = '-1';					//	9jul18 Orden -1 para no adjudicado
			oferta['Sospechoso'] = '';

			oferta['FichaTecnica']	= [];

			oferta['NoInformada']	= 'S';
			oferta['NoOfertada']	= 'S';
			
			//solodebug	13abr17	if (j==0) debug('cargaDatosOfertasPorProveedores. Inicializar ofertas. columna:'+i+' IDProvLic:'+oferta['IDProvLic']+' IDProv:'+oferta['IDProv']);
			
			
			Ofertas.push(oferta);
		}
		
		arrProductos[j].Ofertas=Ofertas;		//	IMPORTANTE: el push da un error
	}	

	cargaDatosOfertasProveedoresAjax(0);
}

//	20mar17	Separamos la inicialización de la actualización Ajax
function cargaDatosOfertasProveedoresAjax(PosProvActual)
{
	var d		= new Date();
	var LicProvID;
	
	
	//solodebug
	//solodebug if (PosProvActual==0)
	//solodebug {
	//solodebug 	for(k=0;k<arrProveedores.length;++k)
	//solodebug 		debug('cargaDatosOfertasProveedoresAjax: Proveedor('+k+ '): ['+arrProveedores[k].IDProvLic+'] '+arrProveedores[k].NombreCorto);
	//solodebug 		
	//solodebug }
	//solodebug


	if (PosProvActual>=arrProveedores.length)
	{
		//solodebug debug('cargaDatosOfertasProveedoresAjax: PosProvActual:'+PosProvActual+ ' total:'+arrProveedores.length+ ' => TODOS CARGADOS');
		
		jQuery('#idEstadoLic').html(mensajeEstadoActual);
		ctrlCargaProv=false;

		//29may19	Inicializa los datos del FloatingBox
		if ((estadoLicitacion!='EST')&&(estadoLicitacion!='COMP'))
		{
			inicializaFloatingBox();
		}
		else
		{
			ConsumoPot=0;
			ConsumoPrev=0;
			Ahorro=0;
			numOfertas=0;
			numProvsAdj=0;
		}

		return;
	}
	else
	{
		//solodebug debug('cargaDatosOfertasProveedoresAjax: PosProvActual:'+PosProvActual+ ' total:'+arrProveedores.length+ ' => procesar este');
	}
	
	
	try	// No sale bien de la función, a pesar del return, al menos así evitamos errores
	{	

		//solodebug debug('cargaDatosOfertasProveedoresAjax: PosProvActual:'+PosProvActual+ ' total:'+arrProveedores.length+ ' => comprobando si tiene ofertas');

		//pendiente	jQuery('#idEstadoLic').show();

		//solodebug	alert ('Proveedor '||LicProvID||' en columna '+columna);
		// Si el proveedor no tiene ofertas no necesitamos hacer la petición
		//	18jul19 Si el proveedor no ha publicado la oferta, tampoco la hacemos
		if ((arrProveedores[PosProvActual].TieneOfertas!='S')
			||((arrProveedores[PosProvActual].IDEstadoProv!='INF')&&(arrProveedores[PosProvActual].IDEstadoProv!='ADJ')&&(arrProveedores[PosProvActual].IDEstadoProv!='FIRM')))
		{
			++PosProvActual;
			
			//solodebug	debug('cargaDatosOfertasProveedoresAjax: PosProvActual:'+PosProvActual+ ' total:'+arrProveedores.length+ ' => llamada recursiva SIN carga de datos');
			
			cargaDatosOfertasProveedoresAjax(PosProvActual);
			return;			// si no salimos aquí, se va a bucle infinito
			
		}

		//var columna=PosProvActual;
		LicProvID=arrProveedores[PosProvActual].IDProvLic;


		//solodebug 13abr17	debug('cargaDatosOfertasProveedoresAjax: TIENE OFERTA. Proveedor('+PosProvActual+ '): ['+arrProveedores[PosProvActual].IDProvLic+'/'+arrProveedores[PosProvActual].IDProveedor+'] '+arrProveedores[PosProvActual].NombreCorto);
		

		jQuery.ajax({
			cache:	false,
			url:	'http://www.newco.dev.br/Gestion/Comercial/RecuperaOfertaProductos.xsql',
			type:	"GET",
			//async:	false,			//	Lo hacemos de forma síncrona, más lento pero más seguro, y permite informar al cliente
			data:	"LIC_ID="+IDLicitacion+"&LIC_PROV_ID="+LicProvID+"&IDIDIOMA="+IDIdioma+"&_="+d.getTime(),
			contentType: "application/xhtml+xml",
			error: function(objeto, quepaso, otroobj){
				alert('error'+quepaso+' '+otroobj+' '+objeto);
			},
			success: function(objeto)
			{
				//var data = eval("(" + objeto + ")");
				var data = JSON.parse(objeto);

				jQuery('#idEstadoLic').html(arrProveedores[PosProvActual].NombreCorto);

				//solodebug	debug('cargaDatosOfertasProveedoresAjax. objeto:'+objeto+' ListaProductosOfertas.length:'+data.ProductosLicitacion.ListaProductosOfertas.length);

				if(data.ProductosLicitacion.ListaProductosOfertas.length > 0)
				{
				
					//solodebug	debug('cargaDatosOfertasProveedoresAjax. length:'+data.ProductosLicitacion.ListaProductosOfertas.length+'>0');
				
					jQuery.each(data.ProductosLicitacion.ListaProductosOfertas, function(key, producto)
					{
						//solodebug		debug('cargaDatosOfertasProveedoresAjax. buscar producto:'+producto.LIC_PROD_ID);
				

						//	Buscamos la fila correspondiente al producto
						for (j=0; j<arrProductos.length; ++j){
							if (arrProductos[j].Ofertas[PosProvActual].IDProdLic==producto.LIC_PROD_ID) fila=j;
						}

						// Comprobamos todos los productos estan validados para poder iniciar la licitacion
						// if(producto.Informada == 'N'){
						// 	CheckCamposPublicar = false;
						// }

						// var items		= [];
						arrProductos[fila].Ofertas[PosProvActual].linea = producto.Linea;
						arrProductos[fila].Ofertas[PosProvActual].PosProvActual = PosProvActual+1;					//	21set16, numerando a partir de la PosProvActual 1
						arrProductos[fila].Ofertas[PosProvActual].IDProdLic	= producto.LIC_PROD_ID;
						arrProductos[fila].Ofertas[PosProvActual].IDProd	= producto.IDProdEstandar;
						arrProductos[fila].Ofertas[PosProvActual].Alternativa	= producto.Alternativa;				//	11mar19, múltiples ofertas por producto
						arrProductos[fila].Ofertas[PosProvActual].RefEstandar	= producto.ProdRefEstandar;
						arrProductos[fila].Ofertas[PosProvActual].RefCliente	= producto.ProdRefCliente;
						arrProductos[fila].Ofertas[PosProvActual].Nombre		= producto.ProdNombre;
						arrProductos[fila].Ofertas[PosProvActual].NombreNorm	= producto.ProdNombreNorm;
						arrProductos[fila].Ofertas[PosProvActual].UdBasica	= producto.ProdUdBasica;
						arrProductos[fila].Ofertas[PosProvActual].FechaAlta	= producto.FechaAlta;
						arrProductos[fila].Ofertas[PosProvActual].FechaMod	= producto.FechaModificacion;
						arrProductos[fila].Ofertas[PosProvActual].Consumo	= producto.Consumo;
						arrProductos[fila].Ofertas[PosProvActual].ConsumoIVA	= producto.ConsumoIVA;
						arrProductos[fila].Ofertas[PosProvActual].Cantidad	= producto.Cantidad;
						arrProductos[fila].Ofertas[PosProvActual].PrecioHist	= producto.PrecioReferencia;
						arrProductos[fila].Ofertas[PosProvActual].PrecioObj	= producto.PrecioObjetivo;
						arrProductos[fila].Ofertas[PosProvActual].TipoIVA	= producto.TipoIVA;
						arrProductos[fila].Ofertas[PosProvActual].Ordenacion	= '0';
						arrProductos[fila].Ofertas[PosProvActual].PrecioColor = producto.Color;				//	16ene17

						// Campos Avanzados producto
						arrProductos[fila].Ofertas[PosProvActual].InfoAmpliada	= producto.InfoAmpliada;
						arrProductos[fila].Ofertas[PosProvActual].Documento	= [];
						if(producto.Documento.ID != ''){
							arrProductos[fila].Ofertas[PosProvActual].Documento.ID		= producto.Documento.ID;
							arrProductos[fila].Ofertas[PosProvActual].Documento.Nombre	= producto.Documento.Nombre;
							arrProductos[fila].Ofertas[PosProvActual].Documento.Descripcion	= producto.Documento.Descripcion;
							arrProductos[fila].Ofertas[PosProvActual].Documento.Url		= producto.Documento.Url;
							arrProductos[fila].Ofertas[PosProvActual].Documento.Fecha	= producto.Documento.Fecha;
						}
						// FIN Campos Avanzados producto
						//arrProductos[fila].Ofertas[PosProvActual]	= [];
						arrProductos[fila].Ofertas[PosProvActual].ID		= producto.IDOferta;
						arrProductos[fila].Ofertas[PosProvActual].IDProvLic	= producto.LIC_PROV_ID;
						arrProductos[fila].Ofertas[PosProvActual].IDProducto	= producto.IDProductoOfe;
						arrProductos[fila].Ofertas[PosProvActual].RefProv	= producto.RefOfe;
						arrProductos[fila].Ofertas[PosProvActual].Nombre	= producto.NombreOfe;
						arrProductos[fila].Ofertas[PosProvActual].Marca	= producto.MarcaOfe;
						arrProductos[fila].Ofertas[PosProvActual].FechaAlta	= producto.FechaAltaOfe;
						arrProductos[fila].Ofertas[PosProvActual].FechaMod	= producto.FechaModificacionOfe;
						arrProductos[fila].Ofertas[PosProvActual].UdsXLote	= producto.UdsXLoteOfe;
						arrProductos[fila].Ofertas[PosProvActual].Cantidad	= producto.CantidadOfe;
						arrProductos[fila].Ofertas[PosProvActual].Precio	= producto.PrecioOfe;
						arrProductos[fila].Ofertas[PosProvActual].TipoIVA	= producto.TipoIVAOfe;
						arrProductos[fila].Ofertas[PosProvActual].Consumo	= producto.ConsumoOfe;
						arrProductos[fila].Ofertas[PosProvActual].ConsumoIVA	= producto.ConsumoIVAOfe;
						arrProductos[fila].Ofertas[PosProvActual].IDEstadoEval	= producto.IDEstadoEvaluacionOfe;
						arrProductos[fila].Ofertas[PosProvActual].EstadoEval	= producto.EstadoEvaluacionOfe;

						// Campos Avanzados oferta
						arrProductos[fila].Ofertas[PosProvActual].InfoAmpliada	= producto.InfoAmpliadaOferta;
						arrProductos[fila].Ofertas[PosProvActual].Documento	= [];
						if(producto.DocumentoOferta.ID != ''){
							arrProductos[fila].Ofertas[PosProvActual].Documento.ID		= producto.DocumentoOferta.ID;
							arrProductos[fila].Ofertas[PosProvActual].Documento.Nombre		= producto.DocumentoOferta.Nombre;
							arrProductos[fila].Ofertas[PosProvActual].Documento.Descripcion	= producto.DocumentoOferta.Descripcion;
							arrProductos[fila].Ofertas[PosProvActual].Documento.Url		= producto.DocumentoOferta.Url;
							arrProductos[fila].Ofertas[PosProvActual].Documento.Fecha		= producto.DocumentoOferta.Fecha;
						}
						// FIN Campos Avanzados oferta

						arrProductos[fila].Ofertas[PosProvActual].FichaTecnica	= [];
						if(producto.FichaTecnica.ID != ''){
							arrProductos[fila].Ofertas[PosProvActual].FichaTecnica.ID		= producto.FichaTecnica.ID;
							arrProductos[fila].Ofertas[PosProvActual].FichaTecnica.Nombre	= producto.FichaTecnica.Nombre;
							arrProductos[fila].Ofertas[PosProvActual].FichaTecnica.Descripcion	= producto.FichaTecnica.Descripcion;
							arrProductos[fila].Ofertas[PosProvActual].FichaTecnica.Url		= producto.FichaTecnica.Fichero;
							arrProductos[fila].Ofertas[PosProvActual].FichaTecnica.Fecha	= producto.FichaTecnica.Fecha;
                    	}

						arrProductos[fila].Ofertas[PosProvActual].OfertaAdjud	= producto.Adjudicada;	//	Informar oferta adjudicada
						arrProductos[fila].Ofertas[PosProvActual].CantAdjud	= (producto.CantidadAdjudicada=='')?'0':producto.CantidadAdjudicada;	//	Informar oferta adjudicada
						arrProductos[fila].Ofertas[PosProvActual].Orden	= producto.Orden;				//	9jul18 y orden
						
						//solodebug debug('Proveedor:'+arrProveedores[PosProvActual].NombreCorto+' fila:'+fila+' PosProvActual:'+PosProvActual+' CantidadAdjud:'+arrProductos[fila].Ofertas[PosProvActual].CantAdjud);

						if (arrProductos[fila].Ofertas[PosProvActual].OfertaAdjud=='S'){	//	21set16 Informar producto con oferta adjudicada
							arrProductos[fila].TieneSeleccion='S';
							arrProductos[fila].ColSeleccionada=PosProvActual;
							numProdsSeleccion++;			//	26set16

							//solodebug		debug('Proveedor:'+arrProveedores[PosProvActual].NombreCorto+' fila:'+fila+' PosProvActual:'+PosProvActual+arrProductos[fila].TieneSeleccion+' CantidadAdjud:'+producto.CantidadAdjudicada+ ' numProdsSeleccion:'+numProdsSeleccion);

						}
						
						//	20may19 Indica si es una línea con varios proveedores adjudicados
						if ((parseFloat(producto.CantidadAdjudicada.replace(',','.'))>0)&&(parseFloat(producto.CantidadAdjudicada.replace(',','.'))<parseFloat(arrProductos[fila].Cantidad.replace(',','.'))))
						{
							//solodebug		debug('Proveedor:'+arrProveedores[PosProvActual].NombreCorto+' fila:'+fila+' PosProvActual:'+PosProvActual+arrProductos[fila].TieneSeleccion+' CantidadAdjud:'+producto.CantidadAdjudicada+ ' VARIOS PROVEEDORES');							
							
							arrProductos[fila].VariosProv='S';
						}
						
						//26set16	CUidado: las siguientes lineas machacaban la info anterior
						//26set16	else
						//26set16		arrProductos[fila].TieneSeleccion='N';

						if (producto.Informada=='S')
							arrProductos[fila].Ofertas[PosProvActual].NoInformada	= 'N';
						else
							arrProductos[fila].Ofertas[PosProvActual].NoInformada	= 'S';

						//	9oct17	desde la base de datos se devuelve '' si no está informado
						if (((arrProductos[fila].Ofertas[PosProvActual].UdsXLote=='0')||(arrProductos[fila].Ofertas[PosProvActual].UdsXLote==''))
								&&((producto.PrecioOfe=='0,0000')||(producto.PrecioOfe=='')))
							arrProductos[fila].Ofertas[PosProvActual].NoOfertada='S';
						else{
							arrProductos[fila].Ofertas[PosProvActual].NoOfertada='N';
							arrProductos[fila].NumOfertas++;						//	30set16 Actualizamos el contador de ofertas
						}


						//solodebug	
						/*
						if (fila<3)
							debug ('Proveedor (LicProvID:'+LicProvID+') '+arrProveedores[PosProvActual].NombreCorto+' en PosProvActual '
										+PosProvActual+' producto '+arrProductos[fila].Nombre
										+' OFERTA. precio:'+arrProductos[fila].Ofertas[PosProvActual].Precio
										+' udes.lote:'+arrProductos[fila].Ofertas[PosProvActual].UdsXLote
										+' NoInformada:'+arrProductos[fila].Ofertas[PosProvActual].NoInformada
										+' NoOfertada:'+arrProductos[fila].Ofertas[PosProvActual].NoOfertada
										+' Adjudicada:'+arrProductos[fila].Ofertas[PosProvActual].OfertaAdjud
										+' Orden:'+arrProductos[fila].Ofertas[PosProvActual].Orden);
										
						*/

                	});	// jQuery each

					//solodebug debug('cargaDatosOfertasProveedoresAjax: PosProvActual:'+PosProvActual+ ' total:'+arrProveedores.length+ ' => llamada recursiva tras carga de datos');
					
					++PosProvActual;
					cargaDatosOfertasProveedoresAjax(PosProvActual);
					return;	//27mar17

				}	//if(data.ProductosLicitacion.ListaProductosOfertas.length > 0)
				else
				{
					debug('data.ProductosLicitacion.ListaProductosOfertas.length=0');
					
					//	30nov20 Seguimos con la recarga
					++PosProvActual;
					cargaDatosOfertasProveedoresAjax(PosProvActual);
					return;	//27mar17
				}
			}	//	success: function(objeto)
		});	//	jQuery.ajax(

	}
	catch(e)
	{
		debug('cargaDatosOfertasProveedoresAjax: PosProvActual:'+PosProvActual+ ' total:'+arrProveedores.length+ ' => ERROR, no ha salido correctamente de la función');
	}
	
	//solodebug 
	debug('cargaDatosOfertasProveedoresAjax: FIN');
	
	return PosProvActual;

}



//	función para depuracion
function MuestraMatrizOfertas(){
	
	texto='MATRIZ OFERTAS\n\rProductos\Proveedores|';

	for (i=0; i<arrProveedores.length; ++i)
	{
		texto+=arrProveedores[i].NombreCorto+':of:'+arrProveedores[i].TieneOfertas+'|';
	}
	texto+='\n\r';
	
	if (rol=='COMPRADOR')
	{
		for (j=0; j<arrProductos.length; ++j)
		{
			texto+=arrProductos[j].Nombre+'('+arrProductos[j].TieneSeleccion+')|';
			for (i=0; i<arrProveedores.length; ++i){
				texto+='('+j+','+i+') '+arrProductos[j].Ofertas[i].Precio+'|';
			}
			texto+='\n\r';
		}
	}
	else
	{
		for (j=0; j<arrProductos.length; ++j)
		{
			texto+='('+j+'|'+ColumnaOrdenadaProds[j]+') '+arrProductos[ColumnaOrdenadaProds[j]].IDProdLic+':'+arrProductos[ColumnaOrdenadaProds[j]].RefEstandar+':'
				+arrProductos[ColumnaOrdenadaProds[j]].Nombre+'|'+arrProductos[ColumnaOrdenadaProds[j]].Oferta.RefProv+':'+arrProductos[ColumnaOrdenadaProds[j]].Oferta.Marca
				+':'+arrProductos[ColumnaOrdenadaProds[j]].Oferta.Nombre+':'+arrProductos[ColumnaOrdenadaProds[j]].Oferta.Precio;
				
			texto+=	'  |  '+j+':'+ColumnaOrdenadaProds[j]+':'+jQuery("#IDPRODLIC_"+ColumnaOrdenadaProds[j]).val()+':'+jQuery("#RefProv_"+ColumnaOrdenadaProds[j]).val()+':'+jQuery("#Marca_"+ColumnaOrdenadaProds[j]).val();
				
			texto+=	'\n\r';
		}
	}
	
	debug(texto);
}


//	16ago16	Al cambiar la seleccion del centro para informar compras recargamos la licitacion 
function CargarDatosComprasCentro()
{
	recuperaDatosCompraPorCentro();
}
 
 
function ValidarFormulario(oForm, nombre, flag){
	var errores=0, eliminarOfertas='S';

	
	if (ctrlCargaProv) return;	//	Desactivamos durante la carga de proveedores


	flag   = (typeof flag === "undefined") ? null : flag;
	if (flag != null)	eliminarOfertas='N';

	/* quitamos los espacios sobrantes  */
	for(var n=0; n < oForm.length; n++){
		if(oForm.elements[n].type=='text'){
			oForm.elements[n].value=quitarEspacios(oForm.elements[n].value);
		}
	}

	if(nombre == 'datosGenerales')
	{
		var msgError='',fechaDec,
		 hoy = new Date(),
		 dd = hoy.getDate(),
		 mm = hoy.getMonth() + 1, 				//January is 0!
		 yyyy = hoy.getFullYear();
		 
		 hoyOrd=yyyy*10000+mm*100+dd;			//	Este formato es más eficiente para comparar fechas
		 
		//solodebug	debug('ValidarFormulario. datosGenerales. fecha dec.:'+oForm.elements['LIC_FECHADECISION'].value);
		
		if((esNulo(oForm.elements['LIC_TITULO'].value))){
			errores++;
			//alert(val_faltaTitulo);
			msgError+=val_faltaTitulo+'\n';
			oForm.elements['LIC_TITULO'].focus();
		}

		if((esNulo(oForm.elements['LIC_FECHADECISION'].value))){
			errores++;
			//alert(val_faltaFechaDecision);
			msgError+=val_faltaFechaDecision+'\n';
			oForm.elements['LIC_FECHADECISION'].focus();
		}
		else if(!errores && CheckDate(oForm.elements['LIC_FECHADECISION'].value))
		{
			errores++;
			//alert(val_malFechaDecision);
			msgError+=val_malFechaDecision+'\n';
			oForm.elements['LIC_FECHADECISION'].focus();
		}
		else if (fechaDecisionLic!=oForm.elements['LIC_FECHADECISION'].value)	//	18feb20 Solo chequeamos la fecha de decision si ha sido modificada
		{
			fechaDec=parseInt(Piece(oForm.elements['LIC_FECHADECISION'].value,'/',2))*10000+parseInt(Piece(oForm.elements['LIC_FECHADECISION'].value,'/',1))*100+parseInt(Piece(oForm.elements['LIC_FECHADECISION'].value,'/',0));
			if (fechaDec<100000000) fechaDec=20000000+fechaDec;
			
			//CAMBIAR CUANDO LA LIBRERIA ESTÉ ACTUALIZADA fechaDec=dateToInteger(oForm.elements['LIC_FECHADECISION'].value);
			
			//solodebug	alert('hoyOrd:'+hoyOrd+' fechaDec:'+fechaDec);
			
			if(!errores && (fechaDec<hoyOrd))
			{
				errores++;
				//alert(val_FechaDecisionAntigua);
				msgError+=val_FechaDecisionAntigua+'\n';
				oForm.elements['LIC_FECHADECISION'].focus();
			}
			
		}
	
		
		//solodebug	debug('ValidarFormulario.datosGenerales. msgError:'+msgError);

		//	19set19 Fecha entrega del pedido
		if((!esNulo(oForm.elements['LIC_FECHAENTREGAPEDIDO'].value) && (CheckDate(oForm.elements['LIC_FECHAENTREGAPEDIDO'].value))))
		{
			errores++;
			//alert(val_faltaFechaDecision);
			msgError+=val_malFechaPedidoLic+'\n';
			oForm.elements['LIC_FECHAENTREGAPEDIDO'].focus();
		}
		else if(!esNulo(oForm.elements['LIC_FECHAENTREGAPEDIDO'].value))
		{
		 	var fechaPed=parseInt(Piece(oForm.elements['LIC_FECHAENTREGAPEDIDO'].value,'/',2))*10000+parseInt(Piece(oForm.elements['LIC_FECHAENTREGAPEDIDO'].value,'/',1))*100+parseInt(Piece(oForm.elements['LIC_FECHAENTREGAPEDIDO'].value,'/',0));
			if (fechaPed<100000000) fechaPed=20000000+fechaPed;
			
			//CAMBIAR CUANDO LA LIBRERIA ESTÉ ACTUALIZADA 	fechaPed=dateToInteger(oForm.elements['LIC_FECHAENTREGAPEDIDO'].value);
			
			//solodebug	alert('hoyOrd:'+hoyOrd+' fechaPed:'+fechaPed);
			
			//solodebug	debug('ValidarFormulario.datosGenerales. '+oForm.elements['LIC_FECHADECISION'].value
			//solodebug				+comparaFechas(oForm.elements['LIC_FECHADECISION'].value,oForm.elements['LIC_FECHAENTREGAPEDIDO'].value)
			//solodebug				+oForm.elements['LIC_FECHAENTREGAPEDIDO'].value);
			
			//19feb20	if(!errores && (oForm.elements['LIC_MESES'].value==0) && (((!comparaFechas(oForm.elements['LIC_FECHADECISION'].value, oForm.elements['LIC_FECHAENTREGAPEDIDO'].value) == '>') 
			//19feb20			&&(!comparaFechas(oForm.elements['LIC_FECHADECISION'].value, oForm.elements['LIC_FECHAENTREGAPEDIDO'].value) == '='))
			//19feb20			||(comparaFechas(oForm.elements['LIC_FECHADECISION'].value, dd+'/'+mm+'/'+yyyy) == '<')))
					
			if(!errores && (oForm.elements['LIC_MESES'].value==0) && ((fechaPed<hoyOrd+1)||(fechaPed<fechaDec+1)))
			{
				errores++;
				//alert(val_FechaDecisionAntigua);
				msgError+=val_FechaPedidoAntigua+'\n';
				oForm.elements['LIC_FECHAENTREGAPEDIDO'].focus();
			}
			
		}

		if((esNulo(oForm.elements['LIC_DESCRIPCION'].value))){
			errores++;
			//alert(val_faltaDescripcion);
			msgError+=val_faltaDescripcion+'\n';
			oForm.elements['LIC_DESCRIPCION'].focus();
		}
		
		/*	Estos campos ya no son obligatorios
		if((esNulo(oForm.elements['LIC_CONDENTREGA'].value))){
			errores++;
			//alert(val_faltaCondEntr);
			msgError+=val_faltaCondEntr+'\n';
			oForm.elements['LIC_CONDENTREGA'].focus();
		}

		if((esNulo(oForm.elements['LIC_CONDPAGO'].value))){
			errores++;
			//alert(val_faltaCondPago);
			msgError+=val_faltaCondPago+'\n';
			oForm.elements['LIC_CONDPAGO'].focus();
		}
		*/

		if(jQuery("#LIC_FECHAADJUDICACION").length){
			if(!esNulo(oForm.elements['LIC_FECHAADJUDICACION'].value)){
				if(CheckDate(oForm.elements['LIC_FECHAADJUDICACION'].value)){
					errores++;
					//alert(val_malFechaAdjudic);
					msgError+=val_malFechaAdjudic+'\n';
					oForm.elements['LIC_FECHAADJUDICACION'].focus();
				}else{
	//debug(comparaFechas(oForm.elements['LIC_FECHADECISION'].value, oForm.elements['LIC_FECHAADJUDICACION'].value));
					if((oForm.elements['LIC_MESES'].value!=0)&&(comparaFechas(oForm.elements['LIC_FECHADECISION'].value, oForm.elements['LIC_FECHAADJUDICACION'].value) == '>')){
						errores++;
						//alert(val_malFechaAdjudic2.replace('[[FECHA_ADJUDICACION]]', oForm.elements['LIC_FECHAADJUDICACION'].value).replace('[[FECHA_DECISION]]', oForm.elements['LIC_FECHADECISION'].value));
						msgError+=val_malFechaAdjudic2.replace('[[FECHA_ADJUDICACION]]', oForm.elements['LIC_FECHAADJUDICACION'].value).replace('[[FECHA_DECISION]]', oForm.elements['LIC_FECHADECISION'].value)+'\n';
						oForm.elements['LIC_FECHAADJUDICACION'].focus();
					}
				}
			}
		}
		
		if ((jQuery('#CHK_LIC_AGREGADA').length) && (oForm.elements['CHK_LIC_AGREGADA'].checked)){	//12set16	Primero comprobamos que existe el checkbox
			oForm.elements['LIC_AGREGADA'].value='S';
		}
		else{
			if (jQuery('#CHK_LIC_AGREGADA').length){			//	Si existe el checkbox, asignamos su valor, sino manetnemos el que hubiera
				oForm.elements['LIC_AGREGADA'].value='N';
			}
		}
		
		if ((jQuery('#CHK_LIC_CONTINUA').length) && (oForm.elements['CHK_LIC_CONTINUA'].checked)){
			oForm.elements['LIC_CONTINUA'].value='S';
		}
		else{
			if (jQuery('#CHK_LIC_CONTINUA').length){
				oForm.elements['LIC_CONTINUA'].value='N';
			}
		}
		
		//	24may18 Licitación urgente
		if ((jQuery('#CHK_LIC_URGENTE').length) && (oForm.elements['CHK_LIC_URGENTE'].checked)){
			oForm.elements['LIC_URGENTE'].value='S';
		}
		else{
			if (jQuery('#CHK_LIC_URGENTE').length){	
				oForm.elements['LIC_URGENTE'].value='N';
			}
		}
		
		//	24may18 Solicitar datos proveedores
		if ((jQuery('#CHK_LIC_SOLICDATOSPROV').length) && (oForm.elements['CHK_LIC_SOLICDATOSPROV'].checked))
		{
			oForm.elements['LIC_SOLICDATOSPROV'].value='S';
		}
		else{
			if (jQuery('#CHK_LIC_SOLICDATOSPROV').length){
				oForm.elements['LIC_SOLICDATOSPROV'].value='N';
			}
		}
		
		//	4jul18 Multiopcion
		if ((jQuery('#CHK_LIC_MULTIOPCION').length) && (oForm.elements['CHK_LIC_MULTIOPCION'].checked))
		{
			oForm.elements['LIC_MULTIOPCION'].value='S';
		}
		else{
			if (jQuery('#CHK_LIC_MULTIOPCION').length){	
				oForm.elements['LIC_MULTIOPCION'].value='N';
			}
		}

		//	17jun20
		if ((jQuery('#CHK_LIC_FRETECIFOBLIGATORIO').length) && (oForm.elements['CHK_LIC_FRETECIFOBLIGATORIO'].checked))
		{
			oForm.elements['LIC_FRETECIFOBLIGATORIO'].value='S';
		}
		else{
			if (jQuery('#CHK_LIC_FRETECIFOBLIGATORIO').length){	
				oForm.elements['LIC_FRETECIFOBLIGATORIO'].value='N';
			}
		}

		//	17jun20
		if ((jQuery('#CHK_LIC_PAGOAPLAZODOOBLIGATORIO').length) && (oForm.elements['CHK_LIC_PAGOAPLAZODOOBLIGATORIO'].checked))
		{
			oForm.elements['LIC_PAGOAPLAZODOOBLIGATORIO'].value='S';
		}
		else{
			if (jQuery('#CHK_LIC_PAGOAPLAZODOOBLIGATORIO').length){	
				oForm.elements['LIC_PAGOAPLAZODOOBLIGATORIO'].value='N';
			}
		}

		//	17jun20
		if ((jQuery('#CHK_LIC_PRECIOOBJETIVOESTRICTO').length) && (oForm.elements['CHK_LIC_PRECIOOBJETIVOESTRICTO'].checked))
		{
			oForm.elements['LIC_PRECIOOBJETIVOESTRICTO'].value='S';
		}
		else{
			if (jQuery('#CHK_LIC_PRECIOOBJETIVOESTRICTO').length){	
				oForm.elements['LIC_PRECIOOBJETIVOESTRICTO'].value='N';
			}
		}
		
		//solodebug debug('ValidarFormulario.datosGenerales. errores:'+errores+' msgError:'+msgError);

		/* si los datos son correctos enviamos el form  */
		if(!errores){
			//	6mar19 Nos aseguramos que no haya cambiado el action debido a la subida de documentos
			//oForm.action="http://www.newco.dev.br/Gestion/Comercial/MantLicitacionSave.xsql";
			oForm.action="http://www.newco.dev.br/Gestion/Comercial/MantLicitacion.xsql";
		
			SubmitForm(oForm);
		}
		else
		{
			alert(msgError);
		}
	}

	// Formulario para anyadir nuevos productos en la licitacion a traves de la referencia
	if(nombre == 'productos'){
		var listRefs = oForm.elements['LIC_LISTA_REFPRODUCTO'].value;

		if((!errores) && (esNulo(listRefs))){
			errores++;
			alert(val_faltaReferencia);
			oForm.elements['LIC_LISTA_REFPRODUCTO'].focus();
		}else{
			var arrLista	= listRefs.split(/\n/);
			if(arrLista.length > maxLineasParaInsertar){ // 18set16 ET No aceptamos mas de 500 referencias (antes 300)
				errores++;
				var Mensaje=val_maxReferencias.replace("[[NUM_REFS]]",arrLista.length);
				
				alert(Mensaje.replace("[[MAX_REFS]]",maxLineasParaInsertar));
				oForm.elements['LIC_LISTA_REFPRODUCTO'].focus();
			}
	
			//	13abr17 Recorre los datos de la lista para controlar errores
			for (i=0;i<arrLista.length;++i)
			{
				if (arrLista[i]!='')
				{
					var Ref=Piece(arrLista[i],':',0);
					var Cant=Piece(arrLista[i],':',1);
					var PrecioRef=Piece(arrLista[i],':',2);					//	8feb18	Permitimos subir precio ref
					var PrecioObj=Piece(arrLista[i],':',3);					//	8feb18	Permitimos subir precio obj
					var Restocadena=Piece(arrLista[i],':',4);				//	8feb18	Para control de errores
					
					if (((Cant!='')&&(!jQuery.isNumeric(Cant)))||(Restocadena!=''))	//	18abr17	COmprobar que la cantidad no sea null antes de chequear error
					{
						errores++;
						alert(val_malCantidad.replace("[[REF]]",Ref));
					}
						
				}
				
			}

		}

		if(!errores && (oForm.elements['LIC_TIPOIVA'].value < 0 || oForm.elements['LIC_TIPOIVA'].value == '')){
			errores++;
			alert(val_faltaTipoIVA);
			oForm.elements['LIC_TIPOIVA'].focus();
		}

		// si los datos son correctos enviamos el form
		if(!errores){
			AnadirProductos(oForm);
		}
	}

	// 8mar17	Formulario para modificar las cantidades en la licitacion agregada a traves de la referencia
	if(nombre == 'productosCant'){
		var listRefs = oForm.elements['LIC_LISTA_REFPRODUCTO_CANT'].value;

		if((!errores) && (esNulo(listRefs))){
			errores++;
			alert(val_faltaReferencia);
			oForm.elements['LIC_LISTA_REFPRODUCTO_CANT'].focus();
		}else{
			var arrLista	= listRefs.split(/\n/);
			if(arrLista.length > maxLineasParaInsertar){ // 18set16 ET No aceptamos mas de 500 referencias (antes 300)
				errores++;
				var Mensaje=val_maxReferencias.replace("[[NUM_REFS]]",arrLista.length);
				
				alert(Mensaje.replace("[[MAX_REFS]]",maxLineasParaInsertar));
				oForm.elements['LIC_LISTA_REFPRODUCTO_CANT'].focus();
			}
		}

		/* si los datos son correctos enviamos el form  */
		if(!errores){
			ActualizarCantidadesEnLicitacionAgregada(oForm);
		}
	}


	// 1jun17	Formulario para enviar las ofertas del proveedor desde un areatext
	if(nombre == 'provEnviarOfertas'){
		var listRefs = oForm.elements['LIC_LISTA_OFERTAS'].value;

		if((!errores) && (esNulo(listRefs))){
			errores++;
			alert(val_faltaReferencia);
			oForm.elements['LIC_LISTA_OFERTAS'].focus();
		}else{
			var arrLista	= listRefs.split(/\n/);
			if(arrLista.length > maxLineasParaInsertar){ // 18set16 ET No aceptamos mas de 500 referencias (antes 300)
				errores++;
				var Mensaje=val_maxReferencias.replace("[[NUM_REFS]]",arrLista.length);
				
				alert(Mensaje.replace("[[MAX_REFS]]",maxLineasParaInsertar));
				oForm.elements['LIC_LISTA_OFERTAS'].focus();
			}
		}

		/* si los datos son correctos enviamos el form  */
		if(!errores){
			ActualizarOfertasDesdeAreaText(oForm);
		}
	}

	// Formulario para anyadir nuevos productos en la licitacion a traves de los desplegables del catalogo privado
	if(nombre == 'productos_2'){
		if(mostrarCategorias == 'S'){
			// Estamos en el caso de empresas de 5 niveles
			if(!errores && (oForm.elements['IDCATEGORIA'].value < 0 || oForm.elements['IDCATEGORIA'].value == '')){
				errores++;
				alert(val_faltaSelecDespl.replace("[[SUBFAMILIAS]]",txtNivel3));
				oForm.elements['IDCATEGORIA'].focus();
			}else if(!errores && (oForm.elements['IDFAMILIA'].value < 0 || oForm.elements['IDFAMILIA'].value == '')){
				errores++;
				alert(val_faltaSelecDespl.replace("[[SUBFAMILIAS]]",txtNivel3));
				oForm.elements['IDFAMILIA'].focus();
			}else if(!errores && (oForm.elements['IDSUBFAMILIA'].value < 0 || oForm.elements['IDSUBFAMILIA'].value == '')){
				errores++;
				alert(val_faltaSelecDespl.replace("[[SUBFAMILIAS]]",txtNivel3));
				oForm.elements['IDSUBFAMILIA'].focus();
			}
		}else{
			// Estamos en el caso de empresas de 3 niveles
			if(!errores && (oForm.elements['IDFAMILIA'].value < 0 || oForm.elements['IDFAMILIA'].value == '')){
				errores++;
				alert(val_faltaSelecDespl.replace("[[SUBFAMILIAS]]",txtNivel3));
				oForm.elements['IDFAMILIA'].focus();
			}else if(!errores && (oForm.elements['IDSUBFAMILIA'].value < 0 || oForm.elements['IDSUBFAMILIA'].value == '')){
				errores++;
				alert(val_faltaSelecDespl.replace("[[SUBFAMILIAS]]",txtNivel3));
				oForm.elements['IDSUBFAMILIA'].focus();
			}
		}
		/* si los datos son correctos enviamos el form  */
		if(!errores){
			AnadirProductos_2(oForm);
		}
	}

	// Formulario para actualizar datos de los productos de la licitacion
	if(nombre == 'actualizarProductos'){
		var IDTablaProds, thisRowID, thisPosArr, RefCliente, valAux;
		var precioRefIVA, precioRef, idPrecioRef, tipoIVA;
		var precioObjIVA, precioObj, idPrecioObj;

		if(jQuery("#lProductos_EST").length){
			IDTablaProds = '#lProductos_EST';
		}else if(jQuery("#lProductos_OFE").length){
			IDTablaProds = '#lProductos_OFE';
		}

		// Recorremos todas las filas de la tabla para hacer las validaciones
		jQuery(IDTablaProds + " > tbody > tr").each(function(){
			thisRowID	= this.id;
			thisPosArr	= thisRowID.replace('posArr_', '');
			RefCliente	= (arrProductos[thisPosArr].RefCliente != '') ? arrProductos[thisPosArr].RefCliente : arrProductos[thisPosArr].RefEstandar;

			// Validacion UdBasica
			valAux	= jQuery('#UDBASICA_' + thisPosArr).val();
			if(!errores && esNulo(valAux)){
				errores++;
				alert(val_faltaUdBasica.replace("[[REF]]",RefCliente));
				oForm.elements['UDBASICA_' + thisPosArr].focus();
				return false;
			}

			// Validacion Precio Historico
			if(mostrarPrecioIVA == 'S'){
				// Validacion de la columna para los precios historicos con IVA
				valAux	= jQuery('#PRECIOREFIVA_' + thisPosArr).val().replace(",",".");

				if(!errores && !esNulo(valAux) && isNaN(valAux)){
					errores++;
					alert(val_malPrecioRef.replace("[[REF]]", RefCliente));
					oForm.elements['PRECIOREFIVA_' + thisPosArr].focus();
					return false;
				}

				if(!errores){
					// Calculamos el valor para cada .precioRef (precio historico sin IVA) que son input hidden
					precioRefIVA	= (valAux != '') ? parseFloat(valAux) : '';
					idPrecioRef	= '#PRECIOREF_' + thisPosArr;
					tipoIVA		= parseFloat(arrProductos[thisPosArr].TipoIVA);
					precioRef	= (precioRefIVA != '') ? (precioRefIVA * 100) / (100 + tipoIVA) : '';
					valAux		= (precioRef != '') ? String(precioRef.toFixed(4)).replace(".",",") : '';
					jQuery(idPrecioRef).val(valAux);
					valAux		= (precioRefIVA != '') ? String(precioRefIVA.toFixed(4)).replace(".",",") : '';
					jQuery('#PRECIOREFIVA_' + thisPosArr).val(valAux);
				}
			}else{
				// Validacion de la columna para los precios historicos sin IVA
				valAux	= jQuery('#PRECIOREF_' + thisPosArr).val().replace(",",".");

				if(!errores && !esNulo(valAux) && isNaN(valAux)){
					errores++;
					alert(val_malPrecioRef.replace("[[REF]]", RefCliente));
					oForm.elements['PRECIOREF_' + thisPosArr].focus();
					return false;
				}

				if(!errores){
					valAux	= (valAux != '') ? String(parseFloat(valAux).toFixed(4)).replace(".",",") : '';
					jQuery('#PRECIOREF_' + thisPosArr).val(valAux);
				}
			}

			// Validacion Precio Objetivo
			if(mostrarPrecioIVA == 'S'){
				// Validacion de la columna para los precios historicos con IVA
				valAux	= jQuery('#PRECIO_OBJIVA_' + thisPosArr).val().replace(",",".");

				if(!errores && !esNulo(valAux) && isNaN(valAux)){
					errores++;
					alert(val_malPrecioObj.replace("[[REF]]", RefCliente));
					oForm.elements['PRECIO_OBJIVA_' + thisPosArr].focus();
					return false;
				}

				if(!errores){
					// Calculamos el valor para cada .precioObj (precio objetivo sin IVA) que son input hidden
					precioObjIVA	= (valAux != '') ? parseFloat(valAux) : '';
					idPrecioObj	= '#PRECIO_OBJ_' + thisPosArr;
					tipoIVA		= parseFloat(arrProductos[thisPosArr].TipoIVA);
					precioObj	= (precioObjIVA != '') ? (precioObjIVA * 100) / (100 + tipoIVA) : '';
					valAux		= (precioObj != '') ? String(precioObj.toFixed(4)).replace(".",",") : '';
					jQuery(idPrecioObj).val(valAux);
					valAux		= (precioObjIVA != '') ? String(precioObjIVA.toFixed(4)).replace(".",",") : '';
					jQuery('#PRECIO_OBJIVA_' + thisPosArr).val(valAux);
				}
			}else{
				// Validacion de la columna para los precios historicos sin IVA
				valAux	= jQuery('#PRECIO_OBJ_' + thisPosArr).val().replace(",",".");

				if(!errores && !esNulo(valAux) && isNaN(valAux)){
					errores++;
					alert(val_malPrecioObj.replace("[[REF]]",RefCliente));
					oForm.elements['PRECIO_OBJ_' + thisPosArr].focus();
					return false;
				}

				if(!errores){
					valAux	= (valAux != '') ? String(parseFloat(valAux).toFixed(4)).replace(".",",") : '';
					jQuery('#PRECIO_OBJ_' + thisPosArr).val(valAux);
				}
			}

			// Validacion Cantidad
			if (isLicAgregada=='N') {

				valAux	= jQuery('#CANTIDAD_' + thisPosArr).val().replace(",",".");

				//solodebug	alert('isLicAgregada:'+isLicAgregada);	//26set16

				if(!errores && (isLicAgregada=='N') &&(esNulo(valAux))){				//23set16 No comprobamos cantidad para licitaciones agregadas
					errores++;
					alert(val_faltaCantidad.replace("[[REF]]", RefCliente));
					oForm.elements['CANTIDAD_' + thisPosArr].focus();
					return false;
				//	ET	13jul16	}else if(!errores && parseFloat(valAux) === 0){
				//	ET	13jul16		errores++;
				//	ET	13jul16		alert(val_ceroCantidad.replace("[[REF]]",RefCliente));
				//	ET	13jul16		oForm.elements['CANTIDAD_' + thisPosArr].focus();
				//	ET	13jul16		return false;
				}else if(!errores && isNaN(valAux)){
					errores++;
					alert(val_malCantidad.replace("[[REF]]",RefCliente));
					oForm.elements['CANTIDAD_' + thisPosArr].focus();
					return false;
				}

				if(!errores){
					jQuery('#CANTIDAD_' + thisPosArr).val( String(parseFloat(valAux).toFixed(4)).replace(".",",") );
				}
			}
		});

		// si los datos son correctos enviamos el form
		if(!errores){
			ActualizarProductos(eliminarOfertas);
		}
	}

	if(nombre == 'proveedores'){
		if(!errores && oForm.elements['LIC_IDPROVEEDOR'].value == ''){
			errores++;
			alert(val_faltaProveedor);
			oForm.elements['LIC_IDPROVEEDOR'].focus();
		}else{
			var chckUser = true;
			if(isNaN(oForm.elements['LIC_IDPROVEEDOR'].value))
				chckUser = false;
		}

		/*	Cogeremos el usuario proveedor por defecto
		if(!errores && chckUser && oForm.elements['LIC_IDUSUARIOPROVEEDOR'].value == ''){
			errores++;
			alert(val_faltaUsuarioProv);
			oForm.elements['LIC_IDUSUARIOPROVEEDOR'].focus();
		}*/

		/* si los datos son correctos enviamos el form  */
	/*	30jun20
		if(!errores){
			if(chckUser)
				AnadirProveedor(oForm);
			else
				AnadirSeleccionProveedor(oForm);
		}
	*/
		if(!errores){
			AnadirProveedor(oForm);
		}
	}

	if(nombre == 'selecciones')
	{
		AnadirSeleccionesProveedores(oForm);
	}

	if(nombre == 'centros'){
		if(!errores && (oForm.elements['LIC_IDCENTRO'].value < 1 || oForm.elements['LIC_IDCENTRO'].value == '')){
			errores++;
			alert(val_faltaCentro);
			oForm.elements['LIC_IDCENTRO'].focus();
		}

		/* si los datos son correctos enviamos el form  */
		if(!errores){
			AnadirCentro(oForm);
		}
	}

	if(nombre == 'usuarios'){
		if(!errores && (oForm.elements['LIC_IDUSUARIO'].value < 1 || oForm.elements['LIC_IDUSUARIO'].value == '')){
			errores++;
			alert(val_faltaUsuario);
			oForm.elements['LIC_IDUSUARIO'].focus();
		}

		/* si los datos son correctos enviamos el form  */
		if(!errores){
			AnadirUsuario(oForm);
		}
	}

	if(nombre == 'provPedidoMinimo'){
		jQuery('#MensPedidoMinimo').hide();

		if((!errores) && (esNulo(oForm.elements['LIC_PROV_PEDIDOMINIMO'].value))){
			errores++;
			alert(val_faltaPedidoMinimo);
			oForm.elements['LIC_PROV_PEDIDOMINIMO'].focus();
		}else if(!errores && isNaN(oForm.elements['LIC_PROV_PEDIDOMINIMO'].value.replace(",","."))){
			errores++;
			alert(val_malPedidoMinimo);
			oForm.elements['LIC_PROV_PEDIDOMINIMO'].focus();
		}


		if((!errores) && (IDPais==55) && (esNulo(oForm.elements['LIC_PROV_FRETE'].value))){	//solo para Brasil controlaremos el campo FRETE
			errores++;
			alert(val_faltaFrete);
			oForm.elements['LIC_PROV_PLAZOENTREGA'].focus();
		}else if((!errores) && (esNulo(oForm.elements['LIC_PROV_PLAZOENTREGA'].value))){
			errores++;
			alert(val_faltaPlazoEntrega);
			oForm.elements['LIC_PROV_PLAZOENTREGA'].focus();
		}

		// si los datos son correctos enviamos el form 
		if(!errores){
			publicarPedidoMinimo(oForm);
		}
	}

	if(nombre == 'productosProveedor'){
		jQuery('#MensActualizarOfertas').hide();
		var thisRowID, thisPosArr, thisRowID2, thisPosArr2, RefCliente, RefCliente2, ProdNombre1, ProdNombre2, valAux, valAux2;
		var precioObj, precioObjFormat, precio, precioFormat, UdsXLote, UdsXLoteFormat;

                var controlPrecio = '';

		// Recorremos todas las filas de la tabla para hacer las validaciones
		jQuery("#lProductos_PROVE > tbody > tr.infoProds").each(function(){
			thisRowID	= this.id;
			thisPosArr	= thisRowID.replace('posArr_', '');
			RefCliente	= (arrProductos[thisPosArr].RefCliente != '') ? arrProductos[thisPosArr].RefCliente : arrProductos[thisPosArr].RefEstandar;
			ProdNombre1	= arrProductos[thisPosArr].Nombre;
			precioObj	= arrProductos[thisPosArr].PrecioObj;
			precioObjFormat	= parseFloat(precioObj.replace(/\./g,"").replace(',', '.'));

			// Validacion Precio
			precio		= jQuery('#Precio_' + thisPosArr).val()
			precioFormat	= precio.replace(",",".");

			if(!errores && esNulo(precioFormat)){
				errores++;
				alert(val_faltaPrecio.replace("[[REF]]",RefCliente));
				oForm.elements['Precio_' + thisPosArr].focus();
				return false;
			}else if(!errores && isNaN(precioFormat)){
				errores++;
				alert(val_malPrecio.replace("[[REF]]",RefCliente));
				oForm.elements['Precio_' + thisPosArr].focus();
      		}else if(!errores && precioFormat != 0){
				// Solo se hace la validacion de precio para España
				//9abr18	if(IDPais != '55' && precioFormat > (precioObjFormat*2)){
				//9abr18		controlPrecio += val_elPrecioProd +" "+ precio +" "+ val_precioProd.replace("[[REF]]",RefCliente)+" "+ val_doblePrecio +" "+ precioObj +" "+ "\n";
				//9abr18	}

				if	((arrProductos[thisPosArr].PrecioMin!='' && precioFormat < parseFloat(arrProductos[thisPosArr].PrecioMin.replace(/\./g,"").replace(',', '.')))||(arrProductos[thisPosArr].PrecioMax!='' && precioFormat > parseFloat(arrProductos[thisPosArr].PrecioMax.replace(/\./g,"").replace(',', '.'))))
				{
					controlPrecio +=val_PrecioFueraRango.replace("[[REF]]",RefCliente);
				}


			}

			if(!errores && precioFormat != 0){
				valAux	= (precioFormat != '') ? String(parseFloat(precioFormat).toFixed(4)).replace(".",",") : '';
				jQuery('#Precio_' + thisPosArr).val( valAux );

				if(jQuery('#Desc_' + thisPosArr).val() == str_SinOfertar){
					jQuery('#Desc_' + thisPosArr).val('');
				}
				if(jQuery('#Marca_' + thisPosArr).val() == str_SinOfertar){
					jQuery('#Marca_' + thisPosArr).val('');
				}
			}

			// Validacion Unidades por Lote
			UdsXLote	= jQuery('#UdsLote_' + thisPosArr).val();
			UdsXLoteFormat	= UdsXLote.replace(",",".");
			if(!errores && esNulo(UdsXLoteFormat)){
				errores++;
				alert(val_faltaUnidades.replace("[[REF]]",RefClientValidarFormularioe));
				oForm.elements['UdsLote_' + thisPosArr].focus();
                        }else if(!errores && isNaN(UdsXLoteFormat)){
				errores++;
				alert(val_malUnidades.replace("[[REF]]",RefCliente));
				oForm.elements['UdsLote_' + thisPosArr].focus();
                        }

			if(!errores && UdsXLoteFormat != 0){
				valAux	= (UdsXLoteFormat != '') ? String(parseFloat(UdsXLoteFormat).toFixed(2)).replace(".",",") : '';
				jQuery('#UdsLote_' + thisPosArr).val( valAux );
			}

			if(IDPais != 55){
				// Validacion Ref.Proveedor
				valAux	= jQuery('#RefProv_' + thisPosArr).val();
				if(!errores && esNulo(valAux) && (precioFormat != 0 || UdsXLoteFormat != 0)){
					errores++;
					alert(val_faltaRefProv.replace("[[REF]]",RefCliente));
					oForm.elements['RefProv_' + thisPosArr].focus();
				}else if(!errores && UdsXLoteFormat != 0){
					// Comprobamos que no hayan escrito 2 Ref.Prov. iguales en la tabla
					var ProdNombre1	= arrProductos[thisPosArr].Nombre;								//	28set17	Faltaba esta línea
					jQuery("#lProductos_PROVE > tbody > tr.infoProds").each(function(){
						thisRowID2	= this.id;
						thisPosArr2	= thisRowID2.replace('posArr_', '');
						RefCliente2	= (arrProductos[thisPosArr2].RefCliente != '') ? arrProductos[thisPosArr2].RefCliente : arrProductos[thisPosArr2].RefEstandar;
						var ProdNombre2	= arrProductos[thisPosArr2].Nombre;

						valAux2		= jQuery('#RefProv_' + thisPosArr2).val();
						if(thisPosArr != thisPosArr2 && valAux.toUpperCase() == valAux2.toUpperCase()){
							errores++;
							alert(val_igualesRefProv.replace("[[REFPROV]]", valAux).replace('[[PRODNOMBRE1]]', ProdNombre1).replace('[[PRODNOMBRE2]]', ProdNombre2));
							oForm.elements['RefProv_' + thisPosArr2].focus();
						}
					});

					// Tambien comprobamos que no exista previamente una Ref.Prov en el array de ofertas
					jQuery.each(arrProductos, function(key, producto){
						if(!errores && key != thisPosArr && producto.Oferta.RefProv.toUpperCase() == valAux.toUpperCase()){
							var ProdNombre2 = producto.Nombre;
							errores++;
							alert(val_igualesRefProv.replace("[[REFPROV]]", valAux).replace('[[PRODNOMBRE1]]', ProdNombre1).replace('[[PRODNOMBRE2]]', ProdNombre2));
							oForm.elements['RefProv_' + thisPosArr].focus();
        	  }
        	});

				}else if(!errores && precioFormat == 0 && UdsXLoteFormat == 0){
					jQuery('#RefProv_' + thisPosArr).val(str_SinOfertar);
					jQuery('#Desc_' + thisPosArr).val(str_SinOfertar);
					jQuery('#Marca_' + thisPosArr).val(str_SinOfertar);
				}
			}
    });

		// si los datos son correctos enviamos el form
		if(!errores && controlPrecio == ''){
			AnadirOfertas(oForm);
		}else{
			if(!errores && controlPrecio != ''){
				controlPrecio += conf_estaSeguro;
				//alert(confirm(controlPrecio));
				var answer = confirm(controlPrecio);
				if(answer){
					//si clica ok envio form, implica que esta seguro no error
					AnadirOfertas(oForm);
				}
			}
		}
	}

	if(nombre == 'provPublicarOferta'){
		// Antes de publicar la oferta, falta comprobar que el proveedor ha rellenado todos los campos para su oferta
		//	24feb17	permitimos ofertas vacias
		//if(ofertaProvInformada != 'S'){
		if(ofertaVacia == 'S'){
			jQuery('#pes_lProductos' ).click();

			//24feb17	alert(alrt_faltaInformarOfertas);
			//24feb17	errores++;
			
			if (confirm(alrt_publicarOfertaVacia)==false)
			{
				errores++;
			}
			
		}

		if(!errores && ofertaProvInformada == 'S' && pedidoMinimoInform != 'S'){
			errores++;
			jQuery('#pes_lProductos' ).click();
			alert(alrt_faltaPedidoMinimo);
			document.forms['PedidoMinimo'].elements['LIC_PROV_PEDIDOMINIMO'].focus();
		}

		// validar checkbox condiciones licitacion
		/* 24jul29	if(!errores && ofertaProvInformada == 'S' && pedidoMinimoInform == 'S'){
			if(jQuery('input#condLicitacion:checked').length <= 0){
				errores++;
				alert(alrt_faltaCondLicitacion);
        		jQuery('input#condLicitacion').focus();
			}
		}*/

		// validar checkbox condiciones licitacion
		if(!errores && (jQuery('input#condLicitacion:checked').length <= 0))
		{
			errores++;
			alert(alrt_faltaCondLicitacion);
        	jQuery('input#condLicitacion').focus();
		}

		if(!errores)
			publicarOferta(oForm);
        }
}

// Funcion que valida que los precios que introduce el proveedor no sean mayores que el doble del precio objetivo
/*9abr18	
function validarPreciosProv(obj){
	var controlPrecio	= '';
	var thisID		= obj.id;
	var thisPosArr		= thisID.replace('Precio_', '');
	var RefCliente		= (arrProductos[thisPosArr].RefCliente != '') ? arrProductos[thisPosArr].RefCliente : arrProductos[thisPosArr].RefEstandar;
	var UdBasica		= arrProductos[thisPosArr].UdBasica;
	var precioObj		= arrProductos[thisPosArr].PrecioObj;
	var precio		= jQuery(obj).val();
//debug(precio);
	var precioObjFormato	= parseFloat(precioObj.replace(/\./g,"").replace(",",".")).toFixed(4);
	var precioFormato	= parseFloat(precio.replace(",",".")).toFixed(4);
//debug(precioFormato);
	if(precioFormato != 0){
// 28ene15 Otelo pide que no haya validacion limite inferior sobre los campos precio
//		if(precioFormato > (precioObjFormato*2) || precioFormato < (precioObjFormato/5)){
//
		if(precioFormato > (precioObjFormato*2)){
			controlPrecio = val_PrecioProvGrande.replace("[[REF]]",RefCliente).replace("[[PRECIO]]",precio).replace("[[PRECIOOBJ]]",precioObj).replace("[[UDBASICA]]",UdBasica);
		}
		if(jQuery("tr#posArr_" + thisPosArr + " input.refProv").length){
			if(jQuery("tr#posArr_" + thisPosArr + " input.refProv").val().toLowerCase() === str_SinOfertar.toLowerCase()){
				jQuery("tr#posArr_" + thisPosArr + " input.refProv").val('');
			}
		}
		if(jQuery("tr#posArr_" + thisPosArr + " input.descripcion").val().toLowerCase() === str_SinOfertar.toLowerCase()){
			jQuery("tr#posArr_" + thisPosArr + " input.descripcion").val('');
		}
		if(jQuery("tr#posArr_" + thisPosArr + " input.marca").val().toLowerCase() === str_SinOfertar.toLowerCase()){
			jQuery("tr#posArr_" + thisPosArr + " input.marca").val('');
		}
	}

	jQuery('#' + thisID).val(precioFormato.replace(".", ","));

	if(controlPrecio != ''){
		alert(controlPrecio);
		jQuery('#' + thisID).focus();
	}
}
*/

// Peticion ajax que inserta nuevos productos en la tabla lic_productos (por referencia cliente o MVM mediante cadena separada por '|')
// A la base de datos se envia en formato REFCLIENTE1[#CANTIDAD1]|REFCLIENTE2[#CANTIDAD2]|... o REFMVM1[#CANTIDAD1]|REFMVM2[#CANTIDAD2]|...
function AnadirProductos(oForm){
	var limit = 20;	
	
	var error=false;
	
	var Referencias	= oForm.elements['LIC_LISTA_REFPRODUCTO'].value.replace(/(?:\r\n|\r|\n)/g, '|');
	var TipoCodificacion	= jQuery("#IDCENTROREFERENCIA").val();
	
	Referencias	= Referencias.replace(/[\t:]/g, ':');	// 18set16	Separadores admitidos para separar referencia de cantidad

		
	//solodebug	debug('Referencias:'+Referencias);		
		

	// Como enviamos solo los datos de los productos que se muestran por pantalla (numProductos)
	// Evaluamos tambien que numProductos no sea mas grande que totalProductos
	var totProductos = PieceCount(Referencias,'|')+1;

	if(totProductos > limit){
		//	Si hay mas productos que la variable limit => hacemos 'loops' peticiones ajax
		loops		= Math.ceil(totProductos / limit);
	}else{
		//	Hacemos una unica peticion ajax
		loops		= 1;
	}

	jQuery("#EnviarProductosPorRef").hide();
	jQuery('#idEstadoEnvio').html('0/'+totProductos);
	jQuery('#idEstadoEnvio').show();
	
	//solodebug 
	debug('TipoCodificacion:'+TipoCodificacion+'AnadirProductos:'+Referencias+' totProductos:'+totProductos+' loops:'+loops);
	

	//6oct17	ColumnaOrdenacionProds = 'linea';	//	22mar17	Con otras ordenaciones se pueden producir errores por campos no inicializados
	//6oct17	prepararTablaProductos(true);

	AnadirProductosAjax(oForm, Referencias, TipoCodificacion, totProductos, 0, loops, '');
}

//	Añade los productos vía Ajax (función recursiva)
function AnadirProductosAjax(oForm, Referencias, TipoCodificacion, totProductos, loop, loops, error)
{
	var cadEnvio=''; limit = 20;

	var TipoIVA	= oForm.elements['LIC_TIPOIVA'].value;
	var d = new Date();

	//solodebug	
	debug('AnadirProductosAjax: totProductos:'+totProductos+' loop:'+loop+'/'+loops+ 'TipoCodificacion:'+TipoCodificacion);

	if (loop==loops)
	{
		if (!error)
		{

			if (estadoLicitacion=='CURS')
			{
				alert(str_InsertarProductos_OK);
				Recarga();	//23jul19	location.reload();					//	recargamos toda la página
			}
			else
			{
				//alert(data.NuevosProductos.message);
				oForm.elements['LIC_LISTA_REFPRODUCTO'].value='';

				//	6oct17	Recargamos la tabla de productos
				ColumnaOrdenacionProds = 'NombreNorm';	//19mar19 'linea'//	22mar17	Con otras ordenaciones se pueden producir errores por campos no inicializados

				recuperaDatosProductos(0,'S');
				prepararTablaProductos(true);
			}
		}
		else	//	6oct17 Aunque haya habido error, recargamos productos, ya que pueden haberse insertado algunos
		{
			
			//solodebug
			alert('Saliendo por error');
			
			oForm.elements['LIC_LISTA_REFPRODUCTO'].value='';
			recuperaDatosProductos(0,'N');

			//	6oct17	Recargamos la tabla de productos
			ColumnaOrdenacionProds = 'NombreNorm';	//19mar19 'linea'//	22mar17	Con otras ordenaciones se pueden producir errores por campos no inicializados
			prepararTablaProductos(true);
		}

		jQuery('#idEstadoEnvio').hide();
		jQuery("#EnviarProductosPorRef").show();
		
		//	17jun20 En cualquier caso, activa el boton
		jQuery('#botonIniciarLici').removeClass("btnGris");
		jQuery('#botonIniciarLici').attr('class','btnDestacado');
		
		return;
	}

	//solodebug		debug('AnadirProductosAjax: '+Referencias+ 'limit:'+limit+' totProductos:'+totProductos);

	//6oct17	for (j=0;(j<limit)&&((loop*limit+j)<totProductos);++j)
	for (j=0;(j<limit)&&((loop*limit+j)<=totProductos);++j)		//	13jul20 
	{
		cadEnvio+=Piece(Referencias,'|',loop*limit+j)+'|';
		
		//solodebug	debug('AnadirProductosAjax: '+cadEnvio+' j:'+j);
	}

	//solodebug	
	debug('AnadirProductosAjax: '+cadEnvio+' final');

	jQuery.ajax({
		cache:	false,
		url:	'http://www.newco.dev.br/Gestion/Comercial/NuevosProductos.xsql',
		type:	"GET",
		data:	"LIC_ID="+IDLicitacion+"&TIPO_CODIFICACION="+TipoCodificacion+"&LISTA_REFERENCIAS="+cadEnvio+"&TIPOIVA="+TipoIVA+"&_="+d.getTime(),
		contentType: "application/xhtml+xml",
		//async: false,
		success: function(objeto){
			//var data = eval("(" + objeto + ")");
			var data = JSON.parse(objeto);

			if(data.NuevosProductos.estado == 'OK'){

				// Se han anyadido productos (pero falta informar campos como cantidad, uds x lote, precios, etc)
				prodsInformados = 'N';

				//alert(data.NuevosProductos.message);
				//recuperaDatosProductos(0);
            }else{
				alert('Error: \n' + data.NuevosProductos.message + '\n' + alrt_errorNuevosProductos);
				error=true;
			}
			
			jQuery('#idEstadoEnvio').html((limit*loop)+'/'+totProductos);
			++loop;
			
			//solodebug	6oct17	debug('AnadirProductosAjax: '+loop+'/'+loops+':'+cadEnvio);
			
			//	18abr17	En el caso de licitación en curso, al añadir productos recargamos la pagina
			//if (estadoLicitacion=='CURS')
			//	location.reload();
			//else
				AnadirProductosAjax(oForm, Referencias, TipoCodificacion, totProductos, loop, loops, error);
			
			return;	//28mar17

		},
		error: function(xhr, errorString, exception) {
			alert("xhr.status="+xhr.status+" error="+errorString+" exception="+exception);
		}
	});

}


//	8mar17	Actualiza las cantidades en licitacion agregada. Formato: Ref Cant (separadores válidos: espacio, tabulador, etc)
function ActualizarCantidadesEnLicitacionAgregada(oForm)
{
	var Cambios=false;
	
	jQuery("#EnviarProductosPorRef").hide();
	
	//solodebug	var Control='';

	var Referencias	= oForm.elements['LIC_LISTA_REFPRODUCTO_CANT'].value.replace(/(?:\r\n|\r|\n)/g, '|');
	Referencias	= Referencias.replace(/[\t:]/g, ':');	// 	Separadores admitidos para separar referencia de cantidad
	Referencias	= Referencias.replace(/ /g, ':');		// 	Separadores admitidos para separar referencia de cantidad
	
	var numRefs	= PieceCount(Referencias, '|');
	
	for (i=0;i<=numRefs;++i)
	{
		var Producto= Piece(Referencias, '|',i);
		var Ref		= Piece(Producto, ':', 0);
		var Cant	= Piece(Producto, ':', 1);
		
		if (Ref!='')
		{
			//	Recorre el array con los referencias de centro
			for (j=0;((j<arrProductosPorCentro.length) && (!Encont));++j)
			{
				if (arrProductosPorCentro[j].RefCentro==Ref)
				{
					Encont=true;
					jQuery('#Cantidad_' + (arrProductos[ColumnaOrdenadaProds[j]].linea - 1)).val(Cant);
					jQuery('#btnGuardar_' + (arrProductos[ColumnaOrdenadaProds[j]].linea - 1)).show();
				}
			}
			
		
			//solodebug	Control=Control+'['+i+'/'+numRefs+'] Referencia:'+Ref+ '. Cantidad:'+Cant;

			//	Recorre el array de productos buscando la referencia
			var Encont=false;
			for (j=0;((j<arrProductos.length) && (!Encont));++j)
			{
				if (ReferenciaCentro(arrProductos[ColumnaOrdenadaProds[j]].IDProdLic)==Ref)
				{
					Encont=true;
				}
				else if ((arrProductos[ColumnaOrdenadaProds[j]].RefCliente==Ref)||(arrProductos[ColumnaOrdenadaProds[j]].RefEstandar==Ref))
				{
					//solodebug	Control=Control+' encontrado en posicion '+j;
					//jQuery('#Cantidad_' + (arrProductos[ColumnaOrdenadaProds[j]].linea - 1)).val(Cant);
					//jQuery('#btnGuardar_' + (arrProductos[ColumnaOrdenadaProds[j]].linea - 1)).show();
					Encont=true;
					//Cambios=true;
				}
				
				if (Encont)
				{
					jQuery('#Cantidad_' + (arrProductos[ColumnaOrdenadaProds[j]].linea - 1)).val(Cant);
					jQuery('#btnGuardar_' + (arrProductos[ColumnaOrdenadaProds[j]].linea - 1)).show();
					Cambios=true;
				}
				
			}
			
			//solodebug	if (!Encont) Control=Control+'NO ENCONTRADO';

			//solodebug	Control=Control+'\n\r';
		}
	}

	//solodebug	alert('ActualizarCantidadesEnLicitacionAgregada:'+Referencias+'\n\r'+'\n\r'+Control);

	if (Cambios)
		jQuery("#idGuardarTodasCantidades").show();
		

	jQuery("#EnviarProductosPorRef").show();
}



function AnadirProductos_2(oForm){
	var TipoIVA	= oForm.elements['LIC_TIPOIVA'].value;
	var IDNivel, Nivel;
	var d = new Date();

	if(jQuery('#IDPRODUCTOESTANDAR').val() > 0 && jQuery('#IDPRODUCTOESTANDAR').val() != ''){
		Nivel	= 'PRO';
		IDNivel	= jQuery('#IDPRODUCTOESTANDAR').val();
	}else if(jQuery('#IDGRUPO').val() > 0 && jQuery('#IDGRUPO').val() != ''){
		Nivel	= 'GRU';
		IDNivel	= jQuery('#IDGRUPO').val();
	}else if(jQuery('#IDSUBFAMILIA').val() > 0 && jQuery('#IDSUBFAMILIA').val() != ''){
		Nivel	= 'SF';
		IDNivel	= jQuery('#IDSUBFAMILIA').val();
	}

	jQuery.ajax({
		cache:	false,
		url:	'http://www.newco.dev.br/Gestion/Comercial/NuevosProductosXCatPrivAJAX.xsql',
		type:	"GET",
		data:	"LIC_ID="+IDLicitacion+"&NIVEL="+Nivel+"&NIVEL_ID="+IDNivel+"&TIPOIVA="+TipoIVA+"&_="+d.getTime(),
		contentType: "application/xhtml+xml",
		success: function(objeto){
			//var data = eval("(" + objeto + ")");
			var data = JSON.parse(objeto);

			if(data.NuevosProductos.estado == 'OK'){
				// Se han anyadido productos (pero falta informar campos como cantidad, uds x lote, precios, etc)
				prodsInformados = 'N';

				alert(data.NuevosProductos.message);
				recuperaDatosProductos(0,'S');
            }else{
				alert('Error: \n' + data.NuevosProductos.message + '\n' + alrt_errorNuevosProductos);
			}
		},
		error: function(xhr, errorString, exception) {
			alert("xhr.status="+xhr.status+" error="+errorString+" exception="+exception);
		}
	});
}

// Peticion ajax que devuelve el desplegable de familias (empresas de 5 o 3 niveles)
function SeleccionaFamilia(IDCategoria){
	var d = new Date();

	jQuery.ajax({
		url:	"http://www.newco.dev.br/ProcesosCdC/CatalogoPrivado/FamiliasAJAX.xsql",
		type:	"GET",
		data:	"IDCLIENTE="+IDEmpresa+"&IDCATEGORIA="+IDCategoria+"&_="+d.getTime(),
		contentType: "application/xhtml+xml",
		error: function(objeto, quepaso, otroobj){
			alert('error'+quepaso+' '+otroobj+''+objeto);
		},
		success: function(objeto){
			//var data = eval("(" + objeto + ")");
			var data = JSON.parse(objeto);
			var Resultados = new String('');

			if(data.Filtros.length > 1){
				for(var i=0; i<data.Filtros.length; i++){
					Resultados = Resultados+' <option value="'+data.Filtros[i].Filtro.id+'">'+data.Filtros[i].Filtro.nombre+'</option>';
				}
				jQuery("#IDFAMILIA").html(Resultados).val('-1').removeAttr('disabled');
			}else{
				Resultados = '<option value="-1">' + str_Todas + '</option>';
				jQuery("#IDFAMILIA").html(Resultados).val('-1').attr('disabled', 'disabled');
			}
		}
	});
}
// Peticion ajax que devuelve el desplegable de subfamilias (empresas de 5 o 3 niveles)
function SeleccionaSubFamilia(IDFamilia){
	var d = new Date();

	jQuery.ajax({
		url:	"http://www.newco.dev.br/ProcesosCdC/CatalogoPrivado/SubFamiliasAJAX.xsql",
		type:	"GET",
		data:	"IDFAMILIA="+IDFamilia+"&_="+d.getTime(),
		contentType: "application/xhtml+xml",
		error: function(objeto, quepaso, otroobj){
			alert('error'+quepaso+' '+otroobj+''+objeto);
		},
		success: function(objeto){
			//var data = eval("(" + objeto + ")");
			var data = JSON.parse(objeto);
			var Resultados = new String('');

			if(data.Filtros.length > 1){
				for(var i=0; i<data.Filtros.length; i++){
					Resultados = Resultados+' <option value="'+data.Filtros[i].Filtro.id+'">'+data.Filtros[i].Filtro.nombre+'</option>';
				}
				jQuery("#IDSUBFAMILIA").html(Resultados).val('-1').removeAttr('disabled');
			}else{
				Resultados = '<option value="-1">' + str_Todas + '</option>';
				jQuery("#IDSUBFAMILIA").html(Resultados).val('-1').attr('disabled', 'disabled');
			}
		}
	});
}
// Peticion ajax que devuelve el desplegable de grupos (empresas de 5 o 3 niveles)
function SeleccionaGrupo(IDSubfamilia){
	var d = new Date();

	jQuery.ajax({
		url:	"http://www.newco.dev.br/ProcesosCdC/CatalogoPrivado/GruposAJAX.xsql",
		type:	"GET",
		data:	"IDSUBFAMILIA="+IDSubfamilia+"&_="+d.getTime(),
		contentType: "application/xhtml+xml",
		error: function(objeto, quepaso, otroobj){
			alert('error'+quepaso+' '+otroobj+''+objeto);
		},
		success: function(objeto){
			//var data = eval("(" + objeto + ")");
			var data = JSON.parse(objeto);
			var Resultados = new String('');

			if(data.Filtros.length > 1){
				if(mostrarGrupos == 'S'){
					for(var i=0; i<data.Filtros.length; i++){
						Resultados = Resultados+' <option value="'+data.Filtros[i].Filtro.id+'">'+data.Filtros[i].Filtro.nombre+'</option>';
					}
					jQuery("#IDGRUPO").html(Resultados).val('-1').removeAttr('disabled');
				}else{
					// En el caso que se trate de una empresa de 3 niveles
					// Recogemos el valor del IDGrupo por defecto y lo pasamos a la siguiente funcion (SeleccionaProducto)
					var IDGrupoXDefecto = data.Filtros[1].Filtro.id;
					SeleccionaProducto(IDGrupoXDefecto);
				}
			}else{
				Resultados = '<option value="-1">' + str_Todas + '</option>';
				jQuery("#IDGRUPO").html(Resultados).val('-1').attr('disabled', 'disabled');
			}
		}
	});
}
// Peticion ajax que devuelve el desplegable de grupos (empresas de 5 o 3 niveles)
function SeleccionaProducto(IDGrupo){
	var d = new Date();

	jQuery.ajax({
		url:	"http://www.newco.dev.br/ProcesosCdC/CatalogoPrivado/ProductosEstandarAJAX.xsql",
		type:	"GET",
		data:	"IDGRUPO="+IDGrupo+"&_="+d.getTime(),
		contentType: "application/xhtml+xml",
		error: function(objeto, quepaso, otroobj){
			alert('error'+quepaso+' '+otroobj+''+objeto);
		},
		success: function(objeto){
			//var data = eval("(" + objeto + ")");
			var data = JSON.parse(objeto);
			var Resultados = new String('');

			if(data.Filtros.length > 1){
				for(var i=0; i<data.Filtros.length; i++){
					Resultados = Resultados+' <option value="'+data.Filtros[i].Filtro.id+'">'+data.Filtros[i].Filtro.nombre+'</option>';
				}
				jQuery("#IDPRODUCTOESTANDAR").html(Resultados).val('-1').removeAttr('disabled');
			}else{
				Resultados = '<option value="-1">' + str_Todas + '</option>';
				jQuery("#IDPRODUCTOESTANDAR").html(Resultados).val('-1').attr('disabled', 'disabled');
			}
		}
	});
}

//eliminar un productos de la licitacion
function modificaProducto(idProdLic,idProd,refProd,descProd,unBaProd,cantProd,precioProd,precioObj,ivaProd,estado){
	var d = new Date();
	var Ejecutar=true;
	
	if ((estado=='B')&&(!confirm(alrt_avisoBorrarProducto))){	//	14set16	Pedimos confirmacion antes de borrar
		Ejecutar=false;
	}

	if (Ejecutar){
		jQuery.ajax({
			cache:	false,
			url:	'http://www.newco.dev.br/Gestion/Comercial/ModificaEstadoProducto.xsql',
			type:	"GET",
			data:	"ID_PROD_LIC="+idProdLic+"&ID_PROD="+idProd+"&REF_PROD="+refProd+"&DESC_PROD="+descProd+"&UN_BA_PROD="+unBaProd+"&CANTIDAD_PROD="+cantProd+"&PRECIO_PROD="+precioProd+"&PRECIO_OBJ="+precioObj+"&IVA_PROD="+ivaProd+"&ESTADO_PROD="+estado+"&_="+d.getTime(),
			contentType: "application/xhtml+xml",
			error: function(objeto, quepaso, otroobj){
				alert('error'+quepaso+' '+otroobj+' '+objeto);
			},
			success: function(objeto){
				//var data = eval("(" + objeto + ")");
				var data = JSON.parse(objeto);

				if(data.ModificaEstadoProducto.estado == 'OK' && estadoLicitacion == 'EST'){
					recuperaDatosProductos(0,'S');
				}else if(data.ModificaEstadoProducto.estado == 'OK' && estadoLicitacion != 'EST'){
					if (estado=='B')
						Recarga();
					else
						recuperaDatosProductosConOfertas();
				}else{
					alert(alrt_errorEliminarProduct);
				}
			}
		});
	}
}


function ActualizarProductos(eliminarOfertas){	//eliminarOfertas no se está utilizando en el PL/SQL
	var arrayCambiosProductos =new Array();
	var listaProductos= '', arrayCambiosProductos, sendProductos, IDTablaProds, thisRowID, thisPosArr;
	var d = new Date();
	var lenAuxIni, lenAuxFin, loops, limit = 30;

	if(jQuery("#lProductos_EST").length){
		IDTablaProds = '#lProductos_EST';
	}else if(jQuery("#lProductos_OFE").length){
		IDTablaProds = '#lProductos_OFE';
	}

	// Como enviamos solo los datos de los productos que se muestran por pantalla (numProductos)
	// Evaluamos tambien que numProductos no sea mas grande que totalProductos
	sendProductos = (numProductos > totalProductos) ? totalProductos : numProductos;

	if(sendProductos > limit){
		//	Si hay mas productos que la variable limit => hacemos 'loops' peticiones ajax
		loops		= Math.ceil(sendProductos / limit);
	}else{
		//	Hacemos una unica peticion ajax
		loops		= 1;
	}

	jQuery('#botonActualizar').hide();
	jQuery('#botonActualizar2').hide();			//	17ene17

	for(var loop = 1; loop <= loops; loop++){
	
		jQuery('#idEstadoLic').html((limit*(loop-1))+'/'+sendProductos);

	
		// Calculamos el indice final de este loop
		lenAuxFin = (limit * loop > sendProductos) ?  sendProductos : (limit * loop);
		// Calculamos el indice inicial de este loop
		lenAuxIni = (limit * loop) - limit;

		listaProductos = '';
		jQuery(IDTablaProds + " tbody tr").each(function(index, element){
			thisRowID	= this.id;
			thisPosArr	= thisRowID.replace('posArr_', '');

			//solodebug	
			//solodebug	debug ('ActualizarProductos thisRow:'+jQuery(element).html()+' thisPosArr:'+thisPosArr
			//solodebug			+' orden:'+ColumnaOrdenadaProds[thisPosArr]+'ID:'+arrProductos[ColumnaOrdenadaProds[thisPosArr]].IDProdLic+ ' Cantidad:'+jQuery('#CANTIDAD_' + thisPosArr).val());


			// Construimos el string listaProductos con los datos de cada producto para este loop (desde lenAuxIni hasta lenAuxFin)
			if(index >= lenAuxIni && index < lenAuxFin){
				var IDProdLic = arrProductos[thisPosArr].IDProdLic;	//	ET 2feb17

				listaProductos += IDProdLic + '|' +				//p_IDProductoEstandar
					jQuery('#UDBASICA_' + thisPosArr).val() + '|' +		//p_UnidadBasica
					jQuery('#CANTIDAD_' + thisPosArr).val() + '|' +		//p_Cantidad
					jQuery('#PRECIOREF_' + thisPosArr).val() + '|' +	//p_PrecioReferencia
					jQuery('#PRECIO_OBJ_' + thisPosArr).val() + '#';	//p_PrecioObjetivo
					
				//28set16 Construimos un array que contenga la misma información para actualizarla si se guarda correctamente	
				var items		= [];
				items['Fila']=thisPosArr;
				items['IDProdLic']=IDProdLic;
				items['UnidadBasica']=jQuery('#UDBASICA_' + thisPosArr).val();
				items['PrecioRef']=jQuery('#PRECIOREF_' + thisPosArr).val();
				items['PrecioObj']=jQuery('#PRECIO_OBJ_' + thisPosArr).val();
				if (isLicAgregada=='N')	items['Cantidad']=Piece(jQuery('#CANTIDAD_' + thisPosArr).val(),',',0);
				
				//solodebug	debug('ActualizarProductos. IDProdLic:'+items['IDProdLic']+' Cant:'+items['Cantidad']);
				
				arrayCambiosProductos.push(items);
			}
		});

		// Quitamos la ultima '#' del string listaProductos
		listaProductos = listaProductos.substring(0, listaProductos.length - 1);
		
		//solodebug	alert ('ActualizarProductos ListaCambios:'+listaProductos);

		jQuery.ajax({
			cache:	false,
			url:	'http://www.newco.dev.br/Gestion/Comercial/ActualizarProductos.xsql',
			type:	"POST",
			async:	false,
			data:	"LIC_ID="+IDLicitacion+"&LISTA_PRODUCTOS="+encodeURIComponent(listaProductos)+"&ELIMINAROFERTAS="+eliminarOfertas+"&_="+d.getTime(),
			error: function(objeto, quepaso, otroobj){
				alert('error'+quepaso+' '+otroobj+' '+objeto);
			},
			success: function(objeto){
				//var data = eval("(" + objeto + ")");
				var data = JSON.parse(objeto);

				if(data.ProductosActualizados.estado == 'OK'){
					// Si estamos en estado 'EST' y se han hecho todas las peticiones ajax,
					// Recuperamos los datos de los productos via ajax, 28set16 También tenemos en cuenta el caso del estado COMP
					if(((estadoLicitacion == 'EST')||(estadoLicitacion == 'COMP')) && loop == loops){
						//	28set16	recuperaDatosProductos(1);
						recuperaDatosProductosDesdeLista(arrayCambiosProductos);
						
						alert(alrt_ProdsActualizadosOK);
					// Si estamos en cualquier otro estado y se han hecho todas las peticiones ajax,
					// Recuperamos los datos de los productos con sus ofertas via ajax
        	        }else if(loop == loops){

						//solodebug	alert ('ActualizarProductos ListaCambios:'+listaProductos+' -> recuperaDatosProductosDesdeLista');
					
						//	28set16	recuperaDatosProductosConOfertas();
						recuperaDatosProductosDesdeLista(arrayCambiosProductos);
						
						alert(alrt_ProdsActualizadosOK);
        	        }
				}else{
					alert(alrt_ProdsActualizadosKO);
					jQuery('#botonActualizar').show();
					jQuery('#botonActualizar2').show();
        	        return;
				}
			}
		});
	}
	jQuery('#botonActualizar').show();
	jQuery('#botonActualizar2').show();
	jQuery('#idEstadoLic').html(mensajeEstadoActual);

	//	2feb17 Redibujamos la tabla de productos, por si hay que recalcular consumos
	
	//solodebug	debug('dibujaTablaProductos'); 
	
	dibujaTablaProductos();

}

//28set16 Para mejorar rendimiento, en caso de actualización en pantalla, recuperamos datos desde pantalla y no vía ajax
function recuperaDatosProductosDesdeLista(arrayCambiosProductos){

	//solodebug	var	msg='';		

	for (i=0;i<arrayCambiosProductos.length;++i){
	
		jQuery('#UDBASICA_' + arrayCambiosProductos[i].fila).val(arrayCambiosProductos[i].UnidadBasica);
		jQuery('#PRECIOREF_' + arrayCambiosProductos[i].fila).val(arrayCambiosProductos[i].PrecioRef);
		jQuery('#PRECIO_OBJ_' + arrayCambiosProductos[i].fila).val(arrayCambiosProductos[i].PrecioObj);
		if (isLicAgregada=='N')	jQuery('#CANTIDAD_' + arrayCambiosProductos[i].fila).val(Piece(arrayCambiosProductos[i].Cantidad,',',0));

		//solodebug	
		//msg+=' fila:'+arrayCambiosProductos[i].fila+' IDProdLic:'+arrayCambiosProductos[i].IDProdLic+'ud.basica:'+arrayCambiosProductos[i].UnidadBasica+' precioobj:'+arrayCambiosProductos[i].PrecioObj+'|';
		
		//	Recorre el array de productos para corregir las lineas correspondientes
		var found=false;
		for (j=0;((j<arrProductos.length) && (!found));++j)
		{
			if (arrProductos[j].IDProdLic==arrayCambiosProductos[i].IDProdLic)
			{

				arrProductos[j].UdBasica=arrayCambiosProductos[i].UnidadBasica;
				
				if (mostrarPrecioIVA == 'S')
				{
					arrProductos[j].PrecioHistIVA=arrayCambiosProductos[i].PrecioRef;
					arrProductos[j].PrecioObjIVA=arrayCambiosProductos[i].PrecioObj;
					
					if (arrProductos[j].TipoIVA != 0)
					{
						arrProductos[j].PrecioHist=arrProductos[j].PrecioHistIVA;
						arrProductos[j].PrecioObj=arrProductos[j].PrecioObjIVA;
					}
					else
					{
						arrProductos[j].PrecioHist=arrProductos[j].PrecioHistIVA/(1+arrProductos[j].TipoIVA/100);
						arrProductos[j].PrecioObj=arrProductos[j].PrecioObjIVA/(1+arrProductos[j].TipoIVA/100);
					}
					
				}
				else
				{
					arrProductos[j].PrecioHist=arrayCambiosProductos[i].PrecioRef;
					arrProductos[j].PrecioObj=arrayCambiosProductos[i].PrecioObj;

					arrProductos[j].PrecioHistIVA=arrProductos[j].PrecioHist;
					arrProductos[j].PrecioObjIVA=arrProductos[j].PrecioObj*(1+arrProductos[j].TipoIVA/100);

				}
				
				if (isLicAgregada=='N')	arrProductos[j].Cantidad=Piece(arrayCambiosProductos[i].Cantidad,',',0);
				
				arrProductos[j].Consumo=parseFloat(arrProductos[j].PrecioObj)*parseFloat(arrProductos[j].Cantidad);
				arrProductos[j].ConsumoIVA=parseFloat(arrProductos[j].PrecioObjIVA)*parseFloat(arrProductos[j].Cantidad);
				arrProductos[j].ConsumoHist=parseFloat(arrProductos[j].PrecioHist)*parseFloat(arrProductos[j].Cantidad);
				arrProductos[j].ConsumoHistIVA=parseFloat(arrProductos[j].PrecioHistIVA)*parseFloat(arrProductos[j].Cantidad);

				arrProductos[j].Consumo=arrProductos[j].Consumo.toString();
				arrProductos[j].ConsumoIVA=arrProductos[j].ConsumoIVA.toString();
				arrProductos[j].ConsumoHist=arrProductos[j].ConsumoHist.toString();
				arrProductos[j].ConsumoHistIVA=arrProductos[j].ConsumoHistIVA.toString();
				
				/*	2may17	Evitamos que aparezca "Nan" en pantalla si no  hay precio histórico informado	*/
				if (arrProductos[j].Consumo=='NaN')
				{
					arrProductos[j].Consumo='';
					arrProductos[j].ConsumoIVA='';
					arrProductos[j].ConsumoHist='';
					arrProductos[j].ConsumoHistIVA='';
				}
				
				//solodebug		
				//msg+=' fila:'+arrProductos[j].Linea+' ud.basica:'+arrProductos[j].UdBasica+' preciohist:'+arrProductos[j].PrecioHist
				//	+' precioobj:'+arrProductos[j].PrecioObj+' cantidad:'+arrProductos[j].Cantidad+' consumo:'+arrProductos[j].Consumo+'\n\r';
				
				found=true;	
			}
		}
		//solodebug	msg+='\n\r';
	}

	//solodebug		alert
	//debug('recuperaDatosProductosDesdeLista: num.filas:' + arrayCambiosProductos.length+'\n\r'+msg);
	//alert('recuperaDatosProductosDesdeLista: num.filas:' + arrayCambiosProductos.length+'\n\r'+msg);
	
	anyChange=false;
		
}


//	Recupera los datos de productos vía AJAX
//	15ene20 Hacemos opcional redibujar tabla
function recuperaDatosProductos(flag, actTabla)
{
	var precioReferenciaVacio = 0, CheckCamposIniciar = true;
	var d = new Date();

	jQuery.ajax({
		cache:	false,
		url:	'http://www.newco.dev.br/Gestion/Comercial/RecuperaProductos.xsql',
		type:	"GET",
		data:	"LIC_ID="+IDLicitacion+"&_="+d.getTime(),
		contentType: "application/xhtml+xml",
		error: function(objeto, quepaso, otroobj){
			alert('error'+quepaso+' '+otroobj+' '+objeto);
		},
		success: function(objeto){
			//var data = eval("(" + objeto + ")");
			var data = JSON.parse(objeto);
			arrProductos	= new Array();

			if(data.ListaProductos.length > 0){

				jQuery.each(data.ListaProductos, function(key, producto){
					// Evaluamos si se han informado todos los precios historicos
					if(producto.PrecioReferencia == ''){
						precioReferenciaVacio = 1;
					}

					// Comprobamos todos los productos estan validados para poder iniciar la licitacion
					if(producto.Validado == 'N'){
						CheckCamposIniciar = false;
                    }

					var items		= [];
					items['linea']		= producto.Linea;
					items['IDProdLic']	= producto.LIC_PROD_ID;
					items['IDProd']		= producto.IDProdEstandar;
					items['RefEstandar']= producto.ProdRefEstandar;
					items['RefCliente']	= producto.ProdRefCliente;
					items['RefCentro']	= producto.ProdRefCentro;
					items['Nombre']		= producto.ProdNombre;
					items['NombreNorm']	= producto.ProdNombreNorm;
					items['UdBasica']	= producto.ProdUdBasica;
					items['FechaAlta']	= producto.FechaAlta;
					items['FechaMod']	= producto.FechaModificacion;
					items['Consumo']	= producto.Consumo;
					items['ConsumoIVA']	= producto.ConsumoIVA;
					items['ConsumoHist']	= producto.ConsumoHist;
					items['ConsumoHistIVA']	= producto.ConsumoHistIVA;
					items['Cantidad']	= producto.Cantidad;
					items['PrecioObj']	= producto.PrecioObjetivo;
					items['PrecioObjIVA']	= producto.PrecioObjetivoIVA;
					items['PrecioHist']	= producto.PrecioReferencia;
					items['PrecioHistIVA']	= producto.PrecioReferenciaIVA;
					items['TipoIVA']	= producto.TipoIVA;

					// Campos Avanzados
					items['InfoAmpliada']	= producto.InfoAmpliada;
					items['Anotaciones']	= producto.Anotaciones;
					items['Documento']	= [];
					if(producto.Documento.ID != ''){
						items['Documento']['ID']		= producto.Documento.ID;
						items['Documento']['Nombre']		= producto.Documento.Nombre;
						items['Documento']['Descripcion']	= producto.Documento.Descripcion;
						items['Documento']['Url']		= producto.Documento.Url;
						items['Documento']['Fecha']		= producto.Documento.Fecha;
					}
					// FIN Campos Avanzados

					items['NumOfertas']	= '0';
					items['TieneSeleccion']	= 'N';
					items['Ordenacion']	= '0';
					
					//solodebug 
					debug('recuperaDatosProductos ('+arrProductos.length+'):'+items.RefEstandar+'/'+items.RefCliente+': '+items.Nombre);

					arrProductos.push(items);
				});

				//
				if(flag && CheckCamposIniciar !== false){
					prodsInformados = 'S';
				}
			}

			if (actTabla=='S')	//15ene20
				prepararTablaProductos(true);

			// Mostramos alert si hay productos con precioRef vacio
			if(flag && precioReferenciaVacio == 1){
				alert(alrt_prodsPrecioRefVacio);
			}
		}
	});
}


//	13set16	recuperamos los datos de ofertas de un proveedor
function cargaDatosOfertasProveedor(LicProvID){
	var CheckCamposPublicar = true;
	var d		= new Date();
	
	//solodebug	var cont=0; 
	
	//solodebug alert('cargaDatosOfertasProveedor:'+LicProvID);
	
	
	var	fila;
	var columna;
	
	//	Buscamos la columna correspondiente al proveedor
	for (i=0; i<arrProveedores.length; ++i){
		if (arrProductos[0].Ofertas[i].IDProvLic==LicProvID) columna=i;
	}
	
	jQuery('#idEstadoLic').html(arrProveedores[columna].NombreCorto);
	
	//pendiente	jQuery('#idEstadoLic').show();
	
	//solodebug	alert ('Proveedor '||LicProvID||' en columna '+columna);
	
	jQuery.ajax({
		cache:	false,
		url:	'http://www.newco.dev.br/Gestion/Comercial/RecuperaOfertaProductos.xsql',
		type:	"GET",
		async:	false,			//	Lo hacemos de forma síncrona, más lento pero más seguro, y permite informar al cliente
		data:	"LIC_ID="+IDLicitacion+"&LIC_PROV_ID="+LicProvID+"&IDIDIOMA="+IDIdioma+"&_="+d.getTime(),
		contentType: "application/xhtml+xml",
		error: function(objeto, quepaso, otroobj){
			alert('error'+quepaso+' '+otroobj+' '+objeto);
		},
		success: function(objeto){
			//var data = eval("(" + objeto + ")");
			var data = JSON.parse(objeto);

			if(data.ProductosLicitacion.ListaProductosOfertas.length > 0){
				jQuery.each(data.ProductosLicitacion.ListaProductosOfertas, function(key, producto){
				
					//	Buscamos la fila correspondiente al producto
					for (j=0; j<arrProductos.length; ++j){
						if (arrProductos[j].Ofertas[columna].IDProdLic==producto.LIC_PROD_ID) fila=j;
					}
								
				
					// Comprobamos todos los productos estan validados para poder iniciar la licitacion
					// if(producto.Informada == 'N'){
					// 	CheckCamposPublicar = false;
					// }

					// var items		= [];
					arrProductos[fila].Ofertas[columna].linea = producto.Linea;
					arrProductos[fila].Ofertas[columna].columna = columna+1;					//	21set16, numerando a partir de la columna 1
					arrProductos[fila].Ofertas[columna].IDProdLic	= producto.LIC_PROD_ID;
					arrProductos[fila].Ofertas[columna].IDProd		= producto.IDProdEstandar;
					arrProductos[fila].Ofertas[columna].RefEstandar	= producto.ProdRefEstandar;
					arrProductos[fila].Ofertas[columna].RefCliente	= producto.ProdRefCliente;
					arrProductos[fila].Ofertas[columna].Nombre		= producto.ProdNombre;
					arrProductos[fila].Ofertas[columna].NombreNorm	= producto.ProdNombreNorm;
					arrProductos[fila].Ofertas[columna].UdBasica	= producto.ProdUdBasica;
					arrProductos[fila].Ofertas[columna].FechaAlta	= producto.FechaAlta;
					arrProductos[fila].Ofertas[columna].FechaMod	= producto.FechaModificacion;
					arrProductos[fila].Ofertas[columna].Consumo	= producto.Consumo;
					arrProductos[fila].Ofertas[columna].ConsumoIVA	= producto.ConsumoIVA;
					arrProductos[fila].Ofertas[columna].Cantidad	= producto.Cantidad;
					arrProductos[fila].Ofertas[columna].PrecioHist	= producto.PrecioReferencia;
					arrProductos[fila].Ofertas[columna].PrecioObj	= producto.PrecioObjetivo;
					arrProductos[fila].Ofertas[columna].TipoIVA	= producto.TipoIVA;
					arrProductos[fila].Ofertas[columna].Ordenacion	= '0';
					arrProductos[fila].Ofertas[columna].PrecioColor = producto.Color;				//	16ene17

					// Campos Avanzados producto
					arrProductos[fila].Ofertas[columna].InfoAmpliada	= producto.InfoAmpliada;
					arrProductos[fila].Ofertas[columna].Documento	= [];
					if(producto.Documento.ID != ''){
						arrProductos[fila].Ofertas[columna].Documento.ID		= producto.Documento.ID;
						arrProductos[fila].Ofertas[columna].Documento.Nombre		= producto.Documento.Nombre;
						arrProductos[fila].Ofertas[columna].Documento.Descripcion	= producto.Documento.Descripcion;
						arrProductos[fila].Ofertas[columna].Documento.Url		= producto.Documento.Url;
						arrProductos[fila].Ofertas[columna].Documento.Fecha		= producto.Documento.Fecha;
					}
					// FIN Campos Avanzados producto
					//arrProductos[fila].Ofertas[columna]	= [];
					arrProductos[fila].Ofertas[columna].ID		= producto.IDOferta;
					arrProductos[fila].Ofertas[columna].IDProvLic	= producto.LIC_PROV_ID;
					arrProductos[fila].Ofertas[columna].IDProducto	= producto.IDProductoOfe;
					arrProductos[fila].Ofertas[columna].RefProv	= producto.RefOfe;
					arrProductos[fila].Ofertas[columna].Nombre	= producto.NombreOfe;
					arrProductos[fila].Ofertas[columna].Marca	= producto.MarcaOfe;
					arrProductos[fila].Ofertas[columna].FechaAlta	= producto.FechaAltaOfe;
					arrProductos[fila].Ofertas[columna].FechaMod	= producto.FechaModificacionOfe;
					arrProductos[fila].Ofertas[columna].UdsXLote	= producto.UdsXLoteOfe;
					arrProductos[fila].Ofertas[columna].Cantidad	= producto.CantidadOfe;
					arrProductos[fila].Ofertas[columna].Precio	= producto.PrecioOfe;
					arrProductos[fila].Ofertas[columna].TipoIVA	= producto.TipoIVAOfe;
					arrProductos[fila].Ofertas[columna].Consumo	= producto.ConsumoOfe;
					arrProductos[fila].Ofertas[columna].ConsumoIVA	= producto.ConsumoIVAOfe;
					arrProductos[fila].Ofertas[columna].IDEstadoEval	= producto.IDEstadoEvaluacionOfe;
					arrProductos[fila].Ofertas[columna].EstadoEval	= producto.EstadoEvaluacionOfe;

					// Campos Avanzados oferta
					arrProductos[fila].Ofertas[columna].InfoAmpliada	= producto.InfoAmpliadaOferta;
					arrProductos[fila].Ofertas[columna].Documento	= [];
					if(producto.DocumentoOferta.ID != ''){
						arrProductos[fila].Ofertas[columna].Documento.ID		= producto.DocumentoOferta.ID;
						arrProductos[fila].Ofertas[columna].Documento.Nombre		= producto.DocumentoOferta.Nombre;
						arrProductos[fila].Ofertas[columna].Documento.Descripcion	= producto.DocumentoOferta.Descripcion;
						arrProductos[fila].Ofertas[columna].Documento.Url		= producto.DocumentoOferta.Url;
						arrProductos[fila].Ofertas[columna].Documento.Fecha		= producto.DocumentoOferta.Fecha;
					}
					// FIN Campos Avanzados oferta

					arrProductos[fila].Ofertas[columna].FichaTecnica	= [];
					if(producto.FichaTecnica.ID != ''){
						arrProductos[fila].Ofertas[columna].FichaTecnica.ID		= producto.FichaTecnica.ID;
						arrProductos[fila].Ofertas[columna].FichaTecnica.Nombre	= producto.FichaTecnica.Nombre;
						arrProductos[fila].Ofertas[columna].FichaTecnica.Descripcion	= producto.FichaTecnica.Descripcion;
						arrProductos[fila].Ofertas[columna].FichaTecnica.Url		= producto.FichaTecnica.Fichero;
						arrProductos[fila].Ofertas[columna].FichaTecnica.Fecha	= producto.FichaTecnica.Fecha;
                    }

					arrProductos[fila].Ofertas[columna].OfertaAdjud	= producto.Adjudicada;	//	21set16 Informar oferta adjudicada
					
					if (arrProductos[fila].Ofertas[columna].OfertaAdjud=='S'){	//	21set16 Informar producto con oferta adjudicada
						arrProductos[fila].TieneSeleccion='S';
						arrProductos[fila].ColSeleccionada=columna;
						numProdsSeleccion++;			//	26set16
						
						//solodebug	alert('fila:'+fila+' columna:'+columna+arrProductos[fila].TieneSeleccion+ 'numProdsSeleccion:'+numProdsSeleccion);
						
					}
					//26set16	CUidado: las siguientes lineas machacaban la info anterior
					//26set16	else
					//26set16		arrProductos[fila].TieneSeleccion='N';
					
					if (producto.Informada=='S')
						arrProductos[fila].Ofertas[columna].NoInformada	= 'N';
					else
						arrProductos[fila].Ofertas[columna].NoInformada	= 'S';
					
					if ((arrProductos[fila].Ofertas[columna].UdsXLote=='0')&&(producto.PrecioOfe=='0,0000'))
						arrProductos[fila].Ofertas[columna].NoOfertada='S';
					else{
						arrProductos[fila].Ofertas[columna].NoOfertada='N';
						arrProductos[fila].NumOfertas++;						//	30set16 Actualizamos el contador de ofertas
					}
						
						
					//solodebug	
					//	alert ('Proveedor '+LicProvID+' en columna '+columna+' producto '+arrProductos[fila].Nombre
					//			+' oferta:'+arrProductos[fila].Ofertas[columna].Precio+ 'adjudicada:'+producto.Adjudicada+','+arrProductos[fila].Ofertas[columna].OfertaAdjud);


					//solodebug
					//if ((LicProvID==5085)&&(cont<10)){
					//	++cont;
					//	alert('Entrando LicProvID:'+LicProvID+' LIC_PROD_ID:'+producto.LIC_PROD_ID+' fila:'+fila+'Precio oferta:'+producto.PrecioOfe+':'+arrProductos[fila].Ofertas[columna].Precio);
					//}

					//solodebug					alert('Consumo:'+arrProductos[fila].Consumo);

                });

				//if(CheckCamposPublicar !== false){
				//	ofertaProvInformada = 'S';
				//}
				
			}	
			
		}
	});

	//pendiente	jQuery('#idEstadoLic').html(mensajeEstadoActual);
	
	//solodebug	alert(mensajeEstadoActual);
	
	//pendiente	jQuery('#idEstadoLic').show();
	
	//solodebug	MuestraMatrizOfertas();
	
}

	
function recuperaDatosProductosConOfertas(){
	
	//solodebug
	debug('recuperaDatosProductosConOfertas');
	
	recuperaDatosProductos(1,'N');
	
	//	Recuperar los datos por proveedor
	cargaDatosOfertasPorProveedores();
	prepararTablaProductos(true);
    validarBotonAdjudicar();
	
}


function ReferenciaCentro(IDProdLic)
{
	var RefCentro='', Encont=false;
	for (var i=0;(i<arrProductosPorCentro.length)&&(!Encont);++i)
	{
		//solodebug	debug('ReferenciaCentro('+IDProdLic+')'+'. Comprobando arrProductosPorCentro('+i+'):'+arrProductosPorCentro[i].IDProdLic);
		
		if(arrProductosPorCentro[i].IDProdLic==IDProdLic)
		{
			RefCentro=arrProductosPorCentro[i].RefCentro;
			Encont=true;
		}
	}
	return RefCentro;
}


//	16ago16 Recuperamos los datos de compras del centro seleccionado
function recuperaDatosCompraPorCentro(){
	var precioReferenciaVacio = 0, CheckCamposIniciar = true;
	var d = new Date();
	var oForm = document.forms['PublicarCompras'];
	var IDCentro = oForm.elements['IDCENTROCOMPRAS'].value;
	
	jQuery.ajax({
		cache:	false,
		url:	'http://www.newco.dev.br/Gestion/Comercial/RecuperaDatosCompraPorCentro.xsql',
		type:	"GET",
		data:	"LIC_ID="+IDLicitacion+"&IDCENTRO="+IDCentro+"&_="+d.getTime(),
		contentType: "application/xhtml+xml",
		error: function(objeto, quepaso, otroobj){
			alert('error'+quepaso+' '+otroobj+' '+objeto);
		},
		success: function(objeto){
			//var data = eval("(" + objeto + ")");
			var data = JSON.parse(objeto);
			arrProductosPorCentro	= new Array();

			if(data.ListaProductos.length > 0){

				jQuery.each(data.ListaProductos, function(key, producto){
					// Evaluamos si se han informado todos los precios historicos
					if(producto.PrecioReferencia == ''){
						precioReferenciaVacio = 1;
					}

					// Comprobamos todos los productos estan validados para poder iniciar la licitacion
					if(producto.Validado == 'N'){
						CheckCamposIniciar = false;
                    }

					var items		= [];
					items['linea']		= producto.Linea;
					items['IDProdLic']	= producto.LIC_PROD_ID;
					items['IDProd']		= producto.IDProdEstandar;
					items['RefEstandar']	= producto.ProdRefEstandar;
					items['RefCliente']	= producto.ProdRefCliente;
					//items['Nombre']		= producto.ProdNombre;
					//items['NombreNorm']	= producto.ProdNombreNorm;
					items['UdBasica']	= producto.ProdUdBasica;
					items['RefCentro']	= producto.ProdRefCentro;

					items['Cantidad']	= producto.Cantidad;
					items['Ordenacion']	= '0';
					
					//solodebug		alert(producto.IDProdEstandar+':'+ producto.ProdRefCliente+':'+producto.ProdRefCentro);

					arrProductosPorCentro.push(items);

				});

				//
				//if(flag && CheckCamposIniciar !== false){
				//	prodsInformados = 'S';
				//}
			}

			prepararTablaProductos(true);
		}
	});
}

// Peticion ajax que informa el desplegable de usuarios cuando se selecciona un proveedor de la lista
function usuariosProveedor(IDProveedor)
{
	
	/*	19feb20 Informaremos el usuario por defecto para el cliente
	var d = new Date();

	if(isNaN(IDProveedor)){
		jQuery("#LIC_IDUSUARIOPROVEEDOR").empty();
		jQuery("#filaUsuarioProveedor").hide();
		return;
	}

	jQuery.ajax({
		cache:	false,
		url:	'http://www.newco.dev.br/Gestion/Comercial/UsuariosProveedor.xsql',
		type:	"GET",
		data:	"IDProveedor="+IDProveedor+"&_="+d.getTime(),
		contentType: "application/xhtml+xml",
		error: function(objeto, quepaso, otroobj){
			alert('error'+quepaso+' '+otroobj+' '+objeto);
		},
		success: function(objeto){
			//var data = eval("(" + objeto + ")");
			var data = JSON.parse(objeto);

			jQuery("#filaUsuarioProveedor").show();
			jQuery("#LIC_IDUSUARIOPROVEEDOR").empty();
			jQuery("#LIC_IDUSUARIOPROVEEDOR").append("<option value=''>" + str_Selecciona + "</option>");

			for(var i=0;i<data.ListaUsuarios.length;i++){
				jQuery("#LIC_IDUSUARIOPROVEEDOR").append("<option value='"+data.ListaUsuarios[i].id+"'>"+data.ListaUsuarios[i].centro+":"+data.ListaUsuarios[i].nombre+"</option>");
				jQuery("#LIC_IDUSUARIOPROVEEDOR").val("");
			}
		}
	});
	*/
}


// Funcion para anyadir proveedores a la licitacion
function AnadirProveedor(oForm){
	var IDProveedor	= oForm.elements['LIC_IDPROVEEDOR'].value;
	var IDUsuario	= '';				//	19feb20	oForm.elements['LIC_IDUSUARIOPROVEEDOR'].value;
	var EstadoEval	= oForm.elements['LIC_IDESTADOEVALUACION'].value;
	var Comentarios	= oForm.elements['LIC_COMENTARIOS'].value.replace(/'/g, "''");	// Sustituimos comilla simple (') por dos comillas simples ('') para que no rompa el PL/SQL
	var BloquearAvisos = (jQuery("#BLOQUEARAVISOS").attr('checked')) ? 'S' : 'N';
	var d = new Date();

    jQuery("#btnAnadirProveedores").hide();

    jQuery.ajax({
        cache:    false,
        url:    'http://www.newco.dev.br/Gestion/Comercial/NuevoProveedor.xsql',
        type:    "GET",
        data:    "PROV_ID="+IDProveedor+"&PROV_US_ID="+IDUsuario+"&LIC_ID="+IDLicitacion+"&IDESTADOEVALUACION="+EstadoEval+"&COMENTARIOS="+encodeURIComponent(Comentarios)+"&BLOQUEARAVISOS="+BloquearAvisos+"&_="+d.getTime(),
        contentType: "application/xhtml+xml",
        error: function(objeto, quepaso, otroobj){
            alert('error'+quepaso+' '+otroobj+' '+objeto);
            jQuery("#btnAnadirProveedores").show();
        },
        success: function(objeto){
			//var data = eval("(" + objeto + ")");
			var data = JSON.parse(objeto);

            if(data.NuevoProveedor.estado == 'OK'){
                // Informamos variable de validacion de proveedores informados (si hay proveedores)
                provsInformados = 'S';

                // Si cuando anyadimos un proveedor la lic esta INF, entonces cambiamos el estado a CURS
                if(estadoLicitacion == 'INF'){
                    estadoLicitacion = 'CURS';
                    jQuery("#idEstadoLic").text(str_EnCurso);
                    jQuery("#idEstadoLic").addClass("amarillo");
                }

                recuperaDatosProveedores();
            }else{
                alert(alrt_NuevoProveedorKO);
            }
            jQuery("#btnAnadirProveedores").show();
        }
    });
}


//	30jun20 Añade un proveedor o una selección de proveedores (Sustituye a AnadirSeleccionProveedor)
function AnadirSeleccionesProveedores(oForm)
{
	var d = new Date();
	var Selecciones='';
	//	Recorre los checkboxes para detectar cambios
	for (var i=0;i<oForm.elements.length;++i)
	{
		//console.log('ProveedorOSeleccion:'+oForm.elements[i].name.substring(0,4));
		if ((oForm.elements[i].name.substring(0,5)=='PROV_')&&(oForm.elements[i].checked)&&(!oForm.elements[i].disabled))
		{
			Selecciones+=Piece(oForm.elements[i].name,'_',2)+'|';
		}
	}
	
	jQuery("#btnAnadirSelecciones").hide();

	jQuery.ajax({
		cache:	false,
		url:	'http://www.newco.dev.br/Gestion/Comercial/AnnadirSeleccionesProveedoresAJAX.xsql',
		type:	"GET",
		data:	"SELECCIONES="+Selecciones+"&LIC_ID="+IDLicitacion+"&_="+d.getTime(),
		contentType: "application/xhtml+xml",
		error: function(objeto, quepaso, otroobj){
			alert('error'+quepaso+' '+otroobj+' '+objeto);
            jQuery("#btnAnadirSelecciones").show();
		},
		success: function(objeto){
			//var data = eval("(" + objeto + ")");
			var data = JSON.parse(objeto);

			if(data.NuevaSeleccion.estado == 'OK'){
				// Informamos variable de validacion de proveedores informados (si hay proveedores)
				provsInformados = 'S';

				// Si cuando anyadimos un proveedor la lic esta INF, entonces cambiamos el estado a CURS
				if(estadoLicitacion == 'INF'){
					estadoLicitacion = 'CURS';
					jQuery("#idEstadoLic").text(str_EnCurso);
					jQuery("#idEstadoLic").addClass("amarillo");
				}
				
				// si todo ha ido bien, desactiva los checkboxes
				for (var i=0;i<oForm.elements.length;++i)
				{
					if ((oForm.elements[i].name.substring(0,5)=='PROV_')&&(oForm.elements[i].checked)&&(!oForm.elements[i].disabled))
					{
						oForm.elements[i].disabled=true;
					}
				}

				recuperaDatosProveedores();
			}else{
				alert(alrt_NuevoProveedorKO);
			}
            jQuery("#btnAnadirSelecciones").show();
		}
	});
	
}

// Funcion para anyadir proveedores a la licitacion
function AnadirSeleccionProveedor(oForm){
	var IDSeleccion	= oForm.elements['LIC_IDPROVEEDOR'].value;
	var EstadoEval	= oForm.elements['LIC_IDESTADOEVALUACION'].value;
	var Comentarios	= oForm.elements['LIC_COMENTARIOS'].value.replace(/'/g, "''");	// Sustituimos comilla simple (') por dos comillas simples ('') para que no rompa el PL/SQL
	var BloquearAvisos = (jQuery("#BLOQUEARAVISOS").attr('checked')) ? 'S' : 'N';
	var d = new Date();

	jQuery("#btnAnadirProveedores").hide();

	jQuery.ajax({
		cache:	false,
		url:	'http://www.newco.dev.br/Gestion/Comercial/NuevaSeleccionProveedor.xsql',
		type:	"GET",
		data:	"SEL_ID="+IDSeleccion+"&LIC_ID="+IDLicitacion+"&IDESTADOEVALUACION="+EstadoEval+"&COMENTARIOS="+encodeURIComponent(Comentarios)+"&BLOQUEARAVISOS="+BloquearAvisos+"&_="+d.getTime(),
		contentType: "application/xhtml+xml",
		error: function(objeto, quepaso, otroobj){
			alert('error'+quepaso+' '+otroobj+' '+objeto);
            jQuery("#btnAnadirProveedores").show();
		},
		success: function(objeto){
			//var data = eval("(" + objeto + ")");
			var data = JSON.parse(objeto);

			if(data.NuevaSeleccion.estado == 'OK'){
				// Informamos variable de validacion de proveedores informados (si hay proveedores)
				provsInformados = 'S';

				// Si cuando anyadimos un proveedor la lic esta INF, entonces cambiamos el estado a CURS
				if(estadoLicitacion == 'INF'){
					estadoLicitacion = 'CURS';
					jQuery("#idEstadoLic").text(str_EnCurso);
					jQuery("#idEstadoLic").addClass("amarillo");
				}

				recuperaDatosProveedores();
			}else{
				alert(alrt_NuevoProveedorKO);
			}
            jQuery("#btnAnadirProveedores").show();
		}
	});
}


//	1jul20 Marca las sleeciones que ya han sido utilizadas
function RevisarListaSelecciones()
{
	for (var i=0;i<PieceCount(listaSelecciones,'|');++i)
	{
		var IDSeleccion=Piece(listaSelecciones,'|',i);
		jQuery("#PROV_SEL_"+IDSeleccion).prop( "checked", true ).prop( "disabled", true );
	}
}


//	Recupera la info de proveedores tras insertar nuevos
function recuperaDatosProveedores(){
	var d = new Date();

	//solodebug debug('recuperaDatosProveedores');
	totalProvs=0;	//24ene20
	
	jQuery.ajax({
		cache:	false,
		url:	'http://www.newco.dev.br/Gestion/Comercial/RecuperaProveedores.xsql',
		type:	"GET",
		data:	"LIC_ID="+IDLicitacion+"&IDIDIOMA="+IDIdioma+"&ROL="+rol+"&_="+d.getTime(),
		contentType: "application/xhtml+xml",
		error: function(objeto, quepaso, otroobj){
			alert('error'+quepaso+' '+otroobj+' '+objeto);
		},
		success: function(objeto){
			//var data = eval("(" + objeto + ")");
			var data = JSON.parse(objeto);
			arrProveedores	= new Array();

			if(data.ListaProveedores.length > 0){

				jQuery.each(data.ListaProveedores, function(key, proveedor){

					var items		= [];
					items['linea']		= proveedor.Linea;
					items['IDProvLic']	= proveedor.IDPROVEEDOR_LIC;
					items['IDProveedor']	= proveedor.ID;
					items['Nombre']		= proveedor.Nombre;
					items['NombreCorto']	= proveedor.NombreCorto;
					items['FechaAlta']	= proveedor.FechaAlta;
					items['FechaOferta']	= proveedor.FechaOferta;
					items['IDEstadoProv']	= proveedor.IDEstadoProv;
					items['EstadoProv']	= proveedor.EstadoProv;
					items['CommsProv']	= proveedor.ComentariosProv;
					items['CommsCdC']	= proveedor.ComentariosCdC;
					items['IDEstadoEval']	= proveedor.IDEstadoEvaluacion;
					items['EstadoEval']	= proveedor.EstadoEvaluacion;
					items['PedidoMin']	= proveedor.PedidoMin;
					items['ConsumoProv']	= proveedor.ConsumoProv;
					items['ConsumoProvIVA']	= proveedor.ConsumoProvIVA;
					items['Ahorro']		= proveedor.Ahorro;
					items['OfertasVacias']	= proveedor.OfertasVacias;
					items['ConsumoPot']	= proveedor.ConsumoPotencial;
					items['ConsumoPotIVA']	= proveedor.ConsumoPotencialIVA;
					items['ConsumoAdj']	= proveedor.ConsumoAdjudicado;
					items['ConsumoAdjIVA']	= proveedor.ConsumoAdjudicadoIVA;
					items['AhorroIVA']	= proveedor.AhorroIVA;
					items['NumeroLineas']	= proveedor.NumeroLineas;

					items['Frete']			= proveedor.Frete;				//	12ago16
					items['PlazoEntrega']	= proveedor.PlazoEntrega;		//	12ago16

					items['OfeConAhorro']	= proveedor.OfertasConAhorro;
					items['OfeMejPrecio']	= proveedor.OfertasConMejorPrecio;
					items['ConsMejPrecio']	= proveedor.ConsConMejorPrecio;
					items['ConsMejPrecIVA']	= proveedor.ConsConMejorPrecioIVA;
					items['AhorMejPrecio']	= proveedor.AhorroEnMejorPrecio;
					items['ConsConAhorro']	= proveedor.ConsConAhorro;
					items['ConsConAhorIVA']	= proveedor.ConsConAhorroIVA;
					items['AhorOfeConAhor']	= proveedor.AhorroOfeConAhorro;
					items['OfertasAdj']	= proveedor.OfertasAdjudicadas;

					items['IDUsuarioProv']	= proveedor.UsuarioProve;
					items['NombreUsuario']	= proveedor.NombreUsuario;

					items['HayConversa']	= proveedor.HayConversacion;
					items['UltMensaje']	= proveedor.UltMensaje;
					items['Estrellas']	= proveedor.Estrellas;	
					items['BloqPedidos']	= proveedor.BloqPedidos;		//	13ene20
					
					items['IDDocumento'] = proveedor.IDDocumento;	//	19feb20

					arrProveedores.push(items);
					ColumnaOrdenadaProvs[totalProvs] = totalProvs;			//	24ene20
					++totalProvs;											//	24ene20
					
					//solodebug debug('recuperaDatosProveedores ('+totalProvs+'):'+proveedor.NombreCorto);
				});
				// Informamos variable de validacion de proveedores informados (si hay proveedores)
				provsInformados = 'S';
			}else{
				// Informamos variable de validacion de proveedores informados (no hay proveedores)
				provsInformados = 'N';
			}

			// Preparamos datos para dibujar nueva tabla
			//prepararTablaProveedores();	
			
			//totalProvs=arrProveedores.length;	//24ene20

			OrdenarProvsPorColumna('NombreCorto');	//	12nov19
			dibujaTablaProveedores();
			
		}
	});
}

// Eliminar un proveedor de la licitacion
function eliminarProveedor(IDProve,IDUsuarioProve){
	var d = new Date();

	jQuery.ajax({
		cache:	false,
		url:	'http://www.newco.dev.br/Gestion/Comercial/EliminarProveedor.xsql',
		type:	"GET",
		data:	"ID_PROVE="+IDProve+"&ID_USUARIO_PROVE="+IDUsuarioProve+"&ID_ESTADO=B&_="+d.getTime(),
		contentType: "application/xhtml+xml",
		error: function(objeto, quepaso, otroobj){
			alert('error'+quepaso+' '+otroobj+' '+objeto);
		},
		success: function(objeto){
			//var data = eval("(" + objeto + ")");
			var data = JSON.parse(objeto);

			if(data.EliminarProveedor.estado == 'OK'){
				recuperaDatosProveedores();
			}else{
				alert(alrt_EliminarProveedorKO);
			}
		}
	});
}

function AnadirUsuario(oForm){
	var IDUsuarioFirm	= oForm.elements['LIC_IDUSUARIO'].value;
        var Firma               = (oForm.elements['LIC_USU_FIRMA'].checked) ? 'S': 'N';
	var Perfil		= (oForm.elements['LIC_USU_COAUTOR'].checked) ? 'COAUTOR': '';

	var d = new Date();

	jQuery.ajax({
		cache:	false,
		url:	'http://www.newco.dev.br/Gestion/Comercial/NuevoUsuario.xsql',
		type:	"GET",
		data:	"LIC_ID="+IDLicitacion+"&US_FIRMA_ID="+IDUsuarioFirm+"&LIC_USU_FIRMA="+Firma+"&LIC_USU_PERFIL="+Perfil+"&_="+d.getTime(),
		contentType: "application/xhtml+xml",
		error: function(objeto, quepaso, otroobj){
			alert('error'+quepaso+' '+otroobj+' '+objeto);
		},
		success: function(objeto){
			//var data = eval("(" + objeto + ")");
			var data = JSON.parse(objeto);

			if(data.NuevoUsuario.estado == 'OK'){
				recuperaUsuarios();
                        }else if(data.NuevoUsuario.estado == 'USUARIO_YA_EXISTE'){
				alert(alrt_UsuarioYaExiste);
			}else{
				alert(alrt_NuevoUsuarioKO);
			}
		}
	});
}


function AnadirCentro(oForm){
	var IDCentro	= oForm.elements['LIC_IDCENTRO'].value;
	var d = new Date();

	jQuery.ajax({
		cache:	false,
		url:	'http://www.newco.dev.br/Gestion/Comercial/NuevoCentro.xsql',
		type:	"GET",
		data:	"LIC_ID="+IDLicitacion+"&IDCENTRO="+IDCentro+"&_="+d.getTime(),
		contentType: "application/xhtml+xml",
		error: function(objeto, quepaso, otroobj){
			alert('error'+quepaso+' '+otroobj+' '+objeto);
		},
		success: function(objeto){
			//var data = eval("(" + objeto + ")");
			var data = JSON.parse(objeto);

			if(data.NuevoCentro.estado == 'OK')
			{
				//	3ago20 incluye el centro en el desplegable IDCENTROREFERENCIA
				
				//solodebug console.log(JSON.stringify(data.NuevoCentro));
				
				if (data.NuevoCentro.RefPropias=='S')
				{
					var opt = document.createElement("option");        
					opt.text = document.getElementById("LIC_IDCENTRO").options[document.getElementById('LIC_IDCENTRO').selectedIndex].text;
					opt.value = IDCentro;

					//solodebug console.log('AnadirCentro: ('+opt.value+') '+opt.text);

					// Add an Option object to Drop Down List Box
					document.getElementById('IDCENTROREFERENCIA').options.add(opt);
				}
				recuperaCentros();
				recuperaUsuarios();	//	12jul16	Al insertar centros, también insertamos sus usuarios
      		}
			else if(data.NuevoCentro.estado == 'CENTRO_YA_EXISTE')
			{
				alert(alrt_CentroYaExiste);
			}
			else
			{
				alert(alrt_NuevoCentroKO);
			}
		}
	});
}

function recuperaUsuarios(){
	var d = new Date();
	jQuery.ajax({
		cache:	false,
		url:	'http://www.newco.dev.br/Gestion/Comercial/RecuperaUsuarios.xsql',
		type:	"GET",
		data:	"LIC_ID="+IDLicitacion+"&ROL="+rol+"&IDIOMA="+IDIdioma+"&_="+d.getTime(),
		contentType: "application/xhtml+xml",
		error: function(objeto, quepaso, otroobj){
			alert('error'+quepaso+' '+otroobj+' '+objeto);
		},
		success: function(objeto){
			//var data = eval("(" + objeto + ")");
			var data = JSON.parse(objeto);

			if(data.ListaUsuarios.length > 0){
				jQuery("#lUsuarios tbody").empty();

				jQuery.each(data.ListaUsuarios, function(key, usuario){
					var tbodyUsuario = "<tr style='border-bottom:1px solid #7d7d7d;'><td class='datosLeft'>";
					if (usuario.Autor == 'S'){ tbodyUsuario +="<span class='amarillo'><strong>"+str_Autor+":</strong></span> "; }

					tbodyUsuario +=  usuario.Nombre+"</td>" +
							"<td>" + usuario.FechaAlta+"</td>" +
							"<td>" + usuario.Estado+"</td>" +
							"<td>" + usuario.FechaModificacion+"</td>" +
							"<td>" + usuario.Comentarios+"</td>" +
							"<td>";
					if(usuario.Autor == 'S'){
						tbodyUsuario += '&nbsp';
//					}else if(IDEstado == null || IDEstado == 'B'){
					}else if(isAutor == 'S' && estadoLicitacion == 'EST'){
						tbodyUsuario += "<a class=\"accBorrar\" href=\"javascript:modificaUsuario(" + usuario.IDUSUARIO_LIC + ",'B');\">" +
                                                    "<img src=\"http://www.newco.dev.br/images/2017/trash.png\">" +
                                                    "</a>";
					}else{
						tbodyUsuario += '&nbsp';
					}

					if (liciFirmada != '' || IDLicitacion == 'FIRM'){
						tbodyUsuario +="<a href='javascript:modificaUsuario("+usuario.IDUSUARIO_LIC+", 'FIRM');'><img src='http://www.newco.dev.br/images/firmar.gif'/></a>";
					}

					tbodyUsuario +="</td></tr>";
					jQuery("#lUsuarios tbody").append(tbodyUsuario);
				});

//				EstadoActualLicitacion();

			}else{
				jQuery("#lUsuarios tbody").empty().append("<tr><td align='center' colspan='6'><strong>" + str_SinUsuarios + "</strong></td></tr>");
			}
		}
	});
}

function recuperaCentros(){
	var d = new Date();
	jQuery.ajax({
		cache:	false,
		url:	'http://www.newco.dev.br/Gestion/Comercial/RecuperaCentrosLic.xsql',
		type:	"GET",
		data:	"LIC_ID="+IDLicitacion+"&_="+d.getTime(),
		contentType: "application/xhtml+xml",
		error: function(objeto, quepaso, otroobj){
			alert('error'+quepaso+' '+otroobj+' '+objeto);
		},
		success: function(objeto){
			//var data = eval("(" + objeto + ")");
			var data = JSON.parse(objeto);

			if(data.ListaCentros.length > 0){
				jQuery("#lCentros_EST tbody").empty();
				NumCentrosEnLicitacion=0;

				jQuery.each(data.ListaCentros, function(key, centro){
					var tbodyCentro = "<tr style='border-bottom:1px solid #7d7d7d;'><td colspan='2'>&nbsp;</td><td class='datosLeft'>";

					tbodyCentro +=  centro.NombreCorto+"</td>" +
							"<td class='datosLeft'>" + centro.Nombre+"</td>" +
							"<td>";
					if(estadoLicitacion == 'EST'){
						tbodyCentro += "<a class=\"accBorrar\" href=\"javascript:borrarCentro(" + centro.Licc_ID +"," + centro.IDCentro + ");\">" +
                                                    "<img src=\"http://www.newco.dev.br/images/2017/trash.png\">" +
                                                    "</a>";
					}else{
						tbodyCentro += '&nbsp';
					}

					tbodyCentro +="</td></tr>";

					jQuery("#lCentros_EST tbody").append(tbodyCentro);
					
					NumCentrosEnLicitacion+=1;		//	2set16	Actualizamos el contador de centros

				});
			}else{
				jQuery("#lCentros_EST tbody").empty().append("<tr><td align='center' colspan='5'><strong>" + str_SinCentros + "</strong></td></tr>");
			}
		}
	});
}

//eliminar un usuario de la licitacion
function modificaUsuario(idUsEliminar,Estado){
	var d = new Date();

	jQuery.ajax({
		cache:	false,
		url:	'http://www.newco.dev.br/Gestion/Comercial/ModificaEstadoUsuario.xsql',
		type:	"GET",
		data:	"ID_US_ELIMINAR="+idUsEliminar+"&US_ESTADO="+Estado+"&_="+d.getTime(),
		contentType: "application/xhtml+xml",
		error: function(objeto, quepaso, otroobj){
			alert('error'+quepaso+' '+otroobj+' '+objeto);
		},
		success: function(objeto){
			//var data = eval("(" + objeto + ")");
			var data = JSON.parse(objeto);

			if(data.ModificaEstadoUsuario.estado == 'OK'){
				if(Estado == 'FIRM'){
					if (window.opener !== null && !window.opener.closed){
						opener.location.reload();	// Recarga de la pagina padre para actualizar el estado de la licitacion
					}
					alert(alrt_licitacionFirmada);
					Recarga();	//23jul19	location.reload();
					return;
				}

				recuperaUsuarios();
			}else{
				alert(alrt_EliminarUsuarioKO);
			}

		}
	});
}

//eliminar un usuario de la licitacion
function borrarCentro(idCentroEliminarLic, idCentroEliminar){
	var d = new Date();

	jQuery.ajax({
		cache:	false,
		url:	'http://www.newco.dev.br/Gestion/Comercial/BorrarCentro.xsql',
		type:	"GET",
		data:	"ID_CENTRO_ELIMINAR="+idCentroEliminarLic+"&_="+d.getTime(),
		contentType: "application/xhtml+xml",
		error: function(objeto, quepaso, otroobj){
			alert('error'+quepaso+' '+otroobj+' '+objeto);
		},
		success: function(objeto){
			//var data = eval("(" + objeto + ")");
			var data = JSON.parse(objeto);

			if(data.BorrarCentro.estado == 'OK')
			{
				
				//	quita el centro del desplegable IDCENTROREFERENCIA
				var select=document.getElementById('IDCENTROREFERENCIA');

				for (i=0;i<select.length;  i++) {
					
					//solodebug	console.log('Buscando centro:'+idCentroEliminar+' encontrado:'+select.options[i].value);
					
				   if (select.options[i].value==idCentroEliminar) {
    				 select.remove(i);
				   }
				}

				recuperaCentros();

				
			}else{
				alert(alrt_EliminarCentroKO);
			}

		}
	});
}


//	Activa el botón de "adjudicar" cuando corresponda
function validarBotonAdjudicar(){
	var productosOlvidados;	//	21set16	Por ahora hacemos un control local
	
	//	21set16	Hacemos aqui las comprobaciones básicas que pueden dar lugar a errores antes de adjudicar
	if (((arrProductos.length>numProductos) && (numProdsSeleccion<numProductos))||(numProdsSeleccion==0)) {
		productosOlvidados = 'S';
	}
	else{
		productosOlvidados = 'N';
	}


	if(productosOlvidados == 'N'){
		jQuery('#botonAdjudicarSelec a').removeClass("grey");
	}
}

// Inicializa el menu desplegable de los meses de la licitacion con el valor por defecto o el valor guardado
function seleccionaMeses(){
	
	//15set16 El valor por defecto se envía desde la base de datos
	//if(mesesSelected == '')	mesesSelected = '12';	/* Valor por defecto para nueva licitacion */
	//jQuery("#LIC_MESES").val(mesesSelected);

	if(mesesSelected == '')	mesesSelected = jQuery("#LIC_MESES").val();
	
	// Si es pedido puntual => mostrar campos necesarios para generar el pedido
	if((mesesSelected == '0') && (isLicAgregada == 'N')){
		jQuery('.campoPedidoPuntual').show();
		jQuery('.campoPedidoPuntual_Inv').hide();
	}
}

// Comprueba que la licitacion esta lista para poder iniciarla
function IniciarLicitacion(IDEstado){

	var MensajeProductos='';

	//	6oct17	Forzamos revisión de productos informados, más seguro que hace el control en cada modificación
	//	13oct17	Incluimos un mensaje por error encontrado
	prodsInformados = 'S';
	for (j=0;j<arrProductos.length;++j)		// && (prodsInformados=='S')
	{
		//	solodebug	debug('IniciarLicitacion. Comprobando producto:'+j+' Ud.Basica:'+arrProductos[j].UdBasica+' Cant:'+arrProductos[j].Cantidad);
		
		if ((arrProductos[j].UdBasica === undefined) || (arrProductos[j].UdBasica == '')) 
		{
			prodsInformados='N';
			MensajeProductos+=arrProductos[j].Nombre.substring(0, 50)+': '+alrt_UdBasicaNoInformada+'\n';
		}
	
		if ((arrProductos[j].Cantidad === undefined) || (parseFloat(arrProductos[j].Cantidad)<=0))
		{
			prodsInformados='N';
			MensajeProductos+=arrProductos[j].Nombre.substring(0, 50)+': '+alrt_CantidadCero+'\n';
		}
	}

	//	2set16	Comprueba también que tenga centros, 
	//	6oct17 Reactivamos el control de prodsInformados que fallaba con Pioneira
	if ((provsInformados == 'S') && (prodsInformados == 'S') && (isLicAgregada == 'N' || NumCentrosEnLicitacion>0))
	{		
		CambioEstadoLicitacion(IDEstado);
	}
	else
	{
	
		var Mensaje=alrt_NoIniciarLicitacion+'\n\r\n\r';
		
		if(prodsInformados == 'N')
			Mensaje+=MensajeProductos;		//13oct17	alrt_NoIniciarLicProds
		if(provsInformados == 'N')
			Mensaje+=alrt_NoIniciarLicProvs;
		if (isLicAgregada == 'S' && NumCentrosEnLicitacion==0)
			Mensaje+=alrt_NoIniciarLicCentros;
			
		alert(Mensaje+'\n\r\n\r');
	}
}


// 2dic20 Envía la licitación al GESTOR para que se ocupe de la misma
function EnviarGestor()
{
	CambioEstadoLicitacion('EST');	
}


// 12set16	Comprueba que la licitacion esta lista para poder informar los consumos
function NoInformacionCompras(){

	if (isLicAgregada == 'S' && NumCentrosEnLicitacion>0){
		CambioEstadoLicitacion('COMP');
	}else{
		Mensaje=alrt_NoIniciarLicCentros;
		
		alert(Mensaje);
	}
}


// Cambiamos estado de la licitacion, ya sea pq se inicia ('EST' => 'CURS') 16ago16:('EST' => 'COMP') ('COMP' => 'CURS')
// Ya sea pq se adjudica ('CURS' => 'ADJ' o 'INF' => 'ADJ')
function CambioEstadoLicitacion(IDEstado){
	var Comentarios	= '', IDProveedor = '';
	var d = new Date();
	var	enviarCambio = true;
	
	//	En el caso de licitación agregada, comprobamos si hay centros pendientes antes de iniciar
	if ((IDEstado=='CURS') && (isLicAgregada=='S') && (NumCentrosPendientes>0) && (confirm(conf_CentrosPendientesInformar.replace('#NUMCENTROS#', NumCentrosPendientes))==false))
	{
		enviarCambio = false;
	}
	
	if (enviarCambio){
		jQuery.ajax({
			cache:	false,
			url:	'http://www.newco.dev.br/Gestion/Comercial/CambiarEstadoLicitacion.xsql',
			type:	"GET",
			data:	"ID_LIC="+IDLicitacion+"&ID_ESTADO="+IDEstado+"&ID_PROVEEDOR="+IDProveedor+"&COMENTARIOS="+Comentarios+"&_="+d.getTime(),
			contentType: "application/xhtml+xml",
			error: function(objeto, quepaso, otroobj){
				alert('error'+quepaso+' '+otroobj+' '+objeto);
			},
			success: function(objeto){
			//var data = eval("(" + objeto + ")");
			var data = JSON.parse(objeto);

				if(data.NuevoEstado.estado == 'OK'){
					location.href = 'http://www.newco.dev.br/Gestion/Comercial/MantLicitacion.xsql?LIC_ID=' + IDLicitacion;
				}else{
					alert(alrt_NuevoEstadoLicKO);
				}
			}
		});
	}
}

function verFichas(ID){
	if(document.getElementById('FT_' + ID).style.display == 'none'){
		jQuery(".fichasTecnicas").hide();
		jQuery("#FT_" + ID).show();
	}else{
		jQuery("#FT_" + ID).hide();
	}
}

function addDocFile(uploadForm, ID)
{
	debug('addDocFile. form:'+uploadForm.name+' ID:inputFileDoc_'+ID+' uploadFilesDoc.length:'+uploadFilesDoc.length);

	//var uploadElem = document.getElementById("inputFileDoc_" + ID);
	var uploadElem = jQuery("#inputFileDoc_" + ID);

	debug('addDocFile. form:'+uploadForm.name+' ID:inputFileDoc_'+ID+' uploadFilesDoc.length:'+uploadFilesDoc.length+' uploadElem.value:'+uploadElem.value);

	if(uploadElem.value != '')
	{
		uploadFilesDoc[uploadFilesDoc.length] = uploadElem.value;
		debug('addDocFile.1. Doc:'+uploadElem.value+ ' length:'+uploadFilesDoc.length);
	}
	else
	{
		uploadFilesDoc.splice(ID, 1);
		debug('addDocFile.2. Doc:'+uploadFilesDoc.value+ ' length:'+uploadFilesDoc.length);
	}

	return true;
}
/*

//	12feb20 En la misma petición informamos el array de documentos y lo enviamos al servidor
function addDocFileAndLoad(uploadForm, ID, tipo)
{
	debug('addDocFile. form:'+uploadForm.name+' ID:inputFileDoc_'+ID+' uploadFilesDoc.length:'+uploadFilesDoc.length);

	//var uploadElem = document.getElementById("inputFileDoc_" + ID);
	var uploadElem = jQuery("#inputFileDoc_" + ID);

	debug('addDocFile. form:'+uploadForm.name+' ID:inputFileDoc_'+ID+' uploadFilesDoc.length:'+uploadFilesDoc.length+' uploadElem.value:'+uploadElem.value);

	uploadFilesDoc[0] = uploadElem.value;
	return cargaDoc(uploadForm, ID, tipo);
}

*/
//cargar documentos
function cargaDoc(uploadForm, tipo, valueID){
	// valueID puede ser:
	//	si tipo in (FT) => valueID = LicProdID
	//	si tipo in (OA, OMVM, OMVMB, OFNCP, etc...) => valueID = LicID
	//	5mar19 DOC_IDLICITACION, LIC_ID
	
	//solodebug	debug('cargaDoc. form:'+uploadForm.name+ ' tipo:'+tipo+ ' ID:'+valueID);

	if(uploadFrameDoc && uploadFrameDoc.document && uploadFrameDoc.document.getElementsByTagName("body")[0]){
		uploadFrameDoc.document.getElementsByTagName("body")[0].innerHTML = "";
	}

	var msg = '';

	if(msg != ''){
		alert(msg);
	}else{
		if(hasFilesDoc(uploadForm)){
			//solodebug	debug('cargaDoc. form:'+uploadForm.name+ ' tipo:'+tipo+ ' ID:'+valueID+ ' hasfiles ok!');
			
			//	6mar19 Guardamos los valores originales del formulario
			var targetOrig=uploadForm.target;
			var enctypeOrig=uploadForm.enctype;
			var actionOrig=uploadForm.action;

			//	Cambiamos el nombre del objeto file (el nombre era diferente para evitar confunidor con docs de producto)
			jQuery("#inputFileDoc_"+valueID).attr('name', 'inputFileDoc');


			uploadForm.target = 'uploadFrameDoc';
			uploadForm.action = 'http://www.newco.dev.br/cgi-bin/uploadDocsMVM.pl';
			uploadForm.enctype = 'multipart/form-data';
			waitDoc(valueID);
			periodicTimerDoc = 0;
			periodicUpdateDoc(uploadForm, valueID, tipo);
			uploadForm.submit();

			//	12feb20 Recuperamos los valores originales del formulario
			uploadForm.target=targetOrig;
			uploadForm.enctype=enctypeOrig;
			uploadForm.action=actionOrig;

			//	Cambiamos el nombre del objeto file
			jQuery("#inputFileDoc_"+valueID).attr('name', 'inputFileDoc_Proveedor');
		}
		else
			debug('cargaDoc. form:'+uploadForm.name+ ' tipo:'+tipo+ ' ID:'+valueID+ ' hasfiles NO!');
	}//fin else
}
//fin de carga documentos js

//Search form if there is a filled file input
function hasFilesDoc(form)
{
	//solodebug debug('hasFilesDoc. form:'+form.name);
	for(var i=0; i<form.length; i++) {
	
		//if(form.elements[i].type == 'file' && (form.elements[i].name.substring(0,12) == 'inputFileDoc'))
		//solodebugdebug('hasFilesDoc. form:'+form.name+ ' element['+i+']:'+form.elements[i].name + ' value:'+form.elements[i].value);
		
		
		if(form.elements[i].type == 'file' && (form.elements[i].name.substring(0,12) == 'inputFileDoc') && form.elements[i].value != '' ){
			return true;
		}
	}
	return false;
}

//function que dice al usuario de esperar
function waitDoc(valueID){
	jQuery('#waitBoxDoc_'+valueID).html ('<img src="http://www.newco.dev.br/images/loading.gif" />');
	jQuery('#waitBoxDoc_'+valueID).show();
	return false;
}

/**
 * Check periodically if the image upload is finished
 * @return Boolean - true if filled file input found
 */
 
function logFormElements(formName){
  var Text='';
  
  for (i=0; i<formName.elements.length; i++){
    Text+=formName.elements[i].name+'\n\r';
  }
  return(Text);
}
 
function periodicUpdateDoc(uploadForm, valueID, tipo){
	// valueID puede ser:
	//	si tipo in (FT) => valueID = LicProdID
	//	si tipo in (OA, OMVM, OMVMB, OFNCP, etc...) => valueID = LicID


	//solodebug	debug('periodicUpdateDoc. tipo:'+tipo+ ' ID:'+valueID+' uploadForm:'+uploadForm.name);

	if(periodicTimerDoc >= MAX_WAIT_DOC){
		return false;
	}
	periodicTimerDoc++;

	//solodebug	debug('periodicUpdateDoc. tipo:'+tipo+ ' ID:'+valueID+' form:'+uploadForm.name+'::'+logFormElements(uploadForm));

	if(uploadFrameDoc && uploadFrameDoc.document && uploadFrameDoc.document.getElementsByTagName("p")[0]) 
	{
		
		tipoDoc = tipo;

		if(tipoDoc == 'LIC_PRODUCTO_FT' || tipoDoc == 'LIC_OFERTA_FT'){
			document.getElementById('waitBoxDoc_CA').style.display = 'none';
		}else{
		
			debug('periodicUpdateDoc. tipo:'+tipo+ ' valueID:'+valueID+' form:'+uploadForm.name+'::'+logFormElements(uploadForm));
		
			document.getElementById('waitBoxDoc_'+valueID).style.display = 'none';
		}

		var uFrame = uploadFrameDoc.document.getElementsByTagName("p")[0];

		if(uFrame.innerHTML.substr(0, 1) != '{' && uFrame.innerHTML.substr(0, 1) != '['){
			return false;
		}else{
			var response = eval('(' + uFrame.innerHTML + ')');
			handleFileRequestDoc(uploadForm,response,valueID, tipo);
			return true;
		}
	}else{
		setTimeout(function(){periodicUpdateDoc(uploadForm,valueID, tipo)}, 1000);
		return false;
	}
	return true;
}
 

/**
 * handle Request after file (or image) upload
 * @param {Array} resp Hopefully JSON string array
 * @return Boolean
 */
function handleFileRequestDoc(form, resp, valueID, tipo){
	// valueID puede ser:
	//	si tipo in (FT) => valueID = LicProdID
	//	si tipo in (OA, OMVM, OMVMB, OFNCP, etc...) => valueID = LicID

	debug('handleFileRequestDoc. resp:'+resp+' tipo:'+tipo+ ' ID:'+valueID);

	var lang = new String('');
	if(document.getElementById('myLanguage') && document.getElementById('myLanguage').innerHTML.length > 0){
		lang = document.getElementById('myLanguage').innerHTML;
	}

	var msg = '';
	var target = '_top';
	var enctype = 'application/x-www-form-urlencoded';
	var documentChain = new String('');
	var action = 'http://www.newco.dev.br/Administracion/Mantenimiento/Productos/confirmCargaDocumento.xsql';
	var docNombre = '';
	var docDescri = '';
	var nombre = '';
	var cadenaDoc = '';

	if(resp.documentos){
		if(resp.documentos && resp.documentos.length > 0){
			for(var i=0; i<resp.documentos.length; i++){
				if(resp.documentos[i].error && resp.documentos[i].error != ''){
					msg += resp.documentos[i].error;
				}else{
					if(resp.documentos[i].size){

						/*en lugar del elemento nombre del form cojo el nombre del fichero directamente, si hay espacios el sistema pone guion bajo, entonces cuento cuantos guiones son, divido al penultimo y añado la ultima palabra, si la ultima palabra esta vacía implica que hay 2 ghiones bajos, entonces divido a los 2 ghiones bajos y cojo la primera parte.*/
						var sinEspacioNombre = '';
						var lastWord = '';
						var numSep = PieceCount(sinEspacioNombre,'_');
						var numSepOk = numSep -1;

						sinEspacioNombre = resp.documentos[i].nombre.replace('__','_');

						if(Piece(sinEspacioNombre,'_',numSepOk) == ''){
							if(sinEspacioNombre.search('__')){
								lastWord	= sinEspacioNombre.split('__');
								docNombre	= lastWord[0];
							}
						}else{
							lastWord	= Piece(sinEspacioNombre,'_',numSepOk);
							nombre		= sinEspacioNombre.split(lastWord);
							docNombre	= nombre[0].concat(lastWord);
						}

						documentChain += resp.documentos[i].nombre + '|'+ docNombre+'|'+ resp.documentos[i].size +'|'+ docDescri + '#';
					}
				}
			}

			if(msg == ''){
				document.getElementsByName('CADENA_DOCUMENTOS')[0].value = documentChain;
				cadenaDoc= document.getElementsByName('CADENA_DOCUMENTOS')[0].value;
			}
		}
	}

	var borrados='', borr_ante = 'N', prove = '';

	if(document.getElementById('ProductosProveedor')){
		var borrados = document.forms['ProductosProveedor'].elements['DOCUMENTOS_BORRADOS'].value;
		var borr_ante = document.forms['ProductosProveedor'].elements['BORRAR_ANTERIORES'].value;
		var tipoDoc = document.forms['ProductosProveedor'].elements['TIPO_DOC'].value;
		var prove = document.forms['ProductosProveedor'].elements['LIC_PROV_IDPROVEEDOR'].value;
	}
	tipoDoc = tipo;

	if(msg != ''){
		alert(msg);
		return false;
	}else{
		form.encoding = enctype;
		form.action = action;
		form.target = target;

		jQuery.ajax({
			url:"http://www.newco.dev.br/Administracion/Mantenimiento/Productos/confirmCargaDocumento.xsql",
			data: "ID_PROVEEDOR="+prove+"&DOCUMENTOS_BORRADOS="+borrados+"&BORRAR_ANTERIORES="+borr_ante+"&TIPO_DOC="+tipoDoc+"&PARAMETROS="+valueID+"&CADENA_DOCUMENTOS="+cadenaDoc,
			type: "GET",
			async: false,
			contentType: "application/xhtml+xml",
			beforeSend:function(){
				if(tipoDoc == 'LIC_PRODUCTO_FT' || tipoDoc == 'LIC_OFERTA_FT'){
					document.getElementById('confirmBox_CA').style.display = 'none';
					document.getElementById('waitBoxDoc_CA').src = 'http://www.newco.dev.br/images/loading.gif';
				}else{
					document.getElementById('confirmBox_'+valueID).style.display = 'none';
					document.getElementById('waitBoxDoc_'+valueID).src = 'http://www.newco.dev.br/images/loading.gif';
				}
			},
			error:function(objeto, quepaso, otroobj){
				alert("objeto:"+objeto);
				alert("otroobj:"+otroobj);
				alert("quepaso:"+quepaso);
			},
			success:function(data){
				//var doc=eval("(" + data + ")");
				var doc=JSON.parse(data);

				var currentDocID	= doc[0].id_doc;
				var nombreDoc		= doc[0].nombre;
				var fileDoc			= doc[0].file;

				if(tipoDoc == 'LIC_PRODUCTO_FT' || tipoDoc == 'LIC_OFERTA_FT')
				{
				
					//solodebug	debug('handleFileRequestDoc LIC_PRODUCTO_FT o LIC_OFERTA_FT. Actualizado OK. nombreDoc:'+nombreDoc+' fileDoc:'+fileDoc);
				
					document.getElementById('confirmBox_CA').style.display = 'block';

					jQuery("#camposAvanzados input#IDDOC").val(currentDocID);
					jQuery("#camposAvanzados input#NombreDoc").val(nombreDoc);
					jQuery("#camposAvanzados input#UrlDoc").val(fileDoc);
					jQuery("#camposAvanzados span#NombreDoc").html('<a href="http://www.newco.dev.br/Documentos/'+fileDoc+'" target="_blank">'+nombreDoc+'</a>');
					jQuery("#camposAvanzados input#inputFileDoc_CA").hide();
					jQuery("#camposAvanzados span#DocCargado").show();
				}
				else if(valueID == 'SC')
				{
				
					//solodebug	debug('handleFileRequestDoc SC. Actualizado OK. nombreDoc:'+nombreDoc+' fileDoc:'+fileDoc);
				
					jQuery("#subirContrato input#IDDOC").val(currentDocID);
					jQuery("#subirContrato span#NombreDoc").html(nombreDoc);
					jQuery("#subirContrato input#inputFileDoc_SC").hide();
					jQuery("#subirContrato span#DocCargado").show();
				}else{
					document.getElementById('confirmBox_'+valueID).style.display = 'block';
					if(tipoDoc == 'FT'){
						//recargamos las ofertas y las fichas
						SeleccionaFichas(prove,'IDFICHA_' + valueID, currentDocID);
					}
					else if(tipoDoc == 'DOC_LICITACION')
					{
						//solodebug	
						debug("handleFileRequestDoc DOC_LICITACION. Actualizado OK. nombreDoc:"+nombreDoc);
					
						form.elements['LIC_IDDOCUMENTO'].value=currentDocID;
						jQuery("#inputFileDoc_"+valueID).hide();
						jQuery("#divDatosDocumento").show();
						jQuery("#docLicitacion").text(nombreDoc);
					}
					//	27ene20
					else if(tipoDoc == 'DOC_PROV_LICITACION')
					{
						//solodebug	debug("handleFileRequestDoc DOC_PROV_LICITACION. Actualizado OK. nombreDoc:"+nombreDoc+" valueID:"+valueID);
					
						form.elements['LIC_PROV_IDDOCUMENTO'].value=currentDocID;
						jQuery("#inputFileDoc_"+valueID).hide();
						jQuery("#divDatosDocumento").show();
						jQuery("#docProvLicitacion").text(nombreDoc);
					}
					
/* PENDIENTE DE IMPLEMENTAR SUBIR CONTRATO
                		        else{
						//lamamos a la funcion que informa del DOC_ID en la tabla licitaciones
						InformarNuevoContrato(doc, valueID);
					}
*/
				}

				uploadFrameDoc.document.getElementsByTagName("p")[0].innerHTML = '';
				uploadFrameDoc.document.getElementsByTagName("body")[0].innerHTML = "";

				//resettamos los input file, mismo que removeDoc
				var clearedInput;
				if(tipoDoc == 'LIC_PRODUCTO_FT' || tipoDoc == 'LIC_OFERTA_FT'){
					var uploadElem = document.getElementById("inputFileDoc_CA");
				}
				else
				{
					var uploadElem = document.getElementById("inputFileDoc_" + valueID);
				}

				uploadElem.value = '';
				clearedInput = uploadElem.cloneNode(false);

				uploadElem.parentNode.insertBefore(clearedInput, uploadElem);
				uploadElem.parentNode.removeChild(uploadElem);

				uploadFilesDoc.splice(valueID, 1);
				return undefined;
			}
		});
	}
		
	return true;
}

//cambio de fichas segun el proveedor
function SeleccionaFichas(IDProveedor,IDTipo,currentDocID,accion){
	var d = new Date();

	if(IDProveedor != -1 && IDProveedor != 0){
		jQuery.ajax({
			cache:	false,
			url:	'http://www.newco.dev.br/Administracion/Mantenimiento/Productos/FichasProveedor.xsql',
			type:	"GET",
			data:	"IDPROVEEDOR="+IDProveedor+"&IDDOC_ACTUAL="+currentDocID+"&_="+d.getTime(),
			contentType: "application/xhtml+xml",
			success: function(objeto){
				//var data = eval("(" + objeto + ")");
				var data = JSON.parse(objeto);
				var Resultados = new String('');
				var valor = '';

				if(data.Filtros != ''){
					arrFichasTecnicas	= new Array();

					for(var i=0; i<data.Filtros.length; i++){
						// Reconstruimos el array de fichas tecnicas con el nuevo documento
						var items		= [];
						items['ID']		= data.Filtros[i].Fitro.id;
						items['listItem']	= data.Filtros[i].Fitro.nombre;
						items['Fichero']	= data.Filtros[i].Fitro.file;
						arrFichasTecnicas.push(items);

						if(i==1){
							var Doc_ID_Actual	= data.Filtros[i].Fitro.id;
							var File_ID_Actual	= data.Filtros[i].Fitro.file;
							var File_URL_Actual	= 'http://www.newco.dev.br/Documentos/'+File_ID_Actual;
						}

						Resultados = Resultados+'<option value="'+data.Filtros[i].Fitro.id+'">'+data.Filtros[i].Fitro.nombre+'</option>';
					}

					jQuery(".IDFicha").each(function(){
						// Capturamos el valor actual seleccionado en el desplegable
						valor = jQuery(this).val();
						// Recargamos el desplegable
						jQuery(this).html(Resultados);

						if(this.id == IDTipo)
							jQuery("#" + IDTipo).val(Doc_ID_Actual);
						else
							jQuery(this).val(valor);
					});

					return undefined;
				}
			},
			error: function(xhr, errorString, exception) {
				alert("xhr.status="+xhr.status+" error="+errorString+" exception="+exception);
			}
		});
	}
}


//	Variables con cadenas necesarias para construir el HTML de las tabla que se construyen via JS
var rowStart		= '<tr>';
var rowStartClass	= '<tr class="#CLASS#">';		//	ET	30dic16
var rowStartID		= '<tr id="#ID#">';
var rowStartIDClass	= '<tr id="#ID#" class="#CLASS#">';
var rowStartStyle	= '<tr style="#STYLE#">';
var rowStartIDStyle	= '<tr id="#ID#" style="#STYLE#">';
var rowStartIDClassStyl	= '<tr id="#ID#" class="#CLASS#" style="#STYLE#">';
var rowEnd		= '</tr>';
var cellStart		= '<td>';
var cellStartID		= '<td id="#ID#">';
var cellStartIDClass	= '<td id="#ID#" class="#CLASS#">';
var cellStartIDClassSty	= '<td id="#ID#" class="#CLASS#" style="#STYLE#">';
var cellStartClass	= '<td class="#CLASS#">';
var cellStartClassStyle	= '<td class="#CLASS#" style="#STYLE#">';
var cellStartStyle	= '<td style="#STYLE#">';
var cellStartColspan	= '<td colspan="#COLSPAN#">';
var cellStartColspanCls	= '<td colspan="#COLSPAN#" class="#CLASS#">';
var cellStartColspanSty	= '<td colspan="#COLSPAN#" style="#STYLE#">';

var cellEnd		= '</td>';

var divStartClassID		= '<div class="#CLASS#" id="#ID#">';
var divStartStyle		= '<div style="#STYLE#">';
var divStartClass		= '<div class="#CLASS#">';
var divStartClassStyle	= '<div class="#CLASS#" style="#STYLE#">';			//	10dic18
var divStartIDAlign		= '<div id="#ID#" align="#ALIGN#">';
var divStartIDStyAlg	= '<div id="#ID#" style="#STYLE#" align="#ALIGN#">';
var divEnd				= '</div>';

var spanStartID		= '<span id="#ID#">';
var spanStartClass	= '<span class="#CLASS#">';
var spanStartStyle	= '<span style="#STYLE#">';
var spanStartClassStyle	= '<span class="#CLASS#" style="#STYLE#">';
var spanStartClassTitle	= '<span class="#CLASS#" title="#TITLE#">';
var spanEnd		= '</span>';

var macroEnlaceAccIDStyle	= '<a class="#CLASS#" id="#ID#" href="#HREF#" style="#STYLE#">';								//	ET	11mar19
var macroEnlaceAccIDStyleTitle	= '<a class="#CLASS#" id="#ID#" href="#HREF#" style="#STYLE#" title="#TITLE#">';			//	ET	24jul19
var macroEnlaceIDStyle	= '<a id="#ID#" href="#HREF#" style="#STYLE#">';													//	ET	29oct19
var macroEnlaceAccID	= '<a class="#CLASS#" id="#ID#" href="#HREF#">';													//	ET	30dic16
var macroEnlaceRef	= '<a href="javascript:FichaProductoLic(\'#LIC_PROD_ID#\');">';
var macroEnlaceRef2	= '<a href="javascript:FichaProductoLic(\'#LIC_PROD_ID#\');" style="text-decoration:none;">';
var macroEnlaceAcc	= '<a class="#CLASS#" href="#HREF#">';
var macroEnlace		= '<a href="#HREF#">';
var macroEnlace2	= '<a href="#HREF#" style="#STYLE#">';
var macroEnlace3	= '<a href="#HREF#" class="#CLASS#" style="#STYLE#">';
var macroEnlaceTarget	= '<a href="#HREF#" target="_blank">';
var macroEnlaceEnd	= '</a>';
var macroInputText	= '<input type="text" name="#NAME#" id="#ID#" value="#VALUE#" class="#CLASS#" size="#SIZE#" maxlength="#MAXLENGTH#"/>';
var macroInputTextonKeyUp	= '<input type="text" name="#NAME#" id="#ID#" value="#VALUE#" class="#CLASS#" size="#SIZE#" maxlength="#MAXLENGTH#" onkeyup="#ONKEYUP#"/>';// 19set16 onkeyup antes onChange
var macroInputTextonKeyUpStyle	= '<input type="text" name="#NAME#" id="#ID#" value="#VALUE#" class="#CLASS#" size="#SIZE#" style="#STYLE#" maxlength="#MAXLENGTH#" onkeyup="#ONKEYUP#"/>';// 3dic20
var macroInputRadio	= '<input type="radio" name="#NAME#" class="#CLASS#" value="#VALUE#" #CHECKED#/>';
var macroInputFile	= '<input type="file" name="#NAME#" id="#ID#" onChange="#ONCHANGE#"/>';
var macroInputHidden= '<input type="hidden" name="#NAME#" id="#ID#" value="#VALUE#" class="#CLASS#"/>';

var macroSelect			= '<select name="#NAME#" id="#ID#" class="#CLASS#">';
var macroSelectOnChange	= '<select name="#NAME#" id="#ID#" class="#CLASS#" onChange="#ONCHANGE#">';
var macroSelectEnd		= '</select>';

var optionStart		= '<option value="#VALUE#" #SELECTED#>';
var optionEnd		= '</option>';


var macroImagen		= '<img src="#SRC#" title="#TITLE#" alt="#ALT#" style="vertical-align:text-bottom;"/>';
var macroImagen2	= '<img src="#SRC#" id="#ID#" title="#TITLE#" alt="#ALT#" style="vertical-align:text-bottom;"/>';
var macroImagen3	= '<img src="#SRC#" class="#CLASS#" title="#TITLE#" alt="#ALT#"/>';
var macroImagen5	= '<img id="#ID#" src="#SRC#" class="#CLASS#" title="#TITLE#" alt="#ALT#" style="#STYLE#"/>';	//17set16 para esconder imagen en entradas de datos por fila



function prepararTablaProductos(dibujaTabla){		//	17nov17
	totalProductos	= arrProductos.length;

	if(ColumnaOrdenacionProds == 'linea'){
		for(var i=0; i<totalProductos; i++){
			ColumnaOrdenadaProds[i] = i;
		}

		if (dibujaTabla) dibujaTablaProductos();			//	17nov17
	}else{
		OrdenarProdsPorColumna(ColumnaOrdenacionProds, true);
	}
}


function dibujaTablaProductos(){

	//	14jul16	
	if(completarCompraCentro == 'S'){
		dibujaTablaProductosCENTRO();
	}else if(estadoLicitacion == 'EST'){
		dibujaTablaProductosEST();
	}else if(rol == 'VENDEDOR'){
		if(permitirEdicionPROV == 'S'){
			dibujaTablaProductosPROVE();
		}else{
			dibujaTablaProductosPROVE_INF();
		}
	}else{
		dibujaTablaProductosOFE();
	}

	if(ProductExist == false && ColumnaOrdenacionProds == 'Ordenacion'){
		alert(alrt_sinResultados);
	}
}


//	1set16	Busca la cantidad correspondiente al producto por ID
function buscaCantidadProductoPorCentro(ID)
{
	var Cantidad;
	//var Estado='NO ENCONTRADO';
	//var TextoDebug='';
	
	for(var i=0; i<totalProductos; i++){
		//TextoDebug+=' [ID:'+arrProductosPorCentro[i].IDProdLic+' Cantidad:'+arrProductosPorCentro[i].Cantidad+']';
		if (arrProductosPorCentro[i].IDProdLic==ID){
			Cantidad=arrProductosPorCentro[i].Cantidad;
			//Estado='Encontrado';
		}
	}
	//alert('ET DEBUG. ID:'+ID+' Estado:'+Estado+' Cantidad:'+Cantidad+ ' debug:'+TextoDebug);
	return Cantidad;
}

//	1set16	Busca la cantidad correspondiente al producto por ID
function buscaRefProductoPorCentro(ID)
{
	var Referencia;
	
	for(var i=0; i<totalProductos; i++){
		if (arrProductosPorCentro[i].IDProdLic==ID){
			if (arrProductosPorCentro[i].RefCentro!='')
				Referencia=arrProductosPorCentro[i].RefCentro;
			else if  (arrProductosPorCentro[i].RefCliente!='')
				Referencia=arrProductosPorCentro[i].RefCliente;
			else if  (arrProductosPorCentro[i].RefEstandar!='')
				Referencia=arrProductosPorCentro[i].RefEstandar;
		}
	}
	return Referencia;
}


//	Tabla de productos para informar los consumos por centro
function dibujaTablaProductosCENTRO(){

	var htmlTBODY = '', thisRow = '', thisCell = '' , thisMacro = '', functionJS, valAux;
	var contLinea = 0;
	anyChange = false;
	
	if(totalProductos > 0){
		for(var i=0; i<totalProductos; i++){
				
			contLinea++;

			// Iniciamos la fila (tr)
			thisRow = rowStartIDClass.replace('#ID#', 'posArr_' + (arrProductos[ColumnaOrdenadaProds[i]].linea - 1));
			thisRow = thisRow.replace('#CLASS#', 'infoProds');

			// Celda/Columna numeracion
			thisCell = cellStart;
			thisCell += '&nbsp;' + contLinea + '&nbsp;';
			thisCell += cellEnd;
			thisRow += thisCell;

			// Celda/Columna Ref.Cliente
			thisCell = cellStart;

			//	14jul20 Trabajamos con la referencia por centro
			var Referencia=buscaRefProductoPorCentro(arrProductos[ColumnaOrdenadaProds[i]].IDProdLic);
			thisCell += Referencia;
			
			/*if(arrProductos[ColumnaOrdenadaProds[i]].RefCliente != ''){
				thisCell += arrProductos[ColumnaOrdenadaProds[i]].RefCliente;	// Mostramos Ref.Cliente si existe
			}else{
				thisCell += arrProductos[ColumnaOrdenadaProds[i]].RefEstandar;	// Mostramos Ref.Estandar si no existe Ref.Cliente
			}*/
			
			thisCell += cellEnd;
			thisRow += thisCell;

			// Celda/Columna Nombre
			thisCell = cellStartClassStyle.replace('#CLASS#','datosLeft');
			thisCell = thisCell.replace('#STYLE#','padding:2px 0px 2px 4px;');
			//1set16 Cuidado, esta funcion utiliza el otro array: thisCell += '<strong>' + NombreProductoConEstilo(i) + '</strong>&nbsp;';
			thisCell += '<strong>' + arrProductos[ColumnaOrdenadaProds[i]].Nombre + '</strong>&nbsp;';
			thisCell += cellEnd;
			thisRow += thisCell;

			// Celda/Columna UdBasica
			thisCell = cellStartClass.replace('#CLASS#', 'udBasica');
			thisCell += arrProductos[ColumnaOrdenadaProds[i]].UdBasica;
			thisCell += cellEnd;
			thisRow += thisCell;

			// Celda/Columna Cantidad
			thisCell = cellStart;
			thisMacro = macroInputTextonKeyUp.replace('#NAME#', 'Cantidad_' + (arrProductos[ColumnaOrdenadaProds[i]].linea - 1));
			thisMacro = thisMacro.replace('#ID#', 'Cantidad_' + (arrProductos[ColumnaOrdenadaProds[i]].linea - 1));
			thisMacro = thisMacro.replace('#CLASS#', 'cantidad peq');
			thisMacro = thisMacro.replace('#SIZE#', '8');
			thisMacro = thisMacro.replace('#MAXLENGTH#', '8');
			thisMacro = thisMacro.replace('#ONKEYUP#', 'javascript:ActivarBotonGuardarCentro('+(arrProductos[ColumnaOrdenadaProds[i]].linea - 1)+')');
			
			var Cantidad=buscaCantidadProductoPorCentro(arrProductos[ColumnaOrdenadaProds[i]].IDProdLic);
			
			if(isLicPorProducto == 'S'){
				if(Cantidad){
					thisMacro = thisMacro.replace('#VALUE#', Cantidad);
				}else{
					thisMacro = thisMacro.replace('#VALUE#', '0');
				}
			}else{
				thisMacro = thisMacro.replace('#VALUE#', Cantidad);
			}
			thisCell += thisMacro;
			thisCell += cellEnd;
			thisRow += thisCell;

			// Celda/Columna para guardar los datos de la oferta fila a fila
			thisCell = cellStartClass.replace('#CLASS#', 'acciones');
			functionJS	= 'javascript:guardarDatosCompraFila(\'' + (arrProductos[ColumnaOrdenadaProds[i]].linea - 1) + '\')';
			thisMacro	= macroEnlace3.replace('#CLASS#', 'guardarOferta');
			thisMacro	= thisMacro.replace('#HREF#', functionJS);
			thisMacro	= thisMacro.replace('#STYLE#', 'text-decoration:none;');
			thisCell	+= thisMacro;

			thisMacro	= macroImagen5.replace('#SRC#', 'http://www.newco.dev.br/images/guardar.gif');
			thisMacro	= thisMacro.replace('#ID#', 'btnGuardar_'+ (arrProductos[ColumnaOrdenadaProds[i]].linea - 1));	//	17set16	ID
			thisMacro	= thisMacro.replace('#CLASS#', '');
			thisMacro	= thisMacro.replace('#TITLE#', str_Guardar);
			thisMacro	= thisMacro.replace('#ALT#', str_Guardar);
			thisMacro	= thisMacro.replace('#STYLE#', 'display:none;');	//	17set16	botones ocultos
			thisCell	+= thisMacro;

			thisCell	+= macroEnlaceEnd;
			thisCell += cellEnd;
			thisRow += thisCell;

			//	17set16	ID para el icono de guardado/error
			thisCell = cellStartClass.replace('#CLASS#', 'resultado');
			thisCell += '<span id="AVISOACCION_'+ (arrProductos[ColumnaOrdenadaProds[i]].linea - 1)+ '"/>';				//	17set16	ID '&nbsp;';
			thisCell += cellEnd;
			thisRow += thisCell;

			thisRow += rowEnd;
			htmlTBODY += thisRow;
    	}
	}

	jQuery('#lProductos_CENTRO tbody').empty().append(htmlTBODY);

}



//	13ene20 Busca el índice de un proveedor por su IDProveedorLic
function IDPosicionProveedor(IDProveedorLic)
{
	var Res=-1;
	for (i=0;((i<arrProveedores.length) && (Res==-1));++i)
		if (arrProveedores[i].IDProvLic==IDProveedorLic) Res=i;
		
	return Res;
}


//	13ene20 Comprueba si un proveedor está bloqueado por pedidos
function ProveedorBloqueado(IDProveedorLic)
{
	return arrProveedores[IDPosicionProveedor(IDProveedorLic)].BloqPedidos;
}



// Este procedimiento dibuja la tabla de productos que permite seleccionar ofertas, sirve también para estados posteriores
function dibujaTablaProductosOFE(){
	var htmlTBODY = '', thisRow = '', thisCell = '' , thisMacro = '', functionJS = '';
	var valAux, valAux2, contLinea = 0;
	anyChange = false;

	//solodebug	MuestraMatrizOfertas();
	//solodebug	debug("dibujaTablaProductosOFE INICIO. totalProductos:"+totalProductos);

	// Eliminamos la fila totalConsumo por si existe
	jQuery('#lProductos_OFE tfoot').remove();

	if(totalProductos > 0){
		// Numero de registros para mostrar en la tabla
		numProductos	= parseInt(jQuery('#numRegistros').val());

		// Redondeamos para saber el numero de paginas totales
		pagsProdTotal = Math.ceil(totalProductos / numProductos);
		// Calculamos el producto inicial y final que se tienen que mostrar en la tabla
		firstProduct	= pagProductos * numProductos;
		lastProduct	= (totalProductos < (pagProductos * numProductos) + numProductos) ? totalProductos : ((pagProductos * numProductos) + numProductos) ;

		// Correccion en la paginacion en caso particular
		if(firstProduct >= lastProduct){
			pagProductos = pagsProdTotal - 1;
			firstProduct	= pagProductos * numProductos;
		}


		arrRadios = new Array();
		for(var i=firstProduct; i<lastProduct; i++){
			var items = [];
			items['checked']	= false;
			items['numOferta']	= null;
			items['OfertaID']	= null;
			contLinea++;

			// Iniciamos la fila (tr)
			thisRow = rowStartIDStyle.replace('#ID#', 'posArr_' + (arrProductos[ColumnaOrdenadaProds[i]].linea - 1));
//			thisRow = rowStartIDStyle.replace('#ID#', arrProductos[ColumnaOrdenadaProds[i]].IDProdLic);
			thisRow = thisRow.replace('#STYLE#', 'border-bottom:1px solid #999;');

			// Celda/Columna numeracion
			thisCell = cellStartClass.replace('#CLASS#', 'datosLeft borderLeft');
			thisCell += '&nbsp;' + contLinea + '&nbsp;';
			if(isLicPorProducto == 'S' && (estadoLicitacion == 'CURS' || estadoLicitacion == 'INF')){
				thisCell += spanStartClassStyle.replace('#CLASS#', 'imgAviso');
				if(arrProductos[ColumnaOrdenadaProds[i]].TieneSeleccion == 'S'){
					thisCell = thisCell.replace('#STYLE#', 'display:none;');
				}else{
					thisCell = thisCell.replace('#STYLE#', '');
				}
				thisMacro = macroImagen.replace('#SRC#', 'http://www.newco.dev.br/images/atencion.gif');
				thisMacro = thisMacro.replace('#TITLE#', str_ProductoSinSeleccion);
				thisMacro = thisMacro.replace('#ALT#', str_ProductoSinSeleccion);
				thisCell += thisMacro + '&nbsp;';
				thisCell += spanEnd;
			}
			thisCell += cellEnd;
			thisRow += thisCell;

			// Celda/Columna Ref.Cliente
			thisCell = cellStartClass.replace('#CLASS#', 'borderLeft');
			if(isAutor == 'S'){
				functionJS	= 'javascript:modificaProducto(\'' + arrProductos[ColumnaOrdenadaProds[i]].IDProdLic + '\', \'' + arrProductos[ColumnaOrdenadaProds[i]].IDProd + '\', \'' + arrProductos[ColumnaOrdenadaProds[i]].RefEstandar + '\', \'' + arrProductos[ColumnaOrdenadaProds[i]].Nombre + '\', \'' + arrProductos[ColumnaOrdenadaProds[i]].UdBasica + '\', \'' + arrProductos[ColumnaOrdenadaProds[i]].Cantidad + '\', \'' + arrProductos[ColumnaOrdenadaProds[i]].PrecioHist + '\', \'' + arrProductos[ColumnaOrdenadaProds[i]].PrecioObj + '\', \'' + arrProductos[ColumnaOrdenadaProds[i]].TipoIVA + '\', \'B\')';
				thisMacro	= '&nbsp;' + macroEnlaceAcc.replace('#CLASS#', 'accBorrar');
				thisMacro	= thisMacro.replace('#HREF#', functionJS);
				thisCell	+= thisMacro;
				thisCell	+= '<img src="http://www.newco.dev.br/images/2017/trash.png" alt="' + str_borrar + '" title="' + str_borrar + '"/>'
				thisCell	+= macroEnlaceEnd;
			}

			thisCell += '&nbsp;' + macroEnlaceRef.replace('#LIC_PROD_ID#', arrProductos[ColumnaOrdenadaProds[i]].IDProdLic);
			if(arrProductos[ColumnaOrdenadaProds[i]].RefCentro != '')
			{
				thisCell += arrProductos[ColumnaOrdenadaProds[i]].RefCentro;	// Mostramos Ref.Centro si existe
			}
			else if(arrProductos[ColumnaOrdenadaProds[i]].RefCliente != '')
			{
				thisCell += arrProductos[ColumnaOrdenadaProds[i]].RefCliente;	// Mostramos Ref.Cliente si existe
			}
			else
			{
				thisCell += arrProductos[ColumnaOrdenadaProds[i]].RefEstandar;	// Mostramos Ref.Estandar si no existe Ref.Cliente
			}
			thisCell += macroEnlaceEnd + cellEnd;
			thisRow += thisCell;

			// Celda/Columna Nombre
			thisCell = cellStartClassStyle.replace('#CLASS#','datosLeft borderLeft');
			thisCell = thisCell.replace('#STYLE#','padding:2px 2px 2px 3px;');
			if(isAutor == 'S'){
				functionJS = 'javascript:abrirCamposAvanzadosProd(' + (arrProductos[ColumnaOrdenadaProds[i]].linea - 1) + ');'
				thisCell += '<span style="display:table-cell;vertical-align:middle;">';
				thisCell += macroEnlace.replace('#HREF#', functionJS);
				thisCell += macroImagen.replace('#SRC#', 'http://www.newco.dev.br/images/anadir.gif').replace('#TITLE#', str_AnyadirInfoAmpliada).replace('#ALT#', str_AnyadirInfoAmpliada);
				thisCell += macroEnlaceEnd + '&nbsp;';
				thisCell += '</span>';
			}
			thisCell += '<span style="padding:2px;display:table-cell;"><strong>' + NombreProductoConEstilo(i) + '</strong>&nbsp;</span>';
			thisCell += cellEnd;
			thisRow += thisCell;

			// Celda/Columna iconos campos avanzados
			thisCell = cellStart;
			// Info.Ampliada
			if(arrProductos[ColumnaOrdenadaProds[i]].InfoAmpliada != ''){
				//ET 14dic16	Cambio de estilos para los tooltips
				//ET 14dic16	thisMacro = macroEnlaceAcc.replace('#HREF#', '#');
				thisMacro = divStartClass;
				thisMacro = thisMacro.replace('#CLASS#', 'tooltip');
				thisCell += thisMacro;
				thisCell += '<img src="http://www.newco.dev.br/images/infoAmpliadaIconO.gif" class="static"/>';
				//ET 14dic16	thisCell += spanStartClass.replace('#CLASS#', 'classic spanEIS');
				thisCell += spanStartClass.replace('#CLASS#', 'tooltiptext');
				thisCell += str_InfoAmpliada + ':<br/><br/>';
				thisCell += arrProductos[ColumnaOrdenadaProds[i]].InfoAmpliada;
				thisCell += spanEnd;
				thisCell += macroEnlaceEnd + '&nbsp;';
			}
			// Documento
			if(typeof arrProductos[ColumnaOrdenadaProds[i]].Documento.ID !== 'undefined'){
				thisMacro = macroEnlaceTarget.replace('#HREF#', 'http://www.newco.dev.br/Documentos/' + arrProductos[ColumnaOrdenadaProds[i]].Documento.Url);
				thisCell += thisMacro;
				thisMacro = macroImagen3.replace('#SRC#', 'http://www.newco.dev.br/images/clipIconO.gif');
				thisMacro = thisMacro.replace('#CLASS#', 'static');
				thisMacro = thisMacro.replace('#ALT#', str_Documento);
				thisMacro = thisMacro.replace('#TITLE#', str_Documento);
				thisCell += thisMacro;
//				thisCell += '<img src="" class="static"/>';
				thisCell += macroEnlaceEnd + '&nbsp;';
			}
			// Anotaciones
			if(arrProductos[ColumnaOrdenadaProds[i]].Anotaciones != ''){
				//ET 14dic16	Cambio de estilos para los tooltips
				//ET 14dic16	thisMacro = macroEnlaceAcc.replace('#HREF#', '#');
				thisMacro = divStartClass;
				thisMacro = thisMacro.replace('#CLASS#', 'tooltip');
				thisCell += thisMacro;
				thisCell += '<img src="http://www.newco.dev.br/images/infoAmpliadaIconNaraO.gif " class="static"/>';
				//ET 14dic16	thisCell += spanStartClass.replace('#CLASS#', 'classic spanEIS');
				thisCell += spanStartClass.replace('#CLASS#', 'tooltiptext');
				thisCell += str_Anotaciones + ':<br/><br/>';
				thisCell += arrProductos[ColumnaOrdenadaProds[i]].Anotaciones;
				thisCell += spanEnd;
				thisCell += macroEnlaceEnd;
			}
			thisCell += cellEnd;
			thisRow += thisCell;

			// Celda/Columna NumOfertas
			thisCell = cellStartClass;
			if(arrProductos[ColumnaOrdenadaProds[i]].NumOfertas == 0){
				thisCell = thisCell.replace('#CLASS#', 'borderLeft fondoRojo');
			}else{
				thisCell = thisCell.replace('#CLASS#', 'borderLeft');
			}
			thisCell += arrProductos[ColumnaOrdenadaProds[i]].NumOfertas;
			thisCell += cellEnd;
			thisRow += thisCell;

			// Celda/Columna UdBasica
			thisCell = cellStartClass.replace('#CLASS#', 'ocho borderLeft');
			if(isAutor == 'S' && estadoLicitacion != 'CONT'){
				thisMacro	= macroInputText.replace('#NAME#', 'UDBASICA_' + (arrProductos[ColumnaOrdenadaProds[i]].linea - 1));
				thisMacro	= thisMacro.replace('#ID#', 'UDBASICA_' + (arrProductos[ColumnaOrdenadaProds[i]].linea - 1));
				thisMacro	= thisMacro.replace('#VALUE#', arrProductos[ColumnaOrdenadaProds[i]].UdBasica);
				thisMacro	= thisMacro.replace('#CLASS#', 'udbasica medio');
				thisMacro	= thisMacro.replace('#SIZE#', '15');
				thisMacro	= thisMacro.replace('#MAXLENGTH#', '100');
				thisCell	+= thisMacro;
			}else{
				thisCell += arrProductos[ColumnaOrdenadaProds[i]].UdBasica;
			}
			thisCell += cellEnd;
			thisRow += thisCell;

			// Celda/Columna Precio Historico
			thisCell = cellStartClass.replace('#CLASS#', 'cuatro borderLeft precioRef textRight');
			if(mostrarPrecioIVA == 'S'){
				if(isAutor == 'S' && estadoLicitacion != 'CONT'){
					thisMacro	=	macroInputText.replace('#NAME#', 'PRECIOREFIVA_' + (arrProductos[ColumnaOrdenadaProds[i]].linea - 1));
					thisMacro	=	thisMacro.replace('#ID#', 'PRECIOREFIVA_' + (arrProductos[ColumnaOrdenadaProds[i]].linea - 1));
					thisMacro	=	thisMacro.replace('#VALUE#', arrProductos[ColumnaOrdenadaProds[i]].PrecioHistIVA);
					thisMacro	=	thisMacro.replace('#CLASS#', 'preciorefiva medio');
					thisMacro	=	thisMacro.replace('#SIZE#', '8');
					thisMacro	=	thisMacro.replace('#MAXLENGTH#', '10');
					thisCell	+=	thisMacro;

					thisMacro	=	macroInputHidden.replace('#NAME#', 'PRECIOREF_' + (arrProductos[ColumnaOrdenadaProds[i]].linea - 1));
					thisMacro	=	thisMacro.replace('#ID#', 'PRECIOREF_' + (arrProductos[ColumnaOrdenadaProds[i]].linea - 1));
					thisMacro	=	thisMacro.replace('#VALUE#', arrProductos[ColumnaOrdenadaProds[i]].PrecioHist);
					thisMacro	=	thisMacro.replace('#CLASS#', 'precioref medio');
					thisCell	+=	thisMacro;
				}else{
					thisCell += arrProductos[ColumnaOrdenadaProds[i]].PrecioHistIVA;
				}
                        }else{
				if(isAutor == 'S' && estadoLicitacion != 'CONT'){
					thisMacro	=	macroInputText.replace('#NAME#', 'PRECIOREF_' + (arrProductos[ColumnaOrdenadaProds[i]].linea - 1));
					thisMacro	=	thisMacro.replace('#ID#', 'PRECIOREF_' + (arrProductos[ColumnaOrdenadaProds[i]].linea - 1));
					thisMacro	=	thisMacro.replace('#VALUE#', arrProductos[ColumnaOrdenadaProds[i]].PrecioHist);
					thisMacro	=	thisMacro.replace('#CLASS#', 'precioref medio');
					thisMacro	=	thisMacro.replace('#SIZE#', '8');
					thisMacro	=	thisMacro.replace('#MAXLENGTH#', '10');
					thisCell	+=	thisMacro;
				}else{
					thisCell += arrProductos[ColumnaOrdenadaProds[i]].PrecioHist;
				}
			}
			thisCell += cellEnd;
			thisRow += thisCell;

			// Celda/Columna Precio Objetivo
			thisCell = cellStartClass.replace('#CLASS#', 'cuatro borderLeft textRight');
			if(mostrarPrecioIVA == 'S'){
				if(isAutor == 'S' && estadoLicitacion != 'CONT'){
					thisMacro	=	macroInputText.replace('#NAME#', 'PRECIO_OBJIVA_' + (arrProductos[ColumnaOrdenadaProds[i]].linea - 1));
					thisMacro	=	thisMacro.replace('#ID#', 'PRECIO_OBJIVA_' + (arrProductos[ColumnaOrdenadaProds[i]].linea - 1));
					thisMacro	=	thisMacro.replace('#VALUE#', arrProductos[ColumnaOrdenadaProds[i]].PrecioObjIVA);
					thisMacro	=	thisMacro.replace('#CLASS#', 'precioobjiva medio');
					thisMacro	=	thisMacro.replace('#SIZE#', '8');
					thisMacro	=	thisMacro.replace('#MAXLENGTH#', '10');
					thisCell	+=	thisMacro;

					thisMacro	=	macroInputHidden.replace('#NAME#', 'PRECIO_OBJ_' + (arrProductos[ColumnaOrdenadaProds[i]].linea - 1));
					thisMacro	=	thisMacro.replace('#ID#', 'PRECIO_OBJ_' + (arrProductos[ColumnaOrdenadaProds[i]].linea - 1));
					thisMacro	=	thisMacro.replace('#VALUE#', arrProductos[ColumnaOrdenadaProds[i]].PrecioObj);
					thisMacro	=	thisMacro.replace('#CLASS#', 'precioobj medio');
					thisCell	+=	thisMacro;
				}else{
					thisCell += arrProductos[ColumnaOrdenadaProds[i]].PrecioObjIVA;
				}
                        }else{
				if(isAutor == 'S' && estadoLicitacion != 'CONT'){
					thisMacro	=	macroInputText.replace('#NAME#', 'PRECIO_OBJ_' + (arrProductos[ColumnaOrdenadaProds[i]].linea - 1));
					thisMacro	=	thisMacro.replace('#ID#', 'PRECIO_OBJ_' + (arrProductos[ColumnaOrdenadaProds[i]].linea - 1));
					thisMacro	=	thisMacro.replace('#VALUE#', arrProductos[ColumnaOrdenadaProds[i]].PrecioObj);
					thisMacro	=	thisMacro.replace('#CLASS#', 'precioobj medio');
					thisMacro	=	thisMacro.replace('#SIZE#', '8');
					thisMacro	=	thisMacro.replace('#MAXLENGTH#', '10');
					thisCell	+=	thisMacro;
				}else{
					thisCell += arrProductos[ColumnaOrdenadaProds[i]].PrecioObj;
				}
			}
			thisCell += cellEnd;
			thisRow += thisCell;

			// Celda/Columna Ahorro
			thisCell = cellStartClass.replace('#CLASS#', 'borderLeft datosRight');
			if(arrProductos[ColumnaOrdenadaProds[i]].SinAhorro == 'S'){
				thisMacro = macroImagen.replace('#SRC#', 'http://www.newco.dev.br/images/change.png');
				thisMacro = thisMacro.replace('#TITLE#', str_ProductoSinAhorro);
				thisMacro = thisMacro.replace('#ALT#', str_ProductoSinAhorro);
				thisCell += thisMacro + '&nbsp;';
			}

			// Marcamos los ahorros como sospechosos o muy sospechosos
			if(arrProductos[ColumnaOrdenadaProds[i]].Sospechoso == '2'){
				thisCell += spanStartClassTitle.replace('#CLASS#', 'rojo2').replace('#TITLE#', '');
				thisCell += '?&nbsp;';
				thisCell += spanEnd;
			}else if(arrProductos[ColumnaOrdenadaProds[i]].Sospechoso == '1'){
				thisCell += spanStartClassTitle.replace('#CLASS#', 'orange').replace('#TITLE#', '');
				thisCell += '?&nbsp;';
				thisCell += spanEnd;
			}

			if(arrProductos[ColumnaOrdenadaProds[i]].AhorroMax != ''){
				thisCell += arrProductos[ColumnaOrdenadaProds[i]].AhorroMax + '%&nbsp;';
			}
			thisCell += cellEnd;
			thisRow += thisCell;

			// Celda/Columna Cantidad
			thisCell = cellStartClass.replace('#CLASS#', 'cuatro borderLeft cantidad textRight');
			if(isAutor == 'S' && estadoLicitacion != 'CONT' && isLicAgregada=='N'){		//1set16 No permitimos modificar en caso de licitacion agregada
				thisMacro	= macroInputText.replace('#NAME#', 'CANTIDAD_' + (arrProductos[ColumnaOrdenadaProds[i]].linea - 1));
				thisMacro	= thisMacro.replace('#ID#', 'CANTIDAD_' + (arrProductos[ColumnaOrdenadaProds[i]].linea - 1));
				thisMacro	= thisMacro.replace('#VALUE#', arrProductos[ColumnaOrdenadaProds[i]].Cantidad);
				thisMacro	= thisMacro.replace('#CLASS#', 'cantidad peq');
				thisMacro	= thisMacro.replace('#SIZE#', '6');
				thisMacro	= thisMacro.replace('#MAXLENGTH#', '8');
				thisCell	+= thisMacro;
			}else{
				thisCell += arrProductos[ColumnaOrdenadaProds[i]].Cantidad;
			}
			thisCell += cellEnd;
			thisRow += thisCell;

			// Celda/Columna Consumo
			thisCell = cellStartClass.replace('#CLASS#', 'cuatro borderLeft textRight');
			if(mostrarPrecioIVA == 'S'){
				thisCell += arrProductos[ColumnaOrdenadaProds[i]].ConsumoHistIVA;
			}else{
				thisCell += arrProductos[ColumnaOrdenadaProds[i]].ConsumoHist;
			}
			thisCell += cellEnd;
			thisRow += thisCell;

			// Celda/Columna TipoIVA
			thisCell = cellStartClass;
			if(IDPais != 55){
				thisCell = thisCell.replace('#CLASS#', 'dos borderLeft textRight');
				thisCell += arrProductos[ColumnaOrdenadaProds[i]].TipoIVA + '%';
			}else{
				thisCell = thisCell.replace('#CLASS#', 'zerouno borderLeft');
				thisCell += '&nbsp;';
			}
			thisCell += cellEnd;
			thisRow += thisCell;

			// DATOS DE LAS OFERTAS
			// Recorremos todos los proveedores
			// 9set16 quitamos los proveedores que no han ofertado

			//solodebug	if (i==0) alert(i+'/'+arrProductos[ColumnaOrdenadaProds[i]].Ofertas.length+' '+arrProductos[ColumnaOrdenadaProds[i]].IDProdLic);

			for(var j=0; j<arrProductos[ColumnaOrdenadaProds[i]].Ofertas.length; j++){
			
			
				//solodebug	if (j==0) alert(j+' '+arrProductos[ColumnaOrdenadaProds[i]].IDProdLic+'	'+arrProductos[ColumnaOrdenadaProds[i]].Ofertas[j].IDProvLic
				//solodebug					+' '+arrProductos[ColumnaOrdenadaProds[i]].Ofertas[j].IDOferta+' of:'+arrConsumoProvs[j].TieneOfertas);
				
				//solodebug
				//	var cont=0;
				//	if ((arrProductos[ColumnaOrdenadaProds[i]].Ofertas[j].IDProvLic==5085)&&(cont<10)){
				//		++cont;
				//		alert(' fila:'+i+' columna:'+j);
				//		alert('LicProvID:'+arrProductos[ColumnaOrdenadaProds[i]].Ofertas[j].IDProvLic+' fila:'+i+' columna:'+j+' Precio oferta:'+arrProductos[ColumnaOrdenadaProds[i]].Ofertas[j].Precio);
				//	}
			
				if (arrConsumoProvs[j].TieneOfertas=='S'){	//	COmprueba proveedor con ofertas /Mantenimiento/LICITACION/PRODUCTOSLICITACION/PROVEEDORESLICITACION/PROVEEDOR/TIENE_OFERTAS

					//solodebug	
					//alert(arrConsumoProvs[j].NombreCorto+' tiene ofertas:'+arrConsumoProvs[j].TieneOfertas
					//	+ ' NoInformada:'+arrProductos[ColumnaOrdenadaProds[i]].Ofertas[j].NoInformada
					//	+ ' NoOfertada:'+arrProductos[ColumnaOrdenadaProds[i]].Ofertas[j].NoOfertada
					//	);

					if(arrProductos[ColumnaOrdenadaProds[i]].Ofertas[j].NoInformada == 'S')
					{
					// Si la oferta del proveedor para este producto no esta informada
						thisCell = cellStartColspanCls.replace('#COLSPAN#', '4');
						thisCell = thisCell.replace('#CLASS#', 'colSinOferta center borderLeft');
						//20may19	thisCell += str_SinOferta;	
						thisCell += cellEnd;
						thisRow += thisCell;
					}
					else if(arrProductos[ColumnaOrdenadaProds[i]].Ofertas[j].NoOfertada == 'S')
					{
					// Si el proveedor ha informado de algunas ofertas, pero esta esta vacia
						thisCell = cellStartColspanCls.replace('#COLSPAN#', '4');
						thisCell = thisCell.replace('#CLASS#', 'colSinOferta center borderLeft');
						//20may19	thisCell += str_OfertaNoOfertada;
						thisCell += cellEnd;
						thisRow += thisCell;
					}
					else
					{	// Si esta oferta esta informada

						// Celda para licitaciones por producto (radio button o imagen checked)
							
						var fondo='';
						if(arrProductos[ColumnaOrdenadaProds[i]].Ofertas[j].OfertaAdjud == 'S') fondo='fondoAmarillo';
							
						thisCell = cellStartClassStyle.replace('#CLASS#', 'borderLeft '+fondo);
						thisCell = thisCell.replace('#STYLE#', 'padding:0 1px;');
						if (isLicMultiopcion=='N')
						{
							if((estadoLicitacion=='CURS' || estadoLicitacion=='INF') && (isLicPorProducto=='S') && (isAutor=='S')
									&&(ProveedorBloqueado(arrProductos[ColumnaOrdenadaProds[i]].Ofertas[j].IDProvLic)=='N')		//	13ene20 Proveedor bloqueado por pedidos
									&&(arrProductos[ColumnaOrdenadaProds[i]].BloqPedidos=='N'))									//	13ene20 Producto bloqueado por pedidos
							{
								thisMacro = macroInputRadio.replace('#NAME#', 'RADIO_' + (arrProductos[ColumnaOrdenadaProds[i]].linea - 1));
								thisMacro = thisMacro.replace('#CLASS#', 'RADIO_' + (arrProductos[ColumnaOrdenadaProds[i]].linea - 1+' muypeq'));
								thisMacro = thisMacro.replace('#VALUE#', arrProductos[ColumnaOrdenadaProds[i]].Ofertas[j].ID);	//21set16	.IDOferta
								if(arrProductos[ColumnaOrdenadaProds[i]].Ofertas[j].OfertaAdjud == 'S')
								{
									items['checked']	= true;
									items['numOferta']	= (arrProductos[ColumnaOrdenadaProds[i]].Ofertas[j].columna);	//13abr17	(arrProductos[ColumnaOrdenadaProds[i]].Ofertas[j].columna - 1);
									items['OfertaID']	= (arrProductos[ColumnaOrdenadaProds[i]].Ofertas[j].ID);

									//solodebug 8may17	debug('dibujaTablaProductosOFE. ID:'+items['OfertaID']+' fila:'+ColumnaOrdenadaProds[i]+'col:'+j+' ->OfertaAdjud');

									thisMacro = thisMacro.replace('#CHECKED#', 'checked="checked"');

									//	Nuevo caso: repartido entre varios proveedores, mostramos la cantidad y ocultamos el control
									if ((arrProductos[ColumnaOrdenadaProds[i]].VariosProv=='S')&&(parseFloat(arrProductos[ColumnaOrdenadaProds[i]].Ofertas[j].CantAdjud.replace(',','.'))>0))
									{
										//	en lugar del radio, presenta la cantidad
										thisMacro = '<B>'+arrProductos[ColumnaOrdenadaProds[i]].Ofertas[j].CantAdjud+'x</B>'+thisMacro.replace('>', ' style="display:none;">');
									}
								}
								else
								{
									thisMacro = thisMacro.replace('#CHECKED#', '');

									//	Nuevo caso: repartido entre varios proveedores, mostramos la cantidad y ocultamos el control
									if (arrProductos[ColumnaOrdenadaProds[i]].VariosProv=='S')
									{
										thisMacro = thisMacro.replace('>', ' style="display:none;">');
									}
								}
								thisCell += thisMacro;


								//solodebug	13abr17	debug('Prov:' + arrProductos[ColumnaOrdenadaProds[i]].Ofertas[j].ID+' columna:'+(arrProductos[ColumnaOrdenadaProds[i]].Ofertas[j].columna));

								thisMacro = macroInputHidden.replace('#NAME#', 'Prov_' + arrProductos[ColumnaOrdenadaProds[i]].Ofertas[j].ID);	//21set16	.IDOferta
								thisMacro = thisMacro.replace('#ID#', 'Prov_' + arrProductos[ColumnaOrdenadaProds[i]].Ofertas[j].ID);	//21set16	.IDOferta
								thisMacro = thisMacro.replace('#VALUE#', (arrProductos[ColumnaOrdenadaProds[i]].Ofertas[j].columna));	//13abr17	arrProductos[ColumnaOrdenadaProds[i]].Ofertas[j].columna - 1
								thisMacro = thisMacro.replace('#CLASS#', 'LicProv');
								thisCell += thisMacro;
							}
							else if(isLicPorProducto=='S')
							{
								if(arrProductos[ColumnaOrdenadaProds[i]].Ofertas[j].OfertaAdjud == 'S'){
									thisMacro = macroImagen.replace('#SRC#', 'http://www.newco.dev.br/images/check.gif');
									thisMacro = thisMacro.replace('#TITLE#', str_OfertaAdjudicada);
									thisMacro = thisMacro.replace('#ALT#', str_OfertaAdjudicada);
									thisCell += thisMacro;
									//	14ene20 Para el cálculo del floating box hay que guardar el valor en un checkbox oculto
									thisMacro = macroInputRadio.replace('#NAME#', 'RADIO_' + (arrProductos[ColumnaOrdenadaProds[i]].linea - 1));
									thisMacro = thisMacro.replace('#CLASS#', 'RADIO_' + (arrProductos[ColumnaOrdenadaProds[i]].linea - 1+' muypeq'));
									thisMacro = thisMacro.replace('#VALUE#', arrProductos[ColumnaOrdenadaProds[i]].Ofertas[j].ID);	//21set16	.IDOferta
									thisMacro = thisMacro.replace('#CHECKED#', 'checked="checked"');
									thisMacro = thisMacro.replace('>', ' style="display:none;">');
									thisCell += thisMacro;
								}else{
									//	14ene20 thisCell += '';
									//	14ene20 Para el cálculo del floating box hay que guardar el valor en un checkbox oculto
									thisMacro = macroInputRadio.replace('#NAME#', 'RADIO_' + (arrProductos[ColumnaOrdenadaProds[i]].linea - 1));
									thisMacro = thisMacro.replace('#CLASS#', 'RADIO_' + (arrProductos[ColumnaOrdenadaProds[i]].linea - 1+' muypeq'));
									thisMacro = thisMacro.replace('#VALUE#', arrProductos[ColumnaOrdenadaProds[i]].Ofertas[j].ID);	//21set16	.IDOferta
									thisMacro = thisMacro.replace('#CHECKED#', '');
									thisMacro = thisMacro.replace('>', ' style="display:none;">');
									thisCell += thisMacro;
								}
							}else{
								thisCell += '';
							}
						}
						else
						{
							//	9jul18 Licitación multiopcion
							if (arrProductos[ColumnaOrdenadaProds[i]].Ofertas[j].Orden=='-1')
							{
								// No Adjudicado, mostramos "NO"
								thisCell += '<strong>NO</strong>&nbsp;';
							}
							else
							{	
								//	Adjudicado: mostramos número de orden, con formato de alta visibilidad para la opción 1
								thisCell += '<strong>'+arrProductos[ColumnaOrdenadaProds[i]].Ofertas[j].Orden+'</strong>&nbsp;';
							}
						}
						thisCell += cellEnd;
						thisRow += thisCell;

						// Celda para precio oferta
						thisCell = cellStartIDClassSty.replace('#ID#', 'arrProd-' + (arrProductos[ColumnaOrdenadaProds[i]].linea - 1) + '_arrProvOfr-' + (arrProductos[ColumnaOrdenadaProds[i]].Ofertas[j].columna - 1));
						thisCell = thisCell.replace('#CLASS#', 'PrecioOferta_' + (arrProductos[ColumnaOrdenadaProds[i]].linea - 1) + ' datosRight colPrecio '+fondo);
						thisCell = thisCell.replace('#STYLE#', 'display:none;');
						if(mostrarPrecioIVA == 'S'){
							valAux	= parseFloat(arrProductos[ColumnaOrdenadaProds[i]].Ofertas[j].PrecioIVA.replace(',', '.'));
							valAux2	= parseFloat(arrProductos[ColumnaOrdenadaProds[i]].PrecioHistIVA.replace(',', '.'));
	/*
							// Marca oferta 80% inferior a precio historico
							if(valAux !== 0 && (valAux2 * 0.2 > valAux)){
								thisCell += spanStartClassTitle.replace('#CLASS#', 'rojo2').replace('#TITLE#', str_PrecioOfertaSospechoso);
								thisCell += '?&nbsp;';
								thisCell += spanEnd;
							}
	*/
							// Marcamos las ofertas como sospechosas o muy sospechosas
							if(arrProductos[ColumnaOrdenadaProds[i]].Ofertas[j].Sospechoso == '2'){
								thisCell += spanStartClassTitle.replace('#CLASS#', 'rojo2').replace('#TITLE#', str_PrecioOfertaMuySospechoso);
								thisCell += '?&nbsp;';
								thisCell += spanEnd;
							}else if(arrProductos[ColumnaOrdenadaProds[i]].Ofertas[j].Sospechoso == '1'){
								thisCell += spanStartClassTitle.replace('#CLASS#', 'orange').replace('#TITLE#', str_PrecioOfertaSospechoso);
								thisCell += '?&nbsp;';
								thisCell += spanEnd;
							}

							// Precio con IVA
							thisCell += macroEnlaceRef2.replace('#LIC_PROD_ID#', arrProductos[ColumnaOrdenadaProds[i]].IDProdLic);
							if(arrProductos[ColumnaOrdenadaProds[i]].Ofertas[j].PrecioColor == 'Naranja'){
								thisCell += spanStartClass.replace('#CLASS#', 'oferta naranja');
							}else if(arrProductos[ColumnaOrdenadaProds[i]].Ofertas[j].PrecioColor == 'Rojo'){
								thisCell += spanStartClass.replace('#CLASS#', 'oferta rojo');
							}else{
								thisCell += spanStartClass.replace('#CLASS#', 'oferta verde');
							}
							thisCell += arrProductos[ColumnaOrdenadaProds[i]].Ofertas[j].PrecioIVA;
							thisCell += spanEnd + macroEnlaceEnd + '&nbsp;';
						}else{
							valAux	= parseFloat(arrProductos[ColumnaOrdenadaProds[i]].Ofertas[j].Precio.replace(',', '.'));
							valAux2	= parseFloat(arrProductos[ColumnaOrdenadaProds[i]].PrecioHist.replace(',', '.'));
	/*
							// Marca oferta 80% inferior a precio historico
							if(valAux !== 0 && (valAux2 * 0.2 > valAux)){
								thisCell += spanStartClassTitle.replace('#CLASS#', 'rojo2').replace('#TITLE#', str_PrecioOfertaSospechoso);
								thisCell += '?&nbsp;';
								thisCell += spanEnd;
							}
	*/
							// Marcamos las ofertas como sospechosas o muy sospechosas
							if(arrProductos[ColumnaOrdenadaProds[i]].Ofertas[j].Sospechoso == '2'){
								thisCell += spanStartClassTitle.replace('#CLASS#', 'rojo2').replace('#TITLE#', str_PrecioOfertaMuySospechoso);
								thisCell += '?&nbsp;';
								thisCell += spanEnd;
							}else if(arrProductos[ColumnaOrdenadaProds[i]].Ofertas[j].Sospechoso == '1'){
								thisCell += spanStartClassTitle.replace('#CLASS#', 'orange').replace('#TITLE#', str_PrecioOfertaSospechoso);
								thisCell += '?&nbsp;';
								thisCell += spanEnd;
							}

							// Precio sin IVA
							thisCell += macroEnlaceRef2.replace('#LIC_PROD_ID#', arrProductos[ColumnaOrdenadaProds[i]].IDProdLic);
							if(arrProductos[ColumnaOrdenadaProds[i]].Ofertas[j].PrecioColor == 'Naranja'){
								thisCell += spanStartClass.replace('#CLASS#', 'oferta naranja');
							}else if(arrProductos[ColumnaOrdenadaProds[i]].Ofertas[j].PrecioColor == 'Rojo'){
								thisCell += spanStartClass.replace('#CLASS#', 'oferta rojo');
							}else if(arrProductos[ColumnaOrdenadaProds[i]].Ofertas[j].PrecioColor == 'Verde'){		//	16ene17
								thisCell += spanStartClass.replace('#CLASS#', 'oferta verde');
							}else{
								thisCell += spanStartClass.replace('#CLASS#', 'oferta');
							}
							thisCell += arrProductos[ColumnaOrdenadaProds[i]].Ofertas[j].Precio;
							thisCell += spanEnd + macroEnlaceEnd + '&nbsp;';
						}
						thisCell += cellEnd;
						thisRow += thisCell;

						// Celda para consumo
						thisCell = cellStartClassStyle.replace('#CLASS#', 'borderLeft datosRight colConsumo');
						thisCell = thisCell.replace('#STYLE#', 'display:none;');
						if(mostrarPrecioIVA == 'S'){
							thisCell += arrProductos[ColumnaOrdenadaProds[i]].Ofertas[j].ConsumoIVA + '&nbsp;';
						}else{
							thisCell += arrProductos[ColumnaOrdenadaProds[i]].Ofertas[j].Consumo + '&nbsp;';
						}
						thisCell += cellEnd;
						thisRow += thisCell;

						// Celda para ahorro
						thisCell = cellStartClassStyle.replace('#CLASS#', 'borderLeft datosRight colAhorro');
						thisCell = thisCell.replace('#STYLE#', 'display:none;');
						if (arrProductos[ColumnaOrdenadaProds[i]].Ofertas[j].Ahorro!=''){		//	31ago16	solo mostramos el ahorro si está informado
							thisCell += arrProductos[ColumnaOrdenadaProds[i]].Ofertas[j].Ahorro + '%&nbsp;';
						}
						thisCell += cellEnd;
						thisRow += thisCell;

						// Celda para imagen evaluacion oferta
						thisCell = cellStartClassStyle.replace('#CLASS#', 'borderLeft colEval');
						thisCell = thisCell.replace('#STYLE#', 'display:none;');
						if(arrProductos[ColumnaOrdenadaProds[i]].Ofertas[j].IDEstadoEval == 'NOAPTO'){
							thisMacro = macroImagen.replace('#SRC#', 'http://www.newco.dev.br/images/bolaRoja.gif');
							thisMacro = thisMacro.replace('#TITLE#', str_ofertaNoApto);
							thisMacro = thisMacro.replace('#ALT#', str_ofertaNoApto);
						}else if(arrProductos[ColumnaOrdenadaProds[i]].Ofertas[j].IDEstadoEval == 'PEND'){
							thisMacro = macroImagen.replace('#SRC#', 'http://www.newco.dev.br/images/bolaAmbar.gif');
							thisMacro = thisMacro.replace('#TITLE#', str_ofertaPendiente);
							thisMacro = thisMacro.replace('#ALT#', str_ofertaPendiente);
						}else{
							thisMacro = macroImagen.replace('#SRC#', 'http://www.newco.dev.br/images/bolaVerde.gif');
							thisMacro = thisMacro.replace('#TITLE#', str_ofertaApto);
							thisMacro = thisMacro.replace('#ALT#', str_ofertaApto);
						}
						thisCell += thisMacro;
						thisCell += cellEnd;
						thisRow += thisCell;

						// Celda para la ficha tecnica (si hay)
						thisCell = cellStartClassStyle.replace('#CLASS#', 'colInfo');
						thisCell = thisCell.replace('#STYLE#', 'display:none;');
						if(arrProductos[ColumnaOrdenadaProds[i]].Ofertas[j].FichaTecnica.ID){
							thisCell += macroEnlaceTarget.replace('#HREF#', 'http://www.newco.dev.br/Documentos/' + arrProductos[ColumnaOrdenadaProds[i]].Ofertas[j].FichaTecnica.Url);
							thisMacro = macroImagen.replace('#SRC#', 'http://www.newco.dev.br/images/fichaChange.gif');
							thisMacro = thisMacro.replace('#TITLE#', str_FichaTecnica);
							thisMacro = thisMacro.replace('#ALT#', str_FichaTecnica);
							thisCell += thisMacro;
							thisCell += macroEnlaceEnd + '&nbsp;';
						}
						// Info.Ampliada Oferta (si hay)
						if(arrProductos[ColumnaOrdenadaProds[i]].Ofertas[j].InfoAmpliada != ''){
							//ET 14dic16	Cambio de estilos para los tooltips
							//ET 14dic16	thisMacro = macroEnlaceAcc.replace('#HREF#', '#');
							thisMacro = divStartClass;
							thisMacro = thisMacro.replace('#CLASS#', 'tooltip');
							thisCell += thisMacro;
							thisCell += '<img src="http://www.newco.dev.br/images/infoAmpliadaIconO.gif" class="static"/>';
							//ET 14dic16	thisCell += spanStartClass.replace('#CLASS#', 'classic spanEIS');
							thisCell += spanStartClass.replace('#CLASS#', 'tooltiptext');
							thisCell += str_InfoAmpliada + ':<br/><br/>';
							thisCell += arrProductos[ColumnaOrdenadaProds[i]].Ofertas[j].InfoAmpliada;
							thisCell += spanEnd;
							thisCell += macroEnlaceEnd + '&nbsp;';
						}
						// Documento Oferta (si hay)
						if(typeof arrProductos[ColumnaOrdenadaProds[i]].Ofertas[j].Documento.ID !== 'undefined'){
							thisMacro = macroEnlaceTarget.replace('#HREF#', 'http://www.newco.dev.br/Documentos/' + arrProductos[ColumnaOrdenadaProds[i]].Ofertas[j].Documento.Url);
							thisCell += thisMacro;
							thisMacro = macroImagen3.replace('#SRC#', 'http://www.newco.dev.br/images/clipIconO.gif');
							thisMacro = thisMacro.replace('#CLASS#', 'static');
							thisMacro = thisMacro.replace('#ALT#', str_Documento);
							thisMacro = thisMacro.replace('#TITLE#', str_Documento);
							thisCell += thisMacro;
							thisCell += macroEnlaceEnd + '&nbsp;';
						}
						thisCell += cellEnd;
						thisRow += thisCell;
					}	//fin comprueba oferta informada	
				}	//fin comprueba proveedor con ofertas	
			}	//	fin bucle proveedores

			thisRow += rowEnd;
			htmlTBODY += thisRow;

			// Hacemos push de datos al array arrRadios
			arrRadios.push(items);
		}// fib bucle productos

		dibujarFilaConsumoProdOFE();
		calcularPaginacion();

    }

	jQuery('#lProductos_OFE tbody').empty().append(htmlTBODY);
	muestraNuevaVistaProductos(jQuery("select#tipoVista").val());
	MarcarMejoresPrecios();

	//	21set16
	validarBotonAdjudicar();


	//solodebug 31mar17 ET problemas floatingbox	debug('dibujaTablaProductosOFE. isLicPorProducto:'+isLicPorProducto+' estadoLicitacion:'+estadoLicitacion);


	// Permitir desseleccionar radio buttons
	if(isLicPorProducto == 'S' && (estadoLicitacion == 'CURS' ||estadoLicitacion == 'INF')){
		//
		jQuery('input[type=radio]').uncheckableRadio();

		//29may19	// Ahora recalculamos los valores del floatinBox
		//29may19	if(jQuery(".FBox").length)
		//29may19		calcularFloatingBox();
		// Ahora mostramos el floatinBox
		if(jQuery(".FBox").length)
			mostrarFloatingBox();
	}

	//solodebug	debug("dibujaTablaProductosOFE FINAL. totalProductos:"+totalProductos);

}

function dibujaTablaProductosEST(){
	var htmlTBODY = '', thisRow = '', thisCell = '' , thisMacro = '', functionJS = '', contLinea = 0;

	// Eliminamos la fila totalConsumo por si existe
	jQuery('#lProductos_EST tfoot').remove();

	if(totalProductos > 0){
		// Numero de registros para mostrar en la tabla
		numProductos	= parseInt(jQuery('#numRegistros').val());
		// Redondeamos para saber el numero de paginas totales
		pagsProdTotal = Math.ceil(totalProductos / numProductos);
		// Calculamos el producto inicial y final que se tienen que mostrar en la tabla
		firstProduct	= pagProductos * numProductos;
		lastProduct	= (totalProductos < (pagProductos * numProductos) + numProductos) ? totalProductos : ((pagProductos * numProductos) + numProductos) ;

		// Correccion en la paginacion en caso particular
		if(firstProduct >= lastProduct){
			pagProductos = pagsProdTotal - 1;
			firstProduct	= pagProductos * numProductos;
                }

		for(var i=firstProduct; i<lastProduct; i++){
			contLinea++;

			// Iniciamos la fila (tr)
			thisRow = rowStartID.replace('#ID#', 'posArr_' + (arrProductos[ColumnaOrdenadaProds[i]].linea - 1));

			// Celda/Columna numeracion
			thisCell = cellStart + '&nbsp;' + contLinea + '&nbsp;' + cellEnd;
			thisRow += thisCell;

			// Celda/Columna Ref.Cliente
			thisCell = cellStart + macroEnlaceRef.replace('#LIC_PROD_ID#', arrProductos[ColumnaOrdenadaProds[i]].IDProdLic);
			if(arrProductos[ColumnaOrdenadaProds[i]].RefCentro != ''){
				thisCell += arrProductos[ColumnaOrdenadaProds[i]].RefCentro;	// Mostramos Ref.Centro si existe
			}
			else if(arrProductos[ColumnaOrdenadaProds[i]].RefCliente != '')
			{
				thisCell += arrProductos[ColumnaOrdenadaProds[i]].RefCliente;	// Mostramos Ref.Cliente si existe
			}
			else
			{
				thisCell += arrProductos[ColumnaOrdenadaProds[i]].RefEstandar;	// Mostramos Ref.Estandar si no existe Ref.Cliente
			}
			thisCell += macroEnlaceEnd + cellEnd;
			thisRow += thisCell;

			// Celda/Columna Nombre
//			thisCell = cellStartClass.replace('#CLASS#','datosLeft') + arrProductos[ColumnaOrdenadaProds[i]].Nombre + cellEnd;
			thisCell = cellStartClass.replace('#CLASS#','datosLeft');
			if(isAutor == 'S'){
				thisCell += '<span style="display:table-cell;vertical-align:middle;">';
				functionJS = 'javascript:abrirCamposAvanzadosProd(' + (arrProductos[ColumnaOrdenadaProds[i]].linea - 1) + ');'
				thisCell += macroEnlace.replace('#HREF#', functionJS);
				thisCell += macroImagen.replace('#SRC#', 'http://www.newco.dev.br/images/anadir.gif').replace('#TITLE#', str_AnyadirInfoAmpliada).replace('#ALT#', str_AnyadirInfoAmpliada);
				thisCell += macroEnlaceEnd + '&nbsp;';
				thisCell += '</span>';
			}

			thisCell += '<span style="padding:2px;display:table-cell;"><strong>' + NombreProductoConEstilo(i) + '</strong>&nbsp;</span>';
			thisCell += cellEnd;
			thisRow += thisCell;

			// Celda/Columna iconos campos avanzados
			thisCell = cellStart;
			// Info.Ampliada
			if(arrProductos[ColumnaOrdenadaProds[i]].InfoAmpliada != ''){
				//ET 14dic16	Cambio de estilos para los tooltips
				//ET 14dic16	thisMacro = macroEnlaceAcc.replace('#HREF#', '#');
				thisMacro = divStartClass;
				thisMacro = thisMacro.replace('#CLASS#', 'tooltip');
				thisCell += thisMacro;
				thisCell += '<img src="http://www.newco.dev.br/images/infoAmpliadaIconO.gif" class="static"/>';
				//ET 14dic16	thisCell += spanStartClass.replace('#CLASS#', 'classic spanEIS');
				thisCell += spanStartClass.replace('#CLASS#', 'tooltiptext');
				thisCell += str_InfoAmpliada + ':<br/><br/>';
				thisCell += arrProductos[ColumnaOrdenadaProds[i]].InfoAmpliada;
				thisCell += spanEnd;
				thisCell += macroEnlaceEnd + '&nbsp;';
			}
			// Documento
			if(typeof arrProductos[ColumnaOrdenadaProds[i]].Documento.ID !== 'undefined'){
				thisMacro = macroEnlaceTarget.replace('#HREF#', 'http://www.newco.dev.br/Documentos/' + arrProductos[ColumnaOrdenadaProds[i]].Documento.Url);
				thisCell += thisMacro;
				thisMacro = macroImagen3.replace('#SRC#', 'http://www.newco.dev.br/images/clipIconO.gif');
				thisMacro = thisMacro.replace('#CLASS#', 'static');
				thisMacro = thisMacro.replace('#ALT#', str_Documento);
				thisMacro = thisMacro.replace('#TITLE#', str_Documento);
				thisCell += thisMacro;
//				thisCell += '<img src="" class="static"/>';
				thisCell += macroEnlaceEnd + '&nbsp;';
			}
			// Anotaciones
			if(arrProductos[ColumnaOrdenadaProds[i]].Anotaciones != ''){
				//ET 14dic16	Cambio de estilos para los tooltips
				//ET 14dic16	thisMacro = macroEnlaceAcc.replace('#HREF#', '#');
				thisMacro = divStartClass;
				thisMacro = thisMacro.replace('#CLASS#', 'tooltip');
				thisCell += thisMacro;
				thisCell += '<img src="http://www.newco.dev.br/images/infoAmpliadaIconNaraO.gif" class="static"/>';
				//ET 14dic16	thisCell += spanStartClass.replace('#CLASS#', 'classic spanEIS');
				thisCell += spanStartClass.replace('#CLASS#', 'tooltiptext');
				thisCell += str_Anotaciones + ':<br/><br/>';
				thisCell += arrProductos[ColumnaOrdenadaProds[i]].Anotaciones;
				thisCell += spanEnd;
				thisCell += macroEnlaceEnd;
			}
			thisCell += cellEnd;
			thisRow += thisCell;

			// Celda/Columna Fecha Alta
			thisCell = cellStart + arrProductos[ColumnaOrdenadaProds[i]].FechaAlta + cellEnd;
			thisRow += thisCell;

			// Celda/Columna Fecha Modificacion
			thisCell = cellStart + arrProductos[ColumnaOrdenadaProds[i]].FechaMod + cellEnd;
			thisRow += thisCell;

			// Celda/Columna Ud. Basica
			thisCell = cellStart;
			if(isAutor == 'S'){
				thisMacro	=	macroInputText.replace('#NAME#', 'UDBASICA_' + (arrProductos[ColumnaOrdenadaProds[i]].linea - 1));
				thisMacro	=	thisMacro.replace('#ID#', 'UDBASICA_' + (arrProductos[ColumnaOrdenadaProds[i]].linea - 1));
				thisMacro	=	thisMacro.replace('#VALUE#', arrProductos[ColumnaOrdenadaProds[i]].UdBasica);
				thisMacro	=	thisMacro.replace('#CLASS#', 'udbasica peq');
				thisMacro	=	thisMacro.replace('#SIZE#', '15');
				thisMacro	=	thisMacro.replace('#MAXLENGTH#', '100');
				thisCell		+=	thisMacro;
			}else{
				thisCell	+=	arrProductos[ColumnaOrdenadaProds[i]].UdBasica;
			}
			thisCell	+= cellEnd;
			thisRow		+= thisCell;

			// Celda/Columna Precio Historico
			thisCell = cellStart;
			if(mostrarPrecioIVA == 'S'){
				if(isAutor == 'S'){
					thisMacro	=	macroInputText.replace('#NAME#', 'PRECIOREFIVA_' + (arrProductos[ColumnaOrdenadaProds[i]].linea - 1));
					thisMacro	=	thisMacro.replace('#ID#', 'PRECIOREFIVA_' + (arrProductos[ColumnaOrdenadaProds[i]].linea - 1));
					thisMacro	=	thisMacro.replace('#VALUE#', arrProductos[ColumnaOrdenadaProds[i]].PrecioHistIVA);
					thisMacro	=	thisMacro.replace('#CLASS#', 'preciorefiva medio');
					thisMacro	=	thisMacro.replace('#SIZE#', '8');
					thisMacro	=	thisMacro.replace('#MAXLENGTH#', '10');
					thisCell	+=	thisMacro;

					thisMacro	=	macroInputHidden.replace('#NAME#', 'PRECIOREF_' + (arrProductos[ColumnaOrdenadaProds[i]].linea - 1));
					thisMacro	=	thisMacro.replace('#ID#', 'PRECIOREF_' + (arrProductos[ColumnaOrdenadaProds[i]].linea - 1));
					thisMacro	=	thisMacro.replace('#VALUE#', arrProductos[ColumnaOrdenadaProds[i]].PrecioHist);
					thisMacro	=	thisMacro.replace('#CLASS#', 'precioref medio');
					thisCell	+=	thisMacro;
				}else{
					thisCell	+=	arrProductos[ColumnaOrdenadaProds[i]].PrecioHistIVA;
				}
			}else{
				if(isAutor == 'S'){
					thisMacro	=	macroInputText.replace('#NAME#', 'PRECIOREF_' + (arrProductos[ColumnaOrdenadaProds[i]].linea - 1));
					thisMacro	=	thisMacro.replace('#ID#', 'PRECIOREF_' + (arrProductos[ColumnaOrdenadaProds[i]].linea - 1));
					thisMacro	=	thisMacro.replace('#VALUE#', arrProductos[ColumnaOrdenadaProds[i]].PrecioHist);
					thisMacro	=	thisMacro.replace('#CLASS#', 'precioref medio');
					thisMacro	=	thisMacro.replace('#SIZE#', '8');
					thisMacro	=	thisMacro.replace('#MAXLENGTH#', '10');
					thisCell	+=	thisMacro;
				}else{
					thisCell	+=	arrProductos[ColumnaOrdenadaProds[i]].PrecioHist;
				}
			}
			thisCell	+= cellEnd;
			thisRow		+= thisCell;

			// Celda/Columna Precio Objetivo
			thisCell = cellStart;
			if(mostrarPrecioIVA == 'S'){
				if(isAutor == 'S'){
					thisMacro	=	macroInputText.replace('#NAME#', 'PRECIO_OBJIVA_' + (arrProductos[ColumnaOrdenadaProds[i]].linea - 1));
					thisMacro	=	thisMacro.replace('#ID#', 'PRECIO_OBJIVA_' + (arrProductos[ColumnaOrdenadaProds[i]].linea - 1));
					thisMacro	=	thisMacro.replace('#VALUE#', arrProductos[ColumnaOrdenadaProds[i]].PrecioObjIVA);
					thisMacro	=	thisMacro.replace('#CLASS#', 'precioobjiva medio');
					thisMacro	=	thisMacro.replace('#SIZE#', '8');
					thisMacro	=	thisMacro.replace('#MAXLENGTH#', '10');
					thisCell	+=	thisMacro;

					thisMacro	=	macroInputHidden.replace('#NAME#', 'PRECIO_OBJ_' + (arrProductos[ColumnaOrdenadaProds[i]].linea - 1));
					thisMacro	=	thisMacro.replace('#ID#', 'PRECIO_OBJ_' + (arrProductos[ColumnaOrdenadaProds[i]].linea - 1));
					thisMacro	=	thisMacro.replace('#VALUE#', arrProductos[ColumnaOrdenadaProds[i]].PrecioObj);
					thisMacro	=	thisMacro.replace('#CLASS#', 'precioobj medio');
					thisCell	+=	thisMacro;
				}else{
					thisCell	+=	arrProductos[ColumnaOrdenadaProds[i]].PrecioObjIVA;
				}
			}else{
				if(isAutor == 'S'){
					thisMacro	=	macroInputText.replace('#NAME#', 'PRECIO_OBJ_' + (arrProductos[ColumnaOrdenadaProds[i]].linea - 1));
					thisMacro	=	thisMacro.replace('#ID#', 'PRECIO_OBJ_' + (arrProductos[ColumnaOrdenadaProds[i]].linea - 1));
					thisMacro	=	thisMacro.replace('#VALUE#', arrProductos[ColumnaOrdenadaProds[i]].PrecioObj);
					thisMacro	=	thisMacro.replace('#CLASS#', 'precioobj medio');
					thisMacro	=	thisMacro.replace('#SIZE#', '8');
					thisMacro	=	thisMacro.replace('#MAXLENGTH#', '10');
					thisCell	+=	thisMacro;
				}else{
					thisCell	+=	arrProductos[ColumnaOrdenadaProds[i]].PrecioObj;
				}
			}
			thisCell	+= cellEnd;
			thisRow		+= thisCell;

			// Celda/Columna Cantidad
			thisCell = cellStart;
			if((isAutor == 'S')&&(isLicAgregada == 'N')){
				thisMacro	=	macroInputText.replace('#NAME#', 'CANTIDAD_' + (arrProductos[ColumnaOrdenadaProds[i]].linea - 1));
				thisMacro	=	thisMacro.replace('#ID#', 'CANTIDAD_' + (arrProductos[ColumnaOrdenadaProds[i]].linea - 1));
				thisMacro	=	thisMacro.replace('#VALUE#', arrProductos[ColumnaOrdenadaProds[i]].Cantidad);
				thisMacro	=	thisMacro.replace('#CLASS#', 'cantidad peq');
				thisMacro	=	thisMacro.replace('#SIZE#', '6');
				thisMacro	=	thisMacro.replace('#MAXLENGTH#', '8');
				thisCell	+=	thisMacro;
			}else{
				thisCell	+=	arrProductos[ColumnaOrdenadaProds[i]].Cantidad;
				//12ago16	Campo oculto Cantidad
				thisMacro	=	macroInputHidden.replace('#NAME#', 'CANTIDAD_' + (arrProductos[ColumnaOrdenadaProds[i]].linea - 1));
				thisMacro	=	thisMacro.replace('#ID#', 'CANTIDAD_' + (arrProductos[ColumnaOrdenadaProds[i]].linea - 1));
				thisMacro	=	thisMacro.replace('#VALUE#', arrProductos[ColumnaOrdenadaProds[i]].Cantidad);
				thisCell	+=	thisMacro;
			}
			thisCell	+= cellEnd;
			thisRow		+= thisCell;

			// Celda/Columna Consumo y Celda/Columna tipoIVA (si se requiere)
			if(mostrarPrecioIVA == 'S'){
				thisCell = cellStart;
				if(IDPais == '34'){
					thisCell	+= arrProductos[ColumnaOrdenadaProds[i]].TipoIVA + '%';
				}else{
					thisCell	+= '';
				}
				thisCell	+= cellEnd;
				thisRow		+= thisCell;

				thisCell = cellStartClass.replace('#CLASS#', 'consumo') + arrProductos[ColumnaOrdenadaProds[i]].ConsumoHistIVA + cellEnd;
				thisRow		+= thisCell;
			}else{
				thisCell = cellStartClass.replace('#CLASS#', 'consumo') + arrProductos[ColumnaOrdenadaProds[i]].ConsumoHist + cellEnd;
				thisRow		+= thisCell;

				thisCell = cellStart;
				if(IDPais == '34'){
					thisCell	+= arrProductos[ColumnaOrdenadaProds[i]].TipoIVA + '%';
				}else{
					thisCell	+= '';
				}
				thisCell	+= cellEnd;
				thisRow		+= thisCell;
			}

			// Celda/Columna Acciones
			thisCell = cellStart;
			if(isAutor == 'S'){
				functionJS	= 'javascript:modificaProducto(\'' + arrProductos[ColumnaOrdenadaProds[i]].IDProdLic + '\', \'' + arrProductos[ColumnaOrdenadaProds[i]].IDProd + '\', \'' + arrProductos[ColumnaOrdenadaProds[i]].RefEstandar + '\', \'' + arrProductos[ColumnaOrdenadaProds[i]].Nombre + '\', \'' + arrProductos[ColumnaOrdenadaProds[i]].UdBasica + '\', \'' + arrProductos[ColumnaOrdenadaProds[i]].Cantidad + '\', \'' + arrProductos[ColumnaOrdenadaProds[i]].PrecioHist + '\', \'' + arrProductos[ColumnaOrdenadaProds[i]].PrecioObj + '\', \'' + arrProductos[ColumnaOrdenadaProds[i]].TipoIVA + '\', \'B\')';
				thisMacro	= macroEnlaceAcc.replace('#CLASS#', 'accBorrar');
				thisMacro	= thisMacro.replace('#HREF#', functionJS);
				thisCell	+= thisMacro;
				thisCell	+= '<img src="http://www.newco.dev.br/images/2017/trash.png" alt="' + str_borrar + '" title="' + str_borrar + '"/>'
				thisCell	+= macroEnlaceEnd;
			}else{
				thisCell	+= '';
			}
			thisCell	+= cellEnd;
			thisRow		+= thisCell;


			thisRow += rowEnd;
			htmlTBODY += thisRow;
		}

		dibujarFilaConsumoProdEST();
		calcularPaginacion();
	}else{
		htmlTBODY = "<tr><td colspan=\"13\" align=\"center\"><strong>" + str_licSinProductos + "</strong></td></tr>";
	}

	jQuery('#lProductos_EST tbody').empty().append(htmlTBODY);

	// Ahora recalculamos los valores del floatinBox
	if(jQuery(".FBox").length)
		calcularFloatingBox_EST();
}

function seleccionarPreciosProveedor(columna){
	var MejorOfertaID;
	var posArr = columna - 1;

	jQuery.each(arrProductos, function(key, producto){
		if(producto.Ofertas[posArr].NoInformada != 'S' && producto.Ofertas[posArr].NoOfertada != 'S'){
//			debug(producto.Ofertas[posArr].IDOferta + ': yes, key: ' + key);
			MejorOfertaID = producto.Ofertas[posArr].ID;		//21set16	.IDOferta;
			// Una vez tengo el mejor precio y su IDOferta, busco el radio button que toca
			var radioAux = document.getElementsByName('RADIO_' + key);

			for(var j = 0; j < radioAux.length; j++){
				if(radioAux[j].value == MejorOfertaID){
					radioAux[j].checked = true;
					// Ahora lanzamos la funcion para que recalcule el div flotante
					recalcularFloatingBox(radioAux[j], 0);
				}
			}
		}
	});

	validarPedidosMinimosDOM();
}

function ordenacionInformado(tipo){
	filtroNombre	= '';
	jQuery('#filtroProductos').val('');

	jQuery.each(arrProductos, function(key, producto){
		if(tipo == 'EST'){
			if(producto.UdBasica == ''){
				producto.Ordenacion = '0';
			}else{
				producto.Ordenacion = '1';
			}
		}else if(tipo == 'PROV'){
			if(producto.Oferta.Informada == 'N'){
				producto.Ordenacion = '0';
			}else{
				if(producto.Oferta.RefProv.toUpperCase() == 'SIN OFERTAR'){
					producto.Ordenacion = '1';
				}else{
					producto.Ordenacion = '2';
				}
			}
		}else if(tipo == 'OFE'){
			if(producto.TieneSeleccion == 'N' && producto.NoAdjudicado == 'N'){	// Todavia no se ha guardado ninguna seleccion
				producto.Ordenacion = '0';
			}else{
				producto.Ordenacion = '1';
			}
		}
	});

	OrdenarProdsPorColumna('Ordenacion');
}

//	Ordena tabla productos por una columna
function OrdenarProdsPorColumna(col, flag){
	flag   = (typeof flag === "undefined") ? false : flag;
	col = (col=='')?ColumnaOrdenacionProds:col;			//18mar19	Valor por defecto
	
	//solodebug	debug('OrdenarProdsPorColumna:'+col);
	

	if(flag !== true){
		if(ColumnaOrdenacionProds == col && col != 'Ordenacion'){
			if(OrdenProds == 'ASC'){
				OrdenProds = 'DESC';
        	        }else{
				OrdenProds = 'ASC';
        	        }
		}else{
			ColumnaOrdenacionProds = col;
			OrdenProds = 'ASC';
		}
        }


//	if(col == 'Consumo' || col == 'ConsumoIVA' || col == 'ConsumoHist' || col == 'ConsumoHistIVA' || col == 'NumOfertas' || col == 'ConsumoOferta' || col == 'Ordenacion'){
	//	Si la columna es string, ordenamiento alfabetico
	if(col == 'NombreNorm' || col == 'RefCliente'){
		ordenamientoAlfabet(col, OrdenProds);
	//	Si la columna es numerica, ordenamiento burbuja
	}else{
		ordenamientoBurbuja(col, OrdenProds);
	}

	dibujaTablaProductos();
}

//	Prepara un array con los ordenes correspondientes a una columna de numeros
function ordenamientoBurbuja(col, tipo){
	var temp, temp2, size, valAux, posArr, column = '';
	var arrValores = new Array();

	if(col.indexOf("PrecioProvIVA") >= 0){
		column = 'PrecioIVA';
		posArr = col.replace("PrecioProvIVA_", "") - 1;
	}else if(col.indexOf("PrecioProv") >= 0){
		column = 'Precio';
		posArr = col.replace("PrecioProv_", "") - 1;
	}else if(col.indexOf("ConsProvIVA") >= 0){
		column = 'ConsumoIVA';
		posArr = col.replace("ConsProvIVA_", "") - 1;
	}else if(col.indexOf("ConsProv") >= 0){
		column = 'Consumo';
		posArr = col.replace("ConsProv_", "") - 1;
	}else if(col.indexOf("AhorProv") >= 0){
		column = 'Ahorro';
		posArr = col.replace("AhorProv_", "") - 1;
	}
		
	//solodebug	debug('ordenamientoBurbuja. column:'+column+' posArr:'+posArr);

	// Creamos un vector auxiliar con los valores que queremos ordenar (segun el vector de ordenacion)
	for(var i=0; i<totalProductos; i++){
		if(column != ''){
			if(arrProductos[ColumnaOrdenadaProds[i]].Ofertas[posArr].NoInformada == 'S'){
				valAux = -2;
			}else if(arrProductos[ColumnaOrdenadaProds[i]].Ofertas[posArr].NoOfertada == 'S'){
				valAux = -1;
			}else{
				valAux = (arrProductos[ColumnaOrdenadaProds[i]].Ofertas[posArr][column].replace(/\./g,'').replace(',','.') != '') ? arrProductos[ColumnaOrdenadaProds[i]].Ofertas[posArr][column].replace(/\./g,'').replace(',','.') : '0';
			}
//                }else if(column == 'Precio'){
//			valAux = (arrProductos[ColumnaOrdenadaProds[i]].Ofertas[posArr].Precio.replace(/\./g,'').replace(',','.') != '') ? arrProductos[ColumnaOrdenadaProds[i]].Ofertas[posArr].Precio.replace(/\./g,'').replace(',','.') : '0';
		}else{
			
			
			//solodebug	debug('ordenamientoBurbuja. i:'+i+' arrProductos[ColumnaOrdenadaProds[i]][col]: ('+arrProductos[ColumnaOrdenadaProds[i]][col]+')');
			
			if (Number.isInteger(arrProductos[ColumnaOrdenadaProds[i]][col]))
				valAux = arrProductos[ColumnaOrdenadaProds[i]][col];
			else
				valAux = (arrProductos[ColumnaOrdenadaProds[i]][col].replace(/\./g,'').replace(',','.') != '') ? arrProductos[ColumnaOrdenadaProds[i]][col].replace(/\./g,'').replace(',','.') : '0';
		}
		
		//solodebug	debug('ordenamientoBurbuja ('+i+'):'+valAux);
		
		arrValores.push(parseFloat(valAux));
	}

	size = totalProductos;
	for(var pass = 1; pass < size; pass++){ // outer loop
		for(var left = 0; left < (size - pass); left++){ // inner loop
			var right = left + 1;

			// Comparamos valores del vector auxiliar
			if(arrValores[left] > arrValores[right]){

				//solodebug	debug('ordenamientoBurbuja. Intercambiar:'+arrValores[left] +'>'+ arrValores[right]);
				
				// Intercambiamos valores del vector auxiliar y del vector de ordenacion, ya este ultimo es el que queremos ordenar y estan relacionados
				temp=ColumnaOrdenadaProds[left];
				temp2=arrValores[left];
				ColumnaOrdenadaProds[left]=ColumnaOrdenadaProds[right];
				arrValores[left]=arrValores[right];
				ColumnaOrdenadaProds[right]=temp;
				arrValores[right]=temp2;
		
			}
		}
	}

	//	En caso de ordenacion descendiente intercambiamos de forma simetrica el vector de ordenacion
	if(tipo=='DESC'){
		for(i=1; i<=totalProductos/2; i++){
			temp=ColumnaOrdenadaProds[totalProductos-i];
			ColumnaOrdenadaProds[totalProductos-i]=ColumnaOrdenadaProds[i-1];
			ColumnaOrdenadaProds[i-1]=temp;
		}
	}


	
	//solodebug
	//solodebugfor(var i=0; i<totalProductos; i++)
	//solodebug{
	//solodebug	debug('ordenamientoBurbuja fin ('+i+'). Pos:'+ColumnaOrdenadaProds[i]+' val:'+arrValores[i]);
	//solodebug}

}

//	Prepara un array con los ordenes correspondientes a una columna de caracteres alfanumericos
function ordenamientoAlfabet(col, tipo){
	var temp, temp2, size, valAux;
	var arrValores = new Array();
	
	var fila;			//19mar19

	// Creamos un vector auxiliar con los valores que queremos ordenar (segun el vector de ordenacion)
	for(var i=0; i<totalProductos; i++)
	{
	/*
		// Si ordenamos por referencia puede que tengamos que ordenar por RefCliente o RefEstandar para cada producto
		if(col == 'RefCliente')
		{
			valAux = (arrProductos[ColumnaOrdenadaProds[i]][col] != '') ? arrProductos[ColumnaOrdenadaProds[i]][col] : arrProductos[ColumnaOrdenadaProds[i]]['RefEstandar'] ;
		}
		else
		{
			try
			{
				valAux = arrProductos[ColumnaOrdenadaProds[i]][col];
			}
			catch(err)
			{
				debug('ordenamientoAlfabet,tipo:'+tipo+' no se ha encontrado valor en fila '+i+' ColOrd:'+ColumnaOrdenadaProds[i]+' columna:'+col);
				valAux = 'PRUEBA';
			}
		}
	*/	

		fila=i;//19mar19
		ColumnaOrdenadaProds[i]=i;	//19mar19
	
		// Si ordenamos por referencia puede que tengamos que ordenar por RefCliente o RefEstandar para cada producto
		if(col == 'RefCliente')
		{
			valAux = (arrProductos[fila][col] != '') ? arrProductos[fila][col] : arrProductos[fila]['RefEstandar'] ;
		}
		else
		{
			try
			{
				valAux = arrProductos[fila][col];
			}
			catch(err)
			{
				debug('ordenamientoAlfabet,tipo:'+tipo+' no se ha encontrado valor en fila '+i+' ColOrd:'+fila+' columna:'+col);
				valAux = 'PRUEBA';
			}
		}

		arrValores.push(valAux);
	}

	size = totalProductos;
	for(var pass = 1; pass < size; pass++){ // outer loop
		for(var left = 0; left < (size - pass); left++){ // inner loop
			var right = left + 1;

			// Comparamos valores del vector auxiliar
			if(arrValores[left] > arrValores[right]){
				// Intercambiamos valores del vector auxiliar y del vector de ordenacion, ya este ultimo es el que queremos ordenar y estan relacionados
				temp=ColumnaOrdenadaProds[left];
				temp2=arrValores[left];
				ColumnaOrdenadaProds[left]=ColumnaOrdenadaProds[right];
				arrValores[left]=arrValores[right];
				ColumnaOrdenadaProds[right]=temp;
				arrValores[right]=temp2;
			}
		}
	}

	//	En caso de ordenacion descendiente intercambiamos de forma simetrica el vector de ordenacion
	if(tipo=='DESC'){
		for(i=1; i<=totalProductos/2; i++){
			temp=ColumnaOrdenadaProds[totalProductos-i];
			ColumnaOrdenadaProds[totalProductos-i]=ColumnaOrdenadaProds[i-1];
			ColumnaOrdenadaProds[i-1]=temp;
		}
	}
}

//	Ordena tabla proveedores por una columna
function OrdenarProvsPorColumna(col)
{

	if(ColumnaOrdenacionProvs == col)
	{
		if(OrdenProvs == 'ASC')
		{
			OrdenProvs = 'DESC';
        }
		else
		{
			OrdenProvs = 'ASC';
        }
	}
	else
	{
		ColumnaOrdenacionProvs = col;
		if(col == 'ConsumoProv' || col == 'ConsumoProvIVA' || col == 'ConsumoAdj' || col == 'ConsumoAdjIVA' || col == 'Ahorro' ||
		   col == 'NumeroLineas' || col == 'OfeMejPrecio' || col == 'OfeConAhorro' || col == 'ConsMejPrecio' ||
		   col == 'ConsMejPrecIVA' || col == 'ConsConAhorro' || col == 'ConsConAhorIVA' || col == 'AhorMejPrecio' || col == 'AhorOfeConAhor')
			OrdenProvs = 'DESC';
		else
			OrdenProvs = 'ASC';
	}

	//	Si la columna es numerica, ordenamiento burbuja
	if(col == 'ConsumoProv' || col == 'ConsumoProvIVA' || col == 'ConsumoAdj' || col == 'ConsumoAdjIVA' || col == 'Ahorro' ||
	   col == 'PedidoMin' || col == 'NumeroLineas' || col == 'OfeMejPrecio' || col == 'OfeConAhorro' || col == 'ConsMejPrecio' ||
	   col == 'ConsMejPrecIVA' || col == 'ConsConAhorro' || col == 'ConsConAhorIVA' || col == 'AhorMejPrecio' || col == 'AhorOfeConAhor')
		ordenamientoBurbujaProvs(col, OrdenProvs);
	//	Si la columna es string, ordenamiento alfabetico
	else if(col == 'NombreCorto')
		ordenamientoAlfabetProvs(col, OrdenProvs);

	dibujaTablaProveedores();
}

//	Prepara un array con los ordenes correspondientes a una columna de numeros
function ordenamientoBurbujaProvs(col, tipo){
	var temp, temp2, size, valAux;
	var arrValores = new Array();

	// Creamos un vector auxiliar con los valores que queremos ordenar (segun el vector de ordenacion)
	for(var i=0; i<totalProvs; i++){
		valAux = (arrProveedores[ColumnaOrdenadaProvs[i]][col].replace(/\./g,'').replace(',','.') != '') ? arrProveedores[ColumnaOrdenadaProvs[i]][col].replace(/\./g,'').replace(',','.') : '0';
		arrValores.push(parseFloat(valAux));
	}

	size = totalProvs;
	for(var pass = 1; pass < size; pass++){ // outer loop
		for(var left = 0; left < (size - pass); left++){ // inner loop
			var right = left + 1;

			// Comparamos valores del vector auxiliar
			if(arrValores[left] > arrValores[right]){
				// Intercambiamos valores del vector auxiliar y del vector de ordenacion, ya este ultimo es el que queremos ordenar y estan relacionados
				temp=ColumnaOrdenadaProvs[left];
				temp2=arrValores[left];
				ColumnaOrdenadaProvs[left]=ColumnaOrdenadaProvs[right];
				arrValores[left]=arrValores[right];
				ColumnaOrdenadaProvs[right]=temp;
				arrValores[right]=temp2;
			}
		}
	}

	//	En caso de ordenacion descendiente intercambiamos de forma simetrica el vector de ordenacion
	if(tipo=='DESC'){
		for(i=1; i<=totalProvs/2; i++){
			temp=ColumnaOrdenadaProvs[totalProvs-i];
			ColumnaOrdenadaProvs[totalProvs-i]=ColumnaOrdenadaProvs[i-1];
			ColumnaOrdenadaProvs[i-1]=temp;
		}
	}
}

//	Prepara un array con los ordenes correspondientes a una columna de caracteres alfanumericos
function ordenamientoAlfabetProvs(col, tipo){
	var temp, temp2, size, valAux;
	var arrValores = new Array();

	// Creamos un vector auxiliar con los valores que queremos ordenar (segun el vector de ordenacion)
	for(var i=0; i<totalProvs; i++){
	
		valAux = arrProveedores[ColumnaOrdenadaProvs[i]][col];
		arrValores.push(valAux);
	}

	size = totalProvs;
	for(var pass = 1; pass < size; pass++){ // outer loop
		for(var left = 0; left < (size - pass); left++){ // inner loop
			var right = left + 1;

			// Comparamos valores del vector auxiliar
			if(arrValores[left] > arrValores[right]){
				// Intercambiamos valores del vector auxiliar y del vector de ordenacion, ya este ultimo es el que queremos ordenar y estan relacionados
				temp=ColumnaOrdenadaProvs[left];
				temp2=arrValores[left];
				ColumnaOrdenadaProvs[left]=ColumnaOrdenadaProvs[right];
				arrValores[left]=arrValores[right];
				ColumnaOrdenadaProvs[right]=temp;
				arrValores[right]=temp2;
			}
		}
	}

	//	En caso de ordenacion descendiente intercambiamos de forma simetrica el vector de ordenacion
	if(tipo=='DESC'){
		for(i=1; i<=totalProvs/2; i++){
			temp=ColumnaOrdenadaProvs[totalProvs-i];
			ColumnaOrdenadaProvs[totalProvs-i]=ColumnaOrdenadaProvs[i-1];
			ColumnaOrdenadaProvs[i-1]=temp;
		}
	}
}

function dibujarFilaConsumoProdEST(){
	var htmlTFOOT = '', consumoTotal = 0, campo, valAux;

	if(mostrarPrecioIVA == 'S'){
		campo = 'ConsumoHistIVA';
	}else{
		campo = 'ConsumoHist';
	}

	for(var i=0; i<totalProductos; i++){
		valAux = parseFloat(arrProductos[ColumnaOrdenadaProds[i]][campo].replace(/\./g,'').replace(',','.'));

		if(!isNaN(valAux)){
			consumoTotal += valAux;
		}
	}

	htmlTFOOT = '<tfoot>';
	htmlTFOOT += rowStartStyle.replace('#STYLE#', 'border-top:1px solid #999;height:30px;');
	htmlTFOOT += cellStartColspan;
	if(mostrarPrecioIVA == 'S')
		htmlTFOOT = htmlTFOOT.replace('#COLSPAN#', '8');
	else
		htmlTFOOT = htmlTFOOT.replace('#COLSPAN#', '7');
	htmlTFOOT += cellEnd;
	htmlTFOOT += cellStartColspan.replace('#COLSPAN#', '2');
	htmlTFOOT += '<strong>' + str_totalConsumo + ':</strong>';
	htmlTFOOT += cellEnd;
	htmlTFOOT += cellStartID.replace('#ID#', 'CONSUMO_TOTAL');
	// Formateamos el valor de la variable consumoTotal para mostrar
	if(!isNaN(consumoTotal)){
		if(consumoTotal >= 1000){
			consumoTotal = formatCurrency(consumoTotal);
                }else{
			consumoTotal = consumoTotal.toFixed(2).replace(".", ",");
                }
	}else{
		consumoTotal = '0,00';
	}
	htmlTFOOT += '<strong>' + consumoTotal + '</strong>';
	htmlTFOOT += cellEnd;
	if(mostrarPrecioIVA == 'S')
		htmlTFOOT += cellStart;
	else
		htmlTFOOT += cellStartColspan.replace('#COLSPAN#', '2');
	htmlTFOOT += cellEnd;
	htmlTFOOT += rowEnd;

	htmlTFOOT += rowStartIDClass.replace('#CLASS#', 'sinLinea');
	htmlTFOOT += cellStartColspan.replace('#COLSPAN#', '12');
	htmlTFOOT += cellEnd;
	htmlTFOOT += rowEnd;
	
	if(isAutor == 'S'){
		htmlTFOOT += rowStartIDClass.replace('#CLASS#', 'sinLinea').replace('#ID#', 'botonRow');
		htmlTFOOT += cellStartColspan.replace('#COLSPAN#', '3');
		htmlTFOOT += cellEnd;
		htmlTFOOT += cellStartColspan.replace('#COLSPAN#', '3');
		//htmlTFOOT += divStartClassID.replace('#CLASS#', 'boton').replace('#ID#', 'botonActualizar');
		//htmlTFOOT += macroEnlaceAcc.replace('#CLASS#', '').replace('#HREF#', 'javascript:ValidarFormulario(document.forms[\'ActualizarProductos\'],\'actualizarProductos\');');
		
		//ET 30dic16
		htmlTFOOT += macroEnlaceAccID.replace('#CLASS#', 'btnDestacado').replace('#ID#', 'botonActualizar').replace('#HREF#', 'javascript:ValidarFormulario(document.forms[\'ActualizarProductos\'],\'actualizarProductos\');');
		
		htmlTFOOT += str_ActualizarDatos;
		htmlTFOOT += macroEnlaceEnd;
		//htmlTFOOT += divEnd;
		
		//ET 27feb19
		htmlTFOOT += cellEnd;
		htmlTFOOT += cellStartColspan.replace('#COLSPAN#', '3');
		htmlTFOOT += macroEnlaceAccID.replace('#CLASS#', 'btnDestacado').replace('#ID#', 'botonBorrarProductos').replace('#HREF#', 'javascript:BorrarTodosProductos();');
		htmlTFOOT += str_BorrarProductos;
		htmlTFOOT += macroEnlaceEnd;
		
		htmlTFOOT += cellEnd;
		htmlTFOOT += cellStartColspan.replace('#COLSPAN#', '3');
		htmlTFOOT += cellEnd;
		htmlTFOOT += rowEnd;
    }

	htmlTFOOT += '</tfoot>';

	jQuery('#lProductos_EST').append(htmlTFOOT);
}

function dibujarFilaConsumoProdOFE(){
	var htmlTFOOT = '', consumoTotalHist = 0, consumoTotalObj = 0, campo, valAux;

	if(mostrarPrecioIVA == 'S'){
		consumoTotalHist	= objLicitacion['ConsHistIVA'];
		consumoTotalObj		= objLicitacion['ConsumoIVA'];
	}else{
		consumoTotalHist	= objLicitacion['ConsHist'];
		consumoTotalObj		= objLicitacion['Consumo'];
	}

	htmlTFOOT = '<tfoot>';
	htmlTFOOT += rowStartStyle.replace('#STYLE#', 'border-top:1px solid #999;height:30px;');
	htmlTFOOT += cellStart + cellEnd;
	htmlTFOOT += cellStartColspanCls.replace('#COLSPAN#', '4').replace('#CLASS#', 'centerDiv');
	if((estadoLicitacion == 'CURS' || estadoLicitacion == 'INF')){
		htmlTFOOT += '<strong>' + str_PorcNegociado + ':&nbsp' + objLicitacion['PorcConsNeg'] + '&nbsp;&nbsp;&nbsp;-&nbsp;&nbsp;&nbsp;' + str_PorcAhorro + ':&nbsp' + objLicitacion['AhorMejPrecio'] + '</strong>';
	}else{
		htmlTFOOT += '<strong>' + str_PorcNegociado + ':&nbsp' + objLicitacion['PorcConsNeg'] + '&nbsp;&nbsp;&nbsp;-&nbsp;&nbsp;&nbsp;' + str_PorcAhorro + ':&nbsp' + objLicitacion['Ahorro'] + '</strong>';
	}
	htmlTFOOT += cellEnd;

	htmlTFOOT += cellStartStyle.replace('#STYLE#', 'text-align:right;padding:5px 0px;');
	htmlTFOOT += '<strong>';
	if(mostrarPrecioIVA == 'S'){
		htmlTFOOT += str_TotalConsCIVA;
	}else{
		htmlTFOOT += str_TotalConsSIVA;
	}
	htmlTFOOT += ':&nbsp;</strong>';
	htmlTFOOT += cellEnd;

	htmlTFOOT += cellStartClass.replace('#CLASS#', 'datosRight');
	htmlTFOOT += '<strong>' + consumoTotalHist + '&nbsp;</strong>';
	htmlTFOOT += cellEnd;

	htmlTFOOT += cellStartClass.replace('#CLASS#', 'datosRight');
	htmlTFOOT += '<strong>' + consumoTotalObj + '&nbsp;</strong>';
	htmlTFOOT += cellEnd;

	htmlTFOOT += cellStartColspan.replace('#COLSPAN#', '4') + cellEnd;

	for(var i=0; i<NumProvsOfertas; i++){

		if (arrConsumoProvs[i].TieneOfertas=='S'){	//	COmprueba proveedor con ofertas /Mantenimiento/LICITACION/PRODUCTOSLICITACION/PROVEEDORESLICITACION/PROVEEDOR/TIENE_OFERTAS

			htmlTFOOT += cellStartClass.replace('#CLASS#', 'borderLeft');
			htmlTFOOT += cellEnd;

			htmlTFOOT += cellStartClass.replace('#CLASS#', 'colPrecio');
			htmlTFOOT += cellEnd;

			if(mostrarPrecioIVA == 'S'){
				if(arrConsumoProvs[i].ConsumoIVA != '0,00' && arrConsumoProvs[i].ConsumoIVA != ''){
					htmlTFOOT += cellStartClassStyle.replace('#CLASS#', 'datosRight colConsumo');
					htmlTFOOT = htmlTFOOT.replace('#STYLE#', 'display:none;');
					if((estadoLicitacion == 'CURS' || estadoLicitacion == 'INF')){
						htmlTFOOT += '<strong>' + arrConsumoProvs[i].ConsumoIVA + '&nbsp;</strong>';
					}else{
						htmlTFOOT += '<strong>' + arrConsumoProvs[i].ConsumoAdjIVA + '&nbsp;</strong>';
					}
					htmlTFOOT += cellEnd;

					htmlTFOOT += cellStartClassStyle.replace('#CLASS#', 'borderLeft datosRight colAhorro');
					htmlTFOOT = htmlTFOOT.replace('#STYLE#', 'display:none;');
					htmlTFOOT += '<strong>';
					if(arrConsumoProvs[i].ConsumoPotIVA != '0,00' && arrConsumoProvs[i].ConsumoPotIVA != ''){
						htmlTFOOT += arrConsumoProvs[i].AhorroIVA + '%&nbsp;';
					}else{
						htmlTFOOT += '&nbsp;';
					}
					htmlTFOOT += '&nbsp;</strong>';
					htmlTFOOT += cellEnd;
				}else{
	//				htmlTFOOT += cellStartColspan.replace('#COLSPAN#', '2') + cellEnd;

					htmlTFOOT += cellStartClassStyle.replace('#CLASS#', 'colConsumo').replace('#STYLE#', 'display:none;');
					htmlTFOOT += cellEnd;
					htmlTFOOT += cellStartClassStyle.replace('#CLASS#', 'colAhorro').replace('#STYLE#', 'display:none;');
					htmlTFOOT += cellEnd;
				}
			}else{
				if(arrConsumoProvs[i].Consumo != '0,00' && arrConsumoProvs[i].Consumo != ''){
					htmlTFOOT += cellStartClassStyle.replace('#CLASS#', 'datosRight colConsumo');
					htmlTFOOT = htmlTFOOT.replace('#STYLE#', 'display:none;');
					if((estadoLicitacion == 'CURS' || estadoLicitacion == 'INF')){
						htmlTFOOT += '<strong>' + arrConsumoProvs[i].Consumo + '&nbsp;</strong>';
					}else{
						htmlTFOOT += '<strong>' + arrConsumoProvs[i].ConsumoAdj + '&nbsp;</strong>';
					}
					htmlTFOOT += cellEnd;

					htmlTFOOT += cellStartClassStyle.replace('#CLASS#', 'borderLeft datosRight colAhorro');
					htmlTFOOT = htmlTFOOT.replace('#STYLE#', 'display:none;');
					htmlTFOOT += '<strong>';
					if(arrConsumoProvs[i].ConsumoPot != '0,00' && arrConsumoProvs[i].ConsumoPot != ''){
						htmlTFOOT += arrConsumoProvs[i].Ahorro + '%&nbsp;';
					}else{
						htmlTFOOT += '&nbsp;';
					}
					htmlTFOOT += '&nbsp;</strong>';
					htmlTFOOT += cellEnd;
				}else{
	//				htmlTFOOT += cellStartColspan.replace('#COLSPAN#', '2') + cellEnd;

					htmlTFOOT += cellStartClassStyle.replace('#CLASS#', 'colConsumo').replace('#STYLE#', 'display:none;');
					htmlTFOOT += cellEnd;
					htmlTFOOT += cellStartClassStyle.replace('#CLASS#', 'colAhorro').replace('#STYLE#', 'display:none;');
					htmlTFOOT += cellEnd;
				}
			}
	//		htmlTFOOT += cellStartColspan.replace('#COLSPAN#', '2') + cellEnd;
		}
		htmlTFOOT += cellStartClassStyle.replace('#CLASS#', 'colEval').replace('#STYLE#', 'display:none;');
		htmlTFOOT += cellEnd;
		htmlTFOOT += cellStartClassStyle.replace('#CLASS#', 'colInfo').replace('#STYLE#', 'display:none;');
		htmlTFOOT += cellEnd;
	}

	htmlTFOOT += rowEnd;
	htmlTFOOT += '</tfoot>';

	jQuery('#lProductos_OFE').append(htmlTFOOT);
}

function calcularPaginacion(){
	var pagAnterior, pagSiguiente;
	var innerHTML = '';

	// Pagina anterior
	if(firstProduct != 0){
		pagAnterior = pagProductos - 1;
	}

	// Pagina siguiente
	if(lastProduct != totalProductos){
		pagSiguiente = pagProductos + 1;
	}

	// Info Pagina actual
	if(pagAnterior !== undefined){
		innerHTML = '<a style="text-decoration:none;font-size:11px;" href="javascript:paginacion(' + pagAnterior + ');">' + str_PagAnterior + '</a>';
		if(jQuery('#topPesProds').length)		jQuery('#topPesProds #pagAnterior').html(innerHTML);
		if(jQuery('#botPesProds').length)		jQuery('#botPesProds #pagAnterior').html(innerHTML);
	}else{
		if(jQuery('#topPesProds').length)		jQuery('#topPesProds #pagAnterior').html('');
		if(jQuery('#botPesProds').length)		jQuery('#botPesProds #pagAnterior').html('');
	}

	if(pagSiguiente !== undefined){
		innerHTML = '<a style="width:20px;text-align:right;padding-left:0px;text-decoration:none;font-size:11px;" href="javascript:paginacion(' + pagSiguiente + ');">' + str_PagSiguiente + '</a>';
		if(jQuery('#topPesProds').length)		jQuery('#topPesProds #pagSiguiente').html(innerHTML);
		if(jQuery('#botPesProds').length)		jQuery('#botPesProds #pagSiguiente').html(innerHTML);
	}else{
		if(jQuery('#topPesProds').length)		jQuery('#topPesProds #pagSiguiente').html('');
		if(jQuery('#botPesProds').length)		jQuery('#botPesProds #pagSiguiente').html('');
	}

	innerHTML = str_Paginacion.replace('[[PAGACTUAL]]', (pagProductos + 1)).replace('[[PAGTOTAL]]', pagsProdTotal).replace('[[TOTALPRODUCTOS]]', totalProductos);
	jQuery('#paginacion').html(innerHTML);

	if(rol == 'VENDEDOR'){
		if(pagsProdTotal > 1){
			if(jQuery('#topPesProds').length){
				jQuery('#topPesProds').css('border', '2px solid red');
				jQuery('#topPesProds div').css('background-color', '#FFFF99');
				jQuery('#topPesProds #pagAnterior a').css('color', 'red');
				jQuery('#topPesProds #pagSiguiente a').css('color', 'red');
			}
			if(jQuery('#botPesProds').length){
				jQuery('#botPesProds').css('border', '2px solid red');
				jQuery('#botPesProds div').css('background-color', '#FFFF99');
				jQuery('#botPesProds #pagAnterior a').css('color', 'red');
				jQuery('#botPesProds #pagSiguiente a').css('color', 'red');
			}
		}else{
			if(jQuery('#topPesProds').length){
				jQuery('#topPesProds').css('border', '1px solid #999');
				jQuery('#topPesProds div').css('background-color', 'rgba(0, 0, 0, 0)');
			}
			if(jQuery('#botPesProds').length){
				jQuery('#botPesProds').css('border', '1px solid #999');
				jQuery('#botPesProds div').css('background-color', 'rgba(0, 0, 0, 0)');
			}
		}
	}
}

function paginacion(numPag){
	var chk = true;

	// Si hay cambios en el formulario, pedimos confirmacion
	if(anyChange){
		chk = confirm(conf_hayCambios);
	}

	if(chk){
		if(jQuery('#MensActualizarOfertas').length){
			jQuery('#MensActualizarOfertas').hide();
		}
		pagProductos = numPag;
		dibujaTablaProductos();
	}
}

//	Prepara la tabla de ordenacion de proveedores
function prepararOrdProveedores(){
	totalProvs	= arrProveedores.length;

	for(var i=0; i<totalProvs; i++){
		ColumnaOrdenadaProvs[i] = i;
	}

	//12nov19 Es desde dibujaTablaProveedores que llamaremos a prepararTablaProveedores
	//12nov19	dibujaTablaProveedores();
}

function dibujaTablaProveedores()
{

	//solodebug debug('dibujaTablaProveedores ColumnaOrdenacionProvs:'+ColumnaOrdenacionProvs);

	//	12nov19 Si no se ha inicializado la tabla, en este punto lo hacemos
	if (ColumnaOrdenacionProvs=='')
	{
		totalProvs	= arrProveedores.length;
		prepararOrdProveedores();
		OrdenarProvsPorColumna('NombreCorto');
	}

	if(estadoLicitacion == 'EST' || estadoLicitacion == 'COMP' || estadoLicitacion == 'CURS' || estadoLicitacion == 'INF')
	{
		dibujaTablaProveedoresEST();
	}
	else
	{
		dibujaTablaProveedoresADJ();
	}
}

function dibujaTablaProveedoresADJ(){
	var htmlTBODY = '', thisRow = '', thisCell = '' , thisMacro = '', valAux, contLinea = 0;

	//solodebug debug('dibujaTablaProveedoresADJ ColumnaOrdenacionProvs:'+ColumnaOrdenacionProvs);

	// Eliminamos la fila totalConsumo por si existe
	jQuery('#lProveedores_ADJ tfoot').remove();

	if(totalProvs > 0){
		for(var i=0; i<totalProvs; i++)
		{
			if ((arrProveedores[ColumnaOrdenadaProvs[i]].IDEstadoProv=='INF')||(arrProveedores[ColumnaOrdenadaProvs[i]].IDEstadoProv=='ADJ')||(arrProveedores[ColumnaOrdenadaProvs[i]].IDEstadoProv=='FIRM')||(arrProveedores[ColumnaOrdenadaProvs[i]].NumeroLineas>0)||(SoloProvInformados=='N'))
			{
			
				//solodebug	debug('SoloProvInformados:'+SoloProvInformados+' IDEstadoProv:'+arrProveedores[ColumnaOrdenadaProvs[i]].IDEstadoProv);
			
				contLinea++;

				// Iniciamos la fila (tr)
				thisRow = rowStartIDStyle;
				thisRow = thisRow.replace('#ID#', arrProveedores[ColumnaOrdenadaProvs[i]].IDProvLic);
				if(arrProveedores[ColumnaOrdenadaProvs[i]].IDEstadoProv == 'SUS'){
					thisRow = thisRow.replace('#STYLE#', 'background:#fd6c85;border-bottom:1px solid #999;');
				}else if(arrProveedores[ColumnaOrdenadaProvs[i]].IDEstadoProv == 'ADJ' || arrProveedores[ColumnaOrdenadaProvs[i]].IDEstadoProv == 'FIRM'){
					thisRow = thisRow.replace('#STYLE#', 'background:#A8FFA8;border-bottom:1px solid #999;');
				}else{
					thisRow = thisRow.replace('#STYLE#', 'border-bottom:1px solid #999;');
				}

				// Celda/Columna numeracion
				thisCell = cellStart + '&nbsp;' + contLinea + '&nbsp;' + cellEnd;
				thisRow += thisCell;

				// Celda/Columna aviso ofertas vacias y subir contrato
				thisCell = cellStart;
				if(arrProveedores[ColumnaOrdenadaProvs[i]].OfertasVacias == 'S'){
					thisMacro = macroImagen.replace('#SRC#', 'http://www.newco.dev.br/images/change.png');
					thisMacro = thisMacro.replace('#TITLE#', str_provOfertasVacias);
					thisMacro = thisMacro.replace('#ALT#', str_provOfertasVacias);
					thisCell += thisMacro;
     			}
				if(arrProveedores[ColumnaOrdenadaProvs[i]].OfertasAdj > 0){
					thisCell += '&nbsp;' + spanStartID.replace('#ID#', 'contrato_' + arrProveedores[ColumnaOrdenadaProvs[i]].IDProvLic);
					if(arrProveedores[ColumnaOrdenadaProvs[i]].Contrato.ID){
						thisCell += spanStartID.replace('#ID#', 'docContrato_' + arrProveedores[ColumnaOrdenadaProvs[i]].IDProvLic);
						thisCell += macroEnlaceTarget.replace('#HREF#', 'http://www.newco.dev.br/Documentos/' + arrProveedores[ColumnaOrdenadaProvs[i]].Contrato.Url);
						thisCell += macroImagen.replace('#SRC#', 'http://www.newco.dev.br/images/contratoIcon.gif').replace('#TITLE#', str_Contrato).replace('#ALT#', str_Contrato);
						thisCell += macroEnlaceEnd + '&nbsp;';
						thisCell += spanEnd;
					}
					if(isAutor == 'S'){
						functionJS = 'javascript:abrirFormContrato(' + (arrProveedores[ColumnaOrdenadaProvs[i]].linea - 1) + ');'
						thisCell += spanStartID.replace('#ID#', 'subirContrato_' + arrProveedores[ColumnaOrdenadaProvs[i]].IDProvLic);
						thisCell += macroEnlace.replace('#HREF#', functionJS);
						thisCell += macroImagen.replace('#SRC#', 'http://www.newco.dev.br/images/anadirContratoIcon.gif').replace('#TITLE#', str_SubirContrato).replace('#ALT#', str_SubirContrato);
						thisCell += macroEnlaceEnd + '&nbsp;';
						thisCell += spanEnd;
					}
					thisCell += spanEnd;
				}
				thisCell += cellEnd;
				thisRow += thisCell;

				// Celda/Columna Nombre
				thisCell = cellStartClass.replace('#CLASS#', 'datosLeft');
				thisCell += '&nbsp;' + macroEnlace.replace('#HREF#', "javascript:FichaEmpresa(" + arrProveedores[ColumnaOrdenadaProvs[i]].IDProveedor + ",'DOCUMENTOS');");
				thisCell += arrProveedores[ColumnaOrdenadaProvs[i]].NombreCorto;
				thisCell += macroEnlaceEnd;

				//	30ago16 Si hay comentarios, los incluimos aqui
				if((arrProveedores[ColumnaOrdenadaProvs[i]].CommsCdC != '')||(arrProveedores[ColumnaOrdenadaProvs[i]].CommsProv != '')){
					//ET 14dic16	Cambio de estilos para los tooltips
					//ET 14dic16	thisMacro = '&nbsp;' + macroEnlaceAcc.replace('#HREF#', '#');
					thisMacro = '&nbsp;' + divStartClassStyle;	//10dic18	divStartClass;
					thisMacro = thisMacro.replace('#CLASS#', 'tooltip').replace('#STYLE#', 'display: inline-block;');
					thisCell += thisMacro;
					thisCell += '<img src="http://www.newco.dev.br/images/info.gif" class="static"/>';
					//ET 14dic16	thisCell += spanStartClass.replace('#CLASS#', 'classic spanEIS');
					thisCell += spanStartClass.replace('#CLASS#', 'tooltiptext');

					if (arrProveedores[ColumnaOrdenadaProvs[i]].CommsCdC != ''){
						thisCell += 'Com.Cli:'+arrProveedores[ColumnaOrdenadaProvs[i]].CommsCdC;
					}

					if (arrProveedores[ColumnaOrdenadaProvs[i]].CommsProv != ''){
						thisCell += 'Com.:'+arrProveedores[ColumnaOrdenadaProvs[i]].CommsProv;
					}

					thisCell += spanEnd;
					thisCell += macroEnlaceEnd;
				}
				thisCell += cellEnd;
				thisRow += thisCell;

				// Celda/Columna Usuario
				thisCell = cellStartClass.replace('#CLASS#', 'datosLeft');
				thisCell += spanStartID.replace('#ID#', 'mailBox_' + arrProveedores[ColumnaOrdenadaProvs[i]].IDProvLic);
				// Macro Enlace
				thisMacro = macroEnlace2.replace('#HREF#', 'javascript:EnviarMailUsuarioLici(\'' + arrProveedores[ColumnaOrdenadaProvs[i]].IDProvLic + '\',\'' + arrProveedores[ColumnaOrdenadaProvs[i]].IDEstadoProv + '\');');
				thisMacro = thisMacro.replace('#STYLE#', 'text-decoration:none;');
				thisCell += thisMacro;
				// Macro Imagen
				thisMacro = macroImagen.replace('#SRC#', 'http://www.newco.dev.br/images/mail.gif');
				thisMacro = thisMacro.replace('#TITLE#', str_enviarCorreo);
				thisMacro = thisMacro.replace('#ALT#', str_enviarCorreo);
				thisCell += thisMacro;
				thisCell += macroEnlaceEnd;
				thisCell += spanEnd;
				thisCell += '&nbsp;' + arrProveedores[ColumnaOrdenadaProvs[i]].NombreUsuario;
				thisCell += cellEnd;
				thisRow += thisCell;

				// Celda/Columna Conversacion con proveedor
				thisCell = cellStart;
				if(estadoLicitacion != 'CONT'){
					if(isAutor == 'S'){
	//					thisMacro = macroEnlace2.replace('#HREF#', 'javascript:conversacionProveedor(' + arrProveedores[ColumnaOrdenadaProvs[i]].IDProveedor + ', ' + IDUsuario + ', ' + arrProveedores[ColumnaOrdenadaProvs[i]].IDUsuarioProv + ', \'' + arrProveedores[ColumnaOrdenadaProvs[i]].Nombre + '\');');
						thisMacro = macroEnlace2.replace('#HREF#', 'javascript:conversacionProveedor2(' + (arrProveedores[ColumnaOrdenadaProvs[i]].linea - 1) + ');');
						thisMacro = thisMacro.replace('#STYLE#', 'text-decoration:none;');
						thisCell += thisMacro;
						if(arrProveedores[ColumnaOrdenadaProvs[i]].HayConversa == 'S'){
							thisMacro = macroImagen.replace('#SRC#', 'http://www.newco.dev.br/images/2017/mail-blue.png');
							thisMacro = thisMacro.replace('#TITLE#', arrProveedores[ColumnaOrdenadaProvs[i]].UltMensaje);
							thisMacro = thisMacro.replace('#ALT#', arrProveedores[ColumnaOrdenadaProvs[i]].UltMensaje);
						}else{
							thisMacro = macroImagen.replace('#SRC#', 'http://www.newco.dev.br/images/2017/message.png');
							thisMacro = thisMacro.replace('#TITLE#', str_iniciarConversacion);
							thisMacro = thisMacro.replace('#ALT#', str_iniciarConversacion);
						}
						thisCell += thisMacro;
						thisCell += macroEnlaceEnd;
					}else if(isAdmin == 'S' && arrProveedores[ColumnaOrdenadaProvs[i]].HayConversa == 'S'){
	//					thisMacro = macroEnlace2.replace('#HREF#', 'javascript:conversacionProveedor(' + arrProveedores[ColumnaOrdenadaProvs[i]].IDProveedor + ', ' + IDUsuario + ', ' + arrProveedores[ColumnaOrdenadaProvs[i]].IDUsuarioProv + ', \'' + arrProveedores[ColumnaOrdenadaProvs[i]].Nombre + '\');');
						thisMacro = macroEnlace2.replace('#HREF#', 'javascript:conversacionProveedor2(' + (arrProveedores[ColumnaOrdenadaProvs[i]].linea - 1) + ');');
						thisMacro = thisMacro.replace('#STYLE#', 'text-decoration:none;');
						thisCell += thisMacro;
						thisMacro = macroImagen.replace('#SRC#', 'http://www.newco.dev.br/images/2017/mail-blue.png');
						thisMacro = thisMacro.replace('#TITLE#', arrProveedores[ColumnaOrdenadaProvs[i]].UltMensaje);
						thisMacro = thisMacro.replace('#ALT#', arrProveedores[ColumnaOrdenadaProvs[i]].UltMensaje);
						thisCell += thisMacro;
						thisCell += macroEnlaceEnd;
					}
				}
				thisCell += cellEnd;
				thisRow += thisCell;

				// Celda/Columna Fecha Oferta
				thisCell = cellStart + arrProveedores[ColumnaOrdenadaProvs[i]].FechaOferta + cellEnd;
				thisRow += thisCell;

				// Celda/Columna Evaluacion
				thisCell = cellStart;
				if(arrProveedores[ColumnaOrdenadaProvs[i]].IDEstadoEval == 'NOAPTO'){
					thisMacro = macroImagen.replace('#SRC#', 'http://www.newco.dev.br/images/bolaRoja.gif');
					thisMacro = thisMacro.replace('#TITLE#', str_provNoApto);
					thisMacro = thisMacro.replace('#ALT#', str_provNoApto);
				}else if(arrProveedores[ColumnaOrdenadaProvs[i]].IDEstadoEval == 'PEND'){
					thisMacro = macroImagen.replace('#SRC#', 'http://www.newco.dev.br/images/bolaAmbar.gif');
					thisMacro = thisMacro.replace('#TITLE#', str_provPendiente);
					thisMacro = thisMacro.replace('#ALT#', str_provPendiente);
				}else{
					thisMacro = macroImagen.replace('#SRC#', 'http://www.newco.dev.br/images/bolaVerde.gif');
					thisMacro = thisMacro.replace('#TITLE#', str_provApto);
					thisMacro = thisMacro.replace('#ALT#', str_provApto);
				}
				thisCell += thisMacro;
				thisCell += cellEnd;
				thisRow += thisCell;

				// Celda/Columna Estado Ofertas
				thisCell = cellStart + arrProveedores[ColumnaOrdenadaProvs[i]].EstadoProv + cellEnd;
				thisRow += thisCell;

				// Celda/Columna Consumo
				thisCell = cellStartClass.replace('#CLASS#', 'datosRight');
				if(mostrarPrecioIVA == 'S'){
					thisCell += arrProveedores[ColumnaOrdenadaProvs[i]].ConsumoProvIVA + '&nbsp;';
				}else{
					thisCell += arrProveedores[ColumnaOrdenadaProvs[i]].ConsumoProv + '&nbsp;';
				}
				thisCell += cellEnd;
				thisRow += thisCell;

				// Celda/Columna Adjudicado
				thisCell = cellStartClass.replace('#CLASS#', 'datosRight');
				if(mostrarPrecioIVA == 'S'){
					thisCell += arrProveedores[ColumnaOrdenadaProvs[i]].ConsumoAdjIVA + '&nbsp;';
				}else{
					thisCell += arrProveedores[ColumnaOrdenadaProvs[i]].ConsumoAdj + '&nbsp;';
				}
				thisCell += cellEnd;
				thisRow += thisCell;

				// Celda/Columna Ahorro
				thisCell = cellStartClass.replace('#CLASS#', 'datosRight');
				if(mostrarPrecioIVA == 'S'){
					valAux = arrProveedores[ColumnaOrdenadaProvs[i]].AhorroIVA.replace(',', '.');
					if(arrProveedores[ColumnaOrdenadaProvs[i]].ConsumoProvIVA != ''){
						if(valAux == 0){
							thisCell += spanStartStyle.replace('#STYLE#', 'color:orange;font-weight:bold;');
						}else if(valAux < 0){
							thisCell += spanStartStyle.replace('#STYLE#', 'color:red;font-weight:bold;');
						}else if(valAux > 0){
							thisCell += spanStartStyle.replace('#STYLE#', 'color:green;font-weight:bold;');
						}
						thisCell += arrProveedores[ColumnaOrdenadaProvs[i]].AhorroIVA + '%';
						thisCell += spanEnd + '&nbsp;';
					}
				}else{
					valAux = arrProveedores[ColumnaOrdenadaProvs[i]].Ahorro.replace(',', '.');
					if(arrProveedores[ColumnaOrdenadaProvs[i]].ConsumoProv != ''){
						if(valAux == 0){
							thisCell += spanStartStyle.replace('#STYLE#', 'color:orange;font-weight:bold;');
						}else if(valAux < 0){
							thisCell += spanStartStyle.replace('#STYLE#', 'color:red;font-weight:bold;');
						}else if(valAux > 0){
							thisCell += spanStartStyle.replace('#STYLE#', 'color:green;font-weight:bold;');
						}
						thisCell += arrProveedores[ColumnaOrdenadaProvs[i]].Ahorro + '%';
						thisCell += spanEnd + '&nbsp;';
					}
				}
				thisCell += cellEnd;
				thisRow += thisCell;

				// Celda/Columna Pedido Minimo
				thisCell = cellStart;
				thisCell += arrProveedores[ColumnaOrdenadaProvs[i]].PedidoMin;
				thisCell += cellEnd;
				thisRow += thisCell;

				// Celda/Columna Num. Productos
				thisCell = cellStart;
				if (arrProveedores[ColumnaOrdenadaProvs[i]].NumeroLineas!=''){	//	31ago16 Solo si está informado
					thisCell += arrProveedores[ColumnaOrdenadaProvs[i]].OfertasAdj + '/' + arrProveedores[ColumnaOrdenadaProvs[i]].NumeroLineas;
				}
				thisCell += cellEnd;
				thisRow += thisCell;

				// Celda/Columna Acciones
				thisCell = cellStart;
				// Botones para imprimir oferta y descargar excel (para todos los usuarios)
				if(arrProveedores[ColumnaOrdenadaProvs[i]].IDEstadoProv != 'CURS' && arrProveedores[ColumnaOrdenadaProvs[i]].IDEstadoProv != 'SUS'){
					thisMacro = macroEnlace3.replace('#CLASS#', 'accImprimir');
					thisMacro = thisMacro.replace('#HREF#', 'javascript:imprimirOferta(' + arrProveedores[ColumnaOrdenadaProvs[i]].IDProvLic + ');');
					thisMacro = thisMacro.replace('#STYLE#', 'text-decoration:none;');
					thisCell += thisMacro;
					thisMacro = macroImagen.replace('#SRC#', 'http://www.newco.dev.br/images/2017/print.png');//5abr18	'http://www.newco.dev.br/images/imprimir.gif'
					thisMacro = thisMacro.replace('#ALT#', str_ImprimirOferta);
					thisMacro = thisMacro.replace('#TITLE#', str_ImprimirOferta);
					thisCell += thisMacro;
					thisCell += macroEnlaceEnd + '&nbsp;';

					thisMacro = macroEnlace3.replace('#CLASS#', 'accExcel');
					thisMacro = thisMacro.replace('#HREF#', 'javascript:listadoExcel(' + arrProveedores[ColumnaOrdenadaProvs[i]].IDProvLic + ');');
					thisMacro = thisMacro.replace('#STYLE#', 'text-decoration:none;');
					thisCell += thisMacro;
					thisMacro = macroImagen.replace('#SRC#', 'http://www.newco.dev.br/images/2017/excel.png');//5abr18	'http://www.newco.dev.br/images/iconoExcel.gif'
					thisMacro = thisMacro.replace('#ALT#', str_ListadoExcel);
					thisMacro = thisMacro.replace('#TITLE#', str_ListadoExcel);
					thisCell += thisMacro;
					thisCell += macroEnlaceEnd + '&nbsp;';
				}
				thisCell += cellEnd;
				thisRow += thisCell;

				thisRow += rowEnd;
				htmlTBODY += thisRow;
			}
		}

		if(estadoLicitacion == 'ADJ' || estadoLicitacion == 'FIRM' || estadoLicitacion == 'CONT'){
			dibujarFilaConsumoProvADJ();
		}
	}else{
		htmlTBODY = "<tr><td colspan=\"16\" align=\"center\"><strong>" + str_licSinProveedores + "</strong></td></tr>";
	}

	jQuery('#lProveedores_ADJ tbody').empty().append(htmlTBODY);
}

function dibujaTablaProveedoresEST(){
	var htmlTBODY = '', thisRow = '', thisCell = '' , thisMacro = '', valAux, contLinea = 0;

	//solodebug debug('dibujaTablaProveedoresADJ ColumnaOrdenacionProvs:'+ColumnaOrdenacionProvs);

	// Eliminamos la fila totalConsumo por si existe
	jQuery('#lProveedores_EST tfoot').remove();

	if(totalProvs > 0){
		for(var i=0; i<totalProvs; i++)
		{
			if ((arrProveedores[ColumnaOrdenadaProvs[i]].IDEstadoProv=='INF')||(arrProveedores[ColumnaOrdenadaProvs[i]].IDEstadoProv=='ADJ')||(arrProveedores[ColumnaOrdenadaProvs[i]].IDEstadoProv=='FIRM')||(arrProveedores[ColumnaOrdenadaProvs[i]].NumeroLineas>0)||(SoloProvInformados=='N'))
			{
			
				//solodebug	debug('SoloProvInformados:'+SoloProvInformados+' IDEstadoProv:'+arrProveedores[ColumnaOrdenadaProvs[i]].IDEstadoProv);
			
		
				contLinea++;

				//solodebug	27set17	debug(arrProveedores[ColumnaOrdenadaProvs[i]].IDProveedor+':'+arrProveedores[ColumnaOrdenadaProvs[i]].NombreCorto+':'+arrProveedores[ColumnaOrdenadaProvs[i]].NivelDocumentacion);


				// Iniciamos la fila (tr)
				thisRow = rowStartStyle;
				if(arrProveedores[ColumnaOrdenadaProvs[i]].IDEstadoProv == 'SUS'){
					thisRow = thisRow.replace('#STYLE#', 'background:#CC0000;border-bottom:1px solid #999;');
				}else{
					thisRow = thisRow.replace('#STYLE#', 'border-bottom:1px solid #999;');	//	9set16	Ponemos linea inferior
				}

				// Celda/Columna numeracion
				//29ago16	Si estamos en Brasil mostramos un fondo de color en función del nivel de documentación del proveedor
				if ((IDPais==55)&&(arrProveedores[ColumnaOrdenadaProvs[i]].IDEstadoProv != 'SUS')){
					if (arrProveedores[ColumnaOrdenadaProvs[i]].NivelDocumentacion=='R'){
						thisCell = cellStartStyle.replace('#STYLE#','background:#CC0000;')
									 + '&nbsp;' + contLinea + '&nbsp;' + cellEnd;
					}
					else if (arrProveedores[ColumnaOrdenadaProvs[i]].NivelDocumentacion=='A'){
						thisCell = cellStartStyle.replace('#STYLE#','background:#F57900;')
									 + '&nbsp;' + contLinea + '&nbsp;' + cellEnd;
					}
					else if (arrProveedores[ColumnaOrdenadaProvs[i]].NivelDocumentacion=='V'){
						thisCell = cellStartStyle.replace('#STYLE#','background:#4E9A06;')
									 + '&nbsp;' + contLinea + '&nbsp;' + cellEnd;
					}
					else{
						thisCell = cellStart + '&nbsp;' + contLinea + '&nbsp;' + cellEnd;
					}
				}
				else
				{
					thisCell = cellStart + '&nbsp;' + contLinea + '&nbsp;' + cellEnd;
				}
				thisRow += thisCell;

				// Celda/Columna aviso ofertas vacias
				thisCell = cellStart;
				if(arrProveedores[ColumnaOrdenadaProvs[i]].OfertasVacias == 'S'){
					thisMacro = macroImagen.replace('#SRC#', 'http://www.newco.dev.br/images/change.png');
					thisMacro = thisMacro.replace('#TITLE#', str_provOfertasVacias);
					thisMacro = thisMacro.replace('#ALT#', str_provOfertasVacias);
					thisCell += thisMacro;
                        	}
				thisCell += cellEnd;
				thisRow += thisCell;

				// Celda/Columna Nombre
				thisCell = cellStartClass.replace('#CLASS#', 'datosLeft');
				thisCell += '&nbsp;<img src="http://www.newco.dev.br/images/StarSmall'+arrProveedores[ColumnaOrdenadaProvs[i]].Estrellas+'.png" class="static"/>&nbsp;'+macroEnlace.replace("#HREF#", "javascript:FichaEmpresa(" + arrProveedores[ColumnaOrdenadaProvs[i]].IDProveedor + ",'DOCUMENTOS');");
				thisCell += arrProveedores[ColumnaOrdenadaProvs[i]].NombreCorto;
				thisCell += macroEnlaceEnd;
				if (arrProveedores[ColumnaOrdenadaProvs[i]].IDDocumento!='')
				{
					thisCell += '&nbsp;<a href="javascript:VerDocumento('+arrProveedores[ColumnaOrdenadaProvs[i]].IDDocumento+');"><img src="http://www.newco.dev.br/images/2020/Documento.png" class="static"/></a>&nbsp;';
				}

				//	30ago16 Si hay comentarios, los incluimos aqui
				if((arrProveedores[ColumnaOrdenadaProvs[i]].CommsCdC != '')||(arrProveedores[ColumnaOrdenadaProvs[i]].CommsProv != '')){
					//ET 14dic16	Cambio de estilos para los tooltips
					//ET 14dic16	thisMacro = '&nbsp;' + macroEnlaceAcc.replace('#HREF#', '#');
					thisMacro = '&nbsp;' + divStartClassStyle;	//10dic18	divStartClass;
					thisMacro = thisMacro.replace('#CLASS#', 'tooltip').replace('#STYLE#', 'display: inline-block;');
					thisCell += thisMacro;
					thisCell += '<img src="http://www.newco.dev.br/images/info.gif" class="static"/>';
					//ET 14dic16	thisCell += spanStartClass.replace('#CLASS#', 'classic spanEIS');
					thisCell += spanStartClass.replace('#CLASS#', 'tooltiptext');

					if (arrProveedores[ColumnaOrdenadaProvs[i]].CommsCdC != ''){
						thisCell += 'Com.Cli:'+arrProveedores[ColumnaOrdenadaProvs[i]].CommsCdC;
					}

					if (arrProveedores[ColumnaOrdenadaProvs[i]].CommsProv != ''){
						thisCell += 'Com.:'+arrProveedores[ColumnaOrdenadaProvs[i]].CommsProv;
					}

					thisCell += spanEnd;
					thisCell += macroEnlaceEnd;
				}
				thisCell += cellEnd;
				thisRow += thisCell;

				// Celda/Columna Usuario
				thisCell = cellStartClass.replace('#CLASS#', 'datosLeft');
				thisCell += spanStartID.replace('#ID#', 'mailBox_' + arrProveedores[ColumnaOrdenadaProvs[i]].IDProvLic);
				// Macro Enlace
				thisMacro = macroEnlace2.replace('#HREF#', 'javascript:EnviarMailUsuarioLici(\'' + arrProveedores[ColumnaOrdenadaProvs[i]].IDProvLic + '\',\'' + arrProveedores[ColumnaOrdenadaProvs[i]].IDEstadoProv + '\');');
				thisMacro = thisMacro.replace('#STYLE#', 'text-decoration:none;');
				thisCell += thisMacro;
				// Macro Imagen
				thisMacro = macroImagen.replace('#SRC#', 'http://www.newco.dev.br/images/mail.gif');
				thisMacro = thisMacro.replace('#TITLE#', str_enviarCorreo);
				thisMacro = thisMacro.replace('#ALT#', str_enviarCorreo);
				thisCell += thisMacro;
				thisCell += macroEnlaceEnd;
				thisCell += spanEnd;
				thisCell += '&nbsp;' + arrProveedores[ColumnaOrdenadaProvs[i]].NombreUsuario;

				if(isAutor == 'S' /*&& estadoLicitacion != 'EST'*/){
					thisCell += '&nbsp;' + spanStartID.replace('#ID#', 'nuevoUsu_' + (arrProveedores[ColumnaOrdenadaProvs[i]].linea - 1));
					// Macro Enlace
					thisMacro = macroEnlace2.replace('#HREF#', 'javascript:abrirBoxNuevoUsuario(' + (arrProveedores[ColumnaOrdenadaProvs[i]].linea - 1) + ');');
					thisMacro = thisMacro.replace('#STYLE#', 'text-decoration:none;');
					thisCell += thisMacro;
					// Macro Imagen
					thisMacro = macroImagen.replace('#SRC#', 'http://www.newco.dev.br/images/boliIcon.gif');
					thisMacro = thisMacro.replace('#TITLE#', str_cambiarUsuario);
					thisMacro = thisMacro.replace('#ALT#', str_cambiarUsuario);
					thisCell += thisMacro;
					thisCell += macroEnlaceEnd;
					thisCell += spanEnd;
				}

				thisCell += cellEnd;
				thisRow += thisCell;

				// Celda/Columna Conversacion con proveedor
				thisCell = cellStart;
				if(estadoLicitacion != 'EST'){
					if(isAutor == 'S'){
	//					thisMacro = macroEnlace2.replace('#HREF#', 'javascript:conversacionProveedor(' + arrProveedores[ColumnaOrdenadaProvs[i]].IDProveedor + ', ' + IDUsuario + ', ' + arrProveedores[ColumnaOrdenadaProvs[i]].IDUsuarioProv + ', \'' + arrProveedores[ColumnaOrdenadaProvs[i]].Nombre + '\');');
						thisMacro = macroEnlace2.replace('#HREF#', 'javascript:conversacionProveedor2(' + (arrProveedores[ColumnaOrdenadaProvs[i]].linea - 1) + ');');
						thisMacro = thisMacro.replace('#STYLE#', 'text-decoration:none;');
						thisCell += thisMacro;
						if(arrProveedores[ColumnaOrdenadaProvs[i]].HayConversa == 'S'){
							thisMacro = macroImagen.replace('#SRC#', 'http://www.newco.dev.br/images/2017/mail-blue.png');//5abr18	'http://www.newco.dev.br/images/bocadillo.gif'
							thisMacro = thisMacro.replace('#TITLE#', arrProveedores[ColumnaOrdenadaProvs[i]].UltMensaje);
							thisMacro = thisMacro.replace('#ALT#', arrProveedores[ColumnaOrdenadaProvs[i]].UltMensaje);
						}else{
							thisMacro = macroImagen.replace('#SRC#', 'http://www.newco.dev.br/images/2017/message.png');//5abr18	'http://www.newco.dev.br/images/bocadilloPlus.gif'
							thisMacro = thisMacro.replace('#TITLE#', str_iniciarConversacion);
							thisMacro = thisMacro.replace('#ALT#', str_iniciarConversacion);
						}
						thisCell += thisMacro;
						thisCell += macroEnlaceEnd;
					}else if(isAdmin == 'S' && arrProveedores[ColumnaOrdenadaProvs[i]].HayConversa == 'S'){
	//					thisMacro = macroEnlace2.replace('#HREF#', 'javascript:conversacionProveedor(' + arrProveedores[ColumnaOrdenadaProvs[i]].IDProveedor + ', ' + IDUsuario + ', ' + arrProveedores[ColumnaOrdenadaProvs[i]].IDUsuarioProv + ', \'' + arrProveedores[ColumnaOrdenadaProvs[i]].Nombre + '\');');
						thisMacro = macroEnlace2.replace('#HREF#', 'javascript:conversacionProveedor2(' + (arrProveedores[ColumnaOrdenadaProvs[i]].linea - 1) + ');');
						thisMacro = thisMacro.replace('#STYLE#', 'text-decoration:none;');
						thisCell += thisMacro;
						thisMacro = macroImagen.replace('#SRC#', 'http://www.newco.dev.br/images/2017/mail-blue.png');//5abr18	'http://www.newco.dev.br/images/bocadillo.gif'
						thisMacro = thisMacro.replace('#TITLE#', arrProveedores[ColumnaOrdenadaProvs[i]].UltMensaje);
						thisMacro = thisMacro.replace('#ALT#', arrProveedores[ColumnaOrdenadaProvs[i]].UltMensaje);
						thisCell += thisMacro;
						thisCell += macroEnlaceEnd;
					}
				}
				thisCell += cellEnd;
				thisRow += thisCell;

				// Celda/Columna Fecha Oferta
				thisCell = cellStart + arrProveedores[ColumnaOrdenadaProvs[i]].FechaOferta + cellEnd;
				thisRow += thisCell;

				// Celda/Columna Evaluacion
				thisCell = cellStart;
				if(arrProveedores[ColumnaOrdenadaProvs[i]].IDEstadoEval == 'NOAPTO'){
					thisMacro = macroImagen.replace('#SRC#', 'http://www.newco.dev.br/images/bolaRoja.gif');
					thisMacro = thisMacro.replace('#TITLE#', str_provNoApto);
					thisMacro = thisMacro.replace('#ALT#', str_provNoApto);
				}else if(arrProveedores[ColumnaOrdenadaProvs[i]].IDEstadoEval == 'PEND'){
					thisMacro = macroImagen.replace('#SRC#', 'http://www.newco.dev.br/images/bolaAmbar.gif');
					thisMacro = thisMacro.replace('#TITLE#', str_provPendiente);
					thisMacro = thisMacro.replace('#ALT#', str_provPendiente);
				}else{
					thisMacro = macroImagen.replace('#SRC#', 'http://www.newco.dev.br/images/bolaVerde.gif');
					thisMacro = thisMacro.replace('#TITLE#', str_provApto);
					thisMacro = thisMacro.replace('#ALT#', str_provApto);
				}
				thisCell += thisMacro;
				thisCell += cellEnd;
				thisRow += thisCell;

				// Celda/Columna Estado Ofertas
				thisCell = cellStart + arrProveedores[ColumnaOrdenadaProvs[i]].EstadoProv + cellEnd;
				thisRow += thisCell;

				/*	30ago16	Si hay comentarios, los concatenamos junto al nombre del proveedor
				// Celda/Columna Comentarios CdC
				thisCell = cellStart;
				if(arrProveedores[ColumnaOrdenadaProvs[i]].CommsCdC != ''){
					thisMacro = macroEnlaceAcc.replace('#HREF#', '#');
					thisMacro = thisMacro.replace('#CLASS#', 'tooltip');
					thisCell += thisMacro;
					thisCell += '<img src="http://www.newco.dev.br/images/info.gif" class="static"/>';
					thisCell += spanStartClass.replace('#CLASS#', 'classic spanEIS');
					thisCell += arrProveedores[ColumnaOrdenadaProvs[i]].CommsCdC;
					thisCell += spanEnd;
					thisCell += macroEnlaceEnd;
				}//else{
	//				thisCell += arrProveedores[ColumnaOrdenadaProvs[i]].CommsCdC;
	//			}
				thisCell += cellEnd;
				thisRow += thisCell;

				// Celda/Columna Comentarios Proveedor
				thisCell = cellStart;
				if(arrProveedores[ColumnaOrdenadaProvs[i]].CommsProv != ''){
					thisMacro = macroEnlaceAcc.replace('#HREF#', '#');
					thisMacro = thisMacro.replace('#CLASS#', 'tooltip');
					thisCell += thisMacro;
					thisCell += '<img src="http://www.newco.dev.br/images/info.gif" class="static"/>';
					thisCell += spanStartClass.replace('#CLASS#', 'classic spanEIS');
					thisCell += arrProveedores[ColumnaOrdenadaProvs[i]].CommsProv;
					thisCell += spanEnd;
					thisCell += macroEnlaceEnd;
				}//else{
	//				thisCell += arrProveedores[ColumnaOrdenadaProvs[i]].CommsProv;
	//			}
				thisCell += cellEnd;
				thisRow += thisCell;
				*/

				// Celda/Columna Num. Productos Mejor Precio
				thisCell = cellStart;
				thisCell += arrProveedores[ColumnaOrdenadaProvs[i]].OfeMejPrecio;
				thisCell += cellEnd;
				thisRow += thisCell;

				// Celda/Columna Num. Productos Oferta Ahorro
				thisCell = cellStart;
				thisCell += arrProveedores[ColumnaOrdenadaProvs[i]].OfeConAhorro;
				thisCell += cellEnd;
				thisRow += thisCell;

				// Celda/Columna Num. Productos
				thisCell = cellStart;
				thisCell += arrProveedores[ColumnaOrdenadaProvs[i]].NumeroLineas;
				thisCell += cellEnd;
				thisRow += thisCell;

				/*	6jul16	Quitamos estos campos que son poco útiles y añadimos la info de frete (solo Brasil) y plazo de entrega	
				// Celda/Columna Consumo Mejor Precio
				thisCell = cellStartClass.replace('#CLASS#', 'datosRight');
				if(mostrarPrecioIVA == 'S'){
					thisCell += arrProveedores[ColumnaOrdenadaProvs[i]].ConsMejPrecIVA + '&nbsp;';
				}else{
					thisCell += arrProveedores[ColumnaOrdenadaProvs[i]].ConsMejPrecio + '&nbsp;';
				}
				thisCell += cellEnd;
				thisRow += thisCell;

				// Celda/Columna Consumo Oferta Ahorro
				thisCell = cellStartClass.replace('#CLASS#', 'datosRight');
				if(mostrarPrecioIVA == 'S'){
					thisCell += arrProveedores[ColumnaOrdenadaProvs[i]].ConsConAhorIVA + '&nbsp;';
				}else{
					thisCell += arrProveedores[ColumnaOrdenadaProvs[i]].ConsConAhorro + '&nbsp;';
				}
				thisCell += cellEnd;
				thisRow += thisCell;
				*/

				// 6jul16	Celda/Columna Frete (solo para Brasil)
				if (IDPais==55)
				{
					thisCell = cellStart;
					thisCell += arrProveedores[ColumnaOrdenadaProvs[i]].Frete;
					thisCell += cellEnd;
					thisRow += thisCell;
				}

				// Celda/Columna Plazo de entrega
				thisCell = cellStart;
				thisCell += arrProveedores[ColumnaOrdenadaProvs[i]].PlazoEntrega;
				thisCell += cellEnd;
				thisRow += thisCell;

				// Celda/Columna Consumo
				thisCell = cellStartClass.replace('#CLASS#', 'datosRight');
				if(mostrarPrecioIVA == 'S'){
					thisCell += arrProveedores[ColumnaOrdenadaProvs[i]].ConsumoProvIVA + '&nbsp;';
				}else{
					thisCell += arrProveedores[ColumnaOrdenadaProvs[i]].ConsumoProv + '&nbsp;';
				}
				thisCell += cellEnd;
				thisRow += thisCell;

				// Celda/Columna Ahorro Mejor Precio
				thisCell = cellStartClass.replace('#CLASS#', 'datosRight');
				if ( arrProveedores[ColumnaOrdenadaProvs[i]].AhorMejPrecio!=''){		//	31ago16	solo mostramos el ahorro si está informado
					thisCell += arrProveedores[ColumnaOrdenadaProvs[i]].AhorMejPrecio + '%&nbsp;';
				}
				thisCell += cellEnd;
				thisRow += thisCell;

				// Celda/Columna Ahorro Oferta Ahorro
				thisCell = cellStartClass.replace('#CLASS#', 'datosRight');
				if ( arrProveedores[ColumnaOrdenadaProvs[i]].AhorOfeConAhor!=''){		//	31ago16	solo mostramos el ahorro si está informado
					thisCell += arrProveedores[ColumnaOrdenadaProvs[i]].AhorOfeConAhor + '%&nbsp;';
				}
				thisCell += cellEnd;
				thisRow += thisCell;

				// Celda/Columna Ahorro
				thisCell = cellStartClass.replace('#CLASS#', 'datosRight');
				if(mostrarPrecioIVA == 'S'){
					if(arrProveedores[ColumnaOrdenadaProvs[i]].ConsumoProvIVA != ''){
						thisCell += arrProveedores[ColumnaOrdenadaProvs[i]].AhorroIVA + '%&nbsp;';
					}
				}else{
					if(arrProveedores[ColumnaOrdenadaProvs[i]].ConsumoProv != ''){
						thisCell += arrProveedores[ColumnaOrdenadaProvs[i]].Ahorro + '%&nbsp;';
					}
				}
				thisCell += cellEnd;
				thisRow += thisCell;

	/* DC - 20mar15 - Los colores son enganyosos
				// Celda/Columna Ahorro
				thisCell = cellStartClass.replace('#CLASS#', 'datosRight');
				if(mostrarPrecioIVA == 'S'){
					valAux = arrProveedores[ColumnaOrdenadaProvs[i]].AhorroIVA.replace(',', '.');
					if(arrProveedores[ColumnaOrdenadaProvs[i]].ConsumoProvIVA != ''){
						if(valAux == 0){
							thisCell += spanStartStyle.replace('#STYLE#', 'color:orange;font-weight:bold;');
						}else if(valAux < 0){
							thisCell += spanStartStyle.replace('#STYLE#', 'color:red;font-weight:bold;');
						}else if(valAux > 0){
							thisCell += spanStartStyle.replace('#STYLE#', 'color:green;font-weight:bold;');
						}
						thisCell += arrProveedores[ColumnaOrdenadaProvs[i]].AhorroIVA + '%';
						thisCell += spanEnd + '&nbsp;';
					}
				}else{
					valAux = arrProveedores[ColumnaOrdenadaProvs[i]].Ahorro.replace(',', '.');
					if(arrProveedores[ColumnaOrdenadaProvs[i]].ConsumoProv != ''){
						if(valAux == 0){
							thisCell += spanStartStyle.replace('#STYLE#', 'color:orange;font-weight:bold;');
						}else if(valAux < 0){
							thisCell += spanStartStyle.replace('#STYLE#', 'color:red;font-weight:bold;');
						}else if(valAux > 0){
							thisCell += spanStartStyle.replace('#STYLE#', 'color:green;font-weight:bold;');
						}
						thisCell += arrProveedores[ColumnaOrdenadaProvs[i]].Ahorro + '%';
						thisCell += spanEnd + '&nbsp;';
					}
				}
				thisCell += cellEnd;
				thisRow += thisCell;
	*/

				// Celda/Columna Pedido Minimo
				thisCell = cellStart;
				thisCell += arrProveedores[ColumnaOrdenadaProvs[i]].PedidoMin;
				thisCell += cellEnd;
				thisRow += thisCell;

				// Celda/Columna Acciones
				thisCell = cellStart;
				if(isAutor == 'S'){
					if((estadoLicitacion == 'EST')||(estadoLicitacion == 'COMP')){
						if(arrProveedores[ColumnaOrdenadaProvs[i]].IDEstadoProv == 'SUS'){
							thisMacro = macroEnlace3.replace('#CLASS#', 'accRollBack');
							thisMacro = thisMacro.replace('#HREF#', 'javascript:modificaEstadoProveedor(' + arrProveedores[ColumnaOrdenadaProvs[i]].IDProvLic + ', \'CURS\');');
							thisMacro = thisMacro.replace('#STYLE#', 'text-decoration:none;');
							thisCell += thisMacro;
							thisMacro = macroImagen.replace('#SRC#', 'http://www.newco.dev.br/images/2017/reload.png');//'http://www.newco.dev.br/images/rollbackVerde.gif'
							thisMacro = thisMacro.replace('#ALT#', str_Activar);
							thisMacro = thisMacro.replace('#TITLE#', str_Activar);
							thisCell += thisMacro;
							thisCell += macroEnlaceEnd + '&nbsp;';
						}else{
							thisMacro = macroEnlace3.replace('#CLASS#', 'accSus');
							thisMacro = thisMacro.replace('#HREF#', 'javascript:modificaEstadoProveedor(' + arrProveedores[ColumnaOrdenadaProvs[i]].IDProvLic + ', \'SUS\');');
							thisMacro = thisMacro.replace('#STYLE#', 'text-decoration:none;');
							thisCell += thisMacro;
							thisMacro = macroImagen.replace('#SRC#', 'http://www.newco.dev.br/images/suspender.gif');
							thisMacro = thisMacro.replace('#ALT#', str_SuspenderOferta);
							thisMacro = thisMacro.replace('#TITLE#', str_SuspenderOferta);
							thisCell += thisMacro;
							thisCell += macroEnlaceEnd + '&nbsp;';
						}

						thisMacro = macroEnlace3.replace('#CLASS#', 'accBorrar');
						thisMacro = thisMacro.replace('#HREF#', 'javascript:eliminarProveedor(' + arrProveedores[ColumnaOrdenadaProvs[i]].IDProvLic + ', ' + arrProveedores[ColumnaOrdenadaProvs[i]].IDUsuarioProv + ');');
						thisMacro = thisMacro.replace('#STYLE#', 'text-decoration:none;');
						thisCell += thisMacro;
						thisMacro = macroImagen.replace('#SRC#', 'http://www.newco.dev.br/images/2017/trash.png');
						thisMacro = thisMacro.replace('#ALT#', str_borrar);
						thisMacro = thisMacro.replace('#TITLE#', str_borrar);
						thisCell += thisMacro;
						thisCell += macroEnlaceEnd + '&nbsp;';
					}else if(estadoLicitacion == 'CURS'){
						if(arrProveedores[ColumnaOrdenadaProvs[i]].IDEstadoProv == 'SUS')
						{
							thisMacro = macroEnlace3.replace('#CLASS#', 'accRollBack');
							thisMacro = thisMacro.replace('#HREF#', 'javascript:modificaEstadoProveedor(' + arrProveedores[ColumnaOrdenadaProvs[i]].IDProvLic + ', \'CURS\');');
							thisMacro = thisMacro.replace('#STYLE#', 'text-decoration:none;');
							thisCell += thisMacro;
							thisMacro = macroImagen.replace('#SRC#', 'http://www.newco.dev.br/images/2017/reload.png');//'http://www.newco.dev.br/images/rollbackVerde.gif'
							thisMacro = thisMacro.replace('#ALT#', str_Activar);
							thisMacro = thisMacro.replace('#TITLE#', str_Activar);
							thisCell += thisMacro;
							thisCell += macroEnlaceEnd + '&nbsp;';
						}
						else if(arrProveedores[ColumnaOrdenadaProvs[i]].IDEstadoProv == 'INF')
						{
							//	19feb20 ocultamos para licitaciones continuas, pero desde Brasil nos comentan que les reuslta útil para que aparezca en la página de INICIO del proveedor
							thisMacro = macroEnlace3.replace('#CLASS#', 'accRollBack');
							thisMacro = thisMacro.replace('#HREF#', 'javascript:modificaEstadoProveedor(' + arrProveedores[ColumnaOrdenadaProvs[i]].IDProvLic + ', \'CURS\');');
							thisMacro = thisMacro.replace('#STYLE#', 'text-decoration:none;');
							thisCell += thisMacro;
							thisMacro = macroImagen.replace('#SRC#', 'http://www.newco.dev.br/images/2017/reload.png');//'http://www.newco.dev.br/images/rollbackVerde.gif'
							thisMacro = thisMacro.replace('#ALT#', str_Rollback);
							thisMacro = thisMacro.replace('#TITLE#', str_Rollback);
							thisCell += thisMacro;
							thisCell += macroEnlaceEnd + '&nbsp;';

							// Si no es licitacion por producto, se adjudica desde pestanya proveedores
							if(isLicPorProducto == ''){
								thisMacro = macroEnlace3.replace('#CLASS#', 'accAdjud');
								thisMacro = thisMacro.replace('#HREF#', 'javascript:modificaEstadoProveedor(' + arrProveedores[ColumnaOrdenadaProvs[i]].IDProvLic + ', \'ADJ\');');
								thisMacro = thisMacro.replace('#STYLE#', 'text-decoration:none;');
								thisCell += thisMacro;
								thisMacro = macroImagen.replace('#ALT#', str_Adjudicar);
								thisMacro = thisMacro.replace('#TITLE#', str_Adjudicar);
								if(IDPais == 55){
									thisMacro = thisMacro.replace('#SRC#', 'http://www.newco.dev.br/images/adjudicarProve-BR.gif');
                                                        	}else{
									thisMacro = thisMacro.replace('#SRC#', 'http://www.newco.dev.br/images/adjudicarProve.gif');
                                                        	}
								thisCell += thisMacro;
								thisCell += macroEnlaceEnd + '&nbsp;';
							}
						}
						else
						{
							thisMacro = macroEnlace3.replace('#CLASS#', 'accSus');
							thisMacro = thisMacro.replace('#HREF#', 'javascript:modificaEstadoProveedor(' + arrProveedores[ColumnaOrdenadaProvs[i]].IDProvLic + ', \'SUS\');');
							thisMacro = thisMacro.replace('#STYLE#', 'text-decoration:none;');
							thisCell += thisMacro;
							thisMacro = macroImagen.replace('#SRC#', 'http://www.newco.dev.br/images/suspender.gif');
							thisMacro = thisMacro.replace('#ALT#', str_SuspenderOferta);
							thisMacro = thisMacro.replace('#TITLE#', str_SuspenderOferta);
							thisCell += thisMacro;
							thisCell += macroEnlaceEnd + '&nbsp;';
						}
					}else if(estadoLicitacion == 'INF'){
						if(arrProveedores[ColumnaOrdenadaProvs[i]].IDEstadoProv == 'SUS'){
							thisMacro = macroEnlace3.replace('#CLASS#', 'accRollBack');
							thisMacro = thisMacro.replace('#HREF#', 'javascript:modificaEstadoProveedor(' + arrProveedores[ColumnaOrdenadaProvs[i]].IDProvLic + ', \'CURS\');');
							thisMacro = thisMacro.replace('#STYLE#', 'text-decoration:none;');
							thisCell += thisMacro;
							thisMacro = macroImagen.replace('#SRC#', 'http://www.newco.dev.br/images/2017/reload.png');//'http://www.newco.dev.br/images/rollbackVerde.gif'
							thisMacro = thisMacro.replace('#ALT#', str_Activar);
							thisMacro = thisMacro.replace('#TITLE#', str_Activar);
							thisCell += thisMacro;
							thisCell += macroEnlaceEnd + '&nbsp;';
						}else if(arrProveedores[ColumnaOrdenadaProvs[i]].IDEstadoProv == 'INF'){// Si el prov ha informado oferta, se puede volver atras para pedir otra oferta
							thisMacro = macroEnlace3.replace('#CLASS#', 'accRollBack');
							thisMacro = thisMacro.replace('#HREF#', 'javascript:modificaEstadoProveedor(' + arrProveedores[ColumnaOrdenadaProvs[i]].IDProvLic + ', \'CURS\');');
							thisMacro = thisMacro.replace('#STYLE#', 'text-decoration:none;');
							thisCell += thisMacro;
							thisMacro = macroImagen.replace('#SRC#', 'http://www.newco.dev.br/images/2017/reload.png');//'http://www.newco.dev.br/images/2017/reload.png'
							thisMacro = thisMacro.replace('#ALT#', str_Rollback);
							thisMacro = thisMacro.replace('#TITLE#', str_Rollback);
							thisCell += thisMacro;
							thisCell += macroEnlaceEnd + '&nbsp;';

							// Si no es licitacion por producto, se adjudica desde pestanya proveedores
							if(isLicPorProducto == ''){
								thisMacro = macroEnlace3.replace('#CLASS#', 'accAdjud');
								thisMacro = thisMacro.replace('#HREF#', 'javascript:modificaEstadoProveedor(' + arrProveedores[ColumnaOrdenadaProvs[i]].IDProvLic + ', \'ADJ\');');
								thisMacro = thisMacro.replace('#STYLE#', 'text-decoration:none;');
								thisCell += thisMacro;
								thisMacro = macroImagen.replace('#ALT#', str_Adjudicar);
								thisMacro = thisMacro.replace('#TITLE#', str_Adjudicar);
								if(IDPais == 55){
									thisMacro = thisMacro.replace('#SRC#', 'http://www.newco.dev.br/images/adjudicarProve-BR.gif');
                                                        	}else{
									thisMacro = thisMacro.replace('#SRC#', 'http://www.newco.dev.br/images/adjudicarProve.gif');
                                                        	}
								thisCell += thisMacro;
								thisCell += macroEnlaceEnd + '&nbsp;';
							}
						}
					}
				}
				// Botones para imprimir oferta y descargar excel (para todos los usuarios)
				if(arrProveedores[ColumnaOrdenadaProvs[i]].IDEstadoProv == 'INF'){
					thisMacro = macroEnlace3.replace('#CLASS#', 'accImprimir');
					thisMacro = thisMacro.replace('#HREF#', 'javascript:imprimirOferta(' + arrProveedores[ColumnaOrdenadaProvs[i]].IDProvLic + ');');
					thisMacro = thisMacro.replace('#STYLE#', 'text-decoration:none;');
					thisCell += thisMacro;
					thisMacro = macroImagen.replace('#SRC#', 'http://www.newco.dev.br/images/2017/print.png');//'http://www.newco.dev.br/images/imprimir.gif'
					thisMacro = thisMacro.replace('#ALT#', str_ImprimirOferta);
					thisMacro = thisMacro.replace('#TITLE#', str_ImprimirOferta);
					thisCell += thisMacro;
					thisCell += macroEnlaceEnd + '&nbsp;';

					thisMacro = macroEnlace3.replace('#CLASS#', 'accExcel');
					thisMacro = thisMacro.replace('#HREF#', 'javascript:listadoExcel(' + arrProveedores[ColumnaOrdenadaProvs[i]].IDProvLic + ');');
					thisMacro = thisMacro.replace('#STYLE#', 'text-decoration:none;');
					thisCell += thisMacro;
					thisMacro = macroImagen.replace('#SRC#', 'http://www.newco.dev.br/images/2017/excel.png');//http://www.newco.dev.br/images/iconoExcel.gif
					thisMacro = thisMacro.replace('#ALT#', str_ListadoExcel);
					thisMacro = thisMacro.replace('#TITLE#', str_ListadoExcel);
					thisCell += thisMacro;
					thisCell += macroEnlaceEnd + '&nbsp;';
				}
				thisCell += cellEnd;
				thisRow += thisCell;

				thisRow += rowEnd;

				htmlTBODY += thisRow;
			}
		}
		if(estadoLicitacion != 'EST'){
			dibujarFilaConsumoProvEST();
        }
	}else{
	
		htmlTBODY = "<tr><td colspan=\"15\" align=\"center\"><strong>" + str_licSinProveedores + "</strong></td></tr>";
	}

	jQuery('#lProveedores_EST tbody').empty().append(htmlTBODY);
}

function dibujarFilaConsumoProvADJ(){
	var htmlTFOOT = '';

	htmlTFOOT = '<tfoot>';

	htmlTFOOT += rowStartStyle.replace('#STYLE#', 'border-top:1px solid #999;height:30px;');
	htmlTFOOT += cellStartColspan.replace('#COLSPAN#', '9');
	htmlTFOOT += cellEnd;
	/*htmlTFOOT += cellStartClass.replace('#CLASS#', 'datosRight') + '<strong>';
	//if(mostrarPrecioIVA == 'S')
	//	htmlTFOOT += str_ConsHistIVA;
	//else
		htmlTFOOT += str_ConsHist;
	htmlTFOOT += ':</strong>' + cellEnd;
	htmlTFOOT += cellStartClass.replace('#CLASS#', 'datosRight') + '<strong>';
	//if(mostrarPrecioIVA == 'S')
	//	htmlTFOOT += objLicitacion['ConsHistIVA'];
	//else
		htmlTFOOT += objLicitacion['ConsHist'];
	htmlTFOOT += '</strong>&nbsp;' + cellEnd;*/
	htmlTFOOT += cellStartClass.replace('#CLASS#', 'datosRight') + '<strong>';
	//if(mostrarPrecioIVA == 'S')
	//	htmlTFOOT += objLicitacion['ConsumoAdjIVA'];
	//else
		htmlTFOOT += objLicitacion['ConsumoAdj'];
	htmlTFOOT += '</strong>&nbsp;' + cellEnd;
	htmlTFOOT += cellStartClass.replace('#CLASS#', 'datosRight') + '<strong>';
	htmlTFOOT += objLicitacion['AhorroAdj'];			//2ene20
	htmlTFOOT += '</strong>&nbsp;' + cellEnd;
	//	2ene20	htmlTFOOT += cellStart + '<strong>' + str_TotalProductos + ':</strong>' + cellEnd;
	htmlTFOOT += cellStart + '&nbsp;' + cellEnd;
	htmlTFOOT += cellStart + '<strong>' + objLicitacion['NumProductosAdj'] +'/'+ objLicitacion['NumProductos'] + '</strong>' + cellEnd;		//2ene20
	htmlTFOOT += cellStart + cellEnd;
	htmlTFOOT += rowEnd;

	htmlTFOOT += '</tfoot>';

	jQuery('#lProveedores_ADJ').append(htmlTFOOT);
}

function dibujarFilaConsumoProvEST(){
	var htmlTFOOT = '';

	htmlTFOOT = '<tfoot>';

	htmlTFOOT += rowStartStyle.replace('#STYLE#', 'border-top:1px solid #999;height:30px;');
	htmlTFOOT += cellStart + cellEnd;
	htmlTFOOT += cellStartColspanCls.replace('#COLSPAN#', '8').replace('#CLASS#', 'centerDiv');;
	htmlTFOOT += '<strong>' + str_PorcNegociado + ':&nbsp' + objLicitacion['PorcConsNeg'] + '&nbsp;&nbsp;&nbsp;-&nbsp;&nbsp;&nbsp;' + str_PorcAhorro + ':&nbsp' + objLicitacion['AhorMejPrecio'] + '&nbsp;&nbsp;&nbsp;-&nbsp;&nbsp;&nbsp;' + str_ProdsSinOferta + ':&nbsp' + objLicitacion['NumSinOferta'] + '&nbsp;&nbsp;&nbsp;-&nbsp;&nbsp;&nbsp;' + str_ProdsSinOfertaConAhorro + ':&nbsp' + objLicitacion['NumSinAhorro'] + '</strong>';
	htmlTFOOT += cellEnd;

	htmlTFOOT += cellStartColspanCls.replace('#COLSPAN#', '3').replace('#CLASS#', 'datosRight') + '<strong>' + str_TotalProductos + ':</strong>' + cellEnd;
	htmlTFOOT += cellStart + '<strong>' + objLicitacion['NumProductos'] + '</strong>' + cellEnd;

	htmlTFOOT += cellStartColspanCls.replace('#COLSPAN#', '2').replace('#CLASS#', 'datosRight') + '<strong>';
	if(mostrarPrecioIVA == 'S')
		htmlTFOOT += str_ConsHistIVA;
	else
		htmlTFOOT += str_ConsHist;
	htmlTFOOT += ':</strong>' + cellEnd;
	htmlTFOOT += cellStartClass.replace('#CLASS#', 'datosRight') + '<strong>';
	if(mostrarPrecioIVA == 'S')
		htmlTFOOT += objLicitacion['ConsHistIVA'];
	else
		htmlTFOOT += objLicitacion['ConsHist'];
	htmlTFOOT += '</strong>' + cellEnd;
	htmlTFOOT += cellStartColspan.replace('#COLSPAN#', '5') + cellEnd;

	htmlTFOOT += rowEnd;

	htmlTFOOT += '</tfoot>';

	jQuery('#lProveedores_EST').append(htmlTFOOT);
}

function formatCurrency(nFloat){
	var result='', integer, decimal, partes;

	partes	= String(nFloat.toFixed(2)).split('.');
	integer	= String(partes[0]);
	decimal	= String(partes[1]);

	for(var i=integer.length, j=1; i>0; i--,j++){
		if(j%3==0 && i!=1)	result = '.'+integer.substring(i-1,i) + result;
		else			result = integer.substring(i-1,i) + result;
	}

	result = result + ',' + decimal;
	return result;
}

// Funcion para abrir la pagina para establecer una conversacion con el proveedor en un pop-up
function comentarioInterno(){
	MostrarPagPersonalizada('http://www.newco.dev.br/Gestion/Comercial/ConversacionLicitacion.xsql?IDLICITACION='+IDLicitacion+'&IDUSUARIOCLIENTE='+IDUsuario,'Conversacion Licitacion',70,70,0,0);
}

// Funcion para abrir la ficha de un producto de la licitacion en un pop-up
function FichaProductoLic(IDProdLic){
	MostrarPagPersonalizada('http://www.newco.dev.br/Gestion/Comercial/FichaProductoLicitacion.xsql?LIC_PROD_ID='+IDProdLic+'&LIC_ID='+IDLicitacion,'Ficha Producto Licitacion',100,100,0,0);
}

// Funcion para abrir la ficha de una empresa en un pop-up
function FichaEmpresa(IDEmpresa, Pestanna){
	MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPDetalleFrame.xsql?EMP_ID='+IDEmpresa+'&ESTADO=CABECERA&PESTANNA='+Pestanna,'Detalle Empresa',100,80,0,0);
}

// Funcion para abrir las ofertas de un proveedor en pop-up para imprimir
function imprimirOferta(IDProvLic){
	MostrarPagPersonalizada('http://www.newco.dev.br/Gestion/Comercial/ImprimirOferta.xsql?LIC_ID='+IDLicitacion+'&LIC_PROV_ID='+IDProvLic,'',100,100,0,0);
}

//Funcion para enviar un e-mail a usuarios de proveedor de la licitación
function EnviarMailUsuarioLici(Prove,Estado){

	jQuery.ajax({
			cache:	false,
			url:	'http://www.newco.dev.br/Gestion/Comercial/EnviarMailUsuarioLiciJSON.xsql',
			type:	"GET",
			data:	"IDPROVE="+Prove+"&ESTADO="+Estado,
			contentType: "application/xhtml+xml",
			success: function(objeto){
				//var data = eval("(" + objeto + ")");
				var data = JSON.parse(objeto);
                alert(alrt_mensajeEnviado);
                //oculto el sobre del usuario a que le he enviado mail
                jQuery("#mailBox_"+Prove).hide();
			},
			error: function(xhr, errorString, exception) {
				alert("xhr.status="+xhr.status+" error="+errorString+" exception="+exception);
			}
		});
} //fin de enviar mail a usuario

function conversacionProveedor(ProvID, UsuID, UsuProvID, NombreProv){
	MostrarPagPersonalizada('http://www.newco.dev.br/Gestion/Comercial/ConversacionLicitacion.xsql?IDLICITACION='+IDLicitacion+'&IDPROVEEDOR='+ProvID+'&IDUSUARIOCLIENTE='+UsuID+'&IDUSUARIOPROV='+UsuProvID+'&NOMBREPROV='+NombreProv,'',70,70,0,0);
}

function conversacionProveedor2(posArr){
	if(posArr == null){	// Comentario del proveedor
		var IDProveedor		= IDProveedorIni;
		var IDUsuClie		= IDUsuarioCliente;
		var IDUsuProv		= IDUsuario;
		var NombreProv		= NombreCliente;
	}else{			// COmentario del usuario autor
		var IDProveedor		= arrProveedores[posArr].IDProveedor;
		var IDUsuClie		= IDUsuario;
		var IDUsuProv		= arrProveedores[posArr].IDUsuarioProv;
		var NombreProv		= arrProveedores[posArr].Nombre;
	}
	var d = new Date();
	
	jQuery("#Respuesta").hide();	//	25oct17

	jQuery.ajax({
		cache:	false,
		url:	'http://www.newco.dev.br/Gestion/Comercial/ConversacionLicitacionAJAX.xsql',
		type:	"GET",
		data:	"IDLICITACION="+IDLicitacion+"&IDPROVEEDOR="+IDProveedor+"&_="+d.getTime(),
		contentType: "application/xhtml+xml",
		beforeSend: function(){
			jQuery("#convProveedor #mensError").hide();
			jQuery("#convProveedor span#NombreProv").html(NombreProv);
			jQuery("#convProveedor table#viejosComentarios tbody").empty();
			jQuery("#convProveedor table#viejosComentarios").hide();
			jQuery("#convProveedor table#nuevoComentario #LIC_MENSAJE").val("");
			jQuery("#convProveedor table#nuevoComentario").hide();
		},
		error: function(objeto, quepaso, otroobj){
			alert('error'+quepaso+' '+otroobj+' '+objeto);
		},
		success: function(objeto){
			//var data = eval("(" + objeto + ")");
			var data = JSON.parse(objeto);

			if(data.Estado == 'OK'){
				if(data.isAutor == 'S' || data.isProveedor == 'S'){
					jQuery("#convProveedor #IDPROVEEDOR").val(IDProveedor);
					jQuery("#convProveedor #IDUSUARIOCLIENTE").val(IDUsuClie);
					jQuery("#convProveedor #IDUSUARIOPROV").val(IDUsuProv);
					jQuery("#convProveedor table#nuevoComentario").show();
				}

				if(data.ListaComentarios.length){
					var innerHTML = '';

					for(var i=0; i<data.ListaComentarios.length; i++){
						innerHTML += '<tr><td class="dies"><strong>' + str_autor + ':</strong></td>';
						innerHTML += '<td style="text-align:left;">';
						if(data.ListaComentarios[i].IDUsuarioAutor == data.ListaComentarios[i].IDUsuarioCliente){
							innerHTML += data.ListaComentarios[i].UsuarioCliente;
						}else if(data.ListaComentarios[i].IDUsuarioAutor == data.ListaComentarios[i].IDUsuarioProv){
							innerHTML += data.ListaComentarios[i].UsuarioProv;
						}
						innerHTML += '</td>';
						innerHTML += '<td><strong>' + str_fecha + ':</strong></td>';
						innerHTML += '<td style="text-align:left;">' + data.ListaComentarios[i].Fecha + '</td>';
						innerHTML += '<td class="dies">&nbsp;</td></tr>';

						innerHTML += '<tr><td><strong>' + str_comentario + ':</strong></td>';
						innerHTML += '<td colspan="3" style="text-align:left;">' + data.ListaComentarios[i].Mensaje + '</td>';
						innerHTML += '<td>&nbsp;</td></tr>';

						innerHTML += '<tr><td>&nbsp;</td>';
						innerHTML += '<td colspan="3" style="border-bottom:2px solid #3B5998;">&nbsp;</td>';
						innerHTML += '<td>&nbsp;</td></tr>';
					}
					jQuery("#convProveedor table#viejosComentarios tbody").append(innerHTML);
					jQuery("#convProveedor table#viejosComentarios").show();
				}
			}else{
				jQuery("#convProveedor #mensError").show();
			}
		}
	});

	showTablaByID("convProveedor");
}

function guardarConversProv(){
	var oForm	= document.forms['convProveedorForm'];
	var IDProv	= oForm.elements['IDPROVEEDOR'].value;
	var IDUsuClie	= IDUsuarioCliente;			//oForm.elements['IDUSUARIOCLIENTE'].value;
	var IDUsuProv	= oForm.elements['IDUSUARIOPROV'].value;
	var Mensaje	= oForm.elements['LIC_MENSAJE'].value.replace(/'/g, "''");
	var errores	= 0;
	var d = new Date();

	if((!errores) && (esNulo(Mensaje))){
		errores++;
		alert(val_faltaMensaje);
		oForm.elements['LIC_MENSAJE'].focus();
	}
	
	jQuery("#btnGuardarConv").hide();			//	25oct17

	/* si los datos son correctos enviamos el form  */
	if(!errores){
		jQuery.ajax({
			cache:	false,
			url:	'http://www.newco.dev.br/Gestion/Comercial/ConversacionLicitacionSaveAJAX.xsql',
			type:	"POST",
			data:	"IDLICITACION="+IDLicitacion+"&IDPROVEEDOR="+IDProv+"&IDUSUARIOCLIENTE="+IDUsuClie+"&IDUSUARIOPROV="+IDUsuProv+"&LIC_MENSAJE="+encodeURIComponent(Mensaje)+"&_="+d.getTime(),
			beforeSend: function(){
				jQuery("#btnGuardarConv").hide();			//	25oct17
			},
			error: function(objeto, quepaso, otroobj){
				alert('error'+quepaso+' '+otroobj+' '+objeto);
			},
			success: function(objeto){
				//var data = eval("(" + objeto + ")");
				var data = JSON.parse(objeto);

				if(data.Estado == 'OK'){
					jQuery("#convProveedor td#Respuesta").addClass("verde").html(str_guardarCommOK);
				}else{
					jQuery("#convProveedor td#Respuesta").addClass("rojo2").html(str_guardarCommKO);
				}
				jQuery("#convProveedor td#Respuesta").show();
			}
		});
	}

}

// modifica estado de un proveedor de la licitacion
function modificaEstadoProveedor(IDProve, IDEstado){
	var d = new Date();

	jQuery.ajax({
		cache:	false,
		url:	'http://www.newco.dev.br/Gestion/Comercial/ModificaEstadoProveedor.xsql',
		type:	"GET",
		data:	"ID_PROVE="+IDProve+"&ID_ESTADO="+IDEstado+"&_="+d.getTime(),
		contentType: "application/xhtml+xml",
		error: function(objeto, quepaso, otroobj){
			alert('error'+quepaso+' '+otroobj+' '+objeto);
		},
		success: function(objeto){
			//var data = eval("(" + objeto + ")");
			var data = JSON.parse(objeto);

			if(data.ModificaEstadoProveedor.estado == 'OK'){
				// Si adjudicamos una licitacion => recargamos la pagina
				if(IDEstado == 'ADJ'){
					Recarga();	//23jul19	location.reload();
					return;
				}else if(IDEstado == 'FIRM'){
					jQuery('#botonFirmarLici').hide();
					if(window.opener !== null && !window.opener.closed){
						opener.location.reload();	// Recarga de la pagina padre para actualizar el estado de la licitacion
					}
					alert(alrt_firmaProveedorOK);
					Recarga();	//23jul19	location.reload();
					return;
				}

				EstadoActualLicitacion();
				recuperaDatosProveedores();
			}else{
				if(IDestado == 'ADJ')
					alert(alrt_AdjudicarProveedorKO);
				else if(IDestado == 'SUS')
					alert(alrt_SuspenderProveedorKO);
				else if(IDestado == 'FIRM')
					alert(alrt_NuevoEstadoProveedorKO);
				else
					alert(alrt_RollBackProveedorKO);
			}
		}
	});
}

function EstadoActualLicitacion(){
	var d = new Date();

	jQuery.ajax({
		cache:	false,
		url:	'http://www.newco.dev.br/Gestion/Comercial/EstadoLicitacion.xsql',
		type:	"GET",
		data:	"LIC_ID="+IDLicitacion+"&_="+d.getTime(),
		contentType: "application/xhtml+xml",
		error: function(objeto, quepaso, otroobj){
			alert('error'+quepaso+' '+otroobj+' '+objeto);
		},
		success: function(objeto){
			//var data = eval("(" + objeto + ")");
			var data = JSON.parse(objeto);

			if(data.LicID == IDLicitacion){
				estadoLicitacion = data.IDEstado;

				var EstadoNuevo	= data.Estado;
				var EstadoViejo	= jQuery("#idEstadoLic").text();

				if(EstadoNuevo != EstadoViejo){
					jQuery("#idEstadoLic").text(EstadoNuevo);
					jQuery("#idEstadoLic").addClass("amarillo");
                                }
                        }
		}
	});
}

function ActualizarFechaDecision(){
	var fechaDecision = jQuery('#LIC_FECHADECISION').val();
	var errores = 0;
	var d = new Date();

	if((!errores) && (esNulo(fechaDecision))){
		errores++;
		alert(val_faltaFechaDecision);
		jQuery('#LIC_FECHADECISION').focus();
	}else if(!errores && CheckDate(fechaDecision)){
		errores++;
		alert(val_malFechaDecision);
		jQuery('#LIC_FECHADECISION').focus();
	}

	if(!errores){
		jQuery.ajax({
			cache:	false,
			url:	'http://www.newco.dev.br/Gestion/Comercial/ModificarFechaDecision.xsql',
			type:	"GET",
			data:	"LIC_ID="+IDLicitacion+"&FECHA="+fechaDecision+"&_="+d.getTime(),
			contentType: "application/xhtml+xml",
			error: function(objeto, quepaso, otroobj){
				alert('error'+quepaso+' '+otroobj+' '+objeto);
			},
			success: function(objeto){
				//var data = eval("(" + objeto + ")");
				var data = JSON.parse(objeto);

				if(data.Resultado.Estado == 'OK'){
					alert(alrt_ModFechaDecisionOK);
				}else{
					alert(alrt_ModFechaDecisionKO);
				}
			}
		});
        }
}

function ActualizarFechasReales(){
	var fechaRealAdj = jQuery('#LIC_FECHAREALADJUDICACION').val();
	var fechaRealCad = jQuery('#LIC_FECHAREALCADUCIDAD').val();
	var errores = 0;
	var d = new Date();

	if((!errores) && (esNulo(fechaRealAdj))){
		errores++;
		alert(val_faltaFechaRealAdj);
		jQuery('#LIC_FECHAREALADJUDICACION').focus();
		return;
	}else if(!errores && CheckDate(fechaRealAdj)){
		errores++;
		alert(val_malFechaRealAdj);
		jQuery('#LIC_FECHAREALADJUDICACION').focus();
		return;
	}else if((!errores) && (esNulo(fechaRealCad))){
		errores++;
		alert(val_faltaFechaRealCad);
		jQuery('#LIC_FECHAREALCADUCIDAD').focus();
		return;
	}else if(!errores && CheckDate(fechaRealCad)){
		errores++;
		alert(val_malFechaRealCad);
		jQuery('#LIC_FECHAREALCADUCIDAD').focus();
		return;
	}

	jQuery.ajax({
		cache:	false,
		url:	'http://www.newco.dev.br/Gestion/Comercial/ModificarFechasReales.xsql',
		type:	"GET",
		data:	"LIC_ID="+IDLicitacion+"&FECHAREALADJ="+fechaRealAdj+"&FECHAREALCAD="+fechaRealCad+"&_="+d.getTime(),
		contentType: "application/xhtml+xml",
		error: function(objeto, quepaso, otroobj){
			alert('error'+quepaso+' '+otroobj+' '+objeto);
		},
		success: function(objeto){
			//var data = eval("(" + objeto + ")");
			var data = JSON.parse(objeto);

			if(data.Resultado.Estado == 'OK'){
				alert(alrt_ModFechasRealesOK);
			}else{
				alert(alrt_ModFechasRealesKO);
			}
		}
	});
}

// Funcion que devuelve un fichero excel con detalles de la licitacion
function listadoExcel(IDProvLic){
	var d = new Date();
	IDProvLic   = (typeof IDProvLic === "undefined") ? '' : IDProvLic;

	jQuery.ajax({
		url:	"http://www.newco.dev.br/Gestion/Comercial/LicitacionesExcel.xsql",
		data:	"IDLIC="+IDLicitacion+"&IDPROVEEDORLIC="+IDProvLic+"&_="+d.getTime(),

		type:	"GET",
		contentType: "application/xhtml+xml",
		beforeSend: function(){
			null;
		},
		error: function(objeto, quepaso, otroobj){
			alert('error'+quepaso+' '+otroobj+''+objeto);
		},
		success: function(objeto){
			//var data = eval("(" + objeto + ")");
			var data = JSON.parse(objeto);

			if(data.estado == 'ok')
				window.location='http://www.newco.dev.br/Descargas/'+data.url;
			else
				alert(alrt_errorDescargaFichero);
		}
	});
}



// Funcion para colorear la celda que tiene el mejor precio
function MarcarMejoresPrecios(){
	var MejorPrecio, MejorColumna, valAux;

	if(rol == 'COMPRADOR' && (estadoLicitacion == 'CURS' || estadoLicitacion == 'INF')){

		// Para cada uno de los indices de arrProductos
		jQuery.each(arrProductos, function(key, producto){
			MejorPrecio	= -1;
			MejorColumna	= -1;

			jQuery.each(producto['Ofertas'], function(key2, oferta){
				valAux = (oferta.Precio != '') ? parseFloat(oferta.Precio.replace(',', '.')) : '';

				if(valAux != '' && (MejorPrecio < 0 || MejorPrecio > valAux)){
					MejorPrecio	= valAux;
					MejorColumna	= oferta.columna;
				}
			});

			if(MejorColumna != -1){
				jQuery("table#lProductos_OFE tbody tr#posArr_" + key + " td#arrProd-" + key + "_arrProvOfr-" + (MejorColumna - 1)).addClass("mejorPrecio");
			}
		});
	}
}

// Funcion para seleccionar automaticamente los radio buttons con los mejores precios
function SeleccionarMejoresPrecios(){
	var MejorPrecio, MejorColumna, MejorOfertaID, valAux;

	// Marcamos el flag de control como que se han hecho nuevos cambios en el formulario
	anyChange = true;
	jQuery('#botonSelecMejPrecios').hide();

	jQuery.each(arrProductos, function(key, producto){
		MejorPrecio	= -1;
		MejorColumna	= -1;

		jQuery.each(producto['Ofertas'], function(key2, oferta){
			valAux = (oferta.Precio != '') ? parseFloat(oferta.Precio.replace(',', '.')) : '';

			if(valAux != '' && (MejorPrecio < 0 || MejorPrecio > valAux)){
				MejorPrecio	= valAux;
				MejorColumna	= key2;
			}
		});

		if(MejorColumna != -1){
			MejorOfertaID = arrProductos[key].Ofertas[MejorColumna].ID;	//21set16	.IDOferta
        }

		// Una vez tengo el mejor precio y su IDOferta, busco el radio button que toca
		var radioAux = document.getElementsByName('RADIO_' + key);

		for(var j = 0; j < radioAux.length; j++){
			if(radioAux[j].value == MejorOfertaID){
				radioAux[j].checked = true;
				// Ahora lanzamos la funcion para que recalcule el div flotante
				recalcularFloatingBox(radioAux[j], 0);
			}
		}
	});

	// Validamos pedidos minimos para mostrar/ocultar el aviso de pedido minimo por proveedores
	validarPedidosMinimosDOM();

	jQuery('#botonSelecMejPrecios').show();
}



function calcularFloatingBox(){
	//var numProductos = 0, numOfertas = 0, numProveedoresAdj = 0;
	var Cantidad, CantidadFormato, PrecioRef, PrecioRefFormato, Precio, PrecioFormato;		//	28may19, ConsumoPot = 0, ConsumoPrev = 0, Ahorro = 0;
	//29may19	var chckPedMinimo = false, 
	var valAux;


	//	inicializamos las variables globales con los totales
	ConsumoPot = 0; 
	ConsumoPrev = 0; 
	Ahorro = 0;
	numProductos = 0; 
	numOfertas = 0; 
	numProdConOfe = 0; 
	numProdsAdjud = 0; 
	numProveedoresAdj = 0;
	//solodebug	debug('calcularFloatingBox');


	//	21jul18	Inicializamos proveedores
	jQuery.each(arrConsumoProvs, function(key, consumoProv){
		//solodebug	debug('calcularFloatingBox.Control proveedores seleccionados. Prov:('+consumoProv.IDProvLic+')'+consumoProv.NombreCorto+'. ofertasAdj:'+consumoProv.OfertasAdj+'->0');	//21jul18
		consumoProv.OfertasAdj=0;
	});



	jQuery.each(arrProductos, function(key, producto){
		numProductos++;

		//solodebug	alert('OfertaAdjud. producto. tiene seleccion:'+producto.TieneSeleccion);
		
		if (producto.NumOfertas>0)	numProdConOfe++;
		

		// Si hay una oferta seleccionada
		if(producto.TieneSeleccion == 'S'){
		
			++numProdsAdjud;
		
			jQuery.each(producto.Ofertas, function(key2, oferta){
				// Si esta es la oferta seleccionada
				if(oferta.OfertaAdjud == 'S'){
				
					//solodebug	alert('OfertaAdjud. precio:'+oferta.Precio);
				
					numOfertas++;
					Cantidad		= producto.Cantidad;
					CantidadFormato	= Cantidad.replace(",",".");
					
					// 20may19 Cantidad adjudicada
					CantidadAdj			= oferta.CantAdjud;
					CantidadAdjFormato	= CantidadAdj.replace(",",".");
					
					(mostrarPrecioIVA == 'S') ? PrecioRef = producto.PrecioHistIVA : PrecioRef = producto.PrecioHist;
					valAux = PrecioRef.replace(",",".");
					if(!isNaN(valAux) && !esNulo(valAux)){
						PrecioRefFormato	= valAux;
					}else{
						PrecioRefFormato	= 0;
					}
					(mostrarPrecioIVA == 'S') ? Precio = oferta.PrecioIVA : Precio = oferta.Precio;
					PrecioFormato		= Precio.replace(",",".");

					if(PrecioRefFormato != 0){
						ConsumoPot		+= CantidadAdjFormato * PrecioRefFormato;
						//21jul18	ConsumoPrev		+= CantidadFormato * PrecioFormato;
					}
					ConsumoPrev		+= CantidadAdjFormato * PrecioFormato;		//20may19 Cantidad adjudicada
					
					if (ConsumoPot!=0)		//31mar17
						Ahorro			= (ConsumoPot - ConsumoPrev) * 100 / ConsumoPot;
					else
						Ahorro			=  0;
						
						
					//	21jul18	Busca proveedor e inicializa
					jQuery.each(arrConsumoProvs, function(key, consumoProv){
						if(consumoProv.IDProvLic==oferta.IDProvLic)						
							++consumoProv.OfertasAdj;
					});
						
						
				}
			});
		}
	});

	//29may19	jQuery('#FBConsPot').html(FormateaNumeroNacho(ConsumoPot.toFixed(2)));
	//29may19	jQuery('#FBConsPrev').html(FormateaNumeroNacho(ConsumoPrev.toFixed(2)));
	//29may19	jQuery('#FBAhorro').html(FormateaNumeroNacho(Ahorro.toFixed(2)) + '%');
	//29may19	jQuery('#FBNumOfertas').html(numOfertas+'/'+numProductos);

	jQuery.each(arrConsumoProvs, function(key, consumoProv){
		if(parseInt(consumoProv.OfertasAdj) > 0){
			//		+consumoProv.NombreCorto

			//solodebug
			debug('calcularFloatingBox.Control proveedores seleccionados. Prov:('+consumoProv.IDProvLic+')'+'. ofertasAdj:'+consumoProv.OfertasAdj);	//21jul18

			numProveedoresAdj++;
		}
	});
	//29may19	jQuery('#FBProvs').html(numProveedoresAdj);

	//29may19	if(mesesSelected == 0)	chckPedMinimo = validarPedidosMinimos(2);
	//29may19	else	chckPedMinimo = true;

	//29may19	if(chckPedMinimo && numOfertas == numProductos){
	//29may19		//	if(numOfertas == numProductos){
	//29may19		jQuery('#FBAviso').html('&nbsp;<img src="http://www.newco.dev.br/images/check.gif" style="vertical-align:text-bottom;"/>');
	//29may19	}else{
	//29may19		jQuery('#FBAviso').html('&nbsp;<img src="http://www.newco.dev.br/images/atencion.gif" style="vertical-align:text-bottom;"/>');
	//29may19	}

	//solodebug	alert('calcularFloatingBox ConsumoPrev:'+ConsumoPrev);

	//solodebug	
	debug('calcularFloatingBox ConsumoPot:'+ConsumoPot+' ConsumoPrev:'+ConsumoPrev);
	

	//if(ConsumoPrev)	-> 31mar17 mostramos el FloatingBox en todos los casos, si no, no aparece en precio histórico informado
	//29may19	jQuery('#floatingBox').show();
	
	mostrarFloatingBox();
}



//	29may19 Separamos la funcion para mostrar el FLoatingBox del cálculo
function mostrarFloatingBox()
{
	var chckPedMinimo = false;
	
	if(mesesSelected == 0)	chckPedMinimo = validarPedidosMinimos(2);
	else	chckPedMinimo = true;

	jQuery('#FBConsPot').html(FormateaNumeroNacho(ConsumoPot.toFixed(2)));
	jQuery('#FBConsPrev').html(FormateaNumeroNacho(ConsumoPrev.toFixed(2)));
	jQuery('#FBAhorro').html(FormateaNumeroNacho(Ahorro.toFixed(2)) + '%');
	jQuery('#FBNumOfertas').html(numProdsAdjud+'/'+numProdConOfe+'/'+numProductos);	//	numOfertas
	jQuery('#FBProvs').html(numProvsAdj);

	if(chckPedMinimo && numOfertas == numProductos){
		jQuery('#FBAviso').html('&nbsp;<img src="http://www.newco.dev.br/images/check.gif" style="vertical-align:text-bottom;"/>');
	}else{
		jQuery('#FBAviso').html('&nbsp;<img src="http://www.newco.dev.br/images/atencion.gif" style="vertical-align:text-bottom;"/>');
	}

	if (mostrarResumenFlotante=='S')
		jQuery('#floatingBox').show();
	else
		jQuery('#floatingBox').hide();
}



//15may17 al guardar selección desde ficha, no marcar la licitación como pendiente de guardar selecciones
function recalcularFloatingBox(obj, flagPedMin, ofertaGuardada)
{
	var thisPosArr, thisOfertaID, PrecioHist, Cantidad, 
		wasChecked = false, 		//21set16	Inicializo
		isChecked, 
		oldPrecioOferta = 0, newPrecioOferta = 0, oldOfertaID = null;

	var thisPosArrProv, oldPosArrProv = null;

	//22may19 var oldConsumoPot = 0, newConsumoPot, oldConsumoPrev = 0, newConsumoPrev, oldAhorro = 0, newAhorro, oldNumOfertas = 0, newNumOfertas, oldnumProvsAdj = 0, newnumProvsAdj = 0;
	var oldConsumoPot = 0, oldConsumoPrev = 0, oldAhorro = 0, oldNumOfertas = 0, newNumOfertas, oldnumProvsAdj = 0, newnumProvsAdj = 0;

	var chckPedMinimo = false, valAux;

	if(jQuery('#floatingBox').is(":visible")){
		//	22may19	Cogemos losvalores antiguos desde las variables globales - Buscamos los valores antiguos en el div flotante y los formateamos para hacer calculos
		oldConsumoPot	= ConsumoPot;		//	22may19	parseFloat(jQuery('#FBConsPot').html().replace(/\./g,'').replace(',', '.'));
		oldConsumoPrev	= ConsumoPrev;		//	22may19	parseFloat(jQuery('#FBConsPrev').html().replace(/\./g,'').replace(',', '.'));
		oldNumOfertas	= NumOfertas;		//	22may19	parseFloat(jQuery('#FBNumOfertas').html().replace(/\/[0-9]+/, ''));
		oldnumProvsAdj	= numProvsAdj;		//	22may19	parseFloat(jQuery('#FBProvs').html().replace(/\/[0-9]+/, ''));
		
		
		//9mar20 No vale la pena ocultarlo jQuery('#floatingBox').hide();
	}

	//solodebug	13abr17	debug('RecalcularFloatingBox. INICIO: firstProduct'+firstProduct+ ' oldOfertaID:'+oldOfertaID+' thisOfertaID:'+thisOfertaID+ ' oldConsumoPot:'+oldConsumoPot+' oldConsumoPrev:'+oldConsumoPrev);

	if (ofertaGuardada!='S')		//15may17
		CambiosEnOfertasSeleccionadas('S');	//	2may17

	if(flagPedMin)	validarPedidosMinimosDOM();

	thisPosArr	= parseInt(jQuery(obj).attr('class').replace('RADIO_', ''));
	
	thisOfertaID	= jQuery(obj).val();
	(jQuery(obj).is(':checked')) ? isChecked = true : isChecked = false;
	
	
	valAux = arrProductos[thisPosArr].PrecioHist.replace(',', '.');
	if(!isNaN(valAux) && !esNulo(valAux)){
		(mostrarPrecioIVA == 'S') ? PrecioHist = parseFloat(arrProductos[thisPosArr].PrecioHistIVA.replace(',', '.')) : PrecioHist = parseFloat(arrProductos[thisPosArr].PrecioHist.replace(',', '.'));
	}else{
		PrecioHist = 0;
	}
	Cantidad	= parseFloat(arrProductos[thisPosArr].Cantidad.replace(',', '.'));

	for(var i=0; i<ColumnaOrdenadaProds.length; i++){
		if(ColumnaOrdenadaProds[i] == thisPosArr){
			wasChecked = arrRadios[(i-firstProduct)].checked;
			if(wasChecked){			

				//solodebug	13abr17	debug('RecalcularFloatingBox. waschecked: firstProduct'+firstProduct+ 'i:'+i+ ' oldOfertaID:'+oldOfertaID+' arrRadios[(i-firstProduct)].OfertaID:'+arrRadios[(i-firstProduct)].OfertaID);

				oldOfertaID = arrRadios[(i-firstProduct)].OfertaID;
				(mostrarPrecioIVA == 'S') ? oldPrecioOferta = parseFloat(arrProductos[thisPosArr].Ofertas[arrRadios[(i-firstProduct)].numOferta].PrecioIVA.replace(',', '.')) : oldPrecioOferta = parseFloat(arrProductos[thisPosArr].Ofertas[arrRadios[(i-firstProduct)].numOferta].Precio.replace(',', '.'));


				//	8may17	Marcamos la oferta seleccionada/deseleccionada en el array de ofertas
				arrProductos[thisPosArr].Ofertas[arrRadios[(i-firstProduct)].numOferta].OfertaAdjud = 'N';

			}
			break;
		}
	}

	//solodebug	debug('RecalcularFloatingBox: oldOfertaID:'+oldOfertaID+' thisOfertaID:'+thisOfertaID);

	for(var j=0; j<arrProductos[thisPosArr].Ofertas.length; j++)
	{
		if(arrProductos[thisPosArr].Ofertas[j].ID == thisOfertaID)
		{	
		
			//	5may17	Marcamos la oferta seleccionada/deseleccionada en el array de ofertas
			
			//solodebug	debug('RecalcularFloatingBox.IDOferta:'+ thisOfertaID+ ' fila:'+thisPosArr+' Col:'+j+'. Estaba adjudicada:'+arrProductos[thisPosArr].Ofertas[j].OfertaAdjud+' Ahora:'+(isChecked?'S':'N'));
			
			arrProductos[thisPosArr].Ofertas[j].OfertaAdjud = (isChecked?'S':'N');
	
			//	21set16	IDOferta
			newPrecioOferta =  (mostrarPrecioIVA == 'S') ? parseFloat(arrProductos[thisPosArr].Ofertas[j].PrecioIVA.replace(',', '.')) : parseFloat(arrProductos[thisPosArr].Ofertas[j].Precio.replace(',', '.'));
			break;
		}
	}

	// Parte para mostrar en el floating box el número de proveedores con ofertas seleccionadas
	// Informamos la posición del array arrConsumoProvs que contiene la oferta del proveedor en la que se ha hecho el click.
	thisPosArrProv = jQuery("input#Prov_" + thisOfertaID).val();
	// Comprobamos si ya existía una selección anterior para ese producto
	if(wasChecked){

		//solodebug	alert('recalcularFloatingBox wasChecked:'+wasChecked+' thisOfertaID:'+thisOfertaID+' oldOfertaID:'+oldOfertaID);

		// Informamos la posición del array arrConsumoProvs que estaba seleccionado previamente
		oldPosArrProv = jQuery("input#Prov_" + oldOfertaID).val();
		// No son el mismo caso => restamos el que estaba seleccionado antes y sumamos el de ahora que se habrá seleccionado
		if(thisPosArrProv !== oldPosArrProv){
		
			//solodebug	alert('recalcularFloatingBox thisPosArrProv:'+thisPosArrProv+' oldPosArrProv:'+oldPosArrProv);
		
			//29may19 arrConsumoProvs[thisPosArrProv].OfertasAdjAux++;
			//29may19 arrConsumoProvs[oldPosArrProv].OfertasAdjAux--;
			arrConsumoProvs[thisPosArrProv].OfertasAdj++;
			arrConsumoProvs[oldPosArrProv].OfertasAdj--;
			
				
		}else{	// Son el mismo caso => si antes estaba seleccionado, ahora no lo está => restamos en la posición actual
			//29may19 arrConsumoProvs[thisPosArrProv].OfertasAdjAux--;
			arrConsumoProvs[thisPosArrProv].OfertasAdj--;
		}

		//solodebug	debug('Was Checked');
	}else{
		// Si antes no había selección => ahora si que hay selección => sumamos en la posición actual
		//29may19 arrConsumoProvs[thisPosArrProv].OfertasAdjAux++;
		arrConsumoProvs[thisPosArrProv].OfertasAdj++;

		//solodebug	debug('Was NOT Checked');
	}

	numProvsAdj=0;		//	09mar20 Faltaba inicializar el contador
	// Ahora me recorro de nuevo todo el array para calcular cuantos proveedores tienen ofertas seleccionadas.
	jQuery.each(arrConsumoProvs, function(key, consumoProv){
	
		//if(parseInt(consumoProv.OfertasAdjAux) > 0){
		if(parseInt(consumoProv.OfertasAdj) > 0){
			numProvsAdj++;
		}
	});

	if(isChecked){
		arrRadios[(i-firstProduct)].checked = true;
		arrRadios[(i-firstProduct)].numOferta = j;
		arrRadios[(i-firstProduct)].OfertaID = arrProductos[thisPosArr].Ofertas[j].ID;	//21set16	.IDOferta
		jQuery('tr#posArr_' + thisPosArr + ' td span.imgAviso').hide();
	}else{
		arrRadios[(i-firstProduct)].checked = false;
		arrRadios[(i-firstProduct)].numOferta = null;
		arrRadios[(i-firstProduct)].OfertaID = null;
		jQuery('tr#posArr_' + thisPosArr + ' td span.imgAviso').show();
	}

	// Posibles casos
	if(wasChecked !== true && isChecked !== false){
		if(PrecioHist != 0){
			ConsumoPot	= oldConsumoPot + (PrecioHist * Cantidad);
			ConsumoPrev	= oldConsumoPrev + (newPrecioOferta * Cantidad);
		}else{
			ConsumoPot	= oldConsumoPot;
			ConsumoPrev	= oldConsumoPrev + (newPrecioOferta * Cantidad);		//	21jul18
		}	

		if (ConsumoPot==0)
			Ahorro	= 0;			//	31mar17 Sin esto, muestra NaN
		else
			Ahorro	= (ConsumoPot - ConsumoPrev) * 100 / ConsumoPot;

		numOfertas	= oldNumOfertas + 1;
	}else if(wasChecked !== false && isChecked !== false){
		if(PrecioHist != 0){
			ConsumoPot	= oldConsumoPot;
			ConsumoPrev	= oldConsumoPrev + (newPrecioOferta * Cantidad) - (oldPrecioOferta * Cantidad);
		}else{
			ConsumoPot	= oldConsumoPot;
			ConsumoPrev	= oldConsumoPrev + (newPrecioOferta * Cantidad) - (oldPrecioOferta * Cantidad);		//	21jul18
		}

		if (ConsumoPot==0)
			Ahorro	= 0;			//	31mar17 Sin esto, muestra NaN
		else
			Ahorro	= (ConsumoPot - ConsumoPrev) * 100 / ConsumoPot;

		numOfertas	= oldNumOfertas;
	}else if(wasChecked !== false && isChecked !== true){
		if(PrecioHist != 0){
			ConsumoPot	= oldConsumoPot - (PrecioHist * Cantidad);
			ConsumoPrev	= oldConsumoPrev - (newPrecioOferta * Cantidad);
		}else{
			ConsumoPot	= oldConsumoPot;
			ConsumoPrev	= oldConsumoPrev - (newPrecioOferta * Cantidad);		//	21jul18
		}

		if (ConsumoPot==0)
			Ahorro	= 0;			//	31mar17 Sin esto, muestra NaN
		else
			Ahorro	= (ConsumoPot - ConsumoPrev) * 100 / ConsumoPot;

		numOfertas	= oldNumOfertas - 1;
	}


	//solodebug	debug('RecalcularFloatingBox. FINAL: wasChecked:'+wasChecked+' isChecked:'+isChecked+' oldNumOfertas:'+oldNumOfertas+' newNumOfertas:'+newNumOfertas+' ConsumoPot:'+ConsumoPot+' ConsumoPrev:'+ConsumoPrev);


	if(newNumOfertas > 0){
		//29may19	jQuery('#FBConsPot').html(FormateaNumeroNacho(ConsumoPot.toFixed(2)));
		//29may19	jQuery('#FBConsPrev').html(FormateaNumeroNacho(ConsumoPrev.toFixed(2)));
		//29may19	jQuery('#FBAhorro').html(FormateaNumeroNacho(newAhorro.toFixed(2)) + '%');
		//29may19	jQuery('#FBNumOfertas').html(newNumOfertas + '/' + ColumnaOrdenadaProds.length);
		//29may19	jQuery('#FBProvs').html(newnumProvsAdj);

/*
//		04feb15 - Desactivada la validacion por delay del navegador en el calculo
		if(mesesSelected == 0)	chckPedMinimo = validarPedidosMinimos(0);
		else	chckPedMinimo = true;

		if(chckPedMinimo && newNumOfertas == ColumnaOrdenadaProds.length){
//		if(numOfertas == numProductos){
			jQuery('#FBAviso').html('&nbsp;<img src="http://www.newco.dev.br/images/check.gif" style="vertical-align:text-bottom;"/>');
		}else{
			jQuery('#FBAviso').html('&nbsp;<img src="http://www.newco.dev.br/images/atencion.gif" style="vertical-align:text-bottom;"/>');
		}
*/
		//29may19	jQuery('#floatingBox').show();

		//solodebug debug('RecalcularFloatingBox: Mostrar. newNumOfertas:'+newNumOfertas);
	}
	else
	{
		//solodebug	debug('RecalcularFloatingBox: NO Mostrar. newNumOfertas:'+newNumOfertas);
	}


	//29may19 Siempre mostramos el floatingBox tras recalcular
	mostrarFloatingBox();
}

function validarPedidosMinimosDOM(){
	var arrConsumos	= new Array(arrConsumoProvs.length);
	var arrPedsMin	= new Array(arrConsumoProvs.length);
	var errPedMin = false, numOfertas = 0;

	//Inicializamos dos arrays:
		// arrConsumos - contador de consumos por proveedor segun ofertas seleccionadas
		// arrPedsMin - donde guardamos el valor del pedido minimo segun proveedor
	for(var i=0; i<arrConsumoProvs.length; i++){
		arrConsumos[i]	= 0;
		arrPedsMin[i]	= parseFloat(arrConsumoProvs[i].PedidoMin.replace(".","").replace(",","."));
	}

	// Recorremos el array de productos entero
	jQuery.each(arrProductos, function(key, producto){
		// Si el producto en cuestion se muestra por pantalla, recuperamos los datos del radio button del DOM
		if(jQuery("tr#posArr_" + key).length){
			// Recorremos los N radio buttons del producto en cuestion para encontrar el que pertenece al proveedor que tiene la oferta
			jQuery(".RADIO_" + key).each(function(key2, thisRadio){
				if(jQuery(thisRadio).is(':checked')){ // Si esta checked, entonces sumamos el consumo en la posicion del array que toca
					numOfertas++;
					
					var thisPos = jQuery("#Prov_" + thisRadio.value).val();			//esto devuelve un número de columna
										
					//solodebug		debug ('validarPedidosMinimosDOM. IDPROVEEDOR:'+thisRadio.value+ ' thisPos:'+thisPos);
					
					try
					{
						arrConsumos[thisPos] += parseFloat(producto.Ofertas[thisPos].Consumo.replace(".","").replace(",","."));
					}
					catch(e)
					{
						debug('validarPedidosMinimosDOM. thisPos:'+thisPos+' error:'+e);
					}
					
					return false;
				}
			});
		// Si el producto en cuestion NO se muestra por pantalla, recuperamos los datos del propio objeto JS
		}else{

			jQuery.each(producto.Ofertas, function(key2, oferta){
				if(producto.Ofertas[key2].OfertaAdjud == 'S'){
					numOfertas++;
					arrConsumos[key2] += parseFloat(producto.Ofertas[key2].Consumo.replace(".","").replace(",","."));
					return false;
				}
			});
		}
	});

	// Ahora recorremos de nuevo el array para mostrar/ocultar la imagen de aviso segun la validacion de pedido minimo
	for(i=0; i<arrConsumoProvs.length; i++){
		if(arrPedsMin[i] > arrConsumos[i] && arrConsumos[i] != 0){
			errPedMin = true;
			jQuery("#avisoProv_" + parseInt(i + 1)).show();
		}else{
			jQuery("#avisoProv_" + parseInt(i + 1)).hide();
		}
	}

	// Si existe alguna seleccion que no cumple el pedido minimo mostramos icono aviso en el floatingBox
	if(!errPedMin && numOfertas == arrProductos.length){
		jQuery('#FBAviso').html('&nbsp;<img src="http://www.newco.dev.br/images/check.gif" style="vertical-align:text-bottom;"/>');
	}else{
		jQuery('#FBAviso').html('&nbsp;<img src="http://www.newco.dev.br/images/atencion.gif" style="vertical-align:text-bottom;"/>');
	}
}

function validarPedidoMinimoProv(objRadio){
	var licOfeID	= jQuery(objRadio).val();
	var posArrProv	= parseInt(jQuery("#Prov_" + licOfeID).val());
	var posArrProd	= parseInt(jQuery(objRadio).attr("class").replace("RADIO_", ""));
	var provPedMin	= parseFloat(arrConsumoProvs[posArrProv].PedidoMin.replace(".","").replace(",","."));
	var Consumo = 0, ConsumoLast = 0, thisPosArrProv, wasChecked, isAnyChecked = false, isAnyCheckedLast = false;
	var lastPosArrProv = null, provPedMinLast;

	for(var i=0; i<ColumnaOrdenadaProds.length; i++){
		if(ColumnaOrdenadaProds[i] == posArrProd){
			wasChecked = arrRadios[(i-firstProduct)].checked;
			if(wasChecked){
				lastPosArrProv = arrRadios[(i-firstProduct)].numOferta;
			}
			break;
		}
	}
	if(lastPosArrProv != null)
		provPedMinLast	= parseFloat(arrConsumoProvs[lastPosArrProv].PedidoMin.replace(".","").replace(",","."));

	// Recorremos el array de productos entero
	jQuery.each(arrProductos, function(key, producto){
		// Si el producto en cuestion se muestra por pantalla, recuperamos los datos del radio button del DOM
		if(jQuery("tr#posArr_" + key).length){

			// Recorremos los N radio buttons del producto en cuestion para encontrar el que pertenece al proveedor que tiene la oferta
			jQuery(".RADIO_" + key).each(function(key2, thisRadio){
				thisPosArrProv = jQuery("#Prov_" + thisRadio.value).val();

				if(thisPosArrProv == posArrProv){ // Este es el radio button que cumple con el parametro posArrProv
					if(jQuery(thisRadio).is(':checked')){ // Si esta checked, entonces sumamos el consumo
						isAnyChecked = true;
						Consumo += parseFloat(producto.Ofertas[posArrProv].Consumo.replace(".","").replace(",","."));
					}
				}

				if(thisPosArrProv == lastPosArrProv && lastPosArrProv != null){ // Este es el radio button que cumple con el parametro posArrProv
					if(jQuery(thisRadio).is(':checked')){ // Si esta checked, entonces sumamos el consumo
						isAnyCheckedLast = true;
						ConsumoLast += parseFloat(producto.Ofertas[lastPosArrProv].Consumo.replace(".","").replace(",","."));
					}
				}
			});
		// Si el producto en cuestion NO se muestra por pantalla, recuperamos los datos del propio objeto JS
		}else{
			if(producto.Ofertas[posArrProv].OfertaAdjud == 'S'){
				Consumo += parseFloat(producto.Ofertas[posArrProv].Consumo.replace(".","").replace(",","."));
			}
			if(producto.Ofertas[lastPosArrProv].OfertaAdjud == 'S' && lastPosArrProv != null){
				ConsumoLast += parseFloat(producto.Ofertas[lastPosArrProv].Consumo.replace(".","").replace(",","."));
			}
		}
	});

	// Gestionamos la imagen para el proveedor para el que se ha seleccionado la oferta
	if(provPedMin > Consumo && Consumo != 0){
		jQuery("#avisoProv_" + parseInt(posArrProv + 1)).show();
	}else{
		jQuery("#avisoProv_" + parseInt(posArrProv + 1)).hide();
	}
	// Gestionamos la imagen para el proveedor que ha perdido la oferta, en el caso que hubiera uno previamente
	if(lastPosArrProv != null){
		if(provPedMinLast > ConsumoLast && ConsumoLast != 0){
			jQuery("#avisoProv_" + parseInt(lastPosArrProv + 1)).show();
		}else{
			jQuery("#avisoProv_" + parseInt(lastPosArrProv + 1)).hide();
		}
	}
}


//	16mar18	Se producen problemas al enviar más de 50 selecciones de golpe. Paginaremos en bloques de 50
function GuardarSeleccion(){
	var thisRowID, thisPosArr, thisLicProdID, isThisChecked;
	var ListaOfertas = '', errores = 0, numProdsTotal = 0, numProdsLista = 0, numProdsAdj = 0, controlPaginacion=0, MaxPagina=50, numPaginas=1;
	var d = new Date();

	// Numero de productos en la licitacion
	numProdsTotal = totalProductos;

	// Recorremos cada fila de la tabla
	jQuery('table#lProductos_OFE tbody tr').each(function(){
		numProdsLista++;
		thisRowID	= this.id;
		thisPosArr	= thisRowID.replace('posArr_', '');
		thisLicProdID	= arrProductos[thisPosArr].IDProdLic;

		// Asignamos el LicProdID al string ListaOfertas
		ListaOfertas += thisLicProdID + '|';

		//Para cada una de las ofertas de proveedor miro que radio button esta seleccionado
		jQuery(".RADIO_" + thisPosArr).each(function(){
			isThisChecked = jQuery(this).attr('checked') ? true:false;

			if(isThisChecked){
				numProdsAdj++;
				ListaOfertas += jQuery(this).val();
				arrProductos[thisPosArr].TieneSeleccion ='S';		//	3oct16	marcamos producto seleccionado 
			}
		});

		// Cerramos esta posicion
		ListaOfertas += '#';

		++controlPaginacion;
		if (controlPaginacion==MaxPagina)
		{
			ListaOfertas+='·';
			controlPaginacion=0;
			++numPaginas;
		}
		
		//solodebug debug('ListaOfertas:'+ListaOfertas+' controlPaginacion:'+controlPaginacion+'/'+MaxPagina+' numPaginas:'+numPaginas);
		
		
	});

	// Tiene que haber minimo una oferta seleccionada
	if(numProdsAdj == 0){
		errores++;
		alert(alrt_errSinOfertaSelec);
		return;
	}

	if(!errores){
		GuardarSeleccionAjax(ListaOfertas, numProdsLista, MaxPagina, 0, numPaginas, '');
	}
}


//	16mar18	Una vez creada la cadena completa, la enviamos por bloques
function GuardarSeleccionAjax(ListaOfertas, numProdsLista, MaxPagina, loop, loops, error)
{
	var thisRowID, thisPosArr, thisLicProdID, isThisChecked;
	var ListaOfertasPagina = '', errores = 0, numProdsTotal = 0, numProdsLista = 0, numProdsAdj = 0;
	var d = new Date();

	if (loop==loops)
	{
		if (!error)
		{
			alert(alrt_guardarSeleccionAdjOK);
		}
		else	//	6oct17 Aunque haya habido error, recargamos productos, ya que pueden haberse insertado algunos
		{
			alert(alrt_guardarSeleccionAdjKO);
		}

		jQuery(".botonAccion").show();
		return;
	}

	
	ListaOfertasPagina=Piece(ListaOfertas,'·',loop);

	//solodebug	debug('GuardarSeleccionAjax: '+ListaOfertas+ 'loop:'+loop+'loops:'+loop+' ListaOfertasPagina:'+ListaOfertasPagina);


	jQuery.ajax({
		cache:	false,
		url:	'http://www.newco.dev.br/Gestion/Comercial/SeleccionarProductos2AJAX.xsql',
		type:	"GET",
		data:	"IDLIC="+IDLicitacion+"&LISTAOFERTAS="+encodeURIComponent(ListaOfertasPagina)+"&_="+d.getTime(),
		contentType: "application/xhtml+xml",
		beforeSend: function(){
			jQuery(".botonAccion").hide();
		},
		success: function(objeto){
			//var data = eval("(" + objeto + ")");
			var data = JSON.parse(objeto);

			if(data.Resultado.Estado == 'OK'){
				jQuery('#idEstadoEnvio').html((MaxPagina*loop)+'/'+numProdsLista);
				++loop;
				GuardarSeleccionAjax(ListaOfertas, numProdsLista, MaxPagina, loop, loops, error);
			}
			return;
		},
		error: function(xhr, errorString, exception) {
			alert("xhr.status="+xhr.status+" error="+errorString+" exception="+exception);
		}
	});

}

/*	16mar18 Versión original de la función
function GuardarSeleccion(){
	var thisRowID, thisPosArr, thisLicProdID, isThisChecked;
	var ListaOfertas = '', errores = 0, numProdsTotal = 0, numProdsLista = 0, numProdsAdj = 0;
	var d = new Date();

	// Numero de productos en la licitacion
	numProdsTotal = totalProductos;

	// Recorremos cada fila de la tabla
	jQuery('table#lProductos_OFE tbody tr').each(function(){
		numProdsLista++;
		thisRowID	= this.id;
		thisPosArr	= thisRowID.replace('posArr_', '');
		thisLicProdID	= arrProductos[thisPosArr].IDProdLic;

		// Asignamos el LicProdID al string ListaOfertas
		ListaOfertas += thisLicProdID + '|';

		//Para cada una de las ofertas de proveedor miro que radio button esta seleccionado
		jQuery(".RADIO_" + thisPosArr).each(function(){
			isThisChecked = jQuery(this).attr('checked') ? true:false;

			if(isThisChecked){
				numProdsAdj++;
				ListaOfertas += jQuery(this).val();
				arrProductos[thisPosArr].TieneSeleccion ='S';		//	3oct16	marcamos producto seleccionado 
																	//	PENDIENTE: seria mejor jhacerlo en el onchange del checkbox
			}
		});

		// Cerramos esta posicion
		ListaOfertas += '#';
	});

	// Tiene que haber minimo una oferta seleccionada
	if(numProdsAdj == 0){
		errores++;
		alert(alrt_errSinOfertaSelec);
		return;
	}

	if(!errores){
		// Quitamos la ultima '#' del string ListaOfertas
		ListaOfertas = ListaOfertas.substring(0, ListaOfertas.length - 1);
		
		//solodebug		alert(ListaOfertas);

		jQuery.ajax({
			cache:	false,
			url:	'http://www.newco.dev.br/Gestion/Comercial/SeleccionarProductos2AJAX.xsql',
			type:	"GET",
			data:	"IDLIC="+IDLicitacion+"&LISTAOFERTAS="+encodeURIComponent(ListaOfertas)+"&_="+d.getTime(),
			contentType: "application/xhtml+xml",
			beforeSend: function(){
				jQuery(".botonAccion").hide();
			},
			success: function(objeto){
				var data = eval("(" + objeto + ")");

				if(data.Resultado.Estado == 'OK'){
				
					//26set16	No debería ser necesario recuperar datos
					//26set16	recuperaDatosProductosConOfertas();
					
					//	3oct16 Actualizar contador productos seleccionados
					ActualizarProdSeleccionados();
					
					CambiosEnOfertasSeleccionadas('N');			//2may17
				
					alert(alrt_guardarSeleccionAdjOK);
				}else{
					alert(alrt_guardarSeleccionAdjKO);
				}

				jQuery(".botonAccion").show();
			},
			error: function(xhr, errorString, exception) {
				alert("xhr.status="+xhr.status+" error="+errorString+" exception="+exception);
				jQuery(".botonAccion").show();
			}
		});
	}
}
*/

function AdjudicarOfertas(){
	var checkAdj = true, confirmChk=false, checkUdsXLote=false;
	
	if (ctrlCargaProv) return;	//	Desactivamos durante la carga de proveedores

	jQuery('.botonAccion').hide();
	
	//	21set16	Hacemos aqui las comprobaciones básicas que pueden dar lugar a errores antes de adjudicar
	//3oct16 Solo mostramos el aviso si no hay productos selecionados	if (((arrProductos.length>numProductos) && (numProdsSeleccion<numProductos))||(numProdsSeleccion==0)) {
	if (numProdsSeleccion==0) {
		productosOlvidados = 'S';
	}
	else{
		productosOlvidados = 'N';
	}
		

	//	14set20 Control fecha de pedido posterior a la actual
	var oForm = document.forms['form1'];
	if (oForm.elements['LIC_FECHAENTREGAPEDIDO'].value!='')
	{
		var hoy = new Date(),
		hoyOrd=hoy.getFullYear()*10000+(hoy.getMonth()+1)*100+hoy.getDate();			//	Este formato es más eficiente para comparar fechas

		var AnnoPed=parseInt(Piece(oForm.elements['LIC_FECHAENTREGAPEDIDO'].value,'/',2));
		if (AnnoPed<2000) AnnoPed+=2000;

 		var fechaPed=AnnoPed*10000+parseInt(Piece(oForm.elements['LIC_FECHAENTREGAPEDIDO'].value,'/',1))*100+parseInt(Piece(oForm.elements['LIC_FECHAENTREGAPEDIDO'].value,'/',0));

		//	solodebug
		console.log('GenerarPedido. hoyOrd:'+hoyOrd+' fechaPed:'+fechaPed);

		if (fechaPed<=hoyOrd)
		{
			alert(alrt_fechaEntregaPedidoAnteriorAFechaDeHoy);
			return;
		}
	}
		
	//solodebug	alert('AdjudicarOfertas numProdsSeleccion:'+numProdsSeleccion+' productosOlvidados:'+productosOlvidados);
		

	if(productosOlvidados == 'N'){

		//ET 22/2/16	alert('Probando, paso1, pedidos minimos');//ET 22/2/16

		// Solo validamos importe pedido minimo para licitaciones de 'pedido puntual'
		if(mesesSelected == 0){
			if	(isLicAgregada == 'S')
			{
				checkAdj = validarPedidosMinimosAgr();
				if (!checkAdj)
				{
					if (saltarPedMinimo=='N')						//	7nov19 Permitir saltar pedido mínimo
						alert(alrt_pedidoMinimoGlobalKO);
					else
						checkAdj=confirm(alrt_avisoSaltarPedidoMinimo);
				}
			}
			else
				checkAdj = validarPedidosMinimos(1);
		}


		//ET 22/2/16	alert('Probando, paso2, pedidos minimos:'+checkAdj);//ET 22/2/16

		if(checkAdj){
			// Comprobamos cantidad respecto udsXLote del proveedor
			var checkUdsXLote;
			if	(isLicAgregada == 'S')
			{
				checkUdsXLote = compruebaUdsXLoteAgr();
			}
			else
			{
				checkUdsXLote = compruebaUdsXLote();
			}
				
			//ET 22/2/16	alert('Probando, paso3, comprueba unidades lote:'+checkUdsXLote);//ET 22/2/16

			if(!checkUdsXLote){
				if(confirm(conf_autoeditar_uds_x_lote)){
					if	(isLicAgregada == 'S')
					{
						calcularCantidadesAutoAgr();
					}
					else
					{
						calcularCantidadesAuto();
					}
					jQuery('.botonAccion').show();
					return;
				}else{
					jQuery('.botonAccion').show();
					return;
				}
			}

			// Antes de adjudicar pedimos confirmacion
			if(numProdsSeleccion < totalProductos){
				//ET 22/2/16	alert('Probando, paso5, pedir confirmacion');//ET 22/2/16
				if(confirm(conf_adjudicar1 + conf_adjudicar2.replace("[[NUM_PROD_TOTAL]]", totalProductos).replace("[[NUM_PROD_ADJ]]", numProdsSeleccion))){
					confirmChk = true;
				}
			}else{
				if(confirm(conf_adjudicar1)){
					confirmChk = true;
				}
			}

			//ET 22/2/16	alert('Probando, paso, confirmar adjudicación:'+confirmChk);//ET 22/2/16
			if(confirmChk)
			{
				jQuery("#botonAdjudicarSelec").hide();	//25oct17
				jQuery("#waitBotonAdjudicar").show();	//25oct17
				CambioEstadoLicitacion('ADJ');
			}
		}
	}else{
		alert(alrt_faltaSeleccProductos);
	}

	//ET 22/2/16	alert('Probando, SALIDA');//ET 22/2/16
	jQuery('.botonAccion').show();
}

function compruebaUdsXLote(){
	var Cantidad, CantidadFormat, UdsXLote, UdsXLoteFormat, toReturn=true;

	jQuery.each(arrProductos, function(key, producto){
		Cantidad	= producto.Cantidad;
		CantidadFormat	= parseFloat(Cantidad.replace(".","").replace(",","."));
		UdsXLote	= '0';
		UdsXLoteFormat	= 0;

		jQuery.each(producto.Ofertas, function(key2, oferta){
			if(oferta.OfertaAdjud == 'S'){
				UdsXLote	= oferta.UdsXLote;
				UdsXLoteFormat	= parseFloat(UdsXLote.replace(".","").replace(",","."));
				return false;
			}
		});

		//	solodebug	if(UdsXLoteFormat) debug('compruebaUdsXLote.UdsXLoteFormat:'+UdsXLoteFormat+' CantidadFormat:'+CantidadFormat+' esEntero:'+esEntero(Math.round((CantidadFormat/UdsXLoteFormat)*1000)/1000));

		// Aqui validamos Cantidad vs UdsXLote
		// ET - 6oct16 - Redondeamos a tres decimales para no tener problemas en calculos javascript
		//if(UdsXLoteFormat && !esEntero(CantidadFormat/UdsXLoteFormat)){
		if(UdsXLoteFormat && !esEntero(Math.round((CantidadFormat/UdsXLoteFormat)*1000)/1000)){
			toReturn = false;

			//	solodebug	debug('compruebaUdsXLote.UdsXLoteFormat:'+UdsXLoteFormat+' CantidadFormat:'+CantidadFormat+' esEntero:'+esEntero(Math.round((CantidadFormat/UdsXLoteFormat)*1000)/1000)+ ' return FALSE');

			return false;
		}
	});

	//	solodebug	debug('compruebaUdsXLote.UdsXLoteFormat:'+UdsXLoteFormat+' CantidadFormat:'+CantidadFormat+' esEntero:'+esEntero(Math.round((CantidadFormat/UdsXLoteFormat)*1000)/1000)+ ' return '+toReturn);

	return toReturn;
}

//	13mar17	Comprueba unidades por lote en licitaciones agregadas
function compruebaUdsXLoteAgr(){
	var IDProductoLic, IDCentro, Cantidad, CantidadFormat, UdsXLote, UdsXLoteFormat, toReturn=true;

	jQuery.each(arrProductosPorCentro, function(key, productoPorCentro)
	{
	
		IDProductoLic	= productoPorCentro.IDProdLic;
		
		for (j=0;j<productoPorCentro.Centros.length;++j)
		{

			IDCentro	= productoPorCentro.Centros[j].IDCentro;
			Cantidad	= productoPorCentro.Centros[j].Cantidad;
			CantidadFormat	= parseFloat(Cantidad.replace(".","").replace(",","."));
			UdsXLote	= '0';
			UdsXLoteFormat	= 0;

			//solodebug	debug('compruebaUdsXLoteAgr: Producto, ref:'+productoPorCentro.RefCliente+' cant:'+Cantidad+' IDCentro:'+IDCentro);

			//	Buscamos el producto asociado al producto por centro
			var productoConOfertas;
			jQuery.each(arrProductos, function(key, producto){
				if (producto.IDProdLic==IDProductoLic) productoConOfertas=producto;
			});
			
			jQuery.each(productoConOfertas.Ofertas, function(key2, oferta){
						
				if(oferta.OfertaAdjud == 'S'){

					//solodebug	debug('compruebaUdsXLoteAgr: Producto, IDProductoLic:'+IDProductoLic+' ref:'+productoPorCentro.RefCliente+' IDCentro:'+IDCentro+' cant:'+Cantidad+' IDCentro:'+IDCentro+ 'Oferta, udes lote:'+oferta.UdsXLote);

					UdsXLote	= oferta.UdsXLote;
					UdsXLoteFormat	= parseFloat(UdsXLote.replace(".","").replace(",","."));
					return false;
				}
			});
			

			// Aqui validamos Cantidad vs UdsXLote
			// ET - 6oct16 - Redondeamos a tres decimales para no tener problemas en calculos javascript
			//if(UdsXLoteFormat && !esEntero(CantidadFormat/UdsXLoteFormat)){
			if(UdsXLoteFormat && !esEntero(Math.round((CantidadFormat/UdsXLoteFormat)*1000)/1000)){

				//solodebug	debug('compruebaUdsXLoteAgr, NO ENCAJAN: Producto, IDProductoLic:'+IDProductoLic+' IDCentro:'+IDCentro+' cant:'+Cantidad+'Oferta, udes lote:'+UdsXLoteFormat);

				toReturn = false;
				return false;
			}
		}
	});

	return toReturn;
}

function calcularCantidadesAuto(){
	var Cantidad, CantidadFormat, RefProducto, NombreProducto, UdsXLote, UdsXLoteFormat, newCantidad, cont=0;
	var ListaProductos = '', thisAviso = '';

	jQuery.each(arrProductos, function(key, producto){
		RefProducto	= (producto.RefCliente != '') ? producto.RefCliente : producto.RefEstandar;
		NombreProducto = producto.Nombre;
		Cantidad	= producto.Cantidad;
		CantidadFormat	= parseFloat(Cantidad.replace(".","").replace(",","."));
		UdsXLote	= '0';
		UdsXLoteFormat	= 0;
		thisAviso = alrt_avisoCambioUnidades;

		jQuery.each(producto.Ofertas, function(key2, oferta){
			if(oferta.OfertaAdjud == 'S'){
				UdsXLote	= oferta.UdsXLote;
				UdsXLoteFormat	= parseFloat(UdsXLote.replace(".","").replace(",","."));
				return false;
			}
		});

		// Aqui validamos Cantidad vs UdsXLote
		//if(UdsXLoteFormat && !esEntero(CantidadFormat/UdsXLoteFormat)){
		// DC - 15ene16 - Redondeamos a tres decimales para no tener problemas en calculos javascript
		// ET 6oct16 Solo para UdsXLoteFormat>0, este error no debería producirse pero es mejor prevenir
		if((UdsXLoteFormat>0) && !esEntero(Math.round((CantidadFormat/UdsXLoteFormat)*1000)/1000)){
			cont++
			// Cantidad y UdsXLote no corresponden => nueva cantidad es:
			newCantidad = Math.ceil(CantidadFormat/UdsXLoteFormat) * UdsXLoteFormat;
			newCantidadStr=newCantidad.toString();

			//alert('Ref.:'+producto.RefEstandar+' udes.lote:'+UdsXLoteFormat+' Cantidad:'+CantidadFormat+' Cantidad corregida:'+newCantidad);	//22/2/16	ET
			thisAviso = thisAviso.replace('[[REFPRODUCTO]]', RefProducto);
			thisAviso = thisAviso.replace('[[PRODUCTO]]', NombreProducto);
			thisAviso = thisAviso.replace('[[UNIDADESPORLOTE]]', UdsXLoteFormat);
			thisAviso = thisAviso.replace('[[UNIDADES_OLD]]', CantidadFormat);
			thisAviso = thisAviso.replace('[[UNIDADES_NEW]]', newCantidadStr.replace('.',','));
			
			//	14ene20 Pedimos confirmación antes de hacer el cambio
			if (confirm(thisAviso))
			{

				//	22/2/16	ET	ListaProductos += producto.IDProdLic + '|' + newCantidad.replace('.',',') + '#';
				ListaProductos += producto.IDProdLic + '|' + newCantidadStr.replace('.',',') + '#';

				//	28set16	ET Actualizamos también el array de productos, que no se recarga al recargar ofertas, y en la pantalla
				producto.Cantidad = newCantidadStr;
			}
						
		}
	});
	//debug(ListaProductos);
	//return;

	ActualizarCantidades(ListaProductos);
	dibujaTablaProductosOFE();		//	28set16	ET Actualizamos también en la pantalla
	jQuery('.botonAccion').show();	//	28set16	ET y mostramos los botones
	
}


//	13mar17	Calcula cantidades que cumplan con unidades por lote en licitaciones agregadas
function calcularCantidadesAutoAgr()
{
	//solodebug	alert('calcularCantidadesAutoAgr');

	var IDProductoLic, IDCentro, RefProducto, PosProducto, NombreProducto, Cantidad, CantidadTotal,CantidadFormat, UdsXLote, UdsXLoteFormat, toReturn=true, newCantidad, cont=0;
	var ListaProductos = '', thisAviso = '';

	jQuery.each(arrProductosPorCentro, function(key, productoPorCentro)
	{
	
		IDProductoLic	= productoPorCentro.IDProdLic;
		
		for (j=0;j<productoPorCentro.Centros.length;++j)
		{

			RefProducto	= (productoPorCentro.RefCliente != '') ? productoPorCentro.RefCliente : productoPorCentro.RefEstandar;
			IDCentro	= productoPorCentro.Centros[j].IDCentro;
			Cantidad	= productoPorCentro.Centros[j].Cantidad;
			CantidadFormat	= parseFloat(Cantidad.replace(".","").replace(",","."));
			UdsXLote	= '0';
			UdsXLoteFormat	= 0;
			thisAviso = alrt_avisoCambioUnidades;

			//solodebug	debug('compruebaUdsXLoteAgr: Producto, ref:'+productoPorCentro.RefCliente+' cant:'+Cantidad+' IDCentro:'+IDCentro);

			//	Buscamos el producto asociado al producto por centro
			var productoConOfertas;
			PosProducto=-1;
			/*
			jQuery.each(arrProductos, function(key, producto){
				if (producto.IDProdLic==IDProductoLic) 
				{
					productoConOfertas=producto;
					NombreProducto = producto.Nombre;
				}

			});
			*/
			for (k=0;(k<arrProductos.length)&&(PosProducto==-1);++k)
				if (arrProductos[k].IDProdLic==IDProductoLic) 
				{
					PosProducto=k;
					productoConOfertas=arrProductos[k];
					NombreProducto = arrProductos[k].Nombre;
				}
			
			
			jQuery.each(productoConOfertas.Ofertas, function(key2, oferta){
						
				if(oferta.OfertaAdjud == 'S'){

					//solodebug
					debug('calcularCantidadesAutoAgr: Producto, IDProductoLic:'+IDProductoLic+' ref:'+productoPorCentro.RefCliente+' IDCentro:'+IDCentro+' cant:'+Cantidad+' IDCentro:'+IDCentro+ 'Oferta, udes lote:'+oferta.UdsXLote);

					UdsXLote	= oferta.UdsXLote;
					UdsXLoteFormat	= parseFloat(UdsXLote.replace(".","").replace(",","."));
					return false;
				}
			});
			

			// Aqui validamos Cantidad vs UdsXLote
			// ET - 6oct16 - Redondeamos a tres decimales para no tener problemas en calculos javascript
			//if(UdsXLoteFormat && !esEntero(CantidadFormat/UdsXLoteFormat)){
			if(UdsXLoteFormat && !esEntero(Math.round((CantidadFormat/UdsXLoteFormat)*1000)/1000)){
				cont++
				// Cantidad y UdsXLote no corresponden => nueva cantidad es:
				newCantidad = Math.ceil(CantidadFormat/UdsXLoteFormat) * UdsXLoteFormat;
				newCantidadStr=newCantidad.toString();

				//alert('Ref.:'+producto.RefEstandar+' udes.lote:'+UdsXLoteFormat+' Cantidad:'+CantidadFormat+' Cantidad corregida:'+newCantidad);	//22/2/16	ET
				thisAviso = thisAviso.replace('[[REFPRODUCTO]]', RefProducto);
				thisAviso = thisAviso.replace('[[PRODUCTO]]', NombreProducto);
				thisAviso = thisAviso.replace('[[UNIDADESPORLOTE]]', UdsXLoteFormat);
				thisAviso = thisAviso.replace('[[UNIDADES_OLD]]', CantidadFormat);
				thisAviso = thisAviso.replace('[[UNIDADES_NEW]]', newCantidadStr.replace('.',','));
				alert(thisAviso);

				//solodebug	debug('calcularCantidadesAutoAgr:'+cont+' '+NombreProducto+' Cant:'+CantidadFormat+' Udes/Lote:'+UdsXLoteFormat+ ' ratio:'+(CantidadFormat/UdsXLoteFormat)+' ceil:'+(Math.ceil(CantidadFormat/UdsXLoteFormat))+' cant. corregida:'+newCantidad);

				ListaProductos += IDCentro + '|' + IDProductoLic + '|' + newCantidadStr.replace('.',',') + '#';

				//	28set16	ET Actualizamos también el array de productos por centro, que no se recarga al recargar ofertas, y en la pantalla
				productoPorCentro.Centros[j].Cantidad = newCantidadStr;
				
				//	Recálcula la cantidad total por producto
				CantidadTotal=0;
				for (l=0;l<productoPorCentro.Centros.length;++l)
				{
					CantidadTotal+=parseFloat(productoPorCentro.Centros[l].Cantidad.replace(',','.'));
					debug('calcularCantidadesAutoAgr: ['+l+ '] IDCentro:'+productoPorCentro.Centros[l].IDCentro+ ' Cant.:'+productoPorCentro.Centros[l].Cantidad+ ' Cant.Total Act:'+CantidadTotal);
				}

				//solodebug	debug('calcularCantidadesAutoAgr:'+cont+' '+NombreProducto+' Cant:'+CantidadFormat+' Udes/Lote:'+UdsXLoteFormat+ ' Cant.Total	Ant:'+arrProductos[PosProducto].Cantidad+' Cant.Total Act:'+CantidadTotal);

				arrProductos[PosProducto].Cantidad=CantidadTotal.toString().replace('.',',');
			}
		}
	});

	//	PENDIENTE ACTUALIZAR CANTIDADES POR CENTRO
	//solodebug	alert(ListaProductos);

	ActualizarCantidadesAgr(ListaProductos);
	dibujaTablaProductosOFE();		//	Actualizamos también en la pantalla
	jQuery('.botonAccion').show();	//	y mostramos los botones

}


function ActualizarCantidades(string){
	var d = new Date();

	jQuery.ajax({
		cache:	false,
		url:	'http://www.newco.dev.br/Gestion/Comercial/ActualizarCantidadesAJAX.xsql',
		type:	"POST",
		async:	false,
		data:	"LIC_ID="+IDLicitacion+"&LISTA_PRODUCTOS="+encodeURIComponent(string)+"&_="+d.getTime(),
		error: function(objeto, quepaso, otroobj){
			alert('error'+quepaso+' '+otroobj+' '+objeto);
		},
		success: function(objeto){
			//var data = eval("(" + objeto + ")");
			var data = JSON.parse(objeto);

			if(data.CantidadesActualizadas.estado == 'OK'){
				//	28set16	ET No debería ser necesario recargar nada, recalculamos directamente
				//recuperaDatosProductosConOfertas();
				alert(alrt_CantsActualizadasOK);
			}else{
				alert(alrt_CantsActualizadasKO);
        return;
			}
		}
	});
}


function ActualizarCantidadesAgr(string){
	var d = new Date();

	jQuery.ajax({
		cache:	false,
		url:	'http://www.newco.dev.br/Gestion/Comercial/ActualizarCantidadesAgrAJAX.xsql',
		type:	"POST",
		async:	false,
		data:	"LIC_ID="+IDLicitacion+"&LISTA_PRODUCTOS="+encodeURIComponent(string)+"&_="+d.getTime(),
		error: function(objeto, quepaso, otroobj){
			alert('error'+quepaso+' '+otroobj+' '+objeto);
		},
		success: function(objeto){
			//var data = eval("(" + objeto + ")");
			var data = JSON.parse(objeto);

			if(data.CantidadesActualizadas.estado == 'OK'){
				//	28set16	ET No debería ser necesario recargar nada, recalculamos directamente
				//recuperaDatosProductosConOfertas();
				alert(alrt_CantsActualizadasOK);
			}else{
				alert(alrt_CantsActualizadasKO);
        return;
			}
		}
	});
}




function formPreciosObj(){
	var dialog	= jQuery('#floatingBoxOBJ');
	var width	= (jQuery(window).width() - dialog.width()) / 2;
	var height	= (jQuery(window).height() - dialog.height()) / 3;

	dialog.css({
		'position':'absolute',
		'left':width+'px',
		'top':height+'px'
	});

	jQuery('#floatingBoxOBJ').show();
}

function cerrarPreciosObj(){
	jQuery('#floatingBoxOBJ').hide();
}

function calcularPreciosObj(){
	var valPorc	= jQuery("#valPorc").val();
	var reg		= /^\d+$/;
	var classSrc, inputSrc, inputDest, thisID, thisPosArr, thisValue, thisValueFormat, thisPrecioObjFormat, isAny = false;

	// Validacion del campo
	if(valPorc == ''){
		alert(val_faltaPorcentaje);
		jQuery("#valPorc").focus();
		return;
	}else if(!reg.test(valPorc)){
		alert(val_errorPorcentaje1);
		jQuery("#valPorc").focus();
		return;
	}else{
		valPorc = parseInt(valPorc);

		if(valPorc <= 0 || valPorc > 100){
			alert(val_errorPorcentaje2);
			jQuery("#valPorc").focus();
			return;
		}
	}

	jQuery('#floatingBoxOBJ').hide();

	if(jQuery(".preciorefiva").length){
		classSrc	= 'preciorefiva';
		inputSrc	= 'PRECIOREFIVA_';
		inputDest	= 'PRECIO_OBJIVA_';
	}else{
		classSrc	= 'precioref';
		inputSrc	= 'PRECIOREF_';
		inputDest	= 'PRECIO_OBJ_';
	}

	jQuery("input." + classSrc).each(function(key, input){
		thisID		= this.id;
		thisPosArr	= thisID.replace(inputSrc, '');
		thisValue	= this.value;
		thisValueFormat	= parseFloat(desformateaDivisa(thisValue));

		if(!esNulo(thisValueFormat) && !isNaN(thisValueFormat)){
			// Para este caso calculamos el precio objetivo
			thisPrecioObjFormat = thisValueFormat - (thisValueFormat * valPorc / 100);
			jQuery("#" + inputDest + thisPosArr).val(anyadirCerosDecimales(reemplazaPuntoPorComa(thisPrecioObjFormat),4));
			isAny = true;
		}
	});

	if(isAny){
		alert(alrt_PreciosObjCalculadosOK);
	}
}

//	5set16	En el caso de licitación agregada, resulta complicado el cálculo del pedido minimo. Hacemos petición ajax al servidor para comprobarlo.
function validarPedidosMinimosAgr(){

	var d = new Date();
	var Result;

	jQuery.ajax({
		cache:	false,
		url:	'http://www.newco.dev.br/Gestion/Comercial/licComprobarPedidoMinimoAJAX.xsql',
		type:	"POST",
		async:	false,
		data:	"LIC_ID="+IDLicitacion+"&_="+d.getTime(),
		error: function(objeto, quepaso, otroobj){
			alert('error'+quepaso+' '+otroobj+' '+objeto);
			
			Result = 'N';
		},
		success: function(objeto){
			//var data = eval("(" + objeto + ")");
			var data = JSON.parse(objeto);
			
			Result = (data.CumplePedidoMinimo=='S')?true:false;

		}
	});

	return Result;
}


function validarPedidosMinimos(option){
	var arrPedMin		= {};
	var arrProvTotal	= {};
	var arrProvNom		= {};

	jQuery.each(arrConsumoProvs, function(key, proveedor){
		arrProvNom[key] = proveedor.NombreCorto;
		arrPedMin[key] = proveedor.PedidoMin;
		arrProvTotal[key] = 0;
	});

	var Cantidad, CantidadFormato, PrecioOferta, PrecioOfertaFormato;

	jQuery.each(arrProductos, function(key, producto){
		jQuery.each(producto.Ofertas, function(key2, oferta){
			if(oferta.OfertaAdjud == 'S'){
				Cantidad		= producto.Cantidad;
				CantidadFormato		= Cantidad.replace(".","").replace(",",".");
//				(mostrarPrecioIVA == 'S') ? PrecioOferta = oferta.PrecioIVA : PrecioOferta = oferta.Precio;
				PrecioOferta = oferta.Precio;
				PrecioOfertaFormato	= PrecioOferta.replace(".","").replace(",",".");

        arrProvTotal[key2] += CantidadFormato * PrecioOfertaFormato;
			}
		});
	});

	var error = false, msg = '', importePedido, pedidoMinimo;

	jQuery.each(arrProvTotal, function(key, value){
		if(value > 0 && value < arrPedMin[key].replace(".","").replace(",",".")){
			error = true;
			importePedido	= FormateaNumeroNacho(value.toFixed(2));
			pedidoMinimo	= arrPedMin[key];
			msg += alrt_pedidoMinimoKO.replace('[[IMP_PEDIDO]]',importePedido).replace('[[PROV_NOMBRE]]',arrProvNom[key]).replace('[[PED_MINIMO]]',pedidoMinimo)+'\n';
			if(option == 2){
				jQuery("#avisoProv_" + (parseInt(key) + 1)).show();
			}
		}
	});

	if(error)
	{
		if(option == 1)
		{
			if (saltarPedMinimo=='N')
				alert(msg);
			else
				error=!confirm(msg+'\n'+alrt_avisoSaltarPedidoMinimo);
		}
  	}
	
	//solodebug debug('validarPedidosMinimos error:'+error);
	
	return !error;
}

// Pluguin que permite desmarcar un radio button seleccionado previamente
(function(jQuery){
	jQuery.fn.uncheckableRadio = function() {

		return this.each(function(){
			jQuery(this).mousedown(function() 
			{
				jQuery(this).data('wasChecked', this.checked);
			});

			jQuery(this).click(function() {
				if (jQuery(this).data('wasChecked'))
				{
					this.checked = false;
                }
			});
		});
	};
})( jQuery );



function dibujaSubirFT(ID){
	var innerHTML, thisRow, thisCell;

	innerHTML = divStartClassID.replace('#ID#', 'cargaDocFT');
	innerHTML = innerHTML.replace('#CLASS#', 'divLeft80');

	innerHTML += '<table class="infoTable" border="0">';
	thisRow = rowStart;

	thisCell = cellStartClass.replace('#CLASS#', 'labelRight quince');
	thisCell += spanStartClass.replace('#CLASS#', 'textFT_' + ID);
	thisCell += str_SubirFicha;
	thisCell += spanEnd;
	thisCell += cellEnd;
	thisRow += thisCell;

	thisCell = cellStartClass.replace('#CLASS#', 'datosLeft trenta');
	thisCell += divStartClass.replace('#CLASS#', 'altaDocumento');
	thisCell += spanStartClass.replace('#CLASS#', 'anadirDoc');
	thisCell += divStartClassID.replace('#CLASS#', 'docLine').replace('#ID#', 'docLine_' + ID);
	thisCell += divStartClassID.replace('#CLASS#', 'docLongEspec').replace('#ID#', 'docLongEspec_' + ID);
	thisMacro = macroInputFile.replace('#NAME#', 'inputFileDoc');
	thisMacro = thisMacro.replace('#ID#', 'inputFileDoc_' + ID);
	//5mar19	thisMacro = thisMacro.replace('#ONCHANGE#', 'addDocFile(' + ID + ');');
	thisMacro = thisMacro.replace('#ONCHANGE#', 'addDocFile(document.forms[\'ProductosProveedor\'],' + ID + ');');
	thisCell += thisMacro;
	thisCell += divEnd;
	thisCell += divEnd;
	thisCell += spanEnd;
	thisCell += divEnd;
	thisCell += cellEnd;
	thisRow += thisCell;

	thisCell = cellStartClass.replace('#CLASS#', 'veinte');
	thisCell += divStartClass.replace('#CLASS#', 'botonLargo');
	thisCell += macroEnlace.replace('#HREF#', 'javascript:cargaDoc(document.forms[\'ProductosProveedor\'],\'FT\',' + ID + ');');
	thisCell += spanStartClass.replace('#CLASS#', 'textFT') + str_SubirFicha + spanEnd;
	thisCell += macroEnlaceEnd;
	thisCell += divEnd;
	thisCell += cellEnd;
	thisRow += thisCell;

	thisCell = cellStart;
	thisCell += divStartIDAlign.replace('#ID#', 'waitBoxDoc_' + ID).replace('#ALIGN#', 'center');
	thisCell += '&nbsp;';
	thisCell += divEnd;
	thisCell += divStartIDStyAlg.replace('#ID#', 'confirmBox_' + ID).replace('#STYLE#', 'display:none;').replace('#ALIGN#', 'center');
	thisCell += spanStartClassStyle.replace('#CLASS#', 'cargado').replace('#STYLE#', 'font-size:10px;');
	thisCell += '¡' + str_DocCargado + '!';
	thisCell += spanEnd;
	thisCell += divEnd;
	thisCell += cellEnd;
	thisRow += thisCell;

	thisRow += rowEnd;
	innerHTML += thisRow;
	innerHTML += '</table>';

	innerHTML += divEnd;

	return innerHTML;
}


// FUNCIONES PARA CATALOGAR Y EMPLANTILLAR

// Funcion (ajax) que comprueba si los datos de la oferta del proveedor (LIC_PRODUCTOSOFERTAS)
// Ya existen en el Catalogo de Productos (PRODUCTOS)
// Pide confirmacion por parte del usuario para crear los productos en el catalogo
function ComprobarCatalogoProveedor(){
	var d = new Date();

	jQuery.ajax({
		cache:	false,
		url:	'http://www.newco.dev.br/Gestion/Comercial/ComprobarCatalogoProveedor.xsql',
		type:	"GET",
		data:	"LIC_ID="+IDLicitacion+"&_="+d.getTime(),
		contentType: "application/xhtml+xml",
		beforeSend: function(){
			jQuery("#botonInsCatProv").hide();
			jQuery("#waitBotonInsCatProv").show();
		},
		error: function(objeto, quepaso, otroobj){
			alert('error'+quepaso+' '+otroobj+' '+objeto);
		},
		success: function(objeto){
			//var data = eval("(" + objeto + ")");
			var data = JSON.parse(objeto);
			var sMensj, sError, bResIns;

			sMensj		= Piece(data.Mensaje, '#',0);
			sError		= Piece(data.Mensaje, '#',1);

			if(sError == ''){	// No hay errores
				bResIns		= confirm(sMensj.replace(/\|/g,"\n") + '\n\n' + conf_InsertarCatalogoProv);
				if(bResIns){
					InsertarEnCatalogoProveedor();
				}else{
					jQuery("#waitBotonInsCatProv").hide();
					jQuery("#botonInsCatProv").show();
				}
			}else{	// Hay errores
				alert(sError.replace(/\|/g,"\n"));
				jQuery("#waitBotonInsCatProv").hide();
				jQuery("#botonInsCatProv").show();
			}
		}
	});
}

// Funcion (ajax) que inserta o actualiza los datos de los productos de la oferta del proveedor (LIC_PRODUCTOSOFERTAS)
// En el catalogo (PRODUCTOS). Llamada desde  la funcion ComprobarCatalogoProveedor()
function InsertarEnCatalogoProveedor(){
	var d = new Date();

	jQuery.ajax({
		cache:	false,
		url:	'http://www.newco.dev.br/Gestion/Comercial/InsertarEnCatalogoProveedor.xsql',
		type:	"GET",
		data:	"LIC_ID="+IDLicitacion+"&_="+d.getTime(),
		contentType: "application/xhtml+xml",
		error: function(objeto, quepaso, otroobj){
			alert('error'+quepaso+' '+otroobj+' '+objeto);
		},
		success: function(objeto){
			//var data = eval("(" + objeto + ")");
			var data = JSON.parse(objeto);

			if(data.Resultado.Estado == 'OK'){
				alert(data.Resultado.Mensaje);
				jQuery("#waitBotonInsCatProv").hide();
				jQuery("#botonInsEnPlant").show();
                        }else{
				alert(alrt_InsertarCatProvKO);
				jQuery("#waitBotonInsCatProv").hide();
				jQuery("#botonInsCatProv").show();
                        }
		}
	});
}

// Funcion (ajax) que comprueba que los productos de la licitacion (LIC_PRODUCTOS) no estan en el catalogo privado del cliente (segun CP_PRO_REFERENCIA)
// Pide confirmacion para emplantillar si no hay errores
function ComprobarYAdjudicarCatalogoCliente(){
	var d = new Date();

	jQuery.ajax({
		cache:	false,
		url:	'http://www.newco.dev.br/Gestion/Comercial/ComprobarCatalogoCliente.xsql',
		type:	"GET",
		data:	"LIC_ID="+IDLicitacion+"&_="+d.getTime(),
		contentType: "application/xhtml+xml",
		beforeSend: function(){
			jQuery("#botonInsEnPlant").hide();
			jQuery("#waitBotonInsEnPlant").show();
		},
		error: function(objeto, quepaso, otroobj){
			alert('error'+quepaso+' '+otroobj+' '+objeto);
		},
		success: function(objeto){
			//var data = eval("(" + objeto + ")");
			var data = JSON.parse(objeto);
			var sMensj, sError, bResIns;

			sMensj		= Piece(data.Mensaje, '#',0);
			sError		= Piece(data.Mensaje, '#',1);

			if(sError == ''){	// No hay errores
				bResIns		= confirm(sMensj.replace(/\|/g,"\n") + '\n\n' + conf_InsertarEnPlantilla);
				if(bResIns){
					InsertarEnPlantilla();
				}else{
					jQuery("#waitBotonInsEnPlant").hide();
					jQuery("#botonInsEnPlant").show();
				}
			}else{	// Hay errores
				alert(sError.replace(/\|/g,"\n"));
				jQuery("#waitBotonInsEnPlant").hide();
				jQuery("#botonInsEnPlant").show();

			}
		}
	});
}

// Funcion (ajax) que actualiza los productos en el cat.priv (CATPRIV_PRODUCTOSESTANDAR) y los inserta en las plantillas
function InsertarEnPlantilla(){
	var d = new Date();

	jQuery.ajax({
		cache:	false,
		url:	'http://www.newco.dev.br/Gestion/Comercial/InsertarEnPlantilla.xsql',
		type:	"GET",
		data:	"LIC_ID="+IDLicitacion+"&_="+d.getTime(),
		contentType: "application/xhtml+xml",
		error: function(objeto, quepaso, otroobj){
			alert('error'+quepaso+' '+otroobj+' '+objeto);
		},
		success: function(objeto){
			//var data = eval("(" + objeto + ")");
			var data = JSON.parse(objeto);

			if(data.Resultado.Estado == 'OK')
			{
				jQuery("#waitBotonInsEnPlant").hide();
				alert(data.Resultado.Mensaje);
                Recarga();	//23jul19	               location.reload();
            }
			else
			{
				jQuery("#waitBotonInsEnPlant").hide();
				jQuery("#botonInsEnPlant").show();
				alert(alrt_InsertarEnPlantillaKO);
            }
		}
	});
}

// Se recupera los valores del desplegbale de lugares de entrega si se cambia el usuario responsable del pedido puntual
function recuperaLugaresEntrega(IDCentroUsuario){
	var d = new Date();
	
	var IDCentro=Piece(IDCentroUsuario,':',0);

	jQuery.ajax({
		url:	"http://www.newco.dev.br/Gestion/Comercial/LugaresEntregaPedidoAJAX.xsql",
		//14set20	data:	"IDUSUARIO="+IDUsuario+"&_="+d.getTime(),
		data:	"IDCENTRO="+IDCentro+"&_="+d.getTime(),
		type:	"GET",
		contentType: "application/xhtml+xml",
		beforeSend: function(){
			null;
		},
		error: function(objeto, quepaso, otroobj){
			alert('error'+quepaso+' '+otroobj+''+objeto);
		},
		success: function(objeto){
			//var data = eval("(" + objeto + ")");
			var data = JSON.parse(objeto);

			jQuery("#LIC_IDLUGARENTREGA").empty();
			jQuery("#LIC_IDLUGARENTREGA").append("<option value=''>" + str_Selecciona + "</option>");

			for(var i=0;i<data.ListaLugares.length;i++){
				jQuery("#LIC_IDLUGARENTREGA").append("<option value='"+data.ListaLugares[i].id+"'>"+data.ListaLugares[i].lugar+"</option>");
			}
		}
	});
}

// Funcion (AJAX) que lanza el proceso que genera los pedidos necesarios en una licitacion de pedido puntual
function GenerarPedido(){
	var d = new Date();
	var mensaje;
	
	
	/*var hoy = new Date(),
	hoyOrd=hoy.getFullYear()*10000+(hoy.getMonth()+1)*100+hoy.getDate();			//	Este formato es más eficiente para comparar fechas

 	var fechaPed=parseInt(Piece(oForm.elements['LIC_FECHAENTREGAPEDIDO'].value,'/',2))*10000+parseInt(Piece(oForm.elements['LIC_FECHAENTREGAPEDIDO'].value,'/',1))*100+parseInt(Piece(oForm.elements['LIC_FECHAENTREGAPEDIDO'].value,'/',0));

	//	solodebug
	console.log('GenerarPedido. hoyOrd:'+hoyOrd+'fechaPed:'+fechaPed);

	if (fechaPed<=hoyOrd)
	{
		alert(val_malFechaPedidoLic);
		return;
	}
	
	
	alert('REACTIVAR!!!!!');
	return;
	*/
	
	
	
	if (conCircuitoAprobacion=='S') mensaje=strConfirmarPedidoConCircuito;
		else mensaje=strConfirmarPedido;


	if (confirm(mensaje))
	{
		jQuery.ajax({
			cache:	false,
			url:	'http://www.newco.dev.br/Gestion/Comercial/GenerarPedido.xsql',
			type:	"GET",
			data:	"LIC_ID="+IDLicitacion+"&_="+d.getTime(),
			contentType: "application/xhtml+xml",
			beforeSend: function(){
				jQuery("#botonGenerarPedido").hide();
				jQuery("#waitBotonGenPedido").show();
			},
			error: function(objeto, quepaso, otroobj){
				alert('error'+quepaso+' '+otroobj+' '+objeto);
			},
			success: function(objeto){
				//var data = eval("(" + objeto + ")");
				var data = JSON.parse(objeto);

				if(data.Resultado.Estado == 'OK')
				{
					jQuery("#waitBotonGenPedido").hide();
					alert(alrt_GenerarPedidoOK);
					Recarga();	//23jul19	location.reload();
				}
				else
				{
					jQuery("#waitBotonGenPedido").hide();
					jQuery("#botonGenerarPedido").show();
					alert(data.Resultado.Mensaje);
				}
			}
		});
	}
}


function CrearLicitacionHija(){
	var d = new Date();

	jQuery.ajax({
		cache:	false,
		url:	'http://www.newco.dev.br/Gestion/Comercial/CrearLicitacionHijaAJAX.xsql',
		type:	"GET",
		data:	"LIC_ID="+IDLicitacion+"&_="+d.getTime(),
		contentType: "application/xhtml+xml",
		beforeSend: function(){
			jQuery("#botonLicitacionHija").hide();
			jQuery("#waitBotonLicHija").show();
		},
		error: function(objeto, quepaso, otroobj){
			alert('error'+quepaso+' '+otroobj+' '+objeto);
		},
		success: function(objeto){
			//var data = eval("(" + objeto + ")");
			var data = JSON.parse(objeto);

			if(data.Resultado.Estado == 'OK'){
				jQuery("#waitBotonLicHija").hide();
				alert(alrt_LicitacionHijaOK);
				location.href = 'http://www.newco.dev.br/Gestion/Comercial/MantLicitacion.xsql?LIC_ID=' + data.Resultado.IDNuevaLic;
			}else{
				jQuery("#waitBotonLicHija").hide();
				jQuery("#botonLicitacionHija").show();
				alert(alrt_LicitacionHijaKO);
			}
		}
	});
}

//	28mar18	Crear nueva licitacion de productos no pedidos, incluye proveedores y ofertas
function ContinuarLicitacion(){
	var d = new Date();

	jQuery.ajax({
		cache:	false,
		url:	'http://www.newco.dev.br/Gestion/Comercial/ContinuarLicitacionAJAX.xsql',
		type:	"GET",
		data:	"LIC_ID="+IDLicitacion+"&_="+d.getTime(),
		contentType: "application/xhtml+xml",
		beforeSend: function(){
			jQuery("#botonContinuarLicitacion").hide();
			jQuery("#waitBotonContLic").show();
		},
		error: function(objeto, quepaso, otroobj){
			alert('error'+quepaso+' '+otroobj+' '+objeto);
		},
		success: function(objeto){
			//var data = eval("(" + objeto + ")");
			var data = JSON.parse(objeto);

			if(data.Resultado.Estado == 'OK'){
				jQuery("#waitBotonContLic").hide();
				alert(alrt_LicitacionHijaOK);
				location.href = 'http://www.newco.dev.br/Gestion/Comercial/MantLicitacion.xsql?LIC_ID=' + data.Resultado.IDNuevaLic;
			}else{
				jQuery("#waitBotonContLic").hide();
				jQuery("#botonContinuarLicitacion").show();
				alert(alrt_LicitacionHijaKO);
			}
		}
	});
}

function guardarDatosInforme(){
	var Situacion		= encodeURIComponent(jQuery('#LIC_INF_SITUACION').val().replace(/'/g, "''"));
	var Presentacion	= encodeURIComponent(jQuery('#LIC_INF_PRESENTACION').val().replace(/'/g, "''"));
	var Analisis		= encodeURIComponent(jQuery('#LIC_INF_ANALISIS').val().replace(/'/g, "''"));
	var Conclusiones	= encodeURIComponent(jQuery('#LIC_INF_CONCLUSIONES').val().replace(/'/g, "''"));
	var d = new Date();

	jQuery.ajax({
		cache:	false,
		url:	'http://www.newco.dev.br/Gestion/Comercial/GuardarDatosInformeAJAX.xsql',
		type:	"GET",
		data:	"LIC_ID="+IDLicitacion+"&LIC_INF_SITUACION="+Situacion+"&LIC_INF_PRESENTACION="+Presentacion+"&LIC_INF_ANALISIS="+Analisis+"&LIC_INF_CONCLUSIONES="+Conclusiones+"&_="+d.getTime(),
		contentType: "application/xhtml+xml",
		error: function(objeto, quepaso, otroobj){
			alert('error'+quepaso+' '+otroobj+' '+objeto);
		},
		success: function(objeto){
			//var data = eval("(" + objeto + ")");
			var data = JSON.parse(objeto);

			if(data.Resultado == 'OK'){
				alert(alrt_guardarDatosInformeOK);
			}else{
				alert(alrt_guardarDatosInformeKO);
			}
		}
	});
}

function calcularFloatingBox_EST(){
	var numProductos = 0, numInformados = 0;
	var Cantidad, CantidadFormat, PrecioHist, PrecioHistFormat, PrecioObj, PrecioObjFormat;	//, ConsumoHist = 0, ConsumoObj = 0;
	var valAux;
	
	//solodebug debug('calcularFloatingBox_EST');

	//	28may19 Inicializar variables globales
	ConsumoHist = 0, ConsumoObj = 0;

	jQuery.each(arrProductos, function(key, producto){
		numProductos++;

		// Si el producto esta informado
		if(producto.UdBasica != ''){
			numInformados++;

			Cantidad		= producto.Cantidad;
			CantidadFormat	= Cantidad.replace(",",".");
			if(mostrarPrecioIVA == 'S'){
				PrecioHist	= producto.PrecioHistIVA;
				PrecioObj	= producto.PrecioObjIVA;
			}else{
				PrecioHist	= producto.PrecioHist;
				PrecioObj	= producto.PrecioObj;
			}
			valAux = PrecioHist.replace(",",".");
			if(!isNaN(valAux) && !esNulo(valAux)){
				PrecioHistFormat	= valAux;
			}else{
				PrecioHistFormat	= 0;
			}
			valAux = PrecioObj.replace(",",".");
			if(!isNaN(valAux) && !esNulo(valAux)){
				PrecioObjFormat	= valAux;
			}else{
				PrecioObjFormat	= 0;
			}

			// Consumo Historico
			if(PrecioHistFormat != 0){
				ConsumoHist	+= CantidadFormat * PrecioHistFormat;
			}
			// Consumo Objetivo
			if(PrecioObjFormat != 0){
				ConsumoObj	+= CantidadFormat * PrecioObjFormat;
			}
		}

	});

	jQuery('#FBNumInform').html(numInformados+'/'+numProductos);
	jQuery('#FBConsHist').html(FormateaNumeroNacho(ConsumoHist.toFixed(2)));
	jQuery('#FBConsObj').html(FormateaNumeroNacho(ConsumoObj.toFixed(2)));

	if(provsInformados == 'S' && prodsInformados == 'S'){
		jQuery('#FBAviso').html('&nbsp;<img src="http://www.newco.dev.br/images/check.gif" style="vertical-align:text-bottom;"/>');
	}else{
		jQuery('#FBAviso').html('&nbsp;<img src="http://www.newco.dev.br/images/atencion.gif" style="vertical-align:text-bottom;"/>');
	}

	jQuery('#floatingBox').show();
}



function filtrarProductosBeforeAjax(){
	var cadena = jQuery('#filtroProductos').val();

	normalizarString(cadena, filtrarProductosAfterAjax);
}

function filtrarProductosAfterAjax(cadenaNorm){
	ProductExist = false;
	if(cadenaNorm != ''){
		filtroNombre = cadenaNorm;

		jQuery.each(arrProductos, function(key, producto){
			if(producto.NombreNorm.indexOf(filtroNombre) > -1){
				producto.Ordenacion = '0';
				ProductExist = true;
			}else{
				producto.Ordenacion = '1';
			}
		});

		OrdenarProdsPorColumna('Ordenacion');
	}
}

function NombreProductoConEstilo(pos){
	var ini = arrProductos[ColumnaOrdenadaProds[pos]].NombreNorm.indexOf(filtroNombre);
	if(ini > -1  && filtroNombre != '' && ColumnaOrdenacionProds == 'Ordenacion'){
		var length	= filtroNombre.length;
		var nombre	= arrProductos[ColumnaOrdenadaProds[pos]].Nombre.substr(0, ini);
			nombre	+= '<span style="background-color:yellow;">';
			nombre	+= arrProductos[ColumnaOrdenadaProds[pos]].Nombre.substr(ini, length);
			nombre	+= '</span>';
			nombre	+= arrProductos[ColumnaOrdenadaProds[pos]].Nombre.substr(ini + length);
		return nombre;
	}else{
		return arrProductos[ColumnaOrdenadaProds[pos]].Nombre;
	}
}

function triggerFB(flag){
	if(flag){
		jQuery("#floatingBoxMin").hide();
		jQuery("#floatingBox").show();
	}else{
		jQuery("#floatingBox").hide();
		jQuery("#floatingBoxMin").show();
	}
}

// FUNCIONES NECESARIAS PARA FichaProductoLicitacionHTML.xsl

// Funcion (ajax) para cambiar el estado evaluacion de una oferta
function CambiarEstadoOferta(IDOfe){
	var IDEstadoEval = jQuery("#IDESTADO_"+IDOfe).val();
	var d = new Date();

	jQuery.ajax({
		cache:	false,
		url:	'http://www.newco.dev.br/Gestion/Comercial/CambiarEstadoOferta.xsql',
		type:	"GET",
		data:	"LIC_OFE_ID="+IDOfe+"&IDESTADO="+IDEstadoEval+"&_="+d.getTime(),
		contentType: "application/xhtml+xml",
		error: function(objeto, quepaso, otroobj){
			alert('error'+quepaso+' '+otroobj+' '+objeto);
		},
		success: function(objeto){
			//var data = eval("(" + objeto + ")");
			var data = JSON.parse(objeto);

			if(data.NuevoEstado.estado == 'OK'){
				//recuperaOfertaProductos(IDLic,IDProvLic);
				//jQuery("#lPublOferta").hide();
				alert(estadoOfertaActualizado);
			}else{
				alert(errorNuevoEstadoOferta);
			}
		}
	});
}

/*	Esta función se ha movido a licFichaProd_251016.js
// Guarda la selección para la oferta de un unico producto (FichaProductoLicitacionHTML.xsl)
function GuardarProductoSel(IDProdLic){
	var d = new Date();

	// Busco el radio button seleccionado
	var IDOfertaLic = (jQuery("input[type='radio'][name='RADIO_" + IDProdLic + "']:checked").val() !== undefined) ? jQuery("input[type='radio'][name='RADIO_" + IDProdLic + "']:checked").val() : '';

//	if(IDOfertaLic != ''){
		jQuery.ajax({
			url:	"http://www.newco.dev.br/Gestion/Comercial/SeleccionarProductoAJAX.xsql",
			data:	"IDLIC="+IDLicitacion+"&IDPRODUCTOLIC="+IDProdLic+"&IDOFERTA="+IDOfertaLic+"&_="+d.getTime(),
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

				if(data.Resultado.Estado == 'OK'){
					//alert(guardar_selecc_adjudica_ok);

					// Se tiene que seleccionar el radio button del documento padre
					window.opener.actualizarRadio(IDProdLic, IDOfertaLic);
					// Si existe el botón 'siguiente', automáticamente saltamos a la siguiente página
					if(jQuery('#botonProdSiguiente').length){
						var href = jQuery('#botonProdSiguiente a').attr('href');
						window.location.href = href;
					}
				}else{
					alert(guardar_selecc_adjudica_ko);
				}
			}
		});
}
*/


// Funcion para seleccionar el radio button en LicitacionHTML.xsl cuando se selecciona y guarda una oferta en FichaProductoLicitacionHTML.xsl
function actualizarRadio(IDProdLic, IDOfertaLic, recFloatingBox){
	var thisPosArr, 
		thisPosArrOfe=-1;	//	16dic16	inicializamos a -1 para identificar no informado
	
	
	//solodebug
	var f=new Date();

	debug("actualizarRadio IDProdLic:"+IDProdLic+" IDOfertaLic:"+IDOfertaLic + " INICIO");
	
	jQuery.each(arrProductos, function(key, producto){
		if(producto.IDProdLic == IDProdLic){
			thisPosArr = (producto.linea -1);

			jQuery.each(producto.Ofertas, function(key, oferta){
				if(oferta.ID == IDOfertaLic){			//21set16	.IDOferta
					thisPosArrOfe = (oferta.columna -1);
				}
			});
		}
	});

	// Marcamos el array de productos como que tiene seleccion
	arrProductos[thisPosArr].TieneSeleccion = 'S';
	// Marcamos como adjudicada la oferta en el array de productos.ofertas
	
	if (thisPosArrOfe!=-1)
		arrProductos[thisPosArr].Ofertas[thisPosArrOfe].OfertaAdjud = 'S';

	
	//solodebug
	debug("actualizarRadio IDProdLic:"+IDProdLic+" IDOfertaLic:"+IDOfertaLic + " recalcularFloatingBox INICIO");


	if (recFloatingBox!='N')
	{
		if(jQuery('.RADIO_' + thisPosArr).length){
			jQuery('.RADIO_' + thisPosArr).each(function(){
				if(this.value == IDOfertaLic){
					jQuery(this).prop('checked', true);
	
			//solodebug
			debug("actualizarRadio IDProdLic:"+IDProdLic+" IDOfertaLic:"+IDOfertaLic + " recalcularFloatingBox (checked)");
			
					recalcularFloatingBox(this, 1, 'S');	// 15may17 No marcamos la licitación como pendiente de guardar seleccion
				}
				else{	//16dic16
					jQuery(this).prop('checked', false);
	
			//solodebug
			debug("actualizarRadio IDProdLic:"+IDProdLic+" IDOfertaLic:"+IDOfertaLic + " recalcularFloatingBox (unchecked)");
			
					recalcularFloatingBox(this, 1, 'S');
				}
			});
		}else{
	
			//solodebug
			debug("actualizarRadio IDProdLic:"+IDProdLic+" IDOfertaLic:"+IDOfertaLic + " calcularFloatingBox");
			
			calcularFloatingBox();
		}
	}

	//solodebug
	debug("actualizarRadio IDProdLic:"+IDProdLic+" IDOfertaLic:"+IDOfertaLic + " actualizarRadio FINAL");
	
}


// Funcion para abrir la ficha de producto del cat.priv.
function FichaProductoOfe(IDProdLic,IDProdOfeLic){
	MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Productos/PRODetalle.xsql?LIC_PROD_ID='+IDProdLic+'&LIC_OFE_ID='+IDProdOfeLic,'',100,100,0,0);
}

// Funcion para abrir el div flotante - formulario para anyadir campos avanzados de producto
function abrirCamposAvanzadosProd(posArr){
	var infoAmpliada	= arrProductos[posArr].InfoAmpliada.replace(/<br>/gi,'\n');
	var anotaciones		= arrProductos[posArr].Anotaciones.replace(/<br>/gi,'\n');
	var IDDoc		= (typeof arrProductos[posArr].Documento.ID !== 'undefined') ? arrProductos[posArr].Documento.ID : '';
	var nombreDoc		= arrProductos[posArr].Documento.Nombre;

	jQuery("#posArray").val(posArr);
	jQuery('#txtInfoAmpliada').val(infoAmpliada);
	jQuery('#txtAnotaciones').val(anotaciones);

	if(IDDoc != ''){
		jQuery('input#IDDOC').val(IDDoc);
		jQuery("span#NombreDoc").html(nombreDoc);
		jQuery("span#DocCargado").show();
		jQuery("input#inputFileDoc_CA").hide();
	}else{
		jQuery('input#IDDOC').val('');
		jQuery("span#NombreDoc").html('');
		jQuery("span#DocCargado").hide();
		jQuery("input#inputFileDoc_CA").show();
        }

	jQuery("#confirmBox_CA").hide();
	showTablaByID("camposAvanzados");
}


function borrarDoc(tipo){
	var posArr	= jQuery("#camposAvanzados #posArray").val();
	var d = new Date(), action, valueID;
	
	debug("borrarDoc tipo:"+tipo);

	if(tipo == 'LIC_PRODUCTO_FT')
	{
		action = 'BorrarDocumentoProductoAJAX.xsql';
		valueID	= arrProductos[posArr].IDProdLic;
	}
	else if(tipo == 'DOC_LICITACION')
	{
		action = 'BorrarDocumentoLicitacionAJAX.xsql';
		valueID	= IDLicitacion;
	}
	else if(tipo == 'DOC_PROV_LICITACION')
	{
		action = 'BorrarDocumentoProveedorAJAX.xsql';
		valueID	= IDLicProveedor;
	}

	jQuery.ajax({
		cache:	false,
		url:	action,
		type:	"GET",
		data:	"ID="+valueID+"&_="+d.getTime(),
		contentType: "application/xhtml+xml",
		error: function(objeto, quepaso, otroobj){
			alert('error'+quepaso+' '+otroobj+' '+objeto);
		},
		success: function(objeto){
			//var data = eval("(" + objeto + ")");
			var data = JSON.parse(objeto);

			if(data.Resultado.Estado == 'OK')
			{
				debug("borrarDoc tipo:"+tipo+' borrado OK');
				if(tipo == 'DOC_LICITACION')
				{
					
					jQuery("#inputFileDoc_Licitacion_"+valueID).show();
					jQuery("#inputFileDoc_Licitacion_"+valueID).val('');
					jQuery("#divDatosDocumento").hide();
					jQuery("#LIC_IDDOCUMENTO").value='';
						
				}
				else if(tipo == 'DOC_PROV_LICITACION')
				{
					
					jQuery("#inputFileDoc_Proveedor_"+valueID).show();
					jQuery("#inputFileDoc_Proveedor_"+valueID).val('');
					jQuery("#divDatosDocumento").hide();
					jQuery("#LIC_PROV_IDDOCUMENTO").value='';
						
				}
				else
				{
					// Recuperamos los productos via ajax
					if(estadoLicitacion == 'EST')
					{
						recuperaDatosProductos(0,'S');
					}
					alert(alrt_BorrarDocumentoOK);
					jQuery("#camposAvanzados span#DocCargado").hide();
					jQuery("#camposAvanzados div#confirmBox_CA").hide();
					jQuery("#camposAvanzados input#inputFileDoc_CA").show();
					//	5nov19 Limpiamos los campos de documento del formulario de campos avanzados
					jQuery("#camposAvanzados input#UrlDoc").val('');
					jQuery("#camposAvanzados input#IDDOC").val('');
					jQuery("#camposAvanzados input#NombreDoc").val('');
					arrProductos[posArr].Oferta.Documento.ID='';
					arrProductos[posArr].Oferta.Documento.Nombre='';
					arrProductos[posArr].Oferta.Documento.Url='';
					debug("borrarDoc tipo:"+tipo+' borrado OK. posArr:'+posArr+' UrlActualizada:'+arrProductos[posArr].Oferta.Documento.Url);
				}
           }
		   else
		   {
				alert(alrt_BorrarDocumentoKO);
           }
		}
	});
}

function subirDoc(tipo){
	var form	= document.forms['CamposAvanzadosForm'];

	debug('subirDoc');

	if(tipo == 'LIC_PRODUCTO_FT')		//	cuando lo sube el autor
	{	
		var posArr	= jQuery("#camposAvanzados #posArray").val();
		var valueID	= arrProductos[posArr].IDProdLic;
	}else{								//	LIC_OFERTA_FT cuando lo sube el proveedor
		var valueID	= jQuery("#camposAvanzados #IDOferta").val();
	}

	if(jQuery("#camposAvanzados #inputFileDoc_CA").val != ''){
		if(uploadFrameDoc && uploadFrameDoc.document && uploadFrameDoc.document.getElementsByTagName("body")[0]){
			uploadFrameDoc.document.getElementsByTagName("body")[0].innerHTML = "";
		}

		//	Cambiamos el nombre del objeto file
		jQuery("#camposAvanzados #inputFileDoc_CA").attr('name', 'inputFileDoc');
		
		var target = 'uploadFrameDoc';
		var action = 'http://www.newco.dev.br/cgi-bin/uploadDocsMVM.pl';
		var enctype = 'multipart/form-data';
		form.target = target;
		form.encoding = enctype;
		form.action = action;
		waitDoc('CA', "Please wait...");
		//5mar19	form_tmp = form;
		//5mar19	man_tmp = true;
		periodicTimerDoc = 0;

		periodicUpdateDoc(form, valueID, tipo);
		form.submit();

		jQuery("#camposAvanzados #inputFileDoc_CA").attr('name', 'inputFileDoc_CA');
	}
}

function guardarCamposAvanzadosProd(){
	var posArr		= jQuery("#camposAvanzados #posArray").val();
	var infoAmpliada	= jQuery("#camposAvanzados #txtInfoAmpliada").val().replace(/'/g, "''");
	var anotaciones		= jQuery("#camposAvanzados #txtAnotaciones").val().replace(/'/g, "''");
	var IDDoc		= jQuery("#camposAvanzados #IDDOC").val();
	var IDProdLic		= arrProductos[posArr].IDProdLic;
	var d = new Date();

	if(infoAmpliada != '' || anotaciones != '' || IDDoc != ''){
		jQuery.ajax({
			cache:	false,
			url:	'http://www.newco.dev.br/Gestion/Comercial/CamposAvanzadosProdAJAX.xsql',
			type:	"POST",
			async:	false,
			data:	"IDPRODUCTOLIC="+IDProdLic+"&IDDOC="+IDDoc+"&INFOAMPLIADA="+encodeURIComponent(infoAmpliada)+"&ANOTACIONES="+encodeURIComponent(anotaciones)+"&_="+d.getTime(),
			success: function(objeto){
			//var data = eval("(" + objeto + ")");
			var data = JSON.parse(objeto);

				if(data.CamposAvanzadosProd.estado == 'OK'){
					// Recuperamos los productos via ajax
					if(estadoLicitacion == 'EST'){
						recuperaDatosProductos(0,'S');
					}else{
						recuperaDatosProductosConOfertas();
					}
					alert(alrt_CamposAvanzadosOK);
					// Escondemos el formulario de campos avanzados
					showTabla(false);
        	                }else{
					alert(alrt_CamposAvanzadosKO);
				}
			},
			error: function(xhr, errorString, exception) {
				alert("xhr.status="+xhr.status+" error="+errorString+" exception="+exception);
			}
		});
	}
}


// Funcion que muestra o esconde las columnas de la tabla 'productos' segun el tipo de vista escogido (solo en tabla productos + ofertas)
function muestraNuevaVistaProductos(tipoVista){
	if(tipoVista == 'SP'){
		// Cambiamos el colspan de las celdas
		jQuery(".colNomProv").attr('colspan',2);
		jQuery(".colSinOferta").attr('colspan',2);

		jQuery(".colPrecio").show().removeClass( "borderLeft" );
		jQuery(".colConsumo").hide();
		jQuery(".colAhorro").hide();
		jQuery(".colEval").hide();
		jQuery(".colInfo").hide();
	}else if(tipoVista == 'SC'){
		// Cambiamos el colspan de las celdas
		jQuery(".colNomProv").attr('colspan',2);
		jQuery(".colSinOferta").attr('colspan',2);

		jQuery(".colPrecio").hide();
		jQuery(".colConsumo").show().removeClass( "borderLeft" );
		jQuery(".colAhorro").hide();
		jQuery(".colEval").hide();
		jQuery(".colInfo").hide();
	}else if(tipoVista == 'SA'){
		// Cambiamos el colspan de las celdas
		jQuery(".colNomProv").attr('colspan',2);
		jQuery(".colSinOferta").attr('colspan',2);

		jQuery(".colPrecio").hide();
		jQuery(".colConsumo").hide();
		jQuery(".colAhorro").show().removeClass( "borderLeft" );
		jQuery(".colEval").hide();
		jQuery(".colInfo").hide();
	}else if(tipoVista == 'PC'){
		// Cambiamos el colspan de las celdas
		jQuery(".colNomProv").attr('colspan',3);
		jQuery(".colSinOferta").attr('colspan',3);

		jQuery(".colPrecio").show().removeClass( "borderLeft" );
		jQuery(".colConsumo").show().addClass( "borderLeft" );
		jQuery(".colAhorro").hide();
		jQuery(".colEval").hide();
		jQuery(".colInfo").hide();
	}else if(tipoVista == 'PCA'){
		// Cambiamos el colspan de las celdas
		jQuery(".colNomProv").attr('colspan',4);
		jQuery(".colSinOferta").attr('colspan',4);

		jQuery(".colPrecio").show().removeClass( "borderLeft" );
		jQuery(".colConsumo").show().addClass( "borderLeft" );
		jQuery(".colAhorro").show().addClass( "borderLeft" );
		jQuery(".colEval").hide();
		jQuery(".colInfo").hide();
	}else if(tipoVista == 'PCAE'){
		// Cambiamos el colspan de las celdas
		jQuery(".colNomProv").attr('colspan',5);
		jQuery(".colSinOferta").attr('colspan',5);

		jQuery(".colPrecio").show().removeClass( "borderLeft" );
		jQuery(".colConsumo").show().addClass( "borderLeft" );
		jQuery(".colAhorro").show().addClass( "borderLeft" );
		jQuery(".colEval").show().addClass( "borderLeft" );
		jQuery(".colInfo").hide();
	}else if(tipoVista == 'PIC'){
		// Cambiamos el colspan de las celdas
		jQuery(".colNomProv").attr('colspan',3);
		jQuery(".colSinOferta").attr('colspan',3);

		jQuery(".colPrecio").show().removeClass( "borderLeft" );
		jQuery(".colConsumo").hide();
		jQuery(".colAhorro").hide();
		jQuery(".colEval").hide();
		jQuery(".colInfo").show();
	}
}

//Funcion que convierte las etiquetas <br> en saltos de linea
function formateaTextareas(){
	jQuery("textarea").each(function(){
		jQuery(this).val(this.value.replace(/<br>/gi, '\n'));
	});
}

// Funcion para abrir el div flotante - formulario para subir contratos
function abrirFormContrato(posArr){
	var IDDoc = '';
//	var IDDoc		= (typeof arrProductos[posArr].Oferta.Documento.ID !== 'undefined') ? arrProductos[posArr].Oferta.Documento.ID : '';
//	var nombreDoc		= arrProductos[posArr].Oferta.Documento.Nombre;
	var NombreProv		= arrProveedores[posArr].Nombre;

	jQuery("#subirContrato #posArray").val(posArr);
	jQuery("#subirContrato #NombreProv").html(NombreProv);

	if(IDDoc != ''){
		jQuery("#subirContrato input#IDDOC").val(IDDoc);
		jQuery("#subirContrato span#NombreDoc").html(nombreDoc);
		jQuery("#subirContrato span#DocCargado").show();
		jQuery("#subirContrato input#inputFileDoc_SC").hide();
	}else{
		jQuery("#subirContrato input#IDDOC").val('');
		jQuery("#subirContrato span#NombreDoc").html('');
		jQuery("#subirContrato span#DocCargado").hide();
		jQuery("#subirContrato input#inputFileDoc_SC").show();
  }

	jQuery("#subirContrato #confirmBox_SC").hide();
	showTablaByID("subirContrato");
}

function guardarContrato(){
	var posArr		= jQuery("#subirContrato #posArray").val();
	var IDProvLic	= arrProveedores[posArr].IDProvLic;
	var DocID		= jQuery("#subirContrato #IDDOC").val();
	var DocURL		= jQuery("#subirContrato #UrlDoc").val();
	var d			= new Date();
	var innerHTML = '';

	jQuery.ajax({
		cache:  false,
    url:    'http://www.newco.dev.br/Gestion/Comercial/InformarNuevoContratoAJAX.xsql',
    type:   "GET",
    data:   "IDPROVLIC="+IDProvLic+"&DOC_ID="+DocID+"&_="+d.getTime(),
    contentType: "application/xhtml+xml",
    error: function(objeto, quepaso, otroobj){
    	alert('error'+quepaso+' '+otroobj+' '+objeto);
    },
    success: function(objeto){
			//var data = eval("(" + objeto + ")");
			var data = JSON.parse(objeto);

    	if(data.Resultado.Estado == 'OK'){

				innerHTML += '<a href="http://www.newco.dev.br/Documentos/' + DocURL + '" target="_blank">';
				innerHTML += '<img src="http://www.newco.dev.br/images/contratoIcon.gif" style="vertical-align:text-bottom;" alt="' + str_Contrato + '" title="' + str_Contrato + '"/>';
				innerHTML += '</a>';

				// Si no existe contrato previo
				if(jQuery("#docContrato_" + data.Resultado.IDProvLic).length == 0){
					innerHTML = '<span id="docContrato_' + data.Resultado.IDProvLic + '">' + innerHTML + '</span>&nbsp;';
					jQuery("#contrato_" + data.Resultado.IDProvLic).prepend(innerHTML);
				// Si el contrato ya existe y se ha sobreescrito
				}else{
					jQuery("#docContrato_" + data.Resultado.IDProvLic).html(innerHTML);
				}
        alert(alrt_SubirContratoOK);
				showTabla(false);
      }else{
        alert(alrt_SubirContratoKO);
      }
    }
  });
}

function abrirBoxNuevoUsuario(posArr){
	var NombreProv	= arrProveedores[posArr].Nombre;
	var IDProveedor	= arrProveedores[posArr].IDProveedor;
	var d = new Date();

	jQuery("#cambioUsuProv #NombreProv").html(NombreProv);
	jQuery("#cambioUsuProv #posArray").val(posArr);

	jQuery.ajax({
		cache:	false,
		url:	'http://www.newco.dev.br/Gestion/Comercial/UsuariosProveedor.xsql',
		type:	"GET",
		data:	"IDProveedor="+IDProveedor+"&_="+d.getTime(),
		contentType: "application/xhtml+xml",
		beforeSend: function(){
			jQuery("#IDUSUARIOPROV_NUEVO").empty();
		},
		error: function(objeto, quepaso, otroobj){
			alert('error'+quepaso+' '+otroobj+' '+objeto);
		},
		success: function(objeto){
			var data = eval("(" + objeto + ")");

			jQuery("#IDUSUARIOPROV_NUEVO").append("<option value=''>" + str_Selecciona + "</option>");

			for(var i=0;i<data.ListaUsuarios.length;i++){
				jQuery("#IDUSUARIOPROV_NUEVO").append("<option value='"+data.ListaUsuarios[i].id+"'>"+data.ListaUsuarios[i].centro+":"+data.ListaUsuarios[i].nombre+"</option>");
			}
			jQuery("#IDUSUARIOPROV_NUEVO").val("");
		}
	});

	showTablaByID("cambioUsuProv");
	jQuery("#cambioUsuProv #BotonNuevoUsu").show();		//	ET	1feb17
}

function guardarNuevoUsuProv(){
	var posArr	= jQuery("#cambioUsuProv #posArray").val();
	var IDUsuProv	= jQuery("#cambioUsuProv #IDUSUARIOPROV_NUEVO").val();
	var IDProvLic	= arrProveedores[posArr].IDProvLic;
	var d = new Date();
	
	if (IDUsuProv=='')
	{
		alert(val_faltaUsuarioProv);
		return;
	}

	jQuery.ajax({
		cache:	false,
		url:	'http://www.newco.dev.br/Gestion/Comercial/GuardarUsuarioProveedorAJAX.xsql',
		type:	"GET",
		data:	"IDPROVLIC="+IDProvLic+"&IDUSUPROV="+IDUsuProv+"&_="+d.getTime(),
		contentType: "application/xhtml+xml",
		beforeSend: function(){
			jQuery("#cambioUsuProv #BotonNuevoUsu").hide();
		},
		error: function(objeto, quepaso, otroobj){
			alert('error'+quepaso+' '+otroobj+' '+objeto);
		},
		success: function(objeto){
			var data = eval("(" + objeto + ")");

    	if(data.Resultado.Estado == 'OK'){
				recuperaDatosProveedores();
				alert(alrt_nuevoUsuarioProvOK);
				showTabla(false);
			}else{
				alert(alrt_nuevoUsuarioProvKO);
			}
		}
	});

}


// Funcion para guardar los datos de la compra por centro para una fila en concreto
function guardarDatosCompraFila(thisPosArr){
	// Validaciones
	var oForm = document.forms['PublicarCompras'];
	var RefCliente	= (arrProductos[thisPosArr].RefCliente != '') ? arrProductos[thisPosArr].RefCliente : arrProductos[thisPosArr].RefEstandar;
	var precioObj	= arrProductos[thisPosArr].PrecioObj;
	var precioObjFormat	= parseFloat(precioObj.replace(/\./g,"").replace(',', '.'));
	var enviarOferta = false;
	var controlPrecio = '';
	var errores = 0;

	//jQuery("#BtnActualizarOfertas").hide();
	//jQuery("img .guardarOferta").hide();
	//alert("("+oForm.elements['Marca_' + thisPosArr].value+")");

	// Validacion Precio
	var cantidad		= jQuery('#Cantidad_' + thisPosArr).val();
	var cantidadFormat	= cantidad.replace(",",".");
	if(!errores && esNulo(cantidadFormat)){
		errores++;
		alert(val_faltaCantidad.replace("[[REF]]",RefCliente));
		oForm.elements['Cantidad_' + thisPosArr].focus();
		return false;
	}else if(!errores && isNaN(cantidadFormat)){
		errores++;
		alert(val_malCantidad.replace("[[REF]]",RefCliente));
		oForm.elements['Cantidad_' + thisPosArr].focus();
	}
	if(!errores){
	
		//alert('IDcentro:'+oForm.elements['IDCENTRO'].value);
		//alert('IDcentroCompra:'+oForm.elements['IDCENTROCOMPRAS'].value);
	
		//var IDLicProv	= oForm.elements['LIC_PROV_ID'].value;
		var IDLicProd	= arrProductos[thisPosArr].IDProdLic;
		var IDCentro = oForm.elements['IDCENTROCOMPRAS'].value;
		var IDFicha = '';
		if(jQuery("#IDFICHA_" + thisPosArr).val() > 0){
			IDFicha = jQuery("#IDFICHA_" + thisPosArr).val();
		}
		//var RefProv = (jQuery('#RefProv_' + thisPosArr).length) ? encodeURIComponent(jQuery('#RefProv_' + thisPosArr).val()) : '' ;
		//var Descripcion = encodeURIComponent(jQuery('#Desc_' + thisPosArr).val());
		//var Marca = encodeURIComponent(jQuery('#Marca_' + thisPosArr).val());
		//var UdsXLote = encodeURIComponent(jQuery('#UdsLote_' + thisPosArr).val());
		//var Precio = jQuery('#Precio_' + thisPosArr).val();
		var Cantidad = arrProductos[thisPosArr].Cantidad;
		//var TipoIVA = arrProductos[thisPosArr].TipoIVA;
		var d = new Date();

		jQuery.ajax({
			cache:	false,
			url:	'http://www.newco.dev.br/Gestion/Comercial/InformarDatosCOmpraAJAX.xsql',
			type:	"GET",
			data:	"LIC_ID="+IDLicitacion+"&LIC_PROD_ID="+IDLicProd+"&IDCENTRO="+IDCentro+"&CANTIDAD="+cantidad+"&_="+d.getTime(),
			beforeSend: function(){
				//17set16	jQuery("#BtnActualizarOfertas").hide();
				//17set16	jQuery(".guardarOferta").hide();
				jQuery('#btnGuardar_'+thisPosArr).hide();
				jQuery('#btnAlter_'+thisPosArr).hide();
			},
			error: function(objeto, quepaso, otroobj){
				//17set16	jQuery('tr#posArr_' + thisPosArr + ' .resultado').html('<img src="http://www.newco.dev.br/images/error.gif"/>');
				jQuery('#AVISOACCION_'+thisPosArr).html('<img src="http://www.newco.dev.br/images/error.gif"/>');
				alert('error'+quepaso+' '+otroobj+' '+objeto);
			},
			success: function(objeto){
				//var data = eval("(" + objeto + ")");
				var data = JSON.parse(objeto);

				if(data.OfertaActualizada.IDOferta > 0){
					//17set16	jQuery('tr#posArr_' + thisPosArr + ' .resultado').html('<img src="http://www.newco.dev.br/images/recibido.gif"/>');
					jQuery('#AVISOACCION_'+thisPosArr).html('<img src="http://www.newco.dev.br/images/recibido.gif"/>');
				}else{
					//17set16	jQuery('tr#posArr_' + thisPosArr + ' .resultado').html('<img src="http://www.newco.dev.br/images/recibido.gif"/>');
					jQuery('#AVISOACCION_'+thisPosArr).html('<img src="http://www.newco.dev.br/images/recibido.gif"/>');
				}
			}
		});
	}

	//17set16	jQuery("#BtnActualizarOfertas").show();
	//17set16	jQuery(".guardarOferta").show();

}


// 10abr17	Funcion recursiva para guardar los datos de la compra por centro para todas las filas
function guardarTodosDatosCompraAjax(Pos){

	//	Si hemos superado el límite, sale
	if (Pos>=arrProductos.length)
	{
		jQuery("#idGuardarTodasCantidades").hide();
		return;
	}
	
	//	Comprueba si esta fila ha sido modificada, si no pasa a la siguiente
	if (!jQuery('#btnGuardar_'+Pos).is(':visible'))
	{
		guardarTodosDatosCompraAjax(Pos+1);
		return;
	}

	//	Declaración de variables
	var oForm = document.forms['PublicarCompras'];
	var RefCliente	= (arrProductos[Pos].RefCliente != '') ? arrProductos[Pos].RefCliente : arrProductos[Pos].RefEstandar;
	var precioObj	= arrProductos[Pos].PrecioObj;
	var precioObjFormat	= parseFloat(precioObj.replace(/\./g,"").replace(',', '.'));
	var enviarOferta = false;
	var controlPrecio = '';
	var errores = 0;
	

	// Validacion Precio
	var cantidad		= jQuery('#Cantidad_' + Pos).val();
	var cantidadFormat	= cantidad.replace(",",".");
	if(!errores && esNulo(cantidadFormat)){
		errores++;
		alert(val_faltaCantidad.replace("[[REF]]",RefCliente));
		oForm.elements['Cantidad_' + Pos].focus();
		return false;
	}else if(!errores && isNaN(cantidadFormat)){
		errores++;
		alert(val_malCantidad.replace("[[REF]]",RefCliente));
		oForm.elements['Cantidad_' + Pos].focus();
	}
	if(!errores){
	
		//alert('IDcentro:'+oForm.elements['IDCENTRO'].value);
		//alert('IDcentroCompra:'+oForm.elements['IDCENTROCOMPRAS'].value);
	
		//var IDLicProv	= oForm.elements['LIC_PROV_ID'].value;
		var IDLicProd	= arrProductos[Pos].IDProdLic;
		var IDCentro = oForm.elements['IDCENTROCOMPRAS'].value;
		var IDFicha = '';
		if(jQuery("#IDFICHA_" + Pos).val() > 0){
			IDFicha = jQuery("#IDFICHA_" + Pos).val();
		}
		//var RefProv = (jQuery('#RefProv_' + Pos).length) ? encodeURIComponent(jQuery('#RefProv_' + Pos).val()) : '' ;
		//var Descripcion = encodeURIComponent(jQuery('#Desc_' + Pos).val());
		//var Marca = encodeURIComponent(jQuery('#Marca_' + Pos).val());
		//var UdsXLote = encodeURIComponent(jQuery('#UdsLote_' + Pos).val());
		//var Precio = jQuery('#Precio_' + Pos).val();
		var Cantidad = arrProductos[Pos].Cantidad;
		//var TipoIVA = arrProductos[Pos].TipoIVA;
		var d = new Date();

		jQuery.ajax({
			cache:	false,
			url:	'http://www.newco.dev.br/Gestion/Comercial/InformarDatosCOmpraAJAX.xsql',
			type:	"GET",
			data:	"LIC_ID="+IDLicitacion+"&LIC_PROD_ID="+IDLicProd+"&IDCENTRO="+IDCentro+"&CANTIDAD="+cantidad+"&_="+d.getTime(),
			beforeSend: function(){
				//17set16	jQuery("#BtnActualizarOfertas").hide();
				//17set16	jQuery(".guardarOferta").hide();
				jQuery('#btnGuardar_'+Pos).hide();
			},
			error: function(objeto, quepaso, otroobj){
				//17set16	jQuery('tr#posArr_' + Pos + ' .resultado').html('<img src="http://www.newco.dev.br/images/error.gif"/>');
				jQuery('#AVISOACCION_'+Pos).html('<img src="http://www.newco.dev.br/images/error.gif"/>');
				alert('error'+quepaso+' '+otroobj+' '+objeto);
			},
			success: function(objeto){
				//var data = eval("(" + objeto + ")");
				var data = JSON.parse(objeto);

				if(data.OfertaActualizada.IDOferta > 0){
					//17set16	jQuery('tr#posArr_' + Pos + ' .resultado').html('<img src="http://www.newco.dev.br/images/recibido.gif"/>');
					jQuery('#AVISOACCION_'+Pos).html('<img src="http://www.newco.dev.br/images/recibido.gif"/>');
				}else{
					//17set16	jQuery('tr#posArr_' + Pos + ' .resultado').html('<img src="http://www.newco.dev.br/images/recibido.gif"/>');
					jQuery('#AVISOACCION_'+Pos).html('<img src="http://www.newco.dev.br/images/recibido.gif"/>');
				}

				guardarTodosDatosCompraAjax(Pos+1);
				return;

			}
		});
	}

	//17set16	jQuery("#BtnActualizarOfertas").show();
	//17set16	jQuery(".guardarOferta").show();

}


function PublicarDatosCompra()
{
	var oForm = document.forms['PublicarCompras'];
	var IDCentro = oForm.elements['IDCENTROCOMPRAS'].value;
	var d = new Date();
	
	//alert('Publicar datos compra para el centro:'+IDCentro+' de la licitación '+IDLicitacion);
	jQuery("#botonPublicarCompra").hide();
	
	//	Si hay un desplegable de
	if (oForm.elements['IDCENTROCOMPRAS'].type=='select-one')
	{
		var sel = oForm.elements['IDCENTROCOMPRAS'];
		var IDCentro = '';
		for (var i = 0; i < sel.children.length; ++i) {
			IDCentro += sel.children[i].value+'|';
		}
	}
	
	jQuery.ajax({
		cache:	false,
		url:	'http://www.newco.dev.br/Gestion/Comercial/PublicarComprasCentroAJAX.xsql',
		type:	"GET",
		data:	"IDLICITACION="+IDLicitacion+"&IDCENTRO="+IDCentro+"&_="+d.getTime(),
		contentType: "application/xhtml+xml",
		error: function(objeto, quepaso, otroobj){
			alert('error'+quepaso+' '+otroobj+' '+objeto);
		},
		success: function(objeto){
			//var data = eval("(" + objeto + ")");
			var data = JSON.parse(objeto);

			if(data.DatosPublicados.estado == 'Si'){
				location.href = 'http://www.newco.dev.br/Gestion/Comercial/MantLicitacion.xsql?LIC_ID=' + IDLicitacion;
			}else{
				alert(alrt_NuevoEstadoLicKO);
				jQuery("#botonPublicarCompra").show();
			}
		}
	});

}


function verInfoCentros(thisPosArr){
	var IDLicProd = arrProductos[thisPosArr].IDProdLic;
	var IDLicProdEstandar = arrProductos[thisPosArr].IDProd;
	var RefCliente	= (arrProductos[thisPosArr].RefCliente != '') ? arrProductos[thisPosArr].RefCliente : arrProductos[thisPosArr].RefEstandar;
	var NombreProducto = arrProductos[thisPosArr].Nombre;
	var d = new Date();

	jQuery.ajax({
		cache:	false,
		url:	'http://www.newco.dev.br/Gestion/Comercial/InfoHistoricaCentrosAJAX.xsql',
		type:	"GET",
		data:	"IDEMPRESA="+IDEmpresa+"&LIC_PROD_IDPRODEST="+IDLicProdEstandar+"&IDLICITACION="+IDLicitacion+"&_="+d.getTime(),
		beforeSend: function(){
			jQuery("#datosCentros tbody").empty();
		},
		error: function(objeto, quepaso, otroobj){
			alert('error'+quepaso+' '+otroobj+' '+objeto);
		},
		success: function(objeto){
			//var data = eval("(" + objeto + ")");
			var data = JSON.parse(objeto);

			if(data.ListaCentros.length){
				var titulo = str_TituloTablaCentrosProv.replace('[[REFCLIENTE]]',RefCliente).replace('[[NOMBREPROD]]',NombreProducto);
				jQuery("#infoHistoricaCentros #tableTitle").html(titulo);

				jQuery.each(data.ListaCentros, function(key, centro){
					var tbodyCentro = "<tr><td>&nbsp;</td><td style='float:left;'>";
					tbodyCentro += centro.Nombre;
					tbodyCentro += "</td><td>";
					tbodyCentro += centro.Cantidad;		// 1/9/16	CantAnual
					tbodyCentro +="</td><td>&nbsp;</td></tr>";

					jQuery("#datosCentros tbody").append(tbodyCentro);
				});

				showTablaByID("infoHistoricaCentros");
			}
		}
	});
}



// FUNCIONES A MEJORAR - REALMENTE SON NECESARIAS

//En Condiciones Licitacion, hacer comprobacion cuando un usuario quiere volver atras. Si hay cambios se pide confirmacion
function ComprobarDatosGenerales(form){
	var change= '';

	if (form.elements['LIC_DESCRIPCION_OLD'].value == form.elements['LIC_DESCRIPCION'].value){}
	else{ change += '1';}
	if (form.elements['LIC_CONDENTREGA_OLD'].value == form.elements['LIC_CONDENTREGA'].value){}
	else{ change += '2';}
	if (form.elements['LIC_CONDPAGO_OLD'].value == form.elements['LIC_CONDPAGO'].value){}
	else{ change += '3';}
	if (form.elements['LIC_CONDOTRAS_OLD'].value == form.elements['LIC_CONDOTRAS'].value){}
	else{ change += '4';}
	if (form.elements['LIC_MESES_OLD'].value == form.elements['LIC_MESES'].value){}
	else{ change += '5';}

	if(change == ''){
		document.location = 'http://www.newco.dev.br/Gestion/Comercial/Licitaciones.xsql';
	}else{
		if(!confirm(conf_SalirDatosGenLic)){
			null;
		}else{
			document.location = 'http://www.newco.dev.br/Gestion/Comercial/Licitaciones.xsql';
		}
	}
}

// Funcion que realiza una copia de la licitacion para renovarla.
// Se tiene que mejorar para adaptarla a los nuevos campos (por producto, pedido puntual, etc...)
function RenovarLicitacion(){
	var d = new Date();

	jQuery.ajax({
		cache:	false,
		url:	'http://www.newco.dev.br/Gestion/Comercial/RenovarLicitacion.xsql',
		type:	"GET",
		data:	"LIC_ID="+IDLicitacion+"&_="+d.getTime(),
		contentType: "application/xhtml+xml",
		error: function(objeto, quepaso, otroobj){
			alert('error'+quepaso+' '+otroobj+' '+objeto);
		},
		success: function(objeto){
			//var data = eval("(" + objeto + ")");
			var data = JSON.parse(objeto);

			if(data.Resultado.Estado == 'OK'){
				alert(alrt_RenovarLicOK);
                        }else{
				alert(alrt_RenovarLicKO);
                        }
		}
	});
}


//	3oct16	Actualizamos contador de productos seleccionados
function ActualizarProdSeleccionados()
{
	numProdsSeleccion =	0;		//24set16	Inicializamos el contador de productos seleccionados
	for(var j=0; j <arrProductos.length; j++){
		if (arrProductos[j].TieneSeleccion == 'S'){
			numProdsSeleccion++;
		 }
	}
	
	
	//solodebug 3oct16 alert('ActualizarProdSeleccionados numProdsSeleccion:'+numProdsSeleccion);
		
}



//	2may17	Comprueba si hay cambios en la licitacion
function CambiosEnOfertasSeleccionadas(hayCambios)
{
	//debug('licCambiosEnOfertasSel:'+hayCambios);
	

	licCambiosEnOfertasSel=hayCambios;
	
	if (hayCambios=='S')
	{
		jQuery("#botonAdjudicarSelec").hide();
		jQuery("#botonGuardarSelec").show();
	}
	else
	{
		jQuery("#botonAdjudicarSelec").show();
		jQuery("#botonGuardarSelec").hide();
	}
	
}


//	3abr18	quitamos ";" de las cadenas
function StringtoCSV(Cadena)
{
	var CadCSV=Cadena.replace('&amp;','&');
	CadCSV=CadCSV.replace(';','');

	//solodebug
	if (CadCSV!=Cadena) debug('StringtoCSV. ['+Cadena+'] -> ['+CadCSV+']');

	return (sepTextoCSV+CadCSV+sepTextoCSV+sepCSV);
}

function NumbertoCSV(Number) {return (sepTextoCSV+Number.toString()+sepTextoCSV+sepCSV);}


//	16nov17	Exportación completa a Excel de la licitación
function listadoExcelCompleto()
{
	var cadenaCSV='', thisRow='';
	
	prepararTablaProductos(false);			//	Prepara los datos de la tabla sin redibujarla

	//	Preparamos la cabecera para la licitacion
	cadenaCSV=StringtoCSV(objLicitacion['Empresa']+': ('+objLicitacion['Codigo']+') '+objLicitacion['Titulo'])+'\n\r\n\r'+strTitulosColumnasCSV;
			
	//	Titulos de columnas
	for(var j=0; j<arrConsumoProvs.length; j++)
	{

		if (arrConsumoProvs[j].TieneOfertas=='S')
		{	//	COmprueba proveedor con ofertas /Mantenimiento/LICITACION/PRODUCTOSLICITACION/PROVEEDORESLICITACION/PROVEEDOR/TIENE_OFERTAS
			if (IDPais==55)
			{
				cadenaCSV += StringtoCSV('(Marca)'+arrConsumoProvs[j].NombreCorto);
				cadenaCSV += StringtoCSV('(Precio)'+arrConsumoProvs[j].NombreCorto);
			}
			else
				cadenaCSV+=StringtoCSV(arrConsumoProvs[j].NombreCorto);
		}
	
	}
	cadenaCSV+=saltoLineaCSV;
	if(arrProductos.length > 0)
	{

		// Numero de registros para mostrar en la tabla
		//numProductos	= parseInt(jQuery('#numRegistros').val());

		arrRadios = new Array();
		for(var i=0; i<arrProductos.length; i++)
		{
		
			// Col 1. Referencia
			if(arrProductos[ColumnaOrdenadaProds[i]].RefCliente != '')
			{
				thisRow = StringtoCSV(arrProductos[ColumnaOrdenadaProds[i]].RefCliente);	// Mostramos Ref.Cliente si existe
			}
			else
			{
				thisRow = StringtoCSV(arrProductos[ColumnaOrdenadaProds[i]].RefEstandar);	// Mostramos Ref.Estandar si no existe Ref.Cliente
			}

			// Col 2. Nombre
			thisRow += StringtoCSV(arrProductos[ColumnaOrdenadaProds[i]].Nombre);
			
			// Col 3. Numero de ofertas
			thisRow += NumbertoCSV(arrProductos[ColumnaOrdenadaProds[i]].NumOfertas);

			// Col 4. Ud basica
			thisRow += StringtoCSV(arrProductos[ColumnaOrdenadaProds[i]].UdBasica);
			
			// Col 5. Precio hist
			if(mostrarPrecioIVA == 'S')
				thisRow += NumbertoCSV(arrProductos[ColumnaOrdenadaProds[i]].PrecioHistIVA);
			else
				thisRow += NumbertoCSV(arrProductos[ColumnaOrdenadaProds[i]].PrecioHist);
			
			// Col 6. Precio obj
			if(mostrarPrecioIVA == 'S')
			{
				if (arrProductos[ColumnaOrdenadaProds[i]].PrecioObjIVA != undefined)
					thisRow += NumbertoCSV(arrProductos[ColumnaOrdenadaProds[i]].PrecioObjIVA);
			}
			else
			{
				if (arrProductos[ColumnaOrdenadaProds[i]].PrecioObj != undefined)
					thisRow += NumbertoCSV(arrProductos[ColumnaOrdenadaProds[i]].PrecioObj);
			}
			
			// Col 7. Ahorro
			thisRow += NumbertoCSV(arrProductos[ColumnaOrdenadaProds[i]].AhorroMax);

			// Col 8. Cantidad
			thisRow += NumbertoCSV(arrProductos[ColumnaOrdenadaProds[i]].Cantidad);

			// Col 8. Consumo
			if(mostrarPrecioIVA == 'S')
				thisRow += NumbertoCSV(arrProductos[ColumnaOrdenadaProds[i]].ConsumoHistIVA);
			else
				thisRow += NumbertoCSV(arrProductos[ColumnaOrdenadaProds[i]].ConsumoHist);

			// Celda/Columna TipoIVA
			thisCell = cellStartClass;
			if(IDPais != 55)
			{
				thisRow += StringtoCSV(arrProductos[ColumnaOrdenadaProds[i]].TipoIVA + '%');
			}

			// DATOS DE LAS OFERTAS
			// Recorremos todos los proveedores que han ofertado

			//solodebug	if (i==0) 
			debug(i+'/'+arrProductos[ColumnaOrdenadaProds[i]].Ofertas.length+' '+arrProductos[ColumnaOrdenadaProds[i]].IDProdLic);

			for(var j=0; j<arrProductos[ColumnaOrdenadaProds[i]].Ofertas.length; j++)
			{
			
				//solodebug
				debug(j+' '+arrProductos[ColumnaOrdenadaProds[i]].IDProdLic+'	'+arrProductos[ColumnaOrdenadaProds[i]].Ofertas[j].IDProvLic
									+' '+arrProductos[ColumnaOrdenadaProds[i]].Ofertas[j].IDOferta+' of:'+arrConsumoProvs[j].TieneOfertas);
				
			
				if (arrConsumoProvs[j].TieneOfertas=='S')
				{	//	COmprueba proveedor con ofertas /Mantenimiento/LICITACION/PRODUCTOSLICITACION/PROVEEDORESLICITACION/PROVEEDOR/TIENE_OFERTAS

					//solodebug	
					debug(arrConsumoProvs[j].NombreCorto+' tiene ofertas:'+arrConsumoProvs[j].TieneOfertas
						+ ' NoInformada:'+arrProductos[ColumnaOrdenadaProds[i]].Ofertas[j].NoInformada
						+ ' NoOfertada:'+arrProductos[ColumnaOrdenadaProds[i]].Ofertas[j].NoOfertada
						+ ' Marca:'+arrProductos[ColumnaOrdenadaProds[i]].Ofertas[j].Marca
						+ ' Precio:'+arrProductos[ColumnaOrdenadaProds[i]].Ofertas[j].Precio
						);

					if(arrProductos[ColumnaOrdenadaProds[i]].Ofertas[j].NoInformada == 'S')
					{
						// Si la oferta del proveedor para este producto no esta informada
						if (IDPais==55) thisRow += StringtoCSV('');
						thisRow += StringtoCSV('');
					}
					else if(arrProductos[ColumnaOrdenadaProds[i]].Ofertas[j].NoOfertada == 'S')
					{
						// Si el proveedor ha informado de algunas ofertas, pero esta esta vacia
						if (IDPais==55) thisRow += StringtoCSV('');
						thisRow += StringtoCSV('');
					}
					else
					{	// Si esta oferta esta informada
						if (IDPais==55) thisRow += StringtoCSV(arrProductos[ColumnaOrdenadaProds[i]].Ofertas[j].Marca);
						thisRow += NumbertoCSV(arrProductos[ColumnaOrdenadaProds[i]].Ofertas[j].Precio );
					}	//fin comprueba oferta informada	
					
				}	//fin comprueba proveedor con ofertas	
				debug('thisRow:'+thisRow);
			}	//	fin bucle proveedores
						
			//thisRow += saltoLineaCSV;	
			//cadenaCSV += decodeURIComponent(escape(thisRow))+saltoLineaCSV;
			cadenaCSV += thisRow+saltoLineaCSV;

		}// fin bucle productos

    }
	
	//DescargaMIME(cadenaCSV, 'Licitacion.csv', 'text/csv;encoding:utf-8');		//	http://www.newco.dev.br/General/descargas_151117.js
	DescargaMIME(StringToISO(cadenaCSV), 'Licitacion.csv', 'text/csv');		//	http://www.newco.dev.br/General/descargas_151117.js
	
}


/*

//	9jul18	
function actualizarAdjudicacionMultiple(IDProductoLic, ListaOfertas)
{
	debug('IDProducto:'+IDProducto+' ListaOfertas:'+ListaOfertas);

	var lineaProd=-1;

	//	Busca el producto 	
	if(totalProductos > 0)
	{
		for(var i=0; (i<totalProductos)&&(lineaProd==-1); i++)
		{
			if (arrProductos[i].IDProdLic=IDProductoLic)
				lineaProd=i;
		}
	}

	debug('IDProducto:'+IDProducto+' en linea '+lineaProd);


	for(j=0;j<PieceCount(ListaOfertas,'|');++j)
	{
	
		var cadOferta=Piece(ListaOfertas,'|',j);
		
		var IDOferta=Piece(cadOferta,'#',0);
		var Orden=Piece(cadOferta,'#',1);
		
		debug('IDProducto:'+IDProducto+' en linea '+lineaProd+ 'COmprobando IDOferta:'+IDOferta+' Orden:'+Orden);
	
	}

//	arrProductos[j].Ofertas.IDOferta


	dibujaTablaProductosOFE();
}

*/


//	10jul18 Adjudica producto a producto, múltiples ofertas seleccionadas
function AdjudicarOfertasMultiples()
{
	var errores='',resAdjudicacion='',debug='',prodAdju=0,prodOpcion1=0,cadAdjudicados;

	//solodebug	debug('AdjudicarOfertasMultiples 13jul18 10:52');
	
	//Revisa la situación de la adjudicación, solicita confirmación del usuario antes de adjudicar
	if(totalProductos = 0)
	{
		errores=str_licSinProductos;
	}
	else
	{
		for(var i=0; i<arrProductos.length; i++)
		{
			//debug=debug+'i:'+arrProductos[i].IDProdLic+'|';
			var Adjud='N',Orden1='N';
			resAdjudicacion+='('+arrProductos[i].RefEstandar+') '+arrProductos[i].Nombre+':';
			cadAdjudicados='';
			for (var j=0; j<arrProductos[i].Ofertas.length; ++j)
			{
				if (arrProductos[i].Ofertas[j].OfertaAdjud=='S')
				{
					Adjud='S';
					if (arrProductos[i].Ofertas[j].Orden=='1') Orden1='S';
					
					cadAdjudicados+=((cadAdjudicados=='')?'':',')+arrProductos[i].Ofertas[j].Orden;
				}
			}
			
			if (Adjud=='S') ++prodAdju;
			if (Orden1=='S') ++prodOpcion1;
			resAdjudicacion+=((cadAdjudicados=='')?str_NoAdjudicado:cadAdjudicados)+'\n\r';
		}
		//debug('AdjudicarOfertasMultiples:'+debug);
		
		if (prodAdju==0) 
		{
			errores=alrt_sinProductosSeleccionados;
		}
		else
		{
			resAdjudicacion=alrt_SeleccionadosYOrden1.replace('[[NUM_PROD_TOTAL]]',arrProductos.length).replace('[[NUM_PROD_ADJ]]',prodAdju).replace('[[NUM_ORDEN1]]',prodOpcion1)+'\n\r\n\r'+resAdjudicacion;
		}
	}

	if ((errores=='')&&(confirm(resAdjudicacion)))
	{
		errorAdjud='N';
		AdjudicarOfertasMultiplesAjax(0);
	}
	else
	{
		alert(errores);
	}

	//solodebug	
	debug('AdjudicarOfertasMultiples: Saliendo. errores: ['+errores+'] resAdjudicacion: ['+resAdjudicacion+']');
	
}


//	16mar18	Una vez creada la cadena completa, la enviamos por bloques
var errorAdjud;
function AdjudicarOfertasMultiplesAjax(fila)
{
	//var thisRowID, thisPosArr, thisLicProdID, isThisChecked;
	//var ListaOfertasPagina = '', errores = 0, numProdsTotal = 0, numProdsLista = 0, numProdsAdj = 0;
	var d = new Date();

	//solodebug	
	debug('AdjudicarOfertasMultiplesAjax:'+fila+ ' errorAdjud:'+errorAdjud);
	

	if ((fila==arrProductos.length)||(errorAdjud=='S'))
	{
		if (errorAdjud=='N')
		{
			alert(alrt_guardarAdjudicacionOK);
			CambioEstadoLicitacion('CONT');
		}

		return;
	}

	//solodebug	
	debug('AdjudicarOfertasMultiplesAjax. fila:'+fila+' IDProdLic:'+arrProductos[fila].IDProdLic);


	jQuery.ajax({
		cache:	false,
		url:	'http://www.newco.dev.br/Gestion/Comercial/AdjudicarProductoMultiplesOfertasAJAX.xsql',
		type:	"GET",
		data:	"IDLIC="+IDLicitacion+"&IDPRODUCTOLIC="+arrProductos[fila].IDProdLic+"&_="+d.getTime(),
		contentType: "application/xhtml+xml",
		beforeSend: function(){
			jQuery("#botonAdjudicarSelec").hide();
			jQuery("#idAvanceAdjudicar").show();
		},
		success: function(objeto){
			//var data = eval("(" + objeto + ")");
			var data = JSON.parse(objeto);

			if(data.Resultado.Estado == 'OK'){
				jQuery('#idAvanceAdjudicar').html((fila+1)+'/'+arrProductos.length);
				++fila;

				//solodebug		debug('AdjudicarOfertasMultiplesAjax. SIGUIENTE. fila:'+fila);
				
				AdjudicarOfertasMultiplesAjax(fila);
			}
			else
			{
				errorAdjud='S';
				alert(alrt_guardarAdjudicacionKO);
				jQuery("#botonAdjudicarSelec").show();
				jQuery("#idAvanceAdjudicar").hide();
			}

			return;
		},
		error: function(xhr, errorString, exception) {
			alert("xhr.status="+xhr.status+" error="+errorString+" exception="+exception);
			errorAdjud='S';
			return;
		}
	});

}


//	27feb19 Borrar todos los productos de la licitación, para empezar a informar desde 0.
function BorrarTodosProductos()
{
	if (confirm(alrt_borrarTodosProductos))
	{
		document.forms['form1'].action="http://www.newco.dev.br/Gestion/Comercial/MantLicitacionAcciones.xsql?ACCION=BORRARPRODUCTOS&LIC_ID="+IDLicitacion;
		SubmitForm(document.forms['form1']);
	}
}


//	27feb19 Borrar todos los proveedores de la licitación, para empezar a informar desde 0.
function BorrarTodosProveedores()
{
	if (confirm(alrt_borrarTodosProveedores))
	{
		document.forms['form1'].action="http://www.newco.dev.br/Gestion/Comercial/MantLicitacionAcciones.xsql?ACCION=BORRARPROVEEDORES&LIC_ID="+IDLicitacion;
		SubmitForm(document.forms['form1']);
	}
}


//	15abr19 Agregar licitacion a la actual
function AgregarLicitacion()
{
	var IDLicitacionSec=jQuery("#LICITACIONES_EST").val(),
		LicitacionSec=jQuery("#LICITACIONES_EST option:selected").text();
	if (confirm(alrt_AgregarLicitacion.replace("[[LICITACION]]",LicitacionSec.trim().replace(/\n/g,"").replace(/\[/g,"").replace(/\]/g,""))))
	{
		document.forms['form1'].action="http://www.newco.dev.br/Gestion/Comercial/MantLicitacionAcciones.xsql?ACCION=AGREGARLIC&LIC_ID="+IDLicitacion+'&IDLICITACIONSEC='+IDLicitacionSec;
		SubmitForm(document.forms['form1']);
	}
}


//	27may19 Informa cantidades (desde la ficha de producto, cuando se distribuye entre varios proveedores)
function informaCantidades(IDProdLic, multOfertas, recFloatingBox)
{
	//solodebug
	debug("informaCantidades IDProdLic:"+IDProdLic+" multOfertas:"+multOfertas + " INICIO");


	var posProd=posicionProductoLic(IDProdLic);
	
	var PrecioTxt =(mostrarPrecioIVA == 'S') ?  arrProductos[posProd].PrecioHistIVA : arrProductos[posProd].PrecioHist;
	var Precio= ((PrecioTxt=='')?0:parseFloat(PrecioTxt.replace(",",".")));

	//solodebug
	debug("informaCantidades IDProdLic:"+IDProdLic+" multOfertas:"+multOfertas +' posProd:'+posProd+ " Precio:"+Precio+' NumOfertas:'+arrProductos[posProd].Ofertas.length+ 'INICIO');

	//	Recorre la matriz con las ofertas anteriores para descontar las cantidades anteriores
	for(var i=0;i<arrProductos[posProd].Ofertas.length;i++)
	{

		//solodebug
		//debug("informaCantidades("+i+") IDProdLic:"+IDProdLic+" multOfertas:"+multOfertas + ' CantAdjud:'+arrProductos[posProd].Ofertas[i].CantAdjud+ " ConsumoPot:"+ConsumoPot+' ConsumoPrev:'+ConsumoPrev+' Ahorro:'+Ahorro);

		if (arrProductos[posProd].Ofertas[i].OfertaAdjud==='S')
		{
			
			//solodebug
			//debug("informaCantidades("+i+"): ADJUDICADA ");
			
			var PrecioOfertaTxt =(mostrarPrecioIVA == 'S') ?  arrProductos[posProd].Ofertas[i].PrecioIVA : arrProductos[posProd].Ofertas[i].Precio;
			var PrecioOferta	= parseFloat(PrecioOfertaTxt.replace(",","."));
			var CantAdjud=parseFloat(arrProductos[posProd].Ofertas[i].CantAdjud.replace(",","."));
			
			ConsumoPot-=CantAdjud*Precio;
			ConsumoPrev-=CantAdjud*PrecioOferta;
			
			//	Marca las ofertas como no adjudicadas
			arrProveedores[i].OfertasAdj--;
			arrProductos[posProd].Ofertas[i].OfertaAdjud='N';
			arrProductos[posProd].Ofertas[i].CantAdjud=0;
			//29may19	arrConsumoProvs[i].OfertasAdjAux--;
			arrConsumoProvs[i].OfertasAdj--;

			debug("informaCantidades("+i+") ADJ ANT. IDProdLic:"+IDProdLic+" multOfertas:"+multOfertas+ " IDOfertaLic:" + arrProductos[posProd].Ofertas[i].ID
				+' CantAdjud:'+CantAdjud+' PrecioOferta:'+PrecioOferta+ " ConsumoPot:"+ConsumoPot+' ConsumoPrev:'+ConsumoPrev);
			
		}
		
	}

	
	for (var i=0;i<PieceCount(multOfertas,'|');i++)
	{
		var Cad=Piece(multOfertas,'|',i);

		//solodebug debug("informaCantidades("+i+") IDProdLic:"+IDProdLic+" multOfertas:"+multOfertas + " Cad:" + Cad);

		if (Cad!='')
		{

			var IDOfertaLic=Piece(Cad,'#',0);
			CantTxt=Piece(Cad,'#',1);
			var Cant=parseInt(CantTxt);

			//solodebug debug("informaCantidades("+i+") IDProdLic:"+IDProdLic+" multOfertas:"+multOfertas + " Cad:" + Cad+ " IDOfertaLic:" + IDOfertaLic);

			
			var posOf=posicionOfertaLic(posProd, IDOfertaLic);
		
			//solodebug debug("informaCantidades("+i+") IDProdLic:"+IDProdLic+" multOfertas:"+multOfertas + " Cad:" + Cad+ " IDOfertaLic:" + IDOfertaLic+ " posOf:"+posOf+' Cant:'+Cant);

			//	Suma el nuevo consumo
			var PrecioOfertaTxt =(mostrarPrecioIVA == 'S') ?  arrProductos[posProd].Ofertas[posOf].PrecioIVA : arrProductos[posProd].Ofertas[posOf].Precio;
			PrecioOferta= parseFloat(PrecioOfertaTxt.replace(",","."));
			
			ConsumoPot+=Cant*Precio;
			ConsumoPrev+=Cant*PrecioOferta;

			debug("informaCantidades("+i+") ADJ AHORA. IDProdLic:"+IDProdLic+" multOfertas:"+multOfertas + " Cad:" + Cad+ " IDOfertaLic:" + IDOfertaLic+ ' PrecioOferta:'+PrecioOfertaTxt
				+ " ConsumoPot:"+ConsumoPot+' ConsumoPrev:'+ConsumoPrev+' Ahorro:'+Ahorro);
			
			
			//	Informa la matriz con los nuevos datos
			arrProveedores[posOf].OfertasAdj++;
			arrProductos[posProd].Ofertas[posOf].CantAdjud=CantTxt;
			arrProductos[posProd].Ofertas[posOf].OfertaAdjud='S';
			//29may19	arrConsumoProvs[i].OfertasAdjAux++;
			arrConsumoProvs[i].OfertasAdj++;
			
		}
		
	}
	
	Ahorro=(ConsumoPot==0)?0:100*(ConsumoPot-ConsumoPrev)/ConsumoPot;
	numProvsAdj=ProveedoresAdjudicados();
	
	/*
	
		Pendiente calcular proveedores adjudicados y total ofertas
		
			numProvsAdj++;
			NumOfertas++;
		
	*/
	

	//solodebug
	debug("informaCantidades IDProdLic:"+IDProdLic+" multOfertas:"+multOfertas + " ConsumoPot:"+ConsumoPot+' ConsumoPrev:'+ConsumoPrev+' Ahorro:'+Ahorro+ ' numProvsAdj:'+numProvsAdj +' Ahora dibujaTablaProductosOFE');
	
	dibujaTablaProductosOFE();

	//solodebug
	debug("informaCantidades IDProdLic:"+IDProdLic+" multOfertas:"+multOfertas + " ConsumoPot:"+ConsumoPot+' ConsumoPrev:'+ConsumoPrev+' Ahorro:'+Ahorro+ ' numProvsAdj:'+numProvsAdj +' Ahora mostrarFloatingBox');

	mostrarFloatingBox();

}


//	27may19 Busca la posición de un producto en la matriz
function posicionProductoLic(IDProdLic)
{
	var pos=-1;
	
	for(var i=0;(i<arrProductos.length)&&(pos===-1);++i)
	{
		if (arrProductos[i].IDProdLic==IDProdLic) pos=i;
	}
	return pos;
}



//	27may19 Busca la posición de una oferta en la matriz
function posicionOfertaLic(posProd, IDOfertaLic)
{
	var pos=-1;

	//	solodebug debug("posicionOfertaLic posProd:"+posProd+" IDOfertaLic:"+IDOfertaLic );
	
	for(var i=0;(i<arrProductos[posProd].Ofertas.length)&&(pos===-1);++i)
	{
		if (arrProductos[posProd].Ofertas[i].ID==IDOfertaLic) pos=i;
	}
	
	//solodebug debug("posicionOfertaLic posProd:"+posProd+" IDOfertaLic:"+IDOfertaLic + ' res:' +pos);

	return pos;
}


//	29may19 inicializa los campos necesarios para el Floating Box
function inicializaFloatingBox()
{
	//solodebug	debug("inicializaFloatingBox. INICIO. NumProductos:"+arrProductos.length);

	ConsumoPot=0;ConsumoPrev=0;NumOfertas=0;numProdConOfe=0;numProdsAdjud=0;Ahorro=0;
	
	//	Recorre la matriz de productos
	for(var j=0;j<arrProductos.length;j++)
	{

		//solodebug	debug("inicializaFloatingBox. Recorriendo producto: " + j);
		
		if (arrProductos[j].NumOfertas>0) 	numProdConOfe++;
		if (arrProductos[j].TieneSeleccion=='S') ++numProdsAdjud;
	
		var PrecioTxt =(mostrarPrecioIVA == 'S') ?  arrProductos[j].PrecioHistIVA : arrProductos[j].PrecioHist;
		var Precio= ((PrecioTxt=='')?0:parseFloat(PrecioTxt.replace(",",".")));

		//	Recorre la matriz con de ofertas (solo para productos con ofertas
		for(var i=0;i<arrProductos[j].Ofertas.length;i++)
		{

			//solodebug	debug("inicializaFloatingBox("+i+") IDProdLic:"+arrProductos[j].IDProdLic + ' CantAdjud:'+arrProductos[j].Ofertas[i].CantAdjud+ " ConsumoPot:"+ConsumoPot+' ConsumoPrev:'+ConsumoPrev+' Ahorro:'+Ahorro);

			if (arrProductos[j].Ofertas[i].OfertaAdjud=='S')
			{

				//solodebug	debug("informaCantidades("+i+"): ADJUDICADA ");
				
				try
				{
					var PrecioOfertaTxt =(mostrarPrecioIVA == 'S') ?  arrProductos[j].Ofertas[i].PrecioIVA : arrProductos[j].Ofertas[i].Precio;
					var PrecioOferta	=parseFloat(PrecioOfertaTxt.replace(",","."));
					var CantAdjud		=parseFloat(arrProductos[j].Ofertas[i].CantAdjud.replace(",","."));

					ConsumoPot+=CantAdjud*Precio;
					ConsumoPrev+=CantAdjud*PrecioOferta;
		
					//solodebug	debug("inicializaFloatingBox("+j+','+i+") ADJUDICADA. IDProdLic:"+arrProductos[j].IDProdLic+ " IDOfertaLic:" + arrProductos[j].Ofertas[i].ID+' CantAdjud:'+CantAdjud+' PrecioOferta:'+PrecioOferta+ " ConsumoPot:"+ConsumoPot+' ConsumoPrev:'+ConsumoPrev);
				}
				catch(e)
				{
					//solodebug	debug("inicializaFloatingBox("+j+','+i+") ADJUDICADA. IDProdLic:"+arrProductos[j].IDProdLic+ " IDOfertaLic:" + arrProductos[j].Ofertas[i].ID+' CantAdjud:'+arrProductos[j].Ofertas[i].CantAdjud+' PrecioOferta:'+arrProductos[j].Ofertas[i].Precio+ " ConsumoPot:"+ConsumoPot+' ConsumoPrev:'+ConsumoPrev+' error:'+e);
				}


			}
		}
	}
	Ahorro=(ConsumoPot==0)?0:100*(ConsumoPot-ConsumoPrev)/ConsumoPot;
	
	numProvsAdj=ProveedoresAdjudicados();
	
	//solodebug debug("inicializaFloatingBox. FINAL. ConsumoPot:"+ConsumoPot+' ConsumoPrev:'+ConsumoPrev+' Ahorro:'+Ahorro+' numProdConOfe:'+numProdConOfe+' numProdsAdjud:'+numProdsAdjud+' numProvsAdj:'+numProvsAdj);

}

//	29may19 Busca el número de proveedores adjudicados
function ProveedoresAdjudicados()
{
	var ProvAdjud=0;

	for (var i=0;i<arrProveedores.length;++i)
	{
		if (arrProveedores[i].OfertasAdj>0) ++ProvAdjud;
	}
		
	return ProvAdjud;
}



//	Reloadd puede enviar parámetros equivocados
function Recarga()
{
	window.open('http://www.newco.dev.br/Gestion/Comercial/MantLicitacion.xsql?LIC_ID='+IDRegistro,'_self');
	
}


//	12set19 Cambia el estado de la licitación directamente a contrato
function PasarAEstadoContrato()
{
	jQuery('#botonEstContrato').hide();
	if (confirm(alrt_avisoEstadoContrato))
	{
		document.forms['form1'].action="http://www.newco.dev.br/Gestion/Comercial/MantLicitacionAcciones.xsql?ACCION=PASARACONTRATO&LIC_ID="+IDLicitacion;
		SubmitForm(document.forms['form1']);
	}
	else
		jQuery('#botonEstContrato').show();
}


//	27ene20 Ver pedidos
function VerPedidos(IDLicitacion)
{
	MostrarPagPersonalizada('http://www.newco.dev.br/Personal/BandejaTrabajo/AnalisisPedidos.xsql?IDLICITACION='+IDLicitacion,'HistoricoPedidos',90,90,10,10);
}


// 17feb20	Funcion que descarga la OC
function DescargarOC(IDFichero){
	var d = new Date();

	console.log("DescargarOC:"+IDFichero);

	jQuery.ajax({
		url: 'http://www.newco.dev.br/Gestion/AdminTecnica/DescargaOC.xsql',
		data: "IDFICHERO="+IDFichero+"&_="+d.getTime(),
		type: "GET",
		contentType: "application/xhtml+xml",
		error: function(objeto, quepaso, otroobj){
		  alert('error'+quepaso+' '+otroobj+''+objeto);
		},
		success: function(objeto){

			var data = JSON.parse(objeto);

			var urlfichero='http://www.newco.dev.br/Descargas/'+data.url;
			console.log("DescargarOC:"+IDFichero+':'+urlfichero);

			if(data.estado == 'ok')
			{
				MostrarPagPersonalizada(urlfichero,data.nombre,90,90,0,0);
			}
			else{
				alert('Se ha producido un error. No se puede descargar el fichero '+urlfichero+'.');
			}
		}
	  });
}


//	12feb20 Permite abrir un documento subido por un proveedor
function VerDocumento(IDDocumento)
{
	var d = new Date();
	//	Recupera los datos del documento vía Ajax
	jQuery.ajax({
		cache:	false,
		url:	'http://www.newco.dev.br/Administracion/Mantenimiento/Productos/datosDocumentoAJAX.xsql',
		type:	"GET",
		data:	"PARAMETROS="+IDLicitacion+"&IDDOCUMENTO="+IDDocumento+"&_="+d.getTime(),
		contentType: "application/xhtml+xml",
		beforeSend: function(){
		},
		success: function(objeto){
			//var data = eval("(" + objeto + ")");
			var data = JSON.parse(objeto);

			if(data.id != '')
			{
			
				var Url="http://www.newco.dev.br/Documentos/"+data.url;
				
				//solodebug	debug('VerDocumento. URL:'+Url);
				
				MostrarPagPersonalizada(Url,data.nombre,90,90,0,0);
			}
			else
			{
				alert(alrt_noSePuedeAbrirDocumento);
			}
		},
		error: function(xhr, errorString, exception) {
			alert(alrt_noSePuedeAbrirDocumento);
		}
	});
	
}


//	5ago20 Había desaparecido esta función
function ActivarBotonGuardarCentro(pos)
{
	jQuery('#btnGuardar_' + pos).show();
}


