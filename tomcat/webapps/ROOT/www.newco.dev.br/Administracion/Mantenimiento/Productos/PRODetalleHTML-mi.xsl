<?xml version="1.0" encoding="iso-8859-1"?>
<!--
 | /////////////////////////////////////////////////////////////////////////////
 |
 | Fichero.......: PRODetalleHTML.xsl
 | Autor.........: Montse
 | Fecha.........:
 | Descripcion...: Ficha de producto
 | Funcionamiento:
 |
 |Modificaciones:
 |   Fecha:21/06/2001      Autor:Olivier Jean          Modificacion: poner "valign=top" para que los titulos quedan alineados arriba de la celda - Situacion: __Normal__
 Para testing de la pagina:
 http://www.newco.dev.br/Administracion/Mantenimiento/Productos/PRODetalle.guille.xsql?PRO_ID=38620&US_ID=72
 |(c) 2001 MedicalVM -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:import href = "http://www.newco.dev.br/General/General.xsl"/>
<xsl:import href = "http://www.newco.dev.br/Administracion/Mantenimiento/Productos/ProductosEquivalentes.xsl"/>
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="lang" select="@lang"/>

<xsl:template match="/">
<html>
<head>
	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:choose>
		<xsl:when test="/Productos/LANG"><xsl:value-of select="/Productos/LANG"/></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<title><xsl:value-of select="document($doc)/translation/texts/item[@name='detalle_producto']/node()"/></title>

	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->

	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/ajax.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/Administracion/Mantenimiento/Productos/proIncidencias031213.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/Administracion/Mantenimiento/Productos/proEquivalentes110614.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/Administracion/Mantenimiento/Productos/CargaDocumentos110614.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/litebox.js"></script>

	<link rel="stylesheet" href="http://www.newco.dev.br/General/lightbox.css" type="text/css" media="screen"/>

	<script type="text/javascript">
		var lang	= '<xsl:value-of select="/Productos/LANG"/>';
		var IDIdioma	= '<xsl:value-of select="/Productos/PRODUCTO/PRODUCTO/IDIDIOMA"/>';

		<!-- Mensajes Validacion Formulario Productos Equivalentes -->
		var comprIncidencias	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='comprueba_incidencias']/node()"/>';
		var errRefEquiv		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='errorRefEquiv']/node()"/>';
		var errProvSelEquiv	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='errorProvSelEquiv']/node()"/>';
		var errProvManualEquiv	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='errorProvManualEquiv']/node()"/>';
		var errNombreEquiv	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='errorNombreEquiv']/node()"/>';
		var errMarcaEquiv	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='errorMarcaEquiv']/node()"/>';
		var errEstadoEquiv	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='errorEstadoEquiv']/node()"/>';
		var errNoIDProv		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='errorNoIDProv']/node()"/>';
		var errProvManual	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='errorProvManual']/node()"/>';

		<!-- Mensajes Peticion ajax Nuevo Producto Equivalente -->
		var nuevoEquiv_ok	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='okNuevoEquiv']/node()"/>';
		var nuevoEquiv_error	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='errorNuevoEquiv']/node()"/>';
		var sinFichaTecnica	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='sin_ficha']/node()"/>';

		<!-- Mensajes Peticion ajax Borrar Producto Equivalente -->
		var borrarEquiv_ok	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='okBorrarEquiv']/node()"/>';
		var borrarEquiv_error	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='errorBorrarEquiv']/node()"/>';
		var borrar		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='borrar']/node()"/>';
 		var sinProdEquiv	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='sin_productos_equiv_manuales']/node()"/>';
		var seguroBorrarProducto	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='seguro_borrar_producto']/node()"/>';

		var IDEmpresaCompradora	= '<xsl:value-of select="/Productos/IDEMPRESA_COMPRADORA"/>';
	</script>

	<xsl:text disable-output-escaping="yes"><![CDATA[
	<script type="text/javascript">
	<!--
		jQuery(document).ready(globalEvents);

		function globalEvents(){
			if(IDEmpresaCompradora != '' && jQuery('#IDCLIENTE').length){
				jQuery('#IDCLIENTE').val(IDEmpresaCompradora);
			}
		}

		function getURLParameter(name){
			// Se ha seleccionado la pestanya 'Equivalentes' => Mostrar contenido
			if(decodeURI((RegExp(name + '=' + '(.+?)(&|$)').exec(location.search)||[,null])[1]) == 'EQUIV'){
				verPestana('EQUIV');
			}
		}

		function abrirVentana(pag){
			window.open(pag,toolbar='no',menubar='no',status='no',scrollbars='yes',resizable='yes');
		}

		function MostrarProdEstandar(idProductoEstandar){
			MostrarPagPersonalizada('http://www.newco.dev.br/ProcesosCdC/CatalogoPrivado/MantProductosEstandar.xsql?CATPRIV_IDPRODUCTOESTANDAR='+idProductoEstandar+'&ACCION=CONSULTARPRODUCTOESTANDAR&TIPO=CONSULTA&VENTANA=NUEVA','prodEstandar',100,80,0,0);
		}

		function Salir(){
			window.close();
		}

		function Borrar(){
        	var form = document.forms['Busqueda'];
            //alert('mi '+form.elements['PRO_ID'].value);
        	if (form.elements['PRO_ID'].value != ''){
                if(confirm(seguroBorrarProducto)==true){
                    SubmitForm(document.forms[0]);
                }
            }
		}

		function verCadenaBusqueda(cadena){
			alert(cadena);
		}

		function verPestana(valor){
			if(valor == 'FICHA'){
				jQuery("#productosEquivalentes").hide();
				jQuery("#fichaProducto").show();

				if(lang == 'spanish'){
					jQuery("#pesEquivalentes").attr('src','http://www.newco.dev.br/images/botonEquivalentes.gif');
					jQuery("#pesFicha").attr('src','http://www.newco.dev.br/images/botonFicha1.gif');
				}else{
					jQuery("#pesEquivalentes").attr('src','http://www.newco.dev.br/images/botonEquivalentes.gif');
					jQuery("#pesFicha").attr('src','http://www.newco.dev.br/images/botonFicha1.gif');				
				}
			}

			if(valor == 'EQUIV'){
				jQuery("#fichaProducto").hide();
				jQuery("#productosEquivalentes").show();

				if(lang == 'spanish'){
					jQuery("#pesEquivalentes").attr('src','http://www.newco.dev.br/images/botonEquivalentes1.gif');
					jQuery("#pesFicha").attr('src','http://www.newco.dev.br/images/botonFicha.gif');
				}else{
					jQuery("#pesEquivalentes").attr('src','http://www.newco.dev.br/images/botonEquivalentes1.gif');
					jQuery("#pesFicha").attr('src','http://www.newco.dev.br/images/botonFicha.gif');				
				}
			}
		}//fin de verPestana

	        //funcion que enseña en el eis los datos del centro o de la empresa segun un producto, agrupar por producto siempre    
        	function MostrarEIS(indicador, idempresa, idcentro, refPro, anno){
			var Enlace;

			Enlace='http://www.newco.dev.br/Gestion/EIS/EISDatos2.xsql?'
				+'IDCUADROMANDO='+indicador
				+'&ANNO='+anno
				+'&IDEMPRESA='+idempresa
				+'&IDCENTRO='+idcentro
				+'&IDUSUARIO='
				+'&IDPRODUCTO=-1'
				+'&IDGRUPOCAT=-1'
				+'&IDSUBFAMILIA=-1'
				+'&IDESTADO=-1'
				+'&REFERENCIA='+refPro
				+'&CODIGO='
				+'&AGRUPARPOR=REF';

			MostrarPagPersonalizada(Enlace,'EIS',100,80,0,0);
		}
	-->
	</script>
	]]></xsl:text>
