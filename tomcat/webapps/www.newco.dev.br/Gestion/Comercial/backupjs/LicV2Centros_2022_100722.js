//	Funciones JS para la nueva version de la licitacion. BLOQUE CENTROS.
//	Ultima revisión ET 12jul22 11:07 LicV2Centros_2022_100722.js

var lineaInicio='<span class="floatRight marginRight50"><a class="btnDestacado" href="javascript:cerrarTablaCentros([POSPROD]);">'+strGuardar+'+'+strCerrar+'</a>&nbsp;<a class="btnNormal" href="javascript:salirTablaCentros([POSPROD]);">'+strCerrar+'</a></span>'
				+'<div class="div_coluna_tabela_filiais w100">'
				+'<div class="tabela tabela_filiais w100" id="divTablaContCentros">'


var lineaCabecera=	'<table id="tblCentrosYProveedores" cellspacing="10px" cellpadding="10px" class="w1200px tableCenter">'
					+'	<thead class="cabecalho_tabela_filiais">'
					+'		<tr>'
					+'		<th></th>'
					+'		<th class="textLeft">'+strCentro+'</th>'
					+'		<th class="textLeft">'+strProveedor+' ('+strMarca+')</th>'
					+'		<th class="textCenter">'+strEmpaq+'</th>'
					+'		<th class="textCenter">'+strCantidad+'</th>'
					+'		</tr>'
					+'	</thead>'
					+'	<tbody class="corpo_tabela">';

var lineaDatosCentro='<tr>'
					+'<td>[LINEA]</td>'
					+'<td class="textLeft">[NOMBRE_CENTRO]</td>'
					+'<td></td>'
					+'<td></td>'
					+'<td><input type="hidden" name="CantidadAnt_[IDCENTRO]" id="CantidadAnt_[IDCENTRO]" value="[CANTIDAD_SF]"><input name="Cantidad_[IDCENTRO]" id="Cantidad_[IDCENTRO]" value="[CANTIDAD_SF]" class="campopesquisa w100px cantidad" maxlength="8" type="text"/></td>'// onKeyUp="javascript:chCantidadCentro([IDCENTRO])"
					+'</tr>';
					
var lineaDatosProv=	'<tr>'
					+'<td>[LINEA]</td>'
					+'<td></td>'
					+'<td class="textLeft">[NOMBRE_PROV] <span class="fuentePeq">([MARCA])</span></td>'
					+'<td>[UDES_LOTE]</td>'
					+'<td><input type="hidden" name="CantidadAnt_[IDCENTRO]_[IDOFERTA]" id="CantidadAnt_[IDCENTRO]_[IDOFERTA]" value="[CANTIDAD_SF]"><input name="Cantidad_[IDCENTRO]_[IDOFERTA]" id="Cantidad_[IDCENTRO]_[IDOFERTA]" value="[CANTIDAD_SF]"  class="campopesquisa w100px cantidad" maxlength="8" type="text"/></td>'// onKeyUp="javascript:chCantidadCentroYProv([IDCENTRO],[IDOFERTA])"
					+'</tr>';

var lineaFoot=	'</tbody>'
				+'	<tfoot class="rodape_cotacao">'
				+'		<tr><td colspan="7"></td></tr>'
				+'	</tfoot>'
				+'</table>'
				+'</div>'
				+'</div>'
				;


//	Array para facilitar el uso de la tabla de centros				
var arrTablaCentros;
var hayCambios='N';
				
