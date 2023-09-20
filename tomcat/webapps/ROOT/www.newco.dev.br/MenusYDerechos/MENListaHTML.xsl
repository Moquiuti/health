<?xml version="1.0" encoding="iso-8859-1" ?>
<!--
 |  This stylesheet implements multi-language at the UI level
 |  It is based on the parameter 'lang' that is 'english' by default.
 |  It can be also 'french' or 'spanish' or 'german'.
 +-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:import href = "http://www.newco.dev.br/General/General.xsl" />
  <xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
  <xsl:param name="lang" select="@lang"/>
  <xsl:template match="/">
    <html>
      <head>
	<xsl:text disable-output-escaping="yes"><![CDATA[
	 <!--style-->
      <xsl:call-template name="estiloIndip"/>
      <!--fin de style-->  	
   	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>
	<script type="text/javascript">
	<!--
	
	/*
	function MostrarPag(pag){
	   var ample, alt, esquerra, alcada;
          if (is_nav){
            ample=parseInt(window.outerWidth*80/100)-50;
            alcada=parseInt(window.innerHeight-23)-50;
            alt=parseInt(window.parent.innerHeight+18)-parseInt(window.innerHeight)+25;
            esquerra = parseInt(window.outerWidth*18/100)+25;
            if (producto && producto.open){
              producto.close();            
            }
            producto=window.open(pag,'procesoVenta','toolbar=no,menubar=no,status=no,scrollbars=yes,resizable=yes,width='+ample+',height='+alcada+',screenX='+esquerra+',screenY='+alt);
          }else{
            
            ample = parseInt(parent.frames['mainFrame'].screenWidth)-50;
            alcada = parent.frames['mainFrame'].screenHeight-50;
            esquerra = parent.frames['mainFrame'].screenLeft+25;
            alt = window.screenTop+25;
            if (producto && producto.open && !producto.closed) producto.close();
	    producto=window.open(pag,'procesoVenta','toolbar=no,menubar=no,status=no,scrollbars=yes,resizable=yes,width='+ample+',height='+alcada+',top='+alt+',left='+esquerra);
          }
        }
        
        */	  	  	
	
	
	
	
        function SituaDiv(){
          if (is_nav){
            if (is_nav5up){     
              document.getElementById('Layer3').top=window.innerHeight-70;
              document.getElementById('Layer3').visibility='visible';          
            }
            else{          
              document.layers['Layer3'].top=window.innerHeight-70;
              document.layers['Layer3'].visibility='show'; 
            }
          }         
          else{ 
            document.getElementById('Layer3').style.posBottom=10;
            document.getElementById('Layer3').visibility='visible';                             
          }
        }	             
        //-->
        </script>       
        ]]></xsl:text>
      </head>
      <body bgcolor="#A0D8D7" onLoad="SituaDiv();window.status=''">       
	<xsl:choose>
	  <xsl:when test="//LOGO_EMPRESA">
	    <div id="Layer1" style="position:absolute;left:10px;top:10px;width:120px; height:10px;z-index:1">
	      <table border="0" width="100%" cellpadding="0" cellspacing="0" align="right">
	        <tr align="center">
	          <td>
	            <img align="rigth" src="{//LOGO_EMPRESA}"/>
	          </td>
	        </tr>
	      </table>
	    </div>
	  </xsl:when>
	</xsl:choose>
	<div id="Layer2" style="z-index:2;position:absolute;left:10px;top:50px;width:120px">
        <xsl:choose>
          <xsl:when test="MENLista/ListaDerechosUsuarios/xsql-error">
            <!-- Mostrar los errores -->
            <xsl:apply-templates select="MENLista/ListaDerechosUsuarios/xsql-error"/>          
          </xsl:when>
          <xsl:otherwise>
            <xsl:apply-templates select="MENLista/ListaDerechosUsuarios/MENUSUSUARIO"/>
           
            <br/><br/>
          </xsl:otherwise>
        </xsl:choose>
        </div>
	<div id="Layer3" style="z-index:3;visibility:hide;visiblity:hidden;position:absolute;bottom:20;left:10px;width:120px;">
	  <center>      
	   <!-- <a href="#" class="menu" onClick="MostrarPag('http://www.newco.dev.br/Noticias/VerNoticias.xsql')">
	    consejos
	    </a>-->
	    <!--<a class="menus" href="mailto:medicalvm@medicalvm.com">          
	      <xsl:attribute name="onMouseOver">cambiaImagen('Emviar','http://www.newco.dev.br/images/Botones/Post_mov.gif');window.status='Enviar';return true</xsl:attribute>
	      <xsl:attribute name="onMouseOut">cambiaImagen('Enviar','http://www.newco.dev.br/images/Botones/Post.gif');window.status='';return true</xsl:attribute>
	      <img name="Enviar" alt="Enviar" border="0" src="http://www.newco.dev.br/images/Botones/Post.gif"/>
	      <br/>          
	      <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='CAB-0010' and @lang=$lang]" disable-output-escaping="yes"/>
	    </a>-->
	  </center>
	</div>         	
      </body>
    </html>
  </xsl:template> 
  
   

