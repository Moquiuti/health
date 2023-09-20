//	JS para el envio de nuevas licitaciones via ajax a la plataforma medicalvm.com, con formato XML estandar Brasil
//	ultima revision ET 14abr23 10:03 IntegracionEstandarBrasil2022_140423.js


//
//	Bloque principal del código para procesar un fichero de SOLICITUD en formato "XML ESTANDAR BRASIL"
//
/*
<?xml version="1.0" encoding="WINDOWS-1252"?>
<Pedido layout="WA">
  <Cabecalho>
    <Requisicao>00007034</Requisicao>
    <Titulo_Pdc>Cota\u73a2o de MATERIAL DE USO E CONSUMO</Titulo_Pdc>
    <Id_Forma_Pagamento>00</Id_Forma_Pagamento>
    <Data_Vencimento>23/03/2023</Data_Vencimento>
    <Hora_Vencimento>09:11</Hora_Vencimento>
    <Moeda>R$</Moeda>
  </Cabecalho>
  <Itens_Requisicao>
    <Item_Requisicao>
      <Codigo_Produto>P03912</Codigo_Produto>
      <Descricao_Produto>SUCO 1 LITRO </Descricao_Produto>
      <Quantidade>12</Quantidade>
      <Campo_Extra>
        <Nome>Cod_Item_Solicitacao</Nome>
        <Valor>1</Valor>
      </Campo_Extra>
    </Item_Requisicao>
  </Itens_Requisicao>
</Pedido>
*/
function ProcesarSolicitudXMLEstandarBrasil(fileName, fileContent)
{
	// Cuando éste evento se dispara, los datos están ya disponibles.
	console.log('ProcesarSolicitudXMLEstandarBrasil '+fileName+':'+fileContent);

	//	Datos generales de la licitacion
	var ficRequisicao, ficTituloPdc, ficDataVencimento, ficHoraVencimento, ficMoeda, ficObservacao, ficUrgencia='N', licAvisosCarga='', ficControlErrores=''; 

	//	Variables de uso interno
	var count=0;
	var textoSalida='';
	
	//	14abr23 Inicializa ficProductos
	ficProductos = new Array();

	jQuery('#infoProgreso').html('Inicio: preparando solicitud a partir de XML estándar Brasil.');

	//	26may17 Pasamos a utilizar la librería ObjTree.js		
	try
	{
		var fileCorr=fileContent.replace(/&/g,'&amp;')
        var xotree = new XML.ObjTree();             
        var tree   = xotree.parseXML(fileCorr);
		
		
		console.log('Leyendo cabecera');
		//	recuperamos datos generales de la licitacion
		ficRequisicao=tree.Pedido.Cabecalho.Requisicao;
		ficTituloPdc=tree.Pedido.Cabecalho.Titulo_Pdc;
		ficDataVencimento=tree.Pedido.Cabecalho.Data_Vencimento;
		ficHoraVencimento=tree.Pedido.Cabecalho.Hora_Vencimento;
		ficMoeda=tree.Pedido.Cabecalho.Moeda;
		ficObservacao=tree.Pedido.Cabecalho.Observacao;
		//	Campos extra a nivel de licitacion
		//	ficUrgencia=tree.Pedido.Cabecalho.Campo_Extra.Nome;

		textoSalida='Requisicao:'+ficRequisicao+'<br/>'
				+' Titulo_Pdc:'+ficTituloPdc+'<br/>'
				+' Data_Vencimento:'+ficDataVencimento+'<br/>'
				+' Hora_Vencimento:'+ficHoraVencimento+'<br/>'
				+' Moeda:'+ficMoeda+'<br/>'
				+' Observacao:'+ficObservacao+'<br/>'
				+' Urgencia:'+ficUrgencia+'<br/>'+'<br/>';

		//solodebug
		console.log('Cabecera:'+textoSalida);
		textoSalida+='<br/>';
		
		
		//
		//	9oct17	En el caso de un único producto lo tratamos directamente
		//
		if (!Array.isArray(tree.Pedido.Itens_Requisicao.Item_Requisicao))
		{

			//solodebug	
			console.log('Recuperando un único producto del XML');
			
			var items		= [];
			items['Codigo']	= tree.Pedido.Itens_Requisicao.Item_Requisicao.Codigo_Produto;
			items['Descripcion'] = tree.Pedido.Itens_Requisicao.Item_Requisicao.Descricao_Produto;
			items['Cantidad'] = tree.Pedido.Itens_Requisicao.Item_Requisicao.Quantidade;
			items['IDProductoLic']	=0;		//	Pendiente de inicializar
			items['NifCentro']	= '';
			items['Precio']	= '';
			//	3abr19 Nuevos campos requeridos por la integración con Recoletas
			items['CodPed']	= '';
			items['LugarEntrega'] = '';		
			items['CentroCoste'] = '';		
			items['UdBasica'] = '';
			items['CodCenEnt'] = '';
			items['CodProv'] = '';
			items['CamposExtra'] = '';
			//	11jun19 Nuevos campos requeridos para la integración con Unimed
			items['Linea'] = '';
			items['Producto'] = '';
			items['Marca'] = '';
			items['IDSolicitud'] = '';		//	
			//	16mar20 TOTUS	
			items['CampoExtra1'] = '';
			items['CampoExtra2'] = '';
			items['CampoExtra3'] = '';
			items['CampoExtra4'] = '';
			items['CampoExtra5'] = '';
			items['CampoExtra6'] = '';


			//	1jun17 COmprobamos que la cantidad sea un número entero
			if (items['Cantidad'].indexOf(',')!=-1)
			{
				var CantidadOld=items['Cantidad'];
				items['Cantidad']=String(parseInt(items['Cantidad'].replace(",","."))+1);
				licAvisosCarga += items['Codigo']+': '+items['Descripcion']+'. '+str_CambioCantidad.replace('[[CANTIDADOLD]]',CantidadOld).replace('[[CANTIDADNEW]]',items['Cantidad']) +'\n\r';
			}


			//	24may17, Recuperar la programacion de entregas
			//items['Entregas']= new Array();

			//	Programacion entregas
			try
			{
				if (tree.Pedido.Itens_Requisicao.Item_Requisicao.Programacao_Entrega.length>0)
				{
					items['Entregas'] = '';
					for (j=0;j<tree.Pedido.Itens_Requisicao.Item_Requisicao.Programacao_Entrega.length;++j)
					{

						items['Entregas']+=tree.Pedido.Itens_Requisicao.Item_Requisicao.Programacao_Entrega[j].Data+'|'+tree.Pedido.Itens_Requisicao.Item_Requisicao.Programacao_Entrega[j].Quantidade+'#';

					}

				}
				else
				{
					items['Entregas']=tree.Pedido.Itens_Requisicao.Item_Requisicao.Programacao_Entrega.Data+'|'+tree.Pedido.Itens_Requisicao.Item_Requisicao.Programacao_Entrega.Quantidade;
				}
			}
			catch(err)
			{
				items['Entregas']='';
			}

			//	26may17, Recuperar campos extra
			items['CamposExtra']= new Array();

			//	Campos extra
			try
			{
				if (tree.Pedido.Itens_Requisicao.Item_Requisicao.Campo_Extra.length>0)
				{
					for (j=0;j<tree.Pedido.Itens_Requisicao.Item_Requisicao.Campo_Extra.length;++j)
					{
						items['CamposExtra']+=tree.Pedido.Itens_Requisicao.Item_Requisicao.Campo_Extra[j].Nome+'|'+tree.Pedido.Itens_Requisicao.Item_Requisicao.Campo_Extra[j].Valor+'#';
					}

				}
				else
				{
					items['CamposExtra']=tree.Pedido.Itens_Requisicao.Item_Requisicao.Campo_Extra.Nome+'|'+tree.Pedido.Itens_Requisicao.Item_Requisicao.Campo_Extra.Valor;
				}
			}
			catch(err)
			{
				items['CamposExtra']='';
			}

 			ficProductos.push(items);

			//solodebug
			console.log('Leyendo producto: ('+items['Codigo']+') '+items['Descripcion']+'. Cant:'+items['Cantidad']);

			if (licAvisosCarga!='') alert(licAvisosCarga);
		}
		
		
		
		
		
		//
		//	En el caso de múltiples productos recorremos el array
		//
		if (tree.Pedido.Itens_Requisicao.Item_Requisicao.length>0)
		{

			//	A partir del nodo de productos, recuperamos los datos de cada nodo
			for (i=0;i<tree.Pedido.Itens_Requisicao.Item_Requisicao.length;++i)
			{
				var items		= [];
				items['Codigo']	= tree.Pedido.Itens_Requisicao.Item_Requisicao[i].Codigo_Produto;
				items['Descripcion'] = tree.Pedido.Itens_Requisicao.Item_Requisicao[i].Descricao_Produto;
				items['Cantidad'] = tree.Pedido.Itens_Requisicao.Item_Requisicao[i].Quantidade;
				items['IDProductoLic']	=0;		//	Pendiente de inicializar
				items['NifCentro']	= '';
				items['Precio']	= '';
				//	3abr19 Nuevos campos requeridos por la integración con Recoletas
				items['CodPed']	= '';
				items['LugarEntrega'] = '';		
				items['CentroCoste'] = '';		
				items['UdBasica'] = '';
				items['CodCenEnt'] = '';
				items['CodProv'] = '';
				items['CamposExtra'] = '';
				//	11jun19 Nuevos campos requeridos para la integración con Unimed
				items['Linea'] = '';
				items['Producto'] = '';
				items['Marca'] = '';
				items['IDSolicitud'] = '';	
				//	16mar20 TOTUS	
				items['CampoExtra1'] = '';
				items['CampoExtra2'] = '';
				items['CampoExtra3'] = '';
				items['CampoExtra4'] = '';
				items['CampoExtra5'] = '';
				items['CampoExtra6'] = '';


				//	1jun17 COmprobamos qeu la cantidad sea un número entero
				if (items['Cantidad'].indexOf(',')!=-1)
				{
					var CantidadOld=items['Cantidad'];
					items['Cantidad']=String(parseInt(items['Cantidad'].replace(",","."))+1);
					licAvisosCarga += items['Codigo']+': '+items['Descripcion']+'. '+str_CambioCantidad.replace('[[CANTIDADOLD]]',CantidadOld).replace('[[CANTIDADNEW]]',items['Cantidad']) +'\n\r';
				}


				//	24may17, Recuperar la programacion de entregas
				//items['Entregas']= new Array();

				//	Programacion entregas
				try
				{
					if (tree.Pedido.Itens_Requisicao.Item_Requisicao[i].Programacao_Entrega.length>0)
					{
						items['Entregas'] = '';
						for (j=0;j<tree.Pedido.Itens_Requisicao.Item_Requisicao[i].Programacao_Entrega.length;++j)
						{

							items['Entregas']+=tree.Pedido.Itens_Requisicao.Item_Requisicao[i].Programacao_Entrega[j].Data+'|'+tree.Pedido.Itens_Requisicao.Item_Requisicao[i].Programacao_Entrega[j].Quantidade+'#';

						}

					}
					else
					{
						items['Entregas']=tree.Pedido.Itens_Requisicao.Item_Requisicao[i].Programacao_Entrega.Data+'|'+tree.Pedido.Itens_Requisicao.Item_Requisicao[i].Programacao_Entrega.Quantidade;
					}
				}
				catch(err)
				{
					items['Entregas']='';
				}

				//	26may17, Recuperar campos extra
				items['CamposExtra']= new Array();

				//	Campos extra
				try
				{
					if (tree.Pedido.Itens_Requisicao.Item_Requisicao[i].Campo_Extra.length>0)
					{
						for (j=0;j<tree.Pedido.Itens_Requisicao.Item_Requisicao[i].Campo_Extra.length;++j)
						{
							items['CamposExtra']+=tree.Pedido.Itens_Requisicao.Item_Requisicao[i].Campo_Extra[j].Nome+'|'+tree.Pedido.Itens_Requisicao.Item_Requisicao[i].Campo_Extra[j].Valor+'#';
						}

					}
					else
					{
						items['CamposExtra']=tree.Pedido.Itens_Requisicao.Item_Requisicao[i].Campo_Extra.Nome+'|'+tree.Pedido.Itens_Requisicao.Item_Requisicao[i].Campo_Extra.Valor;
					}
				}
				catch(err)
				{
					items['CamposExtra']='';
				}

 				ficProductos.push(items);

				//solodebug
				console.log('Leyendo producto: ('+items['Codigo']+') '+items['Descripcion']+'. Cant:'+items['Cantidad']);

			}
			if (licAvisosCarga!='') alert(licAvisosCarga);

		}

		
		if (ficProductos.length==0)
			textoSalida+='No se han encontrado productos.<br/>';
		else
			textoSalida+='<br/>Num.productos:'+ficProductos.length+'<br/>';
		
		//	solodebug
		//for  (i=0;i<ficProductos.length;++i)
		//	textoSalida+='Linea '+i+' cod:'+ficProductos[i].Codigo+' nombre:'+ficProductos[i].Descripcion+' cant.:'+ ficProductos[i].Cantidad
		//		+' entregas.:'+ ficProductos[i].Entregas.length+' extra.:'+ficProductos[i].CamposExtra.length+'<br/>';
	}
	catch(err)
	{
		ficControlErrores='Formato XML incorrecto. Error:'+err;
	}


	//	Control de errores en el proceso
	if (ficControlErrores=='')
	{
		document.getElementById("infoProgreso").innerHTML = str_CreandoLicitacion+': '+fileName;
		jQuery('#infoProgreso').show();
		
		//	solodebug	alert(str_CreandoLicitacion+': '+fileName);
		
		ficControlErrores=EnviarFichero(fileName, ficIDLicitacion, ficRequisicao, ficTituloPdc, ficDataVencimento, ficHoraVencimento, ficMoeda, ficObservacao, ficUrgencia, ficProductos);
	}
	else
	{
		alert(ficControlErrores);
	}
}