</head>

<body onload="getURLParameter('DEST');">
<xsl:choose>
<xsl:when test="Productos/SESION_CADUCADA">
	<xsl:for-each select="Productos/SESION_CADUCADA">
		<xsl:if test="position()=last()">
			<xsl:apply-templates select="."/>
		</xsl:if>
	</xsl:for-each>
</xsl:when>
<xsl:when test="//xsql-error">
	<xsl:apply-templates select="//xsql-error"/>
</xsl:when>
<xsl:when test="Productos/LIC_PROD_ID != ''">
	<xsl:apply-templates select="Productos/PRODUCTO/PRODUCTOLICITACION"/>
</xsl:when>
<!--si borramos el producto devuelve esto-->
<xsl:when test="not(Productos/PRODUCTO/PRODUCTO) or Productos/PRODUCTO/PRODUCTO/PRO_STATUS = 'B' ">
	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:choose>
		<xsl:when test="/Productos/LANG"><xsl:value-of select="/Productos/LANG" /></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<h1 class="titlePage">
    	<xsl:choose>
        <xsl:when test="/Productos/PRODUCTO_BORRADO/OK or Productos/PRODUCTO/PRODUCTO/PRO_STATUS = 'B'">
    		<xsl:value-of select="document($doc)/translation/texts/item[@name='producto_eliminado']/node()"/>
        </xsl:when>
        <xsl:when test="/Productos/PRODUCTO_BORRADO/ERROR">
        	<xsl:value-of select="/Productos/PRODUCTO_BORRADO/ERROR"/>
        </xsl:when>
        </xsl:choose>
	</h1>
    
    <p>&nbsp;</p>
    <p style="text-align:center;">
            <img src="http://www.newco.dev.br/images/cerrar.gif" />&nbsp;
                <a href="javascript:Salir();" title="cerrar"><xsl:value-of select="document($doc)/translation/texts/item[@name='cerrar']/node()"/></a>
    </p>
</xsl:when>
<xsl:otherwise>

	<!--<xsl:choose>
    <xsl:when test="Productos/PRODUCTO/PRODUCTO/PRO_STATUS = 'B'">
    	<h1 class="titlePage">
    		<xsl:value-of select="document($doc)/translation/texts/item[@name='producto_eliminado']/node()"/>
    	</h1>
    </xsl:when>
    <xsl:otherwise>-->
		<xsl:apply-templates select="Productos/PRODUCTO/PRODUCTO"/>
   <!-- </xsl:otherwise>
    </xsl:choose>-->
    
</xsl:otherwise>
</xsl:choose>
</body>
</html>
</xsl:template>

