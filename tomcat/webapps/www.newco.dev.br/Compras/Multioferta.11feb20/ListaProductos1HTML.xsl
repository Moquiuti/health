<?xml version="1.0" encoding="iso-8859-1"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:import href = "http://www.newco.dev.br/General/General.xsl"/>
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="lang" select="@lang"/>

<!-- Variables globales con el contenido de las imagenes de los botones
<xsl:variable name="Editar_MouseOver"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='DB-EditarPeq_mov' and @lang=$lang]" disable-output-escaping="yes"/></xsl:variable>
<xsl:variable name="Editar_alt"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='IMG-0235' and @lang=$lang]" disable-output-escaping="yes"/></xsl:variable>
<xsl:variable name="Editar_MouseOut"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='DB-EditarPeq' and @lang=$lang]" disable-output-escaping="yes"/></xsl:variable>
<xsl:variable name="Editar_href">javascript:AsignarReferencia(document.forms[0],'CANTIDAD_UNI','P3AsignarRef.xsql');</xsl:variable>
-->

<xsl:template match="/">
<html>
<head>
	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:choose>
		<xsl:when test="/ProductosEnPlantillas/LANG"><xsl:value-of select="/Lista/LANG"/></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>

	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->

	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/Compras/Multioferta/Lista.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/Compras/Multioferta/ListaProductos180314.js"></script>

	<xsl:text disable-output-escaping="yes"><![CDATA[
	<script type="text/javascript">
        <!--
        ]]></xsl:text>
<!-- DC - 24.03.14 - Se mueven los textos al fichero de idiomas en /General/texts_$lang.xml

	  var SeleccionePredet   ='<xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='PRO-0360' and @lang=$lang]" disable-output-escaping="yes"/>';
	  var UnidadesNoValidas  ='<xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='P3-0290'  and @lang=$lang]" disable-output-escaping="yes"/>';
	  var IntrodeceNumLotes  ='<xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='PRO-0370' and @lang=$lang]" disable-output-escaping="yes"/>';
	  var LaReferencia	 ='<xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='P3-0315'  and @lang=$lang]" disable-output-escaping="yes"/>';
	  var EsCorrecta	 ='<xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='P3-0320'  and @lang=$lang]" disable-output-escaping="yes"/>';
	  var AsigneReferencia   ='<xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='P3-0300'  and @lang=$lang]" disable-output-escaping="yes"/>';
	  var SeleccionAutomatica='<xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='P3-0510'  and @lang=$lang]" disable-output-escaping="yes"/>';
