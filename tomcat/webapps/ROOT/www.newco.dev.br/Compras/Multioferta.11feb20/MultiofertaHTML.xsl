<?xml version="1.0" encoding="iso-8859-1" ?>
<!--
 | ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
 |
 | Fichero.......: MultiofertaHTML.xsl
 | Autor.........: Ferran Foz
 | Fecha.........: 19/06/2001
 | Descripcion...: .xsql genera un frameset: 100%->MainFrame 0%->form
 | Funcionamiento: un copy del HTML
 |
 |Modificaciones:
 |   Fecha       Autor          Modificacion
 |
 |
 |
 | Situacion: __Normal__
 |
 |(c) 2001 MedicalVM
 |///////////////////////////////////////////////////////////////////////////////////////////////////////////////////   
 +-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href = "http://www.newco.dev.br/General/General.xsl" />
  <xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
  <xsl:param name="lang" select="@lang"/>  
  <xsl:template match="/">
          <xsl:choose>
          <xsl:when test="//xsql-error">
              <xsl:apply-templates select="//xsql-error"/>
          </xsl:when>
          <xsl:otherwise>
		    <html>
		      <head><title>Multioferta</title>
		      </head>
		      <xsl:copy-of select="."/>      
		    </html>
          </xsl:otherwise>
          </xsl:choose>
  </xsl:template>

</xsl:stylesheet>
