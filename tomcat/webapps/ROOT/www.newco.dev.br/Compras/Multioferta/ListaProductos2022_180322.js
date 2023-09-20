//	Buscador en cat�logo proveedores
//	Ultima revision: ET 18mar22 08:20 ListaProductos2022_180322.js

jQuery.noConflict();


//----------------------------------------------------------

jQuery(document).ready(globalEvents);


function globalEvents(){
												

}//fin de globalEvents



//si busqueda no tiene resultados pero hay sinonimo con clic se busca sinonimo
function buscarSinonimos(text){
    var busqueda = window.parent.frames[0];
    var formBusque = busqueda.document.forms['Busqueda'];
     if (formBusque){
        formBusque.elements['LLP_NOMBRE'].value = text;
       }
		SubmitForm(formBusque);
}

//fin de buscarSinonimos
	
	
	

function Amplia_fichas(formu,NombreCampo){
	if(ValidaCampos(formu,NombreCampo)){
	  // Actualizo campo hidden LLP_PRODUCTO_DETERMINADO con el valor seleccionado.
	  for(i=0; i<formu.elements.length; i++){
            if (formu.elements[i].type=="radio" && formu.elements[i].checked==true){	    
	      formu.elements['LLP_PRODUCTO_DETERMINADO'].value=formu.elements[i].value;
	    }
	  }      
	  // Hago submit si hay alguna seleccion
	  if (validaCheckyCantidadSin(formu,'PRO_PREDETERMINADO','CANTIDAD_UNI',IntrodeceNumLotes)){
		formu.elements['xml-stylesheet'].value="P3ListaHTML.xsl";	        
	    SubmitForm(formu);
	  }	    
	}
  }
    	    
//	oct09	ET	Permitimos ordenación de este listado    	    
function OrdenarPor(Orden)
{
	var form=document.forms[0];
	if (form.elements['ORDEN'].value==Orden)
	{
		if (form.elements['SENTIDO'].value=='ASC') form.elements['SENTIDO'].value='DESC';
		
		else  form.elements['SENTIDO'].value='ASC';
	}
	else
	{
		form.elements['ORDEN'].value=Orden; 
		form.elements['SENTIDO'].value='ASC';
	}	
	form.elements['ULTIMAPAGINA'].value=0; 
	SubmitForm(form);
}

function EnviarSolicitud(IDProducto)
{
	// Cuando llaman a esta funcion, ocultar todos los botones de emplantillar para evitar doble-click
        jQuery(".botonEmplantillar").hide();

	var form=document.forms[0];
	form.elements['EMPLANTILLAR'].value=IDProducto; 
	SubmitForm(form);
}

//	21abr11	ET	Enviar peticion para mostrar equivalentes
function Equivalentes(IDProducto)
{
	var form=document.forms[0];
	form.elements['IDPRODUCTO'].value=IDProducto; 
	SubmitForm(form);
}

function SinStock(IDProducto,tipo,text,ref_alt,prod_alt)
{
	//alert(IDProducto);
	//alert(text);
	
	var form=document.forms[0]; 

	form.elements['SIN_STOCK_'+IDProducto].value = text;
	form.elements['STOCKS_REF_ALT_'+IDProducto].value = ref_alt;
	form.elements['STOCKS_PROD_ALT_'+IDProducto].value = prod_alt;
	
	if (tipo == 'S'){ form.elements['TIPO_ROTURA_STOCK_'+IDProducto].checked = true; }
	if (tipo == 'D'){ form.elements['TIPO_DESCATALOGADO_'+IDProducto].checked = true; }


    document.getElementById("TR_"+IDProducto).style.display=''; 
	document.getElementById("TABLA_SIN_STOCK_"+IDProducto).style.display=''; 
}


//	30nov10	ET	Cambia el estado de un producto de "Sin stock" a "con stock"
function ConStock(IDProducto)
{
	var msg='';

	//	Comprueba que haya un texto en el campo comentarios
	if (!IDProducto>0)
		msg=msg+'El ID de producto no puede ser nulo\n\r'

	if (msg=='')
	{
		//	Envía los datos
		var form=document.forms[0];
		form.elements['STOCKS_ACCION'].value='CON_STOCKS';
		form.elements['STOCKS_IDPRODUCTO'].value=IDProducto;
		SubmitForm(form);
	}
	else
		alert(msg);
}

