<?xml version="1.0" encoding="iso-8859-1" ?>
<!--
	Multioferta (todos los estados)
	Ultima revisi�n ET 20dic19 09:30
-->
   
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"> 
   
  <xsl:import href = "http://www.newco.dev.br/General/General.xsl" /> 
   <xsl:import href = "http://www.newco.dev.br/Compras/Multioferta/MultiofertaTemplateUnic.xsl" />          
  <xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>       
  <xsl:param name="lang" select="@lang"/>
    
  <!-- template principal -->              
  <xsl:template match="/">         
                                                   
  	<html>                     
      <head> 	       
        <title>  
        	<xsl:call-template name="tituloMOFtitle">
            	<xsl:with-param name="numMOF">MOF_<xsl:value-of select="/Multioferta/MULTIOFERTA/DERECHOS" /></xsl:with-param>
        	</xsl:call-template> 
        </title>  
        
            <link href="http://www.newco.dev.br/General/Tabla-popup.css" rel="stylesheet" type="text/css"/>
			
            <!--style--> 
            <xsl:call-template name="estiloIndip"/>
            <!--fin de style-->  
            
			<link rel="stylesheet" href="http://www.newco.dev.br/General/estiloPrint.css" type="text/css" media="print" />	 
            <script type="text/javascript" src="http://www.newco.dev.br/General/jquery-1.8.3.min.js"></script>
            <script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>  
            <script type="text/javascript" src="http://www.newco.dev.br/General/divisas.js"></script>
            <script type="text/javascript" src="http://www.newco.dev.br/General/Tabla-popup.js"></script>
			<script type="text/javascript" src="http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPValoracionProv_060917.js"></script>
			<script type="text/javascript" src="http://www.newco.dev.br/General/starrating.js"></script>
             
            <xsl:choose>   
            <xsl:when test="contains(/Multioferta/MULTIOFERTA/DERECHOS,'13_RW')"> 
            	<script type="text/javascript" src="http://www.newco.dev.br/Compras/Multioferta/MOFJS/MOF_13_RW_JS_021018.js"></script>
            </xsl:when>
            <xsl:when test="contains(/Multioferta/MULTIOFERTA/DERECHOS,'25_RW')">
            	<script type="text/javascript" src="http://www.newco.dev.br/Compras/Multioferta/MOFJS/MOF_25_RW_JS_021018.js"></script>
            </xsl:when>
            <xsl:when test="contains(/Multioferta/MULTIOFERTA/DERECHOS,'RW') and not(contains(/Multioferta/MULTIOFERTA/DERECHOS,'13_RW')) and not(contains(/Multioferta/MULTIOFERTA/DERECHOS,'25_RW'))">
            	<script type="text/javascript" src="http://www.newco.dev.br/Compras/Multioferta/MOFJS/MOF_{/Multioferta/MULTIOFERTA/DERECHOS}_JS.js"></script>
            </xsl:when>
            <xsl:when test="contains(/Multioferta/MULTIOFERTA/DERECHOS,'12_RO') or contains(/Multioferta/MULTIOFERTA/DERECHOS,'14_RO') or contains(/Multioferta/MULTIOFERTA/DERECHOS,'21_RO') or contains(/Multioferta/MULTIOFERTA/DERECHOS,'15_RO') or contains(/Multioferta/MULTIOFERTA/DERECHOS,'16_RO') or contains(/Multioferta/MULTIOFERTA/DERECHOS,'40_RO') or contains(/Multioferta/MULTIOFERTA/DERECHOS,'29_RO')">
            	<script type="text/javascript" src="http://www.newco.dev.br/Compras/Multioferta/MOFJS/MOF_InicializarImporte.js"></script>
            </xsl:when>    
            </xsl:choose> 
            
            <!--codigo etiquetas-->
            <script type="text/javascript" src="http://www.newco.dev.br/General/Tabla-popup.150715.js"></script>
            <script type="text/javascript" src="http://www.newco.dev.br/Gestion/Comercial/etiquetas.js"></script>

            <link rel="stylesheet" href="http://www.newco.dev.br/General/lightbox.css" type="text/css" media="screen"/>
            <link href="http://www.newco.dev.br/General/Tabla-popup.150715.css" rel="stylesheet" type="text/css"/>
            <!--fin codigo etiquetas-->
            
            <!--idioma-->
            <xsl:variable name="lang">
                    <xsl:choose>
                    <xsl:when test="/Analizar/LANG"><xsl:value-of select="/Analizar/LANG"/></xsl:when>
                    <xsl:otherwise>spanish</xsl:otherwise>
                    </xsl:choose>
            </xsl:variable>
            <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
            <!--idioma fin-->
            
            <script type="text/javascript">
			var IDMultioferta	= '<xsl:value-of select="/Multioferta/MULTIOFERTA/MO_ID"/>';
			var IDEmpresa		= '<xsl:value-of select="/Multioferta/MULTIOFERTA/MO_IDCLIENTE"/>';
			var IDUsuario		= '<xsl:value-of select="/Multioferta/MULTIOFERTA/USUARIO/ID"/>';
 			
			var nombre	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='nombre']/node()"/>';
			var proveedor	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/>';
			var ref_estandar	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='ref_estandar']/node()"/>';
			var ref_proveedor	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='ref_proveedor']/node()"/>';
			var marca	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='marca']/node()"/>';
			var iva	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='iva']/node()"/>';
			var unidad_basica	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='unidad_basica']/node()"/>';
			var unidad_lote	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='unidad_lote']/node()"/>';
			var farmacia	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='farmacia']/node()"/>';
			var homologado	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='homologado']/node()"/>';
			var precio	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='precio']/node()"/>';
			var familia	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='familia']/node()"/>';
			var subfamilia	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='subfamilia']/node()"/>';
			var grupo	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='grupo']/node()"/>';
			<!-- Variables y Strings JS para las etiquetas -->
			var IDRegistro = '<xsl:value-of select="/Multioferta/MULTIOFERTA/MO_ID"/>';
			var IDTipo = 'PED';
			var str_NuevaEtiquetaGuardada	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='nueva_etiqueta_guardada']/node()"/>';
			var str_NuevaEtiquetaError		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='nueva_etiqueta_error']/node()"/>';
			var str_autor			= '<xsl:value-of select="document($doc)/translation/texts/item[@name='autor']/node()"/>';
			var str_fecha			= '<xsl:value-of select="document($doc)/translation/texts/item[@name='fecha']/node()"/>';
			var str_etiqueta	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='etiqueta']/node()"/>';
			var str_borrar		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='borrar']/node()"/>';
			var incluyePacks	= '<xsl:value-of select="/Multioferta/MULTIOFERTA/MO_INCLUYEPACKS"/>';	// 3set18
			<!-- FIN Variables y Strings JS para las etiquetas -->
			</script>
            
            <xsl:text disable-output-escaping="yes"><![CDATA[ 
   
                <script type="text/javascript">
                <!--       

				/*	INICIO	Para valoraci�n de proveedores	*/
				jQuery(window).load(function(){
					initStarRating();
				});

				// init star rating functionality
				function initStarRating(context)
				{
					jQuery('.rating-holder', context).starRating();
				}
				/*	FINAL	Para valoraci�n de proveedores	*/


                   
                function ControlPedidos(IDPedido){
                    var form=document.forms[0];
                    form.method='post';
                    form.action='http://www.newco.dev.br/Personal/BandejaTrabajo/ControlPedidos.xsql?IDPEDIDO='+IDPedido;
                    SubmitForm(form);
                }
                
                  function VerXML(mo_id){
                  //alert(location.href);
                  	window.open('http://www.newco.dev.br/Compras/Multioferta/MultiofertaFrameXML.xsql?MO_ID='+mo_id,'_self');
                  }//fin verXML
                   
                  function MantenPedido(mo_id,idcliente,idprove){
//                  	window.open('http://www.newco.dev.br/Administracion/Mantenimiento/Pedidos/MANTPedidos.xsql?MO_ID='+mo_id+'&IDCLIENTE='+idcliente+'&IDPROVE='+idprove,'_self');
                  	window.open('http://www.newco.dev.br/Administracion/Mantenimiento/Pedidos/MANTPedidosSave.xsql?MO_ID='+mo_id+'&IDCLIENTE='+idcliente+'&IDPROVEEDOR='+idprove+'&ACCION=COMPROBAR','_self');
                  }//fin mantenPedido
                  
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
    function verDetalleProducto(idProd){
    
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
                
            //-->        
                </script>
        	]]></xsl:text> 
            
     </head>        
     <body>
         <xsl:attribute name="onLoad">
         <xsl:choose> 
         <xsl:when test="/Multioferta/MULTIOFERTA/DERECHOS = '11_RW'">inicializarImportes(document.forms['form1']);
                <xsl:if test="/Multioferta/MULTIOFERTA/MO_URGENCIA='S'">
                    PedidoUrgente();
                    <!--alert(msgPedidoUrgente);-->
            	</xsl:if>
		 </xsl:when>
         <xsl:when test="contains(/Multioferta/MULTIOFERTA/DERECHOS,'12') or contains(/Multioferta/MULTIOFERTA/DERECHOS,'14') or contains(/Multioferta/MULTIOFERTA/DERECHOS,'21') or contains(/Multioferta/MULTIOFERTA/DERECHOS,'23') or contains(/Multioferta/MULTIOFERTA/DERECHOS,'16') or contains(/Multioferta/MULTIOFERTA/DERECHOS,'40_RO')">
         	inicializarImportes(document.forms['form1']);  
         </xsl:when>
         <xsl:when test="/Multioferta/MULTIOFERTA/DERECHOS = '13_RW'">
              <xsl:choose>
                <xsl:when test="Multioferta/DATOSACTUALES=''">
                  inicializarImportes(document.forms['form1']);  
                </xsl:when>
                <xsl:otherwise>
                  inicializarImportes(document.forms['form1']);cargarDatosActuales(document.forms['form1'],'<xsl:value-of select="Multioferta/DATOSACTUALES"/>');  
                </xsl:otherwise>           
             </xsl:choose>
         </xsl:when>
         <xsl:when test="/Multioferta/MULTIOFERTA/DERECHOS = '25_RW'">
            <xsl:choose>
                <xsl:when test="Multioferta/DATOSACTUALES=''">
                  inicializarImportes(document.forms['form1']);RegistrarValores('INICIO', document.forms['form1']);
                </xsl:when>
                <xsl:otherwise>
                  inicializarImportes(document.forms['form1']);cargarDatosActuales(document.forms['form1'],'<xsl:value-of select="Multioferta/DATOSACTUALES"/>');RegistrarValores('INICIO', document.forms['form1']); 
                </xsl:otherwise>              
             </xsl:choose>   
         </xsl:when>
         </xsl:choose>
        
       </xsl:attribute>
    
        
        <xsl:choose>
           <xsl:when test="Multioferta/xsql-error">   
             <xsl:apply-templates select="//xsql-error"/>        
           </xsl:when>
           <xsl:when test="//SESION_CADUCADA">
             <xsl:apply-templates select="//SESION_CADUCADA"/> 
           </xsl:when>
           <xsl:when test="Multioferta/Status">
             <xsl:apply-templates select="//Status"/>        
           </xsl:when>   
           <xsl:otherwise>
               <xsl:apply-templates select="Multioferta/MULTIOFERTA"/>
           </xsl:otherwise>        
        </xsl:choose>  
   	  
          <!--idioma-->                                             
        <xsl:variable name="lang"> 
         	<xsl:choose>
                <xsl:when test="/Multioferta/LANG"><xsl:value-of select="/Multioferta/LANG" /></xsl:when>
                <xsl:otherwise>spanish</xsl:otherwise>
            </xsl:choose>  
        </xsl:variable>
        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
        <!--idioma fin-->

        <!-- detalle de producto -->
		<div class="overlay-container">
			<div class="window-container zoomout">
				<p style="text-align:right;margin-bottom:5px;">
                	<a href="javascript:showTabla(false);" style="text-decoration:none;"><img src="http://www.newco.dev.br/images/cerrar.gif" /></a>
                	<a href="javascript:showTabla(false);"><xsl:value-of select="document($doc)/translation/texts/item[@name='cerrar']/node()"/></a>
            	</p>
				<table class="infoTable incidencias" id="detalleProd" cellspacing="5" style="border-collapse:none; border:2px solid #7d7d7d;" >
				<tbody>
            	</tbody>
				</table>
			</div>
		</div>
		<!-- detalle de producto-->
        
        <!-- DIV Nueva etiqueta -->
        <div class="overlay-container" id="verEtiquetas">
            <div class="window-container zoomout">
                <p style="text-align:right;">
                    <a href="javascript:showTabla(false);" style="text-decoration:none;">
                        <xsl:value-of select="document($doc)/translation/texts/item[@name='cerrar']/node()"/>
                    </a>&nbsp;
                    <a href="javascript:showTabla(false);" style="text-decoration:none;">
                        <img src="http://www.newco.dev.br/images/cerrar.gif" alt="Cerrar" />
                    </a>
                </p>

                <p id="tableTitle">
                    <xsl:value-of select="document($doc)/translation/texts/item[@name='nueva_etiqueta']/node()"/>&nbsp;
                    <xsl:value-of select="document($doc)/translation/texts/item[@name='para']/node()"/>&nbsp;
                        <xsl:call-template name="tituloMOF">
                            <xsl:with-param name="numMOF">MOF_<xsl:value-of select="/Multioferta/MULTIOFERTA/DERECHOS" /></xsl:with-param>
                            <xsl:with-param name="empresa">S</xsl:with-param>
                        </xsl:call-template>
<!--
                        &nbsp;<a href="javascript:window.print();" style="text-decoration:none;">
                                <img src="http://www.newco.dev.br/images/imprimir.gif">
                                        <xsl:attribute name="alt"><xsl:value-of select="document($doc)/translation/texts/item[@name='imprimir']/node()"/></xsl:attribute>
                                        <xsl:attribute name="title"><xsl:value-of select="document($doc)/translation/texts/item[@name='imprimir']/node()"/></xsl:attribute>
                                </img>
                        </a>
-->
                </p>

                <div id="mensError" class="divLeft" style="display:none;">
                        <p><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='no_tiene_derechos']/node()"/></strong></p>
                </div>

                <table id="viejasEtiquetas" border="0" style="width:100%;display:none;">
                <thead>
                        <th colspan="5">&nbsp;</th>
                </thead>

                <tbody></tbody>

                </table>

                <form name="nuevaEtiquetaForm" method="post" id="nuevaEtiquetaForm">

                <table id="nuevaEtiqueta" style="width:100%;">
                <thead>
                        <th colspan="3">&nbsp;</th>
                </thead>

                <tbody>
                    <tr>
                        <td class="quince"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='etiqueta']/node()"/>:</strong></td>
                        <td colspan="2" style="text-align:left;"><textarea name="TEXTO" id="TEXTO" rows="4" cols="70" /></td>
                    </tr>
                </tbody>

                <tfoot>
                    <tr>
                        <td>&nbsp;</td>
                        <td>
                            <div class="boton" id="botonGuardar">
                                <a href="javascript:guardarEtiqueta();">
									<xsl:value-of select="document($doc)/translation/texts/item[@name='guardar']/node()"/>
                                </a>
                            </div>
                        </td>
                        <td id="Respuesta" style="text-align:left;"></td>
                    </tr>
                </tfoot>
                </table>
                </form>
            </div>
        </div>
