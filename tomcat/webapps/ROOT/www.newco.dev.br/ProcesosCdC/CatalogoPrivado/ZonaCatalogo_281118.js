/*
	Librería JS para la gestión del catálogo privado
	ultima revision ET 28nov18
*/




/*
funcion para enviar los cambios al servidor
solo llega aqui si se hay pasado todos los filtros (quiere borrar?, no tiene permisos, etc...)
por lo que habria que hacer comprobaciones en esta funcion
*/
function EnviarCambios(idObjeto, accion){
	alert('EnviarCambios');
}

/*
funciones para el catalogo
*/
//		funcion que obtiene el desplegable con la nueva familia seleccionada y su lista de productos
function obtenerIdProductoEstandar(){
	return document.forms[0].elements['CATPRIV_IDPRODUCTOESTANDAR'].value;
}

function obtenerIdSubfamilia(){
	return document.forms[0].elements['CATPRIV_IDSUBFAMILIA'].value;
}

function obtenerPosicionDesplegableProductoEstandar(){
	return document.forms[0].elements['CATPRIV_IDPRODUCTOESTANDAR'].selectedIndex;
}

function obtenerPosicionDesplegableGrupo(){
	return document.forms[0].elements['CATPRIV_IDGRUPO'].selectedIndex;
}

function obtenerPosicionDesplegableSubfamilia(){
	return document.forms[0].elements['CATPRIV_IDSUBFAMILIA'].selectedIndex;
}

function obtenerPosicionDesplegableFamilia(){
	return document.forms[0].elements['CATPRIV_IDFAMILIA'].selectedIndex;
}

function CambioEmpresaActual(idEmpresa, accion){
	//	11jul16	Recarga el marco con el buscador
	//objFrame=obtenerFrame(top, 'Cabecera');

	//if(parent.Cabecera.location!=null){

	parent.areaTrabajo.Cabecera.document.location.href='Buscador.xsql?IDEMPRESA='+idEmpresa;
	//}

	document.location.href='ZonaCatalogo.xsql?IDEMPRESA='+idEmpresa+'&ACCION='+accion+'&TIPOVENTANA='+document.forms[0].elements['TIPOVENTANA'].value;
}

function CambioCategoriaActual(idEmpresa, idCategoria, accion){
	document.location.href='ZonaCatalogo.xsql?IDEMPRESA='+idEmpresa+'&IDNUEVACATEGORIA='+idCategoria+'&ACCION='+accion+'&TIPOVENTANA='+document.forms[0].elements['TIPOVENTANA'].value;
}

function CambioFamiliaActual(idEmpresa, idFamilia, accion){
	document.location.href='ZonaCatalogo.xsql?IDEMPRESA='+idEmpresa+'&IDNUEVAFAMILIA='+idFamilia+'&ACCION='+accion+'&TIPOVENTANA='+document.forms[0].elements['TIPOVENTANA'].value;
}

function CambioSubfamiliaActual(idEmpresa, idSubfamilia, accion){
	//solodebug	console.log('CambioSubfamiliaActual. idEmpresa:'+idEmpresa+' idSubfamilia:'+idSubfamilia+' accion:'+accion);
	document.location.href='ZonaCatalogo.xsql?IDEMPRESA='+idEmpresa+'&IDNUEVASUBFAMILIA='+idSubfamilia+'&ACCION='+accion+'&TIPOVENTANA='+document.forms[0].elements['TIPOVENTANA'].value;
}

function CambioGrupoActual(idEmpresa, idGrupo, accion){
	document.location.href='ZonaCatalogo.xsql?IDEMPRESA='+idEmpresa+'&IDNUEVOGRUPO='+idGrupo+'&ACCION='+accion+'&TIPOVENTANA='+document.forms[0].elements['TIPOVENTANA'].value; 
}

//		añadimos una nueva categoria -- dc 07/01/13
function NuevaCategoria(idCategoria,accion){
	var idEmpresa=document.forms[0].elements['CATPRIV_IDEMPRESA'].value;
	//var objFrame=new Object();

	parent.areaTrabajo.Resultados.location.href='MantCategorias.xsql?CATPRIV_IDCATEGORIA='+idCategoria+'&CATPRIV_IDEMPRESA='+idEmpresa+'&ACCION='+accion;
}

