<?xml version="1.0" encoding="iso-8859-1"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:import href = "http://www.newco.dev.br/General/General.xsl"/>
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>

<xsl:template match="/">
<html>
<head>
	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->

	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery-1.8.3.min.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>

<xsl:text disable-output-escaping="yes"><![CDATA[
	<script type="text/javascript">
	<!--

		function ejecutarFuncionDelFrame(elFrame,parametro){
			elFrame.CambioCentroActual(parametro);
		}

		function RecargarFrames(cen_id){
                        alert(cen_id);
			ejecutarFuncionDelFrame(obtenerFrame(top,'zonaEmpresa'),cen_id);
    console.log()
			document.location='about:blank';
		}
	//-->
	</script>
]]></xsl:text>
</head>

<body>
<xsl:choose>
<xsl:when test="Mantenimiento/NUEVO">
    <xsl:value-of select="Mantenimiento/form/EMP_ID"/>
    
    <xsl:value-of select="Mantenimiento/form/Centro/CEN_ID"/>
     
    <!--idioma-->
        <xsl:variable name="lang">
            <xsl:value-of select="/Mantenimiento/LANG" />
        </xsl:variable>
        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
    <!--idioma fin-->
    
     <h1 class="titlePage">
 	<xsl:value-of select="document($doc)/translation/texts/item[@name='se_ha_realizado_correctamente_alta_centro']/node()"/>&nbsp;
     </h1>
     <br /><br />

     <center>
         <div class="botonCenter">
            <a href="javascript:RecargarFrames('{Mantenimiento/form/CENTRO/CEN_ID}');">
                <xsl:value-of select="document($doc)/translation/texts/item[@name='aceptar_minu']/node()"/>
            </a>
         </div>
     </center>
	<meta http-equiv="Refresh">
		<xsl:attribute name="content">0; URL=javascript:RecargarFrames(<xsl:value-of select="Mantenimiento/form/CENTRO/CEN_ID"/>);</xsl:attribute>
	</meta>
</xsl:when>
<xsl:otherwise>
	<xsl:apply-templates select="MantenimientoSave/Status"/>
	<xsl:apply-templates select="MantenimientoSave/xsql-error"/>
</xsl:otherwise>
</xsl:choose>
</body>
</html>
</xsl:template>
</xsl:stylesheet>