-->
	  var SeleccionePredet   ='<xsl:value-of select="document($doc)/translation/texts/item[@name='PRO-0360']/node()"/>';
	  var UnidadesNoValidas  ='<xsl:value-of select="document($doc)/translation/texts/item[@name='P3-0290']/node()"/>';
	  var IntrodeceNumLotes  ='<xsl:value-of select="document($doc)/translation/texts/item[@name='PRO-0370']/node()"/>';
	  var LaReferencia	 ='<xsl:value-of select="document($doc)/translation/texts/item[@name='P3-0315']/node()"/>';
	  var EsCorrecta	 ='<xsl:value-of select="document($doc)/translation/texts/item[@name='P3-0320']/node()"/>';
	  var AsigneReferencia   ='<xsl:value-of select="document($doc)/translation/texts/item[@name='P3-0300']/node()"/>';
	  var SeleccionAutomatica='<xsl:value-of select="document($doc)/translation/texts/item[@name='P3-0510']/node()"/>';

	<xsl:text disable-output-escaping="yes"><![CDATA[

	  //Cambiamos el xml-stylesheet a P3ListaHTML.xsl                              
	  //Llamamos a la funcion ValidaCampos.	
	  //
	  //  
      
      function BuscadorCatalogoEspecializado(formu){
      //alert('mi '+formu.elements['LLP_NOMBRE'].value);
      	//si input producto informado voy siempre a la primera pagina
      	if (formu.elements['LLP_NOMBRE'].value != ''){
        	formu.elements['ULTIMAPAGINA'].value = '0';
        }
        formu.action = 'http://www.newco.dev.br/Compras/Multioferta/ListaProductos.xsql';
      		SubmitForm(formu);
      }//fin de buscadorCatalogoEspecializado
	
	//-->
	</script>
	]]></xsl:text>
      </head>
      <body>
      
       <!--idioma-->
         <xsl:variable name="lang">
        <xsl:choose>
            <xsl:when test="/Lista/LANG"><xsl:value-of select="/Lista/LANG" /></xsl:when>
            <xsl:otherwise>spanish</xsl:otherwise>
            </xsl:choose>  
        </xsl:variable>

        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>       <!--idioma fin-->
      
        <xsl:choose>
          <xsl:when test="Lista/form/SESION_CADUCADA">
             <xsl:apply-templates select="Lista/form/SESION_CADUCADA"/>            
          </xsl:when>
          <xsl:when test="Lista/form/xsql-error">
             <xsl:apply-templates select="Lista/form/xsql-error"/>            
          </xsl:when>
          <xsl:when test="Lista/form/Status">
             <xsl:apply-templates select="Lista/form/Status"/>                 
          </xsl:when>          
          <xsl:when test="Lista/form/ROWSET/ROW/TooManyRows">   
           
         
            <h1 class="titlePage">
            	<xsl:value-of select="document($doc)/translation/texts/item[@name='la_busqueda_no_ha_tenido_exito']/node()"/>
             </h1><!--fin titulo-->           
           		
            <div class="divLeft gris">   
            	<br /><br />         
              <p align="center"><xsl:value-of select="document($doc)/translation/texts/item[@name='demasiados_productos_seleccionados']/node()"/>
              </p>   
                <br /><br />
             <div class="botonCenter">
             	<a href="javascript:parent.history.go(-2);" title="Volver"><xsl:value-of select="document($doc)/translation/texts/item[@name='volver']/node()"/></a>
             </div>
               <br /><br />
                
                
            </div>
          
           
          </xsl:when>
	  <xsl:when test="Lista/form/ROWSET/ROW/NoDataFound">
	    <!--<xsl:apply-templates select="Lista/form/ROWSET/ROW/NoDataFound"/>-->
        <h1 class="titlePage"><xsl:value-of select="document($doc)/translation/texts/item[@name='no_se_han_encontrado_resultados']/node()"/></h1>
        <div class="divLeft gris" style="padding:10px;">
        <!--sinonimos-->
        <xsl:if test="Lista/form/ROWSET/ROW/NoDataFound/SINONIMO != ''">
            <p><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='sinonimos_no_resultados']/node()"/>:&nbsp;
            <span class="rojo">
             <a style="text-decoration:none;">  
                 <xsl:attribute name="href">javascript:buscarSinonimos('<xsl:value-of select="Lista/form/ROWSET/ROW/NoDataFound/SINONIMO"/>');</xsl:attribute>
                 
            	<xsl:value-of select="Lista/form/ROWSET/ROW/NoDataFound/SINONIMO"/>
            </a></span>
            </strong></p>
        </xsl:if>
        
        <p>&nbsp;</p>
        <p><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='su_busqueda_nos_es_de_utilidad']/node()"/></strong></p>
        <p>&nbsp;</p>
        <p><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='la_analizaremos_y_le_informaremos']/node()"/></strong></p>
        <p>&nbsp;</p>
        <p><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='ruego_nos_indique_en']/node()"/>
        <a>
        <xsl:attribute name="href"><xsl:value-of select="document($doc)/translation/texts/item[@name='mail_busqueda_medicalvm_consulta']/node()"/><xsl:value-of select="Lista/form/LLP_NOMBRE"/>
        </xsl:attribute>
        <xsl:value-of select="document($doc)/translation/texts/item[@name='mail_busquedas_medicalvm']/node()"/></a>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='si_procede_mas_detalles']/node()"/></strong></p>
        <p>&nbsp;</p>
        <p><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='gracias_medicalvm']/node()"/></strong></p>
         <p>&nbsp;</p>
		</div>
	  </xsl:when>                             
          <xsl:otherwise>
            <xsl:attribute name="onLoad">window.status='';Selecciona(document.forms[0],'<xsl:value-of select="Lista/form/LLP_PRODUCTO_DETERMINADO"/>');loadLotesAUnidades();</xsl:attribute>
			<!--	Presentamos la lista de productos				-->			
            <!--	<xsl:apply-templates select="Lista/form"/>		-->
    <form method="post">    
		<xsl:attribute name="name"><xsl:value-of select="@name"/></xsl:attribute>	
		<!--<xsl:attribute name="method"><xsl:value-of select="@method"/></xsl:attribute>-->	   
		<xsl:attribute name="action"><xsl:value-of select="@action"/></xsl:attribute>
		<input type="hidden" name="ORDEN" value="{/Lista/form/ROWSET/ORDEN}" />
		<input type="hidden" name="SENTIDO" value="{/Lista/form/ROWSET/SENTIDO}" />
       <!-- 
		<input type="hidden" name="FILTROPROVEEDOR"><xsl:attribute name="value"><xsl:choose><xsl:when test="//@name='CEmpresas'">on</xsl:when></xsl:choose></xsl:attribute></input>
		<input type="hidden" name="FILTROMARCA"><xsl:attribute name="value"><xsl:choose><xsl:when test="//field_plus/@name='CMarcas'">on</xsl:when></xsl:choose></xsl:attribute></input>
		<input type="hidden" name="FILTROPRODUCTO"><xsl:attribute name="value"><xsl:choose><xsl:when test="//field_plus/@name='CNomenclator'">on</xsl:when></xsl:choose></xsl:attribute></input>
	-->
		<input type="hidden" name="xml-stylesheet" value="{../xml-stylesheet}"/>           
