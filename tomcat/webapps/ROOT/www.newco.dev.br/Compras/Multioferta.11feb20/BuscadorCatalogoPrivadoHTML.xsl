<?xml version="1.0" encoding="iso-8859-1"?>
<!--
	Ultima revision. ET 25feb19 12:39
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:import href = "http://www.newco.dev.br/General/General.xsl"/>
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="lang" select="@lang"/>

<xsl:template match="/">

<html>
<head>
  <meta http-equiv="Cache-Control" Content="no-cache"/>

  <title><xsl:value-of select="TITULO" disable-output-escaping="yes"/></title>

  <!--style-->
  <xsl:call-template name="estiloIndip"/>
  <link href="http://www.newco.dev.br/General/Tabla-popup.css" rel="stylesheet" type="text/css"/>
  <!--fin de style-->

  <script type="text/javascript" src="http://www.newco.dev.br/General/jquery-1.8.3.min.js"></script>
  <script type="text/javascript" src="http://www.newco.dev.br/Compras/Multioferta/Lista.js"></script>
  <script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>
  <script type="text/javascript" src="http://www.newco.dev.br/General/Tabla-popup.js"></script>

  <!--idioma-->
  <xsl:variable name="lang">
	  <xsl:choose>
	  <xsl:when test="/Analizar/LANG"><xsl:value-of select="/Analizar/LANG"/></xsl:when>
	  <xsl:otherwise>spanish</xsl:otherwise>
	  </xsl:choose>
  </xsl:variable>
  <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
  <!--idioma fin-->

  <script type="text/javascript">
	  var nombre	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='nombre']/node()"/>';
    var proveedor	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/>';
    var ref_estandar	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='ref_estandar']/node()"/>';
    var ref_proveedor	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='ref_proveedor']/node()"/>';
    var marca	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='marca']/node()"/>';
    var iva	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='iva']/node()"/>';
    var unidad_basica	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='unidad_basica']/node()"/>';
    var unidad_lote	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='unidad_lote']/node()"/>';
    var farmacia	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='farmacia']/node()"/>';
    var homologado	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='homologado']/node()"/>';
    var precio	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='precio']/node()"/>';
    var familia	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='familia']/node()"/>';
    var subfamilia	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='subfamilia']/node()"/>';
    var grupo	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='grupo']/node()"/>';
  </script>

