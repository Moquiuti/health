//	JS para la carga y procesado de ficheros XML tipo "Amparo"
//	ultima revision ET 10feb 9:55


/*

Formato de fichero XML

<Pedido layout="WA">
  <Cabecalho>
    <Requisicao>5054</Requisicao>
    <Titulo_Pdc>Cotacao Nr: 5054</Titulo_Pdc>
    <Contato>Susanna Bayao</Contato>
    <Id_Forma_Pagamento>1</Id_Forma_Pagamento>
    <Data_Vencimento>05/05/2015</Data_Vencimento>
    <Hora_Vencimento>12:37</Hora_Vencimento>
    <Moeda>Real</Moeda>
    <Observacao><![CDATA[Fio Sutura: Johnson
Fralda Geriatrica em duas entregas: 10 dias e 20 dias]]></Observacao>
    </Cabecalho>
  <Itens_Requisicao>
    <Item_Requisicao>
      <Codigo_Produto>1323</Codigo_Produto>
      <Descricao_Produto><![CDATA[Fio p/sutura mononylon 3-0]]></Descricao_Produto>
      <Quantidade>24</Quantidade>
    </Item_Requisicao>
*/



var IDFichero;

var Status='OK';

var ControlErrores='';
var LineaError='';

function enviarFichero(files) {
	var file = files[0];

	var reader = new FileReader();

	reader.onload = function (e) {
		// Cuando éste evento se dispara, los datos están ya disponibles.
		//var output = document.getElementById("fileOutput");
		console.log('Contenido fichero '+file.name+':'+e.target.result);

		//	Datos generales de la licitacion
		var licRequisicao, licTituloPdc, licDataVencimento, licHoraVencimento, licMoeda, licObservacao, licUrgencia; 
		var licProductos	= new Array();
		
		//	Variables de uso interno
		var count=0;
		var textoSalida='';

		jQuery('#lineaActual').html('Inicio');
		//$('#lineaActual').redraw();

		//http://www.w3schools.com/xml/xml_parser.asp		
		//parser = new DOMParser();
		
		if (window.DOMParser) {
			// code for modern browsers
			parser = new DOMParser();
			var xmlDoc = parser.parseFromString(e.target.result,"text/xml");
		} else {
			// code for old IE browsers
			var xmlDoc = new ActiveXObject("Microsoft.XMLDOM");
			xmlDoc.async = false;
			xmlDoc.loadXML(e.target.result);
		}  
		
		//xmlDoc = parser.parseFromString(e.target.result,"text/xml");
		
		
		//	recuperamos datos generales de la licitacion
		licRequisicao=obtenerValor(xmlDoc, "Requisicao",0);
		licTituloPdc=obtenerValor(xmlDoc, "Titulo_Pdc",0);
		licDataVencimento=obtenerValor(xmlDoc, "Data_Vencimento",0);
		licHoraVencimento=obtenerValor(xmlDoc, "Hora_Vencimento",0);
		licMoeda=obtenerValor(xmlDoc, "Moeda",0);
		licObservacao=obtenerValor(xmlDoc, "Observacao",0);
		licUrgencia=obtenerValorPorPath(xmlDoc, "Pedido/Cabecalho/Campo_Extra/Nome");

		textoSalida='Requisicao:'+licRequisicao+'<br/>'
				+' Titulo_Pdc:'+licTituloPdc+'<br/>'
				+' Data_Vencimento:'+licDataVencimento+'<br/>'
				+' Hora_Vencimento:'+licHoraVencimento+'<br/>'
				+' Moeda:'+licMoeda+'<br/>'
				+' Observacao:'+licObservacao+'<br/>'
				+' Urgencia:'+licUrgencia+'<br/>'+'<br/>';


		console.log('Leyendo cabecera:'+textoSalida);
		
		/*var xmlCampoExtra=obtenerNodo(xmlDoc, "Campo_Extra",0);
		
		console.log('xmlCampoExtra:'+xmlCampoExtra);
		
		if (xmlCampoExtra!='')
			licUrgencia=obtenerValor(xmlCampoExtra, "Nome",0);
		else
			licUrgencia='NO';
			
		textoSalida+=' licUrgencia:'+licUrgencia;*/
		
		textoSalida+='<br/>';
		
		//textoSalida+=' Descricao_Produto:'+obtenerValorPorPath(xmlDoc, "Pedido/Itens_Requisicao/Item_Requisicao/Descricao_Produto");
		//textoSalida+='<br/>';
		
		var nodoProductos=obtenerNodoPorPath(xmlDoc, "Pedido/Itens_Requisicao");
		
		if (nodoProductos!='')
		{
			/*	Codigo de prueba, utilizando el path completo
			for (i=0;i<nodoProductos.getElementsByTagName("Item_Requisicao").length;++i)
			{
   				//var nodoProducto = nodoProductos.getElementsByTagName("Item_Requisicao")[i];
 
				//textoSalida+='\n\r'+obtenerValorPorPath(nodoProducto, 'Descricao_Produto');

				//textoSalida+='||'+nodoProductos.getElementsByTagName("Item_Requisicao")[i].getElementsByTagName('Descricao_Produto')[0].nodeValue;
				
				textoSalida+=' Codigo_Produto:'+obtenerValorPorPath(xmlDoc, "Pedido/Itens_Requisicao/Item_Requisicao["+i+"]/Codigo_Produto");
				textoSalida+=' Descricao_Produto:'+obtenerValorPorPath(xmlDoc, "Pedido/Itens_Requisicao/Item_Requisicao["+i+"]/Descricao_Produto");
				textoSalida+=' Quantidade:'+obtenerValorPorPath(xmlDoc, "Pedido/Itens_Requisicao/Item_Requisicao["+i+"]/Quantidade");
				textoSalida+='<br/>';
			}

			textoSalida+='*************************************************<br/>';
		*/
			//	A partir del nod de productos, recuperamos los datos de cada nodo
			for (i=0;i<nodoProductos.getElementsByTagName("Item_Requisicao").length;++i)
			{
				var items		= [];
				items['Codigo']	= obtenerValorPorPath(nodoProductos, "Item_Requisicao["+i+"]/Codigo_Produto");
				items['Descripcion'] = obtenerValorPorPath(nodoProductos, "Item_Requisicao["+i+"]/Descricao_Produto");
				items['Cantidad'] = obtenerValorPorPath(nodoProductos, "Item_Requisicao["+i+"]/Quantidade");
				items['IDProductoLic']	=0;		//	Pendiente de inicializar
 				licProductos.push(items);




  				//var nodoProducto = nodoProductos.getElementsByTagName("Item_Requisicao")[i];
 
				//textoSalida+='\n\r'+obtenerValorPorPath(nodoProducto, 'Descricao_Produto');

				//textoSalida+='||'+nodoProductos.getElementsByTagName("Item_Requisicao")[i].getElementsByTagName('Descricao_Produto')[0].nodeValue;
				
				//textoSalida+=' Codigo_Produto:'+obtenerValorPorPath(nodoProductos, "Item_Requisicao["+i+"]/Codigo_Produto");
				//textoSalida+=' Descricao_Produto:'+obtenerValorPorPath(nodoProductos, "Item_Requisicao["+i+"]/Descricao_Produto");
				//textoSalida+=' Quantidade:'+obtenerValorPorPath(nodoProductos, "Item_Requisicao["+i+"]/Quantidade");
				//textoSalida+='<br/>';
				
				
				//solodebug
				console.log('Leyendo producto: ('+items['Codigo']+') '+items['Descripcion']+'. Cant:'+items['Cantidad']);
				
			}

		}
		else
			textoSalida+='No se ha encontrado nodo productos.<br/>';

		textoSalida+='<br/>Num.productos:'+licProductos.length+'<br/>';
		
		for  (i=0;i<licProductos.length;++i)
			textoSalida+='Linea '+i+' cod:'+licProductos[i].Codigo+' nombre:'+licProductos[i].Descripcion+' cant.:'+ licProductos[i].Cantidad+'<br/>';


		//	Control de errores en el proceso
		if (ControlErrores=='')
		{

			//	solodebug	jQuery('#lineaActual').html(textoSalida);

			//	solodebug	jQuery('#siguienteTarea').html('Preparando para ejecutar la carga.');

			//	solodebug	jQuery('#fileOutput').html('FICHERO:<br/><br/>'+e.target.result);
			
			//	Paso 1: Crear licitacion
			jQuery('#lineaActual').html('Creando Licitacion:'+e.target.name);
			prepararEnvio(file.name, licRequisicao, licTituloPdc, licDataVencimento, licHoraVencimento, licMoeda, licObservacao, licUrgencia);
			
			//	Control de errores: -1 No se ha podido crear
			if (licIDFichero==-1)
			{
				alert('Error desconocido al crear el fichero');
				return;
			}
			
			//	Control de errores: -2 fichero ya existe
			if (licIDFichero==-2)
			{
				alert('Este fichero ya ha sido enviado');
				return;
			}

			//	Si no han habido errores con el fichero, creamos la licitacion
			crearLicitacion(file.name, licRequisicao, licTituloPdc, licDataVencimento, licHoraVencimento, licMoeda, licObservacao, licUrgencia);
			
			//	Control de errores: -1 No se ha podido crear
			if (licIDLicitacion==-1)
			{
				alert('Error desconocido al crear la licitacion');
				return;
			}
			

			//	Paso 2: Enviar productos
			for  (i=0;i<licProductos.length;++i)
			{
				jQuery('#lineaActual').html('Linea '+i+' cod:'+licProductos[i].Codigo+' nombre:'+licProductos[i].Descripcion+' cant.:'+ licProductos[i].Cantidad);
				licProductos[i].IDProductoLic=nuevoProducto(i, licProductos[i].Codigo,licProductos[i].Descripcion,licProductos[i].Cantidad, 0);
				
				//	Control de errores a nivel de producto
				
				//
				//	!! PENDIENTE !!
				//

				
			}
			
			//	Paso 3: Confirmar resultados
			jQuery('#lineaActual').html('Licitacion preparada');
			
		}
		else
		{
			alert(ControlErrores);
		}
		
	};

	reader.readAsText(file);
}

