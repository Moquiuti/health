<?xml version="1.0" encoding="iso-8859-1"?>
<!-- Área pública de MedicalVM -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output method="html" encoding="iso-8859-1" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd" doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN" indent="yes"/>

<xsl:template match="/">
<html xmlns="http://www.w3.org/1999/xhtml">
<!--
        Nueva pagina principal de medicalvm.com
        17dic16 ET
        Ultima revision: 20ene17 18:18
-->

<!--idioma-->
<xsl:variable name="lang">
        <xsl:choose>
        <xsl:when test="/AreaPublica/INDEXLANG != ''"><xsl:value-of select="/AreaPublica/INDEXLANG"/></xsl:when>
        <xsl:otherwise>spanish</xsl:otherwise>
        </xsl:choose>
</xsl:variable>
<xsl:variable name="doc">http://www.newco.dev.br/General/texts443_<xsl:value-of select="$lang"/>.xml</xsl:variable>
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
        <title><xsl:value-of select="document($doc)/translation/texts/item[@name=$AP_Titulo]/node()"/></title>
        <script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
        <!-- PS 20170623 <script type="text/javascript" src="http://www.newco.dev.br/General/login_18may17.js"></script>-->
        <script type="text/javascript" src="http://www.newco.dev.br/General/login_21jun17.js"></script>
        <link rel="shortcut icon" href="http://www.newco.dev.br/images/MedicalVM.ico"/>
        <meta name="description" content="Medical VM es la primera plataforma para crear centrales de compras a medida.">
                <xsl:attribute name="content"><xsl:value-of select="document($doc)/translation/texts/item[@name=$AP_metadescr]/node()"/></xsl:attribute>
        </meta>
<!-- 20180312   <link rel="stylesheet" href="http://www.newco.dev.br/General/areapublica443.css" type="text/css"/> -->
                <link rel="stylesheet" href="http://www.newco.dev.br/General/areapublica443CR.css" type="text/css"/>
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

       <title>
        <xsl:value-of select="document($doc)/translation/texts/item[@name='central_compras']/node()"/>&nbsp;-&nbsp;
        <xsl:value-of select="document($doc)/translation/texts/item[@name='compras_residencias']/node()"/>
      </title>
       
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1"/>
 	<!--<META HTTP-EQUIV="Pragma" CONTENT="no-caché"/>-->
	<meta content="ALL" name="ROBOTS"/>	
	<meta name="description" content="Compras residencias es una web para la compra de material medico para residencias."/> 


      
		<link rel="shortcut icon" href="http://www.comprasresidencias.com/images/ComprasResidenciasIco.ico"/>	
		<link rel="stylesheet" href="http://www.comprasresidencias.com/General/basicPublic.css" type="text/css"/>
		
        <script type="text/javascript" src="http://www.comprasresidencias.com/General/jquery-1.8.3.js"></script>
		<script type="text/javascript" src="http://www.comprasresidencias.com/General/jquery-ui.js"></script>
		<script type="text/javascript" src="http://www.comprasresidencias.com/General/jquery-ui-tabs-rotate.js"></script>
                <script type="text/javascript" src="http://www.comprasresidencias.com/General/basic_180608.js"></script>
                
        <link rel="stylesheet" href="http://www.comprasresidencias.com/General/featured-content-slider/style.css" type="text/css" media="screen"/>
        
        <script type="text/javascript">
		
                function AceptaCookie(){
                        var aceptoCookie = GetCookie('ACEPTO_COOKIE');
                        if (aceptoCookie == '' || aceptoCookie == null) {
                                   //si no ha aceptado lo de los coockie pongo aviso
                                   document.getElementById("avisoCookieBox").style.display = 'block';
                           }
		}
	</script>
        
        <script type="text/javascript">
		jQuery(document).ready(function(){
			jQuery("#featured").tabs({
				fx: {opacity: "toggle"},
				active: 0,
				beforeLoad: function(event, ui){
					if(jQuery(ui.panel.selector).html()){    // If content already there...
						event.preventDefault();      // ...don't load it again.
					}
				}
			}).tabs("rotate", 5000, true);

			jQuery("#featured").hover(
				/*function() {
					jQuery("#featured").tabs("rotate",0,true);
				},*/
				function() {
					jQuery("#featured").tabs("rotate",5000,true);
				}
			);

		});
            
             function MenuExplorerPublic(){
            
                         var browserName=navigator.appName; 
                       // alert('mi '+browserName);
                        if (browserName=="Microsoft Internet Explorer") { 
                            jQuery(".menuBox a").css('font-size','18px');
                            jQuery(".menuBox a").css('font-family','Arial');
                            jQuery(".menuBox a").css('font-weight','bold');
                            jQuery(".menuBox a").css('padding-left','15px');
                            jQuery(".menuBox a").css('padding-right','15px');
                            jQuery(".menuBox a").css('padding-top','6px');
                            jQuery(".menuBox a").css('padding-bottom','11px');
                            
                            jQuery(".menu").css('height','29px');
                            jQuery(".menu").css('padding-top','6px');
                            jQuery(".menu").css('padding-left','0px');
                        }//fin de if browsername
                        else if (/MSIE (\d+\.\d+);/.test(navigator.userAgent)){ //test for MSIE x.x;
                            var ieversion=new Number(RegExp.$1) // capture x.x portion and store as a number
                            if (ieversion>=5){
                                    jQuery(".menuBox a").css('font-size','18px');
                                    jQuery(".menuBox a").css('font-family','Arial');
                                    jQuery(".menuBox a").css('font-weight','bold');
                                    jQuery(".menuBox a").css('padding-left','15px');
                                    jQuery(".menuBox a").css('padding-right','15px');
                                    jQuery(".menuBox a").css('padding-top','6px');
                                    jQuery(".menuBox a").css('padding-bottom','11px');

                                    jQuery(".menu").css('height','29px');
                                    jQuery(".menu").css('padding-top','6px');
                                    jQuery(".menu").css('padding-left','0px');
                            }                          
                       }//fin else if ieversion
		}
	</script>
        
        <script>
