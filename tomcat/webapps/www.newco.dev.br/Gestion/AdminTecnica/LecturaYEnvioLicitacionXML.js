//	JS para la carga y procesado de ficheros XML tipo "Amparo" o texto desde Areatext
//	ultima revision ET 21jun17 14:23


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
function enviarFichero(files) 
{
	var file = files[0];

	var reader = new FileReader();

	reader.onload = function (e) {
		
		console.log('Contenido fichero '+file.name);
		ProcesarFicheroXMLEstandarBrasil(file.name, e.target.result)
	};

	reader.readAsText(file);
}


//	21jun17	Enviar pedido desde texto (copy&paste desde excel, por ejemplo)
function EnviarPedidoDesdeTexto()
{
	ProcesarCadenaTXT();
}

