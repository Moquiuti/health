<?xml version="1.0" encoding="iso-8859-1" ?>
<!--
 	Mantenimiento de productos de los catalogos de proveedores de MedicalVM
 
 	(c) 30/8/2001 ET
	
 		19abr07	ET	Permitimos modificar la marca desde este mantenimiento
 -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href = "http://www.newco.dev.br/General/General.xsl" />
  <xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
  <xsl:param name="lang" select="@lang"/>  
  <xsl:template match="/">
    <html>
      <head>
       <!--idioma-->
        <xsl:variable name="lang">
         <xsl:choose>
            <xsl:when test="/MantenimientoProductos/DATOS/LANG"><xsl:value-of select="/MantenimientoProductos/DATOS/LANG" /></xsl:when>
            <xsl:otherwise>spanish</xsl:otherwise>
            </xsl:choose>  
        </xsl:variable>
        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
      <!--idioma fin-->
      
	<title><xsl:value-of select="document($doc)/translation/texts/item[@name='mantenimiento_de_productos']/node()"/></title>
      <!--style-->
      <xsl:call-template name="estiloIndip"/>
      <!--fin de style -->  
	 <script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
     <script type="text/javascript" src="http://www.newco.dev.br/Administracion/Mantenimiento/Productos/PROBuscador090512.js"></script>
    
	 <script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>
     <script type="text/javascript" src="http://www.newco.dev.br/General/imagen.js"></script>
     <script type="text/javascript" src="http://www.newco.dev.br/General/litebox.js"></script>
     <link rel="stylesheet" href="http://www.newco.dev.br/General/lightbox.css" type="text/css" media="screen" />
	
      </head>
      <body class="gris">
          <xsl:attribute name="onLoad">
            <xsl:if test="//PRO_BUSQUEDA!=''">
              recargarPagina('<xsl:value-of select="//PRO_BUSQUEDA"/>');
            </xsl:if> 
          <!--  <xsl:if test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/PRODUCTO and not(/MantenimientoProductos/DATOS/LISTAPRODUCTOS/BUSQUEDA/SOLOMODIFICADOSPROV)">
            	inicializarExpandirTodos(document.forms['formBusca']);
           	</xsl:if> -->
            
          </xsl:attribute>   
          
       <!--idioma-->
        <xsl:variable name="lang">
         <xsl:choose>
            <xsl:when test="/MantenimientoProductos/DATOS/LANG"><xsl:value-of select="/MantenimientoProductos/DATOS/LANG" /></xsl:when>
            <xsl:otherwise>spanish</xsl:otherwise>
            </xsl:choose>  
        </xsl:variable>
        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
      <!--idioma fin-->
      
	
    
		<form action="" name="formBusca" method="POST">
        
      	<!-- ET Desactivado control errores: Habra que reactivarlo -->
        <xsl:choose>
          <xsl:when test="/MantenimientoProductos/DATOS/xsql-error">
            <xsl:apply-templates select="MantenimientoProductos/DATOS/xsql-error"/>          
          </xsl:when>
	
        <xsl:when test="/MantenimientoProductos/DATOS/ROW/Sorry">
          <xsl:apply-templates select="MantenimientoProductos/DATOS/ROW/Sorry"/> 
        </xsl:when>
        <xsl:otherwise>
       <h1 class="titlePageBajo">
        <xsl:value-of select="document($doc)/translation/texts/item[@name='mantenimiento_de_productos']/node()"/>&nbsp;
		</h1>
		
 	
		
		<table class="infoTable gris" border="0">
       
        <input type="hidden" name="ID_CLIENTE_ACTUAL" value="{/MantenimientoProductos/DATOS/LISTAPRODUCTOS/CLIENTES/field/@current}"/>
        <input type="hidden" name="ADMIN_MVM">
        <xsl:attribute name="value">
        	<xsl:choose>
            	<xsl:when test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/ADMIN_MVM or /MantenimientoProductos/DATOS/LISTAPRODUCTOS/ADMIN_MVMB">si</xsl:when>
            	<xsl:otherwise>no</xsl:otherwise>
            </xsl:choose>
        </xsl:attribute>
        </input>
        <input type="hidden" name="PAGINA">
			<xsl:attribute name="value">
				<xsl:value-of select="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/PAGINA"/>
			</xsl:attribute>
		</input>
        <input type="hidden" name="CAMBIOS" value="" />
        <!--comun para todos-->
        <input type="hidden" name="HISTORY" value="{//HISTORY}"/>
        <!--input para productos nuevos o modificado del proveedor mvm acepta o no-->
      	<input type="hidden" name="CAMBIOS_PROVE" value="" />
        <input type="hidden" name="US_ID_CAMBIO" value="{//LISTAPRODUCTOS/IDCLIENTE}" />
        <input type="hidden" name="ORDEN" value="{/MantenimientoProductos/DATOS/LISTAPRODUCTOS/BUSQUEDA/ORDEN}" />
  		<input type="hidden" name="SENTIDO" value="{/MantenimientoProductos/DATOS/LISTAPRODUCTOS/BUSQUEDA/SENTIDO}" />
        
        <xsl:choose>
        <!--SI ES MVM ESPAÑA ENSEÑO MUCHOS CHECKBOX-->
		<xsl:when test="(/MantenimientoProductos/DATOS/LISTAPRODUCTOS/ADMIN_MVM or /MantenimientoProductos/DATOS/LISTAPRODUCTOS/ADMIN_MVMB) and /MantenimientoProductos/DATOS/LISTAPRODUCTOS/IDPAIS = '34'">
        <!--si es mvm veré 3 campos del buscador-->
		<tr style="padding:7px 0px 0px;">
        	<td class="cinco">&nbsp;</td>
			<td class="datosLeft">
            	<strong><xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/></strong><br />
				<input type="text" name="PRODUCTO" maxlength="200" size="38">
					<xsl:attribute name="value">
					<xsl:value-of select="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/BUSQUEDA/PRODUCTO"/>
					</xsl:attribute>
				</input>
				<input type="hidden" name="HAYPRODUCTOS" value="{//HAYPRODUCTOS}"/>
                <input type="hidden" name="IDCLIENTES" />
			</td>
			<td class="datosLeft">
            	<strong> <xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/></strong><br />
   		 		<xsl:call-template name="desplegable">
   		   		<xsl:with-param name="path" select="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/FIDPROVEEDOR/field"/>
   		   		<!--<xsl:with-param name="onChange">EnviarBusqueda();</xsl:with-param>-->
   		 		</xsl:call-template>

			</td>
 			<td class="datosLeft">
				<strong> <xsl:value-of select="document($doc)/translation/texts/item[@name='cliente']/node()"/></strong><br/>
   		 		<xsl:call-template name="desplegable">
   		   			<xsl:with-param name="path" select="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/CLIENTES/field"/>
   		   			<xsl:with-param name="onChange">EnviarBusqueda();</xsl:with-param>
   		 		</xsl:call-template>
			</td>
            <td class="datosLeft">
            <div class="boton" style="margin-top:10px;">
            	<a href="javascript:EnviarBusqueda();">
                	<xsl:value-of select="document($doc)/translation/texts/item[@name='buscar']/node()"/>
                </a>
            </div>
			</td>
            </tr>
            <tr style="border-bottom:3px solid #e4e4e5;padding:5px 0px;">
            <td>&nbsp;</td>
            <td class="textLeft" style="padding:5px 0px;">
			
		   	<input type="hidden" name="SINPRIVADOS" value="N"/>
            
            <p class="textLeft"><input type="checkbox" name="SOLODESTACADOS"><!--onChange="javascript:EnviarBusqueda();"-->
                <xsl:choose>
                <xsl:when test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/BUSQUEDA/SOLODESTACADOS">
                    <xsl:attribute name="checked">checked</xsl:attribute>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:attribute name="unchecked">unchecked</xsl:attribute>	
                </xsl:otherwise>
                </xsl:choose>		
            </input>
            &nbsp;<strong><xsl:value-of select="document($doc)/translation/texts/item[@name='solo_destacados']/node()"/></strong></p>
			<!--	Solo ocultos	-->
             <p class="textLeft"><input type="checkbox" name="SOLOOCULTOS"><!--onChange="javascript:EnviarBusqueda();"-->
                <xsl:choose>
                <xsl:when test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/BUSQUEDA/SOLOOCULTOS">
                    <xsl:attribute name="checked">checked</xsl:attribute>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:attribute name="unchecked">unchecked</xsl:attribute>	
                </xsl:otherwise>
                </xsl:choose>		
            </input>
            &nbsp;<strong><xsl:value-of select="document($doc)/translation/texts/item[@name='solo_ocultos']/node()"/></strong>
			</p>
			<!--	6set12	Solo visibles	-->
              <p class="textLeft"><input type="checkbox" name="SOLOVISIBLES"><!--onChange="javascript:EnviarBusqueda();"-->
                <xsl:choose>
                <xsl:when test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/BUSQUEDA/SOLOVISIBLES">
                    <xsl:attribute name="checked">checked</xsl:attribute>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:attribute name="unchecked">unchecked</xsl:attribute>	
                </xsl:otherwise>
                </xsl:choose>		
            </input>
            &nbsp;<strong>Solo visibles</strong>
			</p>
             <p class="textLeft"><input type="checkbox" name="SOLOFARMACOS"><!--onChange="javascript:EnviarBusqueda();"-->
                <xsl:choose>
                <xsl:when test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/BUSQUEDA/SOLOFARMACIA">
                    <xsl:attribute name="checked">checked</xsl:attribute>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:attribute name="unchecked">unchecked</xsl:attribute>	
                </xsl:otherwise>
                </xsl:choose>		
            </input>
            &nbsp;<strong><xsl:value-of select="document($doc)/translation/texts/item[@name='solo_farmacos']/node()"/>
           </strong></p>
           <p>&nbsp;</p>
           </td>
           <td>
            <p class="textLeft"><input type="checkbox" name="MODIFICADOSPROV"><!--onChange="javascript:EnviarBusqueda();"-->
                <xsl:choose>
                <xsl:when test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/BUSQUEDA/SOLOMODIFICADOSPROV">
                    <xsl:attribute name="checked">checked</xsl:attribute>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:attribute name="unchecked">unchecked</xsl:attribute>	
                </xsl:otherwise>
                </xsl:choose>		
            </input>
            &nbsp;<strong><xsl:value-of select="document($doc)/translation/texts/item[@name='solicitudes_cambios_prove']/node()"/>
           </strong></p> 
           <!--sin emplantillar-->
           <p class="textLeft"><input type="checkbox" name="SINEMPLANTILLAR"><!--onChange="javascript:EnviarBusqueda();"-->
                <xsl:choose>
                <xsl:when test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/BUSQUEDA/SINEMPLANTILLAR">
                    <xsl:attribute name="checked">checked</xsl:attribute>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:attribute name="unchecked">unchecked</xsl:attribute>	
                </xsl:otherwise>
                </xsl:choose>		
            </input>
            &nbsp;<strong>Sin emplantillar</strong>
            </p>
           <!--sin precio -->
            <p class="textLeft"><input type="checkbox" name="SINPRECIOMVM"><!--onChange="javascript:EnviarBusqueda();"-->
                <xsl:choose>
                <xsl:when test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/BUSQUEDA/SINPRECIOMVM">
                    <xsl:attribute name="checked">checked</xsl:attribute>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:attribute name="unchecked">unchecked</xsl:attribute>	
                </xsl:otherwise>
                </xsl:choose>		
            </input>
            &nbsp;<strong>Sin precio MVM
            <!--precio asisa diferente-->
           </strong></p>            <p class="textLeft"><input type="checkbox" name="PRECIOASISADIFERENTE"><!--onChange="javascript:EnviarBusqueda();"-->
                <xsl:choose>
                <xsl:when test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/BUSQUEDA/PRECIOASISADIFERENTE">
                    <xsl:attribute name="checked">checked</xsl:attribute>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:attribute name="unchecked">unchecked</xsl:attribute>	
                </xsl:otherwise>
                </xsl:choose>		
            </input>
            &nbsp;<strong>Precio MVM diferente de precio ASISA
           </strong></p>          
           <p>&nbsp;</p>
            </td>
            <td>
             <p class="textLeft"><input type="checkbox" name="SINOFERTAMVM"><!--onChange="javascript:EnviarBusqueda();"-->
                <xsl:choose>
                <xsl:when test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/BUSQUEDA/SINOFERTAMVM">
                    <xsl:attribute name="checked">checked</xsl:attribute>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:attribute name="unchecked">unchecked</xsl:attribute>	
                </xsl:otherwise>
                </xsl:choose>		
            </input>
            &nbsp;<strong>Sin oferta MVM</strong></p>
            
              <p class="textLeft"><input type="checkbox" name="SINOFERTAASISA"><!--onChange="javascript:EnviarBusqueda();"-->
                <xsl:choose>
                <xsl:when test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/BUSQUEDA/SINOFERTAASISA">
                    <xsl:attribute name="checked">checked</xsl:attribute>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:attribute name="unchecked">unchecked</xsl:attribute>	
                </xsl:otherwise>
                </xsl:choose>		
            </input>
            &nbsp;<strong>Sin oferta Asisa</strong></p>
            
              <p class="textLeft"><input type="checkbox" name="SINOFERTAFNCP"><!--onChange="javascript:EnviarBusqueda();"-->
                <xsl:choose>
                <xsl:when test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/BUSQUEDA/SINOFERTAFNCP">
                    <xsl:attribute name="checked">checked</xsl:attribute>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:attribute name="unchecked">unchecked</xsl:attribute>	
                </xsl:otherwise>
                </xsl:choose>		
            </input>
            &nbsp;<strong>Sin oferta FNCP</strong></p>
            
              <p class="textLeft"><input type="checkbox" name="SINOFERTAVIAMED"><!--onChange="javascript:EnviarBusqueda();"-->
                <xsl:choose>
                <xsl:when test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/BUSQUEDA/SINOFERTAVIAMED">
                    <xsl:attribute name="checked">checked</xsl:attribute>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:attribute name="unchecked">unchecked</xsl:attribute>	
                </xsl:otherwise>
                </xsl:choose>		
            </input>
            &nbsp;<strong>Sin oferta Viamed</strong></p>
            
             <p class="textLeft"><input type="checkbox" name="SINOFERTATEKNON"><!--onChange="javascript:EnviarBusqueda();"-->
                <xsl:choose>
                <xsl:when test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/BUSQUEDA/SINOFERTATEKNON">
                    <xsl:attribute name="checked">checked</xsl:attribute>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:attribute name="unchecked">unchecked</xsl:attribute>	
                </xsl:otherwise>
                </xsl:choose>		
            </input>
            &nbsp;<strong>Sin oferta Teknon</strong></p>
            </td>
			<td>&nbsp;</td>
            
		</tr>
        </xsl:when>
        
        <!--SI ES MVM BRASIL ENSEÑO OTRO FORMATO NO HAY TANTOS CHECKBOX-->
		<xsl:when test="(/MantenimientoProductos/DATOS/LISTAPRODUCTOS/ADMIN_MVM or /MantenimientoProductos/DATOS/LISTAPRODUCTOS/ADMIN_MVMB) and /MantenimientoProductos/DATOS/LISTAPRODUCTOS/IDPAIS = '55'">
        <tr>
        	<td class="cinco">&nbsp;</td>
			<td class="datosLeft">
            	<strong><xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/></strong><br />
				<input type="text" name="PRODUCTO" maxlength="200" size="38">
					<xsl:attribute name="value">
					<xsl:value-of select="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/BUSQUEDA/PRODUCTO"/>
					</xsl:attribute>
				</input>
				<input type="hidden" name="HAYPRODUCTOS" value="{//HAYPRODUCTOS}"/>
                <input type="hidden" name="IDCLIENTES" />
			</td>
			<td class="datosLeft">
            	<strong> <xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/></strong><br />
   		 		<xsl:call-template name="desplegable">
   		   		<xsl:with-param name="path" select="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/FIDPROVEEDOR/field"/>
   		   		<!--<xsl:with-param name="onChange">EnviarBusqueda();</xsl:with-param>-->
   		 		</xsl:call-template>

			</td>
 			<td class="datosLeft">
				<strong> <xsl:value-of select="document($doc)/translation/texts/item[@name='cliente']/node()"/></strong><br/>
   		 		<xsl:call-template name="desplegable">
   		   			<xsl:with-param name="path" select="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/CLIENTES/field"/>
   		   			<xsl:with-param name="onChange">EnviarBusqueda();</xsl:with-param>
   		 		</xsl:call-template>
			</td>
            <td class="datosLeft">
            <!--	Solo destacados	-->
              <p class="textLeft"><input type="checkbox" name="SOLODESTACADOS"><!--onChange="javascript:EnviarBusqueda();"-->
                <xsl:choose>
                <xsl:when test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/BUSQUEDA/SOLODESTACADOS">
                    <xsl:attribute name="checked">checked</xsl:attribute>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:attribute name="unchecked">unchecked</xsl:attribute>	
                </xsl:otherwise>
                </xsl:choose>		
            </input>
            &nbsp;<strong><xsl:value-of select="document($doc)/translation/texts/item[@name='solo_destacados']/node()"/></strong></p>
            <!--	Solo ocultos	-->
             <p class="textLeft"><input type="checkbox" name="SOLOOCULTOS"><!--onChange="javascript:EnviarBusqueda();"-->
                <xsl:choose>
                <xsl:when test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/BUSQUEDA/SOLOOCULTOS">
                    <xsl:attribute name="checked">checked</xsl:attribute>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:attribute name="unchecked">unchecked</xsl:attribute>	
                </xsl:otherwise>
                </xsl:choose>		
            </input>
            &nbsp;<strong><xsl:value-of select="document($doc)/translation/texts/item[@name='solo_ocultos']/node()"/></strong>
			</p>
			<!--	6set12	Solo visibles	-->
              <p class="textLeft"><input type="checkbox" name="SOLOVISIBLES"><!--onChange="javascript:EnviarBusqueda();"-->
                <xsl:choose>
                <xsl:when test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/BUSQUEDA/SOLOVISIBLES">
                    <xsl:attribute name="checked">checked</xsl:attribute>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:attribute name="unchecked">unchecked</xsl:attribute>	
                </xsl:otherwise>
                </xsl:choose>		
            </input>
            &nbsp;<strong>Solo visibles</strong>
			</p>
             <p class="textLeft"><input type="checkbox" name="SOLOFARMACOS"><!--onChange="javascript:EnviarBusqueda();"-->
                <xsl:choose>
                <xsl:when test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/BUSQUEDA/SOLOFARMACIA">
                    <xsl:attribute name="checked">checked</xsl:attribute>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:attribute name="unchecked">unchecked</xsl:attribute>	
                </xsl:otherwise>
                </xsl:choose>		
            </input>
            &nbsp;<strong><xsl:value-of select="document($doc)/translation/texts/item[@name='solo_farmacos']/node()"/>
           </strong></p>
              <p class="textLeft"><input type="checkbox" name="MODIFICADOSPROV"><!--onChange="javascript:EnviarBusqueda();"-->
                <xsl:choose>
                <xsl:when test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/BUSQUEDA/SOLOMODIFICADOSPROV">
                    <xsl:attribute name="checked">checked</xsl:attribute>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:attribute name="unchecked">unchecked</xsl:attribute>	
                </xsl:otherwise>
                </xsl:choose>		
            </input>
            &nbsp;<strong><xsl:value-of select="document($doc)/translation/texts/item[@name='solicitudes_cambios_prove']/node()"/>
           </strong></p> 
            </td>
            <td class="datosLeft">
            <div class="boton" style="margin-top:10px;">
            	<a href="javascript:EnviarBusqueda();">
                	<xsl:value-of select="document($doc)/translation/texts/item[@name='buscar']/node()"/>
                </a>
            </div>
			</td>
            </tr>
        		<input type="hidden" name="SINPRIVADOS" value="N"/>
        		<input type="hidden" name="SOLOASISA" value="N"/>
                <input type="hidden" name="SOLOFNCP" value="N"/>
                <input type="hidden" name="SOLOVIAMED" value="N"/>
                <input type="hidden" name="SOLOTEKNON" value="N"/>
		   		<input type="hidden" name="SINPRECIOMVM" value="N"/>
		   		<input type="hidden" name="PRECIOASISADIFERENTE" value="N"/>
         		<input type="hidden" name="SINOFERTAMVM" value="N"/>
                <input type="hidden" name="SINOFERTAASISA" value="N"/>
                <input type="hidden" name="SINOFERTAFNCP" value="N"/>
		   		<input type="hidden" name="SINOFERTAVIAMED" value="N"/>
		   		<input type="hidden" name="SINOFERTATEKNON" value="N"/>
        </xsl:when>
        <!--si es proveedor veo solo input producto-->
        <xsl:otherwise>
        <tr style="border-bottom:1px solid #e4e4e5;">
				<input type="hidden" name="IDPROVEEDOR" value="{/MantenimientoProductos/DATOS/LISTAPRODUCTOS/IDEMPRESA}"/>
                <input type="hidden" name="IDPAIS" value="{/MantenimientoProductos/DATOS/LISTAPRODUCTOS/IDPAIS}"/>
                <input type="hidden" name="ELIMINAR_SOLICITUD" value=""/>
        <!--si es proveedor doy un ancho a la columna asi queda a la derecha, este unico campo que ve mvm y proveedores-->
			<td class="trenta">
            	<strong><xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/>:</strong>&nbsp;
				<input type="text" name="PRODUCTO" maxlength="200" size="38">
					<xsl:attribute name="value">
					<xsl:value-of select="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/BUSQUEDA/PRODUCTO"/>
					</xsl:attribute>
				</input>
				<input type="hidden" name="HAYPRODUCTOS" value="{//HAYPRODUCTOS}"/>
                <input type="hidden" name="IDCLIENTES" />
			</td>
            <td>
             <xsl:choose>
             <xsl:when test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/IDPAIS = '34'">
               <p class="textLeft"><input type="checkbox" name="SOLOASISA"><!--onChange="javascript:EnviarBusqueda();"-->
                <xsl:choose>
                <xsl:when test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/BUSQUEDA/SOLOASISA">
                    <xsl:attribute name="checked">checked</xsl:attribute>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:attribute name="unchecked">unchecked</xsl:attribute>	
                </xsl:otherwise>
                </xsl:choose>		
            </input>
            &nbsp;<strong><xsl:value-of select="document($doc)/translation/texts/item[@name='solo_asisa']/node()"/>
           </strong>
           </p>
            <!-- solo fncp -->
            <p class="textLeft"><input type="checkbox" name="SOLOFNCP">
                <xsl:choose>
                <xsl:when test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/BUSQUEDA/SOLOFNCP">
                    <xsl:attribute name="checked">checked</xsl:attribute>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:attribute name="unchecked">unchecked</xsl:attribute>	
                </xsl:otherwise>
                </xsl:choose>		
            </input>
            &nbsp;<strong><xsl:value-of select="document($doc)/translation/texts/item[@name='solo_fncp']/node()"/></strong>
            </p>
             <!-- solo viamed-->
            <p class="textLeft"><input type="checkbox" name="SOLOVIAMED">
                <xsl:choose>
                <xsl:when test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/BUSQUEDA/SOLOVIAMED">
                    <xsl:attribute name="checked">checked</xsl:attribute>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:attribute name="unchecked">unchecked</xsl:attribute>	
                </xsl:otherwise>
                </xsl:choose>		
            </input>
            &nbsp;<strong><xsl:value-of select="document($doc)/translation/texts/item[@name='solo_viamed']/node()"/></strong>
            </p>
            <!-- solo teknon-->
            <p class="textLeft"><input type="checkbox" name="SOLOTEKNON">
                <xsl:choose>
                <xsl:when test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/BUSQUEDA/SOLOTEKNON">
                    <xsl:attribute name="checked">checked</xsl:attribute>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:attribute name="unchecked">unchecked</xsl:attribute>	
                </xsl:otherwise>
                </xsl:choose>		
            </input>
            &nbsp;<strong><xsl:value-of select="document($doc)/translation/texts/item[@name='solo_teknon']/node()"/></strong>
            </p>
            </xsl:when>
           <xsl:otherwise><input type="hidden" name="SOLOASISA" value="N"/><input type="hidden" name="SOLOFNCP" value="N"/></xsl:otherwise>
           </xsl:choose>
           <!--solicitudes rechazadas-->
            <p class="textLeft"><input type="checkbox" name="RECHAZADOS"><!--onChange="javascript:EnviarBusqueda();"-->
                <xsl:choose>
                <xsl:when test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/BUSQUEDA/RECHAZADOS">
                    <xsl:attribute name="checked">checked</xsl:attribute>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:attribute name="unchecked">unchecked</xsl:attribute>	
                </xsl:otherwise>
                </xsl:choose>		
            </input>
            &nbsp;<strong><xsl:value-of select="document($doc)/translation/texts/item[@name='solicitudes_rechazadas']/node()"/>
           </strong></p>
           
           </td>
				<input type="hidden" name="IDCLIENTE" value="-1"/>
           	<td>
            <div class="boton">
            	<a href="javascript:EnviarBusqueda();">
                	<xsl:value-of select="document($doc)/translation/texts/item[@name='buscar']/node()"/>
                </a>
            </div>
			</td>
            <td class="veinte">&nbsp;</td>
            <td>
            <div class="boton">
               <a href="PROManten.xsql?PROVEEDOR={/MantenimientoProductos/DATOS/LISTAPRODUCTOS/IDPROVEEDOR}"> <xsl:value-of select="document($doc)/translation/texts/item[@name='nuevo_producto']/node()"/></a>
            </div>
          </td>
		</tr>
        </xsl:otherwise>
        </xsl:choose>
		</table>
		
        <!--tabla productos-->
            <!-- si usuario admin mvm puede cambiar todo, si es proveedor solo imagenes-->
        <xsl:choose>
            <xsl:when test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/ADMIN_MVM or /MantenimientoProductos/DATOS/LISTAPRODUCTOS/ADMIN_MVMB">
       			<xsl:choose>
				<xsl:when test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/PRODUCTO">
                               
                <xsl:call-template name="adminMVM"/>
				</xsl:when>
 	        	<xsl:otherwise>
                	<div class="divLeft">
                    	<br /><br />
                    	<div class="divCenter30">
                    	<strong><xsl:value-of select="document($doc)/translation/texts/item[@name='no_hay_datos_que_mostrar']/node()"/>.</strong>
                    	</div>
                    	<br /><br />
                	</div>
				</xsl:otherwise>
				</xsl:choose>
            </xsl:when>
            <xsl:otherwise>
                <xsl:call-template name="proveedor"/>
            </xsl:otherwise>
       </xsl:choose>
            </xsl:otherwise>
       </xsl:choose>
            <!--frame para las imagenes-->
	<div id="uploadFrameBox" style="display:none;"><iframe src="" id="uploadFrame" name="uploadFrame" style="width: 100%;"></iframe></div>
     
     </form>   
     
     <!--mensaje js-->
    <form name="MensajeJS">
  	<input type="hidden" name="CRITERIO_BUSQUEDA" value="{document($doc)/translation/texts/item[@name='criterio_busqueda']/node()}"/>
  	<input type="hidden" name="CRITERIO_BUSQUEDA_TEXT" value="{document($doc)/translation/texts/item[@name='criterio_busqueda_text']/node()}"/>
	<input type="hidden" name="CRITERIO_BUSQUEDA_TEXT1" value="{document($doc)/translation/texts/item[@name='criterio_busqueda_text1']/node()}"/>
  	<input type="hidden" name="CRITERIO_BUSQUEDA_TEXT2" value="{document($doc)/translation/texts/item[@name='criterio_busqueda_text2']/node()}"/>
  	<input type="hidden" name="CRITERIO_BUSQUEDA_TEXT3" value="{document($doc)/translation/texts/item[@name='criterio_busqueda_text3']/node()}"/>
  	<input type="hidden" name="DESEA_EXPANDIR_PRECIOS" value="{document($doc)/translation/texts/item[@name='desea_expandir_precios']/node()}"/>
    <input type="hidden" name="SEGURO_ELIMINAR_IMAGEN" value="{document($doc)/translation/texts/item[@name='seguro_eliminar_imagen']/node()}"/>
    <input type="hidden" name="ERROR_CON_CLIENTE" value="{document($doc)/translation/texts/item[@name='error_con_cliente']/node()}"/>
    <input type="hidden" name="IDCLIENTE" value="{document($doc)/translation/texts/item[@name='idcliente']/node()}"/>
    <input type="hidden" name="EXPANDIDOS_NULOS" value="{document($doc)/translation/texts/item[@name='expandidos_nulos']/node()}"/>
    <input type="hidden" name="INTRODUZCA_CANTIDAD" value="{document($doc)/translation/texts/item[@name='introduzca_cantidad']/node()}"/>
    <input type="hidden" name="INTRODUZCA_CANTIDAD_CORRECTA" value="{document($doc)/translation/texts/item[@name='introduzca_cantidad_correcta']/node()}"/>
    
    <input type="hidden" name="INTRODUZCA_UNIDAD_BASE" value="{document($doc)/translation/texts/item[@name='introduzca_unidad_base']/node()}"/>
    
    <input type="hidden" name="INTRODUZCA_CANTIDAD_CORRECTA" value="{document($doc)/translation/texts/item[@name='introduzca_cantidad_correcta']/node()}"/>
    
      <input type="hidden" name="INTRODUZCA_CANTIDAD_CORRECTA" value="{document($doc)/translation/texts/item[@name='introduzca_cantidad_correcta']/node()}"/>
      
    <input type="hidden" name="INTRODUZCA_CANTIDAD_CORRECTA" value="{document($doc)/translation/texts/item[@name='introduzca_cantidad_correcta']/node()}"/>
    
      <input type="hidden" name="INTRODUZCA_CANTIDAD_CORRECTA" value="{document($doc)/translation/texts/item[@name='introduzca_cantidad_correcta']/node()}"/>
      
    <input type="hidden" name="INTRODUZCA_CANTIDAD_CORRECTA" value="{document($doc)/translation/texts/item[@name='introduzca_cantidad_correcta']/node()}"/>
    
     <input type="hidden" name="SOLICITUD_PENDIENTE" value="{document($doc)/translation/texts/item[@name='alarma_solicitud_pendiente']/node()}"/>
     
      <input type="hidden" name="SOLICITUD_DEVUELTA" value="{document($doc)/translation/texts/item[@name='alarma_solicitud_devuelta']/node()}"/>
    </form>
      
      </body>
    </html>
  </xsl:template>  
  