(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
})(window,document,'script','//www.google-analytics.com/analytics.js','ga');

  ga('create', 'UA-64519488-5', 'auto');
  ga('send', 'pageview');

</script>

   </head>
      
      <body onload="AceptaCookie(); MenuExplorerPublic();">	
        <!--idioma-->
        <xsl:variable name="lang">
        	<xsl:value-of select="/AreaPublica/LANG" />
        </xsl:variable>
        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
        <!--fin idioma-->
        
        <xsl:choose>
			<!-- Error en alguna sentencia del XSQL -->
			<xsl:when test="AreaPublica/xsql-error">
			<xsl:apply-templates select="AreaPublica/xsql-error"/>        
			</xsl:when>
		<xsl:otherwise>
	
                    <div class="avisoCookieBox" id="avisoCookieBox" style="display:none;">
                        <div class='avisoCookie'>
                                <xsl:copy-of select="document($doc)/translation/texts/item[@name='aviso_cookies_residencias']/node()"/>
                        </div>
                    </div><!--fin de avisoCookieBox-->
        
    	<!--	/AreaPublica	-->
      	<div class="todo">
        
            <div class="header">
<!-- 20180319
            	 <div class="logo">
                        <a href="http://www.comprasresidencias.com" title="Compras Residencias">
                            <img src="http://www.comprasresidencias.com/images/logoComprasResidencias.jpg" alt="Compras Residencias"/>
                        </a>
                  </div>
