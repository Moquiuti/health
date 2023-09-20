<?xml version="1.0" encoding="iso-8859-1" ?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href = "http://www.newco.dev.br/General/General.xsl" />
  <xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
  <xsl:param name="lang" select="@lang"/>  
  <xsl:template match="/">

<html>
<head>
<title>Solicitud muestras</title>
  <xsl:text disable-output-escaping="yes"><![CDATA[
    <link rel="stylesheet" href="http://www.newco.dev.br/General/Estilos.css" type="text/css">
    <link rel="stylesheet" href="http://www.newco.dev.br/General/EstilosImprimir.css" type="text/css" media="print">
    <style type="text/css">
	  textarea{ 
            font-family: verdana, arial, "ms sans serif", sans-serif; 
            font-size: 10px; 
            margin: 2px;
            line-height: 14px;
            padding-left: 1px;
            color: #000000;
          }
        </style>
        <style type="text/css" media="print">
	  textarea{ 
            font-family: verdana, arial, "ms sans serif", sans-serif; 
            font-size: 8px; 
            margin: 2px;
            line-height: 14px;
            padding-left: 1px;
            color: #000000;
          }
          
          select{ 
            font-family: verdana, arial, "ms sans serif", sans-serif; 
            font-size: 8px; 
            margin: 1px;
            line-height: 10px;
            padding-left: 1px;
          }
		 
         input{ 
           font-family: verdana, arial, "ms sans serif", sans-serif; 
           font-size: 8px; 
           margin: 1px;
           line-height: 10px;
           padding-left: 1px;
           color: #000000;
         }
        </style>
    <script language="javascript" src="http://www.newco.dev.br/General/general.js"></script>
    <script language="javascript">
      <!--


         var msgSinMuestras='Por favor, introduzca el número de muestras que se enviarán';
         var msgCantidadUnidadesEnteras='Por favor, introduzca un número valido';
         
         var msgSinReferencia='Por favor, Introduzca la referencia del producto que se ajusta la solicitud.';
         
         var msgSinVerificar='Por favor, confirme que ha comprobado los datos proporcionados por el cliente.';
         
         var msgSinDescripcion='Por favor, rellene la descripción del producto';
      
     
      

          function CerrarVentana(){
            window.close(); 
          }
      

      

      
      
      function ValidarFormulario(form,accion){
        var errores=0;
 
        /* quitamos los espacios sobrantes  */
        
        for(var n=0;n<form.length;n++){
          if(form.elements[n].type=='text'){
            form.elements[n].value=quitarEspacios(form.elements[n].value);
          }
        }
        
        
        
         
        if(!errores){
          if(form.elements['REFERENCIA'].type=='text'){
            if(esNulo(form.elements['REFERENCIA'].value)){
              alert(msgSinReferencia);
              form.elements['REFERENCIA'].focus();
              errores++;
            }
          }
          else{
            if(esNulo(form.elements['REFERENCIA_DEL_PROVEEDOR'].value)){
              alert(msgSinReferencia);
              form.elements['REFERENCIA_DEL_PROVEEDOR'].focus();
              errores++;
            }
          }
        }

        if(!errores){
          if(form.elements['PRODUCTO'].type=='text'){
            if(esNulo(form.elements['PRODUCTO'].value)){
              alert(msgSinDescripcion);
              form.elements['PRODUCTO'].focus();
              errores++;
            }
          }
          else{
            if(esNulo(form.elements['PRODUCTO_DEL_PROVEEDOR'].value)){
              alert(msgSinDescripcion);
              form.elements['PRODUCTO_DEL_PROVEEDOR'].focus();
              errores++;
            }
          }
        }
        
        if((!errores) && (form.elements['VALIDADO'].type=='checkbox')){
          if(form.elements['VALIDADO'].checked==false){
            if(form.elements['REFERENCIA'].type=='text'){
              alert(msgSinVerificar);
            }
            else{
              alert(msgSinVerificar);
            }
            form.elements['VALIDADO'].focus();
            errores++;
          }
        }
        
        
        
        if((!errores) && (form.elements['NUMEROMUESTRAS'].type=='text')){
          if((esNulo(form.elements['NUMEROMUESTRAS'].value))){
            alert(msgSinMuestras);
            form.elements['NUMEROMUESTRAS'].focus();
            errores++;
          }
        }
         

        if(!errores){          
          return true;
        }
        else{
          return false;
        } 
      }
      

      function ValidarNumero(obj,decimales){
          
          if(esEnteroPositivo(obj.value)){
            if(decimales>0){
              if(parseFloat(reemplazaComaPorPunto(obj.value))!=0){
                obj.value=anyadirCerosDecimales(reemplazaPuntoPorComa(Round(reemplazaComaPorPunto(obj.value),decimales)),decimales);
              }
            }
          }
          else{
            alert(msgCantidadUnidadesEnteras);
            obj.focus();
          }
        }
        
        function esEnteroPositivo(valor){

          if(valor!=''){
            valor+='';
            for(var n=0;n<valor.length;n++){
              if(valor.substring(n,n+1)<'0' || valor.substring(n,n+1)>'9')
                return false;	
            }
            if(parseInt(valor)>=0){
              return true;
            }
            else{
              return false;
            }
          }
          else{
            return true;
          }
        }
        
        function AceptarSolicitud(form,accion){
          
          if(ValidarFormulario(form,accion)){
            form.elements['ACCION'].value=accion;
            SubmitForm(form);
          }
        }
         
        function FinalizarSolicitud(form,accion){
          form.elements['ACCION'].value=accion;
          SubmitForm(form);
        }
        
  
     //-->
    </script>
    ]]></xsl:text>
  </head>

<body bgcolor="#FFFFFF">
  <xsl:choose>
  <xsl:when test="//SESION_CADUCADA">
    <xsl:apply-templates select="//SESION_CADUCADA"/> 
  </xsl:when>
  <xsl:when test="//ROWSET/ROW/Sorry">
    <xsl:apply-templates select="//ROWSET/ROW/Sorry"/> 
  </xsl:when>
  <xsl:when test="//Status/CERRADO">
    <xsl:apply-templates select="//Status/CERRADO"/> 
  </xsl:when>
  <xsl:when test="//Status/ARCHIVADO">
    <xsl:apply-templates select="//Status/ARCHIVADO"/> 
  </xsl:when>
  <xsl:otherwise>
