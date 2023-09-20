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
	<xsl:text disable-output-escaping="yes"><![CDATA[
	<link rel="stylesheet" href="http://www.newco.dev.br/General/Estilos.css" type="text/css">
         <script type="text/javascript" src="http://www.newco.dev.br/General/general.js"></script>	
        <script type="text/javascript">
        <!--

          
          function CerrarVentana(){
           window.close();
           Refresh(top.opener.document);
          }
          
          
        
        
        	msgPedidoMinimoActivo='Ha marcado el campo \"Pedido Mínimo\" como \'Activo\'. Por favor, rogamos rellene el campo \"Importe Mínimo\" antes de enviar el formulario.';
        msgNoAceptarOfertas='Ha marcado el campo \"Pedido Mínimo\" como \'No Aceptar Ofertas\'. Por favor, rogamos rellene el campo \"Importe Mínimo\" antes de enviar el formulario.';
        	
        	
               function BorrarPedidoMinimo(idCliente){
                 document.forms[0].elements['ACCION'].value='BORRAR'; 
                 document.forms[0].elements['NUEVO_CLIENTE'].value=idCliente;
                
                 SubmitForm(document.forms[0]);
               }	
        	
        	
        	
        	
        	function ActualizarDatos(form, accion){
        	  if(validarFormulario(form)){
        	    form.elements['NUEVO_CLIENTE'].value=form.elements['IDEMPRESA'].value;
        	    form.elements['ACCION'].value=accion;
        	    SubmitForm(form);
        	  }
        	}
        	
        	function validarFormulario(form){
        	  var errores=0;

        	  if((!errores) && (document.forms[0].elements['EMP_PEDMINIMOACTIVO_CHECK'].checked==true || document.forms[0].elements['EMP_INTEGRADO_CHECK'].checked==true)){
        	    var queMensaje;
        	    if(document.forms[0].elements['EMP_PEDMINIMOACTIVO_CHECK'].checked==true){
        	      document.forms[0].elements['EMP_PEDMINIMOACTIVO'].value='S';
        	      queMensaje='MINIMO_ACTIVO';
        	      if(document.forms[0].elements['EMP_PEDMINIMOESTRICTO_CHECK'].checked==true)
        	        document.forms[0].elements['EMP_PEDMINIMOACTIVO'].value='E';
        	    }
        	    else{
        	      document.forms[0].elements['EMP_PEDMINIMOACTIVO'].value='I';
        	      queMensaje='INTEGRADO';
        	    }
        	    
        	    if(esNulo(document.forms[0].elements['EMP_PEDIDOMINIMO'].value)){
        	      errores=1;
        	      if(queMensaje=='MINIMO_ACTIVO'){
        	        alert(msgPedidoMinimoActivo);
        	      }
        	      else{
        	        alert(msgNoAceptarOfertas);
        	      }
        	      form.elements['EMP_PEDIDOMINIMO'].focus();
        	      return false;
        	    }
        	    else{
        	      document.forms[0].elements['EMP_PEDIDOMINIMO'].value=reemplazaComaPorPunto(document.forms[0].elements['EMP_PEDIDOMINIMO'].value);
        	    }
        	  }
        	  else{
        	    if((!errores) && (document.forms[0].elements['EMP_PEDMINIMOACTIVO_CHECK'].checked==false)){
        	      document.forms[0].elements['EMP_PEDMINIMOACTIVO'].value='N';
        	    }
        	  }
        	  
        	  if(!errores)
        	    return true;  
        	}
        	
        function pedidoMinimo(nombre,form){
          if(nombre=="EMP_PEDMINIMOACTIVO_CHECK"){
            if(form.elements[nombre].checked==true){
              form.elements['EMP_PEDMINIMOESTRICTO_CHECK'].disabled=false;
              form.elements['EMP_PEDIDOMINIMO'].disabled=false;
              form.elements['EMP_DESCRIPCIONPEDIDOMINIMO'].disabled=false;
            }
            else{
              form.elements['EMP_PEDMINIMOESTRICTO_CHECK'].checked=false;
              form.elements['EMP_PEDMINIMOESTRICTO_CHECK'].disabled=true;
              
              form.elements['EMP_PEDIDOMINIMO'].value='';
              form.elements['EMP_PEDIDOMINIMO'].disabled=true;
              
              form.elements['EMP_DESCRIPCIONPEDIDOMINIMO'].value='';
              form.elements['EMP_DESCRIPCIONPEDIDOMINIMO'].disabled=true;
            }
          }
          else{
            if(nombre=="EMP_INTEGRADO_CHECK"){
              if(form.elements['EMP_INTEGRADO_CHECK'].checked==true){
                form.elements['EMP_PEDMINIMOACTIVO_CHECK'].checked=false;
                form.elements['EMP_PEDMINIMOACTIVO_CHECK'].disabled=true;
                form.elements['EMP_PEDMINIMOESTRICTO_CHECK'].checked=false;
                form.elements['EMP_PEDMINIMOESTRICTO_CHECK'].disabled=true;
                form.elements['EMP_PEDIDOMINIMO'].disabled=false;
                form.elements['EMP_DESCRIPCIONPEDIDOMINIMO'].disabled=false;
              }
              else{
                form.elements['EMP_PEDMINIMOACTIVO_CHECK'].disabled=false;
                form.elements['EMP_PEDMINIMOESTRICTO_CHECK'].disabled=true;
                form.elements['EMP_PEDIDOMINIMO'].value='';
                form.elements['EMP_PEDIDOMINIMO'].disabled=true;
                
                form.elements['EMP_DESCRIPCIONPEDIDOMINIMO'].value='';
                form.elements['EMP_DESCRIPCIONPEDIDOMINIMO'].disabled=true;
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
          <xsl:otherwise>    
        <form name="form1" action="PedidoMinimoPorCliente.xsql" method="post">
          <input type="hidden" name="EMP_ID" value="{MantenimientoEmpresas/EMP_ID}"/>
          <input type="hidden" name="ACCION" value="ACTUALIZARCAMBIOS"/>
          <input type="hidden" name="NUEVO_CLIENTE"/>
          
           <input type="hidden" name="EMP_PEDMINIMO_ACTIVO" value="{MantenimientoEmpresas/EMP_PEDMINIMO_ACTIVO}"/>
            <input type="hidden" name="EMP_PEDMINIMO_IMPORTE"  value="{MantenimientoEmpresas/EMP_PEDMINIMO_IMPORTE}"/>
             <input type="hidden" name="EMP_PEDMINIMO_DETALLE"  value="{MantenimientoEmpresas/EMP_PEDMINIMO_DETALLE}"/>
             
        <table width="80%" align="center" class="gris" cellpadding="0" cellspacing="1">
          <tr class="grisClaro">
            <td>
              <table width="100%">
                <tr>
                  <td align="left">
                    <b>Pedido mínimo por cliente</b>
                    <br/>
                    <i>Asigne aquí el pedido minimo que se aplica a un cliente en concreto</i>
                  </td>
                  <td align="right">&nbsp;
                   
                  </td>
                </tr>
              </table>
            </td>
          </tr>
          

          <xsl:if test="MantenimientoEmpresas/EMPRESAS_CON_PEDIDO_MINIMO/EMPRESA">
          <tr class="claro">
            <td class="blanco">
          
            <br/>
            <br/>
               <table width="100%" class="medio" align="center" cellpadding="1" cellspacing="1">
          <tr class="oscuro" align="center">
            <td>
              Empresa
            </td>
            <td>
             Pedido Mínimo
            </td>
            <td>
              Importe Mínimo (Eur)
            </td>
            <td>
              Descripción pedido mínimo:
            </td>
          </tr>

          <xsl:for-each select="MantenimientoEmpresas/EMPRESAS_CON_PEDIDO_MINIMO/EMPRESA">
          
          <tr class="claro" align="center">
            <td align="left">
              <table width="100%">
                <tr>
                  <td>
              <xsl:call-template name="botonPersonalizado">
	      <xsl:with-param name="funcion">BorrarPedidoMinimo('<xsl:value-of select="ID"/>');</xsl:with-param>
	      <xsl:with-param name="label">Eliminar</xsl:with-param>
	      <xsl:with-param name="status">Eliminar Pedido mínimo </xsl:with-param>
	    </xsl:call-template>
	      </td>
	      <td>
	    &nbsp;&nbsp;<xsl:value-of select="NOMBRE"/>
	      </td>
	      </tr>
	      </table>
            </td>
            <td>
             <input type="hidden" name="EMP_PEDMINIMO_ACTIVO_{ID}" value="{ACTIVO}"/>
             <xsl:choose>
               <xsl:when test="ACTIVO='N'">
                 <b>No activo</b>
               </xsl:when>
               <xsl:when test="ACTIVO='S'">
                 <b>Activo</b>
               </xsl:when>
               <xsl:when test="ACTIVO='E'">
                 <b>Estricto</b>
               </xsl:when>
               <xsl:otherwise>
                 <b>Integrado</b>
               </xsl:otherwise>
             </xsl:choose>
            </td>
            <td>
              <xsl:value-of select="IMPORTE"/>
            </td>
            <td align="left" class="claro">

                  <xsl:copy-of select="DESCRIPCION"/>
            </td>
          </tr>
            
          </xsl:for-each>
        </table> 
        <br/>
        <br/>
            </td>
          </tr>
          </xsl:if>
          <tr class="oscuro">
              <td align="left" class="oscuro" colspan="2">
                Añadir Empresa
              </td>
              </tr>
              <tr class="claro" align="center">
              <td colspan="2">
                <select name="IDEMPRESA">
                  <xsl:for-each select="MantenimientoEmpresas/ROWSET/ROW">
                    <option value="{EMP_ID}"><xsl:value-of select="EMP_NOMBRE"/></option>
                  </xsl:for-each>
                </select>
              </td>
            </tr>
          <tr  class="blanco">
            <td class="blanco">
              <table width="100%" align="center" class="medio" cellpadding="1" cellspacing="1">
                <tr class="oscuro" align="center">
                  <td class="oscuro" width="75%">
                    Pedido Mínimo
                  </td>
                  <td class="oscuro" width="*">
                    Importe Mínimo (Eur)
                  </td>
                </tr>
                <tr class="medio" align="center">
                  <td class="medio" width="30%">
                    <table align="left" border="0" width="100%" cellpadding="0" cellspacing="0" class="claro">
           <tr class="claro">
             <td align="right" width="5%">
               Activo:
             </td>
             <td align="left" width="1%">
               <xsl:choose>
                 <xsl:when test="MantenimientoEmpresas/EMP_PEDMINIMO_ACTIVO='S' or MantenimientoEmpresas/EMP_PEDMINIMO_ACTIVO='E'">
                   <input type="checkbox" name="EMP_PEDMINIMOACTIVO_CHECK"  checked="checked" onClick="pedidoMinimo(this.name,document.forms[0]);"/>
                 </xsl:when>
                 <xsl:when test="MantenimientoEmpresas/EMP_PEDMINIMO_ACTIVO='I'">
                   <input type="checkbox" name="EMP_PEDMINIMOACTIVO_CHECK"  disabled="disabled" onClick="pedidoMinimo(this.name,document.forms[0]);"/>
                 </xsl:when>
                 <xsl:otherwise>
                   <input type="checkbox" name="EMP_PEDMINIMOACTIVO_CHECK" onClick="pedidoMinimo(this.name,document.forms[0]);"/>
                 </xsl:otherwise>
               </xsl:choose>
             </td>
           <td width="*" align="left">
             Activar el control de pedido mínimo.
           </td>
         </tr>
         <tr class="claro">
           <td align="right">
             Estricto:
           </td>
           <td align="left">
             <xsl:choose>
                 <xsl:when test="MantenimientoEmpresas/EMP_PEDMINIMO_ACTIVO='S'">
   	           <input type="checkbox" name="EMP_PEDMINIMOESTRICTO_CHECK" onClick="pedidoMinimo(this.name,document.forms[0]);"/>
   	         </xsl:when>
   	         <xsl:when test="MantenimientoEmpresas/EMP_PEDMINIMO_ACTIVO='E'">
   	           <input type="checkbox" name="EMP_PEDMINIMOESTRICTO_CHECK" checked="checked" onClick="pedidoMinimo(this.name,document.forms[0]);"/>
   	         </xsl:when>
   	         <xsl:when test="MantenimientoEmpresas/EMP_PEDMINIMO_ACTIVO='I'">
   	           <input type="checkbox" name="EMP_PEDMINIMOESTRICTO_CHECK" disabled="disabled" onClick="pedidoMinimo(this.name,document.forms[0]);"/>
   	         </xsl:when>
   	         <xsl:otherwise>
   	           <input type="checkbox" disabled="disabled" name="EMP_PEDMINIMOESTRICTO_CHECK" onClick="pedidoMinimo(this.name,document.forms[0]);"/>
   	         </xsl:otherwise>
   	       </xsl:choose>
   	   </td>
   	   <td>
             No permitir el envío de pedidos por debajo del pedido mínimo.
           </td>
   	 </tr>
   	 <tr class="claro">
           <td align="right">
             No aceptar ofertas:
           </td>
           <td align="left">
             <xsl:choose>
                 <xsl:when test="MantenimientoEmpresas/EMP_PEDMINIMO_ACTIVO='I'">
   	           <input type="checkbox" checked="checked" name="EMP_INTEGRADO_CHECK" onClick="pedidoMinimo(this.name,document.forms[0]);"/>
   	         </xsl:when>
   	         <xsl:otherwise>
   	           <input type="checkbox" name="EMP_INTEGRADO_CHECK" onClick="pedidoMinimo(this.name,document.forms[0]);"/>
   	         </xsl:otherwise>
   	       </xsl:choose>
   	   </td>
   	   <td>
             Permitir únicamente el envío de pedidos.
           </td>
   	 </tr>
       </table>
       <input type="hidden" name="EMP_PEDMINIMOACTIVO" value="{MantenimientoEmpresas/EMP_PEDMINIMO_ACTIVO}"/>
                  </td>
                  <td class="claro" width="*">
                    <xsl:choose>
          <xsl:when test="MantenimientoEmpresas/EMP_PEDMINIMO_ACTIVO='S' or MantenimientoEmpresas/EMP_PEDMINIMO_ACTIVO='E' or MantenimientoEmpresas/EMP_PEDMINIMO_ACTIVO='I'">
	    <input type="text" name="EMP_PEDIDOMINIMO" onBlur="checkNumber(this.value, this);" value="{MantenimientoEmpresas/EMP_PEDMINIMO_IMPORTE}"/>
	  </xsl:when>
	  <xsl:otherwise>
	    <input type="text" name="EMP_PEDIDOMINIMO" disabled="disabled" onBlur="checkNumber(this.value, this);"/>
	  </xsl:otherwise>
   	</xsl:choose>
                  </td>
                </tr>
                <tr class="oscuro" align="center">
                <td align="center" class="oscuro"  colspan="2">
          Descripción pedido mínimo 
      </td>
      </tr>
      <tr class="claro" valign="top">
      <td  colspan="2" align="center"> 
         <xsl:choose> 
           <xsl:when test="MantenimientoEmpresas/EMP_PEDMINIMOACTIVO=''">
   	     <textarea name="EMP_DESCRIPCIONPEDIDOMINIMO" cols="60" rows="5" disabled="disabled"></textarea>
   	   </xsl:when>
   	   <xsl:otherwise>
   	     <textarea name="EMP_DESCRIPCIONPEDIDOMINIMO" cols="60" rows="5"><xsl:value-of select="MantenimientoEmpresas/EMP_PEDMINIMO_DETALLE"/></textarea> 
   	   </xsl:otherwise>
   	 </xsl:choose>
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
                      <xsl:with-param name="path" select="MantenimientoEmpresas/button[@label='Cerrar']"/>
                    </xsl:call-template>
                  </td>
                  <td  align="center">
                    <xsl:call-template name="boton">
                      <xsl:with-param name="path" select="MantenimientoEmpresas/button[@label='Insertar']"/>
                    </xsl:call-template>
                  </td>
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