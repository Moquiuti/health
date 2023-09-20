<?xml version="1.0" encoding="iso-8859-1" ?>
<!--
	Zona de productos en "Enviar Pedidos". Estilos 2022.
	Ultima revision: ET 10mar22 19:45
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:import href = "http://www.newco.dev.br/General/General.xsl" />
  
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="lang" select="@lang"/>  
<xsl:template match="/">

	<!--	Todos los documentos HTML deben empezar con esto	-->
	<xsl:text disable-output-escaping='yes'>&lt;!doctype html></xsl:text>

    <html>
      <head>
     
		<!--style-->
		<xsl:call-template name="estiloIndip"/>
		<!--fin de style-->  	

		<script src="http://www.newco.dev.br/General/jquery-3.6.0.js"></script>	
		<script type="text/javascript" src="http://www.newco.dev.br/General/basic2022_010822.js"></script>
		<script type="text/javascript" src="http://www.newco.dev.br/Compras/NuevaMultioferta/ZonaProducto2022_031022.js"></script>
 		<script type="text/javascript">
		var maxVisibles='<xsl:value-of select="//ZonaProducto/PRODUCTOS/MAX_VISIBLES"/>';
	    var totalEnLaPlantilla='<xsl:value-of select="//ZonaProducto/PRODUCTOS/TOTAL_EN_LA_PLANTILLA"/>';
		var msgMuchosProductosEnLaPlantilla='El número de artículos ocultos es elevado, por lo que verlos todos puede tardar.\nDesea continuar? (puede hacer la misma modificación contactando directamente con MedicalVM)';
		</script>
		
      </head>
	<body class="areaizq">
      
	<!--idioma-->
	<xsl:variable name="lang">
	<xsl:value-of select="/ZonaProducto/LANG" />
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->
      
	<xsl:choose>
	<xsl:when test="//SESION_CADUCADA">
    	<xsl:apply-templates select="//SESION_CADUCADA"/>        
	</xsl:when>   
	<xsl:otherwise>
      <form name="productos">
 		<table class="areaizq fuentePeq" cellspacing="2px" cellpadding="2px">      
        <thead>
    	  <xsl:choose>
    	  <xsl:when test="ZonaProducto/PRODUCTOS/PRODUCTO">
        	  <tr>
        	   <th colspan="3">
        	   <xsl:choose>
        	   <xsl:when test="/ZonaProducto/PRODUCTOS/MOSTRAR_BOTON_OCULTOS or /ZonaProducto/PRODUCTOS/EDICION">
            	  <!--<strong>-->
            	 <a href="javascript:MostrarPlantilla('zonaPlantilla');"><xsl:value-of select="ZonaProducto/PRODUCTOS/TOTAL"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Productos']/node()"/>
            	  <xsl:if test="ZonaProducto/PRODUCTOS/OCULTOS">
                	<xsl:if test="ZonaProducto/PRODUCTOS/MOSTRAR_BOTON_OCULTOS">
                	/<xsl:value-of select="ZonaProducto/PRODUCTOS/OCULTOS"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='ocultos']/node()"/>
                	</xsl:if>
            	  </xsl:if></a><!--</strong>-->
        	   </xsl:when>
        	   <xsl:otherwise>
            	  <strong>
            	 <xsl:value-of select="ZonaProducto/PRODUCTOS/TOTAL"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Productos']/node()"/>
            	  <xsl:if test="ZonaProducto/PRODUCTOS/OCULTOS">
                	<xsl:if test="ZonaProducto/PRODUCTOS/MOSTRAR_BOTON_OCULTOS">
                	/<xsl:value-of select="ZonaProducto/PRODUCTOS/OCULTOS"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='ocultos']/node()"/>
                	</xsl:if>
            	  </xsl:if></strong>
        	   </xsl:otherwise>
        	   </xsl:choose>
            	</th>
            	</tr>
                       
		  </xsl:when>
          <xsl:otherwise>
          <tr>
		  <th colspan="4">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Productos']/node()"/>&nbsp; </th>
		  </tr>
          </xsl:otherwise>
          </xsl:choose>
      </thead>
	  <tbody class="corpo_tabela">
	<xsl:choose>
	<xsl:when test="ZonaProducto/PRODUCTOS/PRODUCTO">
    	<xsl:choose>
        	<xsl:when test="ZonaProducto/PRODUCTOS/SIN_PRODUCTOS_VISIBLES">
				<xsl:if test="//ZonaProducto/PRODUCTOS/EDICION">
          			<tr>
						<th colspan="4"><xsl:value-of select="document($doc)/translation/texts/item[@name='todos_productos_ocultos']/node()"/></th>
		  			</tr>
				</xsl:if>
		  		<input type="hidden" name="PRODUCTOS" value="-1"/>
			</xsl:when>
		<xsl:otherwise>
	
          	<xsl:for-each select="ZonaProducto/PRODUCTOS/PRODUCTO">
           		<!-- procesamos los visibles -->
				<xsl:choose>
				<xsl:when test="OCULTAR!='S'">
				<!-- solo mostramos hasta el limite, los demas aparecen como ocultos -->
				<xsl:choose>
				<xsl:when test="number(//ZonaProducto/PRODUCTOS/MAX_VISIBLES)=number(0) or number(VISIBLE/@Numero)&lt;=number(//ZonaProducto/PRODUCTOS/MAX_VISIBLES)">
					<!-- en edicion, mostramos el boton de borrado -->
					<xsl:choose>
					<xsl:when test="//ZonaProducto/PRODUCTOS/EDICION">
						<tr class="conhover">
							<td class="textLeft" style="color:#3d5d95;">
								<!-- Link a la ficha del producto	-->
								<xsl:value-of select="NOMBRE"/><input type="hidden" name="IDPRODUCTO_{../ID}" value="{../ID}"/>
							</td>
							<td class="w1px" valign="top">
        						<a href="javascript:BorrarProducto('BORRARPRODUCTO','{ID}');">
        							<img src="http://www.newco.dev.br/images/2017/trash.png"/>
        						</a>
							</td>
						</tr>
					</xsl:when>
					<!-- solo lectura, info minima -->
					<xsl:otherwise>
						<tr class="conhover">
						<td class="textLeft" style="color:#3d5d95;">
							<!-- Link a la ficha del producto	-->
							<xsl:value-of select="NOMBRE"/><input type="hidden" name="IDPRODUCTO_{../ID}" value="{../ID}"/>
						</td>
						<td class="w1px">
        					<xsl:if test="../MOSTRAR_BOTON_OCULTOS">
            					<a href="javascript:BorrarProducto('OCULTARPRODUCTO','{ID}');">
            					<img src="http://www.newco.dev.br/images/ocultar.gif" alt="Boton ocultar" style="float:right"/>
            					</a><br/><br/>
    					  </xsl:if>
						</td>
            			<!--<tr id="lineGris"></tr>-->
						</tr>
					</xsl:otherwise>
					</xsl:choose>
					</xsl:when>
					<!-- de los visibles, los que no hemos de mostrar incluimos un hidden -->
					<xsl:otherwise>
					<input type="hidden" name="IDPRODUCTO_{ID}" value="{ID}"/>
					</xsl:otherwise>
					</xsl:choose>
					</xsl:when>
					<!-- los que no se muestran -->
					<xsl:otherwise>
					<input type="hidden" name="IDPRODUCTO_{ID}" value="{ID}"/>
					</xsl:otherwise>
					</xsl:choose>
		   </xsl:for-each>
		  			<!-- 
		  				guardamos un valor tipo candena diferente de -1 ya que existen productos
		  				faltaria devolver el contador con los productos que contiene la plantilla actual
		  			-->
		  			<input type="hidden" name="PRODUCTOS" value="CONPRODUCTOS"/>
		  	  </xsl:otherwise>
		  	</xsl:choose>	
            <!--fin listado productos-->



			</xsl:when>
			<xsl:otherwise>
				<tr><td colspan="3" class="textCenter"><xsl:value-of select="document($doc)/translation/texts/item[@name='plantilla_vacia']/node()"/></td></tr>
				<input type="hidden" name="PRODUCTOS" value="-1"/>
			</xsl:otherwise>			
			</xsl:choose>
            <tfoot>
            <tr>
                <td class="footLeft">&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td class="footRight">&nbsp;</td>
            </tr>
            </tfoot>
		</tbody>
		</table>
		<br/>
		<br/>
		<br/>
		<br/>
		<br/>
		<br/>
		<br/>
		</form>
		<form name="envio">
		<input type="hidden" name="ACCION" value="{ZonaProducto/ACCION}"/>
		<input type="hidden" name="IDCARPETA" value="{ZonaProducto/IDCARPETA}"/>
		<input type="hidden" name="IDPLANTILLA"  value="{ZonaProducto/IDPLANTILLA}"/>
		<input type="hidden" name="IDPRODUCTO"  value="{ZonaProducto/IDPRODUCTO}"/>
		<input type="hidden" name="FECHA"/>
		</form>
		</xsl:otherwise>
		</xsl:choose>
	</body>      
</html>   
 </xsl:template>


</xsl:stylesheet>
