<?xml version="1.0" encoding="iso-8859-1"?>
<!--
	Lista de productos de una plantilla
	Ultima revisión: ET 13jun18 13:11 LPLista_201119.js
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href = "http://www.newco.dev.br/General/General.xsl" />
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
		<script type="text/javascript" src="http://www.newco.dev.br/General/divisas.js"></script>
		<script type="text/javascript" src="http://www.newco.dev.br/Compras/Multioferta/LPLista_201119.js"></script>


		<xsl:variable name="lang">
		<xsl:choose>
		<xsl:when test="/ListaProductos/LANG"><xsl:value-of select="/ListaProductos/LANG" /></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>  
		</xsl:variable>

		<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>        
		<title><xsl:value-of select="/ListaProductos/PLANTILLA/NOMBRE"/>:&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='productos_en_plantillas']/node()"/></title>
     
      </head>
      <!--<body onLoad="ActualizarCambios(this.location);">-->
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
        <xsl:variable name="accion"><xsl:value-of select="LP_ACCION"/>
        </xsl:variable>
 
  <!--13jun18	<form action="LPListaCambiosProductos.xsql" name="Cambios" method="POST">-->
  <form action="LPLista.xsql" name="Cambios" method="POST">
 
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
 
 	<!--<xsl:apply-templates select="NOMBRE"/>-->
 	<!--	Titulo de la página		-->
	<div class="ZonaTituloPagina">
		<p class="Path"><xsl:value-of select="document($doc)/translation/texts/item[@name='Inicio']/node()"/>&nbsp;/&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='pedidos']/node()"/>&nbsp;/&nbsp;<span class="FinPath"><xsl:value-of select="document($doc)/translation/texts/item[@name='productos_en_plantillas']/node()"/></span>
			<xsl:if test="/ListaProductos/PLANTILLA/ADMIN">
			<span class="CompletarTitulo">
				<span class="amarillo">PL_ID:&nbsp;<xsl:value-of select="/ListaProductos/PLANTILLA/ID"/></span>
			</span>
			</xsl:if>
		</p>
		<p class="TituloPagina">
			<!--<xsl:value-of select="document($doc)/translation/texts/item[@name='plantilla']/node()"/>:&nbsp;<xsl:value-of select="NOMBRE"/>-->
			<xsl:call-template name="desplegable">
			    <xsl:with-param name="path" select="/ListaProductos/PLANTILLA/PLANTILLAS/field"/>
			    <xsl:with-param name="style">width:600px;height:30px;font-size:15px;</xsl:with-param>
			    <xsl:with-param name="onChange">javascript:cbPlantillaChange();</xsl:with-param>
			</xsl:call-template>
			<span class="CompletarTitulo">
				<!--	botones	-->
				<a class="btnDestacado" href="javascript:Enviar()"><xsl:value-of select="document($doc)/translation/texts/item[@name='actualizar_los_cambios']/node()"/></a>
				&nbsp;
				<a class="btnNormal" href="javascript:DerechosUsuarioPlantilla();"><xsl:value-of select="document($doc)/translation/texts/item[@name='Derechos_usuarios']/node()"/></a>
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
    <table class="buscador">
      <tr class="subTituloTabla">
      <th class="dos">
           <a href="javascript:MarcarTodos(document.forms[1]);" style="text-decoration:underline;"><xsl:value-of select="document($doc)/translation/texts/item[@name='ocultar']/node()"/></a>
      </th>
      <th class="tres">&nbsp;</th>
      <th><xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/></th>
      <th class="cinco">
		 <xsl:copy-of select="document($doc)/translation/texts/item[@name='ref_cliente']/node()"/>
      </th>
      <th class="cinco" align="left">
		<xsl:copy-of select="document($doc)/translation/texts/item[@name='referencia_proveedor_2line']/node()"/>
      </th>
      <th class="cinco">
       <!--<xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/> / --><xsl:value-of select="document($doc)/translation/texts/item[@name='marca']/node()"/>
      </th>   
      <th class="cinco">
      <xsl:value-of select="document($doc)/translation/texts/item[@name='ud_basica']/node()"/>
       </th>
       <th class="cinco">
       	<xsl:value-of select="document($doc)/translation/texts/item[@name='ud_lote']/node()"/>
       </th>
      <th class="cinco">
      	<xsl:value-of select="document($doc)/translation/texts/item[@name='precio_ud_basica']/node()"/>
      </th>        
      <th>&nbsp;</th>
    </tr>
    <xsl:apply-templates select="./PRODUCTOS"/>
   </table>
  
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
	<tr>
		<!-- si no tiene permisos de escritura, no mostramos el boton -->
		<!--	Campo oculto con el ID del producto	-->
	    <input type="hidden" name="IDPRODUCTO">
              <xsl:attribute name="value">
	        <xsl:value-of select="ID"/>
	      </xsl:attribute>
	    </input> 
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
        <td align="center" style="padding-right:4px;">
			<xsl:if test="../../ADMIN_CDC">
                <a>
                <xsl:attribute name="href">javascript:MostrarPagPersonalizada('http://www.newco.dev.br/ProcesosCdC/MantenimientoReducido/MantenimientoReducido.xsql?PRO_ID=<xsl:value-of select="ID"/>','catalogoprivado',100,80,0,0);</xsl:attribute>
                <img src="http://www.newco.dev.br/images/catalogo.gif" />
                </a>
			</xsl:if>
		</td> 

		<td class="textLeft">	
			<!--	En modo normal presenta un link con el nombre	-->
	        <a style="text-decoration:none;">
      		<xsl:attribute name="href">javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Productos/PRODetalle.xsql?PRO_ID=<xsl:value-of select="ID"/>&amp;VENTANA=NUEVA','producto',100,80,0,0)</xsl:attribute>
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
		<td>
			<a class="btnNormal" href="javascript:DerechosUsuarioProducto({IDPRODESTANDAR},{ID});"><xsl:value-of select="document($doc)/translation/texts/item[@name='Derechos_usuarios']/node()"/></a>
		</td>
    </tr>   
  </xsl:for-each>
