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
          Mantenimiento de Centros del Catálogo Privado
        </title>
        
      <!--style-->
      <xsl:call-template name="estiloIndip"/>
      <!--fin de style-->  

     <script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
	 <script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>
	<xsl:text disable-output-escaping="yes"><![CDATA[
	
        <script type="text/javascript">
        <!--

           var msgConfirmarBorrado='¿Eliminar el Centro?'; 
           
           var msgSinCentro='Debe seleccionar un centro para el producto.';
           var msgSinConsumo='Debe introducir la compra anual del producto.';
           var msgSinPrecio='Debe introducir el precio al que se esta comprando el producto.';
           var msgSinProveedor='Debe seleccionar el proveedor del producto.';
           var msgSinReferencia='Debe introducir la referencia del producto (proveedor).';
           var msgSinNombreProducto='Debe introducir el nombre del producto (proveedor).';
           var msgSinUnidadesLote='Debe introducir las unidades por lote del producto.';
           var msgSinUnidadBasica='Debe introducir la unidade básica del producto.';
           var msgOtrosProveedores='La opción que tiene seleccionada en el desplegable de proveedores no permite verificar los datos.';
           var msgSinNombreProveedor='Debe introducir el nombre del proveedor.';
           
           var msgPrecioReferenciaInventado='El último precio está marcado como NO BASADO EN LOS HISTÓRICOS pero no se ha introducido ningún valor.\nPor favor, introduzca uno o desmarque la casilla correspondiente.';
           


          /*
            
            creamos un array con los proveedores (id) y la referencia ya insertadas
          
          */
          
          var arrayProveedoresProducto=new Array();
          
          ]]></xsl:text> 
          
            <xsl:for-each select="/Mantenimiento/CENTROS/PROVEEDORESADSCRITOS/PROVEEDOR">
               arrayProveedoresProducto[arrayProveedoresProducto.length]=new Array('<xsl:value-of select="ID"/>','<xsl:value-of select="REFERENCIA"/>');
            </xsl:for-each>
          
          <xsl:text disable-output-escaping="yes"><![CDATA[

          
          /*
          
             variables con los datos del top y del opener
          
          */
          
          
          
 
          
          function CerrarVentana(){ 
      
           
      
            if(window.parent.opener && !window.parent.opener.closed){
              var objFrameTop=new Object();          
              objFrameTop=window.parent.opener.top;   
              var FrameOpenerName=window.parent.opener.name;
              var objFrame=new Object();
              objFrame=obtenerFrame(objFrameTop,FrameOpenerName);
              
              if(objFrame!=null && objFrame.recargarPagina){
                objFrame.recargarPagina('PROPAGAR');
              }
              else{
                Refresh(objFrame.document);
              }  	
            }
            window.parent.close();
            
          }
          

              
               
               function BorrarCentro(idCentroProducto,idProductoEstandar,accion){
                 if(confirm(msgConfirmarBorrado)){
                   document.forms[0].elements['ACCION'].value=accion; 
                   document.forms[0].elements['CENTROPRODUCTO_ID'].value=idCentroProducto;
                   document.forms[0].elements['IDPRODUCTOESTANDAR'].value=idProductoEstandar;
                 
                   SubmitForm(document.forms[0]);
                 }
               }
               
               function ModificarCentro(idCentroProducto,idProductoEstandar,accion){
                 document.forms[0].elements['ACCION'].value=accion; 
                 document.forms[0].elements['CENTROPRODUCTO_ID'].value=idCentroProducto;
                 document.forms[0].elements['IDPRODUCTOESTANDAR'].value=idProductoEstandar;
                 
                 
                 SubmitForm(document.forms[0]);
               }
               
        	function ActualizarDatos(form, accion){
        	  if(ValidarFormulario(form)){
        	    document.forms[0].elements['ACCION'].value=accion; 
        	    document.forms[0].elements['IDNUEVOCENTRO'].value=document.forms[0].elements['IDCENTRO'].value;
        	    
        	    /* reemplazamos la coma por el punto de los campos numericos */
        	    
        	    //document.forms[0].elements['CONSUMO'].value=reemplazaComaPorPunto(document.forms[0].elements['CONSUMO'].value);
        	    //document.forms[0].elements['PRECIO'].value=reemplazaComaPorPunto(document.forms[0].elements['PRECIO'].value);
                
        	    var consumoOk = ValidarNumero(document.forms[0].elements['CONSUMO'],2);
                var precioOk = ValidarNumero(document.forms[0].elements['PRECIO'],4);
                
                if (consumoOk != '' || precioOk != ''){ 
                	alert(consumoOk+'\n'+precioOk);
                 }
                else{ SubmitForm(document.forms[0]); }
                  
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
                  
                  if((!errores) && (document.forms[0].elements['IDCENTRO'].value<=-1)){
                    alert(msgSinCentro);
                    document.forms[0].elements['IDCENTRO'].focus();
                    errores++;
                  }
                  
                  /*
                  if((!errores) && (esNulo(document.forms[0].elements['CONSUMO'].value))){
                    alert(msgSinConsumo);
                    document.forms[0].elements['CONSUMO'].focus();
                    errores++;
                  }
                  */
                  
                  /*
                  if((!errores) && (esNulo(document.forms[0].elements['PRECIO'].value))){
                    alert(msgSinPrecio);
                    document.forms[0].elements['PRECIO'].focus();
                    errores++;
                  }
                  
                  */
                  
                  if((!errores) && (document.forms[0].elements['PRECIO_INVENTADO'].checked==true)){
          					if(esNulo(document.forms[0].elements['PRECIO'].value)){
            					errores++;
            					alert(msgPrecioReferenciaInventado);
            					document.forms[0].elements['PRECIO_INVENTADO'].focus();
          					}
        					}
                  
                   if((!errores) && (document.forms[0].elements['IDPROVEEDOR'].value<=-1) && (document.forms[0].elements['IDPROVEEDOR'].value!='')){
                    alert(msgSinProveedor);
                    document.forms[0].elements['IDPROVEEDOR'].focus();
                    errores++;
                  }
                  else{
                    document.forms[0].elements['TIPOPROVEEDOR'].value='';
                    for(var n=0;n<document.forms[0].length;n++){
                      if(document.forms[0].elements[n].type=='checkbox'){
                        if(document.forms[0].elements[n].name.substring(0,18)=='CHK_TIPOPROVEEDOR_' && document.forms[0].elements[n].checked==true){
                          var tipo=document.forms[0].elements[n].name.substring(18,document.forms[0].elements[n].name.length);
                          if(tipo=='IMP'){
                            document.forms[0].elements['TIPOPROVEEDOR'].value='I';
                          }
                          else{
                            if(tipo=='FAB'){
                              document.forms[0].elements['TIPOPROVEEDOR'].value='F';
                            }
                            else{
                              if(tipo=='DIS'){
                                document.forms[0].elements['TIPOPROVEEDOR'].value='D';
                              }
                            }
                          }
                        }
                      }
                    }
                  }
                  
                  if((!errores) && (document.forms[0].elements['IDPROVEEDOR'].value=='') && (esNulo(document.forms[0].elements['NOMBREPRROVEEDORNOAFILIADO'].value))){
                    alert(msgSinNombreProveedor);
                    document.forms[0].elements['NOMBREPRROVEEDORNOAFILIADO'].focus();
                    errores++;
                  }
                  
                  /*
                  if((!errores) && (esNulo(document.forms[0].elements['REFERENCIA'].value))){
                    alert(msgSinReferencia);
                    document.forms[0].elements['REFERENCIA'].focus();
                    errores++;
                  }
                  */
                  
                  /* solo se tienen que informar si no exista la entrada ya */
                  
                  if(!existeProveedorReferencia(document.forms[0].elements['IDPROVEEDOR'].value,document.forms[0].elements['REFERENCIA'].value)){
                  
                    /*
                    if((!errores) && (esNulo(document.forms[0].elements['NOMBREPRODUCTO'].value))){
                      alert(msgSinNombreProducto);
                      document.forms[0].elements['NOMBREPRODUCTO'].focus();
                      errores++;
                    }
                    */
                  
                    //UNIDADES LOTE Y BASICA NO OBLIGATORIAS
                    
                    /*
                    if((!errores) && (esNulo(document.forms[0].elements['UNIDADESLOTE'].value))){
                      alert(msgSinUnidadesLote);
                      document.forms[0].elements['UNIDADESLOTE'].focus();
                      errores++;
                    }
                    
                  
                    if((!errores) && (esNulo(document.forms[0].elements['UNIDADBASICA'].value))){
                      alert(msgSinUnidadBasica);
                      document.forms[0].elements['UNIDADBASICA'].focus();
                      errores++;
                    }
                    
                    */
                    
                  }
           
        	  
        	  if(!errores)
        	    return true;
        	  else
        	    return false;  
        	}
        	
        function existeProveedorReferencia(idProveedor, referencia){
          for(var n=0;n<arrayProveedoresProducto.length;n++){
            if((arrayProveedoresProducto[n][0]==idProveedor) && (arrayProveedoresProducto[n][1]==referencia.toUpperCase()))
              return true;
          }
          
          return false;
        }  	
      
        	
        function ValidarNumero(obj,decimales){
            var msg= '';
            var precio = obj.value
			var lun = precio.length;
			var punto= 0;
			var coma= 0;
			
			for(var i=0;i<lun;i++){
				if ( precio[i] == '.'){ punto = 1;}
				if ( precio[i] == ','){ coma = 1;}
				}
			
			if(punto == 1){
            	if (decimales == 2){ msg = 'Error en el consumo, rogamos no usar el punto.\nPor los decimales use la coma.';}
                else{msg = 'Error en el precio, rogamos no usar el punto.\nPor los decimales use la coma.'; }
				return msg;
			}
            else return msg;
			
			if(checkNumberNulo(obj.value,obj)){
				if(parseFloat(reemplazaComaPorPunto(obj.value))!=0){
					obj.value=anyadirCerosDecimales(reemplazaPuntoPorComa(Round(reemplazaComaPorPunto(obj.value),decimales)),decimales);
				}
			}                
             
        }//fin validar numero
        
        function ComprobarProducto(objIdproveedor, objReferencia){
          
          var errores=0;
          
          if(objIdproveedor.value<=-1){
            alert(msgSinProveedor);
            objIdproveedor.focus();
            errores++;
          }
          else{
            if(objIdproveedor.value==''){
              alert(msgOtrosProveedores);
              objIdproveedor.focus();
              errores++;
            }
          }
          
          if((!errores)&& (objReferencia.value=='')){
            alert(msgSinReferencia);
            objReferencia.focus();
            errores++;
          }
          
          if(!errores){
            parent.frameXML.location.href='http://www.newco.dev.br/ProcesosCdC/CatalogoPrivado/ComprobarProducto.xsql?IDPROVEEDOR='+objIdproveedor.value+'&REFERENCIA='+objReferencia.value+'&DESDE=CENTROS';
          }
          
        }
        
        function CargarNombre(nombre){
          document.forms[0].elements['NOMBREPRODUCTO'].value=nombre;
        }
        function CargarUnidadBasica(unidadBasica){
          document.forms[0].elements['UNIDADBASICA'].value=unidadBasica; 
        }
        function CargarUnidadesPorLote(UnidadesPorLote){
          document.forms[0].elements['UNIDADESLOTE'].value=UnidadesPorLote;
        }
        
        function validarTipoProveedorDespl(form, objOrigen, nombreObjetoDestino){
          
          if(!esNulo(objOrigen.value) && objOrigen.value>-1){
            form.elements[nombreObjetoDestino].value='';
          }
        }
        
        function validarTipoProveedorText(form, objOrigen, nombreObjetoDestino){
          if(!esNulo(objOrigen.value)){
            form.elements[nombreObjetoDestino].selectedIndex=form.elements[nombreObjetoDestino].options.length-1;
          }
        }
        	
		function NuevoCentro()
		{
			var Enlace;
			var form=document.forms[0];

			Enlace='http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/CENManten.xsql?VENTANA=NUEVA'
					+'&'+'EMP_ID='+'&'+'ID=';

			MostrarPag(Enlace, 'Nuevo Centro');
		}
		
		function validarChecks(form, objName){
          for(var n=0;n<form.length;n++){
            if(form.elements[n].type=='checkbox'){
              if(form.elements[n].name.substring(0,18)=='CHK_TIPOPROVEEDOR_' && form.elements[n].name!=objName){
                form.elements[n].checked=false;
              }
            }
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
          <xsl:when test="//Status">
            <xsl:apply-templates select="//Status"/> 
          </xsl:when>
          <xsl:otherwise>  
        <form name="form1" action="MantCentrosCatalogo.xsql" method="post">
          <input type="hidden" name="IDPRODUCTOESTANDAR" value="{Mantenimiento/CENTROS/CENTROACTUAL/IDPRODUCTOESTANDAR}"/>
          <input type="hidden" name="CENTROPRODUCTO_ID" value="{Mantenimiento/CENTROS/CENTROACTUAL/CENTROPRODUCTO_ID}"/>
          <input type="hidden" name="IDDIVISA" value="{Mantenimiento/CENTROS/CENTROACTUAL/IDDIVISA}"/>
          <input type="hidden" name="ACCION"/>
          <input type="hidden" name="IDNUEVOCENTRO"/>
          <input type="hidden" name="TIPOPROVEEDOR" value="{Mantenimiento/CENTROS/CENTROACTUAL/TIPOPROVEEDOR}"/>
          
   
    <h1 class="titlePage">
     	 Centros que utilizan el producto - Mantenimiento de Centros del Catálogo privado
    </h1>
          <!--  CAMPOS QUE FORMAN PARTE LA CLAVE Y QUE SON MODIFICABLES   -->
	     <table class="grandeInicio">
         		<thead>
                       <tr class="titulos">
                         <td>&nbsp;</td>
                         <td class="veinte">
                           Centro
                         </td>
                         <td> 
                           Proveedor
                         </td>
                         <td> 
                           Tipo
                         </td>
                         <td> 
                           Ref.
                         </td>
                         <td> 
                           Nombre del producto
                         </td>    
                         <td> 
                           Compra anual
                         </td>
                         <td> 
                           Precio
                         </td>
                         <td> 
                           Ud. básica
                         </td>
                         <td> 
                           Ud. lote
                         </td>
                       </tr>
                    </thead>
                     <xsl:choose>
                       <xsl:when test="Mantenimiento/CENTROS/CENTROSADSCRITOS/CENTRO">
                         <xsl:for-each select="Mantenimiento/CENTROS/CENTROSADSCRITOS/CENTRO">
                           <tr>
                            
                                   <td>
                                     <a href="javascript:BorrarCentro('{CENTROPRODUCTO_ID}','{IDPRODUCTOESTANDAR}','BORRARCENTRO');">
                                   	<img src="http://www.newco.dev.br/images/2017/trash.png" alt="Eliminar" />
                                   </a>
                             
	                           </td>
	                           <td>
                                    
                                     <a href="javascript:ModificarCentro('{CENTROPRODUCTO_ID}','{IDPRODUCTOESTANDAR}','MODIFICARCENTRO');">
                                       <xsl:value-of select="CEN_NOMBRE"/>
                                     </a>
	                           </td>
	                        
                             <td>
                               <xsl:value-of select="PROV_NOMBRE"/>
                             </td>
                             <td>
                               <xsl:choose>
                                 <xsl:when test="TIPOPROVEEDOR!=''">
                                   <xsl:value-of select="TIPOPROVEEDOR"/>
                                 </xsl:when>
                                 <xsl:otherwise>
                                   --
                                 </xsl:otherwise>
                               </xsl:choose>
                             </td>
                             <td class="quince">
                               <xsl:value-of select="REFERENCIAPRODUCTO"/>
                             </td>
                             <td>
                               <xsl:value-of select="NOMBREPRODUCTO"/>
                             </td>
                             <td>
                               <xsl:value-of select="CONSUMOANUAL"/>
                             </td>
                             <td>
                               <xsl:value-of select="PRECIOMEDIO"/>
                             </td>  
                             <td>
                               <xsl:value-of select="UNIDADBASICA"/>
                             </td> 
                             <td>
                               <xsl:value-of select="UNIDADESLOTE"/>
                             </td>   
                          </tr>
                         </xsl:for-each>
                       </xsl:when>
                       <xsl:otherwise>
                           <tr>
                             <td colspan="10">
                                Ningún Centro
                             </td>  
                           </tr>
                       </xsl:otherwise>
                     </xsl:choose>
                   </table>
          <!--fin tabla resumen centro-->
     <table class="infoTable">
      <tr class="titleTabla">
                    <th colspan="4">Datos</th>
                </tr>
                      <tr>
                        <td class="labelRight">
                          Referencia Producto Estandar
                        </td>
                        <td class="datosLeft trenta" colspan="3">
                          <strong><xsl:value-of select="Mantenimiento/CENTROS/PRODUCTOESTANDAR/REFERENCIAPRODUCTOESTANDAR"/></strong>
                        </td>
                      </tr>
                      <tr>
                        <td class="labelRight quince">
                          Nombre Producto Estandar
                        </td>
                        <td class="datosLeft" colspan="3">
                          <strong><xsl:value-of select="Mantenimiento/CENTROS/PRODUCTOESTANDAR/NOMBREPRODUCTOESTANDAR"/></strong>
                        </td>
                      </tr>
                      <tr>
                        <td  class="labelRight quince">
                          Descripción Producto Estandar
                        </td>
                        <td class="datosLeft" colspan="3">
                          <strong><xsl:copy-of select="Mantenimiento/CENTROS/PRODUCTOESTANDAR/DESCRIPCIONPRODUCTOESTANDAR"/></strong>
                        </td>
                      </tr>
                      <tr>
                        <td class="labelRight veinte">
                          Centro:<span class="camposObligatorios">*</span>
                        </td>
                        <td colspan="3" class="datosLeft">
                        		  <xsl:choose>
                            		<xsl:when test="Mantenimiento/CENTROS/EDICION">
                            		  <xsl:call-template name="field_funcion">
    	                        		<xsl:with-param name="path" select="Mantenimiento/CENTROS/CENTROACTUAL/CENTROS/field[@name='IDCENTRO']"/>
    	                        		<xsl:with-param name="IDAct" select="Mantenimiento/CENTROS/CENTROACTUAL/CENTROS/field[@name='IDCENTRO']/@current"/>
    	                    		  </xsl:call-template>
    	                    		</xsl:when>
    	                    		<xsl:otherwise>  
    	                    		  <xsl:for-each select="Mantenimiento/CENTROS/CENTROACTUAL/CENTROS/field[@name='IDCENTRO']/dropDownList/listElem">
    	                        		<xsl:if test="ID=../../@current">
    	                        		  <input type="hidden" name="IDCENTRO" value="{ID}"/>
    	                        		  <xsl:value-of select="listItem"/>
    	                        		</xsl:if>
    	                    		  </xsl:for-each>
    	                    		</xsl:otherwise>
    	                		  </xsl:choose>
                        </td>
                      </tr>
                      <tr>
                        <td class="labelRight">
                          Compra anual:<!--<span class="camposObligatorios">*</span>-->
                        </td>
                        <td class="datosLeft veintecinco">
                          <input type="text" name="CONSUMO" size="30" maxlength="9" value="{Mantenimiento/CENTROS/CENTROACTUAL/CONSUMOANUAL}" onBlur="ValidarNumero(this,2);"/>
                        </td>
                        <td class="labelRight veinte">
                          Último precio/teórico/prov ant:
                        </td>
                        <td class="datosLeft">
                          <input type="text" name="PRECIO" size="13" maxlength="9" value="{Mantenimiento/CENTROS/CENTROACTUAL/PRECIOMEDIO}" onBlur="ValidarNumero(this,4);"/>
                          &nbsp;
                          <input type="checkbox" name="PRECIO_INVENTADO">
                         		<xsl:if test="Mantenimiento/CENTROS/CENTROACTUAL/PRECIO_INVENTADO='S'">
                          		<xsl:attribute name="checked">checked</xsl:attribute>
                          	</xsl:if>
                          </input>
                          &nbsp;
                          <input type="text" name="PROVEEDOR_ANTERIOR" size="15" maxlength="250" value="{Mantenimiento/CENTROS/CENTROACTUAL/PROVEEDOR_ANTERIOR}"/>
                        </td>
                      </tr>
                      <tr>
                        <td colspan="4">&nbsp;</td>
                      </tr>
                      <tr>
                        <td class="labelRight">
                          Proveedor:<span class="camposObligatorios">*</span>
                        </td>
                        <td colspan="3" class="datosleft">
                          <xsl:call-template name="field_funcion">
    	                    <xsl:with-param name="path" select="Mantenimiento/CENTROS/CENTROACTUAL/PROVEEDORES/field"/>
    	                    <xsl:with-param name="IDAct" select="Mantenimiento/CENTROS/CENTROACTUAL/PROVEEDORES/field[@name='IDPROVEEDOR']/@current"/>
    	                    <xsl:with-param name="cambio">validarTipoProveedorDespl(document.forms[0], this, 'NOMBREPRROVEEDORNOAFILIADO');</xsl:with-param>
    	                  </xsl:call-template>
    	                  &nbsp;
    	                  <input type="text" name="NOMBREPRROVEEDORNOAFILIADO" size="40" maxlength="100" onBlur="validarTipoProveedorText(document.forms[0], this, 'IDPROVEEDOR');">
    	                    <xsl:if test="Mantenimiento/CENTROS/CENTROACTUAL/PROVEEDORES/field[@name='IDPROVEEDOR']/@current=''">
    	                      <xsl:attribute name="value"><xsl:value-of select="Mantenimiento/CENTROS/CENTROACTUAL/PROV_NOMBRE"/></xsl:attribute>
    	                    </xsl:if>
    	                  </input>
                        </td>
                      </tr>
                      <tr>
                        <td class="labelRight">
                          Tipo de proveedor:
                        </td>
                        <td class="datosLeft" colspan="3">
                          <table>
                            <tr>
                              <td>
                                <input type="checkbox" name="CHK_TIPOPROVEEDOR_IMP" onClick="validarChecks(document.forms[0], this.name);">
                                  <xsl:if test="Mantenimiento/CENTROS/CENTROACTUAL/TIPOPROVEEDOR='I'">
                                    <xsl:attribute name="checked">checked</xsl:attribute>
                                  </xsl:if>
                                </input>
                              </td>
                              <td>
                                Importador
                              </td>
                              <td>
                                <input type="checkbox" name="CHK_TIPOPROVEEDOR_FAB" onClick="validarChecks(document.forms[0], this.name);">
                                  <xsl:if test="Mantenimiento/CENTROS/CENTROACTUAL/TIPOPROVEEDOR='F'">
                                    <xsl:attribute name="checked">checked</xsl:attribute>
                                  </xsl:if>
                                </input>
                              </td>
                              <td>
                                Fabricante
                              </td>
                              <td>
                                <input type="checkbox" name="CHK_TIPOPROVEEDOR_DIS" onClick="validarChecks(document.forms[0], this.name);">
                                  <xsl:if test="Mantenimiento/CENTROS/CENTROACTUAL/TIPOPROVEEDOR='D'">
                                    <xsl:attribute name="checked">checked</xsl:attribute>
                                  </xsl:if>
                                </input>
                              </td>
                              <td>
                                Distribuidor
                              </td>
                            </tr>
                          </table>
                        </td>
                      </tr>
                      <tr>
                        <td class="labelRight">
                          Referencia del producto:
                        </td>
                        <td class="datosleft">
                                <input type="text" name="REFERENCIA" size="30" maxlength="100" value="{Mantenimiento/CENTROS/CENTROACTUAL/REFERENCIAPRODUCTO}"/>
                             <xsl:text>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</xsl:text>
                                <xsl:call-template name="botonPersonalizado">
	                          <xsl:with-param name="funcion">ComprobarProducto(document.forms[0].elements['IDPROVEEDOR'],document.forms[0].elements['REFERENCIA']);</xsl:with-param>
	                          <xsl:with-param name="label">Verificar</xsl:with-param>
	                          <xsl:with-param name="status">Verificar Producto</xsl:with-param>
	                        </xsl:call-template>
                        </td>
                        <td class="labelRight">
                          Nombre del producto:<!--<span class="camposObligatorios">**</span>-->
                        </td>
                        <td class="datosLeft">
                          <input type="text" name="NOMBREPRODUCTO" size="30" maxlength="100">
                            <xsl:attribute name="value"><xsl:choose><xsl:when test="Mantenimiento/CENTROS/CENTROACTUAL/NOMBREPRODUCTO!=''"><xsl:value-of select="Mantenimiento/CENTROS/CENTROACTUAL/NOMBREPRODUCTO"/></xsl:when><xsl:otherwise><xsl:value-of select="Mantenimiento/CENTROS/PRODUCTOESTANDAR/NOMBREPRODUCTOESTANDAR"/></xsl:otherwise></xsl:choose></xsl:attribute>
                          </input>
                        </td>
                      </tr>
                      <tr>
                        <td class="labelRight">
                          Ud. básica:
                        </td>
                        <td class="datosleft">
                          <input type="text" name="UNIDADBASICA" size="30" maxlength="100">
                            <xsl:attribute name="value"><xsl:choose><xsl:when test="Mantenimiento/CENTROS/CENTROACTUAL/UNIDADBASICA!=''"><xsl:value-of select="Mantenimiento/CENTROS/CENTROACTUAL/UNIDADBASICA"/></xsl:when><xsl:otherwise><xsl:value-of select="Mantenimiento/CENTROS/PRODUCTOESTANDAR/UNIDADBASICAPRODUCTOESTANDAR"/></xsl:otherwise></xsl:choose></xsl:attribute>
                          </input>
                        </td>
                        <td class="labelRight">
                          Ud. lote:
                        </td>
                        <td class="datosLeft">
                          <input type="text" name="UNIDADESLOTE" size="30" maxlength="100" value="{Mantenimiento/CENTROS/CENTROACTUAL/UNIDADESLOTE}"/>
                        </td>
                      </tr>
                      <tr>
                        <td class="labelRight">
                          Comentarios
                        </td>
                      	<td class="datosLeft" colspan="3">
                          <textarea name="COMENTARIOS"  cols="80" rows="3"><xsl:value-of select="Mantenimiento/CENTROS/CENTROACTUAL/COMENTARIOS"/></textarea>
                        </td>
                      </tr>
                      <tr>
                      <td colspan="2">Los campos marcados con (<span class="camposObligatorios">*</span>) son obligatorios.</td>
                       <td colspan="2">&nbsp;</td>
                      </tr>
          </table>
          <!--fin tabla infoTable--> <br /> <br />         
      <div class="divLeft">
     
                	<div class="divLeft20">&nbsp;</div>
                    <div class="divLeft15nopa">
                          <xsl:call-template name="boton">
                            <xsl:with-param name="path" select="Mantenimiento/botones/button[@label='Cerrar']"/>
                          </xsl:call-template>
                    </div>
                    <div class="divLeft10">&nbsp;</div>
                           <xsl:choose>
                            <xsl:when test="Mantenimiento/ACCION='MODIFICARCENTRO'">
                            <div class="divLeft15nopa">
                              <div class="boton">
                              	<a href="javascript:ModificarCentro('0','{Mantenimiento/CENTROS/CENTROACTUAL/IDPRODUCTOESTANDAR}','NUEVOCENTRO');">
                                Cancelar
                                </a>
                              </div>
                            </div>
                            <div class="divLeft10">&nbsp;</div>
                            <div class="divLeft15nopa">
                             <xsl:call-template name="boton">
                                <xsl:with-param name="path" select="Mantenimiento/botones/button[@label='Guardar']"/>
                              </xsl:call-template>
                            </div>
                              
                            </xsl:when>
                            <xsl:otherwise>
							 <div class="divLeft15nopa">                              
                                   <xsl:call-template name="boton">
                                <xsl:with-param name="path" select="Mantenimiento/botones/button[@label='Insertar']"/>
                              </xsl:call-template>
                              </div>
                            </xsl:otherwise>
                          </xsl:choose>
                     </div><!--fin de divLeft-->
                     <!--fin de buttons-->   
                     
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
