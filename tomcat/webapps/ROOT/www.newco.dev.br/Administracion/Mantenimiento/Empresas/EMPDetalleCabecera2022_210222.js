//	JS para la cabecera de la ficha de empresa
//	Ultima revisi�n: ET 29mar20 15:45 EMPDetalleCabecera2022_210222.js

jQuery(document).ready(globalEvents);

function globalEvents()
{
	//	Opci�n de men� seg�n par�metro PESTANNA
	if (Pestanna=='DOCUMENTOS')
	{
		ActivarPestanna('Documentos');
        url = 'http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPDocs2022.xsql?FICHAEMPRESA=S&IDFILTROEMPRESA=' + IDEmpresa;
	}
	else
	{
		ActivarPestanna('Ficha');
        url = 'http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPFicha2022.xsql?EMP_ID=' + IDEmpresa;
	}
	jQuery('iframe#iframeEmpresas').attr('src', url);


	// Codigo javascript para mostrar/ocultar tablas cuando se clica en pesta�as
	jQuery("#Ficha").click(function(){
	
		ActivarPestanna('Ficha');
        url = 'http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPFicha2022.xsql?EMP_ID=' + IDEmpresa;
		jQuery('iframe#iframeEmpresas').attr('src', url);
	});

	jQuery("#InfoCom").click(function(){
	
		ActivarPestanna('InfoCom');
		console.log('jQuery("#InfoCom").click(function()');
        url = 'http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPInfoCom2022.xsql?EMP_ID=' + IDEmpresa;
		jQuery('iframe#iframeEmpresas').attr('src', url);
	});

	jQuery("#Indicadores").click(function(){
	
		ActivarPestanna('Indicadores');
		console.log('jQuery("#InfoCom").click(function()');
        url = 'http://www.newco.dev.br/Gestion/EIS/IndicadoresProveedoresEIS2022.xsql?IDCLIENTE=-1&IDCENTRO=-1&IDPROVEEDOR='+ IDEmpresa+'&PERIODO=-1&SIN_CABECERA=S';
		jQuery('iframe#iframeEmpresas').attr('src', url);
	});

	jQuery("#InfoComProv").click(function(){
	
		ActivarPestanna('InfoComProv');
		console.log('jQuery("#InfoComProv").click(function()');
        url = 'http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPInfoCom2022.xsql?EMP_ID=' + IDEmpresa;
		jQuery('iframe#iframeEmpresas').attr('src', url);
	});

	jQuery("#Seguimiento").click(function(){
	
		ActivarPestanna('Seguimiento');
        url = 'http://www.newco.dev.br/Gestion/Comercial/Seguimiento2022.xsql?FIDEMPRESA=' + IDEmpresa;
		jQuery('iframe#iframeEmpresas').attr('src', url);
	});

	jQuery("#Tareas").click(function(){
	
		ActivarPestanna('Tareas');
        url = 'http://www.newco.dev.br/Gestion/Comercial/Tareas2022.xsql?FIDEMPRESA=' + IDEmpresa;
		jQuery('iframe#iframeEmpresas').attr('src', url);
	});

	jQuery("#MEDDICC").click(function(){
	
		ActivarPestanna('MEDDICC');
        url = 'http://www.newco.dev.br/Gestion/Comercial/Meddicc2022.xsql?FIDEMPRESA=' + IDEmpresa;
		jQuery('iframe#iframeEmpresas').attr('src', url);
	});

	jQuery("#Documentos").click(function(){
	
		ActivarPestanna('Documentos');
        url = 'http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPDocs2022.xsql?FICHAEMPRESA=S&IDFILTROEMPRESA=' + IDEmpresa;
		jQuery('iframe#iframeEmpresas').attr('src', url);
	});

	jQuery("#ValoracionProv").click(function(){
	
		ActivarPestanna('ValoracionProv');
        url = 'http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPValoracionProv2022.xsql?EMP_ID=' + IDEmpresa;
		jQuery('iframe#iframeEmpresas').attr('src', url);
	});

  // Aqui va la parte necesaria por si enlazan a la ficha de empresa directamente a una pesta�a que no es la inicial
  // Se simula un click para realizar las llamadas directamente a la pesta�a que toque
  /*if(Destino !== ''){
    jQuery('a#' + Destino).click();
  }else{
    jQuery('a#Ficha').click();
  }*/
}