//	11jul22 Abre la tabla de centros				
function tablaCentros(Pos)
{
	//solodebug debug('tablaCentros:'+Pos);
	
	var html=lineaInicio.replaceAll('[POSPROD]',Pos);
   	jQuery('#divWindowContCentros').html(html);
	

	html=lineaCabecera;
	
	arrTablaCentros=new Array();
	
	//	Recorre los centros
	for (var i=0;i<arrProductosPorCentro[Pos].Centros.length;++i)
	{
		var linCentro=lineaDatosCentro;
		linCentro=linCentro.replace('[LINEA]',(i+1)/*+'[PROVISIONAL:'+arrProductosPorCentro[Pos].RefEstandar+']'*/);
		linCentro=linCentro.replaceAll('[POSPROD]',Pos);
		linCentro=linCentro.replace('[NOMBRE_CENTRO]',arrProductosPorCentro[Pos].Centros[i].Centro);
		//linCentro=linCentro.replace('[POSCENTRO]',i);
		linCentro=linCentro.replaceAll('[IDCENTRO]',arrProductosPorCentro[Pos].Centros[i].IDCentro);
		// Cantidad DEL CENTRO Y PROVEEDOR
		linCentro=linCentro.replaceAll('[CANTIDAD_SF]',arrProductosPorCentro[Pos].Centros[i].CantidadSF);
		html+=linCentro;
		
		var centro	= [];
		centro['IDCentro']	= arrProductosPorCentro[Pos].Centros[i].IDCentro;
		centro['Centro']= arrProductosPorCentro[Pos].Centros[i].Centro;
		centro['Marcas']= arrProductosPorCentro[Pos].Centros[i].Marcas;
		centro['Cantidad']= arrProductosPorCentro[Pos].Centros[i].Cantidad;
		centro['CantidadSF']= arrProductosPorCentro[Pos].Centros[i].CantidadSF;
		centro['RefCentro']	= arrProductosPorCentro[Pos].Centros[i].RefCentro;
		centro['Proveedores']	= [];
		
		//	Recorre los proveedores con oferta para este producto
		
		for (var j=0;j<arrProductos[Pos].Ofertas.length;++j)
		{
			var linProv=lineaDatosProv;
			linProv=linProv.replace('[LINEA]',(i+1)+'.'+(j+1));
			linProv=linProv.replaceAll('[POSPROD]',Pos);
			linProv=linProv.replaceAll('[IDCENTRO]',arrProductosPorCentro[Pos].Centros[i].IDCentro);
			linProv=linProv.replaceAll('[IDOFERTA]',arrProductos[Pos].Ofertas[j].ID);
			linProv=linProv.replace('[IDPROVEEDORLIC]',arrProductos[Pos].Ofertas[j].IDPROVEEDORLIC);
			linProv=linProv.replace('[NOMBRE_PROV]',arrProductos[Pos].Ofertas[j].PROVEEDOR);
			linProv=linProv.replace('[MARCA]',arrProductos[Pos].Ofertas[j].MARCA);
			linProv=linProv.replace('[UDES_LOTE]',arrProductos[Pos].Ofertas[j].UNIDADESPORLOTE);

			var Proveedor	= [];
			Proveedor['PosOferta']	= j;	//	Aunque sea la misma "j" lo informamos en una columna por si mas adelante hay que cambiar el orden
			Proveedor['IDOfertaLic']	= arrProductos[Pos].Ofertas[j].ID;
			Proveedor['IDProvLic']	= arrProductos[Pos].Ofertas[j].IDPROVEEDORLIC;
			Proveedor['IDProveedor']	= arrProductos[Pos].Ofertas[j].IDPROVEEDOR;
			Proveedor['Proveedor']= arrProductos[Pos].Ofertas[j].PROVEEDOR;
			Proveedor['UdesLote']	= arrProductos[Pos].Ofertas[j].UNIDADESPORLOTE;

			/*var PosProv=-1;
			//	Comprueba que no se supere la cantidad a nivel de centro. Tenemos que utilizar arrProductosPorCentro en lugar de arrCentros
			for (var k=0;(k<arrProductosPorCentro[Pos].Centros[i].Proveedores.length)&&(PosProv==-1);++k)
			{
				debug('BuscaEnArray.Campo:'+Campo+' ID:'+ID);
				if (arrProductosPorCentro[Pos].Centros[i].Proveedores[k].IDProvLic==arrProductos[Pos].Ofertas[j].IDPROVEEDORLIC) PosProv=k;
			}*/
			
			var PosProv=BuscaEnArray(arrProductosPorCentro[Pos].Centros[i].Proveedores, 'IDProvLic', arrProductos[Pos].Ofertas[j].IDPROVEEDORLIC);
			if (PosProv>=0)
				Proveedor['CantidadSF']	=arrProductosPorCentro[Pos].Centros[i].Proveedores[PosProv].CantidadSF;
			else
				Proveedor['CantidadSF']	=0;
				
			//solodebug debug('tablaCentros.Centro:'+arrProductosPorCentro[Pos].Centros[i].Centro+' Prov:'+Proveedor['Proveedor']+' Cant:'+Proveedor['CantidadSF']);

			//Proveedor['Cantidad']	=Proveedor['CantidadSF'];
			Proveedor['CantidadAntSF']=Proveedor['CantidadSF'];
			linProv=linProv.replaceAll('[CANTIDAD_SF]',Proveedor['CantidadSF']);
			html+=linProv;
			
			centro['Proveedores'].push(Proveedor);

		}
		arrTablaCentros.push(centro);
		
	}
	html+=lineaFoot;

	//solodebug debug('tablaCentros:'+Pos+'. HTML:\n'+html);
	
   	jQuery('#divTablaContCentros').html(html);
	containerCentros(true);
	
	//solodebug	VuelcaTablaCentros()
}

