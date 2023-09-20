//	JS Selecciones/agrupaciones para consultas
//	Ultima revisión: ET 19nov21 17:00 EISSeleccion_191121.js


/*
function globalEvents()
{
    jQuery("#nuevaSel").click(function(){
		jQuery("#nuevaSeleccion").show();
		jQuery("#mantSeleccion").hide();
    });
}
*/

function onLoad()
{
	var IDSeleccion=jQuery("#IDSELECCION").val();

	console.log('onLoad. IDSeleccion:'+IDSeleccion);

	//	Bloquea el desplegable de tipo
	if (IDSeleccion!='')
	{
		jQuery("#IDTIPO").attr('disabled','disabled');
		//15abr20 Permitimos cambiar clasificación	jQuery("#IDCLASIFICACION").attr('disabled','disabled');
	
		//	Si es una selección de "areas geo", deshabilitamos estos checks
		CambioClasificacion();
	}
	
	//	Marca en la lista de origen los items seleccionados
	PreparaListas();
	//	Muestra los items no seleccionads en el SELECT
	Filtro1();
	//	Muestra el SELECT de origen que corresponda
	MostrarTipoSel();	
}

//	Extrae de la lista de entrada los elementos ya incluido en la lista de salida
function PreparaListas()
{
	var lista=ListaActiva();

	for (var i=0;i<idRegistros.length;++i)
	{
		MarcaSelEnLista(lista, idRegistros[i],'S');
	}
}

function MostrarTipoSel()
{
	var tipo=jQuery("#IDTIPO").val();
	jQuery("#FILTRO1").val('');
	
	jQuery("#liTipoDoc").show();

	//alert(tipo);
    if (tipo == 'EMP'){
        jQuery("#CENTROS").hide();
        jQuery("#PROVEEDORES").hide();
        jQuery("#EMPRESAS").show();
        jQuery("#TIPOSDOCUMENTOS").hide();
    }
    else if (tipo == 'CEN'){
        jQuery("#PROVEEDORES").hide();
        jQuery("#EMPRESAS").hide();
        jQuery("#CENTROS").show();
        jQuery("#TIPOSDOCUMENTOS").hide();
    }
    else if (tipo == 'EMP2'){
        jQuery("#EMPRESAS").hide();
        jQuery("#CENTROS").hide();
        jQuery("#PROVEEDORES").show();
        jQuery("#TIPOSDOCUMENTOS").hide();
    }
    else if (tipo == 'TDOC'){
        jQuery("#EMPRESAS").hide();
        jQuery("#CENTROS").hide();
        jQuery("#PROVEEDORES").hide();
        jQuery("#TIPOSDOCUMENTOS").show();
		jQuery("#liTipoDoc").hide();
    }
}


function Salir()
{
	window.location="http://www.newco.dev.br/Gestion/EIS/EISSelecciones.xsql?IDCLASIFICACION="+jQuery('#IDCLASIFICACION');	
}


//	En el caso de AREAGEO y MATERIAL, marcamos y bloqueamos los checkboxes correspondientes, si no, desbloqueamos
function CambioClasificacion()
{
	if ((jQuery("#IDCLASIFICACION").val()=='AREAGEO')||(jQuery("#IDCLASIFICACION").val()=='MATERIAL'))
	{
		jQuery("#CHK_AUTORIZADOS").attr('checked',true);
		jQuery("#CHK_EXCLUIDOS").attr('checked',false);
		jQuery("#CHK_AUTORIZADOS").attr('disabled','disabled');
		jQuery("#CHK_EXCLUIDOS").attr('disabled','disabled');
	}
	else
	{
		jQuery("#CHK_AUTORIZADOS").removeAttr("disabled");
		jQuery("#CHK_EXCLUIDOS").removeAttr("disabled");
	}
}


//	COmprueba cambios tras desactivar botón de "Publico"
function chkPublico(control)
{
	
	//solodebug	console.log('chkPublico. control:'+control);
	
    if (document.forms['Seleccion'].elements[control].checked === true)
	{
		document.forms['Seleccion'].elements['CHK_EXCLUIDOS'].checked = false;
		//if  ((jQuery("#IDCLASIFICACION").val()!='AREAGEO')&&(jQuery("#IDCLASIFICACION").val()!='MATERIAL'))
		//	document.forms['Seleccion'].elements['CHK_AUTORIZADOS'].checked = false;
	}
}