//		funcion para modificar la ref y el nombre de la categoria -- dc 07/01/13
function ModificarCategoria(idCategoria,accion){
	var tipoModificacion='';

	if(document.forms[0].elements['CATPRIV_IDCATEGORIA'].value>''){
		if(accion=='CONSULTARCATEGORIA'){
			tipoModificacion='&TIPO=CONSULTA';
		}

		var idEmpresa=document.forms[0].elements['CATPRIV_IDEMPRESA'].value;

//				nuevo trozo para que se enseñe tb buscador siempre
		parent.areaTrabajo.Resultados.location.href='MantCategorias.xsql?CATPRIV_IDCATEGORIA='+idCategoria+'&CATPRIV_IDEMPRESA='+idEmpresa+'&ACCION='+accion+tipoModificacion;
	}else{
		alert(sin_nivel1_para_editar);
	}
}

//		borra la categoria seleccionada, pide confirmacion -- dc 07/01/13
function BorrarCategoria(idEmpresa, idCategoria, accion){
	if(document.forms[0].elements['CATPRIV_IDCATEGORIA'].value>''){
		if(!tieneHijos(document.forms[0].elements['CATPRIV_IDCATEGORIA'].value,arrayCategorias)){
			if(confirm(borrar_nivel1)){
				document.location.href='ZonaCatalogo.xsql?IDEMPRESA='+idEmpresa+'IDNUEVACATEGORIA='+idCategoria+'&ACCION='+accion+'&TIPOVENTANA='+document.forms[0].elements['TIPOVENTANA'].value;
				var objFrame=new Object();
				parent.areaTrabajo.location.href='areaTrabajo';
			}
		}else{
			alert(borrar_antes_nivel2);
		}
	}else{
		alert(sin_nivel1_para_borrar);
	}
}

//		añadimos una nueva familia
function NuevaFamilia(idFamilia,idCategoria,accion){
	var idEmpresa=document.forms[0].elements['CATPRIV_IDEMPRESA'].value;

	parent.areaTrabajo.Resultados.location.href='MantFamilias.xsql?CATPRIV_IDCATEGORIA='+idCategoria+'&CATPRIV_IDFAMILIA='+idFamilia+'&CATPRIV_IDEMPRESA='+idEmpresa+'&ACCION='+accion;
}

//		funcion para modificar la ref y el nombre de la familia
function ModificarFamilia(idFamilia,idCategoria,accion){
	var tipoModificacion='';
	if(document.forms[0].elements['CATPRIV_IDFAMILIA'].value>''){
		if(accion=='CONSULTARFAMILIA'){
			tipoModificacion='&TIPO=CONSULTA';
		}
		var idEmpresa=document.forms[0].elements['CATPRIV_IDEMPRESA'].value;

		parent.areaTrabajo.Resultados.location.href='MantFamilias.xsql?CATPRIV_IDCATEGORIA='+idCategoria+'&CATPRIV_IDFAMILIA='+idFamilia+'&CATPRIV_IDEMPRESA='+idEmpresa+'&ACCION='+accion+tipoModificacion;

	}else{
		alert(sin_nivel2_para_editar);
	}
}

//		borra la familia seleccionada, pide confirmacion
function BorrarFamilia(idEmpresa, idCategoria,idFamilia, accion){
	if(document.forms[0].elements['CATPRIV_IDFAMILIA'].value>''){
		if(!tieneHijos(document.forms[0].elements['CATPRIV_IDFAMILIA'].value,arrayFamilias)){
			if(confirm(borrar_nivel2)){
				document.location.href='ZonaCatalogo.xsql?IDEMPRESA='+idEmpresa+'IDNUEVACATEGORIA='+idCategoria+'&IDNUEVAFAMILIA='+idFamilia+'&ACCION='+accion+'&TIPOVENTANA='+document.forms[0].elements['TIPOVENTANA'].value;
				var objFrame=new Object();
				parent.areaTrabajo.location.href='BuscadorFrame.xsql';
			}
		}else{
			alert(borrar_antes_nivel3);
		}
	}else{
		alert(sin_nivel2_para_borrar);
	}
}

//		añadimos una nueva familia
function NuevaSubfamilia(idSubfamilia,idFamilia,accion){
	if(document.forms[0].elements['CATPRIV_IDFAMILIA'].value>''){
		var idEmpresa=document.forms[0].elements['CATPRIV_IDEMPRESA'].value;
		var objFrame=new Object();

//				nuevo trozo para que se enseñe tb buscador siempre
		parent.areaTrabajo.Resultados.location.href='MantSubfamilias.xsql?CATPRIV_IDSUBFAMILIA='+idSubfamilia+'&CATPRIV_IDFAMILIA='+idFamilia+'&CATPRIV_IDEMPRESA='+idEmpresa+'&ACCION='+accion;
	}else{
		alert(sin_nivel2 + para_nivel3);
	}
}