//	11jul22 Muestra u oculta el container de centros
function containerCentros(mostrar)
{
	//12jul22 Sustituimos showTablaByID('divContCentros') para mostrar el div en la parte superior de la tabla de productos
	jQuery("#divContCentros").fadeIn(function(){
		window.setTimeout(function(){
			jQuery('.window-container').addClass('window-container-visible');
		}, 100);
	});
	
}


/*
//	12jul22 Cambio de la cantidad por centro
function chCantidadCentro(IDCentro)
{
	hayCambios='S';
	jQuery(".resultado").html('');				//	Quita el icono de guardado/error
	jQuery('#btnCantidad_'+IDCentro).show();
}

//	12jul22 Cambio de la cantidad por centro y proveedor
function chCantidadCentroYProv(IDCentro, IDProveedor)
{
	hayCambios='S';
	jQuery(".guardarOferta").hide();			//	Oculta botones de guardar oferta
	jQuery(".resultado").html('');				//	Quita el icono de guardado/error
	jQuery('#btnCantidad_'+IDCentro+'_'+IDProveedor).show();
}


// Funcion para guardar la cantidad de compra de un centro para un producto
function guardarDatosCompraCentro(PosProd, IDCentro){
	// Validaciones

	//No podemos utilizar un form, quedaria anidado y da problemas	var oform=document.forms["cantidadPorCentro"];
	
	var errores = 0;

	// Validacion Cantidad
	//var cantidad	= oform['Cantidad_'+IDCentro].value;
	var cantidad	= jQuery('#Cantidad_'+IDCentro).val();
	
	var cantidadSF	= cantidad.replace(",",".");
	if(!errores && esNulo(cantidadSF)){
		errores++;
		alert(val_faltaCantidad.replace("[[REF]]",RefCliente));
		return;
	}else if(!errores && isNaN(cantidadSF)){
		errores++;
		alert(val_malCantidad.replace("[[REF]]",RefCliente));
	}
	if(!errores){

		var d = new Date();

		jQuery.ajax({
			cache:	false,
			url:	'http://www.newco.dev.br/Gestion/Comercial/InformarDatosCOmpraAJAX.xsql',
			type:	"GET",
			data:	"LIC_ID="+IDLicitacion+"&LIC_PROD_ID="+arrProductos[PosProd].IDProdLic+"&IDCENTRO="+IDCentro+"&CANTIDAD="+cantidad+"&_="+d.getTime(),
			beforeSend: function(){
				//jQuery("#BtnActualizarOfertas").hide();
				jQuery(".guardarCant").hide();
			},
			error: function(objeto, quepaso, otroobj){
				jQuery('#Resultado_'+IDCentro).html('<img src="http://www.newco.dev.br/images/error.gif"/>');
				alert('error'+quepaso+' '+otroobj+' '+objeto);
			},
			success: function(objeto){
				var data = eval("(" + objeto + ")");

				if(data.OfertaActualizada.IDOferta > 0){
					jQuery('#Resultado_'+IDCentro).html('<img src="http://www.newco.dev.br/images/recibido.gif"/>');
					
					var PosCentro=BuscaCentro(PosProd, IDCentro);
					arrProductosPorCentro[PosProd].Centros[PosCentro].CantidadSF=parseFloat(cantidadSF);
					//recalcularCompraCentro(PosProd, IDCentro, parseFloat(cantidadSF))
					
				}else{
					jQuery('#Resultado_'+IDCentro).html('<img src="http://www.newco.dev.br/images/error.gif"/>');
				}
			}
		});
	}

	//jQuery("#BtnActualizarOfertas").show();
	jQuery(".cantidad").show();

}
*/

/*
//12jul22 Recalcula los arrays a partir de los cambios introducidos en los centros y proveedores
function recalcularCompraCentro(PosProd, IDCentro, cantidad)
{					
	debug('recalcularCompraCentro. PosProd:'+PosProd+' IDCentro:'+IDCentro+' cantidad:'+cantidad);

	var PosCentro=BuscaCentro(PosProd, IDCentro);

	//	Recupera la cantidad original
	var cantOrig=jQuery('#CantidadAnt_'+IDCentro).val();

	debug('recalcularCompraCentro. PosProd:'+PosProd+' IDCentro:'+IDCentro+' PosCentro:'+PosCentro+' cantidad:'+cantidad+' cantOrig:'+cantOrig);
	
	

	//	Array productos: actualizar cantidades si se han cambiado
						
	
	//	Subarray de ofertas
	
	
	//	Array de compras por centro
	
	
	
	//	Array de proveedores
	
	alert("Pendiente recalcular!");

}
*/



