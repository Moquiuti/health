<?xml version="1.0" encoding="iso-8859-1"?>
<!--
   Mostrar información comrecial de la empresa.
	Ultima revision: 19oct16 11:42
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:import href="http://www.newco.dev.br/General/General.xsl"/>
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="lang" select="@lang"/>
<xsl:template match="/InfoCom">

<html>
<head>
	<!--idioma-->
	<xsl:variable name="lang">
    <xsl:choose>
		<xsl:when test="LANG"><xsl:value-of select="LANG"/></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
    </xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->

	<meta http-equiv="Cache-Control" Content="no-cache"/>

	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery-1.8.3.min.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>

<!-- solo se muestra la tabla resumen (como pop-up) para fichas de proveedores (acceso para usuarios MVM y MVMB) -->
<xsl:if test="(/InfoCom/EMPRESA/MVM or /InfoCom/EMPRESA/MVMB) and /InfoCom/EMPRESA/ROL='VENDEDOR'">
	<link rel="stylesheet" type="text/css" href="http://www.newco.dev.br/General/TablaResumen-popup.css"/>
	<script type="text/javascript" src="http://www.newco.dev.br/General/TablaResumen-popup.js"></script>
</xsl:if>

	<script type="text/javascript">
		var lang = '<xsl:value-of select="LANG"/>';
		var condProvOK	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='ok_cond_proveedor_save']/node()"/>';
		var condProvERR	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='error_cond_proveedor_save']/node()"/>';
	</script>

<xsl:text disable-output-escaping="yes">
<![CDATA[
	<script type="text/javascript">

		function CondProveedorSend(oForm){
			var IDProv	= oForm.elements['IDPROV'].value;
			var CodProv	= oForm.elements['COP_CODIGO'].value;
			var idFormaPago	= oForm.elements['IDFORMASPAGO'].value;
			var idPlazoPago	= oForm.elements['IDPLAZOSPAGO'].value;
			var gestionCad	= encodeURIComponent(oForm.elements['GESTION_CADUCIDAD'].value);
			var otrasLic	= encodeURIComponent(oForm.elements['OTRAS_LICITACIONES'].value);
			var observaciones	= encodeURIComponent(oForm.elements['OBSERVACIONES'].value);
			var nombrebanco	= encodeURIComponent(oForm.elements['COP_NOMBREBANCO'].value);
			var codbanco	= encodeURIComponent(oForm.elements['COP_CODBANCO'].value);
			var codoficina	= encodeURIComponent(oForm.elements['COP_CODOFICINA'].value);
			var codcuenta	= encodeURIComponent(oForm.elements['COP_CODCUENTA'].value);
			var d		= new Date();

			jQuery('#SAVE_MSG').hide();
			
			var Enlace="PROV_ID="+IDProv
					+"&CODIGO="+CodProv
					+"&IDFORMAPAGO="+idFormaPago
					+"&IDPLAZOPAGO="+idPlazoPago
					+"&GESTION_CADUCIDAD="+gestionCad
					+"&OTRAS_LICITACIONES="+otrasLic
					+"&OBSERVACIONES="+observaciones
					+"&NOMBREBANCO="+nombrebanco
					+"&CODBANCO="+codbanco
					+"&CODOFICINA="+codoficina
					+"&CODCUENTA="+codcuenta
					+"&_="+d.getTime();
			
			//solodebug		alert(Enlace);
			
			jQuery.ajax({
				cache:	false,
				url:	'http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/CondProvSave.xsql',
				type:	"GET",
				data:	Enlace,
				contentType: "application/xhtml+xml",
				success: function(objeto){
					var data = eval("(" + objeto + ")");

					if(data.Estado == 'OK'){
						jQuery('#SAVE_MSG_CELL').html(condProvOK);
						jQuery('#SAVE_MSG').show();

						// DC - 09/12/13 - Si venimos de Gestion >> Proveedores entonces refrescamos el frame padre
						if(String(window.opener.document.location) == 'http://www.newco.dev.br/Gestion/Comercial/CondicionesProveedores.xsql'){
							Refresh(window.opener.document);
            			}
			    }else{
						jQuery('#SAVE_MSG_CELL').html(condProvERR);
						jQuery('#SAVE_MSG').show();
					}
				},
				error: function(xhr, errorString, exception) {
					alert("xhr.status="+xhr.status+" error="+errorString+" exception="+exception);
				}
			});
		}

    function verTablas70(id){
      var k = id+"Div";

      jQuery(".tablas70").hide();
      jQuery("#PestanasInicio .veinte").css("background","#E3E2E2");
      jQuery("#"+id).css("background","#C3D2E9");
      jQuery("#"+k).show();
    }

		function mostrarEIS(indicador, idempresa, idcentro, refPro, anno){
			var Enlace;

			Enlace='http://www.newco.dev.br/Gestion/EIS/EISDatos2.xsql?'
					+'IDCUADROMANDO='+indicador
					+'&'+'ANNO='+anno
					+'&'+'IDEMPRESA=-1'
					+'&'+'IDCENTRO='
					+'&'+'IDUSUARIO=-1'
					+'&'+'IDEMPRESA2='+idempresa
					+'&'+'IDCENTRO=-1'
					+'&'+'IDPRODUCTO=-1'
					+'&'+'IDGRUPOCAT=-1'
					+'&'+'IDSUBFAMILIA=-1'
					+'&'+'IDESTADO=-1'
					+'&'+'REFERENCIA='+refPro
					+'&'+'CODIGO='
					+'&'+'AGRUPARPOR=EMP2';

			MostrarPagPersonalizada(Enlace,'EIS',100,80,0,0);
		}
	</script>
]]>
</xsl:text>
</head>

<body>
	<xsl:choose>
		<xsl:when test="//SESION_CADUCADA">
			<xsl:apply-templates select="//SESION_CADUCADA"/>
		</xsl:when>
		<xsl:when test="//xsql-error">
			<xsl:apply-templates select="//xsql-error"/>
		</xsl:when>
		<xsl:when test="//Status">
			<xsl:apply-templates select="//Status"/>
		</xsl:when>
		<xsl:otherwise>
			<xsl:apply-templates select="EMPRESA"/>
		</xsl:otherwise>
	</xsl:choose>
</body>
</html>
</xsl:template>

<!--
 |  Templates
 +-->

