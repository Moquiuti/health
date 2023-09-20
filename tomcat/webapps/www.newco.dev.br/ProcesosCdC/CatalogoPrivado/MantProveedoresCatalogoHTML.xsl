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
          Mantenimiento de Proveedores del Catálogo Privado
        </title>
      <!--style-->
      <xsl:call-template name="estiloIndip"/>
      <!--fin de style-->  

     <script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
	 <script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>
     <script type="text/javascript" src="http://www.newco.dev.br/ProcesosCdC/CatalogoPrivado/mantProveedoresCatalogo.js"></script>
        

      </head>
      <body class="gris">
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
		
        <form name="form1" action="MantProveedoresCatalogo.xsql" method="post">
          <input type="hidden" name="IDPRODUCTOESTANDAR" value="{Mantenimiento/PROVEEDORES/PROVEEDORACTUAL/IDPRODUCTOESTANDAR}"/>
          <input type="hidden" name="IDCENTRO" value="{Mantenimiento/PROVEEDORES/PROVEEDORACTUAL/CEN_ID}"/>
          <input type="hidden" name="ACCION"/>
          <input type="hidden" name="IDNUEVOPROVEEDOR"/>
          <input type="hidden" name="TIPOPROVEEDOR" value="{Mantenimiento/PROVEEDORES/PROVEEDORACTUAL/TIPOPROVEEDOR}"/>
          
          
          
          <!--  CAMPOS QUE FORMAN PARTE LA CLAVE Y QUE SON MODIFICABLES   -->
          
          
          <input type="hidden" name="IDPROVEEDORPRODUCTO" value="{Mantenimiento/PROVEEDORES/PROVEEDORACTUAL/IDPROVEEDORPRODUCTO}"/>
          <input type="hidden" name="IDPROVEEDORANTERIOR" value="{Mantenimiento/PROVEEDORES/PROVEEDORACTUAL/PROVEEDORES/field[@name='IDPROVEEDOR']/@current}"/>
          <input type="hidden" name="REFERENCIAANTERIOR"  value="{Mantenimiento/PROVEEDORES/PROVEEDORACTUAL/REFERENCIAPRODUCTO}"/>
          
      
          <table class="grandeInicio">
           		<thead>
                    <tr class="tituloTabla">
                      <th colspan="9">Mantenimiento de Proveedores del Catálogo Privado </th>
                    </tr>
                       <tr class="titulos">
                         <td class="dos">&nbsp;</td>
                         <td class="veinte">Proveedor</td>
                         <td>Tipo</td>
                         <td>Ref.</td>
                         <td>Nombre</td>    
                         <td>Marca</td>    
                         <td>Ud. básica</td>
                         <td>Precio<br/>Ud. básica</td>
                         <td>Ud. lote</td>
                       </tr>
                      </thead>
                      <tbody>
                     <xsl:choose>
                       <xsl:when test="Mantenimiento/PROVEEDORES/PROVEEDORESADSCRITOS/PROVEEDOR">
                         <xsl:for-each select="Mantenimiento/PROVEEDORES/PROVEEDORESADSCRITOS/PROVEEDOR">
                                 <tr>
                                   <td>
                                   <a href="javascript:BorrarProveedor('{IDPROVEEDORPRODUCTO}',0,'BORRARPROVEEDOR');">
                                   	<img src="http://www.newco.dev.br/images/2017/trash.png" alt="Eliminar" />
                                   </a>
	                           </td>
	                           <td>
                                     &nbsp;&nbsp;
                                     <a href="javascript:ModificarProveedor('{IDPROVEEDORPRODUCTO}','MODIFICARPROVEEDOR');">
                                       <xsl:value-of select="PROV_NOMBRE"/>
                                     </a>
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
                               <xsl:value-of select="MARCA"/>
                             </td>
                             <td>
                               <xsl:value-of select="UNIDADBASICA"/>
                             </td> 
                             <td>
                               <xsl:value-of select="PRECIOUNIDADBASICA"/>
                             </td> 
                             <td>
                               <xsl:value-of select="UNIDADESLOTE"/>
                             </td>
                           </tr>
                         </xsl:for-each>   
                       </xsl:when>
                       <xsl:otherwise>
                           <tr>
                             <td colspan="11">
                               Ningún Proveedor
                             </td>   
                           </tr>
                       </xsl:otherwise>
                     </xsl:choose>
                    </tbody>
                   </table> 
                   
           <!--fin tabla arriba-->
                   
           <table class="infoTable">
                <tr class="titleTabla">
                    <th colspan="4">Datos</th>
                </tr>
                	<tr>
                        <td class="labelRight veinte">
                          Referencia Producto Estandar:
                        </td>
                        <td class="datosLeft" colspan="3">
                          <b><xsl:value-of select="Mantenimiento/PROVEEDORES/PRODUCTOESTANDAR/REFERENCIAPRODUCTOESTANDAR"/></b>
                        </td>
                      </tr>
                      <tr>
                        <td class="labelRight veinte">
                          Nombre Producto Estandar:
                        </td>
                        <td class="datosLeft" colspan="3">
                          <strong><xsl:value-of select="Mantenimiento/PROVEEDORES/PRODUCTOESTANDAR/NOMBREPRODUCTOESTANDAR"/></strong>
                        </td>
                      </tr>
                      <tr>
                        <td class="labelRight veinte">
                          Descripción Producto Estandar:
                        </td>
                        <td class="datosLeft" colspan="3">
                         <xsl:value-of select="Mantenimiento/PROVEEDORES/PRODUCTOESTANDAR/DESCRIPCIONPRODUCTOESTANDAR"/>
                        </td>
                      </tr>
                      <tr class="blanco">
                        <td class="labelRight veinte">
                          Proveedor:<span class="camposObligatorios">*</span>
                        </td>
                        <td class="datosLeft" colspan="3">
                          <xsl:call-template name="field_funcion">
    	                    <xsl:with-param name="path" select="Mantenimiento/PROVEEDORES/PROVEEDORACTUAL/PROVEEDORES/field[@name='IDPROVEEDOR']"/>
    	                    <xsl:with-param name="IDAct" select="Mantenimiento/PROVEEDORES/PROVEEDORACTUAL/PROVEEDORES/field[@name='IDPROVEEDOR']/@current"/>
    	                    <xsl:with-param name="cambio">validarTipoProveedorDespl(document.forms[0], this, 'NOMBREPRROVEEDORNOAFILIADO');</xsl:with-param>
    	                  </xsl:call-template>
    	                  &nbsp;
    	                  <input type="text" name="NOMBREPRROVEEDORNOAFILIADO" size="40" maxlength="100" onBlur="validarTipoProveedorText(document.forms[0], this, 'IDPROVEEDOR');">
    	                    <xsl:if test="Mantenimiento/PROVEEDORES/PROVEEDORACTUAL/PROVEEDORES/field[@name='IDPROVEEDOR']/@current=''">
    	                      <xsl:attribute name="value"><xsl:value-of select="Mantenimiento/PROVEEDORES/PROVEEDORACTUAL/NOMBREPROVEEDOR"/></xsl:attribute>
    	                    </xsl:if>
    	                  </input>
                        </td>
                      </tr>
                      <tr>
                        <td class="labelRight veinte">
                          Tipo de proveedor:
                        </td>
                        <td class="datosLeft" colspan="3">
                          <table>
                            <tr>
                              <td>
                                <input type="checkbox" name="CHK_TIPOPROVEEDOR_IMP" onClick="validarChecks(document.forms[0], this.name);">
                                  <xsl:if test="Mantenimiento/PROVEEDORES/PROVEEDORACTUAL/TIPOPROVEEDOR='I'">
                                    <xsl:attribute name="checked">checked</xsl:attribute>
                                  </xsl:if>
                                </input>
                              </td>
                              <td>
                                Importador
                              </td>
                              <td>
                                <input type="checkbox" name="CHK_TIPOPROVEEDOR_FAB" onClick="validarChecks(document.forms[0], this.name);">
                                  <xsl:if test="Mantenimiento/PROVEEDORES/PROVEEDORACTUAL/TIPOPROVEEDOR='F'">

                                    <xsl:attribute name="checked">checked</xsl:attribute>
                                  </xsl:if>
                                </input>
                              </td>
                              <td>
                                Fabricante
                              </td>
                              <td>
                                <input type="checkbox" name="CHK_TIPOPROVEEDOR_DIS" onClick="validarChecks(document.forms[0], this.name);">
                                  <xsl:if test="Mantenimiento/PROVEEDORES/PROVEEDORACTUAL/TIPOPROVEEDOR='D'">
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
                        <td class="labelRight veinte">
                          Referencia del producto:
                        </td>
                        <td class="datosLeft trenta">
                                <input type="text" name="REFERENCIAPRODUCTO" size="30" maxlength="100" value="{Mantenimiento/PROVEEDORES/PROVEEDORACTUAL/REFERENCIAPRODUCTO}"/>
                              <xsl:text>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</xsl:text>
                              <xsl:call-template name="botonPersonalizado">
	                          <xsl:with-param name="funcion">ComprobarProducto(document.forms[0].elements['IDPROVEEDOR'],document.forms[0].elements['REFERENCIAPRODUCTO']);</xsl:with-param>
	                          <xsl:with-param name="label">Verificar</xsl:with-param>
	                          <xsl:with-param name="ancho">80px</xsl:with-param>
	                          <xsl:with-param name="status">Verificar Producto</xsl:with-param>
	                        </xsl:call-template>
                        </td>
                        <td class="labelRight veinte">
                          Nombre del producto:
                        </td>
                        <td class="datosLeft">
                          <xsl:choose>
                            <xsl:when test="Mantenimiento/PROVEEDORES/PROVEEDORACTUAL/NOMBREPRODUCTO=''">
                              <input type="text" name="NOMBREPRODUCTO" size="30" maxlength="300" value="{Mantenimiento/PROVEEDORES/PRODUCTOESTANDAR/NOMBREPRODUCTOESTANDAR}"/>
                            </xsl:when>
                            <xsl:otherwise>
                              <input type="text" name="NOMBREPRODUCTO" size="30" maxlength="300" value="{Mantenimiento/PROVEEDORES/PROVEEDORACTUAL/NOMBREPRODUCTO}"/>
                            </xsl:otherwise>
                          </xsl:choose>
                        </td>
                      </tr>
                      <tr>
                        <td class="labelRight veinte">
                          Ud. básica:
                        </td>
                        <td class="datosLeft">
                          <input type="text" name="UNIDADBASICA" size="30" maxlength="100" value="{Mantenimiento/PROVEEDORES/PROVEEDORACTUAL/UNIDADBASICA}"/>
                        </td>
                        <td class="labelRight veinte">
                          Ud. lote:
                        </td>
                        <td class="datosLeft">
                          <input type="text" name="UNIDADESLOTE" size="30" maxlength="100" value="{Mantenimiento/PROVEEDORES/PROVEEDORACTUAL/UNIDADESLOTE}"/>
                        </td>
                      </tr>
                      <tr>
                        <td class="labelRight veinte">
                          Precio ud. básica:
                        </td>
                        <td class="datosLeft">
                          <input type="text" name="PRECIOUNIDADBASICA" size="30" maxlength="9" value="{Mantenimiento/PROVEEDORES/PROVEEDORACTUAL/PRECIOUNIDADBASICA}" onBlur="ValidarNumero(this,4);"/>
                        </td>
                        <td class="labelRight veinte">
                          Marca:
                        </td>
                        <td class="datosLeft">
                          <input type="text" name="MARCA" size="30" maxlength="100" value="{Mantenimiento/PROVEEDORES/PROVEEDORACTUAL/MARCA}"/>
                        </td>
                      </tr>
                      <tr>
                        <td class="labelRight">
                          Comentarios
                        </td>
                      	<td colspan="3" class="datosLeft">
                          <textarea name="COMENTARIOS" cols="80" rows="3"><xsl:value-of select="Mantenimiento/PROVEEDORES/PROVEEDORACTUAL/COMENTARIOS"/></textarea>
                        </td>
                      </tr>
                      <tr>
                      <td colspan="2">Los campos marcados con (<span class="camposObligatorios">*</span>) son obligatorios.</td>
                       <td colspan="2">&nbsp;</td>
                      </tr>
                </table>
                <div class="divLeft">
                 <br /><br />
                	<div class="divLeft20">&nbsp;</div>
                    <div class="divLeft15nopa">
                          <xsl:call-template name="boton">
                            <xsl:with-param name="path" select="Mantenimiento/botones/button[@label='Cerrar']"/>
                          </xsl:call-template>
                    </div>
                    <div class="divLeft10">&nbsp;</div>
                          <xsl:choose>
                            <xsl:when test="Mantenimiento/ACCION='MODIFICARPROVEEDOR'"> 
                            <div class="divLeft15nopa">
                             <div class="boton">
                              	<a href="javascript:AnyadirProveedor('0','-1','NUEVOPROVEEDOR');">
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
                     <br /><br />
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
