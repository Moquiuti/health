//	Funciones de Javascript utilizadas en HTML.xsl
//	Ultima revision: ET 5feb20 15:02 EISDatos_050220.js

//	Datos globales: matriz de datos del EIS, maximo 1000 lineas
var		NumLineas,						//	Numero de lineas de la tabla (la ultima contiene el total)
		IDGrupos=new Array(1000),
		NombresGrupos=new Array(1000),	//	Nombre del grupo (linea)
		IDIndicadores=new Array(1000),	//	Indicador para cada linea de la tabla
		NombresIndicadores=new Array(1000),	//	Indicador para cada linea de la tabla
		Valores=new Array(13000),		//	Matriz de valores (Grupos * Meses)
		Colores=new Array(13000),		//	Matriz de colores (Grupos * Meses)
		Valor,
		NombresMeses=new Array(13),		//	Nombre de los meses
		Meses=new Array(13),			//	Mes para cada columna
		Annos=new Array(13),			//	Anno para cada columna
		TablaPreparada='N',				//	Tabla ya calculada
		LineaActiva=new Array(1000),	//	Indica si la linea de la tabla está activa (y se mostrará) u oculta
		Errores='',						//	Control de errores
		ColumnaOrdenacion='',			//	Columna sobre la que se ordena
		Orden='',						//	ASC o DESC
		ColumnaOrdenada=new Array(1000);//	Indices ordenados de la columna de orden
		 		//indicador de position

jQuery(document).ready(globalEvents);

function globalEvents()
{

	ActivarPestanna('pes_TablaDatos');	//	3feb20

	// Si se cambia la seleccion del desplegable de Anno => Recargamos la pï¿½gina haciendo peticion a EISCambioAnyo.xsql (sin pasar valor de los desplegbales)
	jQuery("#ANNO").change(function(){
		if(jQuery('#ANNO').val() < 2012 && (jQuery('#AGRUPARPOR').val() == 'CAT' || jQuery('#AGRUPARPOR').val() == 'FAM' || jQuery('#AGRUPARPOR').val() == 'SF' || jQuery('#AGRUPARPOR').val() == 'GRU')){
			alert(txtValidacionAnnos);
		}else{
			jQuery("#MostrarCuadro").hide();
			jQuery("#waitBox").show();
			document.forms['formEIS'].action = 'EISCambioAnyo.xsql';
			document.forms['formEIS'].submit();
                }
	});

	// Dependiendo de la seleccion del menu anyo => No permitir desplegables de opciones avanzadas
	if(jQuery('#ANNO').val() < 2012){
		// No permitir opciones avanzadas (desplegables categorias, familias, subfamilias, grupos, productos)
		if(jQuery("#IDCATEGORIA").length > 0){
			jQuery('#IDCATEGORIA').attr('disabled', 'disabled');
			jQuery("#IDCATEGORIA").val('-1');
		}
		if(jQuery("#IDFAMILIA").length > 0){
			jQuery('#IDFAMILIA').attr('disabled', 'disabled');
			jQuery("#IDFAMILIA").val('-1');
		}
		if(jQuery("#IDSUBFAMILIA").length > 0){
			jQuery('#IDSUBFAMILIA').attr('disabled', 'disabled');
			jQuery("#IDSUBFAMILIA").val('-1');
		}
		if(jQuery("#IDGRUPO").length > 0){
			jQuery('#IDGRUPO').attr('disabled', 'disabled');
			jQuery("#IDGRUPO").val('-1');
		}
		if(jQuery("#IDPRODUCTOESTANDAR").length > 0){
			jQuery('#IDPRODUCTOESTANDAR').attr('disabled', 'disabled');
			jQuery("#IDPRODUCTOESTANDAR").val('-1');
		}
		if(jQuery('#AGRUPARPOR').val() == 'FAM' || jQuery('#AGRUPARPOR').val() == 'SF' || jQuery('#AGRUPARPOR').val() == 'CAT' || jQuery('#AGRUPARPOR').val() == 'GRU')
			alert('No es posible agrupar por \'Familia\' o \'Subfamilia\' para aï¿½os anteriores a 2012.\nPor favor, cambia uno de esos valores!');
	}

	jQuery('#AGRUPARPOR').change(function(){
		if(jQuery('#ANNO').val() < 2012 && (jQuery('#AGRUPARPOR').val() == 'FAM' || jQuery('#AGRUPARPOR').val() == 'SF' || jQuery('#AGRUPARPOR').val() == 'CAT' || jQuery('#AGRUPARPOR').val() == 'GRU'))
			alert('No es posible agrupar por \'Familia\' o \'Subfamilia\' para aï¿½os anteriores a 2012.\nPor favor, cambia uno de esos valores!');
	});

	// Si el usuario comprador no es admin => solicitar primer nivel del catalogo privado
	if(userRol == 'COMPRADOR' && userDerechos != 'MVM' && userDerechos != 'MVMB'){
		NivelesEmpresa(null,'CAT');
	}

	// Se selecciona un valor diferente del desplegable TOP => dibujamos la matriz con las nuevas filas
	jQuery("#TOP").change(function(){
		EvaluarTOP();
		generarTabla('');
	});

	jQuery('#IDCUADROMANDO').change(function(index,value){
		DatosCuadroDeMando(this.value);
	});
	jQuery(".divLeft img").mouseover(function(){	this.src = 'http://www.newco.dev.br/images/'+this.id+'.gif';});
	jQuery(".divLeft img").mouseout(function(){	this.src = 'http://www.newco.dev.br/images/'+this.id+'1.gif';});

	// Abrimos el formulario para guardar la seleccion si se hace click en la imagen o escondemos si ya se muestra
	jQuery("#imgGuardarSeleccion").click(function(){
		if(jQuery("#divGuardarSeleccion").is(":visible")){
			jQuery("#imgGuardarSeleccion img ").attr("src", "http://www.newco.dev.br/images/sel.gif");
			jQuery("#divGuardarSeleccion").hide();
		}else{
			jQuery("#imgGuardarSeleccion img").attr("src", "http://www.newco.dev.br/images/contraer.gif");
			jQuery("#divGuardarSeleccion").show();
		}
	});

	// Solo mostramos la opcion de guardar seleccion para agrupaciones EMP, CEN, EMP2, CEN2, CAT, FAM, SF, GRU
	jQuery("#AGRUPARPOR").change(function(){
		if(this.value == "USU" || this.value == "EST" || this.value == "PRO" || this.value == "REF" || this.value == "REFPROV" || this.value == "DES"){
			jQuery("#imgGuardarSeleccion").hide();
			jQuery("#divGuardarSeleccion").hide();
		}else{
			jQuery("#imgGuardarSeleccion img ").attr("src", "http://www.newco.dev.br/images/sel.gif");
			jQuery("#imgGuardarSeleccion").show();
			jQuery("#divGuardarSeleccion").hide();
		}
	});

	// Si elegimos alguna seleccion guardada en los desplegables, mostramos la opcion de borrar
	jQuery(".seleccion").change(function(){
		if(this.value.substr(0,4) == 'SEL_'){
			jQuery("span#borrarSEL_" + this.id).show();
		}else{
			jQuery("span#borrarSEL_" + this.id).hide();
		}
	});

	// Si venimos de enlaces del cat. priv., puede que se tengan que recargar algunos desplegables (centros, categoria o familia, etc...)
	if(jQuery('#IDEMPRESA').length && jQuery('#IDEMPRESA').val() != '' && jQuery('#IDEMPRESA').val() != '-1'){
		if(jQuery('#ANNO').val() > 2011){
			NivelesEmpresa(null,'CAT');
			ListaCentrosDeEmpresa('IDEMPRESA',jQuery('#IDEMPRESA').val());
                }
	}

	
	// Click en tabla datos
	jQuery("#pes_TablaDatos").click(function()
	{
		ActivarPestanna("pes_TablaDatos");
		VerDatos();
	});

	// Click en grafico
	jQuery("#pes_Grafico").click(function()
	{
		ActivarPestanna("pes_Grafico");
		VerGrafico();
	});

	// click en SQL
	jQuery("#pes_SQL").click(function()
	{
		ActivarPestanna("pes_SQL");
		VerSQL();
	});

}

//	5feb20
function ActivarPestanna(pestanna)
{
	jQuery(".pestannas a").attr('class', 'MenuInactivo');
	jQuery("#"+pestanna).attr('class', 'MenuActivo');
}


function DatosCuadroDeMando(IDCuadroDeMando){
	var IDEmpresaAux;
	var d = new Date();

	if(jQuery('#IDEMPRESA').length > 0)	
		IDEmpresaAux = jQuery('#IDEMPRESA').val();
    else
		IDEmpresaAux = IDEmpresaDelUsuario;

	jQuery.ajax({
		cache:	false,
		url:	'EISIndicador.xsql',
		type:	"GET",
		data:	"IDCuadroDeMando="+IDCuadroDeMando+"&_="+d.getTime(),
		contentType: "application/xhtml+xml",
		error: function(objeto, quepaso, otroobj){
			alert('error'+quepaso+' '+otroobj+''+objeto);
		},
		success: function(objeto){
			var data = eval("(" + objeto + ")");

			IDIndicador = data.DatosCuadroDeMando[0].id;
			if(IDEmpresaAux != -1)
				NivelesEmpresa(null,'CAT');
		}
	});
}

