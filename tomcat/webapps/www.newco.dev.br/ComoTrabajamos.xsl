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
        	<xsl:value-of select="/ClasificacionProveedores/LANG" />
        </xsl:variable>
        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
         <!--fin idioma-->
       <title>
        <xsl:value-of select="document($doc)/translation/texts/item[@name='central_compras_material_sanitario']/node()"/>&nbsp;-&nbsp;
        <xsl:value-of select="document($doc)/translation/texts/item[@name='clasificacion_proveedores']/node()"/>&nbsp;-&nbsp;
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
    
	<xsl:text disable-output-escaping="yes"><![CDATA[
	<link rel="stylesheet" href="http://www.newco.dev.br/General/basicPublic.css" type="text/css" />
     <script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>	
    <script type="text/javascript" src="http://www.newco.dev.br/General/loginNew_020914.js"></script>
    
        <script type="text/javascript">
		
		function verImage(id){
			jQuery(".imageTrabajo").hide();
			document.getElementById(id+'Box').style.display = 'block';
		}
		
		function cerrarImage(id){
			document.getElementById(id+'Box').style.display = 'none';
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
       <body onload="MenuExplorerPublic();">	
      
       <!--idioma-->
         <xsl:variable name="lang">
        <xsl:choose>
            <xsl:when test="/ClasificacionProveedores/LANG"><xsl:value-of select="/ClasificacionProveedores/LANG" /></xsl:when>
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
		
    <!--proveedores-->
		
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
                <xsl:with-param name="select"></xsl:with-param>
            </xsl:call-template>
            
            <div class="todoInside">
       
               <div class="zonaPublicaBox">
             	
                <h2>&nbsp;&nbsp;<xsl:copy-of select="document($doc)/translation/texts/item[@name='como_trabajamos']/node()"/></h2>
                
                <div class="comoTrabajamos">
                	<xsl:copy-of select="document($doc)/translation/texts/item[@name='como_trabajamos_text']/node()"/>
                </div>
                
                <!--control y an�lisis-->
                <div class="analisisBox">
                	<h3><!--<a href="javascript:verImage('analisis');">--><xsl:value-of select="document($doc)/translation/texts/item[@name='control_y_analisis']/node()"/></h3>
                </div>
                
                <div class="flechasDoblesBoxes">
                    <div class="flechaDobleBox marginRight"><img src="http://www.newco.dev.br/images/flechaEsquemasDoble.gif" alt="flecha"/></div>
                    <div class="flechaDobleBox marginRight"><img src="http://www.newco.dev.br/images/flechaEsquemasDoble.gif" alt="flecha"/></div>
                    <div class="flechaDobleBox marginRight"><img src="http://www.newco.dev.br/images/flechaEsquemasDoble.gif" alt="flecha"/></div>
                    <div class="flechaDobleBox"><img src="http://www.newco.dev.br/images/flechaEsquemasDoble.gif" alt="flecha"/></div>
                </div>
                
                <div class="trabajosBoxes">
                    <!--catalogacion-->
                    <div class="trabajoBox">
                            <h3><a href="javascript:verImage('catalogacion');"><xsl:value-of select="document($doc)/translation/texts/item[@name='catalogacion']/node()"/></a></h3>
                    </div>
                    <div class="flechaBox"><img src="http://www.newco.dev.br/images/flechaEsquemas.gif" alt="flecha"/></div>

                    <!--evaluacion-->
                    <div class="trabajoBox">
                            <h3><a href="javascript:verImage('evaluacion');"><xsl:value-of select="document($doc)/translation/texts/item[@name='evaluacion']/node()"/></a></h3>
                    </div>
                    <div class="flechaBox"><img src="http://www.newco.dev.br/images/flechaEsquemas.gif" alt="flecha"/></div>

                    <!--negociacion-->
                    <div class="trabajoBox">
                            <h3><a href="javascript:verImage('negociacion');"><xsl:value-of select="document($doc)/translation/texts/item[@name='negociacion']/node()"/></a></h3>
                    </div>
                    <div class="flechaBox"><img src="http://www.newco.dev.br/images/flechaEsquemas.gif" alt="flecha"/></div>

                    <!--operaciones-->
                    <div class="trabajoBox">
                            <h3><a href="javascript:verImage('operaciones');"><xsl:value-of select="document($doc)/translation/texts/item[@name='operaciones']/node()"/></a></h3>
                    </div>
                </div>
                
                <p>&nbsp;</p>
       			<p>&nbsp;</p>
                
               </div><!--fin de zonapublicabox-->
               
               <div class="zonaPublicaBox">
               <div id="catalogacionBox" class="imageTrabajo" style="display:none;">
                	<p class="cerrar">
                    	<a href="javascript:cerrarImage('catalogacion');"><xsl:copy-of select="document($doc)/translation/texts/item[@name='cerrar']/node()"/></a>&nbsp;&nbsp;
                        <a href="javascript:cerrarImage('catalogacion');"><img src="http://www.newco.dev.br/images/cerrar.gif" alt="cerrar"/></a></p>
                    <h3><xsl:value-of select="document($doc)/translation/texts/item[@name='catalogacion']/node()"/></h3>
                	<p class="princi"><img src="http://www.newco.dev.br/images/esquemaCatalogacion.gif" alt="Esquema Funcionalidad"/></p>
                </div>   
                
                <div id="negociacionBox" class="imageTrabajo" style="display:none;">
                	<p class="cerrar">
                    	<a href="javascript:cerrarImage('negociacion');"><xsl:copy-of select="document($doc)/translation/texts/item[@name='cerrar']/node()"/></a>&nbsp;&nbsp;
                    	<a href="javascript:cerrarImage('negociacion');"><img src="http://www.newco.dev.br/images/cerrar.gif" alt="cerrar"/></a>
                    </p>
                    <h3><xsl:value-of select="document($doc)/translation/texts/item[@name='negociacion']/node()"/></h3>
                	<p class="princi"><img src="http://www.newco.dev.br/images/esquemaNegociacion.gif" alt="Esquema Funcionalidad"/></p>
                </div>  
                
                 <div id="evaluacionBox" class="imageTrabajo" style="display:none;">
                	<p class="cerrar">
                    	<a href="javascript:cerrarImage('evaluacion');"><xsl:copy-of select="document($doc)/translation/texts/item[@name='cerrar']/node()"/></a>&nbsp;&nbsp;
                        <a href="javascript:cerrarImage('evaluacion');"><img src="http://www.newco.dev.br/images/cerrar.gif" alt="cerrar"/></a>
                    </p>
                    <h3><xsl:value-of select="document($doc)/translation/texts/item[@name='evaluacion']/node()"/></h3>
                	<p class="princi"><img src="http://www.newco.dev.br/images/esquemaEvaluacion.gif" alt="Esquema Funcionalidad"/></p>
                </div>     
                
                <div id="operacionesBox" class="imageTrabajo" style="display:none;">
                	<p class="cerrar">
                    	<a href="javascript:cerrarImage('operaciones');"><xsl:copy-of select="document($doc)/translation/texts/item[@name='cerrar']/node()"/></a>&nbsp;&nbsp;
                    	<a href="javascript:cerrarImage('operaciones');"><img src="http://www.newco.dev.br/images/cerrar.gif" alt="cerrar"/></a>
                    </p>
                    <h3><xsl:value-of select="document($doc)/translation/texts/item[@name='operaciones']/node()"/></h3>
                	<p class="princi"><img src="http://www.newco.dev.br/images/esquemaFuncionalidad.gif" alt="Esquema Funcionalidad"/></p>
                </div>    
                
                </div><!--fin de zonapublicabox-->
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