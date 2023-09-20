<?xml version="1.0" encoding="iso-8859-1" ?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href = "http://www.newco.dev.br/General/General.xsl" />
  <xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
  <xsl:param name="lang" select="@lang"/>  
  <xsl:template match="/">

<html>
<head>
<title>Informe de no conformidad de producto</title>
  <xsl:text disable-output-escaping="yes"><![CDATA[
    <link rel="stylesheet" href="http://www.newco.dev.br/General/Estilos.css" type="text/css">
    <link rel="stylesheet" href="http://www.newco.dev.br/General/EstilosImprimir.css" type="text/css" media="print">
    <script language="javascript" src="http://www.newco.dev.br/General/general.js"></script>
    <script language="javascript">
      <!--
   
        var msgSinResponsable='Por favor, introduzca el nombre del usuario No Conforme con el producto';
        var msgSinCargoResponsable='Por favor, introduzca el cargo del usuario No Conforme con el producto';
        var msgSinFamilias='Por favor, seleccione la familia a la que pertenece el producto';
        var msgSinSubfamilias='Por favor, seleccione la subfamilia a la que pertenece el producto';
        var msgSinProductosEstandar='Por favor, seleccione el producto estándar';
        var msgSinProveedores='Por favor, seleccione el proveedor del producto';
        var msgBorrarInformeNoConformidad='¿Borrar el informe de no conformidad?';
        var msgSinComentarios='Por favor, introduzca la descripción de la No Conformidad.\nDebe introducir sus comentarios en, al menos, uno de los recuadros de texto funcional / servicios';
        
        
        var msgSinAnalisisFuncionales='Por favor, Introduzca los comentarios del análisis de la No conformidad de producto (funcional).';
        var msgSinAccionesFuncionales='Por favor, Introduzca los comentarios de las acciones a realizar sobre la  No conformidad de producto (funcional).';
        var msgSinAnalisisServicios='Por favor, Introduzca los comentarios del análisis de la No conformidad de producto (servicio).';
        var msgSinAccionesServicios='Por favor, Introduzca los comentarios de las acciones a realizar sobre la  No conformidad de producto (servicio).';
        var msgSinConclusiones='Por favor, seleccione una opción en el desplegable de conclusiones.';
        
        
        
          
        
        function inicializarDesplegable(form,objName,elementoPorDefecto){
        
          var objFrame=new Object();
          objFrame=obtenerFrame(top,'xml');
          
          if(objFrame!=null){
            if(objName=='FAMILIAS'){
              objFrame.habilitarDeshabilitarDesplegable(form,'SUBFAMILIAS','D');
              objFrame.habilitarDeshabilitarDesplegable(form,'PRODUCTOSESTANDAR','D');
              objFrame.habilitarDeshabilitarDesplegable(form,'PROVEEDORES','D');
              peticionDatos('SUBFAMILIAS');
            }
            else{
              objFrame.inicializarDesplegable(form,objName,elementoPorDefecto);
            }
          }
        }
        
        //guardamos los valores iniciales en variables javascript
        
         ]]></xsl:text>
         
           var hayQueInicializar=0;
           var idFamiliaInicial='-1';
           var idSubfamiliaInicial='-1';
           var idProductoEstandarInicial='-1';
           var idProveedorInicial='-1';
       
          <xsl:if test="Mantenimiento/NOCONFORMIDAD/DESPLEGABLES">
            hayQueInicializar=1;
            idFamiliaInicial='<xsl:value-of select="Mantenimiento/NOCONFORMIDAD/DESPLEGABLES/IDFAMILIA"/>';
            idSubfamiliaInicial='<xsl:value-of select="Mantenimiento/NOCONFORMIDAD/DESPLEGABLES/IDSUBFAMILIA"/>';
            idProductoEstandarInicial='<xsl:value-of select="Mantenimiento/NOCONFORMIDAD/DESPLEGABLES/IDPRODUCTOESTANDAR"/>';
            idProveedorInicial='<xsl:value-of select="Mantenimiento/NOCONFORMIDAD/DESPLEGABLES/IDPROVEEDOR"/>';
 
          </xsl:if>
          
          var solicitarComentariosFuncionales=0;
          var solicitarComentariosServicios=0;
          
          <xsl:if test="Mantenimiento/NOCONFORMIDAD/SOLICITRAR_COMENTARIOS_FUNCIONALES">
          
            solicitarComentariosFuncionales=1;
            
          </xsl:if>
          
          <xsl:if test="Mantenimiento/NOCONFORMIDAD/SOLICITRAR_COMENTARIOS_SERVICIOS">
          
            solicitarComentariosServicios=1;
          
          </xsl:if>
          
          
        
          
        <xsl:text disable-output-escaping="yes"><![CDATA[
        
           
        function peticionDatos(accion){
          
          var identificador='';
          
          var objFrame=new Object();
          objFrame=obtenerFrame(top,'xml');
          
          if(accion=='SUBFAMILIAS'){
            if(document.forms['form1'].elements['FAMILIAS'].value!=-1){
              identificador=document.forms['form1'].elements['FAMILIAS'].value;
              if(objFrame!=null){
                objFrame.location.href='NoConformidadProducto_XML.xsql?ACCION='+accion+'&IDENTIFICADOR='+identificador;
              }
            }
            else{
              if(objFrame!=null){
                objFrame.location.href='NoConformidadProducto_XML.xsql';
              }
            }
          }
          else{
            if(objFrame!=null){
              objFrame.location.href='NoConformidadProducto_XML.xsql';
            }
          }
        }
        
        function ValidarFormulario(form,accion){
          var errores=0;
 
          /* quitamos los espacios sobrantes  */
        
          for(var n=0;n<form.length;n++){
            if(form.elements[n].type=='text'){
              form.elements[n].value=quitarEspacios(form.elements[n].value);
            }
          }
          
          // estado 0, 10 (inicio del proceso)
          
          
          
          if(form.elements['STATUS'].value<=10){
          
            if(accion!='PENDIENTE'){
              if(!errores && esNulo(form.elements['RECLAMANTE'].value)){
                errores++;
                alert(msgSinResponsable);
                form.elements['RECLAMANTE'].focus();
              }
            }
          
            if(accion!='PENDIENTE'){
              if(!errores && esNulo(form.elements['CARGORECLAMANTE'].value)){
                errores++;
                alert(msgSinCargoResponsable);
                form.elements['CARGORECLAMANTE'].focus();
              }
            }
          
            if(!errores && (esNulo(form.elements['FAMILIAS'].value) || form.elements['FAMILIAS'].value<1)){
              errores++;
              alert(msgSinFamilias);
              form.elements['FAMILIAS'].focus();
            }
          
            if(!errores && (esNulo(form.elements['SUBFAMILIAS'].value) || form.elements['SUBFAMILIAS'].value<1)){
              errores++;
              alert(msgSinSubfamilias);
              form.elements['SUBFAMILIAS'].focus();
            }
          
            if(!errores && (esNulo(form.elements['PRODUCTOSESTANDAR'].value) || form.elements['PRODUCTOSESTANDAR'].value<1)){
              errores++;
              alert(msgSinProductosEstandar);
              form.elements['PRODUCTOSESTANDAR'].focus();
            }
          
            if(!errores && (esNulo(form.elements['PROVEEDORES'].value) || form.elements['PROVEEDORES'].value<1)){
              errores++;
              alert(msgSinProveedores);
              form.elements['PROVEEDORES'].focus();
            }
          
            if(accion!='PENDIENTE'){
              if(!errores && (esNulo(form.elements['COMENTARIOS_FUNCIONALES'].value) && esNulo(form.elements['COMENTARIOS_SERVICIOS'].value))){
                errores++;
                alert(msgSinComentarios);
                form.elements['COMENTARIOS_FUNCIONALES'].focus();
              }
            }
          }
          else{
            if(form.elements['STATUS'].value==30){
              
              if(accion!='PENDIENTE'){
                if(solicitarComentariosFuncionales){
                  if(!errores && esNulo(form.elements['ANALISIS_FUNCIONALES'].value)){
                    errores++;
                    alert(msgSinAnalisisFuncionales);
                    form.elements['ANALISIS_FUNCIONALES'].focus();
                  }
                }
              }
              
              if(accion!='PENDIENTE'){
                if(solicitarComentariosFuncionales){
                  if(!errores && esNulo(form.elements['ACCIONES_FUNCIONALES'].value)){
                    errores++;
                    alert(msgSinAccionesFuncionales);
                    form.elements['ACCIONES_FUNCIONALES'].focus();
                  }
                }
              }
              
              if(accion!='PENDIENTE'){
                if(solicitarComentariosServicios){
                  if(!errores && esNulo(form.elements['ANALISIS_SERVICIOS'].value)){
                    errores++;
                    alert(msgSinAnalisisServicios);
                    form.elements['ANALISIS_SERVICIOS'].focus();
                  }
                }
              }
              
              if(accion!='PENDIENTE'){
                if(solicitarComentariosServicios){
                  if(!errores && esNulo(form.elements['ACCIONES_SERVICIOS'].value)){
                    errores++;
                    alert(msgSinAccionesServicios);
                    form.elements['ACCIONES_SERVICIOS'].focus();
                  }
                }
              }
          
              if(accion!='PENDIENTE'){
                if(!errores && esNulo(form.elements['IDCONCLUSION'].value)){
                  errores++;
                  alert(msgSinConclusiones);
                  form.elements['IDCONCLUSION'].focus();
                }
              }
            }
          }
 
          if(!errores){
            return true;
          }
          else{
            return false;
          }
            
            
        }
        
        
        function GuardarCambios(form,accion){
          
          switch(accion){
            case 'PENDIENTE':
             if(ValidarFormulario(form,accion)){
               form.elements['ACCION'].value=accion;
               SubmitForm(form);
             }
            break;
            
            case 'BORRAR':
              if(confirm(msgBorrarInformeNoConformidad)){
                form.elements['ACCION'].value=accion;
                SubmitForm(form);
              }
            break;
            case 'ENVIAR':
              if(ValidarFormulario(form,accion)){
                form.elements['ACCION'].value=accion;
                SubmitForm(form);
              }
            break;
            case 'FINALIZAR':
            form.elements['ACCION'].value=accion;
            SubmitForm(form);
          }
        }
        
        
        ]]></xsl:text>
          
          <xsl:choose>
            <xsl:when test="Mantenimiento/NOCONFORMIDAD/STATUS=0">
              
              function CerrarVentana(){
                window.parent.location='about:blank';
              }
              
            </xsl:when>
            <xsl:otherwise>
              
              function CerrarVentana(){
                window.parent.close();
              }
            
            </xsl:otherwise>
          </xsl:choose>
           
        <xsl:text disable-output-escaping="yes"><![CDATA[
        
        
        
        
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
  <xsl:otherwise>
  <xsl:attribute name="onLoad">
    <xsl:choose>
      <xsl:when test="Mantenimiento/NOCONFORMIDAD/STATUS&lt;20 and Mantenimiento/READ_ONLY!='S'">
        peticionDatos('FAMILIAS');
      </xsl:when>
    </xsl:choose>
  </xsl:attribute>
<!--<p align="center" class="tituloPag">Informe de no conformidad de producto</p>-->

<form name="form1" method="post" action="NoConformidadProductoSave.xsql">
  <input type="hidden" name="IDINFORME" value="{Mantenimiento/NOCONFORMIDAD/ID}"/>
  <input type="hidden" name="ACCION"/>
  <input type="hidden" name="STATUS" value="{Mantenimiento/NOCONFORMIDAD/STATUS}"/>
  <xsl:choose>
    <xsl:when test="Mantenimiento/NOCONFORMIDAD/STATUS=0">
      <input type="hidden" name="VENTANA"/>      
    </xsl:when>
    <xsl:otherwise>
      <input type="hidden" name="VENTANA" value="NUEVA"/>   
    </xsl:otherwise>
  </xsl:choose>
  <table width="90%" border="0" align="center">
    <tr> 
      <td align="center">
  <table width="100%" border="0" cellspacing="1" cellpadding="3" class="muyoscuro">
    <tr class="oscuro"> 
      <td class="oscuro" align="center">
        Informe de No Conformidad de Producto
      </td>
    </tr>
    
    <!-- estado < 10 -->
    <xsl:choose>
      <xsl:when test="Mantenimiento/NOCONFORMIDAD/STATUS&lt;=10">
    <tr class="blanco"> 
      <td height="18" class="blanco">
        <table width="100%" border="0" cellspacing="0" cellpadding="10" align="center">
          <tr>
            <td> 
              <table width="100%" border="0" cellspacing="1" cellpadding="3" class="muyoscuro" align="center">
                <tr  class="blanco">
                  <td width="22%" class="claro" align="right">
                    <b>Número de Informe:</b>
                  </td>
                  <td width="35%"  class="blanco">
                    <font color="NAVY" size="2">
    	              <b><xsl:value-of select="Mantenimiento/NOCONFORMIDAD/NUMERO"/></b>
    	              <input type="hidden" name="NUMERO" value="{Mantenimiento/NOCONFORMIDAD/NUMERO}"/>
    	            </font>
                  </td>
                  <td width="22%" align="right" class="claro">
                    <b>Fecha:</b>
                  </td>
                  <td width="*"  class="blanco">
                    <font color="NAVY" size="2">
    	              <b><xsl:value-of select="Mantenimiento/NOCONFORMIDAD/FECHAINICIO"/></b>
    	              <input type="hidden" name="FECHAINICIO" value="{Mantenimiento/NOCONFORMIDAD/FECHAINICIO}"/>
    	            </font>
                  </td>
                </tr>
              </table>
            </td>
          </tr>
          <tr>
            <td> 
              <table width="100%" border="0" cellspacing="1" cellpadding="3" align="center" class="muyoscuro">
                <tr class="blanco">
                  <td width="22%" class="claro" align="right">Responsable de compras:
                  </td>
                  <td width="35%" valign="middle" class="blanco">
                    <xsl:value-of select="Mantenimiento/NOCONFORMIDAD/RESPONSABLECENTRO"/>
                    <input type="hidden" name="IDRESPONSABLECENTRO" value="{Mantenimiento/NOCONFORMIDAD/IDRESPONSABLECENTRO}"/>
                  </td>
                  <td width="22%" class="claro" align="right">Centro:
                  </td>
                  <td width="*" valign="middle" class="blanco">
                    <xsl:value-of select="Mantenimiento/NOCONFORMIDAD/CENTRO"/>
                    <input type="hidden" name="IDCENTRO" value="{Mantenimiento/NOCONFORMIDAD/IDCENTRO}"/>
                  </td>
                </tr>
                <tr class="blanco">
                  <td class="claro" align="right">Usuario de la No Conformidad:<span class="camposObligatorios">*</span>
                  </td>
                  <td valign="middle" class="blanco">
                    <xsl:choose>
                      <xsl:when test="Mantenimiento/READ_ONLY='S'">
                        <xsl:value-of select="Mantenimiento/NOCONFORMIDAD/RECLAMANTE"/>
                      </xsl:when>
                      <xsl:otherwise>
                        <input type="text" name="RECLAMANTE" value="{Mantenimiento/NOCONFORMIDAD/RECLAMANTE}" size="60" maxlength="100"/>
                      </xsl:otherwise>
                    </xsl:choose>
                  </td>
                  <td class="claro" align="right">Cargo:<span class="camposObligatorios">*</span>
                  </td>
                  <td valign="middle" class="blanco">
                    <xsl:choose>
                      <xsl:when test="Mantenimiento/READ_ONLY='S'">
                        <xsl:value-of select="Mantenimiento/NOCONFORMIDAD/CARGORECLAMANTE"/>
                      </xsl:when>
                      <xsl:otherwise>
                        <input type="text" name="CARGORECLAMANTE" value="{Mantenimiento/NOCONFORMIDAD/CARGORECLAMANTE}" size="30" maxlength="100"/>
                      </xsl:otherwise>
                    </xsl:choose>
                  </td>
                </tr>
              </table>
            </td>
          </tr>
          <tr>
            <td>
              <table width="100%" border="0" cellspacing="1" cellpadding="3" class="muyoscuro">
                <tr  class="oscuro">
                  <td colspan="4" class="oscuro"><b>Datos del producto:</b><br/><br/></td>
                </tr>
                      <tr class="blanco" align="center">
                        <td class="claro" align="right" width="18%">
                          Familia de productos:<span class="camposObligatorios">*</span>
                        </td>
                        <td class="blanco" align="left">
                          <xsl:choose>
                            <xsl:when test="Mantenimiento/READ_ONLY='S'">
                              <xsl:choose>
                                <xsl:when test="Mantenimiento/NOCONFORMIDAD/PRODUCTO_NOCONFORMIDAD/FAMILIA=''">
                                  Pendiente de seleccionar
                                </xsl:when>
                                <xsl:otherwise>
                                  <xsl:value-of select="Mantenimiento/NOCONFORMIDAD/PRODUCTO_NOCONFORMIDAD/FAMILIA"/>
                                </xsl:otherwise>
                              </xsl:choose>
                            </xsl:when>
                            <xsl:otherwise>
                              <select name="FAMILIAS" onChange="inicializarDesplegable(document.forms['form1'],this.name,this.value);">
                                <option value="-1">Cargando Lista...</option>
                              </select>
                            </xsl:otherwise>
                          </xsl:choose>
                        </td>
                      </tr>
                      <tr class="blanco" align="center">
                        <td class="claro" align="right">
                          Subfamilia de productos:<span class="camposObligatorios">*</span>
                        </td>
                        <td class="blanco" align="left">
                          <xsl:choose>
                            <xsl:when test="Mantenimiento/READ_ONLY='S'">
                              <xsl:choose>
                                <xsl:when test="Mantenimiento/NOCONFORMIDAD/PRODUCTO_NOCONFORMIDAD/SUBFAMILIA=''">
                                  Pendiente de seleccionar
                                </xsl:when>
                                <xsl:otherwise>
                                  <xsl:value-of select="Mantenimiento/NOCONFORMIDAD/PRODUCTO_NOCONFORMIDAD/SUBFAMILIA"/>
                                </xsl:otherwise>
                              </xsl:choose>
                            </xsl:when>
                            <xsl:otherwise>
                              <select name="SUBFAMILIAS" onChange="inicializarDesplegable(document.forms['form1'],this.name,this.value);">
                                <option value="-1">Cargando Lista...</option>
                              </select>
                            </xsl:otherwise>
                          </xsl:choose>
                        </td>
                      </tr>
                      <xsl:if test="Mantenimiento/READ_ONLY='S'">
                        <tr class="blanco" align="center">
                          <td  class="claro" align="right">
                            Ref. producto estándar:<span class="camposObligatorios">*</span>
                          </td>
                          <td class="blanco" align="left">
                            <xsl:choose>
                              <xsl:when test="Mantenimiento/NOCONFORMIDAD/PRODUCTO_NOCONFORMIDAD/PRODUCTOESTANDAR=''">
                                Pendiente de seleccionar
                              </xsl:when>
                              <xsl:otherwise>
                                <b><xsl:value-of select="Mantenimiento/NOCONFORMIDAD/PRODUCTO_NOCONFORMIDAD/REFPRODUCTOESTANDAR"/></b>
                              </xsl:otherwise>
                            </xsl:choose>
                          </td>
                        </tr>
                      </xsl:if>
                      <tr class="blanco" align="center">
                        <td  class="claro" align="right">
                          Producto estándar:<span class="camposObligatorios">*</span>
                        </td>
                        <td class="blanco" align="left">
                          <xsl:choose>
                            <xsl:when test="Mantenimiento/READ_ONLY='S'">
                              <xsl:choose>
                                <xsl:when test="Mantenimiento/NOCONFORMIDAD/PRODUCTO_NOCONFORMIDAD/PRODUCTOESTANDAR=''">
                                  Pendiente de seleccionar
                                </xsl:when>
                                <xsl:otherwise>
                                  <b><xsl:value-of select="Mantenimiento/NOCONFORMIDAD/PRODUCTO_NOCONFORMIDAD/PRODUCTOESTANDAR"/></b>
                                </xsl:otherwise>
                              </xsl:choose>
                            </xsl:when>
                            <xsl:otherwise>
                              <select name="PRODUCTOSESTANDAR" onChange="inicializarDesplegable(document.forms['form1'],this.name,this.value);">
                                <option value="-1">Cargando Lista...</option>
                              </select>
                            </xsl:otherwise>
                          </xsl:choose>
                        </td>
                      </tr>
                      <tr class="blanco" align="center">
                        <td  class="claro" align="right">
                          Proveedor:<span class="camposObligatorios">*</span>
                        </td>
                        <td class="blanco" align="left">
                          <xsl:choose>
                            <xsl:when test="Mantenimiento/READ_ONLY='S'">
                              <xsl:choose>
                                <xsl:when test="Mantenimiento/NOCONFORMIDAD/PRODUCTO_NOCONFORMIDAD/PROVEEDOR=''">
                                  Pendiente de seleccionar
                                </xsl:when>
                                <xsl:otherwise>
                                  <xsl:value-of select="Mantenimiento/NOCONFORMIDAD/PRODUCTO_NOCONFORMIDAD/PROVEEDOR"/>
                                </xsl:otherwise>
                              </xsl:choose>
                            </xsl:when>
                            <xsl:otherwise>
                              <select name="PROVEEDORES" onChange="inicializarDesplegable(document.forms['form1'],this.name,this.value);">
                                <option value="-1">Cargando Lista...</option>
                              </select>
                            </xsl:otherwise>
                          </xsl:choose>
                        </td>
                      </tr>
                      <tr  class="blanco">
                        <td colspan="4" class="blanco">&nbsp;</td>
                      </tr>
                      <tr  class="oscuro">
                        <td colspan="4" class="oscuro"><b>Descripción de la No Conformidad:</b><br/><br/></td>
                      </tr>
                      <tr class="blanco" align="center">
                        <td  class="claro" align="right" valign="middle">
                          Lote defectuoso:
                        </td>
                        <xsl:choose>
                          <xsl:when test="Mantenimiento/READ_ONLY='S'">
                            <td class="blanco" align="left">
                              <xsl:value-of select="Mantenimiento/NOCONFORMIDAD/LOTE"/>
                            </td>
                          </xsl:when>
                          <xsl:otherwise>
                            <td class="blanco" align="left">
                              <input type="text" size="40" maxlength="100" name="LOTE" value="{Mantenimiento/NOCONFORMIDAD/LOTE}"/>
                            </td>
                          </xsl:otherwise>
                        </xsl:choose>
                      </tr>
                      <tr class="blanco" align="center">
                        <td  class="claro" align="right" valign="middle">
                          Envío muestras defectuosas a la Comisión de Evaluación
                        </td>
                        <xsl:choose>
                          <xsl:when test="Mantenimiento/READ_ONLY='S'">
                            <td class="blanco" align="left">
                              <table width="100%" cellpadding="0" cellspacing="0">
                                <tr>
                                  <td align="left" width="5%">
                                    <xsl:choose>
                                      <xsl:when test="Mantenimiento/NOCONFORMIDAD/MUESTRAS='S'">
                                        Si
                                      </xsl:when>
                                      <xsl:otherwise>
                                        No
                                      </xsl:otherwise>
                                    </xsl:choose>
                                  </td>
                                  <td align="left" width="*">
                                    Clínica&nbsp;<xsl:value-of select="Mantenimiento/NOCONFORMIDAD/CENTROANALISIS"/>,
                                    &nbsp;<xsl:value-of select="Mantenimiento/NOCONFORMIDAD/DIRECCIONANALISIS"/>
                                    &nbsp;<xsl:value-of select="Mantenimiento/NOCONFORMIDAD/CPOSTALANALISIS"/>
                                    &nbsp;<xsl:value-of select="Mantenimiento/NOCONFORMIDAD/POBLACIONANALISIS"/>
                                    (<xsl:value-of select="Mantenimiento/NOCONFORMIDAD/PROVINCIAANALISIS"/>),
                                    &nbsp;telf:&nbsp;<xsl:value-of select="Mantenimiento/NOCONFORMIDAD/TELEFONOANALISIS"/>,
                                    &nbsp;fax:&nbsp;<xsl:value-of select="Mantenimiento/NOCONFORMIDAD/FAXANALISIS"/>
                                  </td>
                                </tr>
                              </table>
                            </td>
                          </xsl:when>
                          <xsl:otherwise>
                            <td class="blanco" align="left">
                              <table width="100%" cellpadding="0" cellspacing="0">
                                <tr>
                                  <td align="left" width="5%">
                                    <input type="checkbox" name="MUESTRAS">
                                      <xsl:if test="Mantenimiento/NOCONFORMIDAD/MUESTRAS='S'">
                                        <xsl:attribute name="checked">checked</xsl:attribute>
                                      </xsl:if>
                                    </input>
                                  </td>
                                  <td align="left" width="*">
                                    Clínica&nbsp;<xsl:value-of select="Mantenimiento/NOCONFORMIDAD/CENTROANALISIS"/>,
                                    &nbsp;<xsl:value-of select="Mantenimiento/NOCONFORMIDAD/DIRECCIONANALISIS"/>
                                    &nbsp;<xsl:value-of select="Mantenimiento/NOCONFORMIDAD/CPOSTALANALISIS"/>
                                    &nbsp;<xsl:value-of select="Mantenimiento/NOCONFORMIDAD/POBLACIONANALISIS"/>
                                    (<xsl:value-of select="Mantenimiento/NOCONFORMIDAD/PROVINCIAANALISIS"/>),
                                    &nbsp;telf:&nbsp;<xsl:value-of select="Mantenimiento/NOCONFORMIDAD/TELEFONOANALISIS"/>,
                                    &nbsp;fax:&nbsp;<xsl:value-of select="Mantenimiento/NOCONFORMIDAD/FAXANALISIS"/>
                                  </td>
                                </tr>
                              </table>
                            </td>
                          </xsl:otherwise>
                        </xsl:choose>
                      </tr>
                      <tr class="blanco" align="center">
                        <td  class="claro" align="right" valign="middle">
                          Funcional:<span class="camposObligatorios">*</span>
                        </td>
                        <xsl:choose>
                          <xsl:when test="Mantenimiento/READ_ONLY='S'">
                            <td class="blanco" align="left">
                              <xsl:copy-of select="Mantenimiento/NOCONFORMIDAD/COMENTARIOS_FUNCIONALES_HTML"/>
                            </td>
                          </xsl:when>
                          <xsl:otherwise>
                            <td class="blanco" align="center">
                              <textarea name="COMENTARIOS_FUNCIONALES" cols="90" rows="5">
                                <xsl:value-of select="Mantenimiento/NOCONFORMIDAD/COMENTARIOS_FUNCIONALES"/>
                              </textarea>
                            </td>
                          </xsl:otherwise>
                        </xsl:choose>
                      </tr>
                      <tr class="blanco" align="center">
                        <td  class="claro" align="right" valign="middle">
                          Servicio:<span class="camposObligatorios">*</span>
                        </td>
                        <xsl:choose>
                          <xsl:when test="Mantenimiento/READ_ONLY='S'">
                            <td class="blanco" align="left">
                              <xsl:copy-of select="Mantenimiento/NOCONFORMIDAD/COMENTARIOS_SERVICIOS_HTML"/>
                            </td>
                          </xsl:when>
                          <xsl:otherwise>
                            <td class="blanco" align="center">
                              <textarea name="COMENTARIOS_SERVICIOS" cols="90" rows="5">
                                <xsl:value-of select="Mantenimiento/NOCONFORMIDAD/COMENTARIOS_SERVICIOS"/>
                              </textarea>
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
    </xsl:when>
    <!-- estado 30 -->
    <xsl:when test="Mantenimiento/NOCONFORMIDAD/STATUS=30 or Mantenimiento/NOCONFORMIDAD/STATUS=20">
    
    <tr class="blanco"> 
      <td height="18" class="blanco">
        <table width="100%" border="0" cellspacing="0" cellpadding="10" align="center">
          <tr>
            <td> 
              <table width="100%" border="0" cellspacing="1" cellpadding="3" class="muyoscuro" align="center">
                <tr  class="blanco">
                  <td width="22%" class="claro" align="right">
                    <b>Número de Informe:</b>
                  </td>
                  <td width="35%"  class="blanco">
                    <font color="NAVY" size="2">
    	              <b><xsl:value-of select="Mantenimiento/NOCONFORMIDAD/NUMERO"/></b>
    	              <input type="hidden" name="NUMERO" value="{Mantenimiento/NOCONFORMIDAD/NUMERO}"/>
    	            </font>
                  </td>
                  <td width="22%" align="right" class="claro">
                    <b>Fecha:</b>
                  </td>
                  <td width="*"  class="blanco">
                    <font color="NAVY" size="2">
    	              <b><xsl:value-of select="Mantenimiento/NOCONFORMIDAD/FECHAINICIO"/></b>
    	              <input type="hidden" name="FECHAINICIO" value="{Mantenimiento/NOCONFORMIDAD/FECHAINICIO}"/>
    	            </font>
                  </td>
                </tr>
              </table>
            </td>
          </tr>
          <tr>
            <td> 
              <table width="100%" border="0" cellspacing="1" cellpadding="3" align="center" class="muyoscuro">
                <tr class="blanco">
                  <td width="22%" class="claro" align="right">Responsable de compras:
                  </td>
                  <td width="35%" valign="middle" class="blanco">
                    <xsl:value-of select="Mantenimiento/NOCONFORMIDAD/RESPONSABLECENTRO"/>
                    <input type="hidden" name="IDRESPONSABLECENTRO" value="{Mantenimiento/NOCONFORMIDAD/IDRESPONSABLECENTRO}"/>
                  </td>
                  <td width="22%" class="claro" align="right">Centro:
                  </td>
                  <td width="*" valign="middle" class="blanco">
                    <xsl:value-of select="Mantenimiento/NOCONFORMIDAD/CENTRO"/>
                    <input type="hidden" name="IDCENTRO" value="{Mantenimiento/NOCONFORMIDAD/IDCENTRO}"/>
                  </td>
                </tr>
                <tr class="blanco">
                  <td class="claro" align="right">Usuario de la No Conformidad:
                  </td>
                  <td valign="middle" class="blanco">
                    <xsl:value-of select="Mantenimiento/NOCONFORMIDAD/RECLAMANTE"/>
                    <input type="hidden" name="RECLAMANTE" value="{Mantenimiento/NOCONFORMIDAD/RECLAMANTE}" size="60" maxlength="100"/>
                  </td>
                  <td class="claro" align="right">Cargo:
                  </td>
                  <td valign="middle" class="blanco">
                    <xsl:value-of select="Mantenimiento/NOCONFORMIDAD/CARGORECLAMANTE"/>
                    <input type="hidden" name="CARGORECLAMANTE" value="{Mantenimiento/NOCONFORMIDAD/CARGORECLAMANTE}" size="30" maxlength="100"/>
                  </td>
                </tr>
              </table>
            </td>
          </tr>
          <tr>
            <td>
              <table width="100%" border="0" cellspacing="1" cellpadding="3" class="muyoscuro">
                <tr  class="oscuro">
                  <td colspan="4" class="oscuro"><b>Datos del producto:</b><br/><br/></td>
                </tr>
                      <tr class="blanco" align="center">
                        <td class="claro" align="right" width="18%">
                          Familia de productos:
                        </td>
                        <td class="blanco" align="left">
                          <xsl:value-of select="Mantenimiento/NOCONFORMIDAD/PRODUCTO_NOCONFORMIDAD/FAMILIA"/>
                          <input type="hidden" name="FAMILIAS" value="{Mantenimiento/NOCONFORMIDAD/PRODUCTO_NOCONFORMIDAD/IDFAMILIA}"/>
                        </td>
                      </tr>
                      <tr class="blanco" align="center">
                        <td class="claro" align="right">
                          Subfamilia de productos:
                        </td>
                        <td class="blanco" align="left">
                          <xsl:value-of select="Mantenimiento/NOCONFORMIDAD/PRODUCTO_NOCONFORMIDAD/SUBFAMILIA"/>
                          <input type="hidden" name="SUBFAMILIAS" value="{Mantenimiento/NOCONFORMIDAD/PRODUCTO_NOCONFORMIDAD/IDSUBFAMILIA}"/>
                        </td>
                      </tr>
                      <tr class="blanco" align="center">
                        <td  class="claro" align="right">
                          Ref. producto estándar:
                        </td>
                        <td class="blanco" align="left">
                          <b><xsl:value-of select="Mantenimiento/NOCONFORMIDAD/PRODUCTO_NOCONFORMIDAD/REFPRODUCTOESTANDAR"/></b>
                        </td>
                      </tr>
                      <tr class="blanco" align="center">
                        <td  class="claro" align="right">
                          Producto estándar:
                        </td>
                        <td class="blanco" align="left">
                          <b><xsl:value-of select="Mantenimiento/NOCONFORMIDAD/PRODUCTO_NOCONFORMIDAD/PRODUCTOESTANDAR"/></b>
                          <input type="hidden" name="PRODUCTOSESTANDAR" value="{Mantenimiento/NOCONFORMIDAD/PRODUCTO_NOCONFORMIDAD/IDPRODUCTOESTANDAR}"/>
                        </td>
                      </tr> 
                      <tr class="blanco" align="center">
                        <td  class="claro" align="right">
                          Proveedor:
                        </td>
                        <td class="blanco" align="left">
                          <xsl:value-of select="Mantenimiento/NOCONFORMIDAD/PRODUCTO_NOCONFORMIDAD/PROVEEDOR"/>
                          <input type="hidden" name="PROVEEDORES" value="{Mantenimiento/NOCONFORMIDAD/PRODUCTO_NOCONFORMIDAD/IDPROVEEDOR}"/>
                        </td>
                      </tr>
                      <tr  class="blanco">
                        <td colspan="4" class="blanco">&nbsp;</td>
                      </tr>
                      <!-- descripcion problema -->
                      <tr  class="oscuro">
                        <td colspan="4" class="oscuro"><b>Descripción de la No Conformidad:</b><br/><br/></td>
                      </tr>
                      <tr class="blanco" align="center">
                        <td  class="claro" align="right" valign="middle">
                          Lote defectuoso:
                        </td>
                        <td class="blanco" align="left">
                          <xsl:value-of select="Mantenimiento/NOCONFORMIDAD/LOTE"/>
                        </td>
                      </tr>
                      <tr class="blanco" align="center">
                        <td  class="claro" align="right" valign="middle">
                          Envío muestras defectuosas a la Comisión de Evaluación
                        </td>
                        <td class="blanco" align="left">
                          <table width="100%" cellpadding="0" cellspacing="0">
                            <tr>
                              <td align="left" width="5%">
                                <xsl:choose>
                                  <xsl:when test="Mantenimiento/NOCONFORMIDAD/MUESTRAS='S'">
                                    Si
                                  </xsl:when>
                                  <xsl:otherwise>
                                    No
                                  </xsl:otherwise>
                                </xsl:choose>
                              </td>
                              <td align="left" width="*">
                                Clínica&nbsp;<xsl:value-of select="Mantenimiento/NOCONFORMIDAD/CENTROANALISIS"/>,
                                &nbsp;<xsl:value-of select="Mantenimiento/NOCONFORMIDAD/DIRECCIONANALISIS"/>
                                &nbsp;<xsl:value-of select="Mantenimiento/NOCONFORMIDAD/CPOSTALANALISIS"/>
                                &nbsp;<xsl:value-of select="Mantenimiento/NOCONFORMIDAD/POBLACIONANALISIS"/>
                                (<xsl:value-of select="Mantenimiento/NOCONFORMIDAD/PROVINCIAANALISIS"/>),
                                &nbsp;telf:&nbsp;<xsl:value-of select="Mantenimiento/NOCONFORMIDAD/TELEFONOANALISIS"/>,
                                &nbsp;fax:&nbsp;<xsl:value-of select="Mantenimiento/NOCONFORMIDAD/FAXANALISIS"/>
                              </td>
                            </tr>
                          </table>
                        </td>
                      </tr>
                      <tr class="blanco" align="center">
                        <td  class="claro" align="right" valign="top">
                          Funcional:
                        </td>
                        <td class="blanco" align="left">
                          &nbsp;<xsl:copy-of select="Mantenimiento/NOCONFORMIDAD/COMENTARIOS_FUNCIONALES_HTML"/>
                        </td>
                      </tr>
                      <tr class="blanco" align="center">
                        <td  class="claro" align="right" valign="top">
                          Servicio:
                        </td>
                        <td class="blanco" align="left">
                          &nbsp;<xsl:copy-of select="Mantenimiento/NOCONFORMIDAD/COMENTARIOS_SERVICIOS_HTML"/>
                        </td>
                      </tr>
                      <tr  class="blanco">
                        <td colspan="4" class="blanco">&nbsp;</td>
                      </tr>
                      <!-- analisis -->
                      <tr  class="oscuro">
                        <td colspan="4" class="oscuro"><b>Respuesta de la CdC:</b><br/><br/></td>
                      </tr>
                      <tr class="blanco" align="center">
                        <td  class="claro" align="right" valign="top">
                          Responsable:
                        </td>
                        <td class="blanco" align="left">
                          <xsl:value-of select="Mantenimiento/NOCONFORMIDAD/RESPONSABLEANALISIS"/>
                          <input type="hidden" name="IDRESPONSABLEANALISIS" value="{Mantenimiento/NOCONFORMIDAD/IDRESPONSABLEANALISIS}"/>
                        </td>
                      </tr>
                      <tr  class="medio">
                        <td colspan="4" class="medio"><b>Funcional</b></td>
                      </tr>
                      <tr class="blanco" align="center">
                        <td  class="claro" align="right" valign="top">
                          Análisis:<span class="camposObligatorios">*</span>
                        </td>
                        <xsl:choose>
                          <xsl:when test="Mantenimiento/READ_ONLY='S'">
                            <td class="blanco" align="left">
                              <xsl:copy-of select="Mantenimiento/NOCONFORMIDAD/ANALISIS_FUNCIONALES_HTML"/>
                            </td>
                          </xsl:when>
                          <xsl:otherwise>
                            <td class="blanco" align="center">
                              <textarea name="ANALISIS_FUNCIONALES" cols="90" rows="5">
                                <xsl:value-of select="Mantenimiento/NOCONFORMIDAD/ANALISIS_FUNCIONALES"/>
                              </textarea>
                            </td>
                          </xsl:otherwise>
                        </xsl:choose>
                      </tr>
                      <tr class="blanco" align="center">
                        <td  class="claro" align="right" valign="top">
                          Acciones a Realizar:<span class="camposObligatorios">*</span>
                        </td>
                        <xsl:choose>
                          <xsl:when test="Mantenimiento/READ_ONLY='S'">
                            <td class="blanco" align="left">
                              <xsl:copy-of select="Mantenimiento/NOCONFORMIDAD/ACCIONES_FUNCIONALES_HTML"/>
                            </td>
                          </xsl:when>
                          <xsl:otherwise>
                            <td class="blanco" align="center">
                              <textarea name="ACCIONES_FUNCIONALES" cols="90" rows="5">
                                <xsl:value-of select="Mantenimiento/NOCONFORMIDAD/ACCIONES_FUNCIONALES"/>
                              </textarea>
                            </td>
                          </xsl:otherwise>
                        </xsl:choose>
                      </tr>
                      <tr  class="medio">
                        <td colspan="4" class="medio"><b>Servicio</b></td>
                      </tr>
                      <tr class="blanco" align="center">
                        <td  class="claro" align="right" valign="top">
                          Análisis:<span class="camposObligatorios">*</span>
                        </td>
                        <xsl:choose>
                          <xsl:when test="Mantenimiento/READ_ONLY='S'">
                            <td class="blanco" align="left">
                              <xsl:copy-of select="Mantenimiento/NOCONFORMIDAD/ANALISIS_SERVICIOS_HTML"/>
                            </td>
                          </xsl:when>
                          <xsl:otherwise>
                            <td class="blanco" align="center">
                              <textarea name="ANALISIS_SERVICIOS" cols="90" rows="5">
                                <xsl:value-of select="Mantenimiento/NOCONFORMIDAD/ANALISIS_SERVICIOS"/>
                              </textarea>
                            </td>
                          </xsl:otherwise>
                        </xsl:choose>
                      </tr>
                      <tr class="blanco" align="center">
                        <td  class="claro" align="right" valign="top">
                          Acciones a Realizar:<span class="camposObligatorios">*</span>
                        </td>
                        <xsl:choose>
                          <xsl:when test="Mantenimiento/READ_ONLY='S'">
                            <td class="blanco" align="left">
                              <xsl:copy-of select="Mantenimiento/NOCONFORMIDAD/ACCIONES_SERVICIOS_HTML"/>
                            </td>
                          </xsl:when>
                          <xsl:otherwise>
                            <td class="blanco" align="center">
                              <textarea name="ACCIONES_SERVICIOS" cols="90" rows="5">
                                <xsl:value-of select="Mantenimiento/NOCONFORMIDAD/ACCIONES_SERVICIOS"/>
                              </textarea>
                            </td>
                          </xsl:otherwise>
                        </xsl:choose>
                      </tr>
                      <tr class="blanco" align="center">
                        <td  class="claro" align="right" valign="top">
                          Conclusiones:<span class="camposObligatorios">*</span>
                        </td>
                        <td class="blanco" align="left">
                          <xsl:choose>
                          <xsl:when test="Mantenimiento/READ_ONLY='S'">
                            <xsl:choose>
                              <xsl:when test="Mantenimiento/NOCONFORMIDAD/CONCLUSIONES/field[@name='IDCONCLUSION']/@current='NULL'">
                                <b>Pendiente de seleccionar</b>
                              </xsl:when>
                              <xsl:otherwise>
                                <xsl:for-each select="Mantenimiento/NOCONFORMIDAD/CONCLUSIONES/field[@name='IDCONCLUSION']/dropDownList/listElem">
    	                            <xsl:if test="ID=../../@current">
    	                              <b><xsl:value-of select="listItem"/></b>
    	                            </xsl:if>
    	                          </xsl:for-each>
    	                        </xsl:otherwise>
    	                      </xsl:choose>
                          </xsl:when>
                          <xsl:otherwise>
                            <xsl:call-template name="field_funcion">
    	                        <xsl:with-param name="path" select="Mantenimiento/NOCONFORMIDAD/CONCLUSIONES/field[@name='IDCONCLUSION']"/>
    	                        <xsl:with-param name="IDAct" select="Mantenimiento/NOCONFORMIDAD/CONCLUSIONES/field[@name='IDCONCLUSION']/@current"/>
    	                      </xsl:call-template>
                          </xsl:otherwise>
                        </xsl:choose>
                        </td>
                      </tr>
                      <tr class="blanco" align="center">
                        <td  class="claro" align="right" valign="top">
                          Comentarios:
                        </td>
                        <xsl:choose>
                          <xsl:when test="Mantenimiento/READ_ONLY='S'">
                            <td class="blanco" align="left">
                              <xsl:copy-of select="Mantenimiento/NOCONFORMIDAD/COMENTARIOS_CONCLUSIONES_HTML"/>
                            </td>
                          </xsl:when>
                          <xsl:otherwise>
                            <td class="blanco" align="center">
                              <textarea name="COMENTARIOS_CONCLUSIONES" cols="90" rows="2">
                                <xsl:value-of select="Mantenimiento/NOCONFORMIDAD/COMENTARIOS_CONCLUSIONES"/>
                              </textarea>
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
    </xsl:when>
    <!-- estado 40 ó 50 -->
    <xsl:when test="Mantenimiento/NOCONFORMIDAD/STATUS&gt;30">
    
    <tr class="blanco"> 
      <td height="18" class="blanco">
        <table width="100%" border="0" cellspacing="0" cellpadding="10" align="center">
          <tr>
            <td> 
              <table width="100%" border="0" cellspacing="1" cellpadding="3" class="muyoscuro" align="center">
                <tr  class="blanco">
                  <td width="22%" class="claro" align="right">
                    <b>Número de Informe:</b>
                  </td>
                  <td width="35%"  class="blanco">
                    <font color="NAVY" size="2">
    	              <b><xsl:value-of select="Mantenimiento/NOCONFORMIDAD/NUMERO"/></b>
    	              <input type="hidden" name="NUMERO" value="{Mantenimiento/NOCONFORMIDAD/NUMERO}"/>
    	            </font>
                  </td>
                  <td width="22%" align="right" class="claro">
                    <b>Fecha:</b>
                  </td>
                  <td width="*"  class="blanco">
                    <font color="NAVY" size="2">
    	              <b><xsl:value-of select="Mantenimiento/NOCONFORMIDAD/FECHAINICIO"/></b>
    	              <input type="hidden" name="FECHAINICIO" value="{Mantenimiento/NOCONFORMIDAD/FECHAINICIO}"/>
    	            </font>
                  </td>
                </tr>
              </table>
            </td>
          </tr>
          <tr>
            <td> 
              <table width="100%" border="0" cellspacing="1" cellpadding="3" align="center" class="muyoscuro">
                <tr class="blanco">
                  <td width="22%" class="claro" align="right">Responsable de compras:
                  </td>
                  <td width="35%" valign="middle" class="blanco">
                    <xsl:value-of select="Mantenimiento/NOCONFORMIDAD/RESPONSABLECENTRO"/>
                    <input type="hidden" name="IDRESPONSABLECENTRO" value="{Mantenimiento/NOCONFORMIDAD/IDRESPONSABLECENTRO}"/>
                  </td>
                  <td width="22%" class="claro" align="right">Centro:
                  </td>
                  <td width="*" valign="middle" class="blanco">
                    <xsl:value-of select="Mantenimiento/NOCONFORMIDAD/CENTRO"/>
                    <input type="hidden" name="IDCENTRO" value="{Mantenimiento/NOCONFORMIDAD/IDCENTRO}"/>
                  </td>
                </tr>
                <tr class="blanco">
                  <td class="claro" align="right">Usuario de la No Conformidad:
                  </td>
                  <td valign="middle" class="blanco">
                    <xsl:value-of select="Mantenimiento/NOCONFORMIDAD/RECLAMANTE"/>
                    <input type="hidden" name="RECLAMANTE" value="{Mantenimiento/NOCONFORMIDAD/RECLAMANTE}" size="60" maxlength="100"/>
                  </td>
                  <td class="claro" align="right">Cargo:
                  </td>
                  <td valign="middle" class="blanco">
                    <xsl:value-of select="Mantenimiento/NOCONFORMIDAD/CARGORECLAMANTE"/>
                    <input type="hidden" name="CARGORECLAMANTE" value="{Mantenimiento/NOCONFORMIDAD/CARGORECLAMANTE}" size="30" maxlength="100"/>
                  </td>
                </tr>
              </table>
            </td>
          </tr>
          <tr>
            <td>
              <table width="100%" border="0" cellspacing="1" cellpadding="3" class="muyoscuro">
                <tr  class="oscuro">
                  <td colspan="4" class="oscuro"><b>Datos del producto:</b><br/><br/></td>
                </tr>
                      <tr class="blanco" align="center">
                        <td class="claro" align="right" width="18%">
                          Familia de productos:
                        </td>
                        <td class="blanco" align="left">
                          <xsl:value-of select="Mantenimiento/NOCONFORMIDAD/PRODUCTO_NOCONFORMIDAD/FAMILIA"/>
                          <input type="hidden" name="FAMILIAS" value="{Mantenimiento/NOCONFORMIDAD/PRODUCTO_NOCONFORMIDAD/IDFAMILIA}"/>
                        </td>
                      </tr>
                      <tr class="blanco" align="center">
                        <td class="claro" align="right">
                          Subfamilia de productos:
                        </td>
                        <td class="blanco" align="left">
                          <xsl:value-of select="Mantenimiento/NOCONFORMIDAD/PRODUCTO_NOCONFORMIDAD/SUBFAMILIA"/>
                          <input type="hidden" name="SUBFAMILIAS" value="{Mantenimiento/NOCONFORMIDAD/PRODUCTO_NOCONFORMIDAD/IDSUBFAMILIA}"/>
                        </td>
                      </tr>
                      <tr class="blanco" align="center">
                        <td  class="claro" align="right">
                          Ref. producto estándar:
                        </td>
                        <td class="blanco" align="left">
                          <b><xsl:value-of select="Mantenimiento/NOCONFORMIDAD/PRODUCTO_NOCONFORMIDAD/REFPRODUCTOESTANDAR"/></b>
                        </td>
                      </tr>
                      <tr class="blanco" align="center">
                        <td  class="claro" align="right">
                          Producto estándar:
                        </td>
                        <td class="blanco" align="left">
                          <b><xsl:value-of select="Mantenimiento/NOCONFORMIDAD/PRODUCTO_NOCONFORMIDAD/PRODUCTOESTANDAR"/></b>
                          <input type="hidden" name="PRODUCTOSESTANDAR" value="{Mantenimiento/NOCONFORMIDAD/PRODUCTO_NOCONFORMIDAD/IDPRODUCTOESTANDAR}"/>
                        </td>
                      </tr> 
                      <tr class="blanco" align="center">
                        <td  class="claro" align="right">
                          Proveedor:
                        </td>
                        <td class="blanco" align="left">
                          <xsl:value-of select="Mantenimiento/NOCONFORMIDAD/PRODUCTO_NOCONFORMIDAD/PROVEEDOR"/>
                          <input type="hidden" name="PROVEEDORES" value="{Mantenimiento/NOCONFORMIDAD/PRODUCTO_NOCONFORMIDAD/IDPROVEEDOR}"/>
                        </td>
                      </tr>
                      <tr  class="blanco">
                        <td colspan="4" class="blanco">&nbsp;</td>
                      </tr>
                      <!-- descripcion problema -->
                      <tr  class="oscuro">
                        <td colspan="4" class="oscuro"><b>Descripción de la No Conformidad:</b><br/><br/></td>
                      </tr>
                      <tr class="blanco" align="center">
                        <td  class="claro" align="right" valign="middle">
                          Lote defectuoso:
                        </td>
                        <td class="blanco" align="left">
                          <xsl:value-of select="Mantenimiento/NOCONFORMIDAD/LOTE"/>
                        </td>
                      </tr>
                      <tr class="blanco" align="center">
                        <td  class="claro" align="right" valign="middle">
                          Envío muestras defectuosas a la Comisión de Evaluación:
                        </td>
                        <td class="blanco" align="left">
                          <table width="100%" cellpadding="0" cellspacing="0">
                            <tr>
                              <td align="left" width="5%">
                                <xsl:choose>
                                  <xsl:when test="Mantenimiento/NOCONFORMIDAD/MUESTRAS='S'">
                                    Si
                                  </xsl:when>
                                  <xsl:otherwise>
                                    No
                                  </xsl:otherwise>
                                </xsl:choose>
                              </td>
                              <td align="left" width="*">
                                Clínica&nbsp;<xsl:value-of select="Mantenimiento/NOCONFORMIDAD/CENTROANALISIS"/>,
                                &nbsp;<xsl:value-of select="Mantenimiento/NOCONFORMIDAD/DIRECCIONANALISIS"/>
                                &nbsp;<xsl:value-of select="Mantenimiento/NOCONFORMIDAD/CPOSTALANALISIS"/>
                                &nbsp;<xsl:value-of select="Mantenimiento/NOCONFORMIDAD/POBLACIONANALISIS"/>
                                (<xsl:value-of select="Mantenimiento/NOCONFORMIDAD/PROVINCIAANALISIS"/>),
                                &nbsp;telf:&nbsp;<xsl:value-of select="Mantenimiento/NOCONFORMIDAD/TELEFONOANALISIS"/>,
                                &nbsp;fax:&nbsp;<xsl:value-of select="Mantenimiento/NOCONFORMIDAD/FAXANALISIS"/>
                              </td>
                            </tr>
                          </table>
                        </td>
                      </tr>
                      <tr class="blanco" align="center">
                        <td  class="claro" align="right" valign="top">
                          Funcional:
                        </td>
                        <td class="blanco" align="left">
                          &nbsp;<xsl:copy-of select="Mantenimiento/NOCONFORMIDAD/COMENTARIOS_FUNCIONALES_HTML"/>
                        </td>
                      </tr>
                      <tr class="blanco" align="center">
                        <td  class="claro" align="right" valign="top">
                          Servicio:
                        </td>
                        <td class="blanco" align="left">
                          &nbsp;<xsl:value-of select="Mantenimiento/NOCONFORMIDAD/COMENTARIOS_SERVICIOS_HTML"/>
                        </td>
                      </tr>
                      <tr  class="blanco">
                        <td colspan="4" class="blanco">&nbsp;</td>
                      </tr>
                      <!-- analisis -->
                      <tr  class="oscuro">
                        <td colspan="4" class="oscuro"><b>Respuesta de la CdC:</b><br/><br/></td>
                      </tr>
                      <tr class="blanco" align="center">
                        <td  class="claro" align="right" valign="top">
                          Responsable:
                        </td>
                        <td class="blanco" align="left">
                          <xsl:value-of select="Mantenimiento/NOCONFORMIDAD/RESPONSABLEANALISIS"/>
                          <input type="hidden" name="IDRESPONSABLEANALISIS" value="{Mantenimiento/NOCONFORMIDAD/IDRESPONSABLEANALISIS}"/>
                        </td>
                      </tr>
                      <tr  class="medio">
                        <td colspan="4" class="medio"><b>Funcional</b></td>
                      </tr>
                      <tr class="blanco" align="center">
                        <td  class="claro" align="right" valign="top">
                          Análisis:
                        </td>
                        <td class="blanco" align="left">
                            <xsl:copy-of select="Mantenimiento/NOCONFORMIDAD/ANALISIS_FUNCIONALES_HTML"/>
                        </td>
                      </tr>
                      <tr class="blanco" align="center">
                        <td  class="claro" align="right" valign="top">
                          Acciones a Realizar:
                        </td>
                        <td class="blanco" align="left">
                            <xsl:copy-of select="Mantenimiento/NOCONFORMIDAD/ACCIONES_FUNCIONALES_HTML"/>
                        </td>
                      </tr>
                      <tr  class="medio">
                        <td colspan="4" class="medio"><b>Servicio</b></td>
                      </tr>
                      <tr class="blanco" align="center">
                        <td  class="claro" align="right" valign="top">
                          Análisis:
                        </td>
                        <td class="blanco" align="left">
                            <xsl:copy-of select="Mantenimiento/NOCONFORMIDAD/ANALISIS_SERVICIOS_HTML"/>
                        </td>
                      </tr>
                      <tr class="blanco" align="center">
                        <td  class="claro" align="right" valign="top">
                          Acciones a Realizar:
                        </td>
                        <td class="blanco" align="left">
                            <xsl:copy-of select="Mantenimiento/NOCONFORMIDAD/ACCIONES_SERVICIOS_HTML"/>
                        </td>
                      </tr>
                      <tr class="blanco" align="center">
                        <td  class="claro" align="right" valign="top">
                          Conclusiones:
                        </td>
                        <td class="blanco" align="left">
                          <xsl:for-each select="Mantenimiento/NOCONFORMIDAD/CONCLUSIONES/field[@name='IDCONCLUSION']/dropDownList/listElem">
    	                      <xsl:if test="ID=../../@current">
    	                        <b><xsl:value-of select="listItem"/></b>
    	                      </xsl:if>
    	                    </xsl:for-each>
                        </td>
                      </tr>
                      <tr class="blanco" align="center">
                        <td  class="claro" align="right" valign="top">
                          Comentarios:
                        </td>
                        <td class="blanco" align="left">
                          <xsl:copy-of select="Mantenimiento/NOCONFORMIDAD/COMENTARIOS_CONCLUSIONES_HTML"/>
                        </td>
                      </tr>
              </table>
            </td>
          </tr>
        </table>
      </td>
    </tr>  
    </xsl:when>
  </xsl:choose>
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
            <xsl:when test="//READ_ONLY='S' or //Mantenimiento/NOCONFORMIDAD/STATUS&gt;40">
              <td>
                <xsl:call-template name="boton">
                  <xsl:with-param name="path" select="Mantenimiento/botones/button[@label='Cancelar']"/>
                </xsl:call-template>
              </td>
              <td>
                <xsl:call-template name="boton">
                  <xsl:with-param name="path" select="Mantenimiento/botones/button[@label='Imprimir']"/>
                </xsl:call-template>
              </td>
    	    </xsl:when>
    	    <xsl:otherwise> 
    	      <td>
                <xsl:call-template name="boton">
                  <xsl:with-param name="path" select="Mantenimiento/botones/button[@label='Cancelar']"/>
                </xsl:call-template>
              </td>
              <xsl:if test="Mantenimiento/NOCONFORMIDAD/STATUS&lt;40">
              <td>
                <xsl:call-template name="boton">
                  <xsl:with-param name="path" select="Mantenimiento/botones/button[@label='Pendiente']"/>
                </xsl:call-template>
              </td>
              </xsl:if>
              <xsl:if test="Mantenimiento/NOCONFORMIDAD/STATUS=10">
                <td>
                  <xsl:call-template name="boton">
                    <xsl:with-param name="path" select="Mantenimiento/botones/button[@label='Borrar']"/>
                  </xsl:call-template>
                </td>
              </xsl:if>
              <xsl:choose>
              <xsl:when test="Mantenimiento/NOCONFORMIDAD/STATUS=40">
                <td>
                  <xsl:call-template name="boton">
                    <xsl:with-param name="path" select="Mantenimiento/botones/button[@label='Finalizar']"/>
                  </xsl:call-template>
                </td>
              </xsl:when>
              <xsl:otherwise>
                <td>
                  <xsl:call-template name="boton">
                    <xsl:with-param name="path" select="Mantenimiento/botones/button[@label='Enviar']"/>
                  </xsl:call-template>
                </td>
              </xsl:otherwise>
            </xsl:choose>
    	    </xsl:otherwise>
    	  </xsl:choose>
        </tr>
      </table>
  
</form>
<p>&nbsp; </p>
</xsl:otherwise>
</xsl:choose>
  </body>
  </html>
</xsl:template>


<xsl:template match="Status/BORRADO">


  <p class="tituloPag">
  <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='CATPRIV-0600' and @lang=$lang]" disable-output-escaping="yes"/>
  </p>
  <hr/>
  <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='CATPRIV-0610' and @lang=$lang]" disable-output-escaping="yes"/>
  <br/> 
  <br/> 
  <xsl:call-template name="boton">
              <xsl:with-param name="path" select="//Mantenimiento/botones/button[@label='Cerrar']"/>
            </xsl:call-template>
   
</xsl:template> 

<xsl:template match="Status/CERRADO">


  <p class="tituloPag">
  <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='CATPRIV-0611' and @lang=$lang]" disable-output-escaping="yes"/>
  </p>
  <hr/>
  <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='CATPRIV-0612' and @lang=$lang]" disable-output-escaping="yes"/>
  <br/> 
  <br/> 
  <xsl:call-template name="boton">
              <xsl:with-param name="path" select="//Mantenimiento/botones/button[@label='Cerrar']"/>
            </xsl:call-template>
   
</xsl:template> 

<xsl:template name="COMBO_PREVISION">
      <xsl:param name="nombre"/>
      <xsl:param name="IDAct"/>
      <xsl:param name="onChange"/>
      <xsl:call-template name="desplegable">
    	<xsl:with-param name="path" select="/Mantenimiento/field[@name='COMBO_PREVISION']"/>
    	<xsl:with-param name="nombre"><xsl:value-of select="$nombre"/></xsl:with-param>
    	<xsl:with-param name="defecto"><xsl:value-of select="$IDAct"/></xsl:with-param>
    	<xsl:with-param name="onChange"><xsl:value-of select="$onChange"/></xsl:with-param>
    </xsl:call-template>
</xsl:template>


</xsl:stylesheet>
