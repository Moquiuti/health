<?xml version="1.0" encoding="iso-8859-1"?>
<!--23abr09	Esta página daba problemas en los nuevos navegadores al utilizar refresh.
			Probamos a montarlo con document.location.
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

	<META Http-Equiv="Cache-Control" Content="no-cache" />

	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>

	<xsl:text disable-output-escaping="yes">
	<![CDATA[
		<script type="text/javascript">
		<!--
			function tienePadre(){
	]]>
	</xsl:text>
				var refrescar='<xsl:value-of select="/Multioferta/REFRESCAR_PADRE"/>';
	<xsl:text disable-output-escaping="yes">
	<![CDATA[
				if(top.name=='Multioferta'|| refrescar=='S'){
					top.opener.AplicarFiltro();
					window.close();
					return false;
				}else{
					window.close();
					return true;
				}
			}

			function CerrarVentana(){
				if(tienePadre()){
					//parent.mainFrame.location.href='<xsl:value-of select="$link"/>?ROL=<xsl:value-of select="//ROL"/>&amp;TIPO=<xsl:value-of select="//TIPO"/>';
					null;
				}
			}

			function GenerarIncidencia(abrirVentana, nombreVentanaNueva){
	]]>
	</xsl:text>
				var mo_id='<xsl:value-of select="Multioferta/MO_ID"/>';
				var rol='<xsl:value-of select="//ROL"/>';
				var tipo='<xsl:value-of select="//TIPO"/>';
				var mo_status='<xsl:value-of select="Multioferta/Status/MO_STATUS"/>';
				var datosActuales='<xsl:value-of select="//DATOSACTUALES"/>';
	<xsl:text disable-output-escaping="yes">
	<![CDATA[ 
				//document.location.href='http://www.newco.dev.br/Compras/Multioferta/MultiofertaFrame.xsql?MO_ID='+mo_id+'&ROL='+rol+'&TIPO='+tipo+'&xml-stylesheet=MultiofertaFrame-'+mo_status+'-HTML.xsl&DATOSACTUALES='+datosActuales+'&ORIGEN=MultiofertaSaveHTML.xsl_1'; comentado 2-4-14 para actualizar mof new
                
                document.location.href='http://www.newco.dev.br/Compras/Multioferta/MultiofertaFrame.xsql?MO_ID='+mo_id;
				MostrarPag(abrirVentana, nombreVentanaNueva);
			}

			function Evento_OnLoad(){
				var Incidencia=document.getElementById('SALTA_INC_ID').value;
				var URL=document.getElementById('URL').value;

				if (Incidencia!=''){
					GenerarIncidencia('http://www.newco.dev.br/Compras/Incidencias/Incidencia.xsql?INC_ID='+Incidencia+'&amp;RELOAD=N','Incidencia');
				}else if(URL!=''){
					document.location.href=URL;
				}
				// Refrescamos la ventana padre para impedir errores de doble pulsacion en estado 13
				//Refresh(top.opener.document);
			}
		//-->
		</script>
	]]>
	</xsl:text>
<!--
	|	Lo hacemos saltar a la pagina de multiofertaframe correspondiente
+-->
	<xsl:choose>
	<xsl:when test="Multioferta/SESION_CADUCADA">
		<input type="hidden" id="URL" value="CADUCADA"/>
		<input type="hidden" id="SALTA_INC_ID" value="CADUCADA"/>
		<xsl:apply-templates select="Multioferta/SESION_CADUCADA"/>
	</xsl:when>
	<xsl:when test="Multioferta/Status/SALTA">
		<input type="hidden" id="URL" value="http://www.newco.dev.br/Compras/Multioferta/MultiofertaFrame.xsql?MO_ID={Multioferta/Status/MO_ID}"/>
		<input type="hidden" id="SALTA_INC_ID"/>
	</xsl:when>
	<xsl:when test="Multioferta/Status/SALTA_INCIDENCIAS">
		<input type="hidden" id="URL" value="INCIDENCIA"/>
		<input type="hidden" id="SALTA_INC_ID" value="{Multioferta/Status/INC_ID}"/>
	</xsl:when>
	<xsl:when test="Multioferta/Status/SALTA_ACTUALIZAR">
		<input type="hidden" id="URL" value="http://www.newco.dev.br/Compras/Multioferta/MultiofertaForm.html"/>
		<input type="hidden" id="SALTA_INC_ID"/>
	</xsl:when>
	<xsl:otherwise>
		<input type="hidden" id="URL"/>
		<input type="hidden" id="SALTA_INC_ID"/>
	</xsl:otherwise>
	</xsl:choose>
</head>
<body bgcolor="#FFFFFF" onload="javascript:Evento_OnLoad();" onbeforeunload="javascript:CerrarVentana();">
	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:choose>
		<xsl:when test="/Multioferta/LANG"><xsl:value-of select="/Multioferta/LANG"/></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<xsl:choose>
	<xsl:when test="Multioferta/xsql-error">
		<xsl:apply-templates select="Multioferta/xsql-error"/>
	</xsl:when>
	<xsl:otherwise>
		<!-- solo mostramos el boton imprimir en los estados de aceptacion pedido / abono que ha sido aceptado -->
		<xsl:variable name="vBotonImprimir">
			<xsl:choose>
			<xsl:when test="//Multioferta/BOTON='CONFIRMAR'">
				<xsl:choose>
				<xsl:when test="//Multioferta/MO_STATUS='11' or //Multioferta/MO_STATUS='14'">IMPRIMIR</xsl:when>
				<xsl:otherwise>NO_IMPRIMIR</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			</xsl:choose>
		</xsl:variable>

		<!--multioferta template status -->
		<xsl:apply-templates select="Multioferta/Status">
			<xsl:with-param name="botonImprimir" select="$vBotonImprimir"/>
		</xsl:apply-templates>
	</xsl:otherwise>
	</xsl:choose>