<xsl:template match="PRODUCTO">
	<form action="http://www.newco.dev.br/Administracion/Mantenimiento/Productos/PROBorrarSave.xsql" name="Busqueda" method="POST">
		<input type="hidden" name="PRO_ID" value="{PRO_ID}"/>
	</form>

	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:choose>
		<xsl:when test="/Productos/LANG"><xsl:value-of select="/Productos/LANG" /></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<xsl:variable name="usuario">
		<xsl:choose>
		<xsl:when test="/Productos/PRODUCTO/PRODUCTO/OBSERVADOR">OBSERVADOR</xsl:when>
		<xsl:when test="/Productos/PRODUCTO/PRODUCTO/MVM or /Productos/PRODUCTO/PRODUCTO/MVMB or /Productos/PRODUCTO/PRODUCTO/CDC">CDC</xsl:when>
		<xsl:otherwise>NORMAL</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>

	<div style="background:#fff;float:left;">
		<a href="javascript:verPestana('FICHA')" style="text-decoration:none;">
		<xsl:choose>
		<xsl:when test="/Productos/LANG = 'spanish'">
			<img src="http://www.newco.dev.br/images/botonFicha1.gif" alt="FICHA" id="pesFicha"/>
		</xsl:when>
		<xsl:otherwise>
			<img src="http://www.newco.dev.br/images/botonFicha1.gif" alt="FICHA" id="pesFicha"/>
		</xsl:otherwise>
		</xsl:choose>
		</a>

		<!--productos equivalentes-->
		<xsl:if test="$usuario = 'CDC' or $usuario = 'OBSERVADOR'">
			&nbsp;
			<a href="javascript:verPestana('EQUIV')" style="text-decoration:none;">
			<xsl:choose>
			<xsl:when test="/Productos/LANG = 'spanish'">
				<img src="http://www.newco.dev.br/images/botonEquivalentes.gif" alt="EQUIVALENTES" id="pesEquivalentes"/>
			</xsl:when>
			<xsl:otherwise>
				<img src="http://www.newco.dev.br/images/botonEquivalentes-Br.gif" alt="EQUIVALENTES" id="pesEquivalentes"/>
			</xsl:otherwise>
			</xsl:choose>
			</a>
		</xsl:if>

			&nbsp;
	</div><!--fin de bloque de pestañas-->

	<div style="background:#fff;float:right;">
		<xsl:if test="/Productos/PRODUCTO/PRODUCTO/INCIDENCIAS/INCIDENCIA and /Productos/PRODUCTO/PRODUCTO/REFERENCIA_PRIVADA != ''">
			&nbsp;
			<a href="http://www.newco.dev.br/Administracion/Mantenimiento/Productos/Incidencias.xsql?PRO_ID={/Productos/PRODUCTO/PRODUCTO/PRO_ID}&amp;USER={$usuario}&amp;PRO_NOMBRE={/Productos/PRODUCTO/PRODUCTO/PRO_NOMBRE}"  style="text-decoration:none;">
			<xsl:choose>
			<xsl:when test="/Productos/LANG = 'spanish'">
				<img src="http://www.newco.dev.br/images/botonIncidencias.gif" alt="INCIDENCIAS"/>
			</xsl:when>
			<xsl:otherwise>
				<img src="http://www.newco.dev.br/images/botonIncidencias-Br.gif" alt="INCIDENCIAS"/>
			</xsl:otherwise>
			</xsl:choose>
			</a>
		</xsl:if>

		<xsl:if test="not(/Productos/PRODUCTO/PRODUCTO/MVM) and /Productos/PRODUCTO/PRODUCTO/REFERENCIA_PRIVADA != '' and $usuario != 'OBSERVADOR'">
			&nbsp;
			<a href="http://www.newco.dev.br/Administracion/Mantenimiento/Productos/NuevaIncidencia.xsql?PRO_ID={/Productos/PRODUCTO/PRODUCTO/PRO_ID}&amp;USER={$usuario}"  style="text-decoration:none;">
			<xsl:choose>
			<xsl:when test="/Productos/LANG = 'spanish'">
				<img src="http://www.newco.dev.br/images/botonNuevaIncidencia.gif" alt="NUEVAINCIDENCIA"/>
			</xsl:when>
			<xsl:otherwise>
				<img src="http://www.newco.dev.br/images/botonNuevaIncidencia-Br.gif" alt="NUEVAINCIDENCIA"/>
			</xsl:otherwise>
			</xsl:choose>
			</a>
		</xsl:if>
        
        
	</div> 
  
	<!--productos equivalentes-->
	<div class="divLeft" id="productosEquivalentes" style="display:none;">
		<xsl:call-template name="productosEquivalentes">
			<xsl:with-param name="pro_id" select="/Productos/PRODUCTO/PRODUCTO/EQUIVALENTES/IDPRODUCTOESTANDAR"/>
		</xsl:call-template>
	</div><!--fin de productos equivalentes-->
         
	<!--ficha producto normal-->
	<div id="fichaProducto">
		<!--nombre producto-->
		<div class="divLeft">
			<h1 class="titlePage" style="float:left;width:70%;padding-left:10%;">
			<xsl:choose>
			<xsl:when test="NOMBRE_PRIVADO">
				<xsl:value-of select="NOMBRE_PRIVADO"/>
				<xsl:if test="MVM">
					<span class="font11">&nbsp;
	        				<xsl:if test="USUARIO/NOMBRE != ''"><xsl:value-of select="document($doc)/translation/texts/item[@name='responsable']/node()"/>: <xsl:value-of select="USUARIO/NOMBRE"/></xsl:if>
						&nbsp;&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='fecha']/node()"/>: <xsl:value-of select="ALTA" />
					</span>
				</xsl:if>
			</xsl:when>
			<xsl:when test="PRO_ID">

				<xsl:choose>
				<xsl:when test="string-length(PRO_NOMBRE) > 75">
					<xsl:value-of select="substring(PRO_NOMBRE, 1, 75)"/>...
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="PRO_NOMBRE"/>
				</xsl:otherwise>
				</xsl:choose>

				<xsl:if test="MVM">
					<span class="font11">&nbsp;
						<xsl:if test="USUARIO/NOMBRE != ''"><xsl:value-of select="document($doc)/translation/texts/item[@name='responsable']/node()"/>: <xsl:value-of select="USUARIO/NOMBRE"/></xsl:if>
						<xsl:if test="ALTA != ''">
							&nbsp;&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='fecha']/node()"/>: <xsl:value-of select="ALTA" />
						</xsl:if>
					</span>
				</xsl:if>
                
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="document($doc)/translation/texts/item[@name='producto_borrado_maiu']/node()"/>
			</xsl:otherwise>
			</xsl:choose>
            
			</h1>

			<h1 class="titlePage" style="float:left;width:20%">
				<xsl:if test="/Productos/PRODUCTO/PRODUCTO/MVM or /Productos/PRODUCTO/PRODUCTO/CDC"><span style="float:right; padding:5px; font-weight:bold;" class="amarillo">PRO_ID: <xsl:value-of select="PRO_ID"/></span></xsl:if>
			</h1>
		</div>

	<xsl:if test="/Productos/PRODUCTO/PRODUCTO/MVM">
		<div style="height:30px;padding-top:10px;text-align:center;clear:both;">
			<form action="http://www.newco.dev.br/Administracion/Mantenimiento/Productos/PRODetalle.xsql" name="Cliente" method="POST">
				<input type="hidden" name="PRO_ID" value="{PRO_ID}"/>

				<xsl:value-of select="document($doc)/translation/texts/item[@name='cliente']/node()"/>:&nbsp;
				<xsl:call-template name="desplegable">
					<xsl:with-param name="path" select="/Productos/PRODUCTO/PRODUCTO/CLIENTESADJ/field[@name='IDCLIENTE']/."/>
                                        <xsl:with-param name="onChange">this.form.submit();</xsl:with-param>
				</xsl:call-template>
			</form>
		</div>
	</xsl:if>

	<!--datos originales producto-->
	<xsl:if test="(NOMBRE_PRIVADO or PRO_ID) and ORIGINAL">
		<div class="divLeft">
			<div class="originalPro divLeft">
				<xsl:attribute name="id">
					<xsl:if test="number(ORIGINAL/ANTIGUEDAD) &gt; number(365)">backAma</xsl:if><!--amarillo-->
					<xsl:if test="number(ORIGINAL/ANTIGUEDAD) &lt; number(365)">backRojo</xsl:if><!--rojo-->
				</xsl:attribute>

				<p><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='datos_originales_maiu']/node()"/></strong></p>
				<p>&nbsp;</p>
				<!--valores prod original-->
				<p><label><xsl:value-of select="document($doc)/translation/texts/item[@name='tarifa']/node()"/>:</label>
					<xsl:value-of select="ORIGINAL/TARIFA"/>
				</p>
				<p>&nbsp;</p>
				<p><label><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha']/node()"/>:</label>
					<xsl:value-of select="ORIGINAL/FECHA"/>
				</p>
				<p>&nbsp;</p>
				<!--  <p><a style="color:#000000;">
					<xsl:attribute name="href">javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Productos/PRODetalle.xsql?PRO_ID=<xsl:value-of select="ORIGINAL/ID"/>','producto',70,50,0,-50);</xsl:attribute>
				Ver original</a></p>-->
				<p><a style="color:#000000;" target="_blank">
					<xsl:attribute name="href">PRODetalle.xsql?PRO_ID=<xsl:value-of select="ORIGINAL/ID"/></xsl:attribute>
				<xsl:value-of select="document($doc)/translation/texts/item[@name='ver_original']/node()"/></a></p>
			</div>
		</div><!--fin divLeft-->
	</xsl:if>

	<!--si prod no esta borrado enseño tabla-->
	<xsl:if test="NOMBRE_PRIVADO or PRO_ID">
	
    <div class="divLeft">
    <table class="prodTabla" border="0">
    <tr>
		<xsl:choose>
		<xsl:when test="NOMBRE_PRIVADO">
			<td class="label" width="32%"><xsl:value-of select="document($doc)/translation/texts/item[@name='nombre_privado']/node()"/>:</td>
			<td class="datosLeft">
				<xsl:choose>
				<xsl:when test="CDC">
					<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/ProcesosCdC/MantenimientoReducido/MantenimientoReducido.xsql?PRO_ID={PRO_ID}&amp;EMP_ID={IDEMPRESADELUSUARIO}','ficha catalogacion',100,80,0,0);">
						<span style="font-size:16px;"><strong><xsl:value-of select="NOMBRE_PRIVADO" disable-output-escaping="yes"/></strong></span>
					</a>
				</xsl:when>
				<xsl:otherwise>
					<strong><xsl:value-of select="NOMBRE_PRIVADO" disable-output-escaping="yes"/></strong>
				</xsl:otherwise>
				</xsl:choose>
			<xsl:if test="PRO_ENLACEFICHA!=''">
				<xsl:text>&nbsp;&nbsp;[&nbsp;</xsl:text>
				<a href="javascript:MostrarPag('FichaTecnica.xsql?FICHA_IMG={PRO_ENLACEFICHA}','ficha');"><xsl:value-of select="document($doc)/translation/texts/item[@name='ver_ficha_tecnica']/node()"/></a>
				<xsl:text>&nbsp;]</xsl:text>
			</xsl:if>

			<!--enseño en un alert la cadena de busqueda para este prod solo si mvm-->
			<xsl:if test="MVM">
				&nbsp;<a href="javascript:verCadenaBusqueda('{CADENABUSQUEDA}')">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='busquedas']/node()"/>
				</a>
			</xsl:if>
			</td>
		</xsl:when>
		<xsl:when test="PRO_ID">
			<td class="label" width="32%"><xsl:value-of select="document($doc)/translation/texts/item[@name='nombre_privado']/node()"/>:</td>
			<td class="datosLeft"><strong><xsl:value-of select="PRO_NOMBRE" disable-output-escaping="yes"/></strong>
			<xsl:if test="PRO_ENLACEFICHA!=''">
				<xsl:text>&nbsp;&nbsp;[&nbsp;</xsl:text>
				<a href="javascript:MostrarPag('FichaTecnica.xsql?FICHA_IMG={PRO_ENLACEFICHA}','ficha');"><xsl:value-of select="document($doc)/translation/texts/item[@name='ver_ficha_tecnica']/node()"/></a>
				<xsl:text>&nbsp;]</xsl:text>
			</xsl:if>

			<!--enseño en un alert la cadena de busqueda para este prod solo si mvm-->
			<xsl:if test="MVM">
				&nbsp;<a href="javascript:verCadenaBusqueda('{CADENABUSQUEDA}')">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='busquedas']/node()"/>
				</a>
			</xsl:if>
			</td>
		</xsl:when>
		</xsl:choose>

 		</tr>
        <xsl:if test="/Productos/PRODUCTO/PRODUCTO/MVM or /Productos/PRODUCTO/PRODUCTO/CDC">
		<tr>
			<td class="label"><xsl:value-of select="document($doc)/translation/texts/item[@name='nombre_proveedor']/node()"/>:</td>
			<td class="datosLeft"><xsl:value-of select="PRO_NOMBRE" disable-output-escaping="yes"/></td>
		</tr>
		</xsl:if>
        </table>
    </div><!--fin de divLeft-->
    
    <div class="divLeft">
    <!--imagen producto, logo-->
    <div class="divLeft20">
    	<p>&nbsp;</p>
        <p>&nbsp;</p>
    	<p><img src="http://www.newco.dev.br/Documentos/{/Productos/PRODUCTO/PRODUCTO/URL_LOGOTIPO}" height="auto" width="110px" style="padding-left:10px"/></p>
        <p>&nbsp;</p>
        <!--imagenes-->
            <xsl:if test="(count(/Productos/PRODUCTO/PRODUCTO/IMAGENES/IMAGEN)) &gt; 0">
                  <xsl:for-each select="/Productos/PRODUCTO/PRODUCTO/IMAGENES/IMAGEN">
                      <xsl:if test="@id != '-1'">
                        <p><a href="http://www.newco.dev.br/Fotos/{@grande}" rel="lightbox" title="Foto producto" style="text-decoration:none;">
                          <img src="http://www.newco.dev.br/Fotos/{@peq}" class="imagenProDetalle" style="width:110px;"/>
                        </a></p>
                      </xsl:if>
                  </xsl:for-each>
                
            </xsl:if>
 		<!--fin de imagenes-->
    </div><!--fin de divLeft30-->
    
    <!--tabla especificas producto-->
	<div class="divLeft35">
	<table class="prodTabla" border="0">
		<tr height="5px;">
			<td class="veintecinco" height="5px;">&nbsp;</td>
			<td height="5px;">&nbsp;</td>
		</tr>

	<tbody>
		<tr>
			<!--ref provee-->
			<td class="label trenta"><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_proveedor']/node()"/>:</td>
			<td><xsl:apply-templates select="REFERENCIA_PROVEEDOR"/></td>
		</tr>
		<tr>
			<!--proveedor-->
			<td class="label"><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/>:</td>
			<td><xsl:apply-templates select="/Productos/PRODUCTO/PRODUCTO/PROVEEDOR"/></td>
		</tr>
		<xsl:if test="REFERENCIA_CLIENTE !=''">
		<tr>
			<!--referencia cliente-->
			<td class="label"><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_cliente']/node()"/>:</td>
			<td><xsl:value-of select="REFERENCIA_CLIENTE"/></td>
		</tr>
		</xsl:if>
        <xsl:if test="REFERENCIA_PRIVADA !=''">
		<tr>
			<!--ref estandar propuesta-->
			<td class="label"><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_estandar']/node()"/>:</td>
			<td><xsl:apply-templates select="REFERENCIA_PRIVADA"/></td>
		</tr>
		</xsl:if>
        <xsl:if test="PRO_MARCA !=''">
		<tr>
			<!--marca-->
			<td class="label"><xsl:value-of select="document($doc)/translation/texts/item[@name='marca']/node()"/>:</td>
			<td><xsl:value-of select="PRO_MARCA" disable-output-escaping="yes"/></td>
		</tr>
        </xsl:if>

	<!--Nomenclator, especialidades-->
	<xsl:choose>
	<xsl:when test="NOM_NOMBRECOMPLETO != '' and ESPECIALIDADES_PRODUCTO != ''">
		<tr>
			<td class="label"><xsl:value-of select="document($doc)/translation/texts/item[@name='nomenclator']/node()"/>:</td>
			<td><xsl:apply-templates select="NOM_NOMBRECOMPLETO"/></td>
		</tr>
		<tr>
			<td class="label"><xsl:value-of select="document($doc)/translation/texts/item[@name='especialidad_producto']/node()"/>:</td>
			<td><xsl:value-of select="ESPECIALIDADES_PRODUCTO" disable-output-escaping="yes"/></td>
		</tr>
	</xsl:when>
	<xsl:when test="NOM_NOMBRECOMPLETO != '' and ESPECIALIDADES_PRODUCTO = ''">
		<tr>
			<td class="label"><xsl:value-of select="document($doc)/translation/texts/item[@name='nomenclator']/node()"/>:</td>
			<td><xsl:apply-templates select="NOM_NOMBRECOMPLETO"/></td>
		</tr>
	</xsl:when>
	<xsl:when test="NOM_NOMBRECOMPLETO = '' and ESPECIALIDADES_PRODUCTO != ''">
		<tr>
			<td colspan="2" class="label"><xsl:value-of select="document($doc)/translation/texts/item[@name='especialidad_producto']/node()"/>:</td>
			<td><xsl:value-of select="ESPECIALIDADES_PRODUCTO" disable-output-escaping="yes"/></td>
		</tr>
	</xsl:when>
	</xsl:choose>

	<xsl:if test="PRO_DESCRIPCION != ''">
		<tr>
			<td class="label" valign="top"><xsl:value-of select="document($doc)/translation/texts/item[@name='descripcion']/node()"/>:</td>
			<td><xsl:value-of select="PRO_DESCRIPCION"  disable-output-escaping="yes"/>&nbsp;</td>
		</tr>
	</xsl:if>
    <tr> 
       <!--unidad basica-->
        <td class="label"><xsl:value-of select="document($doc)/translation/texts/item[@name='unidad_basica']/node()"/>:</td>
      	<td><xsl:apply-templates select="PRO_UNIDADBASICA"/>&nbsp;</td>
     </tr> 
	 <tr>  
       <!--unidad lote--> 
         <td class="label"><xsl:value-of select="document($doc)/translation/texts/item[@name='unidad_lote']/node()"/>:</td>
      	<td><xsl:apply-templates select="PRO_UNIDADESPORLOTE"/>&nbsp;</td>
    </tr>
   
    <!--farmacia-->
     <tr>
     	<td class="label"><xsl:value-of select="document($doc)/translation/texts/item[@name='farmacia']/node()"/>:</td>
        <td><xsl:choose>
        	<xsl:when test="PRO_CATEGORIA='F'">
            	<input type="checkbox" name="PRO_CATEGORIA_CHK" checked="checked" disabled="disabled"/>
        	</xsl:when>
        	<xsl:otherwise>
            	<input type="checkbox" name="PRO_CATEGORIA_CHK" disabled="disabled"/>
        	</xsl:otherwise>
        	</xsl:choose>
        </td>
      </tr>
       <tr>	
      	<td class="label"><xsl:value-of select="document($doc)/translation/texts/item[@name='homologado']/node()"/>:</td>
        <td><xsl:apply-templates select="PRO_HOMOLOGADO"/></td>
      </tr>
      <tr>
      	<td class="label"><xsl:value-of select="document($doc)/translation/texts/item[@name='certificacion']/node()"/>:</td>
        <td> <xsl:apply-templates select="PRO_CERTIFICADOS"/>
             	
                    <xsl:choose>
                      <xsl:when test="PRO_ENLACECERTIFICADO!=''">
                        &nbsp;<a href="javascript:MostrarPag('Certificado.xsql?CERT_IMG={PRO_ENLACECERTIFICADO}','certificado');"><xsl:value-of select="document($doc)/translation/texts/item[@name='ver_certificado']/node()"/></a>
                      </xsl:when>
                      <xsl:otherwise>
                        &nbsp;
                      </xsl:otherwise>
                    </xsl:choose></td>
      </tr>
    </tbody>
    </table>