//
//	Bloque principal del código para procesar un fichero de AUTORIZACION en formato "XML ESTANDAR BRASIL"
//
/*
<?xml version="1.0" encoding="WINDOWS-1252"?>
<Confirmacao layout="WB">
  <PDC>44062121</PDC>
  <Item_Confirmacao>
    <CNPJ_Fornecedor>01.857.076/0001-09</CNPJ_Fornecedor>
    <Id_Artigo>56586356</Id_Artigo>
    <Codigo_Produto>81139</Codigo_Produto>
    <Quantidade>10</Quantidade>
    <Observacao>00030567</Observacao>
  </Item_Confirmacao>
</Confirmacao>
*/
function ProcesarAutorizacionXMLEstandarBrasil(fileName, fileContent)
{
	// Cuando éste evento se dispara, los datos están ya disponibles.
	//var output = document.getElementById("fileOutput");
	console.log('ProcesarAutorizacionXMLEstandarBrasil '+fileName+':'+fileContent);

	//	Datos generales de la licitacion
	var ficRequisicao, ficTituloPdc, ficDataVencimento, ficHoraVencimento, ficMoeda, ficObservacao, ficUrgencia='N', licAvisosCarga='', ficControlErrores=''; 

	//	Variables de uso interno
	var count=0;
	var textoSalida='';
	
	//	14abr23 Inicializa ficProductos
	ficProductos = new Array();

	jQuery('#infoProgreso').html('Inicio: preparando autorizacion a partir de XML estándar Brasil.');

	//	26may17 Pasamos a utilizar la librería ObjTree.js		
	try
	{
		var fileCorr=fileContent.replace(/&/g,'&amp;')
        var xotree = new XML.ObjTree();             
        var tree   = xotree.parseXML(fileCorr);
		
		
		console.log('Leyendo cabecera');
		//	recuperamos datos generales de la licitacion
		ficRequisicao=tree.Confirmacao.PDC;

		textoSalida='Requisicao:'+ficRequisicao+'<br/>';

		//solodebug
		console.log('Requisicao:'+ficRequisicao);
		//textoSalida+='<br/>';
		
		
		//
		//	9oct17	En el caso de un único producto lo tratamos directamente
		//
		if (!Array.isArray(tree.Confirmacao.Item_Confirmacao))
		{

			//solodebug	
			console.log('Recuperando un único producto del XML');
			
			var items		= [];
			
			items['Solicitud']	= ficRequisicao;
			items['Codigo']	= tree.Confirmacao.Item_Confirmacao.Codigo_Produto;
			items['NIFProveedor'] = tree.Confirmacao.Item_Confirmacao.CNPJ_Fornecedor;
			items['IDProducto'] = tree.Confirmacao.Item_Confirmacao.Id_Artigo;
			items['Cantidad'] = tree.Confirmacao.Item_Confirmacao.Quantidade;
			items['Observaciones'] = tree.Confirmacao.Item_Confirmacao.Observacao;

			//	1jun17 COmprobamos que la cantidad sea un número entero
			if (items['Cantidad'].indexOf(',')!=-1)
			{
				var CantidadOld=items['Cantidad'];
				items['Cantidad']=String(parseInt(items['Cantidad'].replace(",","."))+1);
				licAvisosCarga += items['Codigo']+': '+items['Descripcion']+'. '+str_CambioCantidad.replace('[[CANTIDADOLD]]',CantidadOld).replace('[[CANTIDADNEW]]',items['Cantidad']) +'\n\r';
			}

 			ficProductos.push(items);

			//solodebug
			console.log('Leyendo producto: ('+items['Codigo']+'), prov:'+items['NIFProveedor']+'. Cant:'+items['Cantidad']);

			if (licAvisosCarga!='') alert(licAvisosCarga);
		}
		
		
		//
		//	En el caso de múltiples productos recorremos el array
		//
		if (tree.Confirmacao.Item_Confirmacao.length>0)
		{

			//	A partir del nodo de productos, recuperamos los datos de cada nodo
			for (i=0;i<tree.Confirmacao.Item_Confirmacao.length;++i)
			{
				var items		= [];
			
				items['Solicitud']	= ficRequisicao;
				items['Codigo']	= tree.Confirmacao.Item_Confirmacao[i].Codigo_Produto;
				items['NIFProveedor']	= tree.Confirmacao.Item_Confirmacao[i].CNPJ_Fornecedor;
				items['IDProducto']	= tree.Confirmacao.Item_Confirmacao[i].Id_Artigo;
				items['Cantidad'] = tree.Confirmacao.Item_Confirmacao[i].Quantidade;
				items['Observaciones'] = tree.Confirmacao.Item_Confirmacao[i].Observacao;

				//	1jun17 COmprobamos qeu la cantidad sea un número entero
				if (items['Cantidad'].indexOf(',')!=-1)
				{
					var CantidadOld=items['Cantidad'];
					items['Cantidad']=String(parseInt(items['Cantidad'].replace(",","."))+1);
					licAvisosCarga += items['Codigo']+': '+items['Descripcion']+'. '+str_CambioCantidad.replace('[[CANTIDADOLD]]',CantidadOld).replace('[[CANTIDADNEW]]',items['Cantidad']) +'\n\r';
				}

 				ficProductos.push(items);

				//solodebug
				console.log('Leyendo producto: ('+items['Codigo']+'), prov:'+items['NIFProveedor']+'. Cant:'+items['Cantidad']);

			}
			if (licAvisosCarga!='') alert(licAvisosCarga);

		}
		
		if (ficProductos.length==0)
			textoSalida+='No se han encontrado productos.<br/>';
		else
			textoSalida+='<br/>Num.productos:'+ficProductos.length+'<br/>';
		
		//	solodebug
		//for  (i=0;i<ficProductos.length;++i)
		//	textoSalida+='Linea '+i+' cod:'+ficProductos[i].Codigo+' nombre:'+ficProductos[i].Descripcion+' cant.:'+ ficProductos[i].Cantidad
		//		+' entregas.:'+ ficProductos[i].Entregas.length+' extra.:'+ficProductos[i].CamposExtra.length+'<br/>';
	}
	catch(err)
	{
		ficControlErrores='Formato XML incorrecto. Error:'+err;
	}


	//	Control de errores en el proceso
	if (ficControlErrores=='')
	{
		document.getElementById("infoProgreso").innerHTML = str_CreandoAutorizacion+': '+fileName;
		jQuery('#infoProgreso').show();
		
		//	solodebug	alert(str_CreandoLicitacion+': '+fileName);
		
		ficControlErrores=EnviarFicheroAutorizar(fileName, ficIDLicitacion, ficRequisicao, ficTituloPdc, ficDataVencimento, ficHoraVencimento, ficMoeda, ficObservacao, ficUrgencia, ficProductos);
	}
	else
	{
		alert(ficControlErrores);
	}
}






