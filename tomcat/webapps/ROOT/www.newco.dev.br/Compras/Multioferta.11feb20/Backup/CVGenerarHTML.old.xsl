<?xml version="1.0" encoding="iso-8859-1"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:import href = "http://www.newco.dev.br/General/General.xsl"/>
	<xsl:variable name="accion"><xsl:value-of select="//LP_ACCION"/></xsl:variable>
	<!-- definicion del mensaje "Prepara Oferta/Pedido" 5-4-15 mc-->

	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:value-of select="/Generar/LANG"/>
	</xsl:variable>
	<xsl:value-of select="$lang"/>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<xsl:variable name="preparar">
		<xsl:value-of select="document($doc)/translation/texts/item[@name='pendiente_de_confirmacion']/node()"/>
	</xsl:variable>

<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>

<xsl:template match="Generar">
  
<html><head>
	    
	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->

	<link rel="stylesheet" href="http://www.newco.dev.br/General/calendario/spiffyCal_v2_1.css" type="text/css"/>
	<script type="text/javascript" src="http://www.newco.dev.br/General/calendario/spiffyCal_v2_1.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/ajax.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>

	<xsl:text disable-output-escaping="yes"><![CDATA[

	<script type="text/javascript">
	<!--
	
		var centroInicial=']]></xsl:text><xsl:value-of select="/Generar/IDCENTRO"/><xsl:text disable-output-escaping="yes"><![CDATA[';
		var lugarInicial=']]></xsl:text><xsl:value-of select="/Generar/IDLUGARENTREGA"/><xsl:text disable-output-escaping="yes"><![CDATA[';
		var centroConsumoInicial=']]></xsl:text><xsl:value-of select="/Generar/IDCENTROCONSUMO"/><xsl:text disable-output-escaping="yes"><![CDATA[';
		//var almacenInternoInicial=']]></xsl:text><xsl:value-of select="/Generar/IDALMACENINTERNO"/><xsl:text disable-output-escaping="yes"><![CDATA[';
		var historia=0;
		
        ]]></xsl:text>
        
		var msgFechaMinimaIncorrecta='<xsl:value-of select="document($doc)/translation/texts/item[@name='msgFechaMinimaIncorrecta']/node()"/>';
        

		var msgProgramacionPedidosEstrictos='<xsl:value-of select="document($doc)/translation/texts/item[@name='msgProgramacionPedidosEstrictos']/node()"/>';
        
        var msgProgramacionPedidosFexiblesInferior='<xsl:value-of select="document($doc)/translation/texts/item[@name='msgProgramacionPedidosFexiblesInferior']/node()"/>';
        
        var msgProgramacionAbonos='<xsl:value-of select="document($doc)/translation/texts/item[@name='msgProgramacionAbonos']/node()"/>';
        var msgAvisoProgramacion='';


        // mensajes para ofertas        
        
        var msgSinOferta='<xsl:value-of select="document($doc)/translation/texts/item[@name='msgSinOferta']/node()"/>';
        
        var msgSinOfertasRedireccion='<xsl:value-of select="document($doc)/translation/texts/item[@name='msgSinOfertasRedireccion']/node()"/>';

        var msgProveedorSoloPedidos_C1_Semaforo='<xsl:value-of select="document($doc)/translation/texts/item[@name='msgProveedorSoloPedidos_C1_Semaforo']/node()"/>';
        var msgProveedorSoloPedidos_C2_Semaforo='<xsl:value-of select="document($doc)/translation/texts/item[@name='msgProveedorSoloPedidos_C2_Semaforo']/node()"/>';
        
  
        var msgOfertaMinimoEstricto_C1_Semaforo='<xsl:value-of select="document($doc)/translation/texts/item[@name='msgOfertaMinimoEstricto_C2_Semaforo']/node()"/>';
        
        var msgOfertaMinimoEstricto_C2_Semaforo='<xsl:value-of select="document($doc)/translation/texts/item[@name='msgOfertaMinimoEstricto_C1_Semaforo']/node()"/>';
        var msgOfertaMinimoEstricto_C3_Semaforo='<xsl:value-of select="document($doc)/translation/texts/item[@name='msgOfertaMinimoEstricto_C3_Semaforo']/node()"/>';
        var msgOfertaMinimoEstricto_C3_ComprobacionFinal_excluir='<xsl:value-of select="document($doc)/translation/texts/item[@name='msgOfertaMinimoEstricto_C3_ComprobacionFinal_excluir']/node()"/>';
        
        var msgOfertaMinimoEstricto_C4_ComprobacionFinal='<xsl:value-of select="document($doc)/translation/texts/item[@name='msgOfertaMinimoEstricto_C4_ComprobacionFinal']/node()"/>';
        
        var msgOfertaMinimoEstricto_C4_ComprobacionFinal_excluir='<xsl:value-of select="document($doc)/translation/texts/item[@name='msgOfertaMinimoEstricto_C4_ComprobacionFinal_excluir']/node()"/>';
        

        var msgOfertaMinimoFlexible_C1_Semaforo='<xsl:value-of select="document($doc)/translation/texts/item[@name='msgOfertaMinimoFlexible_C1_Semaforo']/node()"/>';
        
        var msgOfertaMinimoFlexible_C2_Semaforo='<xsl:value-of select="document($doc)/translation/texts/item[@name='msgOfertaMinimoFlexible_C2_Semaforo']/node()"/>';
        var msgOfertaMinimoFlexible_C3_Semaforo='<xsl:value-of select="document($doc)/translation/texts/item[@name='msgOfertaMinimoFlexible_C3_Semaforo']/node()"/>';

        var msgOfertaMinimoFlexible_C3_ComprobacionFinal='<xsl:value-of select="document($doc)/translation/texts/item[@name='msgOfertaMinimoFlexible_C3_ComprobacionFinal']/node()"/>';
        
	    var msgOfertaMinimoFlexible_C4_ComprobacionFinal='<xsl:value-of select="document($doc)/translation/texts/item[@name='msgOfertaMinimoFlexible_C4_ComprobacionFinal']/node()"/>';
	
	    var msgCambioEstadoOferta_ENVIAR_Semaforo='<xsl:value-of select="document($doc)/translation/texts/item[@name='msgCambioEstadoOferta_ENVIAR_Semaforo']/node()"/>';
        
        var msgCambioEstadoOferta_NOENVIAR_Semaforo='<xsl:value-of select="document($doc)/translation/texts/item[@name='msgCambioEstadoOferta_NOENVIAR_Semaforo']/node()"/>';
        
        // mensajes para pedidos 
        
       var msgSinPedido='<xsl:value-of select="document($doc)/translation/texts/item[@name='msgSinPedido']/node()"/>';
        var msgSinPedidosRedireccion='<xsl:value-of select="document($doc)/translation/texts/item[@name='msgSinPedidosRedireccion']/node()"/>';
        
        var msgPrograma_C3_Semaforo='<xsl:value-of select="document($doc)/translation/texts/item[@name='msgPrograma_C3_Semaforo']/node()"/>';

        var msgPedidoMinimoEstricto_C1_Semaforo='<xsl:value-of select="document($doc)/translation/texts/item[@name='msgPedidoMinimoEstricto_C1_Semaforo']/node()"/>';
        
        var msgPedidoMinimoEstricto_C2_Semaforo='<xsl:value-of select="document($doc)/translation/texts/item[@name='msgPedidoMinimoEstricto_C2_Semaforo']/node()"/>';
        
        var msgPedidoMinimoEstricto_C3_Semaforo='<xsl:value-of select="document($doc)/translation/texts/item[@name='msgPedidoMinimoEstricto_C3_Semaforo']/node()"/>';
        
        var msgPedidoMinimoEstricto_C3_ComprobacionFinal_excluir='<xsl:value-of select="document($doc)/translation/texts/item[@name='msgPedidoMinimoEstricto_C3_ComprobacionFinal_excluir']/node()"/>';
        
        var msgPedidoMinimoEstricto_C4_ComprobacionFinal='<xsl:value-of select="document($doc)/translation/texts/item[@name='msgPedidoMinimoEstricto_C4_ComprobacionFinal']/node()"/>';
        
        var msgPedidoMinimoEstricto_C4_ComprobacionFinal_excluir='<xsl:value-of select="document($doc)/translation/texts/item[@name='msgPedidoMinimoEstricto_C4_ComprobacionFinal_excluir']/node()"/>';
   		
        var msgPedidoMinimoFlexible_C1_Semaforo='<xsl:value-of select="document($doc)/translation/texts/item[@name='msgPedidoMinimoFlexible_C1_Semaforo']/node()"/>';
        
        var msgPedidoMinimoFlexible_C2_Semaforo='<xsl:value-of select="document($doc)/translation/texts/item[@name='msgPedidoMinimoFlexible_C2_Semaforo']/node()"/>';
        var msgPedidoMinimoFlexible_C3_Semaforo='<xsl:value-of select="document($doc)/translation/texts/item[@name='msgPedidoMinimoFlexible_C3_Semaforo']/node()"/>';
        
        var msgPedidoMinimoFlexible_C3_ComprobacionFinal='<xsl:value-of select="document($doc)/translation/texts/item[@name='msgPedidoMinimoFlexible_C3_ComprobacionFinal']/node()"/>';
        
        var msgPedidoMinimoFlexible_C4_ComprobacionFinal='<xsl:value-of select="document($doc)/translation/texts/item[@name='msgPedidoMinimoFlexible_C4_ComprobacionFinal']/node()"/>';

        var msgCambioEstadoPedido_ENVIAR_Semaforo='<xsl:value-of select="document($doc)/translation/texts/item[@name='msgCambioEstadoPedido_ENVIAR_Semaforo']/node()"/>';
        
        var msgCambioEstadoPedido_NOENVIAR_Semaforo='<xsl:value-of select="document($doc)/translation/texts/item[@name='msgCambioEstadoPedido_NOENVIAR_Semaforo']/node()"/>';
        
        var msgPedidosUrgentasProgramacion='<xsl:value-of select="document($doc)/translation/texts/item[@name='msgPedidosUrgentasProgramacion']/node()"/>';
				
		var msgNumeroPedidoClinicaParaPrograma='<xsl:value-of select="document($doc)/translation/texts/item[@name='msgNumeroPedidoClinicaParaPrograma']/node()"/>';
        
        var suPedidoEs='<xsl:value-of select="document($doc)/translation/texts/item[@name='su_pedido_es_de']/node()"/>';
        var ivaNoIncluida='<xsl:value-of select="document($doc)/translation/texts/item[@name='iva_no_incluida_inferior']/node()"/>';
              
          <xsl:choose>
            <xsl:when test="//LP_ACCION='DIRECTO'">
 
             var msgMinimoFlexible_C1_Semaforo=msgPedidoMinimoFlexible_C1_Semaforo;
              var msgMinimoFlexible_C2_Semaforo=msgPedidoMinimoFlexible_C2_Semaforo;
              var msgMinimoFlexible_C3_Semaforo=msgPedidoMinimoFlexible_C3_Semaforo;
              
              var msgMinimoFlexible_C3_ComprobacionFinal=msgPedidoMinimoFlexible_C3_ComprobacionFinal;
              var msgMinimoFlexible_C4_ComprobacionFinal=msgPedidoMinimoFlexible_C4_ComprobacionFinal;
              
              
              var msgMinimoEstricto_C1_Semaforo=msgPedidoMinimoEstricto_C1_Semaforo;
              var msgMinimoEstricto_C2_Semaforo=msgPedidoMinimoEstricto_C2_Semaforo;
              var msgMinimoEstricto_C3_Semaforo=msgPedidoMinimoEstricto_C3_Semaforo;
              var msgMinimoEstricto_C3_ComprobacionFinal_excluir=msgPedidoMinimoEstricto_C3_ComprobacionFinal_excluir;

              var msgMinimoEstricto_C4_ComprobacionFinal=msgPedidoMinimoEstricto_C4_ComprobacionFinal;
              var msgMinimoEstricto_C4_ComprobacionFinal_excluir=msgPedidoMinimoEstricto_C4_ComprobacionFinal_excluir;


              var msgCambioEstadoElemento_ENVIAR_Semaforo=msgCambioEstadoPedido_ENVIAR_Semaforo;
              var msgCambioEstadoElemento_NOENVIAR_Semaforo=msgCambioEstadoPedido_NOENVIAR_Semaforo;
              
              var msgSinElemento=msgSinPedido;
              var msgSinElementosRedireccion=msgSinPedidosRedireccion;
              
             

            </xsl:when>
            <xsl:otherwise>
              
              var msgMinimoFlexible_C1_Semaforo=msgOfertaMinimoFlexible_C1_Semaforo;
              var msgMinimoFlexible_C2_Semaforo=msgOfertaMinimoFlexible_C2_Semaforo;
              var msgMinimoFlexible_C3_Semaforo=msgOfertaMinimoFlexible_C3_Semaforo;
              
              var msgMinimoFlexible_C3_ComprobacionFinal=msgOfertaMinimoFlexible_C3_ComprobacionFinal;
              var msgMinimoFlexible_C4_ComprobacionFinal=msgOfertaMinimoFlexible_C4_ComprobacionFinal;
              
              var msgMinimoEstricto_C1_Semaforo=msgOfertaMinimoEstricto_C1_Semaforo;
              var msgMinimoEstricto_C2_Semaforo=msgOfertaMinimoEstricto_C2_Semaforo;
              var msgMinimoEstricto_C3_Semaforo=msgOfertaMinimoEstricto_C3_Semaforo;
              var msgMinimoEstricto_C3_ComprobacionFinal_excluir=msgOfertaMinimoEstricto_C3_ComprobacionFinal_excluir;
              
              var msgMinimoEstricto_C4_ComprobacionFinal=msgOfertaMinimoEstricto_C4_ComprobacionFinal;
              var msgMinimoEstricto_C4_ComprobacionFinal_excluir=msgOfertaMinimoEstricto_C4_ComprobacionFinal_excluir;
        
              
              var msgCambioEstadoElemento_ENVIAR_Semaforo=msgCambioEstadoOferta_ENVIAR_Semaforo;
              var msgCambioEstadoElemento_NOENVIAR_Semaforo=msgCambioEstadoOferta_NOENVIAR_Semaforo;
              
              var msgSinElemento=msgSinOferta;
              var msgSinElementosRedireccion=msgSinOfertasRedireccion;
              
            </xsl:otherwise> 
          </xsl:choose>
        <xsl:text disable-output-escaping="yes"><![CDATA[

 ]]> </xsl:text>
    <xsl:choose>
    <xsl:when test="//MULTIOFERTAS/NUMERO_MULTIOFERTAS>1 and //LP_ACCION='DIRECTO'">
    
      msgAvisoProgramacion+='<xsl:value-of select="document($doc)/translation/texts/item[@name='msgAvisoProgramacion1']/node()"/> <xsl:value-of select="//MULTIOFERTAS/NUMERO_MULTIOFERTAS"/> <xsl:value-of select="document($doc)/translation/texts/item[@name='msgAvisoProgramacion2']/node()"/>';
         
      //msgAvisoProgramacion+='\nSolo se programará éste pedido de los <xsl:value-of select="//MULTIOFERTAS/NUMERO_MULTIOFERTAS"/> que está preparando.\nPara programar o enviar los restantes deberá iniciar el proceso de nuevo en \"Ofertas y Pedidos\".\n\n¿Continuar con la programación de este pedido?';
    </xsl:when>
    <xsl:otherwise>
      
      msgAvisoProgramacion+='<xsl:value-of select="document($doc)/translation/texts/item[@name='msgAvisoProgramacion']/node()"/>';
    </xsl:otherwise> 
    </xsl:choose>
  <xsl:text disable-output-escaping="yes"><![CDATA[
    
       
       var fechaEntregaMinima;
	
	var arrayCentros=new Array();
       var arrayLugaresEntrega=new Array();
       var arrayCentrosConsumo=new Array();
       //var arrayAlmacenesInternos=new Array();
		
		]]></xsl:text>
		  <xsl:for-each select="/Generar/MULTIOFERTAS/TODOSLUGARESENTREGA[1]/CENTRO">
          
		    arrayCentros[arrayCentros.length]=new Array(<xsl:value-of select="@ID"/>,
															'<xsl:value-of select="@nombre"/>',
															'<xsl:value-of select="PEDIDO_MINIMO/IMPORTE"/>',
                                                            '<xsl:value-of select="COSTE_TRANSPORTE/IMPORTE"/>');
            
		    <xsl:for-each select="LUGARESENTREGA/LUGARENTREGA">
		      arrayLugaresEntrega[arrayLugaresEntrega.length]=new Array(<xsl:value-of select="ID"/>,
		                                                                <xsl:value-of select="IDCENTRO"/>,
		                                                                '<xsl:value-of select="REFERENCIA"/>',
		                                                                '<xsl:value-of select="NOMBRE"/>',
		                                                                '<xsl:value-of select="DIRECCION"/>',
		                                                                '<xsl:value-of select="CPOSTAL"/>',
		                                                                '<xsl:value-of select="POBLACION"/>',
		                                                                '<xsl:value-of select="PROVINCIA"/>',
		                                                                '<xsl:value-of select="PORDEFECTO"/>');
		    </xsl:for-each>
		  </xsl:for-each>
		

		  <xsl:for-each select="/Generar/MULTIOFERTAS/TODOSCENTROSCONSUMO[1]/CENTRO">
		    <xsl:for-each select="CENTROSCONSUMO/CENTROCONSUMO">
		      arrayCentrosConsumo[arrayCentrosConsumo.length]=new Array(<xsl:value-of select="ID"/>,
		                                                                <xsl:value-of select="IDCENTRO"/>,
		                                                                '<xsl:value-of select="REFERENCIA"/>',
		                                                                '<xsl:value-of select="NOMBRE_CORTO"/>',
		                                                                '<xsl:value-of select="PORDEFECTO"/>');
		    </xsl:for-each>
		  </xsl:for-each>
		  <!--
		  <xsl:for-each select="/Generar/MULTIOFERTAS/TODOSALMACENESINTERNOS[1]/CENTRO">
		    <xsl:for-each select="ALMACENESINTERNOS/ALMACENINTERNO">
		      arrayAlmacenesInternos[arrayAlmacenesInternos.length]=new Array(<xsl:value-of select="ID"/>,
		                                                                <xsl:value-of select="IDCENTRO"/>,
		                                                                '<xsl:value-of select="REFERENCIA"/>',
		                                                                '<xsl:value-of select="NOMBRE"/>',
		                                                                '<xsl:value-of select="PORDEFECTO"/>');
		    </xsl:for-each>
		  </xsl:for-each>
		  -->
		
		<xsl:text disable-output-escaping="yes"><![CDATA[

	
	function ActualizarTextoLugarEntrega(idlugarEntrega){
	  
	  var form=document.forms['Principal'];
	  
	  for(var n=0;n<arrayLugaresEntrega.length;n++){
	    if(arrayLugaresEntrega[n][0]==idlugarEntrega){
	      form.elements['CEN_DIRECCION'].value=arrayLugaresEntrega[n][4];
	      form.elements['CEN_CPOSTAL'].value=arrayLugaresEntrega[n][5];
	      form.elements['CEN_POBLACION'].value=arrayLugaresEntrega[n][6];
	      form.elements['CEN_PROVINCIA'].value=arrayLugaresEntrega[n][7];
	    }
	  }
	}
	
	
	function inicializarDesplegableLugaresEntrega(centroSeleccionado, lugarSeleccionado){
        
          document.forms['Principal'].elements['IDLUGARENTREGA'].length=0;
          
          for(var n=0;n<arrayLugaresEntrega.length;n++){
            if(arrayLugaresEntrega[n][1]==centroSeleccionado){
              if(centroSeleccionado==centroInicial){
                if(arrayLugaresEntrega[n][0]==lugarSeleccionado){
                  document.forms['Principal'].elements['IDLUGARENTREGA'].options[document.forms['Principal'].elements['IDLUGARENTREGA'].length]=new Option('['+arrayLugaresEntrega[n][3]+']',arrayLugaresEntrega[n][0]);//	ET	7mar08		+' ('+arrayLugaresEntrega[n][2]
                  document.forms['Principal'].elements['IDLUGARENTREGA'].options[document.forms['Principal'].elements['IDLUGARENTREGA'].length-1].selected=true;
                  ActualizarTextoLugarEntrega(arrayLugaresEntrega[n][0]);
                }
                else{
                  document.forms['Principal'].elements['IDLUGARENTREGA'].options[document.forms['Principal'].elements['IDLUGARENTREGA'].length]=new Option(arrayLugaresEntrega[n][3],arrayLugaresEntrega[n][0]);
                }
              }
              else{
                if(arrayLugaresEntrega[n][8]=='S'){
                  document.forms['Principal'].elements['IDLUGARENTREGA'].options[document.forms['Principal'].elements['IDLUGARENTREGA'].length]=new Option('['+arrayLugaresEntrega[n][3]+']',arrayLugaresEntrega[n][0]);
                  document.forms['Principal'].elements['IDLUGARENTREGA'].options[document.forms['Principal'].elements['IDLUGARENTREGA'].length-1].selected=true;
                  ActualizarTextoLugarEntrega(arrayLugaresEntrega[n][0]);
                }
                else{
                  document.forms['Principal'].elements['IDLUGARENTREGA'].options[document.forms['Principal'].elements['IDLUGARENTREGA'].length]=new Option(arrayLugaresEntrega[n][3],arrayLugaresEntrega[n][0]);
                }
              }
            }
          } 
        }
        
        
        function inicializarDesplegableCentrosConsumo(centroSeleccionado, centroConsumoSeleccionado){
        
          document.forms['Principal'].elements['IDCENTROCONSUMO'].length=0;

          for(var n=0;n<arrayCentrosConsumo.length;n++){
            if(arrayCentrosConsumo[n][1]==centroSeleccionado){
              if(centroSeleccionado==centroInicial){
                if(arrayCentrosConsumo[n][0]==centroConsumoSeleccionado){
                  document.forms['Principal'].elements['IDCENTROCONSUMO'].options[document.forms['Principal'].elements['IDCENTROCONSUMO'].length]=new Option('['+arrayCentrosConsumo[n][3]+']',arrayCentrosConsumo[n][0]);
                  document.forms['Principal'].elements['IDCENTROCONSUMO'].options[document.forms['Principal'].elements['IDCENTROCONSUMO'].length-1].selected=true;
                }
                else{
                  document.forms['Principal'].elements['IDCENTROCONSUMO'].options[document.forms['Principal'].elements['IDCENTROCONSUMO'].length]=new Option(arrayCentrosConsumo[n][3],arrayCentrosConsumo[n][0]);
                }
              }
              else{
                if(arrayCentrosConsumo[n][4]=='S'){
                  document.forms['Principal'].elements['IDCENTROCONSUMO'].options[document.forms['Principal'].elements['IDCENTROCONSUMO'].length]=new Option('['+arrayCentrosConsumo[n][3]+']',arrayCentrosConsumo[n][0]);
                  document.forms['Principal'].elements['IDCENTROCONSUMO'].options[document.forms['Principal'].elements['IDCENTROCONSUMO'].length-1].selected=true;
                }
                else{
                  document.forms['Principal'].elements['IDCENTROCONSUMO'].options[document.forms['Principal'].elements['IDCENTROCONSUMO'].length]=new Option(arrayCentrosConsumo[n][3],arrayCentrosConsumo[n][0]);
                }
              }
            }
          } 
        }
        
        /*
        function inicializarDesplegableAlmacenesInternos(centroSeleccionado, almaceninternoSeleccionado){
        
          document.forms['Principal'].elements['IDALMACENINTERNO'].length=0;

          for(var n=0;n<arrayAlmacenesInternos.length;n++){
            if(arrayAlmacenesInternos[n][1]==centroSeleccionado){
              if(centroSeleccionado==centroInicial){
                if(arrayAlmacenesInternos[n][0]==almaceninternoSeleccionado){
                  document.forms['Principal'].elements['IDALMACENINTERNO'].options[document.forms['Principal'].elements['IDALMACENINTERNO'].length]=new Option('['+arrayAlmacenesInternos[n][3]+' ('+arrayAlmacenesInternos[n][2]+')]',arrayAlmacenesInternos[n][0]);
                  document.forms['Principal'].elements['IDALMACENINTERNO'].options[document.forms['Principal'].elements['IDALMACENINTERNO'].length-1].selected=true;
                }
                else{
                  document.forms['Principal'].elements['IDALMACENINTERNO'].options[document.forms['Principal'].elements['IDALMACENINTERNO'].length]=new Option(arrayAlmacenesInternos[n][3]+' ('+arrayAlmacenesInternos[n][2]+')',arrayAlmacenesInternos[n][0]);
                }
              }
              else{
                if(arrayAlmacenesInternos[n][4]=='S'){
                  document.forms['Principal'].elements['IDALMACENINTERNO'].options[document.forms['Principal'].elements['IDALMACENINTERNO'].length]=new Option('['+arrayAlmacenesInternos[n][3]+' ('+arrayAlmacenesInternos[n][2]+')]',arrayAlmacenesInternos[n][0]);
                  document.forms['Principal'].elements['IDALMACENINTERNO'].options[document.forms['Principal'].elements['IDALMACENINTERNO'].length-1].selected=true;
                }
                else{
                  document.forms['Principal'].elements['IDALMACENINTERNO'].options[document.forms['Principal'].elements['IDALMACENINTERNO'].length]=new Option(arrayAlmacenesInternos[n][3]+' ('+arrayAlmacenesInternos[n][2]+')',arrayAlmacenesInternos[n][0]);
                }
              }
            }
          } 
        }
        	*/
        
        
        
        function inicializarDesplegableCentros(centroSeleccionado, idLugarSeleccionado, idCentroConsumoSeleccionado){
          
          document.forms['Principal'].elements['IDCENTRO'].length=0;
          
          for(var n=0;n<arrayCentros.length;n++){
          
            if(arrayCentros[n][0]==centroSeleccionado){
            
              document.forms['Principal'].elements['IDCENTRO'].options[document.forms['Principal'].elements['IDCENTRO'].length]=new Option('['+arrayCentros[n][1]+']',arrayCentros[n][0]);
              
              document.forms['Principal'].elements['IDCENTRO'].options[document.forms['Principal'].elements['IDCENTRO'].length-1].selected=true;
              
              //coste de transporte
              var moidpedido = document.forms['Principal'].elements['MOID'].value;
              
              document.forms['Principal'].elements['COSTE_LOGISTICA'].value =anyadirCerosDecimales(formateaDivisa(Round(desformateaDivisa(arrayCentros[n][3]),2)),2);  
                    
              inicializarImportes();
              
              if(arguments.length>1){
                inicializarDesplegableLugaresEntrega(centroSeleccionado,idLugarSeleccionado);
                inicializarDesplegableCentrosConsumo(centroSeleccionado,idCentroConsumoSeleccionado);
                //inicializarDesplegableAlmacenesInternos(centroSeleccionado,idAlmacenInternoSeleccionado);
 
              }
              else{
                if(centroSeleccionado==centroInicial){
                  inicializarDesplegableLugaresEntrega(centroSeleccionado,lugarInicial);
                  inicializarDesplegableCentrosConsumo(centroSeleccionado,centroConsumoInicial); 
                  //inicializarDesplegableAlmacenesInternos(centroSeleccionado,almacenInternoInicial);
                }
                else{
                  inicializarDesplegableLugaresEntrega(centroSeleccionado);
                  inicializarDesplegableCentrosConsumo(centroSeleccionado); 
                  //inicializarDesplegableAlmacenesInternos(centroSeleccionado);
                }
              }
            }
            else{
              document.forms['Principal'].elements['IDCENTRO'].options[document.forms['Principal'].elements['IDCENTRO'].length]=new Option(arrayCentros[n][1],arrayCentros[n][0]);
            }
          } 
        }
	
	
	
	
	function CambioDivisa( frm ) {
	   alert("Se ha solicitado un cambio de divisa");
     	}
       	 
        //funciones para cambiar el puntero del mouse al ponerse encima de un objeto (como en los links)
        function itemOver(obj,color)
        {
          obj.style.color=color;
	  obj.style.cursor="hand";
        }
        
        function itemOut(obj,color)
        {
          obj.style.color=color;
        }
    	 	
    	 	// util para comprobar que FORMA DE PAGO no esta vacio (o cualquier otro campo)
         function esVacio(obj) {
           if (obj.value=="") {
             alert("Rogamos introduzca una forma de pago válida");
             return false;
           }
           else{
             return true;
           }
         }
         
    	 	
    	 	
     //
     // Construye una String para el campo oculto COMENTARIOS_PROVEEDORES
     // que tiene el formato siguiente |225#blabla#S#N$|213#bloblo#S#S$ 
     //

     // nacho 28.1.2005, incorporamos el check de urgencia

     function GuardarComentarios(formPrincipal,linka,formPedido,tipo){
	// Esconder boton de continuar para evitar doble-click
        if (tipo == 'PEDIDO'){ jQuery('#divEnviarPedido').hide(); }
        if (tipo == 'PRESUPUESTO'){ jQuery('#botonEnviarPresupuesto').hide(); }            
        
	var coments='';
	var mo_id;

	// Construimos el string de comentarios.
	for(i=0;i<formPrincipal.length;i++){
		nom=formPrincipal.elements[i].name;

		if (nom.indexOf("COMENTARIO_") != -1){
			mo_id=nom.substring(nom.indexOf("_")+1,nom.length);

			coments+="|" + mo_id + "#" + formPrincipal.elements['COMENTARIO_'+mo_id].value + "#"+formPrincipal.elements['NUMERO_OFERT_PED_'+mo_id].value + "#";

   		       if(formPrincipal.elements['SolicitaComercial'+mo_id].checked){ 
   		         coments+="S#";
   		       }
   		       else{ 
   		         coments+="N#";
   		       }
                    
  		       if(formPrincipal.elements['SolicitaMuestra'+mo_id].checked){
  		         coments+="S#";
  		       }
   		       else{ 
   		         coments+="N#";
   		       }
   		       
   		       if(formPrincipal.elements['NoComercial'+mo_id].checked){ 
   		         coments+="S#";
   		       }
   		       else{ 
   		         coments+="N#";
   		       }
   		       // las urgencias
   		       if(formPrincipal.elements['URGENTE_'+mo_id].checked){ 
   		         coments+="S$";
   		       }
   		       else{ 
   		         coments+="N$";
   		       }
  		     }	  	
  		   }
         
        	   formPrincipal.elements['COMENTARIOS_PROVEEDORES'].value=coments;
                   
               if (tipo == 'PEDIDO'){ 
                    if(ComprobarPedidoMinimo(formPrincipal,formPedido)==true){ 
               		AsignarAccion(formPrincipal,linka);
                	SubmitForm(formPrincipal,document); 
                    }
                 }
                    
               if (tipo == 'PRESUPUESTO'){ 
                        alert('pres');
                        AsignarAccion(formPrincipal,linka);
                	SubmitForm(formPrincipal,document); 
                 }    
               
               
           }//fin de ComprobarPedidoMinimo
               
        	  
             
        	 function solicitarAccion(mo_id){
        	 
        	   var programable;
        	   
        	   var estado=document.forms['PedidoMinimo'].elements['Status_'+mo_id].value;
        	   var nombre=document.forms['PedidoMinimo'].elements['Nombre_'+mo_id].value;
        	   var minimo=document.forms['PedidoMinimo'].elements['Minimo_'+mo_id].value;
        	   
        	   situarEnPagina('#multioferta_'+mo_id);
        	   
        	   // podemos cambiar el estado
        	   if(estado=='C'){
               
	        	     /*quitado mc 28-11-2012 por tema pedido minimo no estricto
                     		if(confirm(msgMinimoFlexible_C1_Semaforo+nombre+msgMinimoFlexible_C2_Semaforo+minimo+msgMinimoFlexible_C3_ComprobacionFinal+msgMinimoFlexible_C4_ComprobacionFinal)){
        	       estado='SC';
        	       programable='C';
        	     }
        	     else{
        	       estado='NC';
        	       programable='N';
        	     }*/
                 
        	     estado='SC';
        	     programable='C';
                   
        	     actualizarImagen(mo_id,estado);
        	     actualizarEstado(mo_id,estado);
        	     actualizarProgramable(mo_id,programable);
        	     
        	     return estado;
        	   }
        	   // no podemos cambiar el estado, pero podemos abortar el proceso
        	   else{
        	     if(estado=='N'||estado=='NI'||estado=='NO'){
        	       if(confirm(msgMinimoEstricto_C1_Semaforo+nombre+msgMinimoEstricto_C2_Semaforo+minimo+msgMinimoEstricto_C3_ComprobacionFinal_excluir+msgMinimoEstricto_C4_ComprobacionFinal_excluir)){
        	         return 'S'
        	       }
        	       else{
        	         return 'N';
        	       }
        	     }
        	   }    	   
        	 }
        	 
        	 function actualizarEstado(mo_id,estado){
        	   document.forms['PedidoMinimo'].elements['Status_'+mo_id].value=estado;
        	 }
        	 
        	 function actualizarProgramable(mo_id,estado){
        	   document.forms['PedidoMinimo'].elements['PED_PROGRAMABLE_'+mo_id].value=estado;
        	 }
        	 
        	    
		 /************************************************************************************************
		 *	ComprobarPedidoMinimo									
		 *												 
		 *	Comprobamos los pedidos con los semaforos para evaluar los pedidos que realmente vamos   
		 *	a mandar y los pedidos que no vamos a mandar.	
		 * 	Guardamos el string en ENVIAR_OFERTAS.
		 *	
		 ************************************************************************************************/
      
function ComprobarPedidoMinimo(formu,formPedido)
{

	var StringEnviar="";
	var action=formPedido.elements['Action'].value;

	var numPedidos=0;
	var numPedidosRechazados=0;

             	 
             	  
 	 // miramos el total de pedidos
	for (i=0;i<formPedido.length;i++) 
	{
		if(formPedido.elements[i].name.substring(0,5) == 'Total')
		{   	  
			numPedidos++;
		}
	}


	// recorremos todos los pedidos 
	for (i=0;i<formPedido.length;i++) 
	{
		if(formPedido.elements[i].name.substring(0,5) == 'Total')
		{   	  

			var mo_id=formPedido.elements[i].name.substring(6);	    
			var status=formPedido.elements['Status_'+mo_id].value;
			var divisa=formPedido.elements['Divisa_'+mo_id].value;
			var nombre=formPedido.elements['Nombre_'+mo_id].value;
			var minimo=formPedido.elements['Minimo_'+mo_id].value;
			
            //alert('ped minimo '+minimo);
            //alert('STATUSo '+status);
            //alert('total '+formPedido.elements['Total_'+mo_id].value);
             
            
             
			StringEnviar+="("+mo_id+",";
			
            
			if(status=="C")
			{
				var status=solicitarAccion(mo_id);
				if(status=='NC')
				{
					  return false;
				}
			}
			else
			{
				if(numPedidos>1)
				{
				  if(status=='N'|| status=='NI')
				  {
    				if(solicitarAccion(mo_id)=='N')
					{
    				  return false;
    				}
				  }
				}
			} 

			StringEnviar+=status.substring(0,1)+'),';
            
            //para crear el estado a S o a N (= no se envia) coje el primer valor de status, si es NT =>N entonces no envia
            //alert('str env3333 '+StringEnviar + 'st substr '+status.substring(0,1));

			if(status=='N'||status=='NO'||status=='NC'||status=='NI')
			{
				numPedidosRechazados++;
			}
		}

	}
        	  
      // en el caso de que todos los pedidos esten rechazados volvemos
      // volvemos a la pagina anterior para que modifique las cantidades

      if(numPedidos>1){
        if(numPedidos==numPedidosRechazados){
          alert(msgSinElementosRedireccion);
          return false;
        }
      }
      else{
        if(status=='NC'){
          if(confirm(msgMinimoFlexible_C1_Semaforo+nombre+msgMinimoFlexible_C2_Semaforo+minimo+msgMinimoFlexible_C3_Semaforo+msgMinimoFlexible_C4_ComprobacionFinal)){
        	return true; 
          }
          else{
        	return false;
          }
        }
        else{
          if(status=='N'||status=='NI'){
          	//alert(mo_id);
          	// alert('precio_sin iva '+formu.elements['MO_IMPORTETOTAL_'+mo_id].value);
            var totalPedidoSinIva = formu.elements['MO_IMPORTETOTAL_'+mo_id].value;
            
        	//alert('El proveedor '+nombre+' ha fijado un importe mínimo estricto de '+minimo+' €\n\nSu pedido es de '+totalPedidoSinIva+' € IVA no incluido (inferior a dicho importe).\n\nEl pedido no será enviado');
            
        	alert(msgMinimoEstricto_C1_Semaforo+nombre+msgMinimoEstricto_C2_Semaforo+minimo+suPedidoEs+totalPedidoSinIva+ivaNoIncluida);
        	return false;
          }
          else{
        	if(status=='NT'){
        	    //minimo=reemplazaPuntoPorComa(Round(reemplazaComaPorPunto(minimo)-reemplazaComaPorPunto(minimo)*(TOLERANCIA_IMPORTE_MINIMO/100),2));
                //alert('minimo222 status '+minimo+ status);
        	    //quitado 30/07/2013 problemas asisa
                //alert(msgMinimoEstricto_C1_Semaforo+nombre+msgMinimoEstricto_C2_Semaforo+minimo+msgMinimoEstricto_C3_Semaforo+msgMinimoEstricto_C4_ComprobacionFinal);
        	    //return false;
        	}
          }
        }
      }
    
      StringEnviar=StringEnviar.substring(0,StringEnviar.length-1);
      
      
      
      //si estado NT significa que es pedido asisa bajo el pedido minimo, permitido en algunos casos, añaden productos en comentarios
      //lo pongo aquí porqué si no para pedidos multiprov falla, string enviar se crea con mo_id y primera letra del estado, si es NT = N y no envia
      
      if(status=='NT'){ StringEnviar = '('+mo_id+',S)'; }
      
      // enviamos si hay por lo menos una oferta o pedido a enviar
      if (StringEnviar.indexOf("S")==-1){
        alert(msgSinElemento);
        return false;
      } 
      else{
      	
        formu.elements['ENVIAR_OFERTAS'].value=StringEnviar;
        return true;
      }
}
		
		 /************************************************************************************************
		 *	CrearStatus										 *
		 *												 *
		 ************************************************************************************************/
		 
			function CrearStatus() { 
       	
       	var formPedido = document.forms['PedidoMinimo'];
       	var action = formPedido.elements['Action'].value;
        var StatusConcatenados = '';
        var programable='';
        	 
       	]]></xsl:text>
        	     
        if('<xsl:value-of select="//LP_ACCION"/>'=='DIRECTO'){
        	   
        <xsl:text disable-output-escaping="yes">  <![CDATA[	 
        	     
       		for(var i=0;i<formPedido.length;i++){
        		if (formPedido.elements[i].name.substring(0,5) == 'Total'){
		        	var status;     	  
        	    var mo_id=formPedido.elements[i].name.substring(6);
  	    
        	    var mini  = Number(reemplazaComaPorPunto(formPedido.elements['Minimo_'+mo_id].value));
        	    var total = Number(reemplazaComaPorPunto(formPedido.elements['Total_'+mo_id].value));
        	    var estricto=formPedido.elements['Estricto_'+mo_id].value;
        	         
        	    var nombre=document.forms['PedidoMinimo'].elements['Nombre_'+mo_id].value;

							// para abonos, no tenemos en cuanta el minimo
        	    if(total<0){

        	    	estricto='N';
        	    }

							
							//estricto
							//	N -> NO (activo) 
							//	S -> SI (activo, NO estricto)
							//	E -> SI (estricto)
							
							
        	    if(estricto=='N'){
        	    	status='S';
        	    	if(total<0){
        	      	programable='A';
        	      }
        	      else{
        	      	programable='S';
        	      }
        	    }
        	    else{
        	    	if(total<mini){
        	      	if(estricto=='S'){
        	      		
        	      		
        	   
        	      		
        	      		// controlamos el indice de tolerancia
        	      		if(100-((total/mini)*100)>TOLERANCIA_IMPORTE_MINIMO){
        	      			status='NT';
        	          	programable='N';
        	      		}
        	      		else{
        	        		status='C';
        	          	programable='C';
        	          }

        	        }
        	        else{
        	        	status='N';
        	          programable='N';
        	        }
        	      }
        	      else{
        	      	status='S';
        	        programable='S';
        	      }
        	    }
        	       
		         	actualizarProgramable(mo_id,programable);
		         	actualizarEstado(mo_id,status);
		       
        	    StatusConcatenados += status;		
        	  } 
          }
                
                
          CambiarImagenStatus();
           
                     
          // comprueba si no se podra enviar ninguna oferta:
          if(StatusConcatenados.indexOf('S')==-1 && StatusConcatenados.indexOf('C')==-1){
	  
		     		if(action=='EDICION'){
		       		situarEnPagina('#multioferta_'+mo_id);
		       		alert(msgProveedorSoloPedidos_C1_Semaforo+nombre+msgProveedorSoloPedidos_C2_Semaforo);
		     		}
		     		
		     		//else{ 
		       		//if(action=='DIRECTO'){
              	//  alert(msgSinElementosRedireccion);
               	//  parent.history.go(-2-historia);
              //}
            //}
          }
        }
        else{
        	aceptarTodosProductos(document.forms['PedidoMinimo']);
        }
        situarEnPagina('#inicio');
        
	    }
	    
	    
	    
        	 
        	 
               function CambiarImagenStatus() {
        	  
                 var formPedido = document.forms['PedidoMinimo'];
                 
        	 for(var j=0;j<document.images.length;j++){
        	   if (document.images[j].name.substring(0,6) == 'Imagen') {  	  
        	     
        	     var mo_id=document.images[j].name.substring(7);
        	     var status=formPedido.elements['Status_'+mo_id].value;
        	    
        	     actualizarImagen(mo_id,status);
        	     
        	   }
        	 }
              }
              
              function actualizarImagen(idMultioferta, estado){
               
                var imgOK=' ]]></xsl:text>http://www.newco.dev.br/images/Botones/AceptarMO.gif<xsl:text disable-output-escaping="yes"><![CDATA[';
                var imgKO=']]></xsl:text>http://www.newco.dev.br/images/Botones/CancelarMO.gif<xsl:text disable-output-escaping="yes"><![CDATA[';
                var imgConsultar=']]></xsl:text>http://www.newco.dev.br/images/Botones/ConsultarMO.gif<xsl:text disable-output-escaping="yes"><![CDATA[';
                
               
                if(estado=='S'||estado=='SC'){
                  //document.images['Imagen_'+idMultioferta].src=imgOK;
                }
                else{
                  if(estado=='N' || estado=='NI'|| estado=='NC'||estado=='NO' ||estado=='NT'){
                    document.images['Imagen_'+idMultioferta].src=imgKO;
                  }
                  else{
                    document.images['Imagen_'+idMultioferta].src=imgConsultar;
                  }
                } 
              }
              
              function situarEnPagina(ancla){
                document.location.hash=ancla;
                historia++;
              }
              
        	 
              function MostrarTexto(obj,formPedido){
              			
	        var action=formPedido.elements['Action'].value;
        	var mo_id=obj.name.substring(7);
        	
        	var nombre=document.forms['PedidoMinimo'].elements['Nombre_'+mo_id].value;
        	var minimo=document.forms['PedidoMinimo'].elements['Minimo_'+mo_id].value;
        	var status=formPedido.elements['Status_'+mo_id].value;
        	
        	//si esta por debajo del indice de tolerancia modificamos el minimo (flexible) al -20%
        	//y lo marcamos como  estricto
        	if(status=='NT'){
        		minimo=reemplazaPuntoPorComa(Round(reemplazaComaPorPunto(minimo)-reemplazaComaPorPunto(minimo)*(TOLERANCIA_IMPORTE_MINIMO/100),2));
        	}
        	
        	
        	
        	//situarEnPagina('#multioferta_'+mo_id);


        	if(status=='NI'){
        	  alert(msgProveedorSoloPedidos_C1_Semaforo+nombre+msgProveedorSoloPedidos_C2_Semaforo);
        	}
        	else{ 
        	  if(status=='N' || status=='NT'){
        	    alert(msgMinimoEstricto_C1_Semaforo+nombre+msgMinimoEstricto_C2_Semaforo+minimo+msgMinimoEstricto_C3_Semaforo);
        	  }
        	  else{ 
        	    if(status=='S'||status=='NO'){
        	      
        	      //if(confirm(msgMinimoFlexible_C1_Semaforo+nombre+msgMinimoFlexible_C2_Semaforo+minimo+msgMinimoFlexible_C3_Semaforo)){
        	      if(confirm(msgCambioEstadoElemento_ENVIAR_Semaforo)){
	                actualizarImagen(mo_id,'S');
	                actualizarEstado(mo_id,'S');
	              } 
	              else{
        	        actualizarImagen(mo_id,'NO');
        	        actualizarEstado(mo_id,'NO');
        	        alert(msgCambioEstadoElemento_NOENVIAR_Semaforo);
        	      }
        	    }
        	    else{
        	      if(status=='C'){
        	        confirmacion=confirm(msgMinimoFlexible_C1_Semaforo+nombre+msgMinimoFlexible_C2_Semaforo+minimo+msgMinimoFlexible_C3_Semaforo);
        	      }
        	     		     
        	      if(status=='SC' || status=='NC'){
        	        confirmacion=confirm(msgMinimoFlexible_C1_Semaforo+nombre+msgMinimoFlexible_C2_Semaforo+minimo+msgMinimoFlexible_C3_Semaforo);
        	        //confirmacion=confirm(msgCambioEstadoElemento_ENVIAR_Semaforo);
        	      }
        	     				
	              if(confirmacion==true){
	                actualizarImagen(mo_id,'SC');
        	        actualizarEstado(mo_id,'SC');
	              } 
	              else{
        	        actualizarImagen(mo_id,'NC');
        	        actualizarEstado(mo_id,'NC');
        	        alert(msgCambioEstadoElemento_NOENVIAR_Semaforo);
        	      }
        	    }
        	  }
        	}
              }
        	
        	
        	
        	function aceptarTodosProductos(formPedido) {
		          	 
        	  for(var n=0;n<formPedido.length;n++){
        	      if(formPedido.elements[n].name.match('Status_'))
        	        formPedido.elements[n].value='S';
        	  }
        	}
        	
	 
        	 	
        	 function abrirVentana(pag) {
          		window.open(pag,toolbar='no',menubar='no',status='no',scrollbars='yes',resizable='yes');
          	 }

		 function VentanaContrato() {
		   var pag = "http://www.newco.dev.br/Medicos/ContratoWeb.html";
                   window.open(pag, "Contrato", "scrollbars,resizable=yes");
		 
		 }
		 
		 function ComercialOno(formu,obj,mo_id)
		 {
		 if (obj.name.substring(0,11) == 'NoComercial' && obj.checked)

		   {
		   formu.elements['SolicitaComercial'+mo_id].checked=false;
		   }
		 
		 if (obj.name.substring(0,11) == 'SolicitaCom' && obj.checked) 
		   {
		   formu.elements['NoComercial'+mo_id].checked=false;
		   }
		 }
		 
		 function calculaFecha(nom,mas){ // nom:nombre del combo; mas:incremento del "delay" cf sabado, domingo...
    /*
      
      
      Modificado por Nacho Garcia
      fecha: 19/8/2002
      
      se calculan los dias habiles
      
      Modificado por Nacho Garcia
      fecha: 14/9/2001
      
      A la hora de calcular la fecha hay un caso especial que es que la fecha de entrega no se quiera informar.
      en ese caso la fecha es NULL
      
      Modificado por E.T.
      fecha: 31/12/2001
      
      Modificado por Nacho
      fecha: 15/01/2002
 
      Cambios introducidos:
      - Utiliza las funciones de suma de fechas de Javascript
      - Separar el tratamiento de los controles del tratamiento de las fechas
      - Corrección del error en Netscape y Mozilla que presenta la fecha 101 en lugar de 2001
      - Corrección del error en todas las plataformas que presenta fecha 0/mm/yyyy
    */
        

          
        if(nom=='ENTREGANO' && document.forms['Principal'].elements['IDPLAZO'+nom].options[document.forms['Principal'].elements['IDPLAZO'+nom].selectedIndex].value==0){
          document.forms['Principal'].elements['FECHANO_ENTREGA'].value='';
        }
        else{
          var hoy=new Date(); 
          
           /*
              nacho 13/11/2002
              para la entrega y la decision se calculan dias habiles
              para el pago naturales
           
           */
            
          if(nom=='ENTREGA' || nom=='DECISION'){
          
            if(mas==999){
             ]]> </xsl:text>   
	              mas='<xsl:value-of select="//LP_PLAZOENTREGA"/>';
	            <xsl:text disable-output-escaping="yes"> <![CDATA[
	          }
          
            var Resultado=calcularDiasHabiles(hoy,mas);
          }
          else{
          
            if(mas==999){
	              mas=0;
	          }
          
            var Resultado=sumaDiasAFecha(hoy, mas);
          
               // gestion de los sabados y domingos...
               diaSemana = Resultado.getDay();
          
               if (diaSemana==0) 
                 Resultado=sumaDiasAFecha(Resultado,1);
               else 
                 if (diaSemana==6) 
                   Resultado=sumaDiasAFecha(Resultado,2);
          }
          
          // imprimir datos en los textbox en el formato dd/mm/aaaa....
          
          var elDia=Resultado.getDate();
          var elMes=Number(Resultado.getMonth())+1;
          var elAnyo=Resultado.getFullYear();
          var laFecha=elDia+'/'+elMes+'/'+elAnyo;
          if (nom=='ENTREGANO'){     
            document.forms['Principal'].elements['FECHANO_ENTREGA'].value = laFecha;
          }
          else{  
            document.forms['Principal'].elements['FECHA_'+nom].value = laFecha;   
          }
        //if(document.forms['Principal'].elements['COMBO_'+nom].options[document.forms['Principal'].elements['COMBO_'+nom].options.selectedIndex].value!='0'){
          //alert(document.forms['Principal'].elements['COMBO_'+nom].options[document.forms['Principal'].elements['COMBO_'+nom].options.selectedIndex].value);
         // document.forms['Principal'].elements['COMBO_'+nom].options[document.forms['Principal'].elements['COMBO_'+nom].options.selectedIndex].value;      
        //}
      } 
    } 

    
    function habilitarDeshabilitarCampo(obj){
     
       var txtObj;
       var accionFecha;
       
       if(obj.name=='IDPLAZOPAGO'){
         txtObj='FECHA_PAGO';
         accionFecha='PAGO';
       }
       else{
         if(obj.name=='COMBO_ENTREGA'){
           txtObj='FECHA_ENTREGA';
           accionFecha='ENTREGA';
         }
       }
           
       if(obj.value=="999"){
         document.forms['Principal'].elements[txtObj].className='';
         document.forms['Principal'].elements[txtObj].onfocus=nothing;
         calculaFecha(accionFecha,30);
       }
       else{
         document.forms['Principal'].elements[txtObj].className='inputOcultoBlancoBold';
         document.forms['Principal'].elements[txtObj].onfocus=document.forms['Principal'].elements[txtObj].blur;
         
       }
     }
     
     function nothing(){
       var nada='no hago nada';
     }
     
     function inicializarCamposTextoHabilitados(){
    
       inicializarHabilitarDeshabilitarCampo(document.forms['Principal'].elements['IDPLAZOPAGO']);
       inicializarHabilitarDeshabilitarCampo(document.forms['Principal'].elements['COMBO_ENTREGA']);
     }
     
     function inicializarHabilitarDeshabilitarCampo(obj){
     
       var txtObj;
       
       if(obj.name=='IDPLAZOPAGO'){
         txtObj='FECHA_PAGO';
       }
       else{
         if(obj.name=='COMBO_ENTREGA'){
           txtObj='FECHA_ENTREGA';
         }
       }
           
       if(obj.value=="999"){
         document.forms['Principal'].elements[txtObj].className='';
         document.forms['Principal'].elements[txtObj].onfocus=nothing;
       }
       else{
         document.forms['Principal'].elements[txtObj].className='inputOcultoBlancoBold';
         document.forms['Principal'].elements[txtObj].onfocus=document.forms['Principal'].elements[txtObj].blur;
         
       }
     }
     
     function inicializarImportes(){
       var form;
       
       for(var i=0;i<document.forms.length;i++){
         form=document.forms[i];
         for(var n=0;n<form.length;n++){
            
            // alert(form.elements[n].name + ' val '+ form.elements[n].value);
             
           //sumo a importe_total el coste_logistica
               if(form.elements[n].name.substring(0,16)=='MO_IMPORTETOTAL_' && form.elements[n].value!='Por definir'){
               
                	 //para pedidos mltiproveedor cojo el moid solo para asisa
                    var temp = form.elements[n].name.split('_');
                    var moidpedido = temp[2];
                    
                	//alert('coste log '+form.elements['COSTE_LOGISTICA_'+moidpedido].value);
                    //alert('iva '+form.elements['IVA_'+moidpedido].value);
                    
                    //alert('importe total '+form.elements[n].name+' '+form.elements[n].value);
                    
                    var total = parseFloat(desformateaDivisa(form.elements[n].value)); 
                    var coste = parseFloat(desformateaDivisa(form.elements['COSTE_LOGISTICA_'+moidpedido].value));
                    var iva = parseFloat(desformateaDivisa(form.elements['IVA_'+moidpedido].value));
                    
                     //se oculto precio ref = N y no es nuevo modelo de negocio sumo iva, viamed nuevo y brasil
                    if (form.elements['OCULTO_PRECIO_REF_'+moidpedido].value == 'N' && form.elements['NUEVO_MODELO_NEGOCIO_'+moidpedido].value == 'N'){
                        var totFinal = total + coste + iva; 
                        totFinal = reemplazaPuntoPorComa(totFinal);
                        //alert('total '+total+'coste '+coste+'iva '+iva);
                        //alert('tot final coste iva '+totFinal);
                        }
                    else{
                        var totFinal = total + coste; 
                        totFinal = reemplazaPuntoPorComa(totFinal);
                        //alert('tot final coste '+totFinal);
                        }
                        
                        
                    //este campo no lo cambio
                    form.elements[n].value=anyadirCerosDecimales(formateaDivisa(Round(desformateaDivisa(form.elements[n].value),2)),2); 
               }
           
           //enseño en importe_final el total + coste_logistica, si españa será 0 el coste
           
           if(form.elements[n].name.substring(0,16)=='MO_IMPORTEFINAL_' && form.elements[n].value!='Por definir'){
           			
                  form.elements[n].value = totFinal;
           
                  form.elements[n].value=anyadirCerosDecimales(formateaDivisa(Round(desformateaDivisa(form.elements[n].value),2)),2);
          }//fin if mo_importefinal
             
             
           if(form.elements[n].name.substring(0,14)=='MO_IMPORTEIVA_' && form.elements[n].value!='Por definir'){
             form.elements[n].value=anyadirCerosDecimales(formateaDivisa(Round(desformateaDivisa(form.elements[n].value),2)),2);
             }

          //antes solo así
          // if(form.elements[n].name.substring(0,16)=='MO_IMPORTEFINAL_' && form.elements[n].value!='Por definir')
           //  form.elements[n].value=anyadirCerosDecimales(formateaDivisa(Round(desformateaDivisa(form.elements[n].value),2)),2); 
           
           // if(form.elements[n].name.substring(0,16)=='MO_IMPORTETOTAL_' && form.elements[n].value!='Por definir')
           //  form.elements[n].value=anyadirCerosDecimales(formateaDivisa(Round(desformateaDivisa(form.elements[n].value),2)),2); 
            
         }
       }
     }
     
     function obtenerValorMinimo(objDepl){
          var minimo;
          
          minimo=parseInt(objDepl.options[0].value);
          for(var n=1;n<objDepl.options.length;n++){
            if(parseInt(objDepl.options[n].value)<minimo){
              minimo=parseInt(objDepl.options[n].value);
            }
          }
          return minimo;
        }
        
        
        function calculaFechaMinima(objDespl,queCampo){
          var hoy=new Date();
          
          if(queCampo=='ENTREGA'){
            fechaEntregaMinima=calcularDiasHabiles(hoy,obtenerValorMinimo(objDespl));
          }
        }
        
        function validarFechaMinima(obj,fechaMinima){
             
          var fechaTmpFormatoIngles=obtenerSubCadena(obj.value,2)+'/'+obtenerSubCadena(obj.value,1)+'/'+obtenerSubCadena(obj.value,3);
          var fechaMinimaTmpFormatoIngles=(fechaMinima.getMonth()+1)+'/'+fechaMinima.getDate()+'/'+fechaMinima.getFullYear();
          var fechaMinimaTmpFormatoEspanyol=fechaMinima.getDate()+'/'+(fechaMinima.getMonth()+1)+'/'+fechaMinima.getFullYear();
          
	  var fechaTmp=new Date(fechaTmpFormatoIngles);
	  var fechaMinimaTmp=new Date(fechaMinimaTmpFormatoIngles);
	  
	  
	  if(parseInt(fechaTmp.getTime())<parseInt(fechaMinimaTmp.getTime())){
	    alert(msgFechaMinimaIncorrecta+fechaMinimaTmpFormatoEspanyol);
	    obj.focus();
	    return false;
	  }
	  return true;
        }
        
        function obtenerSubCadena(fecha, posicion){
         
         var separador_1;
         var separador_2;
         
         var separadores=0;
         
         for(var n=0;n<fecha.length;n++){
           if(fecha.substring(n,n+1)=='/'){
             separadores++;
             if(separadores==1){
               separador_1=n;
             }
             else
               if(separadores==2)
                 separador_2=n;
           }
         }
         if(posicion==1){
           return fecha.substring(0,separador_1);
         }
         else
           if(posicion==2){
             return fecha.substring(separador_1+1,separador_2);
           }
           else{
             return fecha.substring(separador_2+1,fecha.length);
           }
             
       }
       
       
        function ProgramarPedido(formPrincipal,linka,formPedido,idMultioferta, objPedidoProgramable){
         var msgProgramacion;
         var abortar=0;
        
         var nombre=formPedido.elements['Nombre_'+idMultioferta].value;
         var minimo=formPedido.elements['Minimo_'+idMultioferta].value;
         
         // los pedidos urgentes no se pueden programar
         if(formPrincipal.elements['URGENTE_'+idMultioferta].checked==true){
         		msgProgramacion=msgPedidosUrgentasProgramacion;
         		alert(msgProgramacion);
           	return;
         }
         else if(formPedido.elements[objPedidoProgramable].value=='N'){
          	//msgProgramacion=msgProgramacionPedidosEstrictos;
          	
        	  msgProgramacion=msgMinimoEstricto_C1_Semaforo+nombre+msgMinimoEstricto_C2_Semaforo+minimo+msgPrograma_C3_Semaforo;
           	abortar=1;
         }
         else if(formPedido.elements[objPedidoProgramable].value=='C'){
            	//msgProgramacion=msgProgramacionPedidosFexiblesInferior;
            	
          		msgProgramacion=msgMinimoFlexible_C1_Semaforo+nombre+msgMinimoFlexible_C2_Semaforo+minimo+msgPrograma_C3_Semaforo;
            	abortar=1;
         }
         else if(formPedido.elements[objPedidoProgramable].value=='A'){
              	msgProgramacion=msgProgramacionAbonos;
               	abortar=1;
         }

         if(abortar){
          	alert(msgProgramacion);
           	return;
         }
         
				 // miramos que no nos pasen la numeracion de la clinica.
				 // en este punto no tiene sentido. el pedido que estamos preparando 
				 // se utiliza como modelo
         
				if(formPrincipal.elements['NUMERO_OFERT_PED_'+idMultioferta].value!=''){
				 	if(confirm(msgNumeroPedidoClinicaParaPrograma)){
						formPrincipal.elements['NUMERO_OFERT_PED_'+idMultioferta].value='';
					}
					else{
						return;
					}
				}
				 
         	]]></xsl:text>
         	<xsl:choose>
          	<xsl:when test="//MULTIOFERTAS/NUMERO_MULTIOFERTAS>1 and //LP_ACCION='DIRECTO'">
           		if(confirm(msgAvisoProgramacion)){
             		//alert('Programando el pedido... '+idMultioferta+' '+formPedido.elements[objPedidoProgramable].value);
             		formPrincipal.elements['BOTON'].value='PROGRAMAR';
             		formPrincipal.elements['MO_IDPROGRAMAR'].value=idMultioferta;
             		formPrincipal.elements['ESTADOPROGRAMAR'].value='28';
             		GuardarComentariosProgramacion(formPrincipal,linka,formPedido, idMultioferta);
           		}  
           	</xsl:when>
           	<xsl:otherwise>
            	formPrincipal.elements['BOTON'].value='PROGRAMAR';
             	formPrincipal.elements['MO_IDPROGRAMAR'].value=idMultioferta;
             	formPrincipal.elements['ESTADOPROGRAMAR'].value='28';
             	GuardarComentariosProgramacion(formPrincipal,linka,formPedido, idMultioferta);
           	</xsl:otherwise> 
         	</xsl:choose>
         	<xsl:text disable-output-escaping="yes"><![CDATA[

       	
       	}
       	
       
       
       /*
           function para programar un pedido
           copiada de GuardarComentarios, lo tratamos de la siguiete manera:
           marcamos como enviar solo el pedido que queremos programar, los demas como no programar.
           y enviamos la marca BOTON=PROGRAMAR
           
           recorremos todas las ofertas y solo marcamos la adecuada como OK
           
           en la BD se trata, basicamente, como una oferta 
       */
       
         function GuardarComentariosProgramacion(formPrincipal,linka,formPedido, mo_idProgramar){ 
           var coments=''
        	 var mo_id;
        	        
  		     
  		     for (i=0;i<formPrincipal.length;i++){
  		       
  		       nom=formPrincipal.elements[i].name;
  		       if (nom.indexOf("COMENTARIO_") != -1){	
  		  	     mo_id=nom.substring(nom.indexOf("_")+1,nom.length);
  		  	     coments+="|" + mo_id + "#" + formPrincipal.elements['COMENTARIO_'+mo_id].value + "#";
   		  	     if (formPrincipal.elements['SolicitaComercial'+mo_id].checked) 
   		  	       coments+="S#";
   		  	     else 
   		  	       coments+="N#";		  	
  		  	     if(formPrincipal.elements['SolicitaMuestra'+mo_id].checked) 
  		  	       coments+="S#";
   		  	     else 
   		  	       coments+="N#";
   		  	     if (formPrincipal.elements['NoComercial'+mo_id].checked) 
   		  	       coments+="S$";
   		  	     else 
   		  	       coments+="N$";
  		       }	  	
  		     }
        	 
        	 formPrincipal.elements['COMENTARIOS_PROVEEDORES'].value=coments;
        	     
		     //
		     // * Ofertas: Validamos el pedido, la forma de pago y hacemos submit.
		     // * Pedidos: Validamos el pedido y hacemos submit
		     //
           if(PrepararPedidoAProgramar(formPrincipal,formPedido,mo_idProgramar)==true){
        	   AsignarAccion(formPrincipal,linka);
        	       
        	   
			]]></xsl:text>
        	     <xsl:choose>
        	       <xsl:when test="//LP_ACCION[.='DIRECTO']">
        	         <xsl:text disable-output-escaping="yes"><![CDATA[
        	           var miForm=document.forms['PedidoMinimo'];  // forms[0]
        	           var mensaje='Los pedidos a los siguientes proveedores no se enviarán:\n';
        	           var seEnvianTodos='S';
        	           for(var n=0;n<miForm.length;n++){
        	             if(miForm.elements[n].name.substring(0,7)=='Status_' && (miForm.elements[n].value!='S' && miForm.elements[n].value!='SC')){
        	               var id=obtenerId(miForm.elements[n].name);
        	               
        	               /*
        	                  desactivamos el aviso de pedidos que no es enviar solo se puede programar uno
        	               
        	               */
        	               
        	               seEnvianTodos='S';
        	               //seEnvianTodos='N';
        	               mensaje+='\n* '+miForm.elements['Nombre_'+id].value;
        	             }
        	           }
        	           
        	           mensaje+='\n\nSi desea MODIFICAR los pedidos pulse en \"Aceptar\".\nEn caso contrario, sólo los pedidos con el semaforo en VERDE serán enviados.';
        	           
        	           if(seEnvianTodos=='N'){
        	             if(confirm(mensaje)){
        	               parent.history.go(-2-historia);
        	             }
        	             else{
        	               SubmitForm(formPrincipal,document);
        	             }
        	           }
        	           else{
        	             SubmitForm(formPrincipal,document);
        	           }
        	           
        	        ]]> </xsl:text>
        	       </xsl:when>
        	     </xsl:choose>
        	   <xsl:text disable-output-escaping="yes"><![CDATA[
        	      
        	 }
         } 
         
         function PrepararPedidoAProgramar (formu, formPedido, idMultioferta){

           var StringEnviar="";
           var action = formPedido.elements['Action'].value;
	
        	 for (i=0;i<formPedido.length;i++){



        	  if (formPedido.elements[i].name.substring(0,5) == 'Total'){   	  
        	    var mo_id=formPedido.elements[i].name.substring(6);
        	    
        	    if(mo_id==idMultioferta){

        	      formPedido.elements['Status_'+mo_id].value='S';
        	    }
        	    else{
        	      formPedido.elements['Status_'+mo_id].value='N';
        	    }
      	      
      	      // Accedemos a los valores   	    
        	    var status=formPedido.elements['Status_'+mo_id].value;
        	    var nombre=formPedido.elements['Nombre_'+mo_id].value;
        	    var divisa=formPedido.elements['Divisa_'+mo_id].value;
        	    

        	    
        	    StringEnviar+="("+mo_id+",";
        	    StringEnviar+=status.substring(0,1)+"),";
        	  } // if (Total)
        	} // for ()
        	    
        	StringEnviar=StringEnviar.substring(0,StringEnviar.length-1);
        	//alert('StringEnviar:'+StringEnviar);
        	  
          formu.elements['ENVIAR_OFERTAS'].value=StringEnviar;
        	return true;  	
		    }
		    
		    function asignarValorDesplegable(form,nombreObj,valor){
      var indiceSeleccionado=form.elements[nombreObj].length-1;
      for(var n=0;n<form.elements[nombreObj].length;n++){
        if(form.elements[nombreObj].options[n].value==valor){
          indiceSeleccionado=n;
        }
      }
      form.elements[nombreObj].selectedIndex=indiceSeleccionado;
    }
    
    
    function calculaFechaCalendarios(mas){
          var hoy=new Date();
          var Resultado=calcularDiasHabiles(hoy,mas);  
 
          var elDia=Resultado.getDate();
          var elMes=Number(Resultado.getMonth())+1;
          var elAnyo=Resultado.getFullYear();
          var laFecha=elDia+'/'+elMes+'/'+elAnyo;
          
          return laFecha;   
    }
    
    function actualizarPlazo(form,nombreObj, fFechaOrigen){

      var fechaOrigen=fFechaOrigen.getDate()+'/'+(Number(fFechaOrigen.getMonth())+1)+'/'+fFechaOrigen.getFullYear();
      var fechaDestino=form.elements['FECHA_'+nombreObj].value;
      var nombreCombo;
     
      
      if(CheckDate(fechaDestino)==''){
        var fFechaDestino=new Date(formatoFecha(fechaDestino,'E','I'));
        
        
        if(nombreObj=='ENTREGA'){
          var diferencia=diferenciaDias(fFechaOrigen,fFechaDestino,'HABILES');
          nombreCombo='COMBO_'+nombreObj;
        }
        else{
          var diferencia=diferenciaDias(fFechaOrigen,fFechaDestino,'NATURALES');
          nombreCombo='IDPLAZOPAGO';
        }
        asignarValorDesplegable(form,nombreCombo,diferencia);     
      }
      else{
        alert(CheckDate(fechaDestino));
      }
    }
  
    function ultimosComentarios(nombreObjeto,nombreForm,tipoComentario){
      var accion='CONSULTAR';
      MostrarPagPersonalizada('http://www.newco.dev.br/Compras/NuevaMultioferta/UltimosComentarios.xsql?NOMBRE_OBJETO='+nombreObjeto+'&NOMBRE_FORM='+nombreForm+'&ACCION='+accion+'&TIPO='+tipoComentario+'&COMENTARIO='+document.forms[nombreForm].elements[nombreObjeto].value.replace(/\n/g,'\\\\n'),'comentarios',100,80,0,0);
    }
    
    function copiarComentarios(nombreForm,nombreObjeto,texto){
      if(quitarEspacios(document.forms[nombreForm].elements[nombreObjeto].value)!=''){
        document.forms[nombreForm].elements[nombreObjeto].value+='\n\n';
      }
      document.forms[nombreForm].elements[nombreObjeto].value+=texto;
    }
    
     function volverAtras(){
     	
        var browserName= navigator.appName;
		var version= navigator.appVersion;
     
     	if (browserName.match('Explorer')){
        	history.go(-2-historia);
        }
        else { history.go(-1-historia); }
        
     }//fin volverAtras
     
     //ver div de productos manuales
     function VerProductosManuales(){
     	if (document.getElementById('divProductosManuales').style.display == 'none'){
        	jQuery("#divProductosManuales").show();
        }
        else {
        	if (document.getElementById('divProductosManuales').style.display == 'none'){ jQuery("#divProductosManuales").hide(); }
            }
     }
     
     //function añadir productos no en plantilla
     function AnadirProductosManuales(){
     			var form = document.forms['Principal'];
            	var msg = '';
                
            	var moId	= form.elements['MOID'].value;
                var refProv	= encodeURIComponent(form.elements['REFPROVEEDOR'].value);
                var descripcion	= encodeURIComponent(form.elements['DESCRIPCION'].value);
                var unBasica	= encodeURIComponent(form.elements['UNIDADBASICA'].value);
                var cantidad	= form.elements['CANTIDAD'].value;
                //var precio	= form.elements['PRECIOUNITARIO'].value;
                //var iva	= form.elements['TIPO_IVA'].value;
                
                //si cantidad no es un numero return false no sigo
                if (!checkNumber(cantidad)) return false;
                 
                if (refProv != '' && descripcion != '' && unBasica != '' && cantidad != ''){
                
                    jQuery.ajax({
                    cache:	false,
                    url:	'ProductosManualesSave_ajax.xsql',
                    type:	"GET",
                    data:	"MOID="+moId+"&REFPROVEEDOR="+refProv+"&DESCRIPCION="+descripcion+"&UNIDADBASICA="+unBasica+"&CANTIDAD="+cantidad,
                    contentType: "application/xhtml+xml",
                    error: function(objeto, quepaso, otroobj){
                        alert('error'+quepaso+' '+otroobj+''+objeto);
                    },
                    success: function(objeto){
                        var data = eval("(" + objeto + ")"); 
            
                        if(data.ProductosManualesSave.estado == 'OK'){
                        	RecuperaProductosManuales(moId);
                			form.elements['REFPROVEEDOR'].value = '';
               				form.elements['DESCRIPCION'].value = '';
                			form.elements['UNIDADBASICA'].value = '';
                			form.elements['CANTIDAD'].value = '';
                			//form.elements['PRECIOUNITARIO'].value = '';
                			//form.elements['TIPO_IVA'].value = '';
                           //document.location.reload(true);	
                        }else{
                            alert(form.elements['ERROR_INSERTAR_DATOS'].value);
                        }
                    }
                    });//fin jquery
            	}
                else{ 
                    msg = form.elements['TODOS_CAMPOS_OBLI'].value; 
                    alert(msg);
                }
            }//fin de AnadirProductosManuales
     		
             //function eliminar productos manuales
     		 function EliminarProductosManuales(idProdMan){
     			var form = document.forms['Principal'];
            	var msg = '';
            	var moId= form.elements['MOID'].value;
                
                if (idProdMan != ''){
                
                    jQuery.ajax({
                    cache:	false,
                    url:	'EliminarProductosManuales.xsql',
                    type:	"GET",
                    data:	"ID_PRODMAN="+idProdMan,
                    contentType: "application/xhtml+xml",
                    error: function(objeto, quepaso, otroobj){
                        alert('error'+quepaso+' '+otroobj+''+objeto);
                    },
                    success: function(objeto){
                        var data = eval("(" + objeto + ")");
            
                        if(data.EliminarProductosManuales.estado == 'OK'){
                        	RecuperaProductosManuales(moId);
                        }else{
                            alert(form.elements['ERROR_ELIMINAR_DATOS'].value);
                        }
                    }
                    });//fin jquery
            	}
                else{ 
                    msg = form.elements['ERROR_ELIMINAR_DATOS'].value; 
                    alert(msg);
                }
            }//fin de EliminarProductosManuales
     
     
            //recupero a los productos manuales
            function RecuperaProductosManuales(moId){
                
                var ACTION="http://www.newco.dev.br/Compras/Multioferta/ProductosManuales.xsql";
                var post='MOID='+moId;
                if (moId != '') sendRequest(ACTION,handleRequestProductosManuales,post);
            }
     
            //recupero a los productos manuales
            function RecuperaProductosManuales(moId){
                
                var ACTION="http://www.newco.dev.br/Compras/Multioferta/ProductosManuales.xsql";
                var post='MOID='+moId;
                if (moId != '') sendRequest(ACTION,handleRequestProductosManuales,post);
            }
            
          function handleRequestProductosManuales(req){
                
                var response = eval("(" + req.responseText + ")");
                var Resultados = new String('');
                
                if(response.ProductosManuales.length > 0){
                
					jQuery("#productosManuales tbody").empty();
                
					// Se crea la tabla de los productos manuales
					jQuery.each(response.ProductosManuales, function(key, producto){

						txtHTML = "<tr id="+producto.PMId+">" +
									"<td>" + producto.PMRefProv+"</td>" +
									"<td>" + producto.PMDescripcion+"</td>" +
									"<td>" + producto.PMUnBasica+"</td>" +
									"<td>" + producto.PMCantidad+"</td>" +
                                    //"<td align='center'>" + producto.PMPrecio+"</td>" +
                                    //"<td align='center'>" + producto.PMIva+"</td>" +
									"<td>" +
										"<a class=\"accBorrar\" href=\"javascript:EliminarProductosManuales('"+producto.PMId+"');\">" +
											"<img src='http://www.newco.dev.br/images/2017/trash.png'/>" +
										"</a>" +
        	                        "</td>" +
                                    "<td>"+" "+"</td>" +
								"</tr>";
                    
					//escribo HTML en la tabla
					jQuery("#productosManuales").show();
					jQuery("#productosManuales tbody").append(txtHTML);
                    });
				
				}
                //si no hay productos
                else{
                	jQuery("#productosManuales tbody").empty();
                    jQuery("#productosManuales").hide();
                
                }
            }//fin de recupero productos manuales
            
     
        //-->
        </script>        
       ]]> </xsl:text>	
        
      </head>
      
      <body class="gris">
      <xsl:choose><!-- error -->
          <xsl:when test="//xsql-error">
             <xsl:apply-templates select="//xsql-error"/>         
          </xsl:when> 
          <xsl:when test="//SESION_CADUCADA">
            <xsl:apply-templates select="//SESION_CADUCADA"/>        
          </xsl:when> 
      <xsl:otherwise>   
      <xsl:attribute name="onLoad">
          <xsl:choose>
            <xsl:when test="//CENTRALCOMPRAS">
               inicializarDesplegableCentros('<xsl:value-of select="/Generar/IDCENTRO"/>','<xsl:value-of select="/Generar/IDLUGARENTREGA"/>','<xsl:value-of select="/Generar/IDCENTROCONSUMO"/>');
            </xsl:when>
            <xsl:otherwise>
               inicializarDesplegableLugaresEntrega('<xsl:value-of select="/Generar/IDCENTRO"/>','<xsl:value-of select="/Generar/IDLUGARENTREGA"/>');
               inicializarDesplegableCentrosConsumo('<xsl:value-of select="/Generar/IDCENTRO"/>','<xsl:value-of select="/Generar/IDCENTROCONSUMO"/>');
               //inicializarDesplegableAlmacenesInternos('<xsl:value-of select="/Generar/IDCENTRO"/>','<xsl:value-of select="/Generar/IDALMACENINTERNO"/>');
            </xsl:otherwise>
          </xsl:choose>
 
          CrearStatus();
          inicializarImportes();
          <xsl:choose>
            <xsl:when test="$accion='DIRECTO'">
              calculaFechaMinima(document.forms['Principal'].elements['COMBO_ENTREGA'],'ENTREGA');
              /*inicializarCamposTextoHabilitados();*/
            </xsl:when>
          </xsl:choose>
        </xsl:attribute>
        <a name="inicio"/>
        <xsl:if test="$accion='DIRECTO'">
          <div id="spiffycalendar" class="text"></div>
          <script type="text/javascript">
            var calFechaEntrega = new ctlSpiffyCalendarBox("calFechaEntrega", "Principal", "FECHA_ENTREGA","btnDateFechaEntrega",'<xsl:value-of select="/Generar/FECHA_ENTREGA"/>',scBTNMODE_CLASSIC,'ONCHANGE|actualizarPlazo(document.forms[\'Principal\'],\'ENTREGA\',new Date());#CHANGEDAY|actualizarPlazo(document.forms[\'Principal\'],\'ENTREGA\',new Date());');
			
			
          </script>
        
        </xsl:if>
         
      
       <!--
        |   Variable que contiene el tipo de accion. 
        |	Puede ser DIRECTO (para pedidos directos) ó
        |		  EDICION (para multiofertas)
        +-->
	        
                
      
      <form name="PedidoMinimo">
        <input type="hidden" name="Action" value="{$accion}"/>
      <xsl:for-each select="MULTIOFERTAS/MULTIOFERTAS_ROW">
