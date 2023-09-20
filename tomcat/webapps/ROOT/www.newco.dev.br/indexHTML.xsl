<?xml version="1.0" encoding="iso-8859-1"?>
<!-- 
	Area publica de MedicalVM 
	Ultima revision: ET 21oct21 10:00 login_211021.js
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output method="html" encoding="iso-8859-1" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd" doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN" indent="yes"/>

<xsl:template match="/">
<html xmlns="http://www.w3.org/1999/xhtml">

<!--idioma-->
<xsl:variable name="lang">
	<xsl:choose>
	<xsl:when test="/AreaPublica/INDEXLANG != ''"><xsl:value-of select="/AreaPublica/INDEXLANG"/></xsl:when><!-- utilizar INDEXLANG para evitar confusion con la cookie LANG	-->
	<xsl:when test="/AreaPublica/INDEXLANG ='' and /AreaPublica/LANG != ''"><xsl:value-of select="/AreaPublica/LANG"/></xsl:when>
	<xsl:otherwise>spanish</xsl:otherwise>
	</xsl:choose>
</xsl:variable>
<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
<!--fin idioma-->

<!--portal-->
<xsl:variable name="portal">
	<xsl:choose>
	<xsl:when test="/AreaPublica/PORTAL != ''"><xsl:value-of select="/AreaPublica/PORTAL"/></xsl:when>
	<xsl:otherwise>MVM</xsl:otherwise>
	</xsl:choose>
</xsl:variable>
<!--portal-->

<!--login minimo-->
<xsl:variable name="reducido">
	<xsl:choose>
	<xsl:when test="/AreaPublica/REDUCIDO != ''"><xsl:value-of select="/AreaPublica/REDUCIDO"/></xsl:when>
	<xsl:otherwise>N</xsl:otherwise>
	</xsl:choose>
</xsl:variable>
<!--portal-->

<xsl:variable name="AP_Titulo">AP_<xsl:value-of select="$portal"/>_titulo</xsl:variable>
<xsl:variable name="AP_metadescr">AP_<xsl:value-of select="$portal"/>_metadescr</xsl:variable>
<xsl:variable name="AP_Portal">AP_<xsl:value-of select="$portal"/>_Portal</xsl:variable>

<xsl:variable name="AP_textocookie1">AP_<xsl:value-of select="$portal"/>_textocookie1</xsl:variable>
<xsl:variable name="AP_textocookie2">AP_<xsl:value-of select="$portal"/>_textocookie2</xsl:variable>
<xsl:variable name="AP_textocookie3">AP_<xsl:value-of select="$portal"/>_textocookie3</xsl:variable>

<xsl:variable name="AP_URL">AP_<xsl:value-of select="$portal"/>_URL</xsl:variable>
<xsl:variable name="AP_Logo">AP_<xsl:value-of select="$portal"/>_Logo</xsl:variable>
<xsl:variable name="AP_PortalLargo">AP_<xsl:value-of select="$portal"/>_PortalLargo</xsl:variable>
<xsl:variable name="AP_Dominio">AP_<xsl:value-of select="$portal"/>_Dominio</xsl:variable>

<xsl:variable name="AP_Mision">AP_<xsl:value-of select="$portal"/>_Mision</xsl:variable>
<xsl:variable name="AP_MisionTexto">AP_<xsl:value-of select="$portal"/>_MisionTexto</xsl:variable>
<xsl:variable name="AP_Vision">AP_<xsl:value-of select="$portal"/>_Vision</xsl:variable>
<xsl:variable name="AP_VisionTexto">AP_<xsl:value-of select="$portal"/>_VisionTexto</xsl:variable>
<xsl:variable name="AP_Valores">AP_<xsl:value-of select="$portal"/>_Valores</xsl:variable>
<xsl:variable name="AP_ValoresTexto">AP_<xsl:value-of select="$portal"/>_ValoresTexto</xsl:variable>


