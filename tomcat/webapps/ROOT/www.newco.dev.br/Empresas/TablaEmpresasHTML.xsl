<?xml version="1.0" encoding="iso-8859-1" ?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href = "http://www.newco.dev.br/General/General.xsl" />
  <xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
  <xsl:param name="lang" select="@lang"/>  
  <xsl:template match="/">

    <html>
      <head>
        <title>
          <xsl:choose>
            <xsl:when test="//OPCION[.='P']">
              <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='PRV-0010' and @lang=$lang]" disable-output-escaping="yes"/>
            </xsl:when>
            <xsl:when test="//OPCION[.='C']">
              <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='CLI-0010' and @lang=$lang]" disable-output-escaping="yes"/>
            </xsl:when>
          </xsl:choose>
        </title>
	<xsl:text disable-output-escaping="yes"><![CDATA[
	<link rel="stylesheet" href="http://www.newco.dev.br/General/Estilos.css" type="text/css">
	<script type="text/javascript" src="http://www.newco.dev.br/General/general.js">
	</script>
	<script type="text/javascript">
	 <!--
	  function rellenarCeldas(registros, columnas){
	    
	    document.write('<td>&nbsp;</td>');   
	    registros++
	    if(registros % columnas)
	      rellenarCeldas(registros, columnas);                
	  }
        
	 -->
	</script>       
        ]]></xsl:text>
      </head>
      <body bgcolor="#FFFFFF">      
        <xsl:choose>
          <xsl:when test="Generar/xsql-error">
             <xsl:apply-templates select="//xsql-error"/>          
          </xsl:when>
          <xsl:otherwise> 
      <table border="0" width="100%" cellpadding="0" cellspacing="0">
        <tr>
          <td>
            <!--<xsl:apply-templates select="//jumpTo"/>-->
            <xsl:call-template name="boton">
              <xsl:with-param name="path" select="//button[@label='Cerrar']"/>
            </xsl:call-template>
            <br/>
            <br/>
          </td>
        </tr>  
        <tr>
          <td>                  
	    <table width="100%" border="0" cellpadding="1" cellspacing="1"  class="muyoscuro">   
	      <tr class="medio">
	        <td colspan="3" align="center" class="tituloCol">
	          <xsl:choose>
                    <xsl:when test="//OPCION[.='P']">
                      <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='PRV-0010' and @lang=$lang]" disable-output-escaping="yes"/>
                    </xsl:when>
                    <xsl:when test="//OPCION[.='C']">
                      <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='CLI-0010' and @lang=$lang]" disable-output-escaping="yes"/>
                    </xsl:when>
                  </xsl:choose>
	        </td>
			</tr>
	      <tr class="blanco">
	        <xsl:variable name="numRegistros"><xsl:value-of select="count(/Proveedores/EMPRESA)"/></xsl:variable>
	        <xsl:variable name="columnas">3</xsl:variable>
	        <xsl:for-each select="/Proveedores/EMPRESA">  
	            <xsl:choose>
	                <xsl:when test="position() mod 2=0">
	                  <td width="33%">
	                    <xsl:element name="a"> 
	                      <xsl:attribute name="href">http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPDetalleFrame.xsql?EMP_ID=<xsl:value-of select="EMP_ID"/>&amp;VENTANA=ANTIGUA</xsl:attribute>
	                      <xsl:value-of select="EMP_NOMBRE"/>
	                    </xsl:element>
	                  </td>  
	                  <xsl:if test="position() mod $columnas=0">
	                    <script>
	                      javascript:document.write('<xsl:text disable-outputescaping="yes"><![CDATA[</tr><tr class="blanco">]]></xsl:text>');
	                    </script>
	                  </xsl:if> 
	                </xsl:when>
	                <xsl:otherwise>
	                  <td width="33%">
	                    <xsl:element name="a"> 
	                      <xsl:attribute name="href">http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPDetalleFrame.xsql?EMP_ID=<xsl:value-of select="EMP_ID"/>&amp;VENTANA=ANTIGUA</xsl:attribute>
	                      <xsl:value-of select="EMP_NOMBRE"/>
	                    </xsl:element>
	                  </td>  
	                  <xsl:if test="position() mod $columnas=0">
	                    <script>
	                      javascript:document.write('<xsl:text disable-outputescaping="yes"><![CDATA[</tr><tr class="claro">]]></xsl:text>');
	                    </script>
	                  </xsl:if> 
	                </xsl:otherwise>
	              </xsl:choose>     
                </xsl:for-each> 
                <xsl:if test="$numRegistros mod $columnas">
                  <script>
                    rellenarCeldas(<xsl:value-of select="$numRegistros"/>,<xsl:value-of select="$columnas"/>);         
                  </script>
                </xsl:if>
              </tr>	  
            </table>
          </td>
        </tr>
        <tr>
          <td>
            <!--<xsl:apply-templates select="//jumpTo"/>-->
            <br/><br/>
            <xsl:call-template name="boton">
              <xsl:with-param name="path" select="//button[@label='Cerrar']"/>
            </xsl:call-template>
          </td>
        </tr>  
      </table>
          </xsl:otherwise>
        </xsl:choose>
      </body>
    </html>
  </xsl:template>  
 
</xsl:stylesheet>