<xsl:template match="EMPRESA">
	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:choose>
		<xsl:when test="/InfoCom/LANG"><xsl:value-of select="/InfoCom/LANG"/></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<div class="divLeft">
		<!-- INICIO Condiciones Comerciales -->
		<h1 class="titlePage" style="float:left;width:60%;padding-left:20%;">
      <xsl:choose>
      <xsl:when test="EMP_NOMBRE_CORTO != ''"><xsl:value-of select="EMP_NOMBRE_CORTO" disable-output-escaping="yes"/></xsl:when>
      <xsl:otherwise><xsl:value-of select="EMP_NOMBRE" disable-output-escaping="yes"/></xsl:otherwise>
      </xsl:choose>:&nbsp;

      <xsl:value-of select="document($doc)/translation/texts/item[@name='informacion_comercial']/node()"/>

      <xsl:if test="/InfoCom/EMPRESA/MVM or /InfoCom/EMPRESA/MVMB">
        <xsl:text>&nbsp;&nbsp;&nbsp;</xsl:text>
        <a href="javascript:window.print();" style="text-decoration:none;">
          <img src="http://www.newco.dev.br/images/imprimir.gif"/>
          <xsl:value-of select="document($doc)/translation/texts/item[@name='imprimir']/node()"/>
        </a>
        <!--ense?o resumen arriba solo para proveedores, si es cliente ense?o tabla directamente-->
        <xsl:if test="/InfoCom/EMPRESA/ROL = 'VENDEDOR'">
          <xsl:text>&nbsp;&nbsp;&nbsp;</xsl:text>
          <a style="text-decoration:none;">
            <xsl:attribute name="href">javascript:showTablaResumenEmpresa(true);</xsl:attribute>
            <img src="http://www.newco.dev.br/images/tabla.gif"/>&nbsp;
            <xsl:value-of select="document($doc)/translation/texts/item[@name='resumen']/node()"/>
          </a>
        </xsl:if>
      </xsl:if>
		</h1>
    <h1 class="titlePage" style="float:left;width:20%;">&nbsp;
      <xsl:if test="/InfoCom/EMPRESA/MVM or /InfoCom/EMPRESA/MVMB or /InfoCom/EMPRESA/EDITAR_INFO_COMERCIAL"><span style="float:right; padding:5px;" class="amarillo">EMP_ID: <xsl:value-of select="EMP_ID"/></span></xsl:if>
    </h1>

    <!--CONDICIONES COMERCIALES SI SOY PROVEEDOR-->
    <xsl:if test="/InfoCom/EMPRESA/ROL = 'VENDEDOR'">
      <xsl:call-template name="condComercialProveedor"/>
		</xsl:if>
		<!-- FIN Condiciones Comerciales (ficha empresa proveedor) -->

		<!-- INICIO Condiciones Comerciales a Proveedor (ficha empresa cliente) -->
		<xsl:if test="/InfoCom/EMPRESA/ROL = 'COMPRADOR'">
      <xsl:call-template name="condComercialCliente"/>
		</xsl:if>

	</div><!--fin de divCenter50-->
</xsl:template>

