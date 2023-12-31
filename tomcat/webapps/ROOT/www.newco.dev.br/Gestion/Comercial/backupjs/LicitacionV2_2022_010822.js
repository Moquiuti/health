//	Funciones JS para LICITACION v2 (nueva version)
//	Ultima revisi�n ET 25jul22 12:30 LicitacionV2_2022_010822.js


//	Variables globales
var gl_ProductoAbierto = '-1';				//	Producto abierto

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


var macroImagen		= '<img src="#SRC#" title="#TITLE#" alt="#ALT#"/>';
var macroImagen2	= '<img src="#SRC#" id="#ID#" title="#TITLE#" alt="#ALT#"/>';
var macroImagen3	= '<img src="#SRC#" class="#CLASS#" title="#TITLE#" alt="#ALT#"/>';
var macroImagen5	= '<img id="#ID#" src="#SRC#" class="#CLASS#" title="#TITLE#" alt="#ALT#" style="#STYLE#"/>';	//17set16 para esconder imagen en entradas de datos por fila





//	Ejecutar  al final de la carga de "body"
function onLoad()
{
	debug('onLoad. IDProdLicActivo:'+IDProdLicActivo);


	//	Informar fecha de vencimiento en el campo editable
	var Anno=parseInt(Piece(fechaDecisionLic,'/',2));
	if (Anno<2000) Anno+=2000;
	var Fecha=Anno+'-'+Piece(fechaDecisionLic,'/',1)+'-'+Piece(fechaDecisionLic,'/',0);
	//solodebug	console.log('onLoad. Fecha:'+Fecha);
	jQuery('#FECHADECISION').val(Fecha);
	
	if (EstadoLic=='EST')
		jQuery("#selVista").val("pes_lIncluirProductos");
	else
		jQuery("#selVista").val("pes_lProductos");

	CambiaVista();

	if (EstadoLic=='COMP')
	{
		//	en estado "completar compra por centro", no mostrar desplegable de vistas
		jQuery("#selVista").hide();
		CargarDatosComprasCentro();

		jQuery('#spCargaProductos').hide();
		jQuery('#pCargaProductos').hide();
	}
	else
	{
		IncluirProveedores();
		ListaProductos();
		PrepararColumnasMatriz();		//5jul22
	
		CargaOfertas(0);
	}

	if (esAutor=='S')
	{

		if (IDPais==55) ActivarPestannaProv('Selecciones');
		else ActivarPestannaProv('Proveedores');

		// Pesta�a Proveedores/Selecciones
		jQuery("#pes_lpSelecciones").click(function(){
			ActivarPestannaProv("Selecciones");
		});

		// Pesta�a Proveedores/Proveedores
		jQuery("#pes_lpProveedores").click(function(){
			ActivarPestannaProv("Proveedores");
		});

		ActivarPestannaProd('PorReferencia');
		
		// Pesta�a IncluirProductos/Por referencia
		jQuery("#pes_lpPorReferencia").click(function(){
			ActivarPestannaProd("PorReferencia");
		});

		// Pesta�a IncluirProductos/Por catalogo
		jQuery("#pes_lpPorCatalogo").click(function(){
			ActivarPestannaProd("PorCatalogo");
		});
		
		// Evento click a todos los radio buttons que se generan en la tabla 'lProductos_OFE'
		jQuery('table#lProductos_OFE tbody').on('click', 'input[type=radio]', function(){
			clickRadio(Piece(this.name,'_',1), this.value);
		});

	}
}


//	5jul22 Busca la columna DE LA MATRIZ DE OFERTAS correspondiente al proveedor
function PrepararColumnasMatriz()
{
	var Pos=0;
	for (var i=0; i<arrConsumoProvs.length;++i)
	{
		if (arrConsumoProvs[i].TieneOfertas=='S')
		{
			arrConsumoProvs[i].ColMatriz=Pos;
			++Pos;
			
			//solodebug debug('PrepararColumnasMatriz. Proveedor('+i+'):'+arrConsumoProvs[i].NombreCorto+'. Pos:'+arrConsumoProvs[i].ColMatriz);
		}
	}

	//	INFORMA LA VARIABLE GLOBAL NumColsMatriz
	NumColsMatriz=Pos;
}


//	20jun22 Cambia la vista seleccionada (Productos, proveedores, etc). Dibuja la tabla correspondiente si no esta todavia dibujada.
function CambiaVista()
{
	jQuery('.Vista').hide();
	var Vista=jQuery('#selVista').val().substring(4);

	//solodebug	
	debug('CambiaVista:'+Vista);


	//	Tablas que deben ser redibujadas al entrar, por si han habido cambios en los datos
	if (Vista=='lProductos')
	{
		//solodebug	
		debug('CambiaVista:'+Vista+" ListaProductos");

		//	lista de productos
		ListaProductos();
	}			
	if (Vista=='lProveedores')
	{
		//solodebug	
		debug('CambiaVista:'+Vista+" dibujaTablaProveedores");

		//	Tabla de provedores
		dibujaTablaProveedores();
	}			
	else if (Vista=='lMatriz')
	{
		//solodebug	
		debug('CambiaVista:'+Vista+" prepararTablaProductos");

		// Preparamos los datos para dibujar la matriz de ofertas
		prepararTablaProductos(true);
	}			
	
	//solodebug	debug('CambiaVista:'+Vista);
	jQuery('#'+Vista).show();	
}


//	Incluye los proveedores desde el array al desplegable
function IncluirProveedores()
{
	jQuery('#IDPROVEEDOR').append('<option value="">'+strSeleccionar+"</option>")
	for (var i=0;i<arrConsumoProvs.length;++i)
		jQuery('#IDPROVEEDOR').append("<option value='"+arrConsumoProvs[i].ID+"' >"+arrConsumoProvs[i].NombreCorto+"</option>")
}


//	Cambios de pesta�a de proveedores
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


//	Cambios de pesta�a de proveedores
function ActivarPestannaProd(pestanna)
{
	//solodebug 
	console.log('ActivarPestannaProd:'+pestanna)

	jQuery("a.MenuProd").attr('class', 'MenuProd MenuInactivo');
	jQuery("#pes_lp"+pestanna).attr('class', 'MenuProd MenuActivo');
	
	if (pestanna=='PorReferencia')
	{
		jQuery("#lpRefProductos").show();
		jQuery("#lpCatPrivProductos").hide();
	}
	else
	{
		jQuery("#lpRefProductos").hide();
		jQuery("#lpCatPrivProductos").show();
	}
	
}


//	Muestra la lista de productos
function ListaProductos()
{
	gl_ProductoAbierto=-1;	//	10jul22 Indica que estan todos los productos cerrados al dibujar
	
	var lineaProducto='<div id="divProd_[IND]" class="cotacao_fechado">'
							+'<div class="div_coluna_1_cotacaoprodutos_titulo">'
							+'	<div  class="qtd_produto_cotacao">'
							+'		<br/><p class="quantidade_cotacao_fechado"><span id="spProd_[IND]" class="rojo w300px"><a href="javascript:AbrirProducto([IND]);">[CONT]/[TOTAL] - ([REFCLIENTE])</a></span></p>'
							+'	</div>'
							+'	<div class="informacao_produto_cotacao_fechado">'
							+'		<p>[NOMBRE]</p>'
							+'	</div>'
							+'	<div class="info_cotacao_fechado">'
							+'		<p id="pAhorro_[IND]"></p>'
							+'	</div>'
							+'	<div class="info_cotacao_fechado">'
							+'		<p id="pOfertas_[IND]"></p>'
							+'	</div>'
							/*	29jun22 Guardar automaticamente al activar el checkbox o en el lostfocus de cantidad
							+'	<div class="info_cotacao_fechado_salvar">'
							+'		<a class="btnDestacado floatRight marginRight50" href="javascript:GuardarProductoSel([IND],\'SIGUIENTE\');">'+strGuardar+'</a>'
							+'	</div>'*/
							+'</div>'
						+'</div><div id="divOfe_[IND]" class="div_coluna_tabela_cotacao" style="display:none"></div>';


	var html='', ofCargadas='N';

	//	Recorre el array de productos
	for (var i=0;i<arrProductos.length;++i)
	{
	
		//solodebug	debug("ListaProductos ("+i+"). Comprobar CumpleFiltro:"+arrProductos[i].CumpleFiltro+' TotalProd:'+arrProductos.length);
	
		if (arrProductos[i].CumpleFiltro=='S')
		{

			//solodebug	debug("ListaProductos ("+i+"). CumpleFiltro.");

			var linea=lineaProducto.replaceAll('[IND]',i);
			linea=linea.replace('[CONT]',(i+1));
			linea=linea.replace('[TOTAL]',arrProductos.length);
			linea=linea.replace('[REFCLIENTE]',((arrProductos[i].RefCliente!='')?arrProductos[i].RefCliente:arrProductos[i].RefEstandar));
			linea=linea.replace('[NOMBRE]',arrProductos[i].Nombre.substring(0,80));

			if (arrProductos[i].OfCargadas=='S') ofCargadas='S';

			html+=linea;
		}
	}
	
	jQuery("#listaProductos").html(html);	
	
	//	Actualiza la info de ofertas 
	if (ofCargadas=='S')
	{
		for (var i=0;i<arrProductos.length;++i)
		{
			if (arrProductos[i].CumpleFiltro=='S')
			{
				//	Cambia el fondo del color del producto que se ha cargado
				jQuery("#spProd_"+i).removeClass('rojo');			//16jun22 dejamos fondo blanco	.addClass('fondoAzul');
				//	Informa del numero de ofertas
				ActualizaOfertas(i);
			}
		}
	}
}