<!-- FIN DIV Nueva etiqueta -->
        
	</body>     
  
</html>
</xsl:template>
<!-- fin template principal -->
 
<xsl:template match="MULTIOFERTA">
   <!--idioma-->                                             
        <xsl:variable name="lang"> 
         	<xsl:choose>
                <xsl:when test="/Multioferta/LANG"><xsl:value-of select="/Multioferta/LANG" /></xsl:when>
                <xsl:otherwise>spanish</xsl:otherwise>
            </xsl:choose> 
        </xsl:variable> 
        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
      <!--idioma fin-->
	  
	  
 		<!--	Texto para los t�tulos		-->
		<xsl:variable name="titulo">  
        	<xsl:call-template name="tituloMOF">
           		<xsl:with-param name="numMOF">MOF_<xsl:value-of select="/Multioferta/MULTIOFERTA/DERECHOS" /></xsl:with-param>
            	<xsl:with-param name="empresa">S</xsl:with-param>
        	</xsl:call-template>
		</xsl:variable>

 		<!--	Titulo de la p�gina		-->
		<div class="ZonaTituloPagina">
			<p class="Path"><xsl:value-of select="document($doc)/translation/texts/item[@name='Inicio']/node()"/>&nbsp;/&nbsp;<span class="FinPath"><xsl:value-of select="$titulo"/><!--<xsl:value-of select="document($doc)/translation/texts/item[@name='pedido']/node()"/>--></span>
			<!--<span class="CompletarTitulo">
				<xsl:value-of select="$titulo"/>
			</span>-->
			</p>
			<p class="TituloPagina">
        		<xsl:value-of select="PED_NUMERO"/>&nbsp;<xsl:value-of select="substring(CLIENTE,0,70)"/><!--<xsl:value-of select="substring($titulo,0,44)"/>-->
				<span class="CompletarTitulo" id="ocultarBotones" style="width:780px;">
					<!--	Aqu� pondremos los botones m�s b�sicos: Salir, imprimir, etc		-->
    				<xsl:choose>
        				<!--mof muestras botones-->
        				 <xsl:when test="contains(/Multioferta/MULTIOFERTA/DERECHOS,'32_RW')"> 
    						<xsl:call-template name="botonesCuatroMultioferta" />
        				 </xsl:when>
        				 <xsl:when test="contains(/Multioferta/MULTIOFERTA/DERECHOS,'33_RW') or contains(/Multioferta/MULTIOFERTA/DERECHOS,'23_RW') or contains(/Multioferta/MULTIOFERTA/DERECHOS,'12_RW') or contains(/Multioferta/MULTIOFERTA/DERECHOS,'41_RW')"> 
    						<xsl:call-template name="botonesTresRechazoMultioferta" />
        				 </xsl:when>
        				 <xsl:when test="contains(/Multioferta/MULTIOFERTA/DERECHOS,'35_RW')">
    						<xsl:call-template name="botonesTresRecibidaMultioferta" />
        				 </xsl:when>
        				 <xsl:when test="contains(/Multioferta/MULTIOFERTA/DERECHOS,'36_RW')"> 
    						<xsl:call-template name="botonesTresMultioferta" />
        				 </xsl:when>
        				 <!--fin mof muestras botones-->

        				 <!--mof pedidos botones-->
        				 <xsl:when test="contains(/Multioferta/MULTIOFERTA/DERECHOS,'11_RW')"> 
    						<xsl:call-template name="botonesProvAceptarPedido" />
        				 </xsl:when>
        				 <xsl:when test="contains(/Multioferta/MULTIOFERTA/DERECHOS,'14_RW')"> 
    						<xsl:call-template name="botonesCuatroMultioferta" />
        				 </xsl:when>
        				 <xsl:when test="contains(/Multioferta/MULTIOFERTA/DERECHOS,'13_RW') or contains(/Multioferta/MULTIOFERTA/DERECHOS,'25_RW')"> 
    						<xsl:call-template name="botonesMultioferta" /> 
        				 </xsl:when>
						 <!--
        				 <xsl:when test="contains(/Multioferta/MULTIOFERTA/DERECHOS,'12_RW')"> 
         					<xsl:call-template name="botonesIncidenciaMultioferta" /> 
        				 </xsl:when>  
						 --><!--30ene18	estado incluido en botonesTresRechazoMultioferta-->
        				 <xsl:when test="contains(/Multioferta/MULTIOFERTA/DERECHOS,'21_RW')">
         					<xsl:call-template name="botonesTresAbonoPendienteMultioferta" />
        				 </xsl:when>
        				 <xsl:when test="contains(/Multioferta/MULTIOFERTA/DERECHOS,'15_RW')"> 
         					<xsl:call-template name="botonesCuatroCobroMultioferta" />
        				 </xsl:when>
        				 <xsl:when test="contains(/Multioferta/MULTIOFERTA/DERECHOS,'40_RW')">
						 	<xsl:choose>
        						<!--mof muestras botones-->
        				 		<xsl:when test="/Multioferta/MULTIOFERTA/PERMITIR_MANTENIMIENTO">
		         					<xsl:call-template name="botonesUsuarioAprobador" />
								</xsl:when>
								<xsl:otherwise>
									<xsl:call-template name="botonesDosAbonoMultioferta" />
								</xsl:otherwise>
							</xsl:choose>
        				 </xsl:when> 
        				 <xsl:when test="contains(/Multioferta/MULTIOFERTA/DERECHOS,'28_RW')">    
         					<xsl:call-template name="botonesGuardarMultioferta" />
        				 </xsl:when>
        				 <xsl:when test="contains(/Multioferta/MULTIOFERTA/DERECHOS,'30_RW')"> 
         					<xsl:call-template name="botonesCuatroProgramaMultioferta" />
        				 </xsl:when>     
        				 <xsl:otherwise>  
        				 <!--32_RO,33_RO,34_RO,35_RO,36_RO,37_RO ->MUESTRAS | 28 ped progr -->
         					<xsl:call-template name="botonesDosMultioferta" />
        				 </xsl:otherwise>
        			 </xsl:choose>
					&nbsp;<!--	19ene18	A�adimos el boton de enviar PDF al usuario para todos los estados	-->
            		<a class="btnNormal" id="btnRecibirPDF">
                		<xsl:attribute name="href">javascript:EnviarPDF('<xsl:value-of select="/Multioferta/MULTIOFERTA/MO_ID"/>','USUARIO');</xsl:attribute>
                		<xsl:value-of select="document($doc)/translation/texts/item[@name='recibir_pdf']/node()"/>
            		</a>
				</span>
			</p>
       </div>
	   <br/>
