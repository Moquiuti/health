<?xml version="1.0" encoding="iso-8859-1"?>
<!--Área pública de MedicalVM - Mensaje General - Noticias-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:import href="http://www.newco.dev.br/General/General.xsl"/>
	<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
	<xsl:param name="usuario" select="@US_ID"/>
<xsl:template match="/">
<html>
<head>
	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:choose>
		<xsl:when test="/AreaPublica/LANG"><xsl:value-of select="/AreaPublica/LANG" /></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<title>
		<xsl:value-of select="document($doc)/translation/texts/item[@name='central_compras_material_sanitario']/node()"/>&nbsp;-&nbsp;
		<xsl:value-of select="document($doc)/translation/texts/item[@name='contacto']/node()"/>&nbsp;-&nbsp;
		<xsl:value-of select="document($doc)/translation/texts/item[@name='medicalvm']/node()"/>
	</title>

	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1"/>
	<META HTTP-EQUIV="Pragma" CONTENT="no-caché"/>
	<META HTTP-EQUIV="expired" CONTENT="01-Mar-94 00:00:01 GMT"/>
	<meta content="ALL" name="ROBOTS"/>
	<META name="keywords" content="central, compras, sanidad, sanitario, clínica, hospital, equipamiento, médico, farmacia, farmacéutico, 
		ASPIRADOR, BATA, BISTURI, BOLSA, BOMBA, CANULA, CATETER, CEPILLO, COMPRESA, 
		CUCHILLETE, DESFIBRILADOR, ECG, ELECTROCARDIOGRAFO, ELECTRODO, ESPECULO, ESPONJA, EXTRACTOR, FOLEY, GEL, GRAPADORA, GUANTE, INFUSION, 
		JABON, JERINGUILLA, LIPOSUCTOR, LOGO, LUER, LUMEN, LUZ, MASCARILLA, MESA, MONITOR, MONOFILAMENTO, NASAL, NYLON, OMNIPOR, PAPEL, PARCHE, 
		PERLADO, PILAS, PINZA, PROTESIS, RECOLECTOR, SILICONA, SONDA, SUTURA, TERMOMETRO"/>
	<META name="description" content="Medical Virtual Market es la mayor central de compras virtual para las empresas del sector sanitario español."/>

	<link rel="shortcut icon" href="http://www.newco.dev.br/images/MedicalVM.ico"/>


	<link rel="stylesheet" href="http://www.newco.dev.br/General/basicPublic.css" type="text/css"/>
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>	
	<script type="text/javascript" src="http://www.newco.dev.br/General/loginNew_200315.js"></script>
<xsl:text disable-output-escaping="yes"><![CDATA[
	<script type="text/javascript">

		function globalEventsContact(){
			// Esconder el campo de control
			jQuery('.formControl').hide();

			AceptaCookie();
			MenuExplorerPublic();
		}

		function AceptaCookie(){
			var aceptoCookie = GetCookie('ACEPTO_COOKIE');
			if (aceptoCookie == '' || aceptoCookie == null) {
				//si no ha aceptado lo de los coockie pongo aviso
				document.getElementById("avisoCookieBox").style.display = 'block';
			}
		}
	</script>
]]></xsl:text>

<script>
(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
})(window,document,'script','//www.google-analytics.com/analytics.js','ga');

  ga('create', 'UA-64519488-3', 'auto');
  ga('send', 'pageview');

