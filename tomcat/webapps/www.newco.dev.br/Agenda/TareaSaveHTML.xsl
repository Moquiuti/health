<?xml version="1.0" encoding="iso-8859-1" ?>
<!--
 |	
 |
 |	
 |	
 +-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:import href = "http://www.newco.dev.br/General/General.xsl" />
  <xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
  <xsl:param name="lang" select="@lang"/>  
  <xsl:template match="/">
    <html>
      <head>
        <title>Nueva consulta</title>
              
        <xsl:text disable-output-escaping="yes"><![CDATA[
	<link rel="stylesheet" href="http://www.newco.dev.br/General/Estilos.css" type="text/css"/>
        <script type="text/javascript" src="http://www.newco.dev.br/General/general.js">
        </script>
	<SCRIPT type="text/javascript">
	<!--
	  function CerrarVentana(){
      ]]></xsl:text>
        <xsl:choose>
          <xsl:when test="NuevoAnuncio/VENTANA='NUEVA'">
      <xsl:text disable-output-escaping="yes"><![CDATA[  
            if(window.parent.opener && !window.parent.opener.closed){
              Refresh(window.opener.document);
            }
            window.close(); 
       ]]></xsl:text> 
          </xsl:when>
          <xsl:otherwise>
            document.location.href='http://www.newco.dev.br/Agenda/AgendaDiaria.xsql?FECHAACTIVA=<xsl:value-of select="/NuevoAnuncio/DIAINICIOPREVISTO"/>&amp;IDUSUARIOAGENDA=<xsl:value-of select="/NuevoAnuncio/IDUSUARIORESPONSABLE"/>';
          </xsl:otherwise>
        </xsl:choose>
      <xsl:text disable-output-escaping="yes"><![CDATA[       
    }
	  
	  function RefrescarFrames(){
            var objFrame=new Object();
            objFrame=obtenerFrame(top,'AgendaTrabajo');
            Refresh(objFrame.document);
            document.location.href='about:blank';
          }      			
	-->
	</SCRIPT>
	]]></xsl:text>
 
        
        <STYLE>.tituloPagForm {
	COLOR: #015e4b; FONT-FAMILY: Arial, Helvetica, Swiss, Geneva, Sans; FONT-SIZE: 14pt; FONT-WEIGHT: bold
}
.tituloForm {
	COLOR: #015e4b; FONT-SIZE: 10pt; FONT-WEIGHT: bold
}
.subTituloForm {
	COLOR: #018167; FONT-SIZE: 9pt; FONT-WEIGHT: bold
}
.textoForm {
	COLOR: #000000; FONT-SIZE: 10pt; FONT-WEIGHT: bold
}
.textoLegal {
	COLOR: #000000; FONT-SIZE: 8pt
}
.camposObligatorios { COLOR: #FF0000; FONT-SIZE: 10pt; FONT-WEIGHT: bold }
</STYLE>


  <xsl:if test="not(//xsql-error)">
    <xsl:choose>
    <xsl:when test="NuevoAnuncio/VENTANA!='NUEVA'">
      <meta http-equiv="Refresh">
        <xsl:attribute name="content">0; URL=http://www.newco.dev.br/Agenda/AgendaDiaria.xsql?FECHAACTIVA=<xsl:value-of select="/NuevoAnuncio/DIAINICIOPREVISTO"/>&amp;IDUSUARIOAGENDA=<xsl:value-of select="/NuevoAnuncio/IDUSUARIORESPONSABLE"/></xsl:attribute>
      </meta>
    </xsl:when>
    <xsl:otherwise>
      <meta http-equiv="Refresh">
        <xsl:attribute name="content">0; URL=javascript:CerrarVentana();</xsl:attribute>
      </meta>
    </xsl:otherwise>
    </xsl:choose> 
  </xsl:if>

      </head>  
        <xsl:choose>
          <xsl:when test="//xsql-error"> 
          <P class="tituloform">     
            <xsl:apply-templates select="//xsql-error"/>
          </P>
          </xsl:when>
          <xsl:otherwise>

<!-- Cuerpo de la pagina HTML si no se ha producido ningun error -->

          
<body bgColor="#ffffff" leftMargin="0" topMargin="0" marginheight="0" marginwidth="0">
  <!--
  <xsl:if test="NuevoAnuncio/VENTANA='NUEVA'">
    <br/><br/><br/><br/><br/><br/><br/>
    <table width="70%" border="0" align="center">
      <tr>
        <td>
          <p align="center">La tarea ha sido guardada correctamente</p>
        </td>
      </tr>
      <tr align="center">
        <td>
          &nbsp;
        </td>
      </tr>
      <tr align="center">
        <td>
        -->
          <!--<xsl:apply-templates select="NuevoAnuncio/jumpTo"/>-->
          <!--
          <xsl:call-template name="boton">
	          <xsl:with-param name="path" select="//NuevoAnuncio/boton[@label='Cerrar']"/>
	        </xsl:call-template>
        </td>
      </tr>
    </table>
  </xsl:if>
  -->
</body>



 </xsl:otherwise>
 </xsl:choose>
 </html>
 </xsl:template>
 
 </xsl:stylesheet>