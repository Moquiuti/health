<?xml version="1.0" encoding="iso-8859-1" ?>
<!--
	Mantenimiento de centros de consumo. Nuevo disenno 2022.
	Ultima revisión: ET 9mar23 09:00  CentrosConsumo2022_190422.js
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

	<script src="http://www.newco.dev.br/General/jquery-3.6.0.js"></script>	
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic2022_010822.js"></script>
    <!--<script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>-->
	<script type="text/javascript" src="http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/CentrosConsumo2022_190422.js"></script>
	 
	<xsl:text disable-output-escaping="yes"><![CDATA[
    <script type="text/javascript">
    <!--
        msgBorrarPorDefecto='Va a borrar el centro de entrega por defecto. Antes de enviar el formulario debe seleccionar el nuevo centro de consumo. Gracias'
        msgBorrarSinPorDefecto='El centro de consumo por defecto seleccionado no es válido.';
        msgConfirmarBorrado='¿Eliminar el centro de consumo?';  
        msgSinPorDefecto='No hay ningún centro de consumo por defecto seleccionado. ¿Desea utilizar el que esta creando/editando como centro de consumo por defecto?';     
        msgSinPorDefectoError='No hay ningún centro de consumo por defecto seleccionado. Por favor, seleccione uno antes de continuar.';
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


		<!--	Titulo de la página		-->
		<div class="ZonaTituloPagina">
			<p class="TituloPagina">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='mantenimiento_centros_consumo']/node()"/>
				<span class="CompletarTitulo">
                    <a class="btnNormal" href="javascript:chMantenCentro({/Mantenimiento/CENTROCONSUMO/IDCENTRO});">
                    <xsl:value-of select="document($doc)/translation/texts/item[@name='volver']/node()"/>
                    </a>
				</span>
			</p>
		</div>
		<br/>
		<br/>
		<br/>
		<br/>

        <form name="form1" action="CentrosConsumo2022.xsql" method="post">
          <input type="hidden" name="CEN_ID" value="{Mantenimiento/CEN_ID}"/>
          <input type="hidden" name="CENTROCONSUMO_ID" value="{Mantenimiento/CENTROCONSUMO/ID}"/>
          <input type="hidden" name="IDPORDEFECTO"/>
          <input type="hidden" name="ACCION"/>
          
   		<div class="divLeft">
		<div class="tabela tabela_redonda">
		<table cellspacing="6px" cellpadding="6px">
			<xsl:choose>
        	<xsl:when test="(Mantenimiento/CENTROSCONSUMO/CENTROCONSUMO) and (Mantenimiento/CENTROCONSUMO/ACCION!='EDITAR') or (count(Mantenimiento/CENTROSCONSUMO/CENTROCONSUMO)>1 and Mantenimiento/CENTROCONSUMO/ACCION='EDITAR')">
			<thead class="cabecalho_tabela">
        	  <tr class="subTituloTabla">
            	<th class="w1px">&nbsp;</th>
            	<th class="w100px textLeft">
            		<xsl:value-of select="document($doc)/translation/texts/item[@name='referencia']/node()"/>
            	</th>
            	<th class="textLeft">
            		<xsl:value-of select="document($doc)/translation/texts/item[@name='nombre']/node()"/>
            	</th>
            	<th class="w1px">
            		<xsl:value-of select="document($doc)/translation/texts/item[@name='por_defecto']/node()"/><br/>
            	</th>
            	<th class="w1px">
            		<xsl:value-of select="document($doc)/translation/texts/item[@name='eliminar']/node()"/>
            	</th>
        	  </tr>
			</thead>
			<!--	Cuerpo de la tabla	-->
			<tbody class="corpo_tabela">
      
    		  <xsl:for-each select="Mantenimiento/CENTROSCONSUMO/CENTROCONSUMO">
        		<xsl:if test="ID!=//Mantenimiento/CENTROCONSUMO/ID">
        		  <tr>
            		<td>&nbsp;</td>
	      			<td class="textLeft">
	      				<a> 
                			<xsl:attribute name="href">javascript:EditarCentroConsumo('<xsl:value-of select="IDCENTRO"/>','<xsl:value-of select="ID"/>');</xsl:attribute>
                			<xsl:value-of select="REFERENCIA"/>
              			</a>
	      			</td>
            		<td class="textLeft">
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
            		<td>
						<a href="javascript:BorrarCentroConsumo('{IDCENTRO}','{ID}','BORRAR');" style="text-decoration:none;"><img src="http://www.newco.dev.br/images/2017/trash.png" alt="eliminar" /></a>
            		</td>
        		  </tr>
        		  </xsl:if>  
        		</xsl:for-each>
			</tbody>
			<tfoot class="rodape_tabela">
				<tr><td colspan="5">&nbsp;</td></tr>
			</tfoot>
       		</xsl:when>
		    <xsl:otherwise>
        </xsl:otherwise>
       </xsl:choose>
   </table>
   </div>
   <br /><br />


    		<table cellspacing="6px" cellpadding="6px">
        		<tr class="fondoGris h40px">
            		<th colspan="7">
                		<xsl:value-of select="document($doc)/translation/texts/item[@name='mantenimiento_centros_consumo']/node()"/>
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                		<xsl:choose>
                		  <xsl:when test="Mantenimiento/CENTROCONSUMO/ACCION='EDITAR'">
								<a class="btnDestacado" href="javascript:ActualizarDatos(document.forms[0],'GUARDAR');"><xsl:value-of select="document($doc)/translation/texts/item[@name='guardar']/node()"/></a>
								&nbsp;
								<a class="btnDestacado" href="javascript:ActualizarDatos(document.forms[0],'BORRAR');"><xsl:value-of select="document($doc)/translation/texts/item[@name='eliminar']/node()"/></a>
                		  </xsl:when>
                		  <xsl:otherwise>
 								<a class="btnDestacado" href="javascript:ActualizarDatos(document.forms[0],'INSERTAR');"><xsl:value-of select="document($doc)/translation/texts/item[@name='nuevo']/node()"/></a>
                		  </xsl:otherwise>
                		</xsl:choose>
            		  </th>
        		  </tr>
        		  <tr>
						<td class="labelRight ">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='referencia']/node()"/>:&nbsp;
						</td>
						<td class="textLeft ">
							<input type="text" class="campopesquisa w200px" name="NUEVAREFERENCIA" maxlength="100" value="{/Mantenimiento/CENTROCONSUMO/REFERENCIA}"/>
						</td>  
        		  </tr>
        		  <tr>
						<td class="labelRight ">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='nombre']/node()"/>:&nbsp;
						</td>
						<td class="textLeft ">
							<input type="text" class="campopesquisa w300px" name="NUEVONOMBRE" maxlength="100" value="{/Mantenimiento/CENTROCONSUMO/NOMBRE}"/>
						</td>  
        		  </tr>
        		  <tr>
						<td class="labelRight ">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='por_defecto']/node()"/>:&nbsp;
						</td>
         				<td class="textLeft ">
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
          </table>
          </div>
        </form>
        </xsl:otherwise>
        </xsl:choose>
      </body>
    </html>
  </xsl:template>

</xsl:stylesheet>