//		funcion para modificar la ref y el nombre de la familia
function ModificarSubfamilia(idSubfamilia,idFamilia,accion){
	var tipoModificacion='';
	if(document.forms[0].elements['CATPRIV_IDSUBFAMILIA'].value>''){
		var idEmpresa=document.forms[0].elements['CATPRIV_IDEMPRESA'].value;
		if(accion=='CONSULTARSUBFAMILIA'){
			tipoModificacion='&TIPO=CONSULTA';
		}
		parent.areaTrabajo.Resultados.location.href='MantSubfamilias.xsql?CATPRIV_IDSUBFAMILIA='+idSubfamilia+'&CATPRIV_IDFAMILIA='+idFamilia+'&CATPRIV_IDEMPRESA='+idEmpresa+'&ACCION='+accion+tipoModificacion;
	}else{
		alert(sin_nivel3_para_editar);
	}
}

//		borra la subfamilia seleccionada, pide confirmacion
function BorrarSubfamilia(idEmpresa, idCategoria,idFamilia,idSubfamilia,accion){
	if(document.forms[0].elements['CATPRIV_IDSUBFAMILIA'].value>''){
		if(!tieneHijos(document.forms[0].elements['CATPRIV_IDSUBFAMILIA'].value,arraySubfamilias)){
			if(confirm(borrar_nivel3)){
				document.location.href='ZonaCatalogo.xsql?IDEMPRESA='+idEmpresa+'IDNUEVACATEGORIA='+idCategoria+'&IDNUEVAFAMILIA='+idFamilia+'&IDNUEVASUBFAMILIA='+idSubfamilia+'&ACCION='+accion+'&TIPOVENTANA='+document.forms[0].elements['TIPOVENTANA'].value;
				var objFrame=new Object();
				parent.areaTrabajo.location.href='BuscadorFrame.xsql';
			}
		}else{
			if(document.getElementById('td_grupos')){
				alert(borrar_antes_nivel4);
			}else{
				alert(borrar_antes_nivel5_para_nivel3);
			}
		}
	}else{
		alert(sin_nivel3_para_borrar);
	}
}

//el listItem 3 tiene un contador con el num de hijos, si es 0 entonces no tiene hijos, si no si
function tieneHijos(valor,array){
	for(var n=0;n<array.length;n++){
		arrayRegistro=array[n];
		if(arrayRegistro[0]==valor){
			if(arrayRegistro[3]==0){
				return 0;
			}else{
				return 1;
			}
		}
	}
	return 0;
}

//		funciones para los grupos -- dc 07/01/13
function NuevoGrupo(idGrupo,idSubfamilia,accion){
	if(document.forms[0].elements['CATPRIV_IDSUBFAMILIA'].value>''){
		var idEmpresa=document.forms[0].elements['CATPRIV_IDEMPRESA'].value;
		parent.areaTrabajo.Resultados.location.href='MantGrupos.xsql?CATPRIV_IDGRUPO='+idGrupo+'&CATPRIV_IDSUBFAMILIA='+idSubfamilia+'&CATPRIV_IDEMPRESA='+idEmpresa+'&ACCION='+accion;
//				objFrame.location.href='MantGrupos.xsql?CATPRIV_IDGRUPO='+idGrupo+'&CATPRIV_IDSUBFAMILIA='+idSubfamilia+'&CATPRIV_IDEMPRESA='+idEmpresa+'&ACCION='+accion;
	}else{
		alert(sin_nivel3+para_nivel4);
	}
}

function ModificarGrupo(idGrupo,idSubfamilia, accion){
	var tipoModificacion='';
	if(document.forms[0].elements['CATPRIV_IDGRUPO'].value>''){
		var idEmpresa=document.forms[0].elements['CATPRIV_IDEMPRESA'].value;
		if(accion=='CONSULTARGRUPO'){
			tipoModificacion='&TIPO=CONSULTA';
		}
		parent.areaTrabajo.Resultados.location.href='MantGrupos.xsql?CATPRIV_IDGRUPO='+idGrupo+'&CATPRIV_IDSUBFAMILIA='+idSubfamilia+'&CATPRIV_IDEMPRESA='+idEmpresa+'&ACCION='+accion+tipoModificacion;
	}else{
		alert(sin_nivel4_para_editar);
	}
}

