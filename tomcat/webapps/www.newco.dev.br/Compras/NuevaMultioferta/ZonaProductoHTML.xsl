<?xml version="1.0" encoding="iso-8859-1" ?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href = "http://www.newco.dev.br/General/General.xsl" />
  
  <xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
  <xsl:param name="lang" select="@lang"/>  
  <xsl:template match="/">
    <html>
      <head>
     
        <!--style-->
      <xsl:call-template name="estiloIndip"/>
      <!--fin de style-->  	
       <xsl:text disable-output-escaping="yes"><![CDATA[
     <script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
	 <script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>
     
	
		
 		<script type="text/javascript">
		
		<!--
		
		var msgMuchosProductosEnLaPlantilla='El número de artículos ocultos es elevado, por lo que verlos todos puede tardar.\nDesea continuar? (puede hacer la misma modificación contactando directamente con MedicalVM)';

		
		

		function InsertarProducto(idProducto)
		{ 
		 	var pl_actual = document.forms['envio'].elements['IDPLANTILLA'].value;
	  		if (pl_actual==-1)
	  			alert(msgSinPlantilla);
			else
			{
				EnviarCambios('INSERTARPRODUCTO', idProducto);
			}
		}
		
        function BorrarProducto(accion, idProducto){
          var objFrame=new Object();
          objFrame=obtenerFrame(top,'zonaPlantilla');
          //27mar08	ET	Los botones solo se muestran si el usuario tiene derecho a realizar la acción
		  //if(objFrame.BorrarProducto())
		  {
            var carp_id=document.forms['envio'].elements['IDCARPETA'].value;
            var pl_id=document.forms['envio'].elements['IDPLANTILLA'].value;
            document.location.href='ZonaProducto.xsql?IDCARPETA='+carp_id+'&IDPLANTILLA='+pl_id+'&IDPRODUCTO='+idProducto+'&ACCION='+accion;
            
            //   actualizamos los frames que esten cargados (plantilla del producto recien borrado)
              var objFrame=new Object();
              var laUrl;
              objFrame=obtenerFrame(top,'zonaTrabajo');
              if(objFrame!=null)
			  {
                laUrl=String(objFrame.location.href);
                if(laUrl.match('LPLista.xsql') && laUrl.match('PL_ID='+document.forms['envio'].elements['IDPLANTILLA'].value))
				{
     	          Refresh(objFrame);
     	        }
              }
           }
        }
     	
     	function EnviarCambios(accion, idProducto)
		{
     	  if(document.forms['envio'].elements['IDPLANTILLA'])
     	    var pl_actual = document.forms['envio'].elements['IDPLANTILLA'].value;
     	  if(document.forms['envio'].elements['IDCARPETA'])  
     	    var carp_actual = document.forms['envio'].elements['IDCARPETA'].value;

			
     	   document.forms['envio'].elements['ACCION'].value=accion;
	   document.forms['envio'].elements['IDPRODUCTO'].value=idProducto;
	    
     	    
     	    var laUrl;
     	    var nombreFrame;
     	    var actualizarFrame=0;
     	    var frameARecargar='PaginaEnBlanco.xsql';
     	    
     	    if(top.mainFrame.areaTrabajo.zonaTrabajo){
     	      laUrl=top.mainFrame.areaTrabajo.zonaTrabajo.location;
     	      nombreFrame='zonaTrabajo';
     	    }
     	    else{
     	      if(top.mainFrame.areaTrabajo){
     	        laUrl=top.mainFrame.areaTrabajo.location;
     	        nombreFrame='areaTrabajo';
     	        frameARecargar='AreaTrabajo.html';
     	      }
     	    }

     	    laUrl=String(laUrl);
     	    
     	    
     	    /*
     	        si en el frame derecho esta cargada alguna pagina
     	        que debemos que esta afectada por la accion a ejecutar (borrado de carpetas, plantillas o productos)
     	        actualizamos este frame
     	    */
     	    
     	    /*
     	      alert('carpeta nueva: '+document.forms['envio'].elements['IDNUEVACARPETA'].value+'\n'
     	          +' plantilla nueva: '+document.forms['envio'].elements['IDNUEVAPLANTILLA'].value+'\n'
     	          +' accion: '+document.forms['envio'].elements['ACCION'].value+'\n'
     	          +' producto: '+document.forms['envio'].elements['IDPRODUCTO'].value);
     	     */ 
     	        
     	    
     	    
     	    
     	    /*
     	       a veces se produce un error de productos 
     	       duplicados en la plantilla, no sabemos si es un problema de oracle o de javascript
     	       en el campo FECHA enviamos los milisegundos a la hora de hacer el envio.
     	    
     	    */
     	    
     	    var miFecha=new Date();
     	    document.forms['envio'].elements['FECHA'].value=' los milisegundos: '+ miFecha.getMilliseconds();
     	          
     	    
     	    
     	    if(accion=='BORRARPRODUCTO'){
     	      if(laUrl.match('LPLista.xsql') && laUrl.match('PL_ID='+pl_actual)){
     	        //MostrarPlantilla();
     	        actualizarFrame=1;
     	      }
     	    }
     	    else{
     	      if(accion=='BORRARCARPETA'){
     	        if(laUrl.match('CARPManten.xsql') && laUrl.match('CARP_ID='+carp_actual)){
     	          actualizarFrame=1; 
     	        }
     	        else{
     	          if(laUrl.match('PLManten.xsql')){
     	            actualizarFrame=1;
     	          }
     	          else{
     	            if(laUrl.match('LPLista.xsql')){
     	              actualizarFrame=1;
     	            }
     	          }
     	        }
     	      } 
     	      else{
     	        if(accion=='BORRARPLANTILLA'){
     	          if(laUrl.match('PLManten.xsql') && laUrl.match('PL_ID='+pl_actual)){
     	            actualizarFrame=1;
     	          }
     	          else{
     	            if(laUrl.match('LPLista.xsql') && laUrl.match('PL_ID='+pl_actual)){
     	              actualizarFrame=1;
     	            }
     	          }
     	        }
     	      }
     	    }

     	    SubmitForm(document.forms['envio']);
     	    
     	    /*
     	      si hemos de recargar lo hacemos
     	    */
     	    
     	    if(actualizarFrame)
     	      if(nombreFrame=='areaTrabajo')
     	        top.mainFrame.areaTrabajo.location=frameARecargar;
     	      else
     	        if(nombreFrame=='zonaTrabajo')
     	          top.mainFrame.areaTrabajo.zonaTrabajo.location=frameARecargar;	
	  }
	  
	  
	  
	function MostrarPlantilla(nombreFrame){
	  ]]></xsl:text>
	    var maxVisibles='<xsl:value-of select="//ZonaProducto/PRODUCTOS/MAX_VISIBLES"/>';
	    var totalEnLaPlantilla='<xsl:value-of select="//ZonaProducto/PRODUCTOS/TOTAL_EN_LA_PLANTILLA"/>';
	  <xsl:text disable-output-escaping="yes"><![CDATA[
	  
	  //solodebug alert('nombreFrame:'+nombreFrame);
	  
	  if(parseInt(maxVisibles)>0)
	  {
	    if(parseInt(totalEnLaPlantilla)>parseInt(maxVisibles))
		{
	      if(confirm(msgMuchosProductosEnLaPlantilla))
		  {
	        var objFrame=new Object();
			
     	       // ET 4may16 objFrame=obtenerFrame(window.parent.frames[1],nombreFrame);
     	        objFrame=obtenerFrame(top,nombreFrame);
     	        objFrame.MostrarPlantilla();
			   //22feb17parent.nombreFrame.MostrarPlantilla();
	      }
	    }
	    else{
	      var objFrame=new Object();
			// ET 4may16 objFrame=obtenerFrame(window.parent.frames[1],nombreFrame);
			
			objFrame=obtenerFrame(top,nombreFrame);
			objFrame.MostrarPlantilla();
			//22feb17parent.nombreFrame.MostrarPlantilla();
	    }
	  }
	  else{
	    var objFrame=new Object();
     	    //7feb17	objFrame=obtenerFrame(window.parent.frames[1],nombreFrame);
     	    // ET 4may16 objFrame=obtenerFrame(window.parent.frames[1],nombreFrame);
			
     	   objFrame=obtenerFrame(top,nombreFrame);
     	   objFrame.MostrarPlantilla();	
			//22feb17parent.nombreFrame.MostrarPlantilla();
	  }
	}
	
	
	
	/*
	  funcion para controlar que el producto que se quiere insertar no existe ya en la plantilla.
	  si existe se avisa al usuario y no se somete la accion
	  
	  en caso contrario seguimos
	*/
	
	function sinoExisteEnPlantillaEnviarCambios(accion,idProducto){
	  var objFrame=new Object();
      
	  objFrame=obtenerFrame(top,'zonaPlantilla');
		  
	  if(objFrame.existePlantilla>0)
	  {
	    if(objFrame.privilegiosPlantilla)
		{
	      for(var n=0;n<document.forms['productos'].length;n++)
		  {
	        if(document.forms['productos'].elements[n].name.match('PRODUCTO_') && document.forms['productos'].elements[n].value==idProducto)
			{
	          alert('El Producto que está intentando insertar ya existe en la Plantilla');
	          return;
	        }   
	      }
	      InsertarProducto(idProducto);
	    }
	    else
		{
	      alert(objFrame.msgPrivilegiosProducto);
	    }
	  }
	  else
	  {
	    alert(objFrame.msgSinPlantilla);
	  }
	}
		
		//-->
		</script>
		]]></xsl:text>
		
      </head>
      <body class="areaizq">
      
        <!--idioma-->
        <xsl:variable name="lang">
        	<xsl:value-of select="/ZonaProducto/LANG" />
        </xsl:variable>
        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
      <!--idioma fin-->
      
		<xsl:choose>
		<xsl:when test="//SESION_CADUCADA">
                <xsl:apply-templates select="//SESION_CADUCADA"/>        
                 </xsl:when>   
		<xsl:otherwise>
      <form name="productos">
        
			<!--<table class="plantilla">-->
      <table class="areaizq" style="font-size:13px;">      
			 <!-- <tr>
		          <th colspan="4">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Productos']/node()"/>&nbsp; </th>
				</tr>-->
        <thead>
                  <xsl:choose>
                  <xsl:when test="ZonaProducto/PRODUCTOS/PRODUCTO">
                      <!--<tr class="center">-->
                      <tr> <!-- id="table_titulos">-->
                       <!--<th colspan="4" style="padding:3px 1px;">-->
                       <th colspan="3">
                       <xsl:choose>
                       <xsl:when test="/ZonaProducto/PRODUCTOS/MOSTRAR_BOTON_OCULTOS or /ZonaProducto/PRODUCTOS/EDICION">
                          <!--<strong>-->
                         <a href="javascript:MostrarPlantilla('zonaPlantilla');"><xsl:value-of select="ZonaProducto/PRODUCTOS/TOTAL"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Productos']/node()"/>
                          <xsl:if test="ZonaProducto/PRODUCTOS/OCULTOS">
                            <xsl:if test="ZonaProducto/PRODUCTOS/MOSTRAR_BOTON_OCULTOS">
                            /<xsl:value-of select="ZonaProducto/PRODUCTOS/OCULTOS"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='ocultos']/node()"/>
                            </xsl:if>
                          </xsl:if></a><!--</strong>-->
                       </xsl:when>
                       <xsl:otherwise>
                          <strong>
                         <xsl:value-of select="ZonaProducto/PRODUCTOS/TOTAL"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Productos']/node()"/>
                          <xsl:if test="ZonaProducto/PRODUCTOS/OCULTOS">
                            <xsl:if test="ZonaProducto/PRODUCTOS/MOSTRAR_BOTON_OCULTOS">
                            /<xsl:value-of select="ZonaProducto/PRODUCTOS/OCULTOS"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='ocultos']/node()"/>
                            </xsl:if>
                          </xsl:if></strong>
                       </xsl:otherwise>
                       </xsl:choose>
                        </th>
                        </tr>
                       
			   	  </xsl:when>
                  <xsl:otherwise>
                  <tr>
		          <th colspan="4">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Productos']/node()"/>&nbsp; </th>
				  </tr>
                  </xsl:otherwise>
                  </xsl:choose>
      </thead>            
                   <tr><td colspan="4">&nbsp;</td></tr>
                  
		        <xsl:choose>
				  <xsl:when test="ZonaProducto/PRODUCTOS/PRODUCTO">
                 
				
        	<xsl:choose>
         		<xsl:when test="ZonaProducto/PRODUCTOS/SIN_PRODUCTOS_VISIBLES">
					<xsl:if test="//ZonaProducto/PRODUCTOS/EDICION">
          				<tr>
						  	<th colspan="4"><xsl:value-of select="document($doc)/translation/texts/item[@name='todos_productos_ocultos']/node()"/></th>
		  				</tr>
					</xsl:if>
		  			<input type="hidden" name="PRODUCTOS" value="-1"/>
				</xsl:when>
			<xsl:otherwise>
	
          	<xsl:for-each select="ZonaProducto/PRODUCTOS/PRODUCTO">
           		<!-- procesamos los visibles -->
					    	<xsl:choose>
					      	<xsl:when test="OCULTAR!='S'">
					        	<!-- solo mostramos hasta el limite, los demas aparecen como ocultos -->
					        	<xsl:choose>
					          	<xsl:when test="number(//ZonaProducto/PRODUCTOS/MAX_VISIBLES)=number(0) or number(VISIBLE/@Numero)&lt;=number(//ZonaProducto/PRODUCTOS/MAX_VISIBLES)">
										
												<!-- en edicion, mostramos el boton de borrado -->
												<xsl:choose>
							  					<xsl:when test="//ZonaProducto/PRODUCTOS/EDICION">
                                               
							    					<tr> <!-- class="lineBorderTop">-->
							      					<!--<td colspan="3" class="textLeft noventa" style="padding:3px 1px;">-->
                              <td class="textLeft" style="color:#3d5d95;">
							        					<!-- Link a la ficha del producto	-->
														<xsl:value-of select="NOMBRE"/><input type="hidden" name="IDPRODUCTO_{../ID}" value="{../ID}"/>
							      					</td>
							      					<td class="seis" valign="top">
                                                         <a href="javascript:BorrarProducto('BORRARPRODUCTO','{ID}');" title="Borrar producto">
                                                        <img src="http://www.newco.dev.br/images/2017/trash.png" alt="Boton borrar" title="Borrar producto"/>
                                                        </a>
							      					</td>
							    					</tr>
							  					</xsl:when>
							 	 					<!-- solo lectura, info minima -->
							  					<xsl:otherwise>
							    					<!--<tr class="lineBorderTop">-->
                            <tr>
							      					<!--<td colspan="3" class="textLeft noventa" style="padding:3px 1px;">-->
                              <td colspan="3">
							        					<!-- Link a la ficha del producto	-->
														<xsl:value-of select="NOMBRE"/><input type="hidden" name="IDPRODUCTO_{../ID}" value="{../ID}"/>
							      					</td>
                              <!--<tr id="lineGris"></tr>-->
							      					<!--<td class="seis" valign="top">-->

                              <td colspan="3">
                                                    	<xsl:if test="../MOSTRAR_BOTON_OCULTOS">
                                                            <a href="javascript:BorrarProducto('OCULTARPRODUCTO','{ID}');" title="Ocultar producto">
                                                            <!--
                                                            <xsl:attribute name="href">
                                                                javascript:BorrarProducto('OCULTARPRODUCTO','<xsl:value-of select="ID"/>');
                                                            </xsl:attribute>-->
                                                            <img src="http://www.newco.dev.br/images/ocultar.gif" alt="Boton ocultar" style="float:right" title="Ocultar producto"/>
                                                            </a><br/><br/>
                                                      </xsl:if>
							      					</td>
                                                            <tr id="lineGris"></tr>
							    					</tr>
							  					</xsl:otherwise>
												</xsl:choose>
					            </xsl:when>
					            <!-- de los visibles, los que no hemos de mostrar incluimos un hidden -->
					            <xsl:otherwise>
					            	<input type="hidden" name="IDPRODUCTO_{ID}" value="{ID}"/>
					            </xsl:otherwise>
					          </xsl:choose>
					        </xsl:when>
					        <!-- los que no se muestran -->
					        <xsl:otherwise>
					        	<input type="hidden" name="IDPRODUCTO_{ID}" value="{ID}"/>
					        </xsl:otherwise>
					      </xsl:choose>
		  		    </xsl:for-each>
		  				<!-- 
		  					guardamos un valor tipo candena diferente de -1 ya que existen productos
		  					faltaria devolver el contador con los productos que contiene la plantilla actual
		  				-->
		  				<input type="hidden" name="PRODUCTOS" value="CONPRODUCTOS"/>
		  		  </xsl:otherwise>
		  		</xsl:choose>	
                <!--fin listado productos-->
				
				
				  
				</xsl:when>
				<xsl:otherwise>
					<tr><td colspan="3" class="textCenter"><xsl:value-of select="document($doc)/translation/texts/item[@name='plantilla_vacia']/node()"/></td></tr>
					<input type="hidden" name="PRODUCTOS" value="-1"/>
				</xsl:otherwise>			
				</xsl:choose>
                <tfoot>
                <tr>
                	<td class="footLeft">&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td class="footRight">&nbsp;</td>
                </tr>
                </tfoot>
			</table>
			</form>
			<form name="envio">
			<input type="hidden" name="ACCION" value="{ZonaProducto/ACCION}"/>
			<input type="hidden" name="IDCARPETA" value="{ZonaProducto/IDCARPETA}"/>
			<input type="hidden" name="IDPLANTILLA"  value="{ZonaProducto/IDPLANTILLA}"/>
			<input type="hidden" name="IDPRODUCTO"  value="{ZonaProducto/IDPRODUCTO}"/>
			<input type="hidden" name="FECHA"/>
			</form>
			</xsl:otherwise>
			</xsl:choose>
	</body>      
</html>   
 </xsl:template>


</xsl:stylesheet>
