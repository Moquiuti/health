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
        <title>
          Mantenimiento de Criterios de Evaluación
        </title>
	<xsl:text disable-output-escaping="yes"><![CDATA[
	<link rel="stylesheet" href="http://www.newco.dev.br/General/Estilos.css" type="text/css">
         <script type="text/javascript" src="http://www.newco.dev.br/General/general.js"></script>	
        <script type="text/javascript">
        <!--

           var msgConfirmarBorrado='¿Eliminar el Criterio?'; 
           
           var msgSinDescripcionCriterio='Debe introducir la descripción del criterio de evaluación.';
           var msgSinTipoDeCriterio='Debe seleccionar el tipo de criterio.';

          
          /*
          
             variables con los datos del top y del opener
          
          */
          
          
          
          
          
          function CerrarVentana(){
            if(window.opener && !window.opener.closed){
              var objFrameTop=new Object();   
              objFrameTop=window.opener.top;
              var FrameOpenerName=window.opener.name;
              var objFrame=new Object();
              objFrame=obtenerFrame(objFrameTop,FrameOpenerName);
              if(objFrame!=null){
                objFrame.recargarPagina();
                
              }
              else{
                Refresh(objFrame.document);
              }  	
            }
            //window.close(); 
            document.location.href='about:blank';
          }
          

              
               
               function BorrarCriterio(idCriterio,accion){
                 if(confirm(msgConfirmarBorrado)){
                   document.forms[0].elements['ACCION'].value=accion; 
                   document.forms[0].elements['IDCRITERIO'].value=idCriterio;
                 
                   SubmitForm(document.forms[0]);
                 }
               }
               
               function ModificarCriterio(idCriterio,accion){
                 document.forms[0].elements['ACCION'].value=accion; 
                 document.forms[0].elements['IDCRITERIO'].value=idCriterio;
                 
                 SubmitForm(document.forms[0]);
               }
               
        	function ActualizarDatos(form, accion){
        	  if(ValidarFormulario(form)){
        	    document.forms[0].elements['ACCION'].value=accion; 
        	 
                    SubmitForm(document.forms[0]);
                  }
                        
        	}
        	
        	function ValidarFormulario(form){
        	  var errores=0;
 
                  /* quitamos los espacios sobrantes  */
        
                   for(var n=0;n<form.length;n++){
                     if(form.elements[n].type=='text'){
                       form.elements[n].value=quitarEspacios(form.elements[n].value);
                     }
                   }
                  
                  if((!errores) && (esNulo(document.forms[0].elements['DESCRIPCIONCRITERIO'].value))){
                    alert(msgSinDescripcionCriterio);
                    document.forms[0].elements['DESCRIPCIONCRITERIO'].focus();
                    errores++;
                  }
                  
                  if((!errores) && (!opcionSeleccionada(form))){
                    errores++;
                    alert(msgSinTipoDeCriterio);
                   form.elements['CHK_TIPOCRITERIO_FUNCIONAL'].focus();  
                  }                 
        	  
        	  if(!errores)
        	    return true;  
        	  else
        	    return false;
        	}
        	
        	function opcionSeleccionada(form){
                  for(var n=0;n<form.length;n++){
                    if(form.elements[n].name.substring(0,17)=='CHK_TIPOCRITERIO_'){
                      if(form.elements[n].checked==true){
                        form.elements['TIPOCRITERIO'].value=form.elements[n].value;
                        return true;
                      }
                    }
                  }
                  return false;
                }
                
                function validarChecks(form, objName){
        var opcion=obtenerNombre(objName,'_',2,'DESPUES');
        var nombreChk=obtenerNombre(objName,'_',2,'ANTES');
        
        var opcionContraria;
        
        if(opcion=='FUNCIONAL'){
          opcionContraria='ENVOLTORIO';
        }
        else{
          opcionContraria='FUNCIONAL';
        };
        
        if(form.elements[objName].checked==true)
          form.elements[nombreChk+opcionContraria].checked=false;
        
      }
      
      function obtenerNombre(nombre, separador, posicion, lado){
        
        var apariciones=0;
        var subCadena='';
        
        for(var n=0;n<nombre.length;n++){
          if(nombre.substring(n,n+1)==separador){
            apariciones++;
          }
          if(apariciones==posicion){
            if(lado=='DESPUES'){
              return subCadena=nombre.substring(n+1,nombre.length);
            }
            else{
              return subCadena=nombre.substring(0,n+1);
            }
          }
        }
        return null;
      }
      		
                   
	//-->        
        </script>
        ]]></xsl:text> 
        
        
      </head>
      <body bgcolor="#FFFFFF">
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
          <xsl:when test="//Status">
            <xsl:apply-templates select="//Status"/> 
          </xsl:when>
          <xsl:otherwise>  
            <p class="TituloPag" align="center">Criterios de Evaluación Generales</p>
            <br/>
            <br/>
        <form name="form1" action="MantCriteriosEvaluacionGenerales.xsql" method="post">
          <input type="hidden" name="IDACTA" value="{Mantenimiento/CRITERIOS/CRITERIOACTUAL/IDACTA}"/>
           <input type="hidden" name="ACCION"/>
          <input type="hidden" name="TIPOCRITERIO"/>
          <input type="hidden" name="TIPOCRITERIOVIEJO" value="{Mantenimiento/CRITERIOS/CRITERIOACTUAL/TIPO}"/>
          <input type="hidden" name="DESCRIPCIONCRITERIOVIEJO" value="{Mantenimiento/CRITERIOS/CRITERIOACTUAL/DESCRIPCION}"/>
          <input type="hidden" name="IDCRITERIO" value="{Mantenimiento/CRITERIOS/CRITERIOACTUAL/IDCRITERIO}"/>
          <input type="hidden" name="CAMBIOSCRITERIOS"/>
          
          
          
          <!--  CAMPOS QUE FORMAN PARTE LA CLAVE Y QUE SON MODIFICABLES   -->

   
        <table width="95%" align="center">
          <tr>
            <td>
              <table width="100%" align="center" class="gris" cellpadding="0" cellspacing="1">
                <tr class="grisClaro">
                  <td>
                    <table width="100%">
                      <tr>
                        <td align="left">
                          <b>Mantenimiento de Criterios de Evaluación Generales</b>
                          <br/>
                          <i>Puede añadir, eliminar o modificar los criterios.</i>
                        </td>
                        <td align="right">
                         &nbsp;
                        </td>
                      </tr>
                    </table>
                  </td>
                </tr>
                <tr class="claro">
                  <td class="blanco">
                  <br/>
                  <br/>
                     <table width="100%" class="medio" align="center" cellpadding="1" cellspacing="1">
                       <tr class="oscuro" align="center">
                         <td class="oscuro" width="*" align="left">
                           Criterios de Evaluación Funcional
                         </td>
                       </tr>
                     <xsl:choose>
                       <xsl:when test="Mantenimiento/CRITERIOS/CRITERIOSFUNCIONALES/CRITERIO">
                         <xsl:for-each select="Mantenimiento/CRITERIOS/CRITERIOSFUNCIONALES/CRITERIO">
                           <tr class="oscuro" align="center">
                             <td  class="claro" width="*">
                               <table width="100%">
                                 <tr>
                                   <td width="5%">
                                     <xsl:call-template name="botonPersonalizado">
	                               <xsl:with-param name="funcion">BorrarCriterio('<xsl:value-of select="IDCRITERIO"/>','BORRARCRITERIO');</xsl:with-param>
	                               <xsl:with-param name="label">X</xsl:with-param>
	                               <xsl:with-param name="fontColor">red</xsl:with-param>
	                               <xsl:with-param name="status">Eliminar criterio</xsl:with-param>
	                             </xsl:call-template>
	                           </td>
	                           <td>
                                     &nbsp;&nbsp;
                                     <a href="javascript:ModificarCriterio('{IDCRITERIO}','MODIFICARCRITERIO');">
                                       <xsl:value-of select="DESCRIPCION"/>
                                     </a>
	                           </td>
	                         </tr>
	                       </table>
                             </td>
                           </tr>
                         </xsl:for-each>
                       </xsl:when>
                       <xsl:otherwise>
                           <tr class="oscuro" align="center">
                             <td  class="claro" align="center">
                                Ningún Criterio de Evaluación Funcional
                             </td>  
                           </tr>
                       </xsl:otherwise>
                     </xsl:choose>
                   </table> 
                   <br/>
                   <br/>
                     <table width="100%" class="medio" align="center" cellpadding="1" cellspacing="1">
                       <tr class="oscuro" align="center">
                         <td class="oscuro" width="*" align="left">
                           Criterios de Evaluación de la Presentación
                         </td>
                       </tr>
                     <xsl:choose>
                       <xsl:when test="Mantenimiento/CRITERIOS/CRITERIOSENVOLTORIO/CRITERIO">
                         <xsl:for-each select="Mantenimiento/CRITERIOS/CRITERIOSENVOLTORIO/CRITERIO">
                           <tr class="oscuro" align="center">
                             <td  class="claro" width="*">
                               <table width="100%">
                                 <tr>
                                   <td width="5%">
                                     <xsl:call-template name="botonPersonalizado">
	                               <xsl:with-param name="funcion">BorrarCriterio('<xsl:value-of select="IDCRITERIO"/>','BORRARCRITERIO');</xsl:with-param>
	                               <xsl:with-param name="label">X</xsl:with-param>
	                               <xsl:with-param name="fontColor">red</xsl:with-param>
	                               <xsl:with-param name="status">Eliminar criterio</xsl:with-param>
	                             </xsl:call-template>
	                           </td>
	                           <td>
                                     &nbsp;&nbsp;
                                     <a href="javascript:ModificarCriterio('{IDCRITERIO}','MODIFICARCRITERIO');">
                                       <xsl:value-of select="DESCRIPCION"/>
                                     </a>
	                           </td>
	                         </tr>
	                       </table>
                             </td>
                           </tr>
                         </xsl:for-each>
                       </xsl:when>
                       <xsl:otherwise>
                           <tr class="oscuro" align="center">
                             <td  class="claro" align="center">
                                Ningún Criterio de Evaluación de la Presentación
                             </td>  
                           </tr>
                       </xsl:otherwise>
                     </xsl:choose>
                   </table> 

                  <br/>
                  <br/>
                  </td>
                </tr>
                <tr class="grisClaro">
                    <td align="left" class="grisClaro">
                      Añadir / Modificar Criterio 
                    </td>
                </tr>
                <tr  class="blanco">
                  <td align="left" class="blanco">
                    <table class="oscuro" width="100%" align="center" cellspacing="1" cellpadding="3" border="0">
                      <tr class="blanco">
                        <td  class="claro" width="20%"  align="right">
                           Descripción del criterio:<span class="camposObligatorios">*</span>
                        </td>
                        <td class="blanco" width="*" align="left" colspan="3">
                          <input type="text" size="100" maxlength="300" name="DESCRIPCIONCRITERIO" value="{Mantenimiento/CRITERIOS/CRITERIOACTUAL/DESCRIPCION}"/>
                        </td>
                      </tr>
                      <tr>
                        <td  class="claro" align="right">
                          Tipo de Criterio:<span class="camposObligatorios">*</span>
                        </td>
                        <td class="blanco" colspan="3" align="left">
                          <table width="100%">
                            <tr>
                              <td width="5%">
                                <input type="checkbox" name="CHK_TIPOCRITERIO_FUNCIONAL" value="F" onClick="validarChecks(document.forms[0], this.name);">
                                  <xsl:if test="Mantenimiento/CRITERIOS/CRITERIOACTUAL/TIPO='F'"><xsl:attribute name="checked">checked</xsl:attribute></xsl:if>
                                </input>
                              </td>
                              <td>
                                Evaluación Funcional
                              </td>
                            </tr>
                            <tr>
                              <td width="5%">    
                                <input type="checkbox" name="CHK_TIPOCRITERIO_ENVOLTORIO" value="E" onClick="validarChecks(document.forms[0], this.name);">
                                  <xsl:if test="Mantenimiento/CRITERIOS/CRITERIOACTUAL/TIPO='E'"><xsl:attribute name="checked">checked</xsl:attribute></xsl:if>
                                </input>
                              </td>
                              <td>
                                Evaluación de la Presentación
                              </td>
                            </tr>
                          </table>
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
                            <xsl:with-param name="path" select="Mantenimiento/botones/button[@label='Cerrar']"/>
                          </xsl:call-template>
                        </td>
                       
                          <xsl:choose>
                            <xsl:when test="Mantenimiento/ACCION='MODIFICARCRITERIO'">
                              <td  align="center"> 
                              <xsl:call-template name="botonPersonalizado">
	                       <xsl:with-param name="funcion">ModificarCriterio(document.forms[0].elements['IDACTA'].value,'');</xsl:with-param>
	                       <xsl:with-param name="label">Cancelar</xsl:with-param>
	                       <xsl:with-param name="status">Cancelar la modificación el centro</xsl:with-param>
	                       <xsl:with-param name="ancho">120px</xsl:with-param>
	                      </xsl:call-template>
                              </td>
                              <td  align="center"> 
                              <xsl:call-template name="boton">
                                <xsl:with-param name="path" select="Mantenimiento/botones/button[@label='Guardar']"/>
                              </xsl:call-template>
                              </td>
                              
                            </xsl:when>
                            <xsl:otherwise>
                              <td  align="center"> 
                              <xsl:call-template name="boton">
                                <xsl:with-param name="path" select="Mantenimiento/botones/button[@label='Insertar']"/>
                              </xsl:call-template>
                              </td>
                            </xsl:otherwise>
                          </xsl:choose>
                        
                      </tr>
                    </table>
                  </td>
                </tr>
              </table>
            </td>
          </tr>
          <tr>
            <td>
              Los campos marcados con (<span class="camposObligatorios">*</span>) son obligatorios.
            </td>
          </tr>
        </table>
        </form>
        </xsl:otherwise>
        </xsl:choose>
      </body>
    </html>
  </xsl:template>
  
  <xsl:template match="Status">

  <xsl:variable name="vMSGT" select="ERROR/MSGT"/>
  <xsl:variable name="vMSGB" select="ERROR/MSGB"/>

  <p class="tituloPag">
  <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id=$vMSGT and @lang=$lang]" disable-output-escaping="yes"/>
  </p>
  <hr/>
  <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id=$vMSGB and @lang=$lang]" disable-output-escaping="yes"/>
  <br/> 
  <br/> 
  <xsl:call-template name="boton">
    <xsl:with-param name="path" select="/Mantenimiento/botones/button[@label='Volver']"/>
  </xsl:call-template>
   
</xsl:template>

</xsl:stylesheet>
