<?xml version="1.0" encoding="iso-8859-1" ?>
<!--
 |
 +-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href = "http://www.newco.dev.br/General/General.xsl"/> 
  <xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
  <xsl:param name="lang" select="@lang"/>
  
  <xsl:template match="/">
    <html>
      <head>
       <!--style-->
      <xsl:call-template name="estiloIndip"/>
      <!--fin de style-->  

     <script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
	 <script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>
     
	<xsl:text disable-output-escaping="yes"><![CDATA[

        <script type="text/javascript">
        <!--

          
          function CerrarVentana(){
           window.close();
           Refresh(top.opener.document);
          }
          
          
        
        
        	msgBorrarPorDefecto='Va a borrar el centro de entrega por defecto. Antes de enviar el formulario debe seleccionar el nuevo centro de consumo. Gracias'
        	msgBorrarSinPorDefecto='El centro de consumo por defecto seleccionado no es v�lido.';
        	msgConfirmarBorrado='�Eliminar el centro de consumo?';  
        	msgSinPorDefecto='No hay ning�n centro de consumo por defecto seleccionado. �Desea utilizar el que esta creando/editando como centro de consumo por defecto?';     
        	msgSinPorDefectoError='No hay ning�n centro de consumo por defecto seleccionado. Por favor, seleccione uno antes de continuar.';
        	
        	
               
               function EditarCentroConsumo(cen_id, centroconsumo_id){
                 document.location.href='http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/CentrosConsumo.xsql?CEN_ID='+cen_id+'&CENTROCONSUMO_ID='+centroconsumo_id+'&ACCION=EDITAR';
               }
               
               function BorrarCentroConsumo(idCentro, idcentroConsumo,accion){
                 
                 var id;
                 
                 document.forms[0].elements['ACCION'].value=accion; 
                 document.forms[0].elements['CEN_ID'].value=idCentro;
                 document.forms[0].elements['CENTROCONSUMO_ID'].value=idcentroConsumo;
                 
                 if(document.forms[0].elements['CHECKPORDEFECTO_'+idcentroConsumo]){
                   if(document.forms[0].elements['CHECKPORDEFECTO_'+idcentroConsumo].checked==true){
                     alert(msgBorrarPorDefecto);
                   }
                   else{
                     for(var n=0;n<document.forms[0].length;n++){
                       if(document.forms[0].elements[n].name.substring(0,5)=='CHECK' && document.forms[0].elements[n].checked==true){
                         id=obtenerId(document.forms[0].elements[n].name);
                         if(isNaN(id)){
                           alert(msgBorrarSinPorDefecto);
                         }
                         else{
                           document.forms[0].elements['IDPORDEFECTO'].value=id;
                           if(confirm(msgConfirmarBorrado)){
                             SubmitForm(document.forms[0]);
                           }
                         }   
                       }
                     }
                   }
                 }
                 else{
                   if(document.forms[0].elements['CHECKNUEVOPORDEFECTO'].checked==true)
                     alert(msgBorrarPorDefecto);
                   else{
                     for(var n=0;n<document.forms[0].length;n++){
                       if(document.forms[0].elements[n].name.substring(0,5)=='CHECK' && document.forms[0].elements[n].checked==true){
                         id=obtenerId(document.forms[0].elements[n].name);
                         if(isNaN(id)){
                           alert(msgBorrarSinPorDefecto);
                         }
                         else{
                           document.forms[0].elements['IDPORDEFECTO'].value=id;
                           if(confirm(msgConfirmarBorrado)){ 
                             SubmitForm(document.forms[0]);
                           }
                         }   
                       }
                     }
                   }
                 }
               }	
        	
        	
        	function ActualizarDatos(form, accion){

        		document.forms[0].elements['ACCION'].value=accion; 
        	 
        	  if(accion=='INSERTAR'){
        	  	document.forms[0].elements['CENTROCONSUMO_ID'].value=0;
        	  	if(document.forms[0].elements['CHECKNUEVOPORDEFECTO'].checked==true)
        	    	document.forms[0].elements['NUEVOPORDEFECTO'].value='S';
        	    else
        	      document.forms[0].elements['NUEVOPORDEFECTO'].value='N';
        	      
        	    if(validarFormulario(form)){ 
        	    	form.elements['ACCION'].value=accion;
        	      for(var n=0;n<document.forms[0].length;n++){
                	if(document.forms[0].elements[n].name.substring(0,5)=='CHECK'){
                		if(document.forms[0].elements[n].checked==true){
                  		id=obtenerId(document.forms[0].elements[n].name);
                   		if(isNaN(id)){
                      	document.forms[0].elements['IDPORDEFECTO'].value=0;
                     	}
                     	else{
                      	document.forms[0].elements['IDPORDEFECTO'].value=id; 
                     	}
                     }
                   }
                 }
                 if(document.forms[0].elements['IDPORDEFECTO'].value==''){
                   if(confirm(msgSinPorDefecto)){
                   	document.forms[0].elements['NUEVOPORDEFECTO'].value='S';
                   	SubmitForm(document.forms[0]);
                   }
                 }
                 else{
                 	SubmitForm(document.forms[0]);
                 }
        	    }
        	  }
        	  else{
        	    if(accion=='GUARDAR'){
        	      if(document.forms[0].elements['CHECKNUEVOPORDEFECTO'].checked==true)
        	        document.forms[0].elements['NUEVOPORDEFECTO'].value='S';
        	      else
        	        document.forms[0].elements['NUEVOPORDEFECTO'].value='N';
        	      
        	      if(validarFormulario(form)){ 
        	        form.elements['ACCION'].value=accion;
        	        for(var n=0;n<document.forms[0].length;n++){
                          if(document.forms[0].elements[n].name.substring(0,5)=='CHECK' && document.forms[0].elements[n].checked==true){
                            id=obtenerId(document.forms[0].elements[n].name);
                            if(isNaN(id)){
                              document.forms[0].elements['IDPORDEFECTO'].value=0;
                            }
                            else{
                              document.forms[0].elements['IDPORDEFECTO'].value=id; 
                            }   
                          }
                        }
                        if(document.forms[0].elements['IDPORDEFECTO'].value==''){
                   if(confirm(msgSinPorDefecto)){
                   	document.forms[0].elements['NUEVOPORDEFECTO'].value='S';
                   	SubmitForm(document.forms[0]);
                   }
                 }
                 else{
                 	SubmitForm(document.forms[0]);
                 }
                        
        	      }
        	    }
        	    else{
        	      if(accion=='CAMBIARPORDEFECTO'){
        	      	var hemosAvisado=0;
        	        for(var n=0;n<document.forms[0].length;n++){
                          if(document.forms[0].elements[n].name.substring(0,5)=='CHECK' && document.forms[0].elements[n].checked==true){
                            id=obtenerId(document.forms[0].elements[n].name);
                            if(isNaN(id)){
                            	hemosAvisado=1;
                              alert(msgBorrarSinPorDefecto);
                            }
                            else{
                              document.forms[0].elements['IDPORDEFECTO'].value=id; 
                            }   
                          }
                        }
                        if(document.forms[0].elements['IDPORDEFECTO'].value==''){
                        	if(document.forms[0].elements['CENTROCONSUMO_ID'].value==0){
                        		if(!hemosAvisado){
                        			alert(msgSinPorDefectoError);
                        		}
                        	}
                        	else{
                   					if(confirm(msgSinPorDefecto)){
                   						document.forms[0].elements['NUEVOPORDEFECTO'].value='S';
                   						SubmitForm(document.forms[0]);
                   					}
                   				}
                 				}
                 				else{
                 					SubmitForm(document.forms[0]);
                 				}
        	      }
        	    }
        	  }
        	}
        	
        	function validarFormulario(form){
        	  var errores=0;
        	  

        	  
        	  			if((!errores) && (document.forms[0].elements['NUEVAREFERENCIA'].value=='')){
                    alert('Debe proporcionar una referencia para el centro de consumo');
                    document.forms[0].elements['NUEVAREFERENCIA'].focus();
                    errores++;
                  }
 
                  if((!errores) && (document.forms[0].elements['NUEVONOMBRE'].value=='')){
                    alert('Debe proporcionar un nombre para el centro de consumo');
                    document.forms[0].elements['NUEVONOMBRE'].focus();
                    errores++;
                  }
        	  
        	  
        	  
        	  if(!errores){
        	    return true;  
        	  }
        	}
        	
        
        
        
        function comprobarCheck(obj,form){
          if(obj.checked==false){
            obj.checked=true;
          }
          
          for(var n=0;n<form.length;n++){
            if(form.elements[n].name.substring(0,5)=='CHECK' && form.elements[n].name!=obj.name)
              form.elements[n].checked=false;
          }
        }
        
                   
	//-->        
        </script>
        ]]></xsl:text> 
        
        
      </head>
      <body>
        <xsl:choose>
          <!-- Error en alguna sentencia del XSQL -->
          <xsl:when test="//xsql-error">
            <xsl:apply-templates select="//xsql-error"/>        
          </xsl:when>
          <xsl:when test="//SESION_CADUCADA">
            <xsl:for-each select="//SESION_CADUCADA">
              <xsl:if test="position()=last()">
                <xsl:apply-templates select="."/>
              </xsl:if>
            </xsl:for-each>        
          </xsl:when>
          <xsl:otherwise>  
 
        <!--idioma-->
        <xsl:variable name="lang">
        <xsl:choose>
            <xsl:when test="/Mantenimiento/LANG"><xsl:value-of select="/Mantenimiento/LANG" /></xsl:when>
            <xsl:otherwise>spanish</xsl:otherwise>
            </xsl:choose>  
        </xsl:variable>
        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>      	        <!--idioma fin-->


		<!--	Titulo de la p�gina		-->
		<div class="ZonaTituloPagina">
			<p class="Path"><xsl:value-of select="document($doc)/translation/texts/item[@name='Inicio']/node()"/>&nbsp;/&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='centro']/node()"/>&nbsp;/&nbsp;<span class="FinPath"><xsl:value-of select="document($doc)/translation/texts/item[@name='mantenimiento_centros_consumo']/node()"/>&nbsp;</span></p>
			<p class="TituloPagina">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='mantenimiento_centros_consumo']/node()"/>
				<span class="CompletarTitulo">
                    <a class="btnNormal" href="javascript:CerrarVentana();">
                    <xsl:value-of select="document($doc)/translation/texts/item[@name='cerrar']/node()"/>
                    </a>
				</span>
			</p>
		</div>
		<br/>
		<br/>
		<br/>
		<br/>
          
        <!--<h1 class="titlePage">Mantenimiento centros de consumo</h1>-->
           
        <form name="form1" action="CentrosConsumo.xsql" method="post">
          <input type="hidden" name="CEN_ID" value="{Mantenimiento/CEN_ID}"/>
          <input type="hidden" name="CENTROCONSUMO_ID" value="{Mantenimiento/CENTROCONSUMO/ID}"/>
          <input type="hidden" name="IDPORDEFECTO"/>
          <input type="hidden" name="ACCION"/>
          
   		<div class="divLeft">
        <table class="buscador">
			<!--
           <tr class="gris">
           		<td colspan="3">
                 Puede a�adir, eliminar o cambiar el centro de consumo por defecto
            	</td>
                <td class="veinte">
                	<div class="botonLargo">
                      <xsl:call-template name="botonNostyle">
                        <xsl:with-param name="path" select="Mantenimiento/button[@label='PorDefecto']"/>
                      </xsl:call-template>
                    </div>
                </td>
          </tr>
		  -->
          <xsl:choose>
        <xsl:when test="(Mantenimiento/CENTROSCONSUMO/CENTROCONSUMO) and (Mantenimiento/CENTROCONSUMO/ACCION!='EDITAR') or (count(Mantenimiento/CENTROSCONSUMO/CENTROCONSUMO)>1 and Mantenimiento/CENTROCONSUMO/ACCION='EDITAR')">
          <tr class="subTituloTabla">
            <td class="diez">
              Eliminar
            </td>
             <td class="veinte">
              Referencia
            </td>
            <td class="treinta">
              Nombre
            </td>
            <td>
              Por defecto
            </td>
          </tr>
      
      <xsl:for-each select="Mantenimiento/CENTROSCONSUMO/CENTROCONSUMO">
        <xsl:if test="ID!=//Mantenimiento/CENTROCONSUMO/ID">
          <tr>
            <td>
              	<!--<xsl:call-template name="botonPersonalizado">
	      			<xsl:with-param name="funcion">BorrarCentroConsumo('<xsl:value-of select="IDCENTRO"/>','<xsl:value-of select="ID"/>','BORRAR');</xsl:with-param>
	      			<xsl:with-param name="label">Eliminar</xsl:with-param>
	      			<xsl:with-param name="status">Eliminar centro de consumo</xsl:with-param>
	    		</xsl:call-template>-->
				<a class="btnDestacado" href="javascript:BorrarCentroConsumo('{IDCENTRO}','{ID}','BORRAR');"><xsl:value-of select="document($doc)/translation/texts/item[@name='eliminar']/node()"/></a>
	      	</td>
	      	<td>
	      		<a> 
                	<xsl:attribute name="href">javascript:EditarCentroConsumo('<xsl:value-of select="IDCENTRO"/>','<xsl:value-of select="ID"/>');</xsl:attribute>
                	<xsl:value-of select="REFERENCIA"/>
              	</a>
	      	</td>
            <td>
        			<xsl:value-of select="NOMBRE"/>
	      	</td>
            <td>
             <input type="checkbox" name="CHECKPORDEFECTO_{ID}" onClick="comprobarCheck(this, this.form);">
               <xsl:choose>
                  <xsl:when test="PORDEFECTO='S'">
                    <xsl:attribute name="checked">checked</xsl:attribute>
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:attribute name="unchecked">unchecked</xsl:attribute>
                  </xsl:otherwise>
                </xsl:choose>
            </input>
            </td>
          </tr>
          </xsl:if>  
        </xsl:for-each>
        </xsl:when>
        <xsl:otherwise>
          <tr>
            <td colspan="4">&nbsp;</td>
          </tr>
        </xsl:otherwise>
       </xsl:choose>
   </table>
   <br /><br />
   
   <table class="buscador">
          <tr class="subTituloTabla">
              <th colspan="4">
                Centro de consumo
              </th>
          </tr>
          <tr class="subTituloTabla">
              <td>
                Referencia
              </td>
              <td>
                Nombre
              </td>
              <td>
                Por defecto
              </td>
          </tr>
          <tr>
          	<td>
                <input type="text" name="NUEVAREFERENCIA" size="30" maxlength="100" value="{/Mantenimiento/CENTROCONSUMO/REFERENCIA}"/>
            </td>
            <td>
                <input type="text" name="NUEVONOMBRE" size="50" maxlength="100" value="{/Mantenimiento/CENTROCONSUMO/NOMBRE}"/>
            </td>
           <td>
                <input type="hidden" name="NUEVOPORDEFECTO"/>
                <input type="checkbox" name="CHECKNUEVOPORDEFECTO" onClick="comprobarCheck(this, this.form);">
                  <xsl:choose>
                    <xsl:when test="/Mantenimiento/CENTROCONSUMO/PORDEFECTO='S'">
                    	<xsl:attribute name="checked">checked</xsl:attribute>
                    </xsl:when>
                    <xsl:otherwise>
                    	<xsl:attribute name="unchecked">unchecked</xsl:attribute>
                    </xsl:otherwise>
                  </xsl:choose>
                </input>
              </td>
          </tr>
          <tr class="sinLinea"><td colspan="3">&nbsp;</td></tr>
          <tr class="sinLinea">
              <td>
                <div class="botonCenter">
                <xsl:call-template name="botonNostyle">
                  <xsl:with-param name="path" select="Mantenimiento/button[@label='Cerrar']"/>
                </xsl:call-template>
                </div>
              </td>

                <xsl:choose>
                  <xsl:when test="Mantenimiento/CENTROCONSUMO/ACCION='EDITAR'">
                     <td> 
                        <!--<div class="botonCenter">
                        <xsl:call-template name="botonNostyle">
                          <xsl:with-param name="path" select="Mantenimiento/button[@label='Editar']"/>
                        </xsl:call-template>
                        </div>-->
						<a class="btnDestacado" href="javascript:ActualizarDatos(document.forms[0],'GUARDAR');"><xsl:value-of select="document($doc)/translation/texts/item[@name='guardar']/node()"/></a>
                    </td>
                     <td> 
					 <!--
                		<div class="botonCenter">
                    		<xsl:call-template name="botonPersonalizado">
                    		 <xsl:with-param name="funcion">BorrarCentroConsumo('<xsl:value-of select="Mantenimiento/CENTROCONSUMO/IDCENTRO"/>','<xsl:value-of select="Mantenimiento/CENTROCONSUMO/ID"/>','BORRAR');</xsl:with-param>
                    		 <xsl:with-param name="label">Eliminar</xsl:with-param>
                    		 <xsl:with-param name="status">Eliminar centro de consumo</xsl:with-param>
                    		</xsl:call-template>
                		</div>-->
						<a class="btnDestacado" href="javascript:ActualizarDatos(document.forms[0],'BORRAR');"><xsl:value-of select="document($doc)/translation/texts/item[@name='eliminar']/node()"/></a>
                    </td>
                  </xsl:when>
                  <xsl:otherwise>
                   <td>&nbsp;</td>
                    <td> 
                    <!--<div class="botonCenter">
                        <xsl:call-template name="botonNostyle">
                          <xsl:with-param name="path" select="Mantenimiento/button[@label='Insertar']"/>
                        </xsl:call-template>
                    </div>-->
 						<a class="btnDestacado" href="javascript:ActualizarDatos(document.forms[0],'INSERTAR');"><xsl:value-of select="document($doc)/translation/texts/item[@name='nuevo']/node()"/></a>
                   </td>
                  </xsl:otherwise>
                </xsl:choose>
          </tr>
          </table>
          </div>
        </form>
        </xsl:otherwise>
        </xsl:choose>
      </body>
    </html>
  </xsl:template>

</xsl:stylesheet>
