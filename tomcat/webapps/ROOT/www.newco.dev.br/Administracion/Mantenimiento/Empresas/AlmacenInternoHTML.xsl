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
          
          
        
        
        	msgBorrarPorDefecto='Va a borrar el almacén interno por defecto. Antes de enviar el formulario debe seleccionar el nuevo almacén interno. Gracias'
        	msgBorrarSinPorDefecto='El almacén interno por defecto seleccionado no es válido.';
        	msgConfirmarBorrado='¿Eliminar el almacén interno?';  
        	msgSinPorDefecto='No hay ningún almacén interno por defecto seleccionado. ¿Desea utilizar el que esta creando/editando como almacén interno por defecto?';     
        	msgSinPorDefectoError='No hay ningún almacén interno por defecto seleccionado. Por favor, seleccione uno antes de continuar.';
        	
        	
               
               function EditarAlmacenInterno(cen_id, almaceninterno_id){
                 document.location.href='http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/AlmacenInterno.xsql?CEN_ID='+cen_id+'&ALMACENINTERNO_ID='+almaceninterno_id+'&ACCION=EDITAR';
               }
               
               function BorrarAlmacenInterno(idCentro, idalmaceninterno,accion){
                 
                 var id;
                 
                 document.forms[0].elements['ACCION'].value=accion; 
                 document.forms[0].elements['CEN_ID'].value=idCentro;
                 document.forms[0].elements['ALMACENINTERNO_ID'].value=idalmaceninterno;
                 
                 if(document.forms[0].elements['CHECKPORDEFECTO_'+idalmaceninterno]){
                   if(document.forms[0].elements['CHECKPORDEFECTO_'+idalmaceninterno].checked==true){
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
        	  	document.forms[0].elements['ALMACENINTERNO_ID'].value=0;
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
            <p class="TituloPag" align="center">Mantenimiento almacenes internos</p>
            <br/>
            <br/>
        <form name="form1" action="AlmacenInterno.xsql" method="post">
          <input type="hidden" name="CEN_ID" value="{Mantenimiento/CEN_ID}"/>
          <input type="hidden" name="ALMACENINTERNO_ID" value="{Mantenimiento/ALMACENINTERNO/ID}"/>
          <input type="hidden" name="IDPORDEFECTO"/>
          <input type="hidden" name="ACCION"/>
   
        <table width="95%" align="center" class="gris" cellpadding="0" cellspacing="1">
          <tr class="grisClaro">
            <td>
              <table width="100%">
                <tr>
                  <td align="left">
                    <b>Almacenes internos</b>
                    <br/>
                    <i>Puede añadir, eliminar o cambiar el almacén interno por defecto</i>
                  </td>
                  <td align="right">&nbsp;
                   
                  </td>
                </tr>
              </table>
            </td>
          </tr>
          

          <xsl:choose>
        <xsl:when test="(Mantenimiento/ALMACENESINTERNOS/ALMACENINTERNO) and (Mantenimiento/ALMACENINTERNO/ACCION!='EDITAR') or (count(Mantenimiento/ALMACENESINTERNOS/ALMACENINTERNO)>1 and Mantenimiento/ALMACENINTERNO/ACCION='EDITAR')">
          <tr class="claro">
            <td class="blanco">
          
            <br/>
            <br/>
               <table width="100%" class="medio" align="center" cellpadding="1" cellspacing="1">
          <tr class="oscuro" align="center">
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
      
      <xsl:for-each select="Mantenimiento/ALMACENESINTERNOS/ALMACENINTERNO">
        <xsl:if test="ID!=//Mantenimiento/ALMACENINTERNO/ID">
          <tr class="claro" align="center">
            <td align="left">
              <table width="100%">
                <tr>
                  <td width="10%">
              			<xsl:call-template name="botonPersonalizado">
	      							<xsl:with-param name="funcion">BorrarAlmacenInterno('<xsl:value-of select="IDCENTRO"/>','<xsl:value-of select="ID"/>','BORRAR');</xsl:with-param>
	      							<xsl:with-param name="label">Eliminar</xsl:with-param>
	      							<xsl:with-param name="status">Eliminar almacén interno</xsl:with-param>
	    							</xsl:call-template>
	      					</td>
	      					<td align="left">
	    							&nbsp;&nbsp;
	      						<a> 
                			<xsl:attribute name="href">javascript:EditarAlmacenInterno('<xsl:value-of select="IDCENTRO"/>','<xsl:value-of select="ID"/>');</xsl:attribute>
                			<xsl:value-of select="REFERENCIA"/>
              			</a>
	      					</td>
	      				</tr>
	      			</table>
            </td>
            <td align="left">
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
        
          <tr class="blanco">
            <td colspan="6" align="right">
              <xsl:call-template name="boton">
                <xsl:with-param name="path" select="Mantenimiento/button[@label='PorDefecto']"/>
                <xsl:with-param name="ancho">250px</xsl:with-param>
              </xsl:call-template>
            </td>
          </tr>
          
        </table> 
        <br/>
        <br/>
            </td>
          </tr>
         </xsl:when>
        <xsl:otherwise>
          <tr class="blanco">
            <td class="blanco">&nbsp;
              
            </td>
          </tr>
        </xsl:otherwise>
       </xsl:choose>
          <tr class="grisClaro">
              <td align="left" class="grisClaro">
                almacén interno
              </td>
          </tr>
          <tr  class="blanco">
            <td align="left" class="blanco">
              <table class="oscuro" width="100%" align="center" cellspacing="1" cellpadding="1">
                <tr class="blanco">
                  <td  class="claro" width="10%"  align="right">
                    Referencia
                  </td>
                  <td class="blanco" width="30%" align="left">
                    <input type="text" name="NUEVAREFERENCIA" size="30" maxlength="100" value="{/Mantenimiento/ALMACENINTERNO/REFERENCIA}"/>
                  </td>
                  <td  class="claro" width="10%"  align="right">
                    Nombre
                  </td>
                  <td class="blanco" width="30%" align="left">
                    <input type="text" name="NUEVONOMBRE" size="50" maxlength="100" value="{/Mantenimiento/ALMACENINTERNO/NOMBRE}"/>
                  </td>
                </tr>
                <tr>
                  <td align="right" class="claro">
                    Por defecto
                  </td>
                  <td class="blanco"  colspan="3" align="left">
                    <input type="hidden" name="NUEVOPORDEFECTO"/>
                    <input type="checkbox" name="CHECKNUEVOPORDEFECTO" onClick="comprobarCheck(this, this.form);">
                      <xsl:choose>
                        <xsl:when test="/Mantenimiento/ALMACENINTERNO/PORDEFECTO='S'">
                          <xsl:attribute name="checked">checked</xsl:attribute>
                        </xsl:when>
                        <xsl:otherwise>
                          <xsl:attribute name="unchecked">unchecked</xsl:attribute>
                        </xsl:otherwise>
                      </xsl:choose>
                    </input>
                  </td>
                </tr> 
              </table>
            </td>
          </tr>
          <tr>
            <td>
              <table width="100%" class="blanco">
                <tr>
                  <td align="center">
                    <xsl:call-template name="boton">
                      <xsl:with-param name="path" select="Mantenimiento/button[@label='Cerrar']"/>
                    </xsl:call-template>
                  </td>
                 
                    <xsl:choose>
                      <xsl:when test="Mantenimiento/ALMACENINTERNO/ACCION='EDITAR'">
                        <td  align="center"> 
                        <xsl:call-template name="botonPersonalizado">
	                 <xsl:with-param name="funcion">BorrarAlmacenInterno('<xsl:value-of select="Mantenimiento/ALMACENINTERNO/IDCENTRO"/>','<xsl:value-of select="Mantenimiento/ALMACENINTERNO/ID"/>','BORRAR');</xsl:with-param>
	                 <xsl:with-param name="label">Eliminar</xsl:with-param>
	                 <xsl:with-param name="status">Eliminar almacén interno</xsl:with-param>
	                 <xsl:with-param name="ancho">120px</xsl:with-param>
	                </xsl:call-template>
                        </td>
                        <td  align="center"> 
                        <xsl:call-template name="boton">
                          <xsl:with-param name="path" select="Mantenimiento/button[@label='Editar']"/>
                        </xsl:call-template>
                        </td>
                        
                      </xsl:when>
                      <xsl:otherwise>
                        <td  align="center"> 
                        <xsl:call-template name="boton">
                          <xsl:with-param name="path" select="Mantenimiento/button[@label='Insertar']"/>
                        </xsl:call-template>
                        </td>
                      </xsl:otherwise>
                    </xsl:choose>
                  
                </tr>
              </table>
            </td>
          </tr>
          </table>
        </form>
        </xsl:otherwise>
        </xsl:choose>
      </body>
    </html>
  </xsl:template>

</xsl:stylesheet>