<xsl:template name="adminMVM">
 	<!--idioma-->
        <xsl:variable name="lang">
         <xsl:choose>
            <xsl:when test="/MantenimientoProductos/DATOS/LANG"><xsl:value-of select="/MantenimientoProductos/DATOS/LANG" /></xsl:when>
            <xsl:otherwise>spanish</xsl:otherwise>
            </xsl:choose>  
        </xsl:variable>
        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
      <!--idioma fin-->
      
<!--productos normales-->
 	<xsl:choose>
       <xsl:when test="not(/MantenimientoProductos/DATOS/LISTAPRODUCTOS/BUSQUEDA/SOLOMODIFICADOSPROV)">
       
            <input type="hidden" name="IDPROVEEDOR" value="" />
	        <input type="hidden" name="IDCLIENTE" value=""/>
            <input type="hidden" name="IDPRODUCTO" value="" />
            
            <table class="encuesta" border="0">
            <thead>
            <tr class="lejenda">
				<th colspan="3" class="textLeft">
					<xsl:value-of select="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/MENSAJE"/>
				</th>
                <th colspan="4" align="left"> 
                	<xsl:if test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/IDPAIS = '34'">
                      <p style="align:left; font-weight:normal; margin-left:5px;">
                        <img src="http://www.newco.dev.br/images/cuadroRojo.gif" />&nbsp;
                        <span class="font11"><xsl:value-of select="document($doc)/translation/texts/item[@name='precios_diferentes']/node()"/></span>
                        <br />
                        &nbsp;<span class="verde">A</span>&nbsp;
                        <span class="font11"><xsl:value-of select="document($doc)/translation/texts/item[@name='adjudicado_asisa']/node()"/></span>
                	  </p>
                     </xsl:if>
                </th>
                <th colspan="10" class="textRight">
                	<div class="boton">
                        	<a href="javascript:Enviar(document.forms[1],document.forms[0],'ACTUALIZAR');">
                            	<xsl:value-of select="document($doc)/translation/texts/item[@name='actualizar']/node()"/>
                     		</a>
                        </div>
                    <xsl:if test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/PAGINAANTERIOR">
                        <a href="javascript:Enviar(document.forms['formBusca'],'ANTERIOR');"><img src="http://www.newco.dev.br/images/flechaLeft.gif" /></a> 
                       <a href="javascript:Enviar(document.forms['formBusca'],'ANTERIOR');"><xsl:value-of select="document($doc)/translation/texts/item[@name='anterior']/node()"/></a>
                    </xsl:if>
                    <xsl:if test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/PAGINASIGUIENTE">
                         &nbsp;&nbsp;&nbsp;
                         <a href="javascript:Enviar(document.forms['formBusca'],'SIGUIENTE');" title="siguiente"><xsl:value-of select="document($doc)/translation/texts/item[@name='siguiente']/node()"/></a>
                         <a href="javascript:Enviar(document.forms['formBusca'],'SIGUIENTE');" title="siguiente"><img src="http://www.newco.dev.br/images/flechaRight.gif" /></a>
					</xsl:if>
                 </th>
			</tr>
      	    <tr class="titulos">
								<th class="cinco"><a href="javascript:OrdenarPor('REFERENCIA');"><xsl:value-of select="document($doc)/translation/texts/item[@name='referencia']/node()"/></a></th>
                                <th class="dos"><xsl:value-of select="document($doc)/translation/texts/item[@name='ima']/node()"/></th>
								<th><a href="javascript:OrdenarPor('PRODUCTO');"><xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/></a></th>
								<th><a href="javascript:OrdenarPor('PROVEEDOR');"><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/></a></th>
								<xsl:if test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/ADMIN_MVM or /MantenimientoProductos/DATOS/LISTAPRODUCTOS/ADMIN_MVMB">
									<th class="dies"><xsl:value-of select="document($doc)/translation/texts/item[@name='adjudicado']/node()"/></th>
								</xsl:if>
								<th class="tres"><a href="javascript:OrdenarPor('MARCA');"><xsl:value-of select="document($doc)/translation/texts/item[@name='marca']/node()"/></a></th>
								<th class="ocho"><xsl:value-of select="document($doc)/translation/texts/item[@name='ud_base']/node()"/></th>
								<th class="tres"><xsl:copy-of select="document($doc)/translation/texts/item[@name='ud_por_caja_2line']/node()"/></th>
								<th class="tres"><xsl:value-of select="document($doc)/translation/texts/item[@name='iva']/node()"/></th>
								
								<th class="cinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='precio']/node()"/>
                                  <xsl:if test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/ADMIN_MVM and /MantenimientoProductos/DATOS/LISTAPRODUCTOS/IDPAIS = '34'">
                                       <br /><xsl:value-of select="document($doc)/translation/texts/item[@name='mvm']/node()"/>
                                   </xsl:if>
                                </th>
								
                                <!--precio asisa,fncp, viamed, teknon-->
                                <xsl:if test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/ADMIN_MVM and /MantenimientoProductos/DATOS/LISTAPRODUCTOS/IDPAIS = '34'">
									<th class="cuatro"><xsl:copy-of select="document($doc)/translation/texts/item[@name='precio_asisa']/node()"/></th>
                                    <th class="cuatro"><xsl:copy-of select="document($doc)/translation/texts/item[@name='precio_fncp']/node()"/></th>
                                    <th class="cuatro"><xsl:copy-of select="document($doc)/translation/texts/item[@name='precio_viamed']/node()"/></th>
                                    <th class="cuatro"><xsl:copy-of select="document($doc)/translation/texts/item[@name='precio_teknon']/node()"/></th>
								</xsl:if>
								<!--<xsl:if test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/ADMIN_MVM or /MantenimientoProductos/DATOS/LISTAPRODUCTOS/ADMIN_MVMB">
									<th class="cuatro"><xsl:copy-of select="document($doc)/translation/texts/item[@name='precio_anterior_fecha_2line']/node()"/></th>
								</xsl:if>-->
								<xsl:if test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/ADMIN_MVM or /MantenimientoProductos/DATOS/LISTAPRODUCTOS/ADMIN_MVMB">
									<th class="dos"><a href="javascript:OrdenarPor('CONSUMO');"><xsl:copy-of select="document($doc)/translation/texts/item[@name='consumo_euros_2line']/node()"/></a></th>
								</xsl:if>
								<xsl:if test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/ADMIN_MVM or /MantenimientoProductos/DATOS/LISTAPRODUCTOS/ADMIN_MVMB">
									<th class="uno"><xsl:value-of select="document($doc)/translation/texts/item[@name='bor']/node()"/><br /><a href="javascript:SelTodosBorrar();"><xsl:value-of select="document($doc)/translation/texts/item[@name='todos']/node()"/></a></th>
								</xsl:if>
								<xsl:if test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/ADMIN_MVM or /MantenimientoProductos/DATOS/LISTAPRODUCTOS/ADMIN_MVMB">
									<th class="uno"><xsl:value-of select="document($doc)/translation/texts/item[@name='cop']/node()"/></th>
								</xsl:if>
                                <!--
                                <xsl:if test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/ADMIN_MVM or /MantenimientoProductos/DATOS/LISTAPRODUCTOS/ADMIN_MVMB">
									<th class="uno"><xsl:value-of select="document($doc)/translation/texts/item[@name='dest']/node()"/><br /><a href="javascript:SelTodosDestacados();"><xsl:value-of select="document($doc)/translation/texts/item[@name='todos']/node()"/></a></th>
								</xsl:if>
                                <xsl:if test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/ADMIN_MVM or /MantenimientoProductos/DATOS/LISTAPRODUCTOS/ADMIN_MVMB">
									<th class="uno"><xsl:value-of select="document($doc)/translation/texts/item[@name='ocu']/node()"/><br /><a href="javascript:SelTodosOcultos();"><xsl:value-of select="document($doc)/translation/texts/item[@name='todos']/node()"/></a></th>
								</xsl:if>-->
							</tr>
                  </thead>
							<!--	Cuerpo de la tabla	-->
                <tbody>
      	    	<xsl:for-each select="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/PRODUCTO">
                	<!--idioma-->
                    <xsl:variable name="lang">
                     <xsl:choose>
                        <xsl:when test="/MantenimientoProductos/DATOS/LANG"><xsl:value-of select="/MantenimientoProductos/DATOS/LANG" /></xsl:when>
                        <xsl:otherwise>spanish</xsl:otherwise>
                        </xsl:choose>  
                    </xsl:variable>
                    <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
                  <!--idioma fin-->
                                 
      	      	<tr><!--<xsl:if test="OCULTO = 'S'">
                	<xsl:attribute name="class">ocultoTR</xsl:attribute>
                    </xsl:if>-->
									<td class="center">
                                    
										<a>
                                        <xsl:attribute name="href">javascript:soloUnProd('<xsl:value-of select="REFERENCIA"/>');</xsl:attribute>
                                       
                                        <xsl:value-of select="REFERENCIA"/>
                                        </a>
									</td> 
                                    <td>
										<xsl:if test="(count(IMAGENES/IMAGEN)) &gt; 0">
                                            <xsl:variable name="idRef" select="REFERENCIA" />
                                                    <img src="../../../images/fotoListadoPeq.gif" alt="con foto" id="{$idRef}" onmouseover="verFoto('{$idRef}');" onmouseout="verFoto('{$idRef}');" />
                                                    <div id="verFotoPro_{$idRef}" class="divFotoProBusca" style="display:none;">
                                                        <xsl:for-each select="IMAGENES/IMAGEN">
                                                            <xsl:if test="@id != '-1'">
                                                            <img src="http://www.newco.dev.br/Fotos/{@peq}"/>
                                                            </xsl:if>
                                                        </xsl:for-each>
                                                    </div>
                                        </xsl:if>
									</td> 
                                   
									<td class="textLeft">
										<strong>
                                        <xsl:choose>
											<xsl:when test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/ADMIN_MVM or /MantenimientoProductos/DATOS/LISTAPRODUCTOS/ADMIN_MVMB">
 												<a>
													<xsl:attribute name="href">javascript:MantenimientoProductos('http://www.newco.dev.br/Administracion/Mantenimiento/Productos/PROManten.xsql?PRO_ID=<xsl:value-of select="IDPRODUCTO"/>&amp;TIPO=M&amp;PRO_BUSQUEDA=<xsl:value-of select="//LISTAPRODUCTOS/BUSQUEDA/PRODUCTO"/>&amp;IDCLIENTE=<xsl:value-of select="//LISTAPRODUCTOS/BUSQUEDA/IDCLIENTE"/>&amp;HISTORY='+obtenerHistoria());</xsl:attribute>
                                                    
                                                    <xsl:value-of select="NOMBRE"/>
												</a>
											</xsl:when>
											<xsl:otherwise>
												<xsl:value-of select="NOMBRE"/>
											</xsl:otherwise>
										</xsl:choose>
                                        </strong>
									</td>
									<td class="textLeft">
                                    <a>
                                     <xsl:attribute name="href">javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPDetalleFrame.xsql?EMP_ID=<xsl:value-of select="IDPROVEEDOR"/>&amp;VENTANA=NUEVA','DetalleEmpresa',90,60,0,-50)</xsl:attribute> 
    <xsl:attribute name="onMouseOver">window.status='Información sobre la empresa.';return true;</xsl:attribute>
    <xsl:attribute name="onMouseOut">window.status='';return true;</xsl:attribute>
										<xsl:value-of select="PROVEEDOR"/>
                                    </a>
									</td>
									<xsl:if test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/ADMIN_MVM or /MantenimientoProductos/DATOS/LISTAPRODUCTOS/ADMIN_MVMB">
										<td class="center">
											<xsl:choose>
												<xsl:when test="./CLIENTESADJ/field/dropDownList/listElem[2]">
													<xsl:call-template name="desplegable">
   		   										<xsl:with-param name="path" select="./CLIENTESADJ/field"/>
                                                <xsl:with-param name="claSel">select120</xsl:with-param>
   		 										</xsl:call-template>
   		 									</xsl:when>
   		 									<xsl:otherwise>
   		 										<xsl:value-of select="document($doc)/translation/texts/item[@name='ninguna_clinica']/node()"/>
   		 									</xsl:otherwise>
   		 								</xsl:choose>
										</td> 
									</xsl:if>
                                    
									<td class="center">
										<xsl:choose>
											<xsl:when test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/ADMIN_MVM or /MantenimientoProductos/DATOS/LISTAPRODUCTOS/ADMIN_MVMB">	
												<input type="text" maxlength="100" size="10" class="inright">
													<xsl:attribute name="name">MARCA_<xsl:value-of select="IDPRODUCTO"/></xsl:attribute>
													<xsl:attribute name="value"><xsl:value-of select="MARCA"/></xsl:attribute>
												</input>
											</xsl:when>
											<xsl:otherwise>
												<xsl:value-of select="MARCA"/>&nbsp;
											</xsl:otherwise>
										</xsl:choose>
									</td> 
								
									<td class="center">
										<!--quitado 11-04-12
                                        <xsl:choose>
											<xsl:when test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/ADMIN_MVM or /MantenimientoProductos/DATOS/LISTAPRODUCTOS/ADMIN_MVMB">	
												<input type="text" maxlength="100" size="13" class="inright">
													<xsl:attribute name="name">UNIDADBASICA_<xsl:value-of select="IDPRODUCTO"/></xsl:attribute>
													<xsl:attribute name="value"><xsl:value-of select="UNIDADBASICA"/></xsl:attribute>
													<xsl:attribute name="onBlur">esNulo(this);</xsl:attribute>
												</input>
											</xsl:when>
											<xsl:otherwise>-->
                                            	<input type="hidden" maxlength="100" size="13" class="inright">
													<xsl:attribute name="name">UNIDADBASICA_<xsl:value-of select="IDPRODUCTO"/></xsl:attribute>
													<xsl:attribute name="value"><xsl:value-of select="UNIDADBASICA"/></xsl:attribute>
													<xsl:attribute name="onBlur">esNulo(this);</xsl:attribute>
												</input>
												<xsl:value-of select="UNIDADBASICA"/>
											<!--</xsl:otherwise>
										</xsl:choose>-->
									</td>
									<td class="center">
										<xsl:choose>
											<xsl:when test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/ADMIN_MVM or /MantenimientoProductos/DATOS/LISTAPRODUCTOS/ADMIN_MVMB">	
												<input type="text" maxlength="10" size="4" class="inright">
													<xsl:attribute name="name">UNIDADESPORLOTE_<xsl:value-of select="IDPRODUCTO"/></xsl:attribute>
													<xsl:attribute name="value"><xsl:value-of select="UNIDADESPORLOTE"/></xsl:attribute>
													<xsl:attribute name="onBlur">esEntero(this);</xsl:attribute>
												</input>
											</xsl:when>
											<xsl:otherwise>
												<xsl:value-of select="UNIDADESPORLOTE"/>
											</xsl:otherwise>
										</xsl:choose>					
									</td>
									
									<td class="center">
										<xsl:choose>
											<xsl:when test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/ADMIN_MVM or /MantenimientoProductos/DATOS/LISTAPRODUCTOS/ADMIN_MVMB">
												<xsl:call-template name="desplegable">
              						<xsl:with-param name="path" select="IVA/field"></xsl:with-param>
            						</xsl:call-template>
											</xsl:when>
											<xsl:otherwise>
												<xsl:for-each select="IVA/field/dropDownList/listElem">
													<xsl:if test="ID=../../@current">
														<xsl:value-of select="listItem"/>
													</xsl:if>
												</xsl:for-each>
											</xsl:otherwise>
										</xsl:choose>					
									</td>
									 <!--x de expansion
									<td>
                                    	<xsl:if test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/ADMIN_MVM or /MantenimientoProductos/DATOS/LISTAPRODUCTOS/ADMIN_MVMB">
                                        	<xsl:choose>
                                            <xsl:when test="TARIFA/ORIGEN='E' or TARIFA/ORIGEN='I' or TARIFA/ORIGEN='X'">
                                                *<xsl:value-of select="TARIFA/ORIGEN"/>*
                                            </xsl:when>
                                            <xsl:otherwise>
                                            	&nbsp;
                                            </xsl:otherwise>
                                            </xsl:choose>
                                        </xsl:if>
                                    </td>-->
									<td align="right">
										<!--<xsl:choose>
											<xsl:when test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/ADMIN_MVM or /MantenimientoProductos/DATOS/LISTAPRODUCTOS/ADMIN_MVMB">
												<input type="text" maxlength="10" size="8" class="inright">
													<xsl:attribute name="name">TARIFA_<xsl:value-of select="IDPRODUCTO"/></xsl:attribute>
													<xsl:attribute name="value"><xsl:value-of select="TARIFAPRIVADA_EURO"/></xsl:attribute>
													<xsl:attribute name="onBlur">checkNumber(this.value,this);</xsl:attribute>
                                                    
													quitado antes del 11-04-12
                                                    <xsl:if test="TARIFA/ORIGEN='E' or TARIFA/ORIGEN='I'">
														<xsl:attribute name="class">deshabilitado</xsl:attribute>
														<xsl:attribute name="onFocus">this.blur();</xsl:attribute>
													</xsl:if>
                                                    hasta aqui antes del 11-04-12
												</input>
												<input type="hidden" maxlength="10" size="8" class="inright">
													<xsl:attribute name="name">BACKUPTARIFA_<xsl:value-of select="IDPRODUCTO"/></xsl:attribute>
													<xsl:attribute name="value"><xsl:value-of select="TARIFAPRIVADA_EURO"/></xsl:attribute>
												</input>
												
											</xsl:when>
											<xsl:otherwise>-->
                                            
                                       
                                            <input type="hidden" maxlength="10" size="8" class="inright">
													<xsl:attribute name="name">TARIFA_<xsl:value-of select="IDPRODUCTO"/></xsl:attribute>
													<xsl:attribute name="value"><xsl:value-of select="TARIFAPRIVADA_MVM"/></xsl:attribute>
													<xsl:attribute name="onBlur">checkNumber(this.value,this);</xsl:attribute>
                                                    
												</input>
												<input type="hidden" maxlength="10" size="8" class="inright">
													<xsl:attribute name="name">BACKUPTARIFA_<xsl:value-of select="IDPRODUCTO"/></xsl:attribute>
													<xsl:attribute name="value"><xsl:value-of select="TARIFAPRIVADA_MVM"/></xsl:attribute>
												</input>
												
                                            <!--si precios emplantillados veo precio, si no bola ambar con title precio 18-12-12-->
											<xsl:if test="TARIFAPRIVADA_MVM">
                                                <xsl:choose>
                                                <xsl:when test="EMPLANTILLADO_EN_MVM">
                                                    <xsl:choose>
                                                    <xsl:when test="MVM_TARIFA_ALTA">
                                                       <span class="fondoRojo"><xsl:value-of select="TARIFAPRIVADA_MVM"/></span>
                                                     </xsl:when>
                                                     <xsl:otherwise>
                                                        <xsl:value-of select="TARIFAPRIVADA_MVM"/>
                                                     </xsl:otherwise>
                                                     </xsl:choose>
                                                 </xsl:when>
                                                 <xsl:otherwise>
                                                    <a title="{TARIFAPRIVADA_MVM}">
                                                    	<img src="http://www.newco.dev.br/images/iconoTransp.gif" alt="{TARIFAPRIVADA_MVM}"/>
                                                     </a>
                                                 </xsl:otherwise>
                                                 </xsl:choose>
                                             </xsl:if>
                                             
                                             <!--<xsl:if test="EMPLANTILLADO_EN_MVM">&nbsp;<strong><span class="verde">M</span></strong></xsl:if>
                                              
											</xsl:otherwise>
										</xsl:choose>-->
                                    </td>
                                    <!-- <td>
                                   check expansion
									<xsl:if test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/ADMIN_MVM or /MantenimientoProductos/DATOS/LISTAPRODUCTOS/ADMIN_MVMB">
                                    	<xsl:choose>
													<xsl:when test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/CLIENTES/field/@current=1">
														<input type="checkbox" name="EXPANDIR_{IDPRODUCTO}"/>
													</xsl:when>
													<xsl:otherwise>
														<input type="checkbox" name="EXPANDIR_{IDPRODUCTO}">
															<xsl:choose>
																<xsl:when test="TARIFA/ORIGEN='E' or TARIFA/ORIGEN='I'">
																	<xsl:attribute name="checked">checked</xsl:attribute>
																	<xsl:attribute name="onClick">ExpandirNOExpandir(document.forms['Productos'],this,'ANTERIOR');</xsl:attribute>
																</xsl:when>
																<xsl:otherwise>
																	<xsl:attribute name="onClick">ExpandirNOExpandir(document.forms['Productos'],this,'MVM');</xsl:attribute>
																</xsl:otherwise>
															</xsl:choose>
														</input>
													</xsl:otherwise>
												</xsl:choose>
                                    </xsl:if>
									</td> -->
                                    <input type="hidden" name="EXPANDIR_{IDPRODUCTO}" value="N" />
                                    <xsl:if test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/ADMIN_MVM and /MantenimientoProductos/DATOS/LISTAPRODUCTOS/IDPAIS = '34'">
                                    <!--precio asisa-->
										<td class="center">
                                        <xsl:if test="TARIFAPRIVADA_ASISA">
                                                <xsl:choose>
                                                <xsl:when test="EMPLANTILLADO_EN_ASISA">
                                                    <xsl:choose>
                                                    <xsl:when test="ASISA_TARIFA_ALTA">
                                                       <span class="fondoRojo"><xsl:value-of select="TARIFAPRIVADA_ASISA"/></span>
                                                     </xsl:when>
                                                     <xsl:otherwise>
                                                        <xsl:value-of select="TARIFAPRIVADA_ASISA"/>
                                                     </xsl:otherwise>
                                                     </xsl:choose>
                                                </xsl:when>
                                                <xsl:otherwise>
                                                    <a title="{TARIFAPRIVADA_ASISA}">
                                                    	<img src="http://www.newco.dev.br/images/iconoTransp.gif" alt="{TARIFAPRIVADA_ASISA}"/>
                                                     </a>
                                                 </xsl:otherwise>
                                           		</xsl:choose>
                                         </xsl:if>
                                         <!--<xsl:if test="EMPLANTILLADO_EN_ASISA">&nbsp;<strong><span class="verde">A</span></strong></xsl:if>-->
                                        </td><!--fin de precio asisa-->
                                         <!--precio fncp-->
										<td class="center">
                                         <xsl:if test="TARIFAPRIVADA_FNCP">
                                                <xsl:choose>
                                                <xsl:when test="EMPLANTILLADO_EN_FNCP">
                                                    <xsl:choose>
                                                      <xsl:when test="FNCP_TARIFA_ALTA">
                                                       <span class="fondoRojo"><xsl:value-of select="TARIFAPRIVADA_FNCP"/></span>
                                                     </xsl:when>
                                                     <xsl:otherwise>
                                                        <xsl:value-of select="TARIFAPRIVADA_FNCP"/>
                                                     </xsl:otherwise>
                                                     </xsl:choose>
                                                </xsl:when>
                                                 <xsl:otherwise>
                                                    <a title="{TARIFAPRIVADA_FNCP}">
                                                    	<img src="http://www.newco.dev.br/images/iconoTransp.gif" alt="{TARIFAPRIVADA_FNCP}"/>
                                                     </a>
                                                 </xsl:otherwise>
                                           		</xsl:choose>
                                         </xsl:if>
                                          <!--<xsl:if test="EMPLANTILLADO_EN_FNCP">&nbsp;<strong><span class="verde">F</span></strong></xsl:if>-->
                                        </td><!--fin de precio fncp-->
                                    <!--precio viamed-->
										<td class="center">
                                        <xsl:if test="TARIFAPRIVADA_VIAMED">
                                                <xsl:choose>
                                                <xsl:when test="EMPLANTILLADO_EN_VIAMED">
                                                    <xsl:choose>
                                                    <xsl:when test="VIAMED_TARIFA_ALTA">
                                                       <span class="fondoRojo"><xsl:value-of select="TARIFAPRIVADA_VIAMED"/></span>
                                                     </xsl:when>
                                                     <xsl:otherwise>
                                                        <xsl:value-of select="TARIFAPRIVADA_VIAMED"/>
                                                     </xsl:otherwise>
                                                     </xsl:choose>
                                                </xsl:when>
                                                <xsl:otherwise>
                                                    <a title="{TARIFAPRIVADA_VIAMED}">
                                                    	<img src="http://www.newco.dev.br/images/iconoTransp.gif" alt="{TARIFAPRIVADA_VIAMED}"/>
                                                     </a>
                                                 </xsl:otherwise>
                                           		</xsl:choose>
                                         </xsl:if>
                                         <!--<xsl:if test="EMPLANTILLADO_EN_VIAMED">&nbsp;<strong><span class="verde">V</span></strong></xsl:if>-->
                                        </td><!--fin de precio viamed-->
                                        
                                        <!--precio teknon-->
										<td class="center">
                                        <xsl:if test="TARIFAPRIVADA_TEKNON">
                                                <xsl:choose>
                                                <xsl:when test="EMPLANTILLADO_EN_TEKNON">
                                                    <xsl:choose>
                                                    <xsl:when test="TEKNON_TARIFA_ALTA">
                                                       <span class="fondoRojo"><xsl:value-of select="TARIFAPRIVADA_TEKNON"/></span>
                                                     </xsl:when>
                                                     <xsl:otherwise>
                                                        <xsl:value-of select="TARIFAPRIVADA_TEKNON"/>
                                                     </xsl:otherwise>
                                                     </xsl:choose>
                                                </xsl:when>
                                                <xsl:otherwise>
                                                    <a title="{TARIFAPRIVADA_TEKNON}">
                                                    	<img src="http://www.newco.dev.br/images/iconoTransp.gif" alt="{TARIFAPRIVADA_TEKNON}"/>
                                                     </a>
                                                 </xsl:otherwise>
                                           		</xsl:choose>
                                         </xsl:if>
                                         <!--<xsl:if test="EMPLANTILLADO_EN_TEKNON">&nbsp;<strong><span class="verde">T</span></strong></xsl:if>-->
                                        </td><!--fin de precio TEKNON-->
                                        
                                     </xsl:if><!--fin if si es españa-->
                                    <!--precio_anterior fecha
									<xsl:if test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/ADMIN_MVM or /MantenimientoProductos/DATOS/LISTAPRODUCTOS/ADMIN_MVMB">
										<td class="center">
                                        	<xsl:choose>
											<xsl:when test="TARIFA_HISTORICA/PRECIO_FORMATO!=''">
												<xsl:value-of select="TARIFA_HISTORICA/PRECIO_FORMATO"/>
                                                <br /><xsl:value-of select="TARIFA_HISTORICA/FECHA"/>
											</xsl:when>
                                            <xsl:otherwise>
                                            	<xsl:value-of select="FECHAALTA"/>
                                            </xsl:otherwise>
                                            </xsl:choose>
											<input type="hidden" name="TARIFAHISTORICA_{IDPRODUCTO}" value="{TARIFA_HISTORICA/PRECIO}"/>
											<input type="hidden" name="TARIFAPRIVADAMVM_{IDPRODUCTO}" value="{TARIFAPRIVADA_MVM}"/>
										</td> 
									</xsl:if> -->
									<xsl:if test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/ADMIN_MVM or /MantenimientoProductos/DATOS/LISTAPRODUCTOS/ADMIN_MVMB">
										<td class="center" align="right"><xsl:value-of select="CONSUMO"/>&nbsp;</td> 
									</xsl:if>
									<xsl:if test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/ADMIN_MVM or /MantenimientoProductos/DATOS/LISTAPRODUCTOS/ADMIN_MVMB">	
										<td class="center">
											<input type="checkbox">
												<xsl:attribute name="name">BORRAR_<xsl:value-of select="IDPRODUCTO"/></xsl:attribute>
											</input>
										</td>
									</xsl:if> 
									<xsl:if test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/ADMIN_MVM or /MantenimientoProductos/DATOS/LISTAPRODUCTOS/ADMIN_MVMB">
										<td class="center">
											<input type="checkbox">
												<xsl:attribute name="name">COPIAR_<xsl:value-of select="IDPRODUCTO"/></xsl:attribute>
											</input>
                                            
                                             <input type="checkbox" class="destInput" style="display:none;">
                                              <xsl:if test="DESTACADO = 'S'">
                                              	<xsl:attribute name="checked">checked</xsl:attribute>
                                              </xsl:if>
                                            	
												<xsl:attribute name="name">DESTACAR_<xsl:value-of select="IDPRODUCTO"/></xsl:attribute>
											</input>
                                   			<input type="checkbox" class="destInput" style="display:none;">
                                              <xsl:if test="OCULTO = 'S'">
                                              	<xsl:attribute name="checked">checked</xsl:attribute>
                                              </xsl:if>
                                            	
												<xsl:attribute name="name">OCULTAR_<xsl:value-of select="IDPRODUCTO"/></xsl:attribute>
											</input>
										</td> 
									</xsl:if> 
                                    <!--<xsl:if test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/ADMIN_MVM or /MantenimientoProductos/DATOS/LISTAPRODUCTOS/ADMIN_MVMB">
										<td class="center">
											<input type="checkbox" class="destInput">
                                              <xsl:if test="DESTACADO = 'S'">
                                              	<xsl:attribute name="checked">checked</xsl:attribute>
                                              </xsl:if>
                                            	
												<xsl:attribute name="name">DESTACAR_<xsl:value-of select="IDPRODUCTO"/></xsl:attribute>
											</input>
										</td> 
									</xsl:if> 
                                    <xsl:if test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/ADMIN_MVM or /MantenimientoProductos/DATOS/LISTAPRODUCTOS/ADMIN_MVMB">
										<td class="center">
											<input type="checkbox" class="destInput">
                                              <xsl:if test="OCULTO = 'S'">
                                              	<xsl:attribute name="checked">checked</xsl:attribute>
                                              </xsl:if>
                                            	
												<xsl:attribute name="name">OCULTAR_<xsl:value-of select="IDPRODUCTO"/></xsl:attribute>
											</input>
										</td> 
									</xsl:if> -->
                                   
								</tr>
		  				</xsl:for-each>	   
                   </tbody>
                   <!--repetimos nombre columnas-->
                     <tr class="titulos" style="border-bottom:1px solid grey;">
								<th class="cinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='referencia']/node()"/></th>
                                <th class="dos"><xsl:value-of select="document($doc)/translation/texts/item[@name='ima']/node()"/></th>
								<th><xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/></th>
								<th><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/></th>
								<xsl:if test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/ADMIN_MVM or /MantenimientoProductos/DATOS/LISTAPRODUCTOS/ADMIN_MVMB">
									<th class="dies"><xsl:value-of select="document($doc)/translation/texts/item[@name='adjudicado']/node()"/></th>
								</xsl:if>
								<th class="tres"><xsl:value-of select="document($doc)/translation/texts/item[@name='marca']/node()"/></th>
								<th class="ocho"><xsl:value-of select="document($doc)/translation/texts/item[@name='ud_base']/node()"/></th>
								<th class="tres"><xsl:copy-of select="document($doc)/translation/texts/item[@name='ud_por_caja_2line']/node()"/></th>
								<th class="tres"><xsl:value-of select="document($doc)/translation/texts/item[@name='iva']/node()"/></th>
								<!--quitado 11-04-12
                                <xsl:choose>
									<xsl:when test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/ADMIN_MVM or /MantenimientoProductos/DATOS/LISTAPRODUCTOS/ADMIN_MVMB">
										<th class="dies" colspan="3" >
											<xsl:value-of select="document($doc)/translation/texts/item[@name='precio_expans']/node()"/><br />
											<a href="javascript:ExpandirNOExpandirTodos(document.forms['formBusca']);">
												<xsl:value-of select="document($doc)/translation/texts/item[@name='todos']/node()"/>
											</a>
										</th>
									</xsl:when>
									<xsl:otherwise>-->
										<th class="cinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='precio']/node()"/>
                                        <xsl:if test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/ADMIN_MVM and /MantenimientoProductos/DATOS/LISTAPRODUCTOS/IDPAIS = '34'">
                                         	<br /><xsl:value-of select="document($doc)/translation/texts/item[@name='mvm']/node()"/>
                                        </xsl:if>
                                        </th>
                                        
									<!--</xsl:otherwise>
								</xsl:choose>-->
                                <!--precio asisa,fncp, viamed, teknon-->
                                <xsl:if test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/ADMIN_MVM and /MantenimientoProductos/DATOS/LISTAPRODUCTOS/IDPAIS = '34'">
									<th class="cuatro"><xsl:copy-of select="document($doc)/translation/texts/item[@name='precio_asisa']/node()"/></th>
                                    <th class="cuatro"><xsl:copy-of select="document($doc)/translation/texts/item[@name='precio_fncp']/node()"/></th>
                                    <th class="cuatro"><xsl:copy-of select="document($doc)/translation/texts/item[@name='precio_viamed']/node()"/></th>
                                    <th class="cuatro"><xsl:copy-of select="document($doc)/translation/texts/item[@name='precio_teknon']/node()"/></th>
								</xsl:if>
								<!--<xsl:if test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/ADMIN_MVM or /MantenimientoProductos/DATOS/LISTAPRODUCTOS/ADMIN_MVMB">
									<th class="cuatro"><xsl:copy-of select="document($doc)/translation/texts/item[@name='precio_anterior_fecha_2line']/node()"/></th>
								</xsl:if>-->
								<xsl:if test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/ADMIN_MVM or /MantenimientoProductos/DATOS/LISTAPRODUCTOS/ADMIN_MVMB">
									<th class="dos"><xsl:copy-of select="document($doc)/translation/texts/item[@name='consumo_euros_2line']/node()"/></th>
								</xsl:if>
								<xsl:if test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/ADMIN_MVM or /MantenimientoProductos/DATOS/LISTAPRODUCTOS/ADMIN_MVMB">
									<th class="uno"><xsl:value-of select="document($doc)/translation/texts/item[@name='bor']/node()"/><br /><a href="javascript:SelTodosBorrar();"><xsl:value-of select="document($doc)/translation/texts/item[@name='todos']/node()"/></a></th>
								</xsl:if>
								<xsl:if test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/ADMIN_MVM or /MantenimientoProductos/DATOS/LISTAPRODUCTOS/ADMIN_MVMB">
									<th class="uno"><xsl:value-of select="document($doc)/translation/texts/item[@name='cop']/node()"/></th>
								</xsl:if>
                                <!--
                                <xsl:if test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/ADMIN_MVM or /MantenimientoProductos/DATOS/LISTAPRODUCTOS/ADMIN_MVMB">
									<th class="uno"><xsl:value-of select="document($doc)/translation/texts/item[@name='dest']/node()"/><br /><a href="javascript:SelTodosDestacados();"><xsl:value-of select="document($doc)/translation/texts/item[@name='todos']/node()"/></a></th>
								</xsl:if>
                                <xsl:if test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/ADMIN_MVM or /MantenimientoProductos/DATOS/LISTAPRODUCTOS/ADMIN_MVMB">
									<th class="uno"><xsl:value-of select="document($doc)/translation/texts/item[@name='ocu']/node()"/><br /><a href="javascript:SelTodosOcultos();"><xsl:value-of select="document($doc)/translation/texts/item[@name='todos']/node()"/></a></th>
								</xsl:if>-->
							</tr>
                   <tfoot>
                <tr class="lejenda">
				<th colspan="7" class="textLeft">
					<xsl:value-of select="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/MENSAJE"/>
				</th>
                <th colspan="10" class="textRight">
                 <xsl:if test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/ADMIN_MVM or /MantenimientoProductos/DATOS/LISTAPRODUCTOS/ADMIN_MVMB">
                	  <div class="boton">
                        	<a href="javascript:Enviar(document.forms[1],document.forms[0],'ACTUALIZAR');">
                            	<xsl:value-of select="document($doc)/translation/texts/item[@name='actualizar']/node()"/>
                     		</a>
                        </div>
                 </xsl:if>
                    <xsl:if test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/PAGINAANTERIOR">
                        <a href="javascript:Enviar(document.forms['formBusca'],'ANTERIOR');">
                           <img src="http://www.newco.dev.br/images/flechaLeft.gif" /></a>
                        <a href="javascript:Enviar(document.forms['formBusca'],'ANTERIOR');"><xsl:value-of select="document($doc)/translation/texts/item[@name='anterior']/node()"/></a>
                    </xsl:if>
                    <xsl:if test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/PAGINASIGUIENTE">
                         &nbsp;&nbsp;&nbsp;
                         <a href="javascript:Enviar(document.forms['formBusca'],'SIGUIENTE');" title="siguiente"><xsl:value-of select="document($doc)/translation/texts/item[@name='siguiente']/node()"/></a>
                         <a href="javascript:Enviar(document.forms['formBusca'],'SIGUIENTE');" title="siguiente"><img src="http://www.newco.dev.br/images/flechaRight.gif" /></a>
					</xsl:if>
                 </th>
			</tr>         
          </tfoot>
     </table> 
						
 </xsl:when>
 <xsl:otherwise> 
 <!--solicitudes de proveedores-->
 <!--productos nuevos o modificado del proveedor mvm acepta o no
      	  		<input type="hidden" name="CAMBIOS" />
                <input type="hidden" name="US_ID_CAMBIO" value="{//LISTAPRODUCTOS/IDCLIENTE}" />-->
                
            <table class="encuesta" border="0">
            <thead>
            <xsl:if test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/ADMIN_MVM or /MantenimientoProductos/DATOS/LISTAPRODUCTOS/ADMIN_MVMB">
            
                <tr class="lejenda">  
                    <td colspan="5">
                       <p style="align:left; font-weight:normal; margin-left:5px;">
                        <img src="http://www.newco.dev.br/images/cuadroRojo.gif" />&nbsp;
                        <span class="font11"><xsl:value-of select="document($doc)/translation/texts/item[@name='precios_diferentes']/node()"/></span>
                        </p>
                      </td>
                	 <td colspan="3">
                     <xsl:if test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/ADMIN_MVM">
                       <p style="align:left; font-weight:normal; margin-left:5px;">
                        &nbsp;<span class="verde">A</span>&nbsp;&nbsp;
                        <span class="font11"><xsl:value-of select="document($doc)/translation/texts/item[@name='adjudicado_asisa']/node()"/></span>
                        <br />
                        &nbsp;<span class="verde">F</span>&nbsp;&nbsp;
                        <span class="font11"><xsl:value-of select="document($doc)/translation/texts/item[@name='adjudicado_fncp']/node()"/></span>
                	  </p>
                      </xsl:if>
                      </td>
                      <td colspan="4">
                      <xsl:if test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/ADMIN_MVM">
                       <p style="align:left; font-weight:normal; margin-left:5px;">
                        &nbsp;<span class="verde">V</span>&nbsp;&nbsp;
                        <span class="font11"><xsl:value-of select="document($doc)/translation/texts/item[@name='adjudicado_viamed']/node()"/></span>
                        <br />
                        &nbsp;<span class="verde">T</span>&nbsp;&nbsp;
                        <span class="font11"><xsl:value-of select="document($doc)/translation/texts/item[@name='adjudicado_teknon']/node()"/></span>
                	  </p>
                      </xsl:if>
                      </td>
                      <td colspan="5">
                      <div class="boton">
                      	<a href="PROManten.xsql"><xsl:value-of select="document($doc)/translation/texts/item[@name='nuevo_producto']/node()"/></a>
                      </div>
                    </td>
                    <td colspan="4">&nbsp; </td>
                    <td colspan="2">
                      <div class="boton">
                      	<a href="javascript:AceptarCambios(document.forms['formBusca'])"><xsl:value-of select="document($doc)/translation/texts/item[@name='aceptar_cambios']/node()"/></a>
                      </div>
                    </td>
                </tr>
            </xsl:if>
            <tr class="lejenda">
				<th colspan="11" class="textLeft">
					<xsl:value-of select="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/MENSAJE"/>
				</th>
                <th colspan="12" class="textRight">
                    <xsl:if test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/PAGINAANTERIOR">
                        <a href="javascript:Enviar(document.forms['formBusca'],'ANTERIOR');"><img src="http://www.newco.dev.br/images/flechaLeft.gif" /></a> 
                       <a href="javascript:Enviar(document.forms['formBusca'],'ANTERIOR');"><xsl:value-of select="document($doc)/translation/texts/item[@name='anterior']/node()"/></a>
                    </xsl:if>
                    <xsl:if test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/PAGINASIGUIENTE">
                         &nbsp;&nbsp;&nbsp;
                         <a href="javascript:Enviar(document.forms['formBusca'],'SIGUIENTE');" title="siguiente"><xsl:value-of select="document($doc)/translation/texts/item[@name='siguiente']/node()"/></a>
                         <a href="javascript:Enviar(document.forms['formBusca'],'SIGUIENTE');" title="siguiente"><img src="http://www.newco.dev.br/images/flechaRight.gif" /></a>
					</xsl:if>
                 </th>
			</tr>
      	    <tr class="titulos">
								<th class="seis"><a href="javascript:OrdenarPor('REFERENCIA');"><xsl:value-of select="document($doc)/translation/texts/item[@name='referencia']/node()"/></a></th>
                                <th class="dos"><xsl:value-of select="document($doc)/translation/texts/item[@name='ima']/node()"/></th>
                                <th class="dos"></th>
								<th class="quince"><a href="javascript:OrdenarPor('PRODUCTO');"><xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/></a></th>
                                <th class="ocho"><a href="javascript:OrdenarPor('PROVEEDOR');"><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/></a></th>
								<th class="cinco"><a href="javascript:OrdenarPor('MARCA');"><xsl:value-of select="document($doc)/translation/texts/item[@name='marca']/node()"/></a></th>
								<th class="ocho"><xsl:value-of select="document($doc)/translation/texts/item[@name='ud_base']/node()"/></th>
								<th class="cinco"><xsl:copy-of select="document($doc)/translation/texts/item[@name='ud_por_caja_2line']/node()"/></th>
								<th class="cinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='iva']/node()"/></th>
                                <!--precio anterior mvm, si españa(34) no enseño, proveedores ya no pueden cambiar precio mvm, si brasil enseño, solo un precio-->
                                	<xsl:choose>
                                	 <xsl:when test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/IDPAIS = '34'"> 
                                     	<th class="uno">
                                		<!--<xsl:copy-of select="document($doc)/translation/texts/item[@name='anterior_mvm']/node()"/>-->
                                        </th>
                                	 </xsl:when>
                                     <xsl:otherwise>
                                     	<th class="cinco">
                                        <xsl:copy-of select="document($doc)/translation/texts/item[@name='precio_anterior']/node()"/>
                                        </th>
                                     </xsl:otherwise>
                                     </xsl:choose>
                                <!--precio propuesto, si españa(34) no enseño, proveedores ya no pueden cambiar precio mvm, si brasil enseño, solo un precio-->
                                <xsl:choose>
                                	 <xsl:when test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/IDPAIS = '34'">
                                     	<th class="uno"> 
                                		<!--<xsl:copy-of select="document($doc)/translation/texts/item[@name='propuesto_mvm']/node()"/>-->
                                     	</th> 
                                	 </xsl:when>
                                     <xsl:otherwise>
                                     	<th class="cinco"> 
                                        <xsl:copy-of select="document($doc)/translation/texts/item[@name='precio_propuesto']/node()"/>
                                        </th>
                                     </xsl:otherwise>
                                </xsl:choose>
                                
                                <!--precio asisa solo si españa-->
                                <xsl:choose>
                                <xsl:when test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/IDPAIS = '34'"> 
                                <th class="cinco">
                                	<xsl:copy-of select="document($doc)/translation/texts/item[@name='anterior_asisa']/node()"/>
                                </th> 
                                <th class="cinco">
                                	<xsl:copy-of select="document($doc)/translation/texts/item[@name='propuesto_asisa']/node()"/>
                                </th> 
                                 <th class="cinco">
                                	<xsl:copy-of select="document($doc)/translation/texts/item[@name='anterior_fncp']/node()"/>
                                </th> 
                                <th class="cinco">
                                	<xsl:copy-of select="document($doc)/translation/texts/item[@name='propuesto_fncp']/node()"/>
                                </th> 
                                <th class="cinco">
                                	<xsl:copy-of select="document($doc)/translation/texts/item[@name='anterior_viamed']/node()"/>
                                </th> 
                                <th class="cinco">
                                	<xsl:copy-of select="document($doc)/translation/texts/item[@name='propuesto_viamed']/node()"/>
                                </th> 
                                 <th class="cinco">
                                	<xsl:copy-of select="document($doc)/translation/texts/item[@name='anterior_teknon']/node()"/>
                                </th> 
                                <th class="cinco">
                                	<xsl:copy-of select="document($doc)/translation/texts/item[@name='propuesto_teknon']/node()"/>
                                </th> 
                                </xsl:when>
                                <xsl:otherwise>
                                	<th colspan="2" class="uno"></th>
                                	<th colspan="2" class="uno"></th>
                                    <th colspan="2" class="uno"></th>
                                	<th colspan="2" class="uno"></th>
                                </xsl:otherwise>
                                </xsl:choose>
                                <!--columna para cambios de ficha tecnica o oferta-->
                                <th class="tres">&nbsp;</th>
								<xsl:if test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/ADMIN_MVM or /MantenimientoProductos/DATOS/LISTAPRODUCTOS/ADMIN_MVMB">
									<th class="cinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='acep']/node()"/><br /><a href="javascript:SelTodosAceptar();"><xsl:value-of select="document($doc)/translation/texts/item[@name='todos']/node()"/></a></th>
								</xsl:if>
								<xsl:if test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/ADMIN_MVM or /MantenimientoProductos/DATOS/LISTAPRODUCTOS/ADMIN_MVMB">
									<th class="cinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='rechazar']/node()"/><br /><a href="javascript:SelTodosCancelar();"><xsl:value-of select="document($doc)/translation/texts/item[@name='todos']/node()"/></a></th>
								</xsl:if>
                               
                                <xsl:if test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/ADMIN_MVM or /MantenimientoProductos/DATOS/LISTAPRODUCTOS/ADMIN_MVMB">
									<th class="cinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='comentarios']/node()"/></th>
								</xsl:if>
							</tr>
                  </thead>
							<!--	Cuerpo de la tabla	-->
                <tbody>
      	    	<xsl:for-each select="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/PRODUCTO">
                	<input type="hidden" name="IDPROD_{IDPRODUCTO}" value="{IDPRODUCTO}"/>
      	      	<tr>
									<td class="center">
                                  
                                    	<p>
                                         <xsl:attribute name="class"><xsl:if test="CAMBIOS/REFERENCIA">amarillo</xsl:if> </xsl:attribute>
										<xsl:value-of select="REFERENCIA"/>
                                        </p>
									</td> 
                                    <td>
                                        
										<xsl:if test="(count(IMAGENES/IMAGEN)) &gt; 0">
                                            <xsl:variable name="idRef" select="REFERENCIA" />
                                                   <p>
                                                   <xsl:attribute name="class"><xsl:if test="CAMBIOS/NOMBRE">amarillo</xsl:if> </xsl:attribute>
                                                    <img src="../../../images/fotoListadoPeq.gif" alt="con foto" id="{$idRef}" onmouseover="verFoto('{$idRef}');" onmouseout="verFoto('{$idRef}');" />
                                                    </p>
                                                   
                                                    <div id="verFotoPro_{$idRef}" class="divFotoProBusca" style="display:none;">
                                                        <xsl:for-each select="IMAGENES/IMAGEN">
                                                            <xsl:if test="@id != '-1'">
                                                            <img src="http://www.newco.dev.br/Fotos/{@peq}"/>
                                                            </xsl:if>
                                                        </xsl:for-each>
                                                    </div>
                                        </xsl:if>
									</td> 
                                    <td>
                                    	<xsl:if test="ESTADO = 'X'">
                                        	<img src="http://www.newco.dev.br/images/basura.gif" alt="Eliminar prod" title="eliminar" />
                                        </xsl:if>
                                    </td>
									<td class="textLeft">
										<strong>
                                        <xsl:choose>
											<xsl:when test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/ADMIN_MVM or /MantenimientoProductos/DATOS/LISTAPRODUCTOS/ADMIN_MVMB">
 												<a>
                                                <xsl:attribute name="href">javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Productos/PRODetalle.xsql?PRO_ID=<xsl:value-of select="IDPRODUCTO"/>','producto',70,50,0,-50);
                                                </xsl:attribute>
                                                <xsl:attribute name="class">
                                                    <xsl:if test="CAMBIOS/NOMBRE">amarillo</xsl:if>
                                                </xsl:attribute>
                                                     <xsl:value-of select="NOMBRE"/>
												</a>
											</xsl:when>
											<xsl:otherwise>
												<xsl:value-of select="NOMBRE"/>
											</xsl:otherwise>
										</xsl:choose>
                                        </strong>
									</td>
									<td class="center">
                                      <a>
                                     <xsl:attribute name="href">javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPDetalleFrame.xsql?EMP_ID=<xsl:value-of select="IDPROVEEDOR"/>&amp;VENTANA=NUEVA','DetalleEmpresa',90,60,0,-50)</xsl:attribute> 
    <xsl:attribute name="onMouseOver">window.status='Información sobre la empresa.';return true;</xsl:attribute>
    <xsl:attribute name="onMouseOut">window.status='';return true;</xsl:attribute>
										<xsl:value-of select="PROVEEDOR"/>&nbsp;
                                      </a>
									</td> 
									<td class="center">
										<p>
                                         <xsl:attribute name="class"><xsl:if test="CAMBIOS/MARCA">amarillo</xsl:if> </xsl:attribute>
                                         <xsl:value-of select="MARCA"/>&nbsp;
                                         </p>
									</td> 
								
									<td class="center">
                                    	<p>
                                         <!--<xsl:attribute name="class"><xsl:if test="CAMBIOS/UNIDADBASICA">amarillo</xsl:if> </xsl:attribute>-->
											<xsl:value-of select="UNIDADBASICA"/>
                                        </p>
									</td>
									<td class="center">
                                    	<p>
                                         <xsl:attribute name="class"><xsl:if test="CAMBIOS/UNIDADESPORLOTE">amarillo</xsl:if> </xsl:attribute>
										<xsl:value-of select="UNIDADESPORLOTE"/>
                                       </p>
									</td>
									<td class="center">
                                    	<p>
                                         <xsl:attribute name="class"><xsl:if test="CAMBIOS/TIPOIVA">amarillo</xsl:if></xsl:attribute>
                                         
												<xsl:for-each select="IVA/field/dropDownList/listElem">
													<xsl:if test="ID=../../@current">
														<xsl:value-of select="listItem"/>
													</xsl:if>
												</xsl:for-each>
                                       </p>
									</td>
									<td class="center">
                                    	<!--si es españa no enseño precio mvm, provee no npueden cambiarlo, 2-10-13-->
                                    	<xsl:if test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/IDPAIS != '34'">
											<xsl:value-of select="TARIFAORIGINAL_MVM"/>
                                        </xsl:if>
									</td>
									<td class="center">
                                    <!--si es españa no enseño precio mvm, provee no npueden cambiarlo, 2-10-13-->
                                    	<xsl:if test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/IDPAIS != '34'">
                                    <!--precio propuesto si igual al anterior no escribo, si sube rojo, si baja verde-->
                                    	<xsl:choose>
                                        <xsl:when test="MANTIENE_TARIFA">
                                        	&nbsp;
                                        </xsl:when>
                                         <xsl:when test="SUBIDA_TARIFA">
                                         	<img src="http://www.newco.dev.br/images/order_a_rojo.gif"/>
                                         	<!--<span class="rojoNormal"><xsl:value-of select="TARIFAPRIVADA_EURO"/></span>-->
                                        </xsl:when>
                                         <xsl:when test="BAJADA_TARIFA">
                                         	<img src="http://www.newco.dev.br/images/order_d_verde.gif"/>
                                         	<!--<span class="verdeNormal"><xsl:value-of select="TARIFAPRIVADA_EURO"/></span>-->
                                        </xsl:when>
                                        </xsl:choose>
                                        <xsl:value-of select="TARIFAPRIVADA_EURO"/>
                                        </xsl:if>
									</td>
                                     <!--precio anterior asisa solo si españa-->
                                    <td class="center">  
                                    <xsl:if test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/IDPAIS = '34'">
                                        	<xsl:value-of select="TARIFAORIGINAL_ASISA"/>
                                     </xsl:if>
									</td>
                                    <!--precio asisa solo si españa-->
                                    <td class="center">  
                                    <xsl:choose>
                                    <xsl:when test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/IDPAIS = '34'">
                                    	<xsl:choose>
                                        <xsl:when test="MANTIENE_TARIFA_ASISA">
                                        	&nbsp;
                                        </xsl:when>
                                         <xsl:when test="SUBIDA_TARIFA_ASISA">
                                         	<img src="http://www.newco.dev.br/images/order_a_rojo.gif"/>
                                        </xsl:when>
                                         <xsl:when test="BAJADA_TARIFA_ASISA">
                                         	<img src="http://www.newco.dev.br/images/order_d_verde.gif"/>
                                        </xsl:when>
                                        </xsl:choose>
                                    	<!--precio asisa si differente de mvm rojo-->
                                          <xsl:choose>
                                            <xsl:when test="TARIFAPRIVADA_EURO != TARIFAPRIVADA_ASISA">
                                                <span class="fondoRojo">
                                                <xsl:value-of select="TARIFAPRIVADA_ASISA"/>
                                                </span>
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <xsl:value-of select="TARIFAPRIVADA_ASISA"/>
                                            </xsl:otherwise>
                                          </xsl:choose>
                                          <!--fin precio asisa si differente de mvm amarillo-->
                                      </xsl:when>
                                      </xsl:choose>
                                      <xsl:if test="CAMBIOS/EMPLANTILLADO_EN_ASISA">&nbsp;<strong><span class="verde">A</span></strong></xsl:if>
									</td>
                                    <!--precio anterior fncp solo si españa-->
                                    <td class="center">  
                                    <xsl:if test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/IDPAIS = '34'">
                                        	<xsl:value-of select="TARIFAORIGINAL_FNCP"/>
                                     </xsl:if>
									</td>
                                    <!--precio FNCP solo si españa-->
                                    <td class="center">  
                                    <xsl:choose>
                                    <xsl:when test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/IDPAIS = '34'">
                                    	<xsl:choose>
                                        <xsl:when test="MANTIENE_TARIFA_FNCP">
                                        	&nbsp;
                                        </xsl:when>
                                         <xsl:when test="SUBIDA_TARIFA_FNCP">
                                         	<img src="http://www.newco.dev.br/images/order_a_rojo.gif"/>
                                        </xsl:when>
                                         <xsl:when test="BAJADA_TARIFA_FNCP">
                                         	<img src="http://www.newco.dev.br/images/order_d_verde.gif"/>
                                        </xsl:when>
                                        </xsl:choose>
                                    	<!--precio asisa si differente de mvm rojo-->
                                          <xsl:choose>
                                            <xsl:when test="TARIFAPRIVADA_EURO != TARIFAPRIVADA_FNCP">
                                                <span class="fondoRojo">
                                                <xsl:value-of select="TARIFAPRIVADA_FNCP"/>
                                                </span>
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <xsl:value-of select="TARIFAPRIVADA_FNCP"/>
                                            </xsl:otherwise>
                                          </xsl:choose>
                                          <!--fin precio FNCP si differente de mvm amarillo-->
                                      </xsl:when>
                                      </xsl:choose>
                                      <xsl:if test="CAMBIOS/EMPLANTILLADO_EN_FNCP">&nbsp;<strong><span class="verde">F</span></strong></xsl:if>
									</td>
                                    <!--precio anterior viamed solo si españa-->
                                    <td class="center">  
                                    <xsl:if test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/IDPAIS = '34'">
                                        	<xsl:value-of select="TARIFAORIGINAL_VIAMED"/>
                                     </xsl:if>
									</td>
                                    <!--precio viamed solo si españa-->
                                    <td class="center">  
                                    <xsl:choose>
                                    <xsl:when test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/IDPAIS = '34'">
                                    	<xsl:choose>
                                        <xsl:when test="MANTIENE_TARIFA_VIAMED">
                                        	&nbsp;
                                        </xsl:when>
                                         <xsl:when test="SUBIDA_TARIFA_VIAMED">
                                         	<img src="http://www.newco.dev.br/images/order_a_rojo.gif"/>
                                        </xsl:when>
                                         <xsl:when test="BAJADA_TARIFA_VIAMED">
                                         	<img src="http://www.newco.dev.br/images/order_d_verde.gif"/>
                                        </xsl:when>
                                        </xsl:choose>
                                    	<!--precio VIAMED si diferente de mvm rojo-->
                                          <xsl:choose>
                                            <xsl:when test="TARIFAPRIVADA_EURO != TARIFAPRIVADA_VIAMED">
                                                <span class="fondoRojo">
                                                <xsl:value-of select="TARIFAPRIVADA_VIAMED"/>
                                                </span>
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <xsl:value-of select="TARIFAPRIVADA_VIAMED"/>
                                            </xsl:otherwise>
                                          </xsl:choose>
                                          <!--fin precio VIAMED si differente de mvm amarillo-->
                                      </xsl:when>
                                      </xsl:choose>
                                      <xsl:if test="CAMBIOS/EMPLANTILLADO_EN_VIAMED">&nbsp;<strong><span class="verde">V</span></strong></xsl:if>
									</td>
                                     <!--precio anterior viamed solo si españa-->
                                    <td class="center">  
                                    <xsl:if test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/IDPAIS = '34'">
                                        	<xsl:value-of select="TARIFAORIGINAL_VIAMED"/>
                                     </xsl:if>
									</td>
                                    <!--precio teknon solo si españa-->
                                    <td class="center">  
                                    <xsl:choose>
                                    <xsl:when test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/IDPAIS = '34'">
                                    	<xsl:choose>
                                        <xsl:when test="MANTIENE_TARIFA_TEKNON">
                                        	&nbsp;
                                        </xsl:when>
                                         <xsl:when test="SUBIDA_TARIFA_TEKNON">
                                         	<img src="http://www.newco.dev.br/images/order_a_rojo.gif"/>
                                        </xsl:when>
                                         <xsl:when test="BAJADA_TARIFA_TEKNON">
                                         	<img src="http://www.newco.dev.br/images/order_d_verde.gif"/>
                                        </xsl:when>
                                        </xsl:choose>
                                    	<!--precio teknon si diferente de mvm rojo-->
                                          <xsl:choose>
                                            <xsl:when test="TARIFAPRIVADA_EURO != TARIFAPRIVADA_TEKNON">
                                                <span class="fondoRojo">
                                                <xsl:value-of select="TARIFAPRIVADA_TEKNON"/>
                                                </span>
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <xsl:value-of select="TARIFAPRIVADA_TEKNON"/>
                                            </xsl:otherwise>
                                          </xsl:choose>
                                          <!--fin precio TEKNON si differente de mvm amarillo-->
                                      </xsl:when>
                                      </xsl:choose>
                                      <xsl:if test="CAMBIOS/EMPLANTILLADO_EN_TEKNON">&nbsp;<strong><span class="verde">T</span></strong></xsl:if>
									</td>
                                    
                                    <!--cambios en ficha tecnica o en oferta-->
                                    <td>
                                    	<!--2-10-13 solo para brasil, proveedores no pueden poner precio u ofertas mvm en españa-->
                                        <xsl:if test="CAMBIOS/OFERTA and /MantenimientoProductos/DATOS/LISTAPRODUCTOS/IDPAIS = '55'">
                                        	<img src="http://www.newco.dev.br/images/ofertaChange.gif" alt="Cambio de oferta"/>
                                        </xsl:if>
                                        <xsl:if test="CAMBIOS/OFERTAASISA">
                                        	<img src="http://www.newco.dev.br/images/ofertaAsisaChange.gif" alt="Cambio de oferta asisa"/>
                                        </xsl:if>
                                    	<xsl:if test="CAMBIOS/FICHATECNICA">
                                        	<img src="http://www.newco.dev.br/images/fichaChange.gif" alt="Cambio de ficha tecnica"/>
                                        </xsl:if>
                                        <xsl:if test="CAMBIOS/OFERTAFNCP">
                                        	<img src="http://www.newco.dev.br/images/ofertaFNCPChange.gif" alt="Cambio de oferta FNCP"/>
                                        </xsl:if>
                                        <xsl:if test="CAMBIOS/OFERTAVIAMED">
                                        	<img src="http://www.newco.dev.br/images/ofertaViamedChange.gif" alt="Cambio de oferta Viamed"/>
                                        </xsl:if>
                                        <xsl:if test="CAMBIOS/OFERTATEKNON">
                                        	<img src="http://www.newco.dev.br/images/ofertaTeknonChange.gif" alt="Cambio de oferta Teknon"/>
                                        </xsl:if>
                                        
                                    </td>
									<xsl:if test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/ADMIN_MVM or /MantenimientoProductos/DATOS/LISTAPRODUCTOS/ADMIN_MVMB">	
										<td class="center">
											<input type="checkbox" onclick="RevisarOpciones(document.forms['formBusca'], {IDPRODUCTO},'ACEPTAR');">
												<xsl:attribute name="name">ACEPTAR_<xsl:value-of select="IDPRODUCTO"/></xsl:attribute>
											</input>
										</td>
									</xsl:if> 
									<xsl:if test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/ADMIN_MVM or /MantenimientoProductos/DATOS/LISTAPRODUCTOS/ADMIN_MVMB">
										<td class="center">
											<input type="checkbox" onclick="RevisarOpciones(document.forms['formBusca'], {IDPRODUCTO},'CANCELAR');">
												<xsl:attribute name="name">CANCELAR_<xsl:value-of select="IDPRODUCTO"/></xsl:attribute>
											</input>
										</td> 
									</xsl:if> 
                                  
                                    <xsl:if test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/ADMIN_MVM or /MantenimientoProductos/DATOS/LISTAPRODUCTOS/ADMIN_MVMB">
										<td class="center">
                                        	<input size="15">
                                            <xsl:attribute name="name">COMENTARIO_<xsl:value-of select="IDPRODUCTO"/></xsl:attribute>
											</input>
										</td> 
									</xsl:if> 
								</tr>
		  				</xsl:for-each>	   
                   </tbody>
                   <tfoot>
                  <tr class="lejenda">
				<th colspan="11" class="textLeft">
					<xsl:value-of select="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/MENSAJE"/>
				</th>
                <th colspan="12" class="textRight">
                    <xsl:if test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/PAGINAANTERIOR">
                        <a href="javascript:Enviar(document.forms['formBusca'],'ANTERIOR');">
                           <img src="http://www.newco.dev.br/images/flechaLeft.gif" /></a>
                        <a href="javascript:Enviar(document.forms['formBusca'],'ANTERIOR');"><xsl:value-of select="document($doc)/translation/texts/item[@name='anterior']/node()"/></a>
                    </xsl:if>
                    <xsl:if test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/PAGINASIGUIENTE">
                         &nbsp;&nbsp;&nbsp;
                         <a href="javascript:Enviar(document.forms['formBusca'],'SIGUIENTE');" title="siguiente"><xsl:value-of select="document($doc)/translation/texts/item[@name='siguiente']/node()"/></a>
                         <a href="javascript:Enviar(document.forms['formBusca'],'SIGUIENTE');" title="siguiente"><img src="http://www.newco.dev.br/images/flechaRight.gif" /></a>
					</xsl:if>
                 </th>
			</tr>         
            <xsl:if test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/ADMIN_MVM or /MantenimientoProductos/DATOS/LISTAPRODUCTOS/ADMIN_MVMB">
                <tr class="lejenda">
                	
                    <td colspan="17">&nbsp;</td>
                     <td colspan="4">&nbsp; </td>
                     <td colspan="2">
                      <div class="boton">
                      	<a href="javascript:AceptarCambios(document.forms['formBusca'])"><xsl:value-of select="document($doc)/translation/texts/item[@name='aceptar_cambios']/node()"/></a>
                      </div>
                    </td>
                </tr>
            </xsl:if>
          </tfoot>
      	  	</table> 
					
  </xsl:otherwise>
  </xsl:choose>
