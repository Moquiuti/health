<?xml version="1.0" encoding="iso-8859-1"?>
<!-- �rea p�blica de MedicalVM -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output method="html" encoding="iso-8859-1" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd" doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN" indent="yes"/>

<xsl:template match="/">
<html xmlns="http://www.w3.org/1999/xhtml">
<!--
	Nueva pagina principal de medicalvm.com
	17dic16	ET
	Ultima revision: 26dic16 12:27
-->

<!--idioma-->
<xsl:variable name="lang">
	<xsl:choose>
	<xsl:when test="LANG != ''"><xsl:value-of select="LANG"/></xsl:when>
	<xsl:otherwise>spanish</xsl:otherwise>
	</xsl:choose>
</xsl:variable>
<xsl:variable name="doc">http://www.newco.dev.br/General/ap_texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
<!--fin idioma-->

<!--portal-->
<xsl:variable name="portal">
	<xsl:choose>
	<xsl:when test="PORTAL != ''"><xsl:value-of select="PORTAL"/></xsl:when>
	<xsl:otherwise>MVM</xsl:otherwise>
	</xsl:choose>
</xsl:variable>
<!--fin idioma-->

<head>

	<title><xsl:value-of select="document($doc)/translation/texts/item[@name='AP_MVM_titulo']/node()"/><!--Plataforma de compras hospitalarias&nbsp;-&nbsp;MedicalVM.com--></title>
	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/login_16dic16.js"></script>
	<link rel="shortcut icon" href="http://www.newco.dev.br/images/MedicalVM.ico"/>
	<meta name="description" content="Medical VM es la primera plataforma para crear centrales de compras a medida.">
		<xsl:attribute name="content"><xsl:value-of select="document($doc)/translation/texts/item[@name='AP_MVM_metadescr']/node()"/></xsl:attribute>
	</meta>
	<link rel="stylesheet" href="http://www.newco.dev.br/General/areapublica.css" type="text/css"/>
	<script type="text/javascript">
		var errorLogin = 'Se ha producido un error al entrar el usuario o la contrase�a.';

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
<body onload="CompruebaCookie();">
    <div class="todo">
		<a name="MedicalVM"/>
		<div class="avisoCookie" id="avisoCookieBox" style="display:none;">
			<div class="avisoCookieBox">
                    <p class="textoCookie"><xsl:value-of select="document($doc)/translation/texts/item[@name='AP_MVM_textocookie1']/node()"/>
					<!--Al acceder al �rea privada de MedicalVM.com se crear�n �nicamente las "cookies" necesarias para navegar en nuestra 
plataforma con seguridad, guardando la identificaci�n de la sesi�n y algunos datos de configuraci�n del usuario.--></p>
                    <p class="textoCookie"><xsl:value-of select="document($doc)/translation/texts/item[@name='AP_MVM_textocookie2']/node()"/>
					<!--Adem�s, nuestro analizador de tr�fico del site utiliza "cookies" y seguimientos de IPs que nos permiten recoger datos a
 efectos estad�sticos: fecha de la primera visita, n�mero de veces que se ha visitado, fecha de la �ltima visita, URL y dominio de la que 
