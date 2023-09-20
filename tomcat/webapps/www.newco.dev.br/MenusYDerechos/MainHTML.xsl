<?xml version="1.0" encoding="iso-8859-1"?>
<!--
	Página principal de medicalvm.com
	Última revisión: ET 20jul20 11:22
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:import href="http://www.newco.dev.br/General/General.xsl"/>
	<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>

	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:choose>
		<xsl:when test="/Main/USUARIO/LANG != ''">
			<xsl:value-of select="/Main/USUARIO/LANG"/>
		</xsl:when>
		<xsl:when test="/Main/USUARIO/LANG != ''">
			<xsl:value-of select="/Main/USUARIO/LANG"/>
		</xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>   
	<xsl:value-of select="$lang"/>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

<xsl:template match="/">     
<html>
<head>
	<script type="text/javascript">
		var lang='<xsl:value-of select="/Main/USUARIO/LANG"/>';
		var style='<xsl:value-of select="/Main/USUARIO/STYLE"/>';
		var accion='<xsl:value-of select="/Main/USUARIO/ACCION"/>';
		var v_Dominio='http://www.newco.dev.br/';
		
		function setCookieStyle()
		{
			SetCookie('STYLE', style);
			SetCookie('LANG', lang);
		}

		// Creacion de una cookie con nombre sName y valor sValue
		function SetCookie(sName, sValue)
		{ 
			//solodebug 	console.log('SetCookie name:'+sName+' value:'+sValue+';sameSite=Lax');

			document.cookie = sName + "=" + escape(sValue) + ";host="+v_Dominio+";path=/;sameSite=Lax";	
		}


		//4ene19 Si no está informado el idioma (del usuario), salta a la página de login
		if (lang=='') 
		{
			window.location=location.protocol+'//'+document.domain;
		}
		
        //solodebug
        console.log("JS MainHTML INICIO. accion:"+accion);
	</script>

	<!--<title><xsl:value-of select="document($doc)/translation/texts/item[@name='main_title']/node()"/></title>-->
	<title><xsl:value-of select="/Main/USUARIO/CENTRO"/>&nbsp;:&nbsp;<xsl:value-of select="/Main/USUARIO/NOMBRECOMPLETO"/></title>

 	<!--style-->
	<!--<xsl:call-template name="estiloIndip"/> -->
	

</head> 
<xsl:choose>
<xsl:when test="Main/xsql-error">
	<body onLoad="resizeTo(800, 500);moveTo(200,200);"> 
		<xsl:apply-templates select="//xsql-error"/>
	</body>
</xsl:when>
<!--
	|
	| Mostramos el mensaje de acceso
	|
+-->
<xsl:when test="Main/USUARIO/MENSAJE_ACCESO">
	<body onLoad="resizeTo(800, 500);moveTo(200,200);">
		<xsl:variable name="msgacc"><xsl:value-of select="Main/USUARIO/MENSAJE_ACCESO"/></xsl:variable>
		<div id="mensaje_acceso" style="position:absolute; visibility:hidden;z-index:1">
			<p class="tituloForm"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id=$msgacc and @lang=$lang]" disable-output-escaping="yes"/></p>
<!--
	Acceso Correcto con cookies.
+-->
			<xsl:choose>
			<xsl:when test="Main/USUARIO/ACCESO">
				<xsl:variable name="code-img-on">DB-Siguiente</xsl:variable>
				<xsl:variable name="code-img-off">DB-Siguiente_mov</xsl:variable>
				<xsl:variable name="code-link">G-0010</xsl:variable>
				<xsl:variable name="code-status">G-0005</xsl:variable>
				<xsl:variable name="status">
					<xsl:choose>
					<xsl:when test="status">
						<xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id=$code-status]" disable-output-escaping="yes"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:variable name="caption"><xsl:value-of select="caption"/></xsl:variable>
						<xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id=$caption]" disable-output-escaping="yes"/>
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
						<xsl:variable name="caption"><xsl:value-of select="caption"/></xsl:variable>
						<xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id=$caption]" disable-output-escaping="yes"/>
					</xsl:otherwise>
					</xsl:choose>
				</xsl:variable>

				<center>
					<!-- Relanzamos el acceso con la cookie ya guardada -->
					<a>
						<xsl:attribute name="href">http://www.newco.dev.br/MenusYDerechos/Main.xsql?PARAMETRO=<xsl:value-of select="Main/request/parameters/PARAMETRO"/></xsl:attribute>
						<xsl:attribute name="onMouseOver">cambiaImagen('Siguiente','<xsl:value-of select="$draw-on"/>');window.status='<xsl:value-of select="$status"/>';return true</xsl:attribute>
						<xsl:attribute name="onMouseOut">cambiaImagen('Siguiente','<xsl:value-of select="$draw-off"/>');window.status='';return true</xsl:attribute>
						<img name="Siguiente" alt="{$alt}" src="{$draw-off}" border="0"/>
					</a>
					<br/>
					<xsl:variable name="caption">G-0005</xsl:variable><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id=$caption]" disable-output-escaping="yes"/>
				</center>
			</xsl:when>
			<!--  Acceso con cookies, cookie erronea (Intruso) -->
			<xsl:otherwise>
				<form name="mensaje_acceso" action="http://www.newco.dev.br/General/GError.xsql" method="POST">
				<input type="hidden" name="ERR_TABLA" value="Main.AccesoCookiesErroneo"/>
				<input type="hidden" name="ERR_JUMPTO" value="G-0011"/>

					<div class="tituloCamp">
						<p><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='G-1090' and @lang=$lang]" disable-output-escaping="yes"/></p>
						<textarea name="ERR_DATO3" cols="40" rows="5"/>
					</div>
					<a>
						<xsl:attribute name="href">javascript:SubmitForm(document.mensaje_acceso);</xsl:attribute>Enviar
					</a>
					<br/><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='IMG-0100']" disable-output-escaping="yes"/>

					<xsl:apply-templates select="//jumpTo"/>
				</form>
			</xsl:otherwise> 
			</xsl:choose>
		</div>
	</body>
