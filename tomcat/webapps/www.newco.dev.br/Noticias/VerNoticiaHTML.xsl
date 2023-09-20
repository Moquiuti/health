<?xml version="1.0" encoding="iso-8859-1"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href = "http://www.newco.dev.br/General/General.xsl" />
  <xsl:import href = "http://www.newco.dev.br/Noticias/Noticias.xsl" />
  <xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
  <xsl:param name="lang" select="@lang"/>
  
  <xsl:template match="/">
    <html>
      <head>
       <!--idioma-->
         <xsl:variable name="lang">
        <xsl:choose>
            <xsl:when test="/WorkFlowPendientes/LANG"><xsl:value-of select="/WorkFlowPendientes/LANG" /></xsl:when>
            <xsl:otherwise>spanish</xsl:otherwise>
            </xsl:choose>  
        </xsl:variable>
        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>      <!--idioma fin-->

      <title> <xsl:value-of select="document($doc)/translation/texts/item[@name='noticia']/node()"/></title>
      <!--style-->
      <xsl:call-template name="estiloIndip"/>
      <!--fin de style-->  

         <script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
	 <script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>
      
	<xsl:text disable-output-escaping="yes"><![CDATA[

	<SCRIPT type="text/javascript">
	
	<!--
	
	
        Actualitza_Cookie('WFStatus','Iniciar');
       

        function SituaDivs(){

              
              //alert(window.name+' '+window.outerWidth);
              //window.resizeTo(800,500);
              //window.moveTo(0,0);
              
              var anchoPantalla=window.screen.availWidth;
              var altoPantalla=window.screen.availHeight;
              //alert(anchoPantalla);
              //alert(altoPantalla);
              var anchoCabecera=Math.floor(anchoPantalla*78/100)-80;
              var altoCabecera=16;
              var altoCuerpo=window.screen.availHeight*29/100;
              
              var posVerticalCabecera=75;
              var posHorizontalCabecera=((anchoPantalla - anchoCabecera)/2)-100;

          if (is_nav){
            if (is_nav5up){

            
            document.getElementById('NoticiasCabecera').style.top=posVerticalCabecera;
            document.getElementById('NoticiasCabecera').style.left=posHorizontalCabecera;
            document.getElementById('NoticiasCabecera').style.width=anchoCabecera;
	    document.getElementById('NoticiasCabecera').style.height=altoCabecera;  
            document.getElementById('NoticiasCabecera').style.overflow='hidden';     	      
	    document.getElementById('NoticiasCabecera').style.visibility='visible';     
           
           
	      document.getElementById('Noticias').style.top=posVerticalCabecera+altoCabecera;   
	      document.getElementById('Noticias').style.left=posHorizontalCabecera;       
	      document.getElementById('Noticias').style.width=anchoCabecera;
	      document.getElementById('Noticias').style.height=altoCuerpo;
	      document.getElementById('Noticias').style.overflow='auto'	      	      
	      document.getElementById('Noticias').style.visibility='visible';
            
            }
            else{ 
              document.layers['NoticiasCabecera'].top=posVerticalCabecera;
              document.layers['NoticiasCabecera'].left=posHorizontalCabecera;
	      document.layers['NoticiasCabecera'].width=anchoCabecera;
	      document.layers['NoticiasCabecera'].height=altoCabecera; 
	      document.layers['NoticiasCabecera'].overflow='hidden';     	      
	      document.layers['NoticiasCabecera'].visibility='show';     
            
            
	      document.layers['Noticias'].top=posVerticalCabecera+altoCabecera; 
	      document.layers['Noticias'].left=posHorizontalCabecera;
	      document.layers['Noticias'].width=anchoCabecera; 
	      document.layers['Noticias'].height=altoCuerpo; 
	      document.layers['Noticias'].overflow='auto'
	      document.layers['Noticias'].visibility='show';
       
            }
          }else{
              //alert('aqui en explorer');
              document.getElementById('NoticiasCabecera').style.top=posVerticalCabecera;
	      document.getElementById('NoticiasCabecera').style.left=posHorizontalCabecera;
	      document.getElementById('NoticiasCabecera').style.width=anchoCabecera;
	      document.getElementById('NoticiasCabecera').style.height=altoCabecera; 
	      document.getElementById('NoticiasCabecera').style.overflow='hidden';     	      
	      document.getElementById('NoticiasCabecera').style.visibility='visible';
	      
	      
	      document.getElementById('Noticias').style.top=posVerticalCabecera+altoCabecera;
	      document.getElementById('Noticias').style.left=posHorizontalCabecera;
	      document.getElementById('Noticias').style.width=anchoCabecera;
	      document.getElementById('Noticias').style.height=altoCuerpo; 
	      document.getElementById('Noticias').style.overflow='auto';     	      
	      document.getElementById('Noticias').style.visibility='visible';
        
          }
        }      
       
        //-->
        </SCRIPT>        
        ]]></xsl:text>
      </head>
      <body onLoad="Actualitza_Cookie('WFStatus','Terminar');SituaDivs();">
        <xsl:choose>
          <!-- Error en alguna sentencia del XSQL -->
          <xsl:when test="WorkFlowPendientes/xsql-error">
            <xsl:apply-templates select="WorkFlowPendientes/xsql-error"/>        
          </xsl:when>
          
          <xsl:otherwise>       
            <div id="NoticiasCabecera" style="overflow:hidden; z-index:2; position:absolute; visibility:hidden; visibility:hide; border-width:1; border-style:solid; border-color:#015E4B; border-bottom:0px; height:21px;"> 
              <xsl:apply-templates select="WorkFlowPendientes/NOTICIA/TIPO"/>
            </div>
            <div id="Noticias" style="overflow-x:hidden; z-index:2; position:absolute; visibility:hidden; visibility:hide; border-width:1px; border-style:solid; border-color:#015E4B; border-top:0px"> 
              <xsl:apply-templates select="WorkFlowPendientes/NOTICIA"/>
            </div>
            <table align="center" valign="top" border="0" width="100%">
              <tr>
                <td><xsl:apply-templates select="WorkFlowPendientes/button"/></td>
              </tr>
            </table>
          </xsl:otherwise>
        </xsl:choose> 
      </body>
    </html>
  </xsl:template>
         

  <xsl:template match="Sorry">
  	 <!--idioma-->
         <xsl:variable name="lang">
        <xsl:choose>
            <xsl:when test="/WorkFlowPendientes/LANG"><xsl:value-of select="/WorkFlowPendientes/LANG" /></xsl:when>
            <xsl:otherwise>spanish</xsl:otherwise>
            </xsl:choose>  
        </xsl:variable>
        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>      <!--idioma fin-->


    <p class="tituloCamp" align="center">
    	 <xsl:value-of select="document($doc)/translation/texts/item[@name='no_elementos_pendientes_en_buzon']/node()"/>
    </p>
  </xsl:template>
  
  <xsl:template match="TIPO">
    <table width="100%" align="center" border="0" cellpadding="0" cellspacing="0">  
                
      <tr bgcolor="#A0D8D7" align="center">
        <td>&nbsp;</td>
      </tr>
    </table>
  </xsl:template>
  
  
   
</xsl:stylesheet>

