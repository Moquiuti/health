//	JS Derechos de un usuario sobre los productos de una plantilla. Nuevo disenno 2022
//	ultima revisión: ET 18feb22 LPLista2022_180222.js

//	20nov19 Cambio de la plantila de trabajo
function cbPlantillaChange()
{
 	var formu = document.forms['Cambios'];
	formu.elements['PL_ID'].value=formu.elements['IDPLANTILLA'].value;
    SubmitForm(formu);
}

        
//	Guarda en el campo oculto CAMBIOS el contenido de los campos editables por el usuario
//	en formato (ID, UnidadBasica, UnidadesPorLote, Precio)
function Enviar()
{
	var ID;
	var Msg='';
	
	var IdProducto;
	var ValorOcultar;
	
	var formOrigen=document.forms['Productos'];
	var formDestino=document.forms['Cambios'];

	for(var j=0;j<formOrigen.elements.length;j++)		//Quitamos el campo de pagina actual
	{
        if (formOrigen.elements[j].name.match('CHK_OCULTAR'))
		{	   
	    	IdProducto=Piece(formOrigen.elements[j].name,'_',2);
      	
    		if(formOrigen.elements[j].checked==true)
			{
    		  ValorOcultar='S';
			 // console.log('OCULTAR'+formOrigen.elements[j].name);
      		}
	   		else
			{
	    	  ValorOcultar='N';
			 // console.log('NO ocultar:'+formOrigen.elements[j].name);
      	  	}
			
			//	Solo concatenamos si hay cambio de estado
			if (ValorOcultar!=formOrigen.elements["Oculto_"+IdProducto].value)
			{
	    		Msg=Msg+IdProducto+'|'
	        		   //13jun18	+ValorNombreCliente+'|'
	        		   //13jun18	+ValorReferenciaCliente+'|'
	        		   +ValorOcultar+'#';
			}
		}
	}  
	//alert(Msg);
	formDestino.elements['CAMBIOS'].value=Msg;
	SubmitForm(formDestino);  
}   

   

	
	
//	ET 17mar06	Nuevo boton de Marcar Todos
var accionTodos='Marca';
function MarcarTodos(formu)
{
	var Estado;
	if (accionTodos=='Marca')
	{
		accionTodos='QuitarMarca';
		Estado=true;
	}
	else
	{
		accionTodos='Marca';
		Estado=false;
	}

	//	Recorre todos los elementos del formulario y actualiza los checks
	for (j=0;j<formu.elements.length;j++)
	{
    	if((formu.elements[j].type=='checkbox') && (formu.elements[j].name.substring(0,11)=='CHK_OCULTAR'))
		{
			formu.elements[j].checked=Estado;
		}
	}
}

//	20nov19 Abrir pagina de derechos por usuario
function DerechosUsuarioPlantilla()
{
 	var formu = document.forms['Cambios'];
	var IDPlantilla=formu.elements['PL_ID'].value;
	window.location.href="http://www.newco.dev.br/Compras/Multioferta/PLManten2022.xsql?PL_ID="+IDPlantilla;
}


//	20nov19 Abrir pagina de derechos por usuario
function DerechosUsuarioProducto(IDProdEstandar,IDProducto)
{
 	var formu = document.forms['Cambios'];
	var idEmpresa=formu.elements['IDEMPRESA'].value;
	MostrarPagPersonalizada('http://www.newco.dev.br/ProcesosCdC/MantenimientoReducido/MantenimientoReducidoDerechos2022.xsql?IDEMPRESA='+idEmpresa+'&IDPRODUCTO='+IDProducto+'&IDPRODESTANDAR='+IDProdEstandar,80,50,0,-50);
}
