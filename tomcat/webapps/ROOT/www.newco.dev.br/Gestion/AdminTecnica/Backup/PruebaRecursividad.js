//	Pruebas recursividad con Ajax
//	ET 19mar17 10:09

var licProductos = new Array();
var licNumProductosEnviados=0;

function Inicializar()
{
	for (i=0;i<10;++i)
	{
		var item= [];
		item["Codigo"]="Cod"+i;
		item["Descripcion"]="Descripcion del producto "+i;
		item["Cantidad"]=100+i;
		
		licProductos.push(item);
	}
	
	licNumProductosEnviados=0;
}



//    31dic16    recuperamos los datos de ofertas de un proveedor
function EnviarTodosProductos()
{
    var d        = new Date();       
   
    //solodebug    alert(" nuevoProductoINTF_ID="+licIDFichero+"&NUMLINEA="+numLineaInicio+"&REFCLIENTE="+RefCliente+"&CANTIDAD="+Cantidad+"&TIPOIVA="+TipoIVA+"&TEXTO="+encodeURIComponent(texto));

    //    Entrada en el proceso
    console.log('enviarLineaFichero: licNumProductosEnviados:'+licNumProductosEnviados+ ' total:'+licProductos.length);

    if (licNumProductosEnviados>=licProductos.length)
    {
		console.log('enviarLineaFichero: licNumProductosEnviados:'+licNumProductosEnviados+ ' total:'+licProductos.length+ ' => SALIR');
		return 'OK';
    }
    else
    {
		console.log('enviarLineaFichero: licNumProductosEnviados:'+licNumProductosEnviados+ ' total:'+licProductos.length+ ' => enviar siguiente');
    }

    var texto    ='['+licProductos[licNumProductosEnviados].Codigo+'] '+licProductos[licNumProductosEnviados].Descripcion+':'+licProductos[licNumProductosEnviados].Cantidad;
	console.log('enviarLineaFichero: preparando envio: '+texto);

   
    jQuery.ajax({
        cache:    false,
        //async: false,
        url:    'http://www.newco.dev.br/Gestion/AdminTecnica/Pruebas.xsql',
        type:    "GET",
        data:    "US_ID=1&NOMBRE="+encodeURIComponent(texto)+"&_="+d.getTime(),
        contentType: "application/xhtml+xml",
        error: function(objeto, quepaso, otroobj){
            licError='ERROR_ENVIANDO';
            //licLineaError=numLineaInicio;
           
            licControlErrores+=licControlErrores+str_NoPodidoIncluirProducto+': ('+licProductos[licNumProductosEnviados].Codigo+') '+licProductos[licNumProductosEnviados].Descripcion+'<br/>';
            console.log('enviarLineaFichero: licNumProductosEnviados:'+licNumProductosEnviados+ ' total:'+licProductos.length+ ' => ERROR enviando:'+quepaso);
            return 'ERROR';
        },
        success: function(objeto){
            var data = eval("(" + objeto + ")");
           
            //
            //    Control de errores en la funcion que llama a esta
            //
                       
            //licIDSeleccion=    data.Producto.IDSeleccion;

            //    Envio correcto de datos
            //	console.log('enviarLineaFichero: IDProductoLic:'+data.Producto.IDProductoLic+' -> ('+licProductos[licNumProductosEnviados].Codigo+') '+licProductos[licNumProductosEnviados].Descripcion);

            //solodebug   
            console.log('enviarLineaFichero: licNumProductosEnviados:'+licNumProductosEnviados+ ' total:'+licProductos.length+ ' => OK');
            jQuery('#lineaActual').html(texto);
           
            //solodebug    if (numLineaInicio<3) alert("ASINCRONO:"+texto);

            //licProductos[licNumProductosEnviados].IDProductoLic=data.Producto.IDProductoLic;
           
            licNumProductosEnviados=licNumProductosEnviados+1;
            EnviarTodosProductos();
        }
    });
   

    //solodebug   
    //jQuery('#lineaActual').html(texto);

    //licNumProductosEnviados=licNumProductosEnviados+1;
    //EnviarTodosProductos();


}