/*
// Funcion para guardar la cantidad de compra de un centro a un proveedor
function guardarDatosCompraCentroYProv(PosProd, IDCentro, IDOfertaLic, IDProveedorLic){
	// Validaciones
	//No podemos utilizar un form, quedaria anidado y da problemas	var oform=document.forms["cantidadPorCentro"];
	
	var errores = 0, Total=0, cantidades='';
	
	var PosCentro=BuscaCentro(PosProd, IDCentro);

	debug('guardarDatosCompraCentroYProv('+PosProd+','+IDCentro+','+IDOfertaLic+','+IDProveedorLic+'). NumProv:'+arrProductosPorCentro[PosProd].Centros[PosCentro].Proveedores.length);

	//	Calcula cantidad, comprueba empaquetamiento y no superar el total del centro.
	for (i=0;(i<arrProductos[PosProd].Ofertas.length);++i)
	{

		debug('guardarDatosCompraCentroYProv('+PosProd+','+IDCentro+','+IDOfertaLic+','+IDProveedorLic+'). Revisando cantidades. IDOfertaLic:'+arrProductos[PosProd].Ofertas[i].ID+' Cantidad:'+jQuery('#Cantidad_'+IDCentro+'_'+arrProductos[PosProd].Ofertas[i].ID).val());


		//var cantidadTxt	= oform['Cantidad_'+IDCentro+'_'+arrProductosPorCentro[PosProd].Centros[PosCentro].Proveedores[i].IDOfertaLic].value;
		var cantidadTxt	= jQuery('#Cantidad_'+IDCentro+'_'+arrProductos[PosProd].Ofertas[i].ID).val();
		var cantidadFormat	= cantidadTxt.replace(",",".");
		if(!errores && esNulo(cantidadFormat)){
			errores++;
			alert(arrProductosPorCentro[PosProd].Centros[PosCentro].Nombre+','+arrProductos[PosProd].Ofertas[i].Proveedor+':'+val_faltaCantidad.replace("[[REF]]",RefCliente));
			return;
		}else if(!errores && isNaN(cantidadFormat)){
			errores++;
			alert(arrProductosPorCentro[PosProd].Centros[PosCentro].Nombre+','+arrProductos[PosProd].Ofertas[i].Proveedor+':'+val_malCantidad.replace("[[REF]]",RefCliente));
			return;
		}
		
		var cantidad=parseInt(cantidadTxt);
		
		if (cantidad%arrProductos[PosProd].Ofertas[i].UNIDADESPORLOTE!=0)
		{
			errores++;
			
			var nuevaCantidad=arrProductos[PosProd].Ofertas[i].UNIDADESPORLOTE*Math.ceil(cantidad/arrProductos[PosProd].Ofertas[i].UNIDADESPORLOTE);
			
			alert(arrProductosPorCentro[PosProd].Centros[PosCentro].Centro+','+arrProductos[PosProd].Ofertas[i].PROVEEDOR+': La cantidad '+cantidad
					+' no corresponde al empaquetamiento:'+arrProductos[PosProd].Ofertas[i].UNIDADESPORLOTE
					+' cantidad corregida:'+nuevaCantidad);
			
			//oform['Cantidad_'+IDCentro+'_'+arrProductosPorCentro[PosProd].Centros[PosCentro].Proveedores[i].IDOfertaLic].value=nuevaCantidad;
			jQuery('#Cantidad_'+IDCentro+'_'+arrProductos[PosProd].Ofertas[i].ID).val(nuevaCantidad);

			Total+=nuevaCantidad;

			//return;
		}
		else
			Total+=cantidad;
		
		arrProductos[PosProd].Ofertas[i].CantAdjud=cantidadTxt;
		//arrProductosPorCentro[PosProd].Centros[PosCentro].Proveedores[i].CantidadSF=cantidad;
		
		cantidades+=arrProductos[PosProd].Ofertas[i].IDPROVEEDORLIC+'|'+arrProductos[PosProd].Ofertas[i].ID+'|'+arrProductos[PosProd].Ofertas[i].CantAdjud+'#';
		
		debug('guardarDatosCompraCentroYProv('+i+'). text:'+jQuery('#Cantidad_'+IDCentro+'_'+arrProductos[PosProd].Ofertas[i].ID).val()+' Total:'+Total+' listacantidades:'+cantidades);
		
	}
	
	if (Total>arrProductosPorCentro[PosProd].Centros[PosCentro].CantidadSF)
	{
		alert('La cantidad '+Total+ ' asignada a proveedores supera la cantidad total del centro:'+arrProductosPorCentro[PosProd].Centros[PosCentro].Cantidad);
		errores++;
	}

	if (Total<arrProductosPorCentro[PosProd].Centros[PosCentro].CantidadSF)
	{
		alert('La cantidad '+Total+ ' asignada a proveedores no cubre la cantidad total del centro:'+arrProductosPorCentro[PosProd].Centros[PosCentro].Cantidad);
		errores++;
	}
	
	if(!errores){
		var d = new Date();

		jQuery.ajax({
			cache:	false,
			url:	'http://www.newco.dev.br/Gestion/Comercial/InformarDatosCompraCentroYProvAJAX.xsql',
			type:	"GET",
			data:	"LIC_ID="+IDLicitacion+"&LIC_PROD_ID="+arrProductos[PosProd].IDProdLic+"&IDCENTRO="+IDCentro+"&CANTIDADES="+encodeURIComponent(cantidades)+"&_="+d.getTime(),
			beforeSend: function(){
				jQuery(".guardarOferta").hide();
			},
			error: function(objeto, quepaso, otroobj){
				jQuery('#Resultado_'+IDCentro+'_'+IDOfertaLic).html('<img src="http://www.newco.dev.br/images/error.gif"/>');
				alert('error'+quepaso+' '+otroobj+' '+objeto);
			},
			success: function(objeto){
				var data = eval("(" + objeto + ")");

				if(data.OfertaActualizada.Estado =='OK'){
					jQuery('#Resultado_'+IDCentro+'_'+IDOfertaLic).html('<img src="http://www.newco.dev.br/images/recibido.gif"/>');
					
					//ActualizarCentrosYProveedores();
					recalcularCompraCentroYProv(PosProd, IDCentro, IDOfertaLic, IDProveedorLic);
					
				}else{
					jQuery('#Resultado_'+IDCentro+'_'+IDOfertaLic).html('<img src="http://www.newco.dev.br/images/error.gif"/>');
				}
			}
		});
	}

}


//12jul22 Recalcula los arrays a partir de los cambios introducidos en los centros y proveedores
function recalcularCompraCentroYProv(PosProd, IDCentro, IDOfertaLic, IDProveedorLic)
{					
	debug('recalcularCompraCentroYProv. PosProd:'+PosProd+' IDCentro:'+IDCentro+' IDOfertaLic:'+IDOfertaLic+' IDProveedorLic:'+IDProveedorLic);
	
	//	Array productos: actualizar cantidades si se han cambiado
						
	
	//	Subarray de ofertas
	
	
	//	Array de compras por centro
	
	
	
	//	Array de proveedores
	
	alert("Pendiente recalcular!");

}
*/