</xsl:template><!--fin de adminMVM-->

<xsl:template name="proveedor">
	   <!--idioma-->
        <xsl:variable name="lang">
         <xsl:choose>
            <xsl:when test="/MantenimientoProductos/DATOS/LANG"><xsl:value-of select="/MantenimientoProductos/DATOS/LANG" /></xsl:when>
            <xsl:otherwise>spanish</xsl:otherwise>
            </xsl:choose>  
        </xsl:variable>
        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
      <!--idioma fin-->
      
               <input type="hidden" name="CADENA_IMAGENES" />
			   <input type="hidden" name="IMAGENES_BORRADAS" />
               <input type="hidden" name="US_ID" />
               <input type="hidden" name="PRO_ID" />
               <input type="hidden" name="IDPRODUCTO_SOLICITUD"/>
      	  	
            <table class="encuesta" border="0">
            <thead>
            
            <tr class="lejenda">
				<th colspan="3" class="textLeft">
					<xsl:value-of select="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/MENSAJE"/>
				</th>
                <th colspan="3" align="left">
                <xsl:if test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/IDPAIS = '34'"> 
                	<p style="align:left; font-weight:normal; margin-left:5px;">
                        <img src="http://www.newco.dev.br/images/cuadroRojo.gif" />&nbsp;
                        <span class="font11"><xsl:value-of select="document($doc)/translation/texts/item[@name='precios_diferentes']/node()"/></span>
                	  </p>
                </xsl:if>
                </th>
                <th colspan="2" align="left">
                <xsl:if test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/IDPAIS = '34'"> 
                	<p style="align:left; font-weight:normal; margin-left:5px;">
                        &nbsp;<span class="verde">A</span>&nbsp;&nbsp;
                        <span class="font11"><xsl:value-of select="document($doc)/translation/texts/item[@name='adjudicado_asisa']/node()"/></span>
                        <br />
                         &nbsp;<span class="verde">F</span>&nbsp;&nbsp;
                        <span class="font11"><xsl:value-of select="document($doc)/translation/texts/item[@name='adjudicado_fncp']/node()"/></span>
                	  </p>
                      
                </xsl:if>
                </th>
                <th colspan="2" align="left">
                <xsl:if test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/IDPAIS = '34'"> 
                	<p style="align:left; font-weight:normal; margin-left:5px;">
                        &nbsp;<span class="verde">V</span>&nbsp;&nbsp;
                        <span class="font11"><xsl:value-of select="document($doc)/translation/texts/item[@name='adjudicado_viamed']/node()"/></span>
                        <br />
                         &nbsp;<span class="verde">T</span>&nbsp;&nbsp;
                        <span class="font11"><xsl:value-of select="document($doc)/translation/texts/item[@name='adjudicado_teknon']/node()"/></span>
                	  </p>
                      
                </xsl:if>
                </th>
                <th colspan="4">
                	 <p style="align:left; font-weight:normal;"><span style="color:#FF9900; font-weight:bold;">P</span>&nbsp;
                        <span class="font11"><xsl:value-of select="document($doc)/translation/texts/item[@name='solicitud_pendiente']/node()"/></span><br />
                         &nbsp;<span style="color:#FF9900; font-weight:bold;">D</span>&nbsp;
                        <span class="font11"><xsl:value-of select="document($doc)/translation/texts/item[@name='solicitud_rechazada']/node()"/></span>
                	  </p>
                </th>
                <th colspan="6" class="textRight">
                    <xsl:if test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/PAGINAANTERIOR">
                        <a href="javascript:Enviar(document.forms['formBusca'],'ANTERIOR');"><img src="http://www.newco.dev.br/images/flechaLeft.gif" /></a> 
                       <a href="javascript:Enviar(document.forms['formBusca'],'ANTERIOR');"> <xsl:value-of select="document($doc)/translation/texts/item[@name='anterior']/node()"/></a>
                    </xsl:if>
                    <xsl:if test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/PAGINASIGUIENTE">
                         &nbsp;&nbsp;&nbsp;
                         <a href="javascript:Enviar(document.forms['formBusca'],'SIGUIENTE');" title="siguiente"> <xsl:value-of select="document($doc)/translation/texts/item[@name='siguiente']/node()"/></a>
                         <a href="javascript:Enviar(document.forms['formBusca'],'SIGUIENTE');" title="siguiente"><img src="http://www.newco.dev.br/images/flechaRight.gif" /></a>
					</xsl:if>
                 </th>
			</tr>
            
            <!--eliminación de solicitudes parte proveedor-->
            <xsl:choose>
            <xsl:when test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/BUSQUEDA/RECHAZADOS and /MantenimientoProductos/DATOS/OK">
            <tr class="titulos">
            	<td colspan="20" align="center"><p class="rojo"><xsl:value-of select="document($doc)/translation/texts/item[@name='solicitus_eliminada_con_exito']/node()"/></p></td>
            </tr>
            </xsl:when>
             <xsl:when test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/BUSQUEDA/RECHAZADOS and /MantenimientoProductos/DATOS/ERROR">
            <tr class="titulos">
            	<td colspan="20" align="center"><p class="rojo"><xsl:value-of select="/MantenimientoProductos/DATOS/ERROR/@msg"/></p></td>
            </tr>
            </xsl:when>
            </xsl:choose>
            <!--fin eliminación de solicitudes parte proveedor-->
            
      	    <tr class="titulos">
								<th class="ocho"><a href="javascript:OrdenarPor('REFERENCIA');"> <xsl:value-of select="document($doc)/translation/texts/item[@name='referencia']/node()"/></a></th>
                                <th class="dos"> <xsl:value-of select="document($doc)/translation/texts/item[@name='ima']/node()"/></th>
								<th><a href="javascript:OrdenarPor('PRODUCTO');"><xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/></a></th>
                                <th class="seis"> <xsl:value-of select="document($doc)/translation/texts/item[@name='detalle']/node()"/></th>
								<th class="tres"> <xsl:value-of select="document($doc)/translation/texts/item[@name='imagen']/node()"/></th>
								<th class="seis"><a href="javascript:OrdenarPor('MARCA');"><xsl:value-of select="document($doc)/translation/texts/item[@name='marca']/node()"/></a></th>
								<th class="ocho"> <xsl:value-of select="document($doc)/translation/texts/item[@name='ud_base']/node()"/></th>
								<th class="cinco"> <xsl:value-of select="document($doc)/translation/texts/item[@name='ud_por_caja_2line']/node()"/></th>
								<th class="cinco"> <xsl:value-of select="document($doc)/translation/texts/item[@name='iva']/node()"/></th>
								<th class="siete" align="right"><xsl:value-of select="document($doc)/translation/texts/item[@name='precio']/node()"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='mvm']/node()"/></th>
                                <!--si es españa enseño precio asisa y fncp-->
                                <xsl:choose>
                                 <xsl:when test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/IDPAIS = '34'">
                                	<!--precio asisa-->
                                    <th class="cinco" align="right">
                                    	<xsl:value-of select="document($doc)/translation/texts/item[@name='precio_asisa']/node()"/></th>
                                   	<!--emplantillado asisa-->
                                    <th class="uno">&nbsp;</th>
                                    <!--precio fncp-->
                                    <th class="cinco" align="right">
                                    	<xsl:value-of select="document($doc)/translation/texts/item[@name='precio_fncp']/node()"/></th>
                                    <!--emplantillado fncp-->
                                    <th class="uno">&nbsp;</th>
                                    <!--precio viamed-->
                                    <th class="cinco" align="right">
                                    	<xsl:value-of select="document($doc)/translation/texts/item[@name='precio_viamed']/node()"/></th>
                                   	<!--emplantillado viamed-->
                                    <th class="uno">&nbsp;</th>
                                    <!--precio teknon-->
                                    <th class="cinco" align="right">
                                    	<xsl:value-of select="document($doc)/translation/texts/item[@name='precio_teknon']/node()"/></th>
                                    <!--emplantillado teknon-->
                                    <th class="uno">&nbsp;</th>
                                 </xsl:when>
                                 <xsl:otherwise><th colspan="8" class="uno">&nbsp;</th></xsl:otherwise>
                                 </xsl:choose>
                                <!--si son solicitudes rechazadas enseño comentario-->
                                 <xsl:choose>
                                 <xsl:when test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/BUSQUEDA/RECHAZADOS">
                                	<th class="dies" align="left"><xsl:value-of select="document($doc)/translation/texts/item[@name='comentario']/node()"/></th>
                                	<th class="cinco" align="left"><xsl:value-of select="document($doc)/translation/texts/item[@name='eliminar']/node()"/></th>
                                 </xsl:when>
                                 <xsl:otherwise><th class="uno" colspan="2"></th></xsl:otherwise>
                                 </xsl:choose>
                                 
							</tr>

                  </thead>
							<!--	Cuerpo de la tabla	-->
                <tbody>
                
      	    	<xsl:for-each select="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/PRODUCTO">
                
      	      	<tr>
                	
									<td class="center">
										<xsl:value-of select="REFERENCIA"/>
                                        <input type="hidden" name="REF_{IDPRODUCTO}" value="{REFERENCIA}"/>
									</td> 
                                    <td>
                                    	<input type="hidden" name="PRO_ID" value="{IDPRODUCTO}"/>
                                        <input type="checkbox" name="CHECK" id="{IDPRODUCTO}" alt="{REFERENCIA}" />
									</td> 
									<td class="textLeft">
                                    <!--solicitud pendiente o devuelta-->
                                    <xsl:choose>
                                    <xsl:when test="SOLICITUD_DEVUELTA">
                                    	<strong>
                                        	<a href="javascript:AlarmaSolicitud('D');">
                                                    <span style="color:#FF9900;">D</span>&nbsp;<xsl:value-of select="NOMBRE"/>
												</a>
												
                                        </strong>
                                    </xsl:when>
                                    <xsl:when test="SOLICITUD_PENDIENTE">
                                    	<strong>
                                        	<a href="javascript:AlarmaSolicitud('P');">
                                                    <span style="color:#FF9900;">P</span>&nbsp;<xsl:value-of select="NOMBRE"/>
												</a>
												
                                        </strong>
                                    </xsl:when>
                                    <xsl:otherwise>
										<strong>
                                        	<a>
                                            <xsl:attribute name="href">javascript:MantenimientoProductos('http://www.newco.dev.br/Administracion/Mantenimiento/Productos/PROManten.xsql?PRO_ID=<xsl:value-of select="IDPRODUCTO"/>&amp;TIPO=M&amp;PRO_BUSQUEDA=<xsl:value-of select="//LISTAPRODUCTOS/BUSQUEDA/PRODUCTO"/>&amp;IDCLIENTE=<xsl:value-of select="//LISTAPRODUCTOS/BUSQUEDA/IDCLIENTE"/>&amp;HISTORY='+obtenerHistoria());</xsl:attribute>
													
                                                    <xsl:value-of select="NOMBRE"/>
												</a>
												
                                        </strong>
                                    </xsl:otherwise>
                                    </xsl:choose>
									</td>
                                    <!--ficha de producto-->
                                    <td align="center">
                                    
                                    <a>
                                    <xsl:attribute name="href">javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Productos/PRODetalle.xsql?PRO_ID=<xsl:value-of select="IDPRODUCTO"/>','producto',70,50,0,-50);</xsl:attribute>
                                    Detalle</a>
                                    </td>
                                    <!--imagenes-->
									<td class="center">
                                            <xsl:variable name="ima" select="count(IMAGENES/IMAGEN)"/>
                                            
                                                <xsl:choose>
                                                <xsl:when test="$ima &gt; '0'">
                                            <xsl:variable name="idRef" select="REFERENCIA" />
                                            
                                                 
                                                  <img src="http://www.newco.dev.br/images/imagenSI.gif" alt="{IDPRODUCTO}" id="IMA_{IDPRODUCTO}" onmouseover="verFoto('{$idRef}');" onmouseout="verFoto('{$idRef}');" />
                                                  
                                                    <div id="verFotoPro_{$idRef}" class="divFotoProBusca" style="display:none;">
                                                        <xsl:for-each select="IMAGENES/IMAGEN">
                                                            <xsl:if test="@id != '-1'">
                                                            <img src="http://www.newco.dev.br/Fotos/{@peq}" />
                                                            </xsl:if>
                                                        </xsl:for-each>
                                                    </div>
                                                    
                                                </xsl:when>
                                                <xsl:otherwise>
                                                 <xsl:variable name="idIma" select="IDPRODUCTO" />
                                                	<img src="http://www.newco.dev.br/images/imagenNO.gif" id="IMA_{$idIma}"/>
                                                </xsl:otherwise>
                                                </xsl:choose>
                                       
									</td> 
									<td class="center">
										<xsl:value-of select="MARCA"/>&nbsp;
									</td> 
								
									<td class="center">
										<xsl:value-of select="UNIDADBASICA"/>
									</td>
									<td class="center">
										<xsl:value-of select="UNIDADESPORLOTE"/>
									</td>
									
									<td class="center">
												<xsl:for-each select="IVA/field/dropDownList/listElem">
													<xsl:if test="ID=../../@current">
														<xsl:value-of select="listItem"/>
													</xsl:if>
                                                </xsl:for-each>
									</td>
									 
									<td align="right">
										<xsl:value-of select="TARIFAPRIVADA_MVM"/>
                                        <xsl:text>&nbsp;</xsl:text>
									</td> 
                                    
                                    <!--si es españa enseño emplantillado asisa y precio asisa si no nada-->
                                    <td align="right"> 
                                     <xsl:if test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/IDPAIS = '34'"> 
                                          <xsl:choose>
                                            <xsl:when test="TARIFAPRIVADA_ASISA != TARIFAPRIVADA_MVM">
                                               <span class="fondoRojo"><xsl:value-of select="TARIFAPRIVADA_ASISA"/></span>
                                             </xsl:when>
                                             <xsl:otherwise>
                                                <xsl:value-of select="TARIFAPRIVADA_ASISA"/>
                                             </xsl:otherwise>
                                          </xsl:choose>
                                          <xsl:text>&nbsp;</xsl:text>
                                     </xsl:if>
									</td>  
                                    <td align="right"> 
                                     <xsl:if test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/IDPAIS = '34'"> 
                                     	<xsl:if test="EMPLANTILLADO_EN_ASISA">&nbsp;<strong><span class="verde">A</span></strong></xsl:if>
                                     </xsl:if>
									</td> 
                                    
                                     <!--si es españa enseño emplantillado fncp y precio fncp si no nada-->
                                     <td align="right"> 
                                     <xsl:if test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/IDPAIS = '34'">
                                         <xsl:choose>
                                            <xsl:when test="TARIFAPRIVADA_FNCP != TARIFAPRIVADA_MVM">
                                               <span class="fondoRojo"><xsl:value-of select="TARIFAPRIVADA_FNCP"/></span>
                                             </xsl:when>
                                             <xsl:otherwise>
                                                <xsl:value-of select="TARIFAPRIVADA_FNCP"/>
                                             </xsl:otherwise>
                                          </xsl:choose>
                                          <xsl:text>&nbsp;</xsl:text>
                                     </xsl:if>
									</td>  
                                    <td align="right"> 
                                     <xsl:if test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/IDPAIS = '34'">
                                     	<xsl:if test="EMPLANTILLADO_EN_FNCP">&nbsp;<strong><span class="verde">F</span></strong></xsl:if>
                                     </xsl:if>
									</td> 
                                    <!--si es españa enseño emplantillado viamed y precio viamed si no nada-->
                                     <td align="right"> 
                                     <xsl:if test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/IDPAIS = '34'">
                                         <xsl:choose>
                                            <xsl:when test="TARIFAPRIVADA_VIAMED != TARIFAPRIVADA_MVM">
                                               <span class="fondoRojo"><xsl:value-of select="TARIFAPRIVADA_VIAMED"/></span>
                                             </xsl:when>
                                             <xsl:otherwise>
                                                <xsl:value-of select="TARIFAPRIVADA_VIAMED"/>
                                             </xsl:otherwise>
                                          </xsl:choose>
                                          <xsl:text>&nbsp;</xsl:text>
                                     </xsl:if>
									</td>  
                                    <td align="right"> 
                                     <xsl:if test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/IDPAIS = '34'">
                                     	<xsl:if test="EMPLANTILLADO_EN_VIAMED">&nbsp;<strong><span class="verde">V</span></strong></xsl:if>
                                     </xsl:if>
									</td> 
                                     <!--si es españa enseño emplantillado teknon y precio teknon si no nada-->
                                     <td align="right"> 
                                     <xsl:if test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/IDPAIS = '34'">
                                         <xsl:choose>
                                            <xsl:when test="TARIFAPRIVADA_TEKNON != TARIFAPRIVADA_MVM">
                                               <span class="fondoRojo"><xsl:value-of select="TARIFAPRIVADA_TEKNON"/></span>
                                             </xsl:when>
                                             <xsl:otherwise>
                                                <xsl:value-of select="TARIFAPRIVADA_TEKNON"/>
                                             </xsl:otherwise>
                                          </xsl:choose>
                                          <xsl:text>&nbsp;</xsl:text>
                                     </xsl:if>
									</td>  
                                    <td align="right"> 
                                     <xsl:if test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/IDPAIS = '34'">
                                     	<xsl:if test="EMPLANTILLADO_EN_TEKNON">&nbsp;<strong><span class="verde">T</span></strong></xsl:if>
                                     </xsl:if>
									</td> 
                                     <!--si son solicitudes rechazadas enseño comentario-->
                                     
                                     <xsl:choose>
                                     <xsl:when test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/BUSQUEDA/RECHAZADOS">
                                     	<td>
                                        <xsl:if test="COMENTARIO_RECHAZO != ''">
                                        	<xsl:value-of select="COMENTARIO_RECHAZO" />
                                        </xsl:if>     
                                        </td>
                                        <td>
                                        <a href="javascript:EliminaSolicitud({IDPRODUCTO});"><img src="http://www.newco.dev.br/images/eliminarOferta.gif" alt="Elimina"/></a>                         </td>
                                     </xsl:when>
                                     <xsl:otherwise>
                                     	<td colspan="2">&nbsp;</td>
                                     </xsl:otherwise>
                                     </xsl:choose>
                                     
                                    
								</tr>
		  				</xsl:for-each>	   
                   </tbody>
                   <tfoot>
                  <tr class="lejenda">
				<th colspan="8" class="textLeft">
					<xsl:value-of select="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/MENSAJE"/>
				</th>
                <th colspan="6">&nbsp;</th>
                <th colspan="6" class="textRight">
                    <xsl:if test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/PAGINAANTERIOR">
                        <a href="javascript:Enviar(document.forms['formBusca'],'ANTERIOR');">
                           <img src="http://www.newco.dev.br/images/flechaLeft.gif" /></a>
                        <a href="javascript:Enviar(document.forms['formBusca'],'ANTERIOR');"> <xsl:value-of select="document($doc)/translation/texts/item[@name='anterior']/node()"/></a>
                    </xsl:if>
                    <xsl:if test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/PAGINASIGUIENTE">
                         &nbsp;&nbsp;&nbsp;
                         <a href="javascript:Enviar(document.forms['formBusca'],'SIGUIENTE');" title="siguiente"> <xsl:value-of select="document($doc)/translation/texts/item[@name='siguiente']/node()"/></a>
                         <a href="javascript:Enviar(document.forms['formBusca'],'SIGUIENTE');" title="siguiente"><img src="http://www.newco.dev.br/images/flechaRight.gif" /></a>
					</xsl:if>
                 </th>
			</tr>         
               
          </tfoot>
      	  	</table> 
          
