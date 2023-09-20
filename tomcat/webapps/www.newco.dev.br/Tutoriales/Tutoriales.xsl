<?xml version="1.0" encoding="iso-8859-1" ?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href = "http://www.newco.dev.br/General/General.xsl" />
  <xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
  <xsl:param name="lang" select="@lang"/>  
  <xsl:template match="/">
    <html>
      <head>
      
	<title>Tutoriales de MedicalVM</title>
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
      <!--style-->
      <xsl:call-template name="estiloIndip"/>
      <!--fin de style -->  
	 <script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
	 <script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>
	
      </head>
      <body class="gris">
       <xsl:choose>
			<!-- Error en alguna sentencia del XSQL -->
			<xsl:when test="Tutoriales/xsql-error">
			<xsl:apply-templates select="Tutoriales/xsql-error"/>        
			</xsl:when>
			<xsl:otherwise>
        
      	<h1 class="titlePage">Tutoriales</h1>
        
        <div class="divLeft">
         
         <table class="azul">
         	
            <tr>
            	<td class="cuarenta">&nbsp;</td>
            	<td>
                	<a>
                	<xsl:attribute name="href">
                    	<xsl:value-of select="Tutoriales/ROW/URL"/>
                    </xsl:attribute>
                    
                    >&nbsp;<xsl:value-of select="Tutoriales/ROW/NOMBRE"/></a>
                </td>
            </tr>
         </table>
    	</div><!--fin de divleft-->
        
          </xsl:otherwise>
      </xsl:choose>
      </body>
    </html>
  </xsl:template>  
  

</xsl:stylesheet>