//12jul22 Busca la posicion del centro en arrProductosPorCentro segun su ID
function BuscaCentro(PosProd, IDCentro)
{
	var PosCentro=-1;
	//	Comprueba que no se supere la cantidad a nivel de centro. Tenemos que utilizar arrProductosPorCentro en lugar de arrCentros
	for (var i=0;(i<arrProductosPorCentro[PosProd].Centros.length)&&(PosCentro==-1);++i)
	{
		if (arrProductosPorCentro[PosProd].Centros[i].IDCentro==IDCentro) PosCentro=i;
	}
	return PosCentro;
}	



//	Cierra la tabla de centros, sin guardar los cambios
function salirTablaCentros(Pos)
{
	if ((hayCambios=='S')&&(!confirm(conf_PerderCambios))) return;
	showTabla(false);
}


//	Cierra la tabla de centros, guarda los cambios, recupera los datos de las matrices que corresponda
function cerrarTablaCentros(Pos)
{
	var msgErr='',errores=0, strCantidades='';
	
	//solodebug	VuelcaTablaCentros();
	debug('\n\n\n');
	
	//No es necesario avisar, los cambios se guardaran siempre
	//if ((hayCambios=='S')&&(!confirm(conf_PerderCambios))) return;
	
	//	Guarda los cambios en la matriz de ofertas
	
	//	Inicializa todas las ofertas a "no adjudicado, cantidad=0"
	for (var i=0;(i<arrProductos.length);++i)
	{
		arrProductos[Pos].Ofertas[i].OfertaAdjud='N';
		arrProductos[Pos].Ofertas[i].CANTIDADADJUDICADA=0;
	}
		
	//	Guarda los nuevos valores en la matriz de ofertas
	for (var i=0;(i<arrTablaCentros.length);++i)
	{
		var IDCentro=arrTablaCentros[i].IDCentro;
		
		//solodebug	debug('cerrarTablaCentros. Centro('+i+'). IDCentro:'+IDCentro);
		
		var cantidad=jQuery('#Cantidad_'+arrTablaCentros[i].IDCentro).val();
		//solodebug	debug('cerrarTablaCentros. Centro('+i+'). IDCentro:'+IDCentro+' Cant:'+cantidad);
		
		arrTablaCentros[i].Cantidad=cantidad;
		arrTablaCentros[i].CantidadSF=desformateaDivisa(cantidad);
		//solodebug	debug('cerrarTablaCentros. Centro('+i+'). IDCentro:'+IDCentro+' Cant:'+cantidad+' CantSF:'+arrTablaCentros[i].CantidadSF);

		//	Validacion de la cantidad por centro
		if (esNulo(cantidad))
		{
			errores++;
			msgErr+='* '+alrt_faltaCantidad.replace("[[REF]]",arrTablaCentros[i].Centro)+':('+arrTablaCentros[i].cantidadSF+')\n';
			debug('cerrarTablaCentros. Centro('+i+'). IDCentro:'+IDCentro+' Cant:'+cantidad+' CantSF:'+arrTablaCentros[i].CantidadSF+' ESNULO');
		}
		else if(isNaN(cantidad))
		{
			errores++;
			msgErr+='* '+alrt_malCantidad.replace("[[REF]]",arrTablaCentros[i].Centro)+':('+arrTablaCentros[i].cantidadSF+')\n';
			debug('cerrarTablaCentros. Centro('+i+'). IDCentro:'+IDCentro+' Cant:'+cantidad+' CantSF:'+arrTablaCentros[i].CantidadSF+' ISNAN');
		}
		
		var totalPorCentro=0;
		debug('cerrarTablaCentros. Centro('+i+'):'+arrTablaCentros[i].Centro+' Cant:'+arrTablaCentros[i].CantidadSF)
		for (var j=0;(j<arrTablaCentros[i].Proveedores.length);++j)
		{
			var PosOferta=arrTablaCentros[i].Proveedores[j].PosOferta;

			var cantidad=jQuery('#Cantidad_'+IDCentro+'_'+arrProductos[Pos].Ofertas[PosOferta].ID).val();
			var cantidadSF=desformateaDivisa(cantidad);
			var nuevaCantidadSF=cantidadSF;

			//solodebug	debug('cerrarTablaCentros. Centro('+i+'), Proveedor ('+j+'). PosOferta:'+arrTablaCentros[i].Proveedores[j].PosOferta+' Cant:'+cantidad+' CantSF:'+cantidadSF);

			//	Validacion de la cantidad por centro y proveedor
			if(esNulo(cantidad))
			{
				errores++;
				msgErr+='* '+arrTablaCentros[i].Centro+','+arrTablaCentros[i].Proveedores[j].Proveedor+':'+alrt_faltaCantidad.replace("[[REF]]",'')+'\n';
				nuevaCantidadSF=0;
			}
			else if(isNaN(cantidad))
			{
				errores++;
				msgErr+='* '+arrTablaCentros[i].Centro+','+arrTablaCentros[i].Proveedores[j].Proveedor+':'+alrt_malCantidad.replace("[[REF]]",'')+'\n';
				nuevaCantidadSF=0;
			}

			//	Validacion empaquetamiento
			if (cantidadSF%arrProductos[Pos].Ofertas[PosOferta].UNIDADESPORLOTE!=0)
			{
				errores++;

				nuevaCantidadSF=arrProductos[Pos].Ofertas[PosOferta].UNIDADESPORLOTE*Math.ceil(cantidadSF/arrProductos[Pos].Ofertas[PosOferta].UNIDADESPORLOTE);

				msgErr+='* '+arrTablaCentros[i].Centro+','+arrTablaCentros[i].Proveedores[j].Proveedor
						+alrt_CantidadNoCorresponde.replace('[[CANTIDAD]]',cantidadSF).replace('[[UNIDADESPORLOTE]]',arrProductos[Pos].Ofertas[PosOferta].UNIDADESPORLOTE).replace('[[CANTIDADCORREGIDA]]',nuevaCantidadSF)+'\n';

				jQuery('#Cantidad_'+IDCentro+'_'+arrProductos[Pos].Ofertas[PosOferta].ID).val(nuevaCantidadSF);

			}

			totalPorCentro+=nuevaCantidadSF;
			
			//solodebug	debug('cerrarTablaCentros. Centro('+i+'), Proveedor ('+j+'). PosOferta:'+PosOferta+' Incl.cant.adj:'+nuevaCantidadSF);
			arrProductos[Pos].Ofertas[PosOferta].CANTIDADADJUDICADA+= nuevaCantidadSF;			//	incrementamos con las diferentes cantidades adjudicadas a los proveedores

			if ((arrProductos[Pos].Ofertas[PosOferta].OfertaAdjud=='N')&&(nuevaCantidadSF>0))
				arrProductos[Pos].Ofertas[PosOferta].OfertaAdjud='S';

			strCantidades+=arrTablaCentros[i].IDCentro+'|'+arrTablaCentros[i].Proveedores[j].IDProvLic+'|'+arrProductos[Pos].Ofertas[PosOferta].ID+'|'+nuevaCantidadSF+'#';
		
			//solodebug	debug('cerrarTablaCentros. Centro('+i+'):'+arrTablaCentros[i].Centro+' Proveedor('+j+'):'+arrTablaCentros[i].Proveedores[j].Proveedor
			//solodebug		+' Cant:'+arrTablaCentros[i].Proveedores[j].CantidadSF+' Total:'+arrProductos[Pos].Ofertas[PosOferta].CANTIDADADJUDICADA)
		}
		
		//CONTROL TOTAL CENTRO
		if (totalPorCentro>arrTablaCentros[i].CantidadSF)
		{
			msgErr+='* '+alrt_CantidadSupera.replace('[[TOTAL_PROVS]]',totalPorCentro).replace('[[TOTAL_CENTRO]]',arrTablaCentros[i].CantidadSF)+'\n';
			errores++;
		}

		if (totalPorCentro<arrTablaCentros[i].CantidadSF)
		{
			msgErr+='* '+alrt_CantidadNoCubre.replace('[[TOTAL_PROVS]]',totalPorCentro).replace('[[TOTAL_CENTRO]]',arrTablaCentros[i].CantidadSF)+'\n';
			errores++;
		}
		
	}
	
	if (errores>0) alert(msgErr);
	
	if (errores==0)
	{
		//solodebug	debug('cerrarTablaCentros. No se han detectado errores. Preparando para guardar. StringCant:'+strCantidades);

		var d = new Date();
		jQuery.ajax({
			cache:	false,
			url:	'http://www.newco.dev.br/Gestion/Comercial/InformarDatosCompraCentroYProvAJAX.xsql',
			type:	"GET",
			data:	"LIC_ID="+IDLicitacion+"&LIC_PROD_ID="+arrProductos[Pos].IDProdLic+"&IDCENTRO=0&CANTIDADES="+encodeURIComponent(strCantidades)+"&_="+d.getTime(),	//IDCENTRO=0 para guardar todo
			beforeSend: function(){
				jQuery(".guardarOferta").hide();
			},
			error: function(objeto, quepaso, otroobj){
				debug('error'+quepaso+' '+otroobj+' '+objeto);
				alert(alrt_guardarAdjudicacionKO);
			},
			success: function(objeto){
				var data = eval("(" + objeto + ")");

				if(data.OfertaActualizada.Estado =='OK'){
					
					//	Actualiza los valores pendientes en los arrays de producto y productos por centro
					//	Guarda los cambios a nivel de producto
					//	Ocultamos la tabla de productos por centro y proveedor
					//	Volvemos a dibujar el producto, con los nuevos valores del array
					ActualizarArrays(Pos);
					
				}
				else
				{
					alert(alrt_guardarAdjudicacionKO);
				}
			}
		});
	}
		
		
}

