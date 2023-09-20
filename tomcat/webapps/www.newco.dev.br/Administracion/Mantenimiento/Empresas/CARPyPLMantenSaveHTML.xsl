<?xml version="1.0" encoding="iso-8859-1" ?>
<!--
 |   Mantenimiento de Usuarios  
 |
 +-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href = "http://www.newco.dev.br/General/General.xsl" /> 
  <xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
  <xsl:param name="lang" select="@lang"/>
  <xsl:template match="/">  
    <html> 
      <head> 
       <!--style-->
      <xsl:call-template name="estiloIndip"/>
      <!--fin de style-->  	
   	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>
      
	<xsl:text disable-output-escaping="yes"><![CDATA[

        <SCRIPT type="text/javascript">
        <!-- 
        
        
        
          function CerrarVentana(){
  
  
            var objFrame=new Object();
            objFrame=obtenerFrame(window.opener.top,window.opener.name);
            if(objFrame!=null){
              Refresh(objFrame.document);
            }
            opener.location.reload(); 
            window.close();  	
          }

        //-->
        </SCRIPT>        
        ]]></xsl:text>	
      </head>

      <body class="gris">
	<!-- Formulario de datos -->	        
	<xsl:choose>
	  <xsl:when test="//xsql-error">
            <xsl:apply-templates select="//xsql-error"/>
          </xsl:when>   
          <xsl:when test="//SESION_CADUCADA">
            <xsl:for-each select="/Manrenimiento/SESION_CADUCADA">
              <xsl:if test="position()=last()">
                <xsl:apply-templates select="//SESION_CADUCADA"/>
              </xsl:if>
            </xsl:for-each>
          </xsl:when> 
          <xsl:when test="Mantenimiento/OK">
            
              <h1 class="titlePage">Datos actualizados - Los datos han sido registrados.</h1>
               <br /><br />
             	<div class="divCenter20">
                    <xsl:call-template name="boton">
                      <xsl:with-param name="path" select="//boton[@label='Cerrar']"/>
                    </xsl:call-template>
                </div>      
           
          </xsl:when> 
        </xsl:choose>
      </body>
    </html>
  </xsl:template>
 


</xsl:stylesheet>