<!--      	<input type="hidden" name="MO_ID" value="{MO_ID}"/> -->
      	<input type="hidden" name="Total_{MO_ID}" value="{MO_IMPORTETOTAL_SINFORM}"/>      	
      	<input type="hidden" name="Minimo_{MO_ID}" value="{EMP_PEDMINIMO_IMPORTE_SINFORM}"/>
      	<input type="hidden" name="Estricto_{MO_ID}" value="{EMP_PEDMINIMO_ACTIVO}"/>
      	<input type="hidden" name="Status_{MO_ID}" value="void"/>
      	<input type="hidden" name="PED_PROGRAMABLE_{MO_ID}"/>
      	<input type="hidden" name="Nombre_{MO_ID}" value="{PROVEEDOR}"/>
      	<input type="hidden" name="Divisa_{MO_ID}" value="{EMP_PEDMINIMO_DIVISA}"/>
      </xsl:for-each>	     
      
      	<!--mensaje js desde multiidioma-->
        
      </form>
      
      <form name="Principal" method="POST">
      	<input type="hidden" name="ENVIAR_OFERTAS"/> <!-- String con las ofertas que hay que mandar y las que no -->
        <input type="hidden" name="COMENTARIOS_PROVEEDORES"/> <!-- String para los comentarios de los proveedores -->
        <input type="hidden" name="LP_ID" value="{LP_ID}"/>
        <input type="hidden" name="BOTON"/>
        <input type="hidden" name="MO_IDPROGRAMAR"/>
        <input type="hidden" name="ESTADOPROGRAMAR"/>
        <input type="hidden" name="COSTE_LOGISTICA"/>
        
        
        
        <xsl:choose>
          <xsl:when test="//xsql-error">
            <xsl:apply-templates select="//xsql-error"/>          
          </xsl:when>         
          <xsl:when test="//Status">
            <xsl:apply-templates select="//Status"/>          
          </xsl:when>         
          <xsl:otherwise> 
   
      <!--idioma-->
        <xsl:variable name="lang">
        	<xsl:value-of select="/Generar/LANG" />
        </xsl:variable>
        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
      <!--idioma fin-->
      
         
 <div class="divleft">
  
       <h1 class="titlePage"> 
           <xsl:choose>
               <xsl:when test="/Generar/MULTIOFERTAS/MULTIOFERTAS_ROW/REQUIERE_PRESUPUESTO = 'S'">
                   <xsl:value-of select="document($doc)/translation/texts/item[@name='solicitud_de_presupuesto']/node()"/><xsl:text>&nbsp;a&nbsp;</xsl:text>
               </xsl:when>
               <xsl:otherwise>
                    <xsl:value-of select="/Generar/MULTIOFERTAS/TIPODOCUMENTO" />deded<xsl:text>&nbsp;a&nbsp;</xsl:text>
               </xsl:otherwise>
           </xsl:choose>
           
           <xsl:choose>
                <xsl:when test="/Generar/MULTIOFERTAS/MULTIOFERTAS_ROW/CENTROPROVEEDOR != ''"><xsl:value-of select="/Generar/MULTIOFERTAS/MULTIOFERTAS_ROW/CENTROPROVEEDOR"/></xsl:when>
                <xsl:otherwise><xsl:value-of select="/Generar/MULTIOFERTAS/LP_NOMBRE"/></xsl:otherwise>
           </xsl:choose>
       </h1>

	<table class="infoTable" border="0">
    <xsl:choose>
      <xsl:when test="MULTIOFERTAS/MULTIOFERTAS_ROW[1]/LP_ACCION='EDICION'">
       
        <tr> 
          <td>
          	<xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_limite_respuesta']/node()"/>
          </td> 
          <td colspan="3">
              <xsl:apply-templates select="MULTIOFERTAS/MULTIOFERTAS_ROW[1]/LP_FECHADECISION"/>
          </td>
        </tr>
        <tr> 
          <td class="labelRight">
            <xsl:choose>
            <xsl:when test="//CENTRALCOMPRAS">
            	<xsl:value-of select="document($doc)/translation/texts/item[@name='centro_entrega']/node()"/>
            </xsl:when>
            <xsl:otherwise>
            	<xsl:value-of select="document($doc)/translation/texts/item[@name='entregar_en']/node()"/>
            </xsl:otherwise>
          </xsl:choose>
          </td> 
	     <td class="textLeft cuarenta" colspan="3">
          <p class="textLeft">
             <xsl:choose>
            <xsl:when test="//CENTRALCOMPRAS">
              <select name="IDCENTRO" onChange="inicializarDesplegableCentros(this.value);"/>
            </xsl:when>
            <xsl:otherwise>
              <input type="hidden" name="IDCENTRO" value="{//Generar/IDCENTRO}"/>
            </xsl:otherwise>
          </xsl:choose>
          
            <select name="IDLUGARENTREGA" onChange="ActualizarTextoLugarEntrega(this.value);"/> 
           </p>         
          </td>
      
          <td class="labelRight">
              <xsl:if test="/Generar/MULTIOFERTAS/MOSTRARCENTROSCONSUMO">
          	<xsl:value-of select="document($doc)/translation/texts/item[@name='facturar_a']/node()"/>: 
              </xsl:if>
          </td> 
          <td> 
           <p class="textLeft">
            <select name="IDCENTROCONSUMO">
                <xsl:attribute name="style">
                    <xsl:choose>
                    <xsl:when test="/Generar/MULTIOFERTAS/MOSTRARCENTROSCONSUMO">display:;</xsl:when>
                    <xsl:otherwise>display:none;</xsl:otherwise>
                    </xsl:choose>
                </xsl:attribute>
            </select>
            </p>
          </td>
        </tr>
        <tr> 
          <td class="labelRight">
          	<xsl:value-of select="document($doc)/translation/texts/item[@name='entregar_en']/node()"/>
          </td> 
          <td>
            <xsl:call-template name="direccion">
              <xsl:with-param name="path" select="MULTIOFERTAS/MULTIOFERTAS_ROW[1]/CENTRO"/>
            </xsl:call-template>
          </td>
          <td class="labelRightTop">
          	<xsl:value-of select="document($doc)/translation/texts/item[@name='entrega']/node()"/>
          </td>
          <td>
          	<xsl:value-of select="document($doc)/translation/texts/item[@name='presupuesto']/node()"/>
          </td>
        </tr>
      </xsl:when>
      <xsl:otherwise>
        <tr> 
          <td class="labelRight">
            <xsl:choose>
            <xsl:when test="//CENTRALCOMPRAS">
            	<xsl:value-of select="document($doc)/translation/texts/item[@name='centro_de_entrega']/node()"/>:
            </xsl:when>
            <xsl:otherwise>
            	<xsl:value-of select="document($doc)/translation/texts/item[@name='entregar_en']/node()"/>:
            </xsl:otherwise>
          </xsl:choose>
          </td> 
          <td class="cuarenta">
          <p class="textleft">
            <xsl:choose>
            <xsl:when test="//CENTRALCOMPRAS">
              <select name="IDCENTRO" onChange="inicializarDesplegableCentros(this.value);"/>
            </xsl:when>
            <xsl:otherwise>
              <input type="hidden" name="IDCENTRO" value="{//Generar/IDCENTRO}"/>
            </xsl:otherwise>
          </xsl:choose>
            <select name="IDLUGARENTREGA" onChange="ActualizarTextoLugarEntrega(this.value);"/>
            </p>
          </td>
          <td class="labelRight">
              <xsl:if test="/Generar/MULTIOFERTAS/MOSTRARCENTROSCONSUMO">
          	<xsl:value-of select="document($doc)/translation/texts/item[@name='centro_de_consumo']/node()"/>:
              </xsl:if>
          </td> 
          <td colspan="3"> 
            <p class="textleft">
                <select name="IDCENTROCONSUMO">
                <xsl:attribute name="style">
                    <xsl:choose>
                    <xsl:when test="/Generar/MULTIOFERTAS/MOSTRARCENTROSCONSUMO">display:;</xsl:when>
                    <xsl:otherwise>display:none;</xsl:otherwise>
                    </xsl:choose>
                </xsl:attribute>
                </select>
            </p>
          </td>
        </tr>
        <tr> 
          <td class="labelRight">
          	<xsl:value-of select="document($doc)/translation/texts/item[@name='entregar_en']/node()"/>:
          </td> 
          <td>
            <xsl:call-template name="direccion">
              <xsl:with-param name="path" select="MULTIOFERTAS/MULTIOFERTAS_ROW[1]/CENTRO"/>
            </xsl:call-template>
          </td>
          <td class="labelRight">
          	<xsl:value-of select="document($doc)/translation/texts/item[@name='entrega']/node()"/>:
          </td>
          <td>  
              <p style="width:70px; float:left; margin-top:5px;">
              <xsl:call-template name="field_funcion">
                <xsl:with-param name="path" select="//Generar/field[@name='COMBO_ENTREGA']"/>
                <xsl:with-param name="IDAct" select="//COMBO_ENTREGA"/>
                <xsl:with-param name="cambio">calculaFecha('ENTREGA',this.options[this.selectedIndex].value);/*habilitarDeshabilitarCampo(this);*/</xsl:with-param>
                <xsl:with-param name="valorMinimo" select="//LP_PLAZOENTREGA"/>
              </xsl:call-template>
              </p>
         	  <p style="width:100px; float:left; font-size:12px;">
				<script type="text/javascript">
                  calFechaEntrega.dateFormat="d/M/yyyy";
                  calFechaEntrega.labelCalendario='fecha de entrega';
                  calFechaEntrega.minDate=new Date(formatoFecha(calculaFechaCalendarios('<xsl:value-of select="/Generar/LP_PLAZOENTREGA"/>'),'E','I'));
                  calFechaEntrega.writeControl(); 
                </script>
              </p>
            <input type="hidden" name="sum" size="14" readonly="readonly"/>
          </td>
        </tr>
		
	    	<input type="hidden" name="IDFORMAPAGO" value="0" />	                
	    	<input type="hidden" name="FORMAPAGO" value="" />	                
	    	<input type="hidden" name="IDPLAZOPAGO" value="0" />	                
	    	<input type="hidden" name="FECHA_PAGO" value="{/Generar/FECHA_PAGO}" />	                
     
      </xsl:otherwise>
    </xsl:choose>  
  	</table> 
	</div><!--fin divLeft gris-->
	<!--	2jun10		-->
	<xsl:variable name="OcultarPrecioReferencia"> 
	<xsl:choose>
		<xsl:when test="/Generar/MULTIOFERTAS/OCULTAR_PRECIO_REFERENCIA">S</xsl:when><!-- cuidado con no dejar espacios! -->
		<xsl:otherwise>N</xsl:otherwise>
	</xsl:choose>
	</xsl:variable>
		
        <!--	28mar07	ET Quitamos comentario sobre dias habiles	<span class="camposObligatorios">*</span>Para consultar los días hábiles pulse sobre el proveedor.-->        
    <div class="divLeft" style="border-bottom:2px solid silver;">&nbsp;</div>
    <div class="divleft">
    	
                <xsl:apply-templates select="MULTIOFERTAS">
					<xsl:with-param name="OcultarPrecioReferencia" select="$OcultarPrecioReferencia"></xsl:with-param>     
				</xsl:apply-templates>
    <xsl:choose>           
    <xsl:when test="/Generar/MULTIOFERTAS/MULTIOFERTAS_ROW/REQUIERE_PRESUPUESTO = 'S'">
         <table class="encuesta" border="0">
            <tfoot>
        	<tr class="center">
            <td class="veinte">
            	<div class="boton">
            		<a href="javascript:volverAtras();">
                    	<xsl:value-of select="document($doc)/translation/texts/item[@name='volver']/node()"/>
                    </a>
                </div>
            </td>
            <td class="veinte">&nbsp;</td>
            <td class="veinte">&nbsp;</td>
            <td>&nbsp;</td>
            <td class="veinte">
		      	<div class="boton" id="divEnviarPedido">
            		<a id="botonEnviarPresupuesto" href="javascript:GuardarComentarios(document.forms['Principal'],'CVGenerarPresupuestoSave.xsql',document.forms['PedidoMinimo'], 'PRESUPUESTO');">
                    	<xsl:value-of select="document($doc)/translation/texts/item[@name='enviar']/node()"/>
                    </a>
                </div>
             
		    </td>
           </tr>
           <tr><td colspan="5">&nbsp;</td></tr>
           <tr>
           <td colspan="5">
           <xsl:value-of select="document($doc)/translation/texts/item[@name='para_dudas_contactar_tel']/node()"/>
           </td>
           </tr>
           </tfoot>
	</table>
    </xsl:when>
    <xsl:otherwise>
        <table class="encuesta" border="0">
            <tfoot>
            <tr class="center">
            <td class="dies">&nbsp;</td>
            <td class="veinte">
            	<div class="boton">
            		<a href="javascript:volverAtras();">
                    	<xsl:value-of select="document($doc)/translation/texts/item[@name='volver']/node()"/>
                    </a>
                </div>
		    </td>
            <td class="quince">&nbsp;</td>
		<td class="veinte">	
		    <xsl:if test="//MULTIOFERTAS/NUMERO_MULTIOFERTAS=1 and //LP_ACCION='DIRECTO' and not(/Generar/MULTIOFERTAS/MINIMALISTA)"> 
     			<div class="boton">
                    	<a>
                        <xsl:attribute name="href">javascript:ProgramarPedido(document.forms['Principal'],'CVGenerarSave.xsql',document.forms['PedidoMinimo'],'<xsl:value-of select="//MULTIOFERTAS/MULTIOFERTAS_ROW[1]/MO_ID"/>','PED_PROGRAMABLE_<xsl:value-of select="//MULTIOFERTAS/MULTIOFERTAS_ROW[1]/MO_ID"/>');
                        </xsl:attribute>
                        
                       <xsl:value-of select="document($doc)/translation/texts/item[@name='programar']/node()"/>
                       </a>
            		</div>
		    </xsl:if>
		    </td>
            <td>&nbsp;</td>
            <td class="veinte">
		      	<div class="boton" id="divEnviarPedido">
            		<a id="botonEnviarPedido" href="javascript:GuardarComentarios(document.forms['Principal'],'CVGenerarSave.xsql',document.forms['PedidoMinimo'],'PEDIDO');">
                    	<xsl:value-of select="document($doc)/translation/texts/item[@name='enviar']/node()"/>
                    </a>
                </div>
             
		    </td>
           </tr>
           <tr><td colspan="5">&nbsp;</td></tr>
           <tr>
           <td colspan="5">
           <xsl:value-of select="document($doc)/translation/texts/item[@name='para_dudas_contactar_tel']/node()"/>
           </td>
           </tr>
           </tfoot>
	</table>
    </xsl:otherwise><!--fin de si requiere presupuesto-->
    </xsl:choose>
    
	</div>
	</xsl:otherwise>
	</xsl:choose>
	</form>
          </xsl:otherwise>
          </xsl:choose> 
          
  
      </body>    
    </html>
  </xsl:template>

