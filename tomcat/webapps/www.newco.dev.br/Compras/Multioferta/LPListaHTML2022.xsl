<?xml version="1.0" encoding="iso-8859-1"?>
<!--
	Lista de productos de una plantilla. Nuevo disenno 2022.
	ultima revisión: ET 15dic22 LPLista2022_180222.js
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
		<script type="text/javascript" src="http://www.newco.dev.br/General/divisas.js"></script>
		<script type="text/javascript" src="http://www.newco.dev.br/Compras/Multioferta/LPLista2022_180222.js"></script>


		<xsl:variable name="lang">
		<xsl:choose>
		<xsl:when test="/ListaProductos/LANG"><xsl:value-of select="/ListaProductos/LANG" /></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>  
		</xsl:variable>

		<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>        
		<title><xsl:value-of select="/ListaProductos/PLANTILLA/NOMBRE"/>:&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='productos_en_plantillas']/node()"/></title>
     
	</head>
	<body>
        <xsl:choose>
          <xsl:when test="ListaProductos/SESION_CADUCADA">
            <xsl:apply-templates select="//SESION_CADUCADA"/>          
          </xsl:when>
          <xsl:when test="ListaProductos/xsql-error">
            <xsl:apply-templates select="//xsql-error"/>          
          </xsl:when>
          <xsl:when test="ListaProductos/Status">
            <xsl:apply-templates select="ListaProductos/Status"/>                     
          </xsl:when>
          <xsl:otherwise>
	    <xsl:apply-templates select="ListaProductos/PLANTILLA"/>          
          </xsl:otherwise>
        </xsl:choose>                      
	</body>
</html>
</xsl:template>
  
<xsl:template match="LP_ACCION">
        <input type="hidden" name="ACCION">
        <xsl:attribute name="value"><xsl:value-of select="."/></xsl:attribute>
        </input>
</xsl:template>

<xsl:template match="PLANTILLA">

	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:choose>
			<xsl:when test="/ListaProductos/LANG"><xsl:value-of select="/ListaProductos/LANG" /></xsl:when>
			<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>  
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>        
	<!--idioma fin-->

	<xsl:variable name="accion"><xsl:value-of select="LP_ACCION"/></xsl:variable>
 
  <form action="LPLista2022.xsql" name="Cambios" method="POST">
 
		<input type="hidden" name="SES_ID">
			<xsl:attribute name="value">
				<xsl:value-of select="../SES_ID"/>
			</xsl:attribute>
		</input>
		<input type="hidden" name="PL_ID">
			<xsl:attribute name="value">
				<xsl:value-of select="/ListaProductos/PLANTILLA/ID"/>
			</xsl:attribute>
		</input>
		<input type="hidden" name="CAMBIOS" value=""/>
		<input type="hidden" name="IDEMPRESA" value="{/ListaProductos/PLANTILLA/IDEMPRESA}"/>

 	<!--	Titulo de la página		-->
	<div class="ZonaTituloPagina">
		<p class="TituloPagina">
			<xsl:value-of select="document($doc)/translation/texts/item[@name='plantilla']/node()"/>:&nbsp;
			<xsl:call-template name="desplegable">
			    <xsl:with-param name="path" select="/ListaProductos/PLANTILLA/PLANTILLAS/field"/>
			    <xsl:with-param name="claSel">w400px</xsl:with-param>
			    <xsl:with-param name="onChange">javascript:cbPlantillaChange();</xsl:with-param>
			</xsl:call-template>
			<xsl:if test="/ListaProductos/PLANTILLA/ADMIN">
				&nbsp;<span class="amarillo">PL_ID:&nbsp;<xsl:value-of select="/ListaProductos/PLANTILLA/ID"/></span>
			</xsl:if>
			<span class="CompletarTitulo500">
				<!--	botones	-->
				<a class="btnDestacado" href="javascript:Enviar()"><xsl:value-of select="document($doc)/translation/texts/item[@name='actualizar_los_cambios']/node()"/></a>
				<xsl:if test="not(/ListaProductos/PLANTILLA/DERECHOS_PRODUCTOS_POR_CENTRO)">
					&nbsp;
					<a class="btnNormal" href="javascript:DerechosUsuarioPlantilla();"><xsl:value-of select="document($doc)/translation/texts/item[@name='Derechos_usuarios']/node()"/></a>
				</xsl:if>
				&nbsp;
				<a class="btnNormal" href="javascript:window.print();"><xsl:value-of select="document($doc)/translation/texts/item[@name='imprimir']/node()"/></a>
			</span>
		</p>
	</div>
	<br/>
	<br/>
	</form>
 
 <div class="divLeft">
  <form name="Productos">
    <!--<table class="encuesta">
      <tr class="titulos">-->
	<div class="linha_separacao_cotacao_y"></div>
	<div class="tabela tabela_redonda">
		<table cellspacing="10px" cellpadding="10px">
		<thead class="cabecalho_tabela">
		<tr>
			<th class="w1px">&nbsp;</th>
			<xsl:if test="not(/ListaProductos/PLANTILLA/DERECHOS_POR_CENTRO)">
				<th class="w50px">
				   <a href="javascript:MarcarTodos(document.forms[1]);" style="text-decoration:underline;"><xsl:value-of select="document($doc)/translation/texts/item[@name='ocultar']/node()"/></a>
				</th>
			</xsl:if>
			<th class="w80px">&nbsp;</th>
			<th class="textLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/></th>
			<th class="w100px">
				<xsl:copy-of select="document($doc)/translation/texts/item[@name='ref_cliente']/node()"/>
			</th>
			<th class="w100px textLeft">
				<xsl:copy-of select="document($doc)/translation/texts/item[@name='referencia_proveedor_2line']/node()"/>
			</th>
			<th class="w100px textLeft">
			<!--<xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/> / --><xsl:value-of select="document($doc)/translation/texts/item[@name='marca']/node()"/>
			</th>   
			<th class="w100px">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='ud_basica']/node()"/>
			</th>
			<th class="w100px">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='ud_lote']/node()"/>
			</th>
			<th class="w100px">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='precio_ud_basica']/node()"/>
			</th>        
			<xsl:if test="not(/ListaProductos/PLANTILLA/DERECHOS_PRODUCTOS_POR_CENTRO)">
				<th class="w100px">&nbsp;</th>
			</xsl:if>
		</tr>
		</thead>
		<tbody class="corpo_tabela">
			<xsl:apply-templates select="./PRODUCTOS"/>
		</tbody>
		<tfoot class="rodape_tabela">
			<tr><td colspan="11">&nbsp;</td></tr>
		</tfoot>
   </table>
   </div>
  
 </form>