//	Comprueba cambios necesarios tras activar/desactivar botón de autorizados/excluidos
function AutorizadosYExcluidos(control)
{
	var Activado=false;	
	
	debug('AutorizadosYExcluidos('+control+')');
    if (document.forms['Seleccion'].elements[control].checked === true)
	{
		Activado=true;
	}
	
	if ((Activado === true) && (document.forms['Seleccion'].elements['CHK_PUBLICO']) && (document.forms['Seleccion'].elements['CHK_PUBLICO'].checked === true) && (jQuery("#IDCLASIFICACION").val()!='AREAGEO'))
	{
		document.forms['Seleccion'].elements['CHK_PUBLICO'].checked = false;
	}

	if ((control==='CHK_AUTORIZADOS') && (document.forms['Seleccion'].elements['CHK_EXCLUIDOS'].checked === true))
	{
		document.forms['Seleccion'].elements['CHK_EXCLUIDOS'].checked = false;
	}
	else if ((control==='CHK_AUTORIZADOS') && (document.forms['Seleccion'].elements['CHK_AUTORIZADOS'].checked === false))
	{
		jQuery("#IDCLASIFICACION").val('OTROS');
	}
	else if ((control==='CHK_EXCLUIDOS') && (document.forms['Seleccion'].elements['CHK_AUTORIZADOS'].checked === true))
	{
		document.forms['Seleccion'].elements['CHK_AUTORIZADOS'].checked = false;
		jQuery("#IDCLASIFICACION").val('OTROS');
	}
	
}

//	Incluye nuevo elemento en la lista de destino
function NuevoElemento()
{

    var option = '', elem=[];

	var obj=SelectActivo(), Nombre=NombreSelectActivo();
    for (var i=0; i<obj.options.length;i++){

        if (obj.options[i].selected == true){
		
			//solodebug	debug('NuevoElemento. Activo:'+i);
		
			var id = obj.options[i].value;
			
			//	Incluye el registro en el select de destino
            option += '<option value="'+obj.options[i].value+'">'+obj.options[i].text+'</option>';
            idRegistros.push(obj.options[i].value);
			elem.push(obj.options[i].value);
        }
    }	
	
	jQuery("#"+Nombre+" option:selected").remove();
    jQuery("#"+Nombre+" option[value="+id+"]").remove();
	
	jQuery('#REGISTRO_SEL').append(option);
	
}


//	Quita un elemento de la lista de destino
function QuitarElemento()
{

    var option = '';

	var destino=document.forms['Seleccion'].elements['REGISTRO_SEL'];
	
    for (var i=0; i<destino.options.length;i++){

        if (destino.options[i].selected == true){
		
			//solodebug	debug('NuevoElemento. Activo:'+i);
		
			var id = destino.options[i].value;
			
			//	Incluye el registro en el select de destino
            option += '<option value="'+destino.options[i].value+'">'+destino.options[i].text+'</option>';
            QuitaDeArray(idRegistros, destino.options[i].value);
			
        }
    }	
	
	jQuery("#REGISTRO_SEL option:selected").remove();
    jQuery("#REGISTRO_SEL option[value="+id+"]").remove();
	
	var obj=SelectActivo();
	jQuery(obj).append(option);
	
}


//	Desvuelve el objeto SELECT activo
function NombreSelectActivo()
{
	var Nombre;

	var tipo=jQuery("#IDTIPO").val();
    if (tipo == 'EMP') Nombre = 'EMPRESAS';
    else if (tipo == 'CEN') Nombre = 'CENTROS';
    else if (tipo == 'EMP2') Nombre = 'PROVEEDORES';
    else if (tipo == 'TDOC') Nombre = 'TIPOSDOCUMENTOS';
	
	return Nombre;
}

//	Desvuelve el objeto SELECT activo
function SelectActivo()
{
	var obj;
	obj = document.forms['Seleccion'].elements[NombreSelectActivo()];
	return obj;
}

