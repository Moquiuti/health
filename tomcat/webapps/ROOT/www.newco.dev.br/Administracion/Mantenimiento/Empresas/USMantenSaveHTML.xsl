<?xml version="1.0" encoding="iso-8859-1" ?>
<!--
 |   Almacenar una Alta de Sugerencia
 |  
 +-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href = "http://www.newco.dev.br/General/General.xsl" />
  <xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
  <xsl:param name="lang" select="@lang"/>  
  <xsl:template match="/">
    <html>
      <head>      
        <title><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='US-430' and @lang=$lang]"/></title>
           <!--style-->
              <xsl:call-template name="estiloIndip"/>
              <!--fin de style-->  

         <script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
		 <script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>
         
	<xsl:text disable-output-escaping="yes"><![CDATA[
        <script type="text/javascript">
          <!--
            /*recargo los frames de zonaTrabajo (sin contenido y el de zonaEmpresa lo actualizo);

            */
            
            
            
            function obtenerFrame(framePadre,frameBuscado){
              var objeto=new Object();
              
              if(framePadre.name==frameBuscado){
                return framePadre;
              }
              else{
                if(framePadre.length>0){
                  for(var n=0;n<framePadre.length;n++){
                    objeto=obtenerFrame(framePadre[n],frameBuscado);
                    if(objeto!=null){
                      return objeto;
                    }
                  }
                }
              }
            }
            
            
            function ejecutarFuncionDelFrame(elFrame,parametro){
              elFrame.CambioCentroActual(parametro);
            }
            
            function RecargarFrames(cen_id){
              ejecutarFuncionDelFrame(obtenerFrame(top,'zonaEmpresa'),cen_id);
              //top.mainFrame.Trabajo.zonaEmpresa.CambioCentroActual(cen_id);
              document.location='about:blank';
            }
          //-->
        </script>
        ]]></xsl:text>	
      </head>             
          <xsl:choose>
          <xsl:when test="MantenimientoSave/xsql-error">
            <body>
              <xsl:apply-templates select="MantenimientoSave/xsql-error"/>          
            </body>
          </xsl:when>
          <xsl:when test="MantenimientoSave/Status/OK">
            <body>
              <meta http-equiv="Refresh">
                <xsl:attribute name="content">0; URL=javascript:RecargarFrames(<xsl:value-of select="MantenimientoSave/US_IDCENTRO"/>);</xsl:attribute>
              </meta>
              <!--<xsl:apply-templates select="MantenimientoSave/Status"/>-->
            </body>
          </xsl:when> 
          <xsl:when test="MantenimientoSave/Status/DATAERROR">
            <body>
              <xsl:apply-templates select="MantenimientoSave/Status"/>
            </body>
          </xsl:when>
          </xsl:choose> 
    </html>
  </xsl:template>
</xsl:stylesheet>
