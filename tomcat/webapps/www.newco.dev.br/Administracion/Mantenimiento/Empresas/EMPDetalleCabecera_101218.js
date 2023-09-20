//	JS para la cabecera de la ficha de empresa
//	Ultima revisión: ET 10dic18 15:00

jQuery(document).ready(globalEvents);

function globalEvents()
{

	//	12dic16	Marcamos la primera opción de menú
	jQuery("#Ficha").css('background','#3b569b');
	jQuery("#Ficha").css('color','#D6D6D6');

	// Codigo javascript para mostrar/ocultar tablas cuando se clica en pestañas
	jQuery("#Ficha").click(function(){
	
		//console.log('jQuery("#Ficha").click(function()');

		//	16oct17	Marcamos la pestaña seleccionada
		jQuery("a.MenuEmp").css('background','#F0F0F0');
		jQuery("a.MenuEmp").css('color','#555555');
		jQuery("#Ficha").css('background','#3b569b');
		jQuery("#Ficha").css('color','#D6D6D6');

        url = 'http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPFicha.xsql?EMP_ID=' + IDEmpresa;
		jQuery('iframe#iframeEmpresas').attr('src', url);
	});

	jQuery("#InfoCom").click(function(){
	
		//console.log('jQuery("#InfoCom").click(function()');

		//	16oct17	Marcamos la pestaña seleccionada
		jQuery("a.MenuEmp").css('background','#F0F0F0');
		jQuery("a.MenuEmp").css('color','#555555');
		jQuery("#InfoCom").css('background','#3b569b');
		jQuery("#InfoCom").css('color','#D6D6D6');

        url = 'http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPInfoCom.xsql?EMP_ID=' + IDEmpresa;
		jQuery('iframe#iframeEmpresas').attr('src', url);
	});

	jQuery("#InfoComProv").click(function(){
	
		//console.log('jQuery("#InfoComProv").click(function()');

		//	16oct17	Marcamos la pestaña seleccionada
		jQuery("a.MenuEmp").css('background','#F0F0F0');
		jQuery("a.MenuEmp").css('color','#555555');
		jQuery("#InfoComProv").css('background','#3b569b');
		jQuery("#InfoComProv").css('color','#D6D6D6');

        url = 'http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPInfoCom.xsql?EMP_ID=' + IDEmpresa;
		jQuery('iframe#iframeEmpresas').attr('src', url);
	});

	jQuery("#Seguimiento").click(function(){
	
		//console.log('jQuery("#Seguimiento").click(function()');

		//	16oct17	Marcamos la pestaña seleccionada
		jQuery("a.MenuEmp").css('background','#F0F0F0');
		jQuery("a.MenuEmp").css('color','#555555');
		jQuery("#Seguimiento").css('background','#3b569b');
		jQuery("#Seguimiento").css('color','#D6D6D6');

        url = 'http://www.newco.dev.br/Gestion/Comercial/Seguimiento.xsql?FIDEMPRESA=' + IDEmpresa;
		jQuery('iframe#iframeEmpresas').attr('src', url);
	});

	jQuery("#Tareas").click(function(){
	
		//console.log('jQuery("#Tareas").click(function()');

		//	16oct17	Marcamos la pestaña seleccionada
		jQuery("a.MenuEmp").css('background','#F0F0F0');
		jQuery("a.MenuEmp").css('color','#555555');
		jQuery("#Tareas").css('background','#3b569b');
		jQuery("#Tareas").css('color','#D6D6D6');

        url = 'http://www.newco.dev.br/Gestion/Comercial/Tareas.xsql?FIDEMPRESA=' + IDEmpresa;
		jQuery('iframe#iframeEmpresas').attr('src', url);
	});

	jQuery("#MEDDICC").click(function(){
	
		//console.log('jQuery("#MEDDICC").click(function()');

		//	16oct17	Marcamos la pestaña seleccionada
		jQuery("a.MenuEmp").css('background','#F0F0F0');
		jQuery("a.MenuEmp").css('color','#555555');
		jQuery("#MEDDICC").css('background','#3b569b');
		jQuery("#MEDDICC").css('color','#D6D6D6');

        url = 'http://www.newco.dev.br/Gestion/Comercial/Meddicc.xsql?FIDEMPRESA=' + IDEmpresa;
		jQuery('iframe#iframeEmpresas').attr('src', url);
	});

	jQuery("#Documentos").click(function(){
	
		//console.log('jQuery("#Documentos").click(function()');

		//	16oct17	Marcamos la pestaña seleccionada
		jQuery("a.MenuEmp").css('background','#F0F0F0');
		jQuery("a.MenuEmp").css('color','#555555');
		jQuery("#Documentos").css('background','#3b569b');
		jQuery("#Documentos").css('color','#D6D6D6');

        url = 'http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPDocs.xsql?FICHAEMPRESA=S&IDFILTROEMPRESA=' + IDEmpresa;
		jQuery('iframe#iframeEmpresas').attr('src', url);
	});

	jQuery("#ValoracionProv").click(function(){
	
		//console.log('jQuery("#ValoracionProv").click(function()');

		//	16oct17	Marcamos la pestaña seleccionada
		jQuery("a.MenuEmp").css('background','#F0F0F0');
		jQuery("a.MenuEmp").css('color','#555555');
		jQuery("#ValoracionProv").css('background','#3b569b');
		jQuery("#ValoracionProv").css('color','#D6D6D6');

        url = 'http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPValoracionProv.xsql?EMP_ID=' + IDEmpresa;
		jQuery('iframe#iframeEmpresas').attr('src', url);
	});
/*
	jQuery("#Buscador").click(function(){
	
		//console.log('jQuery("#Buscador").click(function()');

		//	16oct17	Marcamos la pestaña seleccionada
		jQuery("a.MenuEmp").css('background','#F0F0F0');
		jQuery("a.MenuEmp").css('color','#555555');
		jQuery("#Buscador").css('background','#3b569b');
		jQuery("#Buscador").css('color','#D6D6D6');

        url = 'http://www.newco.dev.br/Gestion/Comercial/BuscadorEmpresas.xsql';
		jQuery('iframe#iframeEmpresas').attr('src', url);
	});
*/
/*

	Este código ha sido sustituido al cambiar las pestañas gráficas por pestañas CSS

  //veo las varias tablas
  jQuery(".pestanaEmpresa").mouseover (function(){ this.style.cursor="pointer"; });
  jQuery(".pestanaEmpresa").mouseout (function(){ this.style.cursor="default"; });
  jQuery(".pestanaEmpresa").click (function(){
      var k = this.id;
      var src, img;
      Destino = k;

      // Hacemos la carga del iframe solo si se pincha en la pestanya... sino nos ahorramos la peticion
      if(k == 'Ficha'){
        url = 'http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPFicha.xsql?EMP_ID=' + IDEmpresa;
        if(lang == 'portugues'){
          img = 'http://www.newco.dev.br/images/botonFicha1.gif';
        }else{
          img = 'http://www.newco.dev.br/images/botonFicha1.gif';
        }
      }else if(k == 'InfoCom'){
        url = 'http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPInfoCom.xsql?EMP_ID=' + IDEmpresa;
        if(lang == 'portugues'){
          img = 'http://www.newco.dev.br/images/botonCondicionesComerciales1-BR.gif';
        }else{
          img = 'http://www.newco.dev.br/images/botonCondicionesComerciales1.gif';
        }
      }else if(k == 'InfoComProv'){
        url = 'http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPInfoCom.xsql?EMP_ID=' + IDEmpresa;
        if(lang == 'portugues'){
          img = 'http://www.newco.dev.br/images/botonCondicionesComerciales1-BR.gif';
        }else{
          img = 'http://www.newco.dev.br/images/botonCondicionesComerciales1.gif';
        }
      }else if(k == 'Seguimiento'){
        url = 'http://www.newco.dev.br/Gestion/Comercial/Seguimiento.xsql?FIDEMPRESA=' + IDEmpresa;
        if(lang == 'portugues'){
          img = 'http://www.newco.dev.br/images/botonSeguimiento1-Br.gif';
        }else{
          img = 'http://www.newco.dev.br/images/botonSeguimiento1.gif';
        }
      }else if(k == 'Tareas'){
        url = 'http://www.newco.dev.br/Gestion/Comercial/Tareas.xsql?FIDEMPRESA='  + IDEmpresa + '&FIDRESPONSABLE=-1';
        if(lang == 'portugues'){
          img = 'http://www.newco.dev.br/images/botonTareas1-Br.gif';
        }else{
          img = 'http://www.newco.dev.br/images/botonTareas1.gif';
        }
      }else if(k == 'Medicc'){
        url = 'http://www.newco.dev.br/Gestion/Comercial/Meddicc.xsql?FIDEMPRESA='  + IDEmpresa;
        if(lang == 'portugues'){
          img = 'http://www.newco.dev.br/images/botonMeddicc1.gif';
        }else{
          img = 'http://www.newco.dev.br/images/botonMeddicc1.gif';
        }
      }else if(k == 'Documentos'){
        url = 'http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPDocs.xsql?EMP_ID=' + IDEmpresa;
        if(lang == 'portugues'){
          img = 'http://www.newco.dev.br/images/botonDocumentos1.gif';
        }else{
          img = 'http://www.newco.dev.br/images/botonDocumentos1.gif';
        }
      }else if(k == 'ValoracionProv'){
        url = 'http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPValoracionProv.xsql?EMP_ID=' + IDEmpresa;
        if(lang == 'portugues'){
          img = imgPesProvSel;
        }else{
          img = imgPesProvSel;
        }
      }else if(k == 'Buscador'){
        url = 'http://www.newco.dev.br/Gestion/Comercial/BuscadorEmpresas.xsql';
        if(lang == 'portugues'){
          img = 'http://www.newco.dev.br/images/botonBuscador1.gif';
        }else{
          img = 'http://www.newco.dev.br/images/botonBuscador1.gif';
        }
      }

      if(lang == 'portugues'){
        jQuery('a#Ficha img').attr('src', 'http://www.newco.dev.br/images/botonFicha.gif');
        jQuery('a#InfoCom img').attr('src', 'http://www.newco.dev.br/images/botonCondicionesComerciales-BR.gif');
        jQuery('a#InfoComProv img').attr('src', 'http://www.newco.dev.br/images/botonCondicionesComerciales-BR.gif');
        jQuery('a#Seguimiento img').attr('src', 'http://www.newco.dev.br/images/botonSeguimiento-Br.gif');
        jQuery('a#Tareas img').attr('src', 'http://www.newco.dev.br/images/botonTareas-Br.gif');
        jQuery('a#Medicc img').attr('src', 'http://www.newco.dev.br/images/botonMeddicc.gif');
        jQuery('a#Documentos img').attr('src', 'http://www.newco.dev.br/images/botonDocumentos.gif');
        jQuery('a#ValoracionProv img').attr('src', imgPesProv);
        jQuery('a#Buscador img').attr('src', 'http://www.newco.dev.br/images/botonBuscador.gif');
      }else{
        jQuery('a#Ficha img').attr('src', 'http://www.newco.dev.br/images/botonFicha.gif');
        jQuery('a#InfoCom img').attr('src', 'http://www.newco.dev.br/images/botonCondicionesComerciales.gif');
        jQuery('a#InfoComProv img').attr('src', 'http://www.newco.dev.br/images/botonCondicionesComerciales.gif');
        jQuery('a#Seguimiento img').attr('src', 'http://www.newco.dev.br/images/botonSeguimiento.gif');
        jQuery('a#Tareas img').attr('src', 'http://www.newco.dev.br/images/botonTareas.gif');
        jQuery('a#Medicc img').attr('src', 'http://www.newco.dev.br/images/botonMeddicc.gif');
        jQuery('a#Documentos img').attr('src', 'http://www.newco.dev.br/images/botonDocumentos.gif');
        jQuery('a#ValoracionProv img').attr('src', imgPesProv);
        jQuery('a#Buscador img').attr('src', 'http://www.newco.dev.br/images/botonBuscador.gif');
      }

      jQuery('iframe#iframeEmpresas').attr('src', url);
      jQuery('a#' + k + ' img').attr('src', img);
  });
*/
  // Aqui va la parte necesaria por si enlazan a la ficha de empresa directamente a una pestaña que no es la inicial
  // Se simula un click para realizar las llamadas directamente a la pestaña que toque
  if(Destino !== ''){
    jQuery('a#' + Destino).click();
  }else{
    jQuery('a#Ficha').click();
  }
}

//gestion comercial
function CambiarEmpresa(IDEmpresa){
    if (IDEmpresa != ''){
        document.location.href = 'http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPDetalleFrame.xsql?EMP_ID='+IDEmpresa;
    }
    else{    
        document.location.href = 'http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPDetalleFrame.xsql?DEST=Tareas';
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