<xsl:template match="MULTIOFERTAS">
	<xsl:param name="OcultarPrecioReferencia"/>
    
    <xsl:variable name="nuevoModeloNegocio">
    	<xsl:choose>
        <xsl:when test="/Generar/MULTIOFERTAS/MOSTRAR_PRECIO_REFERENCIA/@NuevoModeloNegocio != ''">
        	<xsl:value-of select="/Generar/MULTIOFERTAS/MOSTRAR_PRECIO_REFERENCIA/@NuevoModeloNegocio"/>
        </xsl:when>
        <xsl:when test="/Generar/MULTIOFERTAS/OCULTAR_PRECIO_REFERENCIA/@NuevoModeloNegocio != ''">
        	<xsl:value-of select="/Generar/MULTIOFERTAS/OCULTAR_PRECIO_REFERENCIA/@NuevoModeloNegocio"/>
        </xsl:when>
        </xsl:choose>
    </xsl:variable>
    
     <xsl:variable name="pedidoAntiguo">
    	<xsl:choose>
        <xsl:when test="/Generar/MULTIOFERTAS/MOSTRAR_PRECIO_REFERENCIA/@PedidoAntiguo != ''">
        	<xsl:value-of select="/Generar/MULTIOFERTAS/MOSTRAR_PRECIO_REFERENCIA/@PedidoAntiguo"/>
        </xsl:when>
        <xsl:when test="/Generar/MULTIOFERTAS/OCULTAR_PRECIO_REFERENCIA/@PedidoAntiguo != ''">
        	<xsl:value-of select="/Generar/MULTIOFERTAS/OCULTAR_PRECIO_REFERENCIA/@PedidoAntiguo"/>
        </xsl:when>
        </xsl:choose>
    </xsl:variable>
    
    <!--nuevo modelo = <xsl:value-of select="$nuevoModeloNegocio"/>+++
    pedido antiguo = <xsl:value-of select="$pedidoAntiguo"/>+++
    ocultar precio ref <xsl:value-of select="$OcultarPrecioReferencia"/>-->
    <xsl:for-each select="MULTIOFERTAS_ROW">
    
      <!--idioma-->
        <xsl:variable name="lang">
        	<xsl:value-of select="../../LANG" />
        </xsl:variable>
        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
      <!--idioma fin-->
    
  	<a name="multioferta_{MO_ID}"/>
  	<table border="0" class="infoTable">	
    <thead>
    <tr>
       <td class="paddingLeft datosLeft">
              <p class="textAzul margin25"><xsl:value-of select="$preparar"/></p>
       </td>
        <td rowspan="2">&nbsp;</td>   
   
     
       <td><a href="javascript:window.print();"><img src="http://www.newco.dev.br/images/imprimir.gif" alt="Imprimir" title="Imprimir" /><xsl:value-of select="document($doc)/translation/texts/item[@name='imprimir']/node()"/></a>&nbsp;&nbsp;&nbsp;&nbsp;</td>
       
    </tr>
   
  </thead>
  </table>
  <!--tabla pedido rows-->
  <table class="encuesta">
  <thead>
		<tr class="titulosNoAlto">   
        <!-- ref mvm + cod nacional si es farmacia -->
            <th align="left" class="ocho">
            	 <xsl:choose>
                        <xsl:when test="LINEASMULTIOFERTA/LINEASMULTIOFERTA_ROW[1]/LMO_CATEGORIA = 'F' and /Generar/MULTIOFERTAS/UTILIZAR_REFERENCIA_PROVEEDOR">
                        	<xsl:value-of select="document($doc)/translation/texts/item[@name='codigo_nacional']/node()"/>
                        </xsl:when>
                         <!--<xsl:when test="LINEASMULTIOFERTA/LINEASMULTIOFERTA_ROW[1]/LMO_CATEGORIA = 'N'">-->
                         <xsl:otherwise>
                         	&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='ref_cliente']/node()"/>.
                        </xsl:otherwise>
                 </xsl:choose>
                 
      		</th> 
           	<!-- producto -->
           	<th class="textLeft">
            	<xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/>
        	</th>
          
            <!-- ref provee si es normal-->
            <th>
            <xsl:attribute name="class">
                        <xsl:choose>
                         <xsl:when test="LINEASMULTIOFERTA/LINEASMULTIOFERTA_ROW[1]/LMO_CATEGORIA = 'F' and not(/Generar/MULTIOFERTAS/UTILIZAR_REFERENCIA_PROVEEDOR)">dies</xsl:when>
                         <xsl:when test="LINEASMULTIOFERTA/LINEASMULTIOFERTA_ROW[1]/LMO_CATEGORIA = 'F'  and /Generar/MULTIOFERTAS/UTILIZAR_REFERENCIA_PROVEEDOR">uno</xsl:when>
                         <xsl:when test="LINEASMULTIOFERTA/LINEASMULTIOFERTA_ROW[1]/LMO_CATEGORIA = 'N'">dies</xsl:when>
                        </xsl:choose>
                        </xsl:attribute>
                        
            	 		<xsl:choose>
                         <!--si es farmacia no veo ref prov, solo si es viamed5 veo ref prov-->
                         <xsl:when test="LINEASMULTIOFERTA/LINEASMULTIOFERTA_ROW[1]/LMO_CATEGORIA = 'F' and not(/Generar/MULTIOFERTAS/UTILIZAR_REFERENCIA_PROVEEDOR)">
                         	<xsl:value-of select="document($doc)/translation/texts/item[@name='ref_prov']/node()"/>
                         </xsl:when>
                         <!--si no es viamed5 no veo ref prov-->
                         <xsl:when test="LINEASMULTIOFERTA/LINEASMULTIOFERTA_ROW[1]/LMO_CATEGORIA = 'F'  and /Generar/MULTIOFERTAS/UTILIZAR_REFERENCIA_PROVEEDOR">
                         </xsl:when>
                         <xsl:when test="LINEASMULTIOFERTA/LINEASMULTIOFERTA_ROW[1]/LMO_CATEGORIA = 'N'">
                         	<xsl:value-of select="document($doc)/translation/texts/item[@name='ref_prov']/node()"/>
                             <!--si es asisa veo tb marca 
                               <xsl:if test="$OcultarPrecioReferencia='N'">
                                 <br /><xsl:value-of select="document($doc)/translation/texts/item[@name='marca']/node()"/>
                               </xsl:if>--> 
                        </xsl:when>
                 </xsl:choose>
            </th>
            <!--marca solo si es farmacia o asisa, para todos 26/06/12 mi-->
                    <th>
                    	<xsl:attribute name="class">
                        <xsl:choose>
                        	<xsl:when test="/Generar/MULTIOFERTAS/SIN_MARCA">uno</xsl:when>
                        	<xsl:when test="LINEA_ROW/PRODUCTOS/PRODUCTOS_ROW[1]/PRO_CATEGORIA = 'F'">veinte</xsl:when>
                         	<xsl:when test="LINEA_ROW/PRODUCTOS/PRODUCTOS_ROW[1]/PRO_CATEGORIA = 'N'">ocho</xsl:when>
                        </xsl:choose>
                        </xsl:attribute>
                    	
                        <!--<xsl:if test="LINEASMULTIOFERTA/LINEASMULTIOFERTA_ROW[1]/LMO_CATEGORIA = 'N' and $OcultarPrecioReferencia='N'">-->
                         <xsl:choose>
                           <xsl:when test="/Generar/MULTIOFERTAS/SIN_MARCA"></xsl:when>
                           <xsl:otherwise>
                        	<xsl:value-of select="document($doc)/translation/texts/item[@name='marca']/node()"/>
                           </xsl:otherwise>
                         </xsl:choose>
                       <!-- </xsl:if>-->
                    </th>
            <!-- ud base -->
            <th class="quince textLeft">
            	&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='ud_basica']/node()"/>
            </th>
            <!-- precio ud base -->
            <th class="cuatro">
            	<xsl:choose>
                <!--ASISA Y BRASIL VIEJO MODELO PRECIO PROV SIN IVA-->
                <xsl:when test="($nuevoModeloNegocio = 'N' and $pedidoAntiguo = 'N' and not(/Generar/MULTIOFERTAS/MOSTRAR_PRECIO_CON_IVA)) or /Generar/MULTIOFERTAS/IDPAIS = '55'">
                    <xsl:copy-of select="document($doc)/translation/texts/item[@name='precio_s_iva']/node()"/>
                </xsl:when>
                <!--VIAMED NUEVO VIEJO MODELO PERO VEO PRECIO PROV CON IVA-->
                 <xsl:when test="$nuevoModeloNegocio = 'N' and $pedidoAntiguo = 'N' and /Generar/MULTIOFERTAS/MOSTRAR_PRECIO_CON_IVA">
                    <xsl:copy-of select="document($doc)/translation/texts/item[@name='precio_c_iva']/node()"/>
                </xsl:when>
                <!--NUEVO MODELO VIEJO PEDIDO - SOLO ALICANTE...PRECIO FINAL-->
                <xsl:when test="$nuevoModeloNegocio = 'S' and $pedidoAntiguo = 'S'">
                    <xsl:copy-of select="document($doc)/translation/texts/item[@name='precio_final']/node()"/>
                </xsl:when>
                <!--NUEVO MODELO NUEVO PEDIDO - PARA VIAMED VIEJO, VENDRELL...VEO PRECIO FINAL--> 
                <xsl:when test="$nuevoModeloNegocio = 'S' and $pedidoAntiguo = 'N'">
                    <xsl:copy-of select="document($doc)/translation/texts/item[@name='precio_final_iva']/node()"/>
                </xsl:when>
                </xsl:choose>
                
            </th>
            <!-- cantidad -->
            <th class="cinco">
            	<xsl:value-of select="document($doc)/translation/texts/item[@name='unidades']/node()"/>
            </th>
          <!-- importe -->
            <th class="cinco">
           	 <xsl:choose>
                <!--ASISA Y BRASIL VIEJO MODELO PRECIO PROV SIN IVA-->
                <xsl:when test="($nuevoModeloNegocio = 'N' and $pedidoAntiguo = 'N' and not(/Generar/MULTIOFERTAS/MOSTRAR_PRECIO_CON_IVA)) or /Generar/MULTIOFERTAS/IDPAIS = '55'">
                    <xsl:copy-of select="document($doc)/translation/texts/item[@name='importe_s_iva']/node()"/>
                </xsl:when>
                <!--VIAMED NUEVO VIEJO MODELO PERO VEO PRECIO PROV CON IVA-->
                 <xsl:when test="$nuevoModeloNegocio = 'N' and $pedidoAntiguo = 'N' and /Generar/MULTIOFERTAS/MOSTRAR_PRECIO_CON_IVA">
                    <xsl:copy-of select="document($doc)/translation/texts/item[@name='total_c_iva_2line']/node()"/>
                </xsl:when>
                <!--NUEVO MODELO VIEJO PEDIDO - SOLO ALICANTE...PRECIO FINAL-->
                <xsl:when test="$nuevoModeloNegocio = 'S' and $pedidoAntiguo = 'S'">
                    <xsl:copy-of select="document($doc)/translation/texts/item[@name='total']/node()"/>
                </xsl:when>
                <!--NUEVO MODELO NUEVO PEDIDO - PARA VIAMED VIEJO, VENDRELL...VEO PRECIO FINAL--> 
                <xsl:when test="$nuevoModeloNegocio = 'S' and $pedidoAntiguo = 'N'">
                    <xsl:copy-of select="document($doc)/translation/texts/item[@name='total']/node()"/>
                </xsl:when>
                </xsl:choose>
            
				<!--<xsl:choose>
					<xsl:when test="$OcultarPrecioReferencia='N'">viejo modelo negocio
                    	<xsl:value-of select="document($doc)/translation/texts/item[@name='importe_s_iva']/node()"/>
					</xsl:when>
					<xsl:otherwise>
                    	<xsl:copy-of select="document($doc)/translation/texts/item[@name='total_c_iva_2line']/node()"/>
					</xsl:otherwise>
				</xsl:choose>-->
            </th>
         </tr>
         </thead>
				
    				<xsl:for-each select="LINEASMULTIOFERTA/LINEASMULTIOFERTA_ROW">
      				
                     <!--idioma-->
                        <xsl:variable name="lang">
                            <xsl:value-of select="../../../../LANG" />
                        </xsl:variable>
                        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
                      <!--idioma fin-->
                      
      				<xsl:variable name="usarGrupo">
                        	<xsl:choose>
                            <xsl:when test="/Generar/MULTIOFERTAS/UTILIZAR_GRUPO">S</xsl:when>
                            <xsl:otherwise>N</xsl:otherwise>
                            </xsl:choose>
                        </xsl:variable>
                        
							<xsl:choose>
								<xsl:when test="position()=1">
									<tr class="subCategorias">
										<th>&nbsp;</th>
                                        <th align="left" colspan="11">
                                        
                                                 <strong><span class="subfamilia">
														<xsl:choose>
															<xsl:when test="$usarGrupo = 'S' and GRUPO !=''">
																	<xsl:value-of select="SUBFAMILIA"/>&nbsp;>&nbsp;<xsl:value-of select="GRUPO"/>
															</xsl:when>
                                                            <xsl:when test="$usarGrupo = 'N' and SUBFAMILIA !=''">
																	<xsl:value-of select="SUBFAMILIA"/>
															</xsl:when>
															<xsl:otherwise>
                                                            	<xsl:if test="$usarGrupo = 'S'">
                                                                <!--es viamed5 enseño sin grupo-->
                                                                	<xsl:value-of select="document($doc)/translation/texts/item[@name='sin_grupo']/node()"/>
                                                                </xsl:if>
                                                                <xsl:if test="$usarGrupo = 'N'">
                                                                	<xsl:value-of select="document($doc)/translation/texts/item[@name='sin_subfamilia']/node()"/>
                                                                </xsl:if>
															</xsl:otherwise>
														</xsl:choose>
                                               </span></strong> 
									</th>
									</tr>
								</xsl:when>
								<xsl:otherwise>
                                	<xsl:choose>
                                	<xsl:when test="$usarGrupo = 'S' and GRUPO/ancestor::*[1]/ancestor::*[1]/ancestor::*[1]/preceding::*[2]/ancestor::*[1]/GRUPO!=GRUPO">
                                    	<tr class="subCategorias">
										<th>&nbsp;</th>
                                        <th align="left" colspan="11">
                                               <strong><span class="subfamilia">
														<xsl:choose>
															<xsl:when test="GRUPO !=''">
																	<xsl:value-of select="SUBFAMILIA"/>&nbsp;>&nbsp;<xsl:value-of select="GRUPO"/>
															</xsl:when>
															<xsl:otherwise>
                                                                <!--es viamed nuevo enseño sin familia-->
                                                                	<xsl:value-of select="document($doc)/translation/texts/item[@name='sin_grupo']/node()"/>
															</xsl:otherwise>
														</xsl:choose>
                                               </span></strong> 
											</th>
										</tr>
                                    </xsl:when>
                                	<!--<xsl:when test="$usarGrupo = 'N' and SUBFAMILIA/ancestor::*[1]/ancestor::*[1]/ancestor::*[1]/preceding::*[2]/ancestor::*[1]/SUBFAMILIA!=SUBFAMILIA">-->
                                    <xsl:when test="$usarGrupo = 'N' and CAMBIO_SUBFAMILIA ">
									<tr class="subCategorias">
										<th>&nbsp;</th>
                                        <th align="left" colspan="11">
                                               <strong><span class="subfamilia">
                                               
														<xsl:choose>
                                                            <xsl:when test="SUBFAMILIA !=''">
																<xsl:value-of select="SUBFAMILIA"/>
															</xsl:when>
															<xsl:otherwise>
                                                                	<xsl:value-of select="document($doc)/translation/texts/item[@name='sin_subfamilia']/node()"/>
															</xsl:otherwise>
														</xsl:choose>
                                               </span></strong> 
										</th>
									</tr>
									</xsl:when>
                                    </xsl:choose>
								</xsl:otherwise>
							</xsl:choose>
                            
					<!-- mostramos las lineas template LINEASMULTIOFERTA_ROW-->
      				<xsl:apply-templates select=".">
						<xsl:with-param name="OcultarPrecioReferencia" select="$OcultarPrecioReferencia"></xsl:with-param>     
                        <xsl:with-param name="nuevoModeloNegocio" select="$nuevoModeloNegocio"></xsl:with-param>     
                        <xsl:with-param name="pedidoAntiguo" select="$pedidoAntiguo"></xsl:with-param>     
					</xsl:apply-templates>
      				
    				</xsl:for-each>		
   
  </table><!--fin tabla productos-->
  
  <!--PARTE DE ABAJO-->
	<xsl:if test="$OcultarPrecioReferencia='S' or ($OcultarPrecioReferencia='N' and $nuevoModeloNegocio = 'S')">  
        <div class="divleft sombra">
        	<p>&nbsp;</p>
			<p style="text-align:right; margin-right:15px;"><xsl:value-of select="document($doc)/translation/texts/item[@name='comision_mvm_iva']/node()"/></p>
        </div><!--fin di divleft-->
	</xsl:if>
    <p>&nbsp;</p>