//	Carga las ofertas por producto
function CargaOfertas(Pos)
{
	var d = new Date();

	//solodebug debug('CargaOfertas:'+Pos);

	if (Pos==arrProductos.length)
	{
		jQuery('#divBuscador').show();
		jQuery('#spCargaProductos').hide();
		jQuery('#pCargaProductos').hide();

		//	16jun22 Actualiza el contador junto al carrito
		ActualizarContador();
		
		//solodebug	debug('CargaOfertas:'+Pos+' FIN');		

		//30jun22 Inicializa los datos del FloatingBox
		if ((EstadoLic!='EST')&&(EstadoLic!='COMP'))
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
	
	jQuery.ajax({
		cache:	false,
		url:	'http://www.newco.dev.br/Gestion/Comercial/OfertasProductoLicitacionAjax.xsql',
		type:	"GET",
		data:	"LIC_ID="+IDLicitacion+"&LIC_PROD_ID="+arrProductos[Pos].IDProdLic+"&_="+d.getTime(),
		contentType: "application/xhtml+xml",
		//async: false,
		success: function(objeto){
			var data = JSON.parse(objeto);

			var UltCompra=[];
			UltCompra.FECHA=data.OfertasProductoLic.UltCompra.FECHA;
			UltCompra.MO_ID=data.OfertasProductoLic.UltCompra.MO_ID;
			UltCompra.IDPROVEEDOR=data.OfertasProductoLic.UltCompra.IDPROVEEDOR;
			UltCompra.PROVEEDOR=data.OfertasProductoLic.UltCompra.PROVEEDOR;
			UltCompra.MARCA=data.OfertasProductoLic.UltCompra.MARCA;
			UltCompra.PRECIO=data.OfertasProductoLic.UltCompra.PRECIO;
			UltCompra.CANTIDAD=data.OfertasProductoLic.UltCompra.CANTIDAD;
			arrProductos[Pos].UltCompra=UltCompra;

			var CompraMedia=[];
			CompraMedia.NUMERO_PEDIDOS=data.OfertasProductoLic.CompraMedia.NUMERO_PEDIDOS;
			CompraMedia.CANTIDAD_TOTAL=data.OfertasProductoLic.CompraMedia.CANTIDAD_TOTAL;
			CompraMedia.PRECIO_MIN=data.OfertasProductoLic.CompraMedia.PRECIO_MIN;
			CompraMedia.PRECIO_MAX=data.OfertasProductoLic.CompraMedia.PRECIO_MAX;
			CompraMedia.PRECIO_MEDIO=data.OfertasProductoLic.CompraMedia.PRECIO_MEDIO;
			arrProductos[Pos].CompraMedia=CompraMedia;

			arrProductos[Pos].curvaABC=data.OfertasProductoLic.curvaABC;

			if(data.OfertasProductoLic.posicion && data.OfertasProductoLic.posicion!= ''){
			
				//solodebug	debug('JSON OK. CargaOfertas. Pos:'+Pos+' data:'+objeto);

				//solodebug	debug('JSON OK. CargaOfertas. Pos:'+Pos+'. Num.Ofertas:'+data.OfertasProductoLic.ofertas.length);
				
				Ofertas = new Array();
				var adjudicadas=0,MejorPrecio='', Ahorro='', AhorroSel='N' ;
				
				for (var i=0; i<data.OfertasProductoLic.ofertas.length; ++i)
				{
					Oferta=[];
				
					Oferta["Contador"]=data.OfertasProductoLic.ofertas[i].contador;
					Oferta["ID"]=data.OfertasProductoLic.ofertas[i].LIC_OFE_ID;
					Oferta["IDPROVEEDORLIC"]=data.OfertasProductoLic.ofertas[i].LIC_OFE_IDPROVEEDORLIC;
					Oferta["IDPROVEEDOR"]=data.OfertasProductoLic.ofertas[i].IDPROVEEDOR;
					Oferta["PROVEEDOR"]=data.OfertasProductoLic.ofertas[i].PROVEEDOR;
					Oferta["PROV_IDESTADO"]=data.OfertasProductoLic.ofertas[i].LIC_PROV_IDESTADO;
					Oferta["EMP_NIVELDOCUMENTACION"]=data.OfertasProductoLic.ofertas[i].EMP_NIVELDOCUMENTACION;
					Oferta["PROV_PEDIDOMINIMO"]=data.OfertasProductoLic.ofertas[i].LIC_PROV_PEDIDOMINIMO;
					Oferta["PROV_PLAZOENTREGA"]=data.OfertasProductoLic.ofertas[i].LIC_PROV_PLAZOENTREGA;
					Oferta["PROV_CONSUMOADJUDICADO"]=data.OfertasProductoLic.ofertas[i].LIC_PROV_CONSUMOADJUDICADO;
					Oferta["REFERENCIA"]=data.OfertasProductoLic.ofertas[i].LIC_OFE_REFERENCIA;
					Oferta["NOMBRE"]=data.OfertasProductoLic.ofertas[i].LIC_OFE_NOMBRE;
					Oferta["MARCA"]=data.OfertasProductoLic.ofertas[i].LIC_OFE_MARCA;
					Oferta["FECHAALTA"]=data.OfertasProductoLic.ofertas[i].LIC_OFE_FECHAALTA;
					Oferta["FECHAMODIFICACION"]=data.OfertasProductoLic.ofertas[i].LIC_OFE_FECHAMODIFICACION;
					Oferta["UNIDADESPORLOTE"]=data.OfertasProductoLic.ofertas[i].LIC_OFE_UNIDADESPORLOTE;
					Oferta["CANTIDAD"]=data.OfertasProductoLic.ofertas[i].LIC_OFE_CANTIDAD;
					Oferta["PRECIO"]=data.OfertasProductoLic.ofertas[i].LIC_OFE_PRECIO;				//	Precio como texto
					Oferta["TIPOIVA"]=data.OfertasProductoLic.ofertas[i].LIC_OFE_TIPOIVA;
					Oferta["CONSUMO"]=data.OfertasProductoLic.ofertas[i].LIC_OFE_CONSUMO;
					Oferta["CONSUMOIVA"]=data.OfertasProductoLic.ofertas[i].LIC_OFE_CONSUMOIVA;
					Oferta["IDESTADOEVALUACION"]=data.OfertasProductoLic.ofertas[i].LIC_OFE_IDESTADOEVALUACION;
					Oferta["ESTADOEVALUACION"]=data.OfertasProductoLic.ofertas[i].ESTADOEVALUACION;
					Oferta["AHORRO"]=data.OfertasProductoLic.ofertas[i].LIC_OFE_AHORRO;
					Oferta["OfertaAdjud"]=data.OfertasProductoLic.ofertas[i].LIC_OFE_ADJUDICADA;
					Oferta["ANOTACIONES"]=data.OfertasProductoLic.ofertas[i].LIC_OFE_ANOTACIONES;
					Oferta["INFOAMPLIADA"]=data.OfertasProductoLic.ofertas[i].LIC_OFE_INFOAMPLIADA;
					Oferta["IDMOTIVOCAMBIO"]=data.OfertasProductoLic.ofertas[i].LIC_OFE_IDMOTIVOCAMBIO;
					Oferta["MOTIVOCAMBIO"]=data.OfertasProductoLic.ofertas[i].LIC_OFE_MOTIVOCAMBIO;
					Oferta["CANTIDADADJUDICADA"]=data.OfertasProductoLic.ofertas[i].LIC_OFE_CANTIDADADJUDICADA;
					Oferta["PRECIOIVA"]=data.OfertasProductoLic.ofertas[i].LIC_OFE_PRECIOIVA;
					Oferta["PORPRODUCTOADJUDICADO"]=data.OfertasProductoLic.ofertas[i].LIC_OFE_PORPRODUCTOADJUDICADO;			//	Ofertas automaticas desde producto adjudicado en Cat.Priv.
					Oferta["PrecioColor"]=data.OfertasProductoLic.ofertas[i].COLOR;
					Oferta["MARCA_ACEPTABLE"]=data.OfertasProductoLic.ofertas[i].MARCA_ACEPTABLE;
					Oferta["NO_CUMPLE_PEDIDO_MINIMO"]=data.OfertasProductoLic.ofertas[i].NO_CUMPLE_PEDIDO_MINIMO;
					Oferta["MUY_SOSPECHOSO"]=data.OfertasProductoLic.ofertas[i].MUY_SOSPECHOSO;
					Oferta["SOSPECHOSO"]=data.OfertasProductoLic.ofertas[i].SOSPECHOSO;
					Oferta["EMPAQUETAMIENTO_SOSPECHOSO"]=data.OfertasProductoLic.ofertas[i].EMPAQUETAMIENTO_SOSPECHOSO;
					Oferta["IGUAL"]=data.OfertasProductoLic.ofertas[i].IGUAL;
					Oferta["SUPERIOR"]=data.OfertasProductoLic.ofertas[i].SUPERIOR;
					Oferta["MO_ID"]=data.OfertasProductoLic.ofertas[i].MO_ID;
					Oferta["MO_IDCENTROCLIENTE"]=data.OfertasProductoLic.ofertas[i].MO_IDCENTROCLIENTE;
					Oferta["MO_STATUS"]=data.OfertasProductoLic.ofertas[i].MO_STATUS;
					Oferta["CODPEDIDO"]=data.OfertasProductoLic.ofertas[i].CODPEDIDO;
					Oferta["LMO_ID"]=data.OfertasProductoLic.ofertas[i].LMO_ID;
					Oferta["INCLUIDO_EN_PEDIDO"]=data.OfertasProductoLic.ofertas[i].INCLUIDO_EN_PEDIDO;

					//2may22 var Precio=parseFloat(Oferta["PRECIO"].replace('PUNTO','').replace(',','.'));
					var Precio=desformateaDivisa(Oferta["PRECIO"]);
					Oferta["PRECIO_FLOAT"]=Precio;			//	Precio como float, sera util para calculo de totales

					//solodebug	debug('CargaOfertas:'+Pos+'. Oferta:'+data.OfertasProductoLic.ofertas[i].contador+' Prov:'+data.OfertasProductoLic.ofertas[i].PROVEEDOR+' Ref:'+data.OfertasProductoLic.ofertas[i].LIC_OFE_REFERENCIA+' Precio:'+data.OfertasProductoLic.ofertas[i].LIC_OFE_PRECIO);

					//	5jul22 Buscamos la columna del proveedor
					Oferta["ColProveedor"]=BuscaColumna(data.OfertasProductoLic.ofertas[i].LIC_OFE_IDPROVEEDORLIC);
					if(Oferta["ColProveedor"]>=0) Oferta["ColMatriz"]=arrConsumoProvs[Oferta["ColProveedor"]].ColMatriz;
					
					//	PENDIENTE! Ficha tecnica, documento
					Oferta["DOC_ID"]=data.OfertasProductoLic.ofertas[i].DOC_ID;
					Oferta["DOC_URL"]=data.OfertasProductoLic.ofertas[i].DOC_URL;
					Oferta["FT_ID"]=data.OfertasProductoLic.ofertas[i].FT_ID;
					Oferta["FT_URL"]=data.OfertasProductoLic.ofertas[i].FT_URL;
					Oferta["RS_ID"]=data.OfertasProductoLic.ofertas[i].RS_ID;
					Oferta["RS_URL"]=data.OfertasProductoLic.ofertas[i].RS_URL;
					Oferta["CE_ID"]=data.OfertasProductoLic.ofertas[i].CE_ID;
					Oferta["CE_URL"]=data.OfertasProductoLic.ofertas[i].CE_URL;

						
					//solodebug debug('CargaOfertas:'+Pos+'. Oferta:'+data.OfertasProductoLic.ofertas[i].contador+' FT_ID:'+data.OfertasProductoLic.ofertas[i].FT_ID+' FT_URL:'+data.OfertasProductoLic.ofertas[i].FT_URL
					//solodebug 			+' RS_ID:'+data.OfertasProductoLic.ofertas[i].RS_ID+' RS_URL:'+data.OfertasProductoLic.ofertas[i].RS_URL);

					Ofertas.push(Oferta);
					
					var AhorroOferta=desformateaDivisa(data.OfertasProductoLic.ofertas[i].LIC_OFE_AHORRO);
					
					//	Contador de adjudicadas
					if (data.OfertasProductoLic.ofertas[i].LIC_OFE_ADJUDICADA=='S')
					{
						++adjudicadas;
						if ((AhorroSel=='N')||(AhorroOferta>AhorroSel))
						{
							AhorroSel='S';
							Ahorro=AhorroOferta;
						}
					}
					else if ((Ahorro=='')||((AhorroSel=='N')&&(AhorroOferta>Ahorro)))
					{
						Ahorro=AhorroOferta;
					}
					
					//	Control del mejor precio
					if ((MejorPrecio=='')||(MejorPrecio>Precio)) MejorPrecio=Precio;
				}

				arrProductos[Pos].Ofertas=Ofertas;
				arrProductos[Pos].OfCargadas='S';
				arrProductos[Pos].MejorPrecio=MejorPrecio;
				arrProductos[Pos].Seleccionadas=adjudicadas;
				arrProductos[Pos].Ahorro=Ahorro;
				
				//	10jul22 Prep'aramos una copia de las ofertas para identificar cambios
				arrProductos[Pos].OfertasBack=copiaArray(arrProductos[Pos].Ofertas);	

				/*var color=(arrProductos[Pos].Seleccionadas>0)?'verde':'rojo';
				jQuery("#pOfertas_"+Pos).html(strOfertas+'<br/>'+arrProductos[Pos].Seleccionadas+'/'+(arrProductos[Pos].Ofertas.length+1)).addClass("verde");	
				
				var color=(arrProductos[Pos].Ahorro>0)?'verde':((arrProductos[Pos].Ahorro==0)?'naranja':'rojo');
				jQuery("#pAhorro_"+Pos).html(strAhorro+'<br/>'+arrProductos[Pos].Ahorro+'%').addClass(color);*/


				//	Cambia el fondo del color del producto que se ha cargado
				jQuery("#spProd_"+Pos).removeClass('rojo');		//	16jun22 dejamos fondo blanco .addClass('fondoAzul');
				
				
				//	Informa del numero de ofertas
				ActualizaOfertas(Pos);
				
				if ((IDProdLicActivo!='')&&(arrProductos[Pos].IDProdLic==IDProdLicActivo))
					AbrirProducto(Pos)
				
				
				CargaOfertas(++Pos);
				
				//	Actualiza los datos de carga
				jQuery('#spCargaProductos').html(Pos+' / '+(arrProductos.length));
								
            }else{
				
				alert('Error:\n' + objeto);

			}
						
			return;	

		},
		error: function(xhr, errorString, exception) {
			alert("xhr.status="+xhr.status+" error="+errorString+" exception="+exception);
		}
	});

}

//	5jul22 Busca la columna DE LA MATRIZ DE OFERTAS correspondiente al proveedor
function BuscaColumna(IDProveedorLic)
{
	var Res=-1;
	for (var i=0; ((Res==-1)&&(i<arrConsumoProvs.length));++i)
	{
		if (arrConsumoProvs[i].IDProvLic==IDProveedorLic) Res=i;
	}
	
	//solodebug debug('BuscaColumna. IDProveedorLic:'+IDProveedorLic+' Res:'+Res);
	
	return Res;
}


//	3may22 Revisa todos los productos para comprobar si cumplen los filtros del buscador
function Buscar()
{
	var fTexto=StringToISO(jQuery('#FTEXTO').val().toUpperCase());
	var IDProv=jQuery('#IDPROVEEDOR').val();
	var Tipo=jQuery('#IDTIPOCONSULTA').val();

	//debug('Buscar. texto:'+fTexto+' IDProv:'+IDProv+' Tipo:'+Tipo);
	
	//var r = new RegExp(fTexto.replace(' ',), "i");
	
	//	Bucle de productos
	for (var j=0; j<arrProductos.length;++j)
	{
		var cumple='N'
		var cadNorm=arrProductos[j].RefCliente+' '+arrProductos[j].RefEstandar+' '+arrProductos[j].RefCentro+' '+arrProductos[j].NombreNorm;
		
		//	COmprobar texto
		//	Falta revisar multiples cadenas
		if ((fTexto=='')||(BuscaEnCadena(cadNorm,fTexto)>=0))
			cumple='S';

		//	15jun22 Desplegable de tipo de busqueda
		if ((cumple=='S')&&(Tipo!='TODOS'))
		{
			if (((Tipo=='SIN_OFERTA')&&(arrProductos[j].Ofertas.length>0))
				||((Tipo=='NO_ADJUDICADOS')&&(arrProductos[j].Seleccionadas>0))
				||((Tipo=='SIN_AHORRO')&&(arrProductos[j].Ahorro>0)))
			{
				//solodebug debug('RevisaOfertas. Pos:'+j+' oferta['+i+'] no cumple por '+Tipo);
				cumple='N';
			}
		}


		//	Comprobar proveedores
		if ((cumple=='S')&&(IDProv!=''))
		{
			//	Bucle de ofertas para comprobar proveedor
			var cumple='N';
			for (var i=0;(cumple=='N')&&(i<arrProductos[j].Ofertas.length);++i)
			{

				if (arrProductos[j].Ofertas[i].IDPROVEEDOR==IDProv)
				{
					cumple='S';
					//solodebug debug('RevisaOfertas. Pos:'+j+' oferta['+i+'] incluye prov:'+arrProductos[j].Ofertas[i].IDPROVEEDOR);
				}
			}
		}
	
		//solodebug if (cumple=='S') debug('RevisaOfertas. Pos:'+j+' oferta['+i+'] cumple filtro:'+cumple);

		arrProductos[j].CumpleFiltro=cumple;
	}

	//	Al acabar de filtrar, presenta la lista de productos actualizada
	ListaProductos();
}


//	Cierra el producto actual y abre el siguiente
function AbrirSiguiente(Pos)
{
	debug('AbrirSiguiente.Pos:'+Pos);
	
	CierraProducto(Pos);
	if (arrProductos.length>Pos+1)
		AbrirProducto(Pos+1);
}



//	Abre la ficha correspondiente a un producto
function AbrirProducto(Pos)
{
	debug('AbrirProducto.Pos:'+Pos);

	//	Si no se han cargado las ofertas, no hace nada
	if (arrProductos[Pos].OfCargadas=='N')
		return;

	//COmprueba si han quedado cambios pendientes de guardar
	if ((gl_ProductoAbierto!=-1)&&(arrProductos[Pos].Cambios=='S'))
	{
		alert(alrt_CambiosPendientes);
		return;
	}	

	//	Cierra el resto de productos al abrir uno
	if (gl_ProductoAbierto != '-1')
		CierraProductos();
		
	//	Informa la variable global que apunta al producto abierto		
	gl_ProductoAbierto=Pos;
	
	//	Prepara la copia con la situacion actual de las selecciones
	arrProductos[Pos].OfertasBack=copiaArray(arrProductos[Pos].Ofertas);

	//
	//	INICIO Cadenas para montar la tabla de ofertas
	//	
		
	//	Cabecera de la tabla de ofertas				
	var headTablaOfertas='<div class="tabela tabela_redonda"><div class="divLeft h50px">&nbsp;</div><table cellspacing="6px" cellpadding="6px"><thead class="cabecalho_tabela"><tr>'
					+'<th class="w1px"></th>'
					+'<th class="w50px">'+strFecOferta+'</th>'
					+'<th class="textLeft">'+strProveedor+'</th>'			//	permitimos que esta columna se ensanche si hay espacio
					+'<th class="w80px">'+strPedMin+'</th>'
					+'<th class="w60px">'+strPlEntrega+'</th>'
					+'<th class="w50px">'+strConsumo+'</th>';

		if (incluirDocs=='S')
			headTablaOfertas+='<th class="w100px">'+strVerDoc+'</th>';

		headTablaOfertas+='<th class="w1px">&nbsp;</th>'		// columna icono anyadir campos avanzados
					
			
		//	Para Brasil no presentamos la referencia ni la descripcion de producto		
		if (IDPais != '55')
		{			
			headTablaOfertas+='<th class="w50px">'+strRef+'</th>'
					+'<th>'+strProducto+'</th>';
		}			
					
		headTablaOfertas+='<th class="textLeft">'+strMarca+'</th>';			//	permitimos que esta columna se ensanche si hay espacio

		/*	21abr22 Las marcas se incluiran desde la ficha completa de producto de la licitacion
		if (esCdC=='S')
			headTablaOfertas+='<th class="w20px">&nbsp;<a href="javascript:IncluirMarcas();">'+strIncluir+'</a></th>';*/

		headTablaOfertas+='<th class="w50px">'+strUdesLote+'</th>'
						+'<th class="w1px">&nbsp;</th>';
		
		
		if ((isLicPorProducto=='S')&&(esAutor=='S')&&((EstadoLic == 'CURS')||(EstadoLic == 'INF')))
			headTablaOfertas+='<th class="w100px" colspan="2">'+strSelecc+'</th>'
		else
			headTablaOfertas+='<th class="w100px">'+strSelecc+'</th>'

		headTablaOfertas+='<th class="w50px">'+strPrecio+'</th>'
						+'<th class="w1px">&nbsp;</th>'
						+'<th class="w50px">'+strConsumo2l+'</th>';

		if (IDPais != '55')
			headTablaOfertas+='<th class="w20px">'+strTipoIva+'</th>';

		//20abr22 Quitamos el estado de evaluacion
		//if ((esCdC=='S') && (IDPais != '55'))
		//	headTablaOfertas+='<th class="w50px">'+strEstaEval+'</th><th class="w30px">&nbsp;</th>';

		headTablaOfertas+='<th class="w1px">&nbsp;</th><th class="w1px">&nbsp;</th><th class="w1px">&nbsp;</th>'
					+'</tr></thead><tbody class="corpo_tabela">';





	var lineaDatosProducto=//16jun22'<div class="linha_separacao"></div>'
					//16jun22 +'<div class="div_coluna_tabela_cotacao">'
					'<div class="div_coluna_1_cotacao">'
					+'<div class="div_coluna_1_cotacaoprodutos_titulo">'
					+'<div class="qtd_produto_cotacao">'
					+'<p class="quantidade_cotacao"><a href="javascript:CierraProducto('+Pos+');">[POSICION]/[NUMPRODUCTOS]&nbsp;([REF_CLIENTE])</a>'
					+'<span class="floatRight marginRight50"><a class="btnNormal" href="javascript:chFichaProductoLicitacion([LIC_ID], [LIC_PROD_ID],\'LICV2\');">'+strAvanzado+'</a>'
					+((isLicAgregada=='S')?'&nbsp;<a class="btnNormal" href="javascript:tablaCentros('+Pos+');">'+strCentros+'</a>':'')
					+'&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></p>'
					+'</div>'
					+'<div class="informacao_produto_cotacao marginTop20">'
						+'<p>[DESC_CLIENTE]</p>'
					+'</div>'
					+'</div>'
					+'<div class="linha_separacao_eixo_x"></div>'
					+'<div class="div_coluna_1_cotacao_detalhes">'
						+'<div class="marca_cotacao_detalhes">[DETALLES]'
						+'</div>'
						+'<div class="historico_cotacao_detalhes">'
						+'<p><label>'+strPrecioHist+':&nbsp;</label>[PRECIO_REF]</p>'
						+'<p><label>'+strUdBasica+':&nbsp;</label>[UD_BASICA]</p>'
						+'<p><label>'+strCantidad+':&nbsp;</label>[CANT_PRODUCTO]</p>'
						+'[GUARDAR_PRODUCTO]'
						+'</div>'
					+'</div>'
					+'</div>'
					+'<div class="linha_separacao_eixo_y"></div>'
					+'<div class="div_coluna_2_cotacao">'
						+'<div class="titulo_cotacao_detalhes">'
							+'<p><a href="javascript:FichaPedido([MO_ID]);">'+strUltPedido+':</a></p>'
						+'</div>[ULTIMOPEDIDO]'
					+'</div>'
					+'<div class="linha_separacao_cotacao_y"></div>'
					+'<div class="div_coluna_3_cotacao">'
						+'<div class="titulo_cotacao_detalhes">'
							+'<p>'+strUlt3meses+':</p>'
						+'</div>[COMPRA3MESES]'
					+'</div>'	
					+'</div>';



	//	Linea de la tabla de ofertas
	var linTablaOfertas='<tr id="OFE_[LIC_OFE_ID]" class="filaOferta conhover">'
					//	31ago16	Incluimos un contador, y un fondo de color seg�n la valoraci�n de la documentaci�n
					+'<td class="[COLOR_DOC]">[CONT]</td>'
					//	Fecha Oferta
					+'<td><a href="http://www.newco.dev.br/Gestion/Comercial/ImprimirOferta2022.xsql?LIC_ID=[/FichaProductoLic/LIC_ID]&amp;LIC_PROV_ID=[LIC_OFE_IDPROVEEDORLIC]">[FECHAALTA]</a></td>'
					//	Nombre Proveedor + indicacion pedido minimo
					+'<td class="textLeft">[CUMPLE_PED_MIN]<a href="javascript:FichaEmpresa([IDPROVEEDOR],\'DOCUMENTOS\');">[PROVEEDOR]</a>'
					+'<input type="hidden" name="Proveedor_[LIC_OFE_ID]" id="Proveedor_[LIC_OFE_ID]" value="[PROVEEDOR]"/>'			//	REVISAR, no parece necesario, los calculos s epueden hacer con el array JS
					+'</td>'
					//	Columnas de pedido minimo y consumo adjudicado
					+'<td><input type="hidden" name="PEDMINIMO_[LIC_OFE_ID]" id="PEDMINIMO_[LIC_OFE_ID]" value="[PROV_PEDIDOMINIMO]"/>[PROV_PEDIDOMINIMO]</td>'
					+'<td>[PROV_PLAZOENTREGA]</td>'
					+'<td>[PROV_CONSUMOADJUDICADO]</td>'
					//31jul22	+'[COLUMNA_DOCUMENTOS]'
					//	Ref.Proveedor
					+'<input type="hidden" name="IDProveedorLic_[LIC_OFE_ID]" id="IDProveedorLic_[LIC_OFE_ID]" value="[LIC_OFE_IDPROVEEDORLIC]"/>'
					+'<input type="hidden" name="Cant_[LIC_OFE_ID]" id="Cant_[LIC_OFE_ID]" value="[LIC_OFE_CANTIDAD]"/>'
					+'<input type="hidden" name="TIVA_[LIC_OFE_ID]" id="TIVA_[LIC_OFE_ID]" value="[LIC_OFE_TIPOIVA]"/>'
					+'<input type="hidden" name="FT_[LIC_OFE_ID]" id="FT_[LIC_OFE_ID]" value="[FICHA_TECNICA]"/>'
					// Iconos FT y campos avanzados 
					+'<td style="display:table-cell;">[INFO_AMPLIADA][DOCUMENTO]</td>'
					// Referencia proveedor
					+'[REF_PROVEEDOR]'
					// Nombre producto
					+'[PRODUCTO]'
					//	Marca
					+'<td class="textLeft">[MARCA]</td>'			//21abr22 [CHECK_MARCA]
					+'<td>[UNIDADESPORLOTE]<input type="hidden" name="UdsLote_[LIC_OFE_ID]" id="UdsLote_[LIC_OFE_ID]" value="[UNIDADESPORLOTE]"/>[EMPAQUETAMIENTO_SOSPECHOSO]</td>'
					//	checkbox o marca adjudicacion
					+'<td>[ADJUDICACION]</td>'
					//	precio
					+'<td id="PrOf_[LIC_OFE_ID]" class="PrecioOferta"><input type="hidden" name="PrecioOriginal_[LIC_OFE_ID]" id="PrecioOriginal_[LIC_OFE_ID]" value="[PRECIO]"/>'
					+'<span class="precio [COLOR]">[PRECIO]</span></td>'
					+'<td>[PRECIO_SOSPECHOSO]</td>'
					//	Guardamos el consumo en un parrafo con id y nombre  para poderlo recalcular
					+'<td><input type="hidden" name="CONSUMO_[LIC_OFE_ID]" id="CONSUMO_[LIC_OFE_ID]" value="[CONSUMO]"/><p name="Consumo_[LIC_OFE_ID]" id="Consumo_[LIC_OFE_ID]">[CONSUMO]</p></td>'
					+'[TIPOIVA]'
					//	Sem�foro asociado al pedido	-->
					+'<td>[SEMAFORO_PEDIDO]</td>'
					//	Bot�n de pedido (cuando corresponda)
					+'<td id="tdPedido_[LIC_OFE_ID]">[BOTON_PEDIDO]</td>'
					+'<td>[DESCARTAR_OFERTA]</td>'
					+'</tr>';



	//	Pie de la tabla de ofertas
	var footTablaOfertas='<tr id="lMotivo_[POS]" style="display:none"><td class="color_status">&nbsp;</td><td colspan="22">[IDMOTIVO_SEL]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'
						+strExpli+':&nbsp;'
						+'<input type="text" class="campopesquisa w500px" max-size="1000" name="MOTIVOSELECCION_[POS]" id="MOTIVOSELECCION_[POS]" value="[MOTIVO_SEL]" onblur="javascript:GuardarProductoSel([POS],\'\');"/>'
						+'</td></tr></tbody><tfoot class="rodape_tabela"><tr><td colspan="22">&nbsp;</td></tr></tfoot></table></div>';

	//	Container para centro (solo en caso de lic. Agregada)
	var containerCentros='<div class="overlay-container w100" id="divContCentros" >'
						+'<div class="window-container zoomout" id="divWindowContCentros">'
						+'</div>'
						+'</div>';


	//
	//	FINAL Cadenas para montar la tabla de ofertas
	//	
		
		
	var ObjName='divOfe_'+Pos;

	if (jQuery('#'+ObjName).is(':visible')) {
    	jQuery('#'+ObjName).hide();
	} 
	else 
	{

		var linDatosProd=lineaDatosProducto;

		linDatosProd=linDatosProd.replace('[POSICION]',arrProductos[Pos].Linea);
		linDatosProd=linDatosProd.replace('[NUMPRODUCTOS]',totalProductos);
		linDatosProd=linDatosProd.replace('[MO_ID]',arrProductos[Pos].UltCompra.MO_ID);		
			
		if (arrProductos[Pos].RefCentro!='')
			linDatosProd=linDatosProd.replace('[REF_CLIENTE]',arrProductos[Pos].RefCentro);
		if (arrProductos[Pos].RefCliente!='')
			linDatosProd=linDatosProd.replace('[REF_CLIENTE]',arrProductos[Pos].RefCliente);
		else
			linDatosProd=linDatosProd.replace('[REF_CLIENTE]',arrProductos[Pos].RefEstandar);

		linDatosProd=linDatosProd.replace('[DESC_CLIENTE]',arrProductos[Pos].Nombre);

		var detalles='';
		if (arrProductos[Pos].Marcas!='')
			detalles+='<p><label>'+strMarcas+':&nbsp;</label>'+arrProductos[Pos].Marcas+'</p>';

		detalles+='<p>';
		if (arrProductos[Pos].PrincActivo!='')
			detalles+='<label>'+strPrincActivo+':&nbsp;</label>'+arrProductos[Pos].PrincActivo+'&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;';
		
		if (arrProductos[Pos].ConsumoHist!='')
			detalles+='<label>'+strConsSinIva+':&nbsp;</label>'+arrProductos[Pos].ConsumoHist;
		
		if (arrProductos[Pos].curvaABC!='')
			detalles+='&nbsp;&nbsp;&nbsp;&nbsp;<p><label>'+strCurvaABC+':&nbsp;</label><strong>'+arrProductos[Pos].curvaABC+'</strong></p>';
		
		detalles+='</p>';
		
		linDatosProd=linDatosProd.replace('[DETALLES]',detalles);
		
		if ((esAutor=='S')&&(editarCant=='S'))
		{
			linDatosProd=linDatosProd.replace('[PRECIO_REF]','<input class="campopesquisa w100px"  type="text" name="PrecioRef" id="PrecioRef" value="'+arrProductos[Pos].PrecioHist+'"/>');		
			linDatosProd=linDatosProd.replace('[UD_BASICA]','<input class="campopesquisa w100px" type="text" name="UdBasica" id="UdBasica" value="'+arrProductos[Pos].UdBasica+'"/>');		
		}
		else
		{
			linDatosProd=linDatosProd.replace('[PRECIO_REF]','<strong>'+arrProductos[Pos].PrecioHist+'</strong>');		
			linDatosProd=linDatosProd.replace('[UD_BASICA]','<strong>'+arrProductos[Pos].UdBasica+'</strong>');		
		}

		
		if ((esAutor=='S')&&(editarCant=='S')&&(isLicAgregada=='N'))
		{
			linDatosProd=linDatosProd.replace('[CANT_PRODUCTO]','<input class="campopesquisa w100px" type="text" size="5" name="Cantidad" id="Cantidad" value="'+arrProductos[Pos].Cantidad+'"/>');		
		}
		else
		{
			linDatosProd=linDatosProd.replace('[CANT_PRODUCTO]','<strong>'+arrProductos[Pos].Cantidad+'</strong><input type="hidden" name="Cantidad" id="Cantidad" value="'+arrProductos[Pos].Cantidad+'"/>');		
		}
		
		if ((esAutor=='S')&&(editarCant=='S')&&((EstadoLic=='EST')||(EstadoLic=='COMP')||(EstadoLic=='CURS')||(EstadoLic=='INF')))
		{
			linDatosProd=linDatosProd.replace('[GUARDAR_PRODUCTO]','<p><a class="btnDestacado" id="botonGuardarDatosProd" href="javascript:GuardarDatosProducto();">'+strGuardar+'</a></p>');
		}
		else
			linDatosProd=linDatosProd.replace('[GUARDAR_PRODUCTO]','');
			
		var UltCompra;
		if (arrProductos[Pos].UltCompra.MO_ID!='')
		{
				UltCompra='<div class="historico_complementar_cotacao">'
					+'<p><strong>'+strFecha+':</strong>&nbsp;'+arrProductos[Pos].UltCompra.FECHA+'</p>' 
					+'<p><strong>'+strProveedor+':</strong>&nbsp;'+arrProductos[Pos].UltCompra.PROVEEDOR+'</p>'
					+'<p><strong>'+strPrecio+':</strong>&nbsp;'+arrProductos[Pos].UltCompra.PRECIO+'</p>'
					+'<p><strong>'+strCantidad+':</strong>&nbsp;'+arrProductos[Pos].UltCompra.CANTIDAD+'</p>'
					+'<p><strong>'+strMarca+':</strong>&nbsp;'+arrProductos[Pos].UltCompra.MARCA+'</p>' 
					+'</div>';
		}
		else
		{
			UltCompra='<div class="historico_complementar_cotacao">'+strSinPedidosTri+'</div>';					
		}
		linDatosProd=linDatosProd.replace('[ULTIMOPEDIDO]',UltCompra);




		var compraMedia;
		if (arrProductos[Pos].CompraMedia.NUMERO_PEDIDOS!='0')
		{
				compraMedia='<div class="historico_complementar_cotacao">'
					+'<p><strong>'+strNumPedidos+':</strong>&nbsp;'+arrProductos[Pos].CompraMedia.NUMERO_PEDIDOS+'</p>' 
					+'<p><strong>'+strCantidad+':</strong>&nbsp;'+arrProductos[Pos].CompraMedia.CANTIDAD_TOTAL+'</p>'
					+'<p><strong>'+strPrecio+'&nbsp'+strMin+':</strong>&nbsp;'+arrProductos[Pos].CompraMedia.PRECIO_MIN+'</p>' 
					+'<p><strong>'+strPrecio+'&nbsp;'+strMedio+':</strong>&nbsp;'+arrProductos[Pos].CompraMedia.PRECIO_MEDIO+'</p>'
					+'<p><strong>'+strPrecio+'&nbsp;'+strMax+':</strong>&nbsp;'+arrProductos[Pos].CompraMedia.PRECIO_MAX+'</p>'
					+'</div>';
		}
		else
		{
			compraMedia='<div class="historico_complementar_cotacao">'+strSinPedidosTri+'</div>';					
		}
		linDatosProd=linDatosProd.replace('[COMPRA3MESES]',compraMedia);
			
		linDatosProd=linDatosProd.replaceAll('[LIC_ID]',IDLicitacion);
		linDatosProd=linDatosProd.replaceAll('[LIC_PROD_ID]',arrProductos[Pos].IDProdLic)

		//	Incluimos los datos del producto
		var html=linDatosProd;

		//	Cabecera de la tabla
		html+=headTablaOfertas;
		
		var UltSel=-1;
		for (var i=0; i<arrProductos[Pos].Ofertas.length;++i)
		{
		
			//	Marca la ultima seleccionada para mostrar motivo
			if (arrProductos[Pos].Ofertas[i].OfertaAdjud=='S') UltSel=i;
			
			var Linea=linTablaOfertas;	

			var fondo=(arrProductos[Pos].Ofertas[i].EMP_NIVELDOCUMENTACION=='R')?'fondoRojo':(arrProductos[Pos].Ofertas[i].EMP_NIVELDOCUMENTACION=='A')?'fondoNaranja':'fondoVerde';

			Linea=Linea.replace('[COLOR_DOC]',fondo);
			Linea=Linea.replace('[CONT]',arrProductos[Pos].Ofertas[i].Contador);
			Linea=Linea.replace('[LIC_OFE_IDPROVEEDORLIC]',arrProductos[Pos].Ofertas[i].IDPROVEEDORLIC);
			Linea=Linea.replace('[FECHAALTA]',(arrProductos[Pos].Ofertas[i].FECHAMODIFICACION!='')?arrProductos[Pos].Ofertas[i].FECHAMODIFICACION:arrProductos[Pos].Ofertas[i].FECHAALTA);

			if (arrProductos[Pos].Ofertas[i].NO_CUMPLE_PEDIDO_MINIMO=='N')
				Linea=Linea.replace('[CUMPLE_PED_MIN]','');
			else
				Linea=Linea.replace('[CUMPLE_PED_MIN]','<img src="http://www.newco.dev.br/images/urgente.gif"/>');
				
			Linea=Linea.replaceAll('[IDPROVEEDOR]',arrProductos[Pos].Ofertas[i].IDPROVEEDOR);
			Linea=Linea.replaceAll('[PROVEEDOR]',arrProductos[Pos].Ofertas[i].PROVEEDOR);
			Linea=Linea.replaceAll('[PROV_PEDIDOMINIMO]',arrProductos[Pos].Ofertas[i].PROV_PEDIDOMINIMO);
			Linea=Linea.replaceAll('[PROV_PLAZOENTREGA]',arrProductos[Pos].Ofertas[i].PROV_PLAZOENTREGA);
			Linea=Linea.replaceAll('[CONSUMO]',arrProductos[Pos].Ofertas[i].CONSUMO);
			//	2may22	Linea=Linea.replaceAll('[PROV_CONSUMOADJUDICADO]',arrProductos[Pos].Ofertas[i].PROV_CONSUMOADJUDICADO);

			//	Datos actualizados del consumo, recalculados al guardar cambios en selecciones
			var PosProveedor=BuscaProveedor(arrProductos[Pos].Ofertas[i].IDPROVEEDOR);		
			Linea=Linea.replaceAll('[PROV_CONSUMOADJUDICADO]',arrConsumoProvs[PosProveedor].ConsumoAdj);				
							
			if (IDPais != '55')
			{
				Linea=Linea.replace('[REF_PROVEEDOR]','<td class="datosLeft"><strong>'+arrProductos[Pos].Ofertas[i].REFERENCIA+'</strong></td>');
				Linea=Linea.replace('[PRODUCTO]','<td class="datosLeft"><strong>'+arrProductos[Pos].Ofertas[i].NOMBRE+'</strong></td>');
			}
			else
			{
				Linea=Linea.replace('[REF_PROVEEDOR]','')
				Linea=Linea.replace('[PRODUCTO]','')
			}
				
			//	20abr22 Quitamos la opcion de informar los campos avanzados al autor
			
			//Info Ampliada
			if (arrProductos[Pos].Ofertas[i].INFOAMPLIADA!='')
			{
				var infAmp=	'<a class="tooltip" href="#"><img class="static" src="http://www.newco.dev.br/images/infoAmpliadaIcon.gif"/><span class="classic spanEIS">'
								+strInfoAmp+'<br /><br />'+arrProductos[Pos].Ofertas[i].INFOAMPLIADA+'</span></a>';

			
				Linea=Linea.replace('[INFO_AMPLIADA]',infAmp);
			}
			else
				Linea=Linea.replace('[INFO_AMPLIADA]','');
			
			//	Documento
			/*	PENDIENTE!!!!!!!
			if (arrProductos[Pos].Ofertas[i].IDDOCUMENTO!='')
			{
				var infAmp=	'<a class="tooltip" href="#"><img class="static" src="http://www.newco.dev.br/images/infoAmpliadaIcon.gif"/><span class="classic spanEIS">
								+strInfoAmp+'<br /><br />'+arrProductos[Pos].Ofertas[i].INFOAMPLIADA+'</span></a>'


				[DOCUMENTO]
					<xsl:if test="DOCUMENTO/ID">
						<a target="_blank" href="http://www.newco.dev.br/Documentos/[DOCUMENTO/URL]">
							<img class="static" src="http://www.newco.dev.br/images/clipIcon.gif">
								<xsl:attribute name="alt">[document($doc)/translation/texts/item[@name='documento']/node()]</xsl:attribute>
								<xsl:attribute name="title">[document($doc)/translation/texts/item[@name='documento']/node()]</xsl:attribute>
							</img>
						</a>
					</xsl:if>
			
				Linea=Linea.replace('[INFO_AMPLIADA]',infAmp);
			}
			else	*/

			//31jul22 Ficha tecnica, registro sanitario, certificado experiencia
			//if (incluirDocs=='S')
			//{
				var docs='';
				if (arrProductos[Pos].Ofertas[i].DOC_ID!='')
				{
					docs+='<a href="http://www.newco.dev.br/Documentos/'+arrProductos[Pos].Ofertas[i].DOC_URL+'">DOC</a>&nbsp;'
				}
				if (arrProductos[Pos].Ofertas[i].FT_ID!='')
				{
					docs+='<a href="http://www.newco.dev.br/Documentos/'+arrProductos[Pos].Ofertas[i].FT_URL+'">FT</a>&nbsp;'
				}
				if (arrProductos[Pos].Ofertas[i].RS_ID!='')
				{
					docs+='<a href="http://www.newco.dev.br/Documentos/'+arrProductos[Pos].Ofertas[i].RS_URL+'">RS</a>&nbsp;'
				}
				if (arrProductos[Pos].Ofertas[i].CE_ID!='')
				{
					docs+='<a href="http://www.newco.dev.br/Documentos/'+arrProductos[Pos].Ofertas[i].CE_URL+'">CE</a>&nbsp;'
				}
				if (docs=='')
					Linea=Linea.replace('[DOCUMENTO]','');
				else
					Linea=Linea.replace('[DOCUMENTO]','<span class="fuentePeq">'+docs+'</span>');
			//}
					
			//	Marca
			Linea=Linea.replaceAll('[MARCA]',arrProductos[Pos].Ofertas[i].MARCA);
			
			//			
			//	Check para incluir la marca en la lista de marcas aceptables
			//
				
			//	Unidades por lote
			Linea=Linea.replaceAll('[UNIDADESPORLOTE]',arrProductos[Pos].Ofertas[i].UNIDADESPORLOTE);

			//	Empaquetamiento sospechoso
			if (arrProductos[Pos].Ofertas[i].EMPAQUETAMIENTO_SOSPECHOSO=='S')
				Linea=Linea.replace('[EMPAQUETAMIENTO_SOSPECHOSO]','<span class="rojo2">&nbsp;?</span>');
			else
				Linea=Linea.replace('[EMPAQUETAMIENTO_SOSPECHOSO]','');


			
			//	Columna de adjudicacion, cambia mucho segun tipo de licitacion
			var colAdj;
			if (isLicMultiopcion=='S')
			{
				colAdj='<td><input type="hidden" id="CONT_[LIC_OFE_ID]" value="[CONTADOR]"/>'
						/*PENDIENTE RELLENAR LISTA DE OPCIONES!!!!!!
		            		<xsl:call-template name="desplegable">
								<xsl:with-param name="path" select="ORDEN/field]
								<xsl:with-param name="nombre">ORDEN_[LIC_OFE_ID]</xsl:with-param>
								<xsl:with-param name="id">ORDEN_[LIC_OFE_ID]</xsl:with-param>
								<xsl:with-param name="style">width:50px;</xsl:with-param>
								<xsl:with-param name="onChange">javascript:cambioOrden([LIC_OFE_ID]);</xsl:with-param>
							</xsl:call-template>*/
						+'</td>';
			}
			else
			{
				//	Licitacion por paquetes
				if (isLicPorProducto=='N')
				{
					//	Si esta adjudicada CHECK, si no, nada
					if ((arrProductos[Pos].Ofertas[i].OfertaAdjud=='S')&&(EstadoLic != 'CURS')&&(EstadoLic != 'INF'))
					{
						colAdj='<td><img src="http://www.newco.dev.br/images/check.gif">'
								+'<xsl:attribute name="alt">'+strOfertaAdj+'</xsl:attribute>'
								+'<xsl:attribute name="title">'+strOfertaAdj+'</xsl:attribute>'
								+'</img></td>';
					}
					else 
						colAdj='<td></td>';
				}
				//	Licitacion por producto
				//	Si no es autor, si esta adjudicada CHECK, si no, nada
				else if ((isLicPorProducto=='S')&&(esAutor=='N'))
				{
					if ((arrProductos[Pos].Ofertas[i].OfertaAdjud=='S')&&(EstadoLic != 'CURS')&&(EstadoLic != 'INF'))
					{
						colAdj='<td><img src="http://www.newco.dev.br/images/check.gif">'
								+'<xsl:attribute name="alt">'+strOfertaAdj+'</xsl:attribute>'
								+'<xsl:attribute name="title">'+strOfertaAdj+'</xsl:attribute>'
								+'</img></td>';

					}
					else 
						colAdj='<td></td>';
				}
				else
				{
					if ((EstadoLic == 'CURS')||(EstadoLic == 'INF'))
					{
						colAdj='<td class="w1px">'
								+'<input type="checkbox" name="ADJUD_[LIC_OFE_ID]" id="ADJUD_[LIC_OFE_ID]" class="muypeq" value="[LIC_OFE_ID]" [CHECKED] [DISABLED] onChange="javascript:SeleccionadaOferta([POS],[LIC_OFE_ID]);">';
								
						if (arrProductos[Pos].Ofertas[i].OfertaAdjud=='S')
							colAdj=colAdj.replace('[CHECKED]','checked="checked"');


						colAdj=colAdj.replace('[CHECKED]','');
						colAdj=colAdj.replace('[DISABLED]','');
							
						//	PENDIENTE COMPROBAR BLOQUEO
						/*		
								+'		<xsl:if test="LIC_OFE_ADJUDICADA = 'S'">
								+'			<xsl:attribute name="checked">checked</xsl:attribute>
										</xsl:if>
										<xsl:if test="/FichaProductoLic/PRODUCTOLICITACION/PRODUCTO_BLOQUEADO_POR_PEDIDOS and PROVEEDOR_BLOQUEADO_POR_PEDIDOS">
											<xsl:attribute name="checked">checked</xsl:attribute>
											<xsl:attribute name="disabled">disabled</xsl:attribute>
										</xsl:if>
									</input>*/

						colAdj+='</td><td class="w60px">'
								+'<input type="textbox" class="campopesquisa w60px" name="CANTADJUD_[LIC_OFE_ID]" id="CANTADJUD_[LIC_OFE_ID]" [DISABLED] [ESTILO] onChange="javascript:chCantidadAdjudicada([POS],[LIC_OFE_ID]);" value="[VALUE]"/>';
								
						if (arrProductos[Pos].Ofertas[i].OfertaAdjud=='S')
							colAdj=colAdj.replace('[VALUE]',arrProductos[Pos].Ofertas[i].CANTIDADADJUDICADA);
								

						//	PENDIENTE COMPROBAR BLOQUEO
						/*

									<xsl:when test="LIC_OFE_ADJUDICADA = 'S' and(/FichaProductoLic/PRODUCTOLICITACION/PRODUCTO_BLOQUEADO_POR_PEDIDOS or PROVEEDOR_BLOQUEADO_POR_PEDIDOS)">
										<xsl:attribute name="disabled">disabled</xsl:attribute>
									</xsl:when>
									<xsl:when test="LIC_OFE_ADJUDICADA = 'N' and(/FichaProductoLic/PRODUCTOLICITACION/PRODUCTO_BLOQUEADO_POR_PEDIDOS or PROVEEDOR_BLOQUEADO_POR_PEDIDOS)">
										<xsl:attribute name="style">display:none</xsl:attribute>
									</xsl:when>	
									</xsl:choose>
								</input>*/
								
						colAdj+='</td>';

						colAdj=colAdj.replace('[DISABLED]','');
						colAdj=colAdj.replace('[ESTILO]','');
						colAdj=colAdj.replace('[VALUE]','');
					}
					else
					{
						if (arrProductos[Pos].Ofertas[i].OfertaAdjud=='S')
						{
							colAdj='<td><img src="http://www.newco.dev.br/images/check.gif">'
									+'<xsl:attribute name="alt">'+strOfertaAdj+'</xsl:attribute>'
									+'<xsl:attribute name="title">'+strOfertaAdj+'</xsl:attribute>'
									+'</img></td>';
						}
						else
							colAdj='<td></td>';
					}
				}
			}
			Linea=Linea.replace('[ADJUDICACION]',colAdj);
			

			/*	PENDIENTE!!!!!!	
				[ADJUDICACION]
				
				//	checkbox o marca adjudicacion
					<xsl:choose>
					<xsl:when test="/FichaProductoLic/PRODUCTOLICITACION/LIC_MULTIOPCION = 'S'">
					<!--
					
					
						CUIDADO! LLEVAR LOS CAMBIOS AL BLOQUE "CON IVA"
					
					
					-->
						<td>
							<input type="hidden" id="CONT_[LIC_OFE_ID]" value="[CONTADOR]]
		            		<xsl:call-template name="desplegable">
								<xsl:with-param name="path" select="ORDEN/field]
								<xsl:with-param name="nombre">ORDEN_[LIC_OFE_ID]</xsl:with-param>
								<xsl:with-param name="id">ORDEN_[LIC_OFE_ID]</xsl:with-param>
								<xsl:with-param name="style">width:50px;</xsl:with-param>
								<xsl:with-param name="onChange">javascript:cambioOrden([LIC_OFE_ID]);</xsl:with-param>
							</xsl:call-template>
						</td>
					</xsl:when>
					
					<xsl:otherwise>
					
					
						<xsl:choose>
						<xsl:when test="/FichaProductoLic/PRODUCTOLICITACION/LIC_PORPRODUCTO = ''">
						<td>
							<xsl:if test="LIC_OFE_ADJUDICADA = 'S' and /FichaProductoLic/PRODUCTOLICITACION/LIC_IDEstadoLic != 'CURS' and /FichaProductoLic/PRODUCTOLICITACION/LIC_IDEstadoLic != 'INF'">
								<img src="http://www.newco.dev.br/images/check.gif">
									<xsl:attribute name="alt">[document($doc)/translation/texts/item[@name='oferta_adjudicada']/node()]</xsl:attribute>
									<xsl:attribute name="title">[document($doc)/translation/texts/item[@name='oferta_adjudicada']/node()]</xsl:attribute>
								</img>
							</xsl:if>
						</td>
                    	</xsl:when>
						<xsl:when test="/FichaProductoLic/PRODUCTOLICITACION/LIC_PORPRODUCTO = 'S' and not(/FichaProductoLic/PRODUCTOLICITACION/AUTOR)">
						<td>
							<xsl:if test="LIC_OFE_ADJUDICADA = 'S' and /FichaProductoLic/PRODUCTOLICITACION/LIC_IDEstadoLic != 'CURS' and /FichaProductoLic/PRODUCTOLICITACION/LIC_IDEstadoLic != 'INF'">
								<img src="http://www.newco.dev.br/images/check.gif">
									<xsl:attribute name="alt">[document($doc)/translation/texts/item[@name='oferta_adjudicada']/node()]</xsl:attribute>
									<xsl:attribute name="title">[document($doc)/translation/texts/item[@name='oferta_adjudicada']/node()]</xsl:attribute>
								</img>
							</xsl:if>
						</td>
						</xsl:when>
						<xsl:otherwise>
							<xsl:choose>
							<xsl:when test="/FichaProductoLic/PRODUCTOLICITACION/LIC_IDEstadoLic = 'CURS' or /FichaProductoLic/PRODUCTOLICITACION/LIC_IDEstadoLic = 'INF'">
								<td>
									<input type="checkbox" name="ADJUD_[LIC_OFE_ID]" id="ADJUD_[LIC_OFE_ID]" class="muypeq" value="[LIC_OFE_ID]" onChange="javascript:SeleccionadaOferta([LIC_OFE_ID]);">
										<xsl:if test="LIC_OFE_ADJUDICADA = 'S'">
											<xsl:attribute name="checked">checked</xsl:attribute>
										</xsl:if>
										<xsl:if test="/FichaProductoLic/PRODUCTOLICITACION/PRODUCTO_BLOQUEADO_POR_PEDIDOS and PROVEEDOR_BLOQUEADO_POR_PEDIDOS">
											<xsl:attribute name="checked">checked</xsl:attribute>
											<xsl:attribute name="disabled">disabled</xsl:attribute>
										</xsl:if>
									</input>
								</td>
								<td>
								<input type="textbox" class="campopesquisa w60px" name="CANTADJUD_[LIC_OFE_ID]" id="CANTADJUD_[LIC_OFE_ID]" onChange="javascript:chCantidadAdjudicada([LIC_OFE_ID]);">
									<xsl:if test="LIC_OFE_ADJUDICADA = 'S'">
										<xsl:attribute name="value">[LIC_OFE_CANTIDADADJUDICADA]</xsl:attribute>
									</xsl:if>
									<xsl:choose>
									<xsl:when test="LIC_OFE_ADJUDICADA = 'S' and(/FichaProductoLic/PRODUCTOLICITACION/PRODUCTO_BLOQUEADO_POR_PEDIDOS or PROVEEDOR_BLOQUEADO_POR_PEDIDOS)">
										<xsl:attribute name="disabled">disabled</xsl:attribute>
									</xsl:when>
									<xsl:when test="LIC_OFE_ADJUDICADA = 'N' and(/FichaProductoLic/PRODUCTOLICITACION/PRODUCTO_BLOQUEADO_POR_PEDIDOS or PROVEEDOR_BLOQUEADO_POR_PEDIDOS)">
										<xsl:attribute name="style">display:none</xsl:attribute>
									</xsl:when>	
									</xsl:choose>
								</input>
								</td>
							</xsl:when>
							<xsl:otherwise>
								<td>
								<xsl:if test="LIC_OFE_ADJUDICADA = 'S'">
									<img src="http://www.newco.dev.br/images/check.gif">
										<xsl:attribute name="alt">[document($doc)/translation/texts/item[@name='oferta_adjudicada']/node()]</xsl:attribute>
										<xsl:attribute name="title">[document($doc)/translation/texts/item[@name='oferta_adjudicada']/node()]</xsl:attribute>
									</img>
								</xsl:if>
								</td>
							</xsl:otherwise>
							</xsl:choose>
						</xsl:otherwise>
                    	</xsl:choose>
					</xsl:otherwise>
				    </xsl:choose>*/
			
				
			//	Tipo de IVA (no para Brasil)
			if (IDPais==55)
				Linea=Linea.replace('[TIPOIVA]','');
			else
				Linea=Linea.replace('[TIPOIVA]','<td>'+arrProductos[Pos].Ofertas[i].TIPOIVA+'%</td>');
				
			//	Precio				
			Linea=Linea.replaceAll('[PRECIO]',arrProductos[Pos].Ofertas[i].PRECIO);
			
			//	Color a aplicar al precio			
			if (arrProductos[Pos].Ofertas[i].SUPERIOR=='S')
				Linea=Linea.replace('[COLOR]','colorRojo');
			else if (arrProductos[Pos].Ofertas[i].IGUAL=='S')
				Linea=Linea.replace('[COLOR]','colorNaranja');
			else				
				Linea=Linea.replace('[COLOR]','colorVerde');

			//	Precio sospechoso
			if (arrProductos[Pos].Ofertas[i].MUY_SOSPECHOSO=='S')
				Linea=Linea.replace('[PRECIO_SOSPECHOSO]','<span class="colorRojo">&nbsp;?</span>');
			else if (arrProductos[Pos].Ofertas[i].SOSPECHOSO=='S')
				Linea=Linea.replace('[PRECIO_SOSPECHOSO]','<span class="colorNaranja">&nbsp;?</span>');
			else	
				Linea=Linea.replace('[PRECIO_SOSPECHOSO]','');


			/*[SEMAFORO_PEDIDO]</td>
					<xsl:if test="../../BOTON_PEDIDO and LIC_OFE_ADJUDICADA!='S'">
						<!-- Semaforo verde si existe pedido en estado 11, ambar en estado 13	-->
						<xsl:choose>
						<xsl:when test="/FichaProductoLic/PRODUCTOLICITACION/LIC_AGREGADA!='S'">
							<xsl:if test="MO_ID">
								<xsl:choose>
								<xsl:when test="MO_STATUS='11'"><img src="http://www.newco.dev.br/images/SemaforoVerde.gif]</xsl:when>
								<xsl:otherwise><img src="http://www.newco.dev.br/images/SemaforoAmbar.gif]</xsl:otherwise>
								</xsl:choose>
							</xsl:if>
						</xsl:when>
						<xsl:otherwise>
							<img id="imgSemVerde_[LIC_OFE_ID]" src="http://www.newco.dev.br/images/SemaforoVerde.gif]
							<img id="imgSemAmbar_[LIC_OFE_ID]" src="http://www.newco.dev.br/images/SemaforoAmbar.gif]
						</xsl:otherwise>
						</xsl:choose>
					</xsl:if>
					<xsl:if test="../../BOTON_PEDIDO">
						<input type="hidden" id="MO_ID_[LIC_OFE_ID]" value="[MO_ID]]
						<input type="hidden" id="MO_STATUS_[LIC_OFE_ID]" value="[MO_STATUS]]
						<input type="hidden" id="CODPEDIDO_[LIC_OFE_ID]" value="[CODPEDIDO]]
					</xsl:if>
				</td>*/

			//	Semaforo de pedido
			if ((botonPedido=='S')&&(arrProductos[Pos].Ofertas[i].OfertaAdjud=='S'))
			{
				var semPedido='';
				// Semaforo verde si existe pedido en estado 11, ambar en estado 13
				if (isLicAgregada=='N')
				{
					if (arrProductos[Pos].Ofertas[i].MO_ID!='')
					{
						if (arrProductos[Pos].Ofertas[i].MO_STATUS=='11') semPedido='<img src="http://www.newco.dev.br/images/SemaforoVerde.gif"/>';
						else semPedido='<img src="http://www.newco.dev.br/images/SemaforoAmbar.gif"/>';
					}
					else
					{
						semPedido+='<img id="imgSemVerde_[LIC_OFE_ID]" src="http://www.newco.dev.br/images/SemaforoVerde.gif"/>';
						semPedido+='<img id="imgSemAmbar_[LIC_OFE_ID]" src="http://www.newco.dev.br/images/SemaforoAmbar.gif"/>';
					}	
					
					if 	(botonPedido=='S')
						semPedido+=	'<input type="hidden" id="MO_ID_[LIC_OFE_ID]" value="'+arrProductos[Pos].Ofertas[i].MO_ID+'"/>';
									+'<input type="hidden" id="MO_STATUS_[LIC_OFE_ID]" value="'+arrProductos[Pos].Ofertas[i].MO_STATUS+'"/>';
									+'<input type="hidden" id="CODPEDIDO_[LIC_OFE_ID]" value="'+arrProductos[Pos].Ofertas[i].CODPEDIDO+'"/>';

				}
				
			
				Linea=Linea.replace('[SEMAFORO_PEDIDO]',semPedido);
			}
			else
				Linea=Linea.replace('[SEMAFORO_PEDIDO]','');
				
				
		
			//	Boton de pedido
			if (botonPedido=='S')
			{
			
				var botPedido;
				
				if (arrProductos[Pos].Ofertas[i].INCLUIDO_EN_PEDIDO=='S')
				{
					botPedido='<a id="btnVerPedido_[LIC_OFE_ID]" href="javascript:FichaPedido('+arrProductos[Pos].Ofertas[i].MO_ID+');">'+arrProductos[Pos].Ofertas[i].CODPEDIDO+'</a>';
					if (isLicAgregada=='S')
						botPedido+='<a class="btnDestacado" id="btnPedido_[LIC_OFE_ID]" href="javascript:Pedido([LIC_OFE_ID]);">'+strPedido+'</a>'
				}
				else
				{
					if (isLicAgregada=='S')
						botPedido='<a id="btnVerPedido_[LIC_OFE_ID]" href="javascript:FichaPedido('+arrProductos[Pos].Ofertas[i].MO_ID+');">SINPEDIDO</a>';
						
					botPedido+='<a class="btnDestacado" id="btnPedido_[LIC_OFE_ID]" href="javascript:Pedido([LIC_OFE_ID]);">'+strPedido+'</a>';
				}
				/*
				<xsl:when test="INCLUIDO_EN_PEDIDO">
					<a id="btnVerPedido_[LIC_OFE_ID]" href="javascript:FichaPedido([MO_ID]);">[CODPEDIDO]</a>
					<xsl:if test="/FichaProductoLic/PRODUCTOLICITACION/LIC_AGREGADA='S'">
						'<a class="btnDestacado" id="btnPedido_[LIC_OFE_ID]" href="javascript:Pedido([LIC_OFE_ID]);">'strPedido+'</a>'
					</xsl:if>
				</xsl:when>
				<xsl:otherwise>
					<xsl:if test="/FichaProductoLic/PRODUCTOLICITACION/LIC_AGREGADA='S'">
						<a id="btnVerPedido_[LIC_OFE_ID]" href="javascript:FichaPedido([MO_ID]);">SINPEDIDO</a>
					</xsl:if>
					<a class="btnDestacado" id="btnPedido_[LIC_OFE_ID]" href="javascript:Pedido([LIC_OFE_ID]);">[document($doc)/translation/texts/item[@name='pedido']/node()]</a>
					*/
				Linea=Linea.replace('[BOTON_PEDIDO]','botPedido');

			}
			else
				Linea=Linea.replace('[BOTON_PEDIDO]','');


			//	Icono para borrar oferta
			if (botonPedido=='S')
				Linea=Linea.replace('[DESCARTAR_OFERTA]','');
			else
				Linea=Linea.replace('[DESCARTAR_OFERTA]','<a id="btnDescartar_[LIC_OFE_ID]" href="javascript:DescartarOferta([LIC_OFE_ID]);"><img src="http://www.newco.dev.br/images/2022/icones/del.svg"/></a>');


			//	Al final, para corregir otras macros creadas dinamicamente
			Linea=Linea.replaceAll('[LIC_ID]',IDLicitacion);
			Linea=Linea.replaceAll('[POS]',Pos);
			Linea=Linea.replaceAll('[LIC_OFE_ID]',arrProductos[Pos].Ofertas[i].ID);

			//	Incluimos la linea
			html+=Linea;
		}
		
		var desp=DesplegableMotivos(Pos, arrProductos[Pos].IDMotivoSel);
		var foot=footTablaOfertas.replace('[IDMOTIVO_SEL]', desp);
		var foot=foot.replace('[MOTIVO_SEL]',arrProductos[Pos].MotivoSel);
		var foot=foot.replaceAll('[POS]',Pos);
				
		//	footer
		html+=foot;
		
		if (isLicAgregada=='S')
			html+=containerCentros;
		
    	jQuery('#'+ObjName).html(html);
    	jQuery('#'+ObjName).show();
		
		//	Si no es el mejor precio, muestra motivos

		//solodebug debug("AbrirProducto ("+Pos+"). UltSel:"+UltSel+' MostrarMotivoSeleccion:'+MostrarMotivoSeleccion+' PrecioOfertaActual:'+arrProductos[Pos].Ofertas[UltSel].PRECIO+' MejorPrecio:'+arrProductos[Pos].MejorPrecio);


		if ((UltSel>0)&&(MostrarMotivoSeleccion=='S')&&(desformateaDivisa(arrProductos[Pos].Ofertas[UltSel].PRECIO)>arrProductos[Pos].MejorPrecio))
			jQuery("#lMotivo_"+Pos).show();	

    	
		//	16jun22 Oculta el registro reducido al mostrar el registro completo
		jQuery('#divProd_'+Pos).hide();

		var position = jQuery('#'+ObjName).position();
		scroll(0,position.top);
	}
}


//	27abr22 Prepara el desplegable de motivos
function DesplegableMotivos(Pos, IDMotivo)
{
	var ListaDesplegable='<select id="IDMOTIVOSELECCION_'+Pos+'" class="w300px" onChange="javascript:GuardarProductoSel('+Pos+',\'\');">';
	for (var i=0;i<arrMotivos.length;++i)
	{
		var isSel='';
		if (IDMotivo==arrMotivos[i].ID)
			isSel='selected="selected"';

		ListaDesplegable+='<option value="'+arrMotivos[i].ID+'" '+isSel+'">'+arrMotivos[i].Texto+'</option>';
	}
	
	ListaDesplegable+='</select>';

	//solodebug debug("DesplegableMotivos ("+Pos+","+IDMotivo+"):"+ListaDesplegable);
	
	return ListaDesplegable;
}



// 25abr22 Al seleccionar una oferta, comprueba si es el precio m�nimo
//			Adaptado a partir de la funcion en FichaProductoLicitacion2022_300322.js
function SeleccionadaOferta(PosProd, ID)
{
	
	//solodebug
	debug('SeleccionadaOferta (1). ID:'+ID+' Producto ('+PosProd+'):'+arrProductos[PosProd].RefCliente+':'+arrProductos[PosProd].Nombre);
	//solodebug debug('SeleccionadaOferta. 1. Array productos:\n'+VuelcaArrayProductos(PosProd));
	
	
	var oform=document.forms["frmProductos"];
	var CantidadActual;
	
	//	13abr21 Marca el cambio a nivel de adjudicaciones, para avisar antes de salir
	CambiosProveedores='S';
		
	//solodebug	alert(PresentaForms(document));
	
	//	Busca el precio actual
	var PosOfe	=BuscaOferta(PosProd, ID);
	arrProductos[PosProd].PrecioOfertaActual=desformateaDivisa(arrProductos[PosProd].Ofertas[PosOfe].PRECIO);			//8jul22 oform.elements["PrecioOriginal_"+ID].value);

	//solodebug 
	debug('SeleccionadaOferta (2). PosProd:'+PosProd+' ID:'+ID+' PosOfe:'+PosOfe);	
	
	//	Busca el mejor precio y calcula la cantidad pendiente de adjudicar
	arrProductos[PosProd].CantidadPendiente	=CalcCantidadPendiente(PosProd);
	
	//solodebug 
	debug('SeleccionadaOferta (3). PosProd:'+PosProd+' ID:'+ID+' PrecioOfertaActual:'+arrProductos[PosProd].PrecioOfertaActual
			+' MejorPrecio:'+arrProductos[PosProd].MejorPrecio+' CantidadPendiente:'+arrProductos[PosProd].CantidadPendiente
			+ ' #ADJUD_'+ID+' checked:'+jQuery("#ADJUD_"+ID).prop("checked")
			+' OfertaAdjud:'+arrProductos[PosProd].Ofertas[PosOfe].OfertaAdjud
			);
	
	//	Compara con el mejor precio
	if ((jQuery("#ADJUD_"+ID).prop("checked"))&&(MostrarMotivoSeleccion=='S')&&(arrProductos[PosProd].PrecioOfertaActual>arrProductos[PosProd].MejorPrecio))
		jQuery("#lMotivo_"+PosProd).show();		
	else
	{
		jQuery("#IDMOTIVOSELECCION_"+PosProd).val("");			//	7nov19	Reinicializamos el desplegable
		jQuery("#MOTIVOSELECCION_"+PosProd).val("");			//	29jun22	Reinicializamos el desplegable
		jQuery("#lMotivo_"+PosProd).hide();
	}

	if ((isLicMultiopcion=='S')||((MesesDuracion==0)&&(isLicAgregada=='N')))			//	16dic19 Faltaba incluir la opci�n de SPOT	// 27ago20 Pero no para agregadas
	{
	
		//solodebug	
		console.log('SeleccionadaOferta: ID:'+ID+' isLicMultiopcion:'+isLicMultiopcion+' MesesDuracion:'+MesesDuracion);

		if (jQuery("#ADJUD_"+ID).prop("checked"))
		{
			
			//solodebug	console.log('SeleccionadaOferta: ID:'+ID+' actual:CHECKED. CantidadPendiente:'+arrProductos[PosProd].CantidadPendiente);
						
			CantidadActual=arrProductos[PosProd].CantidadPendiente;
			if (arrProductos[PosProd].CantidadPendiente>0)
			{
				//solodebug	console.log('SeleccionadaOferta: ID:'+ID+' PrecioOfertaActual:'+arrProductos[PosProd].PrecioOfertaActual+' MejorPrecio:'+arrProductos[PosProd].MejorPrecio+' CantidadPendiente:'+arrProductos[PosProd].CantidadPendiente+' MARCANDO ADJUDICADA');

				jQuery("#CANTADJUD_"+ID).val(arrProductos[PosProd].CantidadPendiente);

				arrProductos[PosProd].Ofertas[PosOfe].OfertaAdjud='S';
				arrProductos[PosProd].Ofertas[PosOfe].CANTIDADADJUDICADA=arrProductos[PosProd].CantidadPendiente;
	
				//solodebug	CalculaCantidadPendiente();
				arrProductos[PosProd].CantidadPendiente=0;
			}
			else
			{
				//solodebug	console.log('SeleccionadaOferta: ID:'+ID+' PrecioOfertaActual:'+arrProductos[PosProd].PrecioOfertaActual+' MejorPrecio:'+arrProductos[PosProd].MejorPrecio+' CantidadPendiente:'+arrProductos[PosProd].CantidadPendiente+' MARCANDO NO ADJUDICADA');
	
				arrProductos[PosProd].Ofertas[PosOfe].OfertaAdjud='N';
				arrProductos[PosProd].Ofertas[PosOfe].CANTIDADADJUDICADA='0';

				jQuery("#ADJUD_"+ID).prop("checked",false);
			}
		}
		else
		{
			arrProductos[PosProd].Ofertas[PosOfe].OfertaAdjud='N';
			arrProductos[PosProd].Ofertas[PosOfe].CANTIDADADJUDICADA='0';
			
			//solodebug	console.log('SeleccionadaOferta: ID'+ID+' PrecioOfertaActual:'+arrProductos[PosProd].PrecioOfertaActual+' MejorPrecio:'+arrProductos[PosProd].MejorPrecio+' CantidadPendiente:'+arrProductos[PosProd].CantidadPendiente+' UNCHECKED');

			CantidadActual=0;
			jQuery("#CANTADJUD_"+ID).val('');
			arrProductos[PosProd].CantidadPendiente	=CalcCantidadPendiente(PosProd);
		}
		
		jQuery("#Consumo_"+ID).html(String((arrProductos[PosProd].PrecioOfertaActual*CantidadActual).toFixed(2)));	
	}
	else
	{

		if (jQuery("#ADJUD_"+ID).prop("checked"))
		{
			//solodebug	console.log('SeleccionadaOferta: ID. '+ID+' NO multiopcion, MARCANDO ADJUDICADA, desmarcando otras');

			//10jul22 Marcamos en la lista de productos, en la matriz no es necesario
			jQuery("#ADJUD_"+ID).prop("checked",true);

			arrProductos[PosProd].Ofertas[PosOfe].OfertaAdjud='S';
			arrProductos[PosProd].Ofertas[PosOfe].CANTIDADADJUDICADA=arrProductos[PosProd].Cantidad;
			jQuery("#CANTADJUD_"+ID).val(arrProductos[PosProd].Cantidad);

			DesmarcaOtrasOfertas(PosProd, PosOfe);
		}
		else
		{
			//solodebug	console.log('SeleccionadaOferta: ID. '+ID+' NO multiopcion, MARCANDO NO ADJUDICADA');

			arrProductos[PosProd].Ofertas[PosOfe].OfertaAdjud='N';
			arrProductos[PosProd].Ofertas[PosOfe].CANTIDADADJUDICADA='0';
			jQuery("#CANTADJUD_"+ID).val('');
			arrProductos[PosProd].CantidadPendiente	=CalcCantidadPendiente(PosProd);
		}

	}

	CompruebaCambios(PosProd);
	RevisaOfertas(PosProd);

	//	29mar21
	if (isLicAgregada=='S')
		ActualizarCentrosYProveedores(PosProd);
	
	//	solodebug
	debug('SeleccionadaOferta. Array productos:\n'+VuelcaArrayProductos(PosProd));
	
	//	29jun22 Guarda la seleccion
	GuardarProductoSel(PosProd,'');
	
}


//	25abr22 al cambiar la cantidad, comprobamos como quedan las cantidades
//			Adaptado a partir de la funcion en FichaProductoLicitacion2022_300322.js
function chCantidadAdjudicada (PosProd, ID)
{
	var Cantidad=0;
	var oform=document.forms["frmProductos"];

	//solodebug	console.log('chCantidadAdjudicada. Comprobando ID:'+ID);
	
	//	13abr21 Marca el cambio a nivel de adjudicaciones, para avisar antes de salir
	CambiosProveedores='S';
	
	//	Busca el precio actual
	var gl_PrecioOfertaActual=desformateaDivisa(oform.elements["PrecioOriginal_"+ID].value);

	var CantTxt=jQuery('#CANTADJUD_'+ID).val();
	var PosOfe=BuscaOferta(PosProd, ID);
	
	if ((CantTxt=='')||(!jQuery.isNumeric(CantTxt)))
	{
		jQuery('#CANTADJUD_'+ID).val('');
		jQuery("#ADJUD_"+ID).prop("checked",false);	
		arrProductos[PosProd].Ofertas[PosOfe].OfertaAdjud='N';
		arrProductos[PosProd].Ofertas[PosOfe].CANTIDADADJUDICADA='0';
		CalculaCantidadPendiente();
		Cantidad=0;
	}
	else
	{

		jQuery("#ADJUD_"+ID).prop("checked",true);

		//	Comprueba que la cantidad pendiente sea correcta
		Cantidad=parseInt(CantTxt.replace(",","."));

		//solodebug	console.log('chCantidadAdjudicada. Comprobando ID:'+ID+' Cantidad:'+Cantidad);

		if (Cantidad<0) Cantidad=0;
		
		//	9abr21 Control del empaquetamiento
		var UdsLote=parseInt(jQuery("#UdsLote_"+ID).val());
		
		if (Cantidad%UdsLote!=0)
		{
			var nuevaCantidad=UdsLote*Math.ceil(Cantidad/UdsLote);
			/*	9jun22
			alert('La cantidad '+Cantidad
					+' no corresponde al empaquetamiento:'+UdsLote
					+' cantidad corregida:'+nuevaCantidad);
					
			'La cantidad [CANTIDAD] no corresponde al empaquetamiento: [UDESLOTE]. Cantidad corregida: [NUEVACANTIDAD]'		*/
				
			alert(alrt_CantidadNoCorresponde.replace('[CANTIDAD]',Cantidad).replace('[UDESLOTE]',UdsLote).replace('[NUEVACANTIDAD]',nuevaCantidad));
					
			Cantidad=nuevaCantidad;
		}
		

		//solodebug	console.log('chCantidadAdjudicada. Asignando ID:'+ID+' Cantidad:'+Cantidad);
		
		jQuery('#CANTADJUD_'+ID).val(Cantidad);

		//	Recalcula la cantidad pendiente	
		var CantidadPendiente=CalcCantidadPendiente(PosProd);

		//	Corrige si hemos sobrepasado el total
		if (CantidadPendiente<0) 
		{
			Cantidad+=CantidadPendiente;
			
			/*8jun22 alert("Superada la cantidad total de producto, nueva cantidad:"+Cantidad);*/
			alert(alrt_SuperadaCantidad.replace('[CANTIDAD]',Cantidad));
			
			CantidadPendiente=CalcCantidadPendiente(PosProd);
			if (Cantidad>0 )
			{
				jQuery('#CANTADJUD_'+ID).val(Cantidad);
				arrProductos[PosProd].Ofertas[PosOfe].CANTIDADADJUDICADA=Cantidad;
				arrProductos[PosProd].Ofertas[PosOfe].OfertaAdjud='S';
			}
			else	
			{
				//	Quita la marca de adjudicaci�n
				jQuery('#CANTADJUD_'+ID).val('');
				jQuery("#ADJUD_"+ID).prop("checked",false);
				CantidadPendiente=0;
				arrProductos[PosProd].Ofertas[PosOfe].CANTIDADADJUDICADA=0;
				arrProductos[PosProd].Ofertas[PosOfe].OfertaAdjud='N';
			}
		}
		else
		{
			jQuery('#CANTADJUD_'+ID).val(Cantidad);
			arrProductos[PosProd].Ofertas[PosOfe].CANTIDADADJUDICADA=Cantidad;
			arrProductos[PosProd].Ofertas[PosOfe].OfertaAdjud='S';
		}
	}

	jQuery("#Consumo_"+ID).html(String((gl_PrecioOfertaActual*Cantidad).toFixed(2)));

	CompruebaCambios(PosProd);
	RevisaOfertas(PosProd);
	
	//	29mar21
	if (isLicAgregada=='S')
		ActualizarCentrosYProveedores();

	//	29jun22 Guarda la seleccion
	GuardarProductoSel(PosProd,'')

}


// 25abr22	Guarda la selecci�n para la oferta de un unico producto. Copiado desde lic_170916
//			Adaptado a partir de la funcion en FichaProductoLicitacion2022_300322.js
function GuardarProductoSel(PosProd, Accion){
	var d = new Date();
	var msgError ='';


	//	solodebug
	debug('GuardarProductoSel. Array productos:\n'+VuelcaArrayProductos(PosProd));


	//	Para accion 'TODOS', salimos al completar los productos
	if (PosProd==arrProductos.length)
	{
		jQuery('#spCargaProductos').html('');
		jQuery('#pCargaProductos').hide();
		jQuery('#spCargaProductos').hide();
		return;
	}
	
	if ((Accion=='TODOS')&&(PosProd==0))
	{
		jQuery('#pCargaProductos').show();
		jQuery('#spCargaProductos').show();
	}
	
	
	var IDProdLic=arrProductos[PosProd].IDProdLic;
	var IDOfertaLic = IDOfertaSeleccionada(PosProd);
	var IDMotivo=jQuery("#IDMOTIVOSELECCION_"+PosProd).val();
	var Motivo	=jQuery("#MOTIVOSELECCION_"+PosProd).val();	
	
	var adjudOfertas='',multOfertas='', cantAdjud=0;
	
	var CantidadTotal=arrProductos[PosProd].CantidadSF;
	
	//solodebug
	debug('GuardarProductoSel('+PosProd+'). Accion:'+Accion+' CantidadTotal:'+CantidadTotal);

	/*	solodebug	*/
	debug('GuardarProductoSel('+PosProd+'). Accion:'+Accion+' isLicMultiopcion:'+isLicMultiopcion+' OfertasSeleccionadas:'+arrProductos[PosProd].Seleccionadas+' IDOfertaSel:'+IDOfertaLic
	 	+' MostrarMotivoSeleccion:'+MostrarMotivoSeleccion+' PrecioOfertaActual:'+arrProductos[PosProd].PrecioOfertaActual+' MejorPrecio:'+arrProductos[PosProd].MejorPrecio
		+' IDMotivo:'+IDMotivo+' Motivo:'+Motivo);
	
	if ((MostrarMotivoSeleccion=='S')&&(arrProductos[PosProd].Seleccionadas>0)&&(arrProductos[PosProd].PrecioOfertaActual>arrProductos[PosProd].MejorPrecio)&&(IDMotivo=='')){
		msgError=alrt_RequiereMotivo;
	}

		
	if (isLicMultiopcion=='S')
	{
		var Inform='N', opcion1='N';
		jQuery("select").each(function()
		{
        	//solodebug	
			console.log('Nombre:'+jQuery(this).attr("name").substring(0,5));
			
			if (jQuery(this).attr("name").substring(0,5)=='ORDEN')
			{

				adjudOfertas+=Piece(jQuery(this).attr("name"),'_',1)+'#'+jQuery(this).val()+'|';

				if (jQuery(this).val()!='')
				{
	        	    Inform='S';
				}

				if (jQuery(this).val()=='1')
					if (opcion1=='S')
						msgError=alrt_SoloUnaOpcion1;
					else
						opcion1='S';

        	    //solodebug	console.log('Valor:'+jQuery(this).val()+' Inform:'+Inform+' opcion1:'+opcion1+' lista adj:'+adjudOfertas);
			}
        });
	
		//	11jul18 Opcion1 no obligatoria
		//if ((Inform=='S')&&(opcion1=='N'))
		//	msgError=alrt_RequiereOpcion1;
	}
	else if (arrProductos[PosProd].Seleccionadas>1)
	{
        //solodebug	console.log ('OfertasSeleccionadas>1');

		jQuery("input[name*='CANTADJUD_']").each(function(){

			var ID=Piece(jQuery(this).attr("name"),'_',1);

			//solodebug	console.log('GuardarProductoSel. Comprobando ID:'+ID+' checked:'+jQuery("#ADJUD_"+ID).prop("checked"));

			if (jQuery("#ADJUD_"+ID).prop("checked"))
			{
				var Cantidad=desformateaDivisa(jQuery(this).val());
				cantAdjud+=Cantidad;
				multOfertas+=ID+'#'+Cantidad+'|';

				//solodebug	
				console.log('GuardarProductoSel. Comprobando ID:'+ID+' Cantidad:'+Cantidad+' multOfertas:'+multOfertas);
			}
		});

		//solodebug	
		debug('GuardarProductoSel. multOfertas:'+multOfertas+ 'cantAdjud:'+cantAdjud+' CantidadTotal:'+CantidadTotal);
		
		if (cantAdjud<CantidadTotal) msgError=alrt_CantidadInfTotal+':'+cantAdjud+'<'+CantidadTotal+'.';
		if (cantAdjud>CantidadTotal) msgError=alrt_CantidadSupTotal+':'+cantAdjud+'>'+CantidadTotal+'.';
		
		
		//	5may21 SI esta correcto a nivel de proveedores, revisa las opciones a nivel de centros/proveedores
		if ((msgError=='')&&(isLicAgregada=='S'))
			msgError=CompruebaCantidadCentrosProv();
		
	
	}

	//29jun22 Ya no solicitamos confirmacion al guardar producto sin oferta seleccionada, ya que el guardado es automatico
	//if ((IDOfertaLic=='')&&(multOfertas=='')&&(adjudOfertas=='')&&(!confirm(alrt_NoHaSeleccionadoOferta)))		//	30nov18	Solicitamos confirmaci�n antes de guardar producto sin oferta seleccionada
	//	return;
	
	//solodebug	alert("IDLIC="+IDLicitacion+"&IDPRODUCTOLIC="+IDProdLic+"&IDOFERTA="+IDOfertaLic+"&IDMOTIVO="+IDMotivo+"&MOTIVO="+encodeURIComponent(Motivo));

	//solodebug	console.log('OfertasSeleccionadas. isLicMultiopcion:'+isLicMultiopcion+' multOfertas:'+multOfertas+ 'cantAdjud:'+cantAdjud+' CantidadTotal:'+CantidadTotal+' msgError:'+msgError);	

	if(msgError == '')
	{
		if ((isLicMultiopcion!='S')&&(multOfertas==''))
		{			

			//solodebug	console.log('OfertasSeleccionadas. isLicMultiopcion:'+isLicMultiopcion+' multOfertas:'+multOfertas+ 'cantAdjud:'+cantAdjud+' CantidadTotal:'+CantidadTotal+' -> Adjudicaci�n �nica');

			//	Adjudicaci�n �nica
			jQuery.ajax({
				url:	"http://www.newco.dev.br/Gestion/Comercial/SeleccionarProductoAJAX.xsql",
				data:	"IDLIC="+IDLicitacion+"&IDPRODUCTOLIC="+IDProdLic+"&IDOFERTA="+IDOfertaLic+"&IDMOTIVO="+IDMotivo+"&MOTIVO="+encodeURIComponent(Motivo)+"&_="+d.getTime(),
				type:	"GET",
				contentType: "application/xhtml+xml",
				beforeSend: function(){
					null;
				},
				error: function(objeto, quepaso, otroobj){
					alert('error'+quepaso+' '+otroobj+''+objeto);
				},
				success: function(objeto){
					var data = JSON.parse(objeto);

					if(data.Resultado.Estado == 'OK'){
											
						if (Accion=='TODOS')		
						{
							jQuery('#spCargaProductos').html((PosProd+1)+' / '+arrProductos.length);
							SeleccionGuardada(PosProd, 'N');
 							GuardarProductoSel(++PosProd, 'TODOS');				
						}
						else
							SeleccionGuardada(PosProd, 'N');
												
					}else{
						alert(alrt_GuardarSelKo);
					}
				}
			});
		}
		else 
		{
			if ((isLicMultiopcion!='S')&&(multOfertas!=''))
			{

				//solodebug	console.log('OfertasSeleccionadas. isLicMultiopcion:'+isLicMultiopcion+' multOfertas:'+multOfertas+ 'cantAdjud:'+cantAdjud+' CantidadTotal:'+CantidadTotal+' -> Adjudicaci�n repartida');

				//	Cantidad repartida entre varios proveedores			
				//solodebug console.log('multOfertas:'+multOfertas);

				jQuery.ajax({
					url:	"http://www.newco.dev.br/Gestion/Comercial/SeleccionarProductoRepartidoAJAX.xsql",
					data:	"IDLIC="+IDLicitacion+"&IDPRODUCTOLIC="+IDProdLic+"&LISTA_OFERTAS="+encodeURIComponent(multOfertas)+"&IDMOTIVO="+IDMotivo+"&MOTIVO="+encodeURIComponent(Motivo)+"&_="+d.getTime(),
					type:	"GET",
					contentType: "application/xhtml+xml",
					beforeSend: function(){
						null;
					},
					error: function(objeto, quepaso, otroobj){
						alert('error'+quepaso+' '+otroobj+''+objeto);
					},
					success: function(objeto){
						var data = JSON.parse(objeto);

						if(data.Resultado.Estado == 'OK'){
					
							if (Accion=='TODOS')		
							{
								jQuery('#spCargaProductos').html((PosProd+1)+' / '+arrProductos.length);
								SeleccionGuardada(PosProd, 'N');
 								GuardarProductoSel(++PosProd, 'TODOS');				
							}
							else
								SeleccionGuardada(PosProd, 'N');
						
						}else{
							alert(alrt_GuardarSelKo);
						}
					}
				});
			}
			else
			{
				//	Adjudicaci�n m�ltiple			

				//solodebug	console.log('OfertasSeleccionadas. isLicMultiopcion:'+isLicMultiopcion+' multOfertas:'+multOfertas+ 'cantAdjud:'+cantAdjud+'CantidadTotal:'+CantidadTotal+' -> Adjudicaci�n multiple');

				//solodebug	console.log('adjudOfertas:'+adjudOfertas);

				jQuery.ajax({
					url:	"http://www.newco.dev.br/Gestion/Comercial/SeleccionarProductoMultipleAJAX.xsql",
					data:	"IDLIC="+IDLicitacion+"&IDPRODUCTOLIC="+IDProdLic+"&LISTA_OFERTAS="+encodeURIComponent(adjudOfertas)+"&IDMOTIVO="+IDMotivo+"&MOTIVO="+encodeURIComponent(Motivo)+"&_="+d.getTime(),
					type:	"GET",
					contentType: "application/xhtml+xml",
					beforeSend: function(){
						null;
					},
					error: function(objeto, quepaso, otroobj){
						alert('error'+quepaso+' '+otroobj+''+objeto);
					},
					success: function(objeto){
						var data = JSON.parse(objeto);

						if(data.Resultado.Estado == 'OK'){

							if (Accion=='TODOS')		
							{
								jQuery('#spCargaProductos').html((PosProd+1)+' / '+arrProductos.length);
								SeleccionGuardada(PosProd, 'N');
 								GuardarProductoSel(++PosProd, 'TODOS');				
							}
							else
								SeleccionGuardada(PosProd, 'N');
								
						}else{
							alert(alrt_GuardarSelKo);
						}
					}
				});

			}
			
		}

	}else{
		alert(msgError);
	}
			
	
}


//	2may22 Tareas a realizar una vez guardada la seleccion
function SeleccionGuardada(PosProd, Siguiente)
{
	//	Recalcula los totales
	ActualizaTotales(PosProd);
	
	//	Marca el producto como sin cambios
	arrProductos[PosProd].Cambios='N';
	
	//	Actualiza las ofertas
	ActualizaOfertas(PosProd);

	//	16jun22 Actualiza el contador junto al carrito
	ActualizarContador();

	//	Abre el siguiente producto
	if (Siguiente=='S')
		AbrirSiguiente(PosProd);

}


//	25abr22 Busca el ID de la oferta seleccionada
//			Adaptado a partir de la funcion en FichaProductoLicitacion2022_300322.js
function IDOfertaSeleccionada(PosProd)
{
	var IDOferta='';
	
	for (var i=0;i<arrProductos[PosProd].Ofertas.length;++i)
	{
		//solodebug	console.log('IDOfertaSeleccionada. IDOferta:'+arrProductos[PosProd].Ofertas[i]+' Sel:'+arrProductos[PosProd].Ofertas[i].OfertaAdjud);
		
		if (arrProductos[PosProd].Ofertas[i].OfertaAdjud=='S')
			IDOferta=arrProductos[PosProd].Ofertas[i].ID;		
	}
	
	//solodebug	console.log('IDOfertaSeleccionada ('+PosProd+'). IDOferta:'+IDOferta);
		
	return IDOferta;
}


//	25abr22 Busca el ID de la oferta seleccionada
//			Adaptado a partir de la funcion en FichaProductoLicitacion2022_300322.js
function BuscaOferta(PosProd, ID)
{
	var Pos=-1;
	for (var i=0;(i<arrProductos[PosProd].Ofertas.length)&&(Pos==-1);++i)
	{
	
		console.log('BuscaOferta. ('+PosProd+'). ID:'+ID+'  revisando ('+i+') ID:'+arrProductos[PosProd].Ofertas[i].ID);

		if (arrProductos[PosProd].Ofertas[i].ID==ID) Pos=i;		
	}
	
	//solodebug	
	console.log('BuscaOferta. ('+PosProd+'). ID:'+ID+' Pos:'+Pos);
		
	return Pos;
}


//	25abr22 Recalcula la cantidad pendiente
function CalcCantidadPendiente(PosProd)
{
	//solodebug	console.log('CalculaCantidadPendiente. CantidadTotal:'+CantidadTotal);

	var CantidadPendiente=parseInt(arrProductos[PosProd].Cantidad);
	
	//solodebug	console.log('CalculaCantidadPendiente. CantidadInicial:'+CantidadPendiente);
	
	for (var i=0;i<arrProductos[PosProd].Ofertas.length;++i)
	{
		if (arrProductos[PosProd].Ofertas[i].OfertaAdjud=='S')
		{
			//solodebug	console.log('CalculaCantidadPendiente. fila '+i+' Adjudicada. Cantidad:'+arrProductos[PosProd].Ofertas[i].CANTIDADADJUDICADA);
			
			CantidadPendiente-=parseInt(arrProductos[PosProd].Ofertas[i].CANTIDADADJUDICADA);		

			//solodebug	console.log('CalculaCantidadPendiente. fila '+i+' Adjudicada. Cantidad:'+arrProductos[PosProd].Ofertas[i].CANTIDADADJUDICADA+' CantidadPendiente:'+CantidadPendiente);
		}
	}
	
	//solodebug	console.log('CalcCantidadPendiente ('+PosProd+'). CantidadPendiente:'+CantidadPendiente);

	return CantidadPendiente;
}


//	25abr22 Recalcula la cantidad pendiente
function CalcMejorPrecio(PosProd)
{
	var MejorPrecio=-1;
	for (var i=0;i<arrProductos[PosProd].Ofertas.length;++i)
	{
		var Precio=desformateaDivisa(arrProductos[PosProd].Ofertas[i].PRECIO);
		if ((MejorPrecio==-1)||(MejorPrecio>Precio)) MejorPrecio=Precio;
	}
	
	//solodebug	console.log('CalcMejorPrecio ('+PosProd+'). MejorPrecio:'+MejorPrecio);
	return MejorPrecio;
}


//	25abr22 Recalcula la cantidad pendiente
function DesmarcaOtrasOfertas(PosProd, PosOfe)
{
	for (var i=0;i<arrProductos[PosProd].Ofertas.length;++i)
	{
		if ((i!=PosOfe)&&(arrProductos[PosProd].Ofertas[i].OfertaAdjud=='S'))
		{
			arrProductos[PosProd].Ofertas[i].OfertaAdjud='N';
			arrProductos[PosProd].Ofertas[i].CANTIDADADJUDICADA='';
			
			jQuery("#ADJUD_"+arrProductos[PosProd].Ofertas[i].ID).prop("checked",false);
			jQuery("#CANTADJUD_"+arrProductos[PosProd].Ofertas[i].ID).val('');
		}
	}
}


//	2may22 Revisa el numero de ofertas adjudicadas del producto
function RevisaOfertas(Pos)
{
	var adjud=0;
	for (var i=0;i<arrProductos[Pos].Ofertas.length;++i)
	{
		//solodebug	debug('RevisaOfertas. Pos:'+Pos+' oferta['+i+'] adjud:'+arrProductos[Pos].Ofertas[i].OfertaAdjud);
	
		if (arrProductos[Pos].Ofertas[i].OfertaAdjud=='S')
			++adjud;
	}
	arrProductos[Pos].Seleccionadas=adjud;
	
	//solodebug debug('RevisaOfertas. Pos:'+Pos+' adjud:'+adjud);
}


//	28abr22 Actualiza los totales a nivel de proveedores segun los cambios realizados por el usuario
function ActualizaTotales(Pos)		
{		

	//	Repasa el backup de las ofertas, restando las selecciones anteriores
	for (var i=0;i<arrProductos[Pos].OfertasBack.length;++i)
	{
		if (arrProductos[Pos].OfertasBack[i].OfertaAdjud=='S')
		{
			var PosProveedor=BuscaProveedor(arrProductos[Pos].OfertasBack[i].IDPROVEEDOR);
			
			//solodebug debug('ActualizaTotales [1]. Prov:'+arrConsumoProvs[PosProveedor].NombreCorto+' ofertas:'+arrConsumoProvs[PosProveedor].OfertasAdj+' cons.Ant.:'+arrConsumoProvs[PosProveedor].ConsumoAdj);
			
			arrConsumoProvs[PosProveedor].ConsumoAdj_Float-=arrProductos[Pos].OfertasBack[i].PRECIO_FLOAT*parseInt(arrProductos[Pos].OfertasBack[i].CANTIDADADJUDICADA);
			arrConsumoProvs[PosProveedor].ConsumoAdj=formateaDivisa(arrConsumoProvs[PosProveedor].ConsumoAdj_Float);

			--arrConsumoProvs[PosProveedor].OfertasAdj;
			
		}
	}


	//	Repasa las ofertas, sumando la seleccion actual
	for (var i=0;i<arrProductos[Pos].Ofertas.length;++i)
	{
		if (arrProductos[Pos].Ofertas[i].OfertaAdjud=='S')
		{
			var PosProveedor=BuscaProveedor(arrProductos[Pos].Ofertas[i].IDPROVEEDOR);

			//solodebug debug('ActualizaTotales [2]. Prov:'+arrConsumoProvs[PosProveedor].NombreCorto+' ofertas:'+arrConsumoProvs[PosProveedor].OfertasAdj+' cons.Ant.:'+arrConsumoProvs[PosProveedor].ConsumoAdj);

			arrConsumoProvs[PosProveedor].ConsumoAdj_Float+=arrProductos[Pos].Ofertas[i].PRECIO_FLOAT*parseInt(arrProductos[Pos].Ofertas[i].CANTIDADADJUDICADA);
			arrConsumoProvs[PosProveedor].ConsumoAdj=formateaDivisa(arrConsumoProvs[PosProveedor].ConsumoAdj_Float);

			++arrConsumoProvs[PosProveedor].OfertasAdj;
		}
	}	
	
}

//	2may22 Busca la posicion del proveedor por su ID
function BuscaProveedor(ID)
{
	var Pos=-1;
	//	Repasa las ofertas, sumando la seleccion actual
	for (var i=0;(Pos==-1)&&(i<arrConsumoProvs.length);++i)
	{
		if (arrConsumoProvs[i].ID==ID) Pos=i;
	}
	//solodebug debug('BuscaProveedor ID:'+ID+' Pos:'+Pos);
	return Pos;
}



//	28abr22 Actualiza el contador de ofertas en la linea de producto
function ActualizaOfertas(Pos)		
{		

	//solodebug	debug('ActualizaOfertas. Pos:'+Pos+' Of.Adjud:'+arrProductos[Pos].Seleccionadas+'. Of.Tot:'+arrProductos[Pos].Ofertas.length+ '. Ahorro:'+arrProductos[Pos].Ahorro);

	/*
	15jun22 Nuevo disenno Daniel
	
	jQuery("#ProdOfe_"+Pos).html('&nbsp;'+arrProductos[Pos].Seleccionadas+'/'+arrProductos[Pos].Ofertas.length+'&nbsp;');

	jQuery("#ProdOfe_"+Pos).removeClass('fondoRojo').removeClass('fondoNaranja').removeClass('fondoVerde');
	if ((arrProductos[Pos].Ofertas.length>0)&&(arrProductos[Pos].Seleccionadas>0))
		jQuery("#ProdOfe_"+Pos).addClass('fondoVerde');
	else if ((arrProductos[Pos].Ofertas.length>0)&&(arrProductos[Pos].Seleccionadas==0))
		jQuery("#ProdOfe_"+Pos).addClass('fondoNaranja');
	else
		jQuery("#ProdOfe_"+Pos).addClass('fondoRojo');
	*/

	var color=(arrProductos[Pos].Seleccionadas>0)?'verde':'rojo';
	jQuery("#pOfertas_"+Pos).html(strOfertas+'<br/>'+arrProductos[Pos].Seleccionadas+'/'+(arrProductos[Pos].Ofertas.length+1)).addClass(color);	

	var color=(arrProductos[Pos].Ahorro>0)?'verde':((arrProductos[Pos].Ahorro==0)?'naranja':'rojo');
	jQuery("#pAhorro_"+Pos).html(strAhorro+'<br/>'+arrProductos[Pos].Ahorro+'%').addClass(color);

}


//	28abr22 Cierra el producto abierto (si hay alguno) al abrir uno nuevo
function CierraProductos()
{
	//solodebug debug('CierraProductos.');

	//1ago22 Para "cerrar" todos los productos, redibujamos la tabla
	ListaProductos();

/*	1ago22
	for (var i=0;i<arrProductos.length;++i)
	{

		var ObjName='divOfe_'+i;

		if (jQuery('#'+ObjName).is(':visible')) 
		{
    		jQuery('#'+ObjName).hide();
   			jQuery('#'+ObjName).html('');

			//	16jun22 muestra los registros cortos al cerrar los grandes
			jQuery('#divProd_'+i).show();
		}
	}
	gl_ProductoAbierto = '-1'*/
}


//	29abr22 Cierra el producto abierto
function CierraProducto(Pos)
{
	//1ago22 Para "cerrar" productos, redibujamos la tabla
	ListaProductos();

/*	1ago22
	//solodebug debug('CierraProducto.Pos:'+Pos);
	var ObjName='divOfe_'+Pos;

	if (jQuery('#'+ObjName).is(':visible')) 
	{
    	jQuery('#'+ObjName).hide();
   		jQuery('#'+ObjName).html('');
	}
	gl_ProductoAbierto = '-1'*/
}


//	2may22 Comprueba si se han producido cambios en las selecciones
function CompruebaCambios(PosProd)
{
	var cambios='N';
	for (var i=0;(cambios=='N')&&(i<arrProductos[PosProd].Ofertas.length);++i)
	{
		/*solodebug debug('CompruebaCambios.PosProd:'+PosProd+'Oferta('+i+') Adjud:'+arrProductos[PosProd].Ofertas[i].OfertaAdjud+' vs '+arrProductos[PosProd].OfertasBack[i].OfertaAdjud
			 +'Cant.Adjud:'+arrProductos[PosProd].Ofertas[i].CANTIDADADJUDICADA+' vs '+arrProductos[PosProd].OfertasBack[i].CANTIDADADJUDICADA);
		*/
	
		if ((arrProductos[PosProd].Ofertas[i].OfertaAdjud!=arrProductos[PosProd].OfertasBack[i].OfertaAdjud)
				||(arrProductos[PosProd].Ofertas[i].CANTIDADADJUDICADA!=arrProductos[PosProd].OfertasBack[i].CANTIDADADJUDICADA))
			cambios='S';
	}
	
	//solodebug debug('CompruebaCambios.PosProd:'+PosProd+' cambios:'+cambios);
	
	arrProductos[PosProd].Cambios=cambios;
}


//	PENDIENTE!!!!!
//			Adaptado a partir de la funcion en FichaProductoLicitacion2022_300322.js
function ActualizarCentrosYProveedores(PosProd)
{
}


//	PENDIENTE!!!!!
//			Adaptado a partir de la funcion en FichaProductoLicitacion2022_300322.js
function CompruebaCantidadCentrosProv(PosProd)
{
	return '';
}

//	13jun22 Actualiza los datos de vencimiento en la base de datos. Recarga la pagina si el ESTADO va a cambiar. Comprueba que la fecha sea posterior a la fecha actual.
function GuardarVencimiento()
{
	var msgError='',errores=0;
	var hoy = new Date(), hoyOrd=hoy.getFullYear()*10000+(hoy.getMonth()+1)*100+hoy.getDate();			//	Este formato es m�s eficiente para comparar fechas
	
	var FechaDec=jQuery("#FECHADECISION").val();		//formato yyyy-mm-dd
	//	Cambiamos al formato dd/mm/yyyy
	FechaDec=Piece(FechaDec,'-',2)+'/'+Piece(FechaDec,'-',1)+'/'+Piece(FechaDec,'-',0);
	
	//solodebug	console.log('GuardarVencimiento. Fecha:'+FechaDec);
	
	//	Control de la fecha
	if(esNulo(FechaDec)){
		errores++;
		//alert(val_faltaFechaDecision);
		msgError+=val_faltaFechaDecision+'\n';
	}
	else if(!errores && CheckDate(FechaDec))
	{
		errores++;
		//alert(val_malFechaDecision);
		msgError+=val_malFechaDecision+'\n';
	}
	else if (fechaDecisionLic!=FechaDec)	//	18feb20 Solo chequeamos la fecha de decision si ha sido modificada
	{
		fechaDec=parseInt(Piece(FechaDec,'/',2))*10000+parseInt(Piece(FechaDec,'/',1))*100+parseInt(Piece(FechaDec,'/',0));

		//solodebug	alert('hoyOrd:'+hoyOrd+' fechaDec:'+fechaDec);

		if (fechaDec<10000000) fechaDec=20000000+fechaDec;			//5may21 Solucionado error (fechaDec<100000000)

		//CAMBIAR CUANDO LA LIBRERIA EST� ACTUALIZADA fechaDec=dateToInteger(FechaDec);

		//solodebug	alert('hoyOrd:'+hoyOrd+' fechaDec:'+fechaDec);

		if(!errores && (fechaDec<hoyOrd))
		{
			errores++;
			//alert(val_FechaDecisionAntigua);
			msgError+=val_FechaDecisionAntigua+'\n';
		}

	}
	
	//	Control de la hora/minuto
	var HoraMinuto=jQuery("#HORAMINUTODECISION").val();		//formato yyyy-mm-dd
	//solodebug	debug('GuardarVencimiento.Hora:'+HoraMinuto);
	var Hora=Piece(HoraMinuto,':',0);
	var Minuto=Piece(HoraMinuto,':',1);

	if(esNulo(Hora)||esNulo(Minuto)){
		errores++;
		msgError+=val_faltaFechaDecision+'\n';
	}
	

	if (errores>0)
	{
		//	Mostrar error
		jQuery("#FECHADECISION").focus();
		alert(msgError);
	}
	else
	{
		//	Enviar los datos a BBDD
		debug('GuardarVencimiento:'+FechaDec+' '+Hora+':'+Minuto);
		
		//	Oculta el boton de guardar
		jQuery("#btnGuardarFechaDecision").hide();
		
		//	Adjudicaci�n �nica
		jQuery.ajax({
			url:	"http://www.newco.dev.br/Gestion/Comercial/ActualizarFechaDecisionLicAJAX.xsql",
			data:	"LIC_ID="+IDLicitacion+"&FECHADECISION="+fechaDec+"&HORADECISION="+Hora+"&MINUTODECISION="+Minuto+"&_="+hoy.getTime(),
			type:	"GET",
			contentType: "application/xhtml+xml",
			beforeSend: function(){
				null;
			},
			error: function(objeto, quepaso, otroobj){
				alert('error'+quepaso+' '+otroobj+''+objeto);
			},
			success: function(objeto){
				var data = JSON.parse(objeto);
				
				//solodebug
				debug("GuardarVencimiento. Res:"+objeto);

				if(data.Licitacion.Estado == 'OK'){
					//Destacar mejor que se ha guardado la fecha
					jQuery("#btnGuardarFechaDecision").show();
				}else{
					alert(alrt_GuardarFechaDecisionKO);
					jQuery("#btnGuardarFechaDecision").show();
				}
			}
		});
	}
}

//	15jun22 COmprueba si hay datos pendientes de guardar y cambia a vencedores
function Vencedores()
{
	var msgAviso='', Seguir='S';
	
	if (CuentaSeleccionados()<arrProductos.length)
		msgAviso=alrt_ExistenProdSel+'\n';
				
	if (CuentaModificados()>0)
		msgAviso+=alrt_ExistenProdModif+'\n';
	
	if ((msgAviso=='')||(confirm(msgAviso+alrt_DeseaContinuar)))
		chVencedores(IDLicitacion);
}


//	15jun22 Selecciona la oferta de mejor precio para cada producto. Recalcula los totales segun las selecciones. Guarda las ofertas en plataforma.
function MejoresPrecios(Pos)
{
	//solodebug	debug('MejoresPrecios:'+Pos);

	if (Pos==arrProductos.length)
	{
		jQuery('#spCargaProductos').hide();
		jQuery('#pCargaProductos').hide();
	
		//	20jun22 Guarda todos los productos seleccionados
		GuardarProductoSel(0,'TODOS');	

		// 10jul22 Redibuja la tabla que este actualmente visible
		CambiaVista();
		
		//	Actualiza el contador		
		ActualizarContador();

		//solodebug	debug('CargaOfertas:'+Pos+' FIN');
		
		return;
	}

	//	Selecciona la mejor oferta y guarda los datos
	//solodebug	debug('MejoresPrecios:'+Pos+'---> SeleccionaMejorOferta');
	SeleccionaMejorOferta(Pos);
		
	MejoresPrecios(++Pos);
	
	
	return;

}


//	17jun22 Selecciona la mejor oferta para el producto
function SeleccionaMejorOferta(Pos)
{
	//solodebug debug('SeleccionaMejorOferta:'+Pos);

	//	Sale directamente si no tiene ofertas
	if (arrProductos[Pos].Ofertas.length==0) return;

	//solodebug debug('SeleccionaMejorOferta. ['+Pos+'] Activar:'+arrProductos[Pos].Ofertas[0].ID);

	//	Selecciona la primera oferta	
	arrProductos[Pos].Ofertas[0].OfertaAdjud='S';
	arrProductos[Pos].Ofertas[0].CANTIDADADJUDICADA=arrProductos[Pos].Cantidad;

	arrProductos[Pos].CantidadPendiente=0;
	
	//10jul22 no hace falta, ya se redibujara la tabla completa jQuery("#ADJUD_"+arrProductos[Pos].Ofertas[0].ID).prop("checked",true);	

	for (var i=1;i<arrProductos[Pos].Ofertas.length;++i)
	{
		//solodebug debug('SeleccionaMejorOferta. ['+Pos+'] Desactivar:'+arrProductos[Pos].Ofertas[i].ID);

		arrProductos[Pos].Ofertas[i].OfertaAdjud='N';
		arrProductos[Pos].Ofertas[i].CANTIDADADJUDICADA='';
		
		//10jul22 no hace falta, ya se redibujara la tabla completa jQuery("#ADJUD_"+arrProductos[Pos].Ofertas[i].ID).prop("checked",false);
		//10jul22 no hace falta, ya se redibujara la tabla completa jQuery("#CANTADJUD_"+arrProductos[Pos].Ofertas[i].ID).val('');
	}
	
	//solodebug	console.log('SeleccionaMejorOferta ('+PosProd+'). IDOferta:'+IDOferta);		
}


//	16jun22 Cuenta el total de productos seleccionados
function CuentaSeleccionados()
{
	var Sel=0;
	for (var i=0;i<arrProductos.length;++i)
	{
		if (arrProductos[i].Seleccionadas>0) ++Sel;

		//solodebug debug('CuentaSeleccionados. ['+i+'] Selec.:'+arrProductos[i].Seleccionadas+' Tot:'+Sel);
	}
	return Sel;
}


//	16jun22 Cuenta el total de productos modificados
function CuentaModificados()
{
	var Mod=0;
	for (var i=0;i<arrProductos.length;++i)
	{
		if (arrProductos[i].Cambios=='S') ++Mod;

		//solodebug debug('CuentaModificados. ['+i+'] Cambios:'+arrProductos[i].Cambios+' Tot:'+Mod);
		
	}
	return Mod;
}


//	16jun22 Actualiza el contador de seleccionados junto al carrito
function ActualizarContador()
{
	var Sel=CuentaSeleccionados();
	jQuery("#aContador").html(Sel);
	
	if (Sel==arrProductos.length+1)
	{
		jQuery("#aContador").removeClass('fondoRojo').addClass('fondoAzul');	
	}
	else
	{
		jQuery("#aContador").removeClass('fondoAzul').addClass('fondoRojo');	
	}
}


/*
	D A T O S    G E N E R A L E S
*/

//	21jun22 Guarda los datos de la pestanna "Datos Generales"-->LicDatosGeneralesAjax.xsql
function GuardarDatosGenerales()
{
	oForm=document.forms["frmDatosGenerales"];
	var msgError='',errores=0;
	var hoy = new Date(), hoyOrd=hoy.getFullYear()*10000+(hoy.getMonth()+1)*100+hoy.getDate();			//	Este formato es m�s eficiente para comparar fechas
	
	jQuery("#btnGuardarDatosGenerales").hide();

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

		if(!errores && (oForm.elements['LIC_MESES'].value==0) && ((fechaPed<hoyOrd+1)||(fechaPed<fechaDec+1)))
		{
			errores++;
			//alert(val_FechaDecisionAntigua);
			msgError+=val_FechaPedidoAntigua+'\n';
			oForm.elements['LIC_FECHAENTREGAPEDIDO'].focus();
		}

	}

	if(jQuery("#LIC_FECHAADJUDICACION").length){
		if(!esNulo(oForm.elements['LIC_FECHAADJUDICACION'].value)){
			if(CheckDate(oForm.elements['LIC_FECHAADJUDICACION'].value)){
				errores++;
				//alert(val_malFechaAdjudic);
				msgError+=val_malFechaAdjudic+'\n';
				oForm.elements['LIC_FECHAADJUDICACION'].focus();
			}else{
				if((oForm.elements['LIC_MESES'].value!=0)&&(comparaFechas(oForm.elements['LIC_FECHADECISION'].value, oForm.elements['LIC_FECHAADJUDICACION'].value) == '>')){
					errores++;
					//alert(val_malFechaAdjudic2.replace('[[FECHA_ADJUDICACION]]', oForm.elements['LIC_FECHAADJUDICACION'].value).replace('[[FECHA_DECISION]]', oForm.elements['LIC_FECHADECISION'].value));
					msgError+=val_malFechaAdjudic2.replace('[[FECHA_ADJUDICACION]]', oForm.elements['LIC_FECHAADJUDICACION'].value).replace('[[FECHA_DECISION]]', oForm.elements['LIC_FECHADECISION'].value)+'\n';
					oForm.elements['LIC_FECHAADJUDICACION'].focus();
				}
			}
		}
	}

	if((esNulo(oForm.elements['LIC_DESCRIPCION'].value))){
		errores++;
		//alert(val_faltaDescripcion);
		msgError+=val_faltaDescripcion+'\n';
		oForm.elements['LIC_DESCRIPCION'].focus();
	}
	
	if (msgError!='')
	{
		alert(msgError);
		return;
	}
	
	var Continua=oForm.elements['LIC_CONTINUA'].value,
		Urgente=oForm.elements['LIC_URGENTE'].value, 
		DatProv=(jQuery('#LIC_SOLICDATOSPROV').length)?oForm.elements['LIC_SOLICDATOSPROV'].value:'N', 
		Multiopc=oForm.elements['LIC_MULTIOPCION'].value,
		FreteObli=oForm.elements['LIC_MULTIOPCION'].value,
		PagoAplzObli=oForm.elements['LIC_PAGOAPLAZODOOBLIGATORIO'].value,
		PreciObjEstr=oForm.elements['LIC_PRECIOOBJETIVOESTRICTO'].value;
	
	//	Continua
	if ((jQuery('#CHK_LIC_CONTINUA').length) && (oForm.elements['CHK_LIC_CONTINUA'].checked))
		Continua='S';

	//	Licitaci�n urgente
	if ((jQuery('#CHK_LIC_URGENTE').length) && (oForm.elements['CHK_LIC_URGENTE'].checked))
		Urgente='S';

	//	Solicitar datos proveedores
	if ((jQuery('#CHK_LIC_SOLICDATOSPROV').length) && (oForm.elements['CHK_LIC_SOLICDATOSPROV'].checked))
		DatProv='S';

	//	Multiopcion
	if ((jQuery('#CHK_LIC_MULTIOPCION').length) && (oForm.elements['CHK_LIC_MULTIOPCION'].checked))
		Multiopc='S';		

	//	Frete CIF obligatorio
	if ((jQuery('#CHK_LIC_FRETECIFOBLIGATORIO').length) && (oForm.elements['CHK_LIC_FRETECIFOBLIGATORIO'].checked))
		FreteObli='S';

	//	Pago a plazo oblig
	if ((jQuery('#CHK_LIC_PAGOAPLAZODOOBLIGATORIO').length) && (oForm.elements['CHK_LIC_PAGOAPLAZODOOBLIGATORIO'].checked))
		PagoAplzObli='S';

	//	17jun20
	if ((jQuery('#CHK_LIC_PRECIOOBJETIVOESTRICTO').length) && (oForm.elements['CHK_LIC_PRECIOOBJETIVOESTRICTO'].checked))
		PreciObjEstr='S';

	Params='LIC_ID='+IDLicitacion
				+'&LIC_TITULO='+encodeURIComponent(ScapeHTMLString(oForm.elements['LIC_TITULO'].value))
				+'&LIC_DESCRIPCION='+encodeURIComponent(ScapeHTMLString(oForm.elements['LIC_DESCRIPCION'].value))
				+'&LIC_CONDENTREGA='+encodeURIComponent(ScapeHTMLString(oForm.elements['LIC_CONDENTREGA'].value))
				+'&LIC_CONDPAGO='+encodeURIComponent(ScapeHTMLString(oForm.elements['LIC_CONDPAGO'].value))
				+'&LIC_CONDOTRAS='+encodeURIComponent(ScapeHTMLString(oForm.elements['LIC_CONDOTRAS'].value))
				+'&LIC_MESES='+oForm.elements['LIC_MESES'].value
				+'&LIC_PORPRODUCTO='+oForm.elements['LIC_PORPRODUCTO'].value
                +'&LIC_IDUSUARIOPEDIDO='+oForm.elements['LIC_IDUSUARIOPEDIDO'].value
                +'&LIC_IDLUGARENTREGA='+oForm.elements['LIC_IDLUGARENTREGA'].value
                +'&LIC_CODIGOPEDIDO='+encodeURIComponent(ScapeHTMLString(oForm.elements['LIC_CODIGOPEDIDO'].value))
                +'&LIC_OBSPEDIDO='+encodeURIComponent(ScapeHTMLString(oForm.elements['LIC_OBSPEDIDO'].value))
                +'&LIC_IDFORMAPAGO='+oForm.elements['LIC_IDFORMAPAGO'].value
                +'&LIC_IDPLAZOPAGO='+oForm.elements['LIC_IDPLAZOPAGO'].value
				+'&LIC_FECHAADJUDICACION='+((jQuery('#LIC_FECHAADJUDICACION').length)?encodeURIComponent(ScapeHTMLString(oForm.elements['LIC_FECHAADJUDICACION'].value)):'')
				+'&LIC_CONTINUA='+Continua
				+'&LIC_URGENTE='+Urgente
				+'&LIC_SOLICDATOSPROV'+DatProv
				+'&LIC_MULTIOPCION='+Multiopc
				+'&LIC_IDDOCUMENTO='+oForm.elements['LIC_IDDOCUMENTO'].value
				+'&LIC_FECHAENTREGAPEDIDO='+oForm.elements['LIC_FECHAENTREGAPEDIDO'].value
				+'&LIC_FRETECIFOBLIGATORIO='+FreteObli
				+'&LIC_PAGOAPLAZODOOBLIGATORIO='+PagoAplzObli
				+'&LIC_PRECIOOBJETIVOESTRICTO='+PreciObjEstr
				+"&_="+hoy.getTime();


	debug('GuardarDatosGenerales:'+Params);
	jQuery.ajax({
		cache:	false,
		url:	'http://www.newco.dev.br/Gestion/Comercial/LicDatosGeneralesAjax.xsql',
		type:	"GET",
		data:	Params,
		contentType: "application/xhtml+xml",
		success: function(objeto){
			var data = JSON.parse(objeto);

			if(data.Estado == 'OK')
			{
				alert("Guardado OK");
				jQuery("#btnGuardarDatosGenerales").show();
            }
			else
			{
				alert("Se ha producido un error");
				error=true;
				jQuery("#btnGuardarDatosGenerales").show();
			}
		},
		error: function(xhr, errorString, exception) {
			alert("xhr.status="+xhr.status+" error="+errorString+" exception="+exception);
			jQuery("#btnGuardarDatosGenerales").show();
		}
	});


}