//	Enviamos todos los productos al servidor
function EnviarTodosProductosAutorizar(licNumProductosEnviados)
{
	var d		= new Date();

	//	Entrada en el proceso
	
	//solodebug
	console.log('EnviarTodosProductosAutorizar: licNumProductosEnviados:'+licNumProductosEnviados+ ' total:'+ficProductos.length);

	if (licNumProductosEnviados>=ficProductos.length)
	{

		if (ficControlErrores==0)
		{
			//solodebug	console.log('enviarLineaFichero: licNumProductosEnviados:'+licNumProductosEnviados+ ' total:'+ficProductos.length + ' -> cerrarFichero sin errores');
			
			cerrarFicheroAutorizar(licNumProductosEnviados, 'OK');
			
			jQuery('#infoProgreso').html(str_FicheroProcesado);
			jQuery('#infoProgreso').show();
			jQuery('#infoErrores').hide();
			jQuery('#EnviarPedidoDesdeTexto').show();
			


			//reactivar 				location.reload(true);



			return 'OK';
		}
		else
		{
			//solodebug	
			console.log('EnviarTodosProductosAutorizar: licNumProductosEnviados:'+licNumProductosEnviados+ ' total:'+ficProductos.length + ' -> cerrarFichero CON ERROR');
			cerrarFicheroAutorizar(licNumProductosEnviados, 'ERROR');
			jQuery('#infoProgreso').hide();
			jQuery('#infoErrores').html(ficControlErrores);
			jQuery('#infoErrores').show();
			jQuery('#EnviarPedidoDesdeTexto').show();
			return 'ERROR';
		}
	}
	//solodebug
	//else
	//{
	//	console.log('EnviarTodosProductosAutorizar: licNumProductosEnviados:'+licNumProductosEnviados+ ' total:'+ficProductos.length+ ' => enviando');
	//}

	var texto	=(licNumProductosEnviados+1)+'/'+ficProductos.length+': ['+ficProductos[licNumProductosEnviados].Codigo+'] '+ficProductos[licNumProductosEnviados].Cantidad+' a '+ficProductos[licNumProductosEnviados].NIFProveedor;
					
	jQuery.ajax({
		cache:	false,
		url:	'http://www.newco.dev.br/Gestion/AdminTecnica/EnviarProductoAutorizarAJAX.xsql',
		type:	"GET",
		data:	"INTF_ID="+ficID+"&NUMLINEA="+licNumProductosEnviados
					+"&SOLICITUD="+ficProductos[licNumProductosEnviados].Solicitud
					+"&REFCLIENTE="+ficProductos[licNumProductosEnviados].Codigo
					+"&CANTIDAD="+ficProductos[licNumProductosEnviados].Cantidad
					+"&NIFPROVEEDOR="+encodeURIComponent(ficProductos[licNumProductosEnviados].NIFProveedor)
					+"&OBSERVACIONES="+encodeURIComponent(ficProductos[licNumProductosEnviados].Observaciones)
					+"&_="+d.getTime(),
		contentType: "application/xhtml+xml",
		error: function(objeto, quepaso, otroobj){
			ficError='ERROR_ENVIANDO';
			
			ficControlErrores+=ficControlErrores+str_NoPodidoIncluirProducto+': ('+ficProductos[licNumProductosEnviados].Codigo+') '+ficProductos[licNumProductosEnviados].Cantidad+' a '+ficProductos[licNumProductosEnviados].NIFProveedor+'<br/>';
			console.log('EnviarTodosProductosAutorizar: licNumProductosEnviados:'+licNumProductosEnviados+ ' total:'+ficProductos.length+ ' => ERROR enviando:'+quepaso);
			return 'ERROR';
		},
		success: function(objeto){
			var data = JSON.parse(objeto);
			
			//
			//	Control de errores en la funcion que llama a esta
			//
						
			ficProductos[licNumProductosEnviados].IDProductoLic=data.Producto.IDProductoLic;

			//	solodebug
			console.log('EnviarTodosProductosAutorizar: res:'||data.Producto.estado);
			
			//	Procesar error
			if ((data.Producto.estado=='ERROR')||(data.Producto.estado!='OK'))
			{
				console.log('enviarLineaFichero ERROR ENVIANDO: ('+ficProductos[licNumProductosEnviados].Codigo+') '+data.Producto.estado);
				ficError='ERROR_ENVIANDO';
				ficControlErrores+=(licNumProductosEnviados+1)+'/'+ficProductos.length+'. ('+ficProductos[licNumProductosEnviados].Codigo+'): '+data.Producto.estado+'<br/>';
				licNumProductosEnviados=licNumProductosEnviados+1;
			}
			else
			{
				console.log('EnviarTodosProductosAutorizar: ENVIO CORRECTO. IDProductoLic:'+data.Producto.IDProductoLic+' -> ('+ficProductos[licNumProductosEnviados].Codigo+') '+ficProductos[licNumProductosEnviados].Cantidad+' a '+ficProductos[licNumProductosEnviados].NIFProveedor);
				licNumProductosEnviados=licNumProductosEnviados+1;
			}

			jQuery('#infoProgreso').html(texto+' '+data.Producto.estado);

			//solodebug	if (numLineaInicio<3) alert("ASINCRONO:"+texto);

			EnviarTodosProductosAutorizar(licNumProductosEnviados);		

		}
	});
	
}