<head>

	<title><xsl:value-of select="document($doc)/translation/texts/item[@name=$AP_Titulo]/node()"/>.</title>
	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/login_211021.js"></script>
	<link rel="shortcut icon" href="http://www.newco.dev.br/images/MedicalVM.ico"/>
	<meta name="description" content="Medical VM es la primera plataforma para crear centrales de compras a medida.">
		<xsl:attribute name="content"><xsl:value-of select="document($doc)/translation/texts/item[@name=$AP_metadescr]/node()"/></xsl:attribute>
	</meta>
	<link rel="stylesheet" href="http://www.newco.dev.br/General/areapublica.css" type="text/css"/>
	<link rel="stylesheet" href="http://www.newco.dev.br/General/test2022v1.css" type="text/css"/>
	<script type="text/javascript">
		var errorLogin = 'Se ha producido un error al entrar el usuario o la contraseña.';

        function CompruebaCookie(){

			var aceptoCookie = GetCookie('ACEPTO_COOKIE');

			if (aceptoCookie == '' || aceptoCookie == null) {
				//si no ha aceptado la cookie pongo aviso
				document.getElementById("avisoCookieBox").style.display = 'block';
				document.getElementById("separador").style.display = 'none';
			}
			else
			{
				document.getElementById("separador").style.display = 'block';
				document.getElementById("avisoCookieBox").style.display = 'none';
			}
		}
            
        function AceptaCookie(){

			SetCookie('ACEPTO_COOKIE','S');
			CompruebaCookie();
		}
            
	</script>