<!--    <h1 class="titlePage">
        <a id="conEtiquetas" href="javascript:abrirEtiqueta(true);" style="text-decoration:none;display:none;">
					<img src="http://www.newco.dev.br/images/tagsAma.png" width="20px">
						<xsl:attribute name="alt"><xsl:value-of select="document($doc)/translation/texts/item[@name='ver_mas_nueva_etiqueta']/node()"/></xsl:attribute>
						<xsl:attribute name="title"><xsl:value-of select="document($doc)/translation/texts/item[@name='ver_mas_nueva_etiqueta']/node()"/></xsl:attribute>
					</img>
				</a>&nbsp;

				<a id="sinEtiquetas" href="javascript:abrirEtiqueta(false);" style="text-decoration:none;display:none;">
					<img src="http://www.newco.dev.br/images/tags.png" width="20px">
						<xsl:attribute name="alt"><xsl:value-of select="document($doc)/translation/texts/item[@name='nueva_etiqueta']/node()"/></xsl:attribute>
						<xsl:attribute name="title"><xsl:value-of select="document($doc)/translation/texts/item[@name='nueva_etiqueta']/node()"/></xsl:attribute>
					</img>
				</a>&nbsp; 
        <xsl:call-template name="tituloMOF">
           	<xsl:with-param name="numMOF">MOF_<xsl:value-of select="/Multioferta/MULTIOFERTA/DERECHOS" /></xsl:with-param>
            <xsl:with-param name="empresa">S</xsl:with-param>
        </xsl:call-template>
    </h1>           