</xsl:template>  

<xsl:template match="LP_DESCRIPCION">
  <xsl:value-of select="."/> 
</xsl:template>

<!--
<xsl:template match="NOMBRE">
	<!- -idioma- ->
	<xsl:variable name="lang">
	<xsl:choose>
		<xsl:when test="/ListaProductos/LANG"><xsl:value-of select="/ListaProductos/LANG" /></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
	</xsl:choose>  
	</xsl:variable>

	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>        
	<!- -idioma fin- ->

	<!- -	Titulo de la página		- ->
	<div class="ZonaTituloPagina">
		<p class="Path"><xsl:value-of select="document($doc)/translation/texts/item[@name='Inicio']/node()"/>&nbsp;/&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='pedidos']/node()"/>&nbsp;/&nbsp;<span class="FinPath"><xsl:value-of select="document($doc)/translation/texts/item[@name='propiedades_plantilla']/node()"/></span></p>
		<p class="TituloPagina">
			<xsl:value-of select="document($doc)/translation/texts/item[@name='plantilla']/node()"/>:&nbsp;<xsl:value-of select="."/>
			<xsl:if test="//ADMIN">
				&nbsp;&nbsp;&nbsp;<span class="amarillo">PL_ID:&nbsp;<xsl:value-of select="/Mantenimiento/PLANTILLA/PL_ID"/></span>
			</xsl:if>
			<span class="CompletarTitulo">
				<!- -	botones	- ->
				<a class="btnDestacado" href="javascript:Enviar()"><xsl:value-of select="document($doc)/translation/texts/item[@name='actualizar_los_cambios']/node()"/></a>
				&nbsp;
				<a class="btnNormal" href="javascript:window.print();"><xsl:value-of select="document($doc)/translation/texts/item[@name='imprimir']/node()"/></a>
			</span>
		</p>
	</div>
	<br/>
	<br/>
	
 	<!- -<h1 class="titlePage">
  		<xsl:value-of select="document($doc)/translation/texts/item[@name='plantilla']/node()"/>:&nbsp;<xsl:value-of select="."/>&nbsp;		
	</h1>
    <div class="divLeft gris" style="padding:5px 0px;">
    <div class="divLeft25nopa" align="center">
       <strong>[ <a>
            <xsl:attribute name="href">javascript:abrirCabecera('../Multioferta/PLManten.xsql?PL_ID=<xsl:value-of select="//PL_ID"/>&amp;BOTON=CABECERA');</xsl:attribute>
            <xsl:attribute name="onMouseOver">window.status='Ver cabecera de <xsl:value-of select="."/>';return true;</xsl:attribute>
            <xsl:value-of select="document($doc)/translation/texts/item[@name='modificar_propiedades_plantilla']/node()"/>
        </a> ]</strong>
    </div><!- -fin de divleft25- ->
    <div class="divleft15nopa">&nbsp;</div>
    <div class="divLeft20" align="center">
           <strong><img src="http://www.newco.dev.br/images/imprimir.gif"/>&nbsp;<a href="javascript:window.print();"><xsl:value-of select="document($doc)/translation/texts/item[@name='imprimir']/node()"/></a></strong>
    </div><!- -fin divLeft20- ->
    <div class="divleft15nopa">&nbsp;</div>
    <div class="divLeft25nopa" align="center">
            <strong>[ <a href="javascript:Enviar(document.forms[1],document.forms[0])"><xsl:value-of select="document($doc)/translation/texts/item[@name='actualizar_los_cambios']/node()"/></a> ]</strong>
    </div><!- -fin de divLeft25- ->
    </div><!- -fin de divleft- ->
	- ->
</xsl:template>
-->

<xsl:template match="PROVEEDOR">
   <a>
    <xsl:attribute name="href">javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPDetalleFrame.xsql?EMP_ID=<xsl:value-of select="../IDPROVEEDOR"/>&amp;VENTANA=NUEVA','empresa',100,80,0,0)</xsl:attribute> 
    <xsl:attribute name="class">suave</xsl:attribute>
    <xsl:attribute name="onMouseOver">window.status='Información sobre la empresa.';return true;</xsl:attribute>
    <xsl:attribute name="onMouseOut">window.status='';return true;</xsl:attribute>
    
    <xsl:value-of select="." disable-output-escaping="yes"/>
   </a>
</xsl:template>
</xsl:stylesheet>