/*
	R E S U M E N
*/

//	22jun22 Guarda los datos del informe de la licitacion
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
			var data = JSON.parse(objeto);

			if(data.Resultado == 'OK'){
				alert(alrt_guardarDatosInformeOK);
			}else{
				alert(alrt_guardarDatosInformeKO);
			}
		}
	});
}


/*
			I N F O R M E S
*/

//	22jun22 abre el informe en pop-up
function Informe(ficInforme,NombreInforme)
{
	MostrarPagPersonalizada('http://www.newco.dev.br/Gestion/Comercial/'+ficInforme+'LIC_ID='+IDLicitacion,NombreInforme,70,70,0,0);
}


/*
			U S U A R I O S
*/

//	22jun22 Incluye un nuevo usuario en la licitacion
function AnadirUsuario(oForm){
	var oForm			=document.forms['frmUsuarios'];
	var IDUsuarioFirm	= oForm.elements['LIC_IDUSUARIO'].value;
    var Firma           = (oForm.elements['LIC_USU_FIRMA'].checked) ? 'S': 'N';
	var Perfil			= (oForm.elements['LIC_USU_COAUTOR'].checked) ? 'COAUTOR': '';

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
			var data = JSON.parse(objeto);

			if(data.NuevoUsuario.estado == 'OK'){
				//	Quita el usuario del desplegable
				jQuery("#LIC_IDUSUARIO option:selected").remove();
				
				//	Actualiza la tabla de usuarios
				recuperaUsuarios();
            }else if(data.NuevoUsuario.estado == 'USUARIO_YA_EXISTE'){
				alert(alrt_UsuarioYaExiste);
			}else{
				alert(alrt_NuevoUsuarioKO);
			}
		}
	});
}

