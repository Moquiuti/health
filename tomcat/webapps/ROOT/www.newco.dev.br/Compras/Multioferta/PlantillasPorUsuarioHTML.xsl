<?xml version="1.0" encoding="iso-8859-1" ?>
<!--
 |	Estadisticas de acceso de los usuarios en MedicalVM
 |
 |	(c) 12/1/2001 ET
 |	
 +-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href = "http://www.newco.dev.br/General/General.xsl" />
  <xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
  <xsl:param name="lang" select="@lang"/>  
  <xsl:template match="/">
    <html>
      <head>
      <!--idioma-->
	<xsl:variable name="lang">
		<xsl:value-of select="/Generar/LANG"/>
	</xsl:variable>
	<xsl:value-of select="$lang"/>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->
	<title><xsl:value-of select="TITULO" disable-output-escaping="yes"/></title>

	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->

	<xsl:text disable-output-escaping="yes"><![CDATA[
    <script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/ajax.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>
	
	<script type="text/javascript">
		
	  <!--
	  
	    function EjecutarFuncionDelFrame(nombreFrame,idPlantilla){
	      var objFrame=new Object();
	      objFrame=obtenerFrame(top, nombreFrame);
	      objFrame.CambioPlantillaExterno(idPlantilla);
	    }
		
		 function CerrarProdUs(idUsuario){
			 jQuery("#prodUsuario_"+idUsuario).hide();
		 }
		 
		 //function productos por usuario
         function ProductosPorUsuario(idUsuario){
     			var formJS = document.forms['mensajeJS'];
				var prodOcultos = formJS.elements['PROD_OCULTOS'].value;
				var prodVisibles = formJS.elements['PROD_VISIBLES'].value;
				
				jQuery(".divProdUs").hide();				
				
                if (idUsuario != ''){
                    jQuery.ajax({
                    cache:	false,
                    url:	'ProductosPorUsuario.xsql',
                    type:	"GET",
                    data:	"ID_USUARIO="+idUsuario,
                    contentType: "application/xhtml+xml",
                    error: function(objeto, quepaso, otroobj){
                        alert('error'+quepaso+' '+otroobj+''+objeto);
                    },
                    success: function(objeto){
                        var data = eval("(" + objeto + ")");
						
            			//alert(data.ProductosPorUsuario[0]);
						//alert(data.ProductosPorUsuario[1]);

                        if(data.ProductosPorUsuario[0].prodVis != ''){
							//si prod visibles es 0 entonces no enseño link a buscador
							if (data.ProductosPorUsuario[0].prodVis != '0'){
								var prodVisText = '<p style="float:right;"><a href="javascript:CerrarProdUs('+idUsuario+');"><img src="http://www.newco.dev.br/images/cerrar.gif" /></a></p><p style="font-weight:bold;line-height:24px;">'+prodVisibles+': '+data.ProductosPorUsuario[0].prodVis+'&nbsp;&nbsp;<a href="javascript:MostrarPagPersonalizada(\'http://www.newco.dev.br/Compras/Multioferta/BuscadorCatalogoPrivado.xsql?DONDE_SE_BUSCA=PLA&IDUSUARIOCOMPROBAR='+idUsuario+'\',\'Buscador Plantillas\',100,75,0,-10);"><img src="http://www.newco.dev.br/images/info.gif" style="vertical-align:middle;" /></a><br />';
							}
							else{
								var prodVisText = '<p style="float:right;"><a href="javascript:CerrarProdUs('+idUsuario+');"><img src="http://www.newco.dev.br/images/cerrar.gif" /></a></p><p style="font-weight:bold;line-height:24px;">'+prodVisibles+': '+data.ProductosPorUsuario[0].prodVis+'<br />';
							}
							//si prod ocultos es 0 entonces no enseño link a buscador
							if (data.ProductosPorUsuario[1].prodOcu != '0'){
								var prodOcuText = prodOcultos+': '+data.ProductosPorUsuario[1].prodOcu+'&nbsp;&nbsp;<a href="javascript:MostrarPagPersonalizada(\'http://www.newco.dev.br/Compras/Multioferta/BuscadorCatalogoPrivado.xsql?DONDE_SE_BUSCA=PLA&IDUSUARIOCOMPROBAR='+idUsuario+'&SOLO_OCULTOS=S\',\'Buscador Plantillas\',100,75,0,-10);"><img src="http://www.newco.dev.br/images/info.gif" style="vertical-align:middle;" /></a>';
							}
							else{
								var prodOcuText = prodOcultos+': '+data.ProductosPorUsuario[1].prodOcu;
							}
							
							jQuery("#prodUsuario_"+idUsuario).html(prodVisText + prodOcuText + '<br /><a href="javascript:DerechosProductosUsuario(\'OCULTARNOCOMPRADOS\','+idUsuario+');">Ocultar productos no comprados</a><br /><a href="javascript:DerechosProductosUsuario(\'OCULTARTODOS\','+idUsuario+');">Ocultar todos</a><br /><a href="javascript:DerechosProductosUsuario(\'MOSTRARTODOS\','+idUsuario+');">Mostrar Todos</a></p>');
													
							jQuery("#prodUsuario_"+idUsuario).show(); 
							
                        }else{
                            alert('error');
                        }
                    }
                    });//fin jquery
            	}
               
            }//fin de ProductosPorUsuario
		
		 
		 
		 
		function DerechosProductosUsuario(accion, idUsuario )
		{
			var formJS = document.forms['mensajeJS'];
			
			if (idUsuario!=''){
				  jQuery.ajax({
                    cache:	false,
                    url:	'OcultarMostrarProductos.xsql',
                    type:	"GET",
                    data:	"ACCION="+accion+"&ID_USUARIO="+idUsuario,
                    contentType: "application/xhtml+xml",
                    error: function(objeto, quepaso, otroobj){
                        alert('error'+quepaso+' '+otroobj+''+objeto);
                    },
                    success: function(objeto){
                        var data = eval("(" + objeto + ")");
            			//alert(data.OcultarMostrarProductos.res);
                        if(data.OcultarMostrarProductos.res == 'Ocultar no comprados'){
                        	jQuery("#prodUsuario_"+idUsuario).html('<p style="float:right;"><a href="javascript:CerrarProdUs('+idUsuario+');"><img src="http://www.newco.dev.br/images/cerrar.gif" /></a></p><p style="margin-top:40px; font-weight:bold;">'+formJS.elements['OCULTAR_NO_COMPRADOS_OK'].value+'</p>');
							document.location.reload(true)
                        }
						else if(data.OcultarMostrarProductos.res == 'Ocultar'){
                        	jQuery("#prodUsuario_"+idUsuario).html('<p style="float:right;"><a href="javascript:CerrarProdUs('+idUsuario+');"><img src="http://www.newco.dev.br/images/cerrar.gif" /></a></p><p style="margin-top:40px; font-weight:bold;">'+formJS.elements['OCULTAR_OK'].value+'</p>');
							document.location.reload(true)
                        }
						else if(data.OcultarMostrarProductos.res == 'Mostrar'){
                        	jQuery("#prodUsuario_"+idUsuario).html('<p style="float:right;"><a href="javascript:CerrarProdUs('+idUsuario+');"><img src="http://www.newco.dev.br/images/cerrar.gif" /></a></p><p style="margin-top:40px; font-weight:bold;">'+formJS.elements['MOSTRAR_OK'].value+'</p>');
							document.location.reload(true)
                        }
						else{
                            alert('error');
                        }
                    }
                    });//fin jquery
			}
			else alert('Falta seleccionar el usuario.');
		}

		
	  //-->
	</script>
        ]]></xsl:text>
      </head>
      <body>      
        <xsl:choose>
      	<!-- ET Desactivado control errores: Habra que reactivarlo
          <xsl:when test="ListaDerechosUsuarios/xsql-error">
            <xsl:apply-templates select="ListaDerechosUsuarios/xsql-error"/>          
          </xsl:when>
	-->
        <xsl:when test="PlantillasPorUsuario/SESION_CADUCADA">
          <xsl:apply-templates select="CarpetasYPlantillas/SESION_CADUCADA"/> 
        </xsl:when>
        <xsl:when test="PlantillasPorUsuario/ROWSET/ROW/Sorry">
          <xsl:apply-templates select="CarpetasYPlantillas/ROWSET/ROW/Sorry"/> 
        </xsl:when>
        <xsl:otherwise>
		<br/><br/>
     	
         <!--idioma-->
         <xsl:variable name="lang">
        <xsl:choose>
            <xsl:when test="/PlantillasPorUsuario/LANG"><xsl:value-of select="/PlantillasPorUsuario/LANG" /></xsl:when>
            <xsl:otherwise>spanish</xsl:otherwise>
            </xsl:choose>  
        </xsl:variable>

        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>      <!--idioma fin-->
         
		<table class="grandeInicio" border="0">
        <thead>
			<tr class="tituloTabla">
                <th>&nbsp;</th>
				<th colspan="6"><xsl:value-of select="document($doc)/translation/texts/item[@name='plantillas_por_usuario']/node()"/></th>
                <th>&nbsp;</th>
			</tr>
            <tr class="titulos">
            	<td class="dies">&nbsp;</td>
                <td class="dies"><xsl:value-of select="document($doc)/translation/texts/item[@name='bloqueado']/node()"/></td>
                <td class="veinte textLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='usuario']/node()"/></td>
                <td class="veinte textLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='centro']/node()"/></td>
                <td class="dies textLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='plantillas_visibles']/node()"/></td>
                <td class="dies textLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='plantillas_ocultas']/node()"/></td>
                <td class="dies textLeft"></td>
                <td>&nbsp;</td>
			</tr>
            
            </thead>
            <tbody>
         
		  <xsl:for-each select="PlantillasPorUsuario/LISTA_USUARIOS/USUARIO">
            <tr>
            	<td>&nbsp;</td>
                <td>
                    <xsl:if test="BLOQUEADO = 'S'"><img src="http://www.newco.dev.br/images/urgente.gif" alt="Bloqueado" /></xsl:if>
                </td>                
                <td class="textLeft">
               		<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/CARPyPLManten.xsql?ID_USUARIO={US_ID}','Derechos plantilla',60,85,0,-10);">
                	<xsl:value-of select="USUARIO" /></a>
                </td>
                <td class="textLeft">
                	<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/CENDetalle.xsql?ID={CEN_ID}','Centro',60,35,0,-10);">
                    <xsl:value-of select="CENTRO" /></a>
                </td>
                <td><xsl:value-of select="VISIBLES" /></td>
                <td><a href="javascript:ProductosPorUsuario({US_ID});"><img src="http://www.newco.dev.br/images/info.gif" alt="info" width="15px;" /></a>
                    <div id="prodUsuario_{US_ID}" class="divProdUs" style="position:absolute; left:40%; width:250px; height:120px; border:2px solid grey; background:#FFF;  padding:5px; display:none;"></div>
                </td>
                <!--<td class="cinco textLeft"><xsl:if test="PRODUCTOS_OCULTOS != '0'">&nbsp;<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Compras/Multioferta/BuscadorCatalogoPrivado.xsql?DONDE_SE_BUSCA=PLA&amp;IDUSUARIOCOMPROBAR={US_ID}&amp;SOLO_OCULTOS=S','Buscador Plantillas',60,85,0,-10);"><img src="http://www.newco.dev.br/images/info.gif" alt="info" width="15px;" /></a></xsl:if></td>-->
                <td>&nbsp;</td>
			</tr>
		  </xsl:for-each> 
          </tbody>	
         
		</table>
        
        <form name="mensajeJS">
        <input type="hidden" name="PROD_OCULTOS" value="{document($doc)/translation/texts/item[@name='productos_ocultos']/node()}"/>
        <input type="hidden" name="PROD_VISIBLES" value="{document($doc)/translation/texts/item[@name='productos_visibles']/node()}"/>
        <input type="hidden" name="OCULTAR_OK" value="{document($doc)/translation/texts/item[@name='ocultar_ok']/node()}"/>
        <input type="hidden" name="MOSTRAR_OK" value="{document($doc)/translation/texts/item[@name='mostrar_ok']/node()}"/>
        <input type="hidden" name="OCULTAR_NO_COMPRADOS_OK" value="{document($doc)/translation/texts/item[@name='ocultar_no_comprados_ok']/node()}"/>
        </form>
        </xsl:otherwise>
        </xsl:choose>
      </body>
    </html>
  </xsl:template>  
</xsl:stylesheet>