<!--TEMPLATE COND_COMMERCIALES PROVEEDOR-->
<xsl:template name="condComercialProveedor">
  <!--idioma-->
	<xsl:variable name="lang">
		<xsl:choose>
		<xsl:when test="/InfoCom/LANG"><xsl:value-of select="/InfoCom/LANG"/></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

  <!-- solo se muestra la tabla resumen (como pop-up) para fichas de proveedores (acceso para usuarios MVM y MVMB) -->
	<xsl:if test="/InfoCom/EMPRESA/MVM or /InfoCom/EMPRESA/MVMB">
	<div class="overlay-container-2">
		<div class="window-container zoomout">
			<p><a href="javascript:showTablaResumenEmpresa(false);"><xsl:value-of select="document($doc)/translation/texts/item[@name='cerrar']/node()"/></a></p>
			<table>
			<thead>
				<tr>
					<td>&nbsp;</td>
				<xsl:for-each select="/InfoCom/EMPRESA/RESUMENES_MENSUALES/CABECERA/COLUMNA">
					<td><xsl:value-of select="MES"/>/<xsl:value-of select="ANYO"/></td>
				</xsl:for-each>
				</tr>
			</thead>

			<tbody>
			<xsl:for-each select="/InfoCom/EMPRESA/RESUMENES_MENSUALES/RESUMEN_MENSUAL">
				<tr>
					<td class="indicador"><xsl:value-of select="@Nombre"/></td>
				<xsl:for-each select="COLUMNA">
					<td><xsl:value-of select="VALOR"/></td>
				</xsl:for-each>
                                </tr>
			</xsl:for-each>
			</tbody>
			</table>
		</div>
	</div>
	</xsl:if>
	<!-- FIN Pop-up para mostrar tabla resumen empresa (solo MVM y MVMB)-->

  <div class="divLeft">
    <!--ANALISI PEDIDOS-->
    <div class="divLeft30nopa">
    <xsl:choose>
    <xsl:when test="/InfoCom/EMPRESA/CONDICIONES/IMPORTE_PEDIDOS != '0' and /InfoCom/EMPRESA/CONDICIONES/NUMERO_PEDIDOS != '0' and /InfoCom/EMPRESA/CONDICIONES/RETRASO_MEDIO != '0,00'">
      <table class="infoTable" border="0">
			<thead>
				<tr class="subTituloTabla">
					<td colspan="3">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='analisis_pedidos']/node()"/>:&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='periodo']/node()"/>&nbsp;<xsl:value-of select="/InfoCom/EMPRESA/CONDICIONES/INICIO_ANALISIS"/>&nbsp;-&nbsp;<xsl:value-of select="/InfoCom/EMPRESA/CONDICIONES/FINAL_ANALISIS"/>
					</td>
				</tr>
      </thead>

      <tbody>
        <tr>
          <td class="labelRight sesanta">
            <xsl:value-of select="document($doc)/translation/texts/item[@name='importe_tot_pedidos']/node()"/>:
          </td>
          <td class="datosLeft">
            <strong><xsl:value-of select="/InfoCom/EMPRESA/CONDICIONES/IMPORTE_PEDIDOS"/>&nbsp;
            	<xsl:choose>
							<xsl:when test="/InfoCom/LANG = 'spanish'">€</xsl:when>
              <xsl:otherwise>R$</xsl:otherwise>
              </xsl:choose>
            </strong>
          </td>
					<td class="datosLeft">
						<a href="javascript:mostrarEIS('CO_Pedidos_Eur','{/InfoCom/EMPRESA/EMP_ID}','','','9999');">
							<img src="http://www.newco.dev.br/images/tabla.gif"/>
						</a>
					</td>
        </tr>

        <tr>
          <td class="labelRight sesanta">
            <xsl:value-of select="document($doc)/translation/texts/item[@name='numero_de_pedidos']/node()"/>:
          </td>
          <td class="datosLeft"><strong><xsl:value-of select="/InfoCom/EMPRESA/CONDICIONES/NUMERO_PEDIDOS"/></strong></td>
					<td class="datosLeft">
						<a href="javascript:mostrarEIS('CO_Resumen_Num','{/InfoCom/EMPRESA/EMP_ID}','','','9999');">
							<img src="http://www.newco.dev.br/images/tabla.gif"/>
						</a>
					</td>
        </tr>

        <tr>
          <td class="labelRight sesanta">
            <xsl:value-of select="document($doc)/translation/texts/item[@name='retraso_medio']/node()"/>:
          </td>
          <td class="datosLeft"><strong><xsl:value-of select="/InfoCom/EMPRESA/CONDICIONES/RETRASO_MEDIO"/></strong></td>
					<td class="datosLeft">
						<a href="javascript:mostrarEIS('CO_RetrasosPedidos','{/InfoCom/EMPRESA/EMP_ID}','','','9999');">
							<img src="http://www.newco.dev.br/images/tabla.gif"/>
						</a>
					</td>
        </tr>
      </tbody>
      </table>
    </xsl:when>
    <xsl:otherwise>
      <table class="infoTable" border="0">
      <thead>
        <tr class="subTituloTabla">
          <td>
            <xsl:value-of select="document($doc)/translation/texts/item[@name='estadisticas_de_servicio']/node()"/>
          </td>
        </tr>
      </thead>

      <tbody>
        <tr>
          <td>
            <xsl:value-of select="document($doc)/translation/texts/item[@name='no_hay_pedidos_en_periodo']/node()"/>:&nbsp;<xsl:value-of select="/Empresas/EMPRESA/CONDICIONES/INICIO_ANALISIS"/>&nbsp;-&nbsp;<xsl:value-of select="/Empresas/EMPRESA/CONDICIONES/FINAL_ANALISIS"/>
          </td>
        </tr>
      </tbody>
      </table>
    </xsl:otherwise>
    </xsl:choose>
    </div><!--fin de divLeft30nopa-->

    <!--PEDIDO MINIMO-->
    <div class="divLeft40nopa">
      <xsl:call-template name="pedidoMinimo" />
    </div>

    <!--CONDICIONES PROVEE-->
    <div class="divLeft30nopa">
      <table class="infoTable" border="0">
      <thead>
        <tr class="subTituloTabla">
          <!--<td><xsl:value-of select="document($doc)/translation/texts/item[@name='condiciones_para']/node()"/>&nbsp;<xsl:value-of select="/InfoCom/EMPRESA/EMP_NOMBRE"/></td>-->
          <td><xsl:value-of select="document($doc)/translation/texts/item[@name='condiciones_para']/node()"/></td>
        </tr>
      </thead>

      <xsl:if test="/InfoCom/EMPRESA/CONDICIONES/COP_FORMADEPAGO = ''">
        <tr>
          <td>
            <xsl:value-of select="/InfoCom/EMPRESA/CONDICIONES/FORMA_PAGO/CEN_FORMAPAGO_TXT"/>&nbsp;-&nbsp;
            <xsl:value-of select="/InfoCom/EMPRESA/CONDICIONES/FORMA_PAGO/CEN_PLAZOPAGO_TXT"/>
          </td>
        </tr>
      </xsl:if>

      <xsl:if test="/InfoCom/EMPRESA/CONDICIONES/PLAZOENTREGA/PLANTILLA and /InfoCom/EMPRESA/ROL = 'VENDEDOR'">
        <xsl:for-each select="/InfoCom/EMPRESA/CONDICIONES/PLAZOENTREGA/PLANTILLA">
          <tr>
            <td><xsl:value-of select="document($doc)/translation/texts/item[@name='plazo_entrega']/node()"/>&nbsp;-&nbsp;<strong><xsl:value-of select="CATEGORIA"/></strong>&nbsp;<xsl:value-of select="PL_PLAZOENTREGA"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='dias']/node()"/></td>
          </tr>
        </xsl:for-each>
			</xsl:if>

        <tr><td>&nbsp;</td></tr>
      </table>
    </div><!--fin de divLeft30nopa-->
  </div><!--fin de divLeft-->

  <!--pesta?as condic comerciales prove, licitaciones, incidencias, rotura stock proveedor, cliente y mvm visualiza-->
  <div class="divLeft lineaAzul">&nbsp;</div>
  <div class="divLeft">
    <div class="divLeft15nopa">&nbsp;</div>
		<div class="divLeft70">
			<table id="PestanasInicio" border="0">
				<tr>
          <th>&nbsp;</th>
          <!--condic comm-->
          <th class="veinte" id="pestanaCondicPartic">
            <xsl:if test="not(/Mantenimiento/MANTENIMIENTO/ADMIN)"><xsl:attribute name="bgcolor">#C3D2E9</xsl:attribute></xsl:if>
            <a href="javascript:verTablas70('pestanaCondicPartic');">
              <xsl:value-of select="document($doc)/translation/texts/item[@name='condiciones_particulares']/node()"/>
            </a>
          </th>
          <!--licitaciones
          <th class="veinte pestanaInicio" id="pestanaLicitaciones">
            <a href="javascript:verTablas70('pestanaLicitaciones');">
              <xsl:value-of select="document($doc)/translation/texts/item[@name='licitaciones']/node()"/>
            </a>
          </th>-->
          <!--evaluaciones-->
          <th class="veinte pestanaInicio" id="pestanaEvaluaciones">
            <a href="javascript:verTablas70('pestanaEvaluaciones');">
              <xsl:value-of select="document($doc)/translation/texts/item[@name='evaluaciones']/node()"/>
              &nbsp;(<xsl:value-of select="EVALUACIONESPRODUCTOS/TOTAL"/>)
            </a>
          </th>
          <!--incidencias-->
          <th class="veinte pestanaInicio" id="pestanaIncidecias">
            <a href="javascript:verTablas70('pestanaIncidecias');">
              <xsl:value-of select="document($doc)/translation/texts/item[@name='incidencias']/node()"/>
              &nbsp;(<xsl:value-of select="INCIDENCIASPRODUCTOS/TOTAL" />)
            </a>
          </th>
          <!--rotura de stock-->
          <th class="veinte pestanaInicio" id="pestanaRoturas">
            <a href="javascript:verTablas70('pestanaRoturas');">
              <xsl:value-of select="document($doc)/translation/texts/item[@name='roturas_stock']/node()"/>
              &nbsp;(<xsl:value-of select="ROTURAS_STOCKS/TOTAL" />)
            </a>
          </th>
          <th>&nbsp;</th>
				</tr>
			</table>
		</div><!--fin de divcenter70-->
	</div><!--fin de divleft pesta?as-->

  <!--condiciones particulares-->
  <div class="divLeft tablas70" id="pestanaCondicParticDiv" style="margin-bottom:15px;">

		<table class="infoTable" border="0">
		<form name="CondProveedor" id="formCondProveedor" method="post">
		<input type="hidden" name="IDPROV" value="{/InfoCom/EMPRESA/EMP_ID}" id="IDPROV"/>
		<thead>
			<tr>
				<th colspan="7"><xsl:value-of select="document($doc)/translation/texts/item[@name='condiciones_particulares']/node()"/></th>
			</tr>
		</thead>
		<tbody>
		<tr>
			<td>&nbsp;</td>
			<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='codigo']/node()"/>:</td>
			<td class="datosLeft" colspan="3">
				<xsl:choose>
				<xsl:when test="/InfoCom/EMPRESA/EDITAR_INFO_COMERCIAL">
					<input type="text" name="COP_CODIGO" id="COP_CODIGO" value="{/InfoCom/EMPRESA/CONDICIONES/COP_CODIGO}"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="/InfoCom/EMPRESA/CONDICIONES/COP_CODIGO"/>
				</xsl:otherwise>
				</xsl:choose>
			</td>
			<td>&nbsp;</td>
		</tr>
		<tr>
			<td class="dos">&nbsp;</td>
			<td class="labelRight trenta"><xsl:value-of select="document($doc)/translation/texts/item[@name='forma_pago']/node()"/>:</td>
			<td class="datosLeft quince">
			<xsl:choose>
			<xsl:when test="/InfoCom/EMPRESA/EDITAR_INFO_COMERCIAL">
				<xsl:call-template name="desplegable">
				<xsl:with-param name="path" select="/InfoCom/EMPRESA/CONDICIONES/FORMASPAGO/field"/>
				</xsl:call-template>
			<!--<input type="text" name="FORMA_PAGO" value="{/InfoCom/EMPRESA/CONDICIONES/COP_FORMADEPAGO}" size="40"/>-->
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="/InfoCom/EMPRESA/CONDICIONES/COP_FORMADEPAGO"/>
			</xsl:otherwise>
			</xsl:choose>
        	</td>
        	<td class="labelRight dies"><xsl:value-of select="document($doc)/translation/texts/item[@name='plazo_de_pago']/node()"/>:</td>
			<td class="datosLeft">
			<xsl:choose>
			<xsl:when test="/InfoCom/EMPRESA/EDITAR_INFO_COMERCIAL">
			<xsl:call-template name="desplegable">
				<xsl:with-param name="path" select="/InfoCom/EMPRESA/CONDICIONES/PLAZOSPAGO/field"/>
			</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="/InfoCom/EMPRESA/CONDICIONES/COP_FORMADEPAGO"/>
			</xsl:otherwise>
			</xsl:choose>
        	</td>
			<td>&nbsp;</td>
		</tr>
		<xsl:choose>
		<xsl:when test="/InfoCom/EMPRESA/EMP_IDPAIS=55">
			<tr>
				<td class="dos">&nbsp;</td>
				<td class="labelRight trenta"><xsl:value-of select="document($doc)/translation/texts/item[@name='Nombre_banco']/node()"/>:</td>
				<td class="datosLeft quince">
				<xsl:choose>
				<xsl:when test="/InfoCom/EMPRESA/EDITAR_INFO_COMERCIAL">
						<input type="text" name="COP_NOMBREBANCO" id="COP_NOMBREBANCO" size="20" value="{/InfoCom/EMPRESA/CONDICIONES/COP_NOMBREBANCO}"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="/InfoCom/EMPRESA/CONDICIONES/COP_NOMBREBANCO"/>
				</xsl:otherwise>
				</xsl:choose>
        		</td>
				<td class="datosLeft quince">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='cod_banco']/node()"/>:
				<xsl:choose>
				<xsl:when test="/InfoCom/EMPRESA/EDITAR_INFO_COMERCIAL">
						<input type="text" name="COP_CODBANCO" id="COP_CODBANCO" size="6" value="{/InfoCom/EMPRESA/CONDICIONES/COP_CODBANCO}"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="/InfoCom/EMPRESA/CONDICIONES/COP_CODBANCO"/>
				</xsl:otherwise>
				</xsl:choose>
        		</td>
				<td class="datosLeft quince">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='cod_oficina']/node()"/>:
				<xsl:choose>
				<xsl:when test="/InfoCom/EMPRESA/EDITAR_INFO_COMERCIAL">
						<input type="text" name="COP_CODOFICINA" id="COP_CODOFICINA" size="6" value="{/InfoCom/EMPRESA/CONDICIONES/COP_CODOFICINA}"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="/InfoCom/EMPRESA/CONDICIONES/COP_CODOFICINA"/>
				</xsl:otherwise>
				</xsl:choose>
        		</td>
				<td class="datosLeft quince">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='cod_cuenta']/node()"/>:
				<xsl:choose>
				<xsl:when test="/InfoCom/EMPRESA/EDITAR_INFO_COMERCIAL">
						<input type="text" name="COP_CODCUENTA" id="COP_CODCUENTA" size="6" value="{/InfoCom/EMPRESA/CONDICIONES/COP_CODCUENTA}"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="/InfoCom/EMPRESA/CONDICIONES/COP_CODCUENTA"/>
				</xsl:otherwise>
				</xsl:choose>
        		</td>
				<td>&nbsp;</td>
			</tr>
		</xsl:when>
		<xsl:otherwise>
			<input type="hidden" name="COP_NOMBREBANCO" id="COP_NOMBREBANCO" value="{/InfoCom/EMPRESA/CONDICIONES/COP_NOMBREBANCO}"/>
			<input type="hidden" name="COP_CODBANCO" id="COP_CODBANCO" value="{/InfoCom/EMPRESA/CONDICIONES/COP_CODBANCO}"/>
			<input type="hidden" name="COP_CODOFICINA" id="COP_CODOFICINA" value="{/InfoCom/EMPRESA/CONDICIONES/COP_CODOFICINA}"/>
			<input type="hidden" name="COP_CODCUENTA" id="COP_CODCUENTA" value="{/InfoCom/EMPRESA/CONDICIONES/COP_CODCUENTA}"/>
		</xsl:otherwise>
		</xsl:choose>

		<tr>
			<td>&nbsp;</td>
			<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='gestion_caducidades']/node()"/>:</td>
			<td class="datosLeft" colspan="3">
				<xsl:choose>
				<xsl:when test="/InfoCom/EMPRESA/EDITAR_INFO_COMERCIAL">
					<textarea name="GESTION_CADUCIDAD" cols="80" rows="4">
						<xsl:value-of select="/InfoCom/EMPRESA/CONDICIONES/COP_GESTIONCADUCIDADES"/>
					</textarea>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="/InfoCom/EMPRESA/CONDICIONES/COP_GESTIONCADUCIDADES"/>
				</xsl:otherwise>
				</xsl:choose>
			</td>
			<td>&nbsp;</td>
      </tr>

	<tr>
		<td>&nbsp;</td>
		<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='otras_licitaciones']/node()"/>:</td>
		<td class="datosLeft" colspan="3">
			<xsl:choose>
			<xsl:when test="/InfoCom/EMPRESA/EDITAR_INFO_COMERCIAL">
				<textarea name="OTRAS_LICITACIONES" cols="80" rows="4">
					<xsl:value-of select="/InfoCom/EMPRESA/CONDICIONES/COP_OTRASLICITACIONES"/>
				</textarea>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="/InfoCom/EMPRESA/CONDICIONES/COP_OTRASLICITACIONES"/>
			</xsl:otherwise>
			</xsl:choose>
		</td>
		<td>&nbsp;</td>
      </tr>

      <tr>
		<td>&nbsp;</td>
		<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='observaciones_pedidos']/node()"/>:</td>
		<td class="datosLeft" colspan="3">
			<xsl:choose>
			<xsl:when test="/InfoCom/EMPRESA/EDITAR_INFO_COMERCIAL">
				<textarea name="OBSERVACIONES" cols="80" rows="4">
					<xsl:value-of select="/InfoCom/EMPRESA/CONDICIONES/COP_OBSERVACIONESPEDIDOS"/>
				</textarea>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="/InfoCom/EMPRESA/CONDICIONES/COP_OBSERVACIONESPEDIDOS"/><br />
			</xsl:otherwise>
			</xsl:choose>
          <br />
          <xsl:value-of select="document($doc)/translation/texts/item[@name='observaciones_pedido_expli']/node()"/>
		</td>
		<td>&nbsp;</td>
      </tr>

		<xsl:if test="/InfoCom/EMPRESA/EDITAR_INFO_COMERCIAL">
			<tr style="display:none;" id="SAVE_MSG">
				<td colspan="2">&nbsp;</td>
				<td colspan="2" id="SAVE_MSG_CELL" class="fondoVerde" style="text-align:left;font-weight:bold;">&nbsp;</td>
				<td colspan="2">&nbsp;</td>
			</tr>

			<tr>
				<td colspan="2">&nbsp;</td>
				<td>
					<xsl:if test="not(/InfoCom/EMPRESA/OBSERVADOR)">
            <div class="boton">
							<a href="javascript:CondProveedorSend(document.forms['CondProveedor']);">
								<xsl:value-of select="document($doc)/translation/texts/item[@name='guardar']/node()"/>
							</a>
            </div>
          </xsl:if>
				</td>
				<td colspan="3">&nbsp;</td>
			</tr>
		</xsl:if>
		</tbody>
    </form>
		</table>
  </div><!--fin de divLeft-->

  <!--licitaciones info comm-->
  <div class="divLeft tablas70" id="pestanaLicitacionesDiv" style="display:none;">
    <xsl:choose>
    <xsl:when test="/InfoCom/EMPRESA/CONDICIONES/LICITACIONES/LICITACION">
			<table class="infoTable" border="0">
			<thead>
				<tr>
					<th class="dies">&nbsp;</th>
					<th align="left"><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_alta']/node()"/></th>
					<th align="left"><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_decision']/node()"/></th>
					<th style="text-align:left;"><xsl:value-of select="document($doc)/translation/texts/item[@name='nombre']/node()"/></th>
					<th><xsl:value-of select="document($doc)/translation/texts/item[@name='estado']/node()"/></th>
					<th>
						<xsl:value-of select="document($doc)/translation/texts/item[@name='consumo']/node()"/>&nbsp;
						(<xsl:value-of select="document($doc)/translation/texts/item[@name='eur']/node()"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='c_iva']/node()"/>)
					</th>
					<th style="text-align:left;"><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor_adjudicado']/node()"/></th>
				</tr>
	    </thead>

			<tbody>
			<xsl:for-each select="/InfoCom/EMPRESA/CONDICIONES/LICITACIONES/LICITACION">
				<tr class="lineGris">
					<td class="dos">&nbsp;</td>
					<td class="textLeft ocho"><xsl:value-of select="LIC_FECHAALTA"/></td>
					<td class="textLeft ocho"><xsl:value-of select="LIC_FECHADECISIONPREVISTA"/></td>
					<td class="veinte" style="text-align:left;"><xsl:value-of select="LIC_TITULO"/></td>
					<td><xsl:value-of select="ESTADO"/></td>
					<td><xsl:value-of select="LIC_CONSUMOIVA"/></td>
					<td style="text-align:left;"><xsl:value-of select="PROVEEDORSELECCIONADO"/></td>
				</tr>
			</xsl:for-each>
			</tbody>
			</table>
    </xsl:when>
    <xsl:otherwise>
      <table class="infoTable" border="0">
      <thead>
				<tr>
          <th><xsl:value-of select="document($doc)/translation/texts/item[@name='licitaciones_sin_resultados']/node()"/></th>
				</tr>
      </thead>
      </table>
    </xsl:otherwise>
    </xsl:choose>
  </div><!--fin de divLeft-->

  <!--evaluaciones info comm-->
  <div class="divLeft tablas70" id="pestanaEvaluacionesDiv" style="display:none;">
    <xsl:choose>
    <xsl:when test="/InfoCom/EMPRESA/EVALUACIONESPRODUCTOS/EVALUACION">
			<table class="infoTable" border="0">
			<thead>
				<tr>
					<td class="cinco">&nbsp;</td>
					<th><xsl:value-of select="document($doc)/translation/texts/item[@name='pos']/node()"/>.</th>
					<th class="dos"><xsl:value-of select="document($doc)/translation/texts/item[@name='cod_abbr']/node()"/></th>
					<th><xsl:copy-of select="document($doc)/translation/texts/item[@name='fecha']/node()"/></th>
	        <!--<th align="left"><xsl:value-of select="document($doc)/translation/texts/item[@name='cliente']/node()"/></th>-->
					<th align="left" class="quince"><xsl:value-of select="document($doc)/translation/texts/item[@name='centro_de_cliente']/node()"/></th>
	        <th align="left"><xsl:value-of select="document($doc)/translation/texts/item[@name='respon']/node()"/></th>
	        <th align="left">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='ref_cliente']/node()"/></th>
	        <th align="left">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='ref_prov']/node()"/></th>
					<th align="left">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/></th>
	        <th align="left"><xsl:value-of select="document($doc)/translation/texts/item[@name='coordinador']/node()"/></th>
					<!--<th align="left"><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/></th>-->
	        <th align="left">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='usuario_prov']/node()"/></th>
					<th><xsl:value-of select="document($doc)/translation/texts/item[@name='estado']/node()"/></th>
					<th><xsl:value-of select="document($doc)/translation/texts/item[@name='diagn']/node()"/></th>
	        <th>&nbsp;</th>
				</tr>
	    </thead>

			<tbody>
			<xsl:for-each select="/InfoCom/EMPRESA/EVALUACIONESPRODUCTOS/EVALUACION">
				<tr class="lineGris">
					<td>&nbsp;</td>
	        <td><xsl:value-of select="position()"/></td>
					<td><a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Gestion/Comercial/EvaluacionProducto.xsql?ID_EVAL={PROD_EV_ID}','evaluacion',100,80,0,-10)">
	          	<xsl:value-of select="PROD_EV_CODIGO"/>
	          </a>
	        </td>
					<td><xsl:value-of select="PROD_EV_FECHA"/></td>
					<!--<td style="text-align:left;">
						<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPDetalleFrame.xsql?EMP_ID={IDCLIENTE}&amp;VENTANA=NUEVA','DetalleEmpresa',100,80,0,0)">
							<xsl:value-of select="CLIENTE"/>
						</a>&nbsp;
					</td>-->
					<td style="text-align:left;">
						<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/CENDetalle.xsql?ID={IDCENTROEVALUACION}','DetalleCentro',100,80,0,0)">
							<xsl:value-of select="CENTROEVALUACION"/>
	          </a>
					</td>
	        <td style="text-align:left;"><xsl:value-of select="AUTOR"/></td>
	        <td style="text-align:left;">&nbsp;
						<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Gestion/Comercial/EvaluacionProducto.xsql?ID_EVAL={PROD_EV_ID}','evaluacion',100,80,0,-10)">
							<xsl:value-of select="REFERENCIA"/></a>
					</td>
	        <td style="text-align:left;">
						<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Gestion/Comercial/EvaluacionProducto.xsql?ID_EVAL={PROD_EV_ID}','evaluacion',100,80,0,-10)">
							<xsl:value-of select="PROD_EV_REFPROVEEDOR"/>&nbsp;
						</a>
					</td>
					<td style="text-align:left;">
						<strong><a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Gestion/Comercial/EvaluacionProducto.xsql?ID_EVAL={PROD_EV_ID}','evaluacion',100,80,0,-10)">
								<xsl:value-of select="PROD_EV_NOMBRE"/>
						</a></strong>
					</td>
	        <td style="text-align:left;">
						<xsl:value-of select="COORDINADOR"/>
					</td>
					<!--<td style="text-align:left;">
						<xsl:value-of select="PROVEEDOR"/>
					</td>-->
	        <td style="text-align:left;">&nbsp;<xsl:value-of select="USUARIOMUESTRAS"/></td>
					<td><xsl:value-of select="ESTADO"/></td>
	        <td>
	          &nbsp;
	          <xsl:choose>
	          <xsl:when test="PROD_EV_DIAGNOSTICO = 'Apto'"><span class="verde"><xsl:value-of select="PROD_EV_DIAGNOSTICO" /></span></xsl:when>
	          <xsl:otherwise><span class="rojo"><xsl:value-of select="PROD_EV_DIAGNOSTICO" /></span></xsl:otherwise>
	          </xsl:choose>
          </td>
					<td>&nbsp;</td>
				</tr>
			</xsl:for-each>
			</tbody>
			</table>
    </xsl:when>
    <xsl:otherwise>
      <table class="infoTable" border="0">
			<thead>
				<tr>
          <th><xsl:value-of select="document($doc)/translation/texts/item[@name='evaluaciones_sin_resultados']/node()"/></th>
				</tr>
      </thead>
      </table>
    </xsl:otherwise>
    </xsl:choose>
  </div><!--fin de divLeft-->

  <!--incidencias info comm-->
  <div class="divLeft tablas70" id="pestanaIncideciasDiv" style="display:none;">
    <xsl:choose>
    <xsl:when test="/InfoCom/EMPRESA/INCIDENCIASPRODUCTOS/INCIDENCIA">
			<table class="infoTable" border="0">
			<thead>
				<tr>
					<th class="cinco">&nbsp;</th>
	        <th align="left"><xsl:value-of select="document($doc)/translation/texts/item[@name='pos']/node()"/>.</th>
					<th class="dos"><xsl:value-of select="document($doc)/translation/texts/item[@name='cod_abbr']/node()"/></th>
					<th><xsl:copy-of select="document($doc)/translation/texts/item[@name='fecha_comunicacion_2line']/node()"/></th>
	        <th><xsl:copy-of select="document($doc)/translation/texts/item[@name='ultimo_cambio']/node()"/></th>
	        <!--<th align="left"><xsl:value-of select="document($doc)/translation/texts/item[@name='cliente']/node()"/></th>-->
					<th align="left"><xsl:value-of select="document($doc)/translation/texts/item[@name='centro_de_cliente']/node()"/></th>
					<th align="left">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='ref_cliente']/node()"/></th>
					<th align="left">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/></th>
					<th align="left"><xsl:value-of select="document($doc)/translation/texts/item[@name='responsable']/node()"/></th>
					<!--<th align="left"><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/></th>-->
					<th><xsl:value-of select="document($doc)/translation/texts/item[@name='estado']/node()"/></th>
	        <th>&nbsp;</th>
				</tr>
	    </thead>

			<tbody>
			<xsl:for-each select="/InfoCom/EMPRESA/INCIDENCIASPRODUCTOS/INCIDENCIA">
				<tr class="lineGris">
					<td class="dos">&nbsp;</td>
					<td><xsl:value-of select="position()"/></td>
					<td>
	          <a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Productos/Incidencia.xsql?ID_INC={PROD_INC_ID}&amp;PRO_ID={PROD_INC_IDPRODUCTO}&amp;LIC_OFE_ID={PROD_INC_IDOFERTA_LIC}','incidencia',100,80,0,-10)">
	            <xsl:value-of select="PROD_INC_CODIGO"/>
	          </a>
	        </td>
					<td><xsl:value-of select="PROD_INC_FECHA"/></td>
	        <td><xsl:value-of select="FECHA_ULTIMO_CAMBIO"/></td>
	        <!--<td style="text-align:left;">
						<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPDetalleFrame.xsql?EMP_ID={IDCLIENTE}&amp;VENTANA=NUEVA','DetalleEmpresa',100,80,0,0)">
							<xsl:value-of select="CLIENTE"/>
						</a>
					</td>-->
					<td style="text-align:left;">
						<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/CENDetalle.xsql?ID={IDCENTROCLIENTE}','DetalleCentro',100,80,0,0)">
							<xsl:value-of select="CENTROCLIENTE"/>
	          </a>
					</td>
					<td style="text-align:left;">&nbsp;
						<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Productos/Incidencia.xsql?ID_INC={PROD_INC_ID}&amp;PRO_ID={PROD_INC_IDPRODUCTO}&amp;LIC_OFE_ID={PROD_INC_IDOFERTA_LIC}','incidencia',100,80,0,-10)">
							<xsl:value-of select="REFERENCIA"/>
						</a>
					</td>
					<td style="text-align:left;">&nbsp;
						<strong>
	            <a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Productos/Incidencia.xsql?ID_INC={PROD_INC_ID}&amp;PRO_ID={PROD_INC_IDPRODUCTO}&amp;LIC_OFE_ID={PROD_INC_IDOFERTA_LIC}','incidencia',100,80,0,-10)">
								<xsl:value-of select="PROD_INC_DESCESTANDAR"/>
	            </a>
	          </strong>
					</td>
					<td style="text-align:left;"><xsl:value-of select="USUARIO"/></td>
					<!--<td style="text-align:left;">
						<xsl:value-of select="PROVEEDOR"/>
					</td>-->
					<td><xsl:value-of select="ESTADO"/></td>
				</tr>
			</xsl:for-each>
			</tbody>
			</table>
    </xsl:when>
    <xsl:otherwise>
      <table class="infoTable" border="0">
			<thead>
        <tr>
					<th><xsl:value-of select="document($doc)/translation/texts/item[@name='incidecias_sin_resultados']/node()"/></th>
        </tr>
      </thead>
      </table>
    </xsl:otherwise>
    </xsl:choose>
  </div><!--fin de divLeft-->

  <!--roturas de stock info comm-->
  <div class="divLeft tablas70" id="pestanaRoturasDiv" style="display:none;">
    <xsl:choose>
    <xsl:when test="/InfoCom/EMPRESA/ROTURAS_STOCKS/ROTURAS_STOCKS_HISTORICAS/ROTURA_STOCKS or /InfoCom/EMPRESA/ROTURAS_STOCKS/ROTURAS_STOCKS_ACTIVAS/ROTURA_STOCKS">
			<table class="infoTable" border="0">
			<thead>
				<tr>
					<th class="dos">&nbsp;</th>
	        <th class="tres" align="left"><xsl:value-of select="document($doc)/translation/texts/item[@name='pos']/node()"/>.</th>
					<th class="cinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha']/node()"/>&nbsp;&nbsp;</th>
					<th class="veinte" align="left"><xsl:copy-of select="document($doc)/translation/texts/item[@name='producto']/node()"/></th>
	        <th class="ocho" align="left"><xsl:copy-of select="document($doc)/translation/texts/item[@name='ref_proveedor']/node()"/></th>
	        <th class="dies" align="left"><xsl:copy-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/></th>
	        <th class="veinte" align="left"><xsl:copy-of select="document($doc)/translation/texts/item[@name='comentarios']/node()"/></th>
					<th class="veinte" align="left"><xsl:value-of select="document($doc)/translation/texts/item[@name='alternativa']/node()"/></th>
					<th class="cinco" align="left"><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha']/node()"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='final']/node()"/></th>
	        <th class="cinco" align="left"><xsl:value-of select="document($doc)/translation/texts/item[@name='duracion']/node()"/></th>
	        <th>&nbsp;</th>
				</tr>
	    </thead>

			<tbody>
	    <xsl:for-each select="/InfoCom/EMPRESA/ROTURAS_STOCKS/ROTURAS_STOCKS_ACTIVAS/ROTURA_STOCKS">
				<tr class="lineGris amarillo">
					<td>&nbsp;</td>
					<td style="text-align:left;"><xsl:value-of select="POS"/></td>
	        <td style="text-align:left;"><xsl:value-of select="FECHA" />&nbsp;&nbsp;</td>
	        <td style="text-align:left;"><xsl:value-of select="PRODUCTO" /></td>
	        <td style="text-align:left;"><xsl:value-of select="REFPROVEEDOR" /></td>
	        <td style="text-align:left;"><xsl:value-of select="PROVEEDOR" /></td>
	        <td style="text-align:left;"><xsl:value-of select="COMENTARIOS" /></td>
	        <td style="text-align:left;"><xsl:value-of select="ALTERNATIVA" /></td>
	        <td style="text-align:left;"><xsl:value-of select="document($doc)/translation/texts/item[@name='pendiente']/node()"/></td>
	        <td style="text-align:left;">&nbsp;</td>
	        <td>&nbsp;</td>
				</tr>
			</xsl:for-each>

			<xsl:for-each select="/InfoCom/EMPRESA/ROTURAS_STOCKS/ROTURAS_STOCKS_HISTORICAS/ROTURA_STOCKS">
				<tr class="lineGris">
					<td>&nbsp;</td>
					<td style="text-align:left;"><xsl:value-of select="POS"/></td>
	        <td style="text-align:left;"><xsl:value-of select="FECHA" />&nbsp;&nbsp;</td>
	        <td style="text-align:left;"><xsl:value-of select="PRODUCTO" /></td>
	        <td style="text-align:left;"><xsl:value-of select="REFPROVEEDOR" /></td>
	        <td style="text-align:left;"><xsl:value-of select="PROVEEDOR" /></td>
	        <td style="text-align:left;"><xsl:value-of select="COMENTARIOS" /></td>
	        <td style="text-align:left;"><xsl:value-of select="ALTERNATIVA" /></td>
	        <td style="text-align:left;"><xsl:value-of select="FECHAFINAL" /></td>
	        <td style="text-align:center;"><xsl:value-of select="DURACION" /></td>
	        <td>&nbsp;</td>
				</tr>
			</xsl:for-each>
			</tbody>
			</table>
    </xsl:when>
    <xsl:otherwise>
      <table class="infoTable" border="0">
			<thead>
        <tr>
					<th><xsl:value-of select="document($doc)/translation/texts/item[@name='roturas_sin_resultados']/node()"/></th>
        </tr>
      </thead>
      </table>
    </xsl:otherwise>
    </xsl:choose>
  </div><!--fin de divLeft-->