<xsl:text disable-output-escaping="yes">
<![CDATA[
  <script type="text/javascript">
	<!--
    //
    //	Guarda en el campo oculto CAMBIOS el contenido de los campos editables por el usuario
    //	en formato (ID, UnidadBasica, UnidadesPorLote, Precio)
    //
    //	y envia el formulario
    //
    function Enviar(formDestino, Accion){
      if(Accion=='ANTERIOR'){               //	Guarda resultados y retrocede a la pagina anterior
        formDestino.elements['PAGINA'].value=parseInt(formDestino.elements['PAGINA'].value)-1;
      }else if (Accion=='SIGUIENTE'){       //	Guarda resultados y avanza a la pagina siguiente
        formDestino.elements['PAGINA'].value=parseInt(formDestino.elements['PAGINA'].value)+1;
      }

      //solo ocultos 15-1-14
      var form=document.forms[0];
	  
	  /*14dic16 Este bloque da problemas, lo eliminamos ya que este campo ya no es necesario
      if(form.elements['SOLO_OCULTOS_IN'].checked == true){
        form.elements['SOLO_OCULTOS'].value = 'S';
      }else{
        form.elements['SOLO_OCULTOS'].value = 'N';
      }*/
	  
      form.elements['SOLO_OCULTOS'].value = 'N';

      SubmitForm(formDestino);
    }

    //cambiar usuario
    function CambiarUsuario(idUsuario){
      var form		= document.forms[0];
      var IDProveedor		= form.elements['IDPROVEEDOR'].value;
      var NombreProducto	= form.elements['LLP_NOMBRE'].value;

	    if(form.elements['SOLO_OCULTOS_IN'].checked == true){
        form.elements['SOLO_OCULTOS'].value = 'S';
        document.location.href = 'http://www.newco.dev.br/Compras/Multioferta/BuscadorCatalogoPrivado.xsql?DONDE_SE_BUSCA=PLA&IDUSUARIOCOMPROBAR='+idUsuario+'&SOLO_OCULTOS=S&LLP_NOMBRE='+NombreProducto+'&FIDProveedor='+IDProveedor;
	    }else{
        document.location.href = 'http://www.newco.dev.br/Compras/Multioferta/BuscadorCatalogoPrivado.xsql?DONDE_SE_BUSCA=PLA&IDUSUARIOCOMPROBAR='+idUsuario+'&LLP_NOMBRE='+NombreProducto+'&FIDProveedor='+IDProveedor;
        form.elements['SOLO_OCULTOS'].value = 'N';
	    }
    }

    function EjecutarFuncionDelFrame(nombreFrame,idPlantilla){
      var objFrame=new Object();
      objFrame=obtenerFrame(top, nombreFrame);
      objFrame.CambioPlantillaExterno(idPlantilla);
    }

    //	9nov09	ET	Permitimos ordenación de este listado
    function OrdenarPor(Orden){
	    var form=document.forms[0];

	    if(form.elements['ORDEN'].value==Orden){
        if(form.elements['SENTIDO'].value=='ASC') form.elements['SENTIDO'].value='DESC';
        else  form.elements['SENTIDO'].value='ASC';
      }else{
        form.elements['ORDEN'].value=Orden;
        form.elements['SENTIDO'].value='ASC';
      }

      form.elements['PAGINA'].value=0;
      SubmitForm(form);
    }

    function Ocultar(IDProducto, Oculto){
      var form=document.forms[0];
      form.elements['IDPRODUCTO'].value=IDProducto,
      form.elements['OCULTAR'].value=Oculto;
      SubmitForm(form);
    }

    //ver detalle producto
    //usuario minimalista ve solo info base producto
    function verDetalleProducto(idProd){
      jQuery("#detalleProd tbody").empty();

      if(idProd != ''){
        jQuery.ajax({
	        url: 'http://www.newco.dev.br/Administracion/Mantenimiento/Productos/PRODetalleAJAX.xsql',
	        data: "PRO_ID="+idProd,
          type: "GET",
          contentType: "application/xhtml+xml",
          beforeSend: function(){
            null;
          },
          error: function(objeto, quepaso, otroobj){
            alert('error'+quepaso+' '+otroobj+''+objeto);
          },
          success: function(objeto){
            var data = eval("(" + objeto + ")");
            var tbodyProd = "";

            tbodyProd +=  "<tr><td class='labelRight grisMed'>"+ nombre +":</td><td class='datosLeft'>"+data.Producto.nombre+"</td></tr>";
            tbodyProd +=  "<tr><td class='labelRight grisMed'>"+ ref_proveedor +":</td><td class='datosLeft'>"+data.Producto.ref_prove+"</td></tr>";
            tbodyProd +=  "<tr><td class='labelRight grisMed'>"+ proveedor +":</td><td class='datosLeft'>"+data.Producto.prove+"</td>";
            if(data.Producto.imagen != ''){
              tbodyProd +=  "<td rowspan='4'><img src='http://www.newco.dev.br/Fotos/"+data.Producto.imagen+"' /></td>";
            }
            tbodyProd +="</tr>";
            tbodyProd +=  "<tr><td class='labelRight grisMed'>"+ ref_estandar +":</td><td class='datosLeft'>"+data.Producto.ref_estandar+"</td></tr>";
            tbodyProd +=  "<tr><td class='labelRight grisMed'>"+ marca +":</td><td class='datosLeft'>"+data.Producto.marca+"</td></tr>";
            if(data.Producto.pais != '55'){
              tbodyProd +=  "<tr><td class='labelRight grisMed'>"+ iva +":</td><td class='datosLeft'>"+data.Producto.iva+"</td></tr>";
            }
            tbodyProd +=  "<tr><td class='labelRight grisMed'>"+ unidad_basica +":</td><td class='datosLeft'>"+data.Producto.un_basica+"</td></tr>";
            tbodyProd +=  "<tr><td class='labelRight grisMed'>"+ unidad_lote +":</td><td class='datosLeft'>"+data.Producto.un_lote+"</td></tr>";
            if(data.Producto.farmacia != ''){
              tbodyProd +=  "<tr><td class='labelRight grisMed'>"+ farmacia +":</td><td class='datosLeft'>"+data.Producto.farmacia+"</td></tr>";
            }
            if(data.Producto.homologado != ''){
              tbodyProd +=  "<tr><td class='labelRight grisMed'>"+ homologado +":</td><td class='datosLeft'>"+data.Producto.homologado+"</td></tr>";
            }
            if(data.Producto.categoria != '' && data.Producto.categoria != 'DEFECTO'){
              tbodyProd +=  "<tr><td class='labelRight grisMed'>"+ catalogo +":</td><td class='datosLeft'>"+data.Producto.categoria+"</td></tr>";
            }
            tbodyProd +=  "<tr><td class='labelRight grisMed'>"+ familia +":</td><td class='datosLeft'>"+data.Producto.familia+"</td></tr>";
            tbodyProd +=  "<tr><td class='labelRight grisMed'>"+ subfamilia +":</td><td class='datosLeft'>"+data.Producto.sub_familia+"</td></tr>";
            if(data.Producto.grupo != '' && data.Producto.categoria != 'DEFECTO'){
              tbodyProd +=  "<tr><td class='labelRight grisMed'>"+ grupo +":</td><td class='datosLeft'>"+data.Producto.grupo+"</td></tr>";
            }

            jQuery("#detalleProd tbody").append(tbodyProd);
            showTabla(true);
          }
        });
      }
    }//fin de verDetalleProducto
	-->
	</script>
]]>
</xsl:text>
</head>
<body>
  <!--idioma-->
  <xsl:variable name="lang">
    <xsl:choose>
    <xsl:when test="/ProductosEnPlantillas/LANG"><xsl:value-of select="/ProductosEnPlantillas/LANG" /></xsl:when>
    <xsl:otherwise>spanish</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
  <!--idioma fin-->

  <xsl:choose>
  <xsl:when test="ProductosEnPlantillas/SESION_CADUCADA">
    <xsl:apply-templates select="ProductosEnPlantillas/SESION_CADUCADA"/>
  </xsl:when>
<!--
  <xsl:when test="ProductosEnPlantillas/LISTAPRODUCTOS/Sorry">
    <xsl:apply-templates select="ProductosEnPlantillas/LISTAPRODUCTOS/Sorry"/>
  </xsl:when>