//	13mar19 Separamos esta funci�n para simplificar los cambios de pesta�a
function ActivarPestanna(pestanna)
{
	jQuery(".pestannas a").attr('class', 'MenuInactivo');
	jQuery("#"+pestanna).attr('class', 'MenuActivo');
}

//gestion comercial
function CambiarEmpresa(IDEmpresa){
    if (IDEmpresa != ''){
        document.location.href = 'http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPDetalleFrame2022.xsql?EMP_ID='+IDEmpresa;
    }
    else{    
        document.location.href = 'http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPDetalleFrame2022.xsql?DEST=Tareas';
    }
}

//checkbox desplegable empresa
function soloClientes(oForm){
  if(oForm.elements.SOLO_CLIENTES.checked === true){
    oForm.elements.SOLO_PROVEE.checked = false;
  }
  DesplegableEmpresa(oForm);
}

function soloProvee(oForm){
  if(oForm.elements.SOLO_PROVEE.checked === true){
    oForm.elements.SOLO_CLIENTES.checked = false;
  }
  DesplegableEmpresa(oForm);
}

function DesplegableEmpresa(oForm){
  var idPais = oForm.elements.IDPAIS.value;
  var idEmpresa	= oForm.elements.IDEMPRESA.value;
  var idEmpresaUsuario	= oForm.elements.IDEMPRESAUSUARIO.value;
  var soloClientes = (oForm.elements.SOLO_CLIENTES.checked) ? 'S' : 'N';
  var soloProvee = (oForm.elements.SOLO_PROVEE.checked) ? 'S' : 'N';

  jQuery.ajax({
    cache:	false,
    url:	'http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/DesplegableEmpresa.xsql',
    type:	"GET",
    data:	"MARCA=EMPRESAS&NOMBRECAMPO=FIDEMPRESA&IDPAIS="+idPais+"&IDEMPRESA="+idEmpresa+"&IDEMPRESAUSUARIO="+idEmpresaUsuario+"&SOLO_CLIENTES="+soloClientes+"&SOLO_PROVEE="+soloProvee,
    contentType: "application/xhtml+xml",
    success: function(objeto){
      var data = eval("(" + objeto + ")");
      //var data = JSON.parse(objeto);
      var Resultados = '';

      if(data.Filtros !== ''){
        for(var i=0; i<data.Filtros.length; i++){
          if(data.Filtros[i].Fitro.id == idEmpresa){
            var IDEmpresaActual	= data.Filtros[i].Fitro.id;
            Resultados = Resultados+'<option value="'+data.Filtros[i].Fitro.id+'">['+data.Filtros[i].Fitro.nombre+']</option>';
          }else{
            Resultados = Resultados+'<option value="'+data.Filtros[i].Fitro.id+'">'+data.Filtros[i].Fitro.nombre+'</option>';
          }
        }
      }

      jQuery("#FIDEMPRESA").html(Resultados);
      if(typeof IDEmpresaActual == 'undefined'){
        //jQuery("#FIDEMPRESA").index(1);
        $('#FIDEMPRESA :nth-child(2)').prop('selected', true);
        CambiarEmpresa(jQuery("#FIDEMPRESA").val());
      }else{
        jQuery("#FIDEMPRESA").val(IDEmpresaActual);
      }
    },
    error: function(xhr, errorString, exception) {
      alert("xhr.status="+xhr.status+" error="+errorString+" exception="+exception);
    }
  });
}
