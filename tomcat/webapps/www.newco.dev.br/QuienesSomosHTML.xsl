<?xml version="1.0" encoding="iso-8859-1"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href="http://www.newco.dev.br/General/General.xsl" />
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

        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>      <!--idioma fin-->
       <title>
        <xsl:value-of select="document($doc)/translation/texts/item[@name='central_compras_material_sanitario']/node()"/>&nbsp;-&nbsp;
        <xsl:value-of select="document($doc)/translation/texts/item[@name='quienes_somos']/node()"/>&nbsp;-&nbsp;
        <xsl:value-of select="document($doc)/translation/texts/item[@name='medicalvm']/node()"/>
      </title>
     
       
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1"/>
 	<META HTTP-EQUIV="Pragma" CONTENT="no-cach�"/>
	<META HTTP-EQUIV="expired" CONTENT="01-Mar-94 00:00:01 GMT"/> 	
	<meta content="ALL" name="ROBOTS"/>	
	<META name="keywords" content="central, compras, sanidad, sanitario, cl�nica, hospital, equipamiento, m�dico, farmacia, farmac�utico,
	ASPIRADOR, BATA, BISTURI, BOLSA, BOMBA, CANULA, CATETER, CEPILLO, COMPRESA, 
	CUCHILLETE, DESFIBRILADOR, ECG, ELECTROCARDIOGRAFO, ELECTRODO, ESPECULO, ESPONJA, EXTRACTOR, FOLEY, GEL, GRAPADORA, GUANTE, INFUSION, 
	JABON, JERINGUILLA, LIPOSUCTOR, LOGO, LUER, LUMEN, LUZ, MASCARILLA, MESA, MONITOR, MONOFILAMENTO, NASAL, NYLON, OMNIPOR, PAPEL, PARCHE, 
	PERLADO, PILAS, PINZA, PROTESIS, RECOLECTOR, SILICONA, SONDA, SUTURA, TERMOMETRO"/> 
	<META name="description" content="Medical Virtual Market es la mayor central de compras virtual para las empresas del sector sanitario espa�ol."/> 
	<link rel="shortcut icon" href="http://www.newco.dev.br/images/MedicalVM.ico"/>
    
	
	<link rel="stylesheet" href="http://www.newco.dev.br/General/basicPublic.css" type="text/css"/>
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>
        <script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>	
        <script type="text/javascript" src="http://www.newco.dev.br/General/loginNew_020914.js"></script>
        <script type="text/javascript">
		
                function AceptaCookie(){
                        var aceptoCookie = GetCookie('ACEPTO_COOKIE');
                        if (aceptoCookie == '' || aceptoCookie == null) {
                                   //si no ha aceptado lo de los coockie pongo aviso
                                   document.getElementById("avisoCookieBox").style.display = 'block';
                           }
		}
            
	</script>
        <script>
   (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
     (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
   m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
   })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

     ga('create', 'UA-64519488-3', 'auto');
     ga('send', 'pageview');

   </script>    
      </head>
       <body onload="AceptaCookie(); MenuExplorerPublic();">		
		 <!--idioma-->
         <xsl:variable name="lang">
        <xsl:choose>
            <xsl:when test="/AreaPublica/LANG"><xsl:value-of select="/AreaPublica/LANG" /></xsl:when>
            <xsl:otherwise>spanish</xsl:otherwise>
            </xsl:choose>  
        </xsl:variable>

        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>      <!--idioma fin-->
		
        <xsl:choose>
			<!-- Error en alguna sentencia del XSQL -->
			<xsl:when test="AreaPublica/xsql-error">
			<xsl:apply-templates select="AreaPublica/xsql-error"/>        
			</xsl:when>
		<xsl:otherwise>
		<!--	/AreaPublica	-->
	<div class="avisoCookieBox" id="avisoCookieBox" style="display:none;">
            <div class='avisoCookie'>
                    <xsl:copy-of select="document($doc)/translation/texts/item[@name='aviso_cookies']/node()"/>
            </div>
        </div><!--fin de avisoCookieBox-->
                	
	<div class="todo">
        
            <div class="header">
                <div class="logo">
                        <a href="http://www.newco.dev.br" title="Medical Virtual Market">
                            <img src="http://www.newco.dev.br/images/logoMVM.gif" alt="Medical Virtual Market"/>
                        </a>
                    </div>
                    <div class="textHeader">
                        <h2><xsl:value-of select="document($doc)/translation/texts/item[@name='optimizamos_su_proceso_de_compras']/node()"/></h2>
                    </div>
            </div><!--fin de header-->
        	
            <xsl:call-template name="menuPublic"><!--en general.xsl-->
                <xsl:with-param name="select">quienes_somos</xsl:with-param>
            </xsl:call-template>
            
            <div class="todoInside">

            <!--Quienes Somos-->
			
             <div class="zonaPublicaBox text">
                <xsl:copy-of select="document($doc)/translation/texts/item[@name='quienes_somos_text1']/node()"/>
        	</div>
            <div class="zonaPublicaBox text">
                <xsl:copy-of select="document($doc)/translation/texts/item[@name='quienes_somos_text2']/node()"/>
            </div><!--fin de zonaPublicaBox-->
            
             <div class="zonaPublicaBox text">
                <xsl:copy-of select="document($doc)/translation/texts/item[@name='quienes_somos_text3']/node()"/>
            </div><!--fin de zonaPublicaBox-->
			
            </div><!--fin de todoInside-->
        </div><!--fin de todo-->
        
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