-->
  <xsl:otherwise>
    <div class="divLeft">

		<!--	Titulo de la página		-->
		<div class="ZonaTituloPagina">
			<p class="Path"><xsl:value-of select="document($doc)/translation/texts/item[@name='Inicio']/node()"/>&nbsp;/&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='pedidos']/node()"/>&nbsp;/&nbsp;<span class="FinPath"><xsl:value-of select="document($doc)/translation/texts/item[@name='buscador_catalogo']/node()"/></span>
				<span class="CompletarTitulo" style="width:600px;">
					<xsl:value-of select="/ProductosEnPlantillas/LISTAPRODUCTOS/MENSAJE"/>
					&nbsp;
				</span>
			</p>
			<p class="TituloPagina">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='buscador_catalogo']/node()"/>
				<!--
		    	<xsl:choose>
        		<xsl:when test="/ProductosEnPlantillas/DONDE_SE_BUSCA='PLA'">
        			<xsl:value-of select="document($doc)/translation/texts/item[@name='productos_sel_catalogo_privado']/node()"/>
        		</xsl:when>
        		<xsl:when test="/ProductosEnPlantillas/DONDE_SE_BUSCA='CP'">
        			<xsl:value-of select="document($doc)/translation/texts/item[@name='productos_sel_catalogo_privado']/node()"/>
        		</xsl:when>
        		<xsl:when test="/ProductosEnPlantillas/DONDE_SE_BUSCA='NOPLA'">
        			<xsl:value-of select="document($doc)/translation/texts/item[@name='productos_sel_pendientes_emplantillar']/node()"/>
        		</xsl:when>
        		</xsl:choose>
				-->
				<span class="CompletarTitulo" style="width:300px;">
					<!--	botones	-->
					<xsl:if test="/ProductosEnPlantillas/LISTAPRODUCTOS/PAGINAANTERIOR">
					<a class="btnNormal" href="javascript:Enviar(document.forms[0],'ANTERIOR');"><xsl:value-of select="document($doc)/translation/texts/item[@name='anterior']/node()"/></a>
					&nbsp;
					</xsl:if>
					<xsl:if test="/ProductosEnPlantillas/LISTAPRODUCTOS/PAGINASIGUIENTE">
					<a class="btnNormal" href="javascript:Enviar(document.forms[0],'SIGUIENTE');"><xsl:value-of select="document($doc)/translation/texts/item[@name='siguiente']/node()"/></a>
					&nbsp;
					</xsl:if>
				</span>
			</p>
		</div>
		<br/>
		<br/>

	<!--
		  <h1 class="titlePage">
		    <xsl:choose>
        <xsl:when test="/ProductosEnPlantillas/DONDE_SE_BUSCA='PLA'">
          <xsl:value-of select="document($doc)/translation/texts/item[@name='productos_sel_plantillas']/node()"/>
          <xsl:value-of select="/ProductosEnPlantillas/LISTAPRODUCTOS/CLIENTE"/>
        </xsl:when>
        <xsl:when test="/ProductosEnPlantillas/DONDE_SE_BUSCA='CP'">
          <xsl:value-of select="document($doc)/translation/texts/item[@name='productos_sel_catalogo_privado']/node()"/>
        </xsl:when>
        <xsl:when test="/ProductosEnPlantillas/DONDE_SE_BUSCA='NOPLA'">
          <xsl:value-of select="document($doc)/translation/texts/item[@name='productos_sel_pendientes_emplantillar']/node()"/>
        </xsl:when>
        </xsl:choose>
      </h1><!- -fin titlePage-->

		  <xsl:choose>
			<xsl:when test="/ProductosEnPlantillas/DONDE_SE_BUSCA='PLA' or /ProductosEnPlantillas/DONDE_SE_BUSCA='CP'">
				<xsl:if test="/ProductosEnPlantillas/LISTAPRODUCTOS/BLOQUEADO">
          <div class="tituloCamp">
            <p><xsl:value-of select="document($doc)/translation/texts/item[@name='esta_buscando_en_plantillas_de_otra_empresa']/node()"/>.</p>
	    		</div><!--fin de tituloCamp-->
        </xsl:if>
	</xsl:when>
	</xsl:choose>

		  <!--	Campos ocultos para avanzar y retroceder en la busqueda	-->
	<form action="" name="Busqueda" method="GET">
		<!--<input type="hidden" name="IDCLIENTE" value="{/ProductosEnPlantillas/LISTAPRODUCTOS/IDCLIENTE}"/>-->
		<input type="hidden" name="PAGINA" value="{/ProductosEnPlantillas/LISTAPRODUCTOS/PAGINA}"/>
		<input type="hidden" name="LLP_NOMBRE" value="{/ProductosEnPlantillas/LISTAPRODUCTOS/PRODUCTOBUSCADO}"/><!--	PRODUCTO	-->
		<input type="hidden" name="LLP_PROVEEDOR" value="{/ProductosEnPlantillas/LISTAPRODUCTOS/PROVEEDORBUSCADO}"/><!--	PROVEEDOR	-->
		<input type="hidden" name="ORDEN" value="{/ProductosEnPlantillas/LISTAPRODUCTOS/ORDEN}"/>
		<input type="hidden" name="SENTIDO" value="{/ProductosEnPlantillas/LISTAPRODUCTOS/SENTIDO}"/>
		<input type="hidden" name="IDPRODUCTO"/>
		<input type="hidden" name="OCULTAR"/>
		<input type="hidden" name="SOLO_OCULTOS"/>
		<input type="hidden" name="SIN_STOCKS" value="{/ProductosEnPlantillas/LISTAPRODUCTOS/SIN_STOCKS}"/>
		<input type="hidden" name="IDPROVEEDOR" value="{/ProductosEnPlantillas/LISTAPRODUCTOS/IDPROVEEDOR}"/>

      <xsl:choose>
      <xsl:when test="ProductosEnPlantillas/LISTAPRODUCTOS/PRODUCTO">

		<xsl:if test="/ProductosEnPlantillas/LISTAPRODUCTOS/LISTAEMPRESAS">
			<!--<table class="infoTable">-->
			<table class="buscador">
			<tr>
				<td width="140px" style="text-align:right;"><label><xsl:value-of select="document($doc)/translation/texts/item[@name='empresas_cliente']/node()"/>:&nbsp;</label>
				</td>
				<td width="140px" style="text-align:left;">
					<xsl:call-template name="desplegable">
					<xsl:with-param name="path" select="/ProductosEnPlantillas/LISTAPRODUCTOS/LISTAEMPRESAS/field"/>
					<xsl:with-param name="onChange">javascript:Enviar(document.forms[0],'BUSCAR');</xsl:with-param>
					</xsl:call-template>
				</td>
				<!--
				<td class="veinte">
					<!- -<div class="boton">- ->
					<a class="btnDestacado" href="javascript:Enviar(document.forms[0],'BUSCAR');">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='buscar']/node()"/>
					</a>
					<!- -</div>- ->
				</td>-->
				<td>&nbsp;</td>
			</tr>
			</table>
		</xsl:if>

      <xsl:choose>
      <xsl:when test="/ProductosEnPlantillas/LISTAPRODUCTOS/LISTAUSUARIOS">
      	<!--<table class="encuesta" border="0">-->
        <table class="buscador">
          <!--elegir usuario para asisa-->
          <tr height="30px;">
            <th class="trenta">&nbsp;</th>
            <th class="veintecinco">
              <!--<xsl:value-of select="//IDUSUARIOCOMPROBAR"/>-->
              <xsl:call-template name="desplegable">
                <xsl:with-param name="path" select="/ProductosEnPlantillas/LISTAPRODUCTOS/LISTAUSUARIOS/field"/>
                <!--<xsl:with-param name="onChange">Enviar(document.forms[0],'BUSCAR');</xsl:with-param>-->
                <xsl:with-param name="onChange">CambiarUsuario(this.value);</xsl:with-param>
                <xsl:with-param name="style">width:500px;</xsl:with-param>
              </xsl:call-template>
            </th>
            <th class="dies">
			<!--
              <p class="textLeft" style="display:none;">	14dic16	recupero este bloque, sino hay errores de javascript, pero lo escondo
                <input type="checkbox" name="SOLO_OCULTOS_IN" onchange="Enviar(document.forms[0],'BUSCAR');">
                  <xsl:choose>
                  <xsl:when test="/ProductosEnPlantillas/LISTAPRODUCTOS/SOLO_OCULTOS = 'S'">
                    <xsl:attribute name="checked">checked</xsl:attribute>
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:attribute name="unchecked">unchecked</xsl:attribute>
                  </xsl:otherwise>
                  </xsl:choose>
                </input>
                &nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='solo_ocultos']/node()"/>
              </p>	-->

            </th>
            <th>&nbsp;</th>
          </tr>
        </table>
      </xsl:when>
      <xsl:otherwise>
      </xsl:otherwise>
      </xsl:choose>

	<!--<table class="encuesta" border="0">-->
	<table class="buscador">
