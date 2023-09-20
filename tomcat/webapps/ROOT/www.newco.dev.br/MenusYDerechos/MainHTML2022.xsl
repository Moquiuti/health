<?xml version="1.0" encoding="iso-8859-1"?>
<!--
	Página principal de medicalvm.com, version 2022
	Última revisión: ET 2ago23 11:10
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

<!--	Todos los documentos HTML deben empezar con esto	-->
<xsl:text disable-output-escaping='yes'>&lt;!doctype html></xsl:text>

<html>
<head>
	<style>

		iframe {
			display: block;
			position: fixed; /*	14nov22 Esta propiedad oculta las barras de desplazamiento naturales, forzamos barra de desplazamiento*/
			left: 0;
			border: none;
			width: 100%;
		}

		#topFrame {
		top: 0;
		height: 110px;
		}

		#mainFrame {
		top: 111px;
		height: 100%;
		overflow: auto;
		}

	</style>

	<script type="text/javascript">
		var lang='<xsl:value-of select="/Main/USUARIO/LANG"/>';
		var style='basicMVM2022.css';	//'<xsl:value-of select="/Main/USUARIO/STYLE"/>';
		var accion='<xsl:value-of select="/Main/USUARIO/ACCION"/>';
		var v_Dominio='http://www.newco.dev.br/';
		var idsesionpar='<xsl:value-of select="/Main/PARSES"/>';		//12dic22 SES_ID pasado por parametro
		
		function Inicio()
		{
			//	Cambiamos el enlace en la pagina principal
			history.replaceState({}, '', '/');
			
			
			//solodebug	
			console.log('Inicio lang:'+lang+' idses:'+idsesionpar)
		
			if (idsesionpar!='')
			{
				//solodebug	alert('Inicio lang:'+lang+' idses:'+idsesionpar);
				SetCookie('SES_ID', idsesionpar);
			}

			SetCookie('STYLE', style);
			SetCookie('LANG', lang);
		}

		// Creacion de una cookie con nombre sName y valor sValue
		function SetCookie(sName, sValue)
		{ 
			//solodebug 	console.log('SetCookie name:'+sName+' value:'+sValue+';SameSite=Strict;');

			document.cookie = sName + "=" + escape(sValue) + ";host="+v_Dominio+";path=/;SameSite=Strict;";	
		}

        //solodebug console.log("JS MainHTML INICIO. accion:"+accion);
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
	</body>
</xsl:when>
<!--
	|
	| Acceso correcto.
	|
+-->
<xsl:otherwise>
	<body onLoad="Inicio();">
		<iframe id="topFrame"  name="topFrame" scrolling="NO" noresize="noresize">
			<xsl:choose>
			<xsl:when test="/Main/PARSES!=''">
				<xsl:attribute name="src">http://www.newco.dev.br/MenusYDerechos/Cabecera2022.xsql?SES_ID=<xsl:value-of select="/Main/PARSES"/>&amp;LANG=<xsl:value-of select="Main/USUARIO/LANG"/>&amp;STYLE=basicMVM2022.css<!--<xsl:value-of select="Main/USUARIO/STYLE"/>-->&amp;ACCION=<xsl:value-of select="Main/USUARIO/ACCION"/></xsl:attribute>
			</xsl:when>
			<xsl:otherwise>
				<xsl:attribute name="src">http://www.newco.dev.br/MenusYDerechos/Cabecera2022.xsql?SES_ID=<xsl:value-of select="Main/USUARIO/SES_ID"/>&amp;LANG=<xsl:value-of select="Main/USUARIO/LANG"/>&amp;STYLE=basicMVM2022.css<!--<xsl:value-of select="Main/USUARIO/STYLE"/>-->&amp;ACCION=<xsl:value-of select="Main/USUARIO/ACCION"/></xsl:attribute>
			</xsl:otherwise> 
			</xsl:choose>
		</iframe>
		<iframe id="mainFrame" name="mainFrame"  scrolling="auto" height="auto"><!--noresize="noresize"-->
		<xsl:attribute name="src">
		<xsl:choose>
		<xsl:when test="Main/USUARIO/ACCION='NUEVOPEDIDO'">http://www.newco.dev.br/General/CargaPagina.html?TARGET=http://www.newco.dev.br/Compras/NuevaMultioferta/PedidoDesdeCatalogo2022.xsql?LANG=<xsl:value-of select="Main/USUARIO/LANG"/>&amp;STYLE=basicMVM2022.css<!--<xsl:value-of select="Main/USUARIO/STYLE"/>-->&amp;HOJADEGASTOS=<xsl:value-of select="Main/HOJADEGASTOS"/>&amp;NUMCEDULA=<xsl:value-of select="Main/NUMCEDULA"/>&amp;NOMBREPACIENTE=<xsl:value-of select="Main/NOMBREPACIENTE"/>&amp;HABITACION=<xsl:value-of select="Main/HABITACION"/></xsl:when>
		<xsl:when test="Main/USUARIO/ACCION='EIS'">http://www.newco.dev.br/General/CargaPagina.html?TARGET=http://www.newco.dev.br/Gestion/EIS/EISConsultas2022.xsql?LANG=<xsl:value-of select="Main/USUARIO/LANG"/>&amp;STYLE=basicMVM2022.css<!--<xsl:value-of select="Main/USUARIO/STYLE"/>--></xsl:when>
		<xsl:otherwise>
			<xsl:choose>
			<xsl:when test="/Main/PARSES!=''">
				http://www.newco.dev.br/General/CargaPagina.html?TARGET=http://www.newco.dev.br/Personal/BandejaTrabajo/WFStatus2022.xsql?SES_ID=<xsl:value-of select="/Main/PARSES"/>&amp;LANG=<xsl:value-of select="Main/USUARIO/LANG"/>&amp;STYLE=basicMVM2022.css
				<!--<xsl:value-of select="Main/USUARIO/STYLE"/>-->
			</xsl:when>
			<xsl:otherwise>
				http://www.newco.dev.br/General/CargaPagina.html?TARGET=http://www.newco.dev.br/Personal/BandejaTrabajo/WFStatus2022.xsql?SES_ID=<xsl:value-of select="Main/USUARIO/SES_ID"/>&amp;LANG=<xsl:value-of select="Main/USUARIO/LANG"/>&amp;STYLE=basicMVM2022.css
				<!--<xsl:value-of select="Main/USUARIO/STYLE"/>-->
			</xsl:otherwise> 
			</xsl:choose>
		</xsl:otherwise>
		</xsl:choose>
		</xsl:attribute>
		</iframe>
	</body>
</xsl:otherwise>
</xsl:choose>
</html>
</xsl:template>
</xsl:stylesheet>