<!-- TEMPLATES --> <!-- TEMPLATES --> <!-- TEMPLATES --> <!-- TEMPLATES --> <!-- TEMPLATES --> 

  <xsl:template match="MENUSUSUARIO">
    <table border="0" width="100%" align="top" cellspacing="0" cellpadding="2">                  

      <xsl:for-each select="OPCIONPRINCIPAL">
      
      <tr>
        <xsl:choose>
          <!--
           | 	La opcion que esta abierta
           +-->
          <xsl:when test="OPCIONES">
	        <td valign="top" >
	          <a>
	            <xsl:attribute name="href">http://www.newco.dev.br/MenusYDerechos/MENLista.xsql</xsl:attribute>
	            <xsl:attribute name="class">menus</xsl:attribute>
	            <xsl:attribute name="onMouseOver">window.status='<xsl:value-of select="TEXTO"/>';return true;</xsl:attribute>
	            <xsl:attribute name="onMouseOut">window.status='';return true;</xsl:attribute>
	            <img src="http://www.newco.dev.br/images/triangDown.gif" border="0"/>
	          </a>
	        </td>
          </xsl:when> 
          <!--
           | 	Las opciones que no estan abiertas
           +-->
          <xsl:otherwise> 
           <td valign="top" >  
            <a>
              <xsl:attribute name="href">/<xsl:value-of select="ENLACE"/></xsl:attribute>
              <xsl:if test="TARGET">
                <xsl:attribute name="target"><xsl:value-of select="TARGET"/></xsl:attribute>
              </xsl:if>
              <xsl:attribute name="class">menus</xsl:attribute>
	      <xsl:attribute name="onMouseOver">window.status='<xsl:value-of select="TEXTO"/>';return true;</xsl:attribute>
              <xsl:attribute name="onMouseOut">window.status='';return true;</xsl:attribute>
              <img src="http://www.newco.dev.br/images/triang.gif" border="0"/>
            </a>
           </td>
          </xsl:otherwise>
        </xsl:choose>
        
        <!--
         |   
         +-->
        <td colspan="2">              	 
          <xsl:apply-templates select="TEXTO"/>
        </td>       	 
      </tr>
      
      <!--
       |  Mostramos las opciones del menú que esta abierto.
       +-->
      <xsl:apply-templates select="OPCIONES"/>

      </xsl:for-each>
        
    </table>      
  </xsl:template>
  
  <xsl:template match="OPCIONES">  
          <xsl:for-each select="OPCION">
        <tr>
          <td>&nbsp;</td>
          <td valign="top" >
          <a class="menus">
          <xsl:attribute name="href">/<xsl:value-of select="ENLACE"/></xsl:attribute>
          <xsl:attribute name="target"><xsl:value-of select="TARGET"/></xsl:attribute>
          <xsl:attribute name="onMouseOver">window.status='<xsl:value-of select="TEXTO"/>';return true</xsl:attribute>
          <xsl:attribute name="onMouseOut">window.status='';return true</xsl:attribute>
          <img src="http://www.newco.dev.br/images/triang.gif" border="0"/>
          
          </a>
          </td>
          <td><xsl:apply-templates select="TEXTO"/></td>  
        </tr>
        </xsl:for-each>
  </xsl:template>
  

  <xsl:template match="TEXTO">

	<a class="menus">
          <xsl:choose>
            <xsl:when test="../OPCIONES">
	    <xsl:attribute name="href">http://www.newco.dev.br/MenusYDerechos/MENLista.xsql</xsl:attribute>
            </xsl:when>
            <xsl:otherwise>
	    <xsl:attribute name="href">/<xsl:value-of select="../ENLACE"/></xsl:attribute>
	    </xsl:otherwise>
	  </xsl:choose>
	  
	  
	  <xsl:if test="../TARGET">
	   <xsl:attribute name="target"><xsl:value-of select="../TARGET"/></xsl:attribute>
	  </xsl:if>
	  <xsl:attribute name="onMouseOver">window.status='<xsl:value-of select="."/>';return true</xsl:attribute>
          <xsl:attribute name="onMouseOut">window.status='';return true</xsl:attribute>
	  <xsl:value-of select="."/> 
	</a>	  

  </xsl:template> 

  
  
</xsl:stylesheet>
