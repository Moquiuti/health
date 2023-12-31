<?xml version="1.0" encoding="iso-8859-1" ?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href = "http://www.newco.dev.br/General/General.xsl" />
  <xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
  <xsl:param name="lang" select="@lang"/>  
  <xsl:template match="/">
    <html>
      <head>
        
	<title>Pedidos Programados - Datos guardados correctamente</title>
     <!--style-->
      <xsl:call-template name="estiloIndip"/>
     <!--fin de style-->  
    <script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>
    
	<xsl:text disable-output-escaping="yes"><![CDATA[
	
	<script type="text/javascript">
	  <!--

	   
	   
	   function CerrarVentana(){
	   
	     ]]></xsl:text> 
	     
         <xsl:choose>
           <xsl:when test="//VENTANA='NUEVA'"> 
           
       <xsl:text disable-output-escaping="yes"><![CDATA[     

            if(window.parent.opener && !window.parent.opener.closed){
              var objFrameTop=new Object();          
              objFrameTop=window.parent.opener.top;   
              var FrameOpenerName=window.parent.opener.name;
              var objFrame=new Object();
              objFrame=obtenerFrame(objFrameTop,FrameOpenerName);
              if(objFrame!=null && objFrame.recargarPagina){
                objFrame.recargarPagina();
              }
              else{
                Refresh(objFrame.document);
              }  	
            }
            window.parent.close(); 
         
        ]]></xsl:text>
          
          </xsl:when>
          <xsl:otherwise>
          
        <xsl:text disable-output-escaping="yes"><![CDATA[
            
            document.location.href='about:blank';
            
        ]]></xsl:text>
            
          </xsl:otherwise>
        </xsl:choose>
        
        <xsl:text disable-output-escaping="yes"><![CDATA[
     }
	   
	  //-->
	</script>
        ]]></xsl:text>
      </head>
      <body class="gris">      
        <xsl:choose>
          <xsl:when test="ListaDerechosUsuarios/xsql-error">
            <xsl:apply-templates select="ListaDerechosUsuarios/xsql-error"/>          
          </xsl:when>
        <xsl:when test="PedidosProgramados/SESION_CADUCADA">
          <xsl:apply-templates select="FamiliasYProductos/SESION_CADUCADA"/> 
        </xsl:when>
        <xsl:when test="PedidosProgramados/ROWSET/ROW/Sorry">
          <xsl:apply-templates select="PedidosProgramados/ROWSET/ROW/Sorry"/> 
        </xsl:when>
        <xsl:otherwise>
			    
			    
			    <xsl:choose>
			    <xsl:when test="PedidosProgramados/EDITAR_FECHAS='S'">
			      <meta http-equiv="Refresh">
              <xsl:attribute name="content">0; URL=http://www.newco.dev.br/Compras/PedidosProgramados/LanzamientosPedidosProgramados.xsql?IDUSUARIO=<xsl:value-of select="/PedidosProgramados/IDUSUARIOCONSULTA"/>&amp;PEDP_ID=<xsl:value-of select="/PedidosProgramados/PEDP_ID"/>&amp;FECHAACTIVA=<xsl:value-of select="/PedidosProgramados/FECHANO_ENTREGA"/>&amp;VENTANA=NUEVA&amp;ACCION=LanzamientosPedidosProgramadosSave.xsql&amp;ACTUALIZARPAGINA=<xsl:value-of select="/PedidosProgramados/ACTUALIZARPAGINA"/>&amp;TITULO=Programación manual&amp;DESDEOFERTA=<xsl:value-of select="PedidosProgramados/DESDEOFERTA"/></xsl:attribute>
            </meta>
          </xsl:when>
          <xsl:otherwise>
			<!--idioma-->
            <xsl:variable name="lang">
                <xsl:choose>
                <xsl:when test="/PedidosProgramados/LANG != ''"><xsl:value-of select="/PedidosProgramados/LANG" /></xsl:when>
                </xsl:choose>  
            </xsl:variable>
            <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
            <!--fin idioma-->
         
			       <h1 class="titlePage">
			          <xsl:value-of select="document($doc)/translation/texts/item[@name='ped_programados_datos_guardados']/node()"/>
			       </h1>
			       <div class="divLeft">
                   
			        <xsl:if test="PedidosProgramados/DESDEOFERTA='S'">
			        <br /><br />
			        <h3 align="center">
                    	<xsl:value-of select="document($doc)/translation/texts/item[@name='consultar_pedidos_programados']/node()"/>
			        </h3> 
			        </xsl:if>
			       <br /><br />
                   
                   <div class="divCenter10">
                   <div class="boton">
                   	<a href="javascript:window.close();">
                    	<xsl:value-of select="document($doc)/translation/texts/item[@name='cerrar']/node()"/>
                    </a>
              	   </div>
                   </div>
              
              </div><!--fin de divleft-->
            </xsl:otherwise>
          </xsl:choose>
          
        </xsl:otherwise>
      </xsl:choose>
      </body>
    </html>
  </xsl:template>  
</xsl:stylesheet>
