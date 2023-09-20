//	Funciones javascript para PROEmpaquetamientos
//	ultima revision: ET 14mar22 11:50 PROEmpaquetamientos2022_140322.js

jQuery(document).ready(globalEvents);

function globalEvents(){
	//selecionar ofertas de proveedor

	//	Marcamos la opción de menú de empaquetamiento
	jQuery("#pes_Empaquetamiento").css('background','#3b569b');
	jQuery("#pes_Empaquetamiento").css('color','#D6D6D6');

	//	Pestannas
	jQuery("#pes_Ficha").click(function(){
	
		//	Pendiente identificar si estamos en mantenimiento o en lectura
 		var IDProducto = document.forms['frmEmpaquetamiento'].elements['PRO_ID'].value;
		window.location.assign("http://www.newco.dev.br/Administracion/Mantenimiento/Productos/PROManten2022.xsql?PRO_ID="+IDProducto);

	});
	jQuery("#pes_Tarifas").click(function(){
	
		//	Pendiente identificar si estamos en mantenimiento o en lectura
	
 		var IDProducto = document.forms['frmEmpaquetamiento'].elements['PRO_ID'].value;
		window.location.assign("http://www.newco.dev.br/Administracion/Mantenimiento/Productos/PROTarifas2022.xsql?PRO_ID="+IDProducto);

	});
	jQuery("#pes_Documentos").click(function(){
	
		//	Pendiente identificar si estamos en mantenimiento o en lectura
	
 		var IDProducto = document.forms['frmEmpaquetamiento'].elements['PRO_ID'].value;
		window.location.assign("http://www.newco.dev.br/Administracion/Mantenimiento/Productos/PRODocs2022.xsql?PRO_ID="+IDProducto);

	});
	jQuery("#pes_Pack").click(function(){
	
		//	Pendiente identificar si estamos en mantenimiento o en lectura
	
 		var IDProducto = document.forms['frmEmpaquetamiento'].elements['PRO_ID'].value;
		window.location.assign("http://www.newco.dev.br/Administracion/Mantenimiento/Productos/PROPack2022.xsql?PRO_ID="+IDProducto);

	});

	jQuery("#pes_Empaquetamiento").click(function(){
	
		//	Pendiente identificar si estamos en mantenimiento o en lectura
	
 		var IDProducto = document.forms['frmEmpaquetamiento'].elements['PRO_ID'].value;
		window.location.assign("http://www.newco.dev.br/Administracion/Mantenimiento/Productos/PROEmpaquetamiento2022.xsql?PRO_ID="+IDProducto);

	});

}//fin de globalEvents


function EnviarEmpaquetamiento()
{
    var msg = '';

    var proId	= document.forms['frmEmpaquetamiento'].elements['PRO_ID'].value;
    var cliente	= document.forms['frmEmpaquetamiento'].elements['IDCLIENTE'].value;
    var unBasica	= encodeURIComponent(document.forms['frmEmpaquetamiento'].elements['UN_BASICA'].value);
    var unLote	= document.forms['frmEmpaquetamiento'].elements['UN_LOTE'].value;

    if (cliente != '' && unBasica != '' && unLote != ''){

        jQuery.ajax({
        cache:	false,
        url:	'EmpaquetamientosSave_ajax.xsql',
        type:	"GET",
        data:	"PRO_ID="+proId+"&IDCLIENTE="+cliente+"&UN_BASICA="+unBasica+"&UN_LOTE="+unLote,
        contentType: "application/xhtml+xml",
        error: function(objeto, quepaso, otroobj){
            alert('error'+quepaso+' '+otroobj+''+objeto);
        },
        success: function(objeto){
            var data = eval("(" + objeto + ")");

            if(data.EmpaquetamientosSave.estado == 'OK'){
               document.location.reload(true);	
            }else{
                alert(document.forms['MensajeJS'].elements['ERROR_INSERTAR_DATOS'].value);
            }
        }
        });//fin jquery
    }
    else{ 
        msg = document.forms['MensajeJS'].elements['TODOS_CAMPOS_OBLI'].value; 
        alert(msg);
    }
}//fin de enviarEmpa

function EliminarEmpaquetamiento(cliente)
{

    var proId= document.forms['frmEmpaquetamiento'].elements['PRO_ID'].value;

    jQuery.ajax({
    cache:	false,
    url:	'EliminarEmpaquetamientos.xsql',
    type:	"GET",
    data:	"PRO_ID="+proId+"&IDCLIENTE="+cliente,
    contentType: "application/xhtml+xml",
    error: function(objeto, quepaso, otroobj){
        alert('error'+quepaso+' '+otroobj+''+objeto);
    },
    success: function(objeto){
        var data = eval("(" + objeto + ")");

        if(data.EliminarEmpaquetamientos.estado == 'OK'){
           document.location.reload(true);	
        }else{
            alert(document.forms['MensajeJS'].elements['ERROR_ELIMINAR_DATOS'].value);
        }
    }
});
}