</div><!--fin de divLeft40-->
    
<div class="divLeft40nopa">
<!--tabla precios producto-->
<table class="prodTabla" border="0">
	<tr height="5px;">
    <td class="cuarenta" height="5px;">&nbsp;</td>
    <td height="5px;">&nbsp;</td>
    </tr>
	<tbody>
    
     <!--precio unidad basica, si esta vacio no enseño y implica que hay solo precio asisa quitado-8-4-14 cambiado como devuelve precios segun quien es
     <xsl:choose>
         <xsl:when test="/Productos/PRODUCTO/PRODUCTO/TARIFACLIENTE/TARIFA_EURO_CONFORMATO != ''">
        	<tr> 
            <td class="label"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='precio_final_s_iva']/node()"/>:</strong></td> 
            <td><strong><xsl:value-of select="/Productos/PRODUCTO/PRODUCTO/TARIFACLIENTE/TARIFA_EURO_CONFORMATO"/></strong></td>
            </tr>
            <xsl:if test="/Productos/PRODUCTO/PRODUCTO/IDPAIS = '34'">
                <tr>
                <td class="label"><xsl:value-of select="document($doc)/translation/texts/item[@name='iva']/node()"/>:</td>
                <td><xsl:apply-templates select="PRO_TIPOIVA"/></td>
                </tr>
            </xsl:if>
        </xsl:when>
        <xsl:otherwise>
        <tr>
        	<xsl:choose>
            <xsl:when test="//Productos/PRODUCTO/PRODUCTO/MVM or //Productos/PRODUCTO/PRODUCTO/MVMB">
                <td colspan="2" align="center"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='no_hay_precio_mvm']/node()"/></strong></td>
            </xsl:when>
            <xsl:otherwise>
                <td colspan="2" align="center"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='no_hay_precio']/node()"/></strong></td>
            </xsl:otherwise>
            </xsl:choose>
        </tr>
        </xsl:otherwise>
        </xsl:choose>-->

        <xsl:choose>
        <xsl:when test="/Productos/PRODUCTO/PRODUCTO/DATOS_CLIENTE">
    <xsl:for-each select="/Productos/PRODUCTO/PRODUCTO/DATOS_CLIENTE">
    	<xsl:if test="TARIFA_EURO_CONFORMATO != ''">
            <tr>
                <td class="label"><xsl:value-of select="document($doc)/translation/texts/item[@name='precio']/node()"/>&nbsp;<xsl:value-of select="NOMBRE_CORTO"/>:</td>
                <td><xsl:value-of select="TARIFA_EURO_CONFORMATO"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='euro']/node()"/></td>
            </tr>  
        </xsl:if>  
    </xsl:for-each>
        </xsl:when>
        <xsl:otherwise>
            <tr>
                <td class="label"><xsl:value-of select="document($doc)/translation/texts/item[@name='precio']/node()"/>:</td>
                <td><xsl:value-of select="/Productos/PRODUCTO/PRODUCTO/TARIFACLIENTE/TARIFA_EURO_CONFORMATO"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='euro']/node()"/></td>
            </tr>            
        </xsl:otherwise>
        </xsl:choose>

   </tbody>
 </table>
 </div><!--fin divLeft35-->