</head>
<body onload="CompruebaHTTP('');CompruebaCookie();">
    <div class="todo">
		<a name="MedicalVM"/>
		<xsl:choose>
		<xsl:when test="$reducido != 'S'">
		<div class="avisoCookie" id="avisoCookieBox" style="display:none;">
			<div class="avisoCookieBox">
                    <p class="textoCookie"><xsl:value-of select="document($doc)/translation/texts/item[@name=$AP_textocookie1]/node()"/></p>
                    <p class="textoCookie"><xsl:value-of select="document($doc)/translation/texts/item[@name=$AP_textocookie2]/node()"/></p>
                    <p class="textoCookie"><xsl:value-of select="document($doc)/translation/texts/item[@name=$AP_textocookie3]/node()"/>
                    <a id="aceptaCookie" class="btnOscuro" href="javascript:AceptaCookie();">
                    	<xsl:value-of select="document($doc)/translation/texts/item[@name='acepta']/node()"/>
                    </a>
                    </p>
                </div>
      	</div>
		</xsl:when>
		<xsl:otherwise>
			<!--para evitar error JS	-->
			<span id="avisoCookieBox" style="display:none;"/>
		</xsl:otherwise>
		</xsl:choose>
		
		
    	<div class="cabecera">
    		<div class="logo">
				<a>
					<xsl:attribute name="href"><xsl:value-of select="document($doc)/translation/texts/item[@name=$AP_URL]/node()"/></xsl:attribute>
					<xsl:attribute name="title"><xsl:value-of select="document($doc)/translation/texts/item[@name=$AP_Portal]/node()"/></xsl:attribute>
					<img>
						<xsl:attribute name="src"><xsl:value-of select="document($doc)/translation/texts/item[@name=$AP_Logo]/node()"/></xsl:attribute>
						<xsl:attribute name="alt"><xsl:value-of select="document($doc)/translation/texts/item[@name=$AP_Portal]/node()"/></xsl:attribute>
					</img>
				</a>
			</div>
			<xsl:choose>
			<xsl:when test="$reducido != 'S'">
				<nav>
					<ul style="width:1200px;">
						<li style="width:130px;">
							<a href="#MedicalVM">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name=$AP_Portal]/node()"/></a>
						</li>
						<li style="width:130px;">
							<a href="#Servicios">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='AP_Servicios']/node()"/></a>
						</li>
						<li style="width:130px;">
							<a href="#Clientes">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='AP_Clientes']/node()"/></a>
						</li>
						<!--
						<li>
							<a href="#Proveedores">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='AP_Proveedores']/node()"/></a>
						</li>
						-->
						<li style="width:130px;">
							<a href="#Contacto">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='AP_Contacto']/node()"/></a>
						</li>
						<li style="width:200px;">
						&nbsp;<a href="http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPNuevaSimple2022.xsql?IDPAIS={/AreaPublica/IDPAIS}&amp;PORTAL={/AreaPublica/PORTAL}&amp;INDEXLANG={$lang}"><xsl:value-of select="document($doc)/translation/texts/item[@name='AP_NuevoProveedor']/node()"/></a>
						</li>
					</ul>
				</nav>
			</xsl:when>
			<xsl:otherwise>
				&nbsp;<a class="textoOscuro" href="http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPNuevaSimple2022.xsql?IDPAIS={/AreaPublica/IDPAIS}&amp;PORTAL={/AreaPublica/PORTAL}&amp;INDEXLANG={$lang}"><xsl:value-of select="document($doc)/translation/texts/item[@name='AP_NuevoProveedor']/node()"/></a>
			</xsl:otherwise>
			</xsl:choose>
	</div>
    	<div class="separador" id="separador" style="display:none;"></div>
    	<div class="centro">
    		<div class="textocentro">
				<xsl:choose>
				<xsl:when test="$reducido != 'S'">
					<br/>
					<br/>
					<br/>
					<h1><xsl:value-of select="document($doc)/translation/texts/item[@name=$AP_PortalLargo]/node()"/></h1>
					<p><xsl:value-of select="document($doc)/translation/texts/item[@name=$AP_Portal]/node()"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='AP_Innovacion']/node()"/></p>
					<p><xsl:value-of select="document($doc)/translation/texts/item[@name=$AP_Portal]/node()"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='AP_Ahorros']/node()"/></p>
					<p><xsl:value-of select="document($doc)/translation/texts/item[@name=$AP_Portal]/node()"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='AP_Procedimientos']/node()"/></p>
					<p><xsl:value-of select="document($doc)/translation/texts/item[@name=$AP_Portal]/node()"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='AP_Escalable']/node()"/></p>
					<p><xsl:value-of select="document($doc)/translation/texts/item[@name='AP_Clientesyproveedores']/node()"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name=$AP_Portal]/node()"/><xsl:value-of select="document($doc)/translation/texts/item[@name='AP_Donde']/node()"/></p>

					<p><a class="textoMarketplace" href="http://www.nucleo-hospitalvm.com/" target="_blank" title="HospitalVM"><xsl:value-of select="document($doc)/translation/texts/item[@name='AP_Marketplace']/node()"/></a></p>
					
				</xsl:when>
				<xsl:otherwise>
					<br/>
					<br/>
					<br/>
					<h1><xsl:value-of select="document($doc)/translation/texts/item[@name=$AP_PortalLargo]/node()"/></h1>
					<p><strong><xsl:value-of select="document($doc)/translation/texts/item[@name=$AP_Mision]/node()"/></strong></p>
					<p><xsl:value-of select="document($doc)/translation/texts/item[@name=$AP_MisionTexto]/node()"/></p>
					<p><strong><xsl:value-of select="document($doc)/translation/texts/item[@name=$AP_Vision]/node()"/></strong></p>
					<p><xsl:value-of select="document($doc)/translation/texts/item[@name=$AP_VisionTexto]/node()"/></p>
					<p><strong><xsl:value-of select="document($doc)/translation/texts/item[@name=$AP_Valores]/node()"/></strong></p>
					<p><xsl:copy-of select="document($doc)/translation/texts/item[@name=$AP_ValoresTexto]/node()"/></p>

					<p><a class="textoMarketplace" href="http://www.nucleo-hospitalvm.com/" target="_blank" title="HospitalVM"><xsl:value-of select="document($doc)/translation/texts/item[@name='AP_Marketplace']/node()"/></a></p>

				</xsl:otherwise>
				</xsl:choose>
			</div>
			<!--<div>
				<img src="ImagenConFondoAzul.png"/>
			</div>-->
    		<div class="login">
    			<div class="loginBox">
					<!--<form name="frmLogin" method="post" action="http://www.newco.dev.br/MenusYDerechos/Main.xsql">-->
					<form name="frmLogin">
						<input type="hidden" name="DOMINIO" value="{document($doc)/translation/texts/item[@name=$AP_Dominio]/node()}"/><!-- necesario para la cookie	-->
        				<!--<input type="hidden" name="ERROR_LOGIN" value="{document($doc)/translation/texts/item[@name='error_login']/node()}"/>-->
						<input type="hidden" name="PARAMETRO" value=""/>
						<div class="usuario">
            				<span class="textoLogin"><xsl:value-of select="document($doc)/translation/texts/item[@name='AP_Usuario']/node()"/>:</span><br />
            				<input type="text" name="USER" onClick="this.select();" onFocus="this.select();" />
        				</div><!--fin de login-->
						<br />
        				<div class="clave">
            				<span class="textoLogin"><xsl:value-of select="document($doc)/translation/texts/item[@name='AP_Contrasenna']/node()"/>:</span><br />
            				<input type="password" name="PASS" onClick="this.select();" onFocus="this.select();" />
        				</div><!--fin de login-->
						<!--<br/>
						<a id="btnLogin" class="btnClaro" href="javascript:procesarLogin();">Entrar</a>-->
						<br/>
						<a id="btnLoginDirecto" class="btnClaro" href="javascript:loginDirecto();"><xsl:value-of select="document($doc)/translation/texts/item[@name='AP_Entrar']/node()"/></a>
						<br/>
						<br/>
						<div id="textoOK" class="loginOK" style="display:none;"><xsl:value-of select="document($doc)/translation/texts/item[@name='LoginOK']/node()"/></div>
						<div id="textoKO" class="loginKO" style="display:none;"><xsl:value-of select="document($doc)/translation/texts/item[@name='LoginKO']/node()"/></div>
					</form>
					<br />
        			<a class="textoLogin recuperarClaveLink" href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/RecuperarClave.xsql?LANG={$lang}','Recuperar Clave',30,20,-20,0);" title="Recuperar clave"><xsl:value-of select="document($doc)/translation/texts/item[@name='AP_RecuperarClave']/node()"/></a>
    			</div><!--fin de loginBox-->
			</div>
		</div>
		<xsl:if test="$reducido != 'S'">
			<a name="Servicios"/>
    		<div class="zonados">
   				<div class="servicios">
    				<div class="servicio">
						<img src="http://www.newco.dev.br/images/login2017/icone-software-de-compras.png">
							<xsl:attribute name="alt"><xsl:value-of select="document($doc)/translation/texts/item[@name='AP_PlatCompras']/node()"/></xsl:attribute>
						</img>
						<h3 class="textoOscuro"><xsl:value-of select="document($doc)/translation/texts/item[@name='AP_PlatCompras']/node()"/></h3>
						<p class="textoOscuro"><xsl:value-of select="document($doc)/translation/texts/item[@name='AP_PlatCompras_explic']/node()"/></p>
					</div>
    				<div class="servicio">
						<img src="http://www.newco.dev.br/images/login2017/icone-follow-up-medical-vm.png">
							<xsl:attribute name="alt"><xsl:value-of select="document($doc)/translation/texts/item[@name='AP_SegPedidos']/node()"/></xsl:attribute>
						</img>
						<h3 class="textoOscuro"><xsl:value-of select="document($doc)/translation/texts/item[@name='AP_SegPedidos']/node()"/></h3>
						<p class="textoOscuro"><xsl:value-of select="document($doc)/translation/texts/item[@name='AP_SegPedidos_explic']/node()"/></p>
					</div>
    				<div class="servicio">
						<img src="http://www.newco.dev.br/images/login2017/icone-central-de-compras.png">
							<xsl:attribute name="alt"><xsl:value-of select="document($doc)/translation/texts/item[@name='AP_CentralCompras']/node()"/></xsl:attribute>
						</img>
						<h3 class="textoOscuro"><xsl:value-of select="document($doc)/translation/texts/item[@name='AP_CentralCompras']/node()"/></h3>
						<p class="textoOscuro"><xsl:value-of select="document($doc)/translation/texts/item[@name='AP_CentralCompras_explic']/node()"/></p>
					</div>
    				<div class="servicio">
						<img src="http://www.newco.dev.br/images/login2017/icone-compras-agregadas.png">
							<xsl:attribute name="alt"><xsl:value-of select="document($doc)/translation/texts/item[@name='AP_AgregCompras']/node()"/></xsl:attribute>
						</img>
						<h3 class="textoOscuro"><xsl:value-of select="document($doc)/translation/texts/item[@name='AP_AgregCompras']/node()"/></h3>
						<p class="textoOscuro"><xsl:value-of select="document($doc)/translation/texts/item[@name='AP_AgregCompras_explic']/node()"/></p>
					</div>
				</div>
			</div>
			<a name="Clientes"/>
    		<div class="zonatres">
    			<div class="cliente">
					<h3>Cliente</h3>
					<ul class="listaHome">
					<li class="textoClaro"><xsl:value-of select="document($doc)/translation/texts/item[@name='AP_VentCliente1']/node()"/></li>
					<li class="textoClaro"><xsl:value-of select="document($doc)/translation/texts/item[@name='AP_VentCliente2']/node()"/></li>
					<li class="textoClaro"><xsl:value-of select="document($doc)/translation/texts/item[@name='AP_VentCliente3']/node()"/></li>
					<li class="textoClaro"><xsl:value-of select="document($doc)/translation/texts/item[@name='AP_VentCliente4']/node()"/></li>
					<li class="textoClaro"><xsl:value-of select="document($doc)/translation/texts/item[@name='AP_VentCliente5']/node()"/></li>
					<li class="textoClaro"><xsl:value-of select="document($doc)/translation/texts/item[@name='AP_VentCliente6']/node()"/></li>
					</ul>
				</div>
    			<div class="proveedor">
					<h3>Proveedor</h3>
					<ul>
					<li class="textoClaro"><xsl:value-of select="document($doc)/translation/texts/item[@name='AP_VentProveedor1']/node()"/></li>
					<li class="textoClaro"><xsl:value-of select="document($doc)/translation/texts/item[@name='AP_VentProveedor2']/node()"/></li>
					<li class="textoClaro"><xsl:value-of select="document($doc)/translation/texts/item[@name='AP_VentProveedor3']/node()"/></li>
					<li class="textoClaro"><xsl:value-of select="document($doc)/translation/texts/item[@name='AP_VentProveedor4']/node()"/></li>
					<li class="textoClaro"><xsl:value-of select="document($doc)/translation/texts/item[@name='AP_VentProveedor5']/node()"/></li>
					<li class="textoClaro"><xsl:value-of select="document($doc)/translation/texts/item[@name='AP_VentProveedor6']/node()"/></li>
					</ul>
				</div>
			</div>
			<a name="Contacto"/>
    		<div class="zonacuatro">
    			<div class="contacto">
 				<h3 class="textoOscuro"><span class="textoDestacado"><xsl:value-of select="document($doc)/translation/texts/item[@name='AP_Contacte']/node()"/></span>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='AP_Presentacion']/node()"/>:</h3>
				<form name="Contacto" method="Post" enctype="text/plain" class="formEstandar">
					<input type="hidden" name="CONTACTO_CARGO"/>
					<input type="hidden" name="PAIS" id="PAIS" value="34"/>
					<input type="hidden" name="PORTAL" id="PORTAL" value="$portal"/>
					<ul>
						<li>
							<label><span class="textoDestacado">&gt;</span>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='AP_Empresa']/node()"/>:</label>
							<input maxLength="50" name="CONTACTO_EMPRESA"/>
						</li>
						<li>
							<label><span class="textoDestacado">&gt;</span>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='AP_Actividad']/node()"/>:</label>
							<input maxLength="50" name="CONTACTO_TIPO_EMP"/>
						</li>
						<li>
							<label><span class="textoDestacado">&gt;</span>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='AP_Nombrecontacto']/node()"/>:</label>
							<input type="text" maxLength="50" name="CONTACTO_NOMBRE"/>
						</li>
						<li>
							<label><span class="textoDestacado">&gt;</span>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='AP_Telefono']/node()"/>:</label>
							<input type="tel" maxLength="50" name="CONTACTO_TEL"/>
						</li>
						<li>
							<label><span class="textoDestacado">&gt;</span>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='AP_EMail']/node()"/>:</label>
							<input maxLength="50" name="CONTACTO_MAIL"/>
						</li>
						<li>
							<label><span class="textoDestacado">&gt;</span>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='AP_Comentarios']/node()"/>:</label>
							<textarea name="CONTACTO_TEXT"></textarea>
						</li>
						<li>
							<a class="btnOscuro" id="botonContacto" href="javascript:EnviaContacto(document.forms['Contacto']);"><xsl:value-of select="document($doc)/translation/texts/item[@name='AP_Contacte']/node()"/></a>
						</li>
					</ul>
				</form>
				<div id="confirmBox" class="confirmBoxInfo" style="display:none;" align="center"><xsl:value-of select="document($doc)/translation/texts/item[@name='AP_Gracias']/node()"/></div>
				<div id="waitBox" style="display:none;">&nbsp;</div><br/><br/>
            	<form name="mensajeJS">
					<input type="hidden" name="CNTC_NOMBRE_OBL"><xsl:attribute name="value"><xsl:value-of select="document($doc)/translation/texts/item[@name='AP_ErrorFaltaNombre']/node()"/></xsl:attribute></input>
					<input type="hidden" name="CNTC_EMAIL_OBL"><xsl:attribute name="value"><xsl:value-of select="document($doc)/translation/texts/item[@name='AP_ErrorFaltaEMail']/node()"/></xsl:attribute></input>
					<input type="hidden" name="CNTC_TLFN_OBL"><xsl:attribute name="value"><xsl:value-of select="document($doc)/translation/texts/item[@name='AP_ErrorFaltaTelf']/node()"/></xsl:attribute></input>
					<input type="hidden" name="CNTC_NOM_EMPRESA_OBL"><xsl:attribute name="value"><xsl:value-of select="document($doc)/translation/texts/item[@name='AP_ErrorFaltaEmpresa']/node()"/></xsl:attribute></input>
					<input type="hidden" name="CNTC_TIPO_EMPRESA_OBL"><xsl:attribute name="value"><xsl:value-of select="document($doc)/translation/texts/item[@name='AP_ErrorFaltaTipo']/node()"/></xsl:attribute></input>
					<input type="hidden" name="CNTC_CARGO_OBL"><xsl:attribute name="value"><xsl:value-of select="document($doc)/translation/texts/item[@name='AP_ErrorFaltaCargo']/node()"/></xsl:attribute></input>
					<input type="hidden" name="CNTC_INFO_OBL"><xsl:attribute name="value"><xsl:value-of select="document($doc)/translation/texts/item[@name='AP_ErrorFaltaInfo']/node()"/></xsl:attribute></input>
            	</form>

				<!-- RGPD 20180710 -->
    				<div>
					<!--<rgpd.h3>Información RGPD</rgpd.h3>-->
					<table>
						<tr>
							<td></td>
							<td>Información RGPD</td>
						</tr>
						<tr>
							<td>Epígrafe</td>
							<td>Información básica</td>
						</tr>
						<tr>
							<td>Responsable</td>
							<td>Sistemas de Información para la Dirección, S.L</td>
  						</tr>
						<tr>
							<td>Finalidad</td>
							<td>Gestión de clientes y proveedores</td>
  						</tr>
						<tr>
							<td>Legitimación</td>
							<td>Consentimiento del interesado en cumplimiento de una obligación legal para recoger y tratar datos personales según RGPD</td>
  						</tr>
						<tr>
							<td>Destinatarios</td>
							<td>No se cederán datos a terceros, salvo obligación legal</td>
  						</tr>
						<tr>
							<td>Derechos</td>
							<td>Tiene derechos a acceder, rectificar y suprimir los datos, así como no ser objeto de decisiones individuales automatizadas</td>
  						</tr>
						<tr>
							<td>Procedencia</td>
							<td>Datos suministrados por el interesado</td>
  						</tr>
						<tr>
							<td>Información adicional</td>
							<td>Consultar información adicional en <a href="http://www.newco.dev.br/PoliticaProteccionDatos.xsql?LANG={$lang}">Política Protección de Datos</a></td>
  						</tr>
					</table>
				</div>

				</div>
				<div class="logosClientes">
					<img src="http://www.newco.dev.br/images/login2017/logosClientes.png" width="250px" height="400px">
						<xsl:attribute name="alt"><xsl:value-of select="document($doc)/translation/texts/item[@name='AP_LogosClientes']/node()"/></xsl:attribute>
					</img>
				</div>
			</div>
    		<div class="pie">
				<p><xsl:value-of select="document($doc)/translation/texts/item[@name='AP_Pie1']/node()"/></p>
				<p><xsl:value-of select="document($doc)/translation/texts/item[@name='AP_Pie2']/node()"/></p>
				<xsl:if test="$reducido != 'S'">
					<p><xsl:value-of select="document($doc)/translation/texts/item[@name='AP_DatosLegales']/node()"/></p>
				</xsl:if>
			</div>
		</xsl:if>
	</div>
</body>
</html>
</xsl:template>
</xsl:stylesheet>