//	Macros para montar la tabla de usuarios de forma dinamica
var filaUsuario='<tr class="conhover"><td class="color_status"></td>'
                  +'<td class="textLeft">[AUTOR][NOMBRE]</td>'
                   +'<td>[FECHA_ALTA]</td>'
                   +'<td class="textLeft">[ESTADO]</td>'
                   +'<td>[FECHA_MODIF]</td>'
                   +'<td class="textLeft">[COMENT]</td>'
                   +'<td>[BORRAR]</td>'
                  +'<td>[FIRMAR]</td>'
                +'</tr>';

var Autor='<span class="amarillo"><strong>[TXT_AUTOR]</strong></span>&nbsp;';
var Borrar='<a class="accBorrar" href="javascript:modificaUsuario([LIC_USU_ID],\'B\');"><img src="http://www.newco.dev.br/images/2022/icones/del.svg"></a>';
var Firmar='<a href="javascript:modificaUsuario([LIC_USU_ID], \'FIRM\');"><img src="http://www.newco.dev.br/images/firmar.gif"/></a>';

function recuperaUsuarios(){

	var htmlAutor=Autor.replace('[TXT_AUTOR]',str_Autor);

	var d = new Date();
	jQuery.ajax({
		cache:	false,
		url:	'http://www.newco.dev.br/Gestion/Comercial/RecuperaUsuarios.xsql',
		type:	"GET",
		data:	"LIC_ID="+IDLicitacion+"&ROL=COMPRADOR&IDIOMA="+IDIdioma+"&_="+d.getTime(),
		contentType: "application/xhtml+xml",
		error: function(objeto, quepaso, otroobj){
			alert('error'+quepaso+' '+otroobj+' '+objeto);
		},
		success: function(objeto){
			var data = JSON.parse(objeto);

			if(data.ListaUsuarios.length > 0){
				jQuery("#tbUsuarios tbody").empty();

				var bodyUs='';
				jQuery.each(data.ListaUsuarios, function(key, usuario){
					var fila=filaUsuario;

					//solodebug	console.log('recuperaUsuarios (inicio fila):'+fila+ ' Nombre:'+usuario.Nombre);
					
					if (usuario.Autor == 'S')
						fila=fila.replace('[AUTOR]',htmlAutor);
					else
						fila=fila.replace('[AUTOR]','');
						
						
					fila=fila.replace('[NOMBRE]',usuario.Nombre);				
					fila=fila.replace('[FECHA_ALTA]',usuario.FechaAlta);	
					fila=fila.replace('[ESTADO]',usuario.Estado);	
					fila=fila.replace('[FECHA_MODIF]',usuario.FechaModificacion);	
					fila=fila.replace('[COMENT]',usuario.Comentarios);
						
					if(IDUsuario == usuario.ID){
						fila=fila.replace('[BORRAR]','');
					}else if((esAutor == 'S')&&(data.ListaUsuarios.length > 1)){
						fila=fila.replace('[BORRAR]',Borrar.replace('[LIC_USU_ID]',usuario.IDUSUARIO_LIC));
					}else{
						fila=fila.replace('[BORRAR]','');
					}

					//	REVISAR al reactivar las firmas
					if (liciFirmada != '' || IDLicitacion == 'FIRM'){
						fila=fila.replace('[FIRMAR]',Firmar.replace('[LIC_USU_ID]',usuario.IDUSUARIO_LIC));
					}
					else
						fila=fila.replace('[FIRMAR]','');
						
					bodyUs+=fila;
					//solodebug	console.log('recuperaUsuarios (fin fila):'+fila);
				});
				
				jQuery("#tbUsuarios tbody").append(bodyUs);


			}else{
				jQuery("#tbUsuarios tbody").empty().append('<tr><td class="color_status"></td><td align="center" colspan="7"><strong>' + str_SinUsuarios + '</strong></td></tr>');
			}
		}
	});
}