</div><!--fin de divLeft-->

<div class="divLeft">
    <!--tabla de las ofertas-->
    <table class="prodTabla" border="0">
	<tr>
    <td height="5px;">&nbsp;</td>
    <td height="5px;">&nbsp;</td>
    </tr>
    <tbody>
<!--<xsl:for-each select="/Productos/PRODUCTO/PRODUCTO/DATOS_CLIENTE/OFERTAS/field/dropDownList/listElem[ID != '-1']">-->
    <xsl:for-each select="/Productos/PRODUCTO/PRODUCTO/DATOS_CLIENTE">
    <xsl:if test="OFERTA">
    	<tr>
        	<td class="label" width="32%"><xsl:value-of select="document($doc)/translation/texts/item[@name='oferta']/node()"/>&nbsp;<xsl:value-of select="NOMBRE_CORTO"/>:</td>
            <td class="datosLeft">
                <xsl:value-of select="OFERTA/NOMBRE"/>&nbsp;&nbsp;
                <a target="_blank" style="text-decoration:none;">
					<xsl:attribute name="href">http://www.newco.dev.br/Documentos/<xsl:value-of select="OFERTA/URL"/></xsl:attribute>
					<img src="http://www.newco.dev.br/images/descarga.gif" alt="Descarga"/>
				</a>&nbsp;
                <!--si tiene documentos anexos-->
				<xsl:if test="OFERTA/DOCUMENTOHIJO">
				<xsl:for-each select="OFERTA/DOCUMENTOHIJO">
					<!--<xsl:value-of select="NOMBRE"/>&nbsp;
					( .<xsl:value-of select="substring-after(URL,'.')"/> )-->
					<a target="_blank" style="text-decoration:none;">
						<xsl:attribute name="href">http://www.newco.dev.br/Documentos/<xsl:value-of select="URL"/></xsl:attribute><img src="http://www.newco.dev.br/images/anexo.gif" alt="Anexo"/></a>&nbsp;
				</xsl:for-each>
				</xsl:if>
            </td>
        </tr>
    </xsl:if>
    </xsl:for-each>

	<!--ficha tecnica-->
	<xsl:if test="FICHA_TECNICA != '' and FICHA_TECNICA/NOMBRE != ''">
		<tr>
			<td class="label" width="32%"><xsl:value-of select="document($doc)/translation/texts/item[@name='ficha_tecnica']/node()"/>:</td>
			<td class="datosLeft">
				<xsl:value-of select="FICHA_TECNICA/NOMBRE"/>&nbsp;&nbsp;
				( .<xsl:value-of select="substring-after(FICHA_TECNICA/URL,'.')"/> )
				<a target="_blank">
					<xsl:attribute name="href">http://www.newco.dev.br/Documentos/<xsl:value-of select="FICHA_TECNICA/URL"/></xsl:attribute>
					<img src="http://www.newco.dev.br/images/descarga.gif" alt="Descarga"/>
				</a>
			</td>
		</tr>
	</xsl:if><!--fin de if documento-->

	<!--documentos comerciales-->
   <xsl:if test="MVM and DOCUMENTOS_COMERCIALES_PROV/DOCUMENTO">
   <tr>
   <td colspan="2">   
    <table class="infoTableAma">
    <tr>
    <td width="25%">&nbsp;</td>
    <td colspan="2"><span class="rojo">
    <xsl:value-of select="document($doc)/translation/texts/item[@name='documentos_comerciales']/node()"/>&nbsp;[<xsl:value-of select="document($doc)/translation/texts/item[@name='confidencial_mvm']/node()"/>]:</span>
    </td>
    <td valign="top">&nbsp;</td>
    </tr>
   <xsl:for-each select="DOCUMENTOS_COMERCIALES_PROV/DOCUMENTO">
 	<tr>
    <td class="uno">&nbsp;</td>
    <td valign="top" colspan="3">
        <xsl:value-of select="NOMBRE"/>&nbsp;
        ( .<xsl:value-of select="substring-after(URL,'.')"/> )
    	<a target="_blank">
        <xsl:attribute name="href">http://www.newco.dev.br/Documentos/<xsl:value-of select="URL"/></xsl:attribute>
        <img src="http://www.newco.dev.br/images/descarga.gif" alt="Descarga"/>
        </a>
    </td>
    </tr>
  </xsl:for-each>
  </table>
  </td>
  </tr>
  </xsl:if>
 </tbody>
</table>
</div><!--fin de divLeft-->



<br /><br />
<div class="divLeft">
	 <xsl:if test="/Productos/PRODUCTO/PRODUCTO/LICITACIONESPRODUCTO/LICITACION ">
      	<xsl:apply-templates select="/Productos/PRODUCTO/PRODUCTO/LICITACIONESPRODUCTO"/>
    </xsl:if>