//		borra el grupo seleccionado, pide confirmacion -- dc 07/01/13
function BorrarGrupo(idEmpresa, idCategoria,idFamilia,idSubfamilia,idGrupo, accion){
//alert(idCategoria+' '+idFamilia+' '+idSubfamilia+' '+idGrupo+' '+accion);
	if(document.forms[0].elements['CATPRIV_IDGRUPO'].value>''){

		if(!tieneHijos(document.forms[0].elements['CATPRIV_IDGRUPO'].value,arrayGrupos)){

			if(confirm(borrar_nivel4)){
				document.location.href='ZonaCatalogo.xsql?IDEMPRESA='+idEmpresa+'IDNUEVACATEGORIA='+idCategoria+'&IDNUEVAFAMILIA='+idFamilia+'&IDNUEVASUBFAMILIA='+idSubfamilia+'&IDNUEVOGRUPO='+idGrupo+'&ACCION='+accion+'&TIPOVENTANA='+document.forms[0].elements['TIPOVENTANA'].value;
				var objFrame=new Object();
				parent.areaTrabajo.location.href='BuscadorFrame.xsql';
			}
		}else{
			alert(borrar_antes_nivel5);
		}
	}else{
		alert(sin_nivel4_para_borrar);
	}
}

//		funciones para los productos estandar
function NuevoProductoEstandar(idProducto,idGrupo,idSubfamilia,accion){
	if(document.forms[0].elements['CATPRIV_IDSUBFAMILIA'].value>''){
		var idEmpresa=document.forms[0].elements['CATPRIV_IDEMPRESA'].value;
		parent.areaTrabajo.Resultados.location.href='MantProductosEstandar.xsql?CATPRIV_IDPRODUCTOESTANDAR='+idProducto+'&CATPRIV_IDGRUPO='+idGrupo+'&CATPRIV_IDSUBFAMILIA='+idSubfamilia+'&CATPRIV_IDEMPRESA='+idEmpresa+'&ACCION='+accion;
	}else{
		if(document.getElementById('td_grupos')){
			alert(sin_nivel4 + para_prod_estandar);
		}else{
			alert(sin_nivel3 + para_prod_estandar);
		}
	}
}


function CambioProductoEstandarActual(idEmpresa, idProductoEstandar, accion){
	// solodebug alert(' CambioProductoEstandarActual ');
	var idSubfamilia=document.forms[0].elements['CATPRIV_IDSUBFAMILIA'].value;

	//solodebug	alert('idEmpresa:'+idEmpresa+' idProductoEstandar:'+idProductoEstandar+ ' idSubfamilia:'+idSubfamilia);

	document.location.href='ZonaCatalogo.xsql?IDEMPRESA='+idEmpresa+'&IDNUEVOPRODUCTOESTANDAR='+idProductoEstandar+'&IDNUEVASUBFAMILIA='+idSubfamilia+'&ACCION='+accion+'&TIPOVENTANA='+document.forms[0].elements['TIPOVENTANA'].value;
}

function ModificarProductoEstandar(idProducto,idGrupo,idSubfamilia,idFamilia,idCategoria,accion){
	var tipoModificacion='';
	if(document.forms[0].elements['CATPRIV_IDPRODUCTOESTANDAR'].value>''){
		var idEmpresa=document.forms[0].elements['CATPRIV_IDEMPRESA'].value;
		if(accion=='CONSULTARPRODUCTOESTANDAR'){
			tipoModificacion='&TIPO=CONSULTA';
		}
		parent.areaTrabajo.Resultados.location.href='MantProductosEstandar.xsql?CATPRIV_IDPRODUCTOESTANDAR='+idProducto+'&CATPRIV_IDGRUPO='+idGrupo+'&CATPRIV_IDSUBFAMILIA='+idSubfamilia+'&CATPRIV_IDCATEGORIA='+idCategoria+'&CATPRIV_IDFAMILIA='+idFamilia+'&CATPRIV_IDEMPRESA='+idEmpresa+'&ACCION='+accion+tipoModificacion;
	}else{
		alert(sin_prod_estan_para_editar);
	}
}

function buscarHijos(valor,array,posicion){
//			alert('valor '+valor+' array '+array+' pos '+posicion)
	for(var n=0;n<array.length;n++){
		if(array[n][0]==valor){
//					alert(array[n][0]+' == '+valor);
			return array[n][posicion];
		}
	}
}

