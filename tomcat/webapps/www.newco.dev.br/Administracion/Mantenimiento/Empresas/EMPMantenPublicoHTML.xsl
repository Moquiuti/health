<?xml version="1.0" encoding="iso-8859-1" ?>
<!-- 
	Siguientes pasos del alta de empresas
	ultima revision	ET 8jun21 10:45
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href = "http://www.newco.dev.br/General/General.xsl" />
  <xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
  <xsl:param name="lang" select="@lang"/>
  <xsl:template match="/">  
    <html>
      <head> 
      
		<!--style-->
		<xsl:call-template name="estiloIndip"/>
		<!--fin de style-->  

		<xsl:variable name="lang">
		<xsl:choose>
			<xsl:when test="/Empresa/LANG"><xsl:value-of select="/Empresa/LANG" /></xsl:when>
			<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>  
		</xsl:variable>

		<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>      <!--idioma fin-->
		
		<title><xsl:value-of select="/Empresa/EMPRESA/PORTAL" />:&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='nueva_empresa']/node()"/></title>

		<script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
		<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>
		<!--<script type="text/javascript" src="http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPNueva_060318.js"></script>-->
		<script type="text/javascript">
		IDSesion='<xsl:value-of select="/Empresa/EMPRESA/SES_ID" />';
		
		strErrorSesion='<xsl:value-of select="document($doc)/translation/texts/item[@name='sesion_caducada']/node()"/>';
		
		function onLoad()
		{
			debug('onLoad. IDSesion:'+IDSesion);
			if (IDSesion!='')
				SetCookie('SES_ID', IDSesion);
			else
				alert(strErrorSesion);
		}

		// Creacion de una cookie con nombre sName y valor sValue
		function SetCookie(sName, sValue)
		{ 
			//solodebug 	
			console.log('SetCookie name:'+sName+' value:'+sValue);

			var dominio='http://www.newco.dev.br';
			document.cookie = sName + "=" + escape(sValue) + ";host='+dominio+';path=/;SameSite=Strict;";	
		}	
	</script>
	  
	  </head>

      <body onLoad="javascript:onLoad();">
      <xsl:choose>
          <xsl:when test="//xsql-error">
            <xsl:apply-templates select="//xsql-error"/>        
          </xsl:when>
          <xsl:when test="//SESION_CADUCADA">
            <xsl:for-each select="//SESION_CADUCADA">
              <xsl:if test="position()=last()">
                <xsl:apply-templates select="."/>
              </xsl:if>
            </xsl:for-each>        
          </xsl:when>
          <xsl:otherwise>    
			<xsl:apply-templates select="Empresa"/> 
        </xsl:otherwise>
        </xsl:choose>	 
      </body>
    </html>
  </xsl:template>

<!--
 |  Templates
 +-->

<xsl:template match="Empresa">

<!--idioma-->
	<xsl:variable name="lang">
	<xsl:choose>
		<xsl:when test="/Empresa/LANG"><xsl:value-of select="/Empresa/LANG" /></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
	</xsl:choose>  
	</xsl:variable>

	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>      <!--idioma fin-->

	<form name="frmEmpresa"  method="post">
	
	<!--	Titulo de la página		-->
	<div class="ZonaTituloPagina">
		<p class="Path"><xsl:value-of select="document($doc)/translation/texts/item[@name='Inicio']/node()"/>&nbsp;/&nbsp;<span class="FinPath"><xsl:value-of select="document($doc)/translation/texts/item[@name='nueva_empresa']/node()"/></span></p>
		<p class="TituloPagina">
        	<xsl:value-of select="document($doc)/translation/texts/item[@name='nueva_empresa']/node()"/>
       		&nbsp;&nbsp;
			<span class="CompletarTitulo">
				<!--	Botones	-->
        		<a class="btnDestacado"  href="javascript:EnviaNuevaEmpresa(document.forms['BuscaEmpresa'],'EMPNuevaSave.xsql?EMP_ID=0&amp;DESDE=Alta');">
            		<xsl:value-of select="document($doc)/translation/texts/item[@name='guardar']/node()"/>
            	</a>
				&nbsp;
        		<a class="btnNormal" href="javascript:document.location='about:blank'">
            		<xsl:value-of select="document($doc)/translation/texts/item[@name='cancelar']/node()"/>
            	</a>
				&nbsp;
			</span>
		</p>
	</div>
	</form>
</xsl:template>

</xsl:stylesheet>