//	Desvuelve la lista de elementos correspondiente al SELECT activo
function ListaActiva()
{
	var Lista;

	var tipo=jQuery("#IDTIPO").val();
    if (tipo == 'EMP') Lista = Empresas;
    else if (tipo == 'CEN') Lista = Centros;
    else if (tipo == 'EMP2') Lista = Proveedores;
    else if (tipo == 'TDOC') Lista = TiposDoc;
	
	return Lista;
}

//	Quita un registro de una lista
function QuitaDeLista(obj, ID)
{
	var Done=false;
    for (i=0; (i<obj.options.length)&&(!Done);i++){

        if (obj.options[i].value == ID){
            obj.options[i]=null;
			Done=true;
        }
    }
}

//	Quita un registro de una lista
function MarcaSelEnLista(obj, ID, valor)
{
	var Done=false;
    for (i=0; (i<obj.length)&&(!Done);i++)
	{
        if (obj[i].ID == ID){
            obj[i].Sel=valor;
			Done=true;
        }
    }
}

//	Quita un registro de una lista
function QuitaDeArray(obj, ID)
{
	var Done=false;
    for (i=0; (i<obj.length)&&(!Done);i++)
	{
        if (obj[i] == ID)
		{
            obj.splice(i,1);
			Done=true;
		}
    }
}


//	Comprueba si un valor está incluido en el array
function EnArray(obj, ID)
{
    for (i=0; (i<obj.length);i++)
	{
        if (obj[i]== ID)
		{
            return true;
        }
    }
	return false;
}


//	Guarda un array en un string, separando los eñlemento por el separador
function VuelcaArrayAString(obj, sep)
{
	var str='';
	for (var i=0;i<obj.length;++i)
	{
		str+=sep+obj[i];
	}
	return str;
}


//	Envia el form, registrando la accion
function EnviaForm(Accion)
{
	document.forms['Seleccion'].elements['ACCION'].value=Accion;
	SubmitForm(document.forms[0]);
}

//	Guarda el formulario actual. Los checks se guardan en campos hidden
function Guardar()
{
	var ListaRegistros=VuelcaArrayAString(idRegistros,'|');
	
	jQuery("#PUBLICO").val(jQuery("#CHK_PUBLICO").is(':checked')?'S':'N');
	jQuery("#TODOS_ADMIN").val(jQuery("#CHK_TODOS_ADMIN").is(':checked')?'S':'N');
	jQuery("#AUTORIZADOS").val(jQuery("#CHK_AUTORIZADOS").is(':checked')?'S':'N');
	jQuery("#EXCLUIDOS").val(jQuery("#CHK_EXCLUIDOS").is(':checked')?'S':'N');
		
	console.log('Guardar. ListaRegistros:'+ListaRegistros);
	
	document.forms['Seleccion'].elements['LISTAREGISTROS'].value=ListaRegistros;

	//	Activamos los elementos "disabled" para enviarlos también
	jQuery("#IDTIPO").removeAttr("disabled");
	jQuery("#IDCLASIFICACION").removeAttr("disabled");
	
	EnviaForm('GUARDAR');
}


// Filtro para las listas de origen
function Filtro1()
{
	var obj=SelectActivo();
	var filtro=jQuery("#FILTRO1").val().toUpperCase();
	var lista=ListaActiva();
	
	AplicaFiltroALista(obj, lista, filtro, 'N')
	
}

function Filtro2()
{
	var obj=jQuery("#REGISTRO_SEL");
	var filtro=jQuery("#FILTRO2").val().toUpperCase();
	var lista=ListaActiva();
	
	AplicaFiltroALista(obj, lista, filtro, 'S')
	
}


//	Aplica un filtro a un SELECT (obj) y lo carga a partir de una lista si el registro está seleccionado Sel
function AplicaFiltroALista(obj, lista, filtro, Sel)
{
	//	Vacia el select
	jQuery(obj).empty();
	
	//	Recorre la lista
	var option='';
	for (var i=0;i<lista.length;++i)
	{
		if (((filtro=='')||(lista[i].Nombre.toUpperCase().indexOf(filtro) > -1)) && (lista[i].Sel==Sel))
		{
			option += '<option value="'+lista[i].ID+'">'+lista[i].Nombre+'</option>';
		}
	}
	
	//solodebug	console.log('Filtro2. filtro:'+filtro+'. lista:'+lista.length+' option:'+option);
	
	jQuery(obj).append(option);
}