<!--        <input type="hidden" name="xml-stylesheet" value="{../xml-stylesheet}"/>-->
		<input type="hidden" name="STOCKS_ACCION" value="" />
		<input type="hidden" name="STOCKS_IDPRODUCTO" value="" />
		<input type="hidden" name="STOCKS_COMENTARIOS" value="" />
        <input type="hidden" name="EMPLANTILLAR" value="" />
        <input type="hidden" name="IDPRODUCTO" value="{/Lista/form/ROWSET/IDPRODUCTO}" />
        <input type="hidden" name="STOCKS_TIPO" />
        <input type="hidden" name="SIN_STOCKS" value="{/Lista/form/ROWSET/TEXTO_SIN_STOCK}" />
        <input type="hidden" name="STOCKS_REF_ALT" value="{/Lista/form/ROWSET/REFERENCIAALTERNATIVA}" />
        <input type="hidden" name="STOCKS_PROD_ALT" value="{/Lista/form/ROWSET/DESCRIPCIONALTERNATIVA}" />
        
      
   
      <!--
       |   CUIDADO: Los cambios en campos ocultos se deben copiar en:
       |	 P3Empr-esasHTML.xsl
       |	 P3NomenclatorHTML.xsl
       |	 P3ListaHTML.xsl
       |	 P1ListaHTML.xsl
       |	 LLPMantenSaveHTML.xsl
       +--> 

             
		<!--<input type="hidden" name="LLP_PROVEEDOR">
			<xsl:attribute name="value"><xsl:value-of select="Lista/form/LLP_PROVEEDOR"/></xsl:attribute>
		</input>   -->        
		<input type="hidden" name="SELECCIONARTOTAL"><!--	utilizado en la paginación		-->
			<xsl:attribute name="value"><xsl:value-of select="Lista/form/SELECCIONARTOTAL"/></xsl:attribute>
		</input> 
		<input type="hidden" name="ULTIMAPAGINA">
			<xsl:attribute name="value"><xsl:value-of select="Lista/form/ROWSET/BUTTONS/ACTUAL/@PAG"/></xsl:attribute>
		</input>   
        <input type="hidden" name="SOLO_VISIBLES">
			<xsl:attribute name="value"><xsl:value-of select="Lista/form/ROWSET/SOLOVISIBLES"/></xsl:attribute>
		</input>   
        <input type="hidden" name="GRUPOPRODUCTOS">
			<xsl:attribute name="value"><xsl:value-of select="Lista/form/ROWSET/GRUPOPRODUCTOS"/></xsl:attribute>
		</input>   
           
 
      	<xsl:if test="/Lista/form/ROWSET/SOLICITUD_ENVIADA">
        	<div class="problematicos">
				<p><xsl:value-of select="/Lista/form/ROWSET/SOLICITUD_ENVIADA/MENSAJE" /></p>
			</div>
            <br />
		</xsl:if>
  		<xsl:if test="/Lista/form/ROWSET/REDUCIDA">
        	<div class="divLeft">
			<p><strong>&nbsp;&nbsp;&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='importante_precios_exclusivo_mvm']/node()"/></strong></p>
			</div>
		</xsl:if>
        
	<div class="divLeft">
	<table class="encuesta" border="0">
		<tr class="lejenda">
			<th colspan="7">
				<p class="textLeft" style="font-weight:normal;">* <xsl:value-of select="document($doc)/translation/texts/item[@name='en_amarillo_mvm_recomienda']/node()"/><br />
				* <img src="http://www.newco.dev.br/images/equiv.gif" alt="Equivalentes" title="Equivalentes"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='equivalentes_expli']/node()"/></p>
			</th>
           
			<th colspan="8">
				<p class="textRight">
					<!-- Pagina 1 de 10 -->
					<xsl:text disable-output-escaping="yes"><![CDATA[ P&aacute;gina&nbsp;]]></xsl:text>
					<span class="textoForm"><xsl:value-of select="(Lista/form/ROWSET/BUTTONS/ACTUAL/@PAG)+1"/></span>
					&nbsp;de&nbsp;
					<span class="textoForm"><xsl:value-of select="Lista/form/ROWSET/TOTALES/TOTAL_PAGINAS"/></span>
					<b>&nbsp;|&nbsp;</b>
					<!-- 100 Productos -->
					<span class="textoForm"><xsl:value-of select="Lista/form/ROWSET/TOTALES/TOTAL_FILAS"/></span>
					<xsl:choose>
					<xsl:when test="Lista/form/ROWSET/TOTALES/TOTAL_FILAS[.>1]">
						&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Productos']/node()"/>
						<b>&nbsp;|&nbsp;</b><xsl:value-of select="Lista/form/ROWSET/TOTALES/TOTAL_PROVEEDORES"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='proveedores']/node()"/>
						<b>&nbsp;|&nbsp;</b><xsl:value-of select="Lista/form/ROWSET/TOTALES/TOTAL_MARCAS"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='marcas']/node()"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/>
					</xsl:otherwise>
					</xsl:choose>
					<!--si cdc o admin veo totales Euro-->
					<xsl:if test="//ROWSET/ADMIN or //ROWSET/CDC">
						&nbsp;|&nbsp;<xsl:value-of select="Lista/form/ROWSET/TOTALES/TOTAL_IMPORTE"/>&nbsp;€&nbsp;
					</xsl:if>
					<xsl:variable name="IDAct">nulo</xsl:variable>
				</p>
			</th>
		</tr>
        <xsl:if test="/Lista/TITULO = 'BRAUNAESCULAP'">
        <tr class="lejenda">
            <th colspan="15">
                <p>Puede ampliar la información en <a href="http://www.surgical-instruments.info" target="_blank">www.surgical-instruments.info</a></p>
             </th>
        </tr>
        </xsl:if>
		<tr class="titulos">
			<th class="dos"><xsl:value-of select="document($doc)/translation/texts/item[@name='ima']/node()"/></th>
			<th class="uno">&nbsp;</th> 
			<th class="uno">&nbsp;</th>
			<th class="uno">&nbsp;</th>
			<th class="uno">&nbsp;</th>
			<th class="uno">&nbsp;</th>
			<th>
				<a href="javascript:OrdenarPor('PRODUCTO');"><xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/></a>
				<xsl:choose>
				<xsl:when test="/Lista/form/ROWSET/GRUPOPRODUCTOS!=''">
					: <input type="textbox" name="LLP_NOMBRE" width="20">
						<xsl:attribute name="value"><xsl:value-of select="Lista/form/ROWSET/PRODUCTO"/></xsl:attribute>
					</input>
				</xsl:when>
				<xsl:otherwise>
					<input type="hidden" name="LLP_NOMBRE">
						<xsl:attribute name="value"><xsl:value-of select="Lista/form/ROWSET/PRODUCTO"/></xsl:attribute>
					</input>
				</xsl:otherwise>
				</xsl:choose>
				<xsl:if test="/Lista/form/ROWSET/GRUPOPRODUCTOS!=''">
					<xsl:text>&nbsp;</xsl:text>
					<a href="javascript:BuscadorCatalogoEspecializado(document.forms[0]);"><img src="http://www.newco.dev.br/images/buttonBuscar.gif" alt="Boton Buscar" title="Buscar en Catalogo"/></a>
					<!--<div class="botonMenu">
						&nbsp;<a href="javascript:Enviar();" style="text-decoration:none;"><xsl:copy-of select="document($doc)/translation/texts/item[@name='buscar']/node()"/></a>&nbsp;
					</div>-->
				</xsl:if>
			</th>
			<th class="dies"><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_prov']/node()"/></th>

			<th class="dies">
				<a href="javascript:OrdenarPor('PROVEEDOR');"><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/></a><br/>
				<!--	proveedor	-->
				<xsl:if test="/Lista/form/ROWSET/FIDProveedor/field">
					<xsl:call-template name="desplegable">
						<xsl:with-param name="path" select="/Lista/form/ROWSET/FIDProveedor/field"/>
						<xsl:with-param name="onChange">javascript:CambioRestriccion();</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
			</th>
			<th class="dies">
				<a href="javascript:OrdenarPor('MARCA');"><xsl:value-of select="document($doc)/translation/texts/item[@name='marca']/node()"/></a><br/>
				<!--	marca	-->
				<xsl:if test="/Lista/form/ROWSET/FMarca/field">
					<xsl:call-template name="desplegable">
						<xsl:with-param name="path" select="/Lista/form/ROWSET/FMarca/field"/>
						<xsl:with-param name="onChange">javascript:CambioRestriccion();</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
			</th>
			<th class="dies"><xsl:copy-of select="document($doc)/translation/texts/item[@name='ud_basica_2line']/node()"/></th>
			<th class="nueve" align="right">
				<a href="javascript:OrdenarPor('PRECIO');">
                	
                    <xsl:choose>			 
					<!--viamed y asisa no ven precio ref = precio con o sin iva => viejo modelo -->
                    <xsl:when test="/Lista/form/ROWSET/OCULTAR_PRECIO_REFERENCIA">
                    	<xsl:choose>
                        <!--viamed ve precio con iva-->
                        <xsl:when test="/Lista/form/ROWSET/MOSTRAR_PRECIO_CON_IVA">
							<xsl:copy-of select="document($doc)/translation/texts/item[@name='precio_prov_con_iva_2line']/node()"/>
                        </xsl:when>
                        <!--asisa ve precio sin iva-->
                        <xsl:otherwise>
                        	<xsl:copy-of select="document($doc)/translation/texts/item[@name='precio_prov_sin_iva_2line']/node()"/>
                        </xsl:otherwise>
                        </xsl:choose>
					</xsl:when>
                    
                    <!--gomosa si ven precio ref= precio final con iva y comision => nuevo modelo -->
                    <xsl:when test="/Lista/form/ROWSET/MOSTRAR_PRECIO_REFERENCIA">
                            <xsl:copy-of select="document($doc)/translation/texts/item[@name='precio_final_c_iva_2line']/node()"/>
                    </xsl:when>
					</xsl:choose>
                    
				</a>
			</th>
			<th class="cinco">&nbsp;<xsl:copy-of select="document($doc)/translation/texts/item[@name='ud_ba_lote_2line']/node()"/></th>
			<!--si es spain enseño iva-->
			<xsl:if test="/Lista/form/ROWSET/IDPAIS = '34'">
				<xsl:choose>
				<xsl:when test="/Lista/form/ROWSET/REDUCIDA">
				</xsl:when>
				<xsl:otherwise>
					<th class="cuatro">&nbsp;&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='iva']/node()"/></th>
				</xsl:otherwise>
				</xsl:choose>
			</xsl:if>

			<!--consumo se ve solo si es admin o cdc y si no estamos en catalogo especializado-->
			<xsl:choose>
			<xsl:when test="(/Lista/form/ROWSET/ADMIN or /Lista/form/ROWSET/CDC or /Lista/form/ROWSET/ADMIN_CDC) and /Lista/form/ROWSET/GRUPOPRODUCTOS=''">
				<th class="seis"><a href="javascript:OrdenarPor('CONSUMO');"><xsl:copy-of select="document($doc)/translation/texts/item[@name='consumo_eur_2line']/node()"/></a>&nbsp;</th>
			</xsl:when>
			<xsl:otherwise>
				<th class="uno">&nbsp;</th>
			</xsl:otherwise>
			</xsl:choose>
		</tr>

		<xsl:apply-templates select="Lista/form/ROWSET/ROW"/>

	</table>
	<xsl:if test="//ROWSET/IDPRODUCTO != ''">
		<br /><br />
		<div class="botonCenter">
			<!--<a href="javascript:parent.history.go(-1);" title="Volver">Volver</a>-->
			<a href="ListaProductos.xsql?LLP_NOMBRE={Lista/form/LLP_NOMBRE}&amp;LLP_PROVEEDOR={Lista/form/LLP_PROVEEDOR}&amp;IDPRODUCTO=" title="Volver"><xsl:value-of select="document($doc)/translation/texts/item[@name='volver']/node()"/></a>
		</div>
		<br /><br />
	</xsl:if>
	</div><!--fin divLeft tabla-->

	<div class="divLeft90">
		<br /><br  />
		<div class="botonLeft">
			<xsl:choose>
			<xsl:when test="Lista/form/ROWSET/BUTTONS/ATRAS">
				<a href="javascript:Navega(document.forms[0],'CANTIDAD_UNI',{Lista/form/ROWSET/BUTTONS/ATRAS/@PAG});"><img src="http://www.newco.dev.br/images/anterior.gif"/></a>&nbsp;
				<a href="javascript:Navega(document.forms[0],'CANTIDAD_UNI',{Lista/form/ROWSET/BUTTONS/ATRAS/@PAG});"><xsl:value-of select="document($doc)/translation/texts/item[@name='anterior']/node()"/></a>
			</xsl:when>
			</xsl:choose>
		</div><!--fin de botonleft-->
		<div class="botonRight">
			<xsl:choose>
			<xsl:when test="Lista/form/ROWSET/BUTTONS/ADELANTE">
				<a href="javascript:Navega(document.forms[0],'CANTIDAD_UNI',{Lista/form/ROWSET/BUTTONS/ADELANTE/@PAG});"><xsl:value-of select="document($doc)/translation/texts/item[@name='siguiente']/node()"/></a>&nbsp;
				<a href="javascript:Navega(document.forms[0],'CANTIDAD_UNI',{Lista/form/ROWSET/BUTTONS/ADELANTE/@PAG});"><img src="http://www.newco.dev.br/images/siguiente.gif"/></a>
			</xsl:when>
			</xsl:choose>
		</div><!--fin de divRight-->
		<br /><br  />
	</div><!--fin de divCenter90-->
  </form>
          </xsl:otherwise>
        </xsl:choose>
      </body>
    </html>
  </xsl:template>  