</div><!--fin de divleft tabla-->
 
</xsl:template>


<xsl:template match="PRODUCTOS">
    <xsl:variable name="lang">
    <xsl:choose>
        <xsl:when test="/ListaProductos/LANG"><xsl:value-of select="/ListaProductos/LANG" /></xsl:when>
        <xsl:otherwise>spanish</xsl:otherwise>
        </xsl:choose>  
    </xsl:variable>
    <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>        
	<input type="hidden" name="EDICION">
		<xsl:attribute name="value">
			<xsl:choose>
			  <xsl:when test="./EDICION!=''">EDICION</xsl:when>
			  <xsl:otherwise>NO</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>
	</input>

	<xsl:variable name="Eliminar_MouseOver"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='DB-EliminarPeq_mov' and @lang=$lang]" disable-output-escaping="yes"/></xsl:variable>
	<xsl:variable name="Eliminar_alt"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='PL-0560' and @lang=$lang]" disable-output-escaping="yes"/></xsl:variable>
	<xsl:variable name="Eliminar_MouseOut"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='DB-EliminarPeq' and @lang=$lang]" disable-output-escaping="yes"/></xsl:variable>

	<xsl:variable name="Editar_MouseOver"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='DB-EditarPeq_mov' and @lang=$lang]" disable-output-escaping="yes"/></xsl:variable>
	<xsl:variable name="Editar_alt"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='PL-0520' and @lang=$lang]" disable-output-escaping="yes"/></xsl:variable>
	<xsl:variable name="Editar_MouseOut"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='DB-EditarPeq' and @lang=$lang]" disable-output-escaping="yes"/></xsl:variable>

	<xsl:for-each select="PRODUCTO">
	<tr class="conhover">
		<!-- si no tiene permisos de escritura, no mostramos el boton -->
		<!--	Campo oculto con el ID del producto	-->
	    <input type="hidden" name="IDPRODUCTO">
              <xsl:attribute name="value">
	        <xsl:value-of select="ID"/>
	      </xsl:attribute>
	    </input> 
        <td class="color_status">&nbsp;</td>
		<xsl:if test="not(/ListaProductos/PLANTILLA/DERECHOS_POR_CENTRO)">
        	<td align="center">
        		<input type="checkbox" class="peq" name="CHK_OCULTAR_{ID}">
        		  <xsl:if test="OCULTAR='S'">
            		<xsl:attribute name="checked">checked</xsl:attribute>
        		  </xsl:if>
        		</input>
				<input type="hidden" name="Oculto_{ID}">
				<xsl:attribute name="value">
        		<xsl:choose>
          			<xsl:when test="OCULTAR='S'">S</xsl:when><xsl:otherwise>N</xsl:otherwise>
       			</xsl:choose>
				</xsl:attribute>
        		</input>
        	</td>
		</xsl:if>
        <td align="center" style="padding-right:4px;">
			<xsl:if test="../../ADMIN_CDC">
                <a class="btnDiscreto">
                <xsl:attribute name="href">javascript:FichaAdjudicacion('<xsl:value-of select="ID"/>');</xsl:attribute>
                <!--<img src="http://www.newco.dev.br/images/catalogo.gif" />-->
				<xsl:value-of select="document($doc)/translation/texts/item[@name='catalogo']/node()"/>
                </a>
			</xsl:if>
		</td> 

		<td class="textLeft">	
			<!--	En modo normal presenta un link con el nombre	-->
	        <a style="text-decoration:none;">
      		<xsl:attribute name="href">javascript:FichaProducto('<xsl:value-of select="ID"/>&amp;VENTANA=NUEVA');</xsl:attribute>
      		<xsl:attribute name="class">suave</xsl:attribute>
      		<xsl:attribute name="onMouseOver">window.status='Ver detalle del producto';return true;</xsl:attribute>
      		<xsl:attribute name="onMouseOut">window.status='';return true;</xsl:attribute>
      		<xsl:value-of select="NOMBRE"/><!--<span class="strongAzul"><xsl:value-of select="NOMBRE"/></span>-->
  	        </a>
  	        <input type="hidden" name="nombreCliente_{ID}" value="{NOMBRE}"/>
		</td>
		<td align="center">
        <xsl:choose>
          	<xsl:when test="REFERENCIA_CLIENTE != ''">
				<xsl:value-of select="REFERENCIA_CLIENTE"/>
          	</xsl:when>
            <xsl:otherwise>
            	<xsl:value-of select="REFERENCIA_MVM"/>
            </xsl:otherwise>
       	</xsl:choose>
       	<input type="hidden" name="referenciaCliente_{ID}" value="{REFERENCIA_CLIENTE}"/>
		</td>
		<td align="left">
			<xsl:value-of select="REFERENCIA"/>
		</td>
		<td align="center">
			<!--20nov19 quitamos el proveedor	<xsl:apply-templates select="PROVEEDOR"/><xsl:if test="MARCA!=''"> / <xsl:value-of select="MARCA"/></xsl:if>    --> 
			<xsl:value-of select="MARCA"/>    
		</td>
		<td align="center">
			<xsl:value-of select="UNIDADBASICA"/>                 
		</td>
		<td align="center">
			<xsl:value-of select="UNIDADESPORLOTE"/>               
		</td>
		<xsl:choose>
		<xsl:when test="not(PRECIOUNITARIO[.=''])">  
			<td align="right" style="padding-right:10px;">
				<xsl:value-of select="PRECIOUNITARIO"/>&nbsp;             
			</td>
        </xsl:when>
        <xsl:otherwise>
			<td colspan="2" style="padding-right:10px;">
            	<xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='LP-0590' and @lang=$lang]" disable-output-escaping="yes"/>&nbsp;
        	</td>
        </xsl:otherwise>
		</xsl:choose>   
		<xsl:if test="not(/ListaProductos/PLANTILLA/DERECHOS_PRODUCTOS_POR_CENTRO)">
			<td>
				<a class="btnDiscreto" href="javascript:DerechosUsuarioProducto({IDPRODESTANDAR},{ID});"><xsl:value-of select="document($doc)/translation/texts/item[@name='Derechos_usuarios']/node()"/></a>
			</td>
		</xsl:if>
    </tr>   
  </xsl:for-each>
</xsl:template>  

<xsl:template match="LP_DESCRIPCION">
  <xsl:value-of select="."/> 
</xsl:template>

<xsl:template match="PROVEEDOR">
   <a>
    <xsl:attribute name="href">javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPDetalleFrame2022.xsql?EMP_ID=<xsl:value-of select="../IDPROVEEDOR"/>&amp;VENTANA=NUEVA','empresa',100,80,0,0)</xsl:attribute> 
    <xsl:attribute name="class">suave</xsl:attribute>
    <xsl:attribute name="onMouseOver">window.status='Información sobre la empresa.';return true;</xsl:attribute>
    <xsl:attribute name="onMouseOut">window.status='';return true;</xsl:attribute>
    
    <xsl:value-of select="." disable-output-escaping="yes"/>
   </a>
</xsl:template>
</xsl:stylesheet>