<!--AÑADIMOS PRODUCTOS MANUALES, NO EN PLANTILLA-->
    <xsl:if test="/Generar/MULTIOFERTAS/MANTENIMIENTO_MANUAL_PRODUCTOS">
    	<div class="divleft">
            <div class="divLeft20">
            	<div class="botonLargo">
            	<a href="javascript:VerProductosManuales();"><xsl:value-of select="document($doc)/translation/texts/item[@name='anadir_productos_manuales']/node()"/></a>
                </div>
            </div>
            <div class="divLeft80">&nbsp;</div>
        </div>
    </xsl:if>
    
<div class="divleft" id="divProductosManuales" style="display:none;">
<!--AÑADIMOS TABLA DE PRODUCTOS MANUALES, NO EN PLANTILLA-->
  <table class="encuesta" id="productosManuales" style="display:none;">
  <thead>
		<tr class="titulosNaranja">   
        	<!-- ref prove -->
            <td align="left" class="quince">
            	&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='ref_prov']/node()"/>
      		</td> 
           	<!-- producto descripcion-->
           	<td class="textLeft">
               
            	<xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/>
        	</td>
            <!-- ud base -->
            <td class="quince">
            	&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='ud_basica']/node()"/>
            </td>
            <!-- cantidad -->
            <td class="quince">
            	&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='cantidad']/node()"/>
            </td>
            <!-- precio ud base 
            <td class="dies">
                <xsl:copy-of select="document($doc)/translation/texts/item[@name='precio_final']/node()"/>
            </td>-->
            <!-- iva 
            <td class="dies">
            	<xsl:value-of select="document($doc)/translation/texts/item[@name='tipo_iva']/node()"/>
            </td>-->
            <!-- eliminar -->
            <td class="dies">&nbsp;</td>
            <td>&nbsp;</td>
         </tr>
    </thead>
    <tbody>
    </tbody>
    </table><!--fin de tabla añadir prod no en plantilla-->
    <!--añadir nuevo producto no en plantilla-->
    <table class="infoTableNara" border="0">
		<tr>   
            <th colspan="8" class="textLeft">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='anadir_productos_manuales']/node()"/></th>
         </tr>
    <tbody>
    		<input type="hidden" name="MOID" id="MOID" value="{/Generar/MULTIOFERTAS/MULTIOFERTAS_ROW/MO_ID}"/>
    		<td class="labelRight quince">
                <xsl:value-of select="document($doc)/translation/texts/item[@name='ref_prov']/node()"/>:&nbsp;
                <input type="text" name="REFPROVEEDOR" id="REFPROVEEDOR" size="10" />
            </td>
            <td class="labelRight">
            	<xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/>:&nbsp;
                <input type="text" name="DESCRIPCION" id="DESCRIPCION" size="40"/>
            </td>
            <td class="labelRight quince">
                <xsl:value-of select="document($doc)/translation/texts/item[@name='ud_basica']/node()"/>:&nbsp;
                <input type="text" name="UNIDADBASICA" id="UNIDADBASICA" size="10"/>
            </td>
            <td class="labelRight quince">
            	<xsl:value-of select="document($doc)/translation/texts/item[@name='cantidad']/node()"/>:&nbsp;
            	<input type="text" name="CANTIDAD" id="CANTIDAD" size="10"/>
            </td>
            <!--
            <td class="labelRight dies">
            	<xsl:value-of select="document($doc)/translation/texts/item[@name='precio']/node()"/>:&nbsp;
            	<input type="text" name="PRECIOUNITARIO" id="PRECIOUNITARIO" size="10"/>
            </td>
            <td class="labelRight dies">
            	<xsl:value-of select="document($doc)/translation/texts/item[@name='tipo_iva']/node()"/>:&nbsp;
            	<input type="text" name="TIPO_IVA" id="TIPO_IVA" size="5"/>
            </td>-->
            <td class="dies"><a href="javascript:AnadirProductosManuales();"><img src="http://www.newco.dev.br/images/botonAnadir.gif" alt="Añadir" /></a></td>
            <td>&nbsp;</td>
            <!--mensajeJS-->
            <input type="hidden" name="ERROR_INSERTAR_DATOS" value="{document($doc)/translation/texts/item[@name='error_insertar_datos']/node()}"/>
            <input type="hidden" name="ERROR_ELIMINAR_DATOS" value="{document($doc)/translation/texts/item[@name='error_eliminar_datos']/node()}"/>
            <input type="hidden" name="TODOS_CAMPOS_OBLI" value="{document($doc)/translation/texts/item[@name='todos_campos_obli']/node()}"/>
    </tbody>
    </table><!--fin de añadir nuevo producto no en plantilla-->