</xsl:template><!--find de cond comercial prove-->

<xsl:template name="condComercialCliente">
  <!--idioma-->
	<xsl:variable name="lang">
		<xsl:choose>
		<xsl:when test="/InfoCom/LANG"><xsl:value-of select="/InfoCom/LANG"/></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
  <!--idioma fin-->

  <!-- Tabla resumen empresa (siempre visible para ficha de clientes) -->
	<xsl:if test="/InfoCom/EMPRESA/MVM or /InfoCom/EMPRESA/MVMB">
	<div class="divLeft">
		<table class="grandeInicio">
		<thead>
			<tr class="subTituloTabla">
				<th class="textLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='resumen']/node()"/></th>
				<xsl:for-each select="/InfoCom/EMPRESA/RESUMENES_MENSUALES/CABECERA/COLUMNA">
					<th><xsl:value-of select="MES"/>/<xsl:value-of select="ANYO"/></th>
				</xsl:for-each>
			</tr>
		</thead>

		<tbody>
		<xsl:for-each select="/InfoCom/EMPRESA/RESUMENES_MENSUALES/RESUMEN_MENSUAL">
			<tr>
				<td class="indicador textLeft"><xsl:value-of select="@Nombre"/></td>
				<xsl:for-each select="COLUMNA">
					<td><xsl:value-of select="VALOR"/></td>
				</xsl:for-each>
      </tr>
		</xsl:for-each>
		</tbody>
		</table>
	</div>
	</xsl:if>