</xsl:template><!--fin de proveedor-->

<!--INICIO TEMPLATE IMAGE-->
  <xsl:template name="image">
	<xsl:param name="num" />
    	<div class="imageLineBusca" id="imageLine_{$num}">
			<input id="inputFile_{$num}" name="inputFile" type="file" onchange="addFile({$num});" />
        </div>
</xsl:template>

<!--INICIO TEMPLATE IMAGE-->
<xsl:template name="imageMan">
	<xsl:param name="num" />
	<div class="imageLineBusca" id="imageLine_{$num}">
		
        <xsl:if test="@id != '-1'">
			<div class="imageBuscaManten">
                <a href="http://www.newco.dev.br/Fotos/{@grande}" rel="lightbox" title="Foto producto" style="text-decoration:none;">
				<img src="http://www.newco.dev.br/Fotos/{@peq}" class="manFotoBusca" />
                </a>
				&nbsp;
                <a id="deleteLink_{$num}" href="javascript:Eliminar();" onclick=" this.parentNode.style.display='none'; return deleteImagen({@id}, {$num}); "><img src="http://www.newco.dev.br/images/2017/trash.png" /></a>
                
			</div>
        </xsl:if>
	</div>
</xsl:template>
<!--fin de template image-->


</xsl:stylesheet>