</script> 
</head>
<body onload="globalEventsContact();">
	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:choose>
		<xsl:when test="/AreaPublica/LANG"><xsl:value-of select="/AreaPublica/LANG"/></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<xsl:choose>
	<!-- Error en alguna sentencia del XSQL -->
	<xsl:when test="AreaPublica/xsql-error">
		<xsl:apply-templates select="AreaPublica/xsql-error"/>
	</xsl:when>
	<xsl:otherwise>

		<div class="avisoCookieBox" id="avisoCookieBox" style="display:none;">
			<div class='avisoCookie'>
				<xsl:copy-of select="document($doc)/translation/texts/item[@name='aviso_cookies']/node()"/>
			</div>
		</div><!--fin de avisoCookieBox-->

		<div class="todo">
			<div class="header">
                            <div class="headerInside">
				<div class="logo">
					<a href="http://www.newco.dev.br" title="Medical Virtual Market">
						<img src="http://www.newco.dev.br/images/logoMVM.gif" alt="Medical Virtual Market"/>
					</a>
				</div>
				<div class="textHeader">
					<h2><xsl:value-of select="document($doc)/translation/texts/item[@name='optimizamos_su_proceso_de_compras']/node()"/></h2>
				</div>
                            </div>
			</div><!--fin de header-->

		<xsl:call-template name="menuPublic"><!--en general.xsl-->
                    <xsl:with-param name="select">contacto</xsl:with-param>
                </xsl:call-template>

		<div class="todoInside fondoInfo">
                            
                <section class="leftInfo">
                    <br /><br />
                    <h2>MedicalVM optimiza las compras para hospitales, clínicas quirúrgicas, clínicas odontológicas, centros sociosanitarios y otras empresas de salud.</h2>
                    <ul class="triangle">
                        <li><img src="http://www.newco.dev.br/images/triangleNaraPeq.gif" />Ahorro medio en precio de producto del 20%</li>
                        <li><img src="http://www.newco.dev.br/images/triangleNaraPeq.gif" />Reducción de la carga de trabajo administrativa del 40%</li>
                        <li><img src="http://www.newco.dev.br/images/triangleNaraPeq.gif" />Reducción de incidencias del 75%</li>
                    </ul>
                    
                    <br />
                    <h2>¿Por qué confiar en MedicalVM?</h2>
                    <ul class="lista">
                        <li><img src="http://www.newco.dev.br/images/listNara.gif" /><strong>Ahorro:</strong> generamos un importante ahorro tanto en precio de producto como en costes de gestión de compras.</li>
                        <li><img src="http://www.newco.dev.br/images/listNara.gif" /><strong>Seguridad:</strong> nos adaptamos a los requisitos de calidad marcados por el cliente, el comprador tiene la decisión final en la elección de proveedores.</li>
                        <li><img src="http://www.newco.dev.br/images/listNara.gif" /><strong>Confianza:</strong> no cobramos en ningún caso de los proveedores, el nuestro es un servicio para el comprador.</li>
                        <li><img src="http://www.newco.dev.br/images/listNara.gif" /><strong>Transparencia:</strong> toda la información sobre el trabajo realizado estará continuamente disponible para el cliente a través de MedicalVM.com.</li>
                        <li><img src="http://www.newco.dev.br/images/listNara.gif" /><strong>Fuerza:</strong> aportamos nuestra fuerza de negociación para ponerla a disposición de nuestros clientes.</li>
                        <li><img src="http://www.newco.dev.br/images/listNara.gif" /><strong>Información:</strong> toda la información que se va obteniendo de los proveedores se utiliza para ayudar a cada uno de nuestros clientes en sus compras.</li>
                    </ul>
                    <br />
                    <h2>¿Que hace MedicalVM?</h2>
                    <ul class="triangle">
                        <li><img src="http://www.newco.dev.br/images/triangleNaraPeq.gif" />Analizamos y optimizamos el catálogo del cliente.</li>
                        <li><img src="http://www.newco.dev.br/images/triangleNaraPeq.gif" />Buscamos proveedores alternativos a los existentes, siguiendo los criterios del cliente en cuanto a calidad, servicio y forma de pago.</li>
                        <li><img src="http://www.newco.dev.br/images/triangleNaraPeq.gif" />Ayudamos al cliente a evaluar productos y proveedores.</li>
                        <li><img src="http://www.newco.dev.br/images/triangleNaraPeq.gif" />Llevamos a cabo todo el procedimiento de negociación con los proveedores de forma totalmente transparente.</li>
                        <li><img src="http://www.newco.dev.br/images/triangleNaraPeq.gif" />Ofrecemos al comprador un informe con las mejores alternativas, el comprador decide cual selecciona.</li>
                        <li><img src="http://www.newco.dev.br/images/triangleNaraPeq.gif" />Hacemos un seguimiento de todos los pedidos, y gestionamos sus incidencias.</li>
                        <li><img src="http://www.newco.dev.br/images/triangleNaraPeq.gif" />Proponemos mejoras en su estrategia de compras.</li>
                    </ul>
            </section><!--fin de leftInfo-->
            
            <section class="rightInfo">   
                <form name="mail" method="Post" enctype="text/plain">
                    <input type="hidden" name="CONTACTO_CARGO"/>
                    <input type="hidden" name="PAIS" id="PAIS" value="34" />
                    <label><xsl:copy-of select="document($doc)/translation/texts/item[@name='empresa']/node()"/>:</label>
                    <input maxLength="50" name="CONTACTO_EMPRESA"/>
                    <label><xsl:copy-of select="document($doc)/translation/texts/item[@name='actividad']/node()"/>:</label>
                    <input maxLength="50" name="CONTACTO_TIPO_EMP"/>
                    <label><xsl:copy-of select="document($doc)/translation/texts/item[@name='nombre_contacto']/node()"/>:</label>
                    <input type="text" maxLength="50" name="CONTACTO_NOMBRE"/>
                    <label><xsl:copy-of select="document($doc)/translation/texts/item[@name='telefono']/node()"/>:</label>
                    <input type="tel" maxLength="50" name="CONTACTO_TEL"/>
                    <label><xsl:copy-of select="document($doc)/translation/texts/item[@name='e_mail']/node()"/>:</label>
                    <input maxLength="50" name="CONTACTO_MAIL"/>
                    <label><xsl:copy-of select="document($doc)/translation/texts/item[@name='comentarios']/node()"/>:</label>
                    <textarea name="CONTACTO_TEXT" />
                </form>
                <a class="botonInfo" id="botonContacto" href="javascript:EnviaContacto(document.forms['mail']);">
                    <xsl:copy-of select="document($doc)/translation/texts/item[@name='solicita_info']/node()"/>
                </a>
                <div id="confirmBox" class="confirmBoxInfo" style="display:none;" align="center">
                    <xsl:value-of select="document($doc)/translation/texts/item[@name='gracias_por_contactar_medicalvm']/node()"/>
		</div><!--fin de confirmBox-->

		<div id="waitBox" style="display:none;">&nbsp;</div>
                <br />
                <br />
             </section><!--fin de rightInfo-->
             
             
			<!--	Area Publica	-->
			<!--<form name="mail" method="Post" enctype="text/plain">
				<input type="hidden" name="PAIS" id="PAIS" value="34"/>

				<div class="zonaPublicaBox">
					<div class="contactBox">
						<p><label><xsl:value-of select="document($doc)/translation/texts/item[@name='nombre_apellidos']/node()"/>:<span class="camposObligatorios">*</span></label>
							<input maxLength="80" size="25" name="CONTACTO_NOMBRE"/>
						</p>
						<p><label><xsl:value-of select="document($doc)/translation/texts/item[@name='empresa']/node()"/>:<span class="camposObligatorios">*</span></label>
							<input maxLength="50" size="25" name="CONTACTO_EMPRESA"/>
						</p>
						<p><label><xsl:value-of select="document($doc)/translation/texts/item[@name='e_mail']/node()"/>:<span class="camposObligatorios">*</span></label>
							<input maxLength="50" size="25" name="CONTACTO_MAIL"/>
						</p>
						<p><label><xsl:value-of select="document($doc)/translation/texts/item[@name='tipo']/node()"/>:<span class="camposObligatorios">*</span></label>
							<select name="CONTACTO_TIPO_EMP">
								<option value=""><xsl:value-of select="document($doc)/translation/texts/item[@name='tipo_empresa']/node()"/></option>
								<option value="clinica"><xsl:value-of select="document($doc)/translation/texts/item[@name='clinica']/node()"/></option>
								<option value="proveedor"><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/></option>
							</select>
						</p>
						<p><label><xsl:value-of select="document($doc)/translation/texts/item[@name='telefono']/node()"/>:<span class="camposObligatorios">*</span></label>
							<input maxLength="50" size="25" name="CONTACTO_TEL"/>
						</p>
						<p><label><xsl:value-of select="document($doc)/translation/texts/item[@name='cargo']/node()"/>:<span class="camposObligatorios">*</span></label>
							<input maxLength="50" size="25" name="CONTACTO_CARGO"/>
						</p>
						<p class="formControl"><label><xsl:value-of select="document($doc)/translation/texts/item[@name='dejar_campo_en_blanco']/node()"/>:</label>
							<input name="url"/>
                                                </p>
						<p><label><xsl:value-of select="document($doc)/translation/texts/item[@name='informacion_solicitada']/node()"/><span class="camposObligatorios">*</span></label>
							<textarea name="CONTACTO_TEXT" rows="6" cols="52"></textarea>
						</p>
						<p>
							<a href="javascript:EnviaContacto(document.forms['mail']);">
								<img src="http://www.newco.dev.br/images/botonEnviarGris.gif" alt="Enviar"/>
							</a>
						</p>

						<div id="confirmBox" style="display:none;" align="center">
							<p><xsl:value-of select="document($doc)/translation/texts/item[@name='gracias_por_contactar']/node()"/></p>
						</div>

						<div id="waitBox" style="display:none;">&nbsp;</div>
					</div>
				</div>
			</form>fin de zonaPublicaBox-->

			<!--form de mensaje de error de js-->
			<form name="mensajeJS">
				<input type="hidden" name="CNTC_NOMBRE_OBL" value="{document($doc)/translation/texts/item[@name='cntc_nombre_obl']/node()}"/>
				<input type="hidden" name="CNTC_EMAIL_OBL" value="{document($doc)/translation/texts/item[@name='cntc_email_obl']/node()}"/>
				<input type="hidden" name="CNTC_TLFN_OBL" value="{document($doc)/translation/texts/item[@name='cntc_tlfn_obl']/node()}"/>
				<input type="hidden" name="CNTC_NOM_EMPRESA_OBL" value="{document($doc)/translation/texts/item[@name='cntc_nom_empresa_obl']/node()}"/>
				<input type="hidden" name="CNTC_TIPO_EMPRESA_OBL" value="{document($doc)/translation/texts/item[@name='cntc_tipo_empresa_obl']/node()}"/>
				<input type="hidden" name="CNTC_CARGO_OBL" value="{document($doc)/translation/texts/item[@name='cntc_cargo_obl']/node()}"/>
				<input type="hidden" name="CNTC_INFO_OBL" value="{document($doc)/translation/texts/item[@name='cntc_info_obl']/node()}"/>
			</form>
			<!--	Fin Area Publica	-->
			</div><!--fin de todoInside-->
		</div><!--find e todo-->

		<div class="footerBox">
			<div class="footer">
				<xsl:copy-of select="document($doc)/translation/texts/item[@name='footer_text']/node()"/>
			</div><!--fin de footer-->
		</div><!--fin de footerBox-->
	</xsl:otherwise>
	</xsl:choose>
	<br/>
</body>
</html>
</xsl:template>

<xsl:template match="Sorry">
	<xsl:apply-templates select="Noticias/ROW/Sorry"/>
</xsl:template>
</xsl:stylesheet>