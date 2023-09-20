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
	<title>Mantenimiento de Pedido Mínimo por Cliente</title>
	<link rel="stylesheet" href="http://www.newco.dev.br/General/Estilos.css" type="text/css">
         <script type="text/javascript" src="http://www.newco.dev.br/General/general.js"></script>	
        <script type="text/javascript">
        <!--

          
         
          
       
                 ]]></xsl:text>
                 
                   var pedidoMinimo='<xsl:value-of select="MantenimientoEmpresas/EMP_PEDMINIMO_ACTIVO"/>';
                   var importePedidoMinimo='<xsl:value-of select="MantenimientoEmpresas/EMP_PEDMINIMO_IMPORTE"/>';
                   var descripcionPedidoMinimo='<xsl:value-of select="MantenimientoEmpresas/EMP_PEDMINIMO_DETALLE"/>';
                 
                 <xsl:text disable-output-escaping="yes"><![CDATA[
                 
                 
                 function ModificarComercialZona(idempresa,idcentro,idcomercial,accion){
                 		
                 		document.forms['form1'].elements['ACCION'].value=accion;
                 		
                 		document.forms['form1'].elements['IDEMPRESA'].value=idempresa;
                 		document.forms['form1'].elements['IDCENTRO'].value=idcentro;
                 		document.forms['form1'].elements['IDUSUARIO'].value=idcomercial;
                 		
                 		document.forms['form1'].submit();
                 		
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
          <xsl:otherwise>
            
          <p class="tituloPag" align="center">
            Mantenimiento de comerciales por zona
	  			</p>
          
        <form name="form1" action="ZonasComerciales.xsql" method="post">
          
          <input type="hidden" name="IDEMPRESA"/>
          <input type="hidden" name="IDCENTRO"/>
          <input type="hidden" name="IDUSUARIO"/>

          <input type="hidden" name="ACCION"/>

        <table width="95%" align="center" class="gris" cellpadding="3" cellspacing="1" border="0">
          <tr class="grisClaro">
            <td>
              <table width="100%">
                <tr>
                  <td align="left">
                    <b>Comerciales por zona</b>
                    <br/>
                    <i>Asigne aquí sus comerciales a las clínicas</i>
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
            <td>
              Empresa
            </td>
            <td>
             Clínica
            </td>
            <td>
             Comercial
            </td>
          </tr>
    
                   
                   <!-- si hay empresas las listamos con sus centros indentados (si los hay) -->
          <xsl:choose>
            <xsl:when test="MantenimientoEmpresas/LISTA_COMERCIALES_ZONA/ZONA_COMERCIAL">
                           <!-- mostramos cada empresa -->
              <xsl:for-each select="MantenimientoEmpresas/LISTA_COMERCIALES_ZONA/ZONA_COMERCIAL">
              
              <xsl:if test="not(@seleccionada)">
              
              	<tr class="claro" align="center">
                	<td align="left">
                  	<table width="100%">
                    	<tr>
                      	<td>
                  				<xsl:call-template name="botonPersonalizado">
	          								<xsl:with-param name="funcion">ModificarComercialZona('{IDEMPRESA_CLIENTE}','{IDCENTRO_CLIENTE}','{IDUSUARIO_COMERCIAL}','BORRARCOMERCIAL');</xsl:with-param>
	          								<xsl:with-param name="label">X</xsl:with-param>
	          								<xsl:with-param name="status">Eliminar la asignación del comercial para esta clínica</xsl:with-param>
	          								<xsl:with-param name="fontColor">red</xsl:with-param>
	        								</xsl:call-template>
	          						</td>
	          						<td>
	            						<a href="javascript:ModificarComercialZona('{IDEMPRESA_CLIENTE}','{IDCENTRO_CLIENTE}','{IDUSUARIO_COMERCIAL}','MODIFICARCOMERCIAL');">
	              						&nbsp;&nbsp;<xsl:value-of select="EMPRESA_CLIENTE"/>
	            						</a>
	          						</td>
	          					</tr>
	          				</table>
            			</td>
            		  <td>
            		  	<a href="javascript:ModificarComercialZona('{IDEMPRESA_CLIENTE}','{IDCENTRO_CLIENTE}','{IDUSUARIO_COMERCIAL}','MODIFICARCOMERCIAL');">
	          		  		&nbsp;&nbsp;<xsl:value-of select="CENTRO_CLIENTE"/>
	          				</a>
            		  </td>
            		  <td>
            		  	<a href="javascript:ModificarComercialZona('{IDEMPRESA_CLIENTE}','{IDCENTRO_CLIENTE}','{IDUSUARIO_COMERCIAL}','MODIFICARCOMERCIAL');">
	          		  		&nbsp;&nbsp;<xsl:value-of select="USUARIO_COMERCIAL"/>
	          				</a>
            		  </td>
            		</tr>
            		</xsl:if>
            	</xsl:for-each>   
            </xsl:when>
            <xsl:otherwise>
              <tr class="claro" align="center">
                <td colspan="3" align="center">
                  No se han definido comerciales por zona.
                </td>
              </tr>
            </xsl:otherwise>
          </xsl:choose>
        </table> 
        <br/>
        <br/>
            </td>
          </tr>
          <tr class="oscuro">
              <td align="left" class="oscuro" colspan="2">
                <xsl:choose>
                    <xsl:when test="MantenimientoEmpresas/ACCION='MODIFICARCLIENTE' or MantenimientoEmpresas/ACCION='INSERTARCENTRO' or MantenimientoEmpresas/ACCION='MODIFICARCENTRO' or MantenimientoEmpresas/ACCION='GUARDARCENTRO'">
                      <xsl:choose>
                        <xsl:when test="MantenimientoEmpresas/ACCION='MODIFICARCLIENTE' or MantenimientoEmpresas/ACCION='INSERTARCENTRO' or MantenimientoEmpresas/ACCION='GUARDARCENTRO'">
                         Modificar Empresa / Añadir Centro
                        </xsl:when>
                        <xsl:when test="MantenimientoEmpresas/ACCION='MODIFICARCENTRO'">
                          Modificar Centro
                        </xsl:when>
                      </xsl:choose>
                    </xsl:when>
                    <xsl:otherwise>
                      Añadir Empresa
                    </xsl:otherwise>
                  </xsl:choose>
                
              </td>
              </tr>
              <tr class="claro" align="center">
              <td colspan="2">
              
              <!-- si no tenemos ninguna empresa seleccionada mostramos el desplegable de empresas -->
              
                <xsl:choose>
                  <xsl:when test="MantenimientoEmpresas/ACCION!='MODIFICARCLIENTE' and MantenimientoEmpresas/ACCION!='INSERTARCENTRO' and MantenimientoEmpresas/ACCION!='MODIFICARCENTRO' and MantenimientoEmpresas/ACCION!='GUARDARCENTRO'">
                    <xsl:call-template name="desplegableNoNormalizado">
                      <xsl:with-param name="path" select="MantenimientoEmpresas/ROWSET/ROW"/>
                      <xsl:with-param name="nombre">IDEMPRESA</xsl:with-param>
                    </xsl:call-template>
                  </xsl:when>
                  <xsl:otherwise>
                  
                    <!-- tenemos una empresa editandola, ya sea la info propia de la empresa o la de los centros -->
                                             <!-- mostramos sus centros, si los tiene -->
                  
                    <br/>
                    <table width="95%" align="center" border="0" cellpadding="3" cellspacing="1" class="gris">
                      <tr class="grisClaro">
                        <td class="grisClaro" align="center">
                          Empresa 
                        </td>
                        <td class="grisClaro" align="center">
                          Pedido Mínimo
                        </td>
                        <td class="grisClaro" align="center">
                          Importe Mínimo(Eur.)
                        </td>
                        <td class="grisClaro" align="center">
                          Descripción Pedido Mínimo
                        </td>
                      </tr>
                      <tr class="claro">
                        <td class="claro" align="center">
                          <b><xsl:value-of select="MantenimientoEmpresas/EMPRESAS_CON_PEDIDO_MINIMO/EMPRESA_SELECCIONADA/NOMBRE"/></b>
                          <input type="hidden" name="IDEMPRESA" value="{MantenimientoEmpresas/EMPRESAS_CON_PEDIDO_MINIMO/EMPRESA_SELECCIONADA/ID}"/>
                        </td>
                        <td class="claro" align="center">
                          <xsl:choose>
                            <xsl:when test="MantenimientoEmpresas/EMPRESAS_CON_PEDIDO_MINIMO/EMPRESA_SELECCIONADA/ACTIVO='N'">
                              <b>No activo</b>
                            </xsl:when>
                            <xsl:when test="MantenimientoEmpresas/EMPRESAS_CON_PEDIDO_MINIMO/EMPRESA_SELECCIONADA/ACTIVO='S'">
                              <b>Activo</b>
                            </xsl:when>
                            <xsl:when test="MantenimientoEmpresas/EMPRESAS_CON_PEDIDO_MINIMO/EMPRESA_SELECCIONADA/ACTIVO='E'">
                              <b>Estricto</b>
                            </xsl:when>
                            <xsl:when test="MantenimientoEmpresas/EMPRESAS_CON_PEDIDO_MINIMO/EMPRESA_SELECCIONADA/ACTIVO='I'">
                              <b>Integrado</b>
                            </xsl:when>
                          </xsl:choose>
                        </td>
                        <td class="claro" align="center">
                          <b><xsl:value-of select="MantenimientoEmpresas/EMPRESAS_CON_PEDIDO_MINIMO/EMPRESA_SELECCIONADA/IMPORTE"/></b>
                        </td>
                        <td class="claro" align="left">
                          <b><xsl:copy-of select="MantenimientoEmpresas/EMPRESAS_CON_PEDIDO_MINIMO/EMPRESA_SELECCIONADA/DESCRIPCION_HTML"/></b>
                        </td>
                      </tr>
                      <tr class="oscuro">
                        <td class="oscuro" align="center">
                          Centro 
                        </td>
                        <td class="oscuro" align="center">
                          Pedido Mínimo
                        </td>
                        <td class="oscuro" align="center">
                          Importe Mínimo(Eur.)
                        </td>
                        <td class="oscuro" align="center">
                          Descripción Pedido Mínimo
                        </td>
                      </tr>
                      
                      <!-- mostramos cada uno de sus centros -->
                      
                      <xsl:choose>
                        <xsl:when test="MantenimientoEmpresas/EMPRESAS_CON_PEDIDO_MINIMO/EMPRESA_SELECCIONADA/CENTROS_CON_PEDIDO_MINIMO/CENTRO">
                          <xsl:for-each select="MantenimientoEmpresas/EMPRESAS_CON_PEDIDO_MINIMO/EMPRESA_SELECCIONADA/CENTROS_CON_PEDIDO_MINIMO/CENTRO">
                            <tr class="claro">
                              <td class="claro">
                              <table width="100%" align="right" border="0">
                                <tr>
                                  <td width="15%">
                                    <xsl:call-template name="botonPersonalizado">
	                              <xsl:with-param name="funcion">BorrarPedidoMinimo('<xsl:value-of select="../../ID"/>','<xsl:value-of select="ID"/>','BORRARCENTRO','CENTRO');</xsl:with-param>
	                              <xsl:with-param name="label">X</xsl:with-param>
	                              <xsl:with-param name="status">Eliminar Pedido mínimo del centro</xsl:with-param>
	                              <xsl:with-param name="fontColor">red</xsl:with-param>
	                            </xsl:call-template>
	                          </td>
	                          <td align="left">
	                            <a href="javascript:ModificarPedidoMinimo('{../../ID}','{ID}','MODIFICARCENTRO');">
	                              &nbsp;&nbsp;<xsl:value-of select="NOMBRE"/>
	                            </a>
	                          </td>
	                        </tr>
	                      </table>
                              </td>
                              <td class="claro" align="center">
                                <input type="hidden" name="EMP_PEDMINIMO_ACTIVO_CEN_{ID}" value="{ACTIVO}"/>
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
                                  <xsl:when test="ACTIVO='I'">
                                    <b>Integrado</b>
                                  </xsl:when>
                                </xsl:choose>
                              </td>
                              <td class="claro" align="center">
                                <xsl:value-of select="IMPORTE"/>
                              </td>
                              <td class="claro">
                                <xsl:copy-of select="DESCRIPCION_HTML"/>
                              </td>
                            </tr>
                          </xsl:for-each>
                        </xsl:when>
                        <xsl:otherwise>
                          <tr class="claro">
                            <td align="center" class="claro" colspan="4">
                              Ningún Centro con Pedido Mínimo
                            </td>
                          </tr>
                        </xsl:otherwise>
                      </xsl:choose>
                      
                       <!-- mostramos el desplegable con los centros de la empresa seleccionada -->
                      
                      <!--
                      <xsl:choose>
                        <xsl:when test="/MantenimientoEmpresas/ACCION='MODIFICARCENTRO'">
                          
                          <tr class="claro">
                            <td align="center" class="claro" colspan="4">
                              <xsl:value-of select="/MantenimientoEmpresas/EMPRESAS_CON_PEDIDO_MINIMO/EMPRESA_SELECCIONADA/CENTROS_CON_PEDIDO_MINIMO/CENTRO_SELECCIONADO/NOMBRE"/>
                              <input type="hidden" name="IDCENTRO" value="{/MantenimientoEmpresas/EMPRESAS_CON_PEDIDO_MINIMO/EMPRESA_SELECCIONADA/CENTROS_CON_PEDIDO_MINIMO/CENTRO_SELECCIONADO/ID}"/>
                            </td>
                          </tr>
                          
                        </xsl:when>
                        <xsl:otherwise>
                          
                      <tr class="claro">
                        <td align="center" class="claro" colspan="4">
                          <xsl:call-template name="field_funcion">
                            <xsl:with-param name="path" select="/MantenimientoEmpresas/EMPRESAS_CON_PEDIDO_MINIMO/EMPRESA_SELECCIONADA/CENTROS_CON_PEDIDO_MINIMO/field[@name='IDCENTRO']"/>
                            <xsl:with-param name="IDAct" select="/MantenimientoEmpresas/EMPRESAS_CON_PEDIDO_MINIMO/EMPRESA_SELECCIONADA/CENTROS_CON_PEDIDO_MINIMO/field[@name='IDCENTRO']/@current"/>
                          </xsl:call-template>
                        </td>
                      </tr>
                          
                        </xsl:otherwise>
                      </xsl:choose>
                      -->
                      
                     
                      
                     
                      
                      <!-- mostramos los botones de edicion de los centros -->
                      <!--
                      <tr class="claro" align="center">
                        <td align="center" class="claro" colspan="4">
                          <xsl:call-template name="boton">
                            <xsl:with-param name="path" select="MantenimientoEmpresas/button[@label='InsertarCentro']"/>
                          </xsl:call-template>
                        </td>
                      </tr>
                      
                      -->
                    </table>
                    <br/> 
                  </xsl:otherwise>
                </xsl:choose>
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
                    <table align="left" border="0" width="100%" cellpadding="1" cellspacing="3" class="claro">
           
           <!-- si hay alguna empresa seleccionada mostramos el desplegable de centros o el centro seleccionado -->
           
           <xsl:if test="/MantenimientoEmpresas/EMPRESAS_CON_PEDIDO_MINIMO/EMPRESA_SELECCIONADA">
             <xsl:choose>
               <xsl:when test="/MantenimientoEmpresas/ACCION='MODIFICARCENTRO'">
                 
                 <tr class="claro">
                   <td class="claro" align="right">
                     Centro:
                   </td>
                   <td class="claro" align="left" colspan="2">
                     &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                     <b><xsl:value-of select="/MantenimientoEmpresas/EMPRESAS_CON_PEDIDO_MINIMO/EMPRESA_SELECCIONADA/CENTROS_CON_PEDIDO_MINIMO/CENTRO_SELECCIONADO/NOMBRE"/></b>
                     <input type="hidden" name="IDCENTRO" value="{/MantenimientoEmpresas/EMPRESAS_CON_PEDIDO_MINIMO/EMPRESA_SELECCIONADA/CENTROS_CON_PEDIDO_MINIMO/CENTRO_SELECCIONADO/ID}"/>
                   </td>
                 </tr>
                 
               </xsl:when>
               <xsl:otherwise>
                 
                  <tr class="claro">
                    <td class="claro" align="right">
                      Centro:
                    </td>
                    <td align="left" class="claro" colspan="2">
                      &nbsp;
                      <xsl:call-template name="field_funcion">
                        <xsl:with-param name="path" select="/MantenimientoEmpresas/EMPRESAS_CON_PEDIDO_MINIMO/EMPRESA_SELECCIONADA/CENTROS_CON_PEDIDO_MINIMO/field[@name='IDCENTRO']"/>
                        <xsl:with-param name="IDAct" select="/MantenimientoEmpresas/EMPRESAS_CON_PEDIDO_MINIMO/EMPRESA_SELECCIONADA/CENTROS_CON_PEDIDO_MINIMO/field[@name='IDCENTRO']/@current"/>
                      </xsl:call-template>
                    </td>
                  </tr>
                 
               </xsl:otherwise>
             </xsl:choose>
           </xsl:if>
           <tr class="claro">
             <td align="right" width="15%">
               Activo:
             </td>
             <td align="left" width="1%">
               <xsl:choose>
                  <xsl:when test="MantenimientoEmpresas/ACCION!='MODIFICARCLIENTE' and MantenimientoEmpresas/ACCION!='INSERTARCENTRO' and MantenimientoEmpresas/ACCION!='MODIFICARCENTRO' and MantenimientoEmpresas/ACCION!='GUARDARCENTRO'">
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
                  </xsl:when>
                  <xsl:when test="MantenimientoEmpresas/ACCION='MODIFICARCENTRO'">
                    <xsl:choose>
                      <xsl:when test="MantenimientoEmpresas/EMPRESAS_CON_PEDIDO_MINIMO/EMPRESA_SELECCIONADA/CENTROS_CON_PEDIDO_MINIMO/CENTRO_SELECCIONADO/ACTIVO='S' or MantenimientoEmpresas/EMPRESAS_CON_PEDIDO_MINIMO/EMPRESA_SELECCIONADA/CENTROS_CON_PEDIDO_MINIMO/CENTRO_SELECCIONADO/ACTIVO='E'">
                        <input type="checkbox" name="EMP_PEDMINIMOACTIVO_CHECK"  checked="checked" onClick="pedidoMinimo(this.name,document.forms[0]);"/>
                      </xsl:when>
                      <xsl:when test="MantenimientoEmpresas/EMPRESAS_CON_PEDIDO_MINIMO/EMPRESA_SELECCIONADA/CENTROS_CON_PEDIDO_MINIMO/CENTRO_SELECCIONADO/ACTIVO='I'">
                        <input type="checkbox" name="EMP_PEDMINIMOACTIVO_CHECK"  disabled="disabled" onClick="pedidoMinimo(this.name,document.forms[0]);"/>
                      </xsl:when>
                      <xsl:otherwise>
                        <input type="checkbox" name="EMP_PEDMINIMOACTIVO_CHECK" onClick="pedidoMinimo(this.name,document.forms[0]);"/>
                      </xsl:otherwise>
                    </xsl:choose>
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:choose>
                      <xsl:when test="MantenimientoEmpresas/EMPRESAS_CON_PEDIDO_MINIMO/EMPRESA_SELECCIONADA/ACTIVO='S' or MantenimientoEmpresas/EMPRESAS_CON_PEDIDO_MINIMO/EMPRESA_SELECCIONADA/ACTIVO='E'">
                        <input type="checkbox" name="EMP_PEDMINIMOACTIVO_CHECK"  checked="checked" onClick="pedidoMinimo(this.name,document.forms[0]);"/>
                      </xsl:when>
                      <xsl:when test="MantenimientoEmpresas/EMPRESAS_CON_PEDIDO_MINIMO/EMPRESA_SELECCIONADA/ACTIVO='I'">
                        <input type="checkbox" name="EMP_PEDMINIMOACTIVO_CHECK"  disabled="disabled" onClick="pedidoMinimo(this.name,document.forms[0]);"/>
                      </xsl:when>
                      <xsl:otherwise>
                        <input type="checkbox" name="EMP_PEDMINIMOACTIVO_CHECK" onClick="pedidoMinimo(this.name,document.forms[0]);"/>
                      </xsl:otherwise>
                    </xsl:choose>   
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
               <xsl:when test="MantenimientoEmpresas/ACCION!='MODIFICARCLIENTE' and MantenimientoEmpresas/ACCION!='INSERTARCENTRO' and MantenimientoEmpresas/ACCION!='MODIFICARCENTRO' and MantenimientoEmpresas/ACCION!='GUARDARCENTRO'">
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
   	          </xsl:when>
   	          <xsl:when test="MantenimientoEmpresas/ACCION='MODIFICARCENTRO'">
                    <xsl:choose>
                      <xsl:when test="MantenimientoEmpresas/EMPRESAS_CON_PEDIDO_MINIMO/EMPRESA_SELECCIONADA/CENTROS_CON_PEDIDO_MINIMO/CENTRO_SELECCIONADO/ACTIVO='S'">
   	                <input type="checkbox" name="EMP_PEDMINIMOESTRICTO_CHECK" onClick="pedidoMinimo(this.name,document.forms[0]);"/>
   	              </xsl:when>
   	              <xsl:when test="MantenimientoEmpresas/EMPRESAS_CON_PEDIDO_MINIMO/EMPRESA_SELECCIONADA/CENTROS_CON_PEDIDO_MINIMO/CENTRO_SELECCIONADO/ACTIVO='E'">
   	                <input type="checkbox" name="EMP_PEDMINIMOESTRICTO_CHECK" checked="checked" onClick="pedidoMinimo(this.name,document.forms[0]);"/>
   	              </xsl:when>
   	              <xsl:when test="MantenimientoEmpresas/EMPRESAS_CON_PEDIDO_MINIMO/EMPRESA_SELECCIONADA/CENTROS_CON_PEDIDO_MINIMO/CENTRO_SELECCIONADO/ACTIVO='I'">
   	                <input type="checkbox" name="EMP_PEDMINIMOESTRICTO_CHECK" disabled="disabled" onClick="pedidoMinimo(this.name,document.forms[0]);"/>
   	              </xsl:when>
   	              <xsl:otherwise>
   	                <input type="checkbox" disabled="disabled" name="EMP_PEDMINIMOESTRICTO_CHECK" onClick="pedidoMinimo(this.name,document.forms[0]);"/>
   	              </xsl:otherwise>
   	            </xsl:choose> 
   	          </xsl:when>
   	          <xsl:otherwise>
   	            <xsl:choose>
                      <xsl:when test="MantenimientoEmpresas/EMPRESAS_CON_PEDIDO_MINIMO/EMPRESA_SELECCIONADA/ACTIVO='S'">
   	                <input type="checkbox" name="EMP_PEDMINIMOESTRICTO_CHECK" onClick="pedidoMinimo(this.name,document.forms[0]);"/>
   	              </xsl:when>
   	              <xsl:when test="MantenimientoEmpresas/EMPRESAS_CON_PEDIDO_MINIMO/EMPRESA_SELECCIONADA/ACTIVO='E'">
   	                <input type="checkbox" name="EMP_PEDMINIMOESTRICTO_CHECK" checked="checked" onClick="pedidoMinimo(this.name,document.forms[0]);"/>
   	              </xsl:when>
   	              <xsl:when test="MantenimientoEmpresas/EMPRESAS_CON_PEDIDO_MINIMO/EMPRESA_SELECCIONADA/ACTIVO='I'">
   	                <input type="checkbox" name="EMP_PEDMINIMOESTRICTO_CHECK" disabled="disabled" onClick="pedidoMinimo(this.name,document.forms[0]);"/>
   	              </xsl:when>
   	              <xsl:otherwise>
   	                <input type="checkbox" disabled="disabled" name="EMP_PEDMINIMOESTRICTO_CHECK" onClick="pedidoMinimo(this.name,document.forms[0]);"/>
   	              </xsl:otherwise>
   	            </xsl:choose> 
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
               <xsl:when test="MantenimientoEmpresas/ACCION!='MODIFICARCLIENTE' and MantenimientoEmpresas/ACCION!='INSERTARCENTRO' and MantenimientoEmpresas/ACCION!='MODIFICARCENTRO' and MantenimientoEmpresas/ACCION!='GUARDARCENTRO'">
                 <xsl:choose>
                   <xsl:when test="MantenimientoEmpresas/EMP_PEDMINIMO_ACTIVO='I'">
   	             <input type="checkbox" checked="checked" name="EMP_INTEGRADO_CHECK" onClick="pedidoMinimo(this.name,document.forms[0]);"/>
   	           </xsl:when>
   	           <xsl:otherwise>
   	             <input type="checkbox" name="EMP_INTEGRADO_CHECK" onClick="pedidoMinimo(this.name,document.forms[0]);"/>
   	           </xsl:otherwise>
   	         </xsl:choose>
   	       </xsl:when>
   	       <xsl:when test="MantenimientoEmpresas/ACCION='MODIFICARCENTRO'">
   	         <xsl:choose>
                   <xsl:when test="MantenimientoEmpresas/EMPRESAS_CON_PEDIDO_MINIMO/EMPRESA_SELECCIONADA/CENTROS_CON_PEDIDO_MINIMO/CENTRO_SELECCIONADO/ACTIVO='I'">
	             <input type="checkbox" checked="checked" name="EMP_INTEGRADO_CHECK" onClick="pedidoMinimo(this.name,document.forms[0]);"/>
   	           </xsl:when>
   	           <xsl:otherwise>
   	             <input type="checkbox" name="EMP_INTEGRADO_CHECK" onClick="pedidoMinimo(this.name,document.forms[0]);"/>
   	           </xsl:otherwise>
   	         </xsl:choose>
   	       </xsl:when>
   	       <xsl:otherwise>
   	         <xsl:choose>
                   <xsl:when test="MantenimientoEmpresas/EMPRESAS_CON_PEDIDO_MINIMO/EMPRESA_SELECCIONADA/ACTIVO='I'">
   	             <input type="checkbox" checked="checked" name="EMP_INTEGRADO_CHECK" onClick="pedidoMinimo(this.name,document.forms[0]);"/>
   	           </xsl:when>
   	           <xsl:otherwise>
   	             <input type="checkbox" name="EMP_INTEGRADO_CHECK" onClick="pedidoMinimo(this.name,document.forms[0]);"/>
   	           </xsl:otherwise>
   	         </xsl:choose>
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
          <xsl:when test="MantenimientoEmpresas/ACCION!='MODIFICARCLIENTE' and MantenimientoEmpresas/ACCION!='INSERTARCENTRO' and MantenimientoEmpresas/ACCION!='MODIFICARCENTRO' and MantenimientoEmpresas/ACCION!='GUARDARCENTRO'">
            <xsl:choose>
              <xsl:when test="MantenimientoEmpresas/EMP_PEDMINIMO_ACTIVO='S' or MantenimientoEmpresas/EMP_PEDMINIMO_ACTIVO='E' or MantenimientoEmpresas/EMP_PEDMINIMO_ACTIVO='I'">
	        <input type="text" name="EMP_PEDIDOMINIMO" onBlur="ValidarNumero(this,2);" value="{MantenimientoEmpresas/EMP_PEDMINIMO_IMPORTE}"/>
	      </xsl:when>
	      <xsl:otherwise>
	        <input type="text" name="EMP_PEDIDOMINIMO" disabled="disabled" onBlur="ValidarNumero(this,2);"/>
	      </xsl:otherwise>
   	    </xsl:choose>  
   	  </xsl:when>
   	  <xsl:when test="MantenimientoEmpresas/ACCION='MODIFICARCENTRO'">
   	    <xsl:choose>
              <xsl:when test="MantenimientoEmpresas/EMPRESAS_CON_PEDIDO_MINIMO/EMPRESA_SELECCIONADA/CENTROS_CON_PEDIDO_MINIMO/CENTRO_SELECCIONADO/ACTIVO='S' or MantenimientoEmpresas/EMPRESAS_CON_PEDIDO_MINIMO/EMPRESA_SELECCIONADA/CENTROS_CON_PEDIDO_MINIMO/CENTRO_SELECCIONADO/ACTIVO='E' or MantenimientoEmpresas/EMPRESAS_CON_PEDIDO_MINIMO/EMPRESA_SELECCIONADA/CENTROS_CON_PEDIDO_MINIMO/CENTRO_SELECCIONADO/ACTIVO='I'">
	        <input type="text" name="EMP_PEDIDOMINIMO" onBlur="ValidarNumero(this,2);" value="{MantenimientoEmpresas/EMPRESAS_CON_PEDIDO_MINIMO/EMPRESA_SELECCIONADA/CENTROS_CON_PEDIDO_MINIMO/CENTRO_SELECCIONADO/IMPORTE}"/>
	      </xsl:when>
	      <xsl:otherwise>
	        <input type="text" name="EMP_PEDIDOMINIMO" disabled="disabled" onBlur="ValidarNumero(this,2);"/>
	      </xsl:otherwise>
   	    </xsl:choose>
   	  </xsl:when>
   	  <xsl:otherwise>
   	    <xsl:choose>
              <xsl:when test="MantenimientoEmpresas/EMPRESAS_CON_PEDIDO_MINIMO/EMPRESA_SELECCIONADA/ACTIVO='S' or MantenimientoEmpresas/EMPRESAS_CON_PEDIDO_MINIMO/EMPRESA_SELECCIONADA/ACTIVO='E' or MantenimientoEmpresas/EMPRESAS_CON_PEDIDO_MINIMO/EMPRESA_SELECCIONADA/ACTIVO='I'">
	        <input type="text" name="EMP_PEDIDOMINIMO" onBlur="ValidarNumero(this,2);" value="{MantenimientoEmpresas/EMPRESAS_CON_PEDIDO_MINIMO/EMPRESA_SELECCIONADA/IMPORTE}"/>
	      </xsl:when>
	      <xsl:otherwise>
	        <input type="text" name="EMP_PEDIDOMINIMO" disabled="disabled" onBlur="ValidarNumero(this,2);"/>
	      </xsl:otherwise>
   	    </xsl:choose>
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
          <xsl:when test="MantenimientoEmpresas/ACCION!='MODIFICARCLIENTE' and MantenimientoEmpresas/ACCION!='INSERTARCENTRO' and MantenimientoEmpresas/ACCION!='MODIFICARCENTRO' and MantenimientoEmpresas/ACCION!='GUARDARCENTRO'">
            <xsl:choose> 
              <xsl:when test="MantenimientoEmpresas/EMP_PEDMINIMO_ACTIVO='' or MantenimientoEmpresas/EMP_PEDMINIMO_ACTIVO='N'">
   	        <textarea name="EMP_DESCRIPCIONPEDIDOMINIMO" cols="60" rows="5" disabled="disabled"></textarea>
   	      </xsl:when>
   	      <xsl:otherwise>
   	        <textarea name="EMP_DESCRIPCIONPEDIDOMINIMO" cols="60" rows="5">
   	        </textarea> 
   	      </xsl:otherwise>
   	    </xsl:choose>    
   	  </xsl:when>
   	  <xsl:when test="MantenimientoEmpresas/ACCION='MODIFICARCENTRO'">
            <xsl:choose> 
              <xsl:when test="MantenimientoEmpresas/EMPRESAS_CON_PEDIDO_MINIMO/EMPRESA_SELECCIONADA/CENTROS_CON_PEDIDO_MINIMO/CENTRO_SELECCIONADO/EMP_PEDMINIMO_ACTIVO='' or MantenimientoEmpresas/EMPRESAS_CON_PEDIDO_MINIMO/EMPRESA_SELECCIONADA/CENTROS_CON_PEDIDO_MINIMO/CENTRO_SELECCIONADO/EMP_PEDMINIMO_ACTIVO='N'">
   	        <textarea name="EMP_DESCRIPCIONPEDIDOMINIMO" cols="60" rows="5" disabled="disabled">
   	        </textarea>
   	      </xsl:when>
   	      <xsl:otherwise>
   	        <textarea name="EMP_DESCRIPCIONPEDIDOMINIMO" cols="60" rows="5">
   	          <xsl:value-of select="MantenimientoEmpresas/EMPRESAS_CON_PEDIDO_MINIMO/EMPRESA_SELECCIONADA/CENTROS_CON_PEDIDO_MINIMO/CENTRO_SELECCIONADO/DESCRIPCION"/>
   	        </textarea> 
   	      </xsl:otherwise>
   	    </xsl:choose>
   	  </xsl:when>
   	  <xsl:otherwise>
   	    <xsl:choose> 
              <xsl:when test="MantenimientoEmpresas/EMPRESAS_CON_PEDIDO_MINIMO/EMPRESA_SELECCIONADA/EMP_PEDMINIMO_ACTIVO='' or MantenimientoEmpresas/EMPRESAS_CON_PEDIDO_MINIMO/EMPRESA_SELECCIONADA/EMP_PEDMINIMO_ACTIVO='N'">
   	        <textarea name="EMP_DESCRIPCIONPEDIDOMINIMO" cols="60" rows="5" disabled="disabled">
   	        </textarea>
   	      </xsl:when>
   	      <xsl:otherwise>
   	        <textarea name="EMP_DESCRIPCIONPEDIDOMINIMO" cols="60" rows="5">
   	          <xsl:value-of select="MantenimientoEmpresas/EMPRESAS_CON_PEDIDO_MINIMO/EMPRESA_SELECCIONADA/DESCRIPCION"/>
   	        </textarea> 
   	      </xsl:otherwise>
   	    </xsl:choose>
   	  </xsl:otherwise>
   	</xsl:choose>
      </td>
           </tr>       
              </table>
            </td>
          </tr>
          </table>
          <br/>
          <table width="100%" class="blanco">
                <tr>
                  <td align="center">
                    <xsl:call-template name="boton">
                      <xsl:with-param name="path" select="MantenimientoEmpresas/button[@label='Cerrar']"/>
                    </xsl:call-template>
                    <!--<br/>
                    <xsl:value-of select="MantenimientoEmpresas/ACCION"/>-->
                  </td>
                  <xsl:choose>
                    <xsl:when test="MantenimientoEmpresas/ACCION='MODIFICARCLIENTE' or MantenimientoEmpresas/ACCION='INSERTARCENTRO' or MantenimientoEmpresas/ACCION='MODIFICARCENTRO' or MantenimientoEmpresas/ACCION='GUARDARCENTRO'">
                      <td  align="center"> 
                              <xsl:call-template name="botonPersonalizado">
	                       <xsl:with-param name="funcion">NuevoPedidoMinimoPorCliente(document.forms[0]);</xsl:with-param>
	                       <xsl:with-param name="label">Cancelar</xsl:with-param>
	                       <xsl:with-param name="status">Cancelar la modificación el centro</xsl:with-param>
	                       <xsl:with-param name="ancho">120px</xsl:with-param>
	                      </xsl:call-template>
                      </td>
                      <xsl:choose>
                        <xsl:when test="MantenimientoEmpresas/ACCION='MODIFICARCLIENTE' or MantenimientoEmpresas/ACCION='INSERTARCENTRO' or MantenimientoEmpresas/ACCION='GUARDARCENTRO'">
                          <td align="center" colspan="4">
                              <xsl:call-template name="boton">
                                <xsl:with-param name="path" select="MantenimientoEmpresas/button[@label='InsertarCentro']"/>
                              </xsl:call-template>
                          </td>
                          <td  align="center">
                            <xsl:call-template name="boton">
                              <xsl:with-param name="path" select="MantenimientoEmpresas/button[@label='GuardarEmpresa']"/>
                            </xsl:call-template>
                          </td>
                        </xsl:when>
                        <xsl:when test="MantenimientoEmpresas/ACCION='MODIFICARCENTRO'">
                          <td align="center" colspan="4">
                              <xsl:call-template name="boton">
                                <xsl:with-param name="path" select="MantenimientoEmpresas/button[@label='GuardarCentro']"/>
                              </xsl:call-template>
                          </td>
                        </xsl:when>
                      </xsl:choose>
                    </xsl:when>
                    <xsl:otherwise>
                      <td  align="center">
                        <xsl:call-template name="boton">
                          <xsl:with-param name="path" select="MantenimientoEmpresas/button[@label='InsertarEmpresa']"/>
                        </xsl:call-template>
                      </td>
                    </xsl:otherwise>
                  </xsl:choose>
                  
                </tr>
              </table>
        </form>
        </xsl:otherwise>
        </xsl:choose>
      </body>
    </html>
  </xsl:template>
  
  
  <xsl:template name="desplegableNoNormalizado">
    <xsl:param name="path"/>
    <xsl:param name="onChange"/>
    <xsl:param name="defecto"/>
    <xsl:param name="deshabilitado"/>
    <xsl:param name="nombre"/>
    
    <select>
      <xsl:attribute name="name"><xsl:value-of select="$nombre"/></xsl:attribute>
      <xsl:choose>
        <xsl:when test="$onChange!=''">
          <xsl:attribute name="onChange"><xsl:value-of select="$onChange"/></xsl:attribute>
        </xsl:when>
      </xsl:choose>
      
      <xsl:if test="$deshabilitado!=''">
        <xsl:attribute name="disabled"><xsl:value-of select="$deshabilitado"/></xsl:attribute>
      </xsl:if>

                <option value="-1">Seleccione una empresa</option>
                <xsl:for-each select="$path">
                    <xsl:choose>
                      <xsl:when test="$defecto=EMP_ID">
                        <option>
                                <xsl:attribute name="value"><xsl:value-of select="EMP_ID"/></xsl:attribute>
                                <xsl:attribute name="selected">yes</xsl:attribute>
                                [<xsl:value-of select="EMP_NOMBRE"/>]
                        </option>
                      </xsl:when>
                      <xsl:otherwise>
                        <option>
                                <xsl:attribute name="value"><xsl:value-of select="EMP_ID"/></xsl:attribute>
                                <xsl:value-of select="EMP_NOMBRE"/>
                        </option>
                      </xsl:otherwise>
                    </xsl:choose>
              </xsl:for-each>
        </select>

</xsl:template>




</xsl:stylesheet>