//	Cambia el estado del usuario
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
			var data = JSON.parse(objeto);

			if(data.ModificaEstadoUsuario.estado == 'OK'){
				if(Estado == 'FIRM'){
					//24jun22	if (window.opener !== null && !window.opener.closed){
					//24jun22		opener.location.reload();	// Recarga de la pagina padre para actualizar el estado de la licitacion
					//24jun22	}
					alert(alrt_licitacionFirmada + ' PENDIENTE RECUPERAR ESTADO!');
					//Recarga();	//23jul19	location.reload();
					return;
				}

				recuperaUsuarios();
			}else{
				alert(alrt_EliminarUsuarioKO);
			}

		}
	});
}



/*
	
		C E N T R O S

*/
function AnadirCentro(){
	var oForm	 =document.forms["frmCentros"];
	var IDCentro =oForm.elements['LIC_IDCENTRO'].value;
	var d = new Date();

	if (oForm.elements['LIC_IDCENTRO'].value < 1 || oForm.elements['LIC_IDCENTRO'].value == '')
	{
		alert(val_faltaCentro);
		oForm.elements['LIC_IDCENTRO'].focus();
		return;
	}

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
				recuperaUsuarios();	//	12jul16	Al insertar centros, tambi�n insertamos sus usuarios
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


//	Macros para montar la tabla de centros de forma dinamica
var filaCentro='<tr class="conhover"><td class="color_status">&nbsp;</td>'
				  +'<td>&nbsp;</td>'
                  +'<td class="textLeft">[NOMBRE_CORTO]</td>'
                  +'<td class="textLeft">[NOMBRE]</td>'
                  +'<td class="textLeft">[ESTADO]</td>'
                  +'<td>[BORRAR]</td>'
                +'</tr>';

var Borrar='<a class="accBorrar" href="javascript:borrarCentro([IDCENTROLIC],[IDCENTRO]);"><img src="http://www.newco.dev.br/images/2022/icones/del.svg"></a>';

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
			var data = JSON.parse(objeto);

			if(data.ListaCentros.length > 0){
				jQuery("#lCentros_EST tbody").empty();
				NumCentrosEnLicitacion=0;

				jQuery.each(data.ListaCentros, function(key, centro){
					var tbodyCentro = filaCentro;
					tbodyCentro=tbodyCentro.replace('[NOMBRE_CORTO]', centro.NombreCorto);
					tbodyCentro=tbodyCentro.replace('[NOMBRE]', centro.Nombre);
					tbodyCentro=tbodyCentro.replace('[ESTADO]', centro.Estado);

					if((EstadoLic == 'EST')||(EstadoLic == 'CURS')||(EstadoLic == 'COMP')||(EstadoLic == 'INF'))
					{
						var htmlBorrar=Borrar.replace("[IDCENTROLIC]",centro.Licc_ID).replace("[IDCENTRO]", centro.IDCentro);
						tbodyCentro=tbodyCentro.replace("[BORRAR]",htmlBorrar);
 					}else{
						tbodyCentro=tbodyCentro.replace("[BORRAR]","");
					}
					jQuery("#lCentros_EST tbody").append(tbodyCentro);
					
					NumCentrosEnLicitacion++;		//	Actualizamos el contador de centros

				});
			}else{
				jQuery("#lCentros_EST tbody").empty().append("<tr><td colspan='5'><strong>" + str_SinCentros + "</strong></td></tr>");
			}
		}
	});
}