</div>
<div class="divLeft">
  <!--	Tarifas  tabla si precio mvm esta informado, si no no
  <xsl:if test="../PRODUCTO/MVM">-->	
    <xsl:if test="../LasTarifas/TARIFAS and ../LasTarifas/TARIFAS/TARIFAS_ROW[last()]/TRF_IMPORTE != ''">
      <xsl:apply-templates select="../LasTarifas/TARIFAS"/>
    </xsl:if>
  <!--</xsl:if>-->
<!--	Catalogos	-->
<xsl:if test="../CATALOGOS/CATALOGO">
  <xsl:apply-templates select="../CATALOGOS"/>
</xsl:if>

<xsl:if test="CONSUMOPORCENTRO/CENTRO">
  <xsl:apply-templates select="CONSUMOPORCENTRO"/>
</xsl:if>
</div>

<!--buttons--><br /><br  />

  <div class="divLeft" style="margin-top:40px; padding:5px 0px; background:#FF9;">
 
 		<xsl:if test="MVM and PRO_ID"> 
        
  			<div class="divLeft40">&nbsp;</div>
            <div class="boton">
        		<a href="javascript:Borrar();" title="borrar"><xsl:value-of select="document($doc)/translation/texts/item[@name='borrar_producto']/node()"/></a>
  			</div>
		</xsl:if>
       
        
 </div><!--fin de buttons-->
 </xsl:if><!--fin de if si prod no es borrado-->
 
</div><!--fin div fichaproducto-->
</xsl:template>   
<!--fin de producto normal-->


<!--producto licitacion-->
<xsl:template match="PRODUCTOLICITACION">
	<form action="http://www.newco.dev.br/Administracion/Mantenimiento/Productos/PROBorrarSave.xsql" name="Busqueda" method="POST">
		<input type="hidden" name="PRO_ID" value="{PRO_ID}"/>
	</form>

	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:choose>
		<xsl:when test="/Productos/LANG"><xsl:value-of select="/Productos/LANG" /></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<xsl:variable name="usuario">
		<xsl:choose>
		<xsl:when test="/Productos/PRODUCTO/PRODUCTO/OBSERVADOR">OBSERVADOR</xsl:when>
		<xsl:when test="/Productos/PRODUCTO/PRODUCTOLICITACION/MVM or /Productos/PRODUCTO/PRODUCTOLICITACION/MVMB or /Productos/PRODUCTO/PRODUCTOLICITACION/CDC">CDC</xsl:when>
		<xsl:otherwise>NORMAL</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>

	<div class="divLeft" style="background:#fff;">
		<a href="http://www.newco.dev.br/Administracion/Mantenimiento/Productos/PRODetalle.xsql?LIC_PROD_ID={/Productos/LIC_PROD_ID}&amp;LIC_OFE_ID={/Productos/LIC_OFE_ID}"  style="text-decoration:none;">
		<xsl:choose>
		<xsl:when test="/Productos/LANG = 'spanish'">
			<img src="http://www.newco.dev.br/images/botonFicha1.gif" alt="FICHA" id="pesFicha"/>
		</xsl:when>
		<xsl:otherwise>
			<img src="http://www.newco.dev.br/images/botonFicha1.gif" alt="FICHA" id="pesFicha"/>
		</xsl:otherwise>
		</xsl:choose>
		</a>

	<xsl:if test="/Productos/PRODUCTO/PRODUCTO/MVM or /Productos/PRODUCTO/PRODUCTOLICITACION/MVMB or /Productos/PRODUCTO/PRODUCTOLICITACION/CDC or /Productos/PRODUCTO/PRODUCTOLICITACION/INCIDENCIAS/INCIDENCIA">
		&nbsp;
		<a href="http://www.newco.dev.br/Administracion/Mantenimiento/Productos/Incidencias.xsql?PRO_ID={/Productos/PRODUCTO/PRODUCTOLICITACION/OFERTAS/OFERTA/LIC_OFE_IDPRODUCTO}&amp;LIC_PROD_ID={/Productos/LIC_PROD_ID}&amp;LIC_OFE_ID={/Productos/LIC_OFE_ID}&amp;PRO_NOMBRE={/Productos/PRODUCTO/PRODUCTOLICITACION/LIC_PROD_NOMBRE}" style="text-decoration:none;">
		<xsl:choose>
		<xsl:when test="/Productos/LANG = 'spanish'">
			<img src="http://www.newco.dev.br/images/botonIncidencias.gif" alt="INCIDENCIAS"/>
		</xsl:when>
		<xsl:otherwise>
			<img src="http://www.newco.dev.br/images/botonIncidencias-Br.gif" alt="INCIDENCIAS"/>
		</xsl:otherwise>
		</xsl:choose>
		</a>
	</xsl:if>

<!--
		<xsl:variable name="usuario">
			<xsl:choose>
			<xsl:when test="/Productos/PRODUCTO/PRODUCTOLICITACION/MVM or /Productos/PRODUCTO/PRODUCTOLICITACION/MVMB or /Productos/PRODUCTO/PRODUCTOLICITACION/CDC">CDC</xsl:when>
			<xsl:otherwise>NORMAL</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
-->
	<xsl:if test="$usuario != 'OBSERVADOR'">
		&nbsp;
		<a href="http://www.newco.dev.br/Administracion/Mantenimiento/Productos/NuevaIncidencia.xsql?PRO_ID={/Productos/PRODUCTO/PRODUCTOLICITACION/OFERTAS/OFERTA/LIC_OFE_IDPRODUCTO}&amp;USER={$usuario}&amp;LIC_PROD_ID={/Productos/LIC_PROD_ID}&amp;LIC_OFE_ID={/Productos/LIC_OFE_ID}&amp;PRO_NOMBRE={/Productos/PRODUCTO/PRODUCTOLICITACION/LIC_PROD_NOMBRE}" style="text-decoration:none;">
		<xsl:choose>
		<xsl:when test="/Productos/LANG = 'spanish'">
			<img src="http://www.newco.dev.br/images/botonNuevaIncidencia.gif" alt="NUEVAINCIDENCIA"/>
		</xsl:when>
		<xsl:otherwise>
			<img src="http://www.newco.dev.br/images/botonNuevaIncidencia-Br.gif" alt="NUEVAINCIDENCIA"/>
		</xsl:otherwise>
		</xsl:choose>
		</a>
	</xsl:if>
	</div><!--fin de bloque de pestañas-->

	<!--nombre producto-->
	<div class="divLeft">
		<h1 class="titlePage">
		<xsl:choose>
		<xsl:when test="LIC_PROD_NOMBRE">
			<xsl:value-of select="LIC_PROD_NOMBRE"/><br />
		</xsl:when>
		<xsl:otherwise>
			<xsl:value-of select="document($doc)/translation/texts/item[@name='producto_borrado_maiu']/node()"/>
		</xsl:otherwise>
		</xsl:choose>
		</h1>
	</div>

<!--si prod no esta borrado enseño tabla-->
<xsl:if test="LIC_PROD_NOMBRE">
	<div class="divLeft" id="fichaProducto"> 
		<div class="divLeft50nopa">

<!--tabla izquierda especificas producto-->
<table class="prodTabla">
	<tr height="5px;">
		<td class="cuarenta" height="5px;">&nbsp;</td>
		<td height="5px;">&nbsp;</td>
	</tr>