//	10feb17 Separamos la creación de la licitación de la preparación del envío
function cerrarFicheroAutorizar(numLineas, estado)
{
	var d= new Date();

	//solodebug	
	console.log('cerrarFichero: numlineas:'+numLineas+ ' estado:'+estado);
		
	jQuery.ajax({
		cache:	false,
		//async: false,
		url:	'http://www.newco.dev.br/Gestion/AdminTecnica/FinEnvioFicheroAutorizarAjax.xsql',
		type:	"GET",
		data:	"IDFICHERO="+ficID+"&NUMLINEAS="+numLineas+"&ESTADO="+estado+"&AMPLIADA=S&_="+d.getTime(),
		contentType: "application/xhtml+xml",
		error: function(objeto, quepaso, otroobj){
			ficError='ERROR_CONECTANDO';
		},
		success: function(respuesta){
			var data = JSON.parse(respuesta);

			//solodebug	console.log('cerrarFichero: '+respuesta+'->'+JSON.stringify(data));
			
			//	Prepara el mensaje de respuesta
			if ((estado=='OK')&&(data.FinEnvio.estado.substring(0, 2)=='OK'))
			{	
				//	Envio correcto			
				var msgFinal=str_FicheroProcesado+': '+ficProductos.length+'/'+ficProductos.length+'\n\n';
			
				var NumPeds=parseInt(Piece(data.FinEnvio.estado,'|',1));
				var NumLics=parseInt(Piece(data.FinEnvio.estado,'|',2));
				var InfoRegs=Piece(data.FinEnvio.estado,'|',3);
				
				if (NumPeds>0)
				{
					msgFinal+=NumPeds+' '+str_Pedidos+':\n';
					for (var i=0;i<NumPeds;++i)
					{
						var infoPed=Piece(InfoRegs,'#',i);

						var msgPed=Piece(infoPed,'·',2)+': '+Piece(infoPed,'·',3)+' '+str_Productos;

						if (Piece(infoPed,'·',4)=='S')
							msgPed+=' ... '+str_PedMin+': '+str_NoCumple;

						msgFinal+=msgPed+'\n';
					}
				}

				if (NumLics>0)		//Licitaciones a continuacion de pedidos
				{
					msgFinal+=NumLics+' '+str_Licitaciones+':\n';
					for (var i=0;i<NumLics;++i)
					{
						var infoLic=Piece(InfoRegs,'#',NumPeds+i);

						var msgPed=Piece(infoLic,'·',2)+': '+Piece(infoLic,'·',3)+' '+str_Productos;
						msgFinal+=msgPed+'\n';
					}
				}
				
				
				if (NumPeds>0)
				{
					if (confirm(msgFinal+'\n\n'+str_AbrirPed))
					{
						//	abre todos los pedidos creados
						for (var i=0;i<NumPeds;++i)
						{
							var infoPed=Piece(InfoRegs,'#',i);

							var IDMultioferta=Piece(infoPed,'·',1);
							FichaPedido(IDMultioferta,'');
						}
					}
				}
				else if (NumLics>0)		//Licitaciones a continuacion de pedidos
				{
					if (confirm(msgFinal+'\n\n'+str_AbrirLic))
					{
						//	abre todos los pedidos creados
						for (var i=0;i<NumLics;++i)
						{
							var infoLic=Piece(InfoRegs,'#',NumPeds+i);

							var IDLicitacion=Piece(infoLic,'·',1);
							FichaLicV2(IDLicitacion,'');
						}
					}
				}
				else
					alert(msgFinal);
			
			}
			else
			{
				//	ERROR
				alert(str_FicheroConErrores);
			}

			//	Envio correcto de datos

			//solodebug
			//solodebug	
			console.log('cerrarFichero: '+respuesta);
			//solodebug	ficID=1;
			
		}
	});
}