// Peticion ajax que devuelve una lista segun el nivel que se pida (Categorias, Familias, Subfamilias, Grupos o Productos Estandar)
// Se crean las filas y los menus desplegables segun corresponda
function ListaNivel(IDPadre,tipo){
	var d = new Date();

	// Si elegimos alguna de las opciones guardadas de seleccion, no se lanza peticion ajax
	if(IDPadre.substr(0,4) == 'SEL_')
		return;
	// Si elegimos alguna de las opciones que agrupan varios casos de los desplegables de categorias, no avanzamos al siguiente nivel
	else if(IDPadre < -1){
		VaciaNiveles(tipo);
		return;
        }


	var sql = encodeURIComponent(' ' + FiltroSQL.replace(/\'/g, "''"));
	var IDEmpresa;
	//var IDIndicadorSelec = jQuery('#IDCUADROMANDO').val();

	// Si existe #IDEMPRESA => usuario MVM o MVMB
	if(jQuery("#IDEMPRESA").length > 0){
		IDEmpresa = jQuery("#IDEMPRESA").val();
	// Si NO existe #IDEMPRESA => Cliente
        }else
		IDEmpresa = IDEmpresaDelUsuario;

	jQuery.ajax({
		cache:	false,
		url:	'EISListaNivel.xsql',
		type:	"GET",
		data:	"IDEmpresa="+IDEmpresa+"&IDPadre="+IDPadre+"&IDIndicador="+IDIndicador+"&FiltroSQL="+sql+"&Tipo="+tipo+"&_="+d.getTime(),
		contentType: "application/xhtml+xml",
		error: function(objeto, quepaso, otroobj){
			alert('error'+quepaso+' '+otroobj+''+objeto);
		},
		success: function(objeto){
			var data = eval("(" + objeto + ")");

			if(tipo == 'CAT'){
				if(jQuery('#' + data.Field.name).length > 0){
					VaciaNiveles('FAM');
					jQuery("#" + data.Field.name).empty();
					jQuery("#" + data.Field.name).removeAttr("disabled");
					jQuery("#" + data.Field.name).unbind('change').bind('change',function(){ ListaNivel(this.value,'FAM'); });
				}
			}else if(tipo == 'FAM'){
				if(jQuery('#' + data.Field.name).length > 0){
					VaciaNiveles('SF');
					jQuery("#" + data.Field.name).empty();
					jQuery("#" + data.Field.name).removeAttr("disabled");
					jQuery("#" + data.Field.name).unbind('change').bind('change',function(){ ListaNivel(this.value,'SF'); });
				}
			}else if(tipo == 'FAMEMP'){
				if(jQuery('#' + data.Field.name).length > 0){
					jQuery("#IDCATEGORIA").attr("disabled", "disabled");
					VaciaNiveles('SF');
					jQuery("#" + data.Field.name).empty();
					jQuery("#" + data.Field.name).removeAttr("disabled");
					jQuery("#" + data.Field.name).unbind('change').bind('change',function(){ ListaNivel(this.value,'SF'); });
				}
			}else if(tipo == 'SF'){
				if(jQuery('#' + data.Field.name).length > 0){
					VaciaNiveles('GRU');
					jQuery("#" + data.Field.name).empty();
					jQuery("#" + data.Field.name).removeAttr("disabled");
					jQuery("#" + data.Field.name).unbind('change').bind('change',function(){ NivelesEmpresa(this.value,'GRU'); });
				}
			}else if(tipo == 'GRU'){
				if(jQuery('#' + data.Field.name).length > 0){
					VaciaNiveles('PRO');
					jQuery("#" + data.Field.name).empty();
					jQuery("#" + data.Field.name).removeAttr("disabled");
					jQuery("#" + data.Field.name).unbind('change').bind('change',function(){ ListaNivel(this.value,'PRO'); });
				}
			}else if(tipo == 'PROSF'){
				if(jQuery('#' + data.Field.name).length > 0){
					jQuery("#IDGRUPO").attr("disabled", "disabled");
					jQuery("#" + data.Field.name).empty();
					jQuery("#" + data.Field.name).removeAttr("disabled");
				}
			}else if(tipo == 'PRO'){
				if(jQuery('#' + data.Field.name).length > 0){
					jQuery("#" + data.Field.name).empty();
					jQuery("#" + data.Field.name).removeAttr("disabled");
				}
			}

			for(var i=0;i<data.ListaNivel.length;i++){
				jQuery("#" + data.Field.name).append("<option value='"+data.ListaNivel[i].id+"'>"+data.ListaNivel[i].nombre+"</option>");
				jQuery("#" + data.Field.name).val("-1");
			}
		}
	});
}

// Peticion ajax que devuelve los valores de las marcas <MOSTRARCATEGORIAS> y <MOSTRARGRUPOS> para la empresa seleccionada
// De esta manera construimos los desplegables de los diferentes niveles segun corresponda
function NivelesEmpresa(IDPadre,nivel){
	var d = new Date();

	// Si elegimos alguna de las opciones guardadas de seleccion, no se lanza peticion ajax
	if(IDPadre !== null && IDPadre.substr(0,4) == 'SEL_')
		return;

	// Si existe #IDEMPRESA => usuario MVM o MVMB
	if(jQuery("#IDEMPRESA").length > 0){
		var idEmpresa = jQuery("#IDEMPRESA").val();
	// Si NO existe #IDEMPRESA => Cliente
        }else
		var idEmpresa = IDEmpresaDelUsuario;

	jQuery.ajax({
		cache:	false,
		url:	'EISNivelesEmpresa.xsql',
		type:	"GET",
		data:	"IDEmpresa="+idEmpresa+"&_="+d.getTime(),
		contentType: "application/xhtml+xml",
		error: function(objeto, quepaso, otroobj){
			alert('error'+quepaso+' '+otroobj+''+objeto);
		},
		success: function(objeto){
			var data		= eval("(" + objeto + ")");
			var IDEmpresa		= data.NivelesEmpresa.IDEmpresa;
			var mostrarCategoria	= data.NivelesEmpresa.MostrarCategorias;
			var mostrarGrupo	= data.NivelesEmpresa.MostrarGrupos;

			if(nivel == 'CAT'){
				if(mostrarCategoria == 'S'){
					ListaNivel(IDEmpresa,'CAT');
				}else{
					ListaNivel(IDEmpresa,'FAMEMP');
				}
			}else if(nivel == 'GRU'){
				if(mostrarGrupo == 'S'){
					ListaNivel(IDPadre,'GRU');
				}else{
					ListaNivel(IDPadre,'PROSF');
				}
			}
		}
	});
}

// Peticion ajax que devuelve las opciones del desplegable de 'Centros' dada una Empresa (IDEMPRESA)
// Si el desplegable existe, se cambian los elementos option
// Si el desplegable no existe todavia, se crean una nueva fila en la tabla con el select correspondiente
function ListaCentrosDeEmpresa(id,idEmpresa){
	var d = new Date();
	var sql = encodeURIComponent(' ' + FiltroSQL.replace(/\'/g, "''"));
//	var IDIndicadorSelec = jQuery('#IDCUADROMANDO').val();

	// Inhabilitamos los desplegables para los 5 niveles ya que hemos elegido una nueva empresa
	VaciaNiveles('CAT');

	// Si elegimos alguna de las opciones guardadas de seleccion, no se lanza peticion ajax
	if(idEmpresa.substr(0,4) == 'SEL_')
		return;

	jQuery.ajax({
		cache:	false,
		url:	'EISListaCentrosEmpresa.xsql',
		type:	"GET",
		data:	"IDEmpresa="+idEmpresa+"&IDIndicador="+IDIndicador+"&FiltroSQL="+sql+"&_="+d.getTime(),
		contentType: "application/xhtml+xml",
		error: function(objeto, quepaso, otroobj){
			alert('error'+quepaso+' '+otroobj+''+objeto);
		},
		success: function(objeto){
			var data = eval("(" + objeto + ")");

			if(data.ListaCentros.length > 0){
				// Si el desplegable ya existe (a causa de una peticion previa), lo vaciamos...
				if(jQuery("select#" + data.Field.name).length > 0){
					jQuery("#" + data.Field.name).empty();
					jQuery("#" + data.Field.name).removeAttr('disabled');
				}

				for(i=0;i<data.ListaCentros.length;i++){
					jQuery("#" + data.Field.name).append("<option value='"+data.ListaCentros[i].id+"'>"+data.ListaCentros[i].nombre+"</option>");
					jQuery("#" + data.Field.name).val("-1");
				}

				if(idEmpresa != -1) // Si la eleccion del desplegable NO es 'Todas' (Empresas)
                                    // Una vez termina de informar el desplegable de centros => hacemos peticion para los desplegables del catalogo privado
                                    NivelesEmpresa(idEmpresa,'CAT');
			}
		}
	});
}

// Peticion ajax que devuelve las opciones del desplegable de 'Centros de Cliente' dado un Centro (IDEMPRESA2)
// Si el desplegable existe, se cambian los elementos option
// Si el desplegable no existe todavia, se crean una nueva fila en la tabla con el select correspondiente
function ListaCentrosDeCliente(id,idCliente){
	var d = new Date();

	// Si elegimos alguna de las opciones guardadas de seleccion, no se lanza peticion ajax
	if(idCliente.substr(0,4) == 'SEL_')
		return;

	var sql = encodeURIComponent(' ' + FiltroSQL.replace(/\'/g, "''"));

	jQuery.ajax({
		cache:	false,
		url:	'EISListaCentrosCliente.xsql',
		type:	"GET",
		data:	"IDEmpresa="+idCliente+"&IDCliente="+idCliente+"&IDIndicador="+IDIndicador+"&FiltroSQL="+sql+"&_="+d.getTime(),
		contentType: "application/xhtml+xml",
		error: function(objeto, quepaso, otroobj){
			alert('error'+quepaso+' '+otroobj+''+objeto);
		},
		success: function(objeto){
			var data = eval("(" + objeto + ")");

			if(data.ListaCentros.length > 0){
				// Si el desplegable ya existe (a causa de una peticion previa), lo vaciamos...
				if(jQuery("select#" + data.Field.name).length > 0){
					jQuery("#" + data.Field.name).empty();
					jQuery("#" + data.Field.name).removeAttr('disabled');
				}

				for(i=0;i<data.ListaCentros.length;i++){
					jQuery("#" + data.Field.name).append("<option value='"+data.ListaCentros[i].id+"'>"+data.ListaCentros[i].nombre+"</option>");
					jQuery("#" + data.Field.name).val("-1");
				}
			}
		}
	});
}

function VaciaNiveles(nivel){
	switch(nivel){
		case 'CAT':
			jQuery("#IDCATEGORIA").attr("disabled", "disabled");
			jQuery("#IDCATEGORIA").empty().append('<option value="-1" selected="selected"> [Todas] </option>');
		case 'FAM':
			jQuery("#IDFAMILIA").attr("disabled", "disabled");
			jQuery("#IDFAMILIA").empty().append('<option value="-1" selected="selected"> [Todas] </option>');
		case 'SF':
			jQuery("#IDSUBFAMILIA").attr("disabled", "disabled");
			jQuery("#IDSUBFAMILIA").empty().append('<option value="-1" selected="selected"> [Todas] </option>');
		case 'GRU':
			jQuery("#IDGRUPO").attr("disabled", "disabled");
			jQuery("#IDGRUPO").empty().append('<option value="-1" selected="selected"> [Todas] </option>');
		case 'PRO':
			jQuery("#IDPRODUCTOESTANDAR").attr("disabled", "disabled");
			jQuery("#IDPRODUCTOESTANDAR").empty().append('<option value="-1" selected="selected"> [Todas] </option>');
			break;
	}
}

//	Prepara los datos para ser enviados a la pagina con el grafico Google correspondiente
function PrepararTablaDatos(){

	var Enlace,
		CampoIndicador,
		Len,
		count=-1,
		IDGrupoActual='',
		NombreGrupoActual='',
		IDIndicadorActual='',
		NombreIndicadorActual='',
		Errores='',
		LineaActual='',
		UltimaLinea='',
		ProductoCopia='';			//	16mar11

	jQuery.each(ResultadosTabla, function(key, value){
		//	Recorremos el array ResultadosTabla, sin repetir las lineas
		if((key.substring(0,4)=='ROW|')&&((Piece(key,'|',1)!=IDIndicadorActual)||(Piece(key,'|',2)!=IDGrupoActual)||(Piece(key,'|',3)!=LineaActual))){
			//	Comprueba si hay cambio de indicador
			if(Piece(key,'|',1)!=IDIndicadorActual){
				IDIndicadorActual=Piece(key,'|',1);
				NombreIndicadorActual=ResultadosTabla["INDICADOR|"+IDIndicadorActual];
			}
			//	Comprueba si hay cambio de linea
			if(Piece(key,'|',3)!=LineaActual){
				UltimaLinea=LineaActual;
				LineaActual=Piece(key,'|',3);
			}
			//	Comprueba si hay cambio de grupo
			if(Piece(key,'|',2)!=IDGrupoActual || Piece(key,'|',3)!=UltimaLinea){
				// DC - 02may14
				// Control para comprobar que no nos encontramos con cambios en descripciones de productos
				//  que no se han propagado correctamente a los historicos
				if(Piece(key,'|',2)!=IDGrupoActual){
					ProductoCopia = '';
                                }else{
					ProductoCopia = '[DUPLICADO]';
				}
				IDGrupoActual=Piece(key,'|',2);
				NombreGrupoActual=ResultadosTabla["GRUPO|"+IDIndicadorActual+"|"+IDGrupoActual+'|'+LineaActual];

				// DC - 21/11/13 - Hay dos indicadores para los que se tiene que contar la fila de totales
				if(mostrarFilaTotal=='S' || (mostrarFilaTotal=='N' && IDGrupoActual!='99999Total'))
					count=count+1;
			}

			//	Filtramos la linea de totales
			// DC - 21/11/13 - Hay dos indicadores para los que se muestra la fila de totales
			if(mostrarFilaTotal=='S' || (mostrarFilaTotal=='N' && IDGrupoActual!='99999Total')){
				IDIndicadores[count]=IDIndicadorActual;
				NombresIndicadores[count]=NombreIndicadorActual;
				IDGrupos[count]=IDGrupoActual + ProductoCopia;
				NombresGrupos[count]=NombreGrupoActual;
				LineaActiva[count]='S';

				//	Recorremos todas las celdas de valores
				for(var k=1;k<=13;k++){
					Valores[count*13+k-1]=ANumero(ResultadosTabla['ROW|'+IDIndicadorActual+'|'+IDGrupoActual+'|'+LineaActual+'|'+k]);

					try{
						if(ResultadosTabla['ROW|'+IDIndicadorActual+'|'+IDGrupoActual+'|'+LineaActual+'|'+k+'|COLOR']=='ROJO')
							Colores[count*13+k-1]='R';
						if(ResultadosTabla['ROW|'+IDIndicadorActual+'|'+IDGrupoActual+'|'+LineaActual+'|'+k+'|COLOR']=='VERDE')
							Colores[count*13+k-1]='V';
						if(ResultadosTabla['ROW|'+IDIndicadorActual+'|'+IDGrupoActual+'|'+LineaActual+'|'+k+'|COLOR']=='NEGRO')
							Colores[count*13+k-1]='N';
					}
					catch(err){
						Colores[count*13+k-1]='?';
					}
				}
			}
		}
	});
	NumLineas=count;

	// Montamos array de meses
	NombresMeses[0]='';
	for(j=0;j<=11;j++){
		NombresMeses[j+1]=ListaMeses[j].nombreMes;
		Meses[j+1]=Piece(ListaMeses[j].mes,'/',0);
		Annos[j+1]=Piece(ListaMeses[j].mes,'/',1);
	}

	NombresMeses[13]='Total';
	Meses[13]='99';
	Annos[13]=Anno;

	//	Ordenacion por defecto
	ColumnaOrdenacion='';
	Orden='';
	OrdenarPorColumna(12);

	// Despues de hacer la ordenacion por defecto, evaluamos el desplegable TOP para mostrar el numero de lineas seleccionadas
//	if(TablaPreparada == 'N' && jQuery('#TOP').length)
//		EvaluarTOP();

	TablaPreparada='S';

	if (Errores!='') alert(Errores);	//solodebug!!!!
	//debugMatriz();			//solodebug: recuperamos la matriz y la mostramos en pantalla
}

//	Muestra el contenido de la matriz de valores (para depuracion)
function debugMatriz()
{
	var Matriz='';
	//	Meses
	for(var j=0;j<=13;j++){
		Matriz=Matriz+NombresMeses[j]+':';
	}
	Matriz=Matriz+'\n';

	//	Valores
	for(j=0;j<=NumLineas;j++){
		Matriz=Matriz+'['+LineaActiva[j]+' ord:'+ColumnaOrdenada[j]+']'+NombresGrupos[j]+':'+IDGrupos[j]+'|';	//+NombresIndicadores[j]+'('+IDIndicadores[j]+'):'
		for(var k=0;k<=13;k++){
			Matriz=Matriz+Valores[j*13+k]+':'+Colores[j*13+k]+'|';
		}
		Matriz=Matriz+'\n';
	}
	alert(Matriz);
}

function CompruebaLineasOcultas()
{
	for (var j=0;j<=NumLineas;j++)
		if (LineaActiva[j]=='N') return 'S';
	return 'N';
}

function CompruebaLineasActivas()
{
	for (var j=0;j<=NumLineas;j++)
		if (LineaActiva[j]=='S') return 'S';
	return 'N';
}

//	Devuelve los IDs de grupo de las lineas activas, separadas por '|'
function ListaLineasActivas()
{
	var Res='';

	for (var j=0;j<=NumLineas;j++)
		if (LineaActiva[j]=='S')
			Res=Res+IDGrupos[j]+'|';
	return Res;
}

function MostrarPosiciones(){	//	Posiciones relativas de los conceptos
	var Enlace;

	Enlace='http://www.newco.dev.br/Gestion/EIS/EISPosiciones.xsql?'
			+'SES_ID='+IDSesion
			+'&'+'IDCUADROMANDO='+IDCuadro
			+'&'+'ANNO='+Anno
			+'&'+'IDEMPRESA='+IDEmpresa
			+'&'+'IDCENTRO='+IDCentro
			+'&'+'IDUSUARIO='+IDUsuarioSel
			+'&'+'IDEMPRESA2='+IDEmpresa2
			+'&'+'IDCENTRO2='+IDCentro2
			+'&'+'IDPRODUCTO='+IDProducto
			+'&'+'IDGRUPO='+IDGrupo
			+'&'+'IDSUBFAMILIA='+IDSubfamilia
			+'&'+'IDFAMILIA='+IDFamilia
			+'&'+'IDCATEGORIA='+IDCategoria
			+'&'+'IDESTADO='+IDEstado
//			+'&'+'IDTIPOINCIDENCIA='+form.elements['OR_IDTIPOINCIDENCIA'].value
//			+'&'+'IDGRAVEDAD='+form.elements['OR_IDGRAVEDAD'].value
			+'&'+'REFERENCIA='+Referencia
			+'&'+'CODIGO='+Codigo
			+'&'+'IDRESULTADOS='+IDResultados
			+'&'+'AGRUPARPOR='+AgruparPor
			+'&'+'IDRATIO='+IDRatio;

	MostrarPag(Enlace, 'Posiciones');
}

//	Presenta la pagina con el listado correspondiente a la seleccion del usuario
//	Si hay lineas ocultas, pasar la lista de empresas concatenada
function MostrarListado(Indicador, Grupo, Anno, Mes)
{
	var Enlace;

	if ((Grupo=='99999Total') && (CompruebaLineasOcultas()=='S'))
		Cadena=ListaLineasActivas();
	else
		Cadena=Grupo;

	Enlace='http://www.newco.dev.br/Gestion/EIS/EISListado.xsql?'
			+'US_ID='+IDUsuario
			+'&'+'IDINDICADOR='+Indicador
			+'&'+'ANNO='+Anno
			+'&'+'MES='+Mes
			+'&'+'IDEMPRESA='+IDEmpresa
			+'&'+'IDCENTRO='+IDCentro
			+'&'+'IDUSUARIO='+IDUsuarioSel
			+'&'+'IDEMPRESA2='+IDEmpresa2
			+'&'+'IDCENTRO2='+IDCentro2
			+'&'+'IDPRODUCTO='+IDProducto
			+'&'+'IDGRUPOCAT='+IDGrupo
			+'&'+'IDSUBFAMILIA='+IDSubfamilia
			+'&'+'IDFAMILIA='+IDFamilia
			+'&'+'IDCATEGORIA='+IDCategoria
			+'&'+'IDESTADO='+IDEstado
			//+'&'+'IDTIPOINCIDENCIA='+form.elements['OR_IDTIPOINCIDENCIA'].value
			//+'&'+'IDGRAVEDAD='+form.elements['OR_IDGRAVEDAD'].value
			+'&'+'REFERENCIA='+Referencia
			+'&'+'CODIGO='+Codigo
			//+'&'+'IDNOMENCLATOR='+
			//+'&'+'URGENCIA='+
			+'&'+'AGRUPARPOR='+AgruparPor
			+'&'+'IDGRUPO='+Cadena;		//	Grupo;

	MostrarPag(Enlace, 'Listado');
}

function HabilitarRatios(form,valor,dspOrigen, dspDestino){
  if(form.elements[dspOrigen].value==valor){
	form.elements[dspDestino].disabled=false;
  }
  else{
	form.elements[dspDestino].selectedIndex=0;
	form.elements[dspDestino].disabled=true;
  }
}


//
//	Funciones necesarias para el uso de graficos
//

//	Busca un texto dentro del nombre de un campo
function BuscaCampo(form, Campo)
{
	var 	Nombre,
			Len=Campo.length;

	for (j=0;j<form.elements.length;j++)
	{
		if(form.elements[j].name.substring(0,Len)==Campo)
			Nombre=form.elements[j].name;
	}

	return Nombre;
}


//	Elimina el punto de una cadena y convierte ',' a '.' para poder convertir a numero
function PreparaNumero(Cadena){
	var	Res='';

	//alert(Cadena);

	try
	{
		for (i=0;i<Cadena.length;++i)
		{
			if (Cadena.charAt(i)!='.')
			{
				if (Cadena.charAt(i)!=',')
					Res=Res+Cadena.charAt(i);
				else
					Res=Res+'.';
			}
		}
	}
	catch(err)
	{
		Errores=Errores+'PreparaNumero: parametro vacio:'+err+'\n';
	}
	//alert(Res);
	return Res;
}


//	Elimina el punto de una cadena y convierte ',' a '.' para poder convertir a numero
function ANumero(Cadena){
	//alert(Cadena+'::'+PreparaNumero(Cadena)+'::'+parseFloat(PreparaNumero(Cadena))+'::'+parseFloat(Cadena));
	return(parseFloat(PreparaNumero(Cadena)));
}


//	Prepara los datos para ser enviados a la pagina con el grï¿½fico Google correspondiente
/*
function GraficoGoogle(){
	if (TablaPreparada=='N')	PrepararTablaDatos();

	var arrData = new Array();	// 2D array
	var arrAux  = new Array();	// 1D array

	// Preparamos el array de clientes para la leyenda
	arrAux.push('Clientes');
	for(var i=0;i<=NumLineas;i++){
		if (LineaActiva[i]=='S')
			arrAux.push(NombresGrupos[i]);
	}
	arrData.push(arrAux);	// Se coloca en el primer campo del array de 2D

	// Preparamos los diversos arrays
	for(i=0;i<12;i++){
		arrAux = [];
		arrAux.push(NombresMeses[i+1]);

		var linea=1;	//	contamos lineas visibles
		for(var l=0;l<=NumLineas;l++){
			if(LineaActiva[l]=='S'){
				arrAux.push(Valores[l*13+i]);
				linea++;
			}
		}
		arrData.push(arrAux);
	}

	var data = google.visualization.arrayToDataTable(arrData); //	Pasamos el array de datos para que lo convierta a tabla google chart

	// Set chart options
	var options = {
		fontSize:10,
		pointSize:3,	// Para que se vean los puntos de los datos en la grafica y se visualizen con roll-over
		width:1000,
		height:550,
		legend:{position: 'right', textStyle: {color: 'black', fontSize: 8}}
	};

	// Instantiate and draw our chart, passing in some options.
	var chart = new google.visualization.LineChart(document.getElementById('graficoGoogle'));
	chart.draw(data, options);
}
*/

//	EIS En blanco
function MostrarEISInicio(){
	MostrarPag('http://www.newco.dev.br/Gestion/EIS/EISInicio.xsql', 'Consulta');
}

//	Solo para pruebas con XML -> Algunos parametros no se pueden modificar
function MostrarXML(){
	//var Enlace;

	var Enlace='http://www.newco.dev.br/Gestion/EIS/XML.xsql?'
			+'US_ID='+IDUsuario
			+'&'+'IDCUADROMANDO='+IDCuadro
			+'&'+'ANNO='+Anno
			+'&'+'IDEMPRESA='+IDEmpresa
			+'&'+'IDCENTRO='+IDCentro
			+'&'+'IDUSUARIO='+IDUsuarioSel
			+'&'+'IDEMPRESA2='+IDEmpresa2
			+'&'+'IDCENTRO2='+IDCentro2
			+'&'+'IDPRODUCTO='+IDProducto
			+'&'+'IDGRUPO='+IDGrupo
			+'&'+'IDSUBFAMILIA='+IDSubfamilia
			+'&'+'IDFAMILIA='+IDFamilia
			+'&'+'IDCATEGORIA='+IDCategoria
			+'&'+'IDESTADO='+IDEstado
//			+'&'+'IDTIPOINCIDENCIA='+form.elements['OR_IDTIPOINCIDENCIA'].value
//			+'&'+'IDGRAVEDAD='+form.elements['OR_IDGRAVEDAD'].value
			+'&'+'REFERENCIA='+Referencia
			+'&'+'CODIGO='+Codigo
			+'&'+'AGRUPARPOR='+AgruparPor
			+'&'+'IDRESULTADOS='+IDResultados
			+'&'+'IDRATIO='+IDRatio;

	MostrarPag(Enlace, 'Prueba');
}

//	Abre una pagina con la ficha del grupo seleccionado
function MostrarFichaAgrupacion(ID){
	var Enlace, valAux, IDProdEstandar = 0, IDEmpresaCliente = 0;
	var Presentar=true;
	var form=document.forms[0];
	var AgruparPor = jQuery("#AGRUPARPOR").val();

	switch (AgruparPor)
	{
		case 'EMP':	Enlace='http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPDetalleFrame.xsql?VENTANA=NUEVA&EMP_ID=';
					break;
		case 'EMP2':	Enlace='http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPDetalleFrame.xsql?VENTANA=NUEVA&EMP_ID=';
					break;
		case 'CEN':	Enlace='http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/CENDetalle.xsql?ID=';
					break;
		case 'CEN2':	Enlace='http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/CENDetalle.xsql?ID=';
					break;
/*
		case 'PRO':		if(jQuery("#IDEMPRESA").length){
						IDEmpresaCliente	= jQuery("#IDEMPRESA").val()

						if(isNaN(IDEmpresaCliente) || IDEmpresaCliente < 1){

							IDProdEstandar	= -1;
						}else{
							valAux = ID.split(":");
							IDProdEstandar	= getIDProducto(valAux[0], IDEmpresaCliente);
                                                }
					}else{
						IDEmpresaCliente	= IDEmpresaDelUsuario;
						valAux = ID.split(":");
						IDProdEstandar	= getIDProducto(valAux[0], IDEmpresaCliente);
					}

					if(IDProdEstandar > 0){
						Enlace='http://www.newco.dev.br/ProcesosCdC/MantenimientoReducido/MantenimientoReducido.xsql?PRO_ID=' + IDProdEstandar + '&EMP_ID=' + IDEmpresaCliente;
					}else if(IDProdEstandar == -1){
						Presentar=false;
						Enlace='No hay una ficha definida agrupando por \'Producto\' sin seleccionar Cliente';
                                        }else{
						Presentar=false;
						Enlace='No hay una ficha definida agrupando por \'Producto\'';
					}
					break;
*/
		case 'USU':	Enlace='No hay una ficha definida agrupando por \'Usuario\'';
					Presentar=false;
					break;
		case 'REF':		if(jQuery("#IDEMPRESA").length){
						IDEmpresaCliente	= jQuery("#IDEMPRESA").val()

						if(isNaN(IDEmpresaCliente) || IDEmpresaCliente < 1){

							IDProdEstandar	= -1;
						}else{
							valAux = ID.split(":");
							IDProdEstandar	= getIDProducto(valAux[0], IDEmpresaCliente);
                                                }
					}else{
						IDEmpresaCliente	= IDEmpresaDelUsuario;
						valAux = ID.split(":");
						IDProdEstandar	= getIDProducto(valAux[0], IDEmpresaCliente);
					}

					if(IDProdEstandar > 0){
						Enlace='http://www.newco.dev.br/ProcesosCdC/MantenimientoReducido/MantenimientoReducido.xsql?PRO_ID=' + IDProdEstandar + '&EMP_ID=' + IDEmpresaCliente;
					}else if(IDProdEstandar == -1){
						Presentar=false;
						Enlace='No hay una ficha definida agrupando por \'Referencia\' sin seleccionar Cliente';
                                        }else{
						Presentar=false;
						Enlace='No hay una ficha definida agrupando por \'Referencia\'';
					}

//					Enlace='Referencia';
//					Presentar=false;
					break;
		case 'REFPROV':	Enlace='No hay una ficha definida agrupando por \'Ref. Proveedor\'';
					Presentar=false;
					break;
		case 'CAT':	Enlace='No hay una ficha definida agrupando por \'Categoria\'';
					Presentar=false;
					break;
		case 'FAM':	Enlace='No hay una ficha definida agrupando por \'Familia\'';
					Presentar=false;
					break;
		case 'SF':	Enlace='No hay una ficha definida agrupando por \'Subfamilia\'';
					Presentar=false;
					break;
		case 'GRU':	Enlace='No hay una ficha definida agrupando por \'Grupo\'';
					Presentar=false;
					break;
		case 'EST':	Enlace='No hay una ficha definida agrupando por \'Estado\'';
					Presentar=false;
					break;
		case 'DES':	Enlace='No hay una ficha definida agrupando por \'Descripcion\'';
					Presentar=false;
					break;
		default:	Enlace='No hay una ficha definida para este caso';
					Presentar=false;

	}

	if (Presentar==false)
		alert(Enlace)
	else{
//		if(document.forms['hiddens'].elements['OR_AGRUPARPOR'].value=='EMP2'){
		if(AgruparPor == 'EMP2'){
			MostrarPagPersonalizada(Enlace+ID,'Ficha',65,58,0,-50);
		}else{
//			if(document.forms['hiddens'].elements['OR_AGRUPARPOR'].value=='PRO'){
			if(AgruparPor == 'PRO' || AgruparPor == 'REF'){
				MostrarPagPersonalizada(Enlace,'Ficha',70,50,0,-50);
			}else{
				MostrarPag(Enlace+ID, 'Ficha');
			}
		}
	}
}

function VerDatos(){
	jQuery("#TablaDatos").show();
	jQuery("#Grafico").hide();
	jQuery("#SQL").hide();

	//document.getElementById('datosEIS').style.display ='none';
	//document.getElementById('graficoEIS').style.display ='block';
	//document.getElementById('sqlEIS').style.display ='block';
}

function VerGrafico(){

	//	GraficoGoogle();
	
	datosParaGrafico();

	jQuery("#TablaDatos").hide();
	jQuery("#Grafico").show();
	jQuery("#SQL").hide();

	//document.getElementById('datosEIS').style.display ='block';
	//document.getElementById('graficoEIS').style.display ='none';
	//document.getElementById('sqlEIS').style.display ='block';
}

function VerSQL(){
	jQuery("#TablaDatos").hide();
	jQuery("#Grafico").hide();
	jQuery("#SQL").show();

	//document.getElementById('datosEIS').style.display ='block';
	//document.getElementById('graficoEIS').style.display ='block';
	//document.getElementById('sqlEIS').style.display ='none';
}

//	Recorre los controles y activa los checkboxes de los Grupos
function Seleccionar(){
	var form=document.forms[0];
	var Estado=null;

	for(var i=0;(i<form.length)&&(Estado==null);i++){
		var k=form.elements[i].name;

		if(k.substring(0,12)=='CHECK_GRUPO|'){
			if(form.elements[i].checked == true )
				Estado=false;
			else
				Estado=true;
		}
	}

	for(var i=0;i<form.length;i++){
		var k=form.elements[i].name;

		if(k.substring(0,12)=='CHECK_GRUPO|'){
			form.elements[i].checked = Estado;
			//alert(form.elements[i].name+' vrvr '+form.elements[i].value);
		}
	}
}//fin seltodosClientes

function leccionar(Valor){
	var form=document.forms[0];

	for(j=0;j<form.elements.length;j++){
		if(form.elements[j].name.substring(0,12)=='CHECK_GRUPO|'){
			//codigo antiguo ok
			form.elements[j].checked=Valor;
		}
	}
}

//	Marca los Indicadores/grupos que deben dejarse y vuelve a presentar la tabla
//	Valor=true:dejar, Valor=false:quitar
function Activar(Valor){
	var form=document.forms[0];

	if(TablaPreparada=='N')	PrepararTablaDatos();
	for(j=0;j<form.elements.length;j++){
		if(form.elements[j].name.substring(0,12)=='CHECK_GRUPO|'){
			var	IDIndicador=Piece(form.elements[j].name,'|',1);
			var	IDGrupo=Piece(form.elements[j].name,'|',2);
			var	Pos=BuscaPosicion(IDIndicador, IDGrupo);

			if(Valor==true)	//	DEJAR
				if(form.elements[j].checked==true){
					LineaActiva[Pos]='S';
				}else
					LineaActiva[Pos]='N';
			else				//	QUITAR
				if(form.elements[j].checked==true)
					LineaActiva[Pos]='N';
		}
	}

	//	Si no hay lineas marcadas como activas no mostramos la tabla
	if(CompruebaLineasActivas()=='N'){
		alert('Es necesario que haya alguna linea activa');
		return;
	}

	//redibujar tabla
	generarTabla();
}

function TodasLineasActivas(){
	for(i=0;i<=NumLineas;++i)
		LineaActiva[i]='S';

	//	Recargamos los datos originales
	TablaPreparada='N';
	PrepararTablaDatos();

	//redibujar tabla
	generarTabla();
}

//	Busca a que linea se corresponde un par Indicador/Grupo
function BuscaPosicion(IDIndicador, IDGrupo){
	var Pos=-1;

	for(i=0;i<=NumLineas;i++){
		if((IDIndicadores[i]==IDIndicador)&&(IDGrupos[i]==IDGrupo))
			Pos=i;
	}

	return Pos;
}


//	Prepara un array con los ordenes correspondientes a una columna
//	PENDIENTE: separar ordenaciï¿½n segun indicador
function ordenamientoBurbuja(col, tipo){
	var NumLineasAux;
	// DC - 21/11/13 - Si hay fila totales, esta no se cuenta para ordenar
	if(mostrarFilaTotal == 'S')
		NumLineasAux = NumLineas -1;
	else
		NumLineasAux = NumLineas;

	for(var i=0; i<=NumLineas; i++)
		ColumnaOrdenada[i]=i;

	for(i=0; i<=NumLineasAux; i++){
		for(var j=i+1; j<=NumLineasAux; j++){
			if(Valores[ColumnaOrdenada[i]*13+col] > Valores[ColumnaOrdenada[j]*13+col]){
				temp=ColumnaOrdenada[j];
				ColumnaOrdenada[j]=ColumnaOrdenada[i];
				ColumnaOrdenada[i]=temp;
			}
		}
	}

	//	En caso de ordenaciï¿½n descendente intercambiamos de forma simï¿½trica el vector de ordenacion
	if(tipo=='DESC'){
		for(i=0; i<=NumLineasAux/2; i++){
			temp=ColumnaOrdenada[NumLineasAux-i];
			ColumnaOrdenada[NumLineasAux-i]=ColumnaOrdenada[i];
			ColumnaOrdenada[i]=temp;
		}
	}

	//debug	var depurar='';
	//debug	for (i=0; i<=NumLineas; i++)
	//debug		depurar=depurar+NombresGrupos[ColumnaOrdenada[i]]+':'+Valores[ColumnaOrdenada[i]*13+col]+'\n';
	//debug
	//debug	alert('Ordenacion:'+depurar);
}

//	Ordena por una columna
function OrdenarPorColumna(col, reordenar){
	// Asignamos valor por defecto sino se pasa el parametro
	reordenar = typeof reordenar !== 'undefined' ? reordenar : true;

	if(reordenar !== false){
		if(ColumnaOrdenacion==col){
			if(Orden=='ASC')
				Orden='DESC';
			else
				Orden='ASC';
		}else{
			ColumnaOrdenacion=col;
			Orden='DESC';
		}
        }

	// Ordenamos por la columna 'Concepto'
	if(col == -1)
		//	Ordenar alfabeticamente respecto el array NombresGrupos[]
		ordenamientoAlfabet(Orden);
	else
		//	Ordenar sobre esta columna
		ordenamientoBurbuja(col, Orden);

	//	Redibujar tabla
	if(reordenar !== false)
		generarTabla();
}

//	Variables con cadenas necesarias para construir el HTML de las tablas
var cellTitleStart = '<td align="right">';
var cellTitleStartClass = '<td align="right" class="selected">';
var cellTitleStartMod = '';
var cellTitleStartIndic = '<td align="left">';
var rowIndStart = '<tr class="subTituloTabla">';
var cellIndStart = '<td align="left" colspan="14">&nbsp;&nbsp;';
var rowStart = '<tr class="#CLASEPAROIMPAR#">';
var rowEnd = '</tr>';
var cellGroupStart = '&nbsp;<input type="checkbox" name="CHECK_GRUPO|#IDINDICADOR#|#IDGRUPO#"/>&nbsp;&nbsp;';
var cellTotalStart = '<td align="left">&nbsp;&nbsp;&nbsp;&nbsp;';
var cellStart = '<td align="right">';
var cellEnd = '</td>';
var macroEnlaceGrupo='<a class="grupo" href="javascript:MostrarFichaAgrupacion(\'#IDGRUPO#\');">';
var macroEnlaceNormal='<a class="#CLASS#" href="javascript:MostrarListado(\'#IDINDICADOR#\',\'#IDGRUPO#\',\'#ANNO#\',\'#MES#\');">';
var macroEnlaceTotal='<a class="grupo" href="#">';


//	Genera de forma dinámica la tabla de datos del EIS
function generarTabla(){
	
	//solodebug		debugMatriz();	
	
	//si filtramos por ratio quitamos totales
	var formEis = document.forms[0];
	try{
		var ratio = formEis.elements['IDRESULTADOS'].value;
	}catch(err){
		ratio='NO_RATIO';
	}

	var linea=0;
	var pos = 0;
	var HayOcultas='N';

	//	Total para cada indicador
	var Totales=new Array(13);
	for(k=1;k<=13;k++)  Totales[k]=0;

	var Clase;
	var cellStartThis;

	//var cadenaHtml='<table id="TablaDatos" width="100%" class="muyoscuro" border="0" align="center" cellspacing="1" cellpadding="3" >'
	var cadenaHtml='<tr class="titleTablaEIS">';

	//cadenaHtml=cadenaHtml+ cellTitleStartIndic + '&nbsp;&nbsp;Indicadores' +cellEnd;
	cadenaHtml=cadenaHtml+cellTitleStartIndic;
	cadenaHtml=cadenaHtml+ '<span style="float:left;padding-top:5px;">&nbsp;&nbsp;&nbsp;<a href="javascript:OrdenarPorColumna(-1);">' + txtConcepto + '</a>&nbsp;&nbsp;&nbsp;&nbsp;</span>';
	cadenaHtml=cadenaHtml+BotonArribaHTML(txtTodos, 'Seleccionar', 'javascript:Seleccionar();', 50)+BotonArribaHTML(txtResultados, 'Dejar todos los seleccionados', 'javascript:Activar(true);', 50)+BotonArribaHTML(txtVolver, 'Ver todas las lineas de datos', 'javascript:TodasLineasActivas();', 50) + cellEnd;


	for(i=1;i<=13;i++)
	{
		if((ColumnaOrdenacion==(i-1))&&(Orden!=''))
			cellTitleStartMod = cellTitleStartClass;
		else
			cellTitleStartMod = cellTitleStart;

		cadenaHtml=cadenaHtml+ cellTitleStartMod +'<a href="javascript:OrdenarPorColumna('+(i-1)+');">'+ NombresMeses[i]+'</a>'+cellEnd;
	}

    if(ResultadosTabla['MAX_LINEAS_'+IDIndicador] > 0 && ResultadosTabla['MAX_LINEAS_'+IDIndicador] != '')
	{
		var IDIndicadorActual='';

		for(i=0;i<=NumLineas;i++)
		{
			//	Comprueba si la linea esta activa
			if(LineaActiva[ColumnaOrdenada[i]]=='S'){
				linea++;
				pos++;

				//	Comprueba cambio de Indicador
				if(IDIndicadorActual!=IDIndicadores[ColumnaOrdenada[i]]){
					//	Muestra la linea de totales correspondiente al indicador anterior
					if(IDIndicadorActual!=''){
						//si filtramos por ratio no ensenyo totales
						if(ratio == 'RATIO'){
							cadenaHtml=cadenaHtml;
						}else{
							cadenaHtml=cadenaHtml+LineaTotalesHTML(IDIndicadorActual, Totales, linea, HayOcultas);
						}

						//	Inicializa la linea de totales
						for(k=1;k<=13;k++)  Totales[k]=0;
					}

					pos=1;
					cadenaHtml=cadenaHtml+rowIndStart+cellIndStart+NombresIndicadores[ColumnaOrdenada[i]]+cellEnd+rowEnd;
					IDIndicadorActual=IDIndicadores[ColumnaOrdenada[i]];
				}

				cellStartThis=Replace(cellGroupStart,'#IDINDICADOR#',IDIndicadorActual);
				cellStartThis=Replace(cellStartThis,'#IDGRUPO#',IDGrupos[ColumnaOrdenada[i]]);
				//cellStartThis= linea+cellStartThis;
				//cellStartThis=Replace(cellStartThis,'#CLASEPAROIMPAR#',((linea%2)==0?'par':'impar'));

				//para ensenyar
				if(pos < 10){
					pos = '0'+pos;
				}

				cadenaHtml=cadenaHtml+Replace(rowStart,'#CLASEPAROIMPAR#',((linea%2)==0?'par':'impar'))+'<td align="left">'+pos+cellStartThis+Replace(macroEnlaceGrupo,'#IDGRUPO#',IDGrupos[ColumnaOrdenada[i]])+NombresGrupos[ColumnaOrdenada[i]]+'</a>'+cellEnd;

				for(k=1;k<=13;k++){
					Totales[k]=Totales[k]+Valores[ColumnaOrdenada[i]*13+k-1];

					//alert('tot '+Totales[k]);

					Clase='celdanormal';
					if(k<13){
						Enlace=macroEnlaceNormal;
						if(Colores[ColumnaOrdenada[i]*13+k-1]=='R')	Clase='celdaconrojo';	//cellStart=redCellStart;
						if(Colores[ColumnaOrdenada[i]*13+k-1]=='V')	Clase='celdaconverde';	//cellStart=greenCellStart;
					}else
						Enlace=macroEnlaceNormal;

					Enlace=Replace(Enlace,'#CLASS#',Clase);
					Enlace=Replace(Enlace,'#IDINDICADOR#',IDIndicadores[ColumnaOrdenada[i]]);

					//Revisamos el IDGrupo por si se trata de una descripcion de producto con el prefijo [DUPLICADO]
					// Si es asi, la quitamos para que se puedan abrir bien los listados de pedidos
					Enlace=Replace(Enlace,'#IDGRUPO#',IDGrupos[ColumnaOrdenada[i]].replace('[DUPLICADO]',''));
					Enlace=Replace(Enlace,'#ANNO#',Annos[k]);
					Enlace=Replace(Enlace,'#MES#',Meses[k]);

					//cellStartThis=Replace(cellStart,'#CLASEPAROIMPAR#',((linea%2)==0?'par':'impar'));

					//formatNumbre
					//cadenaHtml=cadenaHtml+cellStart+Enlace+FormatNumber( parseFloat(Valores[ColumnaOrdenada[i]*13+k-1]),0,',','.')+'</a>'+cellEnd;
					//cadenaHtml=cadenaHtml+cellStart+Enlace+FormatNumber(Valores[ColumnaOrdenada[i]*13+k-1],0,',','.')+'</a>&nbsp;'+cellEnd;
					//cadenaHtml=cadenaHtml+cellStart+Enlace+Valores[ColumnaOrdenada[i]*13+k-1]+'</a>&nbsp;'+cellEnd;

					if(Valores[ColumnaOrdenada[i]*13+k-1] < 1 && Valores[ColumnaOrdenada[i]*13+k-1] > 0){
						if(ConvertirPorcentaje == 'N'){
							cadenaHtml=cadenaHtml+cellStart+Enlace+FormatNumber(Valores[ColumnaOrdenada[i]*13+k-1],4,',','.')+'</a>&nbsp;'+cellEnd;
                    	}else{
							cadenaHtml=cadenaHtml+cellStart+Enlace+FormatNumber(Valores[ColumnaOrdenada[i]*13+k-1]*100,4,',','.')+'%</a>&nbsp;'+cellEnd;
						}
					}else{
						if(ConvertirPorcentaje == 'N'){
							cadenaHtml=cadenaHtml+cellStart+Enlace+FormatNumber(Valores[ColumnaOrdenada[i]*13+k-1],4,',','.')+'</a>&nbsp;'+cellEnd;
                    	}else{
							cadenaHtml=cadenaHtml+cellStart+Enlace+FormatNumber(Valores[ColumnaOrdenada[i]*13+k-1]*100,4,',','.')+'%</a>&nbsp;'+cellEnd;
						}
					}

					//alert(cadenaHtml);
					//return false;
				}
				cadenaHtml=cadenaHtml+rowEnd;
			}
			else
				HayOcultas='S';
		}
		//si filtramos por ratio no ensenyo totales
		if(ratio == 'RATIO'){
			cadenaHtml=cadenaHtml;
		}else{
			cadenaHtml=cadenaHtml+LineaTotalesHTML(IDIndicadorActual, Totales, linea);
		}
    }else{
		cadenaHtml=cadenaHtml+'<tr><td colspan="14" align="center">'+txtSinResultados+'</td></tr>';
    }


	cadenaHtml=cadenaHtml+'<tr class="subTituloTabla"><td colspan="14" align="left">'+BotonArribaHTML(txtTodos, 'Seleccionar', 'javascript:Seleccionar();', 50)+BotonArribaHTML(txtResultados, 'Dejar todos los seleccionados', 'javascript:Activar(true);', 50)+BotonArribaHTML(txtVolver, 'Ver todas las lineas de datos', 'javascript:TodasLineasActivas();', 50)+'</td></tr>';

	jQuery("#TablaDatos").html(cadenaHtml);
	jQuery("#waitBox").hide();
	jQuery("#MostrarCuadro").show();
}


function BotonArribaHTML(texto, explicacion, funcion, ancho){
	var cadenaHtml='<table class="button" style="float:left;"  cellpadding="0" cellspacing="1" width="'+ancho+'"><tr><td align="center" valign="middle"><a href="#" onclick="'+funcion+'" >'+texto+'</a></td></tr></table>';
	return cadenaHtml;
}

//	Crea un boton HTML desde el javascript
function BotonHTML(texto, explicacion, funcion, ancho){
	var cadenaHtml='<table class="button" border="0" cellpadding="1" cellspacing="1" width="'+ancho+'"><tr><td class="strongAzul" align="center" valign="middle"><a href="'+funcion+'">'+texto+'</a></td></tr></table>';

	return cadenaHtml;
}

//	Genera la linea de totales
function LineaTotalesHTML(IDIndicador, Totales, linea, HayOcultas){
	var cadenaHtml;

	cellStartThis=Replace(cellTotalStart,'#IDINDICADOR#',IDIndicador);
	cellStartThis=Replace(cellStartThis,'#IDGRUPO#','99999Total');

	cadenaHtml=Replace(rowStart,'#CLASEPAROIMPAR#','medio')+cellStartThis+macroEnlaceTotal+'Total</a>'+cellEnd;

	for(k=1;k<=13;k++){
		Enlace=macroEnlaceNormal;
		Enlace=Replace(Enlace,'#CLASS#','celdanormal');
		Enlace=Replace(Enlace,'#IDINDICADOR#',IDIndicador);
		Enlace=Replace(Enlace,'#IDGRUPO#','99999Total')
		Enlace=Replace(Enlace,'#ANNOINICIO#',jQuery('#OR_ANNO').value);
		Enlace=Replace(Enlace,'#ANNO#',Annos[k]);
		Enlace=Replace(Enlace,'#MES#',Meses[k]);

		cadenaHtml=cadenaHtml+cellStart+Enlace+FormatNumber( Totales[k],4,',','.')+'&nbsp;</a>'+cellEnd;
	}
	cadenaHtml=cadenaHtml+rowEnd

	return cadenaHtml;
}


//	Da formato a un numero decimal
function FormatNumber(number, decimals, dec_point, thousands_sep){

	// Calculamos los decimales a mostrar segun el valor de number
	// number = 0	=> 0 decimales
	// number < 10	=> 2 decimales
	// number < 100	=> 1 decimal
	// number > 100	=> 0 decimales
    if(number == 0)			decimals = 0;
	else if(Math.abs(number) < 1)	decimals = 4;			//	23mar17
	else if(Math.abs(number) < 10)	decimals = 2;
    else if(Math.abs(number) < 100)	decimals = 1;
    else decimals = 0;

	var n = !isFinite(+number) ? 0 : +number,
		prec = !isFinite(+decimals) ? 0 : Math.abs(decimals),
		sep = (typeof thousands_sep === 'undefined') ? ',' : thousands_sep,        dec = (typeof dec_point === 'undefined') ? '.' : dec_point,
		s = '',
		toFixedFix = function (n, prec) {
			var k = Math.pow(10, prec);
			return '' + Math.round(n * k) / k;
		};

	// Fix for IE parseFloat(0.55).toFixed(0) = 0;
	s = (prec ? toFixedFix(n, prec) : '' + Math.round(n)).split('.');
	if(s[0].length > 3){
		s[0] = s[0].replace(/\B(?=(?:\d{3})+(?!\d))/g, sep);
	}
	if((s[1] || '').length < prec){
		s[1] = s[1] || '';
		s[1] += new Array(prec - s[1].length + 1).join('0');
	}

	return s.join(dec);
}


// needle may be a regular expression
function Replace(haystack, needle, replacement){
	var r = new RegExp(needle, 'g');
	return haystack.replace(r, replacement);
}

function Enviar(){
	var formEis = document.forms[0];
	if((formEis.elements['REFERENCIA'].value=='')||(ComprobarCadenasLargas(formEis.elements['REFERENCIA'].value,2)=='S')){
		SubmitForm(formEis);
	}else{
		alert('Las cadenas para la bï¿½squeda deben tener 2 caracteres o mï¿½s. Por favor, revise "'+formEis.elements['REFERENCIA'].value+'"');
	}
}

function TablaEISAjax(){
	var d = new Date();

	guardarValoresForm();

	// Por defecto los resultados del EIS se agrupan por Empresa (excepto admins - MVM o MVMB)
	if(userDerechos != 'MVM' && userDerechos != 'MVMB')
		if(AgruparPor == '-1')	AgruparPor = 'EMP';

	jQuery.ajax({
		cache:	false,
		url:	'EISDatos.xsql',
		type:	"GET",
		data:	"IDCUADROMANDO="+IDCuadro+"&ANNO="+Anno+"&IDEMPRESA="+IDEmpresa+"&IDCENTRO="+IDCentro+"&IDUSUARIO="+IDUsuarioSel+"&IDEMPRESA2="+IDEmpresa2+"&IDCENTRO2="+IDCentro2+"&IDPRODUCTO="+IDProducto+"&IDGRUPO="+IDGrupo+"&IDSUBFAMILIA="+IDSubfamilia+"&IDFAMILIA="+IDFamilia+"&IDCATEGORIA="+IDCategoria+"&IDESTADO="+IDEstado+"&REFERENCIA="+Referencia+"&CODIGO="+Codigo+"&AGRUPARPOR="+AgruparPor+"&IDRESULTADOS="+IDResultados+"&IDRATIO="+IDRatio+"&_="+d.getTime(),
		contentType: "application/xhtml+xml",
		beforeSend: function(){
			jQuery("#MostrarCuadro").hide();
			jQuery("#waitBox").show();
		},
		error: function(objeto, quepaso, otroobj){
			alert('error'+quepaso+' '+otroobj+''+objeto);
		},
		success: function(objeto){
			var data = eval("(" + objeto + ")");
			
			//solodebug	
			console.log(objeto);		

			// Redefinimos el array de los meses para la cabecera de la tabla
			ListaMeses		= [];
			var items;
			jQuery.each(data.DatosEIS[0].ListaMeses, function(arrayID, meses){
				items			= [];
				items['nombreMes']	= meses.nombre;
				items['mes']		= meses.mes;
				ListaMeses.push(items);
			});

			// Colocamos el nuevo nombre del indicador en la cabecera de la pagina
			var Indicador		= data.DatosEIS[1].Indicador[0].nombre;
			jQuery('span#NombreIndicador').html(Indicador);

			// Redefinimos el objeto Resultados para la tabla, la grafica, etc....
			IDIndicador		= data.DatosEIS[1].Indicador[0].id;
			ConvertirPorcentaje	= data.DatosEIS[1].Indicador[0].ConvPorcent;
			mostrarFilaTotal	= data.DatosEIS[1].Indicador[0].FilaTotales;

			ResultadosTabla	= {};
			ResultadosTabla['INDICADOR|'+data.DatosEIS[1].Indicador[0].id]	= data.DatosEIS[1].Indicador[0].nombre;
			ResultadosTabla['MAX_LINEAS_'+data.DatosEIS[1].Indicador[0].id]= data.DatosEIS[3].MaxLineas;
			if(data.DatosEIS[3].MaxLineas != ''){
				jQuery.each(data.DatosEIS[2].Filas, function(arrayFilaID, fila){
					ResultadosTabla['GRUPO|'+data.DatosEIS[1].Indicador[0].id+'|'+fila.IDGrupo+'|'+fila.Linea] = fila.NombreGrupo;

					jQuery.each(fila.Columnas, function(arrayColID, columna){
						ResultadosTabla['ROW|'+data.DatosEIS[1].Indicador[0].id+'|'+fila.IDGrupo+'|'+fila.Linea+'|'+columna.Columna] = columna.Total;
						ResultadosTabla['ROW|'+data.DatosEIS[1].Indicador[0].id+'|'+fila.IDGrupo+'|'+fila.Linea+'|'+columna.Columna+'|COLOR'] = columna.Color;
					});
				});
			}

			//	Preparamos los datos en las variables y mostramos el cuadro
			TodasLineasActivas();
			ActivarPestanna("pes_TablaDatos");
			VerDatos();
		}
	});
}

function TablaEISAjaxExcel(){
	var d = new Date();

	guardarValoresForm();

	// Por defecto los resultados del EIS se agrupan por Empresa (excepto admins - MVM o MVMB)
	if(userDerechos != 'MVM' && userDerechos != 'MVMB'){
		if(AgruparPor == '-1')	AgruparPor = 'EMP';
        }

	jQuery.ajax({
		cache:	false,
		url:	'Excel.xsql',
		type:	"GET",
		data:	"IDCUADROMANDO="+IDCuadro+"&ANNO="+Anno+"&IDEMPRESA="+IDEmpresa+"&IDCENTRO="+IDCentro+"&IDUSUARIO="+IDUsuarioSel+"&IDEMPRESA2="+IDEmpresa2+"&IDCENTRO2="+IDCentro2+"&IDPRODUCTO="+IDProducto+"&IDGRUPO="+IDGrupo+"&IDSUBFAMILIA="+IDSubfamilia+"&IDFAMILIA="+IDFamilia+"&IDCATEGORIA="+IDCategoria+"&IDESTADO="+IDEstado+"&REFERENCIA="+Referencia+"&CODIGO="+Codigo+"&AGRUPARPOR="+AgruparPor+"&IDRESULTADOS="+IDResultados+"&IDRATIO="+IDRatio+"&_="+d.getTime(),
		contentType: "application/xhtml+xml",
		error: function(objeto, quepaso, otroobj){
			alert('error'+quepaso+' '+otroobj+''+objeto);
		},
		success: function(objeto){
			var data = eval("(" + objeto + ")");

                        if(data.estado == 'ok') window.location='http://www.newco.dev.br/Descargas/'+data.url;
                        else alert('Se ha producido un error. No se puede descargar el fichero.');
                }
	});
}

function guardarValoresForm(){
	IDCuadro	= jQuery("#IDCUADROMANDO").val();
	Anno		= jQuery("#ANNO").val();
	if(jQuery("#IDEMPRESA").length > 0)
		IDEmpresa = jQuery("#IDEMPRESA").val();
	else
		IDEmpresa = IDEmpresaDelUsuario;
	if(jQuery("#IDCENTRO").length > 0)
		IDCentro = (jQuery("#IDCENTRO").val() != null) ? jQuery("#IDCENTRO").val() : '';
	else
		IDCentro = -1;

	if(jQuery("#IDUSUARIO").length > 0)
		IDUsuarioSel = jQuery("#IDUSUARIO").val();
	else
		IDUsuarioSel = -1;

	if(jQuery("#IDEMPRESA2").length > 0)
		IDEmpresa2		= jQuery("#IDEMPRESA2").val();
	else
		IDEmpresa2		= -1;
	if(jQuery("#IDCENTRO2").length > 0)
		IDCentro2 = (jQuery("#IDCENTRO2").val() != null) ? jQuery("#IDCENTRO2").val() : '';
	else
		IDCentro2 = -1;
	if(jQuery("#IDPRODUCTOESTANDAR").length > 0)
		IDProducto		= (jQuery("#IDPRODUCTOESTANDAR").val() != null) ? jQuery("#IDPRODUCTOESTANDAR").val() : '';
	else
		IDProducto		= -1;
	if(jQuery("#IDGRUPO").length > 0)
		IDGrupo = (jQuery("#IDGRUPO").val() != null) ? jQuery("#IDGRUPO").val() : '';
	else
		IDGrupo = -1;
	if(jQuery("#IDSUBFAMILIA").length > 0)
		IDSubfamilia		= (jQuery("#IDSUBFAMILIA").val() != null) ? jQuery("#IDSUBFAMILIA").val() : '';
	else
		IDSubfamilia		= -1;
	if(jQuery("#IDFAMILIA").length > 0)
		IDFamilia		= (jQuery("#IDFAMILIA").val() != null) ? jQuery("#IDFAMILIA").val() : '';
	else
		IDFamilia		= -1;
	if(jQuery("#IDCATEGORIA").length > 0)
		IDCategoria = (jQuery("#IDCATEGORIA").val() != null) ? jQuery("#IDCATEGORIA").val() : '';
	else
		IDCategoria = -1;
	IDEstado		= jQuery("#IDESTADO").val();
	Referencia		= jQuery("#REFERENCIA").val();
	Codigo			= jQuery("#CODIGO").val();
	AgruparPor		= jQuery("#AGRUPARPOR").val();
	IDResultados		= jQuery("#IDRESULTADOS").val();
	IDRatio			= jQuery("#IDRATIO").val();

	return;
}

function ordenamientoAlfabet(tipo){
	var NumLineasAux;
	// DC - 21/11/13 - Si hay fila totales, esta no se cuenta para ordenar
	if(mostrarFilaTotal == 'S')
		NumLineasAux = NumLineas-1;
	else
		NumLineasAux = NumLineas;

	for(var i=0; i<=NumLineas; i++)
		ColumnaOrdenada[i]=i;

	for(i=0; i<=NumLineasAux; i++){
		for(var j=i+1; j<=NumLineasAux; j++){
			if(NombresGrupos[i] > NombresGrupos[j]){
				temp=ColumnaOrdenada[j];
				ColumnaOrdenada[j]=ColumnaOrdenada[i];
				ColumnaOrdenada[i]=temp;
			}
		}
	}

	//	En caso de ordenacion descendente intercambiamos de forma simetrica el vector de ordenacion
	if(tipo=='DESC'){
		for(i=0; i<=NumLineasAux/2; i++){
			temp=ColumnaOrdenada[(NumLineasAux)-i];
			ColumnaOrdenada[(NumLineasAux)-i]=ColumnaOrdenada[i];
			ColumnaOrdenada[i]=temp;
		}
	}
}

function EvaluarTOP(){
	var TOP = jQuery('#TOP').val();
	var i;

	// Si no se muestran todas las filas
	if(TOP != -1){
		// Ordenar previamente segun columna 'total' (12) para marcar los valores TOP correctamente segun el array LineaActiva
		//	OrdenarPorColumna(12, false);

		for(i=0; i<TOP; i++){
			LineaActiva[ColumnaOrdenada[i]] = 'S';
		}
		for(i=TOP; i<=NumLineas; i++){
			LineaActiva[ColumnaOrdenada[i]] = 'N';
		}

		// Volvemos a ordenar las LineaActiva visibles segun el criterio seleccionado por el usuario
		//	OrdenarPorColumna(ColumnaOrdenacion, false);

	}else{
		for(i=0; i<=NumLineas; i++){
			LineaActiva[i] = 'S';
		}
	}
}

function GuardarSeleccion(){
	var NombreSeleccion_Pre	= jQuery('#NOMBRE_SELECCION').val();
	var NombreSeleccion	= encodeURIComponent(NombreSeleccion_Pre);
	var MostrarTodos	= jQuery('#PARA_TODOS').is(':checked');
	var Excluir_chck	= jQuery('#EXCLUIR').is(':checked');
	var Tipo_Seleccion	= jQuery('#AGRUPARPOR').val();
	var IDEmpresaSeleccion, Excluir, String_Seleccion = '';
	var d = new Date();

	if(NombreSeleccion == ''){
		alert(txtValNombreSel);
        	jQuery( "#NOMBRE_SELECCION" ).focus();
		return;
	}

	if(MostrarTodos ==! false){
		IDEmpresaSeleccion = IDEmpresaDelUsuario;
	}else{
		IDEmpresaSeleccion = '';
	}

	if(Excluir_chck ==! false){
		Excluir = 'S';
	}else{
		Excluir = 'N';
	}

	var Aux;
	jQuery('#TablaDatos input[type=checkbox]').each(function(){
		if (this.checked) {

			Aux = this.name.split('|');

			if(String_Seleccion == '')
				String_Seleccion = Aux[2];
			else
				String_Seleccion += '|'+Aux[2];
		}
	});

	if(Tipo_Seleccion == 'EMP' || Tipo_Seleccion == 'CEN' || Tipo_Seleccion == 'EMP2' || Tipo_Seleccion == 'CEN2' || Tipo_Seleccion == 'CAT' || Tipo_Seleccion == 'FAM' || Tipo_Seleccion == 'SF' || Tipo_Seleccion == 'GRU'){
		jQuery.ajax({
			cache:	false,
			url:	'EISGuardarSeleccion_ajax.xsql',
			type:	"GET",
			data:	"IDEMPRESA_SELECCION="+IDEmpresaSeleccion+"&NOMBRE_SELECCION="+NombreSeleccion+"&TIPO_SELECCION="+Tipo_Seleccion+"&STRING_SELECCION="+String_Seleccion+"&EXCLUIR_SELECCION="+Excluir+"&_="+d.getTime(),
			contentType: "application/xhtml+xml",
			error: function(objeto, quepaso, otroobj){
				alert('error'+quepaso+' '+otroobj+''+objeto);
			},
			success: function(objeto){
				var data = eval("(" + objeto + ")");

				if(data.ok == 'ok'){
					var IDSeleccion = data.id;

					// Colocamos la seleccion guardada en el desplegable correspondiente
					if(Tipo_Seleccion == 'EMP'){
						jQuery("#IDEMPRESA").append('<option value="SEL_' + IDSeleccion + '" selected="selected">*' + NombreSeleccion_Pre + '</option>');
					}else if(Tipo_Seleccion == 'CEN'){
						jQuery("#IDCENTRO").append('<option value="SEL_' + IDSeleccion + '" selected="selected">*' + NombreSeleccion_Pre + '</option>');
					}else if(Tipo_Seleccion == 'EMP2'){
						jQuery("#IDEMPRESA2").append('<option value="SEL_' + IDSeleccion + '" selected="selected">*' + NombreSeleccion_Pre + '</option>');
					}else if(Tipo_Seleccion == 'CEN2'){
						jQuery("#IDCENTRO2").append('<option value="SEL_' + IDSeleccion + '" selected="selected">*' + NombreSeleccion_Pre + '</option>');
					}else if(Tipo_Seleccion == 'CAT'){
						jQuery("#IDCATEGORIA").append('<option value="SEL_' + IDSeleccion + '" selected="selected">*' + NombreSeleccion_Pre + '</option>');
					}else if(Tipo_Seleccion == 'FAM'){
						jQuery("#IDFAMILIA").append('<option value="SEL_' + IDSeleccion + '" selected="selected">*' + NombreSeleccion_Pre + '</option>');
					}else if(Tipo_Seleccion == 'SF'){
						jQuery("#IDSUBFAMILIA").append('<option value="SEL_' + IDSeleccion + '" selected="selected">*' + NombreSeleccion_Pre + '</option>');
					}else if(Tipo_Seleccion == 'GRU'){
						jQuery("#IDGRUPO").append('<option value="SEL_' + IDSeleccion + '" selected="selected">*' + NombreSeleccion_Pre + '</option>');
					}

					// Si guardamos seleccion excluyente => recargamos la tabla con la nueva seleccion
					if(Excluir == 'S')	TablaEISAjax();

					// Damos aviso de OK y reinicializamos valores del formulario para guardar seleccion
					alert(txtSelGuardarOK);
					jQuery("#NOMBRE_SELECCION").val('');
					jQuery("#PARA_TODOS").removeAttr('checked');
					jQuery("#EXCLUIR").removeAttr('checked');
					jQuery("#imgGuardarSeleccion").click();


				}
        	        }
		});
        }else{
		alert(txtSelGuardarNO);
	}
}

function borrarSeleccion(IDDesplegable){
	var IDSeleccion_pre	= jQuery('#'+IDDesplegable).val();
	var IDSeleccion		= IDSeleccion_pre.substr(4);
	var d = new Date();

	jQuery.ajax({
		cache:	false,
		url:	'EISBorrarSeleccion_ajax.xsql',
		type:	"GET",
		data:	"IDSELECCION="+IDSeleccion+"&_="+d.getTime(),
		contentType: "application/xhtml+xml",
		error: function(objeto, quepaso, otroobj){
			alert('error'+quepaso+' '+otroobj+''+objeto);
		},
		success: function(objeto){
			var data = eval("(" + objeto + ")");

			if(data.ok == 'ok'){
				// Quitamos la seleccion borrada del desplegable  correspondiente
				jQuery('#' + IDDesplegable + ' option:selected').remove();
				// Escondemos la opcion de borrar la seleccion
				if(jQuery('#'+IDDesplegable).val().substr(4) != 'SEL_')
					jQuery('#borrarSEL_'+IDDesplegable).hide();
				alert(txtSelBorrarOK);
			}else{
				alert(txtSelBorrarKO + '\n\r' + 'ERROR: ' + data.error);
			}
       	        }
	});
}

function getIDProducto(Ref, IDEmpresaCliente){
	var IDProdEstandar = 0;
	var d = new Date();

	jQuery.ajax({
		cache:	false,
		url:	'EISBuscaIDProductoAJAX.xsql',
		type:	"GET",
		async:	false,
		data:	"REF="+Ref+"&IDEMPRESA="+IDEmpresaCliente+"&_="+d.getTime(),
		contentType: "application/xhtml+xml",
		error: function(objeto, quepaso, otroobj){
			alert('error'+quepaso+' '+otroobj+''+objeto);
		},
		success: function(objeto){
			var data = eval("(" + objeto + ")");

			if(data.IDProdEstandar){
				IDProdEstandar = data.IDProdEstandar;
			}
		}
	});

	return IDProdEstandar;
}


//	Paleta de colores, para hasta 40 líneas
var PaletaColores=['#0932F0','#204A87','#F00923','#48DAF1','#2EF953','#F28C87','#7C8486','#8F5902','#C17D11','#E9B96E','#EDD400',
'#729FCF','#73D216','#F57900','#FCE94F','#888A85','#A40000','#8F5902','#729FCF','#5C3566','#C4A000','#8AE234',
'#555753','#AD7FA8','#F4F137','#F4373B','#74A4E1','#CE259E','#873570','#F76E0B','#80CD18','#7279A5','#4F209F',
'#2E3436','#C6C44E','#3465A4','#F5902D','#A4EC43','#939EDC','#A37FE0','#7FE0CB','#516E94','#EB090E','#E32FCF'];

function preparaGrafico(filas, labels) 
{
	var Cadena="var ctx = document.getElementById('cvGrafico').getContext('2d');var myChart = new Chart(ctx, {type: 'line',data: {labels: labels,datasets: [";
	
	
	for (i=0;i<filas.length;++i)
	{
		Cadena+=((i==0)?'':',')+"{label: '"+filas[i].nombre+"', borderColor: \""+filas[i].color+"\", data: [";
		for  (j=0;j<filas[i].data.length;++j)
			Cadena+=((j==0)?'':',')+filas[i].data[j];
		
		Cadena+="]}";
		//console.log("PruebaRender("+i+"):"+Cadena);
	}
	Cadena+="]},});";

	//console.log("PruebaRender:"+Cadena);
	
	return eval(Cadena);
}


//	5feb20 Preparar los datos desde los arrays JS para mostrarlos en el gráfico
function datosParaGrafico()
{
	if (TablaPreparada=='N')	PrepararTablaDatos();

	var filas = new Array();	// 2D array
	var labels  = new Array();	// 1D array

	// etiquetas de meses
	for(i=0;i<12;i++)
	{
		labels.push(NombresMeses[i+1]);
	}
	
	//	Nombres de grupos y filas de datos
	for(var l=0;l<=NumLineas;l++)
	{
		if(LineaActiva[l]=='S')
		{
		
			//console.log('datosParaGrafico. LineaActiva ('+l+')');
		
			var fila=[];
			var datos=[];
			var cadDatos='';
			for(i=0;i<12;i++)
			{
				datos[i]=Valores[l*13+i];
	
				cadDatos+=datos[i]+'.';
				//console.log('datosParaGrafico. LineaActiva, dato('+l+','+i+'):'+datos[i]);
			}
			fila["data"]=datos;
			fila["color"]=PaletaColores[l%40];
			fila["nombre"]=NombresGrupos[l];
			
			//console.log('datosParaGrafico. LineaActiva ('+l+'):'+NombresGrupos[l]+':'+cadDatos);
		
			filas.push(fila);
		}
	}
	
	preparaGrafico(filas, labels);
}



