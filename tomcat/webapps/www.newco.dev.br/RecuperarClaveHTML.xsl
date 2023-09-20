<?xml version="1.0" encoding="iso-8859-1"?>
<!-- 
	Recuperar contraseña
	
 -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:import href="http://www.newco.dev.br/General/General.xsl"/>
<xsl:output method="html" encoding="iso-8859-1" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd" doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN" indent="yes"/>
<xsl:param name="usuario" select="@US_ID"/>

<xsl:template match="/">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:choose>
		<xsl:when test="/AreaPublica/LANG"><xsl:value-of select="/AreaPublica/LANG"/></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--fin idioma-->

	<title>
		<xsl:value-of select="document($doc)/translation/texts/item[@name='central_compras_material_sanitario']/node()"/>&nbsp;-&nbsp;
		<xsl:value-of select="document($doc)/translation/texts/item[@name='medicalvm']/node()"/>
	</title>

	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1"/>

	<link rel="shortcut icon" href="http://www.newco.dev.br/images/MedicalVM.ico"/>
	<!--<link rel="stylesheet" href="http://www.newco.dev.br/General/basicPublic.css" type="text/css"/>-->
	<link rel="stylesheet" href="http://www.newco.dev.br/General/areapublica.css" type="text/css"/>
        
    <script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
	<!--<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>-->
	<script type="text/javascript" src="http://www.newco.dev.br/General/ValidaCamps.js"></script>

	<script type="text/javascript">
		var noEmail	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='no_email']/node()"/>';
		var strOk	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='ok_email']/node()"/>';
		var strNoOk	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='error_email']/node()"/>';

		<!-- Variables necesarias para crear las cookies -->
		var cookieSESSID	='<xsl:value-of select="/Main/USUARIO/SES_ID"/>';
		var cookieUSID		='<xsl:value-of select="/Main/USUARIO/US_ID"/>';
		var cookieIdioma	='<xsl:value-of select="/Main/USUARIO/LANG"/>';
		var cookieNombre	='<xsl:value-of select="/Main/USUARIO/US_NOMBRE"/>';

		setCookie('SES_ID',cookieSESSID);
		setCookie('US_ID',cookieUSID);
		setCookie('LANG',cookieIdioma);

		function setCookie(nombre,valor){
			// Asignamos la cookie... Caducidad de la cookie 'At end of session'
			document.cookie = nombre+ "=" + encodeURIComponent(valor) + '; path=/; host=' + location.hostname + ';';
		}

		function sendPwd(sEmail)
		{
			var d= new Date();
			jQuery.ajax({
				cache:	false,
				//async: false,
				url:	'http://www.newco.dev.br/EnviarUsuarioParaClaveAJAX.xsql',
				type:	"GET",
				data:	"USUARIO="+sEmail+"&amp;_="+d.getTime(),
				contentType: "application/xhtml+xml",
				error: function(objeto, quepaso, otroobj){
					alert('Error conectando');
				},
				success: function(objeto){

					//	Compatibilidad entre navegadores + rendimiento en el parsing
					var data = JSON &amp;&amp; JSON.parse(objeto) || $.parseJSON(objeto);
					
					//solodebug	console.log('sendPwd '+sEmail+': '+objeto+':::::'+data.RecuperarClave.estado);
					
					if (data.RecuperarClave.estado=='OK')
					{
						jQuery('#emailError').css('color','#3d5d95').html(strOk).show();//.css('color: #3d5d95;')
					}
					else
					{
						jQuery('#emailError').css('color','#FE4162').html(strNoOk).show();//.css('color: #FE4162;')
					}
				}
			});
		}


		function CheckFormEmail(){
			var sEmail	= jQuery('#email').val();
			jQuery('#emailError').html('').hide();

			// Si no hay datos o no cumple formato email
			if(sEmail == ''){
				jQuery('#emailError').html(noEmail).show();
			}else{
				sendPwd(sEmail);
			}
		}
	</script>


</head>

<body>
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
		<!--	/AreaPublica	-->
      	<!--<div class="todo" style="background:#f5f5f5;">-->
      	<div>
            <div class="recuperarClave" style="text-align:center;">
                <p id="emailError" style="display:none;"></p>
				<p class="textoOscuro">
        			<!--<label><xsl:value-of select="document($doc)/translation/texts/item[@name='email_usuario']/node()"/>:</label>-->
        			<xsl:value-of select="document($doc)/translation/texts/item[@name='email_usuario']/node()"/>:
					&nbsp;<input type="text" name="email" id="email"/>
        		</p>
		<!--<div class="botonGris marginLeft">-->
            	<a class="btnDestacado" href="javascript:CheckFormEmail();">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='recuperar_pwd']/node()"/>
            	</a>
		<!--</div>-->
            </div>
            
        </div><!--fin de todo-->
        
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
