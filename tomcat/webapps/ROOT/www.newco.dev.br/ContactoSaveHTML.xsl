<?xml version="1.0" encoding="iso-8859-1" ?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href = "http://www.newco.dev.br/General/General.xsl" />
  <xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
  <xsl:param name="lang" select="@lang"/>
 
<xsl:template match="/ContactoSave">
[
	<xsl:choose>
		<xsl:when test="OK">
				{
				"enviado": "Gracias por contactar con MedicalVM. Le responderemos lo antes posible."
				}
		</xsl:when>
        <xsl:when test="ERROR">
				{
				"enviado": "Se ha producido un error al enviar el formulario"
				}
		</xsl:when>
</xsl:choose>

]
</xsl:template>
</xsl:stylesheet>
	<!---->