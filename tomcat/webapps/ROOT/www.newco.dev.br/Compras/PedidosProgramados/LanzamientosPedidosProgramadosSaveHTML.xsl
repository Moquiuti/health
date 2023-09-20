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
         
      <!--style-->
      <xsl:call-template name="estiloIndip"/>
      <!--fin de style-->  
	  
	  	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
        <script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>
        
        <xsl:text disable-output-escaping="yes"><![CDATA[
	
	<SCRIPT type="text/javascript">
	<!--
	  function CerrarVentana(){
	    ]]></xsl:text>
	    var ventana='<xsl:value-of select="/GuardarVacaciones/VENTANA"/>';
	    <xsl:text disable-output-escaping="yes"><![CDATA[
	    if(ventana=='NUEVA'){
	      
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
	    }
	    else{
        document.location.href='about:blank';
      }
    } 
   			
	-->
	</SCRIPT>
	]]></xsl:text>
 
      </head>  
        <xsl:choose>
          <xsl:when test="//xsql-error"> 
          <p class="tituloform">     
            <xsl:apply-templates select="//xsql-error"/>
          </p>
          </xsl:when>
          <xsl:otherwise>

<!-- Cuerpo de la pagina HTML si no se ha producido ningun error -->
          
<body class="gris">
 
  	<h1 class="titlePage">
    Los cambios en las fechas de entrega han sido guardados correctamente
    </h1>
    <div class="divLeft">
   
        <xsl:if test="/GuardarVacaciones/DESDEOFERTA='S'">
    		 <br /><br />
    		 <h3 align="center">Puede consultar sus Pedidos Programados en Gestión > Pedidos Programados</h3>
        </xsl:if>
     <br /><br />
   	<div class="divCenter10">
    	<div class="boton">
        <xsl:call-template name="botonNostyle">
	        <xsl:with-param name="path" select="//boton[@label='Cerrar']"/>
	      </xsl:call-template>
    	</div>
    </div>
    
    </div><!--fin de divLeft-->
</body>
  

 </xsl:otherwise>
 </xsl:choose>
 </html>
 </xsl:template>
 
 </xsl:stylesheet>