proviene, explorador utilizado y resoluci�n de la pantalla. No obstante,  el usuario si lo desea puede desactivar y/o eliminar estas cookies 
siguiendo las instrucciones de su navegador de Internet.--></p>
                    <p class="textoCookie"><xsl:value-of select="document($doc)/translation/texts/item[@name='AP_MVM_textocookie3']/node()"/>
					<!--Si contin�as navegando en la p�gina entenderemos que aceptas nuestra <a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/PoliticaCookies.html','Politica%20Cookies',60,60,20,20);">pol�tica de cookies</a>&nbsp;-->
                    &nbsp;&nbsp;&nbsp;&nbsp;<a id="aceptaCookie" class="btnOscuro" href="javascript:AceptaCookie();">Acepta</a>
                    </p>
                </div>
      	</div>
    	<div class="cabecera">
    		<div class="logo">
				<a><!-- href="http://www.newco.dev.br/" title="Medical Virtual Market">-->
					<xsl:attribute name="href"><xsl:value-of select="document($doc)/translation/texts/item[@name='AP_MVM_URL']/node()"/></xsl:attribute>
					<xsl:attribute name="title"><xsl:value-of select="document($doc)/translation/texts/item[@name='AP_MVM_Portal']/node()"/></xsl:attribute>
					<img><!-- src="http://www.newco.dev.br/images/login2017/medical-vm-logo.png" alt="Medical Virtual Market"/>-->
						<!--<xsl:attribute name="src"><xsl:value-of select="document($doc)/translation/texts/item[@name='AP_MVM_Logo']/node()"/></xsl:attribute>-->
						<xsl:attribute name="src"><xsl:value-of select="document($doc)/translation/texts/item[@name='AP_MVM_Logo']/node()"/></xsl:attribute>
						<xsl:attribute name="alt"><xsl:value-of select="document($doc)/translation/texts/item[@name='AP_MVM_Portal']/node()"/></xsl:attribute>
					</img>
				</a>
			</div>
				<nav>
					<ul>
						<li>
							<a href="#MedicalVM">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='AP_MVM_Portal']/node()"/></a>
						</li>
						<li>
							<a href="#Servicios">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='AP_Servicios']/node()"/></a>
						</li>
						<li>
							<a href="#Clientes">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='AP_Clientes']/node()"/></a>
						</li>
						<li>
							<a href="#Clientes">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='AP_Proveedores']/node()"/></a>
						</li>
						<li>
							<a href="#Contacto">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='AP_Contacto']/node()"/></a>
						</li>
					</ul>
				</nav>
		</div>
    	<div class="separador" id="separador" style="display:none;"></div>
    	<div class="centro">
    		<div class="textocentro">
				<br/>
				<br/>
				<br/>
				<br/>
				<br/>
				<h1><xsl:value-of select="document($doc)/translation/texts/item[@name='AP_MVM_PortalLargo']/node()"/></h1>
				<p><xsl:value-of select="document($doc)/translation/texts/item[@name='AP_MVM_Portal']/node()"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='AP_Innovacion']/node()"/></p>
				<p><xsl:value-of select="document($doc)/translation/texts/item[@name='AP_MVM_Portal']/node()"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='AP_Ahorros']/node()"/></p>
				<p><xsl:value-of select="document($doc)/translation/texts/item[@name='AP_MVM_Portal']/node()"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='AP_Procedimientos']/node()"/></p>
				<p><xsl:value-of select="document($doc)/translation/texts/item[@name='AP_MVM_Portal']/node()"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='AP_Escalable']/node()"/></p>
				<p><xsl:value-of select="document($doc)/translation/texts/item[@name='AP_Clientesyproveedores']/node()"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='AP_MVM_Portal']/node()"/><xsl:value-of select="document($doc)/translation/texts/item[@name='AP_Donde']/node()"/></p>
			</div>
			<!--<div>
				<img src="ImagenConFondoAzul.png"/>
			</div>-->
    		<div class="login">
    			<div class="loginBox">
					<form name="frmLogin" method="post" action="http://www.newco.dev.br/MenusYDerechos/Main.xsql">
					<input type="hidden" name="DOMINIO" value="{document($doc)/translation/texts/item[@name='AP_MVM_Dominio']/node()}"/>
					<input type="hidden" name="PARAMETRO" value=""/>
        			<input type="hidden" name="ERROR_LOGIN" value="{document($doc)/translation/texts/item[@name='error_login']/node()}"/>
					<div class="usuario">
            			<span class="textoLogin"><xsl:value-of select="document($doc)/translation/texts/item[@name='AP_Usuario']/node()"/>:</span><br />
            			<input type="text" name="USER" class="intext" onClick="this.select();" onFocus="this.select();" />
        			</div><!--fin de login-->
        			<div class="clave">
            			<span class="textoLogin"><xsl:value-of select="document($doc)/translation/texts/item[@name='AP_Contrasenna']/node()"/>:</span><br />
            			<input type="password" name="PASS" class="intext" onClick="this.select();" onFocus="this.select();" />
        			</div><!--fin de login-->
					<br/>
					<a id="btnLogin" class="btnClaro" href="javascript:procesarLogin();">Entrar</a>
					</form>
        			<a class="textoLogin recuperarClaveLink" href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/RecuperarClave.xsql','Recuperar Clave',30,20,-20,0);" title="Recuperar clave"><xsl:value-of select="document($doc)/translation/texts/item[@name='AP_RecuperarClave']/node()"/></a>
    			</div><!--fin de loginBox-->
			</div>
		</div>
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
		</div>
	</div>
</body>
</html>
</xsl:template>
</xsl:stylesheet>