//	3mar17	Separamos la función para enviar licitaciones, así se podrá utilizar con diferentes formatos de ficheros de entrada
function EnviarFicheroAutorizar(fileName, ficIDLicitacion, ficRequisicao, ficTituloPdc, ficDataVencimento, ficHoraVencimento, ficMoeda, ficObservacao, ficUrgencia, ficProductos)
{
	var ficControlErrores='';
	
	//	8abr19	Faltaba inicializar el array de productos
	ficProductos	= new Array();

	//	Paso 1: Crear licitacion
	document.getElementById("infoProgreso").innerHTML = 'Procesando fichero: '+fileName;
	//solodebug	document.getElementById("infoProgreso").style.background = 0;
	
	//solodebug	alert('Inicio: infoProgreso:'+jQuery('#infoProgreso').html());
	
	prepararEnvio(fileName, ficRequisicao, ficTituloPdc, ficDataVencimento, ficHoraVencimento, ficMoeda, ficObservacao, ficUrgencia);

	//	Control de errores: -1 No se ha podido crear
	if (ficID==-1)
	{
		ficControlErrores+=str_ErrorDesconocidoCreandoFichero;
	}

	//	Control de errores: -2 fichero ya existe
	if (ficID==-2)
	{
		ficControlErrores+=str_FicheroYaEnviado;
	}


	//	Paso 2: Enviar productos
	if (ficControlErrores=='')
	{
		
		//	Version recursiva
		//licNumProductosEnviados=0;
		jQuery('#infoErrores').hide();
		EnviarTodosProductosAutorizar(0);
		
	}
	else
	{
		document.getElementById("infoProgreso").innerHTML = 'Procesando fichero: '+fileName+' ERROR:'+ficControlErrores;
	}

	return ficControlErrores;
}