//	19jun19 Añadimos empresas por NIF, válido para nuevas selecciones o para existentes
//	19nov21 Se habia "perdido" esta funcion, la recuperamos
function AnadirEmpresaPorCod()
{
	//	19nov21	var registroSel = document.forms['Seleccion'].elements['ID_REGISTRO_SEL'].value+'|';
	
	var registroSel = VuelcaArrayAString(idRegistros,'|');
	
    var option = '', Nifs, Encontrados=0, noEnc, listaNoEnc='', listaRepes='';

	var obj=SelectActivo();
	/*
    if (jQuery("#EMPRESAS_NEW").is(':visible')){ obj = document.forms['Seleccion'].elements['EMPRESAS_NEW']; }
    else if (jQuery("#CENTROS_NEW").is(':visible')){ obj = document.forms['Seleccion'].elements['CENTROS_NEW']; }
    else if (jQuery("#PROVEEDORES_NEW").is(':visible')){ obj = document.forms['Seleccion'].elements['PROVEEDORES_NEW']; }
	else obj = document.forms['Seleccion'].elements['EMPRESAS'];
	*/
    if (jQuery("#CODIGOS_NEW").is(':visible')) Nifs = document.forms['Seleccion'].elements['CODIGOS_NEW'].value.replace(/(?:\r\n|\r|\n)/g, '·');
    else  Nifs = document.forms['Seleccion'].elements['CODIGOS'].value.replace(/(?:\r\n|\r|\n)/g, '·');

	//solodebug	
	console.log('AnadirEmpresaPorCod. SELECT:'+obj.name+ ' Nifs:'+Nifs);
	
	for (var j=0; j<=PieceCount(Nifs,'·');++j)
	{
		var Nif=Piece(Nifs,'·',j).trim();

		if (Nif!='')		//	Descarta líneas en blanco
		{
			var Enc='N', Ins='N';

			//	Busca el Nif en la tabla principal, para localizar el ID
			for (i=0; ((i<obj.options.length)&&(Enc=='N'));i++){

				//solodebug	console.log('AnadirEmpresaPorCod. Comprobando:'+obj.options[i].text.substr(1,Nif.length));

        		if (obj.options[i].text.substr(1,Nif.length+1) === Nif+')')				//	Comprobamos que el siguiente caracter sea ")" para evitar confusion con códigos cortos
				{
					Enc='S';
            		var id = obj.options[i].value;

            		if (registroSel.includes(id+'|'))
					{ 
						listaRepes+=(listaRepes==''?'':',')+Nif;
					}
            		else
					{

                		option += '<option value="'+obj.options[i].value+'">'+obj.options[i].text+'</option>';
                		registroSel +=obj.options[i].value+'|';
						Ins='S';
            		}
        		}
    		}
			if (Enc=='N') listaNoEnc+=(listaNoEnc==''?'':',')+Nif;
			else if (Ins=='S') ++Encontrados;
		}
	
	}
	
	//var Res='Incluidos: [INCLUIDOS]. No encontrados: [ERRORES]. Repetidos: [REPES].';
	alert(strRegistrosIncluidos.replace('[[INCLUIDOS]]',Encontrados).replace('[[ERRORES]]',(listaNoEnc==''?0:listaNoEnc)).replace('[[REPES]]',(listaRepes==''?0:listaRepes)));

	if (jQuery("#REGISTRO_SEL_NEW").is(':visible'))
	{
		jQuery("#REGISTRO_SEL_NEW").append(option);
	
		document.forms['Seleccion'].elements['CODIGOS_NEW'].value = '';
	}
	else
	{
		jQuery("#REGISTRO_SEL").append(option);
	
		document.forms['Seleccion'].elements['CODIGOS'].value = '';
	}
	document.forms['Seleccion'].elements['ID_REGISTRO_SEL'].value = registroSel;
	
}