<!-- TEMPLATES --> <!-- TEMPLATES --> <!-- TEMPLATES --> <!-- TEMPLATES --> <!-- TEMPLATES -->      

<xsl:template match="ROW">
	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:choose>
			<xsl:when test="/Lista/LANG"><xsl:value-of select="/Lista/LANG" /></xsl:when>
			<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>  
	</xsl:variable>

	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->
	<tr>
		<xsl:if test="DESTACADO"><xsl:attribute name="class">destacado</xsl:attribute></xsl:if>
		<td>
			<xsl:if test="(count(IMAGENES/IMAGEN)) &gt; 0">
				<xsl:for-each select="IMAGENES/IMAGEN">
					<xsl:if test="@id != '-1' and @num = '1'">
						<a style="text-decoration:none;">  
							<xsl:attribute name="href">javascript:MostrarPagPersonalizada('../../Administracion/Mantenimiento/Productos/PRODetalle.xsql?PRO_ID=<xsl:value-of select="../../PRO_ID"/>','producto',100,80,0,-50);</xsl:attribute>
							<img src="http://www.newco.dev.br/Fotos/{@peq}" class="imagenListaProd"/>
						</a>
					</xsl:if>
				</xsl:for-each>
			</xsl:if>
		</td>
		<td><!-- Semaforo de stocks	-->
			<xsl:choose>
				<xsl:when test="../ADMIN">
					<xsl:choose>
						<xsl:when test="TEXTO_SIN_STOCK=''">
							<a href="javascript:SinStock({PRO_ID},'','','','');" style="text-decoration:none;">
								<img src="http://www.newco.dev.br/images/SemaforoVerde.gif" />
							</a>
						</xsl:when>
						<xsl:when test="TIPO_SIN_STOCK='S'">
							<a href="javascript:SinStock({PRO_ID},'{TIPO_SIN_STOCK}','{TEXTO_SIN_STOCK}','{REFERENCIAALTERNATIVA}','{DESCRIPCIONALTERNATIVA}');" style="text-decoration:none;">
								<img src="http://www.newco.dev.br/images/SemaforoAmbar.gif" title="Sin stock: {TEXTO_SIN_STOCK}" />
							</a>
						</xsl:when>
						<xsl:when test="TIPO_SIN_STOCK='D'">
							<a href="javascript:SinStock({PRO_ID},'{TIPO_SIN_STOCK}','{TEXTO_SIN_STOCK}','{REFERENCIAALTERNATIVA}','{DESCRIPCIONALTERNATIVA}');" style="text-decoration:none;">
								<img src="http://www.newco.dev.br/images/SemaforoRojoParado.gif" title="Descatalogado: {TEXTO_SIN_STOCK}" />
							</a>
						</xsl:when>
					</xsl:choose>
				</xsl:when>
				<!--si usuario gerente veo info sin stock pero no puede modificar 19-09-12 mc-->
				<xsl:when test="../GERENTE">
					<xsl:choose>
						<xsl:when test="TEXTO_SIN_STOCK=''">
							<img src="http://www.newco.dev.br/images/SemaforoVerde.gif"/>
						</xsl:when>
						<xsl:when test="TIPO_SIN_STOCK='S'">
							<img src="http://www.newco.dev.br/images/SemaforoAmbar.gif" title="Sin stock: {TEXTO_SIN_STOCK}"/>
						</xsl:when>
						<xsl:when test="TIPO_SIN_STOCK='D'">
							<img src="http://www.newco.dev.br/images/SemaforoRojoParado.gif" title="Descatalogado: {TEXTO_SIN_STOCK}"/>
						</xsl:when>
					</xsl:choose>
				</xsl:when>
			</xsl:choose>
		</td>
		<td>
			<!--si precio no informado =>solo precio asisa, entonces no enseño catalogo, enplantillado...-->
			<xsl:if test="TARIFA_EUROS != ' €' and TARIFA_EUROS != '€' and TARIFA_EUROS != ''">
				<xsl:choose>
					<xsl:when test="../ADMIN_CDC and not(NONAVEGAR) and /Lista/form/ROWSET/GRUPOPRODUCTOS=''">
						<a href="javascript:MostrarPagPersonalizada('../../ProcesosCdC/MantenimientoReducido/MantenimientoReducido.xsql?PRO_ID={PRO_ID}','catalogoprivado',100,80,75,0);">
							<img src="http://www.newco.dev.br/images/catalogo.gif" alt="Ver en catalogo" title="Ver en catalogo"/>
						</a>
					</xsl:when>
					<xsl:when test="../ADMIN_CDC and NONAVEGAR and /Lista/form/ROWSET/GRUPOPRODUCTOS=''">
						<a href="javascript:MostrarPagPersonalizada('../../ProcesosCdC/MantenimientoReducido/MantenimientoReducido.xsql?PRO_ID={PRO_ID}','catalogoprivado',100,80,75,0);">
							<img src="http://www.newco.dev.br/images/catalogoRojo.gif" alt="Ver en catalogo" title="Ver en catalogo"/>
						</a>
					</xsl:when>
                    
                    <!--estamos en el listado normal desde enviar pedidos-->
					<xsl:when test="../REDUCIDA and /Lista/form/ROWSET/GRUPOPRODUCTOS =''">
						<xsl:choose>
							<xsl:when test="EMPLANTILLADO">
								<xsl:choose>
									<xsl:when test="/Lista/LANG = 'spanish'">
										<img src="http://www.newco.dev.br/images/enplantillaRojo.png" alt="Enplantillado" title="Emplantillado"/>
									</xsl:when>
									<xsl:when test="/Lista/LANG = 'br'">
										<img src="http://www.newco.dev.br/images/enplantillaRojo-br.png" alt="En planilhas" title="En planilhas"/>
									</xsl:when>
									<xsl:otherwise>
										<img src="http://www.newco.dev.br/images/enplantillaRojo.png" alt="Enplantillado" title="Emplantillado"/>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:when>
							<xsl:when test="PENDIENTE_EMPLANTILLADO">
								&nbsp;
							</xsl:when>
							<xsl:otherwise>
								<!--si producto descatalogado o sin stock no enseño emplantillar-->
								<xsl:choose>
									<xsl:when test="TIPO_SIN_STOCK='S' or TIPO_SIN_STOCK='D'"> <img src="http://www.newco.dev.br/images/descatalogado.gif" alt="Descatalog." title="Descatalogado"/></xsl:when>
									<xsl:otherwise>
										<a href="javascript:EnviarSolicitud('{PRO_ID}');" class="anchorEmplantillar">
											<xsl:choose>
												<xsl:when test="/Lista/form/ROWSET/IDPAIS = '34'">
													<img src="http://www.newco.dev.br/images/emplantillar.gif" alt="Emplantillar" title="Emplantillar"/>
												</xsl:when>
												<xsl:when test="/Lista/form/ROWSET/IDPAIS = '55'">
													<img src="http://www.newco.dev.br/images/emplantillar-br.gif" alt="Catalogar" title="Catalogar"/>
												</xsl:when>
												<xsl:otherwise>
													<img src="http://www.newco.dev.br/images/emplantillar.gif" alt="Emplantillar" title="Emplantillar"/>
												</xsl:otherwise>
											</xsl:choose>
										</a>
									</xsl:otherwise>
								</xsl:choose>
								<!--fin choose si prod descatalogado o sin stock--> 
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<!--si es catalogo especializado con /Lista/form/ROWSET/GRUPOPRODUCTOS!=''-->
					<xsl:when test="/Lista/form/ROWSET/GRUPOPRODUCTOS != ''">
						<xsl:text>&nbsp;</xsl:text>
                        <xsl:choose>
							<xsl:when test="EMPLANTILLADO">
								<xsl:choose>
									<xsl:when test="/Lista/LANG = 'spanish'">
										<img src="http://www.newco.dev.br/images/enplantillaRojo.png" alt="Enplantillado" title="Emplantillado"/>
									</xsl:when>
									<xsl:when test="/Lista/LANG = 'br'">
										<img src="http://www.newco.dev.br/images/enplantillaRojo-br.png" alt="En planilhas" title="En planilhas"/>
									</xsl:when>
									<xsl:otherwise>
										<img src="http://www.newco.dev.br/images/enplantillaRojo.png" alt="Enplantillado" title="Emplantillado"/>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:when>
                            <xsl:otherwise>
                                <a href="javascript:EnviarSolicitud('{PRO_ID}');" class="anchorEmplantillar">
                                    <xsl:choose>
                                        <xsl:when test="/Lista/form/ROWSET/IDPAIS = '34'">
                                            <img src="http://www.newco.dev.br/images/botonSolicitar.gif" alt="Solicitar"/>
                                        </xsl:when>
                                        <xsl:when test="/Lista/form/ROWSET/IDPAIS = '55'">
                                            <img src="http://www.newco.dev.br/images/botonSolicitar-br.gif" alt="Pedir"/>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <img src="http://www.newco.dev.br/images/botonSolicitar.gif" alt="Solicitar"/>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </a>
                            </xsl:otherwise>
                            </xsl:choose><!--fin si esta emplantillado-->
					</xsl:when>
				</xsl:choose>

				
				<xsl:if test="EMPLANTILLADO and ../ADMIN_CDC and /Lista/form/ROWSET/GRUPOPRODUCTOS = ''">
					<xsl:choose>
						<xsl:when test="/Lista/form/ROWSET/IDPAIS = '34'">
							<img src="http://www.newco.dev.br/images/enplantillaRojo.png" alt="Enplantillado" title="Emplantillado"/>
						</xsl:when>
						<xsl:when test="/Lista/form/ROWSET/IDPAIS = '55'">
							<img src="http://www.newco.dev.br/images/catalogadoAzulBr.gif" alt="Catalogado" title="Catalogado"/>
						</xsl:when>
						<xsl:otherwise>
							<img src="http://www.newco.dev.br/images/enplantillaRojo.png" alt="Enplantillado" title="Emplantillado"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:if>
                
           </xsl:if><!--fin id si precio esta informado, si no lo esta solo precio asisa y no enseño este trozo-->
		</td>
		<td>
			<xsl:if test="/Lista/form/ROWSET/GRUPOPRODUCTOS != '' and PRO_ENLACE != ''">
				<a target="_blank">
					<xsl:attribute name="href">
						<xsl:value-of select="PRO_ENLACE"/>
					</xsl:attribute>
					<img src="http://www.newco.dev.br/images/verWeb.gif" alt="Ver Web" title="Ver Web"/>
                                </a>
			</xsl:if>
		</td>
		<td>
			<xsl:if test="EQUIVALENTES">
				<a style="text-decoration:none;">  
					<xsl:attribute name="href">javascript:Equivalentes(<xsl:value-of select="PRO_ID"/>);</xsl:attribute>
					<img src="http://www.newco.dev.br/images/equiv.gif" alt="Equivalentes" title="Equivalentes"/>
				</a>
			</xsl:if>
		</td>
		<td>
			<xsl:if test="OCULTO and /Lista/form/ROWSET/GRUPOPRODUCTOS = ''">
				<img src="http://www.newco.dev.br/images/prodOculto.gif" alt="Oculto" title="Oculto" style="margin-top:1px;"/>
			</xsl:if>
		</td>
		<td class="textLeft">
			<!-- si es CdC no mostramos la ficha de producto si no el mantenimiento reducido, PENDIENTE -->
			<a style="text-decoration:none;">  
				<xsl:attribute name="href">javascript:MostrarPagPersonalizada('../../Administracion/Mantenimiento/Productos/PRODetalle.xsql?PRO_ID=<xsl:value-of select="PRO_ID"/>','producto',100,80,0,0);</xsl:attribute>
				<span class="strongAzul"><xsl:value-of select="PRO_NOMBRE" disable-output-escaping="yes"/></span>
			</a>
		</td>
		<td class="tres" align="center">
			<xsl:value-of select="REFERENCIA_PROVEEDOR"/>
		</td>
		<td align="center">
			<xsl:choose>
				<xsl:when test="IDPLANTILLA != ''">
					<a class="noDecor">
						<xsl:attribute name="href">javascript:EjecutarFuncionDelFrame('zonaPlantilla',<xsl:value-of select="IDPLANTILLA"/>);</xsl:attribute>
						<xsl:value-of select="PROVEEDOR"/>
					</a>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="PROVEEDOR"/>
				</xsl:otherwise>
			</xsl:choose>
		</td>
		<td align="center">
			<xsl:if test="PRO_MARCA!=''">
				<xsl:value-of select="substring(PRO_MARCA,1,15)"/>
			</xsl:if>
		</td>
		<td align="center">
			<xsl:value-of select="PRO_UNIDADBASICA"/>
		</td>
		<!--precio-->
		<td align="right">
			<xsl:attribute name="class">
				<xsl:choose>
					<xsl:when test="TARIFA_EUROS != ' €' and TARIFA_EUROS != '€' and TARIFA_EUROS != ''">textRight</xsl:when>
				</xsl:choose>
			</xsl:attribute>
			<xsl:attribute name="style">color:black;</xsl:attribute>

					<xsl:choose>			 
					<!--viamed y asisa no ven precio ref = precio con o sin iva => viejo modelo -->
                    <xsl:when test="/Lista/form/ROWSET/OCULTAR_PRECIO_REFERENCIA">
                    	<xsl:choose>
                        <!--viamed ve precio con iva-->
                        <xsl:when test="/Lista/form/ROWSET/MOSTRAR_PRECIO_CON_IVA and TARIFA_CONIVA_EUROS != ' €' and TARIFA_CONIVA_EUROS != '€' and TARIFA_CONIVA_EUROS != '' ">
							<span style="margin-right:13px;"><xsl:value-of select="TARIFA_CONIVA_EUROS"/></span>
                        </xsl:when>
                        <!--asisa ve precio sin iva-->
                        <xsl:when test="TARIFA_EUROS != ' €' and TARIFA_EUROS != '€' and TARIFA_EUROS != ''">
                        	<span style="margin-right:13px;"><xsl:value-of select="TARIFA_EUROS"/></span>
                        </xsl:when>
                        <xsl:otherwise>
                        	<xsl:value-of select="document($doc)/translation/texts/item[@name='no_disponible']/node()"/>&nbsp;&nbsp;&nbsp;
                        </xsl:otherwise>
                        </xsl:choose>
					</xsl:when>
                    
                    <!--gomosa si ven precio ref= precio final con iva y comision => nuevo modelo -->
                    <xsl:when test="/Lista/form/ROWSET/MOSTRAR_PRECIO_REFERENCIA">
                    	<xsl:choose>
                        <xsl:when test="TARIFA_EUROS != ' €' and TARIFA_EUROS != '€' and TARIFA_EUROS != '' and /Lista/form/ROWSET/MOSTRAR_PRECIO_REFERENCIA">
                            <span style="margin-right:13px;"><xsl:value-of select="TARIFA_EUROS"/></span>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="document($doc)/translation/texts/item[@name='no_disponible']/node()"/>&nbsp;&nbsp;&nbsp;
                        </xsl:otherwise>
                        </xsl:choose>
                    </xsl:when>
			</xsl:choose>
            
		</td>
		<td align="center">
			&nbsp;<xsl:value-of select="PRO_UNIDADESPORLOTE"/>
		</td>
		<!--si es brasil no enseño iva-->
		<xsl:if test="/Lista/form/ROWSET/IDPAIS = '34'">
			<xsl:choose>
				<xsl:when test="/Lista/form/ROWSET/REDUCIDA"></xsl:when>
				<xsl:otherwise>
					<td class="textRight">
						<xsl:value-of select="PRO_TIPOIVA"/>
					</td>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:if>
		<!--fin if si es brasil-->

		<td class="textRight">
			<xsl:choose>
				<xsl:when test="../REDUCIDA">
					&nbsp;
				</xsl:when>
				<!--consumo se ve solo si es admin o cdc y si no estamos en catalogo especializado-->
				<xsl:when test="(../ADMIN or ../CDC) and /Lista/form/ROWSET/GRUPOPRODUCTOS=''">
					<xsl:value-of select="PRO_CONSUMOTOTAL"/>&nbsp;
				</xsl:when>
				<xsl:otherwise>
					&nbsp;
				</xsl:otherwise>
			</xsl:choose>
		</td>
	</tr>

	<tr id="TR_{PRO_ID}" style="display:none; height:1px; border:none;">
		<td colspan="14">
			<table name="TABLA_SIN_STOCK_{PRO_ID}" id="TABLA_SIN_STOCK_{PRO_ID}" style="display:none; height:1px; border:none;">
				<!--idioma-->
				<xsl:variable name="lang">
					<xsl:choose>
						<xsl:when test="/Lista/LANG"><xsl:value-of select="/Lista/LANG" /></xsl:when>
						<xsl:otherwise>spanish</xsl:otherwise>
					</xsl:choose>
				</xsl:variable>

				<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
				<!--idioma fin-->

				<tr>
					<td style="border:none;">
						<xsl:text>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</xsl:text>
						<input type="checkbox" name="TIPO_ROTURA_STOCK_{PRO_ID}" onclick="CheckStock({PRO_ID});" onchange="CheckStock({PRO_ID});" />&nbsp;
						<xsl:value-of select="document($doc)/translation/texts/item[@name='sin_stock']/node()"/>&nbsp;

						<input type="checkbox" name="TIPO_DESCATALOGADO_{PRO_ID}" onclick="CheckDescat({PRO_ID});" onchange="CheckDescat({PRO_ID});" />&nbsp;
						<xsl:value-of select="document($doc)/translation/texts/item[@name='descatalogado']/node()"/>&nbsp;&nbsp;

						<xsl:value-of select="document($doc)/translation/texts/item[@name='explicacion']/node()"/>&nbsp;
						<input type="text" name="SIN_STOCK_{PRO_ID}"  size="40" maxlength="100"/>&nbsp;
					</td>
				</tr>
				<tr>
					<td style="border:none;">
						<xsl:text>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</xsl:text>
						<xsl:value-of select="document($doc)/translation/texts/item[@name='alternativa']/node()"/>:<xsl:text>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</xsl:text>
						<xsl:value-of select="document($doc)/translation/texts/item[@name='Ref']/node()"/>.&nbsp;
						<input type="text" name="STOCKS_REF_ALT_{PRO_ID}"  size="12" maxlength="12"/><xsl:text>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</xsl:text>
						<xsl:value-of select="document($doc)/translation/texts/item[@name='Prod']/node()"/>.&nbsp;
						<input type="text" name="STOCKS_PROD_ALT_{PRO_ID}"  size="40" maxlength="100"/>

						<xsl:text>&nbsp;&nbsp;</xsl:text>
						<a href="javascript:EnviarSinStock({PRO_ID});"><xsl:value-of select="document($doc)/translation/texts/item[@name='enviar']/node()"/></a>
						<xsl:text>&nbsp;&nbsp;|&nbsp;&nbsp;</xsl:text>
						<a href="javascript:CancelarSinStock({PRO_ID});"><xsl:value-of select="document($doc)/translation/texts/item[@name='cancelar']/node()"/></a>
						<!--vuelve a tener stock-->
						<xsl:text>&nbsp;&nbsp;|&nbsp;&nbsp;</xsl:text>
						<strong><a href="javascript:ConStock({PRO_ID});"><xsl:value-of select="document($doc)/translation/texts/item[@name='con_stock']/node()"/></a></strong>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</xsl:template>