<!--        	<tr class="lejenda">
            <th colspan="7" class="textLeft">
              <xsl:value-of select="/ProductosEnPlantillas/LISTAPRODUCTOS/MENSAJE"/>
				    </th>
            <th colspan="6" class="textRight">
              <xsl:if test="/ProductosEnPlantillas/LISTAPRODUCTOS/PAGINAANTERIOR or /ProductosEnPlantillas/LISTAPRODUCTOS/PAGINASIGUIENTE">
                <!- -	Botones de avanzar y retroceder	- ->
                <xsl:if test="/ProductosEnPlantillas/LISTAPRODUCTOS/PAGINAANTERIOR">
                  <a href="javascript:Enviar(document.forms[0],'ANTERIOR');">
                    <img src="http://www.newco.dev.br/images/flechaLeft.gif" />
                  </a>&nbsp;
                  <a href="javascript:Enviar(document.forms[0],'ANTERIOR');"><xsl:value-of select="document($doc)/translation/texts/item[@name='anterior']/node()"/></a>
                  <!- - <xsl:call-template name="botonNostyle">
                    <xsl:with-param name="path" select="/ProductosEnPlantillas/botones_nuevo/button[@label='NavegarAtras']"/>
                  </xsl:call-template>- ->
                </xsl:if>

                <xsl:if test="/ProductosEnPlantillas/LISTAPRODUCTOS/PAGINASIGUIENTE">
                  &nbsp;&nbsp;&nbsp;
                  <a href="javascript:Enviar(document.forms[0],'SIGUIENTE');"><xsl:value-of select="document($doc)/translation/texts/item[@name='siguiente']/node()"/></a>
                  &nbsp;
                  <a href="javascript:Enviar(document.forms[0],'SIGUIENTE');"><img src="http://www.newco.dev.br/images/flechaRight.gif" /></a>
                </xsl:if>
				      </xsl:if>
				    </th>
          </tr>-->

          <!--<tr class="titulos">-->
          <tr class="subTituloTabla">
            <!--emplantillar-->
            <th class="uno">&nbsp;</th>
            <th class="tres">&nbsp;</th>
            <th class="uno">&nbsp;</th>
			<th align="left">
				<a href="javascript:OrdenarPor('PRODUCTO');"><xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/></a>
            </th>
            <th class="tres"><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_cliente']/node()"/></th>
            <th class="veinte">
              <a href="javascript:OrdenarPor('PROVEEDOR');"><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/></a>&nbsp;(<xsl:value-of select="document($doc)/translation/texts/item[@name='ref']/node()"/>.)<br />
              <!--desplegable proveedores-->
              <xsl:call-template name="desplegable">
        				<xsl:with-param name="path" select="/ProductosEnPlantillas/LISTAPRODUCTOS/FIDProveedor/field"/>
                <xsl:with-param name="onChange">Enviar(document.forms[0],'BUSCAR');</xsl:with-param>
      				</xsl:call-template>
            </th>
            <th>
              <xsl:choose>
              <xsl:when test="(/ProductosEnPlantillas/LISTAPRODUCTOS/ADMIN_CDC or /ProductosEnPlantillas/LISTAPRODUCTOS/ADMIN_MVM) and (/ProductosEnPlantillas/LISTAPRODUCTOS/MOSTRAR_BOTON_OCULTOS)">
                <xsl:attribute name="class">cuatro</xsl:attribute>

                <xsl:if test="not(/ProductosEnPlantillas/LISTAPRODUCTOS/MVM) and not(/ProductosEnPlantillas/LISTAPRODUCTOS/MVMB)">
                  <xsl:value-of select="document($doc)/translation/texts/item[@name='ocultos_mayu']/node()"/><br/>
                  <input type="checkbox" class="muypeq" name="SOLO_OCULTOS_IN" onchange="Enviar(document.forms[0],'BUSCAR');">
                    <xsl:choose>
                    <xsl:when test="/ProductosEnPlantillas/LISTAPRODUCTOS/SOLO_OCULTOS = 'S'">
                      <xsl:attribute name="checked">checked</xsl:attribute>
                    </xsl:when>
                    <xsl:otherwise>
                      <xsl:attribute name="unchecked">unchecked</xsl:attribute>
                    </xsl:otherwise>
                    </xsl:choose>
                  </input>
                </xsl:if>
              </xsl:when>
              <xsl:otherwise>
                <xsl:attribute name="class">zerouno</xsl:attribute>
                <input type="checkbox" name="SOLO_OCULTOS_IN" style="display:none;"/>
              </xsl:otherwise>
              </xsl:choose>
            </th>
            <th class="ocho">
				<a href="javascript:OrdenarPor('MARCA');"><xsl:value-of select="document($doc)/translation/texts/item[@name='marca']/node()"/></a>
            </th>
            <!--<th class="ocho textLeft">&nbsp;&nbsp;&nbsp;&nbsp;Plantillas</th>-->
            <th class="doce"><xsl:value-of select="document($doc)/translation/texts/item[@name='ud_basica']/node()"/></th>
            <!--precio sin iva, con iva, total-->
            <th class="ocho">
			<xsl:choose>
              <!--viejo modelo asisa viamed-->
				<xsl:when test="/ProductosEnPlantillas/LISTAPRODUCTOS/VIEJO_MODELO">
                <xsl:choose>
                <xsl:when test="/ProductosEnPlantillas/LISTAPRODUCTOS/MOSTRAR_PRECIO_CON_IVA"><!--viamed-->
					<xsl:copy-of select="document($doc)/translation/texts/item[@name='precio_prov_con_iva_2line']/node()"/>
                </xsl:when>
                <xsl:otherwise><!--asisa precio sin iva-->
                  <xsl:copy-of select="document($doc)/translation/texts/item[@name='precio_prov_sin_iva_2line']/node()"/>
                </xsl:otherwise>
                </xsl:choose>
			</xsl:when>
              <!--nuevo modelo gomosa, vendrell, fncp-->
              <xsl:when test="/ProductosEnPlantillas/LISTAPRODUCTOS/NUEVO_MODELO">
				<xsl:copy-of select="document($doc)/translation/texts/item[@name='precio_final']/node()"/> <br/>
                (<xsl:value-of select="document($doc)/translation/texts/item[@name='iva_comision']/node()"/>)
				</xsl:when>
				</xsl:choose>
            </th>

					<xsl:if test="(/ProductosEnPlantillas/LISTAPRODUCTOS/ADMIN_CDC or /ProductosEnPlantillas/LISTAPRODUCTOS/ADMIN_MVM) and /ProductosEnPlantillas/LISTAPRODUCTOS/NUEVO_MODELO">
            <!--enseñamos precio ref solo a nuevo modelo y super usuarios porqué ve precio final, gomosa, fncp-->
            <th class="cinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='precio_ref']/node()"/>.</th>
					</xsl:if>

            <th class="tres"><xsl:copy-of select="document($doc)/translation/texts/item[@name='ud_ba_lote_2line']/node()"/></th>
            <th class="seis">
              <xsl:if test="/ProductosEnPlantillas/LISTAPRODUCTOS/ADMIN_CDC or /ProductosEnPlantillas/LISTAPRODUCTOS/ADMIN or /ProductosEnPlantillas/LISTAPRODUCTOS/CDC">
						    <a href="javascript:OrdenarPor('CONSUMO');"><xsl:value-of select="document($doc)/translation/texts/item[@name='consumo']/node()"/></a>
              </xsl:if>
            </th>
		      </tr>

				<!--	Cuerpo de la tabla	-->
        <xsl:for-each select="ProductosEnPlantillas/LISTAPRODUCTOS/PRODUCTO">
          <tr class="lineBorderBottom">
            <td>
              <!--si usuario gerente tipo msirvent ve info de sin stock, no modifica-->
              <xsl:if test="../ADMIN and TIPO_SIN_STOCK != ''">
                <xsl:choose>
                <xsl:when test="TIPO_SIN_STOCK='S'">
                  <img src="http://www.newco.dev.br/images/SemaforoAmbar.gif" title="Sin stock: {TEXTO_SIN_STOCK}" />
                </xsl:when>
                <xsl:when test="TIPO_SIN_STOCK='D'">
                  <img src="http://www.newco.dev.br/images/SemaforoRojo.gif" title="Descatalogado: {TEXTO_SIN_STOCK}" />
                </xsl:when>
                </xsl:choose>
              </xsl:if>
            </td>
            <td>
				<xsl:if test="/ProductosEnPlantillas/LISTAPRODUCTOS/ADMIN_CDC">
                <xsl:choose>
                <!--si es mvm y busco por otro cliente no visualizo el boton catalogo-->
                <xsl:when test="(/ProductosEnPlantillas/DONDE_SE_BUSCA='PLA' or /ProductosEnPlantillas/DONDE_SE_BUSCA='CP') and /ProductosEnPlantillas/LISTAPRODUCTOS/BLOQUEADO">
                </xsl:when>
                <xsl:otherwise>
	    		<a>
                    <xsl:attribute name="href">javascript:MostrarPagPersonalizada('http://www.newco.dev.br/ProcesosCdC/MantenimientoReducido/MantenimientoReducido.xsql?PRO_ID=<xsl:value-of select="IDPRODUCTO"/>&amp;EMP_ID=<xsl:value-of select="/ProductosEnPlantillas/LISTAPRODUCTOS/IDCLIENTE"/>','catalogoprivado',100,80,75,0);</xsl:attribute>
                    <img src="http://www.newco.dev.br/images/catalogo.gif" alt="Ver en catálogo" title="Ver en catálogo"/>
                </a>
                </xsl:otherwise>
                </xsl:choose>
	    		</xsl:if>
            </td>

          <xsl:choose>
          <xsl:when test="/ProductosEnPlantillas/LISTAPRODUCTOS/DERECHOS/@ADMIN='S'">
            <td>
				<a>
                <xsl:attribute name="href">javascript:MostrarPagPersonalizada(&#39;http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPDetalleFrame.xsql?EMP_ID=<xsl:value-of select="IDCLIENTE"/>&#39;,&#39;empresa&#39;,100,80,0,-50);</xsl:attribute>
                <xsl:value-of select="CLIENTE"/>
              </a>
            </td>
          </xsl:when>
          </xsl:choose>

            <!--images-->
            <td>
              <xsl:if test="IMAGENES/IMAGEN/@id != ''">
                <xsl:variable name="id" select="IMAGENES/IMAGEN/@id"/>
                &nbsp;<img src="http://www.newco.dev.br/images/fotoListadoPeq.gif" alt="con foto" id="{$id}" onmouseover="verFoto('{$id}');" onmouseout="verFoto('{$id}');"/>
                <div id="verFotoPro_{$id}" class="divFotoProBusca" style="display:none;">
                  <img src="http://www.newco.dev.br/Fotos/{IMAGENES/IMAGEN/@peq}"/>
                </div>
              </xsl:if>
            </td>
            <!--producto-->
            <td style="padding-left:4px;text-align:left;">
              <xsl:choose>
              <!--minimalista para proveedores.com-->
              <xsl:when test="/ProductosEnPlantillas/LISTAPRODUCTOS/MINIMALISTA">
                <!--<a style="text-decoration:none;">-->
                <a>
                  <xsl:attribute name="href">javascript:verDetalleProducto('<xsl:value-of select="IDPRODUCTO"/>');</xsl:attribute>
                  <!--<span class="strongAzul">-->
                    <!--quitado 6-8-2013 MC sobre peticion del Monty, si no las busquedas no coincidian de prod en plantilla y no.
                    vuelto a poner el 20-oct14-->
                    <xsl:choose>
                    <xsl:when test="NOMBRE_PRIVADO">
                      <xsl:value-of select="NOMBRE_PRIVADO"/>
                    </xsl:when>
                    <xsl:otherwise>
                      <xsl:value-of select="PRODUCTO"/>
                    </xsl:otherwise>
                    </xsl:choose>
                  <!--</span>-->
                </a>
              </xsl:when>
              <xsl:otherwise>
                <a style="text-decoration:none;">
                  <xsl:attribute name="href">javascript:MostrarPagPersonalizada(&#39;http://www.newco.dev.br/Administracion/Mantenimiento/Productos/PRODetalle.xsql?PRO_ID=<xsl:value-of select="IDPRODUCTO"/>&#39;,&#39;producto&#39;,100,80,0,-50);</xsl:attribute>
                  <span class="strongAzul">
                    <!--quitado 6-8-2013 MC sobre peticion del Monty, si no las busquedas no coincidian de prod en plantilla y no.
                    vuelto a poner el 20-oct14-->
                    <xsl:choose>
                    <xsl:when test="NOMBRE_PRIVADO">
                      <xsl:value-of select="NOMBRE_PRIVADO"/>
                    </xsl:when>
                    <xsl:otherwise>
                      <xsl:value-of select="PRODUCTO"/>
                    </xsl:otherwise>
                    </xsl:choose>
                  </span>
                </a>
              </xsl:otherwise>
              </xsl:choose>
            </td>
						<td>
							<xsl:choose>
              <xsl:when test="REFCLIENTE != ''">
                <xsl:value-of select="REFCLIENTE"/>
              </xsl:when>
              <xsl:otherwise>
                <xsl:value-of select="REFERENCIA_PRIVADA"/>
              </xsl:otherwise>
              </xsl:choose>&nbsp;
						</td>
            <td align="left">
              <xsl:choose>
              <xsl:when test="/ProductosEnPlantillas/LISTAPRODUCTOS/MINIMALISTA">
                <xsl:value-of select="PROVEEDOR"/>
              </xsl:when>
              <xsl:otherwise>
				 <xsl:choose>
				<xsl:when test="/ProductosEnPlantillas/LISTAPRODUCTOS/BLOQUEADO">
                  <xsl:value-of select="PROVEEDOR"/>&nbsp;
                  <a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPDetalleFrame.xsql?EMP_ID={//LISTAPRODUCTOS/IDPROVEEDOR}','Ficha Proveedor',100,80,0,-50);" style="text-decoration:none">
                    <img src="http://www.newco.dev.br/images/ficha.gif">
                      <xsl:attribute name="alt"><xsl:value-of select="document($doc)/translation/texts/item[@name='abrir_ficha_proveedor']/node()"/></xsl:attribute>
                      <xsl:attribute name="title"><xsl:value-of select="document($doc)/translation/texts/item[@name='abrir_ficha_proveedor']/node()"/></xsl:attribute>
                    </img>
                  </a>&nbsp;
                  <br />
                  <span class="font11">(<xsl:value-of select="REFERENCIA"/>)</span>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:choose>
                  <xsl:when test="PLANTILLAS/PLANTILLA/ID!='MASPLANTILLAS'">
                    <a class="noDecor">
                      <xsl:attribute name="href">javascript:EjecutarFuncionDelFrame('zonaPlantilla',<xsl:value-of select="PLANTILLAS/PLANTILLA/ID"/>);</xsl:attribute>
                      <xsl:value-of select="PROVEEDOR"/></a>&nbsp;
                    <a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPDetalleFrame.xsql?EMP_ID={//LISTAPRODUCTOS/PRODUCTO/IDPROVEEDOR}','Ficha Proveedor',100,80,0,-50);" style="text-decoration:none">
                      <img src="http://www.newco.dev.br/images/ficha.gif">
                        <xsl:attribute name="alt"><xsl:value-of select="document($doc)/translation/texts/item[@name='abrir_ficha_proveedor']/node()"/></xsl:attribute>
                        <xsl:attribute name="title"><xsl:value-of select="document($doc)/translation/texts/item[@name='abrir_ficha_proveedor']/node()"/></xsl:attribute>
                      </img>
                    </a>&nbsp;
                    <br />
                    <span class="font11">(<xsl:value-of select="REFERENCIA"/>)</span>
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:value-of select="PROVEEDOR"/>&nbsp;
                    <a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPDetalleFrame.xsql?EMP_ID={//LISTAPRODUCTOS/IDPROVEEDOR}','Ficha Proveedor',100,80,0,-50);" style="text-decoration:none">
                      <img src="http://www.newco.dev.br/images/ficha.gif">
                        <xsl:attribute name="alt"><xsl:value-of select="document($doc)/translation/texts/item[@name='abrir_ficha_proveedor']/node()"/></xsl:attribute>
                        <xsl:attribute name="title"><xsl:value-of select="document($doc)/translation/texts/item[@name='abrir_ficha_proveedor']/node()"/></xsl:attribute>
                      </img>
                    </a>&nbsp;
                    <br />
                    <span class="font11">(<xsl:value-of select="REFERENCIA"/>)</span>
                    &nbsp;<img width="12" src="http://www.newco.dev.br/images/urgente.gif"/>
                  </xsl:otherwise>
                  </xsl:choose>
                </xsl:otherwise>
                </xsl:choose>
              </xsl:otherwise><!--fin minimalista-->
              </xsl:choose>
						  <!--<xsl:value-of select="PROVEEDOR"/>&nbsp;(<xsl:value-of select="REFERENCIA"/>)-->
            </td>
            <td align="center">
              <!--si hay marca enseño ocultos-->
              <xsl:if test="(/ProductosEnPlantillas/LISTAPRODUCTOS/ADMIN_CDC or /ProductosEnPlantillas/LISTAPRODUCTOS/ADMIN_MVM) and (/ProductosEnPlantillas/LISTAPRODUCTOS/MOSTRAR_BOTON_OCULTOS)">
                <xsl:choose>
                <xsl:when test="PLANTILLAS/PLANTILLA/CENTROAUTORIZADO='N'">
                     <xsl:value-of select="document($doc)/translation/texts/item[@name='Centro_bloqueado']/node()"/>
                </xsl:when>
                <xsl:when test="PLANTILLAS/PLANTILLA/OCULTAR='S'">
                  <span class="font11">&nbsp;<a href="javascript:Ocultar({IDPRODUCTO},'N')" class="rojoNormal"><img src="http://www.newco.dev.br/images/oculto.gif"/><!--[Oculto]--></a></span>
                </xsl:when>
                <xsl:when test="PLANTILLAS/PLANTILLA/OCULTAR='N'">
                  <span class="font11">&nbsp;<a href="javascript:Ocultar({IDPRODUCTO},'S')"><img src="http://www.newco.dev.br/images/visible.gif"/></a></span>
                </xsl:when>
                <xsl:otherwise>
                </xsl:otherwise>
                </xsl:choose>
              </xsl:if>
            </td>
            <td align="center"><xsl:value-of select="substring(MARCA,0,15)"/></td>
            <td align="center"><xsl:value-of select="UNIDADBASICA"/></td>
            <td align="right">
              <xsl:choose>
              <!--viejo modelo asisa viamed-->
				<xsl:when test="/ProductosEnPlantillas/LISTAPRODUCTOS/VIEJO_MODELO">
                <xsl:choose>
                <xsl:when test="/ProductosEnPlantillas/LISTAPRODUCTOS/MOSTRAR_PRECIO_CON_IVA"><!--viamed-->
									<xsl:value-of select="TARIFAPRIVADA_CONIVA_EURO"/>
                </xsl:when>
                <xsl:otherwise><!--asisa precio sin iva-->
                  <xsl:value-of select="TARIFAPRIVADA_EURO"/>
                </xsl:otherwise>
                </xsl:choose>
				</xsl:when>
              	<!--nuevo modelo gomosa, vendrell, fncp-->
              	<xsl:when test="/ProductosEnPlantillas/LISTAPRODUCTOS/NUEVO_MODELO">
					<xsl:value-of select="TARIFATOTAL_EURO"/>
				</xsl:when>
				</xsl:choose>
            </td>

          <xsl:if test="(/ProductosEnPlantillas/LISTAPRODUCTOS/ADMIN_CDC or /ProductosEnPlantillas/LISTAPRODUCTOS/ADMIN_MVM) and /ProductosEnPlantillas/LISTAPRODUCTOS/NUEVO_MODELO">
            <td align="center">
              <xsl:choose>
					<xsl:when test="PRECIOREF!=''">
						<xsl:value-of select="PRECIOREF"/>
					</xsl:when>
					<xsl:otherwise>
        				<xsl:value-of select="document($doc)/translation/texts/item[@name='no_informado']/node()"/>
					</xsl:otherwise>
              </xsl:choose>
            </td>
					</xsl:if>

            <td align="center"><xsl:value-of select="UNIDADESPORLOTE"/></td>
            <!--consumo-->
            <td align="center">
			
              <xsl:if test="/ProductosEnPlantillas/LISTAPRODUCTOS/ADMIN_CDC or /ProductosEnPlantillas/LISTAPRODUCTOS/ADMIN or /ProductosEnPlantillas/LISTAPRODUCTOS/CDC">
                <xsl:value-of select="PEDIDOS"/>
				<!--
                <xsl:value-of select="substring-before(PEDIDOS,'€')"/>
                <xsl:if test="/ProductosEnPlantillas/LANG = 'spanish'">€</xsl:if>
                <xsl:if test="/ProductosEnPlantillas/LANG = 'portugues'">R$</xsl:if>
				-->
              </xsl:if>
            </td>
          </tr>
		  	</xsl:for-each>
		<!--
          <tr class="lejenda">
            <th colspan="6" class="textLeft"><xsl:value-of select="/ProductosEnPlantillas/LISTAPRODUCTOS/MENSAJE"/></th>
            <th colspan="6" class="textRight">
              <xsl:if test="/ProductosEnPlantillas/LISTAPRODUCTOS/PAGINAANTERIOR or /ProductosEnPlantillas/LISTAPRODUCTOS/PAGINASIGUIENTE">
                <!- -	Botones de avanzar y retroceder	- ->
                <xsl:if test="/ProductosEnPlantillas/LISTAPRODUCTOS/PAGINAANTERIOR">
                  <a href="javascript:Enviar(document.forms[0],'ANTERIOR');">
                    <img src="http://www.newco.dev.br/images/flechaLeft.gif" />
                  </a>&nbsp;
                  <a href="javascript:Enviar(document.forms[0],'ANTERIOR');"><xsl:value-of select="document($doc)/translation/texts/item[@name='anterior']/node()"/></a>
                  <!- - <xsl:call-template name="botonNostyle">
                    <xsl:with-param name="path" select="/ProductosEnPlantillas/botones_nuevo/button[@label='NavegarAtras']"/>
                  </xsl:call-template>- ->
                </xsl:if>

                <xsl:if test="/ProductosEnPlantillas/LISTAPRODUCTOS/PAGINASIGUIENTE">
                  &nbsp;&nbsp;&nbsp;
                  <a href="javascript:Enviar(document.forms[0],'SIGUIENTE');"><xsl:value-of select="document($doc)/translation/texts/item[@name='siguiente']/node()"/></a>
                  &nbsp;
                  <a href="javascript:Enviar(document.forms[0],'SIGUIENTE');"><img src="http://www.newco.dev.br/images/flechaRight.gif" /></a>
                </xsl:if>
              </xsl:if>
            </th>
          </tr>-->
        </table>
      </xsl:when>
      <xsl:otherwise>
        <p style="text-align:center;margin-top:10px;padding-bottom:10px;font-weight:bold;border-bottom:1px solid grey;"><xsl:value-of select="document($doc)/translation/texts/item[@name='no_hay_datos_que_mostrar']/node()"/></p>
      </xsl:otherwise>
      </xsl:choose>
      </form>
    </div><!--fin de divLeft del inicio-->

    <!-- detalle de producto -->
    <div class="overlay-container">
		  <div class="window-container zoomout">
        <p style="text-align:right;margin-bottom:5px;">
          <a href="javascript:showTabla(false);" style="text-decoration:none;"><img src="http://www.newco.dev.br/images/cerrar.gif" /></a>
          <a href="javascript:showTabla(false);"><xsl:value-of select="document($doc)/translation/texts/item[@name='cerrar']/node()"/></a>
        </p>

        <table class="infoTable incidencias" id="detalleProd" cellspacing="5" style="border-collapse:none; border:2px solid #7d7d7d;" >
        <tbody></tbody>
        </table>
      </div>
    </div>
    <!-- detalle de producto-->

  </xsl:otherwise>
  </xsl:choose>
</body>
</html>
</xsl:template>

<xsl:template match="Sorry">
  <br/><br/><br/>
  <div class="middle">
    <br/>
    <xsl:choose>
		<xsl:when test="/ProductosEnPlantillas/DONDE_SE_BUSCA='PLA'">
      <xsl:value-of select="document($doc)/translation/texts/item[@name='producto_no_encontrado_en_plantillas']/node()"/>
		</xsl:when>
		<xsl:when test="/ProductosEnPlantillas/DONDE_SE_BUSCA='CP'">
      <xsl:value-of select="document($doc)/translation/texts/item[@name='producto_no_encontrado_en_catalogo_privado']/node()"/>
		</xsl:when>
		<xsl:when test="/ProductosEnPlantillas/DONDE_SE_BUSCA='NOPLA'">
      <xsl:value-of select="document($doc)/translation/texts/item[@name='producto_no_encontrado']/node()"/>
		</xsl:when>
		</xsl:choose>

    <br/><br/>
    <xsl:value-of select="document($doc)/translation/texts/item[@name='por_favor_compruebe_ortografia']/node()"/>
    <br/><br/>
    <xsl:value-of select="document($doc)/translation/texts/item[@name='muchas_gracias']/node()"/>
    <br/><br/>
  </div><!--fin de middle-->
</xsl:template>
</xsl:stylesheet>
