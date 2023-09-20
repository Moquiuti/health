// JS Página de Inicio
// Ultima revisión ET: 21feb22 16:00 MultiofertaFrame2022_210222.js

/*	INICIO	Para valoración de proveedores	*/
/*jQuery(window).load(function(){

	if (strAprobacion!='')
		document.forms['form1'].Aprobacion.title = strAprobacion;

	//initStarRating();
});*/

//	llamada desde onLoad, el codigo anterior da error al cambiar version jQuery
function Inicio()
{
	if (strAprobacion!='')
		document.forms['form1'].Aprobacion.title = strAprobacion;
}



// init star rating functionality
//function initStarRating(context)
//{
//	jQuery('.rating-holder', context).starRating();
//}
/*	FINAL	Para valoración de proveedores	*/

function IncluirComentarios()
{
	strComentarios='\n'+strComentarios.replace('<COMENTARIO_JS>','').replace('</COMENTARIO_JS>','').replace(/\n/g,'<br/>')+'\n';
	console.log('IncluirComentarios:'+strComentarios);
	jQuery('#Comentarios').html(strComentarios);
}


function ControlPedidos(IDPedido){
	CambiarAPagina('http://www.newco.dev.br/Personal/BandejaTrabajo/ControlPedidos2022.xsql?IDPEDIDO='+IDPedido);
}


function VerXML(mo_id){
    CambiarAPagina('http://www.newco.dev.br/Compras/Multioferta/MultiofertaFrameXML.xsql?MO_ID='+mo_id);
}


function MantenPedido(mo_id,idcliente,idprove){
    CambiarAPagina('http://www.newco.dev.br/Administracion/Mantenimiento/Pedidos/MANTPedidosSave2022.xsql?MO_ID='+mo_id+'&IDCLIENTE='+idcliente+'&IDPROVEEDOR='+idprove+'&ACCION=COMPROBAR');
}


function VerTodosDocumentos(mo_id){
    CambiarAPagina('http://www.newco.dev.br/Compras/Multioferta/MODocs.xsql?MO_ID='+mo_id);
}

//enviarPDF a cliente o proveedor
function EnviarPDF(mo_id, tipo){

	//solodebug	console.log('EnviarPDF:'+mo_id+' tipo:'+tipo);

      //si usuario tiene pedidos historicos o activos no se puede borrar
    jQuery.ajax({
        //cache:	false,
        url:	'http://www.newco.dev.br/Compras/Multioferta/enviarPDF.xsql',
        type:	"GET", 
        data:	"MO_ID="+mo_id+"&TIPO="+tipo,
        //contentType: "application/xhtml+xml",
        success: function(objeto){
            var data = eval("(" + objeto + ")");

            //solodebug	alert('EnviarPDF:'+mo_id+' tipo:'+tipo+'...success data '+data.enviarPDF.estado);

            //si se ha enviado ok 
            if(data.enviarPDF.estado == 'OK'){  
                if (tipo == 'CLIENTE'){ alert(document.forms['MensajeJS'].elements['PDF_ENVIADO_CLIENTE'].value);}
                else 
				{
					if (tipo == 'PROVEE'){ alert(document.forms['MensajeJS'].elements['PDF_ENVIADO_PROVEE'].value); }
                    else 
						if (tipo == 'USUARIO'){ alert(document.forms['MensajeJS'].elements['PDF_ENVIADO_USUARIO'].value); }
				}
                return false;
            }
            //si no se ha enviado error
            else if(data.enviarPDF.estado == 'ERROR')
			{ 
                if (tipo == 'CLIENTE')
					{ alert(document.forms['MensajeJS'].elements['ERROR_PDF_ENVIADO_CLIENTE'].value); }
                else 
				{
					if (tipo == 'PROVEE'){ alert(document.forms['MensajeJS'].elements['ERROR_PDF_ENVIADO_PROVEE'].value); }
                    else 
						if (tipo == 'USUARIO'){ alert(document.forms['MensajeJS'].elements['ERROR_PDF_ENVIADO_USUARIO'].value); }
				}
                return false;
            }
        },
        error: function(xhr, errorString, exception) {
            alert("xhr.status="+xhr.status+" error="+errorString+" exception="+exception);
        }
    });

}//fin de enviar pdf
                