//	Eliminar un centro de la licitacion
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
			var data = JSON.parse(objeto);

			if(data.BorrarCentro.estado == 'OK')
			{
				recuperaCentros();
			}
			else
			{
				alert(alrt_EliminarCentroKO);
			}

		}
	});
}


/*
	ACCIONES PARA ESTUDIO PREVIO
*/

// Comprueba que la licitacion esta lista para poder iniciarla
function IniciarLicitacion(IDEstado){

	var Mensaje=alrt_NoIniciarLicitacion+'\n\r\n\r', errores=0;

	//	6oct17	Forzamos revisi�n de productos informados, m�s seguro que hace el control en cada modificaci�n
	//	13oct17	Incluimos un mensaje por error encontrado
	//prodsInformados = 'S';
	for (j=0;j<arrProductos.length;++j)		// && (prodsInformados=='S')
	{
		//	solodebug	debug('IniciarLicitacion. Comprobando producto:'+j+' Ud.Basica:'+arrProductos[j].UdBasica+' Cant:'+arrProductos[j].Cantidad);
		
		if ((arrProductos[j].UdBasica === undefined) || (arrProductos[j].UdBasica == '')) 
		{
			//prodsInformados='N';
			++errores;
			Mensaje+=arrProductos[j].Nombre.substring(0, 50)+': '+alrt_UdBasicaNoInformada+'\n';
		}
	
		if ((arrProductos[j].Cantidad === undefined) || (parseFloat(arrProductos[j].Cantidad)<=0))
		{
			//prodsInformados='N';
			++errores;
			Mensaje+=arrProductos[j].Nombre.substring(0, 50)+': '+alrt_CantidadCero+'\n';
		}
	}

	if(arrProveedores.length == '0')
	{
		++errores;
		Mensaje+=alrt_NoIniciarLicProvs;
	}
	if (isLicAgregada == 'S' && NumCentrosEnLicitacion==0)
	{
		++errores;
		Mensaje+=alrt_NoIniciarLicCentros;
	}

	if (errores==0)
		CambioEstadoLicitacion(IDEstado);
	else
		alert(Mensaje+'\n\r\n\r');

}