</body>
</html>
</xsl:template>

<!-- No usamos el standard, anyadimos cosas al link!! -->
<xsl:template match="JUMPTO_DBERROR">
	<xsl:variable name="code-img-on">DB-<xsl:value-of select="picture-on"/></xsl:variable>
	<xsl:variable name="code-img-off">DB-<xsl:value-of select="picture-off"/></xsl:variable>
	<xsl:variable name="code-link"><xsl:value-of select="page"/></xsl:variable>
	<xsl:variable name="code-name"><xsl:value-of select="caption"/></xsl:variable>
	<xsl:variable name="draw-on"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id=$code-img-on]" disable-output-escaping="yes"/></xsl:variable>
	<xsl:variable name="draw-off"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id=$code-img-off]" disable-output-escaping="yes"/></xsl:variable>
	<xsl:variable name="link"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id=$code-link]" disable-output-escaping="yes"/></xsl:variable>
	<xsl:variable name="code-status"><xsl:value-of select="status"/></xsl:variable>
	<xsl:variable name="status">
		<xsl:choose>
		<xsl:when test="status">
			<xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id=$code-status]" disable-output-escaping="yes"/>
		</xsl:when>
		<xsl:otherwise>
			<xsl:variable name="caption"><xsl:value-of select="caption"/></xsl:variable><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id=$caption]" disable-output-escaping="yes"/>
		</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="code-alt"><xsl:value-of select="alt"/></xsl:variable>
	<xsl:variable name="alt">
		<xsl:choose>
		<xsl:when test="alt">
			<xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id=$code-alt]" disable-output-escaping="yes"/>
		</xsl:when>
		<xsl:otherwise>
			<xsl:variable name="caption"><xsl:value-of select="caption"/></xsl:variable><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id=$caption]" disable-output-escaping="yes"/>
		</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>

	<a>
		<xsl:attribute name="href"><xsl:value-of select="$link"/>?ROL=<xsl:value-of select="//ROL"/>&amp;TIPO=<xsl:value-of select="//TIPO"/></xsl:attribute>
		<xsl:attribute name="onMouseOver">cambiaImagen('<xsl:value-of select="picture-off"/>','<xsl:value-of select="$draw-on"/>');window.status='<xsl:value-of select="$status"/>';return true</xsl:attribute>
		<xsl:attribute name="onMouseOut">cambiaImagen('<xsl:value-of select="picture-off"/>','<xsl:value-of select="$draw-off"/>');window.status='';return true</xsl:attribute>
		<img name="{picture-off}" alt="{$alt}" src="{$draw-off}" border="0"/>
	</a>
	<br/>
	<xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id=$code-name]" disable-output-escaping="yes"/>
</xsl:template>

<xsl:template match="JUMPTO_OK">
	<xsl:variable name="code-img-on">DB-<xsl:value-of select="picture-on"/></xsl:variable>
	<xsl:variable name="code-img-off">DB-<xsl:value-of select="picture-off"/></xsl:variable>
	<xsl:variable name="code-link"><xsl:value-of select="page"/></xsl:variable>
	<xsl:variable name="code-name"><xsl:value-of select="caption"/></xsl:variable>
	<xsl:variable name="draw-on"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id=$code-img-on]" disable-output-escaping="yes"/></xsl:variable>
	<xsl:variable name="draw-off"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id=$code-img-off]" disable-output-escaping="yes"/></xsl:variable>
	<xsl:variable name="link"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id=$code-link]" disable-output-escaping="yes"/></xsl:variable>
	<xsl:variable name="code-status"><xsl:value-of select="status"/></xsl:variable>
	<xsl:variable name="status">
		<xsl:choose>
		<xsl:when test="status">
			<xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id=$code-status]" disable-output-escaping="yes"/>
		</xsl:when>
		<xsl:otherwise>
			<xsl:variable name="caption"><xsl:value-of select="caption"/></xsl:variable><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id=$caption]" disable-output-escaping="yes"/>
		</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="code-alt"><xsl:value-of select="alt"/></xsl:variable>
	<xsl:variable name="alt">
		<xsl:choose>
		<xsl:when test="alt">
			<xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id=$code-alt]" disable-output-escaping="yes"/>
		</xsl:when>
		<xsl:otherwise>
			<xsl:variable name="caption"><xsl:value-of select="caption"/></xsl:variable><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id=$caption]" disable-output-escaping="yes"/>
		</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>

	<a class="btnDestacado">
		<xsl:attribute name="href">javascript:CerrarVentana();</xsl:attribute>
		<xsl:attribute name="onMouseOver">cambiaImagen('<xsl:value-of select="picture-off"/>','<xsl:value-of select="$draw-on"/>');window.status='<xsl:value-of select="$status"/>';return true</xsl:attribute>
		<xsl:attribute name="onMouseOut">cambiaImagen('<xsl:value-of select="picture-off"/>','<xsl:value-of select="$draw-off"/>');window.status='';return true</xsl:attribute>
		<img name="{picture-off}" alt="{$alt}" src="{$draw-off}" border="0"/>
	</a>
	<br/>
	<xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id=$code-name]" disable-output-escaping="yes"/>
</xsl:template>
</xsl:stylesheet>
