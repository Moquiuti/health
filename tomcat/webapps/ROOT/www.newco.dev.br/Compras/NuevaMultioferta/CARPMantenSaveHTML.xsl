<?xml version="1.0" encoding="iso-8859-1"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href = "http://www.newco.dev.br/General/General.xsl" />
  <xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
  <xsl:param name="lang" select="@lang"/>  
  <xsl:template match="/">
    <html>
      <head>
      <xsl:text disable-output-escaping="yes"><![CDATA[
      <link rel="stylesheet" href="http://www.newco.dev.br/General/Estilos.css" type="text/css">
      <script type="text/javascript">
      <!--
      	   function ActualizarBotonera(){
      	   	parent.frames['botonera'].location=parent.frames['botonera'].location;
      	   }
      
      //-->
      </script>       
      ]]></xsl:text> 
      </head>
        <!--
         |   Lo hacemos saltar a la página de lista de productos.
         |	Solo cuando no hay error!
         +-->
      
    <body bgcolor="#FFFFFF">
      
    <xsl:choose>
       <xsl:when test="//SESION_CADUCADA">
         <xsl:apply-templates select="//SESION_CADUCADA"/>     
       </xsl:when>
       <xsl:when test="//xsql-error">
         <xsl:apply-templates select="//xsql-error"/>     
       </xsl:when>
       <xsl:when test="//Status">
         <xsl:apply-templates select="//Status"/>
       </xsl:when>
       <xsl:otherwise>
       
       <xsl:variable name="accion"><xsl:value-of select="Plantilla/MAIN/ACCION"/></xsl:variable>
       <!--
        |	Atributos de <BODY>
        |
        +-->
       
       <xsl:choose>
	     <xsl:when test="$accion='CABECERA' or $accion='COPIAR'">
               <xsl:attribute name="onLoad">top.mainFrame.location.href='../NuevaMultioferta/Unica.html'</xsl:attribute>	       	       
	     </xsl:when>
	     <xsl:otherwise>
	       <xsl:attribute name="onLoad">top.mainFrame.location.href='../NuevaMultioferta/Unica.html'</xsl:attribute>
             </xsl:otherwise>
       </xsl:choose>
       
       <!--
        |	Construimos el formulario que enviaremos automaticamente. Con:
        |	- action
        |	- target
        |	- campos hidden
        +-->

         <form method="POST">
	        <xsl:choose>
	          <xsl:when test="$accion='NUEVA' or $accion='COPIAR'">
	             <xsl:attribute name="action">http://www.newco.dev.br/Compras/NuevaMultioferta/CambioPlantilla.xsql</xsl:attribute>
	             <xsl:attribute name="target">mainFrame</xsl:attribute>

	             <input type="hidden" name="PL_ID" value="{Plantilla/MAIN/PL_ID}"/>
	          </xsl:when>
	          <xsl:when test="$accion='CABECERA'">
	             <xsl:attribute name="action">http://www.newco.dev.br/Compras/Multioferta/LPLista.xsql</xsl:attribute>
	             <input type="hidden" name="LP_ID" value="{Plantilla/MAIN/LP_ID}"/>
	          </xsl:when>
	          <xsl:otherwise>
	             <xsl:attribute name="action">http://www.newco.dev.br/Compras/Multioferta/LPLista.xsql</xsl:attribute>
	             <input type="hidden" name="LP_ID" value="{Plantilla/MAIN/LP_ID}"/>
	          </xsl:otherwise>
	        </xsl:choose>
          </form>
     
       </xsl:otherwise>
      </xsl:choose>      
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
