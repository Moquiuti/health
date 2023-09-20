<?xml version="1.0" encoding="iso-8859-1" ?>
<!--
	Borra PROGRAMA. Nuevo disenno 2022
	Ultima revision: ET 23ago22 15:30
 +-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:import href = "http://www.newco.dev.br/General/General.xsl" />
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="lang" select="@lang"/>  
<xsl:template match="/">

<!--	Todos los documentos HTML deben empezar con esto	-->
<xsl:text disable-output-escaping='yes'>&lt;!doctype html></xsl:text>

<html>
<head>

	<!--idioma-->
	<xsl:variable name="lang">
	<xsl:choose>
	<xsl:when test="/Analizar/LANG"><xsl:value-of select="/Analizar/LANG" /></xsl:when>
	<xsl:otherwise>spanish</xsl:otherwise>
	</xsl:choose>  
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>        
	<!--idioma fin-->
      
	<title><xsl:value-of select="document($doc)/translation/texts/item[@name='pedidos_programados']/node()"/></title>

	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->  

	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery-3.6.0.js"></script>	
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic2022_010822.js"></script>
    
	<xsl:text disable-output-escaping="yes"><![CDATA[
	
	<script type="text/javascript">
	  <!--
	   
	   function CerrarVentana(){
	   
	     ]]></xsl:text> 
	     
         <xsl:choose>
           <xsl:when test="//VENTANA='NUEVA'"> 
           
       <xsl:text disable-output-escaping="yes"><![CDATA[     

            if(window.parent.opener && !window.parent.opener.closed){
              var objFrameTop=new Object();          
              objFrameTop=window.parent.opener.top;   
              var FrameOpenerName=window.parent.opener.name;
              var objFrame=new Object();
              objFrame=obtenerFrame(objFrameTop,FrameOpenerName);
              if(objFrame!=null && objFrame.recargarPagina){
                objFrame.recargarPagina();
              }
              else{
                Refresh(objFrame.document);
              }  	
            }
            window.parent.close(); 
         
        ]]></xsl:text>
          
          </xsl:when>
          <xsl:otherwise>
          
        <xsl:text disable-output-escaping="yes"><![CDATA[
            
            document.location.href='about:blank';
            
        ]]></xsl:text>
            
          </xsl:otherwise>
        </xsl:choose>
        
        <xsl:text disable-output-escaping="yes"><![CDATA[
     }

	   
	  //-->
	</script>
        ]]></xsl:text>
      </head>
      <body class="gris">      
        <xsl:choose>
          <xsl:when test="ListaDerechosUsuarios/xsql-error">
            <xsl:apply-templates select="ListaDerechosUsuarios/xsql-error"/>          
          </xsl:when>
        <xsl:when test="PedidosProgramados/SESION_CADUCADA">
          <xsl:apply-templates select="FamiliasYProductos/SESION_CADUCADA"/> 
        </xsl:when>
        <xsl:when test="PedidosProgramados/ROWSET/ROW/Sorry">
          <xsl:apply-templates select="PedidosProgramados/ROWSET/ROW/Sorry"/> 
        </xsl:when>
        <xsl:otherwise>
        
        <!--idioma-->
        <xsl:variable name="lang">
        <xsl:choose>
            <xsl:when test="/Analizar/LANG"><xsl:value-of select="/Analizar/LANG" /></xsl:when>
            <xsl:otherwise>spanish</xsl:otherwise>
            </xsl:choose>  
        </xsl:variable>
        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>        
        <!--idioma fin-->
      
			    <h1 class="titlePage">
			      <xsl:value-of select="document($doc)/translation/texts/item[@name='pedido_programado_eliminado']/node()"/>
			    </h1>
                
                <br /><br />
              <div class="divCenter10">
              	<div class="boton">
                	<a href="javascript:CerrarVentana();">
                    	<xsl:value-of select="document($doc)/translation/texts/item[@name='cerrar']/node()"/>
                 	</a>
                </div>
              </div>
        </xsl:otherwise>
      </xsl:choose>
      </body>
    </html>
  </xsl:template>  
</xsl:stylesheet>
