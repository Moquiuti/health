<?xml version="1.0" encoding="iso-8859-1" ?>
<!--
	Mantenimiento de lugares de entrega
	Ultima revisión: 20ene20 15:28 LugaresEntrega_200120.js
-->
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
		<script type="text/javascript" src="http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/LugaresEntrega_200120.js"></script>

		<!--idioma-->
		<xsl:variable name="lang">
		<xsl:choose>
			<xsl:when test="/Mantenimiento/LANG"><xsl:value-of select="/Mantenimiento/LANG" /></xsl:when>
			<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>  
		</xsl:variable>
		<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>      	        <!--idioma fin-->
		<script type="text/javascript">
			var referenciaDuplicada	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='referencia_lugar_duplicada']/node()"/>';
			var	msgBorrarPorDefecto='Va a borrar el lugar de entrega por defecto. Antes de enviar el formulario debe seleccionar el nuevo lugar de entrega. Gracias'
			var	msgBorrarSinPorDefecto='El lugar de entrega por defecto seleccionado no es válido.';
			var	msgConfirmarBorrado='¿Eliminar el lugar de entega?';     
			var	msgSinPorDefecto='No hay ningún lugar de entrega por defecto seleccionado. ¿Desea utilizar el que esta creando/editando como lugar de entrega por defecto?';     
			var	msgSinPorDefectoError='No hay ningún lugar de entrega por defecto seleccionado. Por favor, seleccione uno antes de continuar.';
		</script>
		<title><xsl:value-of select="/Mantenimiento/MANTENIMIENTOLUGARESENTREGA/LUGARESENTREGA/CENTRO"/>:&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='mantenimiento_lugares_entrega']/node()"/></title>
      </head>
      <body onload="javascript:Inicializa();">
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


		<!--	Titulo de la página		-->
		<div class="ZonaTituloPagina">
			<p class="Path"><xsl:value-of select="document($doc)/translation/texts/item[@name='Inicio']/node()"/>&nbsp;/&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='centro']/node()"/>&nbsp;/&nbsp;<span class="FinPath"><xsl:value-of select="document($doc)/translation/texts/item[@name='mantenimiento_lugares_entrega']/node()"/>&nbsp;</span></p>
			<p class="TituloPagina">
				<xsl:value-of select="/Mantenimiento/MANTENIMIENTOLUGARESENTREGA/LUGARESENTREGA/CENTRO"/>
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


      <!--
            <h1 class="TitlePage"><xsl:value-of select="document($doc)/translation/texts/item[@name='mantenimiento_lugares_entrega']/node()"/></h1>
          -->
        <form name="form1" id="form1" action="LugaresEntrega.xsql" method="post">
          <input type="hidden" name="CEN_ID" value="{Mantenimiento/MANTENIMIENTOLUGARESENTREGA/LUGARESENTREGA/IDCENTRO}"/>
          <input type="hidden" name="LUGAR_ID" value="{Mantenimiento/MANTENIMIENTOLUGARESENTREGA/LUGARENTREGA_EDITAR/ID}"/>
          <input type="hidden" name="IDPORDEFECTO"/>
          <input type="hidden" name="ACCION"/>
   		<div class="divLeft">
        
        <table class="buscador">
        
          <xsl:choose>
        <!--<xsl:when test="(Mantenimiento/MANTENIMIENTOLUGARESENTREGA/LUGARESENTREGA/LUGARENTREGA) and (Mantenimiento/MANTENIMIENTOLUGARESENTREGA/LUGARENTREGA/ACCION!='EDITAR') or (count(Mantenimiento/MANTENIMIENTOLUGARESENTREGA/LUGARESENTREGA/LUGARENTREGA)>1 and Mantenimiento/MANTENIMIENTOLUGARESENTREGA/LUGARENTREGA/ACCION='EDITAR')">-->
        <xsl:when test="Mantenimiento/MANTENIMIENTOLUGARESENTREGA/LUGARESENTREGA/LUGARENTREGA">
          <tr class="subTituloTabla">
            <td class="cuatro">
              <xsl:value-of select="document($doc)/translation/texts/item[@name='eliminar']/node()"/>
            </td>
             <td>
              <xsl:value-of select="document($doc)/translation/texts/item[@name='centro_entrega']/node()"/>
            </td>
            <td class="diez">
              <xsl:value-of select="document($doc)/translation/texts/item[@name='referencia']/node()"/>
            </td>
            <td class="diez">
              <xsl:value-of select="document($doc)/translation/texts/item[@name='referencia_ERP']/node()"/>
            </td>
            <td class="veinte">
              <xsl:value-of select="document($doc)/translation/texts/item[@name='nombre']/node()"/>
            </td>
            <td>
              <xsl:value-of select="document($doc)/translation/texts/item[@name='direccion']/node()"/>
            </td>
            <td class="diez">
              <xsl:value-of select="document($doc)/translation/texts/item[@name='poblacion']/node()"/>
            </td>
            <td class="cuatro">
              <xsl:value-of select="document($doc)/translation/texts/item[@name='codigo_postal']/node()"/>
            </td>
            <td class="ocho">
              <xsl:value-of select="document($doc)/translation/texts/item[@name='provincia']/node()"/>
            </td>
            <td class="uno">
              <xsl:value-of select="document($doc)/translation/texts/item[@name='por_defecto']/node()"/><br/>
			  <!--<xsl:value-of select="document($doc)/translation/texts/item[@name='material_sanitario']/node()"/>-->
            </td>
            <td class="uno">
              <!--<xsl:value-of select="document($doc)/translation/texts/item[@name='por_defecto']/node()"/><br/>
			  <xsl:value-of select="document($doc)/translation/texts/item[@name='farmacia']/node()"/>-->
            </td>
          </tr>
      
		<xsl:for-each select="Mantenimiento/MANTENIMIENTOLUGARESENTREGA/LUGARESENTREGA/LUGARENTREGA">
      	<tr>
			<td>
				<xsl:if test="PERMITIR_BORRAR">
				<a href="javascript:BorrarLugarEntrega('{IDCENTRO}','{ID}','BORRAR');" style="text-decoration:none;">
    				<img src="http://www.newco.dev.br/images/2017/trash.png" alt="eliminar" />
				</a>
				</xsl:if>&nbsp;
			</td>
			<td align="left">
				<xsl:value-of select="CENTRO_ENTREGA"/>
			</td>
			<td align="left">
				<a> 
					<xsl:attribute name="href">javascript:EditarLugarEntrega('<xsl:value-of select="IDCENTRO"/>','<xsl:value-of select="ID"/>');</xsl:attribute>
					<xsl:value-of select="REFERENCIA"/>
					<input type="hidden" name="REF_{ID}" id="REF_{ID}" value="{REFERENCIA}" />
				</a>
			</td>
			<td align="left">
				<xsl:value-of select="REFERENCIAERP"/>
			</td>
			<td align="left">
				<a> 
					<xsl:attribute name="href">javascript:EditarLugarEntrega('<xsl:value-of select="IDCENTRO"/>','<xsl:value-of select="ID"/>');</xsl:attribute>
					<xsl:value-of select="NOMBRE"/>
				</a>
			</td>
			<td align="left">
				<xsl:value-of select="DIRECCION"/>
			</td>
			<td align="left">
				<xsl:copy-of select="POBLACION"/>
			</td>
			<td>
				<xsl:value-of select="CPOSTAL"/>
			</td>
			<td align="left">
				<xsl:value-of select="PROVINCIA"/>
			</td>
			<td>
			 <input type="checkbox" name="CHECKPORDEFECTO_{ID}" onClick="comprobarCheck(this.form, this, 'CHECKPORDEFECTO_');">
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
			<td>
				&nbsp;
			<!--	14jun18	Copiaremos por defecto 
             <input type="checkbox" name="CHECKPORDEFECTOFARMACIA_{ID}" onClick="comprobarCheck(this.form, this, 'CHECKPORDEFECTOFARMACIA_');">
               <xsl:choose>
                  <xsl:when test="PORDEFECTO_FARMACIA='S'">
                    <xsl:attribute name="checked">checked</xsl:attribute>
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:attribute name="unchecked">unchecked</xsl:attribute>
                  </xsl:otherwise>
                </xsl:choose>
            </input>
			-->
          </td>
          </tr>
         <!-- </xsl:if>  -->
        </xsl:for-each>
        </xsl:when>
       </xsl:choose>
         <tr class="sinLinea">
            <td colspan="6" class="labelRight">
            <xsl:value-of select="document($doc)/translation/texts/item[@name='puede_anadir_lugares_entrega_defecto']/node()"/>:&nbsp;
            </td>
            <td colspan="3"> 
                <!--<div class="botonLargo">-->
                	<a class="btnDestacado" href="javascript:ActualizarDatos(document.forms[0],'CAMBIARPORDEFECTO');">
                    	<xsl:value-of select="document($doc)/translation/texts/item[@name='guardar_cambios_lugares']/node()"/>
                    </a>
                <!--</div>-->
            </td>
            <td colspan="2">
            	&nbsp;
            </td>
          </tr>
    </table><!--fin datos centro-->
    <br/>
    <br/>
    <br/>
    <table class="buscador" style="border:1px;">
          <tr class="subTituloTabla">
              <th colspan="7">
                <xsl:value-of select="document($doc)/translation/texts/item[@name='anadir_modificar_lugar_entrega']/node()"/>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<xsl:choose>
					<xsl:when test="not(/Mantenimiento/MANTENIMIENTOLUGARESENTREGA/LUGARENTREGA_EDITAR)">
                    	<a class="btnDestacado" href="javascript:ActualizarDatos(document.forms[0],'NUEVO');">
                    	<xsl:value-of select="document($doc)/translation/texts/item[@name='nuevo']/node()"/>
                   		</a>&nbsp;
					</xsl:when>
					<xsl:otherwise>
                    	<a class="btnDestacado" href="javascript:ActualizarDatos(document.forms[0],'GUARDAR');">
                    	<xsl:value-of select="document($doc)/translation/texts/item[@name='guardar']/node()"/>
                    	</a>
                    	<a class="btnDestacado" href="javascript:ActualizarDatos(document.forms[0],'NUEVO');">
                    	<xsl:value-of select="document($doc)/translation/texts/item[@name='nuevo']/node()"/>
                   		</a>&nbsp;
					</xsl:otherwise>
					</xsl:choose>
              </th>
          </tr>
          <tr class="sinLinea">
				<td class="labelRight trenta">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='Centro_entrega']/node()"/>:&nbsp;
				</td>
				<td class="datosLeft veinte">
					<xsl:call-template name="desplegable">
						<xsl:with-param name="path" select="/Mantenimiento/MANTENIMIENTOLUGARESENTREGA/LUGARESENTREGA/LISTACENTROS/field" />
						<xsl:with-param name="onChange">javascript:CentroSeleccionado();</xsl:with-param>
					</xsl:call-template> 
				</td>  
				<td class="labelRight diez">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='referencia']/node()"/>:&nbsp;
				</td>
				<td class="datosLeft cuarenta">
					<input type="text" name="NUEVAREFERENCIA" size="30" maxlength="100" value="{/Mantenimiento/MANTENIMIENTOLUGARESENTREGA/LUGARENTREGA_EDITAR/REFERENCIA}"/>
				</td>  
          </tr>
          <tr class="sinLinea">
           		  <td class="labelRight">
                    <xsl:value-of select="document($doc)/translation/texts/item[@name='referencia_ERP']/node()"/>:&nbsp;
                  </td>
                  <td class="datosLeft">
                    <input type="text" name="NUEVAREFERENCIAERP" size="30" maxlength="100" value="{/Mantenimiento/MANTENIMIENTOLUGARESENTREGA/LUGARENTREGA_EDITAR/REFERENCIAERP}"/>
                  </td>  
                  <td class="labelRight">
                    <xsl:value-of select="document($doc)/translation/texts/item[@name='direccion']/node()"/>:&nbsp;
                  </td>
                  <td class="datosLeft">
                    <input type="text" class="grande" maxlength="100" size="50" name="NUEVADIRECCION" value="{/Mantenimiento/MANTENIMIENTOLUGARESENTREGA/LUGARENTREGA_EDITAR/DIRECCION}"/>
                  </td>
            </tr>
            <tr class="sinLinea">
                  <td class="labelRight">
                    <xsl:value-of select="document($doc)/translation/texts/item[@name='nombre']/node()"/>:&nbsp;
                  </td>
                  <td class="datosLeft">
                    <input type="text" name="NUEVONOMBRE" size="30" maxlength="100" value="{/Mantenimiento/MANTENIMIENTOLUGARESENTREGA/LUGARENTREGA_EDITAR/NOMBRE}"/>
                  </td>
                   <td class="labelRight">
                    <xsl:value-of select="document($doc)/translation/texts/item[@name='codigo_postal']/node()"/>:&nbsp;
                  </td>
                  <td class="datosLeft">
                    <input type="text" name="NUEVOCPOSTAL" size="10" maxlength="10" value="{/Mantenimiento/MANTENIMIENTOLUGARESENTREGA/LUGARENTREGA_EDITAR/CPOSTAL}"/>
                  </td>
                  
                </tr>
               
                <tr class="sinLinea">
                  <td class="labelRight">
                    <xsl:value-of select="document($doc)/translation/texts/item[@name='por_defecto']/node()"/><!--&nbsp;(<xsl:value-of select="document($doc)/translation/texts/item[@name='material_sanitario']/node()"/>)-->:&nbsp;
                  </td>
                  <td class="datosLeft">
                    <input type="hidden" name="NUEVOPORDEFECTO"/>
                    <input type="checkbox" class="muypeq" name="CHECKNUEVOPORDEFECTO" onClick="comprobarCheck(this.form, this, 'CHECKPORDEFECTO_' );">
                      <xsl:choose>
                        <xsl:when test="/Mantenimiento/MANTENIMIENTOLUGARESENTREGA/LUGARENTREGA_EDITAR/PORDEFECTO='S'">
                          <xsl:attribute name="checked">checked</xsl:attribute>
                        </xsl:when>
                        <xsl:otherwise>
                          <xsl:attribute name="unchecked">unchecked</xsl:attribute>
                        </xsl:otherwise>
                      </xsl:choose>
                    </input>
                  </td>
                  <td class="labelRight">
                    <xsl:value-of select="document($doc)/translation/texts/item[@name='poblacion']/node()"/>:&nbsp;
                  </td>
                  <td class="datosLeft">
                    <input type="text" name="NUEVAPOBLACION" size="40" maxlength="200" value="{/Mantenimiento/MANTENIMIENTOLUGARESENTREGA/LUGARENTREGA_EDITAR/POBLACION}"/>
                  </td>
                </tr> 
                <tr class="sinLinea">
                  <td class="labelRight">
                    <!--<xsl:value-of select="document($doc)/translation/texts/item[@name='por_defecto']/node()"/>(<xsl:value-of select="document($doc)/translation/texts/item[@name='farmacia']/node()"/>):&nbsp;-->
                  </td>
                  <td class="datosLeft">
				  <!--
                    <input type="hidden" name="NUEVOPORDEFECTOFARMACIA"/>
                    <input type="checkbox" class="muypeq" name="CHECKNUEVOPORDEFECTOFARMACIA" onClick="comprobarCheck(this.form, this, 'CHECKPORDEFECTOFARMACIA_');">
                      <xsl:choose>
                        <xsl:when test="/Mantenimiento/MANTENIMIENTOLUGARESENTREGA/LUGARENTREGA_EDITAR/PORDEFECTOFARMACIA='S'">
                          <xsl:attribute name="checked">checked</xsl:attribute>
                        </xsl:when>
                        <xsl:otherwise>
                          <xsl:attribute name="unchecked">unchecked</xsl:attribute>
                        </xsl:otherwise>
                      </xsl:choose>
                    </input>
					-->
                  </td>
                  <td class="labelRight">
                    <xsl:value-of select="document($doc)/translation/texts/item[@name='provincia']/node()"/>:&nbsp;
                  </td>
                  <td class="datosLeft">
                    <xsl:call-template name="field_funcion">
    	              <xsl:with-param name="path" select="//field[@name='NUEVAPROVINCIA']"/>
    	              <xsl:with-param name="IDAct" select="/Mantenimiento/MANTENIMIENTOLUGARESENTREGA/LUGARENTREGA_EDITAR/PROVINCIA"/>
    	            </xsl:call-template>
                  </td>
                  
                </tr>
        </table>
 
              <!--botones  
       <br /><br />
              <table>
                <tr class="sinLinea">
                        <td class="veinte">&nbsp;</td>
      					<td class="veinte">
                            <!- -<div class="boton">- ->
                            	<a class="btnNormal" href="javascript:CerrarVentana();">
                            	<xsl:value-of select="document($doc)/translation/texts/item[@name='cerrar']/node()"/>
                                </a>
                           <!- - </div>- ->
       					</td>
                        <td class="dies">&nbsp;</td>
                        <td class="veinte">
                       <!- - <div class="boton">- ->
                            	<a class="btnDestacado" href="javascript:ActualizarDatos(document.forms[0],'NUEVO');">
                            	<xsl:value-of select="document($doc)/translation/texts/item[@name='nuevo']/node()"/>
                                </a>
                       <!- - </div>- ->
                        </td>
                        <td class="dies">&nbsp;</td>
                        <td class="veinte">
                        <!- - <div class="boton">- ->
                            	<a class="btnDestacado" href="javascript:ActualizarDatos(document.forms[0],'GUARDAR');">
                            	<xsl:value-of select="document($doc)/translation/texts/item[@name='guardar']/node()"/>
                                </a>
                       <!- -     </div>- ->
                        </td>
                        <td>&nbsp;</td>
              </tr>
          </table>
              -->          
           </div>
        </form>
        </xsl:otherwise>
        </xsl:choose>
      </body>
    </html>
  </xsl:template>

</xsl:stylesheet>