<tbody>
	<tr>
	<xsl:if test="LIC_PROD_NOMBRE">
		<td class="label"><xsl:value-of select="document($doc)/translation/texts/item[@name='nombre_privado']/node()"/>:</td>
		<td><strong><xsl:value-of select="LIC_PROD_NOMBRE" disable-output-escaping="yes"/></strong></td>
	</xsl:if>
	</tr>
	<tr>
		<!--ref provee-->
		<td class="label"><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_proveedor']/node()"/>:</td>
		<td><xsl:apply-templates select="OFERTAS/OFERTA/LIC_OFE_REFERENCIA"/></td>
	</tr>
	<tr>
		<!--proveedor-->
		<td class="label"><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/>:</td>
		<td><xsl:apply-templates select="//PROVEEDOR"/></td>
	</tr>
	<tr>
		<!--referencia cliente-->
		<td class="label"><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_cliente']/node()"/>:</td>
		<td><xsl:value-of select="REFERENCIA_CLIENTE"/></td> 
	</tr>
	<tr>
		<!--ref estandar propuesta-->
		<td class="label"><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_estandar']/node()"/>:</td>
		<td><xsl:apply-templates select="LIC_PROD_REFESTANDAR"/></td>
	</tr>
</tbody>
</table>

		</div><!--fin de divleft50nopa-->

		<div class="divLeft50nopa">

<!--tabla izquierda especificas producto-->
<table class="prodTabla">
	<tr height="5px;">
		<td class="cuarenta" height="5px;">&nbsp;</td>
		<td height="5px;">&nbsp;</td>
		<td>&nbsp;</td>
	</tr>

<tbody>
	<tr>
	<!--precio unidad basica-->
	<xsl:choose>
	<xsl:when test="/Productos/PRODUCTO/PRODUCTOLICITACION/MOSTRAR_PRECIO_IVA and /Productos/PRODUCTO/PRODUCTOLICITACION/OFERTAS/OFERTA/LIC_OFE_PRECIOIVA != ''">
		<td class="label"><xsl:value-of select="document($doc)/translation/texts/item[@name='precio_c_iva_line']/node()"/>:</td>
		<td><strong><xsl:value-of select="/Productos/PRODUCTO/PRODUCTOLICITACION/OFERTAS/OFERTA/LIC_OFE_PRECIOIVA"/></strong>
		<xsl:if test="/Productos/LANG = 'spanish'">
			&nbsp;&nbsp;&nbsp;&nbsp;
			<span class="label"><xsl:value-of select="document($doc)/translation/texts/item[@name='iva']/node()"/>:</span>
			&nbsp;<xsl:apply-templates select="LIC_PROD_TIPOIVA"/>%
		</xsl:if>
		</td>
		<td>&nbsp;</td>
	</xsl:when>
	<xsl:when test="/Productos/PRODUCTO/PRODUCTOLICITACION/OFERTAS/OFERTA/LIC_OFE_PRECIO != ''">
		<td class="label"><xsl:value-of select="document($doc)/translation/texts/item[@name='precio_s_iva_line']/node()"/>:</td>
		<td><strong><xsl:value-of select="/Productos/PRODUCTO/PRODUCTOLICITACION/OFERTAS/OFERTA/LIC_OFE_PRECIO"/></strong>
		<xsl:if test="/Productos/LANG = 'spanish'">
			&nbsp;&nbsp;&nbsp;&nbsp;
			<span class="label"><xsl:value-of select="document($doc)/translation/texts/item[@name='iva']/node()"/>:</span>
			&nbsp;<xsl:apply-templates select="LIC_PROD_TIPOIVA"/>%
		</xsl:if>
		</td>
		<td>&nbsp;</td>
	</xsl:when>
	<xsl:otherwise>
		<td colspan="2" align="center"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='no_hay_precio']/node()"/></strong></td>
		<td>&nbsp;</td>
	</xsl:otherwise>
	</xsl:choose>
	</tr>

	<tr>
		<!--unidad basica-->
		<td class="label"><xsl:value-of select="document($doc)/translation/texts/item[@name='unidad_basica']/node()"/>:</td>
		<td><xsl:value-of select="LIC_PROD_UNIDADBASICA"/>&nbsp;</td>
	</tr>

	<tr>
		<!--unidad lote-->
		<td class="label"><xsl:value-of select="document($doc)/translation/texts/item[@name='unidad_por_lote']/node()"/>:</td>
		<td><xsl:value-of select="substring-before(OFERTAS/OFERTA/LIC_OFE_UNIDADESPORLOTE,',')"/>&nbsp;</td>
	</tr>

	<!--marca-->
	<tr>
		<td class="label"><xsl:value-of select="document($doc)/translation/texts/item[@name='lic_marca']/node()"/>:</td>
		<td><xsl:value-of select="OFERTAS/OFERTA/LIC_OFE_MARCA" disable-output-escaping="yes"/></td>
	</tr>

	<tr>
		<td class="label">&nbsp;</td>
		<td>&nbsp;</td>
	</tr>
</tbody>
</table>

		</div><!--fin divLeft50nopa-->
	</div><!--fin de divLeft-->

	<!--buttons-->
	<div class="divLeft">
		<br /><br  />
	<xsl:if test="MVM and PRO_ID">
		<div class="divLeft30">&nbsp;</div>
		<div class="divleft20">
			<img src="http://www.newco.dev.br/images/2017/trash.png"/>&nbsp;
			<a href="javascript:Borrar();" title="borrar"><xsl:value-of select="document($doc)/translation/texts/item[@name='borrar_producto']/node()"/></a>
		</div>
	</xsl:if>
	
	</div><!--fin de buttons-->
</xsl:if><!--fin de if si prod no es borrado-->
</xsl:template><!--fin de producto licitacion-->

<xsl:template match="TARIFAS">
	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:value-of select="../../../LANG" />
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<div class="divCenter90">
    <p>&nbsp;</p>
	<table class="infoTable"> 
	<xsl:choose>
	<xsl:when test="NUEVOMODELO='S'">
	<thead>
		<tr>
			<th class="diecisiete">&nbsp;</th>
			<th class="veinte"><xsl:copy-of select="document($doc)/translation/texts/item[@name='precio_proveedor_c_iva_2line']/node()"/><xsl:if test="../../PRODUCTO/PRO_TIPOIVA != '0'"><xsl:value-of select="../../PRODUCTO/PRO_TIPOIVA"/>)</xsl:if></th>
			<th class="veinte"><xsl:copy-of select="document($doc)/translation/texts/item[@name='precio_final_comision_mvm_c_iva_2line']/node()"/>&nbsp;<xsl:value-of select="../../PRODUCTO/TIPOIVA_MVM" />%)</th>
			<th class="veinte"><xsl:copy-of select="document($doc)/translation/texts/item[@name='precio_final_s_iva_2line']/node()"/></th>
			<th class="cinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='divisa']/node()"/></th>
            <th>&nbsp;</th>
		</tr>
	</thead>
	<tbody align="center">
	<xsl:for-each select="TARIFAS_ROW">
		<tr>
			<td>&nbsp;</td>
			<td><xsl:value-of select="PRECIOPROVEEDOR_CONIVA"/></td>
			<td><xsl:value-of select="COMISION_CONIVA"/></td>
			<td><strong><xsl:value-of select="TRF_IMPORTE"/></strong></td>
			<td>
			<xsl:choose>
			<xsl:when test="//IDPAIS != '34'">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='euro']/node()"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="DIV_SUFIJO"/>
			</xsl:otherwise>
			</xsl:choose>
			</td>
            <td>&nbsp;</td>
		</tr>
	</xsl:for-each>
	</tbody>
	</xsl:when>
	</xsl:choose>
	</table>
    <p>&nbsp;</p>
	</div>
</xsl:template>
<!--fin tarifas-->