<!--
 |	Los caracteres extraños vienen codificados de la base de datos, hemos de poner:
 |	disable-output-escaping="yes"
 +-->

<xsl:template match="ATRAS">
    <xsl:variable name="code-img-on">DB-Anterior_mov</xsl:variable>
    <xsl:variable name="code-img-off">DB-Anterior</xsl:variable>
    <xsl:variable name="draw-on"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id=$code-img-on]" disable-output-escaping="yes"/></xsl:variable>
    <xsl:variable name="draw-off"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id=$code-img-off]" disable-output-escaping="yes"/></xsl:variable>
	  <a>
            <xsl:attribute name="href">javascript:Navega(document.forms[0],'CANTIDAD_UNI','<xsl:value-of select="@PAG"/>');</xsl:attribute>
            <xsl:attribute name="onMouseOver">cambiaImagen('Anterior','<xsl:value-of select="$draw-on"/>');window.status='Retroceder pagina';return true</xsl:attribute>
            <xsl:attribute name="onMouseOut">cambiaImagen('Anterior','<xsl:value-of select="$draw-off"/>');window.status='';return true</xsl:attribute>
            <img name="Anterior" alt="Pagina anterior" border="0" src="{$draw-off}"/>
          </a>
          <br/>
          <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='G-0110' and @lang=$lang]" disable-output-escaping="yes"/>
