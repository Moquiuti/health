<?xml version="1.0" encoding="iso-8859-1" ?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href = "http://www.newco.dev.br/General/General.xsl" />
  <xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
  <xsl:param name="lang" select="@lang"/>  
  <xsl:template match="/">

<html>
<head>
<title>Solicitud muestras</title>
  <xsl:text disable-output-escaping="yes"><![CDATA[
    <link rel="stylesheet" href="http://www.newco.dev.br/General/Estilos.css" type="text/css">
    <link rel="stylesheet" href="http://www.newco.dev.br/General/EstilosImprimir.css" type="text/css" media="print">
    <style type="text/css">
	  textarea{ 
            font-family: verdana, arial, "ms sans serif", sans-serif; 
            font-size: 10px; 
            margin: 2px;
            line-height: 14px;
            padding-left: 1px;
            color: #000000;
          }
        </style>
        <style type="text/css" media="print">
	  textarea{ 
            font-family: verdana, arial, "ms sans serif", sans-serif; 
            font-size: 8px; 
            margin: 2px;
            line-height: 14px;
            padding-left: 1px;
            color: #000000;
          }
          
          select{ 
            font-family: verdana, arial, "ms sans serif", sans-serif; 
            font-size: 8px; 
            margin: 1px;
            line-height: 10px;
            padding-left: 1px;
          }
		 
         input{ 
           font-family: verdana, arial, "ms sans serif", sans-serif; 
           font-size: 8px; 
           margin: 1px;
           line-height: 10px;
           padding-left: 1px;
           color: #000000;
         }
        </style>
    <script language="javascript" src="http://www.newco.dev.br/General/general.js"></script>
    <script language="javascript">
      <!--

          function CerrarVentana(){
            if(window.opener && !window.opener.closed){
              var objFrameTop=new Object();   
              objFrameTop=window.opener.top;
              var FrameOpenerName=window.opener.name;
              var objFrame=new Object();
              objFrame=obtenerFrame(objFrameTop,FrameOpenerName);
              if(objFrame!=null){
                if(objFrame.ActualizarDatos){
                  objFrame.ActualizarDatos(objFrame.document.forms[0],'GUARDARACTA');
                }
                else{
                  if(objFrame.recargarPagina){
                    objFrame.recargarPagina();
                  }
                  else{
                    Refresh(objFrame.document);
                  }
                }
                
              }
              else{
                Refresh(objFrame.document);
              }  	
            }
            window.close(); 
          }

     //-->
    </script>
    ]]></xsl:text>
  </head>

<body bgcolor="#FFFFFF">
  <xsl:choose>
  <xsl:when test="//SESION_CADUCADA">
    <xsl:apply-templates select="//SESION_CADUCADA"/> 
  </xsl:when>
  <xsl:when test="//ROWSET/ROW/Sorry">
    <xsl:apply-templates select="//ROWSET/ROW/Sorry"/> 
  </xsl:when>
  
  <xsl:otherwise>
  
    <xsl:choose>
      <xsl:when test="//US_ID=Mantenimiento/SOLICITUDMUESTRAS/IDUSUARIORECEPCION and //READ_ONLY!='S' and Mantenimiento/SOLICITUDMUESTRAS/IDESTADO=27">
      
        <meta http-equiv="Refresh">
          <xsl:attribute name="content">0; URL=http://www.newco.dev.br/ProcesosCdC/CatalogoPrivado/InformeEvaluacion.xsql?IDINFORME=<xsl:value-of select="Mantenimiento/SOLICITUDMUESTRAS/IDINFORME"/>&amp;SES_ID=<xsl:value-of select="//SES_ID"/>&amp;READ_ONLY=<xsl:value-of select="//READ_ONLY"/>#</xsl:attribute>
        </meta>
      
      </xsl:when>
      <xsl:otherwise>

        <p class="tituloPag">
          Solicitud de muestras
        </p>
        <hr/>
        Los cambios han sido guardados
        <br/> 
        <br/> 
        <xsl:call-template name="boton">
          <xsl:with-param name="path" select="//Mantenimiento/botones/button[@label='Cerrar']"/>
        </xsl:call-template>
   
      </xsl:otherwise>
    </xsl:choose>
    
  </xsl:otherwise>
</xsl:choose>
  </body>
  </html>
</xsl:template>

</xsl:stylesheet>