</xsl:when>
<!--
	|
	| Error en usuario o clave. 
	|
+-->
<xsl:when test="Main/Status">
	<body onLoad="resizeTo(800, 350);moveTo(200,200);">
		<input type="hidden" name="ERR_DATO2" value="{Main/request/parameters/USER}"/>
		<input type="hidden" name="ERR_DATO3" value="{Main/request/parameters/PASS}"/>

		<xsl:apply-templates select="Main/Status"/>
		<!--<xsl:call-template name="errorLogin"/>-->
	</body>
</xsl:when>
<!--
	|
	| Acceso correcto.
	|
+-->
<xsl:otherwise>
	<frameset rows="80,*" frameborder="NO" border="0" framespacing="0" onload="javascript:setCookieStyle();">
		<frame src="UntitledFrame-1" name="topFrame" scrolling="NO" noresize="noresize">
			<xsl:attribute name="src">http://www.newco.dev.br/MenusYDerechos/Cabecera.xsql?SES_ID=<xsl:value-of select="Main/USUARIO/SES_ID"/>&amp;LANG=<xsl:value-of select="Main/USUARIO/LANG"/>&amp;STYLE=<xsl:value-of select="Main/USUARIO/STYLE"/>&amp;ACCION=<xsl:value-of select="Main/USUARIO/ACCION"/></xsl:attribute>
		</frame>
		<frame name="mainFrame" noresize="noresize" scrolling="auto" >
		<xsl:attribute name="src">
		<xsl:choose>
		<xsl:when test="Main/USUARIO/ACCION='NUEVOPEDIDO'">http://www.newco.dev.br/Compras/NuevaMultioferta/PedidoDesdeCatalogo.xsql?LANG=<xsl:value-of select="Main/USUARIO/LANG"/>&amp;STYLE=<xsl:value-of select="Main/USUARIO/STYLE"/>&amp;HOJADEGASTOS=<xsl:value-of select="Main/HOJADEGASTOS"/>&amp;NUMCEDULA=<xsl:value-of select="Main/NUMCEDULA"/>&amp;NOMBREPACIENTE=<xsl:value-of select="Main/NOMBREPACIENTE"/>&amp;HABITACION=<xsl:value-of select="Main/HABITACION"/></xsl:when>
		<xsl:when test="Main/USUARIO/ACCION='EIS'">http://www.newco.dev.br/Gestion/EIS/EISConsultas.xsql?LANG=<xsl:value-of select="Main/USUARIO/LANG"/>&amp;STYLE=<xsl:value-of select="Main/USUARIO/STYLE"/></xsl:when>
		<!--<xsl:when test="Main/ACCION='NUEVOPEDIDO'">http://www.newco.dev.br/Compras/NuevaMultioferta/Unica.html?LANG=<xsl:value-of select="Main/USUARIO/LANG"/>&amp;STYLE=<xsl:value-of select="Main/USUARIO/STYLE"/>&amp;HOJADEGASTOS=<xsl:value-of select="Main/HOJADEGASTOS"/>&amp;NUMCEDULA=<xsl:value-of select="Main/NUMCEDULA"/>&amp;NOMBREPACIENTE=<xsl:value-of select="Main/NOMBREPACIENTE"/>&amp;HABITACION=<xsl:value-of select="Main/HABITACION"/></xsl:when>-->
		<xsl:otherwise>http://www.newco.dev.br/<xsl:value-of select="Main/USUARIO/URL_INICIO"/>?LANG=<xsl:value-of select="Main/USUARIO/LANG"/>&amp;STYLE=<xsl:value-of select="Main/USUARIO/STYLE"/></xsl:otherwise> 
		</xsl:choose>
		</xsl:attribute>
		</frame>
	</frameset>
	<xsl:apply-templates select="Main/USUARIO"/>
</xsl:otherwise>
</xsl:choose>
</html>
</xsl:template>

<!-- TEMPLATES --><!-- TEMPLATES --><!-- TEMPLATES --><!-- TEMPLATES --><!-- TEMPLATES -->

<xsl:template name="errorLogin">
	<!-- <table width="90%">
		<tr>
			<td>
				<xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='G-1030' and @lang=$lang]" disable-output-escaping="yes"/>
				<br/>
				<xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='G-1031' and @lang=$lang]" disable-output-escaping="yes"/>
			</td>
		</tr>
	</table>-->
</xsl:template>

<xsl:template match="USUARIO">
	Nombre: <xsl:value-of select="US_NOMBRE"/><br/>
	Código: <xsl:value-of select="SES_ID"/><br/>
</xsl:template>

<xsl:template match="AUTORIZADO">
	<a>
		<xsl:attribute name="href">USDERManten.xsql?LANG=<xsl:value-of select="$lang"/>&amp;US_ID=<xsl:value-of select="../IDUSUARIO"/>&amp;IDMENU=<xsl:value-of select="../IDMENU"/></xsl:attribute>
		<xsl:value-of select="."/>
	</a>
</xsl:template>
</xsl:stylesheet>