<!--licitaciones del producto-->
<xsl:template match="LICITACIONESPRODUCTO">
	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:value-of select="../../../LANG" />
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<div class="divLeft15nopa">&nbsp;</div>
	<div class="divLeft70">
	<table class="mediaTabla"> 
	<thead>
		<tr>
			<th class="veinte" align="left">&nbsp;<xsl:copy-of select="document($doc)/translation/texts/item[@name='licitaciones']/node()"/></th>
			<th class="veinte"><xsl:copy-of select="document($doc)/translation/texts/item[@name='fecha_alta']/node()"/></th>
			<th class="veinte"><xsl:copy-of select="document($doc)/translation/texts/item[@name='estado']/node()"/></th>
			<th class="quince"><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_decision']/node()"/></th>
		</tr>
	</thead>
	<tbody align="center">
	<xsl:for-each select="LICITACION">
		<tr>
			<td align="left">&nbsp;<xsl:value-of select="LIC_TITULO"/></td>
			<td><xsl:value-of select="LIC_FECHAALTA"/></td>
			<td><xsl:value-of select="ESTADO"/></td>
			<td><xsl:value-of select="LIC_FECHADECISIONPREVISTA"/></td>
		</tr>
	</xsl:for-each>
	</tbody>
	</table>
	</div>
</xsl:template>
<!--fin de licitaciones del producto-->

<xsl:template match="PRO_ENLACE">
	<a class="valor">
		<xsl:attribute name="href"><xsl:value-of select="."/></xsl:attribute>
		<img>
			<xsl:attribute name="src">http://www.newco.dev.br/images/anexo.gif</xsl:attribute>
		</img>
	</a>
</xsl:template>

<xsl:template match="PRO_HOMOLOGADO">
	<input type="checkbox" name="HOMOLOGADO" disabled="disabled">
	<xsl:choose>
	<xsl:when test=".=1">
		<xsl:attribute name="checked">checked</xsl:attribute>
	</xsl:when>
	</xsl:choose>
	</input>
</xsl:template>

<xsl:template match="PROVEEDOR">
	<a>
		<xsl:attribute name="href">javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPDetalleFrame.xsql?EMP_ID=<xsl:value-of select="../IDPROVEEDOR"/>&amp;VENTANA=NUEVA','DetalleEmpresa',100,80,0,0)</xsl:attribute>
		<xsl:attribute name="onMouseOver">window.status='Información sobre la empresa.';return true;</xsl:attribute>
		<xsl:attribute name="onMouseOut">window.status='';return true;</xsl:attribute>

		<xsl:value-of select="." disable-output-escaping="yes"/>
	</a>
</xsl:template>


<xsl:template match="CATALOGOS">
	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:value-of select="/Productos/LANG"/>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->
	<div class="divCenter90">
	<table class="infoTable" border="0">
	<thead>
		<tr>
			<th class="uno">&nbsp;</th>
			<th class="veinte datosLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='cliente']/node()"/></th>
			<th class="dies"><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_estandar']/node()"/>&nbsp;</th>
			<th class="trenta textLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='descripcion_estandar']/node()"/></th>
			<th class="cinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='adjudicado']/node()"/></th>
			<th class="dies"><xsl:copy-of select="document($doc)/translation/texts/item[@name='tarifa_euros_2line']/node()"/></th>
			<th class="dies"><xsl:copy-of select="document($doc)/translation/texts/item[@name='precio_referencia_euros_2line']/node()"/> </th>
			<th class="siete"><xsl:value-of select="document($doc)/translation/texts/item[@name='teorico']/node()"/></th>
			<th class="dies"><xsl:copy-of select="document($doc)/translation/texts/item[@name='consumo_ultimo_ano_ud_2line']/node()"/></th>
			<th>&nbsp;</th>
		</tr>
	</thead>
	<xsl:for-each select="CATALOGO">
		<tr>
			<td>&nbsp;</td>
			<td class="datosLeft"><xsl:value-of select="EMPRESA"/></td>
			<td><xsl:value-of select="REFESTANDAR"/></td>
			<td class="datosLeft"><xsl:value-of select="DESCRIPCION"/></td>
			<td><xsl:value-of select="ADJUDICADO"/></td>
			<td><xsl:value-of select="TARIFA"/></td>
			<td><xsl:value-of select="PRECIOREFERENCIA"/></td>
			<td><xsl:value-of select="PRECIOREFERENCIATEORICO"/></td>
			<td>
				<xsl:variable name="refProd">
					<xsl:choose>
					<xsl:when test="REFCLIENTE != ''"><xsl:value-of select="REFCLIENTE"/></xsl:when>
					<xsl:otherwise><xsl:value-of select="REFESTANDAR"/></xsl:otherwise>
					</xsl:choose>
				</xsl:variable>

			<xsl:choose>
			<xsl:when test="CANTIDADCOMPRADA > 0">
				<a href="javascript:MostrarEIS('CO_Pedidos_Eur','{IDEMPRESA}','','{$refProd}','9999');" style="text-decoration:none;">
					<xsl:value-of select="CANTIDADCOMPRADA"/>
				</a>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="CANTIDADCOMPRADA"/>
			</xsl:otherwise>
			</xsl:choose>
                        </td>
			<td>&nbsp;</td>
		</tr>
	</xsl:for-each>
	</table>
    </div>
</xsl:template>

<xsl:template match="CONSUMOPORCENTRO">
	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:value-of select="/Productos/LANG"/>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->
	<div class="divCenter90">
	<table class="infoTable" border="0">
	<thead>
		<tr>
			<th class="uno">&nbsp;</th>
			<th class="veinte datosLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='centro']/node()"/></th>
			<th class="veinte datosLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='poblacion']/node()"/>&nbsp;</th>
			<th class="dies"><xsl:copy-of select="document($doc)/translation/texts/item[@name='consumo_ultimo_ano_ud_2line']/node()"/></th>
			<th class="dies"><xsl:copy-of select="document($doc)/translation/texts/item[@name='consumo_reciente_ud_3line']/node()"/></th>
			<th class="uno">&nbsp;</th>
		</tr>
	</thead>
	<xsl:for-each select="CENTRO">
		<tr>
		<xsl:variable name="refProd">
			<xsl:choose>
			<xsl:when test="/Productos/PRODUCTO/PRODUCTO/REFERENCIA_CLIENTE != ''"><xsl:value-of select="/Productos/PRODUCTO/PRODUCTO/REFERENCIA_CLIENTE"/></xsl:when>
			<xsl:otherwise><xsl:value-of select="/Productos/PRODUCTO/PRODUCTO/REFERENCIA_PRIVADA"/></xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
			<td>&nbsp;</td>
			<td class="datosLeft"><xsl:value-of select="NOMBRE"/></td>
			<td class="datosLeft"><xsl:value-of select="POBLACION"/></td>
			<td>
			<xsl:choose>
			<xsl:when test="CONSUMO > 0">
				<a href="javascript:MostrarEIS('CO_Pedidos_Eur','{/Productos/PRODUCTO/PRODUCTO/IDEMPRESA}','{ID}','{$refProd}','9999');" style="text-decoration:none;">
					<xsl:value-of select="CONSUMO"/>
				</a>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="CONSUMO"/>
			</xsl:otherwise>
			</xsl:choose>
                        </td>
			<td>
			<xsl:choose>
			<xsl:when test="CONSUMORECIENTE > 0">
				<a href="javascript:MostrarEIS('CO_Pedidos_Eur','{/Productos/PRODUCTO/PRODUCTO/IDEMPRESA}','{ID}','{$refProd}','9999');" style="text-decoration:none;">
					<xsl:value-of select="CONSUMORECIENTE"/>
				</a>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="CONSUMORECIENTE"/>
			</xsl:otherwise>
			</xsl:choose>
                        </td>
			<td>&nbsp;</td>
		</tr>
	</xsl:for-each>
	</table>
    </div>
</xsl:template>
</xsl:stylesheet>