function BorrarProductoEstandar(idEmpresa, idCategoria,idFamilia,idSubfamilia,idGrupo,idProductoEstandar,accion){
	//alert(' prod estand: '+document.forms[0].elements['CATPRIV_IDPRODUCTOESTANDAR'].value+ 'hijos:'+buscarHijos(document.forms[0].elements['CATPRIV_IDPRODUCTOESTANDAR'].value,arrayProductosEstandar,3));

	if(document.forms[0].elements['CATPRIV_IDPRODUCTOESTANDAR'].value!=''){
		if(buscarHijos(document.forms[0].elements['CATPRIV_IDPRODUCTOESTANDAR'].value,arrayProductosEstandar,3)==0){
			if(confirm(borrar_prod_estandar)){
				document.location.href='ZonaCatalogo.xsql?IDEMPRESA='+idEmpresa+'IDNUEVACATEGORIA='+idCategoria+'&IDNUEVAFAMILIA='+idFamilia+'&IDNUEVASUBFAMILIA='+idSubfamilia+'&IDNUEVOGRUPO='+idGrupo+'&IDNUEVOPRODUCTOESTANDAR='+idProductoEstandar+'&ACCION='+accion+'&TIPOVENTANA='+document.forms[0].elements['TIPOVENTANA'].value;
				var objFrame=new Object();
				parent.areaTrabajo.location.href='BuscadorFrame.xsql';
			}
		}else{
			alert(clientes_utilizan_prod_estandar);
		}
	}else{
		alert(sin_prod_estan_para_borrar);
	}
}

//		funciones para los productos
//		funcion que añade un producto a la familia seleccionada
function NuevoProducto(idProducto,accion){
	var objFrame=new Object();
	parent.areaTrabajo.location.href='MantProductoCatalogo.xsql';
}

//		borra un producto, pide confirmacion
function BorrarProducto(idProducto,accion){
	alert('BorrarProducto: '+idProducto+' '+accion);
}

//		modifica un producto del catalogo actual
function ModificarProducto(idProducto,accion){
	alert('ModificarProducto: '+idProducto+' '+accion);
}

function ListarFamiliasYProductos(){
//			redimensionarFrame('MINIMIZADO');
	var objFrame=new Object();
	parent.areaTrabajo.location.href='FamiliasYProductos_Inicio.xsql';
}

function ModeloPedidosPorFax(){
//			redimensionarFrame('MINIMIZADO');
	var objFrame=new Object();
	parent.areaTrabajo.location.href='ModeloPedidos_Inicio.xsql';
}

function ListarPrecios(){
//			redimensionarFrame('MINIMIZADO');
	var objFrame=new Object();
	parent.areaTrabajo.location.href='FamiliasYPrecios_Inicio.xsql';
}

function recargarPagina(propagar){
	var objFrame=new Object();
	objFrame=obtenerFrame(top,'areaTrabajo');
	objFrame.location.href='about:blank';
	var objFrame=new Object();
	objFrame=obtenerFrame(top,'zonaProducto');
	objFrame.location.href='about:blank';
	document.location.href='ZonaCatalogo.xsql?IDNUEVOPRODUCTOESTANDAR='+document.forms[0].elements['CATPRIV_IDPRODUCTOESTANDAR'].value+'&IDNUEVAFAMILIA='+document.forms[0].elements['CATPRIV_IDFAMILIA'].value+'&ACCION=CAMBIOPRODUCTOESTANDAR'+'&TIPOVENTANA='+document.forms[0].elements['TIPOVENTANA'].value+'&PROPAGAR='+propagar;
}

function CargarProductoEstandar(idProductoEstandar){
	var propagar=document.forms['form1'].elements['CATPRIV_IDFAMILIA'].value;
	if(idProductoEstandar!='' && idProductoEstandar>0){
		var idCategoria=document.forms['form1'].elements['CATPRIV_IDCATEGORIA'].value;
		var idFamilia=document.forms['form1'].elements['CATPRIV_IDFAMILIA'].value;
		var idSubfamilia=document.forms['form1'].elements['CATPRIV_IDSUBFAMILIA'].value;
		var idGrupo=document.forms['form1'].elements['CATPRIV_IDGRUPO'].value;

//alert('idPE: '+idProductoEstandar+' , idG: '+idGrupo+' , idSF: '+idSubfamilia+' , idF: '+idFamilia+' , idC: '+idCategoria);

		parent.zonaProducto.location.href='http://www.newco.dev.br/ProcesosCdC/CatalogoPrivado/ZonaProductos.xsql?IDPRODUCTOESTANDAR='+idProductoEstandar+'&IDGRUPO='+idGrupo+'&IDSUBFAMILIA='+idSubfamilia+'&IDFAMILIA='+idFamilia+'&IDCATEGORIA='+idCategoria;
	}else{
//				CargarProductoEstandarEnBlanco();
	}

	if(!parent.areaTrabajo.location.href.match('BuscadorFrame.xsql'))
		if(propagar!='NOPROPAGAR')
			parent.areaTrabajo.location.href='BuscadorFrame.xsql';
}