</div><!--fin de divProductosManuales-->
  
  
<xsl:choose>
    <xsl:when test="/Generar/MULTIOFERTAS/MULTIOFERTAS_ROW/REQUIERE_PRESUPUESTO = 'S'"><!--si requiere presupuesto no enseño precios-->
        <table class="encuesta gris" border="0" style="margin-top:20px;">
        <!-- Comentarios y Totales -->
            <tfoot>
            <tr> 
              <td rowspan="4" class="dos">&nbsp;</td>
              <td rowspan="4" colspan="2" class="trenta">
                  
                  <xsl:choose>
                    <xsl:when test="/Generar/MULTIOFERTAS/MINIMALISTA">
                        <!--si usuario minimalista no veo comentarios-->
                        <textarea name="COMENTARIO_{MO_ID}" cols="1000" rows="50" style="display:none;"><xsl:value-of select="COMENTARIOPORDEFECTO/COMENTARIO"/></textarea>
                        
                    </xsl:when>
                    <xsl:otherwise> 
                       <!--comentarios-->
                       <strong><xsl:value-of select="document($doc)/translation/texts/item[@name='puede_anadir_sus_comentarios']/node()"/></strong>&nbsp;&nbsp;
                        ( <xsl:call-template name="botonPersonalizado">
                                    <xsl:with-param name="label"><xsl:value-of select="document($doc)/translation/texts/item[@name='ver_comentarios']/node()"/></xsl:with-param>
                                    <xsl:with-param name="status">Comentarios</xsl:with-param>
                                    <xsl:with-param name="funcion">ultimosComentarios('COMENTARIO_<xsl:value-of select="MO_ID"/>','Principal','MULTIOFERTAS');</xsl:with-param>
                            </xsl:call-template> )
                        <br/> 
                        <textarea name="COMENTARIO_{MO_ID}" cols="1000" rows="50"><xsl:value-of select="COMENTARIOPORDEFECTO/COMENTARIO"/> </textarea>
                     
                    </xsl:otherwise>
                    </xsl:choose>
               </td>
            </tr>
            </tfoot>
        </table>
        <!--input hidden para presupuesto si no da error-->
        <input type="hidden" size="20" maxlength="100" name="NUMERO_OFERT_PED_{MO_ID}"/>
        <input type="hidden" name="URGENTE_{MO_ID}"/>
        <input type="hidden" name="SolicitaComercial{MO_ID}" onClick="ComercialOno(document.forms['Principal'],this,{MO_ID});" value="no"/>
        <input type="hidden" name="SolicitaMuestra{MO_ID}" value="no"/>
        <input type="hidden" name="NoComercial{MO_ID}" onClick="ComercialOno(document.forms['Principal'],this,{MO_ID});" value="no"/>
        
    </xsl:when>
    <xsl:otherwise>
        
        
    <!--tabla totales y comentarios normales-->
    <table class="encuesta gris" border="0" style="margin-top:20px;">
        <!-- Comentarios y Totales -->
    <tfoot>
        <xsl:if test="/Generar/MULTIOFERTAS/MULTIOFERTAS_ROW/MO_OBSERVACIONES != ''">
        <tr>
            <td class="dos">&nbsp;</td>
            <td colspan="6">
                <p style="margin-bottom:5px;"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='observaciones_pedidos']/node()"/>:</strong></p>
                <p style="margin-bottom:10px;border:1px solid #666;padding:2px;"><xsl:copy-of select="/Generar/MULTIOFERTAS/MULTIOFERTAS_ROW/MO_OBSERVACIONES" /></p>
            </td>
            <td>&nbsp;</td>
        </tr>
        </xsl:if>
    <tr> 
      <td rowspan="4" class="dos">&nbsp;</td>
      <td rowspan="4" colspan="2" class="trenta">
           <xsl:choose>
                    <xsl:when test="/Generar/MULTIOFERTAS/MINIMALISTA">
                        <!--si usuario minimalista no veo comentarios-->
                        <textarea name="COMENTARIO_{MO_ID}" cols="1000" rows="50" style="display:none;"><xsl:value-of select="COMENTARIOPORDEFECTO/COMENTARIO"/></textarea>
                        
                    </xsl:when>
                    <xsl:otherwise> 
                       <!--comentarios-->
                       <strong><xsl:value-of select="document($doc)/translation/texts/item[@name='puede_anadir_sus_comentarios']/node()"/></strong>&nbsp;&nbsp;
                        ( <xsl:call-template name="botonPersonalizado">
                                    <xsl:with-param name="label"><xsl:value-of select="document($doc)/translation/texts/item[@name='ver_comentarios']/node()"/></xsl:with-param>
                                    <xsl:with-param name="status">Comentarios</xsl:with-param>
                                    <xsl:with-param name="funcion">ultimosComentarios('COMENTARIO_<xsl:value-of select="MO_ID"/>','Principal','MULTIOFERTAS');</xsl:with-param>
                            </xsl:call-template> )
                        <br/> 
                        <textarea name="COMENTARIO_{MO_ID}" cols="1000" rows="50"><xsl:value-of select="COMENTARIOPORDEFECTO/COMENTARIO"/> </textarea>
                     
                    </xsl:otherwise>
                    </xsl:choose>
          
       </td>
       <td rowspan="4" class="dos">&nbsp;</td>
       <td rowspan="4" class="cuarenta">&nbsp;
       	<xsl:choose>
        <xsl:when test="$accion='DIRECTO'">
        	<p>
                    <!--si usuario minimalista no pedido urgente-->
                    <xsl:choose>
                    <xsl:when test="/Generar/MULTIOFERTAS/MINIMALISTA">
                        <input type="hidden" name="URGENTE_{MO_ID}"/>
                    </xsl:when>
                    <xsl:otherwise> 
                        <input type="checkbox" name="URGENTE_{MO_ID}"/>&nbsp;
	           	<strong><xsl:value-of select="document($doc)/translation/texts/item[@name='pedido_muy_urgente']/node()"/></strong>
                    </xsl:otherwise>
                    </xsl:choose>
	           	
                </p>
            <p>&nbsp;</p>
            <p>
            		<span class="rojo"><xsl:value-of select="document($doc)/translation/texts/item[@name='numero_pedido_interno']/node()"/>:&nbsp;</span>
	        		<input type="text" size="20" maxlength="100" name="NUMERO_OFERT_PED_{MO_ID}"/><!--<br />
            		>> <xsl:value-of select="document($doc)/translation/texts/item[@name='introducir_numero_pedido']/node()"/>-->
                   
            </p>
              <input type="hidden" name="SolicitaComercial{MO_ID}" value="no"/>
              <input type="hidden" name="SolicitaMuestra{MO_ID}" value="no"/>
              <input type="hidden" name="NoComercial{MO_ID}" value="no"/>
             
             <!--
              <xsl:if test="//MULTIOFERTAS/NUMERO_MULTIOFERTAS>1">
                <p>&nbsp;</p>
               <strong>
                 [&nbsp;<xsl:call-template name="botonPersonalizado">
                  <xsl:with-param name="funcion">ProgramarPedido(document.forms['Principal'],'CVGenerarSave.xsql',document.forms['PedidoMinimo'],'<xsl:value-of select="MO_ID"/>','PED_PROGRAMABLE_<xsl:value-of select="MO_ID"/>');</xsl:with-param>
                  <xsl:with-param name="label"><xsl:value-of select="document($doc)/translation/texts/item[@name='Programar']/node()"/></xsl:with-param>
                  <xsl:with-param name="status">Permite Programar el pedido</xsl:with-param>
                  <xsl:with-param name="identificador"><xsl:value-of select="MO_ID"/></xsl:with-param>
                </xsl:call-template>&nbsp;]	
                </strong>
		        </xsl:if>-->
              
        </xsl:when>
        <xsl:otherwise>
		  <p>
            	<span class="rojo"><xsl:value-of select="document($doc)/translation/texts/item[@name='numero_oferta']/node()"/>:&nbsp;</span>
	        	<input type="text" size="15" maxlength="100" name="NUMERO_OFERT_PED_{MO_ID}"/>&nbsp;
            	(<xsl:value-of select="document($doc)/translation/texts/item[@name='introducir_numero_oferta']/node()"/>).
           </p>
           <p>&nbsp;</p>
            <p>
          	<input type="hidden" name="URGENTE_{MO_ID}"/>
            </p>
            <p>
            <input type="checkbox" name="SolicitaComercial{MO_ID}" onClick="ComercialOno(document.forms['Principal'],this,{MO_ID});" value="no"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='solicitamos_comercial']/node()"/>
           </p>
           <p><input type="checkbox" name="SolicitaMuestra{MO_ID}" value="no"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='solicitamos_muestra']/node()"/>
          </p>
            <p><input type="checkbox" name="NoComercial{MO_ID}" onClick="ComercialOno(document.forms['Principal'],this,{MO_ID});" value="no"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='no_contacto_comercial']/node()"/>
            </p>
        </xsl:otherwise>
      </xsl:choose>
       </td>
      <td colspan="2">&nbsp;</td>
      
     </tr>
     
	<!--	2jun10	para el nuevo modelo de negocio no mostramos subtotal, para el viejo si (asisa si que ve)	-->
	<xsl:choose>
		<!--<xsl:when test="$OcultarPrecioReferencia='N'">modelo viejo-->
        <xsl:when test="$nuevoModeloNegocio = 'N'">
              <tr>
              	<!--vuelto a poner 27-11-13
                <xsl:attribute name="style">
                 <xsl:choose>
                    VIAMED NUEVO VIEJO MODELO PERO VEO PRECIO PROV CON IVA, quito de totales iva 30-10-13
                    <xsl:when test="$nuevoModeloNegocio = 'N' and $pedidoAntiguo = 'N' and /Generar/MULTIOFERTAS/MOSTRAR_PRECIO_CON_IVA">display:none;</xsl:when>
                    <xsl:otherwise>display:block;</xsl:otherwise>
                 </xsl:choose>
                </xsl:attribute>-->
                  
                  
                  
                
                  <td class="dies" align="right">
                    <strong><xsl:value-of select="document($doc)/translation/texts/item[@name='subtotal']/node()"/>:</strong>&nbsp;
                  </td>
                  <td align="right"> 
                    <xsl:choose>
                        <xsl:when test="MO_IMPORTETOTAL[.='']">
                            <input type="text" size="12" maxlength="12" class="noinput" style="text-align:right;" name="MO_IMPORTETOTAL_{MO_ID}" value="Por definir" onFocus="this.blur();"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <input type="text" size="12" maxlength="12" class="noinput" style="text-align:right;" name="MO_IMPORTETOTAL_{MO_ID}" value="{MO_IMPORTETOTAL}" onFocus="this.blur();"/>
                            <br />
                            
                        </xsl:otherwise>
                    </xsl:choose>
                  </td>   
                  <td class="tres">
                    <xsl:choose>
                      <xsl:when test="MO_IMPORTETOTAL[.='']">
                        &nbsp;
                      </xsl:when>
                      <xsl:otherwise>
                      	<xsl:if test="/Generar/MULTIOFERTAS/MULTIOFERTAS_ROW/IDPAIS = '55'">&nbsp;R$&nbsp;</xsl:if>
                        <xsl:if test="/Generar/MULTIOFERTAS/MULTIOFERTAS_ROW/IDPAIS != '55'">&nbsp;€&nbsp;</xsl:if>
                      </xsl:otherwise>
                    </xsl:choose>
                  </td>
              </tr>
            <!--</xsl:otherwise>
            </xsl:choose>
            fin choose si es brasil-->
          
		</xsl:when>
        <!--si es nuevo modelo-->
		<xsl:otherwise>
        	<input type="hidden" size="12" maxlength="12" class="noinput" style="text-align:right;" name="MO_IMPORTEIVA_{MO_ID}" value="{MO_IMPORTEIVA}"/>
            <input type="hidden" size="12" maxlength="12" class="noinput" style="text-align:right;" name="MO_IMPORTETOTAL_{MO_ID}" value="{MO_IMPORTETOTAL}" disabled="disabled"/>
            
		</xsl:otherwise>
	</xsl:choose>
    <!--	2jun10	para el nuevo modelo de negocio, no mostramos IVA, ya está incluido en el total-->
	<xsl:choose>
		<xsl:when test="$nuevoModeloNegocio = 'N'"><!--modelo viejo-->
        	<!--choose si es brasil no enseño, solo modelo nuevo en brasil-->
        	<xsl:choose>
            <xsl:when test="/Generar/MULTIOFERTAS/MULTIOFERTAS_ROW/IDPAIS = '55'">
            	<!--input hidden si es brasil-->
            	<xsl:choose>
        		  	<xsl:when test="MO_IMPORTEIVA[.='']">
            			<input type="hidden" size="12" maxlength="12" class="noinput" style="text-align:right;" name="MO_IMPORTEIVA_{MO_ID}" value="Por definir" onFocus="this.blur();"/>
        		  	</xsl:when> 
        		  	<xsl:otherwise>  
            			<input type="hidden" size="12" maxlength="12" class="noinput" style="text-align:right;" name="MO_IMPORTEIVA_{MO_ID}" value="{MO_IMPORTEIVA}" onFocus="this.blur();"/>
        		  	</xsl:otherwise>
        		</xsl:choose>
                		<tr>
    		  <td class="dies" align="right">
              <strong><xsl:value-of select="document($doc)/translation/texts/item[@name='trasporte']/node()"/>:</strong>&nbsp;
        		</td>       
    		  <td align="right">
        		<input type="text" class="noinput" name="COSTE_LOGISTICA_{MO_ID}" size="8" maxlength="12" style="text-align:right;" value="{/Generar/COSTE_LOGISTICA}" />
    		  </td>
    		  <td class="tres">
        			<xsl:if test="/Generar/MULTIOFERTAS/MULTIOFERTAS_ROW/IDPAIS = '55'">&nbsp;R$&nbsp;</xsl:if>
                    <xsl:if test="/Generar/MULTIOFERTAS/MULTIOFERTAS_ROW/IDPAIS != '55'">&nbsp;€&nbsp;</xsl:if>
    		  </td>
    		</tr>
                <!--fin de input hidden si es brasil-->
            </xsl:when>
            
            <!--si es asisa-->
            <xsl:otherwise>
            <input type="hidden" class="noinput" name="COSTE_LOGISTICA_{MO_ID}" size="8" maxlength="12" style="text-align:right;" value="0" />
           
    		<tr>
            	<!--vuelto a poner el 27-11-13
                <xsl:attribute name="style">
                 <xsl:choose>
                    VIAMED NUEVO VIEJO MODELO PERO VEO PRECIO PROV CON IVA, quito de totales iva 30-10-13
                    <xsl:when test="$nuevoModeloNegocio = 'N' and $pedidoAntiguo = 'N' and /Generar/MULTIOFERTAS/MOSTRAR_PRECIO_CON_IVA">display:none;</xsl:when>
                    <xsl:otherwise>display:block;</xsl:otherwise>
                 </xsl:choose>
                </xsl:attribute>-->
                
    		  <td class="dies" align="right">
              <strong><xsl:value-of select="document($doc)/translation/texts/item[@name='importe_iva']/node()"/>:</strong>&nbsp;
        		</td>       
    		  <td align="right">
        		<xsl:choose>
        		  	<xsl:when test="MO_IMPORTEIVA[.='']">
            			<input type="text" size="12" maxlength="12" class="noinput" style="text-align:right;" name="MO_IMPORTEIVA_{MO_ID}" value="Por definir" onFocus="this.blur();"/>
        		  	</xsl:when> 
        		  	<xsl:otherwise>  
            			<!--<xsl:value-of select="MO_IMPORTEIVA"/>-->
            			<input type="text" size="12" maxlength="12" class="noinput" style="text-align:right;" name="MO_IMPORTEIVA_{MO_ID}" value="{MO_IMPORTEIVA}" onFocus="this.blur();"/>
        		  	</xsl:otherwise>
        		</xsl:choose>
    		  </td>
    		  <td class="tres">
                <xsl:choose>
                      <xsl:when test="MO_IMPORTEIVA[.='']">
                        &nbsp;
                      </xsl:when>
                      <xsl:otherwise>
                      	<xsl:if test="/Generar/MULTIOFERTAS/MULTIOFERTAS_ROW/IDPAIS = '55'">&nbsp;R$&nbsp;</xsl:if>
                        <xsl:if test="/Generar/MULTIOFERTAS/MULTIOFERTAS_ROW/IDPAIS != '55'">&nbsp;€&nbsp;</xsl:if>
                      </xsl:otherwise>
                    </xsl:choose>
        		
    		  </td>
    		</tr>
           
            </xsl:otherwise>
            </xsl:choose>
          <!--fin de choose-->
		</xsl:when>
		<xsl:otherwise>
        <!--todos los demas-->
     	    <input type="hidden" class="noinput" name="COSTE_LOGISTICA_{MO_ID}" size="8" maxlength="12" style="text-align:right;" value="0"/>
        	<input type="hidden" size="12" maxlength="12" class="noinput" style="text-align:right;" name="MO_IMPORTEIVA_{MO_ID}" value="{MO_IMPORTEIVA}" />
           
              
		</xsl:otherwise>
	</xsl:choose>
    
    <!--importe final lo ven todos-->
	<tr>
    
    	   <td class="dies" align="right">
           
        	<strong><xsl:value-of select="document($doc)/translation/texts/item[@name='importe_total']/node()"/>:</strong>&nbsp;
        	</td>      
			<!--	6jul10 Este codigo reemplaza al comentado a continuación	--> 
    		  <td align="right">
             	 <xsl:choose>
                <!--ASISA Y BRASIL VIEJO MODELO PRECIO PROV SIN IVA-->
                <xsl:when test="($nuevoModeloNegocio = 'N' and $pedidoAntiguo = 'N' and not(/Generar/MULTIOFERTAS/MOSTRAR_PRECIO_CON_IVA)) or /Generar/MULTIOFERTAS/IDPAIS = '55'">
                	<xsl:choose>
                      <xsl:when test="MO_IMPORTETOTAL[.='']">
                            <input type="text" size="12" maxlength="12" class="noinput" style="text-align:right; color:#000000;" name="MO_IMPORTEFINAL_{MO_ID}" value="Por definir" onFocus="this.blur();"/>
                      </xsl:when> 
                      <xsl:otherwise>
                            <input type="text" size="12" maxlength="12" class="noinput" style="text-align:right; color:#000000;" name="MO_IMPORTEFINAL_{MO_ID}" value="{MO_IMPORTETOTAL}" onFocus="this.blur();"/>
                      </xsl:otherwise>
                    </xsl:choose>
                   
                </xsl:when>
                <!--VIAMED NUEVO VIEJO MODELO PERO VEO PRECIO PROV CON IVA-->
                 <xsl:when test="$nuevoModeloNegocio = 'N' and $pedidoAntiguo = 'N' and /Generar/MULTIOFERTAS/MOSTRAR_PRECIO_CON_IVA">
                    <xsl:choose>
                      <xsl:when test="MO_IMPORTETOTAL[.='']">
                            <input type="text" size="12" maxlength="12" class="noinput" style="text-align:right; color:#000000;" name="MO_IMPORTEFINAL_{MO_ID}" value="Por definir" onFocus="this.blur();"/>
                      </xsl:when> 
                      <xsl:otherwise>
                            <input type="text" size="12" maxlength="12" class="noinput" style="text-align:right; color:#000000;" name="MO_IMPORTEFINAL_{MO_ID}" value="{MO_IMPORTETOTAL}" onFocus="this.blur();"/>
                      </xsl:otherwise>
                    </xsl:choose>
                </xsl:when>
                <!--NUEVO MODELO VIEJO PEDIDO alicante...PRECIO FINAL-->
                <xsl:when test="$nuevoModeloNegocio = 'S' and $pedidoAntiguo = 'S'">
                   <xsl:choose>
                      <xsl:when test="MO_IMPORTEFINAL[.='']">
                            <input type="text" size="12" maxlength="12" class="noinput" style="text-align:right; color:#000000;" name="MO_IMPORTEFINAL_{MO_ID}" value="Por definir" onFocus="this.blur();"/>
                      </xsl:when> 
                      <xsl:otherwise>
                            <input type="text" size="12" maxlength="12" class="noinput" style="text-align:right; color:#000000;" name="MO_IMPORTEFINAL_{MO_ID}" value="{MO_IMPORTEFINAL}" onFocus="this.blur();"/>
                      </xsl:otherwise>
                    </xsl:choose>
                </xsl:when>
                <!--NUEVO MODELO NUEVO PEDIDO - PARA VIAMED VIEJO, VENDRELL...VEO PRECIO FINAL--> 
                <xsl:when test="$nuevoModeloNegocio = 'S' and $pedidoAntiguo = 'N'">
                   <xsl:choose>
                      <xsl:when test="MO_IMPORTEFINAL[.='']">
                            <input type="text" size="12" maxlength="12" class="noinput" style="text-align:right; color:#000000;" name="MO_IMPORTEFINAL_{MO_ID}" value="Por definir" onFocus="this.blur();"/>
                      </xsl:when> 
                      <xsl:otherwise>
                            <input type="text" size="12" maxlength="12" class="noinput" style="text-align:right; color:#000000;" name="MO_IMPORTEFINAL_{MO_ID}" value="{MO_IMPORTEFINAL}" onFocus="this.blur();"/>
                      </xsl:otherwise>
                    </xsl:choose>
                
                </xsl:when>
                </xsl:choose>
                
                <input type="hidden" size="12" maxlength="12" class="noinput" style="text-align:right;" name="OCULTO_PRECIO_REF_{MO_ID}" value="{$OcultarPrecioReferencia}" />
                <input type="hidden" size="12" maxlength="12" class="noinput" style="text-align:right;" name="NUEVO_MODELO_NEGOCIO_{MO_ID}" value="{$nuevoModeloNegocio}" />
                <input type="hidden" size="12" maxlength="12" class="noinput" style="text-align:right;" name="IVA_{MO_ID}" value="{MO_IMPORTEIVA}" />
    		  </td>
    	  <td class="tres">
          		<xsl:if test="/Generar/MULTIOFERTAS/MULTIOFERTAS_ROW/IDPAIS = '55'">&nbsp;R$&nbsp;</xsl:if>
                <xsl:if test="/Generar/MULTIOFERTAS/MULTIOFERTAS_ROW/IDPAIS != '55'">&nbsp;€&nbsp;</xsl:if>
        	
    	  </td>
	</tr>
    <xsl:choose>
		<xsl:when test="$OcultarPrecioReferencia='N'">&nbsp;</xsl:when>
        <xsl:otherwise>
        	<tr><td colspan="4">&nbsp;</td></tr>
            <tr><td colspan="4">&nbsp;</td></tr>
        </xsl:otherwise>
    </xsl:choose>
   
    <tr><td colspan="4">&nbsp;</td></tr>
    <tr><td colspan="4">&nbsp;</td></tr>
    </tfoot>
    </table>
      
    </xsl:otherwise><!--fin de condicion si es requiere presupuesto-->
    </xsl:choose><!--fin de condicion si es requiere presupuesto-->
    
  </xsl:for-each>   
