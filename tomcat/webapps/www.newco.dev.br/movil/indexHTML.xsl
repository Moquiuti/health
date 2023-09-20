<?xml version="1.0" encoding="iso-8859-1"?>
<!--  Área pública de MedicalVM   -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href="http://www.newco.dev.br/General/General.xsl" />
  <xsl:param name="usuario" select="@US_ID"/>  
  <xsl:template match="/">
    <html>
      <head>
         <!--idioma-->
        <!--idioma-->
         <xsl:variable name="lang">
        <xsl:choose>
            <xsl:when test="/AreaPublica/LANG"><xsl:value-of select="/AreaPublica/LANG" /></xsl:when>
            <xsl:otherwise>spanish</xsl:otherwise>
            </xsl:choose>  
        </xsl:variable>

        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>      <!--idioma fin-->
        <!-- fin idioma-->
       <title>
        <xsl:value-of select="document($doc)/translation/texts/item[@name='central_compras_material_sanitario']/node()"/>&nbsp;-&nbsp;
        <xsl:value-of select="document($doc)/translation/texts/item[@name='medicalvm']/node()"/>&nbsp;-&nbsp;Movil
      </title>
      
       
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1"/>
   
		<link rel="shortcut icon" href="http://www.newco.dev.br/images/MedicalVM.ico"/>	

	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->


   		<script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
		<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>
		<script type="text/javascript" src="http://www.newco.dev.br/General/utilidades.js"></script>
        <script type="text/javascript" src="http://www.newco.dev.br/movil/loginMovil.js"></script>
        
        
	<xsl:text disable-output-escaping="yes">
    	<![CDATA[

		<script type="text/javascript">
          <!--
		function DetectaResolucion()
		{
			document.getElementById('RESOLUCION').value = screen.width + 'x' +screen.height;
		}
        
           //-->
		</script>
		
        ]]></xsl:text>
        
      </head>
      
      <body onLoad="javascript:DetectaResolucion(); EliminaCookies();">	
      
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
            <div class="loginMovil" style="font-size:14px;">
                <form name="Login"  method="post" target="_self">
                    <input type="hidden" id="RESOLUCION" name="RESOLUCION" value="" />
                    <input type="hidden" id="LANG" name="LANG" value="{/AreaPublica/LANG}" />
          			<input type="hidden" name="PARAMETRO"/>

                    <p><xsl:value-of select="document($doc)/translation/texts/item[@name='usuario']/node()"/></p>
                    <p><input type="text" name="USER" class="intext" onClick="this.select();" onFocus="this.select();" /></p>
                    <p><xsl:value-of select="document($doc)/translation/texts/item[@name='password']/node()"/></p>
					<p><input type="password" name="PASS" class="intext" onClick="this.select();" onFocus="this.select();" /></p>
                </form>
				<p><input type="image" name="Submit" id="Submit" class="buttonLogin" value="Entrar" src="http://www.newco.dev.br/images/buttonEntrarAzul.gif" /></p>
            </div><!--fin de login-->
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