//usuario minimalista ve solo info base producto
function verDetalleProducto(idProd)
{
    
    jQuery("#detalleProd tbody").empty();

     if(idProd != ''){
        jQuery.ajax({
		url: 'http://www.newco.dev.br/Administracion/Mantenimiento/Productos/PRODetalleAJAX.xsql',
		data: "PRO_ID="+idProd,
                type: "GET",
                contentType: "application/xhtml+xml",
                beforeSend: function(){
                    null;
                },
                error: function(objeto, quepaso, otroobj){
                    alert('error'+quepaso+' '+otroobj+''+objeto);
                },
                success: function(objeto){
                    var data = eval("(" + objeto + ")");
                    
                    var tbodyProd = "";
                    tbodyProd +=  "<tr><td class='labelRight grisMed'>"+ nombre +":</td><td class='datosLeft'>"+data.Producto.nombre+"</td></tr>";
                    tbodyProd +=  "<tr><td class='labelRight grisMed'>"+ ref_proveedor +":</td><td class='datosLeft'>"+data.Producto.ref_prove+"</td></tr>";
                    tbodyProd +=  "<tr><td class='labelRight grisMed'>"+ proveedor +":</td><td class='datosLeft'>"+data.Producto.prove+"</td>";
                    if(data.Producto.imagen != ''){
                        tbodyProd +=  "<td rowspan='4'><img src='http://www.newco.dev.br/Fotos/"+data.Producto.imagen+"' /></td>";
                    }
                    tbodyProd +="</tr>";
                    tbodyProd +=  "<tr><td class='labelRight grisMed'>"+ ref_estandar +":</td><td class='datosLeft'>"+data.Producto.ref_estandar+"</td></tr>";
                    tbodyProd +=  "<tr><td class='labelRight grisMed'>"+ marca +":</td><td class='datosLeft'>"+data.Producto.marca+"</td></tr>";
                    if(data.Producto.pais != '55'){
                        tbodyProd +=  "<tr><td class='labelRight grisMed'>"+ iva +":</td><td class='datosLeft'>"+data.Producto.iva+"</td></tr>";
                    }
                    tbodyProd +=  "<tr><td class='labelRight grisMed'>"+ unidad_basica +":</td><td class='datosLeft'>"+data.Producto.un_basica+"</td></tr>";
                    tbodyProd +=  "<tr><td class='labelRight grisMed'>"+ unidad_lote +":</td><td class='datosLeft'>"+data.Producto.un_lote+"</td></tr>";
                    if(data.Producto.farmacia != ''){
                        tbodyProd +=  "<tr><td class='labelRight grisMed'>"+ farmacia +":</td><td class='datosLeft'>"+data.Producto.farmacia+"</td></tr>";
                    }
                    if(data.Producto.homologado != ''){
                        tbodyProd +=  "<tr><td class='labelRight grisMed'>"+ homologado +":</td><td class='datosLeft'>"+data.Producto.homologado+"</td></tr>";
                    }
                    if(data.Producto.categoria != '' && data.Producto.categoria != 'DEFECTO'){
                        tbodyProd +=  "<tr><td class='labelRight grisMed'>"+ catalogo +":</td><td class='datosLeft'>"+data.Producto.categoria+"</td></tr>";
                    }
                    tbodyProd +=  "<tr><td class='labelRight grisMed'>"+ familia +":</td><td class='datosLeft'>"+data.Producto.familia+"</td></tr>";
                    tbodyProd +=  "<tr><td class='labelRight grisMed'>"+ subfamilia +":</td><td class='datosLeft'>"+data.Producto.sub_familia+"</td></tr>";
                    if(data.Producto.grupo != '' && data.Producto.categoria != 'DEFECTO'){
                        tbodyProd +=  "<tr><td class='labelRight grisMed'>"+ grupo +":</td><td class='datosLeft'>"+data.Producto.grupo+"</td></tr>";
                    }
                    
                    jQuery("#detalleProd tbody").append(tbodyProd);
                    
                    showTabla(true);    
                              
                }
                
            });
    }
   
    
    }//fin de verDetalleProducto

var sepCSV			=';';		//	20ene21
var sepTextoCSV		='';		//	20ene21
var saltoLineaCSV	='\r\n';	//	20ene21

//	3may21 Exporta la seleccion del usuario a CSV
function ExportarExcel()
{
	var oForm=document.forms['frmDocumentos'], cadenaCSV='';

	debug("DescargarExcel");

	jQuery.each(arrayProductos, function(key, linea){
		var Cant= linea.Cantidad;
		var Ref	= (linea.RefCliente!='')?linea.RefCliente:linea.RefPrivada;

		cadenaCSV+=Ref+sepCSV+Cant+saltoLineaCSV;
	});

	var Fecha=new Date;
	DescargaMIME(StringToISO(cadenaCSV), 'Pedido_'+Fecha.getDay()+(Fecha.getMonth()+1)+Fecha.getYear()+'.csv', 'text/csv');
}