</xsl:template>

<!--PEDIDO MINIMO PARA PROVEE-->
<xsl:template name="pedidoMinimo">
  <!--idioma-->
	<xsl:variable name="lang">
		<xsl:choose>
		<xsl:when test="/InfoCom/LANG"><xsl:value-of select="/InfoCom/LANG"/></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

  <xsl:choose><!--si no hay pedidos minimos por centros ense?o en 4 lineas el pedido minimo general, si no ense?o todo como tabla-->
  <xsl:when test="(/InfoCom/EMPRESA/CONDICIONES/PEDIDOMINIMO/EMPRESA  or /InfoCom/EMPRESA/CONDICIONES/PEDIDO_MINIMO_GENERAL/EMP_PEDMINIMO_ACTIVO != '') and /InfoCom/EMPRESA/ROL = 'VENDEDOR' and /InfoCom/EMPRESA/CONDICIONES/PEDIDOMINIMO/CENTROS/CENTRO">

		<table class="infoTable"  style="border-right:1px solid #666;border-left:1px solid #666;">
		<thead>
      <tr class="subTituloTabla">
        <td colspan="4"><xsl:value-of select="document($doc)/translation/texts/item[@name='pedido_minimo']/node()"/></td>
			</tr>
			<tr class="subTituloTablaNoB">
				<td align="left"><xsl:value-of select="document($doc)/translation/texts/item[@name='centro']/node()"/></td>
				<td><xsl:value-of select="document($doc)/translation/texts/item[@name='tipo']/node()"/></td>
				<td><xsl:value-of select="document($doc)/translation/texts/item[@name='importe']/node()"/></td>
				<td><xsl:value-of select="document($doc)/translation/texts/item[@name='descripcion']/node()"/></td>
			</tr>
    </thead>

    <tbody>
		<xsl:for-each select="/InfoCom/EMPRESA/CONDICIONES/PEDIDOMINIMO/CENTROS/CENTRO">
			<tr>
				<td class="textLeft"><xsl:value-of select="NOMBRE"/></td>
				<td>
					<xsl:choose>
					<xsl:when test="PMC_PEDMINIMO_ACTIVO='N'">
						<b><xsl:value-of select="document($doc)/translation/texts/item[@name='no_activo']/node()"/></b>
					</xsl:when>
					<xsl:when test="PMC_PEDMINIMO_ACTIVO='S'">
						<b><xsl:value-of select="document($doc)/translation/texts/item[@name='activo']/node()"/></b>
					</xsl:when>
					<xsl:when test="PMC_PEDMINIMO_ACTIVO='E'">
						<b><xsl:value-of select="document($doc)/translation/texts/item[@name='estricto']/node()"/></b>
					</xsl:when>
					<xsl:when test="PMC_PEDMINIMO_ACTIVO='I'">
						<b><xsl:value-of select="document($doc)/translation/texts/item[@name='integrado']/node()"/></b>
					</xsl:when>
					</xsl:choose>
				</td>
				<td>
					<xsl:value-of select="PMC_PEDMINIMO_IMPORTE"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='eur']/node()"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='s_iva']/node()"/>
				</td>
				<td>
					<xsl:copy-of select="PMC_PEDMINIMO_DETALLE"/>
				</td>
			</tr>
		</xsl:for-each>

			<tr style="border-bottom:1px solid #999999;">
				<td><xsl:value-of select="document($doc)/translation/texts/item[@name='resto_centros']/node()"/></td>
				<td>
				<xsl:choose>
				<xsl:when test="/InfoCom/EMPRESA/CONDICIONES/PEDIDOMINIMO/EMPRESA">
					<xsl:choose>
					<xsl:when test="/InfoCom/EMPRESA/CONDICIONES/PEDIDOMINIMO/EMPRESA/PME_PEDMINIMO_ACTIVO='N'">
						<b><xsl:value-of select="document($doc)/translation/texts/item[@name='no_activo']/node()"/></b>
					</xsl:when>
					<xsl:when test="/InfoCom/EMPRESA/CONDICIONES/PEDIDOMINIMO/EMPRESA/PME_PEDMINIMO_ACTIVO='S'">
						<b><xsl:value-of select="document($doc)/translation/texts/item[@name='activo']/node()"/></b>
					</xsl:when>
					<xsl:when test="/InfoCom/EMPRESA/CONDICIONES/PEDIDOMINIMO/EMPRESA/PME_PEDMINIMO_ACTIVO='E'">
						<b><xsl:value-of select="document($doc)/translation/texts/item[@name='estricto']/node()"/></b>
					</xsl:when>
					<xsl:when test="/InfoCom/EMPRESA/CONDICIONES/PEDIDOMINIMO/EMPRESA/PME_PEDMINIMO_ACTIVO='I'">
						<b><xsl:value-of select="document($doc)/translation/texts/item[@name='integrado']/node()"/></b>
					</xsl:when>
					</xsl:choose>
				</xsl:when>
				<xsl:when test="/InfoCom/EMPRESA/CONDICIONES/PEDIDO_MINIMO_GENERAL">
					<xsl:choose>
					<xsl:when test="/InfoCom/EMPRESA/CONDICIONES/PEDIDO_MINIMO_GENERAL/EMP_PEDMINIMO_ACTIVO='N'">
						<b><xsl:value-of select="document($doc)/translation/texts/item[@name='no_activo']/node()"/></b>
					</xsl:when>
					<xsl:when test="/InfoCom/EMPRESA/CONDICIONES/PEDIDO_MINIMO_GENERAL/EMP_PEDMINIMO_ACTIVO='S'">
						<b><xsl:value-of select="document($doc)/translation/texts/item[@name='activo']/node()"/></b>
					</xsl:when>
					<xsl:when test="/InfoCom/EMPRESA/CONDICIONES/PEDIDO_MINIMO_GENERAL/EMP_PEDMINIMO_ACTIVO='E'">
						<b><xsl:value-of select="document($doc)/translation/texts/item[@name='estricto']/node()"/></b>
					</xsl:when>
					<xsl:when test="/InfoCom/EMPRESA/CONDICIONES/PEDIDOMINIMO/EMPRESA/EMP_PEDMINIMO_ACTIVO='I'">
						<b><xsl:value-of select="document($doc)/translation/texts/item[@name='integrado']/node()"/></b>
					</xsl:when>
					</xsl:choose>
				</xsl:when>
				</xsl:choose>
				</td>
				<td>
				<xsl:choose>
				<xsl:when test="/InfoCom/EMPRESA/CONDICIONES/PEDIDOMINIMO/EMPRESA">
					<xsl:value-of select="/InfoCom/EMPRESA/CONDICIONES/PEDIDOMINIMO/EMPRESA/PME_PEDMINIMO_IMPORTE"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='eur']/node()"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='s_iva']/node()"/>
				</xsl:when>
				<xsl:when test="/InfoCom/EMPRESA/CONDICIONES/PEDIDO_MINIMO_GENERAL">
					<xsl:value-of select="/InfoCom/EMPRESA/CONDICIONES/PEDIDO_MINIMO_GENERAL/EMP_PEDMINIMO_IMPORTE"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='eur']/node()"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='s_iva']/node()"/>
				</xsl:when>
				</xsl:choose>
				</td>
				<td>
				<xsl:choose>
				<xsl:when test="/InfoCom/EMPRESA/CONDICIONES/PEDIDOMINIMO/EMPRESA">
					<xsl:copy-of select="/InfoCom/EMPRESA/CONDICIONES/PEDIDOMINIMO/EMPRESA/PME_PEDMINIMO_DETALLE"/>
				</xsl:when>
				<xsl:when test="/InfoCom/EMPRESA/CONDICIONES/PEDIDO_MINIMO_GENERAL">
					<xsl:copy-of select="/InfoCom/EMPRESA/CONDICIONES/PEDIDO_MINIMO_GENERAL/EMP_PEDMINIMO_DETALLE"/>
				</xsl:when>
				</xsl:choose>
				</td>
			</tr>
		</tbody>

      <tr><td colspan="2">&nbsp;</td></tr>
      <tr><td colspan="2">&nbsp;</td></tr>
		</table>
	</xsl:when>
  <xsl:otherwise>
    <table class="infoTable"  style="border-right:1px solid #666;border-left:1px solid #666;">
    <thead>
      <tr class="subTituloTabla">
        <td colspan="2"><xsl:value-of select="document($doc)/translation/texts/item[@name='pedido_minimo']/node()"/></td>
      </tr>
    </thead>

    <tbody>
      <tr>
				<td class="labelRight veinte">
          <xsl:value-of select="document($doc)/translation/texts/item[@name='importe']/node()"/>:
				</td>
        <td class="datosLeft">
					<b>
            <xsl:choose>
						<xsl:when test="/InfoCom/EMPRESA/CONDICIONES/PEDIDOMINIMO/EMPRESA">
							<xsl:value-of select="/InfoCom/EMPRESA/CONDICIONES/PEDIDOMINIMO/EMPRESA/PME_PEDMINIMO_IMPORTE"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='eur']/node()"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='s_iva']/node()"/>
						</xsl:when>
						<xsl:when test="/InfoCom/EMPRESA/CONDICIONES/PEDIDO_MINIMO_GENERAL">
							<xsl:value-of select="/InfoCom/EMPRESA/CONDICIONES/PEDIDO_MINIMO_GENERAL/EMP_PEDMINIMO_IMPORTE"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='eur']/node()"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='s_iva']/node()"/>
						</xsl:when>
						</xsl:choose>
          </b>
				</td>
      </tr>

      <tr>
				<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='tipo']/node()"/>:</td>
                <td class="datosLeft">
				<xsl:choose>
				<xsl:when test="/InfoCom/EMPRESA/CONDICIONES/PEDIDOMINIMO/EMPRESA">
					<xsl:choose>
					<xsl:when test="/InfoCom/EMPRESA/CONDICIONES/PEDIDOMINIMO/EMPRESA/PME_PEDMINIMO_ACTIVO='N'">
						<b><xsl:value-of select="document($doc)/translation/texts/item[@name='no_activo']/node()"/></b>
					</xsl:when>
					<xsl:when test="/InfoCom/EMPRESA/CONDICIONES/PEDIDOMINIMO/EMPRESA/PME_PEDMINIMO_ACTIVO='S'">
						<b><xsl:value-of select="document($doc)/translation/texts/item[@name='activo']/node()"/></b>
					</xsl:when>
					<xsl:when test="/InfoCom/EMPRESA/CONDICIONES/PEDIDOMINIMO/EMPRESA/PME_PEDMINIMO_ACTIVO='E'">
						<b><xsl:value-of select="document($doc)/translation/texts/item[@name='estricto']/node()"/></b>
					</xsl:when>
					<xsl:when test="/InfoCom/EMPRESA/CONDICIONES/PEDIDOMINIMO/EMPRESA/PME_PEDMINIMO_ACTIVO='I'">
						<b><xsl:value-of select="document($doc)/translation/texts/item[@name='integrado']/node()"/></b>
					</xsl:when>
					</xsl:choose>
				</xsl:when>
				<xsl:when test="/InfoCom/EMPRESA/CONDICIONES/PEDIDO_MINIMO_GENERAL">
					<xsl:choose>
					<xsl:when test="/InfoCom/EMPRESA/CONDICIONES/PEDIDO_MINIMO_GENERAL/EMP_PEDMINIMO_ACTIVO='N'">
						<b><xsl:value-of select="document($doc)/translation/texts/item[@name='no_activo']/node()"/></b>
					</xsl:when>
					<xsl:when test="/InfoCom/EMPRESA/CONDICIONES/PEDIDO_MINIMO_GENERAL/EMP_PEDMINIMO_ACTIVO='S'">
						<b><xsl:value-of select="document($doc)/translation/texts/item[@name='activo']/node()"/></b>
					</xsl:when>
					<xsl:when test="/InfoCom/EMPRESA/CONDICIONES/PEDIDO_MINIMO_GENERAL/EMP_PEDMINIMO_ACTIVO='E'">
						<b><xsl:value-of select="document($doc)/translation/texts/item[@name='estricto']/node()"/></b>
					</xsl:when>
					<xsl:when test="/InfoCom/EMPRESA/CONDICIONES/PEDIDOMINIMO/EMPRESA/EMP_PEDMINIMO_ACTIVO='I'">
						<b><xsl:value-of select="document($doc)/translation/texts/item[@name='integrado']/node()"/></b>
					</xsl:when>
					</xsl:choose>
				</xsl:when>
				</xsl:choose>
				</td>
      </tr>

    <xsl:if test="/InfoCom/EMPRESA/CONDICIONES/PEDIDOMINIMO/EMPRESA/PME_PEDMINIMO_DETALLE != '' or /InfoCom/EMPRESA/CONDICIONES/PEDIDO_MINIMO_GENERAL/EMP_PEDMINIMO_DETALLE != ''">
      <tr>
		<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='descripcion']/node()"/>:</td>
        <td class="datosLeft">
					<xsl:choose>
					<xsl:when test="/InfoCom/EMPRESA/CONDICIONES/PEDIDOMINIMO/EMPRESA">
						<xsl:copy-of select="/InfoCom/EMPRESA/CONDICIONES/PEDIDOMINIMO/EMPRESA/PME_PEDMINIMO_DETALLE"/>
					</xsl:when>
					<xsl:when test="/InfoCom/EMPRESA/CONDICIONES/PEDIDO_MINIMO_GENERAL">
						<xsl:copy-of select="/InfoCom/EMPRESA/CONDICIONES/PEDIDO_MINIMO_GENERAL/EMP_PEDMINIMO_DETALLE"/>
					</xsl:when>
					</xsl:choose>
				</td>
			</tr>
    </xsl:if>
    </tbody>

      <tr><td colspan="2">&nbsp;</td></tr>
      <tr><td colspan="2">&nbsp;</td></tr>
    </table>
  </xsl:otherwise>
  </xsl:choose>
</xsl:template><!--fin de pedido minimo-->
</xsl:stylesheet>