-->
                    <div class="textHeader">
                        <h2><xsl:value-of select="document($doc)/translation/texts/item[@name='optimizamos_su_proceso_de_compras']/node()"/></h2>
                    </div>
            </div><!--fin de header-->
        	
            <div class="menuBox">
             <div class="menu">
            	<!-- 20180319 <a href="http://www.comprasresidencias.com/index.html" class="select">-->
		<a href="http://www.newco.dev.br/indexCR443.xsql?PORTAL=CR" class="select">
                  <xsl:attribute name="title"><xsl:value-of select="document($doc)/translation/texts/item[@name='inicio']/node()"/></xsl:attribute>
                	 <xsl:value-of select="document($doc)/translation/texts/item[@name='inicio']/node()"/>
                </a>
            	 <a href="http://www.comprasresidencias.com/QuienesSomos.xsql">
                  <xsl:attribute name="title"><xsl:value-of select="document($doc)/translation/texts/item[@name='quienes_somos']/node()"/></xsl:attribute>
                	 <xsl:value-of select="document($doc)/translation/texts/item[@name='quienes_somos']/node()"/>
                </a>
                <a href="http://www.comprasresidencias.com/ComoTrabajamos.xsql">
                  <xsl:attribute name="title"><xsl:value-of select="document($doc)/translation/texts/item[@name='como_trabajamos']/node()"/></xsl:attribute>
                	 <xsl:value-of select="document($doc)/translation/texts/item[@name='como_trabajamos']/node()"/>
                </a>
                 <a href="http://www.comprasresidencias.com/Contacto.xsql">
                	<xsl:attribute name="title"><xsl:value-of select="document($doc)/translation/texts/item[@name='contacto']/node()"/></xsl:attribute>
                 <xsl:value-of select="document($doc)/translation/texts/item[@name='contacto']/node()"/>
                </a>
            </div><!--fin de menu-->
            </div><!--fin de menuBox-->
            
            <div class="todoInside">
            	
                <div class="arribaBox">
                
                    <div class="slideBox">
                    	<div id="idInicio"></div>
                        <!-- inicio SLIDER -->
                        <div id="slider-wrapper">
                         <div id="featured" >
                        	<ul class="ui-tabs-nav" style="display:none;">  
                            <li class="ui-tabs-nav-item" id="nav-ui-tabs-1"><a href="#ui-tabs-1"><img src="http://www.comprasresidencias.com/images/clinicaHomeResidencias.jpg"/></a></li>
                            <li class="ui-tabs-nav-item" id="nav-ui-tabs-2"><a href="#ui-tabs-2"><img src="http://www.newco.dev.br/images/productosHome.jpg"/></a></li>
                            <li class="ui-tabs-nav-item" id="nav-ui-tabs-3"><a href="#ui-tabs-3"><img src="http://www.newco.dev.br/images/catalogoHome.jpg"/></a></li>
							<li class="ui-tabs-nav-item" id="nav-ui-tabs-4"><a href="#ui-tabs-4"><img src="http://www.newco.dev.br/images/pedidosHome.jpg"/></a></li>
                            <li class="ui-tabs-nav-item" id="nav-ui-tabs-5"><a href="#ui-tabs-5"><img src="http://www.newco.dev.br/images/ahorroHome.jpg"/></a></li>
							</ul>
                        <!-- First Content -->
						<div id="ui-tabs-1" class="ui-tabs-panel">
							<img src="http://www.comprasresidencias.com/images/clinicaHomeResidencias.jpg" alt="Clinica" />
							<div class="info">
								<h2><xsl:value-of select="document($doc)/translation/texts/item[@name='slide_text1_residencias']/node()"/></h2>
							</div>
						</div>
                        <!-- Second Content -->
						<div id="ui-tabs-2" class="ui-tabs-panel">
							<img src="http://www.newco.dev.br/images/productosHome.jpg" alt="Informes productos" />
							<div class="info">
								<h2><xsl:value-of select="document($doc)/translation/texts/item[@name='slide_text2']/node()"/></h2>
							</div>
						</div>

						<!-- Third Content -->
						<div id="ui-tabs-3" class="ui-tabs-panel">
							<img src="http://www.newco.dev.br/images/catalogoHome.jpg" alt="Catalogo pedidos" />
							<div class="info">
								<h2><xsl:value-of select="document($doc)/translation/texts/item[@name='slide_text3']/node()"/></h2>
							</div>
						</div>

                        <!-- Fourth Content -->
						<div id="ui-tabs-4" class="ui-tabs-panel">
							<img src="http://www.newco.dev.br/images/pedidosHome.jpg" alt="Seguimiento pedidos" />
							<div class="info">
								<h2><xsl:value-of select="document($doc)/translation/texts/item[@name='slide_text4']/node()"/></h2>
							</div>
						</div>
                        
                        <!-- Fifth Content -->
						<div id="ui-tabs-5" class="ui-tabs-panel">
							<img src="http://www.newco.dev.br/images/ahorroHome.jpg" alt="Informes" />
							<div class="info">
								<h2><xsl:value-of select="document($doc)/translation/texts/item[@name='slide_text5']/node()"/></h2>
							</div>
						</div>

                        </div><!--fin de featured-->
					</div><!--fin de slider-wrapper-->
				<!-- fin SLIDER -->
                    </div><!--fin de slideBox-->
                   
<!-- 20180319 
                    <div class="loginBox">
                    	<IFRAME src="http://www.newco.dev.br/frameResidencias.html" name="frameResidencias" id="frameResidencias" width="270" height="350" scrolling="no" frameborder="0" marginwidth="0" style="margin-top:1px;">
  						</IFRAME>
                    </div> --><!--fin de loginBox-->
                	
                    
                </div><!--fin de arriba Box-->
                
                <div class="medioBox">
                
                    <div class="clientesBox">
                    	<div class="medioBoxInside">
                             <h2>
                            	<xsl:value-of select="document($doc)/translation/texts/item[@name='clientes']/node()"/>
                           </h2>
                            <xsl:copy-of select="document($doc)/translation/texts/item[@name='clientes_text_home_residencias']/node()"/>
                        </div>
                     
                    </div><!--fin de clientesBox-->
                    
                    <div class="proveedoresBox">
                    	<div class="medioBoxInside">
                    		<h2>
                            	<xsl:value-of select="document($doc)/translation/texts/item[@name='proveedores']/node()"/>
                            </h2>
                            <xsl:copy-of select="document($doc)/translation/texts/item[@name='proveedores_text_home_residencias']/node()"/>
                        </div>
                       
                    </div><!--fin de proveedoresBox-->
                	
                </div><!--fin de medio Box-->
                <p>&nbsp;</p>
                <p>&nbsp;</p>
            </div><!--fin de todoInside-->
            
            
        </div><!--fin de todo-->
        
         <div class="footerBox">
        	<div class="footer">
            	<xsl:copy-of select="document($doc)/translation/texts/item[@name='footer_text_residencias']/node()"/>
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