function CargarProductoEstandarEnBlanco(){
	var idSubfamilia=document.forms['form1'].elements['CATPRIV_IDSUBFAMILIA'].value;
	var idFamilia=document.forms[0].elements['CATPRIV_IDFAMILIA'].value;
	parent.zonaProducto.location.href='http://www.newco.dev.br/ProcesosCdC/CatalogoPrivado/ZonaProductos.xsql?IDPRODUCTOESTANDAR=-1&IDFAMILIA='+idFamilia+'&IDSUBFAMILIA='+idSubfamilia;
}

function montarDesplegable(arrayDatos,obj,defecto){
	obj.length=0;
	for(var n=0;n<arrayDatos.length;n++){
		if(defecto==arrayDatos[n][0]){
			var addOption=new Option('['+arrayDatos[n][1]+']',arrayDatos[n][0]);
			privilegiosPlantilla=arrayDatos[n][2];
			obj.options[obj.length]=addOption;
			obj.options[obj.length-1].selected=true;
		}else{
			var addOption=new Option(arrayDatos[n][1],arrayDatos[n][0]);
			obj.options[obj.length]=addOption;
		}
	}
}

// Funcion que revisa si un producto estandar tiene consumo historico y lo borra si no hay consumo
function BorrarProductoEstandarSinConsumo(oForm){
	var IDProdEstandar	= oForm.elements['CATPRIV_IDPRODUCTOESTANDAR'].value;
	var IDEmpresa		= oForm.elements['CATPRIV_IDEMPRESA'].value;
	var IDCategoria		= oForm.elements['CATPRIV_IDCATEGORIA'].value;
	var IDFamilia		= oForm.elements['CATPRIV_IDFAMILIA'].value;
	var IDSubfamilia	= oForm.elements['CATPRIV_IDSUBFAMILIA'].value;
	var IDGrupo		= oForm.elements['CATPRIV_IDGRUPO'].value;
	var d = new Date();

	jQuery.ajax({
		cache:	false,
		url:	'http://www.newco.dev.br/ProcesosCdC/CatalogoPrivado/ProductoEstandarConConsumoAJAX.xsql',
		type:	"GET",
		data:	"ID_PROD_EST="+IDProdEstandar+"&_="+d.getTime(),
		contentType: "application/xhtml+xml",
		success: function(objeto){
			var data = eval("(" + objeto + ")");

			if(data.consumo == 'No'){
				// Producto Estandar no tiene consumo => se puede borrar
				if(buscarHijos(IDProdEstandar,arrayProductosEstandar,3)==0){
					if(confirm(borrar_prod_estandar)){
						document.location.href='ZonaCatalogo.xsql?IDEMPRESA='+IDEmpresa+'&IDNUEVACATEGORIA='+IDCategoria+'&IDNUEVAFAMILIA='+IDFamilia+'&IDNUEVASUBFAMILIA='+IDSubfamilia+'&IDNUEVOGRUPO='+IDGrupo+'&IDNUEVOPRODUCTOESTANDAR='+IDProdEstandar+'&ACCION=BORRARPRODUCTOESTANDAR';
						var objFrame=new Object();
						parent.areaTrabajo.location.href='BuscadorFrame.xsql';
					}
				}else{
					alert(clientes_utilizan_prod_estandar);
				}
			}else if(data.consumo == 'Si'){
				// Producto Estandar tiene consumo => NO se puede borrar
				alert(prod_estandar_con_consumo);
			}else{
				// Se ha producido un error
				alert(borrar_prod_estandar_error);						
			}
		},
		error: function(xhr, errorString, exception) {
			alert("xhr.status="+xhr.status+" error="+errorString+" exception="+exception);
		}
	});
}