<!--<p align="center" class="tituloPag">Informe de Evaluación</p>-->
<form method="post" action="SolicitudMuestrasSave.xsql">
  <input type="hidden" name="ACCION"/>
  <input type="hidden" name="IDSOLICITUD" value="{Mantenimiento/SOLICITUDMUESTRAS/IDSOLICITUD}"/>

  <input type="hidden" name="IDUSUARIOSOLICITUD" value="{Mantenimiento/SOLICITUDMUESTRAS/IDUSUARIOSOLICITUD}"/>
  <input type="hidden" name="IDUSUARIORECEPCION" value="{Mantenimiento/SOLICITUDMUESTRAS/IDUSUARIORECEPCION}"/>
  <input type="hidden" name="IDUSUARIOCOMERCIAL" value="{Mantenimiento/SOLICITUDMUESTRAS/IDUSUARIOCOMERCIAL}"/>
  
  
   <p class="tituloPag" align="center">Solicitud muestras</p>
  <table width="100%" align="center">
    <tr>
      <td>
        <table width="100%" border="0" cellspacing="1" cellpadding="3" class="oscuro">
          <tr class="blanco"> 
            <td height="18"  class="blanco">
              <table width="100%" border="0" cellspacing="0" cellpadding="10" align="center">
                <tr>
                  <td> 
                    <table width="100%" border="0" cellspacing="1" cellpadding="3" class="oscuro" align="center">
                      <tr  class="blanco">
                        <td width="164px" align="right" class="claro">
                          <b>
                          Número de solicitud:
                          </b>
                        </td>
                        <td width="*" class="blanco">
                          <font color="NAVY" size="1">
                            <b>
          	                <xsl:value-of select="Mantenimiento/SOLICITUDMUESTRAS/NUMEROSOLICITUD"/>
          	              </b>
          	            </font>
                        </td>
                        <td width="164px" align="right" class="claro">
                          <b>
                          Fecha de solicitud:
                          </b>
                        </td>
                        <td width="164px" class="blanco">
                          <font color="NAVY" size="1">
                            <b>
          	                <xsl:value-of select="Mantenimiento/SOLICITUDMUESTRAS/FECHASOLICITUD"/>
          	              </b>
          	            </font>
                        </td>
                      </tr>
                    </table>
                  </td>
                </tr>
                <tr>
                  <td> 
                <table width="100%" border="0" cellspacing="1" cellpadding="0" class="oscuro" align="center">
                <tr  class="oscuro">
                  <td class="oscuro" colspan="2">
                    <table width="100%" border="0" cellspacing="0" cellpadding="3">
                      <tr>
                        <td>
                          <b>
                            Responsable de la solicitud
                          </b>
                          <br/>
                        </td>
                      </tr>
                    </table>
                  </td>
                </tr>
                       
                <tr align="center" class="claro">
                  <td class="claro" width="100%" height="100%" colspan="2">  
                          <table width="100%" border="0" cellspacing="0" cellpadding="0" height="100%">
                            <tr>
                              <td align="right" width="170px">
                                <table width="100%" border="0" cellspacing="0" cellpadding="3" height="100%">
                                  <tr>
                                    <td align="right" width="100%">
                                      Nombre usuario:
                                    </td>
                                  </tr>
                                </table>
                              </td>
                              <td align="right" width="1px" class="oscuro">
                              </td>
                              <td align="left">
                                <table width="100%" border="0" cellspacing="0" cellpadding="3" height="100%" bgcolor="#FFFFFF">
                                  <tr>
                                    <td align="left" width="100%">
                                      <xsl:value-of select="Mantenimiento/SOLICITUDMUESTRAS/USUARIOSOLICITUD"/><br/>
                                    </td>
                                  </tr>
                                </table>
                              </td>
                            </tr>
                            <tr>
                              <td align="right">
                                <table width="100%" border="0" cellspacing="0" cellpadding="3" height="100%">
                                  <tr>
                                    <td align="right" width="100%">
                                      Centro: 
                                    </td>
                                  </tr>
                                </table>
                              </td>
                              <td align="right" width="1px" class="oscuro">
                              </td>
                              <td align="left">
                                <table width="100%" border="0" cellspacing="0" cellpadding="3" height="100%" bgcolor="#FFFFFF">
                                  <tr>
                                    <td align="left" width="100%">
                                      <xsl:value-of select="Mantenimiento/SOLICITUDMUESTRAS/CENTROSOLICITUD/CENTRO/CEN_NOMBRE"/>
                                    </td>
                                  </tr>
                                </table>
                              </td>
                            </tr>
                            <tr>
                              <td align="right">
                                <table width="100%" border="0" cellspacing="0" cellpadding="3" height="100%">
                                  <tr>
                                    <td align="right" width="100%">
                                      Dirección: 
                                    </td>
                                  </tr>
                                </table>
                              </td>
                              <td align="right" width="1px" class="oscuro">
                              </td>
                              <td align="left">
                                <table width="100%" border="0" cellspacing="0" cellpadding="3" height="100%" bgcolor="#FFFFFF">
                                  <tr>
                                    <td align="left" width="100%">
                                      <xsl:value-of select="Mantenimiento/SOLICITUDMUESTRAS/CENTROSOLICITUD/CENTRO/CEN_DIRECCION"/>,&nbsp;
                                      <xsl:value-of select="Mantenimiento/SOLICITUDMUESTRAS/CENTROSOLICITUD/CENTRO/CEN_CPOSTAL"/>&nbsp;
                                      <xsl:value-of select="Mantenimiento/SOLICITUDMUESTRAS/CENTROSOLICITUD/CENTRO/CEN_POBLACION"/>&nbsp;
                                      (<xsl:value-of select="Mantenimiento/SOLICITUDMUESTRAS/CENTROSOLICITUD/CENTRO/CEN_PROVINCIA"/>)&nbsp;
                                    </td>
                                  </tr>
                                </table>
                              </td>
                            </tr>
                            <tr>
                              <td align="right">
                                <table width="100%" border="0" cellspacing="0" cellpadding="3" height="100%">
                                  <tr>
                                    <td align="right" width="100%">
                                      Teléfono:
                                    </td>
                                  </tr>
                                </table>
                              </td>
                              <td align="right" width="1px" class="oscuro">
                              </td>
                              <td align="left">
                                <table width="100%" border="0" cellspacing="0" cellpadding="3" height="100%" bgcolor="#FFFFFF">
                                  <tr>
                                    <td align="left" width="100%">
                                      <xsl:value-of select="Mantenimiento/SOLICITUDMUESTRAS/CENTROSOLICITUD/CENTRO/CEN_TELEFONO"/>&nbsp;
                                    </td>
                                  </tr>
                                </table>
                              </td>
                            </tr>
                            <tr>
                              <td align="right">
                                <table width="100%" border="0" cellspacing="0" cellpadding="3" height="100%">
                                  <tr>
                                    <td align="right" width="100%">
                                      Fax:
                                    </td>
                                  </tr>
                                </table>
                              </td>
                              <td align="right" width="1px" class="oscuro">
                              </td>
                              <td align="left">
                                <table width="100%" border="0" cellspacing="0" cellpadding="3" height="100%" bgcolor="#FFFFFF">
                                  <tr>
                                    <td align="left" width="100%">
                                      <xsl:value-of select="Mantenimiento/SOLICITUDMUESTRAS/CENTROSOLICITUD/CENTRO/CEN_FAX"/>&nbsp;
                                    </td>
                                  </tr>
                                </table>             
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
                <table width="100%" border="0" cellspacing="1" cellpadding="0" class="oscuro" align="center">
                <tr  class="oscuro">
                  <td class="oscuro" colspan="2">
                    <table width="100%" border="0" cellspacing="0" cellpadding="3">
                      <tr>
                        <td>
                          <b>
                            Responsable de la recepción
                          </b>
                          <br/>
                        </td>
                      </tr>
                    </table>
                  </td>
                </tr>
                       
                <tr align="center" class="claro">
                  <td class="claro" width="100%" height="100%" colspan="2">  
                          <table width="100%" border="0" cellspacing="0" cellpadding="0" height="100%">
                            <tr>
                              <td align="right" width="170px">
                                <table width="100%" border="0" cellspacing="0" cellpadding="3" height="100%">
                                  <tr>
                                    <td align="right" width="100%">
                                      Nombre usuario:
                                    </td>
                                  </tr>
                                </table>
                              </td>
                              <td align="right" width="1px" class="oscuro">
                              </td>
                              <td align="left">
                                <table width="100%" border="0" cellspacing="0" cellpadding="3" height="100%" bgcolor="#FFFFFF">
                                  <tr>
                                    <td align="left" width="100%">
                                      <b><xsl:value-of select="Mantenimiento/SOLICITUDMUESTRAS/USUARIORECEPCION"/></b><br/>
                                    </td>
                                  </tr>
                                </table>
                              </td>
                            </tr>
                            <tr>
                              <td align="right">
                                <table width="100%" border="0" cellspacing="0" cellpadding="3" height="100%">
                                  <tr>
                                    <td align="right" width="100%">
                                      Centro: 
                                    </td>
                                  </tr>
                                </table>
                              </td>
                              <td align="right" width="1px" class="oscuro">
                              </td>
                              <td align="left">
                                <table width="100%" border="0" cellspacing="0" cellpadding="3" height="100%" bgcolor="#FFFFFF">
                                  <tr>
                                    <td align="left" width="100%">
                                      <b><xsl:value-of select="Mantenimiento/SOLICITUDMUESTRAS/CENTRORECEPCION/CENTRO/CEN_NOMBRE"/></b>
                                    </td>
                                  </tr>
                                </table>
                              </td>
                            </tr>
                            <tr>
                              <td align="right">
                                <table width="100%" border="0" cellspacing="0" cellpadding="3" height="100%">
                                  <tr>
                                    <td align="right" width="100%">
                                      Dirección: 
                                    </td>
                                  </tr>
                                </table>
                              </td>
                              <td align="right" width="1px" class="oscuro">
                              </td>
                              <td align="left">
                                <table width="100%" border="0" cellspacing="0" cellpadding="3" height="100%" bgcolor="#FFFFFF">
                                  <tr>
                                    <td align="left" width="100%">
                                      <xsl:value-of select="Mantenimiento/SOLICITUDMUESTRAS/CENTRORECEPCION/CENTRO/CEN_DIRECCION"/>,&nbsp;
                                      <xsl:value-of select="Mantenimiento/SOLICITUDMUESTRAS/CENTRORECEPCION/CENTRO/CEN_CPOSTAL"/>&nbsp;
                                      <xsl:value-of select="Mantenimiento/SOLICITUDMUESTRAS/CENTRORECEPCION/CENTRO/CEN_POBLACION"/>&nbsp;
                                      (<xsl:value-of select="Mantenimiento/SOLICITUDMUESTRAS/CENTRORECEPCION/CENTRO/CEN_PROVINCIA"/>)&nbsp;
                                    </td>
                                  </tr>
                                </table>
                              </td>
                            </tr>
                            <tr>
                              <td align="right">
                                <table width="100%" border="0" cellspacing="0" cellpadding="3" height="100%">
                                  <tr>
                                    <td align="right" width="100%">
                                      Teléfono:
                                    </td>
                                  </tr>
                                </table>
                              </td>
                              <td align="right" width="1px" class="oscuro">
                              </td>
                              <td align="left">
                                <table width="100%" border="0" cellspacing="0" cellpadding="3" height="100%" bgcolor="#FFFFFF">
                                  <tr>
                                    <td align="left" width="100%">
                                      <xsl:value-of select="Mantenimiento/SOLICITUDMUESTRAS/CENTRORECEPCION/CENTRO/CEN_TELEFONO"/>&nbsp;
                                    </td>
                                  </tr>
                                </table>
                              </td>
                            </tr>
                            <tr>
                              <td align="right">
                                <table width="100%" border="0" cellspacing="0" cellpadding="3" height="100%">
                                  <tr>
                                    <td align="right" width="100%">
                                      Fax:
                                    </td>
                                  </tr>
                                </table>
                              </td>
                              <td align="right" width="1px" class="oscuro">
                              </td>
                              <td align="left">
                                <table width="100%" border="0" cellspacing="0" cellpadding="3" height="100%" bgcolor="#FFFFFF">
                                  <tr>
                                    <td align="left" width="100%">
                                      <xsl:value-of select="Mantenimiento/SOLICITUDMUESTRAS/CENTRORECEPCION/CENTRO/CEN_FAX"/>&nbsp;
                                    </td>
                                  </tr>
                                </table>             
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
                <table width="100%" border="0" cellspacing="1" cellpadding="0" class="oscuro" align="center">
                <tr  class="oscuro">
                  <td class="oscuro" colspan="2">
                    <table width="100%" border="0" cellspacing="0" cellpadding="3">
                      <tr>
                        <td>
                          <b>
                            	Responsable comercial
                          </b>
                          <br/>
                        </td>
                      </tr>
                    </table>
                  </td>
                </tr>
                       
                <tr align="center" class="claro">
                  <td class="claro" width="100%" height="100%" colspan="2">  
                          <table width="100%" border="0" cellspacing="0" cellpadding="0" height="100%">
                            <tr>
                              <td align="right" width="170px">
                                <table width="100%" border="0" cellspacing="0" cellpadding="3" height="100%">
                                  <tr>
                                    <td align="right" width="100%">
                                      Nombre usuario:
                                    </td>
                                  </tr>
                                </table>
                              </td>
                              <td align="right" width="1px" class="oscuro">
                              </td>
                              <td align="left">
                                <table width="100%" border="0" cellspacing="0" cellpadding="3" height="100%" bgcolor="#FFFFFF">
                                  <tr>
                                    <td align="left" width="100%">
                                      <xsl:value-of select="Mantenimiento/SOLICITUDMUESTRAS/USUARIOCOMERCIAL"/><br/>
                                    </td>
                                  </tr>
                                </table>
                              </td>
                            </tr>
                            <tr>
                              <td align="right">
                                <table width="100%" border="0" cellspacing="0" cellpadding="3" height="100%">
                                  <tr>
                                    <td align="right" width="100%">
                                      Centro: 
                                    </td>
                                  </tr>
                                </table>
                              </td>
                              <td align="right" width="1px" class="oscuro">
                              </td>
                              <td align="left">
                                <table width="100%" border="0" cellspacing="0" cellpadding="3" height="100%" bgcolor="#FFFFFF">
                                  <tr>
                                    <td align="left" width="100%">
                                      <xsl:value-of select="Mantenimiento/SOLICITUDMUESTRAS/CENTROCOMERCIAL/CENTRO/CEN_NOMBRE"/>
                                    </td>
                                  </tr>
                                </table>
                              </td>
                            </tr>
                            <tr>
                              <td align="right">
                                <table width="100%" border="0" cellspacing="0" cellpadding="3" height="100%">
                                  <tr>
                                    <td align="right" width="100%">
                                      Dirección: 
                                    </td>
                                  </tr>
                                </table>
                              </td>
                              <td align="right" width="1px" class="oscuro">
                              </td>
                              <td align="left">
                                <table width="100%" border="0" cellspacing="0" cellpadding="3" height="100%" bgcolor="#FFFFFF">
                                  <tr>
                                    <td align="left" width="100%">
                                      <xsl:value-of select="Mantenimiento/SOLICITUDMUESTRAS/CENTROCOMERCIAL/CENTRO/CEN_DIRECCION"/>,&nbsp;
                                      <xsl:value-of select="Mantenimiento/SOLICITUDMUESTRAS/CENTROCOMERCIAL/CENTRO/CEN_CPOSTAL"/>&nbsp;
                                      <xsl:value-of select="Mantenimiento/SOLICITUDMUESTRAS/CENTROCOMERCIAL/CENTRO/CEN_POBLACION"/>&nbsp;
                                      (<xsl:value-of select="Mantenimiento/SOLICITUDMUESTRAS/CENTROCOMERCIAL/CENTRO/CEN_PROVINCIA"/>)&nbsp;
                                    </td>
                                  </tr>
                                </table>
                              </td>
                            </tr>
                            <tr>
                              <td align="right">
                                <table width="100%" border="0" cellspacing="0" cellpadding="3" height="100%">
                                  <tr>
                                    <td align="right" width="100%">
                                      Teléfono:
                                    </td>
                                  </tr>
                                </table>
                              </td>
                              <td align="right" width="1px" class="oscuro">
                              </td>
                              <td align="left">
                                <table width="100%" border="0" cellspacing="0" cellpadding="3" height="100%" bgcolor="#FFFFFF">
                                  <tr>
                                    <td align="left" width="100%">
                                      <xsl:value-of select="Mantenimiento/SOLICITUDMUESTRAS/CENTROCOMERCIAL/CENTRO/CEN_TELEFONO"/>&nbsp;
                                    </td>
                                  </tr>
                                </table>
                              </td>
                            </tr>
                            <tr>
                              <td align="right">
                                <table width="100%" border="0" cellspacing="0" cellpadding="3" height="100%">
                                  <tr>
                                    <td align="right" width="100%">
                                      Fax:
                                    </td>
                                  </tr>
                                </table>
                              </td>
                              <td align="right" width="1px" class="oscuro">
                              </td>
                              <td align="left">
                                <table width="100%" border="0" cellspacing="0" cellpadding="3" height="100%" bgcolor="#FFFFFF">
                                  <tr>
                                    <td align="left" width="100%">
                                      <xsl:value-of select="Mantenimiento/SOLICITUDMUESTRAS/CENTROCOMERCIAL/CENTRO/CEN_FAX"/>&nbsp;
                                    </td>
                                  </tr>
                                </table>             
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
            
            <table width="100%" border="0" cellspacing="1" cellpadding="0" class="oscuro" align="center">
                <tr  class="oscuro">
                  <td class="oscuro">
                    <table width="100%" border="0" cellspacing="0" cellpadding="3">
                      <tr>
                        <td>
                          <b>
                            Muestras y documentación técnica solicitada:
                          </b>
                          <br/>
                        </td>
                      </tr>
                    </table>
                  </td>
                </tr> 
                <tr align="center" class="claro">
                  <td class="claro" width="100%" height="100%">  
                          <table width="100%" border="0" cellspacing="0" cellpadding="0" height="100%">
                            <tr>
                              <td align="right" width="170px">
                                <table width="100%" border="0" cellspacing="0" cellpadding="3" height="100%">
                                  <tr>
                                    <td align="right" width="100%">
                                      Referencia del producto:<span class="camposObligatorios">*</span>&nbsp;
                                    </td>
                                  </tr>
                                </table>
                              </td>
                              <td align="right" width="1px" class="oscuro">
                              </td>
                              <td align="left">
                                <table width="100%" border="0" cellspacing="0" cellpadding="3" height="100%" bgcolor="#FFFFFF">
                                  <tr>
                                    <td align="left" width="125px">
                                      <xsl:choose>
                                        <xsl:when test="Mantenimiento/SOLICITUDMUESTRAS/IDESTADO=15 and Mantenimiento/US_ID=Mantenimiento/SOLICITUDMUESTRAS/IDUSUARIOCOMERCIAL and Mantenimiento/READ_ONLY!='S'">
                                          <!-- no existe producto real -->
                                          <xsl:choose>
                                            <xsl:when test="Mantenimiento/SOLICITUDMUESTRAS/IDPRODUCTO=''">
                                              <!-- no esta validada -->
                                              <xsl:choose>
                                                <xsl:when test="Mantenimiento/SOLICITUDMUESTRAS/REFERENCIA_VALIDADA='N'">
                                                  <input type="text" name="REFERENCIA" value="{Mantenimiento/SOLICITUDMUESTRAS/REFERENCIA}" size="20" maxlength="100"/>
                                                </xsl:when>
                                                <!-- esta validada -->
                                                <xsl:otherwise>
                                                  <input type="text" name="REFERENCIA" value="{Mantenimiento/SOLICITUDMUESTRAS/REFERENCIA}" size="20" maxlength="100"/>
                                                </xsl:otherwise>
                                              </xsl:choose>
                                            </xsl:when>
                                            <!-- existe el producto -->
                                            <xsl:otherwise>
                                                <!-- no esta validada -->
                                              <xsl:choose>
                                                <xsl:when test="Mantenimiento/SOLICITUDMUESTRAS/REFERENCIA_VALIDADA='N'">
                                                  <input type="hidden" name="REFERENCIA" value="{Mantenimiento/SOLICITUDMUESTRAS/REFERENCIA}"/>
                                                  <input type="text" name="REFERENCIA_DEL_PROVEEDOR" value="{Mantenimiento/SOLICITUDMUESTRAS/REFERENCIA_DEL_PROVEEDOR}" size="20" maxlength="100"/>
                                                  <!--<b><xsl:value-of select="Mantenimiento/SOLICITUDMUESTRAS/REFERENCIA"/></b>-->
                                                </xsl:when>
                                                <!-- esta validada -->
                                                <xsl:otherwise>
                                                  <input type="hidden" name="REFERENCIA" value="{Mantenimiento/SOLICITUDMUESTRAS/REFERENCIA}"/>
                                                  <input type="text" name="REFERENCIA_DEL_PROVEEDOR" value="{Mantenimiento/SOLICITUDMUESTRAS/REFERENCIA_DEL_PROVEEDOR}" size="20" maxlength="100"/>
                                                  <!--<b><xsl:value-of select="Mantenimiento/SOLICITUDMUESTRAS/REFERENCIA"/></b>-->
                                                </xsl:otherwise>
                                              </xsl:choose>
                                            </xsl:otherwise>
                                          </xsl:choose>    
                                        </xsl:when>
                                        <xsl:otherwise>
                                          <b><xsl:value-of select="Mantenimiento/SOLICITUDMUESTRAS/REFERENCIA"/></b>
                                        </xsl:otherwise>
                                      </xsl:choose>
                                    </td>
                                  </tr>
                                </table>
                              </td>
                            </tr>
                            <tr>        
                              <td align="right">
                                <table width="100%" border="0" cellspacing="0" cellpadding="3" height="100%">
                                  <tr>
                                    <td align="right" width="100%">
                                      Nombre del producto:<span class="camposObligatorios">*</span>&nbsp; 
                                    </td>
                                  </tr>
                                </table>
                              </td>
                              <td align="right" width="1px" class="oscuro">
                              </td>
                              <td align="left">
                                <table width="100%" border="0" cellspacing="0" cellpadding="3" height="100%" bgcolor="#FFFFFF">
                                  <tr>
                                    <td align="left" width="100%">
                                      <xsl:choose>
                                        <xsl:when test="Mantenimiento/SOLICITUDMUESTRAS/IDESTADO=15 and Mantenimiento/US_ID=Mantenimiento/SOLICITUDMUESTRAS/IDUSUARIOCOMERCIAL and Mantenimiento/READ_ONLY!='S'">
                                          <!-- no existe producto real -->
                                          <xsl:choose>
                                            <xsl:when test="Mantenimiento/SOLICITUDMUESTRAS/IDPRODUCTO=''">
                                              <!-- no esta validada -->
                                              <xsl:choose>
                                                <xsl:when test="Mantenimiento/SOLICITUDMUESTRAS/REFERENCIA_VALIDADA='N'">
                                                  <input type="text" name="PRODUCTO" value="{Mantenimiento/SOLICITUDMUESTRAS/PRODUCTO}"  size="80" maxlength="500"/>
                                                </xsl:when>
                                                <!-- esta validada -->
                                                <xsl:otherwise>
                                                  <input type="text" name="PRODUCTO" value="{Mantenimiento/SOLICITUDMUESTRAS/PRODUCTO}"  size="80" maxlength="500"/>
                                                </xsl:otherwise>
                                              </xsl:choose>
                                            </xsl:when>
                                            <!-- existe el producto -->
                                            <xsl:otherwise>
                                                <!-- no esta validada -->
                                              <xsl:choose>
                                                <xsl:when test="Mantenimiento/SOLICITUDMUESTRAS/REFERENCIA_VALIDADA='N'">
                                                  <input type="hidden" name="PRODUCTO" value="{Mantenimiento/SOLICITUDMUESTRAS/PRODUCTO}"/>
                                                  <input type="text" name="PRODUCTO_DEL_PROVEEDOR" value="{Mantenimiento/SOLICITUDMUESTRAS/PRODUCTO_DEL_PROVEEDOR}" size="80" maxlength="500"/>
                                                  <!--<b><xsl:value-of select="Mantenimiento/SOLICITUDMUESTRAS/PRODUCTO"/></b>-->
                                                </xsl:when>
                                                <!-- esta validada -->
                                                <xsl:otherwise>
                                                  <input type="hidden" name="PRODUCTO" value="{Mantenimiento/SOLICITUDMUESTRAS/PRODUCTO}"/>
                                                  <input type="text" name="PRODUCTO_DEL_PROVEEDOR" value="{Mantenimiento/SOLICITUDMUESTRAS/PRODUCTO_DEL_PROVEEDOR}" size="80" maxlength="500"/>
                                                  <!--<b><xsl:value-of select="Mantenimiento/SOLICITUDMUESTRAS/PRODUCTO"/></b>-->
                                                </xsl:otherwise>
                                              </xsl:choose>
                                            </xsl:otherwise>
                                          </xsl:choose>
                                        </xsl:when>
                                        <xsl:otherwise>
                                          <b><xsl:value-of select="Mantenimiento/SOLICITUDMUESTRAS/PRODUCTO"/></b>
                                        </xsl:otherwise>
                                      </xsl:choose>
                                    </td>
                                  </tr>
                                </table>
                              </td>
                            </tr>
                            
                            
                            <tr>
                              <td align="right" width="170px">
                                <table width="100%" border="0" cellspacing="0" cellpadding="3" height="100%">
                                  <tr>
                                    <td align="right" width="100%">
                                      &nbsp;
                                    </td>
                                  </tr>
                                </table>
                              </td>
                              <td align="right" width="1px" class="oscuro">
                              </td>
                              <td align="left">
                                <table width="100%" border="0" cellspacing="0" cellpadding="3" height="100%" bgcolor="#FFFFFF">
                                  <tr>
                                    <td align="left" width="100%">
                                      &nbsp;
                                    </td>
                                  </tr>
                                </table>
                              </td>
                            </tr>
                            
                            <tr>
                              <td align="right" width="170px">
                                <table width="100%" border="0" cellspacing="0" cellpadding="3" height="100%">
                                  <tr>
                                    <td align="right" width="100%">
                                      Confirmación:<span class="camposObligatorios">*</span>&nbsp;
                                    </td>
                                  </tr>
                                </table>
                              </td>
                              <td align="right" width="1px" class="oscuro">
                              </td>
                              <td align="left">
                                <table width="100%" border="0" cellspacing="0" cellpadding="3" height="100%" bgcolor="#FFFFFF">
                                  <tr>
                                    
                                    <td align="left" width="*">
                                      <xsl:choose>
                                        <xsl:when test="Mantenimiento/SOLICITUDMUESTRAS/IDESTADO=15 and Mantenimiento/US_ID=Mantenimiento/SOLICITUDMUESTRAS/IDUSUARIOCOMERCIAL and Mantenimiento/READ_ONLY!='S'">
                                          <!-- no existe producto real -->
                                          <xsl:choose>
                                            <xsl:when test="Mantenimiento/SOLICITUDMUESTRAS/IDPRODUCTO=''">
                                              <!-- no esta validada -->
                                              <xsl:choose>
                                                <xsl:when test="Mantenimiento/SOLICITUDMUESTRAS/REFERENCIA_VALIDADA='N'">
                                                  <table width="100%" cellpadding="1" cellspacing="3" align="center">
                                                    <tr>
                                                      <td width="15px">
                                                        <input type="checkbox" name="VALIDADO" unchecked="unchecked"/>
                                                      </td>
                                                      <td>
                                                        &nbsp;Confirmo que he comprobado los datos proporcionados por el cliente
                                                      </td>
                                                    </tr>
                                                  </table>
                                                </xsl:when>
                                                <!-- esta validada -->
                                                <xsl:otherwise>
                                                  <table width="100%" cellpadding="1" cellspacing="3" align="center">
                                                    <tr>
                                                      <td width="15px">
                                                        <input type="checkbox" name="VALIDADO" checked="checked"/>
                                                      </td>
                                                      <td>
                                                        &nbsp;Confirmo que he comprobado los datos proporcionados por el cliente
                                                      </td>
                                                    </tr>
                                                  </table>
                                                </xsl:otherwise>
                                              </xsl:choose>
                                            </xsl:when>
                                            <!-- existe el producto -->
                                            <xsl:otherwise>
                                                <!-- no esta validada -->
                                              <xsl:choose>
                                                <xsl:when test="Mantenimiento/SOLICITUDMUESTRAS/REFERENCIA_VALIDADA='N'">
                                                  <table width="100%" cellpadding="1" cellspacing="3" align="center">
                                                    <tr>
                                                      <td width="15px">
                                                        <input type="checkbox" name="VALIDADO" unchecked="unchecked"/>
                                                      </td>
                                                      <td>
                                                        &nbsp;Confirmo que he comprobado los datos proporcionados por el cliente
                                                      </td>
                                                    </tr>
                                                  </table>
                                                </xsl:when>
                                                <!-- esta validada -->
                                                <xsl:otherwise>
                                                  <table width="100%" cellpadding="1" cellspacing="3" align="center">
                                                    <tr>
                                                      <td width="15px">
                                                        <input type="checkbox" name="VALIDADO" checked="checked"/>
                                                      </td>
                                                      <td>
                                                        &nbsp;Confirmo que he comprobado los datos proporcionados por el cliente
                                                      </td>
                                                    </tr>
                                                  </table>
                                                </xsl:otherwise>
                                              </xsl:choose>
                                            </xsl:otherwise>
                                          </xsl:choose>
                                        </xsl:when>
                                        <xsl:otherwise>
                                          <xsl:choose>
                                            <xsl:when test="Mantenimiento/SOLICITUDMUESTRAS/REFERENCIA_VALIDADA='N'">
                                                  <table width="100%" cellpadding="1" cellspacing="3" align="center">
                                                    <tr>
                                                      <td width="1px">
                                                        <b>No</b>
                                                      </td>
                                                      <td>
                                                        &nbsp;he comprobado los datos proporcionados por el cliente aún.
                                                      </td>
                                                    </tr>
                                                  </table>
                                            </xsl:when>
                                            <!-- esta validada -->
                                            <xsl:otherwise>
                                                  <table width="100%" cellpadding="0" cellspacing="0" align="center">
                                                    <tr>
                                                      <td width="1px">
                                                        <b>Sí</b>
                                                      </td>
                                                      <td>
                                                        . Confirmo que he comprobado los datos proporcionados por el cliente
                                                      </td>
                                                    </tr>
                                                  </table>
                                            </xsl:otherwise>
                                          </xsl:choose>
                                        </xsl:otherwise>
                                      </xsl:choose>
                                    </td>
                                  </tr>
                                </table>
                              </td>
                            </tr>
                            
                            
                            
                            
                            
                            
                            <xsl:if test="(Mantenimiento/SOLICITUDMUESTRAS/REFERENCIA_DEL_PROVEEDOR!='' and Mantenimiento/SOLICITUDMUESTRAS/REFERENCIA!=Mantenimiento/SOLICITUDMUESTRAS/REFERENCIA_DEL_PROVEEDOR) or (Mantenimiento/SOLICITUDMUESTRAS/PRODUCTO_DEL_PROVEEDOR!='' and Mantenimiento/SOLICITUDMUESTRAS/PRODUCTO!=Mantenimiento/SOLICITUDMUESTRAS/PRODUCTO_DEL_PROVEEDOR)">
                              <xsl:choose>
                                <xsl:when test="Mantenimiento/SOLICITUDMUESTRAS/IDESTADO&gt;=25 or Mantenimiento/READ_ONLY='S'">

                            <tr>
                              <td align="right" width="170px">
                                <table width="100%" border="0" cellspacing="0" cellpadding="3" height="100%">
                                  <tr>
                                    <td align="right" width="100%">
                                      &nbsp;
                                    </td>
                                  </tr>
                                </table>
                              </td>
                              <td align="right" width="1px" class="oscuro">
                              </td>
                              <td align="left">
                                <table width="100%" border="0" cellspacing="0" cellpadding="3" height="100%" bgcolor="#FFFFFF">
                                  <tr>
                                    <td align="left" width="100%">
                                      &nbsp;
                                    </td>
                                  </tr>
                                </table>
                              </td>
                            </tr>
                            <tr>
                              <td align="right" width="170px">
                                <table width="100%" border="0" cellspacing="0" cellpadding="3" height="100%">
                                  <tr>
                                    <td align="right" width="100%">
                                      Referencia correcta:&nbsp;
                                    </td>
                                  </tr>
                                </table>
                              </td>
                              <td align="right" width="1px" class="oscuro">
                              </td>
                              <td align="left">
                                <table width="100%" border="0" cellspacing="0" cellpadding="3" height="100%" bgcolor="#FFFFFF">
                                  <tr>
                                    <td align="left" width="125px">
                                      <font color="red"><xsl:value-of select="Mantenimiento/SOLICITUDMUESTRAS/REFERENCIA_DEL_PROVEEDOR"/></font>
                                    </td>
                                    <td align="left" width="*">
                                      &nbsp;
                                    </td>
                                  </tr>
                                </table>
                              </td>
                            </tr>
                            <tr>        
                              <td align="right">
                                <table width="100%" border="0" cellspacing="0" cellpadding="3" height="100%">
                                  <tr>
                                    <td align="right" width="100%">
                                      Nombre correcto:&nbsp; 
                                    </td>
                                  </tr>
                                </table>
                              </td>
                              <td align="right" width="1px" class="oscuro">
                              </td>
                              <td align="left">
                                <table width="100%" border="0" cellspacing="0" cellpadding="3" height="100%" bgcolor="#FFFFFF">
                                  <tr>
                                    <td align="left" width="100%">
                                     <font color="red"><xsl:value-of select="Mantenimiento/SOLICITUDMUESTRAS/PRODUCTO_DEL_PROVEEDOR"/></font>
                                    </td>
                                  </tr>
                                </table>
                              </td>
                            </tr>
                                  
                                  
                                  
                                </xsl:when>
                              </xsl:choose>
                            </xsl:if>


                            <tr>
                              <td align="right" width="170px">
                                <table width="100%" border="0" cellspacing="0" cellpadding="3" height="100%">
                                  <tr>
                                    <td align="right" width="100%">
                                      &nbsp;
                                    </td>
                                  </tr>
                                </table>
                              </td>
                              <td align="right" width="1px" class="oscuro">
                              </td>
                              <td align="left">
                                <table width="100%" border="0" cellspacing="0" cellpadding="3" height="100%" bgcolor="#FFFFFF">
                                  <tr>
                                    <td align="left" width="100%">
                                      &nbsp;
                                    </td>
                                  </tr>
                                </table>
                              </td>
                            </tr>
                            <tr>
                              <td align="right" width="170px">
                                <table width="100%" border="0" cellspacing="0" cellpadding="3" height="100%">
                                  <tr>
                                    <td align="right" width="100%">
                                      Fecha de entrega prevista:
                                    </td>
                                  </tr>
                                </table>
                              </td>
                              <td align="right" width="1px" class="oscuro">
                              </td>
                              <td align="left">
                                <table width="100%" border="0" cellspacing="0" cellpadding="3" height="100%" bgcolor="#FFFFFF">
                                  <tr>
                                    <td align="left" width="100%">
                                          <font color="navy" size="1"><b><xsl:value-of select="Mantenimiento/SOLICITUDMUESTRAS/FECHAPREVISTA"/></b></font>
                                    </td>
                                  </tr>
                                </table>
                              </td>
                            </tr>
                            <tr>
                              <td align="right" width="170px">
                                <table width="100%" border="0" cellspacing="0" cellpadding="3" height="100%">
                                  <tr>
                                    <td align="right" width="100%">
                                      Nº de muestras solicitadas:
                                    </td>
                                  </tr>
                                </table>
                              </td>
                              <td align="right" width="1px" class="oscuro">
                              </td>
                              <td align="left">
                                <table width="100%" border="0" cellspacing="0" cellpadding="3" height="100%" bgcolor="#FFFFFF">
                                  <tr>
                                    <td align="left" width="100%">
                                      <xsl:choose>
                                        <xsl:when test="Mantenimiento/SOLICITUDMUESTRAS/MUESTRASCRITERIO_PROV='S'">
                                          Envíe el número de muestras que considere oportuno para realizar una evaluación del producto
                                        </xsl:when>
                                        <xsl:otherwise>
                                          <font color="navy" size="1"><b><xsl:value-of select="Mantenimiento/SOLICITUDMUESTRAS/MUESTRASPREVISTAS"/></b></font>&nbsp;
                                        </xsl:otherwise>
                                      </xsl:choose>
                                    </td>
                                  </tr>
                                </table>
                              </td>
                            </tr>
                            <tr>
                              <td align="right" width="170px">
                                <table width="100%" border="0" cellspacing="0" cellpadding="3" height="100%">
                                  <tr>
                                    <td align="right" width="100%">
                                      &nbsp;
                                    </td>
                                  </tr>
                                </table>
                              </td>
                              <td align="right" width="1px" class="oscuro">
                              </td>
                              <td align="left">
                                <table width="100%" border="0" cellspacing="0" cellpadding="3" height="100%" bgcolor="#FFFFFF">
                                  <tr>
                                    <td align="left" width="100%">
                                      &nbsp;
                                    </td>
                                  </tr>
                                </table>
                              </td>
                            </tr>
                            <tr>
                              <td align="right" width="170px">
                                <table width="100%" border="0" cellspacing="0" cellpadding="3" height="100%">
                                  <tr>
                                    <td align="right" width="100%">
                                      Comentarios de la solicitud:
                                    </td>
                                  </tr>
                                </table>
                              </td>
                              <td align="right" width="1px" class="oscuro">
                              </td>
                              <td align="left">
                                <table width="100%" border="0" cellspacing="0" cellpadding="3" height="100%" bgcolor="#FFFFFF">
                                  <tr>
                                    <td align="left" width="100%">
                                      <b><xsl:copy-of select="Mantenimiento/SOLICITUDMUESTRAS/COMENTARIOS_SOLICTUD_HTML"/></b>
                                    </td>
                                  </tr>
                                </table>
                              </td>
                            </tr>
                            <tr>
                              <td align="right" width="170px">
                                <table width="100%" border="0" cellspacing="0" cellpadding="3" height="100%">
                                  <tr>
                                    <td align="right" width="100%">
                                      &nbsp;
                                    </td>
                                  </tr>
                                </table>
                              </td>
                              <td align="right" width="1px" class="oscuro">
                              </td>
                              <td align="left">
                                <table width="100%" border="0" cellspacing="0" cellpadding="3" height="100%" bgcolor="#FFFFFF">
                                  <tr>
                                    <td align="left" width="100%">
                                      &nbsp;
                                    </td>
                                  </tr>
                                </table>
                              </td>
                            </tr>
                            <tr>
                              <td align="right" width="170px">
                                <table width="100%" border="0" cellspacing="0" cellpadding="3" height="100%">
                                  <tr>
                                    <td align="right" width="100%">
                                      Nº de muestras enviadas:<span class="camposObligatorios">*</span>&nbsp;
                                    </td>
                                  </tr>
                                </table>
                              </td>
                              <td align="right" width="1px" class="oscuro">
                              </td>
                              <td align="left">
                                <table width="100%" border="0" cellspacing="0" cellpadding="3" height="100%" bgcolor="#FFFFFF">
                                  <tr>
                                    <td align="left" width="100%">
                                      <xsl:choose>
                                        <xsl:when test="Mantenimiento/SOLICITUDMUESTRAS/IDESTADO=15 and Mantenimiento/US_ID=Mantenimiento/SOLICITUDMUESTRAS/IDUSUARIOCOMERCIAL and Mantenimiento/READ_ONLY!='S'">
                                          <!--<input type="text" name="NUMEROMUESTRAS" maxlength="7" size="10" value="{Mantenimiento/SOLICITUDMUESTRAS/MUESTRAS}" onBlur="ValidarNumero(this,0);"/>&nbsp;-->
                                          <input type="text" name="NUMEROMUESTRAS" maxlength="100" size="20" value="{Mantenimiento/SOLICITUDMUESTRAS/MUESTRAS}"/>&nbsp;
                                        </xsl:when>
                                        <xsl:otherwise>
                                          <input type="hidden" name="NUMEROMUESTRAS" value="{Mantenimiento/SOLICITUDMUESTRAS/MUESTRAS}"/>
                                          <xsl:value-of select="Mantenimiento/SOLICITUDMUESTRAS/MUESTRAS"/>&nbsp;
                                        </xsl:otherwise>
                                      </xsl:choose>
                                    </td>
                                  </tr>
                                </table>             
                              </td>
                            </tr>
                            <tr>
                              <td align="right">
                                <table width="100%" border="0" cellspacing="0" cellpadding="3" height="100%">
                                  <tr>
                                    <td align="right" width="100%">
                                      Documentación enviada:
                                    </td>
                                  </tr>
                                </table>
                              </td>
                              <td align="right" width="1px" class="oscuro">
                              </td>
                              <td align="left">
                                <table width="100%" border="0" cellspacing="0" cellpadding="3" height="100%" bgcolor="#FFFFFF">
                                  <tr>
                                    <td width="100px" align="right">
                                       Ficha técnica:
                                    </td>
                                    <td width="50px" align="left">
                                      
                                      <xsl:choose>
                                        <xsl:when test="Mantenimiento/SOLICITUDMUESTRAS/IDESTADO=15 and Mantenimiento/US_ID=Mantenimiento/SOLICITUDMUESTRAS/IDUSUARIOCOMERCIAL and Mantenimiento/READ_ONLY!='S'">
                                          <input type="checkbox" name="CHK_FICHATECNICA">
                                            <xsl:if test="Mantenimiento/SOLICITUDMUESTRAS/FICHATECNICA='S'">
                                              <xsl:attribute name="checked">checked</xsl:attribute>
                                            </xsl:if>
                                          </input> 
                                        </xsl:when>
                                        <xsl:otherwise>
                                          <input type="hidden" name="CHK_FICHATECNICA" value="{Mantenimiento/INFORME_EVALUACION/FICHATECNICA}"/>
                                          <xsl:choose>
                                            <xsl:when test="Mantenimiento/SOLICITUDMUESTRAS/FICHATECNICA='S'">
                                              Si
                                            </xsl:when>
                                            <xsl:otherwise>
                                              No
                                            </xsl:otherwise>
                                          </xsl:choose>
                                        </xsl:otherwise>
                                      </xsl:choose>
                                    </td>
                                    <td width="100px" align="right">
                                       Certificado CE
                                    </td>
                                    <td width="*" align="left">
                                       
                                       <xsl:choose>
                                        <xsl:when test="Mantenimiento/SOLICITUDMUESTRAS/IDESTADO=15 and Mantenimiento/US_ID=Mantenimiento/SOLICITUDMUESTRAS/IDUSUARIOCOMERCIAL and Mantenimiento/READ_ONLY!='S'">
                                          <input type="checkbox" name="CHK_CERTIFICADO">
                                            <xsl:if test="Mantenimiento/SOLICITUDMUESTRAS/CERTIFICADO='S'">
                                              <xsl:attribute name="checked">checked</xsl:attribute>
                                            </xsl:if>
                                          </input> 
                                        </xsl:when>
                                        <xsl:otherwise>
                                          <input type="hidden" name="CHK_CERTIFICADO" value="{Mantenimiento/INFORME_EVALUACION/CERTIFICADO}"/>
                                          <xsl:choose>
                                            <xsl:when test="Mantenimiento/SOLICITUDMUESTRAS/CERTIFICADO='S'">
                                              Si
                                            </xsl:when>
                                            <xsl:otherwise>
                                              No
                                            </xsl:otherwise>
                                          </xsl:choose>
                                        </xsl:otherwise>
                                      </xsl:choose>
                                    </td>
                                  </tr>
                                </table>             
                              </td>
                            </tr>
                            <tr>
                              <td align="right" width="170px">
                                <table width="100%" border="0" cellspacing="0" cellpadding="3" height="100%">
                                  <tr>
                                    <td align="right" width="100%">
                                      &nbsp;
                                    </td>
                                  </tr>
                                </table>
                              </td>
                              <td align="right" width="1px" class="oscuro">
                              </td>
                              <td align="left">
                                <table width="100%" border="0" cellspacing="0" cellpadding="3" height="100%" bgcolor="#FFFFFF">
                                  <tr>
                                    <td align="left" width="100%">
                                      &nbsp;
                                    </td>
                                  </tr>
                                </table>
                              </td>
                            </tr>
                            <tr>
                              <td align="right">
                                <table width="100%" border="0" cellspacing="0" cellpadding="3" height="100%">
                                  <tr>
                                    <td align="right" width="100%">
                                      Comentarios del proveedor:
                                    </td>
                                  </tr>
                                </table>
                              </td>
                              <td align="right" width="1px" class="oscuro">
                              </td>
                              <td align="left">
                                <table width="100%" border="0" cellspacing="0" cellpadding="3" height="100%" bgcolor="#FFFFFF">
                                  <tr>
                                    <td align="left" width="100%">
                                      <xsl:choose>
                                        <xsl:when test="Mantenimiento/SOLICITUDMUESTRAS/IDESTADO=15 and Mantenimiento/US_ID=Mantenimiento/SOLICITUDMUESTRAS/IDUSUARIOCOMERCIAL and Mantenimiento/READ_ONLY!='S'">
                                          <textarea name="COMENTARIOS" cols="50" rows="3">
                                            <xsl:value-of select="Mantenimiento/SOLICITUDMUESTRAS/COMENTARIOS"/>
                                          </textarea>
                                        </xsl:when>
                                        <xsl:otherwise>
                                          <xsl:copy-of select="Mantenimiento/SOLICITUDMUESTRAS/COMENTARIOS_HTML"/>
                                        </xsl:otherwise>
                                      </xsl:choose>
                                    </td>
                                  </tr>
                                </table>       
                              </td>
                            </tr>
                          </table>
                  </td>
                </tr>
              </table>

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
        Los campos marcados con (<span class="camposObligatorios">*</span>) son obligatorios.
      </td>
    </tr>
    
  </table>
  <br/>
  <br/>
    
      <table width="100%">
        <tr align="center">
          
          
        <xsl:choose>
        <xsl:when test="//READ_ONLY!='S'">
        
          <td>
            <xsl:call-template name="boton">
              <xsl:with-param name="path" select="Mantenimiento/botones/button[@label='Cancelar']"/>
            </xsl:call-template>
          </td>
        
          <xsl:choose>
            <xsl:when test="Mantenimiento/SOLICITUDMUESTRAS/IDESTADO=15 and //US_ID=Mantenimiento/SOLICITUDMUESTRAS/IDUSUARIOCOMERCIAL">
              <td>
                <xsl:call-template name="boton">
                  <xsl:with-param name="path" select="Mantenimiento/botones/button[@label='Guardar']"/>
                </xsl:call-template>
              </td>
            </xsl:when>
            <xsl:when test="Mantenimiento/SOLICITUDMUESTRAS/IDESTADO=25 and //US_ID=Mantenimiento/SOLICITUDMUESTRAS/IDUSUARIORECEPCION">
              <td>
                <xsl:call-template name="boton">
                  <xsl:with-param name="path" select="Mantenimiento/botones/button[@label='Recibidas']"/>
                </xsl:call-template>
              </td>
            </xsl:when>
            <!--<xsl:when test="Mantenimiento/SOLICITUDMUESTRAS/IDESTADO=40 and //US_ID=Mantenimiento/SOLICITUDMUESTRAS/IDUSUARIOCOMERCIAL">
              <td>
                <xsl:call-template name="boton">
                  <xsl:with-param name="path" select="Mantenimiento/botones/button[@label='Archivar']"/>
                </xsl:call-template>
              </td>
            </xsl:when>
            -->
          </xsl:choose>
        </xsl:when>
        <xsl:otherwise>
          <td>
            <xsl:call-template name="boton">
              <xsl:with-param name="path" select="Mantenimiento/botones/button[@label='Cerrar']"/>
            </xsl:call-template>
          </td>
        </xsl:otherwise>
      </xsl:choose>
          <td>
            <xsl:call-template name="boton">
              <xsl:with-param name="path" select="Mantenimiento/botones/button[@label='Imprimir']"/>
            </xsl:call-template>
          </td>
        </tr>
      </table>
</form>
</xsl:otherwise>
</xsl:choose>
  </body>
  </html>
</xsl:template>


<xsl:template match="Status/CERRADO">


  <p class="tituloPag">
  <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='CATPRIV-0660' and @lang=$lang]" disable-output-escaping="yes"/>
  </p>
  <hr/>
  <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='CATPRIV-0670' and @lang=$lang]" disable-output-escaping="yes"/>
  <br/> 
  <br/> 
  <xsl:call-template name="boton">
              <xsl:with-param name="path" select="//Mantenimiento/botones/button[@label='Cerrar']"/>
            </xsl:call-template>
   
</xsl:template>  

<xsl:template match="Status/ARCHIVADO">


  <p class="tituloPag">
  <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='CATPRIV-0662' and @lang=$lang]" disable-output-escaping="yes"/>
  </p>
  <hr/>
  <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='CATPRIV-0672' and @lang=$lang]" disable-output-escaping="yes"/>
  <br/> 
  <br/> 
  <xsl:call-template name="boton">
              <xsl:with-param name="path" select="//Mantenimiento/botones/button[@label='Cerrar']"/>
            </xsl:call-template>
   
</xsl:template>  



</xsl:stylesheet>