//	30nov10	ET	Enviar datos de "SIN STOCK" para un producto
function EnviarSinStock(IDProducto){
	var msg='',
		form=document.forms[0];

	//	Comprueba que haya un texto en el campo comentarios
	if (!IDProducto>0){	msg=msg+'El ID de producto no puede ser nulo\n\r'; }

	if (form.elements['TIPO_ROTURA_STOCK_'+IDProducto].checked == false && form.elements['TIPO_DESCATALOGADO_'+IDProducto].checked == false){
			msg=msg+'Es obligatorio informar la razon, si es sin stock o descatalogacion\n\r';
		}

	if (form.elements['SIN_STOCK_'+IDProducto].value ==''){
		msg=msg+'Es obligatorio informar el campo de comentarios sobre la rotura de stock\n\r';
	}


	if (msg=='')
	{
		//	Envía los datos
		form.elements['STOCKS_ACCION'].value='SIN_STOCKS';

		if (form.elements['TIPO_ROTURA_STOCK_'+IDProducto].checked == true){
			form.elements['STOCKS_TIPO'].value = 'S';
			}

		if (form.elements['TIPO_DESCATALOGADO_'+IDProducto].checked == true){
			form.elements['STOCKS_TIPO'].value = 'D';
			}

		//alert(form.elements['STOCKS_TIPO'].value );

		form.elements['STOCKS_IDPRODUCTO'].value=IDProducto;
		form.elements['STOCKS_COMENTARIOS'].value=form.elements['SIN_STOCK_'+IDProducto].value;
		form.elements['STOCKS_REF_ALT'].value=form.elements['STOCKS_REF_ALT_'+IDProducto].value;
		form.elements['STOCKS_PROD_ALT'].value=form.elements['STOCKS_PROD_ALT_'+IDProducto].value;
		//alert('textend '+form.elements['STOCKS_COMENTARIOS'].value);

		SubmitForm(form);
	}
	else
		alert(msg);
}
	
//esta select o stock o descatalogado, no los 2, check
function CheckStock(IDProducto){
	  form=document.forms[0];
	  	if (form.elements['TIPO_ROTURA_STOCK_'+IDProducto].checked == true){
			form.elements['TIPO_DESCATALOGADO_'+IDProducto].checked = false;
		}
	 }
//esta select o stock o descatalogado, no los 2, check
function CheckDescat (IDProducto){
	  form=document.forms[0];
		if (form.elements['TIPO_DESCATALOGADO_'+IDProducto].checked == true){
			form.elements['TIPO_ROTURA_STOCK_'+IDProducto].checked = false;
		}
	 }
	 
	
//	30nov10	ET	Enviar datos de "SIN STOCK" para un producto
function CancelarSinStock(IDProducto)
{
	var form=document.forms[0];
	document.getElementById("TABLA_SIN_STOCK_"+IDProducto).style.display='none'; 
    document.getElementById("TR_"+IDProducto).style.display='none'; 
}



//18mayo11 MC seleccionar plantilla de proveedor
function EjecutarFuncionDelFrame(nombreFrame,idPlantilla)
{
	  var objFrame=new Object();
	  objFrame=obtenerFrame(top, nombreFrame);
	  objFrame.CambioPlantillaExterno(idPlantilla);
}



//	12jun12 Cambio en uno de los desplegables,    	    
function CambioRestriccion()
{
	var form=document.forms[0];

	form.elements['ULTIMAPAGINA'].value=0; 
	SubmitForm(form);
}



//Cambiamos el xml-stylesheet a P3ListaHTML.xsl
//Llamamos a la funcion ValidaCampos.
function BuscadorCatalogoEspecializado(formu){
	//si input producto informado voy siempre a la primera pagina
	if (formu.elements['LLP_NOMBRE'].value != ''){
    	formu.elements['ULTIMAPAGINA'].value = '0';
	}

	formu.action = 'http://www.newco.dev.br/Compras/Multioferta/ListaProductos2022.xsql';
	SubmitForm(formu);
}//fin de buscadorCatalogoEspecializado


//	18mar22 Selecciona la plantilla correspondiente
function SeleccionaPlantilla(IDPlantilla)
{
	EjecutarFuncionDelFrame('zonaPlantilla',IDPlantilla);
}