</xsl:template>
	          
<xsl:template match="ADELANTE">	  		  
    <xsl:variable name="code-img-on">DB-Siguiente_mov</xsl:variable>
    <xsl:variable name="code-img-off">DB-Siguiente</xsl:variable>    
    <xsl:variable name="draw-on"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id=$code-img-on]" disable-output-escaping="yes"/></xsl:variable>
    <xsl:variable name="draw-off"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id=$code-img-off]" disable-output-escaping="yes"/></xsl:variable>   
    <a>	    
      <xsl:attribute name="href">javascript:Navega(document.forms[0],'CANTIDAD_UNI','<xsl:value-of select="@PAG"/>');</xsl:attribute>
      <xsl:attribute name="onMouseOver">cambiaImagen('Siguiente','<xsl:value-of select="$draw-on"/>');window.status='Avanzar pagina';return true</xsl:attribute>
      <xsl:attribute name="onMouseOut">cambiaImagen('Siguiente','<xsl:value-of select="$draw-off"/>');window.status='';return true</xsl:attribute>
      <img name="Siguiente" alt="Siguiente pagina" border="0" src="{$draw-off}"/>
    </a>
    <br/>
    <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='G-0100' and @lang=$lang]" disable-output-escaping="yes"/>
</xsl:template> 

</xsl:stylesheet>
