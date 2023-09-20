<?xml version="1.0" encoding="iso-8859-1"?>
<!--
	Buscador en catálogo proveedores para "Enviar pedidos"
	Ultima revision: ET 13mar23 12:52 ListaProductos2022_180322.js
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:import href = "http://www.newco.dev.br/General/General.xsl"/>
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="lang" select="@lang"/>

<xsl:template match="/">

<!--	Todos los documentos HTML deben empezar con esto	-->
<xsl:text disable-output-escaping='yes'>&lt;!doctype html></xsl:text>

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

	<title><xsl:value-of select="document($doc)/translation/texts/item[@name='buscador_catalogo_proveedores']/node()"/></title>

	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->

	<script src="http://www.newco.dev.br/General/jquery-3.6.0.js"></script>	
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic2022_010822.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/Compras/Multioferta/BuscadorCatalogoPrivado2022_180322.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/Compras/Multioferta/ListaProductos250814.js"></script>

	<script type="text/javascript">
	  var SeleccionePredet   ='<xsl:value-of select="document($doc)/translation/texts/item[@name='PRO-0360']/node()"/>';
	  var UnidadesNoValidas  ='<xsl:value-of select="document($doc)/translation/texts/item[@name='P3-0290']/node()"/>';
	  var IntrodeceNumLotes  ='<xsl:value-of select="document($doc)/translation/texts/item[@name='PRO-0370']/node()"/>';
	  var LaReferencia	 ='<xsl:value-of select="document($doc)/translation/texts/item[@name='P3-0315']/node()"/>';
	  var EsCorrecta	 ='<xsl:value-of select="document($doc)/translation/texts/item[@name='P3-0320']/node()"/>';
	  var AsigneReferencia   ='<xsl:value-of select="document($doc)/translation/texts/item[@name='P3-0300']/node()"/>';
	  var SeleccionAutomatica='<xsl:value-of select="document($doc)/translation/texts/item[@name='P3-0510']/node()"/>';
	</script>
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
          <p class="textCenter"><xsl:value-of select="document($doc)/translation/texts/item[@name='demasiados_productos_seleccionados']/node()"/>
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
		<xsl:attribute name="action"><xsl:value-of select="@action"/></xsl:attribute>
		<input type="hidden" name="ORDEN" value="{/Lista/form/ROWSET/ORDEN}" />
		<input type="hidden" name="SENTIDO" value="{/Lista/form/ROWSET/SENTIDO}" />
		<input type="hidden" name="xml-stylesheet" value="{../xml-stylesheet}"/>
		<input type="hidden" name="STOCKS_ACCION" value="" />
		<input type="hidden" name="STOCKS_IDPRODUCTO" value="" />
		<input type="hidden" name="STOCKS_COMENTARIOS" value="" />
        <input type="hidden" name="EMPLANTILLAR" value="" />
        <input type="hidden" name="IDPRODUCTO" value="{/Lista/form/ROWSET/IDPRODUCTO}" />
        <input type="hidden" name="STOCKS_TIPO" />
        <input type="hidden" name="SIN_STOCKS" value="{/Lista/form/ROWSET/SINSTOCKS}" />
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


	<!--	Titulo de la página		-->
	<div class="ZonaTituloPagina">
		<p class="TituloPagina">
        	<xsl:value-of select="document($doc)/translation/texts/item[@name='buscador_catalogo_proveedores']/node()"/>
			<span class="fuentePeq">
				<!-- Pagina 1 de 10 -->
				(<xsl:text disable-output-escaping="yes"><xsl:value-of select="document($doc)/translation/texts/item[@name='pagina']/node()"/></xsl:text>
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
				<xsl:if test="//ROWSET/MVM or //ROWSET/CDC">
					&nbsp;|&nbsp;<xsl:value-of select="Lista/form/ROWSET/TOTALES/TOTAL_IMPORTE"/>&nbsp;&nbsp;
				</xsl:if>)
			</span>
			<span class="CompletarTitulo200">
				<!--	botones	-->
				<xsl:choose>
				<xsl:when test="Lista/form/ROWSET/BUTTONS/ATRAS">
					<a class="btnNormal" href="javascript:Navega(document.forms[0],'CANTIDAD_UNI',{Lista/form/ROWSET/BUTTONS/ATRAS/@PAG});"><xsl:value-of select="document($doc)/translation/texts/item[@name='anterior']/node()"/></a>
					&nbsp;
				</xsl:when>
				</xsl:choose>
				<xsl:choose>
				<xsl:when test="Lista/form/ROWSET/BUTTONS/ADELANTE">
					<a class="btnNormal" href="javascript:Navega(document.forms[0],'CANTIDAD_UNI',{Lista/form/ROWSET/BUTTONS/ADELANTE/@PAG});"><xsl:value-of select="document($doc)/translation/texts/item[@name='siguiente']/node()"/></a>&nbsp;
					&nbsp;
				</xsl:when>
				</xsl:choose>
			</span>
		</p>
	</div>
	<br/>
	<br/>
	<div class="divLeft marginLeft100">
		<p class="textLeft fuentePeq" >
		* <xsl:value-of select="document($doc)/translation/texts/item[@name='en_amarillo_mvm_recomienda']/node()"/><br />
		* <!--<img src="http://www.newco.dev.br/images/equiv.gif" alt="Equivalentes" title="Equivalentes"/>--><a href="javascript:null();" class="btnDiscreto">EQ</a>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='equivalentes_expli']/node()"/>
		</p>
	</div>
		
	<div class="tabela tabela_redonda">
	<table cellspacing="6px" cellpadding="6px">
		<thead class="cabecalho_tabela">
		<tr class="h20px">
			<th class="w1px"><xsl:value-of select="document($doc)/translation/texts/item[@name='ima']/node()"/></th>
			<th class="w1px">&nbsp;</th>
			<th class="w1px">&nbsp;</th>
			<th class="w1px">&nbsp;</th>
			<th class="w1px">&nbsp;</th>
			<th class="w1px">&nbsp;</th>
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
			<th class="w100px"><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_prov']/node()"/></th>

			<th class="w100px">
				<a href="javascript:OrdenarPor('PROVEEDOR');"><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/></a><br/>
				<!--	proveedor	-->
				<xsl:if test="/Lista/form/ROWSET/FIDProveedor/field">
					<xsl:call-template name="desplegable">
						<xsl:with-param name="path" select="/Lista/form/ROWSET/FIDProveedor/field"/>
						<xsl:with-param name="onChange">javascript:CambioRestriccion();</xsl:with-param>
						<xsl:with-param name="claSel">filtro</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
			</th>
			<th class="w100px">
				<a href="javascript:OrdenarPor('MARCA');"><xsl:value-of select="document($doc)/translation/texts/item[@name='marca']/node()"/></a><br/>
				<!--	marca	-->
				<xsl:if test="/Lista/form/ROWSET/FMarca/field">
					<xsl:call-template name="desplegable">
						<xsl:with-param name="path" select="/Lista/form/ROWSET/FMarca/field"/>
						<xsl:with-param name="onChange">javascript:CambioRestriccion();</xsl:with-param>
						<xsl:with-param name="claSel">filtro</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
			</th>
			<th class="w100px"><xsl:copy-of select="document($doc)/translation/texts/item[@name='ud_basica_2line']/node()"/></th>
			<th class="w100px textRight">
				<a href="javascript:OrdenarPor('PRECIO');">
                <xsl:choose>
            		<!--viamed y asisa no ven precio ref = precio con o sin iva => viejo modelo -->
                    <xsl:when test="/Lista/form/ROWSET/VIEJO_MODELO">
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

                    <!--gomosa precio final con iva y comision => nuevo modelo -->
                    <xsl:when test="/Lista/form/ROWSET/NUEVO_MODELO">
                    	<xsl:choose>
                        <!--reducida usuario normal, ve precio final, us gomosa, fncp no puede emplantillar, no llega a esta pagina, solo cond de abajo-->
                        <xsl:when test="/Lista/form/ROWSET/REDUCIDA">
                        	<xsl:copy-of select="document($doc)/translation/texts/item[@name='precio_final_c_iva_2line']/node()"/>
						</xsl:when>
                        <xsl:otherwise>
                    		<xsl:copy-of select="document($doc)/translation/texts/item[@name='precio_prov_sin_iva_2line']/node()"/>
                        </xsl:otherwise>
                        </xsl:choose>
                    </xsl:when>

				</xsl:choose>

				</a>
			</th>
			<th class="w50px">&nbsp;<xsl:copy-of select="document($doc)/translation/texts/item[@name='ud_ba_lote_2line']/node()"/></th>
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
			<xsl:when test="(/Lista/form/ROWSET/MVM or /Lista/form/ROWSET/CDC or /Lista/form/ROWSET/ADMIN_CDC) and /Lista/form/ROWSET/GRUPOPRODUCTOS=''">
				<th class="w50px"><a href="javascript:OrdenarPor('CONSUMO');"><xsl:copy-of select="document($doc)/translation/texts/item[@name='consumo_eur_2line']/node()"/></a>&nbsp;</th>
			</xsl:when>
			<xsl:otherwise>
				<th class="w1px">&nbsp;</th>
			</xsl:otherwise>
			</xsl:choose>
		</tr>
		</thead>
		<!--	Cuerpo de la tabla	-->
		<tbody class="corpo_tabela_oculto">
		<xsl:apply-templates select="Lista/form/ROWSET/ROW"/>
		</tbody>
		<tfoot class="rodape_tabela">
			<tr><td colspan="15">&nbsp;</td></tr>
		</tfoot>
		</table>
		</div><!--fin div tabla-->
		<xsl:if test="//ROWSET/IDPRODUCTO != ''">
			<br /><br />
			<div class="botonCenter">
				<!--<a href="javascript:parent.history.go(-1);" title="Volver">Volver</a>-->
				<a href="ListaProductos2022.xsql?LLP_NOMBRE={Lista/form/LLP_NOMBRE}&amp;LLP_PROVEEDOR={Lista/form/LLP_PROVEEDOR}&amp;IDPRODUCTO=" title="Volver"><xsl:value-of select="document($doc)/translation/texts/item[@name='volver']/node()"/></a>
			</div>
			<br /><br />
		</xsl:if>
		</div><!--fin divLeft tabla-->
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
		<xsl:attribute name="class">
			<xsl:choose>
				<xsl:when test="DESTACADO">		
					conhover h40px destacado
				</xsl:when>
				<xsl:otherwise>
					conhover h40px
				</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>
		<td class="color_status">
			<xsl:if test="(count(IMAGENES/IMAGEN)) &gt; 0">
				<xsl:for-each select="IMAGENES/IMAGEN">
					<xsl:if test="@id != '-1' and @num = '1'">
						<a style="text-decoration:none;">
							<xsl:attribute name="href">javascript:FichaProducto('<xsl:value-of select="../../PRO_ID"/>');</xsl:attribute>
							<img src="http://www.newco.dev.br/Fotos/{@peq}" width="40px" height="40px"/>
						</a>
					</xsl:if>
				</xsl:for-each>
			</xsl:if>
		</td>
		<td><!-- Semaforo de stocks	-->
			<xsl:choose>
				<xsl:when test="../CONTROL_STOCKS">
					<xsl:choose>
						<xsl:when test="TEXTO_SIN_STOCK=''">
							<a href="javascript:SinStock({PRO_ID},'','','','');" style="text-decoration:none;">
								<img src="http://www.newco.dev.br/images/SemaforoVerde.gif" />
							</a>
						</xsl:when>
						<xsl:when test="TIPO_SIN_STOCK='S'">
							<a href="javascript:SinStock({PRO_ID},'{TIPO_SIN_STOCK}','{TEXTO_SIN_STOCK}','{REFERENCIAALTERNATIVA}','{DESCRIPCIONALTERNATIVA}');" style="text-decoration:none;">
								<img src="http://www.newco.dev.br/images/bolaAmbar.gif" title="Sin stock: {TEXTO_SIN_STOCK}" />
							</a>
						</xsl:when>
						<xsl:when test="TIPO_SIN_STOCK='D'">
							<a href="javascript:SinStock({PRO_ID},'{TIPO_SIN_STOCK}','{TEXTO_SIN_STOCK}','{REFERENCIAALTERNATIVA}','{DESCRIPCIONALTERNATIVA}');" style="text-decoration:none;">
								<img src="http://www.newco.dev.br/images/bolaRoja.gif" title="Descatalogado: {TEXTO_SIN_STOCK}" />
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
							<img src="http://www.newco.dev.br/images/bolaRoja.gif" title="Descatalogado: {TEXTO_SIN_STOCK}"/>
						</xsl:when>
					</xsl:choose>
				</xsl:when>
			</xsl:choose>
		</td>
		<td>
			<!--si precio no informado =>solo precio asisa, entonces no enseño catalogo, enplantillado...-->
			<!-- DC - 1dic15 - Usuarios MVM y MVMB siempre ven la opcion de catalogar -->
			<xsl:if test="../MVM or (TARIFA_EUROS != ' €' and TARIFA_EUROS != '€' and TARIFA_EUROS != '')">
				<xsl:choose>
					<xsl:when test="../ADMIN_CDC and /Lista/form/ROWSET/GRUPOPRODUCTOS=''">
						<a class="btnDiscreto" href="javascript:FichaAdjudicacion('{PRO_ID}','{/Lista/form/ROWSET/IDEMPRESA}');">CAT</a>
					</xsl:when>
					<!--<xsl:when test="../ADMIN_CDC and not(NONAVEGAR) and /Lista/form/ROWSET/GRUPOPRODUCTOS=''">
						<a href="javascript:FichaAdjudicacion('{PRO_ID}');">
							<img src="http://www.newco.dev.br/images/catalogo.gif" alt="Ver en catálogo" title="Ver en catálogo"/>
						</a>
					</xsl:when>
					<xsl:when test="../ADMIN_CDC and NONAVEGAR and /Lista/form/ROWSET/GRUPOPRODUCTOS=''">
						<a href="javascript:FichaAdjudicacion('{PRO_ID}');">
							<img src="http://www.newco.dev.br/images/catalogoRojo.gif" alt="Ver en catálogo" title="Ver en catálogo"/>
						</a>
					</xsl:when>-->
                    <!--estamos en el listado normal desde enviar pedidos-->
					<xsl:when test="../REDUCIDA and /Lista/form/ROWSET/GRUPOPRODUCTOS =''">
						<xsl:choose>
							<xsl:when test="EMPLANTILLADO">
								<xsl:choose>
									<xsl:when test="/Lista/LANG = 'spanish'">
										<img src="http://www.newco.dev.br/images/enplantillaRojo.png" alt="Emplantillado" title="Emplantillado"/>
									</xsl:when>
									<xsl:when test="/Lista/LANG = 'br'">
										<img src="http://www.newco.dev.br/images/enplantillaRojo-br.png" alt="En planilhas" title="En planilhas"/>
									</xsl:when>
									<xsl:otherwise>
										<img src="http://www.newco.dev.br/images/enplantillaRojo.png" alt="Emplantillado" title="Emplantillado"/>
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
											<span class="botonEmplantillar">
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
                                            </span>
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
										<img src="http://www.newco.dev.br/images/enplantillaRojo.png" alt="Emplantillado" title="Emplantillado"/>
									</xsl:when>
									<xsl:when test="/Lista/LANG = 'br'">
										<img src="http://www.newco.dev.br/images/enplantillaRojo-br.png" alt="En planilhas" title="En planilhas"/>
									</xsl:when>
									<xsl:otherwise>
										<img src="http://www.newco.dev.br/images/enplantillaRojo.png" alt="Emplantillado" title="Emplantillado"/>
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
							<img src="http://www.newco.dev.br/images/enplantillaRojo.png" alt="Emplantillado" title="Emplantillado"/>
						</xsl:when>
						<xsl:when test="/Lista/form/ROWSET/IDPAIS = '55'">
							<img src="http://www.newco.dev.br/images/catalogadoAzulBr.gif" alt="Catalogado" title="Catalogado"/>
						</xsl:when>
						<xsl:otherwise>
							<img src="http://www.newco.dev.br/images/enplantillaRojo.png" alt="Emplantillado" title="Emplantillado"/>
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
				<a href="javascript:Equivalentes({PRO_ID});" class="btnDiscreto">EQ</a>
				<!--<a style="text-decoration:none;">
					<xsl:attribute name="href">javascript:Equivalentes(<xsl:value-of select="PRO_ID"/>);</xsl:attribute>
					<img src="http://www.newco.dev.br/images/equiv.gif" alt="Equivalentes" title="Equivalentes"/>
				</a>-->
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
				<xsl:attribute name="href">javascript:FichaProducto('<xsl:value-of select="PRO_ID"/>');</xsl:attribute>
				<xsl:value-of select="PRO_NOMBRE" disable-output-escaping="yes"/><!--<span class="strongAzul"><xsl:value-of select="PRO_NOMBRE" disable-output-escaping="yes"/></span>-->
			</a>
		</td>
		<td class="w50px textCenter">
			<xsl:value-of select="REFERENCIA_PROVEEDOR"/>
		</td>
		<td class="textLeft">
			<xsl:choose>
				<xsl:when test="IDPLANTILLA != ''">
					<a class="noDecor">
						<xsl:attribute name="href">javascript:SeleccionaPlantilla(<xsl:value-of select="IDPLANTILLA"/>);</xsl:attribute>
						<xsl:value-of select="PROVEEDOR"/>
					</a>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="PROVEEDOR"/>
				</xsl:otherwise>
			</xsl:choose>
		</td>
		<td class="textLeft">
			<xsl:if test="PRO_MARCA!=''">
				<xsl:value-of select="substring(PRO_MARCA,1,15)"/>
			</xsl:if>
		</td>
		<td class="textCenter">
			<xsl:value-of select="PRO_UNIDADBASICA"/>
		</td>
		<!--precio-->
		<td class="textRight">
           	<xsl:choose>
            <!--viamed y asisa no ven precio ref = precio con o sin iva => viejo modelo -->
            <xsl:when test="/Lista/form/ROWSET/VIEJO_MODELO">
                <xsl:choose>
                <!--viamed ve precio con iva-->
                <xsl:when test="/Lista/form/ROWSET/MOSTRAR_PRECIO_CON_IVA and TARIFA_CONIVA_EUROS != '' ">
					<xsl:value-of select="TARIFA_CONIVA_EUROS"/>
                </xsl:when>
                <!--asisa ve precio sin iva-->
                <xsl:when test="TARIFA_EUROS != ''">
                   <xsl:value-of select="TARIFA_EUROS"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="document($doc)/translation/texts/item[@name='no_disponible']/node()"/>&nbsp;&nbsp;
                </xsl:otherwise>
                </xsl:choose>
			</xsl:when>

            <!--gomosa precio final con iva y comision => nuevo modelo -->
            <xsl:when test="/Lista/form/ROWSET/NUEVO_MODELO">
                <xsl:choose>
                <xsl:when test="TARIFA_EUROS != ''">
                    <xsl:value-of select="TARIFA_EUROS"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="document($doc)/translation/texts/item[@name='no_disponible']/node()"/>&nbsp;&nbsp;
                </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
			</xsl:choose>
			&nbsp;
		</td>
		<td class="textRight">
			<xsl:value-of select="PRO_UNIDADESPORLOTE"/>&nbsp;
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
				<xsl:when test="(../MVM or ../CDC) and /Lista/form/ROWSET/GRUPOPRODUCTOS=''">
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
			<table name="TABLA_SIN_STOCK_{PRO_ID}" id="TABLA_SIN_STOCK_{PRO_ID}" style="display:none; height:1px; border:none;" class="buscador">
				<!--idioma-->
				<xsl:variable name="lang">
					<xsl:choose>
						<xsl:when test="/Lista/LANG"><xsl:value-of select="/Lista/LANG" /></xsl:when>
						<xsl:otherwise>spanish</xsl:otherwise>
					</xsl:choose>
				</xsl:variable>

				<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
				<!--idioma fin-->

				<tr class="sinLinea">
					<td class="textLeft w800px">
						&nbsp;<input type="checkbox" class="muypeq" name="TIPO_ROTURA_STOCK_{PRO_ID}" onclick="CheckStock({PRO_ID});" onchange="CheckStock({PRO_ID});" />&nbsp;
						<label><xsl:value-of select="document($doc)/translation/texts/item[@name='sin_stock']/node()"/></label>&nbsp;

						<input type="checkbox" class="muypeq" name="TIPO_DESCATALOGADO_{PRO_ID}" onclick="CheckDescat({PRO_ID});" onchange="CheckDescat({PRO_ID});" />&nbsp;
						<label><xsl:value-of select="document($doc)/translation/texts/item[@name='descatalogado']/node()"/></label>.&nbsp;

						<label><xsl:value-of select="document($doc)/translation/texts/item[@name='explicacion']/node()"/></label>:&nbsp;
						<input type="text" class="campopesquisa w300px" name="SIN_STOCK_{PRO_ID}"  size="60" maxlength="200"/>&nbsp;
					</td>
				</tr>
				<tr class="sinLinea">
					<td class="textLeft">
						&nbsp;<label><xsl:value-of select="document($doc)/translation/texts/item[@name='alternativa']/node()"/>:</label><xsl:text>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</xsl:text>
						<label><xsl:value-of select="document($doc)/translation/texts/item[@name='Ref']/node()"/>.:</label>&nbsp;
						<!-- 18mar22 aumentamos el espacio para la referencia, muchas veces es referencia prov y no referencia MVM	-->
						<input type="text" class="campopesquisa w100px" name="STOCKS_REF_ALT_{PRO_ID}" maxlength="25"/><xsl:text>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</xsl:text>
						<label><xsl:value-of select="document($doc)/translation/texts/item[@name='Prod']/node()"/>.:&nbsp;</label>
						<input type="text" class="campopesquisa w200px" name="STOCKS_PROD_ALT_{PRO_ID}" maxlength="150"/>

						<xsl:text>&nbsp;&nbsp;</xsl:text>
						<a class="btnNormal" href="javascript:CancelarSinStock({PRO_ID});"><xsl:value-of select="document($doc)/translation/texts/item[@name='cancelar']/node()"/></a>
						&nbsp;
						<a class="btnDestacado" href="javascript:EnviarSinStock({PRO_ID});"><xsl:value-of select="document($doc)/translation/texts/item[@name='enviar']/node()"/></a>
						&nbsp;
						<a class="btnDestacado" href="javascript:ConStock({PRO_ID});"><xsl:value-of select="document($doc)/translation/texts/item[@name='con_stock']/node()"/></a>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</xsl:template>

</xsl:stylesheet>
