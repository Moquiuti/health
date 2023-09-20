<?xml version="1.0" encoding="iso-8859-1"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:import href="http://www.newco.dev.br/General/General.xsl"/>
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="lang" select="@lang"/>
<xsl:param name="usuario" select="@US_ID"/>

<xsl:template match="/">
<html>
<head>
	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->

	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>

	<script type="text/javascript">
		function ListadosAjaxExcel(meses){
			jQuery.ajax({
				url:	'ListadosPersonalizadosExcel.xsql',
				type:	"GET",
				data:	"MESES="+meses,
				contentType: "application/xhtml+xml",
				error: function(objeto, quepaso, otroobj){
					alert('error'+quepaso+' '+otroobj+''+objeto);
				},
				success: function(objeto){
					var data = eval("(" + objeto + ")");
					if(data.estado == 'ok') window.location='http://www.newco.dev.br/Descargas/'+data.url;
					else alert('Se ha producido un error. No se puede descargar el fichero.');
				}
			});
		}
	</script>
</head>
<body>
	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:value-of select="/ListadosPersonalizados/lang"/>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<div class="divLeft margin25">
		<p><a href="javascript:ListadosAjaxExcel(0);"><xsl:value-of select="document($doc)/translation/texts/item[@name='excel_lineas_pedido_1mes']/node()"/></a></p>
		<p><a href="javascript:ListadosAjaxExcel(3);"><xsl:value-of select="document($doc)/translation/texts/item[@name='excel_lineas_pedido_3meses']/node()"/></a></p>
	</div>
</body>
</html>
</xsl:template>
</xsl:stylesheet>