-->     

	<!--	6set17	Formulario para valoracion de provedores		-->
	<form name="formValoracion" action="EMPValoracionProv.xsql" method="post">
	<xsl:call-template name="nuevavaloracion">
		<xsl:with-param name="doc" select="$doc"/>
		<xsl:with-param name="idproveedor" select="DATOSPROVEEDOR/EMP_ID"/>
		<xsl:with-param name="proveedor" select="DATOSPROVEEDOR/EMP_NOMBRE"/>
		<xsl:with-param name="fecha" select="FECHA"/>
	</xsl:call-template>
	</form>



    <!--form input-->
    <form method="post" name="form1"> 
     	<input type="hidden" name="MO_ROL" value="{/Multioferta/ROL}"/><!--sirve?? quiza no-->
        <input type="hidden" name="MO_TIPO" value="{/Multioferta/TIPO}"/><!--sirve?? quiza no-->
        <input type="hidden" name="MO_STATUS" value="{/Multioferta/MULTIOFERTA/MO_STATUS}"/><!--uso nel js en todos-->
        <input type="hidden" name="MO_ID" value="{/Multioferta/MULTIOFERTA/MO_ID}"/><!--uso nel js en todos-->
    <xsl:choose> 
    <!--muestras 32_rw y 35_rw-->
    <xsl:when test="contains(/Multioferta/MULTIOFERTA/DERECHOS,'32_RW') or contains(/Multioferta/MULTIOFERTA/DERECHOS,'35_RW')">
            <input type="hidden" name="STRING_CANTIDADES"/>
            <input type="hidden" name="STRING_PRECIOS"/>      
            <input type="hidden" name="RECIBIDO"/> 
            <input type="hidden" name="RECIBIDO_GLOBAL" value="1"/>
            <input type="hidden" name="NMU_COMENTARIOS"/>
            <xsl:element name="input">   
             <xsl:attribute name="name">IDDIVISA</xsl:attribute>
             <xsl:attribute name="type">hidden</xsl:attribute>
             <xsl:attribute name="value"><xsl:value-of select="//@current"/></xsl:attribute>
    	   </xsl:element>
    </xsl:when>
    <!--pedido 11_rw-->    
    <xsl:when test="contains(/Multioferta/MULTIOFERTA/DERECHOS,'11_RW')">
		<input type="hidden" name="STRING_CANTIDADES"/>
		<input type="hidden" name="STRING_PRECIOS"/>
		<input type="hidden" name="NMU_COMENTARIOS"/>
		<input type="hidden" name="OTROSPARAMETROS" value="?"/>	
		<input type="hidden" name="MO_URGENCIA" value="{/Multioferta/MULTIOFERTA/MO_URGENCIA}"/>
		<xsl:element name="input">
			<xsl:attribute name="name">IDDIVISA</xsl:attribute>
			<xsl:attribute name="type">hidden</xsl:attribute>
			<xsl:attribute name="value"><xsl:value-of select="//@current"/></xsl:attribute>
			<!--	ET 11jun07	Estos valores se utilizaban online en javascript, imposible seguir el codigo	-->
			<xsl:choose>
			<xsl:when test="/Multioferta/MULTIOFERTA/SOLICITAR_CONFIRMACION">
				<input type="hidden" name="SOLICITARCONFIRMACION" value="S"/>
			</xsl:when>
			<xsl:otherwise>
				<input type="hidden" name="SOLICITARCONFIRMACION" value="N"/>
			</xsl:otherwise>
			</xsl:choose>
		</xsl:element>
    </xsl:when>
    <!--pedido 13_rw-->
    <xsl:when test="contains(/Multioferta/MULTIOFERTA/DERECHOS,'13_RW')">
		<input type="hidden" name="STRING_CANTIDADES"/>
        <input type="hidden" name="STRING_PRECIOS"/>
        <input type="hidden" name="NMU_COMENTARIOS"/>
        <input type="hidden" name="RECIBIDO"/>
        <input type="hidden" name="RECIBIDO_GLOBAL" value="1"/>
    </xsl:when>
     <!--pedido 25_rw-->
    <xsl:when test="contains(/Multioferta/MULTIOFERTA/DERECHOS,'25_RW')">
		<input type="hidden" name="STRING_CANTIDADES"/>   
        <input type="hidden" name="STRING_PRECIOS"/>
        <input type="hidden" name="NMU_COMENTARIOS"/>
        <input type="hidden" name="RECIBIDO"/>
        <input type="hidden" name="RECIBIDO_GLOBAL" value="0"/>
        <input type="hidden" name="OTROSPARAMETROS" value="" />
    </xsl:when>
    <!--pedido 12_rw y 15 y abono 21 -->
    <xsl:when test="contains(/Multioferta/MULTIOFERTA/DERECHOS,'12_RW') or contains(/Multioferta/MULTIOFERTA/DERECHOS,'21') or contains(/Multioferta/MULTIOFERTA/DERECHOS,'15')">
        <input type="hidden" name="STRING_CANTIDADES"/>
        <input type="hidden" name="STRING_PRECIOS"/>  
        <input type="hidden" name="NMU_COMENTARIOS"/>
        <input type="hidden" name="MO_FORMAPAGO" value="{//MO_FORMAPAGO}"/>
    </xsl:when>
     <!--pedido 14_rw y 14_ro que hace solo inicializar importe-->
    <xsl:when test="contains(/Multioferta/MULTIOFERTA/DERECHOS,'14')">
        <input type="hidden" name="STRING_CANTIDADES"/>
        <input type="hidden" name="STRING_PRECIOS"/>
        <input type="hidden" name="NMU_COMENTARIOS"/>
        <input type="hidden" name="MO_FORMAPAGO" value="{//MO_FORMAPAGO}"/>
    </xsl:when>
    <!--pedido 40_rw abono o pedido pend aprobacion-->
    <xsl:when test="contains(/Multioferta/MULTIOFERTA/DERECHOS,'40_RW')">
        <input type="hidden" name="STRING_CANTIDADES"/>
        <input type="hidden" name="STRING_PRECIOS"/>
        <input type="hidden" name="NMU_COMENTARIOS"/>
        <input type="hidden" name="RECIBIDO"/>
        <input type="hidden" name="RECIBIDO_GLOBAL" value="1"/>
    </xsl:when>  
    <!--pedido 28_rw y 28-ro pedido programado-->
    <xsl:when test="contains(/Multioferta/MULTIOFERTA/DERECHOS,'28')">
        <input type="hidden" name="ESMODELO" value="/Multioferta/ESMODELO"/>
        <input type="hidden" name="STRING_CANTIDADES"/>
        <input type="hidden" name="STRING_PRECIOS"/>
        <input type="hidden" name="NMU_COMENTARIOS"/>
        <input type="hidden" name="SOLO_SIGUIENTE"/>
        <input type="hidden" name="MO_FORMAPAGO" value="{//MO_FORMAPAGO}"/>
        <input type="hidden" name="REFRESCAR_PADRE">
        	<xsl:if test="/Multioferta/ESMODELO='S'">
        		<xsl:attribute name="value">S</xsl:attribute>
        	</xsl:if>
        </input> 
        <xsl:element name="input"> 
          <xsl:attribute name="name">IDDIVISA</xsl:attribute>
          <xsl:attribute name="type">hidden</xsl:attribute>
          <xsl:attribute name="value"><xsl:value-of select="//@current"/></xsl:attribute>
        </xsl:element>
    </xsl:when> 
    <!--pedido 30_rw acepta pedido programado-->
    <xsl:when test="contains(/Multioferta/MULTIOFERTA/DERECHOS,'30')">
        <input type="hidden" name="STRING_CANTIDADES"/>
        <input type="hidden" name="STRING_PRECIOS"/>
        <input type="hidden" name="NMU_COMENTARIOS"/>
        <input type="hidden" name="PLAZO_ENTREGA_DEFECTO" value="/Multioferta/MULTIOFERTA/LP_PLAZOENTREGA"/>
    </xsl:when>
    <xsl:otherwise>
        <input type="hidden" name="STRING_CANTIDADES"/>
        <input type="hidden" name="STRING_PRECIOS"/>
        <input type="hidden" name="NMU_COMENTARIOS"/>
        <input type="hidden" name="MO_FORMAPAGO" value="{//MO_FORMAPAGO}"/>
        <xsl:element name="input"> 
          <xsl:attribute name="name">IDDIVISA</xsl:attribute>
          <xsl:attribute name="type">hidden</xsl:attribute>
          <xsl:attribute name="value"><xsl:value-of select="//@current"/></xsl:attribute>
        </xsl:element>
    </xsl:otherwise>
    
    </xsl:choose>
    <!--fin form input-->
     
   <div class="divLeft99">
    
    <!--datos del cliente --> 
       <div class="divLeft35">
      		<xsl:call-template name="datosCliente" />
       </div><!--fin de divLeft50nopa-->
       
        
    <!--proveedor--> 
    	<div class="divLeft35">   
        	<xsl:choose>
            <xsl:when test="contains(/Multioferta/MULTIOFERTA/DERECHOS,'32') or contains(/Multioferta/MULTIOFERTA/DERECHOS,'33') or contains(/Multioferta/MULTIOFERTA/DERECHOS,'34') or contains(/Multioferta/MULTIOFERTA/DERECHOS,'35') or contains(/Multioferta/MULTIOFERTA/DERECHOS,'36') or contains(/Multioferta/MULTIOFERTA/DERECHOS,'37')"><!--datos muestras, mof muestras-->
            
            	<xsl:call-template name="datosProveedor">
            		<xsl:with-param name="numMOF">MOF_<xsl:value-of select="/Multioferta/MULTIOFERTA/DERECHOS" />_Muestras</xsl:with-param>       
            	</xsl:call-template>
            
            </xsl:when>
            <xsl:otherwise>
            <!--datos proveedor pedido normal-->
            	<xsl:call-template name="datosProveedor"/>
            </xsl:otherwise>
            </xsl:choose>  
       </div><!--fin de divLeft50-->
        
        
   <!--DATOS PEDIDO--> 
        <div class="divLeft30nopa">
        	<xsl:choose>
            <xsl:when test="contains(/Multioferta/MULTIOFERTA/DERECHOS,'32') or contains(/Multioferta/MULTIOFERTA/DERECHOS,'33') or contains(/Multioferta/MULTIOFERTA/DERECHOS,'34') or contains(/Multioferta/MULTIOFERTA/DERECHOS,'35') or contains(/Multioferta/MULTIOFERTA/DERECHOS,'36') or contains(/Multioferta/MULTIOFERTA/DERECHOS,'37')">
            <!--datos muestras, mof muestras--> 
            	<xsl:call-template name="datosMuestra">
            		<xsl:with-param name="numMOF">MOF_<xsl:value-of select="/Multioferta/MULTIOFERTA/DERECHOS" />_Muestras</xsl:with-param>  
            	</xsl:call-template>
            </xsl:when>   
            <!--datos abono, mof abono--> 
            <xsl:when test="contains(/Multioferta/MULTIOFERTA/DERECHOS,'21') or contains(/Multioferta/MULTIOFERTA/DERECHOS,'22') or contains(/Multioferta/MULTIOFERTA/DERECHOS,'23') or contains(/Multioferta/MULTIOFERTA/DERECHOS,'24') or contains(/Multioferta/MULTIOFERTA/DERECHOS,'14')"><!-- or contains(/Multioferta/MULTIOFERTA/DERECHOS,'40')-->
            	<xsl:call-template name="datosAbono">
                	<xsl:with-param name="numMOF">MOF_<xsl:value-of select="/Multioferta/MULTIOFERTA/DERECHOS" />_Abono</xsl:with-param>
            	</xsl:call-template>
            </xsl:when>
            <!--datos mof 11--> 
            <xsl:when test="contains(/Multioferta/MULTIOFERTA/DERECHOS,'11')">
            	<xsl:call-template name="datosPedido_MOF_11">
            		<xsl:with-param name="numMOF">MOF_<xsl:value-of select="/Multioferta/MULTIOFERTA/DERECHOS" /></xsl:with-param>
            	</xsl:call-template>
            </xsl:when> 
             <!--datos mof 28 pedido programaso--> 
            <xsl:when test="contains(/Multioferta/MULTIOFERTA/DERECHOS,'28') or contains(/Multioferta/MULTIOFERTA/DERECHOS,'30')">
            	<xsl:call-template name="datosPedido_Prog">
            		<xsl:with-param name="numMOF">MOF_<xsl:value-of select="/Multioferta/MULTIOFERTA/DERECHOS" /></xsl:with-param>
            	</xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
            <!--datos pedido normal-->
            	<xsl:call-template name="datosPedido">
            		<xsl:with-param name="numMOF">MOF_<xsl:value-of select="/Multioferta/MULTIOFERTA/DERECHOS" /></xsl:with-param>
            	</xsl:call-template>
            </xsl:otherwise>
            </xsl:choose>
      		
    	</div><!--fin divleft50nopa-->
		
		
		<!--	30ene17	Para las empresas que lo requieran, mostrar forma y plazo de pago
		26ago19 Movemos este bloque a la cabecera
		<xsl:if test="/Multioferta/MULTIOFERTA/CAMBIARFORMAPAGO and /Multioferta/MULTIOFERTA/FORMAPAGO!=''">
		<br/>
			<xsl:value-of select="document($doc)/translation/texts/item[@name='forma_pago']/node()"/>:&nbsp;<xsl:value-of select="/Multioferta/MULTIOFERTA/FORMAPAGO"/>.&nbsp;
			<xsl:value-of select="document($doc)/translation/texts/item[@name='plazo_pago']/node()"/>:&nbsp;<xsl:value-of select="/Multioferta/MULTIOFERTA/PLAZOPAGO"/>.
		<br/>
		</xsl:if>-->
    
    </div><!--fin divLeft-->
		
	<!--	30ene17	Para las empresas que lo requieran, mostrar forma y plazo de pago
	26ago19 Movemos este bloque a la cabecera-->
    
	<xsl:if test="/Multioferta/MULTIOFERTA/MO_IDLICITACION!='' or (/Multioferta/MULTIOFERTA/CAMBIARFORMAPAGO and /Multioferta/MULTIOFERTA/FORMAPAGO!='')">
		<br/>
	</xsl:if>
	<xsl:if test="/Multioferta/MULTIOFERTA/MO_IDLICITACION!=''">
		<p style="float:left;width:25%">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='licitacion']/node()"/>:&nbsp;
		<strong><a href="http://www.newco.dev.br/Gestion/Comercial/MantLicitacion.xsql?LIC_ID={/Multioferta/MULTIOFERTA/MO_IDLICITACION}" target="blank_"><xsl:value-of select="/Multioferta/MULTIOFERTA/LICITACION"/></a></strong></p>
	</xsl:if>
	<xsl:if test="/Multioferta/MULTIOFERTA/CAMBIARFORMAPAGO and /Multioferta/MULTIOFERTA/FORMAPAGO!=''">
		<p style="float:center;width:55%;text-align:center;">
			<xsl:value-of select="document($doc)/translation/texts/item[@name='forma_pago']/node()"/>:&nbsp;<strong><xsl:value-of select="/Multioferta/MULTIOFERTA/FORMAPAGO"/></strong>.&nbsp;
			<xsl:value-of select="document($doc)/translation/texts/item[@name='plazo_pago']/node()"/>:&nbsp;<strong><xsl:value-of select="/Multioferta/MULTIOFERTA/PLAZOPAGO"/></strong>.
		</p>
	</xsl:if>
	<xsl:if test="/Multioferta/MULTIOFERTA/MO_IDLICITACION!='' or (/Multioferta/MULTIOFERTA/CAMBIARFORMAPAGO and /Multioferta/MULTIOFERTA/FORMAPAGO!='')">
		<br/>
	</xsl:if>
       
    <!--<div class="divLeft sombra">&nbsp;</div>
    <div class="divLeft99">   
    	<div class="divLeft50nopa">
            <xsl:call-template name="NEGOCIACION">
            	<xsl:with-param name="numMOF">MOF_13_RO</xsl:with-param>    
                <xsl:with-param name="insertCome">no</xsl:with-param> 
                <xsl:with-param name="albaran">no</xsl:with-param>    
            </xsl:call-template>       
     	</div>
      </div>fin de divLeft -->     
           
              
   <!--DETALLE DE PRODUCTOS - Nota: TODOS los templates  tambien difieren segun el estado --> 
	<div class="divLeft99">   
    	<xsl:choose>
        <!--caso particular mof 11_RO-->
        <xsl:when test="/Multioferta/MULTIOFERTA/DERECHOS = '11_RO'">    
        	<xsl:call-template name="templateProductos">    
            	<xsl:with-param name="numMOF">MOF_11_RO</xsl:with-param>   
        	</xsl:call-template>  
        </xsl:when>
        
        <xsl:when test="contains(/Multioferta/MULTIOFERTA/DERECHOS,'21') or contains(/Multioferta/MULTIOFERTA/DERECHOS,'22') or contains(/Multioferta/MULTIOFERTA/DERECHOS,'23') or contains(/Multioferta/MULTIOFERTA/DERECHOS,'24') or contains(/Multioferta/MULTIOFERTA/DERECHOS,'14') or contains(/Multioferta/MULTIOFERTA/DERECHOS,'24') or contains(/Multioferta/MULTIOFERTA/DERECHOS,'40')">    
            <xsl:call-template name="templateProductos">
                <xsl:with-param name="numMOF">MOF_<xsl:value-of select="/Multioferta/MULTIOFERTA/DERECHOS" />_Abono</xsl:with-param>
            </xsl:call-template>
        </xsl:when>
        
        <!--muestras, mof de muestras-->
        <xsl:when test="contains(/Multioferta/MULTIOFERTA/DERECHOS,'32') or contains(/Multioferta/MULTIOFERTA/DERECHOS,'33') or contains(/Multioferta/MULTIOFERTA/DERECHOS,'34') or contains(/Multioferta/MULTIOFERTA/DERECHOS,'35') or contains(/Multioferta/MULTIOFERTA/DERECHOS,'36') or contains(/Multioferta/MULTIOFERTA/DERECHOS,'37')">
        	<xsl:call-template name="templateMuestras">
                <xsl:with-param name="numMOF">MOF_<xsl:value-of select="/Multioferta/MULTIOFERTA/DERECHOS" />_Muestras</xsl:with-param>
                <xsl:with-param name="insertCome">no</xsl:with-param>  
        	</xsl:call-template>
        </xsl:when>
        
        <xsl:otherwise>
        	<xsl:call-template name="templateProductos">
                <xsl:with-param name="numMOF">MOF_<xsl:value-of select="/Multioferta/MULTIOFERTA/DERECHOS" /></xsl:with-param>
            </xsl:call-template>
        </xsl:otherwise>
        </xsl:choose>
  
	</div><!--fin de divLeft-->       
        
    <!--botones ver xml y ir a mant pedido solo para mvm y mvm br-->
    <!-- <xsl:if test="/Multioferta/MULTIOFERTA/USUARIO/IDEMPRESA = '1' or /Multioferta/MULTIOFERTA/USUARIO/IDEMPRESA = '6316'">-->
     <xsl:if test="/Multioferta/MULTIOFERTA/PERMITIR_CONTROL_PEDIDOS or /Multioferta/MULTIOFERTA/PERMITIR_MANTENIMIENTO">
        <div class="divLeft" style="margin-top:40px; padding:5px 0px; background:#FF9;">
            <xsl:call-template name="botonesMVM" />
        </div><!--fin de divLeft-->
    </xsl:if>

    <!--boton ir a mant pedido solo para usuario que genera el pedido programado (estado 28) -->
     <xsl:if test="/Multioferta/MULTIOFERTA/DERECHOS = '28_RO' and /Multioferta/MULTIOFERTA/USUARIO/ID = /Multioferta/MULTIOFERTA/MO_IDUSUARIOCOMPRADOR">
        <div class="divLeft" style="margin-top:40px; padding:5px 0px; background:#FF9;">
            <xsl:call-template name="botonMantPedido" />
        </div><!--fin de divLeft-->
    </xsl:if>
	
    </form>
    
    <form name="MensajeJS">
    <input type="hidden" name="PDF_ENVIADO_CLIENTE" value="{document($doc)/translation/texts/item[@name='pdf_enviado_cliente']/node()}"/>
    <input type="hidden" name="PDF_ENVIADO_PROVEE" value="{document($doc)/translation/texts/item[@name='pdf_enviado_provee']/node()}"/>
    <input type="hidden" name="PDF_ENVIADO_USUARIO" value="{document($doc)/translation/texts/item[@name='pdf_enviado_usuario']/node()}"/>
    <input type="hidden" name="ERROR_PDF_ENVIADO_CLIENTE" value="{document($doc)/translation/texts/item[@name='error_pdf_enviado_cliente']/node()}"/>
    <input type="hidden" name="ERROR_PDF_ENVIADO_PROVEE" value="{document($doc)/translation/texts/item[@name='error_pdf_enviado_provee']/node()}"/>
    <input type="hidden" name="ERROR_PDF_ENVIADO_USUARIO" value="{document($doc)/translation/texts/item[@name='error_pdf_enviado_usuario']/node()}"/>
    <xsl:choose>
    <xsl:when test="/Multioferta/MULTIOFERTA/DERECHOS = '35_RW'">    
    <!--mof_35_rw muestras-->
  		<input type="hidden" name="PRODUCTOS_MARCADOS_RECIBIDO" value="{document($doc)/translation/texts/item[@name='productos_marcados_recibido']/node()}"/>
    	<input type="hidden" name="PRODUCTOS_MARCADOS_RECIBIDO1" value="{document($doc)/translation/texts/item[@name='productos_marcados_recibido1']/node()}"/>
    	<input type="hidden" name="ES_EL" value="{document($doc)/translation/texts/item[@name='es_el']/node()}"/>
    	<input type="hidden" name="GRACIAS" value="{document($doc)/translation/texts/item[@name='gracias']/node()}"/>
    	<input type="hidden" name="FECHA_CORRECTA_RECEPCION" value="{document($doc)/translation/texts/item[@name='fecha_correcta_recepcion']/node()}"/>
    	<input type="hidden" name="CANCELAR_INFORMAR_FECHA" value="{document($doc)/translation/texts/item[@name='cancelar_informar_fecha']/node()}"/>
    	<input type="hidden" name="INTRODUZCA_CANTIDAD_CORRECTA" value="{document($doc)/translation/texts/item[@name='introduzca_cantidad_correcta']/node()}"/>
    	<input type="hidden" name="RECIBIDA_SUPERIOR_SOLICITADA" value="{document($doc)/translation/texts/item[@name='recibidas_superior_solicitada']/node()}"/>
    	<input type="hidden" name="SOSTITUIRA_POR_SOLICITADA" value="{document($doc)/translation/texts/item[@name='sostituira_por_solicitada']/node()}"/>
    	<input type="hidden" name="UNIDADES" value="{document($doc)/translation/texts/item[@name='unidad_es']/node()}"/>
    	<input type="hidden" name="UNIDADES_NO_ENTERO_CAJAS" value="{document($doc)/translation/texts/item[@name='unidad_no_entero_cajas']/node()}"/>
    	<input type="hidden" name="REDONDEADO_COINCIDA" value="{document($doc)/translation/texts/item[@name='redondeado_coincida']/node()}"/>
    	<input type="hidden" name="CAJAS" value="{document($doc)/translation/texts/item[@name='cajas']/node()}"/>
    	<input type="hidden" name="RECIBIDA_INFERIOR_SOLICITADA" value="{document($doc)/translation/texts/item[@name='recibidas_inferior_solicitada']/node()}"/>
    	<input type="hidden" name="ACEPTAR_CANTIDAD_PARCIAL" value="{document($doc)/translation/texts/item[@name='aceptar_cantidad_parcial']/node()}"/>
    	<input type="hidden" name="CANCELAR_MARCAR_RECIBIDO" value="{document($doc)/translation/texts/item[@name='cancelar_marcar_recibido']/node()}"/>
		<!--fin mof_35_rw-->
    </xsl:when>
    <xsl:when test="/Multioferta/MULTIOFERTA/DERECHOS = '11_RW'">    
    	<!--mof_11_rw pedido-->
    	<input type="hidden" name="MENS_URGENTE" value="{document($doc)/translation/texts/item[@name='mens_urgente']/node()}"/>
		<input type="hidden" name="MENS_URGENTE1" value="{document($doc)/translation/texts/item[@name='mens_urgente1']/node()}"/>
		<input type="hidden" name="MENS_URGENTE2" value="{document($doc)/translation/texts/item[@name='mens_urgente2']/node()}"/>
		<input type="hidden" name="GRACIAS" value="{document($doc)/translation/texts/item[@name='gracias']/node()}"/>
		<input type="hidden" name="ERROR_FECHA_SALIDA" value="{document($doc)/translation/texts/item[@name='error_fecha_salida_pedido']/node()}"/>
		<input type="hidden" name="OBLI_INFORMAR_PEDIDO_A_TIEMPO" value="{document($doc)/translation/texts/item[@name='obli_informar_pedido_a_tiempo']/node()}"/>
		<input type="hidden" name="INFORMAR_FECHA_ENTREGA_URGENTE" value="{document($doc)/translation/texts/item[@name='informar_fecha_entrega_urgente']/node()}"/>
		<input type="hidden" name="CONFIRME_LEIDO_COMENTARIOS" value="{document($doc)/translation/texts/item[@name='confirme_leido_comentarios']/node()}"/>
		<input type="hidden" name="CONFIRMA_RECHAZO_PEDIDO" value="{document($doc)/translation/texts/item[@name='confirma_rechazo_pedido']/node()}"/>
		<input type="hidden" name="COMUNIQUE_MOTIVO_RECHAZO" value="{document($doc)/translation/texts/item[@name='rogamos_comunique_motivo_rechazo']/node()}"/>
		<input type="hidden" name="GRAC" value="{document($doc)/translation/texts/item[@name='gracias']/node()}"/>
    <!--fin mof_11_rw--> 
    </xsl:when>
    <xsl:when test="/Multioferta/MULTIOFERTA/DERECHOS = '13_RW'">    
    <!--mof_13_rw pedido-->
    	<input type="hidden" name="SIN_CANTIDADES_PARA_ABONO" value="{document($doc)/translation/texts/item[@name='sin_cantidades_para_abono']/node()}"/>
    	<input type="hidden" name="SIN_CANTIDADES_PARA_ABONO1" value="{document($doc)/translation/texts/item[@name='sin_cantidades_para_abono1']/node()}"/>
    	<input type="hidden" name="ES_EL" value="{document($doc)/translation/texts/item[@name='es_el']/node()}"/>
    	<input type="hidden" name="GRACIAS" value="{document($doc)/translation/texts/item[@name='gracias']/node()}"/>     
    	<input type="hidden" name="FECHA_CORRECTA_RECEPCION" value="{document($doc)/translation/texts/item[@name='fecha_correcta_recepcion']/node()}"/>
    	<input type="hidden" name="CANCELAR_INFORMAR_FECHA" value="{document($doc)/translation/texts/item[@name='cancelar_informar_fecha']/node()}"/> 
    	<input type="hidden" name="INTRODUZCA_CANTIDAD_CORRECTA" value="{document($doc)/translation/texts/item[@name='introduzca_cantidad_correcta']/node()}"/>
    	<input type="hidden" name="RECIBIDA_SUPERIOR_SOLICITADA" value="{document($doc)/translation/texts/item[@name='recibidas_superior_solicitada']/node()}"/>
    	<input type="hidden" name="SOSTITUIRA_POR_SOLICITADA" value="{document($doc)/translation/texts/item[@name='sostituira_por_solicitada']/node()}"/>
    	<input type="hidden" name="RECIBIDA_INFERIOR_SOLICITADA" value="{document($doc)/translation/texts/item[@name='recibidas_inferior_solicitada']/node()}"/>
    	<input type="hidden" name="ACEPTAR_CANTIDAD_PARCIAL" value="{document($doc)/translation/texts/item[@name='aceptar_cantidad_parcial']/node()}"/>
    	<input type="hidden" name="CANCELAR_MARCAR_RECIBIDO" value="{document($doc)/translation/texts/item[@name='cancelar_marcar_recibido']/node()}"/>
    	<input type="hidden" name="UNIDADES_NO_ENTERO_CAJAS" value="{document($doc)/translation/texts/item[@name='unidad_no_entero_cajas']/node()}"/>
    	<input type="hidden" name="REDONDEADO_COINCIDA" value="{document($doc)/translation/texts/item[@name='redondeado_coincida']/node()}"/>
    	<input type="hidden" name="CAJAS" value="{document($doc)/translation/texts/item[@name='cajas']/node()}"/>
    	<input type="hidden" name="UNIDADES" value="{document($doc)/translation/texts/item[@name='unidad_es']/node()}"/>
    <!--fin mof_13_rw--> 
    </xsl:when>
    <xsl:when test="/Multioferta/MULTIOFERTA/DERECHOS = '25_RW'">    
    <!--mof_25_rw pedido-->
    	<input type="hidden" name="NECESARIO_ALBARAN" value="{document($doc)/translation/texts/item[@name='necesario_albaran']/node()}"/>
    	<input type="hidden" name="SIN_CANTIDADES_PARA_ABONO" value="{document($doc)/translation/texts/item[@name='sin_cantidades_para_abono']/node()}"/>
    	<input type="hidden" name="SIN_CANTIDADES_PARA_ABONO1" value="{document($doc)/translation/texts/item[@name='sin_cantidades_para_abono1']/node()}"/>
    	<input type="hidden" name="ACEPTAR_GUARDAR_DATOS" value="{document($doc)/translation/texts/item[@name='aceptar_guardar_datos']/node()}"/>
    	<input type="hidden" name="CANTIDADES_NO_MODIFICADAS" value="{document($doc)/translation/texts/item[@name='cantidades_no_modificadas']/node()}"/>
    	<input type="hidden" name="CANCELAR_MODIFICAR_CANTIDADES" value="{document($doc)/translation/texts/item[@name='cancelar_modificar_cantidades']/node()}"/>
    	<input type="hidden" name="CORRIJA_CANTIDAD" value="{document($doc)/translation/texts/item[@name='corrija_cantidad']/node()}"/>
    	<input type="hidden" name="CANTIDAD_CORRECTA" value="{document($doc)/translation/texts/item[@name='cantidad_correcta']/node()}"/>
    	<input type="hidden" name="RECIBIDA_SUPERIOR_SOLICITADA" value="{document($doc)/translation/texts/item[@name='recibidas_superior_solicitada']/node()}"/>
    	<input type="hidden" name="SOSTITUIRA_POR_SOLICITADA" value="{document($doc)/translation/texts/item[@name='sostituira_por_solicitada']/node()}"/>
    	<input type="hidden" name="RECIBIDA_INFERIOR_SOLICITADA" value="{document($doc)/translation/texts/item[@name='recibidas_inferior_solicitada']/node()}"/>
    	<input type="hidden" name="UNIDADES" value="{document($doc)/translation/texts/item[@name='unidad_es']/node()}"/>
    	<input type="hidden" name="UNIDADES_NO_ENTERO_CAJAS" value="{document($doc)/translation/texts/item[@name='unidad_no_entero_cajas']/node()}"/>
    	<input type="hidden" name="REDONDEADO_COINCIDA" value="{document($doc)/translation/texts/item[@name='redondeado_coincida']/node()}"/>
    	<input type="hidden" name="CAJAS" value="{document($doc)/translation/texts/item[@name='cajas']/node()}"/>
    	<input type="hidden" name="CANTIDAD_CORRECTA" value="{document($doc)/translation/texts/item[@name='cantidad_correcta']/node()}"/>
    <!--fin mof_25_rw--> 
    </xsl:when>
    <xsl:when test="/Multioferta/MULTIOFERTA/DERECHOS = '14_RW'">    
    	<!--mof_14_rw abono-->
    	<input type="hidden" name="COMUNIQUE_MOTIVO_RECHAZO" value="{document($doc)/translation/texts/item[@name='rogamos_comunique_motivo_rechazo']/node()}"/>
    	<input type="hidden" name="SIN_CANTIDADES_PARA_ABONO" value="{document($doc)/translation/texts/item[@name='sin_cantidades_para_abono']/node()}"/>
    	<input type="hidden" name="SIN_CANTIDADES_PARA_ABONO1" value="{document($doc)/translation/texts/item[@name='sin_cantidades_para_abono1']/node()}"/>
    <!--fin mof_14_rw--> 
    </xsl:when>
    	<xsl:when test="/Multioferta/MULTIOFERTA/DERECHOS = '40_RW'">    
    	<!--mof_40_rw abono y pedido pendiente aprobacion-->
    	<input type="hidden" name="INFORMAR_COME_MOTIVO_RECHAZO" value="{document($doc)/translation/texts/item[@name='informar_comentarios_motivo_rechazo']/node()}"/>
    	<input type="hidden" name="SIN_CANTIDADES_PARA_ABONO1" value="{document($doc)/translation/texts/item[@name='sin_cantidades_para_abono1']/node()}"/>
    <!--fin mof_40_rw--> 
    </xsl:when>
    <xsl:when test="/Multioferta/MULTIOFERTA/DERECHOS = '28_RW'">    
    	<!--mof_28_rw ped progr-->
    	<input type="hidden" name="INTRODUZCA_IMPORTE_VALIDO" value="{document($doc)/translation/texts/item[@name='introduzca_importe_valido']/node()}"/>
    	<input type="hidden" name="NO_PROD_PARA_ENVIAR" value="{document($doc)/translation/texts/item[@name='no_prod_para_enviar']/node()}"/>
    	<input type="hidden" name="IMPORTE_INFERIOR_MINIMO" value="{document($doc)/translation/texts/item[@name='importe_inferior_minimo']/node()}"/>
    	<input type="hidden" name="IMPORTE_INFERIOR_MINIMO_DESPUES" value="{document($doc)/translation/texts/item[@name='importe_inferior_minimo_despues']/node()}"/>
    	<input type="hidden" name="IMPORTE_INFERIOR_MINIMO_DESPUES1" value="{document($doc)/translation/texts/item[@name='importe_inferior_minimo_despues1']/node()}"/>
    	<input type="hidden" name="INTRODUZCA_DESCUENTO_CORRECTO" value="{document($doc)/translation/texts/item[@name='introduzca_descuento_correcto']/node()}"/>
    	<input type="hidden" name="DESCUENTO_MENOR_0" value="{document($doc)/translation/texts/item[@name='descuento_menor_0']/node()}"/>
    	<input type="hidden" name="INTRODUZCA_CANTIDAD_VALIDA" value="{document($doc)/translation/texts/item[@name='introduzca_cantidad_valida']/node()}"/>
    	<input type="hidden" name="SELECCIONE_CASILLAS" value="{document($doc)/translation/texts/item[@name='seleccione_casillas']/node()}"/>
    	<input type="hidden" name="MODIFICAR_TODOS_PEDIDOS" value="{document($doc)/translation/texts/item[@name='modificar_todos_pedidos']/node()}"/>
    	<input type="hidden" name="MODIFICAR_TODOS_MENO_SIGUIENTE" value="{document($doc)/translation/texts/item[@name='modificar_todos_meno_siguiente']/node()}"/>
    	<input type="hidden" name="MODIFICAR_SOLO_SIGUIENTE_PEDIDO" value="{document($doc)/translation/texts/item[@name='modificar_solo_siguiente_pedido']/node()}"/>
    	<input type="hidden" name="INTRODUCIDO_MAS_COMA" value="{document($doc)/translation/texts/item[@name='introducido_mas_coma']/node()}"/>
    	<input type="hidden" name="INTRODUCIDO_VALOR_INCORRECTO" value="{document($doc)/translation/texts/item[@name='introducido_valor_incorrecto']/node()}"/>
    	<input type="hidden" name="ERROR_EN_DATO" value="{document($doc)/translation/texts/item[@name='error_en_dato']/node()}"/>
    	<input type="hidden" name="UNIDADES_NO_ENTERO_CAJAS" value="{document($doc)/translation/texts/item[@name='unidad_no_entero_cajas']/node()}"/>
    	<input type="hidden" name="REDONDEADO_COINCIDA" value="{document($doc)/translation/texts/item[@name='redondeado_coincida']/node()}"/>
    	<input type="hidden" name="CAJAS" value="{document($doc)/translation/texts/item[@name='cajas']/node()}"/>
    	<input type="hidden" name="UNIDADES" value="{document($doc)/translation/texts/item[@name='unidad_es']/node()}"/>
    	<input type="hidden" name="MSG_MODIFICAR_TODOS_PEDIDOS" value="{document($doc)/translation/texts/item[@name='msg_modificar_todos_pedidos']/node()}"/>
    	<input type="hidden" name="MSG_MODIFICAR_TODOS_PEDIDOS1" value="{document($doc)/translation/texts/item[@name='msg_modificar_todos_pedidos1']/node()}"/>
    	<input type="hidden" name="MSG_MODIFICAR_TODOS_PEDIDOS2" value="{document($doc)/translation/texts/item[@name='msg_modificar_todos_pedidos2']/node()}"/>
    	<input type="hidden" name="MSG_MODIFICAR_TODOS_PEDIDOS_EXCEPTO_SIG" value="{document($doc)/translation/texts/item[@name='msg_modificar_todos_pedidos_excepto_sig']/node()}"/>
    	<input type="hidden" name="MSG_MODIFICAR_TODOS_PEDIDOS_EXCEPTO_SIG1" value="{document($doc)/translation/texts/item[@name='msg_modificar_todos_pedidos_excepto_sig1']/node()}"/>
    	<input type="hidden" name="MSG_MODIFICAR_TODOS_PEDIDOS_EXCEPTO_SIG2" value="{document($doc)/translation/texts/item[@name='msg_modificar_todos_pedidos_excepto_sig2']/node()}"/>
    	<input type="hidden" name="MSG_MODIFICAR_SOLO_SIG_PEDIDO" value="{document($doc)/translation/texts/item[@name='msg_modificar_solo_sig_pedido']/node()}"/>
    	<input type="hidden" name="MSG_MODIFICAR_SOLO_SIG_PEDIDO1" value="{document($doc)/translation/texts/item[@name='msg_modificar_solo_sig_pedido1']/node()}"/>
    	<input type="hidden" name="MSG_MODIFICAR_SOLO_SIG_PEDIDO2" value="{document($doc)/translation/texts/item[@name='msg_modificar_solo_sig_pedido2']/node()}"/>
    <!--fin mof_28_rw--> 
    </xsl:when>
    <xsl:when test="/Multioferta/MULTIOFERTA/DERECHOS = '30_RW'">    
    	<!--mof_30_rw acepta ped progr-->
    	<input type="hidden" name="INTRODUZCA_IMPORTE_VALIDO" value="{document($doc)/translation/texts/item[@name='introduzca_importe_valido']/node()}"/>
    	<input type="hidden" name="NO_PROD_PARA_ENVIAR" value="{document($doc)/translation/texts/item[@name='no_prod_para_enviar']/node()}"/>
    	<input type="hidden" name="IMPORTE_INFERIOR_MINIMO" value="{document($doc)/translation/texts/item[@name='importe_inferior_minimo']/node()}"/>
    	<input type="hidden" name="IMPORTE_INFERIOR_MINIMO_DESPUES" value="{document($doc)/translation/texts/item[@name='importe_inferior_minimo_despues']/node()}"/>
    	<input type="hidden" name="IMPORTE_INFERIOR_MINIMO_DESPUES1" value="{document($doc)/translation/texts/item[@name='importe_inferior_minimo_despues1']/node()}"/>
    	<input type="hidden" name="INTRODUZCA_DESCUENTO_CORRECTO" value="{document($doc)/translation/texts/item[@name='introduzca_descuento_correcto']/node()}"/>
    	<input type="hidden" name="DESCUENTO_MENOR_0" value="{document($doc)/translation/texts/item[@name='descuento_menor_0']/node()}"/>
    	<input type="hidden" name="INTRODUZCA_FECHA_ENTREGA_VALIDA" value="{document($doc)/translation/texts/item[@name='introduzca_fecha_entrega_valida']/node()}"/>
    	<input type="hidden" name="FECHA_ENTREGA_MAYOR_ACTUAL" value="{document($doc)/translation/texts/item[@name='fecha_entrega_mayor_actual']/node()}"/>
    	<input type="hidden" name="INTRODUCIDO_MAS_COMA" value="{document($doc)/translation/texts/item[@name='introducido_mas_coma']/node()}"/>
    	<input type="hidden" name="INTRODUCIDO_VALOR_INCORRECTO" value="{document($doc)/translation/texts/item[@name='introducido_valor_incorrecto']/node()}"/>
    	<input type="hidden" name="ERROR_EN_DATO" value="{document($doc)/translation/texts/item[@name='error_en_dato']/node()}"/>
    	<input type="hidden" name="INTRODUZCA_CANTIDAD_VALIDA" value="{document($doc)/translation/texts/item[@name='introduzca_cantidad_valida']/node()}"/>
    	<input type="hidden" name="CANTIDAD_CORRECTA" value="{document($doc)/translation/texts/item[@name='cantidad_correcta']/node()}"/>
    	<input type="hidden" name="UNIDADES_NO_ENTERO_CAJAS" value="{document($doc)/translation/texts/item[@name='unidad_no_entero_cajas']/node()}"/>
    	<input type="hidden" name="REDONDEADO_COINCIDA" value="{document($doc)/translation/texts/item[@name='redondeado_coincida']/node()}"/>
    	<input type="hidden" name="CAJAS" value="{document($doc)/translation/texts/item[@name='cajas']/node()}"/>
    	<input type="hidden" name="UNIDADES" value="{document($doc)/translation/texts/item[@name='unidad_es']/node()}"/>
    <!--fin mof_30_rw--> 
    </xsl:when>
    <xsl:otherwise>
    </xsl:otherwise>
    </xsl:choose>
    </form>      
</xsl:template><!--fin template MULTIOFERTA-->

</xsl:stylesheet>
   