//	Agregar licitacion a la actual
function AgregarLicitacion()
{
	var IDLicitacionSec=jQuery("#LICITACIONES_EST").val(),
		LicitacionSec=jQuery("#LICITACIONES_EST option:selected").text();
	if (confirm(alrt_AgregarLicitacion.replace("[[LICITACION]]",LicitacionSec.trim().replace(/\n/g,"").replace(/\[/g,"").replace(/\]/g,""))))
	{
		document.forms['form1'].action="http://www.newco.dev.br/Gestion/Comercial/MantLicitacionAcciones2022.xsql?ACCION=AGREGARLIC&LIC_ID="+IDLicitacion+'&IDLICITACIONSEC='+IDLicitacionSec;
		SubmitForm(document.forms['form1']);
	}
}


// 2dic20 Env�a la licitaci�n al GESTOR para que se ocupe de la misma
function EnviarGestor()
{
	CambioEstadoLicitacion('EST');	
}


// Cambiamos estado de la licitacion, ya sea pq se inicia ('EST' => 'CURS') 16ago16:('EST' => 'COMP') ('COMP' => 'CURS')
// Ya sea pq se adjudica ('CURS' => 'ADJ' o 'INF' => 'ADJ')
function CambioEstadoLicitacion(IDEstado){
	var Comentarios	= '', IDProveedor = '';
	var d = new Date();
	var	enviarCambio = true;
	
	//	En el caso de licitaci�n agregada, comprobamos si hay centros pendientes antes de iniciar
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
					location.href = 'http://www.newco.dev.br/Gestion/Comercial/LicitacionV2_2022.xsql?LIC_ID=' + IDLicitacion;
				}else{
					alert(alrt_NuevoEstadoLicKO);
				}
			}
		});
	}
}



//	Ordenacion utilizado al informar compra por centro
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


//	Al cambiar la seleccion del centro para informar compras recargamos la licitacion 
function CargarDatosComprasCentro()
{
	recuperaDatosCompraPorCentro();
}
 

//	Recuperamos los datos de compras del centro seleccionado
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


//
//	para depuracion unicamente
//
function VuelcaArrayProductos(pos)
{
	var msg='';
	for (var i=0; i<arrProductos.length;++i)
	{
		msg+=(((pos!=-1)&&(i==pos))?'****':'') +'Producto ('+i+'):'+arrProductos[i].RefCliente+':'+arrProductos[i].Nombre;
		
		for (var j=0;j<arrProductos[i].Ofertas.length;++j)
		{
			msg+='. Oferta('+j+').:'+arrProductos[i].Ofertas[j].ID+((arrProductos[i].Ofertas[j].OfertaAdjud=='S')?' ADJ':'');
		}
		
		msg+='.\n';
	}
	return msg;
}


