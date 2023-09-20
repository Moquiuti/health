// JavaScript Document

	var msgConfirmarBorrado='¿Eliminar el producto del proveedor?';
	var msgProveedorConCentros='El producto que intenta eliminar esta asignado a algún centro.\nPara poder borrarlo debe eliminar/modificar primero dicho centro.';
	var msgSinProveedor='Debe seleccionar el proveedor del producto.';
	var msgSinReferencia='Debe introducir la referencia del producto (proveedor).';
	var msgSinNombreProducto='Debe introducir el nombre del producto (proveedor).';
	var msgSinUnidadesLote='Debe introducir las unidades por lote del producto.';
	var msgSinUnidadBasica='Debe introducir la unidade básica del producto.';
	var msgSinPrecioUnidadBasica='Debe introducir el precio unidade básica del producto.';
	var msgOtrosProveedores='La opción que tiene seleccionada en el desplegable de proveedores no permite verificar los datos.';
	var msgSinNombreProveedor='Debe introducir el nombre del proveedor.';

	function CerrarVentana(){
		if(window.parent.opener && !window.parent.opener.closed){
			var objFrameTop=new Object();
			objFrameTop=window.parent.opener.top;
			var FrameOpenerName=window.parent.opener.name;
			var objFrame=new Object();
			objFrame=obtenerFrame(objFrameTop,FrameOpenerName);
			if(objFrame!=null && objFrame.recargarPagina){
				objFrame.recargarPagina('PROPAGAR');
			}else{
				Refresh(objFrame.document);
			}
		}

		window.parent.close();
	}

	function BorrarProveedor(idProveedorProducto,numeroCentros,accion){
		if(numeroCentros<=0){
			if(confirm(msgConfirmarBorrado)){
				document.forms[0].elements['ACCION'].value=accion;
				document.forms[0].elements['IDPROVEEDORPRODUCTO'].value=idProveedorProducto;

				SubmitForm(document.forms[0]);
			}
		}else{
			alert(msgProveedorConCentros);
		}
	}

	function ModificarProveedor(idProveedorProducto,accion){
		document.forms[0].elements['ACCION'].value=accion;
		document.forms[0].elements['IDPROVEEDORPRODUCTO'].value=idProveedorProducto;

		SubmitForm(document.forms[0]);
	}

	function AnyadirProveedor(idProveedor,idCentro,accion){
		document.forms[0].elements['IDNUEVOPROVEEDOR'].value=idProveedor;
		document.forms[0].elements['IDCENTRO'].value=idCentro;
		document.forms[0].elements['ACCION'].value=accion;
		SubmitForm(document.forms[0]);
	}

	function ActualizarDatos(form, accion){
		if(ValidarFormulario(form)){
			document.forms[0].elements['ACCION'].value=accion;
			document.forms[0].elements['IDNUEVOPROVEEDOR'].value=document.forms[0].elements['IDPROVEEDOR'].value;

			/* reemplazamos la coma por el punto de los campos numericos */
			//document.forms[0].elements['PRECIOUNIDADBASICA'].value=reemplazaComaPorPunto(document.forms[0].elements['PRECIOUNIDADBASICA'].value);
			var precioOk = ValidarNumero(document.forms[0].elements['PRECIOUNIDADBASICA'],4);

			if (precioOk != ''){ alert(precioOk); }
			else { SubmitForm(document.forms[0]); }
		}
	}

	//validar formulario
	function ValidarFormulario(form){
		var errores=0;
		/* quitamos los espacios sobrantes */
		for(var n=0;n<form.length;n++){
			if(form.elements[n].type=='text'){
				form.elements[n].value=quitarEspacios(form.elements[n].value);
			}
		}

		if((!errores) && (document.forms[0].elements['IDPROVEEDOR'].value<=-1) && (document.forms[0].elements['IDPROVEEDOR'].value!='')){
			alert(msgSinProveedor);
			document.forms[0].elements['IDPROVEEDOR'].focus();
			errores++;
		}else{
			document.forms[0].elements['TIPOPROVEEDOR'].value='';
			for(var n=0;n<document.forms[0].length;n++){
				if(document.forms[0].elements[n].type=='checkbox'){
					if(document.forms[0].elements[n].name.substring(0,18)=='CHK_TIPOPROVEEDOR_' && document.forms[0].elements[n].checked==true){
						var tipo=document.forms[0].elements[n].name.substring(18,document.forms[0].elements[n].name.length);
						if(tipo=='IMP'){
							document.forms[0].elements['TIPOPROVEEDOR'].value='I';
						}else{
							if(tipo=='FAB'){
								document.forms[0].elements['TIPOPROVEEDOR'].value='F';
							}else{
								if(tipo=='DIS'){
									document.forms[0].elements['TIPOPROVEEDOR'].value='D';
								}
							}
						}
					}
				}
			}
		}

		if((!errores) && (document.forms[0].elements['IDPROVEEDOR'].value=='') && (esNulo(document.forms[0].elements['NOMBREPRROVEEDORNOAFILIADO'].value))){
			alert(msgSinNombreProveedor);
			document.forms[0].elements['NOMBREPRROVEEDORNOAFILIADO'].focus();
			errores++;
		}

/*
		if((!errores) && (esNulo(document.forms[0].elements['REFERENCIAPRODUCTO'].value))){
			alert(msgSinReferencia);
			document.forms[0].elements['REFERENCIAPRODUCTO'].focus();
			errores++;
		}
*/
/*
		if((!errores) && (esNulo(document.forms[0].elements['NOMBREPRODUCTO'].value))){
			alert(msgSinNombreProducto);
			document.forms[0].elements['NOMBREPRODUCTO'].focus();
			errores++;
		}
*/
/*
		if((!errores) && (esNulo(document.forms[0].elements['UNIDADESLOTE'].value))){
			alert(msgSinUnidadesLote);
			document.forms[0].elements['UNIDADESLOTE'].focus();
			errores++;
		}
		if((!errores) && (esNulo(document.forms[0].elements['UNIDADBASICA'].value))){
			alert(msgSinUnidadBasica);
			document.forms[0].elements['UNIDADBASICA'].focus();
			errores++;
		}
*/
/*
		if((!errores) && (esNulo(document.forms[0].elements['PRECIOUNIDADBASICA'].value))){
			alert(msgSinPrecioUnidadBasica);
			document.forms[0].elements['PRECIOUNIDADBASICA'].focus();
			errores++;
		}
*/
		if(!errores)
			return true;
	}

	function ValidarNumero(obj,decimales){
		var msg= '';
		var precio = obj.value
		var lun = precio.length;
		var punto= 0;
		var coma= 0;

		for(var i=0;i<lun;i++){
			if ( precio[i] == '.'){ punto = 1;}
			if ( precio[i] == ','){ coma = 1;}
		}

		if(punto == 1){
			msg = 'Error en el precio, rogamos no usar el punto.\nPor los decimales use la coma.';
			return msg;
		}else return msg;

		if(checkNumberNulo(obj.value,obj)){
			if(parseFloat(reemplazaComaPorPunto(obj.value))!=0){
				obj.value=anyadirCerosDecimales(reemplazaPuntoPorComa(Round(reemplazaComaPorPunto(obj.value),decimales)),decimales);
			}
		}
	}//fin  Validar numero

	function ComprobarProducto(objIdproveedor, objReferencia){
		var errores=0;

		if(objIdproveedor.value<=-1){
			alert(msgSinProveedor);
			objIdproveedor.focus();
			errores++;
		}else{
			if(objIdproveedor.value==''){
				alert(msgOtrosProveedores);
				objIdproveedor.focus();
				errores++;
			}
		}

		if((!errores)&& (objReferencia.value=='')){
			alert(msgSinReferencia);
			objReferencia.focus();
			errores++;
		}

		if(!errores){
			parent.frameXML.location.href='http://www.newco.dev.br/ProcesosCdC/CatalogoPrivado/ComprobarProducto.xsql?IDPROVEEDOR='+objIdproveedor.value+'&REFERENCIA='+objReferencia.value+'&DESDE=PROVEEDORES';
		}
	}

	function CargarNombre(nombre){
		document.forms[0].elements['NOMBREPRODUCTO'].value=nombre;
	}

	function CargarUnidadBasica(unidadBasica){
		document.forms[0].elements['UNIDADBASICA'].value=unidadBasica;
	}

	function CargarUnidadesPorLote(UnidadesPorLote){
		document.forms[0].elements['UNIDADESLOTE'].value=UnidadesPorLote;
	}

	function CargarPrecioUnidadBasica(precio){
		document.forms[0].elements['PRECIOUNIDADBASICA'].value=precio;
	}

	function CargarMarca(marca){
		document.forms[0].elements['MARCA'].value=marca;
	}

	function validarTipoProveedorDespl(form, objOrigen, nombreObjetoDestino){
		if(!esNulo(objOrigen.value) && objOrigen.value>-1){
			form.elements[nombreObjetoDestino].value='';
		}
	}

	function validarTipoProveedorText(form, objOrigen, nombreObjetoDestino){
		if(!esNulo(objOrigen.value)){
			form.elements[nombreObjetoDestino].selectedIndex=form.elements[nombreObjetoDestino].options.length-1;
		}
	}

	function validarChecks(form, objName){
		for(var n=0;n<form.length;n++){
			if(form.elements[n].type=='checkbox'){
				if(form.elements[n].name.substring(0,18)=='CHK_TIPOPROVEEDOR_' && form.elements[n].name!=objName){
					form.elements[n].checked=false;
				}
			}
		}
	}