</xsl:template>

<!--lineas de productos-->
<xsl:template match="LINEASMULTIOFERTA_ROW">
	<xsl:param name="OcultarPrecioReferencia"/>
    <xsl:param name="nuevoModeloNegocio"/>
    <xsl:param name="pedidoAntiguo"/>
    
	<xsl:variable name="lang">
        	<xsl:value-of select="//LANG" />
        </xsl:variable>
        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
        
				<tr>
                <!-- ref mvm-->
  				<td align="left">
            		&nbsp;
                	<xsl:choose>
                       <xsl:when test="LMO_CATEGORIA = 'F'">
                       		 <xsl:choose>
                                 <xsl:when test="REFERENCIACLIENTE != ''">
                                      <xsl:value-of select="REFERENCIACLIENTE"/>
                                 </xsl:when>
                                 <xsl:otherwise>
                                      <xsl:value-of select="PRO_REFERENCIA"/>   
                                 </xsl:otherwise>
                             </xsl:choose>
                       </xsl:when>
                       <xsl:when test="LMO_CATEGORIA = 'N'">
                       		 <xsl:choose>
                                  <xsl:when test="REFERENCIACLIENTE != ''">
                                       <xsl:value-of select="REFERENCIACLIENTE"/>
                                  </xsl:when>
                                  <xsl:when test="REFERENCIAPRIVADA!=''">
                                       <xsl:value-of select="REFERENCIAPRIVADA"/>   
                                  </xsl:when>
                             </xsl:choose>
                        </xsl:when>
                   </xsl:choose>
               
  				</td>
					<!-- nombre producto link -->
					<td style="padding-left:5px;">
                                           
                                            <xsl:if test="REQUIERE_PRESUPUESTO = 'S'">
                                                
                                                <span class="rojo">[<xsl:value-of select="document($doc)/translation/texts/item[@name='requiere_presupuesto']/node()"/>]</span>&nbsp;
                                            </xsl:if>
                    <xsl:choose>
          					<xsl:when test="NOMBREPRIVADO!=''">
                               <a style="text-decoration:none;">
  									<xsl:attribute name="href">javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Productos/PRODetalle.xsql?PRO_ID=<xsl:value-of select="LMO_IDPRODUCTO"/>&amp;SES_ID=<xsl:value-of select="//SES_ID"/>','producto',100,80,0,0)</xsl:attribute>
                                     <span class="strongAzul"><xsl:value-of select="NOMBREPRIVADO"/></span>
                                </a>
          					</xsl:when>
          					<xsl:otherwise>
            					<a style="text-decoration:none;">
                                     <xsl:attribute name="href">javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Productos/PRODetalle.xsql?PRO_ID=<xsl:value-of select="LMO_IDPRODUCTO"/>&amp;SES_ID=<xsl:value-of select="//SES_ID"/>','producto',100,80,0,0)</xsl:attribute>
  							
                                    <span class="strongAzul"><xsl:value-of select="PRO_NOMBRE"/></span>
                                </a>
          					</xsl:otherwise>
        			</xsl:choose>
        									
      			</td>
  				
  				<!--ref provee si normal, marca si farmacia-->
  				<td align="center">
                 <xsl:choose>
                   
                     <!--si es farmacia no veo ref prov, solo si es viamed5 veo ref prov-->
                     <xsl:when test="LMO_CATEGORIA = 'F' and not(/Generar/MULTIOFERTAS/UTILIZAR_REFERENCIA_PROVEEDOR)">
                         	 <xsl:value-of select="PRO_REFERENCIA"/>  
                     </xsl:when>
                     <!--si no es viamed5 no veo ref prov-->
                     <xsl:when test="LMO_CATEGORIA = 'F'  and /Generar/MULTIOFERTAS/UTILIZAR_REFERENCIA_PROVEEDOR">
                     </xsl:when>
                     <xsl:when test="LMO_CATEGORIA = 'N'">
                       <xsl:value-of select="PRO_REFERENCIA"/>  
                     </xsl:when>
                 </xsl:choose>
  				</td>
                <!--marca solo si es asisa-->
                <td class="center" style="font-size:11px;">
                <!--  <xsl:choose>
                      <xsl:when test="LMO_CATEGORIA = 'N' and $OcultarPrecioReferencia='N'">-->
                         <xsl:choose>
                           <xsl:when test="/Generar/MULTIOFERTAS/SIN_MARCA"></xsl:when>
                           <xsl:otherwise>
                         		<xsl:value-of select="PRO_MARCA"/>
                           </xsl:otherwise>
                         </xsl:choose>
                     <!-- </xsl:when>
                  </xsl:choose>-->
                 </td>                        
  				<!-- ud base -->
  				<td>
  					<xsl:value-of select="PRO_UNIDADBASICA" disable-output-escaping="yes"/>
  				</td>
  				<!-- precio -->
  				<td align="center">
                	 <xsl:choose>
                    <!--ASISA Y BRASIL VIEJO MODELO PRECIO PROV SIN IVA-->
                    <xsl:when test="($nuevoModeloNegocio = 'N' and $pedidoAntiguo = 'N' and not(/Generar/MULTIOFERTAS/MOSTRAR_PRECIO_CON_IVA)) or /Generar/MULTIOFERTAS/IDPAIS = '55'">
                        <xsl:value-of select="LMO_PRECIO"/>
                    </xsl:when>
                    <!--VIAMED NUEVO VIEJO MODELO PERO VEO PRECIO PROV CON IVA-->
                    <xsl:when test="$nuevoModeloNegocio = 'N' and $pedidoAntiguo = 'N' and /Generar/MULTIOFERTAS/MOSTRAR_PRECIO_CON_IVA">
                        <xsl:value-of select="TARIFA_CONIVA"/>
                    </xsl:when>
                    <!--NUEVO MODELO VIEJO PEDIDO alicante...PRECIO FINAL-->
                    <xsl:when test="$nuevoModeloNegocio = 'S' and $pedidoAntiguo = 'S'">
                        <xsl:value-of select="TARIFA_TOTAL"/>
                    </xsl:when>
                    <!--NUEVO MODELO NUEVO PEDIDO - PARA VIAMED VIEJO, VENDRELL...VEO PRECIO FINAL--> 
                    <xsl:when test="$nuevoModeloNegocio = 'S' and $pedidoAntiguo = 'N'">
                        <xsl:value-of select="TARIFA_TOTAL"/>
                    </xsl:when>
                    </xsl:choose>
  				</td>
  				<!-- cantidad -->
  				<td class="center">
  					<xsl:value-of select="LMO_CANTIDAD"/>
  				</td>
                <!--importe-->
                <td align="center">
                 <xsl:choose>
                <!--ASISA Y BRASIL VIEJO MODELO PRECIO PROV SIN IVA-->
                <xsl:when test="($nuevoModeloNegocio = 'N' and $pedidoAntiguo = 'N' and not(/Generar/MULTIOFERTAS/MOSTRAR_PRECIO_CON_IVA)) or /Generar/MULTIOFERTAS/IDPAIS = '55'">                    
                		<xsl:choose>
  							<xsl:when test="IMPORTE=''"> 
                                	<xsl:value-of select="document($doc)/translation/texts/item[@name='pedir_oferta']/node()"/>&nbsp;
  							</xsl:when>
  							<xsl:otherwise>       
  									<xsl:value-of select="IMPORTE"/>&nbsp;
  							</xsl:otherwise>
  						</xsl:choose>
                </xsl:when>
                <!--VIAMED NUEVO VIEJO MODELO PERO VEO PRECIO PROV CON IVA-->
                 <xsl:when test="$nuevoModeloNegocio = 'N' and $pedidoAntiguo = 'N' and /Generar/MULTIOFERTAS/MOSTRAR_PRECIO_CON_IVA">
                 		<xsl:choose>
  							<xsl:when test="TARIFA_TOTAL_CONIVA=''"> 
                                	<xsl:value-of select="document($doc)/translation/texts/item[@name='pedir_oferta']/node()"/>&nbsp;
  							</xsl:when>
  							<xsl:otherwise>       
  									<xsl:value-of select="TARIFA_TOTAL_CONIVA"/>&nbsp;
  							</xsl:otherwise>
  						</xsl:choose>
                </xsl:when>
                <!--NUEVO MODELO VIEJO PEDIDO alicante...PRECIO FINAL AQUI-->
                <xsl:when test="$nuevoModeloNegocio = 'S' and $pedidoAntiguo = 'S'">
                    	<xsl:choose>
  							<xsl:when test="LINEASUMAFINAL_FORMATO=''"> 
                                	<xsl:value-of select="document($doc)/translation/texts/item[@name='pedir_oferta']/node()"/>&nbsp;
  							</xsl:when>
  							<xsl:otherwise>       
  									<xsl:value-of select="LINEASUMAFINAL_FORMATO"/>&nbsp;
  							</xsl:otherwise>
  						</xsl:choose>
                </xsl:when>
                <!--NUEVO MODELO NUEVO PEDIDO - PARA VIAMED VIEJO, VENDRELL...VEO PRECIO FINAL--> 
                <xsl:when test="$nuevoModeloNegocio = 'S' and $pedidoAntiguo = 'N'">
                	 	<xsl:choose>
  							<xsl:when test="LINEASUMAFINAL_FORMATO=''"> 
                                	<xsl:value-of select="document($doc)/translation/texts/item[@name='pedir_oferta']/node()"/>&nbsp;
  							</xsl:when>
  							<xsl:otherwise>       
  									<xsl:value-of select="LINEASUMAFINAL_FORMATO"/>&nbsp;
  							</xsl:otherwise>
						</xsl:choose>
                </xsl:when>
                </xsl:choose>
                </td>
  				<!-- importe         
				<xsl:choose>
					<xsl:when test="$OcultarPrecioReferencia='N'">
  						<xsl:choose>
  							<xsl:when test="IMPORTE=''"> 
  								<td align="center">
                                	<xsl:value-of select="document($doc)/translation/texts/item[@name='pedir_oferta']/node()"/>
  									&nbsp;
  								</td>
  							</xsl:when>
  							<xsl:otherwise>       
  								<td align="center">
  									<xsl:value-of select="IMPORTE"/>&nbsp;
  								</td>
  							</xsl:otherwise>
  						</xsl:choose>
					</xsl:when>
					<xsl:otherwise>
  						<xsl:choose>
  							<xsl:when test="LINEASUMAFINAL_FORMATO=''"> 
  								<td align="center">
                                	<xsl:value-of select="document($doc)/translation/texts/item[@name='pedir_oferta']/node()"/>
  									&nbsp;
  								</td>
  							</xsl:when>
  							<xsl:otherwise>       
  								<td align="center">
  									<xsl:value-of select="LINEASUMAFINAL_FORMATO"/>&nbsp;
  								</td>
  							</xsl:otherwise>
						</xsl:choose>
					</xsl:otherwise>
				</xsl:choose>-->      
  			</tr>  
           
  		