//	14jul22 Copia los datos en los Arrays de producto
function ActualizarArrays(Pos)
{
	//	Recorre los centros
	var CantTotProducto=0;
	for (var i=0;i<arrTablaCentros.length;++i)
	{
		arrProductosPorCentro[Pos].Centros[i].Cantidad=arrTablaCentros[i].Cantidad;
		arrProductosPorCentro[Pos].Centros[i].CantidadSF=arrTablaCentros[i].CantidadSF;
		
		CantTotProducto+=arrTablaCentros[i].CantidadSF;
	}
	
	//	Actualiza la cantidad a nivel del producto
	arrProductos[Pos].CantidadSF=CantTotProducto;
	arrProductos[Pos].Cantidad=formateaDivisa(CantTotProducto);	

	CompruebaCambios(Pos);
	RevisaOfertas(Pos);

	debug('ActualizarArrays. Producto('+Pos+') Cant.:'+arrProductos[Pos].Cantidad+' CantSF:'+arrProductos[Pos].CantidadSF);
	
	RecuperaProveedoresAdjudicadosAJAX(Pos);
	
}

//	13abr21 Recupera la info de los proveedores (adaptado desde la ficha de licitacion)
function RecuperaProveedoresAdjudicadosAJAX(Pos)
{
	debug('ProveedoresAdjudicadosAJAX');

	var d = new Date();
	jQuery.ajax({
		cache:	false,
		url:	'http://www.newco.dev.br/Gestion/Comercial/ProveedoresAdjudicadosAJAX.xsql',
		type:	"GET",
		data:	"LIC_ID="+IDLicitacion+"&LIC_PROD_ID="+arrProductos[Pos].IDProdLic+"&_="+d.getTime(),
		beforeSend: function(){
		},
		error: function(objeto, quepaso, otroobj){
			alert('error'+quepaso+' '+otroobj+' '+objeto);
		},
		success: function(objeto){
			var data = eval("(" + objeto + ")");
			//arrCentros	= new Array();
			arrProductosPorCentro[Pos].Centros	= new Array();
			
			for (var i=0;i<data.Centros.length;++i)
			{

				var centro	= [];
				centro['IDCentro']	= data.Centros[i].IDCentro;
				centro['Centro']= data.Centros[i].Centro;
				centro['Marcas']= data.Centros[i].Marcas;
				centro['Cantidad']= data.Centros[i].Cantidad;
				centro['CantidadSF']= parseInt(data.Centros[i].CantidadSF);
				centro['Proveedores']	= [];

				debug('ProveedoresAdjudicadosAJAX. Centro('+i+'):'+centro['Centro']+' Cant:'+centro['CantidadSF']);

				for (var j=0;j<data.Centros[i].Proveedores.length;++j)
				{
					var Proveedor	= [];
					Proveedor['IDOfertaLic']= data.Centros[i].Proveedores[j].IDOfertaLic;
					Proveedor['IDProvLic']	= data.Centros[i].Proveedores[j].IDProveedorLic;
					Proveedor['IDProveedor']= data.Centros[i].Proveedores[j].IDProveedor;
					Proveedor['Proveedor']	= data.Centros[i].Proveedores[j].Proveedor;
					Proveedor['UdesLote']	= data.Centros[i].Proveedores[j].UnidadesPorLote;
					Proveedor['Cantidad']	= data.Centros[i].Proveedores[j].Cantidad;
					Proveedor['CantidadSF']	= parseInt(data.Centros[i].Proveedores[j].CantidadSF);
					centro['Proveedores'].push(Proveedor);

					debug('ProveedoresAdjudicadosAJAX. Centro('+i+'):'+centro['Centro']+' Proveedor('+j+'):'+Proveedor['Proveedor']+' Cant:'+Proveedor['CantidadSF']);

				}
				arrProductosPorCentro[Pos].Centros.push(centro);
			}
			
			//	Guarda los cambios a nivel de producto
			GuardarProductoSel(Pos, 'SOLO_UNO');

			//	Ocultamos la tabla de productos por centro y proveedor
			showTabla(false);

			//	Volvemos a dibujar el producto, con los nuevos valores del array
			AbrirProducto(Pos);
			
			//solodebug	VuelcaTablaProductosPorCentro(Pos);
		}
	});
	
}



