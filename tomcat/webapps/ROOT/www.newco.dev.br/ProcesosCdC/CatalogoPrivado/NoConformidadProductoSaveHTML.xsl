<?xml version="1.0" encoding="iso-8859-1" ?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href = "http://www.newco.dev.br/General/General.xsl" />
  <xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
  <xsl:param name="lang" select="@lang"/>  
  <xsl:template match="/">

<html>
<head>
<title>Informe de no conformidad de producto</title>
  <xsl:text disable-output-escaping="yes"><![CDATA[
    <link rel="stylesheet" href="http://www.newco.dev.br/General/Estilos.css" type="text/css">
    <link rel="stylesheet" href="http://www.newco.dev.br/General/EstilosImprimir.css" type="text/css" media="print">
    <script language="javascript" src="http://www.newco.dev.br/General/general.js"></script>
    <script language="javascript">
      <!--  

        ]]></xsl:text>
          
          <xsl:choose>
            <xsl:when test="Mantenimiento/VENTANA='NUEVA'">
              
             function CerrarVentana(){
               if(window.parent.opener <xsl:text disable-output-escaping="yes"><![CDATA[&&]]></xsl:text> !window.parent.opener.closed){
                 var objFrameTop=new Object();    
                 objFrameTop=window.parent.opener.top;
                 var FrameOpenerName=window.parent.opener.name;
                 var objFrame=new Object();
                 objFrame=obtenerFrame(objFrameTop,FrameOpenerName);
                 if(objFrame!=null <xsl:text disable-output-escaping="yes"><![CDATA[&&]]></xsl:text> objFrame.recargarPagina){
                   objFrame.recargarPagina();
                 }
                 else{
                   Refresh(objFrame.document);
                 }  	
               }
               window.parent.close(); 
             }
 
            </xsl:when>
            <xsl:otherwise>
              
              function CerrarVentana(){
                window.parent.location.href='about:blank';
              }
            
            </xsl:otherwise>
          </xsl:choose>
           
        <xsl:text disable-output-escaping="yes"><![CDATA[
        
     //-->
    </script>
    ]]></xsl:text>
  </head>

<body bgcolor="#FFFFFF">
  <xsl:choose>
  <xsl:when test="//SESION_CADUCADA">
    <xsl:apply-templates select="//SESION_CADUCADA"/> 
  </xsl:when>
  <xsl:when test="//xsql-error">
    <xsl:apply-templates select="//xsql-error"/>
  </xsl:when>
  <xsl:when test="//Status/ERROR">
    <xsl:apply-templates select="//Status/ERROR"/> 
  </xsl:when>
  <xsl:otherwise>
  
    <p class="tituloPag">
      Datos actualizados
    </p>
  	<hr/>
  	<p class="tituloCamp">
  	  Los datos han sido registrados.
  	</p>
    <br/>
            
    <xsl:call-template name="boton">
 	    <xsl:with-param name="path" select="//Mantenimiento/botones/button[@label='Cerrar']"/>
 	  </xsl:call-template>
     
  </xsl:otherwise>
  </xsl:choose>
 
  </body>
  </html>
  
  </xsl:template>

</xsl:stylesheet>