</xsl:template> 

<xsl:template match="PROVEEDOR">
   <a>
   <xsl:attribute name="href">javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPDetalleFrame.xsql?EMP_ID=<xsl:value-of select="../MO_IDPROVEEDOR"/>&amp;VENTANA=NUEVA','empresa',100,80,0,0)</xsl:attribute> 
    <xsl:attribute name="onMouseOver">window.status='Información sobre la empresa.';return true;</xsl:attribute>
    <xsl:attribute name="onMouseOut">window.status='';return true;</xsl:attribute>
    <xsl:value-of select="." disable-output-escaping="yes"/>
   </a>
  </xsl:template>
  
<!--  templates de la nueva version  -->

<xsl:template name="direccion">
    <xsl:param name="path"/>
    <p class="textLeft">
    <input type="text" name="CEN_DIRECCION" size="50" value="{$path/CEN_DIRECCION}" style="text-align:left; margin-top:10px;" class="noinput" onFocus="this.blur();"/>
    <br />
   
    <!--spain-->
    <xsl:choose>
   <xsl:when test="/Generar/MULTIOFERTAS/MULTIOFERTAS_ROW/IDPAIS != '55'">
   <input type="text" name="CEN_CPOSTAL" size="5" value="{$path/CEN_CPOSTAL}" style="text-align:left;" class="noinput" onFocus="this.blur();"/>
   </xsl:when>
   <xsl:when test="/Generar/MULTIOFERTAS/MULTIOFERTAS_ROW/IDPAIS = '55'">
    <input type="text" name="CEN_CPOSTAL" size="10" value="{$path/CEN_CPOSTAL}" style="text-align:left;" class="noinput" onFocus="this.blur();"/>
   </xsl:when>
   </xsl:choose>
    -
    <input type="text" name="CEN_POBLACION" size="20" value="{$path/CEN_POBLACION}" style="text-align:left;" class="noinput" onFocus="this.blur();"/>
    
    <input type="hidden" name="CEN_PROVINCIA" size="30" value="{$path/CEN_PROVINCIA}" style="text-align:left;" class="noinput" onFocus="this.blur();"/>
    </p>
  </xsl:template>
  
<xsl:template name="FORMASPAGO">
	<xsl:call-template name="desplegable">
    	<xsl:with-param name="path" select="//MULTIOFERTAS/MULTIOFERTAS_ROW[1]/FORMASPAGO/field"></xsl:with-param>
    	<xsl:with-param name="defecto" select="//Generar/IDFORMAPAGO"/>
    </xsl:call-template>
</xsl:template>

<xsl:template name="PLAZOSPAGO">
  <xsl:param name="onChange"/>
	<xsl:call-template name="desplegable">
    	<xsl:with-param name="path" select="//MULTIOFERTAS/MULTIOFERTAS_ROW[1]/PLAZOSPAGO/field"></xsl:with-param>
    	<xsl:with-param name="defecto" select="//Generar/IDPLAZOPAGO"/>
    	<xsl:with-param name="onChange"><xsl:value-of select="$onChange"/></xsl:with-param>
    </xsl:call-template>
</xsl:template>

<!-- fin templates de la nueva version-->

</xsl:stylesheet>