//13jul22 SOLO DEBUG
function VuelcaTablaCentros()
{
	for (var i=0;(i<arrTablaCentros.length);++i)
	{
		debug('VuelcaTablaCentros. Centro('+i+'):'+arrTablaCentros[i].Centro)
		for (var j=0;(j<arrTablaCentros[i].Proveedores.length);++j)
		{
			debug('VuelcaTablaCentros. Centro('+i+'):'+arrTablaCentros[i].Centro+' Proveedor('+j+'):'+arrTablaCentros[i].Proveedores[j].Proveedor
				+' Cant:'+arrTablaCentros[i].Proveedores[j].CantidadSF+' CantAnt:'+arrTablaCentros[i].Proveedores[j].CantidadAntSF)
		}
	}
}	

//13jul22 SOLO DEBUG
function VuelcaTablaProductosPorCentro(Pos)
{
	for (var i=0;(i<arrProductosPorCentro[Pos].Centros.length);++i)
	{
		debug('VuelcaTablaProductosPorCentro. Centro('+i+'):'+arrProductosPorCentro[Pos].Centros[i].Centro);
		for (var j=0;(j<arrProductosPorCentro[Pos].Centros[i].Proveedores.length);++j)
		{
			debug('VuelcaTablaProductosPorCentro. Centro('+i+'):'+arrProductosPorCentro[Pos].Centros[i].Centro+' Proveedor('+j+'):'+arrProductosPorCentro[Pos].Centros[i].Proveedores[j].Proveedor
				+' Cant:'+arrProductosPorCentro[Pos].Centros[i].Proveedores[j].CantidadSF)
		}
	}
}	

